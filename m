Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290CCE67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615448919F;
	Sat,  2 Nov 2024 23:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9UYraJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA4F89080; Sat,  2 Nov 2024 23:20:29 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D6F892DC
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720cb6ac25aso1908649b3a.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586022; x=1731190822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Tm6eWpdGGVlV/kjE3UzE3xt3/x2Y71r8b+cLnzd1O4=;
 b=X9UYraJU7MTAf7heU6zsgPR64n1/n9308xrT0ky1M6yYo6liEnxgNPbheR1+uu6xH3
 sTsoXHvseXaIAFScyxMRgV1q6fOHvNtQZvE++ZQzP6O9G+XxEtm/Sdh2rOts8XqpUJoH
 d7r1otVM58SAe9vAlSHdIlsXZ99turmn1P560=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586022; x=1731190822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Tm6eWpdGGVlV/kjE3UzE3xt3/x2Y71r8b+cLnzd1O4=;
 b=VNVqfHHr7e1xszxlsh/d8eB9I2JO1UWJZiSu4i1t1XLgxKSzQinaX3+fVWvQvgsPsH
 KO/XZ/8UuGlhz+1gcpj/TwL/g9mJ4KeqfDfLd/TyU8j7mrriR+v9YyBUoNJQJ8uSRbtL
 Fr9oHpAZE4B56M75TyKNP9jrEIRC9iRwYUtG+Xhw29BoRMY/ZXa2kPrI1/JltsbpyHwa
 DnQzVoQgvd6P6wzt/tRHVz4biF3A62zfyHvVrTxDj59dVQNA4RExA1lcBXD6Vv49MGGc
 hXFaIf4+EjH8u+stv/IYzXqss7Z+oufNrm8dUl6JREiW6S0zZRyoC1S2F65yO/9sEti9
 eV2A==
X-Gm-Message-State: AOJu0YwvM/qdJ6ctP+DbiC+YpS+RXsl+DdLBCjmMjRk26uQox+jxKKlx
 mRRkjgUtzhV6GOlv8tfhpa2e7yp8MoURsH1GHjNhphI/fgZ4gpetQtqaXeiFLkSndYESHqWmA3z
 JnA==
X-Google-Smtp-Source: AGHT+IG5xu68EAcXRergaZGetrVpWiJWQlYJBFfrVKXmjDqWFxnFdR7O5qEZOz46Njkt0tz22pY50g==
X-Received: by 2002:a05:6a20:c6ce:b0:1d8:a3ab:7228 with SMTP id
 adf61e73a8af0-1d9a81c3febmr35995310637.0.1730586022198; 
 Sat, 02 Nov 2024 15:20:22 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 03/25] mx23_olinuxino: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 16:17:01 -0600
Message-ID: <20241102221737.547938-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

Enable LED and LED_BOOT instead, since this is the new way to access the
LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Combine removal and enable patches

 board/olimex/mx23_olinuxino/mx23_olinuxino.c |  7 -------
 configs/mx23_olinuxino_defconfig             | 10 ++--------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
index b2bb6678c23..78136c1620a 100644
--- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
+++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
@@ -13,9 +13,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -61,9 +58,5 @@ int board_init(void)
 	/* Adress of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
 
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
-#endif
-
 	return 0;
 }
diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
index 3016f750e64..c1319077891 100644
--- a/configs/mx23_olinuxino_defconfig
+++ b/configs/mx23_olinuxino_defconfig
@@ -39,14 +39,8 @@ CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_MXS_GPIO=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=778
-CONFIG_LED_STATUS_STATE=2
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MMC_MXS=y
 CONFIG_CONS_INDEX=0
 CONFIG_DM_SERIAL=y
-- 
2.43.0

