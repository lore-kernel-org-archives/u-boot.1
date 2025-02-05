Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC2BC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024D28078B;
	Wed,  5 Feb 2025 02:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8HVe5v/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21612809D0; Wed,  5 Feb 2025 02:57:41 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356EE8078B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5f6497fbccbso244585eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720655; x=1739325455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyhEkAf8NWg8M9RIq27iYrRoDESDLW/NjPWa+zjeNwE=;
 b=B8HVe5v/v4FsGRz2IiQZimNeTu634Hn4HrucX79I8A7RH8Xihi50TGwNBFgjmDTOEx
 jxODt77DFEu2zm13zuCorLL5bYXR0jrDmT5ib3YL8Tti69Aaf7FknWOm8taggoOQQUED
 GyI0jaNcCUBjHLX3xT6HFnj9R61F2Ol4Aka50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720655; x=1739325455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyhEkAf8NWg8M9RIq27iYrRoDESDLW/NjPWa+zjeNwE=;
 b=v8WCvB3MjXEjYWWoE+pOONC4VGvUPWAy3lAgYIuFYFcufCn6A/wHBB8hHNbn0lascS
 1oKh1vppIExjgE21+jisMbjpe6OxtDkqufzjoL3TU9xGf6zzqZ0iqbdxRneRUIjBu6Kx
 +N4pWZUjcz3+J7Kn1MXJlm9GGNTUMjGEKM9z85I99tCluO4mjCdcbax2zINQ4MuRUq23
 mWl+Ejxd2cP0+18aTPdNl+hWrNDlJU7GBjsWOSEJqLt5dgqCiS7e/eH06TKpcw7nu+2k
 E4kU4F+swZAS63cU43Lqf2890L0NT8zfLa76EPSfKcuuisPwU9h1A4P+d2oG2mwwHXzE
 Mjsw==
X-Gm-Message-State: AOJu0Yy+6VTjiSBm5JmTDagGM7KM0UFqenIoPeAEuTd4UiSgOstIovLT
 d4JmWRaqnHMpd9putuZjLosO5drfD3ShVuvXC/Afh3wUDw3XW/CrmGxd4eTti8UOjfGX45hZM/0
 =
X-Gm-Gg: ASbGncu83HFj0KRqQqadVwPAdxgODL6y4YKm+tmopl556huVLRQ2lgtKu8G+ms3Ef1N
 1yhBrAA85jHBUzKmNm0SrW9qbJUdJuY8wLLpL2jIXCKm3SWndRLqSxP3kTYy4SOcsRlNrlIq1jC
 /M0w0/MzGaYgUCo/EI6Nqw305gl9j2MyAxhaPfFk+FHM6Ky5kgomE1oOH0Hbzf5kOvuEDmyD/0K
 QspoekTBku/O8fNjulzoClC/y22S1/O3N8KqiyTaHat2P2rVKPPEO8/uCmyiPF156wstQrncF8P
 rZkJX2YvQPwaHQZ8BmWIXxs5nBn/0gN4W6EVWQLoaHUXLGbtF3iS
X-Google-Smtp-Source: AGHT+IEeYFrzHNAObt2s6SN3jaF2+6xwxco90IMf2O8Z2PLKORZUyZNTXntvcbr9U9QKlBZJ5XPzDQ==
X-Received: by 2002:a05:6870:b9c6:b0:2b3:6858:e955 with SMTP id
 586e51a60fabf-2b3e7741f6emr3508600fac.18.1738720654935; 
 Tue, 04 Feb 2025 17:57:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH 22/29] rockchip: Add symbols for spl_reloc
Date: Tue,  4 Feb 2025 18:55:12 -0700
Message-ID: <20250205015606.2686149-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Add various symbols so that this feature works as intended. This allows
xPL to copy the relocating-jump code up to the top of memory, then use
it to decompress and start the next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 958a1b70aef..842bd4eb07f 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -25,10 +25,21 @@ SECTIONS
 	__image_copy_start = ADDR(.text);
 	.text : {
 		. = ALIGN(8);
+		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		//. = . + 0xc0;
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
 		*(.text*)
 	}
 
+	_rcode_size = _rcode_end - _rcode_start;
+
 	.rodata : {
 		. = ALIGN(8);
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
@@ -48,6 +59,7 @@ SECTIONS
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
+	__image_copy_end = .;
 
 	.bss ALIGN(8) : {
 		__bss_start = .;
@@ -55,6 +67,7 @@ SECTIONS
 		. = ALIGN(8);
 		__bss_end = .;
 	}
+	__bss_size = __bss_end - __bss_start;
 
 	/DISCARD/ : { *(.dynsym) }
 	/DISCARD/ : { *(.dynstr*) }
-- 
2.43.0

