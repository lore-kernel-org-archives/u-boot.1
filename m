Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5260C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 19:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D327784AA2;
	Mon, 29 Jun 2026 21:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iuABne5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63D8384A9E; Mon, 29 Jun 2026 21:23:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801E284A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 21:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493a613571eso15218595e9.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782761025; x=1783365825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=iuABne5Dlz6o52IVhvoe6Ia2qLAaGtWbY2pp26sG9jcVxNvntzz42KYNuraSpAqdhm
 roUx7o/a/ngrsRfs+owx+YpS9GdGpiGLusi9xs8BZ8uuX1uyT9N2Hc+AeSliSjSsC+tO
 L5PY4zw9GzlyBBUWVCEv9CsCGKMx7Jx81+rzegjiqbgyhxzf3lD3MZn7SAC5dBMX+h7L
 afgH4OHINCXA/fq1NJy0KlHUQmK8hH+DmCKGdqYuF79pvKV+1QFbg86t6bPmoy0xK6u2
 KVSsJnbeDRaXOxNes50Uop7gzzS4IWbjLCbkW5m9HKrRBxejO/1+5gm/L94jbAjs31kW
 L6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782761025; x=1783365825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=awSjWykKYH6VIgZ5FlMCZbKJL/6gevSU8q3MSpZWhsmY4TqfyVzmIKhzW5I4IQKgs0
 POgp4hSrmK4v34BzeCoUbhvInYWCCs/ZupzuYfP+TSBlBoyY6mTD5uxe5UdxRN3IsoCS
 kCem9ZT1IFX9v7jojxSuhKG5f/N6Iux5LufzIPnlk07bTVlqeqfoRrpASbCsOIB3r0mh
 EgQhIQkZNeEDuu32s84MrPr2zS4Ud2kF/QzeHDwxfmZ0B8hD7EWXeDd7L4lxScVRigVb
 Ao+Caw4mRRQOLRILis7AFUgFEks45rZyIqOFPPKb8Tto8j2CQQQAl8wcssiLvSMTNe7x
 T1Yg==
X-Gm-Message-State: AOJu0YxvEzRPvjssQyywd3MGIUWWSugDfzWF7zPKNnTHOBbu2JJUGKr4
 lf8fpzol191yfcivwlvnvuP56Y0iAgODRYujO3P+/bBd/3LA0ct0YEWjfpXaoJwn
X-Gm-Gg: AfdE7ck8z+A86DZv/y2FRKJ72QKwwDSiPaQ71iYCzwYM/QfBJV6Ph9p7xYHlyo7jVAo
 xkTFv+CgsxCZhjnwklpUVLhd1nkaYkthjlIvWRLCbwBgecaf/+woCA9waFj1M1UBhHfsAGHL6B+
 p3IntVpZm2Do8EJE/VJ1w+Qtuo6RlGKyMvCIqySt/czNx26RKrrVi6t8WPMtmcHMRSHfl3Osr0w
 CilGwcmbCBF6OVkeHawK7jhmXhV02MjFS2FcWfy9RmbEMpG7Ra5qBrGoVnIfTY6Z0N+2Gy/l7/e
 L9DxNGUjIUlg10F+laCqBzrGNiFSYqLOMptBHVh+O7i6PmwzOHNMvNg7xRNa8DFpbu3D95fDldb
 JB6iosm1F+AaM/NSGSVjDTsTqrlpenph8zmoIN8nbBi+6+qzgFBY6LCQoQ/FeAn+iR07huJKcaI
 +WlPSrk9X/ooOINUvmogpul3pIeUC/yTjDILtKO6u8axzr4xn1kGcG1r8b+CpMB3M=
X-Received: by 2002:a05:600c:3b2a:b0:492:3fb1:e9b8 with SMTP id
 5b1f17b1804b1-493b828996cmr15417475e9.12.1782761024805; 
 Mon, 29 Jun 2026 12:23:44 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8b1csm8734785e9.9.2026.06.29.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:23:43 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v4 1/4] rockchip: rk3568: make the WDT trigger a first global
 reset
Date: Mon, 29 Jun 2026 21:23:33 +0200
Message-ID: <20260629192336.1555651-2-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
References: <20260629192336.1555651-1-andreas.zdziarstek@gmail.com>
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

Default is a second global reset which causes a system hang on a timeout
in U-Boot.

Access the register through the rk3568_cru struct to match how PX30 does
it in arch_cpu_init().

Verified on the Hardkernel ODROID-M1S (RK3566): a watchdog timeout now
cleanly reboots the board.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 2b1eafee37c..8bed529a5c1 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -9,6 +9,7 @@
 #include <misc.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/cru_rk3568.h>
 #include <asm/arch-rockchip/grf_rk3568.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <dt-bindings/clock/rk3568-cru.h>
@@ -37,6 +38,9 @@
 #define CPU_GRF_BASE		0xfdc30000
 #define GRF_CORE_PVTPLL_CON0	(0x10)
 
+#define CRU_BASE		0xfdd20000
+#define WDT_GLB_SRST_CTRL	BIT(1)
+
 /* PMU_GRF_GPIO0D_IOMUX_L */
 enum {
 	GPIO0D1_SHIFT		= 4,
@@ -117,6 +121,8 @@ void board_debug_uart_init(void)
 int arch_cpu_init(void)
 {
 #ifdef CONFIG_XPL_BUILD
+	static struct rk3568_cru * const cru = (void *)CRU_BASE;
+
 	/*
 	 * When perform idle operation, corresponding clock can
 	 * be opened or gated automatically.
@@ -145,6 +151,9 @@ int arch_cpu_init(void)
 	/* Enable VO power domain for display */
 	writel((PMU_PD_VO_DWN_ENA << 16),
 	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
+
+	/* Make WDT trigger a first global reset */
+	setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
 #endif
 	return 0;
 }
-- 
2.53.0

