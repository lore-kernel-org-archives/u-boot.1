Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDC6D778AF
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 20:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCE083AEE;
	Fri, 23 Jan 2026 21:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gbpOaLB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ACE83B03; Fri, 23 Jan 2026 21:15:46 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A042A83A6A
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 21:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d148f6833aso820955a34.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769199343; x=1769804143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ivmjQvY4WI10tf8riET/y+4vBXq8E56I/RWH5G141vg=;
 b=gbpOaLB2XfC7Z7NTVHXg39Gp3c/BN8qylPpGiZ4HWwZiM8TgtaA9woEzjmBssxrruj
 nndmgyoQ8bBGgUA5mT+7ejYN0JEWo9H4wKz76T72QnyK1N3CYlihDwFxZQTnYjwOyhg4
 DrIUUH2KKw+h5SWvcJ4Ozyv1cFmuDNGqCRj4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769199343; x=1769804143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivmjQvY4WI10tf8riET/y+4vBXq8E56I/RWH5G141vg=;
 b=OR/VryaO+b9wxb0o3MPGMErvYuR+wkl5eqqavevvtsCk1+Qu+VaEsQP/H1EvWeQ0kg
 z3fybrxP/iu1V+5Tlaw22zjcyVepobMRDa46L7Laqs1Vp8dR2wktbCYtNQLQR7IhJzZJ
 Sx/EXYmZNbUU8sD2G+juop9It9PQkPI5oymsxomSQcSpWh0L76q6QtbFKT4011boKDfo
 2glYEXEKA8byqThklndaotqV9tu4yT3m03634DOxp4AbkILlbkdVEclJG9FT2JvWoaA4
 uMNZQhzvhVyFcrxYjmgZmgdI6uteHz4i/VLSbUZJiwAMUHCwtHXpELBCYNjOZaOuaGU0
 r2oA==
X-Gm-Message-State: AOJu0Ywo7RcuIRH+naomNZubm6jd6+8J7uLxs+Y6hyDfkoANyZXCDBxv
 0mQXoTxyY8R2ogdjwCFYbbUmhV6/m++HyoE7xmGxX/L33zo2iaAjCmQRHGnAwpmdgFk=
X-Gm-Gg: AZuq6aIypfQs8xD9EQS22XLxMqBUbxnTfYEoW+S7mM0cNjUIomRbKe/vN9A/Tq6M4x8
 fZRwamHoYpDUgyR2PRjvWVMgZblL55mCecRR7MWGY2AVUUVKG31HngGohAAprUM0zPC7V/ISzTf
 eaGFCj2r8cJiu50uPkeV84cc9iqFkptP1v2b+x3PIC35Q+suJO43IGePvvaDTQBezI7vs/tdgO8
 eyCyxcX8ml+tneF9mPZDeRqtei7N102Pj+Rd/Q/Ez61+LiOUck2qc5rfi2AdNY+QjihtjrnMRCg
 W3X/0VOYM0PCRuzuGblcpmpgy8n1wdCSwIcmrUxX7mZbr6J3EWUZY+pGtVZs0pCC5dO2AORWnp4
 iFQwO6K+QFNmvZxHYfYmf9pn++Z9+cLRAmE0Yqknpyx7sf5guBarDg5fsxNLdLYTmdKMNv0iWG4
 52/hZT7nVlXoXmMjyD0tQUssq365iiRoV6yct469n4IGIRv4RMiQQXsS4nIoyID9Nd1xzC71oxw
 OkmAqAksQsNXBHso6OVQDmKRxJ4I326XTB2uZzW65PslvVNUw==
X-Received: by 2002:a05:6830:6116:b0:7c9:5bef:ec3 with SMTP id
 46e09a7af769-7d15a5cc5bemr2221195a34.12.1769199343328; 
 Fri, 23 Jan 2026 12:15:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b346e03sm2449643a34.1.2026.01.23.12.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 12:15:42 -0800 (PST)
Date: Fri, 23 Jan 2026 14:15:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Leo <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH 1/2] boot: Fix dtbo application by ensuring overlay
 alignment
Message-ID: <20260123201540.GA2406606@bill-the-cat>
References: <20260120153314.95091-1-jamie.gibbons@microchip.com>
 <20260120153314.95091-2-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mmvGnDTSRPCFKVwX"
Content-Disposition: inline
In-Reply-To: <20260120153314.95091-2-jamie.gibbons@microchip.com>
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


--mmvGnDTSRPCFKVwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 03:33:12PM +0000, Jamie Gibbons wrote:

> After U-Boot's DTC/libfdt update, device tree overlay application could
> fail with FDT_ERR_ALIGNMENT due to the overlay DTBO being loaded at a
> misaligned address. Change the FIT image loader option in image-fit.c
> from FIT_LOAD_IGNORED to FIT_LOAD_OPTIONAL_NON_ZERO, to ensure overlays
> are loaded at properly aligned addresses and any alignment errors are
> resolved.
>=20
> Tested on: PolarFire SoC Icicle Kit
>=20
> Fixes: 0535e46d55d ("scripts/dtc: Update to upstream version v1.7.2-35-g5=
2f07dcca47c")
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 2d040e38d97..3a327d07784 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2481,7 +2481,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, =
ulong addr,
>  			addr, &uname, &uconfig,
>  			arch, IH_TYPE_FLATDT,
>  			BOOTSTAGE_ID_FIT_FDT_START,
> -			FIT_LOAD_IGNORED, &ovload, &ovlen);
> +			FIT_LOAD_OPTIONAL_NON_ZERO, &ovload, &ovlen);
>  		if (ov_noffset < 0) {
>  			printf("load of %s failed\n", uname);
>  			continue;

After talking with Marek about this more, we think this is the wrong
approach. Can you please try dropping the load_op test from 8fbcc0e0e839
and seeing if that also fixes your problem? If so, please post a patch
with that and a Fixes tag, thanks!

--=20
Tom

--mmvGnDTSRPCFKVwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXPW7AAKCRAr4qD1Cr/k
CnGQAQDR2oavql6PpotPzXFrqSK2qrR/VN7q6IAVgvIyuQ2sCwEA2tL18XkFtazq
x4elfT30HwplpNW5TSlYOcZ+WvUcZww=
=79Wk
-----END PGP SIGNATURE-----

--mmvGnDTSRPCFKVwX--
