Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA311C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C566864CD;
	Wed, 23 Aug 2023 19:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EN9bccBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD8386473; Wed, 23 Aug 2023 19:43:27 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7463D864D5
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58d31f142eeso62647327b3.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692812602; x=1693417402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v3nYrOsNIwiEj5xx29VBYqBwCuDxD07ya+YifRRIxJc=;
 b=EN9bccBUdKVs+HMFzVFjbhrEGcyQoiuWT1t71CzN7BzvcNGW4g2hRBUfO9+nRMO2/q
 v9UHw4lUsGaI4mPH5MFFVJ8KnOd1jgC9sTa/qFc0PEWYnVbtsDHsU9PDUjbdGDRshBOm
 plxauAZ/2wNkkLuk90V9gylEM1Te/aYjT/e64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692812602; x=1693417402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3nYrOsNIwiEj5xx29VBYqBwCuDxD07ya+YifRRIxJc=;
 b=EDBbr26vmUiZ4fUqb+4LcxmvdAzB3AiT0DPFdDAnawItCAtxTQ3lqJifVDxp82xigA
 UcubqAtcvsCYfK9PVOwaFVu3whS16ht/snRXrQ3MqGJUWQUJuQFNXUzjhLxKtPo/wkPD
 NSGGO0bc63PHqCyR1YcgGtHH7Tii+NKBYxJIBdbnBN3hh/gmoja2f55K8BZzNTRX/MMR
 m6cdqZd2go05rlf++kiyGuuA21x9Z4VdSvr7LEJEOHgCrlV19h8X/qiyLj4y8ZSftp9B
 laKyx58TPBogeZ94oLcABd0Uk7Tl70hTR8sM/n765XU7Eg3DzjPcr6zE4Ddy6VNg7Q1I
 5Ieg==
X-Gm-Message-State: AOJu0Ywm/saShthaGJGl5Qdh+sCopYy7yeGm7tBG+8yBUY+n3+iuleu2
 MGsLOFpiQEsf8WTnt/hOfUjXXQ==
X-Google-Smtp-Source: AGHT+IGnFpR/UH5PAVfS6aeTq5SR6UIcar8oCnefRq06W9emYen6YVIL/k0WOZ1axT2dkZoaiIZHRA==
X-Received: by 2002:a81:b661:0:b0:58c:676c:b3ef with SMTP id
 h33-20020a81b661000000b0058c676cb3efmr13820291ywk.6.1692812602225; 
 Wed, 23 Aug 2023 10:43:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 p66-20020a0de645000000b00589dbcf16cbsm3478692ywe.35.2023.08.23.10.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:43:21 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:43:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 1/3] Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
Message-ID: <20230823174319.GU3953269@bill-the-cat>
References: <20230823032107.1792-1-wiagn233@outlook.com>
 <TY3P286MB2611136D3ECB23E5003256A4981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NoXuFcpOJZry+N5S"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611136D3ECB23E5003256A4981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
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


--NoXuFcpOJZry+N5S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 11:21:04AM +0800, Shengyu Qu wrote:

> Add SPL version of SYS_MALLOC_CLEAR_ON_INIT, this would help devices
> that need to clear ram before use to work correctly.
>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index 91170bf8d2..588acbaf9b 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -372,6 +372,17 @@ if EXPERT
>  	  When disabling this, please check if malloc calls, maybe
>  	  should be replaced by calloc - if one expects zeroed memory.
> =20
> +	config SPL_SYS_MALLOC_CLEAR_ON_INIT
> +	bool "Init with zeros the memory reserved for malloc (slow) in SPL"
> +	depends on SPL
> +	default SYS_MALLOC_CLEAR_ON_INIT
> +	help
> +	  Same as SYS_MALLOC_CLEAR_ON_INIT, but for SPL. It's possible to
> +	  Enable it without SYS_MALLOC_CLEAR_ON_INIT. It's useful for boards
> +	  that must have particular memory regions zero'ed before first use.
> +	  If SYS_SPL_MALLOC_START is configured to be in such region, this
> +	  option should be enabled.
> +

Please fix the whitespace here.

--=20
Tom

--NoXuFcpOJZry+N5S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmRTcACgkQFHw5/5Y0
tyzeiAv+Kiv/L4ZgiL7agjyI7B/jrFvtY8er6EM2EEd/InpCJhgpOsgc+gatN+Z0
5tNOandld1iHhtdnrehdX+NtB5P2HfpZCNExPciJQHZ9anU8yuZPj/AVssldW8Bx
nsSTyMhq4iEeWDfIyVr6Jqvw2uaRb9uzlsPPDiAsAKY7hazRdE3aDGYsQdZztM9B
fOTOSqQrSrnJ628jzPkSHw4wevDvgAxp2wl+Bq45C1ky4yoSysrZvrGvyc2d4tVB
bQvgYxyKuqX5EZXHttB1xmZQU5BQjiLBzlhFkREJm6VITIyWFOk8K/A6NakqY5CG
bbyZYCwBcuNyt3clANUZFuRDWVUG+bJuzSC4GE+8fbDFk9HpKc//2WLF9Owy26Km
/dLBqKYsuXHpX6PT+CC10njVOq0YgxCDjqrehVwWmHftEdiT70lywQkWcXYeH91t
uREg7Y6SLOhHbfxDZh3qo4/tkdkx4Pl+qB9LYvMl0lHroS8tMpeIAMvu7eN2Z/u3
o10/YOo0
=Y+Bb
-----END PGP SIGNATURE-----

--NoXuFcpOJZry+N5S--
