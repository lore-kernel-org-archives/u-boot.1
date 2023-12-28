Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E937C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 19:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E8A87A5F;
	Thu, 28 Dec 2023 20:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SR97H9Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827D387A7F; Thu, 28 Dec 2023 20:48:18 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6001D87A53
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 20:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f85fe5632so45414936d6.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703792895; x=1704397695; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TM0f89if0T9TXrSbNg9LTy6+LRjytVD8rCrafPCdzo=;
 b=SR97H9MlCykIlFZpD6XxLwuUobZli/8Cr5TeumQ2sosjdivIhMQc4dyXtfbgVGSu5Q
 getuX/Cp5wu9GRZ0apfT6JrBN2o8VjFOoye/iMv8cyWxaPgLSnjTz8f4f6mTgrOo8kWp
 mSbPxoXfLIdS3y13uQgvWMqjCLg83nEMfBgAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703792895; x=1704397695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TM0f89if0T9TXrSbNg9LTy6+LRjytVD8rCrafPCdzo=;
 b=MTNqMjZq60YPoG6wh5a4SRkXJ8CwAu76YCQAI9VkccGejWEK2UKga35pzTTwr8CZXX
 AEoNYB2dA3L4eTpH8zQQRGR0fU+pt1g2/m8rfAUhWpr/jSIOLJgh+LrDPu8ClQk5wbYJ
 UqSFnhwZvWS8GbI6kkeNkaigNHPcR3PH2D/TABUpzRtLKTUF/5KHYy9NDtj5IlI80/CK
 uWE5AEDb3PgLu1rsingoT0/qHZnh80rKrdrn1tdAHiD4Ls5POets+PuS5nIG5CI1xpDx
 V57v5jsVftSowGdVW1yXqSK6G+IKvuCqbq3dPfi3P/1Hd0uCNZPBRoj9L3qta4lRq37A
 qMfQ==
X-Gm-Message-State: AOJu0YwY/2rRUtXsQAdT+hLye1TVIBioXAd43HSHJ05GdUqMbHzYLqf6
 j/SufkhTJGBQInmlwhkZxY0Tg4guW57/GW259tj5BRCHqcbz
X-Google-Smtp-Source: AGHT+IGV1J/7RTKeHPL0iZyJut5l+fE+QaCKxmSsezRAXGeqPD/zwAco8oWau10jiu8UdKExGJLLXEMo6r6p0F1Kwt8=
X-Received: by 2002:ad4:5d47:0:b0:67f:4833:2168 with SMTP id
 jk7-20020ad45d47000000b0067f48332168mr21198928qvb.32.1703792894837; Thu, 28
 Dec 2023 11:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
 <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
 <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
 <690A2210-C523-4A53-8E1A-DF565F183630@gmx.de>
In-Reply-To: <690A2210-C523-4A53-8E1A-DF565F183630@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 19:48:04 +0000
Message-ID: <CAFLszTgxgJM9xm_-RXG64SD0jsg5cRh=OVOVfgy=23Wu0hZ8Yw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] smbios: Require the caller to align the SMBIOS
 table
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Heinrich,

On Thu, Dec 28, 2023 at 5:36=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
>
>
> Am 28. Dezember 2023 14:37:19 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Ilias,
> >
> >On Wed, Dec 27, 2023 at 11:12=E2=80=AFAM Ilias Apalodimas
> ><ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> I commented on v3 as well, but in case you miss that
> >>
> >> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> >> >
> >> > All callers handle this alignment, so drop the unnecessary code. Thi=
s
> >> > simplifies things a little.
> >> >
> >> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> > ---
> >> >
> >> > (no changes since v1)
> >> >
> >> >  include/smbios.h | 5 +----
> >> >  lib/smbios.c     | 2 --
> >> >  2 files changed, 1 insertion(+), 6 deletions(-)
> >> >
> >> > diff --git a/include/smbios.h b/include/smbios.h
> >> > index 77be58887a2..879b8a814b8 100644
> >> > --- a/include/smbios.h
> >> > +++ b/include/smbios.h
> >> > @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *tab=
le, int type,
> >> >   *
> >> >   * This writes SMBIOS table at a given address.
> >> >   *
> >> > - * @addr:      start address to write SMBIOS table. If this is not
> >> > - *             16-byte-aligned then it will be aligned before the t=
able is
> >> > - *             written.
> >> > + * @addr:      start address to write SMBIOS table (must be 16-byte=
-aligned)
> >> >   * Return:     end address of SMBIOS table (and start address for n=
ext entry)
> >> >   *             or NULL in case of an error
> >> > - *
> >> >   */
> >> >  ulong write_smbios_table(ulong addr);
> >> >
> >> > diff --git a/lib/smbios.c b/lib/smbios.c
> >> > index 7f79d969c92..cfd451e4088 100644
> >> > --- a/lib/smbios.c
> >> > +++ b/lib/smbios.c
> >> > @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
> >> >                 ctx.dev =3D NULL;
> >> >         }
> >> >
> >> > -       /* 16 byte align the table address */
> >> > -       addr =3D ALIGN(addr, 16);
> >>
> >> I think this is wrong.  It will break SMBIOS on a user error. I am
> >> fine replacing that with a check instead and error out if the address
> >> is not 16b aligned
> >
> >Well this is why the comment says it must be aligned. This function is
> >not called willy nilly,from code we control. Checking for alignment
> >at runtime creates confusion and adds to code size.
>
> The SMBIOS tables themself have no alignment requirement. Only on non UEF=
I x86 system presenting a UEFI entry point in the range 000F0000h to 000FFF=
FFh this copy of the entry point has to be 16 byte aligned.

OK. So perhaps I should reword the comment to say that any
arch-specific alignment must be respected by the caller?

Regards,
Simon
