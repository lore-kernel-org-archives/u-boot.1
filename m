Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF21C27C43
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5825B88710;
	Thu, 30 May 2024 15:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qh/Gfu8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD99488705; Thu, 30 May 2024 15:00:05 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E4588703
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 15:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43fdb50fc07so4273691cf.3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717074000; x=1717678800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LilNz2TJh+FBiOOgfTxHf8rOrksbL9cNP4vRzORHj5Q=;
 b=qh/Gfu8T13+Lw3q+Wi2JqOw+EWXKrVkrMtjYatUXoTLNhIVCodg/1y3lFlRmaVhwrX
 oaa/n1TpsGudTFIEVLxdhLZGjaGAjFru1TY/0HW1LD++7Wj3T1H6jXOyzDvw+hKeWPdJ
 XKPULeGfl46QQnyrzZEgwrTDg08avRpbCR2lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717074000; x=1717678800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LilNz2TJh+FBiOOgfTxHf8rOrksbL9cNP4vRzORHj5Q=;
 b=Xdpa8PH2QMw3aWGTvZah2g5i4Z0xLItDrNEfLMJ23eDjLhz1M0pqyTj5NGTLSxh4dy
 NibZRYeFuU1LMQxk8C0ngTeoDdLKhIqlWbL6ibpQt2Np1uNuPnckCPbyRN1Kc8w/nv1d
 41CS+c+mAuDEQqUM97OO3EUInpCPKCiuSJ3Qi3N9nyfgMVKpZax+bJZfGLn6J531TdOj
 tYSLpnTOOTVjQgn+MvZP3dsiIPkvwgz2VHkUmjdYj6sezWmcPGKqKDQSBxCCAzqrfqz7
 Jo+bG3yE3SsTlf9/U1gNzHQMmDN54puyUzRbjPicy49WRCc6t+PKSB8RTw0lhMpFTTCL
 Ncjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTlQq0aOw1ssI487/iEYjokORbYJPR5eoQUDophKDEqAcu/mVtpxDZoGVXQdKEL/Iy5QF6Am8OZfC00WiL0bLBXLK/ug==
X-Gm-Message-State: AOJu0YykvTlwSXIGy3gv7SGW2QZAadCLu53rtYqHpVjQ1JlIb73F5waC
 AqzqJKfsTZL0amp/0IrviuU2MIctvzZnjFqmLLCGHJsgol1Q/g81uOfWuj+YQjs=
X-Google-Smtp-Source: AGHT+IGaCHn5z1qQU2673LxBRTk43IVwMTp5M2ddGludRQPZWRt1zXiSv+IetxO1CZG2K7Sj2BCFvQ==
X-Received: by 2002:a05:622a:551:b0:436:4d7c:8a9b with SMTP id
 d75a77b69052e-43fe930c0damr26197211cf.46.1717074000021; 
 Thu, 30 May 2024 06:00:00 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b15e0sm64957861cf.66.2024.05.30.05.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 05:59:59 -0700 (PDT)
Date: Thu, 30 May 2024 06:59:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/3] .mailmap: redirect Philipp Tomsich Theobroma address
 to Vrull
Message-ID: <20240530125957.GJ3714513@bill-the-cat>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
 <20240524-tsd-to-cherry-v1-1-3002bed55f19@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J0tz8lcDqsVwbJVl"
Content-Disposition: inline
In-Reply-To: <20240524-tsd-to-cherry-v1-1-3002bed55f19@cherry.de>
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


--J0tz8lcDqsVwbJVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 01:46:35PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The Theobroma address bounces as Philipp is not working there anymore,
> so let's update with the one that seems to be working right now.
>=20
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot/master, thanks!

--=20
Tom

--J0tz8lcDqsVwbJVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYeEwACgkQFHw5/5Y0
tyxR5Qv/VsckNnyr7ASztvCghgEdMXYQ3/MKbPgRxmgyEj8Irewo19HQ38bRih3T
EaWX2kiv3/9tEYO4NeMx+j/Ulic1RfSxrzkjO5xOiHJtTTw3i5hLh3oLTMzYKzIz
YRKC0PpOlFqwkW9d2UAnAiljrsOxSIIdkBMjqmqYsY6C2q/io0bQdPudoayPeSUE
bJvDytRsNvUqDgZKDyOXG89AlPwe2T3fuUTw7vtaMu5U2v8l7IAiE2fxSimA7lBY
jx19A5O0p+3s2m4ujZzc+efUNJSVKjy534LRhBe7paG1okgmoan+sgJPGAT1qRoV
++Vws+5+yymdXXzuRd70GzbTQIYtwav2OMz0Ey2t6qcDM7wibOsdXHL+3y1aG2hf
5lICuPI6JlrYf+2cKVH+wafYPQXzYsqrxPPg3J//kyCq+usdpts4Jgqn2QcwS7C2
0mynHkwkyTeIlq9npA7cKK0+lMB2hu4A2JftCfo81nBKr4sqfpWSUTRzXwWtPbIh
T7po2brM
=dm1E
-----END PGP SIGNATURE-----

--J0tz8lcDqsVwbJVl--
