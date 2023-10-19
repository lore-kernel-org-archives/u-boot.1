Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966FECDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A04087440;
	Thu, 19 Oct 2023 17:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qsQHJkMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB31587465; Thu, 19 Oct 2023 17:01:30 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54EDE87446
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7c011e113so107906017b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727685; x=1698332485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h+67bDOMpd2Kt18oQqVHggtlLTBIDN1D9T8czDuiY3c=;
 b=qsQHJkMy6/CwLRUL/kfJAIHzTjI65tyZDWYq2mi8tRnqWUZTKUU1Axy9eVc9EA87cu
 Lc6GlQfMDUjePeT6MCVADNb2S0ISoZDuA83tC99VtrizAUdPxX7ufiWROprvLTQVXYeT
 bcAcIKuAwZRZ5vKttqgumEIj6znKWFmqX4zGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727685; x=1698332485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+67bDOMpd2Kt18oQqVHggtlLTBIDN1D9T8czDuiY3c=;
 b=ahdXPsLu3kMTZ5m6X4fNnPbEGaCuv8t+Fc0m8c/kXFdhIKpGmv9gXQcKnYw13HzRfo
 VWIV1EDfqyAmnd0fMx/LyeZkMqfqp9R//36Raf8DnphEYjT+nMWK3c8VyzS9G8bi8cwQ
 63Wi7n/e8947vZykQVvmMP3igBh1U2Cyav3Nwcg+UlyDPE7yW3lkWw41d4UkDH9bHSgi
 J3pnTv3YPFKZV5XIWlbIjNfChnxANntifpj/JqicTcHpv5843Wm/kFwdYs1noPag3RKy
 e9EeaoJht1NdKEBRVX7yAXevpRrapeaL5zX8nrN3vtHfmRQ9TBZqhUQNFrJXErpcidBl
 jOVw==
X-Gm-Message-State: AOJu0YwMG+9hYH3uzL71e91t5gLRX4ILwS4D4MKdgiltnSsX/INP5CHX
 IxHtRrkqGI8hqjH50X0JdpNx3EtTAq8gavT7lctC2w==
X-Google-Smtp-Source: AGHT+IHbxGZwl7ckc3k5tJgAuWQQNPjc6fYcn1M1SrVzp2jVMxPa9rmKPTITXO6ogE9Vh+L7/tVONQ==
X-Received: by 2002:a81:48c4:0:b0:59e:9a44:9db9 with SMTP id
 v187-20020a8148c4000000b0059e9a449db9mr2403927ywa.26.1697727684631; 
 Thu, 19 Oct 2023 08:01:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 16/24] boot: Move SYS_BOOTM_LEN to be by LEGACY_IMAGE_FORMAT
Date: Thu, 19 Oct 2023 11:00:57 -0400
Message-Id: <20231019150105.714407-16-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

This particular option is required for booting all image types,
regardless of if we are starting an OS via command line or something
else.  Move the question for SYS_BOOTM_LEN to be by the question for
LEGACY_IMAGE_FORMAT, as that's where our generic OS questions start.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 11 +++++++++++
 cmd/Kconfig  | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 88b9296ee1bf..7c92e0974c5f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -692,6 +692,17 @@ config LEGACY_IMAGE_FORMAT
 	  loaded. If a board needs the legacy image format support in this
 	  case, enable it here.
 
+config SYS_BOOTM_LEN
+	hex "Maximum size of a decompresed OS image"
+	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
+		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
+	default 0x4000000 if PPC || ARM64
+	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
+	default 0x800000
+	help
+	  This is the maximum size of the buffer that is used to decompress the OS
+	  image in to if attempting to boot a compressed image.
+
 config SUPPORT_RAW_INITRD
 	bool "Enable raw initrd images"
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 872cb49150cc..099ec444ae99 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -361,17 +361,6 @@ config BOOTM_VXWORKS
 	help
 	  Support booting VxWorks images via the bootm command.
 
-config SYS_BOOTM_LEN
-	hex "Maximum size of a decompresed OS image"
-	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
-		   LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
-	default 0x4000000 if PPC || ARM64
-	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
-	default 0x800000
-	help
-	  This is the maximum size of the buffer that is used to decompress the OS
-	  image in to, if passing a compressed image to bootm/booti/bootz.
-
 config CMD_BOOTEFI
 	bool "bootefi"
 	depends on EFI_LOADER
-- 
2.34.1

