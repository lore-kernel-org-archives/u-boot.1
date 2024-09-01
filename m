Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF718C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F18588C19;
	Sun,  1 Sep 2024 22:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B0NDQUQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB58588BB2; Sun,  1 Sep 2024 22:10:12 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DA588B2D
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c35b545b41so7778176d6.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221409; x=1725826209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2K8b4Th5VZPmS5Q2wh0dzUjvkOw0zCkd52MQxViuU7I=;
 b=B0NDQUQYNHiouAl6Q4b1U8q/Y2K7iyvI9qYpcEvalzrvnm1ltCQKg2XAEHs89wE5Ao
 W9LPg3XG9lGQG4gxE+bA2tYeg2TQRJkZsKCwZRfMNJSppBeGdFKPvNBkIqMRBcAiVLIx
 ENxO7WmsHd/EU/2xLDqZScH7//Euj1s92NIhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221409; x=1725826209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2K8b4Th5VZPmS5Q2wh0dzUjvkOw0zCkd52MQxViuU7I=;
 b=KrI6etQ66cRMdmoqYfbWpkwOoK/pU3oxl2VJU42doT4H5aHtbOEIcMRmUFq5rP4x6Q
 PaVCqRJukiL0MApIyQxBAc6UpBMzlnUts8OZ4YrXrIo2JEuzdwCeuY6xuPJOQc0sy9tq
 Gi/d/h4TqPhjK/bSiE5v+nh18v40ywFg1FxSmkjSQYoDdBN8SOHrfJ/0zf3ztiok92R8
 zF5N8Z+SGha8q5/6p2zSHhavzcAjCdmiLSetmnG7i/ZnUsKU44MS31WGnz46JfEZFJqv
 /7xaxIJf7ZVQBIauYgeKvRc89KcgLYgkiMXBXKSRATu9HvY/ckYzy453vvSClFw9dDhg
 pDfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfV6CYE/7G5zpjqK0q9qwE/a2GAsWTqcjBhYH8iyxvJivPWhE4ddVGrTOoF4PCCK9sj+IhfjE=@lists.denx.de
X-Gm-Message-State: AOJu0YwMUbVKl2Mrd1lB46R2U3YBaQGPaO1bXXRo2MNwTIfE9oUbx2lF
 OvyyQBTUTq0+LKnJZgvV2TnZyoJEJo1EFxXAjxLd99+6QUgCcmNHUc5GYrjHkF8SbCVQxZJCOt+
 gEuVTjkeWzxA0xZ+//fFZdi4VFN2kxJKD8KztjK4ZZ097R0s=
X-Google-Smtp-Source: AGHT+IFErhX3eLdSusvVGt18z1xh9YjnaGGbFEoEbpx/UJ7n4v9IaHVZ1EH9Hm0g9kHkrjPR+v6SKURALX/m3TM73DU=
X-Received: by 2002:a05:6214:33c5:b0:6c3:6414:7172 with SMTP id
 6a1803df08f44-6c364147225mr38589436d6.9.1725221409587; Sun, 01 Sep 2024
 13:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
 <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
 <20240830142620.GS2479150@bill-the-cat>
In-Reply-To: <20240830142620.GS2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:58 -0600
Message-ID: <CAFLszTjZmKKQSVTU5rhH_xX-neP1ZWByX96xUNxc-JTOY8R2yA@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Fri, 30 Aug 2024 at 08:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > > Hi Neil,
> > > >
> > > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > > > >
> > > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > > Send the Labgrid quit characters to ask it to exit gracefully. This
> > > > > > typically allows it to power off the board being used.
> > > > >
> > > > > Sending those characters every time could collide with other CI systems,
> > > > > I don't think it's a good idea.
> > > >
> > > > What systems are you thinking about and what sort of collision would occur?
> > > >
> > > > What do you suggest instead?
> > >
> > > Why do we need this at all? Did I miss where we send picocom the
> > > disconnect nicely key-combination?
> >
> > When labgrid gets a signal, it exits. It doesn't continue its
> > co-routines and execute the end strategy to power things off, etc. I
> > suspect it could be made to do that, but I already have 62 Labgrid
> > patches, so I thought this would be expedient...
> >
> > I can make this conditional on the new USE_LABGRID variable.
>
> It sounds to me like we need to make generic improvements to our hooks
> then, if there's not a "now call poweroff" hook.

The thing is, Labgrid has its own internal console, which allows me to
see all the output from reset. If I use picocom or some other program
then some of the output is gone by the time I connect, particularly
when using USB download. Because of that, just killing Labgrid, which
is what pytest does, is a pretty heavy hammer and leaves things in an
unknown state. So I added this method to give it a software signal.

Regards,
Simon
