Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F24C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB58880FE4;
	Mon, 24 Feb 2025 06:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liGnHWD3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0801D80FA6; Mon, 24 Feb 2025 06:56:12 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8107A805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22100006bc8so67375315ad.0
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376568; x=1740981368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu+hb/RUFLSSzYWsM4EbGH+lnMVB1nkmEfpuUAAwHMk=;
 b=liGnHWD3N5fF8g+wPvglgIOpN/oBZqDTEJwqMN8Ky2gQ84P+fzB0sTFe/zk0nnCwjl
 7ZwJWuNZ5KcLu393jnwqMpjbjFCHr2SjVq5vJSiIxU1j/SSoDZWSrnQxBVxL2Tb02wJN
 Bb2/nMbQuhxj0C3l+m7R94UuXm3E8YfcMd4IUzRpOUrXBvclMAE21RGel1NxDvHdDdKB
 4J7dyabSSWOjjR32m4NDg0iN9PKgcZ7AgfTx/OEdBSv8me0ZmXalBSiKW/q1hG3Dd0FM
 b76uS831Nl/KqEqkx5VmtBDxMOmX8FSemgNwTZJFeEc3n2phrU4HywcW3F200tzYf1xI
 aFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376568; x=1740981368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lu+hb/RUFLSSzYWsM4EbGH+lnMVB1nkmEfpuUAAwHMk=;
 b=a4DmcslOf3pz6RUfcx0esQwNy7da0tZ+1TeJybwFGtxokaI5tvY5jPmAQo55Q63grP
 4HJKj74PYbeUyEUpExB6yNR8CjWxDPYvl0vpplWMW6VLH7bT/tZ4ONlX6MwUiPAuRLj6
 tw52JQgqO1wtrSDyRVyL42KKoYwZqbZs2GiuZz60voECETIC+qWpeWZbfFvwa2FO5cNj
 mT4zv2py40rT9GlKntkT+Xb3Xs6BZzyQ5Hrv34t+KLb6s1lMs9tN+YHHG1RjsiXSZrl5
 myrHjH4SEWF+zrLASkW8WQ8s0r2AQuRhCyNVfcxk5Y0WTGsbJO9ptK6a4GDBwpg7k9dQ
 2PZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+snPnJZpUjjORJ2BZpfHAqCs6oFUewg5eJ753pQX11tX9n0zK6Ma7N1SXI9wLR4Uj30NZsSk=@lists.denx.de
X-Gm-Message-State: AOJu0YwSRGbCkG0uGUTzVFXi+K2mNa7tg7Gx2FVfPb9iGshS1S0DzugX
 98k7vqnoO+k5XN0WG6+DEv+E5Y1XCalKW+BXLxD8e2kmcqp564Um
X-Gm-Gg: ASbGnctG8u3Kt6hDPqeIoQzB/sYnJ6/+eWsrvEHVO6u2rVQN/Xg+fxgU8auKMMv8ful
 +fiGaiD5XMJqHrYxBA7SYLZaAzrXy2tPqbU8+Frzdj+Rww5ML6sjgI9LY2GUIu++YScVVreS487
 jl9NdCLP6ESrtqhN2VDokdVyy8o9rHjo5+0g2pL6+ShusNWgr9DzCE5gw7XztpqpXvOrUof6PTF
 OiF0mRNPV8gP6WuGfEOVgmIYAbur3+UVCIzPorGDnZYZzkqkMdjmyLdakNRwfKN+ZUT3j8rQWsB
 gTpMwkbXIjG4Wsv0QHBYRlfNieJ9sv9o6XWm5Q==
X-Google-Smtp-Source: AGHT+IFVgL1CavuZJp+D4movASpEwPTUFpYZSDqdglcGvEw3BQFJCkCQ3CKKRimEFM5bZxLSU3WGUg==
X-Received: by 2002:a05:6a00:9aa:b0:72d:8af9:bc64 with SMTP id
 d2e1a72fcca58-73426cb1ebdmr16331679b3a.9.1740376567987; 
 Sun, 23 Feb 2025 21:56:07 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:07 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 08/17] x86: Fix call64's section flags
Date: Sun, 23 Feb 2025 21:55:15 -0800
Message-ID: <20250224055524.1334929-9-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

When a section is not flagged with SHF_ALLOC, LLD's --gc-sections
algorithm fails to visit the sections that it references. As a result of
this, LLD was dropping the call64.o(.data) section, which is itself only
referenced by .text_call64.

This appears to be a bug in LLD, but the .section directive for
.text_call64 should really have the correct flags either way.

Add `"ax"` to mark the section as ALLOC ("supposed to be loaded") and
CODE ("supposed to be executed").

Fixes: 7dc82591d68e2a ("x86: Move call64 into its own section")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/x86/cpu/i386/call64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/i386/call64.S b/arch/x86/cpu/i386/call64.S
index d81bcc6f8f4..424732fa3fa 100644
--- a/arch/x86/cpu/i386/call64.S
+++ b/arch/x86/cpu/i386/call64.S
@@ -10,7 +10,7 @@
 #include <asm/processor-flags.h>
 
 .code32
-.section .text_call64
+.section .text_call64, "ax"
 .globl cpu_call64
 cpu_call64:
 	/*
-- 
2.45.2

