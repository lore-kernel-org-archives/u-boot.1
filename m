Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2E3C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 14:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9F688652;
	Thu, 18 Apr 2024 16:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eq2vKQCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936F28866A; Thu, 18 Apr 2024 16:28:46 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA928863C
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 16:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IESe7Z007579;
 Thu, 18 Apr 2024 09:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713450520;
 bh=tasxO9FieIFldwq5P4IBabZEFZRl9cxwdfhmhwx8H88=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Eq2vKQCni3kvV7yJlyeEkkcKzxR9P7pOGuRno+tMK6Rur+0IaHcl8Up+WY3RzfJcN
 dcHj00kk1LCw6yNK+cER9DgKW/UkKdXneLcndVA8NqWGKnR0X8iQcwrnu6xkfskI90
 q5lUtiQkpYfrzWXEib6jdcpr4aU9jtRk56wbR2p0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IESeug123024
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 18 Apr 2024 09:28:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 09:28:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 09:28:40 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IESe0S064130;
 Thu, 18 Apr 2024 09:28:40 -0500
Message-ID: <ae2ac350-af67-442e-b518-00e97a3c8ec6@ti.com>
Date: Thu, 18 Apr 2024 09:28:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mmc: am654_sdhci: Add tuning algorithm for delay chain
To: Jaehoon Chung <jh80.chung@samsung.com>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Tom Rini'" <trini@konsulko.com>
CC: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212757epcas1p1a6d792672e1e125e1d1bfb6feec15f0f@epcas1p1.samsung.com>
 <20240415212747.2678974-2-jm@ti.com>
 <01e201da90b9$adcbe020$0963a060$@samsung.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <01e201da90b9$adcbe020$0963a060$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi,

On 4/17/24 6:23 AM, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Judith Mendez <jm@ti.com>
>> Sent: Tuesday, April 16, 2024 6:28 AM
>> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
>> Cc: Nitin Yadav <n-yadav@ti.com>; Simon Glass <sjg@chromium.org>; u-boot@lists.denx.de
>> Subject: [PATCH 1/5] mmc: am654_sdhci: Add tuning algorithm for delay chain
>>
>> Currently the sdhci_am654 driver only supports one tuning
>> algorithm which should be used only when DLL is enabled. The
>> ITAPDLY is selected from the largest passing window and the
>> buffer is viewed as a circular buffer.
>>
>> The new tuning algorithm should be used when the delay chain
>> is enabled; the ITAPDLY is selected from the largest passing
>> window and the buffer is not viewed as a circular buffer.
>>
>> This implementation is based off of the following paper: [1].
>>
>> Also add support for multiple failing windows.
>>
>> [1] https://www.ti.com/lit/an/spract9/spract9.pdf
>>
>> Fixes: a759abf569d4 ("mmc: am654_sdhci: Add support for software tuning")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/am654_sdhci.c | 107 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 89 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
>> index 05595bdac39..e5ad00e2531 100644
>> --- a/drivers/mmc/am654_sdhci.c
>> +++ b/drivers/mmc/am654_sdhci.c
>> @@ -97,6 +97,7 @@ struct am654_sdhci_plat {
>>   	u32 strb_sel;
>>   	u32 clkbuf_sel;
>>   	u32 flags;
>> +	bool dll_enable;
>>   #define DLL_PRESENT	BIT(0)
>>   #define IOMUX_PRESENT	BIT(1)
>>   #define FREQSEL_2_BIT	BIT(2)
>> @@ -110,6 +111,12 @@ struct timing_data {
>>   	u32 capability;
>>   };
>>
>> +struct window {
>> +	u8 start;
>> +	u8 end;
>> +	u8 length;
>> +};
>> +
>>   static const struct timing_data td[] = {
>>   	[MMC_LEGACY]	= {"ti,otap-del-sel-legacy",
>>   			   "ti,itap-del-sel-legacy",
>> @@ -280,8 +287,11 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
>>   		ret = am654_sdhci_setup_dll(plat, speed);
>>   		if (ret)
>>   			return ret;
>> +
>> +		plat->dll_enable = true;
>>   	} else {
>>   		am654_sdhci_setup_delay_chain(plat, mode);
>> +		plat->dll_enable = false;
>>   	}
>>
>>   	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
>> @@ -375,38 +385,99 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
>>   	writeb(val, host->ioaddr + reg);
>>   }
>>   #ifdef MMC_SUPPORTS_TUNING
>> -#define ITAP_MAX	32
>> +#define ITAPDLY_LENGTH 32
>> +#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
>> +
>> +static u32 am654_sdhci_calculate_itap(struct udevice *dev, struct window
>> +			  *fail_window, u8 num_fails, bool circular_buffer)
>> +{
>> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
>> +	u8 first_fail_start = 0, last_fail_end = 0;
>> +	struct window pass_window = {0, 0, 0};
>> +	int prev_fail_end = -1;
>> +	u8 i;
>> +
>> +	if (!num_fails)
>> +		return ITAPDLY_LAST_INDEX >> 1;
>> +
>> +	if (fail_window->length == ITAPDLY_LENGTH) {
>> +		dev_err(dev, "No passing ITAPDLY, return 0\n");
>> +		return 0;
>> +	}
>> +
>> +	first_fail_start = fail_window->start;
>> +	last_fail_end = fail_window[num_fails - 1].end;
>> +
>> +	for (i = 0; i < num_fails; i++) {
>> +		start_fail = fail_window[i].start;
>> +		end_fail = fail_window[i].end;
>> +		pass_length = start_fail - (prev_fail_end + 1);
>> +
>> +		if (pass_length > pass_window.length) {
>> +			pass_window.start = prev_fail_end + 1;
>> +			pass_window.length = pass_length;
>> +		}
>> +		prev_fail_end = end_fail;
>> +	}
>> +
>> +	if (!circular_buffer)
>> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
>> +	else
>> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
>> +
>> +	if (pass_length > pass_window.length) {
>> +		pass_window.start = last_fail_end + 1;
>> +		pass_window.length = pass_length;
>> +	}
>> +
>> +	if (!circular_buffer)
>> +		itap = pass_window.start + (pass_window.length >> 1);
>> +	else
>> +		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
>> +
>> +	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
>> +}
>> +
>>   static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>>   {
>>   	struct udevice *dev = mmc->dev;
>>   	struct am654_sdhci_plat *plat = dev_get_plat(dev);
>> -	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
>> -	u32 itap;
>> +	struct window fail_window[ITAPDLY_LENGTH];
>> +	u8 curr_pass, itap;
>> +	u8 fail_index = 0;
>> +	u8 prev_pass = 1;
>> +
>> +	memset(fail_window, 0, sizeof(fail_window));
>>
>>   	/* Enable ITAPDLY */
>>   	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
>>   			   1 << ITAPDLYENA_SHIFT);
>>
>> -	for (itap = 0; itap < ITAP_MAX; itap++) {
>> +	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>>   		am654_sdhci_write_itapdly(plat, itap);
>>
>> -		cur_val = !mmc_send_tuning(mmc, opcode, NULL);
>> -		if (cur_val && !prev_val)
>> -			pass_window = itap;
>> +		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);
> 
> It's changed to !mmc_send_tuing(mmc, opcode). Could you change this based on latest u-boot?
> 
> Sorry for bothering you.
> 
> commit a3b2786651c7 "mmc: Drop unused mmc_send_tuning() cmd_error parameter"

Thanks, will fix.

~ Judith

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> -		if (!cur_val)
>> -			fail_len++;
>> +		if (!curr_pass && prev_pass)
>> +			fail_window[fail_index].start = itap;
>>
>> -		prev_val = cur_val;
>> +		if (!curr_pass) {
>> +			fail_window[fail_index].end = itap;
>> +			fail_window[fail_index].length++;
>> +		}
>> +
>> +		if (curr_pass && !prev_pass)
>> +			fail_index++;
>> +
>> +		prev_pass = curr_pass;
>>   	}
>> -	/*
>> -	 * Having determined the length of the failing window and start of
>> -	 * the passing window calculate the length of the passing window and
>> -	 * set the final value halfway through it considering the range as a
>> -	 * circular buffer
>> -	 */
>> -	pass_len = ITAP_MAX - fail_len;
>> -	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
>> +
>> +	if (fail_window[fail_index].length != 0)
>> +		fail_index++;
>> +
>> +	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
>> +					  plat->dll_enable);
>> +
>>   	am654_sdhci_write_itapdly(plat, itap);
>>
>>   	return 0;
>> --
>> 2.43.2
> 
> 

