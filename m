Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36D606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z+qtOQ2f;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPGcSVKA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B68B81344;
	Fri, 27 Nov 2026 18:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OyD5wCgXwLHb; Fri, 27 Nov 2026 18:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 150B081306
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802431;
	b=BbAyR9s+uGnoNq9ttShn1233A+R1wutnerdm8ZNtO6kEJkdnAoj9Ympa1Bm6+XAhzlB0
	 BdyzgKEe2XNZEXvFKJCT3+1py4m/bA5cFSI1JW6OSEHe8LqfUNPU5zbOZKQQQazqAclDa
	 fG0HkM4yUUtF1pHliSywb4rKhz5C3fNOwZWjJnLbw0g8YcBwAJHEPwPcgRipg4N779ZmK
	 Lwvs6ihvo6dWTzqS6kL4PYhu11g3gpvJKd9aVWPX6Z2rNwY2/V+NA2ny1l4RnNllvNYZd
	 nV9hCMN6asqgtcZB6GshCSpYVySzGPGrrvav8ErBnuEFLhcpbvl+1y0XKRDSmkXPZ1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eVGhSBixXfBk7VJxH/NTsbEdeniPdHsHIe8etYODQD0=;
	b=leO7AFKSKu8uC0KWcq4E562+e9AZCWVqPFr+7iu2zDw+gr0Pjrj5DdfObg6qHtfp2CA8
	 pA2iypUX9fIDomXnmlQVwl6R2+gny5+hCy7fTcd9784dVSztY0J4kjFPZR3deJb9EIz/y
	 i7g+f3yEwEvsQWX6A034sHUqTgK2Lx3yPAoiVknjf8a3lFFahl9dAaD+Poi96WTLEkYaC
	 lCMwXz25rJTeMFTVbf3NTS7UJvMwt1OdVJ86nY+xPDVBjHYTRC7LQFEDvMk4v+8baIf7V
	 xpWBKdQ3pkG1jQVdEpWpoKMfT/IUov87Lx5fLbz+gIZy0Mhka2c4xrhAQIehrljgoBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802431;
	bh=eVGhSBixXfBk7VJxH/NTsbEdeniPdHsHIe8etYODQD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+qtOQ2fsNLtcA0qBm3OF+NcxxKppfbV3mcZURhL+r+Zp66exu9ZpvetvhcNInIaV
	 Et2rYKjMM1Mq63zWDxkBLQptQiLmlcIxud4gE58hF5U53jS5kXtv6HDdamZjyV55Ix
	 CGo1gsDcYiu+21rfwvC6Bctv4EcgnIznryFEuFPKagyM31WqBuKiVp3NKQgFF4qzzb
	 TZXC51dgZr3yrLQjw+EPFNdcrtmInTw8zEoIUNCdxepwzuktRALAtJNs3i/NesBhoP
	 TE3vTDavzc4m5V+4e7GVx+SYnxX8CNigUxUcy2+/rtbnoRiId+FZWgxZEoKELGHCly
	 G6Dv49ng9q9fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 150B081306;
	Fri, 27 Nov 2026 18:00:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDE26373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B42D9409F7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoQK3uOOM_Se for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B45B1409F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BPGcSVKA
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B45B1409F1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so29365105e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802419; x=1796407219;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eVGhSBixXfBk7VJxH/NTsbEdeniPdHsHIe8etYODQD0=;
 b=BPGcSVKAuN+mN8u6zn77Bcylr7fJYSRF5IX5DnQBD8Z6zhCooxLsyjTQj5YIJhB79F
 WMAcdoUKb/EsLsekeSk8wIH/dxokGLY0r404VsQaR35DDAFVG3JtebtSAQgIQ1BwN6yX
 DtlPucUsZXcWWOUXMVxsIe5Y0AERFi/usLIGDwDWDR5HdasWl0rZ1bzgExXFcjTdSR3a
 DYW1OzmSFOYCzTeFkUqam/j7T1CrtmdDTXE3vxvXyC44OJNkax3cNtVPzXsqgSKGuYWy
 AOEMX4hteMc19VBxcBIZeggF6uMh1iN4wS9aQNkNkLD2ZxMnYMHrClvoYXVWnHDb6BRB
 2u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802419; x=1796407219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eVGhSBixXfBk7VJxH/NTsbEdeniPdHsHIe8etYODQD0=;
 b=wC8siwzKtVH5qzXALL3z5rmNjHdTWguJ77hZI8Jo4MNsfmsgRvDlfJE8LLXvHvNsvK
 F55JOY2F6XAGfbwJNjR+9rPguoTHHlq9goaL/HpUJS2fLDCBnk+/iYwuV50bsWGJTQG/
 wQMsZj8WIw+uwZGmA2hEM24S1q8vDBfVsDpZybhzXer7Rlg0oxdUKdhOgLNXXqHfyh+6
 z6oLEaoMYmbGKqZjcvy9OFIbxeTn5Q/Th5Jpv2GOip6EO2AYseiqksYLoDN5QWpzyGfG
 n5b1Expn+ejBcZiVZHP0s+Fh8ib5Kfr3hkBEDT1PKNExjlGxeulYMR7VhOuTRuE7ii+M
 PEEA==
X-Gm-Message-State: APuU4Z9eoozHuDQahmh/rezcTj9/Dms/9fpm+3CrAqxeLjXpQ+JooEl2
 74v3cOcjzHMn/Te3SAV73RIvR/F8IgwoiSCS8VBoBzGXtmlsqcYn8K1I
X-Gm-Gg: AZFdTZcnbpcnsa7ZAXJGhWJA0uLeFQ0C3cAA984V+iSnoGiFeVG/n92cibhmqNdXlr6
 YwOoc7MaCvarDKRDikWv/kZEFAP0LNFPkw7g7e9phYqzusloByICGe8cG1xtcB/pB2QfCm6w/Iv
 ph0bl0lpra3ulP0P6pvXfJNA6P1SjwIAUl4gGzkie6OMwKPDKJwSmpsoOyE3+xs9rcd1Pxtu/hm
 P4CLyg0Cw0M6tC9YTBgGFsE631SlL9ykBlcdxqR2OQLdhd5YIsSeRPfxVf7tI4LQkSt9Y0qk7HE
 NYKMS2LsGxomhLZsdoBUqKdyVDQPf0PcU0lBNaY6NzsqT8K8RDtWIZJHrBlMPSI1MKyV2Q4NEag
 /MexdiZPbONwWDIosnz5xbtgqo9qCTnlV6pTjTE6uGoCjJkq/CP6HXqfhLWdzqCRsidh7Ef7+mw
 U6uL8thwOFgZx8dM0AyHvAqy145zYpvR8aGTVLUacCj2qElX064+hNjZkBMg9PG4KF9trx7fwxb
 nArsIFtN2Hlvx5AtFqhRroJTR1/nPR2OkxLB/E3d7FPnb5VfIRdgLDqAHftrozB6vyHZrv/YiSd
 twR8D4I2e1Gn3WzVOw8T/HD5FoeSlVqDSW1XbLc=
X-Received: by 2002:a05:600c:a08b:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4bb88922c52mr480819975e9.13.1795802418378; 
 Fri, 27 Nov 2026 10:00:18 -0800 (PST)
Received: from [127.0.1.1] ([151.71.203.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm695638385e9.1.2026.11.27.10.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:00:18 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 27 Nov 2026 19:00:13 +0100
Subject: [PATCH v4 4/4] ram: rockchip: rk3399: support multiple SDRAM types
 at a time
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ddr-multi-v4-4-c66608f3e06f@gmail.com>
References: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
In-Reply-To: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow the SDRAM driver to have DDR3/LPDDR3 and LPDDR4 support built-in
at the same time. The driver chooses how to initialize the controller
based on the SDRAM type property value read from the Device Tree.

This introduces the following behavioral change: if the driver is built
with LPDDR4 support only and the Device Tree reports a DDR3 or LPDDR3
SDRAM type, the driver refuses to initialize the controller and return
immediately. The same applies when only DDR3/LPDDR3 support is built-in
and the Device Tree reports LPDDR4. Previously, the driver would have
tried to initialize the controller in any case, even when the Device
Tree was reporting an unsupported SDRAM type.

The average TPL size increase for RK3399 board configurations is 80.3
bytes with maximum of 86 bytes (buildman report).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/sdram_rk3399.c | 53 +++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 3daad319a57..2386332c498 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -26,12 +26,6 @@
 #include <linux/err.h>
 #include <time.h>
 
-#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
-	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
-	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
-#error "This driver only supports DDR3/LPDDR3 or LPDDR4 at a time"
-#endif
-
 #if !defined(CONFIG_RAM_ROCKCHIP_DDR3) && \
 	!defined(CONFIG_RAM_ROCKCHIP_LPDDR3) && \
 	!defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
@@ -1644,9 +1638,7 @@ static void set_ddr_stride(struct rk3399_pmusgrf_regs *pmusgrf, u32 stride)
 	rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
 }
 
-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
-	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
-	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) || defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
 static int data_training_first(struct dram_info *dram, u32 channel, u8 rank,
 			       struct rk3399_sdram_params *params)
 {
@@ -1737,7 +1729,9 @@ void modify_param(const struct chan_info *chan,
 	clrsetbits_le32(&denali_pi_params[76], 0x1 << 24, 0x1 << 24);
 	clrsetbits_le32(&denali_pi_params[77], 0x1, 0x1);
 }
-#else
+#endif /* CONFIG_RAM_ROCKCHIP_DDR3 || CONFIG_RAM_ROCKCHIP_LPDDR3 */
+
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
 
 struct rk3399_sdram_params dfs_cfgs_lpddr4[] = {
 #include "sdram-rk3399-lpddr4-400.inc"
@@ -2978,9 +2972,11 @@ static int sdram_init(struct dram_info *dram,
 	}
 
 #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
-	/* LPDDR4 needs to be trained at 400MHz */
-	lpddr4_set_rate(dram, params, 0);
-	params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
+	if (dramtype == LPDDR4) {
+		/* LPDDR4 needs to be trained at 400MHz */
+		lpddr4_set_rate(dram, params, 0);
+		params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
+	}
 #endif
 
 	params->base.num_channels = 0;
@@ -3081,21 +3077,23 @@ static int conv_of_plat(struct udevice *dev)
 }
 #endif
 
-static const struct sdram_rk3399_ops rk3399_ops = {
-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
-	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
-	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) || defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
+static const struct sdram_rk3399_ops rk3399_ddr3_lpddr3_ops = {
 	.data_training_first = data_training_first,
 	.set_rate_index = switch_to_phy_index1,
 	.modify_param = modify_param,
 	.get_phy_index_params = get_phy_index_params,
-#else
+};
+#endif
+
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+static const struct sdram_rk3399_ops rk3399_lpddr4_ops = {
 	.data_training_first = lpddr4_mr_detect,
 	.set_rate_index = lpddr4_set_rate,
 	.modify_param = lpddr4_modify_param,
 	.get_phy_index_params = lpddr4_get_phy_index_params,
-#endif
 };
+#endif
 
 static int rk3399_dmc_init(struct udevice *dev)
 {
@@ -3114,7 +3112,22 @@ static int rk3399_dmc_init(struct udevice *dev)
 		return ret;
 #endif
 
-	priv->ops = &rk3399_ops;
+#if defined(CONFIG_RAM_ROCKCHIP_DDR3) || defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
+	if (params->base.dramtype == DDR3 || params->base.dramtype == LPDDR3)
+		priv->ops = &rk3399_ddr3_lpddr3_ops;
+#endif
+
+#if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+	if (params->base.dramtype == LPDDR4)
+		priv->ops = &rk3399_lpddr4_ops;
+#endif
+
+	if (!priv->ops) {
+		printf("no ops found for requested dramtype (%d)\n",
+		       params->base.dramtype);
+		return -EINVAL;
+	}
+
 	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);

-- 
2.34.1

