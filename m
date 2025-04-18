Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F21C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A2D83205;
	Fri, 18 Apr 2025 15:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cRpWvmAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969D0810EA; Fri, 18 Apr 2025 15:51:57 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F74F83214
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvfZ2sjJforuFeiwyZMOrGfQQaV3hFMrnoBelHUkOV9iu1enbihvsEv245oGicJXqrZN9C53umVIKWLQ3O6XWfaWtbpz2JdG3UEVEoMiyc2b3qgxLsuY/lyDKPikVb5uN5AMMeCFxoiMThMsn3k2CTf+PFQOqOPQYprCwoft0trjaxukiBvVUKNxyNB7hg4nzFa+04RM+jvr+DawjfZXpKPrWdBwPoyL4tigxOE6NaCNev45neRc7YsSSt+ZO9BoHum/AZ96t2uqbHSj290rEYFoqsCCpcRI6UQHfKDIzlzKJUcNezatbrT+Eitm7Gs1XBIOovSsNRkajpyw+NDp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9AVnllK9ifk59xpna1E6lge76Odp1aDkU7d1AhKoEw=;
 b=eJNb27ZJG1RXU3hwNgJ58egzzO1sy22XD1y+egEaWVN8Eav8Fnk3vvBD+Q+goErbvKdysxSOm2Amf8V6a0rFRWoUD+U8rIT2EpcfSeEqclEhNfYoQSrix2IMrLbxXm9IxYHWfz2TKERIWvB/Yy1E0Yswi9LuplTenNM9Irz94u/Oyt+uHl3jvXOGiIr9xbj4eGG2OuVS68LhWXShkiJAEyXn1APUf7Eq89RJG7EawEFueDdgqUs3WLu3Hj5iVUoH/KwxuDeyZLs43yjbzrr1x6BJvm6rjv0DPW+X81NI0lkt1PFJxomtCGBLs+9biFCCwmdT00sQtan5e4FhvamzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9AVnllK9ifk59xpna1E6lge76Odp1aDkU7d1AhKoEw=;
 b=cRpWvmAbqI4N92rHfEzBHwofEKE3fRhnbGlhHVcSxb173ihY76i6Q/zDkltsmkvPpvTRJwqhYJ55cxkDIFkBU13tHmdt8/nFt8YCCSzsaaI2TxMuZRJEYES5VRcyoPXtsWZOLQhalDnNC2snaN2DEHoaF/D9+2FiBmZBqD8taBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:51:54 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:51:54 +0000
Message-ID: <8d0d361b-6134-4374-8825-f44af333e948@cherry.de>
Date: Fri, 18 Apr 2025 15:51:52 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] tools: Fix memory and descriptor leak
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
 <20250418081958.12818-2-ant.v.moryakov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250418081958.12818-2-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 17059983-56cb-40cd-e57a-08dd7e802d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjNYNW5FMm93TEhOcFArVUo3QjNrelhDM082a3kxS1hqU0ZWeHFBeUFlL1Fq?=
 =?utf-8?B?YmZNcDJBNkxOTjdsRll4YldOYzRvZzlSVmpsSFdXWExWb1BwMnpVY0drSVlj?=
 =?utf-8?B?d3VQUGRIVkNhVEg1OTE0RFhUd1ExRkVZSUk3TjQvYnZtOFhjRTdVMnVzem9R?=
 =?utf-8?B?aVIzZW5xYWNySmRmYThGbnRGYXdnZlQ2Q0J0TGhNdSt3RTVBMHFQSGFyTUJ4?=
 =?utf-8?B?OVo4c0Zrek02Z2hFR2FZNzRjaW1BcSs1eVVUYytrWmJUVnBHK25STld2U3pq?=
 =?utf-8?B?MllLR21oaXN4cHRNZkNGNWl4bUptR1VrR2NFRzdTUklzemh0bU5kdzBwcTBm?=
 =?utf-8?B?Q3IxWDBXOVcyZ25qUzkvM0ZGYUNHZ1RUZ0xXajVQU1U1L0dXTTIyWE9laERp?=
 =?utf-8?B?TDNTZlZ4c1ZZMjJlN3dJZzFyNGNGWWY3WkdTWmcxbFM3SDU3Y3dDUTErZEpL?=
 =?utf-8?B?eUZwMHpKQUFjNTdYblZFdWJlRDlGZ1lrZ1FaWENFeVNabVlES01JbHNUOGcz?=
 =?utf-8?B?ZUExUFlEVlZaME9NazVUdmtFTGZ3V2dLWXVkT2FMc0gzcGF3RTJJVmdiRk9W?=
 =?utf-8?B?RmRyVWZ0eDZVd25UZDF1Ry81RUtDdUJSb3hCV3Rwb25QZkVkMFN0dE9TK0JE?=
 =?utf-8?B?ZVNxaTNkRDR1ZGlkMkdDamxlMUNaN29WTjFNS0tTYjRWMWhQbCtBQ2hFbW93?=
 =?utf-8?B?V3VJTEhya1MxM0JndWxsU3k0WHNud0loWmdJdzdwcm5ncGx1aVlKV2hUUFUr?=
 =?utf-8?B?VlhlNm56L2JSZkR5ZGRMeWhSU0R0MElVbGc4Nlk3dVhBeEZkcjdoWU80b3BW?=
 =?utf-8?B?bGlXVFZzWHN0aVN0cjBVS0pMa1Zub29ra24wYWpQQUNpbzc0biswaG5YYTBC?=
 =?utf-8?B?WnRhWFBwWi96WEJqNGVIWUVnRitIMkpFbExDR0NrK055TjZienRBekRNT0p1?=
 =?utf-8?B?NmRpbFUvMkphQ2N3RXlOQWZQZGRpckRVQzlOSXVlQ3JTWndDb09laHl1YWVN?=
 =?utf-8?B?bWZWVUJBN0xEdnpCTFlleWdKUTRqcXEzQ0RPVmVscWl3eVJJZ2RaUUU4WjRa?=
 =?utf-8?B?UlllTk52WWNQeCtsVHZrandYelI1SENObUJzcEZzaTBqL01XaGdwWEJVcDJn?=
 =?utf-8?B?ZktkV0s5bENVMEc2RTNobFpwdTdUSUxrOUYxNHhsaTNIS2l3R1M4MmRJU3Zu?=
 =?utf-8?B?ZVVJQ1NvRkx4eUxkZ0VPRHRUSXIvemE5MnlZMmxxcjRyZkQxWU5DUVdpYjBr?=
 =?utf-8?B?L21iOThmaUZNUXdQUHFzUTFuZEFlclZ1ZU9hU21OdDRBZzhzUW1JU3RaV3FO?=
 =?utf-8?B?aGsrc08rK2ExTE85cFcxdjBkby8yN3B4TXMvaHJUSkN3U2xjQkNWenVrZXhV?=
 =?utf-8?B?WW1YSUhDMTAzV0ZMbDdaWTI2djY3Mm15TnlnWjc2czBMMmxkTzVSZ2FtRnZ2?=
 =?utf-8?B?WEZjUW96NFdGd0VTOU9iYzZGdnVtYWRzWlN1M1EvaTVLRWNRdytxSHVTdHFI?=
 =?utf-8?B?bEJaTDJrK0YxcXRUcENlYzQ2cVFZUENRVTV4UWtIam0yNXQ0dlFKY2tRVUdm?=
 =?utf-8?B?b0VpWTU0dkRrM3BubVVUN1JHSTNwb3RHanlZMXVBTXJIOWVBMnA1THkyTGJW?=
 =?utf-8?B?VGx2T2FieFp2N3pLVGV2bENQVnpsNU91Q1ovdG1vV0pmcjBqcnZvbGFxNVc0?=
 =?utf-8?B?ZVRoeHJEMUhUMGoycjhGSGMyQVpzTWtzS2hBdTRFTDFYL1R6czFINlc4Nmhl?=
 =?utf-8?B?dkIrWVlhNFlZNzJwbXFvTzdwTHc4azlzcmVXSDdCaGI3UUUyS0syYXhrNFZz?=
 =?utf-8?B?MWl1ZHRDbzltUDhLZ2JFN2ZCZ3cyTDllOWhCS3M0aFBGSy9IUmg4RkZZdjAv?=
 =?utf-8?B?MHU2dTdXZGpPRE9XdGZkOTNKMi94Nzd1eEZrd01BRlVOQW56NEdKbTVBYVgy?=
 =?utf-8?Q?Ub6fbZ2Dd9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9zdVdhNC9OK2FnSjlBM1ZROWt6eVpiWWpHQ0lwejV1dXllYVJQdlE2NDZS?=
 =?utf-8?B?a3dWTjJYcUVOMGNPU0RXTTl2bSs4SUd2MGgyL01Ia0lBYWV1TUhpdlpWN1hB?=
 =?utf-8?B?RUhhR3VKREZSOTlMdnF3ejlPdFdHZ25CeGxiS3U0K0dwakVHQWxSSHRZdnFn?=
 =?utf-8?B?NE5oOGNSMUV5YUZ6dUlhVlFBb21rNldmb0N3U0hkdTRzdmlPN0N4TWRHQWlK?=
 =?utf-8?B?NUVEUjR6WHVGRkJDNVRYYi81bXlHT3dncFpQUTFmcHFtbHZ3bXZHaE1JVmhC?=
 =?utf-8?B?aU9ORzU3aW5WNE5HY0hSa0x6QkMvMGFzdk9oRmY2UVJ5NG02SWljaGJSNUNr?=
 =?utf-8?B?QitLT3FIVjFYaEh2TDFoRGVPeUZSa2lkMVMxV2Y3Vm1sZnBMMXRSRFBET2E1?=
 =?utf-8?B?SG03NmZDenJQVU1KWk9yZVRzYVFqZzNYbXhCSUxyc3lBQnFpcEYvVVpxQnNz?=
 =?utf-8?B?dExONnhoaWNMZ3kyZjF6a2cxZHVRQXl3RG9CWGFNR2xXa0tNMFUrTEZDVXRW?=
 =?utf-8?B?RHpGL3V5VWRTSFZVZDl0TThjY3FTYkI2OTdaMzM4UjdYM1pjVjRpekplSFo2?=
 =?utf-8?B?U1JpWm5DcFBmK1JhWFdKK2R6NnVqNXg0cU1iMVJWeUxJbEJtMDQraGRteE9T?=
 =?utf-8?B?WEovNFRtcXF6S2lHNTRyR21NTE9NeUdrc1hySXVEMzIrdFUva0xUOXBNVHQz?=
 =?utf-8?B?QnJrcnpKd3Qyb1lxdmkxdlFUd1l4VzRvRzJ6VVpPeGpydGFQaVdaYi91WG5z?=
 =?utf-8?B?cUtPd3NBcHpVSzkzVHN2UUFmbHBLbThWL1g4MWNrVXcvSnNZVmI2Sm40Y2Yx?=
 =?utf-8?B?TjZqK3BOM0hONDlkQzNMZ3cwcGVFK2pIaGtJUzdaS01LNlRJSUp1c3IwVG5C?=
 =?utf-8?B?TnlNbERReFZKWEFleFZpNlptRFNNUnFRUmhtOHB5SXN4WThRU1lkdVlJcGlz?=
 =?utf-8?B?TkVkY2VxRkp1U2lwM3NOL3d3K0cvbThTOEF0bGFGOGxQeVU2SWdmRUhsNVdi?=
 =?utf-8?B?bVhHN1NreGxySzFFcnRkTHUyQXV1aDNmSVBJV0luV2VsMllKNHJuNjRTREV0?=
 =?utf-8?B?YWkxMXhveG1ZMkNrY2RZTXZ1MVNGZnBHUVV4VVRrSEIvKzJseGlEMTMvOWVq?=
 =?utf-8?B?L1NPSFdiZmFUTXlXODRmVGlzYTcvZ1B3ZHBkdC9iUytwT0RUV013eUp6Z2wr?=
 =?utf-8?B?SmFGb2xNSFpDTW1HNVIwNFhDNmNYSTJCdWV5OFRSV043UENUbFk5TXhuT2ta?=
 =?utf-8?B?ajlTWHVZS3ZqSzJ6S0phWWNBT0Y4aDRZSlZ1QVl4Q09mblB6REd6RFNzbXVo?=
 =?utf-8?B?eUdtREU1dWRXa3BqaEMxV3doSlNFS3pHTGFJbjBrcmRlUGp0SmZ5VjU5N0lO?=
 =?utf-8?B?SlFUNUVxbHFqQlRSK1JmWHdEenhhcmwwVTlzd3g1M3A0RjZqRzUwc2dDV21T?=
 =?utf-8?B?c2RGaEIyclQwM2NOWmV1K2gzZWdpUElWUXpYcWpyaFp0M3lNbUJKTGRvY21R?=
 =?utf-8?B?aDdrZzc0Wmw5MDQxQUdmQi93em5CSThDOFkydXFmM1FQL01oNFpYMmZrYThj?=
 =?utf-8?B?N2taalovM1NKREhQRHRjTFkxUyt0Tm55ellVUjlFSW9BUm9SQ2d6dVdiZENR?=
 =?utf-8?B?SHdDZjY3M1hYZHdDbzJMRHc4cGt0b3FBUnZNcW54cUZJUm8vbmNDcmNjZExt?=
 =?utf-8?B?d2lBWEo4cDlWTElmWkw4S1RMSWdDN1lhRHNGRE5ySFFSVUtuVmQ1N1FqY2ta?=
 =?utf-8?B?QUkxeDZtL2E1enB3cFh4d1BzTVFQUkxoSVEyVGt1UUdCMTdRQWEwMVMrTXpO?=
 =?utf-8?B?Vk5rSEMzeDRrRFFaOVUxb0VSK1h2Ty9pT25pdVdIU0oyOWRvSlZNZlViZkFi?=
 =?utf-8?B?NHN0b2pjUnBnK0FIWDVISTF6MHlsNUc1ZXoySVJ6VmRKazNVZlZNREtTbU1E?=
 =?utf-8?B?aTRUWXhWSTdHMEVQK3dWMWVSWG4rYVdIanpCNVI0K3dFeFB0eVg4TEpQRE1Z?=
 =?utf-8?B?MUkyVWVDM2IwdFg0a1d6d24yUjdsQzZNdEtNUDg3SlYzTXZhd1hBNm9oRVFW?=
 =?utf-8?B?bmNvcW4xL3Y0RDAzZFIrcWpXVk0wazJTQzVVRmhWWEVkSmgvOHU2QmZOS0xZ?=
 =?utf-8?B?ekk3MnhoTnVUQ0NKOTlpU01QRnlLbFQ4UklNKzhFb1d1anh4SFZ6dG5jZTF5?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17059983-56cb-40cd-e57a-08dd7e802d83
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:51:54.3496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmI0nEfV+DA/ra6ZR+atM7+XqnWdNBlwcn545xbflhoXjxe4bQtslv+QTkD56pEPd6EhvZsZZ7QcBNMYDion68Q+PM60SvygdhZak6FPfZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

Hi,

On 4/18/25 10:19 AM, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Same remark as for the first patch in this series, are you Maks? If no, 
we need your Signed-off-by too.

> ---
>   tools/zynqmpbif.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
> index 82ce0ac1..76b7a35f 100644
> --- a/tools/zynqmpbif.c
> +++ b/tools/zynqmpbif.c
> @@ -226,8 +226,10 @@ static char *read_full_file(const char *filename, size_t *size)
>   	bufp = buf;
>   	while (len < sbuf.st_size) {
>   		r = read(fd, bufp, sbuf.st_size - len);
> -		if (r < 0)
> +		if (r < 0) {
> +			free(buf);
>   			return NULL;

Shouldn't we close the file descriptor too?

Looking at the code a bit more, it seems like we should be closing the 
file descriptor in other error code paths as well.

I would recommend to go for a goto: instead.

e.g.:

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1a52..0b82f349758 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -226,12 +226,16 @@ static char *read_full_file(const char *filename, 
size_t *size)
  	bufp = buf;
  	while (len < sbuf.st_size) {
  		r = read(fd, bufp, sbuf.st_size - len);
-		if (r < 0)
-			return NULL;
+		if (r < 0) {
+			free(buf);
+			buf = NULL;
+			goto out:
+		}
  		len += r;
  		bufp += r;
  	}

+out:
  	close(fd);

  	return buf;


Then, another patch on top of that, which closes the file descriptor for 
other error code paths as well, e.g.:

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 0b82f349758..81ca9cc7844 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -205,7 +205,7 @@ static const struct bif_flags bif_flags[] = {

  static char *read_full_file(const char *filename, size_t *size)
  {
-	char *buf, *bufp;
+	char *buf = NULL, *bufp;
  	struct stat sbuf;
  	int len = 0, r, fd;

@@ -214,14 +214,14 @@ static char *read_full_file(const char *filename, 
size_t *size)
  		return NULL;

  	if (fstat(fd, &sbuf) < 0)
-		return NULL;
+		goto out;

  	if (size)
  		*size = sbuf.st_size;

  	buf = malloc(sbuf.st_size);
  	if (!buf)
-		return NULL;
+		goto out;

  	bufp = buf;
  	while (len < sbuf.st_size) {


> +		}
>   		len += r;
>   		bufp += r;
>   	}
> @@ -793,6 +795,8 @@ static const struct bif_file_type *get_file_type(struct bif_entry *entry)
>   
>   	if (read(fd, &header, sizeof(header)) != sizeof(header)) {
>   		printf("Error reading file %s", entry->filename);
> +		if (fd)
> +			close(fd);

Fixing a different issue, please in a separate patch.

It seems very wrong to me to close a file descriptor in another function 
that opened it, is this really something we want to be doing? I know we 
already are doing it, (a few lines after that, close(fd) is called), but 
should we "fix" it this way?

Cheers,
Quentin
