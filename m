Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CED9D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03C983A8F;
	Tue, 20 Jan 2026 15:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lR9ugmJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C4D83A8F; Tue, 20 Jan 2026 15:37:06 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 770B783A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40444c41a70so2714440fac.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919823; x=1769524623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TL5q7kaZFfkVi1AVKUWUHRHlgMtDhedylaskwE41hB8=;
 b=lR9ugmJvFm36J3PFCjQrmpa2bO7BdNkpuwXOA4LwJRv3mIi2UOZJ806cSm7bFxIBNM
 CHYwG0a9j4bl1AV3yRd/3f7kEP3chmINV9K4zqoEAwdhH1EfYIvKUzeuYQM80fJEnD0F
 +moA+fRhckrMljgBWfal7aG96jooEo21IO7+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919823; x=1769524623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TL5q7kaZFfkVi1AVKUWUHRHlgMtDhedylaskwE41hB8=;
 b=ave5JiFNB8JEp79ICDtw3pRMSV1McBVuIUY1aQ8eqEJCnj6TLHweolE+fSO9h5PHFw
 RsUNEA1HtDcp73X9vTvUHT6/Wm+VxcxRR2MhFLk5z4KgQL3c20DNAkce0N6/rwwDKvPX
 wAkEvtGDVpcM/0G3ZDenDeGHw868caKvtChFlhzMFHL0bdVR5IgZH4QheNNaoIfTuEUE
 1j4BOXRYBDDTvX5IK2sKtiiy3K0JGvSQ78bYxYb4El4VO+sHe9nPrj5+Z4S7TiUoIbZ/
 /rzwc3F09HpSCxOIlmuWI8pWfitYEQ4nqzSFzM3wtqnPmW4aWWaok/RrBmGCeD0Y2iXB
 gf1w==
X-Gm-Message-State: AOJu0Yyt8bzJiYES7J66HAKomDtl9+PayHX4T5PejRrN6u1WWPBk/xWi
 vzIPKe/mdFDJd5gSL0p+x9BCD6Aq85JMNA1KdAMwfhnMSuaY/FhMM1Fm2j8vLB4y23U=
X-Gm-Gg: AY/fxX4QHP+iJWKjOIuZHNE9ijkQ3X1BXRw4PS2hflromdcgVjEwnHISpd47JQQJVyu
 TFGiguk2Yy/WZ0if0Xym6nCcvPdGyY49H25fPuY5t7yPIMYjBDXhjNzhSXV4+VIF95eAckSn6UR
 8wptSQ831BIc2PmoY6pHj9a4l01WXdaXdxD56Cq88zEhFfWSpvHHnqXv4KSXCv3tK7QVnR7yr3/
 0ug2w7xKncTccXSPuCom7KX3o2Wp/Tj7l/uBuwHCIx1IDq6DqfguSrET0EvdDPWdRN/BigGKt1j
 78Tq8CeunXxFq3VXaBtMHAffCjbvkQSHjZp0hshVxrCdvuYbkm4aDvS85iEe9f6/1l3dpDIkmQi
 7sdcjs2lrRy2t0A8stKk0pq+OrrSbj95Tm4vOLwGmCXVszX6SCaD5DJOjD5tkDtLCrfdexDEp8c
 /5AdAr5mU5CjmeQSGGnePwdqkYwDZYhFGbRFZeas+/wQIpLnH0/RwCQuBSr4Al2KT2m5nAMuZwu
 a19a4z2AcxbhV3vAR8AETKULxmkVLN45hZ4Rzc=
X-Received: by 2002:a05:6820:4889:b0:65f:6733:765f with SMTP id
 006d021491bc7-6611796cfe8mr4713331eaf.27.1768919822953; 
 Tue, 20 Jan 2026 06:37:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf52f3sm8682794fac.2.2026.01.20.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:37:02 -0800 (PST)
Date: Tue, 20 Jan 2026 08:37:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, eballetb@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/5] disk: part_efi: Remove redundant struct partition
 definition
Message-ID: <20260120143700.GJ3416603@bill-the-cat>
References: <20260120133630.1695055-1-javierm@redhat.com>
 <20260120133630.1695055-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7Rek2omVmpPCjyN"
Content-Disposition: inline
In-Reply-To: <20260120133630.1695055-4-javierm@redhat.com>
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


--I7Rek2omVmpPCjyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 02:36:12PM +0100, Javier Martinez Canillas wrote:

> Now that dos_partition_t and struct partition are identical the duplicated
> data structure definition in the part_efi.h header can just be removed.
>=20
> This results in a single, shared definition for MBR partition table
> entries, instead of having the same definition in two different places.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--I7Rek2omVmpPCjyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+TDAAKCRAr4qD1Cr/k
CmjuAP9mwl8d/+MLtL5oqIlCd/VLILT4ugk9WoRFgpN5X0OOPQD/VdFRA3WQbtoi
QkyPOOWOuo7Eu8W2ZLPmKW+jS+Ly7A4=
=HX1P
-----END PGP SIGNATURE-----

--I7Rek2omVmpPCjyN--
