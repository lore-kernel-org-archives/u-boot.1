Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D5C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 07:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636FC80AE4;
	Thu, 30 Jan 2025 08:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HThcO6jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB49080B9B; Thu, 30 Jan 2025 08:21:09 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7389A80AE2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso2843235e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738221667; x=1738826467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qeTa6ht1b5XKOwPg0RS3CcanbnYaz/SxN6h9tTKwY0Q=;
 b=HThcO6jfyHD5FGEHjHTnx22kSm7L+7F5I0Uhu0OwmoUUkag0uM0i1koGEbbTPoCxHM
 Xdwpsvz2koIDCJzwy74oCGtXFFdFlLylMtrgrSiSQrJWuAzwujEiJtw+M4Xa8S0SjAUc
 c8DT9Z9t4jjBXOEaKci1jeDgPZG7wqF+hn8AhkVNjTcxVuN7fppsKHm0Yr3ApdvxmAbW
 y3xvz2eMe/o1QzyT1qYQss+EPJ01pFMPHEptCAWLhE21H2u6DUfBXirnZfd4gnXWMISb
 ulg3GAurI/1WaYuTnM2jFvRXA8qbTjTMcbMJtwkeN7EN3pVwWkx4j5I1cSEOnGLTGyh/
 r6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738221667; x=1738826467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qeTa6ht1b5XKOwPg0RS3CcanbnYaz/SxN6h9tTKwY0Q=;
 b=O/OA56svApntTptPq1lN/opxZsFVDXQ8gnzY6Uzbd4wC3Tqr9AICCw/GJ0BY/61hcm
 SNCgKOudV9AInKqS3YsHR81qvkSAedVsd0xqGI3qtmKLbf6e+Wxc+HvmG1jPjLaGyPXd
 zCL5ocrK+9751O5IKgSe4jd0oX1j7BHwM/fQV7mJTMohYkvi0fwLcZxzvzTImGDxwhoU
 ZKybEa81TFb+9cEeFOWZAMPAIAhbrNaK9cEpxvVT4k+Of11Z35ct7jzVpUT+i2CXlI61
 icgEq0n4HkzrCIrvf2fup7JnXijR4u5ghcCFGKUQ2X88B3Pd2LeP56BK3Cu4P1zXI63P
 gXeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOm45B4jyXKZuoiwLGz55OC3b98E8YcgtBehNBqpyqQaHJ/wHpE0y/DiA/eoGUlQ+aXXJAjuk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+akUtGJEBVr9VmXYngFJthw0zU267jYpFBDDXbq5OEST5KASy
 dGkk7jJTuhZtLFFdXEtqVsgw8v2DCBm/JcezbCz/OvFGsbvc23YQhl7KGMvAVJk=
X-Gm-Gg: ASbGnctefcV1ZFQZruE8yJzWC6oCID94DEh45dNAMktV7vc9ivIIW7SOBW5ufBYudbC
 Vd77RIIqsXptfVSs7d1a+RejjEhsP3X5vZL4WwgNQWUcngp52fahhOH+GJ+GsaRe7afrqb0oYWP
 S4ljht13oPNFcO7WlODh7yf40Kk/74P/+6Xi7RFjOVCoHGpWaYPlrRAgW5aoS5KHQ8/vUFiABgr
 VbxtdltBBTmYqzqvYZMQtMDiyC0zzYEz3MahGgpDVJqog1LULVXOwVZVzGG5nR+YFQ9trKak65b
 Ml1cLoaF6lXT/im5O3RP4wAQRReAEDweHUxtAIqqlO/wSu2kDQ==
X-Google-Smtp-Source: AGHT+IF6zYXqVOPNFgcbSvj2X8qe5RIZ3piL3MxoQTCY8RE1912pTCza2kjplxdbdPkPKi43xyPsaA==
X-Received: by 2002:a05:600c:3c86:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-438dc3c2413mr59817515e9.10.1738221666774; 
 Wed, 29 Jan 2025 23:21:06 -0800 (PST)
Received: from hades.. (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm48076345e9.29.2025.01.29.23.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 23:21:06 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: maz@kernel.org,
	trini@konsulko.com,
	CFSworks@gmail.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [RFC PATCH 0/4] Fix page permission on arm64 architectures
Date: Thu, 30 Jan 2025 09:20:25 +0200
Message-ID: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
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

U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we are
better off mapping binaries with proper permissions.

This is an attempt to map the U-Boot binary properly, but leave the
area we load binaries unaffected and RWX.

patch #1 adds printing capabilities for page permissions in meminfo
patch #2 prepares our linker scripts, aligns sections in page boundaries etc
patch #3 is adding a function to change page tables
patch #4 sets the permissions for .rodata, .text and .data

There's a few problems problem in this RFC ...
- U-Boot has no MMU APIs in place. As a result I just wired up the function
  changing the page permissions in board_r.c but only for arm64. In the long
  term we should add an API that other archs can use if they wish/can
- meminfo doesn't align all results properly (Caleb?)
- I am not setting the permissions of EFI runtime services section on purpose.
  Since the OS is allowed to call SetVirtualAddressMap, we need to reset the
  pages to RWX just before ExitBootServices, so the OS can relocate that code.
  In arm64 this isn't a huge problem, because we explicitly disable SVAM if
  if VA_BITS > 39, but other OSes/archs will have a problem.

# TODO:
- Long term. Add an MMU API and use that instead of exporting arch specific
  functions
- Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
- Set the permissions of EFI runtime services anbd reset them before EBS()
- Fix alignment when printing pages & information
- Add a Kconfig option so the feature can be turned off.
  The reason is that QEMU CI and some boards, fail because they are trying to
  write RO pages. This usually happens due to variables being wrongly defined as
  const, but with the updated page permissions this leads to a crash [0] [1].
  In both cases the reported ESR is 0x9600004f which translates to
  "Abort caused by writing to memory" "Permission fault, level 3.". On top of
  that not setting pages as RO (and only setting .data and .text sections) works
  fine. So until we find and fix the bugs above we can't turn this on
  unconditionally.

# Open questions
- Is initr_reloc_global_data() the right place to change permissions? Or is there
  a better/safer place to do that?

# How to test patches
- Aplly them an enable
  CONFIG_CMD_MEMINFO=y
  CONFIG_CMD_MEMINFO_MAP=y
  'meminfo' should print something along the lines of
=> meminfo
DRAM:  8 GiB
Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
[0x23ffe1000]                     |  Table |               |
  [0x23ffe2000]                   |  Table |               |
    [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inner-shareable
    [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-shareable
  [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inner-shareable
  [0x23ffea000]                   |  Table |               |
    [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inner-shareable
    [0x23ffeb000]                 |  Table |               |
      [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inner-shareable
      [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inner-shareable
      [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inner-shareable
      [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inner-shareable
      [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inner-shareable
      [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inner-shareable
    [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inner-shareable
  [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | Inner-shareable
  [0x23ffe3000]                   |  Table |               |
    [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | Non-shareable
[0x23ffe4000]                     |  Table |               |
  [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | Non-shareable

[0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714

Ilias Apalodimas (4):
  meminfo: add memory details for armv8
  arm: Prepare linker scripts for memory permissions
  arm64: mmu_change_region_attr() add an option not to break PTEs
  arm64: Change mapping for data/rodata/text

 Makefile                                | 15 +++++----
 arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++--
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
 arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
 arch/arm/include/asm/armv8/mmu.h        |  2 ++
 arch/arm/include/asm/system.h           |  3 +-
 arch/arm/mach-snapdragon/board.c        |  2 +-
 cmd/meminfo.c                           |  5 +++
 common/board_r.c                        |  7 ++++
 include/asm-generic/sections.h          |  2 ++
 lib/efi_loader/efi_runtime.c            |  2 ++
 11 files changed, 97 insertions(+), 28 deletions(-)

--
2.43.0

