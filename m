Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952D2CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E679984B2B;
	Thu,  7 May 2026 14:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZaWznSsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C9B84A7B; Thu,  7 May 2026 12:22:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCEAD84A37
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTycooPASVSBAWpeX1pZeBlmYu7qWPg8Q+bmcZorxJSbnalNK8T9rMYK1M+EgElZK+aWkFnu+GzIcaxjSDRIepKnVu9F1C7XGFMGqSzmgcKDvd5mB5Yy6N4XRVUMgFg0mkWsUUknS037HZurlwRdrv+Vdx9iSwYOofZ2JA90eWOyDwkrUU9puo+NqYHti0vYq29fgQAp8d/qEWDNptYGWu+GLLAGdAvl0tlxRFUJ14ygGpmrFhVhVZkWnhslw8FK+LZ4IDRB5rYiWHWvR4ILnVfLRZzMOu8LdgkQyEVdrBlv+z7HjHw95zIc65puSPIy9zTuFrMUR3tqO3PM5NiOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+XFrZsMY+jpg5cGxKfHT08N+s+HUNlRUDi5N13TuhM=;
 b=cguvi+NHitYt9nFTqoNH8D0O5NVoyiC9kcS3DsyMDw1JJ2LlbgAl2sBh0tGjaRRHcKPl8SKRPYqw07wIUAHBKV0TKFFk6ZkBYk7AnXQAWq+8RBHhsFZK6lxXrRJEatzxpZioLf/HW5UA5eIrZyWTaE39QGYBD2zCVADuFjqPJ3C0VhI7uEGW96lKLb1Q6UtfFsFMZS1NRijfFHhV5rrQHM2QjTTGO+HjAThkV6VbOwCis9LU0tgHxH0gXKvLYdRzf/dmgLzTNrBPQGY0MaWpt8nH4EoPVAAlk4FFNbbg4/nmKcba6r5nYhhI9pwTThb2qSLg5WRKRYgTRUaRVd31Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+XFrZsMY+jpg5cGxKfHT08N+s+HUNlRUDi5N13TuhM=;
 b=ZaWznSsOUa2XFxA6lbFuWFiAVfirkPy1KyEBllcHTPbDqardlEODeyVccO5nKZHoJeBImqYKwuemnUKaTsDliuXzUHu0yP5+wacB39JsE6hBCYuGedJCKcFIo/z/aVCQNc4xeAWOB+/9A84Gj5horucOnGr63yiBsKS5je3W5nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10152.eurprd04.prod.outlook.com (2603:10a6:150:1bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:22:26 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:22:26 +0000
Message-ID: <a76f72ff-a520-4ff7-87e2-48454ddb4842@cherry.de>
Date: Thu, 7 May 2026 12:22:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] net: phy: Add airoha AN8801 ethernet phy driver
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, Samuel Holland
 <samuel.holland@sifive.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tommy Shih
 <tommy.shih@airoha.com>, Kevin-KW Huang <kevin-kw.huang@airoha.com>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-6-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-6-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10152:EE_
X-MS-Office365-Filtering-Correlation-Id: d25c6b98-d719-4dc5-c8b6-08deac228909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tkp4AOnrNZqvw/TQU1F0SJr+ipwuF1x4XEo35my7irx+GyD4iOsW4Z8vv05ySeCHK6/7Kz0KmV2K6lyBbhcIzimfY6vYSdqNq3ezGs2MWh/MLkRfD/H7MrZrZODkYYdyzEQf6ISh7v0wrpzLgTPlv9aX223R7BE3atIGbd5XKRsL6ZQ7mvGc0T7SwM11Riv49Y7+qS1B8e3wJ5uGL37vfsbt/LeG4LHbpCREL2g50jGogMLlcuvR2dwt3Gk6KBYzGLWxCd/SarrlWrijMuTu9AUfWlwRawQ9TdxIjLN+lJHTjUZImdOQpzfF8ZR23OVIPqMGoaK10/7q5tPOgIXO8tskIjIvsawY+Sd+jlngAzkjPIfqTK5qKsdJ9Ldjk3GqXBm/fyFjYqojj56/1stps/o3Zc6zKx5u9r/nS/5ijBtM/pTmFinBCn8cz9M6gFqE4gVOfSCYvf9kHWNX/z2PIzR5zGV2566y7X8lyE+44aaLCQ3AV/v5U6oVz21elLFH+U9/+e0G+yZWjNulrT0XLFtJ2VYohX539V6z3C2sxO3f7PbT+wwGDeKaCMSDBiTpFcNlBGNsYvjoCU5m6yp3qihvyb+H48eb4bCOBaNE7KjRczwWUOpE/yzrMnRbALAWbrBMVJeMo/wxM/qzWJLfnVQUhv2F8AdOxtBegFVulTB60Qjm4lrYu9olLLollm/i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFLSlJ1TGNpVXpPTHdVMktobHJRSW9kbW83cFV2bmIrSUxSeFhhS3lsRWtX?=
 =?utf-8?B?UzloUjhabS81a3ExQ01oR21FWm96dElpUHFRckhEbjZjSFlsYjJsNzlSYWN6?=
 =?utf-8?B?eG4rR0xyaUFORWF3VVhVcHpIdllzOG5KR1NjWlg2OGhCMDQrbDZyZzdYQXd2?=
 =?utf-8?B?THpGL3FjSWVXNmlFQUYrc3gxTWRHS01jUDdqRTY2Y3YyNG5ObFovZ3FsRmgv?=
 =?utf-8?B?OW5oRmFycUZqa2xYa2YxT29mN0pMWmxKaTlGYWo3dzZRdWtOWnFwcG9lNFIr?=
 =?utf-8?B?TkhpRDBkYml3WVVuNW1vUWcxeGtXbERVK09FYlNXT3BnM1NieHBMbUErbEUr?=
 =?utf-8?B?Myt1QXJwQm84RjRyTmxwMzRHbzMxTHRXYnlGRlpHTkhOb2ZsQXdoM1gvanNP?=
 =?utf-8?B?eGJud3JtZmNQeTBxd1hTTTA4NUtCeStWS2tzK1VBOVFjL0F5NFgya09NNUla?=
 =?utf-8?B?TTF5NkVFZTFzcTJHZE9JQXRma1YyOWFJVnFTc0hsOEFzZ21vOHBhUUVGNjlD?=
 =?utf-8?B?dkJXTFdCaFQ0TzZsdXk3V0oyclhKZjZySEVXYWRvZ3VUNHVXdTZBL1lMbXda?=
 =?utf-8?B?SitnM2xld0NDOS9jTkE2ODd5bzVIL3JvR3Nzc29aQjlLaWYzNVE2Tzlpbk0r?=
 =?utf-8?B?Wk9NRGVmS1JvWENrRGl2eCtxaUwyMG5ocXhJOXZCTm9ucCtkaER3SHZWNmh3?=
 =?utf-8?B?M2R4Z0VIUmFDVnlYYVVwbW1qSG8rTmdxejNwL0lUR085WlI1cXh6aWxLVGx5?=
 =?utf-8?B?dUhPYnlSQUpFMkVzUk9DVnlBeUZuM05QcUFaTVZ0M2o4aSswbFdneExzV0Mr?=
 =?utf-8?B?YnhWSFBwZWRsNkFHUnNMT1c5ejViNUlTZWVPQzU2c2Y5N2x6dy8zcysyRE0v?=
 =?utf-8?B?bE0rd1ZwdzJ2WDZ4K0IzMU42KzJsdG5tQVMzMHpXRDdseFdGaDBKMFJyTk1U?=
 =?utf-8?B?VUZ3blkrOU5GR2JGMHZNZkxWWVI5Zlprb2dRVGtaQjF5Q0VaejlvTnl3ZlZU?=
 =?utf-8?B?aW5rMGlIa2hHaUJZS05td0Fmbmt0cUdZTGs5V1NCUFpBYzdEcnZmbkl6eUNC?=
 =?utf-8?B?QU5Gd3ZHVUViaEFDd0I1cWhkb1RhaUQrWDdZYUZvVUVhK2cwK2s2YnUzM3M2?=
 =?utf-8?B?SU5NY21UZE00aytOY2ZYak1ORG9Wa1l1Y0cyMzJOeUVqQXJNcWN5MVpnMnFj?=
 =?utf-8?B?WlNBUjI5NWpneUt6czJ1RVFoRElSc1N0ZHV3VlZva3ptUXZiWGJnOHRXanQy?=
 =?utf-8?B?MnE4cFJwb0cxeG5XWFlIYTdQdjVHdmRvLy8xdHNWVnRjZ0hQVXA4b0NzK2lq?=
 =?utf-8?B?bDV4VmZrSDVsMDlna2xZNEIvNnpWSDlqd2pPQmY0eGVPRkV1T1ZIbFdKTy92?=
 =?utf-8?B?aW95RWp3WlE3L3BHUmxOeE0rR1JmenBGUmRsZytWZ3ZDT2xia1JXR1JtK0xk?=
 =?utf-8?B?RUE2WlFOcWVPNDhVVlpVOEp2OFZwcHNCWFRVQzg0WHJ1QlpXZUVoUEpwa2VC?=
 =?utf-8?B?TVRWd0VmNjZpczdveUJJSW9JRU5SY1Z4TTBjQ29pbU9BOFVITFg0ZXEwVEVh?=
 =?utf-8?B?eFBzVGZHWlVNWkJsVEYyaU5pL013eGFBWUxvNzh1SEVEVXF1LzFHbGJLYXFu?=
 =?utf-8?B?L2tqSFR6ellTQkFkSWxSVE9wTDM1c1N2VEhTeWo0eEIwRjZ5WGlMSEtvN3JX?=
 =?utf-8?B?MXhCaThsUUxDL1NXcjBiTGlCcTIxemFWbndIR3FOT1ZGbHlPNEdjUHBjWDZu?=
 =?utf-8?B?NmJWTno2MktRckZDalYxRVYrSFJIcGR3b0s5M3hXcWlZamwvK2F1SjJtdUVB?=
 =?utf-8?B?SGdwU21qT1ZxNjQzU2RXVmt4cDVhMk1sTVhuTTZ5NE5ieSs0TzBnL0RaNEpo?=
 =?utf-8?B?YmwwQUVONStZaGwxbmhRU2Ftd2l5WXdhaGpxbENkb2hQRjJuS2twMVovSmFr?=
 =?utf-8?B?NlVWNFdBakdzRE0wMDQ1OUYxTzNFKzBDU2dLZHVYYWRqbFBtVzNTWlZsdGVs?=
 =?utf-8?B?bUp0VHVzd2ZxNmYrTTk4ZExiRUdnb3JhSVNkbUQwcHZ0bDMvdURVMG9RMEZQ?=
 =?utf-8?B?MWw0SHJlbkpZajU1KzUvQXVGZzVlalB1Z1UwZFJFeEZPbXRBZjhmWVptQ1dr?=
 =?utf-8?B?Nm9TT2NvVFgxM3ZDZm5xZHVjVHFwZnJSQlNpekNGa2xxNStJS2tubWl6NDFy?=
 =?utf-8?B?YzZZaGhlSTR3VEdkaXpnWGFOSEJQVTZyczFtN0o3dXJ6endxZUhRVzBwcW1y?=
 =?utf-8?B?QkpTZXhWQ1BsVWFrOUhVaStSd3lZQVo0ZEp6UmZiK2dtS25qL3pEVldYdnJ6?=
 =?utf-8?B?TTFzQkFWemxUamx5VHNNSFUwWW5VSDh0WmtRcWVmRlpCWkVxSDRuZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d25c6b98-d719-4dc5-c8b6-08deac228909
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:22:26.3001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paWDFJPy2iifGJ9kSDrtJv5jTlZLWJQyUpOkmtwI4UywDcZgV47kj+I5DHgSpDrWNJKP9whLP4edMCQSfo/BqrqjSxrZlUi31POozAbbG/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10152
X-Mailman-Approved-At: Thu, 07 May 2026 14:04:29 +0200
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

Hi Julien,

On 4/29/26 3:58 PM, Julien Stephan wrote:
> Add Airoha AN8801 Ethernet PHY driver (air_an8801.c).
> Implement CL22/CL45 MDIO access, LED control, and RGMII delay
> configuration. Provide probe, initialization, LED setup, and status
> handling. Expose DTS properties for clock delays. Register driver with
> PHY framework and trigger on startup.
> 
> Signed-off-by: Yanqing Wang <ot_yanqing.wang@mediatek.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS                         |   1 +
>   drivers/net/phy/airoha/Kconfig      |   7 +
>   drivers/net/phy/airoha/Makefile     |   1 +
>   drivers/net/phy/airoha/air_an8801.c | 594 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 603 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 735ecc36210..165994cd72f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -60,6 +60,7 @@ F:	lib/acpi/
>   
>   AIROHA PHY
>   M:	Tommy Shih <tommy.shih@airoha.com>
> +M:	Kevin-KW Huang <kevin-kw.huang@airoha.com>

We need Kevin-KW Huang to publicly give their acknowledgment they want 
to assume maintainership.

@Kevin-KW Huang, can you reply here with your Reviewed-by for example to 
show you agree with assuming maintainership of all files under 
drivers/net/phy/airoha?

Cheers,
Quentin
