Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFB5D60CEF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 04:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E032890D0;
	Tue, 19 Nov 2024 05:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NRIwbHwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FE4894AC; Tue, 19 Nov 2024 05:07:00 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF1C88ECB
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-514668ec665so3997125e0c.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731989217; x=1732594017; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rmxtAVhkbRQxcWQCp9Qzp6ibyNFy4KhK9Vt6bA7bkvs=;
 b=NRIwbHwQGiuQP2raWuofCbgHB4Xvq1QTSUo48EMv09mN0+WeZtmp5q1FZrW00Z8RE4
 jMjtuAyTyCghKVAWI+PD9Xkc7v2N2FQodW7EsGoOGYMlTQwoDWAoE5uiq9z49TABoHyk
 gDqp6kwabBn5ZJ32aH/b+7B8xu1qtn937mvKe3npQbuDa2p90pTbmNvLYR4NYGiXeKl0
 Y1kCa8xE3s5XKVeBM2+WNZVuq0/ffILyJ+lGljfcDUchXHcFyBgi2NcRhBNOF7Zsonj4
 yBHaGYpp/jT+etD4O3cT0kw6cTuHhh5l7uVsROKFlD4v/mpRC17EfnYri9zuq/CWUfSt
 TmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731989217; x=1732594017;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmxtAVhkbRQxcWQCp9Qzp6ibyNFy4KhK9Vt6bA7bkvs=;
 b=M5MLC6eDSeOUiMJgpPWVROehwObzyOKUV7utYHVv3k4jovNO7y+qKjUqCz//ep93BR
 g0JWAO1Y46FOY7PTM7U4Lg5Gj58vXxKWzy+gISbDAfn3tKaaGsqfttU/lWdcmNyoyH1V
 JHok1e2WIUusJQYi96zVZGVkU5Bh68q0EHEPxt8yN8hZh61c8gXG5oWWAaBsQ1r/4mby
 kDomJkQJpcubtDW79JIbZFmzSpkPK/G1JK3sKuBmT+qUeXpBV15Td6eeXDiFr0Iyv9sJ
 POgVkjIvFpK2JTPem2UOe+12VUOT29OgDZ2Ik5P1AnKn8LOKNHVCITnNjXtdR8a7ME0g
 iN2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4fnK0W5hfeP9SoQyndEYUehNyWV+fxTzsss7BtW2ntp7yrtiqfxcgVIaMOlrQa3UcXCjng6I=@lists.denx.de
X-Gm-Message-State: AOJu0Yykzq4An2m2QEGH/rGB3dh3kPz+XG1YbJ3SpvKucERnmxXDJ9vH
 0xJF/9cZQsYX+IXd1/5LDPPh9h+25ZUcpEsDcUt3Y6eL7jCB6ihAcx5PZlRzWzl4O1aJWtIr7uo
 +9tc+8h0FTscb04Dgwea2d6HFPEMKNqF12UbUhA==
X-Google-Smtp-Source: AGHT+IGBMVWFbGLofP32w/8FvB3Zc9kdM/4nSHUoT46G/FR/1i4y5xN6ttqV4T6SzwyA1P1FQmILxB4nmgVGWC+Bry0=
X-Received: by 2002:a05:6102:80c:b0:4a9:69ce:dcfb with SMTP id
 ada2fe7eead31-4ad9f085df8mr1612476137.7.1731989215289; Mon, 18 Nov 2024
 20:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
In-Reply-To: <20241119020425.51989-3-hal.feng@starfivetech.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Nov 2024 09:36:44 +0530
Message-ID: <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 H Bell <dmoo_dv@protonmail.com>, 
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

Hi,

On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> Add u-boot features to the U-Boot device tree.
>

For follow-up work, I would suggest minimizing U-Boot specific DT
bits. You can either re-use what's available in upstream DT or push
U-Boot specific changes (eg. bootph-* properties etc.) upstream.

FWIW:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi | 43 +++++++++++++++++--
>  arch/riscv/dts/jh7110-u-boot.dtsi             | 34 +++++++++++++++
>  2 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> index 3012466b30..fac9e16fb1 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> @@ -6,6 +6,10 @@
>  #include "binman.dtsi"
>  #include "jh7110-u-boot.dtsi"
>  / {
> +       aliases {
> +               spi0 = &qspi;
> +       };
> +
>         chosen {
>                 bootph-pre-ram;
>         };
> @@ -27,42 +31,70 @@
>
>  &uart0 {
>         bootph-pre-ram;
> +       reg-offset = <0>;
> +       current-speed = <115200>;
> +       clock-frequency = <24000000>;
>  };
>
>  &mmc0 {
>         bootph-pre-ram;
> +       compatible = "snps,dw-mshc";
>  };
>
>  &mmc1 {
>         bootph-pre-ram;
> +       compatible = "snps,dw-mshc";
> +};
> +
> +&phy0 {
> +       rx-internal-delay-ps = <1900>;
> +};
> +
> +&phy1 {
> +       rx-internal-delay-ps = <0>;
>  };
>
>  &qspi {
>         bootph-pre-ram;
> +       spi-max-frequency = <250000000>;
>
> -       nor-flash@0 {
> +       flash@0 {
>                 bootph-pre-ram;
> +               /delete-property/ cdns,read-delay;
> +               spi-max-frequency = <100000000>;
>         };
>  };
>
> +&syscrg {
> +       assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_BUS_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_PERH_ROOT>,
> +                         <&syscrg JH7110_SYSCLK_QSPI_REF>;
> +       assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&pllclk JH7110_PLLCLK_PLL2_OUT>,
> +                                <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
> +       assigned-clock-rates = <0>, <0>, <0>, <0>;
> +};
> +
>  &sysgpio {
>         bootph-pre-ram;
>  };
>
>  &mmc0_pins {
>         bootph-pre-ram;
> -       mmc0-pins-rest {
> +       rst-pins {
>                 bootph-pre-ram;
>         };
>  };
>
>  &mmc1_pins {
>         bootph-pre-ram;
> -       mmc1-pins0 {
> +       clk-pins {
>                 bootph-pre-ram;
>         };
>
> -       mmc1-pins1 {
> +       mmc-pins {
>                 bootph-pre-ram;
>         };
>  };
> @@ -78,6 +110,9 @@
>         bootph-pre-ram;
>         eeprom@50 {
>                 bootph-pre-ram;
> +               compatible = "atmel,24c04";
> +               reg = <0x50>;
> +               pagesize = <16>;
>         };
>  };
>
> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi b/arch/riscv/dts/jh7110-u-boot.dtsi
> index 52c1d60859..21a2ab1789 100644
> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> @@ -46,6 +46,15 @@
>                 };
>         };
>
> +       timer {
> +               compatible = "riscv,timer";
> +               interrupts-extended = <&cpu0_intc 5>,
> +                                     <&cpu1_intc 5>,
> +                                     <&cpu2_intc 5>,
> +                                     <&cpu3_intc 5>,
> +                                     <&cpu4_intc 5>;
> +       };
> +
>         soc {
>                 bootph-pre-ram;
>
> @@ -73,10 +82,35 @@
>         bootph-pre-ram;
>  };
>
> +&gmac0_rgmii_rxin {
> +       bootph-pre-ram;
> +};
> +
>  &gmac0_rmii_refin {
>         bootph-pre-ram;
>  };
>
> +&gmac1_rgmii_rxin {
> +       bootph-pre-ram;
> +};
> +
> +&gmac1_rmii_refin {
> +       bootph-pre-ram;
> +};
> +
> +&stmmac_axi_setup {
> +       snps,wr_osr_lmt = <4>;
> +       snps,rd_osr_lmt = <4>;
> +};
> +
> +&gmac0 {
> +       snps,perfect-filter-entries = <8>;
> +};
> +
> +&gmac1 {
> +       snps,perfect-filter-entries = <8>;
> +};
> +
>  &aoncrg {
>         bootph-pre-ram;
>  };
> --
> 2.43.2
>
