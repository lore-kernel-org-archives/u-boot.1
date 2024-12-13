Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D36DE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 05:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EC38018E;
	Fri, 13 Dec 2024 06:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aFuO7gly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1E980192; Fri, 13 Dec 2024 06:39:44 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBC680141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f27bbe8fc3so1642857b3.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734068381; x=1734673181; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77mErJjiuJVEQwIJPTBF+ooy+vKaKSPkSekdyN9Gq7U=;
 b=aFuO7glyS9MhpWzvrPJDpYrIKe8Yzs1xGDHl7n/qXRWp1zKvd+dbMzFjxiZ6IPilcA
 j2R8DFcOTKwJqd4oNoB7jmYfPK1uevWPadjc30r9jR7wZX1gM5p766esvOkQQcR+Oi13
 0013rt7lOUxiIlgrRm+lkqugc+fNIIM4fF879DZ/367cr87UCmc1nmHWrWYwUWdRPHtJ
 YM9VcIn2M7QriGM7kaHlsEIpOdt3v+cyvGicx4XNtHPYkYFzWBHgvSeJ9OIBsrY/l0N8
 Sf5jToGy5ODMCS7r9VPRwf3h9d/BR41nKW7cN8mewVBWdVIxNKGQUH4D8+toHAr5jsQE
 EsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734068381; x=1734673181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77mErJjiuJVEQwIJPTBF+ooy+vKaKSPkSekdyN9Gq7U=;
 b=SjT6u+n6by9/YBmmzDClM+CTJRYqdHjGtNOOBqVw5zGOPN4rkXUtuKUrw6BrYcWdkH
 fTH9227AutLm8a69KQQSqHTkb7lc9U2CI0SwNigQJGjhLghMWeCANuj2kqe5OCf1UKQ+
 lp4byo1M3B2CwyKYjhpZUMUF0fYVmsuBqZlsHflYkV9epFCFdfmRwI79T3Ixemf7QmgU
 kSwTuUt8hYOVWWrDXI80DaiSmeBTWyEycA3UH9hOFwIUW3rPxyGzmb4ARQRGUzAC58Am
 Pvstm5zmnK5/EJ1oJDtIfXMlM8myU0vwQ8Yls7JfvhctHkTY8CmNl9EvKTbwXlemIzUU
 ywAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRwqJ4VxLTJwGZdOb/zdCHG2PrXMQlfi39sB5sQhgRMED89Us+u8SoAL92LnuEGE6cl96lLiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7ZlHYW4+QqjvHNNTI2gP1AEo7VSSSru7DG7/BdzYyHQfhIRb2
 UrAEaqzYecgvL3aGBTaCDKTrAlIQo6hDsjTcI8eVY02OrQfje+8ylNYeH3C1kmpXEFKJuLscokq
 fETmc1sBEmpxBKzw/kGw685udAIv33L/tbvnciQ==
X-Gm-Gg: ASbGncvmGjDFrfzp5QZRXedEmLRDNkcivjMhkHwoAQ3YYri2O0Iy/P//a3v75Pl4hej
 buN0IhjbPvu7ygvUrQ+rwT7BPL5FCQcUYHXTXGQ==
X-Google-Smtp-Source: AGHT+IGoiDhEMxleDKC1Ql+uFBdGGEZJYWWB/+/EGqf6HosG3prOJ1CywPPfbnxX5vivmA4iBCHmazqRIEdpm0KrBAs=
X-Received: by 2002:a05:690c:600c:b0:6ef:91a0:dd25 with SMTP id
 00721157ae682-6f279affbf8mr13974927b3.17.1734068380740; Thu, 12 Dec 2024
 21:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20241211105504.453234-1-ilias.apalodimas@linaro.org>
 <20241211105504.453234-7-ilias.apalodimas@linaro.org>
 <CAPLW+4=9EfzWwYE_X+-AnZUwky6+MOF4V73BsqOaoMcMS+EGmQ@mail.gmail.com>
In-Reply-To: <CAPLW+4=9EfzWwYE_X+-AnZUwky6+MOF4V73BsqOaoMcMS+EGmQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 07:39:04 +0200
Message-ID: <CAC_iWjJiwzb=kWm+u_dESny-5hYQzAnBG75VgzJVwQ7dB0y6eQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] lmb: Remove lmb_alloc_addr_flags()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Fri, 13 Dec 2024 at 00:34, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Wed, Dec 11, 2024 at 4:55=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > lmb_alloc_addr() is just calling lmb_alloc_addr_flags() with LMB_NONE
> > There's not much we gain from this abstraction, so let's remove the
> > latter, add a flags argument to lmb_alloc_addr() and make the code a
> > bit easier to follow.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  fs/fs.c                     |  2 +-
> >  include/lmb.h               | 10 ++++------
> >  lib/efi_loader/efi_memory.c |  2 +-
> >  lib/lmb.c                   | 15 ++-------------
> >  test/lib/lmb.c              | 34 +++++++++++++++++-----------------
> >  5 files changed, 25 insertions(+), 38 deletions(-)
> >
> > diff --git a/fs/fs.c b/fs/fs.c
> > index 21a23efd932d..99ddcc5e37be 100644
> > --- a/fs/fs.c
> > +++ b/fs/fs.c
> > @@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char *filename, =
ulong addr, loff_t offset,
> >
> >         lmb_dump_all();
> >
> > -       if (lmb_alloc_addr(addr, read_len) =3D=3D addr)
> > +       if (lmb_alloc_addr(addr, read_len, LMB_NONE) =3D=3D addr)
> >                 return 0;
> >
> >         log_err("** Reading file would overwrite reserved memory **\n")=
;
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 3db35992df8d..5e59915340b7 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -92,7 +92,6 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, =
u32 flags);
> >
> >  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
> >  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t =
max_addr);
> > -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
> >  phys_size_t lmb_get_free_size(phys_addr_t addr);
> >
> >  /**
> > @@ -113,8 +112,8 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, =
ulong align,
> >                                  phys_addr_t max_addr, uint flags);
> >
> >  /**
> > - * lmb_alloc_addr_flags() - Allocate specified memory address with spe=
cified
> > - *                         attributes
> > + * lmb_alloc_addr() - Allocate specified memory address with specified=
 attributes
>
> One character over 80 limit trips my OCD :/ Any chance you can move
> "attributes" to the next line? It's ok to break the line in kernel-doc
> function briefs.
>
> > + *
> >   * @base: Base Address requested
> >   * @size: Size of the region requested
> >   * @flags: Memory region attributes to be set
> > @@ -125,8 +124,7 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size, =
ulong align,
> >   *
> >   * Return: Base address on success, 0 on error.
> >   */
> > -phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> > -                                uint flags);
> > +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, uint fl=
ags);
>
> Can we keep u32 for flags everywhere, for consistency?

We are, I thought it would make the patches easier to review if I only
changed the enum here.
This turns to a u32 in the last patch


>
> With above nitpicks addressed, feel free to add:
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

Thanks!
/Ilias

>
> [snip]
