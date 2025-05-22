Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D92C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDA383095;
	Thu, 22 May 2025 16:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FuXFkog1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C18F83095; Thu, 22 May 2025 16:45:12 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C27883082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2d4f832069bso3177347fac.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747925109; x=1748529909; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7q3VlmxPctUD36DLobuhwX4/Jvch76cV8OwHVUAybu0=;
 b=FuXFkog1olYMPx/6mSLHFSwsjihHh+lF8np5M9Nj/yDL2smzpKnmHZFexsHDMgLFoN
 dqiMc64FXRU7d5c/MQS5ADaCR0WPi+pMXzpS2qA/LajOqcmNEPpR6jFOsv1qUN6qFux4
 6JRhaWIB22YMzcKXpLgivUZ8CaSvb7GodcwFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747925109; x=1748529909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7q3VlmxPctUD36DLobuhwX4/Jvch76cV8OwHVUAybu0=;
 b=sWCapieqGUPjTNUFukjRri6S+GhfRWCbrgc/QRVJrd51ySI2m7T/WqaRuNvUBq5mBC
 N7oZ0YAXXqTMiJOPGGr0vwLGnHLb72g6PCW9JjHKSn4xw+DE8SujXNJL/E9RIpjwP1pt
 iGDt26iVqFYllcEhri0Mi56dX1+A5qCCj7CAM+YAzuqdWYL+nm5ToIna7gShYQ+Q772c
 +Qzuc6hbuasgju20tpbp67gv7sjJJOTHqYi0KLwLUWWrlRtgQGcp6AEbh19jzarQLAuk
 fH/+sN5nf8JAFKMPytxiyrAn9b3XD+Wp9xArwlb5k3N1qkhLK9q3GDoUJ3l6ngj8b7Ft
 5snw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEsQ6wf/8511RmkaAmBvLDoNjlVa7OTJksA7xsfkQy+hj+HZfp+g/+tOX0r7j5IngOnjfNQDk=@lists.denx.de
X-Gm-Message-State: AOJu0YyKcWqjg7BeXUv64nLOclCvU8ZGY7Z1PEEQPr/bJZKATo9OdTU/
 H/5JytnRjwrBtepixuLMA/BQ16/kwmv6aJAV+59AxkfVsPf9W0+yUeaxiam3ZW7iCug=
X-Gm-Gg: ASbGncur2XjCRLNdCRnnTLfgRFcn6MXqza5WynbIpTiVkbiK4aDjh9fYhwCVUQNnOHn
 galjsCmDlTpS+nuvtAbxfE0Dcp/fwcZPr9XYjqD5e6bnxTTIEj70BospXjbSPnsn8i30darYByf
 2OFuuVfcR++Z9rFsovM+sicZcfYA54Nk6gPiAf/DH1/OrdaZitUtwxCtZIX3Fc10/lpEKsk3ay1
 XPC73Uxi0/uUpk2rxygomHWqAsbE0I7wWKG4Td47QkrFSSvLVbNBX5Ds61N/rGY6AMoqd0xrs9E
 RvseCNDGWGT6zCMEfINCggMwQAgtBrQJhRuu4x3IIV/U6Um1+byKGf+qo6h9cI7Y53l3SN06ZaV
 ZaeWdbGpzgTtf
X-Google-Smtp-Source: AGHT+IHKV3pthZxXUoJ831n75bg8HJjysLUtWU9kPalcpWFUn7FH7NGrSCLnsykJH7VBVXkdURrJug==
X-Received: by 2002:a05:6870:cd87:b0:2d4:d9d6:c8d7 with SMTP id
 586e51a60fabf-2e3c1e927f1mr16004508fac.31.1747925108808; 
 Thu, 22 May 2025 07:45:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06084ccsm3113744fac.7.2025.05.22.07.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:45:08 -0700 (PDT)
Date: Thu, 22 May 2025 08:45:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, nm@ti.com, hnagalla@ti.com, n-francis@ti.com, jm@ti.com,
 u-kumar1@ti.com, m-shah@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable
 split mode for MCU R5
Message-ID: <20250522144505.GK100073@bill-the-cat>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hl78fHPzFHKAHlNA"
Content-Disposition: inline
In-Reply-To: <20250522071828.285462-7-b-padhi@ti.com>
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


--hl78fHPzFHKAHlNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:

> Previously, MCU R5F runs in lockstep mode. Enable split-mode on MCU R5F
> as the support to shut down core1 and use it for loading other firmware,
> while DM runs on core0, has been added.
>=20
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>  dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi              | 2 +-
>  dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi              | 2 +-
>  dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi             | 2 +-
>  .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi        | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Please don't post DONOTMERGE patches. If the series can be applied
without this patch, because the functionality is backwards compatible
put these changes in the cover letter or link to a gist or similar to
show how to test the changes locally. If the series can't be merged
until the DTS changes are ready too, please mark the whole thing as RFC.
For clarity, what is the case with this series?

--=20
Tom

--hl78fHPzFHKAHlNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvOHEACgkQFHw5/5Y0
tyzCbAv+JQKT2bIMprAWu8UA0RjbZHZA/o2HRp2WkVj5EX3vp9KIGukNTJ10d2x1
YoW/YZGGbWIjAfeTgC22xqcqq4YjrJCk1tVY+NrSyuZBm5uuKoBTTsbySzmvNKbn
JY+OLV5bEl8Qty3bsHO14Wlal6WtVKVSApu2MtFr8nJLB5Y9djw+fnP5zpuuq26F
mjcyxn8J9PkmNkt4M8CKI2YPF+Sd7MOOmpZZtPeRIJ3Lfw6d2zfXhu7zjGnd88oA
e3QXTd/cNzg04YR1jsvEZTU5CuPiEznYTEdg0IWgTpTgEkXLaFlOtON9ruvuyubn
2jBAX86bjsgA9i76aOy2yEJyy3LrWDTgxn5FQ1I+qU0LDEpXPs7V4LeZSe3OiisW
4QSxYHav5RHrFfmRPmfU38i6p6BKfwyf2K/PnSBMY5HLlq24l/SfN0fqBrHdPEIx
CYO4VkD+ChkEp5rwZGyS+w25fbmHNLCxqpEL8329LMME04z76LHXOsD6wbDZTHYr
d6+Id7tg
=5tHg
-----END PGP SIGNATURE-----

--hl78fHPzFHKAHlNA--
