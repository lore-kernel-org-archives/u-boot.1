Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1813DC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 521C180104;
	Wed,  5 Feb 2025 17:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c8SjD3iC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B58C801BE; Wed,  5 Feb 2025 17:29:45 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 150328003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqLwYo4ynXeBWMss4/fGmQKNXFv+czYQBhieN+Rst2WOpkwYWqpu6gMqw0tUVh0MU5lxdIG5GVi/3DEuWshFpG2xruMclZuzr9pKWAWg6flzYBenlYuE6lnvmaMdJwdlIAq+mWZpDWwuy5sqytUsbV11sgSdr87gnaaQg1F8/p8EgNiEjoLfsLhp7aiKGkyp47U0dpbBO8H9HfOQqLwiLNrmwaeJZdOs8x8QLRU1+r9cqqUSxrJ9uTcnPV5nhTeGATgq+m6Vq6LR9YbjazuQgpR63lY8b5XEh3Q6c9FDOtg/w9cABXJGv7f4JXYhNDjNJfFOKNYPGXPe96u1gcUrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfl1QOu9KoPBNWqpHajUGgpSXcdcs16VU8XjgqnVdTY=;
 b=Uaph3/ozmbP7Q092zSN9DcxRKNpbSIhZeXWzXhO28uxJboYIv3BQRlmT1tGPLjWRpTIEC6FXid/lW1hc4JnFdA7AZv9fNlr9CFTQ4hs5pfxXGMfg0EnCX2shkJM1Z6eoz2a8Bv4yFJG+F5b/SvE/ntinAzKYcxPIi9Sk4+FPEAStBWLg2oShwXCG7FAiJ27thIFODRe8RVq/oMAmWnXhD0OaZy4LkZcg/jfhkFbWstdzcPfOTcL+QfxDiD+IGOSf3NLwilUGleVAAT/JDFJYimqiibE9EK2xy42bIMusd76SjxPtZQrj25X427pxZNI1OUjSafBwqK4mrvAiTNF1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfl1QOu9KoPBNWqpHajUGgpSXcdcs16VU8XjgqnVdTY=;
 b=c8SjD3iCg+CRL7ofRdvvEeJ1Eulr7dpWW7E2qAnssskicw76S+DvuXsY8HQoVDRrZDAMeyo4VUG/sTwBeHwy1J9BpXRcrhEFQfNOxSbeRvLG0Qrg32oGeqC+7cBvPWsFLQMjzDiWhDRw6dHEpT8V0TikjwRB2DT7iyeRSCtTB8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 16:29:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:29:41 +0000
Message-ID: <7aa55d4f-42d9-490a-8a20-705358db00cc@cherry.de>
Date: Wed, 5 Feb 2025 17:29:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] rockchip: mkimage: Add option to change image offset
 alignment
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129223641.1888833-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0096.eurprd09.prod.outlook.com
 (2603:10a6:803:78::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e311b3-4bbc-4e30-053a-08dd46024a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzdHSEI1azQzUGYzSWt6VzJkbmRSci9jV05tM1VkSkRYc1F2MnNVZVp3RUVt?=
 =?utf-8?B?WjVIMU5BeVlFWUVOOUdvSWNTY1RRa0p0YUo3TTUzVjFGUUFzd1BrV2JJUFBv?=
 =?utf-8?B?RUZ1OW1JbDFGYkdtaFBPL2Rvc25RL05nbFJianJyZXpoZFdzdXNISmtKSnRu?=
 =?utf-8?B?bXdsL2h1VE40NVg5eUFGb2VGVVhMaFNLcVRQYUFCZzNmTjZEV3FHUkZkT3h3?=
 =?utf-8?B?b3cwQkpJM05aa1phT25pa2Z0OUlaVmdDQVB3bXZlTkhHbnl6MkdBek1sQ2lv?=
 =?utf-8?B?NTNRZS9UUU9pTWRXWmdOY1VoU3M2ZENleDhiOTBuTEI2ZHRRTlJaLzFUdnlB?=
 =?utf-8?B?YzRMbExxUWRPbWIrV1pxc2FwYnpYUnl1RlVyVGpQbUw0QytXVVRLQzRaa05o?=
 =?utf-8?B?dVFuQWtTTTh1aW9xai9Kalg2TUlZa0xiU1JNNVA4WlJBaEtPTy9Kd1BRZHEw?=
 =?utf-8?B?MUEvOUdVZkJVMEhsWlRKN3ZxSFIyakkxcGtPUk9hekRqaFRDVUpHaFhJT0hZ?=
 =?utf-8?B?eVkxeHkwdHh0Zk93c3Z4ZlZReWlCU2xldFFtVWV3VFBmcmVGc3ZKZ1FKOWZO?=
 =?utf-8?B?QWtJK3VQak5KZGJYNlRvckZ1M0ViMnBlVGJTWnVGOE1pb3ZZZ21ESUhrOWJa?=
 =?utf-8?B?YVduUmwwSUZUa043MVhjNHhOc0lzUjhYM3RpR3dFUUVqUWt5UVpXc0tXWEhB?=
 =?utf-8?B?ZFNrQ3c5bHBCVlk5VEN4UXpQY2gwWkV1djg2MTlpbW80S09hNFc5Wkl0WmhD?=
 =?utf-8?B?VWRtY0F1dW9FKzNOaGNhTmhyL3JweXBGWHNGTGhCVGNqWXJzemplZkJDTVlz?=
 =?utf-8?B?VVkyeXZVMmljeTNWM29XcEM2aWlLelRoa0N3WnJYVWY1MTRVOUxZL1h3MnE0?=
 =?utf-8?B?ZW95aStudlhGblpzTDJINUtsZkVJVDMvTTRVMS9TSDljZitOS3JZQlQrNTFZ?=
 =?utf-8?B?czhOcmpWVTZLUmRHVzdONys5VTZUak9BbDIrMU1YekdXOG5ZVmhUeUlOemdv?=
 =?utf-8?B?cDlnL29VYi9haE1ycHN1UHhHaTl5Qk5odzFqNHE2YWhKVUJRZkpjSm1Na3V4?=
 =?utf-8?B?M0MxZW1mK2EweTJBTHJRenIwLzFrblh6L25yNVpRd2V0a05NYlpmQjVwS1RY?=
 =?utf-8?B?M3dubUJCaEJ6KzJrQW9VYndXK0FFREdpZm4xZVVZankvbHp0WlV6T1Ivc0Y0?=
 =?utf-8?B?WXIybW5MbzM0MmNnYWdZRnBidHpJTzF5RzJQWi84aCtHS1FjTklXNEZOYWVy?=
 =?utf-8?B?blF1eS94VnFibWpyQ0NzYmJ3RlJDYUhhUzhhZndrNEpocWJYZE9jNmhzVlBj?=
 =?utf-8?B?bzVvaDZWYWZrOUxaaVZpQVpKZDBmQUVUQmJiVjVQQm1SVUs0UHRpZnJpZVVo?=
 =?utf-8?B?b2tEdDlrYmZBcU0zeEZpSFQ1ZmRTSkliZnNMd29mdDRndFJkK25SbFZiTm0r?=
 =?utf-8?B?YkRlSm1wajRjWHJCTzBqUEhXOXBxdnlPcmp3MktsRTNKNGdEK0VDRkdKRU8r?=
 =?utf-8?B?eWlqTlhCbUV1WUkvOW8vdUR0TTUyTE9FNEY2TFdRK2lYeEZrZ0hCL2h0bEJw?=
 =?utf-8?B?WEw5NXc4a2NRczZxOGpTa3Blb2lYZUNXT0lmQWRTREcrK1hPSVJKeHRnOXph?=
 =?utf-8?B?UHpSMHNBbVVBMzRUcmt3K0tpd215OVZqMWdIK01qT016cDJzbEFScDJkb3h0?=
 =?utf-8?B?QWJvcm0rOUNNVlYrV2t0Zi9rV0lFbUg4dHcrUGMvemFrZElneTV3Z3RWdnJK?=
 =?utf-8?B?eWxOdW13cHJjR1dYSVN4MFhhb1VRekFQUHVRdWphL3BvcjRmcXRTbGhUWHh2?=
 =?utf-8?B?dmFVL1A1aG5tazA2ZlB1aENLVGQ3RnJjL0JyTFcrZzJ4eURtWjZmUGtaQnpQ?=
 =?utf-8?Q?kY5HWzBVIFgPi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNpekx4VEVlL3RtRlJBd2k4dGN4Y09KRVdWS0xhMlFIWmEzOStzUXMwQkow?=
 =?utf-8?B?Q3FqMjFIRnhyWWRyNzF2M1dEbFBtRkJqejM5QzNKVTZrQlZtOVQ4bGFMYzNY?=
 =?utf-8?B?S3A2RzJsMmZHSWUzcmdXbUl2bGd0MCtwWFZ2Vm03d2V3eWd2R29mcnJsNjBB?=
 =?utf-8?B?RkpQcERwbktrVGU1ZFRKeUFDZlI5cjFHajNtdCtKRkw1M1JKWVZvZUY0SWFn?=
 =?utf-8?B?OXZJaENCd1JMV29FWUVmajRSTXlzdnlabGdOTndIZnh5eVFEYS9pZnVOR2tk?=
 =?utf-8?B?WVZIdjhSbXpGMDV0QlJIVzQ0akdnUUtWK0l3dnBpZkNZT1YyQVFyNTk0VUVP?=
 =?utf-8?B?Y2ZxTjY2ZktNcmgveWlUbkw2ckRQL0RESC9RZm92MTNsNElXZm5zTjVjSlRT?=
 =?utf-8?B?eDRjUi9McHEzVFo2SnFsT1BUenAvT0o3NkhrTm03VjRoTWYyYVh3T0Fjb2pR?=
 =?utf-8?B?M0d4NGdESzUzMGwrMlNsZ2FtUE1OTHh3NFpkbjVmVWFDbkJ4V1RDSFpka3pi?=
 =?utf-8?B?ZnJHR0p6VHgyeGlENjhJVHpEa0Nia3AwaCtXTFFsM3VUUWVvZDhhalpKUUdK?=
 =?utf-8?B?UUpsdUZacS8rOUV5UW5DWXhwd0NoY1FOYXdIRllCN2dQdnBSeXE0NFNaVFFp?=
 =?utf-8?B?NXZJcjdrWnhhMVJSd0lPMGZWa3Q5ZldXUTd1VE9sTmx6eGQvbjJGeU9TQTlm?=
 =?utf-8?B?cVU1aVJPTm42dEI0RmtiSFRGSHhPajFnVUpHb0VHK2lHVTdvMkNlWG9XWDJh?=
 =?utf-8?B?c1oraTdUcjdTOXJveE9DYW9xbThhcHlVQTNwRlZ5VzJWNmNEVWNyMnlJVXY5?=
 =?utf-8?B?b2tLd2xQcy9USmx3WEVWUmtWZnVva2tRZE5qeWxuMS9GYW9KcUN0bEo1NnBH?=
 =?utf-8?B?V0c1NzVvYXBYOWU4ejJ0dW96VWJoMEhvMW5Ha1diWk9MMm9IcUJmaWpPZUVC?=
 =?utf-8?B?L1N1czNqN0FyQU5ieTRZK3lqUTBBWnRiWnRxbWxLalhCelRDelVZNEZZTGJh?=
 =?utf-8?B?cU1tRXlqZjJsVEJLdzZBZEtWM1VTRStmNFhjTnRIMm1oUTdIcnRDSXV4TzJx?=
 =?utf-8?B?YWYwR3lWWkt3KzRxeHREYWl6aWdXeTJaOWt2d2N5WW9xZ0g0QVBwdWVSNlJl?=
 =?utf-8?B?Mkx3d0dKdHNWU0FkL21NY24rclBTYTVXdnNkSDJ3SEw2cG44U2NYTlB1V0ky?=
 =?utf-8?B?OTdhWjdtaXZGc2NlbUNaUElkQUEvWG91bC8rSWI5bXJNT1dwKy9DVy9qYmkr?=
 =?utf-8?B?VGw4d2c5azB4dEo1N1c4VGk5K05vV1hJMXQxUDBRTXVQQmdZdHFLN0hObTl4?=
 =?utf-8?B?U1EwWU5tRXRmSXZDQ25pTTliUVZKMWN2QkdJRTBuTnU3aENaYmdEekI0ZGti?=
 =?utf-8?B?VkROWkIwUXBQbzR2YW9uN2lwZFd5UFpNZjBadStQblg2N3A3L3J4OGpQdjYr?=
 =?utf-8?B?VkNSOW0vZG9lcnVFekZPM1ZVTThmUnhzejIvVE5Rd21nUmYxbEFuWERXZVBj?=
 =?utf-8?B?L2NNTDNRSEs4Q2xuTkl3ZERSOHhIRjFTalp3dHVDSFphdXZqT1J2a1hMbThD?=
 =?utf-8?B?VXljOXc0REpvaG8vczlQMGZMZ1FkeWFvRUNWZ0M3eUlYQjN2QnBJRGdYMkZp?=
 =?utf-8?B?NmFXbFR4QVROT2FsQk9WcFZCQkkvUVRocUFnb0VlNUl2ZmVwejFGa1Y5SWh6?=
 =?utf-8?B?a2x2OFg3UGQyVkhSMnJGQ3BaalZOV3M3ZVZLazJwc3FCTEsyTlFmSEl1ZWFW?=
 =?utf-8?B?dUp6NmhkalZ3ZzJJTEpKemlzQml4K0xXVTlwS0N6Smo1NW5xV0tGUVhYTWpu?=
 =?utf-8?B?bnhZdzlLdEIzNElsQUlZV0lQaWdjTlRFY2NaUEhXNTlrODhRQVZIbFNzd25F?=
 =?utf-8?B?REhwNkdjc0lLL1A1ejV0d01BbDdZVmZ2TUlzUy9YTWtNaitaZ3FzTmdFRXJx?=
 =?utf-8?B?VEZhdVo5WE8zUHU0OUVWZXNqVi9Mbi93UWhxMExrUHY0VmVuZ0MvOWFpOXc2?=
 =?utf-8?B?WGFjSEFqM25hNFFacmhFZTNwZ3BUYUhSeERIVzBJMlAyZXVzczVjWDhxV2Nt?=
 =?utf-8?B?akI0V0hmRTNCaDRoUmsrSTRUNktrMEMxcEtBeFozQjVzYmZHM1VLZ3JQay84?=
 =?utf-8?B?eFQvUnB6SGxhRUJ5NU9sQXhPc3Y2Yld4YlU4YnEyMXp6TVJIa0tsakJHbDl3?=
 =?utf-8?Q?MB8hNEuL6kqQuIac+mwvSjo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e311b3-4bbc-4e30-053a-08dd46024a8a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:29:41.1943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2rWFVrcNPhqNDNhB5VOkHZHtc7ZKezmYP29Rijaa6TTTeJKSP4//YPORyX5jPYABQ8ER9NVg6O8H/t7QJHPFzoyZKY9xjpzWTvHACvkg0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909
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
> The vendor boot_merger tool support a ALIGN parameter that is used to
> define offset alignment of the embedded images.
> 
> Vendor use this for RK3576 to change offset alignment from the common
> 2 KiB to 4 KiB, presumably it may have something to do with UFS.
> Testing with eMMC has shown that using a 512-byte alignment also work.
> 
> Add support for overriding offset alignment in case this is needed for
> e.g. RK3576 in the future.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/rkcommon.c | 75 +++++++++++++++++++++++++++++++-----------------
>   tools/rkcommon.h |  2 --
>   2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 324820717663..542aca931693 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -124,6 +124,7 @@ struct spl_info {
>   	const uint32_t spl_size;
>   	const bool spl_rc4;
>   	const uint32_t header_ver;
> +	const uint32_t align;

Missing documentation update above the struct definition.

>   };
>   
>   static struct spl_info spl_infos[] = {
> @@ -181,14 +182,19 @@ static struct spl_info *rkcommon_get_spl_info(char *imagename)
>   	return NULL;
>   }
>   
> -static int rkcommon_get_aligned_size(struct image_tool_params *params,
> -				     const char *fname)
> +static bool rkcommon_is_header_v2(struct image_tool_params *params)
>   {
> -	int size;
> +	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
>   
> -	size = imagetool_get_filesize(params, fname);
> -	if (size < 0)
> -		return -1;
> +	return (info->header_ver == RK_HEADER_V2);
> +}
> +
> +static int rkcommon_get_aligned_size(struct image_tool_params *params, int size)

Maybe use an unsigned type here as a size will be guaranteed to be positive?

> +{
> +	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
> +
> +	if (info->align)
> +		return ROUND(size, info->align * RK_BLK_SIZE);
>   

Why not make info->align be 4 (RK_SIZE_ALIGN / RK_BLK_SIZE) if unset?

I like the change, though I felt splitting in more commits would have 
made the review easier, e.g.:

- split part of get_aligned_size into get_aligned_filesize
- migrate hardcoded RK_INIT_OFFSET to get_aligned_size
- migrate hardcoded RK_SPL_HDR_START to get_aligned_size
- add align to spl_info + handling in get_aligned_size

Looks good to me otherwise!

Cheers,
Quentin
