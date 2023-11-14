Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B69C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42E9786EFA;
	Tue, 14 Nov 2023 13:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwO3H6iM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3269887266; Tue, 14 Nov 2023 13:11:18 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C190A86758
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1efad296d42so3286457fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699963874; x=1700568674; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OPksgcp2BjltBnVuZVV3+VWvRMsFnGz6V21E3ljhTDM=;
 b=EwO3H6iMMnsjh13+Crx2HVsgnGHiC7gTSEohtL26aOviCLrp5NqRcsasbpLKTeSJ/j
 HlV4e0svpddPR/Uydw1DyL9ysHw87xIYFSncYFfEu+psC4Tk940RaSDG+0aTc4Vot4X0
 0mPK0CbuvgwcfcaiWRv39/OSngONlvyeqU8HGkgz1SUL8tnLYYe2yh9eqQS7LZtK5FVe
 UmoBQA9dY2WLigksEzBjDFZpcvrzPbAI4Fe0eLaP6maR+X2hGdK+q26im6jHsrgFswPV
 DOWZB/C/y5eTf1RIG39Z3S5OjeJm/9mgLmijypbdcDc23cCSH0ZW5BNfLYRAe+VPveM4
 jOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699963874; x=1700568674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPksgcp2BjltBnVuZVV3+VWvRMsFnGz6V21E3ljhTDM=;
 b=CZUmtFYFv0Xkz28IeLJFeJ+sAAEIvLjHtGgbYI4VbaGOhSaArjBt/1N7B+VYRguQts
 2wSW5oIL9RpTG+2yM1WTkRcwVVXdyQGJSjPXpcS+qApAtnY9ptq2e2kITGwZYGUpE5O4
 GYCaALnmV8ORwoRM2JfSdZ3Ndmq4ptseEjK6DF7BmVRd5CCP0ryzuEKzzQ568/wTeoMp
 BzA40QJ0vhFfMKOdjWkYubvzxb8rcuQUUG4YDnAz/YyeHNvdJUUOa3dr8Tku9v1ok8//
 gVCqWTHNu4Y/HbvAdhTK+Bj+y+v7ukg31rW/Cy/RNqso69JuL36vIRDIhIzS/I+0Uzz6
 ulcg==
X-Gm-Message-State: AOJu0Yz99T9ciJldk+NavdDhnXv5Sk8ubPuSMXAVqpnvXNcbw2cZ2g/n
 /d7Zay6ZLiphECRMAvN7v1fRk8h6fSj2zwjU4i8=
X-Google-Smtp-Source: AGHT+IGfJWWng412HuoBGJZJ5QYDkts5eZz0u/N+3xyCFFH8SXv6hnvD724NqpFJMmqLaSiveFiS7pJDmnqSPEkLkG8=
X-Received: by 2002:a05:6870:a54d:b0:1ea:b1c:b859 with SMTP id
 p13-20020a056870a54d00b001ea0b1cb859mr11909815oal.35.1699963874360; Tue, 14
 Nov 2023 04:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
 <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
 <ebe2784d-23c6-470d-a25f-8261fcf820ca@denx.de>
In-Reply-To: <ebe2784d-23c6-470d-a25f-8261fcf820ca@denx.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 14 Nov 2023 13:11:03 +0100
Message-ID: <CAH9NwWfEPeXhmxM6MMmVfS3XJoTT3Qod8-Z3rsuUzyOGwO5-eg@mail.gmail.com>
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
To: Marek Vasut <marex@denx.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Tom Rini <trini@konsulko.com>, pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

ping

Am Mo., 23. Okt. 2023 um 12:45 Uhr schrieb Marek Vasut <marex@denx.de>:
>
> On 10/23/23 10:51, Rasmus Villemoes wrote:
> > On 19/10/2023 15.54, Marek Vasut wrote:
> >> On 10/19/23 11:58, Rasmus Villemoes wrote:
> >>> If the driver's own .bind method has populated uc_plat->label, don't
> >>> override that. This is necessary for an upcoming driver for ti,lp5562,
> >>> where the DT binding unfortunately says to use "chan-name" and not
> >>> "label".
> >>>
> >>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >>> ---
> >>>    drivers/led/led-uclass.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> >>> index 5a5d07b9a7..0232fa84de 100644
> >>> --- a/drivers/led/led-uclass.c
> >>> +++ b/drivers/led/led-uclass.c
> >>> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
> >>>        struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> >>>        const char *default_state;
> >>>    -    uc_plat->label = dev_read_string(dev, "label");
> >>> +    if (!uc_plat->label)
> >>> +        uc_plat->label = dev_read_string(dev, "label");
> >>> +
> >>
> >> One thing I have to wonder about is, why does this controller have label
> >> property in the top-level node , what is that used for ?
> >>
> >> (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)
> >>
> >> Reviewed-by: Marek Vasut <marex@denx.de>
> >
> > Reading the linux driver, it seems that the top-level label, if any, is
> > used as part of the naming for individual channels if they don't have
> > individual chan-name properties:
> >
> >
> >          if (pdata->led_config[chan].name) {
> >                  led->cdev.name = pdata->led_config[chan].name;
> >          } else {
> >                  snprintf(name, sizeof(name), "%s:channel%d",
> >                          pdata->label ? : chip->cl->name, chan);
> >                  led->cdev.name = name;
> >          }
> >
> > but I think the rationale in d1188adb2dabc is a bit weak, since the only
> > example also does have individual chan-name properties.
> >
> > [Complete aside: At first I thought it was related to the multi-color
> > LED work that has been ongoing for many many years (I think there was an
> > LWN article at some point), where this could be exposed as a single
> > multi-color LED, as opposed to the "traditional" three/four individual
> > LEDs. In the former case, there would only be one sysfs entry, but with
> > attributes exposing the multicolor functionality. I must admit I don't
> > know the status of that work, when something reaches v31,
> > http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/t/ ,
> > it's hard to know if it ever lands, or if pieces of it has landed.]
>
> +CC Pavel



-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
