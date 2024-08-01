Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1ADC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 19:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E7E8874D;
	Thu,  1 Aug 2024 21:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTC0hTKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D97886F1; Thu,  1 Aug 2024 21:29:03 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0482288B44
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 21:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b797234b09so23012456d6.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722540539; x=1723145339; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6mWbCjUtGwKwDSuRGD5TKshE5tAp14lkh785ufGl4w=;
 b=XTC0hTKtQn8TTIVUlTy6xeuB/1irw12KNfJVRRQw4UwceyXQINfY9tRUz074rjicUj
 OxIE1BmSItO0eBvkDS2A7KiAIhDNnyGzCt07iWRs4IyMo5pyhIcAwewV9cTMYZZjRHp4
 Dw490HuJlwrRYD3a/ZNbD4mjgNZ9mrslBjgEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722540539; x=1723145339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6mWbCjUtGwKwDSuRGD5TKshE5tAp14lkh785ufGl4w=;
 b=CqqYxNKYDkfBuF3+7drhiglj9bJYkwHbK9aKpYs+eE6g/bYIobjD+2ha5lHAxw+Mvd
 2JTfBlVpO3JAlqaRnncQdZt4bULtv7hjK4gtiODF0BERfXwmbSDmK3h+8Jrz5mP6+wMF
 uHQ1BwodQR3vWuDddyo5azkCen86RlJqrfGQNRKSzuqmEXw5xpT8SY5/Gty9MvoHDNdj
 Cp4RTwgEufKF4Mw89aMvD3MluiIWqc1bZ3Sd687zAIPHDCb6VdRZVFse2jn6nBURIapU
 8KhohPnmxBhBFCpwPImS9XAvKp8q4XoEDfZm3uf2RYnQMRoBG4n0B135A8WyMpK+zZSD
 6yoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy90JWh0dOo7G6gLA7IMyaRDYFFT6nurcnL70bTE8oSDpNHtv/bucz1Jj6VgaiiWO6eeovGOiUy4XalAat2Nmip+rkrg==
X-Gm-Message-State: AOJu0YwDyxZr5how3iTGOtXpYS7+RdB/xptIqVWx9/LR2oD5vW38A6Vw
 8bchYQaA4T4TCAkhXQhRVxQXaghXMGV7pzWqX4wJApAIftN4Sv/0aOrNnnje0L2UBnGLIKJQawT
 /dFwSbSvzSLfYDXyaWnb/ohkVMW+8TEXBymdg
X-Google-Smtp-Source: AGHT+IEyl1/ZlRX1AfrBt87Zovi0oxEXY45sCO+1jX3hi5gw4C+k56Tzg2k7XvT1gfnuxKHXWYwAaVOo8haeIIdaUHg=
X-Received: by 2002:a05:6214:3d85:b0:6b5:684:2d5 with SMTP id
 6a1803df08f44-6bb9868cac1mr20734066d6.4.1722540538784; Thu, 01 Aug 2024
 12:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240731134257.686017-1-admin@hifiphile.com>
 <CAFLszTiAjodH7P50ryJv7NZCAn5zahT=gBrvs+sNUPX0CDdb-Q@mail.gmail.com>
 <CA+GyqeZEJJocLXRKP5aAeKeZABzEGqkBqagRZyvwJjE2bjh7sw@mail.gmail.com>
In-Reply-To: <CA+GyqeZEJJocLXRKP5aAeKeZABzEGqkBqagRZyvwJjE2bjh7sw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 13:28:47 -0600
Message-ID: <CAFLszTjJBtofb0cuPaKSV6S5+6DfaWYt86TYK7pfmtAxQpgB4g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] dm: Duplicate uclass name fix and alias
 improvements
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Zixun,

On Thu, 1 Aug 2024 at 12:37, Zixun LI <admin@hifiphile.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 1, 2024 at 4:42=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Can we rename the gadget uclass to usb_gadget or similar, then update
> > the aliases?
> >
>
> You mean split patch no.4 into 2 parts, first rename the class to usb_gad=
get
> before doing the alias job ?

Yes I suppose so. I am trying to avoid adding the extra field to the
uclass, just for the use of one uclass.

>
> > I think it makes sense to show the seq instead of the index, but
> > please update the header for the table to say 'Seq'
>
> Will do.
>
> > I assume no tests need updating, but please do add a note to
> > doc/usage/cmd/bind.rst
>
> Will do.
>
> Regards,
> Zixun LI

Regards,
Simon
