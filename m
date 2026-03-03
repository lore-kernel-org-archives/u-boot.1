Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FFEDA698
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 16:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E692839DF;
	Tue,  3 Mar 2026 17:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="int83BuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE81783F59; Tue,  3 Mar 2026 17:01:11 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66330838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 17:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DE9E600B0;
 Tue,  3 Mar 2026 16:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5D8C19422;
 Tue,  3 Mar 2026 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772553668;
 bh=oILrhc2Dmaiqw9iiRs260CWqDOcegZOiRxEc8pAcRzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=int83BuQI2uUXErTOSuLZxpuyjMZ9Iw8JX2k+t8WY0PC3KWULK/4khsnjo3/ttB8q
 +RxPx8uVVipTIWC6U30oUUqp2yrRLsc/cGyZqlYlWcx4RpMLVyIdps1+ampYCmlo4v
 v0IyfwdAthU69hTUTwaBd/VH7gKVpAt6etrT3tk8xEQxuMH3Y0w1ygArqN+dCcwr2M
 mD3kTbnN1NJr4wPjlBspmMqT1m7SN2bJ8V8+tv7GvoSlmCcEnEAZ40FieLW9IaH4b2
 OkMi0TziVrv3uGb6ZX9+C7KAPU2AWrzjSVfMmvjTjUemj11lPlRDHqqBsHpvwWbnpd
 2WRXdGhbmrUaQ==
Date: Tue, 3 Mar 2026 16:01:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
Message-ID: <20260303-choosing-chivalry-6f892a14eaef@spud>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NOTvkjGUhkGjsIHD"
Content-Disposition: inline
In-Reply-To: <20260303143721.GM1388590@bill-the-cat>
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


--NOTvkjGUhkGjsIHD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 08:37:21AM -0600, Tom Rini wrote:
> On Tue, Mar 03, 2026 at 03:59:35PM +0800, Ng, Boon Khai wrote:
> > Hi Tom,
> >=20
> > > I don't see this binding in v7.0-rc1, did I miss it? Thanks.
> > >=20
> >=20
> > This binding was not introduce in Linux. This is a per-requisite commit
> > to support the Agilex Smart NIC 60xx board https://www.silicom-usa.com/=
wp-content/uploads/2024/02/FPGA-SmartNIC-N6010-AgileX-Based.pdf
> >=20
> > During the initialization stage, this board require a spi communication=
 to
> > configure the chip's PLL and also to check the chip's status.
> >=20
> > and it require the specific spi bits-per-word=3D16 setting.
> >=20
> > Can i add the binding at U-Boot?
> > https://github.com/u-boot/u-boot/blob/master/doc/device-tree-bindings/s=
pi/snps%2Cdw-apb-ssi.txt
>=20
> Why would this be inappropraite for the Linux kernel, once the system is

Did you mean "inappropraite", or actually appropriate? Guess it
doesn't really matter to me, since the former would be asking "why would
linux not want this" and the latter would be "why would linux want
this". And I guess, as U-Boot maintainer the former is more important so
inappropriate is actually what you meant. I, of course, always approach
things with the latter mindset ;)

> fully supported in Linux is the first question to answer. Thanks.

The property doesn't make sense to me in a linux context. bits_per_word
as explained here is a device setting should be set in the device driver,
and is almost always per-compatible so doesn't even need to come from dt
at all. What a controller can support is also effectively always
determinable from the compatible of the controller, and is often a range.

Looking at the linux driver, all dw spi controllers appear to be able to
support 4-16 bits per word with select devices also supporting 32. The
check is done at runtime, it has no need for a property at all. The
device driver effectively decides what is done for the transfer, within
the range of supported values by the controller, based on what it sets
in its spi_device struct. I don't know if u-boot has similar
functionality in its code, but looking at dm_spi_slave_plat which I
think is your version of spi_device, that information is not there.

Were this submitted to linux with the current explanation, the feedback
would be to set bits_per_word in the driver for whatever this "chip"
that's being talked about is, presumably that means setting it in some
sort of clock driver given that it controls a PLL?

Cheers,
Conor.

--NOTvkjGUhkGjsIHD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacFswAKCRB4tDGHoIJi
0tLSAP9NmtGEqeHABapQVtcjFEw5YrWrJyQaPXgLtIkyDWatNQEAiFngA18ouMKg
fBm2qvwi4zveKisRVYV5fzG3GPR7+Qs=
=9MoC
-----END PGP SIGNATURE-----

--NOTvkjGUhkGjsIHD--
