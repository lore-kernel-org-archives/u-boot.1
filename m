Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29579C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908E888B60;
	Tue,  6 Aug 2024 23:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLn60mmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FEA88B2B; Tue,  6 Aug 2024 23:51:34 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788DC88B52
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso843521a91.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981084; x=1723585884; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guFg3tuE74fHMqfJ4QY+nh4DFZHrHWkj8GU1QtvXhc8=;
 b=QLn60mmT6T4pOev9Wj0zE3qSVyOX6D4cWXSb3z6JhOBxhqcGaanVeoiQ2XxHP29mm7
 c7Abopot5cQ2ubVNa+QlEl6vc6TLsCwSLm3vnVG9Nlz/nBoCSGs2zgQOkxkAirAaQBCh
 vyFYJsvliMDJSFsOIzbhXYqKNeDhWdGQQuSUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981084; x=1723585884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guFg3tuE74fHMqfJ4QY+nh4DFZHrHWkj8GU1QtvXhc8=;
 b=es/hNG6p6KZOnX/sbxCEsXx3jONjT4PCAa0HppGx5QCmivp3rgZ+ChfVnYIfyISysk
 y+jI4Cij/KHAdfh6UP+lC7hWpBUaEM8FmEEHEa8oPsT7fm/Pt5I7TuFgssRlJqZ71r4F
 j/DcCTimR9IJCc2vYjPeqZMmd9f7/MT5OZsQPdnQGwQcniOOTnUDK9G/2cu1TSpinz/2
 edG2UZFFDi6SNMpqP6Wp84GOG5ddBHopYKuwOQ6pxFdVhOVanjgqWw72mhEPG8cVcz+L
 Ko2pvjhYJuTPdUA1Y89Lz9lScNIgsMfXBdVHiwfes3H1KkHHsCSpUhELGvqQsido/fvq
 CW1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjv8ZrauSwp/Q252jntIx6pATqxyodgKnSutts98IcHeKEGS9ZraQ5rS948GApy12aXF5tm1zRFsVwGOvCPYtWzotfEQ==
X-Gm-Message-State: AOJu0YzFTIZq7+XP+jQvb55X7WAoJ948cH2llS0z/tBENRoZx4sEV4XR
 LHQwkn+T2cuHpKrIP/hbLwhLAH4POcPEbHK9gZRX/E8sLJ1FFRCxiLxz1cs5UpmAuUJ23DfrNq/
 uOOmF+0/20Jo5zVNwaH/KYYEEigdKLxEAEpEl4q5XW+ZZr94=
X-Google-Smtp-Source: AGHT+IH47MIjQMfJaBXD3MnEWdvfBeVxrti8TAB7ILrEjNBUWK05It+5BzVv4nOwGBLXHF0aMDRfU9/E7XTq2Eo7Nvg=
X-Received: by 2002:a17:90a:bf14:b0:2c9:758b:a278 with SMTP id
 98e67ed59e1d1-2cff957d120mr20271966a91.35.1722981084102; Tue, 06 Aug 2024
 14:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230822031705.1340941-1-sjg@chromium.org>
 <20230822031705.1340941-6-sjg@chromium.org>
 <CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com>
 <d388c065-9370-498b-96c8-d22af41d2e64@amd.com>
In-Reply-To: <d388c065-9370-498b-96c8-d22af41d2e64@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:39 -0600
Message-ID: <CAFLszTgMTwiunEyVaPYWwDeKoDnWx8PW2JzEj6yk_nuY+bJePw@mail.gmail.com>
Subject: Re: [PATCH 05/14] initcall: Adjust the failure message and return
 value
To: Michal Simek <michal.simek@amd.com>
Cc: Michal Simek <monstr@monstr.eu>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
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

Hi Michal,

On Fri, 2 Aug 2024 at 03:21, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
> On 3/22/24 11:22, Michal Simek wrote:
> > Hi Simon,
> >
> > =C3=BAt 22. 8. 2023 v 5:18 odes=C3=ADlatel Simon Glass <sjg@chromium.or=
g
> > <mailto:sjg@chromium.org>> napsal:
> >
> >     Move the failure message outside the loop, so it is easier to follo=
w the
> >     code. Avoid swallowing the error code - just pass it along.
> >
> >     Drop the initcall-list address from the output. This is confusing s=
ince
> >     we show two addresses. Really it is only the function address which=
 is
> >     useful, since it can be looked up in the map, e.g. with:
> >
> >         grep -A1 -B1 serial_init u-boot.map
> >
> >     Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.o=
rg>>
> >     ---
> >
> >       lib/initcall.c | 12 +++++++-----
> >       1 file changed, 7 insertions(+), 5 deletions(-)
> >
> >     diff --git a/lib/initcall.c b/lib/initcall.c
> >     index 81c5d2450735..0f74cef32f85 100644
> >     --- a/lib/initcall.c
> >     +++ b/lib/initcall.c
> >     @@ -46,11 +46,13 @@ int initcall_run_list(const init_fnc_t init_seq=
uence[])
> >                      }
> >
> >                      ret =3D func();
> >     -               if (ret) {
> >     -                       printf("initcall sequence %p failed at call=
 %p
> >     (err=3D%d)\n",
> >     -                              init_sequence, (char *)func - reloc_=
ofs, ret);
> >     -                       return -1;
> >     -               }
> >     +       }
> >     +
> >     +       if (ret) {
> >     +               printf("initcall failed at call %p (err=3D%dE)\n",
> >     +                      (char *)func - reloc_ofs, ret);
> >     +
> >     +               return ret;
> >              }
> >
> >              return 0;
> >     --
> >     2.42.0.rc1.204.g551eb34607-goog
> >
> >
> > I am debugging one issue and I get output like this. And I dig into it =
and find
> > out that failures are not reported
> > on the function which is causing it but on the next one. It is because =
of
> > pointer is moved to next function;
> >
> > This is what I see.
> > initcall: 0000000008072de8, 0
> > initcall failed at call 000000000802b14c (err=3D-19)
> >
> > And this is the problematic part.
> > for (ptr =3D init_sequence; func =3D *ptr, !ret && func; ptr++) {
> >
> > Fix should be of course to get that if(ret) code back but maybe you wan=
t to see
> > different solution.
>
> Any comment on this one?

Yes it was fixed by this, I believe, although no Fixes tag unfortunately:
7554388c1d1 initcall: break loop immediately on failure

Regards,
Simon
