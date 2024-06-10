Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C8C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C3D885B5;
	Mon, 10 Jun 2024 16:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2IlKdJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20229885C7; Mon, 10 Jun 2024 16:59:42 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E858B885AD
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso18840695ab.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031578; x=1718636378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/yA7KrMC3jhW+59sxNH0Zg7a8cirEwzmasdjTDRlQhg=;
 b=S2IlKdJAAjCMVyxNhruAADF/XTggXrIvtyYxsYoFWfIFEokPIxaEeuToWfeeNntXOl
 eO7oZMsUQ5wEODqOs/bfnjhzddQgPYVMeVpYcbZc5bYdKuFn8OU49T9bRlPQlpGHihan
 quY8uUUMrTVTGoaJ2Ad0HM7y+QHmvp2NzW/nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031578; x=1718636378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yA7KrMC3jhW+59sxNH0Zg7a8cirEwzmasdjTDRlQhg=;
 b=M7bssVcuSPouzW3+rxdeD6D3gLDrbE2Lt9aqW/JunocgEbbk5LvVyZqS6DnNY9J19+
 5RO2Qqv6d5lMLg6eDyBvK4LcRYuWF5uSiIVlAYKVjO7mK2/AxHUjZPRnabalt/8vjqlq
 CiVZSkjMnmTR0Z1bm5wbMBo4Q5LQwKqcQMESvVB/vJlgLNQhdutxFJCCcj9WZfuXT0br
 pgX60XH4QNFWRTVpM2TX9LJhoiXtou4y5C7n7mI03hA175ERAqDkLrlHl4vtlQXa568o
 yCb0PAEiDPGiJLRssrfZTU+LRg0tthissZQcR4A1b2KGJvta/hXZAotSwNpjXKjmviH1
 3X5Q==
X-Gm-Message-State: AOJu0Yw2Js4UHaPurRF6nLAdopYi8JbdgC7kXs98K/ZKumThm7VUrEVM
 ObFwIOBhlb/zSOwlwIK6RxA7DSivKvFE2ZG92tXfY9bk5yIdp07RzxmdBtnP/Ifo0JkHuWv7ay8
 YhA==
X-Google-Smtp-Source: AGHT+IEmhCFoNOXRz2YW2cKSr1GxLGxDG6fU+MVe8o8+BDzLdkYbJ1XCGUUZndV7rD6OpINfdXI6cg==
X-Received: by 2002:a92:c241:0:b0:375:a48d:fda1 with SMTP id
 e9e14a558f8ab-375a48e0215mr36564185ab.2.1718031578489; 
 Mon, 10 Jun 2024 07:59:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 2/9] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
Date: Mon, 10 Jun 2024 08:59:13 -0600
Message-Id: <20240610145920.3302001-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

It does not make sense to enable all SHA algorithms unless they are
needed. It bloats the code and in this case, causes chromebook_link to
fail to build. That board does use the TPM, but not with measured boot,
nor EFI.

Since EFI_TCG2_PROTOCOL already selects these options, we just need to
add them to MEASURED_BOOT as well.

Note that the original commit combines refactoring and new features,
which makes it hard to see what is going on.

Fixes: 97707f12fda tpm: Support boot measurements
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too

 boot/Kconfig | 4 ++++
 lib/Kconfig  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..b061891e109 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..568892fce44 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,6 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

