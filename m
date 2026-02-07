Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D0EE6B4E
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 04:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C0283A64;
	Sat,  7 Feb 2026 05:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAcKfbHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B3483693; Sat,  7 Feb 2026 05:28:29 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6786A83693
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 05:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-894774491deso34880906d6.2
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 20:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770438506; x=1771043306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXokREcXHxTKzuuQng8KKZFgSl3SkE2K4uSSmLhXasU=;
 b=aAcKfbHY8R0ZpCGl1DBMyb2/9JZ7ggOMShav7urv1VvsZNtNCHcsqDVW0hgWPdriri
 yVAA0jDFzA9dllaHYSq0dwJox7MEcAqltUmukJ8OICBZxT1fnMsa6sCChzBrpOXLMEu+
 H5l8qVbzw2rzhQ2CaZYmd5r2gv0ga5jKA6IRNgfFaL+14VmC8ks16VIZUUrhkJQknTLD
 iN+Ir4K+QKIIjX7t8Oa9S0z7hmmBSeWKz7Vw6I4X0/jMx8aQ5GdF4We4W6AukkW9PkJ8
 qywxjvZRliRC7AB0J5fjs2NtdEJbrTdvzk4lQxKWtbi9fwvYZaZRXJDGcifmr4jkKYyu
 WeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770438506; x=1771043306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXokREcXHxTKzuuQng8KKZFgSl3SkE2K4uSSmLhXasU=;
 b=GddI0XBXsMTYrIRPVr0yyJNBtv+guSmBiKdaGlZraiqxRbXsbNsGaXyjY1Q31yDshQ
 e9RckUjo4LzpEuE+pYO/lig6vr2tdmjIypEvGo8JeJQnAMI+YlP9tp36DviQi0RhEFEi
 O11x05PKFdqgSZ0kZvJyGpICbYStW32LRJhs2cmMBx7K7xnLIOHh4d7ElvLwZuaHb9et
 q/tO4cDk0fZFjKSjbH56b9DV3tXCtfrk02av3ZSTX26mcyVrppSTYfD6m84UjpKuOx3q
 6RWiNHRwquTXgVxmTlUlYAeFsDeWk1u2lLIFWgHVnaIvtMZoJ6yr5CSMW7FoZIe/QQf8
 GoFg==
X-Gm-Message-State: AOJu0YzUIPQWuHyNhG5MPYQNqZE6SgrUy6ptiJpqkxGZdQ8SfBCdWNtF
 c+YMWoRWKE0Xmx/VTqLKyaWWf3Cns74rkJt0Uyyc4mXwe9GT85cNm4Oc8gQ3mA==
X-Gm-Gg: AZuq6aIt2vQ8cJFKY43fcUmkH2etlDNfXbBe68+qSBuCBFAXmfomYYw9DLfv4GXxLwe
 yL8AHaYdSQqO/s2XFCcZB+nEOwtXU3Quv2heYHjFsJuAz/oJu2vkIy+1FlT9kN7DaVykX4Gz4SI
 tIeWMQQNCE0zevCIX+NeXFAOuTycXtNo5/qXN3BNnYsoyBvzY1FxW+eIKpOOf4OtydkSUPjbUWg
 +AMss0erKbRkbl5sfrnbbb0eSxSs4G8fQl0NRTGIZFsS2j7Fc535g+CthAbTiBow/KWmV2LX8o+
 WqczpC/snHhOtFZhAzNNJpFdO7pNp5J7A41YOoHI3kpnnkbVe4bG6W8TyDGzWh+TbvTZgt05PH3
 /d7MrD9rhlC5xer5JinvBvJGgx1UTJ4bA8ap0Qe4Hh0eKTn/moUjSN6lbUPRYZEAL5Aj8YxK62f
 51Df7jRs5hrlEf8ZlFWwXO2svs
X-Received: by 2002:a05:690c:9b01:b0:794:7072:b32b with SMTP id
 00721157ae682-7952ab50d90mr55344507b3.50.1770431951350; 
 Fri, 06 Feb 2026 18:39:11 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:44a3:2bb7:a035:fd7e])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a079f71sm37245977b3.23.2026.02.06.18.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 18:39:09 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, niko.mauno@vaisala.com, fberder@outlook.fr,
 peng.fan@nxp.com, hugo@hugovil.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20260206
Date: Fri,  6 Feb 2026 23:39:05 -0300
Message-Id: <20260207023905.2794478-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9:

  Merge tag 'efi-2026-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-02-06 12:35:44 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20260206

for you to fetch changes up to 470ea759aa60890271fba0b8d0bcc7bb29e0b459:

  mach-imx: ele_ahab: Mitigate imx93_qsb build error (2026-02-06 20:35:56 -0300)

u-boot-imx-master-20260206
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/29216

- Convert imx8mn_var_som to OF_UPSTREAM and several cleanups.
- Fix ele_ahab buid error on imx93_qsb.
- Add i.MX95 EVK remoteproc support.
- Several i.MX8/9 EVK cleanups.
----------------------------------------------------------------
Francois Berder (1):
      board: ge: common: vpd: Fix read_i2c_vpd return value

Hugo Villeneuve (6):
      arm: dts: imx8mn-var-som: Move SOM-specific nodes to SOM u-boot.dtsi
      arm: dts: imx8mn-var-som: add som-eeprom alias to SOM u-boot dtsi
      arm: dts: imx8mn-var-som-symphony: migrate to OF_UPSTREAM
      board: imx8mn_var_som: let clock system enable UART clock
      board: imx8mn-var-som: remove unneeded header files
      board: imx8mn-var-som: compile SPL-only stuff only in SPL build

Niko Mauno (1):
      mach-imx: ele_ahab: Mitigate imx93_qsb build error

Peng Fan (19):
      imx8mm_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: spl: Drop i2c_pad_info1
      imx8mp_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: Cleanup headers
      imx8mn_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mn_evk: Cleanup headers
      imx8ulp_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8ulp_evk: Drop board_phy_config
      imx8ulp_evk: Cleanup headers
      imx8mq_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Update IMX_BOOT_IMAGE_GUID
      remoteproc: imx: Support ECC initialization
      remoteproc: imx: Add i.MX95 support
      arm: dts: imx95: Add cm7 node
      imx95_evk: Enable remoteproc for i.MX95 EVK
      nxp: imx95_evk: Drop init_uart_clk
      nxp: imx94_evk: Drop init_uart_clk
      toradex: smarc-imx95: Drop init_uart_clk

Primoz Fiser (1):
      net: fec_mxc: Add support for i.MX91

 arch/arm/dts/Makefile                            |   1 -
 arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi |  63 +--
 arch/arm/dts/imx8mn-var-som-symphony.dts         | 236 ----------
 arch/arm/dts/imx8mn-var-som-u-boot.dtsi          |  70 +++
 arch/arm/dts/imx8mn-var-som.dtsi                 | 564 -----------------------
 arch/arm/dts/imx95-u-boot.dtsi                   |   4 +
 arch/arm/mach-imx/ele_ahab.c                     |   1 +
 arch/arm/mach-imx/imx8m/Kconfig                  |   1 +
 board/ge/common/vpd_reader.c                     |   4 +-
 board/nxp/imx8mm_evk/imx8mm_evk.c                |   3 -
 board/nxp/imx8mn_evk/imx8mn_evk.c                |   4 +-
 board/nxp/imx8mn_evk/spl.c                       |  22 +-
 board/nxp/imx8mp_evk/imx8mp_evk.c                |   2 +-
 board/nxp/imx8mp_evk/spl.c                       |  30 +-
 board/nxp/imx8mq_evk/spl.c                       |   3 -
 board/nxp/imx8ulp_evk/imx8ulp_evk.c              |  17 +-
 board/nxp/imx8ulp_evk/spl.c                      |  12 +-
 board/nxp/imx93_frdm/imx93_frdm.c                |   7 +-
 board/nxp/imx94_evk/imx94_evk.c                  |   6 -
 board/nxp/imx94_evk/spl.c                        |   2 -
 board/nxp/imx95_evk/imx95_evk.c                  |   8 -
 board/nxp/imx95_evk/spl.c                        |   2 -
 board/toradex/smarc-imx95/smarc-imx95.c          |   8 -
 board/toradex/smarc-imx95/spl.c                  |   2 -
 board/variscite/imx8mn_var_som/Makefile          |   4 +-
 board/variscite/imx8mn_var_som/imx8mn_var_som.c  |   4 -
 board/variscite/imx8mn_var_som/spl.c             |  12 -
 configs/imx8mn_var_som_defconfig                 |   2 +-
 configs/imx943_evk_defconfig                     |   1 -
 configs/imx95_15x15_evk_defconfig                |   5 +-
 configs/imx95_evk.config                         |   5 +-
 configs/toradex-smarc-imx95_defconfig            |   1 -
 doc/board/nxp/rproc.rst                          |  13 +
 drivers/net/Kconfig                              |   2 +-
 drivers/net/fec_mxc.c                            |   4 +-
 drivers/remoteproc/imx_rproc.c                   | 189 +++++++-
 drivers/remoteproc/imx_rproc.h                   |   3 +
 37 files changed, 308 insertions(+), 1009 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mn-var-som-symphony.dts
 create mode 100644 arch/arm/dts/imx8mn-var-som-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx8mn-var-som.dtsi
