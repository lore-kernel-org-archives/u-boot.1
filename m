Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EC3CD5BCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F7986A38;
	Tue, 19 Sep 2023 17:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kvgi4y3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC7886A33; Tue, 19 Sep 2023 17:14:35 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE0ED86A38
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59e8d963adbso27397807b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136471; x=1695741271; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/1LFhW+xsy0FrXcjK8QsT1xjxIWAdFFUDrZ08THXts=;
 b=Kvgi4y3TdEoKg3ib2DqOxL1oTqzIWpa8Ak6cXp4dA4gtUpsPCeD7Fu5cU6u12la7U6
 p3DuGHpy4tkDJv8hW8Eq0ssTCpC0Z4CDFXePkNAu7bIE0fqyNmdlQ2fSa9BI7yz/4LZv
 y4YAZamG68YvSbSTosYNiuSBcrThG+Ao6/KXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136471; x=1695741271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/1LFhW+xsy0FrXcjK8QsT1xjxIWAdFFUDrZ08THXts=;
 b=olGMNBwxao3C9oRZQDLb9UK66rQNeZvknQO6o61aCmhp8zL9nXeIQiAKwtCMVDK5B2
 y/Bi5772z/9BCCcxUYg7NztysJLbGsvEAHkG47G2PThmejzbYg4OjQ1eFvs7rnqUn/ZU
 /h/2Tsgn4EtoC6dWTa8z+ixenmHgIOS4gylZCymHaSeKTUFjC0ygQsg8c2hZGtRRoMo+
 08ERGWB0XDP6gbl5/0a7CnKFXRxsKqn1AUSzNr9f9YmK0NWAhRk9Mrf+CNb2rHRxdbpr
 1PuSuhwkU6fGdSp3si2BoIZ0M82zFpZnskW8B80n/PxrLGCyWpfa0SQVg1+l08r9I7t9
 F9Pw==
X-Gm-Message-State: AOJu0Yx7voz6/NZZHmRH/8NM1n+9fCAu5ei6bAnM9X42tOz7rYdjZGrv
 bB18v75UNBmKfC6OmO+e/lIVwA==
X-Google-Smtp-Source: AGHT+IHtNO/42AEDv+tnCJHrRXa5V6cd+EMpgynIQCK2gaUXzZmyYAF/JoBHbE7LPC5rmYlRiv816w==
X-Received: by 2002:a81:7282:0:b0:56d:3b91:7e78 with SMTP id
 n124-20020a817282000000b0056d3b917e78mr12915924ywc.20.1695136471404; 
 Tue, 19 Sep 2023 08:14:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 p62-20020a819841000000b0059b50f126fbsm2356928ywg.114.2023.09.19.08.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:30 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:29 -0400
From: Tom Rini <trini@konsulko.com>
To: Nikhil M Jain <n-jain1@ti.com>
Cc: u-boot@lists.denx.de, devarsht@ti.com, vigneshr@ti.com
Subject: Re: [PATCH] tools: logos: Rename TI logo files
Message-ID: <20230919151429.GG305624@bill-the-cat>
References: <20230901103913.38407-1-n-jain1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/dvbJoQyxPJNROUH"
Content-Disposition: inline
In-Reply-To: <20230901103913.38407-1-n-jain1@ti.com>
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


--/dvbJoQyxPJNROUH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 04:09:13PM +0530, Nikhil M Jain wrote:

> Change the file name from ti.gz and ti.bmp to ti_logos_414x97_32bpp to
> help user understand the resolution and identify the logo files when
> placed in the boot partition and update the splashfile name with the
> same in .env file.
>=20
> Signed-off-by: Nikhil M Jain <n-jain1@ti.com>
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--/dvbJoQyxPJNROUH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJutUACgkQFHw5/5Y0
tyyf7wwAm+5x0Amfh57dNyPaPHh93JCQTrCLtwUjlJXcX4lbYzrjLSbVaKEtpTGY
zY3Iu3+zAv+EwWkVuuy8Gp42v2AiOjVOZj9byF/sKe/MyFSrASo/zDy//ccUEk6a
fbakgdba7pY+zfeJrxexVwV2Vre8kqfFfRod8328PdfL3RaMdpc+9cX3OPo3ZrBi
LN3CiA0lMLC+pdU2lBdZS8tOf2oT69nnX0fixB2JmoCUe6VQXdKG6YGWSrZcG2yb
NhTkeXeiyhOWX+j1l1T3fI7KRA7VYBzVtgOUDdYNCi/PAYG3TgMgNox/flzkRfFJ
je2Ifz3Ld/9zgz/kIBFs6+tSejGbqm0phv0AxNQ1OIx6lKjUkA0Cgd/TGcLrTxVD
Mj48ScofvppNon2rB8lBC+nyhnQzC8fg+4ps+BLGz2UTbFDQ40jJhiFVhfaK/606
vCyUOrirapgAMyo3YC0opvPoImCvQZ22M5EjBLRDqGoBoTTnmdaQmxMy3SY9yQnH
v6Cj/bvq
=wd8M
-----END PGP SIGNATURE-----

--/dvbJoQyxPJNROUH--
