Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17300C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C81487A38;
	Thu, 28 Dec 2023 14:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IuNdV1WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBB7D87A5D; Thu, 28 Dec 2023 14:37:35 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7C987A4F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d9b51093a0so2587028b3a.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770652; x=1704375452; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4h6Ct6wEZmIecpLrohq6KLKUR9Dfq5y0To8dEa80jA=;
 b=IuNdV1WNKPDuj/U+JcvGFzNFQXB1wuR65sseB+voloRy0I/dwfg04nbChZ9eQfE1WO
 wpEQUrnLPIhRqn8qNlcS/j6A0XdArtqHwlY8eJyZ9ycQfIdvHvV3O35MwQud9mM89AmY
 Xvpv0Rt9iEXn5z+N/aXES6GGNJNnqAfU9YbYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770652; x=1704375452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4h6Ct6wEZmIecpLrohq6KLKUR9Dfq5y0To8dEa80jA=;
 b=Bu9zLUSXLaqIEU3Fclzg0RlSKrHqeJs0JQ4Rowcq8Ssq6RN60102G/WsMpA/Jt0y7m
 /xULfGiC+i57jiZF6fO+G2Nh4g4my20CH5b6UY3JBgIlhv5t4xv+S96Eo3bfLmFisbjl
 Cues3zRHQetnhQ+LdYlHApMLTeisixYhvglAYnvLzofyQWzQH8GqOkUmTB/6l+HL3Va7
 hATavZqo9q+Q7Rx3LTlWL8igdR43w+nXIJneDWq2kwAKJn1/mdGra9T/BltXlal13qdD
 F2c2ZjXRjGkyyr3zFBR3loUKYdexe8oMzKgsk1bz05XPSYQhzBcdJDw2vh3gDfc7Aue4
 0+rg==
X-Gm-Message-State: AOJu0YxtDU3YjgJNNlhA6TZ4D84w1KgkT0kGx2h4CaNCyGgTEbKRo5nA
 zmI0NNi1foPA/03FN3Gxr8NiqsqtoCcSqUaoEw9F/TznGW4rBspN4HWQVWM=
X-Google-Smtp-Source: AGHT+IGcWPc7uesaR1SPbcb8oQtMpS2h/PE0R2nglKeShB68uWZ4r0EuY0sL8kCizapejZZhdPYsThW0BihA8vKOp6o=
X-Received: by 2002:a05:6a20:8f01:b0:196:4d6a:c88e with SMTP id
 b1-20020a056a208f0100b001964d6ac88emr954825pzk.23.1703770651892; Thu, 28 Dec
 2023 05:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
 <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
In-Reply-To: <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:19 +0000
Message-ID: <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] smbios: Require the caller to align the SMBIOS
 table
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Ilias,

On Wed, Dec 27, 2023 at 11:12=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> I commented on v3 as well, but in case you miss that
>
> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> >
> > All callers handle this alignment, so drop the unnecessary code. This
> > simplifies things a little.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >
> > (no changes since v1)
> >
> >  include/smbios.h | 5 +----
> >  lib/smbios.c     | 2 --
> >  2 files changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index 77be58887a2..879b8a814b8 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *table,=
 int type,
> >   *
> >   * This writes SMBIOS table at a given address.
> >   *
> > - * @addr:      start address to write SMBIOS table. If this is not
> > - *             16-byte-aligned then it will be aligned before the tabl=
e is
> > - *             written.
> > + * @addr:      start address to write SMBIOS table (must be 16-byte-al=
igned)
> >   * Return:     end address of SMBIOS table (and start address for next=
 entry)
> >   *             or NULL in case of an error
> > - *
> >   */
> >  ulong write_smbios_table(ulong addr);
> >
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index 7f79d969c92..cfd451e4088 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
> >                 ctx.dev =3D NULL;
> >         }
> >
> > -       /* 16 byte align the table address */
> > -       addr =3D ALIGN(addr, 16);
>
> I think this is wrong.  It will break SMBIOS on a user error. I am
> fine replacing that with a check instead and error out if the address
> is not 16b aligned

Well this is why the comment says it must be aligned. This function is
not called willy nilly, from code we control. Checking for alignment
at runtime creates confusion and adds to code size.

>
> Thanks
> /Ilias
> >         start_addr =3D addr;
> >
> >         /*
> > --
> > 2.34.1
> >

Regards,
Simon
