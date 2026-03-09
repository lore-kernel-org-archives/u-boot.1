Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042EF417F3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CD183F75;
	Mon,  9 Mar 2026 16:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cjj8uPrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65F383FBC; Mon,  9 Mar 2026 16:26:23 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD1583A8C
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d754c7c150so270691a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069978; x=1773674778; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UpIYOL0VqoSW0K8ejR+Kw41rUxtowgbJjLaYeG6QPwQ=;
 b=Cjj8uPrl25ORZ370F5akpC8XR8rJDOMTkUFSEf5UDzOaWgbvlbmR6DmwKwxG4Cd3ev
 OqOXLS3LbTt+crwtuckeIA2aC8c5d9OKZRIRIXFEPIPqr0S2NWliEHE1n5aI3ygVzyBT
 8fGERDgd3kYWxQsL4gRCTmEtWmwaSqWfXuUlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069978; x=1773674778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpIYOL0VqoSW0K8ejR+Kw41rUxtowgbJjLaYeG6QPwQ=;
 b=fI5PVwMBoB6BkfAu2VR1CaqGHsbA4P/pfpnFiR7zH8FNjpxHW1bF791jPIV0EOTAaV
 qnsOIwMNIU2ktP6YL+UCDDWijwqx6i9PYD2PATTu6bnoeaFCr8NKg9M/9LkysdQd4/BB
 2ROrUFSH4VYGj4fEOckysakNA1okHzsrGDbeSRKz8oluD5UAGI3xA5r8N0TOzhRSemoK
 hCOyNgDbg6d9osSxbho0iKUpSwhHkFFply0SqMRxU9xS3u1TzpqrfDYgc3/0VZtfMjvt
 hIBtVV7XKWlXxOSUFnSTfjLebR5WeKiskKkGvPf/ApzTgT9Ka636IS4JdAVPRNNmd0ZK
 NGeA==
X-Gm-Message-State: AOJu0Yy+BpyNb9LqQakSPlk2v2PKMxd7P4UA5beijk/xCJ71u9IDmtFi
 PJsgX6Rw9uu1DTZIITwsi9U5+pTRMir1lUoSAdU2AwYk4AT5nS+Y2+e0eYYPfsxt/o0=
X-Gm-Gg: ATEYQzzv8HoJJFYoxAZ6ITv2itME0LNOC0cAypR4qV97LFz8MA77FjR8HJzOtq+JZqy
 6BqRPGubTz3p9RY3z/CwXhSvUPpvOe9atHoyPJlpmyFjUqvjctOE16CN14GvaqNT4yoYbb5HhmY
 aEnx9T41okmfVGGw21vxacA+DJ0uoQEPNcFx01npkgzFi6+ocn/01hv0uomhvivj8U7DYTHk5d0
 xRjF2RN8PhCjRyoz+8fRJOFdFdEqBmS5e7eZuf7OCeDmcBPwb9IjAKsrVQrCap0nuqg7RBXLa3J
 P0ge0i16yjJ1TfJ8qGisepc7SKvi67f6OZkLY+jBimnOD8x+dG0mHzRQNGSoB1+upHHXcQ7RN+2
 hMIIAnr7o1/YbQKStMtxS5COiZYpd3kywO5SknedLWA6XQ13g1p8dexzqbyl1BkQXZwkar7LC9h
 0WEjwvhvOvOcYtf9C35v1cd6ZJEvx+LWgODUuuuBk9kJBPVnY0Ckp9VbOw2QnDYDBSqSnnZrH5E
 LcHVZY4RTSzsbqHXsPI5dhCoSB8JRD7o74RD9K/pyBGlw==
X-Received: by 2002:a05:6820:1843:b0:676:f8f6:3f67 with SMTP id
 006d021491bc7-67b9bd499d0mr6098432eaf.59.1773069977851; 
 Mon, 09 Mar 2026 08:26:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bb666de5bsm1229506eaf.7.2026.03.09.08.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:26:17 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:26:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 5/5] test: Convert fs_helper to use a class
Message-ID: <20260309152615.GA1388590@bill-the-cat>
References: <20260309151307.831537-1-sjg@chromium.org>
 <20260309151307.831537-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oD7D8S6JAo6JXXt4"
Content-Disposition: inline
In-Reply-To: <20260309151307.831537-6-sjg@chromium.org>
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


--oD7D8S6JAo6JXXt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 09:13:04AM -0600, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Create a class around mk_fs() (and later setup_image()) to handle the
> common tasks of image creation. Many callers of fs_helper.mk_fs()
> create their own scratch directories while users of
> fs_helper.setup_image() rely on one being returned. Unify this by
> adding 'srcdir' as a field while converting to a class.
>=20
> The class delegates to the existing mk_fs() function for the actual
> filesystem creation, adding lifecycle management for scratch
> directories and the image file.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oD7D8S6JAo6JXXt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa7mlwAKCRAr4qD1Cr/k
CkMzAP4wHBnMLW9246S7+9iqABXw8ljokTUSD7uQxZSvgLOCDAEAyOq0S7mhQpLv
MfClqix8bTPLAVHDFHblsyH7TQAg9QM=
=fYid
-----END PGP SIGNATURE-----

--oD7D8S6JAo6JXXt4--
