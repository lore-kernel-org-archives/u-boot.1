Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC51C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9C988297;
	Thu, 16 May 2024 17:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LsMugEtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D392B88353; Thu, 16 May 2024 17:12:39 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCC488297
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso629108f8f.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872357; x=1716477157;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7x5EJAVTWOUZ2URBJXvmG1OB7cnDQ947VHPhL86JDqc=;
 b=LsMugEtfuxf/V/X+xbgS75IqQYQeBNgdCRPioawT5sCXCN3MkAJh3X2HM0HfUqDzhX
 xQTH3srNChViAYFPmMVHeQ3QYJdqszJGscPTuQNYF5NB0OfUow+sLf7gr5AS9yiK0D+2
 53QtpvjMBxP7bX7dkmtksAPQhpaP8KV8Quqlh76djLEz4VPzp9GWlfy3X1o1FbnBr9Th
 E+9AbHZ+AJVomOburI1djWOvmbefuRbvdy5YrUeuclNxc6WcBgtnx7J5+l/6R5CoM3fx
 b4lyO3Vz/anFT0MVQ6QwGDWZfiK8B3ltTcpL6PCz1MAef1k0BRQO88pQkyShmVfdCgB7
 z+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715872357; x=1716477157;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7x5EJAVTWOUZ2URBJXvmG1OB7cnDQ947VHPhL86JDqc=;
 b=CJCKfGINytEI2xidqdhrbVlYjRXxIiEFOoglnkFRl5AanFijTD7L7+5C0yJPSXgDP6
 lAIL6/QuuXjiHzqK78m6vum0NkrnbFrWWqOfeg7RQ/PUNmeZUSZ3LT1OCPLnp6qEsGFH
 +gXbJrd2tWVH+cIdBGv6TVvtHYITRieI8nijqeHPw6nPW5eXai7XsdlQ2o64VkBHBQ3g
 Mds5hxF7O52LqZ85fPDCpOUuT9HenpxWrh26og+bI9DanxGfQyjgDbYgKYYt8PFrsGJ0
 gKhwuHjOQsFg5Z6AVjT+Ai/N2qe6Imll9oR5kF5OR/H0pwgEUbQBXovSHofVkPeHEDGn
 24Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkc6J3fZVB3IHRWpU7EeSNGaCqEm0zUi9Uyg6WlunWVson+Vx+vaklpg1CaOyvUvCLs/bLEj15niz64t/JzhsDXpR4Og==
X-Gm-Message-State: AOJu0YxIS0sxx2XM6snPD17HdW2h543aUR3OgTvqWzPpNw6766FZBVvQ
 ChyLPeqSifY8m+gTYe2bKDFxkoQl3jrRxZ+PBW68NlDC29oM5ORJeos1bnbamVY=
X-Google-Smtp-Source: AGHT+IGgsvKtgeMT+0+xVAu6Zd1tx1fBswqAikFfbVLydIqieN2hwPKh/JjyerYy8YpxzNdEqWQpGg==
X-Received: by 2002:a5d:50c5:0:b0:351:d669:5ed7 with SMTP id
 ffacd0b85a97d-351d6696d29mr1646171f8f.39.1715872357067; 
 Thu, 16 May 2024 08:12:37 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bc83sm19233575f8f.16.2024.05.16.08.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:12:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Aswath Govindraju
 <a-govindraju@ti.com>, Benjamin Hahn <B.Hahn@phytec.de>, Alexander
 Sverdlin <alexander.sverdlin@siemens.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20240516
Date: Thu, 16 May 2024 17:12:33 +0200
Message-ID: <87cyplzt7i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom, everyone,

Sorry for the double email, I missed to include the list :(

Please find some fixes for master:

- Fix cdns3 low power hang via fast access bit
- Multiple dwc3 gadget fixes, mainly for USB support on TI AM6232
- Consistent USB_GADGET_MANUFACTURER for PHYTEC boards
- MAINTAINERS file update for u-boot-dfu

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20737

Thanks,
Mattijs

The following changes since commit c8ffd1356d42223cbb8c86280a083cc3c93e6426:

  Merge patch series "arm: dts: am62-beagleplay: Fix Beagleplay Ethernet" (2024-05-13 09:15:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240516

for you to fetch changes up to efbc11ccef89030ed54b7368458eeaf9ec687c77:

  MAINTAINERS: add USB gadget regex to u-boot-dfu tree (2024-05-16 13:28:45 +0200)

----------------------------------------------------------------
u-boot-dfu-20240516

- Fix cdns3 low power hang via fast access bit
- Multiple dwc3 gadget fixes, mainly for USB support on TI AM6232
- Consistent USB_GADGET_MANUFACTURER for PHYTEC boards
- MAINTAINERS file update for u-boot-dfu

----------------------------------------------------------------
Aswath Govindraju (1):
      usb: cdns3: gadget.c: Set fast access bit

Benjamin Hahn (1):
      configs: Make USB_GADGET_MANUFACTURER consistent over all PHYTEC boards

Felipe Balbi (4):
      usb: dwc3: gadget: combine return points into a single one
      usb: dwc3: gadget: clear SUSPHY bit before ep cmds
      usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
      usb: dwc3: gadget: properly check ep cmd

Mattijs Korpershoek (2):
      MAINTAINERS: add tree link for fastboot
      MAINTAINERS: add USB gadget regex to u-boot-dfu tree

Thinh Nguyen (2):
      usb: dwc3: gadget: Check ENBLSLPM before sending ep command
      usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer

 MAINTAINERS                          |  4 +++
 configs/phycore-imx8mp_defconfig     |  2 +-
 configs/phycore_am64x_a53_defconfig  |  2 +-
 configs/phycore_am64x_r5_defconfig   |  2 +-
 configs/phycore_pcl063_defconfig     |  2 +-
 configs/phycore_pcl063_ull_defconfig |  2 +-
 drivers/usb/cdns3/gadget.c           |  4 +++
 drivers/usb/dwc3/core.h              |  2 ++
 drivers/usb/dwc3/gadget.c            | 47 +++++++++++++++++++++++++++++++++---
 9 files changed, 59 insertions(+), 8 deletions(-)
