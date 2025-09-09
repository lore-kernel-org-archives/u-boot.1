Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF1CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5167783252;
	Tue,  9 Sep 2025 14:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q6YLPBgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457488312A; Tue,  9 Sep 2025 14:07:38 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE188830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 14:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55f6f434c96so5255476e87.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1757419655; x=1758024455;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZ4BJHVbfFbd0vmhcFRGG7sk9aRYLaAwmWmnQe5BUh8=;
 b=q6YLPBgtiZWOGX/77VQgiDJoJk2G5vesoQRIFEVV6LtMdvfzmIIORvZgQKM+IrOlX7
 eQNowdE1/8HK/L00czIDIraGIbPl9RpvLsprCBTZ0Utt7KqUn8yz27cb+mbxcE++TvNy
 lXNBlJLPZ8AlaEzK5ZgAVb3QreB725o22Ie5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757419655; x=1758024455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZ4BJHVbfFbd0vmhcFRGG7sk9aRYLaAwmWmnQe5BUh8=;
 b=XuyYLDnYJ1uACE5QU5gPfNuMfriOvPKaZrRCMScsREN2pqZ4dM4q3CQSDs4c1kM6CJ
 6DmdUGNDSi0eSnlyZHVq1ZkUK7QlscxKOPCH5q5Jc3/leoPO0h1sH8aDgE6b48L8DfCH
 YpzkbdMM6rNUafgHW/DxO3IRwtlIXksd6TGIlSR0eYyiJ/PYwX60vmRbF2/ea5IIPcHs
 pHNaIoFmBOj+7lUq+zDfLotnl6KmEMQpwLTFK3jHjcBZq+UP4Do674IwTIXuD/cEepyJ
 lDCsvBu7wDp90tPqOUHbsglHujwwx9fKNUilOjIp5B/4d57BQM3DeTR/pJFD3Nd5K9oY
 geBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR+hSTZhtkXSn78b88PHBTew3Om3o1DzAMG+rTiS4N6+iPvsYXxHiyg2aM0t0tEG3p+iINFTU=@lists.denx.de
X-Gm-Message-State: AOJu0YxJO96PFYeavaub/avmK09LD4A+0c4/m9gbt+UbcMw9/zQ/d8T6
 merdBTrLlMg26+HQc7XTDxHuTeMWRVwfuMWAPh9DNK0kKq5PTZ0gu1wcvMvFNa3ZUqatWeUKGXQ
 GhQSUPs3eaf4PvWF2AFZG8I3csCTmU4HQi05ZjYACXg==
X-Gm-Gg: ASbGncsQHxLje9ouZkhAYaDMAZVwAaYDFqb72OggIKjt0xtWlMoaTrvASFkspG/qxRn
 kXdv9/ELqGNcm+DoaA2y7NmxAJVeak0HS8Dclngd4WgLxF8SCzJSxQVp/6hQs1fSfWxyWJJMEA7
 wUUyS+qy05R/nRuxFTfjPOnUVIgenWtnsvWCFDwdoThWVQl3nR8HEP/qVt0HIDsReRHpuSV2HIp
 UfBNb3FXJB3rGOorAwJYdGc3UotedZ0dxSpEQHK
X-Google-Smtp-Source: AGHT+IGmPTHpHLMu+0+dQ2/sKeXWVk3G/tbxu+ifqXN4v6YdyDl/aJcGJzR1gePqA9R4qnwWsf3gk7Yb/cabH/um+GI=
X-Received: by 2002:a05:6512:1507:10b0:562:d04d:fa0a with SMTP id
 2adb3069b0e04-562d04dfb44mr3532749e87.31.1757419655115; Tue, 09 Sep 2025
 05:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
 <87a534exwc.fsf@bootlin.com>
In-Reply-To: <87a534exwc.fsf@bootlin.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 9 Sep 2025 17:37:24 +0530
X-Gm-Features: AS18NWCT6-w5JYcINTFKnh9kC0pPzHJynF6eb8cyIzgyiGVujUOwTkY5avPgx7c
Message-ID: <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,
 02}jv behave correctly
To: Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

On Tue, Sep 9, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hello,
>
> On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>
> > These chips are internally made of two/four dies with linear addressing
> > capabilities to make it transparent to the user that two/four dies were
> > used. There is one drawback however, the read status operation is racy
> > as the status bit only gives the active die status and not the status o=
f
> > the other die. For commands affecting the two dies, it means if another
> > command is sent too fast after the first die has returned a valid
> > status (deviation can be up to 200us), the chip will get corrupted/in a=
n
> > unstable state.
> >
> > The solution adopted here is to iterate manually over all internal
> > dies (which takes about 30us per die) until all are ready. This approac=
h
> > will always be faster than a blind delay which represents the maximum
> > deviation, while also being totally safe.
> >
> > A flash-specific hook for the status register read had to be
> > implemented. Testing with the flash_speed benchmark in Linux shown no
> > difference with the existing performances (using the regular status rea=
d
> > core function).
> >
> > As the presence of multiple dies is not filled in these chips SFDP
> > tables (the table containing the crucial information is optional), we
> > need to manually wire the hook.
> >
> > This change is adapted from Linux.
> >
> > Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volatil=
e-bit-v3-1-735363f8cc7d@bootlin.com/
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Same question for this one, no feedback for the past 2 months, I'm not
> sure who's supposed to take these, Jagan and Vignesh you are marked M:
> in maintainers, any chances this can get it?

Unfortunately, I was off quite some-time. Need little bit of time.
Vighnesh is off for years. In the meantime, Michael will help in
review but need help on testing.

Thanks,
Jagan.
