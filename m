Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B090C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 17:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E36980F96;
	Tue, 25 Feb 2025 18:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DJTYZEVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF8A80F96; Tue, 25 Feb 2025 18:59:46 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD83807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 18:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-868f322b8dfso37487241.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740506383; x=1741111183; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NSUoNJa2kms/GYBZKcUV5cHzjWhDoZ8BtKoJLCWd5SQ=;
 b=DJTYZEVa3Xvfyt2BPo5tU8eEh3SNRWTWK2bk8ZnN70bHO62wDgS+ryc2FoOVH+3jIL
 DicSb9EfTG6CSJ4rlku9OaSB//Y9xMCGlxn/+1uqC9ihdMj7lHD2jHjQ2Otiqgslquyn
 zja3cktYco/uEaNnPwEzKMxEtilRdP0gXyK88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506383; x=1741111183;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSUoNJa2kms/GYBZKcUV5cHzjWhDoZ8BtKoJLCWd5SQ=;
 b=eBCLwCL8YIrYGfSKPYfr+2IP52hQ4dL5Lmf8WIT0p9a01qAijevKVNFdSdS0/Vrkhx
 1WUuevAAmCZs3w93HkMSJpM7Jf4Rs6/4WviiUh0mDjfjYaLHiJKsapQGSa+DIFtlHYlk
 jDar9Vhf5g56TFd+jCVBk3S4EsBUS/IbuUMYHrWAW+zwDz2S+cND/p+a33e7OegOTk6G
 T0UE0gS4dHQDQlb+VGR8gVlt2vfdhbKltPLPcP/znAybLabaHyTJQo4ykhpO6DILHuhJ
 dNkWWoa7SoIWwW7OZeZAItJHV5sTY2tJkxVdYBBGIaO68pYtxCNH3OwsfQt6QOXdxQDv
 iq2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkvwo4BXroyxDANfo0ZkOSsD2AV5+Z+Av5PpcjtNGmNJ3FWL6XsIupolShwK1LDoY12mDaltg=@lists.denx.de
X-Gm-Message-State: AOJu0YzQL+QCKRTCnSHwpvt9jrP1HqVuBqZOFIkdcXbZsDgrQCfyekIh
 0V2UseAh39EBg/ZDBijNAOu7dVsej2Fnnq5AayxxZpCnKvyAcjNBQi0lkXEACm8=
X-Gm-Gg: ASbGncsg7FVL8GLKsFlb7tIb9f9Owf6l391FPQ3GMNtxvJOjMEhluu4jOVyxDlCc0Ke
 hK7MtjAPgpvThm1rE1LZvXMEEY8qvTXrvGFMQaQcJJFE7a38Cy0Hocg0wmQ6AGxYossP8X77QQr
 jnNBH3iUMeuMABC7MrEhYoW2MmYECxZIlNhgBG5wdYqTdRhzpCcnupf8boh90I1+dLo2Uj0F4SG
 V69C8RwZVS44T1nrXq8jpvMl6XuRGfSK45ZeWXGkosiJtL6eEN8ppGQDMcGsYHWf6kxHuk2/Hpu
 V13fcvex4M7nBgwvSFXZPpI7
X-Google-Smtp-Source: AGHT+IFV2fKadDiK4k8GPlmqBJo5Nllv2/JjYZzLMvxHEezzHTWTVrMnbqLbckY5F8VFFJ1n7vijTQ==
X-Received: by 2002:a05:6102:510f:b0:4be:4e41:734e with SMTP id
 ada2fe7eead31-4be988b99e3mr11282423137.0.1740506383212; 
 Tue, 25 Feb 2025 09:59:43 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ed4c91dsm450407241.8.2025.02.25.09.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:59:42 -0800 (PST)
Date: Tue, 25 Feb 2025 11:59:38 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, u-boot@lists.denx.de
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250225
Message-ID: <20250225175938.GR1233568@bill-the-cat>
References: <DM8PR11MB55926A01DEBF96A95B86AB8DD2C32@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u2goXkDlcVV1UqqL"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55926A01DEBF96A95B86AB8DD2C32@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--u2goXkDlcVV1UqqL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 08:37:03AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for next from u-boot-socfpga, containing =
boot support for the Altera SoCFPGA Agilex 5 platform in U-Boot. The change=
s include:
>=20
>                 1. Board-specific configurations and setup required to en=
able Agilex 5
>                    operation in U-Boot.
>                 2. Integration of cache coherency unit (CCU) initializati=
on routine,
>                    including CCU conguration in DT.
>                 3. Clock, firewall (configured in DT), SMMU, low level in=
itialization
>                    specific to Agilex 5.
>                 4. Integration of memory initialization routine, includin=
g DDR setup.
>=20
> This patch set has been tested on Agilex 5 devkit with QSPI boot (UBI/UBI=
FS) and RAM boot (TFTP & ARM DS debugger).
>=20
> Passing all pipeline tests at SoCFPGA U-boot custodian https://source.den=
x.de/u-boot/custodians/u-boot-socfpga/-/pipelines/24816 .

You forgot to CC the list as well, FYI.

>=20
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71=
ca:
>=20
>   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20250225
>=20
> for you to fetch changes up to ce5e8e60cee2b9dbab701935f99f46bc612be001:
>=20
>   configs: agilex5: Enable watchdog autostart (2025-02-25 10:53:56 +0800)
>=20

After removing some duplicate tags, applied to u-boot/next, thanks!

--=20
Tom

--u2goXkDlcVV1UqqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+BQoACgkQFHw5/5Y0
tyyRngv+JQDrJJcDpiAEgJCwpzbXRQ/dF6rnyex3OwSIuldfS4sBB5BuS73f7kwT
c2rDnOcV7vJUa4ciNEtzfUfZQLdND4qe38pmp+h7B6LkHSaaOy4FQIrZD4nMXJZ7
qfgDSOE8FYSXn+xoBEcnXSVyzfpSblqcZk6Je0CJPlM6ud/T3tgnvFXyiYV8GgC7
ADToudfynpRXjIC+3xo3jxfQ7zI8jAoUg7t54UDaA+PJnehIwjGPyUrQVXRJn9pN
nb+19XpuTho+felaG7OCewX67Uf5ktT3Di4sj4k+C9QFB0oFe9Wp8X20FaXpzcW8
gq2qXl5CRab6Vfh/bMV+28vl/CK+0bGHpL81i/nsDj20y4OQzLhM+24wVg3vjmo4
VZOWVOE3rpedpFm5qCS3aBPG37sqbFGlKyahhuqY0Kv8cy4Yus/6TIq8JEfVV1/u
XpSSwJkjjEH0KKqQfciIvFqfXE3CKikr3yJidXcjmK9R5gQAilv+pwBF7Z0+tCXC
q+cRPs/6
=L7iY
-----END PGP SIGNATURE-----

--u2goXkDlcVV1UqqL--
