Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D716BC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F1B847B0;
	Sun, 28 Jun 2026 15:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqn/gIIs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6/7DCw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5DA84105; Sun, 28 Jun 2026 15:08:32 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DE68056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9Q3Dm3592961
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cY1CrrDheeCybKdOQoVas1x2ZnkMpHk/bIJGiwtMmZU=; b=mqn/gIIs0ZGN6WQD
 rYGHCrIPbgAJufcobUjVSDWL7MmKEF4cxSumZN3ezzeC7CuNyhi9PrGpglIVXiEr
 rIvYHpP9uDL4RNnP/bzVOwxxI+I5QEG6pooe3hbS2uaiLqpHsnKQpE3BA8EV1qyC
 evrtjBp1xGn6J+DOvByKjzKD9SlqiKkNeN8RJjhd0EdrFswnx+eu0hDXZA/8t8Tj
 NDmrSzcfqpSiunwCQNxwnLNo42ij3AGeLp/Wc4q0hsWsFVH+oyA9binf+JtMYCsn
 NTtS6KO5tDhTgmRPkSZZXi7bl+2OAwVOizJsF5ik2txPowU076IwJF6Y3mRPBpV2
 psh4PA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27pf2tgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:08:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c9bd8b9c7so2853800eec.0
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652107; x=1783256907; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cY1CrrDheeCybKdOQoVas1x2ZnkMpHk/bIJGiwtMmZU=;
 b=A6/7DCw+hKo5sJk6v3mWlC9L7flBZx3UbBtHAsqVxsAzUODHddNOJEO0lTDsROPcGP
 rOjnEHM3gXxpANtGSkAkkt1tFLPHO0LlTklFHFLDySGgI5Jhmw5ClrTi048/AiJP36Fa
 tDKXrdt4fXNN+WNHV8u1nkrkHl5CI1eUOBPN+aEdrfHc3hs2SeSCKiz6x5jDcxpp+kQR
 eSAJzuJpcUGF9mTMa3Q00IRdvVuMUTFOIpMqyCiXH9O1C9WHfA6VFpUlWzKcH/qO9BHt
 EdtX6/imEHdOCxbY64vICccZcZPYN9Isy6IzmF5HprV8ZW9G+DtFWq4oUKtzmgVnSN78
 CFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652107; x=1783256907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cY1CrrDheeCybKdOQoVas1x2ZnkMpHk/bIJGiwtMmZU=;
 b=r9rJA51eYIr1fmc2/iH8fuJSBNOla21qyXnArlkm5ptxxpPaz3FGweHy7oBX1KZ3u8
 PSwXKZw1fXgMSyqCG8KhJNs525h3cQ1SJIqduZInBOZSHFoyxWbAleA9dXEgKXvQgqau
 x729+JGWFc3ngD29czlZVXHlaJ7qL82W/ktmplOYZAjRpizxQp9LLGc554jKTc4dGtJz
 SOlbMP+TCYDX8oP27wg/wRw/Ls3k4wVx1lf74gwCkINmmNGfgXzvCWkEfZ6N8YAxYatp
 fi0ZT3ySVQDDxpdOZHybG7I0fVQDQguQHmyKF4LyrQ6sutxW1NAmto0tCH0cgLVrpqjG
 RrGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpk67MoVRA11fvz1ltQGiIyXVAb8xVh6kQX4K12Ji6cUJce2ZDUX9VmqZvR25NepNgU6Pcfiv0=@lists.denx.de
X-Gm-Message-State: AOJu0YykyhyaYkxU04SNBdx8QPPbYcitKZHi/PfTTDViMG6aap62dacp
 iZoN6e19c7VlMT/Zs1hrMiT/7Evqw6pjPj/oQtRuuZ+P2xTku1C37mIqniHxMWXBxbJ8JKzOj7B
 PYCIiJvwEVPdXMazWEmaequly9vC/E+jgd2LAIIWNHF/+ogW2FsrixLfC
X-Gm-Gg: AfdE7cngM+WH/f9+EICB0ZHdiocN6gN/WxJ6TSv7UZ6jyPEzujTCs+Phzcxkr3ZptsZ
 Zj2UKY2ae23yoTWqaM0x9OACYqX7TufPlI9HjLPdoa8nbZrG2VGxJ6olh0wZ012i+LwSLJ8mIcf
 SK6AkC+LEVVXQAjRqjaAIIXWY8xAZ/qqkKO9A6FbTXNTdUi4lsHl8mOeCowNuPnihampQQLLe4W
 e8arawXWDtGhQ4ggpDRlkKlQw5wHW/aMz0FA8IEHUo/iDDrvUpHx2msX482TbLXRKF1QhKAaw+f
 mNbCo9OVtY6lBIvaOaeGg1FQsYb6Q5c+ApEprl8Xukbtozd9ucH7J/zEVx/XOaR31ORP715tYNJ
 QaqtX2b1vfxSjbM3Q4xhRlFfs8Gj3aVs0gB8jTBvKEPGFdus=
X-Received: by 2002:a05:7300:ad28:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-30c850a8f65mr13186830eec.32.1782652106312; 
 Sun, 28 Jun 2026 06:08:26 -0700 (PDT)
X-Received: by 2002:a05:7300:ad28:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-30c850a8f65mr13186771eec.32.1782652105584; 
 Sun, 28 Jun 2026 06:08:25 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f15024sm25806203eec.17.2026.06.28.06.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:08:25 -0700 (PDT)
Message-ID: <532e6b2a-c927-4381-bb4a-4b9ea5244b9e@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:38:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] misc: qcom_geni: Add minicore support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com,
 n-francis@ti.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-5-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-5-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfXyclI2jUqmJpH
 IMsGmDnqq4jfrK+S4hj/9zbV5tFIzObbZ3m2pt1/UOLhDRqItM5Zt470Aks9hJrfTJPR5Hw8ofk
 xH92HBwXgPNRGdZYNk/g5u3FV9Plf3g=
X-Proofpoint-GUID: PMdLS-VO90mSJrhkCuxDu3w6UafSiTzL
X-Proofpoint-ORIG-GUID: PMdLS-VO90mSJrhkCuxDu3w6UafSiTzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX0ekU4YnESLrA
 mwFJsZFXGTJFAzNZ6QwwLam9Df80C6SAMSLAFLHFrmT2+ALP08hUXS0STePgYUjFNgjait3Eaqb
 j+p3ttnTng6D72q4nAr7TvmT6H6wb8qFvqkewzZRG0mO+ievXGQciXD2VWGQDI87BZ9bIg2m7oB
 lkelQmj2Q0J+C1WSI1vDC2SWo+f3pQoOzth9indpIkQVlZSBoyGn1m5OauldTXsbMtI/fnigq5/
 vkIeB5+rdtHM3ZoItg4RL7aDkFRfrTC8lsuOhb85Q5D/Whrxr9t0C63yl3XNmmMq5C9S35nk1kX
 HZM139LsMDD07s9h49gMaXlmCGH4740XQWJ/it7Scd742uvkhnmq4ERAHY3r0ErEqhbTgaGqMdE
 JKzB33pMvl2VVB/RgXdKoN6tPsqKoDDMs5CLBS6SfZrlYoa7BxLv3qT/T98YkELK9my6tmNlGb1
 YJ9uyP8YcDxWEoLaIow==
X-Authority-Analysis: v=2.4 cv=R7Mz39RX c=1 sm=1 tr=0 ts=6a411ccb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=oXKXWpg8_xdbO891-JIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280116
X-Mailman-Approved-At: Sun, 28 Jun 2026 15:25:03 +0200
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

Hi Varada,

On 6/23/2026 12:17 PM, Varadarajan Narayanan wrote:
> The qcom_geni driver reads an ELF from storage and configures a set of
> registers and programs the firmware to the GENI Serial Engine (GENI-SE)
> wrapper device for the expected functionality.
>
> Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
> wrapper is pre-configured for one of the functions defined in 'enum
> geni_se_protocol_type'. Hence, the firmware download is not needed.
> Only the register configuration part is needed.
>
> Earlier, the boot stages before U-Boot would configure the GENI-SE (to
> access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
> (i.e. boot ROM) doesn't do that modify the driver to do the register
> configuration part alone without reading an ELF from the storage.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

> ---
> v4: Remove duplicate defines from qup-fw-load.h
>      Return failure is SE protocol is invalid
>
> v3: Use wrapper probe fn to call qcom_geni_fw_initialise() for SPL
>      Return error if ELF is not found and it is not a minicore
>
> v2: * Add CONFIG_QCOM_GENI_MINICORE option
>      * Move register settings to separate file and include if
>        CONFIG_QCOM_GENI_MINICORE is defined
>      * Remove duplicate definition of GEN_USE_MINICORES
>      * s/GEN_USE_MINICORES/GENI_USE_MINICORES
>      * Skip find_qupfw_part() if it is a minicore
> ---
>   drivers/misc/Kconfig              |   6 ++
>   drivers/misc/Makefile             |   1 +
>   drivers/misc/qcom_geni-minicore.c | 102 ++++++++++++++++++++++++++++++
>   drivers/misc/qcom_geni.c          | 100 +++++++++++++++++++++++++----
>   include/soc/qcom/geni-se.h        |   5 ++
>   include/soc/qcom/qup-fw-load.h    |  12 ++++
>   6 files changed, 214 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/misc/qcom_geni-minicore.c
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ea785793d18..4317bde7406 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -93,6 +93,12 @@ config QCOM_GENI
>   	  for providing a common interface for various peripherals like UART, I2C, SPI,
>   	  etc.
>   
> +config QCOM_GENI_MINICORE
> +	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
> +	depends on QCOM_GENI
> +	help
> +	  Enable support for minicores in Qualcomm GENI and its peripherals.
> +
>   config ROCKCHIP_EFUSE
>           bool "Rockchip e-fuse support"
>   	depends on MISC
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e2170212e5a..2daccbba74d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
>   obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
>   endif
>   obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
> +obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
>   obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
> diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
> new file mode 100644
> index 00000000000..33bc61ddf35
> --- /dev/null
> +++ b/drivers/misc/qcom_geni-minicore.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <soc/qcom/geni-se.h>
> +#include <soc/qcom/qup-fw-load.h>
> +
> +/*
> + * Register configuration for the QUP minicores to setup the corresponding
> + * functionality of SPI/I2C/UART.
> + */
> +static u8 cfg_reg_idx[] = {
> +	/* 0 to 18 */
> +	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
> +	/* 64 to 113 */
> +	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
> +	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
> +	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
> +	112, 113,
> +};
> +
> +static u32 spi_cfg_val[] = {
> +	/* 0 to 18 */
> +	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
> +	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
> +	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
> +	0x00004000,
> +	/* 64 to 113 */
> +	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
> +	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
> +	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000055,
> +};
> +
> +static u32 uart_cfg_val[] = {
> +	/* 0 to 18 */
> +	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
> +	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
> +	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
> +	0x00000B00,
> +	/* 64 to 113 */
> +	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
> +	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
> +	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
> +	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000055,
> +};
> +
> +static u32 i2c_cfg_val[] = {
> +	/* 0 to 18 */
> +	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
> +	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
> +	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
> +	0x00000000,
> +	/* 64 to 113 */
> +	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
> +	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
> +	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
> +	0x00000000, 0x00000055,
> +};
> +
> +struct qup_mini_core_info qup_mini_cores[] = {
> +	{
> +		.serial_protocol = GENI_SE_SPI,
> +		.fw_version = 0xb02,
> +		.cfg_version = 0x9,
> +		.cfg_count = ARRAY_SIZE(spi_cfg_val),
> +		.cfg_val = spi_cfg_val,
> +		.cfg_idx = cfg_reg_idx,
> +	}, {
> +		.serial_protocol = GENI_SE_UART,
> +		.fw_version = 0x405,
> +		.cfg_version = 0xa,
> +		.cfg_count = ARRAY_SIZE(uart_cfg_val),
> +		.cfg_val = uart_cfg_val,
> +		.cfg_idx = cfg_reg_idx,
> +	}, {
> +		.serial_protocol = GENI_SE_I2C,
> +		.fw_version = 0x204,
> +		.cfg_version = 0x9,
> +		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
> +		.cfg_val = i2c_cfg_val,
> +		.cfg_idx = cfg_reg_idx,
> +	}, {
> +		.serial_protocol = GENI_SE_INVALID_PROTO,
> +	},
> +};
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..40044e5d48a 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -34,8 +34,15 @@ struct qup_se_rsc {
>   
>   struct geni_se_plat {
>   	bool need_firmware_load;
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +	bool is_mini_core;
> +#endif
>   };
>   
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +extern struct qup_mini_core_info qup_mini_cores[];
> +#endif
> +
>   /**
>    * geni_enable_interrupts() Enable interrupts.
>    * @rsc: Pointer to a structure representing SE-related resources.
> @@ -163,16 +170,53 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
>   		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
>   }
>   
> -static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
> +static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
>   {
> +	struct elf_se_hdr *hdr, tmp_hdr;
>   	const u32 *fw_val_arr, *cfg_val_arr;
>   	const u8 *cfg_idx_arr;
>   	u32 i, reg_value, mask, ramn_cnt;
>   	int ret;
>   
> -	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
> -	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
> -	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
> +	if (elf) {
> +		hdr = info;
> +		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
> +		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
> +		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
> +	} else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
> +		/*
> +		 * Minicore controllers come with pre-configured functionality
> +		 * and don't need a firmware download and just need the register
> +		 * configuration. Hence, skipping the firmware part and setting
> +		 * up just the register configuration related information.
> +		 */
> +		struct qup_mini_core_info *qmc = info;
> +
> +		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
> +			if (qmc->serial_protocol == rsc->protocol)
> +				break;
> +
> +		if (qmc->serial_protocol == GENI_SE_INVALID_PROTO) {
> +			dev_err(rsc->dev, "Invalid MINICORE protocol (%d)\n",
> +				rsc->protocol);
> +			return -EINVAL;
> +		}
> +
> +		tmp_hdr.magic = MAGIC_NUM_SE;
> +		tmp_hdr.version = 1;
> +		tmp_hdr.serial_protocol = rsc->protocol;
> +		tmp_hdr.fw_version = qmc->fw_version;
> +		tmp_hdr.cfg_version = qmc->cfg_version;
> +		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
> +		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
> +		hdr = &tmp_hdr;
> +		fw_val_arr = (const u32 *)qmc->cfg_ram;
> +		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
> +		cfg_val_arr = (const u32 *)qmc->cfg_val;
> +	} else {
> +		dev_err(rsc->dev, "Neither fw nor register settings found\n");
> +		return -EINVAL;
> +	}
>   
>   	geni_config_common_control(rsc);
>   
> @@ -350,8 +394,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>   {
>   	struct qup_se_rsc rsc;
>   	struct elf_se_hdr *hdr;
> +	bool elf;
>   	int ret;
> -	void *fw;
> +	void *fw, *info;
>   
>   	rsc.dev = dev;
>   	rsc.base = qup_base;
> @@ -377,15 +422,22 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>   	/* The firmware blob is the private data of the GENI wrapper (parent) */
>   	fw = dev_get_priv(dev->parent);
>   
> -	ret = read_elf(&rsc, fw, &hdr);
> -	if (ret) {
> -		dev_err(dev, "Failed to read ELF: %d\n", ret);
> -		return ret;
> +	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
> +		ret = read_elf(&rsc, fw, &hdr);
> +		if (ret) {
> +			dev_err(dev, "Failed to read ELF: %d\n", ret);
> +			return ret;
> +		}
> +		elf = true;
> +		info = hdr;
> +	} else {
> +		elf = false;
> +		info = fw;
>   	}
>   
>   	dev_info(dev, "Loading QUP firmware...\n");
>   
> -	return load_se_firmware(&rsc, hdr);
> +	return load_se_firmware(&rsc, elf, info);
>   }
>   
>   /*
> @@ -414,6 +466,11 @@ static int geni_se_of_to_plat(struct udevice *dev)
>   
>   		if (proto == GENI_SE_INVALID_PROTO)
>   			plat->need_firmware_load = true;
> +
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +		if (readl(res.start + SE_HW_PARAM_2) & GENI_USE_MINICORES)
> +			plat->is_mini_core = true;
> +#endif
>   	}
>   
>   	return 0;
> @@ -473,7 +530,7 @@ static int probe_children_load_firmware(struct udevice *dev)
>   		ret = 0;
>   		/* Find the device for this ofnode, or bind it */
>   		if (device_find_global_by_ofnode(child, &child_dev))
> -			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
> +			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
>   		if (ret) {
>   			/* Skip nodes that don't have drivers */
>   			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
> @@ -492,7 +549,7 @@ static int probe_children_load_firmware(struct udevice *dev)
>    * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
>    * all the peripheral devices that need firmware to be loaded.
>    */
> -static int qcom_geni_fw_initialise(void)
> +int qcom_geni_fw_initialise(void)
>   {
>   	debug("Loading firmware for QCOM GENI SE\n");
>   	struct udevice *geni_wrapper, *blk_dev;
> @@ -518,6 +575,12 @@ static int qcom_geni_fw_initialise(void)
>   		return 0;
>   	}
>   
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +	if (plat->is_mini_core) {
> +		fw_buf = qup_mini_cores;
> +		goto mini_core;
> +	}
> +#endif
>   	ret = find_qupfw_part(&blk_dev, &part_info);
>   	if (ret) {
>   		pr_err("QUP firmware partition not found\n");
> @@ -544,6 +607,9 @@ static int qcom_geni_fw_initialise(void)
>   		return 0;
>   	}
>   
> +#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
> +mini_core:
> +#endif
>   	/*
>   	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
>   	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
> @@ -563,7 +629,14 @@ static int qcom_geni_fw_initialise(void)
>   	return 0;
>   }
>   
> +#if CONFIG_XPL_BUILD
> +int qcom_geni_fw_probe(struct udevice *dev)
> +{
> +	return qcom_geni_fw_initialise();
> +}
> +#else
>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
> +#endif
>   
>   static const struct udevice_id geni_ids[] = {
>   	{ .compatible = "qcom,geni-se-qup" },
> @@ -577,4 +650,7 @@ U_BOOT_DRIVER(geni_se_qup) = {
>   	.of_to_plat = geni_se_of_to_plat,
>   	.plat_auto = sizeof(struct geni_se_plat),
>   	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +#if CONFIG_XPL_BUILD
> +	.probe = qcom_geni_fw_probe,
> +#endif
>   };
> diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
> index fc9a8e82cd8..3063b37010d 100644
> --- a/include/soc/qcom/geni-se.h
> +++ b/include/soc/qcom/geni-se.h
> @@ -77,8 +77,12 @@ enum geni_se_protocol_type {
>   #define SE_IRQ_EN			0xe1c
>   #define SE_HW_PARAM_0			0xe24
>   #define SE_HW_PARAM_1			0xe28
> +#define SE_HW_PARAM_2			0xe2c
>   #define SE_DMA_GENERAL_CFG		0xe30
>   
> +/* SE_HW_PARAM_2 fields */
> +#define GENI_USE_MINICORES		BIT(12)
> +
>   /* GENI_DFS_IF_CFG fields */
>   #define DFS_IF_EN BIT(0)
>   
> @@ -248,6 +252,7 @@ enum geni_se_protocol_type {
>   /* SE_HW_PARAM_0 fields */
>   #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
>   #define TX_FIFO_WIDTH_SHFT		24
> +
>   /*
>    * For QUP HW Version >= 3.10 Tx fifo depth support is increased
>    * to 256bytes and corresponding bits are 16 to 23
> diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
> index a67a93c72a4..b329a18ef22 100644
> --- a/include/soc/qcom/qup-fw-load.h
> +++ b/include/soc/qcom/qup-fw-load.h
> @@ -14,6 +14,7 @@
>   #define GENI_INIT_CFG_REVISION		0x0
>   #define GENI_S_INIT_CFG_REVISION	0x4
>   #define GENI_FORCE_DEFAULT_REG		0x20
> +#define GENI_OUTPUT_CTRL		0x24
>   #define GENI_CGC_CTRL			0x28
>   #define GENI_CFG_REG0			0x100
>   
> @@ -173,6 +174,17 @@ struct elf_se_hdr {
>   
>   struct udevice;
>   
> +struct qup_mini_core_info {
> +	u16 serial_protocol;
> +	u16 fw_version;
> +	u16 cfg_version;
> +	u16 cfg_count;
> +	u32 *cfg_val;
> +	u8 *cfg_idx;
> +	u32 *cfg_ram;
> +	u32 cfg_ram_count;
> +};
> +
>   int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
>   
>   #endif /* _LINUX_QCOM_QUP_FW_LOAD */
