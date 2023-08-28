Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE4BC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C9E846B8;
	Mon, 28 Aug 2023 17:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="Uy46CLn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B6086505; Mon, 28 Aug 2023 17:28:54 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F9A864D8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso2866928f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236531; x=1693841331; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtjxu0Iu7odUraYc55qdTmS0v2UgCqrPCGRg8hyQUuI=;
 b=Uy46CLn6G5NLHgpZdyMeXBVIDakJDxRoa//AvjEWdixyenPDUDE0heZrLhb4Y360dS
 vwBvyLVwnzmNvsgXg8mlT84IKp5PrLqKCdO8qEhRb07U8v3pQQWURbHwwc16Az/AH9K7
 JG9xbYmQRv/Nf8gtkH0Ytga7TtJQjK2izYYe6h6HKav+lAKKWhVoGxvmykHwlGuz5OSv
 Ihn9V2zD2H7z4JcaH8Xj7QMvt46XVcEhVq/b1FBpsJHOHdw8HNgxpwZd+jBvg4iRJkjp
 VQNiLmcpwE7bJxqKTLmOItqOenVoCAyLU1V6jilFJcqgfvqiBMISBO7JMWweAdc7S+2g
 +sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236531; x=1693841331;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtjxu0Iu7odUraYc55qdTmS0v2UgCqrPCGRg8hyQUuI=;
 b=MD5N540Sv3/RsW7il5VchDcZN41t/W8va3ALlO0BYCGdAytiOlWEUGvdX7IayypMey
 k7We3maaoN+WBbr3Y5ixTxXbcDcmrML2oPYt5KoeGFDx9/ex8l8n9Cg3Vn+QlFuNZGMn
 OmFnyFXTaS1O4fN0Vmv2aJIUCmspqe1xPLGt2n+lAkDmPaOoo2KktvI3K54NTQhko2F+
 Gt/j815J6i7A+j+QtNFToYOV+izptcaAlYt7A6zd2H7RHwxFzGvhFM2d1zVl+taI5h/Z
 MSd7ydYOTjwV0y4/b2+SOz/qRi46xcFc9ZpTt8PqkWH0B774R4teanC9XGPMeLC/nkD3
 1M7w==
X-Gm-Message-State: AOJu0YypQtwVU9LqCti3hQluXOAFpC29OzzjrN1/AHqiE95HmFCp+xpH
 AvVRCi56g5DCevR+1GTlOMr0Pg==
X-Google-Smtp-Source: AGHT+IG8yY9rSa4RZTOloBYob1lae73mnZ5kr9deRvy8OGUoEOW5xnhu3BzvWOOE39vz7kMXMr5vrQ==
X-Received: by 2002:adf:e990:0:b0:319:6d8a:75f8 with SMTP id
 h16-20020adfe990000000b003196d8a75f8mr21548017wrm.44.1693236531098; 
 Mon, 28 Aug 2023 08:28:51 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d60c8000000b0031c52e81490sm10841465wrt.72.2023.08.28.08.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:28:50 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
In-Reply-To: <20230825180305.69515-8-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
Date: Mon, 28 Aug 2023 17:28:50 +0200
Message-ID: <878r9vw5hp.fsf@baylibre.com>
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change other than picking up reviews, tested tags along the way.
> V5: https://lore.kernel.org/r/20230824031101.3460411-6-nm@ti.com
>  configs/am62x_evm_a53_defconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defc=
onfig
> index d55caabe22c9..1807df8bbee9 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -28,8 +28,9 @@ CONFIG_SPL_SPI=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> -CONFIG_DISTRO_DEFAULTS=3Dy
> -CONFIG_BOOTCOMMAND=3D"run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=3Dy
> +CONFIG_BOOTSTD_DEFAULTS=3Dy
> +CONFIG_BOOTCOMMAND=3D"run envboot; bootflow scan -lb"
>  CONFIG_SPL_MAX_SIZE=3D0x58000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>  CONFIG_SPL_BSS_START_ADDR=3D0x80c80000
> --=20
> 2.40.0
