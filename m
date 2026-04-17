Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DBEF8E4B3
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 07:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910CD84223;
	Fri, 17 Apr 2026 09:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9FBJB9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B408421D; Fri, 17 Apr 2026 09:15:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D68283BC8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488c2690057so2989685e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776410149; x=1777014949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZObDLYbnKjzKb4/WgI0LGzpjZuwWZXZAlgz2m5+2aI=;
 b=S9FBJB9WTOjNAVryPl7Xx3xuFZXRSo/+q0LPOTHg0oU7JPnpfaqe8Oawtmn9qNOKzE
 oZKy9rA1+bUdsOEAlxmLF24705Z+0FaszaACZJACrYzmoqiMN9ycA3YmOFO8taLvxMNG
 zU28Krv3a035QFgYgAg9LlAz27R1XxzeVMJrDPm4Tpw0DcR2k71lyHthwBWeM7Oa3q/l
 rSoi92wm7WlZVHVINRSjUgDRRpval564qUuvK32fPawi5Vox3dywGHx4WVPgEfBnTyeU
 mSqSCMJP+DaPEln0HvQp2F6qZPWUOreXvVvhEUz6rkiRbbcURn8yenZXu+k/lP1AFPox
 A6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776410149; x=1777014949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZObDLYbnKjzKb4/WgI0LGzpjZuwWZXZAlgz2m5+2aI=;
 b=h8UY9TVyxSD5MsL3Upqr70eeMz0BJCj+CGXsGaiaqRHWtFLgmux9a48n/JwbHYZfLf
 cPPie7JQIx9YIXYfubgxohRwrHyJcBd+NFVcy7JGkh0Gfv2CMm01+g1uLATr8L+zl1Du
 Sl19Pk/ZXU9iFvN0Kbr55gPkHNk9UqY036eIaRCmYubZpY0e9MgrRuMuOIN/FpgTzfsR
 PJwvEAHzDIVwl7XUKC6/HgHFfD4bK//s0vTRfhYDYVJ13J41mv8p9dSBAMgdXT2XfF7I
 bVqdw67ICoWNK/2HV9uh2w+hN14zw62znQJjuIqaNE4BWWIGSwxLjO9TkuSAXlrZ7kVI
 pkMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xCtN2pJDjg+nUPCQW7XLSkR2X5FcU3h+WCdWbPYYddllXAuUmUXn8N54xKMN8+SLmAJ5fUGw=@lists.denx.de
X-Gm-Message-State: AOJu0YyaLoeolv2s+J31KY2ZK4DgeUXWfAWyPghq7pufVwW3Vj91agCz
 kmMrqiqP69tNKuOKekjuiNrpGVX5YWV2/EZ/UOOj95HhGQ9YF6GjnWsu
X-Gm-Gg: AeBDiesDNF36ly9yeb/scVN9QwQJ7szaVzEQm2I3Cizk5aIdCXO7nYTr++T50U+Yy7o
 40M10yDqiAdlmRdbU5S/J7w8pDegIDl8a5GyI9U1x/aQrf0SXcwsgywrmuQstwp7miqeauzX8bE
 z8DU/TKMwJlsUsdxAVEkEVa36vyxtRwnJXJ8wMP/t50Op8TCut3kelItKrnd7yOmLN3WSrbnopq
 9mJ2/5F57A6DqzDPJigBk8hC82KPIXhI8VOUVn+N3c+t/ZZxv58L9RSthx4xk2p24UY7iuyikYD
 FpVGEm26eSsC7ZWJm22JZiJ6EVch7i+FjTpTw9DnMiaLnFYWsvoNrEs2kYC0b12BYqz0e1FQ+41
 AoM5qkWI0IZWubIjlpVk/btzuOpMLt7EsyNbQScYA6Nx3lo7bywD+RL/bXmb02FscXixqi0oR8l
 NDJ+uwpTo3YVKbwPcGV8oIEhoB4hT+k7c6uUwQU7DMInnBa/F4G8dasiArCurEKBQNfSsUrvXGQ
 Mo3BgJZxzAP9fK7dHjP0hwgWVq0+nrzbXAStqzsFyuQCaNx
X-Received: by 2002:a05:600c:a318:b0:486:fdca:ea8d with SMTP id
 5b1f17b1804b1-488fb784662mr14971515e9.25.1776410149188; 
 Fri, 17 Apr 2026 00:15:49 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6dfa33sm15573955e9.0.2026.04.17.00.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 00:15:48 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 0/3] add Toradex Verdin iMX95 support
Date: Fri, 17 Apr 2026 09:13:30 +0200
Message-ID: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
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

v2:
 - add check for CONFIG_IS_ENABLED(SYS_DCACHE_OFF) in probe_ram_size_by_alias
 - renamed ram_alias_check variable to ram_alias_checks. Added static qualifier.
 - fixed typo in verdin-imx95.h: determited -> determined

v1: https://lore.kernel.org/u-boot/20260416084535.1490476-1-ghidoliemanuele@gmail.com/

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
 common/memsize.c                              |   59 +
 configs/verdin-imx95_defconfig                |  183 +++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/verdin-imx95.rst            |  171 +++
 include/configs/verdin-imx95.h                |   27 +
 include/init.h                                |    7 +
 20 files changed, 2285 insertions(+)
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

