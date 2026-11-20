Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210C606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sn50dbiB;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYibhPtx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D31A81774;
	Fri, 20 Nov 2026 13:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0CinhgrEjMw; Fri, 20 Nov 2026 13:21:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 563F581765
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180902;
	b=EdKgFBREsKHNy4sxj+A5oqsodbAk/V4r/iGsXK9N5HoiDcQpzsDOeMfrz9DTcNeZK8Wi
	 h7WEdkKHYBYXoc4j01TwVZKcnoumjkNiWfSMlfa1z/PGDUwBrZOadAMHjIx2rDWeetL1R
	 41UBcQIjd8AVX8whTuHfRAbgSK/EGhWJnHGEwoHOmOX7hd4RJM42zhigRFljUUyN5FFR7
	 G3DWF2TVnj2t3U2DeEcOL+7RYafiQBMc9rkwU7gf18jDJX5Vp0MD9fmPi8+xbYPKKXSj3
	 6MuzT+xcE6s38I7BAABOmtwe7s42f+4rzoA7JESVi5XJapwYT8UkIgWdM/1knW6Gc0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l4K9aNDAXzlxVIlvvMl7TJRGXklOAca+gjHoc70DTzk=;
	b=G2Mt8hXYDv4fKOyKxx/yy+TKsQCTjfh0gj6lhqMrNznffxSm3ZkUtjXVsaMjXR98N8DF
	 n4puVJ9vuX6r/whA6jr1DKawla3kRs81qpFjGkpz/S7g2nKp3l2r/J+nF7oxfgAQr6LGJ
	 35z77550jmVj05GL4Fp4dLNK4TrLhQUWegKk9kWHRxO+dhgSIfCjjgWMeGxo27v/mG09E
	 140iFC26hcmolrV8X1tBbMjxonzWeBmBCIvtz+P1b6NMVxL6yYZ2J66fQQ0h2U+ba8qld
	 J/bUDXIaiP4b08crW+nEOYKxYMLV4ulpctZKC6t4nFJCfUduTz4TbudW2ibsx/+NAVw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xYibhPtx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180902;
	bh=l4K9aNDAXzlxVIlvvMl7TJRGXklOAca+gjHoc70DTzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sn50dbiBh/KVmJNoC9P/wx3u1O+79gBmmUEJJP5U2eOncECVYDuoU8JObj8m0Uupb
	 9HlwpsrRKJsqaQKFAMcYexNVi/ToZCxwkMAkQeW8nsifYspg+eWzcLh0BJIgm/2qmK
	 T2bksnq2INCgxN8fbkO7bL9nQ+Z/tO8183NtR8nKrEgI1ta4+ZL/Tsb9hHH9c1ihLR
	 r7y8k1EGplsHrjAytFqhcrpOxOp/iL4tgCw46Q3rRqb4tiuPoFE11AHWCbqWG7xUTK
	 5mdWtOmVbPoHPYf+7dUKtVUqsTi948UnMfKsTOyLlmyVGq0FOioyp1ymXnAFdAFjbu
	 rHhXcf6vm2myQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 563F581765;
	Fri, 20 Nov 2026 13:21:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CEC291E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5335814A0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SbRlCpg8G2oL for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF24581678
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=xYibhPtx
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF24581678
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:54 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so1271373f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173052; x=1795777852;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4K9aNDAXzlxVIlvvMl7TJRGXklOAca+gjHoc70DTzk=;
 b=xYibhPtx0bQwJfLTR6pUetS3fQvkimg32li2t+cWx/g9QSGB2/BKJUhQTU83z3Hggy
 wo9TF8QmPP0MUTjlxmF+RwcoMpJrT8WIWBK6RQnaUeH5K86gC8Y6hN8MtXAixpA2ZNnt
 x104KtDnX5bGl4cXe7+R9rxN0yq9aLKDcsu7hf6idpHyJ22QG3dejrbIIdlyNWMIEc80
 eSXz1pL5L+UcbUOZIIOEuLf6lEU3oL8JdfpuDKN8H6BwZ7wLZ+eULlC8TepXUrFiLUO8
 XHY6opI+QnzJT8Ys6xzen5yvv5qsN/7TXr0Brl+hmp1hnfMlQgq8GpbuWXA5rRLIw/eF
 ER+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173052; x=1795777852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4K9aNDAXzlxVIlvvMl7TJRGXklOAca+gjHoc70DTzk=;
 b=Trnha7DxNTxEVfJjghGVKvlybnwe0QO+2/NgI1xjnmarJTK7v9KGKaimt3CTfvZ6nY
 r3X1X05T1R6/Jot+/YivdKp+gzq9BFO1hRcJpszLaXS4yU4ALcujJrE1NJ6CGdiDAgXy
 FQZbCpHun5pRbGJcZsTuZKdmWifZpP0vJNIMvO98vHyZsuDyAdoanSPnMq8AkFrzPMzb
 2jLK2y0B6Q9b7LgCEoNp6iujlKm+YjaaKM0fcUCXP6d55jvoNV08kcezMv+C5OodsIMw
 Vaj52knRRCLb4ytKlv1z39+LcBFHz6JY5Z7KBtd459NRTK4Lp+6iay7snxmhLmRns8yx
 ls1g==
X-Gm-Message-State: APuU4Z8Z6okB8Hc75rBqGd1Mq7wK8bH7dGV5w6L5qiZbpnGFi0tRxZB1
 K4Z+gZH6VmPaPkACjs8etmLJgUSaSewyceFSzpio9lxTlf6SvPPbX/4r
X-Gm-Gg: AYBFou0cPDXS6lQImtSCFJBBs8XM4Fy3Lwzn+6jOdvdbOHLbS29bLCQVKSgbpMM/NEa
 YPx/UzW8B9XDI/MWTSWvcI7W6vsAOc2kqYEeZ0DqFUPpR6JOyJGodRS137XRqxxx+qa+iSP1DvO
 o65lteP07frizJu9fpmJcp5LAg7tRpnSizL9SEuAmHlYjZWViYCsJzo/sRLmzlqhCferPADqZGQ
 aMabb2AikJuA8i1L3MJbWDKs+9Uj7p4xFlzpdNOJkC+SL7aQY9poA4yjn5Tkc8JlBMdgNrxrAdE
 NuRPldwg5jHfco4WEUL8813diPfBbB2+5WgLvSUTcClyijeqicYWuMH8GLrZwuW/Xm738bOPb65
 R2avZR0NqdhEZKgC2TmYUIjCdhAJ+GSUaJHd2O77jP4p5yqgTK1d23o5b84p70qpvAH6FxMruI3
 MijKaJ5hi66y8woIx3byuRFOnX1+prW//vR4xJxrkyXP3xkkAsTSM26jH/+aGa9QBa3CuLGPfGo
 z0uEQ9ZcbV3+CQMolIXkBeOo7UfHuI5TrOkZq/l5JCbao+T28ZL9km92x6xqFQHj1agqdsSKbGq
 DxH5WHdPSdVHVzm0d5OkVQ/wrVSWK6iRe9YXmXFJdocK
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr63398095e9.5.1795173052182; 
 Fri, 20 Nov 2026 03:10:52 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:51 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 7/7] board: toradex: colibri-imx6ull: enable the clock
 framework
Date: Fri, 20 Nov 2026 12:10:13 +0100
Message-ID: <20261120111037.110741-8-eichest@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120111037.110741-1-eichest@gmail.com>
References: <20261120111037.110741-1-eichest@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The PHY supply is a regulator-fixed-clock, and since commit a5d990854f2c
("regulator: fixed: fix regulator-fixed-clock") gave that driver a probe
hook calling devm_clk_get() it cannot probe without CONFIG_CLK, so its
150ms startup delay is skipped and the first FEC probe finds no PHY.
Enable the clock framework, which also makes the hand-rolled FEC clock
setup redundant. The ENET2 reference clock selector (gpr1[14]) is now
the IMX6UL_CLK_ENET2_REF_SEL clock, its parent set through
assigned-clock-parents. Only the ENET2_TX_CLK direction (gpr1[18]),
which no clock models, stays in board code.

Drop setup_gpmi_nand() as well. The regulator probe now probes the CCM
in initr_dm, before board_init(), and the CCM driver sets ENFC_SEL to
pll2_pfd2. setup_gpmi_io_clk() then writes MXC_CCM_CS2CDR_ENFC_CLK_SEL(3),
which on i.MX6ULL only covers bits 17:16 of the 3-bit field, leaving
ENFC_SEL at the reserved value 7 behind the back of the clock framework.
The GPMI loses its clock and every NAND command times out. With the
clock framework the CCM driver selects the ENFC parent and the mxs_nand
driver enables the GPMI clocks and sets their rate.

The serial driver probes the CCM before relocation, and the ~80 clocks it
registers need around 13 KiB from the pre-relocation malloc pool, more
than the 8 KiB default. Raise SYS_MALLOC_F_LEN to 32 KiB.

With the clock framework the usdhc, i2c and gpmi drivers take their
rates from the CCM driver instead of mxc_get_clock(), and the usdhc
assigned-clocks in the device tree are now applied.

Tested-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 .../dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |  6 ++++
 .../toradex/colibri-imx6ull/colibri-imx6ull.c | 34 +++----------------
 configs/colibri-imx6ull-emmc_defconfig        |  2 ++
 configs/colibri-imx6ull_defconfig             |  2 ++
 4 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
index 8494b1a2c60..1712f38edbf 100644
--- a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
@@ -29,6 +29,12 @@
 	bootph-all;
 };
 
+/* RMII reference clock from the internal ENET PLL, not from the pad */
+&fec2 {
+	assigned-clocks = <&clks IMX6UL_CLK_ENET2_REF_SEL>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_ENET2_REF_125M>;
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index 01387e87294..ea83d53c27b 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -7,10 +7,7 @@
 #include <asm/global_data.h>
 #include <linux/delay.h>
 
-#include <asm/arch/clock.h>
-#include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
-#include <asm/arch-mx6/clock.h>
 #include <asm/arch-mx6/imx-regs.h>
 #include <asm/arch-mx6/mx6ull_pins.h>
 #include <asm/arch/sys_proto.h>
@@ -57,15 +54,6 @@ int dram_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_NAND_MXS
-static void setup_gpmi_nand(void)
-{
-	setup_gpmi_io_clk((MXC_CCM_CS2CDR_ENFC_CLK_PODF(0) |
-			   MXC_CCM_CS2CDR_ENFC_CLK_PRED(3) |
-			   MXC_CCM_CS2CDR_ENFC_CLK_SEL(3)));
-}
-#endif /* CONFIG_NAND_MXS */
-
 #ifdef CONFIG_VIDEO
 static const iomux_v3_cfg_t backlight_pads[] = {
 	/* Backlight On */
@@ -94,25 +82,16 @@ static int setup_lcd(void)
 #endif
 
 #ifdef CONFIG_FEC_MXC
-static int setup_fec(void)
+static void setup_fec(void)
 {
 	struct iomuxc *iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
-	int ret;
 
 	/*
-	 * Use 50MHz anatop loopback REF_CLK2 for ENET2,
-	 * clear gpr1[14], set gpr1[18].
+	 * Drive the ENET2 reference clock out to the PHY: ENET2_TX_CLK_DIR
+	 * (gpr1[18]) output. The ENET2_CLK_SEL (gpr1[14]) half is the
+	 * IMX6UL_CLK_ENET2_REF_SEL clock, set up from the device tree.
 	 */
-	clrsetbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC2_MASK,
-			IOMUX_GPR1_FEC2_CLOCK_MUX1_SEL_MASK);
-
-	ret = enable_fec_anatop_clock(1, ENET_50MHZ);
-	if (ret)
-		return ret;
-
-	enable_enet_clk(1);
-
-	return 0;
+	setbits_le32(&iomuxc_regs->gpr[1], IOMUX_GPR1_FEC2_CLOCK_MUX1_SEL_MASK);
 }
 #endif /* CONFIG_FEC_MXC */
 
@@ -135,9 +114,6 @@ int board_init(void)
 	setup_fec();
 #endif
 
-#ifdef CONFIG_NAND_MXS
-	setup_gpmi_nand();
-#endif
 	return 0;
 }
 
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index c56e9a90bc1..82f1d9e8b83 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
 CONFIG_TEXT_BASE=0x87800000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
@@ -64,6 +65,7 @@ CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_UUU_SUPPORT=y
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index d65e5c16957..55990719f28 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
 CONFIG_TEXT_BASE=0x87800000
 CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x380000
@@ -74,6 +75,7 @@ CONFIG_TFTP_BLOCKSIZE=16352
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
 CONFIG_USB_FUNCTION_FASTBOOT=y
-- 
2.56.1

