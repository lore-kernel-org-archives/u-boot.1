Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F57E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 06:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83C4800B2;
	Sat, 14 Dec 2024 07:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SebnaJF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37978800B3; Sat, 14 Dec 2024 07:45:18 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B687800B1
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 07:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so1799065b3a.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 22:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734158713; x=1734763513; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sRN7tWPeFdSaahomZu8UYv5TDdSqvfXVBB0WeG8N8Us=;
 b=SebnaJF+ACL7kSqRLDioUilII35faeUcqlqSQm1tod78P1m5QekKz0Pdn9p21hKVEV
 ZGXqUpPLZTT8HdT43Yc8ThxwSUyeEybK357BCSIAXazQpar6qcd50svaRSUrhVmn/RF+
 HeOqgHLARn15chBP0nVd8C48w9fbJEzD3simruLC9P/xCFnzWsMNPN7Bj0fra3bVl/cD
 IdPnQCyY4X9eYB4tqxO8asreRgrK8j4QFiM1ysKPxCHNdkfyrAgn/H3V40a7zRhzs0/D
 nGOkQGt7t5MWT/MOT+CW7EPjGZTRgXe3CqhmAjjMDXQmMlZWg1oZ2n/BP2+KdJZ7b3Pm
 4CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734158713; x=1734763513;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sRN7tWPeFdSaahomZu8UYv5TDdSqvfXVBB0WeG8N8Us=;
 b=GvMNoihX2h/3pTuc/QkZAzBi9pcRex55c5tRb8d/qiTPCGOQapMUtWsVDcDbThZOoh
 6deu2gyOCuw3W/p7e/8oQPags9TuP9NoaBVk0OjDy4TbROCrl7lnvdUd5m1e4ZaaHFvG
 ylE5zyvDoppmJvQm4qE1fGCsyBnCRzxMzkQFEPaoAzMrg8iW5Rong7d8ivu0h8v9Xd+x
 2/NNuj6317l2DUByfsxPkyDSeyVMJtFnoDphzNBovtSlKiRzg8hp6XcH0wkYqNBfeiZ5
 o4aG2PjIGAu+u0+kXCA7w5wgMv/WyIqenS2DpqWIPUcpXvk5ak5drgEufBORih1qS0z/
 38fA==
X-Gm-Message-State: AOJu0Yy8eBvFWGiPxBfWHeIeFkcP9EWyXjFg6SY+OQHIqfA/+kezpbYo
 YCtILFhgVkeGlGXbUAvcg1TcZgItDXyMXRz6K+y5UIo+NkXbIxNS
X-Gm-Gg: ASbGncv0MsW2J9n1FKVKImCnKP3VeVqgbIciCnrUASdIykgBeH9/2vuLGNcaFyfFgD5
 nhvFwyLshGnmrhyXvXwH8wMHO6R2dJQN751uONccAWplC+dqUq/gtBxI7o/gJIUE2vXAIDeyrHo
 LkeeiCW42Y3sER3MSeU/hwuEKUFTH+1yq4SJBi3d5PhIr4TxL6MwTCZ0H0h+BGf+5UXwo8fG+6U
 FovA9y1xDBamiHuhBA0T0yT8YMt+cI+rDB+RyXNuBAdfG6RyviE6F5CrzAvyt6woP06xmL+jWB6
 VVc2biNC8iYxSQI5akaB2EhZaw==
X-Google-Smtp-Source: AGHT+IHlm08zDGJW+yYaChviDAreLNW9yhAIpb3o+8M4CVpYhu5VyU14cjSXzzEcODZc9Hn5Bv+vzQ==
X-Received: by 2002:a05:6a21:3985:b0:1e1:a68b:104a with SMTP id
 adf61e73a8af0-1e1dfea30fdmr7724934637.42.1734158712929; 
 Fri, 13 Dec 2024 22:45:12 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bcde27sm831431b3a.181.2024.12.13.22.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 22:45:12 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v6 0/2] riscv: spacemit: add support for bananapi-f3
Date: Sat, 14 Dec 2024 14:44:59 +0800
Message-Id: <20241214-pickup-bpif3-v6-0-306355826455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGspXWcC/13OTU7DMBAF4KtEXmM0Hv/E7op7IBYzjtNa0CYka
 QSqcnfcFImQ5Rvpe/NuYkxDTqM4VDcxpDmPubuU4J4qEU90OSaZm5IFAhqlFMo+x/drL7nPrZZ
 oLDGC50BGFNIPqc1fa93r2yMP6fNaWqfHUTCNScbufM7ToWJg10D0NXj0ShM1ZCJYJM8mIUS0d
 cPckLh3nfI4dcP3unRWa9nvKP1/1KwkSNRkvY/RauVejmfKH8/l61o06y02O6wLDp6M9YDEddh
 js8EYdtgUnEJoiVvnktZ7bP8wwh7b+2dsPSiuo4tqi5dl+QGoi5xoqwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734158705; l=3198;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=wpT2BUzMmQbogtZ9EryhJdj51ENExxb7UBnLmssL78s=;
 b=LwoyVwkW08ST7otJYIuOQTzJEVd5dZfxeHd2Ef6cH3hEIPJwItpSXgRNpx3QuHIha89b2PpUO
 lsnq+l4HbHkBQ3Bn5mJvA8jJ+seiPI0YAUa7Zh+dVmTO0FvR3ny9ELv
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
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
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

