Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0692CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E103084AE6;
	Thu,  7 May 2026 14:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DM7vB5jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882A284A8A; Thu,  7 May 2026 12:13:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704D884A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIHn2TdvKcVM4HTiGL2UIPVdQ/4pNia4Ryocw/U6voCunGIHLalB7kVUZ+bRrxndUAdvIOt5rV6hp3YBhN+ihZU0pWnE50B2iC/9kgtuTgGpCMyDrMrXh97GBw3hSf/FhKLkIjHVQCrFZI98h8GIbq3nfErCtVIalUAMhlOWcapd+JRvVGQcw/Qgt+wjASQpIw0n9senhIACyubZBjiY7+k4xtFz6qLz8EzjnaJ68DY+Ada+87h3kIl10stUGwYmnjJqIwl7euNJWTUwlihPaq2wEBIfoBqRjAHb/zClHzH/GdHj98h5Un2SFm61mbu6aMLEddwZ+iNLTzZJDIyjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhcCE7X5etkq9sHTHK2iRRH/OpsHO+jxVgW0yBlYG2I=;
 b=XFlFUXFZ04t9RAs1sXo9lJrGjiL/2j5Heu1eCifE02pmwM1gbBOajaBo2aCJtuW6v0bHFLUaRm36Pm6exM8alcxXN992bngl59ihEfmaIB8VG6Nk6y6/lw26q7T26Su4pZUoEfq3uxPeo9pUhjYV7D85agBh5Gav0NEAnuN/g1ynNCEiYCq05E6j3sG2EJH0uDIjBjH/DQyDheXVrYinssrD3WkMDeLk6rqIOGsxLQJv6090pSI4SGF52WKa/iEV2cMOcgsEkxh9eBpYjshfcPwMc9xcKelknWpSbWn0DM61NSqR3qtOO9+Dgx0IB+MkElZNj5PqSHbRN0Fl8+s2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhcCE7X5etkq9sHTHK2iRRH/OpsHO+jxVgW0yBlYG2I=;
 b=DM7vB5jfR9Pv+BpApNZJn/IkybSM1hS121yeJNeP883Zu/MhOdjIiRuScMDQ6BrlcmaMcquA9Bq2F2cQ/H/VrLelE4qx7Nf6kyVtc6oi6dHAgxE1aiCh1S60qcB1a+GwC8gQB9D0mLWXULDT+0Bgdc3njYK6em6XXGNYhbBbpRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:13:23 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:13:23 +0000
Message-ID: <5b9d85fe-b5a6-4cd5-8d32-bd5e210aa557@cherry.de>
Date: Thu, 7 May 2026 12:13:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] MAINTAINERS: add maintainer entry for air_en8811
 driver
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
 <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-2-be54e17239b7@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 4033a771-1f2b-4325-14b6-08deac2145b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3CPvm3JgE6Tnol90Y6y2c3ElQOMvTpEBgY8pWYYkhAgCYqFwxf481tm1Y+bzgHMNqc6e7Ad2FZVJrtY3kfTLG9HPkQnJJ6AeIU5NEPDtXPCUOi5GAnBgLY4pY76fxqRys4WcR4+SiWzLbV3jLkav0vsuSMp6sfFwjawxs5Z1ScSJKbFUqmsx1Di/CuPheel/1awj0mJXHG/hAH+DPZLAGcz973gEGmJtFPTGOGLm8OMAUTJSQsAK96JLPX7/97u8n59EO2oHR6Av9RMrXBnFQnB/D9BbrXjowACRNpRt5VaEyOPNldgh2pNx9PdkXSjoKPUSyg/z9eielFwEIzoTE6iKC5oj4trMXYKxYvJlleQNjZSjGdWFUPafdRqua3xOpHuNKumlIl+hxZUzAzCMZHNa4KDG+ZbpAwcmgFXTqPiKC5+RArv7eHfS/oEABD60SQ/3TDD/1PYg/2arn+c0f2nAEoXwJOZVWbJO+BvklYkHp0lRVXUc46yN2T+Hm9jAWRuPIpKPJseVrYKhd36yn2VR8wBg5ojZVwwTISSSyQat2HRl6jGGT0qlZGmyX0/9HuJna0tUrDrsN+duuM1DOW5/osHzFMqNC3woo8brdmOIIgWxmRhdEewmbfWhzSLrIkyEGY55hOvb1LmlfrWqihaS/hR2+s1A/BtF7kLaU1llPznM2lcKT5G3HDi3v2/h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBZaWlyakZFc1ZHZHRESXdubXhNWnNHblFWUFd5WkxtNVgzQ1VCWURaRlA5?=
 =?utf-8?B?TTdlWVlTRFJyT2ZtZDdOWmtTUXczSSs5djdTVG4vTk5IeThNNDN2M1RjWTlK?=
 =?utf-8?B?U3FLQUVsZGN3NitTK0NwaTRtWVd6WnRINlFqMU5kUi9UU0ljM0hpdlptZFdF?=
 =?utf-8?B?TVg2YmlwN2lHTWc3b0hjeGVJcmRpcUNoLzg0NE5ZYlBMTlN0T2xtaDhsZ3Rk?=
 =?utf-8?B?eFpSTEVHc3FpVHpqbzVldTJDSkFLWExUclNPa0o1cmNuMXUxRTdHcmh3dERn?=
 =?utf-8?B?S0FCRE1FZ0lNVjU5MVVxb2lQSUFUZlNoU3pPSTRYVkg5eVhzcnNrYTAzbXN5?=
 =?utf-8?B?eFZqZkM1QThQZEpNUGRxVzdCMTBzVUFBdnY5MUNOelVzbk9Ud2o3dGJTRXhC?=
 =?utf-8?B?YVZBTHRwT3JiRkRjQVNRM21uZUNCcytvL1cwU2RoZ2xwNzNJSW5uNjRadzFV?=
 =?utf-8?B?c3lqN0hwVHh4OUFhaS8waDYyd0lYK2svblpDeTdHOStsOHBRNW8rV1Z2WHgz?=
 =?utf-8?B?RENnUzBGTDZXV0lkWmZTVHZkRzM2UTI4aWdkWWVTRDUyNmIvNGxWZHNqeWNU?=
 =?utf-8?B?eTBLRnhKbVp4UnlSbE53a0p5SUVpdWs5YXlaMEJxdDBXSFRRKy9DamkzbEo4?=
 =?utf-8?B?bXNnMHRGcHhRYnZ6WjFsYms5SCs2VkRIVkdKbHJKSXRkcWx3ZFM4eEtwSlZl?=
 =?utf-8?B?TWdJa0gxeUNnT2JwSXJ5TExTWDBLZlU1Qm8remZTcWMrbGFjdFVpdWg2NWtL?=
 =?utf-8?B?eEc3dThKd0Zla2FuYVdjeS8za1p4K2VPVjd4WGQyL0kzK1l4TnFpWCsvU1Bn?=
 =?utf-8?B?a0VEMEx2bDB3cFdsYUF2Ump3MkhpaXVPbjZ2a3NJZjYxMTNzd0FyUDlET1cv?=
 =?utf-8?B?OTVBWnhiMzRNbE5iRk9QSWRVaDh1Si9aK3BieW4rUzhuOVVVMGFERlBaYlhl?=
 =?utf-8?B?NHFub095emJqKzRoVTNsV3I5TThaK1JxZlJMdVYwamZyM054dlpJVnJFemM2?=
 =?utf-8?B?V1ZIcXhRT2lhMUNQK3JIR1FyNDEwMGtNN2RYLzlNQ0xKbnFTK0RyTmFUdEVE?=
 =?utf-8?B?Wk5PT2RnK2JpMEhZQ21KdVBLSy9YbEZ2bWIvamFwZndLdk4vT2lWNFhlTnlD?=
 =?utf-8?B?NFBBMHVtVXpYSHcyVTNvcjRtQ2locDY0Z2JOZm9wTXNiQjYrQmhZQ3dpS0Q0?=
 =?utf-8?B?M2hpWDJRNklzbXVGcXBERkVlMTJoSUVNdFZMT0svd1dDY0hDSk9HeldoMGth?=
 =?utf-8?B?YTF5OVV0L0lqQWo3NmNvRGxSYW4rZWs0aUxqVUNyT3hOSmsrWmJWZFNEd1RE?=
 =?utf-8?B?Q1g0QkJ1Y2k3My9Kb3lxK055ZGtvdzMyemM5Vk96TlRvM25IMG5veFpLUXJT?=
 =?utf-8?B?VU1Dc2c4Wm84YkcxSVdRZ214QjJKdzNkVWdTMkdCeWVlS0p6Qi8yRS9rREJV?=
 =?utf-8?B?S0RJMHJKV2dEM0ZDQnBOeTZjUlVmSkVtb1Mxc2Q3V2c3aVNpUWt1K0VacGhS?=
 =?utf-8?B?QmZWcVcrZG5hL2RqY2NXOWVHVTdhamcycjBwZUFUeWZOanZ1ZnNpRWN2dFhV?=
 =?utf-8?B?VngxR1pOam1odGtKR1FaQzNYdEtENUs4dFZuaGNXbFZnR00xQ2tUbm9SMmJx?=
 =?utf-8?B?OXhnVHlzUktzWUVJQ2hsdGJWV0FMRWJsYkdCOGJod1E3Wk1oV2swSHVPZmxv?=
 =?utf-8?B?bVZpLytMQ0o0VkNZUVBVcHFzRXI5dXppUDlyMTRPd0ZXR2x6cEszZ1FxcWxC?=
 =?utf-8?B?U1dPZHQxdTl2WFZzRFpJNkh6RCtWQXRKMlpzdjBYRldsOGFmL1hxc2RhVVFZ?=
 =?utf-8?B?WWdkelhMemRPU3NNNGlja0tsbjdKbFJJSjFiVjZKRlBtNXFDYS95VWtuODV0?=
 =?utf-8?B?aTd0a2ltMTNONGY0WG5Na1UveU1XTmJ0ZmFCcDdYa3VKUi9TU1VSSTJ3dGRp?=
 =?utf-8?B?bHVYdGtOMFZyNGlNOWRZZlVIMHdLSkxtQkIyd05FR0lOZGJhMGgvdnk3UHNz?=
 =?utf-8?B?Sy9QSHp3ZVBISkorejYxOFFWczlyK1FRKy8vOU5mMXgwaUhKem9ob3p5VklB?=
 =?utf-8?B?OW9RRjNzZUdwMnU1d2V1cTdHQ0RpUjdSQVRWdkZkVVR4NloxaHdyZzlRNms1?=
 =?utf-8?B?eDcxMnBtdGI2bk9ScWI0T2Z5Z1NOVVBUYVROb1Jnd1ZuK0xqUVJVd1pWY0tK?=
 =?utf-8?B?NkRBK1JSZkdqZ2VnQ3F0TzA2NWY4dTZESmtOVzNKWVFZamhya0V0d1ZKcHJH?=
 =?utf-8?B?TmZ2cU9HQ0x2UStBS212Z0s1c2Jra2NMS3hvL0drNzFSV3NNM2h5UnFBVHhO?=
 =?utf-8?B?SWxhdTk4bm1ya0VYYTF0Qjk1OVIzcElZOWlpRnQzcGQyamw0azd0dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4033a771-1f2b-4325-14b6-08deac2145b1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:13:23.7964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4tSwKicLerTR/rMlEwj7idbegxvXMYQpy3o0uBeSMa/+ArtFzdcW97pL8gzvKqFI6WXBBfhexhY3HXxNbTHARDt3ZxMA/CklfcAURpwN0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
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
> Add a new entry for drivers/net/phy/airoha/air_en8811.c  driver.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce4e9d58037..105590ffad0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -58,6 +58,11 @@ F:	cmd/acpi.c
>   F:	include/acpi/
>   F:	lib/acpi/
>   
> +AIROHA PHY
> +M:	Tommy Shih <tommy.shih@airoha.com>
> +S:	Maintained
> +F:	drivers/net/phy/airoha/air_en8811.c
> +

You're listing someone else as maintainer and claiming it's maintained, 
this is quite unusual. @Tommy, can you please let us know if this is 
fine with you, by e.g. adding a Reviewed-by as answer to this patch?

Cheers,
Quentin
