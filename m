Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5B6E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EFA80702;
	Wed, 15 Jan 2025 02:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="baMKGAx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0145B80702; Wed, 15 Jan 2025 02:17:11 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5E0806D6
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aab925654d9so444893666b.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903827; x=1737508627; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YHgQ3slHPm9LCIY0cm+T0X4QbGK3rKywtohv9NR0iRQ=;
 b=baMKGAx25m38USSCGl4dDaBdFT8Gh0a50sRhbNdzwtDQByjE4o1giAApVIx9RiLQF9
 jxq/5E4voOUFQMbHJc8qrmyWSqY/Ld4PIIWIYyL7QfwF5gzclGThpEsXEaH9acRn0blB
 gG8pXXVp0NvGBWqBpx/thC8/XoSNoBboPpxTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903827; x=1737508627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YHgQ3slHPm9LCIY0cm+T0X4QbGK3rKywtohv9NR0iRQ=;
 b=k/z6bT38bJ+J4jiSYvyCfQ8IS4/nN4T+PtDxPW9FyOOa4S8IHe9IHOu/FO8quptZSY
 dulnN7x6w2ffvdT5LfPelPG6o9UZkfY/gBeXB3tymOYYADuSVxw/Ne04ae4KMQgzKzsR
 AaE2+Q8CzgEVgKY7NE4vEKAJxXq0Tbh8UvCKstzYLg98MdWSXejxbWgT4fe23PkJYKsF
 IYdHGdnVZ8AfQUPlnYiB6+Z8xCegGqERPTQL7DphGove/NTR1kSCZnazTDorAqTpiALy
 CIfI0fKK8FvFv/qTScSUTKsPMOwoSUSHFV0YMvRWMErVTfkt+vWlNr5l/3dJCXcJUNGU
 o/Pg==
X-Gm-Message-State: AOJu0YzC4NCTg8qd/AOLHkJGlSpBOxeOYonDLSHQBbmnyUWLoPHwdkxy
 cFqy08tV9nBYJRJvrdVW/EqJ1m9uPThc6RPYH0jZfHWlm3wadMvDE688lASsh6rJ6TCz7YDl7bP
 JOw+xZYrIoeMbJMmiqJiDv/9N8FLOTaBYxN8or6DZQ/qyTHs=
X-Gm-Gg: ASbGncsFUxRuAcEMSDg3zlz95253opr1IPVnHBj4Sv+LtEiClpOT+Anq/f6QbYNT+ho
 9bqWzW3xLWH+8Brfb/HbZODjFXY2fINkQUr/iAp0=
X-Google-Smtp-Source: AGHT+IGak6TAHywKI+Z8LhLFzgsjC5w9gY3yT9T1x02yVlmccJFdTVyd2YEsihUcta8vKqCxemVS+VXR45DHyrL2XM8=
X-Received: by 2002:a17:907:d87:b0:aa6:7a81:3077 with SMTP id
 a640c23a62f3a-ab2abdc3649mr2966788166b.54.1736903826880; Tue, 14 Jan 2025
 17:17:06 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR04MB55584A5EF725E8DF69629DF39A302@AM6PR04MB5558.eurprd04.prod.outlook.com>
 <CAFLszTg3D9C-XR7TwCqB6RAOvZH-TK7=CEN-WioSfEKWCVVGLg@mail.gmail.com>
 <AM6PR0402MB3575770B2FD604C0A153BDAC9A182@AM6PR0402MB3575.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3575770B2FD604C0A153BDAC9A182@AM6PR0402MB3575.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:16:55 -0700
X-Gm-Features: AbW1kvbhsS_DIWOAKWjgXSTRv3-oMZgkEM5X-HcQbfmLACWe6mm0ww2LIxWZbVk
Message-ID: <CAFLszTgRCzSN8ODXxXwS2afXktRHa9TOk3moWKroU45USJf+QA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: How would I do signature verification of
 standalone binary?
To: "Koch, Fabian" <Fabian.Koch@hima.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Fabian,

Firstly, please can you drop your signature as it is not correct for a
public mailing list.

On Tue, 14 Jan 2025 at 08:12, Koch, Fabian <Fabian.Koch@hima.com> wrote:
>
> Hey Simon,
>
> Thanks for getting back to me.
>
> > So long as you put your image in a configuration, it can be verified.
> > The question is whether you can load it.
>
> Yes. Meanwhile I got far enough to have a signed FIT image, a u-boot.img which contains the pub-key in a dtb and the means to load it all using "imxtract" which also does the signature verification.
>
> So my usecase might just work without any modifications to u-boot sources.
>
> I only need to confirm whether this can be secure enough against attacks.

If you are just using a signed image, then there is no protection
against a mix-and-match attack. Are you using a signed configuration?
The best approach is to use a signed configuration and then just a
hash for each image.

> > bootm assumes it is booting an OS. It does not support IH_TYPE_FIRMWARE as a type.
> I currently use "standalone" in the FIT source
>
> > You could write a new command to handle that, perhaps.
> I wanted to stay as close as possible to vanilla u-boot (or at least vanilla TI-SDK u-boot) in order to not have to do as much work when upgrading later on.

OK. Patches are welcome, though.

>
> > SPL does support loading firmware, but you are running U-Boot proper so that isn't very useful.
> Honestly, we could probably ditch u-boot proper for our usecase, but again staying very close to the TI SDK, (which instead finally loads a Linux kernel of course) we have been going this road so far.
> Might be worth checking if we can just use SPL only, also saving on boot time.
> Can you point me to how the rest (loading, verification) would look there in SPL only?
> Still a signed FIT image with "standalone" I suppose?

You need to enable full FIT in SPL, but yes, it should work in a similar way.

>
> > For your command, you could call fit_config_verify() to verify the config, then fit_image_load() to load the image you want.
> Both "iminfo" and "imxtract" which I currently tried run through fit_image_check_sig() eventually, and in the .dtb I marked the image as "required" to be verified.
> Doing the negative test of loading an unsigned FIT resulted in both commands failing and yielding a 1 as return value.
> So my current plan is to do some basic bootcmd like:
>
> If imxtract does not fail, use "go" to jump to the entry point, Else fail the boot
>
> Then I would try the "u-boot hardening" tips I found so far (like disabling cli and console, hard-code the env, and set the delay to -2)
>
> If you have any more ideas on how to make this more robust, please let me know.

That seems good to me, although I'm not a security expert!

>
> >> [long signature with legalese]
> > [can you please drop this as it is not correct for a public mailing
> > list?]
>
> It is auto-inserted by (I suspect) the company MTA, so I don't think I can, sorry.
> I tried to send this as a plaintext mail at least, maybe that makes it a bit more bearable.

OK, please raise it with your IT people as it does create confusion
and may make others reluctant to reply.

>
>
> Kind regards and happy new year
> Fabian
> Informationspflicht nach Art. 13 und 14 DS-GVO: https://www.hima.com/de/informationen-DSGVO Information obligation according to Art. 13 and 14 DS-GVO: https://www.hima.com/en/information-GDPR
>

Happy New Year!

[..]

Regards,
Simon
