Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D470DC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445108811C;
	Tue, 21 May 2024 11:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fvEpSH7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D700C88069; Tue, 21 May 2024 11:27:44 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98D58811C
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 11:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbpQH/2sB2MKnJ76vJF9yxVVX6ONWTEHOILUO/GRLCWq7P069hpp8Dq8W/ad0ceT71Jy1/REtMeq9sMfgmu8JdT0JWmMxjqWjOXHTODu3SSSyPfRWlO21ehWJHjCL9vTFcWYI/4Nj6xXdt4UkcL7bwldRw/gHLyLDFaklqyuCXZ1Tu8SECidlcGtsrTvFK8Fa/SJvSffYxEieuBrIzA+npe6UWKXb8w0ZT+dL71WiJSEF6XBOfdDHF4/HaGtBMIYE7zvr1E03eitXnXiyjpVOWihLDxP+Kpe7A67CbQEvyTx2zbuNW8H3UNihn46Dpnos0Sm7luJN+9vwzQPdrEadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8aBuD3GsnwOJgyKqnE8Lh8aMC7nbUlWsW1uUc86GHE=;
 b=fZ6t3ANfmU+IPt1GPXkvL/dx4Nap9cHgNBR7JtDjVIGBUVK1Ueld6tHXNkxTjDUyXdR2/zP1gSDPkfq6j5FtYsw+Re9MzyhdvtuK4bMYUdG38+qtQ+Cu2uWWurOt0txgQBVC2oBIIBvQXhCZzsNrfLmcIh6mAt6Sg5GJXHowAwo0bFtt5k30hYVpSud75kP8v8bb+KdbRDCSbleFALagaZOqxD6X2Xqapt00c8R7RYuYAhenj/v03uSjz/fJnq2ePFlYtQdUaau4xbRHaDPgFpYICrT3WdMQYq54GFXzVMpDJ8xeMytZnmmTjFClY9A2dyfbG2Fv6PFHgKwmOksirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8aBuD3GsnwOJgyKqnE8Lh8aMC7nbUlWsW1uUc86GHE=;
 b=fvEpSH7M4bUFS9ROTISjaSTij+BhNkZF4hQclaD2BkWyr+sed9Gn2Gk2cNjDBMsKtoxb/MGuIN/7Qi3jZEWc/XIMlO3w67EcxcgzZ+eraTVGw2F2nq6NKtWLDvLA6ZQvG71sU8LCJL+6s8P+yLBwdpo3agBncrp6Q4SWbKmXfqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB9892.eurprd04.prod.outlook.com (2603:10a6:10:4ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 09:27:39 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:27:38 +0000
Message-ID: <faf64499-9203-4941-98aa-82e6e529c987@cherry.de>
Date: Tue, 21 May 2024 11:27:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] doc: process.rst: Document device tree resync rules
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240517174930.1028063-1-trini@konsulko.com>
 <20240517174930.1028063-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240517174930.1028063-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f054363-d0d3-456e-4a8b-08dc797841b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmxVNzI4enFpZjNVd3hrb2RRSVEwWkREdDFnVjFnT0FpNlZMQTloeFpUaklJ?=
 =?utf-8?B?dXQ0RFBlVUFmaEpmUzJrUkUrUG9Ec2FnNWxJN01KK3BvMUo0dHdZOTVuaWNM?=
 =?utf-8?B?ZUhpUUNUYStCZ2wvVHJwa1Q2MEN0U00renY5WE5lWXBuZmgwaHZKWHYvU2FY?=
 =?utf-8?B?N0dvL1V2bWllcnN6ak1YZ2Q4VXNpTzkvYU95a1JuU1poYUdPK1lLK2pZa3lv?=
 =?utf-8?B?cnpPcm5FR2JnVHk0MS90ampLZ2pRaFBKWEJCa2hrYy9TVHhNelptL2VsZzZk?=
 =?utf-8?B?aEhMTkFCZjdIb0VCNlIvRCtQT3EvdnFCQSsyVmZvRldiOGVmUGpPb2pYNHdm?=
 =?utf-8?B?MDBTem1tSU4wNmpsaU1MdDQ0MlR5eERNcXJXazJNcnlLZFNFWUdJYVpxV21v?=
 =?utf-8?B?R0YrdmdtYkdCakZQRHdIR0pvRkg1SGJPNUFrcktteHQwK3I5RzN6Z0tNMzNi?=
 =?utf-8?B?SXQ1dDAvZ2FXN3pFVXcxcXlreG1JNTA1WE1vbmM0dmFlYVNtTEtGWFdrTFNo?=
 =?utf-8?B?emdxcG5VeU5MNzRqQ1lDOHVvN3I4bitKM29mK3JXdzFrRm02cEdDcDNackdR?=
 =?utf-8?B?ZWc4ZWkxZDVpYzhCNXpnRHlDdWtEVWZOZDRTdWppS2EyNGFjZFREUG5CWkM5?=
 =?utf-8?B?WlQ5TnR2M1k1NkhLQmt2T0Q4T3RWYkpRUGpGSGZoNUowRHBhSmo0ajcrSkc3?=
 =?utf-8?B?RVhLT0hwREl4VUljcVc2UUZ3VGo3b0t1c3N5eXZrYy9oT1pVcWUzWTdja3VP?=
 =?utf-8?B?cm9oSEVtSEljOUhWcHRQYVNERXJNamJ0ZEw1UmNzajM5enB1ZzdhWnp2c3BF?=
 =?utf-8?B?czlHd1lzcVR3TlRBYVM0QjFNTUdWNkFUUGZtL3cwQTFqTEJHYjRRUVNVQVZN?=
 =?utf-8?B?M1dzMmhEM25vMGhlRng0VEpNcm5hRVJhMlZqQTNjV09PV3ViUWdJdERjTXRa?=
 =?utf-8?B?dGU1OUF5UURMLzZUdnYrbWxURnFYTEs3UmNIVE03N0xpSHFUYmdxNjhYMEhh?=
 =?utf-8?B?RG52OFJQTDZwRkl5N0E2bzNZdmdEcDFsRnNPRDA2cHZvY3NITFhpRVFZZ0hW?=
 =?utf-8?B?YnpTbHdXNkV6TWJYeE1mRzNOVk9lN0NKTVd6NGtJMis3RmVtSVRhUXNFS25i?=
 =?utf-8?B?Mk9KUW1lbW1mcTduRXk1L3pSZzJ5aUVGeHpuaEtZdUZVckFwWHl2SVpnbm5K?=
 =?utf-8?B?S3kzTWk0bXI3RXM4bUdrS2NLdWRvckxQNVpIZkpwMnk2RTErb3FFU0ZxMm94?=
 =?utf-8?B?Vmt0S051Vk13bVpySUVjbkRRYm1WZmZ2NUpDR01VUVRkVjVudWdLSUtRMEs3?=
 =?utf-8?B?Qkw5RHNQZDRWelJNQ2JMdzNJeTJaay96Skc0REJ3bHVPOWN0NVFEYTA1NDQ4?=
 =?utf-8?B?S0M3MWUyTTJzZ3ZNc2J3dU9henVLUGh0M1ZwWnNoVWFxcVFoWmluSzhLZmRk?=
 =?utf-8?B?WkdEdElWektnb3J3Z2FKK2JVMXk0ZkxOOVo2amhTQWZNUlA4a2hXQ1lwRjN5?=
 =?utf-8?B?KzEyV3Npb3ZJc24zZ1gzNTlTL0ozek5PVWRjWWhRODJFNkl4MzRlOHpsOWhT?=
 =?utf-8?B?SUwzRWtJVUQ3LzJRczdtZEZlRzUxVm1PclE1U0pXaWtESUU5eGNwL1IyZWVo?=
 =?utf-8?B?OVQ1QUZEZkFGNVhsZUNvdlZHRDVPa21hNEw5QU43NjBZay80WndmcVNjTTdJ?=
 =?utf-8?B?VWFwRkVKOWdjSEJsWCtkeERwTm14N3Zybkw1WFFxV0MyQ0h3dXVFSXVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBCMXF6TVlzUDQwcDN2MWxiMDF4bHVialpBRVUxSHdTaUc3alFleVVOZFBC?=
 =?utf-8?B?NmZ6ZXBhdk9MbFdMVXR5VzdEN2ZMcDBKQk9iUlpSVzVUd2pUWUpXRk4wM1Zl?=
 =?utf-8?B?WXlxRCtyc2NDcWNrZ2pnS2wreHpPYVJNaS9Kajl5TVNHV2pHSEpadnlld3Fl?=
 =?utf-8?B?SWNBTHByMVJ6TnRGeVlJQ0o0QzE4dE1IU1VSRGphUzViS3hmVWdIY1BLdkYz?=
 =?utf-8?B?eURXc1crenk3SEZQSjZyUFNzSERFVE5RcFBXNDVzYitzbEU3cTlaUnBKT0ZC?=
 =?utf-8?B?WmlXbGEzdldaZTR1dE1NQnFWKzZCNncxZ3p2aWRsOVFiRVM0QmswWWRNKzJL?=
 =?utf-8?B?NmpCSVIxNGswOFdaUmx1UnJUbE1mWWE4YVdPOVZ5c0QyM2VaU0piNExmNklF?=
 =?utf-8?B?QkdKZHBXNEJ5Qk5sSmJySUVVU245bHRsbTZUaTZtTXpJbDhqR1lUakIweTdL?=
 =?utf-8?B?WDlUc2J6dTVqT2pNc1NjNmZBeHVhV25RRG9McDNaalVhZlF6eWRPdWwvSkp4?=
 =?utf-8?B?dkQ3MlljVk5tUWxENSsyTTJGZVJVVUNqMEdLQjNqRHBJc2hiQzJSTk11UDdP?=
 =?utf-8?B?MGpkV3RROStTZDBWVmJhTmlaQ2RQbXZjMEFEVStVWXpVUForcmlEZjBkNWVq?=
 =?utf-8?B?RUFaZmNrM1A2bFhXeFUvNHMyTElwWmd1NjJQYW5kNkRKQWd5UmgrTW9OV2tI?=
 =?utf-8?B?K0JFS3dRL0o2OFMyM242WTNOWDZtemh6MHBKd0g0bnBtUVV4c2Z2QytkQ0NG?=
 =?utf-8?B?NUE1OVZrT0M1MlViK1pSdkNVZ1BuaWMwajhyM2lwaDB0bUptb1RZMlJxTTFW?=
 =?utf-8?B?V0F6RzkvQk9mN1NWZnZCZDRuUkZodlpJOEJFTVpWdU5NeDVMcUU4TkZXSG0r?=
 =?utf-8?B?TGl3a3BmQmxGa01JM2M0TkxsL2M1ZzEzRnI2SVFBUWlJTXl1dzIrUWdOVURN?=
 =?utf-8?B?QU9IYzNzTW85QVc0bmM1cG5Odk1qWU1hUnJmWkVRZDRjTGsrWkhSWG1BY0lt?=
 =?utf-8?B?L2xnMkNQTy9DVllTWFF1OVZ6V1o1ek5LU1h3ZUQ1ZTBLZHMvUlplM0J5Tnda?=
 =?utf-8?B?ZjBZU2FlZnB4dEtqN1ZVNE5oa3RDbk52bTRmcTJGS2dDZWN4QlR0WlNZTE5z?=
 =?utf-8?B?eVdSUWZoOS9LbGR1bDFpdjVsOXZIdmwyTVlxNEZsaEZXUm15OHMrU3pZbnNP?=
 =?utf-8?B?YjJRR1lzY0ZuOTUwOUpSYkIwVTJ4TVZoM0ZlMTd6aUNHVHQ4ZW9YV1hnRXZT?=
 =?utf-8?B?QkJVQjd6cGF1YnJhbzE3MVp1aXdnVURTenhpMUZUeHFNSlBJZytkQzRLUVVp?=
 =?utf-8?B?eksvMHFiNFpsTG5PWCtLRjZsY01xMFpCenZkblY1b0s4S1VXa0krbTVTNnJG?=
 =?utf-8?B?cGFESi9WUmJjdzZTRkZCV2pVSFJhV3RUWWFLM2lsZGpGeDBIcjRJUEgvV1BJ?=
 =?utf-8?B?ZXVFaUVQdVdLRisxOU5NcnZvV3pUVUxSVUpiTkUreExEM3hQWmdYUnA4b1RM?=
 =?utf-8?B?bWlFZVloWVJmWElJemlocDlwR1JUUjdsOVpFU29adzdmcWxmRHhxc1cxRXRY?=
 =?utf-8?B?ZXJFbTY0eHdLT1R5MVlXVWJBL1cxWEtmRFBrQjdJRHl3SXJsNlFIVzZKTVBR?=
 =?utf-8?B?VnRpaURlMmRUYnplemVrTnJyMXl4c2tMMU5PeW5MdVdPaTgrQWtvRVV0Ujc1?=
 =?utf-8?B?SHJLTVpvek5SZDNpUGYzVHZGTFRycGFseGJXMis1aEhBWnNNV0IyYXZjc1Jx?=
 =?utf-8?B?R0hSVzBETjdMWFdEZkFtNHdMQ21NVG1kcHpYYys2VDdxbkg2THVmbXRWMWlv?=
 =?utf-8?B?WUxJL3F1MnBISUN6aU5NbEVBRmtJRzBHcTUvNEdCY3BaQXl5VnNPMWF1VlFN?=
 =?utf-8?B?QW95RlFPVFl3R1JOL29VSGdQcmtxSGVJTUNjVzVvcWE3M0ZmSHVkUkhtOXpD?=
 =?utf-8?B?eEpZR2Ura1o0L1FuZ1AvemFOcS82b3hBUHNiMENmcjFNeGlSZHVSYzlFNXd3?=
 =?utf-8?B?TDllTXZhYWpFM0RsRUNvdFpNcERCTG1jTFhuYUVOM2pGNWs0UUVQNUIyZm9K?=
 =?utf-8?B?d0IwZXFmWXkzQ1lUS3V3VVEwNDZXaFpUSFlpbDZzcmhRYUw4Yzc4MkdEUCtG?=
 =?utf-8?B?RHp5TmdDSFZKVHRZSDl4TEc5c09xa3ZqbytHYU5ka1E2R0tTQ2dJTHhNbWlX?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f054363-d0d3-456e-4a8b-08dc797841b9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:27:38.7551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kiVJfzHEMJIfHd4BEOTYb/RpWK0LHdYcZnNWbNp2dNlemPpUgpPKUz95roO5fzvHx7AuqRWfMH0KrnveFPV8Q4OTptbe+WhUhpSD+LyxpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9892
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

Hi Tom,

On 5/17/24 7:49 PM, Tom Rini wrote:
> Document the logic of when we do a full resync of the device trees used
> by OF_UPSTREAM as well as that cherry-picking is allowed as needed.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v3:
> - Actually commit the changes I intended for v2
> 
> Changes in v2:
> - Address Quentin's feedback
> 
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   doc/develop/devicetree/control.rst |  9 ++++++---
>   doc/develop/process.rst            | 13 +++++++++++++
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index 4cc1457d4ea8..ca4fb0b5b10f 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -113,9 +113,12 @@ SoC being used via Kconfig and set `DEFAULT_DEVICE_TREE=<vendor>/<name>` when
>   prompted by Kconfig.
>   
>   However, if `dts/upstream/` hasn't yet received devicetree source file for your
> -newly added board support then you can add corresponding devicetree source file
> -as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTREAM is not
> -set` and set `DEFAULT_DEVICE_TREE=<name>` when prompted by Kconfig.
> +newly added board support then one option is that you can add the corresponding
> +devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that add `#
> +CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=<name>` when

I don't like the wording here because it implies we should modify the 
defconfig by hand, which nobody should ever do.

I could suggest:
"""
To do that, unselect `OF_UPSTREAM` and set `DEFAULT_DEVICE_TREE=<name>` 
through a Kconfig tool (e.g. `menuconfig`).
"""

In any case, this is wording is not added in this patch, so I guess we 
could fix it in another patch as well, making this remark not a "blocker".

> +prompted by Kconfig. Another option is that you can use use the "pick" option of
> +`dts/update-dts-subtree.sh` mentioned above to bring in the commits that you
> +need.
>   
>   This should include your CPU or SoC's devicetree file. On top of that any U-Boot
>   specific tweaks (see: :ref:`dttweaks`) can be made for your board.
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index a66540a698c1..0542b3fc1245 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -108,6 +108,19 @@ Differences to the Linux Development Process
>     In U-Boot, ``"-rc1"`` will only be released after all (or at least most of
>     the) patches that were submitted during the merge window have been applied.
>   
> +Resyncing of the device tree subtree
> +------------------------------------
> +
> +As explained in :doc:`devicetree/control` some platforms make use of device tree
> +files which come from a git subtree that mirrors the Linux Kernel sources
> +itself. For our purposes, we only track releases and not release candidates for
> +merging in our tree. These merges follow the normal merge window rules.
> +
> +In the case of specific changes, such as bug fixes or new platform support,
> +these can be "cherry-picked" and are subject to the normal merge rules. For
> +example, a bug fix can come in later in the window but a full re-sync only
> +happens within the merge window itself.
> +

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
