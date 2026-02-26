Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A8FCE09A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BBB83D1A;
	Thu, 26 Feb 2026 15:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ofT9P7Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA67183E63; Thu, 26 Feb 2026 15:47:01 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5EF83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46394090d2fso343149b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772117218; x=1772722018; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ut0tnHzwcsGDXU0H8/BEps4Ni2Nuzlv6OysdlnGcbPI=;
 b=ofT9P7CjFktDBsyzkLCrFYf3huvjN116O4SKWA7w4U0K+51bFc3OaYvI9swBIY3cRE
 cZtwTHpUnOG4/nRrQDuS0oPI5rDMt1Uk0S81Dk06TkQ2DAolUfoWRDg4EJ2VwSwd0ift
 H7tX/eO5I/HXFVDoFKV9YCXYtMTaxb03z6ZyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772117218; x=1772722018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut0tnHzwcsGDXU0H8/BEps4Ni2Nuzlv6OysdlnGcbPI=;
 b=AnM7jJI9N74N843tLgov5S6fB24Clsf6k4HE5Z/a3yT/sJ1+9rmR1WVpkjc/wcvsnG
 vlMZ4RHGx2Ah8sBkIHeFEW+Wk7TcdXTkaYXxAIKPA0VE4PXcEIk/jdNTdjgeMzf6NNId
 Rb3EaaYppWh5GFOS1Xey1B26pltcln2UgaXcdLJ9AEtbgJjPUULjHLW1mlQC7hLW2WYz
 UCVnfCYPBrWSkj2jh3eEoqYuZYhEtp3h300sHigediDPoTaBqDhS+XqXsinMGqwBL/bS
 Ao4jSTSClXN4s1LVcrX4TQ6StvTVvpktGx4hKWtQvwv5HpZLsI7ve6g4hXQS46Di6W+Z
 V5RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN9t9/VFiLa/h8Jse7xR7JO6hL+PsHTTZLJ0hNx4lDa+6U/53UcvNATdKXJHHPOpJfzNnaYmc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx35q3gDtL+5S5gbDhWkMjw+cAFjzX4OcCfcn8BLcUHketvpt0/
 rTbZz6tnlI0PKajeMDMcKMiQkHdpYxZ+37r9p6phZuuPLBU+/O0xE+LkqfIXLEpX2A8=
X-Gm-Gg: ATEYQzyg3dGHXKtWnBqSB/w+DylUaqnxoS+XKmz7wGFVDYK/RN0M3oRe0wb1J0SPVl+
 SANxvtvS1mdq/toA7qvoNXiB0UZhG8ZG8XJPhz3T8OLsFuS6x4ebzJAikdfsTPLz1y1oGYw3iqT
 MdDoNrpbUtJdyzkMae1KHLQlZYWs0fKuHJZ6UsCqd5ZH2egLPpyc/JuPiPsz3oz+KmttsGu2spr
 B/wh5EqgYoIuiV6n0F/P1SrGQJUh24OMzQQoL3wXF2Zqcs5ItznLXrogL2WPP2dsCav/Hoe5s54
 fCKpS7tzGm/U2j9PtJQW2Fo/oRS4UFvBuLS32YxMl0YnhDeDpP9JaQ+bEB5nzzuWsZjP+3LYO34
 k6aKVNhe6vcCfki/U4KmDfgkjUB8n1Rto8XV2hCXC1WEvU5d0iYve94VwRKTo6Rw3vFodpPGXgJ
 JWjaUgHRlmoIZ+f3P6Z+/PqpfX9cKEnYNwVqSIjGuocSRNrpP3dLVFGOtN+mXSt7kx0w7b0Uugt
 7pzXueZE6i93vcjbGtdA7VvgwhxMHMCBAtOg3skXDQRF/V+Ks4=
X-Received: by 2002:a05:6808:1a0a:b0:45e:ab45:d226 with SMTP id
 5614622812f47-4649f05ffc7mr2374230b6e.49.1772117217748; 
 Thu, 26 Feb 2026 06:46:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb3ab302sm6743b6e.7.2026.02.26.06.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:46:57 -0800 (PST)
Date: Thu, 26 Feb 2026 08:46:54 -0600
From: Tom Rini <trini@konsulko.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/6] test: fs_helper: Drop the size_gran argument
Message-ID: <20260226144654.GD1593142@bill-the-cat>
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-4-sjg@chromium.org>
 <20260225171246.GQ1593142@bill-the-cat>
 <2c47184c-7bb9-400c-aca2-0874209adef6@weidmueller.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="92HvDiVbtiivTlrf"
Content-Disposition: inline
In-Reply-To: <2c47184c-7bb9-400c-aca2-0874209adef6@weidmueller.com>
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


--92HvDiVbtiivTlrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 12:59:35PM +0100, Taedcke, Christian wrote:
>=20
>=20
> On 2/25/2026 6:12 PM, Tom Rini wrote:
> > On Wed, Feb 25, 2026 at 09:23:47AM -0700, Simon Glass wrote:
> >=20
> > > From: Simon Glass <simon.glass@canonical.com>
> > >=20
> > > Nothing uses this argument, so make it a constant for now.
> > >=20
> > > Also fix a pylint warning when checking for vfat/exfat.
> > >=20
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> >=20
> > It would be good to ask the author about why they added it and mentioned
> > making 8.5MB filesystem images.
> >=20
>=20
> Thanks for checking with me. Initially i wanted to write tests that create
> filesystem images that are slightly larger and slightly smallerthan the
> minimal size of a fat16 image. But these tests do not exist.
>=20
> So i am ok with Simon's change to remove size_gran argument.

Thanks for confirming. Would you like to give an Acked-by / Reviewed-by?

--=20
Tom

--92HvDiVbtiivTlrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBc3gAKCRAr4qD1Cr/k
CkZUAP0RbGFQzAwLneBiybVKmUNAYWj5dygJle1ok1dqWxqyKgEA2v4KdKu9tV3b
IXrrkTdjYsBjo7yu/mU7/izuu/TvJQk=
=Gn7x
-----END PGP SIGNATURE-----

--92HvDiVbtiivTlrf--
