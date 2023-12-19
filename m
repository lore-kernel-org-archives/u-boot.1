Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CBC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A003E86E82;
	Tue, 19 Dec 2023 09:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B6E86FD5; Tue, 19 Dec 2023 09:25:41 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959CB86E65
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 93BDC20284;
 Tue, 19 Dec 2023 09:25:37 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] arm: dts: k3-am625-verdin: fix DDRSS configuration
Date: Tue, 19 Dec 2023 09:25:33 +0100
Message-Id: <20231219082533.8399-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The current DDR subsystem configuration occasionally results in write failures,
impacting memory stability, on Verdin AM62 Solo 512MB WB IT 0072 SKU.
This commit addresses the issue by adjusting Drive Pull-Up/Down and
Write Latency to improve the eye diagram and ensure reliable write operations.
This configuration is shared with all Verdin AM62 SoM and
it does not introduce regressions.

Configurations changes from previous / default values:
- Drive Pull-Up/Down from 40 to 34.3 Ohm
- Write Latency from 8 to 10
- ODTLon / ODTLoff latency from 0 / 0 to 4 / 20 nCK
- VREF control range 1 at 27 %
- tFAW from 30 to 40 ns

Configuration is output from SysConfig [1] web tool, currently at version
1.18.1+3343 (DDR SubSystem v9.10).

[1] https://dev.ti.com/sysconfig

Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../dts/k3-am625-verdin-lpddr4-1600MTs.dtsi   | 151 +++++++++---------
 1 file changed, 76 insertions(+), 75 deletions(-)

diff --git a/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi b/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
index 9bad4309b491..841541bb2433 100644
--- a/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-lpddr4-1600MTs.dtsi
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * This file was generated with the
- * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.09.08
- * Fri Jun 09 2023 08:01:37 GMT+0200 (Central European Summer Time)
+ * AM62x SysConfig DDR Subsystem Register Configuration Tool v0.09.10
+ * Mon Dec 11 2023 17:07:35 GMT+0100 (Central European Standard Time)
  * DDR Type: LPDDR4
  * F0 = 50MHz    F1 = NA     F2 = 800MHz
  * Density (per channel): 16Gb
  * Write DBI: Enable
  * Number of Ranks: 1
- */
+*/
 
 #define DDRSS_PLL_FHS_CNT 3
 #define DDRSS_PLL_FREQUENCY_1 400000000
 #define DDRSS_PLL_FREQUENCY_2 400000000
 
+
 #define DDRSS_CTL_0_DATA 0x00000B00
 #define DDRSS_CTL_1_DATA 0x00000000
 #define DDRSS_CTL_2_DATA 0x00000000
@@ -54,20 +55,20 @@
 #define DDRSS_CTL_37_DATA 0x00000000
 #define DDRSS_CTL_38_DATA 0x0000040C
 #define DDRSS_CTL_39_DATA 0x00000000
-#define DDRSS_CTL_40_DATA 0x0000081C
+#define DDRSS_CTL_40_DATA 0x00000A1C
 #define DDRSS_CTL_41_DATA 0x00000000
-#define DDRSS_CTL_42_DATA 0x0000081C
+#define DDRSS_CTL_42_DATA 0x00000A1C
 #define DDRSS_CTL_43_DATA 0x00000000
 #define DDRSS_CTL_44_DATA 0x05000804
 #define DDRSS_CTL_45_DATA 0x00000B00
 #define DDRSS_CTL_46_DATA 0x09090004
-#define DDRSS_CTL_47_DATA 0x00000204
+#define DDRSS_CTL_47_DATA 0x00000304
 #define DDRSS_CTL_48_DATA 0x00370008
 #define DDRSS_CTL_49_DATA 0x09090024
-#define DDRSS_CTL_50_DATA 0x00001910
+#define DDRSS_CTL_50_DATA 0x00002110
 #define DDRSS_CTL_51_DATA 0x00370008
 #define DDRSS_CTL_52_DATA 0x09090024
-#define DDRSS_CTL_53_DATA 0x09001910
+#define DDRSS_CTL_53_DATA 0x09002110
 #define DDRSS_CTL_54_DATA 0x000A0A09
 #define DDRSS_CTL_55_DATA 0x0400036D
 #define DDRSS_CTL_56_DATA 0x09092004
@@ -223,19 +224,19 @@
 #define DDRSS_CTL_206_DATA 0x00000000
 #define DDRSS_CTL_207_DATA 0x00000000
 #define DDRSS_CTL_208_DATA 0x00000024
-#define DDRSS_CTL_209_DATA 0x00000012
+#define DDRSS_CTL_209_DATA 0x0000001A
 #define DDRSS_CTL_210_DATA 0x00000000
 #define DDRSS_CTL_211_DATA 0x00000024
-#define DDRSS_CTL_212_DATA 0x00000012
+#define DDRSS_CTL_212_DATA 0x0000001A
 #define DDRSS_CTL_213_DATA 0x00000000
 #define DDRSS_CTL_214_DATA 0x00000004
 #define DDRSS_CTL_215_DATA 0x00000000
 #define DDRSS_CTL_216_DATA 0x00000000
 #define DDRSS_CTL_217_DATA 0x00000024
-#define DDRSS_CTL_218_DATA 0x00000012
+#define DDRSS_CTL_218_DATA 0x0000001A
 #define DDRSS_CTL_219_DATA 0x00000000
 #define DDRSS_CTL_220_DATA 0x00000024
-#define DDRSS_CTL_221_DATA 0x00000012
+#define DDRSS_CTL_221_DATA 0x0000001A
 #define DDRSS_CTL_222_DATA 0x00000000
 #define DDRSS_CTL_223_DATA 0x00000000
 #define DDRSS_CTL_224_DATA 0x00000031
@@ -268,21 +269,21 @@
 #define DDRSS_CTL_251_DATA 0x00000000
 #define DDRSS_CTL_252_DATA 0x00000000
 #define DDRSS_CTL_253_DATA 0x00000000
-#define DDRSS_CTL_254_DATA 0x46004646
-#define DDRSS_CTL_255_DATA 0x00002746
-#define DDRSS_CTL_256_DATA 0x00000027
-#define DDRSS_CTL_257_DATA 0x00000027
-#define DDRSS_CTL_258_DATA 0x00000027
-#define DDRSS_CTL_259_DATA 0x00000027
-#define DDRSS_CTL_260_DATA 0x00000027
+#define DDRSS_CTL_254_DATA 0x44004444
+#define DDRSS_CTL_255_DATA 0x00004D44
+#define DDRSS_CTL_256_DATA 0x0000004D
+#define DDRSS_CTL_257_DATA 0x0000004D
+#define DDRSS_CTL_258_DATA 0x0000004D
+#define DDRSS_CTL_259_DATA 0x0000004D
+#define DDRSS_CTL_260_DATA 0x0000004D
 #define DDRSS_CTL_261_DATA 0x00000000
 #define DDRSS_CTL_262_DATA 0x00000000
-#define DDRSS_CTL_263_DATA 0x0000000F
-#define DDRSS_CTL_264_DATA 0x0000000F
-#define DDRSS_CTL_265_DATA 0x0000000F
-#define DDRSS_CTL_266_DATA 0x0000000F
-#define DDRSS_CTL_267_DATA 0x0000000F
-#define DDRSS_CTL_268_DATA 0x0000000F
+#define DDRSS_CTL_263_DATA 0x0000004D
+#define DDRSS_CTL_264_DATA 0x0000004D
+#define DDRSS_CTL_265_DATA 0x0000004D
+#define DDRSS_CTL_266_DATA 0x0000004D
+#define DDRSS_CTL_267_DATA 0x0000004D
+#define DDRSS_CTL_268_DATA 0x0000004D
 #define DDRSS_CTL_269_DATA 0x00000000
 #define DDRSS_CTL_270_DATA 0x00001000
 #define DDRSS_CTL_271_DATA 0x00000015
@@ -388,13 +389,13 @@
 #define DDRSS_CTL_371_DATA 0x01000101
 #define DDRSS_CTL_372_DATA 0x01010001
 #define DDRSS_CTL_373_DATA 0x00010101
-#define DDRSS_CTL_374_DATA 0x01050503
+#define DDRSS_CTL_374_DATA 0x01070703
 #define DDRSS_CTL_375_DATA 0x05020201
 #define DDRSS_CTL_376_DATA 0x08080C0C
 #define DDRSS_CTL_377_DATA 0x00080308
-#define DDRSS_CTL_378_DATA 0x000B030E
-#define DDRSS_CTL_379_DATA 0x000B0310
-#define DDRSS_CTL_380_DATA 0x0B0B0810
+#define DDRSS_CTL_378_DATA 0x0009030E
+#define DDRSS_CTL_379_DATA 0x00090312
+#define DDRSS_CTL_380_DATA 0x09090806
 #define DDRSS_CTL_381_DATA 0x01000000
 #define DDRSS_CTL_382_DATA 0x03020301
 #define DDRSS_CTL_383_DATA 0x04000102
@@ -416,7 +417,7 @@
 #define DDRSS_CTL_399_DATA 0x00003690
 #define DDRSS_CTL_400_DATA 0x00007940
 #define DDRSS_CTL_401_DATA 0x070D0402
-#define DDRSS_CTL_402_DATA 0x00260405
+#define DDRSS_CTL_402_DATA 0x00260607
 #define DDRSS_CTL_403_DATA 0x00000C20
 #define DDRSS_CTL_404_DATA 0x00000200
 #define DDRSS_CTL_405_DATA 0x00000200
@@ -425,7 +426,7 @@
 #define DDRSS_CTL_408_DATA 0x00003690
 #define DDRSS_CTL_409_DATA 0x00007940
 #define DDRSS_CTL_410_DATA 0x070D0402
-#define DDRSS_CTL_411_DATA 0x00000405
+#define DDRSS_CTL_411_DATA 0x00000607
 #define DDRSS_CTL_412_DATA 0x00000000
 #define DDRSS_CTL_413_DATA 0x0302000A
 #define DDRSS_CTL_414_DATA 0x01000500
@@ -609,8 +610,8 @@
 #define DDRSS_PI_169_DATA 0x00020043
 #define DDRSS_PI_170_DATA 0x02000200
 #define DDRSS_PI_171_DATA 0x00000004
-#define DDRSS_PI_172_DATA 0x0000080C
-#define DDRSS_PI_173_DATA 0x00081C00
+#define DDRSS_PI_172_DATA 0x00000A0C
+#define DDRSS_PI_173_DATA 0x000A1C00
 #define DDRSS_PI_174_DATA 0x001C0000
 #define DDRSS_PI_175_DATA 0x00000013
 #define DDRSS_PI_176_DATA 0x00000059
@@ -624,15 +625,15 @@
 #define DDRSS_PI_184_DATA 0x01000100
 #define DDRSS_PI_185_DATA 0x00000100
 #define DDRSS_PI_186_DATA 0x00000000
-#define DDRSS_PI_187_DATA 0x05050503
+#define DDRSS_PI_187_DATA 0x05070703
 #define DDRSS_PI_188_DATA 0x01010C0C
 #define DDRSS_PI_189_DATA 0x01010101
 #define DDRSS_PI_190_DATA 0x000C0C0A
 #define DDRSS_PI_191_DATA 0x00000000
 #define DDRSS_PI_192_DATA 0x00000000
 #define DDRSS_PI_193_DATA 0x04000000
-#define DDRSS_PI_194_DATA 0x04020808
-#define DDRSS_PI_195_DATA 0x04040204
+#define DDRSS_PI_194_DATA 0x06020808
+#define DDRSS_PI_195_DATA 0x04040206
 #define DDRSS_PI_196_DATA 0x00090031
 #define DDRSS_PI_197_DATA 0x00110039
 #define DDRSS_PI_198_DATA 0x00110039
@@ -661,13 +662,13 @@
 #define DDRSS_PI_221_DATA 0x00001900
 #define DDRSS_PI_222_DATA 0x32000056
 #define DDRSS_PI_223_DATA 0x06000101
-#define DDRSS_PI_224_DATA 0x001D0204
-#define DDRSS_PI_225_DATA 0x32120058
+#define DDRSS_PI_224_DATA 0x001F0204
+#define DDRSS_PI_225_DATA 0x72400056
 #define DDRSS_PI_226_DATA 0x05000101
-#define DDRSS_PI_227_DATA 0x001D0408
-#define DDRSS_PI_228_DATA 0x32120058
+#define DDRSS_PI_227_DATA 0x001F0608
+#define DDRSS_PI_228_DATA 0x72400056
 #define DDRSS_PI_229_DATA 0x05000101
-#define DDRSS_PI_230_DATA 0x00000408
+#define DDRSS_PI_230_DATA 0x00000608
 #define DDRSS_PI_231_DATA 0x05040900
 #define DDRSS_PI_232_DATA 0x00060900
 #define DDRSS_PI_233_DATA 0x00000315
@@ -741,23 +742,23 @@
 #define DDRSS_PI_301_DATA 0x00000000
 #define DDRSS_PI_302_DATA 0x00000000
 #define DDRSS_PI_303_DATA 0x00000000
-#define DDRSS_PI_304_DATA 0x00100F27
+#define DDRSS_PI_304_DATA 0x00104D4D
 #define DDRSS_PI_305_DATA 0x00000000
 #define DDRSS_PI_306_DATA 0x00000024
-#define DDRSS_PI_307_DATA 0x00000012
+#define DDRSS_PI_307_DATA 0x0000001A
 #define DDRSS_PI_308_DATA 0x000000B1
 #define DDRSS_PI_309_DATA 0x00000000
 #define DDRSS_PI_310_DATA 0x00000000
-#define DDRSS_PI_311_DATA 0x46000000
-#define DDRSS_PI_312_DATA 0x00150F27
+#define DDRSS_PI_311_DATA 0x44000000
+#define DDRSS_PI_312_DATA 0x00154D4D
 #define DDRSS_PI_313_DATA 0x00000000
 #define DDRSS_PI_314_DATA 0x00000024
-#define DDRSS_PI_315_DATA 0x00000012
+#define DDRSS_PI_315_DATA 0x0000001A
 #define DDRSS_PI_316_DATA 0x000000B1
 #define DDRSS_PI_317_DATA 0x00000000
 #define DDRSS_PI_318_DATA 0x00000000
-#define DDRSS_PI_319_DATA 0x46000000
-#define DDRSS_PI_320_DATA 0x00150F27
+#define DDRSS_PI_319_DATA 0x44000000
+#define DDRSS_PI_320_DATA 0x00154D4D
 #define DDRSS_PI_321_DATA 0x00000000
 #define DDRSS_PI_322_DATA 0x00000004
 #define DDRSS_PI_323_DATA 0x00000000
@@ -765,23 +766,23 @@
 #define DDRSS_PI_325_DATA 0x00000000
 #define DDRSS_PI_326_DATA 0x00000000
 #define DDRSS_PI_327_DATA 0x00000000
-#define DDRSS_PI_328_DATA 0x00100F27
+#define DDRSS_PI_328_DATA 0x00104D4D
 #define DDRSS_PI_329_DATA 0x00000000
 #define DDRSS_PI_330_DATA 0x00000024
-#define DDRSS_PI_331_DATA 0x00000012
+#define DDRSS_PI_331_DATA 0x0000001A
 #define DDRSS_PI_332_DATA 0x000000B1
 #define DDRSS_PI_333_DATA 0x00000000
 #define DDRSS_PI_334_DATA 0x00000000
-#define DDRSS_PI_335_DATA 0x46000000
-#define DDRSS_PI_336_DATA 0x00150F27
+#define DDRSS_PI_335_DATA 0x44000000
+#define DDRSS_PI_336_DATA 0x00154D4D
 #define DDRSS_PI_337_DATA 0x00000000
 #define DDRSS_PI_338_DATA 0x00000024
-#define DDRSS_PI_339_DATA 0x00000012
+#define DDRSS_PI_339_DATA 0x0000001A
 #define DDRSS_PI_340_DATA 0x000000B1
 #define DDRSS_PI_341_DATA 0x00000000
 #define DDRSS_PI_342_DATA 0x00000000
-#define DDRSS_PI_343_DATA 0x46000000
-#define DDRSS_PI_344_DATA 0x00150F27
+#define DDRSS_PI_343_DATA 0x44000000
+#define DDRSS_PI_344_DATA 0x00154D4D
 #define DDRSS_PHY_0_DATA 0x04F00000
 #define DDRSS_PHY_1_DATA 0x00000000
 #define DDRSS_PHY_2_DATA 0x00030200
@@ -856,8 +857,8 @@
 #define DDRSS_PHY_71_DATA 0x00000000
 #define DDRSS_PHY_72_DATA 0x041F07FF
 #define DDRSS_PHY_73_DATA 0x00000000
-#define DDRSS_PHY_74_DATA 0x01CC0B01
-#define DDRSS_PHY_75_DATA 0x1003CC0B
+#define DDRSS_PHY_74_DATA 0x01FF0B01
+#define DDRSS_PHY_75_DATA 0x1003FF0B
 #define DDRSS_PHY_76_DATA 0x20000140
 #define DDRSS_PHY_77_DATA 0x07FF0200
 #define DDRSS_PHY_78_DATA 0x0000DD01
@@ -872,7 +873,7 @@
 #define DDRSS_PHY_87_DATA 0x02020010
 #define DDRSS_PHY_88_DATA 0x51516041
 #define DDRSS_PHY_89_DATA 0x31C06000
-#define DDRSS_PHY_90_DATA 0x07AB0340
+#define DDRSS_PHY_90_DATA 0x06B60340
 #define DDRSS_PHY_91_DATA 0x0000C0C0
 #define DDRSS_PHY_92_DATA 0x04050000
 #define DDRSS_PHY_93_DATA 0x00000504
@@ -1112,8 +1113,8 @@
 #define DDRSS_PHY_327_DATA 0x00000000
 #define DDRSS_PHY_328_DATA 0x041F07FF
 #define DDRSS_PHY_329_DATA 0x00000000
-#define DDRSS_PHY_330_DATA 0x01CC0B01
-#define DDRSS_PHY_331_DATA 0x1003CC0B
+#define DDRSS_PHY_330_DATA 0x01FF0B01
+#define DDRSS_PHY_331_DATA 0x1003FF0B
 #define DDRSS_PHY_332_DATA 0x20000140
 #define DDRSS_PHY_333_DATA 0x07FF0200
 #define DDRSS_PHY_334_DATA 0x0000DD01
@@ -1128,7 +1129,7 @@
 #define DDRSS_PHY_343_DATA 0x02020010
 #define DDRSS_PHY_344_DATA 0x51516041
 #define DDRSS_PHY_345_DATA 0x31C06000
-#define DDRSS_PHY_346_DATA 0x07AB0340
+#define DDRSS_PHY_346_DATA 0x06B60340
 #define DDRSS_PHY_347_DATA 0x0000C0C0
 #define DDRSS_PHY_348_DATA 0x04050000
 #define DDRSS_PHY_349_DATA 0x00000504
@@ -1326,7 +1327,7 @@
 #define DDRSS_PHY_541_DATA 0x003F0000
 #define DDRSS_PHY_542_DATA 0x000F013F
 #define DDRSS_PHY_543_DATA 0x0000000F
-#define DDRSS_PHY_544_DATA 0x020002CC
+#define DDRSS_PHY_544_DATA 0x020002FF
 #define DDRSS_PHY_545_DATA 0x00030000
 #define DDRSS_PHY_546_DATA 0x00000300
 #define DDRSS_PHY_547_DATA 0x00000300
@@ -1582,7 +1583,7 @@
 #define DDRSS_PHY_797_DATA 0x00000000
 #define DDRSS_PHY_798_DATA 0x000F0000
 #define DDRSS_PHY_799_DATA 0x0000000F
-#define DDRSS_PHY_800_DATA 0x020002CC
+#define DDRSS_PHY_800_DATA 0x020002FF
 #define DDRSS_PHY_801_DATA 0x00030000
 #define DDRSS_PHY_802_DATA 0x00000300
 #define DDRSS_PHY_803_DATA 0x00000300
@@ -1838,7 +1839,7 @@
 #define DDRSS_PHY_1053_DATA 0x10000000
 #define DDRSS_PHY_1054_DATA 0x000F0000
 #define DDRSS_PHY_1055_DATA 0x0000000F
-#define DDRSS_PHY_1056_DATA 0x020002CC
+#define DDRSS_PHY_1056_DATA 0x020002FF
 #define DDRSS_PHY_1057_DATA 0x00030000
 #define DDRSS_PHY_1058_DATA 0x00000300
 #define DDRSS_PHY_1059_DATA 0x00000300
@@ -2169,22 +2170,22 @@
 #define DDRSS_PHY_1384_DATA 0x00000300
 #define DDRSS_PHY_1385_DATA 0x00000300
 #define DDRSS_PHY_1386_DATA 0x00000300
-#define DDRSS_PHY_1387_DATA 0x3183BF77
+#define DDRSS_PHY_1387_DATA 0x31833F77
 #define DDRSS_PHY_1388_DATA 0x00000000
-#define DDRSS_PHY_1389_DATA 0x0C000DFF
-#define DDRSS_PHY_1390_DATA 0x30000DFF
-#define DDRSS_PHY_1391_DATA 0x3F0DFF11
-#define DDRSS_PHY_1392_DATA 0x01990000
-#define DDRSS_PHY_1393_DATA 0x780DFFCC
+#define DDRSS_PHY_1389_DATA 0x0C000DBF
+#define DDRSS_PHY_1390_DATA 0x30000DBF
+#define DDRSS_PHY_1391_DATA 0x3F0DBF11
+#define DDRSS_PHY_1392_DATA 0x01FF0000
+#define DDRSS_PHY_1393_DATA 0x780DBFFF
 #define DDRSS_PHY_1394_DATA 0x00000C11
 #define DDRSS_PHY_1395_DATA 0x00018011
 #define DDRSS_PHY_1396_DATA 0x0089FF00
 #define DDRSS_PHY_1397_DATA 0x000C3F11
-#define DDRSS_PHY_1398_DATA 0x01990000
-#define DDRSS_PHY_1399_DATA 0x000C3F11
-#define DDRSS_PHY_1400_DATA 0x01990000
-#define DDRSS_PHY_1401_DATA 0x3F0DFF11
-#define DDRSS_PHY_1402_DATA 0x01990000
+#define DDRSS_PHY_1398_DATA 0x01FF0000
+#define DDRSS_PHY_1399_DATA 0x000C3F91
+#define DDRSS_PHY_1400_DATA 0x01FF0000
+#define DDRSS_PHY_1401_DATA 0x3F0DBF11
+#define DDRSS_PHY_1402_DATA 0x01FF0000
 #define DDRSS_PHY_1403_DATA 0x00018011
 #define DDRSS_PHY_1404_DATA 0x0089FF00
 #define DDRSS_PHY_1405_DATA 0x20040004
-- 
2.25.1

