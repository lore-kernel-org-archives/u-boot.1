Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB2CC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600E98777D;
	Wed, 10 Jan 2024 16:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vwfgbw27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B2487A7F; Wed, 10 Jan 2024 16:53:38 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CD787776
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5576fae29ffso4391609a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704902016; x=1705506816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gQ8g6W8U7kuWXjpkIjq05QuCmlkQekLOn7/ySKRejKg=;
 b=Vwfgbw27rSAUc9Z+bqYgQWM5BWQZWy+U+Og9hIkLFKpikUx58qSTXaa1lHJgLPRkzq
 NMFOsfOpZeCwQmtkt4z4QNfWtCdYixxdin8gjtEvJOdFsa6/gGjntUXO8birise2gdVo
 1+gLPLbPhUws0kommqO3rBQTU4eYXhAyDqUUHH7n5MDcD6iNBefb9EAGOfeMtDPypOks
 nT5N3qILJbp6+he1taTIr3Satgo5OeW4kTKj3WkOOXF5Uc2aCwz4xVP6l1ngZaHPxN+I
 J9VxHDvNFPNAco4bA0db+xZueQo5ZUq0Jcm2AfxuZwUB1llO380u35UjkURfeCYP6YSh
 z6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704902016; x=1705506816;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gQ8g6W8U7kuWXjpkIjq05QuCmlkQekLOn7/ySKRejKg=;
 b=xL1Tajp/bLWljG6N5LKcXbTPTHPCxH80o5TuYNlfl8VoYWhmmuHn5AOCsbEaxFcXUl
 vQ2efizK00/zK96/PIKmWQnTpO9Xbe4CPLOHwtk+2rTN5gqJeZ28T1MOFi/nRdzYm5L5
 jc9zgtL92H/yc6/PRCpTHzBIoFjMqxGynDLSGK0FMHL/lpiq2GamEuMGCp0NEPUQSi9t
 +o1I/lkN6Ex6gZ6LGKA9ib+AwAYK6+lnsyNqd7ody4E1X6C7/K8G/xmendwiz5Ms1+z6
 vC9ehFXPjQ0QZXcmzci53sfefJHYGRynPklyB1+4l6MX7et6Rr32zzXBRUG6LxNGkGbC
 GvHQ==
X-Gm-Message-State: AOJu0YwNijSJr1gnIKtnfFznCmcDEJ2jE+SUvySlWl057DrlLK422jzb
 41sLlHW1hdQpKpBPvWBk5Ss=
X-Google-Smtp-Source: AGHT+IHV31Ic1FLodbRvRUBEl6/SbobZ5JfJfZgUVuq+1/O8LCOWdT0Nj5Qk2ZnUgoGSNGHdajLLgA==
X-Received: by 2002:a50:cd10:0:b0:558:1540:d33a with SMTP id
 z16-20020a50cd10000000b005581540d33amr582238edi.17.1704902015864; 
 Wed, 10 Jan 2024 07:53:35 -0800 (PST)
Received: from [127.0.0.1] ([46.211.245.15]) by smtp.gmail.com with ESMTPSA id
 s7-20020a056402014700b005576f4471besm2107760edu.42.2024.01.10.07.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:53:35 -0800 (PST)
Date: Wed, 10 Jan 2024 17:53:34 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Sean Anderson <seanga2@gmail.com>
CC: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
User-Agent: K-9 Mail for Android
In-Reply-To: <06ffe2bc-072a-010f-313a-80865269adcc@gmail.com>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <06ffe2bc-072a-010f-313a-80865269adcc@gmail.com>
Message-ID: <348C74B3-355E-4B73-BF5A-4A7E64311779@gmail.com>
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



10 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 17:45:57 GMT+02:0=
0, Sean Anderson <seanga2@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>On 12/16/23 10:37, Sean Anderson wrote:
>> On 12/16/23 03:48, Svyatoslav Ryhel wrote:
>>> Existing gpio-gate-clock driver acts like a simple GPIO switch without=
 any
>>> effect on gated clock=2E Add actual clock actions into enable/disable =
ops and
>>> implement get_rate op by passing gated clock if it is enabled=2E
>>>=20
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>>> ---
>>> =C2=A0 drivers/clk/clk-gpio=2Ec | 44 +++++++++++++++++++++++++++++++++=
+--------
>>> =C2=A0 1 file changed, 36 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/drivers/clk/clk-gpio=2Ec b/drivers/clk/clk-gpio=2Ec
>>> index 26d795b978=2E=2E72d9747a47 100644
>>> --- a/drivers/clk/clk-gpio=2Ec
>>> +++ b/drivers/clk/clk-gpio=2Ec
>>> @@ -3,19 +3,23 @@
>>> =C2=A0=C2=A0 * Copyright (C) 2023 Marek Vasut <marek=2Evasut+renesas@m=
ailbox=2Eorg>
>>> =C2=A0=C2=A0 */
>>> -#include <asm/gpio=2Eh>
>>> -#include <common=2Eh>
>>> -#include <clk-uclass=2Eh>
>>> +#include <clk=2Eh>
>>> =C2=A0 #include <dm=2Eh>
>>> +#include <clk-uclass=2Eh>
>>> +#include <linux/clk-provider=2Eh>
>>> +
>>> +#include <asm/gpio=2Eh>
>>> =C2=A0 struct clk_gpio_priv {
>>> -=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=A0=C2=A0 enable;
>>> +=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=A0=C2=A0 enable;=C2=A0=
=C2=A0=C2=A0 /* GPIO, controlling the gate */
>>> +=C2=A0=C2=A0=C2=A0 struct clk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *clk;=C2=A0=C2=A0=C2=A0 /* Gated clock */
>>> =C2=A0 };
>>> =C2=A0 static int clk_gpio_enable(struct clk *clk)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_gpio_priv *priv =3D dev_get_=
priv(clk->dev);
>>> +=C2=A0=C2=A0=C2=A0 clk_enable(priv->clk);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dm_gpio_set_value(&priv->enable, 1);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> @@ -26,21 +30,45 @@ static int clk_gpio_disable(struct clk *clk)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_gpio_priv *priv =3D dev_get_=
priv(clk->dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dm_gpio_set_value(&priv->enable, 0);
>>> +=C2=A0=C2=A0=C2=A0 clk_disable(priv->clk);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> +static ulong clk_gpio_get_rate(struct clk *clk)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct clk_gpio_priv *priv =3D dev_get_priv(clk->d=
ev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return clk_get_rate(priv->clk);
>>> +}
>>> +
>>> =C2=A0 const struct clk_ops clk_gpio_ops =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eenable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D clk_gpio_enable,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Edisable=C2=A0=C2=A0=C2=A0 =3D clk_gp=
io_disable,
>>> +=C2=A0=C2=A0=C2=A0 =2Eget_rate=C2=A0=C2=A0=C2=A0 =3D clk_gpio_get_rat=
e,
>>> =C2=A0 };
>>> -static int clk_gpio_probe(struct udevice *dev)
>>> +static int clk_gpio_of_to_plat(struct udevice *dev)
>
>Same comment as the first time:
>
>Why the conversion from probe to of_to_plat?
>

Same answer as the first time=2E You propose to spam commits for this smal=
l adjustment?

>--Sean
>
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_gpio_priv *priv =3D dev_get_=
priv(dev);
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> -=C2=A0=C2=A0=C2=A0 return gpio_request_by_name(dev, "enable-gpios", 0=
,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &priv->enable, GPIOD_IS_OUT);
>>> +=C2=A0=C2=A0=C2=A0 priv->clk =3D devm_clk_get(dev, NULL);
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(priv->clk)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_debug("%s: Could not g=
et gated clock: %ld\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 __func__, PTR_ERR(priv->clk));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(priv->clk);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 ret =3D gpio_request_by_name(dev, "enable-gpios", =
0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &priv->enable, GPIOD_IS_OUT);
>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_debug("%s: Could not d=
ecode enable-gpios (%d)\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 __func__, ret);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 /*
>>> @@ -59,7 +87,7 @@ U_BOOT_DRIVER(gpio_gate_clock) =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Ename=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D "gpio_clock",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D UCLASS_CLK,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eof_match=C2=A0=C2=A0=C2=A0 =3D clk_g=
pio_match,
>>> -=C2=A0=C2=A0=C2=A0 =2Eprobe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =3D clk_gpio_probe,
>>> +=C2=A0=C2=A0=C2=A0 =2Eof_to_plat=C2=A0=C2=A0=C2=A0 =3D clk_gpio_of_to=
_plat,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Epriv_auto=C2=A0=C2=A0=C2=A0 =3D size=
of(struct clk_gpio_priv),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eops=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D &clk_gpio_ops,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =2Eflags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D DM_FLAG_PRE_RELOC,
>>=20
>> +CC Marek
>
