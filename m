Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95D2CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE783881C1;
	Sat, 21 Sep 2024 16:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KNRhdHPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727DD88413; Sat, 21 Sep 2024 13:36:49 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAC488875
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 13:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so1958198f8f.1
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726918604; x=1727523404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OXdOxeAY/8iBMoAwZzHc9EXX/V5lNqgJizs3+MhkiYM=;
 b=KNRhdHPvc3H3Ue2mHBcz3zhuDVigEhfHfK8aGcFmp6yD5uoUX796fIR+P7nls7cn5n
 Y5wHGhhvqrRGD1eIz77kRO/yW2VFHy3AxwUeCoEkqVWjrWnoP87CZaEy2Jtl72F9Cs4N
 4mXzL7amZTHplvBbUomts4TlyFevfanKeR08c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726918604; x=1727523404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXdOxeAY/8iBMoAwZzHc9EXX/V5lNqgJizs3+MhkiYM=;
 b=eKWKQLYxqSnxSCS/Qj6jAHifINhmKQ6Oqe2U6k8oitiKdyFV5kdgTu57npWAO+rO35
 roDYPKeNz2+15DOXFqzkUkSlxQ3sOKNDUrjhArOMH2qaZTg882VDGioz9IMtCxvetU0l
 2IHnzEyNtz9CjUurFuPQZT/KFcw7xCtVuDwu2/46KWAOVnHHh7nvGPusyrv2ZlbuH38k
 9VykAk7IpEn7QeqevBb+1L38JRxUAOWhu4yWZqJ+6nSONsobZ676n8cxlMRb2gWpPRjc
 Cf9d1r1J0jAweAfBterXWEkF3GNP1Q/xc9t/sSr4UnGofdLLBuEYgwBrDRW8d0dILWR8
 1tjg==
X-Gm-Message-State: AOJu0YxW+Jm+Akciach+rQr1yePucfvHBByFymHCnCHjFpKqB3BQvo3w
 B/5cm+CYAqhUUEiFwxpq4DphO+v8+RpF/GC0G2A/ECZdfcPwz/JFbev56rlP2YFqQXhXnN6cV3g
 A64ss
X-Google-Smtp-Source: AGHT+IFuuvwMEW90+m/tQaV1p07v5E85ZR2cfpA1gi6xOm+vyzDg5uwC5J01UhBcGa6Lysf2sDuyRw==
X-Received: by 2002:a5d:62cb:0:b0:374:b9a1:28f with SMTP id
 ffacd0b85a97d-37a431ad5e0mr3359548f8f.43.1726918603706; 
 Sat, 21 Sep 2024 04:36:43 -0700 (PDT)
Received: from chromium.org (82-132-231-226.dab.02.net. [82.132.231.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800374sm19972134f8f.79.2024.09.21.04.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 04:36:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Gary Bisson <bisson.gary@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3 00/18] vbe: Series part E
Date: Sat, 21 Sep 2024 13:36:12 +0200
Message-ID: <20240921113634.319702-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 16:27:42 +0200
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
- Add the missing word 'not' into the commit message

Changes in v2:
- Add field names into the message
- Fix 'depends on SPL' to depend on TPL
- Depend on TPL/VPL as well
- Drop patch 'serial: ns16550: Allow clocks to be missing'

Simon Glass (18):
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
 boot/Makefile                 |  4 +-
 boot/bootdev-uclass.c         | 10 ++++-
 boot/image-fit.c              | 29 ++++++++------
 common/hash.c                 |  8 ++++
 common/malloc_simple.c        |  3 +-
 common/spl/Kconfig.vpl        | 17 +++++++++
 common/spl/spl.c              | 15 +++++---
 common/spl/spl_atf.c          | 36 +++++++++---------
 common/spl/spl_fit.c          | 12 +++++-
 common/spl/spl_legacy.c       |  8 ++--
 configs/sandbox_vpl_defconfig |  3 +-
 include/image.h               | 16 +++++++-
 include/spl.h                 | 28 +++++++-------
 include/u-boot/crc.h          |  3 ++
 lib/Kconfig                   | 53 ++++++++++++++++++++++++++
 lib/Makefile                  |  8 ++--
 lib/crc8.c                    |  6 +++
 18 files changed, 262 insertions(+), 68 deletions(-)

-- 
2.43.0

