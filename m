Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C367DCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E03B84AF5;
	Thu,  7 May 2026 14:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KIztMPYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A840084A8A; Thu,  7 May 2026 12:15:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4AAA84A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpxzYkxEqcGTqyYW/0Mvz8DVlSNBig10zuM1/VhsIcgXcY3nBd1odv6eRN7ffdxc6oqA8ySo6BiPVs2U5nCWFT7B899s0O/10od8WLZShpAVTX0KoAeWIHifPOL0cFmO8GBoAHBrBM00UWsOB6g+OL+TYCgl0TslS9NBLqkMx9+64i/ZL4QDpuJs6BkvB5R9Y6IF359dp18Q+2IjIu4ZpW1t+iQkEYTzj1g/owBCv/nGl4Vt8oWscDTpWoCyPUYCYHv/4o9oGbb4LnO7QuNe+A3tJTMOJAgRP9i8dqU1KVAPLCbiaJB7Ol65lY/2q9LASBUaYSOFeeClw27SLCOt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWZiUfKSW7p1R2Y2lWqU1Udc1A+XFBaKuygtVAsmgS0=;
 b=Nc2Lptsp2YLTJ3R0YlcrbyR0J3b5VUjTxhDj7Sh+O305Rjz/W2NrLapTU2/YsJRVJWWqldsrBw6s1wOKE3HaR3I1N7vdZaPL0f115RH+ErC93c+nk/3A3OsGNpknKTBrgrkigWXDGI/xu1B6Ut0mH08q0/K/nduhmQ2FCLbrqkxyH9E83nn/LC0cAbX4q+NM3YQ3ZbdPymo1FNAtIb9DDB7zswmh+oBvbS3U6pur+KG6m0HmjRE12D9xYJ/TmarJ/xp/dV7JdyHQQNNltxUa/epU/I3K+39HEHalEh2kY+kWLFLiIrqQDsYHdheOP2KBAaxWolxbSul/a5LAy98mJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWZiUfKSW7p1R2Y2lWqU1Udc1A+XFBaKuygtVAsmgS0=;
 b=KIztMPYIsFaaLI/1l/iM+5cUH5bWC4O7NAEkebz5wxXwkPe9yiRhO8f14L+kyDW6kejuu5ZgaDSpyT+f9b9rHqcjEX51jUroEIM7IfaY/eFc006vYRPfPVIXZx644Jsv/OVi4GGcLncSXPBpbGs6eN3QPxkyC8Z4BQhcK6KoOio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:15:29 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:15:29 +0000
Message-ID: <fdd7ba59-231c-43af-a1d2-2a19c281b2c7@cherry.de>
Date: Thu, 7 May 2026 12:15:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] net: Fix alphabetical ordering in
 drivers/net/Makefile
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
 <20260429-add-ethernet-support-for-genio-520-720-v4-3-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-3-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbd1fc9-9fc2-43ff-d0c4-08deac219022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: q0YWoeldH3DYMTOy2riEIJtOUxYWS1SdHESb7kwJBYmJPbjemHFWkbZ3X09+V8wQUWIPTHQm2dshXVopvOF7DQsSr9UjaPGTZy82p3lhztwipJVc4YmAA3LCZB8q7AKG6Z+j89qexxr7YybkzSjkoGq9M7fNlSSVhBwz+i4k1wW9ZoyPHEVSj94JYfTpmAibP8AeQmgcBEbFajgIAR7R47Pm2CIu2AxrK6Sg+GvuQamUW9f8OcmzcigsU7dQD4iHsrXbJXlGA2dopi50GlLaGO/BydyPjrBzqrq39DBJmDwnm3e0rRlUwaYR+RAYu4eWARMnDClAbNEJJHdwifc+ows20hoAr2VWhZPXxVAC03dEf99BS+MZZlTK2kIqvcNUH0dpTtXGR7JBV1G87hNjjqUl4tQ1ykPuATyfDQD0qPHRS2WY+dgKRsfRXcmTEsCF61rtHB3bvn2TnFiDBirJA/Pn2fXRv8S/wFkp8JwXceAmCsDWJMUJC4YWawqt+7LsQDFQuZ32TbED9tgqwiu3CuurJO12qWTvlMLUxgaj5UCngBlCaUEA86fk8COMODlD9CGFy8wDaAB6SdXeLF7Vece8WzY1QG2zjxHjk1auJ4oiyL6dFJpydXQfQaTW5jwOH/HcxK6WBokJ0/3/nYD8NKm7olaXj0UV3NHo/1VZCbA/a/J0l0HPJSgqEGGfGZRY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU8vSzZwUCtVYzhGZ295dWJ3QlNwbXVuSzdCVTZEdnJtZndBY2VwS092ZVVC?=
 =?utf-8?B?VlhLaGZHamVSa2F6TS8rMGVXZUxhem4yRWJMV0w4VzZXbmRvdmE1L05GUFNX?=
 =?utf-8?B?NHlHWGJreVZXSmd3dVltamlKOGsyaWMrNktCNFJ3Vnhja0ovQVdqMHh1OGhU?=
 =?utf-8?B?MjJ3cDhYSE8vaVJtWTEvYjNJWVhJWlpOb1VZSkY0bFo3dU13Q2Ivd0dmRFdT?=
 =?utf-8?B?alRlQkcrTUhXNVl4bWFFdUg5UHUvTXA1akp2c2NsY21Na1h4NGpVVCt2ZnFO?=
 =?utf-8?B?dnZWTEpTSTlHOENpRDAzWloxeVZwTTlIV2Vicjg2KzJyMXhoWHZqUWxIWXFa?=
 =?utf-8?B?Zlc1b1BCaG14aEMvU0lxMFVNVGt6WUpVMkN1UHhoQlpGYjZhQkphSmFtM2Jx?=
 =?utf-8?B?cktlWThBNVl3dm9ONHRYMTBDclJPQUdFM05aWFZVbWNqdWFCMXhFSGNEQTRH?=
 =?utf-8?B?U05iZlFZOEZjb2Vad05tZzRySTgrWFhQU0w4azdzcWVzL01EY3ZnSWIwMW1C?=
 =?utf-8?B?RVFrWXNnVG1WWUw0bXpNemM3OWM3Ui82aG5IWTFzeTYzVTNFRkxRZVEwQzF6?=
 =?utf-8?B?bkFUWFVLRXRLL2lCVTg4eGh3YUwvRGp2TFBpSzV4bERBWitGZm1aVjU1N2wz?=
 =?utf-8?B?ZWIxQS9HbnlMNXZpRVdpU0RjRG5jNW5xVVJjS3FDVWRFcTNtQU9CZ0Jkci9o?=
 =?utf-8?B?QnJLa3VYNkR0Q2VTR25yNHhwRXA3K1JUODNRTWdZL21Vci9oMmVFMy9HQmda?=
 =?utf-8?B?Ymd6UWNqMUhpbXdUMVdidEp0OXcrd2lSN1U5TmJCZTVPcDR5ekxleU9tSENI?=
 =?utf-8?B?dEdRbTdwYVlqeUFuUkFRY3FocE9yWmF6VGtvU1hkdTFGdzB4ZnpQTE9sS3ZF?=
 =?utf-8?B?QnFSY2pVV1UzWkdidTltZjA4QXZMVmVtZnNMMXhaNVppcjdvMXRPRjByclNV?=
 =?utf-8?B?TEdmVG9FS0JmenVPWVM4bXM2MnBxbDZuT2hQSmkzR1ZRRFNDbUh1TklEaXVC?=
 =?utf-8?B?SERzeFVaMHdMN3V5K1RmUzFTNFhoUWR5NHE1cXpPUUVrOWlBNGFNT1hXLzdh?=
 =?utf-8?B?RE9oYUprdHUwcVhLRkdra1BhcG83NWhkbDZpdDhHcE5BdWRwNnRVL2gzRTJx?=
 =?utf-8?B?RWM1NnZHbGxSTVlGV0ZpZm0vcTBoUnUrKzVOYmxqVVFTek5YRkdIb2tqSjE4?=
 =?utf-8?B?emZyQjRSeFlUQitjR241N3pGeDZzZTNDU2x5NHA1eVlBbnlhQTljbFBaQWt3?=
 =?utf-8?B?UUljQXczZWZmd2t2K3Y0Q05ybzNWK1FxZkI4aUFqV0VqcGJZUjJOSFdKYmxV?=
 =?utf-8?B?cTVVUnRFbm1KRkhmcHVFYjRqVGRRSk96YnVsTkIxZ2pLM1JJTGRZbElDSE4y?=
 =?utf-8?B?WVhLVU1qdi9XSmQ4eWI5S0ZYQ29ILzV5eWtkUWhRTnhXQWROVEk5bkRFU0RK?=
 =?utf-8?B?WjgyUTFXNFVrQVNaY3ZXRnUyRGhOUWRycXVmS1VyU012di9aVk5uNmVka290?=
 =?utf-8?B?Q1hqUmpDS0hpSmlMYWJDdEY5MXVkUXllQ3Jra1RHU2E2bC91dDhxcSthbkZO?=
 =?utf-8?B?cGtIczl4a1hOcW54UFMyM1BrTVpLZHMzN2poNGRvblA5RXZDNkRxa2w2TkFD?=
 =?utf-8?B?eHNUaHpRcnA5VjZGalZ0ZitSNng3R0w5emo1aHU5b21sS3ZXL1J5QlQ0ZjFL?=
 =?utf-8?B?UU5Tb3BtMENrTEg2WGdMWGphVDNSV1NERnJYNDA0bDZMWHg4b3pVdHByZkZE?=
 =?utf-8?B?WUVOYjQ3azdEN1FCdmx4S1JYWThBaDhPNkF4UnFEdXJRT2x1ODFPQk16UFhJ?=
 =?utf-8?B?ZTR2WVIyUDdXYkpSSDhPZ1kwdjBITjNlL2lKNGJuQ1FZNkkrRTMydTBRU1pC?=
 =?utf-8?B?NW5ZUXNEYit3MXM2WVY3dnQ3Ry9QL0h1Y0paOVluNWlaTDJ0SnNPSXdDSVZN?=
 =?utf-8?B?ZWx4WHFZZ0xmejdURHhsa2krcDdqRUdCSzR5R3YyUTJVVWV5T1g1c3lBQ3lv?=
 =?utf-8?B?clNTSGZZZEFZWXNOQmhsWEpEblg4MmNFTG1kdURVWjk3SndhQ0gxdHhHQndk?=
 =?utf-8?B?dzB5TSs4VDR2a1BsdnNHdlZCK1B6TFRFcHNTNzlTei9CWEtkV0lIZGdZU1dM?=
 =?utf-8?B?Q1poS252TGlVaG5RQ0czMEpOTG9rYXZuT3BRNXAweVVST1RiZ1NHbHIxSzJK?=
 =?utf-8?B?RkNaejRKaDY5dXlFZTd6a1JrVmhSUGpCYllrNVNwaTlDRFVpYkwzbi8rKzBQ?=
 =?utf-8?B?UWhWMndKNnh4Y0RjQWF2THdZUkxJZ0FSVGlUeVNTaEJDV1ErSkJ1SU5VWWJ0?=
 =?utf-8?B?TVZXZWFFUmlYUDRZNlJUdk9zVmpnbmp2cXA2Y3hwdDJPUVNYeFVuQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbd1fc9-9fc2-43ff-d0c4-08deac219022
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:15:28.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EulhdzRMG20A6Jt1tX2ImWUsFxl5WXq3nSJ/+vX4CWHkDh57EO8r2vVA1sz0P2bHj0lEcr24EDCKDQ0epCls3w+EPd0W4Pf+mk9cgxMZU+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
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
> Reorder entries to maintain alphabetical sorting by CONFIG_ names:
> - Move CONFIG_DWC_ETH_QOS_QCOM before CONFIG_DWC_ETH_QOS_ROCKCHIP
> - Move CONFIG_DWC_ETH_XGMAC after CONFIG_DWC_ETH_QOS_STM32
> - Move CONFIG_MDIO_GPIO_BITBANG before CONFIG_MDIO_IPQ4019
> - Move airoha directory at the end
> 
> This ensures consistent alphabetical ordering throughout the Makefile.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
