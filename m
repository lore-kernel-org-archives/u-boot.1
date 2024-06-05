Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5EEC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5774882DF;
	Wed,  5 Jun 2024 05:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d3hQAT/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4907D88297; Wed,  5 Jun 2024 05:25:30 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190458785E
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7eb35531c6bso15996039f.0
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717557927; x=1718162727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6S59EENzJ1s97GN6BoOOEem9KKM8QOxqYVqBZ2setqs=;
 b=d3hQAT/ozTLqO9zFN8TNFWEuwaP/9PHGG0kav04vX2Vhcv13EBMGUpqYldy7BvxF+D
 MyxjYMKE03LN46rByqfhJljeKSIxtU3T/MT6AFkgvu1YPcv035IPmno0/jFuoO0YgKYl
 HiB0gjZIO4iw0FwvrCUIlTYU6Xa6VXmlClOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717557927; x=1718162727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6S59EENzJ1s97GN6BoOOEem9KKM8QOxqYVqBZ2setqs=;
 b=nGpQbzUl26gc0zqaPl+b/JJzlNayvkMi/0QSLwmUkbpPD6DbY+JfCgxj6CDWXnHvwM
 NH9YMIFCXqlcnDjqgynh84mpJQcpC7sMlLbhvDO0YlNBM/33XoDWY0xg1K5XqNIFx+ic
 G6S5lru8XMkh2ix9TWKs5ahue7EblBpvKoAwgAsVnImZ48bGe8BepGtRBvzjKI3HIzMp
 ELz0OUd9CQT+RZQwNtmA2+zQyejBVmYrZzqgkvWxMFdnMVWgcV8muz41bAIzpZBY+tps
 gMtHid57Af73TXCAM7I5ZwlcGpXSvIJkotan6tcNX9eo63ozotXvI8t0A0lt1BTjJ+62
 q5AA==
X-Gm-Message-State: AOJu0YxuBnH89aDjEdtE/ufo2FlLXZu9u4EtkbU0qnmk2MkknfldcO9c
 tavhLHXRRRO+7M4NYw42l7NY0ZJX/419hVf7JIYUE/eSwm5U9OE2RKZWSqqSSGOKMsc1DAZ73Je
 qow==
X-Google-Smtp-Source: AGHT+IE0ZapxuaTOGV2IsBWSIFMPAa/gJXVxNioaP6d4Cro2eQfXun5brOxAgFf5Z5SZjkq6tq1Oug==
X-Received: by 2002:a05:6e02:1387:b0:374:984b:1045 with SMTP id
 e9e14a558f8ab-374b1376100mr11767305ab.10.1717557926596; 
 Tue, 04 Jun 2024 20:25:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:25:26 -0700 (PDT)
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
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 William Wu <william.wu@rock-chips.com>, huang lin <hl@rock-chips.com>,
 shengfei Xu <xsf@rock-chips.com>
Subject: [PATCH 0/9] Bug-fixes for a few boards
Date: Tue,  4 Jun 2024 21:25:12 -0600
Message-Id: <20240605032521.1142768-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 05:25:59 +0200
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
working again. It also provides a fix (revert) for Beaglebone Black and
a devicetree fix for coral (x86).


Simon Glass (9):
  nvidia: nyan-big: Disable debug UART
  tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
  rockchip: veyron: Add logging for power init
  power: regulator: Handle autoset in regulators_enable_boot_on()
  fdt: Correct condition for bloblist existing
  spl: Allow ATF to work when dcache is disabled
  rockchip: bob: kevin: Disable dcache in SPL
  regulator: rk8xx: Fix incorrect parameter
  Revert "arm: am335x: Enable SPL_OF_CONTROL on some configs"

 board/google/veyron/veyron.c               | 27 ++++++++++------------
 common/spl/spl_atf.c                       |  3 ++-
 configs/am335x_boneblack_vboot_defconfig   |  1 -
 configs/chromebook_bob_defconfig           |  1 +
 configs/chromebook_kevin_defconfig         |  1 +
 configs/nyan-big_defconfig                 |  1 -
 drivers/power/regulator/regulator-uclass.c |  2 +-
 drivers/power/regulator/rk8xx.c            |  2 +-
 lib/Kconfig                                |  8 +++----
 lib/fdtdec.c                               | 12 ++++++++--
 10 files changed, 32 insertions(+), 26 deletions(-)

-- 
2.34.1

