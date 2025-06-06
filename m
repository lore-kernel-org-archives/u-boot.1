Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E2DC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8111B82A8D;
	Fri,  6 Jun 2025 08:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eQdfLPJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B73182977; Fri,  6 Jun 2025 08:42:27 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70838807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso16154955e9.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192145; x=1749796945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYi6B8XbvaXoTC2nr5gEQHtipxuPsWt8g4Y9tMLOqxY=;
 b=eQdfLPJNZM4az5j7UWREZp2vwoZBy/ysiyNJR/Ei12g8o+GuvIifpWCV9X9jAkyj7Z
 p4RQtwHQXEdeF5ckE3f8D6GiXMsOLQ59sDk2iCs1o0QhngrdusMc8eygK73Z9bzO+72O
 DqB32wefh+6OZe8k7j13bh6ToEkcZRb35sY5d87gyZjVjpjZBdT2BSSj2+Avgkwmxrub
 nHn/dy0Qx7pvHTEciUbhD9VAyEHiM94hXbypOIpuZlBhWdRp24ajvW+NHAbH8wa5CSNd
 o1u1riZfEQ+Ik76EFj+DKjUPW0Z99cbQrKvewT9oSHpXe7bAqOX1AlETfHt7RGrjX5bW
 jUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192145; x=1749796945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYi6B8XbvaXoTC2nr5gEQHtipxuPsWt8g4Y9tMLOqxY=;
 b=SzQqt7enj7zwKXEqlPeEC0xp5XhCJ9F0h0SvB1t1CD0m2FAvZnTL2XD4GT1t61TUS/
 0rzPwuBugSy2x29VImPv5cwj/0hQLB6NIEQ/fr8reudE+c4GyDZ9g5VQ9jvECJK63Cdi
 X0LZFyg/J/otHE2FYmTde57YdUEhWgWJBWD8R5viTF04qSVYfPsA3Mqjvs85qAb/eHhj
 rHGoIGXD+k/ooCOIb3JOl0CfMS8QbD7AXiCuqQVy2xEbhO/2Rw7Z1yYK55Ia2eNGJuYd
 Zskmx01lvA22xHF502IFdjs1Ikv5AOjJ0L67sFqtSz5mXBWODgN8z4aMOKOThFBPdL9+
 w8nw==
X-Gm-Message-State: AOJu0YyYmXTcP0oyyoFuudtgACXBq47Ej7vti6cNj5CsRjk/q3tGXuM7
 enKvjiEklWyg4ia6HcoQu7UCP8EL6Zgg01GaMyg0/dAcw9LWpQcTg73yZmaQDWiMVeW5be9j34k
 6g0ju
X-Gm-Gg: ASbGncv+lPV2WSa+PjHmtieBuRngXxnPsWDaoErfzvcy3ccd34v3xOf483c3PEStKCe
 X1h5UrGNUB8qGvZab22dwDoOZk5fiEjprlF0cHfFhtcJqo7qvr1hsVt49d6qumoZ4KntP1Gr4J1
 KgV1/F2MZCSdcxvrS9DvDx/9AkiF6vDFRqv3paCE09Inz/V10UiPyVE0EJCQfttVsHLaIN2DGk1
 N+WCB3cPX06rX7j8l9vb3DjRHokoesGsoh9vPaCTB1GrjCE6JEOT+IbIVR/RBIsCntzrhkm3ke8
 /UctNjNpEwULPcC4g/p/1bASI7AC0vJSgFnFMa2wn/bSzwYr8yf4+Y4UgQ2FhNRG+OKHmzE=
X-Google-Smtp-Source: AGHT+IGqw0vZuqBHEs0HtC/iOvDftwIOs5c1ORhcpJLsahLkXEoEHWTkqCEZslxLYuUjeAav0H412Q==
X-Received: by 2002:a05:6000:4023:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3a531ab7294mr1498600f8f.47.1749192144659; 
 Thu, 05 Jun 2025 23:42:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/13] lwip: remove net/lwip/eth_internal.h
Date: Fri,  6 Jun 2025 08:41:37 +0200
Message-ID: <20250606064211.3091237-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

net/lwip/eth_internal.h is not used. Remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 net/lwip/eth_internal.h | 35 -----------------------------------
 1 file changed, 35 deletions(-)
 delete mode 100644 net/lwip/eth_internal.h

diff --git a/net/lwip/eth_internal.h b/net/lwip/eth_internal.h
deleted file mode 100644
index 87561d5b214..00000000000
--- a/net/lwip/eth_internal.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2001-2015
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- * Joe Hershberger, National Instruments
- */
-
-#ifndef __ETH_INTERNAL_H
-#define __ETH_INTERNAL_H
-
-/* Do init that is common to driver model and legacy networking */
-void eth_common_init(void);
-
-/**
- * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
- *
- * This sets up an environment variable with the given MAC address (@enetaddr).
- * The environment variable to be set is defined by <@base_name><@index>addr.
- * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
- * eth1addr, etc.
- *
- * @base_name:	Base name for variable, typically "eth"
- * @index:	Index of interface being updated (>=0)
- * @enetaddr:	Pointer to MAC address to put into the variable
- * Return: 0 if OK, other value on error
- */
-int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				  uchar *enetaddr);
-
-int eth_mac_skip(int index);
-void eth_current_changed(void);
-void eth_set_dev(struct udevice *dev);
-void eth_set_current_to_next(void);
-
-#endif
-- 
2.43.0

