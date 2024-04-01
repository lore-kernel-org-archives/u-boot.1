Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C8BCD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 18:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87BF88321;
	Mon,  1 Apr 2024 20:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9aiXUuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B444480EED; Mon,  1 Apr 2024 20:14:57 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B336488327
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 20:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-22a73f2d6adso1899074fac.3
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711995283; x=1712600083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0FtrJPCWjpbJApxcOTRFrAGNnLUQ5cYmHRFs9ApQbR0=;
 b=c9aiXUuJGRcJ6cO91Tc4RPLmjWsyggvb3wHQpkI3HqupP0MZQ1NsyWbwrG3U6PmWGK
 1WVXdrIzC7LbQo0pqQbMiRPOQdvs7SgJ6uzZSvEJhk25i5t9Gj5teB+2v2D6Ncdpll1/
 e8eUiuqTx2p4fHD/PbG8HpgRJ2APvjtxeDl90Lp6lETOBIJWH2q1AczseL2r53uPVwxP
 /9fh93CkIBqBXzpcrljglda9v31HCARrcUTOswWOREcj4dcoitQj7ybGL66PI1bjNDQ1
 +RKAHZ0Q4COKvNEaCaa3MnazhUTOvEoVDHXTZtR1KsjeSm2aPPmOE824v7Cnd6hnaU6C
 4ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711995283; x=1712600083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0FtrJPCWjpbJApxcOTRFrAGNnLUQ5cYmHRFs9ApQbR0=;
 b=uDUB/gIMOF/MA9p+HupNxs2pqg8BDqRg6KyR4fBM+kLzmLf4Esu8/H4P2H5NYQNGxt
 l0C/hWBq5ukCN/RCoUzHoQ3fCSPUwQJSjJqnLQQ4cmtRhZloSS8MYSizXWqH+8IcrtYC
 qQA4aBKidovIFwzFgZ9UrAQ9k0jrNVtGXV84MSxBi6Z1+WZ0O/eatLwccBqmH88sg8Qp
 NPrmvpTgkLp1YBzVg+el6Qbgc1gH3gu9eB7DR5R1OWyfCYHc4kJRHbBDnxeiSHncEYW1
 y+jIM35hM9bu+Saz2Y+3T3agGVcX6y4yEwhTdCEZwmn5I0NmUYIZ4DDgWJO2YJXmlUsX
 gBZQ==
X-Gm-Message-State: AOJu0Yx4iQHCVhP40keVLaLEiuYPY4TkVgNJUCaeqxgKorlEjJX2Km7T
 MfTlrC7Jkw52TA3J6YEqWKjddRvM2mTJGx9D/Xz9GG7kfroQzbytn/bJ5osh
X-Google-Smtp-Source: AGHT+IERKzOJe6Th1j4/HNcKr7udFZsbc/HzD2qIOgQiGChUV5V79oNjmsCsoJz3FQme9Q7WmWfKfw==
X-Received: by 2002:a05:6870:a910:b0:22a:1036:4d86 with SMTP id
 eq16-20020a056870a91000b0022a10364d86mr10347777oab.20.1711995283110; 
 Mon, 01 Apr 2024 11:14:43 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 hx17-20020a056871531100b0022a0a60a9bcsm3008824oac.57.2024.04.01.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:14:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [V2 PATCH 0/2] Update RAM Bank Logic for RK3568/RK3588
Date: Mon,  1 Apr 2024 13:14:33 -0500
Message-Id: <20240401181435.553351-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Use the ATAG info provided by the Rockchip binary TPL to identify
RAM banks on the RK3568 and RK3588 when using the ROCKCHIP_TPL binary.

This is needed because there are specific addresses that should not
be written to for all RK3588 based devices with >=16GB of RAM, writing
to these addresses immediately results in a crash. Additionally on the
RK3568 and RK3588 this allows us to reclaim 256MB of RAM when RAM >=
4GB.

Changes since V1:
 - After additional feedback, removed RFC tag.
 - Made code work for both RK3568 and RK3588.
 - Removed memory hole code for all RK3588 boards.
 - Updated CONFIG_NR_DRAM_BANKS for 3568 and 3588 boards as it is
   the max number of banks supported by the ATAGS code.

Chris Morgan (2):
  rockchip: sdram: Support getting banks from TPL for rk3568 and rk3588
  rockchip: Switch RK3568 and RK3588 to new RAM bank logic

 arch/arm/mach-rockchip/sdram.c                | 100 ++++++++++++++++++
 board/friendlyelec/nanopc-t6-rk3588/Makefile  |   6 --
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       |  39 -------
 board/pine64/quartzpro64-rk3588/Makefile      |   3 -
 .../quartzpro64-rk3588/quartzpro64-rk3588.c   |  39 -------
 board/radxa/rock5a-rk3588s/Makefile           |   6 --
 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c   |  39 -------
 board/radxa/rock5b-rk3588/Makefile            |   6 --
 board/radxa/rock5b-rk3588/rock5b-rk3588.c     |  39 -------
 board/rockchip/evb_rk3588/Makefile            |   6 --
 board/rockchip/evb_rk3588/evb-rk3588.c        |  39 -------
 board/turing/turing-rk1-rk3588/Makefile       |   6 --
 .../turing-rk1-rk3588/turing-rk1-rk3588.c     |  39 -------
 configs/anbernic-rgxx3-rk3566_defconfig       |   2 +-
 configs/bpi-r2-pro-rk3568_defconfig           |   2 +-
 configs/evb-rk3568_defconfig                  |   2 +-
 configs/evb-rk3588_defconfig                  |   3 +-
 configs/generic-rk3568_defconfig              |   2 +-
 configs/lubancat-2-rk3568_defconfig           |   2 +-
 configs/nanopc-t6-rk3588_defconfig            |   3 +-
 configs/nanopi-r5c-rk3568_defconfig           |   2 +-
 configs/nanopi-r5s-rk3568_defconfig           |   2 +-
 configs/neu6a-io-rk3588_defconfig             |   2 +-
 configs/neu6b-io-rk3588_defconfig             |   2 +-
 configs/odroid-m1-rk3568_defconfig            |   2 +-
 configs/orangepi-5-plus-rk3588_defconfig      |   3 +-
 configs/orangepi-5-rk3588s_defconfig          |   3 +-
 configs/quartz64-a-rk3566_defconfig           |   2 +-
 configs/quartz64-b-rk3566_defconfig           |   2 +-
 configs/quartzpro64-rk3588_defconfig          |   3 +-
 configs/radxa-cm3-io-rk3566_defconfig         |   2 +-
 configs/radxa-e25-rk3568_defconfig            |   2 +-
 configs/rock-3a-rk3568_defconfig              |   2 +-
 configs/rock5a-rk3588s_defconfig              |   3 +-
 configs/rock5b-rk3588_defconfig               |   3 +-
 configs/soquartz-blade-rk3566_defconfig       |   2 +-
 configs/soquartz-cm4-rk3566_defconfig         |   2 +-
 configs/soquartz-model-a-rk3566_defconfig     |   2 +-
 configs/turing-rk1-rk3588_defconfig           |   3 +-
 39 files changed, 126 insertions(+), 301 deletions(-)
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 delete mode 100644 board/pine64/quartzpro64-rk3588/Makefile
 delete mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
 delete mode 100644 board/radxa/rock5a-rk3588s/Makefile
 delete mode 100644 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
 delete mode 100644 board/radxa/rock5b-rk3588/Makefile
 delete mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
 delete mode 100644 board/rockchip/evb_rk3588/Makefile
 delete mode 100644 board/rockchip/evb_rk3588/evb-rk3588.c
 delete mode 100644 board/turing/turing-rk1-rk3588/Makefile
 delete mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c

-- 
2.34.1

