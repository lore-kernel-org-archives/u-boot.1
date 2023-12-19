Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A66DC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86ABE8774D;
	Tue, 19 Dec 2023 18:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K446R1HR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A947C86D33; Tue, 19 Dec 2023 18:45:54 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060E18775F
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbd739853easo373480276.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007951; x=1703612751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gHqwJ1HjZ2jkMIgdQW2vjVG+z9PYayBH9ypAzW0U5qA=;
 b=K446R1HRkqS8Nw6OcSFMuPmSbkJ6V2DvdLsO5kLmJ1jPRCNQySnVmPhfMiWvvCQVTP
 yrKEjMAGbLD05jCaJD/ilkfmzxSUPbufX+8Mf23YCvV2vqSMAaTw8XnlZw9yCkO6jcZ7
 vHJ6kozmsc9PbSIjvDeptpLAYU2fPTM8PVRS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007951; x=1703612751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHqwJ1HjZ2jkMIgdQW2vjVG+z9PYayBH9ypAzW0U5qA=;
 b=mUPsjzjR8YDwfMSChBzBd+vaLBbvf8efT05FMM7DKU1o2vop8PGvVL1Tlv0/B4HUhe
 jT4ljWMtO3mlMbGyY4W9QA5FdbuiVa5QfBIPhPzYT5fMpDSegdkNeWi8NwTSDLJoO+Jb
 pk1g8dcB1k/XuXWzkEqKys47sICqLt03YGpughWsYhlQa25uqkHi+MgUi7IaTj0ygK5C
 TPzo/icPZgt0dr6HjaetVGQ5o6KxWsTQOixvYVZdXbKZYpmanqEjUHAw5yPnPwVzFBnv
 /0Z8x3kmk+uVozfriWlpo22nP8QXXOjqHXfXkcDsZOc/vR4Ktl+AIEf3Vm5z9KJaJEMx
 UNGQ==
X-Gm-Message-State: AOJu0YyUuRHpaoOyMIdEoUmBptEcIvjurcRjYpii6hkrYgdw0M9/bqwX
 k5DS4vEzlQBO4PjzY07nlQ92cg==
X-Google-Smtp-Source: AGHT+IGdBh/GlGtMrEBA91BuUKrIZ9gc6JmGJXE49p7vBtOJEvhD4DXq21dKeHtiBeHXwFqxg0zQkQ==
X-Received: by 2002:a25:d34f:0:b0:dbd:987d:2491 with SMTP id
 e76-20020a25d34f000000b00dbd987d2491mr21579ybf.58.1703007950754; 
 Tue, 19 Dec 2023 09:45:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a25200b000000b00d7745e2bb19sm8779083ybg.29.2023.12.19.09.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:45:49 -0800 (PST)
Date: Tue, 19 Dec 2023 12:45:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, nm@ti.com
Subject: Re: [PATCH v3 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20231219174547.GY2513409@bill-the-cat>
References: <20231208153311.2422720-1-w.egorov@phytec.de>
 <20231208153311.2422720-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aoQ7gayljrMj/PC9"
Content-Disposition: inline
In-Reply-To: <20231208153311.2422720-2-w.egorov@phytec.de>
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


--aoQ7gayljrMj/PC9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 04:33:10PM +0100, Wadim Egorov wrote:

> Add basic support for PHYTEC phyCORE-AM62x SoM.
>=20
> Supported features:
>   - 2GB DDR4 RAM
>   - eMMC Flash
>   - OSPI NOR Flash
>   - external uSD
>   - Ethernet
>   - debug UART
>=20
> Product page SoM: https://www.phytec.com/product/phycore-am62x
>=20
> Device trees were taken from Linux v6.7-rc3.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Please rebase this on current -next as phycore_am62x_r5 fails to build
due to yaml schema moving around, thanks.

--=20
Tom

--aoQ7gayljrMj/PC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1ssACgkQFHw5/5Y0
tyyOAQv/fskxxBPnlUoeNRA9fFEmb6wx+qyEq/iD1wsQUvdHmc2xQKTxJn4H9FcZ
McsYwOpmrWxpC9JW8tCNw5L229D0TZZ7WEMGXBAExMxSlI/46+FPZ9cCbP6CJ9vM
q/StgdNae3Wvm5Ix3Bt78oVlhYnHQkYWusrGoERjGxcau/UnJXluSrmpQ6wjq2n4
19AEOiWUV/+tl+/X6dwCsADHeDamNKUoXFMRg+bpLlhyHirrCOjY67lhEl3w/Etq
Ory8EJmzvWFT4w5xy4uznX0fWwM6nRhOaBWJ9V/czX+2+FuZiU0LuAEuDAu/cNhv
tE4yggxrUjbKj8ZnBu6FuvZ5SZfk52H/Ol0OiXiVCuWO/vjM7ZHWs0JMV5dBMMub
PyTYivK96gphq1kE+VBgYQ4P5jGIFSfxecAAYhPpEE7DvvYEH6tKY+yqmEjg0VFK
9ZebeQdJFLo5k0n0QXm3e7WfhOpxyBZ+EVrn+4mkaFFTl6LcCWBg2hWCUDg+5p5n
s8OCYtTq
=ykkH
-----END PGP SIGNATURE-----

--aoQ7gayljrMj/PC9--
