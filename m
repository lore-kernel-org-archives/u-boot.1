Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F57C369AB
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 00:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703E38329B;
	Sat, 19 Apr 2025 02:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="JZ+7utkf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E39782A8D; Fri, 18 Apr 2025 23:04:46 +0200 (CEST)
Received: from sonic303-3.consmr.mail.bf2.yahoo.com
 (sonic303-3.consmr.mail.bf2.yahoo.com [74.6.131.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B3B825A6
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 23:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010282; bh=sT3Zse83xBrXg5iPVY3dtt7XNtosr/g7crQ9seDSc18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=JZ+7utkfaNxaPFl+U99weDh+ekcI+KNi7YKzox32O2fcbkfslWGZi2dWwOWGGQdRrpd49ybKs6HKz+or4doFwKM2B/i048HuxN1eFZkaBsGexdfd67iFIYpVDqsb+zmX6kHFPNyVzjtdi03ZlaT17oIVlIHu16V5UN7kvnTKjpoNa4jd3bpU0blgIycyx9ogExVvNihabtyLSedB7RuDVpnibGxYiaESwKVBxYUlIx6yrPGeOpZrXa6h8bufqS/yFJaLz7bYK3uHzsYTGwEKk8Nm/KarFJVgBtnHzlLkOqUrXeO2FdJAXQTmKJXtq3h4X0Ctqty7FM8AoAUoB+bjDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010282; bh=cw1A7kuTnbBSAmWBzP5GhWaVA+swh/cNx4ZtAHhs3yN=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=GVopNgB/L1raSHNuQ18Z70QiOmYpaclISAT9mTWVXMODwdyxV4115kcoT7MPHtvKG5kD44BcypNxNstaPSoxko5oo5wZ23c0tP6aVncxvP4Losz6gggNQXgIo4OGd90skV8P+EHOx1tkMQhNMd2wmecopG4oRt5EmzcwvDnUNxD8myB6NAgKWYwR60vLucmw1WV0Z5muixwsGZ3Tn2eY744vUDfj41sN3lSdP1U4Pkc5PgKxQyV6w2y8wQG4eHie8Nm/gp2vzcYzmwxuLhQXY89PZwIkud8Qsl3gd78VwxHyprX8NdKM/mza8vaF/YTkaycxdmmEI1pSIfCkMhqRyw==
X-YMail-OSG: IBB38RoVM1mAX8tfHUi2bQ.ZYQFlxRy2gVU6fHKpUrDa21vJERNi6C8cwyoo9Hx
 4vH5B0XnTSAW3SiUeIrESO1dSw7Pg0x_zb5MtCm1vswqJQs6OGih5x_.8ZnNy5dvTPM9_CvBGpfD
 B8Ls3ZX07nQL0PYDbG3ORDu2LOkOk7WdBP8hzc_bDBbJIa.qyxdQTc.vUmT9TbBJ3nxlK_rAHeFP
 teXD4oF5f9LheCG2wMgnYb4NbrrnR.zY4S9ovfBaJ09r8cU8WZ.V9xeFl5G.mTcrSvr4N2coP1ZM
 CgVY0BWMjLBhB.4E5frvfbInlXUgq49sxr7D0Iwxk_n38Jykr8nj.LVYLH2cWISbbACFxf9N014o
 AsInqUi6vsjehYvAMrmlrmfJ2YgYQ8HGcrt910pwA3wtC2E8VBFicEUUx3hLMQFyCPFhOK.sI5mq
 pfZz8Qy5bdhbEBjXkDSYnYzBvXwfX9.Iwg8JN6ANaCfOVEY1AGH9B07Bra09lMC6Z0vU11Iee2Qu
 sMsSuB6JCVXNnZ0i6Cey2Gc2dhZNq6gCcRwdxYCz69ounEsOLKzT3Dm9MYYy0F2n635LXiei4e.7
 ozb6MwtFVBEpNWLpMHC25srNdBdD5zdvCxbVCvvbtz6gECEZD_ewmUw79QMpT9RFL0f1tQCDzf7Z
 fq0NAk1x6.JGcihDCMCkkfp1GO_uB.VfQSF0.dHZfr.Wo3wwaB_qZEi6pNv0aIah7eYMFS1SxmtV
 eZIEvj9nbR4tBKHy85iEVsQ2O7xT.upvqkEFpSccmC8iad3lFjkUauuqdezbPMk9rvkIjbHBqKPM
 B7WIVjsmYkgrUnNHiM1AiDoLkG0P45CbF5DwGootS4RqB3W72NEU.xfMW.t5hcyyJIEi1nYIKLBE
 MG8GhZ1YFwzIVpd1Ko4.ceclUttOeb6sxX51_Bw44zjwxnEjrx6m5Z5H8irFekDr6PXObF2YYs.w
 abm1Y6QteYWu3b0aogQjFLrDPGkvIKITlGNo.2MowsDt0Uqo7yNJaS.gOHJD0i0ehZxyhVEP_zcQ
 8n4VxzGZ2EDA_AB5eMSlItkBJ3yjMiolMMbJ7wKciczyMR4RL.yUrF5DDCDiON0iYZ1rH.zU6g2i
 bTScq5_QqhodfFQ.pgB645uTgXWBBdTflZMDALxdvQ2_vV3pClEL7OA2_uSF7xn5x9Z5mrWwIUjQ
 eAn92n57R_cKSCtjUdJZAZoV62PLTHaDZlWvjDkEwKnkkFvkvlynFy.VXFDUl.RyBwQDBjknnVg2
 JQ4T_2g2Yi7O9_erujt8i13K5OqeKzP1bpinPDgvvQFZazkP1rhbfwfE03S6YsVdqdWEQ5dBujLV
 O6YxBy.qRtqBdrmqhb4F.C3paYB2rRJSbdENtDgLKMekuUEjsLy1osqPIX_TNqXgmQHnBUlLFcC6
 EtpX3t9yUjxNiiv4Lzia.iw3R0IKYcn7pUTK_EuuXOvf9WvRV.EEzXV2J2QEJJSPNi4RfeplzW6s
 Mly8ykjLrRalHLOLr2KHKTTY.3w9Mvfp3IjpG6vSyy8zNex4vawu937Is5G6ZElKg4xtMpc.e_Ai
 R_Ix5sNMn0puBi2p6EZV42ltcO12GVCHqHQA3h.S8nzZHarJ_OIoukefaNU9Uonsu9TmeUr1EfBZ
 wehRYX4sQchdr.cW6BySpcnzLe2dYPY2eVNK4MyyigHHjhjjgqaEfVHlAhzXXgMwEoj9dr24zUpN
 XKBm2ZjX_5oZS4Xc6d07SRZXytqfAEJ0T8r8wSLM2vNHnamYhBXuV7fYfxN6f._WXH.rbd0jMBX1
 K5M4JIdsA1Umm9f2K1UEoksCd4J4zaucXP0y2rZR8hHb1eyYO0uAKvMimyrKlYhAgSQNd_bD0pS.
 WDygF0FvW_0tmCDSRwuCFaYo_mfbhC3xbPoVmho9p291lfSTsNRpj9uZCdhLwRthVvEdc0B6yJX3
 o2JHGrxDDUrFzs4.3Tp5Ls6asowpQEB8ijywk.aBiJZnvJl7JBmJVfWAuOtlTwQfzAXscm.9ZQ6L
 E3EWkgqhzFTOWrdCD7Vca3kWl.5h6Q.Pj9ghpQ1k8s.IjDNuUctSvYk1EVHgKaUgzL7sOGo4.HAg
 vf7GpprpQUmRiEYPtPbwB3408cxivMmPtUtlt_3mXsAZC1dJu4T9SCDIOu7Dg9RBIqUh.kcVVi8w
 WWuryqFGsmEoIB1TKVLr3LGB5gVKFYOyfpySYpG6qkXuwdCvYTSV0x_TTvBGfQbUrwvBEFbgH_ei
 xYia81ra6qnbSaFe1fxKp_2gKYCrYnwIcWNFpKgyLsPvD8lvJxwnioivoYHezMv_A
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 934ddd24-54d9-415d-8667-b639e2e6e0db
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Apr 2025 21:04:42 +0000
Received: by hermes--production-ne1-9495dc4d7-lc7tc (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c5964cebeedf5fd09ef8915e6b0d5c48; 
 Fri, 18 Apr 2025 21:04:37 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Haibo Chen <haibo.chen@nxp.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: Jonathan Currier <dullfire@yahoo.com>
Subject: [RFC PATCH 2/3] spi: fspi: Add imxrt1170 device data
Date: Fri, 18 Apr 2025 16:04:29 -0500
Message-ID: <20250418210430.27458-3-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250418210430.27458-1-dullfire@yahoo.com>
References: <20250418210430.27458-1-dullfire@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Apr 2025 02:13:29 +0200
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

Add the device specific driver data, the device tree entry, and the
clock configuration.

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 arch/arm/dts/imxrt1170-evk.dts              | 28 +++++++++++++++++++++
 arch/arm/dts/imxrt1170.dtsi                 | 13 ++++++++++
 drivers/clk/imx/clk-imxrt1170.c             |  9 +++++++
 drivers/spi/nxp_fspi.c                      | 10 ++++++++
 include/dt-bindings/clock/imxrt1170-clock.h |  4 ++-
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imxrt1170-evk.dts b/arch/arm/dts/imxrt1170-evk.dts
index 0d8e7016860..354352477c7 100644
--- a/arch/arm/dts/imxrt1170-evk.dts
+++ b/arch/arm/dts/imxrt1170-evk.dts
@@ -234,6 +234,34 @@
 					(IMX_PAD_SION | 8)	/* SEMC_DQS */
 			>;
 		};
+
+		pinctrl_flexspi1: flexspi1grp {
+			fsl,pins = <
+				IOMUXC_GPIO_SD_B2_05_FLEXSPI1_A_DQS     0xa
+				IOMUXC_GPIO_SD_B2_06_FLEXSPI1_A_SS0_B   0xa
+				IOMUXC_GPIO_SD_B2_07_FLEXSPI1_A_SCLK    0xa
+				IOMUXC_GPIO_SD_B2_08_FLEXSPI1_A_DATA00  0xa
+				IOMUXC_GPIO_SD_B2_09_FLEXSPI1_A_DATA01  0xa
+				IOMUXC_GPIO_SD_B2_10_FLEXSPI1_A_DATA02  0xa
+				IOMUXC_GPIO_SD_B2_11_FLEXSPI1_A_DATA03  0xa
+			>;
+		};
+	};
+};
+
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <250000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 	};
 };
 
diff --git a/arch/arm/dts/imxrt1170.dtsi b/arch/arm/dts/imxrt1170.dtsi
index 2de775f043f..08665eaf06a 100644
--- a/arch/arm/dts/imxrt1170.dtsi
+++ b/arch/arm/dts/imxrt1170.dtsi
@@ -246,6 +246,19 @@
 			#interrupt-cells = <2>;
 		};
 
+		flexspi1: spi@400cc000 {
+			compatible = "nxp,imxrt1170-fspi";
+			reg = <0x400cc000 0x800>, <0x30000000 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <130>;
+			clocks = <&clks IMXRT1170_CLK_DUMMY>,
+				<&clks IMXRT1170_CLK_FLEXSPI1>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
+
 		gpt1: gpt1@400ec000 {
 			compatible = "fsl,imxrt-gpt";
 			reg = <0x400ec000 0x4000>;
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 88a294f4165..440fb0b001d 100644
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
 	       imx_clk_divider("lpuart1", "lpuart1_sel",
 			       base + (25 * 0x80), 0, 8));
 
+	clk_dm(IMXRT1170_CLK_FLEXSPI1_SEL,
+	       imx_clk_mux("flexspi1_sel", base + (20 * 0x80), 8, 3,
+			   flexspi1_sels, ARRAY_SIZE(flexspi1_sels)));
+	clk_dm(IMXRT1170_CLK_FLEXSPI1,
+	       imx_clk_divider("flexspi1", "flexspi1_sel",
+			       base + (20 * 0x80), 0, 8));
+
 	clk_dm(IMXRT1170_CLK_USDHC1_SEL,
 	       imx_clk_mux("usdhc1_sel", base + (58 * 0x80), 8, 3,
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
 
diff --git a/include/dt-bindings/clock/imxrt1170-clock.h b/include/dt-bindings/clock/imxrt1170-clock.h
index 8ab8018a15e..d3d21cf310d 100644
--- a/include/dt-bindings/clock/imxrt1170-clock.h
+++ b/include/dt-bindings/clock/imxrt1170-clock.h
@@ -43,6 +43,8 @@
 #define IMXRT1170_CLK_GPT1			33
 #define IMXRT1170_CLK_SEMC_SEL			34
 #define IMXRT1170_CLK_SEMC			35
-#define IMXRT1170_CLK_END			36
+#define IMXRT1170_CLK_FLEXSPI1_SEL		36
+#define IMXRT1170_CLK_FLEXSPI1			37
+#define IMXRT1170_CLK_END			38
 
 #endif /* __DT_BINDINGS_CLOCK_IMXRT1170_H */
-- 
2.45.3

