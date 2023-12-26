Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6941BC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5345E8791F;
	Tue, 26 Dec 2023 10:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H1JKoJUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02D38787E; Tue, 26 Dec 2023 10:48:24 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988B58791D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28beb1d946fso3466118a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584099; x=1704188899; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtXzculmzU58eDjU+pdGEM7MpKR/b6Ix/pYM8JWcktc=;
 b=H1JKoJUlhcfbRlZ4u+tAkfj88N82/JIjtcBSvpisnHFvGGidUK67Dv0juReHjLFiFH
 lQK14WRPSLWgJtsG44bdYLvyfugJ90HEKormBr95981hx+Hvqr6rlRccK8+1Amlig6Ug
 BeVAty3PNdLF3VXAAxfBFU7q4jYVJPYEkbyZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584099; x=1704188899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtXzculmzU58eDjU+pdGEM7MpKR/b6Ix/pYM8JWcktc=;
 b=wbpstkMvvDDK9K2Nud4/lYSYPa8P+5xeyJwMrlYPrnf5dy8+P8X8uSlKyNpYYntHoz
 GdbSp3UiWNabaV1tQJ4BSdQgpFFBGwdQ6TjNnzsguRYtXbZWZd43x1yQKGhN8yFQpv5Z
 EKhjJFx4ZpKXJ4ApNJkgQjPovx3hXLHZy6i3sqd90966LogE33BO8hlUpvPYQ9XSFmmN
 QheqLVPik185cic7DcfGoboXwwG4KOa8pqeqO4ftSyy87nu0qPRIbSzbXYfMqFQEjOHP
 9u1V3l43J5mnUyEUPTGqETnSDi0potPOdNg1efNSOz82iVaPRKKWlgLwevyzBTeoz7Ms
 bGkw==
X-Gm-Message-State: AOJu0YyuFjAvrQn1OUSLVWtYGjzAPJJDjU4XD7lqZUDc/PQF53p8oK6Z
 MZzWnYzvAG6aj2LC7BqOOFtjB2ICGWIwupBaN/JZew7ihXr1
X-Google-Smtp-Source: AGHT+IG+rXKnVcrAtoU5x3MNWRgkpEAsMkPWfSMbLyLX2iJEPbYw/YMm7DfYlnkiDemFpQ3JmwkGdgPJ7ANRVEu+v6A=
X-Received: by 2002:a17:90a:d312:b0:28b:d338:db18 with SMTP id
 p18-20020a17090ad31200b0028bd338db18mr3024252pju.63.1703584099540; Tue, 26
 Dec 2023 01:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
 <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
 <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
 <CAPnjgZ2DM55YjF845k2uGscwr6-yrQ7KU=mZFsoo9K-6Gik1WA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2DM55YjF845k2uGscwr6-yrQ7KU=mZFsoo9K-6Gik1WA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:39 +0000
Message-ID: <CAFLszTi61XrAswTvaMVgLp32K+9TftAxo2=VW3jivU1tyOucWw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, Dec 18, 2023 at 3:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Heinrich,
>
> On Sat, 16 Dec 2023 at 14:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 12/16/23 21:46, Simon Glass wrote:
> > > Hi,
> > >
> > > On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
> > >>> On 11/12/23 21:55, Simon Glass wrote:
> > >>>> This function is defined by bootstd so using it precludes using th=
at
> > >>>> feature. Use the board_early_init_r() feature instead.
> > >>>>
> > >>>> This requires moving quite a lot of code into the board directory,=
 butt
> > >>>> this is the normal place for code called by board_early_init_r()
> > >>>>
> > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >>>> ---
> > >>>>
> > >>>> Changes in v2:
> > >>>> - Drop duplicate acpi_xsdt patch
> > >>>> - Put the board_early_init_r code into board/
> > >>>>
> > >>>>    board/efi/efi-x86_app/Makefile  |   5 +
> > >>>>    board/efi/efi-x86_app/efi_app.c | 205 +++++++++++++++++++++++++=
+++++++
> > >>>
> > >>> Our target should be to enable building the EFI app on all architec=
tures.
> > >>>
> > >>> Only x86 specific code should be added to board/efi/efi-x86_app/efi=
_app.c.
> > >>
> > >> A later enhancement to make U-Boot as an EFI app more generic would =
be
> > >> good, but outside the scope of this patch which is moving generic co=
de
> > >> out from "lib" and in to "board".
> >
> > I cannot see that this patch is moving any code our of lib/.
> >
> > But why should we move generic code into board?
>
> It isn't really generic
>
> >
> > >
> > > This patch was marked as old /archived in patchwork so has been
> > > forgotten. I have marked it new and non-archived in the hope that it
> > > can be applied to -master soon.
> >
> > There is nothing x86 specific about the code. Generic code should be in
> > lib/. Please, provide a new version of the patch.
> >
> > >
> > > I believe that having the EFI app support bootstd could be a useful a=
ddition.
> >
> > That was not disputed.

OK, I see now that your objection was putting it into board/ so I sent
a new patch for that.

It is very strange to have board_early_init_r() calling code in lib
though. We should think of a better way.

Regards,
SImon
