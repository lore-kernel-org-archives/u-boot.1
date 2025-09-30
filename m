Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3110CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE2D802C1;
	Tue, 30 Sep 2025 17:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DTACvyj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E078C80819; Tue, 30 Sep 2025 17:55:24 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7407800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-91179e3fe34so792539f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759247721; x=1759852521; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nv9YRtCcy5+BPGUuv/2Ln9+iwaXzwoOrwkTD/M8UUb0=;
 b=DTACvyj7VG28WLzSIGxrPh8OJVrKG0zBDf7p/bYVRBNx2qDxECcfQio5SDGcOrW0NK
 pQfu9Asd4pc9gSijBTTWycLlPeGxONr90w66Dwn3RIoGtcMUH3Zz8ta1lWrY2H/JGvdk
 KAZEwDXo1Uc/6wVaF39zkQJNmqlZ14zABJizs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247721; x=1759852521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv9YRtCcy5+BPGUuv/2Ln9+iwaXzwoOrwkTD/M8UUb0=;
 b=wAJXGFo2cqVBi6yUTer6Ir2iYMD1YEVkmPy+6bSzZG+jXZn/kl1mrenebiAmBUtYWB
 4f6m6RmDxQ7h/SaapCAbHE+3R7BdPn5TS0w3vmWnSWLVabyINzYQviFniSAQFtTzso6O
 OFzQSZDa304HSSopyzNBZb9vl3pchbbiilNQ0UFJmaD9ROxoFOWlMF/UATBlacKWK0Xv
 uZ1edSa5uYR8BshhSxtbqeijh2Pi7ZNd+A7cRE3uUYbjqo+YmRMTOY6lYF1KwMTr18s7
 kp8YI+9Mm9YB/OU2TaMFqUJWOPNvetJON66+Aj95KPcAR5f+F+GSqBLOF6izANI9bDqK
 khUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQfX/9ogyvowOsmCATSBu49ZSCAp0IqrQlsOW3vOBAYgw/YSWX8oHjMUdKSsTak8Cxax47pXM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz7c/DaqwrAEhJFnIsZRt+ESCIFAe5hTWqmM24/dFYs2FKTdhe
 8zEetjJk/+lAtTHrM0wkAu+LNrKSjOKSCBTVdZAmgl28ZL30gXxG8wuF6KTatbhBt0Q=
X-Gm-Gg: ASbGncsnhrYDQdsc++m4QUcFsI/WSaQaANc663Ju7yev37twtkXglSlSw9mSAuP79oA
 fQQH2+hHEGkR38XaTvnYU0Bw/ofH36ZS5d6uvwbq5kOYFCY4MszPGDS1e5d4O7j3kzVG5qk48//
 1cd62Z8YF6ko+UN4uNFXV4YU9Hl6c+UdXTEIcT1xfr8BNJIj2opP7rsxMOFzYECmJaoc+5Ur0VL
 3j1RNn/zuU1To2fNkfqb9Jt0Ecm+Nr66FEa9M48y4BM20VCSHqExfaLMCM3i2+01ocnDoffWa1K
 Z+pdjfpdNYsc0wz0Co/mfS+7Za8CwjG2lkUvIrMlRrqdzSuiVyJwlM466YTer1NhwJ2VMJL5wR5
 ogSDj6UhpImFH2r0ZD2BPvhhXH1sHfDwsf+c4QaalqhIdHeQrfdDa714fNje1buEUZPKu79FEra
 r9YXuW/Iakt2iDyWG0/HfvKQ+IVw==
X-Google-Smtp-Source: AGHT+IESDWz3tkdSd5cMKJDnTDM4wqEZcPYir7tB0sL2UwLS78tfHLgwgHmWgchJO0RQTCS4ZXHFqg==
X-Received: by 2002:a05:6602:2754:b0:917:664e:c00b with SMTP id
 ca18e2360f4ac-930b0de69c8mr560373839f.9.1759247721429; 
 Tue, 30 Sep 2025 08:55:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6ae6ec63sm5996337173.73.2025.09.30.08.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:55:20 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor.Dooley@microchip.com
Cc: Jamie.Gibbons@microchip.com, u-boot@lists.denx.de,
 Valentina.FernandezAlanis@microchip.com, Cyril.Jean@microchip.com,
 ycliang@andestech.com
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Message-ID: <20250930155518.GC6093@bill-the-cat>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
 <20250930154837.GB6093@bill-the-cat>
 <f6b35b7a-457b-48e9-bec7-df3e57b9f6ed@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d1QRIg1NMilb4Xg9"
Content-Disposition: inline
In-Reply-To: <f6b35b7a-457b-48e9-bec7-df3e57b9f6ed@microchip.com>
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


--d1QRIg1NMilb4Xg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 03:51:02PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/09/2025 16:48, Tom Rini wrote:
> > On Tue, Sep 30, 2025 at 04:45:34PM +0100, Jamie Gibbons wrote:
> >=20
> >> Correct the assignment in board_fdt_blob_setup() to use *fdtp instead =
of
> >> fdtp, ensuring the caller receives the correct FDT address. This
> >> resolves an issue where the device tree pointer was not properly set d=
ue
> >> to assigning to the local parameter rather than the dereferenced
> >> pointer.
> >>
> >> Fixes: 63a8506580b6 ("board: mpfs_icicle: implement board_fdt_blob_set=
up()/board_fit_config_name_match()")
> >=20
> > This commit is not in master nor next, where is it? I think this is
> > something that can be folded in to another patch and that patch
> > re-posted. Thanks.
>=20
> It should be:
> Fixes: 7c16ebba1ed ("board: mpfs_icicle: implement board_fdt_blob_setup()=
/board_fit_config_name_match()")
> and the patch is
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Ah. And that is in master, so this should be for v2025.10 then?

--=20
Tom

--d1QRIg1NMilb4Xg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNv9ZgAKCRAr4qD1Cr/k
CpS3AQD1VmqYfxe3ui57A+o+bAlI4VJ8LF2wGi9cI9OO5dZcOwEAlFwje/yAZXNQ
U7sB5QOq4Uha3goVwGn8G48XBSZWzwQ=
=wDuk
-----END PGP SIGNATURE-----

--d1QRIg1NMilb4Xg9--
