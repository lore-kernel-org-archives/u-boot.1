Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE910F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485DD83C14;
	Fri, 27 Mar 2026 17:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJt68vhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89B983E7A; Fri, 27 Mar 2026 14:51:41 +0100 (CET)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C518394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50b2b289925so19769961cf.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774619498; x=1775224298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dhJ/s563If7XOUmebR8Rttd13CgVN58jY1/xzcLk8MY=;
 b=TJt68vhxDAMrGves4a+JNozT34AKAcBFYMcl9gOz8YLId5pciLl6TRHkrDjV6xCE/Z
 qzI3Y8gb98Y7cVuGvtxDNXmkqcCCeKMPk93+M1Qs+HLpt2c+zjuaxAvnYdnX2J9ispj0
 hqTgMNE6k+NuPWPeKWM+LyQDMyTfAZWOs3L4XHFRxVhPihWOO/JLesKZCbCTYb1MA5Tq
 xvzTYm9AvF7gO7QzKzw2BaRs3JbhbBHDHmGmSVwiKJ4iT141jgPoZNl6gfzlGvlcKbtC
 D8lalEeAWqVcIpHV4U4svAUo5+FpHLDf1WY1IyuO/iua4QKrm7eyHVV/vjjfomB3ySeX
 f0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774619498; x=1775224298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhJ/s563If7XOUmebR8Rttd13CgVN58jY1/xzcLk8MY=;
 b=It25bS+31t3sZymH1jmbA79pPd7b6RFN0YQgk50A4xOOB8DTNOSJALByuDPeR6zNgy
 a9nlvdWRua3mvWj25GSAnCR2XYYeZ2n2hUw9abwbTgYd3DCNLZXNGLF8ghYS0ILksZKu
 GSaYZIiC4L/IW9LxMenaP9157fcFHxsKwHvKTkYuMoHaBheHAbuDT4AaRBCTGz5KvaJ5
 CL5+dzdHqSVn3ILg4JDs016fczI8M8tebQoYYD5TlVON23LmS371fk/8AViptioWVfuj
 gU8fGPPVCmSA9zGROM2ASwmNTryJFiSO8l3frTh25zZPtmrD5AUcTtBFcme3w0VHfEYx
 yVdQ==
X-Gm-Message-State: AOJu0Yx1zNfUbpdw4sNoBMQ3kjFPl/OqpriZzprNPU2cPtid+36ss5fZ
 OqXzTVKBPBbM5TVdKN4Gp2Tlz8XHVY3gsS8L6ZLxxyKh/i43V5bAwFxQgkbw/DZH
X-Gm-Gg: ATEYQzx5GCKR5zkS0KG1bgyVfa4GA0UxmCjVuVBejYWyu0MPuq7Dxp7YMmMJupfxVq6
 +5SZYEn3pdlWM7haYIueP8ZNA8NDvMXcEkPuztdv9kovI5YgaAe28Z3+6esVF2k5NXgkVExI42P
 gGIirJP/0Dc7IGLUrqtgoi6z7U4sDmQmCRRqJabux+a9S4wE+JTQ2K1NqRXQyeuNxxlbcatJHqo
 MHViu6LYJIcMDnyqmZDMoOjXWOT/0lKTzAAWYHoJFgt4ypdUHtK/KoPUSAEBC0HjvuL/t8tu63+
 n50rGgGXNun8hR1cvG4utHIsQaz+5/lGHXd4K9J3L5z572XXBWz0TN+zwf3D+qkY0h/cOcwJGhB
 g0wNlOMRnwTXP5e3kCIL9gmnKitlWjtwvvT4L6UT4nMRN6sRpbr4dE00zfhMqGvy3Lb+LSy5c6c
 s58fwTNsIzE64WZNIaN295pi7mESXsqSgzJw==
X-Received: by 2002:a05:622a:10:b0:50b:4abf:313 with SMTP id
 d75a77b69052e-50ba384d1camr34566681cf.19.1774619498165; 
 Fri, 27 Mar 2026 06:51:38 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd588969dsm48691356d6.12.2026.03.27.06.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 06:51:37 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2 00/13] sc5xx Environment Cleanup and Fixes
Date: Fri, 27 Mar 2026 09:49:15 -0400
Message-Id: <cover.1774618658.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:39 +0100
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

This series performs a general cleanup of the default U-boot environment
for sc5xx boards, stemming from the decision to no longer store the
environment in the SPI flash. The environments for each board have been
edited to contain the minimum number of commands needed for all supported
boot modes to avoid confusion, and the default boot command synced to spi
for all boards that support it. The filesystem for the SPI flash has also
been changed from jffs2 to ubifs.

A bug with the Ethernet reset line on the sc594 has been fixed, and the
sc573 has been renamed from the EZKIT to the EZLITE to match the name of the
publically available board. EZKIT was only used internally before release.
Preliminary binman support for sc5xx boards has been removed as it was unused
and full support never added.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>

---
Changes in v2:
- Added commit fixing missing boot env selectors for sc598 EZLITE
- Updated load commands to use kernel_addr_r
---

Caleb Ethridge (12):
  configs: sc5xx: Do not store environment in SPI flash
  mach-sc5xx: Remove update commands from default environment
  mach-sc5xx: Update boot commands
  mach-sc5xx: Switch from tftp to wget
  mach-sc5xx: Add USB boot command
  mach-sc5xx: Remove preliminary binman support
  dts: sc594: Fix gige-reset line on EZKIT
  mach-sc5xx: sc573: Rename EZKIT board to EZLITE
  mach-sc5xx: Update image load address
  mach-sc5xx: Update SPI bootargs for ubifs
  configs: sc5xx: Set default bootcmd to SPI boot
  arm: sc5xx: remove LOADADDR and use kernel_addr_r

Ozan Durgut (1):
  arm: sc5xx: add missing boot env selectors

 arch/arm/dts/Makefile                         |   2 +-
 .../dts/{sc573-ezkit.dts => sc573-ezlite.dts} |   4 +-
 arch/arm/dts/sc594-som-ezkit.dts              |   2 +-
 arch/arm/dts/sc5xx.dtsi                       |  41 -------
 arch/arm/mach-sc5xx/Kconfig                   |  47 +-------
 arch/arm/mach-sc5xx/init/dmcinit.c            |   2 +-
 board/adi/sc573-ezkit/sc573-ezkit.env         |  18 ----
 .../adi/{sc573-ezkit => sc573-ezlite}/Kconfig |   8 +-
 .../{sc573-ezkit => sc573-ezlite}/Makefile    |   2 +-
 .../sc573-ezlite.c}                           |   0
 board/adi/sc573-ezlite/sc573-ezlite.env       |  13 +++
 board/adi/sc584-ezkit/sc584-ezkit.env         |   6 --
 board/adi/sc589-ezkit/sc589-ezkit.env         |   7 +-
 board/adi/sc589-mini/sc589-mini.env           |   7 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env |   7 +-
 .../adi/sc594-som-ezlite/sc594-som-ezlite.env |   6 --
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env |   7 +-
 .../adi/sc598-som-ezlite/sc598-som-ezlite.env |  10 +-
 ...ezkit_defconfig => sc573-ezlite_defconfig} |  11 +-
 configs/sc584-ezkit_defconfig                 |  10 +-
 configs/sc589-ezkit_defconfig                 |  12 +--
 configs/sc589-mini_defconfig                  |  12 +--
 configs/sc594-som-ezkit-spl_defconfig         |   7 +-
 configs/sc594-som-ezlite-spl_defconfig        |   7 +-
 configs/sc598-som-ezkit-spl_defconfig         |   5 +-
 configs/sc598-som-ezlite-spl_defconfig        |   5 +-
 .../arm/adi/adi,sc5xx.yaml                    |   2 +-
 .../configs/{sc573-ezkit.h => sc573-ezlite.h} |   4 +-
 include/env/adi/adi_boot.env                  | 100 ++++++------------
 29 files changed, 83 insertions(+), 281 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (87%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

-- 
2.34.1

