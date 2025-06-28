Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500ACC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 12:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D35D80C83;
	Sat, 28 Jun 2025 14:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC46981D5D; Sat, 28 Jun 2025 10:36:09 +0200 (CEST)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051ED806D8
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 10:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-6f8aa9e6ffdso31951516d6.3
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 01:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751099762; x=1751704562;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmabQ5icOvYgp2RUSMCfLBagKej5AD2Xo+rrM7YNHcc=;
 b=cDCn2OnETtPkaOKE9GH4YxiyrYkV8yhLQgv3Z0iCuEDeHjd3cNUDQAaAj8UORDA6pn
 xVFvXTu5KsqBO/l9+X3GXfAuyXHYnu/DTA0v79m7WVTtQ2GhpWiVjLfZQTufjQjpYGdp
 hjsB/yI66tQpUrXVA39VLwtgqltM0vGf4EYUM1hyIj+9Oe5o3bdjqIaPWL1oijfYyR+Z
 LCKQ1FwiI2bc/kzbC+HYSF1T8oupYOO5WJd9HoJmEGnrbwGylG1bgldUY2YCH1Uck4ab
 hFN2QGDLCJl5AMJ8KkmE8iU95axSiyrcBUB4B02xtS+GqF+SY6XyBpe0UWxqI4ot/Pbh
 7liQ==
X-Gm-Message-State: AOJu0Yz6POyzDxwJ1AmCQgpLIzqhHuO+RFPGz+z0F5gghjtmJmAxWRH2
 clu2n8bwDmaS9YTPQsLQKJULIPs6AzIfo9+sdi/7MaHE46c9ut1YIjNwXWAR+TyIz6c=
X-Gm-Gg: ASbGncvr4OJc/9jod0x0uFF97KWVBpjvNfHq9v4FJ1WFis/ZZ32kgqy0YA/JgVjy/S0
 BDcyWf8UHJLDP07wTk5LZvo6eXm4mDFkOf1EV9oGTmCeMKw5zbyk3FV3TZ8SOBFejn4vtMWmNF3
 8+87sX+vLD0iAJ9qA09Vst3YnzIoKB8wNb7usaeZ7iJCaCyEoPXba1h5t8COhs8tcw14ayjkbUf
 7dSrTZo2facrA/1SyPW7vDh+zS1fsPoj1Bpi2bSgE/Tt+pHpYYhkruQlZa9ej4caU+B7cWa308z
 sY9GLZvtHOuDiPa8KsxGBdaXzNO00EDlLm3iMbOANW7r0YOtL6GXjTjXoxzeKCtIHLHfbnBZEoy
 i5NoomzX3xwLYq2Lu+A==
X-Google-Smtp-Source: AGHT+IHvLbMSz6h86dxf1KaGqEQrHL8UobjNhbmfO7Ytq2OJ2gvjw7SEUywBGhmFV6yrzuaD4advlg==
X-Received: by 2002:a05:6214:2588:b0:6f8:e66b:578e with SMTP id
 6a1803df08f44-700134a73ebmr93620046d6.32.1751099761611; 
 Sat, 28 Jun 2025 01:36:01 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730ec10sm33645816d6.117.2025.06.28.01.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 01:36:01 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 geert+renesas@glider.be, marek.vasut+renesas@gmail.com
Date: Sat, 28 Jun 2025 10:35:59 +0200
Message-Id: <175109975905.52679.4087457787402643705.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH 0/2] Initial r7s72100 Genmai board support
X-Mailman-Approved-At: Sat, 28 Jun 2025 14:35:07 +0200
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

Initial r7s72100 Genmai board support

[PATCH 1/2] Put common r7s72100 code in board/renesas/common
[PATCH 2/2] Add support for the r7s72100 Genmai board

These two patches for U-Boot aim at adding initial support for the
Genmai board which is based on the r7s72100 (RZ/A1H) SoC from Renesas.

The first patch takes SoC specific code from the GR-Peach board and
breaks it out into the board/renesas/common directory so it can be
easily shared between GR-Peach and Genmai.

The second patch adds board specific details for the Genmai board.

There is nothing out of the ordinary on this board, serial console, NOR
flash and Ethernet all come from the upstream DT and seem to be working.

Please note that the external SDRAM (hooked up to CS2/CS3) to the r7s72100
on the Genmai board remains unconfigured at this point. Because of this the
U-Boot Genmai board code is instead making use of the 10 MiB on-chip RAM
available in the r7s72100 SoC. The upstream DT for the Genmai board is however
describing the external SDRAM memory banks as expected from a Linux point of
view, and to "make it work" the memory bank configuration in U-Boot today is
not using DT to describe the memories.

Once SDRAM configuration code gets added as an incremental patch the memory
configuration code can be easily switched over to use DT by adjusting the
number of memory banks in the defconfig and updating the dram_*() functions.

Thanks to Chris Brandt for the older out of tree board code, Marek Vasut
for the upstream GR-Peach board code and the pinctrl-rza1.c driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/dts/Makefile                     |    3 
 arch/arm/dts/r7s72100-genmai-u-boot.dtsi  |   33 +++++++++
 arch/arm/mach-renesas/Kconfig.rza1        |    4 +
 board/renesas/common/Makefile             |    6 +
 board/renesas/common/rza1-common.c        |   27 +++++++
 board/renesas/common/rza1-lowlevel_init.S |  106 +++++++++++++++++++++++++++++
 board/renesas/genmai/Kconfig              |   12 +++
 board/renesas/genmai/MAINTAINERS          |    7 +
 board/renesas/genmai/Makefile             |   10 ++
 board/renesas/genmai/genmai.c             |   49 +++++++++++++
 board/renesas/grpeach/Makefile            |    1 
 board/renesas/grpeach/grpeach.c           |   22 ------
 board/renesas/grpeach/lowlevel_init.S     |  106 -----------------------------
 configs/genmai_defconfig                  |   81 ++++++++++++++++++++++
 configs/grpeach_defconfig                 |    1 
 include/configs/genmai.h                  |   27 +++++++
 16 files changed, 365 insertions(+), 130 deletions(-)
