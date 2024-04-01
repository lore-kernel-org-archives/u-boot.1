Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CD8CD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D07A882D2;
	Mon,  1 Apr 2024 06:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aX0c8l7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1703C882D6; Mon,  1 Apr 2024 06:48:19 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC29B882D2
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-47832f13a82so1224611137.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946894; x=1712551694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rkCY76B/+b4UEuYs1U6CL9EiQxvhKGFJ23/UQDTK0cE=;
 b=aX0c8l7z3wEARxMj+GRV527xG+go6n0sgSJYA7gb/OM7JT3jNqDGKdkpL01KW7Es3Y
 WrquL4ZNvhiFObxONs7VzBgR90e7aqcjc7MRjSph7gksTfW0+y2J7bjapbGiWHjbwgUC
 hicA4PQEpSHsnG+clq85uHTlVCMqll0A74djPJt3PDpIM4/Cd72/BFhitf8yvQX7/Ulo
 2txhf8k36gn6FlHfKhJsX2gH1e9A71IU83CDKKf4LIZqYmqDL1qzMCQGQphHZZCrmcne
 AAbUyQX/2sO0eUYB8OOhw37GUT+OcSouF64nGtHsYkF4YEktrJmaf6Qsre2G8R+CEYMI
 Mm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946894; x=1712551694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkCY76B/+b4UEuYs1U6CL9EiQxvhKGFJ23/UQDTK0cE=;
 b=WzITuBbqT8guW78E1eOsKxDTs7KRcP/4EuFFfqPau8mamAnZZL5ZW+4Gw3caT3ICY0
 vKAMY0u2vpb37JCWG6bsy2fIIQhS/M6/YL/rn0Vw95gmvoQRrJZ8BZ8dyfRNd1UEmMe7
 TESLQlpBL6agbqEzk4qm9D4BJAG9Gpq3bxV20W9iBQKgeEE7FW03JBeSzrZ5w9/AZjE3
 nReKuT+pQJ83QfsT/Dv+QJR2+2jR+YyUn9ucHZmA8tsa93IslWuRoLkhkdSqq7Eqed/9
 ebGg9jqgQBBU4czdoqJ2oJCu2Bwm7/s39FOcq1m93J887UB2neIngPpUN0WSfWwepdGz
 hIpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoxcD9+z39UOyWxVix4InrbebOapwKDMVjuAimTeUD/1c6jpbf7XDAmRuz+CIRdET3feNG6z14zHpuSwMREfxdjlG6CA==
X-Gm-Message-State: AOJu0YxQ1Ae4Jref+Qcyhk0SjgpIsJuf6AU0teaA2FjK7gkYSXO0cc4Q
 HsP2T1CMlDLBZMlALMn2+JrY92SI8hiZeeu4UMBpAO/tELJ4XIib/wggypOdQWXi4ff6zPCk8V9
 LfRcP7QonA28TQg4hNotXQIDWyf8x4y+7kODPnQ==
X-Google-Smtp-Source: AGHT+IGCPojYMAeoQeelglpeJOQd34AmQ72tCPhjmIeJVBULG6VfgaKAX8j8KjKFjOeWtdVzFwWQ+ZV5TGCQbakwn6c=
X-Received: by 2002:a67:ecc9:0:b0:473:4d73:5e1c with SMTP id
 i9-20020a67ecc9000000b004734d735e1cmr5331422vsp.9.1711946894290; Sun, 31 Mar
 2024 21:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-12-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-12-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:18:03 +0530
Message-ID: <CAFA6WYMnkcEBRr-XySBOWVoq87S9v1XAupn1CWV-uRKuuxhp_g@mail.gmail.com>
Subject: Re: [PATCH v5 12/16] mach-snapdragon: call regulators_enable_boot_on()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Make sure we power on any boot-on or always-on regulators. These are
> used for peripherals like USB on some platforms.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 65e4c61e866a..3d5994c87886 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -15,8 +15,9 @@
>  #include <dm/device.h>
>  #include <dm/pinctrl.h>
>  #include <dm/uclass-internal.h>
>  #include <dm/read.h>
> +#include <power/regulator.h>
>  #include <env.h>
>  #include <init.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/bug.h>
> @@ -160,8 +161,9 @@ void __weak qcom_board_init(void)
>  }
>
>  int board_init(void)
>  {
> +       regulators_enable_boot_on(false);
>         show_psci_version();
>         qcom_of_fixup_nodes();
>         qcom_board_init();
>         return 0;
>
> --
> 2.44.0
>
