Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBCC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 16:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B035781F32;
	Wed,  7 May 2025 18:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nx2crNj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251FC81FAB; Wed,  7 May 2025 18:55:40 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE708059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 18:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2da3b3bb560so100187fac.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746636936; x=1747241736; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=apu4yhhrd5qSiWnyioUsk37IBavo8x1Isly6Oh0AAs4=;
 b=Nx2crNj7ml6H2t6k7Bz7z7KjJRXvejQ3nsPMDwpe9Rc0JBlh7HCMfe7cB5psYqi1fc
 YYLsgEslgV4KhFUVExgLljOOUydII4gTKdUJV++RMbxU1Nmfg4iVS/d4CAnYKNuhx3EB
 5ebahCmDWyYvCFKg2lnxkSDLT1UZqMa4PrQo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746636936; x=1747241736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apu4yhhrd5qSiWnyioUsk37IBavo8x1Isly6Oh0AAs4=;
 b=rC1/yVGXNE2zVD7So3xelDAbbu5dERYOhFeeIYwct7ZDh+atjnNHIsX1t2rwIFmX4B
 YvjgdJ5Njxt9DThG3gVIqE7vYFOJdrFUrbQpPozAn1vkro6mzG0ly4rfoj3nhyrtsFQm
 Flx2Ox6pq7/XnzshZd2Mde70eBlDvsZesV7WGgXlluHF1e9+Wq/u9igGPectcvnkn56P
 w8ljhdYIVPaI2V67V4DqN9LJDJJzw2vITaxCEZ+kREAsX4Qld4S46kRI0iR7U4jcc/lk
 iny/AuR9YETJ8hegONfDoSU9IiRa+HSM79ypKDE7xU8Q2ZrZXDxBH55BTciLLUS94rsW
 YaeA==
X-Gm-Message-State: AOJu0YxymRVsW5DpOV4mz8KtUfkVstknrx5hjQ06lSGtK4gbv1T6YHqT
 43zvvHZ88wYZKyK58kjosetthuD3GYBnoiQI8bquSEFFAmRMGrhcV6JXPYJAFZh088kZJZgQxJ0
 P
X-Gm-Gg: ASbGnct8/wRTMolHc5RB2nbzqdr8b/M+ZyVleX471XTFAZ+OE84XrvInDhIeWsbFRsJ
 2+c+LvZ+7XlI5KLijiEq7MY3bZkI4fqyYS6dVQK9C0811y1FgaebbgX/mhQfR7hfpvDzZtkzGGO
 Oxyha3bnxYkB4TasgOXlVMxZn53KF8dct4jgZd+IhV6VaNJPRALfNumdEw8AJx9ZFANVG/0OcT6
 DE9bdrhGpvoVjX5R253ZHpAUAZQN3pNOxVZ5r9ORdGDNlIZS/vEn1h2Lo9HXq31dNeA90yWrGG2
 c3n6M0IdP3NJDLOnuN6kGM8NOZDNGNUJ2J3xda3W/5AYyfLajbR4U65vV+7oOeyrXmC1TmvEmqW
 dTA==
X-Google-Smtp-Source: AGHT+IGA3O6t7rbi+4eLpzM1LkUBaU9V9gP7/+b6eA225BaD72e8x2+u9OymAQdw60SGNJB/qX98IA==
X-Received: by 2002:a05:6870:3307:b0:2d4:d9d6:c8cf with SMTP id
 586e51a60fabf-2db81318919mr117682fac.5.1746636936326; 
 Wed, 07 May 2025 09:55:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cd84c69sm736092fac.22.2025.05.07.09.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 09:55:35 -0700 (PDT)
Date: Wed, 7 May 2025 10:55:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: cpu: armv7m: add required .type name, %function
 directive
Message-ID: <20250507165533.GO5430@bill-the-cat>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wS8TWzVeChnx7xDK"
Content-Disposition: inline
In-Reply-To: <20250507060739.326096-2-johannes@krotti42.com>
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


--wS8TWzVeChnx7xDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 06:07:54AM +0000, Johannes Krottmayer wrote:

> Since GNU binutils version 2.44, assembly functions must include
> the assembler directive .type name, %function. If not a call to
> these functions fails with the error message 'Unknown destination
> type (ARM/Thumb)' and the error message 'dangerous relocation:
> unsupported relocation' at linking.
>=20
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/cpu/armv7m/start.S | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
> index 0c07f2140c7..c20f01a0aed 100644
> --- a/arch/arm/cpu/armv7m/start.S
> +++ b/arch/arm/cpu/armv7m/start.S
> @@ -12,5 +12,6 @@ reset:
>  	W(b)	_main
> =20
>  .globl	c_runtime_cpu_setup
> +.type c_runtime_cpu_setup, %function
>  c_runtime_cpu_setup:
>  	mov	pc, lr

Thanks for making the patch. There's an argument that this should use
the ENTRY / ENDPROC macros from <linux/linkage.h> but that also shows
that we're missing commit 5d4cae5fe2ea ("[ARM] VFP: fix section mismatch
error") from the kernel. And so I'm fine with making a TODO to clean
this up later if you don't want to embark on something a bit more
complicated here.

--=20
Tom

--wS8TWzVeChnx7xDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbkIEACgkQFHw5/5Y0
tywTPwwAuNmqB4rNBkKt32+czu5OIQltajjyQ1nNl4DByZcEXqVklfWAyeuM8hB1
ailvKn368uowoxxAPe8vqCahBC78AdTUWJWlZ8DdpFZKNc8A65J1bX5eU8/7DuE6
VERZd6iPLeiJu0t/WbdkU8nHM5R53b02VCs1fzGYpg5qRUUIPVjLb+m/LBRkmso1
BBFk6mGnTbn9MYHZ6mXMbOzzzfwc7IYw7Us6x2FFDy9yJN8PxT4RJpendnntntVg
X60UyLoVrRp7dMU3pJYXyIyc+vprcD4uCEZOwkBEiycuDcDSaVfJUiKue1Lap+JS
V7OL/gOS37NukGcgVLxAwBit6P1E41ywdtK/YO1ge8tw/Sw67SYtFAVAn4KaJW5w
j84ZDB83e1tbF+A9LX3eW9Yj69P0aFoUmpdoViQsJdJGoOq5NPGgSi1DXER3XDz6
MMj3YQrlSwV67ABGGPqXczOlGe20/6j78zE6kPISxdeB+U8m3Asz+KkCdNdpBF+V
VQ5PGvAi
=yyyD
-----END PGP SIGNATURE-----

--wS8TWzVeChnx7xDK--
