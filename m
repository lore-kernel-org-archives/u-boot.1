Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCEC5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 17:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29C4980B3F;
	Sat, 15 Aug 2026 17:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqo-3UOk5qLi; Sat, 15 Aug 2026 17:59:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 583A780ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786816749;
	bh=gMPxwo3qy7w+DUEYhm9+Vu2MElgqAqs+a8PNzfAZx/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Nn54HqjsuQOKEMJCfKOqNNIh4a62tJcsJgddlVBJfUfCDhWuNIO0l47hcA8tWaO1
	 MyhgjJ8JNPPaDdkZs30gvqejTq6M19jOMSGzO/JyplFwtBOle0HqdycPylxps+98Hs
	 /pxSmWpLzQu4zRg3vBOp4EylO3t7mmvRnwxdfWwiFZif4r45+rAiyLSdtUiUYQVfig
	 kpET8CMUmn7OtvS+NyIU/vmHC7i0Yw+Uiy9HKGdHBT/1jJEM/YtiDjG1rx4lomzPns
	 Fz1/nvrBY7NBNe6Hv+Gwbox7lRTEK9pNlEWOXPJRDWsMJDwoSnNsaoK6EADtXZbh9E
	 /9Ou6uyaAlExw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 583A780ABD;
	Sat, 15 Aug 2026 17:59:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C8A72B2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F6B280CDA
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9ssSWpe8Kut for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 17:59:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2ADAD80DDF
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2ADAD80DDF
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rRcEZScL
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2ADAD80DDF
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 17:59:06 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso664897fac.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786816746; x=1787421546;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gMPxwo3qy7w+DUEYhm9+Vu2MElgqAqs+a8PNzfAZx/o=;
 b=rRcEZScL7RNAWhqMc2KmYiVQ9+7wCYKSzbFJd7eIwx/iTCe3pIfWrOjMjvlO2ByjRB
 z3dmIjtfV7wOhf1Bk26ab4+QukajqstQdEn47uKxzCIgX9IuPtiZl0QdyNp3zauacoKm
 En8qE7lzfHtNM0mhsWbrqT3u3qL8V6jUfrHA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786816746; x=1787421546;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMPxwo3qy7w+DUEYhm9+Vu2MElgqAqs+a8PNzfAZx/o=;
 b=I1ZmWX0+DIO/FLudjLYJcaDaEpOeRRBmir0kR8OUNqmvjH9JKj+/B9qM4I7PnIF6YO
 frwkQIazyz0iK/NZJ2f7HgOEm/j4uo5hmaLWxsHny8XkAEPfl923+PsLJ4Zqa60TaLuU
 Ao27A6IE4AcnfVBPMn/wGXb1ykTFqZya0T2y6pGMH1v6J7iiRWy0+Fgwk4FtYM133mBW
 KFZEmT2ceedkxLbfLUQhmmSXw8S8JB9YmBk1SUyN5nPff5rjOKyL2dHhe9wBdEUBQ7Hk
 C5s2IIzUQZADSIAnaocvx+slELA4GNI+kRtr7dZVFD5titwTJylLHw2BMR5ZwJgAdqRp
 5nyg==
X-Gm-Message-State: AOJu0YxImClf9E62P2PIq1O6m6/LnH3oDAFv3bbZknj6cy+fBj5gkVRU
 l8THH4k3MLEbUTcCovL59JIwM1fDeXzAcser0uxK8g9E1+dLcCTTYfWNf+17Y415FNQ=
X-Gm-Gg: AR+sD11wHnR5hgcDc5yWo+1KWeZVK6SGGD9tDog/OYV+Rq9y1+zKNdabROy/2UpoHQ8
 COVTJC/OYxmiuyn1uXuOKjfPiZis2Q5IU7AWVuP9MUHz18fUNUa2CaHtrktqNJgutMZlOlcfE76
 aCcRDfwbidegScqvan2QlhX/auzSNSAr82DXlXxpY9DoqwsdniRcov9PURAIC2wsJDQgoPEm4pe
 6vHIc4lz8Wal61M60DYLmkzQXiTxj92wjaKi0yh2OBLKYT3PqJeMu9QTG3KPqE2tdfjukZ03YlG
 ooBVaO898p8MQ1WeFFQhdsMIE1V9RJLPC3JbZ8UJjsemVg0RGxBMxR4HHmrtc7QIAREV1HZekuB
 X5Ege4kmRl6qohs65fs86AVMZ1rCEF0qQv8nBZ1OHG9sCIWChqZooGr4Kb/Q3Pv6Q2vHx6yyUCL
 yHwB2YEUifAWklkeAvkl9GLfwkpcx+0SlqocLOxK0eivWtACuad/UCikm+Dw7rAcZYw/y/qKZZL
 Nf5Tn3w/HhHJsRwIsuqMiMF2mYmtp2NuVj7/C+jGyUxmCDM975vWJcbN8b6yV5/XNOk82znnVnP
 mv7L/0NAGNdpceYSBFjE
X-Received: by 2002:a05:6871:200c:b0:447:24bf:ec47 with SMTP id
 586e51a60fabf-45e92353f37mr12604595fac.10.1786816745883; 
 Sat, 15 Aug 2026 10:59:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e8ff322c0sm5290295fac.17.2026.08.15.10.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 10:59:05 -0700 (PDT)
Date: Sat, 15 Aug 2026 11:59:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Valentin Liu <valentinliu@icloud.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm: rockchip: spl: Add hotkey detection support.
Message-ID: <20260815175902.GN3297518@bill-the-cat>
References: <20260815170844.1196849-1-valentinliu@icloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DhwluNrxNNJ5gJu8"
Content-Disposition: inline
In-Reply-To: <20260815170844.1196849-1-valentinliu@icloud.com>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--DhwluNrxNNJ5gJu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 01:08:44AM +0800, Valentin Liu wrote:
> Add a configurable Rockchip SPL hotkey feature that checks the
> serial console during SPL startup.
>=20
> Ctrl+B can be used to enter BootROM download (MASKROM) mode and
> be widely used. We can add more boot mode support in future.
>=20
> Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
> the serial port to be ready to receive input before checking for
> hotkeys.
>=20
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
> ---
>  arch/arm/mach-rockchip/Kconfig | 15 ++++++++++++
>  arch/arm/mach-rockchip/spl.c    | 42 ++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index 1a2e7847c9e..a5de483bbb9 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -743,6 +743,21 @@ config TPL_ROCKCHIP_EARLYRETURN_TO_BROM
>  config SPL_MMC
>  	default y if !SPL_ROCKCHIP_BACK_TO_BROM
> =20
> +config SPL_ROCKCHIP_HOTKEY
> +	bool "SPL hotkey support"
> +	depends on SPL
> +	depends on SPL_DM_RESET
> +	depends on SPL_SERIAL

This can just be:
	depends on SPL_DM_RESET && SPL_SERIAL

[snip]
> diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> index e989c148079..46140e5af3c 100644
> --- a/arch/arm/mach-rockchip/spl.c
> +++ b/arch/arm/mach-rockchip/spl.c
> @@ -19,6 +19,11 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#if IS_ENABLED(CONFIG_SPL_ROCKCHIP_HOTKEY)
> +#include <serial.h>
> +#include <asm/arch-rockchip/boot_mode.h>
> +#include <linux/delay.h>
> +#endif

Guarding includes like this isn't a good practice and should be avoided
unless strictly needed.

--=20
Tom

--DhwluNrxNNJ5gJu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoCo2gAKCRAr4qD1Cr/k
Cg2FAPoCGjUu9ld+kfVJHfu/jMBxYQWMlxdGaNYsmH92uq6PjQEAnnhyJrHOybCl
YH0AbD1n3Hu+1zXylfCz+KvGysjuEQ4=
=phr7
-----END PGP SIGNATURE-----

--DhwluNrxNNJ5gJu8--
