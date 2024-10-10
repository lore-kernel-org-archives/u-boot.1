Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612F7CF11FD
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 15:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F388918B;
	Thu, 10 Oct 2024 17:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FTq6mvLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0FD89167; Thu, 10 Oct 2024 17:10:41 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2738911E
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 17:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso8376886d6.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728573038; x=1729177838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rq1F3RiqpBqt3VnXLmx8jquQS9LdbNMMWNaVhowSr1I=;
 b=FTq6mvLSDET82NcBiItIY5FW4lvYKti85mVUkb/pdQ2T1QvrM2CEVfSQIu/h/wM+hR
 QKDbASCuUSzlsdsbTxFkbHjpXTl6DxxfVoBwcshHiMTI6sS6gSFPc1h5UzzarI9xxSkm
 l14hijPwwhDMk8ZBgaam/vn+5twH8Mn7Q5MTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728573038; x=1729177838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rq1F3RiqpBqt3VnXLmx8jquQS9LdbNMMWNaVhowSr1I=;
 b=tioyOW7ltVEqyVGUM8CIJOfip826GJ9mU0YGaWaizsTmwhGq7uV4hVt9UrziJaPCWd
 7ewrPZ+wmHyQKtVC6b/j+Bf5n/JROBi7Coqk1dndKry9Jf98HxaXC//Mc8dWOoOTnU8f
 gHq31adZ6ayRJ111Gy09tmo4T/OMkf1+aq1OtMpt3GSRQElupK0Pz5yM6lCxg/+r8mTZ
 AVoGPzewQ7CoiWGBwLspocQNHXboel54+r+ySNuNoP4mAZQV9pe2OLmSIjvuqc2u7aAN
 EhGLwZl9AazBeSCx2aLay6PuM5WaWefInTSqOVLS4p+JDgmVA4C9hOQ7m4DSodyTLl1e
 6y9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu4iZdAsGmneRS5I3McmojqylIYa4ev8j6mzz8uw9YJvBGqafmR9gnU6jg5/usjFyi2zHeG6s=@lists.denx.de
X-Gm-Message-State: AOJu0YzloXmUMccXprsFr4jbR5l68RIN4WsRDTgvbloyOzgRIlRnPH/E
 MYGuDnQ1OSfqaR83t5EeSUdBkbJnVQY0g06vsayx63tth39gB5/cNN4KQW3p/o9Rdh2PF78/F8C
 j8XFHV0RTHbnrDnpWhFsSn5cpsw1ETLFJVenu
X-Google-Smtp-Source: AGHT+IGQRJw/Yd1phuU6scbBihTnR4lBY8zIRoLguMErIx1MxoFrHWZETe1fezHIY2wItMomqggbxVtUDd1SFQCqAvs=
X-Received: by 2002:ad4:588e:0:b0:6cb:ce41:20c1 with SMTP id
 6a1803df08f44-6cbce4120d1mr71880116d6.14.1728573008234; Thu, 10 Oct 2024
 08:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241007205543.1632499-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThjoOakb6FgrdkhvjAn1fL00wZeTGRewWUedqSO3E6+dQ@mail.gmail.com>
 <f5fe4549-645a-45d0-9869-fc1c6e355cb3@iopsys.eu>
In-Reply-To: <f5fe4549-645a-45d0-9869-fc1c6e355cb3@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Oct 2024 09:09:57 -0600
Message-ID: <CAFLszTjC99uGBu1LGf-x0n5j+DnjXneEg+By=Sr_NtOLJy-i4Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] net: tcp: improve tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Anand Moon <linux.amoon@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

On Wed, 9 Oct 2024 at 02:21, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Will try to fix spelling. Unfortunately my english is not very well.

Your English is fine and we don't normally worry about that sort of
thing too much. It's just that they looked like typos rather than
grammar, etc.

>
> On 09.10.2024 04:57, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Mon, 7 Oct 2024 at 14:55, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> U-Boot support of LWIP is not ready for a moment, but we already have
> >> some kind of tcp support. Unfrotunately this support is really bad.
> > spelling
> >
[..]


> >> Changes v10:
> >>  * netcat: fix bug appeared after rx/tx packet counter addition
> >>  * rebased on top of v2024.10
> > Is this series ready to go in?
>
> I think it's ready.

Regards,
Simon
