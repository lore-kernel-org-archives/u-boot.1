Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35834CDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C57288FFA;
	Fri, 27 Sep 2024 00:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RtabYtQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35D088FF2; Fri, 27 Sep 2024 00:44:11 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1AE88FAF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45830ff5b70so10635121cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390648; x=1727995448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WTtypEXGFUjEe7ROUITMr9yvlbCyhj+jMFUh3qfaaw=;
 b=RtabYtQLNDuRe52Tq1LGB8d5p/3eDP1VTgwiliCcSMgSBrizic2uEEPZvNcfO0QZeJ
 ArOtKV5+a/MVf/MKTcCwyTVnLObWFdwT3qf85ayHjV67UlQXLC3vaOG2xWaB6XglFnnW
 iCpZDnCfdA4UZEPkn/SNUtLdxOxmmd78NtT4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390648; x=1727995448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WTtypEXGFUjEe7ROUITMr9yvlbCyhj+jMFUh3qfaaw=;
 b=vuMUvgtXLE3Rcq1eP7NcJDbjlmyFMBqKvhEstx/DfKlMNpC1ecQdC0HHz5Qa8YK2JN
 nkWM3M5CGz2JMspfQeOTZiC1rTB72MqZ+tJajuBMP5FUl59kiMFS4nBn27twUnyp51aX
 KcroNhGWz0qXpyHG+mBxo5D8o5awyfIVRH3IysXInki/Rm7lMO6Xu/7l6B7ZcWViC6Cf
 EW+1V9Zi8YhR1YYs/5bCF3s05c10mkh6naVbyn5udrMNvdYZTZUj9T7i74UNI89tv63i
 wbvzGNVIN0Pr+sKDKdM30RXy3X//WcMRvA1ieJgNp1Te6oy5mudbnehqvKqL0VwhdkOj
 8p9g==
X-Gm-Message-State: AOJu0YwH5d/pWFiZZGmiKsEtKuKK4sfpD/ebCJUPQZsvz4qyCgSgkGny
 v+sPIRRgXIJMAetOvDvu/dpREf68HmKjo3R1Xwbn+lznEe8RxSnIyhR7ssg4ygFTeIc87QyhsXk
 nzCJXBOc=
X-Google-Smtp-Source: AGHT+IEftnYW0aWtvvtewHXKkz1JXO6LcfwDMxgxSfXTlGMpQVB8YiD+ZNrbPqPP0HWE2AAzHoPP0Q==
X-Received: by 2002:a05:622a:490:b0:458:2ce2:269 with SMTP id
 d75a77b69052e-45c9f2a2638mr16655731cf.40.1727390648312; 
 Thu, 26 Sep 2024 15:44:08 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:44:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 28/42] drivers: Simplify Makefile condition
Date: Fri, 27 Sep 2024 00:35:53 +0200
Message-ID: <20240926223814.1276764-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

If TPL is enabled, XPL must be, so drop the redundant check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/bus/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index e14cb7fd9c7..b7e6452c48c 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the bus drivers.
 #
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-$(CONFIG_TI_PWMSS)	+= ti-pwmss.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS) += uniphier-system-bus.o
 endif
-- 
2.43.0

