Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294F4CE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96A788FDA;
	Mon, 30 Sep 2024 19:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="INCwg6Qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A8588FD6; Mon, 30 Sep 2024 19:55:41 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BE388C7D
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 19:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2AE6B3F1E0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1727718939;
 bh=jOO3r+8ylySkaOuLBXOU7TqqV4ID84EpM1nvfBzX6QY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=INCwg6QenbWIYOB+ubR3rZS4WhHSORKY8HYCemyodPigw17e6a0dHrci05wDSCmSN
 5EpjjsDqQIxoigjIvAyeHNG+079MdgGWiWrtWN9cAFF1513yrUZQi+4yBEPSK4PooN
 0/PDB4F6bEYeJ3JnD7z+K7LgLAT10019gs85mJSIF4aJmKm5PhmkJhDYoFc56BF6TK
 S3h5+PDrV2cMjaPTu+vGuUVzrLwvwI39vuqEsBnjbHTdHiEn4Mnwdu+5lchUaqrhNq
 PiqZ8wX4alExJ27tmdF3qmOiNDdvY73IMS/ByyAFppYk91ZKi3HiUWPiCrVqnOqSxE
 FVDbVhh8YGy+Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42caf073db8so38552535e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 10:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727718939; x=1728323739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOO3r+8ylySkaOuLBXOU7TqqV4ID84EpM1nvfBzX6QY=;
 b=mD78UrjaSedCtGbWdYyar/HNXindq7uHN7diVqxmzVA4tpF2hesJtWY0mjlOB1roRf
 5kiZF7a7rmiq0iGbcNz6fiOfglqOpSwQzGljAFxSbNfrLS8e9Z998d12Zj7lOvFKfR/I
 dzWdcNVHzZ17rf1TCOzN3uref+WD2uWgG6ckuhjXSH+7cuWQzWkp8XIzlgsT+I3a8mMK
 jJ0rrZvujF0Um5FtcNW4VBuohqlUYqmVkK6l6e3Y3H3mIrbATCTfVrg2yNyGaU352BO3
 ywhcNNYvMbhzeoRLeQSP0A7V2ReSfBVjm22f4y5/WIRVKSUK/qlm9wmYnZ5onhPCkASZ
 +gCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFTIVNMixGH3IBECQ7YLYLU6Z75CczaUclugkfcOR4ew/qyVfdIsP2se2g12tDBBfnx4Tz8c8=@lists.denx.de
X-Gm-Message-State: AOJu0YySkzYBhbEXTNtylnbR4oz2AsOAjv9ZmwFJkra8opc1kNvgeJAE
 MV+Q4myNl0noPOrsdCb7YxrTpqARu3WE96kDtfICckJDOn2o2AkbK5IEEC6Nx+inLRFCX4s50bQ
 eqThqygi86S9ZJXti1QLdtA0Tmuzo4scvJiHMTRBCKChkojEJ9RLDcS1wwL6ZahmKMc4=
X-Received: by 2002:a05:600c:3b8c:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f584335f0mr100509045e9.14.1727718938685; 
 Mon, 30 Sep 2024 10:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR+JsYdHUOpsygwNHBItVWw6IcbbRTNTCjQDYE7hoOqG+YFwllHh6SgB3krmYwkUf8EQUFDA==
X-Received: by 2002:a05:600c:3b8c:b0:42c:be90:fa1b with SMTP id
 5b1f17b1804b1-42f584335f0mr100508815e9.14.1727718938260; 
 Mon, 30 Sep 2024 10:55:38 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dd2e67sm109795785e9.10.2024.09.30.10.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 10:55:37 -0700 (PDT)
Message-ID: <4632a46c-a355-4c2a-8588-6e911b296e3d@canonical.com>
Date: Mon, 30 Sep 2024 19:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
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

On 30.09.24 17:59, Hal Feng wrote:
> This patchset add OF_STREAM support for StarFive JH7110 based boards.
> All the JH7110 based boards can use the DT from upstreaming linux kernel.
> The v1.3b board device tree is set as the default device tree.
> 
> This patchset should be applied after the DT from dts/upstream/ updating
> to the latest version.

Hello Hal,

Thanks a lot for making the move to upstream device-trees for JH7110 
based boards.

With the current patchset you suggest to specify the relevant 
device-tree when building, e.g.

make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin \
DEVICE_TREE=starfive/jh7110-milkv-mars

Another approach would be to build all device-trees into U-Boot and use 
the EEPROM information to select the correct one at runtime.

This approach is selected by Wandboard defconfig and other boards by 
specifying CONFIG_MULTI_DTB_FIT and CONFIG_OF_LIST. The choice of the 
device-tree is made in board_fit_config_name_match().

The advantage from the standpoint of a Linux distro would be that one 
distro image can be provided that will run on all JH7110 boards.

Best regards

Heinrich


> 
> Hal Feng (12):
>    Makefile: Add OF_UPSTREAM Makefile for RISC-V
>    dts: starfive: Switch to using upstream DT
>    riscv: dts: jh7110: Drop redundant devicetree files
>    dt-bindings: Remove StarFive JH7110 clock and reset definitions
>    riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
>    clk: starfive: jh7110: Sync clock definitions with upstream
>      dt-bindings
>    pcie: starfive: Make the driver compatible with upstream DT
>    riscv: dts: jh7110: Move common code to the new
>      jh7110-common-u-boot.dtsi
>    riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
>    board: starfive: spl: Drop the unneeded DT modification code
>    configs: visionfive2: Add OF_LIST for JH7110 based board DT
>    doc: board: starfive: Update the building guide
> 
>   arch/riscv/cpu/jh7110/Kconfig                 |   1 +
>   arch/riscv/dts/Makefile                       |   1 -
>   ...-u-boot.dtsi => jh7110-common-u-boot.dtsi} |  41 +-
>   arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  11 +
>   .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
>   ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
>   ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
>   .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
>   .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
>   arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
>   arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
>   board/starfive/visionfive2/spl.c              | 358 --------
>   configs/starfive_visionfive2_defconfig        |   3 +-
>   doc/board/starfive/milk-v_mars.rst            |   2 +-
>   doc/board/starfive/milk-v_mars_cm.rst         |   2 +-
>   doc/board/starfive/pine64_star64.rst          |   2 +-
>   doc/board/starfive/visionfive2.rst            |  11 +-
>   drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
>   drivers/clk/starfive/clk-jh7110.c             |  44 +-
>   drivers/pci/pcie_starfive_jh7110.c            |  59 +-
>   dts/upstream/src/riscv/Makefile               |  14 +
>   .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
>   .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
>   23 files changed, 194 insertions(+), 2016 deletions(-)
>   rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-common-u-boot.dtsi} (56%)
>   create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>   create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>   create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>   create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>   delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
>   delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
>   delete mode 100644 arch/riscv/dts/jh7110.dtsi
>   create mode 100644 dts/upstream/src/riscv/Makefile
>   delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>   delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
> 
> 
> base-commit: 56b47b8b6a09c777e74fe6c52512c832691169aa

