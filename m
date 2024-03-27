Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0648C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 06:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D9C880AA;
	Wed, 27 Mar 2024 07:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hwB4kS17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F2C880AA; Wed, 27 Mar 2024 07:21:25 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3FD48811C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56c36c67deaso862528a12.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711520478; x=1712125278; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHCjuu8oQ0DRZp3njQTmEbw0l9O6qVAZNL2xKagCwS0=;
 b=hwB4kS17J5YQktjuWqCAcZyGxQLc/iSWEVE7cMnJno5peFOlUnUrOOILIwzwkohH92
 /ZqzPcP0NImPBQ992YDWxvETO3baE3TFo1y67PQAuiRaIRNKTOPOAvsjwqXbQtBXbb4e
 eJ8LZkIguCGlWLecx0/pc+ifv+zAjn5gUaE5kI47ntWeLVsS4X0UsbQxc5khoSr0Ai3k
 pZXNf9aABjjNdhIJ9QIQTt6dDIKd1IYqvKPFbZYWbq0GyPOGiuzeVEaY65ayESnROdBK
 03a3HlNiQ16LHO3/knPn6246nYIMjqnJupumkM6QR+HlnUNJnDcnnKJLGin1nWXILi9+
 4gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711520478; x=1712125278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHCjuu8oQ0DRZp3njQTmEbw0l9O6qVAZNL2xKagCwS0=;
 b=KjDP8+sdX2BcD/dUtrvKiykyj+FxJJMTAgJzqNkZvxwyl9rQY9tADRGJcLdWc+vH1L
 VQpQ8b9IbupEIUdzxPQjiPJ9cbZZhwi5CoxY1s9dJj51Q/WhaLRDzoZp+8klIrusSSoe
 ZCoB1IwRn68QR2v3caWknHvxYDQ3GT8jAbkOnBCdcsFpC1Oct/oLsVg1MiOUASEt9qU/
 rSUn7720ptCLgGn0IJnGWGAk4E2V4mk46NFM+K3CZQ0Tp8fjUR1vKYseMUjvRGZX0mPe
 XGHCv1nex1J1FuukRNv5EAh7S+PiPVwaWCDoFfCeG2Faq2AJ70oFONrh8xj2Ls8IXk5G
 FYgA==
X-Gm-Message-State: AOJu0Yw4RBdjJ7vQXKXlh3ZruGAjqmZDGl1mNRgSm1V5jIiBdDlMJ2aP
 ageQIaiwIZsuovGBLcxXqtxgV/7mFbm0Hl8Z/cSjLYckUvDWTJ2PDBGG1elbdZGoyqDT0tbZ5rs
 egmEne250WDnTsKHUWjZkrKKjuOg=
X-Google-Smtp-Source: AGHT+IFX2o9DzKXJ7nPc5LxM1gH9F+xi5zy6PXvTtnCnAq+wGx1gPWIbRsUpXJhXEY5wABGy1YKWxH27fnuCQTPfH4o=
X-Received: by 2002:a50:ccda:0:b0:56b:d9b6:3911 with SMTP id
 b26-20020a50ccda000000b0056bd9b63911mr159960edj.35.1711520478375; Tue, 26 Mar
 2024 23:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240326211214.577-1-mibodhi@gmail.com>
 <CAFA6WYNtk4Dxx4RqqZ6BKw7Sb03zZuYyc6wcHxfZ9uQkn=DEBQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNtk4Dxx4RqqZ6BKw7Sb03zZuYyc6wcHxfZ9uQkn=DEBQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 26 Mar 2024 23:21:02 -0700
Message-ID: <CAJaLiFwyPMJAzQ8SDoaefs1SSjOYLtG6uV0CTjRbWP_LbkGuoQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: kirkwood: Remove DTS files for Kirkwood boards
To: Sumit Garg <sumit.garg@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Michael Walle <michael@walle.cc>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Guinot <simon.guinot@sequanux.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Sumit,

On Tue, Mar 26, 2024 at 9:30=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 27 Mar 2024 at 02:43, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Remove DTS and DTSI files for Kirkwood boards that have upstream suppor=
ts.
>
> nit: s/supports/support/
>
> >
> > This patch depends on
> > "arm: dts: kirkwood: Enable upstream DT on Kirkwood boards"
> > https://patchwork.ozlabs.org/project/uboot/patch/20240322021747.14873-1=
-mibodhi@gmail.com/
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  arch/arm/dts/Makefile                         |  28 +-
> >  arch/arm/dts/kirkwood-6192.dtsi               |  88 --
> >  arch/arm/dts/kirkwood-6281.dtsi               |  90 --
> >  arch/arm/dts/kirkwood-6282.dtsi               | 161 ----
> >  arch/arm/dts/kirkwood-98dx4122.dtsi           |  53 --
> >  arch/arm/dts/kirkwood-blackarmor-nas220.dts   | 172 ----
> >  arch/arm/dts/kirkwood-d2net.dts               |  45 -
> >  arch/arm/dts/kirkwood-dns325.dts              |  63 --
> >  arch/arm/dts/kirkwood-dnskw.dtsi              | 235 -----
> >  arch/arm/dts/kirkwood-dockstar.dts            | 110 ---
> >  arch/arm/dts/kirkwood-dreamplug.dts           | 131 ---
> >  arch/arm/dts/kirkwood-ds109.dts               |  40 -
> >  arch/arm/dts/kirkwood-goflexnet.dts           | 190 ----
> >  .../arm/dts/kirkwood-guruplug-server-plus.dts | 133 ---
> >  arch/arm/dts/kirkwood-ib62x0.dts              | 146 ---
> >  arch/arm/dts/kirkwood-iconnect.dts            | 195 ----
> >  arch/arm/dts/kirkwood-is2.dts                 |  40 -
> >  arch/arm/dts/kirkwood-lschlv2.dts             |  20 -
> >  arch/arm/dts/kirkwood-lsxhl.dts               |  20 -
> >  arch/arm/dts/kirkwood-lsxl.dtsi               | 241 -----
> >  arch/arm/dts/kirkwood-net2big.dts             |  63 --
> >  arch/arm/dts/kirkwood-netxbig.dtsi            | 232 -----
> >  arch/arm/dts/kirkwood-ns2-common.dtsi         |  97 --
> >  arch/arm/dts/kirkwood-ns2.dts                 |  40 -
> >  arch/arm/dts/kirkwood-ns2lite.dts             |  35 -
> >  arch/arm/dts/kirkwood-ns2max.dts              |  59 --
> >  arch/arm/dts/kirkwood-ns2mini.dts             |  60 --
> >  arch/arm/dts/kirkwood-nsa310s.dts             | 319 -------
> >  arch/arm/dts/kirkwood-nsa325.dts              | 231 -----
> >  arch/arm/dts/kirkwood-nsa3x0-common.dtsi      | 157 ----
> >  arch/arm/dts/kirkwood-openrd-base.dts         |  39 -
> >  arch/arm/dts/kirkwood-openrd-client.dts       |  73 --
> >  arch/arm/dts/kirkwood-openrd-ultimate.dts     |  55 --
> >  arch/arm/dts/kirkwood-openrd.dtsi             | 122 ---
> >  arch/arm/dts/kirkwood-pogo_e02.dts            | 132 ---
> >  arch/arm/dts/kirkwood-pogoplug-series-4.dts   | 180 ----
> >  arch/arm/dts/kirkwood-sheevaplug-common.dtsi  | 104 ---
> >  arch/arm/dts/kirkwood-sheevaplug.dts          |  42 -
> >  arch/arm/dts/kirkwood-synology.dtsi           | 855 ------------------
> >  arch/arm/dts/kirkwood.dtsi                    | 393 --------
> >  40 files changed, 1 insertion(+), 5488 deletions(-)
>
> Glad to see this diff stat.

Really appreciate your hard work.

All the best,
Tony

>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
> >  delete mode 100644 arch/arm/dts/kirkwood-6192.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-6281.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-6282.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-98dx4122.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-blackarmor-nas220.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-d2net.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-dns325.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-dnskw.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-dockstar.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-dreamplug.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-ds109.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-goflexnet.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-guruplug-server-plus.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-ib62x0.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-iconnect.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-is2.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-lschlv2.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-lsxhl.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-lsxl.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-net2big.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-netxbig.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-ns2-common.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-ns2.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-ns2lite.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-ns2max.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-ns2mini.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-nsa310s.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-nsa325.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-nsa3x0-common.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-openrd-base.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-openrd-client.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-openrd-ultimate.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-openrd.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-pogo_e02.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-pogoplug-series-4.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug-common.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood-sheevaplug.dts
> >  delete mode 100644 arch/arm/dts/kirkwood-synology.dtsi
> >  delete mode 100644 arch/arm/dts/kirkwood.dtsi
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index d85a33055c..896476a823 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -47,33 +47,7 @@ dtb-$(CONFIG_ARCH_DAVINCI) +=3D \
> >
> >  dtb-$(CONFIG_ARCH_KIRKWOOD) +=3D \
> >         kirkwood-atl-sbx81lifkw.dtb \
> > -       kirkwood-atl-sbx81lifxcat.dtb \
> > -       kirkwood-blackarmor-nas220.dtb \
> > -       kirkwood-d2net.dtb \
> > -       kirkwood-dns325.dtb \
> > -       kirkwood-dockstar.dtb \
> > -       kirkwood-dreamplug.dtb \
> > -       kirkwood-ds109.dtb \
> > -       kirkwood-goflexnet.dtb \
> > -       kirkwood-guruplug-server-plus.dtb \
> > -       kirkwood-ib62x0.dtb \
> > -       kirkwood-iconnect.dtb \
> > -       kirkwood-is2.dtb \
> > -       kirkwood-lsxhl.dtb \
> > -       kirkwood-lschlv2.dtb \
> > -       kirkwood-net2big.dtb \
> > -       kirkwood-ns2.dtb \
> > -       kirkwood-ns2lite.dtb \
> > -       kirkwood-ns2max.dtb \
> > -       kirkwood-ns2mini.dtb \
> > -       kirkwood-nsa310s.dtb \
> > -       kirkwood-nsa325.dtb \
> > -       kirkwood-openrd-base.dtb \
> > -       kirkwood-openrd-client.dtb \
> > -       kirkwood-openrd-ultimate.dtb \
> > -       kirkwood-pogo_e02.dtb \
> > -       kirkwood-pogoplug-series-4.dtb \
> > -       kirkwood-sheevaplug.dtb
> > +       kirkwood-atl-sbx81lifxcat.dtb
> >
> >  dtb-$(CONFIG_MACH_S900) +=3D \
> >         bubblegum_96.dtb
> > diff --git a/arch/arm/dts/kirkwood-6192.dtsi b/arch/arm/dts/kirkwood-61=
92.dtsi
> > deleted file mode 100644
> > index 396bcba08a..0000000000
> > --- a/arch/arm/dts/kirkwood-6192.dtsi
> > +++ /dev/null
> > @@ -1,88 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/ {
> > -       mbus@f1000000 {
> > -               pciec: pcie@82000000 {
> > -                       compatible =3D "marvell,kirkwood-pcie";
> > -                       status =3D "disabled";
> > -                       device_type =3D "pci";
> > -
> > -                       #address-cells =3D <3>;
> > -                       #size-cells =3D <2>;
> > -
> > -                       bus-range =3D <0x00 0xff>;
> > -
> > -                       ranges =3D
> > -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01=
) 0x40000 0 0x00002000
> > -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8=
) 0       1 0 /* Port 0.0 MEM */
> > -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0=
) 0       1 0 /* Port 0.0 IO  */>;
> > -
> > -                       pcie0: pcie@1,0 {
> > -                               device_type =3D "pci";
> > -                               assigned-addresses =3D <0x82000800 0 0x=
00040000 0 0x2000>;
> > -                               reg =3D <0x0800 0 0 0 0>;
> > -                               #address-cells =3D <3>;
> > -                               #size-cells =3D <2>;
> > -                               #interrupt-cells =3D <1>;
> > -                               ranges =3D <0x82000000 0 0 0x82000000 0=
x1 0 1 0
> > -                                         0x81000000 0 0 0x81000000 0x1=
 0 1 0>;
> > -                               bus-range =3D <0x00 0xff>;
> > -                               interrupt-map-mask =3D <0 0 0 0>;
> > -                               interrupt-map =3D <0 0 0 0 &intc 9>;
> > -                               marvell,pcie-port =3D <0>;
> > -                               marvell,pcie-lane =3D <0>;
> > -                               clocks =3D <&gate_clk 2>;
> > -                               status =3D "disabled";
> > -                       };
> > -               };
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       compatible =3D "marvell,88f6192-pinctrl";
> > -
> > -                       pmx_sata0: pmx-sata0 {
> > -                               marvell,pins =3D "mpp5", "mpp21", "mpp2=
3";
> > -                               marvell,function =3D "sata0";
> > -                       };
> > -                       pmx_sata1: pmx-sata1 {
> > -                               marvell,pins =3D "mpp4", "mpp20", "mpp2=
2";
> > -                               marvell,function =3D "sata1";
> > -                       };
> > -                       pmx_sdio: pmx-sdio {
> > -                               marvell,pins =3D "mpp12", "mpp13", "mpp=
14",
> > -                                              "mpp15", "mpp16", "mpp17=
";
> > -                               marvell,function =3D "sdio";
> > -                       };
> > -               };
> > -
> > -               rtc: rtc@10300 {
> > -                       compatible =3D "marvell,kirkwood-rtc", "marvell=
,orion-rtc";
> > -                       reg =3D <0x10300 0x20>;
> > -                       interrupts =3D <53>;
> > -                       clocks =3D <&gate_clk 7>;
> > -               };
> > -
> > -               sata: sata@80000 {
> > -                       compatible =3D "marvell,orion-sata";
> > -                       reg =3D <0x80000 0x5000>;
> > -                       interrupts =3D <21>;
> > -                       clocks =3D <&gate_clk 14>, <&gate_clk 15>;
> > -                       clock-names =3D "0", "1";
> > -                       phys =3D <&sata_phy0>, <&sata_phy1>;
> > -                       phy-names =3D "port0", "port1";
> > -                       status =3D "disabled";
> > -               };
> > -
> > -               sdio: mvsdio@90000 {
> > -                       compatible =3D "marvell,orion-sdio";
> > -                       reg =3D <0x90000 0x200>;
> > -                       interrupts =3D <28>;
> > -                       clocks =3D <&gate_clk 4>;
> > -                       bus-width =3D <4>;
> > -                       cap-sdio-irq;
> > -                       cap-sd-highspeed;
> > -                       cap-mmc-highspeed;
> > -                       status =3D "disabled";
> > -               };
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-6281.dtsi b/arch/arm/dts/kirkwood-62=
81.dtsi
> > deleted file mode 100644
> > index faa05849a4..0000000000
> > --- a/arch/arm/dts/kirkwood-6281.dtsi
> > +++ /dev/null
> > @@ -1,90 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/ {
> > -       mbus@f1000000 {
> > -               pciec: pcie@82000000 {
> > -                       compatible =3D "marvell,kirkwood-pcie";
> > -                       status =3D "disabled";
> > -                       device_type =3D "pci";
> > -
> > -                       #address-cells =3D <3>;
> > -                       #size-cells =3D <2>;
> > -
> > -                       bus-range =3D <0x00 0xff>;
> > -
> > -                       ranges =3D
> > -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01=
) 0x40000 0 0x00002000
> > -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8=
) 0       1 0 /* Port 0.0 MEM */
> > -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0=
) 0       1 0 /* Port 0.0 IO  */>;
> > -
> > -                       pcie0: pcie@1,0 {
> > -                               device_type =3D "pci";
> > -                               assigned-addresses =3D <0x82000800 0 0x=
00040000 0 0x2000>;
> > -                               reg =3D <0x0800 0 0 0 0>;
> > -                               #address-cells =3D <3>;
> > -                               #size-cells =3D <2>;
> > -                               #interrupt-cells =3D <1>;
> > -                               ranges =3D <0x82000000 0 0 0x82000000 0=
x1 0 1 0
> > -                                         0x81000000 0 0 0x81000000 0x1=
 0 1 0>;
> > -                               bus-range =3D <0x00 0xff>;
> > -                               interrupt-map-mask =3D <0 0 0 0>;
> > -                               interrupt-map =3D <0 0 0 0 &intc 9>;
> > -                               marvell,pcie-port =3D <0>;
> > -                               marvell,pcie-lane =3D <0>;
> > -                               clocks =3D <&gate_clk 2>;
> > -                               status =3D "disabled";
> > -                       };
> > -               };
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       compatible =3D "marvell,88f6281-pinctrl";
> > -
> > -                       pmx_sata0: pmx-sata0 {
> > -                               marvell,pins =3D "mpp5", "mpp21", "mpp2=
3";
> > -                               marvell,function =3D "sata0";
> > -                       };
> > -                       pmx_sata1: pmx-sata1 {
> > -                               marvell,pins =3D "mpp4", "mpp20", "mpp2=
2";
> > -                               marvell,function =3D "sata1";
> > -                       };
> > -                       pmx_sdio: pmx-sdio {
> > -                               marvell,pins =3D "mpp12", "mpp13", "mpp=
14",
> > -                                              "mpp15", "mpp16", "mpp17=
";
> > -                               marvell,function =3D "sdio";
> > -                       };
> > -               };
> > -
> > -               rtc: rtc@10300 {
> > -                       compatible =3D "marvell,kirkwood-rtc", "marvell=
,orion-rtc";
> > -                       reg =3D <0x10300 0x20>;
> > -                       interrupts =3D <53>;
> > -                       clocks =3D <&gate_clk 7>;
> > -               };
> > -
> > -               sata: sata@80000 {
> > -                       compatible =3D "marvell,orion-sata";
> > -                       reg =3D <0x80000 0x5000>;
> > -                       interrupts =3D <21>;
> > -                       clocks =3D <&gate_clk 14>, <&gate_clk 15>;
> > -                       clock-names =3D "0", "1";
> > -                       phys =3D <&sata_phy0>, <&sata_phy1>;
> > -                       phy-names =3D "port0", "port1";
> > -                       status =3D "disabled";
> > -               };
> > -
> > -               sdio: mvsdio@90000 {
> > -                       compatible =3D "marvell,orion-sdio";
> > -                       reg =3D <0x90000 0x200>;
> > -                       interrupts =3D <28>;
> > -                       clocks =3D <&gate_clk 4>;
> > -                       pinctrl-0 =3D <&pmx_sdio>;
> > -                       pinctrl-names =3D "default";
> > -                       bus-width =3D <4>;
> > -                       cap-sdio-irq;
> > -                       cap-sd-highspeed;
> > -                       cap-mmc-highspeed;
> > -                       status =3D "disabled";
> > -               };
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-6282.dtsi b/arch/arm/dts/kirkwood-62=
82.dtsi
> > deleted file mode 100644
> > index e732c501ea..0000000000
> > --- a/arch/arm/dts/kirkwood-6282.dtsi
> > +++ /dev/null
> > @@ -1,161 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/ {
> > -       mbus@f1000000 {
> > -               pciec: pcie@82000000 {
> > -                       compatible =3D "marvell,kirkwood-pcie";
> > -                       status =3D "disabled";
> > -                       device_type =3D "pci";
> > -
> > -                       #address-cells =3D <3>;
> > -                       #size-cells =3D <2>;
> > -
> > -                       bus-range =3D <0x00 0xff>;
> > -
> > -                       ranges =3D
> > -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01=
) 0x40000 0 0x00002000
> > -                               0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01=
) 0x44000 0 0x00002000
> > -                               0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01=
) 0x80000 0 0x00002000
> > -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8=
) 0       1 0 /* Port 0.0 MEM */
> > -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0=
) 0       1 0 /* Port 0.0 IO  */
> > -                               0x82000000 0x2 0     MBUS_ID(0x04, 0xd8=
) 0       1 0 /* Port 1.0 MEM */
> > -                               0x81000000 0x2 0     MBUS_ID(0x04, 0xd0=
) 0       1 0 /* Port 1.0 IO  */>;
> > -
> > -                       pcie0: pcie@1,0 {
> > -                               device_type =3D "pci";
> > -                               assigned-addresses =3D <0x82000800 0 0x=
00040000 0 0x2000>;
> > -                               reg =3D <0x0800 0 0 0 0>;
> > -                               #address-cells =3D <3>;
> > -                               #size-cells =3D <2>;
> > -                               #interrupt-cells =3D <1>;
> > -                               ranges =3D <0x82000000 0 0 0x82000000 0=
x1 0 1 0
> > -                                         0x81000000 0 0 0x81000000 0x1=
 0 1 0>;
> > -                               bus-range =3D <0x00 0xff>;
> > -                               interrupt-names =3D "intx", "error";
> > -                               interrupts =3D <9>, <44>;
> > -                               interrupt-map-mask =3D <0 0 0 7>;
> > -                               interrupt-map =3D <0 0 0 1 &pcie0_intc =
0>,
> > -                                               <0 0 0 2 &pcie0_intc 1>=
,
> > -                                               <0 0 0 3 &pcie0_intc 2>=
,
> > -                                               <0 0 0 4 &pcie0_intc 3>=
;
> > -                               marvell,pcie-port =3D <0>;
> > -                               marvell,pcie-lane =3D <0>;
> > -                               clocks =3D <&gate_clk 2>;
> > -                               status =3D "disabled";
> > -
> > -                               pcie0_intc: interrupt-controller {
> > -                                       interrupt-controller;
> > -                                       #interrupt-cells =3D <1>;
> > -                               };
> > -                       };
> > -
> > -                       pcie1: pcie@2,0 {
> > -                               device_type =3D "pci";
> > -                               assigned-addresses =3D <0x82001000 0 0x=
00044000 0 0x2000>;
> > -                               reg =3D <0x1000 0 0 0 0>;
> > -                               #address-cells =3D <3>;
> > -                               #size-cells =3D <2>;
> > -                               #interrupt-cells =3D <1>;
> > -                               ranges =3D <0x82000000 0 0 0x82000000 0=
x2 0 1 0
> > -                                         0x81000000 0 0 0x81000000 0x2=
 0 1 0>;
> > -                               bus-range =3D <0x00 0xff>;
> > -                               interrupt-names =3D "intx", "error";
> > -                               interrupts =3D <10>, <45>;
> > -                               interrupt-map-mask =3D <0 0 0 7>;
> > -                               interrupt-map =3D <0 0 0 1 &pcie1_intc =
0>,
> > -                                               <0 0 0 2 &pcie1_intc 1>=
,
> > -                                               <0 0 0 3 &pcie1_intc 2>=
,
> > -                                               <0 0 0 4 &pcie1_intc 3>=
;
> > -                               marvell,pcie-port =3D <1>;
> > -                               marvell,pcie-lane =3D <0>;
> > -                               clocks =3D <&gate_clk 18>;
> > -                               status =3D "disabled";
> > -
> > -                               pcie1_intc: interrupt-controller {
> > -                                       interrupt-controller;
> > -                                       #interrupt-cells =3D <1>;
> > -                               };
> > -                       };
> > -               };
> > -       };
> > -       ocp@f1000000 {
> > -
> > -               pinctrl: pin-controller@10000 {
> > -                       compatible =3D "marvell,88f6282-pinctrl";
> > -
> > -                       pmx_sata0: pmx-sata0 {
> > -                               marvell,pins =3D "mpp5", "mpp21", "mpp2=
3";
> > -                               marvell,function =3D "sata0";
> > -                       };
> > -                       pmx_sata1: pmx-sata1 {
> > -                               marvell,pins =3D "mpp4", "mpp20", "mpp2=
2";
> > -                               marvell,function =3D "sata1";
> > -                       };
> > -
> > -                       /*
> > -                        * Default I2C1 pinctrl setting on mpp36/mpp37,
> > -                        * overwrite marvell,pins on board level if req=
uired.
> > -                        */
> > -                       pmx_twsi1: pmx-twsi1 {
> > -                               marvell,pins =3D "mpp36", "mpp37";
> > -                               marvell,function =3D "twsi1";
> > -                       };
> > -
> > -                       pmx_sdio: pmx-sdio {
> > -                               marvell,pins =3D "mpp12", "mpp13", "mpp=
14",
> > -                                              "mpp15", "mpp16", "mpp17=
";
> > -                               marvell,function =3D "sdio";
> > -                       };
> > -               };
> > -
> > -               thermal: thermal@10078 {
> > -                       compatible =3D "marvell,kirkwood-thermal";
> > -                       reg =3D <0x10078 0x4>;
> > -                       status =3D "okay";
> > -               };
> > -
> > -               rtc: rtc@10300 {
> > -                       compatible =3D "marvell,kirkwood-rtc", "marvell=
,orion-rtc";
> > -                       reg =3D <0x10300 0x20>;
> > -                       interrupts =3D <53>;
> > -                       clocks =3D <&gate_clk 7>;
> > -               };
> > -
> > -               i2c1: i2c@11100 {
> > -                       compatible =3D "marvell,mv64xxx-i2c";
> > -                       reg =3D <0x11100 0x20>;
> > -                       #address-cells =3D <1>;
> > -                       #size-cells =3D <0>;
> > -                       interrupts =3D <32>;
> > -                       clock-frequency =3D <100000>;
> > -                       clocks =3D <&gate_clk 7>;
> > -                       pinctrl-0 =3D <&pmx_twsi1>;
> > -                       pinctrl-names =3D "default";
> > -                       status =3D "disabled";
> > -               };
> > -
> > -               sata: sata@80000 {
> > -                       compatible =3D "marvell,orion-sata";
> > -                       reg =3D <0x80000 0x5000>;
> > -                       interrupts =3D <21>;
> > -                       clocks =3D <&gate_clk 14>, <&gate_clk 15>;
> > -                       clock-names =3D "0", "1";
> > -                       phys =3D <&sata_phy0>, <&sata_phy1>;
> > -                       phy-names =3D "port0", "port1";
> > -                       status =3D "disabled";
> > -               };
> > -
> > -               sdio: mvsdio@90000 {
> > -                       compatible =3D "marvell,orion-sdio";
> > -                       reg =3D <0x90000 0x200>;
> > -                       interrupts =3D <28>;
> > -                       clocks =3D <&gate_clk 4>;
> > -                       pinctrl-0 =3D <&pmx_sdio>;
> > -                       pinctrl-names =3D "default";
> > -                       bus-width =3D <4>;
> > -                       cap-sdio-irq;
> > -                       cap-sd-highspeed;
> > -                       cap-mmc-highspeed;
> > -                       status =3D "disabled";
> > -               };
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-98dx4122.dtsi b/arch/arm/dts/kirkwoo=
d-98dx4122.dtsi
> > deleted file mode 100644
> > index 299c147298..0000000000
> > --- a/arch/arm/dts/kirkwood-98dx4122.dtsi
> > +++ /dev/null
> > @@ -1,53 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/ {
> > -       mbus@f1000000 {
> > -               pciec: pcie@82000000 {
> > -                       compatible =3D "marvell,kirkwood-pcie";
> > -                       status =3D "disabled";
> > -                       device_type =3D "pci";
> > -
> > -                       #address-cells =3D <3>;
> > -                       #size-cells =3D <2>;
> > -
> > -                       bus-range =3D <0x00 0xff>;
> > -
> > -                       ranges =3D
> > -                              <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01=
) 0x40000 0 0x00002000
> > -                               0x82000000 0x1 0     MBUS_ID(0x04, 0xe8=
) 0       1 0 /* Port 0.0 MEM */
> > -                               0x81000000 0x1 0     MBUS_ID(0x04, 0xe0=
) 0       1 0 /* Port 0.0 IO  */>;
> > -
> > -                       pcie0: pcie@1,0 {
> > -                               device_type =3D "pci";
> > -                               assigned-addresses =3D <0x82000800 0 0x=
00040000 0 0x2000>;
> > -                               reg =3D <0x0800 0 0 0 0>;
> > -                               #address-cells =3D <3>;
> > -                               #size-cells =3D <2>;
> > -                               #interrupt-cells =3D <1>;
> > -                               ranges =3D <0x82000000 0 0 0x82000000 0=
x1 0 1 0
> > -                                         0x81000000 0 0 0x81000000 0x1=
 0 1 0>;
> > -                               bus-range =3D <0x00 0xff>;
> > -                               interrupt-map-mask =3D <0 0 0 0>;
> > -                               interrupt-map =3D <0 0 0 0 &intc 9>;
> > -                               marvell,pcie-port =3D <0>;
> > -                               marvell,pcie-lane =3D <0>;
> > -                               clocks =3D <&gate_clk 2>;
> > -                               status =3D "disabled";
> > -                       };
> > -               };
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       compatible =3D "marvell,98dx4122-pinctrl";
> > -
> > -               };
> > -       };
> > -};
> > -
> > -&sata_phy0 {
> > -       status =3D "disabled";
> > -};
> > -
> > -&sata_phy1 {
> > -       status =3D "disabled";
> > -};
> > diff --git a/arch/arm/dts/kirkwood-blackarmor-nas220.dts b/arch/arm/dts=
/kirkwood-blackarmor-nas220.dts
> > deleted file mode 100644
> > index 07fbfca444..0000000000
> > --- a/arch/arm/dts/kirkwood-blackarmor-nas220.dts
> > +++ /dev/null
> > @@ -1,172 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > - * Device Tree file for Seagate Blackarmor NAS220
> > - *
> > - * Copyright (C) 2014 Evgeni Dobrev <evgeni@studio-punkt.com>
> > - */
> > -
> > -/dts-v1/;
> > -
> > -#include <dt-bindings/gpio/gpio.h>
> > -#include <dt-bindings/input/input.h>
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6192.dtsi"
> > -
> > -/ {
> > -       model =3D "Seagate Blackarmor NAS220";
> > -       compatible =3D "seagate,blackarmor-nas220","marvell,kirkwood-88=
f6192",
> > -                    "marvell,kirkwood";
> > -
> > -       memory { /* 128 MB */
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x8000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       gpio_poweroff {
> > -               compatible =3D "gpio-poweroff";
> > -               gpios =3D <&gpio0 14 GPIO_ACTIVE_LOW>;
> > -       };
> > -
> > -       gpio_keys {
> > -               compatible =3D "gpio-keys";
> > -
> > -               reset {
> > -                       label =3D "Reset";
> > -                       linux,code =3D <KEY_POWER>;
> > -                       gpios =3D <&gpio0 29 GPIO_ACTIVE_HIGH>;
> > -               };
> > -
> > -               button {
> > -                       label =3D "Power";
> > -                       linux,code =3D <KEY_SLEEP>;
> > -                       gpios =3D <&gpio0 26 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -
> > -               blue-power {
> > -                       label =3D "nas220:blue:power";
> > -                       gpios =3D <&gpio0 12 GPIO_ACTIVE_HIGH>;
> > -                       linux,default-trigger =3D "default-on";
> > -               };
> > -       };
> > -
> > -       regulators {
> > -               compatible =3D "simple-bus";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_power_sata0 &pmx_power_sata1>;
> > -               pinctrl-names =3D "default";
> > -
> > -               sata0_power: regulator@1 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <1>;
> > -                       regulator-name =3D "SATA0 Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio0 24 GPIO_ACTIVE_LOW>;
> > -               };
> > -
> > -               sata1_power: regulator@2 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <2>;
> > -                       regulator-name =3D "SATA1 Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -};
> > -
> > -/*
> > - * Serial port routed to connector CN5
> > - *
> > - * pin 1 - TX (CPU's TX)
> > - * pin 4 - RX (CPU's RX)
> > - * pin 6 - GND
> > - */
> > -&uart0 {
> > -       status =3D "okay";
> > -};
> > -
> > -&pinctrl {
> > -       pinctrl-0 =3D <&pmx_button_reset &pmx_button_power>;
> > -       pinctrl-names =3D "default";
> > -
> > -       pmx_act_sata0: pmx-act-sata0 {
> > -               marvell,pins =3D "mpp15";
> > -               marvell,function =3D "sata0";
> > -       };
> > -
> > -       pmx_act_sata1: pmx-act-sata1 {
> > -               marvell,pins =3D "mpp16";
> > -               marvell,function =3D "sata1";
> > -       };
> > -
> > -       pmx_power_sata0: pmx-power-sata0 {
> > -               marvell,pins =3D "mpp24";
> > -               marvell,function =3D "gpio";
> > -       };
> > -
> > -       pmx_power_sata1: pmx-power-sata1 {
> > -               marvell,pins =3D "mpp28";
> > -               marvell,function =3D "gpio";
> > -       };
> > -
> > -       pmx_button_reset: pmx-button-reset {
> > -               marvell,pins =3D "mpp29";
> > -               marvell,function =3D "gpio";
> > -       };
> > -
> > -       pmx_button_power: pmx-button-power {
> > -               marvell,pins =3D "mpp26";
> > -               marvell,function =3D "gpio";
> > -       };
> > -};
> > -
> > -&sata {
> > -       status =3D "okay";
> > -       nr-ports =3D <2>;
> > -};
> > -
> > -&i2c0 {
> > -       status =3D "okay";
> > -
> > -       adt7476: thermal@2e {
> > -               compatible =3D "adi,adt7476";
> > -               reg =3D <0x2e>;
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@8 {
> > -                reg =3D <8>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-d2net.dts b/arch/arm/dts/kirkwood-d2=
net.dts
> > deleted file mode 100644
> > index bd3b266dd7..0000000000
> > --- a/arch/arm/dts/kirkwood-d2net.dts
> > +++ /dev/null
> > @@ -1,45 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Device Tree file for d2 Network v2
> > - *
> > - * Copyright (C) 2014 Simon Guinot <simon.guinot@sequanux.org>
> > - *
> > -*/
> > -
> > -/dts-v1/;
> > -
> > -#include <dt-bindings/leds/leds-ns2.h>
> > -#include "kirkwood-netxbig.dtsi"
> > -
> > -/ {
> > -       model =3D "LaCie d2 Network v2";
> > -       compatible =3D "lacie,d2net_v2", "lacie,netxbig", "marvell,kirk=
wood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x10000000>;
> > -       };
> > -
> > -       ns2-leds {
> > -               compatible =3D "lacie,ns2-leds";
> > -
> > -               blue-sata {
> > -                       label =3D "d2net_v2:blue:sata";
> > -                       slow-gpio =3D <&gpio0 29 GPIO_ACTIVE_HIGH>;
> > -                       cmd-gpio =3D <&gpio0 30 GPIO_ACTIVE_HIGH>;
> > -                       modes-map =3D <NS_V2_LED_OFF  1 0
> > -                                    NS_V2_LED_ON   0 1
> > -                                    NS_V2_LED_ON   1 1
> > -                                    NS_V2_LED_SATA 0 0>;
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -
> > -               red-fail {
> > -                       label =3D "d2net_v2:red:fail";
> > -                       gpios =3D <&gpio0 12 GPIO_ACTIVE_HIGH>;
> > -               };
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-dns325.dts b/arch/arm/dts/kirkwood-d=
ns325.dts
> > deleted file mode 100644
> > index 94d9c06cbb..0000000000
> > --- a/arch/arm/dts/kirkwood-dns325.dts
> > +++ /dev/null
> > @@ -1,63 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood-dnskw.dtsi"
> > -
> > -/ {
> > -       model =3D "D-Link DNS-325 NAS (Rev A1)";
> > -       compatible =3D "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-=
kirkwood", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x10000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D <&pmx_led_power &pmx_led_red_usb_325
> > -                            &pmx_led_red_left_hdd &pmx_led_red_right_h=
dd
> > -                            &pmx_led_white_usb>;
> > -               pinctrl-names =3D "default";
> > -
> > -               white-power {
> > -                       label =3D "dns325:white:power";
> > -                       gpios =3D <&gpio0 26 GPIO_ACTIVE_LOW>;
> > -                       default-state =3D "keep";
> > -               };
> > -               white-usb {
> > -                       label =3D "dns325:white:usb";
> > -                       gpios =3D <&gpio1 11 GPIO_ACTIVE_LOW>; /* GPIO =
43 */
> > -               };
> > -               red-l_hdd {
> > -                       label =3D "dns325:red:l_hdd";
> > -                       gpios =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
> > -               };
> > -               red-r_hdd {
> > -                       label =3D "dns325:red:r_hdd";
> > -                       gpios =3D <&gpio0 27 GPIO_ACTIVE_LOW>;
> > -               };
> > -               red-usb {
> > -                       label =3D "dns325:red:usb";
> > -                       gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               i2c@11000 {
> > -                       status =3D "okay";
> > -
> > -                       lm75: lm75@48 {
> > -                               compatible =3D "national,lm75";
> > -                               reg =3D <0x48>;
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "okay";
> > -               };
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-dnskw.dtsi b/arch/arm/dts/kirkwood-d=
nskw.dtsi
> > deleted file mode 100644
> > index cbaf06f2f7..0000000000
> > --- a/arch/arm/dts/kirkwood-dnskw.dtsi
> > +++ /dev/null
> > @@ -1,235 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "D-Link DNS NASes (kirkwood-based)";
> > -       compatible =3D "dlink,dns-kirkwood", "marvell,kirkwood-88f6281"=
, "marvell,kirkwood";
> > -
> > -       gpio_keys {
> > -               compatible =3D "gpio-keys";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_button_power &pmx_button_unmount
> > -                            &pmx_button_reset>;
> > -               pinctrl-names =3D "default";
> > -
> > -               power {
> > -                       label =3D "Power button";
> > -                       linux,code =3D <KEY_POWER>;
> > -                       gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;
> > -               };
> > -               eject {
> > -                       label =3D "USB unmount button";
> > -                       linux,code =3D <KEY_EJECTCD>;
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -               };
> > -               reset {
> > -                       label =3D "Reset button";
> > -                       linux,code =3D <KEY_RESTART>;
> > -                       gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -
> > -       gpio_fan {
> > -               /* Fan: ADDA AD045HB-G73 40mm 6000rpm@5v */
> > -               compatible =3D "gpio-fan";
> > -               pinctrl-0 =3D <&pmx_fan_high_speed &pmx_fan_low_speed>;
> > -               pinctrl-names =3D "default";
> > -               gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW
> > -                        &gpio1 13 GPIO_ACTIVE_LOW>;
> > -               gpio-fan,speed-map =3D <0    0
> > -                                     3000 1
> > -                                     6000 2>;
> > -       };
> > -
> > -       gpio_poweroff {
> > -               compatible =3D "gpio-poweroff";
> > -               pinctrl-0 =3D <&pmx_power_off>;
> > -               pinctrl-names =3D "default";
> > -               gpios =3D <&gpio1 4 GPIO_ACTIVE_HIGH>;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -
> > -                       pinctrl-0 =3D <&pmx_power_back_on &pmx_present_=
sata0
> > -                                    &pmx_present_sata1 &pmx_fan_tacho
> > -                                    &pmx_temp_alarm>;
> > -                       pinctrl-names =3D "default";
> > -
> > -                       pmx_sata0: pmx-sata0 {
> > -                               marvell,pins =3D "mpp20";
> > -                               marvell,function =3D "sata1";
> > -                       };
> > -                       pmx_sata1: pmx-sata1 {
> > -                               marvell,pins =3D "mpp21";
> > -                               marvell,function =3D "sata0";
> > -                       };
> > -                       pmx_led_power: pmx-led-power {
> > -                               marvell,pins =3D "mpp26";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_red_right_hdd: pmx-led-red-right-hdd {
> > -                               marvell,pins =3D "mpp27";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_red_left_hdd: pmx-led-red-left-hdd {
> > -                               marvell,pins =3D "mpp28";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_red_usb_325: pmx-led-red-usb-325 {
> > -                               marvell,pins =3D "mpp29";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_power: pmx-button-power {
> > -                               marvell,pins =3D "mpp34";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_red_usb_320: pmx-led-red-usb-320 {
> > -                               marvell,pins =3D "mpp35";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_power_off: pmx-power-off {
> > -                               marvell,pins =3D "mpp36";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_power_back_on: pmx-power-back-on {
> > -                               marvell,pins =3D "mpp37";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_power_sata0: pmx-power-sata0 {
> > -                               marvell,pins =3D "mpp39";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_power_sata1: pmx-power-sata1 {
> > -                               marvell,pins =3D "mpp40";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_present_sata0: pmx-present-sata0 {
> > -                               marvell,pins =3D "mpp41";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_present_sata1: pmx-present-sata1 {
> > -                               marvell,pins =3D "mpp42";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_white_usb: pmx-led-white-usb {
> > -                               marvell,pins =3D "mpp43";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_fan_tacho: pmx-fan-tacho {
> > -                               marvell,pins =3D "mpp44";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_fan_high_speed: pmx-fan-high-speed {
> > -                               marvell,pins =3D "mpp45";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_fan_low_speed: pmx-fan-low-speed {
> > -                               marvell,pins =3D "mpp46";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_unmount: pmx-button-unmount {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_reset: pmx-button-reset {
> > -                               marvell,pins =3D "mpp48";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_temp_alarm: pmx-temp-alarm {
> > -                               marvell,pins =3D "mpp49";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               sata@80000 {
> > -                       pinctrl-0 =3D <&pmx_sata0 &pmx_sata1>;
> > -                       pinctrl-names =3D "default";
> > -                       status =3D "okay";
> > -                       nr-ports =3D <2>;
> > -               };
> > -       };
> > -
> > -       regulators {
> > -               compatible =3D "simple-bus";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_power_sata0 &pmx_power_sata1>;
> > -               pinctrl-names =3D "default";
> > -
> > -               sata0_power: regulator@1 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <1>;
> > -                       regulator-name =3D "SATA0 Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio1 7 0>;
> > -               };
> > -               sata1_power: regulator@2 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <2>;
> > -                       regulator-name =3D "SATA1 Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio1 8 0>;
> > -               };
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -       chip-delay =3D <35>;
> > -
> > -       partition@0 {
> > -               label =3D "u-boot";
> > -               reg =3D <0x0000000 0x100000>;
> > -               read-only;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "uImage";
> > -               reg =3D <0x0100000 0x500000>;
> > -       };
> > -
> > -       partition@600000 {
> > -               label =3D "ramdisk";
> > -               reg =3D <0x0600000 0x500000>;
> > -       };
> > -
> > -       partition@b00000 {
> > -               label =3D "image";
> > -               reg =3D <0x0b00000 0x6600000>;
> > -       };
> > -
> > -       partition@7100000 {
> > -               label =3D "mini firmware";
> > -               reg =3D <0x7100000 0xa00000>;
> > -       };
> > -
> > -       partition@7b00000 {
> > -               label =3D "config";
> > -               reg =3D <0x7b00000 0x500000>;
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@8 {
> > -               reg =3D <8>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-dockstar.dts b/arch/arm/dts/kirkwood=
-dockstar.dts
> > deleted file mode 100644
> > index 6a3f1bf6d9..0000000000
> > --- a/arch/arm/dts/kirkwood-dockstar.dts
> > +++ /dev/null
> > @@ -1,110 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "Seagate FreeAgent Dockstar";
> > -       compatible =3D "seagate,dockstar", "marvell,kirkwood-88f6281", =
"marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x8000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk root=
=3D/dev/sda1 rootdelay=3D10";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_usb_power_enable: pmx-usb-power-enable {
> > -                               marvell,pins =3D "mpp29";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_green: pmx-led-green {
> > -                               marvell,pins =3D "mpp46";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_orange: pmx-led-orange {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "ok";
> > -               };
> > -       };
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D <&pmx_led_green &pmx_led_orange>;
> > -               pinctrl-names =3D "default";
> > -
> > -               health {
> > -                       label =3D "status:green:health";
> > -                       gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
> > -                       default-state =3D "keep";
> > -               };
> > -               fault {
> > -                       label =3D "status:orange:fault";
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -       regulators {
> > -               compatible =3D "simple-bus";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_usb_power_enable>;
> > -               pinctrl-names =3D "default";
> > -
> > -               usb_power: regulator@1 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <1>;
> > -                       regulator-name =3D "USB Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio0 29 0>;
> > -               };
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -
> > -       partition@0 {
> > -               label =3D "u-boot";
> > -               reg =3D <0x0000000 0x100000>;
> > -               read-only;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "uImage";
> > -               reg =3D <0x0100000 0x400000>;
> > -       };
> > -
> > -       partition@500000 {
> > -               label =3D "data";
> > -               reg =3D <0x0500000 0xfb00000>;
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@0 {
> > -               compatible =3D "marvell,88e1116";
> > -               reg =3D <0>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-dreamplug.dts b/arch/arm/dts/kirkwoo=
d-dreamplug.dts
> > deleted file mode 100644
> > index e9eea22fc9..0000000000
> > --- a/arch/arm/dts/kirkwood-dreamplug.dts
> > +++ /dev/null
> > @@ -1,131 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "Globalscale Technologies Dreamplug";
> > -       compatible =3D "globalscale,dreamplug-003-ds2001", "globalscale=
,dreamplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x20000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       aliases {
> > -               spi0 =3D &spi0;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_led_bluetooth: pmx-led-bluetooth {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_wifi: pmx-led-wifi {
> > -                               marvell,pins =3D "mpp48";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_wifi_ap: pmx-led-wifi-ap {
> > -                               marvell,pins =3D "mpp49";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "ok";
> > -               };
> > -
> > -               spi@10600 {
> > -                       status =3D "okay";
> > -
> > -                       m25p40@0 {
> > -                               #address-cells =3D <1>;
> > -                               #size-cells =3D <1>;
> > -                               compatible =3D "mxicy,mx25l1606e", "jed=
ec,spi-nor";
> > -                               reg =3D <0>;
> > -                               spi-max-frequency =3D <50000000>;
> > -                               mode =3D <0>;
> > -
> > -                               partition@0 {
> > -                                       reg =3D <0x0 0x80000>;
> > -                                       label =3D "u-boot";
> > -                               };
> > -
> > -                               partition@100000 {
> > -                                       reg =3D <0x100000 0x10000>;
> > -                                       label =3D "u-boot env";
> > -                               };
> > -
> > -                               partition@180000 {
> > -                                       reg =3D <0x180000 0x10000>;
> > -                                       label =3D "dtb";
> > -                               };
> > -                       };
> > -               };
> > -
> > -               sata@80000 {
> > -                       status =3D "okay";
> > -                       nr-ports =3D <1>;
> > -               };
> > -
> > -               mvsdio@90000 {
> > -                       pinctrl-0 =3D <&pmx_sdio>;
> > -                       pinctrl-names =3D "default";
> > -                       status =3D "okay";
> > -                       /* No CD or WP GPIOs */
> > -                       broken-cd;
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D <&pmx_led_bluetooth &pmx_led_wifi
> > -                            &pmx_led_wifi_ap >;
> > -               pinctrl-names =3D "default";
> > -
> > -               bluetooth {
> > -                       label =3D "dreamplug:blue:bluetooth";
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -               };
> > -               wifi {
> > -                       label =3D "dreamplug:green:wifi";
> > -                       gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
> > -               };
> > -               wifi-ap {
> > -                       label =3D "dreamplug:green:wifi_ap";
> > -                       gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@0 {
> > -               reg =3D <0>;
> > -       };
> > -
> > -       ethphy1: ethernet-phy@1 {
> > -               reg =3D <1>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > -
> > -&eth1 {
> > -       status =3D "okay";
> > -       ethernet1-port@0 {
> > -               phy-handle =3D <&ethphy1>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-ds109.dts b/arch/arm/dts/kirkwood-ds=
109.dts
> > deleted file mode 100644
> > index 29982e7acb..0000000000
> > --- a/arch/arm/dts/kirkwood-ds109.dts
> > +++ /dev/null
> > @@ -1,40 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Andrew Lunn <andrew@lunn.ch>
> > - * Ben Peddell <klightspeed@killerwolves.net>
> > - *
> > - */
> > -
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -#include "kirkwood-synology.dtsi"
> > -
> > -/ {
> > -       model =3D "Synology DS109, DS110, DS110jv20";
> > -       compatible =3D "synology,ds109", "synology,ds110jv20",
> > -                    "synology,ds110", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x8000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       gpio-fan-150-32-35 {
> > -               status =3D "okay";
> > -       };
> > -
> > -       gpio-leds-hdd-21-1 {
> > -               status =3D "okay";
> > -       };
> > -};
> > -
> > -&rs5c372 {
> > -       status =3D "okay";
> > -};
> > diff --git a/arch/arm/dts/kirkwood-goflexnet.dts b/arch/arm/dts/kirkwoo=
d-goflexnet.dts
> > deleted file mode 100644
> > index 02d87e0a10..0000000000
> > --- a/arch/arm/dts/kirkwood-goflexnet.dts
> > +++ /dev/null
> > @@ -1,190 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "Seagate GoFlex Net";
> > -       compatible =3D "seagate,goflexnet", "marvell,kirkwood-88f6281",=
 "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x8000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk root=
=3D/dev/sda1 rootdelay=3D10";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_usb_power_enable: pmx-usb-power-enable {
> > -                               marvell,pins =3D "mpp29";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_right_cap_0: pmx-led_right_cap_0 {
> > -                               marvell,pins =3D "mpp38";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_right_cap_1: pmx-led_right_cap_1 {
> > -                               marvell,pins =3D "mpp39";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_right_cap_2: pmx-led_right_cap_2 {
> > -                               marvell,pins =3D "mpp40";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_right_cap_3: pmx-led_right_cap_3 {
> > -                               marvell,pins =3D "mpp41";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_left_cap_0: pmx-led_left_cap_0 {
> > -                               marvell,pins =3D "mpp42";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_left_cap_1: pmx-led_left_cap_1 {
> > -                               marvell,pins =3D "mpp43";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_left_cap_2: pmx-led_left_cap_2 {
> > -                               marvell,pins =3D "mpp44";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_left_cap_3: pmx-led_left_cap_3 {
> > -                               marvell,pins =3D "mpp45";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_green: pmx-led_green {
> > -                               marvell,pins =3D "mpp46";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_orange: pmx-led_orange {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "ok";
> > -               };
> > -
> > -               sata@80000 {
> > -                       status =3D "okay";
> > -                       nr-ports =3D <2>;
> > -               };
> > -
> > -       };
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D < &pmx_led_orange
> > -                             &pmx_led_left_cap_0 &pmx_led_left_cap_1
> > -                             &pmx_led_left_cap_2 &pmx_led_left_cap_3
> > -                             &pmx_led_right_cap_0 &pmx_led_right_cap_1
> > -                             &pmx_led_right_cap_2 &pmx_led_right_cap_3
> > -                           >;
> > -               pinctrl-names =3D "default";
> > -
> > -               health {
> > -                       label =3D "status:green:health";
> > -                       gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
> > -                       default-state =3D "keep";
> > -               };
> > -               fault {
> > -                       label =3D "status:orange:fault";
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -               };
> > -               left0 {
> > -                       label =3D "status:white:left0";
> > -                       gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               left1 {
> > -                       label =3D "status:white:left1";
> > -                       gpios =3D <&gpio1 11 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               left2 {
> > -                       label =3D "status:white:left2";
> > -                       gpios =3D <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               left3 {
> > -                       label =3D "status:white:left3";
> > -                       gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               right0 {
> > -                       label =3D "status:white:right0";
> > -                       gpios =3D <&gpio1 6 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               right1 {
> > -                       label =3D "status:white:right1";
> > -                       gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               right2 {
> > -                       label =3D "status:white:right2";
> > -                       gpios =3D <&gpio1 8 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               right3 {
> > -                       label =3D "status:white:right3";
> > -                       gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > -               };
> > -       };
> > -       regulators {
> > -               compatible =3D "simple-bus";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_usb_power_enable>;
> > -               pinctrl-names =3D "default";
> > -
> > -               usb_power: regulator@1 {
> > -                       compatible =3D "regulator-fixed";
> > -                       reg =3D <1>;
> > -                       regulator-name =3D "USB Power";
> > -                       regulator-min-microvolt =3D <5000000>;
> > -                       regulator-max-microvolt =3D <5000000>;
> > -                       enable-active-high;
> > -                       regulator-always-on;
> > -                       regulator-boot-on;
> > -                       gpio =3D <&gpio0 29 GPIO_ACTIVE_HIGH>;
> > -               };
> > -       };
> > -};
> > -
> > -&nand {
> > -       chip-delay =3D <40>;
> > -       status =3D "okay";
> > -
> > -       partition@0 {
> > -               label =3D "u-boot";
> > -               reg =3D <0x0000000 0x100000>;
> > -               read-only;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "uImage";
> > -               reg =3D <0x0100000 0x400000>;
> > -       };
> > -
> > -       partition@500000 {
> > -               label =3D "pogoplug";
> > -               reg =3D <0x0500000 0x2000000>;
> > -       };
> > -
> > -       partition@2500000 {
> > -               label =3D "root";
> > -               reg =3D <0x02500000 0xd800000>;
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@0 {
> > -               reg =3D <0>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/=
dts/kirkwood-guruplug-server-plus.dts
> > deleted file mode 100644
> > index ff1260ee3f..0000000000
> > --- a/arch/arm/dts/kirkwood-guruplug-server-plus.dts
> > +++ /dev/null
> > @@ -1,133 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "Globalscale Technologies Guruplug Server Plus";
> > -       compatible =3D "globalscale,guruplug-server-plus", "globalscale=
,guruplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x20000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_led_health_r: pmx-led-health-r {
> > -                               marvell,pins =3D "mpp46";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_health_g: pmx-led-health-g {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_wmode_r: pmx-led-wmode-r {
> > -                               marvell,pins =3D "mpp48";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_wmode_g: pmx-led-wmode-g {
> > -                               marvell,pins =3D "mpp49";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "ok";
> > -               };
> > -
> > -               sata@80000 {
> > -                       status =3D "okay";
> > -                       nr-ports =3D <1>;
> > -               };
> > -
> > -               /* AzureWave AW-GH381 WiFi/BT */
> > -               mvsdio@90000 {
> > -                       status =3D "okay";
> > -                       non-removable;
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D < &pmx_led_health_r &pmx_led_health_g
> > -                             &pmx_led_wmode_r &pmx_led_wmode_g >;
> > -               pinctrl-names =3D "default";
> > -
> > -               health-r {
> > -                       label =3D "guruplug:red:health";
> > -                       gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
> > -               };
> > -               health-g {
> > -                       label =3D "guruplug:green:health";
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -               };
> > -               wmode-r {
> > -                       label =3D "guruplug:red:wmode";
> > -                       gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
> > -               };
> > -               wmode-g {
> > -                       label =3D "guruplug:green:wmode";
> > -                       gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -
> > -       partition@0 {
> > -               label =3D "u-boot";
> > -               reg =3D <0x00000000 0x00100000>;
> > -               read-only;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "uImage";
> > -               reg =3D <0x00100000 0x00400000>;
> > -       };
> > -
> > -       partition@500000 {
> > -               label =3D "data";
> > -               reg =3D <0x00500000 0x1fb00000>;
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@0 {
> > -               /* Marvell 88E1121R */
> > -               compatible =3D "ethernet-phy-id0141.0cb0",
> > -                            "ethernet-phy-ieee802.3-c22";
> > -               reg =3D <0>;
> > -       };
> > -
> > -       ethphy1: ethernet-phy@1 {
> > -               /* Marvell 88E1121R */
> > -               compatible =3D "ethernet-phy-id0141.0cb0",
> > -                            "ethernet-phy-ieee802.3-c22";
> > -               reg =3D <1>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -               phy-connection-type =3D "rgmii-id";
> > -       };
> > -};
> > -
> > -&eth1 {
> > -       status =3D "okay";
> > -       ethernet1-port@0 {
> > -               phy-handle =3D <&ethphy1>;
> > -               phy-connection-type =3D "rgmii-id";
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-ib62x0.dts b/arch/arm/dts/kirkwood-i=
b62x0.dts
> > deleted file mode 100644
> > index 962a910a6f..0000000000
> > --- a/arch/arm/dts/kirkwood-ib62x0.dts
> > +++ /dev/null
> > @@ -1,146 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
> > -       compatible =3D "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-=
b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",=
 "marvell,kirkwood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x10000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk";
> > -               stdout-path =3D &uart0;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_led_os_red: pmx-led-os-red {
> > -                               marvell,pins =3D "mpp22";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_power_off: pmx-power-off {
> > -                               marvell,pins =3D "mpp24";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_os_green: pmx-led-os-green {
> > -                               marvell,pins =3D "mpp25";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_usb_transfer: pmx-led-usb-transfer {
> > -                               marvell,pins =3D "mpp27";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_reset: pmx-button-reset {
> > -                               marvell,pins =3D "mpp28";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_usb_copy: pmx-button-usb-copy {
> > -                               marvell,pins =3D "mpp29";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -
> > -               serial@12000 {
> > -                       status =3D "okay";
> > -               };
> > -
> > -               sata@80000 {
> > -                       status =3D "okay";
> > -                       nr-ports =3D <2>;
> > -               };
> > -       };
> > -
> > -       gpio_keys {
> > -               compatible =3D "gpio-keys";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D <&pmx_button_reset &pmx_button_usb_copy>;
> > -               pinctrl-names =3D "default";
> > -
> > -               copy {
> > -                       label =3D "USB Copy";
> > -                       linux,code =3D <KEY_COPY>;
> > -                       gpios =3D <&gpio0 29 GPIO_ACTIVE_LOW>;
> > -               };
> > -               reset {
> > -                       label =3D "Reset";
> > -                       linux,code =3D <KEY_RESTART>;
> > -                       gpios =3D <&gpio0 28 GPIO_ACTIVE_LOW>;
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D <&pmx_led_os_red &pmx_led_os_green
> > -                            &pmx_led_usb_transfer>;
> > -               pinctrl-names =3D "default";
> > -
> > -               green-os {
> > -                       label =3D "ib62x0:green:os";
> > -                       gpios =3D <&gpio0 25 GPIO_ACTIVE_HIGH>;
> > -                       default-state =3D "keep";
> > -               };
> > -               red-os {
> > -                       label =3D "ib62x0:red:os";
> > -                       gpios =3D <&gpio0 22 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               usb-copy {
> > -                       label =3D "ib62x0:red:usb_copy";
> > -                       gpios =3D <&gpio0 27 GPIO_ACTIVE_HIGH>;
> > -               };
> > -       };
> > -
> > -       gpio_poweroff {
> > -               compatible =3D "gpio-poweroff";
> > -               pinctrl-0 =3D <&pmx_power_off>;
> > -               pinctrl-names =3D "default";
> > -               gpios =3D <&gpio0 24 GPIO_ACTIVE_HIGH>;
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -
> > -       partition@0 {
> > -               label =3D "u-boot";
> > -               reg =3D <0x0000000 0xe0000>;
> > -       };
> > -
> > -       partition@e0000 {
> > -               label =3D "u-boot environment";
> > -               reg =3D <0xe0000 0x20000>;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "uImage";
> > -               reg =3D <0x0100000 0x600000>;
> > -       };
> > -
> > -       partition@700000 {
> > -               label =3D "root";
> > -               reg =3D <0x0700000 0xf900000>;
> > -       };
> > -
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@8 {
> > -               reg =3D <8>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > diff --git a/arch/arm/dts/kirkwood-iconnect.dts b/arch/arm/dts/kirkwood=
-iconnect.dts
> > deleted file mode 100644
> > index 4a512d8091..0000000000
> > --- a/arch/arm/dts/kirkwood-iconnect.dts
> > +++ /dev/null
> > @@ -1,195 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/dts-v1/;
> > -
> > -#include "kirkwood.dtsi"
> > -#include "kirkwood-6281.dtsi"
> > -
> > -/ {
> > -       model =3D "Iomega Iconnect";
> > -       compatible =3D "iom,iconnect-1.1", "iom,iconnect", "marvell,kir=
kwood-88f6281", "marvell,kirkwood";
> > -
> > -       memory {
> > -               device_type =3D "memory";
> > -               reg =3D <0x00000000 0x10000000>;
> > -       };
> > -
> > -       chosen {
> > -               bootargs =3D "console=3DttyS0,115200n8 earlyprintk";
> > -               stdout-path =3D &uart0;
> > -               linux,initrd-start =3D <0x4500040>;
> > -               linux,initrd-end   =3D <0x4800000>;
> > -       };
> > -
> > -       ocp@f1000000 {
> > -               pinctrl: pin-controller@10000 {
> > -                       pmx_button_reset: pmx-button-reset {
> > -                               marvell,pins =3D "mpp12";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_button_otb: pmx-button-otb {
> > -                               marvell,pins =3D "mpp35";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_level: pmx-led-level {
> > -                               marvell,pins =3D "mpp41";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_power_blue: pmx-led-power-blue {
> > -                               marvell,pins =3D "mpp42";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_power_red: pmx-power-red {
> > -                               marvell,pins =3D "mpp43";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_usb1: pmx-led-usb1 {
> > -                               marvell,pins =3D "mpp44";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_usb2: pmx-led-usb2 {
> > -                               marvell,pins =3D "mpp45";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_usb3: pmx-led-usb3 {
> > -                               marvell,pins =3D "mpp46";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_usb4: pmx-led-usb4 {
> > -                               marvell,pins =3D "mpp47";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -                       pmx_led_otb: pmx-led-otb {
> > -                               marvell,pins =3D "mpp48";
> > -                               marvell,function =3D "gpio";
> > -                       };
> > -               };
> > -               i2c@11000 {
> > -                       status =3D "okay";
> > -
> > -                       lm63: lm63@4c {
> > -                               compatible =3D "national,lm63";
> > -                               reg =3D <0x4c>;
> > -                       };
> > -               };
> > -               serial@12000 {
> > -                       status =3D "ok";
> > -               };
> > -       };
> > -
> > -       gpio-leds {
> > -               compatible =3D "gpio-leds";
> > -               pinctrl-0 =3D < &pmx_led_level &pmx_led_power_blue
> > -                             &pmx_led_power_red &pmx_led_usb1
> > -                             &pmx_led_usb2 &pmx_led_usb3
> > -                             &pmx_led_usb4 &pmx_led_otb >;
> > -               pinctrl-names =3D "default";
> > -
> > -               led-level {
> > -                       label =3D "led_level";
> > -                       gpios =3D <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > -                       default-state =3D "on";
> > -               };
> > -               power-blue {
> > -                       label =3D "power:blue";
> > -                       gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
> > -                       default-state =3D "keep";
> > -               };
> > -               power-red {
> > -                       label =3D "power:red";
> > -                       gpios =3D <&gpio1 11 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               usb1 {
> > -                       label =3D "usb1:blue";
> > -                       gpios =3D <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               usb2 {
> > -                       label =3D "usb2:blue";
> > -                       gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               usb3 {
> > -                       label =3D "usb3:blue";
> > -                       gpios =3D <&gpio1 14 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               usb4 {
> > -                       label =3D "usb4:blue";
> > -                       gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> > -               };
> > -               otb {
> > -                       label =3D "otb:blue";
> > -                       gpios =3D <&gpio1 16 GPIO_ACTIVE_HIGH>;
> > -               };
> > -       };
> > -
> > -       gpio_keys {
> > -               compatible =3D "gpio-keys";
> > -               #address-cells =3D <1>;
> > -               #size-cells =3D <0>;
> > -               pinctrl-0 =3D < &pmx_button_reset &pmx_button_otb >;
> > -               pinctrl-names =3D "default";
> > -
> > -               otb {
> > -                       label =3D "OTB Button";
> > -                       linux,code =3D <KEY_COPY>;
> > -                       gpios =3D <&gpio1 3 GPIO_ACTIVE_LOW>;
> > -                       debounce-interval =3D <100>;
> > -               };
> > -               reset {
> > -                       label =3D "Reset";
> > -                       linux,code =3D <KEY_RESTART>;
> > -                       gpios =3D <&gpio0 12 GPIO_ACTIVE_LOW>;
> > -                       debounce-interval =3D <100>;
> > -               };
> > -       };
> > -};
> > -
> > -&nand {
> > -       status =3D "okay";
> > -
> > -       partition@0 {
> > -               label =3D "uboot";
> > -               reg =3D <0x0000000 0xc0000>;
> > -       };
> > -
> > -       partition@a0000 {
> > -               label =3D "env";
> > -               reg =3D <0xa0000 0x20000>;
> > -       };
> > -
> > -       partition@100000 {
> > -               label =3D "zImage";
> > -               reg =3D <0x100000 0x300000>;
> > -       };
> > -
> > -       partition@540000 {
> > -               label =3D "initrd";
> > -               reg =3D <0x540000 0x300000>;
> > -       };
> > -
> > -       partition@980000 {
> > -               label =3D "boot";
> > -               reg =3D <0x980000 0x1f400000>;
> > -       };
> > -};
> > -
> > -&mdio {
> > -       status =3D "okay";
> > -
> > -       ethphy0: ethernet-phy@11 {
> > -               reg =3D <11>;
> > -       };
> > -};
> > -
> > -&eth0 {
> > -       status =3D "okay";
> > -       ethernet0-port@0 {
> > -               phy-handle =3D <&ethphy0>;
> > -       };
> > -};
> > -
> > -&pciec {
> > -        status =3D "okay";
> > -};
> > -
> > -&pcie0 {
> > -       status =3D "okay";
> > -};
> > diff --git a/arch/arm
