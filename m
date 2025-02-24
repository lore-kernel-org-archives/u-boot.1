Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B2AC021B8
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426D280FD8;
	Tue, 25 Feb 2025 00:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GiyC4dmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9C980FB1; Tue, 25 Feb 2025 00:07:17 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C8080F12
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso132666239f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438430; x=1741043230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=GiyC4dmnIDg56XKo4aNiFV4gI3M0Petmxx3jmjBtNfFIK5l3kTSb15o7uFpLJGo/nV
 Sh/6//GMZpwS0ElRUcexGew6hdVWGyM/o+3YSRh3t7fUm3ZKlloYVccg3KPaOrnGfI+H
 DEkKtXNz0ZECELeLJL+JRoNFeVS/3qUkGBn+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438430; x=1741043230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cT6hyUgzi2KUjmtvWIUj4QWb88R5TOvOKY0GhuWn5KE=;
 b=fGRDQej6RoCIRoBJvFZelZWNnb4+56ROoFCkvfMqy0KkfFMd34/v0fLxdAGo0zKjsV
 IXO/JdMazoGC1UTdKXru30L2gpKyp50v77IqKWt84qnG+6i4V/d7NMHK6+6buP+6ASWu
 CGd2ys4m2tiFUPnL9JMwIJDRLDn371hl0YbY8PGZIvZYsPbDXaLWehdPJACpdh/Zx+or
 SGxHo9wuiAQJtD+TBWlE7nLDJ/14LJMo3IA2/Nz+q0ioZWe/ZJv/2k9Ewzlb9rmfzZQ2
 B5p2QFGyQ7Ws4/oJ0KGCPmyKaRMjGFzSrxBuVfyMwqABkMzMB18ddiGOIHmjKmi/NqXP
 MySA==
X-Gm-Message-State: AOJu0Yz/H67bmWxRuIXQyruIlkJb615dkor0QMhXblPUiNcewL5wxCu4
 w22e9fLlxuJKSb7pBUhB82vgybmCdvKGxxKGEItRipDRXhnLHw/juiAS0ixK6HmArFP/ZnqXo4c
 =
X-Gm-Gg: ASbGncvvOcYrNafVxIbiQXO0X5J+YcwRiwZDxPuTqdx8LJeB2uRilsjnZhx53aH4F2p
 VxpzBFIAY/PkX8izEGZEaBwEcmAW6nF1zvciuRPdSKYBjGvXAwWMTdQ3lpQ/TQtwYVZo197s0bG
 At8NJswU491MEJqF/2ufDET3bqisKnvM4smw3QmB2ZhaRV0g7pm9tABZUCUhEcqwzqcGrLOkD1P
 G/KHcIHw91NhQD0GlO1h0KBLQ7a3bPmmVOyUIvTs8BOSdbFU90+RHyyPt4Arn6E7dDl2d0q+3Q1
 qB4S6+o6Usbg9aZnONgbrmrglgqAGGGBsTpuplfDGXnyxEJYT0YLGxg6hW4JYio=
X-Google-Smtp-Source: AGHT+IHyiEgjnh4+ecgfSFSkiDv6iVC8PWHgPyIKdPUdnMB9F891kOl30QaEEtUBkhcGaZCdTkPr7w==
X-Received: by 2002:a05:6e02:1aab:b0:3cf:ba5:1ea3 with SMTP id
 e9e14a558f8ab-3d2fc0d3910mr12890265ab.7.1740438430574; 
 Mon, 24 Feb 2025 15:07:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 07/44] x86: Drop use of CONFIG_REALMODE_DEBUG
Date: Mon, 24 Feb 2025 16:05:56 -0700
Message-ID: <20250224230640.2665206-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

