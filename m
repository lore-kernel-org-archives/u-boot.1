Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE535C5475C
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B208006D;
	Fri, 16 May 2025 17:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="joxizsPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D0580079; Fri, 16 May 2025 17:16:43 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795EA80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNEGlwg1W8a4RVqafIemCS16nsWSX6PqMJMygC2OcfGifyvagxEAT52a8g0MGve9Fz5f5m84bhGhyd2ROp1I2CnrYbfSK4ZnHtGZOMX7mhiVz/BBFro2pRI84bCMpNHW+M7pN1VfC9vt/eiy25KNwnENlyWH4RUROA4hyXZKbQM6T5GLRr1UOHXW5pL42WvUK2ECODYdysKRkLJrgte0f46B/7LV/nhGa/7IvpZx9aDK7PA1Tqou/TuCs3PA+Y1EfhLboTpyRR8Phzg3NQYJrsBg3P69eYkMdNmxdioXdAAy4814U2ftK3DsKZpTL9aOHfTowRvBbnp44uDa87aaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLpTiNha+IeZ6Ag4gGaGr/b324yiKyiWR+NdH74n3OM=;
 b=lW0bJxGAw+1v3nKmkItBqawaZmY4tNGHgwk3NYm2aOPZxpp4bqb436z+Apr6GzTJIS4UYkMkkfGppVPM3yjeb8yJHdQXav7F2bFnVoYBW1bBQ4BZRA5kA+h/pk9fHuOZUxzjSbVcdPXB6kK1q9w8EljgGNu10ymjxhsc44CjpnoX6YgWk+vmHzPHqQmn0U05/5Nn8SCw3avq+fxW8gJfgVaqad0xT82j0utspzjmSZQ5n7tV59osHoclZ9niNP/NlNsMA5eaiVLbzhdHGsqmARtgEGCUa1ivr9H7zZ/vsPpfvdwGtqeNs9jA9yRH7gSUPpbJNNm2j/WE1Ej5h3eBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLpTiNha+IeZ6Ag4gGaGr/b324yiKyiWR+NdH74n3OM=;
 b=joxizsPtkkc8YwUOLM5c3ky/MqDuR/RSUL18VXFnHCbk37oe+bz0/fdazBhXOp8E2FRnDlfpd8dRD+zfW0Kl8ZMpwfpfqfcze/0VoGddHR50CTFg0sTxlElolZImE4huoWzHtitq4DZ6psQi3sl6OqXrAi/2/1ycw6bxnI6onR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 15:16:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:16:39 +0000
Message-ID: <4e28fa16-0314-41db-8de1-82927248b388@cherry.de>
Date: Fri, 16 May 2025 17:16:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: onboard-hub: Add support for Cypress HX3 family
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-4-3cc5a06087cf@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-4-3cc5a06087cf@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6e48b6-9e75-4219-4159-08dd948ca820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1R3Y3Z2K2RJdmJRSVZjKzNSR081VXB6RFF0Z1lXQmllSkpmMytoNU1aMHVV?=
 =?utf-8?B?a1dlV1hsQ3c0SkwyWmloSTNEdHBhaUZiQ1Z1QlpMSFdZcFBsVVo1REhjTmNU?=
 =?utf-8?B?MmNXTFF6WEREZC9KcWI0TE9ScFdFeks0Ky9yb3dRQ2ZaWGs2b3RHVDdYSDZq?=
 =?utf-8?B?M284cGY1N2NqbWdWNXoyMXpleGhNQ0l4SGRkYko5YWhEL1VKTGgzNCtqQ2Ix?=
 =?utf-8?B?V21ZRzFOOU1NRUlNUDVYZ05veFBDbDE5UTB0dnlTZFFlMmpnM3QrUVc5YStu?=
 =?utf-8?B?ODVnMWZKUXdldnM4L1JJbUhpM2FWcWw5YnZsWWR0K0IzcEdIdkJxOTl1YjZ2?=
 =?utf-8?B?U0lldWtrSURCeDdKRnAwd244bW0ramo0SjduTm0xc29MWUErQ0FBQlgrcHRw?=
 =?utf-8?B?OVliekp2anR4MWdpUWpNU05qVU9LbVdoNDVGMmZBZEJmUzA1bkJPcTQxcTNv?=
 =?utf-8?B?NTZTOFVSb3pHTkt1Z20xMVN4a0VXZVBuaXFmWVZ6UXNJQXZLTjhKUkJ2VmRr?=
 =?utf-8?B?RlR5OGVoR2prSjM4Um9wWVJCOHZGdE8yQ2JNZmxsWC9YMUs1TzBHVXFnNi9l?=
 =?utf-8?B?eGlNQWNsMWN0dkxhclN6ek9KTFM3UVNqdXpQWWFZTzNWOVpwY3p3eUYyeXVx?=
 =?utf-8?B?UWhtQUMxTDczb1ZlbVRkc3dNNm1oQnJTN0xURGY4Yy9QWjVmTm9jcjN1UHAw?=
 =?utf-8?B?RFVmSSttaVdyWFpVenBHYmJUb0w0bGpKVXY5cjI1bHlUekxsVk1SSGFUVEZv?=
 =?utf-8?B?OUV6Wld2OUdFM1kzeDR0a3FibFRSekZlNEdDZHF5eGV5aVB2RU1rUllFbHRC?=
 =?utf-8?B?V3V3REN1cEVUQWpIWXdIcnFnRHNTS1F5cmZpSXE2OUo2T3huU0FsVzN6WDhB?=
 =?utf-8?B?QXRKUXVaM3FSYUZtNXpnRmlRdnhyS0k5ZGtSOU51VTNURmlCQzBZbTMwdUY4?=
 =?utf-8?B?ejFnTTJ5ZlI2Q1c5VmtMRWc5TzdxUFg0bFRmZWtPemsxa0Z1RitQc0grdGpK?=
 =?utf-8?B?Y2IxdFY1c01DejNxSXJMaXZEY25lTWdnU3pWYUd2V1dwVlNFM29TUkRhWk4v?=
 =?utf-8?B?QlFnZGpQa1pmTER3NkZpaUdad0QvQzZ3aWdTSXU2RnRta1lMSTh0OXFLbHll?=
 =?utf-8?B?OG9VYk8yNU1LMVNSN0dpVXdUOHBaRjkvb2RCT2pMRGgrV3M1ZXBza0ZxU2hP?=
 =?utf-8?B?S2laWnU4WG9oY0c0QWRwQktJQWYwdUg5RGo5T3YzVlBQb3ljMkFVOXlWTTIy?=
 =?utf-8?B?U3NzNHUrZ2pXRnNoYmhSWDYzKzl0K01VTUFxMUFoNWlMellJeDUva3NNaENR?=
 =?utf-8?B?TGNFUjA3aENYMzRFZWd2ZmxGQ0J2U0tjbFdKVTF4U2pVcWZtMXNiUE9LWEpN?=
 =?utf-8?B?clpUcUVNMU1VWE95c0tiYXhPNFhCN3I4Rzk5MGRmVGN0NWZXV1Q1dVBqbWIy?=
 =?utf-8?B?RDkzV3U2cjNNczZ2Mm9GWnl3SkFOekJWb2hWUUF3aTRCMlMyV2E4aWhzWGhQ?=
 =?utf-8?B?N1lRUHVOTjlSZ2hzbHYvblMvYm9HMnJBSVB2eENIcjBybFpsaUhLc3lTMGs3?=
 =?utf-8?B?R1Fmd2tEV0xDRGlzb1V0NGo2SFZpMmZvR3hwNFk2ZVlGVVp6ZE14K2J4bW9v?=
 =?utf-8?B?OWhxWklaVVdicUhpVjV3aDRBRXdTZDZKUEtMVElpRktCQTlmUFQ0WFNrdmU5?=
 =?utf-8?B?Q3F4dnlGQTk1eW04Zi9mQ2g5cUI2RVl6VWxhQ2JMaUkwNWRHWURNNEJxSERN?=
 =?utf-8?B?WjMrVnBkby8yckRnQWxRLzBMNnNnSUZYRVk5VHZCZXQ3UnpGNldDOXpDaHVE?=
 =?utf-8?Q?hQ6/J111NnGhggMAhxSSjwqOPPzOFRhJzN2Ow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVNWlpjTHlScWJOK1gwa0pMV3BDK3hML2JMc1YyRzhva2VKbFg4M0lFcmw4?=
 =?utf-8?B?TXFkQ2JuY0xjSVZhUitBYWdhTXJGUm1KdjJtYnAzY1h2Z21Tc1FMMnZ2dWdv?=
 =?utf-8?B?eHY2YTlsWkcyc1NUbmtQdmtNWGhocUE4b0VENUdnbDNpQmIvd0svaWcrNXBH?=
 =?utf-8?B?N05mNW5TbE9qVXZ2R1R2SXNMTDNoSURNVHRjRmNnNElIRVJ1dWFFSlpsc3ky?=
 =?utf-8?B?NmJTRkR4emdRNE92YWJBdWU4WTdVUnN5cFVVamhtY0s3QjJMNzRXaTNzdHZE?=
 =?utf-8?B?M1FLU0Zra3JtVEE0QklMVnptSHJuMFZYOE13dFRTQ1RvZTJiZ2VadXhsRG5j?=
 =?utf-8?B?MG5oK0RQVjhrVGpINHpnL2Z1VkFzcnp3SjRWa1ZXdkhUZ0pSUUdTY3lCUGsr?=
 =?utf-8?B?VHllL2NpY1VSNDlkS1VJODZSbkEydG52TFVQd1VLVzNhczBWcko1RzJXempn?=
 =?utf-8?B?eEpvVUtLWHlqb1oxVXFXeWFOaDBqOEg5NzB5N20vN2FGcUdndFJsWDM1TXZL?=
 =?utf-8?B?YkExTzBBcEQ5ZjJ4YmE0c2Jjdk9ldHhiNXRTelZIMGxHT0JmZ1NBeDdkNXhR?=
 =?utf-8?B?cDgrL0NzbUpVVWVvbk01bWxvQ1VtajZ0V0QzVFJGMWVoenUwU2NIQzNVamF1?=
 =?utf-8?B?MXNRNnB3R0thNy9sMThaK0NnQVQ4OWMxaTZSVndlVk1IcGFYci9EOWFqQTZ4?=
 =?utf-8?B?T3lOSmJaYytUNUdDNGM1eGtsOUFLaU9XZVRIMmMzaGpRZG9XaUdnWHpWR21F?=
 =?utf-8?B?MEYvWVVEd2I5VHVWRjcydm5XLzVlRjdOdGptWE00S1R1bUc2ZmhaeXgwOUxB?=
 =?utf-8?B?TTVTR0s0T1c0SG5xaVhma21ub0hhRWtkMmNUOFFlenczYnpLbU5nbGJXcWRC?=
 =?utf-8?B?NCtWaWR2M1kyaElwai8vbmxvSFMxRVRTRlBqaXl2ZjE5aG5iYVA5enAyTDVO?=
 =?utf-8?B?Z0Q5ZStXaUlZaEw2WXp1SHdqR3doTlgyeG40cnVrb3JlRkg1V045dTlFdlcz?=
 =?utf-8?B?WkVka2lLT0VhWXJKeW90RXUreWdxdU1RUUFQRHYzRm51bmdUVWhjNnJ6Q2Vp?=
 =?utf-8?B?TFFDMXFRd0RDQU1pUGFLbzZKMzBzSzZjYWV5TCtvOFptTnJZVmNEQWhNVXl4?=
 =?utf-8?B?Q0xETWJpbkJlazU2b1FZWEIyaTdKc29KUFBjTTQ4U3pWSXNmM0JCTlhXUUFZ?=
 =?utf-8?B?STdJTUNzdnlHeWYrVjRWMzNMRHhmdDdhK1Qvdm9qQWpMUnI0TG02WDJYNHF0?=
 =?utf-8?B?eDl1NFN3TTRxdlc0MndJdDRWWjJTUElQMXM3eUUydjVtRW5LUEpHNjNlaHBa?=
 =?utf-8?B?WlpJWHNnN0t3NFIzenRZR3VObWxTbHE3cFdicEhaN1JIeXBYZXdaYUlGcGlD?=
 =?utf-8?B?cmFOVE51MXFYcStldTNwTStkd3hsVGhjbVVzazhrdTd0VWRwTkNRanZ1dDJn?=
 =?utf-8?B?aTNHVWlzc0U2MWpFTU92ZFcrOVczaU5BejJFVlZXMW9vL1JpellLTXJrQjMx?=
 =?utf-8?B?a09IMStBTFoySzdFUTJXVHRRdFQ2V3dVL2F0aHFlY3JlS2YrQjNyekxIMmxT?=
 =?utf-8?B?c25ybGo1a0lncjI4SzNYSGZRWGYzZHpGRlFaRHR6Q0tLSGVMVS9tSkIyMkVo?=
 =?utf-8?B?RHdvaVhQdmN3OWpmeStLbmdjaDY3SzEzUVFyTURXTXdWbEhYSUJqZm9FUlRT?=
 =?utf-8?B?ZnZvTzZFWUlPbzg1a0ZIUkNNc2xjV1N4R0tyaVBRYmVpaUlKTG1zUmZXa0N4?=
 =?utf-8?B?a3NjaEpDK01lSC9NS0FhS2pTbTN3KzlmVVFKRWdGMEpiYnpYVDk4ck12SGhD?=
 =?utf-8?B?bS9VOVlrYkM5alIzVTRlQjBkbmFJdWFkWW1JYXV6bXRlcm52SzhpVmtLa0U5?=
 =?utf-8?B?OWtOVjVZaEY1dmN3ajZHblJTMFQ5RWRUbklnd1ZrelRiaDBVUzV3UFJZK0gr?=
 =?utf-8?B?Q0tHa1dTZFNpNG5IVDNIMW5lcmtxUDZEVGxaM1JaQXhBSzRSQjJDWFVJMkcv?=
 =?utf-8?B?SDV5aHBWdHdUdENXU1RHb1ZLNjVsU2l2RU5IZzVNWlhtdUhLSXFrSnRFWVRI?=
 =?utf-8?B?SWNMbEVJVDVkV1QyNTV6cWl6VE1UQ2hiMCtQNTBoRmVkQXJBYmx2eGtuc0pZ?=
 =?utf-8?B?dnl6WC9YUUtsK05GR3JibnVtak9BMVIxLzRFbzg1S1c2WEUzZUxlS1JmY0Rp?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e48b6-9e75-4219-4159-08dd948ca820
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:16:39.5012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUcOuKaRx+f7hFxUXRqmlPu4rLitcoRoCGpxVY2Qaw8eOlzdgqOfIOStAfaZN8YOPi0PS/U61q3qRV1kUvAKkxr3EQjlDRBMcfYdGuaPfFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
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

Hi Lukasz,

On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> The HX3 is a family of USB3.0 hub controllers that comes in
> different variants: CYUSB330x/CYUSB331x/CYUSB332x/CYUSB230x.
> To support this hub, controlling of reset pin and two
> power supplies is required.
> The reset time is set to 10ms, based on the datasheet [1].
> Power-on delay time is not required, so it is set to 0.

Global struct have their members initialized to "zero" in C, c.f. 
https://stackoverflow.com/a/16015741 so you can simply omit it.

> The compatible strings added to of_match table are
> compliant with usb/cypress,hx3.yaml bindings.
> 
> [1] https://www.infineon.com/dgdl/Infineon-HX3_USB_3_0_Hub_Consumer_Industrial-DataSheet-v22_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ecb53f644b8
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

This matches what was recently merged in Linux, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
