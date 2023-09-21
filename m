Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AF4E7D0B4
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 23:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85569864CB;
	Fri, 22 Sep 2023 01:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AA7ILmY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B5586400; Fri, 22 Sep 2023 01:32:57 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E118556F
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 01:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d8168d08bebso1908405276.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695339172; x=1695943972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8inyfGZNgwS9SinzfcwD/mcQaLOQhYEKmTozNjfV/vs=;
 b=AA7ILmY+M9CjJzOgdw+GxrqmiAGLbhD/RA0EgMdLJiCQKM5E0pHVkaFEKNJdPasJjK
 4JD7uQ5jpqWyVSYnGE1JgsjOjBgzYib/XaTL8L9vS4qs9m5Dw7Ar3Vz42kqOWvtSfuZg
 4eA8wvZkFd4lzE5h8JS76imhD7H7uMt2A3oLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695339172; x=1695943972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8inyfGZNgwS9SinzfcwD/mcQaLOQhYEKmTozNjfV/vs=;
 b=aaiVfAqkHvTguOzjP6WtOJ14fUpexXhRk+dMA18xkb88p5xJguid9H4ilOw4CcvLo3
 IN8vsCIw8v5li0W9+bnydmnhGUWAkr9NnXQ2GLnOPxRCfXrIUEHBAoTy+PuEXNJ/bgqw
 N90+hWN5rCGlneQtvPc5Ij3av+1J0XL0+5jdN4VfCS263MrTbRkcmdaI+WFK7qA4GKEm
 IoXSWysUuHxhoIgcfj2SLM0tREVxIgTDiHqEV7T4S9nzlO7m5VUCiOZ2GgmIavEHS5r4
 Ilq2uIABpIN46AqllV4WmtU0PWavoz5oKeSaflsxJb2YTjeqwjry37Vm/v7wHEWx6a3Z
 EfAA==
X-Gm-Message-State: AOJu0YwJoZx4Yo2v4fUE5sAod9KKiL1wrEwWhEUlKZINT3dM/p5E735z
 cmSQbyUo0E8aC4zpjwCvxPbliuizhs0nkipwICluYg==
X-Google-Smtp-Source: AGHT+IGDt9Xt6VvKJqHAgpXeS3GAaVajUtt1eXiZMd/C02/bpP0cRAbeOUzabGeAbF70SzpHQW4VGQ==
X-Received: by 2002:a25:c589:0:b0:d81:7041:951e with SMTP id
 v131-20020a25c589000000b00d817041951emr6023577ybe.41.1695339171639; 
 Thu, 21 Sep 2023 16:32:51 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a25808b000000b00d8168e226e6sm566793ybk.47.2023.09.21.16.32.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 16:32:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/3] board: Remove essentially empty board files and Makefiles
Date: Thu, 21 Sep 2023 19:32:47 -0400
Message-Id: <20230921233248.159047-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921233248.159047-1-trini@konsulko.com>
References: <20230921233248.159047-1-trini@konsulko.com>
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

As part of reviewing a new platform, Daniel Schwierzeck noted that we
can have an empty Makefile in the board directory and don't need an
empty board.c file as well.  Further with further cleanup in the
Makefile we can now omit the Makefile entirely. Remove a number of now
unnecessary board.c and Makefiles.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/altera/arria10-socdk/Makefile               |  5 -----
 board/altera/arria10-socdk/socfpga.c              |  6 ------
 board/altera/arria5-socdk/Makefile                |  7 -------
 board/altera/arria5-socdk/socfpga.c               |  5 -----
 board/altera/cyclone5-socdk/Makefile              |  7 -------
 board/altera/cyclone5-socdk/socfpga.c             |  5 -----
 board/altera/stratix10-socdk/Makefile             |  7 -------
 board/altera/stratix10-socdk/socfpga.c            |  7 -------
 board/aries/mcvevk/Makefile                       |  7 -------
 board/aries/mcvevk/socfpga.c                      |  5 -----
 board/aspeed/evb_ast2500/Makefile                 |  1 -
 board/aspeed/evb_ast2500/evb_ast2500.c            |  5 -----
 board/aspeed/evb_ast2600/Makefile                 |  1 -
 board/aspeed/evb_ast2600/evb_ast2600.c            |  5 -----
 board/broadcom/bcm968380gerg/Makefile             |  3 ---
 board/broadcom/bcm968380gerg/bcm968380gerg.c      |  6 ------
 board/broadcom/bcm968380gerg/board.c              |  6 ------
 board/comtrend/ar5315u/Makefile                   |  3 ---
 board/comtrend/ar5315u/ar-5315u.c                 |  6 ------
 board/comtrend/ar5387un/Makefile                  |  3 ---
 board/comtrend/ar5387un/ar-5387un.c               |  6 ------
 board/comtrend/ct5361/Makefile                    |  3 ---
 board/comtrend/ct5361/ct-5361.c                   |  6 ------
 board/comtrend/vr3032u/Makefile                   |  3 ---
 board/comtrend/vr3032u/vr-3032u.c                 |  6 ------
 board/comtrend/wap5813n/Makefile                  |  3 ---
 board/comtrend/wap5813n/wap-5813n.c               |  6 ------
 board/devboards/dbm-soc1/Makefile                 |  5 -----
 board/devboards/dbm-soc1/socfpga.c                |  5 -----
 board/ebv/socrates/Makefile                       |  7 -------
 board/ebv/socrates/socfpga.c                      |  5 -----
 board/edgeble/neural-compute-module-2/Makefile    |  7 -------
 board/edgeble/neural-compute-module-2/neu2.c      |  4 ----
 board/edgeble/neural-compute-module-6/Makefile    |  7 -------
 board/edgeble/neural-compute-module-6/neu6.c      |  4 ----
 board/efi/efi-x86_app/Makefile                    |  5 -----
 board/efi/efi-x86_app/app.c                       |  6 ------
 board/emulation/qemu-x86/Makefile                 |  5 -----
 board/emulation/qemu-x86/qemu-x86.c               |  0
 board/engicam/px30_core/Makefile                  |  7 -------
 board/engicam/px30_core/px30_core.c               |  4 ----
 board/geekbuying/geekbox/Makefile                 |  5 -----
 board/geekbuying/geekbox/geekbox.c                |  6 ------
 board/google/chromebook_link/Makefile             | 13 -------------
 board/google/chromebook_link/link.c               |  6 ------
 board/google/chromebook_samus/Makefile            |  5 -----
 board/google/chromebook_samus/samus.c             |  6 ------
 board/google/chromebox_panther/Makefile           |  5 -----
 board/google/chromebox_panther/panther.c          |  6 ------
 board/hardkernel/odroid_m1/Makefile               |  3 ---
 board/hardkernel/odroid_m1/odroid_m1.c            |  1 -
 board/huawei/hg556a/Makefile                      |  3 ---
 board/huawei/hg556a/hg556a.c                      |  6 ------
 board/intel/agilex-socdk/Makefile                 |  7 -------
 board/intel/agilex-socdk/socfpga.c                |  7 -------
 board/intel/bayleybay/Makefile                    |  1 -
 board/intel/bayleybay/bayleybay.c                 |  7 -------
 board/intel/n5x-socdk/Makefile                    |  7 -------
 board/intel/n5x-socdk/socfpga.c                   |  7 -------
 board/is1/Makefile                                |  5 -----
 board/is1/socfpga.c                               |  4 ----
 board/mediatek/mt7620/Makefile                    |  3 ---
 board/mediatek/mt7620/board.c                     |  6 ------
 board/mediatek/mt7621/Makefile                    |  3 ---
 board/mediatek/mt7621/board.c                     |  6 ------
 board/mediatek/mt7628/Makefile                    |  3 ---
 board/mediatek/mt7628/board.c                     |  8 --------
 board/mqmaker/miqi_rk3288/Makefile                |  7 -------
 board/mqmaker/miqi_rk3288/miqi-rk3288.c           |  4 ----
 board/netgear/cg3100d/Makefile                    |  3 ---
 board/netgear/cg3100d/cg3100d.c                   |  6 ------
 board/pine64/quartz64_rk3566/Makefile             |  3 ---
 board/pine64/quartz64_rk3566/quartz64-rk3566.c    |  1 -
 board/qualcomm/dragonboard845c/Makefile           |  9 ---------
 board/qualcomm/dragonboard845c/dragonboard845c.c  |  9 ---------
 board/radxa/rock/Makefile                         |  7 -------
 board/radxa/rock/rock.c                           |  6 ------
 board/radxa/rock2/Makefile                        |  7 -------
 board/radxa/rock2/rock2.c                         |  6 ------
 board/rikomagic/mk808/Makefile                    |  3 ---
 board/rikomagic/mk808/mk808.c                     |  3 ---
 board/rockchip/evb_px30/Makefile                  |  7 -------
 board/rockchip/evb_px30/evb_px30.c                |  4 ----
 board/rockchip/evb_px5/Makefile                   |  5 -----
 board/rockchip/evb_px5/evb-px5.c                  |  4 ----
 board/rockchip/evb_rk3128/Makefile                |  5 -----
 board/rockchip/evb_rk3128/evk-rk3128.c            |  0
 board/rockchip/evb_rk3229/Makefile                |  7 -------
 board/rockchip/evb_rk3229/evb_rk3229.c            |  9 ---------
 board/rockchip/evb_rk3288/Makefile                |  7 -------
 board/rockchip/evb_rk3288/evb-rk3288.c            |  4 ----
 board/rockchip/evb_rk3328/Makefile                |  7 -------
 board/rockchip/evb_rk3328/evb-rk3328.c            |  4 ----
 board/rockchip/evb_rk3568/Makefile                |  7 -------
 board/rockchip/evb_rk3568/evb_rk3568.c            |  4 ----
 board/rockchip/sheep_rk3368/Makefile              |  5 -----
 board/rockchip/sheep_rk3368/sheep_rk3368.c        |  4 ----
 board/sagem/f@st1704/Makefile                     |  3 ---
 board/sagem/f@st1704/f@st1704.c                   |  6 ------
 board/samsung/starqltechn/Makefile                |  9 ---------
 board/samsung/starqltechn/starqltechn.c           | 10 ----------
 board/sfr/nb4_ser/Makefile                        |  3 ---
 board/sfr/nb4_ser/nb4-ser.c                       |  6 ------
 board/terasic/de0-nano-soc/Makefile               |  7 -------
 board/terasic/de0-nano-soc/socfpga.c              |  5 -----
 board/terasic/de10-nano/Makefile                  |  6 ------
 board/terasic/de10-nano/socfpga.c                 |  5 -----
 board/terasic/de10-standard/Makefile              |  6 ------
 board/terasic/de10-standard/socfpga.c             |  5 -----
 board/terasic/sockit/Makefile                     |  7 -------
 board/terasic/sockit/socfpga.c                    |  5 -----
 board/theobroma-systems/lion_rk3368/Makefile      |  5 -----
 board/theobroma-systems/lion_rk3368/lion_rk3368.c |  4 ----
 board/vocore/vocore2/Makefile                     |  3 ---
 board/vocore/vocore2/board.c                      |  6 ------
 115 files changed, 601 deletions(-)
 delete mode 100644 board/altera/arria10-socdk/Makefile
 delete mode 100644 board/altera/arria10-socdk/socfpga.c
 delete mode 100644 board/altera/arria5-socdk/Makefile
 delete mode 100644 board/altera/arria5-socdk/socfpga.c
 delete mode 100644 board/altera/cyclone5-socdk/Makefile
 delete mode 100644 board/altera/cyclone5-socdk/socfpga.c
 delete mode 100644 board/altera/stratix10-socdk/Makefile
 delete mode 100644 board/altera/stratix10-socdk/socfpga.c
 delete mode 100644 board/aries/mcvevk/Makefile
 delete mode 100644 board/aries/mcvevk/socfpga.c
 delete mode 100644 board/aspeed/evb_ast2500/Makefile
 delete mode 100644 board/aspeed/evb_ast2500/evb_ast2500.c
 delete mode 100644 board/aspeed/evb_ast2600/Makefile
 delete mode 100644 board/aspeed/evb_ast2600/evb_ast2600.c
 delete mode 100644 board/broadcom/bcm968380gerg/Makefile
 delete mode 100644 board/broadcom/bcm968380gerg/bcm968380gerg.c
 delete mode 100644 board/broadcom/bcm968380gerg/board.c
 delete mode 100644 board/comtrend/ar5315u/Makefile
 delete mode 100644 board/comtrend/ar5315u/ar-5315u.c
 delete mode 100644 board/comtrend/ar5387un/Makefile
 delete mode 100644 board/comtrend/ar5387un/ar-5387un.c
 delete mode 100644 board/comtrend/ct5361/Makefile
 delete mode 100644 board/comtrend/ct5361/ct-5361.c
 delete mode 100644 board/comtrend/vr3032u/Makefile
 delete mode 100644 board/comtrend/vr3032u/vr-3032u.c
 delete mode 100644 board/comtrend/wap5813n/Makefile
 delete mode 100644 board/comtrend/wap5813n/wap-5813n.c
 delete mode 100644 board/devboards/dbm-soc1/Makefile
 delete mode 100644 board/devboards/dbm-soc1/socfpga.c
 delete mode 100644 board/ebv/socrates/Makefile
 delete mode 100644 board/ebv/socrates/socfpga.c
 delete mode 100644 board/edgeble/neural-compute-module-2/Makefile
 delete mode 100644 board/edgeble/neural-compute-module-2/neu2.c
 delete mode 100644 board/edgeble/neural-compute-module-6/Makefile
 delete mode 100644 board/edgeble/neural-compute-module-6/neu6.c
 delete mode 100644 board/efi/efi-x86_app/Makefile
 delete mode 100644 board/efi/efi-x86_app/app.c
 delete mode 100644 board/emulation/qemu-x86/Makefile
 delete mode 100644 board/emulation/qemu-x86/qemu-x86.c
 delete mode 100644 board/engicam/px30_core/Makefile
 delete mode 100644 board/engicam/px30_core/px30_core.c
 delete mode 100644 board/geekbuying/geekbox/Makefile
 delete mode 100644 board/geekbuying/geekbox/geekbox.c
 delete mode 100644 board/google/chromebook_link/Makefile
 delete mode 100644 board/google/chromebook_link/link.c
 delete mode 100644 board/google/chromebook_samus/Makefile
 delete mode 100644 board/google/chromebook_samus/samus.c
 delete mode 100644 board/google/chromebox_panther/Makefile
 delete mode 100644 board/google/chromebox_panther/panther.c
 delete mode 100644 board/hardkernel/odroid_m1/Makefile
 delete mode 100644 board/hardkernel/odroid_m1/odroid_m1.c
 delete mode 100644 board/huawei/hg556a/Makefile
 delete mode 100644 board/huawei/hg556a/hg556a.c
 delete mode 100644 board/intel/agilex-socdk/Makefile
 delete mode 100644 board/intel/agilex-socdk/socfpga.c
 delete mode 100644 board/intel/bayleybay/bayleybay.c
 delete mode 100644 board/intel/n5x-socdk/Makefile
 delete mode 100644 board/intel/n5x-socdk/socfpga.c
 delete mode 100644 board/is1/Makefile
 delete mode 100644 board/is1/socfpga.c
 delete mode 100644 board/mediatek/mt7620/Makefile
 delete mode 100644 board/mediatek/mt7620/board.c
 delete mode 100644 board/mediatek/mt7621/Makefile
 delete mode 100644 board/mediatek/mt7621/board.c
 delete mode 100644 board/mediatek/mt7628/Makefile
 delete mode 100644 board/mediatek/mt7628/board.c
 delete mode 100644 board/mqmaker/miqi_rk3288/Makefile
 delete mode 100644 board/mqmaker/miqi_rk3288/miqi-rk3288.c
 delete mode 100644 board/netgear/cg3100d/Makefile
 delete mode 100644 board/netgear/cg3100d/cg3100d.c
 delete mode 100644 board/pine64/quartz64_rk3566/Makefile
 delete mode 100644 board/pine64/quartz64_rk3566/quartz64-rk3566.c
 delete mode 100644 board/qualcomm/dragonboard845c/Makefile
 delete mode 100644 board/qualcomm/dragonboard845c/dragonboard845c.c
 delete mode 100644 board/radxa/rock/Makefile
 delete mode 100644 board/radxa/rock/rock.c
 delete mode 100644 board/radxa/rock2/Makefile
 delete mode 100644 board/radxa/rock2/rock2.c
 delete mode 100644 board/rikomagic/mk808/Makefile
 delete mode 100644 board/rikomagic/mk808/mk808.c
 delete mode 100644 board/rockchip/evb_px30/Makefile
 delete mode 100644 board/rockchip/evb_px30/evb_px30.c
 delete mode 100644 board/rockchip/evb_px5/Makefile
 delete mode 100644 board/rockchip/evb_px5/evb-px5.c
 delete mode 100644 board/rockchip/evb_rk3128/Makefile
 delete mode 100644 board/rockchip/evb_rk3128/evk-rk3128.c
 delete mode 100644 board/rockchip/evb_rk3229/Makefile
 delete mode 100644 board/rockchip/evb_rk3229/evb_rk3229.c
 delete mode 100644 board/rockchip/evb_rk3288/Makefile
 delete mode 100644 board/rockchip/evb_rk3288/evb-rk3288.c
 delete mode 100644 board/rockchip/evb_rk3328/Makefile
 delete mode 100644 board/rockchip/evb_rk3328/evb-rk3328.c
 delete mode 100644 board/rockchip/evb_rk3568/Makefile
 delete mode 100644 board/rockchip/evb_rk3568/evb_rk3568.c
 delete mode 100644 board/rockchip/sheep_rk3368/Makefile
 delete mode 100644 board/rockchip/sheep_rk3368/sheep_rk3368.c
 delete mode 100644 board/sagem/f@st1704/Makefile
 delete mode 100644 board/sagem/f@st1704/f@st1704.c
 delete mode 100644 board/samsung/starqltechn/Makefile
 delete mode 100644 board/samsung/starqltechn/starqltechn.c
 delete mode 100644 board/sfr/nb4_ser/Makefile
 delete mode 100644 board/sfr/nb4_ser/nb4-ser.c
 delete mode 100644 board/terasic/de0-nano-soc/Makefile
 delete mode 100644 board/terasic/de0-nano-soc/socfpga.c
 delete mode 100644 board/terasic/de10-nano/Makefile
 delete mode 100644 board/terasic/de10-nano/socfpga.c
 delete mode 100644 board/terasic/de10-standard/Makefile
 delete mode 100644 board/terasic/de10-standard/socfpga.c
 delete mode 100644 board/terasic/sockit/Makefile
 delete mode 100644 board/terasic/sockit/socfpga.c
 delete mode 100644 board/theobroma-systems/lion_rk3368/Makefile
 delete mode 100644 board/theobroma-systems/lion_rk3368/lion_rk3368.c
 delete mode 100644 board/vocore/vocore2/Makefile
 delete mode 100644 board/vocore/vocore2/board.c

diff --git a/board/altera/arria10-socdk/Makefile b/board/altera/arria10-socdk/Makefile
deleted file mode 100644
index 80d00043464e..000000000000
--- a/board/altera/arria10-socdk/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Copyright (C) 2015 Altera Corporation <www.altera.com>
-
-obj-y	:= socfpga.o
diff --git a/board/altera/arria10-socdk/socfpga.c b/board/altera/arria10-socdk/socfpga.c
deleted file mode 100644
index 4c466cb9444c..000000000000
--- a/board/altera/arria10-socdk/socfpga.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2015 Altera Corporation <www.altera.com>
- */
-
-#include <common.h>
diff --git a/board/altera/arria5-socdk/Makefile b/board/altera/arria5-socdk/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/altera/arria5-socdk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/altera/arria5-socdk/socfpga.c b/board/altera/arria5-socdk/socfpga.c
deleted file mode 100644
index 48bfe3295179..000000000000
--- a/board/altera/arria5-socdk/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- */
-#include <common.h>
diff --git a/board/altera/cyclone5-socdk/Makefile b/board/altera/cyclone5-socdk/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/altera/cyclone5-socdk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/altera/cyclone5-socdk/socfpga.c b/board/altera/cyclone5-socdk/socfpga.c
deleted file mode 100644
index 48bfe3295179..000000000000
--- a/board/altera/cyclone5-socdk/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- */
-#include <common.h>
diff --git a/board/altera/stratix10-socdk/Makefile b/board/altera/stratix10-socdk/Makefile
deleted file mode 100644
index 02a9cadf769a..000000000000
--- a/board/altera/stratix10-socdk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (C) 2016-2017 Intel Corporation <www.intel.com>
-#
-# SPDX-License-Identifier:	GPL-2.0
-#
-
-obj-y	:= socfpga.o
diff --git a/board/altera/stratix10-socdk/socfpga.c b/board/altera/stratix10-socdk/socfpga.c
deleted file mode 100644
index 043fc543f1d7..000000000000
--- a/board/altera/stratix10-socdk/socfpga.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2016-2018 Intel Corporation <www.intel.com>
- *
- */
-
-#include <common.h>
diff --git a/board/aries/mcvevk/Makefile b/board/aries/mcvevk/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/aries/mcvevk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/aries/mcvevk/socfpga.c b/board/aries/mcvevk/socfpga.c
deleted file mode 100644
index f173bf84ac67..000000000000
--- a/board/aries/mcvevk/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Marek Vasut <marex@denx.de>
- */
-#include <common.h>
diff --git a/board/aspeed/evb_ast2500/Makefile b/board/aspeed/evb_ast2500/Makefile
deleted file mode 100644
index 4564098299df..000000000000
--- a/board/aspeed/evb_ast2500/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += evb_ast2500.o
diff --git a/board/aspeed/evb_ast2500/evb_ast2500.c b/board/aspeed/evb_ast2500/evb_ast2500.c
deleted file mode 100644
index ed162c4095fc..000000000000
--- a/board/aspeed/evb_ast2500/evb_ast2500.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2016 Google, Inc
- */
-#include <common.h>
diff --git a/board/aspeed/evb_ast2600/Makefile b/board/aspeed/evb_ast2600/Makefile
deleted file mode 100644
index 9291db6ee101..000000000000
--- a/board/aspeed/evb_ast2600/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += evb_ast2600.o
diff --git a/board/aspeed/evb_ast2600/evb_ast2600.c b/board/aspeed/evb_ast2600/evb_ast2600.c
deleted file mode 100644
index e6dc8c795254..000000000000
--- a/board/aspeed/evb_ast2600/evb_ast2600.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) Aspeed Technology Inc.
- */
-#include <common.h>
diff --git a/board/broadcom/bcm968380gerg/Makefile b/board/broadcom/bcm968380gerg/Makefile
deleted file mode 100644
index a525b7b9b36e..000000000000
--- a/board/broadcom/bcm968380gerg/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += bcm968380gerg.o
diff --git a/board/broadcom/bcm968380gerg/bcm968380gerg.c b/board/broadcom/bcm968380gerg/bcm968380gerg.c
deleted file mode 100644
index 044b3554ba18..000000000000
--- a/board/broadcom/bcm968380gerg/bcm968380gerg.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Philippe Reynes <philippe.reynes@softathome.com>
- */
-
-#include <common.h>
diff --git a/board/broadcom/bcm968380gerg/board.c b/board/broadcom/bcm968380gerg/board.c
deleted file mode 100644
index 044b3554ba18..000000000000
--- a/board/broadcom/bcm968380gerg/board.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Philippe Reynes <philippe.reynes@softathome.com>
- */
-
-#include <common.h>
diff --git a/board/comtrend/ar5315u/Makefile b/board/comtrend/ar5315u/Makefile
deleted file mode 100644
index 25656a8cac33..000000000000
--- a/board/comtrend/ar5315u/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += ar-5315u.o
diff --git a/board/comtrend/ar5315u/ar-5315u.c b/board/comtrend/ar5315u/ar-5315u.c
deleted file mode 100644
index 3437985878ec..000000000000
--- a/board/comtrend/ar5315u/ar-5315u.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/comtrend/ar5387un/Makefile b/board/comtrend/ar5387un/Makefile
deleted file mode 100644
index 572ae1f0916e..000000000000
--- a/board/comtrend/ar5387un/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += ar-5387un.o
diff --git a/board/comtrend/ar5387un/ar-5387un.c b/board/comtrend/ar5387un/ar-5387un.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/comtrend/ar5387un/ar-5387un.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/comtrend/ct5361/Makefile b/board/comtrend/ct5361/Makefile
deleted file mode 100644
index 8b41c4a07e0c..000000000000
--- a/board/comtrend/ct5361/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += ct-5361.o
diff --git a/board/comtrend/ct5361/ct-5361.c b/board/comtrend/ct5361/ct-5361.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/comtrend/ct5361/ct-5361.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/comtrend/vr3032u/Makefile b/board/comtrend/vr3032u/Makefile
deleted file mode 100644
index 3542fea5874e..000000000000
--- a/board/comtrend/vr3032u/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += vr-3032u.o
diff --git a/board/comtrend/vr3032u/vr-3032u.c b/board/comtrend/vr3032u/vr-3032u.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/comtrend/vr3032u/vr-3032u.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/comtrend/wap5813n/Makefile b/board/comtrend/wap5813n/Makefile
deleted file mode 100644
index b8d4a6d5fd23..000000000000
--- a/board/comtrend/wap5813n/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += wap-5813n.o
diff --git a/board/comtrend/wap5813n/wap-5813n.c b/board/comtrend/wap5813n/wap-5813n.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/comtrend/wap5813n/wap-5813n.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/devboards/dbm-soc1/Makefile b/board/devboards/dbm-soc1/Makefile
deleted file mode 100644
index 88621b04c567..000000000000
--- a/board/devboards/dbm-soc1/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2018 Marek Vasut <marex@denx.de>
-
-obj-y	:= socfpga.o
diff --git a/board/devboards/dbm-soc1/socfpga.c b/board/devboards/dbm-soc1/socfpga.c
deleted file mode 100644
index a907ee605e65..000000000000
--- a/board/devboards/dbm-soc1/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Marek Vasut <marex@denx.de>
- */
-#include <common.h>
diff --git a/board/ebv/socrates/Makefile b/board/ebv/socrates/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/ebv/socrates/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/ebv/socrates/socfpga.c b/board/ebv/socrates/socfpga.c
deleted file mode 100644
index 48bfe3295179..000000000000
--- a/board/ebv/socrates/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- */
-#include <common.h>
diff --git a/board/edgeble/neural-compute-module-2/Makefile b/board/edgeble/neural-compute-module-2/Makefile
deleted file mode 100644
index 3bfc89fa1531..000000000000
--- a/board/edgeble/neural-compute-module-2/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y += neu2.o
diff --git a/board/edgeble/neural-compute-module-2/neu2.c b/board/edgeble/neural-compute-module-2/neu2.c
deleted file mode 100644
index 3d2262ce977e..000000000000
--- a/board/edgeble/neural-compute-module-2/neu2.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
- */
diff --git a/board/edgeble/neural-compute-module-6/Makefile b/board/edgeble/neural-compute-module-6/Makefile
deleted file mode 100644
index 28310b1b3458..000000000000
--- a/board/edgeble/neural-compute-module-6/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y += neu6.o
diff --git a/board/edgeble/neural-compute-module-6/neu6.c b/board/edgeble/neural-compute-module-6/neu6.c
deleted file mode 100644
index 3d2262ce977e..000000000000
--- a/board/edgeble/neural-compute-module-6/neu6.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
- */
diff --git a/board/efi/efi-x86_app/Makefile b/board/efi/efi-x86_app/Makefile
deleted file mode 100644
index cb48d1ccc209..000000000000
--- a/board/efi/efi-x86_app/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2015 Google, Inc
-
-obj-y	+= app.o
diff --git a/board/efi/efi-x86_app/app.c b/board/efi/efi-x86_app/app.c
deleted file mode 100644
index da3445bb1d52..000000000000
--- a/board/efi/efi-x86_app/app.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/emulation/qemu-x86/Makefile b/board/emulation/qemu-x86/Makefile
deleted file mode 100644
index ff4aaa51c540..000000000000
--- a/board/emulation/qemu-x86/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
-
-obj-y	+= qemu-x86.o
diff --git a/board/emulation/qemu-x86/qemu-x86.c b/board/emulation/qemu-x86/qemu-x86.c
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/board/engicam/px30_core/Makefile b/board/engicam/px30_core/Makefile
deleted file mode 100644
index 321fdb01731d..000000000000
--- a/board/engicam/px30_core/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (c) 2020 Amarula Solutions(India)
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= px30_core.o
diff --git a/board/engicam/px30_core/px30_core.c b/board/engicam/px30_core/px30_core.c
deleted file mode 100644
index 3adc2f11deac..000000000000
--- a/board/engicam/px30_core/px30_core.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2020 Amarula Solutions(India)
- */
diff --git a/board/geekbuying/geekbox/Makefile b/board/geekbuying/geekbox/Makefile
deleted file mode 100644
index ced2ff75a55d..000000000000
--- a/board/geekbuying/geekbox/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2016 Andreas Färber
-
-obj-y	+= geekbox.o
diff --git a/board/geekbuying/geekbox/geekbox.c b/board/geekbuying/geekbox/geekbox.c
deleted file mode 100644
index b0f9a5f9b70c..000000000000
--- a/board/geekbuying/geekbox/geekbox.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2016 Andreas Färber
- */
-
-#include <common.h>
diff --git a/board/google/chromebook_link/Makefile b/board/google/chromebook_link/Makefile
deleted file mode 100644
index d84a84899d1c..000000000000
--- a/board/google/chromebook_link/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2011 The Chromium OS Authors.
-# (C) Copyright 2008
-# Graeme Russ, graeme.russ@gmail.com.
-#
-# (C) Copyright 2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-#
-# (C) Copyright 2002
-# Daniel Engström, Omicron Ceti AB, daniel@omicron.se.
-
-obj-y	+= link.o
diff --git a/board/google/chromebook_link/link.c b/board/google/chromebook_link/link.c
deleted file mode 100644
index e357e6218e3e..000000000000
--- a/board/google/chromebook_link/link.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2014 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/google/chromebook_samus/Makefile b/board/google/chromebook_samus/Makefile
deleted file mode 100644
index 68c9e4993d6e..000000000000
--- a/board/google/chromebook_samus/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2016 Google, Inc
-
-obj-y	+= samus.o
diff --git a/board/google/chromebook_samus/samus.c b/board/google/chromebook_samus/samus.c
deleted file mode 100644
index 83edf89106ac..000000000000
--- a/board/google/chromebook_samus/samus.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2016 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/google/chromebox_panther/Makefile b/board/google/chromebox_panther/Makefile
deleted file mode 100644
index 1a5518f1341a..000000000000
--- a/board/google/chromebox_panther/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2015 Google, Inc
-
-obj-y	+= panther.o
diff --git a/board/google/chromebox_panther/panther.c b/board/google/chromebox_panther/panther.c
deleted file mode 100644
index da3445bb1d52..000000000000
--- a/board/google/chromebox_panther/panther.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/hardkernel/odroid_m1/Makefile b/board/hardkernel/odroid_m1/Makefile
deleted file mode 100644
index ae8ea3d9781c..000000000000
--- a/board/hardkernel/odroid_m1/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y	+= odroid_m1.o
diff --git a/board/hardkernel/odroid_m1/odroid_m1.c b/board/hardkernel/odroid_m1/odroid_m1.c
deleted file mode 100644
index 4c027f2a7af9..000000000000
--- a/board/hardkernel/odroid_m1/odroid_m1.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
diff --git a/board/huawei/hg556a/Makefile b/board/huawei/hg556a/Makefile
deleted file mode 100644
index 43e9be6bbafb..000000000000
--- a/board/huawei/hg556a/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += hg556a.o
diff --git a/board/huawei/hg556a/hg556a.c b/board/huawei/hg556a/hg556a.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/huawei/hg556a/hg556a.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/intel/agilex-socdk/Makefile b/board/intel/agilex-socdk/Makefile
deleted file mode 100644
index b86223a57143..000000000000
--- a/board/intel/agilex-socdk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (C) 2019 Intel Corporation <www.intel.com>
-#
-# SPDX-License-Identifier:	GPL-2.0
-#
-
-obj-y	:= socfpga.o
diff --git a/board/intel/agilex-socdk/socfpga.c b/board/intel/agilex-socdk/socfpga.c
deleted file mode 100644
index 72a3e0836db8..000000000000
--- a/board/intel/agilex-socdk/socfpga.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2019 Intel Corporation <www.intel.com>
- *
- */
-
-#include <common.h>
diff --git a/board/intel/bayleybay/Makefile b/board/intel/bayleybay/Makefile
index fa263b7bf54b..8b9934f99681 100644
--- a/board/intel/bayleybay/Makefile
+++ b/board/intel/bayleybay/Makefile
@@ -2,5 +2,4 @@
 #
 # Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
 
-obj-y	+= bayleybay.o
 obj-$(CONFIG_GENERATE_ACPI_TABLE) += dsdt_generated.o
diff --git a/board/intel/bayleybay/bayleybay.c b/board/intel/bayleybay/bayleybay.c
deleted file mode 100644
index 4f63c23a1b42..000000000000
--- a/board/intel/bayleybay/bayleybay.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015, Bin Meng <bmeng.cn@gmail.com>
- */
-
-#include <common.h>
-#include <asm/gpio.h>
diff --git a/board/intel/n5x-socdk/Makefile b/board/intel/n5x-socdk/Makefile
deleted file mode 100644
index accfdcddcb41..000000000000
--- a/board/intel/n5x-socdk/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
-#
-# SPDX-License-Identifier:	GPL-2.0
-#
-
-obj-y	:= socfpga.o
diff --git a/board/intel/n5x-socdk/socfpga.c b/board/intel/n5x-socdk/socfpga.c
deleted file mode 100644
index 985ba190d034..000000000000
--- a/board/intel/n5x-socdk/socfpga.c
+++ /dev/null
@@ -1,7 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
- *
- */
-
-#include <common.h>
diff --git a/board/is1/Makefile b/board/is1/Makefile
deleted file mode 100644
index e499116b676f..000000000000
--- a/board/is1/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2015 Stefan Roese <sr@denx.de>
-
-obj-y	:= socfpga.o
diff --git a/board/is1/socfpga.c b/board/is1/socfpga.c
deleted file mode 100644
index 2a543bf7bad2..000000000000
--- a/board/is1/socfpga.c
+++ /dev/null
@@ -1,4 +0,0 @@
-/*
- * Currently nothing special is needed on this board, empty file to
- * make build scripts happy
- */
diff --git a/board/mediatek/mt7620/Makefile b/board/mediatek/mt7620/Makefile
deleted file mode 100644
index db129c5abae2..000000000000
--- a/board/mediatek/mt7620/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-y += board.o
diff --git a/board/mediatek/mt7620/board.c b/board/mediatek/mt7620/board.c
deleted file mode 100644
index 119b8fc9e56f..000000000000
--- a/board/mediatek/mt7620/board.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 MediaTek Inc. All Rights Reserved.
- *
- * Author: Weijie Gao <weijie.gao@mediatek.com>
- */
diff --git a/board/mediatek/mt7621/Makefile b/board/mediatek/mt7621/Makefile
deleted file mode 100644
index db129c5abae2..000000000000
--- a/board/mediatek/mt7621/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-y += board.o
diff --git a/board/mediatek/mt7621/board.c b/board/mediatek/mt7621/board.c
deleted file mode 100644
index 0496f3f80672..000000000000
--- a/board/mediatek/mt7621/board.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 MediaTek Inc. All rights reserved.
- *
- * Author: Weijie Gao <weijie.gao@mediatek.com>
- */
diff --git a/board/mediatek/mt7628/Makefile b/board/mediatek/mt7628/Makefile
deleted file mode 100644
index db129c5abae2..000000000000
--- a/board/mediatek/mt7628/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-obj-y += board.o
diff --git a/board/mediatek/mt7628/board.c b/board/mediatek/mt7628/board.c
deleted file mode 100644
index f837a06fbbfc..000000000000
--- a/board/mediatek/mt7628/board.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 MediaTek Inc. All Rights Reserved.
- *
- * Author: Weijie Gao <weijie.gao@mediatek.com>
- */
-
-#include <common.h>
diff --git a/board/mqmaker/miqi_rk3288/Makefile b/board/mqmaker/miqi_rk3288/Makefile
deleted file mode 100644
index ec95affb3974..000000000000
--- a/board/mqmaker/miqi_rk3288/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2016 Rockchip Electronics Co., Ltd
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= miqi-rk3288.o
diff --git a/board/mqmaker/miqi_rk3288/miqi-rk3288.c b/board/mqmaker/miqi_rk3288/miqi-rk3288.c
deleted file mode 100644
index 1649bee063cb..000000000000
--- a/board/mqmaker/miqi_rk3288/miqi-rk3288.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
diff --git a/board/netgear/cg3100d/Makefile b/board/netgear/cg3100d/Makefile
deleted file mode 100644
index 3e05bb55c1b3..000000000000
--- a/board/netgear/cg3100d/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += cg3100d.o
diff --git a/board/netgear/cg3100d/cg3100d.c b/board/netgear/cg3100d/cg3100d.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/netgear/cg3100d/cg3100d.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/pine64/quartz64_rk3566/Makefile b/board/pine64/quartz64_rk3566/Makefile
deleted file mode 100644
index c24a40e724d7..000000000000
--- a/board/pine64/quartz64_rk3566/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y	+= quartz64-rk3566.o
diff --git a/board/pine64/quartz64_rk3566/quartz64-rk3566.c b/board/pine64/quartz64_rk3566/quartz64-rk3566.c
deleted file mode 100644
index 4c027f2a7af9..000000000000
--- a/board/pine64/quartz64_rk3566/quartz64-rk3566.c
+++ /dev/null
@@ -1 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
diff --git a/board/qualcomm/dragonboard845c/Makefile b/board/qualcomm/dragonboard845c/Makefile
deleted file mode 100644
index fe585ad2631c..000000000000
--- a/board/qualcomm/dragonboard845c/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
-#
-# This empty file prevents make error.
-# Board logic defined in arch/arm/mach-snapdragon/init_sdm845.c, no custom logic for dragonboard845c so far.
-#
-
-obj-y += dragonboard845c.o
diff --git a/board/qualcomm/dragonboard845c/dragonboard845c.c b/board/qualcomm/dragonboard845c/dragonboard845c.c
deleted file mode 100644
index c7685de306c0..000000000000
--- a/board/qualcomm/dragonboard845c/dragonboard845c.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * This empty file prevents make linking error.
- * No custom logic for dragonboard845c so far.
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-void noop(void) {}
diff --git a/board/radxa/rock/Makefile b/board/radxa/rock/Makefile
deleted file mode 100644
index fe94b60c3514..000000000000
--- a/board/radxa/rock/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2015 Heiko Stuebner
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= rock.o
diff --git a/board/radxa/rock/rock.c b/board/radxa/rock/rock.c
deleted file mode 100644
index bdc02a6a7929..000000000000
--- a/board/radxa/rock/rock.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2015 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/radxa/rock2/Makefile b/board/radxa/rock2/Makefile
deleted file mode 100644
index caa305bbb570..000000000000
--- a/board/radxa/rock2/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2015 Google, Inc
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= rock2.o
diff --git a/board/radxa/rock2/rock2.c b/board/radxa/rock2/rock2.c
deleted file mode 100644
index bdc02a6a7929..000000000000
--- a/board/radxa/rock2/rock2.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2015 Google, Inc
- */
-
-#include <common.h>
diff --git a/board/rikomagic/mk808/Makefile b/board/rikomagic/mk808/Makefile
deleted file mode 100644
index a4d16884dfc2..000000000000
--- a/board/rikomagic/mk808/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y	+= mk808.o
diff --git a/board/rikomagic/mk808/mk808.c b/board/rikomagic/mk808/mk808.c
deleted file mode 100644
index e0bfc6f3311c..000000000000
--- a/board/rikomagic/mk808/mk808.c
+++ /dev/null
@@ -1,3 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <common.h>
diff --git a/board/rockchip/evb_px30/Makefile b/board/rockchip/evb_px30/Makefile
deleted file mode 100644
index 74b0b9f44fa8..000000000000
--- a/board/rockchip/evb_px30/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2017 Rockchip Electronics Co., Ltd
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evb_px30.o
diff --git a/board/rockchip/evb_px30/evb_px30.c b/board/rockchip/evb_px30/evb_px30.c
deleted file mode 100644
index 29464ae63ec7..000000000000
--- a/board/rockchip/evb_px30/evb_px30.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2019 Rockchip Electronics Co., Ltd
- */
diff --git a/board/rockchip/evb_px5/Makefile b/board/rockchip/evb_px5/Makefile
deleted file mode 100644
index 40f6ff8e7e1a..000000000000
--- a/board/rockchip/evb_px5/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2017 Rockchip Electronics Co., Ltd
-
-obj-y	+= evb-px5.o
diff --git a/board/rockchip/evb_px5/evb-px5.c b/board/rockchip/evb_px5/evb-px5.c
deleted file mode 100644
index b81f9708834d..000000000000
--- a/board/rockchip/evb_px5/evb-px5.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2017 Andy Yan
- */
diff --git a/board/rockchip/evb_rk3128/Makefile b/board/rockchip/evb_rk3128/Makefile
deleted file mode 100644
index 078bb898c68d..000000000000
--- a/board/rockchip/evb_rk3128/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evk-rk3128.o
diff --git a/board/rockchip/evb_rk3128/evk-rk3128.c b/board/rockchip/evb_rk3128/evk-rk3128.c
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/board/rockchip/evb_rk3229/Makefile b/board/rockchip/evb_rk3229/Makefile
deleted file mode 100644
index 65dcd8be35ac..000000000000
--- a/board/rockchip/evb_rk3229/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2015 Google, Inc
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evb_rk3229.o
diff --git a/board/rockchip/evb_rk3229/evb_rk3229.c b/board/rockchip/evb_rk3229/evb_rk3229.c
deleted file mode 100644
index 0b14b241b304..000000000000
--- a/board/rockchip/evb_rk3229/evb_rk3229.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2017 Rockchip Electronics Co., Ltd
- */
-
-#include <common.h>
-#include <dm.h>
-#include <asm/io.h>
-#include <asm/arch-rockchip/uart.h>
diff --git a/board/rockchip/evb_rk3288/Makefile b/board/rockchip/evb_rk3288/Makefile
deleted file mode 100644
index c11b657601a4..000000000000
--- a/board/rockchip/evb_rk3288/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2016 Rockchip Electronics Co., Ltd
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evb-rk3288.o
diff --git a/board/rockchip/evb_rk3288/evb-rk3288.c b/board/rockchip/evb_rk3288/evb-rk3288.c
deleted file mode 100644
index 1649bee063cb..000000000000
--- a/board/rockchip/evb_rk3288/evb-rk3288.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
diff --git a/board/rockchip/evb_rk3328/Makefile b/board/rockchip/evb_rk3328/Makefile
deleted file mode 100644
index 81c5de86d477..000000000000
--- a/board/rockchip/evb_rk3328/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2016 Rockchip Electronics Co., Ltd
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evb-rk3328.o
diff --git a/board/rockchip/evb_rk3328/evb-rk3328.c b/board/rockchip/evb_rk3328/evb-rk3328.c
deleted file mode 100644
index 1649bee063cb..000000000000
--- a/board/rockchip/evb_rk3328/evb-rk3328.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- */
diff --git a/board/rockchip/evb_rk3568/Makefile b/board/rockchip/evb_rk3568/Makefile
deleted file mode 100644
index cbda95fe94d9..000000000000
--- a/board/rockchip/evb_rk3568/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2021 Rockchip Electronics Co., Ltd
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= evb_rk3568.o
diff --git a/board/rockchip/evb_rk3568/evb_rk3568.c b/board/rockchip/evb_rk3568/evb_rk3568.c
deleted file mode 100644
index c2fdf95d9a1c..000000000000
--- a/board/rockchip/evb_rk3568/evb_rk3568.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2021 Rockchip Electronics Co., Ltd
- */
diff --git a/board/rockchip/sheep_rk3368/Makefile b/board/rockchip/sheep_rk3368/Makefile
deleted file mode 100644
index 9661528114f9..000000000000
--- a/board/rockchip/sheep_rk3368/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2017 Rockchip Electronics Co., Ltd
-
-obj-y	+= sheep_rk3368.o
diff --git a/board/rockchip/sheep_rk3368/sheep_rk3368.c b/board/rockchip/sheep_rk3368/sheep_rk3368.c
deleted file mode 100644
index b81f9708834d..000000000000
--- a/board/rockchip/sheep_rk3368/sheep_rk3368.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2017 Andy Yan
- */
diff --git a/board/sagem/f@st1704/Makefile b/board/sagem/f@st1704/Makefile
deleted file mode 100644
index 08d44a0b88ff..000000000000
--- a/board/sagem/f@st1704/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += f@st1704.o
diff --git a/board/sagem/f@st1704/f@st1704.c b/board/sagem/f@st1704/f@st1704.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/sagem/f@st1704/f@st1704.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/samsung/starqltechn/Makefile b/board/samsung/starqltechn/Makefile
deleted file mode 100644
index e017c827a78e..000000000000
--- a/board/samsung/starqltechn/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
-#
-# This empty file prevents make error.
-# Board logic defined in arch/arm/mach-snapdragon/init_sdm845.c, no custom logic for starqltechn so far.
-#
-
-obj-y += starqltechn.o
diff --git a/board/samsung/starqltechn/starqltechn.c b/board/samsung/starqltechn/starqltechn.c
deleted file mode 100644
index f2cdb4eec2c1..000000000000
--- a/board/samsung/starqltechn/starqltechn.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * This empty file prevents make linking error.
- * No custom logic for starqltechn so far.
- *
- * (C) Copyright 2021 Dzmitry Sankouski <dsankouski@gmail.com>
- *
- */
-
-void nooop(void) {}
diff --git a/board/sfr/nb4_ser/Makefile b/board/sfr/nb4_ser/Makefile
deleted file mode 100644
index ab7ad76b2c23..000000000000
--- a/board/sfr/nb4_ser/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += nb4-ser.o
diff --git a/board/sfr/nb4_ser/nb4-ser.c b/board/sfr/nb4_ser/nb4-ser.c
deleted file mode 100644
index 1e4b7281db6d..000000000000
--- a/board/sfr/nb4_ser/nb4-ser.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- */
-
-#include <common.h>
diff --git a/board/terasic/de0-nano-soc/Makefile b/board/terasic/de0-nano-soc/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/terasic/de0-nano-soc/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/terasic/de0-nano-soc/socfpga.c b/board/terasic/de0-nano-soc/socfpga.c
deleted file mode 100644
index 48bfe3295179..000000000000
--- a/board/terasic/de0-nano-soc/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- */
-#include <common.h>
diff --git a/board/terasic/de10-nano/Makefile b/board/terasic/de10-nano/Makefile
deleted file mode 100644
index 2cf9240846ac..000000000000
--- a/board/terasic/de10-nano/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2017, Intel Corporation
-#
-#
-
-obj-y	:= socfpga.o
diff --git a/board/terasic/de10-nano/socfpga.c b/board/terasic/de10-nano/socfpga.c
deleted file mode 100644
index f9173f1921fc..000000000000
--- a/board/terasic/de10-nano/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017, Intel Corporation
- */
-#include <common.h>
diff --git a/board/terasic/de10-standard/Makefile b/board/terasic/de10-standard/Makefile
deleted file mode 100644
index 2cf9240846ac..000000000000
--- a/board/terasic/de10-standard/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2017, Intel Corporation
-#
-#
-
-obj-y	:= socfpga.o
diff --git a/board/terasic/de10-standard/socfpga.c b/board/terasic/de10-standard/socfpga.c
deleted file mode 100644
index f9173f1921fc..000000000000
--- a/board/terasic/de10-standard/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2017, Intel Corporation
- */
-#include <common.h>
diff --git a/board/terasic/sockit/Makefile b/board/terasic/sockit/Makefile
deleted file mode 100644
index e1c8a6b3c7c9..000000000000
--- a/board/terasic/sockit/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2001-2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-# (C) Copyright 2010, Thomas Chou <thomas@wytron.com.tw>
-
-obj-y	:= socfpga.o
diff --git a/board/terasic/sockit/socfpga.c b/board/terasic/sockit/socfpga.c
deleted file mode 100644
index 48bfe3295179..000000000000
--- a/board/terasic/sockit/socfpga.c
+++ /dev/null
@@ -1,5 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Copyright (C) 2012 Altera Corporation <www.altera.com>
- */
-#include <common.h>
diff --git a/board/theobroma-systems/lion_rk3368/Makefile b/board/theobroma-systems/lion_rk3368/Makefile
deleted file mode 100644
index fc8df271457f..000000000000
--- a/board/theobroma-systems/lion_rk3368/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
-
-obj-y += lion_rk3368.o
diff --git a/board/theobroma-systems/lion_rk3368/lion_rk3368.c b/board/theobroma-systems/lion_rk3368/lion_rk3368.c
deleted file mode 100644
index 1b0d504631ec..000000000000
--- a/board/theobroma-systems/lion_rk3368/lion_rk3368.c
+++ /dev/null
@@ -1,4 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
- */
diff --git a/board/vocore/vocore2/Makefile b/board/vocore/vocore2/Makefile
deleted file mode 100644
index 70cd7a8e5681..000000000000
--- a/board/vocore/vocore2/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-obj-y += board.o
diff --git a/board/vocore/vocore2/board.c b/board/vocore/vocore2/board.c
deleted file mode 100644
index 27e42d141413..000000000000
--- a/board/vocore/vocore2/board.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2019 Mauro Condarelli <mc5686@mclink.it>
- *
- * Nothing actually needed here
- */
-- 
2.34.1

