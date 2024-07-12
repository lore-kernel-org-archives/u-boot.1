Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B5C3DA4D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 581FE887CF;
	Fri, 12 Jul 2024 18:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vf5sF/18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA088887CF; Fri, 12 Jul 2024 18:56:24 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B775887CD
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2598001aae7so1155721fac.2
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720803381; x=1721408181; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ENmzlz8oG1lIxwSuAXxldt3QI3ScZZkOUgt/NQ+NN40=;
 b=Vf5sF/18Sv8/fxhOIB9HgPHf7I8utYwMzGbVKELSa12QF+eWK8RSxieUvuYFi6EyS5
 ScbDe2nmQ0s3rKxY2KWiQAGQBy1BHi9MV12Re8uieBaKK4+puMoO2R9qrIg+jRjdGB9U
 PJVqJN8nmTOJ9KOv5lrzI/0cxC8eBB7uEifN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720803381; x=1721408181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENmzlz8oG1lIxwSuAXxldt3QI3ScZZkOUgt/NQ+NN40=;
 b=kuQbTefuygcC9SLrBlB1LEhLsgJXTvwrwdf820xdV26BJTaIKZK+4arzOiDd5iPZ8n
 9IxCS11R4gfr2308Uqnc4SftfVXE+3+dZTO5B5cFQhJWWdvpFtcEbGkPdSQQUaTU7Vob
 GDcGpn+DG+VuRKjgD4ymgW4cZgyfGEiSJygY99ufWSqnaCl77GQphickq2adPKC6Z8tb
 RMvZr6k0x4c5RsgtrEWpkdbiGKZMv9F5ax6N8FN1n1guRyn/iPfa1BMnxMZPN/iu2yzb
 LkjEutujOw49CxIKd0JVvnhGpf0SwuEuqWbpozd8xjI1wf1T+E1RYcaBn5JSwYsxhOkG
 ii4A==
X-Gm-Message-State: AOJu0YycOXdVhaCUKyK/M3cSE3l4RuAiBRjpCOYd0WwPfyPYcISZrNNZ
 JRYXUGMPVqwcICXrKnq1mkr6o088AbVJZR9w0RlN5fxREFug3wjfbkB0bb2A1J4=
X-Google-Smtp-Source: AGHT+IHXbQ98fVwgA7rOzpvQwq3jR7v0YbaNFLCPTO5Mv8gp1oGYnQo1aH8EPjyHeoYaFckmw6aTQw==
X-Received: by 2002:a05:6871:6a1:b0:254:bca4:d9e8 with SMTP id
 586e51a60fabf-25eae7b87e0mr8547556fac.18.1720803381346; 
 Fri, 12 Jul 2024 09:56:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa2a2195sm2276954fac.52.2024.07.12.09.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:56:21 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:56:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: u-boot@lists.denx.de, upstream@sigma-star.at,
 Richard Weinberger <richard@nod.at>, ilias.apalodimas@linaro.org,
 sjg@chromium.org, christian.taedcke@weidmueller.com,
 upstream+uboot@sigma-star.at, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] fat: fat2rtc: Sanitize timestamps
Message-ID: <20240712165618.GZ38804@bill-the-cat>
References: <20240712082454.8752-1-richard@nod.at>
 <E6A299D7-6DA8-4FA7-8864-BB6F346B4394@gmx.de>
 <2549250.Sgy9Pd6rRy@somecomputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xc4t99LFvB59GnHT"
Content-Disposition: inline
In-Reply-To: <2549250.Sgy9Pd6rRy@somecomputer>
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


--Xc4t99LFvB59GnHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 11:51:06AM +0200, Richard Weinberger wrote:
> Am Freitag, 12. Juli 2024, 11:46:08 CEST schrieb 'Heinrich Schuchardt' vi=
a upstream:=20
> > Am 12. Juli 2024 10:24:54 MESZ schrieb Richard Weinberger <richard@nod.=
at>:
> > >Make sure that tm_mday and tm_mon are within the expected
> > >range. Upper layers such as rtc_calc_weekday() will use
> > >them as lookup keys for arrays and this can cause out of
> > >bounds memory accesses.
> >=20
> > rtc_calc_weekday() might receive invalid input from other sources. Shou=
ldn't the function always validate its input before array access?
>=20
> It depends on the overall design.
> Functions like strlen() also assume that you provide a valid string,
> so rtc_calc_weekday() can assume too that the passed rtc_time structure c=
ontains valid data.
>=20
> In doubt, let's fix both FAT and rtc_calc_weekday().

Well, we care about size growth when at all possible. So what if we
don't sanity check in each FS, but just in rtc_calc_weekday() and make
sure callers handle errors?

--=20
Tom

--Xc4t99LFvB59GnHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRYDIACgkQFHw5/5Y0
tyxncwv+LwzyMPNxxviIZ1Or2lUR5AO/DXIDqUPmIhs+mNx7IpAOdgRS3jvKBT0J
e4nVlIm7CNAcXezZ5aARBctF2cDhJGJZAd3OAV5mjM98m8kKKD4Dv/5JlVcDeJl2
6PTsQTB4r7xnPJ6jma+SYPn5t537E08pLJ2eP1rufHVlNRusw264Rqe1/K1unw4r
lMXpLBX5O0Fs64f3xMd+XWgkOW6ucFd2Ek8W30Z0Lyawq0agz+Syy928n4q41hAA
fixi21Y7fOO97hktuha09cQqxuvnpWOkmfpKfrtFr1fVS8terFiAnPpwgB9aU4yU
1n7/wSg1Exm+IB98dXIZhOV6P9PWwq+t5TLBmQV5GgcuqS7C5rlDU3Ay6NhDUzUu
TXFUnZyROPNAA5AJ9onsSGzEVJDOLd8yajF9lcY/ygk9MRkEpWBMXomf04RVEgac
jr0P4Gu/V+i4tCiR1OURIxeDy+fW9k0e+b7vEVeNUoDHNB4fOIx4gFalF1Zi+tEh
86NvzTXc
=+Qor
-----END PGP SIGNATURE-----

--Xc4t99LFvB59GnHT--
