Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23DDC531D0
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91866607A5;
	Thu, 30 Jul 2026 06:49:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyHeDCGAL9Hk; Thu, 30 Jul 2026 06:49:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FF7160778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785394180;
	bh=vkvQANKWmpE5dECt6aEYP+LRAY1lBEHT072+y18OIbg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5omotveCHsA7FtQdFXptHfIJtXXiBKD8xzWWRmAQ2i53DQHhaHyBCXHd+YzwLm/h
	 BX2h5IiT3K3xSVCCRsC1YNVYh8m8tyAMYUgsTd9upD6UGOTOHGp3AAEln8qlConQn+
	 EMF8pRBd8mPfi/yqzH9X4KWPs2DQpvQL/QrjpkPHFuYLOJpCBnqRmpxKcNCg1W/6AI
	 OODhi75JlV/Rm374K4FFkcSMud4rgepcIhRDXxlq29kcaRAvWe/JVZ06mgR46K/vN4
	 eTajkK93Gpb/MqnDVBJB2RIPjBOQjI6g3vBg/aW6lnaY/5boEAslXKTegaW14DBzah
	 6VAgDkx+iG8DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FF7160778;
	Thu, 30 Jul 2026 06:49:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1BB1381
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93FEA6073C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tm0gBZ6OIPzO for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:49:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9DC4160778
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DC4160778
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DC4160778
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEvU/ejafm3UZmWxBMqe6E1v48JKf2qUWR8UzAT4BSBCfCyhoq9lijtOnxL0SKugn87rfNifqu8ud/m6BcCCzIWLM+AdW0rWJCqgpmxsmcGMWTD4Sy5ihc6Lp2Lknip/FWLU6e6JT4rWzeLIBtqjVwrPMJFONDHIYBplEW5FyDhIFztMeu9bVi1tL+v5riObuSnnBxlk58APTLlieNMrqMwV3Lmah6xQZ+8rdoQQrdel0xTIWgZT0HIhbRDvp78fBIkvAYjb6zITXjh0TVY4c29Q7eFw91zpDRfGfN4YNfy398t96ts+gtK9tskb0C2Hd70A88ArEdZ4PK/48jsN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkvQANKWmpE5dECt6aEYP+LRAY1lBEHT072+y18OIbg=;
 b=NYVy5xCtlC1Ajk7vAEJc8VIguTMUWiswhOik7qN1xtPirrhBXBfRvql4l7iElFPYqVVpIVGOVSlshKLDWpHbBD/FAvMVeTJQVqykDZoQWKxbE3PZOporM58MH9I2DDTKAyYLSJQmwYbx8z30ZgCUshMo+oruwr71v468KI5k2J44jB1OZM4BRBNTA3bpoNLa7WG+bL1mya5my7FkL022M1Hh5ysQOKJA/WgmNCKCBwez5Nsh5AFKidNk8GyFeuL3lZvo31vVXkrBzCcANKpUPrpiwB+9PHiUGYKkylVEG95lkw5JsXIu31n1ZTI7nkDUcQ+M8Qi/WQ/ns3FU2VTlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BN0PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:e8::6)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 06:49:31 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::ad) by BN0PR04CA0031.outlook.office365.com
 (2603:10b6:408:e8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 06:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 06:49:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:29 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 01:49:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] ufs: amd-versal2: Perform controller reset in the init
 callback
Date: Thu, 30 Jul 2026 08:49:16 +0200
Message-ID: <6b4cbfa6cc58bef86da86971e4b27726a4e510f0.1785394153.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785394153.git.michal.simek@amd.com>
References: <cover.1785394153.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3825; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=81ldT4lNX8TF/gdoLUquPeHI0q5lTsD0s1z6agtPfz4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlff7UdbjnaW3Zj7+bdhmd5bMX+LL2GHvxc7H9E9s2P
 bl0MapzSkcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMpM2H4Z/95ylX0oprl/fz
 zKxfIf/jBlOz7z/L5Ps8W77X/VvkdPUOw/+ycrvARX8a50sqK+/UvvLxvKikUPuhvwYlu7Ve7W3
 W+cIDAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 8681d32b-7151-45ed-5655-08deee06b594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: kHQAspJJt5TFeYvmo3Q2clparFAt6YauQ8ljFkDYqcBtoMIa6qA1gdt0MAvkXRXv4HBuFnLLD7HM0i96i2nSiRfVaZR8wwfNzpaTfufnXmc6TGLVZTdt+kjc1kMdRejpkP8mPmv/81ul20vZFxTQh2i3c/BvHYXJxQejr6Ofs6+EwI3/cWg1Cf8Vd0yIjzBZ5M2ntegAKcwd6s2vtUv0uM3KPzwyq+xEshkZDX2bGPvhpy0P2JtPGfBknTbWnI5NZJwJKkmFEC53TvbRZxBupdCWYKA3n7dmcl2TOqMIfGlYMqyW2ijuyxpryUULuElp1t/oQgonnPGK+59CluzWbYt32h+v7H/jPLoDoZTHai713IPftHc++bzdPDceUUVS471pAWBZ+pcG4xOIWj5JO49EVDeTngcnZW24GsiB6cJA6ZJ3tgjtaKHluLVzSJ8Avhz5sQ3Hb1ex+5Slx+mk/wXkxJ65CYp8MyMvgA4UbTrCsr9yqAuWrb7nJgY1Bfw5nM8lbPo/8gylZF7iiyME5NZA5yQfxI/laj1dmssMM6pKgBp+zShS82Fa3p3aZXnoOku+dkrbiNyyMLne4SeyicErGo7lR1DgrBLmDPObXPPCDYHqx5CI64sr3u8nF368CiizHZXl2ZGhtghxYYaS6IEdNAqGrcryXsxTFEW+z1xf90I4jDZh4HI8pJOXPrk33Ph3oFH85sqCF5z8kpysHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H3qmnN9gqGRYt4nhDpV/RI5ajUKYQdaovaXy9BgPhxKu7kmtYdEWt7ltGrAuqlOYXQ2v6Mae7BSZKmXP2G1H682E8E0ubY12ZLJJuPUl+xbDpExvWol7gWUxrwBUZ/9SfmKihXxwnp4u/i1xM5c61Ga7Rwf6IG+Vvz7BH/5EkbFSpGKxJ5PTHMgeFJpjSQ+NjfYb1S4QazEnDUhlA+jqSUk4T1EnzVfa0GoDGuuedRGuuxQB3UVLzc9RH6yOFxiCaObNaCZsbc/Tej7j4hkMk8uy/lrdY1eMsoFaUkh9bA606mFe0bGGhaD25A12PdEPVoNPiUKvJ3Sv0KBVBrn0i24Hppo+G5gGij0bpuG5tAKZwd7JenIfucNFn+sM1WySiN+Lxr/sCViXaTDJKGEY1IblokaHwz8mfHy+8S2Bm5gGTDbQyzLuvENoFX0Vbs+Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:49:31.6371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8681d32b-7151-45ed-5655-08deee06b594
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkvQANKWmpE5dECt6aEYP+LRAY1lBEHT072+y18OIbg=;
 b=2gN2wG+Xz0/SV1ghL0DtA5yUab/wsMdmvElfmcTsEFt1jF/GHS2i1AugSAve23eWYvYYx0H+3s7gsQR9qpEXi1wlBSTGiCOeJh+SX03r4bd+vuQVYyh3g1nyCWmRG+ey1NTBLGGyZvfM4nMDKrJu5Bfw964trZ4FTFJpbKOdLXs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2gN2wG+X
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Move the controller/PHY reset and SRAM-bypass sequence from
hce_enable_notify(PRE_CHANGE) into ufs_versal2_init().
The reset sequence releases the host controller from reset, and the UFS
core reads the capability and version registers right after .init() and
before ufshcd_hba_enable() (the only caller of hce_enable_notify()).
Doing the reset in .init() ensures those registers are read after the
controller is out of reset, and keeps the driver aligned with Linux.
ufs_versal2_phy_init() stays in POST_CHANGE.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/ufs/ufs-amd-versal2.c | 86 ++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index 25af9dd63cca..986147848bda 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -301,7 +301,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
 	struct clk clk;
 	unsigned long core_clk_rate = 0;
-	u32 cal;
+	u32 cal, sram_csr;
 	int ret = 0;
 
 	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
@@ -331,6 +331,41 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 		return PTR_ERR(priv->rstphy);
 	}
 
+	/* Assert RST_UFS Reset for UFS block in PMX_IOU */
+	ret = reset_assert(priv->rstc);
+	if (ret) {
+		dev_err(hba->dev, "host reset assert failed, err = %d\n", ret);
+		return ret;
+	}
+
+	/* Assert PHY reset */
+	ret = reset_assert(priv->rstphy);
+	if (ret) {
+		dev_err(hba->dev, "phy reset assert failed, err = %d\n", ret);
+		return ret;
+	}
+
+	ret = zynqmp_pm_ufs_sram_csr_read(&sram_csr);
+	if (ret)
+		return ret;
+
+	if (!priv->phy_mode) {
+		sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
+		sram_csr |= SRAM_CSR_BYPASS_MASK;
+	} else {
+		dev_err(hba->dev, "Invalid phy-mode %d.\n", priv->phy_mode);
+		return -EINVAL;
+	}
+
+	ret = zynqmp_pm_ufs_sram_csr_write(&sram_csr);
+	if (ret)
+		return ret;
+
+	/* De Assert RST_UFS Reset for UFS block in PMX_IOU */
+	ret = reset_deassert(priv->rstc);
+	if (ret)
+		dev_err(hba->dev, "host reset deassert failed, err = %d\n", ret);
+
 	ret = zynqmp_pm_ufs_cal_reg(&cal);
 	if (ret)
 		return ret;
@@ -346,57 +381,12 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
 					 enum ufs_notify_change_status status)
 {
-	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
-	u32 sram_csr;
-	int ret;
-
-	switch (status) {
-	case PRE_CHANGE:
-		/* Assert RST_UFS Reset for UFS block in PMX_IOU */
-		ret = reset_assert(priv->rstc);
-		if (ret) {
-			dev_err(hba->dev, "ufshc reset assert failed, err = %d\n", ret);
-			return ret;
-		}
-
-		/* Assert PHY reset */
-		ret = reset_assert(priv->rstphy);
-		if (ret) {
-			dev_err(hba->dev, "ufsphy reset assert failed, err = %d\n", ret);
-			return ret;
-		}
-
-		ret = zynqmp_pm_ufs_sram_csr_read(&sram_csr);
-		if (ret)
-			return ret;
-
-		if (!priv->phy_mode) {
-			sram_csr &= ~SRAM_CSR_EXT_LD_DONE_MASK;
-			sram_csr |= SRAM_CSR_BYPASS_MASK;
-		} else {
-			dev_err(hba->dev, "Invalid phy-mode %d.\n", priv->phy_mode);
-			return -EINVAL;
-		}
-
-		ret = zynqmp_pm_ufs_sram_csr_write(&sram_csr);
-		if (ret)
-			return ret;
-
-		/* De Assert RST_UFS Reset for UFS block in PMX_IOU */
-		ret = reset_deassert(priv->rstc);
-		if (ret)
-			dev_err(hba->dev, "ufshc reset deassert failed, err = %d\n", ret);
+	int ret = 0;
 
-		break;
-	case POST_CHANGE:
+	if (status == POST_CHANGE) {
 		ret = ufs_versal2_phy_init(hba);
 		if (ret)
 			dev_err(hba->dev, "Phy init failed (%d)\n", ret);
-
-		break;
-	default:
-		ret = -EINVAL;
-		break;
 	}
 
 	return ret;
-- 
2.43.0

