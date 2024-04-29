Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA324C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 16:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39120887EA;
	Mon, 29 Apr 2024 18:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mu57+4HQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D769887D7; Mon, 29 Apr 2024 18:50:05 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F818887B0
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 18:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78edc3e7cd9so354904885a.1
 for <U-Boot@lists.denx.de>; Mon, 29 Apr 2024 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714409399; x=1715014199; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pfvKoZ4B1iofuKtzWzVysfXxEwYvXgin8bYrsRGf5Ns=;
 b=mu57+4HQNOHZ9en+mXgsukCadNMB0ICPqpsI5aZWQY8RKCwybDVu4sXxNGFIoujItI
 fICYIzer/1AXJir4jiHa2AX/6hWNxz621vX3jisxdAu5BBSTwNf1mlKQCRMrqzW7Q1bx
 gYJyxFa2wWMPUpef4m8+8grhetdfrbtoJO2lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714409399; x=1715014199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfvKoZ4B1iofuKtzWzVysfXxEwYvXgin8bYrsRGf5Ns=;
 b=SEvLmB3brfbcSsLP4XnzwOelYOkSjXZx0NCuDgHTI5h5376a3HWTkzkwDLU1uh1hyj
 oZhudOv46YriDedgOSeitZrZbzJH/aHOO2pYQXrsxTQwW/OKtEYy6P80L5E0vqRv45yr
 eV0Ao0Gl6j+85Iwyqa3HNx9UNberEqU/Zk9Y1DKh66gHAQco6gw+e0pEbHtMm2m8F4BI
 P99wOAZiiWFa+1JVMFSaBCuhJqRZRMqSPqFN9aQ+TH1WLs8o6r8E1lfrDasG8BYydiMT
 K3TJndDkc+LAgqLucfq9nBY6j75a+HGLu+qt1sHKoLT2FclGq/gd8UBDOMNlicc/omgR
 vsIg==
X-Gm-Message-State: AOJu0YzKuZleziMZHxJom4HF+slOLZw4nqASu5l0enpR9TXmePjNONq3
 0NAWAFtrg8th7glsDz53RvqJVgT4sxmVQ2/u2Wny3Viy8Huw/3yikDOj+B1HhfI=
X-Google-Smtp-Source: AGHT+IFpik6PI+72gkfHA3xRelGM9hjsczjY/iAS72Jja4+aakPpv5d/2r3PRcCT/vEFfVHagcGa5A==
X-Received: by 2002:a05:620a:4045:b0:790:f43b:d88a with SMTP id
 i5-20020a05620a404500b00790f43bd88amr4776988qko.36.1714409399489; 
 Mon, 29 Apr 2024 09:49:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p16-20020ae9f310000000b00790f69a0583sm927043qkg.5.2024.04.29.09.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 09:49:59 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:49:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>,
 Bhargav Raviprakash <bhargav.r@ltts.com>, u-kumar1@ti.com,
 Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-pmic master
Message-ID: <20240429164956.GP1054907@bill-the-cat>
References: <CGME20240429082059epcas1p1f35772730ea8c9b8caf558bc360152c2@epcas1p1.samsung.com>
 <03866810-e652-4668-9e47-7ec88949a855@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+N6tqiPK1IWkQZsb"
Content-Disposition: inline
In-Reply-To: <03866810-e652-4668-9e47-7ec88949a855@samsung.com>
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


--+N6tqiPK1IWkQZsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 05:20:58PM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
>=20
> Please pull u-boot-pmic master into u-boot master branch.
> If there is a problem, let me know, plz
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/20569
>=20
> The following changes since commit 174ac987655c888017c82df1883c0c2ea0dc24=
95:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-mmc (2024-04-26 07:39:18 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-pmic.git master
>=20
> for you to fetch changes up to 17fd67aedde714556895a0d39431f482accd0cc3:
>=20
>   power: pmic: tps65941: Update compatible to aling with kernel DT (2024-=
04-29 09:20:51 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--+N6tqiPK1IWkQZsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYvz7QACgkQFHw5/5Y0
tywKdwwAlkNyc4FEmSJ4o6Uy0sqCqa4Bv9w/wbAhtkVu2PRT4XXW23PvUhW1UuS/
nntb8fI4QhYM8ZXQFnV/POxRSD9TTfOK2ka+fe3ClW+AoMF5k3THohFWn7+ZrTCN
Ts3bbsgvkwI6G/va4O8G4200oRBklwG5GYXYh5YlDwbbesGyXeSGin4T1F9iEwYw
+En9wttAX0xc301KJPXKoHxK+NwfMkbVMTjk9qB9aOxb6niGX0D4OpLn0PWicWYC
DKQnm0SILlqwq1SZJiJs7A6kiPOoWUayq8Mzfv0q4hvYIUMthyS22T4XxDfeuhar
OBKo/idJb1PXXZuSw7VWM3TssNyHE5+qZhDonygjVCuoYotiLflu3QmLjiVjsbY1
rkqxwm3/4P5Qm4JT3g45X9ET+akP8FkB78YjuKc0JiuZk+lNFdZgxtgCTRrwRPCj
Dpz2hui36DLSFeiShmBVu4rDGz1of9k4fjKQsW0QwOgFmDizUuZbI5ZoPaIW8srd
5RSrdXE0
=y5ZO
-----END PGP SIGNATURE-----

--+N6tqiPK1IWkQZsb--
