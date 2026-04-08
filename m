Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBCC1073CAE
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C8684209;
	Wed,  8 Apr 2026 14:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cWYU3YvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D040080433; Wed,  8 Apr 2026 11:27:00 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8197C840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso56291365e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775640418; x=1776245218; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=deVcJHLsHapktj5FmsPdX8AO3hgWHQjR7zonmtcKXBg=;
 b=cWYU3YvX9BIweNfTDH4okiz9DQfWSv9R/EAYRjjCB0BFoMwjx2WUy1QF8kchVVA+Jq
 Dv1PRh7P+LjpkgIBj6+sFy8iHFxaGbwDCJjSrLA7JEwjfJpmk2PRwEwxERqrGJiBvLow
 RhVGhdc+oI3NztkNb6B6Z2S3Th6ySXXHcl6RieLQFoWmXRs/C+dStJY/ARXviYAzYw6p
 saxuI1sZwJxe3w1mix5Kvo2KibrKjT3hMqERuxV6cqwxlQMa68hUYStsxqYZKcGr5Uit
 vCbeWKfbpB+LfSivLU340/0p8L9YmQG2Z5d7vD4od3ecrEVdLZJdRJcXha/YNq3wqWHm
 7Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775640418; x=1776245218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=deVcJHLsHapktj5FmsPdX8AO3hgWHQjR7zonmtcKXBg=;
 b=Amw14eQDzYUopIZYCYMFKhjr++RvgfI5PTnyZvY3CegGzLpdYZ+cVAuZ5Pr6VqS56n
 hwoiT8VV6/r+9H6F7Jjkp+Wwc6oFza91qC55uxi8s1S+CY3E6lOD31klrPv2djJWbsVg
 ehTfQ5LW4KYiB6Y5rBfcZAn6pX7tTMti8Uan4kxRnCMmQSpbclV5ZYkyBcBeS8zdDlRx
 D3LUEyxIJOAaTJFLonhbvyjryPFaMe7O0tKB+Vc03K5VA7Jy0xwShZtBP9N6Nbb/gqgr
 pKJPmzHfkBvWkhIsxj+zPbr4GdjRL0C3JG/bJuTdXE/3rMV1zbZIcnr8Nf9NxZ51ji2x
 wW7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3qSOa7kS5VhUg35g63Ms0lPyzub0/VrxPDs1M3oMSHk49iQSYL2cU13fCwLD02ArRLX5Ss60=@lists.denx.de
X-Gm-Message-State: AOJu0Ywciyo4us9w5BF7zGL0qRJyIyz3QyarKlI8pfHX/vlEe/d+LPIK
 Ux17EgcaN6e9hkZEEsMilfMYn/+uV5DhBhVL7fxlEJpERNva6ngN3g+ASZe+S3mZUIY=
X-Gm-Gg: AeBDiesnLLoGRCYKUt/k383wtMLNms4Ku9NlR3ZhYcLQ22XREH9kYf9Ijmgi3rmC9ei
 n4oHu9ErKbkR3UBxKplQ3mFeJGSoFrvBt2tgD769AWPvZPPdcYyXeKqpeDc7iortd4NEVDc42nl
 +Et1TorKoCbJUNIo3YDT0SNd+bY7gAd7OxLZcmwlbal6R4BFJojkX5TzVJofWO1sXIkVh5zwTDc
 nXpUMgm1gFPFo1IY0zXfOre43ZP0xwjMYpw8WI12Su6PMGQGq0XdyIaK9l5EH8hCxrer5RR+pVf
 wl8q1weyvETqG2xZu0jIWJIJhDoPbNXEZin0xaeao7WB6ZRIobwwYRmTB+ZyeXd945kuU5Xt5To
 i3LdimLkDKsQkwoh3kZD6G91GfdFiFzh0PXj0a8T8slAH7qGhWx86Jvx65fALzmZWJ5E7dihKyE
 HUrNWfnVL4IHuRihnbQ1F9x7/Tvd+iwpKHnl/bQMql5xssnkF9jB2hj5ECJz6LAmv/p/hbg1T3L
 e5H
X-Received: by 2002:a05:600c:81e:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488a82fbcc5mr109420665e9.30.1775640417783; 
 Wed, 08 Apr 2026 02:26:57 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48895e19c10sm415156355e9.8.2026.04.08.02.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 02:26:57 -0700 (PDT)
Message-ID: <2f19cd1b-b1ff-4053-8507-675f5bd02133@linaro.org>
Date: Wed, 8 Apr 2026 11:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] misc: qcom_geni: Add minicore support
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, anshuld@ti.com,
 tingting.meng@altera.com, alif.zakuan.yuslaimi@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, afd@ti.com,
 andre.przywara@arm.com, h-salunke@ti.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com, malysagreg@gmail.com,
 richard.genoud@bootlin.com, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260408091136.2794546-6-varadarajan.narayanan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260408091136.2794546-6-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

On 08/04/2026 11:11, Varadarajan Narayanan wrote:
> The qcom_geni driver reads an ELF from storage and configures a set of
> registers and programs the firmware to the GENI Serial Engine (GENI-SE)
> wrapper device for the expected functionality.
> 
> Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
> wrapper is pre-configured for one of the functions defined in 'enum
> geni_se_protocol_type'. Hence, the firmware download is not needed.
> Only the register configuration part is needed.

I don't think we should be embedding this ~1kb of data for just these
platforms.

Please move these to a separate file gated behind some new kconfig option.

> 
> Earlier, the boot stages before U-Boot would configure the GENI-SE (to
> access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
> (i.e. boot ROM) doesn't do that modify the driver to do the register
> configuration part alone without reading an ELF from the storage.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/misc/qcom_geni.c       | 168 ++++++++++++++++++++++++++++++---
>  include/soc/qcom/geni-se.h     |   5 +
>  include/soc/qcom/qup-fw-load.h |  15 +++
>  3 files changed, 175 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..d02ea804c33 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -34,6 +34,102 @@ struct qup_se_rsc {
>  
>  struct geni_se_plat {
>  	bool need_firmware_load;
> +	bool is_mini_core;
> +};
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
> +static struct qup_mini_core_info qup_mini_cores[] = {
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
>  };
>  
>  /**
> @@ -163,16 +259,38 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
>  		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
>  }
>  
> -static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
> +static int load_se_firmware(struct qup_se_rsc *rsc, int elf, void *info)

Please make this a "bool", if you're using clangd or ctags there might
be a configuration issue if they're suggesting that "bool" isn't a valid
type (I've had to deal with that in the past).

>  {
> +	struct elf_se_hdr *hdr, tmp_hdr;
>  	const u32 *fw_val_arr, *cfg_val_arr;
>  	const u8 *cfg_idx_arr;
>  	u32 i, reg_value, mask, ramn_cnt;
>  	int ret;
>  
> -	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
> -	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
> -	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
> +	if (elf) {
> +		hdr = info;
> +		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
> +		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
> +		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
> +	} else {

Please add a comment here briefly explaining that this is for minicore
controllers which don't need the whole firmware.

> +		struct qup_mini_core_info *qmc = info;
> +
> +		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
> +			if (qmc->serial_protocol == rsc->protocol)
> +				break;
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
> +	}
>  
>  	geni_config_common_control(rsc);
>  
> @@ -350,8 +468,8 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>  {
>  	struct qup_se_rsc rsc;
>  	struct elf_se_hdr *hdr;
> -	int ret;
> -	void *fw;
> +	int ret, elf;
> +	void *fw, *info;
>  
>  	rsc.dev = dev;
>  	rsc.base = qup_base;
> @@ -377,15 +495,22 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
>  	/* The firmware blob is the private data of the GENI wrapper (parent) */
>  	fw = dev_get_priv(dev->parent);
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
> +		elf = 1;
> +		info = hdr;
> +	} else {
> +		elf = 0;
> +		info = fw;
>  	}
>  
>  	dev_info(dev, "Loading QUP firmware...\n");
>  
> -	return load_se_firmware(&rsc, hdr);
> +	return load_se_firmware(&rsc, elf, info);
>  }
>  
>  /*
> @@ -414,6 +539,9 @@ static int geni_se_of_to_plat(struct udevice *dev)
>  
>  		if (proto == GENI_SE_INVALID_PROTO)
>  			plat->need_firmware_load = true;
> +
> +		if (readl(res.start + QUPV3_SE_HW_PARAM_2) & GEN_USE_MINICORES)
> +			plat->is_mini_core = true;
>  	}
>  
>  	return 0;
> @@ -473,7 +601,7 @@ static int probe_children_load_firmware(struct udevice *dev)
>  		ret = 0;
>  		/* Find the device for this ofnode, or bind it */
>  		if (device_find_global_by_ofnode(child, &child_dev))
> -			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
> +			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
>  		if (ret) {
>  			/* Skip nodes that don't have drivers */
>  			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
> @@ -492,7 +620,11 @@ static int probe_children_load_firmware(struct udevice *dev)
>   * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
>   * all the peripheral devices that need firmware to be loaded.
>   */
> -static int qcom_geni_fw_initialise(void)
> +#if CONFIG_XPL_BUILD
> +int qcom_geni_fw_initialise(struct udevice *dev)
> +#else
> +int qcom_geni_fw_initialise(void)
> +#endif
>  {
>  	debug("Loading firmware for QCOM GENI SE\n");
>  	struct udevice *geni_wrapper, *blk_dev;
> @@ -520,6 +652,10 @@ static int qcom_geni_fw_initialise(void)
>  
>  	ret = find_qupfw_part(&blk_dev, &part_info);
>  	if (ret) {
> +		if (plat->is_mini_core) {
> +			fw_buf = qup_mini_cores;
> +			goto mini_core;

Why still call find_qupfw_part() in the minicore case? If this is
intentional please add a comment.

> +		}
>  		pr_err("QUP firmware partition not found\n");
>  		return 0;
>  	}
> @@ -544,6 +680,7 @@ static int qcom_geni_fw_initialise(void)
>  		return 0;
>  	}
>  
> +mini_core:
>  	/*
>  	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
>  	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
> @@ -563,7 +700,9 @@ static int qcom_geni_fw_initialise(void)
>  	return 0;
>  }
>  
> +#if !CONFIG_XPL_BUILD
>  EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
> +#endif
>  
>  static const struct udevice_id geni_ids[] = {
>  	{ .compatible = "qcom,geni-se-qup" },
> @@ -577,4 +716,7 @@ U_BOOT_DRIVER(geni_se_qup) = {
>  	.of_to_plat = geni_se_of_to_plat,
>  	.plat_auto = sizeof(struct geni_se_plat),
>  	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +#if CONFIG_XPL_BUILD
> +	.probe = qcom_geni_fw_initialise,
> +#endif
>  };
> diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
> index fc9a8e82cd8..e51dd06fa94 100644
> --- a/include/soc/qcom/geni-se.h
> +++ b/include/soc/qcom/geni-se.h
> @@ -77,6 +77,7 @@ enum geni_se_protocol_type {
>  #define SE_IRQ_EN			0xe1c
>  #define SE_HW_PARAM_0			0xe24
>  #define SE_HW_PARAM_1			0xe28
> +#define SE_HW_PARAM_2			0xe2c
>  #define SE_DMA_GENERAL_CFG		0xe30
>  
>  /* GENI_DFS_IF_CFG fields */
> @@ -248,6 +249,10 @@ enum geni_se_protocol_type {
>  /* SE_HW_PARAM_0 fields */
>  #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
>  #define TX_FIFO_WIDTH_SHFT		24
> +
> +/* SE_HW_PARAM_2 fields */
> +#define GEN_USE_MINICORES		BIT(12)

GENI_USE_MINICORES

Kind regards,

> +
>  /*
>   * For QUP HW Version >= 3.10 Tx fifo depth support is increased
>   * to 256bytes and corresponding bits are 16 to 23
> diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
> index a67a93c72a4..a3ae4122681 100644
> --- a/include/soc/qcom/qup-fw-load.h
> +++ b/include/soc/qcom/qup-fw-load.h
> @@ -14,6 +14,7 @@
>  #define GENI_INIT_CFG_REVISION		0x0
>  #define GENI_S_INIT_CFG_REVISION	0x4
>  #define GENI_FORCE_DEFAULT_REG		0x20
> +#define GENI_OUTPUT_CTRL		0x24
>  #define GENI_CGC_CTRL			0x28
>  #define GENI_CFG_REG0			0x100
>  
> @@ -21,6 +22,9 @@
>  #define RX_FIFO_WIDTH_BIT		24
>  #define RX_FIFO_WIDTH_MASK		0x3F
>  
> +#define QUPV3_SE_HW_PARAM_2		0xe2c
> +#define GEN_USE_MINICORES		BIT(12)
> +
>  /*Same registers as GENI_DMA_MODE_EN*/
>  #define QUPV3_SE_GENI_DMA_MODE_EN	0x258
>  #define GENI_M_IRQ_ENABLE		0x614
> @@ -173,6 +177,17 @@ struct elf_se_hdr {
>  
>  struct udevice;
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
>  int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
>  
>  #endif /* _LINUX_QCOM_QUP_FW_LOAD */

-- 
// Casey (she/her)

