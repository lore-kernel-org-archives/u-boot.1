Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93CACF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17BA88C3E;
	Sat, 21 Sep 2024 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927526;
	bh=mySie2SNPmWWAW+ToD/wBS/AunWG09U9bBWMV3dUc6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s48PtYsJkcryRoydKIlsEDwEC1BdaJj5I1j4GQgJehL2EjABIqQjxZvh+/nnq7jw9
	 4uzYyL45FNmfStwOpz9OWtxDrL16B2YRsHPUW6e3noUERaNwsox9ia/T2+aEv/gqG7
	 IwdjSzOZsQ71e5N28zqSrwpT7PnvjAPTF9u5uPV3+W2Oc2/TbapbhdEUqjsczlggGy
	 eaTGdjfG84Od0MykzqAdTYUq2VXf+TMojsYt0aZEpSbFb6QG7Wfqc+0XajGBIwY5zL
	 MF8pgbrRv2hldOFiHqDz3o1WhaETeuq9pwK01OPNuDaEM6xicFkEvrdJufrFOvp/ZW
	 vyq3/Al1OVIJg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 30B6388B1A;
 Sat, 21 Sep 2024 16:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927522;
 bh=mySie2SNPmWWAW+ToD/wBS/AunWG09U9bBWMV3dUc6I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=agQGr+2K5nuLj8seQwbq/pLjxoJ40Z8Hj6XhkevbH6e/Ao9zB2wEj+HRtxmax02Z7
 zeEAbMxtByhFAxxA8ehpWjWeOPhxNs4XDQlw92KxYoLnieTmeiWsRuy7Ce7IuLMilD
 1Di1nU1iMRmLPgizUdM5ZKV/pHP2fZsi1Z8Tc+bQ953tEAgi8ju14SI6a2Si3GBdDD
 LqAJCYxdsyTFeQhNGNuLZqpGZv0q14PHREE0vPcZUN5rLv2aLMtjcdL9fwRK6rcAR3
 aDBSVn24JTURFCJ8qukBu//F/lQCnMWz4IY7vP2K9ckaC+X8LRFEGOK9sAOM4uvMDZ
 ocJGldWQFe/FQ==
Message-ID: <e25d4ca8-16cc-4309-8814-ca4437ee86fc@denx.de>
Date: Sat, 21 Sep 2024 15:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/20] arm: socfpga: Export board ID as U-Boot
 environment variable
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-14-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-14-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Board ID is exported as environment variable for use to boot Linux with FIT
> configuration.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>   arch/arm/mach-socfpga/include/mach/misc.h | 1 +
>   arch/arm/mach-socfpga/misc_soc64.c        | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/include/mach/misc.h b/arch/arm/mach-socfpga/include/mach/misc.h
> index 8460acb00d9..e62bea017b0 100644
> --- a/arch/arm/mach-socfpga/include/mach/misc.h
> +++ b/arch/arm/mach-socfpga/include/mach/misc.h
> @@ -52,5 +52,6 @@ void set_regular_boot(unsigned int status);
>   void socfpga_pl310_clear(void);
>   void socfpga_get_managers_addr(void);
>   int qspi_flash_software_reset(void);
> +u8 socfpga_get_board_id(void);
>   
>   #endif /* _SOCFPGA_MISC_H_ */
> diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
> index 95e1c07e39f..e34c54518a3 100644
> --- a/arch/arm/mach-socfpga/misc_soc64.c
> +++ b/arch/arm/mach-socfpga/misc_soc64.c
> @@ -60,10 +60,15 @@ int print_cpuinfo(void)
>   int arch_misc_init(void)
>   {
>   	char qspi_string[13];
> +	char id[3];
>   
>   	sprintf(qspi_string, "<0x%08x>", cm_get_qspi_controller_clk_hz());
>   	env_set("qspi_clock", qspi_string);
>   
> +	/* Export board_id as environment variable */
> +	sprintf(id, "%u", socfpga_get_board_id());
> +	env_set("board_id", id);
env_set_ulong()
