Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B0FC1B087
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC1281100;
	Thu, 27 Feb 2025 11:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kuqufh0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B66481101; Thu, 27 Feb 2025 11:19:44 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA671810F9
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so5056885e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740651581; x=1741256381;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ztJfU3zpxmE5t6Ufm9Y53qjWup2IIfxcTji6/LmLge4=;
 b=Kuqufh0/beAwlcV6ac6CHnO4B/w3rVRyi/dlbkUMnuaHkl51NNMXuml4mC8xP0As9D
 hNWUVhKoUfH19cY/IWXbaCkOKWpZvrbc3U6qzKCiKfPc2sUuJgszW+nn8SOGdYdhFZ+A
 ckUZ9KSfET0VxiYwYRkEA1W6qz/j82N+Qcx7Zv13K4+iCo1N0ffxhnhua7pcG85nKjUa
 XHnhg4Y9dsGUrasgxLmE4bC1zzepoz/w3W0AISKoQnKlV6rIURufu1rtQVZjLEzIn5Xm
 YX7MsJuUER79yuSBC9q3wgoas93IKI3VVDjvrMwop48X8JLlbnJvJAsFC6a3vMeD+tX0
 mzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740651581; x=1741256381;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztJfU3zpxmE5t6Ufm9Y53qjWup2IIfxcTji6/LmLge4=;
 b=wMR8zJ2QjYpLG9wS5b0PXXHtfB3MsgnZango0dzwjtfu+wqelGKjwUj98fc3i6xSSW
 jxiMvoXpN91U7gPsdrVR5zfLo7F8rfAkyHZpHtb55G3qwQeebHsrOZ2pXUdP5gG0c7mO
 It7WKlnVpLTw8ROGRdMTb4UV75fJJAyfNNcvfaCeEobXB9QlGeWhufsLiQhbnHX3a/Mf
 h7DIQuE8gV2sZHkNSg+Dj7iUpX/xv8OdCD/2WbmzwXVMFqnL4zcTQo6WRnjk+GPZjead
 fEdXWyIk6kot1frQCKbtnlA+gCHMKiSDNA4B7vnZB45RMC3of3yRdgl+QFX2enK5kYqh
 L97g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRg4anwFWacmgqtpFuTiJBKtYcxioxX+8QtALZSuDjrboboN1+n2eKGzhOYPG8Cy32sjuvBTM=@lists.denx.de
X-Gm-Message-State: AOJu0YyEhkllX/APpq+h0d+drfseS4ap8935nfFn4G/VFDd+OhluQT3O
 GngvbKfuQ9PfhbX+Drkk0Bpy81LUrOrYA6Vp/W1K1sJRv8AMAUE8wmpmG/6mDlg=
X-Gm-Gg: ASbGncts7Z9joHyJJNWH13078iRNo3gQYtaJavh15tYatB08SspjwxKM3R+h5FL5jMe
 VRDEODxOhOU3DL298e99KlFMMFVjS0LFCpj1DBY/lYwbHPR1dQl63purXevtxBhjBauouH41DhJ
 y+hZi0iYGmYUuzetHlV/QT/B5l36ZVuvu7Bg688Q+krzqvRA0udukyz9l8QPz/BfDX/ofvuZL/7
 uc/N+DZLKX/JMFgsYD5/ZtKS7B3QHp/BSIBF/7k1bjR/F8pT/OB9Q9EkkI0h6bxGPQo75sgoE1g
 QY9uX3nBod5vOMSgQeTTYJoLlEvsXA==
X-Google-Smtp-Source: AGHT+IFobmH4Nt+tXWx+F5tjXwdLJzEj63KTSICnP/WVHTTCxkDy9sW6aofnMo5V/+ntNmO9MrLtqw==
X-Received: by 2002:a05:6000:1f88:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-38f7085d549mr16012423f8f.49.1740651581154; 
 Thu, 27 Feb 2025 02:19:41 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm50980225e9.39.2025.02.27.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 02:19:39 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: am62: Use UCLASS_NOP for glue driver
In-Reply-To: <20250227081406.zkfylkznmlg65nll@uda0492258>
References: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
 <20250227081406.zkfylkznmlg65nll@uda0492258>
Date: Thu, 27 Feb 2025 11:19:37 +0100
Message-ID: <871pvj1yh2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Siddharth,

Thank you for the the review.

On jeu., f=C3=A9vr. 27, 2025 at 13:44, Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

> On Wed, Feb 26, 2025 at 03:47:11PM +0100, Mattijs Korpershoek wrote:
>
> Hello Mattijs,
>
>> The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
>> structure.
>> These glue drivers usually just implement the .glue_configure function.
>
> nitpick: Is there a reason behind an abrupt newline above? The sentence:
> "These glue drivers..." could continue on the same line as the previous
> sentence. Also, "These glue drivers..." is referring to glue drivers
> which haven't been mentioned yet and it is the first time that they are
> being referred to. It is not clear to me if there was more content in
> between the first sentence and the second which accidentally got
> removed.

I'll rephrase as:

"""
The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
structure. Glue drivers, which implement dwc3_glue_ops, usually just
define the .glue_configure() function.
"""

Does that looks good ?

>
>>=20
>> For such glue drivers, we don't need to be a SIMPLE_BUS, since we
>> don't interact with any child devices.
>
> This sounds confusing. What does "we" refer to? The dwc3-am62.c driver
> which is being modified in this patch is *the* glue driver itself.
> "For such glue drivers" and "we don't need to be a SIMPLE_BUS" seem to
> be referring to two different entities when they are probably the same.
>
> "For such glue drivers" =3D> dwc3-am62.c
> "we don't need to be a SIMPLE_BUS" =3D> Again dwc3-am62.c ?

I'll rephrase as:

"""
dwc3-am62 is such glue driver which does not need to be a SIMPLE_BUS
since it does not interact with any child device.
"""

Is that okay ?

>
> Did you mean something like the following?
> "Glue drivers don't need to be a SIMPLE_BUS since they don't interact
> with any child devices"

I can't write that down, because that's not true. Some glue drivers (like
dwc3-meson-g12a) need to be SIMPLE_BUS because they rely on
.child_pre_probe() and .child_post_remove().

>
>>=20
>> Use UCLASS_NOP instead as done in the dwc3-generic-wrapper.
>>=20
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> The change made in the driver seems good to me, so with the above
> questions addressed:
>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>
>> ---
>> This is a small cleanup intended for next.
>>=20
>> This has been tested on AM62X SK EVM using:
>> =3D> fastboot usb 0
>>=20
>> $ fastboot devices
>> ????????????     Android Fastboot
>> ---
>>  drivers/usb/dwc3/dwc3-am62.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>> index 99519602eb2c66299445163fafcdb3e065c89eda..66164d0a80c0264bfc400426=
782324f8a57b8bd8 100644
>> --- a/drivers/usb/dwc3/dwc3-am62.c
>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>> @@ -116,7 +116,7 @@ static const struct udevice_id dwc3_am62_match[] =3D=
 {
>>=20=20
>>  U_BOOT_DRIVER(dwc3_am62_wrapper) =3D {
>>  	.name	=3D "dwc3-am62",
>> -	.id	=3D UCLASS_SIMPLE_BUS,
>> +	.id	=3D UCLASS_NOP,
>>  	.of_match =3D dwc3_am62_match,
>>  	.bind =3D dwc3_glue_bind,
>>  	.probe =3D dwc3_glue_probe,
>
> Regards,
> Siddharth.
