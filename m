Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF2EC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB1A80711;
	Wed,  5 Feb 2025 17:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KZeWGcD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D305805E7; Wed,  5 Feb 2025 17:43:43 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3A88003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDCYCNY7S9IC32kSCKG1UXdvxyTHiwD3/xZQBZVfmCSjix6qjiRqr+lMtklwOXcuqq1a3RGGss3tbFwgGPF58qaa93HhtoD26vZhs/99ID+O0abvBTWSu6xS4qyJXSlaoU8w8sPQasWo1Gh4uviTh57rGHlAiD6/O1TGgkV/MTBV/EjsjjZa2gRTN0bQiv93Sfrf8o8OG8jF+dO2U0H8MxKoufUf3zIU2q25zyeeX6zbJndDnU2SEZSZr/DYO3S4mW0qVjROWxlch6BUWUGkgItIbO0v0i1JfUpTNDubtN3SkT6U5wGJjC6dmgvN0Owe69L0zODz9RKwEdcMz568fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JZasv7l1IlvgNpXcBNUQnur/MzjlmNJ/IrqsG7m+iI=;
 b=tW7/ZUgUVCYNNJxu5tNbgCSio+npzww88veXY4QxtWFA7kwXHmBLQ/oXsBK0rnHhekuveiAPwrjAvR9mS7j+amxyUbhcBO24rZSTFawqF22WJ2brSRo1OOt5i2afpKoxmN/eItml3CTMtvzkl6GPs2d9rFPH84dHA5RwonyW61LBZHc6dcQW9gBqIRmd9UdwT8sNEGyxY9ix2S6DK4z8+swWn4tm0pMeOJJe5sMID6Xa+Xp+K0VQP+RIdVKC7uJIi5u2UiTK1nt4AqPWb38fGcqsH1O4twm9ZW0hGvea5D4Pun+AURKDUCD4PsxC1zUpngdjKfzm+PhVR88I1QLkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JZasv7l1IlvgNpXcBNUQnur/MzjlmNJ/IrqsG7m+iI=;
 b=KZeWGcD7OHZGBpcZuWOr6O9nRdlSCq7VEhi1CgcHQyDQXqr63qb5ADqWd8iuzlDzw/uwUjSAWdyOe+NqPY3j1qY6s5YzjVr02NIjDVwirUXAs1//+kLtTWppNjWJ3XuPTagA+1820edSmZ9eBHgeWuKav4IT+q5INI934ExZ7iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8873.eurprd04.prod.outlook.com (2603:10a6:20b:408::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 16:43:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:43:39 +0000
Message-ID: <4dec97d2-0ee8-46a5-bf3e-91776ddb1833@cherry.de>
Date: Wed, 5 Feb 2025 17:43:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] rockchip: mkimage: Add support for up to 4 input files
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-6-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: a43cac1d-54df-4ae7-3628-08dd46043e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2dEMnJuN1N1Y2x5SGtiL3ByUVRXWHRsemtZWW1qc1dZUWR1VUdIY2h4WEZI?=
 =?utf-8?B?dVFYNk95OU9UcHp3enBVZlJFUTR0SmRSdi9uOENLTkE5aTQ5dXJXYlAzU3ZC?=
 =?utf-8?B?OUlNYzR3MDdub0RvZjdnTzhsa0dzR1V4ekZEbmU5YWlNTUZIamJTelZuQ2xV?=
 =?utf-8?B?NTNzOVp0SWY4ZEF1eWd0UXcxcnpWM1NPRHAyZ3R3QU9qQ3NVTUJsaHp3dTBQ?=
 =?utf-8?B?VFFleFR3d1l3NzdWdVMzeGlTVVFVUmFtWCthVnEyclliNHRmbldNMyt0eWVK?=
 =?utf-8?B?bmZycjFHUnhFWXNSdHIxRWUzLzZBVEdRcDUwc3lWdFNENlhVdDFYV3IyQkVO?=
 =?utf-8?B?NU0vS3R1MXRBYm1SQ0FyR051M1B1bWhHK2hJRWw1RHI3RFZuTUgzL1NYQUpU?=
 =?utf-8?B?RlN5cWx5cDhBZnRZY1dIZjFvMUtwNS9aU09RRGpmM0dzQVJKdGd5WkhyNkFU?=
 =?utf-8?B?ZkY1WmdTS0FCb3UyYjcvd2hoMS9YOFZ6Y3ZyVHUxc2hjNG1rbDZzaFpHd1BP?=
 =?utf-8?B?RG9HbDNCOUNLNGlLZkJTYU5ucDhGWnN4dS9TckRFelAzVWIyVTY4TlVWS3ZF?=
 =?utf-8?B?YkdPb0x1dTVPbmREQnpMdjM3SDR6b2tBYXBXTFJ6Wk9ZcEZSRVVHM3VGb0xa?=
 =?utf-8?B?aGgvcjI0STd1MTluZlBoazBoSEM3aUxlYXpVanNLUG4rSmlQUE9peGdFT0JF?=
 =?utf-8?B?MGhUWndBZXk5SVFlSW5JMU9VcWVVVk5Hbm1scnUrMTlvYWJjV0lpUXA3Mng5?=
 =?utf-8?B?VVRMVE9xK2I2Q2FmQW9tSU9Jb1p4L2F2VURaSEtFTUtIbk5ubkRKNkpld1VT?=
 =?utf-8?B?OWgzVENWOFdLVnB6V1NSYXlORm04RnR2UjNJRGh6Q1NHVDJDeFRJYktBeFNV?=
 =?utf-8?B?cGVUUFFqT003djc3UlZaMkg2SUg2dEZsSEtwaWtJc20zcFJEMzdKQTBwWVQv?=
 =?utf-8?B?a04zWFNrWm5QbmU0d0tPblR6NmNrdWV5VU5SVmNzc2ozVHEraDU4YXNGZFdZ?=
 =?utf-8?B?SXdQL3JOSzNtYnAxbGhOSndVTk9DeWxuRmJ3SnBnYTBELzVFekUvMHY0c0tt?=
 =?utf-8?B?S3ptMlhac2RvQWZnYmlxVGdKUHJ3ODVxZEdOR1ptQlhKanA1S0JtT1VVTGRo?=
 =?utf-8?B?WUZiNWQ4eERGRDlaMmEvWW9BWERKdEJrckpORWttRTU0S1c5SXYwaDdtNU1P?=
 =?utf-8?B?dDdqeElCSXBjMWNzdjBmUExOTHNEaWtBTHpxcnMreE5ZTHppOVFrbTJ5TVBF?=
 =?utf-8?B?czhUdUpIRVdjNkFiRWRFWU5aaVlJK2luTzhJczRyWkxtSzhxc25ta0VXdWNU?=
 =?utf-8?B?eU0xaDJ0SERJOXlRWmZhWWlTdm5Nc293WnlKU2ZISmo2UWl4QlRKY1d4anhv?=
 =?utf-8?B?K3N4TVBZajdRdjhrdmpJSTZjNVpmQmxueGlqY0JveWRtU0sxalFFSWNhODFo?=
 =?utf-8?B?UzQvNFBZUFpaVDBuREh2WXlRdjd1bEorcitXc2JuZFJRRWIya1o3aGkzTThS?=
 =?utf-8?B?Q3VLTHpUOWc2WU8za2ZWeGJuVlh2MmJEZTUwR2ZpcDUyWU5Ya2J0NmRralVn?=
 =?utf-8?B?YTZQN3cvQ1lyUU5SZklSSktiOWZWZFNQRDlicUVoditpemRmSHkrVmFtNThE?=
 =?utf-8?B?akRoV3dWKzhmRzNwUnZVUzlobElPVXY0MW9JQk5kRmhPSm5KbGNSbnVGTU1u?=
 =?utf-8?B?dGdIKzJKSnhSU2x1cDZsVW44cmRSY09abkVOdENrVmJGajlXbml3QjMvVE5x?=
 =?utf-8?B?akIyaVBFL3FoUmpvZzZLZzFOLzNCL01mOUs3Tm14UStQaHpYZFJGdFNLa2Jt?=
 =?utf-8?B?NmkzK3kzV1k4QVBnUjFTM25vbDV2MUd4TzFSVHpRbXR4aTJWMTBqZFBTOEtF?=
 =?utf-8?Q?3TXMeoaPyoomg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnB0d2R6TVMweVdBb2cyTHR5K0Y1cnM3T0l4Ykg5OCtkbERBblkyUVNjNUZx?=
 =?utf-8?B?ellBc3J1aThFM29McGNUTXI5cFkrbHA4N2JCOGttQlJTQll3QldHRGt1c2hN?=
 =?utf-8?B?bFZ4UEhBV0RsWVZjSkl2Uk5vVXg0RzVwOHd0OHJ2eGQyNng5Z1YxeDI0R2dW?=
 =?utf-8?B?UTE0U05jZkF3Vk9acUpmWWdubk9UQVF2RmhsdEV3ajBTamttNFVjMHExZ0ds?=
 =?utf-8?B?S1Q1RG9aMXA0OENjVzJ2OEMyNzVyQWZyUjdGZTFJbzBWT3ZsNWhzSzN1MmtR?=
 =?utf-8?B?cEJ2bm0ya0xBTFpaQWJiTTBEdG9YRjZpUDdBQ2NYc21yNDZvUnhsM1pRMUND?=
 =?utf-8?B?NHpiWUU0eUcwRHZCRVo4eGpGZTF1MElVOWxuK2k2YStKclJiN1dBOVNteE16?=
 =?utf-8?B?OWNpNWVPTkN6NzFYcFZPeEpNc0dMcmYzaVVaMFV4N1RWcTNlOUtsQ29YN29m?=
 =?utf-8?B?dTlZQ0Q2SEIzWkdvYlFaalNmam1DbUVjQzh1aDcrNklYd1hxcjVsMERCVjZk?=
 =?utf-8?B?KzZLSHBEMVdWWGlDQ2QzMFUxMndxMWIveGV3S1BJaE9zRW9uQll3dmVhSXZY?=
 =?utf-8?B?ZVc0dEFSY3JDT1Y0TnJNN0t1bmxoUDk2TlJhQ0pMQXBzU2FzK0J4dnRBL2JX?=
 =?utf-8?B?T1BiWHRWNnNNTmhPNnFoT3ZoZnpwZ3lwNktyNmM5d3RTMWN1YXk3b005VVZj?=
 =?utf-8?B?b3dhUUJteVd3QUU0cUxxN2dLMkRIQkJQNkFXRHl0dUdaSzRrY2I2MVVYR2Vt?=
 =?utf-8?B?bTJaWldRZGJaWTVFV1ZOSEVWWEpVMVc2SzRHM2RPOFlkbWtvdGxnNlBwM3F3?=
 =?utf-8?B?SVlVT1g4czQxRm9weU8wODZjSEtzV1N1NElJV0VTT2FleU85NExHUVFNSi94?=
 =?utf-8?B?MmZuUndyNzJqNjBBRTVEREZkcVF6RUNyeGlXVExkaUg1QkZVQm5oK0QyNDds?=
 =?utf-8?B?OW4zOXRFRW9pWnBydnB1dGowdzNXaEFtbFh3QXZ3RngyNENYd1RzK20wcHV0?=
 =?utf-8?B?cHlnTFhYTjhaRm5KcTY1aE0xM0VKS0JGUUQ1RDRaUzZOWTYvMHFOY1BjTFBp?=
 =?utf-8?B?TCtKOVR1TDdmSUoyMzI2S1VraWRmaXVwTGd5U3owSWdWdzVMNGw3aHY1aGVh?=
 =?utf-8?B?TURyNXJhSnBhYUp4MWozMnZqWldXRUdFSVVJaExrbi8xbUNwN1FtQU5TMWdj?=
 =?utf-8?B?UlYwczBXTW44cWlUNDg3S1o2SGtLM1kvUnh5RmZYd2Y4dDBocmJTYlhWbzRn?=
 =?utf-8?B?WVorSGgwc1ZoLzdRaVJ3R1ppSENpTWFWTmVGQ1NEbVgwd3YwMVUzMDUwamxl?=
 =?utf-8?B?bnlWa2FiVC9KWllHOVVlVmdBQlBtRU44NW5kU1JUNDhQSGNUa3paaFBHQUlw?=
 =?utf-8?B?TmYwKzhkRnZ4bkVibTNPZmZESVlxVzhOTU1JT2tHYUFyWEFUUmNJeXdvVk9v?=
 =?utf-8?B?Z0ZnSUJpaFZ2b1E0YzkrR2ZCQ0xSNE5TVUlidHhkcmtVTVpHSG02QXI2R0Nz?=
 =?utf-8?B?VEJJSHV2WGRWZWZsVnI1RElNMktMTDVFVlJiaXBLU3dlK1MxYlhtamludnJy?=
 =?utf-8?B?ZVgrRi9DYkoxUHcvNW9JMTJnUjhFN3BZcS9za0ZsRGdoT1REYXJqUEgxSTA2?=
 =?utf-8?B?ZUo5TWZyU1VrY244RG1UM3BvRWZPbUZ2alM3MW5aMzVOV1MzaFlJRGFNNFFo?=
 =?utf-8?B?WWZzQUNzVFN4S0RjMENKK0F2RVV1a3NoZXc5WkR0NDNzZ3VKWlVmWU9id2p5?=
 =?utf-8?B?bDN5VkloOUxqVjB1QjdxMU1lOS9XU3ZGWkEvOWsyYnVnQWFwVDRaSnRxTXlz?=
 =?utf-8?B?Q2dZQVRCRDYwMS92clVuZThZYkNtbkZuVkgzUFJ1NEF3eDd0Q21NTHBKSVJm?=
 =?utf-8?B?UGxYNjZxZmswenhVdkk3Zkl2aFlvdTgrSHFML1lxWDZqQ3FqdlpPQ0FRME9G?=
 =?utf-8?B?UFR3enFTWVBiaWdyejYwL2Zkb0FNOUJBaTF5WEJ1bUJTRzRQKytSMy9xcVdE?=
 =?utf-8?B?WU5GcmhYeElHeDdCVG1iYWhOU09Wb3Vzejc0RnNuWXpEUys4MXptT1JIRThZ?=
 =?utf-8?B?U0lCTk1EYVF5NTMzcjUwMWQ3UWM0UE82M24rZlR4bEZrQ0xHajJwaW5zM2tS?=
 =?utf-8?B?VjRpT3UxS3BKQ3lrbmh6M00yYTBUakpzckRvTkZ5NDduT2NIL1gwWTVtS3ZN?=
 =?utf-8?Q?4dg3In4X4bhhcUf0gY0mPV0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a43cac1d-54df-4ae7-3628-08dd46043e17
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:43:39.3242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgWMm4oucn1sDg3MQs2eIQ9Z2H7JtSy9QWR4V9tLhpbZh+hvhhMpozKBVyraHMXSpR+nAEtlvSCSwT1KNzwq5T5DzeCeYThag7V5uUx2TDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8873
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

On 1/29/25 11:36 PM, Jonas Karlman wrote:
> The v2 image format can support up to 4 embedded images that can be
> loaded by the BootROM using the back-to-bootrom method.
> 
> Currently two input files can be passed in using the datafile parameter,
> separated by a colon (":").
> 
> Extend the datafile parameter parsing to support up to 4 input files
> separated by a colon (":") for use with the v2 image format.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/rkcommon.c | 93 +++++++++++++++++++++++-------------------------
>   1 file changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 542aca931693..4ff48e81a636 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -148,17 +148,15 @@ static struct spl_info spl_infos[] = {
>   /**
>    * struct spl_params - spl params parsed in check_params()
>    *
> - * @init_file:		Init data file path
> - * @init_size:		Aligned size of init data in bytes
> - * @boot_file:		Boot data file path
> - * @boot_size:		Aligned size of boot data in bytes
> + * @file:	image file path
> + * @size:	aligned size of image in bytes

Not really matching reality though. Could make it easier maybe to have 
an intermediary

struct spl_params_image {
     char *file;
     uint32_t size;
};

and then have

struct spl_params {
     struct spl_params_image images[4];
};

?

>    */
>   
>   struct spl_params {
> -	char *init_file;
> -	uint32_t init_size;
> -	char *boot_file;
> -	uint32_t boot_size;
> +	struct {
> +		char *file;
> +		uint32_t size;
> +	} images[4];
>   };
>   
>   static struct spl_params spl_params = { 0 };
> @@ -238,31 +236,32 @@ int rkcommon_check_params(struct image_tool_params *params)
>   	if (!rkcommon_get_spl_info(params->imagename))
>   		goto err_spl_info;
>   
> -	spl_params.init_file = params->datafile;
> +	spl_params.images[0].file = params->datafile;
> +	for (i = 1; i < ARRAY_SIZE(spl_params.images); i++) {
> +		spl_params.images[i].file =
> +				strchr(spl_params.images[i - 1].file, ':');
> +		if (!spl_params.images[i].file)
> +			break;
>   
> -	spl_params.boot_file = strchr(spl_params.init_file, ':');
> -	if (spl_params.boot_file) {
> -		*spl_params.boot_file = '\0';
> -		spl_params.boot_file += 1;
> +		*spl_params.images[i].file = '\0';
> +		spl_params.images[i].file += 1;
>   	}
>   
> -	size = rkcommon_get_aligned_filesize(params, spl_params.init_file);
> -	if (size < 0)
> -		return EXIT_FAILURE;
> -	spl_params.init_size = size;
> +	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
> +		if (!spl_params.images[i].file)
> +			break;
>   
> -	/* Boot file is optional, and only for back-to-bootrom functionality. */
> -	if (spl_params.boot_file) {
> -		size = rkcommon_get_aligned_filesize(params, spl_params.boot_file);
> +		size = rkcommon_get_aligned_filesize(params,
> +						     spl_params.images[i].file);
>   		if (size < 0)
>   			return EXIT_FAILURE;
> -		spl_params.boot_size = size;
> +		spl_params.images[i].size = size;
>   	}
>   

Can't we merge the two for-loops?

The patch diff makes sense to me :)

Cheers,
Quentin
