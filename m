Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A996C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE738818C;
	Mon, 15 Apr 2024 16:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oGfM5UD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0AB88818C; Mon, 15 Apr 2024 16:00:33 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7A288152
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a51a7d4466bso371436966b.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713189628; x=1713794428;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8U+JGz4G+rEfysvtgsBdJsRtzRm3UVU2jrUxrg9QHU=;
 b=oGfM5UD6tbMxrGRQLXhM257MTgAdNlyhOBXcLracIBZRstE270UpGd7OuFu1bwJHQO
 qBJPfBL7xjKigQFzRjSi+1qqLl3iZdgOZKJfGG2Xd6sdEhfB4Q2xEPGepxNd7+a+/Cb0
 lavtKzo0o5DJJHdaOUZNASRShsWtKGqR02CT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713189628; x=1713794428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A8U+JGz4G+rEfysvtgsBdJsRtzRm3UVU2jrUxrg9QHU=;
 b=K1npdGPnqvEMsp4lmQUFU5ztEYMJI1mSnojf+zZCYeCqvUQ8XKQzEUY0sHzMt6fedc
 ZWqpPXQxwBkkFq7dIgcge0oPvF5bMpYjwMjWvwEbKJpI1u6NM2vtHTFd6d/IYCIEjgCg
 ZZc06GfuT3MdT10qmypK6f1yJHheWykEkjbrxRmvtog2AvS5jqKkWessHDCSxfkeZGaE
 mC+TfbjdasOlwTKWhBAurkqmCU+abkVi1XnbHkgSFfmTq7ohE8sfdGbDLD50bTz5A/tl
 +zSA3DbGQa/FHiCPgcqhvKwe0YWByc6LHpMvBBflTR0D8v46yLBkVtGXvVEF6EPJ3WjW
 GtTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdo2wi2xpNrvySfOlht7vIwL1nHnpL4ZreNIkJuY8+dTbcI0b8M5C57BxSEABmO/SoF1+qLWzaLYZPvoxiE9QFGbM3Tw==
X-Gm-Message-State: AOJu0YwKq7u5Dn3bsFcd8kMCczOSS65UNVaOPFG1VoaJ9VjAmEe47Hcl
 B2x95pBGWf7RZQJ80GP7XPyePlh73FYjqFqLT5WFFJ7vgWwgH2xdQmLLagLbNEz/PGcNZOjO1Kb
 i3CCOEiBdOwOu9AdmtDcmXzfUsu3MdxrIAQTOEg==
X-Google-Smtp-Source: AGHT+IFAxvJw/wBQRkud1Cg+yPp4/6TEE5ZFoOa+TBCNEkcVvis6+re77HwJ/YnwOdNEzaMOPLDuUFIeXoQ3+I7InJs=
X-Received: by 2002:a17:906:7145:b0:a52:8a8a:593a with SMTP id
 z5-20020a170906714500b00a528a8a593amr1136823ejj.2.1713189627883; Mon, 15 Apr
 2024 07:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
 <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
 <CALu9rSZeZYyuCwBeUgR+sxMvmqDBh+Q5hyb-gtHP0U8ovHby_g@mail.gmail.com>
 <CAOf5uwmqeMKKyf6-vxOnUMisHNZ24TupMRd_M-QT4JdtpnaFjQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmqeMKKyf6-vxOnUMisHNZ24TupMRd_M-QT4JdtpnaFjQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 15 Apr 2024 16:00:17 +0200
Message-ID: <CAOf5uwkQaYebNtGP4iuuVMkEQaK9BTjYM=32KTRyfKmDRYzVEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

Hi

On Mon, Apr 15, 2024 at 3:55=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Mon, Apr 15, 2024 at 3:48=E2=80=AFPM Yasuharu Shibata
> <yasuharu.shibata@gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On Mon, 15 Apr 2024 at 22:03, Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > I think I have sent some time ago ;)
> > >
> > > Anyway look sane. I was having the same feeling on code inspection
> > >
> > > Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > Thank you for your review.
> > I already checked the thread, sorry I couldn't find your patch and
> > I couldn't see whether it is the same.
> > In any case, I consider there is a potential issue about
> > wrap around, so I submitted a patch.
> >
>
> Very good job ;) to fix it. Just add Suggest-by: ;)
>

https://lore.kernel.org/all/CAOMZO5AO5X3aHR0AyriijYa309USuA0HJ6oKrHTqQvhW7i=
8i9g@mail.gmail.com/T/

Mine was here

Michael

> Michael
>
> > --
> > Best regards,
> > Yasuharu Shibata
>
>
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
