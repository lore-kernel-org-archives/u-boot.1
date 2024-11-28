Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B540CD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0237F89D4E;
	Thu, 28 Nov 2024 16:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TbCzukFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5249F89D7E; Thu, 28 Nov 2024 16:48:39 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDF389D6B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea78529de1so448273b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808915; x=1733413715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvPWSgl0kUUfdjT64MHDY1upSbt+GwsyAuA48WKa5N0=;
 b=TbCzukFG9yDkbHXH6YzZphfRWiFZ2qjm5xrnecflieApSjE77aqYvrFvnpcwl7dpeG
 KLGdC0uosAkH3ijV+cEQt6JWxj7ew6s7AUzX/ozh7NV4PE2+GcFeRnNy+Fxmhs12UYih
 Kb8pQLEiVXtOHzrRFio43Oz2uVCNMftudQeNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808915; x=1733413715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvPWSgl0kUUfdjT64MHDY1upSbt+GwsyAuA48WKa5N0=;
 b=VSNKXGJQpm+dVe2eIxqryFSZk96ZgwNm3GTGgzXT9mxIdwBruUlG/XQiiG9vrsDsgc
 Tn2jXOMrR3ui/s2D4OGqqnTBotdq2ma8Qzy7R+oz9c7eYnkSQBccLotw/LA8PSIu7zl4
 C9bWtfoB2avTw5/ZBiHdu6DN0YCRSMI3RiR+JmlmuE0CPnNJ3+wHc5PH2DTddH7d+9k/
 FdUkAQ1YDaHC/6CQHyy9PuWDOQGrxjpV84zIac3TPoLoBmxGW4M1Ige+x7QmNNbzbNlJ
 QFihjmy2GAVtoheFWnHWuPd8WvcZC5DIlNcxoJMTet+Zj0U2Ym+UC3E1qzm3XwvRJ5MI
 9T4A==
X-Gm-Message-State: AOJu0Yxaj8eHhQ6GdsibWiRzuj9vFDNhSNzDGGipCf6hllWRU9QYY08D
 IK4YBdJVsSxn8Rxmjsw5f/wWZionaFIP+8EN2N6i2EE2u5ezl/MqRqNyS6BPrhi/H1KVqP82WOY
 =
X-Gm-Gg: ASbGncs4S8NdiC2Fgi8+NRffqvMhYWDgffikjLOtB/qpbRYVmrCp15ZKWcUr2InqTCl
 YaqlN9CNT49Xy/lm/1VZI8LlDuoMTUrhqVC4aLwbcI2abaRxcoIQwNBvmUiTHFKb9z9QNhRuiXN
 +BNKl/qO8u/qQB6DYxa/ByQz4x4+ximth1UTkHvjPUqtZHLkfVfJ5329+5COTMnhOA2nEDd2EUD
 3M4Cp5BjzqTFyW8imGAuYh/JB0rr89fuBg5gYk6E7fiYw==
X-Google-Smtp-Source: AGHT+IEW/c6Jz1uJDnKQ5MRNgq4Pr39Y07cI8ujf7EhCiNQC6xxpPbbXHWF7EyhY6BllGPZUG7q05g==
X-Received: by 2002:a05:6808:130d:b0:3e5:dba3:2480 with SMTP id
 5614622812f47-3ea6dbcf287mr6454526b6e.15.1732808915037; 
 Thu, 28 Nov 2024 07:48:35 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:24 -0800 (PST)
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
Subject: [PATCH v2 18/28] efi_loader: Use correct type in
 efi_add_runtime_mmio()
Date: Thu, 28 Nov 2024 08:47:17 -0700
Message-Id: <20241128154727.771871-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

