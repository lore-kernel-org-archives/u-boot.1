Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B54C88CB2
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 20:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF478867F7;
	Sun,  3 Sep 2023 22:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l6wILCaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F2D4864CF; Sun,  3 Sep 2023 22:48:56 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF4C864CF
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 22:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so176321866b.0
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1693774133; x=1694378933;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4QKPM1XwohIlginldl+jOoz/CGz32GSR1vatPUJR834=;
 b=l6wILCaGSElMUMF1kBBz6ZJ8/a1D+3ckEJ81330Xh2LjZqLCUhwhzaTx3R8uh4YBkK
 00jVH5Q8Uh8yeSmxTG43XBNsqZ0L0wSeT+gbiY6Mslyth1waKxuguPt3u7Esq/8Ls0eS
 2C72rb+FDZPONjBffBSLUjnX9zl1iX5Ve3UhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693774133; x=1694378933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4QKPM1XwohIlginldl+jOoz/CGz32GSR1vatPUJR834=;
 b=Imhsz+2W63/XYUzsk5pl+zyAojmNesovaqzRI7EzMKs1/A7HRs6O180Vnw5CoRUS2V
 TAtIhI/5pYiPHcl4OJRBL6CaogNesG4B09fvNfZdeNA+65wZUaOlFb633oQ9Qk+MEyn8
 cN/LQYk5+xL/HGr6h6GxP6hMZxkfZbOHVDI3uBqZVWFPeDUtXTPg0LQtj+VSGUPDpJ2Z
 Uo0NadQf/TgvYh9oAg6QSdb3v1sthCQP8w62NbulGZ7snosZ6VSswj78jCD8vSfKmhVX
 5KXBzgt7JVJZdqShk2cCfY5/zFlymRxTxCmJl88MZo0X5BOMrlhGLUlAdv73fLup+HnN
 rq0w==
X-Gm-Message-State: AOJu0Yw90UM91dhzF6ZiTuyEtAJhAqPHEsD5uhk9hd7uS6fgsyU1mn+Z
 t9HEl869F6IcJLHUGJj3auqikgLi9Y37BkV+0/3SQw==
X-Google-Smtp-Source: AGHT+IGbphW7BS9Ha2hfF7l97wgo8w4OxoK5DhOqWofNQP06zuTgZWlfzbNhZuxVLXNx5unZ0DSK+w==
X-Received: by 2002:a17:907:7b9e:b0:9a1:d29c:fb6b with SMTP id
 ne30-20020a1709077b9e00b009a1d29cfb6bmr12483582ejc.25.1693774132761; 
 Sun, 03 Sep 2023 13:48:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-54-71-141.retail.telecomitalia.it. [79.54.71.141])
 by smtp.gmail.com with ESMTPSA id
 w22-20020a170906131600b0099d9b50d786sm5182466ejb.199.2023.09.03.13.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 13:48:52 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 =?UTF-8?q?Rapha=C3=ABl=20Gallais-Pou?= <raphael.gallais-pou@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/10] ARM: dts: stm32f746 sync with Linux kernel 6.5
Date: Sun,  3 Sep 2023 22:48:39 +0200
Message-Id: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series contains my patches on the device tree for stm32f746-disco board
that have already been merged into the Linux mainline. Since most of them
applied perfectly, and for the remaining ones, only minimal changes were made,
I preferred not to merge them into a single patch, which would have been less
readable.


Dario Binacchi (10):
  dt-bindings: mfd: stm32f7: Add binding definition for CAN3
  ARM: dts: stm32: add pin map for CAN controller on stm32f7
  ARM: dts: stm32: add CAN support on stm32f746
  ARM: dts: stm32: use RCC macro for CRC node on stm32f746
  ARM: dts: stm32: add pin map for i2c3 controller on stm32f7
  ARM: dts: stm32: add touchscreen on stm32f746-disco board
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f746-disco
  ARM: dts: stm32: support display on stm32f746-disco board

 arch/arm/dts/stm32f7-pinctrl.dtsi        | 126 +++++++++++++++++++++++
 arch/arm/dts/stm32f746-disco-u-boot.dtsi | 103 +++++-------------
 arch/arm/dts/stm32f746-disco.dts         |  69 ++++++++++++-
 arch/arm/dts/stm32f746.dtsi              |  59 ++++++++++-
 include/dt-bindings/mfd/stm32f7-rcc.h    |   1 +
 5 files changed, 276 insertions(+), 82 deletions(-)

-- 
2.34.1

