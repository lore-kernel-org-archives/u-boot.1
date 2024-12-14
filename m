Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D80E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 07:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060B1800B3;
	Sat, 14 Dec 2024 08:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilH+zxZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B115800B6; Sat, 14 Dec 2024 08:30:35 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D122F800B2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 08:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21145812538so24403385ad.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 23:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734161431; x=1734766231; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHzyXEXvxvtabU1WPjM7RLb5iiUCtyZOVP559EY1loE=;
 b=ilH+zxZKBYfJGLYUbTH/6bvr7az0JTm5nnlKhIHEysS1vIM7ePBlTq12vii44MUDWv
 GQ6IoM7Ms8Fl+emYj9ZccAY7zptleDopdMBhwcVk2rXGXMjcvlkrtd+P/Z68RaUQECug
 3CE+Ymqsxe3tm00IbYa5xintQeXPwWyOXYHT52zj8synmz+8UfzPC9prAEkYS7JVKdbh
 PEtNJkfogXn7ugwMBwIWHOGC++kNUcWSNt+PYfQuYRKaq/jht6X/YYD+fG2ZafY7S6zI
 h4PGd7oidz5A8inXqvXBlr9xMZFx8nbEG0i1ZDgpIUU0cW5E+DDpPaWWopARVa2g2Iv6
 5Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734161431; x=1734766231;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHzyXEXvxvtabU1WPjM7RLb5iiUCtyZOVP559EY1loE=;
 b=djh56zFlQzQS4G9+zymrOAvfEab79XGlF/vtFdNblyYoMed4BHwpeaK7qqmbGQUetX
 wUdN+p7UhsZIXvLe042DipbkKtY8PpilyPQ50Uwu/BB3xgEjL4D9jsJJPY3wOY6BICaP
 +5UmOJx8dXe74TcrlLd3WPIQ1Yf0BQ9OyqSYXa3rvmhb1uJQ2Hxic/6q+SSo48ZbJ75/
 OETWRjpPbdEXCavAFr04n+2pL+vtVFKGnakg5ubPMxMnjqRpG1uk5X70FFadPwUvMSGz
 p0pwXwDeRcYhHu4joTHYzHn/zKEWe3U7N731B6/b5oMnf6NxqSZVoVWjE8tw9u6hc5Zx
 gj9w==
X-Gm-Message-State: AOJu0YyLusICVheeoM1At+ntj7qfzkmbO5bOtEJFmkJrrPggDl+JZn9M
 lmdeYaqb4/kucfsiNajPZGyPlL1h2lHbJOAlwXm4kU6n557fTYr6
X-Gm-Gg: ASbGncsbVYn11gMsdJroXdYJW3duNcKYHdsv4TkfMmcnxU3DqxZVm9hwmKsASXYwJv8
 BYQmP4nworhd5Hg+GbPX+RGJDLJPuneY65a3FwsaOPzD9dvhWKVsqH6sPH0dnv3e6Wv2haX6Xnr
 55mytR0Mwy9QyBQGab2u44jJT8qldYQQPr0km9lgD1rZ1M2TIqWMM2zwN5rlv5q6fB984Yur1K9
 h8b9R47ucjDpI55Zslgr1l0hFHjCT+8D7hgmX5XFe+r4ASXR2tPZg9jpIvTzf3m5FI/B+PgDZ5F
 lujOF+AqBl76WXU0DLkcUULaiQ==
X-Google-Smtp-Source: AGHT+IHZPqA8v8ogp4C+l/5BaGRKkVM5Y3ewVp65VNWFeCOg2gNFHxPb8uMUwMEP240PoTV5MACe8A==
X-Received: by 2002:a17:902:f709:b0:215:b45a:6a5e with SMTP id
 d9443c01a7336-218929bdfa6mr77288915ad.18.1734161431134; 
 Fri, 13 Dec 2024 23:30:31 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc748sm7894815ad.92.2024.12.13.23.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 23:30:30 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v7 0/2] riscv: spacemit: add support for bananapi-f3
Date: Sat, 14 Dec 2024 15:30:20 +0800
Message-Id: <20241214-pickup-bpif3-v7-0-d0cd91146f7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAw0XWcC/2XOTW6DMBAF4Ksgr+vKHv9gZ9V7VF3MGJNYLYEAQ
 a0i7l6HVCp1l2+k7827sSmOKU7sUN3YGJc0pf6cQ/1UsXDC8zHy1OTMQICWUgIfUni/DpyG1Co
 O2iCBcORRs0yGMbbpc6t7fXvkMV6uuXV+HBnhFHnouy7Nh4oE2UYEVwsHTirEBnUQBtCRjiACm
 LohapDdu05pmvvxa1u6yK3sZ5T6O2qRXHBQaJwLwShpX44dpo/n/HUrWtQe6wKrjL1DbZwApNq
 XWO8w+ALrjKP3LVJrbVSqxOYXgyixuX+G1glJdbBBltju8L/ZNmMlrDLGgdXG7PG6rt95lOsD6
 AEAAA==
X-Change-ID: 20241112-pickup-bpif3-245ab208b9a4
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734161424; l=3298;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=0kHBKXqypJX4zgvUM6e5DjfQ2vmVg+eLUCGjLG16bwM=;
 b=OamiPUNkAYW9RuMfVlKLhRNqE0hti6zIz7/xo7SmEha7dq4pnqmq6DV/Y7eOUQU7+Dnon66eS
 FCX1BNkitX3DjM8dcD5+17jhdtBMWWiJsggjmPjGJX2VJPu6Qzy5GiZ
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
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

Banana Pi F3 board is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.

This patch introduces fundamental support for the Banana Pi F3 board,
encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
operate in serial console mode.

Changes in v7:
- Remove the wrong tag in patch header.
- Link to v6: https://lore.kernel.org/r/20241214-pickup-bpif3-v6-0-306355826455@gmail.com

Changes in v6:
- Rebase the patch to the latest branch.
- Add small comment in bananapi-f3.h
- Add tag in previous patch(e.g reviewed by or tested by)
- Add fastboot burn procedure in doc.
- Link to v5: https://lore.kernel.org/r/20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com

Changes in v5:
- Formal the name from Bananapif3 -> Banana Pi BPI-F3
- Trailing whitespace
- New blank line at EOF in spacemit/index.rst
- Link to v4: https://lore.kernel.org/r/20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com

Changes in v4:
- Change uart compatible in k1.dtsi in v3, cause related driver in not implemented in u-boot.
- Update doc, show how to validate the patch.
- Update maintainer, remove kongyang cause he lefted.
- Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com

Changes in v3:
- Add base commit
- Clear redifinition warning while building in UART_IIR_ID
- Change underscore to dash in bananapi*f3
- Update maintainer
- link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/

Changes in v2:
- Change license to GPL-2.0-or-later
- Add memory node for dts
- Add ft_board_setup function for kernel memory init
- Use default prompt
- links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashell11234455@gmail.com/

Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---
Kongyang Liu (2):
      riscv: spacemit: bananapi_f3: initial support added
      doc: spacemit: bananapi_f3: document Banana Pi F3 board

 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  54 ++++
 arch/riscv/dts/Makefile                |   2 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
 board/spacemit/bananapi-f3/Kconfig     |  25 ++
 board/spacemit/bananapi-f3/MAINTAINERS |   6 +
 board/spacemit/bananapi-f3/Makefile    |   5 +
 board/spacemit/bananapi-f3/board.c     |   9 +
 configs/bananapi-f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi-f3.rst     | 106 ++++++++
 doc/board/spacemit/index.rst           |   9 +
 include/configs/bananapi-f3.h          |  13 +
 17 files changed, 772 insertions(+)
---
base-commit: b0b6d0c87082813aada4c052a8b4e20c257dbbda
change-id: 20241112-pickup-bpif3-245ab208b9a4

Best regards,
-- 
Huan Zhou <pericycle.cc@gmail.com>

