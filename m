Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A38C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07FB877BC;
	Tue, 12 Dec 2023 00:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RCR0bExg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C4A877CD; Tue, 12 Dec 2023 00:21:45 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C0F8779D
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b9ef61b6b8so2671555b6e.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336893; x=1702941693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXUyqvMBbSvRf5h0yFwfQJJ9bpGctCcbPKtGC3XkLqs=;
 b=RCR0bExgHNZgDc0HMLcTksLByE41roF8TT0bDrAzDpccjnCCMV3v3FJWvoqKVPYjAv
 yr0CzGFRcY/pUB2ZVcLCucwQ/wU3W/T2qUGxmKhuKPudVYmOAkMDxGzsGOxAxtF1+lJ6
 HaGQA4m68qTIssZxIuwVS59rnei2bKLoGuh6twx32MlStWt5YKQ/EDD3vhYwNOqagxSu
 rqmfZhm6uU+L+oO+N/eF9eppKZyLGI+oILjig7mfVImv/Xbbf698EsNfgeYY+oDQFneT
 76hq8CGbs0B4afdxIIDxJZHgnOUS5oMb2KAEkD5el4EyuRFi4XIG87izlrpl/1wq4uQ6
 IjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336893; x=1702941693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXUyqvMBbSvRf5h0yFwfQJJ9bpGctCcbPKtGC3XkLqs=;
 b=AcD9hDVciHx4yxeM6TYPCsoNAsdC7mWGYinTdxOKJZ3gfgC95S+CyQ3VLgOUn6icUq
 QSE58RCaOnJhMZdkhT3cW3sguOpLoKnHhw/J+UNsf9RVqxiqlfOYkoWlyEAt6i5N08qh
 /mNl0e4OsThZ1/sLKXuoIjdJ1BalVK+Gb4ugsIxiI8V8wIuQAu2QtdLVBIH+yaszOyS+
 10i9blR6zp1flTvrRtVb1JcDWKT7TNZu4aTSuZm/jee2vPfy1j8lQiMyFeWJ6iLA67p/
 FLu1UQWd2riRZW0BooiNr/j4fetUvFvZ9Jb2Svq+rFRGNBBHFNcJ1DbCSmGwpRqg/GAN
 dHXg==
X-Gm-Message-State: AOJu0Yzb3ElgcPGUZWUoTL1H6hHgMWfx9UFvDo6S1f/t42NsIIgHl8aX
 MZ8lI6601cO/Foyq+83HVsFIkU6cexg=
X-Google-Smtp-Source: AGHT+IG7fsayHM9rdgI6UMdlQ1bgjjqLEbFFfFu4wG9Dr4sBZbbCHYKxe7CfcihBN7V5vlJFbqaZlQ==
X-Received: by 2002:a05:6808:2201:b0:3b8:63aa:826f with SMTP id
 bd1-20020a056808220100b003b863aa826fmr7354879oib.25.1702336892986; 
 Mon, 11 Dec 2023 15:21:32 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:32 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 2/7] spl: Add Kconfig options for ADC
Date: Mon, 11 Dec 2023 17:21:20 -0600
Message-Id: <20231211232125.171438-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

