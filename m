Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D30AD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8345888B6C;
	Thu, 28 Nov 2024 15:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/q/R5FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55FA688CA2; Thu, 28 Nov 2024 15:59:10 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A4D88965
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea68cd5780so766006a91.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805946; x=1733410746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KAyqw9laPbGKUIjONAtUl/JkC88amz0jvvKWZBi8fC4=;
 b=C/q/R5FXgorV8XpSSw00yjr3TJlQAlezZricSF9l77JeBJ+Ide5MhdngXX85JSPFxs
 Vr++6x84RY+SEWR0DxG/hVTbBsHRdgOi95hxTECpRrBbGvJmnkMUepluKvauHMAoNo9A
 fNXD/QPfcgHkCaxIaAEs85E6mB0aeSc3P1LaX7B150PnaQXsMdcpVK8l9XBWSRu7WTLP
 fBHbgYmVi0w23QzNlNOUOuHE8jdz6n4MRcOiaonAZADv1IN+ixB5a1PwYa2Es8ZJ6AmI
 /kIAM9DtFDsOyhdAM2WANZIFS5GVxt42+rDoMZNGGY0XDFD5ZTdTkq4Rz1306IgWYGwx
 KzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805946; x=1733410746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KAyqw9laPbGKUIjONAtUl/JkC88amz0jvvKWZBi8fC4=;
 b=HuU1ciJ8Pjx+5aBF+Z2JqI0NzWov1KJt01XnnNJLJ6EAflx1EmzAnqIkimzrguySsZ
 eEMBWQFM49Ku2Ev1Mzo6rMhGJfgjqCppSVyHa8kU1pQenQqXJi/BWwjgocdyeXUl2eHa
 skT5xhclC8l1yM+jH8kbXwuGZmpZ+hVZPJmpapwWp6fZltzY54MXi113C82mNpNp/L61
 92VJM7pbo6krWYdf7OqWAAH6k2toy+jRpJcfZCq1NdrscvnFzMdK51TlZF8xaf/stAZG
 ho7Qbvix6KK0034QK6fL/AFfCdZm+rESscrxJFg5zql9r//cJTFvM0U7MXniofBQVZRN
 BPkA==
X-Gm-Message-State: AOJu0YxU1HaAFkBX3v/+IrqfgFmnMmqdei7ZqklvfjJqshjiAEhDUqRk
 guALno6Z3Bv4uP4iNxiv8QddzeYLxNpQTsbDs99xi+b/CCFUFotnMdBuxMkuFkSnMsiPVd/E3MX
 RWhJh1ptO/+Gc5FuctobeUdLYvtE=
X-Gm-Gg: ASbGncuavFtab+v2AVWNj61g+seN6AikEz0J+m/vMRtIlqRX/Ahi3sCuzKrSS3TQhs0
 oSiYI6wQneLsIgl98IcHVyhVvrRORiw==
X-Google-Smtp-Source: AGHT+IGoPYO8V+dN6fcbFcCV3mei3V9T61GGhKrnv2g7fUrMwWMxSy4sjzO38JQmUCJfbAoO/Q4Mw5KRuVyoiJ5yMDg=
X-Received: by 2002:a17:90a:da87:b0:2ea:8d1e:a870 with SMTP id
 98e67ed59e1d1-2ee08eb2a50mr9274384a91.11.1732805946145; Thu, 28 Nov 2024
 06:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20241128143642.590143-1-adrianox@gmail.com>
 <20c29b19-f147-4dc6-8fae-5d20d06fe5df@linaro.org>
In-Reply-To: <20c29b19-f147-4dc6-8fae-5d20d06fe5df@linaro.org>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Thu, 28 Nov 2024 11:58:53 -0300
Message-ID: <CAMGU2hVk2n+41qLiZwesq9okTYMst=HGKQv0fPFtSfZ=6fhhBQ@mail.gmail.com>
Subject: Re: [PATCH] lwip: wget: process legacy url with strncpy
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Ah ok, thanks for pointing it out. I think it is not in the next branch.

Il gio 28 nov 2024, 11:56 Jerome Forissier <jerome.forissier@linaro.org> ha
scritto:

>
>
> On 11/28/24 15:36, Adriano Cordova wrote:
> >     Commit 356011f ("lwip: fix code style issues") changed two strncpy
> calls to
> >     strlcpy calls in the function net/lwip/wget.c:parse_legacy_args, but
> this
> >     breaks the correct parsing of a legacy url. strlcpy expects the size
> of the
> >     destination buffer, not of the amount of bytes to be copied, and it
> will stop
> >     when the buffer ends or when a null is found, but here we want to
> copy a
> >     specific amount of bytes and there is no null at the end of that
> specific
> >     amount of bytes. The change is reverted here. Optionally, all the
> calls to
> >     strlcpy(,,n) could be changed to strlcpy(,,n+1).
> >     Fixes: 356011f ("lwip: fix code style issues")
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >  net/lwip/wget.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index 83ae8a6d15..af48d741a4 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -180,7 +180,7 @@ static int parse_legacy_arg(char *arg, char *nurl,
> size_t rem)
> >
> >       if (rem < n)
> >               return -1;
> > -     strlcpy(p, server, n);
> > +     strncpy(p, server, n);
> >       p += n;
> >       rem -= n;
> >       if (rem < 1)
> > @@ -191,7 +191,7 @@ static int parse_legacy_arg(char *arg, char *nurl,
> size_t rem)
> >       n = strlen(path);
> >       if (rem < n)
> >               return -1;
> > -     strlcpy(p, path, n);
> > +     strncpy(p, path, n);
> >       p += n;
> >       rem -= n;
> >       if (rem < 1)
>
> I already sent the same fix as [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-November/573054.html
>
> Thanks,
>
> --
> Jerome
>
