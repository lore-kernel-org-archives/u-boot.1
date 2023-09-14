Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F70EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 17:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638A0870E7;
	Thu, 14 Sep 2023 18:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fuzm8Dq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CCE870D9; Thu, 14 Sep 2023 18:56:55 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6FA870A8
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34f6f29d319so3548325ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710612; x=1695315412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnflEoIzNSwMq748K1d6WSIwnYt+GkocBp05r+MFELw=;
 b=fuzm8Dq/13VLnO4F0q8tVu9plI/HnxETpUrqEAqcgTVJMdyXK1lTJJyftrwrBA/pjs
 tKUy599I+9WjuZSsBeL2y5BBjBdpVAWOFjHlbwYUq0mOOcJ10Q/VThLfG3uMq1eAiC9t
 nWQzGWkV6nTjJeZbIWPBVHOjok2ljT+c6f2Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710612; x=1695315412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnflEoIzNSwMq748K1d6WSIwnYt+GkocBp05r+MFELw=;
 b=mb7EGuv9dOYkBo15xtySY8/bhlHShtv82hcmwuVMALbw99dztsgiHr5N8cv+b++ZfJ
 GXfKVx2KNOOgsJM2PPpraKG7/BlQnLhUtVTLx3emsjk8edCORxpMZg5LWBkl40Xr9GX5
 i+qhERBFRabiW8u4DPLxoXSlm7gZw8/CcetvdiQ24000I0D5ui7+ITnPOuOji3jqpAxT
 fXC33XNjJsEC2tSC42nX8fR5+88SmmaIABkeJFOU6RvQzjf1UVl8AugXvubdaMlIyEQj
 NaONMeOqdm7jBBI3CW12Kw2E1SeA88C28jenHVml6PK2Qz/RFaEkYfPV9NBHMmiONLsF
 07dQ==
X-Gm-Message-State: AOJu0YxH2TdBF7JMEV5kUbHQrcIJoanIs9we0vD7xAaY9zR7O7ypgHlx
 RjRXhIpWiO8xQeIhvQbhoQvx49qsSeVBC3azigY=
X-Google-Smtp-Source: AGHT+IFKBtZhTwRGaNXzRqpE41xfuvkjLGAY8qmXBLTvbN7240leSP1nFLJSLPXu3OAxnVPnhTCF2A==
X-Received: by 2002:a05:6e02:1a42:b0:34f:7eaa:1156 with SMTP id
 u2-20020a056e021a4200b0034f7eaa1156mr7872576ilv.11.1694710612255; 
 Thu, 14 Sep 2023 09:56:52 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 21/21] boot: Join ARCH_FIXUP_FDT_MEMORY with related options
Date: Thu, 14 Sep 2023 10:55:59 -0600
Message-ID: <20230914165615.1058529-21-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Drop patch 'Move SYS_RX_ETH_BUFFER into the network menu'
- Drop patch 'video: Move BMP options and code to video directory'

 boot/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 235c5a7a993..a01e6cb8aaf 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
-	default y if OF_LIBFDT
-	help
-	  Enable FDT memory map syncup before OS boot. This feature can be
-	  used for booting OS with different memory setup where the part of
-	  the memory location should be used for different purpose.
-
 config CHROMEOS
 	bool "Support booting Chrome OS"
 	help
@@ -1490,6 +1482,14 @@ config FDT_SIMPLEFB
 	  the presence of the simple frame buffer with associated reserved
 	  memory
 
+config ARCH_FIXUP_FDT_MEMORY
+	bool "Enable arch_fixup_memory_banks() call"
+	default y
+	help
+	  Enable FDT memory map syncup before OS boot. This feature can be
+	  used for booting OS with different memory setup where the part of
+	  the memory location should be used for different purpose.
+
 endmenu
 
 endif # OF_LIBFDT
-- 
2.42.0.459.ge4e396fd5e-goog

