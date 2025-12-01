Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD04FD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 20:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E8783DA9;
	Mon,  1 Dec 2025 21:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WIsoDYNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D00783CAA; Mon,  1 Dec 2025 21:08:35 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBEA83DBD
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 21:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ec41466a30so3520735fac.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 12:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764619711; x=1765224511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QOImb4EvG2b3IkxsdBuJbNMx0ovm2aCbCRCXFyPZvqM=;
 b=WIsoDYNoZIfKJ2Az0B77xhmDFLwVAtDOnhOb08t7YsTwF3AveA4uK+nGVVyQ2Y9dQJ
 KpKb61cJEw6zaAP3GobgMp1sD04tB7oYQn/+FL8d6dPyMm7CkRBUCmI0BPmmMJ34AUxF
 pQhTsn67WsN/nTEsLebAC4gn4u6DqCe67Rvig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764619711; x=1765224511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QOImb4EvG2b3IkxsdBuJbNMx0ovm2aCbCRCXFyPZvqM=;
 b=eIKZlg7UYj9qH2AVO6F3ytFmC+4DSuyuS/sM2jn4Lw5rvmu1FoasYmkogl0MZROLaW
 LkR7UwiaHEfN2bW6Cy13lpWerPCt9UAx2FGCbqo56Izv6QtgQiDCT8c4ultrGbtzIFr9
 oCwdW3YM+PO/JRv8H8ZzmkpnZbvxBy0chimVatb+Y72JgHIK9ILzJEBrTMJtrrfLTzWg
 aJNoI5domtXUgjw5YOsySiIoZrBXf1SZ8M/pVFDkSLRyNukdrPb1SiFEyChs34i9xzVd
 X5TACd+9BZyZQ71+i/0/kI0/8ogDWrSiWY0ZgDNrwZgSpF9qX5rCM2iTbsm0bDA8z01X
 mIGw==
X-Gm-Message-State: AOJu0Yzl5lnksMQLznBTe2MMnA0NqnxaMcqzvnw63HT6Js3wOIBymkX7
 onEBih3Wfd2zQVMShc8USm/xluLymcbZrZz8YjjrCpqkic4XGUWk4jDDKtMCeUvENlI=
X-Gm-Gg: ASbGncvkxCd4AWq3X7s95i5dVdQAipAqF2RrA0J6F1yB7YJeZZYI969O+SxIehSzGxV
 UZF6/17N/vi0NKxJfVdcL6jnqRsTH5tTQoxrOuxVOAN2et/V+yNtsxi9LtMPETivWAjmKtzp//3
 Liu9vB+YnOfPOihQDs636V2bsBLeXKjpV02FBMeILMKCEMD99cp+Tulxq42LGKuKriPtpiTtdHx
 3FFLWL/SbVtox8kfE500eg6DfgzXqtMJpQHEf6ECMPzp1pRvwMkLnWj1g6/Z4iooTiqD8tsipol
 B0TViWJpx0NWSTeXmOMFsS4alF5u60Ame2gYFJCUStZY1qvTIm8GyhE1BJgLhNUBf5bFSse+KjV
 C3Lt+JzbEwUoZ9voRQbD7MUiSbhSMyVRISVf8i0UfWr12alCXhG/4NnYPoXrGAJ8+IR2YaAddmc
 k9u4Ubgq8xFPDUZl0u/XSCVcOL6MTP/p1fnoKmehpSPuXRhLtKaw==
X-Google-Smtp-Source: AGHT+IEox7Xdv4y3a0Kor4GEoJ+wFaPXJIQYRVGoWTKsDSO9CRS+3xSXqULJr0RoXIAzvqdXNQEm7g==
X-Received: by 2002:a05:6870:e088:b0:3e8:97ab:d072 with SMTP id
 586e51a60fabf-3ecbbbe044cmr18253752fac.6.1764619711562; 
 Mon, 01 Dec 2025 12:08:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dcfdba89sm5850321fac.11.2025.12.01.12.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 12:08:31 -0800 (PST)
Date: Mon, 1 Dec 2025 14:08:28 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 Sune Brian <briansune@gmail.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nikunj Kela <nikunj.kela@sima.ai>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20251201
Message-ID: <20251201200828.GY303283@bill-the-cat>
References: <LV8PR03MB8137CBCCE83CC09B861816B1A7DBA@LV8PR03MB8137.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hahi9PmxcN3MfDWU"
Content-Disposition: inline
In-Reply-To: <LV8PR03MB8137CBCCE83CC09B861816B1A7DBA@LV8PR03MB8137.namprd03.prod.outlook.com>
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


--hahi9PmxcN3MfDWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 11:05:09AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> SoCFPGA updates for v2026.01-rc cycle
>=20
> This pull request delivers a broad set of improvements across the
> SoCFPGA family, including Agilex5, Cyclone V, SoC64, and common code.
> Key updates include refined boot flows, new driver enablement,
> handoff tooling enhancements, and several stability fixes.
>=20
> Highlights:
>=20
> * Agilex5:
>   - Enable FAT-based environment storage
>   - MMC driver restores legacy clkmgr-based clock lookup
>   - Cleanup of MMC raw mode enablement logic
>=20
> * Cyclone V:
>   - SPL FAT boot support and updated bootcmd sequence
>   - Disable SPL SPI to prevent contention with FAT-based boot
>   - New board handoff script and BSP generator tooling
>   - Optimized Makefile support for SoCFPGA handoff workflows
>=20
> * New drivers:
>   - Cadence xSPI driver with full protocol and command support
>   - SPL enablement for DW APB GPIO controller
>=20
> * Networking:
>   - xgmac MDIO now supports Clause 45 read/write operations
>=20
> * NAND / SoC64:
>   - Enable ONFI detection in Denali NAND controller for SoC64 devices
>=20
> * DTS and board updates:
>   - Sync common SoCFPGA U-Boot DTS with kernel sources
>   - Fixes for FPGA2SDRAM configuration and SoCFPGA boot stall behavior
>   - Vining_FPGA migrated to the modern LED framework
>   - Device tree relocation no longer forced off for Vining FPGA
>=20
> * Tooling:
>   - Introduces a new Python-based Cyclone V BSP generator
>     covering EMIF, IOCSR, HPS, XML parsing, rendering, and documentation
>     to simplify board enablement and handoff regeneration workflows
>=20
> Overall, this series improves boot robustness, enhances xSPI and MDIO
> capabilities, modernizes board support, and introduces new tooling to
> streamline SoCFPGA handoff generation.
>=20
> Pipelines test passing https://source.denx.de/u-boot/custodians/u-boot-so=
cfpga/-/pipelines/28569
>=20
> Thanks.
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 31bf4a1c308773895a8e7ea047b3cea037e4c9=
22:
>=20
>   Merge tag 'rpi-2026.01-rc3' of https://source.denx.de/u-boot/custodians=
/u-boot-raspberrypi (2025-11-28 08:26:44 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20251201
>=20
> for you to fetch changes up to 87cb318344250ac7d598284c0a1928df6bcd1f4e:
>=20
>   Add optimized Makefile support for SoCFPGA handoff (2025-12-01 17:26:52=
 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hahi9PmxcN3MfDWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS31vAAKCRAr4qD1Cr/k
Cp6nAQCVV90QooRiCZ6/TDMfMEEe/y9ZFqUMZY0O+U7+H72tqQD+ObrX0S13lA28
KLeyoIQdbBIPKPXeDFhzvBlAbEHW5AY=
=x9kL
-----END PGP SIGNATURE-----

--hahi9PmxcN3MfDWU--
