Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2831EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 10:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D132C864B3;
	Wed, 23 Aug 2023 12:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRaAtIMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F124864B9; Wed, 23 Aug 2023 12:49:23 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 186EE864AD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 12:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-991c786369cso727483966b.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692787760; x=1693392560;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0VV7IjjiB37pa4vVux9bq044RTV+PTFU9mwz+7Z7u0=;
 b=fRaAtIMHaB86zQ8R3LdR6wXhxOzJed18JKpx8pvWG31A4NqDMPYxM/4l8q6c6JohOu
 FRe6msaUXXsXH06BFpWm1WZKUKhyvejjUPUruglF7fw5pFJ1lO+zvJqsJfOk5YAPmqVe
 k1ESOIUwG6L6L/YUlCV6qhJlr0B5yFY2ngXyq15d/gCxDWBFZCTxOwr0i0PlspOvQdC1
 8XGUjEMHDMVoYJolFITNlKe2jt5EkRTdfkCttpz4RsHbesjVCftSK61xMU9DaNDsQVgO
 dCiwq+IUUteQgNbfmeOtsHW2f7PAOI1ZnUdF+KZjlwi09yKdn5QkSB10BfEnWc6CiUrW
 FPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692787760; x=1693392560;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0VV7IjjiB37pa4vVux9bq044RTV+PTFU9mwz+7Z7u0=;
 b=h32aOpCMGPyubgscmRGAtPvN0VfqMRL/ubP94VF1WMD8EXF0dOM+tz3h/fpcjmKD/M
 k+uGZP/JONvw0bwOg5qOWgQzxmcJRb6Wa2UBA7lJqJYhW3TsVKMMKsLmCTVPFIOvfLFx
 ObTDm7wFg+bX571umSckpe3dUPflGh/rlvloS2g78lGIm1Qf9Qta0mARp2B/9lLafsIh
 M/uvNcw1gqyaWnVcdaY3pbLHEZQ8gNVIfnhJnwFCkB9N88Y/4JPd8y4FvV54eYirVV/A
 N1nQ/Sui5bix9375CXN2m4T89HJLll+THH5jYq/XiFymV/Pfxf/aKIddq+oNA16BzyHW
 Rufw==
X-Gm-Message-State: AOJu0YwcE/rYWmApSCsPFM74NHfs6P1m2YvRgyML4jriNVALWZWdLRNm
 0UybK9cReWJUbUpt3PkZUoA=
X-Google-Smtp-Source: AGHT+IGzgRgy47udPFGYs76H4YUTTiwRBO5DBfWO4yicKeAkH68Nzppc8yN1yQJyYy+95zTCq8J33g==
X-Received: by 2002:a17:907:a067:b0:99d:e417:d6f6 with SMTP id
 ia7-20020a170907a06700b0099de417d6f6mr8146116ejc.32.1692787760315; 
 Wed, 23 Aug 2023 03:49:20 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a170906134600b00992d70f8078sm9716842ejb.106.2023.08.23.03.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 03:49:19 -0700 (PDT)
Date: Wed, 23 Aug 2023 12:49:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
Message-ID: <ZOXkLmctTCKWx84G@orome>
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dN18GV1KjerXHz4u"
Content-Disposition: inline
In-Reply-To: <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--dN18GV1KjerXHz4u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 09:10:17PM +0200, Marek Vasut wrote:
> On 8/20/23 20:32, Svyatoslav Ryhel wrote:
> > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 21:14:15 GMT+03:00=
, Marek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> > > On 8/20/23 09:13, Svyatoslav Ryhel wrote:
> > > > 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 05:23:14 GMT+0=
3:00, Marek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> > > > > On 8/19/23 17:06, Svyatoslav Ryhel wrote:
> > > > > > Some devices (like ASUS TF201) may not have fuse based xcvr set=
up
> > > > > > which will result in not working USB line. To fix this situation
> > > > > > allow xcvr setup to be performed from device tree values if
> > > > > > nvidia,xcvr-setup-use-fuses is not defined.
> > > > > >=20
> > > > > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
> > > > >=20
> > > > > I would hope so. Usually T-B tags are not added by the patch auth=
or, but that's a detail, and here it has the added model value, so keep it.
> > > > >=20
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >     drivers/usb/host/ehci-tegra.c | 53 ++++++++++++++++++++++++=
+++++++----
> > > > > >     1 file changed, 48 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/e=
hci-tegra.c
> > > > > > index 2cf1625670..f24baf8f0c 100644
> > > > > > --- a/drivers/usb/host/ehci-tegra.c
> > > > > > +++ b/drivers/usb/host/ehci-tegra.c
> > > > > > @@ -81,6 +81,8 @@ struct fdt_usb {
> > > > > >        enum periph_id periph_id;/* peripheral id */
> > > > > >        struct gpio_desc vbus_gpio;     /* GPIO for vbus enable =
*/
> > > > > >        struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI p=
hy */
> > > > > > +    bool xcvr_setup_use_fuses; /* Indicates that the value is =
read from the on-chip fuses */
> > > > > > +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output co=
ntrol */
> > > > > >     };
> > > > > >       /*
> > > > > > @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struc=
t fdt_usb *config,
> > > > > >                /* Recommended PHY settings for EYE diagram */
> > > > > >                val =3D readl(&usbctlr->utmip_xcvr_cfg0);
> > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
> > > > > > -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
> > > > > > -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
> > > > > > -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
> > > > > > +
> > > > > > +            if (!config->xcvr_setup_use_fuses) {
> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MAS=
K,
> > > > > > +                                    config->xcvr_setup <<
> > > > > > +                                    UTMIP_XCVR_SETUP_SHIFT);
> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB=
_MASK,
> > > > > > +                                    config->xcvr_setup <<
> > > > > > +                                    UTMIP_XCVR_SETUP_MSB_SHIFT=
);
> > > > > > +            } else {
> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MAS=
K,
> > > > > > +                                    0x4 << UTMIP_XCVR_SETUP_SH=
IFT);
> > > > >=20
> > > > > What is this hard-coded value ?
> > > > >=20
> > > >=20
> > > > 0x4 and 0x3 (not same) but those are not in the device tree. Mainli=
ne linux
> > > > driver seems not set this at all if use_fuses is enabled but I deci=
ded to keep
> > > > original setup just to not cause regressions.
> > > >=20
> > > > https://github.com/clamor-s/linux/blob/transformer/drivers/usb/phy/=
phy-tegra-usb.c#L587-L590
> > > >=20
> > > > > Why not place this value into config->xcvr_setup in e.g. probe() =
and drop this if/else statement ?
> > > > >=20
> > > >=20
> > > > Because config->xcvr_setup should matter only if use_fuses is disab=
led
> > >=20
> > > Can it matter always instead ?
> > >=20
> >=20
> > No, it cannot. You are inversing hw design. Xcvr_setup matters only if =
use_fuses is disabled. If use_fuses is on (which is default state) xcvr val=
ues are taken from chip fuse.
>=20
> The way I read this block of code is, some value is written into the
> register if config->xcvr_setup_use_fuses is false, another value if
> config->xcvr_setup_use_fuses is true . Why not do this determination once=
 in
> probe and then just program the appropriate value instead ?
>=20
> > > > > > +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB=
_MASK,
> > > > > > +                                    0x3 << UTMIP_XCVR_SETUP_MS=
B_SHIFT);
> > > > > > +            }
> > > > > > +
> > > > > >                clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
> > > > > >                                0x8 << UTMIP_XCVR_HSSLEW_MSB_SHI=
FT);
> > > > > >                writel(val, &usbctlr->utmip_xcvr_cfg0);
> > > > > > @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct =
fdt_usb *config,
> > > > > >        setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHR=
G);
> > > > > >        clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIA=
S_SE);
> > > > > > -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
> > > > > > +
> > > > > > +    if (config->xcvr_setup_use_fuses)
> > > > > > +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETU=
P_SEL);
> > > > > >        /*
> > > > > >         * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
> > > > > > @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops=
 =3D {
> > > > > >     static int ehci_usb_of_to_plat(struct udevice *dev)
> > > > > >     {
> > > > > >        struct fdt_usb *priv =3D dev_get_priv(dev);
> > > > > > +    u32 usb_phy_phandle;
> > > > > > +    ofnode usb_phy_node;
> > > > > >        int ret;
> > > > > >        ret =3D fdt_decode_usb(dev, priv);
> > > > > > @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udev=
ice *dev)
> > > > > >        priv->type =3D dev_get_driver_data(dev);
> > > > > >     +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &=
usb_phy_phandle);
> > > > > > +    if (ret) {
> > > > > > +            log_debug("%s: required usb phy node isn't provide=
d\n", __func__);
> > > > > > +            priv->xcvr_setup_use_fuses =3D true;
> > > > > > +            return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
> > > > > > +    if (!ofnode_valid(usb_phy_node)) {
> > > > > > +            log_err("%s: failed to find usb phy node\n", __fun=
c__);
> > > > > > +            return -EINVAL;
> > > > > > +    }
> > > > >=20
> > > > > dev_read_phandle() should replace the above
> > > > >=20
> > > >=20
> > > > Goal of this piece is to get phy of_node by the phandle provided in=
 the
> > > > controller node. Controller node has not only single nvidia,phy pha=
ndle
> > > > reference but also clock and reset reference. How will dev_read_pha=
ndle
> > > > return me a phandle of "nvidia,phy"?
> > > >=20
> > > > https://github.com/clamor-s/u-boot/blob/master/arch/arm/dts/tegra30=
=2Edtsi#L798-L834
> > > >=20
> > > > > > +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
> > > > > > +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
> > > > >=20
> > > > > dev_read_bool()
> > > > >=20
> > > >=20
> > > > This value is set in phy node, not controllers unfortunately.
> > >=20
> > > The question that comes to mind is, would it make sense to implement =
a PHY driver similar to what e.g. imx does -- drivers/phy/phy-imx8mq-usb.c =
-- for the tegra PHY ?
> >=20
> > Yes, but not by me or at least not now. I have already invested too muc=
h of my time and effort in this and I will not invest even more into refact=
oring all this code into 2 separate drivers. Existing code satisfies me apa=
rt from this small tweak.
>=20
> The PHY driver implementation is trivial, example is the imx driver above,
> then just call phy on/off in the right place. Linux also has a PHY driver
> for tegra, maybe you can reuse it ?

The Linux USB PHY driver is something that in retrospect I would've done
differently. The problem is that it shares resources (registers and
clock/reset lines) with the USB controller and it's caused a lot of
headaches to support it in Linux.

Maybe within U-Boot this isn't such a big deal, but for Linux I would've
preferred a single driver that is both a USB controller and a USB PHY. I
suppose it could expose some sort of PHY object for abstraction, but
that would probably be a bit of overkill since this is really only used
within the USB controller driver.

Thierry

--dN18GV1KjerXHz4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTl5CsACgkQ3SOs138+
s6FAqg/+KqpcUNph+VQFIvJQ+YTxnmC6rkRTAkUKS/9ztF7DGKc1lWEoGngriWY7
RhatbLep+xH25fN6MkStkXooguhyRr+nANbEuwzRIcQ89k1DaDwgnMq+XsQf8hVR
3mjHfBuAD18nMD7JMyL27S1cUIat+oRPxPJyRCctysoErejfwa89Ky0UxditRUBO
h51E9eeESvXzQMeDnd8eO7E64iBly9AreMbmjAQLxlAZL/JWwLnzvfqBpAsZAlmO
4ImruM8aVHoCdiprlWAtMqlVTA7E0PYCyw5oDI30HNQxchkLiRbhMIShXg51FK3l
0fI6UzjHSiKzpsR8cjs7gnR3bbLUTu1wlbhxsw6yEeQYqDuuUdxo5Rh+cIjeTaF0
Zxox5lk5yE4vuFC+QGl4AkMc7OfDgaVf6pfR2/GxdyK8TeyQNzSbzRsN+irVm4Z0
a+9FDXfBDlpuwMCLBVHcALnYL84K9KoPphZUcwhP+GF3Cwwf6P6wmjbS2u9+m8Yn
kaRNyIOhZqRP6DDjKRQhqodbW+t3nxpqEmBtxF+3YP431MTG+WEtcDsqwXHFFOIr
lvWLhn0ratqYlCiIii0480HA2vzt4LdGqnfnH9M1gpEdp29q2O3S8jQ1sysZztel
9baXr4LWUbEYclSHdFpZ/T+umvPrzCdOy6ZbHbcwKZk1HZpbHvc=
=jnhu
-----END PGP SIGNATURE-----

--dN18GV1KjerXHz4u--
