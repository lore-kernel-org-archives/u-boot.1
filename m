Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D15C0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 00:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6334780F85;
	Mon, 27 Jan 2025 01:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZ6ihW/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0870980F84; Sun, 26 Jan 2025 19:43:46 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF70880F10
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce76b8d5bcso36142835ab.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917021; x=1738521821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EuUI/oPhTV+Nys5Tb8NxhnwJNxvi33OjWK/zXU8O9HM=;
 b=bZ6ihW/E1GuD3JU1v7Pyq8fLW7ADHrgqVq8r9B55ptV7N+bNzn24dxA2qCOsi5of/L
 rGkFVuzsRy9KOjs37hjIZNMIqIemLVWyqkaGIHE6hHG3dIIUcyzhxCeERS+mLrCD/+mc
 891HvAaYV7xD+5liCb8s9+3FUY7/9KNLK4xFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917021; x=1738521821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EuUI/oPhTV+Nys5Tb8NxhnwJNxvi33OjWK/zXU8O9HM=;
 b=oh+iEgSxus4xeiWJJCXE+uYBYLH4ypaHBZX5q/3m92CLag4QmsMM2K85Dlapt0OKDA
 eEBIobR9ODW7BCid6yfLwpacdIVBVy46/fDu+UZQzNjo0BYwBQcW9VWKV+3ogrixJYQt
 kETF3kbD+B7nYstxva8edSJeIuuqKVzQsT9gekzFmwkJlrloC4nOfdiNm/32IYO2GgJw
 hFzXMZUvoR8TbDRTpjbAoiOtk55q5LSh0B7FwbnwwIoFfGI1GQSa0jkosTGKy06yk7EI
 I7vP1zytRbMDUMWoGsK00P3lAqWILibhdZ9UhzA8jpxkzNPiEroe0dP/1R8bVpE1ICp1
 ywCQ==
X-Gm-Message-State: AOJu0YyC4R8o2mjcPSNGGTcBVWiShekJnEPuLkLXCLC8Ipb/wb8AyEX3
 G1ybSHgsxiCEwqwYnZX+676UxfmjiJp+gETTIqu1za9xn+A0xi2DhhbdxozaZxEKTCXCe52KvHg
 =
X-Gm-Gg: ASbGnctdtbrm+jdP427Yhqa/wczLvg01ruuJSv/LdKoVJA2NDheuYA+lZRHDwk2MPuC
 NYob+zKK0pYRxsyKBX1Ls08v8L5/9o+5h4jvnwc8WbMD1UV0m2RlrRctoCKVychiMcEGmFgusz9
 jRgoV2I07I32t8c+0/TUUXDW98ana8zA86qm/FWdHmTmFxO20YZiggV+O/Xuvmz8zkQYghXB10m
 kiALGSpp11xNXSubd8kihKJx4qEf1rTOF6h5l28ikdFGrUbX+vxeYYbXZ7rWUJf/5oVDOIAiy1y
 YhwJcT+eNrIGB15ywJaBsYT6jbPD9x0ekRTruCP2HA==
X-Google-Smtp-Source: AGHT+IFyq5+tAOxFZySC5lMKyvuYV1sQCvNMYJGkEcv5VGDogh+fr5ExL6FyIsXHuBYgX4UGyVYl4w==
X-Received: by 2002:a05:6e02:1749:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3cf744201a4mr362298745ab.12.1737917021406; 
 Sun, 26 Jan 2025 10:43:41 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:43:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Palmer <daniel@0x0f.com>, Devarsh Thakkar <devarsht@ti.com>,
 Franco Venturi <fventuri@comcast.net>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 00/19] vbe: Series part G
Date: Sun, 26 Jan 2025 11:43:10 -0700
Message-ID: <20250126184333.4058848-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jan 2025 01:09:10 +0100
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

This includes the VBE ABrec (A/B/recovery) implementation as well as a
number of patches needed to make it work:

- marking some code as used by SPL_RELOC
- selection of images from a FIT based on the boot phase
- removal of unwanted hash code which increases code-size too much
- a few Kconfig-related additions for VPL

Note: The goal for the next series (part H) is to enable VBE on
rk3399-generic, i.e. able to boot on multiple rk3399-based boards with
only the TPL phase being different for each board.


Simon Glass (19):
  mbedtls: Add SHA symbols for VPL
  sandbox: Update sandbox_vpl to select sha1 and sha256
  mmc: Allow controlling DM_MMC for VPL builds
  lib: Allow crc16 code to be dropped
  spl: Adjust debugging and xPL symbols
  spl: Avoid including hash algorithms which are not wanted
  spl: Support selecting images based on phase in simple FIT
  vbe: Support selecting images based on phase in FIT
  spl: Allow spl_load() to be controlled in any xPL phase
  spl: Provide a way to mark code needed for relocation
  lib: Mark crc8 as relocation code
  lib: Mark lz4 as relocation code
  lib: Mark memcpy() and memmove() as relocation code
  lib: Mark gunzip as relocation code
  vbe: Support providing a linker script
  vbe: Provide VPL binman-symbols for the next phase
  vbe: Tidy up a few comments
  vbe: Allow VBE to disable adding loadables to the FDT
  vbe: Add an implementation of VBE-ABrec

 MAINTAINERS                    |   7 +
 boot/Kconfig                   |  73 +++++++++
 boot/Makefile                  |   4 +
 boot/image-fit.c               |  29 ++--
 boot/vbe_abrec.c               |  83 ++++++++++
 boot/vbe_abrec.h               | 115 ++++++++++++++
 boot/vbe_abrec_fw.c            | 276 +++++++++++++++++++++++++++++++++
 boot/vbe_common.c              |  24 +--
 boot/vbe_common.h              |  43 +++++
 common/hash.c                  |  17 +-
 common/spl/Kconfig.vpl         |  13 ++
 common/spl/spl.c               |  26 +++-
 common/spl/spl_fit.c           |  40 +++--
 common/spl/spl_reloc.c         |   2 +-
 configs/sandbox_vpl_defconfig  |   2 +
 drivers/mmc/dw_mmc.c           |   4 +-
 include/asm-generic/sections.h |  16 ++
 include/spl.h                  |  19 ++-
 include/spl_load.h             |   9 +-
 include/vbe.h                  |  21 +++
 lib/Kconfig                    |  10 ++
 lib/Makefile                   |  11 +-
 lib/crc8.c                     |   5 +-
 lib/gunzip.c                   |   9 +-
 lib/lz4.c                      |  37 +++--
 lib/lz4_wrapper.c              |   2 +-
 lib/mbedtls/Kconfig            |  40 +++++
 lib/string.c                   |   5 +-
 lib/zlib/inflate.c             |  18 ++-
 tools/Kconfig                  |   5 +
 30 files changed, 879 insertions(+), 86 deletions(-)
 create mode 100644 boot/vbe_abrec.c
 create mode 100644 boot/vbe_abrec.h
 create mode 100644 boot/vbe_abrec_fw.c

-- 
2.43.0

