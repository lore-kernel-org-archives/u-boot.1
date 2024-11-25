Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B2D3B7EF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A518F8961D;
	Mon, 25 Nov 2024 09:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3cdoel7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD19B89664; Mon, 25 Nov 2024 09:25:57 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4708961B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso5559057a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732523155; x=1733127955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r3HEzw0Tdm8E8mijqZgEOsaOjGQseIXH1gXkJ9DgLZA=;
 b=j3cdoel73S0Lp8HKFXBGckkLyjOfzyqwigmJtLWP1QF+PFD7nmhQPhYsqmHf3MGu9D
 d4wtlUIWU1Rn4pxU67Hmn6+kpWfOn1CSGwubEwL818o3unY6A9Hk+192ijJ10mMaQUVj
 34gmajnA/RIZWK5rgWRZRiwitWmYzfnINJVxCY6JfaHNwS8HV72bJkWfD42NWXi/0Pqp
 KT5cgWJlR3vjRf7FRbszwSvDwvGR0BJxbdbX5QbQ1c/Vffgwt3nLUmFjVgZKm4oWnx+Z
 6iceSoRoo+lcqwBNe37lDn6ORsl/mWSk/f/lc8bMqWabFCRIvyU+2Rty5Jw1tQpGdMv/
 TXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523155; x=1733127955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3HEzw0Tdm8E8mijqZgEOsaOjGQseIXH1gXkJ9DgLZA=;
 b=Exfu4g7xEg3M92G9thzFy3KUynmul6KPcC8Jl0qWllTBpubAVl7F6XuuqRat+2tqv3
 1hd8ryExmsj13VsOM3+Q5E8+pwsnBGe/Y0p7RnZleL3SApgdTofYA0Vtz3bT5DbOAl72
 jF2nBRgY7aBF+cQhIeLc4rjEZQ9OlQn7dyLMrdXac8GzOOSWvN6YxJVEuV6CJZKKx8VW
 7GeZLyYVBKyLM5ABXRBgqk/nx50j6lFpVMQ0N1lHlqhB99g0RtiIM0uzzMq4eT2xUzv0
 3wSezYyCJpaXfRrjRFpQWDGNeH6Y+Oeqo+tYWW8KJfTxGUKBq+/leUYeJt8zi8rPxJRm
 JdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHWo+nZMdp9h+/Qqj4liCMJllyaK5LpfA1sc8207HEgnSHSjCvc0FbmqpcdAW7pj26ImUsgpk=@lists.denx.de
X-Gm-Message-State: AOJu0YxKV+jWZkl4rBaGeV/4EIJn4vhaN4TwY6MMGZf9UY8NqqWqjn33
 gVxs0agoSPPHTEIWAdzCgBA1YUpI8QppZZGiKF6bm+FdwUSPPZ+6Em71CLNmeJJDt5I/bomFoHv
 YWhjr9BUDwpR5EZ3DWi6CQk/bOEM=
X-Gm-Gg: ASbGncu5G2bIdLASmCeOOXCrmpT7GQROuvcKQQfjJLPkftP550X+17Qs0f6u9k22C/E
 uybZbZ1wyxbnDxgNJKb6LCOMqC4iY9P8/
X-Google-Smtp-Source: AGHT+IHMrcnqEWQ102EEetTwcVuG37S1CCYZGLtQyl4qTHngkfoPSBg7nhn00ieiZgkwauUm/wWJBOeb4Dsz5HcElz8=
X-Received: by 2002:a17:907:31c5:b0:a99:89e9:a43d with SMTP id
 a640c23a62f3a-aa509d3fbd0mr1191418366b.39.1732523154579; Mon, 25 Nov 2024
 00:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 25 Nov 2024 13:55:38 +0530
Message-ID: <CANAwSgQ0ScgATSWHgaWPCuJFWEY-MspEDJaGHj9gwWcS2BKcew@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

Hi Hal Feng,

On Mon, 25 Nov 2024 at 06:11, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
> All the JH7110 based boards can use the DT from upstreaming linux kernel.
> The v1.3b board device tree is set as the default device tree. Support
> CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
> EEPROM information.
>
> Note:
> 1. Mars CM (lite) are missing upstream dts and so are detected but not
> supported in this series. Users of Mars CM and Mars CM Lite may stay with
> U-Boot v2024.10 until this is resolved.
>
> 2. Property values of network phy0/1 for all JH7110 based boards now
> follow the upstream dts.
>

Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand
> Changes since v5:
> - In patch 2, drop the override of rx-internal-delay-ps on phy0 and phy1.
> - In patch 5, drop "/delete-property/ motorcomm,tx-clk-10-inverted;" for
>   Mars network phy0.
> - In patch 8, rename fdt and conf based on the compatible identifier of
>   boards.
>
> Changes since v4:
> - Merge patch 2, 3, 5 into patch 1, ensuring git bisect works.
> - Add a new patch to sort the list of JH7110 imply statements.
> - Drop the reparent of clock JH7110_AONCLK_APB_FUNC in patch 4, which is
>   unnecessary and will cause errors in gmac0 initialization.
>
> Changes since v3:
> - Add detection for Milk-V Mars CM (lite) boards in patch 13.
>
> Changes since v2:
> - Drop patch 1, because the riscv of_upstream Makefile is created by Conor
>   in commit 239e4705099c.
> - Drop phy0 rx delay for milkv u-boot dtsi in patch 9.
> - Add a Fixes tag for patch 13.
> - In patch 14, the PCB version is only obtained when the product_id is
>   VF7110. Improve the commit messages.
>
> Changes since v1:
> - Drop patch 12.
> - Modify patch 11 and add three new patches to support
>   CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using the
>   EEPROM information.
>
> History:
> v5: https://lore.kernel.org/all/20241119020425.51989-1-hal.feng@starfivetech.com/
> v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivetech.com/
> v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivetech.com/
> v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
> v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/
>
> Hal Feng (11):
>   dts: starfive: Switch to using upstream DT
>   riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
>   pcie: starfive: Make the driver compatible with upstream DT
>   riscv: dts: jh7110: Move common code to the new
>     jh7110-common-u-boot.dtsi
>   riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
>   board: starfive: spl: Drop the unneeded DT modification code
>   configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
>   riscv: dts: jh7110: Support multiple DTBs in a Fit image
>   board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
>   board: starfive: spl: Support multiple DTBs for JH7110 based boards
>   riscv: cpu: jh7110: Sort the list of imply statements
>
>  arch/riscv/cpu/jh7110/Kconfig                 |  19 +-
>  arch/riscv/dts/Makefile                       |   1 -
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 198 +++++
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   7 +
>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
>  .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   6 +
>  .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
>  .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
>  arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
>  arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
>  board/starfive/visionfive2/spl.c              | 391 +--------
>  configs/starfive_visionfive2_defconfig        |   4 +-
>  drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
>  drivers/clk/starfive/clk-jh7110.c             |  44 +-
>  drivers/pci/pcie_starfive_jh7110.c            |  59 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
>  19 files changed, 358 insertions(+), 2135 deletions(-)
>  create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110.dtsi
>  delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>
>
> base-commit: 880fcc49eb40a78ed27ff575aa02034d7bd74e80
> --
> 2.43.2
>
