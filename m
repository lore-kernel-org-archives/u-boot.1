Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB756C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87FA876A7;
	Thu, 25 Jan 2024 15:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IaZqZxKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50277876A9; Thu, 25 Jan 2024 15:12:43 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05653865F5
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6818f3cf006so35399976d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706191959; x=1706796759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/+H6+0s9UuLL7FR/lHqyap6YPakx+d6K6M1JOmgOI0=;
 b=IaZqZxKShUGbX0jUa0ySghjsHdRUEIrmuoDZT0y6aeMcSbajyRVUN6LOi6A7LAaP2Y
 VA3rNTPc3v5YCqIOZEDm2V6w6nSZkM7uGDrFQXjUw9JvcXL8rjVEwaUbmgXnP/Q/hqT7
 Upx1Wgl3uFGGe7Ane97mnY2AhT0tfuN0jachM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191959; x=1706796759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/+H6+0s9UuLL7FR/lHqyap6YPakx+d6K6M1JOmgOI0=;
 b=G8nkmeCgJkBi1F/zqZuppjkgXOIeg2yS7wus/T+98k1q8TCMXlJN2w3iTY4mqSx5mx
 GEiq3nXNgrSNv6ZUBWHujifwTCdVH3DePSVurlMhlkhy4LiAVdG2+hZPJfYx/nCPp+mL
 k7mLOSLFsVPhlTcyMFL0PXTwjGvfLvKXPa01bO5XpDeKozuVttDP8cFV8QSxk0aON1HE
 04NS9sn/F7NhglHeTsli+VYagT/IvJTSEgJN9ld2KzGUP47bAPDdJzfj9jeUPlkICWdJ
 2/KuHkizGPhGyGcHTKhq02kbc0jb0xsOxlM5Sx7SgVBY0VlAHucBZCYtP/7doTuLDp/y
 uB3A==
X-Gm-Message-State: AOJu0YwhZYAkt6+MPrQceO8+KDlGBV+UoGI/fhgucRkVG729nLCAI044
 zDM+uZ4hqU0CNsK+V4xwyJede64Xp2TH4OLow+eg3wLupCIKL6ctOBCnPyMgkxU=
X-Google-Smtp-Source: AGHT+IGOMPN9foYbM2AzjWZ9qd1xprtUdNdMbd3FzcWYCAKF6Q4JRX3n1UPa5OgFuSmZydhTKjUF3Q==
X-Received: by 2002:a05:6214:5195:b0:681:7c9d:9eeb with SMTP id
 kl21-20020a056214519500b006817c9d9eebmr1051297qvb.56.1706191959742; 
 Thu, 25 Jan 2024 06:12:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n2-20020a0ce942000000b0067f032cf59bsm5436394qvo.27.2024.01.25.06.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:12:39 -0800 (PST)
Date: Thu, 25 Jan 2024 09:12:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav <clamor95@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
Message-ID: <20240125141236.GI3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IxlxWKwhFW/A6Ll5"
Content-Disposition: inline
In-Reply-To: <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
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


--IxlxWKwhFW/A6Ll5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
>=20
>=20
> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 08:29:54 GMT+02:00=
, Dan Carpenter <dan.carpenter@linaro.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
> >> Currently, if boot with extlinux.conf and do not set the fdt
> >> U-Boot will provide its own device tree. This behavior is
> >> beneficial if the U-Boot device tree is in sync with Linux,
> >> but it totally halts the booting of pre-dtb kernels (3.4 for
> >> example) since it uses ATAGs. To fix this, pass `-` in the
> >> fdt extlinux field as a signal that no tree should be used.
> >
> >Passing - doesn't seem like the most intuitive thing...  Is there a
> >different argument we could use?
> >
>=20
> I agree that `-` is not the most intuitive argument,
> but this is a way to implement a fix with the least
> code posssible. To make this less obscure I have
> adjusted documentation.=20

It's also how historically we do similar things. eg, "bootm
$kernel_addr_r - $fdt_addr_r". My question is can we re-work this,
cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase size
anywhere that doesn't need this legacy case.

--=20
Tom

--IxlxWKwhFW/A6Ll5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWybFEACgkQFHw5/5Y0
tywjxgwAncesERdBd3z5JNK4VJnPhujX7skidoDIg4j8qfUrho9FO/nRh5JWuhxU
37MmARh0zqYtqfd3892otojp+QyB86dO2oGSv5dprqtj5Y66DvI0EdhyIZtxfrre
01rt+WzFsda284n74PP+7GVM8mtuH5zAr/M/k6Vt9By+/fXyv/cLrX7QS4AdV3AW
mdn2uZYgC2ALKCfe4eWKIx7CZ2g4UvfO30tQGnfNE6B8Q9kBUQR2VRgYUPDrJBBx
zQfiV/4yT2mxj0oFDZPXe69WoEBWGwjuygA7M27eADh38oVBU0MWNNo3Rvt6P1WC
QbDYYNfEhLtCUyAGAX9lzIxhle68uH8RdV2R20q0CHXIk2M2Q2+uCrjRH57++V7+
R/PPuvC4TFAUREu+86OlhBosbuNeO/p4D2N0PGJDJ5k9S3sQQN4I+R3C/ISLfLNH
j413W1OwDEUQFfN8jZPha8yHh5dwRDq2eF7DBpI6U132bfD8Cv70v1Y6iiqBi4cj
BRLc4RZR
=t53/
-----END PGP SIGNATURE-----

--IxlxWKwhFW/A6Ll5--
