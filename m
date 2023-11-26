Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0724C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 03:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED2187075;
	Sun, 26 Nov 2023 04:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WfjI6fZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F353F871A4; Sun, 26 Nov 2023 04:30:03 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D15A87075
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 04:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ca11922cedso31363187b3.2
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 19:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700969400; x=1701574200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gOt0kSr+Wv2a2SJriv4B8cVenid499lDDlY93U9mGzA=;
 b=WfjI6fZ41LDrp0d8WmtWjaZgY6oqaIm+x2xBi04g8/3V9+X00gJIDJymUGR2ssD6RE
 DKhLV/E32AmDqWwIFeSgTxKgeMKsiZS3zZGg2yAdABESAmWuzY5aHeCqvwqw+5ce0LZK
 awuRXMtTlcPsjv6ybNp4ImoriOxp8yDSK5nSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700969400; x=1701574200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOt0kSr+Wv2a2SJriv4B8cVenid499lDDlY93U9mGzA=;
 b=PDJfIuAQ565EkKq9mqLlDLw6A25MUYl2ax8Z5O6Yg1BFnu7/OyRRAfSMLQnVESxCUH
 ebo41Ufbak/NYqt68AynoW2TyA6zB0ho0oUm5SbHna+PTO0N64D1oWOxBC4ITQk+JfSP
 ULhovjzgLibRvuvRNWLyqm1qI+3oJgfiSK29WmpOrngGfOBo5SoFKxKLdd5cxuTHina5
 4YjcZBm5y6Zulc3RTD8Ae7vsS+4+j4gfOpVCvsUXCrRIIiK+Jc4qwVAHUICivrXUOjX+
 99MnO4aOBVPKUlz89sjKwQ6Wz9eSLHgpKO+ZH7PbqTIBQdK0BNgvvvIUc+Ddqa/9ew1O
 kQGQ==
X-Gm-Message-State: AOJu0Yyrx9/ean7H7nZKpMgPw7btxlg9HW/PuBKQPt884vfTPviI9qVx
 cqlTA9/Met1qvoUgsKJcMWNSDg==
X-Google-Smtp-Source: AGHT+IGfdUHioX6/LEBOh88jQu0gJVBqFBJ8ajbmt/hgNJPGljH+KFihkEqYOjleWZyQjUSsADmCRQ==
X-Received: by 2002:a0d:ce01:0:b0:5cd:9f20:966c with SMTP id
 q1-20020a0dce01000000b005cd9f20966cmr6680667ywd.45.1700969396151; 
 Sat, 25 Nov 2023 19:29:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 g15-20020ad4510f000000b0067a2a0b44ddsm1108200qvp.44.2023.11.25.19.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 19:29:55 -0800 (PST)
Date: Sat, 25 Nov 2023 22:29:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20231124
Message-ID: <20231126032953.GZ2513409@bill-the-cat>
References: <87il5rbfkk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lzpw3q3s4BJU4wYv"
Content-Disposition: inline
In-Reply-To: <87il5rbfkk.fsf@baylibre.com>
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


--Lzpw3q3s4BJU4wYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:39:39AM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some fixes for master including:
>=20
> - Fix reinit for ChipIdea controller
> - Add missing newline in fastboot error handling
>=20
> This CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/p=
ipelines/18703
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 24ca49b33af98d54d6cd2e845f071f6565345f=
fd:
>=20
>   Prepare v2024.01-rc3 (2023-11-20 08:43:46 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20231124
>=20
> for you to fetch changes up to 6f68dcd0259f9f1c03f097669e9490b13b5325c7:
>=20
>   usb: fastboot: Add missing newline in pr_err (2023-11-21 09:19:48 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Lzpw3q3s4BJU4wYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmViu64ACgkQFHw5/5Y0
tyz86Qv9GQGRkQ7A25CoXTXC+XA+wj4KB8o3sqGn34Ne14kjn3N3GUzccoBUnc2P
D+LWO7m/iwub8EWaGm1JJWlrJxADN9p0Oijb8khkSU7TvR7x59Kv/1sAxE6iflO1
/xS2s0rQ9rSUotWzyNa5WOIzjWJ9MyRc+OGOmJCjbhFcmFXP/iXSBjFC9Y0EoE0P
IuMag3eSXybvk2LFCV7mRELQOjcW9EzPLaDlJUjFIN431+htPi7Rd5Ym3ckUNM3z
YSm/Sr2Xmqw37Xm9qLYPy3GD/Pyo8RQMmu3JRhtwCEnvs3u0pPmpmiWG3BYqQLBA
I86PxBXzSq6Zq+LPHCqGG/ZRKngQ2EHgkNQBH5NjbGB9/ILsw/i+FDwrf3OuTs+H
vDRDWF+0p8LVcQZRg485wClYCvGAJ3AEntCJ8ObQXlX7c8NnwTJJn77mfeZoDGhW
L5AGkCq6uyIyHpUI9woMQHJR6Vo0Zh3lC0DbXdbP2PL52UolE1kM5pQlI+y4SzmW
WyNKJeNS
=yGJD
-----END PGP SIGNATURE-----

--Lzpw3q3s4BJU4wYv--
