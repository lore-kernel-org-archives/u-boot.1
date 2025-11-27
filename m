Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0ECFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60078457C;
	Fri, 28 Nov 2025 15:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nTHqeVe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B55844D2; Thu, 27 Nov 2025 21:21:34 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C4A8449C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 21:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b728a43e410so213075266b.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 12:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764274891; x=1764879691;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7sLD7u8B1UiCBKjGJCX3cJ+ltTbkaFVmtArX4ApjMC0=;
 b=nTHqeVe31PQp9jt/0QtF7eis1UU2g/K5X91ixXfo7XoxGkE80p9ydxEUYmTQEnTosr
 YXvtd+CAbcNCZPUPq6+gpBRfGvjHTOR48E5WuERbEkdme0rSN3ag7BKr6AYiDkiwAlC4
 1NQYYV8YJgXwyXVwpnq4kTc3Y0AD/TFN8MJc9OuBS8xZ8RTeukwXgW0zA9J7qFgemCbU
 kehZDAeGFsZqWLKXKJl306UzdZpqtiHiloDpFW1BHW3udZgs7ymVYAyxLXN5Tq5Iaiq5
 YOyVsF37OxIiu+THRgpaU+AgAfSb7FSiYo3/aulPl7VBpHspdPUwwJkVE+3qEGbbR3Yt
 2XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764274891; x=1764879691;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sLD7u8B1UiCBKjGJCX3cJ+ltTbkaFVmtArX4ApjMC0=;
 b=E3NjbtPZoyO+decuPJGxo/5irQj0/WtXD7gUeny/bpEtDTk/erA7uVocLtl0svYQJp
 4ojYcDrN6h+I8SfUx8oRiu5wvKxxzDBPLOgBDSfkqhaCUdxBatiRPAtDS1+LoMrnQisW
 Y5Mu7WnRq4iIRwsnPFbtgxRvyFyGERjPxAp3vppnYQL404p9tql0iYuGcey4l2utgGlW
 oVHgtdwGYwxAFbyyJOB0GqgXhHmolS1okNNrFxygrI4kNJPNX8ae71fT0pAu7lwuCp9k
 5Kg/4CKVBRI8VL/R9vVc7tNUEUQaX83NIoioUm9WuivTqzOGUtXYjsSFsp2BvqfSVfCN
 SQPQ==
X-Gm-Message-State: AOJu0YwvRJXqvr4aqgdX4jUnyHmxJaEpuBvAr5JF3g5qGQwX46Flo2Hb
 sflYzYdEX0SEGk47NXKEmzvF5KBXbElBAvBZq9U5mGBloDUDN9zSoYPhaizwtdec4uQ=
X-Gm-Gg: ASbGnctSlWMFJ2R24jNh4+auo5y7/QQ/cPOGnNfPUmOaw1iUMKe6HMDF7kO0MUaGJA3
 Z9K26HtzOucNZvSCTSnVWaoBMBCH7ZDLZFjjsAptGquPNsa0BFito/P9Qses6paGOQRxWMnC5h3
 Z+Uzwmf1K8ggR+DFjoCYLVKscnMNsHxZ2QnLy/fOdhsIhcoDUKPqH0QL0MRJyPZNsZ7Dgpg418B
 EZv8de7oFEdfckzsNFm3dUUfOnmFBJHvALGLX0BpTlVUxel3MKOUZJtXasSaWqcIfNNlplOeuSu
 TeH3CtJ7EI2wvDdtuNdytumSswNH2xXH12zf1/7CV3f87uuDLByF3+iBuHD2DyRkW92PH8eLoyn
 CfFHov5lKmEOFfIPWE4WtEMON2uewDQKVWS7ZMIgiuNjmdL7vjRWWeqlTYsGZXfTfJ/EpVw2Vrl
 +hUYll
X-Google-Smtp-Source: AGHT+IFaYhBQm7G67bnTEvMwzerBc7ntAJ0l94vCWqMIxgHkoGYaU5w80ypDeZOqH00cLatf8ESCyQ==
X-Received: by 2002:a17:907:9288:b0:b76:23df:c997 with SMTP id
 a640c23a62f3a-b76718977d5mr2925564366b.54.1764274890834; 
 Thu, 27 Nov 2025 12:21:30 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a4860fsm245567166b.63.2025.11.27.12.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 12:21:30 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b75f97dcecf5568104db669dac91ee04df47b5523fc59ce400656a149e52;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 27 Nov 2025 21:21:22 +0100
Message-Id: <DEJR900FXLVU.1GCOQ4964FVP4@baylibre.com>
To: "Tom Rini" <trini@konsulko.com>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate
 symbols
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
 <20251126202925.GU2125796@bill-the-cat>
In-Reply-To: <20251126202925.GU2125796@bill-the-cat>
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

--b75f97dcecf5568104db669dac91ee04df47b5523fc59ce400656a149e52
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Tom,

On Wed Nov 26, 2025 at 9:29 PM CET, Tom Rini wrote:
> On Wed, Nov 26, 2025 at 09:25:56PM +0100, Markus Schneider-Pargmann (TI.c=
om) wrote:
>> Remove symbols already present in the included file.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  configs/am335x_hs_evm_spi_defconfig | 3 ---
>>  1 file changed, 3 deletions(-)
>>=20
>> diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm=
_spi_defconfig
>> index df009844defad13109adf2523580181b6ed6b5ca..ad1777f2bcb45bd2c8424011=
adc231f0e7d4ceee 100644
>> --- a/configs/am335x_hs_evm_spi_defconfig
>> +++ b/configs/am335x_hs_evm_spi_defconfig
>> @@ -1,8 +1,5 @@
>>  #include <configs/am335x_hs_evm_defconfig>
>> =20
>> -CONFIG_ARM=3Dy
>> -CONFIG_ARCH_OMAP2PLUS=3Dy
>> -
>>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
>>  CONFIG_SPL_SPI_SUPPORT=3Dy
>
> Did you confirm that buildman still works? That's usually the reason we
> have this kind of duplication, thanks.

Thanks for the hint. I wasn't aware of buildman, but it looks good.

I checked if buildman still works for it just now with this command:

  tools/buildman/buildman am335x_hs_evm_spi

This worked. I am currently not sure if this is everything that can
break with buildman?

Best
Markus

--b75f97dcecf5568104db669dac91ee04df47b5523fc59ce400656a149e52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaSiywhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPh
HgEA7WQ7ISX7Ar7GPOk4BEmlY9PxZDkPlGV1fgsI89jXqMcBAMTmnu4ZykrbYwzI
93PL2HehjktjoDcmja63lMAWxnoO
=DCBy
-----END PGP SIGNATURE-----

--b75f97dcecf5568104db669dac91ee04df47b5523fc59ce400656a149e52--
