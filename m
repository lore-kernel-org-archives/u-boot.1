Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A13C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A83B8890D;
	Sun, 11 Aug 2024 16:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H08ZaMJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DABF587E9D; Sun, 11 Aug 2024 16:51:17 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF1C88907
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so122479539f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387873; x=1723992673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MpsEFh63exo6gClTy+PeQGFdcRJL8vkPmEG2vrUc4qU=;
 b=H08ZaMJRuQYDdVT/N1pnbVf5lNZrIdqz3qlhhaYqo9ewQlviV939sa7mRZDVsrbxR9
 c/OqJRCo2Uzm5fJC3spTlOvLyxF04k3+G/cZmB1zEk7baEdUzd1S15poHZingyE/QnH6
 nRCV5v0J4ROeDqIX4xg+dXQZjQMwFImkDOhmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387873; x=1723992673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MpsEFh63exo6gClTy+PeQGFdcRJL8vkPmEG2vrUc4qU=;
 b=vRRuL/ZPX32mdqtOcvPGFoxpceFThAoayTvZHyFUGlHVznUH2MhDB1YpGS4bamJrYV
 rgu8D6LMSLev5YiSfEfe02GS+LFgIZRqjrk5FGfZlM+kvysXZURtjPgRXrzvX66hTb77
 UNXC68LIpmqH6YnmLfKqBJZp1dAaTE23KNAlDEoQVN7bZhnrnREOi9cFc0lUHQK3YRlw
 rXGKtlitXegiEawL3lq5sLucCxANYy1eRWFz5NRqJM5ZVCNRc8lyJCATVmTQuUYEShOZ
 8qCdVPDFi6Dwqzn4mYqRa3VEPEt8xW03ZViVw4ucpRausnASnKKqqMgcGmd5oCTQqTM+
 7WDw==
X-Gm-Message-State: AOJu0Yw6j3PcK+HZqNAMcHmrsXrhHTEbG7tZoxxv1lTpdj1DFlVW+jXg
 drJ5+XoURFlvI2iyRnjsZkX/PHl6RNJJr6Jkmad4of1iCnVJABtncFOA5XWuPNxl3Q8gFUdHRCM
 =
X-Google-Smtp-Source: AGHT+IFmeofjNHITGXvZNlXandf5F15OM7xxQwp+rgf/iQdjyuRGMqI3UuF0ZbyOU2DmgYzRt85YXQ==
X-Received: by 2002:a92:cd8c:0:b0:39a:1b0a:f0a9 with SMTP id
 e9e14a558f8ab-39b7a459d5bmr90012065ab.23.1723387872991; 
 Sun, 11 Aug 2024 07:51:12 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH v2 00/18] i2c: Chip away at some old code
Date: Sun, 11 Aug 2024 08:50:29 -0600
Message-Id: <20240811145047.4189460-1-sjg@chromium.org>
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

This series aims to remove some of the older contents of i2c.h so that
we can move towards having just the dm API.

It does not remove any boards, but instead removes functionality.

Changes in v2:
- Drop omap3_beagle.h change as that board was removed
- Leave pg_wcom alone as its boards were converted
- Drop patch "pg-wcom: Drop CFG_SYS_I2C_MAX_HOPS"

Simon Glass (18):
  i2c: Remove board_i2c_init()
  i2c: Remove IC2_xxx enum
  i2c: Remove CFG_I2C_MULTI_BUS
  mips: malta: Drop CMD_DATE
  armv8: ls2085a: Drop CMD_DATE
  mx28 / mx51: Drop CMD_DATE
  MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
  rtc: Drop CFG_SYS_RTC_BUS_NUM
  date: Drop the legacy I2C code
  fsl: mxc: Drop legacy I2c
  i2c: Drop reference to SYS_I2C_INIT_BOARD
  octeon: Drop OCTEON_I2C_FDT dead code
  i2c: Remove I2C_SET_BUS()
  i2c: Remove I2C_GET_BUS()
  i2c: Drop CFG_SYS_MAX_I2C_BUS
  i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
  i2c: Remove CFG_SYS_I2C_MAX_HOPS
  i2c: Remove CFG_SYS_I2C_DIRECT_BUS

 README                             |  27 +-----
 arch/mips/mach-octeon/octeon_fdt.c |   7 --
 cmd/date.c                         |  32 -------
 cmd/i2c.c                          |  23 -----
 configs/MPC837XERDB_defconfig      |   1 -
 configs/ethernut5_defconfig        |   1 -
 configs/ls2080aqds_nand_defconfig  |   1 -
 configs/ls2080aqds_qspi_defconfig  |   1 -
 configs/ls2080ardb_nand_defconfig  |   1 -
 configs/malta64_defconfig          |   1 -
 configs/malta64el_defconfig        |   1 -
 configs/malta_defconfig            |   1 -
 configs/maltael_defconfig          |   1 -
 configs/mx28evk_defconfig          |   1 -
 configs/mx51evk_defconfig          |   1 -
 configs/work_92105_defconfig       |   1 -
 doc/I2C_Edge_Conditions            |  10 +-
 drivers/ddr/fsl/main.c             |   3 +-
 drivers/i2c/i2c_core.c             | 141 -----------------------------
 drivers/i2c/mxc_i2c.c              |   1 +
 drivers/i2c/soft_i2c.c             |  11 ---
 drivers/power/power_i2c.c          |   5 -
 drivers/usb/host/ohci-lpc32xx.c    |   4 -
 include/configs/ethernut5.h        |   3 -
 include/configs/ls1028aqds.h       |   1 -
 include/configs/ls1028ardb.h       |   2 -
 include/configs/ls1046afrwy.h      |   1 -
 include/configs/lx2160aqds.h       |   3 -
 include/configs/lx2160ardb.h       |   3 -
 include/configs/lx2162aqds.h       |   3 -
 include/configs/m53menlo.h         |   2 -
 include/configs/sniper.h           |  14 ---
 include/configs/tqma6.h            |   3 -
 include/configs/tqma6_wru4.h       |   1 -
 include/i2c.h                      | 107 ----------------------
 35 files changed, 7 insertions(+), 412 deletions(-)

-- 
2.34.1

