Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B4FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 16:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E9C82E37;
	Mon, 14 Jul 2025 18:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0TFI6omf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2461A82F14; Mon, 14 Jul 2025 18:36:31 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C9682CEA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 18:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752510987;
 bh=BnFdVmwxWfibSi4NA9ZhLKysEr3dpN3eA9WMMPjkTlY=;
 b=0TFI6omfocy5mRHT/n2EiAJ2z9WZSusyzzxR8nXli1aWIlRfwR8zGon+f8PQaGYe2/UhfeNrC
 wadcNjRzvL6rVD371FZZheKMETrFqf/q09yjAxdptFkTVphqs5GeJNw5hQHEYcNHho0R1lvtzRN
 ESr5XchTXdWfxSRbbm3pqVzLIkV8+RpaVPbwAaPSnS3gOGNDrHlFNYhkEuatBoyjhWALpTqvmvK
 +HWViiyODck2GM13RQh3HfxWAcvZDroa3+0tBV6gM+w9MDGQwT8jb9yYjHbKHgioS/CDkE9wglI
 hg0GVmFmkrvhKAZjHRshvMOwmkWZtugdt1qO2x+9WMgw==
X-Forward-Email-ID: 687531ff2fde68b42d1b514d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e8c2de73-48b8-47ce-9039-9bb00c5d2261@kwiboo.se>
Date: Mon, 14 Jul 2025 18:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250710162110.3592089-1-jonas@kwiboo.se>
 <f8220dee-4f70-42c7-af38-53e5a649e31c@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f8220dee-4f70-42c7-af38-53e5a649e31c@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Quentin,

On 7/14/2025 5:38 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/10/25 6:21 PM, Jonas Karlman wrote:
>> eMMC erase and write support on RK3528 is somewhat unreliable, sometime
>> e.g. mmc erase and write commands will fail with an error.
>>
>> Use the delay line lock value for half card clock cycle, DLL_LOCK_VALUE,
>> to set a manual xx_TAP_VALUE to fix the unreliable eMMC support.
>>
>> This is only enabled for RK3528, remaining SoCs still use the automatic
>> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure manually
>> for RK3528.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/mmc/rockchip_sdhci.c | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
>> index 761e3619329c..f15ea7c9c6b7 100644
>> --- a/drivers/mmc/rockchip_sdhci.c
>> +++ b/drivers/mmc/rockchip_sdhci.c
>> @@ -86,13 +86,19 @@
>>   #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
>>   #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
>>   #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
>> +#define DLL_TAP_VALUE_SEL		BIT(25)
> 
> Maybe match the name for the other tap bitfields?

I went with a single define because TXCLK, RXCLK, STRBIN and CMDOUT all
share similar fields, the xx_TAP_VALUE_SEL field is at bit 25 in all of
the EMMC_DLL_xx regs.

Not really sure why we have multiple defines for the other fields when
these regs mostly share similar fields.

> 
> We have DLL_TXCLK_TAPNUM_FROM_SW for example, so something like
> 
> DLL_TAPVALUE_FROM_SW
> 
> ?

I was switching between the field name and the function name during
testing, and you are correct it should be the function name not the
field name. Will change in a v2.

> 
>> +#define DLL_TAP_VALUE_OFFSET		8
>> +#define DLL_LOCK_VALUE_MASK		0xFF
>>   
>> +#define DLL_LOCK_VALUE(x) \
>> +	((((x) & DLL_LOCK_VALUE_MASK) * 2) & DLL_LOCK_VALUE_MASK)
> 
> This seems very odd, why do we need to binary AND before and after 
> multiplying by 2? Trying to avoid an overflow somehow?
> Also, where did you get you need to multiply by 2? The RK3588 TRM 
> doesn't seem to be hinting at that being required?

From the field definition for the different fields:

"""
xx_TAP_VALUE_SEL[25]
Tap value selection for receive clock/transmit clock/strobe input/command output.
1'b0: Tap value equals to (DLL_LOCK_VALUE*2)%256
1'b1: Tap value comes from software (xx_TAP_VALUE)

xx_TAP_VALUE[15:8]
Tap value for receive clock/transmit clock/strobe input/command output.
It denotes delay element number for receive clock/transmit clock/strobe input/command output.

DLL_LOCK[8]
Delay line lock indication.
1'b0: Delay line is not locked
1'b1: Delay line is locked

DLL_LOCK_VALUE[7:0]
Delay line lock value for half card clock cycle.
It denotes the delay element number needed for delay line locked. It is valid when DLL_LOCK is high.
"""

And from 4.6.1 Clock Adjustment of RK3588 TRM:

"""
After phase detection, the clock’s precision is shown in EMMC_DLL_STATUS0[7:0] (DLL_LOCK_VALUE) based on delay element.
We can calculate the delay element numbers requirement for transmit clock (TXCLK), receive clock (RXCLK), data strobe input (STRBIN), command output (CMDOUT), denoted as “XX” as follows:
(1) Get tap value: if XX_TAP_VALUE_SEL=0, tap value equals to (DLL_LOCK_VALUE*2)%256; else tap value is set by software, XX_TAP_VALUE;
(2) Get tap number: if XX_TAP_NUM_SEL=0, tap number comes from Host Controller; else tap number is set by software, XX_TAP_NUM;
(3) Get required delay element numbers: if XX_DELAY_NUM_SEL=0, delay element number equals to tap value* tap number; else delay element number is set by software, XX_DELAY_NUM.
"""

The DLL_LOCK_VALUE at EMMC_DLL_STATUS0[7:0] is the delay line lock value
for half card clock cycle, to get a value that can be set in
xx_TAP_VALUE we must double it for full clock cycle.

Something like this is also what vendor kernel and u-boot does for all
SoCs, at least for linux-6.1-stan-rkr5.

> 
> I believe you could also simply use
> 
> #define DLL_LOCK_VALUE(x) FIELD_PREP((x) * 2, 0xff00)
> 
> and avoid having to carry the mask or the offset of the bitfield in the 
> code (not tested though).

Something like following could possible work:

#define DLL_TAPVALUE_FROM_SW	BIT(25)
#define DLL_LOCK_VALUE_FIELD	GENMASK(7, 0)
#define DLL_LOCK_VALUE(x)	FIELD_GET(DLL_LOCK_VALUE_FIELD, (x))
#define DLL_TAP_VALUE_FIELD	GENMASK(15, 8)
#define DLL_TAP_VALUE(x)	FIELD_PREP(DLL_TAP_VALUE_FIELD, DLL_LOCK_VALUE((x)) * 2)

dll_tap_value = DLL_TAPVALUE_FROM_SW | DLL_TAP_VALUE(val);

If that makes it any more clear what is happening?

Regards,
Jonas

> 
>>   #define DLL_LOCK_WO_TMOUT(x) \
>>   	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>>   	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
>>   #define ROCKCHIP_MAX_CLKS		3
>>   
>>   #define FLAG_INVERTER_FLAG_IN_RXCLK	BIT(0)
>> +#define FLAG_TAP_VALUE_SEL		BIT(1)
>>   
>>   struct rockchip_sdhc_plat {
>>   	struct mmc_config cfg;
>> @@ -317,7 +323,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>>   	struct sdhci_data *data = (struct sdhci_data *)dev_get_driver_data(priv->dev);
>>   	struct mmc *mmc = host->mmc;
>>   	int val, ret;
>> -	u32 extra, txclk_tapnum;
>> +	u32 extra, txclk_tapnum, dll_tap_value;
>>   
>>   	if (!enable) {
>>   		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
>> @@ -347,7 +353,15 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>>   		if (ret)
>>   			return ret;
>>   
>> -		extra = DWCMSHC_EMMC_DLL_DLYENA | DLL_RXCLK_ORI_GATE;
>> +		if (data->flags & FLAG_TAP_VALUE_SEL)
>> +			dll_tap_value = DLL_TAP_VALUE_SEL |
>> +					DLL_LOCK_VALUE(val) << DLL_TAP_VALUE_OFFSET;
>> +		else
>> +			dll_tap_value = 0;
>> +
>> +		extra = DWCMSHC_EMMC_DLL_DLYENA |
>> +			DLL_RXCLK_ORI_GATE |
>> +			dll_tap_value;
>>   		if (data->flags & FLAG_INVERTER_FLAG_IN_RXCLK)
>>   			extra |= DLL_RXCLK_NO_INVERTER;
>>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>> @@ -361,19 +375,22 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>>   				DLL_CMDOUT_BOTH_CLK_EDGE |
>>   				DWCMSHC_EMMC_DLL_DLYENA |
>>   				data->hs400_cmdout_tapnum |
>> -				DLL_CMDOUT_TAPNUM_FROM_SW;
>> +				DLL_CMDOUT_TAPNUM_FROM_SW |
>> +				dll_tap_value;
>>   			sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CMDOUT);
>>   		}
>>   
>>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
>>   			DLL_TXCLK_TAPNUM_FROM_SW |
>>   			DLL_TXCLK_NO_INVERTER |
>> -			txclk_tapnum;
>> +			txclk_tapnum |
>> +			dll_tap_value;
>>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>>   
>>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
>>   			data->hs400_strbin_tapnum |
>> -			DLL_STRBIN_TAPNUM_FROM_SW;
>> +			DLL_STRBIN_TAPNUM_FROM_SW |
>> +			dll_tap_value;
>>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>>   	} else {
>>   		/*
>> @@ -663,6 +680,7 @@ static const struct sdhci_data rk3528_data = {
>>   	.set_ios_post = rk3568_sdhci_set_ios_post,
>>   	.set_clock = rk3568_sdhci_set_clock,
>>   	.config_dll = rk3568_sdhci_config_dll,
>> +	.flags = FLAG_TAP_VALUE_SEL,
>>   	.hs200_txclk_tapnum = 0xc,
>>   	.hs400_txclk_tapnum = 0x6,
>>   	.hs400_cmdout_tapnum = 0x6,
> 

