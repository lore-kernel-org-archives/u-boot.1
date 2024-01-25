Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099CFC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A61878ED;
	Thu, 25 Jan 2024 15:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKx+K6nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7213E878C9; Thu, 25 Jan 2024 15:07:43 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1D2878ED
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malu.bertsch@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cd0d05838fso80518501fa.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191659; x=1706796459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3JOvTDjKUDxMBUyWCcpMmYfR44EjTqUq1rmcvqJzWs=;
 b=XKx+K6ntxtqKAWafgGcjoxVToALSnjFc+bhzHswkH4Fg8DoqMy+0OVaFcsjG/7yVD0
 FDIrs4Aw6rfkHDUK7xX0ihikpK3Xc7BNHTywpkqp6J7i0cuRCtqCcn7BQSOpTytY8GGB
 lqI2BgpQPNBot/GP0J2Kcfwnf3DAJvTpl6eO4mx9CXjsvqmGHnlsMkjdc3mK2TUUM7zQ
 ilUiyN73Ayt7u3EADyXa0F94Jk1s9C5LL+AKA4tEzZqqa1yzbzqkej4Ryod+h31dBmAv
 tooU1WA6+GJcNd7cPL1Bb13oXvev022aBq/ZFQ1fq95vd+EI6SOORNYg6ttsLp0CElnu
 4noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191659; x=1706796459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3JOvTDjKUDxMBUyWCcpMmYfR44EjTqUq1rmcvqJzWs=;
 b=V4/eQm5kf7QbZjmaZRWdjxuLYpKzkchBrYMmKvHS23DK8sHtYtHxorp7fU7SeY0di0
 0zcKwVs//lAfleoN6uZpsE6XcMfWlsdxnHJECOirqPs7laAQbFpbu8Jj6NpBVFeVMSVr
 Xe2lgDDga/MvgjiAqarQzo0gK81xyAXK4m+rY9tRKlj2VfqiE6iCStJmxpnztFL8lehs
 WICDnhyv/48Y8Tj85mKVvEaH3NG5NULqkGHw7CKNck42XfrHknLwwKKkswVwybUg2MHb
 c4wPBTsmiv6WqkqknC7dFlkaS4TDTSSvbePXMDC4hJ1KmhvHuewsvH7Ln8DK16cgRh2u
 HvxA==
X-Gm-Message-State: AOJu0YzEXEQvsQXj9M5sy89Ylw/91aP3FtNWbhmfY5Aj8FHMIkVVHUmy
 h6Zi1JVHc7xMAbQ9+cpkW4gClkaGt9qD7LDX/9S89eb/Whe/7oUZJwdloRM0PZY=
X-Google-Smtp-Source: AGHT+IFiNrCeLI6YQDSRjslh8wVJKMfZ45RujFYkBSyWjP2Nf6M6H6nT6CRYxXXcIVlGxdXpN0ucew==
X-Received: by 2002:a2e:9bc3:0:b0:2cf:15a8:3bc6 with SMTP id
 w3-20020a2e9bc3000000b002cf15a83bc6mr509372ljj.28.1706191659132; 
 Thu, 25 Jan 2024 06:07:39 -0800 (PST)
Received: from localhost.localdomain (pd9fafaa6.dip0.t-ipconnect.de.
 [217.250.250.166]) by smtp.gmail.com with ESMTPSA id
 ee15-20020a056402290f00b0055d18d6a586sm83136edb.13.2024.01.25.06.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:07:38 -0800 (PST)
From: "=?UTF-8?q?kleines=20Filmr=C3=B6llchen?=" <malu.bertsch@gmail.com>
X-Google-Original-From: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?=
 <filmroellchen@serenityos.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?kleines=20Filmr=C3=B6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/1] riscv: Support building with Clang
Date: Thu, 25 Jan 2024 15:06:59 +0100
Message-Id: <20240125140659.28229-2-filmroellchen@serenityos.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125140659.28229-1-filmroellchen@serenityos.org>
References: <20240120002049.GO12635@bill-the-cat>
 <20240125140659.28229-1-filmroellchen@serenityos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The -ffixed-gp option of GCC has an exact equivalent of -ffixed-x3 in
Clang.

Signed-off-by: kleines Filmröllchen <filmroellchen@serenityos.org>
---

Changes in v2:
- Removed copyright attribution
- Use -ffixed-x3 unconditionally as it is also supported by GCC

 arch/riscv/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
index 9cf2aef0a4..9f16dda92a 100644
--- a/arch/riscv/config.mk
+++ b/arch/riscv/config.mk
@@ -25,7 +25,7 @@ EFI_LDS			:= elf_riscv64_efi.lds
 PLATFORM_ELFFLAGS	+= -B riscv -O elf64-littleriscv
 endif
 
-PLATFORM_CPPFLAGS	+= -ffixed-gp -fpic
+PLATFORM_CPPFLAGS	+= -ffixed-x3 -fpic
 PLATFORM_RELFLAGS	+= -fno-common -ffunction-sections -fdata-sections
 LDFLAGS_u-boot		+= --gc-sections -static -pie
 
-- 
2.39.2

