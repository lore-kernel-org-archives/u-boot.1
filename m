Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEE9D5C0ED
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CDE8907E;
	Fri,  8 Nov 2024 16:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HDw5iOzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992C188B1F; Fri,  8 Nov 2024 16:23:57 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4E588B1F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83aad4a05eeso85480739f.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079433; x=1731684233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2/fS9vkgssxYnQ8CkOlKyoNCI55An0vyf1B0pp/YPDg=;
 b=HDw5iOzBMj6JL/xCOg+xOl36nfK1HzgPD5pjw8embbHBhRz+1zQvsnsX83M3IEzzM7
 B6V/g6myn5raEuzLkCByAy0a/52/NmPI6twyIQheDUCILFPf2e9Z9pUblpB3Z1dhrAfJ
 SZ6zY/Glfp9mFDAn30CS9zuKJhjkE3qUWeIbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079433; x=1731684233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/fS9vkgssxYnQ8CkOlKyoNCI55An0vyf1B0pp/YPDg=;
 b=ESzqdB2yLiFcL4qaGQ01PmWatb7m2pNGB9NwZ/O39k7P3Sw6viRHqlUmE9tdVNWh8x
 JBs9fAfT+XjF2+E7z5yxONyzFdg3Z/Zoa/E+O99w478hkY21Si2Wa585lzAFaKTzK1Jd
 vzljUjtleFwVrgf0bo2vaoLLSaWlXlVdru/RoTTwrkhebe/ee3hFgxFMhULUUyFz8luE
 oQNoxeKdtHaJvOxCrbHmh0yLjI4d2ThyqDWpKWOTQYhP8Wq19Xw1ywZjCm6/vPrJMCwz
 9r3ADwpTOi4bKjZDmJ+OlcIyd9FPT3QgdMVpR8WNACwtO0lYVajHlocfcOR/ZRx+prR6
 nyJQ==
X-Gm-Message-State: AOJu0Yx+JOz+MVpkupCOfA3lPhodwRIux1m7uN0d5B+LUSmcO/qLd1s7
 R7cDfK6IvEi/5MR8fiUpZX+19538QuT9AUVePcZFNVPMuOnomBowVczAq3s5Loy5agnrqgUQh7U
 =
X-Google-Smtp-Source: AGHT+IGaVyGVNzngxaeIdl4Jr+jSdugZGigIBsgpOgYza1dTL3XeFjJSLyQHmTwtK5LM2gCYfi+H7Q==
X-Received: by 2002:a05:6602:1690:b0:82c:ddfc:c57b with SMTP id
 ca18e2360f4ac-83e032d8565mr396047139f.5.1731079433562; 
 Fri, 08 Nov 2024 07:23:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:23:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 0/9] buildman: Add initial support for config fragments
Date: Fri,  8 Nov 2024 08:23:41 -0700
Message-Id: <20241108152350.3686274-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series updates buildman to process #include lines in defconfig
files. With this, it is no-longer necessary to duplicate lines certain
lines from the include-file in the defconfig, e.g. CONFIG_ARM and
CONFIG_SOC_...


Simon Glass (9):
  buildman: Add a lower-level test for KconfigScanner
  buildman: Set up the tout library
  buildman: Support #include files in defconfigs
  buildman: Correct the indentation in the setting-up section
  buildman: Document the toolchain-prefix section
  buildman: Correct logic for adding a toolchain
  buildman: Support a tilde to represent the home directory
  buildman: Propose a format for extra boards
  RFC: Show building with #include in defconfig

 configs/j721e_sk_a72_defconfig |   5 --
 tools/buildman/boards.py       |  25 +++++++-
 tools/buildman/buildman.rst    | 102 ++++++++++++++++++++++++++++-----
 tools/buildman/func_test.py    |  85 +++++++++++++++++++++++++++
 tools/buildman/main.py         |   9 ++-
 tools/buildman/test.py         |  50 ++++++++++++++++
 tools/buildman/toolchain.py    |  47 ++++++++-------
 7 files changed, 281 insertions(+), 42 deletions(-)

-- 
2.34.1

