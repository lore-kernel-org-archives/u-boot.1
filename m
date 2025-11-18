Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1849CEDD97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5B483D07;
	Tue, 18 Nov 2025 15:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ioiQxx1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1BB83DEC; Tue, 18 Nov 2025 15:39:25 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B8983B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso1306804fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763476762; x=1764081562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ajPPqT8/GuLpVqBBRhGqjIQ+RgH6JAsJoCh0vJTNfV8=;
 b=ioiQxx1wsvS4i5fLbSh5ItqaBWlAN2+JgPzTRkORHAS0vuTml4RNgiVbYGUJnuC2/y
 44KJQIIPDv2kAfDH6NIuxd4LC3oQv3SBmHEQ14XIaq4bjc5k8dw7/r9VOWQNzRdxR1i+
 ln4S1DfL1vZ9qEEgZSNqw9C90weCmvURYudDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763476762; x=1764081562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajPPqT8/GuLpVqBBRhGqjIQ+RgH6JAsJoCh0vJTNfV8=;
 b=ehq/z4vCBEpYarj01cRXMpxdyYVh6OdO38xiAkKpZ0BGeyfmOB+VhGGqG093ZBd92d
 VKAfbmw/LFmBOOBpujerOZe+FD3r4zDFsG5i0ZsZ94bZYCeysMLFQvTUfiDDGX5UJRFk
 LSnnuxDDR10ZfAlnszyLCRGpdhrrgu63Homwf5O8lGP2MYQ53yCIYwpVv0NvuhV/FkHB
 gPDVs5P209oV4fdQkHvGydhWVpgCNIX4JGhsMnpJPniO6VQOWeZCUP3H4oP7pTT6crJA
 f/T+igTOcsgtdjZkXnQmELSXDtM6drC+t9DSJynQU4eBsweaINORMHRR65AN9QtWjfoo
 iV2A==
X-Gm-Message-State: AOJu0YwBpqu/+tn8qSM+/LBzZNZIJhJ+FTRGDkidFiEjTpycewoO7yvf
 6bnHRr1DvXP7xG81lfDk5r7Vqav84XJNoZfH56mU/Z9uluvBhv3vPEcd22garmZ1ZgQ=
X-Gm-Gg: ASbGncsmvUoze//lOT1l2rQR2TLjcLNkCpmprTelQeTda0RuUlZcXUwS/RZzYs8i7zd
 gm5GMryDvXERMPjJv8U+cg7gxPW/M0AGyAkfQyNQFM0RCVcUKqkBFsXvTU83uWDxXxuViO2WxGW
 kVkCHJ3bAV0EIShWuLiqBbDNX7Qh98yqTjt60R+riaBJT2+492eBYHbhSle/vOVCtbTfkyJBayK
 z/40wwWog00p2hNeff6Rvf/edZwrvDjWzCQfdqVH5Di9mvimk65QIVJ3kxqoJVZJZjAiHrZVSHk
 naIV2RUvUbsJdSvGodFv/zKPhzOJynDN27N7Z4miXNu87DqgqQQR5M8PX/bUxWXsxborcID4v0u
 GJu3Dj7YZIM2uPxg+aa0penvSFsrEXSbz3gj6zw8Nou2NyFvZRd9+z75OcXuPcGnl/PHiCzZkNC
 IAEDsYW3JhrOCBHoS1RIe0tJFW+OzQlu6EE0cxucPOiX6XkXR4Q8b5mAvyX88T
X-Google-Smtp-Source: AGHT+IEgEbNHzkWL/WmwfmMvnT4+Ute5XrhAcNUWUJY//dyXdWZlL23euWSB17De15eBeFbV2tkegA==
X-Received: by 2002:a05:6870:7a8:b0:3e8:93b4:a042 with SMTP id
 586e51a60fabf-3e893b4a630mr5815517fac.51.1763476761647; 
 Tue, 18 Nov 2025 06:39:21 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffcdd8sm7167471fac.3.2025.11.18.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:39:20 -0800 (PST)
Date: Tue, 18 Nov 2025 08:39:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 05/12] docker: add Analog Devices tools to docker image
Message-ID: <20251118143918.GS2125796@bill-the-cat>
References: <20251118064000.14613-1-malysagreg@gmail.com>
 <20251118064000.14613-6-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AsB6meJJOxrVaVmW"
Content-Disposition: inline
In-Reply-To: <20251118064000.14613-6-malysagreg@gmail.com>
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


--AsB6meJJOxrVaVmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 01:39:38AM -0500, Greg Malysa wrote:

> The boot ROM on Analog Devices ADSP-SC5xx SoCs requires code packaged
> in the LDR format. Normally this is available as part of
> our yocto-derived toolchain but, it is not a part of any other pre-made
> toolchain anymore, so it is otherwise unavailable in the docker image
> for CI. This patch adds a source build from the ADI maintained github
> repository. In the future, a package available for install via apt will
> be available, but currently there is no arm64 build upstream, so we must
> build from source for the time being to support CI on both amd64 and
> arm64 runners. The same ldr tool is used for arm and arm64 for all of
> our boards with names adjusted to match the expected $(CROSS_COMPILE)
> for these boards.
>=20
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
[snip]
> +# Build ldr tool for Analog Devices boards and create prefixed symlinks =
to match
> +# $(CROSS_COMPILE) as used by different supported platforms
> +RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linux-=
gnueabi-ldr.git /opt/lnxdsp-arm-poky-linux-gnueabi-ldr && \

We need to be getting a specific branch/tag (or worst case, commit) and
using --depth=3D1.

[snip]
> +ENV PATH=3D"${PATH}:/opt/lnxdsp-arm-poky-linux-gnueabi-ldr"

Does this actually do what you want, update the PATH for the shell that
we spawn and run CI in?

--=20
Tom

--AsB6meJJOxrVaVmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRyFFgAKCRAr4qD1Cr/k
CuM3AQDMrK1hmh/iQOqL/Wukt+1M0EOoL9+SJUklnQqsLaZHugEAjb2QDeS6Ih17
16ZHeAzpT2ICaaQ119OLghrI1G3Iiw8=
=EEnp
-----END PGP SIGNATURE-----

--AsB6meJJOxrVaVmW--
