Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34F1F8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B59A841C2;
	Thu, 16 Apr 2026 10:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XAMlu/tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FD0841D5; Thu, 16 Apr 2026 10:47:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA4A8407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso61201865e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776329241; x=1776934041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=14166xfYCWkGXr+gAZ1xaoeQqQgnle9skVQ92yUtQuk=;
 b=XAMlu/tfqexn0zSTBoX4Cly78E/YJpL94CS84GHlwGk+kna+sfsgAWu2avzoNoOQfK
 wyOKooEwKqcKDsPmAZrMpuf2h9WJMO7tRk6IXoLNsq7N+6zWBsbIErRl7qBSgLQT8GeE
 grAq6s+T4sCp9s7AyELY5vL+javF55dK4/dYOSDNZFtcuwbGaKvGABtT6mWfkgJ68wy+
 ay9Wohc5WI+UTqhOdVb/6HEnl9A/6HlewB7bhaOFO5qCSCIlKWoj7JAz/5W3IAVyzbvN
 yLr9BIV6K1wGI2KaWUTpnjclrdXo8MgA2pxsOUYtw8ERRoWni2qlGjh+NNsHMnERNgpP
 GjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329241; x=1776934041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14166xfYCWkGXr+gAZ1xaoeQqQgnle9skVQ92yUtQuk=;
 b=rm70uIcKSKbSKZjygNEIXiKOjVqqE69gS2tWJY0A2wUGjCayccH7+MYODbAlYyemzk
 XBx88RwukhLF1M21NvfIYFJVQFuJr7+MVFNF8fjy+i35agjbPF9S9DKyKgRb+POok821
 +oIuU9GW8v4QXJ0WtP/sBFQLm6318fX+M6XgbOw/SOXtmpYsfa7UxVqbZT9vjwDWVxG6
 gPyxeIKeu2h3voGyf80nQm/s+3Vn98/9jp+tt2A8xZ9vvyuRyBVZf1shioRHqcuiH+02
 TDRtkVxl9G5kUaTD33Oay49iHjARqpidOR1dCcAJOJbdc2ydcU9lfT7e5tKXLz5a9zJR
 B1bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ83N4IotPgi1uMM7Xj8Tre0FS69HqRltyyLhlQmjd3e2QladnNjbE10XakhAMHKi0AJNF2zj6k=@lists.denx.de
X-Gm-Message-State: AOJu0YxFWfG7rMQ7c0kaHPGcFP5AFWEsfBFSrKbuN7IltLxAB1xGFWMz
 BNOPq4JqfOA0W5bxIwYarSJXlMMWcHDBXbQpp6IpCZw6YY/pDZTHHtRy
X-Gm-Gg: AeBDievtDGxzUfCM+72NUsYR54JOfKWnFtUHYnkLrMjHB9ENoRWcDCKLpz6kvneYyWc
 F/jghv+GgYIzl2EhZbBHWMwlXBwOrDDqDbQmRlMqJh3B8OL77TZ886aYuXGTScnU/HUDzKttHoD
 Pk56bRExzRuYlFdwTKLRL/y+eJnDjzouvzsMJdrpJeNPOHQu6WhE9Ixz6+hQF6m6nLavMNLTJ0d
 xB3VVHyBSkz16XOhmXQ9cTmgDoRGIXkTnT2tt3OqV06NCZWQEtux3L69wKxFsXZDcxpkeiGrMWP
 48E7rrWth7TLcbjeaoFJ4N5iPNfBORZd2ZZLVe2SOujeULHWl2DhIxrjNsMHxKaB27X4V/b9kAM
 cxVoD6NV9byXlnKIv61KEGEY/qXoas62MoDogQC3VAhhs6Hel38oBheexZGfydYLAn795U64STu
 xY5+RoeElBZLBjGUqnescwyR7byQSCBPTriRI20hc7+JfmL1kiS+a4Zk8YN41+dd7l9sx0c0kv2
 ioufpQ6kIdqqz2uWEJOJCdYs+e2In4+5nkx579KqIsJC2xVvHTZaFix5/Y=
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488d67b8db8mr270741965e9.2.1776329240644; 
 Thu, 16 Apr 2026 01:47:20 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm13391674f8f.10.2026.04.16.01.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:47:20 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/3] add Toradex Verdin iMX95 support
Date: Thu, 16 Apr 2026 10:45:22 +0200
Message-ID: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This series adds initial U-Boot support for the Toradex Verdin iMX95.

It also introduces a new RAM-size probing helper based on alias checks.
On Verdin iMX95, the first DDR region is reserved for Cortex-M7 firmware and
the get_ram_size() could not be used to detect the actual RAM size.
Using explicit probe/alias pairs provides reliable size detection for the
supported memory variants.

The board DT is currently aligned with linux-next. Once the board DTS is
in mainline Linux, we'll move to OF_UPSTREAM.

Emanuele Ghidoli (3):
  common: memsize: add RAM size probe based on alias detection
  board: toradex: add Toradex Verdin iMX95
  toradex: tdx-cfg-block: add verdin imx95 0226, 0227 and 0228 pid4

 arch/arm/dts/imx95-verdin-dev.dtsi            |  239 ++++
 .../arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi |  112 ++
 arch/arm/dts/imx95-verdin-wifi-dev.dts        |   21 +
 arch/arm/dts/imx95-verdin-wifi.dtsi           |   50 +
 arch/arm/dts/imx95-verdin.dtsi                | 1172 +++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |    5 +
 board/toradex/common/tdx-cfg-block.c          |    3 +
 board/toradex/common/tdx-cfg-block.h          |    3 +
 board/toradex/verdin-imx95/Kconfig            |   36 +
 board/toradex/verdin-imx95/MAINTAINERS        |   13 +
 board/toradex/verdin-imx95/Makefile           |    8 +
 board/toradex/verdin-imx95/spl.c              |   75 ++
 board/toradex/verdin-imx95/verdin-imx95.c     |   80 ++
 board/toradex/verdin-imx95/verdin-imx95.env   |   20 +
 common/memsize.c                              |   56 +
 configs/verdin-imx95_defconfig                |  183 +++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/verdin-imx95.rst            |  171 +++
 include/configs/verdin-imx95.h                |   27 +
 include/init.h                                |    7 +
 20 files changed, 2282 insertions(+)
 create mode 100644 arch/arm/dts/imx95-verdin-dev.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev.dts
 create mode 100644 arch/arm/dts/imx95-verdin-wifi.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin.dtsi
 create mode 100644 board/toradex/verdin-imx95/Kconfig
 create mode 100644 board/toradex/verdin-imx95/MAINTAINERS
 create mode 100644 board/toradex/verdin-imx95/Makefile
 create mode 100644 board/toradex/verdin-imx95/spl.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.env
 create mode 100644 configs/verdin-imx95_defconfig
 create mode 100644 doc/board/toradex/verdin-imx95.rst
 create mode 100644 include/configs/verdin-imx95.h

-- 
2.43.0

