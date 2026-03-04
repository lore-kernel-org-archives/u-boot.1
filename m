Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0645AEFCE3B
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 18:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5401B838BB;
	Wed,  4 Mar 2026 19:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qSENakYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C8383D8A; Wed,  4 Mar 2026 19:51:20 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1179783642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 19:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d4b9c839b1so3760359a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 10:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772650276; x=1773255076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RFPeAx7f9578aMGhe5JrCy2rmVQXsZJe+z2aMC1Ww6A=;
 b=qSENakYC1kS3A2T9OGpDlXr4a7LL3MU9qTbwpSOuA+giLwuESBx198qQNWoSd2yBOY
 kUU3Q/o+1ds1SNhQrE2wm6HSb5/rLzD+0ai3ppWdX03K4RVjV7GZjAMApEiIn8kUT3Pn
 mPya4UiaSuBDrHMMyAjtPPUkOCXrUyWoBppUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772650276; x=1773255076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFPeAx7f9578aMGhe5JrCy2rmVQXsZJe+z2aMC1Ww6A=;
 b=Ed+tqCXdU9Jwwm8AYE0+ge08glsJ31UNOZkujvf29WEP/3OeeGRwPGb18j6C6w+FBo
 nF6wOdds056wW0DnldeQMlpkeXgur6oY9tYFCdOQYNnbkBhw6HCT33FRfd3AFGWVf0pV
 gJG52KZx/wDDZfZwhzWWMiYumMa/fk08scAtaK+Mkr8ZkhojOmKKacQEfvmjrakw+4nV
 hp0Xuk3uXNUdv1WfqtUtXPHP7UQE8KSz4AiS1SG4yZNf8KEXTtBsRhMiJ9g4tHsY8rYw
 54PPwO8E+PQBtTkTyLCuFFLtK53tC8lpzBRkGCb84aUiNrNrpgnlIlU7mp+PAMFHfueZ
 vzMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCYbFE0E5N/Eryp5wfCB8tBZ/6m9PDC3cRHjEnJZux1V3HrDblZh+p2Kkm6dOjKQpUQPDr/i0=@lists.denx.de
X-Gm-Message-State: AOJu0YztuV/xQctuRfuPoDgznRprBJ5c1h64gVq59/qIZWVC61tB3mFz
 3MNnhLwziuaAJGkQGKTsA6LGtySm+wzxycZKIgDknaJ2mEpvy+KieHnWyjNjezeB/ak=
X-Gm-Gg: ATEYQzx5u5pBNxaKVw07+Ayyd1dYA338mZ3o/bzEZdPee7gRi0nyqjQ1u1+2eo3RytA
 MZelCDCJkuM+nIHdR0pgV+v4f5588ykuqWtLWQXM9En0oeW4QDthES+hR8gcDUE4IYcFvmJOU15
 F4JzTSR3BKmDD27ek64w18q8r0NmHlGDDya7nrfT72JmoZQuMdQO0yvIpvSdN2irWTlIH7l9b/J
 +YfAkWVc/BqPoi4e6xwtWmxt0haOQVUoiwhqad2RLlwmojiCSZVacrYFEbofNdYhuC7K/qT6hV4
 7HjN2Y0y7a0D8L3ErbEmDYIcF9YHK38zrcJpU+XtlZafII9mlzK5/x7+6VnAdrTZ8UY7S2SRi3W
 lrBmL+KFFkWoZ2sYQsuVgt9yxEerVBjTVZU0kyigVmQGqJMUyOsUb03I1OvRow5USl/VjQco4jQ
 VdkZAvgC9Wf3bmqu+UwbGricu1AOg5XMKG0WN5d5iV99Y5uS9Uqy+j66tqMpyEvyDguVCGlwEaO
 qIE1+twtlCf9oBjgHHPOI3UJV3CiE5L28tRbdKsJdEHfOKO4TM=
X-Received: by 2002:a05:6830:368a:b0:7ab:e111:1a57 with SMTP id
 46e09a7af769-7d6da1e7931mr1777143a34.31.1772650276629; 
 Wed, 04 Mar 2026 10:51:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58666f30esm16065402a34.26.2026.03.04.10.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:51:15 -0800 (PST)
Date: Wed, 4 Mar 2026 12:51:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: m-chawdhry@ti.com, c-vankar@ti.com, neil.armstrong@linaro.org,
 marek.vasut+renesas@mailbox.org, u-kumar1@ti.com, j-keerthy@ti.com,
 semen.protsenko@linaro.org, afd@ti.com, anshuld@ti.com,
 peng.fan@nxp.com, ahalaney@redhat.com, mkorpershoek@kernel.org,
 n-francis@ti.com, u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
Message-ID: <20260304185113.GC1388590@bill-the-cat>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6gEhwZn44u6juGCd"
Content-Disposition: inline
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
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


--6gEhwZn44u6juGCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 03:58:28PM +0530, Siddharth Vadapalli wrote:

> Hello,
>=20
> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
> Series is based on commit
> f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
> of the master branch of U-Boot.
>=20
> v4 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/cover/20251201110103.845413-1-=
h-salunke@ti.com/
> Changes since v4:
> - Addressed Udit's feedback:
>   i) Patch 6 has been updated by limiting changes to disabling CONFIG_SPL=
_PCI_ENDPOINT
>      and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP, CONFIG_SPL_PHY_CADENCE_T=
ORRENT and
>      CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled as pointed out by=
 Udit).
>   ii) Commit message of patch 8 has been updated to indicate that althoug=
h PCIe Boot
>       is supported in Hardware for J742S2 SoC, it is not yet enabled in S=
oftware.
>   iii) Documentation in patch 10 has been updated with complete set of de=
vice-tree
>        changes included and the C Program to transfer bootloaders has als=
o been
>        simplified and documented with the usage of appropriate variable n=
ames.
>=20
> PCIe Boot Logs (J784S4-EVM running Linux as Root-Complex transfers
> bootloaders to another J784S4-EVM configured for PCIe Boot):
> https://gist.github.com/Siddharth-Vadapalli-at-TI/2d157003818441fe79a139d=
0dec1058a

With current next this introduces a failure to build on j784s4_evm_a72.

--=20
Tom

--6gEhwZn44u6juGCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaah/HgAKCRAr4qD1Cr/k
Cv2NAQCkLh/7qo/X5nyA5SRghD4yTn4byhi6M+97lRDucgEnmQD/XVrJP2LfoJ+y
kxiQ7EDIexBIJBc6Ucq7aYrXtYV8CwQ=
=8jZz
-----END PGP SIGNATURE-----

--6gEhwZn44u6juGCd--
