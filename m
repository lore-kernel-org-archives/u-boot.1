Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4661C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A4586A7D;
	Thu, 24 Aug 2023 21:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0NwgAfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD0386A8A; Thu, 24 Aug 2023 21:59:45 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F01486A6B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso7294439f.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907180; x=1693511980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Hr+qjgR0kdHiYKm3W7ScuYXv13B8aMAgqGL6OCb0NE=;
 b=V0NwgAfF7wfGlmmUhHC0qJYvcEnLa8AXMNPPQhTShkFgEiEOvlcHG9xuMZG8zhtdS/
 Vtlj4A/pq0qPHnauiB9L5WG+9eroLRp1G8XnJnknEiPTH6vvtSEr9PKVdq4LkfwSmeVp
 BrarcDDql3+opMTNy3FlWX+RL2J6BDj7rKuHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907180; x=1693511980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Hr+qjgR0kdHiYKm3W7ScuYXv13B8aMAgqGL6OCb0NE=;
 b=eoh3vyDGsS/DP4fYRDe07K5b97K558jx72+NtloussP3Nq8gBxpF3PSjptqDKqKT+S
 6/5Jg8Dj8GTHcca3j8IqzMGuCQsX0fe7MiCUtBa5PPGsjYGdrT0r/VUk9iXiomRKQHPS
 rLDSBlMJqLxzoOdd7G1ac+lXx7Jzh5vTafhrs99KHN3X8GuGSBpaHC4dvIB/J0Gi3q6k
 66Fc3EV5klkDoZQLDgGrY1Gd0n8pZaLoKMKgu1vrjpNQgTgwyqHwwHVgpxlN6ag4ELyt
 fuESP5s7Nj3ykTs9y/I7xK4DcTS425uiefaBWcuCzd5wruAVEFe3iFHUDJvJ3uN6h3jQ
 T7lg==
X-Gm-Message-State: AOJu0YwlCtE/zK5cTO/MB878nQcprBWGY6rhx3UDa8mh2+R1NhANu60A
 mQnb/O7kefGkF3aqSYhFnQXFkfwd07W+aOfjVIk=
X-Google-Smtp-Source: AGHT+IEdPtvAYYeAZo6hPpFZ8XJWG7gMke4NgM1BMkcEnfW0d7Mjrpr0LRGZQXtyyUWxcHG0utYkwQ==
X-Received: by 2002:a6b:4f03:0:b0:787:953:514b with SMTP id
 d3-20020a6b4f03000000b007870953514bmr7183959iob.3.1692907179934; 
 Thu, 24 Aug 2023 12:59:39 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 13/19] Kconfig: Move SPL_FIT under FIT
Date: Thu, 24 Aug 2023 13:59:04 -0600
Message-ID: <20230824195917.1687886-14-sjg@chromium.org>
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

This option already depends on FIT, so put it under the same umbrella, so
that it appears in the FIT menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index bc3a68402a15..af08703ea1e5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -140,11 +140,9 @@ config FIT_PRINT
         help
           Support printing the content of the fitImage in a verbose manner.
 
-endif # FIT
-
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
@@ -195,7 +193,7 @@ config SPL_FIT_RSASSA_PSS
 
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -243,7 +241,6 @@ config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 
 config SPL_LOAD_FIT_FULL
 	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
-	depends on FIT
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -341,6 +338,8 @@ config VPL_FIT_SIGNATURE_MAX_SIZE
 
 endif # VPL
 
+endif # FIT
+
 config PXE_UTILS
 	bool
 	select MENU
-- 
2.42.0.rc1.204.g551eb34607-goog

