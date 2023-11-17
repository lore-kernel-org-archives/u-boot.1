Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B213C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE8D887083;
	Fri, 17 Nov 2023 14:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bZ1aJbs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2238701C; Fri, 17 Nov 2023 14:41:12 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A156874C5
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7789aed0e46so120858185a.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228466; x=1700833266; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0lPkQjOkKb86/YfqTJJQA5BBg5mt2Xtd+QCMEalAXyU=;
 b=bZ1aJbs8sFdcfGM4y3lFWdZXRVwITEy8e4ZVhcyXr3IvYUTD4GvrYJVyQ7BdFz3fZf
 Zynd9lVtW++Cu2W4w15ZPfHV5g8IytwAP2HPgr+RnK9rYAdogWTYVCjfNQAKbWI8KTvB
 XQN35g9xRWk1fWQPAlUrVDyG1ykpOLhEHNm/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228466; x=1700833266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lPkQjOkKb86/YfqTJJQA5BBg5mt2Xtd+QCMEalAXyU=;
 b=X6ZnpDbTzhrIWqWh1dpVYeZ44266vDN/9W6vjpkzPyaoxUT5Er+lE6sKoasUpKq3Zm
 fhR1VRyfeCNL43nF1zHSd2tlTGQsbayv8jWGRlA8FiaAFzcLorYXocTz9wz6b/G4HPry
 E3N8d65VSwmV9QWZxgH20gW+PoMO3wwfyDhUVbvlqg9k7nORyaqLuah+lCxF20ewH4Pe
 vsRsJ9iLeTHpowCUCbgXMOs3v3+pebJ0rIRE2c5y9wIIVmvlTR6qnTpHcVv73/WX5naA
 kN/d8gyyl9hFUAl1Qpp70OBsnHzx6EIcJdyro+PDt4VGmIWJd/zj+fbCn61/E+yhjxee
 /69g==
X-Gm-Message-State: AOJu0YzmE5aOcmAX3QzWlYfopTvd3prtt6DmHfQampOzfsK3IdIbil2S
 qCCL9zMyofuh3ATu74/QIE1bYsNdrJWi1CHEtQp0zQ==
X-Google-Smtp-Source: AGHT+IG1b6uxlAibUcQvCzJlUSEURvgmMkRuo2YHD5NlJR+IPHPgP0jDowDVhawQNCqoFh/kzKtYsA==
X-Received: by 2002:a05:620a:4727:b0:774:2915:d180 with SMTP id
 bs39-20020a05620a472700b007742915d180mr13157105qkb.37.1700228465840; 
 Fri, 17 Nov 2023 05:41:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 vv19-20020a05620a563300b0076ce061f44dsm607658qkn.25.2023.11.17.05.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:05 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:03 -0500
From: Tom Rini <trini@konsulko.com>
To: David Oberhollenzer <goliath@infraroot.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] fs/squashfs: remove unused declarations
Message-ID: <20231117134103.GJ170968@bill-the-cat>
References: <20231106100320.58263-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NIyJhUMx/ChWFm36"
Content-Disposition: inline
In-Reply-To: <20231106100320.58263-1-goliath@infraroot.at>
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


--NIyJhUMx/ChWFm36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 11:03:20AM +0100, David Oberhollenzer wrote:

> This patch removes a number of struct and macro declaration that
> were found through `git-grep` to be unused. Most of those are
> related to compressor options and super block flags.
>=20
> For reading a SquashFS image, we do not need the compressor options
> or the flags. Those only encode settings used for packing the image,
> mksquashfs uses them when appending data to an existing image. The
> kernel implementation does not touch those, and we don't need them
> either.
>=20
> Signed-off-by: David Oberhollenzer <goliath@infraroot.at>

Applied to u-boot/next, thanks!

--=20
Tom

--NIyJhUMx/ChWFm36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbWwACgkQFHw5/5Y0
tywFOQwAil0+94WTy1ePrG6ZyvkIuUG90FvfeEhh+0JbHtxPdH5/RiFb7OUQGECE
HZAHvbuOPyFt3KfTQgmaC71IWNN3vKIXptSlOTh+K6mUQ/O1parvd96B6IIV7wHd
DDoOGlwh9JvG+/Z86zrTkvIrmCUFHp11KLHLW763rIBEQd4/LZ+qvra0WGHYgalc
MwWUqDCM2yu4jmFfp0sVAa4o4nBJmkDxsHcIpWo2233xLdp9OoDFvNvnoKfM6TDc
dgOx8uFpPFcp+YReCE+BOrgTH4dF6ybsbgBOGZfxzaE6JDNudyEhNtyW98YU8F+R
tfryMVC+WcyFAzR0fCg/Waltr8LpTXq9iapPDp0lSE6gva7eelhVCgeM7PBVtsPx
QXSh+bYX5cK7yupeMBBB1R2hZEDS6QKVVMz2A+ggpw3eOJJaRgVGRroLEMQ3lIkq
Nu5XYXpIIZyWxbNZwwiMRpdecju/K7Rwpvf6IPr9fW8pYdVl3TqF0PFgbzc3RSxG
sZNMKB1+
=PPbj
-----END PGP SIGNATURE-----

--NIyJhUMx/ChWFm36--
