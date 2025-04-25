Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03966C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 18:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F7882977;
	Fri, 25 Apr 2025 20:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gcMPW4DW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A9182A27; Fri, 25 Apr 2025 20:58:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8F782958
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 20:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C6AF3FE56
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745607534;
 bh=1+m/4ggT4CpN4gTQoXta75xtd//iejSb2ezewrxDe54=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=gcMPW4DWBrx4sWyMrBONd+GWToXwWC0boX+EW1n/f10b1mwXoc9/yi7EjUFaqrESf
 4VLbE4McVPnpO2qKVXv5OpkNinsh3ewlTEt/lD9V0KtyGGi3BCVFY15r9PxLWNKpwX
 Dgy+DoouflGwY+5WBXbgzhkFNwi7+kTBju2nwU2km8J1nXbZosi834QkAUshF+D8rn
 UGNO6ptSpPuKCIIKKOULECWsGEFprOJ6Ao50DK91MLdDlbtPeHNRvxsfyAZ7S2dsr5
 QMj2tnbKQxqEe9N0R7isGSHw0zpAdvCkwmwdWUHedihG0H3R+7Y6wY0iwtFKnM0Qya
 eqqgOfaCFRehg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so931819f8f.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745607533; x=1746212333;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1+m/4ggT4CpN4gTQoXta75xtd//iejSb2ezewrxDe54=;
 b=hnOB1NgqPiM6UF/cGxBpAv4gLK3E6PFFc5dz0Aj1JHL9MWRFnqBXct2Gq75wrWt3d5
 naPyJQYWcDUFvY2fTVQ+H2tPiFnQ0cnwkZfiUBl4uc0wjUE1Gq68PuyrAJrom8B0HXld
 VrMhIlfaWqwICFxihMY9rRzLPN9Oy62aG4wvcK84pTOls1lPNp2SAUbyAJHwydcf54vl
 h+21ypH+HemTGUbEz3N36oFPAyg8J3qksbEcGo+HRoe/K6De6UBte/8BFKjO5RXdVX7J
 5T0a673NCHUuxnjwJBpg1ClPZxtPiT0cGJXHI/YC/LRl3agNLtqoCyv5ORE6OY7Vp3n8
 hfZw==
X-Gm-Message-State: AOJu0YzarcI3xZUl5xXmxZNcC7V9SLf06eAKsHKkMlSkJlRLOoMbjwm3
 oef8+h2SC9nDHwc2VJ8YTqMmRYzNGT+/TyUiBemdOL1lCxo1zmSqv5hn4gSz2ndA1xV+XjKnsqk
 iL3k4KTe1B7UkMiWRl7iYo7LC0BUqC+yIFwceB4yPLxF1Gb9DUNKNC5JqZrGazPctGik=
X-Gm-Gg: ASbGncsscdpKf0QhigxXB8xuKX8UjVlPTqQ3wAR1lcBu1hCAiCMic/HDEWlLcvVw8Yw
 p2c7YoWYtUtL9kcDoGFD7R1qCUxgt/o43ZOVrGInwIod+YrNa1dqF9Zg/a+KAZH3EHD091ssnNt
 h7Su5zPtN01XYGII0mePkFTcOVpkcKzy1U5P51aut59DshQC0cdNuAiUkwPOd7PUTo2Kc8W9lPS
 ef4bxTOBFfZUXmAL+9sKR0Pbsb6dOlHz3Gp7xXKy17ZfZm0MoFz+opVzpusyU1LRIDyoKVeai+O
 HemqN7xrd37+IMlwH3tFViGzc9+vEbN/kXAvERuPax7HVTFFOtey7+hm7Op9usH/iQUGEadiEyJ
 WoA==
X-Received: by 2002:a05:6000:290b:b0:391:2df9:772d with SMTP id
 ffacd0b85a97d-3a07aa64fe7mr367485f8f.13.1745607533479; 
 Fri, 25 Apr 2025 11:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbG6aN0OnQpiwzJnPQ8qEohMG5GTW0dX1cQbLpDb4HARa3ziAtMGStdo+McjfNvYYO/ntezw==
X-Received: by 2002:a05:6000:290b:b0:391:2df9:772d with SMTP id
 ffacd0b85a97d-3a07aa64fe7mr367474f8f.13.1745607533115; 
 Fri, 25 Apr 2025 11:58:53 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:31a3:6e7e:b578:400a:f063?
 ([2a02:3035:6e0:31a3:6e7e:b578:400a:f063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8da58sm3159979f8f.15.2025.04.25.11.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 11:58:52 -0700 (PDT)
Message-ID: <feeb0d44-78d9-4652-9fd3-63c130a22637@canonical.com>
Date: Fri, 25 Apr 2025 20:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2025-07-rc1-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

I have added some board related patches to the pull-request:

The patches for supporting the DeepComputing FML13V01 via 
starfive_visionfive2_defconfig were positively reviewed by four 
reviewers including the StarFive maintainer but I did not see any 
pull-request for RISC-V.

Enabling unit tests on big-endian Malta boards and raising the number of 
supported DRAM banks on QEMU RISC-V are more on the trivial side but 
were also reviewed by the respective maintainers.


The following changes since commit 9d3f1ebaf8751f0287b5d02158cc706435f8fb19:

   tools/make_pip: Use venv when invoking pip (2025-04-24 16:30:37 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2025-07-rc1-3

for you to fetch changes up to 0ded46384952ab74eb7dd54515a3e23bcbb9ca88:

   configs: add UNIT_TESTS to big-endian Malta boards (2025-04-25 
17:33:20 +0200)

----------------------------------------------------------------
Pull request efi-2025-07-rc1-3

Documentation:

* add documentation for the DeepComputing FML13V01
* fix typos

UEFI:

* build with HII configuration protocol
* print image load address in StartImage

Boards:

* qemu-riscv raise CONFIG_NR_DRAM_BANKS
* add support for the DeepComputing FML13V01 board via
   starfive_visionfive2_defconfig
* add UNIT_TESTS to big-endian Malta boards

----------------------------------------------------------------
Aristo Chen (4):
       doc: remove duplicated "commands"
       doc: arch: arm64: fix typos
       doc: fix typo commnad
       doc: fix typo 'to'

Heinrich Schuchardt (12):
       efi_loader: build with HII configuration protocol
       efi_loader: print image load address in StartImage
       configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
       configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
       riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
       board: starfive: DeepComputing FML13V01 fdt selection
       board: starfive: spl: support DeepComputing FML13V01
       doc: add DeepComputing FML13V01 documentation
       doc: starfive: use consistent formatting
       doc: starfive: use jh7110_common.rst
       doc: jh7110: describe debug UART
       configs: add UNIT_TESTS to big-endian Malta boards

  .../dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi  |   7 ++
  board/starfive/visionfive2/spl.c                   |   5 +-
  board/starfive/visionfive2/starfive_visionfive2.c  |   6 +-
  configs/malta64_defconfig                          |   1 +
  configs/malta_defconfig                            |   1 +
  configs/qemu-riscv32_defconfig                     |   1 -
  configs/qemu-riscv32_smode_defconfig               |   1 -
  configs/qemu-riscv32_spl_defconfig                 |   1 -
  configs/qemu-riscv64_defconfig                     |   1 -
  configs/qemu-riscv64_smode_defconfig               |   1 -
  configs/qemu-riscv64_spl_defconfig                 |   1 -
  configs/starfive_visionfive2_defconfig             |   2 +-
  doc/arch/arm64.rst                                 |   4 +-
  doc/board/starfive/deepcomputing_fml13v01.rst      |  80 ++++++++++++++++
  doc/board/starfive/index.rst                       |   1 +
  doc/board/starfive/jh7110_common.rst               | 103 
+++++++++++++++++++++
  doc/board/starfive/milk-v_mars.rst                 |  18 +---
  doc/board/starfive/pine64_star64.rst               |  26 +-----
  doc/board/starfive/visionfive2.rst                 |  47 +---------
  doc/usage/blkmap.rst                               |   2 +-
  doc/usage/cmd/md.rst                               |   2 +-
  doc/usage/cmd/part.rst                             |   2 +-
  lib/efi_loader/Makefile                            |   2 +-
  lib/efi_loader/efi_boottime.c                      |   7 +-
  lib/efi_loader/efi_hii_config.c                    |   4 -
  lib/efi_loader/efi_root_node.c                     |   3 +
  26 files changed, 230 insertions(+), 99 deletions(-)
  create mode 100644 
arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
  create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
  create mode 100644 doc/board/starfive/jh7110_common.rst

