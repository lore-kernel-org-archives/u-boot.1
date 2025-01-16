Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0250C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34ED080719;
	Fri, 17 Jan 2025 00:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WQErDItU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89E280717; Fri, 17 Jan 2025 00:01:37 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903528022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb7ecc3c54so966404b6e.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068494; x=1737673294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpsYxKOZtZvw4QcRQyOhSzssllEy/xoROUXq6Ygrmnk=;
 b=WQErDItUC+1EhZd9bIAZ+6lvkivuDVt6nMIONYDk03aHZA3hEif2qWOmhBZ3vbANqy
 uigGCLkyl8i6aQ//M/wwCypopz2BDjEBuCVW0GvWQiHrvop4/2KakAHtgo1j7euK1n3v
 38G5NX0s+x/p0MZ7vaZd0FvepRyneI+nGqOUfnR0yhzF+apCQ1FsZ722DiqdSIbOznMW
 7zguhJOwcVb65NAY3K8g1Q8D1ilFRFve/lp4kSTyE0VS3fDT3B7rQgFRIklbw2gYfWYA
 /NykzT7f+3zFWy6L33Kb1yYiQcfb/TZUZapps7d9KkPifs7TrQJQ3JFisTUHDtePgWPD
 x+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068494; x=1737673294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpsYxKOZtZvw4QcRQyOhSzssllEy/xoROUXq6Ygrmnk=;
 b=uEmjcqNxWlaYiuOq6gN/vAfPRqpTz5Nj/eDv2aZA79JdXhjA2Z7poQBmK173UNLhuA
 alhPzcTO8j7naJDcwNmzSyM/JlYtftrphpiW1uvxRZUtIvRQmqLiJJRq/mjsYwgZjRpS
 DdJmDR/rnbBK+oopZn79G4DqKHtPahT7tkjITZEMhM1XsIAaTuYeaoNpKMh0JXDpG1/9
 Wl2T04ycpyKSgiM8wl2FcS0vCGHOlst7Bgvnb/FpBAH6ErBIOYE5SZ0SQcYpgwTYI51Y
 dX2nJu8q3HW+cBYaA8Q0EXYUTAVFTvnNMMeJSQtLSE51JlAMRTLmoZdQPNE7WuQUs24W
 8rgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqb2m8wHAz/w9OVyDxlq4w8wb1clgoIdkb08ILsJpi9qo+HexEFAXLQ+6bxPBF1bGzaWBk4FM=@lists.denx.de
X-Gm-Message-State: AOJu0Yze0WKuMGPJiQcEarwyvsF9S4C/IZEGGtLLzGwES5SdfzGVlybK
 NCmNrFxT+bIEIt59mONX+/qmSF0iG6mrMbf2tVI2Ewvs7XyyJU3jvpUNBNcupC8=
X-Gm-Gg: ASbGncvr633WOxePw+MZygMmwxbmVfd6xPVxXIqF7QqQR106M5WQwogD9NkPdXib20P
 Lev+Gu5jXUB6lk+ZZ8sIvMwOaPSGO699WKEDxUkOsbBSD8B9JJzZdzhAdavFInbBE4QYNN1escd
 S6FJ2Rozrb0H/KZka2ZOA2E6ZVVtQN4X7G0LWJmPBeUT4Xh+6d1OOOg/DCut3sLYOfF6BkJlxR2
 Jl/BzkxaEdqoAIFZ/D4r4yv21woqjktGK4KTZwF8PxjGvntXBx+zfOTzRTwgw5MycU=
X-Google-Smtp-Source: AGHT+IF6KI34qJsoeL4ZRXFwUbGKw5nS8UUUs5pliPfFvM+nM5q1OXoOsa67dZIwH3M76Rhk8PJ2Cw==
X-Received: by 2002:a05:6870:2f05:b0:29e:2cd6:4d1d with SMTP id
 586e51a60fabf-2b1c08bfd8amr423354fac.9.1737068494370; 
 Thu, 16 Jan 2025 15:01:34 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b1b8ceff9bsm578510fac.18.2025.01.16.15.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:33 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 1/7] configs: e850-96: Enable options for updated env
Date: Thu, 16 Jan 2025 17:01:24 -0600
Message-Id: <20250116230130.3337-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

The E850-96 default environment is going to be updated soon, requiring
next config options to be enabled:

  - CONFIG_DEFAULT_FDT_FILE: $fdtfile will use this value
  - CONFIG_PARTITION_TYPE_GUID: $partitions will rely on "type" feature

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index c36196c510c5..b1b3510d691d 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0x80000000
 # CONFIG_PSCI_RESET is not set
 CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
+CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_ABOOTIMG=y
@@ -22,6 +23,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
+CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_MMC_DW=y
-- 
2.39.5

