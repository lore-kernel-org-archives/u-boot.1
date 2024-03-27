Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74219C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E533F8802E;
	Wed, 27 Mar 2024 12:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z2BqbTjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFFD8807F; Wed, 27 Mar 2024 05:30:51 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67DA87D31
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7e0ae718e36so1698351241.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711513843; x=1712118643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+R9uhZYu2W3u8zrljg1dWphd+YcRGhAgObQO4CTXtbI=;
 b=Z2BqbTjUtRJw0i0lsAr2W5GL1DnvUXzA1oM8Q3Bf4r4DnbxNKLsJ89XLKuBlsDKNtG
 WePAX1yArQuDREfklNNYk7RK9anuFXKVxQ0uPYj6aa5PhXvfrwW3oKU0giFTcOd5kvba
 CUu85cfW6k6kA7k+MVWXUgMjYQqhaq+jL1awz8n8ZtRbAYKrWcfhbV7UzsuzJv5F2Zn6
 /rNr7HF6VvccNcqGMFvLMC6yCFUnSLhizqdOcHY2qcATCoFcxkPDveseMUDl7sjJ7D1s
 lKMPIocqn/GFKXOlU9qCmAiqRi17p/UD7GGzzEKL6NRcIF3migMvnc3nj81uRSUdKrWs
 Nelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711513843; x=1712118643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+R9uhZYu2W3u8zrljg1dWphd+YcRGhAgObQO4CTXtbI=;
 b=oIYm6hoPDR2HzZ9amvDJTyEYET1azMq3eWIxa4BPTA/Bb/mqvW10WGoy+lQ1LjcU5c
 k7z0dvQOBL3/8vJgIYwVepCnO+kfVdeRgWz3nVtVypwnHQLdCIjEyO4mvUln+8KMi4JD
 4G5QCSxmhjTXu4pETXcmQDYS1kC2MG/DmM2WJD/m6qfWIWt1AHM/iCCB90ilTwpJvCja
 DNRzsFnIhxyxKlU+LxRek1ETRNYc7pMt3v6HQwvD6C0Ex847PH0xkz2hyVFAAV8XeLia
 qZX3XLErYWwzzd4TX7czUFZwaLWOn0ln5Paug7fwrHmq0Ysi4/0VnK8etzM/329qJcGK
 x2jQ==
X-Gm-Message-State: AOJu0YwJeaIdmTu552/lr0SYko4uoTgQ83JWh5R1vVVFuRyDzBWrgfhZ
 CGV6K487hc7bOsZKagZXyQrnBPC2szfflQgpsHvy96SOoViIP7eH44HnPrxDxX8v9t2uiEnO/JM
 rxd8FYF5liqlDiUe5IyDBqek9TZSwtUweU6ZCIxxylizRfrveJVc=
X-Google-Smtp-Source: AGHT+IHTbamA3CiYJYtgsZqDWn0gWsSrFP2LAO1LwrOuIcgD77DZaMXJuyFSwT+0zPPztUoguGwETOB+zDWbGgoD3zQ=
X-Received: by 2002:a67:efcf:0:b0:474:c9be:ae61 with SMTP id
 s15-20020a67efcf000000b00474c9beae61mr64000vsp.18.1711513842249; Tue, 26 Mar
 2024 21:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240326211214.577-1-mibodhi@gmail.com>
In-Reply-To: <20240326211214.577-1-mibodhi@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Mar 2024 10:00:29 +0530
Message-ID: <CAFA6WYNtk4Dxx4RqqZ6BKw7Sb03zZuYyc6wcHxfZ9uQkn=DEBQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: kirkwood: Remove DTS files for Kirkwood boards
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Michael Walle <michael@walle.cc>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Guinot <simon.guinot@sequanux.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 27 Mar 2024 12:14:56 +0100
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

On Wed, 27 Mar 2024 at 02:43, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Remove DTS and DTSI files for Kirkwood boards that have upstream supports.

nit: s/supports/support/

>
> This patch depends on
> "arm: dts: kirkwood: Enable upstream DT on Kirkwood boards"
> https://patchwork.ozlabs.org/project/uboot/patch/20240322021747.14873-1-mibodhi@gmail.com/
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  arch/arm/dts/Makefile                         |  28 +-
>  arch/arm/dts/kirkwood-6192.dtsi               |  88 --
>  arch/arm/dts/kirkwood-6281.dtsi               |  90 --
>  arch/arm/dts/kirkwood-6282.dtsi               | 161 ----
>  arch/arm/dts/kirkwood-98dx4122.dtsi           |  53 --
>  arch/arm/dts/kirkwood-blackarmor-nas220.dts   | 172 ----
>  arch/arm/dts/kirkwood-d2net.dts               |  45 -
>  arch/arm/dts/kirkwood-dns325.dts              |  63 --
>  arch/arm/dts/kirkwood-dnskw.dtsi              | 235 -----
>  arch/arm/dts/kirkwood-dockstar.dts            | 110 ---
>  arch/arm/dts/kirkwood-dreamplug.dts           | 131 ---
>  arch/arm/dts/kirkwood-ds109.dts               |  40 -
>  arch/arm/dts/kirkwood-goflexnet.dts           | 190 ----
>  .../arm/dts/kirkwood-guruplug-server-plus.dts | 133 ---
>  arch/arm/dts/kirkwood-ib62x0.dts              | 146 ---
>  arch/arm/dts/kirkwood-iconnect.dts            | 195 ----
>  arch/arm/dts/kirkwood-is2.dts                 |  40 -
>  arch/arm/dts/kirkwood-lschlv2.dts             |  20 -
>  arch/arm/dts/kirkwood-lsxhl.dts               |  20 -
>  arch/arm/dts/kirkwood-lsxl.dtsi               | 241 -----
>  arch/arm/dts/kirkwood-net2big.dts             |  63 --
>  arch/arm/dts/kirkwood-netxbig.dtsi            | 232 -----
>  arch/arm/dts/kirkwood-ns2-common.dtsi         |  97 --
>  arch/arm/dts/kirkwood-ns2.dts                 |  40 -
>  arch/arm/dts/kirkwood-ns2lite.dts             |  35 -
>  arch/arm/dts/kirkwood-ns2max.dts              |  59 --
>  arch/arm/dts/kirkwood-ns2mini.dts             |  60 --
>  arch/arm/dts/kirkwood-nsa310s.dts             | 319 -------
>  arch/arm/dts/kirkwood-nsa325.dts              | 231 -----
>  arch/arm/dts/kirkwood-nsa3x0-common.dtsi      | 157 ----
>  arch/arm/dts/kirkwood-openrd-base.dts         |  39 -
>  arch/arm/dts/kirkwood-openrd-client.dts       |  73 --
>  arch/arm/dts/kirkwood-openrd-ultimate.dts     |  55 --
>  arch/arm/dts/kirkwood-openrd.dtsi             | 122 ---
>  arch/arm/dts/kirkwood-pogo_e02.dts            | 132 ---
>  arch/arm/dts/kirkwood-pogoplug-series-4.dts   | 180 ----
>  arch/arm/dts/kirkwood-sheevaplug-common.dtsi  | 104 ---
>  arch/arm/dts/kirkwood-sheevaplug.dts          |  42 -
>  arch/arm/dts/kirkwood-synology.dtsi           | 855 ------------------
>  arch/arm/dts/kirkwood.dtsi                    | 393 --------
>  40 files changed, 1 insertion(+), 5488 deletions(-)

Glad to see this diff stat.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  delete mode 100644 arch/arm/dts/kirkwood-6192.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-6281.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-6282.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-98dx4122.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-blackarmor-nas220.dts
>  delete mode 100644 arch/arm/dts/kirkwood-d2net.dts
>  delete mode 100644 arch/arm/dts/kirkwood-dns325.dts
>  delete mode 100644 arch/arm/dts/kirkwood-dnskw.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-dockstar.dts
>  delete mode 100644 arch/arm/dts/kirkwood-dreamplug.dts
>  delete mode 100644 arch/arm/dts/kirkwood-ds109.dts
>  delete mode 100644 arch/arm/dts/kirkwood-goflexnet.dts
>  delete mode 100644 arch/arm/dts/kirkwood-guruplug-server-plus.dts
>  delete mode 100644 arch/arm/dts/kirkwood-ib62x0.dts
>  delete mode 100644 arch/arm/dts/kirkwood-iconnect.dts
>  delete mode 100644 arch/arm/dts/kirkwood-is2.dts
>  delete mode 100644 arch/arm/dts/kirkwood-lschlv2.dts
>  delete mode 100644 arch/arm/dts/kirkwood-lsxhl.dts
>  delete mode 100644 arch/arm/dts/kirkwood-lsxl.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-net2big.dts
>  delete mode 100644 arch/arm/dts/kirkwood-netxbig.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-ns2-common.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-ns2.dts
>  delete mode 100644 arch/arm/dts/kirkwood-ns2lite.dts
>  delete mode 100644 arch/arm/dts/kirkwood-ns2max.dts
>  delete mode 100644 arch/arm/dts/kirkwood-ns2mini.dts
>  delete mode 100644 arch/arm/dts/kirkwood-nsa310s.dts
>  delete mode 100644 arch/arm/dts/kirkwood-nsa325.dts
>  delete mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-openrd-base.dts
>  delete mode 100644 arch/arm/dts/kirkwood-openrd-client.dts
>  delete mode 100644 arch/arm/dts/kirkwood-openrd-ultimate.dts
>  delete mode 100644 arch/arm/dts/kirkwood-openrd.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-pogo_e02.dts
>  delete mode 100644 arch/arm/dts/kirkwood-pogoplug-series-4.dts
>  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug-common.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug.dts
>  delete mode 100644 arch/arm/dts/kirkwood-synology.dtsi
>  delete mode 100644 arch/arm/dts/kirkwood.dtsi
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index d85a33055c..896476a823 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -47,33 +47,7 @@ dtb-$(CONFIG_ARCH_DAVINCI) += \
>
>  dtb-$(CONFIG_ARCH_KIRKWOOD) += \
>         kirkwood-atl-sbx81lifkw.dtb \
> -       kirkwood-atl-sbx81lifxcat.dtb \
> -       kirkwood-blackarmor-nas220.dtb \
> -       kirkwood-d2net.dtb \
> -       kirkwood-dns325.dtb \
> -       kirkwood-dockstar.dtb \
> -       kirkwood-dreamplug.dtb \
> -       kirkwood-ds109.dtb \
> -       kirkwood-goflexnet.dtb \
> -       kirkwood-guruplug-server-plus.dtb \
> -       kirkwood-ib62x0.dtb \
> -       kirkwood-iconnect.dtb \
> -       kirkwood-is2.dtb \
> -       kirkwood-lsxhl.dtb \
> -       kirkwood-lschlv2.dtb \
> -       kirkwood-net2big.dtb \
> -       kirkwood-ns2.dtb \
> -       kirkwood-ns2lite.dtb \
> -       kirkwood-ns2max.dtb \
> -       kirkwood-ns2mini.dtb \
> -       kirkwood-nsa310s.dtb \
> -       kirkwood-nsa325.dtb \
> -       kirkwood-openrd-base.dtb \
> -       kirkwood-openrd-client.dtb \
> -       kirkwood-openrd-ultimate.dtb \
> -       kirkwood-pogo_e02.dtb \
> -       kirkwood-pogoplug-series-4.dtb \
> -       kirkwood-sheevaplug.dtb
> +       kirkwood-atl-sbx81lifxcat.dtb
>
>  dtb-$(CONFIG_MACH_S900) += \
>         bubblegum_96.dtb
> diff --git a/arch/arm/dts/kirkwood-6192.dtsi b/arch/arm/dts/kirkwood-6192.dtsi
> deleted file mode 100644
> index 396bcba08a..0000000000
> --- a/arch/arm/dts/kirkwood-6192.dtsi
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/ {
> -       mbus@f1000000 {
> -               pciec: pcie@82000000 {
> -                       compatible = "marvell,kirkwood-pcie";
> -                       status = "disabled";
> -                       device_type = "pci";
> -
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -
> -                       bus-range = <0x00 0xff>;
> -
> -                       ranges =
> -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
> -
> -                       pcie0: pcie@1,0 {
> -                               device_type = "pci";
> -                               assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> -                               reg = <0x0800 0 0 0 0>;
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -                               ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> -                                         0x81000000 0 0 0x81000000 0x1 0 1 0>;
> -                               bus-range = <0x00 0xff>;
> -                               interrupt-map-mask = <0 0 0 0>;
> -                               interrupt-map = <0 0 0 0 &intc 9>;
> -                               marvell,pcie-port = <0>;
> -                               marvell,pcie-lane = <0>;
> -                               clocks = <&gate_clk 2>;
> -                               status = "disabled";
> -                       };
> -               };
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       compatible = "marvell,88f6192-pinctrl";
> -
> -                       pmx_sata0: pmx-sata0 {
> -                               marvell,pins = "mpp5", "mpp21", "mpp23";
> -                               marvell,function = "sata0";
> -                       };
> -                       pmx_sata1: pmx-sata1 {
> -                               marvell,pins = "mpp4", "mpp20", "mpp22";
> -                               marvell,function = "sata1";
> -                       };
> -                       pmx_sdio: pmx-sdio {
> -                               marvell,pins = "mpp12", "mpp13", "mpp14",
> -                                              "mpp15", "mpp16", "mpp17";
> -                               marvell,function = "sdio";
> -                       };
> -               };
> -
> -               rtc: rtc@10300 {
> -                       compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
> -                       reg = <0x10300 0x20>;
> -                       interrupts = <53>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               sata: sata@80000 {
> -                       compatible = "marvell,orion-sata";
> -                       reg = <0x80000 0x5000>;
> -                       interrupts = <21>;
> -                       clocks = <&gate_clk 14>, <&gate_clk 15>;
> -                       clock-names = "0", "1";
> -                       phys = <&sata_phy0>, <&sata_phy1>;
> -                       phy-names = "port0", "port1";
> -                       status = "disabled";
> -               };
> -
> -               sdio: mvsdio@90000 {
> -                       compatible = "marvell,orion-sdio";
> -                       reg = <0x90000 0x200>;
> -                       interrupts = <28>;
> -                       clocks = <&gate_clk 4>;
> -                       bus-width = <4>;
> -                       cap-sdio-irq;
> -                       cap-sd-highspeed;
> -                       cap-mmc-highspeed;
> -                       status = "disabled";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-6281.dtsi b/arch/arm/dts/kirkwood-6281.dtsi
> deleted file mode 100644
> index faa05849a4..0000000000
> --- a/arch/arm/dts/kirkwood-6281.dtsi
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/ {
> -       mbus@f1000000 {
> -               pciec: pcie@82000000 {
> -                       compatible = "marvell,kirkwood-pcie";
> -                       status = "disabled";
> -                       device_type = "pci";
> -
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -
> -                       bus-range = <0x00 0xff>;
> -
> -                       ranges =
> -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
> -
> -                       pcie0: pcie@1,0 {
> -                               device_type = "pci";
> -                               assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> -                               reg = <0x0800 0 0 0 0>;
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -                               ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> -                                         0x81000000 0 0 0x81000000 0x1 0 1 0>;
> -                               bus-range = <0x00 0xff>;
> -                               interrupt-map-mask = <0 0 0 0>;
> -                               interrupt-map = <0 0 0 0 &intc 9>;
> -                               marvell,pcie-port = <0>;
> -                               marvell,pcie-lane = <0>;
> -                               clocks = <&gate_clk 2>;
> -                               status = "disabled";
> -                       };
> -               };
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       compatible = "marvell,88f6281-pinctrl";
> -
> -                       pmx_sata0: pmx-sata0 {
> -                               marvell,pins = "mpp5", "mpp21", "mpp23";
> -                               marvell,function = "sata0";
> -                       };
> -                       pmx_sata1: pmx-sata1 {
> -                               marvell,pins = "mpp4", "mpp20", "mpp22";
> -                               marvell,function = "sata1";
> -                       };
> -                       pmx_sdio: pmx-sdio {
> -                               marvell,pins = "mpp12", "mpp13", "mpp14",
> -                                              "mpp15", "mpp16", "mpp17";
> -                               marvell,function = "sdio";
> -                       };
> -               };
> -
> -               rtc: rtc@10300 {
> -                       compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
> -                       reg = <0x10300 0x20>;
> -                       interrupts = <53>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               sata: sata@80000 {
> -                       compatible = "marvell,orion-sata";
> -                       reg = <0x80000 0x5000>;
> -                       interrupts = <21>;
> -                       clocks = <&gate_clk 14>, <&gate_clk 15>;
> -                       clock-names = "0", "1";
> -                       phys = <&sata_phy0>, <&sata_phy1>;
> -                       phy-names = "port0", "port1";
> -                       status = "disabled";
> -               };
> -
> -               sdio: mvsdio@90000 {
> -                       compatible = "marvell,orion-sdio";
> -                       reg = <0x90000 0x200>;
> -                       interrupts = <28>;
> -                       clocks = <&gate_clk 4>;
> -                       pinctrl-0 = <&pmx_sdio>;
> -                       pinctrl-names = "default";
> -                       bus-width = <4>;
> -                       cap-sdio-irq;
> -                       cap-sd-highspeed;
> -                       cap-mmc-highspeed;
> -                       status = "disabled";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-6282.dtsi b/arch/arm/dts/kirkwood-6282.dtsi
> deleted file mode 100644
> index e732c501ea..0000000000
> --- a/arch/arm/dts/kirkwood-6282.dtsi
> +++ /dev/null
> @@ -1,161 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/ {
> -       mbus@f1000000 {
> -               pciec: pcie@82000000 {
> -                       compatible = "marvell,kirkwood-pcie";
> -                       status = "disabled";
> -                       device_type = "pci";
> -
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -
> -                       bus-range = <0x00 0xff>;
> -
> -                       ranges =
> -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> -                               0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000
> -                               0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
> -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */
> -                               0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0       1 0 /* Port 1.0 MEM */
> -                               0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0       1 0 /* Port 1.0 IO  */>;
> -
> -                       pcie0: pcie@1,0 {
> -                               device_type = "pci";
> -                               assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> -                               reg = <0x0800 0 0 0 0>;
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -                               ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> -                                         0x81000000 0 0 0x81000000 0x1 0 1 0>;
> -                               bus-range = <0x00 0xff>;
> -                               interrupt-names = "intx", "error";
> -                               interrupts = <9>, <44>;
> -                               interrupt-map-mask = <0 0 0 7>;
> -                               interrupt-map = <0 0 0 1 &pcie0_intc 0>,
> -                                               <0 0 0 2 &pcie0_intc 1>,
> -                                               <0 0 0 3 &pcie0_intc 2>,
> -                                               <0 0 0 4 &pcie0_intc 3>;
> -                               marvell,pcie-port = <0>;
> -                               marvell,pcie-lane = <0>;
> -                               clocks = <&gate_clk 2>;
> -                               status = "disabled";
> -
> -                               pcie0_intc: interrupt-controller {
> -                                       interrupt-controller;
> -                                       #interrupt-cells = <1>;
> -                               };
> -                       };
> -
> -                       pcie1: pcie@2,0 {
> -                               device_type = "pci";
> -                               assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
> -                               reg = <0x1000 0 0 0 0>;
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -                               ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> -                                         0x81000000 0 0 0x81000000 0x2 0 1 0>;
> -                               bus-range = <0x00 0xff>;
> -                               interrupt-names = "intx", "error";
> -                               interrupts = <10>, <45>;
> -                               interrupt-map-mask = <0 0 0 7>;
> -                               interrupt-map = <0 0 0 1 &pcie1_intc 0>,
> -                                               <0 0 0 2 &pcie1_intc 1>,
> -                                               <0 0 0 3 &pcie1_intc 2>,
> -                                               <0 0 0 4 &pcie1_intc 3>;
> -                               marvell,pcie-port = <1>;
> -                               marvell,pcie-lane = <0>;
> -                               clocks = <&gate_clk 18>;
> -                               status = "disabled";
> -
> -                               pcie1_intc: interrupt-controller {
> -                                       interrupt-controller;
> -                                       #interrupt-cells = <1>;
> -                               };
> -                       };
> -               };
> -       };
> -       ocp@f1000000 {
> -
> -               pinctrl: pin-controller@10000 {
> -                       compatible = "marvell,88f6282-pinctrl";
> -
> -                       pmx_sata0: pmx-sata0 {
> -                               marvell,pins = "mpp5", "mpp21", "mpp23";
> -                               marvell,function = "sata0";
> -                       };
> -                       pmx_sata1: pmx-sata1 {
> -                               marvell,pins = "mpp4", "mpp20", "mpp22";
> -                               marvell,function = "sata1";
> -                       };
> -
> -                       /*
> -                        * Default I2C1 pinctrl setting on mpp36/mpp37,
> -                        * overwrite marvell,pins on board level if required.
> -                        */
> -                       pmx_twsi1: pmx-twsi1 {
> -                               marvell,pins = "mpp36", "mpp37";
> -                               marvell,function = "twsi1";
> -                       };
> -
> -                       pmx_sdio: pmx-sdio {
> -                               marvell,pins = "mpp12", "mpp13", "mpp14",
> -                                              "mpp15", "mpp16", "mpp17";
> -                               marvell,function = "sdio";
> -                       };
> -               };
> -
> -               thermal: thermal@10078 {
> -                       compatible = "marvell,kirkwood-thermal";
> -                       reg = <0x10078 0x4>;
> -                       status = "okay";
> -               };
> -
> -               rtc: rtc@10300 {
> -                       compatible = "marvell,kirkwood-rtc", "marvell,orion-rtc";
> -                       reg = <0x10300 0x20>;
> -                       interrupts = <53>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               i2c1: i2c@11100 {
> -                       compatible = "marvell,mv64xxx-i2c";
> -                       reg = <0x11100 0x20>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       interrupts = <32>;
> -                       clock-frequency = <100000>;
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_twsi1>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               sata: sata@80000 {
> -                       compatible = "marvell,orion-sata";
> -                       reg = <0x80000 0x5000>;
> -                       interrupts = <21>;
> -                       clocks = <&gate_clk 14>, <&gate_clk 15>;
> -                       clock-names = "0", "1";
> -                       phys = <&sata_phy0>, <&sata_phy1>;
> -                       phy-names = "port0", "port1";
> -                       status = "disabled";
> -               };
> -
> -               sdio: mvsdio@90000 {
> -                       compatible = "marvell,orion-sdio";
> -                       reg = <0x90000 0x200>;
> -                       interrupts = <28>;
> -                       clocks = <&gate_clk 4>;
> -                       pinctrl-0 = <&pmx_sdio>;
> -                       pinctrl-names = "default";
> -                       bus-width = <4>;
> -                       cap-sdio-irq;
> -                       cap-sd-highspeed;
> -                       cap-mmc-highspeed;
> -                       status = "disabled";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-98dx4122.dtsi b/arch/arm/dts/kirkwood-98dx4122.dtsi
> deleted file mode 100644
> index 299c147298..0000000000
> --- a/arch/arm/dts/kirkwood-98dx4122.dtsi
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/ {
> -       mbus@f1000000 {
> -               pciec: pcie@82000000 {
> -                       compatible = "marvell,kirkwood-pcie";
> -                       status = "disabled";
> -                       device_type = "pci";
> -
> -                       #address-cells = <3>;
> -                       #size-cells = <2>;
> -
> -                       bus-range = <0x00 0xff>;
> -
> -                       ranges =
> -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
> -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0       1 0 /* Port 0.0 MEM */
> -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO  */>;
> -
> -                       pcie0: pcie@1,0 {
> -                               device_type = "pci";
> -                               assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
> -                               reg = <0x0800 0 0 0 0>;
> -                               #address-cells = <3>;
> -                               #size-cells = <2>;
> -                               #interrupt-cells = <1>;
> -                               ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> -                                         0x81000000 0 0 0x81000000 0x1 0 1 0>;
> -                               bus-range = <0x00 0xff>;
> -                               interrupt-map-mask = <0 0 0 0>;
> -                               interrupt-map = <0 0 0 0 &intc 9>;
> -                               marvell,pcie-port = <0>;
> -                               marvell,pcie-lane = <0>;
> -                               clocks = <&gate_clk 2>;
> -                               status = "disabled";
> -                       };
> -               };
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       compatible = "marvell,98dx4122-pinctrl";
> -
> -               };
> -       };
> -};
> -
> -&sata_phy0 {
> -       status = "disabled";
> -};
> -
> -&sata_phy1 {
> -       status = "disabled";
> -};
> diff --git a/arch/arm/dts/kirkwood-blackarmor-nas220.dts b/arch/arm/dts/kirkwood-blackarmor-nas220.dts
> deleted file mode 100644
> index 07fbfca444..0000000000
> --- a/arch/arm/dts/kirkwood-blackarmor-nas220.dts
> +++ /dev/null
> @@ -1,172 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Device Tree file for Seagate Blackarmor NAS220
> - *
> - * Copyright (C) 2014 Evgeni Dobrev <evgeni@studio-punkt.com>
> - */
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6192.dtsi"
> -
> -/ {
> -       model = "Seagate Blackarmor NAS220";
> -       compatible = "seagate,blackarmor-nas220","marvell,kirkwood-88f6192",
> -                    "marvell,kirkwood";
> -
> -       memory { /* 128 MB */
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -
> -               reset {
> -                       label = "Reset";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               button {
> -                       label = "Power";
> -                       linux,code = <KEY_SLEEP>;
> -                       gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -
> -               blue-power {
> -                       label = "nas220:blue:power";
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -                       linux,default-trigger = "default-on";
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_power_sata0 &pmx_power_sata1>;
> -               pinctrl-names = "default";
> -
> -               sata0_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "SATA0 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 24 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               sata1_power: regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "SATA1 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 28 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> -
> -/*
> - * Serial port routed to connector CN5
> - *
> - * pin 1 - TX (CPU's TX)
> - * pin 4 - RX (CPU's RX)
> - * pin 6 - GND
> - */
> -&uart0 {
> -       status = "okay";
> -};
> -
> -&pinctrl {
> -       pinctrl-0 = <&pmx_button_reset &pmx_button_power>;
> -       pinctrl-names = "default";
> -
> -       pmx_act_sata0: pmx-act-sata0 {
> -               marvell,pins = "mpp15";
> -               marvell,function = "sata0";
> -       };
> -
> -       pmx_act_sata1: pmx-act-sata1 {
> -               marvell,pins = "mpp16";
> -               marvell,function = "sata1";
> -       };
> -
> -       pmx_power_sata0: pmx-power-sata0 {
> -               marvell,pins = "mpp24";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_power_sata1: pmx-power-sata1 {
> -               marvell,pins = "mpp28";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_button_reset: pmx-button-reset {
> -               marvell,pins = "mpp29";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_button_power: pmx-button-power {
> -               marvell,pins = "mpp26";
> -               marvell,function = "gpio";
> -       };
> -};
> -
> -&sata {
> -       status = "okay";
> -       nr-ports = <2>;
> -};
> -
> -&i2c0 {
> -       status = "okay";
> -
> -       adt7476: thermal@2e {
> -               compatible = "adi,adt7476";
> -               reg = <0x2e>;
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@8 {
> -                reg = <8>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-d2net.dts b/arch/arm/dts/kirkwood-d2net.dts
> deleted file mode 100644
> index bd3b266dd7..0000000000
> --- a/arch/arm/dts/kirkwood-d2net.dts
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree file for d2 Network v2
> - *
> - * Copyright (C) 2014 Simon Guinot <simon.guinot@sequanux.org>
> - *
> -*/
> -
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/leds-ns2.h>
> -#include "kirkwood-netxbig.dtsi"
> -
> -/ {
> -       model = "LaCie d2 Network v2";
> -       compatible = "lacie,d2net_v2", "lacie,netxbig", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       ns2-leds {
> -               compatible = "lacie,ns2-leds";
> -
> -               blue-sata {
> -                       label = "d2net_v2:blue:sata";
> -                       slow-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -                       cmd-gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
> -                       modes-map = <NS_V2_LED_OFF  1 0
> -                                    NS_V2_LED_ON   0 1
> -                                    NS_V2_LED_ON   1 1
> -                                    NS_V2_LED_SATA 0 0>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -
> -               red-fail {
> -                       label = "d2net_v2:red:fail";
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-dns325.dts b/arch/arm/dts/kirkwood-dns325.dts
> deleted file mode 100644
> index 94d9c06cbb..0000000000
> --- a/arch/arm/dts/kirkwood-dns325.dts
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood-dnskw.dtsi"
> -
> -/ {
> -       model = "D-Link DNS-325 NAS (Rev A1)";
> -       compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_power &pmx_led_red_usb_325
> -                            &pmx_led_red_left_hdd &pmx_led_red_right_hdd
> -                            &pmx_led_white_usb>;
> -               pinctrl-names = "default";
> -
> -               white-power {
> -                       label = "dns325:white:power";
> -                       gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -               white-usb {
> -                       label = "dns325:white:usb";
> -                       gpios = <&gpio1 11 GPIO_ACTIVE_LOW>; /* GPIO 43 */
> -               };
> -               red-l_hdd {
> -                       label = "dns325:red:l_hdd";
> -                       gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> -               };
> -               red-r_hdd {
> -                       label = "dns325:red:r_hdd";
> -                       gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
> -               };
> -               red-usb {
> -                       label = "dns325:red:usb";
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       ocp@f1000000 {
> -               i2c@11000 {
> -                       status = "okay";
> -
> -                       lm75: lm75@48 {
> -                               compatible = "national,lm75";
> -                               reg = <0x48>;
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-dnskw.dtsi b/arch/arm/dts/kirkwood-dnskw.dtsi
> deleted file mode 100644
> index cbaf06f2f7..0000000000
> --- a/arch/arm/dts/kirkwood-dnskw.dtsi
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "D-Link DNS NASes (kirkwood-based)";
> -       compatible = "dlink,dns-kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_button_power &pmx_button_unmount
> -                            &pmx_button_reset>;
> -               pinctrl-names = "default";
> -
> -               power {
> -                       label = "Power button";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> -               };
> -               eject {
> -                       label = "USB unmount button";
> -                       linux,code = <KEY_EJECTCD>;
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -               };
> -               reset {
> -                       label = "Reset button";
> -                       linux,code = <KEY_RESTART>;
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio_fan {
> -               /* Fan: ADDA AD045HB-G73 40mm 6000rpm@5v */
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fan_high_speed &pmx_fan_low_speed>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio1 14 GPIO_ACTIVE_LOW
> -                        &gpio1 13 GPIO_ACTIVE_LOW>;
> -               gpio-fan,speed-map = <0    0
> -                                     3000 1
> -                                     6000 2>;
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               pinctrl-0 = <&pmx_power_off>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -
> -                       pinctrl-0 = <&pmx_power_back_on &pmx_present_sata0
> -                                    &pmx_present_sata1 &pmx_fan_tacho
> -                                    &pmx_temp_alarm>;
> -                       pinctrl-names = "default";
> -
> -                       pmx_sata0: pmx-sata0 {
> -                               marvell,pins = "mpp20";
> -                               marvell,function = "sata1";
> -                       };
> -                       pmx_sata1: pmx-sata1 {
> -                               marvell,pins = "mpp21";
> -                               marvell,function = "sata0";
> -                       };
> -                       pmx_led_power: pmx-led-power {
> -                               marvell,pins = "mpp26";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_red_right_hdd: pmx-led-red-right-hdd {
> -                               marvell,pins = "mpp27";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_red_left_hdd: pmx-led-red-left-hdd {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_red_usb_325: pmx-led-red-usb-325 {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_power: pmx-button-power {
> -                               marvell,pins = "mpp34";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_red_usb_320: pmx-led-red-usb-320 {
> -                               marvell,pins = "mpp35";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_off: pmx-power-off {
> -                               marvell,pins = "mpp36";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_back_on: pmx-power-back-on {
> -                               marvell,pins = "mpp37";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_sata0: pmx-power-sata0 {
> -                               marvell,pins = "mpp39";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_sata1: pmx-power-sata1 {
> -                               marvell,pins = "mpp40";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_present_sata0: pmx-present-sata0 {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_present_sata1: pmx-present-sata1 {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_white_usb: pmx-led-white-usb {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_fan_tacho: pmx-fan-tacho {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_fan_high_speed: pmx-fan-high-speed {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_fan_low_speed: pmx-fan-low-speed {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_unmount: pmx-button-unmount {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_reset: pmx-button-reset {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_temp_alarm: pmx-temp-alarm {
> -                               marvell,pins = "mpp49";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_power_sata0 &pmx_power_sata1>;
> -               pinctrl-names = "default";
> -
> -               sata0_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "SATA0 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio1 7 0>;
> -               };
> -               sata1_power: regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "SATA1 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio1 8 0>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -       chip-delay = <35>;
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -               read-only;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x500000>;
> -       };
> -
> -       partition@600000 {
> -               label = "ramdisk";
> -               reg = <0x0600000 0x500000>;
> -       };
> -
> -       partition@b00000 {
> -               label = "image";
> -               reg = <0x0b00000 0x6600000>;
> -       };
> -
> -       partition@7100000 {
> -               label = "mini firmware";
> -               reg = <0x7100000 0xa00000>;
> -       };
> -
> -       partition@7b00000 {
> -               label = "config";
> -               reg = <0x7b00000 0x500000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@8 {
> -               reg = <8>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-dockstar.dts b/arch/arm/dts/kirkwood-dockstar.dts
> deleted file mode 100644
> index 6a3f1bf6d9..0000000000
> --- a/arch/arm/dts/kirkwood-dockstar.dts
> +++ /dev/null
> @@ -1,110 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Seagate FreeAgent Dockstar";
> -       compatible = "seagate,dockstar", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/sda1 rootdelay=10";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_usb_power_enable: pmx-usb-power-enable {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_green: pmx-led-green {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_orange: pmx-led-orange {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -       };
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_green &pmx_led_orange>;
> -               pinctrl-names = "default";
> -
> -               health {
> -                       label = "status:green:health";
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -               fault {
> -                       label = "status:orange:fault";
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_usb_power_enable>;
> -               pinctrl-names = "default";
> -
> -               usb_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 29 0>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -               read-only;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x400000>;
> -       };
> -
> -       partition@500000 {
> -               label = "data";
> -               reg = <0x0500000 0xfb00000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               compatible = "marvell,88e1116";
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-dreamplug.dts b/arch/arm/dts/kirkwood-dreamplug.dts
> deleted file mode 100644
> index e9eea22fc9..0000000000
> --- a/arch/arm/dts/kirkwood-dreamplug.dts
> +++ /dev/null
> @@ -1,131 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Globalscale Technologies Dreamplug";
> -       compatible = "globalscale,dreamplug-003-ds2001", "globalscale,dreamplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x20000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       aliases {
> -               spi0 = &spi0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_led_bluetooth: pmx-led-bluetooth {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_wifi: pmx-led-wifi {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_wifi_ap: pmx-led-wifi-ap {
> -                               marvell,pins = "mpp49";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -
> -               spi@10600 {
> -                       status = "okay";
> -
> -                       m25p40@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "mxicy,mx25l1606e", "jedec,spi-nor";
> -                               reg = <0>;
> -                               spi-max-frequency = <50000000>;
> -                               mode = <0>;
> -
> -                               partition@0 {
> -                                       reg = <0x0 0x80000>;
> -                                       label = "u-boot";
> -                               };
> -
> -                               partition@100000 {
> -                                       reg = <0x100000 0x10000>;
> -                                       label = "u-boot env";
> -                               };
> -
> -                               partition@180000 {
> -                                       reg = <0x180000 0x10000>;
> -                                       label = "dtb";
> -                               };
> -                       };
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -
> -               mvsdio@90000 {
> -                       pinctrl-0 = <&pmx_sdio>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       /* No CD or WP GPIOs */
> -                       broken-cd;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_bluetooth &pmx_led_wifi
> -                            &pmx_led_wifi_ap >;
> -               pinctrl-names = "default";
> -
> -               bluetooth {
> -                       label = "dreamplug:blue:bluetooth";
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -               };
> -               wifi {
> -                       label = "dreamplug:green:wifi";
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -               };
> -               wifi-ap {
> -                       label = "dreamplug:green:wifi_ap";
> -                       gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -
> -       ethphy1: ethernet-phy@1 {
> -               reg = <1>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&eth1 {
> -       status = "okay";
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-ds109.dts b/arch/arm/dts/kirkwood-ds109.dts
> deleted file mode 100644
> index 29982e7acb..0000000000
> --- a/arch/arm/dts/kirkwood-ds109.dts
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Andrew Lunn <andrew@lunn.ch>
> - * Ben Peddell <klightspeed@killerwolves.net>
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -#include "kirkwood-synology.dtsi"
> -
> -/ {
> -       model = "Synology DS109, DS110, DS110jv20";
> -       compatible = "synology,ds109", "synology,ds110jv20",
> -                    "synology,ds110", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       gpio-fan-150-32-35 {
> -               status = "okay";
> -       };
> -
> -       gpio-leds-hdd-21-1 {
> -               status = "okay";
> -       };
> -};
> -
> -&rs5c372 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-goflexnet.dts b/arch/arm/dts/kirkwood-goflexnet.dts
> deleted file mode 100644
> index 02d87e0a10..0000000000
> --- a/arch/arm/dts/kirkwood-goflexnet.dts
> +++ /dev/null
> @@ -1,190 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Seagate GoFlex Net";
> -       compatible = "seagate,goflexnet", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/sda1 rootdelay=10";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_usb_power_enable: pmx-usb-power-enable {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_right_cap_0: pmx-led_right_cap_0 {
> -                               marvell,pins = "mpp38";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_right_cap_1: pmx-led_right_cap_1 {
> -                               marvell,pins = "mpp39";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_right_cap_2: pmx-led_right_cap_2 {
> -                               marvell,pins = "mpp40";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_right_cap_3: pmx-led_right_cap_3 {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_left_cap_0: pmx-led_left_cap_0 {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_left_cap_1: pmx-led_left_cap_1 {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_left_cap_2: pmx-led_left_cap_2 {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_left_cap_3: pmx-led_left_cap_3 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_green: pmx-led_green {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_orange: pmx-led_orange {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -
> -       };
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = < &pmx_led_orange
> -                             &pmx_led_left_cap_0 &pmx_led_left_cap_1
> -                             &pmx_led_left_cap_2 &pmx_led_left_cap_3
> -                             &pmx_led_right_cap_0 &pmx_led_right_cap_1
> -                             &pmx_led_right_cap_2 &pmx_led_right_cap_3
> -                           >;
> -               pinctrl-names = "default";
> -
> -               health {
> -                       label = "status:green:health";
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -               fault {
> -                       label = "status:orange:fault";
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -               };
> -               left0 {
> -                       label = "status:white:left0";
> -                       gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> -               };
> -               left1 {
> -                       label = "status:white:left1";
> -                       gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> -               };
> -               left2 {
> -                       label = "status:white:left2";
> -                       gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               };
> -               left3 {
> -                       label = "status:white:left3";
> -                       gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> -               };
> -               right0 {
> -                       label = "status:white:right0";
> -                       gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> -               };
> -               right1 {
> -                       label = "status:white:right1";
> -                       gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> -               };
> -               right2 {
> -                       label = "status:white:right2";
> -                       gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> -               };
> -               right3 {
> -                       label = "status:white:right3";
> -                       gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_usb_power_enable>;
> -               pinctrl-names = "default";
> -
> -               usb_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       chip-delay = <40>;
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -               read-only;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x400000>;
> -       };
> -
> -       partition@500000 {
> -               label = "pogoplug";
> -               reg = <0x0500000 0x2000000>;
> -       };
> -
> -       partition@2500000 {
> -               label = "root";
> -               reg = <0x02500000 0xd800000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/dts/kirkwood-guruplug-server-plus.dts
> deleted file mode 100644
> index ff1260ee3f..0000000000
> --- a/arch/arm/dts/kirkwood-guruplug-server-plus.dts
> +++ /dev/null
> @@ -1,133 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Globalscale Technologies Guruplug Server Plus";
> -       compatible = "globalscale,guruplug-server-plus", "globalscale,guruplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x20000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_led_health_r: pmx-led-health-r {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_health_g: pmx-led-health-g {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_wmode_r: pmx-led-wmode-r {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_wmode_g: pmx-led-wmode-g {
> -                               marvell,pins = "mpp49";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -
> -               /* AzureWave AW-GH381 WiFi/BT */
> -               mvsdio@90000 {
> -                       status = "okay";
> -                       non-removable;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = < &pmx_led_health_r &pmx_led_health_g
> -                             &pmx_led_wmode_r &pmx_led_wmode_g >;
> -               pinctrl-names = "default";
> -
> -               health-r {
> -                       label = "guruplug:red:health";
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> -               };
> -               health-g {
> -                       label = "guruplug:green:health";
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -               };
> -               wmode-r {
> -                       label = "guruplug:red:wmode";
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -               };
> -               wmode-g {
> -                       label = "guruplug:green:wmode";
> -                       gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x00000000 0x00100000>;
> -               read-only;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x00100000 0x00400000>;
> -       };
> -
> -       partition@500000 {
> -               label = "data";
> -               reg = <0x00500000 0x1fb00000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               /* Marvell 88E1121R */
> -               compatible = "ethernet-phy-id0141.0cb0",
> -                            "ethernet-phy-ieee802.3-c22";
> -               reg = <0>;
> -       };
> -
> -       ethphy1: ethernet-phy@1 {
> -               /* Marvell 88E1121R */
> -               compatible = "ethernet-phy-id0141.0cb0",
> -                            "ethernet-phy-ieee802.3-c22";
> -               reg = <1>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -               phy-connection-type = "rgmii-id";
> -       };
> -};
> -
> -&eth1 {
> -       status = "okay";
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -               phy-connection-type = "rgmii-id";
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-ib62x0.dts b/arch/arm/dts/kirkwood-ib62x0.dts
> deleted file mode 100644
> index 962a910a6f..0000000000
> --- a/arch/arm/dts/kirkwood-ib62x0.dts
> +++ /dev/null
> @@ -1,146 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
> -       compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_led_os_red: pmx-led-os-red {
> -                               marvell,pins = "mpp22";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_off: pmx-power-off {
> -                               marvell,pins = "mpp24";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_os_green: pmx-led-os-green {
> -                               marvell,pins = "mpp25";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_usb_transfer: pmx-led-usb-transfer {
> -                               marvell,pins = "mpp27";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_reset: pmx-button-reset {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_usb_copy: pmx-button-usb-copy {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_button_reset &pmx_button_usb_copy>;
> -               pinctrl-names = "default";
> -
> -               copy {
> -                       label = "USB Copy";
> -                       linux,code = <KEY_COPY>;
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> -               };
> -               reset {
> -                       label = "Reset";
> -                       linux,code = <KEY_RESTART>;
> -                       gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_os_red &pmx_led_os_green
> -                            &pmx_led_usb_transfer>;
> -               pinctrl-names = "default";
> -
> -               green-os {
> -                       label = "ib62x0:green:os";
> -                       gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> -                       default-state = "keep";
> -               };
> -               red-os {
> -                       label = "ib62x0:red:os";
> -                       gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
> -               };
> -               usb-copy {
> -                       label = "ib62x0:red:usb_copy";
> -                       gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               pinctrl-0 = <&pmx_power_off>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0xe0000>;
> -       };
> -
> -       partition@e0000 {
> -               label = "u-boot environment";
> -               reg = <0xe0000 0x20000>;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x600000>;
> -       };
> -
> -       partition@700000 {
> -               label = "root";
> -               reg = <0x0700000 0xf900000>;
> -       };
> -
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@8 {
> -               reg = <8>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-iconnect.dts b/arch/arm/dts/kirkwood-iconnect.dts
> deleted file mode 100644
> index 4a512d8091..0000000000
> --- a/arch/arm/dts/kirkwood-iconnect.dts
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Iomega Iconnect";
> -       compatible = "iom,iconnect-1.1", "iom,iconnect", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -               linux,initrd-start = <0x4500040>;
> -               linux,initrd-end   = <0x4800000>;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_button_reset: pmx-button-reset {
> -                               marvell,pins = "mpp12";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_otb: pmx-button-otb {
> -                               marvell,pins = "mpp35";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_level: pmx-led-level {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_power_blue: pmx-led-power-blue {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_power_red: pmx-power-red {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_usb1: pmx-led-usb1 {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_usb2: pmx-led-usb2 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_usb3: pmx-led-usb3 {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_usb4: pmx-led-usb4 {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_otb: pmx-led-otb {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               i2c@11000 {
> -                       status = "okay";
> -
> -                       lm63: lm63@4c {
> -                               compatible = "national,lm63";
> -                               reg = <0x4c>;
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = < &pmx_led_level &pmx_led_power_blue
> -                             &pmx_led_power_red &pmx_led_usb1
> -                             &pmx_led_usb2 &pmx_led_usb3
> -                             &pmx_led_usb4 &pmx_led_otb >;
> -               pinctrl-names = "default";
> -
> -               led-level {
> -                       label = "led_level";
> -                       gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> -                       default-state = "on";
> -               };
> -               power-blue {
> -                       label = "power:blue";
> -                       gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> -                       default-state = "keep";
> -               };
> -               power-red {
> -                       label = "power:red";
> -                       gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> -               };
> -               usb1 {
> -                       label = "usb1:blue";
> -                       gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               };
> -               usb2 {
> -                       label = "usb2:blue";
> -                       gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> -               };
> -               usb3 {
> -                       label = "usb3:blue";
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> -               };
> -               usb4 {
> -                       label = "usb4:blue";
> -                       gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> -               };
> -               otb {
> -                       label = "otb:blue";
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = < &pmx_button_reset &pmx_button_otb >;
> -               pinctrl-names = "default";
> -
> -               otb {
> -                       label = "OTB Button";
> -                       linux,code = <KEY_COPY>;
> -                       gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
> -                       debounce-interval = <100>;
> -               };
> -               reset {
> -                       label = "Reset";
> -                       linux,code = <KEY_RESTART>;
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> -                       debounce-interval = <100>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "uboot";
> -               reg = <0x0000000 0xc0000>;
> -       };
> -
> -       partition@a0000 {
> -               label = "env";
> -               reg = <0xa0000 0x20000>;
> -       };
> -
> -       partition@100000 {
> -               label = "zImage";
> -               reg = <0x100000 0x300000>;
> -       };
> -
> -       partition@540000 {
> -               label = "initrd";
> -               reg = <0x540000 0x300000>;
> -       };
> -
> -       partition@980000 {
> -               label = "boot";
> -               reg = <0x980000 0x1f400000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@11 {
> -               reg = <11>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&pciec {
> -        status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-is2.dts b/arch/arm/dts/kirkwood-is2.dts
> deleted file mode 100644
> index 1bc16a5cdb..0000000000
> --- a/arch/arm/dts/kirkwood-is2.dts
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/leds-ns2.h>
> -#include "kirkwood-ns2-common.dtsi"
> -
> -/ {
> -       model = "LaCie Internet Space v2";
> -       compatible = "lacie,inetspace_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_ns2_sata0>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -       };
> -
> -       ns2-leds {
> -               compatible = "lacie,ns2-leds";
> -
> -               blue-sata {
> -                       label = "ns2:blue:sata";
> -                       slow-gpio = <&gpio0 29 0>;
> -                       cmd-gpio = <&gpio0 30 0>;
> -                       modes-map = <NS_V2_LED_OFF  1 0
> -                                    NS_V2_LED_ON   0 1
> -                                    NS_V2_LED_ON   1 1
> -                                    NS_V2_LED_SATA 0 0>;
> -               };
> -       };
> -};
> -
> -&ethphy0 { reg = <8>; };
> diff --git a/arch/arm/dts/kirkwood-lschlv2.dts b/arch/arm/dts/kirkwood-lschlv2.dts
> deleted file mode 100644
> index 1d737d903f..0000000000
> --- a/arch/arm/dts/kirkwood-lschlv2.dts
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood-lsxl.dtsi"
> -
> -/ {
> -       model = "Buffalo Linkstation LS-CHLv2";
> -       compatible = "buffalo,lschlv2", "buffalo,lsxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x4000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-lsxhl.dts b/arch/arm/dts/kirkwood-lsxhl.dts
> deleted file mode 100644
> index a56e0d7977..0000000000
> --- a/arch/arm/dts/kirkwood-lsxhl.dts
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood-lsxl.dtsi"
> -
> -/ {
> -       model = "Buffalo Linkstation LS-XHL";
> -       compatible = "buffalo,lsxhl", "buffalo,lsxl", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-lsxl.dtsi b/arch/arm/dts/kirkwood-lsxl.dtsi
> deleted file mode 100644
> index c99c0da093..0000000000
> --- a/arch/arm/dts/kirkwood-lsxl.dtsi
> +++ /dev/null
> @@ -1,241 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       aliases {
> -               spi0 = &spi0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_power_hdd: pmx-power-hdd {
> -                               marvell,pins = "mpp10";
> -                               marvell,function = "gpo";
> -                       };
> -                       pmx_usb_vbus: pmx-usb-vbus {
> -                               marvell,pins = "mpp11";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_fan_high: pmx-fan-high {
> -                               marvell,pins = "mpp18";
> -                               marvell,function = "gpo";
> -                       };
> -                       pmx_fan_low: pmx-fan-low {
> -                               marvell,pins = "mpp19";
> -                               marvell,function = "gpo";
> -                       };
> -                       pmx_led_function_blue: pmx-led-function-blue {
> -                               marvell,pins = "mpp36";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_alarm: pmx-led-alarm {
> -                               marvell,pins = "mpp37";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_info: pmx-led-info {
> -                               marvell,pins = "mpp38";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_power: pmx-led-power {
> -                               marvell,pins = "mpp39";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_fan_lock: pmx-fan-lock {
> -                               marvell,pins = "mpp40";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_button_function: pmx-button-function {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_switch: pmx-power-switch {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_power_auto_switch: pmx-power-auto-switch {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_function_red: pmx-led-function_red {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -
> -               };
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -
> -               spi@10600 {
> -                       status = "okay";
> -
> -                       m25p40@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "m25p40", "jedec,spi-nor";
> -                               reg = <0>;
> -                               spi-max-frequency = <25000000>;
> -                               mode = <0>;
> -
> -                               partition@0 {
> -                                       reg = <0x0 0x60000>;
> -                                       label = "uboot";
> -                                       read-only;
> -                               };
> -
> -                               partition@60000 {
> -                                       reg = <0x60000 0x10000>;
> -                                       label = "dtb";
> -                                       read-only;
> -                               };
> -
> -                               partition@70000 {
> -                                       reg = <0x70000 0x10000>;
> -                                       label = "uboot_env";
> -                               };
> -                       };
> -               };
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_button_function &pmx_power_switch
> -                            &pmx_power_auto_switch>;
> -               pinctrl-names = "default";
> -
> -               option {
> -                       label = "Function Button";
> -                       linux,code = <KEY_OPTION>;
> -                       gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> -               };
> -               reserved {
> -                       label = "Power-on Switch";
> -                       linux,code = <KEY_RESERVED>;
> -                       linux,input-type = <5>;
> -                       gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> -               };
> -               power {
> -                       label = "Power-auto Switch";
> -                       linux,code = <KEY_ESC>;
> -                       linux,input-type = <5>;
> -                       gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio_leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_function_red &pmx_led_alarm
> -                            &pmx_led_info &pmx_led_power
> -                            &pmx_led_function_blue>;
> -               pinctrl-names = "default";
> -
> -               func_blue {
> -                       label = "lsxl:blue:func";
> -                       gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               alarm {
> -                       label = "lsxl:red:alarm";
> -                       gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               info {
> -                       label = "lsxl:amber:info";
> -                       gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               power {
> -                       label = "lsxl:blue:power";
> -                       gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -
> -               func_red {
> -                       label = "lsxl:red:func";
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio_fan {
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 19 GPIO_ACTIVE_LOW
> -                        &gpio0 18 GPIO_ACTIVE_LOW>;
> -               gpio-fan,speed-map = <0    3
> -                                     1500 2
> -                                     3250 1
> -                                     5000 0>;
> -               alarm-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       restart_poweroff {
> -               compatible = "restart-poweroff";
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_power_hdd &pmx_usb_vbus>;
> -               pinctrl-names = "default";
> -
> -               usb_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 11 0>;
> -               };
> -               hdd_power: regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "HDD Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 10 0>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -
> -       ethphy1: ethernet-phy@8 {
> -               reg = <8>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&eth1 {
> -       status = "okay";
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-net2big.dts b/arch/arm/dts/kirkwood-net2big.dts
> deleted file mode 100644
> index 3e3ac289e5..0000000000
> --- a/arch/arm/dts/kirkwood-net2big.dts
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree file for LaCie 2Big Network v2
> - *
> - * Copyright (C) 2014
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * Based on netxbig_v2-setup.c,
> - * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> - *
> -*/
> -
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -#include "kirkwood-netxbig.dtsi"
> -
> -/ {
> -       model = "LaCie 2Big Network v2";
> -       compatible = "lacie,net2big_v2", "lacie,netxbig", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       fan {
> -               compatible = "gpio-fan";
> -               alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -       };
> -};
> -
> -&regulators {
> -       regulator@2 {
> -               compatible = "regulator-fixed";
> -               reg = <2>;
> -               regulator-name = "hdd1power";
> -               regulator-min-microvolt = <5000000>;
> -               regulator-max-microvolt = <5000000>;
> -               enable-active-high;
> -               regulator-always-on;
> -               regulator-boot-on;
> -               gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       clocks {
> -              g762_clk: g762-oscillator {
> -                        compatible = "fixed-clock";
> -                        #clock-cells = <0>;
> -                        clock-frequency = <32768>;
> -              };
> -       };
> -};
> -
> -&i2c0 {
> -       g762@3e {
> -               compatible = "gmt,g762";
> -               reg = <0x3e>;
> -               clocks = <&g762_clk>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-netxbig.dtsi b/arch/arm/dts/kirkwood-netxbig.dtsi
> deleted file mode 100644
> index b5737026e2..0000000000
> --- a/arch/arm/dts/kirkwood-netxbig.dtsi
> +++ /dev/null
> @@ -1,232 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device Tree common file for LaCie 2Big and 5Big Network v2
> - *
> - * Copyright (C) 2014
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * Based on netxbig_v2-setup.c,
> - * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
> - *
> -*/
> -
> -#include <dt-bindings/leds/leds-netxbig.h>
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -
> -               spi@10600 {
> -                       status = "okay";
> -
> -                       flash@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "mxicy,mx25l4005a", "jedec,spi-nor";
> -                               reg = <0>;
> -                               spi-max-frequency = <20000000>;
> -                               mode = <0>;
> -
> -                               partition@0 {
> -                                       reg = <0x0 0x80000>;
> -                                       label = "u-boot";
> -                               };
> -                       };
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -
> -       };
> -
> -       gpio-keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               /*
> -                * esc and power represent a three position rocker
> -                * switch. Thus the conventional KEY_POWER does not fit
> -                */
> -               exc {
> -                       label = "Back power switch (on|auto)";
> -                       linux,code = <KEY_ESC>;
> -                       linux,input-type = <5>;
> -                       gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> -               };
> -               power {
> -                       label = "Back power switch (auto|off)";
> -                       linux,code = <KEY_1>;
> -                       linux,input-type = <5>;
> -                       gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> -               };
> -               option {
> -                       label = "Function button";
> -                       linux,code = <KEY_OPTION>;
> -                       gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> -               };
> -
> -       };
> -
> -       gpio-poweroff {
> -               compatible = "gpio-poweroff";
> -               gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       regulators: regulators {
> -               status = "okay";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd0power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       netxbig_gpio_ext: netxbig-gpio-ext {
> -               compatible = "lacie,netxbig-gpio-ext";
> -
> -               addr-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH
> -                             &gpio1 16 GPIO_ACTIVE_HIGH
> -                             &gpio1 17 GPIO_ACTIVE_HIGH>;
> -               data-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH
> -                             &gpio1 13 GPIO_ACTIVE_HIGH
> -                             &gpio1 14 GPIO_ACTIVE_HIGH>;
> -               enable-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       netxbig-leds {
> -               compatible = "lacie,netxbig-leds";
> -
> -               gpio-ext = <&netxbig_gpio_ext>;
> -
> -               timers = <NETXBIG_LED_TIMER1 500 500
> -                         NETXBIG_LED_TIMER2 500 1000>;
> -
> -               blue-power {
> -                       label = "netxbig:blue:power";
> -                       mode-addr = <0>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 1
> -                                   NETXBIG_LED_TIMER1 3
> -                                   NETXBIG_LED_TIMER2 7>;
> -                       bright-addr = <1>;
> -                       max-brightness = <7>;
> -               };
> -               red-power {
> -                       label = "netxbig:red:power";
> -                       mode-addr = <0>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 2
> -                                   NETXBIG_LED_TIMER1 4>;
> -                       bright-addr = <1>;
> -                       max-brightness = <7>;
> -               };
> -               blue-sata0 {
> -                       label = "netxbig:blue:sata0";
> -                       mode-addr = <3>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 7
> -                                   NETXBIG_LED_SATA 1
> -                                   NETXBIG_LED_TIMER1 3>;
> -                       bright-addr = <2>;
> -                       max-brightness = <7>;
> -               };
> -               red-sata0 {
> -                       label = "netxbig:red:sata0";
> -                       mode-addr = <3>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 2
> -                                   NETXBIG_LED_TIMER1 4>;
> -                       bright-addr = <2>;
> -                       max-brightness = <7>;
> -               };
> -               blue-sata1 {
> -                       label = "netxbig:blue:sata1";
> -                       mode-addr = <4>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 7
> -                                   NETXBIG_LED_SATA 1
> -                                   NETXBIG_LED_TIMER1 3>;
> -                       bright-addr = <2>;
> -                       max-brightness = <7>;
> -               };
> -               red-sata1 {
> -                       label = "netxbig:red:sata1";
> -                       mode-addr = <4>;
> -                       mode-val = <NETXBIG_LED_OFF 0
> -                                   NETXBIG_LED_ON 2
> -                                   NETXBIG_LED_TIMER1 4>;
> -                       bright-addr = <2>;
> -                       max-brightness = <7>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <8>;
> -       };
> -
> -       ethphy1: ethernet-phy@1 {
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&pinctrl {
> -       pinctrl-names = "default";
> -
> -       pmx_button_function: pmx-button-function {
> -               marvell,pins = "mpp34";
> -               marvell,function = "gpio";
> -       };
> -       pmx_button_power_off: pmx-button-power-off {
> -               marvell,pins = "mpp15";
> -               marvell,function = "gpio";
> -       };
> -       pmx_button_power_on: pmx-button-power-on {
> -               marvell,pins = "mpp13";
> -               marvell,function = "gpio";
> -       };
> -};
> -
> -&i2c0 {
> -       status = "okay";
> -
> -       eeprom@50 {
> -               compatible = "atmel,24c04";
> -               pagesize = <16>;
> -               reg = <0x50>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-ns2-common.dtsi b/arch/arm/dts/kirkwood-ns2-common.dtsi
> deleted file mode 100644
> index 51530ea866..0000000000
> --- a/arch/arm/dts/kirkwood-ns2-common.dtsi
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_ns2_sata0: pmx-ns2-sata0 {
> -                               marvell,pins = "mpp21";
> -                               marvell,function = "sata0";
> -                       };
> -                       pmx_ns2_sata1: pmx-ns2-sata1 {
> -                               marvell,pins = "mpp20";
> -                               marvell,function = "sata1";
> -                       };
> -               };
> -
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -
> -               spi@10600 {
> -                       status = "okay";
> -
> -                       flash@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "mxicy,mx25l4005a", "jedec,spi-nor";
> -                               reg = <0>;
> -                               spi-max-frequency = <20000000>;
> -                               mode = <0>;
> -
> -                               partition@0 {
> -                                       reg = <0x0 0x80000>;
> -                                       label = "u-boot";
> -                               };
> -                       };
> -               };
> -
> -               i2c@11000 {
> -                       status = "okay";
> -
> -                       eeprom@50 {
> -                               compatible = "atmel,24c04";
> -                               pagesize = <16>;
> -                               reg = <0x50>;
> -                       };
> -               };
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               power {
> -                       label = "Power push button";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -
> -               red-fail {
> -                       label = "ns2:red:fail";
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               gpios = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@X {
> -                /* overwrite reg property in board file */
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-ns2.dts b/arch/arm/dts/kirkwood-ns2.dts
> deleted file mode 100644
> index 7b67083e1e..0000000000
> --- a/arch/arm/dts/kirkwood-ns2.dts
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/leds-ns2.h>
> -#include "kirkwood-ns2-common.dtsi"
> -
> -/ {
> -       model = "LaCie Network Space v2";
> -       compatible = "lacie,netspace_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_ns2_sata0>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -       };
> -
> -       ns2-leds {
> -               compatible = "lacie,ns2-leds";
> -
> -               blue-sata {
> -                       label = "ns2:blue:sata";
> -                       slow-gpio = <&gpio0 29 0>;
> -                       cmd-gpio = <&gpio0 30 0>;
> -                       modes-map = <NS_V2_LED_OFF  1 0
> -                                    NS_V2_LED_ON   0 1
> -                                    NS_V2_LED_ON   1 1
> -                                    NS_V2_LED_SATA 0 0>;
> -               };
> -       };
> -};
> -
> -&ethphy0 { reg = <8>; };
> diff --git a/arch/arm/dts/kirkwood-ns2lite.dts b/arch/arm/dts/kirkwood-ns2lite.dts
> deleted file mode 100644
> index b0cb5907ed..0000000000
> --- a/arch/arm/dts/kirkwood-ns2lite.dts
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include "kirkwood-ns2-common.dtsi"
> -
> -/ {
> -       model = "LaCie Network Space Lite v2";
> -       compatible = "lacie,netspace_lite_v2", "marvell,kirkwood-88f6192", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_ns2_sata0>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -
> -               blue-sata {
> -                       label = "ns2:blue:sata";
> -                       gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
> -                       linux,default-trigger = "disk-activity";
> -               };
> -       };
> -};
> -
> -&ethphy0 { reg = <0>; };
> diff --git a/arch/arm/dts/kirkwood-ns2max.dts b/arch/arm/dts/kirkwood-ns2max.dts
> deleted file mode 100644
> index c0a087e774..0000000000
> --- a/arch/arm/dts/kirkwood-ns2max.dts
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/leds-ns2.h>
> -#include "kirkwood-ns2-common.dtsi"
> -
> -/ {
> -       model = "LaCie Network Space Max v2";
> -       compatible = "lacie,netspace_max_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_ns2_sata0 &pmx_ns2_sata1>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -       };
> -
> -       gpio_fan {
> -               compatible = "gpio-fan";
> -               gpios = <&gpio0 22 GPIO_ACTIVE_LOW
> -                        &gpio0  7 GPIO_ACTIVE_LOW
> -                        &gpio1  1 GPIO_ACTIVE_LOW
> -                        &gpio0 23 GPIO_ACTIVE_LOW>;
> -               gpio-fan,speed-map =
> -                       <   0  0
> -                        1500 15
> -                        1700 14
> -                        1800 13
> -                        2100 12
> -                        3100 11
> -                        3300 10
> -                        4300  9
> -                        5500  8>;
> -               alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -       };
> -
> -       ns2-leds {
> -               compatible = "lacie,ns2-leds";
> -
> -               blue-sata {
> -                       label = "ns2:blue:sata";
> -                       slow-gpio = <&gpio0 29 0>;
> -                       cmd-gpio = <&gpio0 30 0>;
> -                       modes-map = <NS_V2_LED_OFF  1 0
> -                                    NS_V2_LED_ON   0 1
> -                                    NS_V2_LED_ON   1 1
> -                                    NS_V2_LED_SATA 0 0>;
> -               };
> -       };
> -};
> -
> -&ethphy0 { reg = <8>; };
> diff --git a/arch/arm/dts/kirkwood-ns2mini.dts b/arch/arm/dts/kirkwood-ns2mini.dts
> deleted file mode 100644
> index 5b9fa14b64..0000000000
> --- a/arch/arm/dts/kirkwood-ns2mini.dts
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/dts-v1/;
> -
> -#include <dt-bindings/leds/leds-ns2.h>
> -#include "kirkwood-ns2-common.dtsi"
> -
> -/ {
> -       /* This machine is embedded in the first LaCie CloudBox product. */
> -       model = "LaCie Network Space Mini v2";
> -       compatible = "lacie,netspace_mini_v2", "marvell,kirkwood-88f6192", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x8000000>;
> -       };
> -
> -       ocp@f1000000 {
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_ns2_sata0>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -       };
> -
> -       gpio_fan {
> -               compatible = "gpio-fan";
> -               gpios = <&gpio0 22 GPIO_ACTIVE_LOW
> -                        &gpio0  7 GPIO_ACTIVE_LOW
> -                        &gpio1  1 GPIO_ACTIVE_LOW
> -                        &gpio0 23 GPIO_ACTIVE_LOW>;
> -               gpio-fan,speed-map =
> -                       <   0  0
> -                        3000 15
> -                        3180 14
> -                        4140 13
> -                        4570 12
> -                        6760 11
> -                        7140 10
> -                        7980  9
> -                        9200  8>;
> -               alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -       };
> -
> -       ns2-leds {
> -               compatible = "lacie,ns2-leds";
> -
> -               blue-sata {
> -                       label = "ns2:blue:sata";
> -                       slow-gpio = <&gpio0 29 0>;
> -                       cmd-gpio = <&gpio0 30 0>;
> -                       modes-map = <NS_V2_LED_OFF  1 0
> -                                    NS_V2_LED_ON   0 1
> -                                    NS_V2_LED_ON   1 1
> -                                    NS_V2_LED_SATA 0 0>;
> -               };
> -       };
> -};
> -
> -&ethphy0 { reg = <0>; };
> diff --git a/arch/arm/dts/kirkwood-nsa310s.dts b/arch/arm/dts/kirkwood-nsa310s.dts
> deleted file mode 100644
> index 09ee76c2a2..0000000000
> --- a/arch/arm/dts/kirkwood-nsa310s.dts
> +++ /dev/null
> @@ -1,319 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Device tree file for the Zyxel NSA 310S NAS box.
> - *
> - * Copyright (c) 2015-2021, Tony Dinh <mibodhi@gmail.com>
> - *
> - * Based on
> - * Copyright (c) 2014, Adam Baker <linux@baker-net.org.uk>
> - * Based upon the board setup file created by Peter Schildmann
> - */
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Zyxel NSA310S";
> -       compatible = "zyxel,nsa320s", "marvell,kirkwood-88f6702", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pinctrl-names = "default";
> -
> -                       pmx_sata0: pmx-sata0 {
> -                               marvell,pins ;
> -                               marvell,function = "sata0";
> -                       };
> -
> -                       pmx_sata1: pmx-sata1 {
> -                               marvell,pins ;
> -                               marvell,function = "sata1";
> -                       };
> -
> -                       pmx_usb_power: pmx-usb-power {
> -                               marvell,pins = "mpp21";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_pwr_off: pmx-pwr-off {
> -                               marvell,pins = "mpp27";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_reset: pmx-btn-reset {
> -                               marvell,pins = "mpp24";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_copy: pmx-btn-copy {
> -                               marvell,pins = "mpp25";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_power: pmx-btn-power {
> -                               marvell,pins = "mpp26";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd2_green: pmx-led-hdd2-green {
> -                               marvell,pins = "mpp34";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd2_red: pmx-led-hdd2-red {
> -                               marvell,pins = "mpp12";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_usb_green: pmx-led-usb-green {
> -                               marvell,pins = "mpp15";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_copy_green: pmx-led-copy-green {
> -                               marvell,pins = "mpp22";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_copy_red: pmx-led-copy-red {
> -                               marvell,pins = "mpp23";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_sys_green: pmx-led-sys-green {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_sys_orange: pmx-led-sys-orange {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd1_green: pmx-led-hdd1-green {
> -                               marvell,pins = "mpp16";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd1_red: pmx-led-hdd1-red {
> -                               marvell,pins = "mpp13";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_pwr_sata1: pmx-pwr-sata1 {
> -                               marvell,pins = "mpp33";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -
> -               serial@12000 {
> -                       status = "ok";
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <1>;
> -               };
> -
> -               rtc@10300 {
> -                       status = "disabled";
> -               };
> -
> -               i2c@11000 {
> -                       status = "okay";
> -                       ht1382: rtc@68 {
> -                               compatible = "htk,ht1382";
> -                               reg = <0x68>;
> -                       };
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pmx_usb_power &pmx_pwr_sata1>;
> -
> -               usb0_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       enable-active-high;
> -                       gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               sata1_power: regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "SATA1 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       enable-active-high;
> -                       gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               pinctrl-0 = <&pmx_pwr_off>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
> -               pinctrl-names = "default";
> -
> -               button@1 {
> -                       label = "Power Button";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> -               };
> -               button@2 {
> -                       label = "Copy Button";
> -                       linux,code = <KEY_COPY>;
> -                       gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -               };
> -               button@3 {
> -                       label = "Reset Button";
> -                       linux,code = <KEY_RESTART>;
> -                       gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
> -                            &pmx_led_usb_green
> -                            &pmx_led_sys_green &pmx_led_sys_orange
> -                            &pmx_led_copy_green &pmx_led_copy_red
> -                            &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> -               pinctrl-names = "default";
> -
> -               green-sys {
> -                       label = "nsa310s:green:sys";
> -                       gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> -                       linux,default-trigger = "default-on";
> -               };
> -               orange-sys {
> -                       label = "nsa310s:orange:sys";
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-hdd1 {
> -                       label = "nsa310s:green:hdd1";
> -                       gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> -               };
> -               red-hdd1 {
> -                       label = "nsa310s:red:hdd1";
> -                       gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-hdd2 {
> -                       label = "nsa310s:green:hdd2";
> -                       gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -               };
> -               red-hdd2 {
> -                       label = "nsa310s:red:hdd2";
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-usb {
> -                       label = "nsa310s:green:usb";
> -                       gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-copy {
> -                       label = "nsa310s:green:copy";
> -                       gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>;
> -                       linux,default-trigger = "ide-disk";
> -               };
> -               red-copy {
> -                       label = "nsa310s:red:copy";
> -                       gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -       chip-delay = <35>;
> -
> -       partition@0 {
> -               label = "uboot";
> -               reg = <0x0000000 0x0100000>;
> -       };
> -       partition@100000 {
> -               label = "stock_uboot_env";
> -               reg = <0x0100000 0x0080000>;
> -       };
> -       partition@180000 {
> -               label = "key_store";
> -               reg = <0x0180000 0x0080000>;
> -       };
> -       partition@200000 {
> -               label = "info";
> -               reg = <0x0200000 0x0080000>;
> -       };
> -       partition@280000 {
> -               label = "etc";
> -               reg = <0x0280000 0x0a00000>;
> -       };
> -       partition@c80000 {
> -               label = "kernel_1";
> -               reg = <0x0c80000 0x0a00000>;
> -       };
> -       partition@1680000 {
> -               label = "rootfs1";
> -               reg = <0x1680000 0x2fc0000>;
> -       };
> -       partition@4640000 {
> -               label = "kernel_2";
> -               reg = <0x4640000 0x0a00000>;
> -       };
> -       partition@5040000 {
> -               label = "rootfs2";
> -               reg = <0x5040000 0x2fc0000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -       ethphy0: ethernet-phy@1 {
> -               compatible = "marvell,88e1510";
> -               reg = <1>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -               phy-mode = "rgmii";
> -       };
> -};
> -
> -&pciec {
> -       status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-nsa325.dts b/arch/arm/dts/kirkwood-nsa325.dts
> deleted file mode 100644
> index efc57cfa41..0000000000
> --- a/arch/arm/dts/kirkwood-nsa325.dts
> +++ /dev/null
> @@ -1,231 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/* Device tree file for the Zyxel NSA 325 NAS box.
> - *
> - * Copyright (c) 2015, Hans Ulli Kroll <ulli.kroll@googlemail.com>
> - *
> - *
> - * Based upon the board setup file created by Peter Schildmann
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood-nsa3x0-common.dtsi"
> -
> -/ {
> -       model = "ZyXEL NSA325";
> -       compatible = "zyxel,nsa325", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x20000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pinctrl-names = "default";
> -
> -                       pmx_led_hdd2_green: pmx-led-hdd2-green {
> -                               marvell,pins = "mpp12";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd2_red: pmx-led-hdd2-red {
> -                               marvell,pins = "mpp13";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_mcu_data: pmx-mcu-data {
> -                               marvell,pins = "mpp14";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_usb_green: pmx-led-usb-green {
> -                               marvell,pins = "mpp15";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_mcu_clk: pmx-mcu-clk {
> -                               marvell,pins = "mpp16";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_mcu_act: pmx-mcu-act {
> -                               marvell,pins = "mpp17";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_sys_green: pmx-led-sys-green {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_sys_orange: pmx-led-sys-orange {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd1_green: pmx-led-hdd1-green {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_hdd1_red: pmx-led-hdd1-red {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_htp: pmx-htp {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       /*
> -                        * Buzzer needs to be switched at around 1kHz so is
> -                        * not compatible with the gpio-beeper driver.
> -                        */
> -                       pmx_buzzer: pmx-buzzer {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_vid_b1: pmx-vid-b1 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_power_resume_data: pmx-power-resume-data {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_power_resume_clk: pmx-power-resume-clk {
> -                               marvell,pins = "mpp49";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_pwr_sata1: pmx-pwr-sata1 {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -
> -               /* This board uses the pcf8563 RTC instead of the SoC RTC */
> -               rtc@10300 {
> -                       status = "disabled";
> -               };
> -
> -               i2c@11000 {
> -                       status = "okay";
> -
> -                       pcf8563: pcf8563@51 {
> -                               compatible = "nxp,pcf8563";
> -                               reg = <0x51>;
> -                       };
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_pwr_sata1>;
> -               pinctrl-names = "default";
> -
> -               usb0_power: regulator@1 {
> -                       enable-active-high;
> -               };
> -
> -               sata1_power: regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "SATA1 Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       enable-active-high;
> -                       gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_hdd2_green &pmx_led_hdd2_red
> -                            &pmx_led_usb_green
> -                            &pmx_led_sys_green &pmx_led_sys_orange
> -                            &pmx_led_copy_green &pmx_led_copy_red
> -                            &pmx_led_hdd1_green &pmx_led_hdd1_red>;
> -               pinctrl-names = "default";
> -
> -               green-sys {
> -                       label = "nsa325:green:sys";
> -                       gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> -               };
> -               orange-sys {
> -                       label = "nsa325:orange:sys";
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-hdd1 {
> -                       label = "nsa325:green:hdd1";
> -                       gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> -               };
> -               red-hdd1 {
> -                       label = "nsa325:red:hdd1";
> -                       gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-hdd2 {
> -                       label = "nsa325:green:hdd2";
> -                       gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -               };
> -               red-hdd2 {
> -                       label = "nsa325:red:hdd2";
> -                       gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-usb {
> -                       label = "nsa325:green:usb";
> -                       gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> -               };
> -               green-copy {
> -                       label = "nsa325:green:copy";
> -                       gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> -               };
> -               red-copy {
> -                       label = "nsa325:red:copy";
> -                       gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -       /* The following pins are currently not assigned to a driver,
> -          some of them should be configured as inputs.
> -       pinctrl-0 = <&pmx_mcu_data &pmx_mcu_clk &pmx_mcu_act
> -                    &pmx_htp &pmx_vid_b1
> -                    &pmx_power_resume_data &pmx_power_resume_clk>; */
> -       };
> -
> -};
> -
> -&mdio {
> -       status = "okay";
> -       ethphy0: ethernet-phy@1 {
> -               reg = <1>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&pciec {
> -       status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> deleted file mode 100644
> index a21c50d44a..0000000000
> --- a/arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "ZyXEL NSA310";
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -
> -                       pmx_usb_power: pmx-usb-power {
> -                               marvell,pins = "mpp21";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_pwr_off: pmx-pwr-off {
> -                               marvell,pins = "mpp48";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_reset: pmx-btn-reset {
> -                               marvell,pins = "mpp36";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_copy: pmx-btn-copy {
> -                               marvell,pins = "mpp37";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_btn_power: pmx-btn-power {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_copy_green: pmx-led-copy-green {
> -                               marvell,pins = "mpp39";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_led_copy_red: pmx-led-copy-red {
> -                               marvell,pins = "mpp40";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -       };
> -
> -       gpio_poweroff {
> -               compatible = "gpio-poweroff";
> -               pinctrl-0 = <&pmx_pwr_off>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_btn_reset &pmx_btn_copy &pmx_btn_power>;
> -               pinctrl-names = "default";
> -
> -               power {
> -                       label = "Power Button";
> -                       linux,code = <KEY_POWER>;
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> -               };
> -               copy {
> -                       label = "Copy Button";
> -                       linux,code = <KEY_COPY>;
> -                       gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> -               };
> -               reset {
> -                       label = "Reset Button";
> -                       linux,code = <KEY_RESTART>;
> -                       gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_usb_power>;
> -               pinctrl-names = "default";
> -
> -               usb0_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -       chip-delay = <35>;
> -
> -       partition@0 {
> -               label = "uboot";
> -               reg = <0x0000000 0x0100000>;
> -       };
> -       partition@100000 {
> -               label = "uboot_env";
> -               reg = <0x0100000 0x0080000>;
> -       };
> -       partition@180000 {
> -               label = "key_store";
> -               reg = <0x0180000 0x0080000>;
> -       };
> -       partition@200000 {
> -               label = "info";
> -               reg = <0x0200000 0x0080000>;
> -       };
> -       partition@280000 {
> -               label = "etc";
> -               reg = <0x0280000 0x0a00000>;
> -       };
> -       partition@c80000 {
> -               label = "kernel_1";
> -               reg = <0x0c80000 0x0a00000>;
> -       };
> -       partition@1680000 {
> -               label = "rootfs1";
> -               reg = <0x1680000 0x2fc0000>;
> -       };
> -       partition@4640000 {
> -               label = "kernel_2";
> -               reg = <0x4640000 0x0a00000>;
> -       };
> -       partition@5040000 {
> -               label = "rootfs2";
> -               reg = <0x5040000 0x2fc0000>;
> -       };
> -};
> -
> -&pciec {
> -       status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-openrd-base.dts b/arch/arm/dts/kirkwood-openrd-base.dts
> deleted file mode 100644
> index 094191ece3..0000000000
> --- a/arch/arm/dts/kirkwood-openrd-base.dts
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Marvell OpenRD Base Board Description
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * This file contains the definitions that are specific to OpenRD
> - * base variant of the Marvell Kirkwood Development Board.
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood-openrd.dtsi"
> -
> -/ {
> -       model = "OpenRD Base";
> -       compatible = "marvell,openrd-base", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       ocp@f1000000 {
> -               serial@12100 {
> -                       status = "okay";
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@8 {
> -               reg = <8>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-openrd-client.dts b/arch/arm/dts/kirkwood-openrd-client.dts
> deleted file mode 100644
> index 74dc23daf6..0000000000
> --- a/arch/arm/dts/kirkwood-openrd-client.dts
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Marvell OpenRD Client Board Description
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * This file contains the definitions that are specific to OpenRD
> - * client variant of the Marvell Kirkwood Development Board.
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood-openrd.dtsi"
> -
> -/ {
> -       model = "OpenRD Client";
> -       compatible = "marvell,openrd-client", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       ocp@f1000000 {
> -               audio-controller@a0000 {
> -                       status = "okay";
> -               };
> -               i2c@11000 {
> -                       status = "okay";
> -                       clock-frequency = <400000>;
> -
> -                       cs42l51: cs42l51@4a {
> -                               compatible = "cirrus,cs42l51";
> -                               reg = <0x4a>;
> -                               #sound-dai-cells = <0>;
> -                       };
> -               };
> -       };
> -
> -       sound {
> -               compatible = "simple-audio-card";
> -               simple-audio-card,format = "i2s";
> -               simple-audio-card,mclk-fs = <256>;
> -
> -               simple-audio-card,cpu {
> -                       sound-dai = <&audio0 0>;
> -               };
> -
> -               simple-audio-card,codec {
> -                       sound-dai = <&cs42l51>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@8 {
> -               reg = <8>;
> -       };
> -       ethphy1: ethernet-phy@24 {
> -               reg = <24>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&eth1 {
> -       status = "okay";
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-openrd-ultimate.dts b/arch/arm/dts/kirkwood-openrd-ultimate.dts
> deleted file mode 100644
> index 888e13320c..0000000000
> --- a/arch/arm/dts/kirkwood-openrd-ultimate.dts
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Marvell OpenRD Ultimate Board Description
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * This file contains the definitions that are specific to OpenRD
> - * ultimate variant of the Marvell Kirkwood Development Board.
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood-openrd.dtsi"
> -
> -/ {
> -       model = "OpenRD Ultimate";
> -       compatible = "marvell,openrd-ultimate", "marvell,openrd", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       ocp@f1000000 {
> -               i2c@11000 {
> -                       status = "okay";
> -                       clock-frequency = <400000>;
> -
> -                       cs42l51: cs42l51@4a {
> -                               compatible = "cirrus,cs42l51";
> -                               reg = <0x4a>;
> -                       };
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -       ethphy1: ethernet-phy@1 {
> -               reg = <1>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&eth1 {
> -       status = "okay";
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-openrd.dtsi b/arch/arm/dts/kirkwood-openrd.dtsi
> deleted file mode 100644
> index 47f03c69c5..0000000000
> --- a/arch/arm/dts/kirkwood-openrd.dtsi
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Marvell OpenRD (Base|Client|Ultimate) Board Description
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - *
> - * This file contains the definitions that are common between the three
> - * variants of the Marvell Kirkwood Development Board.
> - */
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x20000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
> -                       pinctrl-names = "default";
> -
> -                       pmx_select28: pmx-select-rs232-rs485 {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_sdio_cd: pmx-sdio-cd {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_select34: pmx-select-uart-sd {
> -                               marvell,pins = "mpp34";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "okay";
> -
> -               };
> -               sata@80000 {
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -               mvsdio@90000 {
> -                       status = "okay";
> -                       cd-gpios = <&gpio0 29 9>;
> -               };
> -               gpio@10100 {
> -                       p28 {
> -                               gpio-hog;
> -                               gpios = <28 GPIO_ACTIVE_HIGH>;
> -                               /*
> -                                * SelRS232or485 selects between RS-232 or RS-485
> -                                * mode for the second UART.
> -                                *
> -                                * Low: RS-232
> -                                * High: RS-485
> -                                *
> -                                * To use the second UART, you need to change also
> -                                * the SelUARTorSD.
> -                                */
> -                               output-low;
> -                               line-name = "SelRS232or485";
> -                       };
> -               };
> -               gpio@10140 {
> -                       p2 {
> -                               gpio-hog;
> -                               gpios = <2 GPIO_ACTIVE_HIGH>;
> -                               /*
> -                                * SelUARTorSD selects between the second UART
> -                                * (serial@12100) and SD (mvsdio@90000).
> -                                *
> -                                * Low: UART
> -                                * High: SD
> -                                *
> -                                * When changing this line make sure the newly
> -                                * selected device node is enabled and the
> -                                * previously selected device node is disabled.
> -                                */
> -                               output-high; /* Select SD by default */
> -                               line-name = "SelUARTorSD";
> -                       };
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -       pinctrl-0 = <&pmx_nand>;
> -       pinctrl-names = "default";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x400000>;
> -       };
> -
> -       partition@600000 {
> -               label = "root";
> -               reg = <0x0600000 0x1FA00000>;
> -       };
> -};
> -
> -&pciec {
> -       status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood-pogo_e02.dts b/arch/arm/dts/kirkwood-pogo_e02.dts
> deleted file mode 100644
> index f9e95e55f3..0000000000
> --- a/arch/arm/dts/kirkwood-pogo_e02.dts
> +++ /dev/null
> @@ -1,132 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * kirkwood-pogo_e02.dts - Device tree file for Pogoplug E02
> - *
> - * Copyright (C) 2015 Christoph Junghans <ottxor@gentoo.org>
> - *
> - * based on information of dts files from
> - *  Arch Linux ARM by Oleg Rakhmanov <moonman.ca@gmail.com>
> - *  OpenWrt by Felix Kaechele <heffer@fedoraproject.org>
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       model = "Cloud Engines Pogoplug E02";
> -       compatible = "cloudengines,pogoe02", "marvell,kirkwood-88f6281",
> -                    "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x10000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8";
> -               stdout-path = &uart0;
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -
> -               health {
> -                       label = "pogo_e02:green:health";
> -                       gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -               fault {
> -                       label = "pogo_e02:orange:fault";
> -                       gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_usb_power_enable>;
> -               pinctrl-names = "default";
> -
> -               usb_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> -
> -&pinctrl {
> -       pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
> -                     &pmx_led_green >;
> -       pinctrl-names = "default";
> -
> -       pmx_usb_power_enable: pmx-usb-power-enable {
> -               marvell,pins = "mpp29";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_led_green: pmx-led-green {
> -               marvell,pins = "mpp48";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_led_orange: pmx-led-orange {
> -               marvell,pins = "mpp49";
> -               marvell,function = "gpio";
> -       };
> -};
> -
> -&uart0 {
> -       status = "okay";
> -};
> -
> -&nand {
> -       chip-delay = <40>;
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -               read-only;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x400000>;
> -       };
> -
> -       partition@500000 {
> -               label = "pogoplug";
> -               reg = <0x0500000 0x2000000>;
> -       };
> -
> -       partition@2500000 {
> -               label = "root";
> -               reg = <0x02500000 0x5b00000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/dts/kirkwood-pogoplug-series-4.dts
> deleted file mode 100644
> index 5aa4669ae2..0000000000
> --- a/arch/arm/dts/kirkwood-pogoplug-series-4.dts
> +++ /dev/null
> @@ -1,180 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * kirkwood-pogoplug-series-4.dts - Device tree file for PogoPlug Series 4
> - * inspired by the board files made by Kevin Mihelich for ArchLinux,
> - * and their DTS file.
> - *
> - * Copyright (C) 2015 Linus Walleij <linus.walleij@linaro.org>
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6192.dtsi"
> -#include <dt-bindings/input/linux-event-codes.h>
> -
> -/ {
> -       model = "Cloud Engines PogoPlug Series 4";
> -       compatible = "cloudengines,pogoplugv4", "marvell,kirkwood-88f6192",
> -                    "marvell,kirkwood";
> -
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x08000000>;
> -       };
> -
> -       chosen {
> -               stdout-path = "uart0:115200n8";
> -       };
> -
> -       gpio_keys {
> -               compatible = "gpio-keys";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_button_eject>;
> -               pinctrl-names = "default";
> -
> -               eject {
> -                       debounce-interval = <50>;
> -                       wakeup-source;
> -                       linux,code = <KEY_EJECTCD>;
> -                       label = "Eject Button";
> -                       gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_green &pmx_led_red>;
> -               pinctrl-names = "default";
> -
> -               health {
> -                       label = "pogoplugv4:green:health";
> -                       gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> -                       default-state = "on";
> -               };
> -               fault {
> -                       label = "pogoplugv4:red:fault";
> -                       gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> -
> -&pinctrl {
> -       pmx_sata0: pmx-sata0 {
> -               marvell,pins = "mpp21";
> -               marvell,function = "sata0";
> -       };
> -
> -       pmx_sata1: pmx-sata1 {
> -               marvell,pins = "mpp20";
> -               marvell,function = "sata1";
> -       };
> -
> -       pmx_sdio_cd: pmx-sdio-cd {
> -               marvell,pins = "mpp27";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_sdio_wp: pmx-sdio-wp {
> -               marvell,pins = "mpp28";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_button_eject: pmx-button-eject {
> -               marvell,pins = "mpp29";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_led_green: pmx-led-green {
> -               marvell,pins = "mpp22";
> -               marvell,function = "gpio";
> -       };
> -
> -       pmx_led_red: pmx-led-red {
> -               marvell,pins = "mpp24";
> -               marvell,function = "gpio";
> -       };
> -};
> -
> -&uart0 {
> -       status = "okay";
> -};
> -
> -/*
> - * This PCIE controller has a USB 3.0 XHCI controller at 1,0
> - */
> -&pciec {
> -       status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> -
> -&sata {
> -       status = "okay";
> -       pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> -       pinctrl-names = "default";
> -       nr-ports = <1>;
> -};
> -
> -&sdio {
> -       status = "okay";
> -       pinctrl-0 = <&pmx_sdio &pmx_sdio_cd &pmx_sdio_wp>;
> -       pinctrl-names = "default";
> -       cd-gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
> -       wp-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&nand {
> -       /* 128 MiB of NAND flash */
> -       chip-delay = <40>;
> -       status = "okay";
> -       partitions {
> -               compatible = "fixed-partitions";
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -
> -               partition@0 {
> -                       label = "u-boot";
> -                       reg = <0x00000000 0x200000>;
> -                       read-only;
> -               };
> -
> -               partition@200000 {
> -                       label = "uImage";
> -                       reg = <0x00200000 0x300000>;
> -               };
> -
> -               partition@500000 {
> -                       label = "uImage2";
> -                       reg = <0x00500000 0x300000>;
> -               };
> -
> -               partition@800000 {
> -                       label = "failsafe";
> -                       reg = <0x00800000 0x800000>;
> -               };
> -
> -               partition@1000000 {
> -                       label = "root";
> -                       reg = <0x01000000 0x7000000>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/dts/kirkwood-sheevaplug-common.dtsi
> deleted file mode 100644
> index 0a698d3b73..0000000000
> --- a/arch/arm/dts/kirkwood-sheevaplug-common.dtsi
> +++ /dev/null
> @@ -1,104 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * kirkwood-sheevaplug-common.dtsi - Common parts for Sheevaplugs
> - *
> - * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
> - */
> -
> -#include "kirkwood.dtsi"
> -#include "kirkwood-6281.dtsi"
> -
> -/ {
> -       memory {
> -               device_type = "memory";
> -               reg = <0x00000000 0x20000000>;
> -       };
> -
> -       chosen {
> -               bootargs = "console=ttyS0,115200n8 earlyprintk";
> -               stdout-path = &uart0;
> -       };
> -
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -
> -                       pmx_usb_power_enable: pmx-usb-power-enable {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_red: pmx-led-red {
> -                               marvell,pins = "mpp46";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_led_blue: pmx-led-blue {
> -                               marvell,pins = "mpp49";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_sdio_cd: pmx-sdio-cd {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -                       pmx_sdio_wp: pmx-sdio-wp {
> -                               marvell,pins = "mpp47";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -       };
> -
> -       regulators {
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_usb_power_enable>;
> -               pinctrl-names = "default";
> -
> -               usb_power: regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "USB Power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       gpio = <&gpio0 29 0>;
> -               };
> -       };
> -};
> -
> -&nand {
> -       status = "okay";
> -
> -       partition@0 {
> -               label = "u-boot";
> -               reg = <0x0000000 0x100000>;
> -       };
> -
> -       partition@100000 {
> -               label = "uImage";
> -               reg = <0x0100000 0x400000>;
> -       };
> -
> -       partition@500000 {
> -               label = "root";
> -               reg = <0x0500000 0x1fb00000>;
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               reg = <0>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-sheevaplug.dts b/arch/arm/dts/kirkwood-sheevaplug.dts
> deleted file mode 100644
> index c73cc904e5..0000000000
> --- a/arch/arm/dts/kirkwood-sheevaplug.dts
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * kirkwood-sheevaplug.dts - Device tree file for Sheevaplug
> - *
> - * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
> - */
> -
> -/dts-v1/;
> -
> -#include "kirkwood-sheevaplug-common.dtsi"
> -
> -/ {
> -       model = "Globalscale Technologies SheevaPlug";
> -       compatible = "globalscale,sheevaplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> -
> -       ocp@f1000000 {
> -               mvsdio@90000 {
> -                       pinctrl-0 = <&pmx_sdio>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       /* No CD or WP GPIOs */
> -                       broken-cd;
> -               };
> -       };
> -
> -       gpio-leds {
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_led_blue &pmx_led_red>;
> -               pinctrl-names = "default";
> -
> -               health {
> -                       label = "sheevaplug:blue:health";
> -                       gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> -                       default-state = "keep";
> -               };
> -
> -               misc {
> -                       label = "sheevaplug:red:misc";
> -                       gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -};
> diff --git a/arch/arm/dts/kirkwood-synology.dtsi b/arch/arm/dts/kirkwood-synology.dtsi
> deleted file mode 100644
> index c97ed29a0a..0000000000
> --- a/arch/arm/dts/kirkwood-synology.dtsi
> +++ /dev/null
> @@ -1,855 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Nodes for Marvell 628x Synology devices
> - *
> - * Andrew Lunn <andrew@lunn.ch>
> - * Ben Peddell <klightspeed@killerwolves.net>
> - *
> - */
> -
> -/ {
> -       ocp@f1000000 {
> -               pinctrl: pin-controller@10000 {
> -                       pmx_alarmled_12: pmx-alarmled-12 {
> -                               marvell,pins = "mpp12";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanctrl_15: pmx-fanctrl-15 {
> -                               marvell,pins = "mpp15";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanctrl_16: pmx-fanctrl-16 {
> -                               marvell,pins = "mpp16";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanctrl_17: pmx-fanctrl-17 {
> -                               marvell,pins = "mpp17";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanalarm_18: pmx-fanalarm-18 {
> -                               marvell,pins = "mpp18";
> -                               marvell,function = "gpo";
> -                       };
> -
> -                       pmx_hddled_20: pmx-hddled-20 {
> -                               marvell,pins = "mpp20";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_21: pmx-hddled-21 {
> -                               marvell,pins = "mpp21";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_22: pmx-hddled-22 {
> -                               marvell,pins = "mpp22";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_23: pmx-hddled-23 {
> -                               marvell,pins = "mpp23";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_24: pmx-hddled-24 {
> -                               marvell,pins = "mpp24";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_25: pmx-hddled-25 {
> -                               marvell,pins = "mpp25";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_26: pmx-hddled-26 {
> -                               marvell,pins = "mpp26";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_27: pmx-hddled-27 {
> -                               marvell,pins = "mpp27";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_28: pmx-hddled-28 {
> -                               marvell,pins = "mpp28";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd1_pwr_29: pmx-hdd1-pwr-29 {
> -                               marvell,pins = "mpp29";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd1_pwr_30: pmx-hdd-pwr-30 {
> -                               marvell,pins = "mpp30";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd2_pwr_31: pmx-hdd2-pwr-31 {
> -                               marvell,pins = "mpp31";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanctrl_32: pmx-fanctrl-32 {
> -                               marvell,pins = "mpp32";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanctrl_33: pmx-fanctrl-33 {
> -                               marvell,pins = "mpp33";
> -                               marvell,function = "gpo";
> -                       };
> -
> -                       pmx_fanctrl_34: pmx-fanctrl-34 {
> -                               marvell,pins = "mpp34";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd2_pwr_34: pmx-hdd2-pwr-34 {
> -                               marvell,pins = "mpp34";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanalarm_35: pmx-fanalarm-35 {
> -                               marvell,pins = "mpp35";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_36: pmx-hddled-36 {
> -                               marvell,pins = "mpp36";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_37: pmx-hddled-37 {
> -                               marvell,pins = "mpp37";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_38: pmx-hddled-38 {
> -                               marvell,pins = "mpp38";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_39: pmx-hddled-39 {
> -                               marvell,pins = "mpp39";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_40: pmx-hddled-40 {
> -                               marvell,pins = "mpp40";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_41: pmx-hddled-41 {
> -                               marvell,pins = "mpp41";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_42: pmx-hddled-42 {
> -                               marvell,pins = "mpp42";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_43: pmx-hddled-43 {
> -                               marvell,pins = "mpp43";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_44: pmx-hddled-44 {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hddled_45: pmx-hddled-45 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd3_pwr_44: pmx-hdd3-pwr-44 {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_hdd4_pwr_45: pmx-hdd4-pwr-45 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanalarm_44: pmx-fanalarm-44 {
> -                               marvell,pins = "mpp44";
> -                               marvell,function = "gpio";
> -                       };
> -
> -                       pmx_fanalarm_45: pmx-fanalarm-45 {
> -                               marvell,pins = "mpp45";
> -                               marvell,function = "gpio";
> -                       };
> -               };
> -
> -               rtc@10300 {
> -                       status = "disabled";
> -               };
> -
> -               spi@10600 {
> -                       status = "okay";
> -
> -                       m25p80@0 {
> -                               #address-cells = <1>;
> -                               #size-cells = <1>;
> -                               compatible = "st,m25p80", "jedec,spi-nor";
> -                               reg = <0>;
> -                               spi-max-frequency = <20000000>;
> -                               mode = <0>;
> -
> -                               partition@0 {
> -                                       reg = <0x00000000 0x00080000>;
> -                                       label = "RedBoot";
> -                               };
> -
> -                               partition@80000 {
> -                                       reg = <0x00080000 0x00200000>;
> -                                       label = "zImage";
> -                               };
> -
> -                               partition@280000 {
> -                                       reg = <0x00280000 0x00140000>;
> -                                       label = "rd.gz";
> -                               };
> -
> -                               partition@3c0000 {
> -                                       reg = <0x003c0000 0x00010000>;
> -                                       label = "vendor";
> -                               };
> -
> -                               partition@3d0000 {
> -                                       reg = <0x003d0000 0x00020000>;
> -                                       label = "RedBoot config";
> -                               };
> -
> -                               partition@3f0000 {
> -                                       reg = <0x003f0000 0x00010000>;
> -                                       label = "FIS directory";
> -                               };
> -                       };
> -               };
> -
> -               i2c@11000 {
> -                       status = "okay";
> -                       clock-frequency = <400000>;
> -
> -                       rs5c372: rs5c372@32 {
> -                               status = "disabled";
> -                               compatible = "ricoh,rs5c372";
> -                               reg = <0x32>;
> -                       };
> -
> -                       s35390a: s35390a@30 {
> -                               status = "disabled";
> -                               compatible = "sii,s35390a";
> -                               reg = <0x30>;
> -                       };
> -               };
> -
> -               serial@12000 {
> -                       status = "okay";
> -               };
> -
> -               serial@12100 {
> -                       status = "okay";
> -               };
> -
> -               poweroff@12100 {
> -                       compatible = "synology,power-off";
> -                       reg = <0x12100 0x100>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               sata@80000 {
> -                       pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> -                       pinctrl-names = "default";
> -                       status = "okay";
> -                       nr-ports = <2>;
> -               };
> -       };
> -
> -       gpio-fan-150-32-35 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_32 &pmx_fanctrl_33 &pmx_fanctrl_34
> -                            &pmx_fanalarm_35>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
> -                        &gpio1 1 GPIO_ACTIVE_HIGH
> -                        &gpio1 2 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2200 1
> -                                      2500 2
> -                                      3000 4
> -                                      3300 3
> -                                      3700 5
> -                                      3800 6
> -                                      4200 7 >;
> -       };
> -
> -       gpio-fan-150-15-18 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
> -                            &pmx_fanalarm_18>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
> -                        &gpio0 16 GPIO_ACTIVE_HIGH
> -                        &gpio0 17 GPIO_ACTIVE_HIGH>;
> -               alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2200 1
> -                                      2500 2
> -                                      3000 4
> -                                      3300 3
> -                                      3700 5
> -                                      3800 6
> -                                      4200 7 >;
> -       };
> -
> -       gpio-fan-100-32-35 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_32 &pmx_fanctrl_33 &pmx_fanctrl_34
> -                            &pmx_fanalarm_35>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio1 0 GPIO_ACTIVE_HIGH
> -                        &gpio1 1 GPIO_ACTIVE_HIGH
> -                        &gpio1 2 GPIO_ACTIVE_HIGH>;
> -               alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2500 1
> -                                      3100 2
> -                                      3800 3
> -                                      4600 4
> -                                      4800 5
> -                                      4900 6
> -                                      5000 7 >;
> -       };
> -
> -       gpio-fan-100-15-18 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
> -                            &pmx_fanalarm_18>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
> -                        &gpio0 16 GPIO_ACTIVE_HIGH
> -                        &gpio0 17 GPIO_ACTIVE_HIGH>;
> -               alarm-gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2500 1
> -                                      3100 2
> -                                      3800 3
> -                                      4600 4
> -                                      4800 5
> -                                      4900 6
> -                                      5000 7 >;
> -       };
> -
> -       gpio-fan-100-15-35-1 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
> -                            &pmx_fanalarm_35>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
> -                        &gpio0 16 GPIO_ACTIVE_HIGH
> -                        &gpio0 17 GPIO_ACTIVE_HIGH>;
> -               alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2500 1
> -                                      3100 2
> -                                      3800 3
> -                                      4600 4
> -                                      4800 5
> -                                      4900 6
> -                                      5000 7 >;
> -       };
> -
> -       gpio-fan-100-15-35-3 {
> -               status = "disabled";
> -               compatible = "gpio-fan";
> -               pinctrl-0 = <&pmx_fanctrl_15 &pmx_fanctrl_16 &pmx_fanctrl_17
> -                            &pmx_fanalarm_35 &pmx_fanalarm_44 &pmx_fanalarm_45>;
> -               pinctrl-names = "default";
> -               gpios = <&gpio0 15 GPIO_ACTIVE_HIGH
> -                        &gpio0 16 GPIO_ACTIVE_HIGH
> -                        &gpio0 17 GPIO_ACTIVE_HIGH>;
> -               alarm-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH
> -                              &gpio1 12 GPIO_ACTIVE_HIGH
> -                              &gpio1 13 GPIO_ACTIVE_HIGH>;
> -               gpio-fan,speed-map = <    0 0
> -                                      2500 1
> -                                      3100 2
> -                                      3800 3
> -                                      4600 4
> -                                      4800 5
> -                                      4900 6
> -                                      5000 7 >;
> -       };
> -
> -       gpio-leds-alarm-12 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_alarmled_12>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:alarm";
> -                       gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds-hdd-20 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_hddled_20 &pmx_hddled_21 &pmx_hddled_22
> -                            &pmx_hddled_23 &pmx_hddled_24 &pmx_hddled_25
> -                            &pmx_hddled_26 &pmx_hddled_27>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:green:hdd1";
> -                       gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd1-amber {
> -                       label = "synology:amber:hdd1";
> -                       gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-green {
> -                       label = "synology:green:hdd2";
> -                       gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-amber {
> -                       label = "synology:amber:hdd2";
> -                       gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd3-green {
> -                       label = "synology:green:hdd3";
> -                       gpios = <&gpio0 24 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd3-amber {
> -                       label = "synology:amber:hdd3";
> -                       gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd4-green {
> -                       label = "synology:green:hdd4";
> -                       gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd4-amber {
> -                       label = "synology:amber:hdd4";
> -                       gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds-hdd-21-1 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:green:hdd1";
> -                       gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd1-amber {
> -                       label = "synology:amber:hdd1";
> -                       gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds-hdd-21-2 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_hddled_21 &pmx_hddled_23 &pmx_hddled_20 &pmx_hddled_22>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:green:hdd1";
> -                       gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd1-amber {
> -                       label = "synology:amber:hdd1";
> -                       gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-green {
> -                       label = "synology:green:hdd2";
> -                       gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-amber {
> -                       label = "synology:amber:hdd2";
> -                       gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds-hdd-36 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_hddled_36 &pmx_hddled_37 &pmx_hddled_38
> -                            &pmx_hddled_39 &pmx_hddled_40 &pmx_hddled_41
> -                            &pmx_hddled_42 &pmx_hddled_43 &pmx_hddled_44
> -                            &pmx_hddled_45>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:green:hdd1";
> -                       gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd1-amber {
> -                       label = "synology:amber:hdd1";
> -                       gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-green {
> -                       label = "synology:green:hdd2";
> -                       gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-amber {
> -                       label = "synology:amber:hdd2";
> -                       gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd3-green {
> -                       label = "synology:green:hdd3";
> -                       gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd3-amber {
> -                       label = "synology:amber:hdd3";
> -                       gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd4-green {
> -                       label = "synology:green:hdd4";
> -                       gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd4-amber {
> -                       label = "synology:amber:hdd4";
> -                       gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd5-green {
> -                       label = "synology:green:hdd5";
> -                       gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd5-amber {
> -                       label = "synology:amber:hdd5";
> -                       gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       gpio-leds-hdd-38 {
> -               status = "disabled";
> -               compatible = "gpio-leds";
> -               pinctrl-0 = <&pmx_hddled_38 &pmx_hddled_39 &pmx_hddled_36 &pmx_hddled_37>;
> -               pinctrl-names = "default";
> -
> -               hdd1-green {
> -                       label = "synology:green:hdd1";
> -                       gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd1-amber {
> -                       label = "synology:amber:hdd1";
> -                       gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-green {
> -                       label = "synology:green:hdd2";
> -                       gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> -               };
> -
> -               hdd2-amber {
> -                       label = "synology:amber:hdd2";
> -                       gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> -               };
> -       };
> -
> -       regulators-hdd-29 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd1_pwr_29 &pmx_hdd2_pwr_31>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd1power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "hdd2power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       regulators-hdd-30-1 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd1_pwr_30>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd1power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       regulators-hdd-30-2 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd1power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "hdd2power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       regulators-hdd-30-4 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd1_pwr_30 &pmx_hdd2_pwr_34
> -                            &pmx_hdd3_pwr_44 &pmx_hdd4_pwr_45>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd1power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "hdd2power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@3 {
> -                       compatible = "regulator-fixed";
> -                       reg = <3>;
> -                       regulator-name = "hdd3power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@4 {
> -                       compatible = "regulator-fixed";
> -                       reg = <4>;
> -                       regulator-name = "hdd4power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       regulators-hdd-31 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd2_pwr_31>;
> -               pinctrl-names = "default";
> -
> -               regulator@1 {
> -                       compatible = "regulator-fixed";
> -                       reg = <1>;
> -                       regulator-name = "hdd2power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio0 31 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -
> -       regulators-hdd-34 {
> -               status = "disabled";
> -               compatible = "simple-bus";
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -               pinctrl-0 = <&pmx_hdd2_pwr_34 &pmx_hdd3_pwr_44
> -                            &pmx_hdd4_pwr_45>;
> -               pinctrl-names = "default";
> -
> -               regulator@2 {
> -                       compatible = "regulator-fixed";
> -                       reg = <2>;
> -                       regulator-name = "hdd2power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@3 {
> -                       compatible = "regulator-fixed";
> -                       reg = <3>;
> -                       regulator-name = "hdd3power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> -               };
> -
> -               regulator@4 {
> -                       compatible = "regulator-fixed";
> -                       reg = <4>;
> -                       regulator-name = "hdd4power";
> -                       regulator-min-microvolt = <5000000>;
> -                       regulator-max-microvolt = <5000000>;
> -                       enable-active-high;
> -                       regulator-always-on;
> -                       regulator-boot-on;
> -                       startup-delay-us = <5000000>;
> -                       gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> -               };
> -       };
> -};
> -
> -&mdio {
> -       status = "okay";
> -
> -       ethphy0: ethernet-phy@0 {
> -               device_type = "ethernet-phy";
> -               reg = <8>;
> -       };
> -
> -       ethphy1: ethernet-phy@1 {
> -               device_type = "ethernet-phy";
> -               reg = <9>;
> -       };
> -};
> -
> -&eth0 {
> -       status = "okay";
> -
> -       ethernet0-port@0 {
> -               phy-handle = <&ethphy0>;
> -       };
> -};
> -
> -&eth1 {
> -       status = "disabled";
> -
> -       ethernet1-port@0 {
> -               phy-handle = <&ethphy1>;
> -       };
> -};
> -
> -&pciec {
> -        status = "okay";
> -};
> -
> -&pcie0 {
> -       status = "okay";
> -};
> diff --git a/arch/arm/dts/kirkwood.dtsi b/arch/arm/dts/kirkwood.dtsi
> deleted file mode 100644
> index 81c7eda2c4..0000000000
> --- a/arch/arm/dts/kirkwood.dtsi
> +++ /dev/null
> @@ -1,393 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/include/ "skeleton.dtsi"
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/gpio/gpio.h>
> -
> -#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
> -
> -/ {
> -       compatible = "marvell,kirkwood";
> -       interrupt-parent = <&intc>;
> -
> -       cpus {
> -               #address-cells = <1>;
> -               #size-cells = <0>;
> -
> -               cpu@0 {
> -                       device_type = "cpu";
> -                       compatible = "marvell,feroceon";
> -                       reg = <0>;
> -                       clocks = <&core_clk 1>, <&core_clk 3>, <&gate_clk 11>;
> -                       clock-names = "cpu_clk", "ddrclk", "powersave";
> -               };
> -       };
> -
> -       aliases {
> -              gpio0 = &gpio0;
> -              gpio1 = &gpio1;
> -              i2c0 = &i2c0;
> -       };
> -
> -       mbus@f1000000 {
> -               compatible = "marvell,kirkwood-mbus", "simple-bus";
> -               #address-cells = <2>;
> -               #size-cells = <1>;
> -               /* If a board file needs to change this ranges it must replace it completely */
> -               ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000     /* internal-regs */
> -                         MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000      /* nand flash */
> -                         MBUS_ID(0x03, 0x01) 0 0xf5000000 0x10000      /* crypto sram */
> -                         >;
> -               controller = <&mbusc>;
> -               pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
> -               pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
> -
> -               nand: nand@12f {
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -                       cle = <0>;
> -                       ale = <1>;
> -                       bank-width = <1>;
> -                       compatible = "marvell,orion-nand";
> -                       reg = <MBUS_ID(0x01, 0x2f) 0 0x400>;
> -                       chip-delay = <25>;
> -                       /* set partition map and/or chip-delay in board dts */
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_nand>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               crypto_sram: sa-sram@301 {
> -                       compatible = "mmio-sram";
> -                       reg = <MBUS_ID(0x03, 0x01) 0x0 0x800>;
> -                       clocks = <&gate_clk 17>;
> -                       #address-cells = <1>;
> -                       #size-cells = <1>;
> -               };
> -       };
> -
> -       ocp@f1000000 {
> -               compatible = "simple-bus";
> -               ranges = <0x00000000 0xf1000000 0x0100000>;
> -               #address-cells = <1>;
> -               #size-cells = <1>;
> -
> -               pinctrl: pin-controller@10000 {
> -                       /* set compatible property in SoC file */
> -                       reg = <0x10000 0x20>;
> -
> -                       pmx_ge1: pmx-ge1 {
> -                               marvell,pins = "mpp20", "mpp21", "mpp22", "mpp23",
> -                                              "mpp24", "mpp25", "mpp26", "mpp27",
> -                                              "mpp30", "mpp31", "mpp32", "mpp33";
> -                               marvell,function = "ge1";
> -                       };
> -
> -                       pmx_nand: pmx-nand {
> -                               marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3",
> -                                              "mpp4", "mpp5", "mpp18", "mpp19";
> -                               marvell,function = "nand";
> -                       };
> -
> -                       /*
> -                        * Default SPI0 pinctrl setting with CSn on mpp0,
> -                        * overwrite marvell,pins on board level if required.
> -                        */
> -                       pmx_spi: pmx-spi {
> -                               marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> -                               marvell,function = "spi";
> -                       };
> -
> -                       pmx_twsi0: pmx-twsi0 {
> -                               marvell,pins = "mpp8", "mpp9";
> -                               marvell,function = "twsi0";
> -                       };
> -
> -                       /*
> -                        * Default UART pinctrl setting without RTS/CTS,
> -                        * overwrite marvell,pins on board level if required.
> -                        */
> -                       pmx_uart0: pmx-uart0 {
> -                               marvell,pins = "mpp10", "mpp11";
> -                               marvell,function = "uart0";
> -                       };
> -
> -                       pmx_uart1: pmx-uart1 {
> -                               marvell,pins = "mpp13", "mpp14";
> -                               marvell,function = "uart1";
> -                       };
> -               };
> -
> -               core_clk: core-clocks@10030 {
> -                       compatible = "marvell,kirkwood-core-clock";
> -                       reg = <0x10030 0x4>;
> -                       #clock-cells = <1>;
> -               };
> -
> -               spi0: spi@10600 {
> -                       compatible = "marvell,orion-spi";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       cell-index = <0>;
> -                       interrupts = <23>;
> -                       reg = <0x10600 0x28>;
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_spi>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               gpio0: gpio@10100 {
> -                       compatible = "marvell,orion-gpio";
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       reg = <0x10100 0x40>;
> -                       ngpios = <32>;
> -                       interrupt-controller;
> -                       #interrupt-cells = <2>;
> -                       interrupts = <35>, <36>, <37>, <38>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               gpio1: gpio@10140 {
> -                       compatible = "marvell,orion-gpio";
> -                       #gpio-cells = <2>;
> -                       gpio-controller;
> -                       reg = <0x10140 0x40>;
> -                       ngpios = <18>;
> -                       interrupt-controller;
> -                       #interrupt-cells = <2>;
> -                       interrupts = <39>, <40>, <41>;
> -                       clocks = <&gate_clk 7>;
> -               };
> -
> -               i2c0: i2c@11000 {
> -                       compatible = "marvell,mv64xxx-i2c";
> -                       reg = <0x11000 0x20>;
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       interrupts = <29>;
> -                       clock-frequency = <100000>;
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_twsi0>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               uart0: serial@12000 {
> -                       compatible = "ns16550a";
> -                       reg = <0x12000 0x100>;
> -                       reg-shift = <2>;
> -                       interrupts = <33>;
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_uart0>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               uart1: serial@12100 {
> -                       compatible = "ns16550a";
> -                       reg = <0x12100 0x100>;
> -                       reg-shift = <2>;
> -                       interrupts = <34>;
> -                       clocks = <&gate_clk 7>;
> -                       pinctrl-0 = <&pmx_uart1>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -               };
> -
> -               mbusc: mbus-controller@20000 {
> -                       compatible = "marvell,mbus-controller";
> -                       reg = <0x20000 0x80>, <0x1500 0x20>;
> -               };
> -
> -               sysc: system-controller@20000 {
> -                       compatible = "marvell,orion-system-controller";
> -                       reg = <0x20000 0x120>;
> -               };
> -
> -               bridge_intc: bridge-interrupt-ctrl@20110 {
> -                       compatible = "marvell,orion-bridge-intc";
> -                       interrupt-controller;
> -                       #interrupt-cells = <1>;
> -                       reg = <0x20110 0x8>;
> -                       interrupts = <1>;
> -                       marvell,#interrupts = <6>;
> -               };
> -
> -               gate_clk: clock-gating-control@2011c {
> -                       compatible = "marvell,kirkwood-gating-clock";
> -                       reg = <0x2011c 0x4>;
> -                       clocks = <&core_clk 0>;
> -                       #clock-cells = <1>;
> -               };
> -
> -               l2: l2-cache@20128 {
> -                       compatible = "marvell,kirkwood-cache";
> -                       reg = <0x20128 0x4>;
> -               };
> -
> -               intc: main-interrupt-ctrl@20200 {
> -                       compatible = "marvell,orion-intc";
> -                       interrupt-controller;
> -                       #interrupt-cells = <1>;
> -                       reg = <0x20200 0x10>, <0x20210 0x10>;
> -               };
> -
> -               timer: timer@20300 {
> -                       compatible = "marvell,orion-timer";
> -                       reg = <0x20300 0x20>;
> -                       interrupt-parent = <&bridge_intc>;
> -                       interrupts = <1>, <2>;
> -                       clocks = <&core_clk 0>;
> -               };
> -
> -               wdt: watchdog-timer@20300 {
> -                       compatible = "marvell,orion-wdt";
> -                       reg = <0x20300 0x28>, <0x20108 0x4>;
> -                       interrupt-parent = <&bridge_intc>;
> -                       interrupts = <3>;
> -                       clocks = <&gate_clk 7>;
> -                       status = "okay";
> -               };
> -
> -               cesa: crypto@30000 {
> -                       compatible = "marvell,kirkwood-crypto";
> -                       reg = <0x30000 0x10000>;
> -                       reg-names = "regs";
> -                       interrupts = <22>;
> -                       clocks = <&gate_clk 17>;
> -                       marvell,crypto-srams = <&crypto_sram>;
> -                       marvell,crypto-sram-size = <0x800>;
> -                       status = "okay";
> -               };
> -
> -               usb0: ehci@50000 {
> -                       compatible = "marvell,orion-ehci";
> -                       reg = <0x50000 0x1000>;
> -                       interrupts = <19>;
> -                       clocks = <&gate_clk 3>;
> -                       status = "okay";
> -               };
> -
> -               dma0: xor@60800 {
> -                       compatible = "marvell,orion-xor";
> -                       reg = <0x60800 0x100
> -                              0x60A00 0x100>;
> -                       status = "okay";
> -                       clocks = <&gate_clk 8>;
> -
> -                       xor00 {
> -                             interrupts = <5>;
> -                             dmacap,memcpy;
> -                             dmacap,xor;
> -                       };
> -                       xor01 {
> -                             interrupts = <6>;
> -                             dmacap,memcpy;
> -                             dmacap,xor;
> -                             dmacap,memset;
> -                       };
> -               };
> -
> -               dma1: xor@60900 {
> -                       compatible = "marvell,orion-xor";
> -                       reg = <0x60900 0x100
> -                              0x60B00 0x100>;
> -                       status = "okay";
> -                       clocks = <&gate_clk 16>;
> -
> -                       xor00 {
> -                             interrupts = <7>;
> -                             dmacap,memcpy;
> -                             dmacap,xor;
> -                       };
> -                       xor01 {
> -                             interrupts = <8>;
> -                             dmacap,memcpy;
> -                             dmacap,xor;
> -                             dmacap,memset;
> -                       };
> -               };
> -
> -               eth0: ethernet-controller@72000 {
> -                       compatible = "marvell,kirkwood-eth";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       reg = <0x72000 0x4000>;
> -                       clocks = <&gate_clk 0>;
> -                       marvell,tx-checksum-limit = <1600>;
> -                       status = "disabled";
> -
> -                       eth0port: ethernet0-port@0 {
> -                               compatible = "marvell,kirkwood-eth-port";
> -                               reg = <0>;
> -                               interrupts = <11>;
> -                               /* overwrite MAC address in bootloader */
> -                               local-mac-address = [00 00 00 00 00 00];
> -                               /* set phy-handle property in board file */
> -                       };
> -               };
> -
> -               mdio: mdio-bus@72004 {
> -                       compatible = "marvell,orion-mdio";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       reg = <0x72004 0x84>;
> -                       interrupts = <46>;
> -                       clocks = <&gate_clk 0>;
> -                       status = "disabled";
> -
> -                       /* add phy nodes in board file */
> -               };
> -
> -               eth1: ethernet-controller@76000 {
> -                       compatible = "marvell,kirkwood-eth";
> -                       #address-cells = <1>;
> -                       #size-cells = <0>;
> -                       reg = <0x76000 0x4000>;
> -                       clocks = <&gate_clk 19>;
> -                       marvell,tx-checksum-limit = <1600>;
> -                       pinctrl-0 = <&pmx_ge1>;
> -                       pinctrl-names = "default";
> -                       status = "disabled";
> -
> -                       eth1port: ethernet1-port@0 {
> -                               compatible = "marvell,kirkwood-eth-port";
> -                               reg = <0>;
> -                               interrupts = <15>;
> -                               /* overwrite MAC address in bootloader */
> -                               local-mac-address = [00 00 00 00 00 00];
> -                               /* set phy-handle property in board file */
> -                       };
> -               };
> -
> -               sata_phy0: sata-phy@82000 {
> -                       compatible = "marvell,mvebu-sata-phy";
> -                       reg = <0x82000 0x0334>;
> -                       clocks = <&gate_clk 14>;
> -                       clock-names = "sata";
> -                       #phy-cells = <0>;
> -                       status = "ok";
> -               };
> -
> -               sata_phy1: sata-phy@84000 {
> -                       compatible = "marvell,mvebu-sata-phy";
> -                       reg = <0x84000 0x0334>;
> -                       clocks = <&gate_clk 15>;
> -                       clock-names = "sata";
> -                       #phy-cells = <0>;
> -                       status = "ok";
> -               };
> -
> -               audio0: audio-controller@a0000 {
> -                       compatible = "marvell,kirkwood-audio";
> -                       #sound-dai-cells = <0>;
> -                       reg = <0xa0000 0x2210>;
> -                       interrupts = <24>;
> -                       clocks = <&gate_clk 9>;
> -                       clock-names = "internal";
> -                       status = "disabled";
> -               };
> -       };
> -};
> --
> 2.39.2
>
