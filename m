Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EEEC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 14:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0E782B0E;
	Tue, 10 Jun 2025 16:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OZzc+p3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7F882B26; Tue, 10 Jun 2025 16:46:32 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA22582B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 16:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2e541e0b974so3859362fac.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749566788; x=1750171588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z4PrgIwlnalHXDtH+AMNk9CsQ7M8MWVArLVdMTHF0Mw=;
 b=OZzc+p3T/qCk/r9yMXLHsWNyEFOS0O3aXpQ2QH6OzLS1tSfb8MeCObd5WKn6jNaKRP
 4nJP3+/ihhWNg39ZGi6mMjU3O3qoNWPo3X987wQrpgy7GQCFzDrYo7ZiA27pusoqoahf
 kemXMh/XHo0h7Pkngdz1f7Z6AKOUcF4LGlLkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749566788; x=1750171588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4PrgIwlnalHXDtH+AMNk9CsQ7M8MWVArLVdMTHF0Mw=;
 b=dQLnTbw4FKTHO6Xim6Hz4//WlOtRwNs61SBgqh1zw/SjYmJ1P+ypsquigob5VnFdGp
 3/+O/QKaxguv/ceH4pQC8Wfe/00MxWdcKKPpKJUdt1tvhMDBIUYrbO7WXGYL4WSunmhL
 z1z7QUoMvDGhLZdhNu924qjHLKCV0bgk8mz1XJwOnvRmLxZoy4g7ewTsS6dDW/kpbMkT
 Q2TVkfXrCfL2KjKAvOijRhqo27/TBVhESotqn8rwxr5NMDvvhkmZ62665wGydVMeHSFX
 gcoxVQ2RqeFcRqc6f1MXo6IsYG/8HbUMUkk7iya5LSvujBsK/k7NwDotGuSSIet5acoP
 lGuQ==
X-Gm-Message-State: AOJu0YwdQ5TfMqy94UNI5KExPXAjAfdLMdKelRjvDtqbqYeqTJbX0vaW
 eTOwzC3h9+9ZBnkjRnOCY/GMOkcfHs8PcgD0I3gP3ja+0PAg8qxeQfmALIwCxb8dQnw=
X-Gm-Gg: ASbGnctxfOJalsoSAmZPIAqnB1nxhAViFPt1qm5h8gaoKNjTRkGaYhUW4/ystE3dajU
 7yaO4BpfcFB6W6e9cMSKaWxsiqE7cuaD68tru2OnoV+h2bvVIDhU2eZzmRoqxNvDIdYk5TUgck9
 o1rMRFAY7FLxyUbhJ7YpKQN03ZedVQObRmXHnc2/8fMSb1hI+2vcLVtkaPlpvV0mjfQyR1QQ6IN
 KH3/2THx7UE0/n/Ofwt/1j9qXgxB18oC3xt4eL6kzBQAAgBehlam73Tlqx6JBOZZlwbo3hARHUz
 NVJmZcbvmYoFF4bG7bZzh8iumDbAR4gOduNnsdY/BvoCwKLhTVxQXNdf4aui9IHye/LAgNMoBDG
 veVjy39qUi8Gc603gMJmJLuM=
X-Google-Smtp-Source: AGHT+IGbIO3+Zkf6kDFGJC78XCbwZz3LkUPYMcrKZw0fhuffN7t4cs79BGFe8XCYCjn7u4CMy+bgJQ==
X-Received: by 2002:a05:6870:a79e:b0:2c1:4090:9263 with SMTP id
 586e51a60fabf-2ea0153d811mr11224858fac.35.1749566788368; 
 Tue, 10 Jun 2025 07:46:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea0708d437sm2398335fac.18.2025.06.10.07.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:46:27 -0700 (PDT)
Date: Tue, 10 Jun 2025 08:46:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
Message-ID: <20250610144624.GZ1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
 <20250606190956.GA1382132@bill-the-cat>
 <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
 <20250609145716.GM1382132@bill-the-cat>
 <DAIRTBR6H2UR.3D9X1G3AV77FZ@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q3nyhKSsT4jj1kA8"
Content-Disposition: inline
In-Reply-To: <DAIRTBR6H2UR.3D9X1G3AV77FZ@ti.com>
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


--q3nyhKSsT4jj1kA8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 03:41:21PM +0530, Anshul Dalal wrote:
> On Mon Jun 9, 2025 at 8:27 PM IST, Tom Rini wrote:
> > On Mon, Jun 09, 2025 at 01:05:36PM +0530, Anshul Dalal wrote:
> >> On Sat Jun 7, 2025 at 12:39 AM IST, Tom Rini wrote:
> >> > On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:
> >> >
> >> >> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the k=
ernel
> >> >> (dtb in our case) in falcon boot.
> >> >>=20
> >> >> Setting it in board specific Kconfig allows us to reuse the same co=
nfig
> >> >> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabling
> >> >> falcon boot.
> >> >>=20
> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >> ---
> >> >>  board/ti/am62ax/Kconfig | 3 +++
> >> >>  board/ti/am62px/Kconfig | 3 +++
> >> >>  board/ti/am62x/Kconfig  | 3 +++
> >> >>  3 files changed, 9 insertions(+)
> >> >
> >> > Why can't whatever is using the fragment also set this? Is it because
> >> > you're only using this as part of say:
> >> > make am62ax_evm_r5_defconfig am62x_falcon.config
> >> > ?
> >>=20
> >> Correct, having three different config fragments with only changes to =
the
> >> dtb path doesn't seem very useful imo.
> >
> > Then these belong back in the main defconfig itself I think.
>=20
> That's not an option since SPL_FS_LOAD_ARGS_NAME depends on
> SPL_OS_BOOT[1] and due to the way config fragments are applied. Since we
> only set OS_BOOT to y inside of the fragment, we can not define any
> configs that depend on it before that in the defconfig like
> SPL_FS_LOAD_ARGS_NAME, it would just default to "args" instead.
>=20
> [1]: common/spl/Kconfig:794
> config SPL_FS_LOAD_ARGS_NAME
> 	string "File to load for the OS kernel argument parameters from the file=
system"
> 	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_BOOT
> 	default "args"

Config fragments can be nested, so maybe the falcon variant will need to
include the main defconfig, the falcon fragment and then set the args to
the dtb.

--=20
Tom

--q3nyhKSsT4jj1kA8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIRUAACgkQFHw5/5Y0
tyzP6AwAh4G2b61ECGXRWRGc/MNVCw8YbhxEfKiXC3kb3SrX3/+wHkASSxXm1GbA
SzarkRQRnLKvb6tt6zFD5K1dScB/xkesRzI5jInDLPWZrwwHalA5dsivnxsATcx9
N9uBRms/40us5RGzJu2igqmOXcAudfjWF0JTc2HCuyJNRx/86FgrnkkSEKR+KFO8
pTSHzpBJS1cXDQnx4hekByJ/5evQTgmx5gemVDkD57DZ3yioeh6D88ygOUaxKqqd
VlIHZ+RNyGsvgYeCtDkx9zIT0/1//QZIU+4COqrj2lc8JMhAX5OCYBvqTDuaBhFB
RGVvJvyJRnxmNrFmrUoext8AdKxabhk8fH4FhyUa+tQS01T8fHfOI2LIFTX0z62p
GFlXnbt7QqR0TQE3s/G3UjwoCS/nAxQ1YS0ZCan9FkEgiK0WY/1fjGZ2F/n211Hp
284cY/P/Rha2hhRKGxqsxHy4bltN4oDC2FpKJxhkhrAaWhfiD6z7O6n2BYFTKrWO
+grr2eKB
=gyJ+
-----END PGP SIGNATURE-----

--q3nyhKSsT4jj1kA8--
