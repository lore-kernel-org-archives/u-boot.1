Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA86CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829A2808AF;
	Tue,  4 Nov 2025 13:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNvV2rbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD13882A9E; Tue,  4 Nov 2025 13:00:18 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7A28003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3737d09d123so71043131fa.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762257616; x=1762862416; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Cs84RHxlzECX1bQO7/9Pv/g0m3UwiK2Hk0oK8Dxc9A=;
 b=MNvV2rbPPIeQwVUrX0wvr+t9kce1gbWxEYHtmvvJ6oZCIQjKLv/G3meqGMUiXup9Yv
 l/r+sGG5eQaUtyPNtTu1WWliJquIkpjyMxawTW7YLLFXyRcAcc25wXZBtW+vcesZHtIo
 H2tejkBKGjSoAxz8mfBV/Am1REv9yHNIwOiPSiVJJl6jACVj171q1dueokg3HoUY/YXJ
 AP2yWUJVkxaPeC2TN4GJd2TIaB1hKtu8591PBnDMZ5MrG+XFwXzIwdJvHr69NvNpmV3h
 aA45gGKlVydszw4jOxI++RAAHFaxX57Box7xw/bgIz70VCha5v/7BA56TmxfNR0VMUoy
 KEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762257616; x=1762862416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Cs84RHxlzECX1bQO7/9Pv/g0m3UwiK2Hk0oK8Dxc9A=;
 b=alwsSqcm+zX7z0vw1DdM8f0M/Cxmezt4+fGHIEeQPsQzVifbl2Toj66R9ArbCZ0r74
 Pw1ZqwxPlEnoNCI4rf3alLCyxx6jbTykpCiCl+bqZhozo3G5uN2IL9mprM1Cxd2EUpNq
 NRNALWPiAuZ4+MecvvKRVpKndw2eq6MPUT8aFrkRkUa3h2xzt+fN7L0kvjXoCPJNWqXL
 C2+4myvge/Wwvp5ON0DAAfd4kQNtTuL3pGHUEbZ/k/PQ+7zUUcbqo2onMWbLg/N0ypFf
 lBYnmXTlL+UoXcYRbZNYCFNlGPhKIaak/F37g08DEJD1TL9nj/dxXOegT0QwQF8iyY83
 iOMg==
X-Gm-Message-State: AOJu0YyeF5SXdWEpxA1NYu5p71CytXyUuAio5GVFFKVXTAK6PkfV5eJv
 s4BfXsdH0KNyXhVorz18OZRTYL8Lf/UG0qvTiQc1tY4r8hRCobaRYxvZXVJlcedQA0wk20Sfgp3
 FRdjA+4/Alx2MFrIS2vZSypAqM+iiZ6M=
X-Gm-Gg: ASbGnctyyBlP6+27WbE/uI4u2shML8DJaxX4EY56d/w9n3QBmF7hKzvuOk+qjgaZ3hQ
 44ylV4m15biHEKyFMx+6k71P1Xy4KoXNn0llBbKH/jiUSEs1dt6VHLdJWmcoIBUNK+4LJvFNXXz
 juENPjl4fb/WDZ+IV3whON2SwnHHHz54aUUttLnuVAVwwa+l7G1fI42VtZcEdSLceqSwN1w4NZ2
 IRA2HOngA/hx2WHmhv70xrGvL32virpUfU3IdLD+lADlxWkRdYjEcCLf6N0bzwJBLOpBRYmFOQl
 KOXnLmPyhYhCDRw9
X-Google-Smtp-Source: AGHT+IGkCgLnCYEZnnGf6/inhqFjzBRYCbfGYYPZkhRb5bWHMfLh75lXS3fBIuqdaxYhBj/jOENWHYNxYF3lYtn3MBY=
X-Received: by 2002:a2e:bea6:0:b0:37a:2fee:31f7 with SMTP id
 38308e7fff4ca-37a2fee32c7mr28593521fa.27.1762257614050; Tue, 04 Nov 2025
 04:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
 <20251031074611.39426-3-andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251031074611.39426-3-andrea.calabrese@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 09:00:02 -0300
X-Gm-Features: AWmQ_blVNaXRCeW_GOeb1XDwuWntfSvYg9WI2hNzUe_2uYgBVHwlGxIMY5xmcEQ
Message-ID: <CAOMZO5D=sxnGZwm6X8d9hfe0suHRbxXLVGf9D_96K-+LzC9j0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Andrea,

On Fri, Oct 31, 2025 at 4:46=E2=80=AFAM Andrea Calabrese
<andrea.calabrese@amarulasolutions.com> wrote:

> --- /dev/null
> +++ b/configs/imx6ulz_smm_m2d_defconfig
> @@ -0,0 +1,82 @@
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_MX6=3Dy
> +CONFIG_TEXT_BASE=3D0x87800000
> +CONFIG_SYS_MALLOC_LEN=3D0x1000000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x18000
> +CONFIG_SPL_GPIO=3Dy
> +CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> +CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_ENV_SIZE=3D0x20000
> +CONFIG_ENV_OFFSET=3D0x400000
> +CONFIG_MX6ULL=3Dy
> +CONFIG_TARGET_MX6ULZ_SMM_M2=3Dy

imx6ulz_smm_m2b_defconfig, imx6ulz_smm_m2_defconfig and
imx6ulz_smm_m2d_defconfig are the same, except for the CONFIG_TARGET_
line.

I suggest introducing a <configs/imx6ulz_smm_m2.config> with the
standard part and then including this header file and the
CONFIG_TARGET_ line in each defconfig.

Take a look at some examples:

configs/imx6_dhcom_drc02_defconfig:#include <configs/dh_imx6.config>
configs/imx6_dhcom_pdk2_defconfig:#include <configs/dh_imx6.config>
configs/imx6_dhcom_picoitx_defconfig:#include <configs/dh_imx6.config>

The idea here is to simplify maintenance and prevent duplicate
defconfig settings.
