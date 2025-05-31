Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EA5C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B56AE82BBF;
	Sat, 31 May 2025 10:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lEV79TRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9660882C75; Sat, 31 May 2025 10:45:01 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6C382B70
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a367ec7840so1811310f8f.2
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681099; x=1749285899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZU1PFHE7u3fpebWg6dGRphcldPrnk8nzXBuY6GGQ8pw=;
 b=lEV79TRFWbB1k+/r19NsXDxqGaHiCF6vlcy/8JMTxAn28fDXbN+9+sM0a1v809lETY
 0AehgRfNtEqyS6+fZ//TyQKFn7W9SKs9lZrofO/Vhcn3HLkLHLreLAfuS4iPuH2SZeEy
 VKXGUcNpeSvNeiDYWYRC5x1ULq+UZVQQBpbPtCwDlx1wsX2+/QH8Si8EjJeHr4mEsavK
 EDEa9xkFwvalc2zvYzGXmjGHsSxJ1kYw+u6CSXKyuQGxcZbtPXqj0qJgaedl2ARBuJ/k
 AFruvJTQuGw3JfrpWzd3CMfzVVrqWgQAlAz8lovzlZ1bCKIp+byxmXzch2gtGHVqIuYK
 vb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681099; x=1749285899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZU1PFHE7u3fpebWg6dGRphcldPrnk8nzXBuY6GGQ8pw=;
 b=YO+F5uPyg3vDTzuwyIXCObK1ihniTthBYY5OdU7cqPv1aCZY3Brt1IKSQSO0gNOFUe
 2Q2RmSK/Vnw59e0Ku42XtieHA8+2rX7ddzCcR61+a427ALfhPWJI24JCiJQbvvlnhpkt
 gewDIQX7O6Xv+cqb+AH9/dNGtQVXd4KIwtnzhuOVxli7rSB7+numXripzDnxtSq2Iyey
 +Ls85C59cMCwgrrekonxmSsgxncuNH4X9Pa0hrtaXgfxK4oUmcNsyUYaD0yzLNQi2ck3
 jW21ZZtukY2JX0hYQwfYdYqcWt4T/dqLBQyuXZeWa8IgIjNvisj0/oNurOb7X52vb5sR
 WSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3ie3r11Kvd07L7gYw7e5HEeyBBDHW2NxjCC+WGmEY2ryBW4toiLL7fEyB7VZUbXEFoQ/++fo=@lists.denx.de
X-Gm-Message-State: AOJu0YzAs3JP/jD2RrmdtjpO43or7vgPcOusdq0CQmI3MpCYK8jrLj1o
 KTtSIhkOGBTtKlO8Py0HI7UdC7wvFXlYsxqhH9sg1c2MmKVlXqUxPODqz5yvxSX2/e0=
X-Gm-Gg: ASbGncsWMGoU0wt5pTCzSjx9CUpaizwIaNcx/Sdu10tICPvLMUfWrSx7j5riSUUMbRs
 YEuH1kGdbCNoMiks6znHDC3hHeKRHneVkRNzVNsMUgrkuC6xvSj9xpKEC4pb0k5dTeObFqaMpW4
 GJdgFfEHu4s8/HEOI10lpvps/LZI2DOX/toYwkQ9MQF0n63C6zQtNbaMTX/XXEGDDMxrCD3Lwa8
 uuI0xu6VeVrxrUvxFKbLxt9L5lKFtA7ouIhX8Upb6E/VwrGAfjMNWcINfyoj139W9TBI42aAIc1
 ZPC5EyIGBLxBwfHt+bVqnWWykCZYskbr0kNh37UcBDIAbcSZl+lAc+RRz46I2SFYFEB/aJNWMgY
 g4bxObCEvLxIagWhi5M7BNUbvxJvbBDZJRxJWylA9
X-Google-Smtp-Source: AGHT+IFS4GdROQG/wtFYgEdSMwu6H7k9seHA5XHj3fRpa/oOvabTstxyeP3smEUbY42FqNhwjQ6sdQ==
X-Received: by 2002:a05:6000:22c3:b0:3a4:ed4c:422f with SMTP id
 ffacd0b85a97d-3a4f89e2c1cmr4688661f8f.44.1748681099112; 
 Sat, 31 May 2025 01:44:59 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:44:58 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 04/13] kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
Date: Sat, 31 May 2025 11:44:32 +0300
Message-ID: <20250531084449.4125187-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit ad15006cc784 ("kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9098e732b4a8..82bcc097e493 100644
--- a/Makefile
+++ b/Makefile
@@ -446,7 +446,7 @@ ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 LDPPFLAGS	+= $(CLANG_TARGET)
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.49.0

