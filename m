Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4289CC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 13:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8784483CB9;
	Thu, 10 Apr 2025 15:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="isQI4PJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7917983CBD; Thu, 10 Apr 2025 15:31:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F3783C02
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744291902;
 bh=uwZfhCmC1kjmeD5ETZquknKQ5Ch9gpdykqpeRaoYn28=;
 b=isQI4PJ/ecedBhRoKoHihDakcz2TnaazAwhwAPlzRChBTdYDNJ+kt6wBtsfbtHphmTyziwCyK
 I79BzuDXyzJno0n6xA4lS1EXFM/KjqkXOsaajPNnrq8gDrBTZFqPf/pjt+3UfNIVhzIdzGuK0d7
 4rj0yCLSf7ZGITOv8SZX8WYTPj352bLq4GcnJhw3qmaqrNsxZgJ1UjjuuFXxcRJGygB3k5cDbzQ
 kO18DzlmUDLT0zUzq1/YW3HnjEXNWxaBvEcCpQEpLYAQQgj1+vvH3G2YkTChBVUj8IYb622ubf1
 dNYJphysj6qmRdl6I2hxx6zmoNscSvWRDc1XbI2mSG2w==
X-Forward-Email-ID: 67f7c8369583b205ebaae225
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <942c7e46-2b95-4d6e-8194-a6b25eedd2f7@kwiboo.se>
Date: Thu, 10 Apr 2025 15:31:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Fix possible Synchronous Abort using PIO mode
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de
References: <20250123214850.3085559-1-jonas@kwiboo.se>
 <20250410122844.GA311@nxa18884-linux>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250410122844.GA311@nxa18884-linux>
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

Hi Peng,

On 2025-04-10 14:28, Peng Fan wrote:
> Hi Jonas,
> 
> On Thu, Jan 23, 2025 at 09:48:48PM +0000, Jonas Karlman wrote:
>> When MMC_SDHCI_SDMA=y or MMC_SDHCI_ADMA=y and PIO mode is used
>> dma_unmap_single() is called on an unmapped address, 0x0. This may
>> result in a Synchronous Abort:
>>
>>  ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>  CMD_SEND:16
>>                  ARG                      0x00000200
>>                  MMC_RSP_R1,5,6,7         0x00000900
>>  CMD_SEND:18
>>                  ARG                      0x00004005
>>  "Synchronous Abort" handler, esr 0x96000147
>>  elr: 00000000400015bc lr : 0000000040012b4c
>>  x 0: 0000000000008000 x 1: 0000000000092600
>>  x 2: 0000000000000040 x 3: 000000000000003f
>>  x 4: 0000000000000030 x 5: 0000000000000001
>>  x 6: 0000000000000001 x 7: 0000000000000000
>>  x 8: 000000000000000a x 9: 0000000000000090
>>  x10: 0000000043dffc68 x11: 0000000043c00440
>>  x12: 0000000043c00440 x13: ffffffffbfe00000
>>  x14: 000000000000031c x15: 0000000240000000
>>  x16: 000000004001145c x17: 0000000000000032
>>  x18: 0000000043dffef0 x19: 0000000043c00000
>>  x20: 0000000043dffbc8 x21: 0000000000000000
>>  x22: 00000000000f3d95 x23: 0000000000000002
>>  x24: 0000000000000493 x25: 0000000000092600
>>  x26: 0000000000000001 x27: 0000000000000001
>>  x28: 0000000000000008 x29: 0000000043dffab0
>>
>>  Code: d2800082 9ac32042 d1000443 8a230000 (d5087620)
>>  Resetting CPU ...
>>
>>  resetting ...
>>
>> Fix this by only dma_unmap_single() when DMA mode is used and
>> sdhci_prepare_dma() has been called to map host->start_addr.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> drivers/mmc/sdhci.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
>> index 4833b5158c79..dc7f0724a7b6 100644
>> --- a/drivers/mmc/sdhci.c
r>> +++ b/drivers/mmc/sdhci.c
>> @@ -177,8 +177,10 @@ static int sdhci_transfer_data(struct sdhci_host *host, struct mmc_data *data)
>> 	} while (!(stat & SDHCI_INT_DATA_END));
>>
>> #if (CONFIG_IS_ENABLED(MMC_SDHCI_SDMA) || CONFIG_IS_ENABLED(MMC_SDHCI_ADMA))
>> -	dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
>> -			 mmc_get_dma_dir(data));
>> +	if (host->flags & USE_DMA) {
>> +		dma_unmap_single(host->start_addr, data->blocks * data->blocksize,
>> +				 mmc_get_dma_dir(data));
>> +	}
> 
> Many platforms have MMC_SDHCI_SDMA enabled, but I not see USE_DMA is set.

  #define USE_DMA  (USE_SDMA | USE_ADMA | USE_ADMA64)

So any platform that enable support for xDMA should match USE_DMA.

For Rockchip there is a quirk enabled for SPL that may disable use of
xDMA even when xDMA is enabled at build time.

	/*
	 * Disable use of DMA and force use of PIO mode in SPL to fix an issue
	 * where loading part of TF-A into SRAM using DMA silently fails.
	 */
	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
	    dev_read_bool(dev, "u-boot,spl-fifo-mode"))
		host->flags &= ~USE_DMA;

I.e. xDMA may be enabled at build time, and at runtime device may use
PIO mode.

> 
> So this change will make dma_unmap_single not being called for the platforms.

No, this will fix an uneven call to dma_map_single and dma_unmap_single.

dma_map_single() is currently called in sdhci_prepare_dma():
	if (host->flags & USE_DMA) { sdhci_prepare_dma() }

dma_unmap_single() is currently called in: 
	#if (CONFIG_IS_ENABLED(MMC_SDHCI_SDMA) || CONFIG_IS_ENABLED(MMC_SDHCI_ADMA))

This change just apply same (host->flags & USE_DMA) check that
indirectly wraps the dma_map_single() call.

> 
> Will this introduce any issue?

Not to my knowledge.

sdhci_send_command() initialize host->start_addr = 0, so the current
unconditional call to dma_unmap_single(host->start_addr, ...) in
sdhci_transfer_data() may cause the above Synchronous Abort due to
start_addr being 0.

Most boards may have DRAM 0x0 mapped, however the Rockchip RK3576 where
this issue was observed does not, its DRAM base start at 0x40000000.
Trying to unmap 0x0 ended up with a Synchronous Abort.

Regards,
Jonas

> 
> Regards,
> Peng
> 
>> #endif
>>
>> 	return 0;
>> -- 
>> 2.48.1
>>

