Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2859E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 13:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72F68021D;
	Tue, 31 Dec 2024 14:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UtF/Zor+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3645780379; Tue, 31 Dec 2024 14:55:17 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5E88021A
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 14:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dce7263beaso88421106d6.3
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735653314; x=1736258114; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGpW+xhSilxoIyjcEeVEI2UN2BshXuXBDeArKNHi1Dg=;
 b=UtF/Zor+XAGFqUlIZzPmKsKm1CI8XHCojSGJuiyTm6uUbNhRJFvXiKfLq4t+SOp4Bu
 KJw+QpTtgad70irW1MOWlWE1A3u9mPUdQDlFcnZL77XOtqFZyRtBE8KaimQmAMCncuX0
 VfecEjRfTwSDxS/UrDfARyCEGDthSpWYka2PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735653314; x=1736258114;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGpW+xhSilxoIyjcEeVEI2UN2BshXuXBDeArKNHi1Dg=;
 b=EBlg2rEK4r/N3Knum6EseI8L0jtIrgKY85akp8jQCWP4jnOq+2bt/DJZtz/7cXZsQj
 Dbpx2rPlefoyN6ux6wESVrcn8dZ1sRRIhmIiHv4NMHe5hioxAKQclC7ZNTGGsUVd0Q5n
 ytJzUtpPSpsHvi2GeZqeVhtZIT84y0jLYdv9MFvFqCSBNYD6IXWthTP+VmRio6j80Csg
 IGG37GnPBHFL59q2DVLbrxbUylcx7CylQ6/DR7FbYQ68TZsJVYNHzKBldeZ49eZOnI4x
 tWlLVPE152fWAQT1IlO+ehulygvYKn30FsPtSS8Sz0ntuD/62YPdl+dAoOtvl/ws3u/c
 wGeg==
X-Gm-Message-State: AOJu0YyfzsJh5bRTzP5/0+9eo8kgf7HWtjXlktrKbtNm5YF+QQgGoEdl
 vV+RRA1gVvl5QifSYrzSYzaFLFPfq4AIaAFrI3ugZTCIyNPmdmBUI83OCfj4SHuT+vE1pl9DqGm
 P
X-Gm-Gg: ASbGncvdq4v9/moUuy3KdMgDqFYPBL77wADTsvsJ/PKPz/7lsk7lYdyaqJr+EZEIWMA
 3nSyzt9khGUlfIgRVNxCRA6u5CtDo28JK03Xdh/VA5kS7ixwaAhb9MN0Tcrw7CqTRe6HOyu6V0T
 8936e1JQSFhO7DmbcQqwdm/Y33v6KEx2We2FGAUcdZRI3k9IPtn/rjc45CY78mStSmissQXs9Yz
 oJKfynoXbcKQZrrV1BCEQlbnbexIGLqG0zK1i7XlAxK6ygtaqIrrGhcvw==
X-Google-Smtp-Source: AGHT+IGg/qh6HCYagEcmbV/GVS1Ijvl4p+mm5h/ri2B3sqnfrWL6ol28hd8Sk/l5TtVDZkmZDbSEVg==
X-Received: by 2002:a05:6214:1306:b0:6d8:c491:9ce4 with SMTP id
 6a1803df08f44-6dd233a46d6mr581955936d6.46.1735653313239; 
 Tue, 31 Dec 2024 05:55:13 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd22f025ebsm105337786d6.82.2024.12.31.05.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 05:55:12 -0800 (PST)
Date: Tue, 31 Dec 2024 07:55:09 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241231135509.GI3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WbHZzHhaoCChXSbn"
Content-Disposition: inline
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


--WbHZzHhaoCChXSbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all, here's the latest report.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Dec 30, 2024, 10:44 PM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
1 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 528528:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1644 in spi_nor_read()


___________________________________________________________________________=
_____________________________
*** CID 528528:  Control flow issues  (DEADCODE)
/drivers/mtd/spi/spi-nor-core.c: 1644 in spi_nor_read()
1638                            read_len =3D len;
1639                    else
1640                            read_len =3D rem_bank_len;
1641     #endif
1642
1643                    if (read_len =3D=3D 0)
>>>     CID 528528:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return -5;".
1644                            return -EIO;
1645
1646                    ret =3D nor->read(nor, offset, read_len, buf);
1647                    if (ret =3D=3D 0) {
1648                            /* We shouldn't see 0-length reads */
1649                            ret =3D -EIO;

** CID 528527:  Code maintainability issues  (UNUSED_VALUE)
/drivers/mtd/spi/spi-nor-core.c: 1613 in spi_nor_read()


___________________________________________________________________________=
_____________________________
*** CID 528527:  Code maintainability issues  (UNUSED_VALUE)
/drivers/mtd/spi/spi-nor-core.c: 1613 in spi_nor_read()
1607                            }
1608                            rem_bank_len =3D SZ_16M * (bank + 1);
1609                            if
(CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
1610                                    if (nor->flags &
SNOR_F_HAS_PARALLEL)
1611                                            rem_bank_len *=3D 2;
1612                            }
>>>     CID 528527:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "rem_bank_len - from" to "rem_bank_len" here,
but that stored value is overwritten before it can be used.
1613                            rem_bank_len -=3D from;
1614                    }
1615
1616                    if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
1617                            if (nor->flags & SNOR_F_HAS_STACKED) {
1618                                    stack_shift =3D 1;


----- End forwarded message -----

--=20
Tom

--WbHZzHhaoCChXSbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdz970ACgkQFHw5/5Y0
tywZxQwAqfj1NAqIIwGSk4dVB/Y3/zoz5zhPvK6nQo0ZFtHpyHJxnNIctmSxpXIQ
yr+sQAwG+NJ+nG/WOaXxbRmEFqG0vh1oZm58KPTN7m67DGCojZTdrfHxQBrFmrlv
rc7cytuxDiHp1rly2SlEnqz9LjBsBdbIl32/gDAF0YevmAU210eIxI0boI9LnoU2
87HBBtTBHv+xrPJDvyY8wzzBRcTftVB84evBXKrNb+ZfO2YT1w8YvXGol4oD6Twy
U7T3zOQfwXLOk6H1Lby6Xh8/NV/EpV/gHgowZLbR5M8qjetGJG3TMnCrG5csiU54
5+vBaK6/MVozi+DTFmffKYG2JLyF62dRD/5xgEI0VeFYYZUITfcjSE+vlLBTlhpp
I/1QYSf7yz1KRLR8plhieypfyx3qveNt+Ak7B2/PRlq1pgK3o16XgMnfrowiDwp+
5i0DidT6aKYlwIKj1xpahNDRLUIwZSne8kdQMsXYH6T8G0TI2BF4yM5WI7E8E99C
NpSoswAw
=icI9
-----END PGP SIGNATURE-----

--WbHZzHhaoCChXSbn--
