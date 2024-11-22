Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23D9D75E41
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 13:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F062C88C7C;
	Fri, 22 Nov 2024 14:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dp6+kVcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7747F88F7B; Fri, 22 Nov 2024 14:44:34 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 481F5885F4
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 14:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2120f9ec28eso16712715ad.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 05:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732283071; x=1732887871; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rCrP38O+KKR//zDBlQ5MYwkcJ0K3M7QX70SjJjDt6s=;
 b=Dp6+kVcMalJRSvklGiESZA28ZvF3HxKDJwLgypmDAw+XQH/5/IWO7HiGy8ETWHjW/O
 mt1v2DOqKXxvkvfYy4OnKvnZYVVluTMXCYbSf0Dlc6yeJloCeNNpO9SIFSnXKTzOigeD
 UueoUiWVN0pje3nhdUwXz+WEYxvML0CPoYCCrVXqBRaQGN7wzqEOlPYCDAwcr0mhlkc4
 dorv7N07TYkO2DknHZHSpwWitesu2l3lo+kVjFnKT8/lDYlo1bKgyHlyofir3zajvRpH
 7VBDeiXMwtuqPYPduo3QUcBvO0JyN+Z7brM6jYIUuyMJbJp82AuCfw3FF5fkfpiEHegG
 GSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283071; x=1732887871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rCrP38O+KKR//zDBlQ5MYwkcJ0K3M7QX70SjJjDt6s=;
 b=jU6S5xUsAk50rnil/E4hOId4TqmZPjVeZN+po0/GuYE2dSkoh47XO6xSPjHe7qOkzt
 Un54ie18nzPW0Yk822YLIrs3QJPKEBspDHdupMIzOIRWGlC1oOZzXncFSz/LyoFzRFhb
 etvdUmRxOnLYEPpmx41x4r/aYVrV2GRltCPAeFyujPqs3fjAcVSfQZQHZ2v1N8BDFDpI
 2UHCI1IdrU4oKNrGljGP4NZ1FzKWmsYly71mwLgEdld/L6hZIllq1rkpjuXMX49yNcdf
 wEPCA//G24Qb4Ucaw/3IQRXZSccx9m78OYRdyEWHV/73WkZpE/aLOg/fUsn95P3dKt1a
 n4qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7GueosSs7U0ja6HP4AAX5i5HbtJSuZI5YMZIFDUB0nFvnYoWxVJjtKe2RbAJ5/f6dZFM47Ek=@lists.denx.de
X-Gm-Message-State: AOJu0YwBQ0Wkv7gGaIjK/eat2DpxSU1gIzuYP+fcR3e96Fyz5NyQg3gf
 LEpP61BF5fMO2K27xpOAHM6tRvDTO3JfaU49b7Nwz4083i2cPM4GBfDOYoXFZcCJmtSOWd1tVTi
 KKLKcfVjdnR4nOo+Rhl488neI3mA=
X-Gm-Gg: ASbGncvf6Kdw9EcvPTfBAPE3QloZT7vA8d3r6AOUM2JE+znmekwqQ1icTLLPy+l+5fi
 2yrAeVTRMCTavV2ClGgrE+oADYCX4zQI=
X-Google-Smtp-Source: AGHT+IFWjLMyyJOwmTtOLk3wRmergAdTkb9i8z2/mV1M0Y2GG4YBobUhfC+qinABszjlt9iqaAdjGU21YnR79f8nsN0=
X-Received: by 2002:a17:902:e84f:b0:205:8763:6c2d with SMTP id
 d9443c01a7336-2129fe28536mr46515215ad.9.1732283070592; Fri, 22 Nov 2024
 05:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20240707082001.20746-1-michael@amarulasolutions.com>
 <20240707082001.20746-2-michael@amarulasolutions.com>
 <CAHCN7xK4YgEt7xaA6Ln3Q3GzvOP-iZM+YtZwP1Hg402VstBcOg@mail.gmail.com>
 <CAOf5uwn4T573-BDegO8giorZXeePbYszuo3dk1TEmdPvY0+dQw@mail.gmail.com>
 <CAHCN7xLgLwSv_EySui38ePeDqOfetWPi5R7dHJs+exVdZYnjHg@mail.gmail.com>
 <CAOf5uw=r=FsRRmD3tgONbxzCnv-rd2DS3d1bvt4zBHgQn1zomg@mail.gmail.com>
 <CAHCN7xLc0hzXmDaES9961jQ6fXtqof093Tga6d6748gxGYA+Jg@mail.gmail.com>
 <CAOf5uwnZeWTM=doUQ1P+OAoq3pnMPt060LtwaXt_Rnj+GBwjhg@mail.gmail.com>
 <CAHCN7xKg2jBJVfhvz2gCeTBgvMVR-mm0b-L_wEQsZBX4z0UHVw@mail.gmail.com>
 <CAHCN7xKCEjwyhfnCi3un94ssONdJjApMVo3FCRAydGd8Co34Uw@mail.gmail.com>
 <CAOMZO5B7Yedk3G022s_Uoqu=8v9Ds5qD+pg+UNjnObcWNWUv7g@mail.gmail.com>
 <CAHCN7xJ1g3KxzbOYJTONZN1z97mSUtjkHkoxyUSAo-g8DWE1hQ@mail.gmail.com>
 <CAOMZO5CcC4UksuwbR=eNb6cp=t5WLmO48q+yb22GiCfyCmo-yQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CcC4UksuwbR=eNb6cp=t5WLmO48q+yb22GiCfyCmo-yQ@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 22 Nov 2024 07:44:18 -0600
Message-ID: <CAHCN7x+_oYR3ndbjKgbB65Q0zzL99WWcHBGGd=hiAQGU6n48qA@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: imx: clk-imx8mn Fix nand and spi clock parent
To: Fabio Estevam <festevam@gmail.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Fri, Nov 22, 2024 at 7:17=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Fri, Nov 22, 2024 at 10:11=E2=80=AFAM Adam Ford <aford173@gmail.com> w=
rote:
>
> > Sure.  Do you want me to test it against a specific branch or the
> > master mainline branch?
>
> Master branch, please.

I should  have a response for you by Monday.

adam
