Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9B2C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEDB8808D;
	Wed, 28 Feb 2024 12:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DvgsIwaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4C187F73; Wed, 28 Feb 2024 06:40:45 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A6987E88
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 06:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-472591ddc25so245109137.1
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 21:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709098840; x=1709703640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dVoBVaXMQikdO3CjG8xzQHYvno7UrKPpcaQXc4oChHg=;
 b=DvgsIwaWsOf+/aVEhZC5d/prLnaCTw//UkOfxj/k8O2+c5KwCRJbkZ33xNhWNUyqoq
 zFgm15KeRyCNaHn7tQDjPasEdS3jWKUyJ3FLCDJ13MqgeQUvOWg2S2cJmHQFxnm3eIV4
 sydjFGxeLNtcLIDiRtXMdUwj4/OlfDfuPjguZY4A+r1EM6W82xjlkXbihzrqpmbHz3S3
 gDJqMdrVN334uT/remSbbfF4bkv1lxSy/c8FEroidg9Jrdcu35UsZaqHrnq+4iPk//cr
 IDfljHEaV4GHiaZ6e4i/fbuyCwwPKy+jrXlaqXX0D/Da8exyA+rXXqDlNelbZB/env4n
 tHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709098840; x=1709703640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVoBVaXMQikdO3CjG8xzQHYvno7UrKPpcaQXc4oChHg=;
 b=fuyNHsEX90fzyi0M8qhlwBumGbABNggZKApJkvy8TnnwS2Kv8cb35GmhDgwUQAnCJ4
 cJ3WusajxmST8CX+KpKy9ZX+YobRASb6LNSNyEb0jsA/d/9DJh2/9SsBbOUnTq1p7NsI
 4QnbE4+sV+lnNpYlLROSGV54Pb3J0Z87BrCYG0sGitCBhMK7rfcWBvLszV2ZRgHVV8t0
 6dH2bar6UCw99tewMBD2QLEtl1si9XJGCTZEIWXghgTpTowF7GPZm5fIo5qeWkD79E8V
 AJDy9yty3wNswdbAtIXEK7hehFWRV4s1duVui/6zoWgtcOpIbVVk8GIdOmFuUgYfjEqR
 yLVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAxzFVby75zms5PVEJHBsixFtJnn48yQ6aF5A7uefb32FRUubiMcieNv4qmXSf4RTg7cvU+yytCB1i+8R1v3A3ccq86Q==
X-Gm-Message-State: AOJu0YznC2TC3Fp5aNlQMGS3IekShqP7WZ/sfBUyTRp9pnB8UK/SomZD
 jlBzH4Ohc+Of5Bxqsrzk2VYBfcBdFFH/3IW0cDQ8bp6zhd+IrVnbXhyNsnbHgvpFSV25EtsIU7r
 d+/ztb38y2G6vrno9RigmF+apt8Piy3C+QESNcw==
X-Google-Smtp-Source: AGHT+IEzqZDoYeEf7Vm4s13GYEthn3YHdTbLMw45vqhXZGmg70pJWESKuWnR1HeT8Szn+lTRMADWwllX/o12lF/SBmQ=
X-Received: by 2002:a05:6102:3591:b0:472:623b:75ba with SMTP id
 h17-20020a056102359100b00472623b75bamr1465603vsu.2.1709098840028; Tue, 27 Feb
 2024 21:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20240223202153.3756094-1-a-nandan@ti.com>
 <20240223202153.3756094-13-a-nandan@ti.com>
 <0498255bedaef533afb71d852fe426a0d8a7d80b.camel@toradex.com>
In-Reply-To: <0498255bedaef533afb71d852fe426a0d8a7d80b.camel@toradex.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 28 Feb 2024 11:10:28 +0530
Message-ID: <CAFA6WYPWpat4MVdFG8w9O8ibnV7j87n+2KocdNWkTXimLcZm5A@mail.gmail.com>
Subject: Re: [PATCH v10 12/15] arm: dts: Introduce am69-sk u-boot dts files
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "seanga2@gmail.com" <seanga2@gmail.com>,
 "hnagalla@ti.com" <hnagalla@ti.com>, 
 "rogerq@kernel.org" <rogerq@kernel.org>, "afd@ti.com" <afd@ti.com>, 
 "christianshewitt@gmail.com" <christianshewitt@gmail.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>, 
 "ralph.siemsen@linaro.org" <ralph.siemsen@linaro.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>, 
 "j-choudhary@ti.com" <j-choudhary@ti.com>, 
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "naoki@radxa.com" <naoki@radxa.com>, 
 "a-nandan@ti.com" <a-nandan@ti.com>, "bb@ti.com" <bb@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>, 
 "clamor95@gmail.com" <clamor95@gmail.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "n-jain1@ti.com" <n-jain1@ti.com>, "b-kapoor@ti.com" <b-kapoor@ti.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "n-francis@ti.com" <n-francis@ti.com>, 
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>, 
 "mr.bossman075@gmail.com" <mr.bossman075@gmail.com>,
 "marex@denx.de" <marex@denx.de>, 
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "lukma@denx.de" <lukma@denx.de>, 
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "nm@ti.com" <nm@ti.com>, 
 "j-humphreys@ti.com" <j-humphreys@ti.com>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, 
 "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>, 
 "cnsztl@gmail.com" <cnsztl@gmail.com>, 
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Feb 2024 12:49:49 +0100
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

On Tue, 27 Feb 2024 at 21:49, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Apurva
>
> On Sat, 2024-02-24 at 01:51 +0530, Apurva Nandan wrote:
> > From: Dasnavis Sabiya <sabiya.d@ti.com>
> >
> > Introduce the base dts files needed for u-boot or to augment the linux
> > dtbs for use in the u-boot-spl and u-boot binaries.
> >
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >  arch/arm/dts/Makefile               |   3 +-
> >  arch/arm/dts/k3-am69-r5-sk.dts      | 106 ++++++++++++++++++++++++++++
> >  arch/arm/dts/k3-am69-sk-u-boot.dtsi |  54 ++++++++++++++
> >  board/ti/j784s4/MAINTAINERS         |   6 ++
> >  4 files changed, 168 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
> >  create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index e484112dd7c..e3a47d055b0 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -1413,7 +1413,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
> >                              k3-j721s2-common-proc-board.dtb\
> >                              k3-j721s2-r5-common-proc-board.dtb
> >
> > -dtb-$(CONFIG_SOC_K3_J784S4) += k3-j784s4-r5-evm.dtb
> > +dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-r5-sk.dtb \
> > +                            k3-j784s4-r5-evm.dtb
> >
> >  dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
> >                             k3-am642-r5-evm.dtb \
> > diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
> > new file mode 100644
> > index 00000000000..f177f563527
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-am69-r5-sk.dts
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "k3-am69-sk.dts"
> > +#include "k3-j784s4-ddr-evm-lp4-4266.dtsi"
> > +#include "k3-j784s4-ddr.dtsi"
> > +#include "k3-am69-sk-u-boot.dtsi"
> > +
> > +/ {
> > +     chosen {
> > +             tick-timer = &mcu_timer0;
> > +     };
> > +
> > +     aliases {
> > +             remoteproc0 = &sysctrler;
> > +             remoteproc1 = &a72_0;
> > +     };
> > +
> > +     a72_0: a72@0 {
> > +             compatible = "ti,am654-rproc";
> > +             reg = <0x0 0x00a90000 0x0 0x10>;
> > +             power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> > +                             <&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> > +             resets = <&k3_reset 202 0>;
> > +             clocks = <&k3_clks 61 0>;
> > +             assigned-clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> > +             assigned-clock-parents = <&k3_clks 61 2>;
> > +             assigned-clock-rates = <200000000>, <2000000000>;
> > +             ti,sci = <&sms>;
> > +             ti,sci-proc-id = <32>;
> > +             ti,sci-host-id = <10>;
> > +             bootph-pre-ram;
> > +     };
> > +
> > +     dm_tifs: dm-tifs {
> > +             compatible = "ti,j721e-dm-sci";
> > +             ti,host-id = <3>;
> > +             ti,secure-host;
> > +             mbox-names = "rx", "tx";
> > +             mboxes= <&secure_proxy_mcu 21>, <&secure_proxy_mcu 23>;
> > +             bootph-pre-ram;
> > +     };
> > +};
> > +
> > +&mcu_timer0 {
> > +     status = "okay";
> > +     clock-frequency = <250000000>;
> > +     bootph-pre-ram;
> > +};
> > +
> > +&secure_proxy_sa3 {
> > +     status = "okay";
> > +     bootph-pre-ram;
> > +};
> > +
> > +&secure_proxy_mcu {
> > +     status = "okay";
> > +     bootph-pre-ram;
> > +};
> > +
> > +&cbass_mcu_wakeup {
> > +     sysctrler: sysctrler {
> > +             compatible = "ti,am654-system-controller";
> > +             mboxes= <&secure_proxy_mcu 4>,
> > +                     <&secure_proxy_mcu 5>,
> > +                     <&secure_proxy_sa3 5>;
> > +             mbox-names = "tx", "rx", "boot_notify";
> > +             bootph-pre-ram;
> > +     };
> > +};
> > +
> > +&sms {
> > +     mboxes= <&secure_proxy_mcu 8>, <&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> > +     mbox-names = "tx", "rx", "notify";
> > +     ti,host-id = <4>;
> > +     ti,secure-host;
> > +     bootph-pre-ram;
> > +};
> > +
> > +/* WKUP UART0 is used for DM firmware logs */
> > +&wkup_uart0 {
> > +     bootph-pre-ram;
> > +     status = "okay";
> > +};
> > +
> > +&ospi0 {
> > +     reg = <0x0 0x47040000 0x0 0x100>,
> > +           <0x0 0x50000000 0x0 0x8000000>;
> > +};
> > +
> > +&ospi1 {
> > +     reg = <0x0 0x47050000 0x0 0x100>,
> > +           <0x0 0x58000000 0x0 0x8000000>;
> > +};
> > +
> > +&mcu_ringacc {
> > +     ti,sci = <&dm_tifs>;
> > +};
> > +
> > +&mcu_udmap {
> > +     ti,sci = <&dm_tifs>;
> > +};
> > diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..bed330e6d4e
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#include "k3-j784s4-binman.dtsi"
> > +
> > +/ {
> > +     memory@80000000 {
> > +             bootph-all;
> > +     };
> > +};
> > +
> > +&mcu_udmap {
> > +     reg =   <0x0 0x285c0000 0x0 0x100>,
> > +             <0x0 0x284c0000 0x0 0x4000>,
> > +             <0x0 0x2a800000 0x0 0x40000>,
> > +             <0x0 0x284a0000 0x0 0x4000>,
> > +             <0x0 0x2aa00000 0x0 0x40000>,
> > +             <0x0 0x28400000 0x0 0x2000>;
> > +     reg-names = "gcfg", "rchan", "rchanrt", "tchan",
> > +                 "tchanrt", "rflow";
> > +     bootph-pre-ram;
> > +};
> > +
> > +&sms {
> > +     k3_sysreset: sysreset-controller {
> > +             compatible = "ti,sci-sysreset";
> > +             bootph-pre-ram;
> > +     };
> > +};
> > +
> > +#ifdef CONFIG_TARGET_J784S4_A72_EVM
> > +
> > +#define SPL_AM69_SK_DTB "spl/dts/ti/k3-am69-sk.dtb"
>
> Did I miss anything and the device trees are now really also in a vendor folder in U-Boot as well?
>

Yes, with this patch-set [1] we are moving away from manual devicetree
copy/sync from Linux kernel but rather towards automatic sync with
better alignment.

[1] https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.org/

-Sumit
