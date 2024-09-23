Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DEDCF9C73
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 02:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784978890D;
	Tue, 24 Sep 2024 04:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="srxtco71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6FF88001; Mon, 23 Sep 2024 10:25:53 +0200 (CEST)
Received: from outbound-ip24a.ess.barracuda.com
 (outbound-ip24a.ess.barracuda.com [209.222.82.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819F488CBF
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 10:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Arturo.Buzarra@digi.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by
 mx-outbound13-149.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 23 Sep 2024 08:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANrmEPEY2gXqGcmEZ1hIhs2BSSbs96s+9pkERc68ox58L9Us8+igntWPe21Mt/TD2GAtVs91Z2sPhJNsAwTlEbUfqZF50aBOberInPqo9Jf+vmsusagVuIMT3cdkb0p2AZpxZDrNyXpBWacJJXflCCR4Uu+DZuWlH2y0aBljLk7LK146xmb3ON0xkLDmToiLEPAVHDXtjoO32zb1qVArC8LuwYc42mytuTe2E2pWxxF85obmctWJpqHD5NpL16k94UgyehDPWQ2RowCeICOn0kmVEhxLfWg1FBTHtpTcO+pM+kw1XGT8cm6W/P266H3MJ/pFDyL0Dzb/dTyHNAhhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E+hImf12Z8Icykx0AWoM2OwxkJemg7urKsU47ZW/Wc=;
 b=Uwz81sdbUjr+OwO2g6lmU86mQs4niYWjKttEQm2zJybEAYQAUriJiQd1dKouGj4I+pVSRrrfrvZwfqPFIK/uBE0OLmp1IZDuUrsdFYnqG6HtAJEVF/hQIoU/17VxCfe3s5SXO52VOGVeweRk9TP6jqgIBJtjv4FeH9LJR59HvQS/gyryI3bIQ3mhbkOCdtB7BntgArWbMT/udf6VmVEoZgIvuJhsLYMDt2xJMKH1vWydAVzRizG2GHvZ8YrXQ3IpKmhMPELnv7PuTOEU/KoS6Zul960qkQiFTPV3PTVGxEWyjEo6tidx+iN3MqO9SHqjqRuaeFQDg65P3tqox3RjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 198.51.192.30) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=digi.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=digi.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E+hImf12Z8Icykx0AWoM2OwxkJemg7urKsU47ZW/Wc=;
 b=srxtco71tk/zqdItLmHT3QHs3338YGIv+Uh8S4ujs4b7ZMqxD6EMZ9hcXxg8DqUP8mTk3TMWb8aMaUFUf5bp/laQF6YapjMjKxv0QM9B9hjBsDWVx5lmlhEDz2zHre6xMzVoeZ9XrZqMmL3dIdEWK6DVhUPh8yzEVlNgm+aar1ueszDXf9K0M9zS+T1HndY8vDz93o20ZwR/rYC4ieaCdN3aygZ7kh0qAjGQDNSdwniBnpI9UhmKOdV1ryfqrfqzuGHX9kYpLEkoMFFv0odlucQcvYKHNQb6dF5rDrvI8MyyP/ii5nCCp7ZmyM5+YhG2w8kx1ejuUp2LLIjaeh1/cQ==
Received: from SJ0PR03CA0234.namprd03.prod.outlook.com (2603:10b6:a03:39f::29)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 08:25:40 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::87) by SJ0PR03CA0234.outlook.office365.com
 (2603:10b6:a03:39f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Mon, 23 Sep 2024 08:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 198.51.192.30) smtp.mailfrom=digi.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=digi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 digi.com discourages use of 198.51.192.30 as permitted sender)
Received: from HPK-MSS-XCH19.digi.com (198.51.192.30) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 08:25:39 +0000
Received: from LOG-CLN-ABUZARRA3.digi.com (172.26.105.9) by
 HPK-MSS-XCH19.digi.com (10.10.8.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Mon, 23 Sep 2024 03:25:37 -0500
From: <arturo.buzarra@digi.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH] rtc: rv3028: add support to manage VDD regulator
Date: Mon, 23 Sep 2024 10:25:18 +0200
Message-ID: <20240923082518.29507-1-arturo.buzarra@digi.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.26.105.9]
X-ClientProxiedBy: HPK-MSS-XCH19.digi.com (10.10.8.195) To
 HPK-MSS-XCH19.digi.com (10.10.8.195)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cda916-94ea-4941-e4cd-08dcdba94e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?or5Zx5mHd0/C3oEG/yFXwGWHIABfgjmLwNCWmKWiNbYn/SLxC+L3PhNpIc9N?=
 =?us-ascii?Q?bn75OJWWKQIwG+4+9QTSpvTgv7xGGXxxbtzyBSTwlV/6N9DnQas8Df5C6R3N?=
 =?us-ascii?Q?VI+AgLn5I20EQlqDWy4PGc3BVi6Q3tfxoeo5QDZ9AQUkiZUtdydrbSZ2KPjW?=
 =?us-ascii?Q?2pPWYwDdZ8pv1ZEUzMsRyhjBDP6VXIDDI+FQNIWxTN4OQ9cnA19Kj14Ic+8o?=
 =?us-ascii?Q?4DPxOWM5nCLggitj75uq+BDt+dKTLNd0NIqtBFrFZJ0Fg/IwI/nyazxyLAwX?=
 =?us-ascii?Q?IQA6UYLwrcc4JmdMGilbfM1Td3TUL+Y6GCONmlS3vEt7dQTUmnUOYE4wkyGH?=
 =?us-ascii?Q?rCS+ePBVutb5TfqJ9cFkYmUiRi7mPZQXi5NVM/zjsZZKCCUxJhCkbhCbsOF8?=
 =?us-ascii?Q?56jrlqbS3cpZlUXMRznsBTROTQP62P3GVE2qBd6s5XthQzIMZg+46mGr2KIc?=
 =?us-ascii?Q?1+1G/CGreRlVZ6rVNJUM3ht/ec8nYkqM8Yz/jYnDw6LBfHsWj2ir5NKOPOe0?=
 =?us-ascii?Q?ZmX1jYVvuKo2MXoVpMFCH7wxgEDU3LW6n2XIh4bpRURy8rxtk2lDl+MCc1Fh?=
 =?us-ascii?Q?wou+w7xBePptvVl3SahejQwwAyDNSu8EE9T7bO8xa9NQfGd3zDSGKsYT13W2?=
 =?us-ascii?Q?Ge0t3OEV844F6HhhUyCt2aPCCHCyqLDk0U/3QcnvOjYCpt2LGM/njyOm7HWt?=
 =?us-ascii?Q?7YRr/Q03Rt476twCE+Je99haNL3+ETcplJVVqTFoN+DK252J8rfeitQcLwYQ?=
 =?us-ascii?Q?inru6mfy3XMuLmnoabMXfl7wMgYT7bbADlD90RtGOZXB1+PaWjQIedzaKuUL?=
 =?us-ascii?Q?AOjE5/L445SmqsfApDp55dz1HqnzW5N61vVJLSWMzA8ovE8NAfJK1vtdPK/s?=
 =?us-ascii?Q?gTvyqay/siLMwrrjBtZbOFp9iFdt41WqLplNGHXa3JSAKVbbOP0wjgFjkDMM?=
 =?us-ascii?Q?ak/6FiJoQtbBtN/Bd5HCpNeRdxrn2Ft4zmXjEcfFz9P4YsImAzDG8aY5xjDr?=
 =?us-ascii?Q?D+acxuuk2RHKPXGABXzBBcwNFrQkhSl9bpwFM3IWIIoaH7VmZ6SHh8MAAFHu?=
 =?us-ascii?Q?Rm74oo8QOaHCHUbVHX+XD3lo9GZScFBGv7qouaa2aAt4lubQrdJ4Cd2Ryq68?=
 =?us-ascii?Q?enGaM1AjS27g3J0g9sxMutxUzJPvsbkPV1wAyM9QOjTcE4/2KEld2Ple8d7l?=
 =?us-ascii?Q?RhimU7SlY2CCisU+HNVNMzGwK2YUDpD/MOmFumL7tRdrRGvNWIWsgryJOLrN?=
 =?us-ascii?Q?RLpWN2XOJ7FBHzRMKO3Pyej7Az6/FFgTpN+fLX4zJAD+jyiEw83iNBJxiI/Y?=
 =?us-ascii?Q?y9IsKYFTsbCJs3ggBs1FkuMoMgRB7u08G/es5dwZj0LGs6pW8DA8AgNSFBD+?=
 =?us-ascii?Q?5+PgRqs=3D?=
X-Forefront-Antispam-Report: CIP:198.51.192.30; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:HPK-MSS-XCH19.digi.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:25:39.2617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cda916-94ea-4941-e4cd-08dcdba94e8e
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=abb4cdb7-1b7e-483e-a143-7ebfd1184b9e; Ip=[198.51.192.30];
 Helo=[HPK-MSS-XCH19.digi.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-BESS-ID: 1727079945-103477-12692-38373-1
X-BESS-VER: 2019.1_20240917.2338
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYW5iZAVgZQ0NwgKc3U2DDNIN
 XELNk80cQ4xcwwydIwydwo1dLYODFJqTYWAPWi1MxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.259241 [from 
 cloudscan10-187.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Tue, 24 Sep 2024 04:13:40 +0200
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

From: Arturo Buzarra <arturo.buzarra@digi.com>

This commit adds support to manage an external regulator to enable the main
power supply VDD.

Signed-off-by: Arturo Buzarra <arturo.buzarra@digi.com>
---
 drivers/rtc/rv3028.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/rtc/rv3028.c b/drivers/rtc/rv3028.c
index 9f63afc14a8..b14d2a246ff 100644
--- a/drivers/rtc/rv3028.c
+++ b/drivers/rtc/rv3028.c
@@ -12,6 +12,9 @@
 #include <dm.h>
 #include <i2c.h>
 #include <rtc.h>
+#include <dm/device_compat.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
 
 #define RV3028_SEC			0x00
 #define RV3028_MIN			0x01
@@ -78,6 +81,12 @@
 
 #define RTC_RV3028_LEN			7
 
+#define VDD_START_TIME_US		200000
+
+struct rv3028_priv {
+	struct udevice *vdd;
+};
+
 static int rv3028_rtc_get(struct udevice *dev, struct rtc_time *tm)
 {
 	u8 regs[RTC_RV3028_LEN];
@@ -180,6 +189,28 @@ static int rv3028_rtc_write8(struct udevice *dev, unsigned int reg, int val)
 
 static int rv3028_probe(struct udevice *dev)
 {
+	struct rv3028_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DM_REGULATOR)) {
+		ret =  device_get_supply_regulator(dev, "vdd-supply", &priv->vdd);
+		if (ret && ret != -ENOENT) {
+			dev_err(dev, "Warning: cannot get VDD supply\n");
+			return ret;
+		}
+
+		if (priv->vdd) {
+			ret = regulator_set_enable_if_allowed(priv->vdd, true);
+			if (ret) {
+				dev_err(dev, "failed to enable vdd-supply\n");
+				return ret;
+			}
+
+			/* We must wait Tstart = 0.2s before access to I2C */
+			udelay(VDD_START_TIME_US);
+		}
+	}
+
 	i2c_set_chip_flags(dev, DM_I2C_CHIP_RD_ADDRESS |
 				DM_I2C_CHIP_WR_ADDRESS);
 
@@ -205,4 +236,5 @@ U_BOOT_DRIVER(rtc_rv3028) = {
 	.probe	= rv3028_probe,
 	.of_match = rv3028_rtc_ids,
 	.ops	= &rv3028_rtc_ops,
+	.priv_auto	= sizeof(struct rv3028_priv),
 };
-- 
2.46.0

