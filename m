Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C45BC25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322F687946;
	Mon, 23 Oct 2023 18:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sx3YET+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9E98794A; Mon, 23 Oct 2023 18:59:06 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7729087948
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7dafb659cso35446527b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080342; x=1698685142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XjRoUyxuO1lisJCcE5KdzkaclwXovJ40zT3r7bEu7dw=;
 b=sx3YET+w0lYl2AYf5MCEvEEpWkq1D/0rcsbGH1gJqM4QPCyRy6a/8mbmANbzBvcAFM
 LWeACdns0SVjEOsQV8m/KBaaLAE+WLBWviTwOjaGDB6wvmmGHZORu+S/pLlJB4WIqA44
 zHH/5UkqLTgH25CneXjnGbAoVARgoQ2c8HZa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080342; x=1698685142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjRoUyxuO1lisJCcE5KdzkaclwXovJ40zT3r7bEu7dw=;
 b=rSJMgeMGdTaUQjVlk6freBj2gIe/Y24IukSA2V5Oz71z9goc+eYl5eve98SciQG90P
 KNbiXLM1r9O+/BXgK3BDUhpV9uhbUotMPQEYWbTRdtWnYkNel6mtjhT6Eibvz+xVJmlF
 VL0QaHMkBsCmtXwWz+PvXr/pZkkB1nNWVlwFX3EJHidGh4VRKIuyb3o3I1Kz1uDVeplE
 hJPXfWSivgqaHBz0nW+dxC8vryYMsZpJ80ljBxdHA97VcRl/P6jVIQbgEeRgstY0j9Dm
 nJ32U0lPaME1v5e7TM56PJQLowp98zWkGmrB11j25Kv0TVcV7Hm7C7Yq4HuHx3VdMVGh
 +jlg==
X-Gm-Message-State: AOJu0YxY3m+pTUEVpLJvC41ca3F//pYCqDrBOCQnT1qKfQmUeiL86oD/
 JHeg7YkHQ5O8hqZre14+7/DYgTYVKLFA8jvULZBnnA==
X-Google-Smtp-Source: AGHT+IH81khGrh0JfvdX0PSu0kX5q0eBcbq7bw4RTpP4PyGdBnxs17bGt+Z7aWKaTVM36Dnq4k/hHw==
X-Received: by 2002:a81:84d1:0:b0:5a8:204c:5c9b with SMTP id
 u200-20020a8184d1000000b005a8204c5c9bmr9817653ywf.18.1698080342111; 
 Mon, 23 Oct 2023 09:59:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 r65-20020a818144000000b00559f1cb8444sm3277326ywf.70.2023.10.23.09.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:59:01 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:58:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] u-boot-at91-2024.01-b
Message-ID: <20231023165859.GQ496310@bill-the-cat>
References: <93ffc8a3-5e32-4509-83e8-031c70b0ac30@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EdsO84EHblICwcye"
Content-Disposition: inline
In-Reply-To: <93ffc8a3-5e32-4509-83e8-031c70b0ac30@collabora.com>
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


--EdsO84EHblICwcye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:23:38PM +0300, Eugen Hristev wrote:

> Hello Tom,
>=20
> Please pull tag u-boot-at91-2024.01-b , the second set of at91 features f=
or
> 2024.01 cycle.
>=20
> This feature set a new board named Conclusive KSTR sama5d27 with some sma=
ll
> prerequisites patches.
>=20
> Thanks,
> Eugen
>=20
>=20
> The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207d=
d2:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-=
20
> 12:54:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git
> tags/u-boot-at91-2024.01-b
>=20
> for you to fetch changes up to 27347893f02d4457b80357a38c194a726a43533a:
>=20
>   board: Add support for Conclusive KSTR-SAMA5D27 (2023-10-23 17:07:06
> +0300)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--EdsO84EHblICwcye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2plMACgkQFHw5/5Y0
tyzEzQwAs4acbnJf6WoU3FwBk5lJV6NCqV+bKRTf19TtfMSA0mYT8btvJ3X5x+tW
4bBwwRRokqCENnGUogXp1NONE6YZFoL7PG/5y6zyv+K2yb0MJ5YNts2O0j4nr7Rd
VIg3UZ+qwYmkCfDwNgtvCwuSximwB3btTGcnPUI6sSEhZx6loPXU7spcyGPq/K/F
0lowlf7xHnFVWtFInJCpY5dbycU/eBzL1xXGPHVdklheYvaS58kmndIAqNX0mDUy
o7g10dGV4yWYYd6HU2UX6k/XrQS+Byptw1GVZUqcEd0dfk0T6spVLCVwMVuzikuE
NsOR9s9xzdByWVUsq8bf9syFBk+wvx17IAeSX/SadzcD6gIfSQtcmhqqXhilJF+C
5y+5vi8cve4lVEoIrVOpN2s3ttZZ07219tgbt5sbjpcsJLntBTXUAg8QDyn6hgm4
cdjiqxmRwI9eL6V0MCRblWA8BoefgHF7rKlsGC0GcC+9QlYBzwh6h2bq8cEW/1M+
txID+a1u
=8LW1
-----END PGP SIGNATURE-----

--EdsO84EHblICwcye--
