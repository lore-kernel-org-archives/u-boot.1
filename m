Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87477C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A9780FDA;
	Tue,  1 Apr 2025 16:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4KLjYkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C298171B; Tue,  1 Apr 2025 16:56:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5703B801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E9EA45C5B12;
 Tue,  1 Apr 2025 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B229C4CEE9;
 Tue,  1 Apr 2025 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743519369;
 bh=9XCJgY16loGzc0IZVL5JWaCyTYkdjeb1tFnPBKJHX8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U4KLjYkb3Ly/it4EhpmZaZPAzrngt47XJ1LXjw/qToQZyGa30gaye6Sb2eDyQrTAk
 vIjovYHEtkm80c6kKP9aM4638EndXsxx1O+LGxP+oqzUlYlPPVoNqvaIQX8zeILELx
 IDv7Yu41gTQphlqg/NGyvfPeC/ie/oezSWRnr1zVmpEYxyYj0oStGg4TscogPK53bw
 K9teskG+bhI7vASMnhGiTrAHbFIiVksZXvgnErdXMzB5audYN5wIbgLAJwRDIEyyjr
 yhSfGkLcimi/Q5vkvFvVyzUuiRalzkOt07bNvwMANEXMURACrZ7NR9lnc9U1m65X3T
 qQ45A/dA5lLug==
Date: Tue, 1 Apr 2025 15:56:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <20250401-impart-fidelity-49e133443a5c@spud>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
 <20250401144420.GE5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jZ9bxzWJjoxZbLF4"
Content-Disposition: inline
In-Reply-To: <20250401144420.GE5495@bill-the-cat>
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


--jZ9bxzWJjoxZbLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 08:44:20AM -0600, Tom Rini wrote:
> On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> > On 27/03/2025 15:50, Christian Marangi wrote:
> > > On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> > >> On 14/03/2025 19:59, Christian Marangi wrote:
> > >>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is=
 not a binding and
> > >>> should not be placed here. Value is derived internally in the user
> > >>> driver.
> > >>>
> > >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >> Please drop my Ack. I have never acked such patch for uboot. If I di=
d,
> > >> it was by mistake - probably you CC-ed me for some reason.
> > >>
> > >=20
> > > Some explaination, uboot introduced the concept of upstream where they
> > > "import" linux patch for dts and dt-bindings.
> >=20
> > I expected OF_UPSTREAM to be taking the sources, not patches.
> >=20
> > >=20
> > > This and the other patch are the exact upstream patch with only the p=
ath
> > > changed so I keep all the patch commit message with tags and added the
> > >=20
> > > [ upstream commit ] thing.
> > >=20
> > > Hope Tom can better suggest how this should be done. You were CC
> > > probably because the git send-email included you as present in the
> > > different tags.
> >=20
> > Well, Ack is still not valid because I did not Ack exactly that change.
> > It does not matter for the ack, but for Reviewed-by it would matter,
> > because it is a statement (of oversight...). I cannot control what you
> > put into patches taken out of kernel, but at least do not Cc me on that.
>=20
> In specifics, yes, we should update doc/develop/devicetree/control.rst
> and maybe doc/develop/sending_patches.rst to use --suppress-cc=3Dall for
> dts/upstream.

> But in general, what do you expect people to be doing with content from
> devicetree-rebasing? We're doing some direct cherry-picks in between
> merging of the tags. I think it would be weird to be dropping the tags
> and un-attributing peoples work.

I'm okay with my tags being kept for cherry-picked commits, since they
show up with the subtree imports anyway, right? Doing some sort of
[ upstream commit <sha> ] thing like linux-stable could be a good idea
to make it obvious what the source is.

--jZ9bxzWJjoxZbLF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+v+gQAKCRB4tDGHoIJi
0gwJAQDG1NcEiO3mxZRc2lj2TFTpEFx+3Br5npEA12U53e3QoAD8Dk/Vds6ibhmw
OTXwG1FgE57Z/2tVXvu+4qgMTzrNwwM=
=Iu+o
-----END PGP SIGNATURE-----

--jZ9bxzWJjoxZbLF4--
