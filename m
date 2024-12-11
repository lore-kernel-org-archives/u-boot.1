Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BBDE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84B180326;
	Wed, 11 Dec 2024 14:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ad7aGgF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220568035C; Wed, 11 Dec 2024 14:54:58 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E2680323
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so360969739f.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925294; x=1734530094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeUZa1wdYChk8BcUUGkuSUaf+RzegSAECf/9QOeEcVI=;
 b=Ad7aGgF/yqml6zXNE8v+UStclQ50G/hBWFjQmJ/4Uz07xkhrrClIYU25yGZ1HZizXa
 810fVpLgNcjuxEZ35zP4b8xx4+yngk6cGzQqShxSuOz5/aolUVXcbcQb5VoijCHayfRt
 Hy4Fxna3UX12bgP0o4B7EJRQ0apVnddVYw4OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925294; x=1734530094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeUZa1wdYChk8BcUUGkuSUaf+RzegSAECf/9QOeEcVI=;
 b=l1EmFcmhcalA6KvEAOw5V9WWeKPlLUGoGxCSvQgRlskT5j3NimFZ+6yhYkEj6LNSfq
 XEfomnyhQBHDG4pWCZzbgzLA8e4AluhP6Af+Ppa7TahO7Rj6v/FxoDG6S8TkJDyy6lUr
 GMTPaObFTEfL4Wz1CaPok+zcZ1FuR3/YuE9oJs3UdOUy1Dg4Pd+M1coRhDkjRkRPKlWR
 pm/ICFB5CBSHjy+oUt8IQ4pwoKBWQi/OLqH7KZKwrI3q1oUbntmCpRLmPy/l/aKAM8Ez
 Bvwfp131x94e1lyxwrCjo0y9W//+hitncCdilpyefilJfqhb7Q1Ts8Af8FhICLcUdRVe
 DFFw==
X-Gm-Message-State: AOJu0Yw+OnxF2w2oX0HCi2LwImyveX17qs3gZgZlDVumSZjUZqxJwGRh
 VGIAyO0mBuFnbOHJ41LYfEDq+GBjiHJoxv3XrklQ3cLf0wbQDRGKs2CVyPEWpnRPIEla54zEZAg
 =
X-Gm-Gg: ASbGncv93ZXxelkPmGLMOEhMb2z0Rgm8gQ0RakQoO1glFbNnRgg94jYvIjcc1xLnsMR
 o4DwApfX5cNST9r+cRVyy8bO2d4jJZAKShJDeme1UB4q18L0ylY8vGwaOGLR3bcx7/65EWY7YnI
 6m6hExuDyc3kWqZ8WEgqJw9EkMsG+/RiEQfdKw4yc3hgfg+EDFPkRWKiBcRx6zaulz5gamt8RhF
 ujQYIX2Fan7Ts3E+r6j2MLVdItXpWd16ICq1nHZxckSpGB9tCR8fhNM28j3lr/1CsB8ZVz/AvHW
 W2kVB3vrjq+YQOM=
X-Google-Smtp-Source: AGHT+IFY9qby2fInsKXhNheDXABTNW23luwQqlKHUl2Vj2xVycdrJiCAFjqMCW3+vjYWrRkxlqZy0g==
X-Received: by 2002:a05:6602:2ccf:b0:835:4402:e2eb with SMTP id
 ca18e2360f4ac-844cb5fac44mr382422139f.7.1733925292802; 
 Wed, 11 Dec 2024 05:54:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 16/23] efi_loader: Use correct type in
 efi_add_runtime_mmio()
Date: Wed, 11 Dec 2024 06:54:10 -0700
Message-Id: <20241211135418.563803-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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

This function is passed the address of a void * so update the argument
to match. It is better to have casts in the caller than introduce
confusion as to what is passed in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 2 +-
 arch/arm/mach-bcm283x/reset.c           | 2 +-
 include/efi_loader.h                    | 2 +-
 lib/efi_loader/efi_runtime.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2d3e346a36..f9c379e9b06 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1272,7 +1272,7 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 efi_status_t efi_reset_system_init(void)
 {
-	return efi_add_runtime_mmio(&rstcr, sizeof(*rstcr));
+	return efi_add_runtime_mmio((void **)&rstcr, sizeof(*rstcr));
 }
 
 #endif
diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
index 1dc7ce50d1d..fd10f01d4f7 100644
--- a/arch/arm/mach-bcm283x/reset.c
+++ b/arch/arm/mach-bcm283x/reset.c
@@ -85,7 +85,7 @@ void __efi_runtime EFIAPI efi_reset_system(
 efi_status_t efi_reset_system_init(void)
 {
 	wdog_regs = (struct bcm2835_wdog_regs *)BCM2835_WDOG_PHYSADDR;
-	return efi_add_runtime_mmio(&wdog_regs, sizeof(*wdog_regs));
+	return efi_add_runtime_mmio((void **)&wdog_regs, sizeof(*wdog_regs));
 }
 
 #endif
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3f75f2efcb6..3bfc56ebb5b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -73,7 +73,7 @@ struct jmp_buf_data;
  * Call this with mmio_ptr as the _pointer_ to a pointer to an MMIO region
  * to make it available at runtime
  */
-efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len);
+efi_status_t efi_add_runtime_mmio(void **mmio_ptr, u64 len);
 
 /*
  * Special case handler for error/abort that just tries to dtrt to get
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 05369c47b01..9d3b940afbd 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -927,7 +927,7 @@ out:
  * @len:		size of the memory-mapped IO region
  * Returns:		status code
  */
-efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
+efi_status_t efi_add_runtime_mmio(void **mmio_ptr, u64 len)
 {
 	struct efi_runtime_mmio_list *newmmio;
 	uint64_t addr = *(uintptr_t *)mmio_ptr;
@@ -941,7 +941,7 @@ efi_status_t efi_add_runtime_mmio(void *mmio_ptr, u64 len)
 	if (!newmmio)
 		return EFI_OUT_OF_RESOURCES;
 	newmmio->ptr = mmio_ptr;
-	newmmio->paddr = *(uintptr_t *)mmio_ptr;
+	newmmio->paddr = (uintptr_t)*(void **)mmio_ptr;
 	newmmio->len = len;
 	list_add_tail(&newmmio->link, &efi_runtime_mmio);
 
-- 
2.34.1

