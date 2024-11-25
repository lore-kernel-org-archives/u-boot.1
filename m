Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33255D58D66
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 16:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C5D89A05;
	Mon, 25 Nov 2024 17:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="M93Kzl4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8295899FF; Mon, 25 Nov 2024 17:43:05 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3B589A3E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 17:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oy9v/UXZbN7lkXIIoK+M9XPUzuw194Udc9oUwFlo3XK4tOMJvkJ1nmLyHkXPoSxWVilF/yZRVrlPRkOsot6We5oJvFWhRe/3b8df+EkwS3GFvumRGYfAqN/vCJ86SOfHA6no9gSNr00OftUlgNYvEA0+HcIJ//eXXvwTPCqRHHU8/FN4hgAkVW4Sovkw9AAInwMJzlVVoXjY9JZuRcrou9Uu44PCOj3UoFxVv3qFtNdYV1gbQX8xNERp25Gq7JLJF38YTBbXUVD/af8IDi4tbXjt+v3sOB3RIayFrlTcIuIY2pobPDb6u8VFP/rH6aiJgCtmXpwm2KvBbKoCcDSo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gIr4/ThGV9muCX5qsL3lFtRFbJ3+xa6SSxfIJjzs9I=;
 b=m43vxQJyQYf4T1LuCOxce9eWsVcyacDaU7n8vo1tOvyuj5B+oTAY7hRylq6sQW5YXXA3YK53YPK+LFHSv+8abmOOoEqr+QA8MJCPTglaG+6NR5yS354HIhW44v6rC8dj11h/7vNUkxY3jzZ/xRuaz66C1xtOXxcAXDJUk8yZqfnunWNR4AXdf88Y62PAm5wSLQsk2IjSLDK8Z7RNKUQ8wd9ldzaj4v+4Pd+88O0uUvXby19UJ3kZlnCZTlcFf5oSEl5krJQllVmEXIH8VsRZ7zA3RoCeSTNtRlhLonhu74ihy8piA33EPgMNt75prCrvE4gXKTpcenSVYh8BT9tdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gIr4/ThGV9muCX5qsL3lFtRFbJ3+xa6SSxfIJjzs9I=;
 b=M93Kzl4Ra5ivGx7mMPxVQ6sKdPwoePYO8LYPCmFK8JRjIU8F0Mh9VM4UoWykv+ooFL2SVcpp7v1yPa4DoGjPzjLIDliE8nkd5hID2P8azaqgF0hWlHG1WqP/Twb9sl8VlY2h7/xpHtV/tzwYL+m0sAYCJ7hr6Nd+QDtCFUCL6Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 16:43:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 16:43:00 +0000
Message-ID: <e895243b-7ee2-460a-97ec-a5e003bc6d2a@cherry.de>
Date: Mon, 25 Nov 2024 17:42:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: phy: Port set/clear bits from Linux
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241120094903.94-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 970460a9-5557-4447-bc7c-08dd0d70395b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjFNSng2UXZObkFFeDFZeWlXYTZvVXhVV1Rick5sQzR1Z3RjNXV2QURZWExy?=
 =?utf-8?B?d0FtQnN5NjJjS1ZCRWRlbTl5cEMwMTJtMUZGWlFEMnB3U1d1WEgrRkROYm9L?=
 =?utf-8?B?REM1bDRMQWpVM3c2OGsrTVVlbEJiMHRyUFdXeUtMT1R4MUhPb21xcDZ6WWUw?=
 =?utf-8?B?ZC9wL3NvR011NGxWTTZUZjQ0TU5sZWlqaFR0ZUhhVjcrdUh5SXZyZjRHeWp6?=
 =?utf-8?B?NFVqTEtjUkRLVS9Scll5QUtqUmxvNGZiODdpeEh6TUthUWJPM25zcytGQnJX?=
 =?utf-8?B?WnJJenkwM2s1TVI0Q3VzMmFsbVB1OGNpcktOWHRSTE5Zc1Yrb1dVM2w2cUlm?=
 =?utf-8?B?MXo0Z2V0dmhvUzFuZlR3eWRvbmdJempLQ3JyYWxFV3FtN3dxWGxqblJuNkVs?=
 =?utf-8?B?dGVJZElPK1R2eTdsZTBFQkxDVEJpWCtCUnZGbGZEd0c5ZWVvMEZkSXpoKy91?=
 =?utf-8?B?dXFwVGZrUHh1SVhWWjRIYjVvZFdxeXphT2l1V1JYTGMyellVZVpOSGxFa0hR?=
 =?utf-8?B?RHNWZW5tcXJjNUtSRk9pS3E5bjBKQzJtQ2FJSEI5d2h0dVhtbE04azFaMWsv?=
 =?utf-8?B?anlXbzVycXFNN1h1YXlmR1lYY1MvWm1kaUFRTDlSOHNHMHdBSTFFYUYvYWkx?=
 =?utf-8?B?WE9mN1lycXBPWlRDRG9DRzk5Vk1ia3NOOWNyUGZCc0s0VUZsbzk4OWZ6SGlx?=
 =?utf-8?B?U3VxOHhMUnZCVFA4dmJucHY4TmJEeXpySzkyazAwT3MwUFk4eGVaOGNrdXVs?=
 =?utf-8?B?K0ZpaklaZzlqcHVkRWt1aTV0aWtZVlBvVDdOSGVYR05KWHdkYXdEeitPTE5O?=
 =?utf-8?B?NmJKWE1VK2owWGVZcW5ZakNQRWZnc3hybkYrRkRDMnJRUklCMVl0djFLdzEz?=
 =?utf-8?B?b0w5cE1GNWhyMzJ5eXIrU0QvUUg4ZFR5OGtxcHN2Z0s5TDlVdU8zaVhWTnpD?=
 =?utf-8?B?NWxxUlowK2tPOW9kL1gvNE9HcDBSK0FLK1FCZ3N3V1dpMU5ROW5xMHVkWERx?=
 =?utf-8?B?Q0ZBTmUzak8zR1NuRHEyQkdSZndsQ3NGUFpQVk5ORWUyTWpoekNjMjEyd0lH?=
 =?utf-8?B?TXJCdU5Ud1hrWHBMY0ZHTlBscTNvaWpMd0h2d0pGcjdyMmRBYW02YzJ0b2JV?=
 =?utf-8?B?MHl4d0p5aHV0N0ZrK25yVmJhUVZlaFpvSW4yblU0UVY1N0ltMlUxcDZGYi9s?=
 =?utf-8?B?Z05jaDE5NTVXQUJrbFg3MWlBVFRKeWlrTk5Lc2tWVXNZUGhQYXZ2c3gwUmhK?=
 =?utf-8?B?QzcvK01IZlYzSTFENEZBWitZdWNTWmpzbHBaTEJsaWduYlUxSFZiUWVDeGkw?=
 =?utf-8?B?Q3I2TEhNaE50bGV5NEhnNjdmcmsvbmx1OGs3NHRMWTZncTN4U0srYWV3Q3dm?=
 =?utf-8?B?ejhzR2FsdThYNDFOVWYrNEhCWnBGOE9wcDFNcFI0OXZKZ0RFb3VqZzNUL2Zt?=
 =?utf-8?B?ZTByK2hqc3FHNVNOSFFWZHgzTzhldkxkenVGVExYakxxTE1rV3pHM1lWamk0?=
 =?utf-8?B?THRRdzBmaXVMZ0ovRmJZekEvVlN3bWc4SUhZLzJiMG9hREl1UVRYbGtmYTJq?=
 =?utf-8?B?dTJVcUYyR0t6TDM1cUJmQTNIbmN2VExGWnhHQTZyZGYrNWxwRWF6Q3RCMjY3?=
 =?utf-8?B?MURwbGxwcUNEM3g3bnVza1IxRFJzVEZOTXVFbHNsWTJCYVNnRFpESUcxM0ZV?=
 =?utf-8?B?cGZYNElQTXdua3NhQzQ1VjRLUUVac21MLzZ1VFNOTHNNOXd6M080dU00SVRQ?=
 =?utf-8?B?a3ZIcE02SU9jVUtoa0VlUVNvWG94Z1NIQmhPY0g1UnQ1NkRwY1VibFU0VDZB?=
 =?utf-8?Q?DpBty33b75Trr0lMB45spw7i/HIAOGpPXrEN8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ny9nT2orZmF0VHU4cGxwTTFqMHIxYTBzK00vYzRIUk9WQmQwd291YVlpbVBW?=
 =?utf-8?B?WW5qRWc1VGU5TFdNUnkrclUwTEpYa2VRUDUwaFF5N1JCZk11RmJKQWtmR3o4?=
 =?utf-8?B?cnIvUXVHdXlWRlZEUGRlSWN1WkFGVDJXVDlyd1Z6ZGV6d1RLN3JPYzgyaDZo?=
 =?utf-8?B?aWFWQ1dGcDIxQXlaU1BsTHFyVzFQcW14Zm5xTjFucEszRC9BSmgyTW5qR0Q2?=
 =?utf-8?B?cHBOZnJNSTRHZW1WM2lZLzNtcmMvRmIzQXpJaStZajZ1cnJyODBNR1JObm9x?=
 =?utf-8?B?alRYdmtSd0dZK3lKSXVPYWJVTnRqQW1rSm8zYnd6VEpreTEvRFJNWjZHZFls?=
 =?utf-8?B?NVM5eXoxdUY1TzFmakNzZVdzQ1hhdXE2MTVtMExhSHNzcmdyMTBaa0ZSM25J?=
 =?utf-8?B?RVZ2M0l0QVp6NjFwQlZJYk5GT1VNZm5kS09vMUM0Q0FabEVyOFB6VUs5ZUox?=
 =?utf-8?B?RlFlZlJIUVlMTC9HdVRxN3lqTCtIK1RqbS8wbjZOcFdQS3JtcGtVQUcxa2hm?=
 =?utf-8?B?TGNxZVZERmJ0a2RYSHhTVXVLVU91a2VEZ214QkZOSTZObkZzOTk4QzdGN25G?=
 =?utf-8?B?dXRTeTJCZ0s2QVcvQ1VQSzlPTHBiZ0JqWWdZcjc0MG53cTN3Z083aktKNXRm?=
 =?utf-8?B?blk4VmZwNUJxRXZSWTFUYVZibUM4MkNySmw5amFxY2hVVEw0c0J2YUVyMmd1?=
 =?utf-8?B?Y3hwOFhwNmhGY3NHUFpZODA0RmR6bUZhM20xZTNOV3pBZ1UvRUpRTUhHVVlE?=
 =?utf-8?B?d1BtemovQmVBczB1REdUY0dEeTVscXVidi8xZE5wTlJ2TFNOUHozWmZlaVB3?=
 =?utf-8?B?SlNud283V2ErT2pvdy9XK1d0N1NRUUNyakg4UDBEUE9nOU1rY1prdDNDbytM?=
 =?utf-8?B?d1RsM2I4NGxXT2ZnVWJKd0JrQjZxMXIvbk9USGQvZUFjWk95K25aZWRObFpr?=
 =?utf-8?B?eExnRnFVVkprcDBhSmZ5d1p3Sm5yODF1TE5uVll1RVdvL3FkODJZQWFZelQ0?=
 =?utf-8?B?ZFNIV0ZLekJIdE5wZDU3eG1Qazc1VTZnOHcyMWNFQXAzWkRFbzhEOHNINjhn?=
 =?utf-8?B?RkQ4bC9pTzQzSUVoZzdNUUh4UGxTNlk5Q29lNzExVUp4MVJYN3ZacE1EeitI?=
 =?utf-8?B?UHBjdmNTMDM1Yk5iTGN1TlNueUg1cE56TzJ5ZGI3bUd0UWdIeWcxSXpSNWow?=
 =?utf-8?B?R2RTMUVGaGxyamU4ZHNNZEx4emVPVDdKaUhlT3BpYitDNEtaUXhTd3A5QmxR?=
 =?utf-8?B?VkpTQnBXVW01RzZOaVB6V2ZrWWRySGVtZE1MUEJsRDZETEs2N2NXbnRBdlNM?=
 =?utf-8?B?SGxkdlZ3WmFjOXNFem5yYUFTbldkdDFoak1xM0xiODJVcDBlSWFsbDlFcFMv?=
 =?utf-8?B?MEpVOWVjU0NUSTFZZldiOE80ZW8ybnFzdFNkMVkzUHJBNVM5WVhoc3BqZDhm?=
 =?utf-8?B?OHJuMXNicVBBS1NYUTBDUzQ5R1RhNXBxejg5UnBhL2VHSWI2RFJiVU13Umpa?=
 =?utf-8?B?eWRPN043KzV0T2RaTEcrY3JFMjZyZEFrYVZERmdLZFg1NzBwWmFiK1UyZ3hB?=
 =?utf-8?B?SHljWWEwa2FlOWtHK0cwbUhJTUg1T2lmOUFSQjdDbEkxVVMzSklwZnI0bW83?=
 =?utf-8?B?dHN4dWNjVWlvY1R4VmRESk91MjNNZytwd2NOQUlzSjNwcFhZWlJGN29tOHo0?=
 =?utf-8?B?bmhCdHFJQTl5d2lsM2VSSDdQTk8rbnB6WDJ0cVQ4ZEx0VmFqamNlM0NCL2tQ?=
 =?utf-8?B?MjZHemdNenZGRUNnU0RSM1BLVC9YRVYxeC9vOXZNa0hqZVRqTXlNbnFCdmVS?=
 =?utf-8?B?WXlsQUUvbSttN2RkMHRnQlNmRjJCWDhpQUdPQnpIYmJuMUloejJjblowa2ti?=
 =?utf-8?B?OGpDcGJHN0s0YnhHVC9ITENNL2ZnNUptZTFtajRmV3ZVZVIxUlJ5NjBpdFMx?=
 =?utf-8?B?R2xZdjZIcWZaL0gyNVJ1NXNpUWhlbzc5YmxaZFVWNzVqeGJFcGRocTZGb1hp?=
 =?utf-8?B?OURUQkJ3NWpyWFRBZlhuMFNsa2ZScjcvSjVPM0FTeTJVeVMrT3RyYW9Ncjkw?=
 =?utf-8?B?VytBbC9FWXV5UXM1dndNNkl4eUJrMXBaMmNXakgvK0FkOW9WWDRVVjFRamVH?=
 =?utf-8?B?K2Q0Z2NMOFdnMlBjc0U4ZlR2S1k4MGJLR0xuZXIwWVFvNlF4b2hlcFJsTDcw?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 970460a9-5557-4447-bc7c-08dd0d70395b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 16:43:00.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6kgdkWcEHdxz9+NnH26bWymWRn/468HMiI72YgURxZ/MGA06MIC9EvgdHmPS86VRqJKCUvtebpdNt8vhrBDH9MMb7jjvtzk5ke/C9Ghacc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935
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

Hi Paul,

On 11/20/24 10:49 AM, Paul Barker wrote:
> To simply porting phy drivers from Linux to U-Boot, define
> phy_set_bits() and phy_clear_bits() functions with a similar API to
> those used in Linux.
> 
> The U-Boot versions of these functions include the `devad` argument
> which is not present in the Linux versions, to keep them aligned with
> the other phy functions in U-Boot.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Changes v1->v2:
>    - Split out of series adding RZ/G2L Ethernet support [1]
>    - Added Marek's Reviewed-by tag
> 
> [1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@bp.renesas.com/
> 
>   include/phy.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/include/phy.h b/include/phy.h
> index 36785031eeb0..510b0a21831b 100644
> --- a/include/phy.h
> +++ b/include/phy.h
> @@ -333,6 +333,28 @@ int gen10g_startup(struct phy_device *phydev);
>   int gen10g_shutdown(struct phy_device *phydev);
>   int gen10g_discover_mmds(struct phy_device *phydev);
>   
> +/**
> + * phy_set_bits - Convenience function for setting bits in a PHY register
> + * @phydev: the phy_device struct

Please document devad parameter here as well?

> + * @regnum: register number to write
> + * @val: bits to set
> + */
> +static inline int phy_set_bits(struct phy_device *phydev, int devad, u32 regnum, u16 val)
> +{
> +	return phy_modify(phydev, devad, regnum, 0, val);
> +}
> +
> +/**
> + * phy_clear_bits - Convenience function for clearing bits in a PHY register
> + * @phydev: the phy_device struct

Please document devad parameter here as well?

> + * @regnum: register number to write
> + * @val: bits to clear
> + */
> +static inline int phy_clear_bits(struct phy_device *phydev, int devad, u32 regnum, u16 val)
> +{

Looking good to me otherwise.

Cheers,
Quentin
