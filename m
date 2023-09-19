Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B11CD3445
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539D686A8A;
	Tue, 19 Sep 2023 09:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYBK5jBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CA986A9E; Tue, 19 Sep 2023 09:19:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A30C86A21
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99de884ad25so707648866b.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107986; x=1695712786; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omBncyWLVeP606zrycOUhrfuIxSOk+7+1IrwryzNLHs=;
 b=mYBK5jBsdYFUHtmu0fcQOk7EY0Bbu6COrlAAlwVYoRg+r4XkYdZlX0rgAS+RB7yJ4E
 ydzFsnRDWuJrTPp6SPaskaV7OHzhpTGooPF4bLBXmTj+Zh4DiTK8loYaKpPhMzqhGhiw
 CTrug4S5230Hh9S0R3ldzxHUzbYEINQc3K4jvd2NIcKCKQ1JrPEU4Wc7JDCBkElx7EPL
 KtH0C68LA662ugw3QK9PZ4Q0e1Zrk4IUzaWAfc0uAhuLExSamd2GU3xWFb+sgzAfDtcf
 UAxwEY/BSbaKh/D5EaeouZ7xOWOOP42regNzXJDlXdgfn0ME2cIwed1OIOhX4YVwUfw+
 rgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107986; x=1695712786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omBncyWLVeP606zrycOUhrfuIxSOk+7+1IrwryzNLHs=;
 b=gUNPQzSybvK9LgmABy3J7TBVBT1LG9C0WwavX43mP1z0e+81n+IHt6d4gG7Zmbvho7
 V0IL+EFDQyhK1OC09rky4lfN/p8RBETKeg7eJ7sj6GrR3kVo6ta0NXLM3od9E4bEYoWR
 fPKHZxMtivzSDgb6A4lNmlmCTRiLvrmihuI6WEVrzyGYdMNSNnd78ituEcKL/JUTRzR6
 qCQBvwctCjsZGiIQzjUkvmLwSPJaxnybTvu39dABqgoc4TPy+iELURDitsqXsq5O5b5X
 9WxnlQDic82FbvNkUCn2ToM31YLw8bSGLCB006BwminMqaZI2X9NSy9FjWNiDAbv8zwA
 wGyQ==
X-Gm-Message-State: AOJu0Yz9utTVuH3VDbnT8E6MykX/IRuxMQ4r2UHyonm4vs4w6G1zEhom
 ZJ8/aMnD7jv0kyihtEGn7Pr65bgbD7PIYYHqmtw=
X-Google-Smtp-Source: AGHT+IEIzbEpxLDETp/hH+a15lr9MfdpVAnsMasqHO0mQOulIyCpLWl6yeeaILGIE2u4mwmIjMM0koh2EhX5VcnPssY=
X-Received: by 2002:a17:906:73cb:b0:9a5:c4ae:9fec with SMTP id
 n11-20020a17090673cb00b009a5c4ae9fecmr10669590ejl.52.1695107985360; Tue, 19
 Sep 2023 00:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-7-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-7-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:32 +0800
Message-ID: <CAEUhbmVbt8ErjpkmwMW5an=k_hmtvM6grDD8BNBKDofHy7r4Ng@mail.gmail.com>
Subject: Re: [PATCH v4 06/20] x86: coreboot: Look for DBG2 UART in SPL too
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> If coreboot does not set up sysinfo for the UART, SPL currently hangs.
> Use the DBG2 teechnique there as well. This allows coreboot64 to boot fro=
m

typo: technique

> coreboot even if the console info is missing from sysinfo
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  configs/coreboot64_defconfig | 1 +
>  drivers/serial/Kconfig       | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
> index 5623197f6be..e8165961c19 100644
> --- a/configs/coreboot64_defconfig
> +++ b/configs/coreboot64_defconfig
> @@ -54,4 +54,5 @@ CONFIG_SYS_64BIT_LBA=3Dy
>  CONFIG_SOUND=3Dy
>  CONFIG_SOUND_I8254=3Dy
>  CONFIG_CONSOLE_SCROLL_LINES=3D5
> +CONFIG_SPL_ACPI=3Dy
>  # CONFIG_GZIP is not set
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 7ca42df6a7e..27b4b9d9650 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -672,7 +672,7 @@ config COREBOOT_SERIAL
>  config COREBOOT_SERIAL_FROM_DBG2
>         bool "Obtain UART from ACPI tables"
>         depends on COREBOOT_SERIAL
> -       default y if !SPL
> +       default y
>         help
>           Select this to try to find a DBG2 record in the ACPI tables, in=
 the
>           event that coreboot does not provide information about the UART=
 in the
> --

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
