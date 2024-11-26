Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9D0D3B996
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1386A89C88;
	Tue, 26 Nov 2024 15:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVLy4Qar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21ED89C89; Tue, 26 Nov 2024 15:31:31 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F7D89C87
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffc1f72a5bso24059561fa.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732631489; x=1733236289; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEaRMuDQIm1Gae4m3MF+qhKJen3j5dobphWCSkFwwsA=;
 b=FVLy4Qar7imrYM7gdCwshwczn0Ag3ioSH3VGHAfs0vmDAM3pVpd12I6ya7wp6FEUQf
 flQn8oB5LoIbGKAyH87aaqtzMK+/XeT3EXNus2CiSy4Oh7vg4RlJDfUNXTlh5zZ87aCx
 AXNz7l7S5IhJIdPh7XcENgp1np68DpGYjgwIewvjFWCOg3agovBp9MfaifQ7K0t5Wrxm
 ecXHCg0WqpEQhaC7r8ZrN8EcmcQmWdSwB2lv1sykek1qjef7mINJnxTyzn/klTQSTk7e
 hGjDDfPJVl7iAksAxXz93rvfJqf0dRy9Xl4ehC8XUexvUKEgmZu6HEqRr4i+aVitXfi+
 F63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732631489; x=1733236289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEaRMuDQIm1Gae4m3MF+qhKJen3j5dobphWCSkFwwsA=;
 b=bqiJY4JvbA0mdM8ysCEmO+PgfvepxHsiBl9xcBJ2BBn1aW/PHArjzUKR/3De1hbY6F
 AGhScaOOzfnx66dsstzx7CNAfzn36Noj8nOqMhoLoANHAlLeZD52cSsFc4YqWn0FwSGE
 B6+PCOltQJWF4Bs2RKBCA3on/XZQtMM5pUYCWtH+Xv+Iwnxc+XfZnAlUxmrViOVpo++3
 +ECKn1mSTb33eZG8dAkw5SWQiCGiYNkdm4etKGKKSLyKf7EV1Wmn1hNdGHY+QVfc3Yxf
 n/tsw1T2zzGxBAl8r3FmcpR/qsvUszsq1fX2Oq4rXw2HmlljnPjGaoZxOYNueVT9eu6B
 0TUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKOvzc1tH3SvDSRknREWjdPer0PtDyP4xzLnAZwZIjxdXTBe7f/gz32Cxl3neD4Qkc1eb/8E0=@lists.denx.de
X-Gm-Message-State: AOJu0YwQOEODP8tzV7KZ/uCgcQaDcZ45SsmbyN567tQ5/R3geKuUAf+k
 RtQjH9Q+im8vKnGXmxOQ4oonrG8ykt2aZKRahn3MWqbCDrBjn7w/Zady49ieP4Ph3OTG9ctVbpr
 CCxOEwSpJSCVIac0J06UKMdHOu3s=
X-Gm-Gg: ASbGncvRAbMUuMqDvHNGRkmCk4QbvAiBawMJGatVSXahCeDCNCvWC7r8t5eGZqjWdt3
 DO5DoN+mhX4SIOW7cAbH5q+e/hOL9UDEsyEfKCdRGwdDvjYS06niE0eyHzVE7Zbz2Hg==
X-Google-Smtp-Source: AGHT+IGJ5vIbpOPN8c2DDsY6e5/Q606USJ7VwdsJmqWdcdnyN+SAc9F9v4GU4KjzK1fpTHVU6X0hHdPk45llcTzrM0E=
X-Received: by 2002:a2e:bd13:0:b0:2ff:7d2e:f49f with SMTP id
 38308e7fff4ca-2ffcc2f26a5mr12534991fa.17.1732631489014; Tue, 26 Nov 2024
 06:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
 <20241125003205.75327-8-hal.feng@starfivetech.com>
In-Reply-To: <20241125003205.75327-8-hal.feng@starfivetech.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 06:31:17 -0800
Message-ID: <CANV2PTP99kmJxbam1R1DzjAanHUP5wNnCHuTdVVmVxfFfvkj5Q@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

On Sun, Nov 24, 2024 at 4:33=E2=80=AFPM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> So JH7110 based boards can select their own DT at runtime.
>
> Tested-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  configs/starfive_visionfive2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index cb86582fd6..5b7a94ddee 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -79,6 +79,8 @@ CONFIG_CMD_WDT=3Dy
>  CONFIG_CMD_TFTPPUT=3Dy
>  CONFIG_CMD_BOOTSTAGE=3Dy
>  CONFIG_OF_BOARD=3Dy

> +CONFIG_OF_LIST=3D"starfive/jh7110-starfive-visionfive-2-v1.3b starfive/j=
h7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh711=
0-pine64-star64"

Please sort as:

starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64
starfive/jh7110-starfive-visionfive-2-v1.2a
starfive/jh7110-starfive-visionfive-2-v1.3b

> +CONFIG_MULTI_DTB_FIT=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>  CONFIG_ENV_SECT_SIZE_AUTO=3Dy
> --
> 2.43.2
>

With that,

Reviewed-by: E Shattow <lucent@gmail.com>
