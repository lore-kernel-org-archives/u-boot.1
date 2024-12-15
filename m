Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DB0E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 05:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B460B8006F;
	Sun, 15 Dec 2024 06:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kk8u8N7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB0980083; Sun, 15 Dec 2024 06:03:03 +0100 (CET)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750398006C
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso1966495a91.2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734238979; x=1734843779; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aCYVgCh1KegEkuyqtfFL38I9B21vqgj8noh/K+Ry5aU=;
 b=kk8u8N7mdh5Aej1YSRYl/P+MiGFvXh+UJq6osMnTP1n1dMIC/I/XyJwsUsw3n5vkYx
 z/bqDqFLXDVXCMbeacfTe46FxuMue1+17lJ80vk5gkz0O/4mlHtjuAnxDnbsoAAPRynE
 fgZETdn5UsOOAmu86VsxD+vt0F+nYsjfLmjq23GYTHtlF1lDF2nKIBAGBFPwzlZ0bn55
 Kp64jDMGg9dUpnqrvWFN33ghO63ThP+gdocRi7ZVUX0fSH4Jx+q3c4IQLNMBIrMCzdfe
 aVDAQ3Rx5TgtsHFHnqAWBMay5YSWQzKSw4tR93iEwZwoVaIxYBdL/icQWq4ovB1QfBnL
 QBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734238979; x=1734843779;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aCYVgCh1KegEkuyqtfFL38I9B21vqgj8noh/K+Ry5aU=;
 b=YTQoSRifNxyWGV6FCvMBaCEBXzZ2W+sxFja93cdxHjEAFEkg6Q6Jevl+vOx9bofRrR
 9yjTf33Zo8hKdphzJRXHtpculqTaAA2AEdqmyLLhHcDjK1pd3Ugu7iQ6MJghjq/fbACS
 /Ks+duZ2fllSOx4/Tm18tG66X6phhszej0EouBKF1GUN6syPmz4XVefS+VNYJwVzGHY7
 W851Xur+4biyQLLIM7maBvUKDbJSg2ADuRoxlT2/QZDIwoSeSZz6IiyrYLqIPnq+GtR4
 9gtZnlDu3I99ZxIENFgCdJ79mHbF/UjFDqH4Dl64ccH1zpBZMdX+KE7VHrE4nBsMfJ/D
 uFrQ==
X-Gm-Message-State: AOJu0YxCgwmEKXylteQ/T/wq5vLmt7mXygrCQCNNm7XfJezKMLaavAw6
 JKjTZ5mf2PALKqVmdLEoREmJpx67TtuvA8qqhaCfcdBpNDFInKB+
X-Gm-Gg: ASbGnct8K6a8GpPA2wWuZc//yVXoQEKxpS6asYr3G0ro8NURoLsrxoBKtOOeQec8LBg
 vP+sDXUmiUxlqDmvLDU8DBu9oQCouTwWYzDOzvYrRh75pW9jh2LKQGxn0nuTb7yiYLR4kxOwdIM
 v9ohG3afqrZ/4Vpn/7Wzk2SOqJjBczYyij9xI1/ERuDxEgjX9vRrBHziyeJNSB7sqRAVHp+0IVG
 vIrr5GdE12OKyQBpoQ46e0j+z1+14ZMgoZ39B2tjKX/hSnJ/0OSdsuIuxuGJPLe5aE0N/KZmu1R
 8vRRTx0GYJS+ink1ADegjuk2BQ==
X-Google-Smtp-Source: AGHT+IFMYotEcw7pzRk73965AMzYWMy2FiQb25Jw1LtsXaKnTcGL6Ae7bLBTJ9MRP4bfgXl1KMSYZQ==
X-Received: by 2002:a17:90a:fa8d:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f28fb63fcfmr12612507a91.14.1734238978680; 
 Sat, 14 Dec 2024 21:02:58 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c38996sm1965638a12.80.2024.12.14.21.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 21:02:58 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Subject: [PATCH v8 0/2] riscv: spacemit: add support for bananapi-f3
Date: Sun, 15 Dec 2024 13:02:40 +0800
Message-Id: <20241215-pickup-bpif3-v8-0-c78b96b9927b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBiXmcC/33RTU7DMBAF4KtEXmNkj/+74h6IxYzjtBakCUkbg
 areHTdFIhiJ5Vj63jx5LmxOU04z2zUXNqUlz3k4lsE/NCwe8LhPPLdlZiBASymBjzm+nkdOY+4
 UB22QQHgKqFkh45S6/LHGPb/c5ym9n0vq6f7ICOfE49D3+bRrSJBtRfROePBSIbaoozCAnnQCE
 cG4lqhFdss65Pk0TJ9r00WuYd+l1O9Si+SCg0LjfYxGSfu07zG/PZata9CitlhXWBUcPGrjBSC
 5UGO9wRAqrAtOIXRInbVJqRqbHwyixua2GTovJLloo6yx3eA/tW3BSlhljAerjamx+w+7gssd2
 lC+w3aOtvh6vX4BGZ5F2yUCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734238968; l=3461;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=gqIMUbKSIlWXMVBY6ExXeog/SM5m59+EqjRot3MEj/w=;
 b=V/I1fekc4mAqee5ds254USSyecfl3Otyo1UmItAuzp5k7zeyCTaRGOeL0goN03tVKLCRvhee4
 9QnopQvsj2wCMn/EDWOLJ6bCEj8tzw0wfmfw/oKPKPzmN2ebpB1egWB
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

Changes in v8:
- Rename spacemit to SpacemiT in doc.
- Update doc.
- Link to v7: https://lore.kernel.org/r/20241214-pickup-bpif3-v7-0-d0cd91146f7b@gmail.com

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

