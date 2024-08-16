Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE93DC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F5B889E9;
	Fri, 16 Aug 2024 17:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N3vDS2lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B02885C5; Fri, 16 Aug 2024 17:47:22 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CDF889E9
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a1e0ff6871so141810185a.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823238; x=1724428038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XedKZ6/xeL2+MyfdsU7uZK4BRogp66GLZbJWFCl1NLo=;
 b=N3vDS2lOlDXrvCG72QZVPIBDuxB4WoqS0FkpDlOrREFNkfmGHGm/oNb6S+WOUn7vOz
 CSIU7URxBxx0RLSMEIR9t9dEtwG8mcZODTiczbuIgEiwrD5bNWbrQUSzwtPBz9zN/W1H
 GETAOFRmw6i99cBOQ6wyyHQtKpQ/t0f8TpfNoP1bxKObEG+GNSjisgL4K859ktjQTwdJ
 HxboTGEsjIon415Ilgqra4FLJp4QIWJ0m6rGcYOHv2N13z1/tMoC5KucNkHo8XGAHIrU
 5vEuNFX6NmzSwep+xkcwIwNXttOUEsqowmF2i8HHwHttyD00vweOV85t5mz71yfF00yQ
 yHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823238; x=1724428038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XedKZ6/xeL2+MyfdsU7uZK4BRogp66GLZbJWFCl1NLo=;
 b=kbZDidTKNbqPJLm+a3u6vEXdUGbXrpqwPInfufLNmZIMhosau9yAHd2ZMNX9K0Ww0S
 ZwQe6s1QM05nzgfDwW7sQq4f73VULVYtU3MnFNMDT/UAaxkz38zrpe9XlavxYbTGVhUd
 HBY4D8ePkSXIkT4la1mQrcBzghD1sghjuDjwQd48mytKaj+Wi1PLrJd7Rm1lE7xHlVi7
 j6mKMVjhSurPKdr0KESUsU2+EtxtzCtk5jNCjSbeEp2m6qzr2MI5haIBIoQxG6CIF/RW
 kZ+b4B2h3N0c6VUzJH9rf4biArsz5WyHhBpg7WF5Ep98Xt0S+pRZ6Qlng4HfiFmPUWn8
 WQ4g==
X-Gm-Message-State: AOJu0YzC8nw4hTmCI+P/Ow5HYeD+WI76Dl5WuozRgJe0ztfA1Mu2eYwR
 0Dx/JZCMS/CULUGfHp1DNqqfpjpcau3lfoWJfFw1kOm3XfibgvmLXfd1dVl5zzqy2/sQPC/5UMs
 RdQ4=
X-Google-Smtp-Source: AGHT+IG/0KEfPqv+l1xNjRLA3UwjCBCt5eHVyzWJNIfWyFyEuja+QzjfJoPyjWwU3Gumn1WnkIOlCQ==
X-Received: by 2002:a05:620a:410d:b0:79f:8a2:c33 with SMTP id
 af79cd13be357-7a64c75a89emr6827885a.8.1723823238128; 
 Fri, 16 Aug 2024 08:47:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:17 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Stefan Roese <sr@denx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 00/10] SMBIOS improvements
Date: Fri, 16 Aug 2024 08:46:43 -0700
Message-Id: <20240816154658.1866186-1-raymond.mao@linaro.org>
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
   SMBIOS private data from the device hardware.
3. Create a sysinfo driver to poppulate platform SMBIOS private data.
4. Put device tree SMBIOS node as a fallback solution when SMBIOS data is
   missing from sysinfo driver.
5. Add support for Type #7 (Cache Information) and link its handles to
   Type #4.

Once this patch is acceptted, subsequent patch sets will add other missing
types (#9, #16, #17, #19).

Raymond Mao (10):
  sysinfo: Add sysinfo API for accessing data area
  sysinfo: Add sysinfo driver and data structure for SMBIOS
  smbios: Refactor SMBIOS library
  smbios: ignore the non-existence of platform sysinfo detect
  armv8: Add arch-specific sysinfo driver
  sysinfo: Add sysinfo driver for SMBIOS type 7
  smbios: Add support to SMBIOS type 7
  armv8: Add sysinfo driver for cache information
  configs: Enable sysinfo for QEMU Arm64
  tests: update smbios pytest

 arch/arm/cpu/armv8/Makefile      |   5 +
 arch/arm/cpu/armv8/sysinfo.c     | 391 ++++++++++++++++++++++++++
 cmd/smbios.c                     | 350 ++++++++++++++++++++++-
 configs/qemu_arm64_defconfig     |   2 +
 drivers/misc/Kconfig             |   2 +-
 drivers/sysinfo/Makefile         |   1 +
 drivers/sysinfo/smbios_plat.c    | 442 +++++++++++++++++++++++++++++
 drivers/sysinfo/smbios_plat.h    | 131 +++++++++
 drivers/sysinfo/sysinfo-uclass.c |  20 ++
 include/smbios.h                 | 240 ++++++++++++++--
 include/sysinfo.h                | 124 ++++++++-
 lib/Makefile                     |   2 +
 lib/smbios.c                     | 461 ++++++++++++++++++++++++++-----
 test/py/tests/test_smbios.py     |   2 +-
 14 files changed, 2058 insertions(+), 115 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/sysinfo.c
 create mode 100644 drivers/sysinfo/smbios_plat.c
 create mode 100644 drivers/sysinfo/smbios_plat.h

-- 
2.25.1

