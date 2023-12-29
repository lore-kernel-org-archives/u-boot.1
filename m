Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C562CC46CD4
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 06:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D5E8715C;
	Fri, 29 Dec 2023 07:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aDlFidzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCE4871A7; Fri, 29 Dec 2023 07:16:12 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07EFD87120
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e18689828so7031298e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703830569; x=1704435369; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYn4SW9tZ1vgBnl78jm65OpiYH1O7sQawYpTH7u1lvs=;
 b=aDlFidzIMcKA8GyaPdOES3SkcusGtH4jTlLozXRhkownjTi4Y5BcCG4u8KZE9/KrnO
 /tVtiRENHh674DYxFZoMtc1uEbe0u5q/OF+YY+fxWL2HpBryVMbPQcb/q0yaL4L4F46N
 o6XKPhGx1JrpUHbCk3SPrl2PNG8PfuGn7nwoI91+4mTLDB3o0KMEEtwxRjmjkRxBKev8
 Pt33QlozjNE9Bi4FvAKau6kDmXBreCkrmuVuhx2sHAbwUXblynqP0mnRYYvKY9qzhC86
 incjmJBBlbG7bzyRWpGW896sv4NxrqC1MRr+RVQ4eUch38lLBrV2ikn45T++ROIoVuSd
 5suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703830569; x=1704435369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYn4SW9tZ1vgBnl78jm65OpiYH1O7sQawYpTH7u1lvs=;
 b=qtGoMCMVppHKmRVsxbZZfyiyDDjsvjjWFx4lmbsCf3GnRxZuYXXsLuYcQheXDxEQi+
 m/l9p4rga+uU3diWTG7CRJJGZBVTAKHr22XLAlH0oZ4rG/Mhsm0tmeL2lcLg92nfXgbY
 nMuqRoNwa+YXIHW01Yjr8QV4OvBgqS2J5/AAWJVkINusnFyiK9KdJNS84/EPWp/X4RML
 84umzO4tx9KRyJY83yPtSCWy0umgZmf+5IKv7yFYwvHSnG76MaiSDef/a5xxcMLPomnp
 PQSwoK0fhStSa+1JRnjB5DyHnRNiDonQfej+Oy1yoZrEKkN9WEmGQJLFeQgR6v4Y/7sh
 KfQQ==
X-Gm-Message-State: AOJu0YwgTmRtxt2BAzilmuNVO9zvpijCITyMa18krBf49j8TMHEgHZ+7
 p0+bJQwrx9KcnGg9jATUVG07iPeM2DSqr08sCq/75SpAf48hiA==
X-Google-Smtp-Source: AGHT+IHCTcz2a1H0hZvn6+4yEUD+/mb8+uLnxV8x7acdzejbYX10Z2rc7ZZuiiJNAeERpD+0SeXoXLnIR4Ddt2mOE8k=
X-Received: by 2002:a05:6512:419:b0:50e:3c1e:95ed with SMTP id
 u25-20020a056512041900b0050e3c1e95edmr4362166lfk.52.1703830569075; Thu, 28
 Dec 2023 22:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
 <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
 <CAFLszTgko0C42Zc8wHJO5c20SSR-1pcCotEHi7AcuYEOacCGQA@mail.gmail.com>
 <690A2210-C523-4A53-8E1A-DF565F183630@gmx.de>
 <CAFLszTgxgJM9xm_-RXG64SD0jsg5cRh=OVOVfgy=23Wu0hZ8Yw@mail.gmail.com>
 <73A02AD8-46C5-4BB1-BF8C-3361F01A8D5E@gmx.de>
In-Reply-To: <73A02AD8-46C5-4BB1-BF8C-3361F01A8D5E@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 29 Dec 2023 08:15:33 +0200
Message-ID: <CAC_iWj+zeB3qoUX-nz2YCd8Q2E11ETDZn=2DPKGV-NM9ubeZ1w@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] smbios: Require the caller to align the SMBIOS
 table
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Thu, 28 Dec 2023 at 23:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
>
>
> Am 28. Dezember 2023 20:48:04 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Thu, Dec 28, 2023 at 5:36=E2=80=AFPM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
> >>
> >>
> >>
> >> Am 28. Dezember 2023 14:37:19 MEZ schrieb Simon Glass <sjg@chromium.or=
g>:
> >> >Hi Ilias,
> >> >
> >> >On Wed, Dec 27, 2023 at 11:12=E2=80=AFAM Ilias Apalodimas
> >> ><ilias.apalodimas@linaro.org> wrote:
> >> >>
> >> >> Hi Simon,
> >> >>
> >> >> I commented on v3 as well, but in case you miss that
> >> >>
> >> >> On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> >> >> >
> >> >> > All callers handle this alignment, so drop the unnecessary code. =
This
> >> >> > simplifies things a little.
> >> >> >
> >> >> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >> >> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> >> > ---
> >> >> >
> >> >> > (no changes since v1)
> >> >> >
> >> >> >  include/smbios.h | 5 +----
> >> >> >  lib/smbios.c     | 2 --
> >> >> >  2 files changed, 1 insertion(+), 6 deletions(-)
> >> >> >
> >> >> > diff --git a/include/smbios.h b/include/smbios.h
> >> >> > index 77be58887a2..879b8a814b8 100644
> >> >> > --- a/include/smbios.h
> >> >> > +++ b/include/smbios.h
> >> >> > @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *=
table, int type,
> >> >> >   *
> >> >> >   * This writes SMBIOS table at a given address.
> >> >> >   *
> >> >> > - * @addr:      start address to write SMBIOS table. If this is n=
ot
> >> >> > - *             16-byte-aligned then it will be aligned before th=
e table is
> >> >> > - *             written.
> >> >> > + * @addr:      start address to write SMBIOS table (must be 16-b=
yte-aligned)
> >> >> >   * Return:     end address of SMBIOS table (and start address fo=
r next entry)
> >> >> >   *             or NULL in case of an error
> >> >> > - *
> >> >> >   */
> >> >> >  ulong write_smbios_table(ulong addr);
> >> >> >
> >> >> > diff --git a/lib/smbios.c b/lib/smbios.c
> >> >> > index 7f79d969c92..cfd451e4088 100644
> >> >> > --- a/lib/smbios.c
> >> >> > +++ b/lib/smbios.c
> >> >> > @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
> >> >> >                 ctx.dev =3D NULL;
> >> >> >         }
> >> >> >
> >> >> > -       /* 16 byte align the table address */
> >> >> > -       addr =3D ALIGN(addr, 16);
> >> >>
> >> >> I think this is wrong.  It will break SMBIOS on a user error. I am
> >> >> fine replacing that with a check instead and error out if the addre=
ss
> >> >> is not 16b aligned
> >> >
> >> >Well this is why the comment says it must be aligned. This function i=
s
> >> >not called willy nilly,from code we control. Checking for alignment
> >> >at runtime creates confusion and adds to code size.
> >>
> >> The SMBIOS tables themself have no alignment requirement. Only on non =
UEFI x86 system presenting a UEFI entry point in the range 000F0000h to 000=
FFFFFh this copy of the entry point has to be 16 byte aligned.
> >

Thanks Heinrich, this makes sense

> >OK. So perhaps I should reword the comment to say that any
> >arch-specific alignment must be respected by the caller?
>
> Just mentioning the requirement from the spec in the function description=
 should be good enough.
>
> Best regards
>
> Heinrich
>
> >
> >Regards,
> >Simon

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
