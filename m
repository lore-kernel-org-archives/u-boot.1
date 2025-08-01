Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48717C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 15:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D52383A92;
	Fri,  1 Aug 2025 17:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kuR8ArnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B54D83AAE; Fri,  1 Aug 2025 17:30:13 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8E083A8E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 17:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-615378b42ecso1779854a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754062210; x=1754667010; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPArJ64So+cYNxiUoW3U+xeNIjd+wx0qXMMPf/+pdYk=;
 b=kuR8ArnR/pJGhvWf6buC6o+w8QCinFDStVzaegWcdqmrUQyAk8Nm98GdzkbjXBiYKP
 MTEBK7CYTdZE6WgN9KLzMo+FFdY7tWWGFi2rMshqGpV+0pfDClj5QWOK2Wxu/D6SrLMB
 uI/z4sZM0uTR/pRzsq2wEGb93Ay5XAetGU85Mrd8Hf1UuLCVDgA0EhevyujNoo/9V+wU
 MvguLj99WYqF4o+z+8BxHJXZWyrCidodUvJgHA/22DyS1JNi+suOg81OYbWwsV63sW4z
 pkpz18Nwiq1PSuitNhv58UtdOBEf3c4rOjcF2PkG7LvVyApROF7DsbSeQg0romRdisvA
 MqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062210; x=1754667010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPArJ64So+cYNxiUoW3U+xeNIjd+wx0qXMMPf/+pdYk=;
 b=t+0JIgEcDcEV90RzZXQtZXVQdasKyTZAxBlcdFEbjfSJoPCysAgQyV4DzOEH4gHeCo
 RRtYpRAPiPz6X3VVGjzqPcB24ruG4O2XWm3Oy0i184Qxr1zCjBZcCPAVkWMqOZTDs0lr
 C5+eO73Zeu/5pNLR9F54fBoYNNDceK2DxliU2Gq6N/YK5YG/u3VZatGoFR5xtJFo0XzF
 InFPsGq6BYtM5V4OZZt9lJHE31hZMBZYKsKpYrv+6mtPQqgoIl7FqFgzST3NcWcDa5k0
 DUnWQQZmSTaxSHOjYAx3SixdCFoU+v7DmOosp7E+kFS11QQH7yUorzW8FX8bKlGxkIl1
 YAoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoCiHvHwQea1kDOXpKcg8H7AofkjNIs6LfknB7xtMFJ8FrCOEvxW1gZyeiJb7rpIMk/Tk2NDQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxiqmEWkFrm7Krn+TNBBK18VxtCNMI0WF7mqXyi1z3sUKMRWYkb
 pDQtcmmdhVJdUxiic46AyYcFXc1V+GfFeCLudpId5BKPwFgIfOg20wkjA40CDh0eVocD4AimIoD
 Hds317eXzb034QKdWHGjcqOexLNvkXw==
X-Gm-Gg: ASbGncv2X2tMJsnrUeo4LLZR/a8zSQOGDzBAZ1yJ2csvD7zyzPlTAH67QcS3/dRkesp
 u3M6VzDkSWgrtwpokr3FXO90SDTFP0jGinhy3RezeiVNbia4DTpAYGVOZE7h5ryqzXPXlv5cZJc
 xJjmGIUeWkXdDjIClGS2C6a9rE7+GjQyoFTiYokGhuYQzIcIozYC4yIDldFYeEyyE61EZc1LSd0
 RWBr9bEy4qJSyG21t9NQtePYGKfFnQv952XFiDxVVGYG4kSMA==
X-Google-Smtp-Source: AGHT+IGFh5wI+1hFhuXXnO64riuHNjWvn5gslYxn313QvSXybwmiCt4otxKifAa47PgCSrj2rnTZBB7rRkq3sDW5Z9I=
X-Received: by 2002:aa7:ce0a:0:b0:609:9115:60f1 with SMTP id
 4fb4d7f45d1cf-615871e56b4mr10298214a12.16.1754062210257; Fri, 01 Aug 2025
 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <d34b63c9-4fd1-46fd-a984-a22cc0dd3e0c@linaro.org>
 <20250801164333.1221fa13@mitra>
In-Reply-To: <20250801164333.1221fa13@mitra>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 1 Aug 2025 11:25:58 -0400
X-Gm-Features: Ac12FXwzZ0V-CfTdEDW9RPAyGtn81p4kuFeLQ6yQaR79uENB8w84NwpEQonNGFU
Message-ID: <CABdDSeWt9ttnsq+rrkw-_cj5tbe1iahZEmCqnujFGWJoXqqdRA@mail.gmail.com>
Subject: Re: Smatch report for ubispl
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>,
 John Ogness <john.ogness@linutronix.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Fri, Aug 1, 2025 at 10:50=E2=80=AFAM Benedikt Spranger
<b.spranger@linutronix.de> wrote:
>
> On Fri, 1 Aug 2025 12:42:06 +0100
> Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> > Smatch reports the following error.
> Fine.
>
> > drivers/mtd/ubispl/ubispl.c:782 ubi_scan_fastmap() error: memcpy()
> > 'vh' too small (64 vs 268)
> OK. And how does it come to that conclusion?
> What config - what extra shebang was used to get here?
>
> > I do not know the code well enough to attempt a fix in this case.
> And I have no glasball to get sufficient information...

Look at the line mentioned. It is a memcpy from a much larger struct
to a much smaller struct using the size of the larger struct. On a 32
bit system it's a 268 byte copy into a 32 byte destination.

>
> So please provide more information, what you are doing, what
> configuration you use, what is going on behind the scenes.
>
> We are talking mainly about SPL code here. How are you shure that the
> suggestion of your tool is correct? Can your tool handle code which
> interacts with flat mamory without any memory management?

Irrelevant.

> And last but not least how is UBI_FM_MAX_BLOCKS configured?

It's fixed in the header at 32. There is no configuration for it.

>
> Regards
>     Benedikt Spranger
