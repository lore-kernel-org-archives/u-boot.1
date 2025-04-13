Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC19C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 11:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C93A829E7;
	Sun, 13 Apr 2025 13:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SIogRUOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996F482A65; Sun, 13 Apr 2025 13:34:39 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735A982956
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 13:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so616721966b.1
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744544077; x=1745148877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aRH81QwZCnMtGpLOqkHiQG4WAJu/Eh0N/DUrYMkcjOo=;
 b=SIogRUOixf/Vg2jmMb7PtZ5P68dNT3MV2h1Ql1nFfZ4BnObcoYqrbjqtIYM1zIg0N/
 3FbAVOUofcSUGWgRdkZ7f+PEkCJniNk3qkTNDoK6ZpOyyLBghLwLpQDe9cY535HH0y48
 UuE0svvQmaut95VKay0mJJ9NGBKtFN9qR/Ddm1qFlXQEGGjWCvqOEdVK5Z+H4R3ykjV9
 SNNUg+yTeYrl9EIXMivvnpnCEADULil+GCSy3fyDKMpLiTj2Auif7sWILLSNDomESpXs
 ca60Z8W0BvT47zPbhCcuKpc9st+F5OKw6DoWICTLrS3i4Wjq/cCzhw3CXaJMD9Zt/q5h
 UUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744544077; x=1745148877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aRH81QwZCnMtGpLOqkHiQG4WAJu/Eh0N/DUrYMkcjOo=;
 b=p0LpmRK0KVZmTPhnF0VWuD1bfPknF3ewhiAHUdmEZ5VIkvZviO3oU++9rvi9EQgv+8
 Gk+5rdTPaV9bPT5z8Saju2xaJ9D77aRFxgs6raJpZYvz2bW3NMdNy2CR7ic38MzNdomW
 ocrO4KlySWt+JRx/5Q0Xg+eGQz69qnMQ6TGnEBtQU87dtpdyIOB1tYJbaFUhA5RmoPGc
 V/MipXsIFwGZM8POmGl1Eomm+q/s/AVtHGxDQyBleyZdrVdgbe5SABm10i9yN2/bpNOf
 lE7PBfyw36orxk5O+GrFQsU9oavE4itU7zm+myz13NlmUj3jKEFM+EVTvLjL+1xoKGnN
 hlug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2bG06re9XUMC4nYHVwkfdkt2DEE0wINYA9CtzDMjdkM4kh5oXs2VevUd3OCoZ8JvUOQFFh3o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8TuYouJx/WlOhfpzzJuLDEQout30hehb7nbFre1BB7KhBEWuC
 nrBlsoG6kOd35unFCk59Lxe+1bjShAeB6MmwnMxRJXo6UHuWi1eFlKCyKfVJj2s=
X-Gm-Gg: ASbGncsAcLaPclurRYhCtjgdF4mwTB0IWZogcuvmOgzoveWxLe5TkMISEVtUZt7tFOX
 /fnSCPN3qkH7Hg898OZTAGAQqdGKS0KmrliOPH8p+NdySdWVpeF0IEnqtX1OyZr68FmsVZDuq9r
 xhBT5xujG50SXvNNQFMSLhh7dTka6d4R6TGqzTAUrgLJKdfjCsyxi5+a4jZ0ZNR9qxS87jmN3bk
 2mzWZUghJpjcgPV9tdQMfudXltPXHmVh5/tIHOS7MdhAIiSRRkQxj3WOE/ZKE59S8g1otJ7AD1b
 lwQMpn2sf/3ZBUTaelNdnAnI2DoVxTVAedACqFJm8X/y/5rH2MK8ayg7Jx3WBLqNfXUSPks2C2Y
 =
X-Google-Smtp-Source: AGHT+IE2jVizwZUGmbCzZSvDSf/u9/JFx6vtTxv4UY6pBil9bPoVyy68WOfpjPaDbl9+F+xN6mIyQg==
X-Received: by 2002:a17:907:1b03:b0:ac4:493:403 with SMTP id
 a640c23a62f3a-acad36a5b29mr710584666b.37.1744544076786; 
 Sun, 13 Apr 2025 04:34:36 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1bb314esm728772866b.35.2025.04.13.04.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 04:34:36 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Andrea Calabrese <andrea.calabrese@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Moved the generated ESL file to objtree
Date: Sun, 13 Apr 2025 14:34:26 +0300
Message-ID: <20250413113427.3126132-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Tom reports that generating the ESL file we need for authenticated
capsule updates fails to work on azure which expects a RO git tree.

Move it to $(objtree)

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .gitignore              | 1 +
 Makefile                | 2 +-
 lib/efi_loader/Makefile | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index e93c33da1bd2..272257a77bbc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -78,6 +78,7 @@ fit-dtb.blob*
 /drivers/video/u_boot_logo.S
 /test/overlay/test-fdt-overlay.dtbo.S
 /test/overlay/test-fdt-overlay-stacked.dtbo.S
+capsule_esl_file
 
 #
 # Generated include files
diff --git a/Makefile b/Makefile
index 38f2e2bb72a0..73939748e542 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,7 +2231,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map capsule_esl_file
+	       Test* capsule*.*.efi-capsule capsule*.map
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index dc2912148951..ab50a69e48b4 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -79,7 +79,7 @@ capsule_crt_path=($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))
 capsule_crt_full=$(srctree)/$(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE))
 quiet_cmd_capsule_esl_gen = CAPSULE_ESL_GEN $@
 cmd_capsule_esl_gen = cert-to-efi-sig-list $(capsule_crt_full) $@
-$(srctree)/capsule_esl_file: FORCE
+$(objtree)/capsule_esl_file: FORCE
 	@if [ ! -e "$(capsule_crt_full)" ]; then \
 		echo "ERROR: path $(capsule_crt_full) is invalid." >&2; \
 		echo "EFI CONFIG_EFI_CAPSULE_CRT_FILE must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled." >&2; \
@@ -87,8 +87,8 @@ $(srctree)/capsule_esl_file: FORCE
 	fi
 	$(call cmd,capsule_esl_gen)
 
-$(obj)/efi_capsule.o: $(srctree)/capsule_esl_file FORCE
-asflags-y += -DCAPSULE_ESL_PATH=\"$(srctree)/capsule_esl_file\"
+$(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
+asflags-y += -DCAPSULE_ESL_PATH=\"$(objtree)/capsule_esl_file\"
 endif
 
 # Set the C flags to add and remove for each app
-- 
2.49.0

