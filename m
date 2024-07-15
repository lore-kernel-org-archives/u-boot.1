Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8985FC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D36DD87EFA;
	Mon, 15 Jul 2024 21:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UWelz1EJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC6288765; Mon, 15 Jul 2024 21:32:28 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7FF87FC8
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e03a8955ae3so4504466276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721071944; x=1721676744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXyM9UbXo74jj9MWJKM0C2UdGHUwNDLif4l72/ZDTHI=;
 b=UWelz1EJqj7+wKaP/jkKCQbAqspb+MCm9fP55wmtIUo9vIfbLg0JGI0SosnnHRugYD
 lMtjswZz2GOa0oEG5WVKI0jDDXfsxPAjW1UYq8kA5gotG9OJV7MA/bTKnqeqmCx3KdkV
 SOZJXlX8CUlJ9TLiMFUTDkoEqVkqSvynslrAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721071944; x=1721676744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXyM9UbXo74jj9MWJKM0C2UdGHUwNDLif4l72/ZDTHI=;
 b=OT/0RaSNSBrBAqZBmPtK+sEIs8Wa89uFjW6oE8AYZlkMpMyj3JTypIk5DzuZEySVIK
 S0yLZFiIOFY+1btCz2BypyAoW1CTfKDK8gZZijfu5G9mAXXOJy4weN0/FcCjlw+iyNR0
 vdBx7d2SvpwCfd5eQn20im2EcEFxvrrah1tc2jYstVfvkXG6De0Zfubin1Ny4GLe3h/Y
 OK22/WEOOGXObkfsPmY5Lx4DKOEwj3SutlohEyQPOta/pA7fnFmDKDrF6p71vLicqejv
 YVlG9bCtthe4Qt1ZDryFs9ab5AKbfw3unD4ySFlMyQX92k9xGS5T343ZAPUhhualRtmm
 6ExA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+zJ3vpLTHB/iYQJxyVWPFxgAYNNPsO1oBFnIOGGboTOFQjo6QbEpaTv3tOXDybzC1tGv4eBosYfqyk94NYYAcivGIdA==
X-Gm-Message-State: AOJu0YyJcf5GGbVFAU7hRQTvaflXbR4NgAKBOmNod2mUHhVbvGQPICd9
 tKZ+BYEUB/RR9xr2Sn3sdbClzbrpZT8ujawmu67VZdZxuKhyYhEeAHehPXdBX/0ZkhTIAyaY4QC
 ZxkPbs/sY2BrtvEWX0GIHT1ehuPSxInQMhqTn
X-Google-Smtp-Source: AGHT+IGNsdg7Skq9OitIzPl1asSKtyt6MERHAmp2EQB7RbG/h+7YDfzf3RRMPZyUMevdxCl7iq+ET0mpawDHOsT4mW0=
X-Received: by 2002:a05:6902:2706:b0:e03:af3d:d4d6 with SMTP id
 3f1490d57ef6-e05d57ea7d1mr122432276.42.1721071944072; Mon, 15 Jul 2024
 12:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThBPaojbFHZf_OpJz=Ub+ikcMZeoa11GeJ422HNPa-s9A@mail.gmail.com>
 <654fbb9b-dcea-4c07-85a1-47e48d3057d0@genexis.eu>
 <CAFLszTgzgMuB70YRnFUuKvdn9UH3K9ifrSDThDbioQAoaeMMmA@mail.gmail.com>
 <be9e5850-098a-4856-a421-5a4b8cf06c2e@genexis.eu>
In-Reply-To: <be9e5850-098a-4856-a421-5a4b8cf06c2e@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 20:32:13 +0100
Message-ID: <CAFLszTieo9-LuRRSkEC9E5vD8wGSvSCdOLL6g8rCdtp3R9N2Yw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] led: Add dts property to specify blinking of the
 led
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
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

On Mon, 15 Jul 2024 at 14:23, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
>
> On 7/15/24 11:11, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Sat, 13 Jul 2024 at 17:32, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@genexis.eu> wrote:
> >>
> >> On 13.07.2024 18:13, Simon Glass wrote:
> >>> Hi Mikhail,
> >>>
> >>> On Fri, 12 Jul 2024 at 06:25, Mikhail Kshevetskiy
> >>> <mikhail.kshevetskiy@iopsys.eu> wrote:
> >>>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> >>>>
> >>>> The standard property
> >>>>
> >>>>     linux,default-trigger =3D "pattern";
> >>>>
> >>>> used to get an effect. No blinking parameters can be set yet.
> >>>>
> >>>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> >>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >>>> ---
> >>>>  drivers/led/led-uclass.c | 33 +++++++++++++++++++++++++++++----
> >>>>  1 file changed, 29 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> >>>> index 4f5dd66765e..90047ad35ba 100644
> >>>> --- a/drivers/led/led-uclass.c
> >>>> +++ b/drivers/led/led-uclass.c
> >>>> @@ -100,6 +100,9 @@ static int led_post_bind(struct udevice *dev)
> >>>>  {
> >>>>         struct led_uc_plat *uc_plat =3D dev_get_uclass_plat(dev);
> >>>>         const char *default_state;
> >>>> +#ifdef CONFIG_LED_BLINK
> >>>> +       const char *trigger;
> >>>> +#endif
> >>>>
> >>>>         if (!uc_plat->label)
> >>>>                 uc_plat->label =3D dev_read_string(dev, "label");
> >>>> @@ -120,6 +123,12 @@ static int led_post_bind(struct udevice *dev)
> >>>>         else
> >>>>                 return 0;
> >>>>
> >>>> +#ifdef CONFIG_LED_BLINK
> >>>> +       trigger =3D dev_read_string(dev, "linux,default-trigger");
> >>>> +       if (trigger && !strncmp(trigger, "pattern", 7))
> >>>> +               uc_plat->default_state =3D LEDST_BLINK;
> >>>> +#endif
> >>> I still wonder whether you can use IS_ENABLED() instead of adding #if=
defs?
> >> LEDST_BLINK depends on CONFIG_LED_BLINK, so the code will not compile =
if CONFIG_LED_BLINK is not defined.
> >> Defining a LEDST_BLINK unconditionally will produce an issue with cmd/=
led.c
> > We should not use #ifdefs around such declarations. What issue is
> > caused by defining it always?
>
> We need to patch cmd/led.c. Without it we will get:
> * something like out of boundary access
> * enumeration value =E2=80=98LEDST_BLINK=E2=80=99 not handled in switch
>
> can be fixed, but probably it should be a separate patch

Sounds good

Reviewed-by: Simon Glass <sjg@chromium.org>
