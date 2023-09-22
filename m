Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C23CE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2278869F6;
	Sat, 23 Sep 2023 00:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHbNSyfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D461786A1D; Sat, 23 Sep 2023 00:26:38 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D095F864D4
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59bc956b029so34865267b3.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421595; x=1696026395; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dtCPa2Tq63caIqdVXKi53GYnpi/V5sl3ZjtO42SV9xU=;
 b=tHbNSyfLHBBafMXLeEfMDfal80wOdnTExoCSAUSvGCJ6AoDnTQWzOntRUP8TrhcTWb
 D+GukNE1fmLBy2LBzbPOBleZrt6N6W4sFuDtymJ0xKBe+Yk23M9uaCS6Qm7dXT80Bn/n
 98yJNWYTNSB8jYyLY4nlu3Gj+rpTKUwG9uJJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421595; x=1696026395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtCPa2Tq63caIqdVXKi53GYnpi/V5sl3ZjtO42SV9xU=;
 b=GwfPkwfMJK6ZUpwS2iLG19uqzTVo/eO+SLwpOGFRxevi/WqlZOwEWah8VkyjSgJXSi
 QHih7uQ4CiUyMibuZeQj31dp779xNctSY3C7gHn6dsB2EWQLIyZRigq75t++FH2VHFNx
 tpWvaJL1vRDxcz5WB8ULCoFb+dws3huU7WX5Xxqg6LqTt9ig8udOQSNIfo3C2XEvhwnK
 9K30PobaRqhyaGOnuJWBWtULbDSdhmZSLernCPVl03GboMagdDId9dilbS11i+C0C+rT
 c3UURgSbK5xLDb9C7cbXYCWTm2vHjBqcaSVuXHNiRPhOr1N+oJwH/sHr4TZLUn9OWQ20
 U8oQ==
X-Gm-Message-State: AOJu0YyQgZf6C43HJvQO4jzO9vK1VT5dWVH85bBXopoYoWX2vcA9bWZ2
 LeRJfF7ZKTshB3tsPAAznmNWww==
X-Google-Smtp-Source: AGHT+IG/7fK65FNAJMdW1D7iRbIXpydoJXz3Ujd19lLf0/UIm632blNQEaMJTMGAoa8p4SpY6t8BJQ==
X-Received: by 2002:a0d:f685:0:b0:583:741c:5fe6 with SMTP id
 g127-20020a0df685000000b00583741c5fe6mr724847ywf.52.1695421595396; 
 Fri, 22 Sep 2023 15:26:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a81bb4e000000b00579e5c4982fsm1116628ywl.36.2023.09.22.15.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:26:34 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: wget: Avoid packet queue overflow
Message-ID: <20230922222631.GE305624@bill-the-cat>
References: <20230720125156.31773-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fbQK1joNxyfGhuNk"
Content-Disposition: inline
In-Reply-To: <20230720125156.31773-1-richard@nod.at>
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


--fbQK1joNxyfGhuNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:51:56PM +0200, Richard Weinberger wrote:

> Make sure to stay within bounds, as a misbehaving HTTP server
> can trigger a buffer overflow if not properly handled.
>=20
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Applied to u-boot/master, thanks!

--=20
Tom

--fbQK1joNxyfGhuNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFJEACgkQFHw5/5Y0
tyyJ0Qv/aVth9vCM7nt4uywG4h/EiOiuOR6k3V3l+L6/LFDKuFpeq5kZ0h8A01w2
Nvf13Wj+N8JWFnrDUJEOunp6z2WOSM/RFFgY3xLZ59u6N93iEnBwDLP2ddkXxBAl
KaUBrS7SebkCXJvWrxlME3vtfrNh2S11oV4Lz6ioXeCyhiomNCNG6fvfqEVITW/A
4rOWgl3QGywJHjOay0Fme/C645qJxb26XzralN1ynKWwNnBA92W1PT67mEF1zGAl
9T8iFr/gUUa97uXif2nS2jAtIOM2XjQXE1HtUSXRilG0AAmSM3+4nPaLyF0hJ757
EP0K1Ez+DgU7FF6KPFIiMndtcUmKAHJVRkGrtTl0CHZaF/dm4TF3qzKiO/dj/v/8
d0ZsQ1q6Bnr1o/KXIRDzIP3qjLeI/Yoq03GPsBj9jXYJCOotEUaai2kmTWkn907S
VCrUkS7PZ1n//Sgmd9kQ/ExMMNxWvwRtFyXRfmQz5WoNuSPe8XrQFKvFmvdnbrei
5RRwviCG
=4VJU
-----END PGP SIGNATURE-----

--fbQK1joNxyfGhuNk--
