Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA85CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 22:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C9E88ABF;
	Mon,  7 Oct 2024 00:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728253727;
	bh=bssUfIRKxBBRenpyHu9OZbMJWyPhX98G5rpKEyEwPc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npep/HuKHWyFoD/Yyd4sHLXGpI4uCw5EU44+fX4M4DEFbMVG7AsI2s87HjFDbnx0p
	 bZ4GjNBk5QTDAMOYMRtoD/SmA46XIBOCj0upABClQUmwdh8SkwcJWIQJLQanzOTa/q
	 13TXDOsQeykY4YK2C/aNPvkTeMpE+9mQNM244iNougi5jvXEurYZcahqnCXExA78R/
	 Lcl4wPtxkvfnjbNWgo3TJxfgTiwuIBgJjMijlVOquO+3eNqEYBzvtBjG8EKBV4fQE4
	 wESSjhH0zV+sHMU0lxUk3IA79r/8FTeVOtzE9We+Ortc6NW7++z9MiIKzbng9CcWHu
	 upG/eSKRYscjg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5F7A788AB2;
 Mon,  7 Oct 2024 00:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728253726;
 bh=bssUfIRKxBBRenpyHu9OZbMJWyPhX98G5rpKEyEwPc4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HMgrX+j2rySPEJPckpeXC+pEyRcNk/jNK9QnCNEug26hPu41BGzuUyOzTnV40qR2y
 rX6ouh1qcukmtAaJX4b/00sXsyM62K+PD2LN3zvJnpJwzb5opaYUwSUUn1wSVkKC9o
 KyiRkJDBDNCeh6wwN8TsEx/Y5HySvLX1ouDYXrvVfpkC+29vdX9GYjVPd2ArhE6bjn
 eM0E1QBEksFXZo79RW5O5CWbDIJrfxPB9hQUTrG0tQ8YZekKxiYEuhP2oKDK3bbnsB
 9VUr2IWQhlv3xjQ/ss/a5p0RROJYC4e6AQcBIiT2JSRO+ILn0J4NFrjwmJi55MwahU
 AJ4/CsgQKPGbg==
Message-ID: <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
Date: Mon, 7 Oct 2024 00:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
To: Tom Rini <trini@konsulko.com>, alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, peng.fan@nxp.com, fedor.ross@ifm.com, ye.li@nxp.com,
 seanga2@gmail.com, Alice Guo <alice.guo@nxp.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241006212332.GQ4737@bill-the-cat>
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

On 10/6/24 11:23 PM, Tom Rini wrote:
> On Sun, Oct 06, 2024 at 07:31:16AM +0800, alice.guo@oss.nxp.com wrote:
> 
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>> Reviewed-by: Ye Li <ye.li@nxp.com>
>> ---
>>   arch/arm/mach-imx/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index 134e42028c..9d3aafd2f8 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
>>   	  the ddrmc_cr_setting on relevant board file.
>>   
>>   config IMX8_ROMAPI
>> -	def_bool y
>> +	bool "Enable i.MX ROMAPI"
>> +	default y
>>   	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> 
> Since there's no help here, is this truly configurable, or is this
> something that should be select'd based on the SoC and presumably some
> of the newer IMX9 parts cannot use this?
I can imagine the MX95 calls into this custom ELE firmware stuff instead 
of ROMAPI ?
