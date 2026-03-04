Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E60EF8FEE
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 14:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF47B838BB;
	Wed,  4 Mar 2026 15:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J4tEjoic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118BB839A8; Wed,  4 Mar 2026 15:47:07 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F4383642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 15:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-46392972257so5187906b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772635623; x=1773240423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LoAkV1bFoNL59LzH+dV+SGksmJ/F2yEMnkmm+ILz3Hs=;
 b=J4tEjoicNuFYJ7Gm0RHeiJqjqEI9Uskwz+Xp3utIBJSaJ2LyXhzAd6TXsBPkxQpSoO
 VIAbPOuUYIFNYVz/JIurpGVxRw8KGZOvXCyU3oHuBjw5C5RqphYyoz1A1q2DmChXPZe+
 WudcmAL8qqm5+XldljaqVQw3dV7WLxOyIBpKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635623; x=1773240423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LoAkV1bFoNL59LzH+dV+SGksmJ/F2yEMnkmm+ILz3Hs=;
 b=i/8MWhYVXLokDJIP2NsVLHgZjRo5gQouXmrUSg77dxs0jqRATQOoJObhJxlZz1mcXC
 kLq7LErfvsGjF46rkXpmZLyEI9iNmxpvlrb3Pd9bk40JY/dqwzeOxVF7ZF339kV9WOuy
 WjvE6EWmQxh/hFKLJpmfzKe8culgaEjMpPa4PDdSHSHW+J9JWsNTkpXLcGWGBgAzLXGf
 YRoxugx3eK6MNbRJ4PwA+T6xVxIHV8NsZwD7DyeItQKPPDuwgYndxuPhRXvZB98mq97O
 xbZZPPhrhV7nnyNVk4Kt7T6BRj5Me10xs4WRX2fq417jpXk6BtO1cvhpZmk2baJwKebx
 6Pqg==
X-Gm-Message-State: AOJu0Yz5jvrD5ofiTWTNyXDSCwvonEn9227opLJ3QrYbDvznSt0CKbxF
 vKytRpu5rin0weaaoNQcSNfwwyvOIqUyUCbI/iM3OfaBCB2RsxtTYkaRNbJIbQZ0n3E=
X-Gm-Gg: ATEYQzz9OpWAFMEwVEQKaylJnldnoEMX0TKvvMkieanRT/CNM4qann2BWOXTpAFafAX
 YZp994CLZcK3zRfXDpjXWW4cGOQOdJpG5qmoNicPrZKjnhRc0/MNz2XJQxy25/uRaOJAGaDaptv
 sl3Ek7PlYLrVsz3iYtqZWB+HKUsqwdtpg64ezWwhr32UbZiJiqGIUebtkk0vInsSbJi5XPCO7up
 /PmfpYkCyY1UQOX8jBdkchZi6y3wyj5NQp3pt97Mv2ALHFT5QLGfD0GlSTHo3bNiOd1JE8kVegn
 UaXaIu9iqyhGwrTRD3i+USLoP8M8IHnUtk4zVFgHWD56scSnwE0OijnmrLxzsiQk9ssuXBkmoCF
 2ASuKh9sbFuFSoslJzORoQg11fLrDqld7OXYMKRP47gsVmG5CeWXGKgTUQPUURiq9tyo72q5Sr4
 MPNYvfqLUbZz3hGPmg7akPNJBhuNimRljep72jsgbmSjb/0sRRDsL42AcoFt2vIS4JrTFiQZIw8
 c1zW+XvW7TRThWvekHnzAx5SFYgqwxWjBLbHWiQF705iUjf4+M=
X-Received: by 2002:a05:6808:11ce:b0:45e:ecd9:652e with SMTP id
 5614622812f47-4651ab3a402mr1071425b6e.5.1772635623411; 
 Wed, 04 Mar 2026 06:47:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866557c6sm15820950a34.24.2026.03.04.06.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 06:47:02 -0800 (PST)
Date: Wed, 4 Mar 2026 08:47:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Message-ID: <20260304144701.GV1388590@bill-the-cat>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <aaff4oDKlkINa8H7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VTcO36+thwYB5oFg"
Content-Disposition: inline
In-Reply-To: <aaff4oDKlkINa8H7@pengutronix.de>
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


--VTcO36+thwYB5oFg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 08:31:46AM +0100, Sascha Hauer wrote:
> Hi Tom,
>=20
> On Mon, Mar 02, 2026 at 04:09:37PM -0600, Tom Rini wrote:
> > There is a flaw in how U-Boot verifies and generates signatures for FIT
> > images. To prevent mix and match style attacks, it is recommended to
> > use signed configurations. How this is supposed to work is documented in
> > doc/usage/fit/signature.rst.
> >=20
> > Crucially, the `hashed-nodes` property of the `signature` node contains
> > which nodes of the FIT device tree were hashed as part of the signature
> > and should be verified. However, this property itself is not part of the
> > hash and can therefore be modified by an attacker. Furthermore, the
> > signature only contains the name of each node and not the path in the
> > device tree to the node.
> >=20
> > This patch reworks the code to address this specific oversight.
>=20
> As this breaks compatibility between old U-Boot and new FIT images and
> the other way round it would be good to introduce a version field to FIT
> images. With that at least newer U-Boot versions could print a more
> meaningful error message than just "image verification failed" which
> gives no clue what had actually happened.

It's not the first time we've had a break in backwards compatibility but
previously we had at least printed something about it specifically.

--=20
Tom

--VTcO36+thwYB5oFg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahF5AAKCRAr4qD1Cr/k
CjB4AQDITNyEuzrfmdbRnGkq0yVoAFtD0gXpqkpjN+FciLTiVAEA2oOS4vS805BT
+US7krVlZZ5bSMp+xf4S+qgmcTsd9gs=
=LEMJ
-----END PGP SIGNATURE-----

--VTcO36+thwYB5oFg--
