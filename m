Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD69CDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 01:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A85386B67;
	Tue, 17 Oct 2023 03:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697506469;
	bh=MpcGPchvw0f7ty43CUtA/0S6NxoHzbtO7/ilU+T2gaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XHC+0sG/Y3BBBVDxrqfAIYZFkg5ai0GBGAdL7l+zGE0saPHqvOHs/n1Hp5u/x8Vrk
	 Xpwg+D8p8Vg2OBh/o8cr3g8PkWGjOsJjdwVfvDTt5gsPupJcmHS7kIoXCewJ+9QoZa
	 gKH4WEcSTyei0MxJffobVPcdlFbDsq+Fr6bRIYlMOQeJ13Zbg7McqYSVvKMb6mWb4p
	 j47tAp5qeZkhZ9EbcOvFNiXvID4ZkdfyPUePz4dL185vGjdVF3sERaCHEzou+XuQRj
	 VjL/bcJN3syznimDTOw5vm5ctWLFXRDhV/6DcIyGLtuZLS2t3olPGOjqICHENT4FyP
	 c6KZCRU+V6eCg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 293A886A3C;
 Tue, 17 Oct 2023 03:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697506467;
 bh=MpcGPchvw0f7ty43CUtA/0S6NxoHzbtO7/ilU+T2gaY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VBNClNiX/7is+3sFnHAGvJJ2GtS5Y7LO70/8kQK9aYz71xAbsAtJSicjKoVkmIh1Q
 quXEXpWvTjYNksHTPB4QyRF3ING6COI8LESYELwDYDeTy6ZmGuA4ZSreTzk+XRtc/0
 ckaJJrAVCgmM/+YFvsY4tqvbKJ0ppie8XijKuEqz0iWcy+2I679RmeGnMlycBtWFfJ
 bbAegwSMiS73qjcknp4vMufOIDwnW/7rlpzyLPGw8c/3KzWBqSuQFN0PsOfx8bi28n
 nOeU2Vh6tHqSLqVwT8D73IsjYdcxuj58npsfXDGyZxDb0b0LTxQaz2Pse2bKCXl1bj
 y2yUqyf08S8Cg==
Message-ID: <52582da8-9f29-456c-9c72-f9321df1bc4a@denx.de>
Date: Tue, 17 Oct 2023 03:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: imx: Add support for detecting primary/secondary
 bmode on MX8M
Content-Language: en-US
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20230729150946.214878-1-marex@denx.de>
 <20230729150946.214878-3-marex@denx.de>
 <f0e2bb0e-a1e6-45ce-81f1-1a026f125068@denx.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <f0e2bb0e-a1e6-45ce-81f1-1a026f125068@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/16/23 08:44, Stefano Babic wrote:
> Hi Fedor, Marek,
> 
> On 29.07.23 17:09, Marek Vasut wrote:
>> From: Fedor Ross <fedor.ross@ifm.com>
>>
>> Implement the 'getprisec' subcommand of 'bmode' command for i.MX8M by
>> reading out the ROM log events. This event is set by the BootROM if it
>> switched to the secondary copy due to primary copy being corrupted.
>>
>> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Stefano Babic <sbabic@denx.de>
>> ---
>>   arch/arm/mach-imx/Kconfig     | 2 +-
>>   arch/arm/mach-imx/imx8m/soc.c | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index d94b5828d0d..982d542b1c8 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -70,7 +70,7 @@ config CSF_SIZE
>>   config CMD_BMODE
>>       bool "Support the 'bmode' command"
>>       default y
>> -    depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5
>> +    depends on ARCH_IMX8M || ARCH_MX7 || ARCH_MX6 || ARCH_MX5
>>       help
>>         This enables the 'bmode' (bootmode) command for forcing
>>         a boot from specific media.
>> diff --git a/arch/arm/mach-imx/imx8m/soc.c 
>> b/arch/arm/mach-imx/imx8m/soc.c
>> index 2234ef947a1..10e5aeb48a2 100644
>> --- a/arch/arm/mach-imx/imx8m/soc.c
>> +++ b/arch/arm/mach-imx/imx8m/soc.c
>> @@ -726,6 +726,11 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
>>       return part;
>>   }
>> +
>> +int boot_mode_getprisec(void)
>> +{
>> +    return !!imx8m_detect_secondary_image_boot();
>> +}
>>   #endif
>>   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
> 
> 
> This breaks several board, I bisected imx8mm-cl-iot-gate because those 
> boards don't define boot_mode_apply:
> 
> +arch/arm/mach-imx/cmd_bmode.c:86: undefined reference to `boot_mode_apply'
> +make[1]: *** [Makefile:1765: u-boot] Error 139
> 
> I cannot apply this, please check and repost, thanks.

I sent a slightly more extensive V2 which passes CI.
