Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE142C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BAF88151;
	Mon, 15 Apr 2024 15:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G/eOU55U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4706988193; Mon, 15 Apr 2024 15:48:45 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A37A88189
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2a78c2e253aso1099498a91.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713188921; x=1713793721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fsNHQXQvR7yNqu5Cwqa1Ke93kkCR9e6bfCqx0bPrdXA=;
 b=G/eOU55UQ8ZJe6vP96oh3OkqUpGIhTB9FS5sXomud4UEn0Hsz8qnrCnvbLtplnpqAK
 QI4pHaOygdxEsdPBIcpzHHKdfF42/uSLH9n+E+uImLe8lHpTULaDR/2Qjj1nUc+noJli
 iEt/970S3UZtb+w2YXBZ9qMmE9/koJh5Vuy5vA4k98XBD42Jh7DxqGEu/Kii5xXH2Nfv
 YhbXbNg199piDvc2zOAI6SLNmpJTgE60hSJ9wTlLRtAKtLv7CKjQS/0FeeQ8114cGi4m
 5Ls6apfXDoklGW7UJZDimKAzQQmuYNFaed/jgMLWQayLkDOvnl2g8mAOodWoeCpz86dq
 /zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713188921; x=1713793721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsNHQXQvR7yNqu5Cwqa1Ke93kkCR9e6bfCqx0bPrdXA=;
 b=XUR0unPp1xXBpEcfh8JSJB2/7zd6VlOPK1WbrCBfvJC9BgXmuiaHGqIIW/sR0K541w
 DRfIjYwAsU1YjQl63uL0CiodlGHO055wofS4HY2eIXMywcnXYmVp0RqrjScxi5Aizuis
 Ik8JyUU9nRB1FoMpaf45pI+spwm0KLwChjN8RseGIrYeRL/95+5HBzzyxL/0KZGBDuwJ
 XlU9X5LLd0MxM+sD8qZeQkv1B8G4jp7tdNfROpZojimKLv5h5rBbT5kFFl+H5OYUKa0L
 vd+zF4OAtaMjSHuMS0ERAtPlWdJ9z6KLxGIuj+mHX+BGZiXaCf8fMqGmL4evWtAFXdYu
 fCOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Pk6lJpl+E+LU7F9Ij8GsFgyz6L9RlJWFWezRwBhcrPORQkAg2w/ug5yuSwJEzTyN5gHo+LkLnIKUFfLkBU4Bwuy/vw==
X-Gm-Message-State: AOJu0YzjBg/o11uYK01Sa1nSLQRUg5PaQwN8gS2gHXlAlROnLkZDMRIM
 kLqC4Hhwyl4n6+83BcxgwP9Qb0UTVgSOeqoV8SpPznpvHb+kQcPAVnEYHITFB/gU3kmDf/SxZPv
 InNs/ucNqCvjmhcfcAKNawe89TPc=
X-Google-Smtp-Source: AGHT+IF3OrXXdY3CUNCqzw93l4s8brv7eU2yI868a+XeK5d0WJQQxu0yTtbAsWn4jmN34HNWlkM0EqB7ybt/PPU79XA=
X-Received: by 2002:a17:90a:d718:b0:2a5:4d59:950e with SMTP id
 y24-20020a17090ad71800b002a54d59950emr7495511pju.27.1713188921556; Mon, 15
 Apr 2024 06:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
 <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
In-Reply-To: <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Date: Mon, 15 Apr 2024 22:48:00 +0900
Message-ID: <CALu9rSZeZYyuCwBeUgR+sxMvmqDBh+Q5hyb-gtHP0U8ovHby_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

Hi Michael,

On Mon, 15 Apr 2024 at 22:03, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> I think I have sent some time ago ;)
>
> Anyway look sane. I was having the same feeling on code inspection
>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Thank you for your review.
I already checked the thread, sorry I couldn't find your patch and
I couldn't see whether it is the same.
In any case, I consider there is a potential issue about
wrap around, so I submitted a patch.

--
Best regards,
Yasuharu Shibata
