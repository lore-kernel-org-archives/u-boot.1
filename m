Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999AEC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 15:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2088826B;
	Sun, 19 May 2024 17:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNpEbjsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F3C881A0; Sun, 19 May 2024 17:07:58 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECDD882A3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 17:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f44e3fd382so1126482b3a.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716131275; x=1716736075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gdatg5bqp8hU6w3RArzHyKhiwOmuj/D9Hd802EpAc/8=;
 b=MNpEbjsZdjiKpkO0yp1nb81ms6PBkoOAakkuPl+1F/3aGlc/JwdHQBf9f0vDYmreTJ
 rsNhvlMHot07SCQm58vEh+80iJHI6Pg2Piorp2uBh9OHceWzR8hTS/FYPcyosS4YdG/7
 deSsqmn5X6tjrgdbv5p/1cTpFVlyG2O6TFj/54PebyOkRIt/uZDdRWIU/TIlc5JZBeNW
 ij0tC/tZzzzc9LPUO5Sfg9hpFnjGuO/CswdwuK+bsaVGI1lZCZ8vZlL5uI/mru6BT8Fc
 jx0Yt8SzKyIfLF2vc88adJLSXump0ICW12fAaVqabsXm3D+qUZafs0F3khl1tNh9IvsI
 6OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716131275; x=1716736075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gdatg5bqp8hU6w3RArzHyKhiwOmuj/D9Hd802EpAc/8=;
 b=QRJbX7hOU+fejnHX9u7Fpg3z+sCbKCmZg1zmESk0BVAstqQk2WYa5fYimeUkIos9dG
 vjDxZud7+l7TgmJgCj66f7wA4bDqRmDrQok/a/NEuqH4vh3QN9khI2OX1DR+nukbsnar
 AKRsHeoPVhpQa0/iOvAZPdlMzJi22n6lex9EhraF3UM7huWZIQnnqMbOJVh5FBUoL81G
 xoQmtgfr83ZBrYa3/Copcl2fiiPrJwyTahoy0cW6Ca8zBRFlOz3qzUx9ObFbP4BVIz9g
 AGLuC4/xmPXQOp4vQGyOWhhjKyfORQ4Gt4hqGEgr0WMnJZVrmyd37f8cS8FyOTMyj/ra
 A4qA==
X-Gm-Message-State: AOJu0YyfHBhaHgg+HsK4QJkhgxn6c990zAvASNmzSR8XP6oEA2wkiR8r
 bGa5/I8inFst6Js0CIoq86esVErfLdxEBZ10C12uio/C3VFh9ec+K00tTwkdR+I=
X-Google-Smtp-Source: AGHT+IGE8NUi6NCJWUTtkFkp8Vv1pC5da0KfIfTIf6xeC+rD/dCfkG8O3OZBZOEit6lgs/82RvVjDA==
X-Received: by 2002:a05:6a00:391a:b0:6f3:ea4b:d1c1 with SMTP id
 d2e1a72fcca58-6f4e0298a60mr27507637b3a.1.1716131274564; 
 Sun, 19 May 2024 08:07:54 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2b3493asm17692711b3a.191.2024.05.19.08.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 08:07:54 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>, Leo <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 0/4] clk: sophgo: milkv_duo: Add and enable clock controller
 driver
Date: Sun, 19 May 2024 23:07:06 +0800
Message-ID: <20240519150736.13203-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
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

This series of patches introduces the clock controller driver for the Sophgo
CV1800B SoC, updates the device tree sources to use the new clock controller,
and enables the clock controller in the configuration for the Milk-V Duo board.


Kongyang Liu (4):
  dt-bindings: clk: import header for clock controller of sophgo CV1800B
  clk: sophgo: cv1800b: Add clock controller driver for cv1800b SoC
  configs: milkv_duo: Enable clock controller
  riscv: dts: sophgo: Replace device clocks with real clocks.

 arch/riscv/dts/cv18xx.dtsi                |  40 +-
 configs/milkv_duo_defconfig               |   9 +-
 drivers/clk/Kconfig                       |   1 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/sophgo/Kconfig                |  14 +
 drivers/clk/sophgo/Makefile               |   6 +
 drivers/clk/sophgo/clk-common.h           |  74 ++
 drivers/clk/sophgo/clk-cv1800b.c          | 794 ++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800b.h          | 123 ++++
 drivers/clk/sophgo/clk-ip.c               | 594 ++++++++++++++++
 drivers/clk/sophgo/clk-ip.h               | 288 ++++++++
 drivers/clk/sophgo/clk-pll.c              | 284 ++++++++
 drivers/clk/sophgo/clk-pll.h              |  74 ++
 include/dt-bindings/clock/sophgo,cv1800.h | 176 +++++
 14 files changed, 2450 insertions(+), 28 deletions(-)
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-common.h
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.c
 create mode 100644 drivers/clk/sophgo/clk-cv1800b.h
 create mode 100644 drivers/clk/sophgo/clk-ip.c
 create mode 100644 drivers/clk/sophgo/clk-ip.h
 create mode 100644 drivers/clk/sophgo/clk-pll.c
 create mode 100644 drivers/clk/sophgo/clk-pll.h
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

-- 
2.41.0

