Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53820C3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34D886B96;
	Thu, 17 Aug 2023 19:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k87Kn5WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7882A86BA2; Thu, 17 Aug 2023 19:45:13 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC42A8683C
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58c4f61ca12so758557b3.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692294309; x=1692899109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=62OxxHm22Ya0t9AnnL5xiuqfN8P4jfVS+jIwJuBu58U=;
 b=k87Kn5WUezARBvwPNZn+Vt50WP6rahfNJyIg+b95oUS7CIX5LMu95lW9QY3yeOExkt
 4dcj0tA/ZVDuhAa1B1O9mEfRIS+HfXQi64BmSQBR3aUwR0xnVe/nKIPIyAU1Qxx6D4Al
 HfWu1VkO8gdpjbOvfkjp23UxFM90J0pd+N1Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692294309; x=1692899109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62OxxHm22Ya0t9AnnL5xiuqfN8P4jfVS+jIwJuBu58U=;
 b=J0GbTD7laeFgI9qCLAU2pFRXuTjg+Ugs33DAHJFhk2hmbn/JGfC4d/lho25r0rFYtz
 pugTboCCR52CtkCYS9lCRUBUOozPR77vF9EN0g6I2aWw/RoNOJW7Ly08vr21kMSY3xpW
 jYLsP8SutMSQdQo45usD0+KUabKX00RH/ljmui89c4a0j6nZnPoyy7bltDDFIUh67ghl
 FVLC4nmrIfunUXQ3yzR32Ru40JEGnc6apc5IBjSop93w1gLRRTngWSTCijwzzPs53d+6
 6oeEsLYCNqIjqAtff5zB7zTSBYolnitjUdO2oQCkqNDK9PgwimdrsvrSUw12iYlaB3p2
 MgyQ==
X-Gm-Message-State: AOJu0YxCEgVLF/e/etMWb+4iWQAY1DXB/P7E28cdLPfqFPGTuhxw+CcO
 J/+heTNPB9Nx8tlN+5zD/Pu/XTpZBn3f6I/T1j2LMw==
X-Google-Smtp-Source: AGHT+IH3g21h+02l3CDyIkfhU2y6vdeZImho6blVYSPpKDDSdWncwBfZsI96VG9j2KX6EKJG62sGmA==
X-Received: by 2002:a0d:ee05:0:b0:583:6839:755 with SMTP id
 x5-20020a0dee05000000b0058368390755mr64224ywe.14.1692294309498; 
 Thu, 17 Aug 2023 10:45:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 g72-20020a0ddd4b000000b0058605521e6esm4436ywe.125.2023.08.17.10.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:45:08 -0700 (PDT)
Date: Thu, 17 Aug 2023 13:45:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] spl: provide weak empty stub for reset_cpu()
Message-ID: <20230817174507.GJ1515023@bill-the-cat>
References: <20230817143540.23525-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gNlyR0paWcpzGCDC"
Content-Disposition: inline
In-Reply-To: <20230817143540.23525-1-oleksandr.suvorov@foundries.io>
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


--gNlyR0paWcpzGCDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 05:35:37PM +0300, Oleksandr Suvorov wrote:

> This stub needs to link SPL properly.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>=20
>  common/spl/spl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 0062f3f45d9..781858891b9 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -1026,3 +1026,11 @@ ulong bootcount_load(void)
>  	return 0;
>  }
>  #endif
> +
> +/**
> + * Weak default function for board-specific reset. Provide empty stub on=
ly.
> + */
> +__weak void reset_cpu(void)
> +{
> +	/* Nothing to do! */
> +}

NAK, there are already architectures and SoCs that have a weak
reset_cpu.  If you're working on one without reset_cpu, it needs to be
implemented one way or another, not like this.

--=20
Tom

--gNlyR0paWcpzGCDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeXJkACgkQFHw5/5Y0
tyzChwv+P/GoOt9ZaTFuBTX331SbYgeZUfFs1myEEgctF3irTbnKcHWef32Vzjva
jp5rbQjj5+UQYfK3I45uDlAvhpuAdCI3c7HUb7E3RVNWkUcYIaIsECtCdkh+z8QR
C3DnyZWD13YYOf0gk3ZEI6Gn/gdpMnkPReROlo3T28Mxoxx4GjOxzWftsZ/sNgY6
SjTft0mSyAJyFdJLmZgqwbpsX2iGX3cDjSuNJGOld2RSZ6gP0/VP6ccWjWQ2bAD7
GicQlXGyzeSrXiX+qxnYX1Wqi5yrax/VD4vHQ4vGUAn/HyLoLGQF0bOxSbl/abEj
nE0LHAIb+WEVd6YLlWhQQcxjiGc9QesiCqoB76E6MRjgf9n7IAkxqxv2lxJDX8Hx
3vbBoi0bFl2P6jjeBPwdehY843PvAsNP2ulEOCeEVlAesLQR7T00VI25SysJOohL
oHnoYBe/DiMr1Vq6n33IXrJNOVmZ9keiMLk2xurHmBwzemfjhrdAcwWVxOKIZ32j
F5XKVteB
=7Dhf
-----END PGP SIGNATURE-----

--gNlyR0paWcpzGCDC--
