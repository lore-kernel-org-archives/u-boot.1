Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3801FCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC62F833BF;
	Thu, 11 Sep 2025 19:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gD9Ug11l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DB983390; Thu, 11 Sep 2025 19:23:45 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559E8833BF
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-746d754f656so790402a34.0
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611422; x=1758216222; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdia0bqM9wYVOFVt8gEFYBRoObsbRzTp8iiMy1K4/M8=;
 b=gD9Ug11lxVC6iuYmmPS96lWY9dmVi+yBG5h8lAx/tlkLMq+gbiz9tnI0pdcuz7VATG
 l2Ds6vDwoI/Gm60uXrwhLW0xK0Od4Jjszqn0wZX1dSJlRBKHEqnPj83HC2XxPVSi/XuL
 tr0MpEm+9LHo8emv1mkDrcFSMK9AGzh8z3r1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611422; x=1758216222;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fdia0bqM9wYVOFVt8gEFYBRoObsbRzTp8iiMy1K4/M8=;
 b=Ik6spC5LQ6hMZn4/a/+yrEEkJxv8PjEbmoDWEihVdmoF+ZCUDH0xksY201/yQsT3u6
 6vv5CtWes6XnNBl43luEIdBySyojlSKSH1QAS/oG269VlctO1iCdXvOGqdgEm1fUEkiu
 j/UPLzDAqNGxgfkPcMA0KRUAYJuSLvzzjvh7wckVWZl6z9uvvRE8ihaoQJp68Akkwp21
 q3DNWYezjxHJC36LFoXI0DoY+kcIBrCRzC9JmJyfvlTgUZF7DPves7meCw4jAzCKZWan
 u+188glzB0O/DqHzUO4M3uDUtp9sRVV4d3ht/uKmJSgdiYL3fmvk6CR5qjeJwnAaTaHc
 ZvXw==
X-Gm-Message-State: AOJu0Yx2amEe2Ybqd8J0+rENwhtokmkMshDQQU5raQd6WMCJoopXNzXX
 /xjAiTeqhvurghnZq/dAHIKhC1cQhAei5SOCrTx+nuxPDRV0Mpvywd0datXw0f7z4/s=
X-Gm-Gg: ASbGncvTnP9d+Fn8SS7tzvsU3Ew9JSBr1z7zbmJ430PlIC/fQ8CGkJV1menjKC6KW/z
 DwA3alnHZkj5nc14SkzQpOUQ9+hmaY0KSBT1wv2iNKqaozoUXEV/jUq0YYDT8sRb2BgrZNyH0LS
 d3K2wipR81nG2gMaPdavAjoijg3rtYylcYx3iveGv6mFSD4XNgBrDrQ8LE1CplFIb3MYDj4P+xK
 QJkK3i37BJXSJbP/B8uEX3ICpbFljKDBviHxT+EnXOgD2aIFtuDNpvUYV5hw/5TC3Lf8vjDtJzl
 HicjQKeBd+bGWWN3BEbg1BZL2WG5HWJeMRJitBgGqjMn7M97VqqFEGEfnSy37LT5KYgXZbEr32u
 s+kQhmfFluQmdXeHvYNKY2k6IoYrPlOI0/dSsSVand6SQM2Lfq9ccQSW7
X-Google-Smtp-Source: AGHT+IHImubO6eVT183cS9TYmQunh4Mzhw2CQanDnsaWtmz/CbbQXVhNVMqrD6B60I3uQh0froB6JQ==
X-Received: by 2002:a05:6830:498e:b0:745:6166:bb5b with SMTP id
 46e09a7af769-753551dbd6bmr141207a34.29.1757611421974; 
 Thu, 11 Sep 2025 10:23:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524bd8359esm457521a34.32.2025.09.11.10.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:23:41 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:23:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 04/17] spl: fat: load kernel image before args in
 falcon
Message-ID: <20250911172339.GU124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-5-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ta0eOQv51RyHMK/g"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-5-anshuld@ti.com>
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


--ta0eOQv51RyHMK/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:00PM +0530, Anshul Dalal wrote:

> Currently in falcon mode, the FS and raw mmc boot loads the args file
> first followed by the kernel image whereas others load in the opposite
> order. This inconsistency means falcon boot doesn't behave the same
> across various boot media.
>=20
> For example, in the case where the kernel file is a FIT with the kernel
> image present alongside the dtb and the args file is another DT, which
> DT should be picked? The one form the FIT or the one set by the args
> file? Currently this depends entirely on how the boot media handles
> falcon mode.
>=20
> Therefore, this patch enforces the load order of the kernel image first
> followed by the args file in FAT FS boot. So in the above example, the
> args file would take precedence.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ta0eOQv51RyHMK/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMFmgAKCRAr4qD1Cr/k
CrVOAQDIo2h01b3rQbAXhLf0/ongPckfv4tckO8inP7t19mlNQEA3dk3X8XyWJ/M
vEN3ZIiJwULUp6mkzDtJ/n31zru4sAQ=
=2Xqb
-----END PGP SIGNATURE-----

--ta0eOQv51RyHMK/g--
