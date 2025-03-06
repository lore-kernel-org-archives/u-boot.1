Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F52C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCC981298;
	Thu,  6 Mar 2025 17:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="es3Mbi6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D1E8193A; Thu,  6 Mar 2025 17:05:16 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEBFD817D8
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85afc05fc40so23909339f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277112; x=1741881912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=es3Mbi6Nts3FkZBTF279imUA74plcw0GojpHNFpgqKKOzcSD5E7ftJw0DADj4f/M+W
 YKkQBjvfH/6DNISJj6j+a4Gij1sP1887KHs6rwYE4akJvpJliPX2eod1NNvfizkhktGH
 wGf/MShFGPE1NPPX4/X+GDAvG6W37vB3sqMyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277112; x=1741881912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=fzXn+oY2kgPDNA6efaTBF4SiakzTg58cILuH3p+QtDbmsjv3fdjNq+1uYbnOoAFlGH
 Y5pP2vXqvUZh7SggDuU+orlzsfqdcvo82t449vjZ0mH1jaivqInbnXgfDFlzNO3zy4cU
 dvWgmc1/WmC/JIvicFJIeUsYz1vBTfDPCWQlcglVuYosnX4K8VsXbU1V/0ZodTm6osG7
 N/jIwlf1FRSSaMY91O1kqqzsSLFL7jR0eqkk23dQeuQzuVXH6T4/GSwISl1xoFwFM9CL
 cCYn/2tgOz0Yo3qhz9iSlAZcHvWargn0ZykHsuZHw8iJev9dTaF20aTXIaKSBZdJKyXD
 SDbg==
X-Gm-Message-State: AOJu0YxTS6qy1sMVA7V7NIYf+mMLnYPGHnrd8fgB0fXB84ibpIjqR7rK
 vKVP9MMfiJPXV01hvsW79mwuLI6yuz0Yi/Tn2IXVaZf8rxEv2q107leCfepWqCAgLVms8+KX3zA
 =
X-Gm-Gg: ASbGncsmyZLD+Oau+0Dr3lYhwh/966V1vHdtZdDwQZgC48xWW1KcNV6lJ3D+40qwsuz
 4ZkrXhEcehzNA248j6E/9A879MxXVDoAhR6kz9qB1JrKzcP58W1eoIQ+XAe72V9KUQ88IBEnip4
 dP1XFFl1lkWD/JRxwlXZQ7pBlZM3Fu+rdWUtRlBWXLIUVDjab5SgejcHAyyb2CC65PtGJ7FX6bY
 BG8ETOm5hNYdOtrpCSSpltRZ7qAL+296D2marLoy0TPsjwmzpeHEGCbXXDFnGY1zDvq+9/dHt47
 OxMEaTIjlwooADBryvls33oTgz+LDFUh8dhmPu1HS19lgwEbANyvHFmbB8UyFRx2qwxwblHNBUy
 L3AGDig==
X-Google-Smtp-Source: AGHT+IEdX5HoCBmgIqKf4b5hzMYWs1CXvlKuG0mI+7RfkzBFoppJxH8P/5PF2jifCi2Rgp4FzZZ5hQ==
X-Received: by 2002:a05:6602:1596:b0:85a:eee2:fc7e with SMTP id
 ca18e2360f4ac-85b1d08b303mr2003239f.14.1741277112072; 
 Thu, 06 Mar 2025 08:05:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/47] x86: Use defines for the cache flags
Date: Thu,  6 Mar 2025 09:03:39 -0700
Message-ID: <20250306160428.3041057-13-sjg@chromium.org>
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

Use some named flags when setting up the cache, so it is easier to see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 3bbad3b2eca..845e00ca439 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -592,6 +592,13 @@ int cpu_has_64bit(void)
 #define PAGETABLE_BASE		0x80000
 #define PAGETABLE_SIZE		(6 * 4096)
 
+#define _PRES BIT(0)	/* present */
+#define _RW   BIT(1)	/* write allowed */
+#define _US   BIT(2)	/* user-access allowed */
+#define _A    BIT(5)	/* has been accessed */
+#define _D    BIT(6)	/* has been written to */
+#define _PS   BIT(7)	/* indicates 2MB page size here */
+
 /**
  * build_pagetable() - build a flat 4GiB page table structure for 64-bti mode
  *
@@ -604,15 +611,17 @@ static void build_pagetable(uint32_t *pgtable)
 	memset(pgtable, '\0', PAGETABLE_SIZE);
 
 	/* Level 4 needs a single entry */
-	pgtable[0] = (ulong)&pgtable[1024] + 7;
+	pgtable[0] = (ulong)&pgtable[1024] + _PRES + _RW + _US + _A;
 
 	/* Level 3 has one 64-bit entry for each GiB of memory */
 	for (i = 0; i < 4; i++)
-		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i + 7;
+		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i +
+			_PRES + _RW + _US + _A;
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = 0x183 + (i << 21UL);
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+					 (i << 21UL);
 }
 
 int cpu_jump_to_64bit(ulong setup_base, ulong target)
-- 
2.43.0

