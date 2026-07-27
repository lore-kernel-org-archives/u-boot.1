Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13720C53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1120580DEC;
	Mon, 27 Jul 2026 12:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1SGwZsO0Lob; Mon, 27 Jul 2026 12:45:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED0F280DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785156357;
	bh=QRd8AcYcWlRyMs3YVRBXfimLqNRg2BSTgkdi7feDX1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZRt5u2oxyWKBXmuSCMiNpnlm1iIe4j9kGtOApYB2gRGan5cVJbq5YDUDL4JBNyrJO
	 oAbtTe6dd68P5UCjrb5smmC60V4ioo5MqBjSF1Rxfa2H2ZxGXJUh/J5UTogea+KxVR
	 ZguRqQXSUQv/cl+OsLCIZyz9wyIdO5eAe0UWY4KbINX5r0CnFiKsYLRc6ZeGnhImEK
	 U2XJ/cfzyIdQRFXP7E7ANwRgADwZLrPxjziD/47yQ4G+b5FQQThK4cGC7r/qkGX8nG
	 6T4ZfADAj3iOD2NpxEAKA6h1lLZOMdWhloAeVGdr0JB4SBnHrKa+7c/lrnnp74IMUZ
	 yqTqG/RkJFuOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED0F280DE3;
	Mon, 27 Jul 2026 12:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1B7D4C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2C1B40693
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1JDawVLrp0U for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:45:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2D5540689
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2D5540689
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2D5540689
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:45:53 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so20146135e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 05:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156352; x=1785761152;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QRd8AcYcWlRyMs3YVRBXfimLqNRg2BSTgkdi7feDX1g=;
 b=LYJOHF//p7PQTFe4aBCnsTNZ+DC/tbR/q59fNo272OdHu7e8WTP0hNFQh1q3tiarxk
 omYdebTGea7kYPTpzxgg9dvk3SZwhM42FIhxDRAavyGL+Rvb5u4h7JekILklb3zzxKs+
 krFZFmZH4kAhoN+fC0v3P6FXKu4ZHISgYi54h0b08H9aN1bhWHA+q/1VUxDSG/51vIqY
 1O/BD+L2NbmCD++LNGyMr3btWJ0E0mVH5O7fC5V3JRXHtifDbo/27BkiwQmUzK2QBa7W
 /7T6WxBDKUILoVaX1sMrId1BzyTkEMPs4sf11qHB5HR5u++JM2fBaxQFanSvx3dcUKXx
 iJ1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRSJsY19y41IwasBtbT1I2JfxhaO1hNJOwpjn/T53fRXeg/x+LEMZnZWIG59XvhUAvcZtCTG8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy8GfnjZrESwWHu2fMD6LoA2LMnSQCVFavRm7Y5GO+ZZM6J2POt
 7qQN1OKWNkXo/7odfqSpml8eGJ8L9KZC7s8adL9mQ7OfX2PCIithOvJOKEmxIp9jY6o=
X-Gm-Gg: AR+sD108kUFvLpnrQtkYvnqYCkhsfHw1ZSpAkfYHeXQbDV0/1hH5a2HwdpJQp7zamu1
 qPSdvHVBXVicpfF7xxH1pHirW24AEAkHavb6CjzKTDy7UFvflI5uY8zQiRROboMmntL51t0peZr
 bXgfQB19EJl27TovgmptK/rTFxYHQqP9TbYfmLKwUSVAe7ETmOmEk5AAl1H133Xm8331+g3c5MD
 FMo6K/ou1ngyJWlVZS97zUvuDSRSwhLTwp/SUMwaapkT1dgSYhQyqYYhHNJzSdnQG7vLtTHlQQP
 zpPQtNiZL1Z4xDPPg8yknKhk2h2Z6AnQOlXNIfnkLQiOZRP4D3qf4RDHoI8gJeRK34Y46CCui2o
 V73B3VHNB0s/tcM+hsg5dw0AnQ1rEjQJ1UDm+oJ35ywJ9bkH+vO+YKm8tuWHuTEM8sW7tBaDCqv
 JoZ1l/Ktu9y04jZ6oBGTa4/FbQNsAOS5I4+9YAb1f7rg==
X-Received: by 2002:a05:600c:8b47:b0:493:f176:dc69 with SMTP id
 5b1f17b1804b1-496b572e886mr119181215e9.37.1785156351402; 
 Mon, 27 Jul 2026 05:45:51 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee1d31sm239675455e9.5.2026.07.27.05.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 05:45:50 -0700 (PDT)
Message-ID: <4130d9f0-c06c-46bd-8e74-0eb64d221a32@linaro.org>
Date: Mon, 27 Jul 2026 14:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] mach-snapdragon: Add PBL shared data defines
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>, Anshul Dalal <anshuld@ti.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>, Jens Reidel
 <adrian@mainlining.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-2-cbfa79e85a9d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260722-spl-v8-v8-2-cbfa79e85a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785156352; x=1785761152;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QRd8AcYcWlRyMs3YVRBXfimLqNRg2BSTgkdi7feDX1g=;
 b=IM/8EJ0Ln97oFaYC/cfY1ZsNSoQqZld4mpsqEXsjJnX5hfWwf3gS6TUtfa07X8/5Mh
 z4Fi4qtyzC3HCMshFDENKiihcFWvYdClBl/a1pCcp0VnV4AYhGG4w3llp8/ovkRpRJIa
 cSb3yjjO8vI/w0DQhYANy+/vm7E12prDLm7E6YW1cDPgdHVN+lp4NjdWRVIbdIZuZkCK
 6peppS6HPbRncHWTr2G/jS0SjoRBL7ePDillzarfBikrU2e+b8N0FuO5L2g9JMjZZNm+
 t7sagBGZt3T511f06Gj4UgkLV8qNlsUVYZSklFCR2OYet6pm71gHsqOi8QWqQE+ZPMRV
 neTg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IM/8EJ0L
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Varadarajan,

On 22/07/2026 09:41, Varadarajan Narayanan wrote:
> Add structure and enum definitions to be able to parse the information
> that is passed from PBL. This will be used to identify the boot medium.

Please add some version identifier here, or at least a comment
indicating roughly which SoC families/generations this will work on. As
I understand it older SoCs used a different layout here, and it may
change in the future too.

An enum describing the version field in the header would be ideal.

This is a case where I would very much like to see a sensible
abstraction around this data structure maybe in its own file so that we
can gracefully handle additions and changes to the PBL layout.

To that end, I think it would make sense to have these definitions be
private with an API exposed instead so we don't leak these
implementation details everywhere.

Thanks,
// Casey

> 
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/include/mach/pbl.h | 57 +++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/include/mach/pbl.h b/arch/arm/mach-snapdragon/include/mach/pbl.h
> new file mode 100644
> index 00000000000..2e6ad13255c
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/include/mach/pbl.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
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
> 

-- 
// Casey (she/her)

