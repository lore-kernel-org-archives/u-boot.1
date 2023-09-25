Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F98CD54BF
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71CEE86CAD;
	Mon, 25 Sep 2023 21:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="ZMqYgb0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E9E86D3B; Mon, 25 Sep 2023 21:27:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDAAC86B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c4d625da40so2990483a34.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1695670047; x=1696274847;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cEJbJqraLgnkbkn3Itpi2cw2y020R7Dup6xakbJ5OKk=;
 b=ZMqYgb0IHn3uOj5eGfmcSN4oZXYdlzCgHW4RwlpwsTPib3OCXAu0VD7+iq2HYFccE0
 5S4kfR+iX9JUaDe4okLlqrv1XDdGI/6gqC6fG/LWtLRXUfeDgTnjtzY/f+3yd7y5mvIM
 llCFVdainN375W2NbsgJyBDznxCaDM0gggzkJwufld5i7sbpUgldni5kw0y98ipyyl51
 Ww9Q3xtBrRt6Bo2x6KszNJ9ylPoIyBv0Jl1y/QHPPddXc4WX9bNLnYd47co38G1cUajx
 v3VRvLud2+Dvj0jqy+UJByM9ipo121X6rb5DVlYYJ56nmqKx1mitOZTMXutFa6iv46SN
 5hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695670047; x=1696274847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cEJbJqraLgnkbkn3Itpi2cw2y020R7Dup6xakbJ5OKk=;
 b=Zt2simb4UWyAVIdwEU9DUVuxv37XHY9h916P/lKsB9wOm4a/xX1xpz2fUds/ZWT9L6
 LaD/6s44uLW5I7HIJ4DAdPSf4bT1mGfUTTEfv3wD4K/LW/CkoRQrD6TPbCSxZbiXmEw8
 NKWn4J+4urOxSpHCnpZIwXLkAcJ5qycikOBNfkl4K5JD2ykAGOJeYgpmA+BdyllQpdyn
 04ajs/7TvroL8TCuYx8T4ZIiV6LL8yU6ip3Qhaj/ECZVk7wP5MKvWIOEGJaeTHNUKfsz
 3qeWPbl9AGXnM2EO0/Ootoc/sh4coI0XrL+Mtx7/MYlojCuJ9X6dCD4pOutk7I2fvjN1
 ZBow==
X-Gm-Message-State: AOJu0YyZcishvETAUa9LvKRj8gK2gID+hZp/9GsmAtCwwDowT18gqNoE
 lVeVgBwd1pRcbG+j4gvx5sGZ+LUAnR1tvXFnO14=
X-Google-Smtp-Source: AGHT+IFVMIB20yZqgxmpTHl1tIOefX44e/67ZuNNS3IQs4AFhACDbPgTp1V2Eul8781FlvtEK5QyK2J+ag9j5hpHfWg=
X-Received: by 2002:a05:6830:14ce:b0:6bd:7252:9db1 with SMTP id
 t14-20020a05683014ce00b006bd72529db1mr9449664otq.11.1695670047257; Mon, 25
 Sep 2023 12:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
 <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
 <CAOYdKdjALruh9v6HBO-MSjzZM0whYhbA5YLJxbKk7yQk7cznGw@mail.gmail.com>
 <CAOMZO5AVuBxGFF_itcxvdG=W9JoRtyzzeeC+wji__uUOQirwZg@mail.gmail.com>
 <CAOYdKdingLtAvEnth8mSnazQ2fZ_kCsM_2P_dX7tbL2xe9wyVw@mail.gmail.com>
 <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
In-Reply-To: <CAOMZO5ALK_O-648FaHFrjJc9EiU3J=nvv1rYDiLOGqhjt3mmkA@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Mon, 25 Sep 2023 21:27:15 +0200
Message-ID: <CAOYdKdjEOsLmkoJdxk1CmLk6_AJFZhuS_7fWxWOm14Av1n7gHA@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

That outputs LLC about a second after the mxsldr terminates (kinda slowly,
the individual characters can be seen being emitted one at a time), and
then about 5 seconds later, "Pref". But nothing after that point.

At least it looks like there is something happening, which is excellent!

Thank you!

Without CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR=3Dy, (i.e. all 3 PMU
options not set) I still get the LLC\nPref as previously.

With only CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=3Dy, I get LLC\nPref
With only CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=3Dy, I get LLC\nPref
With only CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR=3Dy, I get LLC\nPr=
ef

With CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR=3Dy, AND:
- CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=3Dy, I just get a single L.
- CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=3Dy, I get the LLC\nPref as
previously.

With CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=3Dy AND
CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=3Dy, I get LLC\nPref

With all three =3Dy, I just get L

Rogan

On Mon, 25 Sept 2023 at 17:50, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Mon, Sep 25, 2023 at 11:00=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net>=
 wrote:
>
> > I see absolutely nothing in the console.
> >
> > I=E2=80=99m wondering whether I can possibly execute the vendor SPL wit=
h a
modern u-boot?
>
> The old U-Boot vendor does not use SPL. It uses an old mechanism
> called bootlets.
>
> I suggest that we start from scratch with this imx28-wink-hub support
> that I have just added:
> https://github.com/fabioestevam/u-boot/commits/wink
>
> To build it:
>
> make imx28-wink-hub_defconfig
> make u-boot.sb
>
> Then try to load u-boot.sb via mxsldr.
>
> If it still fails, then I suspect that the power management unit (PMU)
> may be incorrectly configured causing the board to not power up.
>
> Try playing with the CONFIG_SPL_MXS_PMU_ options.
>
> From configs/imx28_xea_defconfig, for example:
>
> CONFIG_SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT=3Dy
> CONFIG_SPL_MXS_PMU_DISABLE_BATT_CHARGE=3Dy
> # CONFIG_SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR is not set
