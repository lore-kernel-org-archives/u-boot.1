Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0FBC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 17:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 463AE8647A;
	Fri, 25 Aug 2023 19:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ju4A6dcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26908863EF; Fri, 25 Aug 2023 19:35:02 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD928647A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-313e742a787so792948f8f.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692984898; x=1693589698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZubAjs1L5tugUqAlD0Cpvzoe/PPAWSSDkqqezslrD0U=;
 b=Ju4A6dcf6tYEI+Cqj3Qub1SVgJzHhlSZj+2eg4l9Z5CAw+DBeDsIHlr4WMPAFjj6tM
 G6OTAbLCkVj22Att8TrzhiLn16+CHKfEbsNKYVrtss4QX/r36rJh0uKngrupBDpQeIzq
 aMnBJD0XT4IgIPoz89KEF2ofgnV4wg0OWO2WoIpo/p/g6Z5EGOT3YpNeh1okAnpGKx0B
 pWSoMo28y1Di50wRBAmlCrHkB6ew/JxSuFZu8c0Ht/BW2dqEeVNvZEdQ0BKcJnSfBq4i
 cb9/x56YwNle2VS7utU8CO2iLoRj35AE5x1PM/pVw+5RqWv0ebTEFQFayP/YjbHSSxYg
 0Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692984898; x=1693589698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZubAjs1L5tugUqAlD0Cpvzoe/PPAWSSDkqqezslrD0U=;
 b=AIEU4pozXc14I+FH5MBpq+nv30s1T88iMGb00hDoIWqBpCZ4lFeSSwUpHr4ijV7IhL
 1fIXwlaMMaIfRRdGxmXmVyLQGtosl/rhcXdvSfJqCKga0Tvq4Ly7eYUZq4ZOhDwABu9O
 0pFdgDXLdRMCUMtt6nGJDNXzzdS8lR+i+LTsgPKUGcHujP1iRngYdZXs3XNighwYqTqM
 7GPB2wSJDe8tZIjhHGtsSGvyObCdJcGgu2pttxKAfgwiJJU9njpMT9W4pGFz1CMvDZKO
 2aFZCkbjUFhXE3TA5LxM+230y4e9uObM8fzcfyxCKxoC5MihIymPlgE9mlhvCdi874KI
 F3jw==
X-Gm-Message-State: AOJu0YxE/aO8Tlws7WrcX6Flc8+mA5fJykGoIlBmCuANztINvToPLAvM
 JSTspWaoHCOi7sxmLkE+xe9t+t1aF/WTo+l/Bts=
X-Google-Smtp-Source: AGHT+IF41JD+dZSk4TcVO8DVHKTF4cU3zVm5jMaWGwg4yEYyCBK1lUAH5cxR8PNmmy90NvAkPjlmuCgADp0m8cyo5lg=
X-Received: by 2002:a05:6000:1361:b0:30e:56b3:60fe with SMTP id
 q1-20020a056000136100b0030e56b360femr15151684wrz.4.1692984897335; Fri, 25 Aug
 2023 10:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de> <ZOXkLmctTCKWx84G@orome>
In-Reply-To: <ZOXkLmctTCKWx84G@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 25 Aug 2023 20:34:46 +0300
Message-ID: <CAPVz0n0eXu5WKoybYbXjWNeenL6_5=-ztToeZ2DanYiTRnqHKQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
To: Thierry Reding <thierry.reding@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

=D1=81=D1=80, 23 =D1=81=D0=B5=D1=80=D0=BF. 2023=E2=80=AF=D1=80. =D0=BE 13:4=
9 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Aug 20, 2023 at 09:10:17PM +0200, Marek Vasut wrote:
> > On 8/20/23 20:32, Svyatoslav Ryhel wrote:
> > > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 21:14:15 GMT+03:=
00, Marek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> > > > On 8/20/23 09:13, Svyatoslav Ryhel wrote:
> > > > > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 05:23:14 GMT=
+03:00, Marek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> > > > > > On 8/19/23 17:06, Svyatoslav Ryhel wrote:
> > > > > > > Some devices (like ASUS TF201) may not have fuse based xcvr s=
etup
> > > > > > > which will result in not working USB line. To fix this situat=
ion
> > > > > > > allow xcvr setup to be performed from device tree values if
> > > > > > > nvidia,xcvr-setup-use-fuses is not defined.
> > > > > > >
> > > > > > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> > > > > >
> > > > > > I would hope so. Usually T-B tags are not added by the patch au=
thor, but that's a detail, and here it has the added model value, so keep i=
t.
> > > > > >
> > > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > > ---
> > > > > > >     drivers/usb/host/ehci-tegra.c | 53 ++++++++++++++++++++++=
+++++++++----
> > > > > > >     1 file changed, 48 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host=
/ehci-tegra.c
> > > > > > > index 2cf1625670..f24baf8f0c 100644
> > > > > > > --- a/drivers/usb/host/ehci-tegra.c
> > > > > > > +++ b/drivers/usb/host/ehci-tegra.c
> > > > > > > @@ -81,6 +81,8 @@ struct fdt_usb {
> > > > > > >        enum periph_id periph_id;/* peripheral id */
> > > > > > >        struct gpio_desc vbus_gpio;     /* GPIO for vbus enabl=
e */
> > > > > > >        struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI=
 phy */
> > > > > > > +    bool xcvr_setup_use_fuses; /* Indicates that the value i=
s read from the on-chip fuses */
> > > > > > > +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output =
control */
> > > > > > >     };
> > > > > > >       /*
> > > > > > > @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(str=
uct fdt_usb *config,
> > > > > > >                /* Recommended PHY settings for EYE diagram */
> > > > > > >                val =3D readl(&usbctlr->utmip_xcvr_cfg0);
> > > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
> > > > > > > -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
> > > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
> > > > > > > -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIF=
T);
> > > > > > > +
> > > > > > > +            if (!config->xcvr_setup_use_fuses) {
> > > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
ASK,
> > > > > > > +                                    config->xcvr_setup <<
> > > > > > > +                                    UTMIP_XCVR_SETUP_SHIFT);
> > > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
SB_MASK,
> > > > > > > +                                    config->xcvr_setup <<
> > > > > > > +                                    UTMIP_XCVR_SETUP_MSB_SHI=
FT);
> > > > > > > +            } else {
> > > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
ASK,
> > > > > > > +                                    0x4 << UTMIP_XCVR_SETUP_=
SHIFT);
> > > > > >
> > > > > > What is this hard-coded value ?
> > > > > >
> > > > >
> > > > > 0x4 and 0x3 (not same) but those are not in the device tree. Main=
line linux
> > > > > driver seems not set this at all if use_fuses is enabled but I de=
cided to keep
> > > > > original setup just to not cause regressions.
> > > > >
> > > > > https://github.com/clamor-s/linux/blob/transformer/drivers/usb/ph=
y/phy-tegra-usb.c#L587-L590
> > > > >
> > > > > > Why not place this value into config->xcvr_setup in e.g. probe(=
) and drop this if/else statement ?
> > > > > >
> > > > >
> > > > > Because config->xcvr_setup should matter only if use_fuses is dis=
abled
> > > >
> > > > Can it matter always instead ?
> > > >
> > >
> > > No, it cannot. You are inversing hw design. Xcvr_setup matters only i=
f use_fuses is disabled. If use_fuses is on (which is default state) xcvr v=
alues are taken from chip fuse.
> >
> > The way I read this block of code is, some value is written into the
> > register if config->xcvr_setup_use_fuses is false, another value if
> > config->xcvr_setup_use_fuses is true . Why not do this determination on=
ce in
> > probe and then just program the appropriate value instead ?
> >
> > > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_M=
SB_MASK,
> > > > > > > +                                    0x3 << UTMIP_XCVR_SETUP_=
MSB_SHIFT);
> > > > > > > +            }
> > > > > > > +
> > > > > > >                clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MA=
SK,
> > > > > > >                                0x8 << UTMIP_XCVR_HSSLEW_MSB_S=
HIFT);
> > > > > > >                writel(val, &usbctlr->utmip_xcvr_cfg0);
> > > > > > > @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struc=
t fdt_usb *config,
> > > > > > >        setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_C=
HRG);
> > > > > > >        clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSB=
IAS_SE);
> > > > > > > -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL)=
;
> > > > > > > +
> > > > > > > +    if (config->xcvr_setup_use_fuses)
> > > > > > > +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SE=
TUP_SEL);
> > > > > > >        /*
> > > > > > >         * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIM=
IT
> > > > > > > @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_o=
ps =3D {
> > > > > > >     static int ehci_usb_of_to_plat(struct udevice *dev)
> > > > > > >     {
> > > > > > >        struct fdt_usb *priv =3D dev_get_priv(dev);
> > > > > > > +    u32 usb_phy_phandle;
> > > > > > > +    ofnode usb_phy_node;
> > > > > > >        int ret;
> > > > > > >        ret =3D fdt_decode_usb(dev, priv);
> > > > > > > @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct ud=
evice *dev)
> > > > > > >        priv->type =3D dev_get_driver_data(dev);
> > > > > > >     +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy",=
 &usb_phy_phandle);
> > > > > > > +    if (ret) {
> > > > > > > +            log_debug("%s: required usb phy node isn't provi=
ded\n", __func__);
> > > > > > > +            priv->xcvr_setup_use_fuses =3D true;
> > > > > > > +            return 0;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
> > > > > > > +    if (!ofnode_valid(usb_phy_node)) {
> > > > > > > +            log_err("%s: failed to find usb phy node\n", __f=
unc__);
> > > > > > > +            return -EINVAL;
> > > > > > > +    }
> > > > > >
> > > > > > dev_read_phandle() should replace the above
> > > > > >
> > > > >
> > > > > Goal of this piece is to get phy of_node by the phandle provided =
in the
> > > > > controller node. Controller node has not only single nvidia,phy p=
handle
> > > > > reference but also clock and reset reference. How will dev_read_p=
handle
> > > > > return me a phandle of "nvidia,phy"?
> > > > >
> > > > > https://github.com/clamor-s/u-boot/blob/master/arch/arm/dts/tegra=
30.dtsi#L798-L834
> > > > >
> > > > > > > +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
> > > > > > > +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
> > > > > >
> > > > > > dev_read_bool()
> > > > > >
> > > > >
> > > > > This value is set in phy node, not controllers unfortunately.
> > > >
> > > > The question that comes to mind is, would it make sense to implemen=
t a PHY driver similar to what e.g. imx does -- drivers/phy/phy-imx8mq-usb.=
c -- for the tegra PHY ?
> > >
> > > Yes, but not by me or at least not now. I have already invested too m=
uch of my time and effort in this and I will not invest even more into refa=
ctoring all this code into 2 separate drivers. Existing code satisfies me a=
part from this small tweak.
> >
> > The PHY driver implementation is trivial, example is the imx driver abo=
ve,
> > then just call phy on/off in the right place. Linux also has a PHY driv=
er
> > for tegra, maybe you can reuse it ?
>
> The Linux USB PHY driver is something that in retrospect I would've done
> differently. The problem is that it shares resources (registers and
> clock/reset lines) with the USB controller and it's caused a lot of
> headaches to support it in Linux.
>
> Maybe within U-Boot this isn't such a big deal, but for Linux I would've
> preferred a single driver that is both a USB controller and a USB PHY. I
> suppose it could expose some sort of PHY object for abstraction, but
> that would probably be a bit of overkill since this is really only used
> within the USB controller driver.

Marek, sorry but at this point I am with Thierry, this stuff will be
more painful
to maintain as 2 separate parts then as it is now. Moreover, it will not pr=
ovide
any benefit, ony issues like waste time to split, maintain 2 files and
literally no
code reusability or reduction.

I have made a rough sketch of how phy node parsing may look, but I cannot
load it here as a patch because it requires first that follow up patches re=
lated
to boards I have sent to be merged (yes, hard to explain, Thierry should kn=
ow).

You may check commit in my personal fork here
https://github.com/clamor-s/u-boot/commit/c8b896192ab9ce3dd578cf224e2c81c8b=
4049ea1

> Thierry
