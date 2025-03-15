Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B49C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C63C8122F;
	Sat, 15 Mar 2025 15:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J8J0JaDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408E58198F; Sat, 15 Mar 2025 15:27:32 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E2F8122F
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso4181185e9.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048849; x=1742653649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=J8J0JaDN0HQJ/K9pmfogeXCXv4S/nN8r1TBQLJluo9SmbBlRG9m6ACG0mOXo8dQoId
 DC9KIMyE/s0uvoc9RSfZa/x0GTlOyPwUWyOHX4ojLCQnfdEWkHh0kSWnp5PalAyHebgh
 ewJ+EY3ACazzfE/RUg6nJV/ilfYZtkgKjfbgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048849; x=1742653649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=NU8V/+y7MVorBluqvTbpzstcjFu2HlBOtCgn5Z0P9l1QVGTbedSp0UloQste4M+tzG
 r1M/9EskfA647v89Y+K+XdknGyY8J0H+FYUHwlOHD0GLzekzUnFgok+llvdJWhOnJHEC
 E/nKGgDBjg+GsUV/Oi926XNMJGZaXQd6FrTQsycf20OGooxXu61lY8U6H2OSrKkLAZct
 e1pFH7wzvhrdGnrNaW+eVWLMz4gn5kP6poixrbnVU7YvdY7rX8Q+rZ25X1IZciizhx5w
 n/GnpiIjUH7XdlOE24VD+YJPRXIpyM+1Jza1XM64hjW2IBZxY5GmyaS7swud4dlhoFjJ
 wrFA==
X-Gm-Message-State: AOJu0YxMnf3otqOIlJ76EBcDw4yCkX1Y08HrnCi4CjJONVCBvlStpcm6
 0fXUqoC+J4azyLv4ncDFRupylvQxX0VZONEPMrVOOHMVQdYrx0JULPdHVSsiPh010WnHUakIZqV
 rBg==
X-Gm-Gg: ASbGncunPHX9xgTswtyBKGiX7+4n62/KfJ7FENf6aEN4gNk2rK7d7i6dwFKOm4EynLy
 a6q5zKZNZNxMBQ083+++jdrMrgt0l+SVy188zTAknNsO5ooL3CM+w0XYK6lbBZ60knN728pWw0U
 GqV964E0ZAsyCETCfC3yCFTorRYW4Vr08sw5AWgZkUGavBBYSND+RUMW3NzE+0o/L3Ii6eM8S4Y
 15ye8D47ffq4DbUAOJ1icMtjXcnoQtYAOAC6Sao9/KO7TG6oIE6GXCxH1Za/Oh1wSvzg66FLASp
 aiyO8gcSz0+09Y8Gt98NIftrmjhFgzIfhdrwcNHuhGuoGEdY6ali
X-Google-Smtp-Source: AGHT+IFna4aRNSQ0g1kwUODHSP8PO9u06k+PCm1/jtuuwkxwsASjrHZbo4ZYkOKyTElG7ZLjNYN7Nw==
X-Received: by 2002:a05:600c:1913:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-43d1ec79e9emr83828205e9.7.1742048849207; 
 Sat, 15 Mar 2025 07:27:29 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 09/46] x86: Drop use of CONFIG_REALMODE_DEBUG
Date: Sat, 15 Mar 2025 14:25:29 +0000
Message-ID: <20250315142643.2600605-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

This option is not actually defined in Kconfig anymore. Use a normal
debug print instead, which has a similar effect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bios.c            | 18 ++++++++----------
 arch/x86/lib/bios_interrupts.c |  6 ++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/lib/bios.c b/arch/x86/lib/bios.c
index acae635cf19..5dfe5a647eb 100644
--- a/arch/x86/lib/bios.c
+++ b/arch/x86/lib/bios.c
@@ -301,16 +301,14 @@ asmlinkage int interrupt_handler(u32 intnumber, u32 gsfs, u32 dses,
 	cs = cs_ip >> 16;
 	flags = stackflags;
 
-#ifdef CONFIG_REALMODE_DEBUG
-	debug("oprom: INT# 0x%x\n", intnumber);
-	debug("oprom: eax: %08x ebx: %08x ecx: %08x edx: %08x\n",
-	      eax, ebx, ecx, edx);
-	debug("oprom: ebp: %08x esp: %08x edi: %08x esi: %08x\n",
-	      ebp, esp, edi, esi);
-	debug("oprom:  ip: %04x      cs: %04x   flags: %08x\n",
-	      ip, cs, flags);
-	debug("oprom: stackflags = %04x\n", stackflags);
-#endif
+	log_debug("oprom: INT# 0x%x\n", intnumber);
+	log_debug("oprom: eax: %08x ebx: %08x ecx: %08x edx: %08x\n",
+		  eax, ebx, ecx, edx);
+	log_debug("oprom: ebp: %08x esp: %08x edi: %08x esi: %08x\n",
+		  ebp, esp, edi, esi);
+	log_debug("oprom:  ip: %04x      cs: %04x   flags: %08x\n",
+		  ip, cs, flags);
+	log_debug("oprom: stackflags = %04x\n", stackflags);
 
 	/*
 	 * Fetch arguments from the stack and put them to a place
diff --git a/arch/x86/lib/bios_interrupts.c b/arch/x86/lib/bios_interrupts.c
index 3ae6c193ec7..e0c2284a901 100644
--- a/arch/x86/lib/bios_interrupts.c
+++ b/arch/x86/lib/bios_interrupts.c
@@ -200,10 +200,8 @@ int int1a_handler(void)
 			dm_pci_write_config32(dev, reg, dword);
 			break;
 		}
-#ifdef CONFIG_REALMODE_DEBUG
-		debug("0x%x: bus %d devfn 0x%x reg 0x%x val 0x%x\n", func,
-		      bus, devfn, reg, M.x86.R_ECX);
-#endif
+		log_debug("0x%x: bus %d devfn 0x%x reg 0x%x val 0x%x\n", func,
+			  bus, devfn, reg, M.x86.R_ECX);
 		M.x86.R_EAX &= 0xffff00ff; /* Clear AH */
 		M.x86.R_EAX |= PCIBIOS_SUCCESSFUL;
 		retval = 1;
-- 
2.43.0

