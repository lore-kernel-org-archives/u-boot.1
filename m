Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3864FC5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDB588C10;
	Fri, 23 Aug 2024 23:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HqHDgKBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B87488C73; Fri, 23 Aug 2024 22:48:35 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C21588BB8
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 22:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f96ea9ff7so116978439f.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724446110; x=1725050910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ews+L2zO+wvLUWJVybnPdB7R7SVNvQa9C4LJkBGzLXY=;
 b=HqHDgKBrGIZoWIuETMnLwAFvVa2s6cNljUaXDIb+2LJM0HrfvzqeSoMxDodXs45Kld
 IRZ9K2EqpibxR+Tb576Zmwr9Qghjd+uLw4Woxfcm5p4J3/XV7t+gP7haExX1xYgqL+Su
 Hfq4iG3IZD4kjPQAG274J54seW9wr17pXuBCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724446110; x=1725050910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ews+L2zO+wvLUWJVybnPdB7R7SVNvQa9C4LJkBGzLXY=;
 b=cBEZQCOoaBnC6+r50NxrKdIpRC5t6RaEG5EkK9UUmj37Mqs9isOZxS7BuuuBq531Id
 Ab3RrAbbMPd7DozzsdY030qIaqwv7aHiGedfjEgXaPuV8gjzeBoLMq8z1iQ2tYMqQNxV
 qPxpJbRgNr682QHkKqOM7d8H7LNhD7s7rf+LnOK/Mm+YAOiYl8QTUtU97Wjzh41qSZmt
 1opVkLaDQfYy/vFmN9hgcdWxxaIS6m+OtuYgAtJvBtG0CWau5Nnc8phv7nSXi8XKhYWq
 NIWxtM6Sdqvz7zkmc5+34rsdLuFYs7SsE5i5mcPrtLb33LA1Zkn5ZL/29Ho4t/jW/d2p
 GLtA==
X-Gm-Message-State: AOJu0Yx1KQTSKtX203G/ii8RTTOT7CJ+75fRAsMEGVVc171PsxhR1FOq
 BhDMYjaoC2O7+9G1Mxestfe17Zq7NWkjg+vPrU5u1TrkDluDCwgmvmQeKTQVJPAidzNWnrV+OWo
 =
X-Google-Smtp-Source: AGHT+IGt/Z25DwHG5vZVteDK0IXXEbenr/jJzjwyLhIkHyNC0iTqfcCidyKGRCFmohR7DqzdsN37yg==
X-Received: by 2002:a05:6e02:1547:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39e3c989d00mr35672165ab.13.1724446109843; 
 Fri, 23 Aug 2024 13:48:29 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e67addsm15698375ab.4.2024.08.23.13.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 13:48:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
Date: Fri, 23 Aug 2024 14:48:16 -0600
Message-Id: <20240823204824.443631-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Aug 2024 23:57:01 +0200
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

This series attempts to migrate all sunxi boards to use standard boot,
along with a text environment.

Changes in v2:
- Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
- Put the FEL bootmeth before all other global bootmeths
- Convert the other DISTRO_DEFAULTS in the Kconfig too
- Keep BOOTCMD_SUNXI_COMPAT
- Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled

Simon Glass (8):
  blk: Make functions available unconditionally
  bootstd: Avoid calling unavailable block functions
  bootstd: Avoid depending on BLK
  sunxi: Add a bootmeth for FEL
  sunxi: Move to bootstd
  sunxi: Drop old distro boot variables
  env: Provide a work-around for unquoting fdtfile
  sunxi: Move to text environment

 Makefile                                      |   1 +
 arch/arm/Kconfig                              |  10 +-
 board/sunxi/sunxi.env                         | 152 +++++++++++
 boot/Kconfig                                  |  16 +-
 boot/Makefile                                 |   1 +
 boot/bootdev-uclass.c                         |   3 +
 boot/bootmeth_fel.c                           |  81 ++++++
 .../gardena-smart-gateway-mt7688_defconfig    |   1 +
 doc/usage/environment.rst                     |  12 +
 include/blk.h                                 |   9 +-
 include/configs/sunxi-common.h                | 238 ------------------
 11 files changed, 278 insertions(+), 246 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.34.1

