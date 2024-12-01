Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB5D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF968967A;
	Sun,  1 Dec 2024 16:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCkN0gse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D4D8914D; Sun,  1 Dec 2024 16:26:13 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16888966F
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so109105839f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066762; x=1733671562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT0zdvSa8Qejfg4T+ij4pz7vPuhZ6JoacgzMYs1whvs=;
 b=JCkN0gse7uaQmqr7/LnstJBjMSY/r05KjNjUdwKvCCSL5ywaIXPsCNTQ30BmMasQKX
 L1mUrf3d6hzc6MEAFwOUab1SrPTTa0VuhsWsexC0RI3F34rDWEWKEOFZzkNv4Y/BQBlP
 bdBl7zpdwXsTFNVppWGPSyNRK2vpTHFl45s0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066762; x=1733671562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT0zdvSa8Qejfg4T+ij4pz7vPuhZ6JoacgzMYs1whvs=;
 b=OhjFFG4M7OzNUIDr5SG+fH3WSMSdeVBqww2M7l5Fcf+mb6auGuqYhaO1bRzG0sOudm
 VFB8UgVL8JLUkGmCDgc2pByfB/iEadCig4KyU7GMzM6ZL7/3izMlcUBaWgxaXKDqGfxJ
 I/Fyi8p1cQL7vcnuoDhOBRYTrcJg9vsQ19VAbl8d7uFGhqPzP8G1lNxWfjJsqCTsQhC6
 gfZ6pRLfBbbIAKXCBOML3AXP8PGxhvn6KjlAjN/smE4YZZPnCMoxKubvH5oxHJJxf6iT
 ciAUYWcOo5lOlvChfF6Yb7huXjas9uMxuAghkEA1sxW1VHsPPd5B2ZYOR+2m0SJE1ZFv
 KciQ==
X-Gm-Message-State: AOJu0Ywt54uijb44hG/pusmEQKFiZm4QiribrXKO1vCpfVZperLj1Pet
 JO2Fm13D8WwTsv+dwVHyBuZIMgcEM4GtT2SJKPacNxEM4h7eJeWhkuyEfHl1CihPnLFDagHKrmE
 =
X-Gm-Gg: ASbGncuY54f+axi8o/jZ2SYfUvV9Q307pu+SEjLW4IpWK/OS/xIQNSE2PpzIm8CNfI+
 BKtgiVe2l8P9nmurGtc85O9op6zUYSzE/IdI3UpsUhcxE+ndr2nZ/x9Bnwut+HTsQndNIiXNdyl
 aYWnP71L9AokdJ1EU1jGYa3njAcffoYOusvQiTyHOB82zGLNSY3y+vcfPsroO2Nm8bHlMnatq39
 xrcQ61376FRkt5h8C0eHHr4xnXD2/M3wO8zeqZrjSbJ
X-Google-Smtp-Source: AGHT+IEkxoJRWdJJtCIrRC63EFmIeA9ksD3y7khdAcb53vei3KXcEP8Uy1jar2Fs/6s4sC9WpbNpNA==
X-Received: by 2002:a05:6602:340b:b0:83a:bd82:77f with SMTP id
 ca18e2360f4ac-843ecfd47e9mr1988342439f.8.1733066762593; 
 Sun, 01 Dec 2024 07:26:02 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Matthias Brugger <mbrugger@suse.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v4 18/25] efi_loader: Use correct type in
 efi_add_runtime_mmio()
Date: Sun,  1 Dec 2024 08:24:37 -0700
Message-ID: <20241201152505.1666789-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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
2.43.0

