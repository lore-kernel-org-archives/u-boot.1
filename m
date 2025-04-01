Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D487C36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A0081F28;
	Tue,  1 Apr 2025 09:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oDUl2wGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CBE81DE3; Tue,  1 Apr 2025 09:01:32 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0383C80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so40795085e9.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490889; x=1744095689;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H3eWv9TxtT4dAVKPSAGwi+x6nlozcvmF0C9mEuJ0A6o=;
 b=oDUl2wGVTgKvnF/1ApKLZ0ALyicvwqljva35b9NUgsTkF56e57yDThFFi8/LlnMQkI
 17bl+z02uLGun6JDQKz+1kfm1c6LXtAV5dgBRccM3Y3qeQST++/sY8NEpngHZN49xAuo
 lVdhmfMOgLnUvFmZz8HQZ/AZJEU/Hj2GfGI2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490889; x=1744095689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H3eWv9TxtT4dAVKPSAGwi+x6nlozcvmF0C9mEuJ0A6o=;
 b=UpUlEFbyQkIsVW3BDn81hJiZ4TnRR/2XYNOpqZZyHYTK+i/4xZq751B5gHDn51DEy/
 3OmksHQN2tE7JSpgiJFgpuDs1GlxZSEtqmFxb/tKlRG8z8Q1RfTYbn77ZvAjyOI6Ubg9
 mGKE+rjsWw4CzsjlvRB5jfijbFavKgYpSzDAneV4Ik5X4IMrS/YWOxcWtkok/36GGf/o
 mMzEirFxXpgAPzcZ/IFSzF3aiKrSHZuab+Mnruh+n3LMOkQmJDHgEjLgjORWnjxfINeh
 a2jVykD8t60eHg3oIptCxJqzzWuNxfDapbPDu7w9ARcYnw7bUvWJWUn6QhLfSR2gAtEO
 jmhQ==
X-Gm-Message-State: AOJu0YzeoFTHis4rSjNouGK3Kd35vJhdNSGB2wNcUTc5LgoWDG6O01yK
 CDzZZMIuZ8LE3fTPG9uzgfnRi3tlhFgQyjqOUNntEnfsuZ6v+yqkL+5j3YCPxzlTwMUBGYdc+Kz
 h
X-Gm-Gg: ASbGncvPAvoBgO3qCjVwPjrhyELEDnSygAdz0KDuWiNFpRcnEdMngQ43no54DqE4gcF
 B9Fnrx1gb8bJRxa7OmN3LsNOCSzr1SLUCt/8GAoULWsmeU5WmRqBcz9Oj0NCD31YMuhylbi6z5w
 GbXxs7qvJ1S0itc7auFc4FlSzKBwCQhNE1wPOAH2tWsYP0nk/UwKbxrzVr3hedC7uLu3M0oxu5i
 tgEY9klHQQh2HUuzNld113lQfHUFTDGbA3Kvi9QmSFSn275uyZAFva5ZREUIypchOLSTuFCDf4L
 IYuq3OK29elyv3JAT39itJNjbMnpNbF9P+mpg3gvhwIBKijob1sg6TZH/UMTZjDbgTg9M3FmbSE
 QIJzBR7Rnue3TNS9DfJcn
X-Google-Smtp-Source: AGHT+IHdZNgJW2L1yrBrvxg+AHOdLrqZccxn6TP9kt7tvpJHQTxU1OKwPpi10MvKB7CE1rNNzVZROw==
X-Received: by 2002:a05:600c:314b:b0:43c:fe15:41cb with SMTP id
 5b1f17b1804b1-43db6249672mr112519885e9.15.1743490889176; 
 Tue, 01 Apr 2025 00:01:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:28 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Anton Bambura <jenneron@protonmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 0/6] Support NT35510 panel controller on stm32f769i-disco
 board
Date: Tue,  1 Apr 2025 09:00:51 +0200
Message-ID: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

The series, inspired by some of my patches already merged into Linux,
adds support for the Novatek NT35510 panel on the stm32f769i-disco
board. Indeed, the MB1166 board comes in different hardware revisions.
The MB1166-A09 is utilizing a NT35510 panel controller while prior
versions are utilizing an OTM8009a controller.

Changes in v2:
- Add Reviewed-by tag of Patrice Chotard
- Add Reviewed-by tag of Patrice Chotard
- Add Reviewed-by tag of Patrice Chotard
- Add Reviewed-by tag of Patrice Chotard
- Replace board with configs in the commit title
- Add Reviewed-by tag of Patrice Chotard

Dario Binacchi (6):
  ARM: dts: stm32: add DSI support on stm32f769
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
  ARM: dts: stm32: add display support on stm32f769-disco
  ARM: dts: add stm32f769-disco-mb1166-reva09
  video: support FRIDA FRD400B25025-A-CTK
  configs: stm32f769-disco: support FRD400B25025-A-CTK display

 arch/arm/dts/Makefile                         |    1 +
 .../stm32f769-disco-mb1166-reva09-u-boot.dtsi |    6 +
 .../arm/dts/stm32f769-disco-mb1166-reva09.dts |   13 +
 arch/arm/dts/stm32f769-disco-u-boot.dtsi      |   53 +-
 arch/arm/dts/stm32f769-disco.dts              |   66 +-
 arch/arm/dts/stm32f769.dtsi                   |   20 +
 configs/stm32f769-disco_defconfig             |    2 +
 configs/stm32f769-disco_spl_defconfig         |    2 +
 drivers/video/Kconfig                         |    7 +
 drivers/video/Makefile                        |    1 +
 drivers/video/novatek-nt35510.c               | 1253 +++++++++++++++++
 11 files changed, 1374 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09.dts
 create mode 100644 arch/arm/dts/stm32f769.dtsi
 create mode 100644 drivers/video/novatek-nt35510.c

-- 
2.43.0

