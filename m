Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3908C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7357987CFA;
	Tue, 31 Oct 2023 18:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S3CuHid7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A4987CFD; Tue, 31 Oct 2023 18:46:14 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B9387CE3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cd52c51abso37177311cf.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774371; x=1699379171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qjNgtv4A8gVkQnz5xkeo7Gy+CpHHe8VRRVcNFwbgGw0=;
 b=S3CuHid7LTWuYV011mB/LuXDQXN4TpojX9JU3xRnLdZPZmoPU3zfJzal5ljI75XmDb
 O4+sGJFsvRCl+myWD7MtlwfLdMy7/CdRPi0nTLlGUEORHvTOC4bQ8SMc0AQyVmiPzq2k
 b+ofPfvWpVPGBJoaWOcyfreA8a930+HOUP/us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774371; x=1699379171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjNgtv4A8gVkQnz5xkeo7Gy+CpHHe8VRRVcNFwbgGw0=;
 b=JFYu46ciWD9oJWCkB5B+FEdbAcgSkOm5QxLFOzEG8OCmWFjIXw+1GHwgSgqBYii2ga
 bT7rAgiuErlNp/SsLUkxMB2L8vpWggcZOranhpGrWnoBmEHSNI7QlETJqeppce0T2pvJ
 k6FAKvle/w3Wh6pJPV94g1aMl1SktVKOR1OEeAVLdjQexLCGl7bJtBjA1NdWCSdIjXSn
 Z+bnSVK6ZBw6Pvjks60E8GI+FBYsUb+wF++28b5RDZPxCpXjMz0ecLXDaCV4Rkcqbgor
 EwqTUKVLGAt5ZYwdVC6CKf62APQ/TBaTggII5voOLnydw2Xn5TkjODihGMQCFeXX/+3F
 x1Bw==
X-Gm-Message-State: AOJu0YwTSxflWuaXqop0VKHdVjZYZYOPbz2n1+T9rOxW9q6LOt1x24xX
 myJLuKBMRIqlwnUBpG7UpANF8w==
X-Google-Smtp-Source: AGHT+IEuOnjLRXAVpz7KRv13YLZOGf6KZePH9ULD+hgXGn31uT4LGfuweOUy/9DfQ78SY5DcL79ChQ==
X-Received: by 2002:a05:622a:199a:b0:412:6f:9ead with SMTP id
 u26-20020a05622a199a00b00412006f9eadmr14923267qtc.14.1698774370727; 
 Tue, 31 Oct 2023 10:46:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 x11-20020ac8730b000000b0041520676966sm685498qto.47.2023.10.31.10.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:46:10 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:46:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org,
 ryosuke.saito@linaro.org, sugimoto.yoshio@socionext.com,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH 2/3] board: developerbox: update old NOR flash layout
 build instruction
Message-ID: <20231031174608.GU496310@bill-the-cat>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U5pMg+EW2UUle23A"
Content-Disposition: inline
In-Reply-To: <20231025065103.3101666-3-masahisa.kojima@linaro.org>
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


--U5pMg+EW2UUle23A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:51:02PM +0900, Masahisa Kojima wrote:

> v2023.07 is the last version supporting old NOR flash layout
> by default. The later versions of U-Boot, Developerbox is
> configured to enable A/B update and new NOR Flash layout
> by default.
> This commit updates the documentation to pin the U-Boot
> version for the old NOR flash layout. It is still useful
> for the user wants to replace the factory default EDK II
> firmware to U-Boot.
>=20
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--U5pMg+EW2UUle23A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPWAACgkQFHw5/5Y0
tyyZVwv/aI2OyWz0ehXpUfgrAj12dsGmJhdJ6+9q9KxJTtNviFonncAm6BP5+QN8
V0oSSN5hShd4Ff+TTsDcRq8FU9qe2KPot8SBzyt7AtQkjZ9o49c1LQT3vh5cHp8U
s22GmT3NY2VQ7+TAuYVRMTSXHT6nvMaXABFewFflZweSMdrFiC11Di3ppoICg4rW
MSbRGJ+YWzyYM2AUWGAmxRxLtXpEm2/Yprhi23pZNohEzTgBq9cQms3YERo2sCeE
sVoWDfIoZlYPgJO3Y8Ev9UjqjC5UrBI9MpihyHZ53GiBZqTto2QRgL222baFeVAx
mvxZcWGdcRgFhDWPhnSsPLtbDWTdAJeeIp3EXztsUpVLprosFWLJMcWuBRyYoNj3
6AHkI0dszp7zRd8hjvh6rDCtfobfwEOceCp4DAeilYhUkqHMqYzCPXgbpjZQj58+
Xk0FJZJuavvSqqcVayrH8dDd4GP10drdNUqCgJCVIcFALSrMj3g0zCZp2S4mMfpn
ly64Ys5l
=R4Ow
-----END PGP SIGNATURE-----

--U5pMg+EW2UUle23A--
