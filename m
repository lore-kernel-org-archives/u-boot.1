Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD26C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141D687D14;
	Tue, 16 Jul 2024 09:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UPb+l/ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B24B874AC; Tue, 16 Jul 2024 09:37:53 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2651188986
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN1kwgcDDWk14njpNsENauX+M+378Br7p2irHCCeaofTpHRsY8dPpN1PkCQmghZS7kafaK/A34qJeBUrSkrS412sYgiEZx38IbYtjVT8imXdtsHUHYZ4ZbQZ8N/K7YRVbYFjxW4lbJfgPIA3gmEQO6AJVnmu2zHyyKrtGUEFO+Ze/I3aim3BCE8GQ2TrD/rAM0I+bnRSb6kQoitahLSiRKt3VKqA2yE1EC8Zoe9PtCvkD9YZQvx5lUIrthWIKJxcqJ4HGcM+E59Vuy8mIf1gT1s2iECgOZdmGM9CWMz9/pTBB/5BoedbNt5Ixvi/7fWKKh19lIPrQoctVnY4qQig7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12CsAnPmicPQw88pO5d9CuULIiLgL8aJLbZgsRmZ9pE=;
 b=hJdziz/Fnbh2Iwr2kRSskSBQXqzqe2K/cNeoRKEVitlQGuQial3intgvM9T1tRmoeJTk0TpgyQGVoqC1uewu0neZ0kSP+GeguftOZhEVBSiiTeWR+2AOjdi4PMvtiC9ei88xOk8Hg/YyKCRJlaXoy+/mT3hkdhGhqoFVUPQABLTxZr15kcMaUEvaLP2QmNNpRLD+rP28zyOvB6jzSuLud7MQERl5aJgzjWOC1AFoMrO+tYKtdqQiTyG5Rf6guNyXAU0Zd7ik0/mXVrtZLsn5mtMtPyDDdiz1tCro7VFAkdyGAUqgDiEoeIdbxSt2ICqzma9kRhBzQNbVFjwIpzKZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12CsAnPmicPQw88pO5d9CuULIiLgL8aJLbZgsRmZ9pE=;
 b=UPb+l/eyYRWfz97XylI83819m5tRe9IvnjueW5LRgf7b66K9XHVU/EQpG5d/W63ApDqvk7LK23hD/BYQZoVnNCSD0M+KRMiyEiph05crp+xbuYqNsT2H8ceDc4W95wGbWUSORaG6YNsPkkteOo6bwavSEz7ccZcGdMFPJYQX1LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:37:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:37:49 +0000
Message-ID: <df29a993-7aef-4214-aca4-68b09d20bc63@cherry.de>
Date: Tue, 16 Jul 2024 09:37:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/4] rockchip: ringneck-px30: disable broken USB
 gadget
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger <klaus.goger@cherry.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, =?UTF-8?B?546L5piO5oiQ?=
 <frank.wang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
 <20240614-ringneck-no-gadget-v1-1-d3bc6e5088de@cherry.de>
 <bfc3d708-0a4d-41ce-a9a7-fe2f435a88e2@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <bfc3d708-0a4d-41ce-a9a7-fe2f435a88e2@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c869c6a-29c0-4128-3d63-08dca56a315e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aStOblpvVFRuY2pHamppc0xwTUpIYzBPZjlLdVQvRmdsTXNNa21nUm4rZEFa?=
 =?utf-8?B?N2NJbzljWnZ2NmNOSlUrNWNkYy9hYW9kekdjNnlIT25GeFhGODNnZ0N6SzQ2?=
 =?utf-8?B?WFQ4RXh5cmFRVVhBTWRCeE8xZW1ZTlQzOWl2T2xVTDh1azMzWDUvWFNMMkht?=
 =?utf-8?B?K0F5RWJ5eUJDUnMxN0o3Q2tYMXBhUUxhRmthbm1JVjBSL0ExRGRDU0xPcWlR?=
 =?utf-8?B?NTc3VnRqSXg1OHlDeHM3OStKQnMybWljUzJGR3Fwa3ZyTDQrQ0N1VEdUZkhl?=
 =?utf-8?B?NWdZeDhCMmp6Y2N6TElHUFVBWndrR3hoS2t6WDJXcHI0SVE2Q0p4ZytwSElR?=
 =?utf-8?B?alRKVUh3MS9BSEpTdzJYcHFPYXVGUmNhOXV0QzBSTzArWk1QNDI1SVRmLy9E?=
 =?utf-8?B?THVOZ3lBOVJ0d2tvcUpmRkllN1FTSVVCQnpTMnhSblI5RVc1YVRVRUJxcHRZ?=
 =?utf-8?B?MDhkTzA3NERHQUd0R3d1Rlg3RnNRaFlXbjZBM3JEZkE0elpaWmlQeXZ2b1Nw?=
 =?utf-8?B?elFtYWRVK3NlQTNKMHl6blBrcm1lTEtiU0lVSWo3SkRia3pqZmJEZ09kWHow?=
 =?utf-8?B?OTRuanRTMlVsWkpTUGhwNWRRdEcrc28wTGhKVExCZU85Qndoamhka2h1QjJp?=
 =?utf-8?B?TU05aWwwWk9UcWREN2Z0anJ0dUQ4aG95aytDT0k1RUZiNjBLTFpNUjUwREJu?=
 =?utf-8?B?MXFuWFhGQVhDdjZHZDIwQXlJNWpYUE5MZW5ON0hNSG1sNm5tWXpZQ2J5dldy?=
 =?utf-8?B?cnFkWmpTNFE3WWJXMlV6a25CQWltSlZRQm5FcG1uZHZ0emhGZlkwMjArYUpE?=
 =?utf-8?B?cVVOOUxTMFhTS2FEa1NXNzVneFR6R2l4MzdGK3RtTTRpT0ZYd1hkNnoyc0Zu?=
 =?utf-8?B?dkM2SVhBMHRsVTRVSkRzNVFNQ2FydFo3dGhsWFVKUktMMFUzbTd0bEJScGFo?=
 =?utf-8?B?ZGphMHMvOW43MVljQS9QbHJSVVBYK2pheU9jbWhKbVY1RHM5dlZheFhPdzBM?=
 =?utf-8?B?Z2lTOWU0ZUptVlNDSmY5Ykk3SUxJTEtZcXN2VkFzcVVtNmQvQng4RnZDc3J4?=
 =?utf-8?B?MDZlOUdaVDgrZkxxQW0yY0dqa210UitKUXFQOXd0bXdaaEtlaXF1QU90aEVF?=
 =?utf-8?B?WmlHa0FrR1hYa3lEWXp0TFRLcG9QWjZrQjJUamh0YzRZellBWHk4aS9Ub2oz?=
 =?utf-8?B?L1VaNG1jdDhTM25UY3ViNjVCNjFTQ3FLQ2ROQjFmUlJsb1lKYkNYV282blZJ?=
 =?utf-8?B?NU11YTd5KzM5NlhBNWtPUFpEcjZqK3pDbXRvTlVyVnBaRjFOVTUwN1MzR1Vl?=
 =?utf-8?B?MDF2bkVUbUJDa0I5a0Rpdy9VVys3SjJyaVR6R1hmMHJSK2doUFYwVm9DOHky?=
 =?utf-8?B?eEFPMlhDNTNrb1hXQWxGeDVFbVFXbk53NVFzWnhFSGxsdmZ3VC9uV1hJM3V1?=
 =?utf-8?B?bkU0UWpzc3JYUWFjL0dhSUQvNUw3T2RwQXlLSFRCLzJqcUFRLzNjY2hycmIy?=
 =?utf-8?B?TDZTRG9GdDlsWWwvbXZMZjZIcHk3NjI2cmxYNWRuS2NmVUEyRUx4aGxETFBw?=
 =?utf-8?B?TTlmdnBPamltMDB5d0FoSDFxSHZkYWE0SzZOaE55QUxSd2dFUi9aVGFSN0Rq?=
 =?utf-8?B?VUQ1cXpwTElmUFdzcnlWNTJOazRnM0pRRnlEd0VqMy8zQmViWUwwQ1Vaemp4?=
 =?utf-8?B?Um0rRFZKZlJZQVpOd1I5Mmp6NGlKbkRpVHo0RVRVSURvSVh5UGQ5SkJNYlQw?=
 =?utf-8?Q?B/k8i78NKmL25YUTVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJTTWZMYjhvdVlubEluZlpNbm9DQTZMdWc0cHl4eURyREJ6U1kzR3NTZGd2?=
 =?utf-8?B?OFNYc1hRMlh2d0l0K0duZFZMQkp0cU5TVC8xdjFSaTVYb1hKY3ZKT083WjJS?=
 =?utf-8?B?NnJQOG1qYnBzdnJtS014L0hjdHhjUGYxdnBXL1dPMkFaQ1dHYUEybTZRUG1h?=
 =?utf-8?B?Yit6OU5MWDE0cGtyTUt6SFB5bHhHREJNcUl4anY5VzdHTHRySS9tcUR5bnE0?=
 =?utf-8?B?NGN5b3B6VTZ6b1ZvMjh5MDBDd1lHOEg5eWs4R084b20zQllCTFcxbUpabTFG?=
 =?utf-8?B?ajB1MVZjdTBBY0FMYVRxcldhOXMwbHkyUnNHUlhtbm9jaHdtL002YnZmM1N1?=
 =?utf-8?B?YkJDMTRSOHovQTVUUnFRU2RxRUFRcmdJR08xTmRFRldnTEJSSFUxenh1Wlk4?=
 =?utf-8?B?YjFYVUhDQy9CdDdEMzBLN1UyRitjLzZ6U2tybi8wRFZORThHTjBiTnVkdTNO?=
 =?utf-8?B?eTVmNWdTeHU3WXc2Rm5Ja1A3N1hhM0tnUVlLMU1YL2p4ZjJYUlp6TjJ2eDYz?=
 =?utf-8?B?TXdEWmYvZTNDR01qUnhlZlhES1I0d0pVSFFvdFd4bnM5bkRjclQ4Uk5XWmlp?=
 =?utf-8?B?Ky9Nb0FRUUgremd4Z1NtTFMrYTVhOE51N0FXR0ZUc0lNdFREVERDZE9DOW9E?=
 =?utf-8?B?OFRSaW9VOXYrc0JnbTVGQXB2cHFCQlh1blhyeUtuQVFUUWxtQnhKYnhQcmY2?=
 =?utf-8?B?dVNFUUFGbVRSRVZJUXNTdGhiUmRDTHlRYjlLajR0VEZRQVRHbHljQmpVMnps?=
 =?utf-8?B?bU53Y01CMytOWnh1cDU5V1FPMXA5VWFMOWdnaFBVZXV2RkJJZk0ySGYwRmQw?=
 =?utf-8?B?VHVXemR3dUc1WmdKREJMSjdWY2lhc3VPMjBySE1nZThuL0VSK2Y5UHZaYVM3?=
 =?utf-8?B?ekVNWUU2RFNTamFaU0VBK3FmVWIvSnlMVGhjWm9kR1RyWmNqWkdQRDlEUDg5?=
 =?utf-8?B?Z1hTWFJZYllsNHl3VmlyOGxPSUJibzdEbHFweGNaOW5FSjZYQURIaXpGWXVW?=
 =?utf-8?B?Ky9VYThjK05sVlZUbFc1SFNHODAydDJDRm5DdjUreU4wVUZzRTl0ck94ZHBv?=
 =?utf-8?B?NlBjeFNzK0pHc01lQXpEbzdOR2MzTWpOaVZlZGZXM2xOZDk4SHd5L3hGc0lP?=
 =?utf-8?B?ajRkWXFtYVFDOW5meHc3UVloMjg1NUxHcHZscWk1Z1grM0VnTHJWU05hdGZI?=
 =?utf-8?B?dFJOSkpUakowZ0ZYRUN1ZHpHQXl1cll3czZ3TUVqY2JicUdyUi9WWVI2QTNZ?=
 =?utf-8?B?K093SkVxUFJFdkNxWVc0TFhIV2x2ODVaY2VNWWZIcjZ4MHJIL2hIVVR4VWJU?=
 =?utf-8?B?ai96eHRmWTEwU0VydEVmME8wbzdKcWFPcVVuS2EwNVJhcksvV3FzUkx0Si9y?=
 =?utf-8?B?b1N5VXVLMk5NVWdBc1VTQ1ZzQzJiZzloUHE3SjhLR3dCMUUveWhyVlFxUVNk?=
 =?utf-8?B?Skx0aFpacURyTWJwTGViVXNQMmU2T1IzK2kyb0VJNE5CdDlVM01IRVI2U1JI?=
 =?utf-8?B?R053TXVzT2ladXMvb3BiVUszSlI3TWU3dGgvdkc5QVFSUW5MODlvZXlOcEtk?=
 =?utf-8?B?Z3RWQktqck1HY3ovV0ZMNGwwY00vVmdxN3YrbXJ4c2FrVzkvZHE0b2ErOTZk?=
 =?utf-8?B?aXdkZWk0K3pZVzNTYTJxS1pWQUl1NWY0Z0RJWTRPRElPTVYxZkpuZWFtb3du?=
 =?utf-8?B?ZzloVDlXYkZlV0lkKzRKOWJlUUFzeThmWGJMU1F5VDYxV3RtNHhaRlAyR0Nt?=
 =?utf-8?B?UGx5cnFna05zQjJPVlJEdlZCR2k0Y1AzR1ZYNmxMTVEwNzVyYzJvVWZFQlBC?=
 =?utf-8?B?UzllOWFPbUo3dW13UzRPekFwUFc1TU11Nm1vZmw1ZTRYV1VCaXNBakxBcmZZ?=
 =?utf-8?B?blIxckhrcFZkRExUTXpsNlJCWVlNVm1Iektyem9oWGljL0dhSzdjVXg0dHVV?=
 =?utf-8?B?djB5SFVPcmx3WlZneVgxaW1UamRQa002M0lHSUxSdmxJeVVjcTRGRDltbWpw?=
 =?utf-8?B?WGk3N0NOU3NjMUQxRlRZK2k5OGxqTzJzK0w5dmFwU3hrVFRBTGcyZWJJVnF3?=
 =?utf-8?B?c1BDdENxS1NwUGsvYVFsSUJhcSsxQ2NUUHRtM01TQ2hKdi9tTmFsMVQxS3JD?=
 =?utf-8?B?cXRpdlNGOXRKcDJDUzYxZUhEUlZWWHBsZUJ1ME14Y2J5aElaQ1RYTHRzM0Fs?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c869c6a-29c0-4128-3d63-08dca56a315e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:37:49.4307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMvAzsVoF4eIaMZkH3Rc1rz8sqaBFPUzKLNYmlRbBJEWPV6vR/r9McJbBTh0rUSKlFEPjjddFHjwjGSwrHzz3gB3hiAoOaT4A6I3BSEXaXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815
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

Hi Kever,

On 7/16/24 4:04 AM, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/6/14 19:04, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> USB gadget simply doesn't work right now on PX30. Tested on PX30 EVB and
>> PX30 Ringneck with Linux mainline and Rockchip 5.10 Linux as well as
>> U-Boot.
> Do you mean for both U-Boot and kernel, including mainline version and 
> rockchip version,
> and on both PX30 EVB and Ringneck board, all SW&HW have no USB gadget 
> working?

Mainline U-Boot on PX30 Ringneck -> not working
PX30 EVB and PX30 Ringneck in Rockchip 5.10 kernel when I tested about 
two years or so ago -> working-ish, but very unstable on Ringneck and I 
think not working at all on PX30 EVB
PX30 Ringneck (possibly PX30 EVB, I don't remember) in upstream 6.0.2 
(and also next-20221216) -> not working

I don't know what you mean by SW&HW, how am I supposed to differentiate 
the two?

FYI, I tried to add **some** support in upstream, it got merged and then 
reverted because it broke STM platforms, c.f. 
https://lore.kernel.org/linux-usb/20221206-dwc2-gadget-dual-role-v2-0-0de821615dd3@theobroma-systems.com/ 
and 
https://lore.kernel.org/linux-usb/20230315144433.3095859-1-fabrice.gasnier@foss.st.com/

I can test stuff again and provide a bit more info if requested.

> So when you test this, does the maskrom mode works? because it sounds 
> like maybe
> the HOST PC is the one have issue at the moment.
> 

I can use rkdeveloptool just fine when using Rockchip blobs from rkbin, 
no issue with the HW asf ar as I know.

Cheers,
Quentin
