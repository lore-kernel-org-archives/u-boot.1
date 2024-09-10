Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32660ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3AE588F47;
	Tue, 10 Sep 2024 11:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RnLen/2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB6588F52; Tue, 10 Sep 2024 11:01:09 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A59488F44
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so6955755e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725958866; x=1726563666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fL+9abO3xxqeqCbLBC9JZ00FGqEby9ZFqwOg8qUBwcU=;
 b=RnLen/2hwIpwHPjw7Tf6H7sYOO3SyN+LtI2RWN39qfu9IjFbUPiNMey2c9HbGuPEuX
 dsnxB/Szwd44Qud/1x/0UziVtgT7P7Jp/bghFSp14bPSz2FaA275lVzgc2RFVNgLwBKG
 OLvwPNafBECv47MwcJ3xXcxTBc5G/rgA0LJCpCJVE6xQtTgT6LkpaoBKpBb5NVQAbld8
 qhINqqF0bnKrQPUUB0XBBRyQ3kpZL6cc9gmbR8lf7h31Tj8Gn8TCkK/HVdu450RfE1eI
 J2s42oHaklgJKgaQZEDBDCuql7q8Gjn8UJukwyeSty7BsAIuUeh47iXhh5tuMpkhTieT
 2r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725958866; x=1726563666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fL+9abO3xxqeqCbLBC9JZ00FGqEby9ZFqwOg8qUBwcU=;
 b=nDjtSu3ws2OasfJACiX9gqV0o/gH94YdEshIrKNvOw5PhI40PmiPo13zpCEeA/KM92
 h37YzxUOcxVtivNsxrOfVgumAYEygH8pYCsm91UCVPMPRY9rRVaIPMsUWHS1oby15IaC
 D2N7iAPUmrQbBI0ZmoKPs1QsmPqbW2I+X4m7f+GJm+LhHFS8/7CAQnPiWwUZ3tyEoFEH
 8HofcoD2T2aEmPipQ099CS3iufqpteoWmAqaUe0ihNsXI+0QQyxky4TxSo3VlXqsuf5Q
 Ff2Yvb5htueKpZYatCTGYamcnb8IFPtbZ70OWXB3rpR/2SweneBsLgAdSB8K7jtLIWPe
 SKLw==
X-Gm-Message-State: AOJu0YwJm6QOIsSavhr/JjRbAh4YNhm/rCdpmiesXMGWbWRD3yx/LvMn
 +/8lgJ0fh6oIzEGOrFlnM1cMgeRVkVXZUrRoTQ7YpzbnEjFWuoh7c64lR4wAsaJ+fdIjWgD2HTp
 43bBiZA==
X-Google-Smtp-Source: AGHT+IFRRi4VaGXz643Fy/JDLZBIFraBvgVFe0/XK7atoXsUeVHvzLvOzJ3q4gQuDfeQwzDM8LB8rw==
X-Received: by 2002:a05:600c:45d1:b0:42c:ba81:117c with SMTP id
 5b1f17b1804b1-42cbddd6575mr13426855e9.6.1725958866260; 
 Tue, 10 Sep 2024 02:01:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d022:7718:6b27:6851])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675c40sm8281423f8f.51.2024.09.10.02.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:01:06 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH] spl: ram: hide SPL_RAM_SUPPORT
Date: Tue, 10 Sep 2024 11:00:12 +0200
Message-Id: <20240910090013.2686124-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
may be enabled without the other two being enabled, which results in the
following build warning:

common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
   19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
      |              ^~~~~~~~~~~~~~~~~

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/spl/Kconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Replaces "spl: ram: fix build warning when neither RAM_DEVICE nor DFU
are enabled" [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-September/564302.html

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08ff064493..885a012461c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1238,15 +1238,11 @@ config SPL_POWER_DOMAIN
 	  the drivers in drivers/power/domain as part of a SPL build.
 
 config SPL_RAM_SUPPORT
-	bool "Support booting from RAM"
-	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
-	help
-	  Enable booting of an image in RAM. The image can be preloaded or
-	  it can be loaded by SPL directly into RAM (e.g. using USB).
+	bool
 
 config SPL_RAM_DEVICE
 	bool "Support booting from preloaded image in RAM"
-	depends on SPL_RAM_SUPPORT
+	select SPL_RAM_SUPPORT
 	default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
 	help
 	  Enable booting of an image already loaded in RAM. The image has to
-- 
2.40.1

