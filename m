Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54E9D609C2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 17:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF05E83106;
	Tue, 16 Dec 2025 18:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i6x/jNGX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E7683106; Tue, 16 Dec 2025 18:06:48 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E252E8309A
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso4910218a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765904804; x=1766509604; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s4/DZebZ2soOJ7/8+/fmj/loxKXlVbvgR5DlLXH1VP4=;
 b=i6x/jNGXqDI/bw8yZ5TyqBIBCg3nk5fsA2BGyH8y9dtFHxqvaMtJkN9XqCJjSvu0+o
 EcSyeMGUeOfhrGVyMsJTUuDOv+m7n9DdNm3kYAJ5tQBZybENny14LlJDanEF0wNTDHjN
 I7eNKl3LWRqlA4d9nXqsdZVc6DjQzU3Zzt6iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765904804; x=1766509604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4/DZebZ2soOJ7/8+/fmj/loxKXlVbvgR5DlLXH1VP4=;
 b=rkqRv+oZeinDe1/i723k89qWWyg7ylmVSHsAjD1B1qs2xtIxpxUrBN/vbTICczPCN6
 DBxqVpzU0okkcHSxsMs/bSwsZNSfViyPwXsXH7FneJYBOMc8XwcRVg2LtMEnJDKroZlc
 zPa3cVTdNsVHyb/oGCeQ4h06Gj6M6q3O1l8wYmrLm8SPjGst+DvRoboVKc52S8KhgmBX
 4YzgNpHMmHBre7YNOUE/82LP0btwSKU124fn5EZgys4vIwblr9zdf9CH4OuNuBccG8OQ
 aYxh6Rhu+6VEnroZeoi0x4xDCWcbhld9mAM7L5QLs17oNdV+6F+6i8LPMGnaBWwPXocC
 S1Jg==
X-Gm-Message-State: AOJu0YzbmOSb0YcxzuKrS7DhfwII4Qdd19+FJtbcdkgqWYlYvsQX2Q5r
 HdG8ANH6Ji6Fbt3tRmHWNSP9EUdXz10pB2se/mmfg1obq90Lr5EnzK3hJH6vcF0dBP8=
X-Gm-Gg: AY/fxX77ANkK8KO8D9cajyInjm05dRraeQe0zUYBc7iLoHN9oofcZyge4Q9EmcOYP0v
 0ahNkBUMQ/mWu+Xq8pEsMDGOwAwNBY7g5an2IyfnAK6FLdfOTRn7oGBdj5Um5YCbrH+OZbh2Y0y
 4hjCLQ12GarGi2fCEhnN7I5bduS14Cw3Xco8EiGAl4UcFGsbtuOkoYREbQDnYkaGwD+oOorNeZr
 nmt5b3M8ROHmn0HE9aKxpIuO6gZ6hmFCDqOZMmXNNOZTndhZJV67pi9inskcLOSqirxBw0fIGCU
 V5Gf8KIgvrRmmUA+NmsjfujI/ZiVr9TIPiV9n537/WqlSjrRc/wp5so/YjPxxxnQFcwQluzRheO
 GGA+m6Wh5Mkm0zNct32QOgZl5gNP8GIUEC4pNuxbYbBy8b3uatAKsL3eIQYXeQryE1OPXwjJ3Ji
 2wHfuZdhR7snyOy/EvoEAdQM01VLNfR9J0fUjQ5x+SqbJEGiujGPQMBAi1xIoT
X-Google-Smtp-Source: AGHT+IHFg2Inj0GSd2Oxsf8SdgjH0fvORKzXDaiKdgc4jjZmlo4n0+6Q8g1vVx2cZMV5I+o9382tQg==
X-Received: by 2002:a05:6830:1509:b0:7ca:f4cd:db57 with SMTP id
 46e09a7af769-7caf4cddcf6mr4715455a34.17.1765904804587; 
 Tue, 16 Dec 2025 09:06:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb3261bfsm11573334a34.25.2025.12.16.09.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:06:43 -0800 (PST)
Date: Tue, 16 Dec 2025 11:06:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
Message-ID: <20251216170641.GY303283@bill-the-cat>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FE86SOf7/oWf2+t0"
Content-Disposition: inline
In-Reply-To: <20251212145056.GR303283@bill-the-cat>
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


--FE86SOf7/oWf2+t0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 08:50:56AM -0600, Tom Rini wrote:
> On Mon, Dec 08, 2025 at 06:53:52PM -0800, Tony Dinh wrote:
>=20
> > This reverts commit b32dda34506b4f486bc803d0c7251f987edd2455.
> >=20
> > Currently, scsi is broken and causes data abort. I did a bisect and fou=
nd
> > that this commit was the cause. Reverting it and scsi is working again.
> >=20
> > =3D=3D=3D Error Log with data abort
> >=20
> > U-Boot 2026.01-rc4-tld-1-g0e0a198a68be (Dec 08 2025 - 17:42:05 -0800)
> > Synology DS116
> >=20
> > DS116> scsi reset
> >=20
> > Reset SCSI
> > scanning bus for devices...
> > Target spinup took 0 ms.
> > SATA link 1 timeout.
> > AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> > flags: 64bit ncq led only pmp fbss pio slum part sxs
> >   Device 0: (0:0) Vendor: ATA Prod.: FUJITSU MHY2250B Rev: 890B
> >             Type: Hard Disk
> >             Capacity: 238475.1 MB =3D 232.8 GB (488397169 x 512)
> >=20
> > DS116> ext2ls scsi 0:1 /boot
> > data abort
> > pc : [<3ffa5d3e>]	   lr : [<3ffc1515>]
> > sp : 3fb65ad8  ip : 0000000c	 fp : 3fb7f220
> > r10: 00002710  r9 : 3fb6aed0	 r8 : 3fb85e40
> > r7 : f10a8100  r6 : 000003e8	 r5 : 000003e8  r4 : 3fb65ae0
> > r3 : e38e39c1  r2 : 00000000	 r1 : 3fb65ae0  r0 : 00931767
> > Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
> > Code: 3ffd b510 6803 460c (6bdb) 681b
> >=20
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>=20
> Any comments Balaji ?

Again, any comments Balaji? I'm otherwise inclined to take this revert
this week and sort things out again in the next branch / post v2026.01.

--=20
Tom

--FE86SOf7/oWf2+t0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUGRngAKCRAr4qD1Cr/k
ClcPAQDdP4SSU+BZ8hwMaqDQeN70WdQb4n42EeLuTwnVh4AGRgEAtreaaU+pSNzT
IR7qN4iBV8hqv2UdYZ0+hXmHhkXrqQE=
=HRKW
-----END PGP SIGNATURE-----

--FE86SOf7/oWf2+t0--
