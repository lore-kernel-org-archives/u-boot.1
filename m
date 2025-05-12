Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346DEC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BB58091A;
	Mon, 12 May 2025 11:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eA65GXiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF8F81DD6; Mon, 12 May 2025 11:55:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32B282162
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnwTR1vABkckG1BW7+5HacPA0QDTFwSxbhwc7ceWthwzrSnPgYF9joM593vVTqnEmUs3xztqp2VvISDX6hRqJFCOHRKYSCoBlD+2c5JAo2CoxKqVuYuAthUJGZTLi+T4hLqZbEDwDsSDzS53gDktWUL8Pgj54rpq0PtVoAg4fXfO8r55bKEDW9pDtH6bh34ySU4wW5frmpzkScLwkUeCP0mocUBsLh3mv+LvPdDrnPRqaigYCcwJ/HkCnz/ssAYpE9c4k9DBvFapw8N1E/56ZXpDQ3axfj/7aUzWB0KdaPJtaV2ueh5JJ3zdioSLrqm5RSJSJzj4i7d40dF4DA7xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkfVPkJsWDlDrIypR4VZygsEm8spZmF8lHgpc/QMhPA=;
 b=K2zizl4VEcmKp85C70Hadawxa+gBRbMdEgcjEQCbAU1yDcHT+T8dgdZan1h14w02ccdkh02tTCjajkorAbrurcxv4dK3QHsDYUg9Stbkl7dB66+VYECP90AQrC5/kCM2REBcuS9ZgHsZWyNzXhbN26IGLDYukdObki5GICa55TMJwhlmOcnzuuegUq88zHI3yz9PKsw7SBlLpd3jP1Sh/Eror9CzA5haUwAtnY3cwzxdLBQN2wHMiRATmBFif0KzEraHCpNIr6B4WKD9nVIzrJhzU/A8PKAkA+w/6nbVm3YHSF37k2sHHjzuHyRt1WaEAtxA92WbJF9nBF1r8iqgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkfVPkJsWDlDrIypR4VZygsEm8spZmF8lHgpc/QMhPA=;
 b=eA65GXiwCP67jVAocKshNVSlla3cLKpP+C+8771QlfU8bi/CeurpNNtugKL01spYe65e2KC6D7GbsxQKING4tiiDzZybWsUxA+yIL5hlcdn//J/K4mTwydNLvnkOzsc7IRCT9UJSEJglvNLUl1aWhAQ4uWuF66mgF9nixrv+osU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7955.eurprd04.prod.outlook.com (2603:10a6:20b:249::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:55:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:55:51 +0000
Message-ID: <1cc1bd87-9265-44ea-8646-740fa32b7156@cherry.de>
Date: Mon, 12 May 2025 11:55:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document test command
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250506205439.415877-1-ravi@prevas.dk>
 <3f0c1dfb-5c28-4160-9a8f-f49ad380bb50@cherry.de> <87v7q641kl.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87v7q641kl.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e1899b-819f-4c9f-26ec-08dd913b2d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BJVktoS29zcy9FaHk2SHllYVM4S1g1aWNPQkExSktxSm9WNHpYS0F1aVFw?=
 =?utf-8?B?cTN1Ym1YWUY2MXVxWTVQVnZzU3ZlV1VEdHh5MDh4OWVlN0ZaeEU1ZVpBN3V2?=
 =?utf-8?B?OUU2bnBDRXRZbDRka2VzRWVtdkxIY1R2NzRLbjFKTklKVGFFT1BZMDBDM3I5?=
 =?utf-8?B?cTkrRnVUVWxrMjNTWHNtZEVFcHRvTm5sVkhQdTlhSGVkNEprK3Y5YkcvcWJ0?=
 =?utf-8?B?NjNIV1JqWTVaOGFOTXZ0VVhITVgzb3BOb0lza3c4TWF1d1p4YVVVTXFGOWVZ?=
 =?utf-8?B?RWU5dnYyaWVxQmhCcW9mT292SXFFNlliNEQ5NEJrZERjQnBrM3I1cCtJTjBt?=
 =?utf-8?B?dUZpdGpRODFyeUhCdFJYdVJ0RVQzQUVrY3pSbGI3eXB4NGNLeWdMalpra2N5?=
 =?utf-8?B?T01LeG04akhOZVpWbk1hK3RLMnp6cCtETjVtRzZCL1piOFZmclYvcXVzamtm?=
 =?utf-8?B?UUYxaEdwUkdOQ1l0RElHc0VydjAxeUlCMmU4dERLTGxhQkpOUkowUlRLdFN6?=
 =?utf-8?B?SGhZU0ZRTWR4b0E1alh1c3czRE9FZW9sLy9xVkdMZ2g2bmdTQWUrZms4dlF2?=
 =?utf-8?B?dXBrNVRnMGQ0NTNRYTk3NC91Yms3bFpZUW11RWJoWUN1RkJYeXIzNVVyK1lw?=
 =?utf-8?B?TGxoUkJpaEJLbmVRK0k5VkFSOUljaDg2Y3plbVo0SUFBQ0dKeFJmR2l2U1dU?=
 =?utf-8?B?ZzhkRlBBV05DTlMvSjZYKzRhckx0RmdRTlJUL013bnlSdjRvbkNEcllxTjFP?=
 =?utf-8?B?bkQzWENYb3puOG9Pem1XVUFXVmFmcGx0K1pjck8vMi96RU0wM1VlTzlCWTVN?=
 =?utf-8?B?VEFvRDFmekY3N0xmeERja3NJL1lpUG01bENvcnA3TVE5TnYvUHVlNjBVNENK?=
 =?utf-8?B?N3BpZndGbnd6ZHZ0bjNOQVFTNnZITkV1UlY5Q3RhTGJHYi8vTm4wUnc0Qkw4?=
 =?utf-8?B?UWd5NVZLRXVOc09OQXFqRmFEMHRHWUpNdmQ3dGRzdTVPTmNjMm9PeFA5SS9q?=
 =?utf-8?B?OEc0QjhlZ1dlZlovT0YyOVAwcGZiNXR4cGY1S3NnSVZqS3JkUlNtd0JrYmhY?=
 =?utf-8?B?QkFEZGNLQjRoa1phVVhJdmRKL2tCeUR6aC94aVc0YWFvVHJjMGFGNmNCZFVR?=
 =?utf-8?B?Zm5YZFkyeXZUMkEvWDlEZ3ZBQkVHRVR0N3VSL0hDeTI1U1k2QlNyblJLOFdN?=
 =?utf-8?B?QzZzSFUzZm56OHo1aE1mOU5USVcybmJZZkRSb0l1Si9uall2elM3bjNJRU5o?=
 =?utf-8?B?L2JUaTFkVEE0dFl0RmVzNTBxKzdQeHBkTmJVdU9wV1dyZDk1aUh3VFM5SGVn?=
 =?utf-8?B?RG5NR1ByWnFHdVA3aktrRUxvWHhEOUYwN2JLVzYxRTV2UlZFdUZoR1Y1QjUx?=
 =?utf-8?B?cXhMYm5jNE5LYWY4b2EzOVoySUpBNythWm1SZ3U0bjEwcXBMRXI3a0ZmTStG?=
 =?utf-8?B?K3dhcHVzNGlURXF1RXNsaGd1Q0FYV2dTaXRFZlYxOXdDMTNhSk5xWjlDbUE0?=
 =?utf-8?B?QnFQejlqSlc2YlFXVFh5RkZLRTZKMWVnTVJDSVRiUFdGT0NEYUhCMzZOZkZF?=
 =?utf-8?B?emNnR2lHVHFpNW5hcGNxZkgvblFaVzlBZ0JQTml6emNhdThzU0dXb2w5WXNO?=
 =?utf-8?B?a0wyRlBxV2dyN1YybWxwSGN4bU4yVnFJRnJzSXNKbmg2c25hc1VyN05MTEV4?=
 =?utf-8?B?MVQ4S2VaNVdhS1FvNzhxTEtvWU1XeUE0K1E3SWxFUU0ybVFsd3hRSjBlV3Ft?=
 =?utf-8?B?NVZKSzNYUFNnVEtVRGdCK0MwV2hIWXh5aUxLYVVTUGQ4YjhoMmE3YlViakFJ?=
 =?utf-8?B?NVVoNzB1RThJa0tydDFFLzZ5MzNKMVF1SmJVcmpjVGVlUExURUJzSFFUOWZr?=
 =?utf-8?B?K1lMei91TktibDZkTkF1YXVzR1FIdFh6TWJPazQvSkd4RTRlVFkzeGY5U0RG?=
 =?utf-8?Q?p+S/Nr4y3Us=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFDeXRYOFduamhwUFlWZEJUZzExZHpGUmpJZ013VkxXVlhEMXVqSnhZT2NG?=
 =?utf-8?B?eFVYK25VWlgreEV2NU5kUkFDUFZMYzkvMlFudCtnZENHWk1QVlI4YlJ5VXVM?=
 =?utf-8?B?YXJJWGF2VEhHWkVQaVVpeHVXVUdUS251U2U4TUlrMFFIY0Nkcjk1S1FqWk9H?=
 =?utf-8?B?UVh4ZVczN2NZQ08rZm9DSlpCLzczL0M1WkZiVDl2ek1tMTA2Wm02aXN3VEl1?=
 =?utf-8?B?N044ckRycndYVk9Cb3VWanVvemMvdmdqV1ZQb1hxdkp1amN4Z3pSOXlyQXlz?=
 =?utf-8?B?eEtFL1VvZ1B5OEdrc0Q5eUkvTjlSZzFEMDVyM3lWUzJLLzdoMURLMnozQ2dp?=
 =?utf-8?B?MzRMSE9KQjJ3bDZHN3BVVzlwWnhwVVVmZ3R6Q1YvWmNlQy9LbkVzT20rYmox?=
 =?utf-8?B?cGtNMFl6VzJYYzhvU1BjeG9iWS9Db2NMbURrWXEvTUxFUXk3YlJHanoxaitP?=
 =?utf-8?B?SlNpd1RVVWIyVS9RUEZwSERNb283NDFXdXNGVW5hQWJjbUoyR0J0Smh1UnIy?=
 =?utf-8?B?ZloxQnRXcEIvTWdSaFc0Y2p6ZENvcHBvb1d2dWtJY01iNVRHamwrbHhvM29l?=
 =?utf-8?B?NVVjRiswYVNIRHIxQms1bFFpc2hndFJ4djZ6cGJ6OVlqNnhELzN5c3NoS3FT?=
 =?utf-8?B?bWpYL0IrTUZXaGttanNwZWZZc3N1aGdla2tMSEJCenBrMlkyK1dTZVFDL1F4?=
 =?utf-8?B?empoTi9EZk54bmNuaW90cHFrZXBEUzUyUWlKanVoZkV6eERLdlVTZDFUQkRz?=
 =?utf-8?B?bEhuWFdSTmxWUmlkYStqQ0p4emdQRmVXY0Q1bjVwYTl0MCtTNlVGcEgxbmZ2?=
 =?utf-8?B?d0FDSkZ3T2dlMFZSOVpQckhSUENYeDNpcmE2TWdrYk1KSzVxRjA4MXEwL1hJ?=
 =?utf-8?B?eDJmaGtsUlJ6elN1UXU4S1hQdVJ1MHlaOU1QMWtlVzFFb1h6WnhrMGd6N0lD?=
 =?utf-8?B?U2JZTXh6aUJRS2xIK24yMWo4UE0ySjRaS1lkaElYSVdBRmxpaW4xRWRRNWZ4?=
 =?utf-8?B?ZU96QVQ3dDJ2QWdUMUNsS1RWaklQMUVIUDRSSDFWWnFKdzBpR3V3NXNKY3hn?=
 =?utf-8?B?a3p6bzRjRmN0UTI2cUlieFJsU1BxYkY3aWVZeXp0Q3M5dys0VnFpWElzTkpD?=
 =?utf-8?B?TWNxcXR0WWRYdEtjcW9tSFgySTdpYnFGazgxYjE3ZkVoTDRMUlliR1B3Z05P?=
 =?utf-8?B?OG1Vc0VPTEllMXNZMjJrRFFiQ0dVNDU1TStSTStyUHlUTElPdUlkamszQXZz?=
 =?utf-8?B?TzZaR0ZXMzZ2Yi9WcWpxSUdlNnNiTHJaUG1hUi9ZNlpRQ2dmQnlnSHNHMVhx?=
 =?utf-8?B?QmQ3VTR4UzRFaGZFWXVsVzExdmtUY05iSmFVdkZ4ci9GcFo0cU1ucEFJSXkv?=
 =?utf-8?B?N1IxWUxncTJpOVJLeXBLUHJxS1VRNnFkY3BTbEM3Y2xWT1hYM3NYT3JySkFv?=
 =?utf-8?B?bTdFVGJIMDJnU1F4TnE1NjQxWEZBYnpaUkhVR0NBbDRVOGFNaGtzZlZNOWVa?=
 =?utf-8?B?blNVb3gvQUhUNVVSaXFmTTdhTS9Zdi80N0FwWE43b0NyclpIOE9TZ1pqK1dm?=
 =?utf-8?B?NElzVVRrbHNuS0pIeEcwamR1dTBOM1JWcHRXVEhZWmVVR0tEaTNZOGgraXhX?=
 =?utf-8?B?TnJmMTl6ZVRYWjR3T1lpbnowVFNrQTlNd3BhNzFnSUNvMi9NNTVtcDV2eHZj?=
 =?utf-8?B?RFRpdHd2eTA3cmVCUVhTeDY2RGFTL2ZkZ0VBd0NhZmEvQzMyS1JIeGlSTnUw?=
 =?utf-8?B?dnR2VUxYdUI3RDZLc2dhTWlqSEk3cktWNEhRdVhBOUNweTAxcFV3T0x6SmIv?=
 =?utf-8?B?S3pqT0NYNlp1NEVUZ1Q3MC81dnFDZFpCaGlVcXFrcFR6OVhVYTl5emNUTDZo?=
 =?utf-8?B?M3g5MGZnMG0rOVRkV3g2Rmg4NnZQU1RRYW1mNWF4NjkyV05YQ1E3S3I3NlB5?=
 =?utf-8?B?dHIyeGtaTzc1STMvTytjTFdIR0FkUjNoaVlvLzVxWTVYVVIvUHVjaGFNOEV2?=
 =?utf-8?B?bHhiRExwcE9FbVJDbG5iQlY5cjlUN0xoQ1ZNQkRxTXRXMXRxeUtITVBGT2Zp?=
 =?utf-8?B?azVpdFpkcklWUFIyWnpKVXA3aU11SWkrOTlMUGtOYjJieCtkZWY0ZUFhRmp3?=
 =?utf-8?B?QTlOaHVLQWVBUUI3VzdFZkVZTDZ4QVNKemRzVUE3alpndkU2ZXlNeDFndmV3?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e1899b-819f-4c9f-26ec-08dd913b2d75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:55:50.9820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksaFx7lAsxXCaqLWHVx0pgv1na8zaj4Qi5jPp2pDOcJiNJUpHFqqsP2iyvtj9lKuPO27weLKCy2W+xv90FOAIng8LcuaC3Kmo8Q/6Cu07Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7955
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

Hi Rasmus,

On 5/12/25 11:31 AM, Rasmus Villemoes wrote:
> On Mon, May 12 2025, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Rasmus,
>>
> 
> Hi Quentin
> 
> Thanks for the review.
> 
>> On 5/6/25 10:54 PM, Rasmus Villemoes wrote:
>>> +
>>> +Numbers
>>> +~~~~~~~
>>> +
>>> +The number comparison operators ``-lt``, ``-le``, ``-gt``, ``-gt``,
>>> +``-eq`` and ``-ne`` work as in ordinary shells.
>>> +
>>> +*Note*, however, that the numbers are parsed with ``simple_strtol(,
>>
>> Maybe use an admonition here?
>>
>> Something like
>>
>> .. note:: Numbers are parsed with ``simple_strtol(,0)`` ...
>>
>> so it's (hopefully) properly highlighted?
> 

And re-reading myself, we probably want:

.. note::
    Numbers are parsed with ``simple_strtol(,0)`` ...

here :)

[...]

>>> +prefix, any errors in parsing are ignored, and parsing stops as soon
>>> +as a non-digit (for the selected base) is encountered. And most U-Boot
>>> +commands that generate "numeric" environment variables store them as
>>> +hexadecimal *without* a 0x prefix.
>>> +
>>
>> ``0x`` ?
>>
> 
> Hm, perhaps, I'm not sure if "code" highlighting is the best for those
> 0x, but I agree that some highlighting is in order.
> 

Fair, could be also `0x` if you prefer how this renders, I don't think 
U-Boot is too picky about those.

[...]

>>> +  # Assuming readme.txt exists, sets 'filesize' environment variable
>>> +  $ size mmc 0:1 readme.txt
>>> +  $ if test "$filesize" -lt 4096 ; then ...
>>> +
>>> +If the file size is actually 8000 (decimal), its hexadecimal
>>> +representation, and thus the value of ``$filesize``, is ``1f40``, so
>>> +the comparison that is done ends up being "1 < 4096".
>>> +
>>
>> All nicely explained! Can you provide an example on how to do this
>> properly though?
>>
>> I assume something like:
>>
>> if test "0x$filesize" -lt 4096 ; then ...
>>
>> maybe?
> 
> Yes, I think that would be the proper way - but it's really messy,
> because if you ever have some variable that happens to contain a hex
> number with a 0x prefix, adding another 0x in front would end up
> yielding 0 when parsed. So I don't want to give the impression that one
> should always blindly prefix 0x (also, sometimes one really does have a
> decimal value). So I'm actually leaning on leaving a "positive" example
> out, to force a developer to think.
> 

This is terrible :/

We now need to figure out if a command modifies environment variables to 
contain hex values, returns hex values, or simply decimal values.

Nothing that is coming from your doing in this patch though :)

[...]

>>> +Regular expressions
>>> +~~~~~~~~~~~~~~~~~~~
>>> +
>>> +When ``CONFIG_REGEX`` is enabled, an additional operator ``=~`` is
>>> +available. This is similar to the same operator available with bash's
>>> +extended test command ``[[ ]]``. The left operand is a string which is
>>> +matched against the regular expression described by the right operand.
>>> +
>>> +The regular expression engine supports these features:
>>> +
>>> +- Anchoring ``^`` and ``$``, matching at the beginning/end of the
>>> +  string.
>>> +- Matching any single character (including whitespace) using ``.``.
>>> +- Character classes ``[ ]``, including ranges ``[0-9]`` and negation
>>> +  ``[^ /.]``.
>>> +- Grouping ``( )``.
>>> +- Alternation ``|``.
>>> +- Postfix qualifiers ``*``, ``+`` and ``?`` and their non-greedy
>>> +  variants ``*?``, ``+?`` and ``??``
>>> +
>>> +For extracting the parts matching a capture group and/or performing
>>> +substitutions, including back references, see :doc:`setexpr`.
>>
>> Question: Should we provide an example use case for each test subcommand?
> 
> I don't think so. I'd assume any U-Boot developer to be reasonably
> familiar with the ordinary shell test, so I think it's better to just
> emphasize the differences and gotchas than providing "shell 101"
> material.
> 

Fair enough!

Quentin
