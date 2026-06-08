Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6CCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A3C84154;
	Mon,  8 Jun 2026 09:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HvOhrxr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FA7846C3; Mon,  8 Jun 2026 09:53:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 72BF083FEC
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D131476;
 Mon,  8 Jun 2026 00:52:58 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 846D13F86F; Mon,  8 Jun 2026 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780905183; bh=uJKzGjAKhPwt6+/VGWI4ZjsJAIxxs7HkMfW4MqLbb/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HvOhrxr5NNHvxyyu1BPExfZ+OEvukIRTJXjPeFm5WP10uz0PMHOaXuUKCWz36RP8+
 lZeyLGg/uDUxI+1HjSV7j5z04nU4LS3AVINV/TVwc07dNTgS3USiZ5jnSTWt3mQUTC
 Xdw4D+KsTLhwp89QEFrJ8egibD5zLzIXCDfv42uU=
Message-ID: <9ae8c8ae-39e7-4c91-9323-0644424972f9@arm.com>
Date: Mon, 8 Jun 2026 09:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
 <DJ11OP03ERX3.OQJE3XQ1QJ3F@linaro.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <DJ11OP03ERX3.OQJE3XQ1QJ3F@linaro.org>
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

Hi Ilias,

On 6/5/26 12:31, Ilias Apalodimas wrote:
> Andre,
> this has been assigned to me by mistake in patchwork.

thanks for the heads up, this somehow didn't even make it into my inbox.

> I guess Tom can pick it up directly after the reviews etc?

It's fine for me to take it through the sunxi tree.

Will reply to the original post for some details.

Cheers,
Andre

> 
> Thanks
> /Ilias
> On Wed May 27, 2026 at 12:28 AM EEST, Omar Ivan Fardjoume wrote:
>> Hi, first thanks for everything you do.
>> I was working on reviving a cubieboard4 a80 board and I found and fix
>> two issues that prevented eMMC from working on sun9i-A80 boards:
>> 1. The get_mclk_offset() function used the non-existent Kconfig symbol
>>     CONFIG_MACH_SUN9I_A80 instead of CONFIG_MACH_SUN9I, causing the
>>     MMC2 clock register to be written at 0x06000090 instead of
>>     0x06000418. This corrupted the CMD2 response and made eMMC
>>     completely unresponsive.
>> 2. The legacy (SPL) sunxi_mmc_init() did not include CONFIG_MACH_SUN9I
>>     in the 8-bit bus width condition, so MMC2 (eMMC) would only use
>>     4-bit mode in the SPL, which is insufficient for reliable boot.
>> Tested on a Cubieboard4 A80: with both fixes, SPL loads U-Boot proper
>> and boots Debian 12 from eMMC with no SD card present.
>> Signed-off-by: Omar Ivan Fardjoume <ivan.fardjoume@email.com>
>> ---
>>   drivers/mmc/sunxi_mmc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
>> index 4c5fbf8960f..3d5e7c1a234 100644
>> --- a/drivers/mmc/sunxi_mmc.c
>> +++ b/drivers/mmc/sunxi_mmc.c
>> @@ -546,7 +546,7 @@ struct mmc *sunxi_mmc_init(int sdc_no)
>>    cfg->voltages = MMC_VDD_32_33 | MMC_VDD_33_34;
>>    cfg->host_caps = MMC_MODE_4BIT;
>>
>> - if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I) ||
>> + if ((IS_ENABLED(CONFIG_MACH_SUN50I) || IS_ENABLED(CONFIG_MACH_SUN8I)
>> || IS_ENABLED(CONFIG_MACH_SUN9I) ||
>>        IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
>> IS_ENABLED(CONFIG_MACH_SUN55I_A523)) &&
>>        (sdc_no == 2))
>>    cfg->host_caps = MMC_MODE_8BIT;
>> @@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
>>
>>   static unsigned get_mclk_offset(void)
>>   {
>> - if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
>> + if (IS_ENABLED(CONFIG_MACH_SUN9I))
>>    return 0x410;
>>
>>    if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
> 

