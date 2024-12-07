Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33DBE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC0C891CF;
	Sat,  7 Dec 2024 18:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdAt6I6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBD888FB4; Sat,  7 Dec 2024 18:25:58 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B91891C3
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-843df3c4390so97372039f.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592354; x=1734197154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bYgxCXl4/JEP0EgABUd5aUu5aD0xaGG1Be9Dk9/mUDM=;
 b=XdAt6I6gPt+uEXYnYd984uofaCnBsBjwtGeaq5jRE9lGvdEelpomudlPHIjkeLNX/M
 jUuzbge+DIdJ6TMe/iodn7LeTxXldpN3RRW+ZX5M35QrYgs5gqY6IOZg8YzEcO23D3NA
 1bALLdBsBweJ4jOfWpqqpsje5dcd0TTAlBsak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592354; x=1734197154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYgxCXl4/JEP0EgABUd5aUu5aD0xaGG1Be9Dk9/mUDM=;
 b=WmvTiD3fIvKOqFW3YSm6aGyiM28x3VwrnPKMAJFdsN1t+vt5tQOe3ClUnldqmw7Kpa
 rxPmHger/wZjWi+Bjkw9LhH4jvnnqsz7NB8fuTO3FHHXFFFScFZ/dhTubK6z+MwxT0vs
 Ws81RNAwsQNA4CcewSI3Gas1wEVeKdWMWMc5zcqbAfmuE4dFgXoxIJvetE3lekXXfrYi
 fVqL+q8HHWZmsCUFlk016Gg4uCDf76FJWbfmkO+Rc3dK3P8uyYzNlEYWEoUJQAerxgiG
 lkbofRNG5+hkZa54ILRdqphLTOWzD8Aijs/LEFRSQh9zYxeMvQoIWLXhNqUY4oHP4M8T
 mUgw==
X-Gm-Message-State: AOJu0YyN2o8MR/6ne8DvmyzQgzIdwmjahHfXP0TgmBQ3WsnM63ifh3kg
 UnIddlmYmR2k8GeX9H8xBl/ZtwPJMQKY4dQzUjFCZYOEeihq6wINBxsPMPeTY86GM+2iyqqdhjo
 =
X-Gm-Gg: ASbGncsABpUSYa/9WGFm4T+jnldZ2avhmqWMsWCiqciKVAQ7Z4/XRptFKtvPOYdcbED
 0wLmj+uG6n7XjwHNBpivc1/tRr/E6v0ucy2DzMBgsPYCh8ca5jRgPmKanzJV+K9ZUba50wcDZ3R
 EOGH4RjJFi0m5vG17kZSciQ3ofWHFtkr72EInq8jhIisvqUSFmLBrlt11NZ8qSf6vHGq0rgNL+R
 hqsN4MngyhK48VW5Rr9GLM8hfRuR+02KzbnTqQjdifmd3Lt5XpXlxkWPeeU7HBWbvQ2aMtfG641
 nroqsN7LWSI=
X-Google-Smtp-Source: AGHT+IGkeY9VDCbDzIG8+RiMmr8F56Lwv0C2YEAjaPOc93nY0Ya5ByyHkg4Rzr+RiiuN8a5a+e38tg==
X-Received: by 2002:a05:6602:2b0f:b0:843:eb89:9655 with SMTP id
 ca18e2360f4ac-8447e35dd97mr838746639f.15.1733592354077; 
 Sat, 07 Dec 2024 09:25:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:25:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>,
 Gary Bisson <bisson.gary@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 00/19] vbe: Series part E
Date: Sat,  7 Dec 2024 10:23:53 -0700
Message-Id: <20241207172412.1124558-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Dec 2024 18:29:08 +0100
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


This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
fatures are available in VPL.

Changes in v3:
- Add new patch to avoid size growth in spl_mmc_find_device() debug
- Use strlcpy() instead of strncpy()
- Rebase to master

Changes in v2:
- Add field names into the message
- Fix 'depends on SPL' to depend on TPL
- Depend on TPL/VPL as well
- Drop patch 'serial: ns16550: Allow clocks to be missing'

Simon Glass (19):
  spl: mmc: Avoid size growth in spl_mmc_find_device() debug
  image: Add a prototype for fit_image_get_phase()
  boot: Allow FIT to fall back from best-match option
  bootstd: Avoid sprintf() in SPL when creating bootdevs
  boot: Respect the load_op in fit_image_load()
  malloc: Show amount of used space when memory runs out
  malloc: Provide a simple malloc for VPL
  Support setting a maximum size for the VPL image
  spl: Report a loader failure
  spl: Allow serial to be disabled in any XPL phase
  spl: Support a relocated stack in any XPL phase
  spl: Drop use of uintptr_t
  spl: Drop a duplicate variable in boot_from_devices()
  spl: Add some more debugging to load_simple_fit()
  spl: lib: Allow for decompression in any SPL build
  boot: Allow use of FIT in TPL and VPL
  lib: Allow crc8 in TPL and VPL
  boot: Imply CRC8 with VBE
  hash: Plumb crc8 into the hash functions

 boot/Kconfig                  | 71 ++++++++++++++++++++++++++++++++++-
 boot/bootdev-uclass.c         | 10 ++++-
 boot/image-fit.c              | 29 ++++++++------
 common/hash.c                 |  8 ++++
 common/malloc_simple.c        |  3 +-
 common/spl/Kconfig.vpl        | 17 +++++++++
 common/spl/spl.c              | 15 +++++---
 common/spl/spl_atf.c          | 36 +++++++++---------
 common/spl/spl_fit.c          | 12 +++++-
 common/spl/spl_legacy.c       |  8 ++--
 common/spl/spl_mmc.c          |  6 ++-
 configs/sandbox_vpl_defconfig |  2 +
 include/image.h               | 16 +++++++-
 include/spl.h                 | 28 +++++++-------
 include/u-boot/crc.h          |  3 ++
 lib/Kconfig                   | 53 ++++++++++++++++++++++++++
 lib/Makefile                  | 12 +++---
 lib/crc8.c                    |  6 +++
 18 files changed, 267 insertions(+), 68 deletions(-)

-- 
2.34.1

