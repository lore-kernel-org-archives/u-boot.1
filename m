Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8E4EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8275686AA3;
	Thu, 17 Aug 2023 10:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="evmnkn6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DA686AA8; Thu, 17 Aug 2023 10:57:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C654986AAB
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262644; x=1694854644;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lr6/M/udMLMUDyYOtgRbgUDGr9UUxmSb7fPj1piSgoc=;
 b=evmnkn6cd9n/3WuGmMRWH7MKyemlp17UA1Ey5oOUPZIxeSzpbR3JiXPBR0Xnf3+e
 lNqPUkQqOTqRMhgSn2+/GfGePAiwrJEpnNAKkNCoSMexu94vw52Mln9CJwxC5s6B
 mtEV7Tn21PPqTJQc5k5vVzCyAkLn3ZTp+J/IZICLm1w=;
X-AuditID: ac14000a-917fe70000007ecb-af-64dde0f4f397
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 34.D2.32459.4F0EDD46;
 Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:24 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 4/6] board: phytec: phycore_imx8mp: Update 2GB RAM Timings
Date: Thu, 17 Aug 2023 10:57:09 +0200
Message-ID: <20230817085711.45339-5-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR/fLg7spBg9+aVs8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujKONagWNORV3Tx1nbmBcENjFyMkhIWAisebVN+YuRi4OIYElTBJdK/ayQjjPGCX6ZjSw
 g1SxCWhIPF1xmgnEFhEok3jY+4kZxGYWWMwosfq3JYgtLOArcXfNG0YQm0VAVeLSjQcsIDav
 gLnE190bGCG2yUvsP3gWrJdTwEKiqfsG2HwhoJpFPbsYIeoFJU7OfMICMV9eonnrbKhdEhIH
 X7xghqiXl9h16STczGnnXjND2KESRzatZprAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9
 gozKktRkvZTUTYygsBdh4NrB2DfH4xAjEwfjIUYJDmYlEd4e3lspQrwpiZVVqUX58UWlOanF
 hxilOViUxHnv9zAlCgmkJ5akZqemFqQWwWSZODilGhgVaz+UZP9iP9YYk2WY2yZuzx3YqbdK
 tDM4izvnOpvfv1pfgzXdJr9+LxNpWhyr6ZF41v/NrtVnP5d3KmrlJh07Ea7z7oPLxnWXrd1a
 /+eYbbXWYm8zOxV53T34z+a+aKt7l45y7tL4eai9salyY5PztEgOBy/pL/139qZdKfVUPPPZ
 e53uNCWW4oxEQy3mouJEAACB+DhpAgAA
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

Due to PCB layout constraints in PCB revisions until including 1549.2,
a RAM frequency of 2 GHz can cause rare instabilities. Set the RAM
frequency to 1.5 GHz to achieve a stable system under all conditions.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
- none
---
 board/phytec/phycore_imx8mp/lpddr4_timing.c | 278 ++++++++++----------
 1 file changed, 135 insertions(+), 143 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/lpddr4_timing.c b/board/phytec/phycore_imx8mp/lpddr4_timing.c
index e59dd74377cb..f2707b859606 100644
--- a/board/phytec/phycore_imx8mp/lpddr4_timing.c
+++ b/board/phytec/phycore_imx8mp/lpddr4_timing.c
@@ -13,63 +13,68 @@ static struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x1 },
 	{ 0x3d400000, 0xa1080020 },
-	{ 0x3d400020, 0x323 },
-	{ 0x3d400024, 0x1e84800 },
-	{ 0x3d400064, 0x7a0118 },
-	{ 0x3d4000d0, 0xc00307a3 },
-	{ 0x3d4000d4, 0xc50000 },
-	{ 0x3d4000dc, 0xf4003f },
-	{ 0x3d4000e0, 0x330000 },
+	{ 0x3d400020, 0x1223 },
+	{ 0x3d400024, 0x16e3600 },
+	{ 0x3d400064, 0x5b00d2 },
+	{ 0x3d400070, 0x7027f90 },
+	{ 0x3d400074, 0x790 },
+	{ 0x3d4000d0, 0xc00305ba },
+	{ 0x3d4000d4, 0x940000 },
+	{ 0x3d4000dc, 0xd4002d },
+	{ 0x3d4000e0, 0xf10000 },
 	{ 0x3d4000e8, 0x660048 },
 	{ 0x3d4000ec, 0x160048 },
-	{ 0x3d400100, 0x2028222a },
-	{ 0x3d400104, 0x807bf },
-	{ 0x3d40010c, 0xe0e000 },
-	{ 0x3d400110, 0x12040a12 },
-	{ 0x3d400114, 0x2050f0f },
-	{ 0x3d400118, 0x1010009 },
-	{ 0x3d40011c, 0x501 },
-	{ 0x3d400130, 0x20800 },
-	{ 0x3d400134, 0xe100002 },
-	{ 0x3d400138, 0x120 },
-	{ 0x3d400144, 0xc80064 },
-	{ 0x3d400180, 0x3e8001e },
-	{ 0x3d400184, 0x3207a12 },
+	{ 0x3d400100, 0x191e1920 },
+	{ 0x3d400104, 0x60630 },
+	{ 0x3d40010c, 0xb0b000 },
+	{ 0x3d400110, 0xe04080e },
+	{ 0x3d400114, 0x2040c0c },
+	{ 0x3d400118, 0x1010007 },
+	{ 0x3d40011c, 0x401 },
+	{ 0x3d400130, 0x20600 },
+	{ 0x3d400134, 0xc100002 },
+	{ 0x3d400138, 0xd8 },
+	{ 0x3d400144, 0x96004b },
+	{ 0x3d400180, 0x2ee0017 },
+	{ 0x3d400184, 0x2605b8e },
 	{ 0x3d400188, 0x0 },
-	{ 0x3d400190, 0x49f820e },
+	{ 0x3d400190, 0x49b820a },
 	{ 0x3d400194, 0x80303 },
-	{ 0x3d4001b4, 0x1f0e },
+	{ 0x3d4001b4, 0x1b0a },
 	{ 0x3d4001a0, 0xe0400018 },
 	{ 0x3d4001a4, 0xdf00e4 },
 	{ 0x3d4001a8, 0x80000000 },
 	{ 0x3d4001b0, 0x11 },
-	{ 0x3d4001c0, 0x1 },
+	{ 0x3d4001c0, 0x7 },
 	{ 0x3d4001c4, 0x1 },
 	{ 0x3d4000f4, 0xc99 },
-	{ 0x3d400108, 0x9121c1c },
+	{ 0x3d400108, 0x7101817 },
 	{ 0x3d400200, 0x1f },
+	{ 0x3d400208, 0x0 },
 	{ 0x3d40020c, 0x0 },
 	{ 0x3d400210, 0x1f1f },
 	{ 0x3d400204, 0x80808 },
 	{ 0x3d400214, 0x7070707 },
 	{ 0x3d400218, 0x7070707 },
-	{ 0x3d40021c, 0xf07 },
-	{ 0x3d400250, 0x1f05 },
-	{ 0x3d400254, 0x1f },
-	{ 0x3d400264, 0x90003ff },
-	{ 0x3d40026c, 0x20003ff },
+	{ 0x3d40021c, 0xf0f },
+	{ 0x3d400250, 0x1705 },
+	{ 0x3d400254, 0x2c },
+	{ 0x3d40025c, 0x4000030 },
+	{ 0x3d400264, 0x900093e7 },
+	{ 0x3d40026c, 0x2005574 },
 	{ 0x3d400400, 0x111 },
+	{ 0x3d400404, 0x72ff },
 	{ 0x3d400408, 0x72ff },
-	{ 0x3d400494, 0x1000e00 },
-	{ 0x3d400498, 0x3ff0000 },
-	{ 0x3d40049c, 0x1000e00 },
-	{ 0x3d4004a0, 0x3ff0000 },
-	{ 0x3d402020, 0x21 },
+	{ 0x3d400494, 0x2100e07 },
+	{ 0x3d400498, 0x620096 },
+	{ 0x3d40049c, 0x1100e07 },
+	{ 0x3d4004a0, 0xc8012c },
+	{ 0x3d402020, 0x1021 },
 	{ 0x3d402024, 0x30d400 },
-	{ 0x3d402050, 0x20d040 },
+	{ 0x3d402050, 0x20d000 },
 	{ 0x3d402064, 0xc001c },
 	{ 0x3d4020dc, 0x840000 },
-	{ 0x3d4020e0, 0x330000 },
+	{ 0x3d4020e0, 0xf30000 },
 	{ 0x3d4020e8, 0x660048 },
 	{ 0x3d4020ec, 0x160048 },
 	{ 0x3d402100, 0xa040305 },
@@ -89,12 +94,12 @@ static struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{ 0x3d402194, 0x80303 },
 	{ 0x3d4021b4, 0x100 },
 	{ 0x3d4020f4, 0xc99 },
-	{ 0x3d403020, 0x21 },
+	{ 0x3d403020, 0x1021 },
 	{ 0x3d403024, 0xc3500 },
-	{ 0x3d403050, 0x20d040 },
+	{ 0x3d403050, 0x20d000 },
 	{ 0x3d403064, 0x30007 },
 	{ 0x3d4030dc, 0x840000 },
-	{ 0x3d4030e0, 0x330000 },
+	{ 0x3d4030e0, 0xf30000 },
 	{ 0x3d4030e8, 0x660048 },
 	{ 0x3d4030ec, 0x160048 },
 	{ 0x3d403100, 0xa010102 },
@@ -137,12 +142,12 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{ 0x110a7, 0x6 },
 	{ 0x120a0, 0x0 },
 	{ 0x120a1, 0x1 },
-	{ 0x120a2, 0x3 },
-	{ 0x120a3, 0x2 },
-	{ 0x120a4, 0x5 },
-	{ 0x120a5, 0x4 },
-	{ 0x120a6, 0x7 },
-	{ 0x120a7, 0x6 },
+	{ 0x120a2, 0x2 },
+	{ 0x120a3, 0x3 },
+	{ 0x120a4, 0x4 },
+	{ 0x120a5, 0x5 },
+	{ 0x120a6, 0x6 },
+	{ 0x120a7, 0x7 },
 	{ 0x130a0, 0x0 },
 	{ 0x130a1, 0x1 },
 	{ 0x130a2, 0x2 },
@@ -185,7 +190,7 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{ 0x7055, 0x1ff },
 	{ 0x8055, 0x1ff },
 	{ 0x9055, 0x1ff },
-	{ 0x200c5, 0x18 },
+	{ 0x200c5, 0x19 },
 	{ 0x1200c5, 0x7 },
 	{ 0x2200c5, 0x7 },
 	{ 0x2002e, 0x2 },
@@ -194,11 +199,11 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{ 0x90204, 0x0 },
 	{ 0x190204, 0x0 },
 	{ 0x290204, 0x0 },
-	{ 0x20024, 0x1e3 },
+	{ 0x20024, 0x1a3 },
 	{ 0x2003a, 0x2 },
-	{ 0x120024, 0x1e3 },
+	{ 0x120024, 0x1a3 },
 	{ 0x2003a, 0x2 },
-	{ 0x220024, 0x1e3 },
+	{ 0x220024, 0x1a3 },
 	{ 0x2003a, 0x2 },
 	{ 0x20056, 0x3 },
 	{ 0x120056, 0x3 },
@@ -264,7 +269,7 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{ 0x20018, 0x3 },
 	{ 0x20075, 0x4 },
 	{ 0x20050, 0x0 },
-	{ 0x20008, 0x3e8 },
+	{ 0x20008, 0x2ee },
 	{ 0x120008, 0x64 },
 	{ 0x220008, 0x19 },
 	{ 0x20088, 0x9 },
@@ -310,19 +315,15 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
 	{ 0x200f6, 0x0 },
 	{ 0x200f7, 0xf000 },
 	{ 0x20025, 0x0 },
-	{ 0x2002d, 0x0 },
-	{ 0x12002d, 0x0 },
-	{ 0x22002d, 0x0 },
+	{ 0x2002d, 0x1 },
+	{ 0x12002d, 0x1 },
+	{ 0x22002d, 0x1 },
 	{ 0x2007d, 0x212 },
 	{ 0x12007d, 0x212 },
 	{ 0x22007d, 0x212 },
 	{ 0x2007c, 0x61 },
 	{ 0x12007c, 0x61 },
 	{ 0x22007c, 0x61 },
-	{ 0x1004a, 0x500 },
-	{ 0x1104a, 0x500 },
-	{ 0x1204a, 0x500 },
-	{ 0x1304a, 0x500 },
 	{ 0x2002c, 0x0 },
 };
 
@@ -1052,7 +1053,7 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
 /* P0 message block paremeter for training firmware */
 static struct dram_cfg_param ddr_fsp0_cfg[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xfa0 },
+	{ 0x54003, 0xbb8 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
@@ -1061,26 +1062,26 @@ static struct dram_cfg_param ddr_fsp0_cfg[] = {
 	{ 0x5400b, 0x2 },
 	{ 0x5400f, 0x100 },
 	{ 0x54012, 0x110 },
-	{ 0x54019, 0x3ff4 },
-	{ 0x5401a, 0x33 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, 0xf1 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x3ff4 },
-	{ 0x54020, 0x33 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, 0xf1 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
-	{ 0x54032, 0xf400 },
-	{ 0x54033, 0x333f },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, 0xf12d },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xf400 },
-	{ 0x54039, 0x333f },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, 0xf12d },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1102,25 +1103,25 @@ static struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0x5400f, 0x100 },
 	{ 0x54012, 0x110 },
 	{ 0x54019, 0x84 },
-	{ 0x5401a, 0x33 },
+	{ 0x5401a, 0xf3 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
 	{ 0x5401f, 0x84 },
-	{ 0x54020, 0x33 },
+	{ 0x54020, 0xf3 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
 	{ 0x54032, 0x8400 },
-	{ 0x54033, 0x3300 },
+	{ 0x54033, 0xf300 },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
 	{ 0x54038, 0x8400 },
-	{ 0x54039, 0x3300 },
+	{ 0x54039, 0xf300 },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1142,25 +1143,25 @@ static struct dram_cfg_param ddr_fsp2_cfg[] = {
 	{ 0x5400f, 0x100 },
 	{ 0x54012, 0x110 },
 	{ 0x54019, 0x84 },
-	{ 0x5401a, 0x33 },
+	{ 0x5401a, 0xf3 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
 	{ 0x5401f, 0x84 },
-	{ 0x54020, 0x33 },
+	{ 0x54020, 0xf3 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
 	{ 0x54032, 0x8400 },
-	{ 0x54033, 0x3300 },
+	{ 0x54033, 0xf300 },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
 	{ 0x54038, 0x8400 },
-	{ 0x54039, 0x3300 },
+	{ 0x54039, 0xf300 },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1171,37 +1172,36 @@ static struct dram_cfg_param ddr_fsp2_cfg[] = {
 /* P0 2D message block paremeter for training firmware */
 static struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
 	{ 0xd0000, 0x0 },
-	{ 0x54003, 0xfa0 },
+	{ 0x54003, 0xbb8 },
 	{ 0x54004, 0x2 },
 	{ 0x54005, 0x2228 },
 	{ 0x54006, 0x14 },
 	{ 0x54008, 0x61 },
 	{ 0x54009, 0xc8 },
 	{ 0x5400b, 0x2 },
-	{ 0x5400d, 0x100 },
 	{ 0x5400f, 0x100 },
 	{ 0x54010, 0x1f7f },
 	{ 0x54012, 0x110 },
-	{ 0x54019, 0x3ff4 },
-	{ 0x5401a, 0x33 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, 0xf1 },
 	{ 0x5401b, 0x4866 },
 	{ 0x5401c, 0x4800 },
 	{ 0x5401e, 0x16 },
-	{ 0x5401f, 0x3ff4 },
-	{ 0x54020, 0x33 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, 0xf1 },
 	{ 0x54021, 0x4866 },
 	{ 0x54022, 0x4800 },
 	{ 0x54024, 0x16 },
 	{ 0x5402b, 0x1000 },
 	{ 0x5402c, 0x1 },
-	{ 0x54032, 0xf400 },
-	{ 0x54033, 0x333f },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, 0xf12d },
 	{ 0x54034, 0x6600 },
 	{ 0x54035, 0x48 },
 	{ 0x54036, 0x48 },
 	{ 0x54037, 0x1600 },
-	{ 0x54038, 0xf400 },
-	{ 0x54039, 0x333f },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, 0xf12d },
 	{ 0x5403a, 0x6600 },
 	{ 0x5403b, 0x48 },
 	{ 0x5403c, 0x48 },
@@ -1629,67 +1629,58 @@ static struct dram_cfg_param ddr_phy_pie[] = {
 	{ 0x90155, 0x20 },
 	{ 0x90156, 0x2aa },
 	{ 0x90157, 0x9 },
-	{ 0x90158, 0x0 },
-	{ 0x90159, 0x400 },
-	{ 0x9015a, 0x10e },
-	{ 0x9015b, 0x8 },
-	{ 0x9015c, 0xe8 },
-	{ 0x9015d, 0x109 },
-	{ 0x9015e, 0x0 },
-	{ 0x9015f, 0x8140 },
-	{ 0x90160, 0x10c },
-	{ 0x90161, 0x10 },
-	{ 0x90162, 0x8138 },
-	{ 0x90163, 0x10c },
-	{ 0x90164, 0x8 },
-	{ 0x90165, 0x7c8 },
-	{ 0x90166, 0x101 },
-	{ 0x90167, 0x8 },
-	{ 0x90168, 0x448 },
+	{ 0x90158, 0x8 },
+	{ 0x90159, 0xe8 },
+	{ 0x9015a, 0x109 },
+	{ 0x9015b, 0x0 },
+	{ 0x9015c, 0x8140 },
+	{ 0x9015d, 0x10c },
+	{ 0x9015e, 0x10 },
+	{ 0x9015f, 0x8138 },
+	{ 0x90160, 0x104 },
+	{ 0x90161, 0x8 },
+	{ 0x90162, 0x448 },
+	{ 0x90163, 0x109 },
+	{ 0x90164, 0xf },
+	{ 0x90165, 0x7c0 },
+	{ 0x90166, 0x109 },
+	{ 0x90167, 0x0 },
+	{ 0x90168, 0xe8 },
 	{ 0x90169, 0x109 },
-	{ 0x9016a, 0xf },
-	{ 0x9016b, 0x7c0 },
+	{ 0x9016a, 0x47 },
+	{ 0x9016b, 0x630 },
 	{ 0x9016c, 0x109 },
-	{ 0x9016d, 0x0 },
-	{ 0x9016e, 0xe8 },
+	{ 0x9016d, 0x8 },
+	{ 0x9016e, 0x618 },
 	{ 0x9016f, 0x109 },
-	{ 0x90170, 0x47 },
-	{ 0x90171, 0x630 },
+	{ 0x90170, 0x8 },
+	{ 0x90171, 0xe0 },
 	{ 0x90172, 0x109 },
-	{ 0x90173, 0x8 },
-	{ 0x90174, 0x618 },
+	{ 0x90173, 0x0 },
+	{ 0x90174, 0x7c8 },
 	{ 0x90175, 0x109 },
 	{ 0x90176, 0x8 },
-	{ 0x90177, 0xe0 },
-	{ 0x90178, 0x109 },
+	{ 0x90177, 0x8140 },
+	{ 0x90178, 0x10c },
 	{ 0x90179, 0x0 },
-	{ 0x9017a, 0x7c8 },
+	{ 0x9017a, 0x478 },
 	{ 0x9017b, 0x109 },
-	{ 0x9017c, 0x8 },
-	{ 0x9017d, 0x8140 },
-	{ 0x9017e, 0x10c },
-	{ 0x9017f, 0x0 },
-	{ 0x90180, 0x478 },
-	{ 0x90181, 0x109 },
-	{ 0x90182, 0x0 },
-	{ 0x90183, 0x1 },
-	{ 0x90184, 0x8 },
-	{ 0x90185, 0x8 },
-	{ 0x90186, 0x4 },
-	{ 0x90187, 0x8 },
-	{ 0x90188, 0x8 },
-	{ 0x90189, 0x7c8 },
-	{ 0x9018a, 0x101 },
-	{ 0x90006, 0x0 },
-	{ 0x90007, 0x0 },
-	{ 0x90008, 0x8 },
+	{ 0x9017c, 0x0 },
+	{ 0x9017d, 0x1 },
+	{ 0x9017e, 0x8 },
+	{ 0x9017f, 0x8 },
+	{ 0x90180, 0x4 },
+	{ 0x90181, 0x0 },
+	{ 0x90006, 0x8 },
+	{ 0x90007, 0x7c8 },
+	{ 0x90008, 0x109 },
 	{ 0x90009, 0x0 },
-	{ 0x9000a, 0x0 },
-	{ 0x9000b, 0x0 },
+	{ 0x9000a, 0x400 },
+	{ 0x9000b, 0x106 },
 	{ 0xd00e7, 0x400 },
 	{ 0x90017, 0x0 },
 	{ 0x9001f, 0x29 },
-	{ 0x90026, 0x6a },
+	{ 0x90026, 0x68 },
 	{ 0x400d0, 0x0 },
 	{ 0x400d1, 0x101 },
 	{ 0x400d2, 0x105 },
@@ -1699,15 +1690,16 @@ static struct dram_cfg_param ddr_phy_pie[] = {
 	{ 0x400d6, 0x20a },
 	{ 0x400d7, 0x20b },
 	{ 0x2003a, 0x2 },
-	{ 0x2000b, 0x7d },
-	{ 0x2000c, 0xfa },
-	{ 0x2000d, 0x9c4 },
+	{ 0x200be, 0x3 },
+	{ 0x2000b, 0x34b },
+	{ 0x2000c, 0xbb },
+	{ 0x2000d, 0x753 },
 	{ 0x2000e, 0x2c },
-	{ 0x12000b, 0xc },
+	{ 0x12000b, 0x70 },
 	{ 0x12000c, 0x19 },
 	{ 0x12000d, 0xfa },
 	{ 0x12000e, 0x10 },
-	{ 0x22000b, 0x3 },
+	{ 0x22000b, 0x1c },
 	{ 0x22000c, 0x6 },
 	{ 0x22000d, 0x3e },
 	{ 0x22000e, 0x10 },
@@ -1804,8 +1796,8 @@ static struct dram_cfg_param ddr_phy_pie[] = {
 
 static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
 	{
-		/* P0 4000mts 1D */
-		.drate = 4000,
+		/* P0 3000mts 1D */
+		.drate = 3000,
 		.fw_type = FW_1D_IMAGE,
 		.fsp_cfg = ddr_fsp0_cfg,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
@@ -1825,8 +1817,8 @@ static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg),
 	},
 	{
-		/* P0 4000mts 2D */
-		.drate = 4000,
+		/* P0 3000mts 2D */
+		.drate = 3000,
 		.fw_type = FW_2D_IMAGE,
 		.fsp_cfg = ddr_fsp0_2d_cfg,
 		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
@@ -1845,5 +1837,5 @@ struct dram_timing_info dram_timing = {
 	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
 	.ddrphy_pie = ddr_phy_pie,
 	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
-	.fsp_table = { 4000, 400, 100, },
+	.fsp_table = { 3000, 400, 100, },
 };
-- 
2.34.1

