Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C74C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 08:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5F198301F;
	Thu, 29 May 2025 10:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YnGM32st";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2123A83022; Thu, 29 May 2025 10:10:21 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0365780C93
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6046ecc3e43so981309a12.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 01:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748506218; x=1749111018; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2QDS3jhwYpF+14JO1CKp5ffrg6Ku500cQm1bp/sc64g=;
 b=YnGM32stHUxbtWPxTvC4ZcW3UJmJHoDizHHA87KaIFheVfB3n2j7c4dKQOUuXXp5li
 8QwNd9YE0Bqqc8Ov1hMbau/IxSQ3vlyfnrixOnL8GOJh/Av9RXwAJ5niYwbRfQNwORZf
 xLuVupmI9niUn8HPLY1dN62Ic8iEGhZm3w67WlEJjMObkHgqdBU05OL41ApnHIX0qByJ
 s9pS1l74KvASeu7da0YhVEk4B2OLJhvPdD1oe4cHA2esNUfFJd62Zix0UfE4miw3DOwz
 UJhdbI4BrSPyVP8QLi4PTHUSbnql6XDdEvOf4hXPtlo8WL6tmoRvp+cdJRtRnvcgYS6I
 0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748506218; x=1749111018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QDS3jhwYpF+14JO1CKp5ffrg6Ku500cQm1bp/sc64g=;
 b=qvPihUJhmRrXS8uIXU6CzKfPTsABlc495V+PMNmZE7xZ1+JaerF0Mg8W7tTfYKbSpV
 /Kx7WdCm8ebnoobHtzirmzQKD47gWGkHjgbuOj+MIurxXeFb+ZLsOX678RqzXdOm/hBV
 4ZGyTMsnTcb7UnHDCTnxm2cu1nWiez6Fg0bg39x6uMdQ1f4clD9UD3m6sAgpDOMGZYrW
 ZfZJBro5iTKfkf8Z0lAS/pA8R2TMuCa5iu56xMkRHslUbjt8pdGQNX2t0Ue7Doyoetxw
 neJSuWu+Wh99ft6EhaEvpIdvamuxZ1x/trWvY9FLKpKUHhQznHeVzCbQ9oXKDOEhXVmZ
 08VA==
X-Gm-Message-State: AOJu0Yw5OvrZTLXf2vLcCwkybkIRU5UIHhCefFKIhnOyK8+A13boDJyR
 dffw4n+CNy01HiPnV2IYr9+n4RnpihcWDBXZMRtaOqBtsqHMwxMN55KRRdA8bggowLdLfnTP1cw
 aN8l4HtJEZq92hdCcXJ5lZC7VHrYqgeCLMKgDbbx0xHg2bpVgcb4bamU=
X-Gm-Gg: ASbGncvzO6lhISX7NmpL9ElpNvULiuD8mOXqceHLULHtWZtNz98lw+Yk9ei4YYyL//P
 ogwOQEI794/KPyohSgE5KpOj0TG4U6a6jRxH09q13RaVG8/b1mfH061EzvXH3J3TtvMys2DYPl9
 4F/DN32NlJS4L4+UMiH6TfJeUio5BdrMRUTn3VhirDZk9agj6YsjfXjpU+2bcAcRdT
X-Google-Smtp-Source: AGHT+IFXbotwHNSs75bxDdewjUuD0vlK8CldAOqoYLlO/dX3mlmTk2NNTR+fT5i5NA1UybhiVL/atJNDM4HtkrX/ugg=
X-Received: by 2002:a17:907:daa:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-ad8a1f313admr474781166b.31.1748506218237; Thu, 29 May 2025
 01:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU1=maNegZ=DiVR+OQG6B+eaGdn9v9Spz+KhYGCbzhRaFA@mail.gmail.com>
 <2b22423d-36db-4dba-8844-9bab22579158@linaro.org>
 <CAJ+vNU3gNAzCQzcHEY+1dkjpMeZfuxaJaaSLzP4pR_pSAt4Kiw@mail.gmail.com>
In-Reply-To: <CAJ+vNU3gNAzCQzcHEY+1dkjpMeZfuxaJaaSLzP4pR_pSAt4Kiw@mail.gmail.com>
From: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
Date: Thu, 29 May 2025 10:10:08 +0200
X-Gm-Features: AX0GCFtzAnwPaibqima9qNgyhXAHaEl-jHVEyDfEgx-dWP52BynB433FUGXZl8E
Message-ID: <CA+NB=mZfJJNViyC6VAyvuX_oPf-UvpFMsjyNC6qs1AO=35-Lyw@mail.gmail.com>
Subject: Re: lwIP watchdog not being serviced
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le mer. 28 mai 2025, 18:29, Tim Harvey <tharvey@gateworks.com> a =C3=A9crit=
 :

> On Wed, May 28, 2025 at 12:57=E2=80=AFAM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > On 5/27/25 21:07, Tim Harvey wrote:
> > > Hi Jerome,
> > >
> > > In my continued evaluation to see if I want to switch my boards over
> > > to use lwIP I've noticed that the watchdog does not get serviced
> > > during at least http/tftp which surprised me. This causes board reset=
s
> > > when transferring large files such as disk images.
> > >
> > > It seems lwIP is missing some calls to schedule(). Do you have a
> > > suggestion for the right place to call this for lwIP?
> >
> > That's a good point. Anywhere in the receive loops should be OK, for
> > example right after net_lwip_rx(udev, netif). But for simplicity and
> > to avoid pattern duplication we may want to call schedule() as well
> > as sys_check_timeouts() inside net_lwip_rx():
> >
> > int net_lwip_rx(struct udevice *udev, struct netif *netif)
> > {
> >         struct pbuf *pbuf;
> >         uchar *packet;
> >         int flags;
> >         int len;
> >         int i;
> >
> >         /* lwIP timers */
> >         sys_check_timeouts();
> >         /* Other tasks and actions */
> >         schedule();
> >
> >         if (!eth_is_active(udev))
> >                 return -EINVAL;
> >         ...
> > }
> >
>
> Hi Jerome,
>
> I knew you would know exactly where to put it - works great.


Good.

Shall I
> submit a patch authored by you and signed-off by both of us?
>

I suggest you author it and add your sign-off and add me as Suggested-by.

Thanks,
--=20
J=C3=A9r=C3=B4me


> Thanks,
>
> Tim
>
