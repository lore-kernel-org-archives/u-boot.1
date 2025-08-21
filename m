Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DF5CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 15:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9363D80B9B;
	Thu, 21 Aug 2025 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VLcd/6WS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A97281D5D; Thu, 21 Aug 2025 17:04:11 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2733380422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 17:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3e66c013e4dso5665455ab.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755788648; x=1756393448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RpnP4/PnmqqS5P+pyCJ2GBGe397Ap8vuLs1Lld4ZNGU=;
 b=VLcd/6WSCO4VCJvGwhYGX87x5oob3mOVg6IC0RKVOUAwayQiV/1m4JCZYLUuqdOCyg
 vLGL8wZwggFMnpzX008dTbn5673jfp6G3yUofeCdARHtF/nYbz5a3xuz90MnqX7pedNW
 eesUBpsacupxirAxgv62iOJgNN5orl4GWiQ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755788648; x=1756393448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpnP4/PnmqqS5P+pyCJ2GBGe397Ap8vuLs1Lld4ZNGU=;
 b=Wc0LBPvqXlsLceGm3iwyvOjJlpfM+ukOf9LimhvXIqClFQSZN+6W0lLix8g9oD68xJ
 s9Iq3ss6/n+a287nE29nwY7RABlLG7H9ntKEpGCX4dcGwBaWRpLtmalk1x7JNEyn8j+s
 jduSo3pvTA6K3GBAwqVarxclCN7PzsueCX8xs+j7VeF3LFWLiYnIg4qQr265TVMW5YG0
 8dUMDfxD+WtI4md9HdxeMiKj5yVEr0GuO1eqvsZG7zDteFCRQgwOxD03kOheKnRW+GeM
 30MA95xzSmdWxAwpnqe0OwCMIgn31JcznD40QkR8B5rUBD5OEBvD2nNUp6+VHmGMk5XN
 VhYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0TG33V8S4XzkFGtXm04cpmqud2O3xdwHsuFRl4Fzk3k+ni4oPhb0jw+7OZ5L/pf2U8zyW4AQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/wWZoRbNPbYw01bYAXZvUHyub50M7J591pnus8XhUKnS6qME5
 OFqD+FbXKHAfY+ZHyWEFsu8pXpxDYub/YCW+FbXZSu6CRbh1V1ISyOpnHnMJwsLR7e0=
X-Gm-Gg: ASbGncsGkBOx8bwYwPcq17MWe4lkkC9rfwLHbZYfOzGhHSgweHliIWhKqefdOpU/Y4b
 nrxDaX8zUjN05xKBMlZPZTcNUsQ/AHlcSsuTN9mUGT5jXIjXtz/jrg2m3IyWHWXeYpyi7J8GRNd
 jKz1V0pKgwEjRR524qZZE+rJ5tyUQTtFAjm+0CWznsQclAs0TU/nyeMBztseGhgGf9AVX7EBZSO
 h4Qz5oAc+xX1llWq/DBIEG+o8QLUtQnmfa0IzVWV/vrvWhevtl58YUoZ3ZXdrua07BJ9J9vyfpG
 2xULJZbq8AkeI4FQQqFiylfyjEz0XjtAo9y+LiH8EfVsXAlTS5+h1V3JYeYFOFQ0397+IID01rR
 2iaC3sp8qUNLvURd5tgnG5d9ZWYOagfutG0VnUqxsVsQv/bsEC7jeUO2V0MkbHqteiu8=
X-Google-Smtp-Source: AGHT+IHeRRs71SpDkBfZxphpb44gGfQU6tPyJNthbJyQqVsZtfFg3G5V9UcIpVgiXwZ67ibRAeSkwA==
X-Received: by 2002:a05:6e02:2604:b0:3e6:6f40:ccfd with SMTP id
 e9e14a558f8ab-3e6d7479749mr43945335ab.5.1755788647249; 
 Thu, 21 Aug 2025 08:04:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e67dbc3939sm23304485ab.12.2025.08.21.08.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:04:06 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:04:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 David Wronek <david@mainlining.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: dts: pxa1908: convert to OF_UPSTREAM
Message-ID: <20250821150404.GL124814@bill-the-cat>
References: <20250816-pxa1908-upstream-v1-1-6bd5ad032021@dujemihanovic.xyz>
 <20250818154339.GY124814@bill-the-cat>
 <12753632.O9o76ZdvQC@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HgVTAJg2oXvW+A9b"
Content-Disposition: inline
In-Reply-To: <12753632.O9o76ZdvQC@radijator>
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


--HgVTAJg2oXvW+A9b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 01:37:40PM +0200, Duje Mihanovi=C4=87 wrote:
> On Monday, 18 August 2025 17:43:39 Central European Summer Time Tom Rini=
=20
> wrote:
> > On Sat, Aug 16, 2025 at 09:35:19PM +0200, Duje Mihanovi=C4=87 wrote:
> > > Convert the PXA1908 platform and its coreprimevelte board to OF_UPSTR=
EAM
> > > and enable the few drivers found in the upstream DTS.
> > >=20
> > > Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
> > > ---
> > > Important note: The PXA1908 DTs were merged into Linux during the v6.=
17
> > > merge window. Thus, it depends on the v6.17-rc1-dts subtree tag being
> > > merged. I'm sending this now just so that any eventual feedback can be
> > > addressed in time for the v6.17 release.
> > > ---
> > >=20
> > >  arch/arm/Kconfig                                   |   1 +
> > >  .../dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi |  20 ++++
> > >  arch/arm/dts/pxa1908-samsung-coreprimevelte.dts    |  74 -----------=
---
> > >  arch/arm/dts/pxa1908.dtsi                          | 106
> > >  --------------------- configs/coreprimevelte_defconfig              =
    =20
> |
> > >    7 +-
> > >  5 files changed, 27 insertions(+), 181 deletions(-)
> >=20
> > Given how far off that is, I would recommend that once v6.17-rc1-dts is
> > tagged you use tools/update-subtree.sh and "pick" the required commits,
> > then say this patch requires those patches applied.
>=20
> I already have used the script. By "pick" do you mean that I take the com=
mit=20
> IDs from the description of the squash commit the script creates?

No, sorry, I mean you literally do
=2E/tools/update-subtree.sh pick dts commit-hash
And then send that patch to the U-Boot mailing list. That will make it
easier to manage resyncs later.

--=20
Tom

--HgVTAJg2oXvW+A9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKc1YwAKCRAr4qD1Cr/k
Cha6AQCQPPB2awJEYdF2qxydVBRq8qQJLNvnz/8Bm1xKalEVxwD8CCJqNe47grPO
fCR2GFHJCShPRhvSLVAOQpwsilT2igk=
=Fydt
-----END PGP SIGNATURE-----

--HgVTAJg2oXvW+A9b--
