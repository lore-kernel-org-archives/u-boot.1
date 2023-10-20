Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C6C0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 21:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F68787522;
	Fri, 20 Oct 2023 23:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yoZfNZnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277468752A; Fri, 20 Oct 2023 23:46:44 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20F58751F
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 23:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso891343fac.3
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697838394; x=1698443194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPoBYuV9+bIOB/TtPPbevJ97OKA2iDpkfB97P9qpt3w=;
 b=yoZfNZnvgoH4SDrIey8gVag1/vTw7S9JglLsYcX2rl7oxgCWIESW1SoIcK3svo6SUE
 59rtTfDRVZ/aFCWJJ0L+nlI/U+VmvG8DYnDbB2Cx6yWmXjoCyItAD4dFjwxDH4PSLdGv
 lj0rCswKgt0BXcHr8y30DhxnCpA/Yx4UcPRbhXxZjVL/GVbFr6TslnJYvHAJUrLurdVt
 6BQzw3MGcgzP6F/Ffh5hBZO3DsAejF+8yX63Y7C5Qs2gcBCDPcHxHi1oW55LS/vtQQ6c
 VdhKVhT4vzK8JywgsZvfdjryYJzefK6YBmxrRSlf0jqIqCh5wLCah5pWfwGjW6jfgITk
 ZGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697838394; x=1698443194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPoBYuV9+bIOB/TtPPbevJ97OKA2iDpkfB97P9qpt3w=;
 b=vudP8/QbocyYfqp1WIWVCIg2b/bQYXngaYlX1CqU8cuxZxcS63V7GZlgRK4QKwwZ2Z
 nNcMeMOwfjDaf2OQ0pijlsfVub1f61Q6YU+52hvTDL4pkYvS02dU6geNuIzjM+Y8hzDq
 756mbnTeisQMnw2rm+eFEHGE/lI40BSrL2V1G00arEIbr5wRXaYOg5VXfMhAXhkD+Q6a
 tTfrWImAaJ6MyQjGKdHqWeDEaci1EXUwayxOoBlcRIV0CzUYWtFSgY0zcek1X/aO7Q4+
 FFpRsB106vdo5XoUW70B+7Ke2QaROlNjbEeD0mHBHUniBVIWirqiN1oEMwtIezIVgSmq
 +WoQ==
X-Gm-Message-State: AOJu0Yzq/Z56Jwo6CMYQXd2PH9TL5qbvyL82OVNh+y2xjPPFr9rvC/9A
 5TRdPly3L5ymxoHK2iM/t5iYZg==
X-Google-Smtp-Source: AGHT+IHtVp+wkHMV6MKlI7P2IlKHeqdeAGpNhUUS27UOmhzKsx34bp1kJx9N+73bETkWPw/gQ8HEug==
X-Received: by 2002:a05:6870:3d99:b0:1e9:de2c:3bd with SMTP id
 lm25-20020a0568703d9900b001e9de2c03bdmr3969777oab.30.1697838394485; 
 Fri, 20 Oct 2023 14:46:34 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 g15-20020a056830160f00b006b9cc67386fsm465938otr.66.2023.10.20.14.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 14:46:34 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/3] arm: exynos: Include missing CPU header in soc.c
Date: Fri, 20 Oct 2023 16:46:31 -0500
Message-Id: <20231020214633.30883-2-semen.protsenko@linaro.org>
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

samsung_get_base_swreset() is called in soc.c, but corresponding header
with its prototype is not included. Fix this to avoid possible build
errors.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/soc.c b/arch/arm/mach-exynos/soc.c
index a07c87a2c8e2..6fe61cf9288d 100644
--- a/arch/arm/mach-exynos/soc.c
+++ b/arch/arm/mach-exynos/soc.c
@@ -9,6 +9,7 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/arch/cpu.h>
 
 #ifdef CONFIG_TARGET_ESPRESSO7420
 /*
-- 
2.39.2

