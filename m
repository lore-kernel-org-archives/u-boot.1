Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD70E77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 01:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D15788E2B;
	Mon,  9 Dec 2024 02:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YR+eBVI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2EF893E8; Sun,  8 Dec 2024 23:10:15 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C410893B4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3003e203acaso13918601fa.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733695811; x=1734300611; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIa7ETMnohITq7Jrx5RjX71qlJsIrY/tZh1gFOMDv/0=;
 b=YR+eBVI9XcM3tkVgbnpA2aLKR0IV2G/hzTUvYLZPg2KiWx7jOOxqBkPlPfN0MmFxjn
 QFQB1siZnK1g1ANHZeFapsO+aVp+xmLJxUOI8jBk4w6gXNTaDQrI5QxMSn8lkMxP0R07
 Lu6Z1p4Fn2FNQb/Q+sMhPa8Kc4WrtBjlt833jEmN/7NoA3pdKZPJKgF5vx316spMkOPK
 CrV8vrSljwBpLK7mnId2GWS8w4mo/R48hec6p3j5A5wnTQeBhfaY4N4Z81fqIsRl5k9c
 bPvselWY6oriD24FjsY+F6EG4qjWykwTPuzO63auLtC/tFpUNkS+iSC/x/c20kbS0sxa
 ypLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733695811; x=1734300611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIa7ETMnohITq7Jrx5RjX71qlJsIrY/tZh1gFOMDv/0=;
 b=tufBMEaJETaFx2InCrswf1J+cphvgenwR1b2pZK6Flpvj8IJLzQ3TMBy2DgIs26KoD
 AhD4P2a/rPsAdEwa2KAdlwTrNqgE2zCcBSUsrgimlAOzRBiFn8LSSus40dhbwFiZSiFH
 WqHnW1hk/aYuoIobf8wLPN7i+35WkLQqLFyCUupWguN3mzabTPs067twJNFgp9w60xEb
 ozZyp4PVmd2xgV1Y5EuHTYrb/gSyzTOqMh5kUrksLqHCoq1bw2VxD2T67CsHBMIpETT2
 5AEHAxZLn9BRXeVV/nWOlzsAoBb21Kve9YkLMqmd0TYdoDafi4a/q1nGQzHPDVqryF33
 I+PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkurzj7tkQKeJPL2C3c+kkrOBq8AiPCK9L40ZJnZ9abewiDtfg2X5nM/ZxEp9KPfGgkm0DzmY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3SgJ95aOJglPz+YBad2URUlMigTYb8gj2kn+ygwdTttlEZRlV
 ZORhdA39LG/yMY8A9tSPJOk7dQE60g7OpsApmF5tQ88OuesGSNCmkY9xIWrUY8X1keK8Fx1TAf/
 SpP2MKOx7di1b0KlnJ0HHH5d6zQU=
X-Gm-Gg: ASbGncuwxFRs+I1/aB/MFl0kvYgR7AvihEDx9GdxnHE9KJBFDTpAnInIHj3mGkBAWPI
 nd+Et4DJrSZo36ujWIEcSB8fvsodvdXfViNwX57B9i7TmI5Nqvf+LaEjZH5pjALTt6g==
X-Google-Smtp-Source: AGHT+IFjwLALmDb1SUUjyaKN5ohlIvvk58T933YofwuvYe+fG4bWemgTq48NWvP+6BUXQ21kH5sJjnGtQPok2ffmbmc=
X-Received: by 2002:a2e:9fc8:0:b0:302:1d7a:e09 with SMTP id
 38308e7fff4ca-3021d7a114bmr9232271fa.31.1733695811027; Sun, 08 Dec 2024
 14:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 8 Dec 2024 14:09:59 -0800
Message-ID: <CANV2PTPEmR11GmsSbS=o7MJtvkgYo+99FLzYeo2dFXoOxbXwnA@mail.gmail.com>
Subject: Re: [PATCH v8 00/12] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 H Bell <dmoo_dv@protonmail.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Dec 2024 02:00:16 +0100
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

Hi Hal, I think this series is now ready for merge to -next

On Sun, Dec 8, 2024 at 1:21=E2=80=AFAM Hal Feng <hal.feng@starfivetech.com>=
 wrote:
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
> 2. Property values of node phy0/1, gmac0/1, stmmac_axi_setup for all
> JH7110 based boards now follow the upstream dts.
>
> 3. Set "cdns,read-delay =3D <2>" for qspi flash@0 and this setting will b=
e
> synced to Linux later.
>
> Changes since v7:
> - In patch 2, drop "spi-max-frequency" property of qspi, set

Patch 2 adds (not drops) "spi-max-frequency" to 100MHz in co-operation with=
...

>   "cdns,read-delay =3D <2>" for flash@0.

... this change of read-delay =3D 2 cycles. The commit messages are not
affected and the code is correct. For anyone in future reading this
cover letter, the intention is to drop both of these properties from
the u-boot specific dtsi after resolving upstream in Linux devicetree.

>   Drop &stmmac_axi_setup &gmac0 &gmac1 property overrides.
>   Drop the redundant &S7_0 { status =3D "okay"; }.
>
> Changes since v6:
> - Drop the "snps,dw-mshc" override of compatible in patch 2, then add
>   "starfive,jh7110-mmc" compatible in mmc driver to match upstream DT.
> - Delete newline at end of Mars DT file in patch 5.
> - Sort OF_LIST in patch 7.
> - Sort items of images and configurations in patch 8.
>
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
> - Drop patch 1, because the riscv of_upstream Makefile is created by Cono=
r
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
> v7: https://lore.kernel.org/all/20241203030430.26089-1-hal.feng@starfivet=
ech.com/
> v6: https://lore.kernel.org/all/20241125003205.75327-1-hal.feng@starfivet=
ech.com/
> v5: https://lore.kernel.org/all/20241119020425.51989-1-hal.feng@starfivet=
ech.com/
> v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivet=
ech.com/
> v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivet=
ech.com/
> v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivet=
ech.com/
> v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfive=
tech.com/
>
> Hal Feng (12):
>   dts: starfive: Switch to using upstream DT
>   riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
>   mmc: dw_mmc: Add "starfive,jh7110-mmc" compatible to match upstream DT
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
>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 195 +++++
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |   6 +
>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
>  .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |   6 +
>  .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
>  .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
>  arch/riscv/dts/jh7110-u-boot.dtsi             |  27 +-
>  arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
>  board/starfive/visionfive2/spl.c              | 391 +--------
>  configs/starfive_visionfive2_defconfig        |   4 +-
>  drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
>  drivers/clk/starfive/clk-jh7110.c             |  44 +-
>  drivers/mmc/snps_dw_mmc.c                     |   1 +
>  drivers/pci/pcie_starfive_jh7110.c            |  59 +-
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
>  20 files changed, 342 insertions(+), 2139 deletions(-)
>  create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dt=
si
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-b=
oot.dtsi
>  create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-b=
oot.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
>  delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
>  delete mode 100644 arch/riscv/dts/jh7110.dtsi
>  delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>  delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>
>
> base-commit: 45f05f681224d88d1b170063001b59edc8fc24cf
> --
> 2.43.2
>

If no further code or commit message corrections are requested, then
let's merge this series to -next

-E Shattow
