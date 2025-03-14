Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18589C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863B481C64;
	Fri, 14 Mar 2025 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g37gY8I9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA8281C67; Fri, 14 Mar 2025 15:27:52 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A2D980F9A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so13551331cf.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741962469; x=1742567269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KbEJ3ymQwEP6ha9Jz7JB3aWK6VG4EV2FaHgtdpN8YZQ=;
 b=g37gY8I9pnb8sYWO37OwHzP79+dUTReDFNvUlOeZGIBOJS7+AfckzS+vU79LLQKrlk
 8ln8peeP0fd9PRYBwJcTwk4EqTrs56V5JAVKj8iFMMEmVJEg1o0ZTUCTQhWsIaVHVwR3
 5NZAqL0AXlml1ZsGW9n6BwSFhORjO6kYnikaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962469; x=1742567269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbEJ3ymQwEP6ha9Jz7JB3aWK6VG4EV2FaHgtdpN8YZQ=;
 b=aucDJmHSGdwnsUO9jdCsue5fs/2KVJaR7/fnrwgRwqNmeavCCqu/DBSam7VuiaIJaW
 PQo4f+54uW5m4cNJpANaFcU1uniVNyVv5EhvbFcU+nZA2IjNKbd7WPazEGqAtgQv7LXI
 yIKXH5PzaedQPaoGSot+HxYqTS55DsB2uLLElFLwXbXk7/yls/ZPuONnbsfetDOX/Y57
 0k3ZIemJw8EcD7BHKAAHG0tPvC6dXra9xqUcWUccEybm6m+nd2H8DWvDIIa0QgUqXWJy
 7x8Nia4umhMrFFuHXQXgUgtmd61lpK/7Jl/i0fEIh0lJFp7hKQV3K9pJFOUUxBVMNrJL
 ICHQ==
X-Gm-Message-State: AOJu0YwfeCbRFV1UReZjancyfK4QARiFOhC+ohQ17CpRb36afgtGU22P
 RiBxKpKPUt/tyQSmdEl9MVpa4puhw5uI0HoMXJbobxWRhnSURk38/7i+Myti8LI=
X-Gm-Gg: ASbGncv+ftqAMHxgVneCxk9O3EcsBCzeBUYVy1USdXiJ+4q3Ww7tz0qroMbVSZrXRwl
 fsgGGOHDMTXrg4k43LeBv53cBa3IMPlTqdWqw03NYk2q0xkv294bxeX0tf1GDocyCqNFngTj5MM
 aeguWXPLZmL0tRV2S2xzxmu0hAmMa2XC+P1paor2y8GMmiZxg2YFLe3oQjiD0W3hm0istvkBizk
 xzJpv8YslMuV10bTAvVWDVpJuwQPSiXYcSVPqzsph2Ct35+RpZSTQ/5W3usqDhLuXvZRyutVkMY
 8SLBWMnnhFDJOHrizDf3fOXCQY77gIbFt02kVg0odUgfHPuml8m0wiFw
X-Google-Smtp-Source: AGHT+IHsI44SPdVJ/tsj0CyypFqj/aUWTJp3+DHpxdgHq75RuB9aohUnqJG/hWLljdmNpSv6XduRqw==
X-Received: by 2002:a05:6214:5284:b0:6e6:6089:4978 with SMTP id
 6a1803df08f44-6eaeaa5d9e6mr33261666d6.24.1741962468829; 
 Fri, 14 Mar 2025 07:27:48 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade3349dbsm24283426d6.75.2025.03.14.07.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:27:48 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:27:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 07/11] fs: exfat: Add U-Boot porting layer
Message-ID: <20250314142744.GM2640854@bill-the-cat>
References: <20250313191348.170054-1-marex@denx.de>
 <20250313191348.170054-8-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="++MpyoAZvWEppUbC"
Content-Disposition: inline
In-Reply-To: <20250313191348.170054-8-marex@denx.de>
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


--++MpyoAZvWEppUbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 08:13:23PM +0100, Marek Vasut wrote:

> Add U-Boot adjustments to the libexfat code and integrate
> the result into U-Boot filesystem layer. This provides full
> read-write exfat support for U-Boot available via generic
> filesystem interface.
>=20
> FS_DIRENT_NAME_LEN is increased to 1024 in case exfat is
> enabled, because EXFAT can use UTF16 names, which do not
> fit into current FS_DIRENT_NAME_LEN. To avoid affecting
> every configuration, increase FS_DIRENT_NAME_LEN only in
> case EXFAT is enabled.
>=20
> Example usage via sandbox, assuming disk.img with one exfat partition:
>=20
> Drive info:
> $ ./u-boot -Tc 'host bind 0 ../disk.img ; host info 0'
> dev       blocks  blksz label           path
>   0       262144    512 0               ../disk.img
>=20
> List files:
> $ ./u-boot -Tc 'host bind 0 ../disk.img ; ls host 0:1 /api'
>       475   Kconfig
>       230   Makefile
>      1873   README
>      ...
> 10 file(s), 0 dir(s)
>=20
> Load and checksum a file:
> $ ./u-boot -Tc 'host bind 0 ../disk.img ; load host 0:1 $loadaddr .config=
 ; \
>                 crc32 $loadaddr $filesize'
> 56724 bytes read in 1 ms (54.1 MiB/s)
> crc32 for 00000000 ... 0000dd93 =3D=3D> b2e847c9
>=20
> $ crc32 .config
> b2e847c9
>=20
> Load .config file to RAM, store the file into FS as /newconfig,
> load the /newconfig into RAM and checksum the file:
> $ ./u-boot -Tc 'host bind 0 ../disk.img ; load host 0:1 $loadaddr .config=
 ; \
> 		save host 0:1 $loadaddr /newconfig $filesize ; \
> 		load host 0:1 0x10000 /newconfig ; \
> 		crc32 0x10000 $filesize'
> 56724 bytes read in 1 ms (54.1 MiB/s)
> 56724 bytes written in 0 ms
> 56724 bytes read in 0 ms
> crc32 for 00010000 ... 0001dd93 =3D=3D> b2e847c9
>=20
> Remove file 3.txt and create new directory /newdir:
> $ ./u-boot -Tc 'host bind 0 ../disk.img ; ls host 0:1 / ; \
>                 rm host 0:1 3.txt ; mkdir host 0:1 /newdir ; \
> 		ls host 0:1 /'
> ...
>         0   1.txt
>         0   2.txt
>         0   3.txt
>         0   4.txt
>         0   5.txt
>=20
> 7 file(s), 4 dir(s)
> ...
>         0   1.txt
>         0   2.txt
>             newdir/
>         0   4.txt
>         0   5.txt
>=20
> 6 file(s), 5 dir(s)
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--++MpyoAZvWEppUbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUPN0ACgkQFHw5/5Y0
tyyGngv/dR3vi90flBT8B19XTBX91jvNaXYEbEt9H/qI37H78BmoZut37OZ1gVAN
JeU44yYXzpID1SltacAvdVq8VAdwvv0qbrXcyoqkROPPF+gEnT90gyK3VvRoDfBh
6Jk5PhT/WSgBSRvfW4HNILjXu27TAm1XpwcB41vAhgDA7i5X/cZjYIiswkgLHEA2
sY6YVrDedDc3kFU+PalQ/QsUQ2Fi1QtRSpPaRrkHZY0aLZLKBLJHEaC0axNEtXiz
t+zRlfBY/4UWOJru4HY7pbm3OwQL9ywdcQcYWwUzIIQWAc5UaFuwCk8cmsqSDl13
NAa+OP6DWXCoQKC4JCdvUsOZk5PzRXKroJpmHMwee7O+Y8ljGE6FIuTsscxU24NA
huDI6F7r453Wp9uBYVH2JeDRkhogrCDBjrMmuZ/MmlMSN85cmC2kpEzB19NT+Do8
xU+Ku29QIiZoG8jkaOoIHX4WrfgiIycR2x/fsjspSrWSxn2eSTCneXW1KQe+U+lA
/jsBf2AV
=dNCo
-----END PGP SIGNATURE-----

--++MpyoAZvWEppUbC--
