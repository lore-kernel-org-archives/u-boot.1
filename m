Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46189EE6B74
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 04:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E61083A64;
	Sat,  7 Feb 2026 05:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cVI5MnyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACA083AA7; Sat,  7 Feb 2026 05:21:13 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B3E83693
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 05:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45c715116dbso1827556b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770438069; x=1771042869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXokREcXHxTKzuuQng8KKZFgSl3SkE2K4uSSmLhXasU=;
 b=cVI5MnyI6DSqgmC7+lJ+TPfIJpVU9fhatr9946wsrKtmLhQ1eB3nL7kyX+X7ZVC9wr
 GiyglCvfph4t8c0C/5N5DOQ3/tEdsBcl+grXnPUNtMJbH4TDl3uAaqzR4ZnFNyzK4cwj
 SCyk948/6uyl8QAI5yA54FsJGTEiajSRbgA/hIg+BsiLCF5EyRag3aqXRn8JRlYkkLZ+
 wTwDD7GqxWiHxGBSqJqIxOQ1hqSqV0qcwELqsg0lJURJqOBRw52Us6grusBYy7wSbKIQ
 btnQs9adyiBwoK6CrtrqaiD+MTdFwF/MfS3WxIGfb0+J65khaXH69o2czLNFCUvr5dVw
 fvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770438069; x=1771042869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXokREcXHxTKzuuQng8KKZFgSl3SkE2K4uSSmLhXasU=;
 b=U7dgO2+tX47b2EJqXTSlAcQY+tV1/mrpkuKJ4EFjwO2AQU7VCnmkrGfFQZIhmOttYF
 BIPxnVzCUsFSh28UK28W8cQezyDVHkeS6wtqL3OBsMum1K8agS9MyA+EYEer3Uuj8L9Y
 2uiNVZpsiPNH8jy0sI/8NpKytR6CokUtzkK6upRPF1mduTsezsyI4oruafOoQDCv0J0d
 vjLdIkFXNiE0MkDTzDwzhmGJc1koqJxJRiirRBIJx6ZDz30IuaOs9x71WD0suB25qYle
 iFsyPBvmwMRskr9mybAVhJGsuyZ9lR3HRGgXb1GKh8XpSOLQc+zghiUVWfbvwXBr0Dki
 kxBw==
X-Gm-Message-State: AOJu0Yybw3GrCnfpUOTAQfBzNT+Cjb+aFDX7r50cUXvJhfMxndiejuaI
 h7q6G5LNnTZhtIjR1FNcDxndYZtcHpglr7g70I78z4pjCBoF9uu4wWo8qIMvVQ==
X-Gm-Gg: AZuq6aKB3TOUPg4gNakxoL6sAmC+C2pmPqJqOLIokl+nBgrpXTg+kk/dsA3akgu2GEY
 4tEZh0JWCmkXeFrhem9LKyeAXXqQg9YE9uFn+86vu24jipT53CCWZyR4oHnZlLP7UiRxQ+1G7Lv
 SKrz/SlwpGKiy1CKqJTqV0KBoEZt8yHoGToY1MqhqwMHym7OycBtgDDO2dC3g76Wpm5QLOTONq1
 BTibn5Wk2kvYCs1toLC5xcTi+ChPwAVUffKpa+b4J3icx/yt3eKZ3yoKnMkTC3fq6M/mkJhN/93
 sEGo+5Lk6rGEJ9OZ9iwHuLa4WFP25II2Im6xLd0DTqPDcfdInKRpuo6fOlnNOBILMaUNUsgWRVs
 XIan7e4dqytDsA00ijeMgn5DZZwg/21BAK/f0YKO+Bado7UfOS+gYjJ7cTTJGQ4EYQcnjRiLESh
 U2fySMJHQrrYhdJNNKZ4rADkM/
X-Received: by 2002:a05:690c:d8c:b0:794:6fa2:a037 with SMTP id
 00721157ae682-7952aa62f8dmr96450297b3.8.1770431717464; 
 Fri, 06 Feb 2026 18:35:17 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:44a3:2bb7:a035:fd7e])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-649f248d184sm3967616d50.10.2026.02.06.18.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 18:35:17 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, niko.mauno@vaisala.com, peng.fan@nxp.com,
 hugo@hugovil.com
Subject: [GIT PULL] Please pull u-boot-imx-master-20251104
Date: Fri,  6 Feb 2026 23:35:12 -0300
Message-Id: <20260207023512.2793979-1-festevam@gmail.com>
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
