Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CACC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2243380E9A;
	Thu, 26 Jun 2025 14:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N1QWu1dP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C172582063; Thu, 26 Jun 2025 14:31:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C692809A5
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453066fad06so5187255e9.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750941104; x=1751545904; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUnhJsTjL+cvK7ren7XaSyMi66MLmKZs6nCAXJFZTPA=;
 b=N1QWu1dPipjmkzeEwNipZSYOfOKEwXhpYHT9uiOivzKx/Wg6Nwp0qa8zU8cyOSTy69
 Il7Qo38b4Zs1rWtMX/d7RHS27wkcJp8zhdttdx2r8csMjTa+yrM68sKzz+rsKsHuf5GZ
 ZA46nkCnDNa9lCGY3ewZy+zm1hQU+Pst2mshl0Yq/FTvZQ86Rf8mZkVWa6VMG8DJGqa0
 4tVs6qv70+FpLHxNEYcPTVX0dTDFxd7mFvhFzl2uc0ao/tZQ26zkQL37jGSVUmrXer4A
 6vPLXoUV7/NpEzxtKcDJV3vmA3XdTWY85Ns/bs9PREElE6vngPo56lz6WZsMlncRUTyO
 B7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750941104; x=1751545904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUnhJsTjL+cvK7ren7XaSyMi66MLmKZs6nCAXJFZTPA=;
 b=MjvbAR/Vl0Wt0/W7bm2cCMZDXOs9XLZNFJWXVxjgFmuUVsWVeunrTJWN+gQv6E7CQ0
 qjUcQgaZZrB1av8YWmZt9NRIE69fdtzV8B2FyoVHC1CwSc7+4FKutXX/SIHkL4vmwoh7
 qOCHBwKiLHB2AD0J24TdnSdKc4ss7EOSHSlbLCh4LlcJvIOv0oqqeu8qH0EMD2L/N1Cp
 1AAc56w/f219RdycmjxH0EXCaN8EJSQSsToomBNlpeNGhvphwhH8BIgblbE7UQRiidfv
 DsuGL9T1S9YjMkbV8bcn6q9cw4PD7hN9OETWAjaBsE0zW1SNsOB8p3NVlByvj/u74qpF
 KaXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUbRxnHsekJ8dbDusszuoqhBhaCmg0qExt5gU6yfhvS4GwQ0F1uuIG1cFk4rQxdlz4IZ8XMyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwfF6sHV0b7LOvx55++bOS56hLozOytGws+CwnZ+d7Gw0Vn3Sld
 nqTm9RGFhOSFPYpuCOcsXopQjvO7alOZKRiwbS1F2i5JzvB+k1Mj0eHIU5eO234blok=
X-Gm-Gg: ASbGncvSrSu2Qe5BwX8UBoG+l69VlYQn19z4/BjhJN6ZlPhDoFvATsbDYqQF5dhAvXv
 nG2i+If9d4ZejLe/GW4DMuEwmGeMGO3CdReQPLgF1VjCEwBTqKrLEU9Ek/loO2AQYR1fqdbe3Uc
 7qdMMfU6A/vxDvCYW9uHVIiY+gok1Pbvcsx3+po5faVRIZj6Il5++zhf8nQsurHZcSlbirty0QK
 fhiBqxltkCfLOLj9cA3kSHPol6lqzNiF7Dcz8WeSApaBKSOdCANy4Kf6D/gsw9PuSWN7p8MkFbg
 LiXvNlN0kPFkrkrJLOb9dRuYTTxVrF7FZFfTUpcU4vaAjUQO/44dRQqafjOtf5fuinOcypYxryu
 oYiBQeZanPOjqo5JYCLyj9JLis5f1tx1bpW/uMJv8
X-Google-Smtp-Source: AGHT+IEqGoRxIn+ILLRFgUx+oBkC33WhOS6Z+C1syfagxVoXj2ukfehySk/kNq0hTjpsvjd2qimm9Q==
X-Received: by 2002:a05:600c:37c9:b0:453:7bd:2e30 with SMTP id
 5b1f17b1804b1-4538dbd5effmr7806675e9.29.1750941103628; 
 Thu, 26 Jun 2025 05:31:43 -0700 (PDT)
Received: from [192.168.1.159] (p5b29ef66.dip0.t-ipconnect.de. [91.41.239.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234b6b3sm50259095e9.13.2025.06.26.05.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 05:31:42 -0700 (PDT)
Message-ID: <5afbdafa-a0f9-4146-b64e-8869f68bc7f8@linaro.org>
Date: Thu, 26 Jun 2025 14:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Added QCOM RPMH Power Domain Driver
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, me@samcday.com,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

On 6/26/25 13:24, Aswin Murugan wrote:
> This patch series adds support for the Qualcomm RPMH power domain
> driver, responsible for managing power domains on Qualcomm SoCs.
> The driver is ported from the Linux kernel and adapted for
> U-Boot to enable proper power domain control on SA8775P platform.

Thanks for working on this! I'm very glad to be reducing the amount of 
DT fixups we do at runtime.

Before getting too deep into the code I have to push back on part of 
your approach here. I would ideally like to see the fixup code removed 
entirely and rpmh-pd support for most if not all platforms, I think this 
should be possible? At worst we could have some "stub" code for 
untested/broken platforms which would also let us drop the fixup code.

Something missing from your description here is an explanation of the 
motivations for this. What platform is it needed for and why? Are there 
intentions to expand this in the future? etc...

I guess this comes down to a slightly broader topic that I'm kind of 
flying blind when it comes to the work you folks are doing, it would be 
good if we could have some regular meeting off-list to discuss this 
stuff so that I can better align the work you're doing with the work 
going on at Linaro and in the community as there is a lot of overlap. 
I'll follow up about this off-list.

Thanks and kind regards,

> 
> Aswin Murugan (4):
>    power-domain: Add QCOM RPMH Power Domain Driver Support
>    soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
>      functions
>    mach-snapdragon: fixup power-domains
>    configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN config
> 
>   arch/arm/mach-snapdragon/Kconfig    |   7 +
>   arch/arm/mach-snapdragon/of_fixup.c |   6 +
>   configs/qcom_defconfig              |   1 +
>   configs/qcs9100_defconfig           |   2 +
>   drivers/power/domain/Kconfig        |   8 +
>   drivers/power/domain/Makefile       |   1 +
>   drivers/power/domain/qcom-rpmhpd.c  | 271 ++++++++++++++++++++++++++++
>   drivers/soc/qcom/cmd-db.c           |  45 +++++
>   include/soc/qcom/cmd-db.h           |   2 +
>   9 files changed, 343 insertions(+)
>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
> 

-- 
Casey (she/they)

