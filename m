Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857CAC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 18:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C028F875A0;
	Tue,  7 Nov 2023 19:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WVPdJ0kG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A21D8759F; Tue,  7 Nov 2023 19:06:41 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AAD875A8
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66cfd874520so37217976d6.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699380398; x=1699985198; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=URc5jqLW7hI7Nm5kQQVIL5BdtgyVLOeTFFPrpYgAHzU=;
 b=WVPdJ0kGwYNU5ah2rN6W81ZwF12dTtsJ1+XFbXQGTlm3VhsabRbvLRH8wSw3xRsdrG
 lu7ePUZBeFXoEWEhSpor0gdapDgJ4FIR2pCN7uZ2LxV1bjg3lVRhv5y3jZl+HjL2FhBI
 mMYvtG2imVOVtf7QzpqH2Uyjmit6vp++v81TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380398; x=1699985198;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URc5jqLW7hI7Nm5kQQVIL5BdtgyVLOeTFFPrpYgAHzU=;
 b=w05L3jxjcfXytoUx86HcwtHqLa7i7DfiZkoIh907ucYylD3gqhjO/3kuNcVY6XMPUa
 gyiaWe+a8oVkUeOSZ30GHeHneu7578eMaZcmi+SpSeyx4ucnw4vi+kf/GfY5jSWHJoHk
 sh4Ts93uGykx7AawxZ36mtvtZVWWdLbIjrbda51II46MREbrIuPZ2Yz0PakC7qrAk6VQ
 blZr3a1jRzfqa1TnXGOrYToOfEcxsB9Sbrwc3RTy+Q0zoebROGJ/cXJPEV998CAhJyiq
 373X3kpxmBQZQyPjDrP5y0K5MTb10ot59sNDFGgQg1581OSxno849qrNkwPDfQKboUWf
 32ZQ==
X-Gm-Message-State: AOJu0YwCQfaAcfMBP5nbxfuClsIeDHoopLBZQBojBT+4jDdWRdX9gD0X
 CvC2VTa91lIsyWDZqF+C4SxPvA==
X-Google-Smtp-Source: AGHT+IFdt2tWnWLkcTvgIAtjCuuXSyNPjcsahhMLw1QQOhXplvc5BbZBDrlJasn3HIBfUv4Z5mEL/Q==
X-Received: by 2002:ad4:594b:0:b0:66d:3474:a93b with SMTP id
 eo11-20020ad4594b000000b0066d3474a93bmr34968717qvb.59.1699380397780; 
 Tue, 07 Nov 2023 10:06:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a0cc48e000000b0065d0d0c752csm123116qvi.116.2023.11.07.10.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:06:37 -0800 (PST)
Date: Tue, 7 Nov 2023 13:06:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Bryan Brattlof <bb@ti.com>, Gowtham Tammana <g-tammana@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 0/8] Suspend to RAM support for K3 J7200
Message-ID: <20231107180635.GH6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ejf6COfSBXl8Hs5x"
Content-Disposition: inline
In-Reply-To: <20231107161802.855154-1-thomas.richard@bootlin.com>
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


--Ejf6COfSBXl8Hs5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:17:54PM +0100, Thomas Richard wrote:

> This series is the U-Boot part of the work to add the suspend to RAM
> support for the K3 J7200 EVM board.
>=20
> During the boot R5 SPL makes a copy of DM-Firmware in memory.
> Resume detection is done by reading a magic value in a pmic register
> (set by DM-Firmware).
>=20
> If a resume is detected, R5 SPL run the exit retention sequence of the
> DDR. Then it restores TF-A in SRAM (it saved itself to DDR), and load
> DM-Firmware using the copy done during the boot (fit image processing
> is skipped).
>=20
> The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
> reserved memory region (for the kernel point of view) to avoid any
> memory corruption.

I'm glad to see all of this in general. In specific, this work will get
merged once (a) the DTS changes are upstream to the kernel and (b) TI
has/plans on doing further cleanup and re-org of the K3 support code
overall and how J7200 is handled vs J721E vs J784S4. At least the parts
that matter for this series I am hopeful won't take too long, and this
can be rebased on top of that work without being too difficult.

--=20
Tom

--Ejf6COfSBXl8Hs5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKfKsACgkQFHw5/5Y0
tyzPogv/b/BWWndRgmMVfg0myjBBV3syH2wa7fcHje7ASopCkCourOPm/q06heKS
4uds5lXnormZPvld0ZTo8bHxZHt5LEBJuwDKFGyUchXniDm+nm68Z3qFWPLrYWhd
Ex+avfxFBTt0Leal5BqcNOxd2vp4TuQwyL2ojSl8Ayp/oeIwT5Fr7uUAQzkNmXDv
2uwhQWpLKb/3Hp+t3Kc6rHZRggj05ioR9hFbpHax1h3NrF2DhHeNJY7OHY2eXPGV
gm/m72RhJ2OLdaUqgEwGuSjJLuoUluSRJjVYYJUvTUHK3NIrgNgc+eNCTiatK/DY
NO3NqEz4urh+KjxihEIa4sA+/klApQ29fHsPfS669p+vnXea6gn9OBScRTJaSJai
SJMCj+SG32+cJfHy09Bje95nIh4n78suMe76VVV1uq4QT+dI1ocoteRSwauk8TN9
+/D8WM9TfstmLWsVvHRTEJbomOKjeSySaEKGDlrqx0sYLgds82h/6i014Hq8P3RQ
HjG67e29
=n7p5
-----END PGP SIGNATURE-----

--Ejf6COfSBXl8Hs5x--
