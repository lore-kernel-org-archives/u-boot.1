Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72055D2C55A
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C0D88F8E;
	Tue, 22 Oct 2024 16:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EpriQnjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E2288E89; Tue, 22 Oct 2024 16:01:43 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12A288FA5
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so33341786d6.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605699; x=1730210499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0dckx4khsgusx1CgJxY2W5ITf5CsrUHOX+/pN9/Wo3o=;
 b=EpriQnjCopTFY3kRCfQTuXVMtd3SbQBpULnXho9661HLOo5iArf0e1ZVKf51KOd4EQ
 WQEUBJjZ7vptJn9ifFfTQokY6c98nqMVNdnxnPwwcacsF6uPQHwrDuoiKffWo5sAUJKX
 WQ6M5ppyw36PVnW94R7PMeIMUIANnQYoaeCm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605699; x=1730210499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dckx4khsgusx1CgJxY2W5ITf5CsrUHOX+/pN9/Wo3o=;
 b=PI/dFXlB4iHQMdBQbRvsoJuHir5EO3URs9ANLwovYLIOgUZQFzTduGXVoFAL3Misbz
 pXfQmfTyC1JMw6ybvU7le8e1ho7pohmXxjTVF4BWwrf1oEEGiZOtVx88hqbQCWTl0Hlb
 eXfXRvrhPCJS4tioCqtU6Iqq6jbuUg+fPNn9RvwIrGFNmpXbN8INzLK3KCQOH3UK8HWf
 EqjT/1lKsNmrLiazo+QAuoRt3scCmTXI1VQkpEKXN8tcvFsv+XL0d9PuwH93EYKGNuIP
 N/mCrRmDISsuGYn7fGQi3kFxhRR6v1CWhHfpGQqK81Rw+hHIX/Mi05FYPbETdSzwdsq/
 kebg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPsdD1Meo3B5D1QmJMakbBTFV9x3iSZfh0FwRoxM0G4Yu6bvX4C3fr2WW4tTIzrExcTTJUrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4yoWxyw5eDD9cD1HyUr5vSQ7rTf/Fl4Esaz+E3y5raWgqYOt4
 A3Ujl2Qm+j5M05kKSXgCvZTFiQjaj0CGhqWiJP3FWyzIdD+NER7BVR5qrgatWhg=
X-Google-Smtp-Source: AGHT+IENCP3iZ0tt5lRLF9bu50Ehw++M2rbbnnqLJgn2S0giucxlxu30i2eRP1BfsFEk5k72tK4dCQ==
X-Received: by 2002:a05:6214:4b01:b0:6c3:5833:260f with SMTP id
 6a1803df08f44-6ce205682f3mr48619006d6.39.1729605699614; 
 Tue, 22 Oct 2024 07:01:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a3aasm29768491cf.4.2024.10.22.07.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:01:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:01:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH 1/6] memory: ti-aemif: Correct macro to ensure avoiding
 precedence issues
Message-ID: <20241022140135.GV4959@bill-the-cat>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
 <20241021151330.1860929-2-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="50qCD8AdfUciTj45"
Content-Disposition: inline
In-Reply-To: <20241021151330.1860929-2-bastien.curutchet@bootlin.com>
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


--50qCD8AdfUciTj45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 05:13:25PM +0200, Bastien Curutchet wrote:

> Fix following CHECK pointed out by checkpatch:
>=20
>    CHECK: Macro argument 'cs' may be better as '(cs)' to avoid precedence=
 issues
>    #62: FILE: drivers/memory/ti-aemif.c:15:
>    +#define AEMIF_CONFIG(cs)               (0x10 + (cs * 4))
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--50qCD8AdfUciTj45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsDwACgkQFHw5/5Y0
tyxX3QwAt/u0CryE+2n1TSAVtNTSZJ1Jiw2C+NcqxeGodKT5ToU2U6tNDws8jW0K
Za+wUcSM2g5apuyMU/m+8m5gsdx2Fpn7kKCxjzmretrTDkcz14XuErhPS6FjMOoT
nqbIm9lQWNfUUWjnelmKbKojsST40S+x0GkQR9FErCNK7NJxWFjEzsFWh9yVviDr
GdBG+n6uuFLz7ParXjx11zDCfnC2WnY45Kdeuum2YJH93yeLt6klEn4A5t6yTYro
laVTJfbtlMZy3KtNbAKdO4ur0Osz5q739wOA8tBIWzaImZu9k5fL0TAk9pOK8Et9
12dpnAN6FMI+D8RsRrEFt4tuftVnT9BiJcwKaLv7J7CNY4rphkMSwfPW2w2+G04C
0d/GfGvzDbgvBZZsbYcUGU80ORK9bPMDkrTJkFHHzPUzMJUTqcP805Rf+I+G22JC
luLO7U9VdhM92CQBXyycclp55ZaR45OJAlHa/88+goIalUuBUCJJw2uX/usDiM5T
OW62ykCe
=UFlK
-----END PGP SIGNATURE-----

--50qCD8AdfUciTj45--
