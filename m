Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81109C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A46487525;
	Fri, 20 Oct 2023 23:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MLZYAFRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD12A87520; Fri, 20 Oct 2023 23:46:45 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E467987526
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2ec9a79bdso916373b6e.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697838395; x=1698443195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=So463+mvBifKqJcHKBOOs5MUizj5x3eimJQ+Si+QgP0=;
 b=MLZYAFREFGa9CTBK/9WTlBnmRrPEzSdv6k17RtY6bOmmz9Uq4wY1JZDqPqgyM3K74k
 WLkcLznyDWH3q34UJoF99A12XRqqxq9u00OEn3+LkqdnVxiAHLPqk+zAo4fSANPnWqE+
 nlyW+G3dtpglmQidkA8DemkSw8KSQIVFoip5GHPiK3pAWuCDKuWsX686kBQVDnMb/650
 bByzRed4u1bp2d8lnKOB3lYaiLb9Rpsj/NH3FcLjzAWX3tHZhP+Rb2DSq6Cbol+GBuPz
 WCzqiM14P95PM/VewoejyHwtous3IzpLr8KugVdEZZlRMyrQzt6zlIJOS5eLilsIZzEV
 BuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838395; x=1698443195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=So463+mvBifKqJcHKBOOs5MUizj5x3eimJQ+Si+QgP0=;
 b=ppBwXwJ/gIluTXeAtu1u720QPbnO3tc9KxxdMiWacHPS5Nz/M6rBb6uxcsRP4iO8Xx
 AEliYtkzxRnQD8DiQr2OX2r5LGu/AvWQKuCI6AckjlT7Bu03dPUsoYN4kz3zLg1tve59
 dDhRahe4+rhn9iiwFfe7UgmKoBR3nzFEJOGXz7ECXjwCwvlfHm8asLoIrkJDyvs2qkS5
 pCpC7HKDYUx/s7dwJv+K9MIkPNRv5R4ocyUqo02rYJ9+LGrS0C7QAsoq2QZGyG16nPQg
 T/FUTUb6CmyZWf0hUk/unGitqyMgCZlADlqxdE7vGL0NZWLuiaDLdtNZSAq6yfQBnGwV
 XtAg==
X-Gm-Message-State: AOJu0YyQPnzKQGOHjmwE4MEDHkVXInKhjru4hYQ5lVKCr0JzA0Nwo2QI
 vbVxrk+MootwAJVDL8Drfx649Q==
X-Google-Smtp-Source: AGHT+IHLgjWXaQuIVMx2Hf8ED+aFwyxJg0SGWoqxsQaj3+yWqczGHprdHiGXyEMdRlPZmW6GOB/r8g==
X-Received: by 2002:a05:6808:f87:b0:3a7:2690:94e0 with SMTP id
 o7-20020a0568080f8700b003a7269094e0mr4152815oiw.4.1697838395211; 
 Fri, 20 Oct 2023 14:46:35 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 bh29-20020a056808181d00b003a40b3fce01sm484223oib.10.2023.10.20.14.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:46:34 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/3] arm: exynos: Include missing CPU header in gpio.h
Date: Fri, 20 Oct 2023 16:46:32 -0500
Message-Id: <20231020214633.30883-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020214633.30883-1-semen.protsenko@linaro.org>
References: <20231020214633.30883-1-semen.protsenko@linaro.org>
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

arch/arm/include/asm/arch/gpio.h relies on definitions from cpu.h.
Include it explicitly in gpio.h. Otherwise next build error may occur:

    In file included from ./arch/arm/include/asm/gpio.h:7,
                     from include/cros_ec.h:14,
                     from board/samsung/common/board.c:8:
        ./arch/arm/include/asm/arch/gpio.h:1357:4:
              error: 'EXYNOS4_GPIO_PART1_BASE' undeclared here
              (not in a function); did you mean 'EXYNOS4_GPIO_MAX_PORT'?
         1357 |  { EXYNOS4_GPIO_PART1_BASE, EXYNOS4_GPIO_MAX_PORT_PART_1 },
              |    ^~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/include/mach/gpio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/gpio.h b/arch/arm/mach-exynos/include/mach/gpio.h
index f9975d7919f2..9eeeb7699963 100644
--- a/arch/arm/mach-exynos/include/mach/gpio.h
+++ b/arch/arm/mach-exynos/include/mach/gpio.h
@@ -8,6 +8,9 @@
 #define __ASM_ARCH_GPIO_H
 
 #ifndef __ASSEMBLY__
+
+#include <asm/arch/cpu.h>
+
 struct s5p_gpio_bank {
 	unsigned int	con;
 	unsigned int	dat;
-- 
2.39.2

