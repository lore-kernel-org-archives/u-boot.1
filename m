Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0773BD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B820B89D49;
	Thu, 28 Nov 2024 20:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BsOipcaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8513289D49; Thu, 28 Nov 2024 20:13:39 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E18B89D4D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea47869282so984491b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821214; x=1733426014; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvPWSgl0kUUfdjT64MHDY1upSbt+GwsyAuA48WKa5N0=;
 b=BsOipcaXKYqdcBKaXgge58rEpZg1t9MvBgsyWdTsTzD6r5ksc38+SUN9rilN9b2l1F
 5th+cY9YTzydzXJ8PWR2F9HALkXDV5ZWdRysjRlKNHH3qn75gMviodBQDhgXCKi7pDAO
 Lx9xmSmE366CGuWByN0fnyTOuuOqyK7MDDYRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821214; x=1733426014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvPWSgl0kUUfdjT64MHDY1upSbt+GwsyAuA48WKa5N0=;
 b=r/oE1XXhzqd4MX0FLWg2mw3R/a0JUt1bwz6T8Rrzy0twjS/cnDkHAn7Yw5HiwfkaV9
 FUEyx2ft+gVUCYQpXcPb+Uly7xY6zaAZ2X9wYwy1DF1M5DXGgTRAl81p63q+Ntr6a5Iq
 kjrvaRgsZlU2CqS9J4Ees3HOeto6GYv8QDe6ndS6WSFu+LroWl4SKrrdpkSqgsAi52iY
 S6e4kDLps7U3uSoR5/z7bRiucIf8vlsEHtgr8+3zncfAoV/vO+sw4+L5esJ0XnB1hKI5
 2mP1U2XMbAG2cmrdy1DpeHraciS/mQc72MkRDzOMyzZz4mFTG1D8s69jvQsnrOYC35rD
 je2A==
X-Gm-Message-State: AOJu0YxjVLm4bWzmF6AHeOdcdVX1HTVpBUW2hlVEMoIZGluIkwXDSOn4
 3UgJvZTdFlPzkTrQu0Jl59QmO26FDM0rDfiZxtv0f1rmq6+EquOuQ5T9ojbF8cF4T7pjImW3YG8
 =
X-Gm-Gg: ASbGncuYq0jTyqfm0D3inuFdSeCHbb7ysjJbfmz0mPAuus/HRi4J2dqEMiGzAptUYtx
 EflOPnQpcsxjIEmddlIqbwlYSW6wFr7DixbK2NzKrl4SuSgJFFm4Z48J3XikgHSibBs2clVWLRU
 b+jxWUiFer9JJXQxXRWo8UEf70sewB/hZuZIygiYe98VP2GGnqWDVv4scNKJcDcs7M/Os5HZr8n
 D+zblR8KU3TwofE51ez5o10cn2L2ubcD4ijoot65tyFQA==
X-Google-Smtp-Source: AGHT+IE344wVv/TLocqIqn+3Zi2j/+7+uNguYVILOjmky21/ZqXTg0lRA6JvRgzbucYehbc0jdjmAw==
X-Received: by 2002:a05:6808:10cd:b0:3e0:3f2e:3d86 with SMTP id
 5614622812f47-3ea814ed76amr2582064b6e.8.1732821213747; 
 Thu, 28 Nov 2024 11:13:33 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:33 -0800 (PST)
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
Subject: [PATCH v3 18/28] efi_loader: Use correct type in
 efi_add_runtime_mmio()
Date: Thu, 28 Nov 2024 12:12:34 -0700
Message-Id: <20241128191244.900006-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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
index a7228672f27..4c346addae3 100644
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

