Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D36C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EDF8778F;
	Mon, 11 Dec 2023 18:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="hZIpAt+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FB087682; Mon, 11 Dec 2023 18:48:39 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4787E8776E
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58d08497aa1so2970282eaf.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702316913; x=1702921713;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/dmK+pCzBvYrZPuLzMDh1JXqv0dzju38Gs5bc9t6zE=;
 b=hZIpAt+IV7tgc8ssQW609BP2DyzIJelZVxtLvNQS1b85b6PSApC48pLL8/BnRSYxo8
 czMJDFxJfzLoDAb10Gjyb8AT/3JIoOT7Fr9zu+7Rlf7aGZzCL8XoNqVjnowy+ben3XjG
 hWijTi1tlz06effpNXcQx9YlknwLoze0dQJKEdbTEF7NJ5BZmWD0S3Qga2ObnCWDvqru
 2Z8FV2X5fsqJjC3j0JlsxePWuKXmO9ob3Q1hL1+FIIRFFh0K7LFk94JWoQUdB0wZiLfb
 Sa30rclJS1TGZYlO/F2l/HL3wzM+DL1vvLwNrpSXHWpxASY5eSFxd5x9sBawSXzRXnlo
 Cp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316913; x=1702921713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/dmK+pCzBvYrZPuLzMDh1JXqv0dzju38Gs5bc9t6zE=;
 b=lXp+K2xpuaJF5NOw4GJ+896Yx2p/6ZR8LRTMKGQJJAQpdPuot96qHbQ4xtFyGRPUHS
 L6qKhuiu/E7GovZ1R04J2cYNHvNsmVZqrvhe269jLcoSgXtawtCTfmmJpt9eg9Rv+nrI
 aKBZSnFC4xyYL1iYYXFHehbofABLWKz43+1dKc3e/x7tZ7wjx49TLMbM34fMFcxMsxDE
 jEL8Uipnv9OQvda1QKDuxUlSCetKlrd/S2d+wnc9tJetE1ld+3r0XnJgp367tbE8OdaQ
 MQvJuETmZKSAZ8GRkdJMAws70DB4dfAhZ3+X26eh+ldhUDjs0q5Sy2MdF1qb/ncvR/Lg
 ISEg==
X-Gm-Message-State: AOJu0YxYK++4nLif3fvpH4fPyRGSA4AmKnP/Pip8ihaUWxoCauEpVCsY
 dVVdO+o25KPnvIkJqj7FSVr74/0hwnpmgG7KY4tGMTRT2oh+Zznf
X-Google-Smtp-Source: AGHT+IF5MAZkePqT9ZNUYluwzDjtC2mV7iJdSXRr9Xt/tEOofEYvkBVtydE5UbcsY5rx7bwOW1aOMlC/NprPpAd7FiE=
X-Received: by 2002:a05:6820:16a2:b0:590:7537:9535 with SMTP id
 bc34-20020a05682016a200b0059075379535mr3126966oob.1.1702316912986; Mon, 11
 Dec 2023 09:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20231211134617.457471-1-festevam@gmail.com>
In-Reply-To: <20231211134617.457471-1-festevam@gmail.com>
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Mon, 11 Dec 2023 14:48:17 -0300
Message-ID: <CABqjNW-5D-j0knfNDrWVpn6U7nXtLrSLcguzkHKT1zqXJf_4jA@mail.gmail.com>
Subject: Re: [PATCH] imx: imx-hab: Select SPL_DRIVERS_MISC in the SPL case
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, trini@konsulko.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Dec 11, 2023 at 10:46=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Selecting CONFIG_IMX_HAB=3Dy on a SPL target, such as apalis_imx6_defconf=
ig,
> for example, leads to the following build error:
>
> /usr/bin/arm-linux-gnueabihf-ld.bfd: arch/arm/mach-imx/hab.o: in function=
 `imx_hab_is_enabled':
> arch/arm/mach-imx/hab.c:879: undefined reference to `fuse_read'
>
> fuse_read() comes from SPL_MXC_OCOTP, which depends on SPL_DRIVERS_MISC,
> since commit 251a3053b1e6 ("misc: imx: remove DM dependency for ocotp
> driver in SPL").
>
> Select SPL_DRIVERS_MISC in the SPL case to fix this build issue.
>
> Reported-by: Lisandro P=C3=A9rez Meyer <lpmeyer@ics.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  arch/arm/mach-imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index abd48d42583a..c34bc25c0bfb 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -54,6 +54,7 @@ config IMX_HAB
>         bool "Support i.MX HAB features"
>         depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5 || ARCH_IMX8M || ARCH=
_MX7ULP
>         select FSL_CAAM if HAS_CAAM
> +       select SPL_DRIVERS_MISC if SPL
>         imply CMD_DEKBLOB if HAS_CAAM
>         help
>           This option enables the support for secure boot (HAB).
> --
> 2.34.1
>

Tested-by: Lisandro P=C3=A9rez Meyer <lpmeyer@ics.com>

--=20
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
