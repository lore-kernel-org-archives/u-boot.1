Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F071C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 13:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFCF84866;
	Sun, 28 Jun 2026 15:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFLp0iRP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgVzuuth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D67C84105; Sun, 28 Jun 2026 15:09:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE2088056B
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 15:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65S9PU7J3597391
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4tIkJm1J9lTQDuApxb36WOO6X4di1bjOaiL1z75a9xc=; b=eFLp0iRPcrN2ubq8
 t4TmG/HnK0u1qIj6AVdMltkZUmDGCybDl5KehIRt4oBGSfh7+8aGDKu6ouJ+O3C1
 bk2jPasIPQtrLxuXsz3DdeRkEA7EMXnoQBYMo6e2AcDDb43ME17nYewFZV4e64Z6
 9AtcbIAr+hoO/07TbmKtHdrnO+uYaCuEcvCfDo3W5HzPgS6hFqADY9K88XkQ/5Ph
 Vh7Lm+QpAx0LiokThMH/TGpuv4Pma/xyGKTtDQLtgHtAEl2rQoTpj3jDjEOR6I7n
 43Sm7f1EtzKqcEgkLaBRUBiusfZkGgF+h6GLeNyHJNqwLZYEqdauf8Av/PI+AkWN
 vbfisw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27332wvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 13:09:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30e85f5bc9eso3612383eec.1
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782652141; x=1783256941; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4tIkJm1J9lTQDuApxb36WOO6X4di1bjOaiL1z75a9xc=;
 b=AgVzuuthIAkp9aXTOIyD0PrYirfbJz3I4M8PNQERbq9Xy+bGBwTXFce+I4O2KI3+OK
 RiTSentE3y6aGZMaGZR4w4Q+7N7ZiGx9owDUDggSTJ42lkeqjYeyTQcTHnuEPfqnO1EH
 KLs+uctqQlZQzWhoLHXUCT0K18Fq6TfIvROSiNofnomPZDIN+b2HssRFCrIiyywZGD0O
 iZgimmA/si56ludVonPZqm+eCF9kyMARoIU9B4i3htT6GKgVbNLN4fKXQhDtfOfPj/LO
 NshVXNuA6mwZLHbQTUQ8/iM0bp6DYuWdv7TgEAemvKqYdKF5d3i2aI8vITSBW+g8hyYw
 Zz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782652141; x=1783256941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4tIkJm1J9lTQDuApxb36WOO6X4di1bjOaiL1z75a9xc=;
 b=egvwNQCtXqHAcV4MYdatb5VB5KP9ElNIozMea9V9aKHnyVmrHBytI0sur4OzcoMFks
 2xxCQQCroKcNVrcf9HZdNhWS8BBcPGMgKzQjwS9BK2IZsuVg+9SGNdSX+UPvkrL11/ND
 5i3O7fxFNTIhdj3M32SDuYkdjiVPiInd9CNiLiYPXJxzYzeJn5NlZyqxqnZgyV/B4Prb
 QVDAzNrdtTn+HcrsdWurGFPXw7p/oaDaVv0YPgUZiRBSQZ0ZXUVRXOXQ6hWzEQFSaZP1
 M7Erj0ZzyiHgzhWB4TF3lo6C6MZJMtMJxVPpnsk8zKDeHHq3wPGzcaUBmg3t1ydEBNO8
 YKZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlMZFKX/XgYtlaXhdONAIh72Y8w6NffM1Iva3tXa7y5xTy51DdJlBt+iSmAXibYUdfyQC9GUY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+kJybn84x24ZKrlABOLv5Pu7zfmeavVKg1AxUbLuNJfZBnN6+
 IyTzeB3ETeS8tew22v8hi766yq2w26vk25zN8MA4DUHtoNzI7OaU8mGA2D2KAM4w/icPIMWAxvh
 /odBr/vEZI2Js5JWuoQN7TRh6W2XAgXeZ0saDLCfhhkEQgQyO6caKrV0/
X-Gm-Gg: AfdE7cl6EFTqz3DnyI5ErKpvpKP3SLZtCirvTCUwr88Rct1lk5XlduowLMFd+JssY9l
 72LHXCUXtHyy+x25n3IixvaFlMhD2PxhJ/+OkKISmCxte9TfdLp+awQ8sJnbHVAZUGMPPKCDLIp
 /ep6nJ1ZRZ+tkEN+ZVrUUlJIKgjZxywge687Bb4VNwjDvUEccKSXa+1BfajReWJo/jAvVOCcSEx
 u7jCDTsMvzxil0iB4eaKfeDdZXJylaLsJasnvvxteeiNgwzLefYhTAz0muFNixRF2XC+kyHQHOb
 2O8/oeS0aB7JahTnEAQ9cDmO90BB933GvQfV01+YsMLfqkEcfF8rtRn5FQmkRSW3pp6Jn3HVSbh
 blsWQf1b6BQ9RktqXnAIjlfGF2NN+7Bavo6c+yDw4Cbdki9Q=
X-Received: by 2002:a05:693c:66d7:20b0:30c:ab97:d7b2 with SMTP id
 5a478bee46e88-30cab97dc47mr4457340eec.44.1782652141076; 
 Sun, 28 Jun 2026 06:09:01 -0700 (PDT)
X-Received: by 2002:a05:693c:66d7:20b0:30c:ab97:d7b2 with SMTP id
 5a478bee46e88-30cab97dc47mr4457299eec.44.1782652140547; 
 Sun, 28 Jun 2026 06:09:00 -0700 (PDT)
Received: from [192.168.0.5] ([49.206.99.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm42585596eec.16.2026.06.28.06.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 06:09:00 -0700 (PDT)
Message-ID: <9e39ae70-4d57-4dfd-9785-141a54f2325f@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 18:38:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] mach-snapdragon: Add PBL shared data defines
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
 <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a411cee cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=8fNwSSZIJDewi4B+fYJmHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=aPy4u0QKlrczO_6kgjkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: Fi5Ra7BNZu81-7Qt3yabmpQtjeBRsSLS
X-Proofpoint-ORIG-GUID: Fi5Ra7BNZu81-7Qt3yabmpQtjeBRsSLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX7hjrfKE8PPJT
 kLyewxWA1MWauvpICYJ3pbgrOI1FrXk+04cSSwzsx8UpyarzWq8fEGIuPCIWuKyMus0hhCZY4W0
 jKwF7Mrj/5VsHj94SfiXV8s3ubqUcMhVxXKCxXBwHkGwPADVlExEDQFnPSbLEBaauOqcaWTVaGK
 6rmt7bsGbFH69GN12bbJv104/X5LwZvjbAoMnplc5cGVkK73pzJuHNVBj7XqHIzUQwy/s02TfnO
 ikLSb3CC6cGojxF9djKY/ChCtWXuYboUX9+vtQeVUzMIXFakKEPph+xUOzCXsSxjFaDh+SB6qrh
 mihhzPKj0+i8eGjusAzDfPPWpCCXVxGuuohfarr+oZLPmB4Ng9CC7S9uR7uZpBs907V3MUZDidx
 Y1wknPVmqS/5MH9Mc4Un4pGB1c6qFKGpTBrP1AO7scpYvkzkpKet0DH3w3q284sgD0nEgQ06B0B
 sqUGBWCxlIVcynQQGoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDExNiBTYWx0ZWRfX8CMN2yqB+Hy8
 nVCjZkyVYjkHghpV+tpXj6DNvjFvzxheg+d19HxIJPGJaxxpgngHtIfTGxtsAPSsYyl585nuXc3
 zNUf90OzJHpFVLX+igts/nOAPvYLbUY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
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
> Add structure and enum definitions to be able to parse the information
> that is passed from PBL. This will be used to identify the boot medium.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Regards,

Balaji

> ---
> v5: Move PBL shared data related defines from qcom-priv.h to pbl.h
>      so that it can be shared in arch/arm/mach-snapdragon and board/qualcomm
>      directories
> ---
>   arch/arm/mach-snapdragon/include/mach/pbl.h | 58 +++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644 arch/arm/mach-snapdragon/include/mach/pbl.h
>
> diff --git a/arch/arm/mach-snapdragon/include/mach/pbl.h b/arch/arm/mach-snapdragon/include/mach/pbl.h
> new file mode 100644
> index 00000000000..94f845d070b
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/include/mach/pbl.h
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __PBL_H__
> +#define __PBL_H__
> +
> +enum pbl_shared_data_param_id {
> +	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
> +	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
> +	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
> +	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
> +	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
> +	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
> +	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
> +	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
> +	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
> +	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
> +	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
> +	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
> +	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
> +	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
> +	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
> +	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
> +	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
> +	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
> +	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
> +	PBL_SHARED_DATA_PARAM_MAX,
> +	PBL_SHARED_DATA_PARAM_SIZE	= 0xffffffffu, /* to force 32 bits */
> +};
> +
> +enum pbl_boot_flash_type {
> +	PSD_NO_FLASH		= 0,
> +	PSD_NOR_FLASH		= 1,
> +	PSD_NAND_FLASH		= 2,
> +	PSD_ONENAND_FLASH	= 3,
> +	PSD_SDC_FLASH		= 4,
> +	PSD_MMC_FLASH		= 5,
> +	PSD_SPI_FLASH		= 6,
> +	PSD_PCIE_FLASH		= 7,
> +	PSD_UFS_FLASH		= 8,
> +	PSD_RSVD_1_FLASH	= 9,
> +	PSD_USB_FLASH		= 10,
> +	PSD_SPI_NAND_FLASH	= 11,
> +	PSD_SPI_FLASH_GPT	= 12,
> +};
> +
> +struct pbl_shared_data_entry {
> +	u32 param_id;
> +	ulong value;
> +	bool valid;
> +};
> +
> +struct pbl_shared_data {
> +	u32 version;
> +	u32 num_of_entries;
> +	struct pbl_shared_data_entry entry[PBL_SHARED_DATA_PARAM_MAX];
> +};
> +
> +#endif /* __PBL_H__ */
