Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47005C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87757865AA;
	Thu, 31 Aug 2023 05:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FP6102xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F7986586; Thu, 31 Aug 2023 05:53:41 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065088657B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so17299439f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454016; x=1694058816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWX/LENdO9nxl5ih0fn7nxKxSjjH9CJCTnSZnRYB2OU=;
 b=FP6102xdrbPoPmoO2ZNOIZUSN5CpWp4ErHXPZlippR3h1wmfLNDyJwYdHLuiRWll2q
 CdaOhpcBL6NyapSiTIWxtDgo6Gxb6rfNZx194fe1CGrVTc53H/gfA9JKkPXG8XDvfO+3
 szMbsuZO50Sm/F2ehil2WwDDnsMJ+65aAdlas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454016; x=1694058816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PWX/LENdO9nxl5ih0fn7nxKxSjjH9CJCTnSZnRYB2OU=;
 b=HmY0syWZGrTKf77wpfr1NBvSVDnP3CGdn5TSvaaeqIe98DdXhW5rD/eeK27TMWoCVe
 biJI573E26KBZZz5BWD9zG6WkqYwFqqySpBT15yspXx2caFqY8iOyUlfuXvaNccKxZ4l
 IuPDzfK9dWi41DdUQPan0pIDrVU3jPIv2c3U0TXqawIVOqzNIOci9irRxGrxbeF5KA/H
 Gmf2OEy0D1KDzLdorXFHRzPwjdRlHMoIDp6eUmZWlDctd3wuc5AiPgDnUTrFbRD06WYE
 wvQG+fNoYalxoi7dNeiNvhmr/1aInJU/XujvzTjqIEUjy3mT6SoLrv4O8NQLOUdeXkAF
 GBgQ==
X-Gm-Message-State: AOJu0YyPctNss/qYVESOm9QXtOVljXdnZIqIQS3PpT5d/Ey/s6T1LxIx
 AnhHgRZ0S1nOaivadDduOTPWS0J/Wc9yu+SYPmc=
X-Google-Smtp-Source: AGHT+IHG+D7YpJvEcDidKKJXYzHBk352KxKK1H8z9ST89xlrSX3PCLDcDemwsbuCcKQV78UV8PgPyA==
X-Received: by 2002:a05:6602:1813:b0:783:60f7:ade9 with SMTP id
 t19-20020a056602181300b0078360f7ade9mr4678615ioh.5.1693454016699; 
 Wed, 30 Aug 2023 20:53:36 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/19] boot: Move fdt_support to boot/
Date: Wed, 30 Aug 2023 21:53:02 -0600
Message-ID: <20230831035319.2316665-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

