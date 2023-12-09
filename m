Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB86AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65920874CA;
	Sat,  9 Dec 2023 16:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aqi9uUJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0749C87686; Sat,  9 Dec 2023 16:51:56 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE90587215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:51:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso28945087b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137112; x=1702741912; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/cv8qnJfx2X4hYhO4s4zzVUoQC4FNBTszrJLhQlsyx4=;
 b=aqi9uUJbCdGFNlRdNKrh3Vioq0y7ydlzDerBiw7axddWFK1l9knbkSJf9xw1bSUgAb
 LDcwgDRyjSkzbo+iPR9PmNZliTGSvVODHlu1PGR/nTDdkrqQ6Rt2wf9Ejui6Js9/ArEd
 3H7FHjZEZmO6Uxh/MnAB28+cmvX4+lXjRAVk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137112; x=1702741912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cv8qnJfx2X4hYhO4s4zzVUoQC4FNBTszrJLhQlsyx4=;
 b=qhhLbOMLi7jjMHb6ArwWYWgl4Qt/x2aYlnNaUAf/bavv/Dr4PYlruW8t0xLYSuZi7m
 xQx0wHg+Uo8pC9vI4EY5IFA/BEBa6ch09ouJrEVppC2X9a4kyqi5DZv6WjaVX8ru8wn6
 yvpumnc8nAazFsMMTM3AqNc4KPrfYpJo8AlAO4FiaYEE0HxwLmsOETxsvcpEeB6wq63c
 wCXykyj1cNn1RNhzbMC6ArKeZonuz+mLZVuq99N5lHkZtYudFgDgTLI9SkvJ3+3iMdhD
 H4ycoNEjoRLc9dVpF8gV8piYuUPjm4+NPWs+6XExz00ZMYi8G+ml3CS9cACFqn/+n0xW
 uCDQ==
X-Gm-Message-State: AOJu0Yx9I3PupYXzh68aIyivDtzFORMlDgopQfIAKzG6MGdA3tNQb9HB
 1ZFVjnV13verHJO2i9mnxlg4jg==
X-Google-Smtp-Source: AGHT+IEKQ7IxXbQB2ZoAr8vx2zVXiArokjJpeFDTAqwD0O2a+EqUJpHFdhD77VKZa4DRsYxT/6pMBg==
X-Received: by 2002:a0d:e605:0:b0:5a8:19c0:bb6b with SMTP id
 p5-20020a0de605000000b005a819c0bb6bmr1231409ywe.36.1702137112654; 
 Sat, 09 Dec 2023 07:51:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a0dd707000000b00559fb950d9fsm1557570ywd.45.2023.12.09.07.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:51:52 -0800 (PST)
Date: Sat, 9 Dec 2023 10:51:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] doc: Replace examples of MD5 and SHA1 with SHA256
Message-ID: <20231209155150.GM2513409@bill-the-cat>
References: <20231202193314.1513224-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hKmeLecVPMvqFtxD"
Content-Disposition: inline
In-Reply-To: <20231202193314.1513224-1-seanga2@gmail.com>
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


--hKmeLecVPMvqFtxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 02:33:14PM -0500, Sean Anderson wrote:

> Both SHA1 and (especially) MD5 are no longer as safe as they once were for
> cryptographic use. Replaces examples which use them with examples using
> SHA256 instead. This will provide more-secure defaults for users who use
> documentation examples as a base for their own use. This is not too
> necessary for non-verified-boot scenarios (since someone could just repla=
ce
> the checksum), but I wanted to be complete.
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hKmeLecVPMvqFtxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jRYACgkQFHw5/5Y0
tyzK2wv+Nb/qxJuYjXrPOtkUgMey80GagTNfOwZyrI0oJb7IhuKK/SrB7R3Avcck
P14znKRez8KozmUHvUwPXpTNS3vgJjUbWS7oCHBuCNKDBwrTYISmFLgvKlZ85YXl
Tl2Qm0v+7bB6Tiky6gjoBPxEq4sDMbJjG4O8N2nHxwFVOXt0lcsEbf/WDn9/ezmi
qUECZQZdfT3zUeME/496hOI5ha9ZLW5b9TG30EsojViTVSPQFa8OVnCW4pTfTcnm
Pn7VyI5oBcSLrqf3nRAfwJSblSFdbzl2t5A+upPv6sD+xgUh2JCiaENzOF3Nqpd5
qhlemSsILroGEphpckGcgY3q3FY9Bmq+A5O29l/gstr+Ql8g3N1Ae4DrKxXv6q3V
MXHkGpja5ymS3x/LmTD+XYMEpdPwS5k53CDqZKrQUFCU987aLq0eV9nmbbAOjamI
NvcighQdttGTpzK9QbD/ouF7DiAvffj3/zirfK2nOwGn+7Tp2O5vhkdH2Mw6LJYV
MVhgEt5d
=t2Cn
-----END PGP SIGNATURE-----

--hKmeLecVPMvqFtxD--
