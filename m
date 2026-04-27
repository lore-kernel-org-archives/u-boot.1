Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F374FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A7F8407D;
	Mon, 27 Apr 2026 17:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLdgJRGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8350384106; Mon, 27 Apr 2026 17:55:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6769083BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de44ed7a11so4577476a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777305354; x=1777910154; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FdUVZKkjrI0O7YPoc/HDiI9y35BkegJL7sSOHlzTHYY=;
 b=dLdgJRGgQ/lDz7KpQxJRu07yN1FMYbsPWLLfYVgSAEXxl6mi8DDRe7GMIlrZayIRn7
 MBT0Oq+0Rl4aAQuqbRRyZqaImChT4q1e23C1x3UNTmxCwwXg4gWTi1JpI4ezwuZk2E4N
 1ACGDapmfkgFfsCAjkkQHMF69F5Lp0zMFRq4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777305354; x=1777910154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdUVZKkjrI0O7YPoc/HDiI9y35BkegJL7sSOHlzTHYY=;
 b=g+a4gvELKOygVpB8hGjHrjDv9ltqFXxy7HrA+Rw1/OW8EtwIkgLk9g99ySrr1kBz9X
 EZfltNc4drtSs9Un+qD7KQ3lt26UwEOh5Q64b4uQUCF8qkss0ulZD+iWPWVcwINumE72
 vB7qxTr+x22gyhCEFbkQGUAyr3WehaTSBqjSl1NRk3Q2dskAJlS647T5Hx9GstIkfwzo
 HJ7bGURH29MIM5sq7IFtN93t7UkZ4Z0dLBBGKkJoXMlzk89wRE6Wum9vPWJAEcsJY2EE
 1+hBOFaTdpfUB34cqaojCTpqe2NXI5nqp+hiVDZ8PsQDdIwen59T0eBa+87DA1tEn+kI
 b5BA==
X-Gm-Message-State: AOJu0YzSfgCqTUS/1X53Ohd9cY63dl1stU1XivvAvTzYZ0S/BKeY4n08
 BItL1elXGIPTLzt+nZ9S74Vqxo59zWgvZxXWPEWrcsWNvPvgfpGU15SVtW/rL/UOxnQ=
X-Gm-Gg: AeBDiesUJJBLqmmIfDqb2YvNMHZno+/eqAurihOJFB5iwg9O73A7OSTvpCRyT9n6mxE
 nXZJNbb+Pmt404NJHV7f1xjzPJd+55bthD+076WS3KFdyACo5/UxvCRObVnMXMSy6hxhVXhveiI
 +7wgpvXcHODQp5fRPb6VvoZSwpkxyADHytNgfT+Pt44DOtRDnv637mJT7XsGdnoUEZ8d/aV11t5
 PrnmEnkdmjDP3CqK/MWvQAvOWgUw6hr3kcIFGqXMOWMgY5utniDj181BoNY6yQruoDMT4Q9ppv9
 OGXkpji6BetD6u8SwV6sDqxTkAstGtMC9ju1ScpJMOIzVO9C6yKvBlBlf0msRfs3jduy7K0hqsH
 e3nJK70RS2+1Ov8h+82oTQlbt3RqkO57Qb6cGUoAHvdPWU3QVbcfzTRJecv0EEqwfAbNhZnMedV
 8jltLhgjPe3L2yQ1rG+te14cvNcnm2xx0W0/CK9rDPDX3/r2CgOLgQ4cph5S6TRvQ/IAPQx3UWd
 F0puBhUVTFtwBazPVg3h0hbpKwSHz/XmloCGkKTF2TUfKW3QEGvrXeDCLjaVw==
X-Received: by 2002:a05:6830:3809:b0:7dc:c926:4f87 with SMTP id
 46e09a7af769-7dcc926689bmr20735643a34.16.1777305354150; 
 Mon, 27 Apr 2026 08:55:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dce6a9405asm15253396a34.5.2026.04.27.08.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:55:53 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:55:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH 1/4] qemu: overlay signature nodes
Message-ID: <20260427155551.GH41863@bill-the-cat>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bvqbEg5KPwEANAVG"
Content-Disposition: inline
In-Reply-To: <20260427150409.400914-1-ludwig.nussel@siemens.com>
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


--bvqbEg5KPwEANAVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 05:03:38PM +0200, Ludwig Nussel wrote:

> The keys trusted for FIT signature verification are supposed to be
> embedded in the device tree built into u-boot. When running in Qemu it's
> convenient to use the device tree provided by the VM which doesn't know
> about signatures though. So merge the signature nodes at run time.
>=20
> Needs
>   CONFIG_OF_OMIT_DTB=3Dn
>   CONFIG_OF_LIBFDT_OVERLAY=3Dy
>=20
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

This series seems interesting. Can you please reply with a cover letter
that explains it a bit and perhaps some usage information? Thanks!

--=20
Tom

--bvqbEg5KPwEANAVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCae+HBAAKCRAr4qD1Cr/k
Cl8RAQDpfKo6dXL07aIvHbEug8lpGQf4cefPOik1xuLYTbeRdwEA/+nVwE/i/zaL
+wbfEtaI/im4rhhGpLZEIWnHf5jr7gU=
=fKSr
-----END PGP SIGNATURE-----

--bvqbEg5KPwEANAVG--
