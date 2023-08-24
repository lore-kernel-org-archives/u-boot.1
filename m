Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5003CC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5443A86A81;
	Thu, 24 Aug 2023 21:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PgufnzTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3458C86A57; Thu, 24 Aug 2023 21:59:40 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CE186A5A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7927f84525dso316939f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907175; x=1693511975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYhPSu/31EKFQ9auzzTQmzn43V5Qt9ZcDp1B0GS6jvM=;
 b=PgufnzTyXytbnWBoB9zRibwry1LSenFrGXVzHXQ4hKtUAvs6LqgiB0ob7SnfER7UQ9
 QzxxwjOWZn7N+5iJjxRPVbw14r757Io23VGO10zQzv58jx/THN9U/qMiasaJYe1FpnDm
 CsvPr1xWqs8MJxYVb/Yyvj8cD9sDnf33Ffd/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907175; x=1693511975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYhPSu/31EKFQ9auzzTQmzn43V5Qt9ZcDp1B0GS6jvM=;
 b=cSHnw+mOTzXHZXLVJXFlh+g08pCMTvy9Ab4wpjy6ivrbZIZc+IZsWJSf05yF4ZKIYb
 k/Gerqv/YVA25bKygh1sBouc1MAfE0SYOL+DLOxqGNGmbUVijIwGoTR6QcZ4uae+ebVC
 mYFgOujWY7vSB4mgjJsAIQQqnwATeArrZ0jNAMtqcb6KUADyaqOWhW4lY/4nd27YlTKM
 X3ZRaTjUjTcZQuDkEt1pzZxt1aqHlgZE+kFcum47IpM2w+SN8Y/OW3101q5c2joSgo5A
 fQsf4fSYc61IeHfIAhwStc09s9uEttqh6iu5hjB4uZv/Va0vv02Q0EMOV0IDGu8s8HBX
 6oXw==
X-Gm-Message-State: AOJu0Yyw03vPOCJGEcMde6THHo7FpsUBBMlMjQgxa7Qi0eafUM6FYRHp
 7XmvVaVs42YMJOmmIYX05MtawZJl5WGPlkA5XLQ=
X-Google-Smtp-Source: AGHT+IEnCNDm8CfqoDrMY5y2KqeE5J6P3eiKsEv9uYq7q3gWXvL+bC1VEUG39mPva1FiWUHvq1dnZg==
X-Received: by 2002:a5e:cb49:0:b0:790:a905:5fbf with SMTP id
 h9-20020a5ecb49000000b00790a9055fbfmr6582635iok.11.1692907175168; 
 Thu, 24 Aug 2023 12:59:35 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 08/19] boot: Move fdt_support to boot/
Date: Thu, 24 Aug 2023 13:58:59 -0600
Message-ID: <20230824195917.1687886-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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
2.42.0.rc1.204.g551eb34607-goog

