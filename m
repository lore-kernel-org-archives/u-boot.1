Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35983FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 11:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D6D83A91;
	Thu, 30 Apr 2026 13:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zoyCLqcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5C280433; Thu, 30 Apr 2026 13:58:55 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC6083FB5
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 13:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lq91Awg4mYPAZ9BjFffHZrNC1BtqsBevezB99ZD5BHyIN0wpjgWRtQlagkR3HBm/bH8wKO+ySTKqxG+7J/ybmo5kU4FmTkki/591RBeRjyixBFPqpSAstQOa+bAFmcY8GkrHe4LQp1Q9/aOU6Y6EFXyxlmOskn3kVZeFeQEGAkBtl4Azy4/BoKZsU/H+yv8ow8eDmhTPP5UfnVnzgeAmW+tfqKdkNxWzIh3AqKTve+BOvVbghkoxAmjEPlcLDtUpAQmCBuZn74uT5D6SO5JaRm6m8Al7SnNgW3NGHtgqSvUiKRp1WuYwLo/HnVev17lB4e/sTwCB4ND6S4wuNv1V9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPUa24skwXsp3qJaWAdWgXXtYBzU7loywOe85zAhrnM=;
 b=VOwtKAvyLx2hKU1l8BvAny2w3KfjGjm2xGpLkIMiGQdh0XUcTv+26En4L7k8oN7pVSVh5WtZKeP23WTVdlVsTpj3zIfZxGXqYBkV1ENiTV5PK92QwLOAKL6oAqCW7/dvys7iGhdsCiopl3HsW8UvcsBFq9B8YTTbJK7lRo42cnPyTi9EsQYHG6+ePEIaPlnrcRzd1hvCDErF+0fS1XSlx07uMwV9zKLN/QdFjDt9T3b4zRhVOddvfBe7mvZRFZMs7ivf19cpO/tsziTrMREeh0UOlMZ3S+OHGN/AVGDNPD1mbsr6Dz1E3BfQTWkxqA9jb2BhOPz+cHLkfTP0vBa4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPUa24skwXsp3qJaWAdWgXXtYBzU7loywOe85zAhrnM=;
 b=zoyCLqcPkOEWJqCwoT4N56x7zFbuFSpT29qg8ihaqcyO2AfhvXCqmIzOo3m3s/iLQI9cpzeWpevGbjx9KB0VtLijw/E0FLhjLZ0ompFaLWoV246/FUpCLvtV+66mAU3TJuM++SFf/OtMTrEv+HciUGH6f99IVYPaUvgkSUl6PTc=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:58:49 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::8e) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 11:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 11:58:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 06:58:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:58:39 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 06:58:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] riscv: Exclude ACLINT for TARGET_XILINX_MBV
Date: Thu, 30 Apr 2026 13:58:28 +0200
Message-ID: <75160eb268d7a445e8483b357f7814bef30b12d4.1777550306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6mPBMWM9L8C/d4tdELYEW0GgG9EwfbXw0AoSXmWmcy0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+dn7+u+4M+0m32+qsHF7ntzY8md1ac+G0x70PbmcNn
 zc++MNwr6OUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmcvsoI8P6JalPIzwPSqxt
 icmM8HO6ubv+If/qvlJrBbPOhG7+tBWMDKeeWgv8XhuXpBSaFpzPJdPnNE1ut8fU+oeqRRU+6rK
 rWQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 2746f9f5-b77f-4bdb-f482-08dea6afd70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: B0d+VhJ8J+ZoW5CpKMoep/XgmcHRkYouslAWKFkq90DjcMdUJHuW4CjmTemd+dJfeZXam89IaPGRofP4mIJF+Oy2dBMdpawFL1WxzpgdAwbObSN0cmNNC6v7SIPRCppomZ+jlwh8CXIwiEAi5mbfJawpFEIr7koa4u4hYwO4lsPxRHj0FD5iQQxkXQnCbt3GVf1zIvrXYC+kVwbtikm9AKYGLO4M8O9fWVBEmhjYXEN4Fj8KKCEosJs63hYKCGPPcUBaR4sSpGXrjkI/uapiR9tXF83KWqfF1dCip1I1ufVkfpE4gf73vkGNvLFghCB+ngBW8yDKaUAo5EVH/35Th3QKbPKOCuUUIBP0IkC6UflUtQClvaOUtTw7PeCwcNT4Bpym7Es6Nscv1mER8JDV5R+/DviMciBf2hIM92YT0F7yUBx5K+FSoG2RrO15av3F6U5WdcxMnWBGhOBDtvm6TTOrt2gJ+tv9/j8FUTMaQLds4eWOgQ4ElAR0ubKKSWb0XivbL/krGp6oJWJ7R3sSy1Jfky5ra7zD9DKlbhtXgUO+hnp/rzI5A6eRewhdHZ2H0je6VUvvRYhgs8uDSX1Dr1DhKVvbpiJBC7tTa2tZ4PlH/MUr3OQDikivcR15vLdJJCAZrR/2Yvips/VjS0P2Azdqq8Yi5WwQusxWdMEXkF60OLaO53QGswWEismVs+WrkAEHx1Z8l/P1zspc9L2/d3EYDg+SPHvP08KDb42/byFOqiEIlM12bsvXFTjtUzBn9Fzwtpj+YgebNJohjNE0eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cSdC2vyfUy/UJ1EGml/rvMuTix6QaKqhegOh4wSj1jixjm23O0r5hr/BqmhTSwFfBIF1j079rX5GFCClj3zikzil4fuClPG2RknFjaTFJ2vWT/H9RqXwAxvN16lP1N6pZ+LEdL1p5UAJ85rkkLbewfSTMaZbz68gc6W8JYcVIPxL1xkcb0kElu9jfD1xwWmEqUVr9IOC3e0sKxYCQ+PJ7OkY2uDGS4jeAzoUitgUoB3ac9W1u9s0lDLD5nCHErpoBvRtjBYllj+OHwwmirnBitVz4WxP240YRhMqTMLD8WWZxhARLZz7TCX+QLMkNlVyScODxlHWgAgGTCs0WhksfymGsHvZtwsJV7Ac1NOs0mgnOAlckvFXkVvFnsf75P+EFfRB32+bnb84HeVJvSMqNsJArEphO5+HGkNwV+dF5yzvZGYA55biNFq1NIfm6pIN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:58:49.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2746f9f5-b77f-4bdb-f482-08dea6afd70b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
Core Local Interruptor) hardware block. The timer functionality is
provided through a different mechanism.

Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
for TARGET_XILINX_MBV while keeping the default behavior for other
generic RISC-V targets that do have ACLINT hardware.

   spl/u-boot-spl: all -1382 data -360 rodata -200 text -822

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/cpu/generic/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/generic/Kconfig b/arch/riscv/cpu/generic/Kconfig
index 2baba2299238..8d53c69ba38c 100644
--- a/arch/riscv/cpu/generic/Kconfig
+++ b/arch/riscv/cpu/generic/Kconfig
@@ -10,8 +10,8 @@ config GENERIC_RISCV
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply RISCV_ACLINT if RISCV_MMODE
-	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply RISCV_ACLINT if RISCV_MMODE && !TARGET_XILINX_MBV
+	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE && !TARGET_XILINX_MBV
 	imply CMD_CPU
 	imply SPL_CPU
 	imply SPL_OPENSBI
-- 
2.43.0

base-commit: 0d875f98e9d81b68265ea26c379dae8ce5b1f5a9
