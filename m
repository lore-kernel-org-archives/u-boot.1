Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467BC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 09:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9828C87FDF;
	Tue, 27 Feb 2024 10:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yW5xSeLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AAF87FD6; Tue, 27 Feb 2024 10:41:35 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7E287F51
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 10:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412af574501so1288325e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 01:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709026892; x=1709631692; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YlBfsYhLZq98VpP/vYSe8MR6HasYw7vqzvcaM2SyuEc=;
 b=yW5xSeLPj+Qb/Mbnxevn6WlooS7p9F0zSGKQWKhgc3kbdLotko8Xrmy5+tsH1612pZ
 Bu+TS55SoG9CPHP+Ecp16iwiM+QkdfJOo7yzq1MuFjDzTfmsTkEU7cyzAinhDfSD2ehq
 tF+bAfLQ/IjLAj3wlXE1edZqmmzZJ6ThlmWsOMZUMNHo1VDMCnHhDmqHvQZmn4Ex5h1O
 3Na6Za2pLO/DFw495Bmh2rZwTEP7FSTwKVUD+1mxtKXqxSI/3gA+5ycgvm0zqtFW1J4C
 Zd6YZwJquWMXQvCOQJ6OrwulbW3kzncW+8dpMlLxCY8L7kmb9zDwoxSCdV5z/UYKS4Ad
 c9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709026892; x=1709631692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YlBfsYhLZq98VpP/vYSe8MR6HasYw7vqzvcaM2SyuEc=;
 b=ZUZtyCqL5PhiS75NhF+n0jEctvFEPXAmHwb9Bub9Sf7h2z6F6xJWZG43/Mujb6WG1M
 xMW2fn4phSTgccq7zjAArmCEEcz8872bVl11fyNSksiEQ5qxwMdrUiJpMFlJcaE6YwvF
 5b3tUs2FN5Ssm9dkhzHngkxELFg3Nf6F8llxFkfYzb8rr2blKpbJ9SBdrFvoQbfWmBCi
 OZpG4KlMWmUYTogkWPgzscf19SNJMW0tyJLz1MvmPhl1zq7j2XWBP0nRRuEFpe2Wyt6f
 1RjX+2CDr/fg8DLhRJnVwXl16ZCyskhrOPalO05cvcfmmInw1fzEhDiblPCuF1IwGbct
 fBTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+ScDSHjhKQh5bWp4OMHq95iwALIQ+6gCQlM3eZLC8zlSOGRx3rOI6PHa5/KWnB2ZhlA269xRb7gCzOpPfGaplbXuBw==
X-Gm-Message-State: AOJu0YwKIMDqvVF7VbT2JLos2vVdyC9myXmizu3hRug+sOO6cTB1OvEu
 Zldy+/27aCEt8vks0+rlUnhI36gOLXZFGVx7xcnWyZYuaQu/yB29t4aAHCufnpqNn95pCI18DwO
 W
X-Google-Smtp-Source: AGHT+IG5MOXDs0FSXjNlTMeKROxeSDSxtc5fHsOVpB32z3RxewBbYAIW11qMqx66MzWYVIofQVf5xQ==
X-Received: by 2002:a05:600c:3514:b0:412:ab27:a13f with SMTP id
 h20-20020a05600c351400b00412ab27a13fmr1166782wmq.1.1709026891908; 
 Tue, 27 Feb 2024 01:41:31 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 o25-20020a05600c379900b004129051a8f7sm14191173wmr.41.2024.02.27.01.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 01:41:31 -0800 (PST)
Message-ID: <decfd7de-f07f-435c-9b61-e1af54284150@linaro.org>
Date: Tue, 27 Feb 2024 09:41:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mach-snapdragon: ipq9574: Add SMEM defines needed
 for IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-3-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-3-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 26/02/2024 10:07, Varadarajan Narayanan wrote:
> Add few SMEM related defines that will be used for
> IPQ9574 based boards.

The tiny To/Cc list above is probably because this file isn't mentioned
in MAINTAINERS, please add myself, Neil, and Sumit (see the ARM
SNAPDRAGON section in MAINTAINERS) on the next revision, thanks.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  include/smem.h | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/include/smem.h b/include/smem.h
> index b19c534ebc..f305354996 100644
> --- a/include/smem.h
> +++ b/include/smem.h
> @@ -16,6 +16,84 @@
>  #ifndef _smemh_
>  #define _smemh_
>  
> +enum {
> +	SMEM_SPINLOCK_ARRAY		= 7,
> +	SMEM_AARM_PARTITION_TABLE	= 9,
> +	SMEM_HW_SW_BUILD_ID		= 137,
As I understand it, smem is a bit of a dumping ground of various
different data, some of which is standard across all boards and some is
not... A lot of the values you're adding here seem specific to this
modern set of IPQ-based dev boards. Could you document what each of
these values actually does.
> +	SMEM_USABLE_RAM_PARTITION_TABLE	= 402,
> +	SMEM_POWER_ON_STATUS_INFO	= 403,
> +	SMEM_MACHID_INFO_LOCATION	= 425,
> +	SMEM_IMAGE_VERSION_TABLE	= 469,
> +	SMEM_BOOT_FLASH_TYPE		= 498,
> +	SMEM_BOOT_FLASH_INDEX		= 499,
> +	SMEM_BOOT_FLASH_CHIP_SELECT	= 500,
> +	SMEM_BOOT_FLASH_BLOCK_SIZE	= 501,
> +	SMEM_BOOT_FLASH_DENSITY		= 502,
> +	SMEM_BOOT_DUALPARTINFO		= 503,
> +	SMEM_PARTITION_TABLE_OFFSET	= 504,
> +	SMEM_SPI_FLASH_ADDR_LEN		= 505,
> +	SMEM_FIRST_VALID_TYPE		= SMEM_SPINLOCK_ARRAY,
> +	SMEM_LAST_VALID_TYPE		= SMEM_SPI_FLASH_ADDR_LEN,
> +	SMEM_MAX_SIZE			= SMEM_SPI_FLASH_ADDR_LEN + 1,
> +};
> +
> +enum {
> +	SMEM_BOOT_NO_FLASH		= 0,
Likewise what what smem property do these correspond to?
> +	SMEM_BOOT_NOR_FLASH		= 1,
> +	SMEM_BOOT_NAND_FLASH		= 2,
> +	SMEM_BOOT_ONENAND_FLASH		= 3,
> +	SMEM_BOOT_SDC_FLASH		= 4,
> +	SMEM_BOOT_MMC_FLASH		= 5,
> +	SMEM_BOOT_SPI_FLASH		= 6,
> +	SMEM_BOOT_NORPLUSNAND		= 7,
> +	SMEM_BOOT_NORPLUSEMMC		= 8,
> +	SMEM_BOOT_QSPI_NAND_FLASH	= 11,
> +};
> +
> +#define BUILD_ID_LEN			32
> +#define SOCINFO_VERSION_MAJOR(ver)	(((ver) & 0xffff0000) >> 16)
> +#define SOCINFO_VERSION_MINOR(ver)	((ver) & 0x0000ffff)
> +
> +struct smem_pmic_type {
Please document these structs, and which SMEM property they represent.
> +	unsigned int pmic_model;
> +	unsigned int pmic_die_revision;
> +};
> +
> +struct ipq_platform_v1 {
> +	unsigned int	format;
> +	unsigned int	id;
> +	unsigned int	version;
> +	char		build_id[BUILD_ID_LEN];
> +	unsigned int	raw_id;
> +	unsigned int	raw_version;
> +	unsigned int	hw_platform;
> +	unsigned int	platform_version;
> +	unsigned int	accessory_chip;
> +	unsigned int	hw_platform_subtype;
> +};
> +
> +struct ipq_platform_v2 {
> +	struct ipq_platform_v1	v1;
> +	struct smem_pmic_type	pmic_info[3];
> +	unsigned int		foundry_id;
> +};
> +
> +struct ipq_platform_v3 {
> +	struct ipq_platform_v2	v2;
> +	unsigned int		chip_serial;
> +};
> +
> +union ipq_platform {
> +	struct ipq_platform_v1	v1;
> +	struct ipq_platform_v2	v2;
> +	struct ipq_platform_v3	v3;
> +};
> +
> +struct smem_machid_info {
> +	unsigned int format;
> +	unsigned int machid;
> +};
> +
>  /* struct smem_ops: Operations for the SMEM uclass */
>  struct smem_ops {
>  	/**

-- 
// Caleb (they/them)
