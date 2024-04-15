Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DA3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388E187E75;
	Mon, 15 Apr 2024 15:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d2aTGHjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBFC88089; Mon, 15 Apr 2024 15:55:50 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB7F87E4D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57030fa7381so779333a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713189347; x=1713794147;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziyggO0UXD4QzVByrEkS5yy3e6nCGZaHjPfkjk/+FzM=;
 b=d2aTGHjwubQSExLpdmjGKRv7xpiqil03BRmWddx9Lz2l1W2utRqnMCyMfnw17Xrk8e
 Tp22HbpllpEIObzdaSwuSiDIeOOOH9XrB419K/1aX2r4Xu8h6JcC7Y0cb4qCu9HSH7kU
 Cd33pQnTxgK9VGvDCPq7RmFhz3P6LXIHmjKvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713189347; x=1713794147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziyggO0UXD4QzVByrEkS5yy3e6nCGZaHjPfkjk/+FzM=;
 b=M7yaHRWiIYjW3N6N8TuNOp+szz/bJeXOM4O9MDpK1Bo8J7mU3eUE35jaX1eyLB6gLg
 N0K2ICx/nkWEZrbn0ajvrD+YRj1GJ/vP0OlXUK6AGmIs5abubgHax0SQALasyFW5dqZD
 9N3YY38Dpyt07d8gNg5hh6INGQC6TGC6iMQ6u7jrCR1KABEFioOZ/n4/ER2VucegsxiV
 urjpcCXZtt8Cu4W8p3SA7qnUryI6TiHg+yEWE2rBq/jPS+08VlTCMHHqj4572JuWn50c
 cM5yDCshbHNmzHxpooStaj0MuDwEZFm7FG6S9zes4jiJI84diWnoreYTSpZiMEM4v/DL
 Q4ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaU1B10IC3HjXaf1Go8THUcySWvD3g0og34cih9OLw3mio9znG3ulAcjvHtZ24cJKqU5cgNRCDep83H5xOk2wnyssZLw==
X-Gm-Message-State: AOJu0YyiAL7nqFpFD9loK4KzuQvzBA9fIOKNOBg8o3oODqdyxepcSkdM
 rNVd9z7ndEoPXaR4oGyaakiAwKsvBheUazISUjc3Zjr+5VqQ/hQXfGbDvC7i3uep9ZareG5U6gK
 rbWEIcbTGL5Fy4n27AlCcgq2vP+zzG9TJU8bUDg==
X-Google-Smtp-Source: AGHT+IFihQ3YhxiLSFd8e6oXjeEtrfIRbvvL4m0MKbP1k+/2KqUjzNZDvn84orLOc0SLudcFITWO7w9wDfdxkbN8+WU=
X-Received: by 2002:a50:9ec8:0:b0:568:32cc:f808 with SMTP id
 a66-20020a509ec8000000b0056832ccf808mr6368936edf.15.1713189347555; Mon, 15
 Apr 2024 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
 <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
 <CALu9rSZeZYyuCwBeUgR+sxMvmqDBh+Q5hyb-gtHP0U8ovHby_g@mail.gmail.com>
In-Reply-To: <CALu9rSZeZYyuCwBeUgR+sxMvmqDBh+Q5hyb-gtHP0U8ovHby_g@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 15 Apr 2024 15:55:36 +0200
Message-ID: <CAOf5uwmqeMKKyf6-vxOnUMisHNZ24TupMRd_M-QT4JdtpnaFjQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Mon, Apr 15, 2024 at 3:48=E2=80=AFPM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> Hi Michael,
>
> On Mon, 15 Apr 2024 at 22:03, Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > I think I have sent some time ago ;)
> >
> > Anyway look sane. I was having the same feeling on code inspection
> >
> > Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> Thank you for your review.
> I already checked the thread, sorry I couldn't find your patch and
> I couldn't see whether it is the same.
> In any case, I consider there is a potential issue about
> wrap around, so I submitted a patch.
>

Very good job ;) to fix it. Just add Suggest-by: ;)

Michael

> --
> Best regards,
> Yasuharu Shibata



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
