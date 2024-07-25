Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F81C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB5388453;
	Fri, 26 Jul 2024 01:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gcevlp3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2D88842C; Fri, 26 Jul 2024 01:38:07 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703DE884A7
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34722so2668280a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721950685; x=1722555485; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lww86tc7j/ROK1sAKan5pw7YK64sm67lMA2lY+3mkYo=;
 b=Gcevlp3wN0QlEaHxLoZvtDCqAwuUOPXvgDkzDJdsx8+8mJJsjGwV4/FY4+ziXKeiVP
 5vrKRaPV/QngllWCD5LYz9riCsDIrEvb2QyG9uNNTiv87oCQ5AWdvcTDqXz8gOPlR18h
 mUjD7BzqRmdimehKnMgiTwah8Hxl5QDMtFJuFY4+ll13NFjza6CiqI6Jt2+VNwKcAYQL
 FNZlkrjrdV7/kN/OlINY296H5JSHvNX9QLaVgqjUl1KRm2XyOXvLEffS1FUE2Z+Lc3dZ
 v5CXaOibKyx5hrojGTA82EsmdROcU0wSlkUhF39xuFikYymayfdHgXYtFgr4P37m5Z7L
 gkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950685; x=1722555485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lww86tc7j/ROK1sAKan5pw7YK64sm67lMA2lY+3mkYo=;
 b=KXjbASjCmDOFE7nzx42PmUFTap+sh4X8kxkZvD1DN8fnqOYCDjHcWu2/+RLnGQ+F0U
 mjMxv3PneF5+ymy2W+vXXEZfPUf9VgVaM/HjjWsMw8q013r+zFYI3MN+4Fnr6s11x8QB
 F6zAdf3a+DqPOge9dOjeSa5tra6EFL2Qp1wb/AU1ci1WGB10tUaFPM8sqzaAEAa4AUqF
 qUBABysLvJnMucMy+ZZbeDzv5lpfoHOORn8DOsfoK4oodBwhHYRE5a1y0yfMrEwbIU+H
 mB/HTN07418pW3xu5pYae7/kjYQc4mgfGl7EQh6LbT5miLCm1iLb2stHzLD8ejbMMwTe
 AjBA==
X-Gm-Message-State: AOJu0YzG6mR2Lu9k9vPsLJ0sEKNBQqiIYxR1j1WniKpkhYLfw1D1briN
 PERMki0XXOUtcPJj21YXf5I0ajwvOrtgeHDYybweZJ6WIrzSBwg0YyzsZ6h2A0w=
X-Google-Smtp-Source: AGHT+IHWIuKwwJoA3za4DX6I8XlTVAXCycOxvlOewL7YIn3KyBS4h+O9jrUB7pRfoHb+i6Q7PCzylA==
X-Received: by 2002:a05:6402:2755:b0:5a2:1b9d:1d3c with SMTP id
 4fb4d7f45d1cf-5ac12993e4emr5304548a12.5.1721950684799; 
 Thu, 25 Jul 2024 16:38:04 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63d4720dsm1280622a12.58.2024.07.25.16.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 16:38:04 -0700 (PDT)
Message-ID: <eb3236b4-63bd-4195-acdc-b1930f170d97@linaro.org>
Date: Fri, 26 Jul 2024 01:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/24] qcom: rpmh core and regulator support
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 15/07/2024 12:07, Caleb Connolly wrote:
> This series introduces support for the RPMh (Resource Power Manager
> (hardened)) co-processor and associated regulator driver found on most
> modern Qualcomm platforms (since ~2017).
> 

Applied in 1fbd0582a28d108c77d7f9135a7f2c3da2398b72

https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/qcom-main


> ---
> Caleb Connolly (24):
>        dm: core: scan reserved-memory nodes
>        linux/bitmap.h: add bitmap_empty helper
>        soc: qcom: import rpmh and cmd-db drivers from Linux
>        soc: qcom: cmd-db: adjust headers for U-Boot
>        soc: qcom: cmd-db: drop unused functions
>        soc: qcom: cmd-db: adjust probe for U-Boot
>        soc: qcom: cmd-db: adjust for U-Boot API
>        soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
>        soc: qcom: rpmh-rsc: adjust headers for U-Boot
>        soc: qcom: rpmh-rsc: adjust probe for U-Boot
>        soc: qcom: rpmh-rsc: remaining U-Boot API changes
>        soc: qcom: rpmh: adjust headers for U-Boot
>        soc: qcom: rpmh: drop unused functions
>        soc: qcom: rpmh: U-Boot API changes
>        soc: qcom: add build infrastructure
>        power: regulator: import qcom-rpmh-regulator from Linux
>        power: regulator: qcom-rpmh-regulator: adjust headers for U-Boot
>        power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
>        power: regulator: qcom-rpmh-regulator: adjust structs for U-Boot
>        power: regulator: qcom-rpmh-regulator: remove unused regulators
>        power: regulator: qcom-rpmh-regulator: port ops to U-Boot
>        power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
>        power: regulator: qcom-rpmh-regulator: add build infra
>        qcom_defconfig: enable rpmh regulators
> 
>   configs/qcom_defconfig                        |   5 +
>   drivers/core/root.c                           |   3 +-
>   drivers/power/regulator/Kconfig               |   8 +
>   drivers/power/regulator/Makefile              |   1 +
>   drivers/power/regulator/qcom-rpmh-regulator.c | 544 ++++++++++++++++++++++++++
>   drivers/soc/Kconfig                           |   1 +
>   drivers/soc/Makefile                          |   1 +
>   drivers/soc/qcom/Kconfig                      |  27 ++
>   drivers/soc/qcom/Makefile                     |   4 +
>   drivers/soc/qcom/cmd-db.c                     | 225 +++++++++++
>   drivers/soc/qcom/rpmh-internal.h              | 138 +++++++
>   drivers/soc/qcom/rpmh-rsc.c                   | 505 ++++++++++++++++++++++++
>   drivers/soc/qcom/rpmh.c                       | 110 ++++++
>   include/linux/bitmap.h                        |   8 +
>   include/soc/qcom/cmd-db.h                     |  30 ++
>   include/soc/qcom/rpmh.h                       |  28 ++
>   include/soc/qcom/tcs.h                        |  81 ++++
>   17 files changed, 1718 insertions(+), 1 deletion(-)
> ---
> change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
> base-commit: 834df20b4ef50cda26936fbc435689fa0c5d47b1
> 
> // Caleb (they/them)
> 

-- 
// Caleb (they/them)
