Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD3BC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 15:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 712C7406F3;
	Mon, 21 Sep 2026 15:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lYtGJRlj_0LW; Mon, 21 Sep 2026 15:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BC4FC40811
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790005862;
	b=fOAqACpQSkPWz9dYXhu0tZ51WrPnyE8kWgpT5SjNhTob4OHbPsciJSQEEMRZiTcLOc4X
	 2sD6vTiKmzvjGFTAA8oBWE+wF1xQE80DyQK6mCLsD/cYsRfyjctksZVpb9ncYxwgtSzW2
	 DI2eU+kYx8ZH8EY2eszL6YuaNdOq5AmkG7K8ceCG+Ssjgnbl6SB65z1+9uVkjBXdR2roy
	 +O+fNw5Tm2rIAlFPZLz/JQNRRSu2Uk2gfDXY+ruIEe4/zfNoxe/XjaIJWiPgFQv3kGd0V
	 ar9vguQOiJJCIr1wCdYnVMEu9ow/txkRI63Jrkx5jIB6FebHhRgTeCkGB0ABzpDeYDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790005862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PkjhCwnPJjIBcdqpSMDVHwO3wh0iYz9Thz4f25IAg7k=;
	b=EaL50ZHDeO/oN9/VyyQeuJbvSZ1zxirzyxcG0+LVl4ISxu+tiPam9EjAIAf6qBWUR4hT
	 8qIDWoS4kKcyQ+L4pKRp7cfIjvQuJ+iMquVSbaYMiZjMLCehxWMo+BXLbFenfRNAjPN+1
	 D3DU8dO17I1FiM/39SZ6uzex4If74jjeqtiPDHjuKjF7OSg7i0UaFLqrMJfQmlYkzUk25
	 C/Uxj/OlVdSNtOoBT6lTPy+qFi+DIFREkZwPHLVA3NdVEQQnMV9QIhMzzHsvmjvvffirY
	 2iBKvzkQGrO4/ofmUKEA1EiSmwjlbTvEPpT0yNl7zwOuuAGPWtWsYTfdcAOTxL0/mvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LuHgUgV6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790005862;
	bh=PkjhCwnPJjIBcdqpSMDVHwO3wh0iYz9Thz4f25IAg7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cb9J2zpg9jjJ9xbUmIMeZPqD8L0vZqkWJIWwtXwcLxDghlBOwpmMF2yB6oeaz7g9p
	 yZFTZjpgRf07ASurd0WcGIHvmUekGcmoPdC3kzEis4p6SQHPz5FaMszne9EtY1TqMT
	 E+QV/zKctNofrSQ3+yGurjDuFvCo5lcHFS/QdEGZ6ArJonJlx70waQcIw8cfncQ/bK
	 w03Ha/ZgyKaODKf36cb3KCn0hC3TTOWOrQCVYSI6zsrmav6mRBUGHUZN+thVkss2YD
	 WzxnutjKXvAMKpfEGsDwcmPIplGDnnm+/3jJf5qOR65MgPTokCPZScMYZ9SQUPthtx
	 4cg/BuLq/7L7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC4FC40811;
	Mon, 21 Sep 2026 15:51:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0D0112C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6B56406F3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8GS6mLtoeXys for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 15:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D87E40811
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790005860;
 b=DdSPfzDEYlzuT5xeLlme45HUURYFX0XK26CprX28i7fW5d+CPHhxuMZXhQGmnMnXhsGJ
 pY9AWhNjm5MElck/zQMn6ioQNZPeg2eol+/UtNc4AfFD1YF9Dgj+sw8Tn3UT27w986yeK
 bp11AWHI5GO+n5QhofoTD5thjQMru/yf5iJFPPCQmVAWzIV0Q6VTP01f8ZQhZZCQN0TNH
 dChBfwwLAAbP74DDSVtfQAmdJ1duEjJpgTzGCTaCyAFWAQ612PqTal1D+wH/YE1DsNMGI
 jMlV8XCkBY4tASGMyCyLfE4RM9rso2hdDQu9p3r+aP8+sU1DGmxju1waaDGPz6AdwBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790005860;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=PkjhCwnPJjIBcdqpSMDVHwO3wh0iYz9Thz4f25IAg7k=;
 b=ahomCZrUewn/4SQAI5D2P/hN++MdDi6flHX3ocY271uejujLQ3JyN6F1+AW4u/ZMaeFp
 lfC+bpVIAh5UfxiUeUCt1KYyY+vI0qaC3b46m2Ly9+LyQau3SBAX/YWzHrweVMbe4BzyV
 8qBIBbOFWi7j19KI/lrkWYYluIhZaXU5S2Bf3q7WgqFMKm4l0xK4UuFyLmXVfT7QCedWX
 yc3QALO3PPaHTRLf4VX46MEgj+flybVPv+xr0RasItpll/wJPDlXjDV1ujbi7DIRg8CMt
 pmcph1te3I2+eioMijUMJqNtWk1Y+gzRmrGKwNGUJUIEijZBS2TCHulFcRzr99QSuYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LuHgUgV6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::c;
 helo=mail-oa2-x0c.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LuHgUgV6
Received: from mail-oa2-x0c.google.com (mail-oa2-x0c.google.com
 [IPv6:2607:f8b0:4864:30::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D87E40811
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:50:59 +0000 (UTC)
Received: by mail-oa2-x0c.google.com with SMTP id
 586e51a60fabf-46a63c34533so3615510fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790005859; x=1790610659;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PkjhCwnPJjIBcdqpSMDVHwO3wh0iYz9Thz4f25IAg7k=;
 b=LuHgUgV6TQUQq49Ie0g8R8zKO/3AkBuVa6MxyyexD49tlYCsmpx/58TlgXZS2ta/DQ
 AADkq90fnpTk+/ZkH95cJLU0ibn3xUq85M9dY+VEv7udUBmYy6+K77TSXofT1gtbolp8
 Zu7sIED7Im7/jG6hTwka9encb9xd/GZWQJMY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790005859; x=1790610659;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PkjhCwnPJjIBcdqpSMDVHwO3wh0iYz9Thz4f25IAg7k=;
 b=tSXdOG01Sydn6f5djXbTGfFdnllSeo782TGAy6+7kvBzMCygkYjabrERJ6HJWGBhz2
 /vZsJuz52FntddSbQKTKQ6NqaO2+8dJhrVkHjaHkJx8yrwZQsetV/++8HudfckmQkykQ
 OTEpdOTx/WN+mE63GxjB4h9bgh3rtr2Qh97dZVDIwFY7+iRctonayG7sCgWZkcH4/3dm
 lRMIJueBIN6OIlD5xo84mq+pLHMCcEXpzoOFiae8jRn6ODrn3BXscMFJz08ARzmfW/6u
 ZrffpHO9vSCmBxiZ5KzPtBgF9C8hvrwXG7zFRAjzv+mJ4XuTLmlWI1f9MGb24AEcYhbN
 w8og==
X-Gm-Message-State: AFuF++nmLuyK8t9p0t6LPMpylSEr931eCr3uYo6ip9OLR6ql/fqGG7A7
 Ngl+r6cDs7joSn5ATNmtY0pzWcPXd8oVH5RLydfHxIHghsO5/R1NDIa6Y68uQDPiTLo=
X-Gm-Gg: AYBFou0sRk5GWjOagqSG/BoTvEN8WGcejTxh/Ofm6R7yojGBqC/NvtqQaaDMo42wx/R
 i/HE2ujALC4Q1yW79b1jEZmCUt/ElRdCrxP2qlk5e8GklbYdd28GGrx8s/MmfaKRgCEqBZYjp92
 UZvhy80FMmoqRiAMHoi0HxMNR7kG5Yw3oWzItAom0RQDRcoje73ztX2UypQMBg9aLYekHVS9r9I
 tZf+xjvMGAB28lHCBxjvTkXzJ5zLm2jnSUkD1afToEalYQw+HTxkERmhBa6ZT9NBNE3LtPk0pc6
 aWKQXgVLpL1aaF0Xfx6ojK6QFNB5YqA7SA7Q2EhJfZo+cY8AHHYJEfxuoqr0vtxxkZNyL1Kxi4t
 BDGsJscrhTXjtm3adOjHTWcHQkbBS8jgEPIifypLv2Z8ESxttpjLgVXNDXCJbCma4onyacQ67ML
 ftX6EITaDQRIBeQ0FOZhAI8IafNwrDuljUKXw0DQZcg3q2WOxgqEGr/cYP1NeQMRC3bljGtOrxI
 RbxYe4uRsZnKXE/zZOg2iHNflxsZdXogYfW2P2f8Cq/VuGQOrWb93/sncfbAS/NOa3K8Yuwu0qL
 lKSxqS68x7gTqvaMggE=
X-Received: by 2002:a05:6820:7093:10b0:6cd:3ffc:ad08 with SMTP id
 006d021491bc7-6cd3ffcb687mr4767316eaf.88.1790005858735; 
 Mon, 21 Sep 2026 08:50:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d145bc5929sm337216eaf.3.2026.09.21.08.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:50:58 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:50:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: u-boot@lists.u-boot-project.org, weijie.gao@mediatek.com,
 ryder.lee@mediatek.com, chunfeng.yun@mediatek.com,
 GSS_MTK_Uboot_upstream@mediatek.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH 1/2] arm: let a defconfig ask for the Linux kernel image
 header
Message-ID: <20260921155055.GZ858934@bill-the-cat>
References: <20260920151512.401899-1-f@lex.la>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zMk7KqheTV2frrIT"
Content-Disposition: inline
In-Reply-To: <20260920151512.401899-1-f@lex.la>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--zMk7KqheTV2frrIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 06:15:11PM +0300, Aleksei Sviridkin wrote:

> LINUX_KERNEL_IMAGE_HEADER has no prompt, so a board can only get the
> header through a select in its platform Kconfig, and the text offset
> base it needs has no prompt either, so a board cannot set it from its
> defconfig.
>=20
> The header is what a stock boot loader that only ever starts a kernel
> image checks before it jumps, and a board whose stock loader cannot be
> replaced has to be chainloaded through it. The Keenetic KN-1012, an
> MT7981 router, is such a board: its loader accepts a kernel FIT and
> nothing else, and U-Boot runs from it as that kernel. Getting the header
> onto the binary took a platform Kconfig change for one board.
>=20
> Give both symbols a prompt, so a board defconfig can enable the header
> and set the offset base the loader expects. Platforms that select the
> header are not affected, and the existing per-platform defaults for the
> offset base stay in force.
>=20
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  arch/arm/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3e9f3b5103..cc40be0048 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -92,18 +92,19 @@ config SPL_USE_SEPARATE_FAULT_HANDLERS
>  	  on them separately.
> =20
>  config LINUX_KERNEL_IMAGE_HEADER
> +	bool "Place a Linux kernel image header at the start of U-Boot"
>  	depends on ARM64
> -	bool
>  	help
>  	  Place a Linux kernel image header at the start of the U-Boot binary.
>  	  The format of the header is described in the Linux kernel source at
>  	  Documentation/arm64/booting.txt. This feature is useful since the
>  	  image header reports the amount of memory (BSS and similar) that
> -	  U-Boot needs to use, but which isn't part of the binary.
> +	  U-Boot needs to use, but which isn't part of the binary. It also
> +	  lets a boot loader that only starts kernel images chainload U-Boot.
> =20
>  config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> +	hex "Base of the text offset in the Linux kernel image header"
>  	depends on LINUX_KERNEL_IMAGE_HEADER
> -	hex
>  	help
>  	  The value subtracted from CONFIG_TEXT_BASE to calculate the
>  	  TEXT_OFFSET value written to the Linux kernel image header.

This isn't a prompted option as boards that need it are expected to
select it and provide the correct value.

--=20
Tom

--zMk7KqheTV2frrIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarFSXAAKCRAr4qD1Cr/k
CirsAQCd2yOvD/wdPkDg8b2//gvOKRc/+bE+stQusjWNIyZm4AD/SQNphvwKkr/y
stk+rDe+idrFRi/SVLz3wQCt4H+5JQQ=
=9Z/y
-----END PGP SIGNATURE-----

--zMk7KqheTV2frrIT--
