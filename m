Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DA1C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D959B82F4B;
	Wed, 25 Jun 2025 15:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p3/PSIYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E63782F46; Wed, 25 Jun 2025 15:21:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537F282DA1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so49313595e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857687; x=1751462487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/ySdy1n6AgDC7NIfoWPUsAgLrYrc7+o/jJcNrR0Sb4=;
 b=p3/PSIYcQ2aL0B54M1dDet3QOoAIvXJOftljQ1rjPGkGTy3V3YUsc6UQjdOG4J9R6B
 DxaVcjVoYCuI3BDmabXaOnGQXEqx/gDKAU7Q60XKACyYeS5ov+R4MbAFJdUX7qRDEsUO
 shLOA1IzPOtQXc59HRRI0Cnjr0T8fkim3hUvtOPXpAT3eFecvpnA+cd+n6UL5CPOIXeA
 3WKnu7e6ioqXyPkFc0WJyTmLZQTuXEp6gO/1/fO2QQr7i2pLrwqZY0j7Oi/p+Jcm6LJZ
 1XlBaN+MUucSvGoVUsqojyogJwk9e3kWkF2mKn2O+YiAhT6OTcfCn0bCUxPePFDtpIc1
 OC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857687; x=1751462487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/ySdy1n6AgDC7NIfoWPUsAgLrYrc7+o/jJcNrR0Sb4=;
 b=nlL74gwwVpPBo2YhGJRe6S/j6BCaNAue8ndYTqg2lqpD6259tSIhWSxDGrCGQKF+lV
 fb6OQ9pR7Igxg7gzmooL4Nf77/i06BzoFN5sl4AL+NruKRxqMt/buea1c0LOhHA40nmV
 IyzsgIuqiOqyUUdslkQODBLNr1J011T5x+uDD5UQBXXkk0VNjQob3QiA/h21V+/Hiidt
 E5cW5/5LytA3p5gQORv05Xohy3+Gt6q5Dhlbj2H5UItm7UgC3nLZSmtrhwVgUpnxdvlP
 bVeTHdm96F4vHPuOxrrLRDwYPlLvrWi6G5wHJXEmUcSPoPWFTIMJbmC2b+3T3m1gXDW9
 ZGoQ==
X-Gm-Message-State: AOJu0YwsA+TU9gLHK3Ynu/bTSiJ+0ZUNaxwnhLxEvvvrGQ7zUYYmvjfO
 Tp4bgc2JSlNlbx/clow4Ct8ukSjq0fGBTg0lTF4DRdlgdkEWVCBiieSHfhr0dknKXq+K/0RirsB
 u3+MWm1Q=
X-Gm-Gg: ASbGnctoxQA26gguA6lTukGdbrcynIeaQ+Ce7uGBD+6DcBesZDbGiUyS2r0irtmkbcm
 X7CDnotu+albTc84RzXCCykcp61I0IPHA/eBgw9VD3T3m8xhNBhm6TId0uCfgxxFsI7C5S2Ssg8
 /taNTvoK51S4eYGlO03/QRGcXwwI3uuNS3fAC2h84bHCL5e4t/eKIRWLNvJsVxiLwLwIAFoLFAi
 M/3sT1XOQimGnY7f2sFAZuUigmHHdqGlT0DGaiVmhJ8ltMnxRwjfAKbp90Wsl8BNqSyWoRkHIfF
 tUWzbK9ZYHK0w5FQJO261Hw4SpfsE1LytWw88BKOOONy3GDeg2jRg64xCqenaBawpcpHZbQ=
X-Google-Smtp-Source: AGHT+IE5YnRZNRo0phQ66DYgtrup/Jk3mbzvgA/Mw8Yr0So60gdEY/wz6EEl+UvVkEkenqzqzPEDxQ==
X-Received: by 2002:a05:6000:4b04:b0:3a6:e1bd:6102 with SMTP id
 ffacd0b85a97d-3a6ed6751fbmr2278748f8f.49.1750857687364; 
 Wed, 25 Jun 2025 06:21:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:26 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/13] lwip: remove net/lwip/eth_internal.h
Date: Wed, 25 Jun 2025 15:19:09 +0200
Message-ID: <20250625132108.3292932-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

(no changes since v2)

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

