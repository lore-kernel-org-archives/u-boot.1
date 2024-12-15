Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0BE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 16:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D858004F;
	Sun, 15 Dec 2024 17:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EaQDjU60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A226780050; Sun, 15 Dec 2024 17:48:28 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CB380040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso4710516d6.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734281305; x=1734886105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pXR7KM/1lOa29+LWGjVOzz7gWXJu1Q6pNMPB6fp9ePw=;
 b=EaQDjU60vEXkA9asHyc5zQ/bCCFj+yufgYNMeQcwdYg++WfCl4R7hswa8f83r3ILnZ
 pFLSOXm3u2Wu9V1Xb5BWQTjw0WlMiuHFdj8l8bRuniNJUtbToqRfwyLNAFDG/EFT1rdQ
 hBLHN1UsmP9FHIGGGSjIHOamk8Zsfxg8aRBO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734281305; x=1734886105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXR7KM/1lOa29+LWGjVOzz7gWXJu1Q6pNMPB6fp9ePw=;
 b=t9bk2EYyf1A8cGb3SWw0v4H5uZxvehqyN4ZY9JcRCZatg/yc5NNXrI8miocoYhiOvD
 J4Q+tmcpC7YJwe091clEGNnnVq0GSeZZ1/LHDMGeqOIRoK9Mnx/EZTR2TZqRg4zpauvO
 /XpVonZUYnq1fZwWfk4cRIQ/3ixOGGotQN5t6jfFbvd8iaGUywYy7gmBsB87TCdYKjg/
 r/uR2lxDuNptX2ALMbCt+L2sqHvHiBMTiscKla9CMftjQNvUh8kZa+gbRvboEbEa0WI2
 XB20XvJivIWro+wxQwbgKgkIVPj7+B2Gjuc9Dmqhrz/LdTou1oNJHtoKGF8qL1jPwgVo
 NaKw==
X-Gm-Message-State: AOJu0YzIoJOkxk6wxODretR3HoUGQw3ZX4mBTrq+kKOpWVXjWzp0000w
 YR1Fy+TLuPFasl55ZGXkviGE7nW9fKZde4I0gqhk+2oFNgqYdga+DSy36Sxye/g=
X-Gm-Gg: ASbGncvzyT5pN3CoQswvFJEkMSzHYp/hoz5NtD/hD33hJnTk57IOfs7FZ+qosBhlnhZ
 KqzVLYpLmZ9wn773xbRBXGGr8Pr9y6FOb5x4KzvI8abPfw/9p8ba1mPcJ7O/OUcvLqQY7OeqpZz
 Y5XGwufljjxBA845Uq2CBAgkfFXosNs6+tXXCbrIstZ3OAVrd/PxL5u2/mzRJsGAgj/i+2MpicY
 sf2WDNFccRzHXtBAn7nyBZCJ+2NpekTN2R44kx4xhRZ7U9mcjFkVrK0
X-Google-Smtp-Source: AGHT+IHEq+liMjznetF2Alj6UTUcPwLp6GT5E3HfDZYf9+OzGdlwRnvoh34ausOFRpQ3kbnM6xr2Wg==
X-Received: by 2002:a05:6214:2388:b0:6d8:ab7e:e552 with SMTP id
 6a1803df08f44-6dc96878b78mr189196256d6.39.1734281305057; 
 Sun, 15 Dec 2024 08:48:25 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd25a2c8sm18188526d6.40.2024.12.15.08.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 08:48:24 -0800 (PST)
Date: Sun, 15 Dec 2024 10:48:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Andy Yan <andyshrk@163.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: Pull request doc-2025-01-rc5
Message-ID: <20241215164821.GA1505244@bill-the-cat>
References: <7739d82f-fdac-482f-8c04-8261e8aae069@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TyH/EFMqHL/NQz8y"
Content-Disposition: inline
In-Reply-To: <7739d82f-fdac-482f-8c04-8261e8aae069@canonical.com>
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


--TyH/EFMqHL/NQz8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 04:00:16AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 88bd5701efdc48048e030d91c2633048f0f753=
a0:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-usb (2024-12-12 09:50:25
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2025-01-rc5
>=20
> for you to fetch changes up to 55e8704402350d06e8ebf244515d96c36a3bacf5:
>=20
>   doc: cosmetic: fwu_updates: Fix formatting (2024-12-15 02:11:13 +0100)
>=20
> Gitlab-CI showed no issues.
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23857
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--TyH/EFMqHL/NQz8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfCFEACgkQFHw5/5Y0
tyy30wwApU6E5MpYU07rXXYUNK+z0H7f4lUEDoG18VisiNQ9IUQOTMgrjTeDScNK
wpwR+Ypn/2Ewwvc5wBvR9DQnoWKuaHx/2gNQZ7o8DT8mUMMbfKUWJK7XMzj59gVJ
7obHn35jBisns0CQasPOjM811KuFLDl68y7rLdUv0t/KvH3hoL9VbnT3bovxoLev
k9+abzHt4Sgh8AE1nGV24q4x/PjhrpoJWDPw2DgiWa17GYV1/cIwpDDF2yLa2JXB
abHQmjEPinV1TAuU0vUZWHPlggAwhHk7/GbOuZiTQS/UQWrK01Ueb3WU8CdezD7C
k74CoWwLkk/4J4X/kmrhXakDzlCy17mfB2C3OH0aoOCtve40I+EfFZv6YYycXP9E
0pYP5CEJwAX8+PtUJi2V6WInQ/oWwtRQqyICajkDMf2spFlcQrADrCghDO2Hsqo4
HJlOsF1IqP8j17XOPFWB9D979imC6sVjYBPqH08H0BTX8xoAtkG4OtapZ6a+jK+R
Mmw8dpLh
=dztl
-----END PGP SIGNATURE-----

--TyH/EFMqHL/NQz8y--
