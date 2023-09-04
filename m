Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9268C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1437B869D7;
	Mon,  4 Sep 2023 16:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XjysWoPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381908693D; Mon,  4 Sep 2023 16:41:53 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D536F86961
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34ca1bcb48fso4728445ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838507; x=1694443307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4U91nakWwLOEeQox4XV+9uMvXu1XnnWJdJluRtUGrw8=;
 b=XjysWoPW+KeAULO/Efnkltbo+qfjN7TD2qo3DRi/EfnYAUpTpAl6lEH9ag5gG/sdws
 5DvWDgkjWuCI5vy71Sn+9ESpGs2G971cw/ZawjEftpYqMqtpLG6ntvX9jJotfeOQGyya
 h7/QKFrpwNfSm5pSh1tPUd8z+IyJhegh5o5NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838507; x=1694443307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4U91nakWwLOEeQox4XV+9uMvXu1XnnWJdJluRtUGrw8=;
 b=CBlDnC4OhKU5iKlHVa72oDu/Iw+gk0iX8ygXYMD2CJkKiFODcJutAAl1OBh39rxlqz
 jmqHHv6nJcH9xRsMKJuipjGEzDWySmaGp9xkk2aRiPbbB4UWbAaxi5wOElUxZZJHdJdT
 zXn14SDTVimxgMjg/8uf4nC/6BllnY57XMhRPvy0oyvy9STn+gNY/T47WgCItvVvdeaD
 1PkP4lK4uq6lxIYgBriZeDQFfM4GFaJJcNLXFDz/ZV4kKTdbL6QYQTmS2v9a35V0/1jJ
 Qq+Gi0ctAhYw33QtdYkYm88jaK4+cyUMGHSdQ3uLc0pV2Asg6+KkaKq7bDA1lvLjoFt1
 Fv9g==
X-Gm-Message-State: AOJu0Yy3x7d4NyAptfHH4oTIfGGUk1qjsfw/C+QRQMNHoZNlMKeI9OVT
 OajfigFPUXKnhCrpoujy76aNFHB+cf8mzYu9xYI=
X-Google-Smtp-Source: AGHT+IH+IMW9HaLMfzv7r146ssYoYCHBtUA13ZcRJJ7KcpXOMP6dgpd4gr2VhwNVC6/6aTyecYQPQw==
X-Received: by 2002:a92:dc41:0:b0:34e:2060:40eb with SMTP id
 x1-20020a92dc41000000b0034e206040ebmr6301340ilq.28.1693838507562; 
 Mon, 04 Sep 2023 07:41:47 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/20] boot: Move fdt_support to boot/
Date: Mon,  4 Sep 2023 08:41:11 -0600
Message-ID: <20230904144131.2699824-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

This relates to booting since it fixes up the devicetree for the OS. Move
it into the boot/ directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile                  | 3 +++
 {common => boot}/fdt_support.c | 0
 common/Makefile                | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename {common => boot}/fdt_support.c (100%)

diff --git a/boot/Makefile b/boot/Makefile
index 10f015722378..f15a161614ff 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_QFW) += bootmeth_qfw.o
 endif
 
 obj-y += image.o image-board.o
+
 obj-$(CONFIG_ANDROID_AB) += android_ab.o
 obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
 
@@ -37,6 +38,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
+obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
+
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
 obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
diff --git a/common/fdt_support.c b/boot/fdt_support.c
similarity index 100%
rename from common/fdt_support.c
rename to boot/fdt_support.c
diff --git a/common/Makefile b/common/Makefile
index 0a3f75f2f1c8..0948721d0b47 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
 obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
 obj-$(CONFIG_MII) += miiphyutil.o
 obj-$(CONFIG_CMD_MII) += miiphyutil.o
 obj-$(CONFIG_PHYLIB) += miiphyutil.o
@@ -51,7 +50,6 @@ ifdef CONFIG_SPL_DFU
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 endif
 obj-$(CONFIG_SPL_NET) += miiphyutil.o
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
 
 obj-$(CONFIG_SPL_USB_HOST) += usb.o usb_hub.o
 obj-$(CONFIG_SPL_USB_STORAGE) += usb_storage.o
-- 
2.42.0.283.g2d96d420d3-goog

