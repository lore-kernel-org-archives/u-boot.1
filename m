Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1112D42B84
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A350189430;
	Tue, 12 Nov 2024 14:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TMZNtxW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F00789461; Tue, 12 Nov 2024 14:59:49 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8513E89430
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so219913739f.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419986; x=1732024786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mox9fZ+I66WAXDkqf7w0uXnFvuIzFRIFpSjOfdmBgAU=;
 b=TMZNtxW+494efKKA3TYi/cF6DLwEiYe97AdPlEXJzhcmV4EF09UxmAXzRK51Xf9NM2
 Ik+B/PIAScXdgtEcpV9Gbu3AqFSzRQ3PayBFYnVnWKO3ry3CxqRkd1VsEFDcPYGaMeYK
 Wnq06mr6icgfGt6/xZocJgmlC8dB9Mr5SYOUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419986; x=1732024786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mox9fZ+I66WAXDkqf7w0uXnFvuIzFRIFpSjOfdmBgAU=;
 b=cLihqThpIRQpLcivn2whypn6Yp9LqrNVYGeEsQmr6jTY7Gy2M1m2j5VnvRtHKO6Bzz
 Q46mnG4aiveZg6VwU3/voYAegG2OQNnIV3FUtnyadcxf+4X9BeRjsghoKYJNF7I+X9yW
 0Or7mbXhcHAWzZuWyGN/022766FaXkV7OoGTPkZT4rbTZZ84DzNkxFhFgCg5RNr1rl9S
 rR5weiG3poyJxvfVXNTgc/8JNPkqo27a9vpg7EHu1JywaODfWP+BVDySLOUt83GkTmi/
 8Rd1/k6SFx8iGzuQz7HpcZ3mdlrZ97C/IF/kT4kUHIMDyDDu/9H8SP2CZX3qagf+Yrm6
 6n2Q==
X-Gm-Message-State: AOJu0YwRliQKw7yt09Ily/HfMOQDcgtwOMZOX7tVkBbigWAnxHBCnlPd
 0ix9pwI1ppNkhBgD593JxIPHgd45vQ0HZesj4DWZbMpUKDl6LNoBjEYW7DTVK+dQQRK7cL7ARSA
 =
X-Google-Smtp-Source: AGHT+IHjcqQvMyhtTF+ivR0jrsdk/C4/LNm/xPsWwsuYhyY3F7uZkQbY01MSbFyPzCSfv6qkUYDeSQ==
X-Received: by 2002:a05:6602:1512:b0:83a:872f:4b98 with SMTP id
 ca18e2360f4ac-83e43175db5mr310119539f.2.1731419985696; 
 Tue, 12 Nov 2024 05:59:45 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/18] x86: Drop use of CONFIG_REALMODE_DEBUG
Date: Tue, 12 Nov 2024 06:59:01 -0700
Message-Id: <20241112135911.630586-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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
2.34.1

