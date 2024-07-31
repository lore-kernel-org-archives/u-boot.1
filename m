Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DDEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227C788A40;
	Wed, 31 Jul 2024 16:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fk1D5zWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365FD88A3E; Wed, 31 Jul 2024 16:49:15 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07119889E3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-39626aee4easo33246075ab.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437351; x=1723042151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cS16QwSrkMYXhIPzqp5gLz4DD88VMNJeIVB+lu70IIY=;
 b=Fk1D5zWqEFUmmp1+KJGlpTZomyOWvY5xBtfoVQQPn169LbjNdEahlawNqdWvLogrsF
 xAZ7EZqEndhsBor3a47hutdOzJerOGV/jsrwJ6ikJvTfx7xiByc7R0eGkJcSJj0Hzifr
 oHEKHP1q6VTFA6rd6CHLcPLH38cjSp/PfIE9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437351; x=1723042151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cS16QwSrkMYXhIPzqp5gLz4DD88VMNJeIVB+lu70IIY=;
 b=HHkIdO0QfvSet2WgWf8MaAlJzcklaavf76kXE+WtsaJux9dbVqoZWojyAxQLseXDRa
 09/MuIewjI3jOmlWJ8szTPW9ihxH1aFmoitT0KfIkU6KuCazJ7jtodHwxrmwzT5hwe4O
 sbPwSkm+CYY1D/Tx/ItU9XlOSZLG6d/q3XFHdS+uioFUi5bM/K4JAh461RrKSEM0tPrH
 my+UDU8EKsfXlZ/gUl7Xd32WWsU/WZp37NRX8vEEDZF9QSOrFPYXL61r1VnoBd+E3Wy2
 jUIp0pQmni9pBaM5HiQO5apewI4eOoSLIGpigAnbIuDH9q6eHlNsZ9OmL0oUcIayR1TX
 3oog==
X-Gm-Message-State: AOJu0Yw41zWWohK3Q/4o8v1/Vl1GjpHFkFMk7GjP2hK++AHBn5wlPiyQ
 I3Qs0OVdfaEyFDF8517l/enDQSFkSNeHXTbJ2yGKBQl2ss3Vqk2ZMSxyi9cOgpITCy2A9olQe38
 =
X-Google-Smtp-Source: AGHT+IGNqwOMesJo7/YGObxsPWWXq7LKjfOTr8FYNUZPnVTPSGCfNyHBmh++Rir2RjI9OpxJWfC4+w==
X-Received: by 2002:a05:6e02:1fcd:b0:397:351b:2c0c with SMTP id
 e9e14a558f8ab-39aec4011f1mr184833185ab.17.1722437351628; 
 Wed, 31 Jul 2024 07:49:11 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 0/8] Bug-fixes for a few boards
Date: Wed, 31 Jul 2024 08:48:59 -0600
Message-Id: <20240731144908.795290-1-sjg@chromium.org>
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

This series includes fixes to get some rockchip and nvidia boards
working again. It also drops the broken Beaglebone Black config and
provides a devicetree fix for coral (x86).

Note that since this series fixes bugs, it is targeted at -master

Changes in v7:
- Reword the comment

Changes in v5:
- Move setting of pmugrf into the probe() function
- Drop patches previously applied

Changes in v4:
- Drop Fixes tag
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST
- Cut the patch down to bare bones
- Split out the refactoring into a separate patch

Changes in v2:
- Use 'phase' instead of 'stage'
- Add new patch to correct memory size in SPL
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

Simon Glass (8):
  mkeficapsule: Add a --version argument
  binman: Collect the version number for mkeficapsule
  binman: Deal with mkeficapsule being missing
  binman: Return failure when a usage() message is generated
  binman: Keep the efi_capsule input file
  fdt: Correct condition for bloblist existing
  rockchip: Ensure memory size is available in RK3399 SPL
  rockchip: Avoid #ifdefs in RK3399 SPL

 doc/mkeficapsule.1                  |  4 ++++
 drivers/ram/rockchip/sdram_rk3399.c | 35 ++++++++++++++---------------
 lib/fdtdec.c                        | 12 ++++++++--
 tools/binman/btool/mkeficapsule.py  |  3 ++-
 tools/binman/etype/efi_capsule.py   |  5 ++++-
 tools/mkeficapsule.c                | 10 +++++++--
 6 files changed, 45 insertions(+), 24 deletions(-)

-- 
2.34.1

