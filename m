Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3943C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 14:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA7987168;
	Thu,  9 Nov 2023 15:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hwoan0IS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD1D48719B; Thu,  9 Nov 2023 15:07:47 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A82F8715C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 15:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41e58a33ec9so5620501cf.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699538860; x=1700143660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F9kuaaovQfheUbm/uhZmLqsNcOFK7+WSSFnDHbRJCC0=;
 b=Hwoan0ISJiLl3UZGOH4bKERu8ibXPu+a8GJbw1YcQp8UDSUMBUpdhBu6vNbVSIYWau
 wCn8WM29MKS/tdG5ABG8BS1da08XFz8z34UEKgVAz7AIAOU7EdMBk0onZYhkZ14/IptS
 Btw7eQC9SM1G/cjldi+nNSMOBOhCBv/T13kEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699538860; x=1700143660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9kuaaovQfheUbm/uhZmLqsNcOFK7+WSSFnDHbRJCC0=;
 b=CKdLv5+qHIhPm99OhZqlnVBqyPpJ6UgYrpwKq4IuWDT6mv0nzXcIIMA6JtK81GGOlI
 WNn9qwm6nvYyKCi5RtFrse9yltuWf8/oUMd+jp+oTALokhl+zPreuJH94TLrYVvnH+pB
 08MMPyHxWB+jwU50BcHao2JjTPbcpS/WWW8XKb2P4r/xPGueD0ENMCkI3cmob2Te/cvz
 xGIjKCnRSbcIWCrqDO6SoUZgZUxx+YPpWViVn78CKMy5ztw9Bst0U0Zkr8Tm4rOTXxhg
 XnxMOqps0n4ej6AXEej4QxEd8DtC70uCx3UII63TqKdyZ4ucoQfcHtaeu9r4BZSQCLz8
 bDBA==
X-Gm-Message-State: AOJu0YyptfZ1QXvl61RMM8lzQ1VwFq4irSwfPWND0shXfpijXZl+x49/
 pBOpIygKv6aLoSZdtNdV8G+fEQ==
X-Google-Smtp-Source: AGHT+IF2DZujxz7mXGc3dIiE9bk3FU/MaWDBtJQi2t7KxY2dY91on3tniQrsI1tqcNBonx5TO8S8GQ==
X-Received: by 2002:a05:622a:11c3:b0:412:191c:ffa with SMTP id
 n3-20020a05622a11c300b00412191c0ffamr7038319qtk.26.1699538860251; 
 Thu, 09 Nov 2023 06:07:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 l6-20020ac84586000000b004198f67acbesm1939523qtn.63.2023.11.09.06.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 06:07:39 -0800 (PST)
Date: Thu, 9 Nov 2023 09:07:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: Re: [PATCH v2 6/8] board: ti: j721e: Add the missing part of exit
 retention for k3-ddrss (J7200)
Message-ID: <20231109140738.GF6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-7-thomas.richard@bootlin.com>
 <20231107181853.GK6601@bill-the-cat>
 <a8ee2c00-4824-4e3f-804c-0472d152a53a@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EHHSfqrJOmJMJ9Qe"
Content-Disposition: inline
In-Reply-To: <a8ee2c00-4824-4e3f-804c-0472d152a53a@bootlin.com>
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


--EHHSfqrJOmJMJ9Qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 11:43:12AM +0100, Thomas Richard wrote:
> On 11/7/23 19:18, Tom Rini wrote:
> > On Tue, Nov 07, 2023 at 05:18:00PM +0100, Thomas Richard wrote:
> >=20
> >> Add the board specific part of the exit retention sequence for k3-ddrss
> >>
> >> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >=20
> > If this ends up being physical board design specific and so someone
> > making a new design for this SoC with a custom board layout entirely
> > needs something else, we should think harder about what's in
> > board_is_resuming() vs what we document the function does. If however,
> > this is generic to the SoC and will be needed, it should be folded in
> > with the previous patch and the commit message expanded, and the
> > documentation part of this series explain clearly what the functions are
> > responsible for.
> >=20
>=20
> Hi Tom,
>=20
> Thanks for all these interesting feedback's.
>=20
> From my point of view, board_is_resuming will work with all j7* SoCs and
> all new designs for these SoCs.
> This function only read and erase a scratchpad register in the PMIC A.
> So it should be ok for all designs which have the PMIC@48.
>=20
> For the function board_k3_ddrss_lpddr4_release_retention, it's a little
> bit more tricky. The sequence is specific to the SOC, but the GPIOs used
> are specific to the board.

I suspect this is going to be the case where a judgement call will have
to be made on theory vs practical on if the GPIOs will be duplicated to
custom designs (it's tricky! TI gave us a working solution, just use
it!) or changed based on other needs. I'll hope that perhaps people know
who to talk with in-private to get some unofficial feedback on such
things.

--=20
Tom

--EHHSfqrJOmJMJ9Qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM56cACgkQFHw5/5Y0
tyzzmwv/dxaHI4bse2CFiQHPDVgweDxb1NOvyjP9c3LKmAeD629O5rAZM+hxVeqR
BjytZQigZ2LFrl0CAOb79xxPldh21k7X7qntXsU6pCdySjhyVTKSY+QrEy/NUwLo
+OUdjLPIXXKIg+uc3zTUWsXYpki5qzBiJMpgSC/ZJs3apOjo94r3NjJUUEM8OxEd
8giB8XMZKmXMzwUC9Xy+Emh5aObRZs6APO7MGBAushFy8HxQihj2aHHWOMvbPDlz
tSgZfBLDU/chKN22XwHldmufJ9lL09MxE22aDkFrub3Rpz+fCsYc+B6vXSrgAlmF
6BLmtgBllUzATc3lUqRYlTtjHgcNDmcHnIBI666ot4YKJheuWXdGOED+ReNv8uu3
VetDav1UyMC00C0/fVmk93ChuMUXNVTWxpVC9KA0u7N6fMGZzBICxrgTg4vl6L5x
BVd0b55PnYKsVcb2e4CaDxn2raF4lcyzHxFA5XHU5SOijlpsMoUr0jN+pz5/0Akc
57MSHbxa
=GQDA
-----END PGP SIGNATURE-----

--EHHSfqrJOmJMJ9Qe--
