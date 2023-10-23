Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E89CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 10:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D958787D;
	Mon, 23 Oct 2023 12:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Icb54+TK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F898787D; Mon, 23 Oct 2023 12:44:06 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22301878D4
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 12:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ce31c4a653so2027183a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698057842; x=1698662642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6iokNPiVstSomkLNF6F2gcxW/EaWIfNriJBp4LwIMdE=;
 b=Icb54+TKbVez3YdMRSreUYrDS8+rUaKZJUjLNwpmQQFXjR9RxgW9WTJ1MHQgjRtPjd
 5rxRndkT53cg/G+hs7iCIa0Ow/s3m/OiVKenMT5706OJHoC7ikpcUimYRDvgwNkgMiDu
 h48EREEnwAkS6/NiT0fzdNSIjZzrtoz4khxdeb1E47Qv/zueSAw7SIuadNLKYNRJ7m3d
 DVEmGpXsTMYgMRuQ+CDSo+eHLJVImaAwGLV1BTZALGr9V0fX3fTS0diB8rwsqGrhrcqn
 NrccTl1E/xHjtS6vMpk7TbSqzkicxunRt7ZOVvWaep5rhwjKfqtQ3m3+SIfmThOFCr8U
 bWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698057842; x=1698662642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iokNPiVstSomkLNF6F2gcxW/EaWIfNriJBp4LwIMdE=;
 b=QCRZALxHVwC6g1pX/8O+TrAFbBUTtau8IGr/K801SDCwfn7lhPTiJyzoqiVmfJqYTG
 jZHiht3EUwgjoLFd2QeQ5QyoTK194O1+iLIybtZjux19H3PQx1iRPO52LRwJbgcg7giN
 CE8of2p8nVs3aUWkWdl+sKkwu2DzB3ira4aLeBI88LUF2nNugsUzN6IebQ9B8I9bGibk
 9ym4NBwnRqZk6xDwJq2y9AoJsjmpyxplUpFe5CRkXCBhJPN7ek7z/cdSNy6gywmcr7L9
 IXBv+okniSvHZnPSP3cNReQhWFQrPog//34RuwjViYa8C486elVl9omQlTcCVm3BhwEC
 ri6A==
X-Gm-Message-State: AOJu0YzEomKvbV/IH+hTicdhmY8/LuO6yGnM32WwIFoOXReP529boMcW
 YC9GU0Vt8Dl+FNtzwpNbeI0ZZAFs+S03+OW4Y+k=
X-Google-Smtp-Source: AGHT+IHdlDlhAJMyt/6OGObEtXivFud7dpOTARUCz2ETGOL0rsiri6WQ4zLpAvIQXfWVemhkBPAgsH237t9dFDLY764=
X-Received: by 2002:a05:6871:a302:b0:1d5:21cd:7069 with SMTP id
 vx2-20020a056871a30200b001d521cd7069mr10484826oab.8.1698057842446; Mon, 23
 Oct 2023 03:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-3-rasmus.villemoes@prevas.dk>
 <d4389465-e5bd-492b-8f86-7b4a93ff6016@denx.de>
 <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
In-Reply-To: <7d38b732-e5f4-4e6a-9a5d-7837e285ba55@prevas.dk>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 23 Oct 2023 12:43:51 +0200
Message-ID: <CAH9NwWdiVdbX+4FcA6M_ma_rOZDyE_=c_QNN-uxT7xE8jYCepA@mail.gmail.com>
Subject: Re: [PATCH 2/6] led-uclass: honour ->label field populated by
 driver's own .bind
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
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

Am Mo., 23. Okt. 2023 um 11:30 Uhr schrieb Rasmus Villemoes
<rasmus.villemoes@prevas.dk>:
>
> On 19/10/2023 15.54, Marek Vasut wrote:
> > On 10/19/23 11:58, Rasmus Villemoes wrote:
> >> If the driver's own .bind method has populated uc_plat->label, don't
> >> override that. This is necessary for an upcoming driver for ti,lp5562,
> >> where the DT binding unfortunately says to use "chan-name" and not
> >> "label".
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >> ---
> >>   drivers/led/led-uclass.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
> >> index 5a5d07b9a7..0232fa84de 100644
> >> --- a/drivers/led/led-uclass.c
> >> +++ b/drivers/led/led-uclass.c
> >> @@ -71,7 +71,9 @@ static int led_post_bind(struct udevice *dev)
> >>       struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> >>       const char *default_state;
> >>   -    uc_plat->label = dev_read_string(dev, "label");
> >> +    if (!uc_plat->label)
> >> +        uc_plat->label = dev_read_string(dev, "label");
> >> +
> >
> > One thing I have to wonder about is, why does this controller have label
> > property in the top-level node , what is that used for ?
> >
> > (see Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml)
> >
> > Reviewed-by: Marek Vasut <marex@denx.de>
>
> Reading the linux driver, it seems that the top-level label, if any, is
> used as part of the naming for individual channels if they don't have
> individual chan-name properties:
>
>
>         if (pdata->led_config[chan].name) {
>                 led->cdev.name = pdata->led_config[chan].name;
>         } else {
>                 snprintf(name, sizeof(name), "%s:channel%d",
>                         pdata->label ? : chip->cl->name, chan);
>                 led->cdev.name = name;
>         }
>
> but I think the rationale in d1188adb2dabc is a bit weak, since the only
> example also does have individual chan-name properties.
>
> [Complete aside: At first I thought it was related to the multi-color
> LED work that has been ongoing for many many years (I think there was an
> LWN article at some point), where this could be exposed as a single
> multi-color LED, as opposed to the "traditional" three/four individual
> LEDs. In the former case, there would only be one sysfs entry, but with
> attributes exposing the multicolor functionality. I must admit I don't
> know the status of that work, when something reaches v31,
> http://archive.lwn.net:8080/linux-kernel/20200722071055.GA8984@amd/t/ ,
> it's hard to know if it ever lands, or if pieces of it has landed.]
>
> Rasmus
>

I have an almost similar patch sent out today as I have not seen yours
before. The end results
is the same as mine
https://patchwork.ozlabs.org/project/uboot/patch/20231023082117.39290-1-christian.gmeiner@gmail.com/

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
