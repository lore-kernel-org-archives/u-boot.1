Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB64EE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5C086489;
	Wed, 23 Aug 2023 09:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="08ezvKMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A52864B4; Wed, 23 Aug 2023 09:47:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EF886485
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fee843b44cso33737415e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692776870; x=1693381670; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOM0iyk0qe42IBXNBqInDPW6wskVIbcVX4xcCzkFzUw=;
 b=08ezvKMIIHE13/ZXwr3RwuaMayG60Ed+yK7s4gzgCeapz4mNU6fhL9IOxWhhjOzJq7
 ABZ2F5U99DdgV8vhBVMdrC/+LKAoV6WTjeq0wRLHcspi7E6hvLL6vkplTO3+aBhFrYD0
 6A/3U0NbVQv93FE470SL5gvWG+NIydiZ1NihNbrs2F7NAlgi3muXSmBHOBj4cLLm1k/n
 y2sLgNB++nMIj0gkpuY536gxMVvshS3GAv/VigpzNU4SdtqQK/voMmVnDQjzhGDyvQuQ
 x5sg7VFDWLhaDEMb6IvNSN5fWlla+DoFgBM1fr4apeSx2fSuxv8S9khlxO8N7ZajugOQ
 KajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692776870; x=1693381670;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uOM0iyk0qe42IBXNBqInDPW6wskVIbcVX4xcCzkFzUw=;
 b=j9jO0Wm2uUzY8j3Pe43F0uEDW3Ne59tyFFYotyMq4F7EZ61ZpzWfJ8Xxj+bUjhCIWP
 +3L7GK1wFmZLG11u4F7IWrC+dCUlqahvUrF4hAED9rMYvwiqqVL7PIy0O/GY0rQl4IK/
 x2IDSUuxzimhe/zMVsmYoMrom2nZ/Em0hBm/+RknpUuNqqgVczmrR9jN5hxnogXwykDB
 lxJOWjD6q26jeP+OWBrxRh6KVk5rR4K7vXujBNn6uCY0TbEkFEVcnirasgUyf8UuxGVR
 ipIEBikEOMPh1BOjQyi6e0NEUdI1ID0RMvmUyMY3dCP/myg0de7ymrduOyWRYZr9ibrH
 TKtg==
X-Gm-Message-State: AOJu0YwM7jWGUcbsVkhhhMrayjK1Is9rMng+qOHV/9bnFBh22jYs3LQt
 Wh+Bio6cRXDIA/13NK4iYtMdsg==
X-Google-Smtp-Source: AGHT+IFUcOkIQVS43nl5Pb7S4WoyWYo3HaMnolNHCD+eGBE8qOZLrmydGZjTDDwHxYi0CcvuSHZmzQ==
X-Received: by 2002:a5d:6041:0:b0:31a:e5e8:1d8e with SMTP id
 j1-20020a5d6041000000b0031ae5e81d8emr8769937wrt.5.1692776869706; 
 Wed, 23 Aug 2023 00:47:49 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 o2-20020adfcf02000000b00317a04131c5sm17953854wrj.57.2023.08.23.00.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:47:49 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to
 override CFG_EXTRA_ENV_SETTINGS
In-Reply-To: <20230822184135.2328409-2-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-2-nm@ti.com>
Date: Wed, 23 Aug 2023 09:47:48 +0200
Message-ID: <87zg2ifbdn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

> CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
> for majority of the settings to be set in a common manner. However, the
> minor variations between various board can be addressed by the board.env
> files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.
>
> However, this creates a minor problem. For example:
> distro_bootcmd.h and used by ti_armv7_common.h uses it as:
>  #define BOOT_TARGET_DEVICES(func) \
> 	func(MMC, mmc, 0) \
> 	func(MMC, mmc, 1)
>
> Which in turn generates:
> boot_targets=3Dmmc0 mmc1
>
> And this probably works fine for most boards, However when the
> boot_targets need to be reversed, the preferred behavior would have been
> to define it in board.env file as:
> boot_targets=3Dmmc1 mmc0
>
> By changing the order of the inclusion, we allow for the
> CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> New patch
>
>  include/env_default.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/env_default.h b/include/env_default.h
> index b16c22d5a28c..714dfa9e845e 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -112,12 +112,12 @@ const char default_environment[] =3D {
>  #ifdef CONFIG_MTDPARTS_DEFAULT
>  	"mtdparts=3D"	CONFIG_MTDPARTS_DEFAULT		"\0"
>  #endif
> +#ifdef	CFG_EXTRA_ENV_SETTINGS
> +	CFG_EXTRA_ENV_SETTINGS
> +#endif
>  #ifdef CONFIG_EXTRA_ENV_TEXT
>  	/* This is created in the Makefile */
>  	CONFIG_EXTRA_ENV_TEXT
> -#endif
> -#ifdef	CFG_EXTRA_ENV_SETTINGS
> -	CFG_EXTRA_ENV_SETTINGS
>  #endif
>  	"\0"
>  #else /* CONFIG_USE_DEFAULT_ENV_FILE */
> --=20
> 2.40.0
