Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062E9C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 21:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2926405C3;
	Mon, 24 Aug 2026 21:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYm15Chwwdju; Mon, 24 Aug 2026 21:34:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787607263;
	bh=uCx+DfgxaSIx0cWoRb6c6c9HaOfE7w5prO9S021Ln9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDEeY7S3dx/fx2gIMoFdFrTIwuKuqB/JdjwYmirp30DdD3d/r55kLrrY23CQqw0Fp
	 ZTfaSSq0G/BznmZPt3y/oiMaz0ZKeIc3IqNcUe204eoV4QYWd80G4sMn5cbCQbhfki
	 vCBM1IWdSdJHFPLsud3nGmH1Xj//taGU2yQ5/mn3zxPXYAZPykMSSw1KdThXaJGQML
	 WVnbhYzmt8NYk2q1+YIRlDzzfVBvitXOy041uFNShzEbzpxEtZRuXhIi1UscT/+vQe
	 QdvyTX5XFarqTOwV4sfsR2lh1g4N9/18OeHPD7bcRKgLuAGU5EWoEczYfngW88vSiY
	 9D/LrA1oph6Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E824E405C9;
	Mon, 24 Aug 2026 21:34:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 424A84B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 21:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 340A0405C9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 21:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UTnpZETedGpZ for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 21:34:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gJesUo03
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64697405C3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 21:34:19 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7f0167e59a3so3051382a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787607259; x=1788212059;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uCx+DfgxaSIx0cWoRb6c6c9HaOfE7w5prO9S021Ln9A=;
 b=gJesUo03XPlWBERNTyzRmBznahVGYVbshjmI2QmkDpBfZ0DBroVoj3T+9MYn95X6iI
 XIpsY22PQAY0TU7L9Fe4KD7dMZy61TKQFDsFR/iDaeIzpljXYF9CV6z7gflxfs7rsOC/
 YmHosRBFgHvQ5j0gScysAG05+G1IGJcq7xLY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787607259; x=1788212059;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCx+DfgxaSIx0cWoRb6c6c9HaOfE7w5prO9S021Ln9A=;
 b=ThDu0jepIjp7tIA9Q6XTmEjgt9Row9Oh0CHJbjdrex8Sqp2wea5uKB3EBBtH6puEsN
 CrBYQFdFXkhBtv1qLoRqa9Db0SM/loPysHysCTw3LGhYzsteMDEIBKQ3oPzOodcsFh7R
 FFDP6VdKVFzN4gGatoHvWSt8JAE4C8xhDlsy9TR4gZUwLGdq4GwmlwB+VGAMiOBinsjM
 PThuOf6JmpuidhBibrMUOx6XKb5fHw20KAPW8QsYsVcuRsxC9odoKCTvlzdd34klvYg6
 cp0IyK4ZVuZARy3Gehb8DgagE0Ac1Lj2HKdcUcE+vFy5otgtDYr7/OwCQ8jypfPKGZw9
 YemQ==
X-Gm-Message-State: AFuF++lnaf4tGKi8eOwuV/Okc7bc3u7A+qfls+cZnXO1vuUyRFXsHQBO
 KoQgEOH9KOkK6pbC5pVVeAUwjB6VUrWpjvBzGqfDJesfCawWbAJ8l+L59WPlAJxsa5c=
X-Gm-Gg: AR+sD13IKFLGdv61q8eyTsXUjF2qNGiXAoUP+sB3Jh7ja9W4WV08TaowhccxV7uCfty
 7DZOTw465pHPCVO2+ezTPywCVxLguj7NVikb/gHgHLss9FnOaT8a8yg2JHh1y1hBLLenZBjl9r6
 s0pfk3lMANrqYxDmzvDets6uWp5/jykQB6Jh9+dsplRFshskzycCVge4vXolaiAZObfyxBzHugm
 YNUR2gciSv/8kt3Sh98FKdWr0BD8o6NH7kd+9VDamnoaHHZ4rDYanbvhCQ38GeTbEx+g0Ld9QXq
 2WbudHkpMQQ2lPv5ELTy5kPlqayft6gT6godM/YCA7Tym8tIykIsgfDMFe3+BPmMtdPDxO0M/Ny
 k+SBOZEehq3MKf2cWp1009VdTHUdC/rZs2tV25DfIEFj4tH4EoKJCq9CcdMWQejb9PNyLT4WYw/
 WgLk7IOIuYA5hemYzLEBOIEYspfuJ4K+7NjZSlivhShASdZyoS72lcVNDigzGYwpCujscWj5+0/
 RvaPfzC2cuoMmZMQM3GWZnT0Hes5S6LvCoUJKXGY537e9ODeGUV/MAVFge8MSTN2I0UvYlAxRoF
 grCIzltY7Q==
X-Received: by 2002:a05:6830:6284:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7f4761b4dcamr23909518a34.0.1787607258833; 
 Mon, 24 Aug 2026 14:34:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc8623esm5172459a34.22.2026.08.24.14.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 14:34:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:34:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>,
 Randolph Sapp <rs@ti.com>, Binarly Research <vr@binarly.io>
Subject: Re: [PATCH v3 3/4] spl: fit: Harden external-data offset and size
 arithmetic
Message-ID: <20260824213415.GA691042@bill-the-cat>
References: <20260810-b4-fit-ext-data-hardening-v3-0-17184cdb87fd@binarly.io>
 <20260810-b4-fit-ext-data-hardening-v3-3-17184cdb87fd@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="99vgveGJCy2f98Bt"
Content-Disposition: inline
In-Reply-To: <20260810-b4-fit-ext-data-hardening-v3-3-17184cdb87fd@binarly.io>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--99vgveGJCy2f98Bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 11:09:56PM +0100, Anton Ivanov via U-Boot wrote:

> The data-offset, data-position and data-size FIT properties are
> excluded from the configuration signature, so they are attacker
> controlled even when signature verification succeeds. The offset and
> size arithmetic in load_simple_fit() can wrap on hostile values:
>=20
>  - adding the external-data base offset to data-offset can wrap past
>    UINT32_MAX,
>  - get_aligned_image_size() adds the block-alignment overhead and
>    rounds up to the block length, which can wrap past ULONG_MAX,
>  - adding the FIT's device offset to the aligned external-data offset
>    can wrap past ULONG_MAX.
>=20
> Make get_aligned_image_size() return the aligned size through an out
> parameter and fail with -EOVERFLOW when the computation would wrap,
> check the two offset additions explicitly, and compare the
> block-aligned size (the amount info->read() actually transfers)
> against max_size before reading. Do the same for the FIT header read
> in spl_simple_fit_read().
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>

Unfortunately this leads to a large size increase in SPL on am335x_evm
(and related build variants) and it overflows the allowed size.

--=20
Tom

--99vgveGJCy2f98Bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoy41AAKCRAr4qD1Cr/k
Cg8fAP4pYXDTGpNCPI7dJ8W63ZTB3s3O2qS24rGtJA0O2VVQdQEAwmYjGfp3bwI8
KQMpfVzdXBgT/zEApspWLjiJsHMddgQ=
=KfHn
-----END PGP SIGNATURE-----

--99vgveGJCy2f98Bt--
