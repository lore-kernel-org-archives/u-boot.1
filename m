Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B25C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAC5806FC;
	Sun,  2 Mar 2025 13:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MSaL21sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94226810FE; Sat,  1 Mar 2025 17:49:47 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B8A810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e4c0c12bccso5557197a12.1
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847784; x=1741452584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hLpu45rQNgQ1Xx1l//Eo12vdx/3Dnml9joTThgLFGKg=;
 b=MSaL21svt3kH8E2ab1Vxz02PKnZra5BTnHaYKdf3rbyP4bNl8QMsfGE4aoNV7/Qwny
 kqitoEdMIfD7zNGoqSG7+CqhT9r4h3HUIESzQqldQCE5194pzwjYMyLHRBTA7duHxHGd
 NM703luMfT0R9aDIBNM65l1oovl8oR5xSsVblJnFfgKLKrT4tK/AYFpPuMkyzJfD87/r
 uLls3mpmyQGG6VWtxs8S8SdBvim6kTRj1ktxEGfBUv754GFs68SW3UJclSkGnneWHxMb
 9DHI7oG0Z7qZuWRFzYACkZtVXhbV7zEu3J8QrIGgYUwcW83LxGxAKT68zwIijN1ENaaB
 72Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847784; x=1741452584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLpu45rQNgQ1Xx1l//Eo12vdx/3Dnml9joTThgLFGKg=;
 b=tS+xG7oIaWmAToswZcez4dqVRv7/OEHuj+jpKgqv8YcLTvsmtT4RZPF34eVXunDxIG
 EL7r01bcFwuHTR9M4BWU/3Ksy3HvyogqVej8hoNWLjAEzNNU4kblrA00G2uTnyNDlBdv
 Ktz3YXvhuM75Y/kgl3C777Bi7B3upjULFyjRGHkHUXsvxcU8MwsJfKrCxDzEhoaOl0MD
 sg1CSVq3camFaRkcR9VJdkPYE5e5Y/frPtb78aTjM5+k5115x0gYgz7nOe6UP0D0U6f6
 W0mvlSBqrX60MChcGbfXqFcuGaAvnGg+wcW5uttjogc1vNPB/qYSq/5bUKMFCGJcpNQk
 FHyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyVHiKk/wvp0o6Gixs4GIoSvUml9n/Vm77eILVxw4MbNH5bKpDvqPU0Wf3IquhdZAHFKVI8MY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6CBf7es/3A0WB2GoPoWO2ZRH7YTdlMmnOue9hcJ5NuwD6I/Xu
 XRFg67eYcofg4o4+BsPioaqDjDaR1fLf35Gd0C7fnq6SFGtW1yGWA2He+tT+TO4=
X-Gm-Gg: ASbGnctvz7eHyf98K0N2S/AC913IclwFbOlnaZPQfObiS5cRx1R4iUk5IiOxwq5fyf3
 3oJ38EvPJ7jUBOKm7k1AWrsq7XfcsXkvG0/ddXRQCBou3dy/NCm7MunDrvbKDJN4hwOojqzi72Q
 Aqb1Kzs8j4N+yZaskMSBOgQcbMrGfeaq4nv/pUtjWguaoFnCvASOEKW0EoxiaRj4kPir0hoTZo8
 1ldcivHd/eNAkuMtjc8vnclNM8kCXDq+3Dvdc+pKcBJ/NsG+oMptir4hcgjzMP/64E+No1KNjRG
 SJZOtYTjistKh+FD1Yw0YDxzi+NVU8TagbF+wcwsr0yOElioBGaGuhu9mcc/f3A47x4ywG1XV4p
 /6ru9stGFJWXvcZ15Z8KymOg=
X-Google-Smtp-Source: AGHT+IFEdXMxYI3EntC1mel+CFkhF5aV4wOWgzAQ2CStNvx45BHiNUSDtzVoFvuxDkiTQlpxrhPMiA==
X-Received: by 2002:a05:6402:848:b0:5dc:d10a:1be8 with SMTP id
 4fb4d7f45d1cf-5e4d6b0e6c9mr7990060a12.19.1740847782579; 
 Sat, 01 Mar 2025 08:49:42 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:49:41 -0800 (PST)
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
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 0/6] Fix page permission on arm64 architectures
Date: Sat,  1 Mar 2025 18:48:58 +0200
Message-ID: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

Hi this is v4 of [0] [1] [2] [3]

This is an attempt to map the U-Boot binary properly and enhance its
security posture but leave the area we load binaries unaffected and RWX.

Changes since v3:
- Call mmu_change_region_attr_nobreak from mmu_change_region_attr()

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
[3] https://lore.kernel.org/u-boot/20250227121515.232996-1-ilias.apalodimas@linaro.org/

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


Ilias Apalodimas (6):
  meminfo: add memory details for armv8
  doc: update meminfo with arch specific information
  arm: Prepare linker scripts for memory permissions
  arm64: mmu_change_region_attr() add an option not to break PTEs
  treewide: Add a function to change page permissions
  arm64: Enable RW, RX and RO mappings for the relocated binary

 arch/arc/lib/cache.c             |  6 ++
 arch/arm/cpu/arm926ejs/cache.c   |  6 ++
 arch/arm/cpu/armv7/cache_v7.c    |  6 ++
 arch/arm/cpu/armv7m/cache.c      |  6 ++
 arch/arm/cpu/armv8/cache_v8.c    | 99 ++++++++++++++++++++++++--------
 arch/arm/cpu/armv8/u-boot.lds    | 59 +++++++++++++------
 arch/arm/include/asm/armv8/mmu.h |  2 +
 arch/arm/include/asm/system.h    | 18 ++++++
 arch/arm/lib/cache.c             |  6 ++
 arch/m68k/lib/cache.c            |  6 ++
 arch/nios2/lib/cache.c           |  6 ++
 arch/powerpc/lib/cache.c         |  6 ++
 arch/riscv/lib/cache.c           |  6 ++
 arch/sh/cpu/sh4/cache.c          |  6 ++
 arch/xtensa/lib/cache.c          |  6 ++
 cmd/meminfo.c                    |  6 ++
 common/Kconfig                   | 13 +++++
 common/board_r.c                 | 20 +++++++
 doc/usage/cmd/meminfo.rst        | 71 +++++++++++++++++------
 include/asm-generic/sections.h   |  2 +
 include/cpu_func.h               | 17 ++++++
 21 files changed, 313 insertions(+), 60 deletions(-)

--
2.47.2

