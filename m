Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CADC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFB78323A;
	Fri, 30 May 2025 17:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="NIlrJpNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CA88323A; Fri, 30 May 2025 17:22:26 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AC382CB6
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-708d90aa8f9so20749457b3.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748618543; x=1749223343; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVNND72ylskTzxN7xzuzx1l9EaZCstG0vawsFPWIN9E=;
 b=NIlrJpNwTPuWlZSPErgMwf5yN8k0U+9kd0ZldVKQTeRCm3KvuOcmKENXc4rz5bzJRg
 ldqXS388vyFi1Blogvhn3zU/1/n7Ntfx22PZ7afAv0r9Ir+55TAKSDnJOkCN8/bK6U92
 1BsfLHgsImRcNoY+RbjdmKBQox3IB/XxKRTFfHTn5j2KDwLlk5rAcAdTlIFFz5LNaq9B
 mKSU8Hx5a0/LEFRqZZYWlqt4UAvQf6oLKRpn/4LIyCCpmU1LDfwM9kHNbEU1UGfNSUuV
 7Qr2pPym9EIXjxqP8EytD8ygRZvLfDmarBub+yTudUjyEwK6v1R4539h+yeoAF1XH9VI
 IjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748618543; x=1749223343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVNND72ylskTzxN7xzuzx1l9EaZCstG0vawsFPWIN9E=;
 b=fl0owts8J6TEEY0XeOZAbB+0xmFST4r86L1QI0zDX0EPCSa1XKCRyEbteSzQGQcgz0
 Wp0Wv5G4Cq5pewjkMr/uNR+4bAJ8+uNQmJvMz/DeM3ygeDc71sEYZn7sv6qEz6EIC+VD
 s2wppaJSmMUO6upkYI10bXcKdyYMl+KHcdwrzi3YU/r8nA6GifBJaRyE1E+tLk2Wjbie
 QfldC+jTfL8I7zd3gd69xnh9wGMFiZ/j8fEwKi/nw3Sj9OKDya9L50BMiqx18cKguj4I
 Dbg0UPvhulUnBRA66EPsnnWCvTy1XI7JIoQGdBFYtxM7FA7OCrqM1Qricv8kioV6v9S5
 MRrA==
X-Gm-Message-State: AOJu0Yy146EQ8FwjMyBr6PtOsZTT/w/QBKey+e50uIUeQw4QpuiHzQnJ
 5b89QtCtOljkjHktkt2bjLvBMpT0sV3X9caNZ75SLdt57X/AX6Xqc04qaGZIsbBCUwbv9BIzwU6
 DS/7XCvAqJ7Xknmkbpl5sIue0E7Eatjn7tZFfvAMrbw==
X-Gm-Gg: ASbGncvJxLiv2iKFYJegoU7UCzmML+eV4D/GVF9drf0gM1LcNj9y1FNrGQNtRI8/uPx
 qYGK0PA615VfUama149SDKnxy3VHPd3cGZWXmoGQPdCpjwgXIlIyHUcclRoILj4pH+KiIo1X/Fg
 yV7sqx8xLPguw/sEOW1sz0Y3NPl6W8cBWf
X-Google-Smtp-Source: AGHT+IGk5/s+fLNKGajJiZ3oJCtH6YbTOCeND4MVMutnBN4OrG0+Yprk8efYO4AnFbwgr7DPraxoli90rxMYEm2nDDw=
X-Received: by 2002:a05:690c:ed4:b0:70d:f47a:7e3f with SMTP id
 00721157ae682-70f97ea6787mr56780867b3.20.1748618542652; Fri, 30 May 2025
 08:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-6-tharvey@gateworks.com>
 <b19493e1-b79a-494c-a150-300969eaee5d@linaro.org>
In-Reply-To: <b19493e1-b79a-494c-a150-300969eaee5d@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 30 May 2025 08:22:10 -0700
X-Gm-Features: AX0GCFtQVWozE__rRoqM505JI8kLOc-djCNkWmp1KWPjU6crpVbPvgmIq0JTcPQ
Message-ID: <CAJ+vNU2j7yniHBoZ942KNJSLHhN=P4ahkmaKa+KJ8Og1fTqomw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: lwip: wget: use loadaddr env var for default
 address
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Fri, May 30, 2025 at 1:03=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 5/29/25 23:49, Tim Harvey wrote:
> > The loadAddress is optional and defaults to image_load_address
> > which should be initialized to the 'loadaddr' env variable like the
> > legacy stack (CONFIG_NET) does.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  net/lwip/wget.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> > index 76401991bde6..ff8dbdc08d9b 100644
> > --- a/net/lwip/wget.c
> > +++ b/net/lwip/wget.c
> > @@ -579,7 +579,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char * const argv[])
> >                       return CMD_RET_USAGE;
> >               url =3D argv[2];
> >       } else {
> > -             dst_addr =3D image_load_addr;
> > +             dst_addr =3D env_get_ulong("loadaddr", 16, image_load_add=
r);
> >               url =3D argv[1];
> >       }
> >
>
> image_load_addr is initialized in initr_env() (common/board_r.c) so this
> should not be necessary.
>

Hi Jerome,

You are correct - not sure how I missed this. I'll drop it from v2.

Thanks,

Tim
