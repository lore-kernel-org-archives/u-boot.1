Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03828D3B9AC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F678972F;
	Tue, 26 Nov 2024 17:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BLyIWnED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0886E8974D; Tue, 26 Nov 2024 17:07:09 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A87789723
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21210fe8775so53120405ad.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732637225; x=1733242025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vvwdhFodHdaSuCnqWoiXLjVK1Fz51sFv1ITac7rsN4A=;
 b=BLyIWnEDWo1bTdTfIVnHzwnJW145gnojDkJIDm22U8RvJnjxR4R5oKFlmtg2E/YLK+
 y+qGxyCuoLvx98mJXhcejeiA+3jQBb4lYhn/ISyrhCCo8pTIEBobo8sBEbuCni5Ph731
 Zl1hcaJL4V4YSyqwil+HueLXjCN6ABb4zRwe7V3yQlO+XSWYlzCA4m+r+VZGApqnaygK
 8tYhkXq1IkA/2oiMDnlMVHAdRSnjagn1+6hJlDzUd3kL+9P4Ny0Rd0SKlcPwO+cYawkF
 XRqE3aI8S5m+eLZbRDYYOpv2/5RqBu6SSTFlK9UQz+RC1n6XuXdAXpuaEXk6h+Qp4Fah
 sJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637225; x=1733242025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvwdhFodHdaSuCnqWoiXLjVK1Fz51sFv1ITac7rsN4A=;
 b=eSzI5Nl0C/WYu23IeJw65evBLEVHj7Unm0COiWr+EFHO1Do2s7uCQrqXx5xgdYY3wD
 YduNX2qMzQbX4i3mHCJB49MtxsWaE6FtirBJvd1UjCflurzQhSWscpOaXhc02X6WUCGY
 A/JnVVYGdau4uBIfbxUoBTxzT8Hgv9gYAGghwLx8PQFD6kztnKlgGuJi2E1Tfn51m9bv
 L/nJyW7GXl2ydVKrRqE/UvZoM/ukzp22Z1hsHbFUfXMDS3vmtMzPaSYkxPdIZIRaNvQ3
 cBL3ZMVxQh4jeGZGdr5dMUiRu1tMPd3M0W0JgEWfmyAwHXCuq/seWeht8puIwL/475ow
 NCkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr9C+mo8XqeI3tYl4EfQJr2W3jf8LjuCV26ZUurh3nqYUR2TL6+xRnhMODBJXPhYlN7ZrMQ0s=@lists.denx.de
X-Gm-Message-State: AOJu0YwVpxtjRJYPihsU7CThvQxvKsgneCseadFVgPP/eFyWoX+AfoCa
 jneKH0gHzpuvkYARMVDH7jurfnmFt5Hm/cGcEbAZOzy2C59E8IBkH2YAt/DC75wM6aEiu4wpYRI
 m+kml5LrHjtHS/axbDMavALQAxZQ=
X-Gm-Gg: ASbGncvci6FtQL2DvIIMLenya53Pq7vERd1vL8Zp7pCP8eOxIHa5QamNijPJR7293og
 ob3WydT00PSti72CqBpHEcPjErsOy6A==
X-Google-Smtp-Source: AGHT+IEKsbxDgb4RnXpewtMG6EF+OcAH7r4iRGmZ7CC0Bv13XTnPqXE7DgBgaZGrw0rZ/h85LNJaXBcJsh6Lgk7vA+Y=
X-Received: by 2002:a17:902:eccc:b0:20c:7196:a1e9 with SMTP id
 d9443c01a7336-214e6e9ae08mr61826735ad.13.1732637224750; Tue, 26 Nov 2024
 08:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20241125171645.126487-1-heinrich.schuchardt@canonical.com>
 <612dfbc7-5b1b-460a-a12d-d7cfafdbb091@linaro.org>
In-Reply-To: <612dfbc7-5b1b-460a-a12d-d7cfafdbb091@linaro.org>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 26 Nov 2024 13:06:53 -0300
Message-ID: <CAMGU2hVt8rVEL_vapfw10aSzVnKoOQnDg=x9E2dyH7=Su7yAAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: zero terminate string with headers in
 wget_fill_info()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

El mar, 26 nov 2024 a las 12:35, Jerome Forissier (<
jerome.forissier@linaro.org>) escribi=C3=B3:

>
>
> On 11/25/24 18:16, Heinrich Schuchardt wrote:
> > Commit 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy
> > wget code") introduced function wget_fill_info() which retrieves the
> > headers from the HTTP server response. As we want to parse the string i=
n
> > later patches we need to ensure that it is NUL terminated.
> >
> > We must further check that wget_info->headers in not NULL.
> > Otherwise a crash occurs.
> >
> > Fixes: 2dd076a9c1b4 ("net: wget: integrate struct wget_info into legacy
> wget code")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  net/wget.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/wget.c b/net/wget.c
> > index 3bc2522cde5..b290ca1843e 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -208,8 +208,13 @@ static void wget_fill_info(const uchar *pkt, int
> hlen)
> >       const char *second_space;
> >       char *pos, *end;
> >
> > -     if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
> > -             strncpy(wget_info->headers, pkt, hlen);
> > +     if (wget_info->headers) {
> > +             if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE - =
1)
>
> No need to check wget_info->headers twice. Why -1? I can't find where
> wget_info->headers is allocated in the original series btw.
>
Hi Jerome,
Right, I will send an updated patch. About wget_info->headers, it is
provided by the caller of wget.
The whole wget_http_info struct ponted to by wget_info is povided by the
client. If none is provided,
default_wget_info from net-common.c is used.

Best,
Adriano

>
> > +                     strncpy(wget_info->headers, pkt, hlen);
> > +             else
> > +                     hlen =3D 0;
> > +             wget_info->headers[hlen] =3D 0;
> > +     }
> >
> >       //Get status code
> >       first_space =3D strchr(pkt, ' ');
>
> Thanks,
> --
> Jerome
>
