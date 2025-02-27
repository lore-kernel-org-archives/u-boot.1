Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFFC19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F75810F5;
	Thu, 27 Feb 2025 13:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pbWqJcKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AED480FF4; Thu, 27 Feb 2025 13:15:31 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1C5801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abbec6a0bfeso134866166b.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658528; x=1741263328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kTYs6pqzc3RnPER6g4hCKruCSUYQ5PyKDoyMjFil9SY=;
 b=pbWqJcKmhDoUrukRIbiI5ffaU5WaxJi9yTArkXYJ0BVFSXDC2I3jengPOoFK2Tx+wM
 yGkgNUx90Sw5Ssk419gHphHUNg/J+jEw3jzh4f1Yzh2Cy0pEgkHW8VqUKl/zsAIRUneb
 oBbxlzSBEUaulDdbvzkCtxBbtT96kCklawFrBMml8nlzX85NzfAZgq370u+ul3LgL+I9
 Wn6DUvdAeAzQRs0KK5HD/vX9PrZEYBZ8tAPbQZmjy8UmLPWw243umNV7g+C0ZEvwqxfb
 aDT9tBkd9GQpsCAtssWTMRp5oOnUphNontegt4PllGXeKh097ugKAOeAOZ+/eXHmph+5
 whsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658528; x=1741263328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTYs6pqzc3RnPER6g4hCKruCSUYQ5PyKDoyMjFil9SY=;
 b=gD1BxGUxcOSBbvNVCchWPYclOEQHXGXgPGCHv7wgaaBt7n4cd4DRhcvACjFvp/rP5H
 bMz429ORYNXQTMl3z5h6iVTULx5c1EkOqMbntSkEM9l0MHIz63cN7FwllBx7rKCQGGrt
 5m8Q2wuYi0gHSz3O+ytci8s0RHQN8IiYpayPJ/4kZ+OMJAq1Vaq2GVZC3F5pm03dtuRP
 rzlSp75Yr1tu6yZ2hzT84MgGpHYtF+Q7uhbJNpGF99oj640G05uK4r7QTlyTbzfrRSiR
 PsNGSS65fXXTw8wPdLgO/TnC99R/S/4b4gLHLBcFA3H5eJZtGNufhk7VrBm8ZdA23qzI
 dexA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWONEd13QLdTGm7Fq5CvITAkc5AK/nuSIesQGZQFAOCRGQ3/E9x6qW1Fv0kzx1WjaHwQJKakJw=@lists.denx.de
X-Gm-Message-State: AOJu0YxWQeu0RHPQhTyvQgF42IYYmnOSbKnEYCl6zGEVX0Yt/8//VI0O
 zrxrKDIAJ9t3MAdT/lKa7Rdy/dbjAsk5eA4AEkHHYgJ1PQOFuUgcl2cB6zabD/E=
X-Gm-Gg: ASbGnct1HqgonRX2Kg1hZIgWd+fs5jI7FC1iuAjsRWVdPtlcLG6KIWTyPPPq3t9SIUt
 EY4AH4UkWmYnXCXjx1c+CVl0gVf5A/A2UI3QbVnftxZRgVU3+JwDPX0vDW4BdjewoQzowjq1ujf
 eDVNM3J+mgFPf/kmEbfTV0gVuei+JvM+nRaMbQohtlyx8SWE+C2Vdob4PWqcJU0qFdzSeWsxUS6
 xWxo0OPRCk80VsZX+WQfbX4pjsd+Rlr4Mv4Crv6XygUswJD5Us5yKG59/TdQU/kVVuC+z0SoePN
 D8gzhsESM2wh8qGwJ6kpr4A1ZfRXNLhEKItDvIobga5Rh/XtOjGIEC97s/FpYtO1LhjN63+fDAi
 XmaLy
X-Google-Smtp-Source: AGHT+IHRNF29FxdBV629751ZAJ3oaEsmCU9YsFENpyi/I/p+0dgtYFynbPpu3aAwGcxnuzHHMX1EeQ==
X-Received: by 2002:a17:906:b818:b0:abc:29e3:f453 with SMTP id
 a640c23a62f3a-abc29e3f7cdmr2283700366b.33.1740658527867; 
 Thu, 27 Feb 2025 04:15:27 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:15:27 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 0/6] Fix page permission on arm64 architectures
Date: Thu, 27 Feb 2025 14:14:50 +0200
Message-ID: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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

Hi this is v3 of [0] [1] [2]

This is an attempt to map the U-Boot binary properly and enhance its
security posture but leave the area we load binaries unaffected and RWX.

Changes since v2:
- Changed the function arguments of pgprot_set_attrs() to enum instead of u64
- Added a new function instead of adding an argument in pgprot_set_attrs()
  to control break-before-make. This makes the final binary slightly
  smaller since the callers are using static arguments
- Added r-b tags from Richard

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
[2] https://lore.kernel.org/u-boot/20250220135506.151894-1-ilias.apalodimas@linaro.org/

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

 arch/arc/lib/cache.c             |  6 +++
 arch/arm/cpu/arm926ejs/cache.c   |  6 +++
 arch/arm/cpu/armv7/cache_v7.c    |  6 +++
 arch/arm/cpu/armv7m/cache.c      |  6 +++
 arch/arm/cpu/armv8/cache_v8.c    | 79 ++++++++++++++++++++++++++++++--
 arch/arm/cpu/armv8/u-boot.lds    | 59 ++++++++++++++++--------
 arch/arm/include/asm/armv8/mmu.h |  2 +
 arch/arm/include/asm/system.h    | 18 ++++++++
 arch/arm/lib/cache.c             |  6 +++
 arch/m68k/lib/cache.c            |  6 +++
 arch/nios2/lib/cache.c           |  6 +++
 arch/powerpc/lib/cache.c         |  6 +++
 arch/riscv/lib/cache.c           |  6 +++
 arch/sh/cpu/sh4/cache.c          |  6 +++
 arch/xtensa/lib/cache.c          |  6 +++
 cmd/meminfo.c                    |  6 +++
 common/Kconfig                   | 13 ++++++
 common/board_r.c                 | 20 ++++++++
 doc/usage/cmd/meminfo.rst        | 71 ++++++++++++++++++++--------
 include/asm-generic/sections.h   |  2 +
 include/cpu_func.h               | 17 +++++++
 21 files changed, 313 insertions(+), 40 deletions(-)

--
2.47.2

