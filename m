Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A010A1E72
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7584083A1B;
	Thu, 26 Mar 2026 12:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="q32R/s1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E88983CD3; Thu, 26 Mar 2026 12:04:40 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AAC81E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6674cba2c50so2977875a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774523077; cv=none;
 d=google.com; s=arc-20240605;
 b=Fb4uwFB6a7UYisZUqp2/4nZt+ZQvbVFoJCoohy4Z8LmVFh/0N2+03ijtqfv3T1b9k5
 FIfG/bcwq3Msk0YI0J3VbTX6ixprRoJ7Jh0HPUUF2TuFJnoefl08c96QxOJVv5E5ndq+
 i4ZszpFHE1opWeEBfWmSSz2JF34dDTMMNQkjQq4ilec6uEivkINRHrtpT/iPafUXWc0p
 yqn1QTjne5P5hxvYnB6kudcy2eVtfXya+JRmh3qejQkwJLGM5F2fthQyjv6I5wJ6FNTE
 DX8vtfurXqxECMumGSijnbMzXiXqJ09owiAKwPe4T9bn+WVlxVG9ql32m/O4VwMc5LAT
 KfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ElcPPX/orCyBpBNalv+zzTQuclAepCTeILX63NlpZEQ=;
 fh=b/59rRfUTTMuKCQOd2M8mPkKtPAZ1mLPI+Y3K2VJOyo=;
 b=XyqKFYO1LcFI8m2dFlWfGVGdv40DX84vvR6gYyu0KAvcy/geoTxW07TabZ0oHGUB+s
 mQOiUWYMK8czTplOp8KMd8MjW1nf+LENE3u9tX1QriULCbxwUhitqE9e7AZUTbrFF+iV
 CrhXkkLzb5VSck6Br7R/GO5bJg/5yOJfbwngwOQN63yLlRqf1o6E9bJzVaeC3EK1hQq+
 CNj2EL89vyKzNUJIw0PEtNo9df65bVtHWW4MF7LWOmdEROchrGw+QXtGD1pS7tYrES8u
 fgZlvtZAlPXRO46qjOHTancx40x836z8qqNs4wzQG/uCE42wA4pQl9dek+RIHrP2XKcc
 3H+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1774523077; x=1775127877; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElcPPX/orCyBpBNalv+zzTQuclAepCTeILX63NlpZEQ=;
 b=q32R/s1blIiG+r30hI/mvKLtFTIAPKZJb2AFa7djxhtkFZ4ZOVcSaY2anGK57oayNg
 99/Jl+3vdDLeQaRXAn79p7vYeOcar9+Zo/JqCYKvy7hvC+55UnuZB/k2MgdeYVQXHAmj
 rFxeso/dB4I+jlArkgrVFk03A2FLhZBpAI53tPHDUjx7faESnggPSTbd2WJ7uFMDWVsy
 6zzxFGJwUHefVClETpwnz9f+XkX3eUhdRTY7STn5PoZgf9O51bAA9FRciTLXS2jMnJNB
 KletqNORlyVTAqVYd7X+R+1j5QZKzQYZmAGby9PKPKTB//gFLcAJEk9aMhIyOF/AbAee
 EDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774523077; x=1775127877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElcPPX/orCyBpBNalv+zzTQuclAepCTeILX63NlpZEQ=;
 b=ER4ZAF8uM6TuCL27kwJdtl4otUVFUuJFU8/VWedSqsGwaqd6pK/vwMycMoquJNToJW
 f+2O4DDZL1cRCaI6paGjY1NNcal+F1i1qGugvkzv3wJ/c+Elab6v2CvzwHafZqOJM6QY
 uRoh8LtLLFIydW/lUMnhMNj7fgloC+a5ySB3vyfjiwf7NlJnQBhkdVnFRFe/+4Y2oUCS
 8BMX+tPWXJL79KdtNeZQpi/DU80noQj7GOH9xJQOE8Bk/icZU9xpp6TtAVwjGqlnHPz1
 kT3Rm2BaMd7SRAs7uO+KUhhApqJmTsVNX09Gb5YMrHpzlzl2hSBfkQJ4y5rd1ncZUYl0
 2uhA==
X-Gm-Message-State: AOJu0Yxb11OzrvHCwu10ecfsolIiQDnyiFplv9llhjJpXJ13NOP8LsAk
 Rq+eDBlT+EUeSR/KATpof+ljRL8lsFlMnGpaZ1bDknEdAqixRyW8nVWAfUbncj8O/XMb6WfQUIc
 Bfq/b58GcAq4pDDcafd5x/6aE+7kzx/ERIS1MP8s0YA==
X-Gm-Gg: ATEYQzzPfyO/hHMxAhvHIskt0OM4f5AAoPvilY3GG7fplT+eNLcIzlXVRrtQtgUQQ6/
 ARAas9pU2tstGWqM2TUdFwkRbjotlrJ/CfLxnJk4WItgf686xEbQ4pGfKgRt9Oa0TawDWLmwHyJ
 LDYqrV7c4GTUPH6knFRT+EUabLLoW6raVQjIeD2SLqH1QdcPuPodhPW5ciGm3+pISf8cuT2pvJy
 8ZE/OyLI4sdmBS0Apg0hldJfcNTFZdIccHorcdsb27uhm4w5GRFLrwl5gQCp/hwBsG0+3zhC7La
 RQ4cYjgyeRGjHCG/kdnnNEuQer3K9JBEAnPmHHTQOvgW7dDK589AY3eSqjNxUg==
X-Received: by 2002:a17:906:c155:b0:b97:9a7a:9d21 with SMTP id
 a640c23a62f3a-b9b2e5481abmr76673266b.4.1774523077336; Thu, 26 Mar 2026
 04:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260325190022.3428531-1-trini@konsulko.com>
In-Reply-To: <20260325190022.3428531-1-trini@konsulko.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 26 Mar 2026 12:04:25 +0100
X-Gm-Features: AQROBzB6F-BsCgv0S5C3d7MTBPK6er0Z87VHwPiXW4tLRe7nOJIuAn41Xonq0qU
Message-ID: <CA+HBbNHqG_w1kxtp_B9otXSGf2nSac6FaeVBtE+6qT9sb_PpMQ@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>, 
 Konstantin Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>
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

On Wed, Mar 25, 2026 at 8:00=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Robert Marko <robert.marko@sartura.hr>

> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Konstantin Porotchkin <kostap@marvell.com>
> Cc: Ben Schneider <ben@bens.haus>
> ---
>  board/Marvell/mvebu_armada-37xx/board.c           | 5 -----
>  configs/eDPU_defconfig                            | 1 -
>  configs/mvebu_db-88f3720_defconfig                | 1 -
>  configs/mvebu_espressobin-88f3720_defconfig       | 1 -
>  configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
>  configs/uDPU_defconfig                            | 1 -
>  6 files changed, 10 deletions(-)
>
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mveb=
u_armada-37xx/board.c
> index e44b713f96d7..c30fca6cffd8 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -102,11 +102,6 @@ static bool is_edpu_plus(void)
>                 return false;
>  }
>
> -int board_early_init_f(void)
> -{
> -       return 0;
> -}
> -
>  int board_init(void)
>  {
>         /* adress of boot parameters */
> diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
> index 0b7815c78a30..98ba91aa568f 100644
> --- a/configs/eDPU_defconfig
> +++ b/configs/eDPU_defconfig
> @@ -23,7 +23,6 @@ CONFIG_SYS_PBSIZE=3D1048
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SYS_PROMPT=3D"eDPU>> "
>  CONFIG_SYS_MAXARGS=3D32
>  # CONFIG_CMD_ELF is not set
> diff --git a/configs/mvebu_db-88f3720_defconfig b/configs/mvebu_db-88f372=
0_defconfig
> index 52ad18e4dd91..b7a2559997fe 100644
> --- a/configs/mvebu_db-88f3720_defconfig
> +++ b/configs/mvebu_db-88f3720_defconfig
> @@ -23,7 +23,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_FUSE=3Dy
>  CONFIG_CMD_GPIO=3Dy
> diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_=
espressobin-88f3720_defconfig
> index af3bf1a04fce..c101b342980c 100644
> --- a/configs/mvebu_espressobin-88f3720_defconfig
> +++ b/configs/mvebu_espressobin-88f3720_defconfig
> @@ -25,7 +25,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_FUSE=3Dy
> diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/=
mvebu_espressobin_ultra-88f3720_defconfig
> index 69d6f7e34c3b..157bd9696425 100644
> --- a/configs/mvebu_espressobin_ultra-88f3720_defconfig
> +++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
> @@ -24,7 +24,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_BOARD_LATE_INIT=3Dy
>  CONFIG_SYS_MAXARGS=3D32
>  CONFIG_CMD_FUSE=3Dy
> diff --git a/configs/uDPU_defconfig b/configs/uDPU_defconfig
> index 851d7bb2cb99..b819e978c3a5 100644
> --- a/configs/uDPU_defconfig
> +++ b/configs/uDPU_defconfig
> @@ -22,7 +22,6 @@ CONFIG_SYS_PBSIZE=3D1048
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
> -CONFIG_BOARD_EARLY_INIT_F=3Dy
>  CONFIG_SYS_PROMPT=3D"uDPU>> "
>  CONFIG_SYS_MAXARGS=3D32
>  # CONFIG_CMD_ELF is not set
> --
> 2.43.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
