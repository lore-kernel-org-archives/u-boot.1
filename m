Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B077C83030
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCFF81FEE;
	Tue,  1 Jul 2025 03:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TZmzDCpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BDD281FFC; Tue,  1 Jul 2025 03:42:24 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779868006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6fb0eb0f0fbso55268686d6.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334139; x=1751938939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LoC61TNnGCaB8eZaaLXZr0+KC2rDKpBkMK7i4yTt6v4=;
 b=TZmzDCpN8z4CIv0L7qTSt7ojrS4X0EZLiKDRTHY+4b5raAG1QncxP5mq0wAX8lmYHU
 12Ey4B4hkUQoJds//PoWsPyKSylM54t81mQ1+VRB52126BGq7mOU1Ea8z0IcYOpMzEeW
 /1S61oDoKBXPB5WS2u6hUqCKJETX7c1yLVscH3fVX/JUJ997fTMl96dnWATDUMgynJoX
 +uIvaI/xAVxjWadqjGof9F+C8pebQjOwi+532CzOElyiU8BYsMnyyxpQg32vGRhrcccN
 qeBgQqcsi5JuzLaJ6+6xAlnTSWXZhSB9TprC65OGYHocU8VMOe1Xwm8Ij5FyQA5nMDJa
 VLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334139; x=1751938939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LoC61TNnGCaB8eZaaLXZr0+KC2rDKpBkMK7i4yTt6v4=;
 b=bLKROCy/tmnWuOCLpGVXHuyJo7/ck8GM82LFGNKR/dE9FL89MTJV7Zr9994f/59tAJ
 yqhb+4dKaWELO8L91sSfQplltSTdHCADAhCdZCnzGywBK9KghSIdMYPOD91GRzproU7+
 xWYN29LLpAtndCsjgYD+tBkpydYOOWVPWaTNgnCJRsUBZoGs5sDv/9Grmb8rNFyPRZeY
 HL6eMJjg1t1qwWFqRWYZOdE7S1PmIqc2Yo5fO27+DNRCnNFOA7gbQcksbvdPbX44WiKH
 ZwCx5rhmy0DPoPBCGmrzHInTYOl5zWandw8SxixihkR/068CRIKOnr66K/G8Q2Cq0vTC
 6HjQ==
X-Gm-Message-State: AOJu0YwKLCLWmCpHb+jlfbcGG7QPWC68/RblqN0YyY5YIFoC6GZFMXpa
 4B64fIhlNSDmJAYa5KFcyn5Mn0Jg9fKu2I6wQrU8YFOIWVw7rBC9k2bU
X-Gm-Gg: ASbGncs+683pbrwJX75bsrAvOKeWwgdVgCi7lVJ/q3iUZYy3Buvte5E3GETNq8dfF84
 LsVTE0H5z7WDnAImFEFBEIuXBaGV3nM7hXqhsEYliKTJVUyxDw2N2ioMJZue3f13HtWAy+mfAx3
 ijfsOI9uLqOf5j1zxLLwHn8dVPO8wnS52KzjJxbJadP/Pc52XFCTqz2HghUcYMPnnIQfjVo1rkd
 pSpPmhkHz6asFnqiQDBJHjM95c/i8d+dcxpejEscJtqNJdjIzfaEC/5Zg0Pw1BSvNlaBnQYj/R+
 AvnooF2NkZMgcQogmML/+KB2cxz2BdCD3Z0fn2Gqxc4gvz9wMisaxFc0kXSMBvPNtIZtQFQLYXT
 E
X-Google-Smtp-Source: AGHT+IF6LXhHl8Ci9/d5Qne0ea3NOzLsBsWGD7Pd5nxhRGmS6PgiS7PRb2DubbafR/VMguJ3HDwI4g==
X-Received: by 2002:ad4:5de9:0:b0:6fa:fdb3:5879 with SMTP id
 6a1803df08f44-7010a95a8bfmr27797656d6.1.1751334139159; 
 Mon, 30 Jun 2025 18:42:19 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2c21:1591:6d18:6009])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772e434bsm77575106d6.67.2025.06.30.18.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 18:42:18 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250630
Date: Mon, 30 Jun 2025 22:42:15 -0300
Message-Id: <20250701014215.2011927-1-festevam@gmail.com>
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

Please pull from u-boot-imx/next, thanks.

The following changes since commit 490ae8ceae2d5999c9de863e014e463f5c1495a6:

  Revert the last two mach-k3 changes (2025-06-27 13:07:43 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250630

for you to fetch changes up to a14da5ed615de8ed1e6aea6d290a65bd9c678fe0:

  arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use common gpio.h (2025-06-29 10:08:10 -0300)

u-boot-imx-next-20250630
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26882

- Add capsule update support for i.MX8M EVKs.
- Fixes for Vybrid BK4 board.
- Use common gpio.h in i.MXRT.
----------------------------------------------------------------
Giulio Benetti (1):
      arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use common gpio.h

Lukasz Majewski (3):
      dts: pcm052: bk4: Use proper compatible for QSPI SPI-NOR memory
      config: nxp: vf610: Remove CONFIG_SYS_MALLOC_F_LEN
      arm: pinctrl: Define .mux_mask field for NXP's SoC

Peng Fan (5):
      imx8mp: evk: Add support for capsule update
      imx8mm: evk: Add support for capsule update
      imx8mn: evk: Add support for capsule update
      imx93: evk: Add support for capsule update
      imx8mq: evk: Add support for capsule update

 arch/arm/dts/imx8ulp-evk-u-boot.dtsi    |  1 -
 arch/arm/dts/imxrt1020.dtsi             |  1 -
 arch/arm/dts/imxrt1170.dtsi             |  1 -
 arch/arm/dts/vf610-pcm052.dtsi          |  4 ++--
 arch/arm/include/asm/arch-imxrt/gpio.h  |  9 +--------
 board/freescale/imx8mm_evk/imx8mm_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mn_evk/imx8mn_evk.c | 22 ++++++++++++++++++++++
 board/freescale/imx8mp_evk/imx8mp_evk.c | 23 +++++++++++++++++++++++
 board/freescale/imx8mq_evk/imx8mq_evk.c | 21 +++++++++++++++++++++
 board/freescale/imx93_evk/imx93_evk.c   | 21 +++++++++++++++++++++
 configs/bk4r1_defconfig                 |  1 -
 configs/imx8mm_evk_defconfig            | 19 +++++++++++++++++++
 configs/imx8mn_evk_defconfig            | 23 +++++++++++++++++++++++
 configs/imx8mp_evk_defconfig            | 15 +++++++++++++++
 configs/imx8mq_evk_defconfig            | 13 +++++++++++++
 configs/imx93_11x11_evk_defconfig       | 14 ++++++++++++++
 configs/pcm052_defconfig                |  1 -
 configs/vf610twr_defconfig              |  1 -
 configs/vf610twr_nand_defconfig         |  1 -
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c  |  1 -
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c   |  2 ++
 drivers/pinctrl/nxp/pinctrl-imxrt.c     |  1 +
 drivers/pinctrl/nxp/pinctrl-vf610.c     |  1 +
 23 files changed, 200 insertions(+), 18 deletions(-)
