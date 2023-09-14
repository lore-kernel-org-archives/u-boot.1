Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3700AEEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEDF870D5;
	Thu, 14 Sep 2023 18:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOU4IBbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07EE870C8; Thu, 14 Sep 2023 18:56:52 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C47C870CB
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34dec9c77d4so3910545ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710609; x=1695315409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKnQWiIoK4RL2EIJU7EV7VDeutPbIOTwJ2WRLT/t4As=;
 b=gOU4IBblvH2sjJ+lZxHL07B4NJy3il5BJSk5z40hMnb6EnfywxPLBUL63q5sxuAwlF
 JBeXBTQfN9jqfjVSJ3nj6p9wHE9bwUB4ta0HPW1OmXnNdvkSXjVa3ynEPcIgo4SnKMOt
 ITxZgSP/FMhNySDaAU71dAdAiC3MTtojHcs8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710609; x=1695315409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKnQWiIoK4RL2EIJU7EV7VDeutPbIOTwJ2WRLT/t4As=;
 b=moYt1iMezgcMNFTeC+7zOR+hegre/DX80jCHzdXR/tgmZAYxbpPkGG7OwNwX9oBGns
 LhmczGu+C9OOTXhO+VGNjK123fTC8rBZ5VXrBu7Yj2MoMXqm8iVOTeonLgZ9MoRvTssx
 zfkBMOaGaVt29Fm8lJPO2CB4YMoMNsUW3Qj3IIlcK8FOxZCxEkJOh7suvKgGtMBZ5Rdw
 MoHDOrHjwtI1f9TK53eh+8ovMdmyL+EUxmxFiq7Ael4bRA8I99HDaDupU4+WDGAEHPRY
 5VP42dSfDF2cgyTyWyP3muC/ltERgoURzp2tFpJAXHJ8sY9ePAPPEDxW2fjvk9mGC3fZ
 8fpg==
X-Gm-Message-State: AOJu0Yzy1azUM4H0Od0ZY+FH7f8/3CGTiaxp/e/uF1MEi//1uVPVcEsw
 gWLaY6kO/iL0ADfRULmIuhvaOMchUF6Yk9ViL2M=
X-Google-Smtp-Source: AGHT+IEUHjwIfhe+mXn/tm9TJUHrGZTAS6TIXW5ge6EVwXOcxVnA+xjMPZswKPJRdaDvaKLZKy76iw==
X-Received: by 2002:a05:6e02:2167:b0:349:191:af05 with SMTP id
 s7-20020a056e02216700b003490191af05mr7817559ilv.16.1694710609198; 
 Thu, 14 Sep 2023 09:56:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 18/21] Make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT
Date: Thu, 14 Sep 2023 10:55:56 -0600
Message-ID: <20230914165615.1058529-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

We need CONFIG_OF_LIBFDT to be able to do fdt fixups, so add that
condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to make ARCH_FIXUP_FDT_MEMORY depend on OF_LIBFDT

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7ef44a26fb9..2dd05e2e166 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -695,7 +695,7 @@ config SUPPORT_RAW_INITRD
 
 config ARCH_FIXUP_FDT_MEMORY
 	bool "Enable arch_fixup_memory_banks() call"
-	default y
+	default y if OF_LIBFDT
 	help
 	  Enable FDT memory map syncup before OS boot. This feature can be
 	  used for booting OS with different memory setup where the part of
-- 
2.42.0.459.ge4e396fd5e-goog

