Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05651C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 12:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A1788680;
	Mon, 12 Aug 2024 14:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uYRWsYMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B1CB8867B; Mon, 12 Aug 2024 14:20:24 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1898686EE3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 14:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-709485aca4bso2188682a34.1
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723465221; x=1724070021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ht+rc2LZCaoeNoLbmT6t3zcHNDAnro9JtQbum5S55+A=;
 b=uYRWsYMDIbASHVQASxFTPr4veB7hmYepp8IWuIWWYkaDe6CXhqsmjYgqolwgOXjgIx
 gusa7BYfFngjDCQuPW24IY+Ivi35v9kU5l/V4wMCs85oCEzz0XVkGP9CUrOoyKrJXGdr
 wli+j/BMWJVST4AAzqihVBU2yQBzUzLe87eThX/x6t/3cpWstuhGliIxx9YbPrPwlJi7
 WH3mso2GxwgRv7y4GRnIV1l1AnWal69IgkP7BE4EBdXFSBxN4/iHNItEYyKHN14NLELJ
 GJy3kCWv+C8Px72AZwE8m+k1bZNS/Wk0G13OWiWHBQ2VQ0ELXOyGf51JfURCCAwg77iw
 vKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723465221; x=1724070021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ht+rc2LZCaoeNoLbmT6t3zcHNDAnro9JtQbum5S55+A=;
 b=Ei59/J9Wp5LBfL8sMS34/JdVU6B95zovva2Rk8cA3t6DlUozMAMten+cwojyn/YXAT
 c6UNTDrP4ppJHWSOQaOgfy3GA/f43QplME2qjXPNUbY22vZ/WtZAJr6oNLq1SIjTvzxL
 FMXep0/sdyQorE//L7FYve6Cw1OfUbchJDWcbLK+3nRwhQcB/SCT3s9Ki7HBuE3ITrlY
 ocQQJO1YVxs0apxIoWYnzEZZI0e+Q4OLAjxzfdLtmprdQmljgoueUn5Mir3PmGBNXbb2
 WVpuJjwHGgkF676tCan6TNnDLG1cF2IltCD+wRVLxTB/ncMVcxekrMXvx5qypaRUmO2o
 6FsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvlLf51WyiMq0FTdrDNZwgurHJZuCsDKv+GpIKGsW2+n/2wNpGZ74fGQ8WMzT0VJtqs0IRW4NN1WVMS5nH48nSGMxFzQ==
X-Gm-Message-State: AOJu0YxNg/Ocwhe2oLK7zB5+bUE7vJLl4KFJZRjx7GOUO/y0euc1uHol
 qhJnnKg2VwNLjDo0UPuCkUmarUlT8GQSC2RHXJfq6dX31RvQX1hXgmepJghLU+owMRO8ctog8+v
 sbIZAZbPsEPuOv4dG9KymStTjt1Yh8w0ypN7S3jrTR/mS5cxv6Ac=
X-Google-Smtp-Source: AGHT+IHsQrkXGRQrjzGGkJazebhm6w+w2uYoltlCqVeeCKv8WwLKs3cVi6SPPp9cuDKPTa/kkXXxVS+25yNfB2Xi1Uk=
X-Received: by 2002:a05:6358:720:b0:1aa:c492:1d34 with SMTP id
 e5c5f4694b2df-1b19d2e7196mr27380155d.23.1723465220720; Mon, 12 Aug 2024
 05:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240812113621.3840652-1-c-vankar@ti.com>
 <20240812114945.3844224-1-c-vankar@ti.com>
In-Reply-To: <20240812114945.3844224-1-c-vankar@ti.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 12 Aug 2024 17:50:08 +0530
Message-ID: <CAFA6WYO5JeFsUyDWkF+Xw018cGehZiD7ZdVvXAc-VERZWSFTUg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] dts: upstream: src: arm64: ti:
 k3-am62x-sk-common: Sync DT with Linux v6.11-rc3
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, 
 Ravi Gunasekaran <r-gunasekaran@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Chintan,

On Mon, 12 Aug 2024 at 17:19, Chintan Vankar <c-vankar@ti.com> wrote:
>
> Sync Device tree nodes with Linux v6.11-rc3.
>

You don't need to manually sync DT files but...

> [ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]
>

...rather cherry pick required commits from upstream as the one you
have mentioned. Refer DT docs [1] for instructions.

[1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

-Sumit

> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>
> Link to v3:
> - This link is for the patch which was equivalent to this patch, from
>   this version the node is moved to DT file equivalent to Linux as a
>   part of DT sync.
>   https://lore.kernel.org/r/20240705045030.1141934-11-c-vankar@ti.com/
>
> Changes from v3 to v4:
> - Updated this patch by syncing "k3-am62x-sk-common.dtsi" file
>   with Linux v6.11-rc3 compared to previous version.
>
>  .../src/arm64/ti/k3-am62x-sk-common.dtsi      | 32 ++++++++++---------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> index 3c45782ab2..44ff67b6bf 100644
> --- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
> @@ -48,6 +48,14 @@
>                         pmsg-size = <0x8000>;
>                 };
>
> +               /* global cma region */
> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0x00 0x8000000>;
> +                       linux,cma-default;
> +               };
> +
>                 secure_tfa_ddr: tfa@9e780000 {
>                         reg = <0x00 0x9e780000 0x00 0x80000>;
>                         alignment = <0x1000>;
> @@ -128,6 +136,10 @@
>         };
>  };
>
> +&phy_gmii_sel {
> +       bootph-all;
> +};
> +
>  &main_pmx0 {
>         /* First pad number is ALW package and second is AMC package */
>         main_uart0_pins_default: main-uart0-default-pins {
> @@ -156,6 +168,7 @@
>         };
>
>         main_i2c1_pins_default: main-i2c1-default-pins {
> +               bootph-all;
>                 pinctrl-single,pins = <
>                         AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17/A17) I2C1_SCL */
>                         AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17/A16) I2C1_SDA */
> @@ -335,15 +348,9 @@
>                         self-powered;
>                         data-role = "dual";
>                         power-role = "sink";
> -                       ports {
> -                               #address-cells = <1>;
> -                               #size-cells = <0>;
> -
> -                               port@0 {
> -                                       reg = <0>;
> -                                       usb_con_hs: endpoint {
> -                                               remote-endpoint = <&usb0_hs_ep>;
> -                                       };
> +                       port {
> +                               usb_con_hs: endpoint {
> +                                       remote-endpoint = <&usb0_hs_ep>;
>                                 };
>                         };
>                 };
> @@ -470,12 +477,9 @@
>
>  &usb0 {
>         bootph-all;
> -       #address-cells = <1>;
> -       #size-cells = <0>;
>         usb-role-switch;
>
> -       port@0 {
> -               reg = <0>;
> +       port {
>                 usb0_hs_ep: endpoint {
>                     remote-endpoint = <&usb_con_hs>;
>                };
> @@ -504,8 +508,6 @@
>                0 0 0 0
>                0 0 0 0
>         >;
> -       tx-num-evt = <32>;
> -       rx-num-evt = <32>;
>  };
>
>  &dss {
> --
> 2.34.1
>
