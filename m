Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D82C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01AB88060;
	Wed, 27 Mar 2024 13:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YSF2YB3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E26C8803A; Wed, 27 Mar 2024 13:18:08 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D84488060
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29df0ca87d1so5517955a91.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711541883; x=1712146683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rb58YCh3dU+Xg2d56/AcSGBkM+AA+LqqHAd4UF3me9Q=;
 b=YSF2YB3QGJeiAwekHkCoSb3PkQsUPwGVIDisDD1l2NwpA7mqJa8ffXzXdxNPEVrcSA
 4czjW3MH3DostCdyaNGx6O12ErCuWKTsNpDDbCEgPYdNo89GHJKPrhTJmIk+A+0U8ZGo
 Apsl4mvx4Tkbo2Xfnr+5ycKOc2F7FFS9b68q37FWKjO3ClMqFy3jWB3gfpSKN6MyJL7e
 a+sShnk1ZoqGaK6OZmtrFthmPA62MVqjEIyResLAv1fe4FMBthR4UOMmhrA2ZQTuQD8c
 61xu1y6juSrLK4y9/dZ7BhtOi8uXsdWjS4l7MMAApxBAJAQACLMZwhXfRnUNjCYdrYWg
 FC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711541883; x=1712146683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rb58YCh3dU+Xg2d56/AcSGBkM+AA+LqqHAd4UF3me9Q=;
 b=s3Gtw40LYQGlhw7iY7m6iaSKQ6R+n7/VJTWy7KCvpTmWBnfsllE0BC+tKIrviVotDF
 o8qO3SZby+eW4NqtLiyrDITqXd9FHnc8C3sefmJdVMjaxBCPwSrEtMIVDpuxfFw6hLZ9
 h4rf0tLIx2AdjBEIBSAzok8RCMsdbGhXfMe3w3w+pI8etf7MsCwJj37YVUC9ODxra/xt
 8WJONl1mbAhh1t1ij4s97iK0Mlj51NrcwUSaM2YqNgY5JJIDi2OneknfQnJ46P1aYDNK
 i3RI3RZjQCe4A8n8Ur5lNn/1R6btr9f2w8fsWcA+hE5EiKd0i6x6SwcYtGJox9PEnPP0
 0TrA==
X-Gm-Message-State: AOJu0YxCS4qGswhCDQJaGAxrrA5BHLIyQCbXcK/uFf97tdwLe1xLg6Wf
 mwujLzKOAsGcUXvRwslaXxsJ3xfwjVMxHiFJMqmxPaAaqX6qSlGLSvbW5PXzzoTsLn21SGXRGE7
 NHHgYofvtbLnhU5cc13tI7R8rKSSNUbB0j20tZg==
X-Google-Smtp-Source: AGHT+IGjlp4uvtlRiFJIqCmf5xtDP74oWz8hnC9N3IFU6Ub8BtGC3y+5FYicOrO/pl/3MIkTv4wNPfkqnCMSOlwLHZo=
X-Received: by 2002:a17:90a:4944:b0:29b:b70d:463a with SMTP id
 c62-20020a17090a494400b0029bb70d463amr2509997pjh.12.1711541882942; Wed, 27
 Mar 2024 05:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220728070540.28554-1-josua@solid-run.com>
 <CA+EmdG5+QYxVo27C-u5W6FkuDgcoey4i-md9L4b9cs1gtsv+1g@mail.gmail.com>
 <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
In-Reply-To: <30c35e80-2015-4fac-b9dc-6902cc09c58e@solid-run.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 27 Mar 2024 13:17:51 +0100
Message-ID: <CAH9NwWd2smg+vC=hHx1XbRPS569Mxzr4HNghwA9DUQUyYf-OKA@mail.gmail.com>
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

My bisect showed me that after a device-tree sync the ethernet broke.

>
> please take a look at this patch, I suspect it will (hack-)fix your
> ethernet issue.
>

Yes.. it fixes the problem I am seeing.

>
> Unfortunately I had no time to revisit this yet and implement a correct solution.
>

Would it be okay for you if I look into a proper solution? I have a
handful of such devices here
that are already or will be used in a CI farm so I am interested in
using the latest U-Boot for them.

> sincerely
> Josua Mayer
>
> Am 28.07.22 um 09:08 schrieb Josua Mayer:
> > Please hold off merging this patch until someone tested it, I can not do so this week.
> > @Tom Can you confirm if this fixes the networking on your Cubox?
> > Also note that the phy-handle property may or may not be required, I am not sure.
> >
> > sincerely
> > Josua Mayer
> >
> > On Thu, Jul 28, 2022 at 7:05 AM Josua Mayer <josua@solid-run.com> wrote:
> >
> >     The i.MX6 Cubox-i and HummingBoards can have different PHYs at varying
> >     addresses. U-Boot needs to auto-detect which phy is actually present,
> >     and at which address it is responding.
> >
> >     Auto-detection from multiple phy nodes specified in device-tree does not
> >     currently work correct. As a work-around merge all three possible phys
> >     into one node with the special address 0xffffffff which indicates to the
> >     generic phy driver to probe all addresses.
> >     Also fixup this fake address before booting Linux, *if* booting with
> >     U-Boot's internal dtb.
> >
> >     Signed-off-by: Josua Mayer <josua@solid-run.com>
> >     Fixes: d0399a46e7cd
> >     ---
> >      arch/arm/dts/imx6qdl-sr-som.dtsi     | 30 +++++++++-------------------
> >      board/solidrun/mx6cuboxi/mx6cuboxi.c |  6 +++++-
> >      2 files changed, 14 insertions(+), 22 deletions(-)
> >
> >     diff --git a/arch/arm/dts/imx6qdl-sr-som.dtsi b/arch/arm/dts/imx6qdl-sr-som.dtsi
> >     index ce543e325c..2d7cbc26b3 100644
> >     ---_a/arch/arm/dts/imx6qdl-sr-som.dtsi
> >     +++ b/arch/arm/dts/imx6qdl-sr-som.dtsi
> >     @@ -53,6 +53,7 @@
> >      &fec {
> >             pinctrl-names = "default";
> >             pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
> >     +       phy-handle = <&phy>;
> >             phy-mode = "rgmii-id";
> >
> >             /*
> >     @@ -68,30 +69,17 @@
> >                     #address-cells = <1>;
> >                     #size-cells = <0>;
> >
> >     -               /*
> >     -                * The PHY can appear at either address 0 or 4 due to the
> >     -                * configuration (LED) pin not being pulled sufficiently.
> >     -                */
> >     -               ethernet-phy@0 {
> >     -                       reg = <0>;
> >     +               phy: ethernet-phy@0 {
> >     +                       /*
> >     +                        * The PHY can appear either:
> >     +                        * - AR8035: at address 0 or 4
> >     +                        * - ADIN1300: at address 1
> >     +                        * Actual address being detected at runtime.
> >     +                        */
> >     +                       reg = <0xffffffff>;
> >                             qca,clk-out-frequency = <125000000>;
> >                             qca,smarteee-tw-us-1g = <24>;
> >     -               };
> >     -
> >     -               ethernet-phy@4 {
> >     -                       reg = <4>;
> >     -                       qca,clk-out-frequency = <125000000>;
> >     -                       qca,smarteee-tw-us-1g = <24>;
> >     -               };
> >     -
> >     -               /*
> >     -                * ADIN1300 (som rev 1.9 or later) is always at address 1. It
> >     -                * will be enabled automatically by U-Boot if detected.
> >     -                */
> >     -               ethernet-phy@1 {
> >     -                       reg = <1>;
> >                             adi,phy-output-clock = "125mhz-free-running";
> >     -                       status = "disabled";
> >                     };
> >             };
> >      };
> >     diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >     index debf4f6a3b..52172a03b1 100644
> >     ---_a/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >     +++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> >     @@ -446,7 +446,7 @@ static int find_ethernet_phy(void)
> >       */
> >      int ft_board_setup(void *fdt, struct bd_info *bd)
> >      {
> >     -       int node_phy0, node_phy1, node_phy4;
> >     +       int node_phy, node_phy0, node_phy1, node_phy4;
> >             int ret, phy;
> >             bool enable_phy0 = false, enable_phy1 = false, enable_phy4 = false;
> >             enum board_type board;
> >     @@ -478,6 +478,10 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
> >                     return 0;
> >             }
> >
> >     +       // update U-Boot's own unified phy node phy address, if present
> >     +       node_phy = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/phy");
> >     +       ret = fdt_setprop_u32(fdt, node_phy, "reg", phy);
> >     +
> >             // update all phy nodes status
> >             node_phy0 = fdt_path_offset(fdt, "/soc/bus@2100000/ethernet@2188000/mdio/ethernet-phy@0");
> >             ret = fdt_setprop_string(fdt, node_phy0, "status", enable_phy0 ? "okay" : "disabled");
> >     --_
> >     2.37.1
> >

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
