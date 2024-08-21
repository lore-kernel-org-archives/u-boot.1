Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A80C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403B888DBA;
	Wed, 21 Aug 2024 16:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zyq45z9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF0788DB7; Wed, 21 Aug 2024 16:00:03 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D3088717
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-691c85525ebso61580297b3.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248800; x=1724853600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=onVS0yAGaejZJanTjehVOM0V6uunVWvkVZs7NIjBRis=;
 b=Zyq45z9uIAq7BYYKVuWmYnsJ1ISzBHjwYe9MOQ6/L5SRc8u4SbcgIVGYh7ny03R3yh
 GY+EnJaQ3fp8ccI/xLcookqINzW9ZjwamwDmADZf3njgtn0JU0kn/PmHzSxTHhytVABF
 yoN5m45y1/7UGW4aqLwexf2bV/AEKcKLrT3u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248800; x=1724853600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=onVS0yAGaejZJanTjehVOM0V6uunVWvkVZs7NIjBRis=;
 b=upScpt9k7+Uxbcy8Hd/HtIUyTXduOoWtngImM5vG9EVhl5oZ0i5toAdT7UXxlb/p8x
 jX1UheDoEwpKHpatctAXJGJ7FTui3nrrNu6A0xdbG+2Yw7wby/I1IMlj5SCasy5EtyZK
 PjKudXTyI02aZrcEdkHfR9gBozP7f2y0Ld2o7TlozYzgZM7alzv2cltnrzcOLFcN7vQa
 pZhVv4R4EFA0XQnu0Zo7fH3z8fqY2+XQ2s4RhUILg7vS7d2Wy3rQKCez4TvuhP1vA779
 M/9F8gxXj6nBD2HqEbdZVLB+PcIiPJlmwSNQqwvO8a7+nBYuW44M6ad9y60b44xfwPIV
 E7Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXovAkxzUataLxwT15fEYifAee24mY4peT+T4c2P0MlfTJ3QTPTsvwSYxawmJsGkIMP0nI4btg=@lists.denx.de
X-Gm-Message-State: AOJu0YwysI2wFJIT78tcqp9ZoCQoKE696N+EQ5UUgawCxTWb7Mk56Vl9
 vUk+Ptjxsvex7u/nBvZs4uDxC9/EGjcIyJnIdIoEX6SHeR/JOilMMxevm20ivqbWMb4ow7njFMY
 sYn8gi1qPju4u+EqWgSwb4yb3oCyobFGSh0exQKEvHHcadg4=
X-Google-Smtp-Source: AGHT+IGF99mnehr35q+gLEEdHXWvyEGW48+SbbZ++pZIHLnk6ekSCnry+GyMDLojNNrXeO7Mir3yG0xSUY6+dPjns+E=
X-Received: by 2002:a05:690c:18:b0:646:25c7:178e with SMTP id
 00721157ae682-6c09c1c02d7mr31404277b3.5.1724248799846; Wed, 21 Aug 2024
 06:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
 <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
 <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
 <6bc0ccf4-66ef-467c-a3f2-e39d3d54f7cd@cherry.de>
 <CAFLszTggctZ-iRj0PS7zgCbUM8y3VUGky4aheg0HGw4RQvUsOQ@mail.gmail.com>
 <5b8e78ff-2a72-4af0-a286-065f312cbb8f@cherry.de>
In-Reply-To: <5b8e78ff-2a72-4af0-a286-065f312cbb8f@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:48 -0600
Message-ID: <CAFLszTggtp2AQO2_xJpAfVUh=MsvL5Btj=HddQrUNa3YeWWdxg@mail.gmail.com>
Subject: Re: clarifying i2c_get_chip_for_busnum()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sahaj Sarup <sahaj.sarup@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

On Wed, 21 Aug 2024 at 02:19, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/21/24 4:11 AM, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 20 Aug 2024 at 07:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi,
> >>
> >> On 8/20/24 3:01 PM, Sahaj Sarup wrote:
> >>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> On Tue, 20 Aug 2024 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 8/20/24 11:12 AM, Sahaj Sarup wrote:
> >>>>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> In `include/i2c.h` , the udevice pointer and return value definition
> >>>>> seems to be confusing.
> >>>>>
> >>>>> ```
> >>>>> /**
> >>>>>     * i2c_get_chip_for_busnum() - get a device to use to access a chip on
> >>>>> .
> >>>>> .
> >>>>> .
> >>>>>     * @devp: Returns pointer to new device if found or -ENODEV if not
> >>>>>     * found
> >>>>>     */
> >>>>> ```
> >>>>>
> >>>>> Should this instead be:
> >>>>>
> >>>>> ```
> >>>>>     * @devp:   Returns pointer to new device or NULL if not found
> >>>>>     * Return:  0 on success, -ENODEV on failure
> >>>>> ```
> >>>>>
> >>>>
> >>>> For the @devp part, seems like it as uclass_get_device_by_seq sets it to
> >>>> NULL and i2c_get_chip only modifies it when a device is found.
> >>>>
> >>>> For the return part... not sure. We don't overwrite the return value we
> >>>> get from functions we call, so not sure we can guarantee that only
> >>>> ENODEV will be returned?
> >>>
> >>> make sense, devp can't return -ENODEV, ofc, and Return returns 0 or -ve.
> >>> So it can be closer to:
> >>>
> >>> ```
> >>> * @devp:   Returns pointer to new device or NULL if chip is not found
> >>> * Return:  0 on success, -ve on failure to find bus or chip
> >>> ```
> >>>
> >>
> >> Nothing guarantees we'll return a negative value either though, c.f. the
> >> if conditions in i2c_get_chip_for_busnum(), where we only check for ret
> >> (i.e. ret != 0).
> >
> > That is pretty common in driver model. Few things return a positive
> > value. Mostly they return 0 on success or a -ve error code.
> >
> > Note though that *devp is generally not assigned if there is an error.
> > It is left unset, so it could be something like:
> >
> > @devp: Returns pointer to new device on success
> >
>
> I assume you're suggesting
>
> ```
> * @devp:   Returns pointer to new device on success
> * Return:  0 on success, -ve on failure to find bus or chip

Yes that's right.

Regards,
Simon
