Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FA487849;
	Wed, 20 Dec 2023 22:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iq5VyBkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FAF87849; Wed, 20 Dec 2023 22:02:22 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C555A8787E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbb328a238so39820a34.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106139; x=1703710939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yyEBbLTyrAVJrOXInQzc2NEeXcI6ihiuieypkyQSeCw=;
 b=iq5VyBkXyP4R6e7B7gPKp8mm4ZV9brm3q49Xs+6oWka2ZQj58vk0sMZgusO8/BJDOP
 A5oEVzduuwome0TwK23CiFKu/qJmpKqwj3ReR4UfbEVxdiBwT5Ay9CqOhOdklhAAuLx1
 nbrqMHnPWKGhPXym2xgHGA7oSDa14ssu1bIS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106139; x=1703710939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyEBbLTyrAVJrOXInQzc2NEeXcI6ihiuieypkyQSeCw=;
 b=gg+OsnshkMp0oT4XL9DWH/lZexeUGcqq497aW3SyW/KcuQ7DXr2b++W01VnfIEaPHx
 oGaghZjpw8q4hYLw+1CUeJkiRnriC/73IP+8sa0IpTrn9eC4UxYCYf28Ce3Ao/Lx5BUO
 0ZYYtNFcZa4xR7IAo9lhG+8KXOfeAR4DyqCnniwSuElID2OXChEGn7IOQxPn3S4d+KZe
 T6BEn3G9XufOevYM8ikTNRuJJLcbjOLl4durXwxB+1HQJhaFNkjU8kTlfCixxsDiO0zI
 exHUMxmSvoGbNKuKlIbpirulR9mHl7+L3uMZ55RlaWvYpSdsrO8MGDxx8J+JWYyQnPdq
 lhzg==
X-Gm-Message-State: AOJu0YzMGxgPDg3gj1XaHuMa+hfBLgaNyNr9h1C1xcbAxYKDMTKq+US9
 bsfHonYsRZWcerL5bwxdS43IEw==
X-Google-Smtp-Source: AGHT+IF7rmcjvgd/dYsKPoOG82U6xgxqZcDRberlSeQWR/bWGz1L79GqfHnjoXvFvAYGJ4kak6CiSQ==
X-Received: by 2002:a9d:6393:0:b0:6d8:4993:9455 with SMTP id
 w19-20020a9d6393000000b006d849939455mr12056225otk.19.1703106139506; 
 Wed, 20 Dec 2023 13:02:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 m125-20020a0dfc83000000b005ca4e49bb54sm221126ywf.142.2023.12.20.13.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:02:18 -0800 (PST)
Date: Wed, 20 Dec 2023 16:02:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: part: Cover both part type entries with GUID ifdef
Message-ID: <20231220210217.GC2513409@bill-the-cat>
References: <20231210212522.398132-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U9cMQCjbhNbCR3Ig"
Content-Disposition: inline
In-Reply-To: <20231210212522.398132-1-marek.vasut+renesas@mailbox.org>
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


--U9cMQCjbhNbCR3Ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 10:25:07PM +0100, Marek Vasut wrote:

> The 'part type' subcommand depends on GUID partition table support.
> The help text exposes one of two 'part type' subcommand entries,
> hide both in case GUID partition table support is not enabled to
> avoid confusing users.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--U9cMQCjbhNbCR3Ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVlkACgkQFHw5/5Y0
tyz8sQv+KTb2D3nr977zAtCVv9xXS9ICIgcWVonCf3eaKpOMfEmxUsTtEdMV7524
L9eiMVF+ZxidMAP1rFoaP3FWgWTiJNT4W9NmRptWGErKyjtMlNkPAK/B3fnedQjY
KQC77F5jB6TRwPgPDPPp4g84PfXiC8iQgLtJM4Vk5X8SCGboJPCrPx9yPRH2Vxko
eH/zEa/R9ERjtGBknXuoMscUTDOZfMqm9ng0SwU+SOZkKOWmj84CQKiStkJQ4bhD
aG79IAa9Qg1EkCN7TXWmP5hCzalqMG1NJqh7JfZY9J1l+V2+2/HUOA8ioZucTSIo
Z0TC2cknPDcHiCjAUg3i1RGLhZrtmgWmHXrqILZdYfhvdjGGrA+eQk+NqcBrrfCN
JmSjgVW1NboYBy9IzAUDH+4nZsOWk2b2Ye5tVaT8H8gblNeok8p4xbpv3R9GYBet
Q02oEEQcBRypY05UT28REeSKGU+kMaw/D3ISxJVrDDqkBAXbPnw5z2QHebz90ScK
DcHZ3APy
=v/yr
-----END PGP SIGNATURE-----

--U9cMQCjbhNbCR3Ig--
