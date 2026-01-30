Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB56E6BF17
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 14:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223CD8441D;
	Fri, 30 Jan 2026 15:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PPFG6RZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17FF84435; Fri, 30 Jan 2026 15:55:34 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9623384319
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 15:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d19bfe1190so1531667a34.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769784931; x=1770389731; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/36cu2r1NyZA1/hU8MeBElhd0Hgujgwvdllp/ANKtQ=;
 b=PPFG6RZ+eNQHnE1073t4t9Ok4BEJmnwIZKtdwhVsGflEQR6B2z9RTAVup2T8pRxov3
 bsAYDXTRG9FyfJftcoB2demi4SOyiqzMDNYm+9UcRyhv+F/eDQQ3t1hAt1CtP4VKRAzg
 qhPmGsw07oflfRYjUxAk82d0NkSaBzGEMMJp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769784931; x=1770389731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/36cu2r1NyZA1/hU8MeBElhd0Hgujgwvdllp/ANKtQ=;
 b=Ki37e3dvU3ObO3u6JfhhC26qiJaTcw++5LpR3yckzXxuwnkU59xseESQUEfS6dOS2l
 lqb9poqkhn4T3BF/xqQW/sHC1yZP1QHE8OaNKLiyjZjA2XBCvdyOemkYGaY1BhZIFxan
 nJ/kp1aLdSp3I67ysyoIEGPTJXA7ZkNZ/+JARMK3YGvZ2kmxC8aYRXzl+wVG1xwrnDUF
 LaDZRXOO/uje/HE02XQdtSgv0rvQGgoguBKNq4GBjPwY0CU/1aB4A9bNOS3iKKfWd4Gw
 mWr/DOkwyMnhmPF0hMw/ElWntyIb1emcV+xjhuTt9RutGkMSp4jDqrBRbUwX/DpyQJko
 eqXQ==
X-Gm-Message-State: AOJu0YwIA80k5h3ZaEHcoHkS5nMQsi8ikB9BwEXllaOhwwIQ8PSsVBlr
 k6RVD7Xi/NXWH340mUahlAJv2PgIoFbW8AsIRUMPYE1fr2rb05ABwFwnZZrzXW3JjhA=
X-Gm-Gg: AZuq6aKdJ5gtxLSYdXGZuXB3rakw4ba89FzIRqlUJ/wOoUa1+mXxPFWo6fDNxLLK18B
 xj70fZyMnlvmqfR7kpjTjEKhzkYMJeDTZKABbCrVol0fn4jb8uLbn/bzWeyroYc4D58B0thlGge
 aWoVzkPuWfrT8cwhQn/LAzrtHXcefDk+gaMTETMQkdGaFnCrpqi4r7mM55weHLbl5cbsebbJ1rV
 OfKlBUPxKbfeD9k2LWRIoYCnPLAP34BibLaI52PxpE1LZNsWDuQ5EY/IwshbbmVvyobrSQnXvzn
 v6tEc++sPmsRBKpK1uOiUJteqAaCk4Hnx4uRJ+5VgUPvXzepuEaugGexyOD1BuGEvg2i+oIxCIg
 AAykVUTVyHP+BikZHLdo9h6Cc7rz679mEISlcvjN3kWyuGnG2XzpaQdPQFFYp28qi4nMZqEtQdO
 8LGEPa+K9HGTMDdpCSoaMlU5lrnhgNZ/PbKlkQUW355fvcE1Qmwu9Md/B0J/rcZeaQfT3wAQo/l
 ixF1lev479gMXXP4y68Vm3Y9raEzpqNbH+Gh4w=
X-Received: by 2002:a05:6820:1012:b0:663:1399:1412 with SMTP id
 006d021491bc7-66313991619mr477365eaf.9.1769784931238; 
 Fri, 30 Jan 2026 06:55:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a18776sm4948391eaf.12.2026.01.30.06.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 06:55:30 -0800 (PST)
Date: Fri, 30 Jan 2026 08:55:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] Fix unbootable ARMv7 devices
Message-ID: <20260130145528.GA2421612@bill-the-cat>
References: <20260130031217.998002-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m7dV+Qk7Zr7ODzFn"
Content-Disposition: inline
In-Reply-To: <20260130031217.998002-1-briansune@gmail.com>
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


--m7dV+Qk7Zr7ODzFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 11:12:17AM +0800, Brian Sune wrote:

> The linker script u-boot-spl.lds now
> is no longer aligned and -nodtb.bin ending shows
> the zeros are not 8 byte aligned. This result in
> the Makefile.xpl simply think the previous file
> is aligned and do not zero pad. simply fix the
> data align to 8 can ensure the -nodtb.bin is aligned,
> hence, the formation of u-boot-spl.bin properly align.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  arch/arm/cpu/u-boot-spl.lds | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This fixes your problem in that it results in the device tree being
aligned still, but doesn't solve the underlying problem of why there
were 4 extra bytes. Can you please try:

diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index c578c3ebf821..5f807323f856 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -31,16 +31,16 @@ SECTIONS
 		*(.data*)
 	}
=20
-	. =3D ALIGN(4);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	}
-
 	. =3D ALIGN(4);
 	.binman_sym_table : {
 		__binman_sym_start =3D .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end =3D .;
+	}
+
+	. =3D ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. =3D ALIGN(8);
 	}

As the problem ends up being that when both of these are true:
- .binman_sym_table is empty of actual .binman_sym* symbols
- The inner '. =3D ALIGN(8);' increments the linker counter from the
  previous '. =3D ALIGN(4);' (in other words we were not already 8b
  aligned).

The linker sets the type for this section to "NOBITS" which in turn
means that when we later call objcopy to create u-boot-spl-nodtb.bin we
get a mismatch between our expected size and actual size for creating
the -pad.bin file.

--=20
Tom

--m7dV+Qk7Zr7ODzFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXzGXAAKCRAr4qD1Cr/k
CvScAQCGMwHZpmALoNZE2/CIJXKltJqG317dXyhzEyPj8Mz+2AD/aKGKG6pUw+wZ
EefqJKYKOuTAE8n6kkCjHiRbjQh/pgc=
=p+RZ
-----END PGP SIGNATURE-----

--m7dV+Qk7Zr7ODzFn--
