Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B463C83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92608658B;
	Wed, 30 Aug 2023 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MCgRk+8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C51786575; Wed, 30 Aug 2023 20:05:52 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5E986552
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-792717ef3c9so1965139f.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418743; x=1694023543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QmwOjeeghn7SHtjqldiB/rtiZ9RGLf4qoLBk3JIRtI=;
 b=MCgRk+8lXiY1cdznbQh1XzGctzOi1GcHA+sqmogxTkfGJG8OZ03pWFKr7NNOjAqr28
 zXZ4vF5kFwCKvNbB9bk3hqMCqr9AeTrqed0N0ajs3Mla0znQe8/qG5ID1zT4boaul9Rg
 2U98fAz53fckqHvavzBGNWYADc0HYkf//jUGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418743; x=1694023543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QmwOjeeghn7SHtjqldiB/rtiZ9RGLf4qoLBk3JIRtI=;
 b=K2xGEGCap8cqSzT363yIlVSJkqb2d55dnhi3S2eSFrqd/bsg4AFwUMQCxGiYmpGGTh
 HKXLEENTcF5K0zr2OWkYIN7cNWVGgdX0PTTYBaROl4t+ikBU22ZBlJagk0p5vUPysEQa
 cC6whtn+lEZDwXcRA7hPSD7WXE0PudTyO1rwT+WYANoUjVea7jSIQb4h3e7r5NEde+gm
 zre2Isz+r95WygFJUYQuu5e/z3hcaBnRFAYV5MI208UOgtkNnqUL5I4cD5wiJOc8MoZc
 hsL29ZX0wA5xJ3As7+cbdG4D2uoCtNG4w/oJPjL4s0SVch2+ynMD7J8WleCzh+1pDjfI
 2oGw==
X-Gm-Message-State: AOJu0Yy/2vX9apx8lMr4vZxuDj4Iyg3m2AsC4Jx1G0VbGnkg1HfU+Q82
 qNx6c4Bb+mlNGuTKk1vejKI0gG3LkVXC277MDjw=
X-Google-Smtp-Source: AGHT+IFaGrNhJ9Z3azAxOPylxXBvEXdn1S7CN6O3OaND/XA6THw3Iw9fD0CYZ6B9nsFxX/FcfKZHRg==
X-Received: by 2002:a5e:9418:0:b0:787:4fd:abda with SMTP id
 q24-20020a5e9418000000b0078704fdabdamr3329880ioj.12.1693418743283; 
 Wed, 30 Aug 2023 11:05:43 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 07/32] spl: Avoid #ifdef with CONFIG_SPL_SYS_ARGS_ADDR
Date: Wed, 30 Aug 2023 12:04:38 -0600
Message-ID: <20230830180524.315916-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

Use IF_ENABLED_INT() to avoid needing to use the preprocessor. Give the
Kconfig option a default since we try to avoid hex values without
defaults.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/Kconfig |  1 +
 common/spl/spl.c   | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c23a1f7750b..e863aac2b34 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1067,6 +1067,7 @@ config SPL_SYS_ARGS_ADDR
 	hex "Address in memory to load 'args' file for Falcon Mode to"
 	depends on SPL_OS_BOOT
 	default 0x88000000 if ARCH_OMAP2PLUS
+	default 0
 	help
 	  Address in memory where the 'args' file, typically a device tree
 	  will be loaded in to memory.
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 77fe4cdb053..2da5bc0c4f5 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -814,9 +814,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	memset(&spl_image, '\0', sizeof(spl_image));
-#ifdef CONFIG_SPL_SYS_ARGS_ADDR
-	spl_image.arg = (void *)CONFIG_SPL_SYS_ARGS_ADDR;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_SYS_ARGS_ADDR)) {
+		spl_image.arg =
+			map_sysmem(IF_ENABLED_INT(CONFIG_SPL_OS_BOOT,
+						  CONFIG_SPL_SYS_ARGS_ADDR), 0);
+	}
 	spl_image.boot_device = BOOT_DEVICE_NONE;
 	board_boot_order(spl_boot_list);
 
@@ -873,8 +875,16 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	case IH_OS_LINUX:
 		debug("Jumping to Linux\n");
+		if (IS_ENABLED(CONFIG_SPL_SYS_ARGS_ADDR)) {
+			ulong addr;
+
+			addr = IF_ENABLED_INT(CONFIG_SPL_OS_BOOT,
+					      CONFIG_SPL_SYS_ARGS_ADDR);
+			spl_fixup_fdt(map_sysmem(addr, 0));
+		}
+	}
+
 #if defined(CONFIG_SPL_SYS_ARGS_ADDR)
-		spl_fixup_fdt((void *)CONFIG_SPL_SYS_ARGS_ADDR);
 #endif
 		spl_board_prepare_for_linux();
 		jump_to_image_linux(&spl_image);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

