Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF4C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371C481BC0;
	Wed, 19 Mar 2025 12:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hq0g5+OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EEB81D25; Wed, 19 Mar 2025 12:59:40 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B5881D5A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so31236045e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385577; x=1742990377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqocY9btUAb4Z7YuGrsDBrQdneNJJSt/7DcVGBAHz0I=;
 b=hq0g5+OOgXg8j6QnGN3hwpM9B2+nExDFljh89ICKZTOXx92bbklJvPIkegTzgmxhC7
 8hJf5UWJ5E0GSLQqH7Xu3CMVDmZqk0awW4ElGwPoZzrld0FkytrUFJ+BXb5bMpeErhMa
 7YfPHukIlY/idLt/JgftBCdLwbHntiIrqfCUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385577; x=1742990377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqocY9btUAb4Z7YuGrsDBrQdneNJJSt/7DcVGBAHz0I=;
 b=PG8N5ONNsG+1HjYPMBUV7cXjwzor1tsx0pazneZ7IFvSNCMammz37ACFOMPgRw6LJI
 VF4zaWDF6IalY/XZGM+F+f3WPOb6k/tUfGXpEuVC+quJMRgwABIrBAr0GiOW4z3HaP1T
 3fEWQvaPqX9RWf+dj6BUYLnO8bXwTkWxsfzRJg9ZD6XB/bu0dnSABhopBiJ6O5JzaVl0
 6tMZnlbvqbKqhXRW60+TZmFbCiFcc1LL/Aye5nHcG/Arb26KziOTWBEydVMKwM5kQVaR
 HRyvgqzOyfwQKhZ2pR5sqmUbPkRWjgN4mR//NtEP9jQBE9aMhtB44hG1QHzyi6E6K6tc
 M64w==
X-Gm-Message-State: AOJu0YxpJbNGtoQg4/76Ajbvl5IxBRjSEm3vHQcyKXw7Vtca9ANzEHT7
 m4LSAzkJWu8eFl9pPY+OBBhCWmGQWV61LC3TkKu0P3OilxGSK3E4xlc1LoF22RX7l11AKeyqaux
 2wg==
X-Gm-Gg: ASbGncsq0iIGSIvzsHU4z2iGcqYzaZ1iFd+Rdf+rQjd9s6C3hU1N8rfWeP4r5Otojk7
 1sV4XI6yYKGJdG0rWzXR6FFsMeo621inF/t5JPfe1UYVYHs02u1ISIH2uYuH/jBj6SX7Ma+udIy
 FDihl/lNhs3fC6dIEVht9JeRxLSNCan/qOKqjHYqGHDC8/2lprF0WsW/MEKoJZ3rTvm38P0oiwF
 uqF6EG9psnS6rWlh7cnK7UCleoy8oxwAiQny3gPZXhKwgWOS6d2YKtKE7oc21lc1LQBkhUtzrQw
 QegIQY1H6ceFyLgXkHBmQ0WpQzIPmB/n8opJ2VsBsQ==
X-Google-Smtp-Source: AGHT+IEXBMfWALDrDn4i37o5gqF7MnPl5MKemzx88E/kyF6hCb9xTQ3NA0PTwy1OeqPSEJRsahDJ6g==
X-Received: by 2002:a05:600c:b9b:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-43d43842251mr18472965e9.19.1742385576798; 
 Wed, 19 Mar 2025 04:59:36 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 5/6] sandbox: Enable PHYS_64BIT for 64-bit builds
Date: Wed, 19 Mar 2025 12:59:07 +0100
Message-ID: <20250319115911.2204045-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

Sandbox is special in that we use the bitness of the host. This should
extend to PHYS_64BIT as well, so enable this option when building on a
64-bit host.

Update the conditions in io.h so that 64-bit access is available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Kconfig                       | 1 +
 arch/sandbox/include/asm/io.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 2e63896c477..c80d6128260 100644
--- a/Kconfig
+++ b/Kconfig
@@ -448,6 +448,7 @@ endif # EXPERT
 config PHYS_64BIT
 	bool "64bit physical address support"
 	select FDT_64BIT
+	default y if HOST_64BIT
 	help
 	  Say Y here to support 64bit physical memory address.
 	  This can be used not only for 64bit SoCs, but also for
diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 3d09170063f..3c3545a2747 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -39,13 +39,13 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
 #define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
 #define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_HOST_64BIT
 #define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
 #endif
 #define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
 #define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
 #define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_HOST_64BIT
 #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
 #endif
 
-- 
2.43.0

