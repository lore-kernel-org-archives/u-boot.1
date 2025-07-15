Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75C5C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 11:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3E782F6F;
	Tue, 15 Jul 2025 13:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kPDBgp3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CF282F8F; Tue, 15 Jul 2025 13:17:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAF182BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a257=Z4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752578217;
 bh=PEV2BrdLupkqpRbt+BltdUkQMAtYJxTANfGgv4eCjKc=;
 b=kPDBgp3qwwJjd31sLt7yZuSBiscS6tRzpem5OGedYlNoU7jsjIlU+EiGbHBED/tlZvF8F88oc
 iNQpZcix4WRfZ2tMq0N9aQUxdQQ2uq4OnG+C4XH12mWLbCHxi9ykxCfvWwiTqXkUenFS+xlPT2Z
 m4KqqTnMkVF8t3VckmRHKbh72qqVD5RpImXOKDYvc0T0K4HM4dLqrdqEWyJ3+ohwcNjmG8ZYsZ1
 nxrYi9aMshVwsUqGRGfmjfAdHOEIjgnbVwkoA7uv7p5P3QYYYR4HQe7QB02y2jr7s+eecXh/QTD
 oAbh3JMmQT61smCj7B8E+fKorckhpOozj/TcHKUXvkPw==
X-Forward-Email-ID: 687638a102da433925acb7eb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <23c00620-379d-4bf6-b692-86146b386789@kwiboo.se>
Date: Tue, 15 Jul 2025 13:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
To: Peng Fan <peng.fan@nxp.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20250714203410.1782783-1-jonas@kwiboo.se>
 <PAXPR04MB84591B628A56777F00320BEF8857A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <PAXPR04MB84591B628A56777F00320BEF8857A@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 7/15/2025 3:15 AM, Peng Fan wrote:
>> Subject: [PATCH v2] mmc: rockchip_sdhci: Set xx_TAP_VALUE for
>> RK3528
>>
>> eMMC erase and write support on RK3528 is somewhat unreliable,
>> sometime e.g. mmc erase and write commands will fail with an error.
>>
>> Use the delay line lock value for half card clock cycle,
>> DLL_LOCK_VALUE, to set a manual xx_TAP_VALUE to fix the unreliable
>> eMMC support.
>>
>> This is only enabled for RK3528, remaining SoCs still use the automatic
>> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure
>> manually for RK3528.
> 
> May I ask how linux kernel handle this issue you spotted?

I am not yet sure if or how this issue may be affecting Linux.

This issue turned up when I was testing eMMC on my ArmSoM Sige1 board,
where a simple "mmc erase 40 5000" to remove an existing bootloader or
use "mmc write $fileaddr 40 5000" to write the new bootloader
unexpectedly resulted in an ERROR.

When using the generic-rk3528 target (a minimal generic device tree) the
emmc module seems to initialize correctly:

  => mmc dev 0
  rk3568_sdhci_config_dll: clock=400000 enable=0
  rk3568_sdhci_config_dll: clock=400000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=200000000 enable=0
  rk3568_sdhci_config_dll: clock=200000000 enable=1
  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
  switch to partitions #0, OK
  mmc0(part 0) is current device
  =>

However when using a real device tree for the board the sdhci init seem
to sometime behave differently:

  => mmc dev 0
  rk3568_sdhci_config_dll: clock=400000 enable=0
  rk3568_sdhci_config_dll: clock=400000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=200000000 enable=0
  rk3568_sdhci_config_dll: clock=200000000 enable=1
  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=200000000 enable=0
  rk3568_sdhci_config_dll: clock=200000000 enable=1
  rk3568_sdhci_config_dll: dll_tap_value=2007600 DLL_LOCK_VALUE=3b
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=25000000 enable=0
  rk3568_sdhci_config_dll: clock=25000000 enable=1
  rk3568_sdhci_config_dll: clock=52000000 enable=0
  rk3568_sdhci_config_dll: clock=52000000 enable=1
  switch to partitions #0, OK
  mmc0(part 0) is current device
  =>

or something similar could be observed.

Please note that above code that is run print out the value that would
have been used for dll_tap_value but it never uses it to configure the
manual tap values.

However when the dll_tap_value are used the initialization seem to be
back to working normally (single cycle) and erase/write starts working.

Possible that some other underlying power, clock or timing issue is
causing this discrepancy.

To my knowlede Linux is using interrups during sdhci card inizialization
compared to U-Boot, so Linux may not be affected of this issue.

Regards,
Jonas

> 
> Thanks,
> Peng.
> 
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - Rename flag and field value to function name, TAPVALUE_FROM_SW
>> - Simplify and make code more understandable with use of
>> FIELD_GET/PREP,
>>   should be more clear that xx_TAP_VALUE is set to DLL_LOCK_VALUE *
>> 2
>> ---
>>  drivers/mmc/rockchip_sdhci.c | 27 ++++++++++++++++++++++-----
>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/rockchip_sdhci.c
>> b/drivers/mmc/rockchip_sdhci.c index 761e3619329c..cca917da68e7
>> 100644
>> --- a/drivers/mmc/rockchip_sdhci.c
>> +++ b/drivers/mmc/rockchip_sdhci.c
>> @@ -9,6 +9,7 @@
>>  #include <dm.h>
>>  #include <dm/ofnode.h>
>>  #include <dt-structs.h>
>> +#include <linux/bitfield.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>>  #include <linux/libfdt.h>
>> @@ -86,6 +87,9 @@
>>  #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
>>  #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
>>  #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
>> +#define DLL_TAPVALUE_FROM_SW		BIT(25)
>> +#define DLL_TAP_VALUE_PREP(x)
>> 	FIELD_PREP(GENMASK(15, 8), (x))
>> +#define DLL_LOCK_VALUE_GET(x)
>> 	FIELD_GET(GENMASK(7, 0), (x))
>>
>>  #define DLL_LOCK_WO_TMOUT(x) \
>>  	((((x) & DWCMSHC_EMMC_DLL_LOCKED) ==
>> DWCMSHC_EMMC_DLL_LOCKED) && \ @@ -93,6 +97,7 @@
>>  #define ROCKCHIP_MAX_CLKS		3
>>
>>  #define FLAG_INVERTER_FLAG_IN_RXCLK	BIT(0)
>> +#define FLAG_TAPVALUE_FROM_SW		BIT(1)
>>
>>  struct rockchip_sdhc_plat {
>>  	struct mmc_config cfg;
>> @@ -317,7 +322,7 @@ static int rk3568_sdhci_config_dll(struct
>> sdhci_host *host, u32 clock, bool enab
>>  	struct sdhci_data *data = (struct sdhci_data
>> *)dev_get_driver_data(priv->dev);
>>  	struct mmc *mmc = host->mmc;
>>  	int val, ret;
>> -	u32 extra, txclk_tapnum;
>> +	u32 extra, txclk_tapnum, dll_tap_value;
>>
>>  	if (!enable) {
>>  		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
>> @@ -347,7 +352,15 @@ static int rk3568_sdhci_config_dll(struct
>> sdhci_host *host, u32 clock, bool enab
>>  		if (ret)
>>  			return ret;
>>
>> -		extra = DWCMSHC_EMMC_DLL_DLYENA |
>> DLL_RXCLK_ORI_GATE;
>> +		if (data->flags & FLAG_TAPVALUE_FROM_SW)
>> +			dll_tap_value = DLL_TAPVALUE_FROM_SW |
>> +
>> 	DLL_TAP_VALUE_PREP(DLL_LOCK_VALUE_GET(val) * 2);
>> +		else
>> +			dll_tap_value = 0;
>> +
>> +		extra = DWCMSHC_EMMC_DLL_DLYENA |
>> +			DLL_RXCLK_ORI_GATE |
>> +			dll_tap_value;
>>  		if (data->flags & FLAG_INVERTER_FLAG_IN_RXCLK)
>>  			extra |= DLL_RXCLK_NO_INVERTER;
>>  		sdhci_writel(host, extra,
>> DWCMSHC_EMMC_DLL_RXCLK); @@ -361,19 +374,22 @@ static int
>> rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>>  				DLL_CMDOUT_BOTH_CLK_EDGE |
>>  				DWCMSHC_EMMC_DLL_DLYENA |
>>  				data->hs400_cmdout_tapnum |
>> -				DLL_CMDOUT_TAPNUM_FROM_SW;
>> +				DLL_CMDOUT_TAPNUM_FROM_SW
>> |
>> +				dll_tap_value;
>>  			sdhci_writel(host, extra,
>> DWCMSHC_EMMC_DLL_CMDOUT);
>>  		}
>>
>>  		extra = DWCMSHC_EMMC_DLL_DLYENA |
>>  			DLL_TXCLK_TAPNUM_FROM_SW |
>>  			DLL_TXCLK_NO_INVERTER |
>> -			txclk_tapnum;
>> +			txclk_tapnum |
>> +			dll_tap_value;
>>  		sdhci_writel(host, extra,
>> DWCMSHC_EMMC_DLL_TXCLK);
>>
>>  		extra = DWCMSHC_EMMC_DLL_DLYENA |
>>  			data->hs400_strbin_tapnum |
>> -			DLL_STRBIN_TAPNUM_FROM_SW;
>> +			DLL_STRBIN_TAPNUM_FROM_SW |
>> +			dll_tap_value;
>>  		sdhci_writel(host, extra,
>> DWCMSHC_EMMC_DLL_STRBIN);
>>  	} else {
>>  		/*
>> @@ -663,6 +679,7 @@ static const struct sdhci_data rk3528_data = {
>>  	.set_ios_post = rk3568_sdhci_set_ios_post,
>>  	.set_clock = rk3568_sdhci_set_clock,
>>  	.config_dll = rk3568_sdhci_config_dll,
>> +	.flags = FLAG_TAPVALUE_FROM_SW,
>>  	.hs200_txclk_tapnum = 0xc,
>>  	.hs400_txclk_tapnum = 0x6,
>>  	.hs400_cmdout_tapnum = 0x6,
>> --
>> 2.49.0
> 

