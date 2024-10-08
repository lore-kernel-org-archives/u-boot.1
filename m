Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944AFCEF172
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B54C88E18;
	Tue,  8 Oct 2024 15:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NMBVFgQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B3A88E6E; Tue,  8 Oct 2024 15:15:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0231788E18
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so57705025e9.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728393315; x=1728998115;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiQAYMdtTeLtxBJjS3BiMAnDTiJu02juPHKWhplXTI=;
 b=NMBVFgQ7/b5yi3tVDppu6rVc+9BeIlR5v4RG8ZrDHPHO0NtvdcG52pm7gBPZXgn411
 lSqcrpcDHEUYMikAsoPNWVGfypqIZfDEyRJWWRThCmzSnb3aInqtJEQimx8dEdJ4ZlQ1
 n2dl7GdtPtf5zRrNBBjbNKSJq2D7B4WeG+/bAnzclc/+Zz4cxkWlRFJ9Au/Y76Y68FEI
 m1sO+FFrO9SPxqvfbcRFWziT6QXjGWFQw3bh4AsqL0fUeq0z2VhTa0PZdlZ9TdVGmrtL
 K/ZNv5HGK2GLbavZZpIiRm2HGWYiC+Jo//H3SW1e6VDpyQLaTDX/o7pQBwNH6ig3QayB
 qBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393315; x=1728998115;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PGiQAYMdtTeLtxBJjS3BiMAnDTiJu02juPHKWhplXTI=;
 b=dV/lGEPI66lhFRCnYdWj5LKawiKzHrZCRHIoXKHjaCMenmN+P8mfjqwxsz/R4+WoKD
 z5ysE68B0uPFKqRSzvMOvMsiYQN2SkQzZ13S7gFgDhpgkRNZFsyoHOxLMpRca3xolTHF
 BgC6QjELhSF/YMl3tbcpaDuSlsVBRr47XlK4Dj3OxZkn+KTW4WnzzYV8kfxCkaP2HITy
 ut70hI7nLXq2aAuU+RWYXwmaul4PjaxDz/96ay+LcH2WQzuBcr9r6qMvyoX1PlVgrQXy
 Pyh5rm5kAmmuzrFoL70/d7cuOAUUrKJj9Px396rbTDVkXtqsasK2JJ2ZD5VPGaTRCwk8
 m2MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm0g9rgKulmSelHdasFt9JeEHOAVugZSrG6bYBwwrfzX1Uuoe8ROx9paoLHbG7aRR9Cnr/N9Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwLqMQGSIjLa/Fd3LDVIF3EnvQVMbG7k6iD0aLB+v7WwLo41Lc9
 rJsfNfh8K+iBT+Pzq+sv59BeyNE8ahKSiqOAW0RNHOtXXwuEaZ375N+0REGacDY=
X-Google-Smtp-Source: AGHT+IHnMfNK4J5QStrnAMA8tB1l6WWrlYsHOFKPh+1AYX/MHembB/Y1FQ2Ox+WMy1tOh/AzVGiXLw==
X-Received: by 2002:a05:6000:186f:b0:371:8eb3:603a with SMTP id
 ffacd0b85a97d-37d0e77a468mr11958854f8f.27.1728393315395; 
 Tue, 08 Oct 2024 06:15:15 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d169107d8sm8072682f8f.16.2024.10.08.06.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:15:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Joshua Watt <jpewhacker@gmail.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] Make AVB_VERIFY depend on FASTBOOT
In-Reply-To: <20241002144845.1439316-1-jerome.forissier@linaro.org>
References: <20241002144845.1439316-1-jerome.forissier@linaro.org>
Date: Tue, 08 Oct 2024 15:15:12 +0200
Message-ID: <87cykag2hr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jerome,

Thank you for the patch.

On mer., oct. 02, 2024 at 16:48, Jerome Forissier <jerome.forissier@linaro.org> wrote:

> AVB_BUF_ADDR, which is under "if AVB_VERIFY", defaults to
> FASTBOOT_BUF_ADDR. Therefore AVB_VERIFY should depend on FASTBOOT.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  common/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 957de0c5c02..c011ab6e820 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -850,6 +850,7 @@ config AVB_VERIFY
>  	depends on LIBAVB
>  	depends on MMC
>  	depends on PARTITION_UUIDS
> +	depends on FASTBOOT
>  	help
>  	  This option enables compilation of bootloader-dependent operations,
>  	  used by Android Verified Boot 2.0 library (libavb). Includes:
> -- 
> 2.40.1
