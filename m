Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D9CCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B114F848BC;
	Wed, 10 Jun 2026 16:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJKVYVNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3AD848DC; Wed, 10 Jun 2026 16:32:13 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3983C848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bebe5d8c661so76183966b.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781101931; x=1781706731; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KZi321iYlD5Ys2db0XyKNzFNptJtgjNj7Izrn0H3fA=;
 b=YJKVYVNl0b4EyLDETitd/7LToJm6pKntpq3OqPFBTZlocWp0VLjJcdi62/mSIishQC
 cv5V8NEfrMpX6swiSN3JS1sd4CYa6kvqPNtbaO2RA/VTG8YqZbH3I32Cn+ZysvXuV/wp
 Ol8G5KXd92uBiJx1DmLwzSqfTlg2q+Hv/+S1zZv5veZPSuYrtRtI+1tlGoSUfUKPppmD
 zcdUTnquagaCE+ozz/TNArknsO1PxLawRXAzCh4zBSSwZPAV9m4iFAicS1/RO/n2pUTF
 L1kAD49lpwE53aAuFFOak8kg7pQ7ij4o3FqPabgcAMYAVfhfAki3cmd5+XpcXPuP+8Iz
 s2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781101931; x=1781706731;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/KZi321iYlD5Ys2db0XyKNzFNptJtgjNj7Izrn0H3fA=;
 b=EyxZgTahZJTK0crGlhV0T5e292JGi1bWxxFFCdgoOyEy6iP535Z84UO3Dg/t6Z6OA5
 ESU4sLLiu0ztZye2F1lgtCAsqgy7fzWUH70NNtl7k5EFzxXk1tMG75U8i8vYmfNP3+fd
 ge1+kMCSL0zr7l/WD/wq021jm16CbjxK+omUE4HRIbHXhtN7sPlnEgE8k0piUtg5bc9V
 a8qMl/RJIkmpmDj2mtJH5gnZowKoZMIsBEJdhcSQbgqyNFyFsFrQsWVzZ9XcggR5miHO
 q/hitFIC5EzzXi6o57xpJRYZw9pW6F04K2VugXGC3JjhyBypV3QtKXC5frdj2tAWDMME
 NNAg==
X-Gm-Message-State: AOJu0YzOXfaTc1LsykdZN4UOT7HJr/UdgS1HH5pWJZIWhDfteJkIDPkN
 YwiTOinEBVXrPSfTwNDxJzLGMcfllyacXnfEaVl9/IQgJC8tRLeRdK0b
X-Gm-Gg: Acq92OEI3EAoCl27vg2HBj3oYF3zVA44J+MS3FjvV/QvP83BC6SUIABuLDZJJRmAR1X
 ql0TnEAQ6wo+GzJO0kjhG530vFWzwq01qc+xlP/dbE0MUupXlgg9fuMhOlv5N4Snifty4d1CmrV
 ZjVY0JqUeqcixhOWH0xRQhXGsbWMcqSayojX9V4g/gKhzNk91X7IIKz7N+GK9XwX+ktr/ng77Ra
 sZ7oLBuzEYSohTwBFSNxd4lPHTz2V6sNVxGFBobrikNd34sH5AiXdtRvlxX//scvEhmpADgRJFp
 oKuYl9MTHLdHtbQe2qqu1aH59JYgIDzDQ7yxke5KXirguy0irXzlkyIZqWXFgNIurhG8T7JwqG+
 /ejsaJktR/2rSpFqSK5q2o4vMoEl5XonRltRPsbjZM6zyNileu06ynIGmINLAWpM2pDpXkCRjKG
 baVRtQUOxmpA4GR2QZvvcS99mRwGRS2qj2xwH0wFRFEOGD6F4m241ZU+sgqRH/pzXo87IRjpWh
X-Received: by 2002:a17:907:7f9f:b0:bcb:d018:30f with SMTP id
 a640c23a62f3a-bf372f20885mr639517466b.5.1781101930181; 
 Wed, 10 Jun 2026 07:32:10 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559eee00sm1213445966b.56.2026.06.10.07.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:32:09 -0700 (PDT)
Message-ID: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Date: Wed, 10 Jun 2026 16:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 00/18] Kconfig restyle part 2
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Content-Language: en-US, ar-EG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The Kconfig menu attribute '---help---' is deprecated.
If we change to "help" the text has to indent.
This again has to align with other attributes,
so we have to restyle them as well.
And as there's a script then change all Kconfig files
excluding 'arch' and 'board' directories from part 1.

Restyle all Kconfigs:
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Problems:
People creating indents in help texts.
The script doesn't care. It puts everything left aligned.

Help texts with empty lines. It stops aligning as help test.

Other fixes:
While using checkpatch.pl or the script some issues showed up,
so fix them as well.

Johan Jonker (18):
  Kconfig: boot: restyle
  Kconfig: cmd: restyle
  Kconfig: common: restyle
  Kconfig: disk: restyle
  Kconfig: dts: restyle
  Kconfig: fs: restyle
  Kconfig: lib: restyle
  Kconfig: net: restyle
  Kconfig: i2c: restyle
  Kconfig: mtd: restyle
  Kconfig: net: restyle
  Kconfig: pinctrl: restyle
  Kconfig: power: restyle
  Kconfig: usb: restyle
  Kconfig: video: restyle
  Kconfig: gpio: add empty line
  Kconfig: drivers: restyle remaining
  Kconfig: restyle

 Kconfig                          |  14 +-
 boot/Kconfig                     |  10 +-
 cmd/Kconfig                      |  74 +++---
 cmd/ti/Kconfig                   |  18 +-
 common/Kconfig                   |   8 +-
 common/spl/Kconfig               |  34 +--
 disk/Kconfig                     |   6 +-
 drivers/adc/Kconfig              |   2 +-
 drivers/block/Kconfig            |   8 +-
 drivers/bootcount/Kconfig        |   4 +-
 drivers/clk/Kconfig              |   4 +-
 drivers/clk/owl/Kconfig          |   8 +-
 drivers/clk/renesas/Kconfig      |   8 +-
 drivers/crypto/aspeed/Kconfig    |   4 +-
 drivers/crypto/fsl/Kconfig       |  10 +-
 drivers/ddr/fsl/Kconfig          |   4 +-
 drivers/dma/ti/Kconfig           |  16 +-
 drivers/gpio/Kconfig             |  49 ++--
 drivers/i2c/Kconfig              | 140 +++++------
 drivers/i2c/muxes/Kconfig        |   2 +-
 drivers/led/Kconfig              |   2 +-
 drivers/memory/Kconfig           |  16 +-
 drivers/mfd/Kconfig              |   6 +-
 drivers/misc/Kconfig             |   8 +-
 drivers/mmc/Kconfig              |   8 +-
 drivers/mtd/Kconfig              |  20 +-
 drivers/mtd/nand/raw/Kconfig     |  70 +++---
 drivers/mtd/spi/Kconfig          |  54 ++---
 drivers/mtd/ubi/Kconfig          |   4 +-
 drivers/mux/Kconfig              |  12 +-
 drivers/net/Kconfig              |  48 ++--
 drivers/net/phy/Kconfig          |  18 +-
 drivers/net/ti/Kconfig           |   4 +-
 drivers/pci/Kconfig              |  16 +-
 drivers/pci_endpoint/Kconfig     |   8 +-
 drivers/phy/Kconfig              |  14 +-
 drivers/phy/qcom/Kconfig         |   2 +-
 drivers/pinctrl/broadcom/Kconfig |   8 +-
 drivers/pinctrl/mediatek/Kconfig |   2 +-
 drivers/pinctrl/mscc/Kconfig     |  20 +-
 drivers/pinctrl/mvebu/Kconfig    |  12 +-
 drivers/pinctrl/qcom/Kconfig     |  10 +-
 drivers/power/Kconfig            | 364 ++++++++++++++--------------
 drivers/power/domain/Kconfig     |   8 +-
 drivers/power/pmic/Kconfig       | 348 +++++++++++++--------------
 drivers/power/regulator/Kconfig  | 398 +++++++++++++++----------------
 drivers/ram/aspeed/Kconfig       |  10 +-
 drivers/ram/octeon/Kconfig       |   6 +-
 drivers/ram/stm32mp1/Kconfig     |  36 +--
 drivers/reboot-mode/Kconfig      |  18 +-
 drivers/rtc/Kconfig              |   4 +-
 drivers/serial/Kconfig           |  16 +-
 drivers/smem/Kconfig             |  30 +--
 drivers/soc/ti/Kconfig           |   4 +-
 drivers/spi/Kconfig              |  28 +--
 drivers/spmi/Kconfig             |   8 +-
 drivers/thermal/Kconfig          |  32 +--
 drivers/ufs/Kconfig              |   4 +-
 drivers/usb/Kconfig              |  16 +-
 drivers/usb/eth/Kconfig          |  16 +-
 drivers/usb/gadget/Kconfig       |  22 +-
 drivers/usb/host/Kconfig         |  44 ++--
 drivers/usb/musb-new/Kconfig     |  14 +-
 drivers/video/Kconfig            | 178 +++++++-------
 drivers/video/bridge/Kconfig     |   4 +-
 drivers/video/imx/Kconfig        |   2 +-
 drivers/video/rockchip/Kconfig   |   4 +-
 drivers/video/tegra/Kconfig      |  42 ++--
 drivers/video/ti/Kconfig         |   2 +-
 drivers/video/zynqmp/Kconfig     |   6 +-
 drivers/watchdog/Kconfig         |   8 +-
 dts/Kconfig                      |  26 +-
 fs/fat/Kconfig                   |   2 +-
 lib/rsa/Kconfig                  |   8 +-
 net/Kconfig                      |  20 +-
 net/lwip/Kconfig                 |   2 +-
 76 files changed, 1258 insertions(+), 1257 deletions(-)

--
2.39.5

