Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A5BCDB47D
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE7586DEE;
	Wed, 11 Oct 2023 20:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lrM3gAkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5159D86DC4; Wed, 11 Oct 2023 20:38:04 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C216786CF3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7af52ee31so1851317b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049414; x=1697654214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nyu8WYcQJ4w9595s+NjRgJoQEeeINV2ZPTXl9KXIwVE=;
 b=lrM3gAkbaliiNzLmMAvG9EwgheuoUoc6Dzg7+qelckhctOtArtlRf9OcCJn/6jIpRH
 TJD1dq06P7UVJwY57X2IWGLhGO49RZvU+fgw5BXSbmd6rYMvEzUUTzMKO7CpNkqTi430
 Xv+BcqrtaJcztiPm9+cyX4b+lIP9jR2a5P/xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049414; x=1697654214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyu8WYcQJ4w9595s+NjRgJoQEeeINV2ZPTXl9KXIwVE=;
 b=I3Qj02A/YSF1cT39vwzrFUiFBzgQyS/qUYfBhkb55joJrrUdvrD67DrhBMKmDAYCRp
 4sQtVb2XcyRrc/30qKpl69+twp1BUZhSO/SrgbO98FvXtfYRtcVvsx5IlYpcIdaZCKqn
 2Z9k623yrWWr3tSeg/JBj6Roh6rnaN+C2FTDP1HpajBmHe1DP7FVofybAoB5L+pVXhXU
 M1XhVOF/W8pW4+T9cbaNat9hRpkbJsKOLWapPP+LwBqFZ5IhU9x1HhbE3i1Lz2YK9g1x
 4JGFN7wEjzaNKumiCyOZouYDLQ3ZxTH6TklbQGDwkJ8gEp6mUPkZbve8bbeP+6Vs0nbF
 1LuA==
X-Gm-Message-State: AOJu0Yzq0/cbdQXLbiYKb89TusAwwI7mpSnmZzUlerga3qqZImiN3cjE
 ptI9IibCG3jZA6XRSlJ4A3DxqQ==
X-Google-Smtp-Source: AGHT+IFRcBrrtiY5Wn7S/Bhim2Hn+/9OybpigE2mzhKkgPGsNo0wCvuP8bTH4DdI2I788zw5EicMfw==
X-Received: by 2002:a81:9c02:0:b0:585:ef4e:6d93 with SMTP id
 m2-20020a819c02000000b00585ef4e6d93mr23378631ywa.47.1697049413918; 
 Wed, 11 Oct 2023 11:36:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a814405000000b0059bc980b1eesm1631548ywa.6.2023.10.11.11.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:53 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 1/5] arm: dts: imx8mm-cl-iot-gate: rename overlay sources
 to .dtso
Message-ID: <20231011183651.GM3119521@bill-the-cat>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-2-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mRA8ziOQ4iji9bE2"
Content-Disposition: inline
In-Reply-To: <20230925080909.365098-2-rasmus.villemoes@prevas.dk>
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


--mRA8ziOQ4iji9bE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 10:09:05AM +0200, Rasmus Villemoes wrote:

> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo. No functional change, as we
> currently have rules for producing a foo.dtbo from either foo.dts or
> foo.dtso.
>=20
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Applied to u-boot/master, thanks!

--=20
Tom

--mRA8ziOQ4iji9bE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm60MACgkQFHw5/5Y0
tyzi8AwAhr6Q1Vg+Z2FBrXEwfdFe9C3u5t2WQ6pQh+DU9lR+XFxgWxCRq/L7z3jm
xtdhIXx1QgAdz1bVZEpKpgwU83F8/ntzUTrw5ekgTGbuPz4zMBJoYmZ/f0IOBPIB
WNnzKP6vkGtTHUjStU1TSpbQui6qSJHui02fmZvQEgBJmqoi3tsaqeu9uEQKtTZy
yZVQS+rKHG5YlRqeTOkJDB3BoeQ+pvlFJVnYNIEpbY7uJbE3zC3DW33TgyEbRt82
/5eN72+1IR9aqFNRAv0NkHE5sZMj8iq1s0r/n/3CK29lhVoRc183hrOYLdZt0q1z
22P+bqCYT3fIKlSn2ovPnhSI93m6MagzaNPiaF0XUKeZH3AzX6lzRCF5i2u3+J8a
OGTDOk2IFp0Aju1aYeH0rAMhddJTUJDUmmS7S6jWNcC9NRyLochX5XV1/2+JP3Ga
1TOq1AyB80dTcp3S5yzpWcLr5lvMwqhAijdi54+7m+tkOWJiUYU11PwNisz+zeAk
yyzQlH/K
=uwva
-----END PGP SIGNATURE-----

--mRA8ziOQ4iji9bE2--
