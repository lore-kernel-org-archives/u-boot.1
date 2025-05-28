Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB03C54ED1
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 00:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E53831A1;
	Wed, 28 May 2025 02:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V5e6K+lB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A124C831C8; Wed, 28 May 2025 02:01:24 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DE88318E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c09f8369cso1154989a34.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748390480; x=1748995280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1mxgSJS6GJAVBdx+EL+tgzgdjBt8pscJLi11S9Uu72k=;
 b=V5e6K+lBZQ538maEu+DNrPs5Gl47wMdnvQRtfO08CoABSqtcZvXBUNdhwRzD015jtv
 R6ar/4UJtv88zUc32pN525bNkK/F2mqR5XJjHS4n5BvsfjSAoQu2eYVHJ5z5qa8d8bX0
 yPI0xkg3W358iZVxHtPWNvX92UbX6vPxZCbRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748390480; x=1748995280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1mxgSJS6GJAVBdx+EL+tgzgdjBt8pscJLi11S9Uu72k=;
 b=trDuOBLjf1ZLtyVb5t+i4tCtW1XAW4dG9CWK0Ej/hx70XfKfsogUKdhLSTxytyUqsP
 sFyM613kyxEWOXWFUUBv9cV4esPcSmMqztTa5nKFouASUiR2EHYkLnXd0ZaswNne4IQv
 YBbQAXJKtjJIu4oKMZvdpp6j5wCdX4jFCsmfhxSoCJP3RUysIIs47I9zT4Xf4w4oXtmC
 /flB2TcXLfP+jP0caPXZo5UpInqQm52KTEpKlmkjngqMSqoOUKRbk+rA13DwRHQLXkKP
 UZL1LszeoGcof0diKr1LPr98ap50ftK9wC7JXVvBOU4EvjA/ozFMUl/vP2HiKSex76oy
 I5Ug==
X-Gm-Message-State: AOJu0YzEKhqEuXAo/m8RXxlq5CQ7LTGyjMxAyHOZuGGDKm12el4AGRd0
 J8H+/7Cv+0haGWqLExm6yQZ6X+8O9LzdF1jxDD9tXGhxszVLaI58vVkCdt/kEYMxoh04TgkGT5b
 xGXIodsY=
X-Gm-Gg: ASbGnctIetUXGUxuBjd2YzQ0WskABYx9GtasMZoLcrFvVm6Zyf14LV0DiEK2keeBX8Q
 ezrEGE/DJJPoCzUa+9SVYc1S50pbXneHZFwBwEoqXiLAyIPlH3dDN8kxp4i6lDROPKEni2tA2Ht
 MZRMJbcnFjjcV5SId2qZe2ImjPBR2LKkSxd6aQVqGr9LRaiqKIcwJrj2gf8z6dsPi6GQP/ufhuf
 GvGR0tNcgtxXKMddhB/5g2wXMusc4LS11KUW2FJ35whvg9ClFwbSjjPxRJHymdy8qBlHNqus2FT
 05Pop4yrejgfmgba8zBL8Uwc8SsXqIKodXBMQBLRPF4ej/tc+E5YFDsOfGXyDu/v5r0JP/3vnMM
 QFT6gOVS9wJ+v96A=
X-Google-Smtp-Source: AGHT+IFSgH6FqjigIdD/gB91/lPewyY6kFUkVtCpYS2FGxjcKSgMHnwqAd/auA+XwRp+NXrgGclseQ==
X-Received: by 2002:a05:6808:6f97:b0:404:ee1a:2057 with SMTP id
 5614622812f47-40646845fc8mr8079520b6e.29.1748390480482; 
 Tue, 27 May 2025 17:01:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e16bead3sm12299fac.10.2025.05.27.17.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 17:01:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] atmel: Remove local <dt-bindings/pinctrl/at91.h>
Date: Tue, 27 May 2025 18:01:18 -0600
Message-ID: <20250528000118.3002916-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We have this binding file in both include/dt-bindings/ and
dts/upstream/include/dt-bindings. These files are identical save for the
fact that we do not have commit adb2424d0d05 ("dt-bindings: clock: add
clock definitions for Ralink SoCs") from the kernel applied. However,
this change is rather important and should not have been omitted here
most likely. Remove our local copy to get in sync with upstream now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Mihai Sain <mihai.sain@microchip.com>

The full kernel commit log is at
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b3292852863215825f88905b9dbafc3101e1d7e
and so this sounds very important. Please let me know if this should go
in master for v2025.07 (or Eugen, please pick it and send a PR). Thanks!
---
 include/dt-bindings/pinctrl/at91.h | 49 ------------------------------
 1 file changed, 49 deletions(-)
 delete mode 100644 include/dt-bindings/pinctrl/at91.h

diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
deleted file mode 100644
index 3831f91fb3ba..000000000000
--- a/include/dt-bindings/pinctrl/at91.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This header provides constants for most at91 pinctrl bindings.
- *
- * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- */
-
-#ifndef __DT_BINDINGS_AT91_PINCTRL_H__
-#define __DT_BINDINGS_AT91_PINCTRL_H__
-
-#define AT91_PINCTRL_NONE		(0 << 0)
-#define AT91_PINCTRL_PULL_UP		(1 << 0)
-#define AT91_PINCTRL_MULTI_DRIVE	(1 << 1)
-#define AT91_PINCTRL_DEGLITCH		(1 << 2)
-#define AT91_PINCTRL_PULL_DOWN		(1 << 3)
-#define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
-#define AT91_PINCTRL_OUTPUT		(1 << 7)
-#define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
-#define AT91_PINCTRL_SLEWRATE		(1 << 9)
-#define AT91_PINCTRL_DEBOUNCE		(1 << 16)
-#define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
-
-#define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
-
-#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT		(0x0 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_LOW			(0x1 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
-
-#define AT91_PINCTRL_SLEWRATE_DIS	(0x0 << 9)
-#define AT91_PINCTRL_SLEWRATE_ENA	(0x1 << 9)
-
-#define AT91_PIOA	0
-#define AT91_PIOB	1
-#define AT91_PIOC	2
-#define AT91_PIOD	3
-#define AT91_PIOE	4
-
-#define AT91_PERIPH_GPIO	0
-#define AT91_PERIPH_A		1
-#define AT91_PERIPH_B		2
-#define AT91_PERIPH_C		3
-#define AT91_PERIPH_D		4
-
-#define ATMEL_PIO_DRVSTR_LO	1
-#define ATMEL_PIO_DRVSTR_ME	2
-#define ATMEL_PIO_DRVSTR_HI	3
-
-#endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.43.0

