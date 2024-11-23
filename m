Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45372E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C00C893D0;
	Sat, 23 Nov 2024 03:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SvGrZrdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825708981B; Sat, 23 Nov 2024 03:42:26 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DFF891E8
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d41f721047so18890006d6.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329743; x=1732934543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DZV8h5ns9tE9sk3kmaBwQLAMSsre0zQH+laiDCUlpbk=;
 b=SvGrZrdLdb4/R7MsL8k0S1yt8OXQKECL1WYUvrm8YQhYaiT6qcy8BK4PqHt2sav7GO
 9Z2BoNPfOFdDFnIk515SUzaPk8miVpPLjRfsVq0i56PuEbjLUt9wFvVllXwTlRDXbnb7
 3wqjRyYHrdJZC9mqgfYany7TP+va6ecQXIn10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329743; x=1732934543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZV8h5ns9tE9sk3kmaBwQLAMSsre0zQH+laiDCUlpbk=;
 b=ELzGnutA4GY+QSTLcb85WxDT+qpThpNynIboiz6zOL3LyxP8qHctx2vh50RgWdsyCI
 iUfMg9amsooru7m4Il1LEA7BRH547Aov6/jbo4EfcFBxZycRc7TFmwl8CAvubnnUTsl3
 uaCyrmW6rjR6K5WiQ5F+bwKTxVPOVXhq2def/mc7edHEP2WG7QIlvd5QVY75irznSi/c
 w5/i9CpvXX0U8HiJSDyFlAcBvwL07U94/xfqA9/KVI5utovt4xMfGNHRHECC9pox77gL
 +ImP55S1vWq7MCy2CFePLxkdOJXA99uUUhxx4LCEknmh/WmdaR3AcC8bws5yLtRYNaLJ
 /MpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNw+ZH6hAejNxgagx2jHouBl0bXB3MO8hR3IiroExRzuuLFAXzCRZ1CRIaxxq3kATVdKhkQEo=@lists.denx.de
X-Gm-Message-State: AOJu0YzrkjBk6UC4Q4X+6FGp8XTW5y/5ndnHXfR1FQYa6mQe5QGR2h4/
 WclQDXWpsIxIHkmAATjMm7V3uGRMi6fUvxoKF7weLlYtVOi57SbShJpndYhYC5M=
X-Gm-Gg: ASbGncuLjS6CtDeH0K92S2tANs5bGN9Qx0zvhPdxaahRw5A1pJbBYsKvFQaOJiFmTYA
 UR1BlwZrxoOIkmsdOKKB92HICrc/pwAW/Ft5oSdeU1/jeFLMY3FozLaimQWoF6PeIuK9cO1lYtQ
 Z6dnBzKoApbjpnma4E2wpYxGFzQt2HQhIZkYqJqeWmY6nUooUVPLSRPGl9vf/r7hIwEQbDhPbk1
 3FW68tFvZy9B0v+GBDpnb+HNpzOMHH5R1dTrI3b8oAZxYYnYA==
X-Google-Smtp-Source: AGHT+IEBM+VaM/x1ZhN7UZIzbdcxT1PTrbWT2TfagUpj/W3hYYtkQAZ4lTJ7M/M1G+VC80dNgQzopQ==
X-Received: by 2002:a05:6214:629:b0:6d4:1d18:3365 with SMTP id
 6a1803df08f44-6d4513446d3mr69641046d6.38.1732329743355; 
 Fri, 22 Nov 2024 18:42:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451a97c5asm17212156d6.32.2024.11.22.18.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:22 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, n-francis@ti.com, afd@ti.com, u-boot@lists.denx.de,
 nm@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
Message-ID: <20241123024219.GU3600562@bill-the-cat>
References: <20241119100720.1297067-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sEVoitDmBqJ2oAA7"
Content-Disposition: inline
In-Reply-To: <20241119100720.1297067-1-u-kumar1@ti.com>
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


--sEVoitDmBqJ2oAA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:

> OSPI boot is broken due to missing bootph property
> in pin mux of OSPI.
> So add bootph to fix OSPI boot.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--sEVoitDmBqJ2oAA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQQsACgkQFHw5/5Y0
tyyn6QwAhoHCZ2LpFAo6xj++rPXmfL8o3BpC82l8q3EZDJsPt98cpFk9MkzSmLpI
fZ5RGAb6AropqFinjJXfmf6h8Q1P/Pefl2cULK6IJ3DQIa13/l04FMm4U8u2S1xg
rs6GK8JwABeAJTFNUpqfXdIXxOW7Fh44JW88AkeTYgRyniSrW6/ImsL1ByC/gJU1
XuehxaxWYR9ihzJK1hBEt7tQVkS7pIZySret5T7cVc24ucZRFpQHMbsdWOk4BSRT
sW4scCk3zrBwkgkX7MH5+eXnUPar4dNWvnvklam4SsfeiwOwHiQcLXey8D0V0K79
dyO3unSxEfXxKlS/0TFVdbPrvSdnSoFTyAMN9VaUvhzREunJaAZNpRMMEsnI5NWE
JnJUzy2U2Tapm0BBJMpQ9fj5ee8j1uXWMpUAnc+rI0ldx+VwbJ2bOhxBMsvn/btz
X/QNDpuKmHeDJwQGWQuKUW/fb1Ink6tpdGN+4PUhTLgE5kWIpdsPcKV0K8IK9TFa
+jN6U8gw
=wtp+
-----END PGP SIGNATURE-----

--sEVoitDmBqJ2oAA7--
