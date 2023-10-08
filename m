Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FD1E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFE686BA8;
	Sun,  8 Oct 2023 17:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y4oBwhX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C000B8662F; Sun,  8 Oct 2023 17:45:59 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E629286B89
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99de884ad25so665585966b.3
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779957; x=1697384757;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FGKAgaWaq8j4SufF5PEWZku7JsXLcsXNqOhBcLo5wW0=;
 b=Y4oBwhX8BfJaccEbPVxoUhysVQAKjQo48rCdzrJIGet5ORAD7KOEBlv1C01M7mxsNZ
 +jnF5XndPlxo7FMcH8wN+L+o/cqs/dWdFTKKHfR1tdbhGKgga0tSev7A+hH5U4mmFUHW
 JV7LVIltYmbNqmDvAxuy65ktn0+ES5ErSQOws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779957; x=1697384757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FGKAgaWaq8j4SufF5PEWZku7JsXLcsXNqOhBcLo5wW0=;
 b=QdttjCIYL6M5f2EzFDT/fF1sh0OLA8/pvrUDC6HCG6QFbE7N5h2aoKN+Ate9FJ731T
 tOnXJidKxBJ9baXU+JoVuQHSVye64OyBrliu7qxa3XNFGtjjeTgoGOMxw1J19QRo2m7O
 YRx0i+KuWIQHmZGF1KBvqlEQtdd6VFpkC7OfMbx/rtAC1lJ0bXyVrFM3enHgPF52x7dR
 mvBRqGgCa4lCB/HfntiOXynWzCcu9CbRGjvRAfIa3lucj1QLdOd8tmBWzntjIX9l5KpE
 SX1WRRhcGCDSo9j6xfqr/AmZJOBUmaR0BjO9Emfomc4diRmFRihyfZr3FRbsOXS/4p/J
 WywQ==
X-Gm-Message-State: AOJu0Ywzq9L5d4AtQsUaz6Quu4U/CuG9JRGT25lXqMcaiLv5eqx4oaZE
 wyj2y/fXAnG5C2wrU5tt8C9+Y8+HiIBOriijD3o=
X-Google-Smtp-Source: AGHT+IHVQsHY5UZ+YToecke/lMgaJB2OLbZsFe4sWhakDfKiPfxqVniWLEBX0FPw3riUAHkn3UDKvw==
X-Received: by 2002:a17:907:b1c:b0:9b2:787d:b326 with SMTP id
 h28-20020a1709070b1c00b009b2787db326mr11910573ejl.16.1696779957041; 
 Sun, 08 Oct 2023 08:45:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-50-102-159.retail.telecomitalia.it. [79.50.102.159])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm5623981ejb.131.2023.10.08.08.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 08:45:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v2 0/5] Support display on stm32f469-disco board
Date: Sun,  8 Oct 2023 17:44:52 +0200
Message-ID: <20231008154538.1622772-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
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

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag to patches 1, 2 and 3 of the series.
- Fix frame buffer allocation for stm32f469 discovery board.

Dario Binacchi (5):
  ARM: dts: stm32f469-disco: sync with Linux 6.5
  ARM: dts: stm32: make the LTDC clock usable by the clock driver
  ARM: dts: stm32: make the DSI clock usable by the clock driver
  ARM: dts: stm32: support display on stm32f469-disco board
  board: stm32f469-disco: add splash screen with stmicroelectronics logo

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  13 ++++++++++
 arch/arm/dts/stm32f469-disco.dts         |   4 +--
 configs/stm32f469-discovery_defconfig    |  16 ++++++++++++
 drivers/video/stm32/stm32_ltdc.c         |  31 +++++++++++++++++++++++
 include/configs/stm32f469-discovery.h    |   2 ++
 tools/logos/stm32f469-discovery.bmp      | Bin 0 -> 18532 bytes
 6 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 tools/logos/stm32f469-discovery.bmp

-- 
2.42.0

