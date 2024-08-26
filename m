Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE70C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8A888AD7;
	Mon, 26 Aug 2024 20:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CNvJOuqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB12388B63; Mon, 26 Aug 2024 20:05:08 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE91888F0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-714114be925so4020320b3a.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724695505; x=1725300305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nLPpVY5qQx/kfEBEol3Eo07j2//6zAKIHhYdW/33PE=;
 b=CNvJOuqJHh5Nn2CITZRPlUkslDTLnTmoZ5op7IeWShp+R4njba/xLAndi6BtRZqv7R
 Lj/cdlBNok3dJ3LYTO2EIGD3xaojajV+j//Pl4JWwhrI1QHx29AQOrotB1WFxMsOSZEh
 oRYuBqMRqXhIDjbYaNSPkzaiEa7qf+M38zh32hzxQ/4ksu0dCox9xKk9uz0sWA8SK3lw
 o6pNrAgB2a5bRuhTGy8xZsKKqfRSPfB87swzYQq6X/OOmgSMoTPG2f9cYwjTGg/zi1c4
 s2bbE8csTANEQjpL63Jv5bZyrkAJA4UOf4wcg16yKyDLFL6EJ5r8TRcWyAfhI27B7GTj
 mcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695505; x=1725300305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nLPpVY5qQx/kfEBEol3Eo07j2//6zAKIHhYdW/33PE=;
 b=mw7dLKk6k1tB/bG9Fr/RClMoP/dqeRPGGxoiQmY9SuUDZ6rPAiBZrfDIRYd+HokVLQ
 rCTwJe0uCRttjpwKIiXJqStnBvA0yN2jZHNODUsj97Thxd2m/2UAK741kpDCvxdq49si
 bJOhVvE1aOAwAIiYafnwhhOLlp5Et2MEgVbbfcr3GuBoIchByz0Fv+K5uA5PeOSu8qZV
 tgLBcYtNSBfAUDornQK9Zo6S5V7BE99WPB4amYQrajFglqCRKFQ5Vp4fiq2FPksT93Ur
 I6WJQYpUXCncAvtYsHm3Z+PSS3Yb8iWVe8hch5VMoCP/2ehrAFnTm8OQyTmsA17c6bz6
 vRmQ==
X-Gm-Message-State: AOJu0YyMW5oCk91NZ3xNL2FNhDu1SNao1YTbddf3XUpwDL9IF/vEu85b
 VSGx4IKqlktiCBJjjC0n9R6u9D3blFwM112mwfUiQTR4I7qnxN94ZvI3Wg==
X-Google-Smtp-Source: AGHT+IEOtdzl7UvmCmIcOgum7r1fCzr4mbdN+D/n6OXq+vmgugVX0aQVGcwAZxrZlr1rYh/HKXVuSA==
X-Received: by 2002:a05:6a00:1882:b0:70d:2e24:af75 with SMTP id
 d2e1a72fcca58-715c009c1e7mr612837b3a.24.1724695504847; 
 Mon, 26 Aug 2024 11:05:04 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7544947b3a.12.2024.08.26.11.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:05:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/4] mx6slevk: Fix the boot device number
Date: Mon, 26 Aug 2024 15:04:52 -0300
Message-Id: <20240826180454.2778016-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826180454.2778016-1-festevam@gmail.com>
References: <20240826180454.2778016-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The SD card is registered as mmc device 0.

Fix it accordingly so that the board can boot to Linux
from the SD card.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/mx6slevk_defconfig | 1 -
 include/configs/mx6slevk.h | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/mx6slevk_defconfig b/configs/mx6slevk_defconfig
index a9d7435c0e89..071bcaebf5b8 100644
--- a/configs/mx6slevk_defconfig
+++ b/configs/mx6slevk_defconfig
@@ -38,7 +38,6 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/include/configs/mx6slevk.h b/include/configs/mx6slevk.h
index 39c8ef060c7f..490d9feb805b 100644
--- a/include/configs/mx6slevk.h
+++ b/include/configs/mx6slevk.h
@@ -25,9 +25,9 @@
 	"fdt_addr=0x88000000\0" \
 	"boot_fdt=try\0" \
 	"ip_dyn=yes\0" \
-	"mmcdev=1\0" \
+	"mmcdev=0\0" \
 	"mmcpart=1\0" \
-	"finduuid=part uuid mmc 1:2 uuid\0" \
+	"finduuid=part uuid mmc ${mmcdev}:2 uuid\0" \
 	"mmcargs=setenv bootargs console=${console},${baudrate} " \
 		"root=PARTUUID=${uuid} rootwait rw\0" \
 	"loadbootscript=" \
-- 
2.34.1

