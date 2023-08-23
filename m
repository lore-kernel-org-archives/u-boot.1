Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAD0EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A833B864BE;
	Wed, 23 Aug 2023 13:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X2Ic4Aet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F64864BE; Wed, 23 Aug 2023 13:28:43 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1863864AD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99bed101b70so712591266b.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692790120; x=1693394920;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3kaoJ/EG+jEXT4We7Zj7ACE2+bzFJdORz21oYuyMT0g=;
 b=X2Ic4AetjLONbHoAqgqcY/FVxSUkWq+XDD9dRxxkPIoPJizLnu3vlgDVWq3BckRpB9
 jXSUxARmFS4oF5LbYnG5cdFFlgIAJotVzIVUGdodaNjcwqOFSklruRjB+An8ycxTymVO
 jjjFL6Iucp6koyxC7b+ZSRO5252eM2vEvZnj40/c4pS6xZ1a4jeCi92ZBJ1hoI1NEVHO
 r81KJ+FJuTvIWOZpd8BIflo3NW6YM5lwniEMS12e/Q7lJC1K/MB/RrXfDHuReCHy9ROj
 4O6b7UnByea4HsJOLp1cVeYK321caZBKGeoPLOzMMVoS9lOlPu6KCWVC7I9y+jBL/Btx
 fP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692790120; x=1693394920;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kaoJ/EG+jEXT4We7Zj7ACE2+bzFJdORz21oYuyMT0g=;
 b=fo7+6fyKqF1b3h7NHnl2suIarPJ/e9zO7I5CpfK1dHxWE5oerpo9io1IaNPkb9xjbo
 uKvWu2v9XcI/pa7TEc8NASxjhTn7JGyg2hROiD6JWBnBtUlN4S3S3t7Yg0kGVwKylM9K
 vA9wkOQLiZ8LoXy3W0rFrpUgPWNmjK1CwEiT84SSvLGZQvEJY3kVZiwsNp+qtpSkKf1H
 art3jIhRCBUKEEEw9llQ8TbGYua76VLYvJfHkB40uhM+KxnoGdjQFJpvknCfunatm+TL
 nwvXF2J5TRFxzVBnIzVFJJEvkktYk6/rulrBXETpGVy+BkqHWMboF7VccFnoMVO7EZvD
 s4Eg==
X-Gm-Message-State: AOJu0YycNW/pRJIHOvhUu9gV8VlMaVClJYTlg3uDdPqrssnaM7USwto2
 dKprEtahqY1/pq5qmPGS9Lzi3YN4N8MOfg==
X-Google-Smtp-Source: AGHT+IE2snxRIj5Tof88WXdqmUM1NJS5f6R0wbgLLjruYTZTixGXenroGXksJpgWzQ7MQYb+6PgJiQ==
X-Received: by 2002:a17:906:2253:b0:9a1:d077:b74f with SMTP id
 19-20020a170906225300b009a1d077b74fmr1708723ejr.49.1692790119869; 
 Wed, 23 Aug 2023 04:28:39 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 se22-20020a170906ce5600b009a18a86bf1csm6539865ejb.207.2023.08.23.04.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 04:28:39 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:28:38 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Marek Vasut <marex@denx.de>
CC: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOXkLmctTCKWx84G@orome>
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de> <ZOXkLmctTCKWx84G@orome>
Message-ID: <9082264C-E0EB-474F-82FF-02E4ACD1D703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 13:49:18 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sun, Aug 20, 2023 at 09:10:17PM +0200, Marek Vasut wrote:
>> On 8/20/23 20:32, Svyatoslav Ryhel wrote:
>> > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 21:14:15 GMT+0=
3:00, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>> > > On 8/20/23 09:13, Svyatoslav Ryhel wrote:
>> > > > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 05:23:14 G=
MT+03:00, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>> > > > > On 8/19/23 17:06, Svyatoslav Ryhel wrote:
>> > > > > > Some devices (like ASUS TF201) may not have fuse based xcvr s=
etup
>> > > > > > which will result in not working USB line=2E To fix this situ=
ation
>> > > > > > allow xcvr setup to be performed from device tree values if
>> > > > > > nvidia,xcvr-setup-use-fuses is not defined=2E
>> > > > > >=20
>> > > > > > Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF2=
01
>> > > > >=20
>> > > > > I would hope so=2E Usually T-B tags are not added by the patch =
author, but that's a detail, and here it has the added model value, so keep=
 it=2E
>> > > > >=20
>> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > > > > ---
>> > > > > >     drivers/usb/host/ehci-tegra=2Ec | 53 ++++++++++++++++++++=
+++++++++++----
>> > > > > >     1 file changed, 48 insertions(+), 5 deletions(-)
>> > > > > >=20
>> > > > > > diff --git a/drivers/usb/host/ehci-tegra=2Ec b/drivers/usb/ho=
st/ehci-tegra=2Ec
>> > > > > > index 2cf1625670=2E=2Ef24baf8f0c 100644
>> > > > > > --- a/drivers/usb/host/ehci-tegra=2Ec
>> > > > > > +++ b/drivers/usb/host/ehci-tegra=2Ec
>> > > > > > @@ -81,6 +81,8 @@ struct fdt_usb {
>> > > > > >        enum periph_id periph_id;/* peripheral id */
>> > > > > >        struct gpio_desc vbus_gpio;     /* GPIO for vbus enabl=
e */
>> > > > > >        struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI=
 phy */
>> > > > > > +    bool xcvr_setup_use_fuses; /* Indicates that the value i=
s read from the on-chip fuses */
>> > > > > > +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output =
control */
>> > > > > >     };
>> > > > > >       /*
>> > > > > > @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(str=
uct fdt_usb *config,
>> > > > > >                /* Recommended PHY settings for EYE diagram */
>> > > > > >                val =3D readl(&usbctlr->utmip_xcvr_cfg0);
>> > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> > > > > > -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
>> > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> > > > > > -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIF=
T);
>> > > > > > +
>> > > > > > +            if (!config->xcvr_setup_use_fuses) {
>> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
ASK,
>> > > > > > +                                    config->xcvr_setup <<
>> > > > > > +                                    UTMIP_XCVR_SETUP_SHIFT);
>> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
SB_MASK,
>> > > > > > +                                    config->xcvr_setup <<
>> > > > > > +                                    UTMIP_XCVR_SETUP_MSB_SHI=
FT);
>> > > > > > +            } else {
>> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
ASK,
>> > > > > > +                                    0x4 << UTMIP_XCVR_SETUP_=
SHIFT);
>> > > > >=20
>> > > > > What is this hard-coded value ?
>> > > > >=20
>> > > >=20
>> > > > 0x4 and 0x3 (not same) but those are not in the device tree=2E Ma=
inline linux
>> > > > driver seems not set this at all if use_fuses is enabled but I de=
cided to keep
>> > > > original setup just to not cause regressions=2E
>> > > >=20
>> > > > https://github=2Ecom/clamor-s/linux/blob/transformer/drivers/usb/=
phy/phy-tegra-usb=2Ec#L587-L590
>> > > >=20
>> > > > > Why not place this value into config->xcvr_setup in e=2Eg=2E pr=
obe() and drop this if/else statement ?
>> > > > >=20
>> > > >=20
>> > > > Because config->xcvr_setup should matter only if use_fuses is dis=
abled
>> > >=20
>> > > Can it matter always instead ?
>> > >=20
>> >=20
>> > No, it cannot=2E You are inversing hw design=2E Xcvr_setup matters on=
ly if use_fuses is disabled=2E If use_fuses is on (which is default state) =
xcvr values are taken from chip fuse=2E
>>=20
>> The way I read this block of code is, some value is written into the
>> register if config->xcvr_setup_use_fuses is false, another value if
>> config->xcvr_setup_use_fuses is true =2E Why not do this determination =
once in
>> probe and then just program the appropriate value instead ?
>>=20
>> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
SB_MASK,
>> > > > > > +                                    0x3 << UTMIP_XCVR_SETUP_=
MSB_SHIFT);
>> > > > > > +            }
>> > > > > > +
>> > > > > >                clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MA=
SK,
>> > > > > >                                0x8 << UTMIP_XCVR_HSSLEW_MSB_S=
HIFT);
>> > > > > >                writel(val, &usbctlr->utmip_xcvr_cfg0);
>> > > > > > @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struc=
t fdt_usb *config,
>> > > > > >        setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_C=
HRG);
>> > > > > >        clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSB=
IAS_SE);
>> > > > > > -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL)=
;
>> > > > > > +
>> > > > > > +    if (config->xcvr_setup_use_fuses)
>> > > > > > +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SE=
TUP_SEL);
>> > > > > >        /*
>> > > > > >         * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIM=
IT
>> > > > > > @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_o=
ps =3D {
>> > > > > >     static int ehci_usb_of_to_plat(struct udevice *dev)
>> > > > > >     {
>> > > > > >        struct fdt_usb *priv =3D dev_get_priv(dev);
>> > > > > > +    u32 usb_phy_phandle;
>> > > > > > +    ofnode usb_phy_node;
>> > > > > >        int ret;
>> > > > > >        ret =3D fdt_decode_usb(dev, priv);
>> > > > > > @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct ud=
evice *dev)
>> > > > > >        priv->type =3D dev_get_driver_data(dev);
>> > > > > >     +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy",=
 &usb_phy_phandle);
>> > > > > > +    if (ret) {
>> > > > > > +            log_debug("%s: required usb phy node isn't provi=
ded\n", __func__);
>> > > > > > +            priv->xcvr_setup_use_fuses =3D true;
>> > > > > > +            return 0;
>> > > > > > +    }
>> > > > > > +
>> > > > > > +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
>> > > > > > +    if (!ofnode_valid(usb_phy_node)) {
>> > > > > > +            log_err("%s: failed to find usb phy node\n", __f=
unc__);
>> > > > > > +            return -EINVAL;
>> > > > > > +    }
>> > > > >=20
>> > > > > dev_read_phandle() should replace the above
>> > > > >=20
>> > > >=20
>> > > > Goal of this piece is to get phy of_node by the phandle provided =
in the
>> > > > controller node=2E Controller node has not only single nvidia,phy=
 phandle
>> > > > reference but also clock and reset reference=2E How will dev_read=
_phandle
>> > > > return me a phandle of "nvidia,phy"?
>> > > >=20
>> > > > https://github=2Ecom/clamor-s/u-boot/blob/master/arch/arm/dts/teg=
ra30=2Edtsi#L798-L834
>> > > >=20
>> > > > > > +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
>> > > > > > +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
>> > > > >=20
>> > > > > dev_read_bool()
>> > > > >=20
>> > > >=20
>> > > > This value is set in phy node, not controllers unfortunately=2E
>> > >=20
>> > > The question that comes to mind is, would it make sense to implemen=
t a PHY driver similar to what e=2Eg=2E imx does -- drivers/phy/phy-imx8mq-=
usb=2Ec -- for the tegra PHY ?
>> >=20
>> > Yes, but not by me or at least not now=2E I have already invested too=
 much of my time and effort in this and I will not invest even more into re=
factoring all this code into 2 separate drivers=2E Existing code satisfies =
me apart from this small tweak=2E
>>=20
>> The PHY driver implementation is trivial, example is the imx driver abo=
ve,
>> then just call phy on/off in the right place=2E Linux also has a PHY dr=
iver
>> for tegra, maybe you can reuse it ?
>
>The Linux USB PHY driver is something that in retrospect I would've done
>differently=2E The problem is that it shares resources (registers and
>clock/reset lines) with the USB controller and it's caused a lot of
>headaches to support it in Linux=2E
>
>Maybe within U-Boot this isn't such a big deal, but for Linux I would've
>preferred a single driver that is both a USB controller and a USB PHY=2E =
I
>suppose it could expose some sort of PHY object for abstraction, but
>that would probably be a bit of overkill since this is really only used
>within the USB controller driver=2E

PHY node can be parsed by controller for values used in setup without crea=
ting separate driver=2E I would even agree to implement this=2E

>Thierry
