Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C260FC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 814A56064D;
	Mon, 24 Aug 2026 08:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C8c7P-gNQpRZ; Mon, 24 Aug 2026 08:36:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787560560;
	bh=O6evbQ07dQXtaQ8j0bB9DaGI+m4ibBHk9Ecy48m00Zs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aKbUqVcDzABe/7QEDuCt22LDEbqcZURAexizXJhh6XDMvc6MsZZLI7GZFDww9Eb1/
	 g/Pd9kdPHpWaZxvBIIEIzntoj3xhOlpcTADKnvhUroa6j4Iw0umYZVKMqJDMPk2nx3
	 geFuEzoUsmN3/IqGb7giPJIiNnoL6pH2uRddo2VQL3b8qCHrTtr9X71I02pAB/p0Fu
	 wIWxuG/Rp+SeO1hENoNvjyxK/55+bhp1br05EK87S93ym9QlwXn0uKRll9OulMUsoW
	 OnQSpaY4BV3TDrPuzs1Zcal2U1XADjatGFA4WyMLxwmJP2no0Ne7HqEn3T46YNa1gB
	 cDnCAl+RRsJ9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 883F460608;
	Mon, 24 Aug 2026 08:36:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C2B7336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A30980E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ExrsBv6SCZ8g for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:35:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=u2w3RZhb
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5FDD80DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyMtdAfq+UzYhU3ZhbcDvtz/+JC38/O6ESBPFGvlh7ql+37OJt0TgT29dS5/CWzw7Gb03dMpYDGG5EB8gNMRWM4DFQqXdR6YZ0rNRecC9DGl2uszpn0MXyynn+8Zloz/Ac33s0iM66UDNSaydL/eXKJpNXEyvdFMHBm7OIpyRXXtaZJsRkSRjeJ8k1BjXo2DjUafQc1v6cc88X8VpRHKKWyvqa5FVlICrWDRZO4xo1umqa84c8jp0FvtpmUh0LO9l8Zb5DESrgkAcP4PMHpymhZCaiMuOMPM2ccmBxmbaUk/LtbO0ktosh9qnrt8Wt6UUEaWNtaD7wypsJ4I6jpgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6evbQ07dQXtaQ8j0bB9DaGI+m4ibBHk9Ecy48m00Zs=;
 b=xZwKa8a92VyYeHzCliapSdMmenf62PrSnRNhbJRjN4lkdN7ojToj9o60Y9A4cgmlmxIDWkdrUIrxXdT05+whZP5ZqHVv7D7OTmzZR1KTocHIs+eTJHosb9M+gse/lLDZlr3PryNLrY/EThim50lbzUn+nslCIGNKJleKXLUBgJnHr4sN6L2XvqP8S4oCfFo5QbnrL3ELHjqFXgFPLOhdJPhtR52ZaceGpON6SeRg0QSSwdSMmYRvYuMcLdQ/E8B1f45LcXmEcOvSH03CkGTry97yT5tQm17t+RyPaimHqZCnFBy3xT133AO9PP4GdnXEUEQ/6yopNQaA/AEhhJOOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6evbQ07dQXtaQ8j0bB9DaGI+m4ibBHk9Ecy48m00Zs=;
 b=u2w3RZhb8jdFUELWUXjXjLryfa9bGYSmA1v7Jq+N79sWhrHfgEWKry5QLIg4dipsbo/M5cVz6Jxo5oJRrnp6kvUZx7OB3D4kz3FhL8v18hcqIDxGlWaujNk7jAF0DwCcd1AwLsHxt0tP53gOREbU7XmKOuudn77IPD1my5LH+nk=
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:35:54 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::55) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 08:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Mon, 24 Aug 2026 08:35:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:52 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 03:35:50 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, "Ye
 Li" <ye.li@nxp.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] pci: Enable AMD DW PCIe (MDB) controller support on
 Versal Premium Gen 2
Date: Mon, 24 Aug 2026 14:05:01 +0530
Message-ID: <9baa9ad5c513b50e09fa57991d60c06e562b8333.1787559753.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787559753.git.pranav.sanwal@amd.com>
References: <cover.1787559753.git.pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3aeada-d1c2-4135-b8d0-08df01bab5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 4G5JDqBT2rwPpOX6/jlXFMSakTltNZ/H8V6sAHwxxoDHxPiKdoZtBAfZMqJbwZy2yFPB++/JBZ0i9WCVrebLgn1FTHah7FuYUU2y+V8U1KECcEiQtoBx5Z4fEYKcPo+G+NZZgwAJkuycP0c+vuJYq3bIQNCP5xVPL2vGsRa/T6nb7/ydrGhcghHUUTk4FcF8GnPE+M2Vs8bAVqYmy0epOck/rvF3LaeCatNxwDv5uR5gb8YAPCBKxSBC3so96UJqz/PyAtcSyFs0PKfGlkQ26o1FyIh45ks4lfXR1OzYyMPXK3on+RCV9x1jLr+x/3cLGHblV9t1jg+6O/kdZ4hWqW2FqDkzk0ekvCczLgKljNdEKkzvXDXMobx+CAdDV9cZS0pn2REBiGYUR8bhnbLuaXnCPKsAGA4cO/fXIDrUpe/GZnf468teoEx4dYUPt2vp2eKwVXV/m7WtFI1V6Iu/Sqo/smEps2BSI43ejlTQqV3atXSyrirnwjOQVTejwjgwRObhWowTbrvvjaB/WMLWEve9Rm2qeRsHax0Sn0UlJ7W5SbzduIAgE4X9sLRLsaLbxvH9q4iAppccnAaRlR8lga796crk8aBLQ1ulkBH+zgr1gLsRGauCIEMAieJGqNbQS5y/mtLC+VrRlai7gkOXwW384YLODz4V69FLGbYJee6lZkyAu6qqkCygehGAX89ryW+bUFBtSDD6JtFhZWBTIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAXdMmVKbYyfv9jvyG/k2mtM1Hi1XR2Y6Z//xhmq19DqnF9cPT4ZGSHNPTqGNBa3MbfQhk58KZUm5v2rUtZsx9IVwJngnemOYeejHBMGuu1ebqhUICyM/6/eN3+7OLF2Vnfd8gHgjcrqp01srrCgIfXhnvFwGtsQF0UGN5pd+5KK6WF/OKxkFSx9evDeNIWGDawJfFqOnw9YDqtiuxSi4GAfjx6JHN8+S3jfyJ+YKr6bTguHwagpMM5dpP5aL4pRa+IbhKbRLXF3Ts/gYuSMca6oc+4r1tyScEvvN+DmjhgPQ3tfiwcBDxH/g0F1+akiw5Ak1wyX/4AYA06MtDSympj4g6JrRLcievKZewiupqFDylmsP/ozd5LO2Ew2GnzF1jFF3Fi5iFBBd3pm3Qu8SXXP9/+cagHwwQl4mZo2YZoVHSrWfhEDugf0ucGdeLxn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:35:53.4517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3aeada-d1c2-4135-b8d0-08df01bab5c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

PCIE_DW_AMD currently only targets ARCH_VERSAL2. Versal Premium Gen 2's
PCIe root complex is built around the same DesignWare/MDB core, so
extend the Kconfig dependency to ARCH_VERSAL and update the help text
to reflect that.

Add "amd,versal2-cpm6-host" to pcie_dw_amd.c's compatible list
alongside "amd,versal2-mdb-host" so the driver binds to Versal Premium
Gen 2's PCIe devicetree node.

versal_mem_map[] in arch/arm/mach-versal/cpu.c already maps the
0x600000000 region unconditionally as normal memory, covering the
controller's DBI/ECAM window, so no mem-map changes are needed here.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 drivers/pci/Kconfig       | 4 ++--
 drivers/pci/pcie_dw_amd.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2b2ccdf4745..0a6af36e361 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -459,14 +459,14 @@ config PCIE_STARFIVE_JH7110
 
 config PCIE_DW_AMD
 	bool "AMD Versal2 DW PCIe host controller"
-	depends on ARCH_VERSAL2
+	depends on ARCH_VERSAL2 || ARCH_VERSAL
 	depends on DM_GPIO
 	select PCIE_DW_COMMON
 	select SYS_PCI_64BIT
 	help
 	  Say Y here to enable support for the AMD Versal Gen 2 PCIe
 	  host controller. This is a DesignWare-based PCIe controller
-	  used in AMD Versal Gen 2 SoCs.
+	  used in AMD Versal Gen 2 and premium gen 2 SoCs.
 
 config PCIE_DW_IMX
 	bool "i.MX DW PCIe controller support"
diff --git a/drivers/pci/pcie_dw_amd.c b/drivers/pci/pcie_dw_amd.c
index 81c6d8f2817..dbc51afa9b4 100644
--- a/drivers/pci/pcie_dw_amd.c
+++ b/drivers/pci/pcie_dw_amd.c
@@ -236,6 +236,7 @@ static const struct dm_pci_ops amd_dw_pcie_ops = {
 
 static const struct udevice_id amd_dw_pcie_ids[] = {
 	{ .compatible = "amd,versal2-mdb-host" },
+	{ .compatible = "amd,versal2-cpm6-host" },
 	{ }
 };
 
-- 
2.43.7

