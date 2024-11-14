Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE76D65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DD288CED;
	Thu, 14 Nov 2024 11:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AT6yJTSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09851895C0; Thu, 14 Nov 2024 08:21:49 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8597F88E0A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7f3e30a43f1so173354a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731568905; x=1732173705; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ny+G5h9+85a9yZA08iiZjONp6ufawd+BnWwSQ6UtzY=;
 b=AT6yJTSh3JRi2MBYeKz/qAIHIwkX5Kea4MvQun6W6TBX0gtWIbHPOo3rTXKk6zdtBj
 JbYTaHph2I6/no/3paq6btnepZ3L3Ofljs4QtbfLBgfbvbXsz4cb/IL7FFb3zAQd9c2D
 E7kY7cYJg9t8WYI5T6GLbd0kyFBMSweX1rqbdizGvnYS3h7/y7LwiVIAVd4bmr8eg0+X
 nIgOfGoRJlwZUSYeeXMKkl3ePtcGREMhrZAvLOGhqLgwtRrpeSeuo7WvMpuntV160a1T
 Bv1Avqjp/igVmpaoOScA02k/UExZaBH7q1z4nUENPJBQU3ifldStmwTxNHMxuHJMKPuF
 Hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731568905; x=1732173705;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ny+G5h9+85a9yZA08iiZjONp6ufawd+BnWwSQ6UtzY=;
 b=unjsOU60t/h1wYX5gnGcRE2h1Cr/Zo9zQgEv2Iu6+ZHZdSL5SEnPpOlBFCqbTALTQQ
 0h7mhGA0hIA54iS7gtUr7MoLQc/XsZsf6YBYsQx+0pqkapk9M20I4sLaNRP/Pdfhwa3m
 Y1YIdkc1mqQD5BoIOFnQXx3VqrCj+BuWOAnKIk3K9IsMxb+Y5KXamU4WTDz6Bz3gso7J
 dsOLmImV4nhif3KLdoLbVPstIiTP4Ri01Ps+eRFKDKDp4CtFJs/zhgFJ9osoVf5opncj
 Rhw8sS6Mc9wlu3By12A6XXFJfwpN63LkpidTZARbcuXVyl40OzNEQT/G43rR+SuyMaj6
 7nOQ==
X-Gm-Message-State: AOJu0YwlupLOG94x+yWew7gGJ7Xw+nzoEt0NA5fhJSoIyxEwuET9vYd+
 McdDDEGdg2IGGdWqbomYeqfv9X//6/u+zAIpsmbfUKL0pgSO/t/C
X-Google-Smtp-Source: AGHT+IE3yq1NdkZmgd3NdqaTbdm9oubft6GyADbfanK86HcJOmOA2nvIEJSqcuxyzf2HksP4bwSeuw==
X-Received: by 2002:a05:6a20:4304:b0:1db:eb56:be7c with SMTP id
 adf61e73a8af0-1dc834ede2dmr1750551637.35.1731568904908; 
 Wed, 13 Nov 2024 23:21:44 -0800 (PST)
Received: from per1cycle.per1cycle (n058153182158.netvigator.com.
 [58.153.182.158]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f4ce8bsm533733a91.28.2024.11.13.23.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 23:21:44 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v3 0/2] riscv: spacemit: add support for bananapi-f3
Date: Thu, 14 Nov 2024 01:21:31 -0600
Message-Id: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPukNWcC/1WOSw7CMAwFr1J5TVC+pWXFPRCLfBywoLQkpQKh3
 p1Q2LAcS543L8iYCDNsqxcknChTfy2gVhX4k70ekVEoDJJLLYSQbCB/vg/MDRQVk9pYJ3njWqu
 hvAwJIz0W3f7w5YS3e7GO3yM4m5H5vuto3Faa+yIwm3ajXXC8jTFaJULA2oQQ6xZNQKPQwcd1o
 jz26bmUTmKR/aLUf9QkGGdSWdM03hsl6t2xs3RZl1U4zPP8BqSBgmj0AAAA
X-Change-ID: 20241112-pickup-bpif3-245ab208b9a4
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Padmarao Begari <padmarao.begari@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731568899; l=2206;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=+Vl8GqCw0SWlCPOVnXesZYr5jzc/EF1tdo2wnNlhME8=;
 b=gCLRLmyHVWmQ87zDgmHNN7aM6BETkHtUjXuoeoPX+2xa9r7GIpqkRKWKcfmnZ9Ie5SWr2pjHr
 Ke6KuGmvbdzBXcDk5plTBZWot0Q4+5FQeYGN3Nzz458hUGKKLkbKmWQ
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
X-Mailman-Approved-At: Thu, 14 Nov 2024 11:38:48 +0100
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

Changes in v3:
- Add memory node for dts
- Add base commit
- Add ft_board_setup function for kernel memory init
- Change license to GPL-2.0-or-later
- Clear redifinition warning while building in UART_IIR_ID
- Change underscore to dash in bananapi*f3
- Update maintainer
- Use default prompt
- link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/

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
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
 board/spacemit/bananapi-f3/Kconfig     |  25 ++
 board/spacemit/bananapi-f3/MAINTAINERS |   7 +
 board/spacemit/bananapi-f3/Makefile    |   5 +
 board/spacemit/bananapi-f3/board.c     |   9 +
 configs/bananapi-f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi-f3.rst     |  78 ++++++
 doc/board/spacemit/index.rst           |   8 +
 include/configs/bananapi-f3.h          |  13 +
 17 files changed, 743 insertions(+)
---
base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
change-id: 20241112-pickup-bpif3-245ab208b9a4

Best regards,
-- 
Huan Zhou <pericycle.cc@gmail.com>

