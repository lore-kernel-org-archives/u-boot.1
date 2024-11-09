Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41515D5E37F
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 21:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5E289301;
	Sat,  9 Nov 2024 22:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Igh5dCVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0298E89304; Sat,  9 Nov 2024 22:23:39 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC53892ED
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 22:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso613940566b.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731187416; x=1731792216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vEhPSRnkQ6aq5lZVCvvLuejcyjVPnla+qX8dvtGvZug=;
 b=Igh5dCVnrSorcPrAohgYH1YeBhuBa9gwMwmQd3PoRf4NMzRaH0u9Zw5RZyzBh9lrCd
 o2xhy9HQkwebxa1Kua/PXIjKZXKhIA8Sv+V/kCWh5ySX9D/XrgJQhjgVM2qHr5zu+ytx
 WvKdL1h888VN0j+JvgF1DqhteilkU/EJ/Ok1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731187416; x=1731792216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEhPSRnkQ6aq5lZVCvvLuejcyjVPnla+qX8dvtGvZug=;
 b=pYBABdWSkueg2bzmafLk4nL0fnCtBmVDupctN3xcbRthcgtSU8EToVAlQQdGMQfntr
 ZRcIGklx+Nrrk10gbF3Uied/Tm7ZJ0RNHXvDjE41oCJllgVTFvt8DN687xjKHVNj5N0Z
 VpY6bmYE/DYC3mNDVvE7q+zMFzGioYL9y7S1WjcLP2vGLtUPUC/5MnwghrOKP+wc/brV
 32gcKPcLuusJ5jjt78qOxlDQszGeXMyDn6cZSTmFFk4u5wC8f07xT8AnmUs1jcq10WS9
 a2krcDJPiz7+JIwsP0pEZqBWAxu5/xQ+PK62mpfn2GLmhj5DJ9o1pjz3WTRdkwbvoiqQ
 WGpg==
X-Gm-Message-State: AOJu0Yx1PqfD3X75xv99XMetktEUyCk6sH2oweZ89NwHM9ECVT6ylZ42
 pd1aXXSv6TjdUqN9lBOHEUkIGCkXtTbt7n6jFdI+49lkEzvE5DADDMdGrNZyxN8=
X-Google-Smtp-Source: AGHT+IE1j77yMmgpnveFLxvxRJ4nS8UDvzEGzNg1RWv5B43bz4b50rof0DiSlmzmIY8dA/gCSKZkMg==
X-Received: by 2002:a17:907:6ea5:b0:a8d:4631:83b0 with SMTP id
 a640c23a62f3a-a9eefe9bb4fmr714467366b.5.1731187415885; 
 Sat, 09 Nov 2024 13:23:35 -0800 (PST)
Received: from oliver.lan ([23.155.80.164]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0dc4c60sm410187466b.102.2024.11.09.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 13:23:35 -0800 (PST)
Date: Sat, 9 Nov 2024 15:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241109
Message-ID: <20241109212330.GA72527@oliver.lan>
References: <20241109170826.1995522-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g66gIQBwlj1mGbuv"
Content-Disposition: inline
In-Reply-To: <20241109170826.1995522-1-festevam@gmail.com>
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


--g66gIQBwlj1mGbuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 02:08:26PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit a7a96a37cbd875994bc8d25adb0536bf00e4a3=
0e:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2024-11-06=
 10:44:33 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241105
>=20
> for you to fetch changes up to 28958998f6301bc4a247a9057a623f997ee78c11:
>=20
>   arm: mach-imx: imx8m: re-use SNVS init routine (2024-11-09 08:55:04 -03=
00)
>=20
> u-boot-imx-master-20241105

Applied to u-boot/master, thanks!

--=20
Tom

--g66gIQBwlj1mGbuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcv0s4ACgkQFHw5/5Y0
tyxvjwv+PwR1+K1VacSb+vzEhmTce6cJYTwsvoXTpoc06mys4nLCpoElVcbIQgeR
3nya3O6hYhD8qR0fBN7QqZzwd5Vq7Ls3si6S42mU7NL1O9JJCsNfT3qxthl+PhgP
V8nXsoGKgVaWsLLKWkRmBJMyOifVD8CEflDa97zUwX3sOrgHGQQdf+BtD+J9sEb/
MVBIHK5BNQ1FHcOSf+96iPmg9EVnKVfWncELe4+vjeGjWzH/8sItYU0IjT8FkNqJ
Gtqic795QH4wQDsXnhH53ZflSwUFkkzRfWtgKaMOjy8g5OxLw/88TeO8TY0nnclT
VImiybBCZyn/F13Q6FaxyJm8CmWD7XuXviw11JOeFhTidv0r3AVErNXwtK2CoC9S
b5rGDd01c+aePQZ8fJ5Kn6uLeMzYudPfGd+b/N3fw72uaW7WIMqZEcAej8CHaYk+
Y46qyjKO2xDh9+RB/pxXdOT/3C7UXwntL/sREah36S5/DOh1IxZTNrRvVpD18LzH
nxYsw8EZ
=qTag
-----END PGP SIGNATURE-----

--g66gIQBwlj1mGbuv--
