Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6235CE7716A
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 00:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21CF8005B;
	Mon, 16 Dec 2024 01:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bhelqY/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBBB80092; Mon, 16 Dec 2024 01:29:18 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53DF180050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 01:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso725810566b.1
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734308956; x=1734913756; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LgkJrNd+rsHJPuAFI0Z6fU0xV5y1WOO5onUHpcDP/Wk=;
 b=bhelqY/RdE2TfQKblS3//e0Qp/aMPRFYsVAUs9aMTbJWZRnA2MUM/ojn88YlAbDo3S
 Ee2VE2yvGjZEz2FK9bla02wNwvAshJ0NzUhE4tLPdGV4Ns3HLlrSzl7RMaTapPY4KJID
 /rJcw/i4rE4F/nabwBcJAG5VQLj4+6iH79scI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734308956; x=1734913756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LgkJrNd+rsHJPuAFI0Z6fU0xV5y1WOO5onUHpcDP/Wk=;
 b=GKpu+dpDP55Pfsl8f/E0mZ52kIr+it0dGV8EcrKDRqjtrycJfQPXAI1cyMP68tHZL5
 Iq0b7bB4XF36Q4NqOqdgMdTj1rlJ5PkLxQ8M43Fv9NGqANyRcCzix72Pj9UYXL+fbBLt
 h75S1pgAreI/iLowpVgYuO2s6QbIixHHym6fGxBqzUN8kmKtRKPo0fpRPpg5/OWv+Fsl
 2YYbJ675tQFF5kcoCaa0LVdL5Y15WyWIdXdtNtrWdLsuumM0p37eD+eLtwaLyKUuJsQU
 QnRrY2Xx11AG2Go48CQzjKtK02xr4MgPYXILFwY3tr2b9cBg3ntCpjT3gaczMacvMhei
 P7Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX7B1t4ysyURqfLOBChvbv55L4qcDINczAe4mnMN+09+QSOvuT5E/sIEv9a2HWWzZimHCM9uI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7/Uli35esxgTwYwDkX4vCYxCE30BPL+KMEyVFM9AhduTTbDO+
 v6umS4DRFRSRun1UJdhHOwOmv/pJjghY0qfcnJL0p6M6P6mt7zdUn1nDevRreqfIpDz4offJAkW
 WbvSLiFkgtl+8qIDU62YPIAuyay6Kbe7OhgvZ
X-Gm-Gg: ASbGncuIo33lYa3HY6Yfis7bFJsjsLaU5+Bk/ntOlAps2yOMr31n1RkKWjRtDcSSX9S
 175kGcEgdhR65hcIwcrJE8HSFgZZtmsou7kL2koeqNry7jQBR1fB7s0pmJvR0dEN2WFOwwZY=
X-Google-Smtp-Source: AGHT+IEyh4fOlITDpxzHNLI/aiyUF0+mzy0K2p+a8T/V63EXmRlhgI+nBosHpWeHTeEKESw0Xj6HjuCt2ciq0VumoEA=
X-Received: by 2002:a17:907:c22:b0:aa6:85d0:1492 with SMTP id
 a640c23a62f3a-aab77e97095mr866176866b.37.1734308955842; Sun, 15 Dec 2024
 16:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-4-sjg@chromium.org>
 <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
 <CAFLszTgDCAxiZBYkDVUUb4jWejry4wWKm4gyyNndLhBYQ+zfAg@mail.gmail.com>
 <20241210170856.GC2457179@bill-the-cat>
In-Reply-To: <20241210170856.GC2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 17:29:04 -0700
Message-ID: <CAFLszThPgtngJM16oCcOD1oCJNzpdn7We0=OB6E41XRHokxDuA@mail.gmail.com>
Subject: Re: [PATCH 3/8] doc: test: Add docs and test for part_find
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 10 Dec 2024 at 10:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 10, 2024 at 09:16:57AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 10 Dec 2024 at 01:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 09.12.24 17:27, Simon Glass wrote:
> > > > Add some documentation and a test for this new command.
> > >
> > > Shouldn't this be two patches?
> >
> > Often we put the new command, its docs and tests in the same commit,
> > since the question I always ask when looking at a command is, where
> > are the docs and tests!
> >
> > >
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >   doc/usage/cmd/part_find.rst | 119 ++++++++++++++++++++++++++++++++++++
> > > >   doc/usage/index.rst         |   1 +
> > > >   test/cmd/Makefile           |   1 +
> > > >   test/cmd/part_find.c        |  42 +++++++++++++
> > > >   4 files changed, 163 insertions(+)
> > > >   create mode 100644 doc/usage/cmd/part_find.rst
> > > >   create mode 100644 test/cmd/part_find.c
> > > >
> > > > diff --git a/doc/usage/cmd/part_find.rst b/doc/usage/cmd/part_find.rst
> > > > new file mode 100644
> > > > index 00000000000..fd5bd6578d5
> > > > --- /dev/null
> > > > +++ b/doc/usage/cmd/part_find.rst
> > > > @@ -0,0 +1,119 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0+:
> > >
> > > This is not a valid SPDX identifier.
> > > Cf. https://spdx.org/licenses/GPL-2.0-or-later.html
> >
> > I have seen this point made a few times, but I'm afraid I still don't
> > fully understand it:
> >
> > The Licenses/README lists the licenses and GPL-2.0+ appears in there.
> > In the source tree:
> >
> > $ git grep GPL-2.0+ |wc -l
> > 13406
> > $ git grep GPL-2.0-or-later |wc -l
> > 1847
> >
> > I have to say I much prefer GPL-2.0+ as it is easier to remember.
> >
> > But if we are planning to change, could you update checkpatch to throw
> > a warning?
>
> As I've said before too, GPL-2.0+ is deprecated by SPDX and
> GPL-2.0-or-later is the correct tag. But we aren't, sadly, right now a
> best practices example for SPDX anyhow and so it's not a deal breaker to
> use the old tag, just something that should be avoided.

OK, I will try to remember this.

At minimum, if this is important, Licenses/README should be updated to
drop the old license?

Heinrich, please update checkpatch to warn about this.

Regards,
Simon
