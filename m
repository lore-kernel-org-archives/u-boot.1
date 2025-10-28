Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A947CCF9EB
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E96836D3;
	Tue, 28 Oct 2025 17:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lOFkMcUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D990836D3; Tue, 28 Oct 2025 17:51:03 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B5680422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3d357d115dfso1612351fac.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761670260; x=1762275060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wFYqd5kJF0c4Mq2rlrFSvyFuoVHaMZ1KOEhhiTtw1vI=;
 b=lOFkMcUXBHn453VINMtTGbcsz+PbcngYEu4wDAdGHveG6ceKMnzsZ9FfhQnJas5JCU
 yLwfZf1SdEFq4r8N8xEdeHlysTIRY0P8BXqyP7m5J2TuEIxRLCgTKP3NNLSqA1ag4Cbg
 t/g+40hJ5bfrriQaxrR6oTleJBliEqopqRKP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670260; x=1762275060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFYqd5kJF0c4Mq2rlrFSvyFuoVHaMZ1KOEhhiTtw1vI=;
 b=oGvwWCdx7D4YG0GtM0xG3j9r8gg0JVcM3iPDUv9BLKH9y2QaVE39E5PIBt9ouod/k1
 /WJEVJsFBvmzZ05ik0/2AJlndV/weSLABCXnBf1Z515uVDueYkCclIpJ2dtRXIEIloSa
 C0vrzNZv2uBjsdBdXRAukT3lSiEdlFa/rth3OEXdigKCNp6OW9UdGM6AgNuUZfvr/Y5f
 8XF7WA8iltALGh9soY5Es5uqxub6CtmUDG6JXI44FXYO/i+T4U420qUu2JbfaxplwC/g
 Pk02NerCYuTa7KfJ/QY6qn3axE18Yfr1d7GFjQe3Zcb70noXoF7D7/6edvNDILzDNS1+
 NSjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT+X7BQZrO+VuvtQMJTSNTmH4L8KMZN+YiKsfHbgpzyM3dfd0R8/CJFRmB6HwtvfUa8SYq8hY=@lists.denx.de
X-Gm-Message-State: AOJu0YwlB0rmhUZBDq59iIoFpCObnYv1dhkUr+HYIvfRBrb420a6PbsZ
 EmBq2qsME0who0Rem09WqtEjeLjPHGuKtoGwvaAxrSCEgB3+i3bVnLH2ay/YcM9u8dw=
X-Gm-Gg: ASbGncs9GqYVWKbE7nf7gmvBHHxSjAaeEcesjwoclW4vE/+Wqnf+OjzUOChGYBvYuxI
 QCujsEUwCTGikrkGHviQXgdXRiEwrUwl+I50Oe1O+BmanjW216fYz4JfWFHw7P12bxBYMrCvqh3
 2lW8X5AIIj3DROUnGAQK7+nRCwXm/j6ge4zzQY9mk/Ob1UoyTFQhtrbPTpLcNPrKPD+t/IyihCj
 VtNuDcuWv/SK/yZj4LArk6Bm+EbGNZXn35iWe/PFeFBH1/72AhX9mM+EMJLdECB1oA7cPUiKZy0
 eyoFj/UoLOd4MMh0YZompz1nJ8WXb5OddjEGPACEHzQVuEoEQWh0BCURHOhPzPXkaktMFRfgBCi
 2GdOlJXw2AAPAMxcJ3+xxk68LsUluLvKASDAmfdSck2cmSvDlf9IlGAL0q0LC2FPQ7itWcIOimx
 5nOd6DcawWg3PXFGMAFB85UNIreiTLctk9sbWCATE=
X-Google-Smtp-Source: AGHT+IF/nnv28p9/OPQRofhvPsQ1NGj2jZ+VErMa1NUZheX4yuHCIQ0uPM6m/VeVGWgJZd6JXXsb4g==
X-Received: by 2002:a05:6871:71f:b0:3d3:84a6:652d with SMTP id
 586e51a60fabf-3d745b8a545mr10392fac.3.1761670259719; 
 Tue, 28 Oct 2025 09:50:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e2816b32sm3754933fac.9.2025.10.28.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:50:58 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:50:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
Message-ID: <20251028165056.GG6688@bill-the-cat>
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1bVjdN1Tpd+jJZrZ"
Content-Disposition: inline
In-Reply-To: <20251027002458.16741-1-semen.protsenko@linaro.org>
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


--1bVjdN1Tpd+jJZrZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 07:24:58PM -0500, Sam Protsenko wrote:

> Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduces
> inconsistency in how the countdown is displayed. For example, in case
> when BOOTDELAY=3D5, the next output is observed during the boot:
>=20
>     Hit any key to stop autoboot:  5
>     Hit any key to stop autoboot: 4
>     Hit any key to stop autoboot: 3
>=20
> That happens due to different printf format (%2d vs %1d). Moreover, the
> mentioned commit fails to handle the case when the user is holding some
> key before the countdown is shown. E.g. if BOOTDELAY=3D101, the next
> malformed output is being produced:
>=20
>     Hit any key to stop autoboot: 1 0
>=20
> That's because the fast path code wasn't modified accordingly, and still
> tries to erase the number using '\b\b\b' format.
>=20
> Fix both issues by introducing a dedicated routine for printing the
> whole countdown line.
>=20
> Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

This seems the reasonable path, given everything in the following parts
of the thread, thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--1bVjdN1Tpd+jJZrZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQD0bQAKCRAr4qD1Cr/k
CqelAP9YcA0hVOqfaahnfTPUyITklxevh0jH6BLqD2tJlJgT2wEA504D2pqLMqV6
0smEg88yMSOTs1NAJHEhehmpsy0pIQc=
=Idzv
-----END PGP SIGNATURE-----

--1bVjdN1Tpd+jJZrZ--
