Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A355AC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F1788A14;
	Tue,  6 Aug 2024 15:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AEcS6ocT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFF088813; Tue,  6 Aug 2024 15:27:28 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3DF88A2D
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 15:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHQkE2ETXfJSgRusrBJCT6e2Bcgb7u40rlTwjquo7P+dJBPsTPzHyiIeNqOgoQkds90TrzT9Q5QrTS4W3coOUu/ZPEcxjANw1VivMO/t/ZWpoEXYFhvxaJ4ix2rqh0xuonEM6BnPnpKmMLJXuxJqht155dTtkLqhWvX9K1AKPok4ew4+L0233FqW8l1pcedUdeHcZjItBu1lqK/lb0pRk7PWy32m0YO9+kqY82cVCO4h51TzWe/cOJ9qF5DgI7YuJUKIrG5yCb2/znfHUcbLNe4QqKTgJtwg6y2qNMQFBRgiekyzjrYLlu0pFIJMibsZ1s2U92q3t0O/A6DCkRUPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1svP0a9rVq/rBypSPSinz9hWXfEB9KXGRtuX3vEMFUY=;
 b=qXc4xO5sm3ANHxhPb8/FHBgAanhpc/bVFItoMq40Ijh9rdmC2zpMbe3nRZueEWi1txA1VFLDQaqBONXnVCHFM62GnA2tJMCeHFKVsZury74gWbl/vkp2vGUZlTIRvtF2acolO4iq0OrzstSmhlBrgvVtBWNRIDs2cyoqLBjh59N5JKu6E0taiLEU2d9AWLxJbexVW2CjnQE66AogdbxZrvZBnMTBWsNKYkzuTK6cxB4e1LR6m5h56ByCmTUZ43YkmKQE0bsnH8w5A24oMxvFpQ+0wDTdcLXHldDLjge5cUpvedd4SmiTDjXbloIs7Rg7gLp6nYgE/9YIbWnujA99tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1svP0a9rVq/rBypSPSinz9hWXfEB9KXGRtuX3vEMFUY=;
 b=AEcS6ocT35I3okPTwsMd15A6dqjCUWtlKto9vfZPvkfXu44yu6MWrTzB3C10cbcHElRwdvL4HInCvONVY0CPswU69/ugMgrmYLwtToD5AD/YKlN329Q6q7rsfY68Lc++SroPIT8KjhZBAOF3vvyybm7qF1IZaW3hSaDuVzbEa3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10896.eurprd04.prod.outlook.com (2603:10a6:150:204::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:11:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 13:11:29 +0000
Message-ID: <3e588768-ded9-4f1d-8361-b494ec0a6de0@cherry.de>
Date: Tue, 6 Aug 2024 15:11:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b90ff8e-e549-46be-26dc-08dcb61948d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dFRVNVSThzVHdYNVlVOU44dkZxNGladzAwaUxHMTc2Q1UrVkFDTVdMd0tY?=
 =?utf-8?B?eTNFWUl6QkZLOHVTWWFXYTloYURsYTVMa250TFJIck43UUs4NXRIL0RGTHpN?=
 =?utf-8?B?ZEdiOG9LVXRiVHJYUmErUzYyVUdyaXRTNHZ0cE1WM1A3dmpwTWQxSVVtbDE3?=
 =?utf-8?B?M2ZUdzJRb3c0M2xiQVEzSWhUME5CSmRTN3daZzZHaXJWbXd0S0QrWkYzYUtM?=
 =?utf-8?B?aWNBeTdwQktPNEtaVVFWamd4VjRwWEtIcDJ1a1ZxSjk4M0xWekcyODM1WEhV?=
 =?utf-8?B?ZXZPWjJVRWV5N0tGYkJwMXgyVlFxK2tPR3FNUS9LdGV0YzY0WmpqWkRxTnVO?=
 =?utf-8?B?TVdRV2NHOVExWnpRQUNIejgyM1BXQkJBeENCRlVpS2piaUkzT3BvM3hpZEV0?=
 =?utf-8?B?VUFPOExuRmFqUEdNOUV5eCtGUDFLanVuZy9JUGlZSEQxUHdMckZvRzgyMHZm?=
 =?utf-8?B?MkcrVVVHRkdVL0tGNFJvM3ZNY1dqQk1XSUVjNEU2c3U4RlRDczBYTUFIVkVt?=
 =?utf-8?B?MFVtVDNMSFR6RmliWlNaN1JjOFNjaE1ENDNDQ00yUHFscDFIN29sQlVvWXJ2?=
 =?utf-8?B?YXI3c094c1B6LzNDVkNKUkhHR0NqNlI0OVd3ZGgrK1A0alFEa3c2UlEzdGlI?=
 =?utf-8?B?U1pRR0lLTytYWjM4dkhTWFg4VDl2UXZvb09QMzZpQWVNd0pxV3hiVjlxYmxK?=
 =?utf-8?B?dXlJdVFUSlR2dzVTZEVYQ1lnMjF4VU95dW9jWnpFTENoODBZR2hoTHhZKzNa?=
 =?utf-8?B?ZXlReWhDTHowWmE4R0dVYmYva3dJOENpVTJKSjF3NStLejZMUFM4NkM0NENx?=
 =?utf-8?B?YlI4WVFlcENHdmVjWXB1UlZpaFhvSzVIWXBYVmFsRGFKdVJpOUpvdmpSMXpi?=
 =?utf-8?B?bmxqRjhub0VjS3l2SjF4eU5CcXd3TWRhdlR1bFZmQkg0RW1vNHAvS1o1THlT?=
 =?utf-8?B?NzZVSjM2TnZ4WEdzTzhjb3dxeDdIK3dKNXdLdDJMbURNNS9JbFhTVDNPNllW?=
 =?utf-8?B?ZFJpMjIyU05TQWl3aXhIQ2loY1lyZmcxUndIL1lxOHVES0FWd3RSY3lFUWFE?=
 =?utf-8?B?RzF6akxseFlJaTBWVVFndDlNdERCWnQzZFdMVFFQNWVHRkEzc1lud2tZNDdH?=
 =?utf-8?B?a2VrOVNGOWVlR3VqZ212QlZkSkRwTHFyU0JBOUk1RFJ6U0Z4eTJOR2hjcUdF?=
 =?utf-8?B?S2loTTFiK3Z4SFVzYmJqWHB2K2R4NmpiYlNNajdMV2tOMVNaeFNuWWRrdVM2?=
 =?utf-8?B?QTJpV0duV3ZNZk9OSTNVeWhxOXVyZUwrdXhheGswQ2Q4WHlyTEdwSUdIWUVs?=
 =?utf-8?B?R1ZKMXNpRjdLSE1SQ1VaZjhZZmFxSzdGTWRLTEMvSXV1VzdNRDBoa2hUY0x1?=
 =?utf-8?B?c1Q2ZmdyRTVzU3ZEaGxNS1JIVjkxRTE4emIrbU5LWHJDSGhXMXh5aG11VWdR?=
 =?utf-8?B?QU0zSmtGZ29OUzc3MGU1S1IrK1NSVUd2bzV1MWl5R0VVRVpzd3VXV3UvTlF3?=
 =?utf-8?B?MWY5a0ZGUXNCNnhZU0dlVW1Ia3NNbUdGN0hhbXF0S0VpbFdWZEhtVzhWWklP?=
 =?utf-8?B?WDM2ZWYxNFdBSmxhc1RTLzBOUU55NDlDT2dNN3l3Z2NEbkRuNzdhME5iQVJO?=
 =?utf-8?B?ek8zOEFGUUgwQS9tLzd5ZjZWWjhkUEEzQzNzUmhJTTZ3ZXdLVUVGRDY2UTdK?=
 =?utf-8?B?dWkva2pPejR4Vkd5Z080UDc3SHk1R3Zmdzhob0VaMzg5V0JtUGVLejAwa2VT?=
 =?utf-8?B?alBudHNHdHg4Ym5oeTZmUXdhNkpKdzRMaUw1U2FCaVpkYXZFdVhmTmJOM2hH?=
 =?utf-8?B?UmtiUDBOeXVkblI0OTdEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRrVjJXYXJoNGVpTUxQd1QybGlKcXFDYklSRDg4SXpTc0oyY3BoZGxyaGJy?=
 =?utf-8?B?dEFVbHpGSUZsRVJjNmFQTHBYSXRSdTIzZEdrQ0Y1V3F5cHoydWhkL0NpMERV?=
 =?utf-8?B?NUNNcklZQ0FtZEIrYVdhdzZqUmp1WnRxVDI4Wm5yR0czRU84VmRVUk1xdkdX?=
 =?utf-8?B?OEc2a0Q5ZnFaM1puS0xuaU9rRGROZ2srWm0yeDVxdlMwV0NkeTY1NmVBQWdN?=
 =?utf-8?B?ZDFmODlDZFRXZlFDMWhWU3JsZVVUTmhyQndMaWg2R3ZxaWJEUU1MSVg0Y1U1?=
 =?utf-8?B?eUxjVXBTMXczTEFtOHNtRzV1WHF6QmpSbWY2eVBuTGZoMXYwNTZVR0s2VUV1?=
 =?utf-8?B?RkpCTW5sYTR4cFdrZlpWTktZSXhldlIyOUtpcGJieEtqSXhWcUsyWE5aTG5J?=
 =?utf-8?B?ZUNTalFsbStheXliVFI0RjJ6bnpBRkdNNnRMWmNxVFRKTHo1SnlPZnl5bjNC?=
 =?utf-8?B?Y2JEU2VRbDBmeW5BZGdrK2lrQ0tSR0JRcUo4UHpLNHJ5UW13YVB3OGlIVzZ1?=
 =?utf-8?B?d243WWdRaFRUa3Q5NHQyM0FLbTZzd0k5cGluRnFLL01sMU9GN1E4dTFCQ3Ji?=
 =?utf-8?B?NDNhdllmeVAwKzMyQmhFeUR6MU9pWVBtZ2pZOGk3cThEdUpVejcyeG10UGRI?=
 =?utf-8?B?Qk5EVnp3UU13U1cvcVIzYVZxWndrdnRZL2p5dG50NE9aSFNUZHJuK2RHTHll?=
 =?utf-8?B?dW5JRWlLRFZSOXc0Q0s2OENteU9rdXVrWElBVDJoVzAvOEptMEs4aG8xV3BK?=
 =?utf-8?B?aDFmVXhLdjdmOUFiTWlYZ1hic0taTFJsZ1BxN00weGVzVVVUYWVlVGRaN3lv?=
 =?utf-8?B?OFBrVnhqcmFIQW5mWGx6WjRQNyt3RDhjYWJpVUN4VUdpZXkxc1lHcHpFbTUx?=
 =?utf-8?B?c3cxM0pURVVBNFdBRUdKYjE0bUxDSTJmQW5GKzZqNmtHRytkR1hSWENLc0ly?=
 =?utf-8?B?RmU5RlRmaGM2eEVHOURIVWNqUm9lL0FCRUJuank1SzBPQjRZdXVCT0tKeGYz?=
 =?utf-8?B?RSsrWGwrYnlCWTZaelRxNUwrekZhd2lXdUQ2M1g4UnF2bmZLTHUxTUhHdU53?=
 =?utf-8?B?cE81NWo4Y1NmcVJzR2I5MUJhUnRDL0MzSTEzeXJLYnRnZGNsOHJOU3R1Y0g5?=
 =?utf-8?B?M1ArYkpZb0x2STFya2F3Mk9vNmNTR1hHWERDd014OGxSdUVOQlJFaEh0SHUx?=
 =?utf-8?B?cGtGQmJpUkdsODFPNVlWWWZrUlQ3Z3VPK2oxaHRUZEhkcWJ6RTBNNGw5LzRI?=
 =?utf-8?B?VW9lVHFLSnZkaGRyL0w1TTJsMU9UY1ZOaWEvNzVMUTVQT1dTdDMrOTVxQzMv?=
 =?utf-8?B?cjdobGVUaWt3QU9hMFI3YzBxU3p1MGJKYkRzUjAyRTVvK2VaM1ZEc0tXMXpM?=
 =?utf-8?B?aUk0WVJqMFphTUpHWEVCdkNjOEkrb1hVYXJwTGdrRjhhcFR3d0dsNmRrN2Iz?=
 =?utf-8?B?UkViTjIwc3JsTHJsMDNaMjVIeGhiUTJabGRBakRCUElQSGpDV21KRGlCbUI4?=
 =?utf-8?B?UUZaVXdNYXl5OURvcUtQMjlxdjhhSHdqNXZQajBZWXpDUHNJYWIzeFdYaWFJ?=
 =?utf-8?B?ZDB2RGpJaWdzQWdCL0U2QmwyTkRMempzcjhYWVhxeWx6aUg1T1FiNVVHa0cx?=
 =?utf-8?B?NGxuMGxCMnVYVVBGbWJLY3psck1XbUg2MHl1TUk5dWVvZFBqSHlZNTk1ZUk0?=
 =?utf-8?B?ZzNLUWRORXBoaUtVYXBJSGZpeG9lcWtBRml3dVF0WE5VdG13WG9mQzBRYWdO?=
 =?utf-8?B?REpnM1RQVEZGM0tvWTkwWElycDBYMUxrQlB5WVFDa09YYnBpU05NdVEvTEZn?=
 =?utf-8?B?RzRxdlZLWEIyYW9rQ3phcjhIR3puY2ZOWGhoR2E4eDhaOXFqdjljckozSUQz?=
 =?utf-8?B?RlNsTEloWnZ3MzJlSGZRbEJQdExib24wYzhGamd6YmtCYWszenJTbFdMTEF2?=
 =?utf-8?B?QWtaV0ZjbjJkTmdieHpUN1JRSlpDTEwyOEg5d1RyenlQMEhVQWFxMkNSSWFB?=
 =?utf-8?B?STlaTWlLbXVTRG4zR3BqdElHeU43TjdkN3Z6WnBzQy9CWS9idExWUFpQMTQ5?=
 =?utf-8?B?ODlRK1A2Sk9tR1dKNDZoMDFmQWE1OWxMQ2R0YjJCVjF6S2VDWmpocjRXSkVP?=
 =?utf-8?B?MzhuWWtNQ1BtRkxja0haUCszRVFJcTFBNnpTR0pMOWFSTWwwcmVvQXBqeVV1?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b90ff8e-e549-46be-26dc-08dcb61948d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:11:29.2901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIGhBJHWAYRon0GNXtSLQgLc39VvvvGYLQ/3wNzUpjd9b9ey6O6UNNviCB12vJy6rSHclTKz7lkCyhoK59EfPaGF993jf9kgF6UdDU7o2LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10896
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> These should have a CONFIG_ prefix. Add it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>   common/spl/spl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccade..6f4a8bfb3f4 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(OS_BOOT)
> -#if defined(CMD_BOOTI)
> +#if defined(CONFIG_CMD_BOOTI)
>   		ulong start, size;
>   
>   		if (!booti_setup((ulong)header, &start, &size, 0)) {
> @@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   			      spl_image->load_addr, spl_image->size);
>   			return 0;
>   		}
> -#elif defined(CMD_BOOTZ)
> +#elif defined(CONFIG_CMD_BOOTZ)

Should we rather use IS_ENABLED(CONFIG_CMD_BOOTZ)? (same question for booti)

In any case,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
