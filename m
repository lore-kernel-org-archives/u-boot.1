Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0437AC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70523885F1;
	Mon, 10 Jun 2024 17:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PArr+dE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDED885FB; Mon, 10 Jun 2024 17:18:09 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F4C885F1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c2dee9d9a1so1404554a91.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718032685; x=1718637485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AoaWqVabIORiOf1mKCDDlgZYUXHw3EFu9aT2Q1j1pXU=;
 b=PArr+dE8v5xQDcd+S4U1Wj2C91Z/gk/Vz0p8UmIY8p8pSQjyBRzRzCQgTRrGrbewSx
 jK1Xk7AiXQJWrkKjZVrgmHBR45n2eT/4Fn2pN5pGUUMxKicSAMjT4XkEv0JXEbZmSNtX
 iXjUpz+mtdU/QfBd/J/CDUs2QLwkrh5PqhxXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032685; x=1718637485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AoaWqVabIORiOf1mKCDDlgZYUXHw3EFu9aT2Q1j1pXU=;
 b=ua/iMUh0wiIR1jBHUq/UFgjRMJVUZPxQ7vAR0+DpOb0mNiGEDvB47RpU/qWAf59Sl4
 hPf0nsjMWputREenA6heeh0WWgYTdvEAwLDSZQK2YPaDbZfVdHfTaLwuAObBmzTsL/of
 m2CJi/Z91AQ+QY7uNMiPlM8jqH8SCTSHk4mvsQSIYzSX9bQGaKz8ZHp5PJbAaL6q3qzr
 ZGtxOkJ9i/BbEaFeY7+Y1wwFjg8dKk2QIIv4/X8CLBky/wChiV6zI4YtcKzuLUyAoim1
 D86ewWlpXfVk6nM/Z2XASwPiZ6XURR3eHdZGRPWZhaQj+G8ziau27iI7u8bFJm2OqM/k
 fUzQ==
X-Gm-Message-State: AOJu0YxxQE502DV3jLwc2tTNZD1n52y6aOk9DkVlYXoJ7AEEV1johHsU
 svWzaXkzEiactI2lfTaKvJ97IHWhDp0VGcdVhlIkXjEjAywWBkPNo3a3LDNfAfdzU3gOaQd9Bu4
 Vmp7ixXiwmTbNHBKTiO2w+VxH8aDiIFIQp+rb
X-Google-Smtp-Source: AGHT+IHnPpU9OJIXX3bU3kbLnAdv3zNH1sVUQ2DlAJdPiG3fld/CVwehU7MJiOG7WOIwARL7NCaeQ+SGLGUfYYK5FD0=
X-Received: by 2002:a17:90a:eacf:b0:2c2:d163:d761 with SMTP id
 98e67ed59e1d1-2c2d163d873mr5728523a91.47.1718032685665; Mon, 10 Jun 2024
 08:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-8-sjg@chromium.org>
 <d87e132b-f31c-4b3b-a055-9625fb3fbb49@kwiboo.se>
 <CAFLszTjStfEOJY63CxsgT=+Q+GosQEBVK0ypX0cWmheNhXsKFw@mail.gmail.com>
In-Reply-To: <CAFLszTjStfEOJY63CxsgT=+Q+GosQEBVK0ypX0cWmheNhXsKFw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:17:54 -0600
Message-ID: <CAFLszTh_QijScd-UBiWzNPwoci14gEHmqq8+uM80-Ah6z3TQDw@mail.gmail.com>
Subject: Re: [PATCH 7/9] rockchip: bob: kevin: Disable dcache in SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Thu, 6 Jun 2024 at 09:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jonas,
>
> On Wed, 5 Jun 2024 at 05:07, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Simon,
> >
> > On 2024-06-05 05:25, Simon Glass wrote:
> > > This causes a hang, so disable it.
> >
> > When I initially tested this on multiple boards there was some boards
> > that also hanged, that turned out to be an issue in one of the drivers.
> >
> > If I remember correctly such hang was related to a null pointer
> > dereference or unaligned access in one of the drivers.
> >
> > Could there be a similar underlying issue for these boards?
>
> Yes it could be. I will take a look.
>
> But given the release date I would like to get this patch in first.

I did find a bug in memory sizing, but fixing that was not enough to
get the cache running. I am not sure how to debug it, since presumably
the code works fine on other rk3399 boards (sadly mine broke a few
days ago).

Regards,
Simon
