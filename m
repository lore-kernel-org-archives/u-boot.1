Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B7D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A78183AA0;
	Tue, 20 Jan 2026 15:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hShyF6qY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C66D83B07; Tue, 20 Jan 2026 15:35:00 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7757A83A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd95f77a3so3523108a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919692; x=1769524492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qy2/rKLmxYGfcLkGh7+rstna/5ywXOAUuEE5k2iKRA4=;
 b=hShyF6qY4VlGlh+uvkTNDAnFVq+LLI1U6jsZv994EZ4kHKhN6ZsNTQvgflh5fbov6I
 ZjzuW0y6Z0pe61Z1XRl2bctL7xUcfrObkq+L1cv+mcBL//g7FEjkMl9/fDH/yPhTkmur
 l9l0IMLhJ240akvtBBCTSWNLGkDZa/wrc/zLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919692; x=1769524492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qy2/rKLmxYGfcLkGh7+rstna/5ywXOAUuEE5k2iKRA4=;
 b=rplqYg0LiG9tZtjwtquhSiEwvBe1wERDfNQcr52T75pGX36D04gLBwfMz95B1Ryvfs
 jreQIatqCLriWiAtqfBiZHyAqCrD0SwKotKUPnH3/vn+dsHPw2g8pgO/8CuYfA8CK6U2
 7bmHeleJhA1q17N3NTzWZazO3VAG/tPZGAwmqPKeeRkbUwXkEbraX/LpRisZpMdzKVOF
 skAnyrVmrzjSSvrBEIbBLuP+EDdMQOzdjhxgv+tXLvf+zDbDHVWmHm/+SJn7nFzVROKE
 sB0Oeoexb0E4gB+Erei8xEl+ermu5byGCwQY5yeUrmYqjVP6J/5xBAZkzolFaovsV96x
 g47A==
X-Gm-Message-State: AOJu0YynOMosEnMPPfs+BnZacrf4JK4EJGj/tOuC48zi5F0YEsfls3yB
 vg7tmAPxT9/sZFaKnyQL4mKbRGF3+iE6405xxagAU06Y+OzhEOQyUKgC1R7T+RBb2bg=
X-Gm-Gg: AY/fxX67aD8+5tc7stN1FTsRnrQJqcUKNsX4ZfajpPoBK87p4vFb4avry5SOom6R+1H
 RkntCyQRVsfsdHeKT+i7Z9mZkYT8bYxoBEbeNnQXcT9VKo5SlgmPllNf0AUeyLf5QsKnWRGbusV
 +6f5xGIlI2kHD/7atU7iRKVYyk/BgS17gH4aRD0KjS3yoYoWdP/wzEeU7UJneFO25t94C1DkDHr
 SvjZDzG28iXgczh3T0ViubE9XIcJMPNYJvcNCDiJUfsAufw1C0J+1BGlYUuR2Qg2XeleV3QfZqd
 F9yVfTxWxs7XbKnhT71l/m92f1wpbk5upldSQNblzU7tFwW4XN+siLlB3sJHZLukjXL0mJlrgby
 /qJhgz/y178vXtfqr6puzjL/x7qdSKEeGXvIz3UOIxcGuRqIxvikj3GBLte0SmO9E9DMIvtXChr
 zKCI6lqAghUEZ5Ttk4Tp1YoOLnDaCMwjkf4FN+ssKPgRFnAVz3dBB5yOI3SHvbZN9zytrrtnDW4
 ERUAYSoihB6Y2RD52xVEig6RsdB/4kI/MdmuFbsWn5SGJbDSQ==
X-Received: by 2002:a05:6830:6d41:b0:7c7:266:392d with SMTP id
 46e09a7af769-7cfdff5bd99mr6487439a34.13.1768919692225; 
 Tue, 20 Jan 2026 06:34:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef44sm8689345a34.18.2026.01.20.06.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:34:51 -0800 (PST)
Date: Tue, 20 Jan 2026 08:34:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, eballetb@redhat.com, alexl@redhat.com
Subject: Re: [PATCH 1/5] disk: part_dos: Move header to the main include
 directory
Message-ID: <20260120143449.GH3416603@bill-the-cat>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5JdVvHfaitE5gBvT"
Content-Disposition: inline
In-Reply-To: <20260120133630.1695055-2-javierm@redhat.com>
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


--5JdVvHfaitE5gBvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 02:36:10PM +0100, Javier Martinez Canillas wrote:

> There are two different struct definitions for MBR partition table
> entries: one in part_dos.h and a nearly identical one in part_efi.h.
>=20
> To enable future consolidation of these two structures, move part_dos.h
> to the main include directory. This makes it accessible from other parts
> of the codebase, such as part_efi.h, and is the first step toward removing
> the redundant definition.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5JdVvHfaitE5gBvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+SiQAKCRAr4qD1Cr/k
CjTDAQDUK2l3wboaBNPvrOr3veQbQ6eHXNz0t1Wb+OgxU/9JQgEAzAN/iW411CCY
2iV+j0UTP+f3GaSrAFJFrim6tN018Qc=
=p34l
-----END PGP SIGNATURE-----

--5JdVvHfaitE5gBvT--
