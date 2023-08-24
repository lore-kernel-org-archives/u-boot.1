Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A81C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6601D86ABC;
	Thu, 24 Aug 2023 21:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJm2ISPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D377F86AB0; Thu, 24 Aug 2023 21:59:49 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2759B8694A
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so8680639f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907186; x=1693511986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6FiaHTzac+iHOjxo6TVQJUDsYQR5zn3xN5i56iUC7g=;
 b=gJm2ISPWTZZfoyyNJdsosE044239fR7yRB/kEmtY3qYIrUy/7yyeu4e8qmRgnPMP0c
 A4OypKoMDEC9SXqs7piFp0GGCNKHO7rYbJfMZQ4BObhcR8WPnbXCaAYP/Ssajxt8YbrM
 KULDls3kHP35JrSmAzxUZZm2bP+q4dUYKPmQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907186; x=1693511986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6FiaHTzac+iHOjxo6TVQJUDsYQR5zn3xN5i56iUC7g=;
 b=R64ufbG8bRCTsm6JPvvb4Soy2ceVVexLKmn/HNMK3XXhoQEOWF9XJXgv4CglnAen2E
 ynDNcIxXRswvzSqv0UOsevzhBLUfgq8RRhOHyeSPDCu5gsJ5r0KOUTCRy4bc0PqJkdVh
 m6sDO5jTa2vscQGk2dTh+c7nqiOBEgzEzagtWu0Refv84qdv/PJp/9rUawpLva6+gLSL
 alTxMUGxZPt/pUGhyP+/IF+6agL6pqWaj1Nhh3cZ/ciwHjhn1w/2N8jUeTC7CwT/pCgU
 jSVc/DHvxi9uC0BEAcKORMYFpDNm5BJm/LTYlD5VdD7Zy+JgvBOvUoFShxeX4wrVhGld
 wWSA==
X-Gm-Message-State: AOJu0Yw37/3WSsUVMPlATU7hVEfvgj4Baz4JRdlqw5tFnEJAStQIzWFY
 8HgXs/nwIm6oGwREzCl41L0tZDAXpoceqdfpT9Q=
X-Google-Smtp-Source: AGHT+IETKDEZ1K3mtq+dj/fAw/lxqvUTzgVEVAa/gjiqHFJkbNvxDiJkpVj0Z3Df26btCOipalQqQQ==
X-Received: by 2002:a5e:dd45:0:b0:791:3791:527b with SMTP id
 u5-20020a5edd45000000b007913791527bmr7257693iop.14.1692907185822; 
 Thu, 24 Aug 2023 12:59:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/19] boot: Join ARCH_FIXUP_FDT_MEMORY with related options
Date: Thu, 24 Aug 2023 13:59:10 -0600
Message-ID: <20230824195917.1687886-20-sjg@chromium.org>
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

Move this to be with the other devicetree-fixup options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 32d3a7306139..d9cb67945716 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -690,14 +690,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config ARCH_FIXUP_FDT_MEMORY
-	bool "Enable arch_fixup_memory_banks() call"
-	default y
-	help
-	  Enable FDT memory map syncup before OS boot. This feature can be
-	  used for booting OS with different memory setup where the part of
-	  the memory location should be used for different purpose.
-
 config CHROMEOS
 	bool "Support booting Chrome OS"
 	help
@@ -1489,6 +1481,14 @@ config FDT_SIMPLEFB
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
2.42.0.rc1.204.g551eb34607-goog

