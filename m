Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F320910AB829
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 21:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6779981E18;
	Thu, 26 Mar 2026 22:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="be3piTPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB7083CF5; Thu, 26 Mar 2026 22:08:23 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C89E80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 22:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-46704177508so837350b6e.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774559300; x=1775164100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXHzJV6v6G11dKu2Zv/Ce+seUcA8oA1lpx3tqfnWol8=;
 b=be3piTPihtfXwQ6/cTC4ULe2zYdAw4AuZJ7m6Qv8/rsQ1y+kvLwsqDPDbTuO27ebmI
 mQjaIoprCaYxr4zvt4yso7QlJzPUlY4wNZDudcF8rEGOZPSgnu4hhmi7HlxyBeWA+Yle
 vbEryVLOdcd4NYwvDy1D96bHjhRyiOcs3FWSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774559300; x=1775164100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXHzJV6v6G11dKu2Zv/Ce+seUcA8oA1lpx3tqfnWol8=;
 b=d4oTcOm2TL3H2HyqqB8tJWmffMWPnv6JT5EcpwPPwqQq9enWmI/+CYhP+gG/i34fmY
 ccN7sQAFVtgq7Kyj9ovIUSGBuiSmGGC/tGX0ty2sp0+QcD7TxZLju1tFVUPiVl58ajPs
 8oJDOtx0oBq1E6SNAS3K2rFEbJnkH6YEzaSuxbZ7VzH+OlEbNG2qvBSUOeHqFa4pBwjj
 fpviAdFSCcgqzKVKZyh/J6EEx+6QZ8oHRLIcdVU112PRm0YHC4/3ZdTXLzqipsP88IlJ
 lKtHGXKsmkgaU5tsYgWJvuu5Y53rd8uOTvgfFkDxA9s0OKvGYHmotyePkKwzrxcg79JD
 XXtg==
X-Gm-Message-State: AOJu0YxRIJNSaOwhiVQx462YIp+DoUrffu4e1zRgNWlppD64XZS0pBFn
 2xcsbk/ZxYBhS05tURv1y6x2+PI3BtlQygAI6kl5W+iKFIu9nG4A5qJVE8+RGprWCj4=
X-Gm-Gg: ATEYQzxMnJFC2/zj1tIscfYqb5iOk5KpjOC8TZVOM1l4G/wC5uNbUiIWxzk86+YEC/k
 M1UnyQzLr3KuVzK0SBAcgyq2+uN7D589UxXTUKHYx8FozzjDPZOrCJKfhMIA/rcvtTyLW8e7W4K
 I8sS0JIUeC+VosiWAZuUaOAJSp5GT6nrAPZ7I2RCWs0/aYaladC1mKOoyveYdqXxQ7Wn/nsGE6G
 dqIWoO1TN+wMogRGDiVxl2gKaIeP8+iYxVEQweAIDQP4EJQ+99graWRhHiJow08BJLXDwK87h/i
 WsM6e5cRq4PN7MsohpQAUF+3d92fIhM2vchu9L8pkmTDZPv2dQCJX2OL2KjlTo+3TBzzgqKDwvg
 9Vwv/WsyTULhowLVCxa1NJVfdXOA24NI/4+xtv8EGNfJv2Z9eV1pezNQMma+cDqyOzNm5YeZ6/h
 e5tL64fYKds6cGnVZ/7Gt5MQD2TM1DJ1h16cOD/ApMAg8JC0RVPLkiuDF5aqSBcWbhFASBNA7Y8
 u2JzGPDFHBaN7FUx+9dFN/cLctagexGZ6pyFW9ruJ+p74+N
X-Received: by 2002:a05:6808:1c0d:b0:467:1e5:6768 with SMTP id
 5614622812f47-46a5c77f2b5mr4445469b6e.43.1774559300195; 
 Thu, 26 Mar 2026 14:08:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41cc775deb2sm3437975fac.1.2026.03.26.14.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 14:08:19 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:08:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Tra Ngo <S4210155@student.rmit.edu.au>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>
Subject: Re: [SECURITY][1/4] Stack buffer overflow in NanoPi2 board code
 (CONFIG_SYS_CBSIZE-dependent)
Message-ID: <20260326210817.GC502704@bill-the-cat>
References: <SY4PR01MB6316CA7533B4F9E6D5899EB09A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qV8KqbEEaSZy2LOp"
Content-Disposition: inline
In-Reply-To: <SY4PR01MB6316CA7533B4F9E6D5899EB09A56A@SY4PR01MB6316.ausprd01.prod.outlook.com>
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


--qV8KqbEEaSZy2LOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 04:41:04AM +0000, Tra Ngo wrote:

> Dear U-Boot maintainers,
>=20
> I would like to report a potential stack buffer overflow in the NanoPi2 b=
oard code (board/friendlyarm/nanopi2/board.c, bd_update_env()).
>=20
> The issue arises from unbounded sprintf()/strcpy() calls on a buffer size=
d by CONFIG_SYS_CBSIZE, where initial size checks do not account for subseq=
uent appends.
>=20
> This is configuration-dependent and can lead to overflow under certain se=
ttings.
>=20
> I have attached a detailed analysis, including root cause, reproduction, =
and suggested fix.
>=20
> This is part of a set of related configuration-dependent issues; I will r=
eport others in separate emails.
>=20
> Please let me know if you would like a patch or further details.

Thanks for this, and the other report. Please take a look at
https://docs.u-boot.org/en/latest/develop/sending_patches.html for
submitting patches to address these problems, and perhaps we need to
look a bit more generically at solutions? A common part of your reports
was that if we configure SYS_CBSIZE in a specific manner, then we have
problems.

--=20
Tom

--qV8KqbEEaSZy2LOp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacWgPgAKCRAr4qD1Cr/k
CvC+AP4nwReAnu7rHvmWdfJWi7tHs/E/RXvajjV2ECRODtQQcQD+M/Cr2mkx0meJ
ddMwAxj80fT6fk7Xwk0i5Jwgw4q6Fw4=
=9fKI
-----END PGP SIGNATURE-----

--qV8KqbEEaSZy2LOp--
