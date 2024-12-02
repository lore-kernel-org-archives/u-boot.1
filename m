Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81457D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23AE89336;
	Mon,  2 Dec 2024 15:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aCcuMjfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905AF89330; Mon,  2 Dec 2024 15:16:06 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ECA8919F
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d884e8341bso24068556d6.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733148963; x=1733753763; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GSJsaEjBDivqgeX+Ps8N2v0FRCSpajSJo7XEFdZ3/Wk=;
 b=aCcuMjfZluYmRRiyE5KMBrAsWcAvXkMRj9PsMmbnM35kBgnKmocJTyS+zOE5SJroHm
 DWopGiUjqfBx6HS+jZm9SUZoNYMB39VcfuLAfMgpNHL1ZvoQCdexVyixp3Kyu/kH4iSO
 LAXLHmpdKraryds7uGlDBx09rYN1cPrbPZ0SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733148963; x=1733753763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSJsaEjBDivqgeX+Ps8N2v0FRCSpajSJo7XEFdZ3/Wk=;
 b=SkjO0Ep8sS6fsRrOs/EywYzeB8rmfA1k7mmTMcxCSkipbesvHILcfkNq96DBDVKV7f
 AeJRQ92tkjgRhIqV09E+UxKBCb9dWjlwmNsgW4b77Ajr9qDfX0BqAzeetU/b+hcp+/Ut
 530xD/NP3ySKFmOSDSpgSEEpL/SerDdjuAQMKs16jH7dvauyDaLWjo+H0zJdHNnbFZix
 v6rFTR/O+inNQbsfs3K2gG3Km8SjiJTPkjgomY5ZGn9L18m/xkkFV8gjoZXbyIOGVDIl
 hQy5f+L8ky+thp/jlS4XdWEvJapN+gap9AY4OYBm936hWrwzvoSNCzXM7gnjoNCLQ55K
 PRwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyLBS/7waQD8Uit5tOh2NwvKT9vObjOAu6k7wOiTFX8gzzzra0EwvJ+JKZ2j6Klmg9TlN6NPE=@lists.denx.de
X-Gm-Message-State: AOJu0YznheVRzlNSv2mjTl6OEkpI/ZUCboeMg1pHgEOf6wST24qLgLv9
 Ysjp3oEnWfdZFr+jORiB+P0hCZtMKwNWZegYgqAYxjPgNdhwZybuzWLb1YbWDlc=
X-Gm-Gg: ASbGncsb9igm8MfLW0p0nQ25c/EK27yThZYChPOgvaSd2DRbcvLDfUWbrO92tI2nHwo
 8vIXjwmbdWDc9rz6lyt4lAgKCPq+wBccI05N5VAIAVP+ib+cKEC2z3145ZBVa+0kD6UZkwwT8m4
 5v/TgtSaNBzd84A0V/FTKmTgLFo8KigHIzGflEv1dnaZL6vhMhwlJMPcyIUYRNuSwjtXp80gfF/
 DtVBn9QTxm6Utw96L+kbO3FjNltptIZQO4NwQn04gNYGQlShg==
X-Google-Smtp-Source: AGHT+IEoi8/r6kDG4x0QBmso55RJGJu9rQq1FWnGk9pcJjUPqpW7uVZ2NvY4avhMd6y91V58PWlOxg==
X-Received: by 2002:a05:6214:626:b0:6d8:b3a7:75a0 with SMTP id
 6a1803df08f44-6d8b3a779f3mr1811496d6.47.1733148962584; 
 Mon, 02 Dec 2024 06:16:02 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849b90bfsm406447985a.108.2024.12.02.06.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 06:16:02 -0800 (PST)
Date: Mon, 2 Dec 2024 08:15:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
Message-ID: <20241202141558.GD2457179@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lfSdiiiFYjn1vfgh"
Content-Disposition: inline
In-Reply-To: <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
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


--lfSdiiiFYjn1vfgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 01:24:27AM +0100, Heinrich Schuchardt wrote:
> Am 2. Dezember 2024 01:12:36 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >It is a bit of a pain to log EFI boot-services calls at present. The
> >output goes to the console so cannot easily be inspected later. Also it
> >would be useful to be able to store the log and review it later, perhaps
> >after something has gone wrong.
> >
> >This series makes a start on implementing a log-to-buffer feature. It
> >provides a simple 'efidebug log' command to inspect the buffer. For now,
> >only memory allocations are logged.
>=20
> In my previous review I suggested to move your work to the level of the l=
ogging library lib/log.c.
>=20
> Why are you reiterating your series without exposing why an EFI specific =
solution. should be desireable?

Even with
https://lore.kernel.org/u-boot/CAFLszTgE_HZEbG7B09_oo=3DXfugvH07ix=3D_0eoSG=
aEQ+KhyA4Qw@mail.gmail.com/
it is unclear why this patch series rather than either/both:
- Expand CONFIG_LOG to have a "file" or "bloblist" option
- Use CONFIG_TRACE

Do not match your needs. Especially the second option.

--=20
Tom

--lfSdiiiFYjn1vfgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdNwRoACgkQFHw5/5Y0
tyzdlwv8C7u6Y5osdpIVrtJjcT13A9HjrsSVtMjP+4zPe4/PEKexCib6CqyeNFDA
sW6zradTcfM2TmeD3UrgDAQ8IFck1bDvSrrtHp3mLqTea1IyFUIJ5fIwgChOH0bZ
eH5JCNjt9U3pOfEMK2eouNbewQFqq9zTl9mow2smEXnsJJxhHaK1si16PaVghVA9
Nj3AJNmaLnd2bdJ7t+tGz5FcA1sp2k1GAZdmPPlLQ1yhrUsDnu7pun+5sSHmVhAO
DGc0xlmofAa8dOasEp7uP5VxUvrx+URAt8WbqQao5w3AU+o4myZ1sI58H+q9r1sB
N5WszPxPnHuSN19jOtM03NRUAvwCr2vakZb2yOKscjgIiP2x3+5iGCiCS1fyHsUK
MAmZ9HblY/l74FQlhdh+fRGSuQ2kE9r8IppSQX9oQssSRI3ajROTC39k84NvtzNd
5qmaNhNsd2+G0yu5iBnWWOqRApVrRbEicKrBwNGxwve3ZYvn4Qefz3b7HAFwvyYy
lE0f2K91
=zfUg
-----END PGP SIGNATURE-----

--lfSdiiiFYjn1vfgh--
