Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA60CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 17:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7941783955;
	Fri, 10 Oct 2025 19:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zqx/+BlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1062B83906; Fri, 10 Oct 2025 19:39:11 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FE2838E5
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 19:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so26483135ad.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1760117946; x=1760722746;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGsVginqEVUbXj/T86W+YsDi93zcMjIB75S76PHfY8E=;
 b=Zqx/+BlHRV8G39GWrXoGtAkHvLp0UxmiSjcoKGgJwHfEgzJl8TZ8in/gf9cFWq2NNA
 oO0K8Otw75mGZKtxHqVDUuWw29GZMnJKOpuThIwrNwYV16ATqMRTfNtc2nRC3WwW3KmC
 tS+OvsLNXv8nuxgkf2fupGIo0bApIO0sPPD60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117946; x=1760722746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGsVginqEVUbXj/T86W+YsDi93zcMjIB75S76PHfY8E=;
 b=TB+G3dlclJv7Oc2UAn+aq+8Up/CZJBRV3irn3Y0ctkOiNRL+6Jupc8Z+756MQ6r6oZ
 zrrQJVomzzMlsSbTyDMsEWv5YJi2DB9LcaXc3hUQwriUH/Vqdehx9zoT/yMEN1CjswgV
 kz7dHicyCIg5ZTi4ARWqhzCYeZcE0LLW8/txCQKiI1IiQ+sUM6ACtV5cJHpwOPwIX5y2
 QQIyVn0WuZf7dxjKMjv2VKhnfX6U1NMGyNc6uGuZFrF0x67aIKF6970FLV7CvYXtWUOn
 8xLHRR2U5c7spP4GnjjPY6tC9oWNxzRgqWgLUGnJx+Stdx4TQE4pCeZA9KKr80CYGy0i
 8UAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/NTP/z7Wv1fz1oMWbgfnwkddrxJAPTJJJODe7RLadHrkvBY1xsZzhmsYknQyCtUxUVSeARuM=@lists.denx.de
X-Gm-Message-State: AOJu0YziTOTU5XP0XL1xlYC3UDKmGChc1x3OMeCUFaq0OTnxpzKsl0nj
 yPhI9Q5oUL5imKlOTzSm2clj9uRZ66rHgj+hNdZHR6SRp9GRFEDpr8F5qmx0TACFU/rRwSxWSR6
 F3xCmdnaGQa3ebHPZdvotu1PCGGHaz5FOXm3dUZILig==
X-Gm-Gg: ASbGnctItTa87R2UEdtCuyIvRAe8bXT6Vs56IX8iGcI1KlKejQM0omVN28TDxwMtMwK
 LJQD1hxLnWhkYDRkqbLBIs5DxVfabIlOn7uj9DQ5jbeBT8a10XZ2T35e4kUFGYjnpAnCHmOmBLK
 4cQgS9QC7gJa/DVMF2L9vKi+o9knDXY1KYnxC3AnnL51TfL+8Cu2AQFgwayyIEA1cUgq4wxf64E
 bjrzmqAjAalceLy+ob647Skd7PQRwMNvfVC69I5XqBNRarRDFbOd0ud1ZIzdOhqImOY
X-Google-Smtp-Source: AGHT+IEsDQBr5HxzBGcJw9a9aHH4o+VAIowwb5mZ7+4j9FTUrUAP3miBx5ougyxaEd1Ee3mGk8sQRsWKuKyeqVZLeTI=
X-Received: by 2002:a17:902:c94c:b0:27e:f201:ec94 with SMTP id
 d9443c01a7336-29027373e8cmr175213495ad.18.1760117946180; Fri, 10 Oct 2025
 10:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251010165103.1572444-1-mikhail.kshevetskiy@iopsys.eu>
 <d5cc0678-5d8a-4ff4-973d-6b5a41f2fa4e@gmx.de>
In-Reply-To: <d5cc0678-5d8a-4ff4-973d-6b5a41f2fa4e@gmx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 10 Oct 2025 19:38:55 +0200
X-Gm-Features: AS18NWBEj3IrHF8P8S5MvlauVsLfT4IX0m1PT1GJYy0RqrFZ9UZMl_6qGtGt8WQ
Message-ID: <CAOf5uwk_PmCfPiDTkXQWVJajT4KtgoXKvFgCTtapjc4_PycaPA@mail.gmail.com>
Subject: Re: [PATCH] cmd: mtd: benchmark: use lldiv() instead of 64-bit
 division
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>, 
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Fri, Oct 10, 2025 at 7:28=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 10/10/25 18:51, Mikhail Kshevetskiy wrote:
> > As was noted by Heinrich Schuchardt, some SoCs may not support 64-bit
> > divisions. Fix an issue by using lldiv() instead.
>
> Thank you for the patch.
>
> It is on top of
> cmd: mtd: fix speed measurement in the speed benchmark
> https://patchwork.ozlabs.org/project/uboot/patch/20251010124115.1545865-5=
-mikhail.kshevetskiy@iopsys.eu/
>
> Adding it to the series might make Tom's life easier.
>
> >
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > ---
> >   cmd/mtd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/cmd/mtd.c b/cmd/mtd.c
> > index acd886da6da..2bc9fea697c 100644
> > --- a/cmd/mtd.c
> > +++ b/cmd/mtd.c
> > @@ -10,6 +10,7 @@
> >
> >   #include <command.h>
> >   #include <console.h>
> > +#include <div64.h>
> >   #include <led.h>
> >   #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
> >   #include <hexdump.h>
> > @@ -595,7 +596,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> >
> >       if (benchmark && bench_start) {
> >               bench_end =3D timer_get_us();
> > -             speed =3D (len * 1000000) / (bench_end - bench_start);
> > +             speed =3D lldiv(len * 1000000, bench_end - bench_start);
>
> Here you assume that the benchmark never takes more than 4294 seconds
> and thus the difference will be less than U32_MAX. This looks reasonable
> to me.
>
> >               printf("%s speed: %lukiB/s\n",
> >                      read ? "Read" : "Write",
> >                      (unsigned long)(speed / 1024));
>
> You further assume that the compiler implements this u64 division
> as >> 10. You could be explicit about this.

The series is taken already, so it means apply now on top of tom tree

Michael

>
> Best regards
>
> Heinrich



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
