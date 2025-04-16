Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABE2C369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 22:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0465E82DE7;
	Thu, 17 Apr 2025 00:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eoQHHkl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2222F82DE7; Thu, 17 Apr 2025 00:34:58 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F04382CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 00:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so118818a91.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744842892; x=1745447692; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2chCondtjJK9X7hlighKM+7K61s6uPhB76Di/H+JFo=;
 b=eoQHHkl4ftn4iUAemGaQdFcosr1Rn6dswrKB37K6iWYkfkudG2LzapVgJSXBuo/mbr
 Y1d6ZMQbRgNYo8Ln41SvcY7zPVcZC+uE+uhUv1m/9R3vbfaczeL9LyzWxYoQtrNMxuES
 Fs2IVl3UWW6U0ht195Ejz0oPrT+4UlcyEqpJSpLLCfILO2S81ax42XHVY/2qvfQpM9jq
 g4EA23vWOuOKzVHhrSW3bW/8jxQuOhtjXbrd2xaPYTjtXO2Y9tmDPGhVk3mcYu23gukO
 3PvzbnS93/CQtXui+fDZW7zNIiN+w9jySbzEyQ7SLSPUyW3DOSUXYNTSOF1NWBIPUS9J
 3MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744842892; x=1745447692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2chCondtjJK9X7hlighKM+7K61s6uPhB76Di/H+JFo=;
 b=EqlomZEV5PkRpnYEjtbUPtuSDD4TovBJwl8EM5tXuRn72G4jn9ahGg6ojyg8m+oYrf
 GB3P4akbip6bEDWSyjah5DnSnZwF6i5VcWiILW6i02RFD9DlXDIJyZ0e6xct3GYKk2ND
 mlezRluHiJo1opnNoWeF1BRmPWSYatowdwHgcw4Fe7ZMZ2RaoANhv0Gc1gSIDa+vWr18
 tAP/WjvWqRfJyXEqWWJ2Sgp1cpt/s/wlScf7LKjFw6smtPMzRlOs0IOxOwU9MOmYQexd
 +ayAY8gheEgYra/yNel4Vi5NFPQpI0hSRfx79WCPoi7vpXLvLgxA9X7KX5aus6XihJVX
 Iueg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/N0bo+bsGTzTJWVIMom+ZD6uMgUaiXontLOUGp4u1KokKtinno1v88UtDKWoHeCkzLsrUyo=@lists.denx.de
X-Gm-Message-State: AOJu0YzxQ9HpT3TkZWtOEk2eQRuu/VG8r3Qqo0fB6/Y2V/HjViTF9L36
 pOdqS7mUJ4LftgLS/cK8AUE1YoNxZA6E4WeC56UVe3yKDZW+NnM4NUzQdSCxu2tX/JRWzuBL86L
 qX842Gi1u0kmmLU5qvKAC/u/WIek=
X-Gm-Gg: ASbGnct6AxPVEO/jpDfaN3T7JW2SuVX97jkLMt+1i3V2ZgSAUUxLBrBX9/IfgevVtg6
 WYt4b5bVhaRFwcYKUijnUOjFBXDMYMD9QCn/2mL/TGQLlFbRM/iPW+ogyNnHeOdmZXDmerk1DXa
 GJcUCcuRsDO8kCyCsfuyuMNA==
X-Google-Smtp-Source: AGHT+IH7SIL9JEjnwZxaisDa23sxCAHMmOIXHRLlsleyrDBtGmrkupG+qmkkwIYNwg9NQNNf4L0tpIO6hukYGyM2HPM=
X-Received: by 2002:a17:90b:1f83:b0:2ff:6ac2:c5a5 with SMTP id
 98e67ed59e1d1-3086415c582mr4518857a91.26.1744842891765; Wed, 16 Apr 2025
 15:34:51 -0700 (PDT)
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
In-Reply-To: <db2d623afd944df2bca6d1e4657d4031@dh-electronics.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 16 Apr 2025 17:34:39 -0500
X-Gm-Features: ATxdqUFN9qm1zHKWo08R4WVRCvn308OI6_03AFqmBHarhTKGOQCUlBz33uWv-MQ
Message-ID: <CAHCN7xKyoBQPeXDA90-kcBTw7BhObvn6PVzreoUQ5+GjiCewyg@mail.gmail.com>
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

On Wed, Apr 16, 2025 at 9:19=E2=80=AFAM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Wednesday, April 16, 2025 11:27 AM
> > On Tue, Apr 15, 2025 at 02:13:30PM -0300, Fabio Estevam wrote:
> >> On Tue, Apr 15, 2025 at 1:55=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> >>> Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kHz
> >>> oscillator clock in SPL DTs"") in place ? If so, try and revert it, d=
oes
> >>> it help ?
> >>
> >> It seems I have not pushed the "Revert "arm64: dts: imx8mn: Include 32=
kHz
> >> oscillator clock in SPL DTs" fix. Sorry about that.
> >>
> >> As Francesco is using imx8mp, then I guess we also need to do the same
> >> for imx8mp:
> >>
> >> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-b=
oot.dtsi
> >> index 6de9ab5d37cf..35af412f01b0 100644
> >> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> >> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> >> @@ -37,11 +37,6 @@
> >>         /delete-property/ assigned-clock-rates;
> >>  };
> >>
> >> -&osc_32k {
> >> -       bootph-pre-ram;
> >> -       bootph-all;
> >> -};
> >> -
> >>  &osc_24m {
> >>         bootph-pre-ram;
> >>         bootph-all;
> >>
> >> Does this fix the boot problem?
> >
> > My issue is not the boot. The issue is that USB is not working.
> >
> > With this patch applied nothing changes, the issue is not solved.
> >
> > Francesco
>
> Hello,
>
> I don't know if it is related or not, I noticed that Adam Ford's patches
> commit 6d33ca36e3b ("clk: imx8mm: register UART clocks") and
> commit 8999b76f238 ("clk: imx8mn: register UART clocks")
> use the former name "clock-osc-24m". But Marek's patch
> commit b4734c9c333 ("clk: imx: Convert clock-osc-* back to osc_*")
> converted clock-osc-* to osc_*. So I think the UART clocks should also
> use the current name osc_*.

I sent a fix for that, but back to the subject at hand.

I added some debug code to the clk driver to see which clock is failing:

u-boot=3D> usb start
starting USB...
Bus usb@38200000: clk_mux_fetch_parent_index hsio_axi
clk_mux_fetch_parent_index (parent) sys_pll2_500m
imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
500000000 reg: 0000000030388380
clk_mux_fetch_parent_index hsio_axi
clk_mux_fetch_parent_index (parent) sys_pll1_800m
imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
800000000 reg: 0000000030388380
clk_mux_fetch_parent_index usb_phy_ref
clk_mux_fetch_parent_index (parent) clock-osc-24m
Could not fetch index
Failed to get PHY0 for usb@38200000
Port not available.
u-boot=3D>

When I change the name back to "clock-osc-24m" in
imx8mp_usb_phy_ref_sels, the functionality returns.

u-boot=3D> usb start
starting USB...
Bus usb@38200000: clk_mux_fetch_parent_index hsio_axi
clk_mux_fetch_parent_index (parent) sys_pll2_500m
imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
500000000 reg: 0000000030388380
clk_mux_fetch_parent_index hsio_axi
clk_mux_fetch_parent_index (parent) sys_pll1_800m
imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
800000000 reg: 0000000030388380
clk_mux_fetch_parent_index usb_phy_ref
clk_mux_fetch_parent_index (parent) clock-osc-24m
Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
scanning bus usb@38200000 for devices... clk_mux_fetch_parent_index hsio_ax=
i
clk_mux_fetch_parent_index (parent) sys_pll1_800m
imx8m_clk_composite_divider_recalc_rate: name hsio_axi prate:
800000000 reg: 0000000030388380
4 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
u-boot=3D>

DM tree

Show the parent of usb_phy_ref is "clock-osc-24m"

u-boot=3D> dm tree
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 root          0  [ + ]   root_driver           root_driver
 clk           0  [ + ]   fixed_clock           |-- clock-osc-32k
 clk           1  [ + ]   fixed_clock           |-- clock-osc-24m
 clk          11  [ + ]   ccf_clk_mux           |   |-- dram_pll_ref_sel
 clk          16  [ + ]   imx_clk_pll1443x      |   |   `-- dram_pll
 clk          21  [ + ]   ccf_clk_mux           |   |       `-- dram_pll_by=
pass
 clk          26  [ + ]   clk_gate              |   |           `-- dram_pl=
l_out
 clk          94  [ + ]   ccf_clk_mux           |   |
`-- dram_core_clk
 clk          95  [   ]   imx_clk_gate2         |   |
 `-- dram1_root_clk
<snip>
 clk         126  [   ]   imx_clk_gate2         |   |-- usb_suspend_clk
 clk          82  [ + ]   clk_composite         |   `-- usb_phy_ref
 clk         127  [   ]   imx_clk_gate2         |       `-- usb_phy_root_cl=
k

The device tree node lists the 24m clock as:

osc_24m: clock-osc-24m

So it seems to me, we need to somehow address the translation from
clock-osc-24m back to osc_24m.

adam


>
> Regards
> Christoph
