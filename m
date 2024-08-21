Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5386C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023C588AD2;
	Wed, 21 Aug 2024 04:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KKVyG2Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA8A88A64; Wed, 21 Aug 2024 04:11:30 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB10C88B5F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6bf7f4a133aso27248496d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206287; x=1724811087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0WDz9+p8JiGzORxpnBxMVtyZflfdHyTZc2lfrM1WicQ=;
 b=KKVyG2JlZIfF/CmWxj8Oo+d1NhMluqeNqOKlMHKxqUw9g8YiBkow+iHLTezt3Q+YpZ
 aaTVKbGAbeplNLnCzq+I/EE/Tq+Kyz61x/haKzo1SLkRW7v91BrnX9T02ecocjpT/Jgs
 CqY4yj+ej1JwTs4SG7WwBmFZY5ynhwQbBMi30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206287; x=1724811087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0WDz9+p8JiGzORxpnBxMVtyZflfdHyTZc2lfrM1WicQ=;
 b=LTSahictn245OfNuwkD77KMI3uKa8RQtxVl27Vb3eXug+B6wvASmJ7UqK6EJKuqvCQ
 XnZvTxsgoFwdIHGeQyaqnud4QGsjSUgeXZjj8Cf/UoxMCzDZg5q8gAIwLx735b3gOU6x
 rrJziQkVLy5B0MvNPHg5LNXLjmqzfQ1LlbfGf6DpdHkTcXvcHFoKJE+QkDWvpyuzFbCu
 qbFXp0utk8alT2XiLAfHMsi/vAnYVltRSE303rhNkoV6xOjm8ocbK1EeOcWb+yD4BanR
 rE723Rh5VdEbk+9f6FP7yM25q0DGQPGCoPNWKSJA1DfC4L2fTK8NeXgR3kVCXQsGCqTa
 cLqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX68AYLTdhe6tg+pGMTt3xO8PN2TZQXw5hjkCrCUiqrnfTm/iy/SGB4Fx46QLC7n+T9V9C+IQ0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg5c1F2wwhUsVR4xfHGHHzxV7LDZihTXmdrp0QQUSl9o+7G95G
 TK9wm7T1/vMVtAtWV0soFgQP6XBU5WkkGLZm6zB3K31b1Jr7SRL7qASCXoEN0Gto64IdYCx8NZr
 LEypdU0ptnCneay24A3AhmH6MEm1L3u7yKOvf/LxXzJUNOLQ=
X-Google-Smtp-Source: AGHT+IHT8KokJL9qTLwXMKj7tJ04RmBNgUk7nzmW0W/jjt6EqNmPgMsSRoctFzwEnBW9GBSxK+27OIwlYIYLJK/IoGU=
X-Received: by 2002:a05:6214:310b:b0:6bf:8ae8:fc0c with SMTP id
 6a1803df08f44-6c15686dff0mr9281086d6.35.1724206286731; Tue, 20 Aug 2024
 19:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
 <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
 <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
 <6bc0ccf4-66ef-467c-a3f2-e39d3d54f7cd@cherry.de>
In-Reply-To: <6bc0ccf4-66ef-467c-a3f2-e39d3d54f7cd@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:16 -0600
Message-ID: <CAFLszTggctZ-iRj0PS7zgCbUM8y3VUGky4aheg0HGw4RQvUsOQ@mail.gmail.com>
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

Hi,

On Tue, 20 Aug 2024 at 07:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi,
>
> On 8/20/24 3:01 PM, Sahaj Sarup wrote:
> > [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, 20 Aug 2024 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi,
> >>
> >> On 8/20/24 11:12 AM, Sahaj Sarup wrote:
> >>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> Hi,
> >>>
> >>> In `include/i2c.h` , the udevice pointer and return value definition
> >>> seems to be confusing.
> >>>
> >>> ```
> >>> /**
> >>>    * i2c_get_chip_for_busnum() - get a device to use to access a chip on
> >>> .
> >>> .
> >>> .
> >>>    * @devp: Returns pointer to new device if found or -ENODEV if not
> >>>    * found
> >>>    */
> >>> ```
> >>>
> >>> Should this instead be:
> >>>
> >>> ```
> >>>    * @devp:   Returns pointer to new device or NULL if not found
> >>>    * Return:  0 on success, -ENODEV on failure
> >>> ```
> >>>
> >>
> >> For the @devp part, seems like it as uclass_get_device_by_seq sets it to
> >> NULL and i2c_get_chip only modifies it when a device is found.
> >>
> >> For the return part... not sure. We don't overwrite the return value we
> >> get from functions we call, so not sure we can guarantee that only
> >> ENODEV will be returned?
> >
> > make sense, devp can't return -ENODEV, ofc, and Return returns 0 or -ve.
> > So it can be closer to:
> >
> > ```
> > * @devp:   Returns pointer to new device or NULL if chip is not found
> > * Return:  0 on success, -ve on failure to find bus or chip
> > ```
> >
>
> Nothing guarantees we'll return a negative value either though, c.f. the
> if conditions in i2c_get_chip_for_busnum(), where we only check for ret
> (i.e. ret != 0).

That is pretty common in driver model. Few things return a positive
value. Mostly they return 0 on success or a -ve error code.

Note though that *devp is generally not assigned if there is an error.
It is left unset, so it could be something like:

@devp: Returns pointer to new device on success

Regards,
SImon
