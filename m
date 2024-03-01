Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C48C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 14:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536E887C0A;
	Fri,  1 Mar 2024 15:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aeU28GJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B0F587CFC; Fri,  1 Mar 2024 15:17:37 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB4987A23
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 15:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-607dec82853so20743247b3.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 06:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709302653; x=1709907453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bHCn2TSs3AkdYlL85Y0kSqHQoP5FyHDA7oCa77QQvo0=;
 b=aeU28GJpACzaawb9iEv07FrJmi59uEVPMMRSfkQdQP5VtlJRq+/zmj+N+Nd6+MMbVU
 QQKDlel6vf2l5PNCHk2rAPxIYQexRjbjT72LvyV7720+YEodN0CmkXmPMbiCRPP2//lu
 zVvrOT6SEDOx9ktKOXmC82gOD3LdoOkMFKTGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709302653; x=1709907453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHCn2TSs3AkdYlL85Y0kSqHQoP5FyHDA7oCa77QQvo0=;
 b=VcDFEtNfWfa5RSe43GthCFuRpvINGcyc4/jFQHTIWFntayzdy/a6kEEw7B6Pp5raTQ
 uOWkXIzENy0vIzgZ/OoEErv7F7u7ONz4YI0KYlvIdbgY0xkAh7RjtIYBs4bPe++xVMck
 ucxcAdN8kgzm8ZRSSq+3UgGrxueiT8JtEEKLmSi45qcMnuxAhoWdJIK8hvvwoTJgPVh4
 ucHysKrw4XAYjpw6Hisuto5DDt2J1vJk3Xt8KRZWZiY8lknfVQoj1j8Y6IzbGww9eoii
 zsA0ZDO+YOknEqGz78/Vo0oxUzC+CUC4U6w1Sb80B7O5Lq+c+nrK1I5KR0qbAkcr3TFk
 3Gkg==
X-Gm-Message-State: AOJu0YxzRZgOjoYyzVqsOKB64TzXdvGVJdZfsDT/S2niDWMLWLPik6Xn
 GbUJKL3Q0K4jMtIOPoc+VYUGoEA3++5ohPlMAaJeXJhEM/TQqeeWMqwWMk/V/Jo=
X-Google-Smtp-Source: AGHT+IHDRbkgiy9GolMxJNeY/e1+pXhG9NtMA5CknlETc7Ny2hobP1pqbkrpeOKXsi5F+4y1Gj6mEA==
X-Received: by 2002:a81:9a94:0:b0:609:89a9:9a58 with SMTP id
 r142-20020a819a94000000b0060989a99a58mr686411ywg.10.1709302653384; 
 Fri, 01 Mar 2024 06:17:33 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 i67-20020a819146000000b006097e2e54eesm509596ywg.127.2024.03.01.06.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 06:17:32 -0800 (PST)
Date: Fri, 1 Mar 2024 09:17:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Ken Sloat <ken.s@variscite.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 Roger Quadros <rogerq@kernel.org>, Nate Drude <Nate.D@variscite.com>,
 Eran Matityahu <eran.m@variscite.com>
Subject: Re: [PATCH v2 1/1] net: ti: am65-cpsw-nuss: Remove incorrect
 RGMII_ID bit functionality
Message-ID: <20240301141730.GA1118861@bill-the-cat>
References: <AS8PR08MB79915B184330438FBFE664DAEC432@AS8PR08MB7991.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZQCrLBjyVAHClKKN"
Content-Disposition: inline
In-Reply-To: <AS8PR08MB79915B184330438FBFE664DAEC432@AS8PR08MB7991.eurprd08.prod.outlook.com>
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


--ZQCrLBjyVAHClKKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 08:17:05PM +0000, Ken Sloat wrote:

> The CPSW implementations on the AM6x platforms do not support the
> selectable RGMII TX clk delay functionality via the RGMII_ID_MODE bit as
> the earlier platforms did. While it is possible to write the bit,
> according to various TI AM6x datasheets, reference manuals, hardware
> design guides and TI forum posts from TI, this bit is "not timed, tested
> or characterized. RGMII_ID is enabled by default."
>=20
> The driver implementation today however, will incorrectly set this bit
> whenever the interface mode is in RGMII_ID or RGMII_TXID. Since
> disabling the delay (bit=3D1) is not supported by TI, this bit should
> always be written as 0.
>=20
> See:
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum=
/1211306/am625-enet1_ctrl_rgmii_id-_mode
> https://www.ti.com/lit/pdf/spruiv7 (Rev. B Figure 14-1717)
> https://www.ti.com/lit/gpn/am625 (Rev. B Figure 7-31 Note A)
> https://www.ti.com/lit/an/sprad05b/sprad05b.pdf (Rev. B Section 7.4)
>=20
> Signed-off-by: Ken Sloat <ken.s@variscite.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

The whitespace in this version was totally destroyed, please re-send,
thanks.

--=20
Tom

--ZQCrLBjyVAHClKKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXh43EACgkQFHw5/5Y0
tyy7owv8DRYA+pJzMvZLcnHKd7O5oNarjtlzdm9DwWHxRU5qkKMzW4tioe4xrIap
RXbdIyvrQjfmn4iXcWOrAqptUBiJPsgTZoQYyDuf4XhULS05getZUAtWJMp3kmOx
WwUdaN5KhikDjBdpW0Er2fZF+5qDj8WjWoIn6PIKZbnufBjz7iOp8C+z1JZSQI1z
mUlv3OGe06SWOJmjuCAvTW/itpamDAOVu2CvCGZ1OtfmAboVvknHrIQuZSSHR123
i1FWDdDlZVszhf+i5fwvSBC+wLF4ZTmRTZu9BXLGfMpU3f3OatqWBWU1vMpltXI6
JoxcPJQIpohx3EQ5BdOVQgoIKP3qWU0m1u1AZ3ZevuCb38ZQq5rm0JC6Yiv7MSqA
f8bcUmX7Sa31w6kqof/7eNAZoIKmhj5G7j1uI3BXGE/bNPpcpP7Vbkfv1Vknl798
yXBhNnhybPzbR13y4t9VCCn+gy/TYY5a8EIbfJ7REOz8CjwWo2OQJZ5uaQ/lbES/
69geFlY1
=Lx+h
-----END PGP SIGNATURE-----

--ZQCrLBjyVAHClKKN--
