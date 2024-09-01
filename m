Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388FFC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D4F88A02;
	Sun,  1 Sep 2024 22:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZVN6Thf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF27889A2; Sun,  1 Sep 2024 22:09:57 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91BEA88A13
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c331543ef0so20243616d6.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221394; x=1725826194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NhwNPKnRGlgu2EMiEh3GB6mP7uVhaSRMZTpv157/qVg=;
 b=GZVN6ThfIsR98k16lSSK3jVLf+fISEY0sCEmy/D6NBh/c2NvHTdxQWv5VMz7uCrGV4
 nC05+5BOeFy3VBfNs5mI1L4pyMt2C7uyb5kiZtv9wwoUKfZBlgd278xwAyzwyCvqN/+L
 Vtq+uW1b5kMEGAtmJKiA+RjlHDNmtx+7B9x/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221394; x=1725826194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NhwNPKnRGlgu2EMiEh3GB6mP7uVhaSRMZTpv157/qVg=;
 b=DeQV99xn4ZsaoiIs28mjml73VRepe2rj7s4GiJYWMX7oUDogSW2drJnlBuF5uYYtiv
 JxWskk//060YDI18afnBGmCsG9678NZtp6QRQ4rq4c7ok81jVTcJCJO0vuzWPVF77mjE
 9KqlodjVwmHqBHJcpassW/iRGXHu/JctI1NwbzpIZkWNXBmtzzpJxX/bvGveinukIYX2
 I6i2QpR4zT6WIDtREYdk4zbBYGlkq+agRzCK/MBqZwalG5P1fIRjmeeG2LsKBuwwLyEa
 LCGTNsNa+9uTazC4f1h0OUUDlBKrD8ReF2QA4Th6uZYbE7hEsHUcnWSxjnAspx9F7+oS
 HseQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWipeYHtJmoKMt3h858mkrmNeBHrh8UTVVhv21V6c1+afnW5nGZe1syYycyHhlNGTcFOAIifyQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy98B7BbdU8gUX/26TyX+qL4QXDEtUZJsNY+cXbsq0W8YmMHnVf
 KYOGIH2RSfT5IftwWasD0rCWbU41C4zfbhAOJsC6aCngTGuZydf9vpe94LCcXzXQS8Ro/xit90X
 fxeODQHez0fUE5HxTI4pnIy6PZ+4983bfF43QCq0jCaOy/CY=
X-Google-Smtp-Source: AGHT+IEI8A418r84VXVbTMv67jJfn/epOYK+wWjg1VT2m/Bq6aHcQtpkhILSuzLhyCLDkKpmCFj4GqZnuqY/ZPdraes=
X-Received: by 2002:a05:6214:418b:b0:6bf:8971:1320 with SMTP id
 6a1803df08f44-6c3553f3dc1mr55921686d6.18.1725221394457; Sun, 01 Sep 2024
 13:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
 <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
 <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:43 -0600
Message-ID: <CAFLszTh-5o8hEv47+jb2od=xQxMhjOGpG0qC_PjL5XkLx5nM2w@mail.gmail.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
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

Hi Ilias,

On Fri, 30 Aug 2024 at 03:27, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 30 Aug 2024 at 03:59, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Jerome,
> >
> > On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > >
> > >
> > > On 8/29/24 16:05, Simon Glass wrote:
> > > > Hi Jerome,
> > > >
> > > > On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> > > > <jerome.forissier@linaro.org> wrote:
> > > >>
> > > >> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
> > > >> NET_LWIP so default to NET in this case.
> > > >
> > > > Sandbox needs to support NET_LWIP.
> > >
> > > I agree in principle, but AFAICT it is not a trivial task. Does it have to
> > > be done in this series or can it be dealt with later?
> >
> > Does it build OK with sandbox? We use it for almost all of our feature
> > development and testing, so I cannot imagine bringing this in if it
> > doesn't work. How did you develop this feature?
>
> sandbox is deeply rooted into the old network stack. It fakes ACK
> responses, handles the ping request/replies with the sandbox ethernet
> driver etc. I was looking on adding LWIP support for it, but it's not
> trivial and I don't want us to add another hacky 'glue layer'. Since
> LWIP is a big feature on its own -- and is working on real hardware
> and QEMU, we discussed adding it, so people can test and contribute
> fixes while we fix sandbox.

At the very least it needs to build on sandbox.

I am not sure what tests LWIP has. The U-Boot networking tests are
very simple on sandbox. The test provides a handler to generate a
packet that it wants, then does a networking operation. It should not
be hard to plumb that through.

I am nervous about this going in with an intention to fix it up later...

>
> >
> > >
> > > I would need to look into this more closely to give details, but if I
> > > remember correctly the sandbox tests expect a precise sequence of network
> > > packets. For example when doing a TFTP tests, it expects an ARP packet to
> > > go out first, but when lwIP is used the ARP might not go out because the IP
> > > may already be in the cache. So the sandbox is definitely not a black box
> > > in that respect which makes things a bit more difficult.
> >
> > The key thing is to have a way to reset the state. So long as you have
> > that, you should be able to put networking back to the initial state
> > before running a test.

Regards,
Simon
