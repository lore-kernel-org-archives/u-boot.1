Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41503C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D647186E2F;
	Mon, 13 Nov 2023 04:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ieYm3p5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B14286F1A; Mon, 13 Nov 2023 04:00:13 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F75686A43
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7ac61c58d85so173021839f.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844406; x=1700449206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TGGAhuv1ao7PDHIsXFlwhrpH6JEyYjCaG2p5iKBld00=;
 b=ieYm3p5JBm8JjNFUeJqJd42PXaS3WYsdal0cYGIR+84NgjGXxq9ZqFduSWz6Hquh7/
 yTWZVU4rR8/JIdVG6B5XCJcQYywjS7I1/w4dw6rS4/8XTV9nBP+1eeRj19LzZDTMoa/Z
 tbDqxpq3otnFhRcuU3lkAms7qFzDS8bzBHBPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844406; x=1700449206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGGAhuv1ao7PDHIsXFlwhrpH6JEyYjCaG2p5iKBld00=;
 b=YKoPJWU/N9ZzXblvBXO4SZ/KH8Uowf41Oa7dTxVDtbVvH6jFGe+nPnyLs4INiPf+oO
 pOr/tL2MLnl93RtzgZzf/kYDdyJBkeRum05pSLgIN1S0odA3Tj8bw8fdI5jfi4o7GVEn
 GVqHazqsJq5m7j7wEB1U3xpSxIvXFl9PWtj0Gk8mGLYHL+UiVRdVZxoH5C7Dm4QUzWyP
 cazT3xJbfHJ2qs/UmYLCzIAM4AdMXJMowqPdYP+p8dJkBj0BTjFp4IG9dK1IZ03HFXyc
 4sSEX3byu1ZEnA/6gS2fY3weZhJJrlp5HbaIoMiOtsochonvKoLiNca9tkGpD8g5+YOd
 ++oA==
X-Gm-Message-State: AOJu0YzM5CtvNSsEiIqvuIF+lTVwohuPmfCMx2cSkqSrMhWBPwJCEZPr
 0WrbLBgm5akYyYqajrfTkKuWuNQPAtYgse1J1s33CA==
X-Google-Smtp-Source: AGHT+IHU1QE61o46WmxygpOuB4smHvqEh/+H/Pz7/cZT6qjO9fp990CastmB1/8L4r/tGZyvbgafDg==
X-Received: by 2002:a05:6e02:1d13:b0:359:3d9a:2837 with SMTP id
 i19-20020a056e021d1300b003593d9a2837mr9768065ila.2.1699844405827; 
 Sun, 12 Nov 2023 19:00:05 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Breno Lima <breno.lima@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Mike Frysinger <vapier@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
Subject: [PATCH 0/9] sysinfo: Expand sysinfo with some more banner information
Date: Sun, 12 Nov 2023 19:58:20 -0700
Message-ID: <20231113030001.240020-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

The show_board_info() function was adjusted to weak so that it could be
entirely replaced with a board-specific implementation.

The intended way for boards to provide their own information is via a
sysinfo driver. But currently there is no way to show anything other
than the model name.

This series adds support for showing a few more items, in a way that is
easy for boards to extend.

Since there is already a weak checkboard() function, we don't need to
have two levels of weak function here. So this series drops the weak
attribute from show_board_info()

Existing boards will see a slight change in output, in that the model
name will appear first, before any custom output. If that is a problem,
then the solution is to implement a sysinfo driver for the board.


Simon Glass (9):
  board: Move show_board_info() comment to header file
  meson: Use checkboard() instead of show_board_info()
  turris: Use checkboard() instead of show_board_info()
  solidrun: Use checkboard() instead of show_board_info()
  toradex: Use checkboard() instead of show_board_info()
  udoo: Use checkboard() instead of show_board_info()
  Revert "generic-board: make show_board_info a weak function"
  sysinfo: Allow displaying more info on startup
  x86: coreboot: Add a sysinfo driver

 arch/arm/mach-meson/board-info.c              |  2 +-
 arch/x86/cpu/coreboot/Kconfig                 |  2 +
 arch/x86/dts/coreboot.dts                     |  4 +
 board/CZ.NIC/turris_mox/turris_mox.c          |  2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c      |  2 +-
 board/coreboot/coreboot/Makefile              |  1 +
 board/coreboot/coreboot/coreboot.c            | 44 ---------
 board/coreboot/coreboot/sysinfo.c             | 89 +++++++++++++++++++
 board/solidrun/mx6cuboxi/mx6cuboxi.c          |  7 +-
 board/toradex/apalis-imx8/apalis-imx8.c       |  2 +-
 board/toradex/apalis-tk1/apalis-tk1.c         |  2 +-
 board/toradex/apalis_imx6/apalis_imx6.c       |  3 +-
 board/toradex/apalis_t30/apalis_t30.c         |  2 +-
 .../toradex/colibri-imx6ull/colibri-imx6ull.c |  2 +-
 board/toradex/colibri-imx8x/colibri-imx8x.c   |  2 +-
 board/toradex/colibri_imx6/colibri_imx6.c     |  3 +-
 board/toradex/colibri_imx7/colibri_imx7.c     |  2 +-
 board/toradex/colibri_t20/colibri_t20.c       |  2 +-
 board/toradex/colibri_t30/colibri_t30.c       |  2 +-
 board/toradex/colibri_vf/colibri_vf.c         |  2 +-
 board/toradex/common/tdx-common.c             |  2 +-
 board/toradex/common/tdx-common.h             |  1 +
 board/udoo/neo/neo.c                          |  2 +-
 common/board_info.c                           | 80 +++++++++++------
 drivers/sysinfo/Kconfig                       |  7 ++
 include/init.h                                | 11 +++
 include/sysinfo.h                             |  3 +
 27 files changed, 189 insertions(+), 94 deletions(-)
 create mode 100644 board/coreboot/coreboot/sysinfo.c

-- 
2.42.0.869.gea05f2083d-goog

