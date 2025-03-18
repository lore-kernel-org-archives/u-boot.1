Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CDCC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 16:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AF581026;
	Tue, 18 Mar 2025 17:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7o8GcY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C152810F4; Tue, 18 Mar 2025 17:10:55 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85C2800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 17:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2260c915749so36765575ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742314251; x=1742919051; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R/UMiNEQHZFEwTii5/3WEwanuQDfxdfyKsq3Hb6gauY=;
 b=j7o8GcY1B+denEW60IJUZQLJovRcc/8dsMEIgDU0zxIeva8XG7pvGmR7kqJqHMKVzI
 4zSx4YYAwQPI9493DwhZGluant76oOQzYWDbMTEsFnbTbZdtv8PDbKIWtyIOiODeTBHu
 b9RHSgIZWX1XOxUGCq5Fcc+vpiWwi3y+mtw20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742314251; x=1742919051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/UMiNEQHZFEwTii5/3WEwanuQDfxdfyKsq3Hb6gauY=;
 b=xJgHY351JYyRZ3ZZJb58nKZNH/xhY+3x9lQvJb6bGbfoIX1vya5WQxRorRi4sLU0U5
 fM/RVFC6HcY4na7GO8eAdLMRsfyG/G5HIlGRSH4ldfEUBDLxiM3nPY3O2AaXViG+gB1R
 /6c41szpqbjqui6WvWPe3r/ydcEXV+XBEzzYR6LY3uqGmv6aMzUnZ4bDllsHcNq/MP9Y
 GyBdYRm7yJtOpCstzDjiKwA8uK5tLUPsZNjzFbAzTOCCXQaJ3k7felu/207GpX0Bs9Aq
 c+EGx8on19fNk/snY44yjOpAVk4i2hfZpkzGlNLbA5+W1+ZS+/6eossy8Ed7qE+TxLLS
 1Rhw==
X-Gm-Message-State: AOJu0YyAL6DVZZdHFZgGYdvBcMElWKD7Dzem1sF29qnEC+dVl8GG3c0v
 9lz3JHyO5FwzU5EfPM49MDzhOFqjVdP4zfaZDXq47A0CcP6rvH/9vq85LSS9i+M=
X-Gm-Gg: ASbGncvZYtOliwhgEk6Sj+hD93/5WB4Teikq1M7hQ2X2f2ffAbQIPQ+dwwdU8JZE/gu
 YDPwvoqYZ5lJY6fs0NBsJ0ybKCUDpfiCQDF9r8UqRFmdRPqiU6dAFHm7E2AR+BORZQ2iIxLb824
 iC+BED1fBNM2FjsRmfRRUdf2StAjarzm191kGey4Q6e5LW5i8zBxR2gq4thmwwBytiefNi5dSTz
 5Tuo3puA3mertaSUUcd0KGEFTi4GTst1hJt8cBr+maYEw4oLTS5TDE50VFGMfZt5+N47DEtMjkd
 iTUDP5DVKxM6zVClyCHsIkAD53LAqW2e1ojezjc6Ls/ltg==
X-Google-Smtp-Source: AGHT+IGrAWnXf9q0rqGChpWn9nkca9qfKi8qZd2onSf/YD/aB5gOwxwXDKhK/9T0246xPYzOP7/C7A==
X-Received: by 2002:a17:902:ce0a:b0:223:3630:cd32 with SMTP id
 d9443c01a7336-225e0b2fa2amr234895945ad.53.1742314251258; 
 Tue, 18 Mar 2025 09:10:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68aa938sm96420815ad.96.2025.03.18.09.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 09:10:50 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:10:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [EXTERNAL] Re: [RFC PATCH v3 1/5] cmd: fuse: Remove custom
 string functions
Message-ID: <20250318161048.GB2640854@bill-the-cat>
References: <20250318105047.256022-1-h-vm@ti.com>
 <20250318105047.256022-2-h-vm@ti.com>
 <20250318140932.GY2640854@bill-the-cat>
 <e78678b0-3f56-831f-fda7-eac3a0eae31b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2wQhk0MKrbJn/xhY"
Content-Disposition: inline
In-Reply-To: <e78678b0-3f56-831f-fda7-eac3a0eae31b@ti.com>
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


--2wQhk0MKrbJn/xhY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 09:38:59PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 18/03/25 19:39, Tom Rini wrote:
> > On Tue, Mar 18, 2025 at 04:20:43PM +0530, Harsha Vardhan V M wrote:
> >=20
> > > Remove custom string functions and replace them with normal string
> > > functions. Remove the custom strtou32 and replace it with
> > > simple_strtoul.
> > >=20
> > > Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> > [snip]
> > > @@ -54,14 +43,18 @@ static int do_fuse(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> > >   	argc -=3D 2 + confirmed;
> > >   	argv +=3D 2 + confirmed;
> > > -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
> > > -			strtou32(argv[1], 0, &word))
> > > +	if (argc < 2)
> > >   		return CMD_RET_USAGE;
> > > +	bank =3D (u32)simple_strtoul(argv[0], NULL, 0);
> >=20
> > Do we really need these casts?
> >=20
>=20
> Not really, Just added them to make it explicit.
> I can remove the casts if that's preferred.

Yes, please drop the casts throughout and post the next iteration as
non-RFC, thanks!

--=20
Tom

--2wQhk0MKrbJn/xhY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZmv0ACgkQFHw5/5Y0
tywfIQv/cm09ktBF4SuRsMd/vkkY4Cn+OErTnfXDCO5JmKjIGO05f6YOh1HT1XHf
rMYsCwd3djQE+uWIN6iVUc5UH1YZMFLOMm8tR729YIjhlf9FbKWfnAPrrCGWodIh
BthgerozQZVWAG31d0jYMgmKQSwsXb6yan+hyo3LyxlLSjYHcNnRO0BjVCLXU8J9
FG0b0QoUlqpRMkAOS3pG5AyxBFA2CK+buKFCbHd1lfsO5ppHIv8nPE0OjVOiSbDY
WgNlBg3mo1H6p0iJHgdFUqt2MTc1R4Ok7qS6cyMpVa4UBLh+4qlqg/rP0f5yV3BM
61m63mTi1i6emyVrmCkmW+rQR5gJ1TA6xihfIvQYeDQomd30Tso+Avln86iOiDUr
3vTMSNVHfeHCmM+IxbP4chxzRks4e5Mbtd2CsCmUYl85Z3UxuxDEx7i5pC8nRtME
6BkZPDrT/cGMaJnW5hTusg5+prPtKA+I2k7zjn8Ftc8iAwonCS7r1Yv1xblL3Y5M
TZXcmUWF
=u1rM
-----END PGP SIGNATURE-----

--2wQhk0MKrbJn/xhY--
