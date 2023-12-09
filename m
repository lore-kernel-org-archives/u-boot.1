Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C4DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268C38761B;
	Sat,  9 Dec 2023 19:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bc1ymF51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5B087632; Sat,  9 Dec 2023 19:39:23 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9888761B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db547d3631fso3390268276.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147160; x=1702751960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6a9roPT01e3yoo76et37bAZKGh2cWuyO8VGyENm8BlE=;
 b=bc1ymF51wJut0kmF0NcOF8RsyMokt0g0aA28+fUDVRA237owRZpSnHwgqlIb/C9YoX
 G6qy0FTee0qfgrbox/vQR+hVseg+ZANHThcqGNPePYJaAYcWQ6ACav0DEoVKoVKr2D7I
 ciPL6XplOVDW8SIfNqg8qaqegT+k2CpmN0Btw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147160; x=1702751960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6a9roPT01e3yoo76et37bAZKGh2cWuyO8VGyENm8BlE=;
 b=d/iYpiF9UitQPVUuiQ0WilokFEaT3XTdwJyd7tIDLCSbBVsCQ8I7rmfGOubsCzb9ue
 wPYMi2fLWs8Feqm91uGvqWCasveOjHxcgDMgAjTR5h3IJpA+RACCtYTLF8kPhAI2OJjP
 HKj9CEUVC5MuM6b5QmRE52e6cEX32IK6Pou5xgRi492MyVv4DBKsrIRjUJzhZY4hjaSi
 o/hYKbOLuRy9jf8wuaEePbIWdZ20kMNtV/bjYGy5MND9+ytDjBSTkgBJlP577sbmtR2v
 d61BOX01BLtRWDtI08TGJJGy2WE4P7yimAI1ERbOiA5bWeUX6FZ+TyaAjFhtPd4Y4763
 8Uew==
X-Gm-Message-State: AOJu0YxQFBvwMrprx1gdsg6gi6nC0Zgt/lmF+Nv9W+REyBKLPN96DCuK
 +VGYRZIS2NqgtCCmIbn40nKDUQ==
X-Google-Smtp-Source: AGHT+IGEoFRxMQ7wUYm2hLqkeuaCJhYjWHlnv0qSTxUf0V7OLsdStAaJpbsbeVWBKHOXL+EEm33T/g==
X-Received: by 2002:a25:b90f:0:b0:db5:3eab:b4ad with SMTP id
 x15-20020a25b90f000000b00db53eabb4admr1346957ybj.12.1702147159859; 
 Sat, 09 Dec 2023 10:39:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a258b02000000b00db40de8de5asm1399591ybl.18.2023.12.09.10.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:39:19 -0800 (PST)
Date: Sat, 9 Dec 2023 13:39:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Eric Nelson <eric@nelint.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 02/14] bootm: Add a Kconfig option for bootm functionality
Message-ID: <20231209183917.GU2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231203173130.2.I826be28024caa3834c47f752d0be1000855dd4fd@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EESI6Uz6IyHMF0LF"
Content-Disposition: inline
In-Reply-To: <20231203173130.2.I826be28024caa3834c47f752d0be1000855dd4fd@changeid>
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


--EESI6Uz6IyHMF0LF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:31:26PM -0700, Simon Glass wrote:

> Create a separate Kconfig option which enables the bootm logic,
> separate from the 'bootm' command. This will eventually allow booting
> without CMDLINE enabled.
>=20
> Update boards which disable CMD_BOOTM to disable BOOTM instead, since
> CMD_BOOTM now depends on BOOTM
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is fine, to start with. But I wonder if it shouldn't be an
unprompted option and select'd by functionality as needed. That might be
clearer to the user going through menus, but we can see better once the
whole picture is available.

--=20
Tom

--EESI6Uz6IyHMF0LF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tFUACgkQFHw5/5Y0
tyzZ7gv+J8kNRKgMXCt20NDwDQJfwMt+31ZgRg38liXTOQbulxdxc9eoW46WMum2
1jYQJ+al1BHRCFeouMlxyf+mx2rYyS1I2WJBJneC65XuiWVEc/ikyQOsbZnPiMbK
qbQEifZyZRVP4EL4GySpISwKZixV+x5krtjWrDInASXIBAgm6I+5NNcDevSsRAmb
t77Vs7nD0m3Hmu8geO7ZUatFXtjT2kcIa7uIDUmzoahiBFoGoQ7RygzauUbOyyOT
zUb7oOxB58P32mnyI2aqrUokVXCJ377z5GO/uZWzZmWvxQUuD+I1BKeED+WBv2R4
hMBpzZQAcvUWeJR0u+yPtM9omFFDpKPYBddpFoAZ7EoN797sFrJolhZrnWdZFPry
xV8ptBvPA7v+oEEv6p4n/H0ZQAXYIcISFEEBJCDrWg1/RwGKsnAdk8dgn7ihAucR
irpBJrzwCgjWJRBd00qaeIeQdzbArU1kIot9qsw/jiSAYfxewxtyBsxDy8U3jyQL
vRiAervn
=6Nfs
-----END PGP SIGNATURE-----

--EESI6Uz6IyHMF0LF--
