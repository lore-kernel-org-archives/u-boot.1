Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7107D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529218959D;
	Wed, 13 Nov 2024 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WaVbD26c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8A889021; Wed, 13 Nov 2024 16:09:52 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0158959A
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a6bba54722so27419525ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510587; x=1732115387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D9W2L6QfAWTCRvwOE+bVEVmBDk+XXSu1iZ9wgwaZyMo=;
 b=WaVbD26c+ubIrwgQPejjmNyUKqDfrWWUP/yp+dZ8RRGxRbd+/s5ezD8M6drQLd0gLo
 Oqk8gi7yhSViJHzrjIvU80h0AqWSd6mh/9HEmuOy2DiXWFbQXofPb5v46uF0R3/4bCD3
 xc7/eUjAka0glyJ4lCJQVjKYJyEq9IB7s3ImM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510587; x=1732115387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9W2L6QfAWTCRvwOE+bVEVmBDk+XXSu1iZ9wgwaZyMo=;
 b=rZD3pGDPJhTchXA8btwbVSXL4w48YOMR+HBCfsJg0z1Mol0N7Q9W3OYM/Q/OxtXjyI
 juLJ85mMeV6nRiedCDMSIGnHulWzD4n8zR/rjtD/cA+EvqC4k+sXLSrUImvqdvi/pqaP
 TrbyztxN6QAWluvP27ykPRScoARoKq2A2wdBTbu+vvfPoAcKPDw+OsHimBlkhZvEr+x1
 JHgqSa47TQKRaecgTehPHSw8K8Vlq9oxe9KO1CPaCYyZPpzSlIV/JH4iKs5GlId3PpI/
 xm35SwWf9EqmRYjhEKksnTWHPMm0HEsR5e0YsuwFtFeXpDmOSnIUfVuQt+hkMoKR5emj
 ZecQ==
X-Gm-Message-State: AOJu0Yz4/gDDDj2XtU5xJ7KOeAcj7oo02/H/ko8jQ8QE95mzUjuLUzVY
 cYVphmIsGZzl5yxWr+HiJuESvM31hduaKnLRRuoRmlP2trGeh0qicR5KqWacuLFeeMazO+fonvI
 =
X-Google-Smtp-Source: AGHT+IFWqswOWGIAFB3Ipo9Zt4zQel308RPcEts7XR5K3rMw4D6w/88JsEH9hHeI7L5vjDhijDN1/Q==
X-Received: by 2002:a05:6e02:184c:b0:3a4:e452:c42c with SMTP id
 e9e14a558f8ab-3a6f19c1d84mr198790605ab.6.1731510586786; 
 Wed, 13 Nov 2024 07:09:46 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:09:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alex Shumsky <alexthreed@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/8] bootstd: sunxi: Migrate to standard boot
Date: Wed, 13 Nov 2024 08:09:30 -0700
Message-Id: <20241113150938.1534931-1-sjg@chromium.org>
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

This series attempts to migrate all sunxi boards to use standard boot,
along with a text environment.

Unfortunately a late-breaking problem has come up with bootmgr. There
are two ways to fix this, both included in this series:

   - Drop bootmgr for sunxi
   - Change efi_mgr bootmeth back to sandbox-only

Based on the mailing-list discussion I have selected the first one and
marked the second as RFC.

Changes in v5:
- Add new patch to drop bootmgr for sunxi

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
  bootstd: Avoid depending on BLK
  sunxi: Add a bootmeth for FEL
  efi_loader: bootstd: Drop bootmgr for sunxi
  RFC: Revert "bootstd: Make efi_mgr bootmeth work for non-sandbox
    setups"
  sunxi: Move to bootstd
  sunxi: Drop old distro boot variables
  env: Provide a work-around for unquoting fdtfile
  sunxi: Move to text environment

 Makefile                                      |   1 +
 arch/arm/Kconfig                              |  10 +-
 board/sunxi/sunxi.env                         | 140 +++++++++++
 boot/Kconfig                                  |  18 +-
 boot/Makefile                                 |   1 +
 boot/bootmeth_efi_mgr.c                       |  18 +-
 boot/bootmeth_fel.c                           |  84 +++++++
 .../gardena-smart-gateway-mt7688_defconfig    |   1 +
 doc/usage/environment.rst                     |  12 +
 include/configs/sunxi-common.h                | 238 ------------------
 10 files changed, 261 insertions(+), 262 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.34.1

