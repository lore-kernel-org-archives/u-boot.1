Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA4FC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 738B388139;
	Thu, 28 Mar 2024 11:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711621751;
	bh=lNkefTuYRODQ5aFW0vfVv5T7PLQxDtewkuCr93YYMUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aBksYnMuyR2bxpSU4+R9MRKPRpXsk8qg/bLNTOlEQE1Qj6QkWjEdzqKbnmz6VMRjE
	 ofbfgKmMHsylzJR4AXh2yW8xInQ34bxfDjaLOMZN4s3w8UJxvM2yJcPqc51YOWIODm
	 1WwB9D5me2RtGydZ/y/y6ZjwOR1XT3FlvTltGo+MJgkhIsxSixNudDI3wtO6JSBG9a
	 4OC+JW5PwEnDcDJwQe8/OxBxxLsnzrXfspQAKzrcnsUMxjv+lyuLdHJA5Vw390U9ff
	 Tf5Yo1GBLDq1vJGdXc3u90M23PFa92yEap/cmUzxq/SzagL8EBYQLU2rkCCgGSGKEI
	 VfsTvOT+wnnGg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E8F3B88125;
 Thu, 28 Mar 2024 11:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711621750;
 bh=lNkefTuYRODQ5aFW0vfVv5T7PLQxDtewkuCr93YYMUM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=vp78VPo7G2tDEAZVaTPbmC+AIKDgBDxQP46iIGpBY9U+Ef+Ob1ibp8b1NOdco2NXA
 3bXAv4q1Yp5ICPry+QBarJmHwzjhEYTY8WaLDn3HxDulMJZ2QDYAKtTGJE+ZVR9XgP
 lpc2SuX733dDPp8/fVLURQ4pPVD8KyieE+SI6vw0iarNxWXyF/aiKDZhYl2iS/tjYF
 mMhHUVuRVrQzy3YPo5fxavG3di5XJfuzGyQV/UIOePgJxTn/4jswM4K/MJcGPMEdNS
 XpX4+DueGpkSVte6l3MwIVdkLsxitS5CuOATQeLfjUDPQmnzLPqhtssaqFhYBwTInR
 P18pssNds/iYg==
Date: Thu, 28 Mar 2024 11:29:04 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328112904.19f39d66@wsk>
In-Reply-To: <343af186-17b5-4945-ac76-9bd4527f1da7@denx.de>
References: <20240328102049.10108d5b@wsk>
 <343af186-17b5-4945-ac76-9bd4527f1da7@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Iaq_x1ATbJC29VCejDC9GnC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/Iaq_x1ATbJC29VCejDC9GnC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marek,

> On 3/28/24 10:20 AM, Lukasz Majewski wrote:
> > Dear Community,
> >=20
> > I'd like to share with you some thoughts about growth of u-boot's
> > binary size for SPL and u-boot proper.
> >=20
> > Board: XEA
> > SoC  : imx287 (still in active production)
> > Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).
> > 	 Board design constraints u-boot proper size to less than
> > ~448 KiB
> >=20
> >=20
> > When XEA was added (2019.07):
> > 	- u-boot.sb (SPL): 37 KiB
> > 	- u-boot.img 	 : 401 KiB
> >=20
> > Now (2024.04):
> > 	- u-boot.sb (SPL): 40 KiB =20
>=20
> Do you know which symbol(s) grew in here ?

I will need to check it.

>=20
> > 	- u-boot.img 	 : 427 KiB
> >=20
> > (With a _lot_ of effort put to reduce the size)
> >=20
> > Hence, the question - would it be possible to take more concern
> > about the binary size growth?
> >=20
> > Maybe CI could catch patches, which enable by default some features
> > and the size is unintentionally increased? =20
>=20
> Try and set CONFIG_BOARD_SIZE_LIMIT and CONFIG_SPL_SIZE_LIMIT for
> this board, that would trip build error if the size grows too large.

I think that setting CONFIG_BOARD_SIZE_LIMIT and CONFIG_SPL_SIZE_LIMIT
would help for rising the "red flag" of the size limit.

However, I would like to signal that there is a problem with u-boot
size increase.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Iaq_x1ATbJC29VCejDC9GnC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFRnAACgkQAR8vZIA0
zr1gIwf+O6k+Q6AzK/4+V0rioK3YBVng/SBTez3aKTwnCXQG5hiJ97h/HdsbQpD/
VYmCgLRspG7ZnMXg2McWfffYm/2NLZgd9tjrgBZhQqfEOcmR6iW7ZA68XA1xp+xr
IVtL/4aBkIjkZosE69TAHrwFemxBb5Yfp/9Bv+ptRDuJfIJAsbQOnK7AfhNQMdZR
h7fJi9xih6ENtUDxYGediaYY+E2WLAa27Lh28TC/7UawllQpX71fq/baYZ/JBnSi
+050BXUQfsQw0xXQ019auzFCA5MIkt+OhBbVquPVedgC/fURcCNLGpiPE+P3fTaD
zCmF8wmPjooLqGKzOkh4eaqOejuMuA==
=yplv
-----END PGP SIGNATURE-----

--Sig_/Iaq_x1ATbJC29VCejDC9GnC--
