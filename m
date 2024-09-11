Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730D2EE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7603C8917B;
	Wed, 11 Sep 2024 11:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+QV2h3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12388923D; Wed, 11 Sep 2024 11:58:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B0B8915D
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3787f30d892so4018917f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048727; x=1726653527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LE97g+NXU8jbE+uKkVXKJS8DO6I5shyTyPeSIfaJ7dI=;
 b=m+QV2h3URyRhwyel3Hd/q3XgxSWRhn6pCBVF/epwgc2YNv+NC2XEitPOYWsVW/2SNY
 rFs/XTbiUSunf+ViKeufTYBRIHB+FG83mr/dwoWjpqYsQzgUi9Q5uWFknrHAhNvF6snS
 EDSR/nWbiKhToUQ7HndzgiefJKCE+2XCwnvvaJbCyHptzhTkStMioUcKEnKPugBf2xjc
 BV9dRr8yMjBo5ThSrcBs4MxK5Vcv06a6npEQKNySqHYCZTyh0amsP/0vnH4P7xMB3Kuc
 cjv2PNGI9hu+7nnBI0aFjXFQjCe0pE/Sg5SxEL/q1pKx1AQ7mG8ILKLjviKyDqESFbwd
 5Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048727; x=1726653527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LE97g+NXU8jbE+uKkVXKJS8DO6I5shyTyPeSIfaJ7dI=;
 b=gVoFK+massqkZGt2uj4gy9bp8w0FLQ5mx51fLmmH6PsY4GspybL/eh1gWQ9Xia9/zI
 UdTRV3CK2egnAFd0e/FWRh4QTBCoeTa4JhnDPPBTS35ocbH4kei4PTynp1LDICjymKHg
 vWf9L0JClC4utK1+9G0+LGI+ASLRUtKvvxB9xEQnLhk00oaEhOiaDBOU4dxzQU2y8RjL
 jjLnuHs2vJa5GRZ5IhabBJ5HGgVRHUbnYYKDSBrCZ98bAxLsyRIMHCpzaYcoydXZWdxh
 gJL5C01drDC/R4GLsZnI7MfUWWIlqAYT+PdschPnvnTXS5kmdxG0xjDwvWqdN9Hcvcup
 l4AA==
X-Gm-Message-State: AOJu0YycVeqDZYRT/u810X4vDrHnGbU5987ek3hQM0lz133McDp5m9eT
 DNbkHH2QV+AvqNwZBlZ0uwbireGchTwnNaiuyMyDo6wucJMZT/si/5iQPsnGJqk2SxuCVFsSZUD
 1zvQOrg==
X-Google-Smtp-Source: AGHT+IEqKnBIsaQgIJsXjgc9hT8uOp3MAORQ3bZ/xtVN2/GA/XJ0fEyHk8CxvO2kikBFp9BxkyUi4A==
X-Received: by 2002:a5d:4f8c:0:b0:367:8a00:fac3 with SMTP id
 ffacd0b85a97d-378895d5318mr11650559f8f.30.1726048726451; 
 Wed, 11 Sep 2024 02:58:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 00/15] Miscellaneous fixes
Date: Wed, 11 Sep 2024 11:58:13 +0200
Message-Id: <cover.1726048404.git.jerome.forissier@linaro.org>
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

Changes in v4:

- "net: fm: call dtsec_init_phy() only when it is defined"
Use '#if CONFIG_IS_ENABLED()' not 'if IS_ENABLED()' which would still
cause an error.
- Drop "Makefile: detect HOST_ARCH properly when CROSS_COMPILE is
multi-word". The first use case mentioned in the patch description
(cross-compiling sandbox) is not valid, and the second one (buildman)
is actually addressed in another patch ("buildman/toolchain.py: do not
set CROSS_COMPILE for sandbox").
- Rebased onto next

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

Jerome Forissier (15):
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
 drivers/net/fm/eth.c                          |  6 +-
 drivers/net/phy/Kconfig                       |  1 +
 include/flash.h                               | 20 +++---
 net/wget.c                                    | 11 ++--
 test/py/tests/test_efi_loader.py              | 62 ++++++++++++++-----
 test/py/tests/test_net_boot.py                |  2 +-
 tools/buildman/test.py                        | 46 ++++++++++++++
 tools/buildman/toolchain.py                   |  6 +-
 37 files changed, 200 insertions(+), 115 deletions(-)

-- 
2.40.1

