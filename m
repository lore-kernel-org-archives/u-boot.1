Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BED8CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD69088E58;
	Thu, 26 Sep 2024 22:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GukU0nfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6277888E46; Thu, 26 Sep 2024 22:53:28 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC0A88E66
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so5844676d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384005; x=1727988805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQ2LBSL3qpXyuL8zC7aN5SvgjJSMQ9nubSHU0OHexdY=;
 b=GukU0nfnPWgRpjvbYMB4sd9cHTL9wN27iBcbBHotZRcDRwffSmB2PRx+H7cF7j1oq6
 ff/vi6thdMHaZp+w232w47Zd8FlPDTK+o+zXvCa3nkgntNl8VYaqpYtdbZjdRKs1xyaq
 T8Euhl6MCBssUbf6PVNq7RA02ya24+jok8eR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384005; x=1727988805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQ2LBSL3qpXyuL8zC7aN5SvgjJSMQ9nubSHU0OHexdY=;
 b=bJF3FZSd283u9jHiMsokcypAXDvJhHuvg181kxZrHzi5+rDHdQ1EBCg2xK65MdKpi7
 9nuWF3Kh+tjIVOYFMzKvc7VN0Ytb2MM3XIEmq1A7ujNHsML7u7+wreAN2g8oB2FkQN8d
 FZ650470C/5CHBcqg1n9XPjarKz2LsqBx/AwkWaz6vLCXFknaH8g4O9ucHPNYx8js+qA
 XoZbzjfdztQvrTuBBUTUSY+CP+2HgKEv3abY6mqqos2WeczkVnXy9cbyL5e9YfGDYUxD
 4j1GMAugj/0rcDbQU9HqiNYqjpmjfiFYyDTePvlxMCP4n4yhKi5BugoM1mwrhP1tTHE3
 IkhQ==
X-Gm-Message-State: AOJu0YyO4ItyrAq50IWCC5SgR3OBl2OTY/BFEoGHAAdYlC7v7fneNxn6
 YS4enHPjprZhHtEMeXv7ugmpMYH4lJ7TsXcrejN4Ve7i5FjtahtAaChyylc7f47sspZ5e700OT0
 HhL8L1vk=
X-Google-Smtp-Source: AGHT+IErxyvXHuUcbv4TbH2FyGMNWhQFqhlK0qV7QLN3j71OU3xR9eTksXFSiSTK0jRmP68GDyRRIQ==
X-Received: by 2002:a05:6214:5a0b:b0:6bf:8d11:b640 with SMTP id
 6a1803df08f44-6cb3b5db221mr10214266d6.19.1727384005165; 
 Thu, 26 Sep 2024 13:53:25 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:53:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 23/27] image: Drop unused status_led.h header file
Date: Thu, 26 Sep 2024 22:44:43 +0200
Message-ID: <20240926204455.963584-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index abac254e026..7bed8ba4b1f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -15,10 +15,6 @@
 #include <malloc.h>
 #include <u-boot/crc.h>
 
-#ifdef CONFIG_SHOW_BOOT_PROGRESS
-#include <status_led.h>
-#endif
-
 #if CONFIG_IS_ENABLED(FIT) || CONFIG_IS_ENABLED(OF_LIBFDT)
 #include <linux/libfdt.h>
 #include <fdt_support.h>
-- 
2.43.0

