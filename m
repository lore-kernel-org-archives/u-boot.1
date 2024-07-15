Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372ECC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B483C8881F;
	Mon, 15 Jul 2024 15:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZhgiYXYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7548885E; Mon, 15 Jul 2024 15:25:03 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EA887F9F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5854ac817afso5370252a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721049900; x=1721654700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jlJWKMKuLhrEsnNGF3bTmjxX7JTBboX6csdvghT2tbo=;
 b=ZhgiYXYmVQp8XIV4xFsQWr23jPnDA3XJW/IwvFO2wv3QEmFJqD9gjNetEgn2p8tuDi
 PRzATqJqhmtglW1ZknFd/sWh4AXKMd8s3k0F+x0kdjwd8dX6p7aBAc1H61OnzB1134MI
 p0uvXITr++v+NNlw0cRkgbmZe0zdLG9n9T0V1mR40j5O2c7fyUKWJJgmYMa35+LNGyIV
 QBgzC1PtDTWj5qhcInC9fVwWTSKiHPGtjAvEv8sqM+6v8qeMUl18fJr/OGVlzqANI+q6
 UYD7wAdruyoyUlEecjybZoXCf4e65C964KxhlNo2+v/rYpwRk4ozIuKEmyYkL8CcbSa8
 Xp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721049900; x=1721654700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jlJWKMKuLhrEsnNGF3bTmjxX7JTBboX6csdvghT2tbo=;
 b=RA6pzjdTkkFZM2YNRa7ihfFQpTTm7uO8VmksUNtmVDXtBheOnJiQbsVlcMe6Fk0axi
 2eNPcvUogq8PixTuAlpkSi2NLRt2tluTqDbKVbDpJZYROIKRGzcY4EgiKKsCtAnBL9w8
 CM0TLfEUJxUr0ShlUA+ywmicoSqlD+suFVdodLrc34h2CWvU6ZhErBl8k3R79Gm1wWbQ
 TkKGd9HA7Xf2a7oK5snpajn8A/TaxN5WYzFbncqueUeGEpezPcd502bC2zAkXiwrI07F
 cYNmwOAJiGfbz5mUUOC5SRh9BP3+yyfbXcfhwZCFGrDoDIXqmEjZ6HZyubUSQ7or79gU
 wiTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUt1x/67KEuCeIcxN6FQjlYfxWd9BvL3gEejLi8etYu2JbvwZQh4yyZ1PDWYMku966D+6TwOylxrj/nG+k0S8oFyqR2Q==
X-Gm-Message-State: AOJu0Yy6FLDnqo4aSEwvpeknehKrupUvbgB7HqLpbgm8AslltJI5u+Ny
 +gJSDYoI2ZfRvAQHNxqXWeaWDYnwtwsCTHBN9QHoQ7l+CRZyFxSk3nZjs11RfWDVfDSqe3yn2FQ
 EitKeUcWKHId4AyPDpH1dKHvha/xkyw==
X-Google-Smtp-Source: AGHT+IEzjIHkwXDtR0a8xaonr9Hgs6LLrwdnhAQkGbADcfOwzm/QwbyCbXOSEPsscQ52ABXqC0ysVl34bkzyop8X5r0=
X-Received: by 2002:a05:6402:3406:b0:58a:e73f:6edb with SMTP id
 4fb4d7f45d1cf-594bcab0181mr11530633a12.40.1721049900210; Mon, 15 Jul 2024
 06:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de> <87a5ii959q.fsf@prevas.dk>
In-Reply-To: <87a5ii959q.fsf@prevas.dk>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 15 Jul 2024 14:24:48 +0100
Message-ID: <CALeDE9MsL-DR5+6ce97r4osSwNNo9SAaepYf3rsr2-ZdLuD5bQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] a little RPi watchdog cleanup
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

> > I can't find these patches (and v1) in patchworks. Do you have an
> > idea, why this is the case?
> >
>
> Perhaps because they (v2) have already been merged to master via a PR from
> Peter?  commit 1ca216522d4.

They were there, although weirdly they weren't assigned to me and I
had to dig for therm.

> So one has to change 'state' from 'action required' to see them:
> https://patchwork.ozlabs.org/project/uboot/list/?series=&submitter=&state=*&q=hw_watchdog&archive=&delegate=
>
> Rasmus
