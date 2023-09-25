Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A01BCE7A8C
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FEE86C06;
	Mon, 25 Sep 2023 17:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i5R8pkcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E1686C5D; Mon, 25 Sep 2023 17:31:20 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8590786B58
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59c0b9ad491so79417757b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695655877; x=1696260677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fw5YWns8qOhGLE/TOO9pUkzrtbS9805nELezQDb3Pk8=;
 b=i5R8pkcS3QrypSc62iHXAMT1jzaU1d5vrALIg1sKO82pBPt8U3uLK0zGgcnztB+qGV
 qJFdJnRIbqZ/A/kXivXepZxH9C9sqr5EXJxjubrIFF9vColJV21TYxgG/cAPv5jJ1udL
 NZX4+9KVVMxfvZz+d2Opi9QNHUjTt8N5Hi1Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695655877; x=1696260677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw5YWns8qOhGLE/TOO9pUkzrtbS9805nELezQDb3Pk8=;
 b=jpfpkDfqvd+hMZ5/Bmo0hFBxGuvKeU4fz56LMgF6PT7iIW3Ub52cftaCgR5PdYSYzl
 plulUVkc8WM+pp1s2eUeuHlVyhOpLo0mfxELvvSQLalcQ3bP1/q5bDU7j2I/Xj0FiF8J
 mbA+HCZ6YHFE/3A+8PD9a+P0HxDu22dZXGB4QI7zhiMOlqecmlaj0q718JIp8cPCIwid
 kUFiXh3zoGiiP86dfyuGdVGHWuL1ayAdJ8fhVAiSM//eEZs57G8P1KIGebmIZBuWNuV3
 Y662Mu5j/YwUfY9fWVvDLUBf8FbwBG+jzHIpA5XiCx93w5JkzAtpXDQLwSqO+W8d+KyH
 53Ug==
X-Gm-Message-State: AOJu0YxTczMcz1R6UONrR1EXo9YUB9RUBdU5zgoCAk1SFHvk9fOLJ2s4
 tQJ6jvhtJwVUugzGXBJOmznkOQ==
X-Google-Smtp-Source: AGHT+IHV1X2tQOPKHpAMS/xITeiZadC1hV444kA5Mvgh1tt50FnWqGP/qXIYK+cEDj5yiojsOXgygQ==
X-Received: by 2002:a25:a2cb:0:b0:d7a:c0b8:f171 with SMTP id
 c11-20020a25a2cb000000b00d7ac0b8f171mr5956024ybn.37.1695655877262; 
 Mon, 25 Sep 2023 08:31:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 n62-20020a252741000000b00d7360e0b240sm2245226ybn.31.2023.09.25.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 08:31:16 -0700 (PDT)
Date: Mon, 25 Sep 2023 11:31:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-kumar1@ti.com, nm@ti.com, vigneshr@ti.com,
 patrick.delaunay@foss.st.com, sjoerd@collabora.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de, michal.simek@amd.com,
 s-anna@ti.com, dsankouski@gmail.com, kettenis@openbsd.org,
 sumit.garg@linaro.org, sam.shih@mediatek.com
Subject: Re: [PATCH] lmb: remove overlapping region with next range
Message-ID: <20230925153114.GD305624@bill-the-cat>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <20230925152126.GC305624@bill-the-cat>
 <87ttricly9.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d+gehQCzZBTPo54U"
Content-Disposition: inline
In-Reply-To: <87ttricly9.fsf@bloch.sibelius.xs4all.nl>
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


--d+gehQCzZBTPo54U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 05:27:26PM +0200, Mark Kettenis wrote:
> > Date: Mon, 25 Sep 2023 11:21:26 -0400
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Sun, Sep 24, 2023 at 04:48:32PM +0530, Udit Kumar wrote:
> >=20
> > > In case of new memory range to be added is coalesced
> > > with any already added non last lmb region.
> > >=20
> > > And there is possibility that, then region in which new memory
> > > range added is not adjacent to next region. But have some
> > > sections are overlapping.
> > >=20
> > > So along with adjacency check with next lmb region,
> > > check for overlap should be done.
> > >=20
> > > In case overlap  is found, adjust and merge these two lmb
> > > region into one.
> > >=20
> > > Reported-by: Suman Anna <s-anna@ti.com>
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> >=20
> > This is good!  I wonder if this addresses the issue that has caused
> > other platforms to need to set CONFIG_LMB_MAX_REGIONS=3D64 and I'm
> > wondering if any of the other maintainers I've cc'd here can drop back
> > to the default number of regions and then re-test their failure case?
> > Thanks!
>=20
> Hi Tom,
>=20
> For the Apple M1 systems I don't think it makes sense to reduce the
> number of regions.  These systems don't have TPL or SPL, have plenty
> of memory (at least 8GB) and are really fast.  And we anticipate that
> the number of memory regions will only grow in the future.

This partly gets at what I see as part of the problem.  It's been
unclear to me if it's reasonable to just bump the default to 64 for
aarch64 (and riscv?) because the problem is that 16 is truly too small,
or given what we're doing we still don't need a ton of LMB regions as at
the end of the day things should be coalesced in to just a few and it's
been an underlying bug in an area everyone assumed wasn't buggy.

--=20
Tom

--d+gehQCzZBTPo54U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURp8IACgkQFHw5/5Y0
tyylIAv/dLZKZaD0z4JqFc5iVVBUWi7tVBAM+ZWWz3Kmuc3tnV2KHhSxBwdA/l09
tugrPXlc9Zjiy3LCRoGB7FWS/b4blE/jUTdeArfTaGRESGYPt7lAvFKb9Xqs6P1I
xdQG7Hi5E9XPNVd9IpnAbOHh1i4wYN0F/jxs7NFTh59I7HV14dNpWQkg279GnLhL
vFMxvKPLCdD92nf9LSgLIObvcjK6rSvYW6REvu6z+vrGMdeF1RdXn1+Hc8L5qjQX
jD1bZdbrKAzl1sG3xQWp5dMaZ2XGzOMZHrGXkzjksVZzhlefUAGepNAtO8LxsAk1
/lIeaBoxggAFHOtKAlvxYA39SAPC1FRtIY2o2NWP0CRig2ZlYvDsxwOKL9Tm/wlY
qKcYMoh3jUcOiv0Q/TmZv9dFmUTS3CvLbV2PV6C0KxF1YaBSROs3RdkIpIstD00e
b2B1YlmUGUPqIIwDERorpDCcwqcbUdw5WYfjKyy6qqDxNRiYWXfS/rgc33ucmzGk
aHdXu85j
=74wr
-----END PGP SIGNATURE-----

--d+gehQCzZBTPo54U--
