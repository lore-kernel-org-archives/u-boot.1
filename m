Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A41C83030
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 10:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4EC88B59;
	Thu, 29 Aug 2024 12:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fx+HNrFr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C58EB88B64; Thu, 29 Aug 2024 12:21:52 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E086B88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 12:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpUpgsYgyCm0STv4uuVWg2EFzXtMiOIczDw70sN1S3t6ZoOoqcNZNkdEbyN79u1Kyuqq0RUe510lAo7AM0LrQOt4ZjQ56xGczbw4lFP0AwVo8fqt/Ue9Xuyg2G5LxWVAdoae6MCOVaR9HJTn+0GEdUiK84IFRRqDVmow92ckOw+L0RNUM5kIh2ZhV2E/MjSla71yTCQ4emQid/7URmFGl1H72CAhYcUY7SPrkoxoyi56QMgM2uEyj9/lZXPMB0Sb5GFir7jx25VPgHe6QXbuxN0AEfyM5wqNcmTBgj0FE+smQknT9l+GnMgZQIxb2R156NDIUXiGAYH479S9wKaYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFqZFRL1yoi3oV1Y7RP0vlFZSvZlKss7jbBR4XsBNbA=;
 b=XzsJdUCdovoifprcXQCIMTR/WTXdV+eOICYsMDz6bAgAIQyLMey+dlc3+Sg2kshkcXgAbyDXTd8aToqVd3L50BTHVoFB9z7utuCV7LHLplEE2nAVk4O/SGFFgRBS+Jtn0a0Z3EfEJDaswudcgusiKl/7NHehIw8nlc2g7JaGJFLS9kzBHP3JZtqSgv1X+jTbM260a0BMnZiS6duXDB/XrkmT484xbOnNPxzGVRZIlkkwbJGfm43CDRcQd5hI8zQU8mE0XhGoX5IFIzKFDe7ErZwBGbAjlZVInKV2jm8T6xi8vHrOQFtig8EZQm/rv96jD+8J0cX5137VuWlGAVjAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFqZFRL1yoi3oV1Y7RP0vlFZSvZlKss7jbBR4XsBNbA=;
 b=fx+HNrFrdf2hvOrqWeClyUSSL+nh3mf8C3OHaZlPh0p4oifNEjgHLOZeEy0zC/pTpqRRTOz3mLyKwDSTeaRvXDcGYwe6gd6nNzUmoENTlb4FtjInzB99ItlHAa/sPiuW4lzesfLJ7GQ1tmmDOtvss7f835eT3RZpUjhU/JWV8Uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 10:21:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:21:49 +0000
Message-ID: <72e6e223-4b9e-4376-8f7e-21a6b0faf922@cherry.de>
Date: Thu, 29 Aug 2024 12:21:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rockchip: Kconfig: PX30: Weaken dependency TPL/SPL
 serial
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-4-lukasz.czechowski@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240827142058.594556-4-lukasz.czechowski@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: eff8674f-a0da-4054-41e8-08dcc8146460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFZOL3FwbjBpbTJVcnk0cmVYSGtBQ1RvaFN0eklQbUo1NVgxNDlidVpCOVVF?=
 =?utf-8?B?OXpudUhuNEh1bzlWL0tEOE4xaFB6dDF2NlRZcjNyUkFuSTU0bmdwcWZyYVRX?=
 =?utf-8?B?R1FIbDhiYWdtVjFud1hOOUpuN0hBbWNUOUpENlFIaTROcjVZOXc0WkRudGVO?=
 =?utf-8?B?UEh1WFJyWXV0em9GR3RkQ3dseGRxYkFRWXM0Q25NT2NKekltdzllc3pNU2k1?=
 =?utf-8?B?alVWcVdVc0EwbS92eE9vZjg4TFhkQXdmdlRzNVdvcXl0UVBUMUFCL05LdERa?=
 =?utf-8?B?SUFXL2xNUHNDZlVRMXQzUHJZM1JrcXpQLzNjMWxFVGhaR0VjMEl4ZUEvUXB6?=
 =?utf-8?B?TVFpc3VjdzNJNWk4dGxUQU42SU55TDNOUzVML3lkYWUwSWY0UWplalhHcUtR?=
 =?utf-8?B?YkFMQnNyTmFwbE9PNkh2YjhDOGpWbnM1WlFTNGY3NE1tMVhmQTA4OENGdkRy?=
 =?utf-8?B?VkdiN0hEUjRhTkUzcWQxa3N4OVh0NHpTMG16UW4vY3BZYlppYUVFd1loeEhp?=
 =?utf-8?B?Z1pZS1FKYmZZNk5kRXJxbHdjQlMxN0c1UWQvcFBJc1hZMnBkWVNVcHNqT3F1?=
 =?utf-8?B?RFFyK3FTOUg3blNua1UzU01mclVYUkhXMHFKdHVtbHN0YjlBT3lBOEZtRUd4?=
 =?utf-8?B?U3JBcTEvTmtUWUt2VEgwQ3hNWXVvMzhyRnREQ0syUXB3d3puZTVnZXU3Z1Nr?=
 =?utf-8?B?ZW8xK2VLWTluc0xSb1owQUxaVWowMVNJRGtLeTEwRWIxOTJQT1lUVzdiUkhJ?=
 =?utf-8?B?V1ZSdzJGVXRBYTMxN2d4dXJsUVYrZ0JwKzRnRUpaVGxFZXB4bHR3VFpjY0Vy?=
 =?utf-8?B?VjBYZ1VNZXg0NURRQnFZM1AzK2lwZlRSSHpzZTQ2QThDUFpwY1BoMzVYaTNY?=
 =?utf-8?B?Y0VVY3pSb1h3NERQR0kzSGp4SnNBWEEwNWN1NkNOTWlsdWpBWHpFa3EyTGFJ?=
 =?utf-8?B?bVZSUThQZi9KV2thMVJTakNyWWNGb1AxV1FCTkxiMUxwSlM2YmFTZGx6OTYw?=
 =?utf-8?B?NCs4ZE5vcnpvV1NqRDhHQjBPcXZDSWNHeEtDeG81Qk5vY1pxMEtVUWZ0cXpu?=
 =?utf-8?B?dGVOby8vZ2MraVltMHY5aGRRZDJ3TmJlenh4QWFoeGFDZWxZbGxlcGo4UWps?=
 =?utf-8?B?R1FFRUF4Z1BUNitIenRRMGxWWm8rNXZSTXA3clEzcm9UdEpoRjcwcmt6dWQ4?=
 =?utf-8?B?ZjBGa2ZYdzl5cVRsNHdpMTV6NzU3TDNmd3pIbzU3UGNMSW5iOFd4eTBTZ3hx?=
 =?utf-8?B?QVNVc2tCZVk4MkVjdDE3VzhQcThNcW1BbTlsbWg3MSt2d0pGaFVaUlVsbnRN?=
 =?utf-8?B?b0ZvNy94N1FpaGJnSllOSEhPZS9WMzRXcHhnZG9Zd29zamQyWW9vRUFnenhi?=
 =?utf-8?B?UFM0Zmpic1lxcDNmMCtEb2hSWXV0WE9IRFRud1o0NkZ1VEtweW5BUFFFZ3Bm?=
 =?utf-8?B?QUJYWFNSdzE5TmV2WGE0Mm1GODBDelduTnpjcngyYVV2LzZLUDBjQ1VVRzBZ?=
 =?utf-8?B?S05OcE42dGJSVThwdUhXSmJIVUQ0WTBnenVqYldIbTZKR1owN3JBYldjSjlW?=
 =?utf-8?B?MW9YK212Z1NFTmpVdVgwREZ4alk1ZmpqMGhWTWZYaE15VGFIUWI3SWtHZVBU?=
 =?utf-8?B?cDIwVGNmOFFSV1g4d1FoVHh3UlNHcjBPSEZZQWxCNDZOS01sQ0F5cUNOS2ht?=
 =?utf-8?B?elpaNzdtSm1KWllQVG9SRlRmZ0NhRGZ4VTYySWpPb0ZTYmhubkJBUFdBZzZQ?=
 =?utf-8?B?cGRHaFlsZDV2ZmZUUE9Yd2o0UVAvekF3MmxUSGZwSGZwSEdhTm9ueCtaZjA2?=
 =?utf-8?B?Wml3NnNrRFBMR1lSS0thZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDlyNlFmYlJ3TW9odVpZVWFNM3pXcEFiYi9nSEZuN3o0VVNsdkFMd25tQlV5?=
 =?utf-8?B?dWNQbXY2ZUtHaW9mdSs4emtiUW1uQ1VDM0F6MXBYU2lMSW9tb1c2aXZjMVZG?=
 =?utf-8?B?UjNCODZ4VEpuVXIrWVUvNmo3L0Z2WDBBOUUwNDgxNDRIdVZhMEpYa09ZYWFU?=
 =?utf-8?B?SWE5b08xdWJsUktLbXArY1dyS0dCa3g1OVIrbnppSEF3VDBOdW5WdytHNXV3?=
 =?utf-8?B?Ui95Ym9qVXZNc2tIRldod2JPOGtlNWJEUHN0eU5MM1FUWGk3YktlOVZPZVBs?=
 =?utf-8?B?MkdXTXIvQjJhM1owci90V3cyZXo0Mjd6a2Y4RnlwVlF0OUlwY0hOTjYrMlBX?=
 =?utf-8?B?MGtseDZrTkZLZnRLcElrTE92TjdZZUYwS1pNcStCaXFUSlUxbUx2ejgrY3lB?=
 =?utf-8?B?NWdocnVEbUplMkJGbERXMGVMa2dXNEw5WERLMTF0MmhYTnBzcEpFakh5T1d6?=
 =?utf-8?B?NHZYQUdHRFg5SURYZFNhMXFTa05JZzZKaWwrSzBaODFqWXdsSmZQSEJoN0Ey?=
 =?utf-8?B?NXcvVWEwMVJvZUh1OUxlTFI1Mnh1VXorcDhGY2hOcHhseDhxUWVHVWJjL2R4?=
 =?utf-8?B?NXh5cHVEOXZ2b0lnaWFTY3F5WU1tWHY4UFN6a1IxTVdYcWo0UTZVTXBrOXVz?=
 =?utf-8?B?L1pDbitpL0FyNmpQWGRPbFNGSWxTQzdxaXVibWswQmp0U1VyQmVxSkVXYmJ3?=
 =?utf-8?B?QXZNa2Z5L0p2enZyWDR1OUFTaWlZT3VWSnk4S0E2bUdkdFllMmhLRk05enBm?=
 =?utf-8?B?MSs3aWRWVTI4eWpsek9KWExkODVXVXJoSG9QNUsrcURGWkFSeFNFa09VS2dm?=
 =?utf-8?B?ejgvRkN1cThmL01UVWVuVzN5dFM5cU1LN0dObHlyQTJHVXdZMkgwVStzWmtt?=
 =?utf-8?B?SUV5VlVyV0s1QlpTcmZDVCtmemFiWXArN2ZYVmlCK21Za04rTGJ6SmgvUnlB?=
 =?utf-8?B?UGtQNml1OFZGYlJPRjFjM0VtZGFLcWtmNzVsT1hhNmJVTmdWOWx2eml3a2VR?=
 =?utf-8?B?U1JEVndJSlQwRTJUSXRMZkRmVnlwazNUSVdvWHY0ZFEvZEVKNHVCV1NZLzRq?=
 =?utf-8?B?ZmxGcHpoeml3bUlUanZCaWxkKzZPWGtKWmN6NjNZcDNVbldxamo1SXhqV25w?=
 =?utf-8?B?T3B0ME5hMXNYeUlLeExFSzVZMW9LUjBMcUxmczNGckxsa3dWSlVWK0llV3Rm?=
 =?utf-8?B?S1R3NThyZzJnN1ZDYUdwajU0UjFOU1RvOFR1UVlwVVFTNU5nS2hBTEVCVjI0?=
 =?utf-8?B?VDI5SWRUZGNUYXlXVUpTNk5wQTNWTlZsMzNITlc4S1JlNXVlZExqWElaa1FU?=
 =?utf-8?B?OWpncEVVUjJsYUFYaTA0bEJXQ2FjdjJmRXM5djRoVy9KM2tiNWRoNVorcEh5?=
 =?utf-8?B?THBsUXQyVjVQUHZtR0dSM0p4U1p2WXkxeEhieXQ1V2txOFEzb0JTYjZmRVRa?=
 =?utf-8?B?NFlBem9kcnVwNytmVjd0Y2pMV1llWm1ndzhUdURiemNHZnJscVNkK0NqanRF?=
 =?utf-8?B?MmZkQ25rWmVLU1dKdHg3Y1ZTVC9ENEFpRm9DMGRuU2JDMEVYTGQ0TlRhdmYy?=
 =?utf-8?B?LzFTS1c4bS9KWlptTzNnQkxoZnZzdE1pYzNvTFQzS2pqekkxRStHcjlCNHNo?=
 =?utf-8?B?YUJZWDFpNStqN00yQStpOTlUUWpLYTc3T0FRNkRkcFZjS0FxRGRIUjZUR2dW?=
 =?utf-8?B?dGwyMklBck0xdzdDUkxoUzc3dVU5L2pWby9GMjhJYk9Qd1pYL1B4UEdDb1R6?=
 =?utf-8?B?REZ5c25pcUxScktsMk9mcG5OOGhRdXpndDZCb0pTZEFCNGhMZG9MNzZlMUo3?=
 =?utf-8?B?VjRDQS84am5yREtDaXVTY3dvelUyQkd2VHdUdTZoUGUzbjJqMk9DRHdaQ0xp?=
 =?utf-8?B?L0E1TWk2RlF1YVUrRjNFWjFnSUFqWk1hT0pJUlFYbDliZ1hlUWZhNzFjdlVR?=
 =?utf-8?B?NmVZTXNGMkhoRzFLZ0dkVjlSc0ZOd29KY1dUbFZJZ1ZzUU9tbHlyVDBiVFBC?=
 =?utf-8?B?Z3J0Z3FWYWtkZWFMc3U2N3YzY2VJbEVXWmVyYUFkTHY2eGdKbGg1d1hWUFZN?=
 =?utf-8?B?WC9OSTdoQVRDSkdKK0ZDMHkvT1JYOS8wdXh0YUpGV3hqWGdrd291TXJmWVlR?=
 =?utf-8?B?KzBZeld6UFRQQzNuVjN1c0RPNjFwN0kwZVRyTkJad1dyRXJ1Um9FVzJwV1Yw?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eff8674f-a0da-4054-41e8-08dcc8146460
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:21:49.5374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkLgoxpwevgAEYTv89fJT5ZBA0ZvOeCGYyF+AV/1O9C0Zra0Xyw4Cr80FAiFasf/YhxVzQng51I4PMcq4ytIj8DbGJGBRiHBcy3OPfv/yG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846
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

Hi Lukasz,

On 8/27/24 4:20 PM, Lukasz Czechowski wrote:
> Allow to disable serial console in TPL and SPL. Weak dependency
> to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com

FWIW, most commits in that file for px30 have the following prefix for 
the commit title:

rockchip: px30:

so following the same pattern would make sense.

The change is fine though, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
