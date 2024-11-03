Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E92E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F9889110;
	Sun,  3 Nov 2024 01:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X2+xfQuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2CC8917E; Sun,  3 Nov 2024 01:34:53 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66928910E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cbcd71012so36010325ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594090; x=1731198890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Tm6eWpdGGVlV/kjE3UzE3xt3/x2Y71r8b+cLnzd1O4=;
 b=X2+xfQuXAdTvaOyMC0zkBVq7KgzpZ1FzOpk+lNceR3K4pk8RWkvWeD/Y5Rlw26OjBp
 CuYkAsNyqkc82ri0ouS3e3+MXMr49fxPrvv2x4wXnZHKYFfrmVd/wjdwtEtBLd7fy4J5
 JKO4fRCeOjlCpc7xnGikXdwqaPl/fLTkb2qxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594090; x=1731198890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Tm6eWpdGGVlV/kjE3UzE3xt3/x2Y71r8b+cLnzd1O4=;
 b=lOjNcc95J3VJF/l+zokBm9zUfLDoWX32YhIc9eVR9X+yKbjzesWia5MpnKOOkIA+PA
 4TfEELabChQ6VMkqeHb8M3tccI7OeLjF5Tty7jUkTemCs4Ig0bxGSiWESXA1PWC3iEfM
 0RmUSbXGtR948rfCf4ArYUUWJ6aoGY6EtaW3PCBYEh8c9QCWNPiC5H76RjwrnFhLwyzH
 cjAmslkqAxgoBsxge+usFchhL+vZlNNG3YWTTKIBKGckqyOFXRG8NyXz29H0zoDgoo2U
 DqPsWheNjwo/9LxYZYXPcTAZ/G+j1g3d3EEVUmYHYxSndz1OM4ZQv3c4GR8YRsk4c29+
 D0Og==
X-Gm-Message-State: AOJu0Yx8lSJFxID1XZT29hZOskENYu7Vv6r+xrxidOahwd7mEl+qBlED
 L5snmgmCd+DZjv/P4CCDVEtlIQ6aKCgQbsm4YmEUF0+FSD+SyNxTy7MM/qG6kfE7Oe+hJh8FQ2p
 NEQ==
X-Google-Smtp-Source: AGHT+IG19gTV5zfE+kWonpextnAWM+C1Dsu1RKyVnKJ9a/mwNb8gqi10fTGg8M7xdV6GbuufdKgzig==
X-Received: by 2002:a17:902:d2c4:b0:20c:8331:cb6e with SMTP id
 d9443c01a7336-2111aee4561mr109326985ad.19.1730594089662; 
 Sat, 02 Nov 2024 17:34:49 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:34:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 03/25] mx23_olinuxino: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 18:32:55 -0600
Message-ID: <20241103003322.626036-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

