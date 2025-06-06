Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7171C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A23B81F0D;
	Fri,  6 Jun 2025 21:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ov1pqNMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7D782A53; Fri,  6 Jun 2025 21:15:09 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54160807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-404e580bf09so635877b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749237306; x=1749842106; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BIN4AeTWuTIQ5ekPVoPfJHK3tAPhoLd9dozw8o2wzGQ=;
 b=Ov1pqNMGnaTf44TFIZbvqr9oBVpZqPmjmOH2otFxC9DonZpr4QQx5/F1A28FyvMqvA
 QNmoAdAp8w0qnuUS0+79kS6MYNaha5xuKIAX3OMGG8H7EMGUjIVlf5eC/TsrfU/IdFpC
 qvOIzpd9ab4wGqLR8UGpL3xEWVcX3TXis6Pvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749237306; x=1749842106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIN4AeTWuTIQ5ekPVoPfJHK3tAPhoLd9dozw8o2wzGQ=;
 b=SdizqaCj5NQuG4QYA6vuqzToEADKdxs4cyuZq/I+9KgI64WU9/CCula7k9Xv1/NHpT
 QkG4/xsamWfNbhc3rTTod1YjvgKyaWw5XFjZvmvSqoCCwhgvRR/vxYiIfKtDWWyC2tq3
 RhEuh5v9TlPYsXTqfUYwS7MkBGUpghyQJuIJbgdOe7iy5vuV8j5hUvhz1scPe75wDNKL
 45gEGaCFSWHfIuCSPUNG5zMW9w3kehTKuGFJB8Tz3nVH3CvTWYbwHeBrbnCFRymBtU9T
 2Vm1Ka0ad9o3EV2gTa4ilQM0f8aVOXlwygIQSLTxitiLsuYdSPyEXOGR8oTQNOPe5jTO
 zIfg==
X-Gm-Message-State: AOJu0YxBtsPqU57ovZYlZLRK8HdPhTIgpkU7gDuwOf5lG3HhEZHj/0EL
 7Onys8LhLQSpi6p7yPr6ugYHx++78/rVt5tfxywYHPslypKhn4pXuBCcqEFPKCLGaFo=
X-Gm-Gg: ASbGncs7Jf/VisTDea9zKLgj0HbSyR2ORcTziIzxdW2Hl8XJEJlLNIiw68Ez4m0DqLU
 JebQ97EUkNIbJ28/34DC9gfIfaeW2l0xLq/hwsWywUWst9fiRKaiTHaDLo17ez8pA3Qda3lVOlE
 H43oefqF9l8GMBxhg/AH3/QrVnf+8F0EuFNbuSDGzef/RmlQSZSxgEHc4pY5RH7ws+ErZZYbmnJ
 QLRHFtnupy0n7xZuX88l9urWhd7MD0J5rTlxD0rtEDLvJ3en0ljaR9o//MKtZzKqgAjN4MNjjjQ
 26Lt2ZlY/5RFcbXWwcQ892/vJYIqv+rz7LSVNU/2DRNjncE8ewKrt8w43PLXJ63vsE8JjHliyzb
 7dFk0uWl2Abs6O1BQoKNRvcTYweBlMLvO9g==
X-Google-Smtp-Source: AGHT+IHBbV1vEXOIi7L8aZMHNFXwTrKUtWC8BZ8BWPcKzQxrFY8eJZSqkNVhVMD7hXTJdNz+nzzT/g==
X-Received: by 2002:a05:6808:2e49:b0:401:ea99:533 with SMTP id
 5614622812f47-4090521feaamr3571365b6e.26.1749237305916; 
 Fri, 06 Jun 2025 12:15:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40906a2cb38sm451843b6e.44.2025.06.06.12.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:15:04 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:15:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 08/10] mach-k3: common: enable falcon mode for 62
 platform
Message-ID: <20250606191502.GB1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-9-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5nDbO3Mn0Gom6omu"
Content-Disposition: inline
In-Reply-To: <20250603142452.2707171-9-anshuld@ti.com>
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


--5nDbO3Mn0Gom6omu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 07:54:48PM +0530, Anshul Dalal wrote:
> We use the spl_board_prepare_for_boot hook to call k3_falcon_prep which
> is ran after tispl is loaded but before jump_to_image.
>=20
> In here, we find the boot media and load the image just as std falcon
> flow (since spl_start_uboot returns 0 now). Once the kernel and args are
> loaded, we perform fdt fixups on the fdt accompanying the kernel (if
> loaded as FIT) or the loaded up args and return.
>=20
> Now when the flow goes to jump_to_image, we do the regular pre-jump
> procedure and jump to ATF which jumps to the kernel directly since we
> have already loaded the kernel and dtb at their respective addresses
> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 107 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>=20
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index fc230f180d0..70317fec19c 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -259,8 +259,115 @@ static __maybe_unused void k3_dma_remove(void)
>  		pr_warn("DMA Device not found (err=3D%d)\n", rc);
>  }
> =20
> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT) && !IS_ENABLED(CONFIG_ARM64)
> +static bool tispl_loaded;
> +
> +int spl_start_uboot(void)
> +{
> +	if (!tispl_loaded)
> +		return 1;
> +	return 0;
> +}
> +
> +static int k3_falcon_fdt_fixup(void *fdt)
> +{
> +	struct disk_partition info;
> +	struct blk_desc *dev_desc;
> +	char bootmedia[32];
> +	char bootpart[32];
> +	char str[256];
> +	int ret;
> +
> +	strcpy(bootmedia, env_get("boot"));
> +	strcpy(bootpart, env_get("bootpart"));

Since we're talking secure parts, strncpy is even more important, and
being aware of:
 * Note that unlike userspace strncpy, this does not %NUL-pad the buffer.
 * However, the result is not %NUL-terminated if the source exceeds
 * @count bytes.
=66rom lib/string.c

> +	ret =3D blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, =
0);
> +	if (ret < 0)
> +		printf("Failed to get part details for %s %s [%d]\n", bootmedia,
> +		       bootpart, ret);

=2E.. and bail out?

I feel like all the changes here need a read with "and on failure in secure
mode what can someone abuse this to do" in mind.

--=20
Tom

--5nDbO3Mn0Gom6omu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDPjYACgkQFHw5/5Y0
tywrOAwAlKGNMynw9nWanDSnfNNo7iV6QqRAXRf/25hh3oK715Jmi5RXpIk54a0G
omk7q70cqLrxLsHtTHQKR5/30lhhh91X/PYdiGuuNro6CgEPVaOsWOrPBjh472fx
3ULfDDL7C9tWMVcMc2EdJuhwWOT86t4tedT+iYTLxdSGG4gaJWWkllAjoWmRbvn5
fHHDM2IlgT5xrZk8F1MDmywx9Lqh4Sj1yFwQ7WgozAmlW9t8Z9EotF8EY6g4PMOG
HDBpQNw9izw51r5XU0mEDFOjDb1ZwOPqeiEC4oc4PoNUnDO5I/tXoCWPwpkrJey2
qdNc70Ddy0gqObv8Qi/EAkeFolVVdWC+n/c3+atP1fhTkk/oVUQF9rqPlV/pvjoZ
TFPV5pR3iG2ZVqWj1Tn3h53pcNLnBJ9TsLSZeBMI8qKi+G3IXC0uv1c0nIx087wY
JfVdOMnX3MitWAdNupeCsjZoz9ei+4X/XDk8NgB1SSzxueUXLIxlysqomocktInk
uOZpRmv4
=aGDX
-----END PGP SIGNATURE-----

--5nDbO3Mn0Gom6omu--
