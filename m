Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49500C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC93831A1;
	Thu, 11 Jul 2024 13:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="45CN5CVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB0885B66; Thu, 11 Jul 2024 13:59:35 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DEB80705
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6u1omUxCWgzlxqJaXT2WOfF/CjBPXPCObSjFr4bB0nTNvVFg3CgBkYp3rcv9uiuRt0630Xn2aY5wSyEpMg9cit1OaACb6RgzUtfqXMWpRnR1sblqN9KRFFCo0hqxQQp8Vt/ev66kS1l/VlshJKNTpglf+EQDH1gCb2CcwpYzIzdX9XXIjMN1a12nOLlcz93KRwZ4o9diee8L7sDLaovnWVb8tUjKN8eZKVbMpsNTUqFFt5Yc68yhRUXsCWvgsbCg9E132NxywHeV+9xtdYU5t4bujLG5EnhN+8uGYrXQ3zI/02wFRLAy29B0Gek/ufi/lbT0oXpeC4Jc//BggLyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6E9ZYTM/p4+E7cGV3KfTBuVKyc+y1k/XOZLPZNaSZM=;
 b=MgjWrg5GEvK3LJXQxDcsN/XBwcD7PLi+nwgcTgB6iU1DafgjDYnCz/Xi0JWmzNrX8BIkxoC5810uLLzSZl/UWUwuaN9is1i3Wb2dG+bgdeD76UhNY3fmZ0WYZkmgRyzIPfq7xPo40L0uPtk5BtJJLG1D1zWTZLkTZfkUc+tcg7w1aARQJx5fmXnGIwUTEoBkVJ5QITupYLkHiFXxXeTXyYflLK1LEL8ttktUzCGc118NEJ1MuzmdkBy/cPrYhy/Gd5S1orMNmmlE8CKf5Y3W7jtepmVbkLikQsuA7+j5FOKvp0tPpzzAOgkBENR/0PdFLLbo9WoAdWh+ymdr1hwzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6E9ZYTM/p4+E7cGV3KfTBuVKyc+y1k/XOZLPZNaSZM=;
 b=45CN5CVV8nabtxK+a0S6bjNAEXxeRj+TtQ7VrrIbZ1H5GIzKRtOp4GnHxiRQj3ED9nhJFZOSKy0yVVz7+DVljujhl7g+ys8pSqeVH0LzQaxcVBJmgtd7N1mlMSQYmHGxYClWTteJR9loaLq5N7AvIYjnx1U6GN/KfZvYFYmhPQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 11:59:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:59:30 +0000
Message-ID: <2bf46601-e8ed-4976-bf22-029d43c6265f@amd.com>
Date: Thu, 11 Jul 2024 13:35:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Remove UARTLITE from defconfig
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <c9b66495bbdef3fe94467ae43c50a74adaaeacae.1718716833.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c9b66495bbdef3fe94467ae43c50a74adaaeacae.1718716833.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a079772-3c75-4128-63c6-08dca1a0eb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlZzTElwNTdyTDdMMjFIVEx6NWFZbWdOV2dXOUxlTVlKc3dkQVpFdjY4dkxL?=
 =?utf-8?B?K1VEeWpScFFOZXhUNG9UZkdyZ1R4TG9zaW9Bd1paMmNwc1kvaVdVSWt6bS8r?=
 =?utf-8?B?bG9IVlE1RGNFeUg0bHFPMGQ3UVJENUhTOWQ2WVlrSmVic1hUQUNaRk9UM1ov?=
 =?utf-8?B?bk52UTdpeHA5QjVBcytDd0FHV2VDbVoxaDR0Yk81SVh3S3JCWVp6QkJjek1N?=
 =?utf-8?B?Rll4Y3gwWXBCbytWSTVyYkE1MzlxZk9sYk01UnlrTDlHVHNGZkNuYjVVTXpG?=
 =?utf-8?B?QTVHekpkZ2E1ZDY4UXZhVTg0Ykd6L1lvNU9QV20zR1RDWUIzNC9xaWdUTm8z?=
 =?utf-8?B?NkNUM3N3Mk5EV1owQWM0WWMxTWU1b1lGWkZ6MWgvVXRLZjVveElOeHF3WVpQ?=
 =?utf-8?B?MUVESitxay8yY3JUbTF0VUNCU2dmQUNxVXZMcWo3a1dKalNneC84LzZnYjN3?=
 =?utf-8?B?OFpHYVd2cEtKTDdLQ1JiQ3o4NDdJaXJ0cGFFZ2M2WkphbWx4TUVPQUJacll4?=
 =?utf-8?B?UkdxcXBHazZ3UExGRnVwN3RZV0s3UWZCNXJPUC80TytyTFdRQkFMYlZCZ3VU?=
 =?utf-8?B?QytFTzFKT21mS1IwdG1aWHczeEFFUUVqUXB3TW9qZG54ZHZucWRJTC83MnNT?=
 =?utf-8?B?bTJNR0lJbFpsM2JMcEtKeW9PK1lXb21CWW15ZnpMQmFBcVl6ViswOTdCakVp?=
 =?utf-8?B?dGtrZHd2UkxoSnd2ZmNpOVQ2ZHJnRFRmdFlhWmZQaWkxNTM0WXVDL1p4bG5l?=
 =?utf-8?B?L2lHNkZZZTkremViKzQ0eWRONzE2T2VGRWo1N3JBQUJHaXgwM2NEQ2hHN3FX?=
 =?utf-8?B?UmJGTnNUek9jY1F6RTYxWmtLSWxVSW5PVjJxeVRyaVhYMTczNklaYXdMdEl6?=
 =?utf-8?B?RDFPYUxMQ2dBK1RONjJwOW02clZBRlFrU3dkci94dW5TbU40R3FxdzRDWHFz?=
 =?utf-8?B?RVpScUZvQWhtcjU4cy8vTlE3VUhDK0hOK0VJTEtuLzkvUld6V0JyOVNyMlN5?=
 =?utf-8?B?WHRSTFVmaTMzS0FIRDQ0VWhSNEkzR2Q4NzFuM0FWUzJINTlBeFVwQ0IvTUxW?=
 =?utf-8?B?R2pSOTNMS3JTQUFlL3MwOTM5elFLeXlCMmw4SURrYlYzSUlFZjBnWDRENFJs?=
 =?utf-8?B?RDIxak1NNGQ0Qk5ubC9ka0tuekNNM0NJSTNKM1JNTDBibGl0UWt6OGVYR2kz?=
 =?utf-8?B?aW5RY0U5SWRzZ29EemY2c1RQZlBMUStzblFSWjJFVEVxdWsybmJKTTFPYzNC?=
 =?utf-8?B?WDdOQWtkalgyaFQzTWI3bEZGLzlJejlXTDlacERRMWJyN2pQeTRBUjlGaVEw?=
 =?utf-8?B?VytjTTNDbkVmZlhCTlJpVFFvbnVOc1pHbEtBZmtuVnMvdk5OVmorcFVZMjNl?=
 =?utf-8?B?WUJsYWdxTWRWTU9vUGhzUmlIdjVWR1VnTitYMzh1eEcyQ2g4azhOL1lEOTh1?=
 =?utf-8?B?aVBGeTZ4V2hqMU9PVHJCMnYzM0R4U0IvYUdXVWV1Tkhla3lydTZyRlVmVlIw?=
 =?utf-8?B?blVjS29KaE0xYXRzbEF2KzV2YnpvSW01eE0rcGNsNElGYU14M2NXTW1zY0F3?=
 =?utf-8?B?dFZzYXJKeUVOODFIOTJkeGpRbU5ScjY4bTd1eTJidlpYZnhrS0dQU0lqQUw2?=
 =?utf-8?B?Nk9kby9va2NEWEp5NWY4QmFnSk53VUFRYTJ1bHJxTmViSlJIUUFYYzY2bU9r?=
 =?utf-8?B?Z2xOZFBXOWxPUzZsZTh2QW0xYXkydXZEenUwOUhENXo5UGhleTZwaVdnT1VJ?=
 =?utf-8?B?UzBTQmp4RzhUbzcvWlFyU3QwMFYrVVYvY0YyMDF3ekNIc1hDR2VTZGI3TzRp?=
 =?utf-8?B?SXdaR0lyMmtZOGE5aHJldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05YU2dsdTY1UDAyTTJYNHVqUFVoL0dMc21CUnhkL3ZKWEN6ekRKZyszaGRV?=
 =?utf-8?B?Mi8xNktrREtWQXFXVnRQTW9URWM1eUZoVlBKcnRGNitBNFNiWjZoeEFyMnpm?=
 =?utf-8?B?MmVIVTJKUkZqRWkxNWI0QjV5MWhwLzdTY0FRTGdyYlQzVkVrVXl0K2J2REZG?=
 =?utf-8?B?WjF2QmJoVHdNcHltZVVCVndvUHZXdGV4SDN4MDdEdklibWZ3YU5UUU1ManlM?=
 =?utf-8?B?bzZ3dTdMY2p1cWMxSlFFcng4czR1MnBMRWpSaW9PUHQzc1pBRHMreERnb0xC?=
 =?utf-8?B?Qm9nM3hvOFJ3aThzdkdUcEdzTlc5RDhxbFppUUNnNnhKYU45c2M1NGV0OFM1?=
 =?utf-8?B?L3kvWERiWTNTRUprbUlqdnh3bEd1NldDcUo0YnVadWt5U2ZZVkhjdXh1MElB?=
 =?utf-8?B?ZWdFQURUZkt6eUlJT1QwVmRadURnLzQ3OFEzMCtSaC9FZnFNZEd6ZWs3b3V6?=
 =?utf-8?B?OFBBTG1OSjhCNkNHbFZiMXVsTzNGOHhYbU1CdVFiOVNoMGcrRFdtTTltMHlk?=
 =?utf-8?B?dXF6RnVEM0NWaHp6ekRiVGx4aXNrZndLaFR0VDE5TE4vQnpvTGZBRkQ5SmFR?=
 =?utf-8?B?SXpiVlY4emFZZWNHOVFPZGI1ZkRPSlNBRTNEU2diVkJTNFVsay9BQS9uZjBa?=
 =?utf-8?B?bEZLQnJYc2NyUVY3SHJhQUphKzFkaGt2Rnh6UnR1SERiSmdjbVRIblMwekRy?=
 =?utf-8?B?WERiOXZtWWp0bEhHbEw1MjN3VG8rWDluWmc5MDBCYWZBODRFNHR6SnFsL1h4?=
 =?utf-8?B?VWdrRllHdDc1RDJXQ1h1bmo3eUViL3Y0UGh5NVUwMFA4R0ZZak8ydHVLbUUv?=
 =?utf-8?B?bkhRcVJpWVJYWmpOTllXYXRVa1l2NkJLY1hRblFkaFVoaS90em9wcG5vR1I1?=
 =?utf-8?B?ZlRSQ3lUTlh0dFZGeERDNTJPZnkrWXJXdTVBZ0VSK0pmenNRejk1SWJKb0t6?=
 =?utf-8?B?Mnl0RGtqRXRJdnJZZUxxamR0THFUdEJ0d29oSEdHM1RsUWwycDFobGp2OTIr?=
 =?utf-8?B?SDVHQ0dzYXV6bFBLblV6cDNxVnlDbzh6NnU2YlBVc0ZiMWI5VlpMZUg1OXVG?=
 =?utf-8?B?TC9lcnVuY2pCVFVGUWJQY1kyQ2FlK20yV3JhalJYbnJ4MWVPRUkweWJWbjJQ?=
 =?utf-8?B?T21UUHNpU3puTGFKQU5GbHgrN2ZNUFdHK1QvemlFVXhwb0xKZW1LY0hpZnp4?=
 =?utf-8?B?UDN1RXBZSmgxN1FoYWluZTBMZGExNlVwWGY3VUMxSng1cXE5cWc2OFM2YjF0?=
 =?utf-8?B?OEJkbzZvUEJTR1c1TGplbU5DMG15aGg4N3F1Z3lNWW9FN2kvVk1xTXJXK2tt?=
 =?utf-8?B?SmRHeTJhcmlGd3NRWHRqK0d5QVoyWUZ3N1lwV0tXYlBrQWRidklJNUtpSG1H?=
 =?utf-8?B?b3d4NERRTzBSWHBuVzhPZGgrWFJERSs3Wis2Y0RQRlZaYVRaN0Vpb2tyeDdJ?=
 =?utf-8?B?SWs4Vk5OaDBxVTBvbitsTGRkdHRya3VtQnhnSHlKRVBqNzZKV3BNbWxxSWRZ?=
 =?utf-8?B?dzVkRTVGK3d5MzBPd2I4M2FQTmtBa1A0TVpMYWlBa1M5ODY5N252YWxCK3di?=
 =?utf-8?B?Y3k0MFRaZXhYZkdIei9PdU9ONmVGbEFJRUpRZEtVZk9TWUZDWVNTQTBpdjQy?=
 =?utf-8?B?TDdoNTE3VHl6c3JyNFJPbDdhTy9UeTZKZFpSOHNwc0xvc1FlaUduZDNzWDdE?=
 =?utf-8?B?SHpzSGE4bjFyT296WU5YTnlWVUlUQnFBMy9JYVBNK1hROHlDTGZ3Q3JENHRu?=
 =?utf-8?B?VExwcEJlUXBnWjB2VG9DVmFFVFhxQS9BVUk2YTVLRjYrN09UUEFJelpDOGds?=
 =?utf-8?B?OGhYTk14OHo3SmxzcnhWSTc5NmpkWkhCdTZtNlgzUC9jNTY4S2RwME1FZ05F?=
 =?utf-8?B?NGdOUklkNmFHZG9aRHI4Q21lNEp2c1EvU1FQa1dSWndXN3JzaDRsWUNhSnBj?=
 =?utf-8?B?NDZ0UmtjVlRLWlUzaUlMMzBIRzZ5dWtPNEhpQ1pzRk5RNDVDVHJqVThtU2Vx?=
 =?utf-8?B?UWJGNVp6bXpRRUtvOGtVSzM2QjFraXVFWWJTbVAyN0JHdUc5UEV3ZGl5Ritx?=
 =?utf-8?B?MmRRbGo2U0h1K1ZSN2lzZEw5UjJpd0hhbmcwQUoyTGNaVDBNUzQwL1lBY1hO?=
 =?utf-8?Q?Spj+DJaq54U65jP2NYbyXo8cg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a079772-3c75-4128-63c6-08dca1a0eb2d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:59:30.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oNLFauFHcAAAMvGwfAYSE4y73agpvzhtmqFIiUkGnf7O9JUTmr4DCgicgvKtY2f
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



On 6/18/24 15:20, Michal Simek wrote:
> UARTLITE can be used as console but none is testing it that's why removing
> it not to pop up there.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 2d611f84cd93..b071a480b517 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -119,7 +119,6 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
> -CONFIG_XILINX_UARTLITE=y
>   CONFIG_SOC_DEVICE=y
>   CONFIG_SOC_AMD_VERSAL2=y
>   CONFIG_SPI=y

Applied.
M
