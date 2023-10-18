Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE7CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 13:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E0A86F7E;
	Wed, 18 Oct 2023 15:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SMRntwXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EC5D86F92; Wed, 18 Oct 2023 15:37:16 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B01B86F79
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 15:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7ac4c3666so83836107b3.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697636232; x=1698241032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C5QOdRsq7Tn95H435vlrTZtYYhsa6cI4Fda9Ki95xjE=;
 b=SMRntwXrOADlygsw7rvdaM1mVqax5Sr3/utnjJquM7dyNo+V1w/uCG8Rzrzj1gPq94
 KznAy0Rfq+bLuQCWQkD7WUEDTTrSCRjnXETGg508LBDJJRjdXuZi5KRD7OQ3X8rzXf3D
 bQ7n8fciwaAFjLk7xc1JzKgphZMbS6Vv94h1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697636232; x=1698241032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5QOdRsq7Tn95H435vlrTZtYYhsa6cI4Fda9Ki95xjE=;
 b=G6IrYNyHOLpMUeVRwlnDID+ODdMtoIJdozW2AfDqtvSFbDQdHUe3V+jTvQFtLe6jbh
 /bL2qSKCWm/zI/eNZORCd35IWGIYbcYPkk5/K7UctTOhoELO98RFkBs2gdOCTg/fx0u+
 akq+mecgdpTTwO758xGszZO6cRfk7bephIWI/EBwED8LwKqb/1447TYDLx0+39Z8HeOh
 U/1NDjPp6xULxDXa88lTN/l4cVTCW1FynxrWmgxHpLtw1zOTpz17L/RsXLqRjcQQSMQ/
 kRUJeCo22KyNhWq51mJ4ux0IRwASTuRw0C64I1etj08qweHdalioS/wLsv8S5eJJMzRG
 3HGA==
X-Gm-Message-State: AOJu0YxTsFGjnqygTw5EctVB7nAY10yTx13rK30ig5g5AMGPj+9Bjz10
 Lbrl0pS34wI7hH1Bb/Bjn7PuWw==
X-Google-Smtp-Source: AGHT+IEuF3gJSQ/O/KVHVEM0KIWa/+SXZra3iFNKZBr/ioxfkbdhWdJfTI7Xil8n/USRhdLTwDihlw==
X-Received: by 2002:a0d:c047:0:b0:5a8:72ee:463d with SMTP id
 b68-20020a0dc047000000b005a872ee463dmr4755728ywd.49.1697636231974; 
 Wed, 18 Oct 2023 06:37:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 m190-20020a0dcac7000000b0059c2e3b7d88sm1504273ywd.12.2023.10.18.06.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:37:11 -0700 (PDT)
Date: Wed, 18 Oct 2023 09:37:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231018133709.GA3765642@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I+bpPpmqxCXD4ULS"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-23-sjg@chromium.org>
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


--I+bpPpmqxCXD4ULS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:

> Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> available, add it as an explicit dependency.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Add new patch to update EFI_LOADER to depend on DM_ETH
>=20
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13cad6342c36..fca4b3eef270 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -11,6 +11,7 @@ config EFI_LOADER
>  	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>  	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>  	depends on BLK
> +	depends on DM_ETH
>  	depends on !EFI_APP
>  	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>  	select CHARSET

I don't think this is needed.  After reconfiguring qemu_arm64 to be able
to disable networking entirely, we still are able to build with
EFI_LOADER enabled, and no warning / link errors.

--=20
Tom

--I+bpPpmqxCXD4ULS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv34IACgkQFHw5/5Y0
tyy05wwAhoPnwUuR7C3DvKfFvuqRq9a9MEebV9wW+WOvzraRTlNgODNT+OGi12rJ
T4JLxDNQOnLZQ23X1Xyh6J7Wf2HMz3GelILWTBwnH1Qb/WIdNpCZWlSTuIiQeiXn
QObnTCr9jqS5NAyXvhDEP9hQ6M05hcK2CGrkg36KSfRKXvj0PgX9/NaQHSVYxloP
MFOV6m0eGiHZLXCuiyKAVRYfssOumIM+F9ApqkqRnCWcZZKE2A77jIFUWKTAaKB2
xUxIk+Trs22Hiz6Zzh+YXFnN5L11jC+bG8FkHEoWbTeBiCXOvkDDdjrQWYoFIH9G
wourEraqxWLxk5+hNZ6Mf/538JlbX7hZL6TlaeUKdLpfPnwJUpryOF+s3KdIVJ3I
bOhj4Z2M5U6hn9ddu3MHPHQbBAfhNAD8nEp5zuHZMIPvKtL0JgFwQ/8QZbF11zMM
dd6gOfO/oBcU/PKesbz0HuuQhD48e8t2NPt0L0OTf80j9i0aETGxyh53UOQG3jo/
h7WATGbv
=Oi4Y
-----END PGP SIGNATURE-----

--I+bpPpmqxCXD4ULS--
