Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E300E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 18:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337E486940;
	Sun,  8 Oct 2023 20:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLmIW3G6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A128691E; Sun,  8 Oct 2023 20:48:29 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA6681F44
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 20:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f57ad6126so44408027b3.3
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696790905; x=1697395705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aio8cq5xH2eoAxUvgwBJDc9coRXPQ+ECQA3sXxMFlYE=;
 b=OLmIW3G65Nx0WOeuS96EsT6KcOrVXm7xJMvEMf8YSto0PHcEGldmlqFbcqUTyC6YJk
 eoVKyA3Qcdl/5+AvehfZhUROAAv/VZyM7M0vdHUgI0K49pMUktc3Azb2k431NJiurYYC
 FEUiwqvAhouz7nTCl3lbjiP7SV/x/4PPK/R2QcWvD6J5OWHPo6FTBPn0NKFCPRGXSbPK
 apXEC8a16STf1VfK+cwn+WBNLep9J49eKwx7+/lSevhNHQ1sB5EqKp/jLVwi8LMtilHB
 oZ3pYgopdpvHPwdO9o9DvKxSOn6zEPfn68QsxRWQWMj4Pg9Uf163iUGsP/FFrLsCIaBT
 PXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696790905; x=1697395705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aio8cq5xH2eoAxUvgwBJDc9coRXPQ+ECQA3sXxMFlYE=;
 b=gpR5SL04YiZLPzqLQz2hb66YOH+PtkJsGpF7ZScH8N9lyWTC5NM+w0oYD/6jb2q7aE
 ojwQx1GcpLoS+dC3Gie1ryQmPzxI4b6hLZ/1iVqOW6HKl7Xg6u0t9m5+6XqmgzNtJga0
 9bA835NUTISAO4VlAV6QcVJ+nzuoci2Tn6stjUdPzOp+0F84p3dP1cOHZGCLTNybn25q
 5B5n0ZCOJWTySTB1Q0zYjS4IzKY3ZpyIzeUgEs86ro2M2UnncanALNM2KZGUpsR4vL4U
 DYE9zPPI+MEuiQvVWBoi6+2D6YGa3Sa1Pqe8lko8PZoqpid76611BBChFeSXdx1ioW1N
 ygtA==
X-Gm-Message-State: AOJu0YxQsRMB9stUj84xc/VTqud+IU2RAPmzhN+q6AdN6GTpYckTCbGT
 jGwWQPNqjWZKN5Gn9nlSXpqOh0yBl6vwGA==
X-Google-Smtp-Source: AGHT+IFQMw55POMf9bMYnnBwPSrTZs4F5zCGaxmHz9awrM9ovnvCh5F4vSgbqvxnv2irkFTHBx7W/w==
X-Received: by 2002:a0d:e88d:0:b0:59b:d7c0:ea0c with SMTP id
 r135-20020a0de88d000000b0059bd7c0ea0cmr14571791ywe.11.1696790904869; 
 Sun, 08 Oct 2023 11:48:24 -0700 (PDT)
Received: from localhost.localdomain ([192.34.165.40])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a81a250000000b0059b24bd4f2asm3003777ywg.57.2023.10.08.11.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 11:48:24 -0700 (PDT)
From: John Clark <inindev@gmail.com>
To: u-boot@lists.denx.de
Cc: John Clark <inindev@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v2 0/1] board: rockchip: add FriendlyElec NanoPC-T6 rk3588
 board
Date: Sun,  8 Oct 2023 18:46:32 +0000
Message-ID: <20231008184805.5088-1-inindev@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Jonas, thank you for your detailed review.  The explanations for each of config change recommendations were especially helpful.

As for the CFG_IRAM_BASE / BROM_LAST_BOOTSOURCE issue, I have made a step forward, but expect I will be getting feedback as to a better approach.

Note: This patchset is based on Kever's most recent pull request "u-boot-rockchip-20231007" which, as of this writing, has yet to be merged upstream.

Finally, I would appreciate any insight as to FriendlyElec vs FriendlyARM naming.  Currently, I have documented this as the "FriendlyARM NanoPC-T6" but it would seem that it could also be called the "FriendlyElec NanoPC-T6" and be equally correct.  It is worth noting that u-boot currently contains support for the "FriendlyARM NanoPi2" board/friendlyarm/nanopi2 and thus my use of FriendlyARM.

Changes in v2:
- resync dt from:
    https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/plain/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts?h=for-next
- config changes:
    -CONFIG_PCI_INIT_R=y
    -CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
    +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
    -CONFIG_REGULATOR_PWM=y
    -# CONFIG_USB_XHCI_DWC3_OF_SIMPLE is not set
    -CONFIG_SPL_USB_DWC3_GENERIC=y
- added board files:
    create mode 100644 board/friendlyarm/nanopct6-rk3588/Kconfig
    create mode 100644 board/friendlyarm/nanopct6-rk3588/MAINTAINERS
    create mode 100644 board/friendlyarm/nanopct6-rk3588/Makefile
    create mode 100644 board/friendlyarm/nanopct6-rk3588/nanopct6-rk3588.c
    create mode 100644 include/configs/nanopct6-rk3588.h
- improved BROM_LAST_BOOTSOURCE handling for SPI NOR:
    if (CONFIG_IS_ENABLED(TARGET_NANOPCT6_RK3588) && bootdevice_brom_id == 4)
        bootdevice_ofpath = boot_devices[BROM_BOOTSOURCE_SPINOR];
    else
        bootdevice_ofpath = boot_devices[bootdevice_brom_id];

-- 
2.42.0

