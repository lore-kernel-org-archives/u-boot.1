Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C2C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A5584006;
	Fri, 11 Apr 2025 18:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCZID/Qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CCC383E96; Fri, 11 Apr 2025 18:15:31 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AECB83F15
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso3087374a12.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744388129; x=1744992929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuEQ9yrSToLHvjKmbeRLo8fL3rTd0BkEIt0ruhnjGGA=;
 b=BCZID/Qn1Qdp02kEHjypym8YCcAzGraZknMH/j9yoiNkpUZHu5Bc8kBaC4zBvlkBuc
 9wo90SnFWJJ4nxm9AxbjXOg1ogoMOsGebWbXtvhjfujpvyrihN1gN5GMjv+8s+TVoS7K
 s/q/J2RtU/G5ps8vby762tV7DTvXashfV4mnO39HWkWshQVXEYP2yVNz7px28IU3JqC4
 G94VRigDwERS1t+inyzk1APK18opVyoBF6EnjZz1XZ+UUSHEVGkunPvNw5FZ+tYw0RR/
 ECXlb5epEo5aQLtExDJe7SkH4AnlYvXpPR1BoV6L3+qsAATYRen6bgl7fJEX6RoB5nXv
 +Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388129; x=1744992929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuEQ9yrSToLHvjKmbeRLo8fL3rTd0BkEIt0ruhnjGGA=;
 b=lGyp5kuBxscD45/FJJA89QNICuQtWoqq7QchpChjCeGmFF9QuR03i3fxrzaE5qTYwX
 Tf09ddBygDawAPQape4FnMokX3yXji972GCNWIAZc6TIWkj+F1cRZYQ3LbdMjY9fxvGn
 zlH9WRq6Ask3ecYxL34Fb19gryP7nX5KMLPCv5TDZLztMvuy9/ozGrgNgbHJ6lJ4jr83
 ak5ErKsSR3dzWCJDMY/3bePn6XrOgR8M4tR4F6O5n1pmoNPInlsJRgW44knBZkDGs4Uv
 HJGaT23a/ID+fYq771fbP98T2RyZASYowWb451BoRqpzrvURwqrm8jHSbVRukq6of4BC
 r11w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiqgKGtFefjvki7v6b3V8/DHKmBMJ8fmCO+H1O3qVHpitntbzhNGXtHRRMx6X+MNcHC70A+jg=@lists.denx.de
X-Gm-Message-State: AOJu0YxrAbt/AKQ00PIBAVBnXLl+p/XT3weT3lsshp2CCMYKxkNNWGzr
 B2rNof7GArWQuSMn2/4JivzHZmGHG5xJ7FwEPEz9HPFsoJdzuj9W
X-Gm-Gg: ASbGncvBj8ZKJ8lJZfSUvM1IkQVXvAm4nENZK3p7WYjO2BrBsZH0PMqF43o4Xv+Q/s5
 g2Tz0nS502QB3HEuxE7avDZOjS3roqy07GWmVcqXCyr60lEsYt6Ti4qw38bwueDS3uiF+XQ3rjF
 hCdRqLbYGjhOQ9YJnHa39g4kjZlieXE7WQq62vHQ4AnFGUnPAXVz+PHNrDMxTtJDZ8EA0LX9dKR
 nelBFli6pHmMQWW2wot2IXC34JMbMtBW/1yJekFqJzLIrgEvwYaO5vo3w+BdLqAfYHHzJqRWJQY
 U7rb+bq1h/LdJj03/2VYaDV7E8C7FbUQgfwZmjf4wolYQ+NIcO3T4IPHkA==
X-Google-Smtp-Source: AGHT+IGHQBesIrBvfkPJHNy1sRjkhZq8DAy9QsZvpZANVTHrrv6Bl1KbGqVeMrme9oojWix/Efa9UQ==
X-Received: by 2002:a05:6402:51ce:b0:5e7:5b30:3c4f with SMTP id
 4fb4d7f45d1cf-5f36f77bab2mr2518097a12.14.1744388128650; 
 Fri, 11 Apr 2025 09:15:28 -0700 (PDT)
Received: from localhost.localdomain ([80.90.89.143])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f526da3sm1136246a12.67.2025.04.11.09.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:15:28 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: trini@konsulko.com, macromorgan@hotmail.com, uwu@icenowy.me,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/5] sunxi: H6: DRAM: Constify function parameters
Date: Fri, 11 Apr 2025 18:14:37 +0200
Message-ID: <20250411161439.4743-4-jernej.skrabec@gmail.com>
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

Constify parameters for two reasons:
- Allow more compile time optimizations
- It will allow later sharing of common code with H616 (when it will be
  rearranged some more)

Commit does same kind of changes as 457e2cd665bd ("sunxi: H616: dram:
const-ify DRAM function parameters")

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 0adbda756639..24b2cb1579f4 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -34,13 +34,13 @@
  * similar PHY is ZynqMP.
  */
 
-static void mctl_sys_init(struct dram_para *para);
-static void mctl_com_init(struct dram_para *para);
-static bool mctl_channel_init(struct dram_para *para);
+static void mctl_sys_init(u32 clk_rate);
+static void mctl_com_init(const struct dram_para *para);
+static bool mctl_channel_init(const struct dram_para *para);
 
 static bool mctl_core_init(struct dram_para *para)
 {
-	mctl_sys_init(para);
+	mctl_sys_init(para->clk);
 	mctl_com_init(para);
 	switch (para->type) {
 	case SUNXI_DRAM_TYPE_LPDDR3:
@@ -150,7 +150,7 @@ static void mctl_set_master_priority(void)
 	MBUS_CONF(HDCP2,  true,    HIGH, 2,  100,   64,   32);
 }
 
-static void mctl_sys_init(struct dram_para *para)
+static void mctl_sys_init(u32 clk_rate)
 {
 	struct sunxi_ccm_reg * const ccm =
 			(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
@@ -171,7 +171,7 @@ static void mctl_sys_init(struct dram_para *para)
 
 	/* Set PLL5 rate to doubled DRAM clock rate */
 	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN |
-	       CCM_PLL5_CTRL_N(para->clk * 2 / 24), &ccm->pll5_cfg);
+	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), &ccm->pll5_cfg);
 	mctl_await_completion(&ccm->pll5_cfg, CCM_PLL5_LOCK, CCM_PLL5_LOCK);
 
 	/* Configure DRAM mod clock */
@@ -196,7 +196,7 @@ static void mctl_sys_init(struct dram_para *para)
 	writel(0x8000, &mctl_ctl->unk_0x00c);
 }
 
-static void mctl_set_addrmap(struct dram_para *para)
+static void mctl_set_addrmap(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
@@ -282,7 +282,7 @@ static void mctl_set_addrmap(struct dram_para *para)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-static void mctl_com_init(struct dram_para *para)
+static void mctl_com_init(const struct dram_para *para)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
@@ -352,7 +352,7 @@ static void mctl_com_init(struct dram_para *para)
 	}
 }
 
-static void mctl_bit_delay_set(struct dram_para *para)
+static void mctl_bit_delay_set(const struct dram_para *para)
 {
 	struct sunxi_mctl_phy_reg * const mctl_phy =
 			(struct sunxi_mctl_phy_reg *)SUNXI_DRAM_PHY0_BASE;
@@ -411,7 +411,7 @@ static void mctl_bit_delay_set(struct dram_para *para)
 	}
 }
 
-static bool mctl_channel_init(struct dram_para *para)
+static bool mctl_channel_init(const struct dram_para *para)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
-- 
2.49.0

