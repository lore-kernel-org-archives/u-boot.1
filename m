Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E5AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 16:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0560D87AA4;
	Mon, 30 Oct 2023 17:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ucOrhe4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4C487A86; Mon, 30 Oct 2023 17:55:09 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 859A587AA4
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 17:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1e993765c1bso3273536fac.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698684903; x=1699289703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kNcuVwFyki0iDwY7uJq9KgzuQAivof0qRQNiBwvultY=;
 b=ucOrhe4itCbOCQ8agMVegJm8e5PGOPzqIUBnSB/7SWmDBQNmHu7yeS82FN8ZrQB+N4
 dd3ah4jzX1y8vX8p4vxfVsp6zM1u82PZVtkXAlc4L9qeWjiVWYgCnlpiHzNaoe+WbXPA
 9tOHHVQobMl1Ybd9uAKLldQvoBgN0CPemY5zO9mvCnSPXv/LdiZdcT1kkNC5m4X2Oxtl
 VVp9GlGLcmV9TFzpcJGotLHzZVeHjUDV8X4bvjAVTWFDrBxdwkxOTuJh7fHPGyfgXw8l
 B+H+Xm1BpiQBPkT4J8hPkhr1p1ArDGY1pjJfX5hry99tp0uB4Up6EYmbuGErYJzUjE1C
 CkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698684903; x=1699289703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNcuVwFyki0iDwY7uJq9KgzuQAivof0qRQNiBwvultY=;
 b=ORyzuOaYd/jEfCCnOnpa8DG/klDK7rl1LEFc9xnxyRBz+2q0pUNe+/Kqqw+fGVLM7U
 dSt3VH7dEHp3EMkn9hY+S+VvK9aHCS8DJSvc5lYXvy2H+galNdKDws9KSDwVlWZclZdG
 ipAzwsCzfl1STfnCAysns7l+qZ8Ll9pdrnfW0axZsIKeXkQWT2Y1/WZmzp+RioyYhMFU
 GLX4b6gkVcdV0b03ZsNXqIgKK66DeQqczEkXJpD0viagYYHXM9t/4iUUT+qoaeYl0xCo
 Z2fEUm6446sp+8YeOhPb7b8tKreV+UVYEVikavxokVbyVLBHLll304N3iantgiYqUciP
 CjZQ==
X-Gm-Message-State: AOJu0YwcUHjw299igeTYNx78WjT8iAfjPsUSP2PU/vgq6yUCdlaNc5OG
 GiTxB8WbBbNvbd7sylwOz28McQ==
X-Google-Smtp-Source: AGHT+IGrTFemvvbPKEajFgcKCMrTuT19eumiYVbre9vYlDUf2/QlNpnoLxdjdV/mkwcN0ufsVaQbbQ==
X-Received: by 2002:a05:6871:6b15:b0:1ef:c07e:b54c with SMTP id
 zg21-20020a0568716b1500b001efc07eb54cmr4818524oab.57.1698684903083; 
 Mon, 30 Oct 2023 09:55:03 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 lb24-20020a05687c331800b001ef38a85f9bsm1636969oac.16.2023.10.30.09.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:55:02 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] exynos: Avoid duplicate reset_cpu with SYSRESET enabled
Date: Mon, 30 Oct 2023 11:55:02 -0500
Message-Id: <20231030165502.27813-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The sysreset uclass unconditionally provides a definition of the
reset_cpu() function. So does the exynos soc code. Fix the build with
SYSRESET enabled by omitting the function from the soc code in that
case. The code still needs to be kept around for use in SPL.

This commit was inspired by commit 6e19dc84c14b ("sunxi: Avoid duplicate
reset_cpu with SYSRESET enabled").

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/soc.c b/arch/arm/mach-exynos/soc.c
index 6fe61cf9288d..aff2b5e1b6e8 100644
--- a/arch/arm/mach-exynos/soc.c
+++ b/arch/arm/mach-exynos/soc.c
@@ -21,12 +21,14 @@ extern void _main(void);
 void *secondary_boot_addr = (void *)_main;
 #endif /* CONFIG_TARGET_ESPRESSO7420 */
 
+#if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
 #ifdef CONFIG_CPU_V7A
 	writel(0x1, samsung_get_base_swreset());
 #endif
 }
+#endif
 
 #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
 void enable_caches(void)
-- 
2.39.2

