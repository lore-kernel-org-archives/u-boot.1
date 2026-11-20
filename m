Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01510606A33F
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0rUDnPyw;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WzvMoVdz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B688581746;
	Fri, 20 Nov 2026 13:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3y5t37Xrwdwc; Fri, 20 Nov 2026 13:21:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 273AD81766
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180898;
	b=gUhAjkW9YWEIdRbZ1rM0yAflDHyHOHu9tRd64rjPKYkB66P+1oa03MDsJOoTUq48IwRm
	 1bHB/9H1/1cVecl9t+pXLcWaJ6PuuB5Kr1Pm2BJEj7mm/LYrcsXdLLfrtQtIIbRZF4lRS
	 G7guxoCoGlA899Y0SDn86m8iey30uvAExB0MzcByDuAE987MK9QLUi2SsSn24Pl38oLh4
	 QQolqk5E5mHMlLB9AwlNRQoMIroFcXN8yeaqNdaJ5kyzg5wmndubXKJP7+PoE1ER7/6RZ
	 czI40Ph/Gfs2jirLOxi6mXo3tODCqIm//Dkw0KiUs2aCMA08UjJXrpxtRfoPBk07jyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5FUeOZZiRMPjVcBtTtr/b+kKthB335A2SOjGuAPbvMM=;
	b=abgzIn4DCbnLaDLJPUSQPjtnL1CGZFxPwgARoUCz047cvSvlM/1IDBHrpRLknOZ8fpYi
	 d6c5KaasnPRVV0kmIZW5PFS/IisNA5cNMKVH8Yq1CtNisY3/D6VxFvBiqc9vDGajXfX9y
	 gNSOKkN/AKRG0M0BsCaGRV5eCf5lNtlP3rXYP5QTZnshQ1A8cG3sQmxXzcgHcDGYT7ADL
	 ZWJzos+cbqC5j4BTqgcZGuwIPZOsBYwnPuvpHQRfeE7ChKd5FOkCft83rOYKYbdTqGwFJ
	 mO7P9dwPLsdjhIwDf6HBsz53fKqLSGaiUPb/ruvp05pKvDBW8ATmw8FiEp5lkysLuFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180898;
	bh=5FUeOZZiRMPjVcBtTtr/b+kKthB335A2SOjGuAPbvMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0rUDnPywa4VsiI3lvYDjhuPqqv9UC8SYHAMXXuSW4oQfhmX1QbbkLypKslJ1/SQ0/
	 R/40zMfs2UJVs3iRU0zfovfUx9NSpezc0fRUEKqoUQhtp6N83kO2LWwJNUeOYZhjHi
	 qfFz9k6BWx/R3FZIhwxb5pcR/BDNfLCJGeshhUF9REK0+k3heNeLOlslbPRGDFz7HI
	 G3EhGpXz50TnsA2OPr3D0SaW9DxA9ZXFtN3zGHb62FKeAWjv9Gqo8SpDbAgxqQmyKa
	 jTcBMjF3xsS6nuvuwn5/249hbGeyUzUqJMoKakASeYW5n5jBZD3Ic/a6C9IlVpMCcb
	 S1DS6UEAZyLRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 273AD81766;
	Fri, 20 Nov 2026 13:21:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33A00E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19AE340977
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nljkAmEBi7rQ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 11:10:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA80540E10
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=WzvMoVdz
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA80540E10
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:10:50 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so6389425e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795173049; x=1795777849;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5FUeOZZiRMPjVcBtTtr/b+kKthB335A2SOjGuAPbvMM=;
 b=WzvMoVdzJgbdLbA2aJHzZ0F+IhCOnnh+29KIaDWZw9xCslv5Sn2ZXdECh3pmqpVXQF
 cRHVgRUCQud7XjuXedxAzX9W6KHIUfzHo6O2we5mgYQLMR/3QFGJIipvCP+nmR2B/cJ6
 4FyKmOtSX1UpTheIJs1nSwBf3nGknQ1KiyflB2viMMjGZnMpQTOntlVEOBY0KHiZJ8Q6
 E4t16BarxJVrV48Tukj+9d4DqptQhD7EnuPVKH0u/FINVqEFFq275VtzeYrlKQXun/tk
 LdYVFOQ3WHIzKd9+OSTkxoY03Pgzm1cVPDpCpci5U6ADOflc7O4Fki1yPDLWZonvI2zI
 cGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795173049; x=1795777849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5FUeOZZiRMPjVcBtTtr/b+kKthB335A2SOjGuAPbvMM=;
 b=cqaby0OH3YjdB7ZEvNByV0O1vX81o/y2g4cs4RFP/pslijJkEmNCtJFDxY5/0+6BcR
 WKBCK0mgVKzcg0smoRs8zWvAGkPK0ypthpt2zXEv6tsAiwpy8o7clgjAOOK+raZx5u2Y
 I7dYbGc0zKGDtequZcqYkXK9JzCzXfGNJVznhug9kr1YUCDa8j/6bXiceAaFJ3pkYpKO
 uR2jMTiHjP27ESvYM6P7x6hiLI/nOLcjOCw9U4y2UukFJc8JiMmVHcNUKlAs1OEfhkoR
 Ic9JX2t7N+3MPtpn322rRvJtLuskoFPFImOQ1mpz8oPSSuFBEzqWhuKji8I1YpWQ0vD0
 kGYQ==
X-Gm-Message-State: APuU4Z/FmW3g6e5JWTXVaJELTxaBFAHWa4Ma3LYpoqA4p9Vh1ACgjpD3
 U/pQufJN/juxq0YX5wk7z0vSicAIGzyGHa44MSQ5TM8L6sWPDUHlRNtK
X-Gm-Gg: AYBFou2GYmTjFrIBEemwZn3MCasON8o7cr4/jKzHIqt344i84N+krdcXpesiR0rE9Bz
 yI2irFTa63TtijH2Kn9F8/1KVEygUbnaoeyHnJwPOaBE+BMgwrGZV8dySycj42nLrYwY/WZdu5I
 mfGQUSicNx9bg/TP+65iUqGWO+wR/3h1vFFQ/vKIKx2c4rTOzVMuqcMF35h+BibTgy5vcuaRuOg
 gAY4ZasLornrLf8rTNy8Pf9bXIELODSrqYZzpka/njWhuTEl8Tf8TKVu3pLzN1/Aj14wtzwJ0pH
 tNG40dKArcwirtPHM6QbWQqJkje1PUAIIVkHnfeJzjksLniXMvODFJp89sP/gDokEjBEu9iZpJC
 HrZT+gMgLNT5CDdpGKDOv2va0MHsMl7uZ7SNOpG1X/zPVizthm67zx21125jzo4cJmgNzDFrXvH
 PJxyEvMqfqK30wa9zrmCMA3jar6wpop9GP3gYmQ9Gq7cDQGZdMD5pktZMLYToZibLWsobl3QABl
 LQ8C/PuCqRFC4OpIHwfg6mPGrioTpyrOOgBIHTMl13KcRRUaI+G1pyk/sP2swAEef5yJQtT7r4I
 JhzTW3rTs/7HUaXUNVNjI74=
X-Received: by 2002:a05:600c:1d0a:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4bb8880ef6amr61221285e9.14.1795173048654; 
 Fri, 20 Nov 2026 03:10:48 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm79108005e9.3.2026.11.20.03.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 03:10:48 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, francesco.dolcini@toradex.com,
 lukma@nabladev.com, dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com, jbx6244@gmail.com,
 aford173@gmail.com, cniedermaier@dh-electronics.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 4/7] clk: imx: imx6ul: add the enet clock tree
Date: Fri, 20 Nov 2026 12:10:10 +0100
Message-ID: <20261120111037.110741-5-eichest@gmail.com>
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The FEC ipg/ahb/ptp/ref clocks and the regulator-fixed-clock PHY
supplies reference clock IDs the driver never registered, so none of
them can probe with the clock framework enabled. The CCM request
callback only checks the ID range, so clk_get_by_name() still succeeds,
but the following clk_set_rate() and clk_enable() fail to look up the
clock.

Model the ENET branch as the reference manual and Linux describe it:

- The PLL6 bypass muxes, as this driver already does for PLL3.
  PLL_ENET comes out of reset with BYPASS set, and the PLLv3 enable
  only powers the PLL up, so select pll6 at probe time. Otherwise the
  reference dividers run from the 24 MHz oscillator.
- pll6_enet feeding the two ref dividers and their 125M gates.
  pll6_enet was registered as a gate on PLL_ENET bit 13, which is the
  ENET1 125M output enable, not a PLL gate.
- The ENET1/ENET2 reference clock selectors on the IOMUXC_GPR1
  ENETn_CLK_SEL bits, choosing between the 125M gates and the
  ENETn_TX_CLK pads. U-Boot has no GPR mux clock type, so use a plain
  mux on the GPR1 register. The pad clocks are not modelled and map to
  "dummy". Unlike the Linux GPR mux, this does not drive
  ENETn_TX_CLK_DIR: the U-Boot mux can only update a contiguous bit
  field, and CLK_SEL and TX_CLK_DIR are not adjacent.
- The PTP reference and the enet AHB gate.

The 125M gates and the selectors carry CLK_SET_RATE_PARENT, so the FEC
driver's clk_set_rate() on enet_clk_ref lands on the ref divider.
Default both ref dividers to 50 MHz as Linux does, so the clock is
already at the RMII rate when a consumer enables it before the FEC
sets the rate, such as a regulator-fixed-clock PHY supply that probes
before the FEC.

Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/clk/imx/clk-imx6ul.c | 76 +++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index a73fb40b8ac..c65c029758b 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -34,8 +34,20 @@ static struct clk_ops imx6ul_clk_ops = {
 	.disable = ccf_clk_disable,
 };
 
+static const struct clk_div_table clk_enet_ref_table[] = {
+	{ .val = 0, .div = 20, },
+	{ .val = 1, .div = 10, },
+	{ .val = 2, .div = 5, },
+	{ .val = 3, .div = 4, },
+	{ }
+};
+
 static const char *const pll_bypass_src_sels[] = { "osc", "dummy", };
 static const char *const pll3_bypass_sels[] = { "pll3", "pll3_bypass_src", };
+static const char *const pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
+/* The ENETn_TX_CLK pad clocks are not modelled, hence "dummy" */
+static const char *const enet1_ref_sels[] = { "enet1_ref_125m", "dummy", };
+static const char *const enet2_ref_sels[] = { "enet2_ref_125m", "dummy", };
 static const char *const bch_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 static const char *const gpmi_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
 
@@ -103,8 +115,48 @@ static int imx6ul_clk_probe(struct udevice *dev)
 	clk_dm(IMX6UL_CLK_PLL6,
 	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0,
 			     0x3));
+	clk_dm(IMX6UL_PLL6_BYPASS_SRC,
+	       imx_clk_mux(dev, "pll6_bypass_src", base + 0xe0, 14, 1,
+			   pll_bypass_src_sels,
+			   ARRAY_SIZE(pll_bypass_src_sels)));
+	clk_dm(IMX6UL_PLL6_BYPASS,
+	       imx_clk_mux_flags(dev, "pll6_bypass", base + 0xe0, 16, 1,
+				 pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels),
+				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX6UL_CLK_PLL6_ENET,
-	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
+	       imx_clk_fixed_factor(dev, "pll6_enet", "pll6_bypass", 1, 1));
+	clk_dm(IMX6UL_CLK_ENET_REF,
+	       clk_register_divider_table(dev, "enet1_ref", "pll6_enet", 0,
+					  base + 0xe0, 0, 2, 0,
+					  clk_enet_ref_table));
+	clk_dm(IMX6UL_CLK_ENET2_REF,
+	       clk_register_divider_table(dev, "enet2_ref", "pll6_enet", 0,
+					  base + 0xe0, 2, 2, 0,
+					  clk_enet_ref_table));
+	clk_dm(IMX6UL_CLK_ENET1_REF_125M,
+	       imx_clk_gate(dev, "enet1_ref_125m", "enet1_ref", base + 0xe0,
+			    13));
+	clk_dm(IMX6UL_CLK_ENET2_REF_125M,
+	       imx_clk_gate(dev, "enet2_ref_125m", "enet2_ref", base + 0xe0,
+			    20));
+	/*
+	 * IOMUXC_GPR1 ENETn_CLK_SEL: the ENET reference clock comes from
+	 * the anatop ENET PLL (0) or from the ENETn_TX_CLK pad (1).
+	 */
+	clk_dm(IMX6UL_CLK_ENET1_REF_SEL,
+	       imx_clk_mux_flags(dev, "enet1_ref_sel",
+				 (void *)IOMUXC_GPR_BASE_ADDR + 0x4, 13, 1,
+				 enet1_ref_sels, ARRAY_SIZE(enet1_ref_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6UL_CLK_ENET2_REF_SEL,
+	       imx_clk_mux_flags(dev, "enet2_ref_sel",
+				 (void *)IOMUXC_GPR_BASE_ADDR + 0x4, 14, 1,
+				 enet2_ref_sels, ARRAY_SIZE(enet2_ref_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6UL_CLK_ENET_PTP_REF,
+	       imx_clk_fixed_factor(dev, "enet_ptp_ref", "pll6_enet", 1, 20));
+	clk_dm(IMX6UL_CLK_ENET_PTP,
+	       imx_clk_gate(dev, "enet_ptp", "enet_ptp_ref", base + 0xe0, 21));
 
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
@@ -260,14 +312,17 @@ static int imx6ul_clk_probe(struct udevice *dev)
 	clk_dm(IMX6UL_CLK_PWM1,
 	       imx_clk_gate2(dev, "pwm1", "perclk", base + 0x78, 16));
 
-	if (is_mx6ull())
+	if (is_mx6ull()) {
 		clk_dm(IMX6UL_CLK_ENET,
 		       imx_clk_gate2(dev, "enet", "ipg", base + 0x68, 12));
-	else
+		clk_dm(IMX6UL_CLK_ENET_AHB,
+		       imx_clk_gate2(dev, "enet_ahb", "ahb", base + 0x68, 12));
+	} else {
 		clk_dm(IMX6UL_CLK_ENET,
 		       imx_clk_gate2(dev, "enet", "ipg", base + 0x74, 4));
-	clk_dm(IMX6UL_CLK_ENET_REF,
-	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+		clk_dm(IMX6UL_CLK_ENET_AHB,
+		       imx_clk_gate2(dev, "enet_ahb", "ahb", base + 0x74, 4));
+	}
 
 	struct clk *clk, *clk1;
 
@@ -276,6 +331,17 @@ static int imx6ul_clk_probe(struct udevice *dev)
 
 	clk_set_parent(clk, clk1);
 
+	/* Take PLL6 out of bypass, the ENET reference clocks need 500 MHz */
+	clk_get_by_id(IMX6UL_PLL6_BYPASS, &clk);
+	clk_get_by_id(IMX6UL_CLK_PLL6, &clk1);
+
+	clk_set_parent(clk, clk1);
+
+	clk_get_by_id(IMX6UL_CLK_ENET_REF, &clk);
+	clk_set_rate(clk, 50000000);
+	clk_get_by_id(IMX6UL_CLK_ENET2_REF, &clk);
+	clk_set_rate(clk, 50000000);
+
 	return 0;
 }
 
-- 
2.56.1

