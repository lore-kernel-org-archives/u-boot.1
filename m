Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3352C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38AB088872;
	Mon, 15 Jul 2024 12:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WrJsyOPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2102E88820; Mon, 15 Jul 2024 12:14:03 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF65C8882D
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42795086628so27714365e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038438; x=1721643238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mtMJPapFzKqHAx24V7SDVOcFpOivJtkSfu8Nh0s4ENQ=;
 b=WrJsyOPXT50KOXVMG+DOqy3ONKLXqIvFJ2ycEIekofEa5jwpP/SnmtLRHmE8rj4YBg
 CxwDTCxH/CImug7oCOUA85l9aijhDIAj40jMFdwhFswiRDcAvMX3AW+BsP2VV/CxSlra
 /eWVchHIMGQMI13RAmoH5p53HKq/Xtwc/HGi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038438; x=1721643238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtMJPapFzKqHAx24V7SDVOcFpOivJtkSfu8Nh0s4ENQ=;
 b=TfMRxkxK7EnZD747SiWn9wq2cMOxqW9EdaljxVfqk71oplZaDJfFJltugP6GL47Z+E
 FTvr4zdtbE9oS1I1+fZlwaZDziOY4aYULii4fA6DzQj94Z1h+agEGCm3rAMro6vMiMWM
 2HoG7iUBuDEPSKUYORzl8I06lHUHdFG+KYM2JevEa81RD5kOoK0q8f/rnH5H8tMo3p1d
 e94rhocBEkvyucpOZv2Q1IIYZdEJ4CBKsQKRZk0OmzYuoTP8kIB1lVwDPc6hHB5CNhS8
 noyfnnNNYc8bArB8KoJ4KvR/qsGzr3Q5fln9vUTqt1JrwK6wHWMLZngRvjQcHbS6WEd1
 ayPQ==
X-Gm-Message-State: AOJu0Yz4nec2jM0MhGRMWDlTHUoDi9WBRr3DNsuz8504aADxFwAIrmOL
 rs7mv8I7lHVLGADjD35FezUNsUXHPy3MT/+8oBOetXBslcmOiA6BtFf+nhhDjyWoh/3bIdPMQyw
 =
X-Google-Smtp-Source: AGHT+IEaoPYQ2maocL7Ur/iN7Am/FG5Ha+RUOItSqQhfLrXS53CGH/ptTL+Ld2PIbQAXUkqmiiFwOg==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-426707d8a90mr131270065e9.16.1721038437853; 
 Mon, 15 Jul 2024 03:13:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:13:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Dahl <ada@thorsis.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, E Shattow <lucent@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Jaewon Jung <jaewon8868@gmail.com>,
 Janne Grunau <j@jannau.net>, Joao Marcos Costa <jmcosta944@gmail.com>,
 John Clark <inindev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 00/13] doc: Add documentation for bootmeths
Date: Mon, 15 Jul 2024 11:13:41 +0100
Message-Id: <20240715101354.97895-1-sjg@chromium.org>
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

This series adds some documentation about most of the bootmeths and
tidies up a few minor areas.

It also fixes a bug in network-based booting of a script.


Simon Glass (13):
  MAINTAINERS: Rename BOOTDEVICE
  doc: Move bootstd into its own directory
  doc: Add a description for bootmeth_extlinux
  doc: Add a description for bootmeth_pxe
  doc: Add a description for bootmeth_qfw
  doc: Add a description for bootmeth_cros
  doc: Add a description for bootmeth_sandbox
  bootstd: Tidy up comments on the boothmeth drivers
  bootstd: Correct handling of script from network
  doc: Add a description for bootmeth_script
  doc: Add a link to VBE from the bootstd docs
  boot: Correct indentation in efi bootmeth
  doc: Describe the bootstd settings

 MAINTAINERS                                   |  4 +-
 boot/bootmeth_efi.c                           |  3 +-
 boot/bootmeth_extlinux.c                      |  2 +-
 boot/bootmeth_qfw.c                           |  2 +-
 boot/bootmeth_sandbox.c                       |  2 +-
 boot/bootmeth_script.c                        | 53 +++++++++++--------
 doc/board/starfive/milk-v_mars_cm.rst         |  2 +-
 doc/develop/board_best_practices.rst          |  2 +-
 doc/develop/bootstd/cros.rst                  | 33 ++++++++++++
 doc/develop/bootstd/extlinux.rst              | 27 ++++++++++
 doc/develop/bootstd/index.rst                 | 15 ++++++
 .../{bootstd.rst => bootstd/overview.rst}     | 38 +++++++++----
 doc/develop/bootstd/pxelinux.rst              | 27 ++++++++++
 doc/develop/bootstd/qfw.rst                   | 21 ++++++++
 doc/develop/bootstd/sandbox.rst               | 18 +++++++
 doc/develop/bootstd/script.rst                | 49 +++++++++++++++++
 doc/develop/index.rst                         |  2 +-
 doc/usage/cmd/bootdev.rst                     |  2 +-
 doc/usage/cmd/bootflow.rst                    |  2 +-
 doc/usage/cmd/bootmeth.rst                    |  2 +-
 doc/usage/environment.rst                     |  2 +-
 21 files changed, 263 insertions(+), 45 deletions(-)
 create mode 100644 doc/develop/bootstd/cros.rst
 create mode 100644 doc/develop/bootstd/extlinux.rst
 create mode 100644 doc/develop/bootstd/index.rst
 rename doc/develop/{bootstd.rst => bootstd/overview.rst} (96%)
 create mode 100644 doc/develop/bootstd/pxelinux.rst
 create mode 100644 doc/develop/bootstd/qfw.rst
 create mode 100644 doc/develop/bootstd/sandbox.rst
 create mode 100644 doc/develop/bootstd/script.rst

-- 
2.34.1

