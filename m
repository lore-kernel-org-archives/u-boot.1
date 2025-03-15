Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEDFC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B40D811B2;
	Sat, 15 Mar 2025 23:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UF3/QC3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715F980F70; Sat, 15 Mar 2025 23:18:33 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC478122F
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223959039f4so66751975ad.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077110; x=1742681910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9n3qkJGbaMOic70X4gh+5f0jAKfS3gD6IDDnP6fU3k=;
 b=UF3/QC3HCZal9cPrMj13WS5THA/zQ7sYlNfVTD8n7gkph0Rclu1MkgmYG5Du6srtCH
 FW3kBMkSBGKRdqimrAPWe4EMlY44VwQzLrFqd6Sjig7Zbw1kIqLIh4jz0J+Kd1Mfxtt6
 qq40193Q277/yvWlSI30T+LjPpvomiY7dOGQmg1cwVolkovIzAVuKH9V2KaFEan7qk6w
 Cv/c4ERrfF0o+eLtqVpRJSQhYxF0HvGmmfOR7Y2mRqYe/rdE4LIVNAZwxZpeSFvsip3t
 fMagxirQ7YHnZWkjR/LGX4wSfpGSj2U1yTB7RvtD3BFFKIap95SOcu1AQj6OnXwkZWjs
 T/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077110; x=1742681910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9n3qkJGbaMOic70X4gh+5f0jAKfS3gD6IDDnP6fU3k=;
 b=vYh5UWAggXpKaaZBnFvQzjNG8u3ujUkeyY5PrKwZ8ji7ppqNO9vWvTJn0/XwuFuLmO
 gEkvp4+rzJf2RMfEFCQaTFGKPREFosGxag9bgnyEIQ3LzWXv2br8lfl7DVNqb7nBDgHc
 pdSWot2tKmChOm+cdtX4kqrs5qyzPK3dcf6mEeBmPYXbiwAIEOlNDpxcF4ZsDJB5VAHo
 c01y8uamH0NN8/QXVMJ5VxHjGWieHccQk8QiLySbGz8oV3jrA6TKj9rgDzlhVs+ANYBp
 jdsTmiTHhaJH/FodR8bdKeZMAsSrTq+NhPXPxnMdEfOo6UW15vzMrMEIxw7hxYLNd5Yd
 Htiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWSiyixsYFQ4II0IjiAAjhqyrtExNM7G2cf++2i50FRU3vgxxXkhxir6VDG2Ptbbq40QY6z6c=@lists.denx.de
X-Gm-Message-State: AOJu0YzqBTtkz+qD71gJ0YGP+Anf10V1cB4wkbcFIeMZ3HTy27EdtM1m
 AyeiHztaXNb+qHDImGKPc7mpm3xTLHHC35qeyCHZvxFJm1RfkbBR
X-Gm-Gg: ASbGnctkRZdIFAPFwJpw21q6f2XjmrE0rzqVuxiQJF3ivHORaMJ0yRG6e/OUQA3uxYp
 /s7P+gJTqem6dK9p93vsnT00ExQBBAH46iJpMnbOtVlcIOdsMPvqh/9iEMZNOe4zeceDyguCxbs
 djWk0xMgfiwcmEvc3BxeuV0Fsm4j73JbBnbjuuzcNhQ8cwvpFy+6U4Mg4AwWsCNCD50NEdqWcg3
 dY9dvtjwvi8wLdAirkmo0nHaBFsp6lPEh9z0a0rZ8NK5e3wJcsYkWp6W4/yyeQKen7l+o5j0QQ2
 VGLHjBRqxGk4e4RJBmL7mS8xehbCoiAvBGB3BGFLltNcLuaE4Zzt3lo=
X-Google-Smtp-Source: AGHT+IFjEaz5vwaxPt6GelNliNmYOTuYGkaK1YIgtMdEDOPx8OEULomtn7N3kgJLN9YBexoe5U+YNg==
X-Received: by 2002:a05:6a21:328a:b0:1f5:87a0:60ed with SMTP id
 adf61e73a8af0-1f5c126e0b7mr8405139637.19.1742077109744; 
 Sat, 15 Mar 2025 15:18:29 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:29 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 09/15] makefile: Add `norelro` linker option
Date: Sat, 15 Mar 2025 15:18:07 -0700
Message-ID: <20250315221813.1265193-10-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

RELRO is an instruction to a dynamic loader to make a memory range
read-only after relocations are applied, for added security. Some
linkers (e.g. LLD) require that all sections covered by the RELRO are
contiguous, so that only a single RELRO is needed. U-Boot at present
neither satisfies this requirement (e.g. x86_64 linker script currently
puts .dynamic too far from .got) nor preserves the RELRO when converting
away from ELF, therefore add `-z norelro` to global linker options.

This can be brought back in the future when the linker scripts are
cleaned up and U-Boot understands RELROs.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9c353af17cd..05a93813afa 100644
--- a/Makefile
+++ b/Makefile
@@ -820,6 +820,7 @@ KBUILD_AFLAGS += $(KAFLAGS)
 KBUILD_CFLAGS += $(KCFLAGS)
 
 KBUILD_LDFLAGS  += -z noexecstack
+KBUILD_LDFLAGS  += -z norelro
 KBUILD_LDFLAGS  += $(call ld-option,--no-warn-rwx-segments)
 
 KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
-- 
2.48.1

