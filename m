Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A5D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386578394E;
	Thu, 15 Jan 2026 23:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QeqTA/JJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C5783935; Thu, 15 Jan 2026 23:28:41 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4158D80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfca52ac2dso912987a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516118; x=1769120918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/6jFxqSzaRUxHVDwKEB5LuH0Hmtod3ua/9w2rZWfno=;
 b=QeqTA/JJ4Mk4ij5mZ1qghQ1cjMitqhBr9UBa7/mglL4irMwN4gUW1LeRBZkqCXuDcC
 5K1zqCurMl/0AblNdaRip/xhnE06sxEL7CFsOAv0TThyQi0Fi+RFjUTS3BWbe5+nJu5I
 rbvPM1pspBtXVx4r9g9hWSb9KKPYzrMLrtadM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516118; x=1769120918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/6jFxqSzaRUxHVDwKEB5LuH0Hmtod3ua/9w2rZWfno=;
 b=NfRU1Fno9u7ukXctM/NOpLZts31FVVAWQ25qhm9OHX2dLUWkGTPa52uA24t9IjZHNJ
 wW/GkXSN5dVKZi18EKikGbtoo5phpH0+hbkU3IetWCeEc/LJ/bctV3liaMOPkHa6X8+6
 TImB5QzamkqlqmjadKsGuyB3HzwLf+bbmxnOX5SZykk3844ML4RrS9+pIwRdZpKoQHEK
 mzk+sGRJOb5qP0TlnJzD6LGm8e9Hi32yOkb1+uUnpQc7L74j6mQm9Y/LL+Y8RRRNHwWo
 ky3cbcNIYuGZ1u12quiyd946+jpmWHLodKE4ub1pRaoi17y9QTJJ+ybHE07IYiwCVc6/
 IlHg==
X-Gm-Message-State: AOJu0YyOOMYvT6g73ZwgH1dcWbndsMcwAPpY12U2cScV6OXnGeyeRMbG
 2P3Ue0jMdcoaqrIWcFkC9THaZ3kWU1S+B43yrxynLMzRa/7nplCLbO8+TBZ3PvrV4GRsivI3wNF
 qKm5sKXM=
X-Gm-Gg: AY/fxX6tRsXKBC3shrAKn17yJcYNuOFP+PWCC2+Z1MBc6gdekqW0bXShcbmPe+DtbX6
 6IsYi2x4wt84fFXODEBgjAnIX7KYwqMThNCZQo1WwYlhjmqgJpE/a3znMeF/0p2ueWWy28tFvJT
 Bkylh3KvZqLpkPPd894zrgwqrHvsxr5W1kFaidWO6hTPtQyD552ilsabCXZu8pXots0Cf3hOpV5
 O7ExJjvLIAqvNkYK+Q3lVa6959eJZXmanSA6Ug3A6gC5T1wZ5ZdzZHkmi3SxcKrKhkysBQrnoYd
 sMKKoQ+PcNcMbMSS32XESP8d1gBHLS1L5xJXAARTItvIqYbugWN3D6BdxyXj8sqlTBipOWqAsOg
 cXghiQ3EW4WUAJ/91H3x/pI6Y7AnPlDBtbLLcR++k5mkSaiDSyzm9kx9+ICWW5dSJT8j9HfGSBs
 hOzLwH2E4lyh+Ob05FeOKr7tCoRHpXFaZqgNS1dqeqMKKmbAiB171TuxM4fgJGZeIY52mDuOzCt
 JZdkBQaf18kBX1jGBqDAWaBrSCx/0nDf8kWw6mz0A==
X-Received: by 2002:a05:6830:6f42:b0:7c5:3a34:994a with SMTP id
 46e09a7af769-7cfdee22628mr707332a34.17.1768516117843; 
 Thu, 15 Jan 2026 14:28:37 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 03/10] m68k: Update linker scripts to ensure appended device
 tree is aligned
Date: Thu, 15 Jan 2026 16:19:33 -0600
Message-ID: <20260115222828.3931345-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115222828.3931345-1-trini@konsulko.com>
References: <20260115222828.3931345-1-trini@konsulko.com>
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

With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
that we must have ALIGN(x) statements inside of a section to ensure that
padding is included and not simply that the linker address counter is
incremented. To that end, this patch:
- Remove part of what Marek Vasut did in commit 9ed99e2eeadb ("m68k:
  Assure end of U-Boot is at 8-byte aligned offset") as we now better
  understand what can trigger failure and check for it.
- Rewrite the '.dynsym' section to follow modern practices, and include
  the 8-byte alignment at the end of the section.
- Ensure that we do have alignment by adding an ASSERT so that when not
  aligned we fail to link (and explain why).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 arch/m68k/cpu/u-boot.lds | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/cpu/u-boot.lds b/arch/m68k/cpu/u-boot.lds
index be1ad0170af6..452003ff43cb 100644
--- a/arch/m68k/cpu/u-boot.lds
+++ b/arch/m68k/cpu/u-boot.lds
@@ -69,28 +69,27 @@ SECTIONS
 	__ex_table : { *(__ex_table) }
 	__stop___ex_table = .;
 
-	. = ALIGN(8);
+	. = ALIGN(4);
 	__init_begin = .;
 	.text.init : { *(.text.init) }
 	.data.init : { *(.data.init) }
-	. = ALIGN(8);
+	. = ALIGN(4);
 	__init_end = .;
 
-	. = ALIGN(8);
+	. = ALIGN(4);
 	__rel_dyn_start = .;
 	.rela.dyn : {
 		*(.rela.dyn)
 	}
 	__rel_dyn_end = .;
 
-	. = ALIGN(8);
-	__dyn_sym_start = .;
-	.dynsym : {
+	.dynsym ALIGN(4) : {
+		__dyn_sym_start = .;
 		*(.dynsym)
+		__dyn_sym_end = .;
+		. = ALIGN(8);
 	}
-	__dyn_sym_end = .;
 
-	. = ALIGN(8);
 	_end = .;
 
 	__bss_start = .;
@@ -100,9 +99,11 @@ SECTIONS
 		*(.bss*)
 		*(.sbss*)
 		*(COMMON)
-		. = ALIGN(8);
+		. = ALIGN(4);
 		_ebss = .;
 	}
 	__bss_end = . ;
 	PROVIDE (end = .);
 }
+
+ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
-- 
2.43.0

