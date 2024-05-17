Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D84C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 08:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E970388489;
	Fri, 17 May 2024 10:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="ggj54n+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611108848A; Fri, 17 May 2024 10:47:29 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE27D8811D
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infinera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joakim.Tjernlund@infinera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkRYBv4QYt/lP1dF7Q322poJuunXf2N1ofDzfpIYBp+lwzHP3pHElh+IHZS1CNsHrAnHXYEY3p7VWFSh2SVtpr2M35GqL6/TCXA1GkCxIjLyAejzbSPQ/IUfSiOTdBPu/IQDeuago+Tcvyi+VwEcH4r61VM+VmbFGUnnuadiKOKaxcs00GqiICUob1e1H1Wc6RRQTTUz6kcCTuNTL6FAVzKzzkYLFjP2vrM+Rqo2OxMBa0nTELMERMWgis7ZrerQV333eUXagqsZZ6hS/9bKkerDZ7+6dW5vx1gH3usFvKyWW2jYTPOvILf8UNbYzXF7sy7o0WjV4mOd9YfJTudZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR5/lNqeyCybQYJzXZWrLO8R+GH5bfoD6BPPOVKEMH4=;
 b=WFhSbGZqLLuSCZK2r1gPuiw9+MsM2EBfRRVorX+XnnHe6reFHGNDYywNLS+cK2LX5IPH1x5P0cooGwmcK3D60oCpy/9CNV7HN6FEQKQ/MgPC5wQyt3kduTDL1YRX8wVtTiKeJdKMfROdwLO1Gw7nb+oScKfJAh9/bR+1HhjttKWEtl86xKXJ+IBOhr1pCDkp3Og873kTPwdm6foSV2fy8WEkrmW+0DY6xdLzsf1RP8G9CpF//e+ZFyWvIjcNG25MvhHSLSa+WWD1vtGQS1HGlAmxHd2KD9R/rZzYy0aJV+l552j1V4wQsSLeagsmy1wHIsX5qN8g4/EaLfap4JrLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR5/lNqeyCybQYJzXZWrLO8R+GH5bfoD6BPPOVKEMH4=;
 b=ggj54n+qaCqKQX98Sjk19wf5HqKVnFHkhgNUNyZfjEHLhqCpla6HW5U3ifujPhV2Nqz/Qkg8YeQI+4yUi7MbODcKC/lemGZAXwezbCmg1Y31GMt/rv9MKlwBVia5/+48U+iWk9cjos8o8bor5wOLumZYrN4D9Yh7Y9sdL8G62tI38eSafEEycgGKTJeiu8BVyUTjPHM5dxphIbWi00JZ3pXAtxYNoU11zF9m1wqkg5PIC8ymOkUlHsrKzMtHRLpPsrCIjyRv4eLQjgUiFdg/HPPNBeJvQb9W0f9iWBP4PMvGg8SV0MSbU565h5kLmmRChgsXbali5eMfobYcNLnNRw==
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.27; Fri, 17 May 2024 08:47:24 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::9c) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Fri, 17 May 2024 08:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com; 
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 08:47:24 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 01:47:23 -0700
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 17 May 2024 01:47:23 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by
 sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697); 
 Fri, 17 May 2024 01:47:23 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com
 [10.210.73.37])
 by se-metroit-prd1.infinera.com (Postfix) with ESMTP id E685BF4058D
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 10:47:22 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
 id DF23A40118CE; Fri, 17 May 2024 10:47:22 +0200 (CEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: "u-boot @ lists . denx . de" <u-boot@lists.denx.de>
CC: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample
Date: Fri, 17 May 2024 10:46:53 +0200
Message-ID: <20240517084719.781068-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 May 2024 08:47:23.0925 (UTC)
 FILETIME=[D6614450:01DAA836]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f6c666-5818-454c-65ad-08dc764df937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DB8OiD9nOVdbkQqOY6uM74m8gPDooxFx38KhJRC3udO7QzGG+hzI57SFHMve?=
 =?us-ascii?Q?rzW35dkun6t1BS5RBrh+0rY6d7pR1GdBzamw5kLxmmJPRtPQ8Au4iNlHwQ5j?=
 =?us-ascii?Q?I2jSS7lYp2tWPfiRRpqnkyT/GISnetqIGyB2Jvizx7NlQj/Ke7jTi3fFdMCH?=
 =?us-ascii?Q?LRa/dl23Dnjn3gVptEEPlp9miB9s76PSwQ22YHeimT6U4LSGIuGSvWEhjhoF?=
 =?us-ascii?Q?/l2AtUUE25g19HtZvmC/szFeqTrhVAcTbbuy3dZfOxjRDVOWM8ukMYWSUEZV?=
 =?us-ascii?Q?UgoKKDCHRDkXw8rL4ywphTgmHiWAAlGm8tzz9C8xwDGieJtgEqCmoVi1nPZA?=
 =?us-ascii?Q?2FCUdpCBPpu5O5mFYrbkI99S4uhbtxxb4Zok40hKq65QuM4/DfSdAr0RBQnT?=
 =?us-ascii?Q?ZSfOsWDo6qJfu9U2wc5uYMeBdM0zN1/M8E/b/afs7D3zpdnfMoY0jKimEeSJ?=
 =?us-ascii?Q?9euWtyoIoOTrhthvbYjVoj0DGRhpvmVidg2E3TiU9ju5WOdAseQtiRNJpFkt?=
 =?us-ascii?Q?fs19S2ZbpQe9yBv1XtZs3hb7SoEexOfOGNTEJz3uDdXWocn7CNtO6ZZ+IaEu?=
 =?us-ascii?Q?9BVEBpaH3xmBN2dAf1LpdzQ5HkZvlWgy9HQwpMvMsVwTQskAnuN5DKbG+cEJ?=
 =?us-ascii?Q?sM5+xgFb74J9DzXCx6yt+wbAxcVnNI3ZWkfXMmoz84JVeA0651bNJqMCcAjY?=
 =?us-ascii?Q?uoT+31i+TSkDdZB0mX7yar3QzU/IyWVlS1k+I/flWqcw4kU2zJvIAlSfk1t5?=
 =?us-ascii?Q?MuYQgPK7aBf65iLENxHB9Yxc66Cyr5J7L5Zwz7HootNZwBdFBehtUgOtAEAO?=
 =?us-ascii?Q?gjxMj3uxN96OX/dlm6A6jOoSiCEx1FFc+EfeH8r/zhl8/woCuVmVG9n0b/dK?=
 =?us-ascii?Q?uYQ3gGBe4i/JKvIl5Ou0IGPGjJr3DtqVfg1VZlvJ6/gBCzczap4AVhVYXptI?=
 =?us-ascii?Q?a+0MESHZGlpNWzeDI3CMazcEbX+vaxw8bPihosem42lJxp4rD1jHpP3nqs8j?=
 =?us-ascii?Q?30AW+Ap8TgfOxhaqycp2eUWMjvnQ2lCTHcbjlClMMNiPyL58koCi5rzUK8xi?=
 =?us-ascii?Q?F7riwb4B8sXY6jGlnR8mWiPwXk1vdtJdKw9oVqUmn8DdazCjYJmRWz2b7am7?=
 =?us-ascii?Q?3yuJhq76+wp9ZzHdZM5M9dcP8OJHS+g8zvIbOKamnKF/I9m9VCfbmLg6Gk80?=
 =?us-ascii?Q?jTyPpEJnOlXgTQdtrwcvHDqIiK/qrw1byxHn0jlKaO+VVEzPgyJ6T8w5B2KO?=
 =?us-ascii?Q?1d20TcVuQ4Iq+EfMw9lYzNX6YzyL7q0EH2WGgeAM7Cg9hTzh5CrpUsdmfv7S?=
 =?us-ascii?Q?P5r9vsEk0MSCZhbmCRawheYbxArI/l0GUhBRUTuHSsPzmmATnEjdmChCvU8m?=
 =?us-ascii?Q?FXFFPH0=3D?=
X-Forefront-Antispam-Report: CIP:8.4.225.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:owa.infinera.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 08:47:24.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f6c666-5818-454c-65ad-08dc764df937
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77; Ip=[8.4.225.30];
 Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
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

LSB in debug_28 register is cleared here so
previous setting by errata A009942 is lost.
Save and restore LSB in debug_28

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 drivers/ddr/fsl/fsl_ddr_gen4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ddr/fsl/fsl_ddr_gen4.c b/drivers/ddr/fsl/fsl_ddr_gen4.c
index 31c58d9a8e..1f8ff87a8b 100644
--- a/drivers/ddr/fsl/fsl_ddr_gen4.c
+++ b/drivers/ddr/fsl/fsl_ddr_gen4.c
@@ -477,6 +477,8 @@ step2:
 #ifdef CONFIG_SYS_FSL_ERRATUM_A009942
 	ddr_freq = get_ddr_freq(ctrl_num) / 1000000;
 	val32 = ddr_in32(&ddr->debug[28]);
+	temp32 = val32 & 0xff;
+	debug("cpo_sample:%x\n", temp32);
 	val32 &= 0xff0fff00;
 	if (ddr_freq <= 1333)
 		val32 |= 0x0080006a;
@@ -487,6 +489,8 @@ step2:
 	else if (ddr_freq <= 2133)
 		val32 |= 0x0060007b;
 
+	if (temp32)
+		val32 = (val32 & ~0xff) | temp32;
 	ddr_out32(&ddr->debug[28], val32);
 	debug("Applied errata CONFIG_SYS_FSL_ERRATUM_A009942\n");
 #endif
-- 
2.43.2

