Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FEB10F286A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 20:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5519483E7A;
	Fri, 27 Mar 2026 21:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qhvOTLL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033DA83DA7; Fri, 27 Mar 2026 21:09:58 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77E68394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 21:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so2091363a34.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774642194; x=1775246994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yb+91WANTYfIoBSwBVZ/Egwt/l3EltUFuvcCRUECruI=;
 b=qhvOTLL2W2Q/S9LkpC11qXQeRQjFUPOg5i5rdaNreMmj9s5+uDMAVqLwQ9CLrH8glJ
 1hEJJL1FRqItxTOYsOp4x+ZJye9FAuSiy0QEMtztr2ltBlMpa+sImZDdteGAyl5Fq7uW
 FIhFCJZuKigRyDyE6p5Gmv0Xx471R22ksK6wadQTuKqN7I2Dp2+hqfxCJ06lwjDySmK1
 3vzYbLfa+ihsEC/8R3GnIO9sQTkVcR43Kzfr5T+8plV714t+haK4Q685HATGX9m0rrkY
 9JA1S7w5a6ZSN5pKajNLdGU+6VuhFYVeUz6OVD9M8FS9t9+haVMi3XwO014LOEasfCZW
 dimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774642194; x=1775246994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yb+91WANTYfIoBSwBVZ/Egwt/l3EltUFuvcCRUECruI=;
 b=L3vizeZCJ8/lno0XyeiaCVqtXQuG4hwbMii8g9x5l+yIgT9zopXCUKMk1RbL9uEfet
 N2Aq4lEUxvb5kdMqH7pQ0I8ZoCkVEra1Ge17AXm+y9dhWmyo/0JvdFIdz2JHrPve0CJr
 o1JfB0G519DFyiVr3qcScLg4/L5s875LE989+SRlxzNPc9rqaqWpCzkuD6REZh0+jqir
 UM3VI3G7IggM89zAjWkNC0/gbeDUSypSka+f7Z32G/k4XWuNIoVkfAEMr3e6v73y3B7U
 FbL89qWBmRQLJX+FM3C4fLsh/kGFLOXBVa5AU1mf9i0Rdssmyaoa8ueeErF2wKeQv6+4
 xjpQ==
X-Gm-Message-State: AOJu0YzG/6enOONFP1woHCF5qi3WM018ceB/pSWaCwDGkFCDSaLSnm+m
 kX1FloyszVrE49QHr2Tr4PNEYk1bpae0ZteVT8ewNdmp0j8amv5npqe/DUo606bb
X-Gm-Gg: ATEYQzy6w0gMeC2AOj2WBrt5nxf6rD851bK5p3HvVFpv3yN/eeXbfyCU39eVIw07t5Q
 1hhVoGMXoK9EcWk4kiSx6XRLNBlNbT257A2BFnd6b3A010ct/50FZEjZ6dw6sBNm1jScc5KeV7L
 44rtDZTuZlK6qJuNoEiOrUJCainy7QtE8DSU/4Vbz0ThpCDI3E3TVy5cK9yMasPLvnJXCZnBrq5
 PlRRbsyDipdPwu+eW+yvbbhJtWbWFyRCpVDZaK2AvwZF/ftF86S2HybIBNpZrpFwTgVnoy7TR7j
 iIeMW+NFpX071TB8CD1AHnoqOPIYLuChPEgXL+VjvAGSvVDKdRZtruR124FKme84/TDxABVaabq
 XPoLIQr/5MLvXy1sAwsCC82Qw1KzVP9HFxTJLLCl8nrn/oM3YcfpH6EgS2AJsvSkM7XkcOI6V2L
 VDxtOtYjrxNkxI/I+RN9kZSk+9E1y+WnOZH2SJx4MWvWY3Oln5pcM2NDeLZxrpIQhgl6fdtoxB1
 eocCK+nAiYLR0E6qKQ76+QvRzP7Cb9IFwcrTFqwBOnO4fPTZgSN/RkYHyda
X-Received: by 2002:a05:6830:488f:b0:7c7:69c8:2d2 with SMTP id
 46e09a7af769-7d9fad77586mr2049433a34.13.1774642194036; 
 Fri, 27 Mar 2026 13:09:54 -0700 (PDT)
Received: from james-x399.localdomain (71-33-142-50.hlrn.qwest.net.
 [71.33.142.50]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a7b5b41sm166102a34.15.2026.03.27.13.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 13:09:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Alexander Graf <agraf@csgraf.de>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v4 1/5] sunxi: h616: make ns_to_t() use the DRAM clock
Date: Fri, 27 Mar 2026 14:09:12 -0600
Message-ID: <20260327200932.2016910-1-james.hilliard1@gmail.com>
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

Pass struct dram_para into ns_to_t() and derive the controller
clock from para->clk instead of CONFIG_DRAM_CLK.

This prepares the H616 timing code for selecting the DRAM
backend from runtime parameters instead of a fixed build-time
clock setting.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../include/asm/arch-sunxi/dram_sun50i_h616.h |  4 +--
 .../mach-sunxi/dram_timings/h616_ddr3_1333.c  | 30 +++++++++----------
 .../arm/mach-sunxi/dram_timings/h616_lpddr3.c | 30 +++++++++----------
 .../dram_timings/h616_lpddr4_2133.c           | 30 +++++++++----------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index a8fdda124a0..c35ef0252cb 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -168,9 +168,9 @@ struct dram_config {
 	u8 bus_full_width;
 };
 
-static inline int ns_to_t(int nanoseconds)
+static inline int ns_to_t(const struct dram_para *para, int nanoseconds)
 {
-	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
+	const unsigned int ctrl_freq = para->clk / 2;
 
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd97..1f0d0de198c 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -20,27 +20,27 @@ void mctl_set_timing_params(const struct dram_para *para)
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
index ce2ffa7a020..e753fd7b4af 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr3.c
@@ -20,27 +20,27 @@ void mctl_set_timing_params(const struct dram_para *para)
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
index 6f5c4acbd62..bbe401464eb 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
@@ -18,24 +18,24 @@ void mctl_set_timing_params(const struct dram_para *para)
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
@@ -49,7 +49,7 @@ void mctl_set_timing_params(const struct dram_para *para)
 
 	u8 twtp		= 24;
 	u8 twr2rd	= max(trrd, (u8)4) + 14;
-	u8 trd2wr	= (ns_to_t(4) + 17) - ns_to_t(1);
+	u8 trd2wr	= (ns_to_t(para, 4) + 17) - ns_to_t(para, 1);
 
 	/* set DRAM timing */
 	writel((twtp << 24) | (tfaw << 16) | (trasmax << 8) | tras,
-- 
2.43.0

