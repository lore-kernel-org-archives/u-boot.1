Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36AAC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F6F82153;
	Tue, 29 Apr 2025 00:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pIoj+7ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95BF8267E; Tue, 29 Apr 2025 00:21:02 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82928297E
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c09f8369cso1432363a34.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745878858; x=1746483658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SvlO4+dgG1PAlkGxqRMyvZeWldC9qX1xmNiC/2+4d0o=;
 b=pIoj+7llnIF1idh8tW6x9TR16GeZdNjvwSmruwwXC3VXW+ysJDSR3xx0HBLeeOCLKz
 jRsw2idGVHRWlinAEsNZVrNJ397FqlNKTK+p8xZdRj1rMkhqQdU/WOpeP3SFX4LAz+0N
 kLlErJw66eDjcIXiWcuVa2uHFJTP6hKcEzkLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745878858; x=1746483658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvlO4+dgG1PAlkGxqRMyvZeWldC9qX1xmNiC/2+4d0o=;
 b=gtSxZXmBYMz6JSC5+LqMN3a2Yi3wRKFIX0Rpz0x4rfzxJVjOoY7Cfy9PFYbIR92dyV
 LItGFjUV4OmA5N+yzZCe7JHG3vDbNdBxjgkSsGI+3ponOiZ8p6oIo/NHRLHlytI9rDFx
 ASx2ME9vU8kHvhHhlraE9cwkOw7l8Rt4UMTn64JkuQDJSU4Vitmf3zugxu8vJq2hDvzQ
 btt52OI2LgEyE8dBnqQCiYQWcm4C7BhrXeTgUHv1o/c69OEeCbfsAvWfO/ntEDfVjGNh
 XjsKmo8Do/H/lBr2yUJojRxne66HohkJzTC9bA8mHINpcB+fjH21wuJltSFELvUzrdjz
 JmmA==
X-Gm-Message-State: AOJu0YwmS5UhLdeHZgiJq2ptT6OOT8rBYydWSBlNKPDe819R1IyvAoHK
 QDbit5RQG2OVGpuN0hSnBLFKNE2PTzuWTusV0tHmi1W3T7Pe9NACizStShfrx+c=
X-Gm-Gg: ASbGncvmMxibaaqWoWKuZ2mWDhocVTtinoygBsw6Dr0Ck7QEsPDQ/0RVPHabjtAFT2S
 s2HSoiWvzdJuVdhLmPLC4cdk71H/faasGpsjiqriZS2LWQvLDrC5+7TL+B0kUSuHJYYeT6TdFrZ
 Wmu/NKbzRj3oMhpeHTo03/qgvWj+VwS/gWCcEtXtOSsikfLoplMyuA43DMr9W003ot/kSCNekSL
 9aVpJAb8LqLqzrdfLrCY++q3LDwsLuRAZk3Ut0hbWsm+NwMq/4cCROpvflvEqLY8mYjEb11mMuU
 Yy5sMG0VWSuPUa6UFG0LPKZr3Si+t+VtMm3g6LKHzXppeS7tygS7c4hSqr3gWRTpRkc7+uWdukc
 YOa7UazRvuXw9
X-Google-Smtp-Source: AGHT+IFIratSVd4+EOeFRuETwLYR7HwVoKY4JkTg5bHdK8XLWYuIDQfxMxBnJzzj+Pd0Eo4B4r5vSw==
X-Received: by 2002:a05:6830:2aa1:b0:72a:1625:ef11 with SMTP id
 46e09a7af769-7308a58f5b5mr315031a34.27.1745878858569; 
 Mon, 28 Apr 2025 15:20:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b2ee7d3sm17937a34.42.2025.04.28.15.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:20:57 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:20:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 07/17] coreboot: Locate table earlier than
 arch_cpu_init()
Message-ID: <20250428222054.GL5495@bill-the-cat>
References: <20250428192427.3877612-1-swboyd@chromium.org>
 <20250428192427.3877612-8-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gdaPJRqlRITTy9gg"
Content-Disposition: inline
In-Reply-To: <20250428192427.3877612-8-swboyd@chromium.org>
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


--gdaPJRqlRITTy9gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:24:14PM -0700, Stephen Boyd wrote:

> Currently we locate the coreboot table in arch_cpu_init(). One of the
> first things that happens in initcall_run_f() initialization is
> fdtdec_setup() is called which could inspect the DTB for memory
> information (see mach-snapdragon's board_fdt_blob_setup() code).
> Introduce an initcall specifically to locate the coreboot table early on
> in the boot process so that board_fdt_blob_setup() can know that the
> memory is described in the coreboot tables instead of the DTB that's
> either embedded in the ELF file or provided by the earlier stage
> bootloader. This will also help in the future when we want to pick the
> DTB from a FIT image based on the board and revision ID bits in the
> coreboot tables.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gdaPJRqlRITTy9gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP/0YACgkQFHw5/5Y0
tyygTgv/VfWA36/KFK3DnbOPfMi2f7FcPrWK2M6yDlPlHCHJsoN2ABhmCcvzeB+z
9DFBCm0bCIgdQtrlV19DLqH6ndLq3M3fSXNVPVdASXBly9kH1Uq/mbYGc6UV1vnN
BBdjxQOPHSriTYv7KX/IkFYjBK6DoettGPrMXf0oShvWxrub0GBeY6m/ue9x6ZQE
8HPCov7u2WenMTw7ZdfbuNdxwmw+FdmamOe0CKfG0YJDHrwWvteVltuwhcCvrq2A
GCQxW6wiG+bjzZiP3ndRzihVhYhHZgAQm9rIJPbe6xWRtEyb3bCKYGknY/Mb29qG
wgn84BXnSEGOaXT6o9vFzBpCRklnngxLWANh/fHD9MhiTqMUH0INYEhc10P6bvaL
/TLZ7YNTDdrglyXADZ9qtGMsXNuK+bqWHYqePSUslNHP83583smEeD/xq67voJ1W
J8xtp6WlgpP3C3piI7gjxNH9CJ4tLMr1ZO+7f2r8L8jb+IpuXBzT7hCJiiYcHLB4
rV32lp2z
=kW+e
-----END PGP SIGNATURE-----

--gdaPJRqlRITTy9gg--
