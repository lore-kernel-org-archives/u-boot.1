Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F51C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72BA8006D;
	Thu, 20 Feb 2025 22:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YG90SbXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B04580F5F; Thu, 20 Feb 2025 14:55:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDCD8001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439846bc7eeso6012465e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059731; x=1740664531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FBV0sSv6L+85XXXbM370AJ2lKj/uwMyF1YIii6aajU4=;
 b=YG90SbXOxFGcrtiIQZbgXykBhWqLvaJ2jl4YflzKIxLFNmErQQLbCvJg//aWcBs9aL
 8XCVZn8Xy9n/wCN/XX4PWRDdeyUwb6ZoB8X+axI6kq352AOd/+dBGU9ov6S3f9aVrWRN
 LViO1PmlPuodT8eg3OwrF+p34UQ1qNdQQHmls9zVhjd3DsOpOu/JeQ+6m7F5vvooMIY2
 ouUrzC462OBjV9HC3TgQ2C9plSK3v0WMFEWQInWTNsZOBvtkWZ8OIysfeMg0yXfylgcW
 k7rB/fJ8l6mcXQux7BkHVAQ5rXQghCPqFuWDjGGO5163O7zfEYdv1bHoUpB1Lk2yKa7v
 pSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059731; x=1740664531;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBV0sSv6L+85XXXbM370AJ2lKj/uwMyF1YIii6aajU4=;
 b=rYRvJL7jSWUc1YbPCef2t0SbeQ8JK5iZ28wo+DtsrwGk2Wi0Kma50Ln1CITnLJ/mtX
 Ob4Vp3dJh8LhYJHxJkw7wKvcR/yQEM3cPauYjPLXAHNoeCNs59TdzcJqJbgYGiym/Yy/
 Me2n0LnqXaKsnhguZtlRvGwNSMDUXMivQPQz/0dmXCVGH2+BJkh1XF36OXwT14cFRL83
 W1MZAn0XY/bxnv51N/griySQsqvQKk5M9OsaKDM/tpaArd/DWisdM3yfyd0oOVlVd4LD
 LpFp+McliPMTQuvYWBR3912hISIWJI9LEEUtVuyohG8OS5cMDkkHbKBxpsMKbnyYT5T2
 luUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh+24hPwZF+Fepcq+sQW5Ic8l/jExwJHhRVAml/u+V2d/sN8xwkDIIdUtR+XtElnnxPyhH6rA=@lists.denx.de
X-Gm-Message-State: AOJu0YwnWK776U/F2tt6VRthyHabykeIWi8I9rq+744l0mv6EVvokHiv
 IGQaFfdhEdCIwgeGO0dHQoaUtQ8h1n0bvdtlFPoQZMrHpkAIuuRHtJ2ZyjHRTMU=
X-Gm-Gg: ASbGncsu9TdtNxAKluObsIMgy/gvDHpFds1q4/fPztsCEa/kDJdHu3X4GfmqPWVL3aQ
 TjM48em/hLDmzLqpyDYxfLzi5nvlA+Fw1BB42QQFwUVt3febcaFgoszOsaOBBZyP6Y0YkWS+tM1
 0Df0fGl7He3sNIG3EjN+H+sWeLFjrMIqJtNdMmgmCz8AaeDecTHT/G3P2Ue07ExIeOQcnUJ72LG
 za7hUarEG5rkzuBaCmvHeG50leEdpdzpUMQsRaOwKxciMIT0oyvxHlSwEs399wL7ekJHeJoG12R
 55jygjBT/hsbO4Q3ARCAfISw15PQeoTsLCzMLNM2vEkOhFsFgOjO4s9MR5qwTkK/a9MRwQ==
X-Google-Smtp-Source: AGHT+IHcGfXf+BkfrjOXqLHJvBulTAYfgiIUmNj96AHn9Qw2/R+LlH9yObQ4aOdtiD3KmU7Vaa3ktQ==
X-Received: by 2002:a05:600c:190c:b0:439:6017:6689 with SMTP id
 5b1f17b1804b1-43999d97e0fmr63199535e9.9.1740059731416; 
 Thu, 20 Feb 2025 05:55:31 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:55:30 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/6] Fix page permission on arm64 architectures
Date: Thu, 20 Feb 2025 15:54:37 +0200
Message-ID: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

Hi this is v2 of [0] [1]

This is an attempt to map the U-Boot binary properly and enhance its
security posture but leave the area we load binaries unaffected and RWX.

What I have done but decided not to include was Simons suggestion of using
DM for the cpu ops. I've spent some time doing this but once I finished I
realised that the DM cpu ops are only present in a handful of boards.
Since we want this to work for all boards I've kept the DM branch here [2]
but still use the weak function approach on the patchset. I can resend
it once we have boards supporting the DM class.

Changes since v1:
- added r-b from Caleb.
- The memory map only gets dumped if CONFIG_CMD_MEMINFO_MAP is enabled as
  Simon asked
- reworded some patches and Kconfig messages according to Toms suggestions
- Fixed suggestions from Richard on linker scripts and added a Kconfig
  option to reduce the required page alignment if the feature is not
  selected
- Treating _u_boot_list as .rodata, they end up in RO memory now
- The function changing attributes returns an int instead of void so we can
  reuse it in EFI for the memory attribute protocol -- Heinrich
- Correctly cast the size as size_t instead of phys_addr_t in
  pgprot_set_attrs()

Change since RFC:
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

[0] https://lore.kernel.org/u-boot/20250205071714.635518-1-ilias.apalodimas@linaro.org/
[1] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/
[2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions_uclass

Neil tested a bunch of board as well so adding his tags here to be picked up for
the entire series

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905X-CC
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S805X-AC
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi-M5
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi-M2S
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

Cheers
/Ilias

Ilias Apalodimas (6):
  meminfo: add memory details for armv8
  doc: update meminfo with arch specific information
  arm: Prepare linker scripts for memory permissions
  arm64: mmu_change_region_attr() add an option not to break PTEs
  treewide: Add a function to change page permissions
  arm64: Enable RW, RX and RO mappings for the relocated binary

 arch/arc/lib/cache.c                    |  6 +++
 arch/arm/cpu/arm926ejs/cache.c          |  6 +++
 arch/arm/cpu/armv7/cache_v7.c           |  6 +++
 arch/arm/cpu/armv7m/cache.c             |  6 +++
 arch/arm/cpu/armv8/cache_v8.c           | 57 ++++++++++++++++++--
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++--
 arch/arm/cpu/armv8/u-boot.lds           | 59 +++++++++++++-------
 arch/arm/include/asm/armv8/mmu.h        |  2 +
 arch/arm/include/asm/system.h           | 11 +++-
 arch/arm/lib/cache.c                    |  6 +++
 arch/arm/mach-snapdragon/board.c        |  2 +-
 arch/m68k/lib/cache.c                   |  6 +++
 arch/nios2/lib/cache.c                  |  6 +++
 arch/powerpc/lib/cache.c                |  6 +++
 arch/riscv/lib/cache.c                  |  6 +++
 arch/sh/cpu/sh4/cache.c                 |  6 +++
 arch/xtensa/lib/cache.c                 |  6 +++
 cmd/meminfo.c                           |  6 +++
 common/Kconfig                          | 13 +++++
 common/board_r.c                        | 20 +++++++
 doc/usage/cmd/meminfo.rst               | 71 ++++++++++++++++++-------
 include/asm-generic/sections.h          |  2 +
 include/cpu_func.h                      | 17 ++++++
 23 files changed, 288 insertions(+), 48 deletions(-)

--
2.47.2

