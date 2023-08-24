Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E74C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C5D86584;
	Thu, 24 Aug 2023 10:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="uMAeIeeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D6B286586; Thu, 24 Aug 2023 10:36:23 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5917186582
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso1614185e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692866180; x=1693470980; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4fNIcuIA25JxRRR8p+/+TZVHSV+6oGauXSu3DdTdH0Y=;
 b=uMAeIeeEOtb0hjnBkSnNb7QMc83GH6gLfN8ZhD9X4Dpjimm5Hus+fOAv5YzdoW8uf2
 bTAxLjwkgNvoeHnoml263JodHWDutUc/5WgcQuSWouq87UWu2Q9cnUhqw/aqUlSCL28W
 JLb4P2qrcMxRnSC/WcJbusEboIlaVVyeKfg+TDdn6qwxyVNQehLA6WNq7qAXYJOWaZOA
 cpJ9hHdqW5gffpOh7kXI0umzLTP10Tbxa9C4W7dXWgq2kjNFR2F7aFvw3q1nKMUJ5jhv
 r4sX77tJCBvdZs19svOGBpIDLn+LZxnVsH96E3PoHXHoo9SzHxGKdI3gl/9yTrEs4KHZ
 BP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692866180; x=1693470980;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fNIcuIA25JxRRR8p+/+TZVHSV+6oGauXSu3DdTdH0Y=;
 b=ALF/3qxZvYdS/ocLjK/YlPm6uO7nUDvkynsax82VOLbEnGlxudzEJzjuV89+5dTkUu
 f/8KIuOIefbCyZNPr2uoPzn2UvPS9HCv+1uEP+hFa29U4ptaYYtF+1NuIvH4N/hF9Ifm
 ZS18MVqVHQCkVIRIzFe77e3dgvFS2/2qFV37G5i07/+uq+0NhBTzjZTSAizHG/z4l9EW
 Au5h9QlxEyGPWtliDk+trZ0qid6TRtW6fZg9rRbyS69xLUw9Y0CXvt2nxLqhxm0M55+p
 Ts1r1DgvqdMKYJ1WOR5P0Ds+MjFFiarrZhpk5sfL8NJGWdtoMwehvJWvhQ1ddMP5FsG6
 D8lQ==
X-Gm-Message-State: AOJu0YzBRCCDpTkIcUkHkyWbnAGbgsJjf53ppz4OWuTSxxd6htiGzEOq
 rOddOHmThmX3MIUQ2n6DvCcJxQ==
X-Google-Smtp-Source: AGHT+IE5r5cN9fuQckJfSn3xdfYJCTIFp9XAeE/NThSqs8njsd0upqCzfFICEpN7hrbRNmfcUl0ykQ==
X-Received: by 2002:a05:600c:c5:b0:3fe:fe71:14da with SMTP id
 u5-20020a05600c00c500b003fefe7114damr4827159wmm.10.1692866179705; 
 Thu, 24 Aug 2023 01:36:19 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 z9-20020adfe549000000b0031762e89f94sm21546893wrm.117.2023.08.24.01.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:36:19 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 11/17] arm: mach-k3: am625_init: Convert
 rtc_erratumi2327_init to static
In-Reply-To: <20230824031101.3460411-12-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-12-nm@ti.com>
Date: Thu, 24 Aug 2023 10:36:18 +0200
Message-ID: <877cpkrg59.fsf@baylibre.com>
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> The erratum is called locally, make it static, drop the #ifdeffery since
> it will only be called in R5 build and mark it potentially unused to
> stop compiler screaming at us.
>
> While at this, drop the redundant return for a void function.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> new patch (cleanup before modifying for adding UDA-FS)
>
>  arch/arm/mach-k3/am625_init.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> index 165bca6885ef..499cb57267b9 100644
> --- a/arch/arm/mach-k3/am625_init.c
> +++ b/arch/arm/mach-k3/am625_init.c
> @@ -80,8 +80,6 @@ static __maybe_unused void enable_mcu_esm_reset(void)
>  	writel(stat, CTRLMMR_MCU_RST_CTRL);
>  }
>=20=20
> -#if defined(CONFIG_CPU_V7R)
> -
>  /*
>   * RTC Erratum i2327 Workaround for Silicon Revision 1
>   *
> @@ -94,7 +92,7 @@ static __maybe_unused void enable_mcu_esm_reset(void)
>   *
>   * https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>   */
> -void rtc_erratumi2327_init(void)
> +static __maybe_unused void rtc_erratumi2327_init(void)
>  {
>  	u32 counter;
>=20=20
> @@ -112,9 +110,7 @@ void rtc_erratumi2327_init(void)
>  	 */
>  	writel(K3RTC_KICK0_UNLOCK_VALUE, REG_K3RTC_KICK0);
>  	writel(K3RTC_KICK1_UNLOCK_VALUE, REG_K3RTC_KICK1);
> -	return;
>  }
> -#endif
>=20=20
>  void board_init_f(ulong dummy)
>  {
> --=20
> 2.40.0
