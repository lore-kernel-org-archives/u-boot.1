Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C2C5478C
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 06:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200E88802E;
	Thu, 22 Feb 2024 07:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oAlo5zPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B7088051; Thu, 22 Feb 2024 07:48:12 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6E68803E
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41275f1b45aso10319675e9.3
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 22:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708584482; x=1709189282; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wp+o4Nz/nYqtKpCioaLTD8CsJQ6aK+axnusdZWEnDj8=;
 b=oAlo5zPvjM4Zx+RR7zZKRE47sDIUNvTWkRhqrxhxvkv0YREKnujhJp50a96Ujz/R8B
 BhpB5ru9ky5r14WNtTMN8jslZ/8/gys8gWfRHBfJGIbzBy5iyzMrBdoUMPEGzGcqn9Sm
 JNDNsExEWICS4zMMQRyoAQK75b9FCIVPl64vS0+FDfKKXgxU9npB4qqGOpOPAFP5t+qs
 dHK+SUMIlFpN0jQHQbxpOCoEQidKZtZ27kcExjp0oLQwUJUXhZEgqrlbwWUQFJw1gKMp
 TIpFKAv8kvaC+0+wlQoeOrxOyTm4KzuCfkPcMdkKVf+zEVApe0noaZcUAOWRcq1/milZ
 onQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708584482; x=1709189282;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wp+o4Nz/nYqtKpCioaLTD8CsJQ6aK+axnusdZWEnDj8=;
 b=rlb7gkvbpm/MNi5UrfOgn5mLagPqFhBziY6WvUXCqD0uneMXUmQX4fQ0mWEjmnST8c
 zKcbjLTFwvKMH5DY8KeuKIFZDZRnXzkEysifynmlzWLh9eJ42jcHcgmne7J8Rt5Iwcfd
 ke0Ev60/n70e5H8NipWNC9F4jQfqA8BV/4gXaChkzV4/F9QA+hvVvkeZACc8rkCoOiUV
 4Rm7cnEc6m7sVtE8iJDfUxWrqo4bLQLfCwUtNZVE2NRezPK4ypH3RyQrdd04gKY7MgMZ
 jAa3CavumDMMFQykAdWA7Ntbxi4cFDQbcAaRo8fwB/84+yNkv08Igi6kRY6QrFGJ/f/b
 i5Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP7Js1BYWDmucDZp/5Qz+BEpeqSK0i4RTZrrLduAYkZ858kdD5X2qVgtn/02u/hfx/lGrFTFZ9/ANN2iQ/CY/NjDhGQw==
X-Gm-Message-State: AOJu0YzGw/8eLyMDM4VzqpmLxkmZ/i8Pqm1vIM5B2M+iEJjfZqSOSq/o
 q7hZolgZYNyQpvmO0zD3TUTQCqNGbqHli8wQDAqifx5BmnwR3wDJMB1Bis4yW9E=
X-Google-Smtp-Source: AGHT+IFf1UjLEJnGTOdm88xLPr18SpqendBdw74aqxpJQgBYQ/ybENzyhoYoGafAf2qN0XR/tPDj1A==
X-Received: by 2002:a05:600c:3590:b0:412:6d65:abd5 with SMTP id
 p16-20020a05600c359000b004126d65abd5mr6515979wmq.10.1708584481981; 
 Wed, 21 Feb 2024 22:48:01 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05600c4e4600b0041276d96349sm4623455wmq.8.2024.02.21.22.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 22:48:01 -0800 (PST)
Date: Thu, 22 Feb 2024 09:47:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Sumit Garg <sumit.garg@linaro.org>,
 Fabio Estevam <festevam@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH] ARM: Enable CONFIG_64BIT for static analysis
Message-ID: <d156b6f6-429e-4c6c-b863-f8554480d74a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

In the Makefile there is a line that says this:

    # the checker needs the correct machine size
    CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

So set CONFIG_64BIT so that we don't pass -m32 to the static checker.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/arm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fde85dc0d537..4c7be7cf9c33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,11 +1,15 @@
 menu "ARM architecture"
 	depends on ARM
 
+config 64BIT
+	bool
+
 config SYS_ARCH
 	default "arm"
 
 config ARM64
 	bool
+	select 64BIT
 	select PHYS_64BIT
 	select SYS_CACHE_SHIFT_6
 	imply SPL_SEPARATE_BSS
-- 
2.43.0

