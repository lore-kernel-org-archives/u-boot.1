Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4072C61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3936C8745B;
	Tue, 21 Nov 2023 14:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7OhkzIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C668745B; Tue, 21 Nov 2023 14:08:09 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1CC287253
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cc7b67419so34297321cf.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700572074; x=1701176874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrNXMx3HzvRDAzmENK8i/NomUcj2eHTLt3s78rLUd7w=;
 b=t7OhkzIaJQyF6EuSGGSLt1KkkNiLeRM+6FMTmOgtIeux617L24eBiO27jnUtlCCM/8
 num5wB8Ghadp8UacjEd/jYnoAXNxibD06+S3vo419XtkYN7/H9vBxN9GSl37THhoL3ql
 1/Z0oEqQKJqQou0asJCB6p308fcLVOLikPaNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700572074; x=1701176874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrNXMx3HzvRDAzmENK8i/NomUcj2eHTLt3s78rLUd7w=;
 b=dnYm8TU+1oP9xyfxWQmNACJpRy4cR7qVSHELjgnLCqtaV0SIRYb6JnpGqqLAlxUJk1
 E5sRIYHrtAgFL12b1QlnnH6jjIthcrY2H+MnVUyBb2+e5EJi6koDM1Z7YFYhFH2wnPz8
 r4NzJg0NvblaGDZCdxlyiGfzgLIVpNIiWcumzRvxq+mQflkkXG0YUlkKtAfClfn/2v4v
 ncUvtDklqtg6FhXEtG5tdNf6SFgFRmcIunuUXvHjU/ETyWUSE6/L3A4c6Fvvb74Cd1JF
 vCiRTFVRKzcql6QBvcc/8CHLYR15EcteykfvWndWnhYlEoKwbvOmW5ECq78vhRO5m/bs
 G4Rg==
X-Gm-Message-State: AOJu0YwWOzcHGoUhR7GGzSmctjt31keI0hFAaAcGY1hbTw2zgtY9Qx2u
 jIaz2QtcMtdeGgQQL41jr3fZOw==
X-Google-Smtp-Source: AGHT+IGGabvSCg9wxspbGSmygq67WARBX02U5hBWf8oLZLDmtXBz1LPAbyWOATMxWCi/0UvQJXFU3g==
X-Received: by 2002:a05:622a:1441:b0:421:f47f:d758 with SMTP id
 v1-20020a05622a144100b00421f47fd758mr12354310qtx.8.1700572074633; 
 Tue, 21 Nov 2023 05:07:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 p1-20020ac84081000000b0041b83654af9sm3572308qtl.30.2023.11.21.05.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:07:54 -0800 (PST)
Date: Tue, 21 Nov 2023 08:07:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/5] video: Use cyclic to handle video sync
Message-ID: <20231121130752.GN2513409@bill-the-cat>
References: <20231121020932.733405-1-sjg@chromium.org>
 <20231121020932.733405-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JKqt4qxhQA5/l25H"
Content-Disposition: inline
In-Reply-To: <20231121020932.733405-4-sjg@chromium.org>
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


--JKqt4qxhQA5/l25H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 07:09:27PM -0700, Simon Glass wrote:

> At present U-Boot flushes the cache after every character written to
> ths display. This makes the command-line slower, to the point that
> pasting in long strings can fail.
>=20
> Add a cyclic function to sync the display every 10ms. Enable this by
> default.
>=20
> Allow much longer times for sandbox, since the SDL display is quite
> slow.
>=20
> Avoid size growth if the feature is disabled by making the new init and
> destroy functions dependent on CYCLIC being enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks for updating the help, I'll leave actual review to Anatolij.

--=20
Tom

--JKqt4qxhQA5/l25H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcq6gACgkQFHw5/5Y0
tyy13Qv+JKn4le1QqPoJHjLpm8FgessQF4kcZm0tL4zxIXEvbWTPyZHXAStfB7gR
gu6O+1vFmuZlmUru4yGdJ7E/wU8963+c7y4XeYPQ+pvQqwr1ukFfD4T3KRmE8azi
Czrd85P12vq7+Yt9OCVWgRlPOSoHO9ElRp2XX/C4WZVA+U+MgSpBnZaTDrw5u6BD
aDmAJFlb6Ab4OC3r3e3tKbgY7Pb0kn3LCxrvhhCZ8bNsHn5LsDmmSL2ru12sdiHq
1pBjhnvyW99UdtnRyGJ6zpI5eVXqKg2pSMfzP+h4LEY4eoeWOjNcx+tTu8D1xzgj
nVQeH1Gr7rR7kKPwLB/AuANyVRPAhB+zWLHOFoutCSZcYcIgM0VDruflYh2iqQW4
uvw/NnWMB21CAMS5edvkmgRWVIxBk+wSde2NlziiK/uOmBWLEuE68mFUQeKhm0J+
04Wj1nU9/R2CLSTWpr+WZErCuKxA2RF3a9aPZD5BebCvlCIszGnq5kwJy8Hi5+TR
A08Ri/dh
=/EX0
-----END PGP SIGNATURE-----

--JKqt4qxhQA5/l25H--
