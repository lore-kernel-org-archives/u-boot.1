Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65330C54F32
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EFD88847;
	Wed, 28 Aug 2024 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wRvtwI4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36488892; Wed, 28 Aug 2024 14:10:44 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D4B88829
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3718b5e9c4fso3395511f8f.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847041; x=1725451841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xu3WO+pTgfqAA09HDKYQVGKGJnpCarAktqU4D5Hrs6k=;
 b=wRvtwI4QQ4ZuzhOt4VYOR+fv7LgO10YcIuv8cJpewnfWQgTDECfKEchANj7dHZdt2m
 DZ+/5tpangyiUfG4wFArM+iBVBl1aWMfsHpW2kp+zxnWGnb5aC+p5idmrXcqb0FfAeJc
 pkpZrYBkUi2FuB8Wz6WGSiW38Y8f6wFF4/NHbzFVUeyQi83508uiWgfg4DI1Q/Mn2MBx
 7i07iJ+DdubY0UOl9wKwtFX2Z0tvTWn8m9a9llslqsFrDuovlPNm4ufS4h1f9t8SyJy2
 u33y3GyRpe/EjJWm27eQvFTBYaMcA12kz8ssMMFkuMr6B6v9f062u2WP/O7AQ3PaX10H
 rIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847041; x=1725451841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xu3WO+pTgfqAA09HDKYQVGKGJnpCarAktqU4D5Hrs6k=;
 b=VMbNGku1TvAijwU8+5IcPVQp+EEfZuXWqn+H5BtkdxeWl7j86DdlmU8r8QDPBL265p
 VLpopRDhdlrDVcVWr46dLttP7D5DG6wt8A/Ey9HuvsETfhpQReUJV8oBhsvyibuzJN/2
 zLX7vpsIOZdDmEAVkPLR5K8Y0tnd3ADgVTpOWD6IVoku6VElPLonYEQK586oMuNuKWpv
 EYLf3x6AcGFCcPW/2eD2Ft6ma7Zzo0hlxJYgCZODS6G+HSblqlCBuXAX4wt35EA/avDk
 rBNLAT6Ro63iKWhx0GyxvLtWvRiu8b/hFqM33G3r8afx9SRQC8w4f3wEWQgy6U4MARIk
 +KPw==
X-Gm-Message-State: AOJu0Yzer9fCZjXHgfEZmn6dADbWb+irJZMhGki4+DKLI/FI/NzsP5Oo
 gkzH518vxkOQ1CJ+oA+paH08gcAFmB4ilZeVlyChBpT+8EuLImteYfFYtP0ZC0nZhrufMlfUfMs
 67H2eZA==
X-Google-Smtp-Source: AGHT+IGyvxUWGfdv5T9cyRohGrxaBLKhSFJqNG3Smmj4yV85Z3Cc7/XWcnezBtHqJ6336CgSQkZunw==
X-Received: by 2002:a5d:6247:0:b0:371:8d47:c17b with SMTP id
 ffacd0b85a97d-373118b8b17mr10557697f8f.30.1724847040867; 
 Wed, 28 Aug 2024 05:10:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:40 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 00/13] Miscellaneous fixes
Date: Wed, 28 Aug 2024 14:10:23 +0200
Message-Id: <cover.1724846454.git.jerome.forissier@linaro.org>
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

Miscellaneous fixes made when developing the lwIP series [1].

[1] http://patchwork.ozlabs.org/project/uboot/list/?series=420712&state=%2A&archive=both

Jerome Forissier (13):
  Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
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
 common/flash.c                                | 44 ++++++-------
 drivers/mtd/cfi_flash.c                       | 36 +++++------
 drivers/net/Kconfig                           |  1 +
 drivers/net/fec_mxc.c                         |  3 +-
 drivers/net/fm/eth.c                          |  2 +
 drivers/net/phy/Kconfig                       |  1 +
 include/flash.h                               | 20 +++---
 net/wget.c                                    | 11 ++--
 test/py/tests/test_efi_loader.py              | 62 ++++++++++++++-----
 test/py/tests/test_net_boot.py                |  2 +-
 33 files changed, 144 insertions(+), 111 deletions(-)

-- 
2.40.1

