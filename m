Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77139C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF6F80934;
	Sat,  8 Feb 2025 18:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZcoDe5P+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2880880934; Sat,  8 Feb 2025 18:12:22 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B1080820
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e06e5d11so87908039f.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034738; x=1739639538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDhy0yWQZk9kP/Al4NhnrQnOnmi0eBKU9sfaJQVOwzk=;
 b=ZcoDe5P+we00ViWnvfK3D1pfKi7bZPKspo0JuUAmPLo7K2ql0HD6BxgtqXmohiyNbd
 aKAiFuFW+k+JHmXgjNGVtKn2S+mkeJbWP6xocyvH/TjQ8ycIV3H98gURY5K7ZrpbgD3F
 yqOcFwRnA4nZGcyVIVKI7z+gKt3TNSVrHfF5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034738; x=1739639538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDhy0yWQZk9kP/Al4NhnrQnOnmi0eBKU9sfaJQVOwzk=;
 b=DdaMqrRvMzttgxo9ugitBwkyYvzf1DLbzChtsyI9chfBqOybV4JTVUcXj47sCTvgpW
 pXC6Ewr7UAcnc+kwjv+Xj5XWqlHLNeE3lY30coXdmi0Ns1+19D05aAacCoD6AUaS9Df7
 Uvs0L/FpUcwNPp+KDDDsGX2kAM4twjnyfleLtaF3KdZDaoLUWZTy1GRosv2UkEWXuUCx
 Im14Sf35b9DvFJ5C24BYPxY5+tTKsUgSbVmr+4wqPPC70I8/fI/5nMBilSESTgPLSYzy
 t/2rLyiE3N5x/2DI2V3gntVs4xqNiNnD/dYh80O+XKu4ogwSm2vxKBx/iNQTwI+ssHmc
 40zg==
X-Gm-Message-State: AOJu0YxyYrIfk+Etrz12xLAPFs34Vl+eZPupzErUNw3RzUrz4a6xRHNu
 zTkLaw38lRJ81mIYw86G48jvtA6OIiAZjku4fff4DFdTp+p9ADoQ4nwyFVJSLSa9lhVW0anecI8
 =
X-Gm-Gg: ASbGncvDsfUvQLfo+UUtsq/Dw/dilfy8tjdk2nStB6aWS38OG6W1VBxDUscEdiAHAly
 T6FiElO9xbwLI/hIE5SOb8w22OErAv5Vvdukcd/7fEeSEcji/xi+TIk2PHtRnNQmewgm/M6Rplg
 w5Qp4xklHi3kYUbZfVErI1vOQIyogz6R3EDK9sXSA4u9I08IrT4pw5JCTP+nThHBMmybc2GfqLZ
 27s5cBINM+JeRNw7YNORZAgK46KxTdCcU2SNuga+lIgzeJAkcxFh0y86wIKTGkXDA6dHOpfoExQ
 e+75gWi993q6C1x2eHz+RvBmv/ULg3ZrW4and4bcDmtVd6jsElYX
X-Google-Smtp-Source: AGHT+IERdADkHBsA8/QSa5VuiabLDRY2d1LzFu9eflVB4Il50qdenFCPAPKQUf2j2dcSB2m8/mOxjw==
X-Received: by 2002:a05:6602:4008:b0:851:f176:9827 with SMTP id
 ca18e2360f4ac-854fd89ba0bmr768889239f.5.1739034738173; 
 Sat, 08 Feb 2025 09:12:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 06/29] efi: Allow board/efi Kconfig to be used outside x86
Date: Sat,  8 Feb 2025 10:11:26 -0700
Message-ID: <20250208171154.1305761-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

So far only x86 supports the EFI app. ARM is going the same way, so
allow these options to be enabled for 64-bit ARM too.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Drop the word 'Sadly'
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/Kconfig      | 2 ++
 arch/x86/Kconfig  | 1 -
 board/efi/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53f..493c827d74d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -544,6 +544,8 @@ source "arch/Kconfig.nxp"
 
 endif
 
+source "board/efi/Kconfig"
+
 source "board/keymile/Kconfig"
 
 choice
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29e..80396a3a2d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,6 @@ source "board/advantech/Kconfig"
 source "board/congatec/Kconfig"
 source "board/coreboot/Kconfig"
 source "board/dfi/Kconfig"
-source "board/efi/Kconfig"
 source "board/emulation/Kconfig"
 source "board/google/Kconfig"
 source "board/intel/Kconfig"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 9027ca8482c..7545f808585 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,5 +1,7 @@
 if VENDOR_EFI
 
+if X86
+
 choice
 	prompt "Mainboard model"
 	optional
@@ -33,8 +35,6 @@ config TARGET_EFI_X86_PAYLOAD
 
 endchoice
 
-if X86
-
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-- 
2.43.0

