Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF178CDD0E2
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3C488FE3;
	Tue, 22 Oct 2024 22:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jWEBHm4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E277289056; Tue, 22 Oct 2024 22:06:18 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46B288FA7
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 22:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b152a23e9aso424100185a.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729627574; x=1730232374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2l2x0H6ooiTZkuCoVcSnRtauz6Vza1Xvx2WDzhNbizs=;
 b=jWEBHm4zDJHUd2B4jsEQ0hnmPWO5MwoIoOElMNpdEbsdFxb5cblMluyIfW9+xShdA/
 k3ea3tknJ/hnSdtpN4RdlLNUuR3kXudTQsgVT4ktNrVTw92tKroprrg6y4+xZeAtmPm7
 EfEVxNYsW9QHmL3IdIWshD4sjf+HLvXl2yv3tkL/p81kMB/QuWVoD2EIwcKBUm37oMqD
 VeyDt5cmWWYIKjl6IDDDNXOBOzMcISi+SyRDtSj21tdiAync2WoaF6eoZYFpSvJg0zLU
 vewgj2wwJqvYw2p8WsCGBUL37IaQY286onWrSPD4FtpUfnU4SxiImahM/ojiUgDheTH0
 dmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729627574; x=1730232374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2l2x0H6ooiTZkuCoVcSnRtauz6Vza1Xvx2WDzhNbizs=;
 b=Ye6dQCY4X5u+mPhBeA9oxxaZ+mLAMWGLDrPUuWJbgPr3zkl2+Fx13raKSU5LmnGciz
 gC8OeawxGPDkpOGJTKRtq87WLUNebuhivGHovrJQN+Xj2uWo+ajLeJJYd9l9xSEua9oJ
 Yy7L5GtXfqvZPn0hDmG4zWInjD676lV2XrBR8mIQcQwGqbM+VEL/nrA+bjWZB2i2waoN
 hxqCq924LmrsNIxaEizGkaASUVFcBmJuya/d/K5Zy5Y6ojzOPzJrpt/85kJ0AHw0grrj
 iwzhjMpP8GdEj5GleAu7/w2l9VmmUspkieVOjR+yaZLr0v8XwDLGajejII+5dgQX2+7S
 sR9Q==
X-Gm-Message-State: AOJu0YxxHW7kF22KUAEvcAHl6s3+datCN4n7RfcH1rtHyB2MZTerxo8Z
 kPEHRDZX7/uNfXjfFeOSqUTowCWRVPD+gE9ijOtkERjmfLURGsppbJZGxz858mUmuPZlrzo/ZwP
 E/dY=
X-Google-Smtp-Source: AGHT+IEcogvv6g4UTEAlY1Sll27KEFptd6mpoEOgKb6shifB1IPNKVOzFcoCZAq5jI11Ui3SAB6Mog==
X-Received: by 2002:a05:6214:4402:b0:6cb:ee08:c1e8 with SMTP id
 6a1803df08f44-6ce34191896mr4004096d6.23.1729627574529; 
 Tue, 22 Oct 2024 13:06:14 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce0091a255sm32519956d6.59.2024.10.22.13.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 13:06:14 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: iwamatsu@nigauri.org, marek.vasut+renesas@mailbox.org,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 0/8] SMBIOS improvements
Date: Tue, 22 Oct 2024 13:05:21 -0700
Message-Id: <20241022200543.116343-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Motivations for changes:
Current SMBIOS library and command-line tool is not fully matching with
the requirements:
1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
2. Only a few platforms support SMBIOS node from the device tree.
3. Values of some fields are hardcoded in the library other than fetching
   from the device hardware.
4. Embedded data with dynamic length is not supported (E.g. Contained
   Object Handles in Type #2 and Contained Elements in Type #3)

Changes:
1. Refactor the SMBIOS library and command-line tool to better align with
   the SMBIOS spec.
2. Create an arch-specific driver for all aarch64-based platforms to fetch
   SMBIOS private data from the device hardware (processor and cache).
3. Create a sysinfo driver to poppulate platform SMBIOS private data.
4. Add generic SMBIOS DTS file for arm64 platforms for those common strings
   and values which cannot be retrieved from the system registers.
   Vendors can create their own SMBIOS node using this as an example.
   For those boards without SMBIOS nodes, this DTS file can be included to
   have a generic SMBIOS information of the system.
5. Add support for Type #7 (Cache Information) and link its handles to
   Type #4.

Once this patch is acceptted, subsequent patch sets will add other missing
types (#9, #16, #17, #19).

Tests:
To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
get a merged DT to run with.
```
qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/) \
  | dtc - -o merged.dtb
qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb merged.dtb
```

Known issues:
It hits the image size limitation on R-CAR board(rcar3_salvator-x).
```
u-boot.img exceeds file size limit:
  limit:  0x100000 bytes
  actual: 0x10049d bytes
  excess: 0x49d bytes
```
This board needs a clean-up to reserve spaces for the changes as SMBIOS
is a fundamental feature.

Below is the breakdown of the size-growth of the related functions:
  function                                   old     new   delta
    static.smbios_write_type4                  252    1052    +800
    static.smbios_write_type7                    -     764    +764
    static.smbios_write_type3                  188     488    +300
    smbios_get_val_si                            -     128    +128
    static.smbios_write_type2                  316     376     +60
    sysinfo_get_data                             -      56     +56
    static.smbios_write_type1                  380     396     +16
    smbios_write_funcs                         112     128     +16
    ofnode_read_u32                              -      12     +12
    sysinfo_rcar_ops                            40      48      +8
    install_smbios_table                       468     472      +4

Raymond Mao (8):
  smbios: Refactor the smbios headfile
  sysinfo: Add sysinfo API for accessing data area
  sysinfo: Add sysinfo driver and data structure for smbios
  smbios: Refactor smbios library
  armv8: Add arch-specific sysinfo platform driver
  armv8: Add generic smbios information into the device tree
  cmd: update smbios cmd
  configs: Enable sysinfo for QEMU Arm64

 arch/arm/cpu/armv8/Makefile      |   2 +
 arch/arm/cpu/armv8/sysinfo.c     | 292 +++++++++++++++++++
 arch/arm/dts/qemu-arm64.dts      |   4 +
 arch/arm/dts/smbios_generic.dtsi |  82 ++++++
 cmd/smbios.c                     | 346 ++++++++++++++++++++---
 configs/qemu_arm64_defconfig     |   2 +
 drivers/misc/Kconfig             |   2 +-
 drivers/sysinfo/smbios.c         | 228 +++++++++++++++
 drivers/sysinfo/sysinfo-uclass.c |  20 ++
 include/smbios.h                 | 158 ++++++-----
 include/smbios_def.h             | 191 +++++++++++++
 include/smbios_plat.h            |  79 ++++++
 include/sysinfo.h                | 125 ++++++++-
 lib/smbios.c                     | 462 ++++++++++++++++++++++++++-----
 test/py/tests/test_smbios.py     |   2 +-
 15 files changed, 1822 insertions(+), 173 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c
 create mode 100644 arch/arm/dts/smbios_generic.dtsi
 create mode 100644 include/smbios_def.h
 create mode 100644 include/smbios_plat.h

-- 
2.25.1

