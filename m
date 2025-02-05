Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D7C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7B580104;
	Wed,  5 Feb 2025 18:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c+4MG5Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F9B801BE; Wed,  5 Feb 2025 18:08:03 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C78B8003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqrj/HBgtDLUSwzSWrTZ6asdX1UKycT4OEbYEo0CV3mxDpjd++hPNt0rUrYF3CrPjgB8cACdXkot8zsoBByskm9JIPXB6kTHIIO2vNokRWiozwdvd2PrGftMB+NfgNyqBcqCHR59y+NLfu5MLe5WPJXcJbESvhmwvWiLWlm5dOVIBZ7SjhPZIoZlXIG4kNUsuuaYmsvNg2UFJ90rdgEuOoDNCEN77sV4cQv+hrOYwM/hLANg6XuPkLWp0sdovVK3EdR5Hcg8kgleILdUGixT/9MT8ZX7oJF0sXMOUT9csnkvdqBXzA9qCDbdlbtRtyGdIiSDLDJC1GhPqklO4t7OMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq0yMeY64V1rg1GVtVPxKBpNEjSF8DOFO6tEUU0exVM=;
 b=IE6QNUBO+AqHAzBJ+5sWGRHEB4O+lk9ZPgyHtlARiH51vaEukwoyp0NYydn+kAOfbDohkNI85NA3faarZIuaObgMRykbf7OQ+cz7vr0wvx0HtKlpqhN21TPj1pcZFbRKNdEvjIbvYAmK/Nh2r2nps7JzgvgBm0Ig/vS5x2BxGxMOCcs9KsDfOtrdRk+3r+nMQfah9a56t4ZY56H8Q4eMpsgARDD1biCPyCOoqyFtfOD/gOeMgAeFC/qs7MNDVFcXY6l2ewjXXYm2M/mc7ruKtEuhsA1S6Vnii5RGjItSKqHcZjvX4/hwWxGv3I7xEUVRQ+fyD8wxPG2EQAN4fCfeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq0yMeY64V1rg1GVtVPxKBpNEjSF8DOFO6tEUU0exVM=;
 b=c+4MG5RujYQE0bGae6pkIjKl22uCWypqCvxn8L4Wqorj+8WRcPICeW4jAjrV/bubMyIxrEWcP0CvfQUPDiNqxBetF8QQ72QCuhA2IWVHzjnkGr+X6DgFHj+ZZZK3Ytsn1Si77FsVTiFMZ9K5LW+FwN1wT6fiZ3bso0fnT2SNQ4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 17:07:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 17:07:59 +0000
Message-ID: <efe6dd8b-e18f-454e-a93d-53f4ea491307@cherry.de>
Date: Wed, 5 Feb 2025 18:07:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250126234838.561065-1-jonas@kwiboo.se>
 <20250126234838.561065-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250126234838.561065-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: cb730ace-fa9b-4907-248b-08dd4607a410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0w5cXBIc0VSYVNwd043SmtGbGg3dXdvU1dVc1BlU3d1a1huczUwbkNBdys0?=
 =?utf-8?B?azFUZmtOUElVZVBLMnhOeFFsMmNKRGpoR1pQWG9kSmRSZkRWZDRjMkN1eHZQ?=
 =?utf-8?B?Z3ZIbnJSMldVQ2gwZldUN2RGa1lPTVFxcURTaVVMR0ZiN0FyNDBqTDdrZWk1?=
 =?utf-8?B?NlRha05rU3VrOEtCblNSVFVGSlNGVm5Xbm5KbkxhS0duN3lzUzEySGhKTmhD?=
 =?utf-8?B?dHRtZzV2YlJXVGU5QzZ5eTRvbGh1ZERMblRZbGJHTjZ4cThidm5QRlFVNkU5?=
 =?utf-8?B?d0ZtcDQ2dit5cDRzalBxVWtyRUJyZlhzZ01VWDVHamt2K09TUG9uNjR4Nmkv?=
 =?utf-8?B?V0lyUWV1OXVnR01OeHdvWERWTnpzbkw1RmJjc0VZWWIyM04ybUFpSVFOUXBG?=
 =?utf-8?B?bkhGNzEwNEw4Nkdsc3JTZ1cwaXVaNWhaZHRUN3RpNllSZy8venhaU25tZnU3?=
 =?utf-8?B?eDJHaG02YzR2TWJwNnBqVHpCMFd5bHp4dThDSzFsYndQbE1VUWxjTTNnRnpB?=
 =?utf-8?B?cXBOZDFKdmxydG1Oa3B4TC94UEhQZE5qdjZCMy80SkFkd2l1WElvQU1zS1d3?=
 =?utf-8?B?cUtzVHhtOUhtY0VHeWs1U2VXSHJDVDdxYmJFZ0pGcFE4d1BtSHFSZ2M5VlBp?=
 =?utf-8?B?aUw2TmFPbmhoUTV3aTZ1UVRHN2hUVm0xbklQOFdOeVRNMW5mM3RWSzlZdC9G?=
 =?utf-8?B?blZLZmZhc21NcGlselhYUGZBTzJPM2NQQkZOTFE0dFRadkU3MTdzVWt1S3ZD?=
 =?utf-8?B?Q3pYWisrTEZ3eEFSMHhra1lmZjlPZEJiNmpOMWlQMjhONy9YdS9CS3RvNEpQ?=
 =?utf-8?B?MzhreFdrdnZLOEdET3JRK2l4TU92K1BUMnBab1VTcWQ0SGt3MGg1bHBzVFNE?=
 =?utf-8?B?MWw2enk1R2FabkRlYjlGbXFMZTZCek0zK1VRSUY4blRuSkI4d21paFpaeUJp?=
 =?utf-8?B?ZFQrR3lPWkM4NUlibTYwWFowS2Ftd3FhS1Z3WWcyeWMrTWhENXpzYnU1YzBR?=
 =?utf-8?B?aEZGMmJMTjBOMGQ2VjlYc0dkVUVjdlhOaUpCc25YMy9UcUhxalZDUTlWL0tI?=
 =?utf-8?B?Z1FGN3pGeEk3Q2h1T3Y5cHVsdWl4Q242NmdDdXhGSmR1Mzhncis4azEyblZM?=
 =?utf-8?B?a1hudVJHMUxjNGsxVU8waHZJUGx2akVUUENteUwwa0lENUJnK1B2dkpmQ1h2?=
 =?utf-8?B?dk1oaG01SjJWVmMyQVFhZUkyQVVKREtZWGMwVnZ2Qm01aGhueWpDc1poNFpK?=
 =?utf-8?B?dDNjdGtFTzlSdVZMeHVtRENNY2ZrSUkyVGpFbHlXMXBQczRITmVjT3VzSFh4?=
 =?utf-8?B?TUloOUwzcU9mQThMWUtwQVBoeDZjWW5sUTN0em1oek5XVGl1OVZGZG5mVWFE?=
 =?utf-8?B?NEtXQWw5VW0rREpRRzZDK01YK0U4V2E1MFkwWnpSQkM3d05UZWs3RFBZczdj?=
 =?utf-8?B?anhlaVFsN1RPL2I3Tzk5UEhRK0hhdkIwUzE0VjNjSm9OSlZqZmhWYkVzL21M?=
 =?utf-8?B?VG1wWmNIVEJNRGF4RzNmZFRsQ0xCUlZmUVBDTm5XTENnU2Z3aFkwaVZ4Misw?=
 =?utf-8?B?eTdoVktPK0JScnVQdkNoT29aMFpRZmR4TzhHUFRBWEUwNTdvZVlLU3hwVWl3?=
 =?utf-8?B?WWJnQ2V1OHZUcmZ2SVdXU0NXTFRLTTJIQnJUTFBxa1diZ1FIVmxXaGtXNG1V?=
 =?utf-8?B?Rm5WWlNyeGRiWGRPQU1rTE1CRzdiWGUzbDZxV1M0M3MzK1J3b0oxZ042ZkVM?=
 =?utf-8?B?OFZJNExhY2VYWFc3VFU0dTVSZGRmZWF1SmRVWGE1NXlIUDZ2aGRkWEFKUkk5?=
 =?utf-8?B?K1RwQm5QK0lWR2RVdFBLcVZsYnd0KzVPVXhrN2JQWXRVZUxIaEY2dVpYamhr?=
 =?utf-8?Q?8FC2G9XpoQmrE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pHclY1S3VodzBJWmZoTkxkQnYyK3oyRUJjRC9adWRpakpPTithdS9VcUJm?=
 =?utf-8?B?V3RIU1NUKzloNXdrRThJcHpicXVBeXJvWDl0b3cxaUpaTUd6S0V6RDFHdkk2?=
 =?utf-8?B?UC9wNUxqUDB1NjFPL3UxeHdFa1FlUVZrM2lmdE8vdHI3dG9vaytKSGhNeXNj?=
 =?utf-8?B?NnpBd3FFekdROGlua2NDeTFZSThKUDJqWEo1dldHQVVMM25YYXF3KzZXTGx0?=
 =?utf-8?B?NEdrWmU1OHVLQ0dzbWQ3Qm0zK2NQZm5zNGVTYndud0lENzQyN1pNZmxibTJO?=
 =?utf-8?B?RzVzS291OHVMeVlETU42bkRCNDk1TkkwR0JjQ002dVhwQUsvZEdKOWpxVmJ2?=
 =?utf-8?B?UGRmdzVsNmlnZFM5bndoYzA4OElWd3FscnpyMFhvUkxKcFNXblprTWR1V3BF?=
 =?utf-8?B?RmpUV1ErUnBGNFpNMlNRcUxnUXJ0eWZ1YUdCRGpNZ2htbFlkeER2ZXJiWDQ2?=
 =?utf-8?B?NFVkY1JMMTJyODFTUUx2NWdjWm92Wkp3eTY5c0h6dXppSi90aUZUR09EOWVW?=
 =?utf-8?B?clpoZHZwaWw4azUyRml1NDk4cFgrMUZ1cUJ1bXlPODMzZkxIclFUak80LzlE?=
 =?utf-8?B?R0ZiL3BiSEV1dzFuQWlXd3JvMWNhQnRFTnZnQ0lKbE0vdnppN01saTJIV2ov?=
 =?utf-8?B?QmR0UG1McG5UWUZoVUl5dGQ2YkpWS1VaZWNiSFY5Ym9EOURjc1ZDRWxPQWIx?=
 =?utf-8?B?VlorTWdTMTM0dURVYVFtL1dFL1p2OHdyeStkaEQwQXNoWlNRT0JsZ21tRXQ2?=
 =?utf-8?B?WXVkOHd3V2pIL1BXZno1Y29maE1UaTkwaFp2ZmZLMzZvbVd2Ym9jaUNqNHFV?=
 =?utf-8?B?SXA0aG1EOVNpL0xkV1QvYnEwdWhsZUh4bXlVZ292akdXakt6UW4rOTcyZEYr?=
 =?utf-8?B?czI3UWtzdzZDS2dxdDlTUDg1VW5PbjdTdStDbGJhcVhMWjdvZmhCdzRFRmlu?=
 =?utf-8?B?MUdHVXI4bXdqRXVBZXJNd2R3NmIzNU04WW1sZVNrQW0yaWRTVHdIRTcyMERE?=
 =?utf-8?B?ZHJXNlFJWmMvZU1lZ293WnpycjRNR0Z0TjBnc2RIYXpIS1p6ZlRMZS80b2J3?=
 =?utf-8?B?VHFtWS9rQnpkYnhEeHg5dVY2d3NBT2xyOG5uU2pVdDdRMEU5bTliOStoL1V0?=
 =?utf-8?B?VGJWWWFEZExNQUZUaUM4dlJqei83bmNINDh3ZlBXT25IbzdaQkVmbnZVcStS?=
 =?utf-8?B?dVpYWDJ1QlBRTzg5RG1JanF5WE1QTjBINEM0ZUZaYXA3d1QrLzczSFFwZ2Zx?=
 =?utf-8?B?eEt0bHZkVUNJcG5ualJ5SFdST1ZXOVNWeXk5bXI4cWQ5ZWFqZm5lN0V2VTFq?=
 =?utf-8?B?cVg2VE56V3Q1MmQyVU15QjF6alZBMkMxVGpBZDhqei9sdk83SHpzc2d6Tlg1?=
 =?utf-8?B?MCtqdy8wNVAxYmVFaEN3R21pMXhsaU4vUjAvRXFSblBac3lvSWRZZWJFNGlE?=
 =?utf-8?B?blcvMVlFbGRvY1QvWUpMbUIyb0Qxdk9CRU9jc05sTU5KZk9rbHV1TXhYSjRh?=
 =?utf-8?B?UVBRT00yclJ0d203dzZSK2tGTlNRK2dHMWI3Q2M0NGZWdlNYMGxqNE1GT284?=
 =?utf-8?B?NlJMUXNaTlV1Y2lwWFROcHd6NEY3NlRkWDFMZzArczNEMWhuZUJ2ZUV1eVlK?=
 =?utf-8?B?RndJSnVRY3JQM1NpTk5wWFhwMWw2M1FpK3o5dGI4WER3NS8yYy9GejhVODN1?=
 =?utf-8?B?Vy9kc0xEQlNiWFpEQXAxQlp0VVVaYVdlT2xjK1BnT0ZiTDM1QUlzTlRKSjdE?=
 =?utf-8?B?dmZxQ0pRallMTFNqekhuQWt3NEFuSXEwRFZrU2NGd1YrL0RYVGpXb0lJRS95?=
 =?utf-8?B?L0xoVGhLckFpeVlxU1VwV3dDbjE5bjRCWlh0ZTNsZlNSU3ZCNWtPWmoxTFpE?=
 =?utf-8?B?enJFS2oySGh3ZTkyaXY3elR3d09aenRUcnpjMDF2dUJuZjZMSGMxZCtCWmhL?=
 =?utf-8?B?dWtNRk9jdy93aFhyVC94Yy8ya0dybHpHN1FMWTdHQWlvRnRrc0FMb0M0cVhO?=
 =?utf-8?B?aHljUjlTeGJiNGR2b3RGMmlmeGs1UlNzQ1JLU0lPbWxjY1FVaUlBbklBQldD?=
 =?utf-8?B?M3JzWTZWdWFIWGI4RzUveWtPQzk4NFgvK2dsd0pYdzF0djBJOTBPZFdvd0Nx?=
 =?utf-8?B?cFNJOEVyOGJtQzN6MVR1U2I5WUlud3Q1TlQxb0JOVWdlSlB0SzNEdWErS2FH?=
 =?utf-8?Q?B8/K2jV7pDC6cmJ6yiPDI+o=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb730ace-fa9b-4907-248b-08dd4607a410
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:07:59.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ro0NM+xfy82DXT5m7tRkt2JS1eg3IViXixwIjCX6xTvNeQBam91HourmmSe/ayDDWIX6TyWi85zDU3jhMcxfi34Hk+4VfSf6HpbWRb8JNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368
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

Hi Jonas,

On 1/27/25 12:48 AM, Jonas Karlman wrote:
> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of

Are there known exceptions? Among the list you provided I see RV1126 is 
missing but is ARMv7-based. Is it an oversight or done on purpose? I 
couldn't quickly find the TRM so no clue.

> the more common 0x0 DRAM base address used on AArch64 SoCs.
> 
> Add default options that should work for these ARMv7 SoCs. Same offsets
> as before are used, just below 64 MiB. Hex values have also been padded
> to improve alignment.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 5aa9e0f1af3b..da20d3233fe3 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>   if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>   
>   config CUSTOM_SYS_INIT_SP_ADDR
> -	default 0x3f00000
> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000

A bit sad we cannot do arithmetic here in Kconfig :(

>   
>   config SYS_MALLOC_F_LEN
> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config SPL_SYS_MALLOC_F_LEN
> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TPL_SYS_MALLOC_F_LEN
> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>   
>   config TEXT_BASE
> -	default 0x00200000 if ARM64
> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>   
>   config SPL_TEXT_BASE
> -	default 0x0 if ARM64
> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108

If applicable to all ARMv7 SoCs, maybe

if CPU_V7A

would be more future-proof?

Cheers,
Quentin
