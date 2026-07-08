Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFDBC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6995C8496E;
	Wed,  8 Jul 2026 19:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QEz0slV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489A18497A; Wed,  8 Jul 2026 19:16:08 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1668B843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4472500e25fso481624fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783530965; x=1784135765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=usgGrjjo25XUZZ+/ZtouU2bFNtliARYc0qCeUqMqLqk=;
 b=QEz0slV4NcCM5IvcPs3lC0L33yVg/fsctvvMBZGgNAjJh3byAcUgs9lCSl1TtSO/IL
 eHK6EVY1V9jRNp6i1jFp0zcbnCAuLvjWx/gOXsVsaUxaPXMeYqb1JKdXcPydHvkVwK85
 yGnqT703q2XsOM/vN7TX9T5sNuRFc5R3t2c5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783530965; x=1784135765;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=usgGrjjo25XUZZ+/ZtouU2bFNtliARYc0qCeUqMqLqk=;
 b=i2RpQE1Cy4kaoE5MdYCb9JG9mBY9fs7Lg72b7zhrggXK1ryBOaTU1tZcgGajdXHdrv
 BKyt/lMbomyYnypAnuWdi1aPfVYw7CdKdSq6asrS1LKVs3zC8mQ+agc9eLZIscSghx9W
 vcOHVqSAcf/aOHnxetGlU3vCs83IZL6jhaJvr8Elw/jpV1ObO+v2rFJP5Wp3RSLNqwV6
 GYdTHwV95bQ1FB8wBNUo66/GD+9WWUgG8K3EZ8wrxG0m3ulLIgcuQqu9ieYiuI/oJLH7
 RRGjsBWjRDfcBB78qi9JxNNazJdiBOxnLc6gWF/bBRLufCCtkKQ7uxIUgvtwN/G7oi3k
 ybTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sRUpGVxM43tMBty7CTWQgpEfa6SB48apYXKEZ9zXMHGT821PFMgAVAWwbf8xn7ev+56xFWMI=@lists.denx.de
X-Gm-Message-State: AOJu0YxNSLo1MjkVViEUx1XVV3g/x8QnpGPMIxq8Mll98aVdB/AJvPgu
 4s5v3ToOl7s6bTE4MNFHcbQVVJ2KUOOrILRt4bB+ttxQ/HEtmfbitzq/QvR65GvdPAk=
X-Gm-Gg: AfdE7ckX/2C7mqtGVM02rfFespJnf8dnPFEj4RXofnVawAaDwCrEhWdrFMjJvUGjn3p
 DdekMfGSAqIARWMR2qYPJWx56u7jCjpInoXaUN6bxE+PpssH64Y5PH9PB/kw4FDk+LrQkJP0wfA
 lQ7lSFbvNodC+8HnRi2sazzVB86ni+YMIa7HoW0s52eN46D3LT1QeVWY+TOVMoBuG9KSV0pRg/x
 Hi6gv1wemvN+AhQ2Cq0/KsRd5A7Bgb1Bb9C3q3Jq8lMvc1RIxdGERCozmFzYAqeAIXZ6Z+jmzHP
 mIgCAo2MOknhYJ2wrQEqY+Zy4PpJVrEY72F7EOgV0u442xyqDptXToAuBRQIXJwjidGrJrsfxwy
 do2nAp+rghUWKrKPgMt2Y62zqJtHb3CawJ+dxMm7lAVBQCy6Vljxr+/oUCKW7qDcxUY0VDniAv5
 ZZtkzbIiH4VWY3YJLpapHHM7JgatCygAPIiIQimguWu7y7an9Kfl8glJMKaj661HVnNpTrL48JM
 +Z2uzAo75URE3JqBa7/ZMqYKw7l4Iz9UUBbJ3SPY1epX3VI
X-Received: by 2002:a05:6820:2d43:b0:69e:3c9e:5e82 with SMTP id
 006d021491bc7-6a36d9c4a43mr2465276eaf.42.1783530964729; 
 Wed, 08 Jul 2026 10:16:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1d1ff0sm17232620fac.7.2026.07.08.10.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:16:04 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:16:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Desapogu, Jayaramudu" <Jayaramudu.Desapogu@amd.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: Re: [PATCH] video: fix no display when serial console is disabled
Message-ID: <20260708171602.GY749385@bill-the-cat>
References: <20260603132953.36042-1-jayaramudu.desapogu@amd.com>
 <LV8PR12MB93602C400E0DC621AAED473FE4FF2@LV8PR12MB9360.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WA4R2V6HpFEmt2K3"
Content-Disposition: inline
In-Reply-To: <LV8PR12MB93602C400E0DC621AAED473FE4FF2@LV8PR12MB9360.namprd12.prod.outlook.com>
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


--WA4R2V6HpFEmt2K3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:55:54AM +0000, Desapogu, Jayaramudu wrote:
> AMD General
>=20
> Hi ,
>=20
> Gentle ping for this patch.
>=20
> Could someone please take a look when time permits?
>=20
> Thanks,
> Jayaram
>=20
> -----Original Message-----
> From: Desapogu, Jayaramudu <Jayaramudu.Desapogu@amd.com>
> Sent: Wednesday, June 3, 2026 7:00 PM
> To: sjg@chromium.org
> Cc: u-boot@lists.denx.de; Desapogu, Jayaramudu <Jayaramudu.Desapogu@amd.c=
om>
> Subject: [PATCH] video: fix no display when serial console is disabled
>=20
> When the serial console is disabled in coreboot configuration, no display=
 output is observed during boot.
>=20
> This happens because DBG2 (Debug Port 2 table) configuration is required =
for proper UART initialization and affects the video initialization path.
>=20
> Fix this by ensuring DBG2 is correctly configured as a 16550-compatible U=
ART, allowing video initialization to proceed independently of serial conso=
le settings.
>=20
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> ---
>  include/acpi/acpi_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h index =
4895366a618..3517698ff3e 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -667,7 +667,7 @@ struct __packed acpi_dmar {
>=20
>  /* Subtypes for port_subtype field */
>=20
> -#define ACPI_DBG2_16550_COMPATIBLE     0x0000
> +#define ACPI_DBG2_16550_COMPATIBLE     0x0012
>  #define ACPI_DBG2_16550_SUBSET         0x0001
>  #define ACPI_DBG2_ARM_PL011            0x0003
>  #define ACPI_DBG2_ARM_SBSA_32BIT       0x000D

As presumably these values are defined by some specification, a link to
the source would make it easy to verify this is correct (and in turn, be
a good chance to verify the other values). Thanks.

--=20
Tom

--WA4R2V6HpFEmt2K3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6FygAKCRAr4qD1Cr/k
CqyTAQDHjrRFDCgQWPwa55wN3M7mTy/RYQyyQuz2UoR3TZJAcQD/c+rYADK5GbOS
7akmS82huuQjRkeW51+2ullNld0B2AI=
=UMcR
-----END PGP SIGNATURE-----

--WA4R2V6HpFEmt2K3--
