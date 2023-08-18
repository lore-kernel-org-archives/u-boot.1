Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F7AC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A27A86C06;
	Fri, 18 Aug 2023 02:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YPOrQVyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA7086C02; Fri, 18 Aug 2023 02:27:19 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FDE986BFE
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34bb08caab7so1312785ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318432; x=1692923232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QxBaLQ63rIUGcjoQhSlNYQHR6VOdy1lqLJDtRT7s7Ik=;
 b=YPOrQVyo309QXqI+TeJr2YRG4AxKn08zH8xzLOdN3hBB0+q5Wxu8MF6EwKEKsnGdaW
 Ky7RuFJPqegbYGNhMSO2M+MPSyQ1WR9aGDng6K0hw4cLeiHaxAZjjp3TYpLWCThdiuq8
 iHKQE5utMP3p7+XSU2oq+9vQs2NKqP9bYIxL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318432; x=1692923232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QxBaLQ63rIUGcjoQhSlNYQHR6VOdy1lqLJDtRT7s7Ik=;
 b=Da2xWKZt6YugMqzjEwt/IEw0TfjjQsxQ8Q7xHHOf5aUPbg9n6c8mFKZaNgGUq8uxaC
 rcM6d6zR3jVUU75TkcjwHFbiTOlcjS4agBS4jJpOPcIfCDhCdDNPJBqFfOUpIi4c5acg
 KTHAI0ZRZlAkLnQRZdEXuRM3W3tFb0A1eC1dj1jxzYdCM6BufpKNrggVYeQS4sNONBUS
 d4mDPXjQ7KeCYhK3LFeAgHduWFKm8fMzUmrteH2beV5jKVH5u3bYSdyZCL4UJl+O7zyb
 M2H0DHBJHRVzA1gs17WJEgukqaGmozMiWo216D9TrjPox6hR4ySKcolx1ky86AEZFzbt
 GOkA==
X-Gm-Message-State: AOJu0YzxU00hBCny7l8WrfkZHQXUAhiB9ibycZqLlfXeWmP2DVHRrbpP
 WcFSyTSn8DJe9UecanlXXandab7raUwS4O6xyrk=
X-Google-Smtp-Source: AGHT+IE0vMQOapuiVzM9tf7TC6qSN9Su+voGJ5cXjMZQGIP2X+xjTvea0nkqSPCAVEyoflbqEtR1Jg==
X-Received: by 2002:a05:6e02:1069:b0:346:7502:aeaa with SMTP id
 q9-20020a056e02106900b003467502aeaamr1090235ilj.18.1692318432751; 
 Thu, 17 Aug 2023 17:27:12 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Anatolij Gustschin <agust@denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Coreboot ML <coreboot@coreboot.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Sjoerd Simons <sjoerd@collabora.com>, Stefan Bosch <stefan_b@posteo.net>,
 Stefan Roese <sr@denx.de>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 00/20] x86: efi: Fixes and improvements for coreboot
Date: Thu, 17 Aug 2023 18:26:39 -0600
Message-ID: <20230818002706.853550-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

This little series fixes various bugs and annoyances in coreboot and
coreboot64.

With this both coreboot and coreboot64 start up and work reasonably well
on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.

- Make coreboot64 debug UART start reliably
- Avoid the long USB-init delay on startup
- Correct the timer speed on coreboo64
- Fix a bootstd cros bug (will likely be squashed into another patch)
- Fix the terribly slow console scrolling

With v2 I have also brought in some lost x86 patches so they are all in
one series.

Changes in v2:
- Update the malloc size too
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch

Simon Glass (20):
  x86: coreboot: Add IDE and SATA
  x86: coreboot: Enable standard boot
  x86: coreboot: Rearrange arch_cpu_init()
  x86: Set the CPU vendor in SPL
  x86: Allow APCI in SPL
  x86: coreboot: Look for DBG2 UART in SPL too
  x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
  x86: coreboot: Drop USB init on startup
  x86: coreboot: Align options between coreboot and coreboot64
  x86: coreboot: Enable VIDEO_COPY
  efi: x86: Correct the condition for installing ACPI tables
  x86: smbios: Add a Kconfig indicating SMBIOS-table presence
  x86: Record the position of the SMBIOS tables
  efi: x86: Use the installed SMBIOS tables
  efi: x86: Install the SMBIOS tables if present
  x86: coreboot: Record the position of the SMBIOS tables
  x86: doc: Move into its own directory
  x86: doc: Update summaries and add links
  x86: doc: Split out manual booting into its own file
  x86: doc: coreboot: Mention 64-bit Linux distros

 arch/x86/cpu/coreboot/coreboot.c   |  16 +-
 arch/x86/cpu/x86_64/cpu.c          |   7 +
 arch/x86/dts/coreboot.dts          |   1 +
 arch/x86/include/asm/global_data.h |   1 +
 arch/x86/lib/coreboot/cb_sysinfo.c |   1 +
 arch/x86/lib/tables.c              |   3 +
 configs/coreboot64_defconfig       |  25 +--
 configs/coreboot_defconfig         |  21 +-
 doc/arch/index.rst                 |   2 +-
 doc/arch/x86/index.rst             |  12 ++
 doc/arch/x86/manual_boot.rst       | 276 +++++++++++++++++++++++++++
 doc/arch/{ => x86}/x86.rst         | 295 ++---------------------------
 doc/board/coreboot/coreboot.rst    |  38 +++-
 drivers/serial/Kconfig             |   2 +-
 drivers/video/coreboot.c           |  12 ++
 include/asm-generic/global_data.h  |   8 +
 lib/Kconfig                        |  20 +-
 lib/efi_loader/Makefile            |   4 +-
 lib/efi_loader/efi_setup.c         |  20 +-
 lib/efi_loader/efi_smbios.c        |  37 +---
 20 files changed, 447 insertions(+), 354 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 create mode 100644 doc/arch/x86/manual_boot.rst
 rename doc/arch/{ => x86}/x86.rst (64%)

-- 
2.42.0.rc1.204.g551eb34607-goog

