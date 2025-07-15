Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83107C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD3782F14;
	Tue, 15 Jul 2025 11:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="InnDZO6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9912C82F14; Tue, 15 Jul 2025 11:46:46 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC6D82F00
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRsni7JV59kWJaAUYMA3vOcwWSWgruq7tA+CcM9J+qbA9lAYNM58Jc/GjksY9HtZsdXDjt9j12P2nbUemDL6pu7/g7Qztt6s9PYd8+Ynlrykp/asA0DVWs112o0iacFKKLVnanaUPaL9A4BmkX84cOBDg0Krv7pamtzgornM+H612GPgkrimscPn9pxXQxnasLpeV9Fs4gSIvA19OPUhUKgMUslo4yRABl58igYmVgaz4kwBULqTwLjBklgc5p2TpSuDpTNtGlHaXn4j5flJ4Rk2JoZD9fl/H7/MO6WmZcwa3mvNYbII4cHwuEz9+LbM0c83dS/FdFCDWVQnccnhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqF4/zakWpNzUT0DOFgWVpidDUW63PEvscpZz+FDwc4=;
 b=ANnWwnl34QOK8QAjAFwEL8QyCFCroLD7k4ynTkCxlLFRTY39AV/hV9IFzdEf4U/+1WW5hPFdhBkCT4P6BNvZX38dTBJ/N5W7OVI5J5wtXNnfe6DWckcMtE4Upkh+8S+wGFYkeQptB/0CdShiZPlcivnFkv3FrPFI8y3jAVEfGcqM8+Ded+Amu1+hHz3cDkqvSGQRpW+keqqgd6HMDh59FwVTVCH2hC83TXDXM9jNp8oyoC2bHms4RsPe+4yHlmY9QeRfKO5iQ6rxXgGhYUVa23RcCj5KlRx71WL05TqrA1sRdMIaNseMqc7RvOLVveemwhDN1Ckxm2/tRnUYEL/DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqF4/zakWpNzUT0DOFgWVpidDUW63PEvscpZz+FDwc4=;
 b=InnDZO6LVNPTDzCSkQtADHIsesV4ViSiR4uy5XVS8/3RKtGDKzx3u635UnmpjzuusPqbCwF0dUtSAzENey946rxTqSbqa30vhJDB9XMmCKzwt+TrO8FlF9snqSV965C5pHt8xkcpV1uX/VtkFXWhbNu1zg1YgevXPgZ99zC4Sx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6784.eurprd04.prod.outlook.com (2603:10a6:803:13e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:46:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:46:37 +0000
Message-ID: <ef7bc4a7-4195-42a6-a7a3-9d1afef39d7e@cherry.de>
Date: Tue, 15 Jul 2025 11:46:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] rockchip: odroid-go2: Use env from same storage FIT
 was loaded from
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-13-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250713233429.1376172-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: e17c8e7d-dafd-45e1-57ec-08ddc3847e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WldjYWN6Q0RBalg2Qi8za0xyRHBOOXp5NW5lSlZJSER2VmF2TzFsS1hYU3Jw?=
 =?utf-8?B?ejR3UUNlNDdtWS9JdnY3czE5TVJDT2c5MWVEQ3NaVHlYc1lPT1lDOUVHZDcr?=
 =?utf-8?B?UU9DYVFTb3hqbmNYK3B4bmNjRXJHelg2bVlXQ2dtVTdMcmprSTh2K0pGeEpN?=
 =?utf-8?B?QlB3UlZMN01sZGRGVW9IVC9wWUllRUlITmY1d0xieE4zT3o2YXhhN04wS2tr?=
 =?utf-8?B?OGphMGhtUjdtQXJkSDJyOHV6dTh6U0lJMGtkbGU2a3l1aWhQNUdDaHkxWk85?=
 =?utf-8?B?b2o3R2FkV0JIbHNaK1QwYjcyNzU3K0FoVkQ1Q1laMk9qd3BuNGNDOFhJMGhl?=
 =?utf-8?B?ZWFDaWwwYStqUHU2cjYvWU9RejBIdGlQZlZybWE4VUhydE80ZUQ5RUR3c3VS?=
 =?utf-8?B?Q0ljcDUxNnhnNHNGaHhHUVl4S25aVzd1VjhxbWt3RFV3QWduQmMrUUQvN1lm?=
 =?utf-8?B?U1pCVUZ0Zll0cWxwZTlxOXVkNG5IUHNhUzZUM05RT1hRcVZNSnZibEkvbHc3?=
 =?utf-8?B?czFKc1V4eDIrYWVPV0ZIQi9OWWE3bXFiS3M0TTVlaTJXcHhCYUNKL1cwaklk?=
 =?utf-8?B?OEsvK1N0OFU2aXoxWWs5dmZwdGdVcUl6am1OeVRyNlBtcnFWZEk2MzdPY2p4?=
 =?utf-8?B?RVlMS2kyWkFrbG8wR2FFWWlJN1EzWHZJWkZHVmZjUmcrRDVhNGs2NjcrMmpN?=
 =?utf-8?B?WXhyeDU5Z3dsVnRXcU5hUEtJd3RJVWZMSWtydUxndndueExXT2VGZFkzSjdt?=
 =?utf-8?B?a1lMbW41eldacERDa3o5bEFQaXZ6ZGord1dlciszV05YeEJ6aVcwR2J0eGs2?=
 =?utf-8?B?RDdmSlVYMXBiaFJQeWtjVlV4R01EdDgzRmtqQmpJekQzeWs1MHRTNjgvZ0pZ?=
 =?utf-8?B?c0VkbDJieHdSdmwyUHg0aS9mYnVnL2RiYWtTVXVqcGc1Q1RleHZFTVFYVTQx?=
 =?utf-8?B?WW93U2RCZ0ZFS1lyWGlmSkQrSnptVm5CaTVJbGNFc0wrUWRlbFphaU9ZQjRm?=
 =?utf-8?B?MlJwalhXenBiVjZ6WEdvR0dyNDhHRUgwWEsrQXFSbEROZ3dpaG5UUTlNUzhQ?=
 =?utf-8?B?aFdKT2IzeDMrc1E1bzRsbmdGdm9veVdBWko4dzBkN3NFRmkveFJHcFZKUkJ0?=
 =?utf-8?B?SkcyVFdXaFpjb2F4NjVmL0xWQ0tOdkhoTnl1cnd3U1dVRis2UTJrdGxzUmFn?=
 =?utf-8?B?UDFINURLOHB5bHFIZElHb2pHZVljUzVVQXJLWlZ0RHZHdHN1bGNCMzlyYWhE?=
 =?utf-8?B?bm1lekFzbVI1Q0NDVnJNeVc5dngxZHphNFoycnkzdysvNHZBdjlEM2tWN09k?=
 =?utf-8?B?bytNbGF1WldLb3Ivdm4vREVnOVZ3U2s1aGdFU2N5Y0dnemp5UC9sQWpzOG5p?=
 =?utf-8?B?NjI3WXp4MTluVnl6Y2pLUzlsQnJBWkRVc1ViM2IxVW16NEprclNMT1pLUnkw?=
 =?utf-8?B?bk05RlJQdEhuK0Z6ZTFybmYxRDR2WEcrUE11Tm5hL0h6T3ZmUE93dENVUkZC?=
 =?utf-8?B?V0c5RFhpbmtxNGlTY1dGTjJjMlNHSm81eVJ0cE1XbzdlQ3QyVEx4TjlWNlR6?=
 =?utf-8?B?czhnQzB6emZDQWlZMXdCSWpsdi80WUV1ck9lWkpkL2k3aEplNUlTZnZPSEF2?=
 =?utf-8?B?WUIyT212azRBbTBEOGw3V09ldTNMcEkxR3ZBY3ZESzg0cS9QMjhzZWdWSjl0?=
 =?utf-8?B?dGVPV09tcDNLMTZyNkNHcG5FZ2RJTVpFWmN4bnJLTHpJM1BnbnRpdHhpYVNP?=
 =?utf-8?B?ck12Mndra0tGZkRUNWxFZWJ0UmFPdS9Gb09rN1ozOVJ1OFdxR21GMEIxSkhV?=
 =?utf-8?B?ZlBtaUVONk1KUjlwUENtdVErRXV2bnBSdkR2ak5JNW52a25YZ2Y4d0dNMy9S?=
 =?utf-8?B?R01BRWdLa2llYXZKMkkwMFFOUTQ2TEZCeFowSGdSQ1drSmlSSVhsSS9Hem00?=
 =?utf-8?Q?WzHnoQn8kqs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndyTXp0S0xGQi8zdExEclcvTDRVZXVMRW5jSEFmcUcrbExpenFMdTBzejlN?=
 =?utf-8?B?UzVJcUJuaFBqV3VacHhnK2RuN2JXNkhUM3ArbDM0M3Y0aGwraUdZSzNsRHRM?=
 =?utf-8?B?YmIvOS80eC9KMzk4ckdhTS85L0FDajFwaFVsR0QrVHVGT0w5ZEYvb0EybDh5?=
 =?utf-8?B?NFg5N1h4cFpzMTRRWTRQTGpPaVRWcHVkczlGcXBQWndwdW9ZTXppbjl2MGhM?=
 =?utf-8?B?bkNsUFlteGZJalpZN3pBUEZpbjlsODNMSFFqNlBkL3lMUEh2R0JLWlQyUW9x?=
 =?utf-8?B?YklIQWR3ankyeUZvVTh2NHQ4RTczQ2MzK1QzalBxcmhPVThIL01OQ1VvMWtk?=
 =?utf-8?B?bDFPMkI5SzNZOWMxUlFsKzVwVHRQdy9mR0hBamZSOEJ6T2p1aUdWM3ZueG1E?=
 =?utf-8?B?OFo0UkFDTkdlQ1hsMkxyNHpQUGloMnJKZnlwOUw4SUtHemkvLzBFSWpxZFV2?=
 =?utf-8?B?L3crRUdWRmU1VmxZc2liSWFwa1h0TXc2MTdFNFZFT1hzS0JMQWNqTzdFWFJv?=
 =?utf-8?B?ZlhldnRpNmJ6UlZHcGdybk9IdENLR2hwS1RTMUVmREZrcVg5Q3hiSzNZRXJv?=
 =?utf-8?B?aDBjb0JuV2tJSG5xM2Y5Wk1LQWtudUlqdmREQnlVbjhKMkh4WHU1WW9vZW96?=
 =?utf-8?B?QTRhNmMrT3poaWE1Smp6cTltQjhVRlpkcmZTZUVkSFBpbWJNa0lyWHZ6QzZu?=
 =?utf-8?B?M1p2cnhLNXp4eXR1T3RoZlo4Uk1NanhHZk5TWFVsKzBmQWI2S1NNS0MyYWFR?=
 =?utf-8?B?cmdjM3YvZkZaSWJLd3FTd0JURzRXMVZoeWhFRmZvQkFINEs2MUtsK3B5Wkkr?=
 =?utf-8?B?d29UUXRqNDlJNit5bEh3a3dGejFvVHZYOHdSSDBBQk9Da2d1RDd4azBFdytD?=
 =?utf-8?B?STM3YWdQL0p2TXJqVHlKNWppcFdhUzZpVkp0TklxY0lReGdiRWdLVkcvN1Q5?=
 =?utf-8?B?cWtTRE5EQ1FvblBibnRSVUZ6eFp0Q0EzakU1RUQ1WFBVeVlIS2F4bU1heVM5?=
 =?utf-8?B?YVcwd3JwNkJwZU5CRGx6TjZJdFBxQ3UzaXR3eExwN2RUQ0lydDdwNzV0RmEr?=
 =?utf-8?B?UFB0Qk1QTUpPd0NTQWN0VlhzMERTQTJSY25wd050aW5hTFJ0aUFJSFBNVFZE?=
 =?utf-8?B?UkJheDJTbXhHN08za0lEVXdCcGVCT1RVaUdoMVpFb1FEaExibE13d2VIMEVT?=
 =?utf-8?B?ME12dit4QVVSQXUwL2kvbG9QZGVEa1JQUWNKbDBPekd2OUFHeURnRHNJcGJw?=
 =?utf-8?B?TnNTdTI3UWlxT1FXc3B5V08wSklMSm5VeitsSGRTMWtHdTNaS0RtMjJMcWp0?=
 =?utf-8?B?eEtWNEw3YWtpSXpZaHpEaDFMUWZ1UmZjM3oveFk4WTB3QTV4RGFLbWRsQjJi?=
 =?utf-8?B?eXpOVXNRWURNR2k2NExDd3huUmFrTEdneHdnSWdsR1RxT2Fta1hTMjRGZFVI?=
 =?utf-8?B?VGpEOVBteDl6RGRqL0FxVDcwTi93NU5VdFNoRVVXbWMrditpRFY0MkJyN3E5?=
 =?utf-8?B?aEt4OWZrMlFXRUNlNW9BeFplUzlzWTNrSmFDUE1Ed3BCVVkwNE9IZUpESnNX?=
 =?utf-8?B?RjdtcHZteEFIYjBQakNOZS9hTnplMDNiOFRLUlJHb3FmVXI4YmxtbDFLV0pJ?=
 =?utf-8?B?bEF6UUJyT01SbGpSUUEyUmx4ZTZsTDZJT2NQUnlaQktNMm5pWUpQZDIxTWlR?=
 =?utf-8?B?b1FXbGZTQU1WUVJ3aDR0dG9SR0RUYTdsbENVUXdjdzNmTTdKZnpqVVJxZkRG?=
 =?utf-8?B?NGJtQmFTdW1RekRWaHM0cGlsUFY2ZG9kcEQxM1QyYVU1TC9EZTZXNlR2OGUx?=
 =?utf-8?B?THp1YjVmUXI0VVZzcnNBeUNwU293YU5iVHpqS2c4MzlLTklSeDJQcE5tQTVS?=
 =?utf-8?B?MWtlaTlFYXJ4NHRBL0drb3dUbk9CaHoxSlF5ZVNBMUtRdG9vZ0tKeHMyb0Uv?=
 =?utf-8?B?QUx6NWsvb3haQlNIYjhmSWhzYWJMS0t1a0ZVbjRmbUV6TzRpUEVxVTFEdy9t?=
 =?utf-8?B?YmwxV1RRSFF2RmFIbnd3SEJoSm5NdzNEcXd4NHkxK0FkSDNQS21tQ2V2VXZp?=
 =?utf-8?B?V1o5K0lNdCtPR0tSV1IxcTY1RTMwbUNtWU9IZWYrb2xmaE9tZm1NOW9iWEZr?=
 =?utf-8?B?V0NPMGFXUVZvTWUzUHpHcDExbW1iYjdlTnJSVXJoOFQwUWJKd1lxam45MVpv?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e17c8e7d-dafd-45e1-57ec-08ddc3847e20
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:46:37.8158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zejmm+CuKu5AllZpbBLWolBT3UAjs65g57IMmmCmPiBMa3qA3gcq0jJYiai3WhHisJ7ew0sWJELHdOvLgTDPgUNUymDz1PgJyeeY7yT0ob0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6784
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

On 7/14/25 1:34 AM, Jonas Karlman wrote:
> Change to dynamically select what storage media to use for the U-Boot
> environment depending on from what storage media the FIT images was
> loaded from, fall back to use env from nowhere.
> 
>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>    Trying to boot from MMC1
>    ...
>    Loading Environment from MMC... Reading from MMC(0)...
> 
> or
> 
>    U-Boot SPL 2025.07 (Jul 13 2025 - 10:07:16 +0000)
>    Trying to boot from SPI
>    ...
>    Loading Environment from SPIFlash...
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   board/hardkernel/odroid_go2/Kconfig |  1 +
>   board/hardkernel/odroid_go2/go2.c   | 34 +++++++++++++++++++++++++++++
>   configs/odroid-go2_defconfig        |  2 ++
>   3 files changed, 37 insertions(+)
> 
> diff --git a/board/hardkernel/odroid_go2/Kconfig b/board/hardkernel/odroid_go2/Kconfig
> index dd6e366282e3..6487335972b8 100644
> --- a/board/hardkernel/odroid_go2/Kconfig
> +++ b/board/hardkernel/odroid_go2/Kconfig
> @@ -13,6 +13,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>   	def_bool y
>   	select ADC
>   	select BOARD_TYPES
> +	select ENV_IS_NOWHERE
>   	select SPL_ADC
>   
>   endif
> diff --git a/board/hardkernel/odroid_go2/go2.c b/board/hardkernel/odroid_go2/go2.c
> index 9d9f3cee36a5..ae32ea87af88 100644
> --- a/board/hardkernel/odroid_go2/go2.c
> +++ b/board/hardkernel/odroid_go2/go2.c
> @@ -7,7 +7,9 @@
>   #include <adc.h>
>   #include <asm/io.h>
>   #include <dm.h>
> +#include <dm/uclass-internal.h>
>   #include <env.h>
> +#include <env_internal.h>
>   #include <stdlib.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -129,3 +131,35 @@ int board_fit_config_name_match(const char *name)
>   
>   	return -EINVAL;
>   }
> +
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
> +	const char *boot_device;
> +	struct udevice *dev;
> +	ofnode node;
> +
> +	if (prio)
> +		return ENVL_UNKNOWN;
> +
> +	boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
> +	if (!boot_device) {
> +		debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
> +		return ENVL_NOWHERE;
> +	}
> +
> +	debug("%s: booted from %s\n", __func__, boot_device);
> +
> +	node = ofnode_path(boot_device);
> +	if (!ofnode_valid(node))
> +		return ENVL_NOWHERE;
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_SPI_FLASH, node, &dev))
> +		return ENVL_SPI_FLASH;
> +
> +	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
> +	    !uclass_find_device_by_ofnode(UCLASS_MMC, node, &dev))
> +		return ENVL_MMC;
> +
> +	return ENVL_NOWHERE;
> +}

This is virtually identical to the implementation in 
board/theobroma-systems/common/common.c and I think it's quite a 
reasonable approach (though I'm the one who implemented it so I may be 
slightly biased :) ).

Should we somehow make it available in a header so it's easy/easier to 
implement the same for other boards? E.g. env_get_location() could 
simply call env_get_location_same_as_proper()? What do you think?

Not necessary for this patch to be merged though, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
