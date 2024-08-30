Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B27CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D254688896;
	Fri, 30 Aug 2024 12:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VfPUe/0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC63A888C1; Fri, 30 Aug 2024 12:17:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898718817C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42bbc70cc19so3425535e9.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013041; x=1725617841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/MPcX4J/nKvfQZbm5Jwvt3IQGybrl2ThSOVeM+rcY70=;
 b=VfPUe/0cxgvNkwfvFadWhD2HZ4FB3hffWEqk4dYE7qf55WSRTLH2XOegc09ZDJDq1A
 bBDCqIl9Gl62rmBicnzNr5pqaNthXWwuq3AffiZBPJLlQ2BRceajZafFn+6R5qM59CHY
 zblEOBGF3DJrvmV7VaeZEEnB56Jj5d74lMKrAAed9/cm8qjk8m+7jba4lkDNy++q7gZ5
 ff6gUWr1fIdJNUlLhhMqy2HNoM072Zegbx3dzdP2SKMbpCpES2l1asm7Up3AWxz66qNT
 C6RoaM5IrW9XKkxrUy7PhjkPUB5LNhHUzQ9Ox4/MFNXlgxrlyhCoXoTEp+T5Unrgo2yu
 fTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013041; x=1725617841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/MPcX4J/nKvfQZbm5Jwvt3IQGybrl2ThSOVeM+rcY70=;
 b=E05rMDOSUCnjb+6SJGLbIh/oN7K1Ffxnj/jzmKB0EAdxOPGK9wrF3tiX3mFdwfxvO9
 NeomwZ6mSE7ptzGVsKYH5N2wBiM+umXhQQFzx57iYPk/QC/nqspBhQas1HRBm0M2e/3i
 rgnpXpVO/lamlrwMiKJeDnxIj55QUZ7PcaSLISsfFsqAlDkQiPbl40W8Jd6b/oAiQ0jH
 t9s7uLDQT0AfuZWLld0izhdRskwjLgLNTjzsmuWDPmN3x3cQnogYVUhUnEhj/G8p6x4K
 NJlpSAjOLU4HBcvOXnRQl6OWedqrccfViIcLjdy0va1CvC0Hql+QQXqJ67sC9x/J4Dnu
 X3kw==
X-Gm-Message-State: AOJu0Yxe/EQlN3poHqXfxQvtdxbgibtzpfxu++8QH9hLVIJvs7XROaKV
 +dwXegJgKor8OlcT7zZWH53xS6JqQ+rCvUy8VyNpiFDSL9M11C9p4J7pPQhjVKaImvGiTlabvgl
 qR6tevA==
X-Google-Smtp-Source: AGHT+IEZiCNQca2vN/IWoombqDwdG3+N5gIEyWzxfJlLUsaCk1ZAsVZUY2Bu2vvpyosnwOaE2nv0CA==
X-Received: by 2002:adf:8bd1:0:b0:362:8ec2:53d6 with SMTP id
 ffacd0b85a97d-3749b5948fdmr3849913f8f.61.1725013040585; 
 Fri, 30 Aug 2024 03:17:20 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:20 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 00/16] Miscellaneous fixes
Date: Fri, 30 Aug 2024 12:16:43 +0200
Message-Id: <cover.1725012294.git.jerome.forissier@linaro.org>
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
  buildman/toolchain.py: set CROSS_COMPILE only if self.cross is set
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
 tools/buildman/toolchain.py                   |  4 +-
 37 files changed, 155 insertions(+), 118 deletions(-)

-- 
2.40.1

