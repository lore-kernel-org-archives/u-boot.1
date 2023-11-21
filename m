Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E462EC61D94
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 13:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4930A875B1;
	Tue, 21 Nov 2023 14:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sUgZeY78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0CF875B1; Tue, 21 Nov 2023 14:21:15 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50288745B
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-679dd8d1281so10018956d6.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700572872; x=1701177672; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cCsU8JPOQ91oxOTzHtz2UGOWfD0wUAlwCtGe/DTWQ48=;
 b=sUgZeY78hPvQCsEjjDVpmnIO8SoZeotpSExNDin4tAW7sAHfdEdp8eStyZWaL59rtW
 24PZnNy0zewMBFXiDq/YcdEz4PiSZLP+dDMPwGPSfQjNLhJHUrmI/96D0Q75RuYTXucl
 1dKe9vPoWaprSCJj0Zs42+waW4kTijQPpDX/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700572872; x=1701177672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCsU8JPOQ91oxOTzHtz2UGOWfD0wUAlwCtGe/DTWQ48=;
 b=Dq9g+6MTnYZDgJ1LPIoxG875/xU8KGsxichF9/PeckXspL/wePj8Z+U/uGzVkzCclG
 HW8wnMJzDauibNTHo/AqYHHd6OKVs/JBQ2UrVmF0Jo+Dduz5Z20KWY40bnpO5dyiZARS
 jepiO3N+/5SGi31dNxP0nJXcWjis9E/6JIzXWTcF/Ydhhun7CPlAXnc0W0oUh6zF7IYc
 RCFlTNdVtgeXfAfExsOJ06e+hbSs0UpwQzVwG87jYCEK6exLEUoGh7ntWHk4jrYWHukr
 uqPbg0zK+YdCiaC0Mq4NYO6qffmzfeS05bepZt3hF065BVBp59gvjncckxNHlQkYGdaW
 bY9A==
X-Gm-Message-State: AOJu0YzMa9TORafqTBHUJx9v8E+qX5kF+UOggO4CnDgiLuvjrlm3VuZl
 aRNmcORdP8p3EI+Nj0P+gRhbJQ==
X-Google-Smtp-Source: AGHT+IG7FH9uEpCTFTITen7jOI08FXdK6fsH5NSVj6JztlYzK+trtDHzTcnB2vhI4CFal57mlkgsjw==
X-Received: by 2002:a05:6214:19e6:b0:679:f30e:34e3 with SMTP id
 q6-20020a05621419e600b00679f30e34e3mr21019qvc.54.1700572872464; 
 Tue, 21 Nov 2023 05:21:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05620a144500b007757868e75csm3600238qkl.117.2023.11.21.05.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 05:21:12 -0800 (PST)
Date: Tue, 21 Nov 2023 08:21:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
Message-ID: <20231121132110.GQ2513409@bill-the-cat>
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I1yD457llhRCNCMm"
Content-Disposition: inline
In-Reply-To: <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
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


--I1yD457llhRCNCMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
> On 11/12/23 21:55, Simon Glass wrote:
> > This function is defined by bootstd so using it precludes using that
> > feature. Use the board_early_init_r() feature instead.
> >=20
> > This requires moving quite a lot of code into the board directory, butt
> > this is the normal place for code called by board_early_init_r()
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> > Changes in v2:
> > - Drop duplicate acpi_xsdt patch
> > - Put the board_early_init_r code into board/
> >=20
> >   board/efi/efi-x86_app/Makefile  |   5 +
> >   board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++
>=20
> Our target should be to enable building the EFI app on all architectures.
>=20
> Only x86 specific code should be added to board/efi/efi-x86_app/efi_app.c.

A later enhancement to make U-Boot as an EFI app more generic would be
good, but outside the scope of this patch which is moving generic code
out from "lib" and in to "board".

--=20
Tom

--I1yD457llhRCNCMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcrsYACgkQFHw5/5Y0
tyyeIQv+OtBYEGPYkiAwaXvVhly35QH9ynsLrGafOkHANZEGrCunChpkn6uBORA0
0gJI5lb/AQhHWpsxV/PyURMC3gMO6aNoEdGINvp4J+D5vp8jTOc4lG8Yqm6CvV9m
NS8tLI04WV29Q3bckdO7dFAjAya9ukeOE2jsDbMZ3wCMhXqTSJpMYh8b1cHu6wBY
+oiPcMVjjMF39zHSo7jGF7Y3+TwHZr0NbzagAR1oouX0SK8+3w5UMRB1TXO7bGCw
MGEW6sKbWbjFLNGqxeJkYntfaHv5rvTqGJHgAkmGWoBeATI/3EaDSvGYEvSWPsMF
+if/1NaruJIi6x5CHaP7w1IHeGBbLAYNbwHaShXkgOiDM8vuAyiNsV/y4Qdm/qQp
r4Jf05LQSjnuYt05r3hVL+BaGF5QGdF3a0AJvZLUCCBz3RdFZLqI7bIVHv4ZiScA
J0M+9VlM2VokumM7/WWORkBB/4NBseLB9XzO3ORWWsaUrrYndL6Uq/gs+uYOMP0M
DSYMvBlh
=8dg7
-----END PGP SIGNATURE-----

--I1yD457llhRCNCMm--
