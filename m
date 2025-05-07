Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E74C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78ADB81F66;
	Wed,  7 May 2025 10:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="gcDV5QWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6212C8215B; Wed,  7 May 2025 10:36:36 +0200 (CEST)
Received: from sonic303-20.consmr.mail.ne1.yahoo.com
 (sonic303-20.consmr.mail.ne1.yahoo.com [66.163.188.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224C18007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606992; bh=hg/5GjSkLW3Um8tQXjQmT/HyA6Amlh54HYcIEbP66EQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=gcDV5QWTL3nfwOu92ZtHtQan9LQTK5J9TIlmc9356wrcgtTnVX/UDa7MqycGayJXGORK9dis2S6JV52kTL/8uO1uX+fVptrQ0HVZByWi2gPdhT7HGiErMIw2a4Mw3CmM6P/AW8LU1Tk2md/rMIGZVQ76A5lQ/uu87ZKuWtLR0GUI7ID82YMyU2nsn2xNG08ouyelzkiuwp4tMXOIjr06+dIXrWvk5mE0QrJ4BU0plTpBIly36d2b7sLW588tyhGP2CL4XxibCEpm18DdZRD9M6QU/AtCquq7MnIdtFfiI1K2lVTR34afFBJWPe2fhAhuN+hKplakhZ0ObR/BwqYELg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606992; bh=jIaNZcIpRgKXL7dEEwVejtLivv1HPuD6OhcueLVxbbx=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=KfjGgxUyABuKQxrY7DSOJ/RecWmB8pZtoQZ+7/m63e2XXxWxYCUj9tZgk5THGpAhcAY1wfEEi99BQnDdta4QnVyWE77X3E3dkBnRD3hlbVkPPjIhpZOVdMO8MnHugDaLiyJW0bypRv6I7Fv7Kingp4uYBgjrXY+wFGpHWY/U5nAQAsArwQ0v33+o14qEeTqrpqoi6Rabgf8p8pmoNfe7oSy6Koz2qpLzxOtNuoT/6597fhf/OvOGaM0I8UO33zDw1x+dnnNKtpIhu7roDkSVIenhe1a6Zc2xeEtNlq3dxprHFGdchRjQYrcBai5WdilElEFYkJTSJ3bfMEKxp83S1A==
X-YMail-OSG: LaHr_8EVM1mnoNzywRwRS8t.7UJG7avIAexlQZ3mqu68me._Vaq8LmKGDJfJ5J1
 p_Pfo17nzgrJ57F2kTJAzZP2vNowdVC0juuJmpQr7JBoI0Kun5woYyMh0tVgG6izquccX5gS3AXs
 B9ysZRXHl7zFQKTuVrV4ZzuyY75A6_OdCq6N1kjXgDz8s4MRNJ8HGXoWTPpvwO2JjWjwuofZlxy0
 K57X0wQjpeRbHAwvqSmQEVB7zr3jMbP_6bVUTEAP1z_D0L5vWQ.Hcq1.QiyiGqKT3IcFaA7EYPDt
 KvhC.4sxZCU9FLn0cyBes1pYR6gLb_V77yj4MtzCGTOCPANrokC_So625miOURaHYRuk4T7jF4pr
 QN2IXJtmd38LttW3Cu9MSAFPrqsQ2LGs5QFrWHVGiywNKHuS6g71cW6ce6JaG2vRPA1kzQtnikQE
 xI0RCaJoLcXnkaJOuGLL4KgR6Bui7gUKiy2Il07MC_VUI8Ew5MLtAf94ghbZz2fDqOOxZ3Bo0gIx
 MOtRYoy.GEquwY0e0IzILqlQAaD9x.62CV7yHQmIf9w4OzuoWncAcmBVbAQdO6MWId.snkmWhs8D
 VjXmgBaPp8vFcTrxtlKcVdLhc6OR702yen_cWLFTKDem4CEAHMqq3LPuAoYThD6zZJBDk0LPTaWU
 ca2kKJGGq2sSLExWpbF8WYCe6X7rTrkJ4NpamCdYpgP3oXUYTdLCL9yhpiAREA0fwAiWoru2x04N
 Lz6UVfboFjs5WfjfhaJoPeJ2EzO9h5DuZsfi01u_nMdI8hNfN6vd6NzL1uB.nIByjl4_jFAgDU4w
 bdgLjmJYqW9LRL9q_A57BbS_jqI63knzKHnHhUonlALWJf75xbp9exnk6SMdxJsNkD8U8ywZ9xiu
 zRvE8UsOhB7cS5RtCC3INC5XPOkKqR_TguOHMpVIx9JfFazV7TXtrUTuYR7epf2RQqzCfNYORyHz
 04i9bXlgL9bzzxq7AAI91NFm8VY6KNAzXoxN5S5_IFyy0BqAgilzTN_7T93aCohQQwDWv27MWqWK
 1oBkJJ9imbuORA38rxQJwIykcX.YRAw1PWDWtNUAQuXrAJqBHIGV7XvcHaTfgFY88GTpxy6xVh1B
 p1FCXR8bU.U3l48VWC4ULr_QdsVGiVLE5Wii4Llsh9q2QMvyLuaHn3Hqa78cHZvI60XY44u1OOIq
 WISqlMyTcPPlNyVFUawzfQxKTkaVpWo2s0jQzGgWEnlwgYBDBV.rWxYJh0kJmJ9CEX3axkswt_cI
 xHue8aq5KLo_tzRqT1AJSZeaDUenanDC1z71jEs.Jf1ro4qGJIaaJk17ajE2mXT37H2IkZDvmm7l
 .fXIXn6vQyyEZfSsMkaccg_.um0e0MFxOqi6DPlpgrj6DAS4cnKMwPnCtLTTkzIUvDN20JkElOWP
 4q0JyxeYdqKn4MceqNi4XhP0QB8YIscZVm1iSluKgl1c0Lv94OQkOK1HxsP9r3_C0G9lQWUClCQx
 weD0vO0wU.eRwdNbNMwrlzyAETOgo_OQ_QjgaJ8GXJXsSwBOv.pl.hIA5pmK8y01budKHGmtJ9ba
 a.H8Apm7CMhWbpgvd4MrEbJeimJM_IbiyV06gqo3Hq8oIuNfrnVtjEip.UdmZF2d8g9ji5gEzGE.
 NGgQuQsjXVCu.NwoTONYko1IlSRxi.UiYqPn0E7LCXd41_cBLIgFM3gDGvzWGbgQC5_3viMoOhbp
 pVS6tQBRxlygC27RAt379E360atsEXanXKUCnI.uuuoUK87MB6fn5Sudae7XFx7jhFu4plIvBCCs
 GiEjvHCjfEH0o7jbd0fK3GwRKiuCq5Ia.tXVn8lzJKB2ATbNdLMbMpXH1tjTkqE.QKZzaPbuPaJf
 zvtuxXChR7nOq9RyDQmFBT1cQUW22ucMEpyjTblsdLWsh1lZsrLL41xNsiQsvT2zq9oyAnLsD7Ws
 gHM0p3PFcyHdWx1cUsSgnObINYXSiew_wpIyRCh8h.6Gdp_k7M8Krz_mgfRC61buCKsQaMbVnqCh
 YB0bamKe04sEtAGB3Wk53BuWdX5XyiBJn._Os9xkzbuVcuHxomtvnf3C5AbmG5WOD9exxVAwWD2e
 wQ3Ro1mwUliQGklxHuAQly8GwSgNEb4SohH2lzzpjoE4lsZfL6dFbtbSW8b5lpV0d0_Zom_GP9GA
 9YT7p_1UKt1X4pgcuonRmL1LUX8R2e5vh4ZU963CyawNKHjw5zZh4jqp5kMMDQbGu1gDlr4Pdlrj
 xdXO2b0Wsv5fclhEpRQksbjrjrVxuvobJpNOkZGCaVffyG0lAlJBgH1bDBA--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: cd436b75-7ed8-4023-8a96-71f74b9bdb6a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:32 +0000
Received: by hermes--production-ne1-9495dc4d7-vqkqz (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 90ecdd06fd74475af2c0d3e1c8ff11ce; 
 Wed, 07 May 2025 08:36:29 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Mark Brown <broonie@kernel.org>, u-boot@lists.denx.de
Subject: [RFC PATCH v2 2/5] spi: fspi: Add imxrt1170 device data
Date: Wed,  7 May 2025 03:36:21 -0500
Message-ID: <20250507083625.6195-3-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250507083625.6195-1-dullfire@yahoo.com>
References: <20250507083625.6195-1-dullfire@yahoo.com>
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

Add the device specific driver data, and the clock configuration.

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/clk/imx/clk-imxrt1170.c |  9 +++++++++
 drivers/spi/nxp_fspi.c          | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 3f55d0d0127..bfd5dd6c464 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -105,6 +105,8 @@ static const char * const usdhc1_sels[] = {"rcosc48M_div2", "osc", "rcosc400M",
 "pll2_pfd2", "pll2_pfd0", "pll1_div5", "pll_arm"};
 static const char * const semc_sels[] = {"rcosc48M_div2", "osc", "rcosc400M", "rcosc16M",
 "pll1_div5", "pll2_sys", "pll2_pfd2", "pll3_pfd0"};
+static const char * const flexspi1_sels[] = {"rcosc48M_div2", "osc", "rcosc400M", "rcosc16M",
+"pll3_pdf0", "pll2_clk", "pll2_pfd2", "pll3_clk"};
 
 static int imxrt1170_clk_probe(struct udevice *dev)
 {
@@ -163,6 +165,13 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	       imx_clk_divider(dev, "lpuart1", "lpuart1_sel",
 			       base + (25 * 0x80), 0, 8));
 
+	clk_dm(IMXRT1170_CLK_FLEXSPI1_SEL,
+	       imx_clk_mux(dev, "flexspi1_sel", base + (20 * 0x80), 8, 3,
+			   flexspi1_sels, ARRAY_SIZE(flexspi1_sels)));
+	clk_dm(IMXRT1170_CLK_FLEXSPI1,
+	       imx_clk_divider(dev, "flexspi1", "flexspi1_sel",
+			       base + (20 * 0x80), 0, 8));
+
 	clk_dm(IMXRT1170_CLK_USDHC1_SEL,
 	       imx_clk_mux(dev, "usdhc1_sel", base + (58 * 0x80), 8, 3,
 			   usdhc1_sels, ARRAY_SIZE(usdhc1_sels)));
diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 3d0f659ecb2..95ad7fcff7f 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -328,6 +328,15 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static struct nxp_fspi_devtype_data imxrt1170_data = {
+	.rxfifo = SZ_256,
+	.txfifo = SZ_256,
+	.ahb_buf_size = SZ_4K,
+	.quirks = 0,
+	.lut_num = 16,
+	.little_endian = true,
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1061,6 +1070,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (ulong)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
+	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
 
-- 
2.45.3

