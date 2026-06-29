Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B346C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C06ED84A5D;
	Mon, 29 Jun 2026 20:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YorwJgdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0308490A; Mon, 29 Jun 2026 20:20:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE0984A4C
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b29be0d6so9858345e9.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782757243; x=1783362043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=YorwJgdrXaNu37xaAw1+/Zw6/EHak5e1nz1J0HSfcsM89SJB1Z4GwMi3cSwmgGQO2R
 3yz4fbr8CqvVRC74fIITXY6MRXS1b46rUvOeWi851i/yj/fiQcb8cQiYM0ayXl6gUS9q
 tBWBHKrUX4bktwk0FDpsxP18jNSol8610qVTx+QyTaHhLKAjFNrswei/UlDC1oKvslDU
 iuBMUe6JCtbV8WO6oE6ZJLKzeyVjraBYdbkoFA2BASMBrwEgEwdHCsMFwMbDnnV6dt4h
 n8Tber8lxNk65IUQSyjZn1YkzTW9x2Eu17x4D9GXL6DqK2qThzFJ6tN04DLgNEddOh+i
 fMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757243; x=1783362043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UCtvqt7dvjWgVpWuwseVXOAtJOV1HOs35v4wF9L++aw=;
 b=J3IHoTebIRaQfDr5FTxLfkHQZ9FZbwrhmILFU43Ecoqi4JChPLxK0RbqBrm5GAD6mV
 oHkEBW5yLcFvHbltfaH1qXESE/Og77uM8MEvlGvs8GbPKsqX8TNU3eugrw1Q9TIH4nNN
 v7wrK8m7n9zetnVR8teg+goZgEJIylhPLa+VOp24bou85++C8++y/F+wpFLWBRygzslr
 wyfLxXrfi/e/EqNL+jS0TfBMkHd7tffUp5v7zTA9X33xwn+mAa1BqsD6nNl9lfkhUK5j
 Nu8i0bPE88X+EKa930IY7XNMmsSuK6hm9bVeW6UEplGrihP9z3FHbMr/FDpG0B9kQzym
 dRIw==
X-Gm-Message-State: AOJu0YwF+Cj7PPQoOfRQ6qfcb4DQuKlvXcQid8TDBzRiUB7iAoLVrrPW
 h4rw53hkj9P4iEgQratK6vY3Mv4+7oEu3xowUYWkbMY21vqYilziPdpLYpY2M9mj
X-Gm-Gg: AfdE7cmSc06fXlKkGpg8k105ugnMoJIkSrv59fKF02Tj0yips9NlJ5icgFr9u/5sbuK
 sX0WlLf2J5fsnNRrpam07FYIuV1EFsoEktp29k0REeeu8WSBNLaVnlIQiz1bTEfv6qJEdNnVBR5
 lHJBP9sBnX8FH02tFsE8Sn6eyIGDTBY6DQ+MV7reRYE9UdHjfGhBPEiVWyRtuDOshEKkeTznItE
 xMS8B052xNMF1lPjilgb255thz+wmGmd0E+RbCpGL2ikQetdI5SkH4V8hk6vTKb+6/BLIkY+5jJ
 I5xErBgqalZkjCw859Z2IpPrrc9jaIisqBBKwBDNYJFJ/BMIXjw0G4uTQGcS+8zijLCiBOsKOsu
 btZj9XKBd0emArkCQeLIxhEj68Si9VveJCzOm9yLZcATvICZ0U9o0o4nHYb4Qael8zIc8P8uJm0
 QsRcLRXeEwRJ0q70IcoVBT3BM/vZ0ZZ5fK37F9vHstH/Xku7Y1HQd6RAjv8ucI4kg=
X-Received: by 2002:a05:600c:468d:b0:493:b4a3:5ab0 with SMTP id
 5b1f17b1804b1-493b8ce0686mr4357995e9.13.1782757242482; 
 Mon, 29 Jun 2026 11:20:42 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c2954efsm219567015e9.2.2026.06.29.11.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:20:42 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v3 1/3] rockchip: rk3568: make the WDT trigger a first global
 reset
Date: Mon, 29 Jun 2026 20:20:10 +0200
Message-ID: <20260629182012.1508336-2-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
References: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
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

