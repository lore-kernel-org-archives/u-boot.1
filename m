Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA7EC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4611B80137;
	Thu, 23 Jan 2025 02:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104CE807B4; Thu, 23 Jan 2025 02:01:34 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20715.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33610805C5
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DifLDYyGwRwFe4h2fjicZece5CjmcctjfPem8pfPOdq80uaYaaDO06S64c2QpNwz3KMP0IB8hU1NifxKx/u5hlvcKEtccQYjAouTffLJT+3SNYsrV9p3ahWRYt+lAHEA4MO4RjTgpVvP5RWgPkgNl7iFb9AAUjjqbznni84F0Cs035YRHWeebpSpWKRzI6iSU9nX9eDQBrwJ5yLPt/be0qAA6qUyA8JHoyRxPhf6M4yyhf1XSO3XZrga36DTlDz0pk80L3Skvl2fbkQ1R81jE+OWNpm0Pp9RRzDyqE3rD2TuCA7tUIXSDB8G6fqUIRZ38KNi9WBVcsa9OguwZL5j4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5Mw14WApY7I9CNtqOEO6gW8g3QXjL/Mh44eX2IY0Og=;
 b=fLii8ke4uLe/mYyp3t+BhlO8iCh2oPbLiAO2Mvv0RatmhDhSbNEZbRxcGRvuy2WV6QDwq1MfNfC1pw9PrGYOHCMJOhDbbWSXNOODdetUx1ouY00UbbUhXsWZ6s5yvHAaYdo7uRFCuvkg6fju/eW8vANC93iD7BHEfcoYCUlA6/T+EBgnPS0pDYWg9sQzLZoaWhj+Vtg58vTEn8AvAETpyVeak69STt9wGojjERgAa+w1D8t7cexfV8Ke1p0kYeACuRGP5c8F8ohYKEfnFPy7+rn6WZiDxrPaf+vPdcLAjJJ/qpX/jiAtPLSzvaxZreiJE/fEHw+wY7+t2us6z6mXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:26 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:26 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v6 4/8] usb: cdns: starfive: Get dr mode from wrapper device
 dts node
Date: Thu, 23 Jan 2025 09:01:08 +0800
Message-Id: <20250123010112.78924-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4137c532-bbc5-4b64-a96c-08dd3b4976a9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Lraj7UZGAkmWxf35qSqLdHXKnqt1ocxgR5btBygD79dIhKeI5FjwoPaosdt88bLEImPfB3pZbV5DDRvlmfW4UZQFEysfAJX+EX6djcFSMTxPVm2TLRWLy+w7MiaRPtBaqfMnjYzeORQBObStpmvlhQVDmBvr8VIM/hEbYaRmSeVfr6VZJ9hmVremrs645FDjqz1Eyj0bRL4HDqIOSD+p6YZywshaXCAXjFqN1Qekm2R1ItLpqHkNHEDMOQQz5bhbmG+c9e+628GxFAPNG9HWKrdAX1Xg9/g267LbxbJ8b8GwyiSOwqGn+CDkcjHFUL0r0RfwtNfLybQOqrJvBQvSqQOp6A0zqYXAF+ltdq3y8GNZQ1/Rp8k/UKLbdynOMGYM+CGUNuMQvpH6oJl24+lvXMEQg5KosHViouMbIC3wY46gsqgLy4ISGlmT1IP+dzysSaSeU8rDvhMuwfLYjSVJ+XjKkc2lpqDYHrwOwcxG4+6unfx0dRxl5OAsDlnsBq6ohc8YGojlvPypnaHywF3vv2hdz6Zj+ncezR45NOyij2CytCwtMN9cN+gF1Mhmm0m5kEZvOu1TJ1O3bf77r5Gpz/d8PtjVB64WUgCK4t9UGc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vtVlDkMfRK2Kd6TbuumrnOZg2ZLDoAwgBhF5d2R5eoefB7f8f+sXSuaJ8Ryf?=
 =?us-ascii?Q?5n96oORYlW68g1kon5y2T0n2CF/cjmkY81bTbCyhjPkneitmpghTcYrws/Xw?=
 =?us-ascii?Q?mca3AImoTKHxtw2LwSgzrRx8KsyGpnSrrmFoH6cMuit2oMxVF5ay0b5fYj70?=
 =?us-ascii?Q?qindJaArDv8d39wnQdJ7vqCv7iyqtANVhz7NpdfDP06WsGaKgTKsqZP2EDPe?=
 =?us-ascii?Q?XjYDhH28HyFYAdN3d9geUoMU6Q0PZcCwyrYn692IkySswPTKugZn6/fpRfGJ?=
 =?us-ascii?Q?p45XhWCeZtRNXSoUB71BO8PlVR2hmV0bLo9GH8r20GmsAN5VkmAbuW2xB6M6?=
 =?us-ascii?Q?Ni2HAuOiSfb6TdpscmoByztHTl8qVqdbrS3IZDHv8tGPWMnS5v5CJY3CCchT?=
 =?us-ascii?Q?iAC8EBBpjcdNu0pbxwA5p+q6ZVTnZQvbN/akWQLs3fx+fsRXSS3/Pduv3VU6?=
 =?us-ascii?Q?I1njD/jL79vkCcK4b0mfqOa935d6wsMv4/sHoZ4dalf6j0xOrByJR7iEfIkH?=
 =?us-ascii?Q?YgNr7p6qyrI/UxmRQu7rAz4FtL8jQoEkfxYEsSXIS8D/Ui6eHKe4BnjDyouF?=
 =?us-ascii?Q?SwSMs0rRfuEd/PQdN+gPuV5Ki2XufqFCgIENX0EfD6UB1SkoKB4oBaB63Zbl?=
 =?us-ascii?Q?ptddJBHTOryBNDsUkb2LkhiTNcWSIJyIZx5OCLtMsV3HyegkPvs8AIents/J?=
 =?us-ascii?Q?FQOegCVjp5UcoVyOOZpI7EPGz818f8Aj3FeOcKRnJNshJPpeZKluTMWt+/Wq?=
 =?us-ascii?Q?hOFo9Y7awOR306j7uqU//wyFzxK/C1nmLHrvO0F1u64XSkoJITdzdBuHPve5?=
 =?us-ascii?Q?lZC9KpVxQWv1qW6TAhDnUOXarFwQ93f3spW7Lg7nq07CIh4erp9poVPwFZ6P?=
 =?us-ascii?Q?aEJOBrrah9ibGOgxsf/qgPc5B95m+Zk2L35jgoMynetFh/pY5GlZLeuMXcpQ?=
 =?us-ascii?Q?9WDPgP7pZaUqLuU+tCS0Zra5DYJDQPk3QimHshwsjqUdtk0ONZgki4xLub6e?=
 =?us-ascii?Q?H9jZDbFJ158dy4awn+d+9CExmYL0HYHbh31LF8CXBa5B0o/rawDq+Apf+ny4?=
 =?us-ascii?Q?4PYmgtv95K56/bPkkSBj4o87kCo7DzuJX0W4kKt/ClGa08SqFyyX+/S+KipG?=
 =?us-ascii?Q?B0LhLooVn2wHwUv5Jj2k9c1g21x5WRvv/IG1f3wXjaoCGU3AwypfAyFOYeJy?=
 =?us-ascii?Q?MYx6CZd199kBB2paTyST1BcX0q24W/lqMVA+uh8D/AxB+8XSy46E+iD6qOFL?=
 =?us-ascii?Q?mkKd546Z25bTQNh8QoroozkvHTw2riDBCXvYKXDGfryDrFkaNEHkS18q2oGm?=
 =?us-ascii?Q?eiSedBlOnLUE3tFcCJhLRYovcIDolV2QtMmjgyCRA+KQ50zrfU/ObRf4s2/t?=
 =?us-ascii?Q?eQ53mGtluDNkW4+01Biqn38mx59LNIsHnoMOUFG+iDRxj+Q8sdRJvFhsrEYi?=
 =?us-ascii?Q?uiDg0v5a12dsGrgyqphUC9xZgeJ1b9g+hnMtjdEehO9ds8WwKj1Y3MvWIuon?=
 =?us-ascii?Q?9ujQ8u8kZnr4w4fxAM3zytCGuBF9X4GNpmvC44oAYi9AwtpzeXiN+YRFBWCX?=
 =?us-ascii?Q?3VGukJW2NfbYOgQMH1t61es+CGypI0w5hQ5YS0TLBrlU0P6BoptMH42RA0rE?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4137c532-bbc5-4b64-a96c-08dd3b4976a9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:26.7208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsFcktd6Fb+Wv4+7+AbXUuSTXDpZqh+7owqM+7r4UTpanU0G2bsnWwRrFMjYrfX7/LXx5g6VTmzUnDpKlssqDaEIxA19sWAvNABH2Xw+h/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

Cdns core driver also get dr mode from wrapper devcie dts node
to make it is same with Starfive cdns USB Linux kernel driver,
Starfive 7110 OF_UPSTREAM is enabled

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/phy/starfive/phy-jh7110-pcie.c | 2 +-
 drivers/usb/cdns3/core.c               | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/starfive/phy-jh7110-pcie.c b/drivers/phy/starfive/phy-jh7110-pcie.c
index ecb04bdedfa..a30582821d9 100644
--- a/drivers/phy/starfive/phy-jh7110-pcie.c
+++ b/drivers/phy/starfive/phy-jh7110-pcie.c
@@ -170,7 +170,7 @@ static int starfive_pcie_phy_get_syscon(struct udevice *dev)
 	int ret;
 
 	/* get corresponding syscon phandle */
-	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 0, 0,
+	ret = dev_read_phandle_with_args(dev, "starfive,sys-syscon", NULL, 1, 0,
 					 &sys_phandle);
 
 	if (ret < 0) {
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4cfd38ec245..4434dc15bec 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -410,6 +410,9 @@ int cdns3_bind(struct udevice *parent)
 	name = ofnode_get_name(node);
 	dr_mode = usb_get_dr_mode(node);
 
+	if (dr_mode == USB_DR_MODE_UNKNOWN)
+		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
+
 	switch (dr_mode) {
 #if defined(CONFIG_SPL_USB_HOST) || \
 	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
-- 
2.17.1

