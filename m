Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7D2C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 22:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64FC800B3;
	Tue, 18 Feb 2025 23:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHfjRnXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA23280646; Tue, 18 Feb 2025 23:31:46 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7158480077
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 23:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so6557301a91.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739917903; x=1740522703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wL9UHZOWE0NWhWf92N5OYK88GWdCR299bMjA2JeArFU=;
 b=XHfjRnXmIts3of+YuKrLV6l+fuEK/ol1F4u3iuJ+POb6B/9A6g+uEQrG4Apggt1PRi
 ElmZoO9dBBLubPaYPH9wmNIcGcJECsENwG/AKouz5QmTlZfR9dU8ZaijmpZfeHtx1Vn7
 i0RzRxUA5hE/FotQTzdbZD/3uWm32EzmDr38Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917903; x=1740522703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wL9UHZOWE0NWhWf92N5OYK88GWdCR299bMjA2JeArFU=;
 b=PPf4kHhNpTWGlORJ1LPO9kke5IgVDtpPU/XHCOj5ppHpDtBOGo1BmBnhmhDX3pRRVh
 eYuty2kMQA7Dw1bZVOlieBk5cCztDeTiBGkykbk/vwLNCok7eis3C6Fy4pFbF0vKPfZQ
 2DyJubSy9C0TS1fFsVLhtaVOCfqLQjsTH0379LtKUjsOm3mtCeMxexW+DPXWEuIkE9rH
 jIByvr00vocftPx072ldDVE2icRsVAAYDWj/e1r5DFIN4yAWvZJRhHFrqfhtji+6q2Gg
 oYECWc7WV62YNq9KgbWEL6rQjLZyJrKBfdHgG3a12vk2hSAZ2DJaI8xT9KcR4NfMAWQw
 ZwgA==
X-Gm-Message-State: AOJu0YyfEReiZbfRwcTF701wMVXWJGPh8qU4QQ+gzvNaXIeJb/Envbvt
 vyMHgFUe8a6fFrO67IfbMrFXJGtypS5lPPMbkb2UQcN6iIDQ2PM9yc7k69lBZ6Q=
X-Gm-Gg: ASbGnctkx+Mm2l/B7ExR2qKaPK4SD6muyCsXfSDmBp2Gf3WpzNv3rbuIeUvXP3ZQC/c
 ROAE6ijtHP6AY2AmYBV6EyjwViR5qjPV+NP5J+HUoyUmivY1hwC/xXuywuPKmYUis3w7fg8UjSq
 rsUUgNVfyVRAZYz1rzO6rSwPgkdsFcPyJMEFUvKjorTird0ldkUlAtoVXLFxtedjo9cVzQe1gH3
 55eYyu/HQ0sIywIdnTo4OaevgPL3lYpN6JyFPq/xs1khnJa+rKxASJl2S/hb5Io1ej2CLDAsL7V
 QyVgZUIUSzT4kQ==
X-Google-Smtp-Source: AGHT+IFlWsKj3fwch9a4L+iTJzRWUXBXDtElpZNwJBi9AU+oZbSdH3R71hyZoLe3MsiUTqONFTteRQ==
X-Received: by 2002:a17:90b:4c0c:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-2fc40f108e9mr26841145a91.14.1739917902897; 
 Tue, 18 Feb 2025 14:31:42 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98cfd19sm12745950a91.14.2025.02.18.14.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 14:31:42 -0800 (PST)
Date: Tue, 18 Feb 2025 16:31:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
Message-ID: <20250218223138.GA1618326@bill-the-cat>
References: <20250211133116.28833-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fR3xXXmkVelwHWX7"
Content-Disposition: inline
In-Reply-To: <20250211133116.28833-1-marex@denx.de>
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


--fR3xXXmkVelwHWX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 02:31:08PM +0100, Marek Vasut wrote:

> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
>=20
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET =3D=3D CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) =3D=3D mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

This introduces a failure to build on a number of platforms including
verdin-am62_a53 with:
+(verdin-am62_a53) env/mmc.c:208:13: error: 'mmc_env_is_redundant_in_both_b=
oot_hwparts' defined but not used [-Werror=3Dunused-function]
+(verdin-am62_a53)   208 | static bool mmc_env_is_redundant_in_both_boot_hw=
parts(struct mmc *mmc)
+(verdin-am62_a53)       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
+(verdin-am62_a53) cc1: all warnings being treated as errors
+(verdin-am62_a53) make[3]: *** [scripts/Makefile.build:257: spl/env/mmc.o]=
 Error 1
+(verdin-am62_a53) make[2]: *** [scripts/Makefile.xpl:550: spl/env] Error 2
+(verdin-am62_a53) make[1]: *** [Makefile:2115: spl/u-boot-spl] Error 2
+(verdin-am62_a53) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--fR3xXXmkVelwHWX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1CkAACgkQFHw5/5Y0
tyw5SQv9Ef47coiP6ca3ybKaxdw5CwI+nkuSvxDRVWZq9+TRIYl+30uhCcvxiARn
YJRpElfk0Hh/BzekFORqqFUIMzp5SQ/+fehlp2ZqP12wUSPPAmCBAYLVWGqN0e4T
tXei3oprDGdfFvigB3is2/ARujbMJns4H3yGbfmcybN1bseRTishguKqR540d9cJ
WQ3TU1JDbAFn6gr5h5PF1RJnK73w5YUOL+s7+mQJymeQHXsT27qhKEMijTV5qgXp
+39iAyZH1VmlI3733UYiFL7RK1ff+5ybMTsl22Sd3fgJqcdE3ew803SkV3R9ITls
puXwKPOtRJXby4RQBR/ABNzt7Tx/9FXgK2HHYfUddrb1sRBZ7RkZ+ZvyeSVl/WGJ
Kz/uLUtPbU5UxAxZOFefKMjU1yW3JFw2MDw6+GyVQM1A32B/BBrTg0KDvRjJmrw+
gsTMo5iR+PMLyIb0mXDXYyBhIAb0K0+FZ30bvhQWMnSpl++RH8Lvvbo6s47kiQSZ
rOdjv/g3
=Ie5y
-----END PGP SIGNATURE-----

--fR3xXXmkVelwHWX7--
