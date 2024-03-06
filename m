Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E5C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3D487776;
	Wed,  6 Mar 2024 17:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="cyvQpZhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A4B87666; Wed,  6 Mar 2024 17:57:34 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C707E87D9D
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE0a6Yr30oU9QN3Uv0TPp0Z/mNJeENmV9mrhAODrsYTLknSw/6fZDY1p+te/iNDGFmOdzAXfqsV/bRHJaLybfIf5JluOXU5gJ6sGB8bGH6teGTunBqYQS2WxxptON6uFIZ2jrOpcCNNASTwQHXypsxM3nWPqn11GrwrK92E9Wk2y/HgYln3v49t94N7ZGnVZZVa5nqZZFaKxyaJXK0iIBUAu3XcUYtk2t8gF8I6camf6pZJoMHdUYKuqV2S9TyqaLkMuZkPadTLIAJmyUiT4OqIrz3aZ0lydrmdaJ+ZIyNgfKLnIkMn0Ez2FdTWuCdIstuVo71fT2xANTaCfq9/O5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpPTL6uqvhr2MDnMZAkDkfCiMVzqciBgfaiUE4kkGmM=;
 b=MKYvGrP2uB7JuQ69XveIdHueAOgByGApxm88M4kGWUJ4rfaqPu8lLX63Aodfkgh9uE76X1MgJub87tyWGpFSrc3GcDdsWEOUXWqE3kkydmqa2RzZn6BN8RBYWC9sLeXoAjmLJ5fISvdxBH8Hw3TBak5GfR2u6qNWGClgL84l1aUP+X7a7wmn7DMIMUyRyYPgCI6SZE85oyebRKyCtzljkWAPFkfV6XaeJJxLsexeuGSCXmAkzQtBJp1Ki2Y6UD/RVW3bgXt3zBNNaOwOQtj0x4zlcu+y3lk/tY0HBbGowosxF9Ly3GJ8RXjIXZtve2KwWn5VVPZbUNDyDBSxXWwR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpPTL6uqvhr2MDnMZAkDkfCiMVzqciBgfaiUE4kkGmM=;
 b=cyvQpZhLfpMvBFwYuRAX7y2M0DHnBLsz0SOIc/BRY6h3vm1yXQbTwHBkO3UMXnlOoKjNcxVRuUfxsvtMNk44BmT8xDstJIMM1TPhbSr/GzzsT4n493xcQaDoXRFFrO83aUfwL4zsmRV8sZBJ7T5nQae33M195zVIvxp9WMtibGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB3PR10MB6788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:438::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 16:57:28 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cad:3fbb:8707:8ca5]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cad:3fbb:8707:8ca5%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:57:28 +0000
Message-ID: <c964f840-52fb-40da-9fe7-3f2a31573c00@kontron.de>
Date: Wed, 6 Mar 2024 17:57:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spinand: Add support for XTX SPI NAND
Content-Language: en-US, de-DE
To: Bruce Sun <bruce_suen@163.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
 Jagan Teki <jagan@amarulasolutions.com>, bruce.sun@xtxtech.com
References: <b5939776-5f40-4795-9c2d-e96c7e51cc1e@163.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b5939776-5f40-4795-9c2d-e96c7e51cc1e@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: f7589443-922d-49af-eb36-08dc3dfe815e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhB1f60QaxjB/ljRLQ1J/hMNWU857K4F0mpkhQN6mZQkAGwJsjddcZtTF5QqY0rt97r7dVepeD+dQ2G5/gfVsMuSY/+nDfcPLyGj5RXhOFm0YonIeVHionqLx20uA6c7PW3SosoVdqQHx4wQ4UDZlSih8u9zyQM5WUVCeAw/iD5l3ArlApgjISvHW+CLdkOOJFHrunG9JS4BiJMMlk4gce9Jqi4m2ICFWBpwCIRqpMZsvw4AJpheolXTpYr+K4fYWP0FW3gvzWxsSqsP8AP6e2h4Js0nUDIucPJINahJtTYOFuUVDO8rpDW4kNVwYlMIDU7AYocFpoHVCO84g7Mq899c4RpIhzYEtam0xwt/QIc22cQ6hJhq9JiFxlh/34sXWAGYgBDsta8P+E9Vl9ejaOGDUgOWfFHTmWaqjPR7jMqbDYmExvZ1qNHt+VaPabCG6JRPJ5J6YX125BaPAPMXXAIX304QsiXK9yTMBHumK5jg7Flvmbo1Un7kLkauod9xbm7b4DJQIOxKKeIVH7jeIuxs1g3avUbQkvbkDPT5Faoqc/ltbclhAtlJYAALhNV/CZAg+IWYOSraU29BTvm0g4suLkY1TyeMqA6/SjCsb1KSe+dWqo/E+8C16SYAvP3s5Imtu3QqD7PM1LRbfoInd7vGCmIiRYbmXWxR5aAeeeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNGNFJjeXhuR2sxaHI4YzVGQ2kxejVoUEFKelF0YS9GdEhiKzZ2c3R3blpT?=
 =?utf-8?B?R1M5S0thN1N0U3d3NkxpZVNYUXVuYXN5QktJT2tSc0VrM1phMUFCcnJtczk0?=
 =?utf-8?B?QUlJU1JPMTY0WnB6QUsxK0kveWUrMExvVXlKTUx6T3V0eVlSZkc1M0RvZ0lt?=
 =?utf-8?B?Y1I4YjlONXd1T1RRazluT0IwT0wwSGI5bWNkb0JhRXZFdExya1hKeHkyNTUr?=
 =?utf-8?B?a0Fxb2JqN0NxUmFsUDhvalZHMElQZTI4UGdSRGx0N2FqbWIyb1M5RXdRY1dJ?=
 =?utf-8?B?b3diSm5pSk1WNE1GNVlSSjhxREt6SmRaMy91aWxEMW9qazgwM0l4ZHFCc3BG?=
 =?utf-8?B?RndrRTNvTFNIbzNUVlBHVzlja3pZM096Z3k1Y1RCc1hGR2luc2FHckluZlJ6?=
 =?utf-8?B?bERFWk5VVVo5aVM2VVNkMGJBQVVTQTVIUmpMMHFXMEtTS1ZFMkRWN2JieFRz?=
 =?utf-8?B?YUVmdkREVjFMeEhLQmk1RnM3SEdjNDR3UDJQc1BMZ2tlcmpPcENqL0l1Qkl2?=
 =?utf-8?B?a1lwWnVuaXhoaHVrN1BGVk5kTDBCRGk4SVZEdXdUMXFGRmg2WWI5Rk1NZFJ6?=
 =?utf-8?B?RUxLaFE2UEFaMVlFZzU2RTg1TEFYVkMzKzRUSCtrR0VGQXUvRXRMdzRBY2ky?=
 =?utf-8?B?YXFOZG9UcGJNQVNNdlJpMElaTE1CQXQwMEVDeXl3NExFa0JJbHNjZXZOS0t2?=
 =?utf-8?B?ZEwwWGJsdGpjQkZCSDJiNldjdFBTNVV6TSs5aUIzZXVjMjhFUUV2QjlXdmRl?=
 =?utf-8?B?czlXeVpwa3RWOUNqVFN2OU1OSjNWUm1HQnlNQkxNNW0vLy9vbnc2ZzQwcGsw?=
 =?utf-8?B?L2JnWTN0elBwMjNyZHVoRVg5bUVHNFNEeTNKSFpPT1d6Z3M4WnBBcVdyWnlO?=
 =?utf-8?B?bXpMeUdWeUllV3M2emw2UWFjV1Vub3YwTGtSSWh0VlNNY1NhdFhad0labWtq?=
 =?utf-8?B?UytXVXpUd1JvWjBQcWhOMzlKK212M01PeW5KMkhZcHl5c01CZGNWbWd0K3pR?=
 =?utf-8?B?SWJVK29HeUkyN2V3NHhoOWYyc0xzR1BKeFE4SXlSU3FQdEM4d1FySlRsV0tE?=
 =?utf-8?B?M0x4N0RlNW45M3JtdWNUUzZhRjBnYk43MUlhZ1RtR25OaFl6alRPbHdRSndY?=
 =?utf-8?B?VEVNNit4SHhQMHZBMDczaDFGZ3Z4R3BXVnJzMC9iaWwzbUFVNFJhUThFdHRE?=
 =?utf-8?B?ZDV5UmUvNzduRi80WENnMkw1ekM5UThjdGgvbkNKWkhiYlB0V0p5Y0QwaDRx?=
 =?utf-8?B?QnRHL1NjOXlteXFxUndUVndLRFk4OHdqaVV2R1BhT2FUZUFFaTU1alRWZ1pG?=
 =?utf-8?B?RWxTREg5U1NOWGlrK09QWWltSW10eEZmWUlRRXdvL1pUQ1lkaGdEck9BQ0lO?=
 =?utf-8?B?My9iZHdkNi90aElTbGc5WDRQN1Q2cE9FTlc5bGdQNHZZcUdzVVFNUFFMQ3pm?=
 =?utf-8?B?OVBCOTJJM1ZVQ201YkpLcWNBSmJaMmdkZENaRjRGR2VvNjJXNjk5M2hZd0FG?=
 =?utf-8?B?Yy9CUERuZFhEcXdBSXpkWTVpRzVybUJNREY5NzJ4SVZXSHl5eG1FWnRMdXRW?=
 =?utf-8?B?RWN1QVBQc1htYkJEK08zdi9ZMXRySFB6dnJueGkzRGZ6S2lwNE9BamxlV25w?=
 =?utf-8?B?c1A0SERmTFJBbzhOS2ZIQUIveksvZ2w5VG1kdVkyQ1pNSHBvMHdjaVlUWm00?=
 =?utf-8?B?bUJtbHVoRm5ZemVoRnFUczMydEk0aXVzNDR0elFUZ0pCdTQrZWZtVkNiK2xh?=
 =?utf-8?B?SmpvOEU5QzM3NXBPWEl5d3FKc2xYL2ZkRkxtWnU3UkVOMXpCdm1STW9hUlhC?=
 =?utf-8?B?bDQyNG13M2gvM3Y5N3JMMmtub0xjYi9OVHpHVW9JRlQyVy84T0ZvL3NyOWR6?=
 =?utf-8?B?bzY3dVd4OVlLRzF1M2E4TXdJMnMyZlV4NEg4MEhGc1JyK0JVZ0Y2eHJwaW1i?=
 =?utf-8?B?bUJ2alB0WG1UYm9heWxaZDZMbmxXVnMxQVNYNEJ4Y3RCMjRPNFVjak80VGdS?=
 =?utf-8?B?dk5LR2hJVEpjUnlaZmVhNTV2ZEhLeXFpc051SzNaRWhLYUQ3eS9pcGRKQzla?=
 =?utf-8?B?WVd5dUJzblVXTEJ1MitOYkNzMURJUlhVMVdMZ21jbW1YSlI1K2pmVmtyOHNP?=
 =?utf-8?B?T1gxRTU3REZRRkQ0bTNyVDdXRDQ3d3d3TnZ1MUVYVDRjVlZrNzdRYURQQTNG?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f7589443-922d-49af-eb36-08dc3dfe815e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:57:28.2538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fpmc+JCFoAg/5OxyCX85rXjDyLWf8cNRFGbE/z4GQJSlicBYR7XSLQCm5okT6qg99B5icfadhR6aE3W3bLlHaxFd4xwxajDnONdrL6SxOfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6788
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

Hi Bruce,

On 01.03.24 09:01, Bruce Sun wrote:
> Add support for XTX XT26G0xA and XT26xxxD,the driver is ported from
> linux-6.7.1.

This patch is missing your Signed-off-by tag. And it seems to be
formatted incorrectly. At least I can't apply it to master or nand-next.

How do you create the patch? Can you please make sure to use 'git
format-patch' and/or 'git send-email' properly?

And also please use scripts/checkpatch.pl on your patch before sending it.

Thanks
Frieder
