Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67774EE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 07:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B1DD869C8;
	Sun, 20 Aug 2023 09:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTs8GYgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A037386CA7; Sun, 20 Aug 2023 09:14:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E2286963
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 09:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso2121666f8f.0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692515645; x=1693120445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSUOg1zumej0kBihskkvszBFvJPPBero8vTEdDhPw24=;
 b=lTs8GYgwuemdjVvMe/sKsgOZiBvLm97v7GVWkhUieNcN+K9dKjAktS6m6ydkFpjcZf
 vHen3bP2YlyTauyp4TQ/Hgr19RSlpr7Zj7Htam6WALjDa+soZPmaPyGE1M5NwJDp+aJy
 6pV9eUx5nctOQ1IdbT4jc1q87KGMTYHr8JtMUswYGUZRIFrewfpD46cDGs0E3mcYXoXS
 X2qJwKgcT4MmmP14QmxFakBh2L829Q3hwEi5pjG6GHqbV/rYOuDe7FYhRJc83pcrvVjM
 dOlBbVjwRiqjF3O9HMtv0uh/wQ6EH6txTgVRNAQIA+zM9iH3oPPx/LymBvVcL0hNdEhv
 QfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692515645; x=1693120445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSUOg1zumej0kBihskkvszBFvJPPBero8vTEdDhPw24=;
 b=FWPH7+WtIYthAdCeRwYNhN4AQCMdw+JYAgbLDkBh75jwIFSPijlEBTBd9QRrnAp5I8
 EPRiCHmt0TGvicL1+1SoaMjgtTZBgDklqLtTOGFxI377v3FM10z2MFihnFcHBBTNCV1T
 iNILFIGlj10y6Ee8+S6SKSx0AuHQ2USYpsAFnpLPrFgEMUq7zNvyyLklJ8CW8DD40AFe
 bNYfAVzAF/GJCUk2dorPrJTuhHMWEnnDBNq9fFBibXBb7l0sfCrErVRaSeVwVWG20ML8
 mCnCFUB1eq1dku/Rp1fyXfBEaa/4gP/tD8o5RSY2MagkW3P4Zhla3Szp1KzZ/qxsLzft
 onIw==
X-Gm-Message-State: AOJu0YwiLYYFNOeDNBPJ6R1yDfLkf9h+tfVljM5wkEh+uWmGKPY4g65i
 3p+17qxZLg98xdWNxip1OGAhCuGB585wGC8smws=
X-Google-Smtp-Source: AGHT+IGjFyCsjn1L6b74j7QmGnsBN1vLN/tUZgfrhbiydCvsbXKf4B4Z9iZYQwvOfZhndAlcrEuWoBWxhjJbBPaRI5U=
X-Received: by 2002:a5d:5412:0:b0:319:735f:92c5 with SMTP id
 g18-20020a5d5412000000b00319735f92c5mr4666222wrv.32.1692515644668; Sun, 20
 Aug 2023 00:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230819150619.76455-1-clamor95@gmail.com>
 <20230819150619.76455-2-clamor95@gmail.com>
 <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
In-Reply-To: <a0d1a60d-6a95-abf5-4892-ae1269c478eb@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 20 Aug 2023 10:13:53 +0300
Message-ID: <CAPVz0n3mmd1doFA=nbMZVC3Tm+aM9FUhGyZ8AEjtvC0k0TM9Rw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
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

20 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 05:23:14 GMT+03:00, Ma=
rek Vasut <marex@denx.de> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=
=BB=D0=B0):
>On 8/19/23 17:06, Svyatoslav Ryhel wrote:
>> Some devices (like ASUS TF201) may not have fuse based xcvr setup
>> which will result in not working USB line. To fix this situation
>> allow xcvr setup to be performed from device tree values if
>> nvidia,xcvr-setup-use-fuses is not defined.
>>
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
>
>I would hope so. Usually T-B tags are not added by the patch author, but t=
hat's a detail, and here it has the added model value, so keep it.
>
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> ---
>>   drivers/usb/host/ehci-tegra.c | 53 +++++++++++++++++++++++++++++++----
>>   1 file changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra=
.c
>> index 2cf1625670..f24baf8f0c 100644
>> --- a/drivers/usb/host/ehci-tegra.c
>> +++ b/drivers/usb/host/ehci-tegra.c
>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>      enum periph_id periph_id;/* peripheral id */
>>      struct gpio_desc vbus_gpio;     /* GPIO for vbus enable */
>>      struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
>> +    bool xcvr_setup_use_fuses; /* Indicates that the value is read from=
 the on-chip fuses */
>> +    u32 xcvr_setup; /* Input of XCVR cell, HS driver output control */
>>   };
>>     /*
>> @@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struct fdt_usb=
 *config,
>>              /* Recommended PHY settings for EYE diagram */
>>              val =3D readl(&usbctlr->utmip_xcvr_cfg0);
>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> -                            0x4 << UTMIP_XCVR_SETUP_SHIFT);
>> -            clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> -                            0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>> +
>> +            if (!config->xcvr_setup_use_fuses) {
>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> +                                    config->xcvr_setup <<
>> +                                    UTMIP_XCVR_SETUP_SHIFT);
>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> +                                    config->xcvr_setup <<
>> +                                    UTMIP_XCVR_SETUP_MSB_SHIFT);
>> +            } else {
>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> +                                    0x4 << UTMIP_XCVR_SETUP_SHIFT);
>
>What is this hard-coded value ?
>

0x4 and 0x3 (not same) but those are not in the device tree. Mainline linux
driver seems not set this at all if use_fuses is enabled but I decided to k=
eep
original setup just to not cause regressions.

https://github.com/clamor-s/linux/blob/transformer/drivers/usb/phy/phy-tegr=
a-usb.c#L587-L590

>Why not place this value into config->xcvr_setup in e.g. probe() and drop =
this if/else statement ?
>

Because config->xcvr_setup should matter only if use_fuses is disabled

>> +                    clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> +                                    0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>> +            }
>> +
>>              clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>                              0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>              writel(val, &usbctlr->utmip_xcvr_cfg0);
>> @@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct fdt_usb *=
config,
>>      setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>      clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
>> -    setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>> +
>> +    if (config->xcvr_setup_use_fuses)
>> +            setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>      /*
>>       * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>> @@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops =3D {
>>   static int ehci_usb_of_to_plat(struct udevice *dev)
>>   {
>>      struct fdt_usb *priv =3D dev_get_priv(dev);
>> +    u32 usb_phy_phandle;
>> +    ofnode usb_phy_node;
>>      int ret;
>>      ret =3D fdt_decode_usb(dev, priv);
>> @@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
>>      priv->type =3D dev_get_driver_data(dev);
>>   +  ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_pha=
ndle);
>> +    if (ret) {
>> +            log_debug("%s: required usb phy node isn't provided\n", __f=
unc__);
>> +            priv->xcvr_setup_use_fuses =3D true;
>> +            return 0;
>> +    }
>> +
>> +    usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
>> +    if (!ofnode_valid(usb_phy_node)) {
>> +            log_err("%s: failed to find usb phy node\n", __func__);
>> +            return -EINVAL;
>> +    }
>
>dev_read_phandle() should replace the above
>

Goal of this piece is to get phy of_node by the phandle provided in the
controller node. Controller node has not only single nvidia,phy phandle
reference but also clock and reset reference. How will dev_read_phandle
return me a phandle of "nvidia,phy"?

https://github.com/clamor-s/u-boot/blob/master/arch/arm/dts/tegra30.dtsi#L7=
98-L834

>> +    priv->xcvr_setup_use_fuses =3D ofnode_read_bool(
>> +            usb_phy_node, "nvidia,xcvr-setup-use-fuses");
>
>dev_read_bool()
>

This value is set in phy node, not controllers unfortunately.

>> +    if (!priv->xcvr_setup_use_fuses) {
>> +            ret =3D ofnode_read_u32(usb_phy_node, "nvidia,xcvr-setup",
>> +                                  &priv->xcvr_setup);
>> +            if (ret)
>> +                    return ret;
>> +    }
>> +
>> +    log_debug("%s: xcvr_setup_use_fuses %d, xcvr_setup %d\n",
>> +              __func__, priv->xcvr_setup_use_fuses, priv->xcvr_setup);
>
>Is xcvr_setup always initialized, e.g. in case priv->xcvr_setup_use_fuses=
=3Dtrue ?

Yes, xcvr_setup is always initialized, unless the device needs it to
be disabled.
