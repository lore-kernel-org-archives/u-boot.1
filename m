Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAC810F2867
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E7C83FAF;
	Fri, 27 Mar 2026 21:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B+/FsObM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3830983FA7; Fri, 27 Mar 2026 21:10:01 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7958394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso1708901a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774642197; x=1775246997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1PzgCuunsNOT2GKEFj0EWNMYKiUyLhbM9iVZXmRt4Q=;
 b=B+/FsObMQ87iIYFreNYC0zYd1z/2guYh6rDS4vKWT52ZFFlLYD/TkKkuo70OEynFJ7
 56fOYmUn1p3NJSk5du6+zOrvh92LTifzGnAhMRg67+GYKz3isxGN3YKTz2Gz1ilVK13R
 OsktppFoot3f8/nzK9390Ha5i3kvXHo6hhDm6y/9hfkUqq28L9tR9wba129jlE/JQofM
 QATVmFYXwv7NiSdHIumR+Sd6Wv6VCbWlozhSCl1I5sS3KESrxorpd1p20ciXWeidjh0O
 m+m4Fx5lt0iJ1D4pcv+og3hyE797PkXNJi1n79mJqZMgudhaPthnPLwIBRddd1gfxIzc
 vaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774642197; x=1775246997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1PzgCuunsNOT2GKEFj0EWNMYKiUyLhbM9iVZXmRt4Q=;
 b=MMAqexyppKTl3XAYEQaI9TnL2kpdYtEibW45Lm1WrQr8ZARrVY/kacjOdtCEjkcR0v
 OjiI80w4fd4nWR/dL9MB/CGpKPLyHS/8342ROUlLk6vLEGbkmsVNfyNh1RhMNZ42RL2P
 +Kg9v59Am+ETvkpmWCu996CpnrHWMtdpLq283SsoV8yBFaTse9CyFWpfePuNl+SclyMk
 EOIWtH6xiJQr8JfQdxIhV3yiLnjc8cRXhjiP47qxoIVA+p89JO8+8M77APDkCWFfovdq
 XVroeyC+Lu582j5AI93TR/AT3EDVFN5eTVh05gFYdajHZm863ekNjmTFgHgUeDtt4YFf
 4VNg==
X-Gm-Message-State: AOJu0Ywg8Dyst9xTZ4A7mnOQ0xtHjcSa9yk9BKWbi+YVCi8cwtyzXheb
 njK4ZYEskNcbWwaFoM5c9YHdKIw+bVJsNmJCPeMAlTReRdR9hRNFsNtR+vUVfw==
X-Gm-Gg: ATEYQzwDmNKan5yax8UlJSf963St0uJ52lRK6GLi17tbce0xiX+XN3pqr2YGB5someL
 /HenKaay5UNGzkMea1VibMJp9oES9Ky/+kgGvU6hitia8XatoyhUn1SJbLQBmSMK9rekkxziXnt
 xPa0myBOJPJTYGgqWbpxFH1dW2TqNoLqZAKfunov5nrOQWadXzfnB9WLoZirTtq4WvG+YxC08+z
 uGSdTFCst82+PXB8sn5ekrvXiXAIirboCU6zKUK+yhu5QecqT4lOjDNlDDul4TZ4iJnkI4UqqqK
 kgkERID7rp7oP8vj0eZ3VwyW3DI/bf9/zYGufdSo8XUPS1sPpf34qTMDV6Uwah2HatwoBocGYKQ
 dHesy1j3HW8vr508Q5Euk9Ai9227VnwQ2UV/xAEu7ds4rW02KEZgt5mv4vPUbxpKys/Okr7hqk8
 uy56h+8gLhCoQis9KZk9PJK+40iYrLki2KIKIXuS99M2ek+iwNw1gfh2n2JjhVnosLRa56tGPNq
 oPAFoRhJxSd8F74YDDfMY71Td7Eg5Cb0fCrnGtUzp97rO09BHpKZW2x/g14
X-Received: by 2002:a05:6830:710a:b0:7d9:b314:1452 with SMTP id
 46e09a7af769-7d9fad15978mr2161235a34.7.1774642197416; 
 Fri, 27 Mar 2026 13:09:57 -0700 (PDT)
Received: from james-x399.localdomain (71-33-142-50.hlrn.qwest.net.
 [71.33.142.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b5b41sm166102a34.15.2026.03.27.13.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:09:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 2/5] sunxi: h616: move PHY init tables into timing files
Date: Fri, 27 Mar 2026 14:09:13 -0600
Message-ID: <20260327200932.2016910-2-james.hilliard1@gmail.com>
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

Store the compile-time-selected PHY initialisation data alongside
each H616 timing implementation instead of in the common H616
DRAM code.

The common code still consumes a single phy_init pointer, so this
only moves the DRAM-type-specific data without changing the
selection model.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h |  3 ++
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 41 +------------------
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  | 18 ++++++++
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c | 18 ++++++++
 .../dram_timings/h616_lpddr4_2133.c           | 18 ++++++++
 5 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index c35ef0252cb..fa12d5d2685 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -168,6 +168,8 @@ struct dram_config {
 	u8 bus_full_width;
 };
 
+#define H616_PHY_INIT_LEN	27
+
 static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 {
 	const unsigned int ctrl_freq = para->clk / 2;
@@ -175,6 +177,7 @@ static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
+extern const u8 *phy_init;
 void mctl_set_timing_params(const struct dram_para *para);
 
 #endif /* _SUNXI_DRAM_SUN50I_H616_H */
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..5ee1ca25311 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -227,45 +227,6 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-#ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
-	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
-	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
-	0x06, 0x09, 0x0f
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
-	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
-	0x08, 0x01, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
-	0x18, 0x04, 0x1a
-#endif
-};
-#else /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
-static const u8 phy_init[] = {
-#ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
-	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
-	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
-	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
-	0x09, 0x05, 0x18
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR3)
-	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
-	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
-	0x17, 0x19, 0x1a
-#elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
-	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
-	0x18, 0x03, 0x1a
-#endif
-};
-#endif /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
 #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
 static void mctl_phy_configure_odt(const struct dram_para *para)
 {
@@ -964,7 +925,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
 
 	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
-	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
+	for (i = 0; i < H616_PHY_INIT_LEN; i++)
 		writel(phy_init[i], &ptr[i]);
 
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 1f0d0de198c..f367f604d5f 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -14,6 +14,24 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
+static const u8 h616_ddr3_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
+	0x0a, 0x15, 0x03, 0x13, 0x04, 0x0c, 0x10, 0x06,
+	0x0f, 0x11, 0x1a, 0x01, 0x12, 0x17, 0x00, 0x08,
+	0x09, 0x05, 0x18
+};
+
+static const u8 h616_ddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
+	0x14, 0x07, 0x04, 0x13, 0x0c, 0x00, 0x16, 0x1a,
+	0x0a, 0x11, 0x03, 0x10, 0x0e, 0x01, 0x0d, 0x19,
+	0x06, 0x09, 0x0f
+};
+
+const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
+		     h616_ddr3_phy_init_addr_map_1 :
+		     h616_ddr3_phy_init_default;
+
 void mctl_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index e753fd7b4af..7efb1b22a84 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -14,6 +14,24 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
+static const u8 h616_lpddr3_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x18, 0x06, 0x00, 0x05, 0x04, 0x03, 0x09, 0x02,
+	0x08, 0x01, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+	0x17, 0x19, 0x1a
+};
+
+static const u8 h616_lpddr3_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x18, 0x00, 0x04, 0x09, 0x06, 0x05, 0x02, 0x19,
+	0x17, 0x03, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x07,
+	0x08, 0x01, 0x1a
+};
+
+const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
+		     h616_lpddr3_phy_init_addr_map_1 :
+		     h616_lpddr3_phy_init_default;
+
 void mctl_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index bbe401464eb..055d8dd3cad 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -12,6 +12,24 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
+static const u8 h616_lpddr4_phy_init_default[H616_PHY_INIT_LEN] = {
+	0x02, 0x00, 0x17, 0x05, 0x04, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x03, 0x1a
+};
+
+static const u8 h616_lpddr4_phy_init_addr_map_1[H616_PHY_INIT_LEN] = {
+	0x03, 0x00, 0x17, 0x05, 0x02, 0x19, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x01,
+	0x18, 0x04, 0x1a
+};
+
+const u8 *phy_init = IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1) ?
+		     h616_lpddr4_phy_init_addr_map_1 :
+		     h616_lpddr4_phy_init_default;
+
 void mctl_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
-- 
2.43.0

