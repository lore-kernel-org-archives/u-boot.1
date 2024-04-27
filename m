Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFACC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 01:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43F28827F;
	Sat, 27 Apr 2024 03:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hXZD+TMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF2988266; Sat, 27 Apr 2024 03:29:55 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12AAE882F9
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 03:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-47c0d9bc65aso1077440137.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 18:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714181392; x=1714786192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZqa+MLq6T9wkhPPaYi5CdarAII35CIszhNB1Pg5nf4=;
 b=hXZD+TMmRVTQdR0CtB5u6pQKsJidbRZualhshf9am6QeDDRp4X/TM1GIa2xrmxOoMk
 WHtKuU3XWOm9GAMqbTfh6xqYCuJ2xHpHBpZIUx5Wi6QFEZnJk9Seu1OihHJqb1MR56qs
 uDfV3BKGUngV8aUCRveagGJwWGHqzA0EPFm9yhk/3gUQL8warvG4dJH64dKo6p+Nw1up
 XEGpXk4dq86O34Y7SVg9yK9pJnIqCCX/1U8r+pRqwUvt18tD6sYYASSStv/VIssahe61
 MNnjjEDuPjavyl9WBqJlQmp7+DjpkU0SE17X0HXcIXN9WMiXBlgZFlyeQhaAPvKrdwIy
 ovog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714181392; x=1714786192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZqa+MLq6T9wkhPPaYi5CdarAII35CIszhNB1Pg5nf4=;
 b=cQphHe8utHlrp5V2tyZgrAjPez1CWRiGSEDx1AAw4VClwi/gAIcslCbbUXV5DI6nEV
 EqX49UzH9GoBPgIQTwaYZqFkD4gZSInw/MMDDRplbDFQNBppYZNouUjQv/MNL+4f2zeo
 8DpXgpkE37Hx5oOCjGZ3lhOEQ2n8ziiOAs7AEiKI43BxoSs4cJtMHXKXHkGRbuTX0dOO
 xNg4l/g+JN+psC9jhI04NqfnQQRM0vZXrtGjfQHnWBENqM9c/+VAWWPPGmdn02gXAXtw
 Osa5s/bSpa4cf+5u3u6F/Kflhmt79gC8O+LjDV1NUxA15fNGZkAWFUOmRSsfvQVfE14i
 x03w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfUtNsWhZ578ShORxg5DaYepXkG1uimHub5Y784Y0l7f8S9xLdTyQUMnRIwejFwQvGefqGt1OvOc8vnL/8siDz86MyGw==
X-Gm-Message-State: AOJu0YyEzVGSJ45AmCZFNO80eTLszCSEL6shR9GAatlrxqWCuA9pUgkN
 2bK1+rL6L0yMn3bySSz6n+fKl17f2kyRr7Rl9k307+k+9Wrzff+HJnfL+uJeelYZ71QDTyPt8u9
 0hXF7j/jdi2Xo/1csZxq6xpepxJM=
X-Google-Smtp-Source: AGHT+IEugiSYypqlXDdQBcvGT6PnFf1cliQPuCEtRpEdFYyloQG6py30uY+tr/xPwhumGSUKpx2oVXkC56d/S/Wxc34=
X-Received: by 2002:a67:e252:0:b0:47c:1777:c4a7 with SMTP id
 w18-20020a67e252000000b0047c1777c4a7mr4521114vse.3.1714181391944; Fri, 26 Apr
 2024 18:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
In-Reply-To: <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
From: E Shattow <lucent@gmail.com>
Date: Fri, 26 Apr 2024 18:29:40 -0700
Message-ID: <CANV2PTOQknpnfKsZQC9Tr0AhZgMQOOTTND0T+WMp8pwv-5TNdQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Dragan Simic <dsimic@manjaro.org>
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

Hi Marek,

On Fri, Apr 26, 2024 at 5:49=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> [...]
>
> > diff --git a/include/mmc.h b/include/mmc.h
> > index 4b8327f1f93b..7243bd761202 100644
> > --- a/include/mmc.h
> > +++ b/include/mmc.h
> > @@ -381,6 +381,21 @@ enum mmc_voltage {
> >   #define MMC_TIMING_MMC_HS200        9
> >   #define MMC_TIMING_MMC_HS400        10
> >
> > +/* emmc hardware partition values */
> > +enum emmc_hwpart {
> > +     EMMC_HWPART_DEFAULT =3D 0,
> > +     EMMC_HWPART_BOOT0 =3D 1,
> > +     EMMC_HWPART_BOOT1 =3D 2,
> > +     EMMC_HWPART_GP1 =3D 3,
> > +     EMMC_HWPART_GP2 =3D 4,
> > +     EMMC_HWPART_GP3 =3D 5,
> > +     EMMC_HWPART_GP4 =3D 6,
> > +     EMMC_HWPART_USER =3D 7,
> > +};
> > +
> > +/* emmc hardware partition names */
> > +extern const char *emmc_hwpart_names[];
>
> Maybe the array should have fixed size here, i.e. 8 ?

Is there an ABI reason to do so? Can you explain further why it would
be needed to do that?
