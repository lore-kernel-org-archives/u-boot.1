Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B82D6ED0F
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF2B89688;
	Thu, 21 Nov 2024 12:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ucw.cz header.i=@ucw.cz header.b="nfaIGC9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881AF89731; Thu, 21 Nov 2024 12:36:38 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3317389603
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pavel@ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id AA0E01C00A8; Thu, 21 Nov 2024 12:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
 t=1732188995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hmEX7oVxr3GYBUY6DMe8t+lrwxK6hYdYQa8W0wAMD18=;
 b=nfaIGC9ve1+cBUXSIBxaPTVSWjRIJMGoZqb3jWBsUaElcQ2I5sZ0F5rPSdPEVSB+eO6cyd
 iotik0xaG2pBjJ4AhPXrNjmmlQnQ4IqzNKejU8FgLIYhIrmNR+hwfQDOmhjGdf2zdA+2Ah
 gKBIA71/5Gq/M7CbfLC9PKRwiaYAyk4=
Date: Thu, 21 Nov 2024 12:36:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@konsulko.com>
Cc: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
 Michal Simek <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <Zz8bQ4otq5752b6x@duo.ucw.cz>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p2DKfhNJqW4Wp/fu"
Content-Disposition: inline
In-Reply-To: <20241114145636.GF3600562@bill-the-cat>
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


--p2DKfhNJqW4Wp/fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2024-11-14 08:56:36, Tom Rini wrote:
> On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicro.com =
wrote:
>=20
> > Hi,
> > Do you have any updates to share regarding this vulnerability report?
>=20
> Michal, microblaze-generic is the most active platform that enables
> FS_JFFS2 by default and so vulnerable here. Can you find some resources
> to look in to fixing this please? Thanks.

Is that a real vulnerability?

If you can write to raw flash, you can also replace u-boot, no need to
to corrupt jffs...

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--p2DKfhNJqW4Wp/fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZz8bQwAKCRAw5/Bqldv6
8nEwAJ9DrEZVbbWZhE8U9JSptapIMIfh/ACgknFhVVVt5+TNNGEt34dI4jVjj/s=
=2QcH
-----END PGP SIGNATURE-----

--p2DKfhNJqW4Wp/fu--
