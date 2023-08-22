Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F5EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 07:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C388641A;
	Tue, 22 Aug 2023 09:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1PbW/Ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405CE86416; Tue, 22 Aug 2023 09:51:25 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9938641A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 09:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso20243695ad.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692690680; x=1693295480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+dqmZ9rDMBUi8pPdP0xXZ6665T9Du0SEQ0l6cJLlHg=;
 b=L1PbW/FfDW/J+nZM810ccKjTpoqUuiQFQOrt5LAdDUfsYEKqv8zywmByiuK/SljA5N
 chJYfEF1lfwo5r3b3pOLV0EocDQHcsHTw2dcAImTFxAlJYQuxO8IanKDhIU+hDltg8xx
 6NfrNY5tKi1RwcbaeJPPkuLIZeORfeLeJQT7TYxzJ8BWBkAYCuIg0uAISznkaTLVGFi5
 e7HKaiueFeNY+HcecNaPuZ/gU/clZNBWHNiVxhxXHu+7nu7NoSVoFaJU2H1O+aMQfTtE
 qP2ZqD/78ZV9oKueOcqW0qKzLbo30Kc6jKdKXJLN6w6BpPnGKUvzKEHkZ708O8qFbfqp
 6YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692690680; x=1693295480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+dqmZ9rDMBUi8pPdP0xXZ6665T9Du0SEQ0l6cJLlHg=;
 b=DpZWuDQYhNWmWXXJkYxbOmOYqbBGcpD4ZVNCep/6BApzLmbEu1H30X0w8GLVYkBoJn
 ZtQBrEF9UitTckm27m9MPGldVeWSf4MRUXxoiW+tE9l80m2SUOmIbs5me2a+mKkaBBp7
 4K1FPfkpPbD0RtkZzjAcyKLIXYY9WbReW2AiGGrDFMA8kuXVvFGJ0wFBXh/2kUuWbySX
 W6GqePEF0kGQQwis0aNbLpDw9SvKUSK9D5m+2NCBmWdGI42Yvvh7h8RLZqembqNebqrk
 wCi3YInmOh01Kp/0MDtxlDG2kDdYGF05yXmK9rGN4e+qAbMJYP2xmt0Ow7rcVKDPAI72
 XONw==
X-Gm-Message-State: AOJu0Yyk03JnxU2uUSzI3EsncAKFaEzcIrbZM5HeW7pK3/7XJmA0CgRc
 Y8dzYJsPxXrlu1S/9FI+n+2rONGHsGUlf3/8WqM=
X-Google-Smtp-Source: AGHT+IHq55cLWJ3mNtg/KGqiRfNxoOeFoSqaQMejXyZ+0Mh6BDMiStWd9s6LhdmEolQ027zkbq0lqA==
X-Received: by 2002:a17:902:70cc:b0:1bc:9c70:b955 with SMTP id
 l12-20020a17090270cc00b001bc9c70b955mr6195586plt.28.1692690680188; 
 Tue, 22 Aug 2023 00:51:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bb8895848bsm8422199plb.71.2023.08.22.00.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 00:51:19 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/2] Disable setting ICACHE and DCACHE off for ARM64
 platforms
Date: Tue, 22 Aug 2023 13:21:10 +0530
Message-Id: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

As suggested by Tom, disable setting ICACHE and DCACHE off for ARM64
platforms. It is also noticed that with CACHEs off u-boot on ARM64 (ARMv8)
boots slower.

If some platforms still wish to turn off ICACHE / DCACHE during the
SPL stage, support that configuration as well.

While at it, also fix an compilation issue for stm32mp when 
SYS_DCACHE_OFF and/or SYS_DCACHE_SYS are enabled.

Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>

Bhupesh Sharma (2):
  arm: stm32mp: Really fix compilation issue when SYS_DCACHE_OFF and/or
    SYS_DCACHE_SYS are enabled
  armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF for ARM64

 arch/arm/Kconfig            | 2 ++
 arch/arm/cpu/armv8/Makefile | 4 ++--
 arch/arm/mach-stm32mp/cpu.c | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.38.1

