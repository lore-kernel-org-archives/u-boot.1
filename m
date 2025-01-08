Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F07DE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015DF801E8;
	Wed,  8 Jan 2025 08:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K7YUKNMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 014EF803DC; Wed,  8 Jan 2025 08:12:50 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E1A8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e537d9e3d75so24556498276.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736320365; x=1736925165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+D6kt4Ul6nIRN6uH/g4ZgVP8PIiBQvIfHUz9LfNHleU=;
 b=K7YUKNMzxiYlk69uPuUYvinfNWb4nLqSIzl7Poc7syIGVANV5BU0DNRgFzmGMV14ty
 hndT1G2R/se618bVcNygJH01cIHO49oQVz8X9Fu0hYuwSsg1vd/2wVJt63dw+ySdmEAV
 URHocLAXqLM1DG5OyapZ2pqelgbPOMlzLdY7YccPLMwu2lD5H7tqmTyY8ZD8cNY7/QYb
 DZndn1ov7mcP9yxYyl5jZTz8yjv9obMv1zy9S9jyn2t59ODrXQWL85OFDmnvNzlAReg5
 94cGjg6RDwHG+1+2z59cX5WbB3s/RxtLW8qlmB1hYFt3qjzbTn4axBmrc2+mKDgIehN6
 rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736320365; x=1736925165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+D6kt4Ul6nIRN6uH/g4ZgVP8PIiBQvIfHUz9LfNHleU=;
 b=C8OuMgeuv3y7ks3NHrl2/vKEnK8Rec3StOustuQKQFCSq6uZVQ6LCXD0mATY/nPQQ7
 z3Pz5Qqm8JyEuo8yJarHoVKrt2hANBpOLX/iq6zipYnnREWYHSsuvDWlR5X+xYEDl9bG
 jUR0w43KtIw0aCsIfzu+V5aSYzlT/C6utp+SiJqDoLZaPkSgkaBUXIgwHO5wUms0b/uJ
 slDrP951DDB31/qBROajB9g1ponbUVHoIP1oYOt+6rZJNW/k8WWlq3ZZCtCx6YSf2ijZ
 Rr074KsAKs9mlo1JAXcW0SZ+U6ybtY1SGPGHr3hJakv8O00nUTvtttCXxI0ljdP668aC
 bfgg==
X-Gm-Message-State: AOJu0YxtIMdiCxo7EDrej33bqP8VY75cTETqTWPhjjvIlB0kD5BcMBvF
 35hN7Bf5S9o3QQC11A2hod7hmGxcxXnYXS9D4r/sSR/C5xrBV1XlKsSopLpGJpRJLfe6L3CAAr3
 5UYLHYf2WFtjPmAuteEJ+i6WClC2bAN6BxnVm3wPoq9IyRwum
X-Gm-Gg: ASbGncuf42npbF/SDQHzpq0hX3RPkzkPtlJ4i4TYDv3z+hO6j/b77nunqN2tj/Ui+Se
 qb4DLdToJvjYRmXo3YSsuRtqiQNdPPIVI6kqcJQ==
X-Google-Smtp-Source: AGHT+IHeHwlG3VX/RYogC3YY7N7zpqTcEL9j+m3280GBmdAuGJE0b11ttiSfLL2sZ4QMa4ZhWjzLJqIzg8q6LpvtZKU=
X-Received: by 2002:a25:1e45:0:b0:e3c:9548:e92d with SMTP id
 3f1490d57ef6-e54edf0b337mr933062276.5.1736320365352; Tue, 07 Jan 2025
 23:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-3-sjg@chromium.org>
 <CAC_iWjLrSEpHgTGK3WhHTGQ-SF5Zg6o_h14x++ot8FD+JAm3RA@mail.gmail.com>
 <CAFLszTjaeMimD_0HczGXxJUhjDjP+-TjT6RdfW5XOzBFhg+hkQ@mail.gmail.com>
In-Reply-To: <CAFLszTjaeMimD_0HczGXxJUhjDjP+-TjT6RdfW5XOzBFhg+hkQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Jan 2025 09:12:09 +0200
X-Gm-Features: AbW1kvacuKfrW3sVMUnu6G9Gn_W-_NdAuwxpHmgAoHAjRLDENwcBFJslhDtCawc
Message-ID: <CAC_iWjLp3Yrr35CJLvZKM9nLS0X8PtOn7nQs205MZ69kO5R2CQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] efi_loader: Fix display of addresses in log
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, 7 Jan 2025 at 15:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Tue, 7 Jan 2025 at 06:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The allocate/free-pages functions return an address, so there is no need
> > > to convert it. Fix this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Fixes: c824a96d76d ("efi_loader: Use the log with memory-related...")
> >
> > I can't find that commit in -master. Is there anything I am missing?
>
> Sort-of. You, Tom and Heinrich NAKed this series. See [1]

Ok, please don't cc me on patches that are not destined for master or
next. I have no interest in out-of-tree work


Thanks
/Ilias
>
> > >  lib/efi_loader/efi_log.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
> > > index 4b9c6727fe7..ad490bb431c 100644
> > > --- a/lib/efi_loader/efi_log.c
> > > +++ b/lib/efi_loader/efi_log.c
> > > @@ -340,8 +340,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
> > >                 show_ulong("pgs", (ulong)rec->pages);
> > >                 show_addr("mem", (ulong)rec->memory);
> > >                 if (rec_hdr->ended) {
> > > -                       show_addr("*mem",
> > > -                                 (ulong)map_to_sysmem((void *)rec->e_memory));
> > > +                       show_addr("*mem", rec->e_memory);
> > >                         show_ret(rec_hdr->e_ret);
> > >                 }
> > >                 break;
> > > @@ -349,7 +348,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
> > >         case EFILT_FREE_PAGES: {
> > >                 struct efil_free_pages *rec = start;
> > >
> > > -               show_addr("mem", map_to_sysmem((void *)rec->memory));
> > > +               show_addr("mem", rec->memory);
> > >                 show_ulong("pag", (ulong)rec->pages);
> > >                 if (rec_hdr->ended)
> > >                         show_ret(rec_hdr->e_ret);
> > > --
> > > 2.34.1
> > >
>
> Regards,
> Simon
>
> [1] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
