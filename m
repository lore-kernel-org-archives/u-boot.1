Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A7103E18F
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDEC84132;
	Wed, 18 Mar 2026 15:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UPHAwWiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CFE8415D; Wed, 18 Mar 2026 15:25:04 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB7684090
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af5sJs3rsf4sXJW1nJcANscv2e1KTGxTfoT603h0WTw6Q0quYqFC9VRORhanda68C5HLzkDRrgH6fZPtsf2bSxjlqMvaIsvlFUd4WXzyKEo64REm0+CO/sCXY2c+Csgw0e+Jf+UNcfZaMsigljPfiHlcA43TPqdq6ILvkOFTPqSfU6y1uBrQ+lQQFazKjI4lqC3QbN1DxoQcOcQ56O9xpLRaecV3iWxZJp84MGfitJbyAu28tXDAzkxDgOInZxZSExKfCQzTFX5LYPbyDvnMuFUcIOyJ2zkTxehow6a83gz+Uhrf0X/uYyKUKAaO0g3mI5fjUTHp1gY6RgSPIeRQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0Awe1gt0QbwhsjbN5OV8TQ+nMeNpBolEx9Q/mBtb8k=;
 b=glu+fIolq8TC1CB2GyFWRa3jS0KLqJ4gI9hBmG07RExpE+hdIiEhj4GM4lT46yjh9CO1M3nATz9WMBxWyoTrr+xkR9bse7aulewJeZT+V3aY8NYOe9yYDitiim6oah0FZUA0Xbi352EiPPLREq89RttDv1+kFUkdO1m4OQjIXeBKLcfuSBHNHejF5RVrxhr2mD0IbyDH59UDMDnUW5iHlGgUnYNJWE8TxjtErha6YbzgBI6bphMm08ydVg96F3jSkNuNTIVC8EXSuummE8bzXU9zRunKy8FSSYTIl+w9JwTBHYmOV95AXhB4jlG2N8p4GaymcMxFH1rzEa+Bm8s/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0Awe1gt0QbwhsjbN5OV8TQ+nMeNpBolEx9Q/mBtb8k=;
 b=UPHAwWizBkPmIz/0xHuT0PX6B35m8yUV2hNY7WApfDMHt4p2NCb5nSbOtIUvxLLSK+v+6S/G/mB/eTI8QVbJYI2Rn5AfTigFBml1rvtV9MDuecyyEnpkk2bMvwrTWHUtdKqfvi5Otg7BF25Yxl2rqJhJ968Sk+UM9oijxMeEyso=
Received: from BN9PR03CA0321.namprd03.prod.outlook.com (2603:10b6:408:112::26)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Wed, 18 Mar
 2026 14:24:57 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::f0) by BN9PR03CA0321.outlook.office365.com
 (2603:10b6:408:112::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:24:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:24:56 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:24:55 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <ilias.apalodimas@linaro.org>,
 <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: Casey Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonathan Humphreys <j-humphreys@ti.com>, Shantur
 Rathore <i@shantur.com>, Wadim Egorov <w.egorov@phytec.de>, "Ying-Chun Liu
 (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH v2] efi_loader: Allow disabling ANSI console queries via
 Kconfig
Date: Wed, 18 Mar 2026 15:24:52 +0100
Message-ID: <85854708c4d707d9db8ec84c11e1686a32198d91.1773843890.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mkQkvB4l7070dBWyioV7/KB2AJzLIUZMPCacX/5q8FI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTu2rq16UW7/eKUHS+vJXGYlPjMPbHDU86xIfIKz3fL0
 748m7PDOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAi95oZGXrLQn2bd7697s9h
 3517QnOyX555T+wdmz0bq3eHBi+1MGFk6Hu0gvW4VUzMcpuPf22b131Pn70jr7B644YWh5UO7Mu
 qmQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: a67ff7ec-3b42-4279-51de-08de84fa219f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qpP0N+gpYP7TtZYxjD0bsiIeaN7Q0h7fYkVgdQUC7isp94JMj8sFS2lgT2W0OJmI4Mo0Zpb0SsNMGh4Wtg1fI130/RDezCt0UbTgTJ3inbnJ3n0bRqLcC4Lm5GHce0YsWEfGWn6Sm5Rh46NUs96H7sxT79JsCPq7ZVHV7CHatjZcPp6+bv+EQ7jUwKPpAGQJ5Pkq+u5S8DGT5oUpdx+4fO5ufZnP/l2wYiWONBJQoEhBJF9g/4DqXgko6VtF0ro1qPb3mHHcPtsz4iKeqe2DUHvBcbyRMyfh428l5rMuUbFC4VafsTITlm4dPB20BkVGTRhfqqRPFAd+XMatbr9hgOJ/Fo6lqHWe0vcX5UStd7mTrJyvIzEP8AOmFij7tKlQcG9aww6jDEgDUMklQZmqamFQugTKVzm0YhkTwzFXnyeFXTr7AnSjlxH0G7u0mJ2sSUEWTZYUurEDV6YdIvbRgzOjuf5CSwXjqJffFqPH/vmHvnpsjRSQEU/3Z0AR44nq1E265DPP3Owy2Zm8wozDKhRXxtVFvPp7I9UPP+4yLmkDKLVgZxFRTbnbGhD/wT/JOFxsdj+xJn2S7tTg5VKeWG+LVdJbf+ACShduyOimoMRm8sZbu4AREwPv3ZwmmqfjfCzsWRxoojfx5AQ0Qa0Hw0GR9qe439DiXifFq0Skvjsoy2vJJ/U2lnM44jxZeWm/XuJx66GKNThF4vj0rDyLMnz/jWa7BKLd3rADSf+mpIZBB+/r3PcStsUVN4dAs2013T2JpUGfNBxiWsIo1YBGhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CpkO2skPArjEKMAMT4dzOHZOSiw+z5KfTLDacsenNbcEKYHfGoq/ySohn96zd0JjAZhAYcN48vCC3R1J7hJF2yHmGHvVlLKUxsvrbCgm3nmuavlFI4ZLtX+SHLYfQkGe5Yah1gZ/HT0e81KkHHEQRQBrp4D+lXkYYx5u2QVXCS1iUKUqIJbDGg+0TcJSY2wPGjuHGAC8OdoWdELubtkpXR6DtvSb4vJ9FcKS1/1eCf898/gq/iJ2KNH7UGQJioUCNsbQcvAG4qF2TKbnHvglWk1ONz3zduVHOZXrc0swVanMqS7Tka/grXOV9MZWOE052T86KpQukrlls9Hd++ecMZOKyKHnmzxtkqPg7FtNz/lL+ZSghNZr9w+aMoMsPykhf2M6BadkwSNgPf/DG7yEFxaHii3zzHObyH9yWTaq939XSGV2XrfxkCWqrqeQBgpA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:24:57.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67ff7ec-3b42-4279-51de-08de84fa219f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
introduced efi_console_set_ansi() to suppress ANSI escape sequences
during unit tests. Extend this mechanism to be configurable via a new
Kconfig option CONFIG_EFI_CONSOLE_DISABLE_ANSI.

When CONFIG_EFI_CONSOLE_DISABLE_ANSI is enabled,
efi_console_set_ansi(false) is called at the start of
efi_setup_console_size(). This prevents query_console_serial() from
sending ANSI escape sequences to the terminal, using default 25x80
dimensions instead. This is useful for platforms where the serial
console cannot handle ANSI queries.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Replace runtime 'no_ansi' env variable with compile-time
  CONFIG_EFI_CONSOLE_DISABLE_ANSI Kconfig option (Ilias, Peter)

 lib/efi_loader/Kconfig       | 11 +++++++++++
 lib/efi_loader/efi_console.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index b5f81e0ff530..bae98e07d238 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -576,6 +576,17 @@ config EFI_EBBR_2_1_CONFORMANCE
 	help
 	  Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
 
+config EFI_CONSOLE_DISABLE_ANSI
+	bool "Disable ANSI escape sequence queries for console size"
+	help
+	  Select this option to disable ANSI escape sequence queries for
+	  detecting serial console size. When enabled,
+	  efi_setup_console_size() will not send ANSI escape sequences to
+	  the terminal and will use default 25x80 dimensions instead.
+	  This is useful for platforms where the serial console cannot
+	  properly handle ANSI queries, causing boot delays or garbled
+	  output.
+
 config EFI_SCROLL_ON_CLEAR_SCREEN
 	bool "Avoid overwriting previous output on clear screen"
 	help
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 068d1a0a7b74..a798d5604a31 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -365,6 +365,9 @@ void efi_setup_console_size(void)
 	int rows = 25, cols = 80;
 	int ret = -ENODEV;
 
+	if (IS_ENABLED(CONFIG_EFI_CONSOLE_DISABLE_ANSI))
+		efi_console_set_ansi(false);
+
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ret = query_vidconsole(&rows, &cols);
 	if (ret) {
-- 
2.43.0

base-commit: 0d7293676b1e644b9b9ee2e45fb1ed10337cef31
branch: debian-sent3
