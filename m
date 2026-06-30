Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387C6C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194B984A5F;
	Tue, 30 Jun 2026 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zpw+w1TV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF5684A4F; Tue, 30 Jun 2026 13:36:37 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D501B84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 13:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4763b0c1dcdso203290f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782819394; x=1783424194; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iEZNZtjg5MQrBRzUQ3WFmlhobIa5A1I+7Pqzzdxia5Q=;
 b=zpw+w1TVU4cmTkk9SPCcswj5AQQC9Il+s/95AX9Wj545BrXh+BqBt6hO0vXWn+dElN
 U98UJyARwZTaQLTpl9ZwRVk+k3JtA/1OBnqUDPKXtLzY1ZJ58G0uB1sxyE3Vz55amURR
 OwiQMinJeY1+l6HMOrCzLkn9sXvpcSIgIWsiUQZuYDciNvKyEIlPpl6e7C+VfXWLUMK1
 6H6qFHEsoBZoN25b/BDmJT3t0nBOGvBFq3p/UEX3KwVgc7aP5BV1xQTe4UsXBaV2Vv78
 bbU3gMsCUcBlC1MQ1J0OSIeomdDq59rlctZomAhAjtkkb6ZdK4RVpu8dwtCksWkvP1FL
 wJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782819394; x=1783424194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEZNZtjg5MQrBRzUQ3WFmlhobIa5A1I+7Pqzzdxia5Q=;
 b=nKFsaJ+0DkE9h02CFAh160wvwmFIwUxBSGbvJDjAo6eVgmidOfcffOnSTZgKqwhpGl
 I45n7+F628H+CCd1kI9nvcKnhEDSRCT1vqOgHdBxxdY2XxRN0tFRHVzjTKejKbVtXQxK
 +Vks7NE/j2CTaOA3bO0eGid8tc7tCTVM6SzsWJhq/z+pGFJx6NpNG8edEnWvMI5/pqq4
 OYHm5xa+3Hh11OyBxCXMClwEFejy3I3ecpnNKnPeoa5RJkyDsPdjP+uLkpr6Z3Z89UfO
 PcKqLkiud3m2RtR0NzR2l3vNJngY8IUeXi57oISFHvx0NYwoL7he/dM6P6oiP9myywIT
 IjhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tLLUbmzvARasgSz6v1vPNl7WreUlpfHd6i9lnd1fhWI/sTptvzXBKXOhH4HLxLwnpFCogohM=@lists.denx.de
X-Gm-Message-State: AOJu0YyZb94Hkie+rWWzQ2fcNIdF1jbWkMlTrwh+6Q9IqAtyA2KcP4D7
 ljgzexu6pjnEjA3zhk+Q2+zR1ecpri5g2hfSluk1KdwFoAQzKTfjqnEbAEv1i03qzf0=
X-Gm-Gg: AfdE7cm6YtUtm4XDfLrBNeJmaLLaj4r/9qTlE4Wymk+EcSKZHfH68gKviY8Uwj9OhI6
 Eet7TWQeRxttK77LTr2awxWb05U0tStbYiwDiPWBR/1XB9Oud4zlFyvI1MEsml6axoQmNNePf93
 QOK0NYwAp96dihHhmal7hB1Ox2MMTOurRgdP2oi5/nTD/cisSklnV+cSfR7dBH2KwXBVTmfDjkN
 WL7VAbxsk5YpHr4E89wjr6z260Re/m6CS5WWZ9UFCnzzfCQ8ykgWob5+ZvR9Ac2Fz9UIaCVAAoM
 R89KbUHKznr1gjXIB3y4Mf2Oa0mVYAIqvCbIEW9+fclgxFR43SEnWNqMW6gMHrcfZ/4P+c8lQGc
 jyzyqdmLYScgOtWKjHM/jIgUIFI8FOuo0e6MDUtf5YMArcEwL4hTsV4TFfm2po9//FWhWaZUn3/
 yUmGl28TVbKHpdzoMKD5qzXnD/gZI1BbSkqNoSIQ==
X-Received: by 2002:a05:600c:8288:b0:492:465c:56f6 with SMTP id
 5b1f17b1804b1-493b8289c9bmr48835765e9.10.1782819394135; 
 Tue, 30 Jun 2026 04:36:34 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0462asm63554665e9.11.2026.06.30.04.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 04:36:33 -0700 (PDT)
Message-ID: <bff145c2-2b17-4d0b-8bad-8d615ebd65b1@linaro.org>
Date: Tue, 30 Jun 2026 13:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] spl: Include SMEM driver in SPL
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-7-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260623064804.3988799-7-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:13 +0200
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

Hi,

On 6/23/26 08:47, Varadarajan Narayanan wrote:
> Add SPL_SMEM config to enable/disable SMEM driver in SPL.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v3: Pick R-b Simon
> ---
>   common/spl/Kconfig | 8 ++++++++
>   drivers/Makefile   | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e49..88db96807b0 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1387,6 +1387,14 @@ config SPL_RAM_DEVICE
>   	  be already in memory when SPL takes over, e.g. loaded by the boot
>   	  ROM.
>   
> +config SPL_SMEM
> +	bool "Support SMEM (Shared Memory manager)"
> +	depends on SMEM
> +	help
> +	  Enable support for the Shared Memory Manager. The driver provides an
> +	  interface to items in a heap shared among all processors. This enables
> +	  the drivers in drivers/smem as part of an SPL build.
> +
>   config SPL_PCI_DFU
>   	bool "PCIe boot support"
>   	depends on SPL_PCI_ENDPOINT
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 43d0ba33281..ead082450ca 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
>   obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
>   obj-$(CONFIG_SPL_THERMAL) += thermal/
>   obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
> +obj-$(CONFIG_SPL_SMEM) += smem/

As I mentioned several times, SMEM support is being reworked. It 
unfortunately took a bit longer than I hoped but I picked it for 
qcom-next last week, I'm also picking up the sdm845 SPL patches so 
please wait a day or so and then rebase this series on that.

https://source.denx.de/u-boot/custodians/u-boot-snapdragon

Thanks,
Casey

>   
>   endif
>   endif

