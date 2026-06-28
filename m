Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB124C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F04884975;
	Sun, 28 Jun 2026 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BesUcnqX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJaoqLZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601B684105; Sun, 28 Jun 2026 15:11:36 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E978056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9P2gt3611307
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 23nwcz4Bvp6tVQgkmvNXYaN1x6gCwYTTdNe91xlZ/Wk=; b=BesUcnqXsUYV+qE1
 ejLWnnarCVU/h5OqGUCJau3BmyYlwpUMixMHT38OUdGltiWB9BB75el8wQIyxWxg
 F5MMMk8kgR2PZoqlCw2uXbWDGYl0Wb8bu27DJg0MHO/XAUjD/5/A1D7hfoQtKkMa
 IDp5wje2PJJIYFGexHzz1HjrWbtCVabHV9Da6Hm2297e2KGwQnhcHuJ+GR+f1tvz
 RrwTNND726maSVQcC3gUUp+qnZDJH92UqC11lTCiMQWpjErdw1iIIKQNvdmd0TVR
 VWvt0JT0WO26dPM0q5JPsNt6dwjGeN/RM0SRlWMdOmb78afXpucylAKsreVtrYlX
 HcDxIw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f270a2y0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:11:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ca1f74cacso2220272eec.0
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652291; x=1783257091; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23nwcz4Bvp6tVQgkmvNXYaN1x6gCwYTTdNe91xlZ/Wk=;
 b=gJaoqLZjdGJkxSi21dODv/0cvZjB4bj854lLCjgc0lnWhT0PYLE34XWIa2dPGUOBdv
 3SK3tZbRhqVQsaDxSr5yNIbApUcEEFFyoZWwkQ7Knc/aLl2xWg8GnMNC2Mkj+pS4CduT
 jfDkYn0Kvt+XQfHdJRUz+k5Vv7z88foUdrXt2l093I2CusrzUXurEAmvCNO91xBkwN3s
 5wZpdjpfIgSTisse2OU/QcASVQOJrJDY6++d45C2vxybNsrK5hn9W6mgsAU19RoZfunz
 6dING+IWe1uciInBnkaFDxq09wODVNdPkjemwdoBp4iX2GtG5KMyHcjdE21Aofyr4LUV
 ssMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652291; x=1783257091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23nwcz4Bvp6tVQgkmvNXYaN1x6gCwYTTdNe91xlZ/Wk=;
 b=Uj4TaRIZSGk0QXfHqfxfxCcxudqIs17UftTB3/QNaAs61MmpXMsH4H1SjEC9+/Xs4n
 8TIhOoo1251o3lunkMANIayKK8Z+cuKyP6BuXA1aIQZCp4lnI8vDIkn09GEtsncg7llx
 jceEBdT4mPqSvb2rtiQmwmm51EokCK+X8W1FWrvLYtou/ZPM++EgU4bLb7/IQdLec5iy
 ZgaSMRa0qO+b+TEQ9efV8w+oZ9KfxQEs37/6earKs2dz6ASu+mQrPF/BOpUW6SuntHPl
 0l2q+tjCf0yEko7YwXdzkIxUcr+YbjNCMxxzesOiawawR4bvg934zbwyIn5pKJQEJS3E
 hrgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1FcAh4fljBw3JWeqEGwmCSmfOnziavkSZ75J45bJvLZqrGqKWBgZVR+BeA+UFV24AFSzwWx4=@lists.denx.de
X-Gm-Message-State: AOJu0YxrrtD0tc1XpjFhVbAw4giFWV2PT6okCDnVGJT6ppCm23Pe1sj9
 JvLn+BP97IFOYSDOyDBp9zI8BshmEdlaN+JKi0bGIff9jgbV1vUVoAZJbZR7UkT2ZTF7/SWpV/V
 vzgS5WNKlafhOa08Pfrd+nJtNzIz71zHbSfZ2RpCOhYw3MpD/pN4uWVbC
X-Gm-Gg: AfdE7cmNkG2xDvn6s0Bt8lgh0tqmoHXoDXPZPJShIeLkzLVB7MdlqBkHCeOd3Px2sg2
 sW3IjzNMz+RcsYlyJXEsVJIIMzZ+K5LiCJaE1PRx/l9buYooL01p0RtOG4tf2zAY6m4hYCs40h8
 BPtY3JOqpegehBIAl17aPcNY1VfJwJ28rmTTLsCYIGjMcrV1gCUwwR72NRik5Jl7sGYlABgI9lg
 d2wAOAkx3mZ8Fd6rna0cI5Wh+uk++IxJlXJfk7+iXpfCY2VI+ko5ZgW72CR4fPQCL0VBN+Pt2mB
 NRXz4Ihp2KA3hbTm4iuW1s3KAIsCn52tr6Z9i4mfgGvXfIurX5iXUWZXntq1UYIkrg2NVz5ABfj
 we0k6uszN1NNnixF+J6VgJtMmmpbhcZY4oPoEkTNH32fV5D4=
X-Received: by 2002:a05:7300:e830:b0:30e:cb91:6598 with SMTP id
 5a478bee46e88-30ecb9168a5mr351229eec.23.1782652290779; 
 Sun, 28 Jun 2026 06:11:30 -0700 (PDT)
X-Received: by 2002:a05:7300:e830:b0:30e:cb91:6598 with SMTP id
 5a478bee46e88-30ecb9168a5mr351192eec.23.1782652290244; 
 Sun, 28 Jun 2026 06:11:30 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c664sm40560044eec.8.2026.06.28.06.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:11:29 -0700 (PDT)
Message-ID: <8fc52c7b-87f8-4ef5-a75a-71fc065cdfc5@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:41:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] mach-snapdragon: spl: Update SMEM with boot
 details
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
 <20260623064804.3988799-9-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-9-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfXwQaLnAmdGRTk
 7zItxKyK/alFIGLp0hjieAZkvOsDlLuLRr3g+D7v/wTOZ1Hq2dwg9xATkqpkcOfGMpFouYN4JxQ
 Dwa/lWN2ZS9KDdEW1VsNBGKi2onE7UtpHH+JP46NgLhsyz0XBFGziqJAdhQJWvzWqu74R10D9Dk
 /2VskeDoWTT2nCTeu1GYAW+mMmMT/ohChReaeVcTyyDqdsLMPDivT4WOAXLC9a8bm9gJ2/4dNdk
 MD+t8KHFnnmwm/7z/yjKsCbHulmIfFfLHjrIhtfSNHaD+ttTUcVq71XArYS48sfDrZycjCe6tET
 kzkGdyInVFOK8J4ch2lztcnkGQ7mxHk4I7FJaS5F/ViQcfcJodqQNor/rPCrbIoxJRRqg15/liM
 zajJw3m+H1Y+R7UNu1hpboSUPLGQRuVP55dJ7mzK6JrmIwNs0P45Kr8lX+YD4zH4cEcGKYTlZHE
 ubAMWzN6LSjEdHohkjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX33mSWnQ29nuD
 pwp3JsCuZjtvvqvUV9NKX88uH9ecT2v/y2oocZ7JsE7+NJmSqjtbGJLGpABk2USD0JbmjAgiAkj
 zOZKy5QlwuQnM1I98T6dt6nqNrF5ne4=
X-Proofpoint-GUID: U1K2ohBc1TOL-a4hIKPSzySmb7kEvQ34
X-Proofpoint-ORIG-GUID: U1K2ohBc1TOL-a4hIKPSzySmb7kEvQ34
X-Authority-Analysis: v=2.4 cv=Fe4HAp+6 c=1 sm=1 tr=0 ts=6a411d84 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8kKxhoh07Sqrr8qOpwUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
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

On 6/23/2026 12:18 PM, Varadarajan Narayanan wrote:
> Update SMEM with the storage medium from which the system booted.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

> ---
> v4: Handle Boot medium not specified case properly
>      Minor cosmetic changes
>
> v3: Move SMEM init from previous patch to this new patch
> ---
>   arch/arm/mach-snapdragon/spl.c | 73 +++++++++++++++++++++++++++++++++-
>   include/smem.h                 |  3 ++
>   2 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> index 9b8a640256a..aef9bf206c2 100644
> --- a/arch/arm/mach-snapdragon/spl.c
> +++ b/arch/arm/mach-snapdragon/spl.c
> @@ -11,6 +11,7 @@
>   #include <asm/io.h>
>   #include <asm/system.h>
>   #include <asm/sections.h>
> +#include <smem.h>
>   #include <atf_common.h>
>   #include <linux/err.h>
>   #include <dm/device-internal.h>
> @@ -167,6 +168,52 @@ static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
>   	return ret;
>   }
>   
> +#if IS_ENABLED(CONFIG_SPL_SMEM)
> +/**
> + * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
> + * @ctx:	Pointer to the global SPL context.
> + *
> + * This function initializes and populates various SMEM items with boot-related
> + * information, such as flash type, try-mode status, and ATF enable status.
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_populate_smem(void *ctx)
> +{
> +	int ret;
> +	size_t size;
> +	struct udevice *smem;
> +	u32 *fltype;
> +
> +	ret = uclass_get_device(UCLASS_SMEM, 0, &smem);
> +	if (ret) {
> +		pr_err("Failed to find SMEM node (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	size = sizeof(u32);
> +	ret = smem_alloc(smem, -1, SMEM_BOOT_FLASH_TYPE, size);
> +	if (ret) {
> +		pr_err("Failed to alloc item: SMEM_BOOT_FLASH_TYPE (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	fltype = (u32 *)smem_get(smem, -1, SMEM_BOOT_FLASH_TYPE, &size);
> +	if (!fltype) {
> +		pr_err("Failed to get item: SMEM_BOOT_FLASH_TYPE\n");
> +		return -ENOENT;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_MMC)) {
> +		*fltype = SMEM_BOOT_MMC_FLASH;
> +		return 0;
> +	}
> +
> +	pr_err("Boot medium not specified\n");
> +
> +	return -ENOENT;
> +}
> +#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> +
>   /**
>    * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
>    * @if_tbl:	Pointer to the QCLIB interface table.
> @@ -328,6 +375,30 @@ int qclib_post_process_from_spl(void)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_SPL_SMEM)
> +/**
> + * spl_board_prepare_for_boot() - Prepare board for boot
> + *
> + * This function is called by SPL before jumping to the next stage.
> + * It populates SMEM during coldboot.
> + */
> +void spl_board_prepare_for_boot(void)
> +{
> +	int ret;
> +
> +	/*
> +	 * Populate SMEM in coldboot (Dload bit not set)
> +	 */
> +	if (!QCOM_SPL_IS_DLOAD_BIT_SET) {
> +		ret = qcom_spl_populate_smem(NULL);
> +		if (ret) {
> +			pr_err("Failed to populate SMEM (%d)\n", ret);
> +			qcom_spl_error_handler(NULL);
> +		}
> +	}
> +}
> +#endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> +
>   /**
>    * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
>    * @offset:	Offset (unused, typically 0 for SPL).
> @@ -396,7 +467,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
>   
>   /**
>    * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
> - * @boot_device:Type of boot device.
> + * @boot_device: Type of boot device.
>    *
>    * Return: 0 on success, or a negative error code on failure.
>    */
> diff --git a/include/smem.h b/include/smem.h
> index b19c534ebc4..f16ba7d63dc 100644
> --- a/include/smem.h
> +++ b/include/smem.h
> @@ -87,4 +87,7 @@ void *smem_get(struct udevice *dev, unsigned int host, unsigned int item, size_t
>    */
>   int smem_get_free_space(struct udevice *dev, unsigned int host);
>   
> +#define SMEM_BOOT_FLASH_TYPE			498
> +#define SMEM_BOOT_MMC_FLASH			5
> +
>   #endif /* _smem_h_ */
