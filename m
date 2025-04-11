Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F16C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D0D783F15;
	Fri, 11 Apr 2025 18:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCFOUdcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9AE82C10; Fri, 11 Apr 2025 18:15:37 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6A7841D5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso3785358a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744388133; x=1744992933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yT0F91CBZ5cB0JDXSj1e0tey/TyTjr0AH6774qDqY8Q=;
 b=KCFOUdcnL1D4TV0a66irfGbyt1tyAqRE78yIQYUvojbQOUgADh4yiLip/MMHzaZgIl
 TyW0qftwHDtGSHvnSVcFs655QrpQUW4CKURE+HU3jDISIEw3fo9JXdvmIJwDNOY6wDfV
 /zHms94uMIpecqY3dvz7QiMTtoDtnOIZl+82MIfN0DQSjXkIdOj0JBqBX5S4XerVGlqz
 BgNtOs2xlNJTZDZlWzdTi3JTLmyXGJuvmIWMkflFxsN892gRkt+cuzyShss6gQXRt2zx
 J0npIdho8lyznU+yhvWJjLWZuNAYZSuV9S7gdh4FQWhTmsSwVD1Z0Qx5ePgD58tZguk+
 0hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388133; x=1744992933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yT0F91CBZ5cB0JDXSj1e0tey/TyTjr0AH6774qDqY8Q=;
 b=Di0m0mq8GqzOwOvh9W/HdmEcXg/iZcsuFniKKDDZNhPqVVfw0/LRG96vCGQw7cHR5X
 t2SsrKWkps3a7gVTAFARCNT+qUaCMw2ORAUNFRbqUEs2ifRWDJ4odUZOCJyZucLE0kXD
 0YQET+DQMMOJDtuMyX+wTE6RSng2mvK+iMntP+O/IRxIU6rhxmC+aH7MNZMqT5/HCk/3
 mmeXk/69rs3/m8TVB16pm2JBn8ZdKmaZs3RjzKx74HiexB2czdGVClLEMUWEcknUVQV0
 qcbrcb47RS5+GxqpgTeoXNG45czFwYYzfBiZnxh/liF27l2cRR2IISLznf9C/ZWqAYtu
 zlxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVChBZgzy/2Gcs2e6pa9P7kknaLthRKpI0GuGqA9mCdniXQ+mO9ih8gYZOQIL6p/6ZSfxSGL04=@lists.denx.de
X-Gm-Message-State: AOJu0YyMypGXh1GmmXVuhkl3ekWcNDQhW1qYdyMAebuWAPoc+nlO70un
 6cjgIdkcXg2O5E93DgItwYEFMENd00cFA/HSDI/kad7aDu4tFnsy
X-Gm-Gg: ASbGnctgslvrYNtXJ+u5JVfONN9nf+bM/Oh7nkWNjmseARCRKWJXvIUPwlFGK6VnqVE
 Qb8m9WnIGGWHM/74XL+4Ntqoj63IUJic+WiWZn8SBigVl/mIugXw691OzqRl9TZ/xFDnp1rV/jp
 ZhENWGyNwxlCMMuqrHpjRjgcQtZQE71aYjT33+ojJPcDoIyJFkU5DfVmQGfxX5rcdbXpcA3qmBa
 WuVvAkFKIe4LDn6c1AaGYHsXwo7W4X2weQ36ZLebYcAyF3k/6EtyPfMMbMZSJo3TcrZj5wD6wRl
 qHQcvsF5SkiRvlfoPY0bcH0D9mQpJKZFMO78rYpJU56JR4RWT314kymoVka4lAMoUo0Q
X-Google-Smtp-Source: AGHT+IEk5cUxa5igAyqTVLGP/ed1g+vshxe2NPkqgXw52+gFYWurM1UXbcbYD9jfUgNa0YaAoWF6MQ==
X-Received: by 2002:a05:6402:51c7:b0:5db:68bd:ab78 with SMTP id
 4fb4d7f45d1cf-5f362fb5495mr3019556a12.10.1744388132684; 
 Fri, 11 Apr 2025 09:15:32 -0700 (PDT)
Received: from localhost.localdomain ([80.90.89.143])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f526da3sm1136246a12.67.2025.04.11.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:15:32 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: trini@konsulko.com, macromorgan@hotmail.com, uwu@icenowy.me,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/5] sunxi: h6: dram: split dram_para struct
Date: Fri, 11 Apr 2025 18:14:38 +0200
Message-ID: <20250411161439.4743-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411161439.4743-1-jernej.skrabec@gmail.com>
References: <20250411161439.4743-1-jernej.skrabec@gmail.com>
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

This change is same as in 78aa00c38e86 ("sunxi: H616: dram: split struct
dram_para"), but for H6. This is needed in order to extract common code
between H6 and H616 later.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h6.h   |   7 +-
 arch/arm/mach-sunxi/dram_sun50i_h6.c          | 145 ++++++++++--------
 2 files changed, 82 insertions(+), 70 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
index f05a1845b32b..af6cd337d7e0 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
@@ -315,12 +315,15 @@ check_member(sunxi_mctl_phy_reg, dx[3].reserved_0xf0, 0xaf0);
 struct dram_para {
 	u32 clk;
 	enum sunxi_dram_type type;
+	const u8 dx_read_delays[NR_OF_BYTE_LANES][RD_LINES_PER_BYTE_LANE];
+	const u8 dx_write_delays[NR_OF_BYTE_LANES][WR_LINES_PER_BYTE_LANE];
+};
+
+struct dram_config {
 	u8 cols;
 	u8 rows;
 	u8 ranks;
 	u8 bus_full_width;
-	const u8 dx_read_delays[NR_OF_BYTE_LANES][RD_LINES_PER_BYTE_LANE];
-	const u8 dx_write_delays[NR_OF_BYTE_LANES][WR_LINES_PER_BYTE_LANE];
 };
 
 static inline int ns_to_t(int nanoseconds)
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 24b2cb1579f4..6a9e53f965eb 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -35,13 +35,16 @@
  */
 
 static void mctl_sys_init(u32 clk_rate);
-static void mctl_com_init(const struct dram_para *para);
-static bool mctl_channel_init(const struct dram_para *para);
+static void mctl_com_init(const struct dram_para *para,
+			  const struct dram_config *config);
+static bool mctl_channel_init(const struct dram_para *para,
+			      const struct dram_config *config);
 
-static bool mctl_core_init(struct dram_para *para)
+static bool mctl_core_init(const struct dram_para *para,
+			   const struct dram_config *config)
 {
 	mctl_sys_init(para->clk);
-	mctl_com_init(para);
+	mctl_com_init(para, config);
 	switch (para->type) {
 	case SUNXI_DRAM_TYPE_LPDDR3:
 	case SUNXI_DRAM_TYPE_DDR3:
@@ -50,7 +53,7 @@ static bool mctl_core_init(struct dram_para *para)
 	default:
 		panic("Unsupported DRAM type!");
 	};
-	return mctl_channel_init(para);
+	return mctl_channel_init(para, config);
 }
 
 /* PHY initialisation */
@@ -196,15 +199,15 @@ static void mctl_sys_init(u32 clk_rate)
 	writel(0x8000, &mctl_ctl->unk_0x00c);
 }
 
-static void mctl_set_addrmap(const struct dram_para *para)
+static void mctl_set_addrmap(const struct dram_config *config)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-	u8 cols = para->cols;
-	u8 rows = para->rows;
-	u8 ranks = para->ranks;
+	u8 cols = config->cols;
+	u8 rows = config->rows;
+	u8 ranks = config->ranks;
 
-	if (!para->bus_full_width)
+	if (!config->bus_full_width)
 		cols -= 1;
 
 	/* Ranks */
@@ -282,7 +285,8 @@ static void mctl_set_addrmap(const struct dram_para *para)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-static void mctl_com_init(const struct dram_para *para)
+static void mctl_com_init(const struct dram_para *para,
+			  const struct dram_config *config)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
@@ -292,7 +296,7 @@ static void mctl_com_init(const struct dram_para *para)
 			(struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
 	u32 reg_val, tmp;
 
-	mctl_set_addrmap(para);
+	mctl_set_addrmap(config);
 
 	setbits_le32(&mctl_com->cr, BIT(31));
 
@@ -311,12 +315,12 @@ static void mctl_com_init(const struct dram_para *para)
 	clrsetbits_le32(&mctl_com->unk_0x008, 0x3f00, reg_val);
 
 	/* TODO: DDR4 */
-	reg_val = MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(para->ranks);
+	reg_val = MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(config->ranks);
 	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
 		reg_val |= MSTR_DEVICETYPE_LPDDR3;
 	if (para->type == SUNXI_DRAM_TYPE_DDR3)
 		reg_val |= MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
-	if (para->bus_full_width)
+	if (config->bus_full_width)
 		reg_val |= MSTR_BUSWIDTH_FULL;
 	else
 		reg_val |= MSTR_BUSWIDTH_HALF;
@@ -328,7 +332,7 @@ static void mctl_com_init(const struct dram_para *para)
 		reg_val = DCR_DDR3 | DCR_DDR8BANK | DCR_DDR2T;
 	writel(reg_val | 0x400, &mctl_phy->dcr);
 
-	if (para->ranks == 2)
+	if (config->ranks == 2)
 		writel(0x0303, &mctl_ctl->odtmap);
 	else
 		writel(0x0201, &mctl_ctl->odtmap);
@@ -346,7 +350,7 @@ static void mctl_com_init(const struct dram_para *para)
 	}
 	writel(reg_val, &mctl_ctl->odtcfg);
 
-	if (!para->bus_full_width) {
+	if (!config->bus_full_width) {
 		writel(0x0, &mctl_phy->dx[2].gcr[0]);
 		writel(0x0, &mctl_phy->dx[3].gcr[0]);
 	}
@@ -411,7 +415,8 @@ static void mctl_bit_delay_set(const struct dram_para *para)
 	}
 }
 
-static bool mctl_channel_init(const struct dram_para *para)
+static bool mctl_channel_init(const struct dram_para *para,
+			      const struct dram_config *config)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
@@ -446,14 +451,14 @@ static bool mctl_channel_init(const struct dram_para *para)
 
 	udelay(100);
 
-	if (para->ranks == 2)
+	if (config->ranks == 2)
 		setbits_le32(&mctl_phy->dtcr[1], 0x30000);
 	else
 		clrsetbits_le32(&mctl_phy->dtcr[1], 0x30000, 0x10000);
 
 	if (sunxi_dram_is_lpddr(para->type))
 		clrbits_le32(&mctl_phy->dtcr[1], BIT(1));
-	if (para->ranks == 2) {
+	if (config->ranks == 2) {
 		writel(0x00010001, &mctl_phy->rankidr);
 		writel(0x20000, &mctl_phy->odtcr);
 	} else {
@@ -555,11 +560,12 @@ static bool mctl_channel_init(const struct dram_para *para)
 	return true;
 }
 
-static void mctl_auto_detect_rank_width(struct dram_para *para)
+static void mctl_auto_detect_rank_width(const struct dram_para *para,
+					struct dram_config *config)
 {
 	/* this is minimum size that it's supported */
-	para->cols = 8;
-	para->rows = 13;
+	config->cols = 8;
+	config->rows = 13;
 
 	/*
 	 * Previous versions of this driver tried to auto detect the rank
@@ -575,68 +581,69 @@ static void mctl_auto_detect_rank_width(struct dram_para *para)
 	 */
 
 	debug("testing 32-bit width, rank = 2\n");
-	para->bus_full_width = 1;
-	para->ranks = 2;
-	if (mctl_core_init(para))
+	config->bus_full_width = 1;
+	config->ranks = 2;
+	if (mctl_core_init(para, config))
 		return;
 
 	debug("testing 32-bit width, rank = 1\n");
-	para->bus_full_width = 1;
-	para->ranks = 1;
-	if (mctl_core_init(para))
+	config->bus_full_width = 1;
+	config->ranks = 1;
+	if (mctl_core_init(para, config))
 		return;
 
 	debug("testing 16-bit width, rank = 2\n");
-	para->bus_full_width = 0;
-	para->ranks = 2;
-	if (mctl_core_init(para))
+	config->bus_full_width = 0;
+	config->ranks = 2;
+	if (mctl_core_init(para, config))
 		return;
 
 	debug("testing 16-bit width, rank = 1\n");
-	para->bus_full_width = 0;
-	para->ranks = 1;
-	if (mctl_core_init(para))
+	config->bus_full_width = 0;
+	config->ranks = 1;
+	if (mctl_core_init(para, config))
 		return;
 
 	panic("This DRAM setup is currently not supported.\n");
 }
 
-static void mctl_auto_detect_dram_size(struct dram_para *para)
+static void mctl_auto_detect_dram_size(const struct dram_para *para,
+				       struct dram_config *config)
 {
 	/* TODO: non-(LP)DDR3 */
 
 	/* detect row address bits */
-	para->cols = 8;
-	para->rows = 18;
-	mctl_core_init(para);
+	config->cols = 8;
+	config->rows = 18;
+	mctl_core_init(para, config);
 
-	for (para->rows = 13; para->rows < 18; para->rows++) {
+	for (config->rows = 13; config->rows < 18; config->rows++) {
 		/* 8 banks, 8 bit per byte and 16/32 bit width */
-		if (mctl_mem_matches((1 << (para->rows + para->cols +
-					    4 + para->bus_full_width))))
+		if (mctl_mem_matches((1 << (config->rows + config->cols +
+					    4 + config->bus_full_width))))
 			break;
 	}
 
 	/* detect column address bits */
-	para->cols = 11;
-	mctl_core_init(para);
+	config->cols = 11;
+	mctl_core_init(para, config);
 
-	for (para->cols = 8; para->cols < 11; para->cols++) {
+	for (config->cols = 8; config->cols < 11; config->cols++) {
 		/* 8 bits per byte and 16/32 bit width */
-		if (mctl_mem_matches(1 << (para->cols + 1 +
-					   para->bus_full_width)))
+		if (mctl_mem_matches(1 << (config->cols + 1 +
+					   config->bus_full_width)))
 			break;
 	}
 }
 
-unsigned long mctl_calc_size(struct dram_para *para)
+unsigned long mctl_calc_size(const struct dram_config *config)
 {
-	u8 width = para->bus_full_width ? 4 : 2;
+	u8 width = config->bus_full_width ? 4 : 2;
 
 	/* TODO: non-(LP)DDR3 */
 
 	/* 8 banks */
-	return (1ULL << (para->cols + para->rows + 3)) * width * para->ranks;
+	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
 }
 
 #define SUN50I_H6_LPDDR3_DX_WRITE_DELAYS			\
@@ -661,36 +668,38 @@ unsigned long mctl_calc_size(struct dram_para *para)
 	 {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },	\
 	 {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 }}
 
-unsigned long sunxi_dram_init(void)
-{
-	struct sunxi_mctl_com_reg * const mctl_com =
-			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
-	struct sunxi_prcm_reg *const prcm =
-		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
-	struct dram_para para = {
-		.clk = CONFIG_DRAM_CLK,
+static const struct dram_para para = {
+	.clk = CONFIG_DRAM_CLK,
 #ifdef CONFIG_SUNXI_DRAM_H6_LPDDR3
-		.type = SUNXI_DRAM_TYPE_LPDDR3,
-		.dx_read_delays  = SUN50I_H6_LPDDR3_DX_READ_DELAYS,
-		.dx_write_delays = SUN50I_H6_LPDDR3_DX_WRITE_DELAYS,
+	.type = SUNXI_DRAM_TYPE_LPDDR3,
+	.dx_read_delays  = SUN50I_H6_LPDDR3_DX_READ_DELAYS,
+	.dx_write_delays = SUN50I_H6_LPDDR3_DX_WRITE_DELAYS,
 #elif defined(CONFIG_SUNXI_DRAM_H6_DDR3_1333)
-		.type = SUNXI_DRAM_TYPE_DDR3,
-		.dx_read_delays  = SUN50I_H6_DDR3_DX_READ_DELAYS,
-		.dx_write_delays = SUN50I_H6_DDR3_DX_WRITE_DELAYS,
+	.type = SUNXI_DRAM_TYPE_DDR3,
+	.dx_read_delays  = SUN50I_H6_DDR3_DX_READ_DELAYS,
+	.dx_write_delays = SUN50I_H6_DDR3_DX_WRITE_DELAYS,
 #endif
-	};
+};
+
+unsigned long sunxi_dram_init(void)
+{
+	struct sunxi_mctl_com_reg * const mctl_com =
+			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
+	struct sunxi_prcm_reg *const prcm =
+		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
+	struct dram_config config;
 
 	unsigned long size;
 
 	setbits_le32(&prcm->res_cal_ctrl, BIT(8));
 	clrbits_le32(&prcm->ohms240, 0x3f);
 
-	mctl_auto_detect_rank_width(&para);
-	mctl_auto_detect_dram_size(&para);
+	mctl_auto_detect_rank_width(&para, &config);
+	mctl_auto_detect_dram_size(&para, &config);
 
-	mctl_core_init(&para);
+	mctl_core_init(&para, &config);
 
-	size = mctl_calc_size(&para);
+	size = mctl_calc_size(&config);
 
 	clrsetbits_le32(&mctl_com->cr, 0xf0, (size >> (10 + 10 + 4)) & 0xf0);
 
-- 
2.49.0

