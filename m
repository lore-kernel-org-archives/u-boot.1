Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237C3CF58E4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9101489351;
	Fri, 20 Sep 2024 09:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y6OC9/MY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B54893B5; Fri, 20 Sep 2024 09:35:17 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C81089325
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuNTgprc9oVpdtbMUP+b77RhBiCsjAzKQWauatYaakN6DvRwSAuFo9RnMX9fLh2VmhcBxSY0AgDC4hbhBit25MPsjOy26yifHg1PYY1i3LXXKsST/GJnFwgtIDrQAL1ltoOEd9JXV6W0q+T3ScGaXqMlQ8dQmzIOUz7LyBR6EdjDswZyplCUGTrm7MJkz11Xxoj9wGdl1AaKsJ2S30bttAXaDl5wwrRKedatJtuauVxzcO+KR/kmwSBWXzBe8jlmjsrhFfRf0mS9bm2qKFz4fQcAG3h9g+SrJkEqCe0adbfvzdeOOctJA9VE2PDJFzSw9Jy+dwOoyr5MXJzEb5nHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5skCsJStVmQB6IQuHHVauUXYQZD5fv0qmKhkAmuWmA=;
 b=ebYlT+9FPYxbU4ZjplPZmyWvpVSTOPEm/JIwBzxrPyCA+SyZ9W6J5YO2+HIcbZ/x+LvsuXi9HPsjkVj9Ywdaow88U54ofE6RoBIgMc/Kj77SH+5XyjkNRUxBAr0trvQuS8hagmrTk5nLH/3Z7rji2gXTetjQa2CmBktPZyJ0a4OVrBsB9wH7ChAmfdNSuFh+mmg31v0kZwTQncVhFjIy/jKBBLvKZ0QDhGKIvoTNJfdyXOLnVyQ2VNck7MWRLV0bUjWR5tVCskylTTgYVAbhyfpPwLK/XSU5jD/p1cW04Ox+So93hWMpvukBggvw2/ag0l1tIblQVjybGQ8bGfBKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5skCsJStVmQB6IQuHHVauUXYQZD5fv0qmKhkAmuWmA=;
 b=Y6OC9/MYkTlj4eLGJ2xKn9mIa4OhMiMugb+C+7zFrqzD3N1eINgLD2++QRFeU3MXN50f1y3td9iQovQO9M9+ez9Z2OduP9C/f5FJHHNChbj7RgHvW6t7XdWYHKeC7M7+Zbxd0mqAGRgcbwCrfu0uyYBDIVx/qEDtO7OxR3u4nsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 07:35:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 07:35:06 +0000
Message-ID: <f35c7002-0312-4ce6-82df-c91635898a39@amd.com>
Date: Fri, 20 Sep 2024 09:34:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/8] spi-nor: Add parallel and stacked memories support
To: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, jagan@amarulasolutions.com, git@amd.com
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
 <9ab7d67e-1e6a-4176-b448-7724b0ce7615@amd.com>
 <20240919220545.GV4252@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240919220545.GV4252@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0058.eurprd09.prod.outlook.com
 (2603:10a6:802:1::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: f0282fc9-e0e8-4a0f-5819-08dcd946bf49
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWU2Sm16dDVzTWYyVVRoT2V6TXlpSkx2dGFDR0dUZWVFckxJdWs4VXpZZndV?=
 =?utf-8?B?RWZoVGlkcE1DaEZZWnVmcVBkcWh0VlRKaTYwTHZwL2FqUWhCaU5rSVpxd0VW?=
 =?utf-8?B?K09MeDNRMDlhTWU1MUdidUZPR0dvSE9kcnptQUY5ZzRTMjgyaUxTMEI0WlJz?=
 =?utf-8?B?d05FWTRGelNHcnFMeEhtMExXTlhzWnNpOUJET0UrK1ZGM21hNGd6Zy9MUTZX?=
 =?utf-8?B?enA2eEVVdEFJdGQrUk9mc21mais3VmJ0UEVaeStwL3RqRzgwMjZacmE1Lzc2?=
 =?utf-8?B?cjlUVk5QaUpaUHlqV3N5QW81M2lTSWwva0xLbDRlN1FZelV6dFpoNkJlZ0cw?=
 =?utf-8?B?QnZ6VjN0U0h0VTNkbzRnMVZjNC94bTV6emtwSnB4a1pTaGJxbnJhT3dXZGZK?=
 =?utf-8?B?c2lOL2YwZ2RGWmFkQWNsZXZtY1RoNDZFNnNyVUw2QlBpS2Evc0gweHFRNEFt?=
 =?utf-8?B?MkR4d08yUTlVanVreG9zeHBVSWN2aXVqcm5ENXJCQ0swT0VXcW5QbjlJLzBT?=
 =?utf-8?B?eS9Rcy9GNDdkbjNJUytZUFpKaEcrbDE1L09FZytrSmhpQmtPeTZacGQyQnZq?=
 =?utf-8?B?eFZQTHJHSjMrSTBKcHRnYmZnV1A5Q3JjUmhEenVGNWtjbXZsUlRHaEJid3lK?=
 =?utf-8?B?ZjI3dDFqWlFiVGxVNm5PWkM4SElLKyt0S0o1b2NFSFFZSHppaE9LSEZReXB0?=
 =?utf-8?B?UVJGVk94VXNMMFYyYklyM1JNWW1laVNuUXFQSURCSzRlT0JpYWF0UGZKNmcv?=
 =?utf-8?B?NnJEVUgxb3NONFZuNW0wNk9IdkZBV2VFdTJWMzRsNzlpL21KQTJoL1JsT1ZS?=
 =?utf-8?B?VTZTK2dxdWtWT1htZGlDMERhRzdpRTJJOHN6VlViZFI0SzdJeDNFSEFlQjBB?=
 =?utf-8?B?clBhNDNxaUh0MmsvRFR5YkJ5QXRnOHg0ZHR3c0ZjWUhGQzB3M1M5UldKTVMx?=
 =?utf-8?B?OEIxVEdQaEdBeGpTY1IrS1RBd1k1Y1EwdCtpUEhmNWd2eENzSXZveVh6YUNP?=
 =?utf-8?B?bDhyN3pSSnBUekRCUi92UjRtdmtRSUJ4L3c1elg5ZGZxSk1VRTkvcXFrZGtS?=
 =?utf-8?B?dmFVMGlMam15UURpajZvMVltc0JxTFBYeXZCUVdES1VvTkNTS0htSm1MbUs1?=
 =?utf-8?B?b2c3MmVEUUl1ekxtN2tFTFpWNllEd3pMNjhtcW5tU1lsUjZTMWc1NkJPSUl4?=
 =?utf-8?B?WkNodFdNYWZkK2xRWG1rUUdpa2E1eVhlQldQRm80UWJnRmltQWJoelo3N3gz?=
 =?utf-8?B?SWN4RUJZeWhkSW8xU09pZEJINXBBOHkvNFJwcUVuUWJYUXF2QkVYZ2VpdG1V?=
 =?utf-8?B?Um1ncXVzZVBIN2FMRGUxTmdWMS85T081TFQrcTM1SGJiVmdXeU5oZDEvUmtB?=
 =?utf-8?B?eGlVOVBtUWxXUDFOSyt3NWdwc1JITldsZ2E1STM2c3R2dlRBQ1ZnSjJFOUFT?=
 =?utf-8?B?QUJrUWxLRGxlbnVvZ0xaZFhGNHdUK2x6elFIdVpTY2hSaDlNczJDV2IxelB3?=
 =?utf-8?B?dkFKRHJrWmRqc2RpUGdtSTdVWmI1YVJMSDBvdWVka0krUmUzQ2RlblVpUkJL?=
 =?utf-8?B?dHNqWXdQUXNDd2Vib0ZVVEhvZnM4K0UxYWwxSFh6NUhNSGdpclV1RFZKbnFV?=
 =?utf-8?B?R3RmUmVRNCtHUHB6YmN4NktNa1lHZDAwTXVzYzBJNitGM2xGRnZhQXVpRFZO?=
 =?utf-8?B?M1pMejJuVjJyRjI4cUNteWVQQWV6Rm81V3ltR0p0TlhGQXBodFoxVHJicXJ0?=
 =?utf-8?Q?QTbm+O4MDUu2j6lARY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVhObzFSdWttOWo1bk9yRzhUZUtiV1EwVEtIYzBTOUlUT2s0VFdHU0tWSGJz?=
 =?utf-8?B?czhKTk1aQTVWU0VrN2NwYm4xRElIQUlMTjhjYnB5S09PZWtYSklrNkhzUEs2?=
 =?utf-8?B?M1JLQThuNmlqeExuZ3FVMnNVcjZ6cjI2aHE4V2hrWEFwRWpWOFYzek1PY3ZE?=
 =?utf-8?B?WEM0YzJleElyOXdQUktpRnBCZVRBTjdWNHlVZTVXLzJSaFk2U0NqYXpveTlW?=
 =?utf-8?B?STlhMU5yTWJ5Q3RWN2ZpV0F2cldTT0JsMDIxVU9QQWVpOXVwQTc2dlJ6NGlG?=
 =?utf-8?B?U3gxclF6dnFia3pSbk13NlZOSUEwNnRNdExMZVZDY21uRmZiaWlyaUdwMUVi?=
 =?utf-8?B?Q1VIcXhSRVFHejhyVWhESnNidGM4a1FoYW5TNU1TaGl0NWtRWERkTUQyOC9w?=
 =?utf-8?B?cHRteUJuQUs1ZU9MUGZURVU1a0JpTWJ3eDVYb3RLTDhlNzVhVVZBK2IvNHBO?=
 =?utf-8?B?aWl6U3pUeExucy9CUmlNekhzTHJVSU5KWUpJVUhOMVNEQ2hnWGdDUmloUVdO?=
 =?utf-8?B?MGZiT1ZubEVlUEVlRGZLQkR5MFA5OXloOUJ3V2J5YlVWNWEwTm1EUHE3cmxm?=
 =?utf-8?B?cyt3YzFieWFzME1zZGh4TjNua1E5SkUzOEc1R0xqZUszUUNEVmcreDZkQ29F?=
 =?utf-8?B?UUpOR0VKYS9iOEYvV2VJMUp4aU9aOGZ1OFk3SmJvM3FkT2hPallLZ3JXUUN5?=
 =?utf-8?B?VWJhL2tDd1hkY09CWGJDSlZUbEdSclg1aDYrODVUZkkyNmhpdEdnLzlGOFdh?=
 =?utf-8?B?STcyUHYxSWRsa29yUTV0a0RBVENrcERiZXFlR2xSeDJHaUhnNG9nb1JJbXFY?=
 =?utf-8?B?OWFTZUhodlNhZUtqSXBBU2F3OVN5Z3QzNDZMM0xGbEY2V01vQ2FBSi8xMERN?=
 =?utf-8?B?cDVJbWNhTHFYc2c5b1hLZllXVHI4QVdQSWVXSE9OTkN5d20wUnFtNHJzYlk1?=
 =?utf-8?B?bXZ1NDVSYWxCZThmNngrOXF1c0oyekpqZVQrSkVTUFE0dUhZQU91YSt4ZG9J?=
 =?utf-8?B?cjVqOEljR041YzFSdkREU1FzajUzR3kvU1VQYWxBUW1vN2VYNXNNTS9mQzRU?=
 =?utf-8?B?WkRLaGZQNDIyMnBBNzVRN1M4TlE3dEJaK1UrM0JnYnVHQ2dHeWdxbmQxYjYr?=
 =?utf-8?B?N3d2alo0YVFmaVlLMXR5TWwyMkZYSmZabjdESDJCVS9UMWc3MHlYMEJIV2ln?=
 =?utf-8?B?RmNHQnZ2UWU3MEcza0wwZnJxVGxRQmtrdHJraWJzdklrSkNldkUyb2FrRmh0?=
 =?utf-8?B?ek4zcWxHQ2JSZ0hPc3dVV04vSmM0ajI4ME5ZaTc0VHZEbFZrKzNtVUNDQmpU?=
 =?utf-8?B?cndab0lvbmg3VUQycDFmYmpRMFhxb3AxMmFzWjNyeE9VWFhDREJGRGtZbmEv?=
 =?utf-8?B?cjZEQmZtYW44TmNmVStlQ2pRQmJQVms4b2taSjgyNGRVTXQ1aXFXeTBTZWFM?=
 =?utf-8?B?ZlVLblZMZ2ZLMW52NUpnaE5GMkZQaHRndUJUZHBNVm92K2NPVnE4TGR4T0tO?=
 =?utf-8?B?WllKclExTzBIVXVndUoyMlYyREhlMVN6L0tNbm0zNHF4UHE4NkM4Nk1aQ2Nk?=
 =?utf-8?B?ZWMveXMxT1B5UU9PQlI5Tkd0RkRoNmYvLzNwaXJWY0FFOXdId0NSUkxSRlRM?=
 =?utf-8?B?Vzc5SDdhcDJ2RkxZWllVaW4vQlh1aEt4Yjdhd1RhODRLS0NuSzc1RDdQTjIx?=
 =?utf-8?B?U3E4ZWFmY3NKd0V5cE03T1dNRWZtUzZnQUVGMFRuU0RKLzlWeGp2TnVmSjNL?=
 =?utf-8?B?djhJWDQzS1REcmJCcEZyYTV6NHBUQXdwZm9UWURiSlZvSUZGOGk2blpkdnlB?=
 =?utf-8?B?Slg5UHpZTjNrdm45RkdJNGQ0S2lXQW5kcHBHN3U2aHMrR1ZPYVdFNWd4Y3A0?=
 =?utf-8?B?bXUwb1BwVUhUNjduQ200MkhOQ0tBbHJtU0Yyek1qYUNyazV6aWUyUzJRWm1T?=
 =?utf-8?B?Q1R6OEVxQ0ovWTRaRnRTcnJrdndPZ2VCelIzVjYvR2ZpU2lHQ3hnWVJWd1ky?=
 =?utf-8?B?QXc2Wm9lODBOTy9JKzUxYWNpS0xCYzNHWE9TT2dJU0FDR29FS1VkdGtPWlZN?=
 =?utf-8?B?RXNZT2FiT1laSGRoZG1kcGlkdEk3am1UbXNlaDI0dXBOcWhtK0cwWlhJYVJM?=
 =?utf-8?Q?KJLqjhbvzs7t1YzuNnlfHQUIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0282fc9-e0e8-4a0f-5819-08dcd946bf49
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:35:06.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC9/IkvDG9GUoZfHFUdFFm/6LUzVidSm+zeN+iJ2DRX7Bv5Z+5mXljm6pfXW9Oux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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



On 9/20/24 00:05, Tom Rini wrote:
> On Wed, Sep 18, 2024 at 01:18:10PM +0200, Michal Simek wrote:
>> Hi Tom,
>>
>> On 9/5/24 05:21, Venkatesh Yadav Abbarapu wrote:
>>> This series adds support for Xilinx qspi parallel and
>>> stacked memeories.
>>>
>>> In parallel mode, the current implementation assumes that a maximum
>>> of two flashes are connected. The QSPI controller splits the data
>>> evenly between both the flashes so, both the flashes that are connected
>>> in parallel mode should be identical.
>>> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
>>> nor->flags.
>>>
>>> In stacked mode the current implementation assumes that a maximum of two
>>> flashes are connected and both the flashes are of same make but can differ
>>> in sizes. So, except the sizes all other flash parameters of both the flashes
>>> are identical.
>>>
>>> Spi-nor will pass on the appropriate flash select flag to low level driver,
>>> and it will select pass all the data to that particular flash.
>>>
>>> Write operation in parallel mode are performed in page size * 2 chunks as
>>> each write operation results in writing both the flashes. For doubling the
>>> address space each operation is performed at addr/2 flash offset, where addr
>>> is the address specified by the user.
>>>
>>> Similarly for read and erase operations it will read from both flashes, so
>>> size and offset are divided by 2 and send to flash.
>>>
>>> Changes in v2:
>>> - Fixed the compilation issues.
>>> Changes in v3:
>>> - Fixed the CI issues.
>>> Changes in v4:
>>> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
>>> - Fix the compilation issue by including the DM_SPI config.
>>> Changes in v5:
>>> - Fixed the issue reported by buildman.
>>> Changes in v6:
>>> - Fixed the issues reported while running the sandbox test cases.
>>> Changes in v7:
>>> - Fixed the issues reported while running these da850evm_defconfig,
>>>     imx28_xea_defconfig configs.
>>> - Fixed the issue when DM_SPI config is disabled.
>>> - Fixed the issue while running the sandbox_noinst_defconfig with spl
>>>     ./spl/u-boot-spl -d arch/sandbox/dts/test.dtb
>>>      jedec_spi_nor spi.bin@0: has no valid 'reg' property (-12)
>>>      jedec_spi_nor spi.bin@1: has no valid 'reg' property (-12)
>>>      ### ERROR ### Please RESET the board ### Changes in v8:
>>> - Fixed the compilation issue with imx28_xea_defconfig.
>>> - Fixed the SPL size issue with the axm and taurus defconfigs.
>>> - Rebased the patches on top of next branch.
>>> Changes in v9:
>>> - Updated the commit log why SPL_FIT is being enabled.
>>> Changes in v10:
>>> - Added the new config SPI_ADVANCE to fix the issue while enabling imx28_xea_defconfig.
>>> Changes in v11:
>>> - Removed the unused variable, corrected the type of variable and replaced memcpy with memmove.
>>> Changes in v12:
>>> - Fixed the compilation issue with mx6sabresd defconfig, as the binary size got exceeded.
>>> Changes in v13:
>>> - Fixed the compilation issue for imx28 by making bisectable.
>>> - Disable the config SPI_ADVANCE by default.
>>> - Rearranged the patch series order.
>>>
>>> Ashok Reddy Soma (2):
>>>     mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>>>     mtd: spi-nor: Add parallel and stacked memories support in read_bar
>>>       and write_bar
>>>
>>> Venkatesh Yadav Abbarapu (6):
>>>     config: mx6sabresd: Default don't enable the flash lock
>>>     mtd: spi-nor: Add parallel and stacked memories support
>>>     spi: spi-uclass: Read chipselect and restrict capabilities
>>>     config: xilinx: Enable the SPI_ADVANCE config option
>>>     spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>>>     spi: zynq_qspi: Add parallel memories support in QSPI driver
>>>
>>>    configs/mx6sabresd_defconfig             |   1 +
>>>    configs/xilinx_versal_net_virt_defconfig |   1 +
>>>    configs/xilinx_versal_virt_defconfig     |   1 +
>>>    configs/xilinx_zynq_virt_defconfig       |   1 +
>>>    configs/xilinx_zynqmp_virt_defconfig     |   1 +
>>>    drivers/mtd/spi/sandbox.c                |   2 +-
>>>    drivers/mtd/spi/spi-nor-core.c           | 400 ++++++++++++++++++++---
>>>    drivers/spi/Kconfig                      |   6 +
>>>    drivers/spi/altera_spi.c                 |   4 +-
>>>    drivers/spi/atcspi200_spi.c              |   2 +-
>>>    drivers/spi/ath79_spi.c                  |   2 +-
>>>    drivers/spi/atmel_spi.c                  |   6 +-
>>>    drivers/spi/bcm63xx_hsspi.c              |  42 +--
>>>    drivers/spi/bcm63xx_spi.c                |   6 +-
>>>    drivers/spi/bcmbca_hsspi.c               |  34 +-
>>>    drivers/spi/cf_spi.c                     |   6 +-
>>>    drivers/spi/davinci_spi.c                |   8 +-
>>>    drivers/spi/fsl_dspi.c                   |  18 +-
>>>    drivers/spi/fsl_espi.c                   |   4 +-
>>>    drivers/spi/fsl_qspi.c                   |   4 +-
>>>    drivers/spi/gxp_spi.c                    |   2 +-
>>>    drivers/spi/mpc8xx_spi.c                 |   4 +-
>>>    drivers/spi/mpc8xxx_spi.c                |  10 +-
>>>    drivers/spi/mscc_bb_spi.c                |   4 +-
>>>    drivers/spi/mxc_spi.c                    |   6 +-
>>>    drivers/spi/npcm_fiu_spi.c               |  14 +-
>>>    drivers/spi/nxp_fspi.c                   |   2 +-
>>>    drivers/spi/octeon_spi.c                 |   2 +-
>>>    drivers/spi/omap3_spi.c                  |   4 +-
>>>    drivers/spi/pic32_spi.c                  |   2 +-
>>>    drivers/spi/rk_spi.c                     |   4 +-
>>>    drivers/spi/rockchip_sfc.c               |   2 +-
>>>    drivers/spi/spi-aspeed-smc.c             |  28 +-
>>>    drivers/spi/spi-mxic.c                   |   6 +-
>>>    drivers/spi/spi-qup.c                    |   4 +-
>>>    drivers/spi/spi-sifive.c                 |   6 +-
>>>    drivers/spi/spi-sn-f-ospi.c              |   2 +-
>>>    drivers/spi/spi-sunxi.c                  |   6 +-
>>>    drivers/spi/spi-synquacer.c              |   4 +-
>>>    drivers/spi/spi-uclass.c                 |  34 +-
>>>    drivers/spi/stm32_qspi.c                 |   2 +-
>>>    drivers/spi/stm32_spi.c                  |   4 +-
>>>    drivers/spi/ti_qspi.c                    |  14 +-
>>>    drivers/spi/xilinx_spi.c                 |   6 +-
>>>    drivers/spi/zynq_qspi.c                  | 121 ++++++-
>>>    drivers/spi/zynq_spi.c                   |   6 +-
>>>    drivers/spi/zynqmp_gqspi.c               | 141 +++++++-
>>>    include/linux/mtd/spi-nor.h              |  12 +
>>>    include/spi.h                            |  23 +-
>>>    lib/acpi/acpi_device.c                   |   2 +-
>>>    50 files changed, 795 insertions(+), 231 deletions(-)
>>>
>>
>> Acked-by: Michal Simek <michal.simek@amd.com>
>>
>> Any comment about this series?
>> It is around for a while.
>> I pushed it to CI sometime ago and nothing has been reported.
>> FYI: https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/22232
>>
>> Tom: If there is any other comment can you please merge this to next to get
>> more testing on other HW?
> 
> Fair point, and sorry for the delay on my own feedback here. The problem
> I see right now, and iot2050 is the platform in front of me in my logs,
> is that SPL is growing by 1344 bytes from this. Full U-Boot is as well,
> but that's a little more tolerable, if we can't avoid it. But we need to
> try and avoid that in SPL.

I played with it and pretty much some save can be saved if we use some ifs and 
one trick. I c&p it below. Especially the last one is something to discuss if it 
is acceptable solution. The aim is to get conditions to if (0) and get rid of 
that code by compiler itself.

And in connection to platform you mentioned. I tried to enable LTO and it looks 
like is saving a lot of space on this platform. Isn't it something to consider too?

Thanks,
Michal


diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6ed90cbf5666..81531c256f62 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3041,7 +3041,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
  			       const struct flash_info *info,
  			       struct spi_nor_flash_parameter *params)
  {
-#if CONFIG_IS_ENABLED(DM_SPI)
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
  	struct udevice *dev = nor->spi->dev;
  	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
  	u32 idx = 0, i = 0;
@@ -3165,7 +3165,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
  			memcpy(params, &sfdp_params, sizeof(*params));
  		}
  	}
-#if CONFIG_IS_ENABLED(DM_SPI)
+#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
  	/*
  	 * The flashes that are connected in stacked mode should be of same make.
  	 * Except the flash size all other properties are identical for all the
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index bf987ea4327c..005a6626dae7 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -514,25 +514,19 @@ int spi_slave_of_to_plat(struct udevice *dev, struct 
dm_spi_slave_plat *plat)
  {
  	int mode = 0;
  	int value;
+#if CONFIG_IS_ENABLED(SPI_ADVANCE)
  	int ret;

  	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
-
-	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		if (ret == -FDT_ERR_BADLAYOUT) {
-			dev_read_u32(dev, "reg", &plat->cs[0]);
-		} else {
-			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
-			return ret;
-		}
+	if (ret == -EOVERFLOW) || ret == -FDT_ERR_BADLAYOUT) {
+		plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
  	} else {
-		if (ret == -EOVERFLOW) {
-			dev_read_u32(dev, "reg", &plat->cs[0]);
-		} else if (ret) {
-			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
-			return ret;
-		}
+		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+		return ret;
  	}
+#else
+	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
+#endif

  	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
  					    SPI_DEFAULT_SPEED_HZ);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b0e9df4271e0..d5f4faf0a68d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -303,8 +303,13 @@ enum spi_nor_option_flags {
  	SNOR_F_BROKEN_RESET	= BIT(6),
  	SNOR_F_SOFT_RESET	= BIT(7),
  	SNOR_F_IO_MODE_EN_VOLATILE = BIT(8),
+#if defined(CONFIG_SPI_ADVANCE)
  	SNOR_F_HAS_STACKED	= BIT(9),
  	SNOR_F_HAS_PARALLEL	= BIT(10),
+#else
+	SNOR_F_HAS_STACKED	= 0,
+	SNOR_F_HAS_PARALLEL	= 0,
+#endif
  };

  struct spi_nor;



