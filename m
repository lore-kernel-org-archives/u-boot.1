Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3178C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B982382E52;
	Mon, 14 Jul 2025 14:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aslb2r4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C684482F49; Mon, 14 Jul 2025 14:37:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D569D82B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo8qniJBD+WSS4Kt4R32UYBTHWYSwJnsUNJRdwRm6Q8lA9LThlUdZAIp3bKGF9O+WLPlMwCV2JD2P4PMspl/TOZRHcW9I3daOHFcUN3ZdmNrxV6weAz5wtYzwt3laIBBRcUIetzG+CuQVbVyQQ7yRaS+cCCBjPf+yyaMVDQitSRfh5cEpnJHhuYKUTQo8X/ll/MY2glgjCVl0nm62axUaz8P0k/yja4REJvMLe8DyrzyrVUriS3UZEYjtSi5jUcbJfL8No0FYifJkj5DHNE+wFzwg4EUtOsUlvbkBYZikpa5w7rFyTKYvnWsYMBjncXlScTib1lCJh6kzzKn6NhkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRSK60d38gwmaq+rVXUB9SRuCbxKQFfDadHMtj8rzMw=;
 b=QtLquI6rMXs/oD8VD5+y9TB7SV9NT/1zCrdqfaY8I8ddBJ4nBcwkBz67f/RC1zkRaA7HXxheWe9UBnW0lfmHLu/xJNA36iF12G5DRrEC6gjLq/oiFlaOPbcMia2dfdJ4DJiLs6jRMKBA7Do+YR2veaFFugPu/Ufitqaqlpaqrzcx2S7sILI5sSv5WYM3YSpWtRAzZhFLF52ChtOt3Wdsy875hluTwFiikiIUr5OZC9IAWvXyYz6EQTMvHMn5TGXG0qRilOpaun37IAGy3keuFOa7HA0G4onheLI2KzcF17HKFOFSKDKh7rAyN82zP8BUSDzmB4RIw45FCY87yma0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRSK60d38gwmaq+rVXUB9SRuCbxKQFfDadHMtj8rzMw=;
 b=aslb2r4ZWpIksyNFHL1i7AGlpC82x2tDJPIBIoLNWhtQvwxaFsjirxRpSMdn1heq6MDeXR19WCwGvzfI64yRGa5X4WbncVfWOgbTnwVgeFnxbM+/DxxYXeEeHBv/R7TWMsWxDjTVaAyHzvlwAe+7iURf2oeMY4U8S8LRtlfn64g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10987.eurprd04.prod.outlook.com (2603:10a6:102:486::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:37:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:37:34 +0000
Message-ID: <2f38e9d5-f030-4b66-ab90-9111a02657ec@cherry.de>
Date: Mon, 14 Jul 2025 14:37:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Return value calculated by ERR_PTR
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250703-clk_uclass_fix-v1-1-9b6cc81c9490@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0167.eurprd09.prod.outlook.com
 (2603:10a6:800:120::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10987:EE_
X-MS-Office365-Filtering-Correlation-Id: b37f274c-a002-4475-ba2b-08ddc2d3354b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTViK3VpQVhRSmFPNTRmZTlybjlzQUhXK3d6bWVubmVyb2pXT1E4SndVYlFF?=
 =?utf-8?B?eHVxYUlUWnQzb0Znak4yRzVXV0tneERTWjgxSmlMYzE0ek14d2N5MFlnRXIr?=
 =?utf-8?B?OXhqTXdoMnBXYXgvWHlYcVcwaHNaRStjWk1UMHRZZ0RhOHpaQnpSWEhpd2tr?=
 =?utf-8?B?a09oWXQvN3pIdHJhQjd4S3RkR3JMVUtBSHRXNG9wdjh6ZEFLOG9JWlpWYWJQ?=
 =?utf-8?B?V3hMWXFSVU1WeitoSTlxN3hsWnBNdzl3K1loNTMrd3BBc2pZOXY5Umgwdjhl?=
 =?utf-8?B?YXV0NTQ4OGVBWENna0lCRW9zbDZiN2NvTU9rTjFhQ2pLS09BaGd0OVBwdjRi?=
 =?utf-8?B?LzVLMU9JMnFVNzNaOHNucEZFTTdEMGlWU05YRnMyc0FzOEdSS3FIaFNJR0da?=
 =?utf-8?B?cGZnZ2JwRmZ0b0lBMmFhV3Q3ODlVY005NmhDN0pBai96dW8wak0zaGZqaEFO?=
 =?utf-8?B?Q1dJSXZBWDF5Q29ZQzlkV3JEdkZGNDFyZHlJZVNZZXRrdW0wYzYwbWZ4SXB2?=
 =?utf-8?B?eEw1M2VXdVdkVWE3MUNjNTBWS2VpVVdoUTQwZ05JMHhUMVg4MlBYRXptUkM3?=
 =?utf-8?B?b2xVbmdmU2YzT2xPeGxJNXdzZnpFZmdpQXhuRUlEWk03OTc3c2NLTlNtT0Mz?=
 =?utf-8?B?WXdBYkRZT2YxbkxoaExLcUNVbzlYQUErditIVEZEUm53RCs2U0RSRVV5ZExy?=
 =?utf-8?B?RlpwZy91SU1YRnlxbkVzWUE1U2tWNnhCU2JoZXUyQnNjeU8xdzQ1NS9pdEdC?=
 =?utf-8?B?V2NXSlRNT2FscjVmNjlkelIvV1N1aGgzUnl4bytxeGt1L1h3L1BJSnRFUmhh?=
 =?utf-8?B?T002Sm1sU0syMWtMWHFJMVJGZkRpZjZ5RHlVVFV6T3hCbEEwWE1BS1lRTXhq?=
 =?utf-8?B?VUJBY2RZMDlIS0QvZkUwOGY3THVCYWlpakhsdUlYV29mZjFhd3ZFblU1VDNo?=
 =?utf-8?B?OTdsbjdjTlJDMEQ5a0RXSXFhTTZ3VFI2V21SdUVUV0RLS01JODRGL1RoejJK?=
 =?utf-8?B?NytsWFhjTnJEMlY3ZzJ6QmU4TmorQUFKNnVENHk3My9KQ1lydmhMMkdyRUNu?=
 =?utf-8?B?dGZnckZYa2xMbGNnNml1M1pGYTVXMzdxODJ4UlBKdVlnR1RlQktnYy9ONXBv?=
 =?utf-8?B?bkpFVGtndXk3WUUzSklWY09VeEhtZDBwMmcwU21ZaGpLa1RQQmVGL0sza2FI?=
 =?utf-8?B?VGlmdG9Yd2NZeXBFUVRjcnZFSUVRVFY5cm1nT1dKUDZCbUszZVJjcUxaS0R4?=
 =?utf-8?B?VHN4aDJvbnFKNmZ6SzNUVFg1TW5aNVRhcDg3azYvVVhncHpOYjdOYTZXRjQy?=
 =?utf-8?B?b0ZDWHEzTTcxVlZVNU5Lenh0NUxKR3ZBdGtvVG1vbTBPYXRlN3FUKzBmRHc5?=
 =?utf-8?B?YU92S092SEdWa1haY2JiSG1lQXFDUzJyeFhDOEJWTDErTXQ5aFJJN0QvVUpr?=
 =?utf-8?B?Nkd6eFZ0cWxEQnErMG04UkRVa1ZhRDRCV1J4bnRrVGlrVE5jTEl4VSswUjEx?=
 =?utf-8?B?dXJFandJRU9ZQ05VbFpmT0lhcnhaTE8xbnJDc2hZUGhBQ1lJWmg2OW9wdkk5?=
 =?utf-8?B?dlAvZkZQM3BJdkNYc05EUUN3L28xM0xqNXl6Z0FYOEI4VlBQZHBEbks1QmJK?=
 =?utf-8?B?LzJmQTRjZFZ5am5Gam16T3hoL1hXTHczaG9Hdy9ZMUZkMUI1RG5oUE9tNTZO?=
 =?utf-8?B?OGxPaTVJbkwwUHBJZzhqY0NtWWJuTE9QRm1kYm4vT3R6MGFYcE1HdmxCZFJw?=
 =?utf-8?B?cEUrZkZsdjhmUlYxRGZybXdMZGNUZ3NYVnI4Zkw2MzNrd0x0bG4vTWdJZ3dY?=
 =?utf-8?B?ZFY2SUI0TWh1TXFQbVB0bVQrWEJZTFJLVUtzayt5cCt2dVcybVFHM3hiamRt?=
 =?utf-8?B?LytudTNxN1JmckJTTHdlejU2eW4vNW1BekVzd1IrTjJBWjN0R0dRbjFjRDEr?=
 =?utf-8?Q?cDon9NGabMk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnlsaUVVZ2tOdlEzM2xNZ3llM2E5TnU4emQvZmY4K09kd3lySkoxcWphNFp1?=
 =?utf-8?B?KzRPRzBDeThIOE5adEw0MGFrRXJPK2o5amV5VTlreXZSazMrUHpqN2hlK2U0?=
 =?utf-8?B?bFBHS2d2ZHVQKzRET0xMSDgzSUdlSHpORkdGYkVNSVBTa2sxZ0VqZHpZWm1N?=
 =?utf-8?B?eHM4K2EzNWhGRnJUbVUvNjRrTUpuNUZRV2x0aE53cnpFMjlGZkR6OTZjaXZp?=
 =?utf-8?B?c3JFK05wSTFNSm5KRnNDR0tmaHNGcEl2cVp0SER5d3lVNjVKaTM5WWJrZW80?=
 =?utf-8?B?OFJGcXVidjN1VE5IOENhaTR4VjN3QnBTTE1xQ1RIREY2UkRsc1FSWDQzUE9y?=
 =?utf-8?B?WmdORjdKb295M3RCTnp3V2xsNzVaRzV3VlRTSE9aUmQrYlppclp3Zk1HU3ll?=
 =?utf-8?B?bVRsSGpUL1dreEpMTkRnS0x3Q1dFVEpEY2lwZStnb1NZTXNDQVRFMFRHMlBt?=
 =?utf-8?B?RUQ0L1pwemdvVGduaHUvam1nK080ajNlc2dFVEEvSm9ZeWJjTC9kTEFVeUZ6?=
 =?utf-8?B?MkZ3Qmw3ZU0vVG1MUEdtbTJTeEdjaEF0dmFjSllsYVdLeFdOMURGbVZYTUFo?=
 =?utf-8?B?YmVVMCs2bXpSREFPNUkxZ3JLWEVTNzlrTURyTDJkK3VsQlBSZittRDlJRFg2?=
 =?utf-8?B?UjVZRHovN2JwQ1B3MTJ0K2dHb3VLM3FNdm9WcUtiaENJcUtWeDRJLy8zOHBB?=
 =?utf-8?B?YWRPUVpLeDhSNmxPbjVxd2s4anZmR0w3cUhYOEgwejNWbmJIZFVsK2h3dUlT?=
 =?utf-8?B?UVJyUk5Pb1J3bGNLSUVqZmk2V1ZWVVVDaFg2V2xTaWJSNytrWTV3cHNEcDlQ?=
 =?utf-8?B?d3poWkFpR1FNVWRkYUdRZjNIL0c4aC9XSUZ6TzdJQXY1RTR1alhYOVF0S3Yz?=
 =?utf-8?B?YVk2dEQrYmp6Y0FKeUkxc3dlY29PdjRENnduZlpuQ3Y4TnFtczk0M21ZRytk?=
 =?utf-8?B?a1M2MEVGbE43Yjd2MjlDaURmOUR5Zjg2RWQ5NUdLL3MydGIvOXREZHUycFNl?=
 =?utf-8?B?K0pGeSthN0c0ejd0RWViUkQyVUp0YUdRUGVOeElLaW9LMWhhM3YrSHFYWHI5?=
 =?utf-8?B?RVM5NEF3c3ViZS9SS21tQTRhU1dzb3FGVThnbGhSQ2t0MnFkSlo5VnVjaXlL?=
 =?utf-8?B?N21vKzFraFhNTlAwZ3UzSHFaRzhaekNaOXQ2MEJ0NFlXdlMwcWRzNUlTblU5?=
 =?utf-8?B?bnUxRXorOUo0dkVZWGhDOXNKcDZXOHlna1FPbnU5cC9RWExJb3M4dWlnNThQ?=
 =?utf-8?B?ZHI1cm5iVGhqaVZvR3IwVEVLYVRDeXJPWUpsWTNic0tlbWFKd3Y1TGdpZEJr?=
 =?utf-8?B?V0J4cS8yLzlZa2VTdFIyVFY4ZElXZ3FUS3NVSWtoYkxJcGJDUzZGeWNiV3Ns?=
 =?utf-8?B?cnhvR1gxdUZ5d3laN2NhRE04NDJWL3JpU0UwWHZMVHNuSkFUanFrWHk5aXFy?=
 =?utf-8?B?TXNiWk9Pdk11R3F5cHZsd0VYUnNLNUVtSWdPTDFEZFpJeWFDS3RoQXd4VkNR?=
 =?utf-8?B?d3JrZHhxSWc5bFhIL0J3RWtiaWcwL2duVk1WMVZHc00rSG5peU1XQVR0Z3VS?=
 =?utf-8?B?eVFCamllYTdKOHhlSjl4OHl4OW5HWUsraTJnZ3pMZW54R29RTXpQaFZRSi9z?=
 =?utf-8?B?NFNnckFXZ1U5SzBMVVdLMDVuVzBPYjM2MlJkS2htUks1bk8vUnBNU0pvY0E2?=
 =?utf-8?B?NFNqck1jN0MrbnNXUkhPVTh5bjJnaEtrQzB0Q2Fac3NXWnhjZzZiWmMxK1JW?=
 =?utf-8?B?d3k3OUkzcGVUWTFDSlJzcXR6WGFYNlB5Z0Y0UmFrZzh3QmRVbTRVUUNPbzNT?=
 =?utf-8?B?czNWblIyZUFWR1M5Q2NzMitiVTBXaHNpTXVBakdrRmppR3FBdFhaL084dTIz?=
 =?utf-8?B?dHhtYkZHSjJPc0JuYW5RSWZrNWlKa2VSZHZ0dWFjQUw2OFFWTFFjK0pZUkkv?=
 =?utf-8?B?ZjR5akFKVE1yazVSNzlWT3F0QXRCQWwweU91MEpEMHVOaktNVlVVU2twRUEx?=
 =?utf-8?B?M0VJRndPcThYNGZnWjNFdnhFOVhkbXJ5RFMvL2YvTGUzNVBiNGpyUmh4TkNV?=
 =?utf-8?B?RG85Szg2bWZBWWxjZzJaeVM3TzBINUJSSFZRaHNUcmdKekx1akx2azdKMWlR?=
 =?utf-8?B?UzB2NW4zZkVwQm50dlhCb3pUeXduZXBZcVBTVDN5cjh1djUwSFllNEtxNmwr?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b37f274c-a002-4475-ba2b-08ddc2d3354b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:37:34.6326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXGjn8WV54HLBa8g7qP2eCWoGYEqVDDeMGX5XaUcsJ50/ZNj00iDcotAOB4VYDjUTotg42cOFnvesBVh/0BYEC+j04rRnjirx2W80rViTr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10987
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

Hi Andrew,

On 7/3/25 4:40 PM, Andrew Goodbody wrote:
> In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
> done with the value that this calculates which is obviously not the
> intention of the code. This is confirmed by the code around where this
> function is called.

Indeed, they do check the return code with IS_ERR() which indicates 
there should be something returning an error pointer somewhere, which 
doesn't happen right now?

So this seems like a valid change to do.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
