Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF623CD11C2
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 01:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39E187BAF;
	Wed,  3 Apr 2024 03:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="VYTgGwa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AEE87BF4; Wed,  3 Apr 2024 03:16:24 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC9C879F3
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 03:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD8KyKAqvLBOmmkdjA5ERgVUAEw8KHkPh1Bbtdb0Nch969BlGGfAXcDN9cei1knzR/MfPJozoVctNPCn37mpGGin+FkrRbYahuwDL0uXNhpboz7AUIcJfJHZjeUv1xu5IFGSv2NfJCsKwzqplaa+a/Ns+9L6qclYQgh3ch6IrM2EReRFilDUFYsQHI5UOaiTSxUSAarBKpjS7g5FRe6miAsFu6tKrQqqOyBsESl6vmOZza3bM7TB7wXKQnWSLg4b3hmeRvHJJnNM8qU4lK68mqFs8QlGKLqFxbfaNyqT106CL1GgFQ3aAn5mIGQuQLcuclxp9mn2nBewfRvquV2h7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbXc044AkXJMK3g2tNKc4NfZgZ8IqMAVixLVsQZ0E5k=;
 b=VIXAWqPFDPIVFg4Pc8a6cek/5N2vDOE2zVeBcjJTur6on9tjyh5BkYgrG04kf0m1YlaozcXxLPNzyyZcE1GJH8WBM728lU/97z4R0KIDj7+GZwnwq/h+kOwJ1GXFi+s1xafWmwHaVaHBGButFFx75Nu2p/lwg9xtCTrb45Eq2RYMzZjJX2pCD90QtIIc6p8HOtK9SGKnIpQsNdXue6ozg2T1GfLgCazR6AM/BALgv1/eNx0s77wgZ9YdoY+90/q/FbAkdwxs9AFVxnMJIOUiH6hcVQq975kftYBhifdfvdahC7kxlrSrd9rs7qZmKDQOftk6HglRL6iEmVPySpLBnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbXc044AkXJMK3g2tNKc4NfZgZ8IqMAVixLVsQZ0E5k=;
 b=VYTgGwa/CME1waUAaZkhxUUVmCexgKKnweLlZGuwP3QFloRA0gojr3ii+t/ccBfLSu6i/NxJuAbT2gR5zGBf70SXTzqco88nBkrp+H3kQ8gGQcDKbKg4H/0g/eE2KIaJ4ynUBwTZzkNg/qOSSGbiJ9zWBsp9whumo/mkE6mJ0BaWWhplSzVQDlls5/QIDftSxlI8TsHUoP7ySNrS0xRJNQrbabeJOUVVPygsSrVRxMEgX5B0xtK9ud/leu8BaTsYwrGupCC7WLnu7cQrauG1WhkCwB/3VdaSZeRQhtW9HaUV80AHBxOCeKrSUmIMmQ5P3j4NHby14+5IPfe00np85w==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 01:16:18 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::aced:cbb9:4616:96d8%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 01:16:18 +0000
Message-ID: <SEZPR06MB69599C34A5A8BF84F87C1CC1963D2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Wed, 3 Apr 2024 09:16:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: hi6220-dwmmc: handle clocks and resets if
 CONFIG_CLK and CONFIG_DM_RESET enabled
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-1-9f09dc1335fd@outlook.com>
 <CGME20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a@epcas1p4.samsung.com>
 <01f712ed-a07c-4db7-b7c1-9dc0f7efd898@samsung.com>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <01f712ed-a07c-4db7-b7c1-9dc0f7efd898@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [GAPbo3RliVw0idWekp6yLMMvyC6xM70X54+dXpYrpffE6AAzDVxB+G4DkzPbuahA]
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <d7e61d5a-9e4b-4142-9846-40a1bf129837@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8246e9-ba88-430b-e923-08dc537ba9fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3L4nOjxMTqkGIMvWX9tz9/M2+YUksxb3PrYNirvbz4n8fQn2AVZ4afBP3vbsMhrRW4rAPVBo6njwhw82QNcrLbiNVACViE4KtjbJJ5kSpMexfMQ0SRBXjpskEwD7zYQP3DR0aNMquJVVoA10Sm3JoLXvZ6VWAgJJUhfHLhdEMJJB1+0t7NxSe0vfekojGhzhtW+N+z2h0PW4Khuyuj3om/SjV+LPpVMa+8lQAdOmOZ4ZoaQ2X5ODs5WgWXVq2HEmAVWM2HRTN5rEeQ7io1MUVh4vwBIcEtBa4i0N34LMbZ3tQ4QOHTj02KqePY3/80PeCjRUfAWVWF6NeOjv8bWKLnF9LX2rx18xD7GkvM4dYFLVu6se5kV2s03Uz3BJjnuiwkoAEHsPZAiDfXNMi7jlDKvnsANfwj+PTmRxlR7XIfe6SyEDMDeEXQCxdzrRD+Zz8iX5hikIJC1pwGzHap4eS5UdIvvvLL9fECzGfrIn/gMHCbvPeQ9ky2moz3wauarYA4T3e4CWtp9QI+LgnJXAGUL0jVBOicCCd5EpC3JD+Te8Ni7fQMhltYMzVGB/S5T
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBSWnoxdUd2eFBTUmhLaDFKTWxTbldyV2xwckxSNytTeUxpbzNwOERGWms5?=
 =?utf-8?B?ajNiK3htSzBJcWFGT0ZHQXJxb1RlSVJDZTNjWDE5TlJXbm1qeFc3SXM0NkNH?=
 =?utf-8?B?TGZRQkgyVnkyZ3YzbjU1VTNMYkZUQUtxNVJGdC9qU3hCWFZlK0NxRlNXWVl5?=
 =?utf-8?B?bWoyRHh4UUY2QWRUNEVkRVZIYWp2SnJwZkNjT3FXS08xVmc3WUJibjhPN0hW?=
 =?utf-8?B?T29LU3BhckxwdVAycEdkMnhsS2Eva1FpUUpNYjZNd3JIS1NOalpGUmpBc0hG?=
 =?utf-8?B?YXlaZ2RhaWo5Rlc1Y2tCcjJqS0t0QUYvdmZQL3FtYWFFbURsY2xySlhpc0o3?=
 =?utf-8?B?T2lDWnFQalkzQUJEeUxSUUh0Y1ByZDMxWjRVUjFVeUlVcG1nbDRPa3lKZ3pW?=
 =?utf-8?B?K09NdTJ6N25nYTgzU3pNQjRtblpORm9wNUwyQnI2Zkh0MVlDQ3RjYU1RVXRI?=
 =?utf-8?B?NkU3QU8rcFdiY0ZxeWNnaW9mRGJJTkFKSHNISzA5Wk51SlVsR3NlNzAwWjlO?=
 =?utf-8?B?RUpUQ0dPMmNvbFYxWDk4YjlBbkordVFJTG1yMHlKaTFnTVFqdFBqNGxjSlh0?=
 =?utf-8?B?aG5pNHppNDhQcDkxWXpBK0ZSdDVTU2ZSNmdDL3NCSXBGdE5RdjcwcTNlZkdv?=
 =?utf-8?B?Yk02eEp2RGw2aFhuek03RTg0bmN6Q05wL3ZQNDFkT3g0eFYvQ3BKSFMxbHZ3?=
 =?utf-8?B?RTUyZjd1d3J6dDZRYXJyalZmUVovdCtqMEFnbEVMSDd5NW5acnVEZGxpRFB1?=
 =?utf-8?B?aWx1ZU9iRDl5R0FUdjZtckxEbFl4QUNLamtQTUhtNktqOFRXZlNNQjVjNldL?=
 =?utf-8?B?T05ybm04bTRtU2R6dUp6WlcrNnJDK25vTk5iL25uUlFrY3VZQ0t3ZEJ5bUhz?=
 =?utf-8?B?SzNqRWJmaUNubm9kRnhtSkI3ZmExLzZLOUVYd1lhNWFHK2dTRm9OK3dzeHNi?=
 =?utf-8?B?Q2dXZ1g1R1RWdWg3ZjF0cGY5NzREc2RtSDUzZ3JuM3J5aFc4QUt3YlJxczVx?=
 =?utf-8?B?cWdjbFNxVDlIRHp5YktFZGQwZVJVSVB4UnhJak5FRWFhSTVhTVRxVWNkRHlI?=
 =?utf-8?B?OW5uT09Rc0E2cXJPa0Z1VklPcmFRb1JUZHlDUHBQRGtSZFlSZC8xa2FvNW8r?=
 =?utf-8?B?ZjlRQ1UxTnN3M3RKQjlVcUZzMzJiVWo2K24wWUMzdVhDL1JWN29TeUxvVmow?=
 =?utf-8?B?Nkw2NThzUUlyV1Bkc1h6Rnpsb293QmVKaGlCc1lsMGszQzRRRzcrUGFBRGtZ?=
 =?utf-8?B?WlVsRm4rdDdGSXliTlhsWEN3WTRmcWg4OVhwMGZWNzBVTlJabWRGcTlUcDd4?=
 =?utf-8?B?c0JQdGw2eE1zT0ZmS0lIdlJWQ3I4UmQ1bGNENWV6VXdXejZVb25WT0ovaDFB?=
 =?utf-8?B?WmRFZ1FrUDdTRWZBSkFYeVNmTGxPK2hSenlMaTJ0MWs1dHNiWmxQMDZ1Z0sr?=
 =?utf-8?B?ZmRMTTVJRzNVMUU5UHRKMkxkNEViZlJGOUZQUVlxQjF0S3lBZjQzejRNTTBx?=
 =?utf-8?B?WU9Da3NPSDhLcnN2eDVydWozbnRrZTFoR0NURjQyRVh5b05XSEV1UVFIa1BD?=
 =?utf-8?B?dTRGSHVpU0JseVo4UDhOS1JBUmpGS2hvcFRXOUZxQjZ6YUVVeWlJSXhWWlRG?=
 =?utf-8?B?Rys2VnoyL3RONE9VWnMvUFV2Uit3bU1OTkJUVGFHVHlvaldjZEJ3UXRvOSto?=
 =?utf-8?B?WlpyamZKOFNzRGVEQVZOemtGcDJQejlGakh6R2RzemlFcklWTDEzbVpnNHU5?=
 =?utf-8?Q?dbCRUaGA10LJ9CyLX3q/OlqZN2wAMmoYQJ5cJRZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8246e9-ba88-430b-e923-08dc537ba9fa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 01:16:18.1360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6684
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

On 4/3/2024 8:39 AM, Jaehoon Chung wrote:
> Hi,
>
> On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> This can avoid hardcoding a clock rate in driver. Also can enable the
>> clocks and deassert the resets if the pre-bootloader does not do this
>> for us.
>>
>> Currently only enabled for Hi3798MV200.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   drivers/mmc/hi6220_dw_mmc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
>> index 71962cd47e..a4b8072976 100644
>> --- a/drivers/mmc/hi6220_dw_mmc.c
>> +++ b/drivers/mmc/hi6220_dw_mmc.c
>> @@ -5,15 +5,24 @@
>>    */
>>   
>>   #include <common.h>
>> +#include <clk.h>
>>   #include <dm.h>
>>   #include <dwmmc.h>
>>   #include <errno.h>
>>   #include <fdtdec.h>
>>   #include <malloc.h>
>> +#include <reset.h>
>>   #include <asm/global_data.h>
>> +#include <dm/device_compat.h>
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>> +enum hi6220_dwmmc_clk_type {
>> +	HI6220_DWMMC_CLK_BIU,
>> +	HI6220_DWMMC_CLK_CIU,
>> +	HI6220_DWMMC_CLK_CNT,
>> +};
>> +
>>   struct hi6220_dwmmc_plat {
>>   	struct mmc_config cfg;
>>   	struct mmc mmc;
>> @@ -21,6 +30,8 @@ struct hi6220_dwmmc_plat {
>>   
>>   struct hi6220_dwmmc_priv_data {
>>   	struct dwmci_host host;
>> +	struct clk *clks[HI6220_DWMMC_CLK_CNT];
>> +	struct reset_ctl_bulk rsts;
>>   };
>>   
>>   struct hisi_mmc_data {
>> @@ -32,7 +43,29 @@ static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
>>   {
>>   	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
>>   	struct dwmci_host *host = &priv->host;
>> +	int ret;
> If CONFIG_CLK and DM_RESET aren't enabled, this value is a dead code.
> It also needs to initialize.


I think a alternative solution is replacing the if stmt below with some 
`#ifdef`s just like some unittests code. So we can mask variable `ret' 
out if it's not used However, this seems not favored by checkpatch.pl.


>
>>   
>> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
>> +		priv->clks[HI6220_DWMMC_CLK_BIU] = devm_clk_get(dev, "biu");
>> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_BIU])) {
>> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_BIU]);
>> +			dev_err(dev, "Failed to get BIU clock(ret = %d).\n", ret);
>> +			return log_msg_ret("clk", ret);
>> +		}
>> +
>> +		priv->clks[HI6220_DWMMC_CLK_CIU] = devm_clk_get(dev, "ciu");
>> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_CIU])) {
>> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_CIU]);
>> +			dev_err(dev, "Failed to get CIU clock(ret = %d).\n", ret);
>> +			return log_msg_ret("clk", ret);
>> +		}
>> +
>> +		ret = reset_get_bulk(dev, &priv->rsts);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to get resets(ret = %d)", ret);
>> +			return log_msg_ret("rst", ret);
>> +		}
>> +	}
>>   	host->name = dev->name;
>>   	host->ioaddr = dev_read_addr_ptr(dev);
>>   	host->buswidth = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
>> @@ -56,11 +89,37 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
>>   	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
>>   	struct dwmci_host *host = &priv->host;
>>   	struct hisi_mmc_data *mmc_data;
>> +	int ret;
> Ditto.
>
>
> Best Regards,
> Jaehoon Chung
>
>>   
>>   	mmc_data = (struct hisi_mmc_data *)dev_get_driver_data(dev);
>>   
>> -	/* Use default bus speed due to absence of clk driver */
>>   	host->bus_hz = mmc_data->clock;
>> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
>> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_BIU]);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable biu clock(ret = %d).\n", ret);
>> +			return log_msg_ret("clk", ret);
>> +		}
>> +
>> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_CIU]);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable ciu clock(ret = %d).\n", ret);
>> +			return log_msg_ret("clk", ret);
>> +		}
>> +
>> +		ret = reset_deassert_bulk(&priv->rsts);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to deassert resets(ret = %d).\n", ret);
>> +			return log_msg_ret("rst", ret);
>> +		}
>> +
>> +		host->bus_hz = clk_get_rate(priv->clks[HI6220_DWMMC_CLK_CIU]);
>> +		if (host->bus_hz <= 0) {
>> +			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", ret);
>> +			return log_msg_ret("clk", ret);
>> +		}
>> +	}
>> +	dev_dbg(dev, "bus clock rate: %d.\n", host->bus_hz);
>>   
>>   	dwmci_setup_cfg(&plat->cfg, host, host->bus_hz, 400000);
>>   	host->mmc = &plat->mmc;


-- 
Regards,
Yang Xiwen

