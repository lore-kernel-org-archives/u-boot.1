Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C417C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 17:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7410680ADF;
	Tue, 18 Feb 2025 18:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f9fiYAAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4958580BA8; Tue, 18 Feb 2025 18:33:24 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C9480646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so40276705e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739900001; x=1740504801; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BnDZk5NXF1fGddxqvA8anV543P6p8EkQWuILW57Jwu0=;
 b=f9fiYAAlgtUXjVg7YkB0b/9KT4T21imE8JGLKjHPXlZ7p5DiAAZ32E1uECPShcaHE7
 dYoWCkzh0UkxDfZA7eVLvj77CjDPqnw8EA2aqO37DUqo2uPPRuju7h9IPxO3mhKSF94R
 kn18om10j8ddg6c5YiM7A8i9UDy77MbLANeba89GQaCpxcAv1rKtQnBJuHygaV4F83aE
 Ij0AnGHb0FPmLyhk+pKIsWvl++ENF7t2X8G/snV+nAytzw95R8Kxw+QrIsRCvcDTlP/G
 bX6BViGR0Rzus++nXPR9nvH5cuA4plk0qbombVIONDERxT1kcG/Coicm168BFXXk31mM
 yC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739900001; x=1740504801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BnDZk5NXF1fGddxqvA8anV543P6p8EkQWuILW57Jwu0=;
 b=ve0rchmlW2JIrJAq43NmA2qu1lNswiG4IkAI45a6ovGv8OUBR0g1jVrMwb6gOO3Rqg
 edZ0q1A+/ghTAQeDMB702YWT/sUiV8IQjmh79dFZD3dVRwMefMHivEDIKuyR/MA13uEw
 wOaWki5im2tQU3GVnE06uguVe2jf7IK8iL6tZLQxCMnmjJuisXEZTl9PlOuM0wlbShzz
 ilCb5LyTZPDh1xSTsKlNIuvWvQLlGoa07X2wIfykzxEsqSx0KLVo0V0HfInW43NleXXO
 i15GrPa0kgXqvCvOwDa4Pk+Y/o9ifdg91+v11KeNmrjuGsGxZ2Yc5f+sGDQpTQsMfgdE
 ysXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrSpoqhMWE4nkwTTQfHyX282wt1N9zNVDIDAbEfms9cnTii0CHoSbtaTy//OT3oZCXdZOT8qk=@lists.denx.de
X-Gm-Message-State: AOJu0YzGjSjTYm5L0VNt1/lSWgd68aBpvi3KV4DRzpTI0n5yLT+5J6dE
 KWanDqHaePGlLB8f8it+jUmQ6DaQHCdEkkTlTMrqiIFZ59T6YPl5PfaSyt+ln7I=
X-Gm-Gg: ASbGnctSbvRPi89/VM1kX0QJOVgfmlTnjKNglhEKY/im9Jrnz0MpEWaytxbrUKut5WT
 +m4Q2RBQjHq79DIaitYc5Kh8Lh9+fzo6M73gNa0RUZ5kLvXPOReUsK7LF4Qv6ZyB3m/kbjOyWgK
 rWPs7X3VCry0Kh1Vth7zZaZoYwhh6smT8zN/THDc8cexzbaNDACz0cx9niszyADPmdcwPG3jzyo
 j5e4q7vKMs7peoS+lvmEePJfYpZXShi7qOg8Z4SjaaRR37h3mSf6ssnNdOJ6VRFkGYKASx0JAyN
 viUEM7+fYv09p74sElZz7H6RXYDN9pUflSpT1of75uWjTQSm7/jPWDflxeKQI5jKoYE7LJPE
X-Google-Smtp-Source: AGHT+IGLKWOfIvFjKb0EBmU36UiiRZw9/o7UKYqeyXcZBDuouAGH+5Jn1uus6jDHXULBxkgRl5+Xqw==
X-Received: by 2002:a5d:59ac:0:b0:38f:3e39:20ae with SMTP id
 ffacd0b85a97d-38f3e3931demr9525758f8f.43.1739900001106; 
 Tue, 18 Feb 2025 09:33:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:9130:73e1:1d41:9989?
 ([2a0a:ef40:1d11:ab01:9130:73e1:1d41:9989])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5655sm15546425f8f.77.2025.02.18.09.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 09:33:20 -0800 (PST)
Message-ID: <59b2b371-97a7-4b3e-af5d-1ea1f6dee2eb@linaro.org>
Date: Tue, 18 Feb 2025 17:33:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] doc: board/qualcomm: document RDP building/flashing
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr,
 ilias.apalodimas@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 Volodymyr_Babchuk@epam.com, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250218085430.2422287-2-quic_varada@quicinc.com>
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

Hi Varadarajan,

On 2/18/25 08:54, Varadarajan Narayanan wrote:
> Introducing basic support for Qualcomm IPQxxx based RDPs.
> Document the build and flashing steps.

It looks like you forgot to squash this patch into a previous one (which 
isn't part of the series?)

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   doc/board/qualcomm/rdp.rst | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> index b51b495e4f..f6ea689b91 100644
> --- a/doc/board/qualcomm/rdp.rst
> +++ b/doc/board/qualcomm/rdp.rst
> @@ -1,24 +1,21 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> +.. SPDX-License-Identifier: GPL-2.0
>   .. sectionauthor:: Varadarajan Narayanan <quic_varada@quicinc.com>
>   
>   Qualcomm RDP
>   ============
>   
> -The Qualcomm RDPs are development boards based on the Qualcomm IPQ series of
> +Qualcomm RDPs are development boards based on the Qualcomm IPQ series of

Also, please explain what the acronym means.

>   SoCs. These SoCs are used as the application processors in WiFi router
>   platforms. RDPs come in multiple variants with differences in storage
>   medium (NOR, NAND, MMC), no. of USB and PCIe ports, n/w ports etc.
> -More information can be found on `Qualcomm's product page`_.

This should point to something like 
https://www.qualcomm.com/products/internet-of-things/networking/wi-fi-networks/networking-pro-series/qualcomm-networking-pro-820-platform

I'll give this a proper review once I have the whole file heh.

Kind regards,
> -
> -.. _Qualcomm's product page: https://www.qualcomm.com/developer/hardware/rb3-gen-2-development-kit
>   
>   Installation
>   ------------
>   First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
>   
> -  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -  $ make qcom_ipq9574_mmc_defconfig
> -  $ make -j8
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make qcom_ipq9574_mmc_defconfig
> +	$ make -j8
>   
>   This will build ``u-boot.elf`` in the configured output directory.
>   
> @@ -28,20 +25,29 @@ security in this case, but it provides the firmware with some required metadata.
>   
>   To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
>   
> -  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
> +	$ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
>   
>   Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
>   on your device with::
>   
> -  => tftpboot path/to/u-boot.mbn
> -  => mmc part (and note down the start & end of '0:APPSBL' partition)
> -  => mmc erase <blk no> <count>
> -  => mmc write $fileaddr <blk no> <count>
> +	=> tftpboot path/to/u-boot.mbn
> +	=> mmc part (and note down the start & end of '0:APPSBL' partition)
> +	=> mmc erase <blk no> <count>
> +	=> mmc write $fileaddr <blk no> <count>
>   
>   U-Boot should be running after a reboot (``reset``).
>   
>   .. WARNING
> +	Boards with newer software versions would automatically go the emergency
> +	download (EDL) mode if U-Boot is not functioning as expected. If its a
> +	runtime failure at Uboot, the system will get reset (due to watchdog)
> +	and XBL will try to boot from next bank and if Bank B also doesn't have
> +	a functional image and is not booting fine, then the system will enter
> +	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
> +	firehose loader binary appropriate for the board.
> +
>   	Note that the support added is very basic. Restoring the original U-Boot
> -	without a debugger is almost impossible.
> +	on boards with older version of the software requires a debugger.
>   
>   .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
> +.. _edl: https://github.com/bkerler/edl

-- 
Caleb (they/them)

