Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF98C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BD284979;
	Tue, 30 Jun 2026 14:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rFS4N4ss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F154B84A4B; Tue, 30 Jun 2026 12:47:51 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4FE84A1F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 12:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4939a809b24so28189995e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782816469; x=1783421269; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+tr0ePkUXBNT9rY9nqYcOvgob/lHLouGyU37TqhJGBI=;
 b=rFS4N4ss4UzN7bQdEyJpo2BoDoVLssPBfOlmsT6AeaZAM9aJi2lwI7/7TjlgLBXLRs
 41ec0W9HiYkR/CBOzAaajhW2YPWReE12mHc8XURkWeCFwJmrOOsaCyQQqs6crqXPzyOY
 fnnhzs30BbMnbqte6BVYs/DFvtfmWRYbWWcRYN0lLsaYVCO6AWlxPS43Ej7AcJ9olYN2
 DfVmT0pzzg9rxVe6tvg4yy37fLZoPBW07we8H0uJbVykw81vQXVqkxiUpAFb9ZB/bsid
 iILjpAu39+3D5gCTTYY4P2wjxPOLpxzs2DvZ/FJMEgroFO17QKYsWYuYN8TZP9v68pTY
 E4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816469; x=1783421269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tr0ePkUXBNT9rY9nqYcOvgob/lHLouGyU37TqhJGBI=;
 b=DvljihIsmITv24B5qs2YGeqwmsb2PCc4Ovu8Mu2NYmBmKgFeahnGsnqbgClohoiaKZ
 80KHnuDNl5QhIAekif+HNPPg4k2Jq/5gCLIVfP2TpovE39wk9O9My4chd2NqXN7/OvQ7
 ksqwXwq+Drm6opSifNLgBG9RBY1e2Tzv5y/MpgH0KpKUk5j0S7YTYTcWrSOaknWpkNRn
 WdNlxhmcOqoF0XQzAEkj2kbMw1i5DzjO7nreQE09phjQX8TvEujq/A5VKPyB93IQDD4O
 Tpzup83oJ8M5UEslgDidn5Nr4a4mAZ/64qemfpRe1Z4t9p79xHQ5ex7GtuO8S9DpTaHZ
 ipFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8u76u7ghXy8Sr2CuvQFjc43iKcpaY0WgAaEDbvGNSPgJz5rDbHvTogEhFzGEgnBTmCTTQSLjg=@lists.denx.de
X-Gm-Message-State: AOJu0YyN9X2TleOcMBg22utg0inwgGgr45pwUSoEDOemrwRGa8s19EDF
 ubyM/qcfA2WbBzypP0sGj9OiJ/JGLrbMePwgIZdpZIuuhhwoSPxZlIfKUFahdafspcc=
X-Gm-Gg: AfdE7clK5ZjkNYqMaVrLtTbDX0m2oFIM6+xNuUfWEkyK9nbDYZlTwPoWeOPZkw1GVwS
 x0z+AzeylQkLYZVAhJ9hahPyVKTORA0G0O4eyQysTyiRYGGvT0hK0KSdHHtL0hYOoUnSDX0Eoas
 rsMWhw649JPnjfNt0NUqY2JySY/PEV+rr+8ORBtc4i3COKtnVF2h0CZUxR9yyIlX10Uoor9BWLU
 4CxlP34eaI8iZxtc/0MxWb0NnnqSKQjVoBJqNq+ItYDVSfJ/g2Q7ndZZdycgUSoCgGVW5+dS9fZ
 IptHT44YnhxWgVeo6+ydN/M4gH+rRLEhZCsSfwR42ANAHQU3muKB0EaNtnsEStoWXFQGZ3tdgMw
 /2ofjJwr8nJINsJPnSLfunT6Hj7JS3/MlISuyUncZ66LqnP7jTXTd6UVkgt4yg84r2i8d/eUuoF
 kuUFlPY5KKAi2IOHCsx6UiyotmHsQ=
X-Received: by 2002:a05:600c:1d0a:b0:492:40e2:358d with SMTP id
 5b1f17b1804b1-493bda7173fmr855335e9.16.1782816469002; 
 Tue, 30 Jun 2026 03:47:49 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0496csm53573195e9.10.2026.06.30.03.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 03:47:48 -0700 (PDT)
Message-ID: <0299e3ad-ae16-4e99-8b02-4c0ffc6ee14f@linaro.org>
Date: Tue, 30 Jun 2026 12:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] mach-snapdragon: Add PBL shared data defines
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
 <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
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



On 6/23/26 08:47, Varadarajan Narayanan wrote:
> Add structure and enum definitions to be able to parse the information
> that is passed from PBL. This will be used to identify the boot medium.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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

Remove these old compiler hacks, you don't even use the enum type in the 
pbl_shared_data_entry struct

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

