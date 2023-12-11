Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0DC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 14:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595EB876DF;
	Mon, 11 Dec 2023 15:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ics-com.20230601.gappssmtp.com header.i=@ics-com.20230601.gappssmtp.com header.b="BBugW6Zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212A687734; Mon, 11 Dec 2023 15:46:00 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC46E876DD
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lpmeyer@ics.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b88f2a37deso3533004b6e.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ics-com.20230601.gappssmtp.com; s=20230601; t=1702305955; x=1702910755;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQ1Wwy9kvT5uMtW/tEBIykMxgph1Q7s9E7ZgUsvkmDk=;
 b=BBugW6ZyhH/vC87X5qhQN7A9MZCa2DNff+lxRDjrvma1o32A3s7U9cCkHYKMxq8Sf6
 GAvPJulswv4kU/e15rK8dyHKCdPRQobRcAM1thE5TOlXiOkeLSbF+MYxYluK3egOB0H6
 NVzF4CkhdNlIAMX3zOO35NQwbJPu0CmISpwSp+Egl9LVuuReAh3AgTHad2upwHRrTuv8
 YRIG0xVrRP5HkNwI6lOphhGT5wTV4L7rBR3IZtCXYf23uQ8cKS18HoIIDfe5D6VLuFqQ
 kjlSgaHPCl5cUarQV0sDeuRzZmPLeyUl0oX9qvKU+iHTt/cuKnnJiKs/6gCIHlshL1o9
 gzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702305955; x=1702910755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQ1Wwy9kvT5uMtW/tEBIykMxgph1Q7s9E7ZgUsvkmDk=;
 b=ILMX3anhDW79WUqeRp0aO8FieMeE04fq5/4ECEFeiRXCFVo8anPJNDGTcA+Gme4vBL
 57RxiSV0adzc+yQ019J4Fg8giC/DFKqjoOHOy4CzQpv/9WHM3+0P56ZlEbDiwCcUh7ut
 SvjsDU4GQYNA1oaOqzebe6kApJ0JvSJamTqi0M8wcH01AkP61Xe6sv+q48IbglWM4Slr
 ldHpEVL0oX7MdIvG89WXbSewiq9OMkz8Hk1eh+VLGEquyNlKieUcAshpNPekqo39FTTL
 VoPp46gtiKHJTH/snv+lampInt1pWHMhapUfNuSWblcFhUslRK6ROqlr9n3AYbsuqkEL
 U8+g==
X-Gm-Message-State: AOJu0YwlW/O0A5WCwoLLF80/mRCFZ4s1mKOLyuNq8C8zG1Z1opOmmisl
 WyHAJ4dAuJGuNQ6lZMJ7PeZ5NTc8LqeVbmyeYHtkZQ==
X-Google-Smtp-Source: AGHT+IFnsdPdhWQ6ajnQRfXZTCWmkGtuSQTVWX4zwwrVlY0vxTcONb5p5hbkKj8z3eDo2WKb+j2E1hCcQ73Xzja4X7Q=
X-Received: by 2002:a05:6871:7512:b0:1fb:75a:6d4b with SMTP id
 ny18-20020a056871751200b001fb075a6d4bmr5362845oac.114.1702305955321; Mon, 11
 Dec 2023 06:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20231211134617.457471-1-festevam@gmail.com>
In-Reply-To: <20231211134617.457471-1-festevam@gmail.com>
From: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Date: Mon, 11 Dec 2023 11:45:39 -0300
Message-ID: <CABqjNW-C3862iH0sLQxGnVBL3f4nhcasS4swMo-DSex2GGx8BA@mail.gmail.com>
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

I actually tested this, so, should I reply with Reviewed-By?


--=20
Lisandro P=C3=A9rez Meyer
Embedded Platform Engineer
