Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD7FC02184
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 16:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD36801CF;
	Mon, 13 Jan 2025 17:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W9y8wHpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24589805DA; Mon, 13 Jan 2025 17:48:31 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA09480141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 17:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4679eacf25cso30661791cf.3
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736786907; x=1737391707; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+x3XrTIc3qJl//3FIMK4wOelQLqbvFIjODF1zWPGO6M=;
 b=W9y8wHpadjR/Xaj7r/ORCg/b0b1Tzaxs7rWxQr2Ye0fglRKhvBYy3dq1XR1L3klKdY
 aFoQ3yEc5s74HSPsOtH56ufdbkjhG1Jnz0Pik4v0aU+0AVF/ubrqwtl1m2PyS7i6RdVc
 Ctlw4OogUwV6Np5VDAWRdiX5kj2mizWtDQUko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736786907; x=1737391707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x3XrTIc3qJl//3FIMK4wOelQLqbvFIjODF1zWPGO6M=;
 b=QWGtase3wYsLLhRPhu0C4Uszse9iS4Y5U5TfKv5aFNRzgQ2Uf5dBkFe50K/GtoEceG
 TUtFNlkMI/fPcSee3WkO1dK1vnbWWQwCNWBrsV+c8W/QxEuMjy547DtmHtTeyNtAE8yD
 R0tLbXcLlSunZxHuj3qM2jTbG6k27gC5Kxl5CSVhBBFypgvv9CPr0FnRAxQbjugwoEl+
 qvUpUrAljn8SVLGLtnXqRUfmm3+UicouI6RmJyHHTlzMiNOoVxPNMUL/d6QBGTU+eFtI
 +KzVOrJcTQ9/GBe3wJFdjT8imw6BPDHKG0HBsy6jwtVEMOzh/wtxHiMWEe/CptpSjUCJ
 VpaQ==
X-Gm-Message-State: AOJu0YwnDb3onIfpVsh4Ym31vYv6S/Lx1oPF2gCsh0ruUw9CG7V2sC4x
 AiO/kNP40K2y411BYUZXOemBmLrya3Yp3NkzRh8GMI6oPua80wU9wJ7HQO1PLLM=
X-Gm-Gg: ASbGncsPcTdEiHMwe9L7SebT4lSfcGpwG3+Fb+efQmQXn6Uoxtu/WQkdVVS7iao75Ue
 oGAqydf44K9ODY3BHD8Azt4AZziQ+V+vsdrGeRn9jo6T4DeBVYl9k5v/yviM7tMdOibRCIw999K
 A+jYVBHaUSIONpTLOmC+Xn1rXL+2Cd+wror9JPBiHgTMXrqHZMzpmn4ITyrqw6rMzkicVW9TVTA
 +4JLDtStNGSafVnpB5Oy2OiLgSiylZp407G0XEtZTtcapDIxv35k7g=
X-Google-Smtp-Source: AGHT+IH+fg5xsvNHACOi9gnydUpMfUgEaiPEMa7mhHs9VeWLCo+sETkYQTDYJ/bEkVl0vG9aeIJPdg==
X-Received: by 2002:a05:622a:342:b0:46c:782f:5f85 with SMTP id
 d75a77b69052e-46c782f611emr341923051cf.52.1736786907602; 
 Mon, 13 Jan 2025 08:48:27 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873dc8c0sm42799591cf.72.2025.01.13.08.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 08:48:26 -0800 (PST)
Date: Mon, 13 Jan 2025 10:48:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20250113164823.GW3476@bill-the-cat>
References: <20250113001853.296787-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pcJ4oUr4jo+54zJz"
Content-Disposition: inline
In-Reply-To: <20250113001853.296787-1-marek.vasut+renesas@mailbox.org>
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


--pcJ4oUr4jo+54zJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 01:17:30AM +0100, Marek Vasut wrote:

> The following changes since commit bc157bb6667ed97e33be8ce8436c28baa275b2=
95:
>=20
>   Merge tag 'u-boot-rockchip-20250110' of https://source.denx.de/u-boot/c=
ustodians/u-boot-rockchip (2025-01-10 18:56:22 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 46a7999160da3167497e08a444417aea26171197:
>=20
>   arm64: renesas: Convert boards over to is_cortex_a() functions (2025-01=
-12 23:49:58 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pcJ4oUr4jo+54zJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFQ8wACgkQFHw5/5Y0
tyzFtAwAt/LHsEP4rd/jbMgo1mqKLomWO+k+FOcYYF+f9mE2/FdHcr9hehZInlcQ
qYzKEhmZrc8Iyh6B0qRcUtfkQ7rZNbTylrzxnLOyJ8FkI9DO//alFKsUu7dfn7my
oCm+xuXNssOE5Nt6ryzx2tRZvQqdzcMP1/6Y78XDNmv4SxJV+hWUEfyDYSA0tbYH
vWqyij7JYmZRHUOWOfzi/htFOD5hdqt5N4J1wCLc/1cOqVpw+WnMOvF3vVyc4Q+U
trMvafmC+AHjDVOGSAHZIgom6QXn2Wu8Nq92+FwidmlNNAUANnZuZJTL5RO+xAiP
x6CMNNk/uDtvNn5eOZ49mi9KYPiDpOuXOUeans7h6P329XtqCihyj0r8AchCszKQ
MKIs9mkrjuF8YjztEa2ncoaNSUCYANm0j7Jy6dAt39yfvHh7Qc70Vm+s9SQlS8Ss
yO9mr46oP/mFX9GoA4BBo24WsfltNxHMM2Huhq8WDlMP4GJLxcJTlmZCWk/lii4S
z0ysjs79
=wrAX
-----END PGP SIGNATURE-----

--pcJ4oUr4jo+54zJz--
