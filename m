Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2841C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 03:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60483875C8;
	Tue, 28 Nov 2023 04:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HkR7w30d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4EB87627; Tue, 28 Nov 2023 04:03:21 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 424838757B
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 04:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b83398cfc7so3112834b6e.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701140598; x=1701745398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I31dWUrDcp29LxSWzFvKgoFlu0h5MugzRLc7Yi6GGxI=;
 b=HkR7w30dCA39g8VYesllYRlcT+lBPd6vxatNnOWEIO+7/zNyJzbGN0iX6e1X37o/wv
 tEfDFTIvwE/CPG4CU4T9AIjO+JJIpbWIzQPxVc20s7WsZxqDg9ECfbNgXGvUNUERuorS
 iGIPT0x4+m1cs94tMpm8lTLYED5CDmhX1zTEsw4YDY68z1HdmGR3jj3ZL+BiNxeSFeqF
 8vtb22TK5GKju+XQbBwprjk09eAAmc7TwkggPgrLETZlN9xPCOrPy9j0EkloFXdG5Oy+
 rsFAU1w3HW7ef/Ng41cOgIbvLS6SWilC0GT1Lj/puT9thWTjBwbPtPtFtyqwEo9UpSef
 nK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701140598; x=1701745398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I31dWUrDcp29LxSWzFvKgoFlu0h5MugzRLc7Yi6GGxI=;
 b=wPwkAQO9ln5wkAxv2guI2oZ7PtuWxCuZ00AVjj2i4vpH4+TIUVCF+B+bhTVTfjrDZO
 zz845hEVBvmZEJCd89T00tNCteWoYtLSRbx+y9omZMRzV8kKxE4Fef/VwCJFnC1dnnto
 r0v230u2xCvclcusm3XEEbiYbUZp3VmEc2/HTg98gw536uRks6nj2zBD1Y/DbLzzKGK3
 ujBT6qkWcCwHd9GlNaRrxcMNdDFJ206Fk7+qQR2iEnfFr22dKWlBs0SKacBvmdU8cNwo
 8MKa5Lt+oH/uBgcMwbiJSD1ilFhiHlxQXFvQVX5tBciEvZjDz5B4J0HAR/lLWFiBcP3Z
 /E0w==
X-Gm-Message-State: AOJu0YwpAfEp7Qfwt8AZmik/rBIqF0krIgkwyUDEz4emxSFdAtGMJiXV
 jKWQdd8yxfaiOXRFpAMMhoFVK3b6QyVJZRnDyPlSjfDo
X-Google-Smtp-Source: AGHT+IGJE0jtyEkXmbGVBJzn4lwFCa4y/KC4uEIubNrVMOw8rymKaffMGsUBDNDkTpXTyox9Rpdmh5p4KMwuztMDLUY=
X-Received: by 2002:a05:6808:9bb:b0:3b2:ee75:31f with SMTP id
 e27-20020a05680809bb00b003b2ee75031fmr15680966oig.49.1701140597924; Mon, 27
 Nov 2023 19:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20231109201313.29791-1-semen.protsenko@linaro.org>
 <20231109201313.29791-2-semen.protsenko@linaro.org>
In-Reply-To: <20231109201313.29791-2-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 28 Nov 2023 12:03:06 +0900
Message-ID: <CALrBrZ0oHNMDnyYgw4szjToB7y1Jy5uSG51ke6Y_rZ9AyRFZhw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] configs: Remove unneeded SYS_CONFIG_NAME from
 a*y17lte defconfigs
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi!


2023=EB=85=84 11=EC=9B=94 10=EC=9D=BC (=EA=B8=88) 05:13, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> As correct default SYS_CONFIG_NAME value is now set in
> board/samsung/axy17lte/Kconfig (in commit "board: samsung: Fix
> SYS_CONFIG_NAME configs in axy17lte Kconfig"), the SYS_CONFIG_NAME
> option can be safely removed from all a*y17lte defconfigs. That removal
> doesn't change resulting .config files.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - None. This patch wasn't present in v1
>
>  configs/a3y17lte_defconfig | 1 -
>  configs/a5y17lte_defconfig | 1 -
>  configs/a7y17lte_defconfig | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/configs/a3y17lte_defconfig b/configs/a3y17lte_defconfig
> index 42fcd2a3d317..043f3a04db88 100644
> --- a/configs/a3y17lte_defconfig
> +++ b/configs/a3y17lte_defconfig
> @@ -1,5 +1,4 @@
>  CONFIG_ARM=3Dy
> -CONFIG_SYS_CONFIG_NAME=3D"exynos78x0-common"
>  CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D26000000
>  CONFIG_ARCH_EXYNOS=3Dy
> diff --git a/configs/a5y17lte_defconfig b/configs/a5y17lte_defconfig
> index 3b80536c12c8..14590f65e9c0 100644
> --- a/configs/a5y17lte_defconfig
> +++ b/configs/a5y17lte_defconfig
> @@ -1,5 +1,4 @@
>  CONFIG_ARM=3Dy
> -CONFIG_SYS_CONFIG_NAME=3D"exynos78x0-common"
>  CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D26000000
>  CONFIG_ARCH_EXYNOS=3Dy
> diff --git a/configs/a7y17lte_defconfig b/configs/a7y17lte_defconfig
> index 9390e35057eb..ccb0bf2e8059 100644
> --- a/configs/a7y17lte_defconfig
> +++ b/configs/a7y17lte_defconfig
> @@ -1,5 +1,4 @@
>  CONFIG_ARM=3Dy
> -CONFIG_SYS_CONFIG_NAME=3D"exynos78x0-common"
>  CONFIG_SKIP_LOWLEVEL_INIT=3Dy
>  CONFIG_COUNTER_FREQUENCY=3D26000000
>  CONFIG_ARCH_EXYNOS=3Dy
> --
> 2.39.2
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
