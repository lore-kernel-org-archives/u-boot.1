Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072DBC54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 11:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F649874B1;
	Thu, 29 Feb 2024 12:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZB4BZGMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BB487BE0; Thu, 29 Feb 2024 12:58:44 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7457787B7C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 12:58:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE2s9JMVvtsyEM2hlpSnCF7ZMv/uYb7292HziPbTMCQ4d/VY9O5A4C2wedl2H2Dezb8Pw0w4nZ5b528A6vXNHuWTiUHMnPoQFKwyVC4LQS7FBwka8ae4J9qUEX/81fUOuX7q0dIugRXjRVRp2/n3Yeuv7tTtP2tJiCclCj3aRwBJGh1w/U4TBJu9SJmr7AiWZeFLfBuVCgW2GVD0lZwX2iyeSCc1HN8GPbHmy1doVr/mPX2y+JyHs+jHwP7Vb3xXJzvqDUiiRDNwsqvpXv9iVNjZEIGxJ8+Y3n+a7j4k3Cm0rS4blfwfYDYyIjAiRbL3inNcGYrS2/Xx3cVUoAASjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2sP1z0eaR8JaNNcxqzZ/WdKNW4yvJA0qtCI7n9gl1M=;
 b=hbe2NSYN9kLEwvdnBktaAJWHC2QzPZUBq8w+gmlnTpdRt/7ybC29hWENXt/SkCjzOgM648Za+kGgsgeFF0VUEq+Bkp0NDzdNyE2uHXffDpbtG3wKpxk5+y1Xah8DBPgk4PwVzLo/B4DitBlqNC4JVTsl9OkCX7OYrkWLSfApzgCGQDZQ3H0tsQ1k4/6UOzsc9hvOcvyg2Hum1//Cghyayd0SqdQLVkue6gkt0g/2K9DwKvy/YoTgIPy9I93hitG5XslAhOuRFx4zhr8ZXs40m/bcG+9ErPewGLQnmsdv3ek8KUzSmpJD4eI05hR9UT/clWZmXTJcmk3Y4wpmZqmi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2sP1z0eaR8JaNNcxqzZ/WdKNW4yvJA0qtCI7n9gl1M=;
 b=ZB4BZGMzSqAdopcEpsHyGzA3j2VwFj4JSV64vC4KwqLZCoFdzDeN1yL+FUjsdAaJFkTFQp/JmjyOpOxezOjE97nWw4/qFxY5m9DGWDHXKIAd7BCgMiX2xK56Xyh4MezL47MBcdLGn06i+5axClr1r5MNbo/XVgxBW0vD21tqTTBUy6aiplI19q86T+0Jjcvs4RkyqNmnUzyjAZ1WjXXNLEWS0FkEdHV61gvlEIeSQlZuTkWZzSSooFu9O2xoqJmaMGKILdxafxoCD6IZgTz5v6TtKcDxw/MvrYjEYMFV18Voe5/OpLbQWgqOG2z2EwN92qejkaZarr+rlp76UsWqQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB9844.eurprd04.prod.outlook.com (2603:10a6:10:4c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 11:58:38 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:58:38 +0000
Message-ID: <b88234e9-2c71-408b-a722-fc27c81c356a@theobroma-systems.com>
Date: Thu, 29 Feb 2024 12:58:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] power: rk8xx: add support for RK806
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, u-boot@lists.denx.de
References: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
 <20240223-rk3588-saradc-v2-5-11c046b7e94a@theobroma-systems.com>
 <e792f582-3db3-40f2-8e9d-4a4985edf3f6@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e792f582-3db3-40f2-8e9d-4a4985edf3f6@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB9844:EE_
X-MS-Office365-Filtering-Correlation-Id: d733ffd2-7bb4-4769-93b2-08dc391dc3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjpLV/DPEcybuliUR0fxdySbZV1KilMim4eYZKEe/xRnej/5awIm18gnxOM29K1zvmc14SLzD/ajQvMwOdXrCg+k/zYjHPvG77jNe1av5bi8Vgb2CALwiFbrg3Ag248za9ky4ecjIwrYd2KWvI1/l1KyuWtRUbhM7SqQMKOHriAt14S9db5oPXyNYvyBqICKvpK3Yw8+z0P9DHlqRX/ruaRL8HYlTyAM//NPpLwjQoeBoef5fykxg7wqDkiO5vrdO1+u39fHCW7vmwTmO+tnmZBtvAzAc9suQq+r/C01/+XTng5IhBNvOH384+TnDSNpIvEsoWW7MDXZcEuJdAAKgwFFFiDjoMpQzdMAyp0imebQYjHFdOzI6wuOg+mLBsJUv4LdIGLwHktzE6iMkYBzGfMAJoa63LuHLhb10w/Ok5PJ3LOQwkmJruqRNvYC3H6on+gTUyqEO3LH74hYK+clb3hYdV9Zo0a9rcFutiEOSo31zCJKTBoIdYW+Eyj4y2P5lJ/audYhH+w5dp7edkThzGDse1rvB5nF8cyE4QteobG4UqmR3FBwqfBb3F3p/BmeKCk2hdS0tTHwEo7Z2aH77w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhOV3lhemRHUk5qL2ZMRjhhL2haRlZkVzB5dEJjMWVQWVNpamxraVNmQ2s4?=
 =?utf-8?B?dU16ejBOZWlVakpQeEVUeFIydU1YR0hIbTdMMExNZHREVVV0c0g5dGwydEZK?=
 =?utf-8?B?V2xLMnh5a3M5UHh5WkFqZitIbWZFWTdnOHBUYjlQYVdlMU9ZbGhMU1A5ejFD?=
 =?utf-8?B?T2NyOGZOOGlnbkhZQTNKV0MrenRIWStyWlJPS1dUckdjc1ovS0s2ZEZZL2Jz?=
 =?utf-8?B?TFNvWnJvN3Z5MWVpVlZHR1hZamNVMFptYitBK1QwQjlJVTZKTTI1cHoxT2xZ?=
 =?utf-8?B?RlkrNi8yRWZIMHpvZGhCeFB4QXN1dlNDZk9RQTl6MEFvWHNWTWY3eE8zR2R4?=
 =?utf-8?B?VXkxa2N4QU0vdGJqNnlLN0VQTDRrQ1dVaHR6T1paSlJJNGpMbkVJRG43Sk1m?=
 =?utf-8?B?YzlzMTRLZzNDTDNuY080WVpRNFBENXZIQkFyZEI2bHR3enRNQ25WM2hpckRB?=
 =?utf-8?B?aU8xWWlQS2RoUnFwMm1NK3ZnQzU1dlBjTnpNYWlFaFFMcm5pM2dEWndQcHFW?=
 =?utf-8?B?M0VBc0RCS0U3ZjBEcCtvY1VEWFRyeDNhVzIrdDJBQWNYNWlvR0IvSktidHJE?=
 =?utf-8?B?RXNOdk5oVEFxWGxPYkNHeWg5U3FoVVAvaUlpUm52ZzJyckdHM1Y3cHdIY2hK?=
 =?utf-8?B?ZXhabWo1ejBhSU1YYXFTYXMxU2pYQUx2NXlOME1IbGcvTlNXTnR1VlZ6QVdI?=
 =?utf-8?B?dE1sVGtjK2o1WmZacU13TTRXR0FieUtZSUNhYUwzQ3FlbDdINktaOFpOeWEr?=
 =?utf-8?B?eFMyYUxydFlrNTYxcXZqbFoycmtkRkVvaENic0xKbkdqMHdrSEJyaldNZitT?=
 =?utf-8?B?eDJKZFJ5NTFHdFA1SkR6V3BHUU5LdXhhMk40Y21JNEZoZEF1OWdKZCtYOFpz?=
 =?utf-8?B?R2p3dk9WVWdrK09iWnRLMm9FVU9CVXhibWRGWG9Dc3VKelhlTzhJR3ZPejRT?=
 =?utf-8?B?YUxXNEMxVDE5Nys4UkhEbnhlTmJVaHJZZVRGWVZGZXhibEwyR2VhV3h1TE1X?=
 =?utf-8?B?bkpNQVJqd2hJMGRKT2dZaUFkTGtTeFhJTzNjbUFBaW5hRXU0WjdmVDlTS0V0?=
 =?utf-8?B?QnNvWCt1VUJFTmtoWTFDdXZiOU1VRDdEUS9GbkJEVzFwbG1KVTlkSFYvYyth?=
 =?utf-8?B?d1lsdjYwSmdJdEVTRjcyNE1vWkFyR3RibHFPamdNY2p1M2l3UTVxNUIzUG9w?=
 =?utf-8?B?ODBIYVorZzJPSnVMZHhTL1lOWDR5aXRnVXpPdHQwSkZkVlVqVE5RZHpCa2Mz?=
 =?utf-8?B?dDIrR3RZOHVUVFVWenNBVFh1ZUs0enR0VUNYSlVhUHdUYmYvQTRMUTViVERX?=
 =?utf-8?B?Q1lxVjcyaGZzeXcwRERiTnR1SnB2MnA5Vy9NanhpNlZ0UGwvWUNMZWpLUVpP?=
 =?utf-8?B?TWdYUGRLSTFzYWFSQ09NaGdjMFpMemk1TEFOL1VQcGdrSENZWElLUVBwRWs4?=
 =?utf-8?B?MjZ0N1FXTVI0a3N0NXJES0hlWS9DeUZsTkNEQWp6cUUzcVdhc0h2bE1uRUIx?=
 =?utf-8?B?OGU5ZkRXLy9vYVhVQjZ4dTRyYVVlZWZtSTAvRXVjdVlENFVWUys4b2J1Mmow?=
 =?utf-8?B?SlFDbDNUWHRsVklRaUw4aklvMWdURGF0em5rOHkxbUx4WDJmZ2taS081eXll?=
 =?utf-8?B?UnZjUytRdnQrR0hSUGd6S2xtNkR0RDNQY2w2bkxaRStaZkJQdXlVNEM0c0xp?=
 =?utf-8?B?VTE5MXZCK1p3Y3MwYmYxakhIa29yUVh5bEtiMFBmREVUREZxclk4TFRjdEJJ?=
 =?utf-8?B?ZUdNaU85emltL1MvbTkwNk55QnFSeGk3aHZ0WnNYVU0rMDFrMFNibVFGMmpN?=
 =?utf-8?B?RnhwcHRoQ3pWMkZHVG12K0MwR2owUnhQNDRvbnRLRUVSc1VQbFdUekdLenJi?=
 =?utf-8?B?VnZQSzQ0ZHkzVFJvQ0ZxaVlYcnh2TGcyajdoSWU5UkdCZ213N0RFTWdROWJ1?=
 =?utf-8?B?QU56OEp4L29INERYQ2doUmkyN2dMRjJZQTV0dWlIcGgvby9kRDg0UnkrNkFT?=
 =?utf-8?B?SlNjK0JyN0twaDkyUlROK2xnYWVEc055SUR5WTBKeHhwWWJZOEw2YTVaUWpz?=
 =?utf-8?B?QldlbjdESmhaWHBrR2xIbFNHRm80YlNySTJDeE5VdURmeFdab2ZmbUc1c0Vy?=
 =?utf-8?B?NjNWZjM3d3BIUG1kVGhORHN1Z1FFTzVoVjdxUFYyM09vaFVVNkRmRWRjekZw?=
 =?utf-8?Q?nJ5fP7rnqe8DZzgf3MEseDc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d733ffd2-7bb4-4769-93b2-08dc391dc3fc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:58:38.6446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 598o+pmrtHpjAwZ6AggE2U1b1IAuweVYhIDc2KFpFMdRgqy6MqReoNGxqa8YlJNVfHti/yoPqqpa7pOnXFCVh6woAGtoeHo/WxFCRWJ4fuAZqT0Y8SfIX6PqYVY2uFFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9844
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

Hi Jonas,

On 2/29/24 12:47, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-23 10:05, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> This adds support for RK806, only the SPI variant has been tested.
>>
>> The communication "protocol" over SPI is the following:
>>   - write three bytes:
>>     - 1 byte: [0:3] length of the payload, [6] Enable CRC, [7] Write
>>     - 1 byte: LSB register address
>>     - 1 byte: MSB register address
>>   - write/read length of payload
>>
>> The CRC is always disabled for now.
>>
>> The RK806 technically supports I2C as well, and this should be able to
>> support it without any change, but it wasn't tested.
>>
>> The DT node name prefix for the buck converters has changed in the
>> Device Tree and is now dcdc-reg. The logic for buck converters is
>> however manageable within the current logic inside the rk8xx regulator
>> driver. The same cannot be said for the NLDO and PLDO.
>>
>> Because pmic_bind_children() parses the DT nodes and extracts the LDO
>> index from the DT node name, NLDO and PLDO will have overlapping
>> indices. Therefore, we need a separate logic from the already-existing
>> ldo callbacks. Let's reuse as much as possible though.
>>
>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   drivers/power/pmic/rk8xx.c      |  85 +++++++
>>   drivers/power/regulator/rk8xx.c | 514 +++++++++++++++++++++++++++++++++++++++-
>>   include/power/rk8xx_pmic.h      |  19 ++
>>   3 files changed, 616 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>> index 4e3a17337ee..15cb82029cc 100644
>> --- a/drivers/power/pmic/rk8xx.c
>> +++ b/drivers/power/pmic/rk8xx.c
>> @@ -9,8 +9,10 @@
>>   #include <dm/lists.h>
>>   #include <errno.h>
>>   #include <log.h>
>> +#include <linux/bitfield.h>
>>   #include <power/rk8xx_pmic.h>
>>   #include <power/pmic.h>
>> +#include <spi.h>
>>   #include <sysreset.h>
>>   
>>   static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
>> @@ -32,6 +34,10 @@ static int rk8xx_sysreset_request(struct udevice *dev, enum sysreset_t type)
>>   		pmic_clrsetbits(dev->parent, RK817_REG_SYS_CFG3, 0,
>>   				BIT(0));
>>   		break;
>> +	case RK806_ID:
>> +		pmic_clrsetbits(dev->parent, RK806_REG_SYS_CFG3, 0,
>> +				BIT(0));
>> +		break;
>>   	default:
>>   		printf("Unknown PMIC RK%x: Cannot shutdown\n",
>>   		       priv->variant);
>> @@ -83,6 +89,11 @@ void rk8xx_off_for_plugin(struct udevice *dev)
>>   	}
>>   }
>>   
>> +static struct reg_data rk806_init_reg[] = {
>> +	/* RST_FUN */
>> +	{ RK806_REG_SYS_CFG3, GENMASK(7, 6), BIT(7)},
>> +};
>> +
>>   static struct reg_data rk817_init_reg[] = {
>>   /* enable the under-voltage protection,
>>    * the under-voltage protection will shutdown the LDO3 and reset the PMIC
>> @@ -92,7 +103,10 @@ static struct reg_data rk817_init_reg[] = {
>>   
>>   static const struct pmic_child_info pmic_children_info[] = {
>>   	{ .prefix = "DCDC_REG", .driver = "rk8xx_buck"},
>> +	{ .prefix = "dcdc-reg", .driver = "rk8xx_buck"},
>>   	{ .prefix = "LDO_REG", .driver = "rk8xx_ldo"},
>> +	{ .prefix = "nldo-reg", .driver = "rk8xx_nldo"},
>> +	{ .prefix = "pldo-reg", .driver = "rk8xx_pldo"},
>>   	{ .prefix = "SWITCH_REG", .driver = "rk8xx_switch"},
>>   	{ },
>>   };
>> @@ -102,11 +116,47 @@ static int rk8xx_reg_count(struct udevice *dev)
>>   	return RK808_NUM_OF_REGS;
>>   }
>>   
>> +struct rk806_cmd {
>> +	char	len: 4; /* Payload size in bytes - 1 */
>> +	char	reserved: 2;
>> +	char	crc_en: 1;
>> +	char	op: 1; /* READ=0; WRITE=1; */
>> +	char	reg_l;
>> +#define REG_L_MASK	GENMASK(7, 0)
>> +	char	reg_h;
>> +#define REG_H_MASK	GENMASK(15, 8)
>> +};
>> +
>>   static int rk8xx_write(struct udevice *dev, uint reg, const uint8_t *buff,
>>   			  int len)
>>   {
>>   	int ret;
>>   
>> +	if (device_get_uclass_id(dev->parent) == UCLASS_SPI) {
>> +		struct spi_slave *spi = dev_get_parent_priv(dev);
>> +		struct rk806_cmd cmd = {
>> +			.op = 1,
>> +			.len = len - 1,
>> +			.reg_l = FIELD_GET(REG_L_MASK, reg),
>> +			.reg_h = FIELD_GET(REG_H_MASK, reg),
>> +		};
>> +
>> +		ret = dm_spi_claim_bus(dev);
>> +		if (ret) {
>> +			debug("Couldn't claim bus for device: %p!\n", dev);
>> +			return ret;
>> +		}
>> +
>> +		ret = spi_write_then_read(spi, (u8 *)&cmd, sizeof(cmd), buff, NULL, len);
>> +		if (ret)
>> +			debug("write error to device: %p register: %#x!\n",
>> +			      dev, reg);
>> +
>> +		dm_spi_release_bus(dev);
> 
> I am getting following build error on PineTab2 [1] with this:
> 
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.o: in function `rk8xx_write':
> drivers/power/pmic/rk8xx.c:144:(.text.rk8xx_write+0x60): undefined reference to `dm_spi_claim_bus'
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:150:(.text.rk8xx_write+0x84): undefined reference to `spi_write_then_read'
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:155:(.text.rk8xx_write+0x90): undefined reference to `dm_spi_release_bus'
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.o: in function `rk8xx_read':
> drivers/power/pmic/rk8xx.c:182:(.text.rk8xx_read+0x60): undefined reference to `dm_spi_claim_bus'
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:188:(.text.rk8xx_read+0x84): undefined reference to `spi_write_then_read'
> aarch64-linux-gnu-ld.bfd: drivers/power/pmic/rk8xx.c:193:(.text.rk8xx_read+0x90): undefined reference to `dm_spi_release_bus'
> make[2]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> make[1]: *** [Makefile:2055: spl/u-boot-spl] Error 2
> 
> On PineTab2 this driver is enabled in SPL and this build error happens
> because SPL_SPI and/or SPL_DM_SPI is not enabled.
> 
> The RK8XX driver is enabled in SPL to be able to quickly power down the
> tablet if it was powered on because a power cable was connected.
> 
> CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
> CONFIG_SPL_I2C=y
> CONFIG_SPL_PMIC_RK8XX=y
> 
> [1] https://patchwork.ozlabs.org/patch/1895031/
> 

I was investigating this yesterday but this turned out to be a perfect 
match to Hal fixing a light bulb in Malcom in the Middle 
(https://www.youtube.com/watch?v=AbSehcT19u0).

I will settle on adding some ifdef that should have been unnecessary and 
fix the actual issue in a later patch series because it'll be involving 
likely a lot of people and I wouldn't really want to block this patch 
series for fixing missing dependencies in Kconfig symbols :)

In short, SPL_DM_SPI is not enough for the ifdef because while the 
symbol is enabled, nothing in SPI will be compiled for the SPL unless 
SPL_SPI is selected as well... And we're missing a bunch of those 
(SPL_DM_I2C as well, SPL_PMIC on SPL_POWER, etc...). The issue is the 
moment I add a hard dependency on SPL_SPI for SPL_DM_SPI a bunch of 
defconfigs/devices will have SPL_DM_SPI dropped because of an unmatched 
dependency. While this is nothing more than cleaning stuff up, I have a 
feeling people who enabled those symbols expected them to work. So we 
have two schools here: it's been broken for years (for SPL_I2C 
dependency missing, July 2021) so if nobody figured it was missing until 
then, it's probably not required for the current usecases where SPL_I2C 
is missing or, they wanted it enabled and somehow it went through 
maintainers' nets but we should fix it now to add it back for the 
devices that are requiring it.

Cheers,
Quentin
