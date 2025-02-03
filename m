Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279D6C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 955EB80243;
	Mon,  3 Feb 2025 21:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NaW771+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E962E805E2; Mon,  3 Feb 2025 21:09:18 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5CA8070F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6ed0de64aso418197385a.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613355; x=1739218155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S6WCwIkCn+zVhfwCL4vG2gU3XA0QsMMkWUDf5oTE/L8=;
 b=NaW771+4cvHDTujPw1YpuHE1ghEU/4ZYpZlXACM13KWI6r9CzGx+x9PxxrHyPhhcuC
 r70Rp15Nbe3O8aSHnaGGF/dNxvnbpH5lCO74xtRiwIkPnrRicwCFWdSE4xO9giZt5aP6
 60JmqmC9By62zepkFszaoxO9Tl6Z8wDSpThkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613355; x=1739218155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6WCwIkCn+zVhfwCL4vG2gU3XA0QsMMkWUDf5oTE/L8=;
 b=fpO+NXTQZTggqFh5K1yxtfWb6n/FaAAgZhI3gmVe/BgP31OFAMsNOv7u3/Ns8TNYJa
 NmLiU0RhBxbhn8I6ZanyAHLeAxcxphLenaIpcbJhhFkzNddqpc5aQhd4lD2fdXIfT38u
 CnBarGZ4zk+eWrgsX2b/M36Tg7rIK4Ye/RQEk4fMvZyUcBvuS/IXbE4f0/sD1OAqKNE7
 8L9M+EmDYr99EF5qCsPdy/1ko6EzGOS76Uj62aHgrKE1v2fijvPFcQYEBpUwZ6PFKXtX
 5GThaQuDk/9GVduET0k2n8k3Ia/ORsCQyC9lZgnVTwX6kLjlc+zKtUWnzm/2FXZ8qGaC
 Pikg==
X-Gm-Message-State: AOJu0Yz3mRHzyFPecdPLCsrliYSw84zTdgzIhNdXnDxraqA29tsaTtFy
 meQOip0LCZgv8HlAYAyoQxMAoF4h63fReDBdYfYaefuZL8GRfWxQBY2R9ncYxRA=
X-Gm-Gg: ASbGncvX0m+FGiDPsjOtdNj3GDOhnvscg8FzhaPp7CsYp85g58QSL0mtDwJOniTaXWz
 3ATfJx78Albfv+5RtIamy4Z02lSd/ktnUxmkkTMQG3RsWNmIVIBF9t2RIH+rVOU6EzJ3/nG9YWN
 AqvRbtK5eeWx6CkarBtwTQoVNOCgzmXLO0UUcJ3eXpaHvSQDCvOKk27IPY0yDLMedopMuUt6DXm
 9QRHBoCBEojh7KgAnIP6qBdCHM8HTzQip3cr5S0FbKfxkpjtF/k0ZVfjZrlfoZBzgSw3vzFvNVE
 r2Tk3cFVFiSifPY=
X-Google-Smtp-Source: AGHT+IGUvC1/duLK/tNpttb4laYdn0wa7+WfBXtp6R0WXsYILJYfvdJiVxAZFB37t/8JjBkG/ZMzRQ==
X-Received: by 2002:a05:620a:2706:b0:7b6:cef9:4f10 with SMTP id
 af79cd13be357-7c02ec0f9eemr115923885a.3.1738613355024; 
 Mon, 03 Feb 2025 12:09:15 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8cf5fdsm563522085a.35.2025.02.03.12.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:14 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/32] efi: lmb: Avoid access to _start
Message-ID: <20250203200911.GI1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-16-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XIISR4hyMpH6DxI/"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-16-sjg@chromium.org>
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


--XIISR4hyMpH6DxI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:08AM -0700, Simon Glass wrote:

> The app does not have this symbol. Also the memory where the app is
> loaded is not under U-Boot's control. Disable this reservation for
> the EFI app.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  lib/lmb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 588787d2a90..420eae4d0b8 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
>  		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
>  				  LMB_NOOVERWRITE);
> =20
> -		if (gd->flags & GD_FLG_SKIP_RELOC)
> +		if (!IS_ENABLED(CONFIG_EFI_APP) &&
> +		    (gd->flags & GD_FLG_SKIP_RELOC))
>  			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
>  					  gd->mon_len, LMB_NOOVERWRITE);

What prevents U-Boot from overwriting itself, with U-Boot commands? Also
how is this linking today? I see lmb_reserve_uboot_region in
efi-x86_app64 for example.

--=20
Tom

--XIISR4hyMpH6DxI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehImcACgkQFHw5/5Y0
tyyINgwAixmqMcr9s+q0G3dc//Bhr1P1wub9cHfPt7b+mTyH3hc2krPC8vOOqseJ
rl2b6n5ZmrtrSHb/DdmX/eleLu/7vIPYuK4tVVaQKiRsTIBuUT/EtQAMabGXQAyo
MApNCwgHto5jdVvg9+vKRiNv4/YS4g3fYwyWJz3Q4Cez1X6dg+xqRE4Uk9DvGTph
1i2qonjKIxhMWL23g4o07TwtWrYWrBcou6T7DEyrwTLGEqRdaEYUScG9ZkLz4MiH
efRzoFfYTe/KiXaWZ83ddh0Pxjh02XYi6hjMGUcFeqeXk3F0JVQoN8otDRk9UzYX
6Ovakz4jrHQwidg+4/NKo64PmWx7mURvWwmdYQSTi7DRQx/PhHha60Ykkt6S88GU
sbB0TEfaFidpe19qR7ViNcSDP1a2+s3kS5TITncdwtvt7XUHHQw0w4K8mnzP/z9j
Cls0Eefv0dU1SXDfuPXomxClZlvqFFUGubNnVSwezaKPSeZAIPwsaPXOXNT9u9oJ
ZSPLgmyO
=Ap6F
-----END PGP SIGNATURE-----

--XIISR4hyMpH6DxI/--
