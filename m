Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADCDC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C42A87EDD;
	Mon, 11 Mar 2024 16:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cu/Ugtw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7676487E50; Mon, 11 Mar 2024 16:09:17 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F7287DD5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7884124b06aso201867185a.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710169750; x=1710774550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jCz6TMVxo9/3AAZ12r/tdV8FBqXAi5LgkIaU2v6N//M=;
 b=cu/Ugtw97I9hQ5EVFMGCMuKfySau2SdR/GKMibn4H/sw+S+fD1pKF1SwcNqjMs+oxm
 rPPfJbuANIj/xdujPZSnApR+mnHq5DtA/KmtlngP5gbLTFVOpscKkU4yEM5fZl6CIe6O
 e4Q71rXY/k52irs8wc+h9DVGW9GJn6Ubantik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710169750; x=1710774550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCz6TMVxo9/3AAZ12r/tdV8FBqXAi5LgkIaU2v6N//M=;
 b=THGzgOL0+85A6A5tvTyN8q8oR4tdI1VCtIsuACAzKybcYmD+Vav6ZW3qG79tvd8Bhx
 /ucfIn+RvK1kRxT4QnvKDCw/rH3OcHz0IlXiZDLgInhb8eIAzAwVleLAEhO/p/qGkVyB
 d4LO+Jrd8UMsg9+NHzYxoEoB8cJ+zY1jgVfdRAf6ySXat9fBvePuO4Cni2uk1Fq11uq1
 m4+sZ7LOUnqYI0tR9dRYREbxqjhj1hyp/dVDj89zFzk+xmNAiiX56eEj2aPdUBpRFJvl
 5/nH6Y0jxImN81YoYTNvNri55ceZVJchDdDidcZjRGK0Q1HKUTKtTyTWV2+SIQODE6A1
 ycRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm78o3ol2Yz0vYCFAkjd9L/XWqbzGgA0QGnfTSHrkVoZ8k5SdW81RLONLVvLFbD6e8ilaoy05njfoLmIB54bsonONj8Q==
X-Gm-Message-State: AOJu0YxMlXwc3TDUpv3J/SKOy6XILn0Z8Uy7Qcb7sg9o+Zasni6ynICV
 v6zFyVdIgmLbx+V9VXgzRiii92HudxLl+rN8zRbkL/X2I/qOZf0s5OzQpp0ZytE=
X-Google-Smtp-Source: AGHT+IHhIMCQaUozYk7OimtMXql42pFZklnzXAIRWCAwOWWet1Pa9GRUvxyW5vv7gbZ/KBm57Y3UZQ==
X-Received: by 2002:a05:620a:178c:b0:788:1f78:9b3a with SMTP id
 ay12-20020a05620a178c00b007881f789b3amr10858105qkb.58.1710169750500; 
 Mon, 11 Mar 2024 08:09:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 g12-20020ae9e10c000000b00788663d8a1esm1711139qkm.112.2024.03.11.08.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:09:10 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:09:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Love Kumar <love.kumar@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240311150908.GX1523872@bill-the-cat>
References: <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
 <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
 <20240311143938.GV1523872@bill-the-cat>
 <9e3f916a-7e5b-4ec8-abe4-c2cead1df557@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="irgVrjkAPBZiLuxD"
Content-Disposition: inline
In-Reply-To: <9e3f916a-7e5b-4ec8-abe4-c2cead1df557@amd.com>
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


--irgVrjkAPBZiLuxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 03:52:57PM +0100, Michal Simek wrote:
>=20
>=20
> On 3/11/24 15:39, Tom Rini wrote:
> > On Mon, Mar 11, 2024 at 02:40:59PM +0530, Love Kumar wrote:
> > > Hi,
> > >=20
> > > On 11/03/24 2:11 pm, Angelo Dureghello wrote:
> > > > Hi,
> > > >=20
> > > > jfyi,
> > > >=20
> > > > reset support added in qemu
> > > > merged as commit d3c79c3974.
> > > >=20
> > > > Regards,
> > > > angelo
> > > >=20
> > > The other issue was with echo commands:
> > > =3D> echo $modeboot
> > > $modeboot
> > >=20
> > > =3D> echo $?
> > > $?
> > >=20
> > > Does HUSH shell is enabled by default for this?
> >=20
> > It is not, so at least the saveenv test needs to depend on HUSH_PARSER
> > too.
>=20
> Based on logs on this platform echo $? doesn't return any value.
> There is any config for it which is not enabled for this platform.
> Do you know which Kconfig symbol it is?
>=20
> Depending on HUSH is likely big hammer but I was not able to find that ex=
act
> Kconfig symbol just for $?

Well, if we don't have the hush parser we have a much more limited
parser enabled and I bet that's why (I think there's no variable
expansion).

--=20
Tom

--irgVrjkAPBZiLuxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvHpQACgkQFHw5/5Y0
tyw9FAwAm7P0c78Y4waJQfapLY1qWZyhBuTMEcCucWAEBkPCIYcTn9e4OiulnxiB
9/gigIklaqPugAeqGCsbh/AZpQIfOUQrtNc/4Dc8xCU4VtHnYJI3XlrhnH6PshUW
QaLqykgetX5yrJuiXkcYuFR714/547XSMHws286EZD51DNsObrtPofo+NIsYcrVr
daJmsStmyrCWATCYJeDKhRUiY9VeGW/BKFAsEcyVrk4CyeGXCPsfE4+mKpNHjGrX
uibbBzKbunyoZSITzr5RhCP9jhuKhVvVzlC7SsNmtOvTvDkwIUdAsuUwmBYFTKp4
Hfs6VWQ6WeYHKcXz7wCsvdMY3Nl4eJt2DllEbeJB4W9cHnH3zzrpMVg3BTC8LOWn
xyWcoM24alOm7qW5g4hzXzTkBzskc+3E1xX7aKUigqIEQrKTlZiI88tZQsIAQPH5
5FQs+VQsoJO2akmwR4mSyW7j664ktfBF3C7zh6I5yE7RpI819JhUd3BJBaA7FBCM
+RUP+oNr
=L0K0
-----END PGP SIGNATURE-----

--irgVrjkAPBZiLuxD--
