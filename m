Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47272F9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7EB5842FD;
	Wed, 22 Apr 2026 16:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="srWsNk1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB9C83F14; Wed, 22 Apr 2026 16:31:55 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B54C842FD
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50d75bfb259so40594341cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868306; x=1777473106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thZ55Hr7rwH2XmmDH2OsEEm1NiF3NL035rQAbGYmDU0=;
 b=srWsNk1y+4IkwV8l32S3tkEnRWtAUV2JNms9u4Dj6RuUPtmlIJOzwWOZTk/Jw23oq0
 P4Le5naHP4qOKziYuqr3DkFEOnstiTGok8lGdqYs7LnGF1g4q76bwV3wPP9hhIj9Nn3S
 IowCmbrO4q9Az0AqT4Cu+YbdnSg1KPKVlUpibOqx5C4NGuQ2jFRLnq7fIYuPhozmaVnL
 TaeYz/OzcTYjlEJTdPwA67aXdvgO6SrkUQnsSXLjAIIgpG+hhygHB5rGMPQMgBHNMsod
 jdXO9b8zTlQfZ4h+elW//qpy2l5ayNVUW0lYC38A5VeZFnJByG+p6zS4BIJWOhmMrptH
 vHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868306; x=1777473106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thZ55Hr7rwH2XmmDH2OsEEm1NiF3NL035rQAbGYmDU0=;
 b=P7S8mLNJRavRRrRTCf+K/+440Pn40M9myYiYY2b+48Q5I1FyzlRQIoHoxdMk10q7qc
 5ovTT7Z3aYUfDF6A4gYqlENthO284xM4ZBDE4AuDIkGXYhWk0AJPRzivR262OW6QVOmN
 R53Ecs1cNCj/xa+eJ2I9oX1zDn2Bp9Fy/k3EAZRCjOuIrEdya15X0ZBZSQkXAtRjvLj8
 rofrTmshnT9Qf69E9sDSfaDsoPBa+3eoj5bNp63IeljwtwtrCdiaye7IfFsfKlzPQs5d
 2vFb7Y5V+GxNDKYin5FxmHQvJWlBjtTS2e5+SDXUbUv9LudFbTERarq/BabR6lYXXCB7
 0dkA==
X-Gm-Message-State: AOJu0YzbW4R3V9khJVzzBy4OWMUytUKwyRv8puU9Y3KEjw6jN1V5FVJg
 3gxiXH43g46uf9rMjSvD6GUnI2D9nva7Y8amg4oghnxYOtIr8A3I9R/vu5wxekto098=
X-Gm-Gg: AeBDievgo14lJBvhixtGLi/9klwBNX6750hWKEfzC7rHk/Nyfh/C5OPdKoQjkCqsa1N
 U7PzrDX6w7MfhruWmavfF1vRrmWO+dyVpeKKOz/ZRaAnBe+wV24ET0dYs+/oL/czj9COOZ0sc8M
 pQ14gH3REimSHvje5thqdUVZpTfJctzcd+AOxGFJEC22MtwloMIH57S9GSvA7PUsJPgEa+djL9/
 g93kCSI9Sp8ijJPAaSSZkCrsQ3okplW7v6YwOZVtvip8qiSlksUxsWDUxjLGNbr/LDhvuSmVn2A
 usBDzgZKocPxmgGqRCwHSY3hLehKaqLdtgGftaHxgzHQe6GPQ35X6MAidY1Yx23mlUnDV2ArDbp
 RY1kFwhBhpk/4khwNT8KjFQ07yGy4Hm0NXtG0E9VWys1V43ILyKBYZtI2kvqoX8I2JC4shzLyRX
 4jUOL1XtQtFyQ/byo1IqkCvMxLjhDCdFwAhhU5csk3lWWMbJIgP4hefvJJ/h2DaoNovsOyijBf8
 fDcKcz1R9JPnO5to2k5Hw==
X-Received: by 2002:a05:622a:2446:b0:50f:ade2:2da with SMTP id
 d75a77b69052e-50fade20ae2mr142241581cf.44.1776868305967; 
 Wed, 22 Apr 2026 07:31:45 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:45 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 06/16] configs: k1: enable pinctrl and gpio
Date: Wed, 22 Apr 2026 10:31:02 -0400
Message-Id: <20260422143112.1329478-7-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable pinctrl and gpio configurations for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/MAINTAINERS | 2 ++
 configs/spacemit_k1_defconfig | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 408621ab819..6a2c4c23f9f 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -6,6 +6,8 @@ S:	Maintained
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
+F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/pinctrl/spacemit/pinctrl-k1.c
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 16754ea98d3..29a3c71f19e 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -31,7 +31,11 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_GPIO=y
+CONFIG_DM_GPIO=y
+CONFIG_CMD_GPIO=y
+CONFIG_SPACEMIT_GPIO=y
 CONFIG_RESET_SPACEMIT_K1=y
 CONFIG_SPL_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
-- 
2.25.1

