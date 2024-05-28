Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067C8C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE448844D;
	Tue, 28 May 2024 11:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCCOF07K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B378844E; Tue, 28 May 2024 11:41:47 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68538843D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDSKmbFgta/L8AMVqnaPPryN4yaSjV8pqVd3Pnh6T5UznAkWhBQPw9B5pidRnxvSFKjPpveLz5sSW2qzECBTKCrQl8/NmBmdnoCTJX7JoZqFkU8NIRUdnACR8jCjGHy7JgpCy632p5RVXjEogKK59rjCObe+MH2A12pGbloMJDcDxEPiT4koSDauSlXGPsb4jh2wgm4Ud2up6oY9Vq/pU7KdOErwmblgD0iKuABKZxsJsTlW+OWAJmnRCDl7N5+x+CTZid2t5gZv8Ez5fWED6gHpOPVK/ucvyRrT8BeuVGT5E2ys9GJXNTokLjwBEztjYkKd8hdyt5e6Fzn8kSv6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPxL+vrkTo2YLy03sUGCEb7DvCfRZxwiCPVSLeEqj5k=;
 b=KvlSvMoXR/Ogm2ja6yp0c8eB5wnWIcR4CIa6JBmW4WAEmB6bC8HYeia+0+/xQbOp0IBM6wmo9ADK8C/16BseOzNnXNqDQUy7HpPo2yV1heinYUBjbMjZjBKv9hTlgH1wbu6xbGqTcUPAO+IZzyAsAyMFlhbVv3hzqzyMkc5PtePRW3RVVmSsks8BVmCll7Ua0wCMaPv4QlBQFhmbsiu4cOlY6I12+JfjrfMzmIFerGJm6Xb9EtkKuOkjB3Qotk+dCORHDA43aqbq32NBztIfSeXog91ddPMGQlem04bOCg9HYKDTVwg8yRp0UBqw8uXWRWHf5F/RWnBbwlRBZtDX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPxL+vrkTo2YLy03sUGCEb7DvCfRZxwiCPVSLeEqj5k=;
 b=iCCOF07K2ge43KJRwYDSA8360xmJLIZiOmkyZYw+pgiNk9f3ZDdBK/gsNLZJkKL0boAe5iQmSQTIxFkVD4SEXQJl3FYR8o5YOJnER9rrtdcgv4aRa8NC59hZ7EsxkmSqojOZ64ERaM5j7DhrlIhJqHWRnzdZq+lxSwiC6rSOul0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 09:41:40 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::f1f4:ef3a:f565:c5a5]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::f1f4:ef3a:f565:c5a5%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:41:40 +0000
Message-ID: <272ae10a-7ea0-4a0a-bdbf-35ce12285ff3@amd.com>
Date: Tue, 28 May 2024 15:11:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] test/py: net: add _lwip variants of dhcp, ping
 and tftpboot tests
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <9acc7630e5768ab9af673981a78ffb84b47aa62e.1716566960.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To SA0PR12MB4461.namprd12.prod.outlook.com
 (2603:10b6:806:9c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: d605753d-d846-47eb-3809-08dc7efa601d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFpSGhqQ2drdEg3TlBoYVpjS2dSMGdTWE9tRzlqQlFzR3JUczRoU1pic1J6?=
 =?utf-8?B?T01ld3VqRUF0VCs1eGpxM0VaZFdqS0FHVmdGY2tpNEFzTzE3djlCRTRWcmVD?=
 =?utf-8?B?b1hvNFFvVVFjWFprZytSUkFBT1lHUTBOcFg5b0dQeUhjR3lYWXV6dTFTVnlJ?=
 =?utf-8?B?Ujg4ekxtUkRxaVY3c21vaktYdEZlRjdIUWZHUHV6WU1Dd1QvWUZOWjgzbGdH?=
 =?utf-8?B?c2RZWVBUd0J3d0VuR0Z5TS9RRHZJWW5yYnZGUlZtSzdWTFl6bVlIWmR0Y2d5?=
 =?utf-8?B?cFN0Sm5wa3p4cTJEL0dzcXFPQlBvZ0ErZUVyU1J0OEUxSWhTeEJVaXluUVpv?=
 =?utf-8?B?TnVFelFjV1ArS0I3VGZJaGZIK1ZPZ0craTNaSXo0Sy9qQ0h4SDJUTWNFQmNY?=
 =?utf-8?B?Mm1BRXYrVHRuWjZKQVNrNzE3akZJYXFPQTdxVk5LUjhpMnR5Qm1xUTZENHI4?=
 =?utf-8?B?d2hFYXFMOTFqeWRWczRpYlU3Z3EzUVVzNjBrNi9JakM3b1FQNFFicE1paWRT?=
 =?utf-8?B?YVNDbjZ3bDVkaklmbG9GOTNYOEsyL1pWQk4yS0djcGVRWGgzTHp5TTNRek5j?=
 =?utf-8?B?YWoxK0o5dFFBTklZN2ozT2pzaDNRYzcyZnlRcFpoRVgrU05DcjhXdnJWWml4?=
 =?utf-8?B?WThtZDBpbzg3UldBYnppMGVhNHpodU9PNjFqS3VuUmg5ZFFoS2tGcFYrbnJE?=
 =?utf-8?B?VmhxcW5DRGVYeGR6NmNlSnVIT21ZaGpYQzNOS1ovREFaOTBJdXJLNTdiSnNa?=
 =?utf-8?B?TjNRR0N1MlRQTG9XMDlDNjRJczF2YWkvVENTMmZjSnhlOER6REEzNUtzbVQ2?=
 =?utf-8?B?ck92K0huTm5qaGxIbDNCVXBkWEhuOFdzYjNLdGJ0Y1hObndWdCtYS2luaUty?=
 =?utf-8?B?U2NlZ0xCLzVpVk1SS1paMEdqb001SWlvYkVyNkdwanZabjdlQUhtQ0tLeGlT?=
 =?utf-8?B?TkRUei9EQTJKalc1dllXalo0eklYdENralFBeTE5QlVuRnhGZVRGZzV3RXVE?=
 =?utf-8?B?OGwyTCtYUzlBdnpYSlFnWDBGYWhOaUtTUEwvSXJ5MitHc1lJcldGZ3Y2aVV6?=
 =?utf-8?B?S0dCaFRRUEF2OUdWOWw4dGY4bjZKVEtwOXRSM3QybGc1QUxKaU9tVG1qeWhS?=
 =?utf-8?B?ZngyV0d0WUhjY3lMeko5OW05TE4zZEJSVStyai9ORVpYZFA1ZS85RnRQblZa?=
 =?utf-8?B?em51OVVsNUs0b1NDSGtocytXNUdIUUFPVDdJVmxGKzNKWFk1Q3orVzRvclFW?=
 =?utf-8?B?NGNJOFQ1Vk9PVEpYOXhaMkJrSmxBWDV4TFp4YzZQMjBsVmdBVnViUkJvNXZw?=
 =?utf-8?B?UExqM245VWxhbW9CNGU1M0p0eDV6L2FCempRK205d3BBa3dVR2dXaER4SERt?=
 =?utf-8?B?cFVvanhaTGxXR1hSaTlhdTVqV3VHK0JwQ3pDajNCSjVwK2Y4QjJvY1hxNU1R?=
 =?utf-8?B?cGo1dDkrdGN6cDNITFRlTFhURU15OEZCTzh3NXUrTG1LMkRiQjFWclFxU2xy?=
 =?utf-8?B?UzBxMkVOa0dJdWkzZzJtSG1ncmRRd0IwckJXMXlXUkh6bjRhVnRVdXBocTA1?=
 =?utf-8?B?Ly9WNStidTZFNDRNSytRY01IUGdzYzQreVBtcGdXclF5S25CQ08wclhEQ1Jn?=
 =?utf-8?B?TWxQTGNvazZIMmFwU3FnNElsREIrOWVERjBGdlY3dVNkQ3BiNHlJcHllT3dy?=
 =?utf-8?B?QWh1MmdmMW9ENG5mRDRlbDE4cDdMWDJLdVNMMllGZlFGQ3A0NVAyaVhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB5cXBtSmxjdGlIRnlvVzVrVXFuWW9mZ0JKalVSK3hiakZkWlE1ZXhZanBx?=
 =?utf-8?B?QVJZdHhHT05JVnhDbG12bk1rQ1pJdmJFVnVQVFlUZE9kcVlUZ0NuSjRva2V6?=
 =?utf-8?B?WjF6Q0RoU3pCNVhzRVJIbXp4QXBzVkhzS0JDWEsyWE1sYldrczVTT0t5K1BS?=
 =?utf-8?B?a2xTWVBwVXhFRUpDNVlEa3ROdm43ZzJjN1luMXZvQ0U1Qzh0YnA2R1FKVWFD?=
 =?utf-8?B?Sk1vWEJoMUdiZ2RWaGMwQlVRNlptclQySkFYNGxhSk9JVlV0bm90cjlxOEhK?=
 =?utf-8?B?N1A4L0kzWWtZUFgrK04vUElsSTFNSzEzNHpwMUZBL0FVaEZJd3EvWE8rMHU1?=
 =?utf-8?B?NkdOS2w0MmVzSWUwWkpwMXpnTmN4YzhxdDlkWCtqaEZYcjl1ZU1EWVdrSG5V?=
 =?utf-8?B?SHNJUjJSV3ZLY1haOEdORDFadEd4UEVONmhCRVVyempaL0NEVTd2Z0U0b0tx?=
 =?utf-8?B?NktoQWZOOVY0UndxVldyajFPNGxSVElnRi9zRzdMSmtpbS9pZ1dJZG9tZmdS?=
 =?utf-8?B?R1RQQjQwWkYwRFhPa1lRZUFLK2hLVUxnSHF4WXE3QWRlNFo3QnVCQmI4RStB?=
 =?utf-8?B?d2oyRGJsOHk0TGJGRTV2L09SbHhOdjRQeWZQa2w2SFBKai9qdk1nVUpQbnNT?=
 =?utf-8?B?L2VQc1NPWVFhVFpnNFpqak1KQ1RFays4VUxNOGx0bk1zUTJkK3RSN0hoVHRP?=
 =?utf-8?B?SnNFRFV0aGxRanVkNzBMMWwwNUk2eWx4M2lKWjNVbE5zbExidTFvOEIwczd1?=
 =?utf-8?B?WFBJZDBSV2UydCtHczNMTzQrUGtFbjdHbWhKQXp4UHhMYk5aNllnOXIrdzBt?=
 =?utf-8?B?bUgzTVFNS0xjaDRuanFqUjF6NUFVSjNNUkZySXd6MWRxMS9rVXJlWlluNnp1?=
 =?utf-8?B?TkovdW1Ib2EveHFWTStTZ1dsVXZ3cUo2c3JBSmJtTkJESy9weEduYTdzVmNZ?=
 =?utf-8?B?aklpQmcvdTMwa1JkRE9nM0Z5YXpudmxyT0FQNXd1cldqK2RrbVZZWTBSTDdD?=
 =?utf-8?B?S2pZSFFWZlAvem4xeFl0WXc5NWtrNW5tNFlzcTY1YWZWWXpvbitpYk5Nb0RD?=
 =?utf-8?B?L2E3THlyWDZITENLWDlkTGtleXZma2VZb3VZUm1RMzE0Y21wcldlZ2NnL0Ir?=
 =?utf-8?B?NlFqOGdrMW5laWhVcGYxWnNHZEkrVkxOT0d1UUlJSStHVHc0cHJCZWpVbG1O?=
 =?utf-8?B?Q2wyeVFKZ2hRL3o3b0dUNEl3L3VxejFZQnphVnBiSEo5Ly93V3Q4b2J6Wncv?=
 =?utf-8?B?K3NQVkxmUUhVMTBmMm1GaDl1TXgvZXdyMDRnTjUvT05aLy9HblBmS25FaXMx?=
 =?utf-8?B?WEdBdTZwS0haVlB0U0FSd1BxQkI2Tk9ER2piWFVveWw0SVN5cm96Sk1CTlRL?=
 =?utf-8?B?UDliWjY2QkYvOVlXZHk2M3BZbnlkWGV5RkQwdDRWNGJOMHB0R01jVVpDd2o5?=
 =?utf-8?B?TkFWV1RnMDJ2WGRoaWROV3kvU0o1a3Q0VzZGY292UERKTHhQZk0vWFZPTFA3?=
 =?utf-8?B?WGQ1eVdTU2FTSnNyalJXeTNheFZYckhQODZwd0RUN2czc2QzNWRxT3B6RWNW?=
 =?utf-8?B?RTlFZ3NoVDZQRWhJSXVGN09TM3F2dXBvdTY4ejJFNlk0bVd3LzhtdVFUVTNT?=
 =?utf-8?B?MjcweVRrU0tRMThETVI3Zkw4UWd2OHZyd0VMVXhGV0swT1dwN0IzTWRuSzhO?=
 =?utf-8?B?SnVxeTV1cytONzhuUys1SlJTckZNRlZoOGVQMGN6eHFBVHlYNFJ1Sm1tdjRF?=
 =?utf-8?B?NmxNOU9qYU9tcWExTXZrcU9wNWdNVHd1MDJQNHpXVUVOcmlHR1h3Q1JkQ2J4?=
 =?utf-8?B?T0FzY2Q5SjI0aG0ybUhON2ZGVVZBcWdLaVhuZ0RWU2R0RzVHY0hGSmJDaW80?=
 =?utf-8?B?anRqOGxNWDM5dyt0OHRYQ1NWa1BiNVA0UWhOY29VMW5Yekkza0p1QnpaNTZ4?=
 =?utf-8?B?ZERsQnFZNk1nY2hlWWtEMXNqL0pjODJXdldSdEVTTzA5UVN0N3MzbEgycFIv?=
 =?utf-8?B?U2tmVnBwZTBNOC9sTm02aTdtRVV2dnNuVzAvTkl0N1NZaUpTdUtzMVhwQWF4?=
 =?utf-8?B?KzZKNi93ZVNRaDgvVkxVRjBaVzFPUUVYSUl3UWxJMXZueUt4b2R0U3F1SU53?=
 =?utf-8?Q?LRUM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d605753d-d846-47eb-3809-08dc7efa601d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:41:40.2439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6VFMILfso0V04/7by3xucEX0SKNFxzE9BRZwzyOMtAwpXv23QDgxpQXqPNkukVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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



On 24/05/24 9:50 pm, Jerome Forissier wrote:
> WHen NET_LWIP is enabled, the dhcp/ping/tftpboot commands are enabled
> via CMD_DHCP_LWIP, CMD_PING_LWIP and CMD_TFTPBOOT_LWIP, respectively;
> therefore the config annotations in the Python test scripts need to be
> cmd_dhcp_lwip, cmd_ping_lwip and cmd_tftpboot_lwip.
> 
> The console output of the tftpboot command with lwIP is slightly
> different from the non-lwIP implementation. This is taken care of in
> test_net_tftpboot().
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   test/py/tests/test_net.py | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
> index 038a473b239..ba30780903f 100644
> --- a/test/py/tests/test_net.py
> +++ b/test/py/tests/test_net.py
> @@ -127,6 +127,10 @@ def test_net_dhcp(u_boot_console):
>       global net_set_up
>       net_set_up = True
>   
> +@pytest.mark.buildconfigspec('cmd_dhcp_lwip')
> +def test_net_dhcp_lwip(u_boot_console):
> +    test_net_dhcp(u_boot_console)
> +
>   @pytest.mark.buildconfigspec('cmd_dhcp')
>   @pytest.mark.buildconfigspec('cmd_mii')
>   def test_net_dhcp_abort(u_boot_console):
> @@ -230,6 +234,10 @@ def test_net_ping(u_boot_console):
>       output = u_boot_console.run_command('ping $serverip')
>       assert 'is alive' in output
>   
> +@pytest.mark.buildconfigspec('cmd_ping_lwip')
> +def test_net_ping_lwip(u_boot_console):
> +    test_net_ping(u_boot_console)
> +
>   @pytest.mark.buildconfigspec('IPV6_ROUTER_DISCOVERY')
>   def test_net_network_discovery(u_boot_console):
>       """Test the network discovery feature of IPv6.
> @@ -255,7 +263,7 @@ def test_net_network_discovery(u_boot_console):
>       assert '0000:0000:0000:0000:0000:0000:0000:0000' not in output
>   
>   @pytest.mark.buildconfigspec('cmd_net')
> -def test_net_tftpboot(u_boot_console):
> +def test_net_tftpboot(u_boot_console, lwip = False):
>       """Test the tftpboot command.
>   
>       A file is downloaded from the TFTP server, its size and optionally its
> @@ -279,10 +287,11 @@ def test_net_tftpboot(u_boot_console):
>           output = u_boot_console.run_command('tftpboot %s' % (fn))
>       else:
>           output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
> -    expected_text = 'Bytes transferred = '
>       sz = f.get('size', None)
> -    if sz:
> -        expected_text += '%d' % sz
> +    if lwip:
> +        expected_text = f'{sz} bytes transferred'
> +    else:
> +        expected_text = f'Bytes transferred = {sz}'
>       assert expected_text in output
>   
>       expected_crc = f.get('crc32', None)
> @@ -295,6 +304,10 @@ def test_net_tftpboot(u_boot_console):
>       output = u_boot_console.run_command('crc32 $fileaddr $filesize')
>       assert expected_crc in output
>   
> +@pytest.mark.buildconfigspec("cmd_net_lwip")
> +def test_net_tftpboot_lwip(u_boot_console):
> +    test_net_tftpboot(u_boot_console, True)
> +
>   @pytest.mark.buildconfigspec('cmd_nfs')
>   def test_net_nfs(u_boot_console):
>       """Test the nfs command.

Reviewed-by: Love Kumar <love.kumar@amd.com>
