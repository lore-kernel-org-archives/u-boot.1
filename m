Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37619EF5851
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 18:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFC483AA9;
	Sat, 14 Feb 2026 19:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QPZQ26sJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C5683BC9; Sat, 14 Feb 2026 19:59:09 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF5983AA7
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 19:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9744C600BB;
 Sat, 14 Feb 2026 18:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5CFC16AAE;
 Sat, 14 Feb 2026 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771095544;
 bh=ylfegkUHdKXJdh/ZivQKduadmy2QYDwewCQxZdyEX0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QPZQ26sJ8uw8/ZwDakFaRUY/lYqYSW4mDjhuYaaMMygfOSfLEFyIZ9LeEXWXjjYeM
 GohSwqdtrTRNbiu+JQRDC0PTYidRWVN+Pzi0T0gNIbtcrumpGc4V6mlQqnVy7k27qN
 XjhX9A7GIVb9TONVh6KWF3ejcx8U84BemXfBI4BZh+GFQq0ocYwy186f7P+y8lBX9k
 jbnWgOrSmIvPeaKzMIOgmv4ffarQnRQeLNZetuflosDpypLQE/y63uWGgTWij5l8Tk
 VeZaZZx7Vr5nioER7BZgyTJOXRLT4KHBxddMXOQ83v+OvftQE8jz08HEBH8A/QqDBE
 QqGuKIlXLG7+A==
Date: Sat, 14 Feb 2026 18:58:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, mwalle@kernel.org
Subject: Re: [RFH] SPI and SPI-NOR patch help
Message-ID: <20260214-sternness-cling-4259916a8f73@spud>
References: <20260213164607.GI2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pbYNaaR3Hrn6kEM7"
Content-Disposition: inline
In-Reply-To: <20260213164607.GI2747538@bill-the-cat>
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


--pbYNaaR3Hrn6kEM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
> Hey all,
>=20
> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
> and SPI-NOR subsystems. We haven't had someone with time to actively
> work in this area for some time. I'm going through the outstanding
> changes now, but it also seems a common problem is that with respect to
> device IDs, most of the new ones also aren't in the upstream Linux
> Kernel. Is there some better and generic solution we're missing so that
> we don't have large and often growing device ID tables? I'd rather not
> make that problem worse, so I've rejected two of those types of updates
> today and I'm just setting aside a large number of others.

Dunno if your timing was cursed on sending this, but Tudor submitted his
resignation from spi-nor maintainership in the kernel about 10 mins
after.
I think Michael Walle might be responsible for what you're talking about
here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"),
but idk jack about spi-nor stuff.

Cheers,
Conor.

--pbYNaaR3Hrn6kEM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZDF1wAKCRB4tDGHoIJi
0gi8AQDMtlbbqZZQQGwYyzwhMCT/lPX2qDljt8A7lU/8X0Vo5AEA+SDfsJeQiKDa
+hCzeetzDT7qdU3ipQdp8vfvXYQ+gQ0=
=kIUW
-----END PGP SIGNATURE-----

--pbYNaaR3Hrn6kEM7--
