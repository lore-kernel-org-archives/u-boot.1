Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96419F89249
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 10:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01233843C0;
	Tue, 21 Apr 2026 12:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=pbarker.dev header.i=@pbarker.dev header.b="TpQoPXlP";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvgZE3+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B16843D0; Tue, 21 Apr 2026 12:07:30 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040B78439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pbarker.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paul@pbarker.dev
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C377D140006D;
 Tue, 21 Apr 2026 06:07:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 21 Apr 2026 06:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1776766045; x=1776852445; bh=aS/zom2hXG
 1e2LI+iTVcHBrLXhOGje5t85hibC3JSg4=; b=TpQoPXlP5bqt7H1FqaDIo1I0R8
 DhZDU+Xya/wi1kjuiq/dI8BJVT/TcbzAARToY3byCM9XnqMZrDT/3MNOKUcUu/B4
 M3VDPhwS0QP6eaRh51L5FWPyPXGioKLmgoKRXMKUR8iwpEYBQS2jkE3omEqMwYW2
 2YDQdTB0RqBlq1HnuxY/CSQMmBkr2blhf3Jy0w+Mn70GVs950c66mSn3zbMdlpO5
 Bt5sckHqwME5Y4j9bNnfRNeM9DqgCeMi923hQeYV+4X1unH18FQleCE3kkF/c6BA
 639KaEbDnImH7cIVMczosy4YHsO+4RXygimhXSPEQ8hWDqI5pTWCir+UheMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1776766045; x=1776852445; bh=aS/zom2hXG1e2LI+iTVcHBrLXhOGje5t85h
 ibC3JSg4=; b=TvgZE3+wkTPetNVUcIuNU8NR1qE0QoNgXMuu3fh5/jFtHltKrlO
 DLZD0tnwRjhFZ+Ib34h+Sn7O2PhhS9HuqWToAAIjw7xQa/fXlFFZhPM9jltz3LhB
 baPQzL7OatM0gKgi/oTIRo8FaHrCCDPGRJST4CA7+9WHk4d37dmETlay8yJn+uvl
 ICfAnuDhSRgA7rHecuCxVhmYZlZUaCA390djLu5+Wm3fcTMMBR9hx2T+lNROjoV1
 T/IjmJ6UZnkWTxhKjn8ZQsgPEorC80VMlkksRNd9kPRTQqAFgwlDlyJL9ChvsVDl
 iZKjNkJtr/Yyd3hnmdPg4bwYHaTg/lsW9qw==
X-ME-Sender: <xms:XUznaSsoainpzsDBa1ngsAHV824DKcG0Dwe3HBjUkUY38NZzQ6zOyw>
 <xme:XUznaQws2zeALxpXjfye6Ul7crRgXW-DmuDD0pbNT62RTbyNqC0r7DBQifGPkb_xE
 RC0X2-DjV4ln89TwXKKuL2enjVcSj0hG9ERbOXLjlCBY91PR8h8TZ3y>
X-ME-Received: <xmr:XUznaVBYahsSCPhqWwuFI1l0yainKL3eEAXDfd_jnNqyLiE4GvcI4xuH8kzopI8vuwJ77a_t62W8LEFsN2Vp17YBEbupqIv4qcbzcjPSdL6q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
 rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
 eljeehuefhffeuffduhefhgfdtgedtvefggeektdfhteetvdduieefleegteduueenucff
 ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgt
 phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfrhgrnhgtvghstg
 hoseguohhltghinhhirdhithdprhgtphhtthhopeifohhjtghivggthhdrughusghofihi
 khesmhhtrdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpd
 hrtghpthhtohepohhpvghnvghmsggvugguvgguqdgtohhrvgeslhhishhtshdrohhpvghn
 vghmsggvugguvggurdhorhhgpdhrtghpthhtohepfhhrrgdrshgthhhnhiguvghrsehgmh
 grihhlrdgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggv
X-ME-Proxy: <xmx:XUznaeeYj5CkpIrkAtYWO6W_UUix4vaXQiK7LAjkETYLsGkvhwZVWw>
 <xmx:XUznafkagOWPvWgnLaBhxc-Dw_yHXjDkRuLLJup2zlfSwzL29PjIpA>
 <xmx:XUznaVE2IZpnClqYYtwcyfmMM6LK7CeRojWq6Ri2c6lSU6sbhzCX0w>
 <xmx:XUznaX7C4LKtRpa4FLKMT-iW0p6WXLMe3AhxWEXBlYond31CjD9dPA>
 <xmx:XUznaVpqk0d8dymvQizABde9XWpdVRwcVmn0wHLc60ykMl2mfYQDT4uz>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 06:07:24 -0400 (EDT)
Message-ID: <e87d67ec12516ae9c62b1d7b19797ff0ec131b36.camel@pbarker.dev>
Subject: Re: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
From: Paul Barker <paul@pbarker.dev>
To: Francesco Dolcini <francesco@dolcini.it>, Wojciech Dubowik
 <Wojciech.Dubowik@mt.com>, trini@konsulko.com, 
 openembedded-core@lists.openembedded.org
Cc: Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de
Date: Tue, 21 Apr 2026 11:07:21 +0100
In-Reply-To: <20260420085001.GA47182@francesco-nb>
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
 <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
 <aeXgdkBin5uz0-OH@mt.com> <20260420085001.GA47182@francesco-nb>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-FSIrMXyddQJwQz8lGCqU"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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


--=-FSIrMXyddQJwQz8lGCqU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-20 at 10:50 +0200, Francesco Dolcini wrote:
> + Paul Barker
>=20
> Hello all,
>=20
> On Mon, Apr 20, 2026 at 10:14:46AM +0200, Wojciech Dubowik wrote:
> > On Thu, Apr 16, 2026 at 05:51:13PM +0200, Franz Schnyder wrote:
> > > On Thu, Apr 09, 2026 at 09:47:07AM +0200, Wojciech Dubowik wrote:
> > > > Some distros are using gnutls library without pkcs11 support
> > > > and linking of mkeficapsule will fail. Add disable pkcs11
> > > > option with default set to no so distros can control this
> > > > feature with config option.
> > > Shouldn't it be the other way around? Use of pkcs11 should be disable=
d=20
> > > by default and enabled if required. As it is now, it would still depe=
nd
> > > on the the gnutls library having pkcs11 support and therefore still=
=20
> > > would break our OE builds with mainline u-boot if we don't change our
> > > modules defconfig.
> >=20
> > As far as I understand, gnutls is built by default with pkcs11 support.=
 So for
> > most of the distribution it should be ok. Security by default.
> > I don't have yn strong opinion for this but default enabled has been su=
ggested
> > by the maintainer.
>=20
> We are in the very unfortunate situation in which we are not able to run
> any test at the moment in our CI and automated test infrastructure (not
> in U-Boot, not in OE), and the reason is that we have pcks11 enabled in
> U-Boot, and OE core is not picking up the patch to enable it [1].
>=20
> Any advise to have a way forward?
>=20
> Francesco
>=20
> [1] https://lore.kernel.org/all/20260408130553.819420-1-fra.schnyder@gmai=
l.com/

Hi Francesco,

Which versions of U-Boot and openembedded-core are you trying to build?

Thanks,

--=20
Paul Barker


--=-FSIrMXyddQJwQz8lGCqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaedMWREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0burCAP9PFG0jXI0TZTsUhTbxBA4o8zo+6osso6Fp
/79ugmDR0wEAzJdYGjGASG6SRwW41LU0W+Zf81dGhoz8aqU4WOnmMw8=
=Vg6X
-----END PGP SIGNATURE-----

--=-FSIrMXyddQJwQz8lGCqU--
