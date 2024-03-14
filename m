Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE21EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 12:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDE187F48;
	Thu, 14 Mar 2024 13:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qvujHZTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B19A87F71; Thu, 14 Mar 2024 13:45:42 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E90187F6E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 13:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-690d75c73f4so5706846d6.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710420335; x=1711025135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vkeTXrfNFiTyfN8/SFZtaG/EQsusBes3T9xl1TeecWk=;
 b=qvujHZTpJI5vzHbSQWM8tHZUTvgDdCKzoyCiks3+1wIbV4oQXYNvu8Vk8p7Oi2Qtud
 6Vo3uUNGbOk8MQn/ADte98QtS5twEy1/loBCeTkQgaiDxrTFi+pNS8AYC6R4Fap7QsTG
 wAHWVgnTkhOnImmqBqyPdKd/m5lDYxk82vcBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710420335; x=1711025135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkeTXrfNFiTyfN8/SFZtaG/EQsusBes3T9xl1TeecWk=;
 b=Kt7ApR74DWikkCdxNVgKfSo76WU3tdDl7+Zh6TdlyPhtkBNc5KQ4YHsVgI5P3/DmNb
 bW63Io1jhalabY014VNHiX1uG4JJAwctQOT44h2fe1nkI6BeYi2usF1DD1eqfFZjAMpM
 L4BUl4z9vijDdiJrxRXO6q/lT1lTPUpEwQJwVwnBFrmwEIYam405YuwoDdDaeYOn9Pc8
 VN/yfkA1SeCWkkM3terejBv+N4dLgWYM+HR3yOKI60yktYqZY4E3oqA8A0EViVrs9sbQ
 Nttv1P/KtLtYTD5O+cgv2oNTk6o0XqpOHnC8NCU4W/ShckS+hOFyRc+kuiBC+9Ge6RGP
 W+2w==
X-Gm-Message-State: AOJu0YxZyfuv1GxVA3fO2gECPGBZ6zuOUNleMh5ciqVmrP8FCPShF/Ci
 D0lJoTaQT6+zCf5OQx9yT3mdxf0mqJ7UdY3mwsB4Zxm/SPTyd0Kd0zn1BLXeEKk=
X-Google-Smtp-Source: AGHT+IE0DVCRXTaBES/Bjagp8U7nCmqb1BQfxeISrF6vQCQSKGhPUtFqLfpof3E6FESajkDOUEg4bg==
X-Received: by 2002:ad4:53a6:0:b0:690:df46:2ebb with SMTP id
 j6-20020ad453a6000000b00690df462ebbmr2085290qvv.56.1710420334855; 
 Thu, 14 Mar 2024 05:45:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 r7-20020ad45767000000b00690f9ea30aesm398808qvx.26.2024.03.14.05.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:45:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:45:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexander Dahl <ada@thorsis.com>, Mark Kettenis <kettenis@openbsd.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: Pull request efi-2024-04-rc5
Message-ID: <20240314124532.GU3442575@bill-the-cat>
References: <792febd8-7372-436e-8720-3efeb8d66b75@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3jTx5y3otKvGp41b"
Content-Disposition: inline
In-Reply-To: <792febd8-7372-436e-8720-3efeb8d66b75@gmx.de>
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


--3jTx5y3otKvGp41b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 01:19:40AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc=
2d:
>=20
>   Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc5
>=20
> for you to fetch changes up to c8a2567475508156f4f43ea2caf3532790d47f8e:
>=20
>   doc: fix incorrect path Documentation (2024-03-13 08:16:16 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19917
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3jTx5y3otKvGp41b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXy8WwACgkQFHw5/5Y0
tyxlMAwAkurNk1oq6HMghwm7z1d3Is/fCoD4cSs1x2M2Ui/bDPjboEMkqZH3MXqK
9dXBgkMYf6FWK+0Xs9Vy1Jx/GJEmghrwhF1KAj9+O3b03++Gcyo8yzBk+W6U6sx3
zVqJVvOJnNv84E99t0EOhzfIelmBotDqOFBYMrGnanrZVHMzYcF5M4a+1XF6pSZs
8jernz/a6pnG1HQ0zpAHt1G7TVVy8fRcjdXnQSiM44O8uQw1bq408FmqrRUtLR0y
c9g6KXANjTJ661R2uos7h6VrHJzwMGTLfOnL3Q0W1AeKjc4vPv4+ThgEgPW/lWHF
MM7DRBVW7gMlAY1ytOUnQ1XHAzgej0nCBqjzLxexdN9PbFopQzA2X0aCduZk1jY8
BDMj76imt18r5tB6n/2D6GL0JYhPDGvpwN4J8/gKEgQDpkiwc0jKNDVVYhwqPTLs
VhPlalQXBYSa7NEom42qD/5LHvpbQk5IwDVFRIk82Do/2Z9aznbBZNnNZ7ZsFPxM
rSMguljx
=8/7S
-----END PGP SIGNATURE-----

--3jTx5y3otKvGp41b--
