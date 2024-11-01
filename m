Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03196E6F066
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B138902F;
	Fri,  1 Nov 2024 16:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qPJ/qgcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B0D8902F; Fri,  1 Nov 2024 16:16:55 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D981589177
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e13375d3so2278607e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730474213; x=1731079013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+kB9x0+aK88NXi0Foa9PhO6JJyP/+20O4Pjlr3OQ+EY=;
 b=qPJ/qgcztjeazMs0fD0AWl1TEJbmGKcxBE78nwgPGEeAvugOeu+xt4n/CzlRqihNb1
 Xq4nEhrdOSQ+gE/ZyrJmDw06EVX7rZn1sY51V0LXRuRX4MH/KoQOxKRWtxev3tP2KRhl
 zNH3z2ACxv7+vOcXBkliBShja1PL5dWOW4+j7a4ApBv7s5oYfKUM7ZCiQD1fzyed+k4z
 Jb0Q7KvpYnAtAucbhEmmhzTEIMbNNRc38e+PVLzzsG2EjYDXulyo5CU/lsXUVl95vqaZ
 OHn3iM9p/XTjd2XxTtBBIlSF1XUtTuOKTF+pE7PDz1vlJPFEIDpnxjXH1bKdofQOvudX
 RBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474213; x=1731079013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kB9x0+aK88NXi0Foa9PhO6JJyP/+20O4Pjlr3OQ+EY=;
 b=StdWAT8QFp1qnOhgg7T2gmsr9oVnditfndw0Xtel0ZfJeGtNrgQdoaNqOdy/i4hTND
 +haqew83uYra5ijOdIl3NFwUrohb879EHfostEsNHRy25ciqur/mXqIuTUNe2CUydTqN
 gCs+L/fm57PTBkKxxP6g99PssjmikvV/yGXAv+Gd7thy/rKaCy0ManeLr6Ex/XANnP1a
 5z2FhQFGEyyZZftzvZI9+dLrC6ldeWef98GJ9L9nz/49pKR4awOanZ+si52bTHBg3V/b
 qySBAiP1MfJiKtpNxaUDSWDXRyHbXhMlrlOMBlspIL1Flnl81edrJu/qtc9YeVo9GyWW
 X9fA==
X-Gm-Message-State: AOJu0YwMKJdQXfi0X6RQEKYnIfQcRmN0KbYCvuoZsWGDTuGb3wP/VFIB
 ho3rwkd6GfaYa5oSTYZlQpURWlUBYqBphiPkyuRXCwMD7J9k5ScNM9HstTW/kcB+9adWK1XP2Ds
 x
X-Google-Smtp-Source: AGHT+IF0iU9uRfQCXy/XLUXt1fJOe6BMyF3AODgVFbxEv5m5DdKpVb2X31SA1SrE1S5wYqkMtaYP+A==
X-Received: by 2002:a05:6512:6c9:b0:539:f4ab:5638 with SMTP id
 2adb3069b0e04-53c79eb4ca1mr3524043e87.60.1730474212822; 
 Fri, 01 Nov 2024 08:16:52 -0700 (PDT)
Received: from hera (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1168afcsm5455885f8f.91.2024.11.01.08.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:16:52 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:16:49 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/8] arm_ffa: sandbox: Replace the emulator error log
 with debug log
Message-ID: <ZyTw4Xsl_yMbbQr6@hera>
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241101142017.79311-5-abdellatif.elkhlifi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101142017.79311-5-abdellatif.elkhlifi@arm.com>
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

On Fri, Nov 01, 2024 at 02:20:13PM +0000, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Set the log to a debug log and reformulate the message
>
> The message is about showing what the emulated FF-A ABI decided
> based on the user arguments. The log is just for information purposes
> and helpful when debugging.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> index 1521d9b66ac..3e8b5288d3b 100644
> --- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> +++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> + * Copyright 2022-2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
>   *
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -658,8 +658,7 @@ void sandbox_arm_ffa_smccc_smc(ffa_value_t *args, ffa_value_t *res)
>  			args->a0);
>  	}
>
> -	if (ret != 0)
> -		log_err("FF-A ABI internal failure (%d)\n", ret);
> +	log_debug("Emulated FF-A ABI feedback (%d)\n", ret);
>  }
>
>  /**
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
