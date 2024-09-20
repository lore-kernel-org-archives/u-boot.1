Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEB7CF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 904B1893FB;
	Fri, 20 Sep 2024 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aj5kTxhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC33893FC; Fri, 20 Sep 2024 09:25:58 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9238940C
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c351809a80so12741596d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817155; x=1727421955; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uwqBgQr1x/wVX1RMEkUkDGFthmRqBDwmXkD/Lu5rOJc=;
 b=aj5kTxhZ6ubiR92wP6UrfZdm3KPMuRHOklwHVB5F13sLofNGKbxPRZpF4FY70gKRdi
 Mi7mpUm10DOnkTEPYkhdYQmdz2zbG4uFlAC0LltBPoElpRJTEMziYLME3PKct77MS4tj
 toumJoFEgXjBYY5O99M0ixVVr49Qom+SUcJQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817155; x=1727421955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwqBgQr1x/wVX1RMEkUkDGFthmRqBDwmXkD/Lu5rOJc=;
 b=ghRBY6vZsEp+SWmpHVU8pc52ykhgfH9wixYu3K4tk4BmtY/pQeQC4DgiCazTY8vsIE
 E+pPOG88w9Y/c+NxSRa6OvwPEZr5M1je/6p4YTmGDJqk44jANamYhPTudDejEJlDt7kt
 0xBwBoI4NUHKeZTFgFmOHDjeEmPx9d5sGhALdD6P3XblRKr02Mo5gu3uSrWSOhkFFE/E
 udzBsXT1J/hMytgPgbqzNeHafWr0wDRUQN3B9+HfRHy3rT7B1r/eg3vFoGudhAj29nRW
 Zx+/jQkt2txmgWvVAsdAVyFXapFy0/cUWBKQjrlDuff3TPILqu+X6YMaBLwOuPbD6iY2
 Tnzg==
X-Gm-Message-State: AOJu0YzrfMGIqx4HbkD9VYofZcCaY4j1uJgJm94iDDFYU0QbxtU2lA9k
 d+zLh+hFkyxlzli/7yT47n5nevHw8SZ5qFw28t0+WsIT+ZmiNb4QIjSK03SDa308thQmre5BU79
 aJpFGZtnYibi5ftcVpFyGbcetqdN4zGMuZrdUX34TDzWYA9Cc/ocW
X-Google-Smtp-Source: AGHT+IFomFnTwOd0ovQxqAW4WN5ioY4oxqTQVFbzMOKCIDegXxT/6tjkCceHdleftiAboLip+HrZoCVyksQyW84poyw=
X-Received: by 2002:a05:6214:5886:b0:6c5:166e:566c with SMTP id
 6a1803df08f44-6c7bd575628mr24828216d6.28.1726817155429; Fri, 20 Sep 2024
 00:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-7-sjg@chromium.org>
 <20240829172626.GK2479150@bill-the-cat>
In-Reply-To: <20240829172626.GK2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:44 +0200
Message-ID: <CAFLszThacdwBNMP8Rq3uEXd=MT-8NpVXHOjhcMrdvLR-KrNPXg@mail.gmail.com>
Subject: Re: [PATCH 06/19] malloc: Show amount of used space when memory runs
 out
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Thu, 29 Aug 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:57:49AM -0600, Simon Glass wrote:
> > Show a bit more information when malloc() space is exhausted and
> > debugging is enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/malloc_simple.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/malloc_simple.c b/common/malloc_simple.c
> > index 5a8ec538f8f..f2b3dc53689 100644
> > --- a/common/malloc_simple.c
> > +++ b/common/malloc_simple.c
> > @@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
> >       log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
> >                 gd->malloc_limit);
> >       if (new_ptr > gd->malloc_limit) {
> > -             log_err("alloc space exhausted\n");
> > +             log_err("alloc space exhausted %lx %x\n", new_ptr,
> > +                     gd->malloc_limit);
> >               return NULL;
> >       }
>
> Since debugging is enabled you should update the error message to say
> what the values mean...

OK, will do. This message is shown without debugging enabled, so I do
want to keep it short.

Regards,
Simon
