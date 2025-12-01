Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A971D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E415483D00;
	Mon,  1 Dec 2025 18:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3eGK66n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4755483D01; Mon,  1 Dec 2025 18:56:03 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD8183CBD
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3ed15120e55so2616356fac.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764611756; x=1765216556; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TlbylAZCKYNCrhzw6MNFl82P2QtqzVPuodUnABtEVpo=;
 b=f3eGK66nZ0qsXgfys8g/oyn6atpX4D604pRu4O+pCfQJ9YUcMM/pCzGXMkjnDnpuDy
 KCWnHiqVqZ4GRAbsPSLH9CS3CWHJBWIoCf8IboeUDB5SELpsewG8ScboEHxpr8uXbNLd
 7Z4wkhyriEDgcz4GbJVk632ZWnymSQV+C6I7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611756; x=1765216556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlbylAZCKYNCrhzw6MNFl82P2QtqzVPuodUnABtEVpo=;
 b=KC4GMNUOuNQ3FkLE0qXvOHDr+UUamalOFg59ozfHG2bpsRruModkPhX8hgdDW2qEmc
 JfMEuTjhYH0wC/9DiGmEPwPjzXVSmcqu7l6Fwht5If30m0n7hZmOx7/05bSTcSlTpuMq
 IiXRVcRvpr6/KT+SSOr+/VF5095efVR7/iNAw8yRNx2OrSJZOrICthRkGcP5fPN9ld39
 4gmAODQkPOjG912FhN40o3+gFiSuzfcWacg7hzYVbok4du5jpsVBXrKigW19QiwUoWHI
 dS9fH84HuJpkPU2bGsMtbE1Mwm5kJf42RjBuCPabPBNM9h11mhSJifQ+VV0iqHLQfah7
 pxFQ==
X-Gm-Message-State: AOJu0YwqG+VYz0Od/BIIrrtentfIpITKDHAc8++6MlEp5ABANc4whqEX
 QuIsZF2ETx9jh1IzZB4MkTyOCMxpJu0xoBNLln7myihj9vCl4hsClAyI2WsyEVnKZiuRoK9Ywh7
 OuxVPwmw=
X-Gm-Gg: ASbGncsTpbuHraju3/4S4w7QZ4m3N4CKVR+1mbG6Lx4mZZgsrmtwvQQmmVV9Z7IXb/x
 p61OFz+fdJM0X80gnNYsA5NIC69Ds8G6Esug/I6mp2jseCK4D/IJAxB/nPjpUW1iwdzxz7d8S5i
 NF/vPBPc/evXQs+/1OKF+LyD8p3jE2VW0E08xHWn3Waef25fAZwSN+YZChU9OJPi6x/2X1EWvRw
 VV2vgOU8S6G6AFTtqM1E62SQyjt+tYL3On6/OVEPGnnJNqhIwXu7EkjWallgJfFNbXomhyvwMFk
 eyAV+Nrff5ByWY3z/abGAGXA2W5tGpDLVzGRWlSE+BMNX/pqBR2VgeaFwsjOYyVlBN+nMDVRyXt
 xNiZl8oDxBlZtRA3OkgO17q0xvWyMy2WlnczJxEQEuwRrLT+qwvmWzqdzEbHAdAlqyaW8XwQ5Wl
 4lPOU/DCQfdUzEI6o30DPfZRg3Ds5H53P5r9cVS5macmGxwdxQQA==
X-Google-Smtp-Source: AGHT+IGe2w5FI8pjeuOAmMzFs6jM4wuPfFejooLYDH1gWar3yRdX61U6+lEzmH0XXdpe+VzZCMW+AA==
X-Received: by 2002:a05:6808:1987:b0:450:b3ec:c154 with SMTP id
 5614622812f47-45112a8a8dcmr15243296b6e.25.1764611756050; 
 Mon, 01 Dec 2025 09:55:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3e8a5sm5638603fac.7.2025.12.01.09.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:55:55 -0800 (PST)
Date: Mon, 1 Dec 2025 11:55:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Glass <sjg@chromium.org>, Sune Brian <briansune@gmail.com>
Subject: Re: [PATCH v2 3/5] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
Message-ID: <20251201175553.GC2247668@bill-the-cat>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HCKCLG+/CfQjvVuq"
Content-Disposition: inline
In-Reply-To: <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
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


--HCKCLG+/CfQjvVuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 08:32:47AM +0100, Jan Kiszka wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This function and the sector parameter evolved over the time. By now,
> sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
> adjust the read sector with an offset that U-Boot proper may have inside
> the partition. That used to work by chance if both
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
> 2a00d73d081a they are a choice, and we need to drop the condition to
> maintain this feature.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HCKCLG+/CfQjvVuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3WqAAKCRAr4qD1Cr/k
CkN+AP95eFF9yQmX6JfHdsx0uO/IzIo4OfSEPWmcltzbXQGikgEAs9MVHazhBXqq
LjaIH+scmFLcBAVAITey8OL51PKQLwc=
=bTGW
-----END PGP SIGNATURE-----

--HCKCLG+/CfQjvVuq--
