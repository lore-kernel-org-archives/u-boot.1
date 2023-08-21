Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264EEEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 14:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887AE86BF8;
	Mon, 21 Aug 2023 16:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HSZ8oDls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E235B86813; Mon, 21 Aug 2023 16:06:44 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB498707D
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 16:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so32521385e9.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692626802; x=1693231602;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VcWOzEQkKE5H7yKnVIurJc2u8NzzwOFVNuhZdwRkx1s=;
 b=HSZ8oDlsCmyL4zphZq5ZV1UzZBgAHlPMqlloWmjnZBEooxAwSh4glAaShbp5mBsQmh
 HeoALAMZ0j8a8mqh6kZXMYwDFR54teSNBn9rZk33uSbwQWX1zCvFji3wF9SacrKldK80
 CfOZrn+FwvJD3u+eG5MMPtxCtwpg0zFWHGFWvG88qpJMpO2wdBpB2OFsbc0S8mjcGI0Q
 Rw1MsCe1R9ZZORfAz5taWBVkQTWCcDVRrNG6gLI9IkoJT0qC0k9/NsBngP01eb8C6yp2
 ZdTzgp0f3fBXXWgiR7OpdGLjgpyd5rZR4rMSTbeDm1KUQN3H4zoKL3ewG/4CQZsZVIxR
 NBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692626802; x=1693231602;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VcWOzEQkKE5H7yKnVIurJc2u8NzzwOFVNuhZdwRkx1s=;
 b=VnhHNCHEfTB3vKm+MMGtG7zuJxry4JYPav8Emi26u2SuwlwYJpBFDgAacNyMLMNmKd
 ev1kmoeLu23MCeckAvdzuKJmOwn4snjxY/NiBCOFBKPtYnC38Bk3r/KMsvuqzjJG52h5
 4+481/TYXQ51psckhUiYE2gWquWECQOna+BumZFoWxB5e/ypYH2OwpE3oczv4psghZc8
 FHMfcQftoi3Px1KhKlEFgccDh78FOc7HApPqnOOQvx0Z9u+Je4JsBjrvCV2LJyyerkgd
 ZelM3mw5rYC86MS/95UlvBGym87bGR5G64ZLaCNxNHwUiQ0UROdULLFLA6jNqPx1DDgj
 g7+A==
X-Gm-Message-State: AOJu0YzSew2r3aEMlvykKXn6L+QQ2wMTw0TAVOhqdskO2iWB0UoET69T
 qIdy7TUFsqMFGRLZwlZl4XtAMfMdmxi6xg==
X-Google-Smtp-Source: AGHT+IHIlp0AX4TTDxVbrRgGxOIZaXcQ0Hizjvt/udGdKFGCGEswUzMG5fx5R0Ti9wiGdiLQfO9T1w==
X-Received: by 2002:adf:e482:0:b0:31a:dc27:e10 with SMTP id
 i2-20020adfe482000000b0031adc270e10mr4754096wrm.65.1692626801365; 
 Mon, 21 Aug 2023 07:06:41 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.148.65]) by smtp.gmail.com with ESMTPSA id
 k25-20020aa7c059000000b0052889d090bfsm6047925edo.79.2023.08.21.07.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 07:06:41 -0700 (PDT)
Date: Mon, 21 Aug 2023 17:06:41 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] usb: host: tegra: implement dts based xcvr setup
User-Agent: K-9 Mail for Android
In-Reply-To: <8864abd1-58c9-d529-9084-4707077f4f21@denx.de>
References: <20230821111953.5919-1-clamor95@gmail.com>
 <20230821111953.5919-2-clamor95@gmail.com>
 <8864abd1-58c9-d529-9084-4707077f4f21@denx.de>
Message-ID: <9FA3D118-5D1A-4293-A37A-8D280D62A805@gmail.com>
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

21 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:41:51 GMT+03:00, =
Marek Vasut <marex@denx=2Ede> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
>On 8/21/23 13:19, Svyatoslav Ryhel wrote:
>> Some devices (like ASUS TF201) may not use fuse based xcvr setup
>> which will result in not working USB line=2E To fix this situation
>> allow xcvr setup to be performed from device tree values if
>> nvidia,xcvr-setup-use-fuses is not defined=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>   drivers/usb/host/ehci-tegra=2Ec | 48 +++++++++++++++++++++++++++++++-=
---
>>   1 file changed, 43 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/host/ehci-tegra=2Ec b/drivers/usb/host/ehci-te=
gra=2Ec
>> index 2cf1625670=2E=2Ea9aee908f3 100644
>> --- a/drivers/usb/host/ehci-tegra=2Ec
>> +++ b/drivers/usb/host/ehci-tegra=2Ec
>> @@ -81,6 +81,8 @@ struct fdt_usb {
>>   	enum periph_id periph_id;/* peripheral id */
>>   	struct gpio_desc vbus_gpio;	/* GPIO for vbus enable */
>>   	struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
>> +	bool xcvr_setup_use_fuses; /* Indicates that the value is read from t=
he on-chip fuses */
>> +	u32 xcvr_setup;	/* Input of XCVR cell, HS driver output control */
>>   };
>>     /*
>> @@ -464,10 +466,16 @@ static int init_utmi_usb_controller(struct fdt_us=
b *config,
>>     		/* Recommended PHY settings for EYE diagram */
>>   		val =3D readl(&usbctlr->utmip_xcvr_cfg0);
>> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> -				0x4 << UTMIP_XCVR_SETUP_SHIFT);
>> -		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> -				0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
>> +
>> +		if (!config->xcvr_setup_use_fuses) {
>> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
>> +					config->xcvr_setup <<
>> +					UTMIP_XCVR_SETUP_SHIFT);
>> +			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
>> +					config->xcvr_setup <<
>> +					UTMIP_XCVR_SETUP_MSB_SHIFT);
>> +		}
>> +
>>   		clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
>>   				0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
>>   		writel(val, &usbctlr->utmip_xcvr_cfg0);
>> @@ -522,7 +530,9 @@ static int init_utmi_usb_controller(struct fdt_usb =
*config,
>>   	setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
>>     	clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
>> -	setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>> +
>> +	if (config->xcvr_setup_use_fuses)
>> +		setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
>>     	/*
>>   	 * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
>> @@ -843,6 +853,8 @@ static const struct ehci_ops tegra_ehci_ops =3D {
>>   static int ehci_usb_of_to_plat(struct udevice *dev)
>>   {
>>   	struct fdt_usb *priv =3D dev_get_priv(dev);
>> +	u32 usb_phy_phandle;
>> +	ofnode usb_phy_node;
>>   	int ret;
>>     	ret =3D fdt_decode_usb(dev, priv);
>> @@ -851,6 +863,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev=
)
>>     	priv->type =3D dev_get_driver_data(dev);
>>   +	ret =3D ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_pha=
ndle);
>> +	if (ret) {
>> +		log_debug("%s: required usb phy node isn't provided\n", __func__);
>> +		priv->xcvr_setup_use_fuses =3D true;
>> +		return 0;
>> +	}
>> +
>> +	usb_phy_node =3D ofnode_get_by_phandle(usb_phy_phandle);
>> +	if (!ofnode_valid(usb_phy_node)) {
>> +		log_err("%s: failed to find usb phy node\n", __func__);
>> +		return -EINVAL;
>> +	}
>
>Can we get a simple PHY driver instead of this hackage please ?
>
>See the generic PHY stuff in other ehci drivers for example of how to int=
eract with PHY drivers, and drivers/phy/ for PHY driver examples=2E

No we can't=2E As I said, I will not start a split of tegra-echi to chipid=
ea controller and phy because of this small tweak=2E It seems that you don'=
t understand what your are requesting=2E Sorry for bothering=2E
