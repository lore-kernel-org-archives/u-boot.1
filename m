Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD541D65526
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A9F89C7D;
	Tue, 26 Nov 2024 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hKMQfci0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C7389C89; Tue, 26 Nov 2024 17:49:26 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C6C89C74
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea53011deaso893750b6e.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732639762; x=1733244562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrUrH/NAURYZCbV57C94/34nA+fy2weZxC8GcT5EbgU=;
 b=hKMQfci0AwyKFHFAiTvee7izwGVRDfa40KhDIcqgW5bJNztNiBo1oBGnYm+/Xo7Drk
 YZ3MV8vHx8yAUBoWZ8d8Z0nPgfytfNxQxJ4/J6Yub+IA7vBWtGlFef/0XUXe+v8x8jue
 Nb/8JLHlKqgWne/fR0pGKXL4oecbXd9JG6SYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732639762; x=1733244562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrUrH/NAURYZCbV57C94/34nA+fy2weZxC8GcT5EbgU=;
 b=tU5MFavE6NZXTZj9OhPidq44BPvfRWbBf0wzti2AY3e7YwTe4VtB6Fy3QvgH2tJeXT
 ybyByVj9YCbYooF3MQJnSHNeH1SRGiuGnmRftj+E27IUKTFjTH5CLvMkLcIPRSz3cAlk
 UUW0zd4rU4LQeHEKPzniMlJHqiiDqLy3iwqjvM0gvvhwTKsgHM5g9dX+GVBrLQjUjsfJ
 yk5nj+rKVnbN3V3OInx1Y9jAwLpDS4Ev9qC//Rl2YD5W4TVIfvwNVZVgFaXPhetrlPBB
 GV5ReA/jjyXHb8GiFwrNx/UnYfQjXlrjKIWGjLs1yjSe/TFhvMA/evmzYk+tEOz/JWf+
 Xhbw==
X-Gm-Message-State: AOJu0Yw4kwc8XeN8jXHH0uGhtG6JNgqGoldZGBapuI+aHW6LW8Zy1n9D
 DVzWkHSX65x2XxKM01onhKVpLerJYv6f40n2PMhdnf7aMVmHc0uMHegQWSpOXMFWykbGWQcXk0o
 kP1k=
X-Gm-Gg: ASbGncuKEXtDyS16WO5jUAwEijjXUBxfkseh2kZes0nndgO3wnPJTrbMTWjds/ueBYO
 auVXHSoQVDuMMQ1tII17tD2GQOKsEXuW+pf2gBp2+WjODM+yDZ5Vn0JsISX9Yiwj5oOcadjARVt
 Y+yheYrRwrdNs72lRwOYKaNMfHEBlD3PmEZ2nSU40bbpGRgVaUrzPOncBUBufm2wlyF4AvbkZsE
 /ndx/NXZHZJ7mzfxSRqsIc5ajxunlcDc0kw41Ggd9vqmfDgjQ==
X-Google-Smtp-Source: AGHT+IGJzgSxI5INFbTSbH7klICTLfhKoHTMdr4YRlKTLyG4/bJTUseyDRMgbF2AD5FJIzMEHK7hIw==
X-Received: by 2002:a05:6808:1922:b0:3e7:61e6:8113 with SMTP id
 5614622812f47-3e915877102mr16882710b6e.23.1732639762642; 
 Tue, 26 Nov 2024 08:49:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4a8dasm57251816d6.109.2024.11.26.08.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:49:22 -0800 (PST)
Date: Tue, 26 Nov 2024 10:49:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20241126164919.GT3600562@bill-the-cat>
References: <6166e3ab-d808-4505-b0d7-0cf32841f0d5@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="grnkuMibEJrmksLz"
Content-Disposition: inline
In-Reply-To: <6166e3ab-d808-4505-b0d7-0cf32841f0d5@denx.de>
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


--grnkuMibEJrmksLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 01:24:13PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the next batch of Marvell Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--grnkuMibEJrmksLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdF/AsACgkQFHw5/5Y0
tyz76QwAi44o3jH5HMmelmWRJMBmSFI/v0dM9VLOyQiV9+4Sq0MaCTceLYX/HRFw
NVqDXTcO2TMRutfRaeO9fMW9RC5HDvnlxWRveH5/QlZul2087iZyzxumZxqtSZ4y
B2YV5Q8e+8EuDV5u4yOK6zj+5UXthNLeqQ7t4KxZEzsNy87YNgXkEXFkxgkek4T9
OFBVynHzcPRM6TpNbkhTk1bLJa4dU/XyHIf2V9/xd2N9xdabZvaXVWTALy8UU7pm
MpSAOcLjylZDWLYlEj/GIDo6rKKhPLVdlydXacxB4c65JvvRNweAePKkStpktSme
jEbTEClpkEHv4uQsVesAY5jCZjA1SpAdUEN4HGiS4Cm3q/1Nlpz+zvC23wKNZZFh
w3jk+QXzvHwxtynabI3iR1AAF8ZB6Y7DXzfuOUOiZ533s2us8OrXDza+cpSbUtxq
Zlofe+DxAuRBav31UG62D0vK/tr0jdR97c+BG6qVvfN7ErkETuXaDu9XGFGWdEDE
meJ2ZsjX
=njAt
-----END PGP SIGNATURE-----

--grnkuMibEJrmksLz--
