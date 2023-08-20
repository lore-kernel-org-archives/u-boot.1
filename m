Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F40EE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 18:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA9B8692C;
	Sun, 20 Aug 2023 20:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbKhb4xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DFC867EA; Sun, 20 Aug 2023 20:32:40 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F2E8692C
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 20:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so3255750a12.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692556356; x=1693161156;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZFC6inD/3J+rTnYYlxMNiPT7BkFpeKH+lVNOuD+hmag=;
 b=hbKhb4xdpW0aYXhX4DJsJhCYL8wC40zCqcrvJLWk9XphYoQ2igjQGPp2up8ChYgpde
 gfWQsXrBi86tNTx95A6acFGJ7VCif3bKYsdKoLD3s/iq4M+8+sNv0SGrOQWiFRxLGMGP
 c3Ac5Oxne845kvHP7QqxTtVqxH5SGlqJWVmb5rIcCu98xMbCJQGvHW9EL6UAQgt3DUNy
 qhjOeSzLuHnwJ91C/vyNYTLXaKnKvS/nhTLal7/hPbNIQgKh5bP1R87IpUHW3cxXkBpg
 AwXCRCxw3x5zLiqe/atrOF7obiZdJD0xYetcXHlX4D9OnLcIB+IBdoOeAhuTgOZjktTu
 4L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692556356; x=1693161156;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFC6inD/3J+rTnYYlxMNiPT7BkFpeKH+lVNOuD+hmag=;
 b=HRBkVqk/fNDmVYjA5z8OiVTnvBjyU7tKqjQYCW9MJohW0dt8LuYsS964jTMPDbACbB
 dWEXC3w38ECYdssXAnwYrSG3W3gLaWTetFiOQsVoynlBnZBBkW69s9zz53WDxpkacuuZ
 SkLiSfchlU25YMjrBN/MtmbfQQ7X1hBbpgL0UV12S/lrmtOKOog0tNBmaRt3GNrSi5oJ
 1sb5KtdTa426sA3a3dJuvBJGio9kj+ugkD7UA8J4MPm9X0ojHDRxGmmGRU9Sfq0kjoTY
 GrKIm9+CO8WNDbxNr9EVEAFmsjKG/4tCetc7LWmJGVMXyss12jEvO+4KTiROm2IHULV/
 B8xg==
X-Gm-Message-State: AOJu0Yw9PmDvvE2jq0yWIo/kLsr7aK6aRw/8A2b+JvvQsZjWXRdmbO35
 wmHqVhU36IhNICFpetuwLUHBLJXBnSlZoA==
X-Google-Smtp-Source: AGHT+IFWAYBUAZmjdT3Ggyemavt8h63uAsGm9hWp6vXjTe4jx8iSIMMJ0Bij4/+NiaHivzxd9tf1ZA==
X-Received: by 2002:aa7:c603:0:b0:523:ae0a:a446 with SMTP id
 h3-20020aa7c603000000b00523ae0aa446mr3519624edq.24.1692556355605; 
 Sun, 20 Aug 2023 11:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.24.140]) by smtp.gmail.com with ESMTPSA id
 w23-20020aa7cb57000000b0052a063e52b8sm1383405edt.83.2023.08.20.11.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 11:32:35 -0700 (PDT)
Date: Sun, 20 Aug 2023 21:32:34 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
User-Agent: K-9 Mail for Android
In-Reply-To: <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
 <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
 <8c8b9849-9960-4f88-ef93-5a41b6d006bb@denx.de>
Message-ID: <7F964CFB-304C-41F4-81AA-52C412965CB1@gmail.com>
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

20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 21:14:15 GMT+03:00, =
Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
>On 8/20/23 09:13, Svyatoslav Ryhel wrote:
>> 20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 05:23:14 GMT+03:=
00, Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>>> On 8/19/23 17:06, Svyatoslav Ryhel wrote:
>>>> Some devices (like ASUS TF201) may not have fuse based xcvr setup
>>>> which will result in not working USB line=2E To fix this situation
>>>> allow xcvr setup to be performed from device tree values if
>>>> nvidia,xcvr-setup-use-fuses is not defined=2E
>>>>=20
>>>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF201
>>>=20
>>> I would hope so=2E Usually T-B tags are not added by the patch author,=
 but that's a detail, and here it has the added model value, so keep it=2E
>>>=20
>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>>>> ---
>>>>    drivers/usb/host/ehci-tegra=2Ec | 53 +++++++++++++++++++++++++++++=
++----
>>>>    1 file changed, 48 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/drivers/usb/host/ehci-tegra=2Ec b/drivers/usb/host/ehci-=
tegra=2Ec
>>>> index 2cf1625670=2E=2Ef24baf8f0c 100644
>>>> --- a/drivers/usb/host/ehci-tegra=2Ec
>>>> +++ b/drivers/usb/host/ehci-tegra=2Ec
>>>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>>>       enum periph_id periph_id;/* peripheral id */
>>>>       struct gpio_desc vbus_gpio;     /* GPIO for vbus enable */
>>>>       struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
>>>> +    bool xcvr_setup_use_fuses; /* Indicates that the value is read f=
rom the on-chip fuses */
>>>> +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output control =
*/
>>>>    };
>>>>      /*
>>>> @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struct fdt_=
usb *config,
>>>>               /* Recommended PHY settings for EYE diagram */
>>>>               val =3D readl(&usbctlr->utmip_xcvr_cfg0);
>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>> -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>> -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>> +
>>>> +            if (!config->xcvr_setup_use_fuses) {
>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>> +                                    config->xcvr_setup <<
>>>> +                                    UTMIP_XCVR_SETUP_SHIFT);
>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>> +                                    config->xcvr_setup <<
>>>> +                                    UTMIP_XCVR_SETUP_MSB_SHIFT);
>>>> +            } else {
>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>>>> +                                    0x4 << UTMIP_XCVR_SETUP_SHIFT);
>>>=20
>>> What is this hard-coded value ?
>>>=20
>>=20
>> 0x4 and 0x3 (not same) but those are not in the device tree=2E Mainline=
 linux
>> driver seems not set this at all if use_fuses is enabled but I decided =
to keep
>> original setup just to not cause regressions=2E
>>=20
>> https://github=2Ecom/clamor-s/linux/blob/transformer/drivers/usb/phy/ph=
y-tegra-usb=2Ec#L587-L590
>>=20
>>> Why not place this value into config->xcvr_setup in e=2Eg=2E probe() a=
nd drop this if/else statement ?
>>>=20
>>=20
>> Because config->xcvr_setup should matter only if use_fuses is disabled
>
>Can it matter always instead ?
>

No, it cannot=2E You are inversing hw design=2E Xcvr_setup matters only if=
 use_fuses is disabled=2E If use_fuses is on (which is default state) xcvr =
values are taken from chip fuse=2E

>>>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>>>> +                                    0x3 << UTMIP_XCVR_SETUP_MSB_SHIF=
T);
>>>> +            }
>>>> +
>>>>               clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>>>                               0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>>>               writel(val, &usbctlr->utmip_xcvr_cfg0);
>>>> @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct fdt_us=
b *config,
>>>>       setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>>>       clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
>>>> -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>>> +
>>>> +    if (config->xcvr_setup_use_fuses)
>>>> +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL)=
;
>>>>       /*
>>>>        * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>>>> @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops =3D {
>>>>    static int ehci_usb_of_to_plat(struct udevice *dev)
>>>>    {
>>>>       struct fdt_usb *priv =3D dev_get_priv(dev);
>>>> +    u32 usb_phy_phandle;
>>>> +    ofnode usb_phy_node;
>>>>       int ret;
>>>>       ret =3D fdt_decode_usb(dev, priv);
>>>> @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udevice *d=
ev)
>>>>       priv->type =3D dev_get_driver_data(dev);
>>>>    +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy=
_phandle);
>>>> +    if (ret) {
>>>> +            log_debug("%s: required usb phy node isn't provided\n", =
__func__);
>>>> +            priv->xcvr_setup_use_fuses =3D true;
>>>> +            return 0;
>>>> +    }
>>>> +
>>>> +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
>>>> +    if (!ofnode_valid(usb_phy_node)) {
>>>> +            log_err("%s: failed to find usb phy node\n", __func__);
>>>> +            return -EINVAL;
>>>> +    }
>>>=20
>>> dev_read_phandle() should replace the above
>>>=20
>>=20
>> Goal of this piece is to get phy of_node by the phandle provided in the
>> controller node=2E Controller node has not only single nvidia,phy phand=
le
>> reference but also clock and reset reference=2E How will dev_read_phand=
le
>> return me a phandle of "nvidia,phy"?
>>=20
>> https://github=2Ecom/clamor-s/u-boot/blob/master/arch/arm/dts/tegra30=
=2Edtsi#L798-L834
>>=20
>>>> +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
>>>> +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
>>>=20
>>> dev_read_bool()
>>>=20
>>=20
>> This value is set in phy node, not controllers unfortunately=2E
>
>The question that comes to mind is, would it make sense to implement a PH=
Y driver similar to what e=2Eg=2E imx does -- drivers/phy/phy-imx8mq-usb=2E=
c -- for the tegra PHY ?

Yes, but not by me or at least not now=2E I have already invested too much=
 of my time and effort in this and I will not invest even more into refacto=
ring all this code into 2 separate drivers=2E Existing code satisfies me ap=
art from this small tweak=2E
