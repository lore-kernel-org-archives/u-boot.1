Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077EDD6A25E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CA289348;
	Fri, 15 Nov 2024 15:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrAb5QGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F66C89354; Fri, 15 Nov 2024 15:25:28 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78D38909F
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2fb304e7dso1617305a91.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731680724; x=1732285524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/zzZiZVjCQMPMShA+VieDdfoNbKQK4RedDdbGsn+GTs=;
 b=rrAb5QGNDcO1VYXY+/O8g1uupifYbuS7TlMAOL9kZ792ipK3nN/q4Zm9lIBQ7wX66K
 KepN9mCUWV9BrYERG8wVJstn8HmJbxh2zTBLZ3jy4lnTPA2vSTknLbTTWRC168DSK50x
 gxnXFxDOutmDByvc8IfWUiVj0uO2I1vB19AFRCRMMmPKwxzz/W2TZKJR740QZ/WLaDHn
 vtK8aPuxMqSjCm1kCPVTDUTIhHWgCky1hwwKmtwJBpsxZZDlp/gGVZxJr73Qe0XE4dlG
 h8qUTh1LTlelYK3JlYy0xSVDu7//GoGgtW6fCXWACDJcCBPfGmAF3OanQqzUsl1vuoc8
 EGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680724; x=1732285524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zzZiZVjCQMPMShA+VieDdfoNbKQK4RedDdbGsn+GTs=;
 b=Hzfjh6zaIb8jSYqmQlQnIqJ3EApu8rWpBSOXUWTFG6kkAPGEvKv9JJim2ZBO6Y5EU6
 NkrUMIAi/Cj5EJzQhN3En4/q/s8PSCtDnWsB5NIhieZOTB4mz0dc9Vvh5X5HaRjQW2q7
 cGlhJB/iDsndWAZpj4517mIjsTEW4e6CK1dj/JYKktbeFFYXpZshi48jxpP0ZOEdZr+v
 g5htJS8ktrdCDyIs0Y3Oyfb9y0UmuYswaHItLt2+r8JqResrjUzCWpIfp6bIb66qwJc7
 lSE2+JDFJklO9vauKuPhqJZQCfy6jqcB4WoeofBUcdUhipZIJG6bOzfGbOU/QOj9u4Ho
 VR4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXms8reEUGCfOasC4ROAd95u5W38ufsuZdCE54a8RLDxNrk1r9CAlXaKvN0ajEy526qK/JoOQs=@lists.denx.de
X-Gm-Message-State: AOJu0YxUVmEzciWfMPRqD2bv+tzRCWYG6bkfLL8ONWUK2deNeZ93blsf
 9Q+YGMYait7OUSRoA9M9BEqJ4xCp9Hys2kqo+NieaIiQQj5Te/i6fTdPjwoEoLYTUMrHH09OhJ4
 TEinDQrrZ5yVS8VM7MGmxKAa87G7fQWlh9OYnWQ==
X-Google-Smtp-Source: AGHT+IEb4yW5x41OA61xtkxp3W1LtHzJw/sNJCCwSllgOh0DTutNhM01OKr6yyMetASYUTnQVfsE0QQQ99rDPvJLyN8=
X-Received: by 2002:a17:90b:1c10:b0:2e0:7b2b:f76 with SMTP id
 98e67ed59e1d1-2ea1551e389mr3212314a91.19.1731680724293; Fri, 15 Nov 2024
 06:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
 <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
 <CAC_iWjKFxtBxEqkkXSOhcRqN4fRRgMcsmFRVYeNZOnR4zERrQQ@mail.gmail.com>
 <CAFLszTjou7yq-psYT3jBU7L8g81+bWUqc9Xj007zqfpfpnP9gg@mail.gmail.com>
 <CAC_iWjJdK6D+inVSMqJ941yvpDvK4j5XufvA1Fije3aqZvm=1g@mail.gmail.com>
 <CAFLszTiG9AMPs7q9QJgD5bP4=QwXVxQrOJqpWARamkPXS8p4wg@mail.gmail.com>
 <CAC_iWjL6BDhRHTYWW25N2v8Aw_MbwTzc+FAX1c6akGKypLKFEA@mail.gmail.com>
 <CAFLszTiPNMEGFPsbsuagcVooPDb_eawafnb=7hWGaDmNYbrqyg@mail.gmail.com>
 <CAC_iWjK-8JxM65dZkN1z_wP1Q+o7t4mJ1Xw8QZjzcanWXr98SA@mail.gmail.com>
 <CAFLszTgUbx4wXNmR0Fqu-ZxQwT1nvV7aOGiDOzZ-di-w-zQLew@mail.gmail.com>
 <CAC_iWj+59tJh=iBSTRGw3DCtfQ+aPCeYo_JP2joASZ7bqC5uKQ@mail.gmail.com>
 <CAFLszThSq+U8RqdOg09jEW0EcwbiaE3rwHwtaUshq+qS7DMUpw@mail.gmail.com>
In-Reply-To: <CAFLszThSq+U8RqdOg09jEW0EcwbiaE3rwHwtaUshq+qS7DMUpw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Nov 2024 16:24:47 +0200
Message-ID: <CAC_iWjJOqUuNHBGByR=tdo59Q-TboWLKXTW3tNK-L8=ZBvyatQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

[...]


> > > > +
> > > > > +       return 0;
> > > >
> > > > Yep, that's identical to what I had above without the allocation,
> > > > which indeed isn't needed.
> > > > Both of the versions are correct and I ask internally mbedTLS devs if
> > > > they have a preference.
> > > >
> > > > In any case feel free to send this, since Tom picked up the patches
> already
> > >
> > > OK. It will be interesting to see if coverity picks this up.
> >
> > Pick up what ? There's nothing wrong with the merged code. It does
> > gathers entropy in rounds of 8b
>
> If len is 40 (say) then this will memcpy() 40 bytes from the 8-byte
> variable.
>

Mbed TLS will only use 8 though, and the rest are garbage. In any case I
don't think coverity can catch that.

Cheers
/Ilias

>
> Regards,
> Simon
>
