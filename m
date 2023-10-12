Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E70CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10DB86E5A;
	Thu, 12 Oct 2023 23:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rshsdIDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463DE86E75; Thu, 12 Oct 2023 23:11:03 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE58F86E87
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59e88a28b98so12179497b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144633; x=1697749433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3gPyBDjy6bT7KUJ4xKYcnIwBgDKIISrwphRwtmSXctc=;
 b=rshsdIDlEcnV0kp25skXIwNYXfJEdoH+HNokY9hDfdefBxPwZfiAvAlhB11fpljUDU
 IICEHINt6gJP17a6c7qySMETPMErtXDapgKoHOrSm1BcBHr//L/L5nygPaziDS73z92f
 cblxnVsaR5NuI3yvZfyiYq69vW0BIJwQBMKH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144633; x=1697749433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gPyBDjy6bT7KUJ4xKYcnIwBgDKIISrwphRwtmSXctc=;
 b=UjiEaJe2VUQdvqIyacBFtUgP8mY80TYCivJtOyiS9/dZUPCtiWKRBV3pn86KuBhRfu
 fc3klcWL0oKPbsLJX4jLVy8PSBSYqAz2wAGwfTTv9J/U0ne91qEPLEOhclh5JkpYUieK
 pUrbr8PL1hnPd+7sM9lo6iqNAmIsbdyKCFgCPi+31MdDTvgCpQWhsf977Of5Ts+lcz2Q
 Fcz60l9sQM0SkqzChc4mfmNVM6xfNt1MdWXZSVf095rCKZER1aGQjJ+4QlCyLHdLYsRs
 0mOmujA5KTfzU43F+4dl/TxvGSWhn5kuhyOe+t59EO18lk28F5ooF+gjJys04ePCZKf1
 ld1g==
X-Gm-Message-State: AOJu0YyyeW5GkagZvHOwQ7fEgER8jWU8BVgADu3ZWHeCs/XRNCu5UuqU
 TVIDWxidBxtG2yyGf4F8v7o/4A==
X-Google-Smtp-Source: AGHT+IHK+N6/topsWAqSBxy6I2djrIJw7N5Ugv+3Yc/ZsmhB9MUCadNVPwUqqp/YonC3IDlR69gJEw==
X-Received: by 2002:a0d:d491:0:b0:5a7:fbac:4ffe with SMTP id
 w139-20020a0dd491000000b005a7fbac4ffemr1953414ywd.22.1697144633026; 
 Thu, 12 Oct 2023 14:03:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a816506000000b005845e6f9b50sm216320ywb.113.2023.10.12.14.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:52 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
Message-ID: <20231012210350.GX3119521@bill-the-cat>
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="usgKFSbymszu+9Q4"
Content-Disposition: inline
In-Reply-To: <20231005130642.21402-3-rogerq@kernel.org>
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


--usgKFSbymszu+9Q4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 04:06:42PM +0300, Roger Quadros wrote:

> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>=20
> Drop header files that are no longer needed in am64x_evm.h.
> k3_dfu.h is available via k3_dfu.env in am64x.env.
>=20
> Drop unused macro CFG_SYS_SDRAM_BASE1.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--usgKFSbymszu+9Q4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXzYACgkQFHw5/5Y0
tyyrrQv+NF+ECOq5tZpSNhFu/95QXbxMBbVOXCHpQ1yV/j7sg89npzbM+9B+iPAe
zc4vVMPMgEPL2rArVL6S0QbhkcUZtYAb5oX/GuMwhstEeS80zmHmusxB/dceqeby
GKaYtdeRxdKStKwC2inF9cvu5FKv2A+6O01KbYg2xKgIYRasoMOyv0G7JbECbvZO
KyvPmLRQ1xTR7Px1CxMSuOSr9TQb1X7pIHqhLqNtPPjchQyMtkEwRdFeS5XlHDiD
/qV/AdrYeNQJol4DNu5aIDF8tKH7NNGjisbYxyYZALSdTxl+DvFClx+0vmBVnvov
055genib2Mt7jrr34qq9YFmWUYYXRR/D/Fn/khHo3J21xFs58IC4NA+etFMHSs2u
2gASuotr8ajG4DhgoqR/fNGZ2aLbxXRsSzLsIC5PYbzSlgV+pp4SDVPI+uxJam40
grUCz6LFXkZUbLY9kFhLty/TrdoxqE59GmjEPNZINrxINubsf1LUobS9X5QIv4tK
fsFsH1KA
=8URy
-----END PGP SIGNATURE-----

--usgKFSbymszu+9Q4--
