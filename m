Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517D6E6ADD9
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13D7893AA;
	Sat, 23 Nov 2024 03:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faXKg1QM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108A9893CA; Sat, 23 Nov 2024 03:41:14 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00801891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46353bd879aso18021661cf.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329670; x=1732934470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0+ohem/1sqso3IbupI/wOijxPzEj3zS44GDX1sAgmPg=;
 b=faXKg1QMYaC2BGcKnBytZGZSsq6Fl3bfnfgkcHqT8+59MjRL7SCiT/f+XxMf0BzQFh
 xEnzkypqrsRetjJoa/iFnVVhW2TODOZ9aFPHy1iRdVfSiB+fz+spOwWlKITCljWlomhq
 np+KGkLlXdwsnlvxgAy7xx5xJsp4l/HmMZroE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329670; x=1732934470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+ohem/1sqso3IbupI/wOijxPzEj3zS44GDX1sAgmPg=;
 b=UHyx/AagamIP491HJGqZTCY9v56a3EjwpJ7iJ3RFufMTIQxURVkWFgBXYk738ufmyq
 B1txNmXVvnBjbmrvyWxOtaHI3tVPRXkxDHUBfc+ptyDkC2hpsaebGpXkqBxWNb0Gfo26
 bWOStWaJdWLgqATibMsWYJK3z0YbAVsY6o10aXdjiqpYlIJo1PwzH7PWWXLJRZbBH6+f
 cGjGW95ywmV0EKC2suTiK3LLCMdBWlS1qP2BHjCwyPdv7y64BbI7tgsgrvVC07H7yV3U
 UQ60coLw/sYJwDcHu6I9orP/sIvruN2a07PI5VF9wkWxSYouXFQLd8Xi0942a1UM+It2
 Rd5w==
X-Gm-Message-State: AOJu0Yx8xW/5c8mTIIKUpY9GK3cTEP/YY2z+aLUvcjBW/MH4GMLXISJZ
 pNT2J1ipG80WegeR9XWnDcR5+1MKMjEOrD1IvjxrPLeBCB8qp7ADOUcJedHg8BQ=
X-Gm-Gg: ASbGncvI38TTZY1ekS+349s1KbDasiEEY0fI2rmCsjAEb2XG6r9GUdQmVAg268LQOdV
 P5IRCpYWAi35xC6UZryLUZbJjmZvzOxJ/aK5fwT11XFcPKwCR9SoAaxiNh0J1wT3VVbGQchtvZe
 e4DH9bCLXOZbIlIEqNNaceIXUpT9jM2M01SjAsDtEd9DvQEX4Y4Dt8iZmzbVSoSJupVhXaUrbdq
 wLJjf7tgyKJ30xMZorxdKTH/fx37vGunnRmn7xXSSVpbrc2LA==
X-Google-Smtp-Source: AGHT+IGuuteqGhgRcxOyweZiZXrYmbEMOR9IRsvQJ7vKhcCauUbX0KDtMtcS7IC1TXjRSjp44c9anA==
X-Received: by 2002:ac8:5a16:0:b0:464:888f:adf5 with SMTP id
 d75a77b69052e-4653d635524mr67633311cf.45.1732329669842; 
 Fri, 22 Nov 2024 18:41:09 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c0e1446sm19407731cf.0.2024.11.22.18.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:41:08 -0800 (PST)
Date: Fri, 22 Nov 2024 20:41:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Polgar <ppeter.bme@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Adding cross compile for armv7 to docs
Message-ID: <20241123024105.GL3600562@bill-the-cat>
References: <CAF2BDb-Nus00P3peuPnbtadzhWDvdK9C4R+5zHxsGGimMn_YPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Cgn8BLYJhUgYbeg"
Content-Disposition: inline
In-Reply-To: <CAF2BDb-Nus00P3peuPnbtadzhWDvdK9C4R+5zHxsGGimMn_YPg@mail.gmail.com>
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


--7Cgn8BLYJhUgYbeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:30:27AM +0100, Peter Polgar wrote:

> Hi,
>=20
> I have recently built U-Boot for an armv7 board (OrangePi PC). It took me
> some googling to find the dependencies needed to cross compile on Ubuntu.
> I am thinking about adding the info to the documentation here:
> https://github.com/u-boot/u-boot/blob/master/doc/build/gcc.rst#debian-bas=
ed
>=20
> I have a few questions though:
> Can I send a PR now or should I wait for the next merge window?
> Is it ok to commit to github.com or should it go to source.denx.de instea=
d?

Sorry for the delayed response. Yes, please do send a fix for this
sooner rather than later and don't worry about the merge window. And
please use "git send-email" to submit it and not a pull request on
GitHub.

--=20
Tom

--7Cgn8BLYJhUgYbeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQMEACgkQFHw5/5Y0
tyw/WgwAs3simoRoEYgM2lw+qwtI8MELYXt+DglJYWseHJ1GI424PaSKdyq1xiBm
DSFYZWebZbawBJ0TohYSkXHTBahSBqjjb/J+r3Rojot2YnciiGLrcSsJSPl15FH4
6Biqc4zeC7YT45dOTFi54jnw90bxJz1zx/aBS1vZOT2/NB3ZvJNLzE6uF47sr5DI
5XZD7zQS4P2VwDnKfu/9yx6Y8gKc4zrz0MPZHpoossDG83Gw+45g0RMgXqGMuqdK
9jQxxETGA2crB3pILSGQESPnbOo7VWx76MDgmpZJI6E272FVUOe7EVdm0adtdvml
myJ46lxa6HBq4KMk040pEq950odpKrtc+b4esqExU5cPIOYEWxmPCyxilNvonP/o
mCP8pccq11RBkWdf5crYgJETR7kRm5E9AV9O4gau0pUeutHpLsNwzq2zc96A3ZdR
Xwf0rqBr5Zm7BmoIrHyKaWD+llDCxKHB3f09e03Y25oYZPWLd+g1dlI5rDPFmHaP
OpRykPre
=ZNVY
-----END PGP SIGNATURE-----

--7Cgn8BLYJhUgYbeg--
