Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DFEEE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 19:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5BC869CB;
	Sun, 20 Aug 2023 21:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+9applX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB5E86B7E; Sun, 20 Aug 2023 21:23:55 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE3F869CB
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 21:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe457ec6e7so3850207e87.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692559432; x=1693164232;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vepm1GGsdKQYWI7oOqkRXBDFXG1dUtzPxYWryRgvStY=;
 b=A+9applXQrvQSUF0ZoVY4PF8CUqiW7gmtdkjWB9SDow2AAxucESZXPsNTLaKkW8asP
 3UniPn5prh2xcIN9IEAzM1DlFmYsVx78Isg88P1xDxQt3PJohfRI9VmYJgXXuRiY2kMx
 FGEzsW6RuLs9T9glH1JVTX1jCINrVFj7wO3pFIHHUIsA1D5nmlp7jnpFUZmNVHmZOAXM
 cimivYt1SmwmHJ0EAtFAagxuE8XZDeOIwTGPWcCuY+IlwuQRymHgGlhlm94bc1YoL1Cn
 2Ol3KuI7NXMpbYwgDJ6sgkqkdAyoXOLomp5pycI1NhKLfs9gA4SvRoO4qxgCgiu1p7u4
 otsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692559432; x=1693164232;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vepm1GGsdKQYWI7oOqkRXBDFXG1dUtzPxYWryRgvStY=;
 b=Xn5dNH+1Yqkd/J19kpTjrIrTeRqb5ZC3/+QgcVtQ1lTuFqZoMS3hjf9Hsknvn7aYPC
 fXAF9QXKwCWAeecyMyylFSmvzNctQ84dRfZR8rfuRG2jyC4nqFVOKYg40VXt9AtZYvWi
 a5EYBdvTHOyDMzyZUnxQlGMTglFp48AovxWeqJH0DBKRPjYShv6SIXDD4QKLvibJSvRm
 CT9bEviE9Q1baBM/AmuU8KXJCzJ+5ViBeHMVN37+ROhXTzhsvKM4VxLFXhW7Lc/xEJ3n
 wL4tKzpHtDWlliXXA+coH8CI+aujly3Q9UKJjCbfxuP+B7AvrvUeSZqB0K+pEZAL8cTB
 nsCA==
X-Gm-Message-State: AOJu0YxH5WtwMU1AEhaibcdLCfgvY5z0xjT6SDEbCREyy+XAW8k7mtbt
 BIHZLdBY2c5hqzZwz575JyY=
X-Google-Smtp-Source: AGHT+IGQpX94J8tUO0QrHl4SUb2yt++/sckA4rAltDBDiNztWwSAnfRtO0GOYNTxgEVMWaoZlmbgqA==
X-Received: by 2002:a05:6512:2110:b0:4f8:6ac4:84 with SMTP id
 q16-20020a056512211000b004f86ac40084mr2984084lfr.8.1692559431587; 
 Sun, 20 Aug 2023 12:23:51 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.24.140]) by smtp.gmail.com with ESMTPSA id
 c17-20020a170906695100b00992a8a54f32sm5054750ejs.139.2023.08.20.12.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 12:23:51 -0700 (PDT)
Date: Sun, 20 Aug 2023 22:23:50 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
User-Agent: K-9 Mail for Android
In-Reply-To: <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de>
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
 <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
 <678cdb50-6d4a-3e04-1c10-b8d410d76a9f@denx.de>
Message-ID: <660BFE60-E330-4DA1-8466-8735BB094CFB@gmail.com>
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



20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 22:10:17 GMT+03:00,=
 Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
>On 8/20/23 20:32, Svyatoslav Ryhel wrote:
>> 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 21:14:15 GMT+03:=
00, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>>> On 8/20/23 09:13, Svyatoslav Ryhel wrote:
>>>> 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 05:23:14 GMT+0=
3:00, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>>>>> On 8/19/23 17:06, Svyatoslav Ryhel wrote:
>>>>>> Some devices (like ASUS TF201) may not have fuse based xcvr setup
>>>>>> which will result in not working USB line=2E To fix this situation
>>>>>> allow xcvr setup to be performed from device tree values if
>>>>>> nvidia,xcvr-setup-use-fuses is not defined=2E
>>>>>>=20
>>>>>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF201
>>>>>=20
>>>>> I would hope so=2E Usually T-B tags are not added by the patch autho=
r, but that's a detail, and here it has the added model value, so keep it=
=2E
>>>>>=20
>>>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>>>>>> ---
>>>>>>     drivers/usb/host/ehci-tegra=2Ec | 53 ++++++++++++++++++++++++++=
+++++----
>>>>>>     1 file changed, 48 insertions(+), 5 deletions(-)
>>>>>>=20
>>>>>> diff --git a/drivers/usb/host/ehci-tegra=2Ec b/drivers/usb/host/ehc=
i-tegra=2Ec
>>>>>> index 2cf1625670=2E=2Ef24baf8f0c 100644
>>>>>> --- a/drivers/usb/host/ehci-tegra=2Ec
>>>>>> +++ b/drivers/usb/host/ehci-tegra=2Ec
>>>>>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>>>>>        enum periph_id periph_id;/* peripheral id */
>>>>>>        struct gpio_desc vbus_gpio;     /* GPIO for vbus enable */
>>>>>>        struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy *=
/
>>>>>> +    bool xcvr_setup_use_fuses; /* Indicates that the value is read=
 from the on-chip fuses */
>>>>>> +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output contro=
l */
>>>>>>     };
>>>>>>       /*
>>>>>> @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struct fd=
t_usb *config,
>>>>>>                /* Recommended PHY settings for EYE diagram */
>>>>>>                val =3D readl(&usbctlr->utmip_xcvr_cfg0);
>>>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>> -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>>>> -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>>>> +
>>>>>> +            if (!config->xcvr_setup_use_fuses) {
>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>> +                                    config->xcvr_setup <<
>>>>>> +                                    UTMIP_XCVR_SETUP_SHIFT);
>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MAS=
K,
>>>>>> +                                    config->xcvr_setup <<
>>>>>> +                                    UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>>>> +            } else {
>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>>>> +                                    0x4 << UTMIP_XCVR_SETUP_SHIFT)=
;
>>>>>=20
>>>>> What is this hard-coded value ?
>>>>>=20
>>>>=20
>>>> 0x4 and 0x3 (not same) but those are not in the device tree=2E Mainli=
ne linux
>>>> driver seems not set this at all if use_fuses is enabled but I decide=
d to keep
>>>> original setup just to not cause regressions=2E
>>>>=20
>>>> https://github=2Ecom/clamor-s/linux/blob/transformer/drivers/usb/phy/=
phy-tegra-usb=2Ec#L587-L590
>>>>=20
>>>>> Why not place this value into config->xcvr_setup in e=2Eg=2E probe()=
 and drop this if/else statement ?
>>>>>=20
>>>>=20
>>>> Because config->xcvr_setup should matter only if use_fuses is disable=
d
>>>=20
>>> Can it matter always instead ?
>>>=20
>>=20
>> No, it cannot=2E You are inversing hw design=2E Xcvr_setup matters only=
 if use_fuses is disabled=2E If use_fuses is on (which is default state) xc=
vr values are taken from chip fuse=2E
>
>The way I read this block of code is, some value is written into the regi=
ster if config->xcvr_setup_use_fuses is false, another value if config->xcv=
r_setup_use_fuses is true =2E Why not do this determination once in probe a=
nd then just program the appropriate value instead ?

You are correct, I will remove those previous stuff=2E

>>>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MAS=
K,
>>>>>> +                                    0x3 << UTMIP_XCVR_SETUP_MSB_SH=
IFT);
>>>>>> +            }
>>>>>> +
>>>>>>                clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>>>>>                                0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>>>>>                writel(val, &usbctlr->utmip_xcvr_cfg0);
>>>>>> @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct fdt_=
usb *config,
>>>>>>        setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>>>>>        clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE=
);
>>>>>> -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>>>>> +
>>>>>> +    if (config->xcvr_setup_use_fuses)
>>>>>> +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SE=
L);
>>>>>>        /*
>>>>>>         * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>>>>>> @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops =3D=
 {
>>>>>>     static int ehci_usb_of_to_plat(struct udevice *dev)
>>>>>>     {
>>>>>>        struct fdt_usb *priv =3D dev_get_priv(dev);
>>>>>> +    u32 usb_phy_phandle;
>>>>>> +    ofnode usb_phy_node;
>>>>>>        int ret;
>>>>>>        ret =3D fdt_decode_usb(dev, priv);
>>>>>> @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udevice =
*dev)
>>>>>>        priv->type =3D dev_get_driver_data(dev);
>>>>>>     +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_=
phy_phandle);
>>>>>> +    if (ret) {
>>>>>> +            log_debug("%s: required usb phy node isn't provided\n"=
, __func__);
>>>>>> +            priv->xcvr_setup_use_fuses =3D true;
>>>>>> +            return 0;
>>>>>> +    }
>>>>>> +
>>>>>> +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
>>>>>> +    if (!ofnode_valid(usb_phy_node)) {
>>>>>> +            log_err("%s: failed to find usb phy node\n", __func__)=
;
>>>>>> +            return -EINVAL;
>>>>>> +    }
>>>>>=20
>>>>> dev_read_phandle() should replace the above
>>>>>=20
>>>>=20
>>>> Goal of this piece is to get phy of_node by the phandle provided in t=
he
>>>> controller node=2E Controller node has not only single nvidia,phy pha=
ndle
>>>> reference but also clock and reset reference=2E How will dev_read_pha=
ndle
>>>> return me a phandle of "nvidia,phy"?
>>>>=20
>>>> https://github=2Ecom/clamor-s/u-boot/blob/master/arch/arm/dts/tegra30=
=2Edtsi#L798-L834
>>>>=20
>>>>>> +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
>>>>>> +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
>>>>>=20
>>>>> dev_read_bool()
>>>>>=20
>>>>=20
>>>> This value is set in phy node, not controllers unfortunately=2E
>>>=20
>>> The question that comes to mind is, would it make sense to implement a=
 PHY driver similar to what e=2Eg=2E imx does -- drivers/phy/phy-imx8mq-usb=
=2Ec -- for the tegra PHY ?
>>=20
>> Yes, but not by me or at least not now=2E I have already invested too m=
uch of my time and effort in this and I will not invest even more into refa=
ctoring all this code into 2 separate drivers=2E Existing code satisfies me=
 apart from this small tweak=2E
>
>The PHY driver implementation is trivial, example is the imx driver above=
, then just call phy on/off in the right place=2E Linux also has a PHY driv=
er for tegra, maybe you can reuse it ?
>
>Let's not add ad-hoc hacks, those are difficult to maintain in the long r=
un=2E

Nope, no intention to do it=2E Hense I assume this patch can be dropped=2E

Best regards,
Svyatoslav R=2E
