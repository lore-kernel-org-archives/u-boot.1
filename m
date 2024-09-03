Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C671BCD3427
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06BB388C50;
	Tue,  3 Sep 2024 10:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XQ4mZiYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF37288C1C; Tue,  3 Sep 2024 10:38:48 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49AC088AB1
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso39814525e9.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352725; x=1725957525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/QwzGNcFIWZTJS1MmYKEAWXX8PNoNSodrPmTmZlc+6I=;
 b=XQ4mZiYjMSLbJjl5ZAxv4igKGLLnlcWnmLNoCQ1+GPV4Cy5f57NK1dk5qx6ZunUnEK
 9tHr+2i9g31HbBASXlwUbLWPyHsNsfyloGGbF1g/9fli/M8Wytc80oLN3FkwBfbr3o4b
 2JIt64Pp8rizc9JYyMHII/DKDrQKOtLezjsjcPQppbJIWEvh3ceBvgKXPkuqaDlC0bIZ
 N2LM7cdJz1JTG5xipCmmJJOaNuA6Z6lnCBQz6o6LqRTTxrB+OBPhopythELP9W107wM8
 gbjiEKFZku2UDLUatFMqnUZEtiQxGn341ueaLBRBvhkaYTKC8wOsWgtSgrVzr3a/BPY8
 9vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352725; x=1725957525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/QwzGNcFIWZTJS1MmYKEAWXX8PNoNSodrPmTmZlc+6I=;
 b=reJVSxIedXyUQW7+FtOFlPqZWjY0fuE0PE5npKXxET6TIc03yzKrVWHPrT6/Q/GX6o
 JRh0VK35cwCVwtLWwBY/3rwQu6k6TvNbv8gt0RrwXKiXzCrcfbcX+ootOter34+e9dzM
 VBvLa8XdlJbPGC1Dp83H6X8iSO57/fMA/jcEVGox4/iurrNoS4cUyDJLGKgmFrObbEB4
 h0o9V+BkktxC5ymdY/vt9JQcg1f3fHkLYXDingJzu57hJhjKcFPolFyoGencCu+cWeOf
 IWrUdUd3pDCyBahQJfSAP/5Pvn0irzUHBsPQjVzi/uRR538jVJzb7/w9Zm3Py0zrcJat
 HaIg==
X-Gm-Message-State: AOJu0YwQqUHsVj5bGLSdKIUv6x5RBP8JuynMc7Q76+lDikpQNRKh6AbF
 Xy2b2qtBpgKisuOk4tC8al0NS35LzqakU9sE/ajku4LgyDlSFSWRqlw4F7zryeQQDR5OkGMMw3h
 DxPXSXw==
X-Google-Smtp-Source: AGHT+IFf1czkdh+ETjSuJEmYr1J0p9JERqR/2u2DFOzB9qCaOXXs9nYzukP1Etq5sXhJfHDRx51W1Q==
X-Received: by 2002:a5d:5c88:0:b0:374:c8e5:d56a with SMTP id
 ffacd0b85a97d-374c8e5d5a4mr3671026f8f.48.1725352724779; 
 Tue, 03 Sep 2024 01:38:44 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 00/16] Miscellaneous fixes
Date: Tue,  3 Sep 2024 10:37:57 +0200
Message-Id: <cover.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Miscellaneous fixes made when developing the lwIP series [1]. They are
posted separately since they make sense on their own. Subsequent
versions of the lwIP series will contain a squashed version of this one.

[1] http://patchwork.ozlabs.org/project/uboot/list/?series=420712&state=%2A&archive=both

Changes in v3:

- Apply R-b tags from Peter R.
- Rework "buildman/toolchain.py: set CROSS_COMPILE only if self.cross
is set". Subject changed to "buildman/toolchain.py: do not set
CROSS_COMPILE for sandbox", GetEnvArgs function fixed as well, and
test cases added. (Simon G.)

Changes in v2:

- Rebased onto master
- "flash: prefix error codes with FL_"
Update drivers/mtd/altera_qspi.c too. This was mentioned by Simon G.
in my lwIP v9 thread [1]. Tom R./Ilias A./Peter R.: I kept your R-b
tags, please shout if it's not OK.
- "net: fm: call dtsec_init_phy() only when it is defined"
Address Simon G.'s comments: update condition (parentheses,
CONFIG_BITBANGMII, if instead of #if).
Peter R: I dropped your R-b since the code changed significantly.
- New patches:
  "common: update: UPDATE_COMMON implies CMD_TFTPBOOT"
  "cmd: pxe: CMD_PXE implies CMD_TFTPBOOT"
  "buildman/toolchain.py: set CROSS_COMPILE only if self.cross is set"

[1] https://lists.denx.de/pipermail/u-boot/2024-August/563497.html

Jerome Forissier (16):
  Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
  buildman/toolchain.py: do not set CROSS_COMPILE for sandbox
  flash: prefix error codes with FL_
  at91: rename mem_init() to at91_mem_init()
  arm: omap2: add missing #include <netdev.h>
  net: fm: call dtsec_init_phy() only when it is defined
  net: wget: removed unused function wget_success()
  net: phy: ncsi: depend on NET
  net: ftgmac100: depend on NET
  net: wget: allow EFI boot
  net: fec_mxc_init(): do not ignore return status of fec_open()
  test/py: net_boot: fix comment
  test/py: test_efi_loader: add missing dependency on cmd_tftpboot
  test/py: test_efi_loader: add HTTP (wget) test for the EFI loader
  common: update: UPDATE_COMMON implies CMD_TFTPBOOT
  cmd: pxe: CMD_PXE implies CMD_TFTPBOOT

 Makefile                                      |  2 +-
 arch/arm/mach-at91/include/mach/at91_common.h |  2 +-
 arch/arm/mach-at91/spl_at91.c                 |  2 +-
 arch/arm/mach-at91/spl_atmel.c                |  2 +-
 arch/arm/mach-omap2/omap3/emac.c              |  1 +
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |  2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |  2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |  2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |  2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |  2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c         |  2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |  2 +-
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |  2 +-
 board/atmel/sama5d3xek/sama5d3xek.c           |  2 +-
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |  2 +-
 board/atmel/sama5d4ek/sama5d4ek.c             |  2 +-
 board/cobra5272/flash.c                       | 26 ++++----
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |  2 +-
 board/freescale/m5253demo/flash.c             |  6 +-
 board/gardena/smart-gateway-at91sam/spl.c     |  2 +-
 board/siemens/corvus/board.c                  |  2 +-
 board/siemens/smartweb/smartweb.c             |  2 +-
 board/siemens/taurus/taurus.c                 |  2 +-
 cmd/Kconfig                                   |  1 +
 common/Kconfig                                |  1 +
 common/flash.c                                | 44 ++++++-------
 drivers/mtd/altera_qspi.c                     |  4 +-
 drivers/mtd/cfi_flash.c                       | 36 +++++------
 drivers/net/Kconfig                           |  1 +
 drivers/net/fec_mxc.c                         |  3 +-
 drivers/net/fm/eth.c                          | 10 ++-
 drivers/net/phy/Kconfig                       |  1 +
 include/flash.h                               | 20 +++---
 net/wget.c                                    | 11 ++--
 test/py/tests/test_efi_loader.py              | 62 ++++++++++++++-----
 test/py/tests/test_net_boot.py                |  2 +-
 tools/buildman/test.py                        | 46 ++++++++++++++
 tools/buildman/toolchain.py                   |  6 +-
 38 files changed, 203 insertions(+), 118 deletions(-)

-- 
2.40.1

