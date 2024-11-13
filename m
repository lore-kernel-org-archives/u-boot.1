Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B7D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA82895BE;
	Wed, 13 Nov 2024 16:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PylLaVI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8990A89021; Wed, 13 Nov 2024 16:10:07 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6893789595
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a3f8543f5eso2651485ab.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510603; x=1732115403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDiSGvZEB8UAa0O5LCj0dybfZf7akhqLiggva7GHgsM=;
 b=PylLaVI2kPD4onJQ6E6I6Dwct6nqz752CaMr/JQpiGDwqV3fS2shaGQpZnQCLUWJ6L
 EFxORTL4QrER/Fcy+TJv0uKRf3WWoDnJnJpkRIRuozQgQGJ9MlpSpd0uh7SfM0KGX9cD
 ycNwZQN/c10epnv77f9hBR/rdcY4BbeZC/NzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510603; x=1732115403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDiSGvZEB8UAa0O5LCj0dybfZf7akhqLiggva7GHgsM=;
 b=T+VE5+mpxZVPvwDf+u3JXa2bDVzqTNwMA3yA7D8fteXNShj3HayvZQxp7EuZz4eYfW
 59yEXc8nk8tcARcY6vYXHrM2QAcfXsa9ED/ZuO8p7iKn/M38MkPocYFF/1Jz5PTmIEra
 dzfzYYb5rtpC5imd3c9b24EYiZhbyC4MmCFlA+xHsHfpNZAv9hIqoLL02oidahDftwEN
 jhHeVIm/3hE1byUVS8SchpNr5sMDs+W4ArN3uDaRXlV2DRElGbwnN0euKUgo3ni5zAY3
 uApYEk+CPZlGI0rDdEIL1suHEvCplEHryf2iekJ415qu50RHKpZ4jRVAHeRPUTYzFhEg
 YDqQ==
X-Gm-Message-State: AOJu0Yywxmtn2S6l+s11VYR1uyxUfgqDtiTvFUTX0knelQOQyBfWpngP
 4CesxQpLlWz43ltrCe5LRrZ699IZGuQPlVvizgeGnp1QuRh66gt1ZFi9fRu/sYwPM4rHUr5Aih8
 =
X-Google-Smtp-Source: AGHT+IGv819XIAuP8N8vufcpWgr5Brnay3eeqdyoHiAdjkzFj6F+mUsClNREPc3exGgVdkOgIKJe3Q==
X-Received: by 2002:a05:6e02:1a69:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a6f25615c4mr165555645ab.12.1731510599243; 
 Wed, 13 Nov 2024 07:09:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:09:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v5 4/8] RFC: Revert "bootstd: Make efi_mgr bootmeth work for
 non-sandbox setups"
Date: Wed, 13 Nov 2024 08:09:34 -0700
Message-Id: <20241113150938.1534931-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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

This is another option to fix sunxi booting with bootstd, which may be
better since it will work for all boards. We can then figure out how to
automatically and deterministicaly decide when bootmgr should be used.

This reverts commit f2bfa0cb17948aa4a0fa20fdf9014296b9c4d9c7.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
If this patch is applied, we don't need to drop bootmgr for sunxi

(no changes since v1)

 boot/bootmeth_efi_mgr.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 23ae1e610ac..095fa74fc60 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -14,8 +14,6 @@
 #include <command.h>
 #include <dm.h>
 #include <efi_loader.h>
-#include <efi_variable.h>
-#include <malloc.h>
 
 /**
  * struct efi_mgr_priv - private info for the efi-mgr driver
@@ -48,27 +46,13 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
 static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	struct efi_mgr_priv *priv = dev_get_priv(dev);
-	efi_status_t ret;
-	efi_uintn_t size;
-	u16 *bootorder;
 
 	if (priv->fake_dev) {
 		bflow->state = BOOTFLOWST_READY;
 		return 0;
 	}
 
-	ret = efi_init_obj_list();
-	if (ret)
-		return log_msg_ret("init", ret);
-
-	/* Enable this method if the "BootOrder" UEFI exists. */
-	bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
-				&size);
-	if (bootorder) {
-		free(bootorder);
-		bflow->state = BOOTFLOWST_READY;
-		return 0;
-	}
+	/* To be implemented */
 
 	return -EINVAL;
 }
-- 
2.34.1

