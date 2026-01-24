Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E1D715E5
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 14:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B9A83B32;
	Sat, 24 Jan 2026 15:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YCrwLuOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B42783BC4; Sat, 24 Jan 2026 08:14:25 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764E383B86
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 08:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1B58427C80;
 Sat, 24 Jan 2026 08:14:23 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qITgQLo925z2; Sat, 24 Jan 2026 08:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1769238862; bh=Wr7POptxM1aPxX6pVQFoXO4J3Y7afmCIeyggA95b4RU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YCrwLuOyyGJD61fd8efah0ipKchyuJkuaAXMnwtPEgwRkuJGFdBaLH4jxTrznkIfO
 E4yefICrrCxHgDwtzOaPcZ7j0LrzY0HzbXuiPbU9aJxSqqZGTHl7lFgglRB0W/WkGM
 12P0fCXKqgqVPf1SKSCklvo193i6pAePwmb4DN7CB028zOiODzVqtUUHYeiVUcIEJI
 PjQFCrs4C6mDnBBGIsuQfQuz3CI2i9dqJ9LCZYqDOXsW0hlfZamn+SMlIzP9nyQlP2
 dONacyUWE8cP7cl15rAYI5VHecxaxzY0RyBf6NvvSBCzTKRVXpPiv6iT5TANM8e+XX
 2izlX9XmnIdRA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 24 Jan 2026 12:44:17 +0530
Message-Id: <DFWMTYEQKEJ7.2KB7GXDI6E0P8@disroot.org>
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Tom Rini" <trini@konsulko.com>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH] dts: add exynos arm64 vendor support for
 OF_UPSTREAM_BUILD_VENDOR
References: <20260123-dts-exynos-vendor-v1-1-479e72170257@disroot.org>
 <20260123182003.GN3416603@bill-the-cat>
In-Reply-To: <20260123182003.GN3416603@bill-the-cat>
X-Mailman-Approved-At: Sat, 24 Jan 2026 15:35:21 +0100
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

On 2026-01-23 12:20 -06:00, Tom Rini wrote:
> On Fri, Jan 23, 2026 at 11:41:41PM +0530, Kaustabh Chakraborty wrote:
>
>> Set OF_UPSTREAM_BUILD_VENDOR to build all devicetrees in "exynos/" for
>> Exynos-based 64-bit ARM platforms (32-bit ARM uses "samsung/").
>>=20
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  dts/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/dts/Kconfig b/dts/Kconfig
>> index 870f75ad3ec..e0f6f03a343 100644
>> --- a/dts/Kconfig
>> +++ b/dts/Kconfig
>> @@ -124,6 +124,7 @@ config OF_UPSTREAM_VENDOR
>>  	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
>>  	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
>>  	default "nvidia" if ARCH_TEGRA
>> +	default "exynos" if ARCH_EXYNOS && ARCH_ARM64
>>  	help
>>  	  Select the vendor to build all devicetree files for.
>
> Two things. First, it's "ARM64" and not "ARCH_ARM64". Second, since we
> know what the 32bit one is and it's not the same, we might as well do
> both while we're here?

Sure, I can add it. However "samsung/" in ARM also includes pre-Exynos
SoCs, I assume that's not a problem here.
