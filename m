Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF62C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3F383B8B;
	Thu,  7 Aug 2025 00:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sadynvN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F2983AFD; Thu,  7 Aug 2025 00:27:43 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E735883B1A
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30b6bd0a352so358105fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519239; x=1755124039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx+9aCSmaQfmM9h0xYg9mw3T+cdonPb1GnX6RT5ggVk=;
 b=sadynvN+u5F83+10TO6Lw5zwmWBNaZt77k/DEj7Ls+DGdwAQNRsaxNV6gR6+3WDumh
 Iwe9khe6O7MQhHuUjIbrjQfjK7uK517+35G4N4wyxOqWWQ4DFGYegsyjWnwCcDZ04lBC
 OCKyAbzCbZ6LkUdk/Gj8i2klw4KobbXU1P6L0VaejeKUVkp5/UT6/wJm8mP0tsZmX2aV
 p1eTsExtV3X34IBRnEggptXHYnLpu3PDzwvvUwgtDhw+5mfaKyxE76gDYZTVXceKrBcX
 aEifhP0Y/ogLYUPBAiOrNlgGKubf4bqs6UNa0039duxaVJnTjwJzh5fXXuh1s0qVjCI/
 /S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519239; x=1755124039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wx+9aCSmaQfmM9h0xYg9mw3T+cdonPb1GnX6RT5ggVk=;
 b=ETGNkP6Qgw5jgMeAlsbgHRv+Oxs1BBNAIpdn/qLTP4hLCt4hfgKw2uJlxdqVzVfrHs
 /hfRwjNN8P553sT6fORLScnFSwZ4RA/e9YdvJDZPqvF2yDsWPHyL3ULaCoLt8qOVmFb6
 ZWPcNKka3SKn3fxph85AuFNk7ab676IgWWHkQgPzKxxHpIIV1helHHeQTQAhawV0yU1K
 UCvPmgFlOCEVL60+HQxfYGD/cYGIS/tYgEt93lJfs9bQlmrK/6NXCxEQaTbC8UXwDp3C
 a7UP6zjNGXxK5kSwa7WXBz2u6DTk/OFQEf4KF1wiHc4dxTV3IA4K7ErJiWz4cApBOx2W
 naaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+lB0U0eCIVoYXqbbBIOJhSWrprxZlvw7HBStw5hKkhYpnACLOk/ftx58GC220l3A3Frbxrh8=@lists.denx.de
X-Gm-Message-State: AOJu0YzTyGwX48S2czQVSQhpCOHB5qn5K307R2tM5k8KKt7DKmSqPv0/
 lj9vwRUDBGwgdnBVfmGWX89sCdQb2HOPh6f7BaXCaUxgALhZNqC9AGiLUBpqQwqaK8U=
X-Gm-Gg: ASbGncvNwNVMA2HG3sCLciStPd8AFVHJ9h1+TWFezbTHuchGhNfViYCwnbAyPjhEuI9
 tHXjYPFgMk80X65Ie/CH76azDc1a1dKMdVY/VD+olQes1VT4nFZibzltLyLuIW/3FdmnieJbikg
 U9pQlCoeGr3oz3/qgz9MrK2gyyEsilzDoFckgHXi0Io0dKW80/uSvKEceTjw5sGqjtxb7IwsSPq
 kr+ydRhcD/dI1882l04ZEnWORK7IKJRpb8ERYsg6r96uh0DwLBawTpS1w6piULbeHJ3ozQGyY9O
 nYGd/l0bXKBFevzm+vvfHCyA7uRfvo9N2sG8i1dWk5wSstIFlhC7pYzmAsB3MxhWFYRc1TvfCwi
 d0wDz3RCB9q+OBG+rxUMq0g0WlQ==
X-Google-Smtp-Source: AGHT+IGebWxsoPjYOkJlWnGeMTyIsRWI4Nxp40AhQP9qgKdi9yK4NvuiJ2ijV7Gnb91v0T4qm7tO+Q==
X-Received: by 2002:a05:6871:408c:b0:2ff:94d7:b006 with SMTP id
 586e51a60fabf-30be2911cbbmr3119644fac.13.1754519238579; 
 Wed, 06 Aug 2025 15:27:18 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a717f93fsm4451265fac.14.2025.08.06.15.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:18 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 08/10] configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
Date: Wed,  6 Aug 2025 17:27:08 -0500
Message-Id: <20250806222710.23773-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Linux kernel should use some separate device tree obtained from another
source anyway. For example the dtb file can be read from /boot directory
in eMMC rootfs partition, either by GRUB or U-Boot. Using U-Boot's
device tree blob to provide it to the kernel (when
CONFIG_DEFAULT_FDT_FILE is set and nobody else overrides this choice)
might lead to undesired effects when booting the OS. For example, if a
user sets "dr_mode" property to "host" value in U-Boot's dts to enable
USB host capabilities in U-Boot, it might confuse usb-conn-gpio driver
in Linux kernel later like this:

    platform connector: deferred probe pending: usb-conn-gpio:
    failed to get role switch

Disable CONFIG_DEFAULT_FDT_FILE option to avoid any possible confusion.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.env | 2 +-
 configs/e850-96_defconfig         | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.env b/board/samsung/e850-96/e850-96.env
index aed7a71046d0..992318b0ab26 100644
--- a/board/samsung/e850-96/e850-96.env
+++ b/board/samsung/e850-96/e850-96.env
@@ -5,7 +5,7 @@ fdt_addr_r=0x8c000000
 scriptaddr=0x8c100000
 pxefile_addr_r=0x8c200000
 ramdisk_addr_r=0x8c300000
-fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtfile=exynos/exynos850-e850-96.dtb
 
 dfu_alt_info=
 	rawemmc raw 0 0x747c000 mmcpart 1;
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index b4066d874602..412c99468f29 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -19,7 +19,6 @@ CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BOOTSTD_FULL=y
-CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
-- 
2.39.5

