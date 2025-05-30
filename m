Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C26C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 20:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8083982BBF;
	Fri, 30 May 2025 22:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VW73r+D8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4125D82BBF; Fri, 30 May 2025 22:27:48 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBDC8059D
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 22:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4064ec636a4so1371439b6e.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748636863; x=1749241663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ms/iE/i7KA4vaRyMl4upJfBb/hL8E/MaIo32AWC7/EM=;
 b=VW73r+D8464S2uN/Nt2280u+nwt/ccjDL70G07ygv4ynUjeO4uwLU2TuscyufTz7Is
 fxP52N58T61DeX+Nb+v82K51+grI4H+pyg/K23DEfS1GqgMfB2JrHCXaQLvN5R6JHWpC
 y3RPk3+RoQVAe47VPR4dzIFVQjH9rZ9NxO2ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748636863; x=1749241663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms/iE/i7KA4vaRyMl4upJfBb/hL8E/MaIo32AWC7/EM=;
 b=WpHvRxhw9Mw0zmVx/HbbvPdEb2usRGrsFQddfqJKRL0EdXcYvsGgg+9OW56XCrL7oF
 nOda8pluoeM1tOYs5E47VgvyP2GLwNFFWWJfK3hxuA6sh/o2zmRjsEdCZlRqqdNc93tW
 G6ZiCmTUvrIk11Adg6pT4DqLlv5PNszccVD8oiloUe0M1QcbfsZn4mjJ9N5D98ZgieOa
 OmGUI7oA/+51pPCdotZIF4khrTr3iPBcXTTgKhfgoFCPcjtRHhmcM4ZnkccAnzuqcomG
 9qrDRSgpsm19T3doqr4W2rR8rUGeVx9q5CR4nNnX1ZM0mWJlB9NvnP04Z0Xr3CDeECMP
 vYXw==
X-Gm-Message-State: AOJu0Yx3gaWTPsm78Z52MkxThrWUimyJrNIXaijwTPt8X90I9PRf6vSE
 m01zfAFPyDimpTACctF37P0/4LTMTuV/UC3OCP5RgHLb7W/ndQ+y889AUVv784fKuOU=
X-Gm-Gg: ASbGncvzI282Ihf5MZmgE+pDc0JKSl+hxkfwAuAbJURYLsmXtOmyVCE4dMSBPXWl9SD
 wlWhmkNm+1IK63T87ubrWdhz06IVTdRE3KM/pUf89Vhfa366LzTkrDxCkmPdFKvKLTk8nqYwRa+
 u32N+coHZyklyqyyLTAM2W4M1VV8m08cb0e8JHgmLWvGvBbuC6ehiYmaqQA7TY3E90/kOppSIAZ
 4A89z/Ri/9UrFo9aM4aURF0sRHzcdcWtVhDtoIaRbD9Sj1DpV5gQDSAAZ3foYN6M3Dhjccun2UK
 +SdKmM6daAr5Pyfl9FloSWuEWJ0XCTwEOeukGAM8e/Pg5xs+RYrD4hoMPO70UtUfwmWqxrimxvt
 HX5ysNbkLRydjFSasF3KHXjA=
X-Google-Smtp-Source: AGHT+IFDYydZ6swT8zXGnUVbTIKJXy8lRWAQlblIRki5gVpvdrQh/7LmufLZXbdeaODK4qiudwQmhw==
X-Received: by 2002:a05:6808:45ec:b0:3f6:a9d4:b7e4 with SMTP id
 5614622812f47-406796a0514mr2322600b6e.20.1748636863550; 
 Fri, 30 May 2025 13:27:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c427d2sm500945eaf.4.2025.05.30.13.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 13:27:42 -0700 (PDT)
Date: Fri, 30 May 2025 14:27:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 patrice.chotard@foss.st.com, Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 0/3] Restore support of short name for type UUID
 parameter
Message-ID: <20250530202740.GA4068177@bill-the-cat>
References: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NNTvoToqVKPsylyD"
Content-Disposition: inline
In-Reply-To: <20250523091140.149298-1-patrick.delaunay@foss.st.com>
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


--NNTvoToqVKPsylyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 11:11:37AM +0200, Patrick Delaunay wrote:

> Fix and add documentation/tests for selection by string for known
> partition type GUID introduced by bcb41dcaefac ("uuid: add
> selection by string for known partition type GUID"):
>=20
> - split list_guid for short name (used also for partiton
>   description with type parameter) and full name to display
>   information
>=20
> - as the function are uuid_str_to_bin() / uuid_guid_get_str()
>   are no more under CONFIG_PARTITION_TYPE_GUID,  since commit
>   31ce367cd100 ("lib/uuid.c: change prototype of uuid_guid_get_str()")
>   and commit c1528f324c60 ("lib: compile uuid_guid_get_str if
>   CONFIG_LIB_UUID=3Dy") move the content of array under EFI_PARTITION
>   and linker will remove it is not used it (in SPL)
>=20
> - Add and fix documentation for gpt command
>=20
> - Add test test_gpt_write_part_type to test "type=3D" parameters
>=20
> This first patch solves an issue for the "system" shortcut for ESP,
> removed by commit d54e1004b8b1 ("lib/uuid.c: use unique name
> for PARTITION_SYSTEM_GUID") but used in 2 location (at least):
>=20
> 1- board/samsung/e850-96/e850-96.env:10:
>=20
> partitions=3Dname=3Desp,start=3D512K,size=3D128M,bootable,type=3Dsystem;
> partitions+=3Dname=3Drootfs,size=3D-,bootable,type=3Dlinux
>=20
> 2- arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:1151
>=20
> 			case PART_ESP:
> 				/* EFI System Partition */
> 				type_str =3D "system"
> ....
> 			offset +=3D snprintf(buf + offset,
> 					   buflen - offset,
> 					   ",type=3D%s", type_str);

This leads to failure in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/1151511

--=20
Tom

--NNTvoToqVKPsylyD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg6FLgACgkQFHw5/5Y0
tywNFAwAs2pJFHKj+NteD9rb6bZ7wMmWMdloYrfoJFceOq9TFPrgiM/iw3dsAGDJ
qw1YY8CFYPI9TQNSCPOU85da4Z4WMAN6pTkQIWSaT6dxxBFs+hTopJpSdEJvhxJy
DRjfixlpzA0OYQNwMgd1AtCcyyNOxSrKXSJV6vyhAMP1NM9qahewh/onyPdGMTnf
Hz7N/iQtjXysxKvEhV+AunWrRoZc2fqqUVbt29Fj+/dnsTSkXG16LryT7Ff+Sulo
gVkMsaKycbX9MuIoFy/uv3y6RebLxhRs5wHuoa80Ox9utlKhLRhCMvcEJnSg9YLm
QA/JcUg+oYoW0yjS/dOt2wzeaaSbBt4QCHZbqj8dIBSGhC6JSUnqDDL9bv+T5CrN
bAiTCOUmsFEFVozogYZ/mnS+Bdf9EDUs/ijMXIKjOnxRKPabHCA5i2FD7Brx9UUf
8b0PswlouThzEc4f7VAH0XsEQAzg0frbiBguuU/NINfBi5mW1fTaIJByAR+6DhJi
h1wnAH75
=w7eT
-----END PGP SIGNATURE-----

--NNTvoToqVKPsylyD--
