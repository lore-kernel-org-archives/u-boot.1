Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4007AC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 18:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7A188679;
	Mon, 10 Jun 2024 20:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nw5wDIwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D417C885B6; Mon, 10 Jun 2024 16:59:28 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 523B888476
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso18839355ab.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031565; x=1718636365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GPaTeeUCMOpio4yMkH8ou8Mbyj4dUUvAR9tnDS3rVEw=;
 b=nw5wDIwjHuQNqzsM76lkV8tJ/FYUoXoq1udbs+BFhvTcJVgXm/fYEQMNj9qTed3Uaa
 9C+soxoeSUDo7TvIcDnUHaHkdCogEZo3aPaOkzDxRFrJzgLXcftcEgcBJw7aEyKq6Fz6
 phSAkFV01bqNDF58OpJ1V3Cy4N0Ml8uuV1Qcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031565; x=1718636365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GPaTeeUCMOpio4yMkH8ou8Mbyj4dUUvAR9tnDS3rVEw=;
 b=TqOUIGWiqMaMYi5OO9AlT12vjAlPIC621CO6WHNjlEKk4QMxxvbRWbCyAE4ElT4H/n
 XzIjagkb0vcsZXQUmlBvUEXCZ5RMh6cOwG1tl/9P0bAJ0GeWpTqxY2KaQRcOnKmLrS4P
 MGqYUoanc62Dr8UMps7POHBupLVZrf0fvCgyMhtECHrqpE+xMgI51DpFriYZ9HM1U8d5
 4V6qG+qd1gk58hJE7Vf7u/+l7aYfAfF6O6Ub7KMVKlbgxPmCHUh2wB6acIigNIQK25qZ
 G/NN1moWoNHwBOAIx+OV1HW1hWaFRAyHO4kyVl1qk+WRAkib3ruZvs0/X0zvN9wyp2U0
 q06g==
X-Gm-Message-State: AOJu0YxonrNgC+8/sT6kiLbkIiniaNK3sktwGH57X16EtO2gIRUYax+i
 AT4O/4zAH4NO3qdeSVbQQStAkewd6wWm35OEdCJuVX6YdX2q5MEl7f6PX6X+tt7jScITw2ejfBU
 xSA==
X-Google-Smtp-Source: AGHT+IHNCnBdYb0WzE0emyGljGhPRoET6uxlsygMfkX2CxOdae0pp2OwzRvR++YjChat4157CTWzWA==
X-Received: by 2002:a92:c5c3:0:b0:375:932e:7e9c with SMTP id
 e9e14a558f8ab-375932e80bbmr57453995ab.19.1718031564545; 
 Mon, 10 Jun 2024 07:59:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Allen Martin <amartin@nvidia.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 0/9] Bug-fixes for a few boards
Date: Mon, 10 Jun 2024 08:59:11 -0600
Message-Id: <20240610145920.3302001-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 20:54:07 +0200
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

This series includes fixes to get some rockchip and nvidia boards
working again. It also drops the broken Beaglebone Black config and
provides a devicetree fix for coral (x86).

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too
- Remove the superfluous if() and drop the debug() as well
- Use 'phase' instead of 'stage'
- Add new patch to correct memory size in SPL
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

Simon Glass (9):
  nvidia: nyan-big: Disable debug UART
  tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
  rockchip: veyron: Add logging for power init
  power: regulator: Handle autoset in regulators_enable_boot_on()
  fdt: Correct condition for bloblist existing
  spl: Allow ATF to work when dcache is disabled
  rockchip: Ensure memory size is available in RK3399 SPL
  rockchip: bob: kevin: Disable dcache in SPL
  Drop the special am335x_boneblack_vboot target

 board/google/veyron/veyron.c               | 30 +++----
 board/ti/am335x/MAINTAINERS                |  1 -
 boot/Kconfig                               |  4 +
 common/spl/spl_atf.c                       |  3 +-
 configs/am335x_boneblack_vboot_defconfig   | 94 ----------------------
 configs/am335x_evm_defconfig               |  3 +-
 configs/chromebook_bob_defconfig           |  1 +
 configs/chromebook_kevin_defconfig         |  1 +
 configs/nyan-big_defconfig                 |  1 -
 doc/usage/fit/beaglebone_vboot.rst         | 21 +++--
 drivers/power/regulator/regulator-uclass.c |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c        | 49 ++++++-----
 lib/Kconfig                                |  4 -
 lib/fdtdec.c                               | 12 ++-
 14 files changed, 70 insertions(+), 156 deletions(-)
 delete mode 100644 configs/am335x_boneblack_vboot_defconfig

-- 
2.34.1

