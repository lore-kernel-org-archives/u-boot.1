Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AD7CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 16:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 506498329F;
	Fri, 19 Sep 2025 18:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mtGPj7/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73F7832AD; Fri, 19 Sep 2025 18:10:16 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC1883285
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 18:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-751415c488cso2228081a34.1
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758298213; x=1758903013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IkapZhfiGFdgifyx3E+Fj2CB4dEMIrOdW+eQQL7ZqMs=;
 b=mtGPj7/SJv4m+5zmh5xPeb2k/qQwXLhnLOpACDOTXFG9LfPDtIDTNIfRIAExIA4ens
 373wx5XIqW3TrEopqtkY3Pp71vHiYqMmFVn2JC6vWPIR4sEMAXjn8nd/qv1z56iNO6xr
 uMRrfyVTVfAAoyytMF7lNDgq5zAXscEvv+0Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758298213; x=1758903013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkapZhfiGFdgifyx3E+Fj2CB4dEMIrOdW+eQQL7ZqMs=;
 b=sYDBuXnEj8ze6dgipsalUkeXKexruc6xtAZWsr6WpuHdpqjQVCY+ChC03jBhIibWxD
 q8qOdA8s46vC8LBVweTVFhJklzhljwNYY06MS7ZA71HlS3ccZzhYlP5KFHwLuAk93gVJ
 /4bOLtN2bhmgnhFneZE7hKPRynXkBGVHuJDtn7eBH+RUKcwWVuEd/GrUQGrW6UiPGUu/
 1b2wXeTCXRFMjusnKrNW2/GOVaMYuPSC43Pv45BCFw1tJ+6umUl2YYT+AhPdrnZf55bL
 nLSAMQX4Pt6Lm9fjUc/CCjanrqkMISFDDEQ5iBJFBLPB/Gpana5hRFzOqQVdYSVqpDUE
 Txig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgdEguhAkFAE0I7V84HpfC2z2+wZyIIzFueW3dvebAx7ot/vhf3HgudFi3srRUdO+zOqd76oo=@lists.denx.de
X-Gm-Message-State: AOJu0YyxHRJf4zf88j7IwDUUnV2N47VlPDucOFco3X6K78Q/FJS8ElFi
 9YFMQN86K7JOsz6shKX7TUIdSy9IstoFrzhZbqDf84CeZ6G/iRwDFrArCzaHmv/u/PE=
X-Gm-Gg: ASbGncuyU+2RLYxV1aG+UQHiWsEFeqhBzg+JBKJchFCdQ1GU/mGG9VR5WQX+wvlM+Ij
 UTiHfG2k8QaNkAhOAPOhi2mYiUh9CRjlHrIMjCQi8J/NWaKuqn5wEpKDJRKTJ64++f/hPxDqn4u
 BIOOqZMzVOv2QXAO+63+PRR9BgDkw3anftPTSHWR84xYc2nyCwx1m9TWBXr+henPToRZubgqhWR
 aCbA6GGXqWrfRZnZNU/wBiekYzA0sgM2UtZTYo/cIYV6gc9NGP9mEiwBLR5EOuTPB7777wpnP0n
 xA0Ylcj8j7Wg86lrUcuMsfH8ZrPU/+1D5/ijSC+ZrWPJI/1QlkAUSmjkSkuRWPRYOBHKqEQJuLe
 xA1q7DF2lBET+pjUbZ5LWWlvpSVeOZXT4/PUQ2meK+c7bGgYVUxxjvZdC
X-Google-Smtp-Source: AGHT+IGbxUM0Wnv3JQq4g+HByRDv1NAREJb6H2K/Aa3i93woxHlnGu4c1RprHiZqMxvUxSU0kA8SXA==
X-Received: by 2002:a05:6830:2a16:b0:74b:3422:f327 with SMTP id
 46e09a7af769-76f79078c6dmr2024518a34.24.1758298212509; 
 Fri, 19 Sep 2025 09:10:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7692a974e35sm2510285a34.33.2025.09.19.09.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 09:10:11 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:10:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH RFC] lib: optee: forbid OP-TEE OS loading without adding
 OP-TEE OS reserved-memory nodes
Message-ID: <20250919161009.GX124814@bill-the-cat>
References: <20250919-tee-env-needs-optee-lib-v1-1-2d52e75f7580@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nwKZIC7Dksuk6W8q"
Content-Disposition: inline
In-Reply-To: <20250919-tee-env-needs-optee-lib-v1-1-2d52e75f7580@cherry.de>
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


--nwKZIC7Dksuk6W8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 05:50:21PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> It is currently possible to build an image with an OP-TEE OS (via the
> TEE environment variable) without OPTEE_LIB. U-Boot will happily load
> the TEE OS and the next OS (e.g. the Linux kernel).
>=20
> This is an issue because on FDT-enabled devices, OP-TEE OS adds nodes to
> the reserved-memory FDT node for the memory regions it just reserved for
> itself. This updated is then passed to U-Boot proper which should know
> better not to use memory from there. The actual issue is that without
> OPTEE_LIB and OF_LIBFDT enabled, U-Boot proper will not copy those nodes
> over to the next OS's FDT before starting it. This results in the next
> OS's (e.g. Linux kernel) to not be aware of reserved memory, incurring
> random crashes or device reboots when it tries to access secure reserved
> memory area.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> I've just lost a day trying to figure out why my board suddenly boot
> loops when running a specific program in Linux userspace after updating
> U-Boot. I actually inadvertently had the TEE environment variable set
> for a device which doesn't actually need to run any TEE OS (so had
> OPTEE_LIB disabled).
>=20
> This device is Rockchip PX30-based and the image is built with binman
> like all Rockchip-based devices.
>=20
> The issue is that I built a U-Boot FIT with an OP-TEE OS that reserves
> some memory regions for itself (via the TEE environment variable) but
> U-Boot proper "forgot" to propagate those to the Linux kernel's FDT
> (because of the missing OPTEE_LIB).
>=20
> Unfortunately, binman doesn't seem to have access to Kconfig symbols
> (grep CONFIG_ doesn't return anything meaningful and binman is either
>  configured through FDT nodes or via CLI arguments, c.f. cmd_binman in
>  the root Makefile) so I cannot try to be smart and guide the user to
> the correct Kconfig option to select if TEE is set. I could add a
> property based on the presence of OPTEE_LIB in rockchip-u-boot.dtsi for
> example and have a custom message based on that, the issue is that I
> assume all FDT-based platforms do actually need to do this dance, and
> not only Rockchip.
> Another option could be to add a CLI argument to binman through which
> we would pass the state of OPTEE_LIB and error out the build in that
> case, but that feels like opening the door to dirty hacks (though this
> patch is admittedly another dirty hack :) ).
>=20
> Another option is to propagate the TEE environment variable to the
> preprocessor of the FDT (via dtc_cpp_flags) and then I can do
>=20
>  #if defined(TEE) && !IS_ENABLED(CONFIG_OPTEE_LIB)
>  #error "CONFIG_OPTEE_LIB must be enabled!"
>  #endif
>=20
> but we have the same issue as above, it is then Rockchip specific and
> also feels bad.
>=20
> Another option is to remove the @tee-SEQ node from the binman FIT
> description when OPTEE_LIB isn't set but then I would lose the nice
> message when no TEE is provided:
>=20
> Image 'simple-bin' is missing optional external blobs but is still functi=
onal: tee-os
>=20
> and even worse, build without any TEE OS even though I could provide one
> with the TEE environment variable.
>=20
> Finally, another option could be to move this hack under
> arch/arm/mach-rockchip/Kconfig to make it Rockchip specific or add a
> depends on ARCH_ROCKCHIP
>=20
> OP-TEE OS on Aarch32 Rockchip boards doesn't actually need any of that
> if SPL_OPTEE_IMAGE is set because arch/arm/mach-rockchip/sdram.c then
> marks some hardcoded memory regions in RAM as holes in DRAM, which has
> the same effect as reserved memory regions I guess. I assume other
> platforms may use something different, so it may be casting too wide of
> a net.
>=20
> Does anyone have something more delicate than this sledgehammer of a
> solution?

It looks like on other SoCs there's an ARCH_x wide imply/select OPTEE
(which in turn gets OPTEE_LIB), so is there a case for ARCH_ROCKCHIP &&
!ARM64 && !OPTEE ? I see you explained that 32bit has a workaround for
this already.

--=20
Tom

--nwKZIC7Dksuk6W8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM2AXQAKCRAr4qD1Cr/k
CsICAP9nDuV8WOtqTVs85eVxTLOiRt3R/R/SqUTK0q0fOhAn+QEAmKiNZzBc1EVk
i2ggLmUWREgCmlD2Bb1iRox0KGEU2ws=
=tOwL
-----END PGP SIGNATURE-----

--nwKZIC7Dksuk6W8q--
