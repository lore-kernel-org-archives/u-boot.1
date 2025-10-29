Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE898CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 19:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5181382A9E;
	Wed, 29 Oct 2025 20:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eVEC2VJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B30D832AD; Wed, 29 Oct 2025 20:16:10 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151B28004F
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 20:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d275090417so202968fac.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761765365; x=1762370165; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e6mtDtq9Guq1rCcRnNl6jV00WeWHZ2u20qwBf0uvZhA=;
 b=eVEC2VJUDUiKpyqeVLXT2bHsAOhIy9a5yQtIyMTjkwyb10s0QyTHyN5d4yb/RFrtLL
 KdOGgYiHIC5I3yban9KOIq3bTDNRtHMAP9xWBivykQxgP3JkxYfHO85Mt5QChsf6GXxk
 IuHQPhHzXL38CZiE6HjGzkCRwAqWqEv5Ml5NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765365; x=1762370165;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6mtDtq9Guq1rCcRnNl6jV00WeWHZ2u20qwBf0uvZhA=;
 b=dyWWfU5HxdU3AQZUG6BlxaG0gVhllTJyIjwBkMbElTaMrbacQT0pLNQeiAq4u5ZKtR
 rYzuEajA9BXOqCzgqJ6Pr9jkBMaCFmMwtkErup5KPxP/wVv86jLB9nOZSJpjcrKttzSK
 Xi5QFyBuJWcjfh6kKaApME4fJeRh2hEUdHu00geFceb9kxDxvcLWvks/FwYnbaJhy3bb
 mkxplAk1j1+PPWmGy3YqzSyvszaOJzA/1SV2cFqE7I4FqC+ZqWJiZ2mMC5P713tNvRjr
 SHbimO+Iw10EFDVw9pRyMSr+ta41DWsegRbP6vKcqceogHXtaFVO+UIquUHvIRG1vVbW
 32iw==
X-Gm-Message-State: AOJu0YxI4tH84Ghnlr2a5QMotD6emjRXkeicBKFmnhsUTCL2W3tjSIAH
 cJyTTlOMkHtpeU1tSOkIqPGSFNRJZNUhiTa+nKg7IndRJqsrb08P5pUE6FIZv2/IUhs=
X-Gm-Gg: ASbGncsXojAJwkCS0rmd9XUpph3lrjkS2bB9fXz5y/0b7cnfMIjX6j7UZQMdv9Q6ZGb
 iYW+pVtoB+/20tCfnnKanetPjlVIGrQv8D+JBKqnLD/aIXf1WCW1TnrxLN/6X2fmMCPbwIVPWHi
 Ek8Bp7Ge8C+NIK3DYuX0J2Wfq58K29HM4LRqhDDU+zyojG/NfaCFBwnU611PBbuJhBbE+5XPkHM
 KqWrdHag+NOSKISV/AhzIuGBJhbQ0jHoOFT1bQQ4cbF16Kh5fpqcKFpXrBN6Umo4cRpM06sg2Sy
 fUjj630yMVQIg9AlyuXk8CWdz0SI2CH2bjda5DM4nK9vyqkpDm79dKNBrXlesPi3PsH3ovnUD3u
 6HSrKhjk7iUyhAV9uwP8xXy+sy8EF5vRX0nuq7a83xiA6GMfWdffjiOGT81hIxkpKJ78bGjGyoL
 JnQCVt9l7mpERl8wxrcSE/LVk5ZagY4hjPW2T5+Sw=
X-Google-Smtp-Source: AGHT+IFTTQ99q4bc8FzApt9dHNL5lpFAjQ+q920TNZS2B1DN2e8I11ODwynFvnVrysFd2Oxo16Ui7Q==
X-Received: by 2002:a05:6871:81e:b0:3d2:ddfa:dfdb with SMTP id
 586e51a60fabf-3d8c634958amr309067fac.13.1761765365404; 
 Wed, 29 Oct 2025 12:16:05 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e2d24eb1sm5003244fac.12.2025.10.29.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:16:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:16:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] serial: make VPL_DM_SERIAL depend on VPL_DM
Message-ID: <20251029191601.GO6688@bill-the-cat>
References: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NBjCwPQWHR67Vj9C"
Content-Disposition: inline
In-Reply-To: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
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


--NBjCwPQWHR67Vj9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:17:43PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> I have a hunch VPL_DM_SERIAL should not be selectable if VPL isn't set
> as implied by the prefix. Additionally, still based on the prefix, I'm
> assuming VPL_DM should be a dependency. Since VPL_DM can only be
> selectable when VPL is enabled, only depend on VPL_DM.
>=20
> This mirrors SPL_DM_SERIAL and TPL_DM_SERIAL so seems right to me.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NBjCwPQWHR67Vj9C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQJn8QAKCRAr4qD1Cr/k
CuEjAP9QCWTYHJT+fPct4VI6Sh6Ythc2Szvmt9iMlRkU/Qn09wD/SJWvfNKJ8j/W
T/aIi4+2UZ31WGvMpb8fKdCEKHpd6A0=
=MSXx
-----END PGP SIGNATURE-----

--NBjCwPQWHR67Vj9C--
