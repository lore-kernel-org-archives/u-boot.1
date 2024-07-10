Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ECCC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 23:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D808871E;
	Thu, 11 Jul 2024 01:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="afB4OpuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365758872D; Thu, 11 Jul 2024 01:23:50 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA358871D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 01:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e02c4983bfaso274488276.2
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720653826; x=1721258626; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTXiWaaBXqAFy2Bj33U85w+pgUEQPyS/Tqf2hrBbFoE=;
 b=afB4OpuAeeiLpdnhEwkud6tJY/KYXK0tNU/9RWZzCtHAeSdzVYLUeBEsSdfB59Q3uX
 gnhIp4/5y8dm629u+EtV8bgop/4jK15ST0UcCVkfflRZ/TdQCz6NDaHeZ7UE+o/Je0bF
 IpH8ebxyLuzy05F9NQVZUy0lhBCTV6YZpfXUAlIBmMSNOqlH5o1Tw6TaTPXpssfpbe0j
 P1Iw9sQDbwfaigziq9Hn80ddEImQyJiqABdFR9egaG1qEjW9sybaiQ9X8hQtNH5KDB9A
 nS64CdiLzey1b3Dqk+6qToDySJOHP7vDKYcciQz1f2QKKCStYGgnbIQUQU4UcS/BRzdX
 eGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720653826; x=1721258626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTXiWaaBXqAFy2Bj33U85w+pgUEQPyS/Tqf2hrBbFoE=;
 b=Ee1HMKUvReD6T3wfUsoWV/6tpr/B+SlNjznOLeko84RI3ZlVr0gFTYgBgnBOPRgIqg
 15vumyuaO/b1zeuX+Mxei6MMNTojb/YlcZxAu2rm9655C+JW+hgAd+EHbv2xJkWQFtql
 HfRL2oNO5XZnZLK/dGUBdHbbGogL7O9YxCO3x55bN/Wx63HVq0xEJLnQYQgAFMnP5b5+
 i9sHGSkqgqpChWa0ZyCxcaFqWK4WgXsPudnZVkwVInTNz6fiUvE1wfRVChOLUTY15GOk
 EqzfPH8Npj6KkeevyD1TXxc5Q0BxirOGZCCgvVxtPGDmTzhcMwmEXRxyuLMZUmWnZjrw
 OsXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZg0guMXoOOCWC9YKVYVK14NRnSn/YIpkBbcvWZAaNBByEKyMGW45NGF7h9v5eaWqfdNFlQsRmfd59ga99qacrQHWwQ==
X-Gm-Message-State: AOJu0YxNoBI1SEPEB0mFRM6wpGKyiMDOiGtML5lrSHv7HkvKmmKFZJ8p
 /eGpa0ctp5MrMJmScCKBKrJVogSJJPLMZBUOk+lfA3E7j9wZN5HKzXzaSoVfYzYBaR/m+A7zCZb
 UucnxAtq1PbXdki78rave7wP7Z7w0r3qJOPRaiA==
X-Google-Smtp-Source: AGHT+IEls7os/pScl0b5Dj8NP0xQZoM6YCukEwYpCPLNm1Uaaifa65ztjc5LsT9OWqwJC7SYO5sRB1ZLPaoPNExp5S4=
X-Received: by 2002:a25:6911:0:b0:dfb:2ba4:91d with SMTP id
 3f1490d57ef6-e041b0965c0mr8069564276.17.1720653826507; Wed, 10 Jul 2024
 16:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112904.99969-1-mikhail.kshevetskiy@iopsys.eu>
 <CAPLW+4=n5B39=KnUma7=ZedAnX1FBiw1AtoRTnFO7UNfkecsJQ@mail.gmail.com>
In-Reply-To: <CAPLW+4=n5B39=KnUma7=ZedAnX1FBiw1AtoRTnFO7UNfkecsJQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jul 2024 18:23:35 -0500
Message-ID: <CAPLW+4m=3JSFRjf+ZjHHYRZhtBkZe7v3cRt+NothGJjJjvojxg@mail.gmail.com>
Subject: Re: [PATCH] gpt: allow spaces in partition list
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>, 
 u-boot@lists.denx.de, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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

On Tue, Jul 9, 2024 at 9:00=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> On Thu, Jun 27, 2024 at 6:29=E2=80=AFAM Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
> >
> > This allows spliting partition list to several lines in environment fil=
e
> >
> > ex:
> > --------------------
> > gpt_partition_list=3D
> >         name=3Dboot1,size=3D5MiB,start=3D0x100000;
> >         name=3Dboot2,size=3D5MiB;
> >         name=3Drootfs1,size=3D70MiB;
> >         name=3Drootfs2,size=3D70MiB;
> >         name=3Doverlay1,size=3D20MiB;
> >         name=3Doverlay2,size=3D20MiB;
> >         name=3Dart,size=3D4MiB;
> >
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > ---
>
> Feel free to add:
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> With this patch the next command succeeds, when having $partitions
> described in multi-line variable in .env file:
>
>     =3D> gpt verify mmc 0 "$partitions"
>
> I wonder if it makes sense to also change cmd_gen_envp command in
> Makefile to avoid adding spaces in place of newlines, in the first
> place? It would allow us to specify unbroken multi-line variables in
> .env, though I'm not sure if anyone actually relies on that behavior
> in their .env files.
>

Tom, can you please apply this one? I think it actually fixes this existing=
 env:

    board/sifive/unmatched/unmatched.env

which has multi-line $partitions definition in it. I'd also want to
keep $partitions in .env file (as opposed to .h) for E850-96 board in
my new series, which requires this patch to be applied as well.

Thanks!

> >  cmd/gpt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/cmd/gpt.c b/cmd/gpt.c
> > index 7aaf1889a5a..2b29ab98ccc 100644
> > --- a/cmd/gpt.c
> > +++ b/cmd/gpt.c
> > @@ -117,6 +117,7 @@ static char *extract_val(const char *str, const cha=
r *key)
> >                 k =3D strsep(&v, "=3D");
> >                 if (!k)
> >                         break;
> > +               k +=3D strspn(k, " \t");
> >                 if  (strcmp(k, key) =3D=3D 0) {
> >                         new =3D strdup(v);
> >                         break;
> > @@ -151,6 +152,7 @@ static bool found_key(const char *str, const char *=
key)
> >                 k =3D strsep(&s, ",");
> >                 if (!k)
> >                         break;
> > +               k +=3D strspn(k, " \t");
> >                 if  (strcmp(k, key) =3D=3D 0) {
> >                         result =3D true;
> >                         break;
> > --
> > 2.43.0
> >
