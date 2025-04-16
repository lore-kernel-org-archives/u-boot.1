Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C505EC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 23:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0389C82B3F;
	Thu, 17 Apr 2025 01:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wm4NXEg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3786382B44; Thu, 17 Apr 2025 01:36:00 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DFB82B33
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 01:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30572effb26so125993a91.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744846556; x=1745451356; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOxCEtl+oc1l6+7sbEQy7d8K493JdNr5/Yrb9LEE2Zo=;
 b=Wm4NXEg3wQeXWWww1snGFQ+Rzix8QWoBc5FcypcyX5++qDP1Gt0v9kW3Uoe2SuZDI3
 yyg651WAwYbePElf/rVP55DGDX+5dJCSV/xXnLm+p/HSXV/ICbJAaBR+Ursg4/85pLfq
 oKCaWqfqSKGIvpxJofVf8Dqy439YwaVTxpD4QurgdNO4PZADhcXEP8jOmyT7xPyHVS4p
 eegGtAm0UkhxTmu4BCN8+k2KHpBFAVUa4EyUb8xlReCEvPxP27otXQKX6P5OyZU2XThJ
 pyWW3aM62Hio0AdV1VP8yTIoCapjIIwXDsMQ/UFyGDgqipxHSh/HugpgaNiVlmdz5Sx7
 w2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744846556; x=1745451356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOxCEtl+oc1l6+7sbEQy7d8K493JdNr5/Yrb9LEE2Zo=;
 b=QkfpQf8BCXO4gy4xAWbXSRPc6+rsQavPNLrlEc4SjXi0l7kb6H2uaSIzvR0n4jUyuR
 CLTZY0VdaEOpIUvDSIKP6w0cjwSiNCI8w8YYI9/O2CphsZl5IhovBiqL28z2UcgqCRki
 RQQskaRs4y5L3gkA575QEIFV1muYSUU6vNBKmzO4986RM1cHgLn8sTJBL/NdXn5mGTXc
 Ae3s/OEdqXOPv7Mt3x+jJwnKAqk+ybfnOTLl2IjFbQAG7Lw+nD3whm+SwyCEwp8x3uVD
 hJs0ZhhhwT45JYKnshkTAhJ7NSgdQk/y+HB8mdwgaTZ9cSpv+qoGZhDFY0EARSSvx8Fh
 qbBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI43F60r/J/th7F+ptdVRRvp1T1PZUcvvOEJVaatm0sNHOiNdUBKC6WCbfcxvc1mhjjLIctnA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv1iIMuTyEXQT1gQ77/peVhdSwN+qAkms6ZGYeBuLCsKkuTzk+
 JAVCC8HQ2/YBb6O56jvPk5Gu0unBKTatsQ5m+bzPESwsaVNbrWV4DIxNpnfY2eSIl7SSwEnRP48
 cXLm1XzZaf+sHuuMAqTp2vuuTXXbYZkX2
X-Gm-Gg: ASbGncsPmhA4+mK10y/wB7SscglQaq71PPUs/22OZsAk20f8VpMpa5ZDDYPAPIuLjIm
 YzpkV3kFiVwO0GVeNtbrJ7+xJVUKmAjEMvahxfLB6Os1l96MIhGbu2GHc1hCYM0JLHLsz+r9/0r
 PHct1y42kiOUY4q/Bbt6jRdTs7kNiISMhM
X-Google-Smtp-Source: AGHT+IFFv3A4N6qBWsw1szKi09QNb4y5AxEn0xP2VM0GqGmvW0OUUopUig9LRVTVBKKRmdfcE7gmNKiM8AnReGYjDeU=
X-Received: by 2002:a17:90b:1f88:b0:2f6:d266:f462 with SMTP id
 98e67ed59e1d1-30864172a14mr5293927a91.35.1744846556067; Wed, 16 Apr 2025
 16:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
 <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
 <CAOMZO5B=j=k8U6to2TDzohS11j4hPWQOho9bdrYCPe0WXtrQjw@mail.gmail.com>
 <20250416092639.GA24345@francesco-nb>
 <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
 <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
In-Reply-To: <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 16 Apr 2025 18:35:44 -0500
X-Gm-Features: ATxdqUGWTuBAVi4wCCTRWpEMDsC_XyAULR1FhfKrcoeWWaP3wIBoU5Gk61grvmc
Message-ID: <CAHCN7xLgS7FZ4ajbBa+p-_w_s6oHnfMYcZEMsNBNkqkgAG-7Jw@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>
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

On Wed, Apr 16, 2025 at 5:34=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Wed, Apr 16, 2025 at 9:19=E2=80=AFAM Christoph Niedermaier
> <cniedermaier@dh-electronics.com> wrote:
> >
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Wednesday, April 16, 2025 11:27 AM
> > > On Tue, Apr 15, 2025 at 02:13:30PM -0300, Fabio Estevam wrote:
> > >> On Tue, Apr 15, 2025 at 1:55=E2=80=AFPM Marek Vasut <marex@denx.de> =
wrote:
> > >>> Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kH=
z
> > >>> oscillator clock in SPL DTs"") in place ? If so, try and revert it,=
 does
> > >>> it help ?
> > >>
> > >> It seems I have not pushed the "Revert "arm64: dts: imx8mn: Include =
32kHz
> > >> oscillator clock in SPL DTs" fix. Sorry about that.
> > >>
> > >> As Francesco is using imx8mp, then I guess we also need to do the sa=
me
> > >> for imx8mp:
> > >>
> > >> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u=
-boot.dtsi
> > >> index 6de9ab5d37cf..35af412f01b0 100644
> > >> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> > >> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> > >> @@ -37,11 +37,6 @@
> > >>         /delete-property/ assigned-clock-rates;
> > >>  };
> > >>
> > >> -&osc_32k {
> > >> -       bootph-pre-ram;
> > >> -       bootph-all;
> > >> -};
> > >> -
> > >>  &osc_24m {
> > >>         bootph-pre-ram;
> > >>         bootph-all;
> > >>
> > >> Does this fix the boot problem?
> > >
> > > My issue is not the boot. The issue is that USB is not working.
> > >
> > > With this patch applied nothing changes, the issue is not solved.
> > >
> > > Francesco
> >
> > Hello,
> >
> > I don't know if it is related or not, I noticed that Adam Ford's patche=
s
> > commit 6d33ca36e3b ("clk: imx8mm: register UART clocks") and
> > commit 8999b76f238 ("clk: imx8mn: register UART clocks")
> > use the former name "clock-osc-24m". But Marek's patch
> > commit b4734c9c333 ("clk: imx: Convert clock-osc-* back to osc_*")
> > converted clock-osc-* to osc_*. So I think the UART clocks should also
> > use the current name osc_*.
>
> I sent a fix for that, but back to the subject at hand.
>
> I added some debug code to the clk driver to see which clock is failing:
>
> u-boot=3D> usb start
> starting USB...
> Bus usb@38200000: clk_mux_fetch_parent_index hsio_axi
> clk_mux_fetch_parent_index (parent) sys_pll2_500m
> imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
> 500000000 reg: 0000000030388380
> clk_mux_fetch_parent_index hsio_axi
> clk_mux_fetch_parent_index (parent) sys_pll1_800m
> imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
> 800000000 reg: 0000000030388380
> clk_mux_fetch_parent_index usb_phy_ref
> clk_mux_fetch_parent_index (parent) clock-osc-24m
> Could not fetch index
> Failed to get PHY0 for usb@38200000
> Port not available.
> u-boot=3D>
>
> When I change the name back to "clock-osc-24m" in
> imx8mp_usb_phy_ref_sels, the functionality returns.
>
> u-boot=3D> usb start
> starting USB...
> Bus usb@38200000: clk_mux_fetch_parent_index hsio_axi
> clk_mux_fetch_parent_index (parent) sys_pll2_500m
> imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
> 500000000 reg: 0000000030388380
> clk_mux_fetch_parent_index hsio_axi
> clk_mux_fetch_parent_index (parent) sys_pll1_800m
> imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
> 800000000 reg: 0000000030388380
> clk_mux_fetch_parent_index usb_phy_ref
> clk_mux_fetch_parent_index (parent) clock-osc-24m
> Register 2000140 NbrPorts 2
> Starting the controller
> USB XHCI 1.10
> scanning bus usb@38200000 for devices... clk_mux_fetch_parent_index hsio_=
axi
> clk_mux_fetch_parent_index (parent) sys_pll1_800m
> imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
> 800000000 reg: 0000000030388380
> 4 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> u-boot=3D>
>
> DM tree
>
> Show the parent of usb_phy_ref is "clock-osc-24m"
>
> u-boot=3D> dm tree
>  Class     Seq    Probed  Driver                Name
> -----------------------------------------------------------
>  root          0  [ + ]   root_driver           root_driver
>  clk           0  [ + ]   fixed_clock           |-- clock-osc-32k
>  clk           1  [ + ]   fixed_clock           |-- clock-osc-24m
>  clk          11  [ + ]   ccf_clk_mux           |   |-- dram_pll_ref_sel
>  clk          16  [ + ]   imx_clk_pll1443x      |   |   `-- dram_pll
>  clk          21  [ + ]   ccf_clk_mux           |   |       `-- dram_pll_=
bypass
>  clk          26  [ + ]   clk_gate              |   |           `-- dram_=
pll_out
>  clk          94  [ + ]   ccf_clk_mux           |   |
> `-- dram_core_clk
>  clk          95  [   ]   imx_clk_gate2         |   |
>  `-- dram1_root_clk
> <snip>
>  clk         126  [   ]   imx_clk_gate2         |   |-- usb_suspend_clk
>  clk          82  [ + ]   clk_composite         |   `-- usb_phy_ref
>  clk         127  [   ]   imx_clk_gate2         |       `-- usb_phy_root_=
clk
>
> The device tree node lists the 24m clock as:
>
> osc_24m: clock-osc-24m
>
> So it seems to me, we need to somehow address the translation from
> clock-osc-24m back to osc_24m.

From what I can tell, the name of the clock is osc_24m as defined by
clock-output-names in the node, but we are not looking at that entry.
There is a function, dev_read_string_index, which appears to let us
look for the that string, and it returns so we can sort through the
list.  Adding some debug code, a few other functions look for the
index, and they appear to be returning valid numbers, and the match
for osc_24m returns an index  of 0 which appear correct.

With the following patch, the 'usb start' command now works for me, so
I would expect the usb peripheral mode would too.

adam

Can you try the following patch and see if it works?

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index d7411f8f282..de669164939 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -31,6 +31,7 @@
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <dm/read.h>
 #include <dm/uclass.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
@@ -104,7 +105,7 @@ u8 clk_mux_get_parent(struct clk *clk)
 int clk_mux_fetch_parent_index(struct clk *clk, struct clk *parent)
 {
        struct clk_mux *mux =3D to_clk_mux(clk);
-
+       const char *name;
        int i;

        if (!parent)
@@ -113,6 +114,9 @@ int clk_mux_fetch_parent_index(struct clk *clk,
struct clk *parent)
        for (i =3D 0; i < mux->num_parents; i++) {
                if (!strcmp(parent->dev->name, mux->parent_names[i]))
                        return i;
+               dev_read_string_index(parent->dev,
"clock-output-names", i, &name);
+               if (!strcmp(name, mux->parent_names[i]))
+                       return i;
                if (!strcmp(parent->dev->name,
                            clk_resolve_parent_clk(clk->dev,
                                                   mux->parent_names[i])))



>
> adam
>
>
> >
> > Regards
> > Christoph
