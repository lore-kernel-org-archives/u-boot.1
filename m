Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35042E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 02:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFBC6895A7;
	Mon,  9 Dec 2024 03:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uav3NMN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECED895A7; Mon,  9 Dec 2024 03:00:33 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06EDA8954F
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 03:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-725f2f79ed9so89626b3a.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733709629; x=1734314429; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vfQboXlpCt2QrqKPfArkU/rn2vECeqaBR0bl/qiXVvA=;
 b=Uav3NMN9XG5+NDM8OJocYfRBA5eHjgnF3MSJkC5ykljSDxhVKP6NvME7v0tc4IhghL
 EYe1RqUrQpnriSsTpCrojK9xIl/c4DF00zYo/EtbH/4xXhrLsNKuW2hKqy3DOOWR/cGO
 JJB3CWeVJk1L9jhxsE7wRT+C2htf9pm+9vCk7Hnx6LtkaBdbiTriTp2ac0V044LLyn9e
 ARcyu8D+U/OEstFLljTRwh9H9CgumroRkQ6CDyHyc1/zSeXtUGG8se6NgLqhNMJ/OTxY
 ZK+0IhyBPWVn/7fI0pH7MzeUylZCAAvbSEoMGY8EVJPuZyFLopPL24PVrsEmHFIhj5JS
 up/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733709629; x=1734314429;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfQboXlpCt2QrqKPfArkU/rn2vECeqaBR0bl/qiXVvA=;
 b=wEwJB5zrVB+ajnF83kM+42INy5sXEPUcA+keRuALOH8qngPWRP8LJjclr1ZqrFydOY
 yW71ucmgfFsnpw6Q4t6XGotnx40ulQpLSOmIYF+Ykx3PiMbbiclvkfFn9xq0hbd1wk5m
 ReYJ189i7HSkhDaPQZFXEgmYfzBo9TyHQhK+iGyn5Uysa7fnti5WueJHqUhnviHwCxpi
 1etEueTHPSyB6wVnr2inxCds9jCEQJ5Y0JpXk0d/mbK4A1n9CM7KktZv6J+uqqaoZ9S1
 r75k7+PA3ZBKlBHIqRvcwjlAnqbjTrN65UYCNxk0M7k1yEIWe/UmRrqQCvPBkhbcFnpb
 vchw==
X-Gm-Message-State: AOJu0YySyu21je8DgDJSsOfE9QRglRqKpCxGJhLZoRQ+AugxaFfikZMI
 4C9tgnYeJnNUMm0QtBSEAbwuQMdPtNp0EXU7MhRXDDknWTceHHNN
X-Gm-Gg: ASbGncuhtNjMbAWA0rGHopdulapYMEdEVspyxNncvntpJVz4yPMTO+vNgGs4hVW9ZTG
 jLXXPrnrKAEaN8i1h3BL8g9gNV/FMRO9nI/07ck8nqG25NtAh1N+FuYXOOHgEfgEZhpDT8JvPSZ
 ocS2waQF53MQBu6uT7piruP+qXB8vRJXg8ohhRIJd5nuOLhrB+q+Y7A0Ma9vIeVlNNZOEc/d2hI
 rQwj/qigDmE6vLeUvnhzfK/cXGBQPKlUsfl7Kd9TphBt9Y1KcPqIgpM2mgZvgJAhZlwkfDdH6FR
 8Bvm9RdnmqU+NdR3XZRtJ+9jRip3
X-Google-Smtp-Source: AGHT+IH8/wMyfymPS63Dakd5lcLpsqxbNWzo1JrAXhBzFk0wLFYTXMdPIMtUmIL1Hu5IgzFDmTdk5w==
X-Received: by 2002:a05:6a00:a90:b0:725:f128:6538 with SMTP id
 d2e1a72fcca58-725f1286620mr1567950b3a.6.1733709629229; 
 Sun, 08 Dec 2024 18:00:29 -0800 (PST)
Received: from per1cycle.per1cycle (36-226-243-111.dynamic-ip.hinet.net.
 [36.226.243.111]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725ec7394b0sm921252b3a.43.2024.12.08.18.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 18:00:28 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v5 0/2] riscv: spacemit: add support for bananapi-f3
Date: Mon, 09 Dec 2024 10:00:18 +0800
Message-Id: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJPVmcC/13OzU7EIBSG4VtpWIsBDlCYlfdhXPBzmCHaaYVOo
 5n03sWOi9rlR/K8nDupWDJWcurupOCSax6vbainjoSLu56R5tg2EUxIzrmgUw7vt4n6KSegQir
 nBTPeOkkamQqm/LXlXt8eu+DnrVXnxyPxriIN4zDk+dRJFlpA9baXPnpmU0oOeIyoVYxJW1QRF
 aAnv61LrvNYvrdLF77F/o6C/0ctnDIqwCljQlDA9ct5cPnjuf26hRbYY3nA0LA1TirDhPO9PWK
 5w8IesGwYrU3OJ60RYI/Xdf0BeIdkRm4BAAA=
X-Change-ID: 20241112-pickup-bpif3-245ab208b9a4
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733709622; l=2859;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=jnWlOcQNzehpBEsFTrnpdqUXbyDB7xus4yO0rQaMiUE=;
 b=EJuuB4PEL3TKTHrrKIFckO3St5nf1B93f2WEXWhuRoeoTBKjGAG1hWXbnfxzx62Kmqu2SIqvf
 UjDJrsqVdPtDG0jpOs45Wau9bT0Ard1fSaln3mQ8fk/8xxtLOCyeGkD
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
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
 board/spacemit/bananapi-f3/Kconfig     |  25 ++
 board/spacemit/bananapi-f3/MAINTAINERS |   6 +
 board/spacemit/bananapi-f3/Makefile    |   5 +
 board/spacemit/bananapi-f3/board.c     |   9 +
 configs/bananapi-f3_defconfig          |  20 ++
 doc/board/index.rst                    |   1 +
 doc/board/spacemit/bananapi-f3.rst     |  86 ++++++
 doc/board/spacemit/index.rst           |   9 +
 include/configs/bananapi-f3.h          |  13 +
 17 files changed, 751 insertions(+)
---
base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
change-id: 20241112-pickup-bpif3-245ab208b9a4

Best regards,
-- 
Huan Zhou <pericycle.cc@gmail.com>

