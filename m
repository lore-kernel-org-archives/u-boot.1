Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CFCCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F332886BA1;
	Tue, 17 Oct 2023 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jrqGC9Js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B6DF86F01; Tue, 17 Oct 2023 16:13:26 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E9D803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso6445756276.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697552003; x=1698156803; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+Mk16zHEjHHg5isgp44YcX0lGNfj45CRRPYCdHW3+zk=;
 b=jrqGC9Js77IkdPpxh0PcTEXDMVCdcGHU1Nt6k9P6H3M67n9ybt6sysFuXEVhk/lDJR
 9PXhgXRVFWhPTsuX/YQU9iQVMReVPVW1SYLf3z1U9dkPXg1aiEegAHNt9zhG5FCKA1d7
 qnt9Eu1wPMyMPD/v8npJo3TBPtJ0AD26SjS84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697552003; x=1698156803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Mk16zHEjHHg5isgp44YcX0lGNfj45CRRPYCdHW3+zk=;
 b=jstbcTogQiSotbJeY+ZojJLiYvAcsp+kla1MStcG3Hg1TV5GtGHmLxEVhbhOapr78h
 eBR1A1DJcUBfbXd7TQt3OydDl9/Tgk6XuVmKpj1bjD6tHCSPb+IQSVsZmEeJa/r/LDyJ
 IycTNOaDJs3Ot14P1O+7ZMm3YTbu+vfYx22CLrgObzHt2h1f/6p5ht5qc/c1XfJtxjDo
 BPFZNxWykSStjH24BNGa/BGW5sb1aj9EF55hVh1UbidZS595ii5eLEFwSVS8V+K2N2Og
 g3mmnNBkd5jKaVhSm2oUmhkVS1fdjLm71JoVVoay9VivmqQyaECUeg8T9tFG7A/cx5tN
 et0g==
X-Gm-Message-State: AOJu0YyIPe9sCdOaEM83WOj4aUtz+MyDS8rq7iJ1M1L7bJIu+ZExuAgA
 D7A5er5MBh2ORvtjzfsiVOQIKb74IoggFmVmQ9iq5g==
X-Google-Smtp-Source: AGHT+IE5ktY9j1D+Wc1uBKWIcVZhO7QN6PpB1JLgwTsmvD5eS9gZ1PjznUdeSnd+g2H6sNr5Nu/heA==
X-Received: by 2002:a25:da08:0:b0:d9a:c304:bb78 with SMTP id
 n8-20020a25da08000000b00d9ac304bb78mr2420427ybf.12.1697552002983; 
 Tue, 17 Oct 2023 07:13:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 b34-20020a25aea2000000b00c64533e4e20sm540890ybj.33.2023.10.17.07.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:13:22 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:13:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 21/32] efi: Rearrange the Kconfig for
 CMD_BOOTEFI_BOOTMGR
Message-ID: <20231017141320.GD3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-22-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vmoILa7wQS/zfsKM"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-22-sjg@chromium.org>
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


--vmoILa7wQS/zfsKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:12PM -0600, Simon Glass wrote:
> The command should not be used to enable library functionality. Add a
> new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
> same code is built.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
[snip]
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 621ed5e5b0fb..13cad6342c36 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -32,15 +32,14 @@ config EFI_LOADER
> =20
>  if EFI_LOADER
> =20
> -config CMD_BOOTEFI_BOOTMGR
> +config BOOTEFI_BOOTMGR
>  	bool "UEFI Boot Manager"
> -	depends on CMDLINE

This is another example of why I'm asking for re-ordering things so that
first you clean / re-order things then you make all of CMD depend on
CMDLINE.  This patch, aside from other feedback, is standalone, if you
do that.

--=20
Tom

--vmoILa7wQS/zfsKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUuloAACgkQFHw5/5Y0
tyyv5wv+JzVaHHXumSqU6FCINqbVZCFjSNqFyHPvwNmXNN4GrNOkk7SZFETW0PMt
kIYez0Kn8nTatsLIGa7jV5pNAFC2ewy9fDBwsGFVLcyN7HYgBKV4/qGYiPOE/wXn
QGHbEbPDs4xl5+EO/pgUERTeCTZOP5HQbAUDkEA/IH/oRBhirpgftRv7gGHDNAqo
BINaW0Igkrq/8lxTonZRjbDvmPtXoMmVAyrQXCP5r1LpnpXShNaoZP4Hb24nq3Kv
UqQGP7RArCpKvW8K8+tibfXlICuITAHZMs60o4H7aOlX35Mi9bfwWDAUo2K5KiaJ
bRxKr7417qoNhxi+HkrDK9w1gvevyfSZ3zRWu5HTqQTby1yHhxDWR5ghkqMc92vQ
+cXhyw3N5uB27bMnOVa8dSTlqGvstB9j3tSMAOBt2JoOzAQjvS2JtLpCR4RnNeEa
stkQjhEFoL/Vt5nz4M5FQuGDpXO38mq2Il1PqIMNXXHZFmxkij1hfD4aNwDndOIz
hFJNWcDS
=8yyw
-----END PGP SIGNATURE-----

--vmoILa7wQS/zfsKM--
