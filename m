Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B9C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 04:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A534B87B41;
	Tue, 23 Jan 2024 05:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBLh3fjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA785879F3; Tue, 23 Jan 2024 05:57:34 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED1C87B41
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 05:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlUTVOEyObXVmqFA34XILeu6Js/OyjHocQGMgwDitu6AdiQdpDPaKsD6eSBrPsBWE0CTzH2f8350LBs6LlaDMbu1OvzhCJ9M7fx7EWrd+Gqg85GSjiQ1Ftv+npDLVzbZjXVRa53fg/xuE4diaiOskVevO7trNRn7Hg+L6E1BpG35pQxevD43SwZNgmOpphXwB69rEAATdGG33CuxceQphZpUu3Nmy4r8SyTA4uo5Y+hTOKay7rvfXTZ9Un7vda/HBtkZw899swfmO+wxYk+MGeeqrwl0B+YbcZ4pwZQpu6WXcnuz7TE/e1QFHS9nd/fEPtasebBTGuuDV9MsmaJkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoOi4uUFsWfrYzkK0lpMC6FiSC5flXY7KxQ+7nIRpXk=;
 b=J/9vKty5xGeRgyY7iiJi9cc+PhQ6SH7ss3wnSWLw4ZAG+yT3OzNJozex7wZbEMYdJXy7OszUnGa3KuZObGT7ohldO0+0rUcymGtim0MjWz/sQKF6d1Cuhf1TcFuB/BQwluOzyQu5anunfrhNQEeyvsNcs0csMp13USU7sKb615/kTtMHvHAC+8o/aLazB4CmoIFLeMZclR0K0fV9mpJcEEe0SFaDBbKkCCIICHrLhbdpSON5qOUZtz8xU4zgsxHeronarUBa8Cxo826iE/YwdxzVI07nwGWC2E+SODbzDVyf1+G0IlXiyLHpD2jycHn2g1lArTVsX+xVLbJUSeYC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoOi4uUFsWfrYzkK0lpMC6FiSC5flXY7KxQ+7nIRpXk=;
 b=LBLh3fjNWT8gS6xpXPhQQgO3ck5ksUD4V/GODXo3Op8ZIY5d7nZoFPqpafTOubWcJZ40gT9lgJOuc67p9kxlcetErJ0kqQOQMmuNGMsRT09j00jcP7U7Hkv3R/zLOHHPeqlq9BBtiDZ7+RC6/URlKebXtnxMfM/0KHU9z4stwLQ=
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 04:57:25 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::5c) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Tue, 23 Jan 2024 04:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 04:57:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 22:57:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 22:57:23 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 22 Jan 2024 22:57:22 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] soc: zynqmp: Add the IDcode for dr_SE and eg_SE variants
Date: Tue, 23 Jan 2024 10:27:15 +0530
Message-ID: <20240123045715.893652-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d50554-7462-4d36-7a3e-08dc1bcfca87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPE2mctKgbt1xwmFbbmSJj7dhx4heoTlWAca/gT5xE6ya1Yy1xdTrCAoDhNOMA75tJ2RncoAderz8dydBxS2yc5dAyrrDD6euCJ4VXBKO54F7Yq7TtZlX3JQlDvtscM3lsw0hfZpdjwkNoEfwWOhPjAJDhWGLZ8w5ItQNR3PGcXHxLXYO0vOgQCrbdG6r85Zo+14sMlJLlBbGT42tEikBZUF07tw3dKmJVi1BeMABZpchigSroAWC7eSElPlhDA4s1piOWuD6LeUjhxgG+FpUhHkk8dyKPl6N6m75PBRpbVbxf0AVMIPvmt41J4vz9XHxWjiwLvl+65G1/bHZuHQQQbzSqRJMqB5qwYtIYEcXLDg2ZI8FNomaodQRGb2mZrIQxVs9NG7LyTKWhk/2rJOD3CNkzXQ8WM/u+ci7KBWv8aqGYGga88TSsl2JyRUB4eAcH7GxFn3w9YosaoyhSzL9BQ/colmDyyb/XID/QiAQtsnfZJoTha/yaUNXWf0ZUIW6J+X4cUzbLTHh5IK2w4PnFip1gWjHL4tjflSpOC63gV5QawT46fteWLhf26aFtkhmlybDlcwdMIWiJk2Gl/JkRt6yGmPWQybXMZvL8Be0c9Jlb3q2tdk/AAckckYTuzO9qTYqrQ5qmBNzh65zTuUXZmWboAaklTgmda/2AkmnQ83KahLIA3MaWeVhqjOealD4Prg7rfxvtSke0iwqSGCZXe8C2933aXr8Ne6+OHBrs8f90osrFHP0bLTqQNxG9i+VEt8T4WhiWMmNkFvm4L6RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(40470700004)(36840700001)(6666004)(336012)(2616005)(26005)(1076003)(107886003)(426003)(36860700001)(5660300002)(83380400001)(47076005)(478600001)(2906002)(41300700001)(54906003)(4326008)(70206006)(6916009)(70586007)(316002)(8676002)(8936002)(356005)(86362001)(36756003)(81166007)(82740400003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:57:24.8261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d50554-7462-4d36-7a3e-08dc1bcfca87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

ID code is added for zu67dr_SE, zu11eg_SE, zu19eg_SE and zu47dr_SE
variants. SE is the select edition of restricted devices with the
capabilities.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/soc/soc_xilinx_zynqmp.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index d9a5944965..786825d920 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -35,13 +35,15 @@ static const char zynqmp_family[] = "ZynqMP";
 #define IDCODE2_PL_INIT_SHIFT	9
 #define IDCODE2_PL_INIT_MASK	BIT(IDCODE2_PL_INIT_SHIFT)
 
-#define ZYNQMP_VERSION_SIZE	7
+#define ZYNQMP_VERSION_SIZE	10
 
 enum {
 	ZYNQMP_VARIANT_EG = BIT(0),
 	ZYNQMP_VARIANT_EV = BIT(1),
 	ZYNQMP_VARIANT_CG = BIT(2),
 	ZYNQMP_VARIANT_DR = BIT(3),
+	ZYNQMP_VARIANT_DR_SE = BIT(4),
+	ZYNQMP_VARIANT_EG_SE = BIT(5),
 };
 
 struct zynqmp_device {
@@ -105,6 +107,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 11,
 		.variants = ZYNQMP_VARIANT_EG,
 	},
+	{
+		.id = 0x04741093,
+		.device = 11,
+		.variants = ZYNQMP_VARIANT_EG_SE,
+	},
 	{
 		.id = 0x04750093,
 		.device = 15,
@@ -120,6 +127,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 19,
 		.variants = ZYNQMP_VARIANT_EG,
 	},
+	{
+		.id = 0x0475C093,
+		.device = 19,
+		.variants = ZYNQMP_VARIANT_EG_SE,
+	},
 	{
 		.id = 0x047E1093,
 		.device = 21,
@@ -170,6 +182,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 47,
 		.variants = ZYNQMP_VARIANT_DR,
 	},
+	{
+		.id = 0x047FA093,
+		.device = 47,
+		.variants = ZYNQMP_VARIANT_DR_SE,
+	},
 	{
 		.id = 0x047FB093,
 		.device = 48,
@@ -185,6 +202,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 67,
 		.variants = ZYNQMP_VARIANT_DR,
 	},
+	{
+		.id = 0x046d7093,
+		.device = 67,
+		.variants = ZYNQMP_VARIANT_DR_SE,
+	},
 	{
 		.id = 0x04712093,
 		.device = 24,
@@ -271,8 +293,12 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
 			"cg" : "eg", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_EG) {
 		strlcat(priv->machine, "eg", sizeof(priv->machine));
+	} else if (device->variants & ZYNQMP_VARIANT_EG_SE) {
+		strlcat(priv->machine, "eg_SE", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_DR) {
 		strlcat(priv->machine, "dr", sizeof(priv->machine));
+	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
+		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
 	}
 
 	return 0;
-- 
2.25.1

