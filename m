Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 23:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723B888A3D;
	Thu,  8 Aug 2024 01:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KQ8Do43C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D93888C20; Wed,  7 Aug 2024 22:50:44 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9469A88BDF
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso11049339f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723063839; x=1723668639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IquL634a2kJ/HsFO7fKz4yJPOx5IOkDbAzl8bsB4qiA=;
 b=KQ8Do43CF5sCPPebCVJVn6WeSYitW5vOilTneDS5jPR2aHCbHjnf4ntd2Xo89oNR5G
 UD4ilfJtK5paNYOSPrKnwb+Q16ledDiPcjuz7LQQVyHtLfN25ixZnVe+q2Y8xigLt3P1
 UwzyraH1SZfWfy35+Qx6BzkYqpNXHmGmoA9JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723063839; x=1723668639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IquL634a2kJ/HsFO7fKz4yJPOx5IOkDbAzl8bsB4qiA=;
 b=uTsisC+DQMD0pZ3+cmiyqWVWQmW4OL5tRtBiB98Y6KuOZHzglFb0aQbtM4Mt1o35c6
 newbrGaAhrEtSW/mYhk92XrcBcGqMGWDVX7Wfvw+UJsE1Lfjjab+G2em2+NOshS44Qon
 kEu+72Y1xUYawuHasjpAZ7nsRk8bTus1/KhTym7LzYkPJEhekEEFDaYVSIXXHeucz2Uw
 UwqHdaiSmobRmeDE4AQ0aQIxq1iecY3f4PxZYZNxgb4Km4laiUN6QI2QSeV9MMKI3YvV
 co/YXoOuydt3U2KhkBSkZfbWB0ZSw9GEsrNnir5OYyxkU6gha0r/Jmgfb45P82GIhqrv
 iUig==
X-Gm-Message-State: AOJu0YzRcJ6udkHr6dE/OqzMT9X2c48U60GPyEyCRlkG6kDcjPIWAlW/
 0HeArl6xgnKvtnpaIv+FWD6IXd8yK0we3Q/l/d4SxQ0di+CM7FOGY9MZh+tAbc2yZGZ9liuhNek
 =
X-Google-Smtp-Source: AGHT+IHtMnxSQPm0ttzG7xugZfgHotVNkNkAoSuj275IwmD7u9IIZDbuMwJDIs1xcCEe3jUp+mgYUw==
X-Received: by 2002:a5d:985a:0:b0:81f:8665:da0a with SMTP id
 ca18e2360f4ac-822483e8b2dmr313527139f.1.1723063839069; 
 Wed, 07 Aug 2024 13:50:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6988421sm2912581173.32.2024.08.07.13.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:50:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Eddie James <eajames@linux.ibm.com>, Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Edwards <cfsworks@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/6] bootstd: sunxi: Migrate to standard boot
Date: Wed,  7 Aug 2024 14:50:26 -0600
Message-Id: <20240807205032.3745680-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Aug 2024 01:41:15 +0200
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


Simon Glass (6):
  sunxi: Drop BOOTCMD_SUNXI_COMPAT
  sunxi: Add a bootmeth for FEL
  sunxi: Move to bootstd
  sunxi: Drop old distro boot variables
  env: Provide a work-around for unquoting fdtfile
  sunxi: Move to text environment

 Makefile                                      |   1 +
 arch/arm/Kconfig                              |   2 +-
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h |  10 -
 arch/arm/mach-sunxi/Kconfig                   |  12 -
 arch/arm/mach-sunxi/dram_sun4i.c              |   4 -
 board/sunxi/sunxi.env                         | 138 ++++++++++
 boot/Kconfig                                  |  14 ++
 boot/Makefile                                 |   1 +
 boot/bootmeth_fel.c                           |  81 ++++++
 configs/icnova-a20-swac_defconfig             |   1 -
 doc/usage/environment.rst                     |  12 +
 include/configs/sunxi-common.h                | 238 ------------------
 12 files changed, 248 insertions(+), 266 deletions(-)
 create mode 100644 board/sunxi/sunxi.env
 create mode 100644 boot/bootmeth_fel.c

-- 
2.34.1

