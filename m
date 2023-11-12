Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AABC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E942F870F3;
	Sun, 12 Nov 2023 04:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bmnRmewj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8218709F; Sun, 12 Nov 2023 04:08:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85C6386FB8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9df8d0c2505so680748666b.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758529; x=1700363329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hjF27fwtfKI8igWPAJSIfERAtZ5XPTk6Ji0rvEgBIp4=;
 b=bmnRmewjdImmKhGGf3T+cHZ3Je7xdWDAROgij35KS2gjCb08QUtNW6b3p+1iTjmLvS
 NTjTkfNlF5pZP7bYKOhsoqLiCw+6YI3IOKUCFjn1cfrr6jmVL87QS+C2NRlSGS/QnjIb
 yW/qXj3znMKNSb/yCJHg4cbS9JYxBj+e2cKWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758529; x=1700363329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjF27fwtfKI8igWPAJSIfERAtZ5XPTk6Ji0rvEgBIp4=;
 b=jqWNRRp31dQl+5VwLCYRO6l23MxwrYoVm0htKEOpDrdD0Css2OqGawDblCqgzvK1lZ
 bqy356hbLUCkn3iLFUfqyMkZv2WBXF/8XD4iIaQYYfAlMiVrjLYpohUUvFECMHPJpdPg
 rnrXy4lybIwFbj7og41Ar/zUXZnN3Rpq6vJiCRh0sDDOcEKg4zr/Z9O7d1MxEXEAIGvZ
 0z/04ZgbaCvO61MsROrvQN8UrsAudvGWxDEbrVgxPcfEkxLdSw9lXsCAxY7KOtu6c3k5
 WkSnlkmU9ZUc7+lBaKWmk+AytYi2x7M0/fEcorXy/EtEc+5Yl1Tri04I20E80gYK6L3Y
 Dl+g==
X-Gm-Message-State: AOJu0YyYtk+6JdSzySQswYFzcAcSehNJy10Pf1k3PC8+87mpS0e9xtAK
 7kMSTjFcS/ouWkiy6niOpmbNfx8c/1GpjnjxWNAppA==
X-Google-Smtp-Source: AGHT+IG+5DUHxAUxdNzI/foBmZ59EUPyE3gcj/+oDmiHRiYYkqzkqm6rwj9gRKc+S604m3Y45k16edu1FsgiE5ESKMI=
X-Received: by 2002:a17:907:9809:b0:9dd:b919:79bf with SMTP id
 ji9-20020a170907980900b009ddb91979bfmr7775799ejc.36.1699758528976; Sat, 11
 Nov 2023 19:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107160900.2652813-1-andre.przywara@arm.com>
 <CAPnjgZ1_KVcGvh869p3jvBh6umkwGv_VwFs73Yo3k9BBM54p0w@mail.gmail.com>
 <20231110141614.72b6dffd@donnerap.manchester.arm.com>
In-Reply-To: <20231110141614.72b6dffd@donnerap.manchester.arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:36 -0700
Message-ID: <CAPnjgZ3PKoi2z6iBCr1f0DJMbS_usp1fedwaCzwCjqd02O_87Q@mail.gmail.com>
Subject: Re: [PATCH] virtio: rng: gracefully handle 0 byte returns
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de, 
 Peter Hoyes <peter.hoyes@arm.com>
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

Hi Andre,

On Fri, 10 Nov 2023 at 07:16, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Fri, 10 Nov 2023 05:53:59 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> > On Tue, 7 Nov 2023 at 09:09, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > According to the virtio v1.x "entropy device" specification, a virtio-rng
> > > device is supposed to always return at least one byte of entropy.
> > > However the virtio v0.9 spec does not mention such a requirement.
> > >
> > > The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng always
> > > returns 8 bytes less of entropy than requested. If 8 bytes or less are
> > > requested, it will return 0 bytes.
> > > This behaviour makes U-Boot's virtio_rng_read() implementation go into an
> > > endless loop, hanging the system.
> > >
> > > Work around this problem by always requesting 8 bytes more than needed,
> > > but only if a previous call to virtqueue_get_buf() returned 0 bytes.
> > >
> > > This should never trigger on a v1.x spec compliant implementation, but
> > > fixes the hang on the Arm FVP.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > Reported-by: Peter Hoyes <peter.hoyes@arm.com>
> > > ---
> > >  drivers/virtio/virtio_rng.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > Unrelated to this patch, but do you know the hardware architecture of
> > the ARM RNG? Is there one RNG unit per CPU or one for the whole SoC?
>
> Architecturally and from a software perspective the ARMv8.5 FEAT_RNG
> feature is a system register, so per-core. Theoretically the availability
> could differ between cores, but the CPU ID feature registers are also
> per-core, so as long as we run on a single core, or always at least
> read from the same core, it's all good.
>
> Now the architecture only describes the CPU instruction aspect of the
> feature, and establishes rules for the quality and spec conformance, but
> leaves the actual source of the entropy open to the integrator.
>
> The manual in the Neoverse V1 core[1] (still not a SoC!) states that the
> actual entropy source is a memory mapped peripheral, its address being
> held in an internal, per-core register. So you can have one shared entropy
> source per SoC, or a private instance for each core, that's up to the
> actual integrator to design.
>
> From the software perspective this shouldn't matter, though: the feature
> is "per-core", how this is backed is an implementation detail.

Would it make sense to model this as a memory-mapped peripheral under
/soc (perhaps one without an address?)


>
> Cheers,
> Andre
>
> [1]
> https://developer.arm.com/documentation/101427/0102/Functional-description/Random-number-support/About-the-random-number-support
>
>
> > > diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
> > > index b85545c2ee5..786359a6e36 100644
> > > --- a/drivers/virtio/virtio_rng.c
> > > +++ b/drivers/virtio/virtio_rng.c
> > > @@ -20,7 +20,7 @@ struct virtio_rng_priv {
> > >  static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
> > >  {
> > >         int ret;
> > > -       unsigned int rsize;
> > > +       unsigned int rsize = 1;
> > >         unsigned char buf[BUFFER_SIZE] __aligned(4);
> > >         unsigned char *ptr = data;
> > >         struct virtio_sg sg;
> > > @@ -29,7 +29,12 @@ static int virtio_rng_read(struct udevice *dev, void *data, size_t len)
> > >
> > >         while (len) {
> > >                 sg.addr = buf;
> > > -               sg.length = min(len, sizeof(buf));
> > > +               /*
> > > +                * Work around implementations which always return 8 bytes
> > > +                * less than requested, down to 0 bytes, which would
> > > +                * cause an endless loop otherwise.
> > > +                */
> > > +               sg.length = min(rsize ? len : len + 8, sizeof(buf));
> > >                 sgs[0] = &sg;
> > >
> > >                 ret = virtqueue_add(priv->rng_vq, sgs, 0, 1);
> > > --
> > > 2.25.1

Regards,
Simon
