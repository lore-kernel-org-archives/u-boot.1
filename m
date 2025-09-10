Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DD0CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 22:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AAA8323A;
	Thu, 11 Sep 2025 00:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IYlLRn8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BAC83257; Thu, 11 Sep 2025 00:06:23 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11396831D5
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 00:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-61bd4ba9fafso35934eaf.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757541980; x=1758146780; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Xz65ZmN4l4UV7g3okMC3Is7X+odJdUrWyNevEM1QeM=;
 b=IYlLRn8Rr5fIZ8nU4QCf/qoOoqrKX1Io7XwAvkVVeeosrpKPRT5DbVwk8PBdGmFdg/
 KL/isrf818awO8cZfpxDvJQg1Mblv2kMLsS39PKBAeib2vlPdlfHrdiGNMo3+JxEBQGo
 4riG4uK+QkQ0WoG5UJQxNO248mEwByPuREvRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757541980; x=1758146780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Xz65ZmN4l4UV7g3okMC3Is7X+odJdUrWyNevEM1QeM=;
 b=Pe8yRxUuS8TjQSSnDLvXS0BObrZ5+G2jj04TFsc8sM5DTqn1yWHEeqysh3DG1n1od+
 klL0geNrtPDf6EZamm6V3CP6SVRQ7X0HS9kLHdTuIUpU8QLhXlaluTjaoX8K4xnMmX16
 2g7eibYFIQVpXA8J41n4/KkLnBeUCAMdy/1V28rk+RnlGqz87VMfwZ3mZ0EietpOukm2
 CDU2CkmH3Eb3OsX+nGBBpW7cJ10xFvX2FEDY4KdDfXN7GIdsIKnOVYC/B8XP95TO886g
 8PVYB+rydBAmGKi1gvKhu1PbY8i+0rql037OeqNMbttUTAImB5vX4cIegxg93JcQX0Po
 oZAw==
X-Gm-Message-State: AOJu0YxHhWdA1CT3BBevWABCaQ3OS41ImBhF4Rq6jr8c0y8vLUxQsr8/
 tVL6CM84zTDeC5NeGohMob7eJcXbrIM5sWNud6PkbF7VpfQwYShFYcsM+O7mBs+RBqMAMSAtxej
 VfWSRt00=
X-Gm-Gg: ASbGncuq8Y3093oMnCUyc+D84PkvSCm/NyYpUs//Czv/S/lpHa8ZRoCR6+OpoEoIfI5
 q2bLcgld70iSjCjCTa3lJBCFx4qG/pbPncv7pkELyi1maAo5+rDodZz9AW21aBhKk0mVJ0wrO37
 w7B02rxZ4aDLKy3J/O41ma6npTcFD/oqn02dSrXknPCHQ3JVsPbW5QDV9yarzIZfzqY03ldM80B
 7n7Ul09L61ewinDUke05T/r8TRCnI4cF1FvaY0yAeq5Z10JOEUoVPx9XqmUiH5v6NjeWxvpdIle
 ++4hYB++WAXqxNwo67L7vfxX5Yn7vr2PmSl/46USz7Cg2ZJA0FJXyk5sZGUrjH9fjPFVHAzcK4r
 m3qpZ9kLuPZybCsgzgbfkEY5e2KPF3+Ei5H3UtuT3woRBU6j50G4wVKVXsMuxbFEr1ws=
X-Google-Smtp-Source: AGHT+IH3bFXoyGDOyfzyxoNZP5U2IbUTbI4IdfU8Ti2VR4J/XynaaGDVksrGDLiZb5CCM2Cf3qHT7g==
X-Received: by 2002:a05:6820:808:b0:621:aadc:8d28 with SMTP id
 006d021491bc7-621aadc9328mr1581141eaf.4.1757541979718; 
 Wed, 10 Sep 2025 15:06:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b4d32de9sm13389eaf.24.2025.09.10.15.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 15:06:18 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:06:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] doc: ext4fs: update documentation for Ext4 Write
 configuration
Message-ID: <20250910220616.GJ124814@bill-the-cat>
References: <20250910215702.15576-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ZZabTL6yA+rdfIa"
Content-Disposition: inline
In-Reply-To: <20250910215702.15576-1-mibodhi@gmail.com>
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


--9ZZabTL6yA+rdfIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 02:56:03PM -0700, Tony Dinh wrote:

> Update documentation for how to configure Ext4 Write when using large
> partitions.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>=20
>  doc/README.ext4 | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This really needs to be converted to rST first. Maybe
doc/usage/filesystems/ and the associated index files? Thanks.

--=20
Tom

--9ZZabTL6yA+rdfIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMH2UQAKCRAr4qD1Cr/k
ChuVAP9bjOBOp19GmYDhZ+XpJG1Bcz72qz4njDg3FgD/v1cZvAEA+y0KqVvgZJ1W
JOvt3gIUaRLRL92BT832mPlC8BG5ywI=
=jhm4
-----END PGP SIGNATURE-----

--9ZZabTL6yA+rdfIa--
