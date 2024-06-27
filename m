Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00B7C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4258854E;
	Thu, 27 Jun 2024 10:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObGfZt5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E72588549; Thu, 27 Jun 2024 10:29:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C8D884A7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4247f36f689so53945225e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476995; x=1720081795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=29l5u/ATdz3BkQodh9CPv6uBw/gjOeOJVZBKz6EqLlc=;
 b=ObGfZt5yxG0uzn6VNREo8i0wwjeylKxC/rFABbg4k5dbl2qcQCLHjUKzOqYVZ8m580
 MWhHtRop2sZXK587D50BAFde6xb5lX4iItIhUImOVg3IgTRiFEW0SRyU1CYhQyXUV2eu
 aUNdypeAzox5wOs1MnyKo9F3oqzg6Rqznz9Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476995; x=1720081795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29l5u/ATdz3BkQodh9CPv6uBw/gjOeOJVZBKz6EqLlc=;
 b=Fa/FzA9ZJCiCtI4f1WF/KePQmdizFkT2aYocdFKp+vLgsBBMvbYZ4IStmqkSaR6mhC
 xo9UzIdDCXbCmEugvBcjems9TLXH0wJiD1PzxUyM1LVVkReLaZjc/M0PWnlb9Nj5d0wh
 mz7zWtvh0qWYj+RytnljV1z78TnY1V9lyd6+yg0LyGd7V96kLA8GJUA8a5wghyDxo8a4
 1Cii+ifQAv52+63wFBahHvItg7Mgj1AjCjFqmGftxXmCuU9BMvJIr/6regn4BnfrQBgk
 cB9g7RAoYM4sRfzGQEK/979GiFL3OWf+KyZU6gO75t1DpzMk+VRZDu8NrBmC45u0pj0x
 lArg==
X-Gm-Message-State: AOJu0YwTP8T1F7Zdn+jbUcrdFMeesOScPvh54ePmm1m6sNrSiYKW2rvw
 52AJme1pZq01Fs7v1S85DIEUsJFpV4EDFdZswtJr/Hohf+4xHqRu7S6CKhppWWJl1Z0YCseNpcI
 mrA==
X-Google-Smtp-Source: AGHT+IFy+vRFHJQF/WYfUHvUR8eYE1AmexdKTFg5OPgOYtyy6j91Iy5sn0d8USZnJ+GezM2Gh0HjXA==
X-Received: by 2002:a05:600c:4748:b0:424:8cc8:6350 with SMTP id
 5b1f17b1804b1-4248cc8652cmr92213395e9.21.1719476995360; 
 Thu, 27 Jun 2024 01:29:55 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <l.majewski@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v6 0/8] Bug-fixes for a few boards (reduced series)
Date: Thu, 27 Jun 2024 09:29:41 +0100
Message-Id: <20240627082949.357089-1-sjg@chromium.org>
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

This series includes fixes to get some rockchip and nvidia boards
working again. It also drops the broken Beaglebone Black config and
provides a devicetree fix for coral (x86).

Note that since this series fixes bugs, it is targeted at -master

Note that this series does not include:

   fdt: Correct condition for bloblist existing

which is needed to fix booting on several boards.

(no changes since v4)

Changes in v4:
- Add new patch to set a board-size limit for chromebook_link
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too
- Remove the superfluous if() and drop the debug() as well
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

Simon Glass (8):
  nvidia: nyan-big: Disable debug UART
  tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
  x86: Set a board-size limit for chromebook_link
  rockchip: veyron: Add logging for power init
  power: regulator: Handle autoset in regulators_enable_boot_on()
  spl: Allow ATF to work when dcache is disabled
  rockchip: bob: kevin: Disable dcache in SPL
  Drop the special am335x_boneblack_vboot target

 board/google/veyron/veyron.c               | 30 +++----
 board/ti/am335x/MAINTAINERS                |  1 -
 boot/Kconfig                               |  4 +
 common/spl/spl_atf.c                       |  3 +-
 configs/am335x_boneblack_vboot_defconfig   | 94 ----------------------
 configs/am335x_evm_defconfig               |  3 +-
 configs/chromebook_bob_defconfig           |  1 +
 configs/chromebook_kevin_defconfig         |  1 +
 configs/chromebook_link_defconfig          |  2 +
 configs/nyan-big_defconfig                 |  1 -
 doc/usage/fit/beaglebone_vboot.rst         | 21 +++--
 drivers/power/regulator/regulator-uclass.c |  2 +-
 lib/Kconfig                                |  4 -
 13 files changed, 35 insertions(+), 132 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig

-- 
2.34.1

