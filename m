Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67062D31A2B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82CC835B3;
	Wed, 14 Jan 2026 10:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="OF5tZ9ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3579830A0; Wed, 14 Jan 2026 10:04:09 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AD783885
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZBPnwiwEQvwjpG4RBEq1cNj1mVkPj47xqdoioOighbIvsdsXY3IjRueCh0s7gQuirT0C1ghW8F0G8ABGxW2EKpHfWLzcaYpu0peHD1Why38qJMb/IVMmOQgUQ8buq9upAvu449CQuwY2vd1HzsNd9NcjweqYFDNpFln63MwpIVI7YOYB08GzD1gu/V/PlpTJAZR2BDe+OJGWkrWEbnlM3dhJTH5rk3rTN+aIFR4z8Rmv7DeALyhBMUbq5Rfl+wGxwZ+WVMxe5EJI01WYHLtJg4cXs+pVaykEfQuuLp9ZIDYW+Q9dU0qUNzhCJxlMrNEyWD8ZfLX6tcl6A0cCz0o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1xEfk/jXL8RVzE95eWXwYrOBlI25MecTT/8egN/fb0=;
 b=a2a1UPzd+m1/UT9mEBmslU4HctekF6jPldlqAJ18voiXwhaMKXyJDKjkne/EOw1DSyGr71AcWh4xgUBUOxh95r0r9apl4pEID0somxfdKf1XUzOUf/goBWb2C60JL55eWQNelJRWfE4WEDKPm/nJ6VJeyTjhhzM/sNtCExFqkSKhXMC/2dev0wgl5FxxioraMw/XdB1DlBG7OS+Vh3A0PgoVB36lHYldDAPFKMUrVJGH4wGXPuWNzT8deyifXM/jWuumrv08dDrqXhf4WM9n+s3kqPcsnlA0bh+S6t6WHCWAUEe668/ui41kAFnjdOUvHkVUA5Jux10oNaDziVmUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1xEfk/jXL8RVzE95eWXwYrOBlI25MecTT/8egN/fb0=;
 b=OF5tZ9wwFti1XeCttfObxUZ7dAYIJKbe6N3SS6sDdIUA9cXvf2LknL/OKhpiDohYSxFYqK9CdWGIy2qbgOzjkSVRhsYOYmgv3c+e7vTQl1cT0iAqVSenGzHQKOEXeZ8lPakJAFpU6VBxPxd60zEsdR/yy7UJfixuKBmOBG6UT2u4hAt7KZiIqMuM0FFkJCpf0aMFgttvbVgcOZl/Fi52IH14CEPBn0/76c2OBEafB6sZSx91eDRbUH7aAM+d7/c/55eCFwyqa+kTqVT949wRUCU/B1Lkr7HaTKXvqBBLAzALLo1A/rC7OvgLg+RrF4nij1cJxgWqf2DOpVstu/2luA==
Received: from DB9PR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::6) by PAXP195MB1607.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:281::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 09:04:03 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::d6) by DB9PR01CA0001.outlook.office365.com
 (2603:10a6:10:1d8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:04:02 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 14 Jan
 2026 10:04:02 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <t.remmet@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] board: phytec: Add PHYTEC mailing list to MAINTAINERS entries
Date: Wed, 14 Jan 2026 10:03:51 +0100
Message-ID: <20260114090351.3419641-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PAXP195MB1607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ecd67b5-3e3b-4fb4-5618-08de534bdcf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vL46+QTXAh8mUXwHln8gw+YmK7QPFDlgZCyi/SUFYyyothkybGcNkpL8815Y?=
 =?us-ascii?Q?N1BAWaxDsY0VgkbamaVBFN8vZq3dV16ggz3mHZX8JxhLySZvph8w3ZTjGmks?=
 =?us-ascii?Q?3de3NX9V0yRrMScVgt1w2MqROb/Xy9ihzhMVxxbM9nqT+0S9vqrnYIzQK+TZ?=
 =?us-ascii?Q?wJfNZDpw9Ht03rRswUD5x201NoapkBMwJi1fuC1BPKlBBAsp8K3/ISxnMUC2?=
 =?us-ascii?Q?NA3sChFczs7xSPk1E6u7Grd7DW2ZKF3XwxY4L1kqkzj9sGmG20kFoDeICXa2?=
 =?us-ascii?Q?I1SfYOrfp90yIvBinQzZ5O1Dctp+AwVb7iwUvKn/lmjZwyrcxZw9hmHcjJUl?=
 =?us-ascii?Q?53uligLq6U4RB71nix2VuTKoYvSzdW3TN4vwvNcp/6Ig6Ozt6hO38VFRKWe3?=
 =?us-ascii?Q?7EMYoxqWUYNAv0IQQKOuu2HtecpQaIcrMWWpvan8/Gr2Zqmk2hNFbtJzGQzf?=
 =?us-ascii?Q?fTzdy8veXS9JfuHBtashK9a0lZZpqcZbt/0+VLBMjzAaAXNPrAVspiVwu+86?=
 =?us-ascii?Q?NQVmzYgQOPLIBzFDaAQLisHB6DapizEKhmamcGjVeeTE1PwSqLlIQIKakdD7?=
 =?us-ascii?Q?FqXOjnNDYim0HllVGC30Bi+hscvju6BaJmS0f/QCxxw8qkHWnI9fZZYOv5ks?=
 =?us-ascii?Q?NIM1wwU+8EMeWqlYbLlacDKBCZ2ZyT5TBFcOqljhaFy56waniqUVDIKRygXV?=
 =?us-ascii?Q?xhic3nJ9AV7y/uI0ZNby0pIDt3jZs7tCOiJ0eURVWAbBYbkEnX22OW+cVosg?=
 =?us-ascii?Q?4gl/xVJyejdedbdhVl3rWb8aqKUe6Vwn7pUaFDsBCCvPrS8/cF6owlvLXSsp?=
 =?us-ascii?Q?5HjkfC5DL61XhMKPerSr2b5AUrHAnd4AXY2cUsdR9wN2QwudbImy5ltZagba?=
 =?us-ascii?Q?Lwn1L2MIYFFrc/yruA19lTEHW0H/nB6BMkU/k0mZFFraJvWEka54TC6mgWVH?=
 =?us-ascii?Q?aF/eIwbYnUoYy9QS1sMmnYQtqBauocO/EnPJYv+I3VnuH9jfzWcQoKvt/GX1?=
 =?us-ascii?Q?J477c/f2lLsevOJoxKU76w2rslP8Mx+zvrgcJUOmsexcZYOOdl4R997zbtbv?=
 =?us-ascii?Q?s7Rv4m0Np5kg+32qo0FF+4kHNr1xTA73bd3PiNYkxeK7a54rN1GdYGwyUyfC?=
 =?us-ascii?Q?l/HgKDJ1asr23ReMjJM+vUfcUyrWkJ3Bkqs9vKXiJPZzWHbmzZYDHPHYWZPy?=
 =?us-ascii?Q?gobKK/5dFbROe0B5JQAfEiMv027EySP5nOwPwfeZi/bt1ix/tovFk5aS+kOd?=
 =?us-ascii?Q?F7dyj8IZpsSJ5DxJn9o6Yj588iH6pVo+RBGtqAQ/NeW7pOKXD37CFAhn1mtF?=
 =?us-ascii?Q?bAOECduwqGXmjB+wfUCmURxP60sYP8IE/HYkLOazGuhXJnTXtUSvVkz8sejI?=
 =?us-ascii?Q?ImmdhQa7L/+iWu2xSKrtRyDWJ62QoqNaS25Ip3lHuNh0BNR+Tw4UAuhyHT6E?=
 =?us-ascii?Q?8Pju5iluL/h9dtRHXUZtkpDQDhETlx9kJxs31uxsn1att2hG/M4H13p42w9D?=
 =?us-ascii?Q?ltw6oeAQkC7MnxvV/5JV5tIV1KZ9UeAHfFZrUIx0TxrRrXzVXQ0PJ71t2zhB?=
 =?us-ascii?Q?/p0YldFghf6aFE+LYeY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:04:02.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ecd67b5-3e3b-4fb4-5618-08de534bdcf1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1607
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

PHYTEC maintains an actively monitored mailing list for upstream
activities: upstream@lists.phytec.de. Add it to the MAINTAINERS
entries for PHYTEC boards we actively develop and contribute to.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/imx8mp-libra-fpsc/MAINTAINERS | 1 +
 board/phytec/phycore_am62ax/MAINTAINERS    | 1 +
 board/phytec/phycore_am62x/MAINTAINERS     | 1 +
 board/phytec/phycore_am64x/MAINTAINERS     | 1 +
 board/phytec/phycore_imx8mm/MAINTAINERS    | 1 +
 board/phytec/phycore_imx8mp/MAINTAINERS    | 1 +
 board/phytec/phycore_imx93/MAINTAINERS     | 1 +
 board/phytec/phycore_rk3288/MAINTAINERS    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/board/phytec/imx8mp-libra-fpsc/MAINTAINERS b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
index 1fd99888a2e..c2d24b7c386 100644
--- a/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
+++ b/board/phytec/imx8mp-libra-fpsc/MAINTAINERS
@@ -1,5 +1,6 @@
 Libra-i.MX 8M Plus
 M:	Teresa Remmet <t.remmet@phytec.de>
+L:	upstream@lists.phytec.de
 W:	https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-8m-plus-fpsc/
 S:	Maintained
 F:	arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
index feb1e0b39dc..ded4a88d199 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -1,6 +1,7 @@
 phyCORE-AM62ax
 M:	Garrett Giordano <ggiordano@phytec.com>
 M:	Wadim Egorov <w.egorov@phytec.de>
+L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am62a
 S:	Maintained
 F:	arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
diff --git a/board/phytec/phycore_am62x/MAINTAINERS b/board/phytec/phycore_am62x/MAINTAINERS
index 274dc0cbb81..7274e6aa376 100644
--- a/board/phytec/phycore_am62x/MAINTAINERS
+++ b/board/phytec/phycore_am62x/MAINTAINERS
@@ -1,5 +1,6 @@
 phyCORE-AM62x
 M:	Wadim Egorov <w.egorov@phytec.de>
+L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am62x
 S:	Maintained
 F:	arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
diff --git a/board/phytec/phycore_am64x/MAINTAINERS b/board/phytec/phycore_am64x/MAINTAINERS
index f5294db9916..0ba503934c8 100644
--- a/board/phytec/phycore_am64x/MAINTAINERS
+++ b/board/phytec/phycore_am64x/MAINTAINERS
@@ -1,5 +1,6 @@
 phyCORE-AM64x
 M:	Wadim Egorov <w.egorov@phytec.de>
+L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am64x
 S:	Maintained
 F:	arch/arm/dts/k3-am64-phycore-som-ddr4-2gb.dtsi
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 58c5e2d0af9..5cada15ac4b 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -1,5 +1,6 @@
 phyCORE-i.MX8M Mini
 M:      Teresa Remmet <t.remmet@phytec.de>
+L:      upstream@lists.phytec.de
 W:      https://www.phytec.eu/product-eu/system-on-modules/phycore-imx-8m-mini-nano/
 S:      Maintained
 F:      arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
diff --git a/board/phytec/phycore_imx8mp/MAINTAINERS b/board/phytec/phycore_imx8mp/MAINTAINERS
index 645476ae30a..9343e3b550d 100644
--- a/board/phytec/phycore_imx8mp/MAINTAINERS
+++ b/board/phytec/phycore_imx8mp/MAINTAINERS
@@ -1,5 +1,6 @@
 phyCORE-i.MX8M Plus
 M:      Teresa Remmet <t.remmet@phytec.de>
+L:      upstream@lists.phytec.de
 W:      https://www.phytec.eu/product-eu/system-on-modules/phycore-imx-8m-plus/
 S:      Maintained
 F:      arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
index 7393061707d..0b087bf1ef2 100644
--- a/board/phytec/phycore_imx93/MAINTAINERS
+++ b/board/phytec/phycore_imx93/MAINTAINERS
@@ -1,6 +1,7 @@
 phyCORE-i.MX93
 M:      Mathieu Othacehe <m.othacehe@gmail.com>
 R:      Christoph Stoidner <c.stoidner@phytec.de>
+L:      upstream@lists.phytec.de
 W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
 S:      Maintained
 F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
diff --git a/board/phytec/phycore_rk3288/MAINTAINERS b/board/phytec/phycore_rk3288/MAINTAINERS
index e3b0af98e9a..a7ab023ff32 100644
--- a/board/phytec/phycore_rk3288/MAINTAINERS
+++ b/board/phytec/phycore_rk3288/MAINTAINERS
@@ -1,5 +1,6 @@
 phyCORE-RK3288
 M:	Wadim Egorov <w.egorov@phytec.de>
+L:	upstream@lists.phytec.de
 S:	Maintained
 F:	arch/arm/dts/rk3288-phycore-rdk-u-boot.dtsi
 F:	board/phytec/phycore_rk3288
-- 
2.48.1

