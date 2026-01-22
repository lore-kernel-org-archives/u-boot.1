Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6ECD3EE65
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A49839DF;
	Thu, 22 Jan 2026 14:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MTG5KjBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB3083AC5; Thu, 22 Jan 2026 14:26:17 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2438397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Geo0LNzPKqu4/mB1N6GB29Yjz4MC4O4vgf04S/4by/22xC1qdLXCfn3wapH7/OLzECYgZW6lqf/n6m1vzsHyDrhiOY1vUYJNxT8Wpr7Dhn1Ni6UETJQHz47YDNdSk4N5WM00PqIcZSZgzyStI/y7VSWbbx52SWrWechI+IjquZ+WLWe98ZfTMoXye2UI6IpPEYDgmDQctWIS31qJDBJhEZpoEQuhLpsTUf4PMONNSsqOU+AS6bev35cqCj61oV7grJ2AQpWCRhS5BoV/wIel0nW2U5gzIrUrHb7okDlv4e5zJO2drRIiS14tHZJ6XLV2+pqniEEr/1S4sj4TjgX2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsH66HlPHkENKYc8lhPjJRiTBIUQn2IIGYSdC+ByvgY=;
 b=hyGXB5wLQOBcH0T+s66tUj8tmp2v2w4/BgKo4nJAec0c9oFznTQcHJ68rzVAuGCXAYnbE2F0SITK+uLa1X66a7eTNApLDppFCn6oy2qVp+Shrow28cOHhyAPuQUgwQSfatgLzoPTTd269lQa9H/QI8RaZxTbMtMX9DU3bu5CXyclI5u8MhzjW8+X1J28wz+SLamcleFDBVtIshwQkzQ9d5csW2YHOijwscbZVmRDG1XffAfwYr0er4W+UunMjSl2l/4RmKJ8luVb6Sag4Yyk2OybigLXP3rrn2tJOanLZKJQTRwDBDJeYRZnlNpIvJXm0myWUQorB5Y9FKhP8KuUmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsH66HlPHkENKYc8lhPjJRiTBIUQn2IIGYSdC+ByvgY=;
 b=MTG5KjBmdvTwCfNtU4JaCbkXBkmOxiSJV+bwnBhR/MCwbEHac0R7qC6KOb2EdINsUOjaKH/3xrAEn+zf2+anyj5FbZBGaXa5z/QXGXcxBTLcAJNz6saDAIYqoFMjwBwg171o8H3bjFjL07uXeaoXLQjfNL3Uze/EiIOuWx5uIL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 13:26:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 13:26:08 +0000
Message-ID: <0d7fb416-2021-4b8a-a7b3-db72bb2ad05c@amd.com>
Date: Thu, 22 Jan 2026 14:25:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Initialize Xilinx glue registers
To: Sean Anderson <sean.anderson@linux.dev>,
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Love Kumar <love.kumar@amd.com>
References: <20260106221728.738219-1-sean.anderson@linux.dev>
 <8265ad50-83d1-40fa-943d-b6e64d9b7812@amd.com>
 <8dad4173-4b2b-4ba7-8e73-838182570bc1@mailbox.org>
 <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ce3b1b60-4c05-4255-9a46-e32751a269a9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: b157a9de-92bb-43da-d40d-08de59b9cd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajEvdmdra1kyUDdGa3dscVlQTzhHMlBSb3BpNWxKbVpHcmwvb0Zad3FFTnBl?=
 =?utf-8?B?bEpRMGwvdlJENnhBR0pieFNwZWo5dHB0QWI0am5GSjJ3WWVjd0dmWTkyQ0Nk?=
 =?utf-8?B?VkQzT2dzNWo1NTB5L0pUMGoyY1h0WkpOWEpkeUxubHJJLzVxK2xGUnhhT3g4?=
 =?utf-8?B?bFVKZjlzdjJocE4xVWhsZVFpdURPMEMzNnVEMkUxMDJ3eU4wRzdBaUFYaFll?=
 =?utf-8?B?dU5FSEVHbDNCdFhVQ0tyeDFVZTBJOVR0clozTEFtMXhWSkpoelhiQWl3ZHhB?=
 =?utf-8?B?MkFKTDl6UittL2JSRlJjeWQvZHpBOWxFRmI0a3BYZTdRYmk4SG50RWFlYkRO?=
 =?utf-8?B?U29vaHVLNEkrYWorKytHeThxREJxeHlIRERkQ2tKOGNmMDhoWmpmZ1NNc21r?=
 =?utf-8?B?cDlQUnduU3BGVXlLRHd6akFHek9iUEhmNVhJa2tFZ2dlRUxrMkZVaHkzKytG?=
 =?utf-8?B?RHFRa2FaaytlbkNjNEpLNmdvSVQ4bjlTNEMwcDhBeXBwZ1BVMXlWSFQwQzdQ?=
 =?utf-8?B?UklzanFPTGVtS3dGanF0WjMzOEVpSlJ4Z1JjY0FKZ3Uvb29TemFpQXJTUlNh?=
 =?utf-8?B?TXhDRklia0VFRjV4S2NyTVJQU0UyMmRLbkZUM1Y1dGZDWEJJYm5vSnJMdEdH?=
 =?utf-8?B?ZUtpWlBIaFJiaGhjSUNHeXFnc2l4VklEdFhsMUVxMXlLTHZNbzJGdHRqYkFo?=
 =?utf-8?B?MUtxNFZGRGE5YWtSK3JpL0lRRCswYVJ1d3h3ZGZHWVp2YmpjUmpXL0JOeDYw?=
 =?utf-8?B?TFYycVZtR0lLdEVIL0M1dEFOcE5pY051akNrNitHbUhYVHNIMjl2SFFsZkNq?=
 =?utf-8?B?R3lwejlOMytTT3NMa1RWK1kvZHhMcVJ1MDluRmEvZ2xYVGh2Vk1OeW1IVzVY?=
 =?utf-8?B?REx0SnJSQUFRMkVWaVZTbzZrSUlIRWo4REhxTXNhRE5CMXphMmVhVWFZUkY0?=
 =?utf-8?B?ZnkvR014amgzdDhjSEJMOHBGemVXdDczeFlKckVrY3FIclJqanViT1MwS1Vm?=
 =?utf-8?B?Ty9UcTJMZzZBYUhtZGdYaGRtdXZ4RkVOMUd2UHJLcEszWUMxRTB0UnowTUV0?=
 =?utf-8?B?TWY3dkltNW43eUZoQlhWNjREZUQ5STZ6eUtlSXRrRkc0cmpyV2dlQXZzMUNK?=
 =?utf-8?B?a2hMYjBtcGFSR0VqYVV5Q3Y0azNuVVlrbEdLR0RCNGNHTkFjcGtpYmptNnNY?=
 =?utf-8?B?VzNVQ0NhUHQvOWFZYUp3enhBUklTMG1QVHJGaDhieXVKdGJZeVZvUW5yOGVp?=
 =?utf-8?B?b0Jkd3FiQWZDMUd1YzdkSk9Ba0xWbFh2bkFNckJNaTRHZVhIbTBxUE9uZ2Zi?=
 =?utf-8?B?VlpPc1RMeDlVeTJuN3JDK0J6VFlhN2FtN1JWY0dWYkIzSTIwWTJ3UjJNRVV2?=
 =?utf-8?B?Qk0wL2sycXVLLzhJSTN2blBDdUZZT3hKdHQ1RTNaWGN0cnM3UFJMMUdpTHZH?=
 =?utf-8?B?dDVYLzBSenBBazkrVkhlQ0gwN1U5RWhlaFgvZTltcVk0KzRJOW9PVlVJOEhs?=
 =?utf-8?B?bFpzK01tLy9HVlNFNmxXREJKR3Jra0kzMDRrUXRuNDBFb2kwMFlVK3BQL3dp?=
 =?utf-8?B?QVEwMG5BL1ZqUk9GdWFKb0FGM3pLNFp3WGxYT1F4THBCSStoVlVQZG9OeTdP?=
 =?utf-8?B?WFlZRk1UbzBmOWNUQ3ZoQTFSNGlpcUZoVzRTWHRUN3p1QlhtWTRNUmpud0Iv?=
 =?utf-8?B?T3NxZ0ZsRjJ1eFNKWkNTaGZmRFNQU1VwUEgvMzFkcFcxUXFabHJnT2pBelJY?=
 =?utf-8?B?RDkzbjBtZ3l4bnNYOVhoRGhoYlRqOFlUbU9VcmUxQ2ROTFplYWE5WUw4dE45?=
 =?utf-8?B?M0MvVTUwbkZBNWtCM0Z3VVBIUWRZajBZdFIzVVlITVJsSWJUN3VTVnJCSG9t?=
 =?utf-8?B?bXVoUnpleHJRQlg5YW4zOXphU2VvTzQvK1krV0YvcnpvdkNkLzFDQmpoZ1BJ?=
 =?utf-8?B?d0ZjSWllQ3p2Y0RyZ3dQdk5ROWpSWGEvUWJrRFdUQ2kxYkhCTVN6ekh6QUxN?=
 =?utf-8?B?UEJCdmh6TXZzaW1iUEI1RXRVbmhNeUgxODRjWXd1MUp2Ym1XMGlGclVwbHBY?=
 =?utf-8?B?YWYrZmNxc0RRNjJEbHFKdGZFUUVDNzJmcU45NkZJT09KQXVJRVpLV0RnbXQx?=
 =?utf-8?Q?v+22dLZfPnr3HPKn8aqPOq2ki?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXd6T3d4U0czYzdlenF0SFdmV0RYV1pGd1krRG0wRWl4Z3NWSzVyblVCTlBl?=
 =?utf-8?B?WmV4RWFMS3RVNmRqVzZOWlFJaThTUlA2Y2tUaTBnVzBhZzdMUHJCenVtbVRr?=
 =?utf-8?B?VjdSbmUxWEhtWnl5WkN3WVZxY3ZMa1VGdlovS0h1VnBKQ3BIanRjL3dMN1My?=
 =?utf-8?B?eGovZW5NdkVqdHR1dXNSVnl6REdzZW9VTlNaTVAwTUZsVVhXTnBmOVpVVG1B?=
 =?utf-8?B?RDdJUFZOczQrbHEvazY4cHBySmRsUWlXekNETW9JS3FPVFpNdFFZeVRqOEEy?=
 =?utf-8?B?dmtYWDIxajNObVJYdm1ZS21QclI3SUc5RTc4ZGdFeG5sYmt2Q0ZxaHc4MFpU?=
 =?utf-8?B?SXRtelZ1WkIyZ001Y1EvVStCN3p4dFRHVnNLNnRLRmI3NFdOb0dpWVc0VzMy?=
 =?utf-8?B?VFNTaUNMZXB4Nkx2NEtlQkN3UXJKVWNyY1B6TU90Z3FZWk5ZU2U0ejhIcTBj?=
 =?utf-8?B?NUlidEVYTW4zc2hlbkFNMEFxZkFUamgrY2gvYjE4b0hYZTNHWHF5TXlsbGc0?=
 =?utf-8?B?NUNwKytyaUZvQU9COHdnQUlRQ0pVVDRhTDFQa0hFclp6TWUrZnA0aTBGekNu?=
 =?utf-8?B?OFdEdU94bUY3QVRCdG95Q1BCRGtWd21KVFM3MFNlV0ZhQlJMM0JyWVE0OWJP?=
 =?utf-8?B?TVZHU0FOemlIU29CNEp2K2dDa3FsMmhWS09UQ1JTUkt3RmFodk1QU3AyN1l3?=
 =?utf-8?B?U1A0SmtmQWRhQ005ekVLOWI4U0VRdXVvY0JvREU2L29PekZVdVZCYllET1hh?=
 =?utf-8?B?dWloVmFtTER5UnlYMUoyRDVMcXJub0greStmNUJhai9CaGRaVEFDSVd2V0tY?=
 =?utf-8?B?eHVTRjlFZG85UnFxczRBa1RxSDVZQmZhY1lkdktyRjJXbjJNTTl3eHVvb2hT?=
 =?utf-8?B?ZUE3TmlrelFDWXhMMjZ2SkNXcFlucVhoUUM5akdpR1VUNng2a01iM3VjcFQ1?=
 =?utf-8?B?YzIxWjlYK1FBVVZCT21yWE5tcFI2WDlUZlJ2RkhLWTVCVCsxNWh5SXU0UmVI?=
 =?utf-8?B?enlFZ1BxekREZHVTNVlWek9ZZlBlb0dGWU9WamVxUjI5TktSUi9iNlI1NW53?=
 =?utf-8?B?dGxJUnNMQ1IvdkxQVDVQbE9LT0poaGVUaVF3bnpCRFMwVExHMFlrVjlENUxF?=
 =?utf-8?B?MWE4UW1mRmVjcTRaeExtSXpnOXpMSU1yRGdzQ3A0bHQyTVJOeVkrcW1ObkNE?=
 =?utf-8?B?bFA3NEt4RkpsMkVtMWNhRy83UDdsNHhnWG10dUVpTElSd3ZYZzg4K3hHdzYw?=
 =?utf-8?B?c0NpdFhoSDZoM0ZocjdGV0JPUzNzRUdtd21YMmVYMEZ0dEc1MkduRG42Q0o4?=
 =?utf-8?B?VWtoYUcwNDRlWklweGwwWWlvUFRBRnBnQVc3YS92U2JZRUZQSGs0RExFekZq?=
 =?utf-8?B?VXRIaGViNWhNblMySFdMalJUemlleUQ5MktRd21wWXlzVDNYQ2xmbjNyOFgz?=
 =?utf-8?B?eVRRazR5ZDBVV216RjdSUVplUVhXVjlqTXA0ZmZ3S0hxL3gwOGNYR0FYamV4?=
 =?utf-8?B?QTZhZnJxZkNjU2E4dHJHMFp5WUd6WDNCcVhHWHRvbHZiOTZKZGp6cCtOMVJJ?=
 =?utf-8?B?YlJNQ0NUVThQQlRrUzRPK09QNTdBdnR6U2E4N1JWR3o5YWZNelB0WlErOFUv?=
 =?utf-8?B?Ulk1bjRtcjhyYjNPSkZBTkxnYnFrSXEzWllzSXoxbGtZSE9DeDdIMDBGdGFm?=
 =?utf-8?B?UTNkcUl6cHFKbXlLOGRFZ1AxWUhqQThkOU9Tby82eE5VcWJNOG9tYW12b2Vn?=
 =?utf-8?B?OVpuNjRWcE9NUEdkN1BNVlYzVEU2Y3htaXZpL0twcXRzaFRSRi96TnpVUFdB?=
 =?utf-8?B?cE1XTk1RRDZBQklmcWdNOTBwampZY1J1N3oxUk5ZY2ljQ0hLU1lnVDJ4NHRu?=
 =?utf-8?B?REJLZGpCZmRyNlpFNUcvUitjNVhNUGxzTWV6TW1uOE84ZldlaTBHQUNFL2pM?=
 =?utf-8?B?MVMwa2thZmtTVUtXQnBXTnAyanI0U3NrbUJTdGlnb1JWTmRjRWFBOEx5RWM0?=
 =?utf-8?B?WjdYWUgzMmQ3NitJMmo5SE04bk9kRVV1SURWcW1WWHdad2NHdzQ1QktyazVS?=
 =?utf-8?B?bGc5L09VUnpmSkkrZk5Ra0lnd2dyU251MjFBUmtJSFI4NnRTOFA4NHZaU21n?=
 =?utf-8?B?dk0wQlpVZnI0Y2loNmt6QU96TDZmb3NsVXBpSFJHb29vTmVzbm8zTGJ3U2Np?=
 =?utf-8?B?N3c4bUFyc3JNTmZ6V3ZheWxQZHRaQWFoNTcxd2J1ZlZGaC9pNjVNRXRBWnVi?=
 =?utf-8?B?c2Vsb2tPNlVaaGZobFp6azVEaENRbFcrOXEycmg4QlRhcEVraWtjY0pTUEY0?=
 =?utf-8?B?QVZBZHd4NVVMTGpmcnpvMG1BS1RNYVRvWFQvRlhzQlFwZU9McWFDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b157a9de-92bb-43da-d40d-08de59b9cd3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:26:08.4150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I860+ejJ+a15ZmU7Xp+hk+f/SIOudfLXqf7PBOpesT+Vqlv1jqKcmz4XeFIbx47b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

+Love

On 1/16/26 17:14, Sean Anderson wrote:
> On 1/16/26 09:07, Marek Vasut wrote:
>> On 1/16/26 9:19 AM, Michal Simek wrote:
>>>
>>>
>>> On 1/6/26 23:17, Sean Anderson wrote:
>>>> These registers may have been initialized by SPL/FSBL, but program them
>>>> in case they have not. If they are left at their default values, the
>>>> controller will never exit reset.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>>
>>>> ---
>>>>
>>>>    drivers/usb/dwc3/dwc3-generic.c | 32 ++++++++++++++++++++++++++------
>>>>    drivers/usb/dwc3/dwc3-generic.h |  2 ++
>>>>    2 files changed, 28 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3- generic.c
>>>> index c09014aec60..ce896db9532 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>> @@ -501,6 +501,27 @@ struct dwc3_glue_ops rk_ops = {
>>>>        .glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
>>>>    };
>>>> +void dwc3_xlnx_glue_configure(struct udevice *dev, int index,
>>>> +                  enum usb_dr_mode mode)
>>>> +{
>>>> +/* USB glue registers */
>>>> +#define USB3_FPD_PIPE_CLK    0x7c
>>>> +#define USB3_FPD_POWER_PRSNT    0x80
>>>> +    struct dwc3_glue_data *glue = dev_get_plat(dev);
>>>> +    void *base = map_physmem(glue->regs, 0x10000, MAP_NOCACHE);
>>>> +
>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>> +        writel(0, base + USB3_FPD_PIPE_CLK);
>>>> +        writel(1, base + USB3_FPD_POWER_PRSNT);
>>>> +    } else {
>>>> +        writel(1, base + USB3_FPD_PIPE_CLK);
>>>> +    }
>>>> +}
>>>> +
>>>> +struct dwc3_glue_ops xlnx_ops = {
>>>> +    .glue_configure = dwc3_xlnx_glue_configure,
>>>> +};
>>>> +
>>>>    static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>>>    {
>>>>        const char *name = ofnode_get_name(node);
>>>> @@ -621,11 +642,10 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>        struct udevice *child = NULL;
>>>>        int index = 0;
>>>>        int ret;
>>>> -    struct phy phy;
>>>> -    ret = generic_phy_get_by_name(dev, "usb3-phy", &phy);
>>>> +    ret = generic_phy_get_by_name(dev, "usb3-phy", &glue->phy);
>>>>        if (!ret) {
>>>> -        ret = generic_phy_init(&phy);
>>>> +        ret = generic_phy_init(&glue->phy);
>>>>            if (ret)
>>>>                return ret;
>>>>        } else if (ret != -ENOENT && ret != -ENODATA) {
>>>> @@ -643,8 +663,8 @@ int dwc3_glue_probe(struct udevice *dev)
>>>>        if (ret)
>>>>            return ret;
>>>> -    if (generic_phy_valid(&phy)) {
>>>> -        ret = generic_phy_power_on(&phy);
>>>> +    if (generic_phy_valid(&glue->phy)) {
>>>> +        ret = generic_phy_power_on(&glue->phy);
>>>>            if (ret)
>>>>                return ret;
>>>>        }
>>>> @@ -690,7 +710,7 @@ int dwc3_glue_remove(struct udevice *dev)
>>>>    }
>>>>    static const struct udevice_id dwc3_glue_ids[] = {
>>>> -    { .compatible = "xlnx,zynqmp-dwc3" },
>>>> +    { .compatible = "xlnx,zynqmp-dwc3", .data = (ulong)&xlnx_ops },
>>>>        { .compatible = "xlnx,versal-dwc3" },
>>>>        { .compatible = "ti,keystone-dwc3"},
>>>>        { .compatible = "ti,dwc3", .data = (ulong)&ti_ops },
>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.h b/drivers/usb/dwc3/dwc3- generic.h
>>>> index 40902c8923f..13f6391cae8 100644
>>>> --- a/drivers/usb/dwc3/dwc3-generic.h
>>>> +++ b/drivers/usb/dwc3/dwc3-generic.h
>>>> @@ -10,12 +10,14 @@
>>>>    #define __DRIVERS_USB_DWC3_GENERIC_H
>>>>    #include <clk.h>
>>>> +#include <generic-phy.h>
>>>>    #include <reset.h>
>>>>    #include <dwc3-uboot.h>
>>>>    struct dwc3_glue_data {
>>>>        struct clk_bulk        clks;
>>>>        struct reset_ctl_bulk    resets;
>>>> +    struct phy phy;
>>>>        fdt_addr_t regs;
>>>>        fdt_size_t size;
>>>>    };
>>>
>>> I will let Marek to handle this. From my perspective we should take Jerome's patchset to update usb stack and then add this on the top.
>> Since this fixes a real bug and is isolated to xilinx platform, it would be good if xilinx at least provided feedback on this patch.
>>
>> +CC Ilias
> 
> It's not a bug fix (hence no fixes tag). See [1,2] for details.
> 
> --Sean
> 
> [1] https://lore.kernel.org/linux-usb/8f0e04a5-49df-4fe3-9c76-9a1c0bd822a0@linux.dev/
> [2] https://lore.kernel.org/linux-usb/be8a566a-163f-4d20-b712-67de6f63a6b5@linux.dev/

Love: Can you please test this patch and provide your tested-by flag if it is 
working.

Thanks,
Michal

