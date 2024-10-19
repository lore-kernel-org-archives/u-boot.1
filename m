Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65498D3C906
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB63B89242;
	Sat, 19 Oct 2024 13:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GDxLMz09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C838C89242; Sat, 19 Oct 2024 13:51:11 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5805D89034
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbc28f8e1bso21664726d6.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338668; x=1729943468; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pUjRzWMwyaGZHezQkWe3LRLlFd2fQ9zp2aDDjHl+KTg=;
 b=GDxLMz097X9VOAgg6bs71jOmvlJm98ax7MrOoiPBguqRfukod3TmhnWsuo0+vP+VyG
 N6UppxzIuCpmd03ABfkEWUm7lO+dbR9wFtKxYYE2jNxE0RumPhEvfAqGdfCkzBhqgjHG
 f1ETZv9l9kTMUjP+DclQXWhw8HwNPxk5KUTGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338668; x=1729943468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUjRzWMwyaGZHezQkWe3LRLlFd2fQ9zp2aDDjHl+KTg=;
 b=HOJo2T6x6+cxvvo/7VaNNOe9KVO25jJAZHI0rQgts/WPjfwJouHovCtoODqp80Xyzq
 mxsivqe0Iw7sF1W/6X+p6i3t69ltaZGU7RK769vmQ0GNN1baMTLgezer6e8VB2guk9ue
 4781oSGUQAFrsl4R4P7FCwQe6PKSNmdqSQJmm4/hyeApN8jvPU1z1Fq8rrtBEZPDFNPL
 3UHdlMtn/qfAf9MJt4dw1AYmlfmFiaRYKkJwxetSLt5fF0J+JwYhU4KICVrDRJuCFBtE
 EhFGfY2cym/I2do4wbFmIHDNhI0PdGlpXNt9yFzkzCvpApeWhVMsYTQ/xNxXclMzCUcU
 97qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE+Ersa/+K3aduEMhsJaCHt0gJygddZ8zFWy4hz7/cMGvROzDvZF/KVTg16LIXNjOZt7hEaqo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7UrGSEYyQCqxC0ezwVTsA5ugGczHkYZVGashIyGdOQgSN+Dib
 2uZ9g8uS1sCrHvHRXYP3FfcMrOX9VFYDwh68/mT+dVvH9xY8+m1rUTiwR/yVnBOempmuIu76HJt
 QjnyE6ubogMoE2zuiTZZfQFcHnqJcgd+M/WPH
X-Google-Smtp-Source: AGHT+IE9YpPOilT9QhO1jFzZkGORNo2c4HgQJ59AcAb98kEiCY+BLlY7O1T/l7ZsMg3uNOnJrMnd2kjI4jzmHU++JNk=
X-Received: by 2002:a05:6214:4808:b0:6cb:e9da:bd6 with SMTP id
 6a1803df08f44-6cde15d01famr77959076d6.35.1729338668259; Sat, 19 Oct 2024
 04:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-2-heinrich.schuchardt@canonical.com>
 <4aef209c-cbed-4fac-b48a-4101e27e64f8@gmail.com>
In-Reply-To: <4aef209c-cbed-4fac-b48a-4101e27e64f8@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:50:57 -0600
Message-ID: <CAFLszTgt_5rpKg2XUW_h5_AU5zYssiO7cLtTEaz8w0_Q8zVh4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] rockchip: block: simplify rkmtd driver
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

Hi Johan,

On Fri, 18 Oct 2024 at 07:33, Johan Jonker <jbx6244@gmail.com> wrote:
>
>
>
> On 10/18/24 03:30, Heinrich Schuchardt wrote:
> > By using blk_create_devicef() instead of blk_create_devicef() the driver
> > can be simplified and brought into line with other block device drivers.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  drivers/block/rkmtd.c | 21 ++-------------------
> >  1 file changed, 2 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/block/rkmtd.c b/drivers/block/rkmtd.c
> > index c55f052e51b..f84cacd7ead 100644
> > --- a/drivers/block/rkmtd.c
> > +++ b/drivers/block/rkmtd.c
> > @@ -794,36 +794,19 @@ int rkmtd_init_plat(struct udevice *dev)
> >       return 0;
> >  }
> >
> > -static void rkmtd_blk_kmalloc_release(struct udevice *dev, void *res)
> > -{
> > -     /* noop */
> > -}
> > -
> >  static int rkmtd_bind(struct udevice *dev)
> >  {
> >       struct rkmtd_dev *plat = dev_get_plat(dev);
> > -     char dev_name[30], *str;
> >       struct blk_desc *desc;
> >       struct udevice *bdev;
> >       int ret;
> >
> > -     snprintf(dev_name, sizeof(dev_name), "%s.%s", dev->name, "blk");
> > -
>
> > -     str = devres_alloc(rkmtd_blk_kmalloc_release, strlen(dev_name) + 1, GFP_KERNEL);
>
> Hi Heinrich, Simon,
>
> The function strdup() is not an exact replacement for the devres_alloc() function in relation to a device.
> It is in use for memory leak detection / device resource management.
> Not sure what the status of that devres project currently is? Also tracking in general in relation to EFI and blk-class.
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blk-uclass.c?ref_type=heads#L739
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L812
>
> Test for this driver are based on work done by Simon.
> https://source.denx.de/u-boot/u-boot/-/blob/master/test/dm/host.c?ref_type=heads#L71
>
> This rkmtd driver makes use of devm_kzalloc(). All the memory that rkmtd reserves is freed.
> But if I remember well somehow I was not able to free all memory on unbind and was not able to find the source, so I didn't include that last test.
> https://elixir.bootlin.com/u-boot/v2024.10/source/test/dm/rkmtd.c#L84

Yes, you can use that API. But I think Heinrich's patch is correct,
and separate from your points here. Yes, blk_create_devicef()
strdup()s the name, but it sets a flag indicating that it has done so.
Then device_unbind() checks DM_FLAG_NAME_ALLOCED later. So the code
should be equivalent.

Re the memory leak, I don't have any ideas, but test/dm/devres.c does
have some checks for some of that. I have often wondered about having
a way to store the filename and line (or just the line?) with every
allocation, so we can list out what is left at the end, since valgrind
doesn't work on target devices.

Regards,
Simon
