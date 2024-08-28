Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D62C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CD588AB9;
	Wed, 28 Aug 2024 03:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kPixGxZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA19988A8B; Wed, 28 Aug 2024 03:45:49 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B834988AAA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81fe38c7255so395997739f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809544; x=1725414344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JTFS1ml1W1hw1phfknORflZnZj0X0SfPF+nQrlRvuxY=;
 b=kPixGxZ6/bz7qJVNfLnrD8o8lgPTP44IW/rEMgJpne/cBzb3n60pxFKYnhg/7Z9qhZ
 PusLuoNZJoQM+d4UOde3COVzkYC6Hpk+O24rLoe2lT52p0YoGYGufErdq+FtRnppOGIU
 Yfywu/z3oTsGGCzFHcv/qaZh7mOgt+MVn2NJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809544; x=1725414344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JTFS1ml1W1hw1phfknORflZnZj0X0SfPF+nQrlRvuxY=;
 b=rw0MST7PAl+A4ho8AJwJyMmbBhA1POKe13nRByhXV7FP9lxgIR7Yigt5YYbz+dZujH
 G91pa/mbBwthEJcTMncFsjglrNgbT3632Thq7ahHCx6fDZCRQic2MZArz9wNIKNm6hhn
 ozGePzUXbHDacVsSbzXhoMbz4s7gygZrb3t8sBw8SSV9Nos62yWBARrpLT4rYNp+6l1T
 Pjk7qFkDND/n9KMMQ99cAickLlL2LhqN4Znt0asTd4pTDd6kneWqCcsgec9hKT2nyJkL
 0npdVc3DevI++GA/KcGwBQnGslwEn9feSjgYCgR5ZdJdkzVkkLIQJUOTJyNtiB3HQOLN
 7rZw==
X-Gm-Message-State: AOJu0Yw7czIURF9dPRNIY1Y5zqR8LYHNpL4GBDir2VhD5FHA5FMFGt+y
 dUWhT7cEW8krX0VZ7bHzmhzEiWO97GjqdFPd6vm1O3Jg76qudATNeNln5xDVZTCYyj+aIviQ0pM
 =
X-Google-Smtp-Source: AGHT+IFVbZr2JHPJtg7C4yA5KCR+iWDlqfjflvQ98mzK96BV1SD4Ul+ggqBvgRwyYz6yhoAznkMqdQ==
X-Received: by 2002:a05:6602:1509:b0:825:20ed:c3f5 with SMTP id
 ca18e2360f4ac-82a03cafefamr80673339f.0.1724809544369; 
 Tue, 27 Aug 2024 18:45:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 00/18] vbe: Series part D
Date: Tue, 27 Aug 2024 19:45:19 -0600
Message-Id: <20240828014538.3322013-1-sjg@chromium.org>
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

This includes various patches towards implementing the VBE abrec
bootmeth in U-Boot.


Simon Glass (18):
  sandbox: Add missing header file
  bootstd: Add stub for bootdev_setup_for_sibling_blk()
  gzip: Correct function comment for gunzip()
  fdtdec: Support separate BSS for all XPL builds
  tiny-printf: Correct return values
  tpl: Support numbered aliases in device tree
  ram: Support driver model in TPL
  serial: Support debug UART in TPL
  armv8: Support not having separate BSS
  arm: cache: Drop a stale comment
  arm: Fix up a stale comment in sections.c
  mmc: Support driver model in TPL
  mmc: Add more debugging for SPL
  mmc: Log the error when init fails
  mmc: rockchip: Log some error returns
  mmc: rockchip: Allow clocks to be missing
  rockchip: mmc: Fix a missing colon
  rockchip: Provided SPL control over efuse presence

 arch/arm/cpu/armv8/u-boot-spl.lds   | 12 ++++++++++++
 arch/arm/lib/cache.c                |  2 --
 arch/arm/lib/sections.c             |  2 +-
 arch/sandbox/include/asm/sections.h |  1 +
 common/spl/spl_mmc.c                | 13 +++++++++++++
 drivers/core/Kconfig                |  8 ++++++++
 drivers/misc/Makefile               |  2 +-
 drivers/mmc/Kconfig                 | 12 ++++++++++++
 drivers/mmc/mmc.c                   |  2 +-
 drivers/mmc/rockchip_dw_mmc.c       | 10 ++++------
 drivers/mmc/rockchip_sdhci.c        | 11 +++++------
 drivers/ram/Kconfig                 |  9 +++++++++
 drivers/serial/Kconfig              |  7 +++++++
 include/bootdev.h                   |  8 ++++++++
 include/gzip.h                      |  6 ++++--
 lib/fdtdec.c                        |  2 +-
 lib/tiny-printf.c                   | 15 ++++++---------
 17 files changed, 93 insertions(+), 29 deletions(-)

-- 
2.34.1

