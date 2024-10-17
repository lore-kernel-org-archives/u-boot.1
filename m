Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30754D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4573F892D5;
	Fri, 18 Oct 2024 01:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ivoDwAwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED9089257; Fri, 18 Oct 2024 01:25:38 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DAC89265
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a3b98d8a7eso5841835ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207534; x=1729812334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBZRW7U1TEOcJTSk72guUGqcEean5FXFObBqn31KN58=;
 b=ivoDwAwe7xGv/XW22VIOzMmTTDWMbRO2gfldYW8CEL6tqPKbNjpof3cbgvV1s1ZNaR
 04pYh3jxI9bxc31nvl9nPigc+kRCD3oIJ+11TfkowByfKjfv9VRge1WHc9VLasIJHjWA
 xfhMTm8O6I1D7aRFKx5306A6Ib0XkDPpCHR2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207534; x=1729812334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBZRW7U1TEOcJTSk72guUGqcEean5FXFObBqn31KN58=;
 b=ZSf5wW8RunPogSUYDTNfgaDxpP2ls8F1AVpspRqlFgKc1xiNty3QNPdDLmZLLMQZDM
 Gll+NEjR8Jw8H7EUzz2qXyyT7X7QF9U4heVeL/ZplAkzMdtjWyMzv3IPfBnXe+LCsiAP
 FrzZhmv62+VvGsdyxQlp/JUgnwm/6MUA7s/kAJKocuz9lN4H5uGHxo7fm2ykTVDI82xj
 OVDc5kVN2wecOFcYmSLm4q/1iVdkHO4ap0eAWKaGYKjWFuoKW7z9utcYWripH9OkJNpt
 HY4NKfZtcb4Rqlse0HaPYUjCnvKJ1c+Ju6aOgXDid6nBS19MSpYse8IQG/lBZ1KDWS4t
 bLPQ==
X-Gm-Message-State: AOJu0YyZYTRUj5DwQF6zCFZTSKrvaPDrYcx7qXExGcQ+tcryuMbamw1O
 isSuGXB/FCILncE2SOS2TB7N9WtITK9BASW7p8bDrgwEiMIwXcWnRLjwcAayj5mWueS8nCrfMI4
 =
X-Google-Smtp-Source: AGHT+IHO0nfEfNIFqGTC35pvLxbX7Vg+4deIpiZJSPXvNqxgXmJhkHc013GW7d6pQW3ATN/zdNgiQg==
X-Received: by 2002:a05:6e02:1c29:b0:3a2:aed1:12a6 with SMTP id
 e9e14a558f8ab-3a3f4059d87mr4531105ab.6.1729207534263; 
 Thu, 17 Oct 2024 16:25:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ac9csm122057173.29.2024.10.17.16.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Joe Hershberger <joe.hershberger@ni.com>,
 Johan Jonker <jbx6244@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Neal Gompa <neal@gompa.dev>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 0/8] bootstd: sunxi: Migrate to standard boot
Date: Thu, 17 Oct 2024 17:25:23 -0600
Message-Id: <20241017232531.726559-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Oct 2024 01:26:15 +0200
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

Changes in v4:
- Reword Kconfig
- Add a name for the bootflow
- Drop UUID_GPT_SYSTEM and UUID_GPT_ESP definitions
- Drop special case for ARM64's devicetree subdir
- Drop unwanted quotations and indentation in KERNEL_COMPAT path

Changes in v3:
- Drop wip (work-in-progress) comment in commit
- Fix 'supressed' typo
- Use backquotes to highlight DEFAULT_DEVICE_TREE

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
 board/sunxi/sunxi.env                         | 140 +++++++++++
 boot/Kconfig                                  |  16 +-
 boot/Makefile                                 |   1 +
 boot/bootdev-uclass.c                         |   3 +
 boot/bootmeth_fel.c                           |  84 +++++++
 .../gardena-smart-gateway-mt7688_defconfig    |   1 +
 doc/usage/environment.rst                     |  12 +
 include/blk.h                                 |   9 +-
 include/configs/sunxi-common.h                | 238 ------------------
 11 files changed, 269 insertions(+), 246 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.34.1

