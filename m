Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC51EE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA3D80278;
	Tue, 10 Dec 2024 17:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GvI81bS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79CF8027E; Tue, 10 Dec 2024 17:17:13 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E75D680269
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e829ff44so5442581a12.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847430; x=1734452230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=waG5M+UtBF3/MCiVjxeHqiNp2Ahf4cyyRZHAV14zqjc=;
 b=GvI81bS4y6cWfiin/7UgfyWjmrXc40uO348cn3YePEpSBKjTKydN/isZQBkNE3Rkmf
 3SsuCeHGxwZ6uIVuE2PVC0QQkztxLcfTb3PKODadg+IhWS3cGH+6hR5PWF4jeXYjlspX
 xtmuO1yqFLXl3yEFAVKmXUb3BW3xUDm5UQmts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847430; x=1734452230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waG5M+UtBF3/MCiVjxeHqiNp2Ahf4cyyRZHAV14zqjc=;
 b=h3kJa8WEYozvofD7B4xrX8QuV1Dd0FaMiSqATXuTL0zDK7SHTNvOnaD5h0CnmswUqu
 t13lfOZNBJwD1hAaGPScC2lb90PyrKtvDilFHCqWcyi8dfXKPYILXsQDiIAcZ0HYm3EL
 f8Lh5zJH5kq6C/D/dDMLAPQ1cuS3ZPibM2XCijuRAbv1h/RIiBrOJZatng+hcqU8kslt
 jbkweBdiFe7g6U2vLEDCgjowUjT7dBqxHmWt35rWlaZ8iV6svNSp2yRK/HjlCfzT0lvs
 ZD22tyJDUQ+ZSiCF3ofwL/jYvmOXAjOu7GKAfIcE443zfFyPX01ifU/yWKq6mXfqXay2
 nO/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+oeOZ/YQXH2/HViYBPbxcx1SVmx6kuWLNgnNbt9i7UpO6IDQlD97x/XwAj84J2GFyuTEuW8c=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu3tA5AttnQjfLCAT5Ap9yyCMn3xcSgeT8B6c7ye5byL6PXbQu
 jdsClEnt6DYz45zZ3DzT+M2DCo5Hk0wRqcaPywTrVWino7WYQQjCrmalgtt35BSZ91DXPUhavmG
 FIFv10BMwPyHzagP06YjrPJrSMedjfLgi/OyG
X-Gm-Gg: ASbGncv6HsXm2GX6CJzC1Bncp9+R90WIJeTx7TIwaaJzOk2iBGpZU5wjiiJFGBG9zYx
 o0ddaLEN9vhuCpvXcT9oCYcm40R0hf4AmDHkN
X-Google-Smtp-Source: AGHT+IFYIEdvIwX953BIKEataIWCxvuXqI79gRhBR3jvQNFPBQDxFmrwoEBPBnatO6n/8qLe508//xlUkgR2vyCPCG8=
X-Received: by 2002:a17:906:9d2:b0:aa6:7b49:28fb with SMTP id
 a640c23a62f3a-aa6a00794e5mr450318566b.14.1733847430382; Tue, 10 Dec 2024
 08:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-4-sjg@chromium.org>
 <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
In-Reply-To: <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:16:57 -0700
Message-ID: <CAFLszTgDCAxiZBYkDVUUb4jWejry4wWKm4gyyNndLhBYQ+zfAg@mail.gmail.com>
Subject: Re: [PATCH 3/8] doc: test: Add docs and test for part_find
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>, 
 Wang Jie <dave.wang@rock-chips.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, 10 Dec 2024 at 01:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 09.12.24 17:27, Simon Glass wrote:
> > Add some documentation and a test for this new command.
>
> Shouldn't this be two patches?

Often we put the new command, its docs and tests in the same commit,
since the question I always ask when looking at a command is, where
are the docs and tests!

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   doc/usage/cmd/part_find.rst | 119 ++++++++++++++++++++++++++++++++++++
> >   doc/usage/index.rst         |   1 +
> >   test/cmd/Makefile           |   1 +
> >   test/cmd/part_find.c        |  42 +++++++++++++
> >   4 files changed, 163 insertions(+)
> >   create mode 100644 doc/usage/cmd/part_find.rst
> >   create mode 100644 test/cmd/part_find.c
> >
> > diff --git a/doc/usage/cmd/part_find.rst b/doc/usage/cmd/part_find.rst
> > new file mode 100644
> > index 00000000000..fd5bd6578d5
> > --- /dev/null
> > +++ b/doc/usage/cmd/part_find.rst
> > @@ -0,0 +1,119 @@
> > +.. SPDX-License-Identifier: GPL-2.0+:
>
> This is not a valid SPDX identifier.
> Cf. https://spdx.org/licenses/GPL-2.0-or-later.html

I have seen this point made a few times, but I'm afraid I still don't
fully understand it:

The Licenses/README lists the licenses and GPL-2.0+ appears in there.
In the source tree:

$ git grep GPL-2.0+ |wc -l
13406
$ git grep GPL-2.0-or-later |wc -l
1847

I have to say I much prefer GPL-2.0+ as it is easier to remember.

But if we are planning to change, could you update checkpatch to throw
a warning?

Regards,
SImon
