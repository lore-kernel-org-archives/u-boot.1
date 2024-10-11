Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB5AD1A427
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 22:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E47B893D2;
	Sat, 12 Oct 2024 00:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ifXLrlZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA968893FF; Sat, 12 Oct 2024 00:54:45 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD5B893D1
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 00:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7afc847094fso160425685a.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728687283; x=1729292083; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G6pI54ellQ3g8vczjgkql8Xsohzj6LwWyMmoK5D6i9Y=;
 b=ifXLrlZ2QBfGFZUL53XhMYNOuc8dGrLEA/oU6HnTBQTE0Qsvb7+Eb/hth1ZqLvCUgW
 om6ufPDAjJVr/2ebvHhKkh9VGyn4VzMzahA+ios+yIWXhzh9gNwPq1miw5k8jCcKLVK5
 CqMotWUvaxYWsS0IQ8Wm5C5wtI+jZNedgPgKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728687283; x=1729292083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6pI54ellQ3g8vczjgkql8Xsohzj6LwWyMmoK5D6i9Y=;
 b=LT5X99A489l3xQ/dtLi5btWagWzmC6pDwn4L9FfaMHVUjgXUVClJ6jb62GkOcG8yAx
 TdkLzs/qauv30WHFonYPlYLqdp4MSb2JIU/I0pMbmxCzn0YCe0istlONE//t7Yk33Qf5
 HQzrO0a7LpZxsgNgUQVTQNZ2FLACto3Z2XeluaLoZKXQz0y0bahl9bjfQ08a/eFmp1jo
 2qORJT/pIOyI99X5i2zKJsbmAsZ5iRbILW5fpwzZh2lkrepvn4cAp8CICTNpRdoMRENQ
 FlvKz1ei58e43uMtBKbbezeDEJ5vIjjAYlwZcRr38qTKdeEJHhZK9oHr072mbbU0Fsyx
 dvkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR5l5mcZZhtjHuAUBc2oTCkAwzTW43xC3N9pv39DTzZn50icRGOBYVfw6OgJ6faOfrAPnUrOU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/peDhSkjVpj7YsrNx5wsOkOrYf7Y8OmzzTG3RrSNqK3ygFN/x
 6NufuBAhabnMSL0EQqaLxeTQRR3JVWAGt/vwYnJJSZtqssQIK80ZAJkMbksteVk=
X-Google-Smtp-Source: AGHT+IGUtTU5MFY8a4PvwSaYFbUgFoUAR0BE6LLgFa4ZpZ6pTZrpwbl5zStlzXfMH5RsdfmpIXzjAA==
X-Received: by 2002:a05:620a:2947:b0:7a9:acd5:1b08 with SMTP id
 af79cd13be357-7b11a3a753cmr564430985a.51.1728687282588; 
 Fri, 11 Oct 2024 15:54:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604288208fsm20204831cf.76.2024.10.11.15.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 15:54:41 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:54:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241011225438.GA14210@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <CAFLszTiGHhU3LgUu7bv-oYd3b-4Y5-OY=LZhTGcQ4vvpu80r2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kA0x/xT8+e1CEUD5"
Content-Disposition: inline
In-Reply-To: <CAFLszTiGHhU3LgUu7bv-oYd3b-4Y5-OY=LZhTGcQ4vvpu80r2w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--kA0x/xT8+e1CEUD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 04:18:07PM -0600, Simon Glass wrote:

[snip]
> No other subsystem generates ANSI characters when U-Boot starts. Why
> are we creating this problem in the EFI implementation?
>=20
> So please, I very-much want to have a way to stop this output from
> being generated, not to filter it afterwards. As above, we should
> design U-Boot for easy testing, not treat it as a black box. Please do
> seriously consider this as I believe this is an important testing
> principle being violated here.

This is, I think, a good point. Outside of user-facing interactive
code, we don't use ANSI sequences for printing information in
U-Boot anywhere else. Why are we doing it in the EFI_LOADER code outside
of personal preference? And, can we just not instead? It does confuse
matters (as my example showed) when problems do arise.

--=20
Tom

--kA0x/xT8+e1CEUD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJrKsACgkQFHw5/5Y0
tyykIgv9HdVWMADVxBpc5CJUeaFE5prIG3cRdGd45OC9i7L4AfESbGG4jiMQxuuX
nY5NEYBB0VcQKMhkgHwIYI7pcOrmdI9t/U0cUaFGOdO1rCmkig2Wc6HASNMBtAlA
I03FCE4DcLRtEQei03zFn3WAhz8RxEKTMT07XgNIbUmgT7aK+QnezuvSmTi3dmnV
IznHba3meDE/uZ6P0RtcdBwPbMA1QwU7onYOZsjO0AdO6fDYtLHJNlVkZXHJZD5V
2temYnh25kIqZ6/+uWnI8SlmUoS5H8UbHmNItOTe8He2JIK151zQ1vADCbQqKdlP
OVjOskDo7r7SEh2nEw4WVVuCQGZKiinXxAyr1FB0UCRaVFzNz+1YfsCquro6Ez1K
hOjMgSiNk0S9gmDXBRLZnjOkg0hheBHpti6AyZGSBwZi2GYkd6bdUD1AJaqH/vN4
bkzKATtFuriLrLnK1iMN39HBdz/p2j5JpMzGn1CEHNcgRpQS3gb8rKnFcaVEPlF6
qX2AbBcJ
=2yhU
-----END PGP SIGNATURE-----

--kA0x/xT8+e1CEUD5--
