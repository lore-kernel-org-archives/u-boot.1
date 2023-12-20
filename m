Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B013C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 18:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA46187727;
	Wed, 20 Dec 2023 19:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S06dLZkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D2D877FE; Wed, 20 Dec 2023 19:21:29 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42DE875E9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 19:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ce3281a307so592810b3a.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703096485; x=1703701285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AyYfOkBu6JDpBRo0mXrvWtFNdoARoCI7kzak2bR8alQ=;
 b=S06dLZkmytLKNwrAxVszUXw59oYfXp50c/rv97D7+BydR/t6c7BoYD5EP7uRdX5Vjq
 ekz8n51q4vK50SFXvUu6JhGJ4hZwI+J5Waw2euklgZeDusj0RAYblslP4O48yBlxuiL7
 0kgGkap+MNGCV87+PIkC/0/ECgyXVZm9m4oKxshi/Lls11+FBO1uDSd9DvWUBMufhm5Z
 kl0b0bzuP2Y2tPZNaqJoVXeQnT3fCQG4oMwytjWNCS9/uWgAbYMfrkCQOYgmH3bHLH/g
 B1qOh8bb51NHt/et3cNCTLg5UyG1CKhgX+KMNYtKpixU3SEtUfwhA5MNHXEIV2pYPbKg
 WM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703096485; x=1703701285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyYfOkBu6JDpBRo0mXrvWtFNdoARoCI7kzak2bR8alQ=;
 b=K7NTgLD8gXW88ErUGLPt47uEFCfbIr5nKcTAsD0UlmOTE8BjZ22Wk1WcL1ZDWjos14
 4ZMJHHGNfXYZC9Ix1NeGVV/yWIv5iE2YLloswq1kNqTEORt+bf1DOUVevNIbqsNmt3KS
 lDIboG2OcWlDOYPpqE7GWQO6zbJ6UlSWyjJGMf7nwIE5N+jDvSdBZ9kieLDg4ssqFJJa
 EXBi4OZU5NJ2ZShept8NdpiSN5yz+c6G3EmjYOc4VYKF+lcl2jab1EBQwhpqqZF70294
 3/lOAEvV+EBiPDLn/vOHtMBJKbfRvt29qY7Zpn06UEeqVkvv9uNdjaKwzEQBmm/owPoH
 oiSA==
X-Gm-Message-State: AOJu0YwT9CxwFCdMuS8vlmB+n3eY8bM0/DGABkXj6mQOzYThoPQW1sah
 l4mYCuqZQhzwOJaw1S02X3Q7oNJcAAo=
X-Google-Smtp-Source: AGHT+IGTVVHokgTENLby+50F/Tm0JuGa5AtKUGZ0fSwNV6p5XNyWo6rg7AU61t5dWA5wGZQ5tMDamw==
X-Received: by 2002:a05:6a00:2d86:b0:6d9:4573:a572 with SMTP id
 fb6-20020a056a002d8600b006d94573a572mr3390617pfb.1.1703096484818; 
 Wed, 20 Dec 2023 10:21:24 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4f39:a3af:6ee6:81ee])
 by smtp.gmail.com with ESMTPSA id
 y186-20020a6364c3000000b005cd9bc22bdfsm91683pgb.87.2023.12.20.10.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 10:21:24 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-next-20231220
Date: Wed, 20 Dec 2023 15:21:19 -0300
Message-Id: <20231220182119.1444897-1-festevam@gmail.com>
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

Hi Tom,

Please pull this u-boot-imx material targetted for 'next', thanks.

The following changes since commit f7655af980dc376783bbdac833e450a86e3255f4:

  Merge tag 'u-boot-amlogic-next-20231220' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next (2023-12-20 08:34:12 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20231220

for you to fetch changes up to 8a72d193cf15cf0d6936886db4b2dd75956fb4d8:

  colibri-imx8x: configure usb hub to bypass mode (2023-12-20 15:04:46 -0300)

u-boot-imx-next-20231220
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19043

- Put the USB hub out of reset on colibri-imx8x
- Fix VDDx brownout interrupt register of i.MX23/i.MX28
- Fix Phytec imx8m SoM detection
- Add TPM support for gw72xx boards

----------------------------------------------------------------
Andrejs Cainikovs (3):
      apalis-imx8: remove -u-boot.dtsi include
      colibri-imx8x: remove -u-boot.dtsi include
      colibri-imx8x: configure usb hub to bypass mode

Cody Green (1):
      mxs: Fix VDDx brownout interrupt disable/enable

Tim Harvey (3):
      arm: dts: imx8mm-venice-gw72xx: add TPM device
      arm: dts: imx8mp-venice-gw72xx: add TPM device
      configs: imx8m{m, n, p}_venice_defconfig: add arch_misc_init

Yannic Moog (5):
      board: phytec: imx8m_som_detection: change phytec_imx8m_detect return type
      board: phytec: imx8m_som_detection: fix uninitialized pointer bug
      board: phytec: phytec_som_detection: fix eeprom_data zero check
      board: phytec: som_detection: move definitions to source file
      board: phytec: phytec_som_detection: fix uninitialized bug

 arch/arm/cpu/arm926ejs/mxs/spl_power_init.c      |  8 +++--
 arch/arm/dts/fsl-imx8qm-apalis.dts               |  1 -
 arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi     | 15 ++++++++
 arch/arm/dts/fsl-imx8qxp-colibri.dts             |  3 --
 arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi |  7 ++++
 arch/arm/dts/imx8mm-venice-gw72xx.dtsi           | 10 +++++-
 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi |  9 +++++
 arch/arm/dts/imx8mp-venice-gw72xx.dtsi           |  9 ++++-
 board/phytec/common/imx8m_som_detection.c        | 40 ++++++++++++++++++---
 board/phytec/common/imx8m_som_detection.h        | 34 +-----------------
 board/phytec/common/phytec_som_detection.c       | 46 ++++++++++++++++++++++--
 board/phytec/common/phytec_som_detection.h       | 38 --------------------
 configs/colibri-imx8x_defconfig                  |  1 +
 configs/imx8mm_venice_defconfig                  |  1 +
 configs/imx8mn_venice_defconfig                  |  1 +
 configs/imx8mp_venice_defconfig                  |  1 +
 16 files changed, 137 insertions(+), 87 deletions(-)
