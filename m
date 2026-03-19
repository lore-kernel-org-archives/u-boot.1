Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB6A107526F
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 07:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356E783CF3;
	Thu, 19 Mar 2026 08:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZuNiFw80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EAE83D71; Thu, 19 Mar 2026 08:15:37 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82E683BC7
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 08:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc8egCymq0q1pBcouRkDBoNRqTlF1XuPMzPZR7/crm1NHN2SDjHo+Mrqnw8GtG77TN70Xi98pvWCS3Me9Emm1pyxSERrF7OCGHbw2Hy3r3yxc/2KutNi/9JB4jQfEdW0ljJLKq0fMPt4VXaykmXzQG2qTPVFrUmQ+oLUAiEmmHBBJ6iPhgTS1QqJe2JnlaznkI/Ai18elqEVlB7MmZB+Cfo+GARqB6rJrm2Je24mVeEYKCkbQ9y++gb/NOl26CAKu+yoAIGoWZh68yUCnjvulZDqVibXirfmPQIKeuMke9TGhGlUe08Oy97dj5DsazuDpROuDkwggMMzxETUZZhuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hi/nEZJmlw9ZPiZUanEIKoSKqlj5+veYuOP3N9ffT4=;
 b=lo1l41HapS/WFmeg82bpcc0K20TN8kdLF5jUiOMN4SG/5hAVzC/DfkuALXh7YadEc4g7mhnLcMSnLOedLwn76W3C2j4/M3EyEAPW0n5w7qwJ83hg5O8LA+Tf/UX7elWrVXQUUQeTJoiiF+ysF7Sgo4K2+dJPSrWubJoXOLF6wyNYQi8uNALR4oFDK0HJhgrJ2+3hiyvmirY5Grq0uTw821bFUiTx5zlugcadimnInxWFSRfHwey3EgUKFhzsPuth8jERCzstr1IqPQzenFhNK0LR5Hoby9rJYKMyRWzPLzWDtHqehxoQLFpOpmIhZHlotAbNaoB3NvyBCntlB+2uKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hi/nEZJmlw9ZPiZUanEIKoSKqlj5+veYuOP3N9ffT4=;
 b=ZuNiFw801fIC8Gm3FwxZ3WQ65qKdlX4Df1zWmeNvfGJZ/w3boEnmXEDc0o/dc+gjoQkt/R5e9hJQt3BLGsQ7D7ltuurlj7AYVZzyy3J+NDvHCLMfb3NX7Uuyq0BM5r8dI38wYCcoLOk98g0bYkCBuEJf75RfULC6fx2IfmHme58=
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:15:28 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ed) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 07:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 07:15:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Mar
 2026 02:15:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 02:15:15 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 02:15:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: John Toomey <john.toomey@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shantur
 Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] efi_loader: efi_var_sf: Do not fail on blank SPI Flash
Date: Thu, 19 Mar 2026 08:15:07 +0100
Message-ID: <99ed0e792590ecfc1a3f056f234e053013ffd981.1773904505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YNZx66exQbhqz4WlelGIC3SrbrZn5OrXYqP7GLpozTg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuXlRbOFcnac5DhRuBrY3li/0VYm26jp9z/xKVwLipq
 O66NJNURykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkSjXDX5H+8Ksu7if8ywKO
 VOxWcbeYGaRzSWCdfFu80+wul1qxRob/1TOv9tho3Ln57uf040buus2Jvhn6ywquHTggHcko6zG
 HBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 8259fc9e-ccdf-4bca-fa81-08de85874c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2mz2hgmGDLN6YHlgE3QaVongb7dUxBXqhO0Gi5JyN5O6Exnb4sceADcwjVuoAz03puTBhwphBfr+sgn2K2bJqwo68t8yu+CU2Ke5bwRJ2LE5ti+dBFHgi5ZIPlgbhjB8Sr2Df1B59axRHfOFEsTcmisMDH2FvZbH0c9+3ZbaZdNJcyrIhs0nwLg1WUp1b0o32XdK1py5iTGA37/kntThwTcpyiJwSd1pe1bteR0OP2arNnXoYnRQSBAB4NRIPAll6eewPEBCyODxVZp3qbmK2LrOpiaiSd3E91Hgo2r7/gPWv3lMQ6DG/dorot0hqjT6IA1NN0DJo+wQFs278/WHPZRVJOcuT3L3JTUo7RCg5GiRS5pNA8dd4mMU5avAWEi2jj7Hmd6BCCrhj6KpgWQhq7PRlmwlA9Q6L7RMHbalel9qsb8ix0vlwChhxB8myo9UlyKVfZ2dIdcWr86P6xhZ7RU5e1BIejO6gqD/SquoNa5w/OJvr53Pdjv5QuwvouIXGUZjtDTheTrrzHtMjpf561SXbfKJ8tZBGyZDWcChcPtBQKwFCQP/S77vPSPW4cFrfOlCxHQPgZAJqGyvah8ufA7ZF+klFK3y6sTUEhxuH8phfzYIKSrzxTx4+wRQsar8CJgVsdKFyPv8GS/BzMFVbXSVoP7noVoZV1yjbZGtSdsCimmlQm2MpPc9bCTT4k21nPNVWjqX9Fvy0MC1xN78NSxHhECRomVBAGZXbPR/sY+rMyh4oL71lL1PQWTbVjyIzdYG+h3ZvRQdC9ijiJHfjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4CldG9v2u/jcVevJldJ05T7cKP9A/xrSMdWoEo6FyqkR3Puullq5BCb5cWOx79XBlvlM6EPTUeGK75CvxTw99bfZY6qjohfUCS6zSClaj+d0qVvZZAIec4rlaz3PZ8u+uGXH0xV/lX8sR/CJtyoMhF6es5/CRCDHbTf8YqGX+LC3CNCb3c1jVERHkG3oaE2x5dxUOrBu5hVHS2q9o08dMx6kQybwGpwxhpM9yLFvtIX7b3Rg41Td+KUxTUMx1ZnmAOn+za8E0IHHNwfcPjyqv8w8LkHPOpJ+hHxgArIvBrDXf3aJMS9A61tAxM4LtNVBpPwDqbrlKHj5p2MpzSVGgLA5GLvGZGG2y5rooMXT3TjLAIpOT5UI99AyzVKgSEO47sDRcdrfF2jyukEp7N91AU1oBTHpD/UEVZyLdbUUtP5nhEnWe5FtcvR+51vzu4c2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:15:28.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8259fc9e-ccdf-4bca-fa81-08de85874c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

When SPI Flash is blank (first boot or erased), efi_var_from_storage()
returns EFI_DEVICE_ERROR because efi_var_restore() fails on invalid
magic/CRC. This prevents the EFI subsystem from initializing.

Check the magic value before attempting to restore variables. If
the magic does not match EFI_VAR_FILE_MAGIC, treat it as an empty
store and return EFI_SUCCESS, matching the behavior of the file-based
efi_var_file.c which deliberately returns EFI_SUCCESS on missing or
corrupted variable files to avoid blocking the boot process.

Similarly, if the magic matches but efi_var_restore() fails (e.g.
corrupted CRC), log the error but still return EFI_SUCCESS.

Suggested-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Remove magic checking which is the part of efi_var_restore() already

 lib/efi_loader/efi_var_sf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
index 6eae8d464645..b84ec8e67dce 100644
--- a/lib/efi_loader/efi_var_sf.c
+++ b/lib/efi_loader/efi_var_sf.c
@@ -98,11 +98,8 @@ efi_status_t efi_var_from_storage(void)
 		goto error;
 	}
 
-	if (efi_var_restore(buf, false) != EFI_SUCCESS) {
+	if (efi_var_restore(buf, false) != EFI_SUCCESS)
 		log_err("No valid EFI variables in SPI Flash\n");
-		ret = EFI_DEVICE_ERROR;
-		goto error;
-	}
 
 	ret = EFI_SUCCESS;
 error:
-- 
2.43.0

base-commit: 85854708c4d707d9db8ec84c11e1686a32198d91
branch: debian-sent3
