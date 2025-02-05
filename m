Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF289C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D23807E1;
	Wed,  5 Feb 2025 14:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F4UEt/Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C0C805D7; Wed,  5 Feb 2025 08:17:25 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9E880207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 08:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so8755915a12.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 23:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738739843; x=1739344643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aiMDUOF+vVLyUleOeRJRJvo1kndXbMVJLcBcDO9796s=;
 b=F4UEt/Xc1P0j2VrUWpLj7r99mUvyiOp212M1wNczkp4iSdS1HUA8o0ONGT2DgeqjXP
 YQ7Ej6DznaOTFUtRF25fTq4piXl4WgSEx58b4QQDqDRIkK3QL0/r20xb0GXoZ9dHL30Y
 L79yPwE8NWErVGX7SAj5wu7rYMJZotKS0CD+YwKaffNrklLjEqqBxDh+krKNgXWPNpxa
 Qc3RtW5LAX1w0cTfDLq6AxODKLDqmM+1pLpESWXr+/H06L3pOJsNCHWfYFj/kWjzpvjL
 jIQci8bVrdXzVhw6FT8HE0r/hLymvLDblDaDD3VktjJHfWY7FYDEdmR+T0I3q/6BSx82
 8MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738739843; x=1739344643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aiMDUOF+vVLyUleOeRJRJvo1kndXbMVJLcBcDO9796s=;
 b=dX/1idUMkG/2tvoIHnDrj2gY3KqybFJfbxP8Zr5oIzGn0eRJ8SreWbpU+U7thR2bZ6
 vwPdMmWxmEbUqM2yc4JT9QGGn1PaRzyhwbNkhMedE9vwCIINHPjGlo6NqqGlE+pn7nM9
 eDsoQV3xq5rUWNROQ0OPMMDJvguLoqmj4ALYPy166UqNy3WRluab0YeehFNJIv9t8PoT
 fr6NDTtnhvK+CHKB1yzQy7lpivw9VKVq8t3Sql0MMAkOURvzYdrkmhaWKxgb4QQzQQzQ
 a9EF+ADCdIGTCUGTb3v+EfMHokIVhlLMC4/7GhM4Mmx2bM6ZTgfAUVo2WkEd7FI89K11
 cRog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmn1oTSi4dLqtq3myzAhUqITUfTwhcs2HIbh3Aah8VG898Fj9iumG8Tnrp98LV9w3A3m+KNQs=@lists.denx.de
X-Gm-Message-State: AOJu0YyEKJSuw/gcBQ9o4xVKyW4JqHCU+kwJSwM18x5Tfh1RiO4ru0QR
 w857Be4e1/RKjJdh6kGw1q6g2vqdVxWEy7zC10A5bglCrN4BOsyC6S1+mAcaZ9w=
X-Gm-Gg: ASbGncsw5Ta6TPhsM4YuHQ0V0hrMqEsEcUE7C646fnrav7B8pIsee9QDnNukIU5Fkox
 irQvblfVRsmZnS/P/nrpJS7PwJnaLsfQmAyHsges3zDppUjYiUbT+Tcplm9ikLzk0Lb3zTD3WVH
 rLu0l6CY3RtCb6Jp6sk8Yo+g5+AHAb/37nn9Vdp0V9Azck9n72TrfkA8c2AsLQqNpjZDZEKP2qP
 DkFG8RlD1e6G5NN/JXXhrpuJO4tPRa6uRxQp3Iwibj2Gl3XzFsLOuj6nJYSvk67HCNjYeFs7SIJ
 u02DID1fjwrjgg7oymshUa0wFuYhf4qNkyICv2oAApxm+AM5z02nqVFrt9DSEgTWlgTi
X-Google-Smtp-Source: AGHT+IFrqZT+Wxah9GzgLXCS1HQRbce9GrKmgtDcb4sguUaAclbNdRhkjMs0IROUN+4ZSDgdXGUe0w==
X-Received: by 2002:a05:6402:4604:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5dcdb762a2cmr5463015a12.20.1738739842769; 
 Tue, 04 Feb 2025 23:17:22 -0800 (PST)
Received: from localhost.localdomain (ppp176092167070.access.hol.gr.
 [176.92.167.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcda28cbcesm1107191a12.43.2025.02.04.23.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 23:17:21 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/6] Fix page permission on arm64 architectures
Date: Wed,  5 Feb 2025 09:16:44 +0200
Message-ID: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Hi!
This is v1 of [0].

This is an attempt to map the U-Boot binary properly, but leave the
area we load binaries unaffected and RWX.

There's a few changes since the RFC
- Fixed the alignment of meminfo command when printing regions
- 'meminfo' now prints arch specific attributes e.g PXN, UXN etc for arm
  instead of RW, RO, RX
- Since we don't set the permissions of EFI runtime services yet and keep
  them as RWX, I removed the linker alignment changes which makes patch #3
  easier to review. It's worth noting that qemu-arm sbsa was crashing with
  the efi services page aligned. This is probably due to a mismatch of
  memory, since the crash is only reproducible with QEMU instances that
  have < 2 GB of RAM. I'll fix that along with the efi runtime services
- Defined memory attribute changes properly with an enum for RW, RO, RX
  instead of the hardcoded '1,2,3' I had on the RFC
- Enabling mappings is now under a Kconfig (CONFIG_MMU_PGPROT), since
  peope reported crashes when testing this, which are orthogonal to this
  patch. We still have places in U-Boot where we define and later write
  const variables. This will lead to a crash now as const variables are
  properly managed and places in RO memory
- Split patches to be easier to review
- Added a patch updating 'meminfo'
- Picked up acked-by tags from Jerome

patch #1 adds printing capabilities for page mappings in 'meminfo'
patch #2 adds documention in 'meminfo' command
patch #3 prepares linker scripts, aligns sections in page boundaries etc
patch #4 prepares an internal function to change the PTEs
patch #5 adds function definitions & stubs for all archs
patch #6 wires up the changes in U-Boot after it relocates

[0] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/

Ilias Apalodimas (6):
  meminfo: add memory details for armv8
  doc: update meminfo with arch specific information
  arm: Prepare linker scripts for memory permissions
  arm64: mmu_change_region_attr() add an option not to break PTEs
  treewide: Add a function to change page permissions
  arm64: Enable RW, RX and RO mappings for the relocated binary

 arch/arc/lib/cache.c                    |  2 +
 arch/arm/cpu/arm926ejs/cache.c          |  2 +
 arch/arm/cpu/armv7/cache_v7.c           |  1 +
 arch/arm/cpu/armv7m/cache.c             |  2 +
 arch/arm/cpu/armv8/cache_v8.c           | 54 +++++++++++++++++--
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++--
 arch/arm/cpu/armv8/u-boot.lds           | 29 +++++-----
 arch/arm/include/asm/armv8/mmu.h        |  2 +
 arch/arm/include/asm/system.h           | 11 +++-
 arch/arm/lib/cache.c                    |  2 +
 arch/arm/mach-snapdragon/board.c        |  2 +-
 arch/m68k/lib/cache.c                   |  2 +
 arch/nios2/lib/cache.c                  |  2 +
 arch/powerpc/lib/cache.c                |  2 +
 arch/riscv/lib/cache.c                  |  2 +
 arch/sh/cpu/sh4/cache.c                 |  2 +
 arch/xtensa/lib/cache.c                 |  2 +
 cmd/meminfo.c                           |  5 ++
 common/Kconfig                          | 13 +++++
 common/board_r.c                        | 20 +++++++
 doc/usage/cmd/meminfo.rst               | 71 ++++++++++++++++++-------
 include/asm-generic/sections.h          |  2 +
 include/cpu_func.h                      | 16 ++++++
 23 files changed, 215 insertions(+), 41 deletions(-)

--
2.47.2

