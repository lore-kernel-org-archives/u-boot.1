Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE9EC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C5587872;
	Mon, 22 Jan 2024 15:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZcXQVxfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA9C8799D; Mon, 22 Jan 2024 15:47:24 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721948783F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dc236729a2bso2606344276.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 06:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705934841; x=1706539641; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TPr89lk8bwUDNivvTfOkLRce00ZdpuhD3upJjYeCnqk=;
 b=ZcXQVxfRUodX2hka+cKon6zvEQ11VvZUzMwq6Z6WdEj0rJhEvi7MwAC+SKBfl/AeAH
 59izm13RN6lrQobZmISTnCkVEI9POeXLFI+yddpYb92AOjU61D1PGV03UGzs5t6SAKXJ
 Yb9T8oqpMhiBZAXaXLQdg3gYe8rHJ3pu4VVqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934841; x=1706539641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPr89lk8bwUDNivvTfOkLRce00ZdpuhD3upJjYeCnqk=;
 b=cknoInfqg/5CpfBqL/A982BlfTroyIRMt8Wi0s/MTu7IEA3kZ8daZMqANEmj6UX3DS
 fYCeULfC0gQs5OpF3xTUQ+xubChwYd77Ic/nQCKsz048YNFd+UpRUws1LOyHbHfH18Jl
 Nsnyxkfcuu3+I3uXXYPP6VhOmWuvvKclCpoJ4qlwwdsGDuGJuPwVeZc+26qGxxsh+cby
 3EYukXdsza2az1CL51mPgAcPwX2VPOFubq6Wpk2FT2dhVwnKUMsluPrxRmontWgdqIU4
 LYsriUd64rOI/R2MtjWRMxCQrsf6qQxCSMMIbRxPYc0ubFL54c/LpLlbx98KDTz17XOf
 EKyQ==
X-Gm-Message-State: AOJu0Ywp0iCCqvPdj6Hzhvoqv4rMWufeH5V5SMr/QUY2hTpTlbAK8Fj2
 KEAfoHy37iyGHT8RJcA0Ls8ZpDFrTFkbaBxH69putEhXAhT6TeHsAW7nYcRGxp0=
X-Google-Smtp-Source: AGHT+IFA7Vu44FaWY65me+AqQ5odHdZn5YWGH4xcudyw7EzuDaBKVUpN/tHMyPAVFCZF0HEipjsWOg==
X-Received: by 2002:a25:9343:0:b0:dc2:5086:6a2d with SMTP id
 g3-20020a259343000000b00dc250866a2dmr1930833ybo.1.1705934841157; 
 Mon, 22 Jan 2024 06:47:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q4-20020a5b0344000000b00dbd15c3b753sm1580050ybp.46.2024.01.22.06.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:47:20 -0800 (PST)
Date: Mon, 22 Jan 2024 09:47:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: Pull request efi-2024-04-rc1-3
Message-ID: <20240122144718.GG3652023@bill-the-cat>
References: <37dc396d-7580-4373-b8e7-561a8f7fdca2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hlwRQBmsMGrJNECi"
Content-Disposition: inline
In-Reply-To: <37dc396d-7580-4373-b8e7-561a8f7fdca2@gmx.de>
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


--hlwRQBmsMGrJNECi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 12:46:05PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f=
78:
>=20
>   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20
> 11:39:13 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-04-rc1-3
>=20
> for you to fetch changes up to 2c98f7435cc5edb2a0b96e9f398c0b7f084e83cd:
>=20
>   efi_loader: return immediately in UCLASS_EFI_LOADER removal
> (2024-01-21 11:24:24 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19394
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hlwRQBmsMGrJNECi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuf/YACgkQFHw5/5Y0
tyx8BwwAkonGHSPtEVAGTQldVcxijzRN9+gj73J4OE1Jqs0joj0PIa73y6RnzlUC
BXWw6HRJOHIVQFTuqBAGFWGgXOGSTXMh+6EZAP8xsMT+tuRviPqfroEf9ZA8gXcv
+HH3xjFYF6brSLhhBam76Zqlrn/1Pt0yU9P2EibNC0jKk54Sxfm3PID12rK3DG/R
eVlBB1YIlT6qGmLoW2dC+OcaiTYVA9+uOCJPPH6uco+43rzIJZ8RoLBL0h1xXbW3
nVV+6+X9mJYJo1zVNHfdqqO5S9opG4Y3oppZZfcwjemGm5m8ai9wQ3hQC9wJuwra
cHFwZsgMJhRUAa2ELpsYF1g7FGJLopz1tSMdYvlPY2//rHZuRgQVsabNTL/7UpUo
8MzBWIRQ8Hw5GacioEB7M0QpUefxZNGKD14b2cA10qsuDBAUb0ZA3oWTYYbH0uQA
zlwzpY4dzXxI9tioS0bv0sNhP+PG2EpeNX/7Z5PoXTY8ylyLFZXU3xWSxsMmoO2q
TXIAG9kA
=S2WF
-----END PGP SIGNATURE-----

--hlwRQBmsMGrJNECi--
