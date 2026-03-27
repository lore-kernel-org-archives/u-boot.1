Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE4E10F2867
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A2783FA7;
	Fri, 27 Mar 2026 21:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p10y8z7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8057283DA7; Fri, 27 Mar 2026 21:10:06 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308548394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-464ba2bb3aeso1492537b6e.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774642201; x=1775247001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D81tqlM9p36aa6IXtx4qsIfEJnRmqGR3OB+YgHyg9Qg=;
 b=p10y8z7egd5Y3mFq0+Mye0ZVdO++J+zxGqcG6z0VFJGjfLItgsNoAGpI1iH4aTVSz9
 sLdnU5tA6cMU5o7bk5gYX2h2KX3Eh+LE2z3+u8rRj2+oShipSLdVoouBpC24CexhwOI/
 K38XvSF+vK5T58EBzQ4P5RShry5pu6G2lebPXrTPJ6HmlMsjzwEOb6OSuKvNmh9U2Anm
 IJTfHV4ZQJ25Yh34gXmTlttm32qZ6300/tzsf6JyxlKkIwrxu9psrR6MDxikd1zdSJLf
 P/lVmtSbIqnxE0RHBlbicOoPTHm0Ql2Q5nggIm47RVB7ZSFldwMT4ZovAyjJcK+NRlgK
 5oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774642201; x=1775247001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D81tqlM9p36aa6IXtx4qsIfEJnRmqGR3OB+YgHyg9Qg=;
 b=qB4DWbk1CVW4hyqoX8fLS7008zSDnD9pgL9DCilMA8uQrfDyjkjlqU2rJySOobKl7O
 H0l/wQqOfqRV0U2581Jv5lk8bReXobeorl3Rcg1a+DFyWMw5L45gOYkUpBWA/ZIUe1iA
 CSC6zdjnsY4hVBiOASzRPWy7TdUnMJnVM+Y4uE0ulAmj9eJkhRAgxrMzg77obmDXf1WA
 KGZtlstDc0vbYfQJIDujJDZcUUciy9Jk3nixx1kcuzKyKabccFn0HLiEd9qbQWe2bXv5
 1oS9PnupZmE7FCHe/8VHiQBH4leNYO0BDMZlFRLXSgHHnZuThZT6esRYIU6rBpU+sUrh
 9fFQ==
X-Gm-Message-State: AOJu0YxBlosdZh59nonN6VdBPEwjRjruL0kEa04YGCEIf+zDW9c6zthK
 zAju+sFlGx7JheeA7CWspmwEo9QzqsQBlvZY+PbRNJbgXmQ/t4D3GMMpCaxMKR9h
X-Gm-Gg: ATEYQzzlRTIjCXlyo22NLnCw7vL9/rTF6Ywthsq5b+VnDgGFeBYgcdHVlTdebaScvht
 rOfnh0vLlBiI54XGUPzxT5eNgSG0Jqir/9/c3BJ2OETFYKW+D1aWmX5jC69jXjBUTN7jSv5p8A7
 ATq8vZ6vDJh6l6GWDCF9dnESVkO0PcS6lODbi9B1Ua4W9Ic4WRV9AHCS8yyG9aE3jg2H7/S7xGO
 JW/uEJ6V8AkqpvgZDM/4UWG5v15WaQVW+apc4HZHReCMl0JiN8E0ylFS6Zy6Zqo2IrKu/QphF0V
 +BjvIXJItwvd/vpqrR0IVhziuvmupHdKjq7VRaojhQNF75n0EgIEWtKDRr0dPobVDFgXfUIUUir
 AQFoZrpVDc0iSoe0C11t+C6rUw7Jxz1lvHMDWGVWQSDEfk3CLoUGidH8/P3i/GfS6IgOfBl+Ypk
 MV2Q8YHrF8fptjfnQlhsfy2QQU90Gv2R1CqSinWInZp2X6xVKKmOtosI6oBF4z3yC/s//1ZnZOG
 TyvxXybJayB/iS+wSLoYGuF7Hdlry8IP+pMx+WUs3lWF9D1UWKAxBgrIZsa
X-Received: by 2002:a05:6808:1585:b0:467:317:805a with SMTP id
 5614622812f47-46a7aa0c450mr2683421b6e.26.1774642200878; 
 Fri, 27 Mar 2026 13:10:00 -0700 (PDT)
Received: from james-x399.localdomain (71-33-142-50.hlrn.qwest.net.
 [71.33.142.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b5b41sm166102a34.15.2026.03.27.13.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:10:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Alexander Graf <agraf@csgraf.de>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v4 3/5] sunxi: h616: split timing and PHY init helpers by DRAM
 type
Date: Fri, 27 Mar 2026 14:09:14 -0600
Message-ID: <20260327200932.2016910-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327200932.2016910-1-james.hilliard1@gmail.com>
References: <20260327200932.2016910-1-james.hilliard1@gmail.com>
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

Give each H616 timing file its own timing entry point and PHY
initialisation accessor, then dispatch to them through inline
helpers in the H616 header.

This keeps the current fixed-profile build model intact while
making the common H616 code consume DRAM-type-specific helpers
through a uniform interface.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h | 34 +++++++++++++++++--
 arch/arm/mach-sunxi/dram_sun50i_h616.c        |  1 +
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  | 12 ++++---
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c | 12 ++++---
 .../dram_timings/h616_lpddr4_2133.c           | 12 ++++---
 5 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index fa12d5d2685..6dab3b4832b 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -177,7 +177,37 @@ static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
-extern const u8 *phy_init;
-void mctl_set_timing_params(const struct dram_para *para);
+void h616_ddr3_set_timing_params(const struct dram_para *para);
+void h616_lpddr3_set_timing_params(const struct dram_para *para);
+void h616_lpddr4_set_timing_params(const struct dram_para *para);
+
+const u8 *h616_ddr3_get_phy_init(void);
+const u8 *h616_lpddr3_get_phy_init(void);
+const u8 *h616_lpddr4_get_phy_init(void);
+
+static inline void mctl_set_timing_params(const struct dram_para *para)
+{
+#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
+	h616_ddr3_set_timing_params(para);
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
+	h616_lpddr3_set_timing_params(para);
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+	h616_lpddr4_set_timing_params(para);
+#endif
+}
+
+static inline const u8 *h616_get_phy_init(const struct dram_para *para)
+{
+	(void)para;
+
+#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
+	return h616_ddr3_get_phy_init();
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
+	return h616_lpddr3_get_phy_init();
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+	return h616_lpddr4_get_phy_init();
+#endif
+	return NULL;
+}
 
 #endif /* _SUNXI_DRAM_SUN50I_H616_H */
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 5ee1ca25311..c3e1286fb35 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -869,6 +869,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+	const u8 *phy_init = h616_get_phy_init(para);
 	u32 val, val2, *ptr, mr0, mr2;
 	int i;
 
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index f367f604d5f..20c90f20cb9 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -28,11 +28,15 @@ static const u8 h616_ddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
 	0x06, 0x09, 0x0f
 };
 
-const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
-		     h616_ddr3_phy_init_addr_map_1 :
-		     h616_ddr3_phy_init_default;
+const u8 *h616_ddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_ddr3_phy_init_addr_map_1;
+
+	return h616_ddr3_phy_init_default;
+}
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_ddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index 7efb1b22a84..23b29cc973c 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -28,11 +28,15 @@ static const u8 h616_lpddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
 	0x08, 0x01, 0x1a
 };
 
-const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
-		     h616_lpddr3_phy_init_addr_map_1 :
-		     h616_lpddr3_phy_init_default;
+const u8 *h616_lpddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr3_phy_init_addr_map_1;
+
+	return h616_lpddr3_phy_init_default;
+}
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_lpddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index 055d8dd3cad..c19ae025f75 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -26,11 +26,15 @@ static const u8 h616_lpddr4_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
 	0x18, 0x04, 0x1a
 };
 
-const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
-		     h616_lpddr4_phy_init_addr_map_1 :
-		     h616_lpddr4_phy_init_default;
+const u8 *h616_lpddr4_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr4_phy_init_addr_map_1;
+
+	return h616_lpddr4_phy_init_default;
+}
 
-void mctl_set_timing_params(const struct dram_para *para)
+void h616_lpddr4_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-- 
2.43.0

