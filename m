Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A60C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 15:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14712836A9;
	Fri, 18 Jul 2025 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dYBeUFLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659D783623; Fri, 18 Jul 2025 17:01:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3C6836A9
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 17:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73e5792cb9dso679719a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752850885; x=1753455685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O1r0oM4YqFcvuddg/x0mj4sQc/JKIxUTEuV9hePaz8E=;
 b=dYBeUFLoG0StECIDtbbMlNb1QHwEjOMeb5X+hr6T4RRxuvTR56hC/iK4jmq93Kg10P
 5ONQYjK9Wg6ypJ5YKrjT1ogQE89K6MG4Xu1PPuMU/1rqSgLlbGVu1ZSo3ag14Ko9RwR4
 JmFGnds1Hx5ZuwJqIqwLnZi8UHYz21Jhbbeig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752850885; x=1753455685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1r0oM4YqFcvuddg/x0mj4sQc/JKIxUTEuV9hePaz8E=;
 b=G+1z7O3w9iwL2jRyWkoM0bm7Um/T/RHF6ltnAdt6eU/8XAoCOvTA6/1hQt6MvWl6o4
 iDzfxnnoiDtk7KxnoxKDyriTzgvfi6Uq+AzR5PcVf4dKQ1LxqJI6oCYIqDKlCbc3MOuX
 BDz71q5v2jCOaoMF9dTYyMO2WTWRRE2jPeHu++AiYNZ7RNMTdA9/VmaR4yS8bMS+G9Sx
 WPsjzKhO/deITIl2nxSoXaXO/llBNaqdVCLqECsUE9erZy0TRrEgi1ZR3JA6ZfAEIU1v
 kOhBq/yFRLctL0s4osnGYCuN7EQxsTaWwgOTL8Nwro83OsV3zZXvd5p1m/DEmS/tv/PD
 9Pkg==
X-Gm-Message-State: AOJu0YwJKhwtYuw2ZvYib/vCgeM54DT/F+p+HFDnEa+AN4avHlts+UE3
 b06xXIVF/khIFcuJS8x/DjIP7KfsDohM++XRmwqZE/LS2SA09UtauH+A2xfkc/WaHyKcey0Fsxm
 jomucZRE=
X-Gm-Gg: ASbGnctvqRFD9rHJD0qcTo2tcn76fqAK9GSHcKADPbJJs2FuYtRYMHTN44+TXW8gaAp
 psvCzQGJ6qNs+3SbDC6c4ogAo+EHhfjjUwX6Y0W6v4TOwnxmfg6qVA170lfF++o3a+QH/eopF0a
 V8jn0RtVAwLSSNCMJTAtW3Bave+t/weopxKUQ9PWcfbIEtXbO+4uLIew/nZNYPiEXZZHcyY67vq
 h1VmimsjXLm43psgUSYKSgNyLCfmTj5o4ns6B5Kvph2Lp1nUoHxthwlEVHaGX+3BxWumQK1a9DG
 JzM2hXVptrgQsca93CGXf6p2aznpq0BgUvM3JqeSgj9thi4tHHjW3rmY97bt2ilXhIE8zJig8Er
 xSUJdzwAkf6gSTq7/JUpCax+kgI42TDJzYAOiyBM5QiVUJdevXt2kAWuF
X-Google-Smtp-Source: AGHT+IEGzykJnJK0y1UQcuGmnQ5nZ9YDT64SZ2Va72tZKN9t3M1Ql/OO73F3qecR8l6oyuVKrODtCw==
X-Received: by 2002:a05:6830:630d:b0:72b:9b1f:2e33 with SMTP id
 46e09a7af769-73e64a80b44mr8946438a34.18.1752850884034; 
 Fri, 18 Jul 2025 08:01:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83bca6b5sm650233a34.59.2025.07.18.08.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 08:01:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:01:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] .gitignore: don't ignore .gitattributes files
Message-ID: <20250718150121.GV193579@bill-the-cat>
References: <20250718085634.13542-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v1UtnEt7ZfDhpam3"
Content-Disposition: inline
In-Reply-To: <20250718085634.13542-1-ravi@prevas.dk>
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


--v1UtnEt7ZfDhpam3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:56:34AM +0200, Rasmus Villemoes wrote:

> In a private fork, it's not unreasonable to commit various binary
> files associated to one's project, and thus put a suitable
> .gitattributes file next to it to force git to treat that file as
> binary. In my case, I have a .xslx spreadsheet used for computing
> suitable RAM timing tables, which I wanted to put in
> board/<vendor>/<project>. Git duly warned me that it would do LF/CRLF
> mangling, so I also added a .gitattributes file next to it with
>=20
>   *.xlsx binary
>=20
> but upon adding that file, git told me that I'd have to use -f because
> it's a dot-file that is by default ignored.
>=20
> Add .gitattributes to the list of dot-files that should not be
> ignored.
>=20
> While in here, sort the list and update the comment, as there are also
> files which git itself does not make use of in the list, cf. linux
> commit f46e65da48b2 (".gitignore: exclude .get_maintainer.ignore and
> .gitattributes").
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--v1UtnEt7ZfDhpam3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh6YcEACgkQFHw5/5Y0
tyz9OQv/bUOpeFJNamRxhmZpvJN9kSsisE8YB+djY680zHHnKRT0kQTyubBqrEen
JB23sZv8Ny9fALb2Hd3FsQLoRED9pMXDRWLeYYYnVmro6tJiFduRfdN9Rdh4tAQS
rh7lt2ifvZQpAWShhRBGYiNrzN2eYKTZ3kTFNFEqALBDPGmpZbhwWqHHVppztWy7
bAIeksAa87DgQwzoTuvCUieFj8zTMciHEjwR331cze5Mu8MAKVtp8I3lVkbT93bp
OEIfjMDrpvQVpkZUicAEXBbHHxEoE5LxgyFlnBi7fAR2eoPIfdGVnk2fK7bUYAwG
W9K2rwl1nvjqOSNHQGKENVQlwcB5cGbQL2eleVfoAtr46gHa1d35MPSCUt66rDcZ
cCjTNuZrULv92QyJpAB8+KcyOFN9jXEGWFbM0uNQTB9RpJttZFHL0Nia7Av9ExWE
nlD5MfuB5SC6ikdFEunfc4L08gWD3HabYxJFNobmZ6jw8VMlybMol3K3XE8OBljX
CkT9/c9H
=BkeN
-----END PGP SIGNATURE-----

--v1UtnEt7ZfDhpam3--
