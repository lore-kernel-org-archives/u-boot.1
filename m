Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261DBCD128D
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9031088377;
	Tue,  2 Apr 2024 16:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="IAuZuGYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF3A87E89; Tue,  2 Apr 2024 16:44:27 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CCC88050
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I95J2jKv5oqmqhmzr64zyxVcMPRG97KkseTxaXkq0vz7vULLZ8sr3IPN8jH31PEzOX4ehjwZsHv9czd5IvvHabV+wlwmD9+T1/yIhGzL4qmGJONKrwTd/30AMMW+2GnY9LE4lxwsTep/pl+EPg3SXwufUosbYDyVvBFvJAWMixSknZiNxF5Xhm1n0Mc/ne0ifM/PNynQgI0lLS6EWdS2WZSdwk2IAhKTtNoxwQ2Ig1bSAlk4cxHi9u7Sbb/0mkPHM2gqq6iiczuxfnLxpcEECffdHwahkIIvjYNWdReKzFz/f4T0gDRb3Ce7I4enlxyj7poshlxjf/PBS8+M3OK9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNDF8auLjoN8WJT8VCZg0+r1KanJ1+1eTc/p3gWxrLQ=;
 b=C91pr6/wgBrbZuVmUtZZcdkBIAJcGzr1Jh57ch+V6Utf+ngu0HA+VTvU7b0clUAjRy5FTikZwTtcfhd2xZk711dwDcbZitBMntkBv+xr+li0dKBOVHSM9D7lVPS/F5zDgi6p70kXXcLg9s0Kwt+A8d+lVsJxbRbLCzcp64eH/DxzMkhQ7LCiKcoT+FRT/pHOFTiESFOGdAcyntWbMKot3c1DD0H0XkUNMzZjd5aAHdghytoppcjHhLKBb4+KMVDonZVjkW6C34WUlxdnKOp8uTWXdVdus263iq8ZTk1ImsZJ0MR8TQhgxCEH4jaYPNC52nXqc2jJhxJaXJzzf++BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNDF8auLjoN8WJT8VCZg0+r1KanJ1+1eTc/p3gWxrLQ=;
 b=IAuZuGYnM7lOFg7+oaUOExQ2WmxLZ5XEz64nvDoR+dAUK5Q51H8szJyFWFg8RZ3FfJ7Cqx+Y/P1tWQu/9JX2Phq078hv1t9JSLlet7PNeNdXpQIyg7BHqIDcPdAt0/JNpS0AtkULjgE0diftRfMHUKPW2k9GnMcG73BxWabOZ+AYV2Tbth7nVqqIA5R/E0ICcDAjWjssn5nE2JzY7N+jzNwsyPWv4y9vkK/bQaIJGFv+M2orhvAltbp8D1did1RMPQ1a+8V/PtZxOuc97o2SyfVr/LFSmTSzP4P3m9TxWe6L5leDBrSW2xRSuxAjARVQsDAYQsf1bvqmui7JKB3Nsg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB7926.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:44:22 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:44:22 +0000
Message-ID: <e8868088-3862-4110-8aad-081babde9855@theobroma-systems.com>
Date: Tue, 2 Apr 2024 16:44:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/31] clk: rockchip: rk3399: Add dummy support for
 SCLK_PCIEPHY_REF clock
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-14-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-14-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB7926:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u65VYhy+AoyCxAVSltos6/RicCp3JSxuXxaLEFkVWzQ19AGpjDOrJZZNIk/pF2042tWxXwv1g/p45oHZgImRh7zZ/Qlgaw/G5wc+tpsfFf0vxkiZTvCkwS+LEpBKOsdN1P6vZMIoPXmqqFhbVy6DjQbJ2xlPPs8GaicGrtU+Z+6oW91qOilDtvu8jkcNGMO92QRWtge1zDaOf64oYltF+a34cGiptU4EavLC/bfEPPjBpDEfSM1Y/988JL6gmxeSIIOiGlsBGpu5vDFFJ+n6/o8PQ6KPxST7bKrSW1Bz5HjjuaRE8/GUSnaCG5/plYK+UnxSzaPrf1osxEOwSDfNZGnfhz7PgbhSikV/hwmDbzsaNKI9ShELlOjjHXYCfqyzl7qm0CCZmP+M2KK/fSS4ezKN48gDj35ESLM8pCFQbSr9lBeu1fjL9Fg4ofiODQ1ltcoNEaUVq56lWbX2zfg93WxPtqubRgt1e6deoNWYc0YcQOeSDxkjFbbmbhIdUzNb3ld6SDBwIaXijMFL3Q5SJlTqW1+G6lQir+5i1nAw5yPAXOqv+AL+Pkh0idiH0CV3uak6HaAfJHyZ6afqY78KHTSsrpvU2ghwjQA/2JHr2I3w4C5Iq6TMMurTjLOM8gCz1XXU2z5qEqf4j8vW/jV+9Mj0JZAGfcYyeXvCjRpt31Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFE3bVhDSVBnU1JUSjJlNHBQM0J6WEZ0Zk1vMDdOV3lGVWlTNHIwMi91TWQv?=
 =?utf-8?B?RnNxa1pxdTRLSGxTMUJIMzNlTEpLdTdpMEVEU1R5UG9tc1c2Mms1aitUZGNH?=
 =?utf-8?B?M0RNY0VVdTlpYkM3Nm0zSmhSOTZKVTdrUVJ4ai9jZERwUEFKcEJKN0ZyZ0VW?=
 =?utf-8?B?VTR6b2xQRlZEQzRMUDRSSkZyTDRFVnBVVUY5cnZmQ1JLUjNITitPRWlybnZQ?=
 =?utf-8?B?eC9hT3NWSnFtSFdUancvY2tWa3FPenBOOHlyRTkzdVpyZDcxQUcvSzV6dm5j?=
 =?utf-8?B?dktoRG5SSk80UFZ5djFubXRmb2VFN295NFVIaW4rT0hNc1EydUIrajBKekJh?=
 =?utf-8?B?TEZNcUh0aGdPRWc5QlNCYW5NMkErZHlxdUJSc2ZKWnVmNVVEWWlTV2w4WFBx?=
 =?utf-8?B?QVpYTXB1OS9KenZFemJ1RDJKT0Z1Sk9Sd2lkSVduTmFkOXNjbWkwTnYrcmI3?=
 =?utf-8?B?aVUwRDR3RlQwRXhmbStZY1hIbGYzL0dpOFplMFZwV3hmcnplc3M0b2NnN3g5?=
 =?utf-8?B?UFkrQTNIZ3BkR0xsQ2RDVU12dXRubTZ3Z1E5UmhKQnNGZE1DZXNJb3ZsMy9v?=
 =?utf-8?B?KzFnVTAxeU5neE1XUGxQeXdURU04citCamE4YzRuVmtDRy9xa0pBYlZUUzVS?=
 =?utf-8?B?Z1F6dTBzaGRSOGk4MmxLR2puYWErOTdMa0xpUmF2NWVjWm9CT1pmWWxVS3Y0?=
 =?utf-8?B?T3YzYTBLNE80OFJnU3RQaWxmZkRGaDZucFYwaFJiMi9uNE9tMXN3T3VnenVw?=
 =?utf-8?B?d0QwdmNTU0J1b2V5VkFwV1NuMllRRitGdjd0OUV3Q3dEZjB5VHRqRWc4ajVv?=
 =?utf-8?B?Y3JUV2FEbVZaa2N5ait3UXdWQXNuNXptekM2VVlzSjJnZGRDVFRzc3NJSUgw?=
 =?utf-8?B?WG5idmo4MFBRU0dCMi93ZFVqZ0FaQXJ3THBZZnRGbXRiaU5hZU5XTXdlNFg0?=
 =?utf-8?B?ZlVOYysxSkpUdjlLR1B0emFBMllWVTdGeCtWK2hNZy9FQi9rTVdzblMzYWE0?=
 =?utf-8?B?THlVWERta3cxVVRUSUg5YkZMOWJmcnF5NEZFRXRnY1VYQS9wNDZMUEpiUFJI?=
 =?utf-8?B?eHhrc1QreGgwOE5ISXJhbVgxbnN5MGRaVndHa3FKaG1yUlMxUjFQbXhZamZi?=
 =?utf-8?B?RElxSk9vaTJpUTZkbkZWTUVaSVVSZW9GdHF5MGRJYm4zNGhEUm9YZEV2bTVQ?=
 =?utf-8?B?ZzdYWkFCU2hYNEZQTTVtZWpJQ1UvckZpK1BwbklnK0QwSUF3Q0h5R1VTZVRp?=
 =?utf-8?B?ZkNXWnFGT1RvL0hRNXcxaHhnYjQwY0ZtVkFRanQ2MkNZaVV1NllXQXd1ZGN1?=
 =?utf-8?B?MzBVNXZ2bjl3bXluM2dZclM2MlR6TTVBZjFEdTc5QWxia0t5dkhrQ3VXbDA0?=
 =?utf-8?B?bFFyYzA1N2FRY0JlbkQwSXViTHZ6L1gwUm5KSXl6TzUrZFBTLzhqVzNrbjdK?=
 =?utf-8?B?OGttcEptM3VGaVAxczI2eXdQRllNMU5sSi9VUXpUclozWWQrUncwVWNFL0V3?=
 =?utf-8?B?Q2YrTlZ2cEw0c2txWGYwOVU2OC9BSGs0WUpSd2NtdytBWlV4M2cvTWFwc0VS?=
 =?utf-8?B?YXU0V3hMRkRhTUMzVW1jdDBTeUFFZnFucmxDYzBZT21CNmxqWlVwWWFSeGs1?=
 =?utf-8?B?QzExZ1pvWnJDK2I5ODlTYTI3TDdGRSt5ZXNjSnJpaHVTQXhUdkRrbG5RelpT?=
 =?utf-8?B?ellLOUM0NnllbWtFWk00VlZEZmFnU25UeCtZMVdkcXdTalRMR0N4RFJxcy8z?=
 =?utf-8?B?aHo3eWVpem9udG1YZ2w3VGc4LzBhZDhweHozLzN0Tms1ZTFrZGFZcjJNYVN4?=
 =?utf-8?B?MWdtckVTVWpzNC9PZ1Q4YkR5UU5tdjY3dGF2cGpMOHN4bjhLZGZQaDQ0a0Y5?=
 =?utf-8?B?SzFPUDlBUjJPdlVBcE1xKzZEaEpkRE1jRU9TOEFrMmFPUUFyOTZKSEYvWmtV?=
 =?utf-8?B?Q1F1SldFU0NvNUhkMlMrTU1BNjJHSkh4R2pFTFc3RXEwUW52bzNXeFpKRk1P?=
 =?utf-8?B?eG9QRDBZc3Vpcmo3elg3VGZtWTNoMmw4TWx4ZnhZOGVETHVPSzNvRVpud0hL?=
 =?utf-8?B?TzQ5V2RYSnpWNGpZaEcwUytVaFE4MUVrZ0UxbVR3aTZRUk11em9pQ0FDbjg2?=
 =?utf-8?B?VXhrQ1FtNGxnNVJ2eGk5a3paZXJ1S0RjMXRWSE5kVk5uZHRGYm5xVzluWVdG?=
 =?utf-8?Q?w5BBt1McDUgQhb0vUYnIAFA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7a82e3-5862-485d-add8-08dc5323627a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:44:22.7305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuNJHmdjAoyood2cqmCv33MPQOvK6xbyUxW26DDzi5dVsPku4uQqwIBUeqjw/kERS9i8+OPDe2R6EebYYx5URgwSI0ww/soS2OCqHyNGMY+1E92kPl7zmfH3rkx3Pt6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7926
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

On 3/31/24 22:28, Jonas Karlman wrote:
> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
> SCLK_PCIEPHY_REF clock.
> 
> The existing enable/disable ops for SCLK_PCIEPHY_REF already handles
> setting correct parent once the clock gets enabled. And 100 MHz is the
> default rate used for this clock.
> 

I'm not sure that's true?

If I read the TRM correctly, clk_pciephy_ref_sel can come either from 
clk_pcie_ref24m (the default) or clk_pcie_ref100m.

enable/disable is actually only ever writing 0 to that bit (bit 10 in 
CRU_CLKSEL_CON18) and not even enabling the clock.

Assuming clk_pcie_ref24m is the 24MHz base clock (which seems to be the 
case according to the Linux kernel CRU driver), there shouldn't be a way 
to disable that clock. However, if clk_pcie_ref100m is selected, one 
needs to enable/disable it via CRU_CLKGATE_CON12 bit 6 (enabled by default).

set_parent should be properly implemented to handle this parenting and 
enable/disable fixed to use the proper register.

Cheers,
Quentin
