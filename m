Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BD105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5F48430F;
	Fri, 13 Mar 2026 15:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t6nzcUuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A4A84319; Fri, 13 Mar 2026 15:57:12 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5D384307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d743ba241aso1236049a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773413828; x=1774018628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qOk3Lo8OjUxCTI/li4NlRKgpOEsVd7CxR7fYZXSrg5w=;
 b=t6nzcUuQF0W9USwF5vdNrz8pRS7qHmC0fle52APf6y8uDJbKp4zf6R4zntx9a0Kmqh
 Urv106B9ZvZXRuto7cOwPJHqkM578lhftf+gbGx1Y+0NFG98NflILq5K1NKJ54jwbZ+U
 1CCw7eBej5EVxIKvf3d2lW4dd/1Kzq46aYXfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413828; x=1774018628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOk3Lo8OjUxCTI/li4NlRKgpOEsVd7CxR7fYZXSrg5w=;
 b=HCqHIdU13m+yTXyojbSL2JtcC7H+aSN8XBs/AjMtDKNfab6RQIoEvkAbsO4gav33qS
 L1e3l1nc00ypk12GYfIaBIC8ktUTFaRZmFoIYcFmvtw2O9n9ynoOvpijo8GhnKo/FCoW
 XekcpwptPMFjCoZ29xMbM58S6IG4kmv/ILe1V2CW66l/1hOOoCcNuurK464Vhy/45oIH
 02OgCLUXruErWzyvtiNcr8HxIArXFVp+z2RTyIIlCwCFYuqAl3GLC2ScDq4Q0kbR5gnY
 86r5OEdJ6mxmDMTpa2AxV3kK0ob94PNYls7Q6lc2KoaaQqKf+Jw1I5Y3s0oGlmlUeVbt
 ljeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm/VEMaCEMaWxGW1ziMfWCdyhKWfUBJRwLiKdfsMX6Pe6CvJBrcIuWOxhhiDOO5YdlFy50kK4=@lists.denx.de
X-Gm-Message-State: AOJu0YyLRR3pV5efGgqo0o9p/3xeecLktNbCmHUhFv2sOnhrgY7pL6oU
 iEQBUzrF89OJHnUFFUHF9sJNwXiBZduJ4E04iIOLTRpHgw23lOhYzTxPUAcFKEBCbqw=
X-Gm-Gg: ATEYQzyBJcGcbde32AMbY1CUD9U/EL0pPRwymh5/me2zAKFEkb5BEedgkTHdJsDv/sv
 RKieIjh5X5eWC/SIL5vgxb3X9PEnXSWS0d2kKM7Z+/ixlR8JTIn9J6azbEcIUqZBGQS5VrMgr4A
 I8B9HWWGr24QEgPtwzGphaBZwsIsapZBz8pIfu7idetoORXwet61yphBNJZfJwb9Ldx5WMoYG3V
 536fsC/ZtLused4wVY5NN239/+zYnLwF16iLW6GMRUoWdTRXE/qja/zk2pVyrZ/VE/1LukYKLCf
 D49wfVoCH+1aAtqddicKOuFRImTaoLo0nYYwVsI0143pcQj63JXT2VkSp0/UsBi/x66XT/HKknf
 bak5yt/GdmgeZDZznpU2yrS4hb9aoiVD89bm4uLUd/yxrHZ/+GM3G1ORZWTIFfZprMaKdoiX2nD
 v/OtRJwsKxOCc41ysv7To2lQv7ooCdpjdGXuy3PSN6Eh7XjCPn+rxtB94J2b7dCRpCYjsHk+pw7
 7TbRSE3S2xfzLdESsVcqKm6zIHfa+prHZCbFUzvsXN0xd+d
X-Received: by 2002:a05:6830:4c07:b0:7d7:54d5:c6f8 with SMTP id
 46e09a7af769-7d78250c8cemr2384241a34.17.1773413828099; 
 Fri, 13 Mar 2026 07:57:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8975csm6407834a34.8.2026.03.13.07.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:57:07 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:57:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: bb@ti.com, reatmon@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 gehariprasath@ti.com, s-k6@ti.com
Subject: Re: [RESEND PATCH v2 0/2] k3_*: Add config fragments for inline ECC
 and BIST
Message-ID: <20260313145705.GE502704@bill-the-cat>
References: <20260226122508.2269682-1-n-francis@ti.com>
 <6a62fbd9-2a0f-4783-8529-1e42c6ec496d@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jFW3qt9RcNYCF/VW"
Content-Disposition: inline
In-Reply-To: <6a62fbd9-2a0f-4783-8529-1e42c6ec496d@ti.com>
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


--jFW3qt9RcNYCF/VW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 02:08:19PM +0530, Neha Malcom Francis wrote:
> Hi Tom
>=20
> On 26/02/26 17:55, Neha Malcom Francis wrote:
> > Typically we do not enable these configs by default but would still lik=
e to
> > have the option to start building them in our default build flow for
> > testing. Also there is the added advantage of users being able to see w=
hat
> > is needed in case they choose to enable these features.
> >=20
> > Changes since v1:
> > https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.co=
m/
> > - move fragments to board/ti/common (Tom)
> > - add doc patch (Tom)
> >=20
> > Neha Malcom Francis (2):
> >   configs: k3_*: Add config fragments for enabling inline ECC and/or
> >     BIST
> >   doc: board: ti: Add support for config fragment builds
> >=20
> >  board/ti/common/k3_bist.config       |  1 +
> >  board/ti/common/k3_inline_ecc.config |  1 +
> >  doc/board/ti/k3.rst                  | 66 ++++++++++++++++++++++++++++
> >  3 files changed, 68 insertions(+)
> >  create mode 100644 board/ti/common/k3_bist.config
> >  create mode 100644 board/ti/common/k3_inline_ecc.config
> >=20
>=20
> Any rework or so needed on this or is it good to go?

I'll pick this up for next soon, thanks.

--=20
Tom

--jFW3qt9RcNYCF/VW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabQlwAAKCRAr4qD1Cr/k
Cjr8AQDl2zOy22BKIn4pI5MObDfsEryUdVsa0+MliE6ckHX65AD/bGXQ27CA9SCp
cLJXCbMihcd48i3xz54LZEvpaSK7ig0=
=76Yh
-----END PGP SIGNATURE-----

--jFW3qt9RcNYCF/VW--
