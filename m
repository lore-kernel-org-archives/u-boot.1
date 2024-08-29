Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A320C71151
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 04:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFF388AD7;
	Thu, 29 Aug 2024 06:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1XlMYMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D50588AB2; Thu, 29 Aug 2024 06:57:52 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4DC88B08
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 06:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-533488ffaf7so292854e87.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724907469; x=1725512269; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue957NoKF8IPGoUpb4iH5mgYIbP/jPfELVJ/iew7t2o=;
 b=l1XlMYMiJVIqN0JxAhiTiFysz2iCPXS6kiUIyGwMTKSxzgrsS8miBC5rHSNY+I16Wv
 dpJTT0ukcHfDyvMVSlVYVwjwZXh1uLckjRbEsFPcpRVqASJMpOdrw/te5C9abClH2Fs3
 kEQNEAfOk6VSOLujvSRP7eux75UrBjJncDFSCnqLaZNVfqeM+ru0QRKiZ/LhoxAORnak
 x6ydqbAG//nkVfkUkAD2NCVI1nweQI8yUTJzeUPZuP2pHwMYjl8t4m5md/4Q8QqkZlGp
 8VzGGjMGkp1eVzSVr26UqdcLMhd4VJWLxHybLm2/cSqaaqiU4mcXMtFLGSiYVpkr7bnH
 0qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724907469; x=1725512269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ue957NoKF8IPGoUpb4iH5mgYIbP/jPfELVJ/iew7t2o=;
 b=IQW4jYsf0PDNSqQPYAqQnNr98GTtW3o+xlFqM+Bfu/oOz1XplNVdZqRi04T30siGAx
 nAOn5I4oX5TK/MD56HVmtLHIpW1fh00yV+20h2popTwWo2p9TLUMFg7MDCV4Ms7rbiz6
 h7UZxIc9WAvfsCVWQxGb1IR2r5hcZS0q9AhhvnWB3efGd236Wa31aVM1z7jZopfbmhDx
 y9elavVvKmehLa9SkVlV0lB6WXcwLJjsg+MMpljo+xwJCqTZ1BPnKGKcCvaIgJpiSPdx
 0IE+fvEuIDgqVJR1wkBu4q9WaLMeUHXRsxUibHR+7Libd5DQVlyp3H7CpkmDOFnFK8Tv
 ZuCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDbFPDGjSb8jZow3EDOniCq5Ip2TLvvvIfKG0+r9kxfyOgnb+kl/OmpuznL1iCMqhRGYK7qi8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu1NT8agqll7Z2OEzjJxMEPvGK8aUJZ8Fkc9B8THTMyV9LdJvs
 28ov8Y91vZPC1WtsFFYoiOnA1qoU0PtGN4lfzVTYGMhkMad4Ih1u8xdMO79EWGtzlbkB0fb0w8a
 kqcSyy/1WKancE2euOaPxSLLNQB8=
X-Google-Smtp-Source: AGHT+IHk7tCuFOqfz7cmrsR3IQsC7KRr70QGg7i9EXBbCX/rEkm+lJD1kdPQ6r+9l1dytbrLJd/k8e4a7GXdnsfzXYc=
X-Received: by 2002:a05:6512:1111:b0:52c:842b:c276 with SMTP id
 2adb3069b0e04-5353e5b6ae6mr817484e87.53.1724907469138; Wed, 28 Aug 2024
 21:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-8-minda.chen@starfivetech.com>
 <CAFA6WYOFFxO3ob+Fj9YEotLnxwTD1hJwX4oEZtiJjSCkzNkj=g@mail.gmail.com>
In-Reply-To: <CAFA6WYOFFxO3ob+Fj9YEotLnxwTD1hJwX4oEZtiJjSCkzNkj=g@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Wed, 28 Aug 2024 21:57:37 -0700
Message-ID: <CANV2PTMc5ZeHSWgxJ+aX31S1GmV-KhfyTNg4JtM77fVk7CH61g@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] dts: starfive: Add JH7110 Cadence USB dts node
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Wed, Aug 28, 2024 at 9:47=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> Hi,
>
> On Thu, 29 Aug 2024 at 07:01, Minda Chen <minda.chen@starfivetech.com> wr=
ote:
> >
> > Add Jh7110 Cadence USB dts node, Visionfive2 default setting
> > is USB 2.0 device.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > ---
> >  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
> >  arch/riscv/dts/jh7110.dtsi                    | 53 +++++++++++++++++++
> >  2 files changed, 58 insertions(+)
>
> Can you try to evaluate if this SoC can support OF_UPSTREAM? I can see
> corresponding DT sources well supported by dts/upstream. AFAICS, you
> at least need to add a Makefile for RISC-V here:
> dts/upstream/src/riscv/ for which you can reference
> dts/upstream/src/arm64/Makefile.
>
> This is not something to be considered as a blocker for this series
> but kind of follow-up work.
>
> -Sumit
>
> >
> > diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/ri=
scv/dts/jh7110-starfive-visionfive-2.dtsi
> > index e11babc1cd..44785bbee3 100644
> > --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > @@ -378,3 +378,8 @@
> >                 };
> >         };
> >  };
> > +
> > +&usb_cdns3 {
> > +       dr_mode =3D "peripheral";
> > +       status =3D "okay";
> > +};
> > diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> > index 2cdc683d49..7bf9b2a03a 100644
> > --- a/arch/riscv/dts/jh7110.dtsi
> > +++ b/arch/riscv/dts/jh7110.dtsi
> > @@ -371,6 +371,59 @@
> >                         status =3D "disabled";
> >                 };
> >
> > +               usb0: usb@10100000 {
> > +                       compatible =3D "starfive,jh7110-usb";
> > +                       ranges =3D <0x0 0x0 0x10100000 0x100000>;
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <1>;
> > +                       starfive,stg-syscon =3D <&stg_syscon 0x4>;
> > +                       clocks =3D <&stgcrg JH7110_STGCLK_USB_LPM>,
> > +                                <&stgcrg JH7110_STGCLK_USB_STB>,
> > +                                <&stgcrg JH7110_STGCLK_USB_APB>,
> > +                                <&stgcrg JH7110_STGCLK_USB_AXI>,
> > +                                <&stgcrg JH7110_STGCLK_USB_UTMI_APB>;
> > +                       clock-names =3D "lpm", "stb", "apb", "axi", "ut=
mi_apb";
> > +                       resets =3D <&stgcrg JH7110_STGRST_USB_PWRUP>,
> > +                                <&stgcrg JH7110_STGRST_USB_APB>,
> > +                                <&stgcrg JH7110_STGRST_USB_AXI>,
> > +                                <&stgcrg JH7110_STGRST_USB_UTMI_APB>;
> > +                       reset-names =3D "pwrup", "apb", "axi", "utmi_ap=
b";
> > +
> > +                       usb_cdns3: usb@0 {
> > +                               compatible =3D "cdns,usb3";
> > +                               reg =3D <0x0 0x10000>,
> > +                                     <0x10000 0x10000>,
> > +                                     <0x20000 0x10000>;
> > +                               reg-names =3D "otg", "xhci", "dev";
> > +                               interrupts =3D <100>, <108>, <110>;
> > +                               interrupt-names =3D "host", "peripheral=
", "otg";
> > +                               phys =3D <&usbphy0>;
> > +                               phy-names =3D "cdns3,usb2-phy";
> > +                       };
> > +               };
> > +
> > +               usbphy0: phy@10200000 {
> > +                       compatible =3D "starfive,jh7110-usb-phy";
> > +                       reg =3D <0x0 0x10200000 0x0 0x10000>;
> > +                       clocks =3D <&syscrg JH7110_SYSCLK_USB_125M>,
> > +                                <&stgcrg JH7110_STGCLK_USB_APP_125>;
> > +                       clock-names =3D "125m", "app_125m";
> > +                       starfive,sys-syscon =3D <&sys_syscon 0x18>;
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> > +               pciephy0: phy@10210000 {
> > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > +                       reg =3D <0x0 0x10210000 0x0 0x10000>;
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> > +               pciephy1: phy@10220000 {
> > +                       compatible =3D "starfive,jh7110-pcie-phy";
> > +                       reg =3D <0x0 0x10220000 0x0 0x10000>;
> > +                       #phy-cells =3D <0>;
> > +               };
> > +
> >                 stgcrg: clock-controller@10230000 {
> >                         compatible =3D "starfive,jh7110-stgcrg";
> >                         reg =3D <0x0 0x10230000 0x0 0x10000>;
> > --
> > 2.17.1
> >

I note that Hal Feng saying earlier this week they would take on
OF_UPSTREAM of JH7110 boards:
https://lore.kernel.org/lkml/ZQ2PR01MB13073EF3BD7A64F2C098AA8FE6882@ZQ2PR01=
MB1307.CHNPR01.prod.partner.outlook.cn/

It is a good time for this work to begin.

-E
