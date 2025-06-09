Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DA2C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AD88144A;
	Mon,  9 Jun 2025 16:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gmtoarBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311F1826AA; Mon,  9 Jun 2025 16:57:23 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F64A811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7300069c447so2912642a34.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749481040; x=1750085840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+LJnwA+EyCzcO+arv32mgrh1AsXGYudSVkEaEFC+C+U=;
 b=gmtoarBQZC2zpURaTGP7fBn8On93zmYW5jIljt2XdYcFHdVdAU2imzD81ac9ulEN90
 4ZNd6Stro+DE/Tx9eyNU50HdjcuVkjwSMeSdCH8LbSYaJ6mxHD22hjaxPSsWSIeuqMzT
 Kq9jeIyn2IHtwPM1pM3IBbDTaYY8PdwNMK9KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749481040; x=1750085840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LJnwA+EyCzcO+arv32mgrh1AsXGYudSVkEaEFC+C+U=;
 b=U3Pf44ImdFssMnNFGP8fKRxrzWXjeoRSg8QVdFI0yhVs6b1kvMDqSoj3BD8JkxmBhm
 rOMN8bXCh+vGcGksFtqU3GRk4OzXioYPHdcvGLUacAW0SjQTem4glcwjcK7DjWWb/oDJ
 r+2YiD8QyJTGzNZylM3GTzxTRROjryOeIiwg9vlbC6EWYqXtlihn9EllZdSVVtm9AsTC
 4+fm1r8Z7mg5H8HwQNahV2J0ooN8xckM1HeMBdhH11kNZCqNtiCAQhaRQ+zGhyVBf6wh
 BjelpnSzB3xWU/2Qf6GSzmWC4N1RwaoPlUFYOiXlSC2CxdHUZvucsRjv5Jl0PsMDwkMY
 XHCg==
X-Gm-Message-State: AOJu0Yyi00UpW9+y1PINQC4iWjugfZ6egCDec379HkQT2wn4Yzsj3DG/
 u7dTgjwuRoRTFdX65wECnGPK+flwvxZLG5qM7dbD0BNrOKxhP5M+7WdY/WD4hIsTMDo=
X-Gm-Gg: ASbGncswH0LVCeXHEQy5B/Syu9SaA2IeWuyuTsVj63ZZ5mmjLMZu/cpqy+FKnmlYcIc
 C+EQbUE6WeD46Yegm7Bp2lAZxBQSnj6TZ0tYDCOQ+KxP55tcyfsUDZRwZvV0t23XrVpA2dbUebF
 fEoIeHmKXX/5lkfKwhpcGpW8SZNNY5VFXmL1R+Ydu1gnkrNUzf5Z6FDu+yQ/9QjzVPGkZAvLYug
 wdKFhoVFahw7j4zHf5IUhP3WAeBwpFwhGsqRMFWcf51JoMI9fGtVKlPSGm2EKBqIGyMODIbeCuf
 47mIK6DzAQZsHABjT8chhXOb/TjZUlOQOPEdCvZg9zph+tk7yElFSJ1tW4kSJ/029Va0BxxjIfP
 8iw74/i0cDPbE7qEfDyrk0xY=
X-Google-Smtp-Source: AGHT+IHYPndHFVE1i5pp8do56YI2gecu11qk0/9IkFwbbBZeNMZLCC33YNWQKpGpgblaRkjGB68l8A==
X-Received: by 2002:a05:6830:3896:b0:735:ac82:1ac8 with SMTP id
 46e09a7af769-73888f0d470mr9864707a34.17.1749481039777; 
 Mon, 09 Jun 2025 07:57:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f2d220sm1591059a34.11.2025.06.09.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 07:57:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:57:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
Message-ID: <20250609145716.GM1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
 <20250606190956.GA1382132@bill-the-cat>
 <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Zp0b080Rn9RQrxE"
Content-Disposition: inline
In-Reply-To: <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
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


--6Zp0b080Rn9RQrxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 01:05:36PM +0530, Anshul Dalal wrote:
> On Sat Jun 7, 2025 at 12:39 AM IST, Tom Rini wrote:
> > On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:
> >
> >> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the kern=
el
> >> (dtb in our case) in falcon boot.
> >>=20
> >> Setting it in board specific Kconfig allows us to reuse the same config
> >> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabling
> >> falcon boot.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  board/ti/am62ax/Kconfig | 3 +++
> >>  board/ti/am62px/Kconfig | 3 +++
> >>  board/ti/am62x/Kconfig  | 3 +++
> >>  3 files changed, 9 insertions(+)
> >
> > Why can't whatever is using the fragment also set this? Is it because
> > you're only using this as part of say:
> > make am62ax_evm_r5_defconfig am62x_falcon.config
> > ?
>=20
> Correct, having three different config fragments with only changes to the
> dtb path doesn't seem very useful imo.

Then these belong back in the main defconfig itself I think.

--=20
Tom

--6Zp0b080Rn9RQrxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG9kwACgkQFHw5/5Y0
tyyDYgv+I5xmCctfOnYFVvqNxJXzTxzHfoFBcrjqYQFXYmXNsptR9qcU7nRkg9ob
xVm3uOoB89f3n7LxUcqMxuNZa2n61sd0TmtkJgvyQ4KnFD57pU7Winnl78KsOVpF
ALl9EgOn5yKsFUaiUZtFCFraf8UOuhA3JFRiUFZsLxLaA4n9l7KPrR2LJYwBoA6W
9sa/tAukf7hLJFSTdLkn4nnxG0m4otwYI8dJVZTzp5iOaKe5FjEZMF26kFg9VAYd
4/kthThMTl0zxuvPG68TSw5gYILmawme6wkVS5Z55xQcw/WXmvAApI6Y2XHEqsDN
JjGOQPTXO1ZXwWV0IchsPS3FjNGNzwJwodQBLPWD2RlNIKdyQCZwYM5oz9UBjevk
0YRPGSY0k60WsYDI2s2rFp2pDjwDeGqjr3sI2w3AX1lp536vDjU4guG00x3pYMUd
c8uYAJy6sx5PUtJv+2Vtm7jCQn0iJTN8MCQ7fPLf3dM+2tckwxrT8dF9Mx/Pxx/r
xp3iOdhX
=EV+j
-----END PGP SIGNATURE-----

--6Zp0b080Rn9RQrxE--
