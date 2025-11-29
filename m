Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6288ED116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 14:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7EC83655;
	Sat, 29 Nov 2025 15:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tWSIxBJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841CE8367F; Sat, 29 Nov 2025 15:37:09 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6294832AD
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 15:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c704bdd57aso1365387a34.3
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 06:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764427024; x=1765031824; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0QTumz0jLQs9zuo6um1h7610XYyV0mLOlJf1IaKKvH8=;
 b=tWSIxBJmCPaYoWw3ZQRP8aAPoUCdiT8h8UPyK33CniRoeBT6xMGyN6T1X+pH/pO0sd
 txWRyPDLB3YQc8mO65DgyirQQuim/AppFTE0Yd1B5mfl8TiiWKMCA/VNkJRmE8vsNuUx
 nQw0ed3h/eXnmTW4X0Kg3NkBWYPMJkc2uxVpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764427024; x=1765031824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QTumz0jLQs9zuo6um1h7610XYyV0mLOlJf1IaKKvH8=;
 b=GxFmKtWNTsqf0kPqu/2EsJNoK0a5Tvj1mXzPuxgR0IuI5bUdphuf8pKXcCdkFjeW+m
 gv5dWRsvTDS7fPsIvS33EmNrqSOYw1YPgfYe4y3khDhjo4gxnhCq/3LbYVCqWG+eF6e/
 f4EcdxqXvONvekLR6DOcrPtaEDw7iPsPjvlpLC532JxxWtMO7bmdpgwzw/epdY5yHdqp
 hWxdT3hHzHiuoSl8huibx8bIJyDUKZ8J6tbw2x+Rno/uNL9cxaeC9Dx5qobX8XhPFzNO
 +L3l9e9775vkxiRiVplBG78M4miE8frID3dc5naeecxVRkPX0wfiUOkRJP4kVbVPZzad
 VuSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYLVZYr17tVQIlgI4fXnX/4RMwvqc1f1Ys3JV0oEwkwpqi4h3kExGjQ9ptj0je6zFtpGnKxCs=@lists.denx.de
X-Gm-Message-State: AOJu0YypFXhyA7ym7cBq9jR29JAWD5bH5SvSutAy/pSfd2BkeXrCMUvT
 Fln+ELCwwLcGBcpnYr4+H71+d1BXRsTmxtElAcTiBREywIc53EruGPZUCLvc6IIuQdw=
X-Gm-Gg: ASbGnctV0l9uMnfXfbWsprkxNnNHZyS8jLfhpqqbIpVGeJo/znDBZ6HWB0yXIrTiuUt
 vfVUGFkdITOXa+614iwxaMIBeIWYCDV56+9KF8AUvP73Jb7C6jofWYX+2s5XEkU7gL1/nd2CXek
 2PJV+EwybD+TietXS/aRdB8qol22/5bgDcLYZLfu2ygDRnQ1QDsuM7d7F2ZZ49CUMOLToAhhNhq
 YZRLchqaA7RbvsZPNTA71W+tvR1tCncUTvD1r+joHO+JJ4pCYmTwgnUTp2n1mjRRTOGby5qxkzT
 dAWVN0P5332smZGryQnkDf/PVkCRSoleP5A7wkeDvlrZYgqKCtX+bxqG/YKUT6TI1AbiVBlJJc7
 jmBs2QM678kxGzQUStcPNRjJJ9kc1fec81nUJCpxzEyT4uIjMDdm/EntWgvHNi03E9pNagVS9KT
 F716saFrMiP6jgpI+i6lTO/f2XJzAvMJifeT99PhppFp09IG+W9RE0ikWtiyP1
X-Google-Smtp-Source: AGHT+IHjw7k8khfB4LQpb0lZukzczd6IZ+5deppHmCo6cvP3mvrtu1Rj8seCSJwyA6RPsmzQklaQkQ==
X-Received: by 2002:a05:6830:34a7:b0:7b4:1768:ff3b with SMTP id
 46e09a7af769-7c7c4466f4fmr8479136a34.22.1764427024337; 
 Sat, 29 Nov 2025 06:37:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe15847sm2759522a34.25.2025.11.29.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Nov 2025 06:37:03 -0800 (PST)
Date: Sat, 29 Nov 2025 08:37:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: c-vankar@ti.com, u-kumar1@ti.com, marek.vasut+renesas@mailbox.org,
 n-francis@ti.com, peng.fan@nxp.com, semen.protsenko@linaro.org,
 s-vadapalli@ti.com, jm@ti.com, m-chawdhry@ti.com,
 u-boot@lists.denx.de, danishanwar@ti.com
Subject: Re: [PATCH v3 0/5] arm: k3: j784s4: Add PCIe boot support
Message-ID: <20251129143700.GA470491@bill-the-cat>
References: <20251112064725.1049199-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K5dzctAuBVHFprqO"
Content-Disposition: inline
In-Reply-To: <20251112064725.1049199-1-h-salunke@ti.com>
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


--K5dzctAuBVHFprqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 12:17:20PM +0530, Hrushikesh Salunke wrote:

> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
>=20
> PCIe boot allows the device to boot as a PCIe endpoint, where the
> bootloader images are loaded by a PCIe host through Device Firmware
> Upgrade (DFU) over PCIe.
>=20
> The J784S4 SoC uses PCIe1 instance with SERDES0 for endpoint boot.
> To enable this functionality, the SERDES and PCIe peripherals must be
> configured early in the R5 SPL stage before the bootloader images can
> be transferred from the host.
>=20
> This series:
> 1. Adds the required clock and device data for SERDES0 and PCIe1
> 2. Enables Cadence Torrent PHY driver at SPL stage
> 3. Enables J721E WIZ SERDES wrapper driver at SPL stage
> 4. Enables PCIe boot configs for R5 and A72 stage
>=20
> This feature has been tested on J784S4 EVM. Following are the logs
> corresponding to this feature.
>=20
> https://gist.github.com/hrushikesh221/cf48b512eb4cd90c1612ad2e531b8ffe
>=20
> Program used to copy bootloaders from PCIe Root-Complex to Endpoint:
>=20
> https://gist.github.com/hrushikesh221/94e6042dbd717c74b74a5c9fc8ec5b6c
>=20
> This series is based on commit :
> 6b27b688694 Merge branch 'master' of https://source.denx.de/u-boot/custod=
ians/u-boot-sh

This adds failure to build on am69_sk_r5 am69_sk_r5_ethboot
j742s2_evm_r5 j784s4_evm_r5 on current next, thanks.

--=20
Tom

--K5dzctAuBVHFprqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSsFCQAKCRAr4qD1Cr/k
ChpFAP9E+GCYX0qxi7ohpvli64SwLOSc17FqY2uRM/RqHymt6gD/czUDW2BwTAVW
a6synfyUL+1EBNEFFCdBToB2nh2Ndgs=
=TwC8
-----END PGP SIGNATURE-----

--K5dzctAuBVHFprqO--
