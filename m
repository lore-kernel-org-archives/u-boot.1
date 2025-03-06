Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D3C28B24
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAFE816AF;
	Thu,  6 Mar 2025 17:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="naQJ/kIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445BC8141E; Thu,  6 Mar 2025 17:05:09 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F9781658
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d2b6ed8128so6770325ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277105; x=1741881905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=naQJ/kITCQrV0Mt4QF0F9/qYhxXExatnv/WqrTsdgJZyDGP4nKp4Pzi8Cf6JmUTMJq
 J5DV/38mT5hPecixZ+sMqGMCan1xiUMx1bQm/sAaFdT++FUkLrPtNyWZcEFMCS9tihic
 igWMr5SULVSV3Goa8nVx4XCNu2+EFX51Bb+sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277105; x=1741881905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=uPsih72phwDatODMw1o2kOg4acshNnRp0otq9Bgjz1XGxpnT0PUWZ/v6hJ0bG0xUkm
 NZqLmqRdwq5HqS7WeFNwuOabFK+hFcPmy37LvLuBfBRRPHaOOfNVxqFKLDfeTkWLFc8/
 v2HgyayMWcbLHzKtsDyVGxh3l8wMX/rIOk2CZFcviydW0IJqNQRrwBWQ5oalCAnsr8h9
 jTZy2o4FkpImNTRWop1J66YCYLYJDAIMb1Y2G+NMlKh/Dvh3aieidHxDmWxvHD1ojbEy
 NEuu7YwH8jl1edwlJSKicqwkO9Rbmi+uAnMJDMx0/b7IlxdJfsUgUuFUaITb7Dxf491f
 8epQ==
X-Gm-Message-State: AOJu0YwAsMSc+0hYAerTPO2oZGu3x0nUyc53OTslz/5VLuIc5FA6JS4S
 OevP/8yKI7zY7e0sWKAPGtG4A/Fy0L5tbewS7OCUnPrpSFA2wkQlC0GHkzTpsUzfDCavfUcpUCY
 =
X-Gm-Gg: ASbGncuEZ5mxaXngsQ4jyCI1j1D2EyJKr4ZZtYA+NCCBKzaiNGJ29MIKItFBVtkMTea
 LK8j2xdWEcBp9agEhMwKyYv0RqFMLO4b+pee4ZQfaKveH4ohV7eH6TS9/Ij+Z4vHj8aj90f3um6
 nYBBpvhoI0nCcvfXbDU4VpfrgUBHxHh1GAPW6iH2y/Z06YDJlG+V4T0Yh4spbbdU66iIz49Bvvv
 6V+/SqSQGRAJKOSyO4b3UTMSpIg68EjzQ+QAXg0JtHHMd91n5kdbFsFwTCjqh0ElhDfThqk4vcQ
 OAX04luQHmP5jFgNWbiDsGJPlyCl1sYbqVDUejCOTlGD9r3jepypjgmje4/H/5Z8QUbGFxvMgB6
 6iHXeFQ==
X-Google-Smtp-Source: AGHT+IE+8Q95ogdwtMkqODr5QCiwFW6Jq2tmvBNzu5x0Qyip106rMyl0TwdRc3txJzz1jev1LqQq2A==
X-Received: by 2002:a05:6e02:198f:b0:3d4:2306:fbb6 with SMTP id
 e9e14a558f8ab-3d436b254cdmr50287315ab.10.1741277105098; 
 Thu, 06 Mar 2025 08:05:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/47] x86: Drop use of CONFIG_REALMODE_DEBUG
Date: Thu,  6 Mar 2025 09:03:36 -0700
Message-ID: <20250306160428.3041057-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

