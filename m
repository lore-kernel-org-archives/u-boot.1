Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF7C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 10:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E2D886B1;
	Wed, 12 Jun 2024 12:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FHdhIzYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24348883D3; Wed, 12 Jun 2024 12:37:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0AD88763
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 12:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl+mRqcX8v3zXBoTL+sAqPZV8vXcCJ0LQRDdgYOud32BtVLagrFud1yMeR5JMxbHnsfAbUXN8xgFs/kEZXUQG6AoeaJgusbBCG4TiQ5AxdsMyAjgYwSy5kdW1rPcD0ZP+dOM+/XvNR/Wc+oGkUIqbhftYXJoFHr/mz1yHrsUfpH6HhjFGFHqO+fmJOS896d58sZrEIjCXyyygnnKybO05BGxg4bH4wTPhMEVBDiGNgB4j6aq4Aki9c4K62UxNdeVLbGXKeu+2VG/rI94GyHMikYN645jKXv4ZE/zRR4Wol+pH5+qLQylpVr9owpF3XeXOfPpre5zzeZ/+rIzEmdcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7AMAz+k97YWC3xI++VAr/poZ7rGt5X/3ikynk156wM=;
 b=eSQBb7z4veIdEz1aaYVhR31z5LVjjuV3y6bslBYTeJ6M28h8flvT8iXIqYHXoxpUpvXSeNY6bG5VHu0MmZOUBRxPCD3szT2/g7lYloz9Pqhdld0TatFCi3x8KqCHohQHWf/q4h5j3BFgaksgpDFs9gpnYz4AFqnqJLGVTHZE/Sjv+u2wC8n7wBaUqiNzXNzJ95F8bHPw033HRS2IySr5eEPMv4A0A072X+C1xIALDKQs9R1Ct9d3rDmYuwpLFJ0eXZQbyv6kFMBgQcDGn1IstnhkFEa8XMXyL10sOzxb5/Cszbar/AJTYma8vQCVn0skGOcNxM0J/w/Kgc5YRB2G8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7AMAz+k97YWC3xI++VAr/poZ7rGt5X/3ikynk156wM=;
 b=FHdhIzYjVXdKjAGYwabdiKjVUV/Ted32UfG72p3IAc8eUL/i27mFOGN3bsx0UQex9Tp3YeKbG3/9FSOSDHyms2gRgCQlfNpkTSKkSR1D5pzBMGsZcORZ01oMnjiP2YQxXMv2yPjvimalRELcJNrlQqDw2O9q5uJEWIcpcJYgoJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 10:37:40 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 10:37:40 +0000
Message-ID: <94d1e571-6051-4a1a-b15a-ab5147ada833@cherry.de>
Date: Wed, 12 Jun 2024 12:37:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shutting down of the git-daemon (git protocol, https and ssh
 still remain)
To: Claudius Heine <ch@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>
References: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <323dbb9c-42bd-4664-b660-0ba24c819bec@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: ea65dcde-6d0d-48ee-523e-08dc8acbaf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTF1L1R6dWRqVU9zUXRldXlhRGtmcjZmNm1MRFl6N29jRWRLQUVYY3Q0SGpv?=
 =?utf-8?B?SFN0Z0xYcVB3QktOMTNGc01lYXFrM0JqcHNPbElVd1BjN0dsejIwd0xad0I4?=
 =?utf-8?B?dzRGQ1pnaWZhWTN0ZzJ6OVB3QjVvbys4ODlORDRqems1bzBqK3l1ajU2aDRT?=
 =?utf-8?B?U2N4S25tYVZub1RKRFVPcEVja1p3cUpXdTlWbktqTUgzekNvUUNCblFYT2Uw?=
 =?utf-8?B?QWwxUS83ei9aQ1BCZXQ5c3pDRHFYSk9MUzJ6UUh1cUh0VkpEMk9iUnFtN3Qz?=
 =?utf-8?B?NHRsbDVmSnQ2UndSdStFYjljQS9RYXN3VFZPQjVxNGpDZXVBOUk5VEdJcHht?=
 =?utf-8?B?d05sbGt2WWliWXpGMjQrbVZSRTYrNmhyOU0remJhV0hueEJNNk0zMXlCMExa?=
 =?utf-8?B?OGlBTHNESk56dDJnWWpQb3ZpYjJacWxuaklSSkZjc3loRGdQaVA4MFdHdDRY?=
 =?utf-8?B?MEpodmZKMFVvcGl6ZGxFRjAwdHNEUlZWanFqSXcvRlIwbVVjNVh5cUIxTmM5?=
 =?utf-8?B?akdIalZBaTNVYVVjMmZHMjAxUytNeS82Rk5YS3Yrai9vNG9zUDZvS215dmVC?=
 =?utf-8?B?b1hXcVFBYTJKYndtUzVrUmtXNzZJV3JJN2twWEUvL0xlU3JNNHVBWWd1dFRS?=
 =?utf-8?B?aUpldmFQbnUyOXVsK2JUTGpRejAxd1VHbHBWU21lMVhmUlBRdnRSaU5xZFFV?=
 =?utf-8?B?U1V1V1RRakFXZm1lL3VpNW5BV1Jkai9wYTlKQmczTS9nRXFrZUorZy9yMW9i?=
 =?utf-8?B?VW45WHpQYTc5blpENmdkNzhMcEJ0ajZpNzdQMm9tbGljVnN3ZFBMT3hvc0Vj?=
 =?utf-8?B?aGtUWU5zWEpQeGNJYisybm0vZjFBQWFuMU9nZGVjK0NEaWJpS05wNUFpdGN2?=
 =?utf-8?B?eW9RNmdXZEpwQXVGdS9OcDYzbS8yQmdCdmlhUEY5ejNqM3IxWlQ2OWlUOFht?=
 =?utf-8?B?YmxZYWxWZ2R5RGdjU2RKZ0JIeHFyOWJkZjZCQzFHdHhHK2NQVnR1WC9YQjYw?=
 =?utf-8?B?aG9OT2VzYTZFY0orWXM2NjNUQXRNTE5ZT0wwak5yYjhzRHoza2oyUkdLTHlY?=
 =?utf-8?B?SWkvK0xrWldzN3hKSm81bW9HMnN0Tk9MOHZkQUZkTmNWZCtRcVR4cXRKdDll?=
 =?utf-8?B?SHVJdnZUdkdIcDdtdDlvV3lFNkdCNlVkWlFRMmNKbDhIZnFRbnlFVWFJMmda?=
 =?utf-8?B?MEIrWG9IRk9kek8zeHB6ZlNTS1ExaDhmZndaUVJTOThLdkNOMnRIdDVEU2RK?=
 =?utf-8?B?Y3NkN08rNWh0UU1HL016Z0RKQTJJMUUwdmJUY29vcVU3SVlhZ0E5eWFMblFE?=
 =?utf-8?B?SXlBR05PdEgrN2dEZGpPK2FwSDlOcGp3U1lucFY5S0E1WjFEZFNNVVIvR1BK?=
 =?utf-8?B?dGVIQ0l6M0RIYTl6UXEyTDRqM3hMQ283c3htMDhJcVk4OVprb29Wb05WZ3Nz?=
 =?utf-8?B?UXdnV2hRdkwza1R4REd4WXRyK2t4SU5Uei9Pbk42Qmg5VGF1TDRkajV1QTFU?=
 =?utf-8?B?ZDl6YXU5VCtQYzR2azVkNWtqVkZqS3FNN2g5OFlyTmYwQ1B5L0FabXFZQ2pG?=
 =?utf-8?B?S1Z2SDRNbHdJcC8yT3hmUVJvemRXaml2eEUxOGd3WkZXMFduWXcwWlRQOE5x?=
 =?utf-8?B?RmVEeC83UGZrV3hwRUNmM2VJRi81eGVxNldoZ0k4VnFYblRVbDBHbGYwSTJR?=
 =?utf-8?Q?mcDQh8I/ctBNC/K/WiYA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(1800799016)(366008)(376006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhvRi9YbjRnbzZwY3dPRTRpWEd5b0lvbTRFd09MOU93LzY2cDZSSHBha0pE?=
 =?utf-8?B?UVJIdFNLODNucUlHQlJtbzY2aTl4eXliWThLMVFDUkdvM2NnVFBTSTJLeDJW?=
 =?utf-8?B?aUhvcUhnOVBjMGJFeis1b3ppTXZkZzdub3g2L0lIRmx6bm1zVUZJYXlWODgv?=
 =?utf-8?B?dVBsTkFaenAxVXNtVmZNZEVJQXR6TVE2OFVBUzY5MEh4QzdvM0tWWktJcHNr?=
 =?utf-8?B?ekpUQmxBR1FuZGM0Q3dpRHhYbktocjZJQjh1NTQralJwUFRCSW5SSi9NeS9Z?=
 =?utf-8?B?WHFKWWs0QmhMcmR6UVBnNWVqeFBrN2NmeC9UZDJqUlJMekNFMzdTSTAvbVhL?=
 =?utf-8?B?akpLVzRIazRmNVQ4dnRUUmZaRjkrUU9EdW1EejR4Y0lYc05DSUNWdHpFWFFL?=
 =?utf-8?B?NGUxemlNMmlRc2VZM1doakJtOW95Y2FjNVh6LzJ4UU5VMmlCQTJGTlE4cW9R?=
 =?utf-8?B?RWs4ck5CMkQ1Qk9LM1g5UkFQSk0zdmh0b0RaNXowWlNubFNENFlpcHRROXI2?=
 =?utf-8?B?MVRJMy9SWmtERlZxaWdJVmpsdkJZaW9QcjFrV1RQemVQcXZ4R05xcXY0a0to?=
 =?utf-8?B?dlIxSzRJMW1wc1pLdW5GeEVSNGZiUnQxSW1rVDQxVUc0NThXdW0zMUxTTlNv?=
 =?utf-8?B?c2U0aUR2ajc2M01OeUlyNGJiNWpScG5wRU9MRlJjTXB0Y1p1anJ6R2U4WnlG?=
 =?utf-8?B?WGhxUFJNbzJZRS9xZDR3d2VsOVFVS0dvek9kaUR6QmhWRnJKVXZvblphTmt1?=
 =?utf-8?B?MmR6K3MxbFduaXVwazJEZ3ZXR1BrdEc0WDZxRXlnNE9yNjJHU2tuUnlTcGRF?=
 =?utf-8?B?ajRjTTJVd1NSSXFsc1VZQzdsRnR6Zk9qaTBQL3pRelFSbHQ3bU1wQ2tmWmQ0?=
 =?utf-8?B?U0h6STR6Z0x2ZktVbjNoOEFXYkFoRVl4d0F3bDRXcGZidWE5elB3eGpSV25Z?=
 =?utf-8?B?RXgrNkEzMlVzc0hjWlJqVW0rQVBsUW9oSUNiTVgzaFY1bHpETnFjdG5kZjg1?=
 =?utf-8?B?OXFZaWg5eFVqZ3duSkdHWVRJc3lIK2FLemdXL2h5dW1NQ3N1OXJ3Znp1Y3N6?=
 =?utf-8?B?RDhxVHBIU29sYTNsMnVXQ3ZRdVdZUEdmUk1uNFN1b21ZWTZpSDdjenVtNmNo?=
 =?utf-8?B?NkU3cnplemVXWnBRaXgwcms0M05MYVNBOTlzYXJrVmxzS2xLc0lHSkR6Nys3?=
 =?utf-8?B?VHllajB0OTJtd25CQ3ZMZGpLTVd2c3IxdGg0T01JOWhMcUVibUFPdlFDYmNp?=
 =?utf-8?B?TXd6Y2NtaE5ROGhvOTFlYjRpTnd5RU1qQnJFQlVCZ3FpallZL1p2a2dYS2oy?=
 =?utf-8?B?RGQ2SWtZMStUQXE5NDA0SEM0VjhHZmNVck1wOE5UL2RBRS9jT3lXbWc0R0pz?=
 =?utf-8?B?WU5PK3R0TUxkd29vUTlSS1BCVDBOM3RuMFVKWkw3b2FRRzBSNDk2WlZhT3JO?=
 =?utf-8?B?OEtzOUE2WmVzL29tQUlHVnVWNEpXK1lQQ3pxMyttdDBxZjBuUysxT2Y1cVRp?=
 =?utf-8?B?bDF2bU0wUE5JQTFMZFZBY2tySURjSnBFU3NpZENKVDdvTWdobmxlYkJuSW4v?=
 =?utf-8?B?L0MvUHZuOW1uQ2V4TTR0OWJhN1BXejV2alc5UENvUGd2TmNjV2d2SXBUMWlO?=
 =?utf-8?B?M2Z0RzZ0bzJVdVhCbU5YdlhuV2ZQZGwwcVc4eW91OTFMWmhMcW15SjZwella?=
 =?utf-8?B?T2dyZWl4KzFFVU5PRU16bmNiVWkvc1VtMkdNclN0aEMrN09MUGtqNjdBQ1Vo?=
 =?utf-8?B?bXlpS241UVgxWWxHMXZWTHFzWWE2R21IMm11anlvbGxDYXR6aGN2QjhvZWQx?=
 =?utf-8?B?MmR6QVorR0V2Q2V3UnExMUo0TUxkMW1xMW42YWVOSXc1V1hkQWNrbjYyend6?=
 =?utf-8?B?N3JOcGg0ZitrWEpTVnBVZDZJQWphT0hmWlZuQTlBTnI4a05SMTJzUFgvRXpa?=
 =?utf-8?B?NVdqQkRGd2NLZFRQaFQwUTFiY3NhMERDZGxYYW1GclVXNTJKQ3JZZFcwNVRR?=
 =?utf-8?B?aUgrYzZvdlJDcXFsa3RpOEpXMzJtVFhWVTg3dUcvY2dKaDY5d1c5RDVsYURJ?=
 =?utf-8?B?N2h5Mm02Q0grNHV6dmRJa1dqVGFTbCtHNjZDMWpyd1VNMFpaMjkrTjAvdVVB?=
 =?utf-8?B?Qm1QUjVTTEdKVkZDRHJhV3NneG5uRHhhdU1uM2N2QjBaa2JvU1lrbEt1ZWNY?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ea65dcde-6d0d-48ee-523e-08dc8acbaf14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:37:40.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+iFd5iDX+rgy4/jV5tXtMkqMHwuWI1oZPzZ3PRI/MND4sNcU4nXFw9XThezdH7s3yCrtuIIcYED1eauueG6eE9UEaKtOugIGp5tjCaUYgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
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

Hi Claudius,

On 6/12/24 12:20 PM, Claudius Heine wrote:
> Hi everyone,
> 
> in the past we used cgit, which provided cloning the u-boot repo via 
> http, https, ssh and the git protocol.
> 
> When we migrated to gitlab, which doesn't support the git protocol, we 
> implemented some additional service files to continue to support it for 
> some of our git repositories.
> 
> We just noticed that cloning via the git protocol is currently broken, 
> likely some changes in gitlab happened and we would need to recreate the 
> symlinks on the server to point to the right repositories again.
> 
> Since that is another thing to maintain and keep up, we would like to 
> just shut the git protocol down. AFAIK most projects moved to use https 
> for cloning anyway, since there were not many reports of broken cloning.
> 
> What are your thoughts? Is it worth the effort to keep the git protocol up?
> 

On the side of OpenEmbedded-Core, HTTPS is being used since Langdale 
(4.1) and the first dot release of Kirkstone (4.0.1) so only outdated 
layers would be impacted (provided they aren't already, but since 
there's a download cache system in Yocto, it's possible they're hitting 
their own local cache instead of fetching it from your server(s)).

It's never nice to see things going/breaking compatibility because it 
may break old builds which is always a nice trick up one's sleeve to 
figure out when things started to go wrong in one's image. Also, while I 
checked OE-Core, other third party/community maintained layer could be 
impacted. I assume this is the case of meta-amarula-engicam[1] and 
meta-allwinner-hx[2] for example.

I would suggest sending a mail to the different build systems mailing 
lists, I assume https://lists.openembedded.org/g/openembedded-devel and 
https://lists.yoctoproject.org/g/yocto for the OE-Core/YP side? Either 
to ask for their opinion or notify them (and specifically third party 
layers) it's going away or both.

[1] 
https://github.com/amarula/meta-amarula-engicam/blob/master/recipes-bsp/u-boot/u-boot-common_2018.05.inc
[2] 
https://gitlab.com/dimtass/meta-allwinner-hx/blob/master/recipes-bsp/u-boot/u-boot-common.inc

Cheers,
Quentin
