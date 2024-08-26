Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2B3C5472D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 17:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E8088AA4;
	Mon, 26 Aug 2024 19:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L63CamEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51E088981; Mon, 26 Aug 2024 19:59:09 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82553886A7
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 19:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf66fe9d8bso21798136d6.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724695146; x=1725299946; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=suYgUUsam5NJCnlRO6M1nLsMpOzqcPqshJkcud5n/uM=;
 b=L63CamEN6EadoTj4IVg6O2jj3fQnbDuvk64WxcVOX0o0eK2flJkkROG4dasTevJ5W/
 tPZh/sEW3F8LesuOgA7XpsTohvE25lWplfRkPjsoe68wDkICeG4KCL/oMeC6NKYwWZaz
 ItfM3LOugOmnygnFbXH/5mR1Vfu0N1QAhPDhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695146; x=1725299946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suYgUUsam5NJCnlRO6M1nLsMpOzqcPqshJkcud5n/uM=;
 b=pkuKSpRYMVSHkpLke24eHpqG4O+kP3ZEcyY7hQv3VyPz+EiF5QOK9lt3NHE0cdsGKg
 SqIHw/qMlg/SeiI0AfI5eMO2TI8jGsNNPidRt+CbngCvdCy39YTwi3ht3B0ehzZ5HPBs
 aFLASSty6nik7WG5n/xLjEPkde/2gUfI7wIOBgn/xny+RNmzsfvyf4iUvxpvqhFQc3Zq
 7ll+6cLIPpC4PD+Txz20VJd/2xEL4p6EtDD9hlsPNbxeKiqWSehfFqzIIHQh6u8EVoxI
 8OhqO6+tWfHCzDQFlo3g/ZdgNJlrLTMqKAElHMkoaXdBzJMtjleyP035NuUr18lieMf2
 2wiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX572V+dtBvMGpyo8aJepRKx9EfVMEuMXVTy/UdqkmBp/r+qaVlokSNW5v0+qs+Yd1AmCzTPE0=@lists.denx.de
X-Gm-Message-State: AOJu0YziUXvnhQq59nfCpHjcY38mfkaRz7Nm3mjNWSTqhdWKgTm/LFKd
 WD/S4HIfANFStE8SbLVZHSfsOiEWaMjLd22azD42JAVIe4mvjjy2oCKZIvAISiZPhu+zFZKXfFD
 hm6TS8+CeZ50Dr6yD9+k58ygk0Jb2JfAy9B2T
X-Google-Smtp-Source: AGHT+IGMoJsJgft5f2kCZo1MP0QFa40CDJS2DXssgJTz1V/c1RjY5PgH9mQZ3fCQ60i4o4s7XD+Ci4GXuF6yVgV1isc=
X-Received: by 2002:a05:6214:318d:b0:6b5:e60c:76dc with SMTP id
 6a1803df08f44-6c16dc604d3mr134647136d6.19.1724695146477; Mon, 26 Aug 2024
 10:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
 <b7c9d535-9295-4a6b-9b8e-a62a123bc1fc@genexis.eu>
 <CAFLszTgFXHoWjdeZ+Ze_vpvRpA4B1C=zpsKzJsMtuLkzH_HFmg@mail.gmail.com>
 <c77f2748-129f-4307-9bab-8691da69b0b9@genexis.eu>
In-Reply-To: <c77f2748-129f-4307-9bab-8691da69b0b9@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Aug 2024 11:58:55 -0600
Message-ID: <CAFLszTj2uEjx24q222gMBm2AsydnpVf-qhcrkPpQt76cXXVRJw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Mikhail,

On Sat, 24 Aug 2024 at 06:30, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
> actually I know nothing about sandbox emulator

This is the foundation of U-Boot's testing [1]. See for example test/cmd/wget.c

>
>
> On 23.08.2024 23:47, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Fri, 23 Aug 2024 at 09:12, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@genexis.eu> wrote:
> >> By the way, I'd like to know your opinion:
> >>  * should I add a sample implementation of http/1.1 compatible
> >> web-server to this patch series?
> >>
> >> This can be used as a base for other implementations like firmware
> >> upgrade web-server used by some vendors.
> > Do you mean using the sandbox emulator? Yes I think that would be very helpful.
> >
> > Regards,
> > Simon
> >
> >
> >> Mikhail Kshevetskiy
> >>
> >>
> >> On 17.08.2024 18:58, Simon Glass wrote:
> >>> Hi Mikhail,
> >>>
> >>> On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> >>> <mikhail.kshevetskiy@iopsys.eu> wrote:
> >>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >>>> ---
> >>>>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
> >>>>  1 file changed, 37 insertions(+), 33 deletions(-)
> >>>>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>

[..]

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/testing.html
