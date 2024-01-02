Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ED7C47074
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9553087922;
	Tue,  2 Jan 2024 16:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEZ5ys07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED1587916; Tue,  2 Jan 2024 16:47:07 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FBD878F9
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-594bea92494so3382688eaf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210423; x=1704815223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXUyqvMBbSvRf5h0yFwfQJJ9bpGctCcbPKtGC3XkLqs=;
 b=kEZ5ys07CkSoKCmBW3zc/Eu99k0yVG5v9CWL/sHPjWtFtk/3D8JyFpO9bB7SKz8eXA
 N3qRceRbgWb05cYYfd5u16r/ByDRK+6AACXksQvgzQ8ycDd8WJjks401IlkXte90AyQF
 UNSLRKt0bn5iYaia9DkVXTBUxsQLUUYF7CXsUsKKklnmVw2CToHctczBNV7J/zQm5uhP
 3pqaqAWmTaohz3jz8cxJVWoJsz+cuJmHho86cLUJu/hC9ABCGAshWlce2sWIH189z4mQ
 O3RabBU8GogdXQ8iYQFeqBMFW1k96fDI6wat1Dt5xb7F98f5gq9XB9GiCRTp2p7mgVWk
 jdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210423; x=1704815223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXUyqvMBbSvRf5h0yFwfQJJ9bpGctCcbPKtGC3XkLqs=;
 b=JYvq7LXpkgtmHDj2xYLjbVtSmsjdQn4ksDEw7GF6p+0PzZgCjm0qlXsh+eTUE6j43f
 yJfOl39PwDXwFkXKIyRdk09D1p0izNZpFlbSOeotoOAChdmD1ED/I92wq6sqYymrj0BI
 hAf1x/NuCFkIZpWt+3t6Xoa50tPRA1DGNZzM7WMA3p3Ki/lCY2hmW4LWm2OCivNBQVbD
 RE+CYEikqqesahQifuMVZxn2CVXd0amEOh5zQ69SdZZrDCxxYafpmX1X/WMkARvzKnwD
 XW7HjrCQd684ppaMQpQizhIPf0rHvr8Y4j3m4mP+SyFskCdZfGajNiXFUCuuKcC9eGWx
 J/4Q==
X-Gm-Message-State: AOJu0YxGq6HCcouHXSBo7q15OICcYMZAdfpiQJGZM5Pd5qxJOOdjVEWH
 EFHPHxvoVJqAXJ00J02mkVYTKCZyOMvhDw==
X-Google-Smtp-Source: AGHT+IHnduA91YWgtvlV+z1mdX/AWf15qEAuZcedWvjO63k58eA7Y2OS9DV+wIpuYxSlhYbZjPv92A==
X-Received: by 2002:a05:6820:230d:b0:58d:9b89:a844 with SMTP id
 cn13-20020a056820230d00b0058d9b89a844mr8220006oob.7.1704210423262; 
 Tue, 02 Jan 2024 07:47:03 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:02 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 2/7] spl: Add Kconfig options for ADC
Date: Tue,  2 Jan 2024 09:46:49 -0600
Message-Id: <20240102154654.191055-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add kconfig options to enable ADC in SPL

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 common/spl/Kconfig   | 7 +++++++
 drivers/Makefile     | 1 +
 drivers/adc/Makefile | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c521b02f4a..ada9dcea5c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -579,6 +579,13 @@ config SPL_FIT_IMAGE_TINY
 	  ensure this information is available to the next image
 	  invoked).
 
+config SPL_ADC
+	bool "Support ADC drivers"
+	help
+	  Enable ADC drivers in SPL. These drivers can allow the reading of
+	  analog values from one or more channels. Enable this option to
+	  build the drivers in drivers/adc as part of an SPL build.
+
 config SPL_CACHE
 	bool "Support CACHE drivers"
 	help
diff --git a/drivers/Makefile b/drivers/Makefile
index bf73b7718c..81ba2c534e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+obj-$(CONFIG_$(SPL_)ADC) += adc/
 obj-$(CONFIG_$(SPL_TPL_)BIOSEMU) += bios_emulator/
 obj-$(CONFIG_$(SPL_TPL_)BLK) += block/
 obj-$(CONFIG_$(SPL_TPL_)BOOTCOUNT_LIMIT) += bootcount/
diff --git a/drivers/adc/Makefile b/drivers/adc/Makefile
index 5336c82097..9eb07769b0 100644
--- a/drivers/adc/Makefile
+++ b/drivers/adc/Makefile
@@ -4,7 +4,7 @@
 # Przemyslaw Marczak <p.marczak@samsung.com>
 #
 
-obj-$(CONFIG_ADC) += adc-uclass.o
+obj-$(CONFIG_$(SPL_)ADC) += adc-uclass.o
 obj-$(CONFIG_ADC_EXYNOS) += exynos-adc.o
 obj-$(CONFIG_ADC_SANDBOX) += sandbox.o
 obj-$(CONFIG_SARADC_ROCKCHIP) += rockchip-saradc.o
-- 
2.34.1

