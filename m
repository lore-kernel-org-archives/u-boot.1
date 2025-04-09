Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8A1C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 18:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E9782A27;
	Wed,  9 Apr 2025 20:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D4z13nt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB7682A31; Wed,  9 Apr 2025 20:25:06 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088FB82A0D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 20:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 539IP13Z901666
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Apr 2025 13:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744223102;
 bh=hdFVnlWKBMoGLecHILxf0MSuyzGB3QjyrCaxttuA1xU=;
 h=From:Date:Subject:To:CC;
 b=D4z13nt1rczqErd066T061wsm90cYXmGwk/42sjRRbCpVmuezb3JIw1YBl+3Ibduj
 ADADjaSUXIUBuirFTFJzfkO59LuYfiNsyZKDrxSuyMhIGc9FqRdbnSyuWOEs78BZns
 c6syuq2B0YvXDjslZKKJVGI3RUZWH0KoYOoXujRU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 539IP16m122351
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Apr 2025 13:25:01 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Apr 2025 13:25:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Apr 2025 13:25:01 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 539IP1av081869;
 Wed, 9 Apr 2025 13:25:01 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 9 Apr 2025 13:25:00 -0500
Subject: [PATCH] arm: mach-k3: am62ax: fix MCU_CLKOUT0 parent clock mux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250409-r5-eth-fix-v1-1-9b73667f304f@ti.com>
X-B4-Tracking: v=1; b=H4sIAHu79mcC/x2MQQqAIBAAvyJ7bmGVPNhXooPVmnux0IhA/HvSc
 QZmKhTOwgUmVSHzI0XO1EEPCrbo08Eoe2cwZCyN5DBb5DtikBc1hcCOvOPVQg+uzF3/s3lp7QN
 9jGJZXAAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Parth Pancholi <parth.pancholi@toradex.com>, Bryan
 Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Much like what was fixed on the AM62x and AM62Px platforms[0]. The
CU_CLKOUT0 has two (25mhz and 50mhz) mux options however the clock
structure incorrectly duplicated the first 50mhz option twice. Fix this
for the AM62A platforms so the 25mhz option is selectable.

[0] https://lore.kernel.org/all/20250408161211.3165588-1-parth105105@gmail.com/

Reported-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/r5/am62ax/clk-data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62ax/clk-data.c b/arch/arm/mach-k3/r5/am62ax/clk-data.c
index d950b35e0beb7..85b39a0655add 100644
--- a/arch/arm/mach-k3/r5/am62ax/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62ax/clk-data.c
@@ -64,7 +64,7 @@ static const char * const sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents[] = {
 
 static const char * const clkout0_ctrl_out0_parents[] = {
 	"hsdiv4_16fft_main_2_hsdivout1_clk",
-	"hsdiv4_16fft_main_2_hsdivout1_clk",
+	"hsdiv4_16fft_main_2_hsdivout1_clk10",
 };
 
 static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
@@ -180,6 +180,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout1_clk", "pllfracf_ssmod_16fft_main_1_foutvcop_clk", 0x681084, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout1_clk", "pllfracf_ssmod_16fft_main_2_foutvcop_clk", 0x682084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout1_clk10", "pllfracf_ssmod_16fft_main_2_foutvcop_clk", 0x682084, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout0_clk", "pllfracf_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040080, 0, 7, 0, 0),
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_main_0_sysclkout_clk", sam62_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
@@ -272,7 +273,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(146, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 20, "clkout0_ctrl_out0"),
 	DEV_CLK(157, 21, "hsdiv4_16fft_main_2_hsdivout1_clk"),
-	DEV_CLK(157, 22, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 22, "hsdiv4_16fft_main_2_hsdivout1_clk10"),
 	DEV_CLK(157, 24, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 25, "board_0_ddr0_ck0_out"),
 	DEV_CLK(157, 40, "mshsi2c_main_0_porscl"),

---
base-commit: 9d9fbdab0e9664bff147109cc89ad2786f6ecd83
change-id: 20250409-r5-eth-fix-10ffe90a9eb5

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

