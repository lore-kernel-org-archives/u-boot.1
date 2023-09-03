Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405A2C71153
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7C786961;
	Sun,  3 Sep 2023 22:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VIEzMGyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BAB86898; Sun,  3 Sep 2023 22:57:09 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E82868AE
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1010878a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774626; x=1694379426;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu874AXqAnFuFEoWLwUCi0oaN1bQ6BNWKx9R8q+zZXk=;
 b=VIEzMGyqt8Essq5yCm1x3T6mi/yZKVfwBbhgNTvlbbOlewiC0EKGZH0uJafa6zsaSe
 4Tdc6GRKrZS/uFl770Zkvqc14RZaQvUzjrwXQi/2soco+189dgS1scptrL4EtBpvF7tO
 8LvDuMO3faFSphT6Djpw7g7/tsONZ1HucqPy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774626; x=1694379426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pu874AXqAnFuFEoWLwUCi0oaN1bQ6BNWKx9R8q+zZXk=;
 b=l2zgBb0OktFAHKfctuUolkBXuk27/bpoaJ8ek6CSnBI16CR5ep49ZZtRw4dFSog/7N
 /1zqCYCtDYrpSQf9ORxVOd3Gxu2tkq+UQKmQ6GM8Kr0ET53k3/ZDX6umDyP4zwHnuAN+
 mJG90WH4r3XgwaF4OuhlGUTGvBexLNPEzycLJc4fbCcSiVWqsctElzE7w/BaB3br5fxM
 WsckNZFlPUEwonV+yE5sbkJSI9dHlQldbBV3irt3lso+E0jo6YsO3Ps9qIecipflORTr
 k9Jj/+H4O7Lup0P+aM/tm8Bh4kA71xEgLlIVFqzt2EbnmzzY/9hX8d9ovaLJyE/AWgKe
 TfRg==
X-Gm-Message-State: AOJu0Yz9zws2UDjCyhPf71TvdZtF2p9Ah2M9El9urKBY1Lqf/gjrOPwJ
 Wx9ycPsqBFZ7CN5bPM9Rp4o7cdyUCnPk+PxqD2/nNQ==
X-Google-Smtp-Source: AGHT+IGu3c6CExox+4C9h8/JyNKpmciYT1Mbp/YEH5ZidJjjz2xdvPeECf08e0v/Nix3rxEo7KNHrQ==
X-Received: by 2002:aa7:cfc5:0:b0:525:d95b:cd4c with SMTP id
 r5-20020aa7cfc5000000b00525d95bcd4cmr5892731edy.20.1693774626130; 
 Sun, 03 Sep 2023 13:57:06 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d9d6000000b0052568bf9411sm4850232eds.68.2023.09.03.13.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:57:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 0/5] Support display on stm32f469-disco board
Date: Sun,  3 Sep 2023 22:56:58 +0200
Message-Id: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
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

The series adds support for the Orise Tech OTM8009A display on the
stm32f469-disco board. Substantial differences in the drivers for clock
management, LTDC and DSI compared to Linux, made it necessary to modify
the device tree. These changes were made in stm32f469-disco-uboot.dtsi to
avoid altering the Linux device tree. It is therefore desirable, as soon
as possible, to add these drivers the functionalities so that they do not
require device tree properties that deviate from those present in the Linux
version.


Dario Binacchi (5):
  ARM: dts: stm32f469-disco: sync with Linux 6.5
  ARM: dts: stm32: make the LTDC clock usable by the clock driver
  ARM: dts: stm32: make the DSI clock usable by the clock driver
  ARM: dts: stm32: support display on stm32f469-disco board
  board: stm32f469-disco: add splash screen with stmicroelectronics logo

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  13 ++++++++
 arch/arm/dts/stm32f469-disco.dts         |   4 +--
 configs/stm32f469-discovery_defconfig    |  16 ++++++++++
 drivers/video/stm32/stm32_ltdc.c         |  37 ++++++++++++++++++++++-
 include/configs/stm32f469-discovery.h    |   2 ++
 tools/logos/stm32f469-discovery.bmp      | Bin 0 -> 18532 bytes
 6 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100644 tools/logos/stm32f469-discovery.bmp

-- 
2.34.1

