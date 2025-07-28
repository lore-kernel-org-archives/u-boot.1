Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38067C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A39982F6F;
	Mon, 28 Jul 2025 16:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JoF0URZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E43682E26; Mon, 28 Jul 2025 16:12:17 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1DED82CA4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antoine.picard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B3B8443A1;
 Mon, 28 Jul 2025 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1753711933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XT90lEFd6ewoCYlS1nIectOdFTGuQS3o0Vo+V20TKC0=;
 b=JoF0URZU1m08pflY17hE548qxNbDSPEG1eFI4jLSH+GOmjUlkjQrbqVQE69je/M+TPtHD3
 uKVLzlLTekqZoxiqAGbnRqRxnSeXf9kpN2BccJaLUYbpmo61iyAAoWNqhlWy4pKJ4c/IUn
 7+irjvGdU0uMo5gMJaSYykOOc3C7d8H5RuyyNRx4hsz35MkNC/e+Ub9jP8LIZ3DFm4PZww
 oB2ErIxhPIdJe+cXhjntKIAq3p5WwxFv4U3uGRAVveXgKn3XeWW7A9SydwvZ3nLRRZtfMb
 OmVmiyIDhXySmFtVjtLacgt0S1SAva/TD3IyAMhPeXp6aveivaFAdlByRYO42Q==
From: Antoine Picard <antoine.picard@bootlin.com>
To: u-boot@lists.denx.de
Cc: antoine.picard@bootlin.com
Subject: [PATCH u-boot v1 0/2] Add initial support for the i.MX93 11x11
Date: Mon, 28 Jul 2025 16:12:06 +0200
Message-ID: <20250728141209.92123-1-antoine.picard@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhhtohhinhgvucfrihgtrghrugcuoegrnhhtohhinhgvrdhpihgtrghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfedvtdfhveekgeekgfdvjeegvedttefgledtgedtgfehtefhheegleetudetgeegnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegrnhhtohhinhgvqdgirffuqddufedqleefjedtrddrpdhmrghilhhfrhhomheprghnthhoihhnvgdrphhitggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtoheprghnthhoihhnvgdrphhitggrrhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: antoine.picard@bootlin.com
X-Mailman-Approved-At: Mon, 28 Jul 2025 16:13:10 +0200
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

This series introduces initial support for the i.MX93 11x11 FRDM
development board
in U-Boot. It includes:

- Device tree files tailored for the board.
- Board configuration header defining memory layout and basic hardware
addresses.
- Defconfig and Kconfig entries to enable building for the new board.

A minimal working configuration has been tested on the hardware but
without secure os. 

Feedback and suggestions are welcome.

Signed-off-by: Antoine Picard <antoine.picard@bootlin.com>

Antoine Picard (2):
  arm: dts: imx93: add device tree for imx93-11x11-frdm board
  board: freescale: add initial support for imx93_frdm board

 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi     |   53 +
 arch/arm/dts/imx93-11x11-frdm.dts             |  574 +++++
 arch/arm/mach-imx/imx9/Kconfig                |    6 +
 board/freescale/imx93_frdm/Kconfig            |   19 +
 board/freescale/imx93_frdm/MAINTAINERS        |    5 +
 board/freescale/imx93_frdm/Makefile           |   16 +
 board/freescale/imx93_frdm/imx93_frdm.c       |  350 +++
 .../freescale/imx93_frdm/lpddr4x_2gb_timing.c | 1996 ++++++++++++++++
 .../imx93_frdm/lpddr4x_ecc_2gb_timing.c       | 1997 +++++++++++++++++
 board/freescale/imx93_frdm/spl.c              |  201 ++
 configs/imx93_11x11_frdm_defconfig            |  158 ++
 include/configs/imx93_frdm.h                  |   27 +
 13 files changed, 5403 insertions(+)
 create mode 100644 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx93-11x11-frdm.dts
 create mode 100644 board/freescale/imx93_frdm/Kconfig
 create mode 100644 board/freescale/imx93_frdm/MAINTAINERS
 create mode 100644 board/freescale/imx93_frdm/Makefile
 create mode 100644 board/freescale/imx93_frdm/imx93_frdm.c
 create mode 100644 board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
 create mode 100644 board/freescale/imx93_frdm/lpddr4x_ecc_2gb_timing.c
 create mode 100644 board/freescale/imx93_frdm/spl.c
 create mode 100644 configs/imx93_11x11_frdm_defconfig
 create mode 100644 include/configs/imx93_frdm.h

-- 
2.43.0

