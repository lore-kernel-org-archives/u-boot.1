Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C93FCF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5F58941C;
	Fri, 20 Sep 2024 09:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HCkH7nBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B3F8941B; Fri, 20 Sep 2024 09:26:11 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E8A89424
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so10214516d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817168; x=1727421968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/T9ddhJDwxbZe0RWjlY13qGClCGq7i1OnvSGowIGXGU=;
 b=HCkH7nBiM7vnK22W1NFjYFrqQ+2v2GZCLEuFMeM4O8VgEiPzZg+LS3NUBiVE96sp4b
 BhzKrZEFi3GQkbeNvNiPcBWO8GMXoSCNvVbkudNWTWgmLbtiUX8TfmB00mi0aAmc4GD9
 aqAq8zxNZL1ry0dm0GxQOQenXwmBZUF4Q1XIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817168; x=1727421968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/T9ddhJDwxbZe0RWjlY13qGClCGq7i1OnvSGowIGXGU=;
 b=spBPERzcPCG40bd5RctYHauwehpnv0MdfjgBsiiJVEpnCjJJfZWBRKHcFxMNJq4qNK
 szWUfWmba0eHSo+C+pHa/kx79piTLbcM+PzZr+9t0oUrmSeIyoBaNelIzYDD8OenQozS
 ung+rasWyC5pPgl654G32QRekZGIhun0ePC5cgdYst+sNkmqdN78KcuNlBqcfMQ8hVkH
 +X5AQkDLdkCDpozF60CwW5qMnHHUJl4gFQZnJXs42hjkg//1EpIL6oLXDcbXQue97UMQ
 UL8ImxNbSiv7hy8ApDAz3LNNtOSWANORLPp4N5JNvapW8BaDW7HCGotwsNZaH4+Ihtdh
 bMcQ==
X-Gm-Message-State: AOJu0Yz8HGCru4OAkoNC4sAVbayzBxNMNzvQR1ITC8+yRQspkccgsiaq
 e7NX3d9BOgGD1FwD4djxGGWfJcz2hRcfzzhfwGzhWp1WlclD/fZi8kQ1GhINz6s/9B9hO6U5uUz
 GRwZqB+xg/WTzbBfH5hI9YSX/YQ8D0R/ZwDhm
X-Google-Smtp-Source: AGHT+IGxZ5ud1kKldbpQkFozQvM6PHrf3NyU15Lj39JNt4cBJCuw3dlMyDHdTge4kCDE7EWhSwIX/MFxefMqCkizpCY=
X-Received: by 2002:a05:6214:3c9f:b0:6c5:aadd:9219 with SMTP id
 6a1803df08f44-6c7bc6a4bc5mr32107506d6.11.1726817167648; Fri, 20 Sep 2024
 00:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
In-Reply-To: <20240920070242.20884-1-tien.fong.chee@intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:56 +0200
Message-ID: <CAFLszTgN8uTDBfLixYY7pMRsU370t++OiFweqYYZ119Oa=bdRA@mail.gmail.com>
Subject: Re: [PATCH v1 00/20] SoCFPGA: Add Boot Support for Agilex 5 in U-Boot
To: tien.fong.chee@intel.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>, 
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, 20 Sept 2024 at 09:03, <tien.fong.chee@intel.com> wrote:
>
> From: Tien Fong Chee <tien.fong.chee@intel.com>
>
> This patch set introduces boot support for the Altera SoCFPGA Agilex 5
> platform in U-Boot. The changes include:
>         1. Board-specific configurations and setup required to enable Agilex 5
>            operation in U-Boot.
>         2. Integration of cache coherency unit (CCU) initialization routine,
>            including CCU conguration in DT.
>         3. Clock, firewall (configured in DT), SMMU, low level initialization
>            specific to Agilex 5.
>         4. Integration of memory initialization routine, including DDR setup.
>
> This patch set has been tested on Agilex 5 devkit with QSPI boot (UBI/UBIFS)
> and RAM boot (TFTP & ARM DS debugger).
>
> Alif Zakuan Yuslaimi (1):
>   configs: socfpga: soc64: agilex5: Enable QSPI boot with UBI / UBIFS
>
> Tien Fong Chee (18):
>   arm: socfpga: agilex5: Add new system manager base addresses
>   arm: socfpga: Add support for agilex5 clock manager
>   linker: Add SPL linker script for SoC64 devices
>   arm: socfpga: agilex5: Add low level initialization
>   arm: socfpga: Add handoff data support for SoCFPGA Agilex5 device
>   arm: dts: agilex5: Add HPS cache coherency unit configuration settings
>   arm: dts: agilex5: Add firewall configure settings
>   arm: dts: agilex5: Enable XGMAC
>   sysreset:  Add reset support to SoCFPGA Agilex5 device
>   arm: socfpga: agilex5: Enable cache flush for system memory cache in
>     CCU
>   arm: socfpga: agilex5: Add SMMU initialization
>   arm: socfpga: agilex5: Update CPU info
>   arm: socfpga: Export board ID as U-Boot environment variable
>   configs: agilex5: Add configuration for malloc pool
>   arm: socfpga: smc: Add memory coherency support to mailbox command
>   arm: socfpga: agilex5: Add SPL for Agilex5 SoCFPGA
>   configs: socfpga: soc64: agilex5: Enable XGMAC
>   arm: socfpga: soc64: Add support for board_boot_order()
>
> Tingting Meng (1):
>   ddr: altera: Add DDR driver for Agilex5 series
>
>  MAINTAINERS                                   |   2 +
>  arch/arm/Kconfig                              |   1 +
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi      | 660 ++++++++++++++++++
>  arch/arm/dts/socfpga_agilex5.dtsi             |   7 +
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  33 +
>  arch/arm/mach-socfpga/Makefile                |   6 +
>  arch/arm/mach-socfpga/ccu_ncore3.c            |  64 ++
>  arch/arm/mach-socfpga/include/mach/firewall.h |  23 +-
>  .../mach-socfpga/include/mach/handoff_soc64.h |   4 +-
>  arch/arm/mach-socfpga/include/mach/misc.h     |   1 +
>  .../include/mach/reset_manager_soc64.h        |  12 +-
>  .../include/mach/system_manager_soc64.h       | 129 ++--
>  arch/arm/mach-socfpga/lowlevel_init_agilex5.S |  57 ++
>  arch/arm/mach-socfpga/misc.c                  |  24 +-
>  arch/arm/mach-socfpga/misc_soc64.c            |  12 +-
>  arch/arm/mach-socfpga/smc_api.c               |  13 +-
>  arch/arm/mach-socfpga/spl_agilex5.c           |  84 +++
>  arch/arm/mach-socfpga/spl_soc64.c             | 120 +++-
>  arch/arm/mach-socfpga/u-boot-spl-soc64.lds    |  80 +++
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c    |  10 +-
>  configs/socfpga_agilex5_defconfig             |   6 +
>  drivers/ddr/altera/Makefile                   |   1 +
>  drivers/ddr/altera/iossm_mailbox.c            | 613 ++++++++++++++++
>  drivers/ddr/altera/iossm_mailbox.h            | 186 +++++
>  drivers/ddr/altera/sdram_agilex5.c            | 377 ++++++++++
>  drivers/ddr/altera/sdram_soc64.c              |  78 ++-
>  drivers/ddr/altera/sdram_soc64.h              |  32 +-

Can we please put RAM drivers in drivers/ram ? Also, do make sure they
actually use UCLASS_RAM

>  drivers/sysreset/Kconfig                      |   7 +
>  drivers/sysreset/Makefile                     |   1 +
>  drivers/sysreset/sysreset_socfpga_agilex5.c   |  47 ++
>  include/configs/socfpga_soc64_common.h        |   5 +
>  31 files changed, 2605 insertions(+), 90 deletions(-)
>  create mode 100644 arch/arm/mach-socfpga/ccu_ncore3.c
>  create mode 100644 arch/arm/mach-socfpga/lowlevel_init_agilex5.S
>  create mode 100644 arch/arm/mach-socfpga/spl_agilex5.c
>  create mode 100644 arch/arm/mach-socfpga/u-boot-spl-soc64.lds
>  create mode 100644 drivers/ddr/altera/iossm_mailbox.c
>  create mode 100644 drivers/ddr/altera/iossm_mailbox.h
>  create mode 100644 drivers/ddr/altera/sdram_agilex5.c
>  create mode 100644 drivers/sysreset/sysreset_socfpga_agilex5.c
>
> --
> 2.25.1
>

Regards,
Simon
