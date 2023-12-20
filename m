Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322D6C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0046887854;
	Wed, 20 Dec 2023 22:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lO9A6edG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C8C8784D; Wed, 20 Dec 2023 22:01:54 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069A68785B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e784ce9bb8so1066797b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106109; x=1703710909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c42vy1dICOvnuKneboao5AS+gYA8XTDQ4QD+kVX4m4E=;
 b=lO9A6edGqJrT8/FupTEH5G+IOuBIOvzHKepCpy2/4VlWhtkr6xplsEsCswbBgZhvjp
 3VT7rEwEMP/QigSTo+QtH0A/r+xsWgRjLrJ85iCPj8IjOTsVbmTIYqtDPMBaD291z29x
 G4fznPk0NkRXJ1jLLenhhM+8dC7L6vVkMhbnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106109; x=1703710909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c42vy1dICOvnuKneboao5AS+gYA8XTDQ4QD+kVX4m4E=;
 b=nM2gdbagG9Pnpj4Lk+b9j7CWQhO+6SkkKlKJimO2qz/9pa/+lveTythRhWljnbffoV
 ugWSQfZDJVe03yY1Rh5FVtKzJMT2BPScF4XB/8/+B2PWu/y3PqXYykd2KvmHdGo2fJPM
 gpfsq7dOBwbtibXGBTE8I7i4KYmQIMVFKJlEwcIxcaWhK1flju7ZCYVMaFsPCV1e26Dn
 doiA6n2UTAPChyA2PVM8LAFXEGR8rN3OBtAIxb5JrqAB9LgRe4EPWoYIUs68Kq26XHKQ
 apjsbB9QsR+mRVGwK75GcU14cmGsa8a1v0U1keT7CO681gb+OILLQEajWmC+aVLgVCCB
 nnCA==
X-Gm-Message-State: AOJu0YyXxjmEQS9y9Uey/glq/055oGS9c3E/DouXYvVUVFMQR4VDcAZw
 YXs68bExFnobxFXcA1LNYusbGzXjb+Fco8uG6Uww1l2LVfw=
X-Google-Smtp-Source: AGHT+IG8WIUmokFQe4XdxlD4LmlNtS9wTeVG8aluqV3Y+1ZdQVKp1X5YPD8TWvwHuFqjQ5/yXLg69g==
X-Received: by 2002:a81:5385:0:b0:5e5:2f0:3fe7 with SMTP id
 h127-20020a815385000000b005e502f03fe7mr227399ywb.0.1703106108430; 
 Wed, 20 Dec 2023 13:01:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 a187-20020a818ac4000000b005e4a023fcf3sm230575ywg.92.2023.12.20.13.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:47 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Ayoub Zaki <ayoub.zaki@embetrix.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] rsa: use pkcs11 uri as defined in rfc7512
Message-ID: <20231220210146.GV2513409@bill-the-cat>
References: <20230826115329.12938-1-ayoub.zaki@embetrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="idzH8P/Suv78w2SF"
Content-Disposition: inline
In-Reply-To: <20230826115329.12938-1-ayoub.zaki@embetrix.com>
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


--idzH8P/Suv78w2SF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 01:53:29PM +0200, Ayoub Zaki wrote:

> pkcs11 : change engine uri to use full pk11-URI as defined in:
>=20
> https://www.rfc-editor.org/rfc/rfc7512.html
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>

Applied to u-boot/next, thanks!

--=20
Tom

--idzH8P/Suv78w2SF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVjoACgkQFHw5/5Y0
tyxXkQwAlAk9qwtzRn5d2KGIAz+9RgeP9xxzALL83EhaFYnvx9UP99ZxYm/tRA1H
HhV5cjHoNkgYPxInIeUvc6T4rZwFRZ50WyqcQp9ozTP7kYt0rOlzZu4AnfKyARO6
dfCNU/5LVPgJ8jClK/0bnx9+gk9HN8Ltrd32cBgRs0eK7p193rcfkBzdmqdgTJCv
1QBKJXFGcYg910sVVyU0nSS1ilkjF99TKH+oOKYCXud3RDuy89QSPog/GvqSYIO7
5kschcaRZan69tFIDj/6jFYHt5e/E1k/RxgCb8rvhcmPjdBkRgTkePFC6NKug7ft
upFBD4Sk9SNr0o+XzjB8zSX4VuT5/VFSAJ5+NMu+mXZ7XNZz+GeZMkNCl34pzZxw
/OjbgFrwXcj1uvw8qwL+CVZPco2VUrBDCly3VRUmXq6mEplZNYXFyXCSVA9V2EI1
wnWoH0eUmIIizybLYxMk6rXdCQuO9Zm3duD6dgpOckkIIdKln6s07iLON6ybEZjh
FrFNTrdd
=bHGd
-----END PGP SIGNATURE-----

--idzH8P/Suv78w2SF--
