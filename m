Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D1C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E314980FB1;
	Mon, 24 Feb 2025 06:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WMz+sQ5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCC880F16; Mon, 24 Feb 2025 06:56:10 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1599B80FA6
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2211cd4463cso75786735ad.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376564; x=1740981364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POjcyzWgFJunkriBJXoxdN1R45iq2nXCYMl+njD7Tuo=;
 b=WMz+sQ5hIa/L16cimPFvpfsv6Ko6AnnQxyez1YoAH5eQNAjrOCSnZPB/Ij6MQmlwA/
 lQHFZAPVyo2UhX15w6kwvA1ww8/soU0kTPxuX+AR/H8ahAkqP0spK1xhRCXsHLFN5ibV
 piX8TLryT+msBfDHAYZt7kX9S+tWf2O5mJC4LKYcC3TxgF8g8S1hyzlGCaNe9U5tpClj
 gSODuwYUFDhmaE0P0qEGG0BzTpmI5TLhDIsqDbsJZwxlZjvFraMSmEMWl8LoKss/PaFD
 RwwcQlbZs7u61zBuaKB6zB/d6NTQ2UAJnr1PZRwguKvDY4qt1RcNi/g1yq2dkUhUariL
 3t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376564; x=1740981364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POjcyzWgFJunkriBJXoxdN1R45iq2nXCYMl+njD7Tuo=;
 b=BYopY+ppmKEglEoNFfTROXhpjjbKd25hLlJiFxx0cvMO/balFsNyf8UYekhKDvzo/k
 UkpxOySo/qu9sRONtUhCvBjPhAD1wsi9fMxNxeqSQDAsfTriN9v5EZUwDyhOG3XnFOMf
 fjsHLpybFV/28dK032kOA9jOVPYQ1en7s2GF16lO2czE0dKTbtrSFWgl88fjbLoUI5Bo
 +hVnYObTOf7X5Yeme08NZT+EyJCT9r/PE7PkAMUB2wI/qcG9aDeNRDWj1BMhdCIssWUr
 UQnP2L7UkblChXXUXYnOPvUf6aFdyPGd6dnFhboFEjJbCtgPiAqzpPA7f3YKvmSg1AUb
 FuhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1TzVozdeZRlRROjYWYbLcCvykA4SRUsDxfDQJwXVkm/M7jhveKA9YTfAsXY7y6fqcQjXb2YA=@lists.denx.de
X-Gm-Message-State: AOJu0YwKuZWAkenAlKuocwHyQUvIr+HG+RyGOKX+n5LsDDOZaGjD7RPN
 8fetF0iNwZmhm8xuap7Q4b4dQ2/U0kaL4MttaeLBUsc9Uw7CMSFT
X-Gm-Gg: ASbGncsBFUrIjcKG+KrFsQLS5kfU7l1sywobxwRK0b+prnUsGIuyNKIUY5dEGw84oRx
 gbz2wDKkbq2+De8xyzVBJ1y0e6LumOy6hXOV6OBymMx1+mCZPtqrNwZiYTfc5blVid0FBmMcEzE
 0WfT6vLlrtDg2vkBovanexCmGp/YxIs5TLdcuqOG0rVt0ztqTUeoIH0Jj97mSLLK1PoeFShrfCC
 nTVa79h+he4/NJbiYMWuSFoS5PQ5LwyuvCdebeoI5FcnziKPD6FVak98yUfs9gXQDeg006CFIO+
 g7XMN9Kd3uxt4GJBhxJduw0rf/O2DAuW+pnHVw==
X-Google-Smtp-Source: AGHT+IFD7ArVXckoxYYQRVS4KfGV2wIKmZey7FDMEZQzskwyS/+rLKLHVy+dWmJ/j4UfmYz5/hW6kQ==
X-Received: by 2002:a05:6a20:2444:b0:1ee:d06c:cddc with SMTP id
 adf61e73a8af0-1eef3da4cf2mr25426015637.30.1740376564589; 
 Sun, 23 Feb 2025 21:56:04 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:03 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 06/17] arm: Use -mstrict-align when the MMU is off
Date: Sun, 23 Feb 2025 21:55:13 -0800
Message-ID: <20250224055524.1334929-7-CFSworks@gmail.com>
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

On ARM, enabling the MMU is a prerequisite to enabling caching, which
allows unaligned memory accesses by consolidating them into aligned
accesses. When the MMU is disabled, however, all accesses must strictly
adhere to the alignment rules.

Some compilers (e.g. Clang) contain optimizations that may break these
rules on the assumption that misaligned accesses merely incur a
performance penalty. We do not necessarily want to prevent the compiler
from applying these optimizations where it believes there may be net
gains, but we do need to tell it to respect the alignment requirements
when the MMU is disabled.

Therefore, add the `-mstrict-align` compiler flag when SYS_ARM_MMU is
not set.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/config.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index e0045e22271..98237b251f1 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -33,6 +33,10 @@ PLATFORM_RELFLAGS	+= $(LLVM_RELFLAGS)
 
 PLATFORM_CPPFLAGS += -D__ARM__
 
+ifneq ($(CONFIG_SYS_ARM_MMU),y)
+PLATFORM_RELFLAGS += -mstrict-align
+endif
+
 ifdef CONFIG_ARM64
 PLATFORM_ELFFLAGS += -B aarch64 -O elf64-littleaarch64
 else
-- 
2.45.2

