Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B7EC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D41C86FCE;
	Tue, 26 Dec 2023 16:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gv5pXJpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C1F87910; Tue, 26 Dec 2023 16:51:20 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E1E86FCE
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbd029beef4so4144535276.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703605875; x=1704210675; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8uPflpMmSotZyI2sZKiU8EunhhY8gsVZDbnL009Lq40=;
 b=gv5pXJpdWwRfSQ/ivMFI11Du7OaBXf726kTPQ77B0VZmKKO+mqfTJwEXqT+3PQ54V2
 eAGkmK2kjrDV2eBBl1I2LskDn+aMrj1o9jbqdTHi3Z3vx2e48Qo1atn80k+mht9V6H5o
 N0zKWRDUJ5CjHnvgG/Y2rKG1n0a4t5bVewH1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605875; x=1704210675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uPflpMmSotZyI2sZKiU8EunhhY8gsVZDbnL009Lq40=;
 b=eMTOtH6w/jUAmcnh9yyiFQCuHpvmsXaC1qRaGBhEGPYEoq8Xzw3xOMNB8UQAOHHxLB
 2scYxLEZbVTHuzcIKDhF/THcz2TPpjQJXrNTXAQXLkLipgohNKxDLjQZSxko/XnkBIp+
 HJ9NcRXyQhCInAmoTIv/lL3w7kIj2X4giPjjM9mYbi+fCnYvUos/h90Mr8lrLE5+CiFT
 3ThV7TdtDBp4U1AETdyN7tKBiu36F2NiJZeexAIbiL3lKW5/9TqmvhGspkvbwNaeEZx4
 22t/6F3SWTCi1SnwWgMB4eL/8m2ZbEyxOGRsFZurCa5U5ExMP3zmsWL+6fpE5LcG/BZE
 YARw==
X-Gm-Message-State: AOJu0YwmOiHTjnV0j838zumMDrCtedHpJZPHpvSYSxL3ifyb0Oue3I63
 ZKwdZ3MR2nu8r64M3W2WfxbyOI9LIHgubA==
X-Google-Smtp-Source: AGHT+IH8bRljxQ1PmMPpFkbwEukJkeNUT36/1anj4i/9Dtn2FBvpMhv/6Xtbe71O+FHFMNp5qzA7HQ==
X-Received: by 2002:a05:6902:1782:b0:dbd:d003:3c16 with SMTP id
 ca2-20020a056902178200b00dbdd0033c16mr4325695ybb.9.1703605875470; 
 Tue, 26 Dec 2023 07:51:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d1-20020a258241000000b00d8679407796sm4432992ybn.48.2023.12.26.07.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:51:14 -0800 (PST)
Date: Tue, 26 Dec 2023 10:51:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 vigneshr@ti.com, lukma@denx.de, git@xilinx.com
Subject: Re: [PATCH v9 7/8] config: xea: Enable the SPL_FIT config option
Message-ID: <20231226155113.GN2652760@bill-the-cat>
References: <20231226114453.577589-1-venkatesh.abbarapu@amd.com>
 <20231226114453.577589-8-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xEkqYgeRpif9ZqrS"
Content-Disposition: inline
In-Reply-To: <20231226114453.577589-8-venkatesh.abbarapu@amd.com>
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


--xEkqYgeRpif9ZqrS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 05:14:52PM +0530, Venkatesh Yadav Abbarapu wrote:

> Enable the config SPL_FIT, as getting the below error
> ../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in functi=
on
> `ofnode_get_property':
> /u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
> make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  configs/imx28_xea_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This isn't a problem today and is a side effect of changes you're making
elsewhere in the series. Please figure out what that is, and then work
to rework things so that platforms like this one which don't (and can't
ever) make use of the new functionality don't see much in the way of
growth, thanks.

--=20
Tom

--xEkqYgeRpif9ZqrS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK9nEACgkQFHw5/5Y0
tyxwmwv+OGLkJOswp/nC9xtnQ9ANN/TY2H+BKDfk5buGxD2HNh0lXj7ruxl6TUSf
r735qzK07sbnY1qu3P+XfCcOe0rRzxwTX4CAbABLJM8/wDQipJ3sxgmXtdjBrGUl
BbibMHP+NHIUcKmSo7Y9D/ljpCJQP0PDVSpqrzVhuoOjGhAG55hXPjrj+aEI0SzA
zEQdwjicqaT7Xiq11JTfz1LdlgJYQZDIueCKXsZMgP7H+C/7ZdwD1BWzXqIrlgh5
/FUi2DwqX3yB0HzYott9JqcBQGit3ADUTWxXegRta61UqVvmkN946BBQGp7o66KR
xVarnubmidMILL47NgbJ9j50Kz5uu3ESFTF3E9jDkaXjCQxEu44x3WJ9YcOSL7Nj
p3isiJxdPudWrgzMPcMW8fUdV8QO2ZtalF9M0GizkCpsHLK3LHxeoZg6hPqBujoK
fpSFptsAxzCefije8id4A5IWY/cw4MyXktuBcQxRSmZzdKUm7Oxjdp4GdUYefXXj
QYLO8nu1
=z14R
-----END PGP SIGNATURE-----

--xEkqYgeRpif9ZqrS--
