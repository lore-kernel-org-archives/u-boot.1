Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6D2C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 16:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F4F87D61;
	Wed,  1 Nov 2023 17:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LWWZeFm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E55487D3E; Wed,  1 Nov 2023 17:28:52 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18A587D49
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789a4c01ddso483219985a.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698856122; x=1699460922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5YuUYcd5qCMHGa8GmHwR6jjVCXP8Siwoeiigc8FQ5ZE=;
 b=LWWZeFm+MDCLeWOSSj3ZsUpf1T83TR0sUGs4RoS04+u1jCM3hYlF0VxHosIsXme2GX
 4SAcqE/QKa2SaKHRMlIURYzvEVtJc02baBzGt3i/9bZbXV1gbhjrH08YDJ6d3EiizACo
 nqCThKJUTVywXdH+YYcUWo235znj39vLmaPpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698856122; x=1699460922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YuUYcd5qCMHGa8GmHwR6jjVCXP8Siwoeiigc8FQ5ZE=;
 b=c+hYzURrIm0W9sCuPKSFygKf972D5V5zqUleRWPwblbLv0WG/4572In5Q3hLgentBL
 8dW/A7CZxit8aPy0kDltfpyPwymr9oOi1kd3QX5/L2aV6S2yJ3B//8DrknxRJKaTdfH/
 SJ6PhaiuLLHm3MP44XOS1Vjq8TjzgrEOoMlRYgF5oKGvDrOyUpjkmiC7M42gxTJeN6HL
 kTibi1aOxs8ZPmHJoReUvbrZ6b9AJrhtI2ZFHHZ5Y+insFHXLVtDMqX4UkdvGun1NOiQ
 yQbSKgAQ22VB2+yKR6LqWbsVJ3njldhCjQeleDRNrJCbpYzl3L11Ea25SvY/H/mfwqYz
 FT9A==
X-Gm-Message-State: AOJu0YwhU9u8kTpHlW6K9yYKcAHLdATnGy6FoM+Dsnce6+c2wI7JTOYR
 +eUGgkveAVLJYC5lhu19KTWt5Ucz9munbfMzUB0Jxw==
X-Google-Smtp-Source: AGHT+IHKhmk6xMNMowM3UIcMSiETZtgvNZbL/WWvlERaOBHavSaRhpUV6oYxHIUBnl8oCL+6pXIhOw==
X-Received: by 2002:a05:6214:2122:b0:66d:50a8:2439 with SMTP id
 r2-20020a056214212200b0066d50a82439mr25652557qvc.23.1698856122259; 
 Wed, 01 Nov 2023 09:28:42 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o3-20020a0cecc3000000b0065b21f1b687sm1610238qvq.80.2023.11.01.09.28.41
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 09:28:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 20/20] x86: Drop <common.h> from remaining header files
Date: Wed,  1 Nov 2023 12:28:24 -0400
Message-Id: <20231101162824.3755579-20-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101162824.3755579-1-trini@konsulko.com>
References: <20231101162824.3755579-1-trini@konsulko.com>
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

None of these header files need to include <common.h> so we can just
drop that entirely.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/x86/include/asm/arch-slimbootloader/slimbootloader.h | 1 -
 arch/x86/include/asm/dma-mapping.h                        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/arch-slimbootloader/slimbootloader.h b/arch/x86/include/asm/arch-slimbootloader/slimbootloader.h
index 05dd1b2b4471..460bfc4f2d4f 100644
--- a/arch/x86/include/asm/arch-slimbootloader/slimbootloader.h
+++ b/arch/x86/include/asm/arch-slimbootloader/slimbootloader.h
@@ -6,7 +6,6 @@
 #ifndef __SLIMBOOTLOADER_ARCH_H__
 #define __SLIMBOOTLOADER_ARCH_H__
 
-#include <common.h>
 #include <asm/hob.h>
 
 /**
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 8be1003e6baf..c79ec64afd7a 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -7,7 +7,6 @@
 #ifndef __ASM_X86_DMA_MAPPING_H
 #define __ASM_X86_DMA_MAPPING_H
 
-#include <common.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
 #include <linux/dma-direction.h>
-- 
2.34.1

