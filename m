Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D58CD1280
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 15:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155298806C;
	Wed, 27 Mar 2024 16:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ayLfPQb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D6E87F4F; Wed, 27 Mar 2024 16:56:06 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CF58806C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 16:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso4878198a12.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711554959; x=1712159759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mnw8lmecvrexGHzgOpFlHfHzWumVgsaWcRWB+VR0fro=;
 b=ayLfPQb7ycpgqtzvy6sMC8GjMkrkMGbrh20NwKJ/uH2tnsw9tBq5pGvx429TFhSC/F
 NBJSCfpBHsrNons5KNRvxnVFNAHPU7eZZF+99I2zXDtXggZMx9FxIwKFIORZxxWpp9C4
 L/jjnkri68dLZrbnnYEtcDQS0TKh6ztlzwzc5JNs18y3Tl6XcFn0E6GeR6GFfkITJYZk
 xLVW5Pyi8S2bQeayhd4EI8/AfQf/s3Vq/voJfL1tfBOVxhlsOHkYxcLiVpB82w5xnLxi
 S35hMzJvKF0F/+wZ1FNB6br3vT0C81L3e9g4KJPBPJ7NKoBI3MwjF2e31mqAQ/C59yXn
 7RXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711554959; x=1712159759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mnw8lmecvrexGHzgOpFlHfHzWumVgsaWcRWB+VR0fro=;
 b=LI/X6Z+sLxo/D5h5seTOme8wMm2pwJ7L3uUsCSuA+WluMLjKhDOVvg3g4dGZYov+ml
 lq7kUKr+aD5rIQyBMDyVDSI/2VMXh1/uHrPNCLOCHFQ1wlQTMnYlOvb0/rD541P9oIqn
 L18abxt4AOULsFPy2Dk4LJElCEWrEk/GPw+sNx2+0CAc8tsYY7lGwddeBucTb1UXhVG5
 n8/fp6+DDpQ0r9t7Dtf+CAP56wNntROllNMgWSCW2UKivrKyqOLx0R01RDudTXi8S2as
 zQQQq7NrCsDtJrEYlNCgodjqqDoQlD6RpWtb3svjD92G38ZgQt7NmyetSA7Iyh3pe2q4
 hg+Q==
X-Gm-Message-State: AOJu0Yy1bLCEdmywBJDrYX46v7ANO//k5F0+GMn4JgBkqzlceqBMl5V8
 yJdi0psgTRXIpd1QeaxUZUZ2LS+qJqpLF1MeS+DCV/LvPNoCP+ZTu/CnQjh5X+3erORgU3vbicY
 7QtVk+YNhmLVajcwT4wYRCgi7H1yxI4oHK8OkjJnT
X-Google-Smtp-Source: AGHT+IFoA9I65oiCW40q5kFbFwmlnibs1F2sObAzkwMAZG5Mk3fMLJY3PXvZEmeMF+7/8GOTxpiBeOs2J/6ZktQBlhw=
X-Received: by 2002:a17:90a:dc08:b0:2a0:4c3b:3454 with SMTP id
 i8-20020a17090adc0800b002a04c3b3454mr20429pjv.47.1711554958741; Wed, 27 Mar
 2024 08:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
 <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
 <CAH9NwWd2smg+vC=hHx1XbRPS569Mxzr4HNghwA9DUQUyYf-OKA@mail.gmail.com>
 <1c077133-dbd4-4255-89af-259a2ca686c2@solid-run.com>
In-Reply-To: <1c077133-dbd4-4255-89af-259a2ca686c2@solid-run.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 27 Mar 2024 16:55:47 +0100
Message-ID: <CAH9NwWfEBUiGF9kVh20AYnHwn1mri1sHy-M4Qdb-zrOcOXjM7Q@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: fix ethernet after synchronise device-tree
To: Josua Mayer <josua@solid-run.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Baruch Siach <baruch@tkos.co.il>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Josua

> > Hi Josua
> >
> > My bisect showed me that after a device-tree sync the ethernet broke.
> >
> >> please take a look at this patch, I suspect it will (hack-)fix your
> >> ethernet issue.
> >>
> > Yes.. it fixes the problem I am seeing.
> >
> >> Unfortunately I had no time to revisit this yet and implement a correct solution.
> >>
> > Would it be okay for you if I look into a proper solution?
>
> Sure. I am swamped by other products at the moment.
>
> However I will provide a rough overview what needs to be done:
>
> Background: i.MX6 SoMs originally had a an atheros phy at unstable address,
> either 0 or 4 depending on electrical noise on floating configuration signals.
>

Would it be possible to set those configuration signals from the MX6
to a defined state and
then toggle the PHY reset , to force correct PHY address?

> Linux had solved this by placing 2 phy nodes in device-tree.
> During boot the kernel would attempt in order to probe the phys,
> then link the successful one to the ethernet netdev.
> As a side-effect there is always an error in the kernel log for one of the
> addresses.
>
> U-Boot had something similar in that with a special address (I think 0xff)
> in device-tree, the code will probe mdio bus for all addresses, but only
> for a single phy node in dts.
>
> With release of SoM 2.0 we changed to an analog devices phy at address 1,
> which most importantly uses a different driver, and requires a different description
> in device-tree.
>
> When adding this new phy, as a third node in device-tree, kernel maintainers
> requested a better solution, and we got u-boot to runtime patch dtb to update
> status properties of the dtb for linux, after probing mdio bus for phys.
>

Got it.

>
> Now - what u-boot needs to do is probe the mdio bus, and then runtime-patch its own DTB.
> Either with status properties, or for adding the phy-handle property (not sure which method will work).
>

We could patch DTB in SPL for U-Boot proper but doing a mdio scan in
SPL looks like a lot of work. Do
you know if there is a pull up/down resistor etc. that I could use to
detect pre SoM 2.0 and SoM 2.0?

Is this what board_type() does?
Is HummingBoard2 == SoM 2.0?

> This somehow has to happen after probing mdio driver, but before probing ethernet driver.
>
> > I have a
> > handful of such devices here
> > that are already or will be used in a CI farm so I am interested in
> > using the latest U-Boot for them.
> >
> >> sincerely
> >> Josua Mayer
> >>
> >> Am 28.07.22 um 09:08 schrieb Josua Mayer:
> >>> Please hold off merging this patch until someone tested it, I can not do so this week.
> >>> @Tom Can you confirm if this fixes the networking on your Cubox?
> >>> Also note that the phy-handle property may or may not be required, I am not sure.
> >>>
> >>> sincerely
> >>> Josua Mayer
> >>>
> >>> On Thu, Jul 28, 2022 at 7:05 AM Josua Mayer <josua@solid-run.com> wrote:
> >>>
> >>>     The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
> >>>     addresses. U-Boot needs to auto-detect which phy is actually present,
> >>>     and at which address it is responding.
> >>>
> >>>     Auto-detection from multiple phy nodes specified in device-tree does not
> >>>     currently work correct. As a work-around merge all three possible phys
> >>>     into one node with the special address 0xffffffff which indicates to the
> >>>     generic phy driver to probe all addresses.
> >>>     Also fixup this fake address before booting Linux, *if* booting with
> >>>     U-Boot's internal dtb.
> >>>
> >>>     Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>>     Fixes: d0399a46e7cd
> >>>     ---
> >>>      arch/arm/dts/imx6qdl-sr-som.dtsi     | 30 +++++++++-------------------
> >>>      board/solidrun/mx6cuboxi/mx6cuboxi.c |  6 +++++-
> >>>      2 files changed, 14 insertions(+), 22 deletions(-)
> >>>
> >>>     diff --git a/arch/arm/dts/imx6qdl-sr-som.dtsi b/arch/arm/dts/imx6qdl-sr-som.dtsi
> >>>     index ce543e325c..2d7cbc26b3 100644
> >>>     ---_a/arch/arm/dts/imx6qdl-sr-som.dtsi
> >>>     +++ b/arch/arm/dts/imx6qdl-sr-som.dtsi
> >>>     @@ -53,6 +53,7 @@
> >>>      &fec {
> >>>             pinctrl-names = "default";
> >>>             pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
> >>>     +       phy-handle = <&phy>;
> >>>             phy-mode = "rgmii-id";
> >>>
> >>>             /*
> >>>     @@ -68,30 +69,17 @@
> >>>                     #address-cells = <1>;
> >>>                     #size-cells = <0>;
> >>>
> >>>     -               /*
> >>>     -                * The PHY can appear at either address 0 or 4 due to the
> >>>     -                * configuration (LED) pin not being pulled sufficiently.
> >>>     -                */
> >>>     -               ethernet-phy@0 {
> >>>     -                       reg = <0>;
> >>>     +               phy: ethernet-phy@0 {
> >>>     +                       /*
> >>>     +                        * The PHY can appear either:
> >>>     +                        * - AR8035: at address 0 or 4
> >>>     +                        * - ADIN1300: at address 1
> >>>     +                        * Actual address being detected at runtime.
> >>>     +                        */
> >>>     +                       reg = <0xffffffff>;
> >>>                             qca,clk-out-frequency = <125000000>;
> >>>                             qca,smarteee-tw-us-1g = <24>;
> >>>     -               };
> >>>     -
> >>>     -               ethernet-phy@4 {
> >>>     -                       reg = <4>;
> >>>     -                       qca,clk-out-frequency = <125000000>;
> >>>     -                       qca,smarteee-tw-us-1g = <24>;
> >>>     -               };
> >>>     -
> >>>     -               /*
> >>>     -                * ADIN1300 (som rev 1.9 or later) is always at address 1. It
> >>>     -                * will be enabled automatically by U-Boot if detected.
> >>>     -                */
> >>>     -               ethernet-phy@1 {
> >>>     -                       reg = <1>;
> >>>                             adi,phy-output-clock = "125mhz-free-running";
> >>>     -                       status = "disabled";
> >>>                     };
> >>>             };
> >>>      };
> >>>     diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >>>     index debf4f6a3b..52172a03b1 100644
> >>>     ---_a/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >>>     +++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >>>     @@ -446,7 +446,7 @@ static int find_ethernet_phy(void)
> >>>       */
> >>>      int ft_board_setup(void *fdt, struct bd_info *bd)
> >>>      {
> >>>     -       int node_phy0, node_phy1, node_phy4;
> >>>     +       int node_phy, node_phy0, node_phy1, node_phy4;
> >>>             int ret, phy;
> >>>             bool enable_phy0 = false, enable_phy1 = false, enable_phy4 = false;
> >>>             enum board_type board;
> >>>     @@ -478,6 +478,10 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
> >>>                     return 0;
> >>>             }
> >>>
> >>>     +       // update U-Boot's own unified phy node phy address, if present
> >>>     +       node_phy = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/phy");
> >>>     +       ret = fdt_setprop_u32(fdt, node_phy, "reg", phy);
> >>>     +
> >>>             // update all phy nodes status
> >>>             node_phy0 = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/ethernet-phy@0");
> >>>             ret = fdt_setprop_string(fdt, node_phy0, "status", enable_phy0 ? "okay" : "disabled");
> >>>     --_
> >>>     2.37.1
> >>>



-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
