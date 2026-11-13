Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC138606A8A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GAUpUJnv;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=OWvK9Keh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79E9E60EAB;
	Fri, 13 Nov 2026 02:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUoWWqMw8Wm0; Fri, 13 Nov 2026 02:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03C5560E9F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537215;
	b=kGc3NOWjtDOfiyr2Ap1PimDxwHaWcA6BFA42NoWyQylnqm6fFveDsCIP/L805QGmrNPj
	 bvJWkj7TvQc0vaYpSgc21PGThRnt5rmaJm6hAqneeyVwfgJd4pk3CD5d5rC5oWPqDuUrP
	 r6ZKdyr4NvYI3cPNwq9yMo7gI1O1XmWzSyW7SmQkybLM8ib6QLjMWtU7BDvqskDKhnZtc
	 fy0h2gHjFG6WAZgOXji0qVmvnymhsEbcWkXRJj6bGLgjEEFCEdfalFhNArMbC5xMJpWNu
	 EZ4g0sIgM69ubiYVt8UHr5lxcKLJVq0Ns+78GbtYlDng04cHZXy2Ohq5YMv0RE+Z8OA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZVXyu8TYY0c9bN4Zfb5YKc7OFIBjFPUNvpKerERj+cM=;
	b=HTloSg6uhqlZ3ioNL7S2WcwWRyjfSKl1V7JtF70nvWrXUy6Ow6Dp7RVEM68v1zJBqNaj
	 WSWMYBbvubcLKxTA8xYDAO3Eapaew57IJOJFMIn9yRvcGabrQhpvy+LrN5D+tpn1w2YQU
	 AQXaM02JeJ9XLX+oHVQkOZHLwkfxf86n20Ls3fFCHkTSl3OxziySa3YMd6/oh+wdQOw84
	 O8HFVzLQbBj6u8Gp7eBDzWMwgl9TmGQaS336KWk0RyqrVG1bInbVAvFkHqs/+Vy0u8X6W
	 pFqvZVrxfQmSniykqS14zBNJSpXf4x9YsQyS13qmQ9vgi9VCf8tVLn7BMfZzUDfv27g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=OWvK9Keh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537215;
	bh=ZVXyu8TYY0c9bN4Zfb5YKc7OFIBjFPUNvpKerERj+cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GAUpUJnvcVyGgQ2S/5pWzknvEa6JXrdc6w/XCgTfdMWWGf7OiyVnGUPFnayFg7PJ3
	 FAM+sCYtnkswfhIXpDXsOAYvwEeY7OtoNe1dqSiOE0fEoZIXodScBGYqPIE8z6Zlof
	 JRLFN6X6cOye9p7YyUdzJUmsMaec0D+j30V/fkyKcSj8spGzAlfkx21htwAKJ/MQcm
	 +PdHzG0nsR8qEFl3zbRd1V87M7lZ4ES1Tw/hlEb8R1RG03p1S88BRP3AB2X/hEuzp6
	 bYfxfubJBUB2AdbL+QI7hd8RRcb6qZ3eCKmhoZkzMHhBcsrY8AIhC1WUyioy6EA2sr
	 NvyFXRR5L38jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C5560E9F;
	Fri, 13 Nov 2026 02:33:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E97AF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DB8560E9F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PihfAK5v72ox for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 062CD60E9C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=OWvK9Keh
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 062CD60E9C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:32 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 98D464C8BB;
 Fri, 13 Nov 2026 13:33:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVXyu8TYY0c9bN4Zfb5YKc7OFIBjFPUNvpKerERj+cM=;
 b=OWvK9KehBf988JDw14Jp98ONjcs8P0WHWSiqq15O2dUjei8K0l+8o/LgFDoILM3vYvXFdc
 kosmznJ111KVSHsh5MixkPpx5EhGKycs8YoFKKsMaMpE6rM4wBwGCK//73GTvEGla/nlD7
 kVi45Nc+dGjY4zpz1Zt2fukSwsEuLMzUsUEblrNBGOTtB63CaWeeaFIPrG8CHBE+G7IkZm
 oo5nSXwPnR+3D5UW0YRCmSu3mVeBTf+lu3NYUfC7g5jODC9MP2ZC2Dw5xbdCqp6yR9VfOv
 V8rqcLdAHW+/CperFQaS5Zs2IKZR/rs/CZv5368SjcuEgZAc7ghPH8upKt7BIw==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 10/26] sunxi: mmc: enable support for A733
Date: Fri, 13 Nov 2026 13:32:20 +1100
Message-ID: <20261113023236.569054-11-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yixun Lan <dlan@gentoo.org>

Add MMC clock and SPL bus-gate/reset support for the Allwinner A733 MMC
controllers, where SMHC0_CLK_REG starts at CCU offset 0x0d00 with a
per-channel stride of 0x10 bytes and MMC2 uses PLL_PERIPH0_800M.

Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-8-f19dcd098f60@gentoo.org
Signed-off-by: Yixun Lan <dlan@gentoo.org>
[Alastair: add MMC2 800 MHz factor and 8-bit SPL support, preserve SUN9I]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/mmc/sunxi_mmc.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 12c92b1e2b6..35e23dbafe2 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -101,13 +101,14 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 			pll_hz /= 2;
 
 		/*
-		 * The A523/T527 uses PERIPH0_400M as the MMC0/1 input clock,
-		 * and PERIPH0_800M for MMC2. There is also the hidden divider
-		 * of 2. The clock code reports 600 MHz for PERIPH0.
+		 * The A523/T527 and A733 use PERIPH0_400M as the MMC0/1 input
+		 * clock, and PERIPH0_800M for MMC2. There is also the hidden
+		 * divider of 2. The clock code reports 600 MHz for PERIPH0.
 		 * Adjust the calculation accordingly: 600 * hidden2 / 3 for
 		 * MMC0/1, and 600 * hidden2 / 3 * 2 for MMC2.
 		 */
-		if (IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
+		if (IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
+		    IS_ENABLED(CONFIG_MACH_SUN60I_A733)) {
 			pll_hz /= 3;
 			if (priv->mmc_no == 2)
 				pll_hz *= 2;
@@ -166,8 +167,9 @@ static int mmc_set_mod_clk(struct sunxi_mmc_priv *priv, unsigned int hz)
 			CCM_MMC_CTRL_SCLK_DLY(sclk_dly);
 	}
 
-	/* The A523 has a second divider, not a shift. */
-	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
+	/* The A523 and A733 have a second divider, not a shift. */
+	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
+	    IS_ENABLED(CONFIG_MACH_SUN60I_A733))
 		n = (1U << n) - 1;
 
 	writel(CCM_MMC_CTRL_ENABLE| pll | CCM_MMC_CTRL_N(n) |
@@ -585,7 +587,8 @@ struct mmc *sunxi_mmc_init(int sdc_no)
 
 	if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
 	    IS_ENABLED(CONFIG_MACH_SUN9I) || IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
-	    IS_ENABLED(CONFIG_MACH_SUN55I_A523)) && (sdc_no == 2))
+	    IS_ENABLED(CONFIG_MACH_SUN55I_A523) ||
+	    IS_ENABLED(CONFIG_MACH_SUN60I_A733)) && (sdc_no == 2))
 		cfg->host_caps = MMC_MODE_8BIT;
 
 	cfg->host_caps |= MMC_MODE_HS_52MHz | MMC_MODE_HS;
@@ -611,6 +614,10 @@ struct mmc *sunxi_mmc_init(int sdc_no)
 	writel(SUNXI_MMC_COMMON_CLK_GATE | SUNXI_MMC_COMMON_RESET,
 	       SUNXI_MMC_COMMON_BASE + 4 * sdc_no);
 #endif
+#elif defined(CONFIG_MACH_SUN60I_A733)
+	/* A733 has individual BGR registers per MMC channel */
+	setbits_le32(ccm + CCU_A733_MMC_BGR_REG(sdc_no),
+		     BIT(GATE_SHIFT) | BIT(RESET_SHIFT));
 #else /* CONFIG_SUN50I_GEN_H6 */
 	setbits_le32(ccm + CCU_H6_MMC_GATE_RESET, 1 << sdc_no);
 	/* unassert reset */
@@ -669,16 +676,19 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 	.get_cd		= sunxi_mmc_getcd,
 };
 
-static unsigned get_mclk_offset(void)
+static unsigned int get_mclk_offset(unsigned int mmc_no)
 {
+	if (IS_ENABLED(CONFIG_MACH_SUN60I_A733))
+		return 0xd00 + mmc_no * 0x10;
+
 	if (IS_ENABLED(CONFIG_MACH_SUN9I))
-		return 0x410;
+		return 0x410 + mmc_no * 4;
 
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
-		return 0x830;
+		return 0x830 + mmc_no * 4;
 
-	return 0x88;
-};
+	return 0x88 + mmc_no * 4;
+}
 
 static int sunxi_mmc_probe(struct udevice *dev)
 {
@@ -715,7 +725,7 @@ static int sunxi_mmc_probe(struct udevice *dev)
 	ccu_reg = (u32 *)(uintptr_t)ofnode_get_addr(args.node);
 
 	priv->mmc_no = ((uintptr_t)priv->reg - SUNXI_MMC0_BASE) / 0x1000;
-	priv->mclkreg = (void *)ccu_reg + get_mclk_offset() + priv->mmc_no * 4;
+	priv->mclkreg = (void *)ccu_reg + get_mclk_offset(priv->mmc_no);
 
 	ret = clk_get_by_name(dev, "ahb", &gate_clk);
 	if (!ret)
-- 
2.53.0

