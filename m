Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFE1C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 12:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E8688498;
	Sat, 18 May 2024 14:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="oXFoDu+Q";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWd6Li0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2243D88658; Sat, 18 May 2024 14:27:41 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BB8882E2
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 2C8331C000C5;
 Sat, 18 May 2024 08:27:36 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Sat, 18 May 2024 08:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716035255;
 x=1716121655; bh=770r4bYRQlijsUd9gM2UbGMPOAv821GNLqzP0ISK7R8=; b=
 oXFoDu+QNIyPK4kZ5Kq3BAPvYrwyG8ECwgijhpkMHHIJ2g60zjcchWNAWmIjXTX2
 MujR8E/crtIDF9vRLDD8mf8ndxu9yVkGv4plQNvdC1fSAnMDHWj54aYbmbNuIzRA
 XoezlNBsvNj0JOlguyN0G/QtoTERyo7GQi9VErs8DJMuQDm0rs/ij7MMZihXNp4u
 /I6ohmvgt6WJDUDeuzY7ddUjp6DZCLCY6Il0RNIv4VOgO+A9iMOkukyNgejcKcyY
 bH7FIorOIzTvU9Z51Yrcj2secmqq/7OKwR33IwLY6yXCAcyUsxl8QkLg5952jkkY
 mzz7v8Bw4HhBPHUrZLky7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716035255; x=
 1716121655; bh=770r4bYRQlijsUd9gM2UbGMPOAv821GNLqzP0ISK7R8=; b=F
 Wd6Li0vBYlKeAeor2oXfwiHZqg586XcAoYZ4LIZCOQVXpd5hcBKJCIrEiTL+vlo7
 wQ7LPUlpqqnbMJ8PZ2C56uNBrTusXDN/EGzvPBT90s4kguSY4uM5+n3R+Pj46h5G
 oFCKggoiiUOaMDwlArM9tg3fWcrwd2TgjjqdDRTMnp2iEbOfNfQ8VFNTwLKcxleB
 lrjVDjNfiw8UzoAkkXLDaa96ZzkvwEyWcnf4kyvVpKM49mQjNwlfNUfW+Qnmyo7n
 FJk6mB/gq7xtb1c4t11D8mIpv5dOmanNwUDSq1YCOStsaJoy8zK0WTPKLGxVnGFY
 Y4pJG83PUKnPuBMKUbawQ==
X-ME-Sender: <xms:t55IZtM3QjYxRo5nwORtGiHcNoN3MvVZNoOidanZoYzcRGGlfEATCw>
 <xme:t55IZv9y01BdZm0ewfrV8j34PI2R9MBA7vqeH3eIwKF00ZBTb-cxxuZfdFuPMkyKD
 3P4pdBZgNq0JTEQLrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehiedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:t55IZsRozX9FUMDR-XXW_OBU7-pvNen_jFMpID5NG1je97uxcezxVA>
 <xmx:t55IZpsfKcj3XRelTxI2uZpQMMgTSFcwot5-6xP_gHO4YtAN_Trxag>
 <xmx:t55IZld7D_XYRvR7t-_plkcbx1kqMSU_ICpxUxzs8aVBfkDrDc3imQ>
 <xmx:t55IZl1Kguee_npfwFBY3kqF6gTAraCLElARVwFwXVXHaT9aGbEmeA>
 <xmx:t55IZs68Uv7Q_reBEj7dDBSlQKO5TDTzbrRCz8bWmi6cUBG6itDNsAPD>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 834ED36A0074; Sat, 18 May 2024 08:27:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <7a16f84c-4711-41fc-977e-5ca9fc93d93b@app.fastmail.com>
In-Reply-To: <20240517-sandbox-hostarch-kconfig-v1-1-716c146635c9@flygoat.com>
References: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
 <20240517-sandbox-hostarch-kconfig-v1-1-716c146635c9@flygoat.com>
Date: Sat, 18 May 2024 13:27:16 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/3] sandbox: Move HOST_ARCH detection to Kconfig
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=E5=
=8D=8811:09=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
[...]
> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c=20
> b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> index f668cdac4ab2..2dfbb7c74075 100644
> --- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
> +++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c

Seeme like I forgot to move host_arch.h from this file, I don't understa=
nd why
does it only cause problem non-sandbox build.

Will resend if no further review comments.

Thanks
- Jiaxun

> @@ -36,11 +36,11 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>  #elif defined(CONFIG_X86)
>  	asm volatile (".word 0xffff\n");
>  #elif defined(CONFIG_SANDBOX)
> -#if (HOST_ARCH =3D=3D HOST_ARCH_ARM || HOST_ARCH =3D=3D HOST_ARCH_AAR=
CH64)
> +#if (CONFIG_IS_ENABLED(HOST_ARCH_ARM) ||=20
> CONFIG_IS_ENABLED(HOST_ARCH_AARCH64))
>  	asm volatile (".word 0xe7f7defb\n");
> -#elif (HOST_ARCH =3D=3D HOST_ARCH_RISCV32 || HOST_ARCH =3D=3D=20
> HOST_ARCH_RISCV64)
> +#elif (CONFIG_IS_ENABLED(HOST_ARCH_RISCV32) ||=20
> CONFIG_IS_ENABLED(HOST_ARCH_RISCV64))
>  	asm volatile (".word 0xffffffff\n");
> -#elif (HOST_ARCH =3D=3D HOST_ARCH_X86 || HOST_ARCH =3D=3D HOST_ARCH_X=
86_64)
> +#elif (CONFIG_IS_ENABLED(HOST_ARCH_X86) ||=20
> CONFIG_IS_ENABLED(HOST_ARCH_X86_64))
>  	asm volatile (".word 0xffff\n");
>  #endif
>  #endif
>
> --=20
> 2.34.1

--=20
- Jiaxun
