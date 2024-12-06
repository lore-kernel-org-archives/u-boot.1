Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CAE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A250D88ACB;
	Fri,  6 Dec 2024 23:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l+RcpKMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EBA8870D; Fri,  6 Dec 2024 23:54:54 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A2888ACB
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46375ac25fbso25044671cf.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733525690; x=1734130490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FpEobe0cKi35hFHw6+Ngd+djB58S8yacqOETbL2ZS8g=;
 b=l+RcpKMQvj4yG4Yz7B1MirHtH678546gE3w/2PbjoI8wFmRKBXob3ge1xS3BmTvJ1S
 it3MSGG97vugNyWezyQRkrUdWx73dnM9cCwR3BiKmroOsz9D7jZOPco4gL5E8Q4sM2SW
 SCWYC7K5cmzi0PNsEV7zAL9K7DXVcyvy3+qGPHrkYmJrud6B4Ih8PJasJYrKNtDWIeHb
 HkbvJESagMSoT99nq9N/afkPhjXWRKvcGFo0P31xouXnfJzZW2f+cczldzkywR3tRFGe
 AKThyy3s5L5eA2XFCzDVvKxzaiE6+hGqae6Oe30gzQI4TUHejJxey2U7fsh4rZUwolmn
 /9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733525690; x=1734130490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FpEobe0cKi35hFHw6+Ngd+djB58S8yacqOETbL2ZS8g=;
 b=lv3X2hQVUxjeNsYukgF0K6Zm2/5dMXfKeM17kzGCF47v51/Swjj3P5QxYtJCURM82E
 9QNsd1XGuZwF8wp3tfdOzAYZYq/xnuQjmisOzk0bB6jm87xq03esa4m2lQPdifK+XDw/
 oJolbAN7eH3ekmcnoGJi6Ahj9NtJBS3zhhQDGeGFSuYmxt7LGp77Z05/OUMHxIhOVgtg
 IC3duSPEj4+EHZHptoJdbQw8SrLA1niB3GX/G0oitNwQVNWtJ08vD/tGsZzjnY4HF+jW
 ZqJBXEtrvogJDwD3JBaKKx+sPhfAHiahXTDZsqmAW2mttT5gzHuG18x25ZBZD74vd9rw
 NhnQ==
X-Gm-Message-State: AOJu0YynWMDzI7qK5mPwGu76aZ0+zu6WqQVhJZxi4d0UPbHZBFqN+oSM
 xSTz26Ehh/13C2UvqN2TfCIB7sSxSc1mHHEZFUmZDsv4OZjYm+XDKzyIf1CAGlIKv2td/YZ/BcF
 a
X-Gm-Gg: ASbGncunyiiEejfx6m1fYJjBlobiPjGCthMOfg26b/7b8jGtV8OkHYq6iPKbl2JMZIu
 zCrjpMEW8Kfvyaozj/zLO9HV3Jir5nGd7Y8Lntw+ARwrYy+XWfZJO4o1Jx/O5j4h56eo5zpZgUV
 B+7pvAgiHfvh27o1fubETtOV9Sw/2UcV+WDJ4x2sTw0tBHuZF36EQix2kkxVbPoiVmcr4nmMp87
 /c2ltdtymrTy8KCqhOgleq05qFKvt6TYs1Vp+obCAVYgmizF69WC1bIrRn8m7QUo2yWihsnoeVN
 UdwxVqKfaJcgyebK+x6qFVCNPyPAkGtj2ItL28+COUfOiXAG
X-Google-Smtp-Source: AGHT+IHlBk/z34/sXIuMD7qJuhwshs3K9thez/b2HintNQtBrPTl2M/50sLZh92T/42AoBDoIYWUgQ==
X-Received: by 2002:a05:622a:7414:b0:467:48f3:3452 with SMTP id
 d75a77b69052e-46748f339a0mr8014681cf.56.1733525690201; 
 Fri, 06 Dec 2024 14:54:50 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d4d7dsm26080871cf.34.2024.12.06.14.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:54:49 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 00/10] SMBIOS improvements
Date: Fri,  6 Dec 2024 14:54:17 -0800
Message-Id: <20241206225438.13866-1-raymond.mao@linaro.org>
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
6. To minimize size-growth for those platforms which have not sufficient
   ROM spaces or the platforms which don't need detailed SMBIOS
   information, new added fields are only being built when kconfig
   GENERATE_SMBIOS_TABLE_VERBOSE is selected.
   
Once this patch is acceptted, subsequent patch sets will add other missing
types (#9, #16, #17, #19).

Tests:
To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
get a merged DT to run with.
```
qemu-system-aarch64 -machine virt -machine dumpdtb=qemu.dtb
cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v /dts-v1/) \
  | dtc - -o merged.dtb
qemu-system-aarch64 -machine virt -nographic -bios u-boot.bin \
  -dtb merged.dtb
```

Raymond Mao (10):
  smbios: Refactor the smbios headfile
  sysinfo: Add sysinfo API for accessing data area
  test/dm: add sandbox test for sysinfo_get_data
  sysinfo: Add sysinfo driver and data structure for smbios
  smbios: Refactor smbios library
  smbios: add detailed smbios information
  armv8: Add arch-specific sysinfo platform driver
  armv8: Add generic smbios information into the device tree
  cmd: update smbios cmd
  configs: Enable sysinfo for QEMU Arm64

 arch/arm/cpu/armv8/Makefile      |   2 +
 arch/arm/cpu/armv8/sysinfo.c     | 292 ++++++++++++++++++++
 arch/arm/dts/qemu-arm64.dts      |   4 +
 arch/arm/dts/smbios_generic.dtsi |  82 ++++++
 cmd/smbios.c                     | 348 +++++++++++++++++++++---
 configs/qemu_arm64_defconfig     |   3 +
 drivers/misc/Kconfig             |   2 +-
 drivers/sysinfo/sandbox.c        |  19 ++
 drivers/sysinfo/sandbox.h        |   1 +
 drivers/sysinfo/smbios.c         | 228 ++++++++++++++++
 drivers/sysinfo/sysinfo-uclass.c |  20 ++
 include/smbios.h                 | 158 ++++++-----
 include/smbios_def.h             | 194 ++++++++++++++
 include/smbios_plat.h            |  79 ++++++
 include/sysinfo.h                | 125 ++++++++-
 lib/Kconfig                      |   6 +
 lib/smbios.c                     | 445 ++++++++++++++++++++++++++-----
 test/dm/sysinfo.c                |   6 +
 test/py/tests/test_smbios.py     |  18 +-
 19 files changed, 1863 insertions(+), 169 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c
 create mode 100644 arch/arm/dts/smbios_generic.dtsi
 create mode 100644 include/smbios_def.h
 create mode 100644 include/smbios_plat.h

-- 
2.25.1

