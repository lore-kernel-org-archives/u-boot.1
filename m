Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD21410854B6
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 00:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19EB84242;
	Sun, 15 Mar 2026 01:55:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwC1toxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AC884286; Sun, 15 Mar 2026 01:55:27 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6C68420D
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 01:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4673790ab85so2268619b6e.3
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773536124; x=1774140924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RhVncFdpraN4RU63OggrJlEKtmlB/fWr7Qm0+sTeJr0=;
 b=BwC1toxq9BSUVIXpDNTIQycsP3mRb69dwSik5i+J1DSRfzmw2vW023kG2U7i4EFLsI
 SNGhx5PqlN53Ap37x/uYF4OlSOxcqi7nG+n5y20YQdMJPQDDDLozwdiRKtSSfTrwOKFJ
 cuxh8zyLlcnkKHKguS3e5DYqAslR6GF7nuYTLtZsDERUkrqMnwTi1xCj62ybLtJeoFDu
 WjKcrExb6pWfkt895itGPflUTbCgB0CZB91qIpK2fbdqiikH6EZ4Gz8PVHkbVswAqQeh
 VgmRKbH95JkUubSjH/lYD2yCLBnryaGETF1uf2ZgIAohvDhPzFfI4keSLz49x+nUV7tR
 YMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773536124; x=1774140924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhVncFdpraN4RU63OggrJlEKtmlB/fWr7Qm0+sTeJr0=;
 b=MLYP9fNZjLw19GtxsP3MonTomKmJsYHBzM48IyYLJtBWu4HEyERtRRUe7KOnEXGk3A
 OjSsR1ZQNa1sCslNH+iHrlDefCdvA2xLLuCC+St2c30jwCpOB2wyoQ9z8y07kZphBPwf
 +ZNt0BZSPzJs2MfdWQ/3cqphET6cAIXRlYwuF1Zm7Wzi7InVcpyPfzay/S9AvmGAhvI1
 Q2fl7K5B53mp+U7HWhuAFH1YW8OZ0NXtX+oM5DMJ5lU+gY/9Io816LVJ/NYpQiBB2VHO
 Pgn7joLveCMBPPkOJVJ/X7MxbU1zpibz04p/7aSMiQHj3dccQL7KEwfP5FdNpwb0IAI7
 A5zg==
X-Gm-Message-State: AOJu0YxUAT1suIWYq/MRqSL6gbmQRYkyDpU/ktzdiXPiLwOd+AHqmhYz
 Nzhsyj4CTe5ErBgErdGy4SO+KJf0m6YB0/CdYWtrPzzj2+bv0rxgd5eTDFM6kA==
X-Gm-Gg: ATEYQzzGckLPMw2+Foqz4ubMV71joceQg2mn+Y9twPYT7QHbYix/l+YCI4vQnUheEba
 TyiiNx6lKoiBsGKV9vF262Z3yzmAvGt8meKe0DzfuAXkQ/mrSjswxlAqpWpH2lzFG8XMB9hQVBB
 yKDXe+g8goSgKHZrrsXkbEPN8waTIg8yRK7JeZJpp4Tb3lv/6D3T2KvA/55wnYgATqH9Fj8EY0P
 AET3/dbGtRncdYdC10cCUKNrOm4m7booM4XJDaSpBg5trtZZYJTQcFW0zhsNo8YHb2Nfuzx2whG
 Hk3KsNSc6IsRliXb5k+Ab+cdJRhZ5Cwc9G29z3Buzx6TixSojthGGFyhWzdQ3SwVeByVbQ0gqB3
 J1D1SldA963XYY02pVaT664zch47WV0SqoZ19Jpqtlgk4Och47WB5chwSsUjKym85PANepiCRbd
 9asv4WArPLyV9UeXXGGyimuC69tE3roeX9pwcvUymnzu8HwnsY/7V4GnczCxOLkn9GDVyBV21w3
 57LPPbOyc7fyo7VJ98e+XmP81m7sOQF67lspYNv22CJiwL7XnL/cEiHaKac
X-Received: by 2002:a05:6808:1645:b0:467:19fa:19f2 with SMTP id
 5614622812f47-46757196fd0mr4589459b6e.25.1773536123474; 
 Sat, 14 Mar 2026 17:55:23 -0700 (PDT)
Received: from james-x399.localdomain (71-33-158-51.hlrn.qwest.net.
 [71.33.158.51]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4673415d291sm7207195b6e.6.2026.03.14.17.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 17:55:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 1/1] sunxi: h616: prepare for runtime DRAM backend selection
Date: Sat, 14 Mar 2026 18:54:20 -0600
Message-ID: <20260315005422.471159-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Move the H616 PHY init tables into the per-DRAM-type timing files
and expose helpers to select the timing and PHY initialisation
data from the current DRAM parameters.

Also make ns_to_t() use dram_para->clk instead of
CONFIG_DRAM_CLK so a future caller can select the backend at
runtime.

Keep the existing fixed-profile Kconfig selection and linkage
unchanged by doing the dispatch in inline helpers, so current
H616 boards still build with only their selected backend linked
in.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h | 39 ++++++++++++--
 arch/arm/mach-sunxi/dram_sun50i_h616.c        | 42 +--------------
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  | 54 +++++++++++++------
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c | 54 +++++++++++++------
 .../dram_timings/h616_lpddr4_2133.c           | 54 +++++++++++++------
 5 files changed, 152 insertions(+), 91 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index a8fdda124a0..6dab3b4832b 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -168,13 +168,46 @@ struct dram_config {
 	u8 bus_full_width;
 };
 
-static inline int ns_to_t(int nanoseconds)
+#define H616_PHY_INIT_LEN	27
+
+static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 {
-	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
+	const unsigned int ctrl_freq = para->clk / 2;
 
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
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
index 3345c9b8e82..c3e1286fb35 100644
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
@@ -908,6 +869,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+	const u8 *phy_init = h616_get_phy_init(para);
 	u32 val, val2, *ptr, mr0, mr2;
 	int i;
 
@@ -964,7 +926,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 	writel(val2, SUNXI_DRAM_PHY0_BASE + 0x37c);
 
 	ptr = (u32 *)(SUNXI_DRAM_PHY0_BASE + 0xc0);
-	for (i = 0; i < ARRAY_SIZE(phy_init); i++)
+	for (i = 0; i < H616_PHY_INIT_LEN; i++)
 		writel(phy_init[i], &ptr[i]);
 
 	if (para->tpr10 & TPR10_CA_BIT_DELAY)
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd97..20c90f20cb9 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -14,33 +14,55 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
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
+const u8 *h616_ddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_ddr3_phy_init_addr_map_1;
+
+	return h616_ddr3_phy_init_default;
+}
+
+void h616_ddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 2;			/* JEDEC: 4nCK */
-	u8 tfaw		= ns_to_t(50);		/* JEDEC: 30 ns w/ 1K pages */
-	u8 trrd		= max(ns_to_t(6), 4);	/* JEDEC: max(6 ns, 4nCK) */
-	u8 trcd		= ns_to_t(15);		/* JEDEC: 13.5 ns */
-	u8 trc		= ns_to_t(53);		/* JEDEC: 49.5 ns */
-	u8 txp		= max(ns_to_t(6), 3);	/* JEDEC: max(6 ns, 3nCK) */
-	u8 trtp		= max(ns_to_t(8), 2);	/* JEDEC: max(7.5 ns, 4nCK) */
-	u8 trp		= ns_to_t(15);		/* JEDEC: >= 13.75 ns */
-	u8 tras		= ns_to_t(38);		/* JEDEC >= 36 ns, <= 9*trefi */
-	u16 trefi	= ns_to_t(7800) / 32;	/* JEDEC: 7.8us@Tcase <= 85C */
-	u16 trfc	= ns_to_t(350);		/* JEDEC: 160 ns for 2Gb */
+	u8 tfaw		= ns_to_t(para, 50);	/* JEDEC: 30 ns w/ 1K pages */
+	u8 trrd		= max(ns_to_t(para, 6), 4); /* JEDEC: max(6 ns, 4nCK) */
+	u8 trcd		= ns_to_t(para, 15);	/* JEDEC: 13.5 ns */
+	u8 trc		= ns_to_t(para, 53);	/* JEDEC: 49.5 ns */
+	u8 txp		= max(ns_to_t(para, 6), 3); /* JEDEC: max(6 ns, 3nCK) */
+	u8 trtp		= max(ns_to_t(para, 8), 2); /* JEDEC: max(7.5 ns, 4nCK) */
+	u8 trp		= ns_to_t(para, 15);	/* JEDEC: >= 13.75 ns */
+	u8 tras		= ns_to_t(para, 38);	/* JEDEC >= 36 ns, <= 9*trefi */
+	u16 trefi	= ns_to_t(para, 7800) / 32; /* JEDEC: 7.8us@Tcase <= 85C */
+	u16 trfc	= ns_to_t(para, 350);	/* JEDEC: 160 ns for 2Gb */
 	u16 txsr	= 4;			/* ? */
 
 	u8 tmrw		= 0;			/* ? */
 	u8 tmrd		= 4;			/* JEDEC: 4nCK */
-	u8 tmod		= max(ns_to_t(15), 12);	/* JEDEC: max(15 ns, 12nCK) */
-	u8 tcke		= max(ns_to_t(6), 3);	/* JEDEC: max(5.625 ns, 3nCK) */
-	u8 tcksrx	= max(ns_to_t(10), 4);	/* JEDEC: max(10 ns, 5nCK) */
-	u8 tcksre	= max(ns_to_t(10), 4);	/* JEDEC: max(10 ns, 5nCK) */
+	u8 tmod		= max(ns_to_t(para, 15), 12); /* JEDEC: max(15 ns, 12nCK) */
+	u8 tcke		= max(ns_to_t(para, 6), 3); /* JEDEC: max(5.625 ns, 3nCK) */
+	u8 tcksrx	= max(ns_to_t(para, 10), 4); /* JEDEC: max(10 ns, 5nCK) */
+	u8 tcksre	= max(ns_to_t(para, 10), 4); /* JEDEC: max(10 ns, 5nCK) */
 	u8 tckesr	= tcke + 1;		/* JEDEC: tCKE(min) + 1nCK */
 	u8 trasmax	= (para->clk / 2) / 15;	/* JEDEC: tREFI * 9 */
-	u8 txs		= ns_to_t(360) / 32;	/* JEDEC: max(5nCK,tRFC+10ns) */
+	u8 txs		= ns_to_t(para, 360) / 32; /* JEDEC: max(5nCK,tRFC+10ns) */
 	u8 txsdll	= 16;			/* JEDEC: 512 nCK */
 	u8 txsabort	= 4;			/* ? */
 	u8 txsfast	= 4;			/* ? */
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
index ce2ffa7a020..23b29cc973c 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -14,33 +14,55 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
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
+const u8 *h616_lpddr3_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr3_phy_init_addr_map_1;
+
+	return h616_lpddr3_phy_init_default;
+}
+
+void h616_lpddr3_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 2;
-	u8 tfaw		= ns_to_t(50);
-	u8 trrd		= max(ns_to_t(6), 4);
-	u8 trcd		= ns_to_t(24);
-	u8 trc		= ns_to_t(70);
-	u8 txp		= max(ns_to_t(8), 3);
-	u8 trtp		= max(ns_to_t(8), 2);
-	u8 trp		= ns_to_t(27);
-	u8 tras		= ns_to_t(41);
-	u16 trefi	= ns_to_t(7800) / 64;
-	u16 trfc	= ns_to_t(210);
+	u8 tfaw		= ns_to_t(para, 50);
+	u8 trrd		= max(ns_to_t(para, 6), 4);
+	u8 trcd		= ns_to_t(para, 24);
+	u8 trc		= ns_to_t(para, 70);
+	u8 txp		= max(ns_to_t(para, 8), 3);
+	u8 trtp		= max(ns_to_t(para, 8), 2);
+	u8 trp		= ns_to_t(para, 27);
+	u8 tras		= ns_to_t(para, 41);
+	u16 trefi	= ns_to_t(para, 7800) / 64;
+	u16 trfc	= ns_to_t(para, 210);
 	u16 txsr	= 88;
 
 	u8 tmrw		= 5;
 	u8 tmrd		= 5;
-	u8 tmod		= max(ns_to_t(15), 12);
-	u8 tcke		= max(ns_to_t(6), 3);
-	u8 tcksrx	= max(ns_to_t(12), 4);
-	u8 tcksre	= max(ns_to_t(12), 4);
+	u8 tmod		= max(ns_to_t(para, 15), 12);
+	u8 tcke		= max(ns_to_t(para, 6), 3);
+	u8 tcksrx	= max(ns_to_t(para, 12), 4);
+	u8 tcksre	= max(ns_to_t(para, 12), 4);
 	u8 tckesr	= tcke + 2;
 	u8 trasmax	= (para->clk / 2) / 16;
-	u8 txs		= ns_to_t(360) / 32;
+	u8 txs		= ns_to_t(para, 360) / 32;
 	u8 txsdll	= 16;
 	u8 txsabort	= 4;
 	u8 txsfast	= 4;
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
index 6f5c4acbd62..c19ae025f75 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -12,30 +12,52 @@
 #include <asm/arch/dram.h>
 #include <asm/arch/cpu.h>
 
-void mctl_set_timing_params(const struct dram_para *para)
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
+const u8 *h616_lpddr4_get_phy_init(void)
+{
+	if (IS_ENABLED(CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1))
+		return h616_lpddr4_phy_init_addr_map_1;
+
+	return h616_lpddr4_phy_init_default;
+}
+
+void h616_lpddr4_set_timing_params(const struct dram_para *para)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
 	u8 tccd		= 4;
-	u8 tfaw		= ns_to_t(40);
-	u8 trrd		= max(ns_to_t(10), 2);
-	u8 trcd		= max(ns_to_t(18), 2);
-	u8 trc		= ns_to_t(65);
-	u8 txp		= max(ns_to_t(8), 2);
+	u8 tfaw		= ns_to_t(para, 40);
+	u8 trrd		= max(ns_to_t(para, 10), 2);
+	u8 trcd		= max(ns_to_t(para, 18), 2);
+	u8 trc		= ns_to_t(para, 65);
+	u8 txp		= max(ns_to_t(para, 8), 2);
 	u8 trtp		= 4;
-	u8 trp		= ns_to_t(21);
-	u8 tras		= ns_to_t(42);
-	u16 trefi	= ns_to_t(3904) / 32;
-	u16 trfc	= ns_to_t(280);
-	u16 txsr	= ns_to_t(190);
+	u8 trp		= ns_to_t(para, 21);
+	u8 tras		= ns_to_t(para, 42);
+	u16 trefi	= ns_to_t(para, 3904) / 32;
+	u16 trfc	= ns_to_t(para, 280);
+	u16 txsr	= ns_to_t(para, 190);
 
-	u8 tmrw		= max(ns_to_t(14), 5);
+	u8 tmrw		= max(ns_to_t(para, 14), 5);
 	u8 tmrd		= tmrw;
 	u8 tmod		= 12;
-	u8 tcke		= max(ns_to_t(15), 2);
-	u8 tcksrx	= max(ns_to_t(2), 2);
-	u8 tcksre	= max(ns_to_t(5), 2);
+	u8 tcke		= max(ns_to_t(para, 15), 2);
+	u8 tcksrx	= max(ns_to_t(para, 2), 2);
+	u8 tcksre	= max(ns_to_t(para, 5), 2);
 	u8 tckesr	= tcke;
 	u8 trasmax	= (trefi * 9) / 32;
 	u8 txs		= 4;
@@ -49,7 +71,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 
 	u8 twtp		= 24;
 	u8 twr2rd	= max(trrd, (u8)4) + 14;
-	u8 trd2wr	= (ns_to_t(4) + 17) - ns_to_t(1);
+	u8 trd2wr	= (ns_to_t(para, 4) + 17) - ns_to_t(para, 1);
 
 	/* set DRAM timing */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
-- 
2.43.0

