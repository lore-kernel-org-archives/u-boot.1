Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D39C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F57782F83;
	Mon,  7 Apr 2025 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mnq9651L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 081188300F; Mon,  7 Apr 2025 22:02:37 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F7F82E76
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso52504455e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056154; x=1744660954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ra5rDa4ONwSd+F4OIJt7U51MFlTiFzZitay8UBY+ej4=;
 b=Mnq9651LjOHMqPUTAVrud5GslHOPWCZbyRCUZWUNoEGFjmboqpSa9ZdQWPfLkLfo/c
 58IVL1wBlGXn/KDZCO3S9sy7kEJlkXcO12n7RgoYIxeFysRGfDLRMMM04Mhsr3CFF9XA
 lpkyJ/PcpxKNhXolqlwlU6Frg3m++C+5bk/ZmgWL4DEPRSch4Kj+T9kToUvAGil+hVg0
 n6IbKlm1fGDH847I2/Wc4IalbHOFR2/s0qHpWbPPD2zWiRSSRaHMELcdhFZlAcJvMjKQ
 EqjPQjMdRB8S954OoPcXLCkOxZrKpkC0dUdtJLEmtH8DXpQ8p8ew9nSqnLYo7dt54Vil
 dZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056154; x=1744660954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ra5rDa4ONwSd+F4OIJt7U51MFlTiFzZitay8UBY+ej4=;
 b=pN17pK5hEjNOHTqj67Z27/eYtqeiJDos5neXm4eDNUSRAAfJ4Wy41qQecie0w6I3A1
 OpA0Sg/xYfM9c9yAKpfluXZWQPQiVfaV3p5da7uRMfNwGEKO2pUpS+N43UxR4KACWaJF
 RvUbWf2X5rHhfSJyDCfqMW9qAt3aey3f1OVkOwSgwIIYo8UnlEsYIob1vWwtc2kjNjHc
 EpQREBHamdCgESpVEA4ThaxdfduqYN21VHMb1busWVcjZwoff0BK6GfTl3ucvCE2Fe3q
 wEFYUKqLivzjg2ZUnXKvNJ1VKq2Uzxil0ULHXJze0xu1JGS5TkWEvC7BlfmPAoQ3T7cl
 KEag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEtxgC4YEc2GlLcPLwjHB+wnB2sQgoK1QlvC6GSfj1YuNUxqe3ilFlrJWla/XlxqwEsMw9EI8=@lists.denx.de
X-Gm-Message-State: AOJu0YzqrvPoBre9z1E12Pck85kkVRUFuBZLXJxHbsoRmtuH50oRypdS
 D+VdhZ37pYMGP+kcb4+t2LKtYjxDZDVx7NErhvirGS3JHuI+XPg7
X-Gm-Gg: ASbGncvW8nFUBTrqA7uAUcFnIR9YZJ84GDZy+XoZro5x+4q80iJ0wxeEHqXUMQBAYnL
 c2Ej8jGUr+JvbAycrhVWnEbmeVnZVIbMXZGf2MG08ARfyc6Yqzxf7JIlNtD9w+INvY3h1nKW+D8
 HMY+ySOSHF/4Ex4lti5Jqml6kq1HXSjlZzVeBU09B+n6vl4jxseyvIILaSUzm/ia+kj+3Dxgo0A
 GpY3SLzfxtdvL9GqfCLKYKiq/7SrAT4GnNubZQiDMxJrKXerVAi/2qBrnAmWSih1xU+HlWcXcFU
 vDRDbofPTITlniIfl4bfjl1GiJyWWi/9grFOcrkjVRjYbQQyfvD9F4i1zcS4Rv2s64Qcr77UMHM
 9Nd/5weaJZcKoZw==
X-Google-Smtp-Source: AGHT+IFy142rk0TJ+vE02uqeEoHfNoAyfw9Ez6noaxbVDnSkURIwAlii7k40tXFYV2D/ibT5Zv9Vjw==
X-Received: by 2002:a05:600c:1d91:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43ed0d98e57mr107553415e9.20.1744056154173; 
 Mon, 07 Apr 2025 13:02:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:33 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 00/14] airoha: add support spi/mmc/ethernet
Date: Mon,  7 Apr 2025 22:01:44 +0200
Message-ID: <20250407200208.25594-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

This is continuation of the initial patchset for airoha
support.

Some are trivial fix for spi.
A new concept to setup SPI from detected NAND.

Sadly DTS node still need to be merged upstream so we
are currently adding them to u-boot dtsi and it's planned
to be dropped once they are accepted in upstream kernel.

Changes v2:
- Drop unused define in ethernet driver
- Use remap in ethernet driver

Christian Marangi (14):
  arch: arm: dts: an7581: add Chip SCU node
  net: airoha: Add Airoha Ethernet driver
  airoha: Add Ethernet config to defconfig
  arch: arm: dts: an7581: Add Ethernet nodes
  mmc: mediatek: permit to also build for Airoha arch
  arch: arm: dts: an7581: Add eMMC nodes
  airoha: Add eMMC config to defconfig
  regmap: Add regmap_set/clear_bits shorthands
  spi: drop unneeded spi.h header include from spinand.h
  spi: Introduce setup_for_spinand()
  spinand: call SPI setup_for_spinand if supported
  spi: airoha: Add Airoha SPI NAND driver
  arm: dts: an7581: Add SNAND node
  configs: airoha: an7581_evb: Enable Airoha SNFI SPI config

 arch/arm/dts/an7581-u-boot.dtsi |  90 +++
 configs/an7581_evb_defconfig    |   3 +
 drivers/mmc/Kconfig             |   2 +-
 drivers/mtd/nand/spi/core.c     |  18 +
 drivers/net/Kconfig             |   8 +
 drivers/net/Makefile            |   1 +
 drivers/net/airoha_eth.c        | 948 ++++++++++++++++++++++++++++++++
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/airoha_snfi_spi.c   | 717 ++++++++++++++++++++++++
 include/linux/mtd/spinand.h     |   2 +-
 include/regmap.h                |  28 +
 include/spi.h                   |  11 +
 13 files changed, 1836 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/airoha_eth.c
 create mode 100644 drivers/spi/airoha_snfi_spi.c

-- 
2.48.1

