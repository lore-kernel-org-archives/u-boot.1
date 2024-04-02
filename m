Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BECD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABD987F1C;
	Tue,  2 Apr 2024 10:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="IIIE6J6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987D887F1C; Tue,  2 Apr 2024 10:11:53 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52F787E1C
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id A23B2528;
 Tue,  2 Apr 2024 10:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1712045510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=VC6dP+ZPZue3zq7SBdmfG2cAtKaNZD6W3AH22sLHlvI=;
 b=IIIE6J6kWdbAOsb4N1zykrRDF/mYCRtJUzRFxuwwaX9ialr5WExaXgVJwVLU/NCgsoR36R
 mlqWePz349IUqCywTPJgbLLgqioBmUMgNm5HXN731ycWNkqt7rICwEKolM/q8t1e2eVP+7
 0faSfiX9Kp0YuDEQXHtjVTaOeLNPsEc2wbdBazD5xDmykc9eWYPaX0G+PnRGGFibdrvxjs
 geSmWkC9SpZ8d4WIy6EyHm/Jxvg/lXMuG8NeFsk08iffxswhYfpchvUJjRpM69yUW9XA2L
 889/ulEabnbQ86sIo6g4QLeG2Ybd+XYu8WeFIiA0yrXjGZTnAlRoomx+hUzSjw==
Content-Type: multipart/signed;
 boundary=29b3154fe2e1ed4d281c02634f04e2c776fdbc9eab49f64c1871cf97c67d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 10:11:48 +0200
Message-Id: <D09HHD0G6HHN.1KMUSO6YCM010@walle.cc>
To: "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>
Subject: Re: [PATCH] net: phy: broadcom: Configure LEDs on BCM54210E
Cc: <u-boot@lists.denx.de>, "Joe Hershberger" <joe.hershberger@ni.com>,
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, "Ramon Fried"
 <rfried.dev@gmail.com>, "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <michael@walle.cc>
X-Mailer: aerc 0.16.0
References: <20240101210820.87486-1-marex@denx.de>
 <20240328150905.GW3442575@bill-the-cat>
In-Reply-To: <20240328150905.GW3442575@bill-the-cat>
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

--29b3154fe2e1ed4d281c02634f04e2c776fdbc9eab49f64c1871cf97c67d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Mar 28, 2024 at 4:09 PM CET, Tom Rini wrote:
> On Mon, Jan 01, 2024 at 10:07:47PM +0100, Marek Vasut wrote:
>
> > Configure LEDs on BCM54210E so they would blink on activity
> > and indicate link speed. Without this the LEDs are always on
> > if cable is plugged in.
> >=20
> > Signed-off-by: Marek Vasut <marex@denx.de>
>
> Applied to u-boot/next, thanks!

Pretty late and I'm not implying this should be reverted. I just
want to point out, that this is really board dependent and might
even break boards which have this PHY and are using its default
configuration for the attached LEDs.

FWIW, linux now have LED PHY DT bindings.

-michael

--29b3154fe2e1ed4d281c02634f04e2c776fdbc9eab49f64c1871cf97c67d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgu9xREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+ML1AX9ne6Aoehvi88Q2I1/7s2UiXTESByBBHj28
kbQZdaP2cJBdYHnuIod1h9a+Id1JdUcBgJ5aXhlMQFzMLXb7J5rzeGqjN8gbFheP
GWKJo8VbcfEsnCn61GZMWjQRmL4Nd73XMg==
=ZAwJ
-----END PGP SIGNATURE-----

--29b3154fe2e1ed4d281c02634f04e2c776fdbc9eab49f64c1871cf97c67d--
