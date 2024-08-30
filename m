Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C4CA1008
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385E788C8C;
	Fri, 30 Aug 2024 17:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sxw8ieU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FBA88C75; Fri, 30 Aug 2024 17:57:42 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFAD88C4D
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 17:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70f5cd2fa39so1380317a34.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725033459; x=1725638259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpkitDeuxRcNMfmg24HZXUmkTmVZb/2y6/y1WE/ozxo=;
 b=Sxw8ieU9yo02cSPlmyxZEMH3ytR+ow4Ww1WBAHwzZ9C5TvtzRYJ7A00QsthJ3TuG6V
 HEppCHtGf+iJDPCW1RMlHPEmqBhK0vP7LNWxu4rxYeJkyWaRK6bLNeu0gqfaHVvlVon1
 JzCswjRThpfjLT+oKo6PF2peoMXHTjcS3rEtULRbP+jfnJUg3lFvgfcbXf4NKj+za6nA
 dfhjUPUgG4J0TjC8UL6HudMTzFHA5gpnJpx1AfDDiKIxYNcRMsoBE4tDdok1/12o85io
 UiczO7JyplsGVmRAG8arYV2SbV5xSnlji3AeKF3gTmj9ZSXljSkEDbNR/76byi805zlp
 PBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725033459; x=1725638259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpkitDeuxRcNMfmg24HZXUmkTmVZb/2y6/y1WE/ozxo=;
 b=u7XI13pg+WEmqsSRshj1q9A6KwaIY/XVV0wlFt+YMLzzkuYMLIe6xmDKSue55FkFO+
 tJNgIbsYPYT0WM4o74HUmYy4PnVW07p+o3AVAFPVjJIH4qes2W5Da2OpNxCiF0FqtXmr
 ltvvsjhqLDSRySNhgOz0OOof0j90NSK3EhyyxaED4kXnRVPYl7lQYKy9ixDHemmKgNmX
 UPKQcPyqkExX5cCaqGdwHx5Rnwfr3wZf9PZIUw3+EnW7bkyVK5D/YJLFqB/SXjd0wpQt
 N9uOc5AwuNg466t32IcJZoyROzPS50xlTH/HMHjCynP+WiPYP+th00hNziR7ezwOXl6k
 /HYA==
X-Gm-Message-State: AOJu0Yy1K1j/Ka9lv/8HWldsmt+ECOXBx22cQmD5kVNLLn+scl+1K+bY
 yVQiqQ/L0JooEsDQbxaYni8+14wJTMkBv70FlalVpwFwKzDVqdm4a7EvNQ==
X-Google-Smtp-Source: AGHT+IEHBsIbpUfwp9qe8QeeuVXh6pwXCA+cq0f9HjAFaUyOSw9k5b4cxmj24YmXwJVJgQ+oXQ33hQ==
X-Received: by 2002:a05:6830:2c0c:b0:70f:674c:116c with SMTP id
 46e09a7af769-70f674c17f3mr3510067a34.24.1725033458765; 
 Fri, 30 Aug 2024 08:57:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70f671a8630sm490092a34.51.2024.08.30.08.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 08:57:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 2/9] sunxi: H616: DRAM: Add alternative pin mapping
Date: Fri, 30 Aug 2024 10:55:07 -0500
Message-Id: <20240830155514.481410-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830155514.481410-1-macroalpha82@gmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

It seems that different dies need different PHY pin mapping. Select
alternatives at compile time.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
[adapted to switch from runtime to compile time config]
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/Kconfig            | 17 +++++++++++++++++
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 22 +++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 17666814c5..078f8c19fa 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -108,6 +108,23 @@ config DRAM_SUN50I_H616_TPR12
 	default 0x0
 	help
 	  TPR12 value from vendor DRAM settings.
+
+choice
+	prompt "H616 PHY pin mapping selection"
+	default DRAM_SUN50I_H616_PHY_ADDR_MAP_0
+
+config DRAM_SUN50I_H616_PHY_ADDR_MAP_0
+	bool "H313/H616/H618"
+	help
+	  The pin mapping selection used by the H313, H616, H618, and
+	  possibly other dies which use the H616 DRAM controller.
+
+config DRAM_SUN50I_H616_PHY_ADDR_MAP_1
+	bool "H700"
+	help
+	  The pin mapping selection used by the H700 and possibly other
+	  dies which use the H616 DRAM controller.
+endchoice
 endif
 
 config SUN6I_PRCM
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 5be2887a06..52f7799173 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -225,6 +225,26 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
+#ifdef CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_1
+static const u8 phy_init[] = {
+#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
+	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
+	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
+	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
+	0x06, 0x09, 0x0f
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
+	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
+	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+	0x08, 0x01, 0x1a
+#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
+	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x04, 0x1a
+#endif
+};
+#else /* CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_0 */
 static const u8 phy_init[] = {
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
 	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
@@ -243,7 +263,7 @@ static const u8 phy_init[] = {
 	0x18, 0x03, 0x1a
 #endif
 };
-
+#endif /* CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_0 */
 #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
 static void mctl_phy_configure_odt(const struct dram_para *para)
 {
-- 
2.34.1

