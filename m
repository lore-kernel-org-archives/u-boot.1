Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C580C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCDF87873;
	Thu, 11 Jul 2024 13:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="om0DBwgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F74F87CDB; Thu, 11 Jul 2024 13:59:48 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D755A8751B
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdy53WfIJw8WzKuhgc85CRt5QXWfjxCu5oad82UtOSbhx7wU2wBCChV+VUybU7ngfMbvY3ZUAjdP+oELVNzEnd+xum9hNGKbg/XbIbBoJ8noRoCSxWJZORuGuHPMqA6ObT0CZ+9o+LAf1yKq3/ONmijdKGfP7ddEL+UnzkE17yI2gCFSgpEc6k7x4q6z2pW/5cfu5X9Q+l/FXDVe6PsgDsD2CC0VQ7KmsHuLQB6VguH+m0/7f9Ztex9Yb6vV0tjugVCcgT6nkag2TjKeGc2bJ0NQ8wWiKdKnnuTofBmzm5LgVGo08T1CfLEyK44Fu1ab6lQU5jKCsqyffcV0oG2OIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGW1z+RX/W+bDfpw15HBOG9KLj2yC0ZtXamtY1EXcyk=;
 b=owQdLip4M/6DX62MJGbDFh8QHejogRWtDs5WilAUgmIUGJN/0i607BQRcvP4YcFlxWVohkTZBjOefCs8xCgnaVai2rd6jPFcuPnTmwq7v2xEx69CZ+YSW565vyl+pAK5Pycjt9FBvOjvVI9mm87hkapz8PnEVI+DSggAwATiVz546k3CRCGOA+2MveF64nmPJkDn0x/F8c/2tR9YfQUMAAcN7AJcnAJ/xRvaBEzb5JPe7uclg34JxrLanxhlQrZQrX9/GB92D4UzcSpSb6+xFIbz7FMFSQnvKYttw3b8qs6RpsMIuCPs9LfdifmWEGeHF3sULfMYxYZp/OyMt/uPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGW1z+RX/W+bDfpw15HBOG9KLj2yC0ZtXamtY1EXcyk=;
 b=om0DBwgE2VxnnJNNKVihO+YKtvKB0mHz0UzDk0lMQxK0eQX54zSf1KJA/kpvG2yXZx3PnofKyq5JDzODoUW1h2KXG+gjVWuA9U0NE2tQn7o3RhDnH56MP6xRd+7kLPlU4pjs+HyZ+GgHTHgpb+/Iva9yVErgAbMl/2Vb8tktjq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 11:59:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:59:42 +0000
Message-ID: <1886c74b-984a-4460-83a2-feb84ce6e5b3@amd.com>
Date: Thu, 11 Jul 2024 13:37:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] env_spi: support overriding spi dev from board code
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, trini@konsulko.com, vigneshr@ti.com,
 git@amd.com
References: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 925fe17b-9af8-48fa-1b32-08dca1a0f296
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFhmU1Z1N0dXdTRFY0NhSFloRG5IZmdhd2gxVUdJSXZFbzRVbnRScXVudE5Y?=
 =?utf-8?B?WEpabUlKUUxkWnJZLzc1VjVtMmRVZGpNN09MWE14SUlqYUg3M1dETlFhR3Mv?=
 =?utf-8?B?NWZmY2dYUzcrVy9rZDNXT2VnRHFxV2hqdW5NekRHSHlKTTZhOHlJQU56Q1hI?=
 =?utf-8?B?K2wvcktRc0hqZUtnNHlaNlpCaGczam9kd2pta1BMcDhDQjRnWlNyZUtlTDI5?=
 =?utf-8?B?aVdLS2tocVd3ckN0R2prMktHNkF1MHhSTXYxaHhLeU8zY3VKN25yQnZHZmxQ?=
 =?utf-8?B?NC93TTBKRExJenRTNWNoQ1pUOGQ5WjZuNjBEMTdieGluYWlKckZLMlZtOEVy?=
 =?utf-8?B?aW4yRGFMUFBHUncydDZuSW1tT2hWblVWV0VPYzljOGRzVUQ1elN2elRKVnU3?=
 =?utf-8?B?OGs3NGtUTEJFOFltc056Zlg3eFpNcFZpc2c3bjRkZWtPTXRiNURQd0NueGtI?=
 =?utf-8?B?R05BQzdZUWJHSDBoMUFQaU5yMkZuVHBnUUs5RkVvTXFmQmx3bVpWN2IrTjVG?=
 =?utf-8?B?eVZNWG5aMjlIZXVwdXNWb3c1d3JZSktSdmR1eVZVVzFkcXNsRXFKVlV4QlBa?=
 =?utf-8?B?Zi9yY1pCVmJidm1ZODlWL3FyNTdncllpSjRzTklKdGYra1BoaGhIdlF1LytM?=
 =?utf-8?B?K1ZZcytKOVJBSDNLUUR6N2dGcmlqOHpkajl4WjVWeHAybmk2TlRxQmJqN01E?=
 =?utf-8?B?WVhsOXlveHJNcnF6TnBXeU9JY0NQMk5GWFowdnY0ZlVvTkVod0dRNGNFc2VJ?=
 =?utf-8?B?M1BENG84eVBjd2RWRFBvYUpXdit1d1ZtNDRLdTR6OVJiaG96alVHeldBYkpR?=
 =?utf-8?B?VUFMdXpFQWlpNC96bmlFRjhzcGFVMlU2bHdMeEJyWk5MRXN6bmV3cWM0TFht?=
 =?utf-8?B?VGovUmlqSzdXR01SU0NKQm5jSWN4ZlkyY2NKU2hqeFZCbXlDM3hVenYveHZX?=
 =?utf-8?B?SW9pZjZQdWg3NkU0NGhLWmVUdnlESEtCYjhsQzdzYVhMTzFZQ0tYbnl3dms2?=
 =?utf-8?B?SVk3bS8xUGFRaExLVS8yOWdPS2dFWUJ3OTV5eUY4SVJ6Q0FpRm9scEFjNzky?=
 =?utf-8?B?K0hyVG4rUGRITlhBMW5rRHQ3Q2huT0V5VU9aOHdQK3VYWDA2WndjYVo1clJZ?=
 =?utf-8?B?RGdYUFBrR3FBdUNUL0U2ZEFWRXowWE9Ya2FHMDdDRldFYjRiRFRYQ1o0TWo0?=
 =?utf-8?B?Q3VPbFpLSlFIY0gzNDhQWXRWR1FtYzl4OVhHeFRzTUUxWHRJV2NOdWVxOFY4?=
 =?utf-8?B?cG5jQVNrUDk4Z1AzemJvNWloMER1RWIzSlF5WSs2aXN0RjgvdnphcGdzQkJJ?=
 =?utf-8?B?L1ZZSldYeDdiMHBUWTU1cVRyU1lHNjdtTWtmK1RMTk1neEN0UlNDNWNjei9V?=
 =?utf-8?B?aDh3dlgvSndiV2xNakJaVC9EREdUV2F3SlhBb2ZCK2NDV3QvWUE0NExMWm5O?=
 =?utf-8?B?eUZOYS9CM2xMNVNCV3E4MVJrdVZaOWx6NjdaRE8rd0k2MzhtZEZpR2JySW9L?=
 =?utf-8?B?aHg3VDdmQm5iTi9CQjBoWFJwdTF2NGJiYzhqWXBOaS9ZQmxTWEU4UjR3Z0lM?=
 =?utf-8?B?MUloUEdxcFJnZFh1Uk1JdzdLSDU2T01adXAwNEcvQ1ZwWnRqRFYyMlA1Yys5?=
 =?utf-8?B?cHNXWmlTYXljVjh2L1MwUzNhNUhXZmM3dFJhM25MMEpJQ3pDNHFjQlY4NzRO?=
 =?utf-8?B?d3RISjIvTk1ZV3BRSmxXUFBsVCtoY2pDZldZcWJ4SzFtZFc4RlVOTUdqaG9l?=
 =?utf-8?B?ek9HWERnSzdpYVd5WlEyakpUdytqS1VBelYxbmRhSnUzQmwrVUhDcldnclI5?=
 =?utf-8?B?UCtXWHJOcjJyL05iKzhkQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlWZ1RRZFUrdXJ6bDJYN2pTbFRMb2FqbmpQMENoanVBbWdZUzAweERqem9Y?=
 =?utf-8?B?S29pdXJ4cnBYNXhqVDMvVm9rUjJDQkpoK1FjMnhQKzJ6R3BOQVBQOHFJcXRR?=
 =?utf-8?B?RU82RjQyVWhjcFB0SE9JN1lYcGVSeHNaYWZNb1EzaS9XZE83bXlMRjhjRG0y?=
 =?utf-8?B?S0RoVGFsVlJpNTZCQStNQjJSdEhJMnY4ZWZNRC9UYTJRQUlkdjZtZmVYbTBo?=
 =?utf-8?B?U2JobktFakNLSHZTb3Y2bngzNTJBT3R2c3hxd2E2eDNwTHJqaVRIUFAzc1ps?=
 =?utf-8?B?b0lKVkhyK0tjbGczL1prUUNCd09GTEcwY2ZTRGtQbWF4QnhXaFI4ZEpMYVBV?=
 =?utf-8?B?bDR0NElJa240ZEI2WVlnSHM4aG42Qm0xei9FV0x0RGFnWlQ2VDc0QWhHUUFX?=
 =?utf-8?B?NnZMM0FuMHdGZmVERXF2UFR0WnRYTVcxSEtEQjNCTzlGWndxNFdPcUY2S2pJ?=
 =?utf-8?B?cHkzZDkvQllFK3FVbWlCUEtHME95RkZ4UHZjMWJIa2lYdmhuYkhhcnR6S3Jm?=
 =?utf-8?B?U1RhTS9jNHdhYmxGa091cFZEN2wyeGlRVFVwYVJmQktSUHBIZEphL0YrWkcr?=
 =?utf-8?B?NDRNRDNJVmxUSk5JblA5UnlzeXlFSS91TnptcnM4WTlDVExjNkFRTGJCUVRm?=
 =?utf-8?B?TFpJRHdUczB3WW5rS1hEcjVRdmdVZDlxaGRuQ25xeFQ3dGd6ODI0ei9wMEQv?=
 =?utf-8?B?NExzS3NRSUdJbXhRS1d2c1VCSWpVVHRicDFoMTZodURnSURZSENOWkdNWERk?=
 =?utf-8?B?Yk5yNGJYTkRBNDN1VXcvTDl4RjJ4cWlEeW1YbFVQcTNGL0RoN2tjVGptVkNS?=
 =?utf-8?B?eUhQVEV1MzhkTTB2UUJtOFJvSVp6eG1RUWovM292Zm1WaGswWW51Z21Qb1ZK?=
 =?utf-8?B?MG5lM01UbDVVV3BuamxqdmhDbmJ2VG8yN0xYUjd3YVVzbEN0WThWWnhHTnNE?=
 =?utf-8?B?Nlk2aXhFYjlXY1ZtMXhVTzB4QnNsQWR6RTBWRnA4TWwzdnFFMU9nZGtZditm?=
 =?utf-8?B?clFtaklsRDBqMjN1ZTMzUzZyOHc1UzNROWdrV2VsdndNaDZqUUd5NGVGaXZp?=
 =?utf-8?B?OHRvVTN0TE53eVNMdlBlayt1OFdVcjJKZ0NNanZwVlBhVm1vaHRtV3Z3ZjBV?=
 =?utf-8?B?ZE1LcjVuVlhzdGtablNVYmFaUmhOQ0RZcG1QbHZkMzZ6QmdiSWprc2FpRG9J?=
 =?utf-8?B?OElpbXluYnM2c3I3eW5PNVV1eGtZU3AzcEVuaGxJdUQ2SEdYSnpaT2pTUE10?=
 =?utf-8?B?cWNyVWIrUEhYTnRKZXM1N2R3QTVqd2pUMFczTlpKODN4MWZkRTJXcm9Za08z?=
 =?utf-8?B?WlhVKzRuc1lta0dac0MvWEFEb3luOXc1QTVCMnNYWXhPeXFmYms4QW1yelJi?=
 =?utf-8?B?RllPeUNKNDZaN0Y2czd5VzZtQzdYeitwY1BsZ0UvTTFTanpCNlkwUmlZTlhL?=
 =?utf-8?B?ZEhnT2NDTnV5Z1UrOGt2b0Y4YmV5aVVRY0V6YUp6SkgzNWJLQnJzUHFEYUdn?=
 =?utf-8?B?QjVKTlg3MjI3RzRaditYS1hCYnUzTnlXVlV4R2NSS0NuQXM2cTVrL1JFL1Zo?=
 =?utf-8?B?Mjk2SHZob0Q4bkpsVzdsQnZhT0pSR0hFWmdmK2xvbW03TFowT0RpZUZqbHgw?=
 =?utf-8?B?UWwrdzgzWC9nOHBkSE83bExsWnRkU3o0Mk0rQ0RUVFdwQTczVC85Z1hlTzA0?=
 =?utf-8?B?RDFGTzVNQzJXZUIyWG56VERXei8za3FJc3czOExETlNWbXpwRkRuTElOOGxk?=
 =?utf-8?B?anpzbmt6dXc0OEh6Z1Y0ZDlnRDJ2QzZmV3Z0NzZOczJXMmZpYW1VZUR3Mm1V?=
 =?utf-8?B?WFloOUpWcCtLYXJWRjY4ZE9rd3BOSXlHUkFXcVlmOVNkWERoYk1pYjYvUEM1?=
 =?utf-8?B?V1hJM2UzZ2ZaaU5VeUFNVEZRdzFkdlJFbEl1cGFneFJtRXhZQ2dvTmlzY3hn?=
 =?utf-8?B?SGNMRkNVNk1wMHdodmF4SFNNMG1BbndmZm1DMStsdWhSbkVoY3Q2TWFuakY5?=
 =?utf-8?B?M3J1YWxMUzE4S0NoZjB0azVsNlAvVXZ0Rk5Vc0ZrYURJS214V3BIUlphVnBV?=
 =?utf-8?B?Z0hzNUNhemI1MnAzUlFOUlI2Wks2WUpYTFZqdmxNK3dZSnU5WFB1RWh5M2lk?=
 =?utf-8?Q?+/1lR3GC+axcsFdMvdFR8duJI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925fe17b-9af8-48fa-1b32-08dca1a0f296
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:59:42.4385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuIBHiI/MQ7abMJFhD9aPeausR94nLNajmUu/ESXgUzX+Mqvp2aZYOQjbnqYetgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
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



On 6/14/24 14:48, Venkatesh Yadav Abbarapu wrote:
> This enables boards to choose where to/from the environment
> should be saved/loaded either QSPI or OSPI based on the bootmode.
> 
> Venkatesh Yadav Abbarapu (2):
>    env_spi: support overriding spi dev from board code
>    xilinx: versal-net: Handle spi seq number based on boot device
> 
>   board/xilinx/versal-net/board.c | 45 +++++++++++++++++++++++++++++++++
>   drivers/mtd/spi/spi-nor-core.c  |  9 +++++++
>   env/sf.c                        |  3 ++-
>   include/spi.h                   |  2 ++
>   4 files changed, 58 insertions(+), 1 deletion(-)
> 

Applied.
M
