Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D3CFC501
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:17:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7B088D10;
	Mon, 14 Oct 2024 09:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JnQ1EuG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384D288F46; Mon, 14 Oct 2024 09:17:43 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FC886BF1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5c94dd7e1c0so3567274a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728890260; x=1729495060;
 darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qLqq65KH735wkY/mI31qhL4cagciTjAESWJCFyayrTg=;
 b=JnQ1EuG7jDQ9buutuAKSHstzdq1OXC15OHlYXpAFIhc+KIuut3/7xy3Rm+aRcORb8l
 PyXlKqpfQgjr+1SkkjVxL3JasJSMvzjTraAccj1+DUBLL6CNMv3/jCUVg5XblzP5lQMS
 I0ATqxAL+z/rdhEMGIiAG89XlnCkROXzKiz6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728890260; x=1729495060;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qLqq65KH735wkY/mI31qhL4cagciTjAESWJCFyayrTg=;
 b=ZVfp/Rzl3qXjohDPj3PkcPEWPwI9t2K5QGm7/9G5pLuRZ6w1pasQ1UPQWznmp0G90R
 phTGlSBOdQoAdO4SW6i8R9+IYU/4KKuWnazVzVLzCuvaAMrZHYqJyqLJBtsWx18tRD24
 JNehOpvvPLy1a4HMz6FHD/bqJVzi/UOXrNIeLs4e3F3riW2CMBVkXm2AGRnfUHavvIxM
 8p+MYsVcEiOWm6QAHMgHfdsCXVLlcYY3JCiY3/O+k9VX7W5XuJ6rYgw84DTCgwDNqFgA
 IZ3gGqxJBWO7sSPRE1gpFlKi1jy1fCipcDhbF9pbJi7cSuD0+KJWNw7RvIRSfiARv3Qb
 Mfww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc5z01aiBGQGlYzW/nnNjmfrhvZChU7IIifPqIbNFcU89/gB6CnGr8g18euvidC+93TRmgiBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzMoSIWf8HL/PA0tX1AVkGUFGcxOzkgesGhBb/dDxE3uM0aPfGt
 TAMiki02E4eCryLF2U3+Wd6PAM0wfDpDMsmSt9GGn9jfSQFVL+s7+XSe3BU+jFbuf9wi75qSH3w
 PZKfbaZFW3y3LuCWWNFUR3ZN2w15R89Wapj1laQ==
X-Google-Smtp-Source: AGHT+IFJMAcaVNSwbftIXcbhGpGUhokczhRhe/yswPctUWBRzKu0/DqMuA/bQjYzM9L/+HAoepivo02Ykn1jgBDMNqs=
X-Received: by 2002:a05:6402:4409:b0:5c9:85ce:d9e3 with SMTP id
 4fb4d7f45d1cf-5c985cedd76mr115126a12.16.1728890260281; Mon, 14 Oct 2024
 00:17:40 -0700 (PDT)
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 14 Oct 2024 09:17:25 +0200
Message-ID: <CAOf5uw=NJEiiX4qOWqZ6CpAjdwvyBsmonEn5egSAHC8-N6FxKQ@mail.gmail.com>
Subject: Pull request for u-boot-nand-20241012
To: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
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

The following changes since commit 47e544f576699ca4630e20448db6a05178960697:

  Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD"
(2024-10-11 12:23:25 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
u-boot-nand-20241012

for you to fetch changes up to 25e46f8281075d3b3a8d393264ff1cd33f8815b3:

This merge request add support for BCMBCA raw nand driver for bcm96846 board
that switch using OF_UPSTREAM and allow use onfi ecc params when they
are available
in the atmel nand controller

The patches pass the pipeline CI:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/22638

----------------------------------------------------------------
Linus Walleij (4):
      mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
      drivers: nand: bcmbca: Enable on BCM6846
      board: bcm96846: Enable NAND options
      board: bcm96846: Switch to using OF_UPSTREAM

Zixun LI (1):
      mtd: nand: raw: atmel: Use ONFI ECC params if available

 arch/arm/dts/bcm6846.dtsi                    | 103 ------------------
 arch/arm/dts/bcm96846.dts                    |  30 ------
 arch/arm/mach-bcmbca/bcm6846/Kconfig         |   4 +
 configs/bcm96846_defconfig                   |  15 ++-
 drivers/mtd/nand/raw/Kconfig                 |   7 ++
 drivers/mtd/nand/raw/atmel/nand-controller.c |   4 +
 drivers/mtd/nand/raw/brcmnand/Makefile       |   1 +
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c  | 152 +++++++++++++++++++++++++++
 8 files changed, 182 insertions(+), 134 deletions(-)
 delete mode 100644 arch/arm/dts/bcm6846.dtsi
 delete mode 100644 arch/arm/dts/bcm96846.dts
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
