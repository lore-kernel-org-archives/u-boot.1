Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD883C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 16:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDCC686CF7;
	Wed,  6 Dec 2023 17:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m73kPTvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D9286C72; Wed,  6 Dec 2023 17:03:53 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13EFF870F8
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 17:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c9c18e7990so98511591fa.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701878630; x=1702483430; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=27QkL0Qlhem16i+05liv9a56kuG9xai4sy8ElItT79A=;
 b=m73kPTvBr40fmCF5qDs54IzgxxC4VaTi5TYcb4Cq01VQ/N0MK85ND8mtNU/EIfqlja
 31J+9wc5FIt4mgQF6UR0hhyW1vsjaqPa7Ih1rgj4FZdw8DNeS+V04BNFYecdLRDJkMPv
 qggIemdfDNhdLC0zJQsQl/IWRZ9BCiuQ4gs5Pz5ig536XCTz5eBrPiNo1hTE0x0YjEE4
 eU4bbKSVXwQy53ln5ziVxFdQMseuf6ZqMcDAHuZ/80AiitifuSoRHqOdX9sMUkiWfaey
 PVgZXBb2sRfenrGfODJZCjyqeTJErIy/ZrQXdnYfFlcnTC9gr25Nk8XndiDcL+iKf7kJ
 C0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701878630; x=1702483430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=27QkL0Qlhem16i+05liv9a56kuG9xai4sy8ElItT79A=;
 b=rWiWeV8v/ici5O7NzGi8YlMiXFIXqzGU0zK7s7TqSD9XX6ZNn98SESsI/Igj3nKcJ8
 NOjMmdjPbe9H288Ggk322Ldg0IRkeMI9tgrLz3vhjd1Bzh2vXVWHzIqPXW3irH+w7DNC
 P+ymmUYlWXwAOWWkvXQe+TxyS/xY9299JkC91Hss0vqDLs6Km5gb1/2v4FDnirBgJXBI
 Yl4nzdBndLJEoqGNv9RM/MCxNJQ3Uf9UqbzihCe3RExXDkrzVnssACoZyKZZDoN4L31O
 EO+4YETfxdOeomHIC4qTw1Y6lgD4WF5HBtStFRSmNGV/CWAtllDbol+tFaH03ZTpi4cZ
 HC/g==
X-Gm-Message-State: AOJu0YxW9Iv0J/kjmPbFxtTI96YTgrq1FH6nT/ycYBkbRL2VGLBtLTjn
 6OWXeyyVv8YurokG286PbMkigW2wzUSURvDv97xf26MuiFCBd1z1D0g=
X-Google-Smtp-Source: AGHT+IEqRXcjBsdWYlNZbU2ClH8gtQPa8aleQqiMUc1+Vy60LodOkhyu7O5wpN9xRnX+iN0E9nfnhMIY/TSq7mw/JNU=
X-Received: by 2002:a05:651c:204:b0:2ca:d4c:14d4 with SMTP id
 y4-20020a05651c020400b002ca0d4c14d4mr755967ljn.97.1701878630162; Wed, 06 Dec
 2023 08:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 18:03:14 +0200
Message-ID: <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Simon,

On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > [...]
> >
> >> > Changes since v1:
> >> > - Tokenize the DT node entry and use the appropriate value instead of
> >> >   the entire string
> >> > - Removed Peters tested/reviewed-by tags due to the above
> >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >> >
> >>
> >> Can this be put behind a Kconfig? It adds quite a bit of code which
> >> punishes those boards which do the right thing.
> >
> >
> > Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
> >
> >>
> >> > +
> >> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
> >>
> >> Could this use ofnode_read_string_index() ?
> >
> >
> > Maybe, I'll have a look and change it if that works

Unless I am missing something this doesn't work.
This is designed to return a string index from a DT property that's defined as
foo_property = "value1", "value2" isn't it?

The code above is trying to read an existing property (e.g compatible)
and get the string after the comma delimiter.
Perhaps I should add this in drivers/core/ofnode.c instead?

> >
> > [...]
> >
> >>
> >> Any chance of a test for this code?
> >
> >
> > Sure, but any suggestions on where to add the test?
> > SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?
>
> They are written on startup, right? They should certainly be in place
> before U-Boot enters the command line.

Not always.  I am not sure if x86 does that, but on the rest of the
architectures, they are only initialized when the efi smbios code
runs. Wasn't this something you were trying to change?

>
> > Any other ideas?
>
> Probably a test in test/lib/ would work. We actually have
> smbios-parser.c which might help?

That doesn't seem too helpful either. But I can add a test in
test/dm/ofnode.c if we move the parsing function to ofnode.c. The
generic SMBIOS tests can be added when the SMBIOS code is refactored.

Regards
/Ilias
>
> Regards,
> Simon
