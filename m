Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CEDC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0E68391E;
	Wed, 28 May 2025 14:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xjnhm2/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5808083937; Wed, 28 May 2025 14:53:57 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF6378390C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70df67e1b17so41190077b3.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748436832; x=1749041632; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=daaZfaTC+lXxj0lySRpn7bG3OX+HUtP7LZa/M9Y55NQ=;
 b=Xjnhm2/lpmFo6XAbLD4E/ulRmfvkWcu+iCyQtmxTerEWpPOTamoPxPqmVuRFzQorAJ
 7iAeej+ZOHWjcCb17iR7CIMdr6iHw5c42wcP7ElQSGyeZxHT7t4724obmo+nSm4zA8lq
 5EHrJf5PjOXtbz0fa98gQou+rOYMaRST23dwd93KKjGLdu0PNI1e+y/te8TZ8CcF5mTW
 o70+qEUUPzMwGYtrS0bBJ37r7WpPbnJ828Myzq53uU+vcPzKoVrwJF05hppJ5E+ECDP5
 zEmhWegEnXbWcguivZ9kn39/1IsTR3btUZTIf7l60IL7wHYT1Y3LXE0Ey4uvQUBB2fnZ
 XaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748436832; x=1749041632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daaZfaTC+lXxj0lySRpn7bG3OX+HUtP7LZa/M9Y55NQ=;
 b=e7eNu3/uUwWlMEPUrkhGfa9o9GCCBB20AWaPKXOjHIbfvkXbflX1lUgraILWRn+d7t
 DnooaEXYfQFu7slp6sySTyxE0gfWQik10qu+fVxEXv6Nl/x1+AbawFM9f1MpVniJQS9Z
 0XYSlv2YV5qXxn6uHtJv+vndkthzNiL6BQ94IqrtJT4hFHxs5Mdi15FSLlckixh8e0z/
 g37uaYk9avyJBrGXfqFP6bJD1GQN5Zq7HItlzVKmN22npMk03/4ZtMrEPd/Z03b3epfb
 JsdAgJZHXzXYSY9Q4/GAIirmfgsNRq8s5ayYZCYPNY3P+F0tFnKWdv+LmM3WyabuXa3b
 LJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58qvYq0267oyz0MdQMEl+GJi5ZDRSFXzq+l4Gnsdiv8CLXakunlmzet9M7+pYm+FJYobAmAA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywl4qbav4lSut1EsFalh3nVxi93dYMiizfOgYR3MT2hw0GoDBr+
 W3tKJHZ8jAPTqZd5h99F1OIbn2PLtN08kyMekcn+GYYxCeskaZAp9tyeVRKppm3QoDS8L7YqAxM
 VkjYcddtpGns/UFj5Cm6nNCg3SYkEmd6bmj/+6KG9Zg==
X-Gm-Gg: ASbGncv7e4/ZFD7rs0PHOp0yQmg/zBaF2THB/04qWra7WVml5bzHEVU2p1oM1RsS7l0
 SEwFjdDKDN220P/81ICyUXZ5vEDqIoZl/IkZFvp3jxIc2d8/tTVCFZROmgYTpbDTv5XxIah9s2Q
 Jmt5Dd0hUqYDV8lN4z/fLJ/rQ9vrVTAcvBxw==
X-Google-Smtp-Source: AGHT+IFDZTpGWiOLBq2BogEx4RhuOQwCdHzZfqeVx75JWonMbCTmyu3gbfEgUknKpDPw6XId/3B07o8c5MFZ6FK2lBE=
X-Received: by 2002:a05:690c:f8b:b0:70d:f47a:7e1a with SMTP id
 00721157ae682-70e2d99d830mr220495717b3.10.1748436830144; Wed, 28 May 2025
 05:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjtw8s2NnrS+B6-K8i_YF0ZGU9JB+O_vNYmT+AD7Km_AA@mail.gmail.com>
 <20250526145128.GW100073@bill-the-cat>
 <CAFLszTiF_3hMcgL7g6scpHRPa0wdmZSbKL4wfe+YYS5Wv94OJg@mail.gmail.com>
In-Reply-To: <CAFLszTiF_3hMcgL7g6scpHRPa0wdmZSbKL4wfe+YYS5Wv94OJg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 May 2025 15:53:14 +0300
X-Gm-Features: AX0GCFuFhUWNSb70w1My5JWMz5l1i-JBopMjE8EXp1AUXOLv4Cpz_yeTb77SH84
Message-ID: <CAC_iWjKmCX3m7uiFGsPXQt+0xEpzoGmgVFPrM5epR7dDzm=wmA@mail.gmail.com>
Subject: Re: Booting distros in CI
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi all

On Wed, 28 May 2025 at 12:35, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Mon, 26 May 2025 at 15:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, May 26, 2025 at 03:10:49PM +0100, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > What do you think about having a Linux distro in the docker image so
> > > we could run a 'boot' test in CI without needing my lab?
> > >
> > > Alpine Linux has an image which is about 250MB.
> >
> > I did say we should be doing this in some other thread we had, so yes, I
> > think it's a good concept. Ilias I believe has been telling me about
> > some HTTP (or HTTPS) boot pipeline Linaro has for a while, and with
> > Adriano's patch to add a simple web server to CI too, yes, a pytest
> > doing that would be a good next step forward. I'm sure we can find some
> > sufficient and small stock images to fetch and use.
>
> As discussed on the call, Ilias / team is planning to take a look at
> this, so I'll hold off for a few months on anything here from my own
> side.

If anyone else wants to have a look I don't mind.
commit df11ac859d has enough information, but the tl;dr is that we can
boot a live image over the network now as long as the kernel is
compiled with

CONFIG_ARCH_HAS_PMEM_API
CONFIG_OF_PMEM
CONFIG_DEV_DAX_PMEM
CONFIG_ARM64_PMEM
 CONFIG_BLK_DEV_PMEM
CONFIG_ARM64_PMEM
CONFIG_DEV_DAX_PMEM

Cheers
/Ilias

>
> Regards,
> SImon
>
>
> > --
> > Tom
