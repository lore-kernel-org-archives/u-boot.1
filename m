Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E5AE65D29
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 07:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F3189703;
	Fri, 22 Nov 2024 08:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVsWlAlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE6D897A0; Fri, 22 Nov 2024 08:55:55 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1310D8937E
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 08:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so19732021fa.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732262151; x=1732866951; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHj2Oo/7Yot0ZNiE+cQyoLjT5CGO6V5LfFM6zymDkWw=;
 b=EVsWlAlLZ7Pggz2xJ4qJzlV1gHRXECbfT3xCJLQUkIqpYyeeyBEMhEj1Yf+M0n9ioy
 g0IgNssr9+jppmHI874sbhhcAG6XrOhqeCX2L65EPczdMmbZLQhWmxW5arkPCbIYr+1s
 OR+RQzlC6N5bkcL7TNelku8jQhYE+VKJZIYix7XZlPgLBdGfsJN4U/3Q1XhK1xDT0o+9
 GOdZvbyS1HRzxzTct66z/wG9uotAFT8alz9gzShd+l3VsLL3DRTGWMbHO8TyrUYr3EWn
 OIdF2fGEmJEqsbTGCfWTc4hJ13XnVHvePjQJVPV+V4l2Ww7JksqPCKLtVfn9rLB4klC3
 E7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732262151; x=1732866951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHj2Oo/7Yot0ZNiE+cQyoLjT5CGO6V5LfFM6zymDkWw=;
 b=cVTDQHsoYzrSdsReKPjoYia8/5RCn5QYg7WMGldc+fDSVKfuYL6JxznQAV7ErfkaRi
 2uD8wUl3YNoalWrtLg20vXaRP2y+E9lznDV0IVsSCJuEf7ZXwh4GWkCspyt7MUEg+2Cj
 DSFHPxhdIjHm6OGMUizBWOZlmX0r10S7SbCGEhjJMLjq0WGRLlVyESflHFmkUrHFmkix
 Z31G3EPXC4v7NfgiV9nuuV5OJN2VNx8A0y6wyXWAXcJmQCqtP0LglUUfMTIhc1d8BZea
 d2f5/caq1pV8ONE5DG3ixlRf1LQD1nkdvHdsDu5oQQFe5tGW0GmKSeoHAxp0HCQt/fkB
 icig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQgCfLKSOJL6+8lAo0VX0KR4vtW1bV1PZF2lwybThSNowvsv1BtXK2wIKkc8cPl6bGDf3VUQk=@lists.denx.de
X-Gm-Message-State: AOJu0YzK8S0FThpuRP+PmKyl9iUrYa7UCqSBqTWNve3eihdsSG9ghh6W
 OANzK+dupHfV6hKcUvG+jMjLeYkaOPdm1CR8yp2cnqK0B6tFsIBAEaUfxciWA07jLno0UkKebtM
 7K35UaBEwfBUqFrIB5VoBHx5EISY=
X-Gm-Gg: ASbGncufqL+qDuGM7DK9WlikOM/ZReREPT9QisMQ08DXw5BhN2BzMwPwl0wHnOctIKM
 OVeHv8eP66D7L++XCIFcXPcgPv7Wnf6w303SjbihLmLN5APe/0dHmlxGKlGgmtIPvGA==
X-Google-Smtp-Source: AGHT+IEDoDOUnPz7TeihDINpR+NqyfZDCLdRDlHyHcaxNnbAYg1FV3vvKXZ2EKftTqZIICdInBVCxRXbWH9Uliyz37s=
X-Received: by 2002:a05:651c:b0f:b0:2fb:65c8:b4ae with SMTP id
 38308e7fff4ca-2ffa71a7b98mr8420201fa.31.1732262150959; Thu, 21 Nov 2024
 23:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 21 Nov 2024 23:55:39 -0800
Message-ID: <CANV2PTMsbFw5k4cBt2QOKmYEm=WOdUhHPOYxbmgN6OzThr_bKA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Support OF_UPSTREAM for StarFive JH7110
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 18, 2024 at 6:05=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
> All the JH7110 based boards can use the DT from upstreaming linux kernel.
> The v1.3b board device tree is set as the default device tree. Support
> CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
> EEPROM information.
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
> v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivet=
ech.com/
> v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivet=
ech.com/
> v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivet=
ech.com/
> v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfive=
tech.com/
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
>  arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  10 +
>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
>  .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
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
>  19 files changed, 369 insertions(+), 2135 deletions(-)
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
> base-commit: 0e6432e19f9c812b4986ca7fd8e6db9fd2c199d3
> --
> 2.43.2
>

A temporary workaround before testing is first applied for unrelated
designware mmc driver fault on 4GB memory address (applies to
4GB-and-larger DRAM boards):

+++ b/lib/lmb.c
@@ -615,6 +615,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 void lmb_add_memory(void)
 {
        int i;
+       phys_addr_t top;
        phys_size_t size;
        u64 ram_top =3D gd->ram_top;
        struct bd_info *bd =3D gd->bd;
@@ -628,6 +629,7 @@ void lmb_add_memory(void)

        for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
                size =3D bd->bi_dram[i].size;
+               top =3D bd->bi_dram[i].start + size;
                if (size) {
                        lmb_add(bd->bi_dram[i].start, size);

@@ -639,6 +641,9 @@ void lmb_add_memory(void)
                        if (bd->bi_dram[i].start >=3D ram_top)
                                lmb_reserve_flags(bd->bi_dram[i].start, siz=
e,
                                                  LMB_NOOVERWRITE);
+                       else if (top >=3D ram_top)
+                               lmb_reserve_flags(ram_top, top - ram_top,
+                                                 LMB_NOOVERWRITE);
                }
        }
 }

Result of testing is good Star64 (eMMC, SD Card, PCIe NVMe); bad
Star64 (network bottom port) as expected until better delay values in
Linux 6.12 resolve this when that dts sync will happen; good Mars CM
Lite network and PCIe NVMe; bad Mars CM Lite fails MMC (SD Card) as
expected not having upstream dts representation here so missing the
necessary GPIO configuration.

Please add a mention in the cover letter making it clear that Mars CM
(lite) are missing upstream dts and so are detected but not supported
in this series. Users of Mars CM and Mars CM Lite may stay with U-Boot
v2024.10 until this is resolved.

I will soon send a series to Linux kernel mailing list adding the Mars
CM and Mars CM Lite initial devicetree.

Tested-by: E Shattow <lucent@gmail.com>
