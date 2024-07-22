Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E9C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 12:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224AC87C86;
	Mon, 22 Jul 2024 14:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="cJ8oNIYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D89874AC; Mon, 22 Jul 2024 14:54:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AAAC88363
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 14:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDQvxXhlijMDBl+QaQnOeAum/BWJ9zrNiMaoM9eqvZi0V6iHUtWw8zkSH9VbduWj5UXdQ+41wNoRQ5Za0iHfi4arK9HVFOraq7PV3NosmnDHtyH/5at/7SrYiIFux9OsOCMekm4zhOnumf+hOp7HWvvIyPbqfMWkGeoC3AMjaaUoHl0J6zJzH6rvhyoL7Z/FFxDiFigbpzSL89o5pfGx8LHo2CBg3R/shx49pb2ypG28u7hPSB4J7OtaFSbwKgPQwbvpDbW/2tFPriU1Pcn8hoI28pCO/hmnjnSvgU95dcA0CaEqTuzpcNBfPhXC5PGYjkvLwmwJtAcaGL4QWQUkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTGyOZJGmukIS7+2zmJl4fUPO/JlmXkUC7zWaoyc0zA=;
 b=bsRF3NydJUIgZR0KloYw4D4/GBizPlzUs1NCNocOklDf97mq2i/NVb9NzTBf2kPeKAA1ekaWy7zmBzjFh9ZUgUAZTOxOR8Zi95EngW6J7NIt2ymzfNhaxnFLHhQLcEcs7Lzc7dOUAQ3MnZ0x9SJ36aCZojjgpZrdSptYVpahWtpUdmOxqlmTxcuvL4zy+i0bvqqkJFtRBgNO2Aex/fqcWZAjVuLg2Ebqg0uHjZc04F7+HU3JZw1oGLsXXXU/6iaAVbVl4Vwwd1EbPVnhLA2QI/T1Qiu0Yxuk2+zJgetZ3uKtkGMRsGUnm6FJtFwSTesfAad1aVD+vQxiuKdQGN6aAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTGyOZJGmukIS7+2zmJl4fUPO/JlmXkUC7zWaoyc0zA=;
 b=cJ8oNIYfnz3vmPr5JK+otb5K5Jbi98r8s8jtxbLNZNUz3ybBHwjSExeZ+0urNoikomob5QNrfIdxGZNI/P0n7skyQ7fbWg1fxvtEPnDsJV9C76WNqk+GEZlaDrJBtvmbBeGlRPlRprnjc9kSPM7gfxTvVW6t7lCT0cVRYFE2/mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB8702.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 12:53:59 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 12:53:59 +0000
Message-ID: <e13430f0-9af2-4efe-85e3-a941c20a736b@kontron.de>
Date: Mon, 22 Jul 2024 14:53:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kontron-sl-mx6ul: switch to DM_SERIAL
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240720155400.3576137-1-agust@denx.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240720155400.3576137-1-agust@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 198de4b7-4055-42b8-1544-08dcaa4d5af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzZTQ0tqMTk4ZWcrZ3hhQThKZzd1ZzJhRGpreStqamo4ZFRFa2djMzJVMDZL?=
 =?utf-8?B?QTNZZTJPR0lQMktXSnNNK0JMYmV0R2pPZ1JVcXZzNkkyQTJUMHNuSG42WUU4?=
 =?utf-8?B?MHN3TmNacnoxL1VxMHprUVpNRGFHMkRzM1VMU1pzSHhtT2tBcGFDcXd4YlJk?=
 =?utf-8?B?SjE4bXVRQzRXaXNhTXZ6QWxwS3daZ2dJSDBtd0FRQ2xXcy95ZjRiTlkrMFMv?=
 =?utf-8?B?bVQ4OWY5UzZaejhOTm5NVFlpbFJRRkhLSmQ1TFFScDZZK3JaTGpkVnJYcUNx?=
 =?utf-8?B?eE5oaFJBL3M0Wjh3T3U2cXNQMDdnQzF3Mmt5WGgwUlVqcjJHMTdoOTJKVENu?=
 =?utf-8?B?UXNCd2YvZ0pTazFhQTVNWlJvb3dSaXhYU1RzUDlZY3dWWXRpTzFFUWw0aUg0?=
 =?utf-8?B?L2RGKzZ1UFYvcUJuVnNDMVBZd3l3V0ZWd0NjTjlSNjFKU09MTDlaaU9GS0Vu?=
 =?utf-8?B?dGpsVjBsUlJwcThLNGxzS3g1SStxQVBBZTE3aXJHTVFtNGxveGgxK0dyNHNE?=
 =?utf-8?B?N3RURVJ1elg4akdqaXZ1d2VwdDd3UVBzZGtlN1A0c2MxQ0lBU2VXK0JKUXlo?=
 =?utf-8?B?aEp0bFp3ZzlUeXRmNzJzYkh4K0haZS9OWGFNQnZkRnhaK0Vmc29lMFE5SFcx?=
 =?utf-8?B?SHVpalUzdlFUM3pldkROSHVteFF6UGl1LzFGRUYyb0xTa1MvN2pKTXNlK2xr?=
 =?utf-8?B?aEk4SDV3WTRZbXE3ckJYSE5kSm1odDR0Y3pqbUtPakgydDBVcS9HdE1OZEtp?=
 =?utf-8?B?WTUzVnhUMVZvUXpCRm1RSGpYaE9hQktxandHdDNHaDFQT2tDSmR2d01TeitZ?=
 =?utf-8?B?WXFZcVdkZXZIOGNMKzd1TnhyMTAvSW5oTm9kUzB6eGttOGJ6SmlwVytFZnpC?=
 =?utf-8?B?YUFiNzJkOUI3dTNBQ2YrSjBjSEZzU2lRcVhSYkpYUStZbi9SeGNzTVh5NjN2?=
 =?utf-8?B?ZW5nbTl3aTE0NXZuN2ZPZVU5RFo3WnpiZ2NHTmdpNXdPblh5VjJiYW5ObW1V?=
 =?utf-8?B?S0tuV2lWMW1YWEVOeWdoZXI2OU44VHJwODRKU2dyU29iQTIrWk01ZU5UemhB?=
 =?utf-8?B?aGZDSXJwTUhUZWZoSTl2aWpnS1JCSmFVZVIzVjEvM0g4ODdZVGQwTm5udHVq?=
 =?utf-8?B?RUs1WWI3VEg3ZnRGa3ZKQVlzZ0NIa1dXRTlsenE1V1VoTlFqUkFSUU9rOTRL?=
 =?utf-8?B?LzNFR1ZOaC9SSDV6aDFHUHNWOU96bWNyOE4zdUlFOE9WbWdGL2MvRnIxS0VV?=
 =?utf-8?B?bkNYbVBoUHgzVDRUM1JxOXB3RmowY1FJbFVYaEpyWW16cmpZcWx6V09yNzhS?=
 =?utf-8?B?TUdHVU9JaHo4Tk5USVkvR1BaTm9aZnlNNEtrMlZ1amFLSkRKd0lYYzhjMkdz?=
 =?utf-8?B?OWJNTFI3NXZMNUpkbUdUMFFadDhaTFl0VEpvZ2JjeDRWc29xZHQxQ2xZVnZQ?=
 =?utf-8?B?NWlqaFlhK2NkNjJVR1BVVllOa1pGR01TNHM2VmY2V0dRWHlZY2VDRmZIM3hq?=
 =?utf-8?B?a2owS2R4TmhwYVVhUnJidXZmVnhKWU9PMG54eGZBNnpxd09PV1Z4S2dPM3pX?=
 =?utf-8?B?THoyOEZPWUtpMWJtVWtVSlcvNHJtdjVwNC9uN21TNDhIMGVJSEYxdlRkcVpl?=
 =?utf-8?B?enlOSEo5SkVnNGhFK1NrYisySzFMMEN3amI3TDcwc3ZocFlJckRMajIrcjVu?=
 =?utf-8?B?T0p1Y1gvWjhLTElWUkN3eHNzRk5lWjZ6UGtXdTc3VzZ0RWt1NUVQVU5WaGh5?=
 =?utf-8?B?dHpUSnN2aVJHME1FRlVacEhSbG9QWFJEZmFwcytpczlWcjgwYXdYazBwNENy?=
 =?utf-8?B?U0FseTNMK3VYTTFkS1NsZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpwNzZTczFHaFdNVzhQNXJrTVE1TFJRUTlIM2pScXVtb0xpRWU0VzNrVnhP?=
 =?utf-8?B?ZFJ4NmNoZzVQUldPcm1TWUxoVWV2OTRkVjg4bStiRFJRc3hhbFhhbmVNby80?=
 =?utf-8?B?aXdSZTZyaE5RS0FwRmgzNk5RVk9idy9PbzZENExxVlNuK2ZaS1BYMGRra3JD?=
 =?utf-8?B?SmdiR0llMFowdWtCZVdaeTBCRnkxWE12R2Iva1hWVlQzbXhkTFhVa3Fwb0ZS?=
 =?utf-8?B?NkFFSC9XeTJRRmorRTFReFZycTdRc0ppWDBKNjRTdHdpOEpNb1RhdHFucUU3?=
 =?utf-8?B?Wkg5OTJ1NDVsd0xEWDBoZmt0NkJieU1Mc3hRcm9teElGRWwzOG4vZ09NVjc1?=
 =?utf-8?B?eUZkOXVxQjlqVzRSMm1zN0RzOFN0R2NWeTNQb0M3MFlGQzRPSU1CYVlIbHF6?=
 =?utf-8?B?UGlUWlZOR0hoYjlOL2MyMXdoY0lkMmEvQUs4UyswZlJNeHVMK0djNmZaSzVu?=
 =?utf-8?B?Z2NheG5HNms1cG9JNk1RdHFtVFFqWWZUQU1rbnBkK2l0cGVaTFJmTFl5Mnpj?=
 =?utf-8?B?cUlOWUZxeFVZVHowQ2h4eDZyczFVbXdYTUhBRWRGdVpOVFhmd2M4clpCelN1?=
 =?utf-8?B?ZUR5RVBmNlhHS1JYVlYyeXo5ZFF4blBIZHdrVGRaRjhMVGFJZGRxYWpyMGx1?=
 =?utf-8?B?ejBLU1pCM3NQZ0cxNENyV3Fkd0EvaE9USXF2UEZFS0dwNkVxUFgvbE84KzhH?=
 =?utf-8?B?QnFSeW4rUi90cHJpdnJrd3VqQ2dDVnFyZjRYWUE3aWhRQ2VmMHQ1ZEwwSXYy?=
 =?utf-8?B?dU9vR0Qzb1BXTEcrQjJheU0xeGt2bURRck5UVkJONUViQlBpRVNNSE9xUVZz?=
 =?utf-8?B?ZU00Z3FGQWR1UjlMMEVhU2p3ZUZuMXRiSzR4MHFFNDV1Q1Y1bm5jdHJJQy9q?=
 =?utf-8?B?OVQvM0lQL2VvRE9QUnVacDd2cW9VVi9kOUsveFdYbFlZc2lFYUpUa0kzUXlU?=
 =?utf-8?B?aW95Q1dZQVlTVldocGd4TWVqazhjWHZuUURGRy90TEs5MDBwdzEwVGlOZ3U4?=
 =?utf-8?B?YmFHZVlnZkpHLzcyR0JYcmRFK3g0Sy9jcXZFSkRCNWlOd1g5aGxxN2xYamNK?=
 =?utf-8?B?Zm1zbFFQdUFoV0VmNnJZbmV0dkVRbHhKa2tVU0xGZi8rSWV3OHh3SU5vT3Vq?=
 =?utf-8?B?MlJ3bDJZOEJyVXZ0ZGhGdmlvT0YraGtZZmpuMW1pS2JKTm44VEtDNU0xdXVs?=
 =?utf-8?B?SUtNem1ZTkVGUGs3Q2xGRi96WDdNSGE5aGNjZ21rNGhDNVI5NFhzTkg3TnJX?=
 =?utf-8?B?YTB1VzkwWHIrR1VPREw2akRMSmdxVkY0aHkwdmwzZ2gxTStrT1JIRGFEdVph?=
 =?utf-8?B?OForTjg2SGkwVEVPcDJ3Tms5aUdpQmRWd0w5YW5MazhRdjIveis3cDh0dy9o?=
 =?utf-8?B?R0pmUDlyK29ndGcrUjFnWFpoRGhuWTBveWZFNUpvV25yY2hXTVVOTXB6UWRz?=
 =?utf-8?B?WWZBU1RySnEwZWRUWkkxSFJpbzI4VnlGZkRpdm13TlVyZVBRcytYbmRVS0dO?=
 =?utf-8?B?QUxvRkdDb01hRWp4Qld0RlFDQTZuMlFQRGF0TnpBWFdUTFo3R2IvRXFBWklZ?=
 =?utf-8?B?T0J0d0pMT2ZLOUFjTWJUTXVNb2x0S09Sa3pqV05EV1pzQ2N3NGpEdStXc3RG?=
 =?utf-8?B?NzNEUUNvRFpKY0Y1K2Z5MDJlV1BadVhQMzdXSmRwQ3ZseFQ1K2dqM2hESWwy?=
 =?utf-8?B?ekpibHJYSG13VUR4S0MwVkhKcDhqckNya1hJeERiUCt6TGhsVTdpUHBnb01t?=
 =?utf-8?B?UFdLV3BuOWZhN1RRUnF4L1pLSHB1VDlpeWNzZ01PVHJrR2k0c21JTzdHMVpV?=
 =?utf-8?B?b0N1VDFCdEMvRE4xTHp2YjFST3pMdWVhWGhMSld3ZW9WcnJaVHZ5ZkFqQ0ph?=
 =?utf-8?B?c2poc2ZtVmdYVDJIWmRPSmdGdk1Gb1hWWUdIdzdtRG5tc1NETVoxR0RtRWdn?=
 =?utf-8?B?czFZWkdiUnRReDJRd2xDVTMvSDBoVkk4aDRnM1ZKaEJiWU9PTDdTZjNVN3Bk?=
 =?utf-8?B?RUJuSUx6d3FTbFROMk1iQmZ1dXdRR0g2TitEQTExTnVWNm8xMnFqSDNCRnNi?=
 =?utf-8?B?Q2JocTV1ODJObUZxc2VoRXl3QlZ1MkYxWHk0WEhNdGx4eTVIQi9jMjRhenNv?=
 =?utf-8?B?Z25KZVpDc0lOSStBcG5Xd0Zib2Rjb3JUQ2N2M0RPN1oyOVRNdFZNaUJpeDB1?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 198de4b7-4055-42b8-1544-08dcaa4d5af6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 12:53:59.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTtzVYMUNSiljk3zeHtmQZSIkKvwVohREOsAvUdlxkAHyjrRYzYEZLJKBeS0v72isecU1uvaNzs/BcJZbjf+AgQHXq9MAN48u2ETsbRnTm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8702
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

On 20.07.24 5:54 PM, Anatolij Gustschin wrote:
> Enable DM_SERIAL to avoid board removal warning.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  configs/kontron-sl-mx6ul_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
> index 12d96b674c..f295ecfe4b 100644
> --- a/configs/kontron-sl-mx6ul_defconfig
> +++ b/configs/kontron-sl-mx6ul_defconfig
> @@ -90,6 +90,7 @@ CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_DM_REGULATOR_GPIO=y
>  CONFIG_CONS_INDEX=4
> +CONFIG_DM_SERIAL=y
>  CONFIG_MXC_UART=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
