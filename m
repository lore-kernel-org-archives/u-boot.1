Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEBEC4707C
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2FB87A82;
	Thu, 11 Jan 2024 04:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BNt/4ZqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0962287A7F; Thu, 11 Jan 2024 04:09:37 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA3B87B1E
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6de424cef01so469249a34.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942564; x=1705547364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCR2s6dv9TcN0rCDDRwOvshFyB9yr+laMEwcE42IykI=;
 b=BNt/4ZqLPWXxchOuDlTU8Cq2H5MeCQoymUktOo/HmnW9WUKCfg/HTjKv9kJPFH/5TN
 0iCCzbqUCGBioCetuQx9tpsj1ghfx5ABsV1sFlrr9FSkhD8mC4Uw2lb7M8JTShI5BRj2
 zcqsGFnfVo473RyZ/aOlXD1yRDo973MpzrUNij5uVsoi8x1friz83A0kK+xlu99QY+Mq
 bh6UDz1b43GG9w0+SW4OMaa3vFbAOIQSNQj6J5OUvzEHqh2hD0ZguZ8aIs24hmleyrE9
 ikBuoFVAYREXfNZDDI5IyrtdTlyzDD8b0+TajuSO8AdLjCzP31zgGyi+3gCoDIvxtbEu
 cchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942564; x=1705547364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCR2s6dv9TcN0rCDDRwOvshFyB9yr+laMEwcE42IykI=;
 b=MhvHMZ4DhWNBd+jy/vT9hR7kwlZV8JnV+Lgwl0Pt3dw2GWzyeKg2Oy0IKhbHeToR/9
 jzX7Nk1V1QZKtOb5lFYcxdhRkfHy9F/dZjrs/n3+eJNu9omIIpJmMZqyQL5ndT10f5AV
 AldjmeDJ+YpWltZ3baeh5u5VHciNMr7SoQs39+Jupb4B8+p4v6R8L1XSUPxNwHxEtAJt
 9heoRxaY1hPEmrDYaJc0GPifjK8aKZq9DvCgiE577aoJJzJcK+NgUWjzSCcJ5gVrGEAg
 KUz528z/d6k9qViZCPg+420t0ic76Oe5gQgZfTDqEnIYrRtaFwAUDXCdk9XVd++tr1lx
 fQUQ==
X-Gm-Message-State: AOJu0YzOz6LrlHVyhWe4f8aYF+YR/5hyGciqxkPilQYbHM4iCG0TGpWi
 EGaWbWVBw7pfY6kIi/cxRxayB6Elf6L9yw==
X-Google-Smtp-Source: AGHT+IGTQRwLJw6ZHCOmIsSBJrWhu7Lp7wz5iiCWYhgEblLWZwyK2AJSmpUdPVDREiJqI187IEAdDw==
X-Received: by 2002:a05:6830:144b:b0:6dc:5d73:d744 with SMTP id
 w11-20020a056830144b00b006dc5d73d744mr580071otp.23.1704942564418; 
 Wed, 10 Jan 2024 19:09:24 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 l23-20020a05683016d700b006dc8ce3b8b6sm2841otr.69.2024.01.10.19.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:24 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 13/13] MAINTAINERS: Add new Samsung subsystems
Date: Wed, 10 Jan 2024 21:09:09 -0600
Message-Id: <20240111030909.27373-14-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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

Add next Samsung subsystems with Sam Protsenko as a maintainer:

- Samsung CCF Clock Framework
- Exynos850 SoC Support
- Samsung SoC Drivers

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - (none)

 MAINTAINERS | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fec063a242f..33e96cd4231f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -563,6 +563,31 @@ F:	arch/arm/mach-exynos/
 F:	arch/arm/mach-s5pc1xx/
 F:	arch/arm/cpu/armv7/s5p-common/
 
+ARM SAMSUNG CLOCK
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	drivers/clk/exynos/clk-pll.c
+F:	drivers/clk/exynos/clk-pll.h
+F:	drivers/clk/exynos/clk.c
+F:	drivers/clk/exynos/clk.h
+
+ARM SAMSUNG EXYNOS850 SOC
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	arch/arm/dts/exynos850-pinctrl.dtsi
+F:	arch/arm/dts/exynos850.dtsi
+F:	doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
+F:	drivers/clk/exynos/clk-exynos850.c
+F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
+F:	include/dt-bindings/clock/exynos850.h
+
+ARM SAMSUNG SOC DRIVERS
+M:	Sam Protsenko <semen.protsenko@linaro.org>
+S:	Maintained
+F:	doc/device-tree-bindings/soc/samsung/*
+F:	drivers/soc/samsung/*
+F:	include/dt-bindings/soc/samsung,*.h
+
 ARM SANCLOUD
 M:	Paul Barker <paul.barker@sancloud.com>
 R:	Marc Murphy <marc.murphy@sancloud.com>
-- 
2.39.2

