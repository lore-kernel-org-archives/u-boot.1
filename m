Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BDFCD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F807849B4;
	Wed, 17 Jun 2026 16:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NhHvQpJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1E7849BB; Wed, 17 Jun 2026 16:14:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692D184833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so9072347a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781705637; x=1782310437; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2HuAUoKw9+fTwarov2QWzSYxJTZhZ08xW7hqwvrT3w=;
 b=NhHvQpJbn5fLcOPcNiiQ+T1NSQ/PFVGKHNAzvEMxjEzrKciGyV2cvVq76xWtyPuhsx
 jv9NVRo3Te83seHFrLAam+zPa7tnjl0d/3bvEA4qRfkuVq1vpQfOVu2ZSIGgR+5p76S6
 RnWTbKm7FKzv3BCfAgLw6RuVNZvdfcCFveHP9sa0TwcZ7wlOWx6NsTY6dOpwgXN2WKMv
 xhrPjp8Lw3vVjZaihjOs9kV3XDuLy2lkbjexhNPtvVtioO6p3X23JciT+QVvRNTTzxNm
 EAv4rvNllk55dLDsH1t0HfjnwzekaEEa8lncdB+N18oR5F2zs65r47psLsMwDTZB7U0P
 z81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781705637; x=1782310437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2HuAUoKw9+fTwarov2QWzSYxJTZhZ08xW7hqwvrT3w=;
 b=KhaNkQaXXn15slLmTJIUFNGvTr96zIEv5fso5VHKl8AfzqPQDCleJ3QxKFpSeVMEMy
 NpToBtYIWtFSMBgjO8tNCWKh3Qi7Ikfc8I8mHOsrAPQcgvc1hki0ul1CCLu4/aUa8xYQ
 RBdyj2hVCrD1iPoZENp6MVcIYH40dAtcTxP8Jlz7XwvSnNJ+SVWIACZXKHNZqMFPEftC
 2NSd1wNhpgrMxFasCKr87NhWegejFfWOzhGwCWA6yUc7yX8ai56cKDnYCDVM9Ff7BYTN
 9ZC1LjzgmxBtSox+wYYcN4yullUPcBEtJ11bE8K+yXpJ5FpOjE+MxhOd3OrEOFS26eO6
 ub3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hyBJ2eLX+ymqEIA5+WHc4RmoiorpUPkjnvfF7sZDQDUY8onOT/Nihmqc68vwf8tBOMsf1f98=@lists.denx.de
X-Gm-Message-State: AOJu0YwiMTz04wXm5k/ZHHrcRp8gy1f9sK4MhhAlgXbeBmARrOhkeIYV
 pAFS/QqiSxQr7YJL6yWtOuC/+Bc3Q0i5Si17iXklLGxu5FV/QWchU7RwqdO9eTbReDg=
X-Gm-Gg: AfdE7cn5vEufyyLtIaZhV0+AwNa+aPJ49KcRtUuWyWHPaCGTWEICjzhrlRM86Rz/nJp
 DoAqHr3//wX63WTYH008NbPrqJ0HAMsao9tBrWz+ITL3AWYsi5+RRogynZJo99GcMlIYO8rLSVO
 ghq/jS+4qetj3S9QXiNuxRS88qyGkmPu6JHwt1bKMLM+7YCO6MJ/y37QigRksxEDWHKdR6Yz2bN
 6uW/geyXVYOZ53/cnPfIL5fTHY3APs9I93H3Oq2A/u1ha06aGzo4EYSJHo7h1hv3qeMUIclNTGV
 nRnweBjRguVSDJlfS7bYmB/xOc6SRs9F+2bnzxi1zFkdCmVF2fgMFQHIz1ohsV6QmIf0giFL183
 TIhjMp+1N8hWlpCc+tJKq51R8fOU0FU0DQVh54Js0/D1QCVd3vfZEqZknrcJcQ0BJ/l/Iq8MD17
 1KIrYicz5Jv60jg7JOm9vT0SSY1KkkzvrpSCzJgqCDS71R1Mi/ifo+
X-Received: by 2002:a05:6402:35c7:b0:693:2a2:9e41 with SMTP id
 4fb4d7f45d1cf-6954749255fmr2305787a12.19.1781705636767; 
 Wed, 17 Jun 2026 07:13:56 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937919b556sm6475940a12.4.2026.06.17.07.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:13:56 -0700 (PDT)
Message-ID: <4d31e770-5803-49fd-841b-f6cfe92860d0@linaro.org>
Date: Wed, 17 Jun 2026 16:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: Add qcs6490_rubikpi3_defconfig
Content-Language: en-US
To: Hongyang Zhao <hongyang.zhao@thundersoft.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Roger Shimizu <rosh@debian.org>
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
 <20260617-qcs6490-rubikpi3-v1-2-495f618a1e4c@thundersoft.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-2-495f618a1e4c@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Hongyang,

Thanks for the patch and for this series!

On 17/06/2026 12:56, Hongyang Zhao wrote:
> Add a defconfig for building U-Boot for the Thundercomm RUBIK Pi 3.
> 
> The board reuses the existing QCM6490 configuration and selects the
> RUBIK Pi 3 device tree. Add the defconfig to MAINTAINERS so the
> Snapdragon maintainers are copied for future changes.

Currently we're opportunistically trying to clean up the naming of
defconfigs, could you prefix this with qcom_? That also means it doesn't
need to be added to MAINTAINERS since it will be picked up automatically
by the existing match criteria.

Thanks and kind regards,

> 
> Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
> ---
>  MAINTAINERS                        | 1 +
>  configs/qcs6490_rubikpi3_defconfig | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f9c5fa0bdd..6a23cffcf13 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -681,6 +681,7 @@ L:	u-boot-qcom@groups.io
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>  F:	configs/qcm6490_defconfig
> +F:	configs/qcs6490_rubikpi3_defconfig
>  F:	configs/qcs9100_defconfig
>  F:	drivers/*/*/pm8???-*
>  F:	drivers/gpio/msm_gpio.c
> diff --git a/configs/qcs6490_rubikpi3_defconfig b/configs/qcs6490_rubikpi3_defconfig
> new file mode 100644
> index 00000000000..1d56659c0c5
> --- /dev/null
> +++ b/configs/qcs6490_rubikpi3_defconfig
> @@ -0,0 +1,7 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of Thundercomm RUBIK Pi 3
> +# with the "Linux Embedded" partition layout.
> +
> +#include "qcm6490_defconfig"
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-thundercomm-rubikpi3"
> 

-- 
// Casey (she/her)

