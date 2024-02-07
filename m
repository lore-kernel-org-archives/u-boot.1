Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DDEC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9D087CA3;
	Wed,  7 Feb 2024 16:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/e0a6oW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574C387CA3; Wed,  7 Feb 2024 16:45:29 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9024F87D51
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6818aa07d81so5063846d6.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320725; x=1707925525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/eX54ljtcERrrZXvFoot6E7h/AOygIsHvZAie97GY6M=;
 b=X/e0a6oWacsExNAYQsGo527pGGzKbtNHeOPRdeCy1H2Pd/2pVX0CXDDAFtqolJcnL9
 yZuzQUlOehTUqmXr/bCZLDENAUM/Fl/was0iXUaQedSReWbH6GLG5PWNHVWH7RBZFQFE
 T2urYsewMsIJUqvNNyJcEDafbNYy36qIEpoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320725; x=1707925525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eX54ljtcERrrZXvFoot6E7h/AOygIsHvZAie97GY6M=;
 b=ZmGyinZGohkV03DI5/11VgRCGAOyDatvyDmbTOZprM/Vei+a+AjVd79V3svFDHqFsn
 jkzA+yTWKToPdnwUmo/gDX6w3udYOt2wh/5irP2bF+x/nG0ji581pdhqbN/jbrbe+gs9
 VC5xI5aFXnInJkmk+4jbkxxJUoDshFZ2HlVN3wmu2jMpkharSAmSp0vRGeG3fR1MtgB5
 EeMOWnSjk129s1nDPPyV70P1gVQr0Dsu1XuNLpU3n0xMwTv5fT+9uv5zyuro16zevzPX
 1Pn3FUdB7qGQ2MET5NQdiJlXdzJw7BT5FZMyWf4mYOiJopB4WUYfMEQwzf7AvuvU7u1J
 V3lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdD46bNytln/9D+MECXWQwSVjEbcindfi58H875tRhXVuH2qusGjGdQw/dU7BaI1fCert3Is5EK62dh4+zwLCTz5hIBg==
X-Gm-Message-State: AOJu0Yyms7mabPz3/TzodXa0usLxZ5EVBoDav24IHDpEx+xtcBlo1tWF
 mg/jbd6AqP6eCYlSgt+ECOQe3a7FftoKGWbumfNQVNhz0RIAj3lRGX0BHEYaKRPPmi2W7qIsXS3
 G
X-Google-Smtp-Source: AGHT+IGl7KLWkMeECOMsASlREALYXq+PAMm2D2skC2iRUwSamh2TAXJv2t+oYryHzRiZHFP40zFsFw==
X-Received: by 2002:a0c:df85:0:b0:68c:c16e:933 with SMTP id
 w5-20020a0cdf85000000b0068cc16e0933mr1062732qvl.53.1707320725353; 
 Wed, 07 Feb 2024 07:45:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBAEow3KxWcuZMfMc9mMa2CgZo7OIHDWa/dc/KZ0yfoDVpEITVVsiPrQu5ki/CQ0wFDIWOywoQAwQVKZjpGxlogQHX9GN7/Mwq6JTmJvl5Qw0jaJig4sBb8TOFkpYKZTzL5ZsicJRjzOZw
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 od8-20020a0562142f0800b0068cc0227604sm441004qvb.138.2024.02.07.07.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:45:24 -0800 (PST)
Date: Wed, 7 Feb 2024 10:45:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] blk: host_dev: Fix error code in host_sb_attach_file()
Message-ID: <20240207154523.GH1152441@bill-the-cat>
References: <e2f1eea9-8ed6-4081-991c-b1348b7d1c55@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pcCavSnf+NXf3rzr"
Content-Disposition: inline
In-Reply-To: <e2f1eea9-8ed6-4081-991c-b1348b7d1c55@moroto.mountain>
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


--pcCavSnf+NXf3rzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:09:52AM +0300, Dan Carpenter wrote:

> This error path should return -EINVAL instead of success.
>=20
> Fixes: e261fbf34785 ("blk: host_dev: Sanity check on the size of host bac=
king file")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--pcCavSnf+NXf3rzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpZMACgkQFHw5/5Y0
tyw9FAv7B8fqKAUuabsDVIP3vZsle+sgVBoEc1867W5OOyTADI0eEIBOY2h8eJNj
DKRPvI3e0D9PIj8+8NiGXgPoC9DKWVhHJOP0dDgU/TyWv9zSroSK915Bj1nycCoG
yOGnp+K1mB3EOFdNSwS/mozadIMS7V7OzbvrAQDr/IhrEYsB1RfWlSWtlB2z5yPk
tZzcjMbIVtyHcQt6Jj/YC+RbxCTnLwDu33EY3tC2kuWoAuLaEmFLgd4qEJS7C7li
Zrgcyv7tscx+FIgXQ8jc9jWI0fQOG7UQIhIZ0nsfmfn/ETBc0ryE/FD7w9lV7RJV
NjPX526W+A8vL+VuAoORlwHI0u8yj7UEcI8D1wecGG2cG/q/2J7jQC0Lc5G/iNVP
K7YwVRkTvnc6/mzukPmXK+VeuzbsHuXZN5m6+MXJQODZLptK/AVIkwS/ejw2ChaC
PsAHkz97Fy0i/HyzYfJTAjGJ3zGqbbyJAFrpVhNoQtL4LvqsNXOVj+Ty7/7niRC+
tS1DVCwB
=2X+v
-----END PGP SIGNATURE-----

--pcCavSnf+NXf3rzr--
