Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A608C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07F9881A2;
	Wed,  5 Jun 2024 11:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YoMSMIYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69656881A2; Wed,  5 Jun 2024 11:25:13 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB9F831A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnX8Nsv/yZx1HccyNEHCfS7hCZu31EN2mS4DBG3A5mxxKQvku0568MUDY6KsCjQ5zq8+YJCikEJUHEJvupzERrdjloVZ8iPvH5H7dEfoat4KQ29Jz+AF9keJ3rb0IaxfZPSqL60TCBhPAiDusGjzoVl86++fy6arxdxbmHe2maZvONXLbEDBxiLGJ0WyRh3Os2Dhv2VdMMxE+KteeMdc30+yvffrgNSnJG07EdRlFVj988bHvdyqnhXiwV/iYpvMI14C4sIUIDi+TJvEIAKPzM2h+Bk9n46maNQhIBqsq1Q3pOZo7H+Uie9fVSfqWLNkEPJR9x2aG/R3kr/MgogCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0owScTjj58NfTQ8OQ4Malj8Rj14mycP1ZawbgRQPec=;
 b=T5pnUpuH+AWPWb/lGSYT+aVESuvodA6gJfe2qJQVMIdX3i5sybzD/NGjgcT/J7x4Eb/buCmMYXQhdPFh7RBgCkJvkiw4a6e3inFGVvY2eKYcfHDSvHC2tIjqGHJFjx7wIMPxXGOrMg0e1m3IDMRiHMR9uhFgL7w+jtJ5+5XkB1gF30pMoRwsm1eDhsKWQFs5HvyYm1GSzucSMl7K8psrF+kftaUWJ8jusM/6vVnEV53DSGkFMxjT5rjEDHv2cCzHP1DjZhx5sLXfG92X7c2Hn367Jp1lYunDHx7IMEgaZ8iJ8BmhDkqJ6YyXvPA5h88QB1ukhT4TmUArOkSQkJ+etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0owScTjj58NfTQ8OQ4Malj8Rj14mycP1ZawbgRQPec=;
 b=YoMSMIYubVYowvUCWi38/gxloXSQJxNfXBFDECbHOTQZNCC8c6CBebFnTl3h/pQFoAhLlDpb5aDC3+0PY3VkcZoJXiaEJMzWoed53vc8T7kAgzxfXsccj5WZQ4hnsPvMIC1qCmqqU0qengyqj2pW89QO+Q/N/I2jUhQ9DDbNRLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8931.eurprd04.prod.outlook.com (2603:10a6:20b:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 09:25:09 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:25:08 +0000
Message-ID: <b0b825ec-b864-4607-8059-95f68ab9c268@cherry.de>
Date: Wed, 5 Jun 2024 11:25:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] regulator: rk8xx: Fix incorrect parameter
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 William Wu <william.wu@rock-chips.com>, shengfei Xu <xsf@rock-chips.com>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-9-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605032521.1142768-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: f65ee6ab-ec1d-4022-0082-08dc85416491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkFVYjAveHpKT1ZsVi9Vd05yb3ZFZk1UVXNDSncyZVVaOTBWeG53UkZSanZS?=
 =?utf-8?B?MTdjTGplYmpCMHZhNml4b013OFA5NXYxL2JCaTQ0UmdmTkFEdVFIOTd1Z0s4?=
 =?utf-8?B?VXU4S2JLeUNrVkxnTi9QNlhOcm5XNFFRK0xLUDdlT3YyQkN0WmFPaDJtVy84?=
 =?utf-8?B?K0RNVjk1Mi9ObjQybjlCUVdTQmk2OU1scDhRRFA1bitCRHVvdjZIUTEyR0Qy?=
 =?utf-8?B?UVdndFZOQkJ2RnNNWFpsTFRkUUpFTGN1aUZSOVJQTnk0QUNjSXhsMGk3ZTlB?=
 =?utf-8?B?b2p1RWdUK3pzcXlqa0JtYXVOQzJrcUEwVFdtL1hJc0dEWHVaL1JBeVJuYmF4?=
 =?utf-8?B?Z1VhNWR6dXJCU1hDQTBYRStwNlJ5elBQVmg4UjZkbk93MG9MTFE5U2hCYytv?=
 =?utf-8?B?ZWUwekFRbVNVR0RkcTBLMkNOYThzUUVvc1czRm1FWVFkTmswMTEzbWN3WnQ5?=
 =?utf-8?B?K2xhaGZOL3B5UHN5NExFaHkwMjFRVzVHVTNsQTB5Q1Ryb0hPLzVRdFAxNE5w?=
 =?utf-8?B?TVpMcU5SM2xqTVhjdThieGxjR05HL1E2SU5vMDFvNzM3L21OWDd5b0d2andx?=
 =?utf-8?B?cHo1ZHJaUjcrKzVreFZTcVZubU13cTdGZGFQL2F6UWltc0tsR2pOU0pYWDE3?=
 =?utf-8?B?aGZDSENYQlh3R2Q1KzdDd2M5S2VaYW1kS1lZNFBXY0dEbUduUzFMdzJLbGta?=
 =?utf-8?B?akZ1WWdrMVNlbHRscG1uVVo1blFOS1ByUzVDb1N5ZTQwWDQwRmlyOStBWTNQ?=
 =?utf-8?B?NnJ2UUhXVWVJaUhRdkhQOFRLclhpSWUyWFpyUXlHNndyTzF4bFhxL0dlM29Q?=
 =?utf-8?B?WHhFRUpTdGIwUlk3VVBjVFFJVnJqOFJYUVBDenNJL1RaN3o0Z09JbTZRTmty?=
 =?utf-8?B?aHZsS2dNdUY5UW1kaXFpSDB2MWliaUJ6SVBDNVgvT1Y3bWJ4UGZWMVJGa0lU?=
 =?utf-8?B?T0RkYUxncW5VZXRILzQ3ZEl2dW9pVjRQZW5Xb0dLWXpaODIrUndBNTloK2Rh?=
 =?utf-8?B?ZFh1Vm5OTVZURkdMV2tubWpBQ29WMWZSNFlVVFh1QmkrbjQ2MXJBdmFJZzJ5?=
 =?utf-8?B?VlVpVDBaL1ZLNXFvMCtvektDNFdEVERZem9Ea2laUHpReFFXckJhS0JrNXly?=
 =?utf-8?B?UXJVWUlTYUJRTGkxdVVsY1h6WExHLzdnWEQ3NHYvb3hRZkdoWkdiUTJSTVVz?=
 =?utf-8?B?T2RRU3FLY1hTVENUZnpXdThYQ3pHSUhjQWdVaEt2MjlteWZEcWJVOW5ZRUxZ?=
 =?utf-8?B?YSttTFd6bDJmMWNlNjNOeUduQ1hUSFVySXJKZEU2M3VDZ1FHbGw4bnhQVEdh?=
 =?utf-8?B?ZWlpd3Q5S0hUWjFwOEVpNUY3d1pSdXZ4aXI0aUN3MEJPc1pETnNDZ1p4dnhi?=
 =?utf-8?B?UW9JSHRWUlVhOHRiSTZKWktIK3NDSjVEL1EySGlBVVhielRyeGVyYllkcDll?=
 =?utf-8?B?UnNtS1p5YXR5R2tETi94cjM5ZEU1YkswbUk1NVV4djB1VStUUlJHNjl0cGtl?=
 =?utf-8?B?Q0pDYUtTbnFjU3FSdWc0SEVMR0x1Q1ErUGlzalAxdjN1Mm1zdDVPQ29SK3Ew?=
 =?utf-8?B?VEIzWnc0aGRLM3Izc1dyMU9jVWxkVVFBcDRZcmNSaUxxOGppeVFUVGMyT2dn?=
 =?utf-8?B?cUk0MlRFcXladk8vM0dRcktUclczenErUThYMDg1b0ZlRzhDdXpRblpLNmt0?=
 =?utf-8?B?M09HSDVKd0ptMWVMeUVoTDNON0Vtekl6blNCTHRKeXhRY3VsZjZPU3BYbzNW?=
 =?utf-8?Q?TeBVqrMermDFQiEp935KRBwnMVdSWjHfUIFZvK1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpDbjZzL2JwbEFrUjZTcjdVWFpGTXNxaVlzUDJLOFA0ZFRTWGVtdXZUd2pw?=
 =?utf-8?B?REsxQmgxaHlDVG9yZHEwM0QzalQybEwxNlo0NEQ4eVdIblJKUlY2emFudVBV?=
 =?utf-8?B?L2xCY01xc3hKV1FPK0tlTk04MzRrM0NzNHRrUnZHWkc4RGZKWEMzK3hUSE5Q?=
 =?utf-8?B?ZURQdkJQRmY5U3kzelJueS92UHh6bDhiUWcyZWhkdFlpeW9XdHJtUVZRU0dh?=
 =?utf-8?B?ZmFpTVZSZTFpbGFFTFFqQUFJRk94T2lxNHl0V1NtbDhkTlo2bjVPaCt1WVVP?=
 =?utf-8?B?eFZwZEFCM1NzTXFwWWJjUmF5cTlIMk5XK2gxRXFHSmlEVFhTMU1hMFVvd2NW?=
 =?utf-8?B?YTk1NVMyRGk1TFd2b0Vla1lOYmV4MHQ4YzlJWFhKcnBZTWtJYlV0N2VUNzJY?=
 =?utf-8?B?QkZ0bVNZY2k0OUNVakk5YUNiK0c5MUFGUVNpQkZqb0I2VFFoUDNFWm52ZE9X?=
 =?utf-8?B?UFNxelc1Z1NpVXdjUHNobGxrTGZ2V3NHTUpXNUpzd1RSRExkQnBvRWZlZ2ty?=
 =?utf-8?B?eTBLMEEwL2hvMEVRUDFJOTIzTEdqd2p3VWhuK3h2emtDWmRhNmVha3JqM2pF?=
 =?utf-8?B?Z3czME9XYmVzajIwMFA0emh5YURSRHB1Mms1dTRlN2FESnUwYy9lRUg2RlNa?=
 =?utf-8?B?Zmx3MktScThNQVVVb1gwa1l1YU1IVDlsZXc3dm1WWENCd0hkTFhXREQzaktY?=
 =?utf-8?B?c1hQMnJVSWttQ2tMbWF1dFJWRDdRSXJsWXBsWktDT2hRWFZ0NFgwRitjU2Ft?=
 =?utf-8?B?UVFrb2dCZEhSTVhEeW42NWxtTGdlcWVkZ2FRU2ZXVm9RYTFoZU1TMkxLdUtr?=
 =?utf-8?B?YTlCNlFveW84WGUzNG90SlluTmFiMTlBbEJ6SXcwR24wMGtZc3FiTDBrYkFj?=
 =?utf-8?B?M0RJaWQyVEFQSkh5OTNoZ2QvVU12Rm1iK3A1WmlIVWN0bDA5M0JFK1pBM1RX?=
 =?utf-8?B?SjVQcFJwL2VGNHdXUG1WL2F6OE4yVnZNZ2dpVEZSV2R5Y0hha0FVQXcySTly?=
 =?utf-8?B?TGRZVHVnK1hzNFMvUHpNYlJ0MlN4TFJDUTlzY01tOWRIa05ndzQ5OHkzSlhY?=
 =?utf-8?B?MmJSWGp1WjA3RW45RE1uRmNJclZ5RUtyKzFKMFBxMTlheXN2S1JTdUVGZng5?=
 =?utf-8?B?dDdINWs0U1NVa0M5Y21uZ3FjY1RoUmxySDdaM2FRczdvaWdvcE05MGliQVU0?=
 =?utf-8?B?MEJ5aG9vbW9LZVB6TzRsdVpLL1BiMzluZklnUUQ2bVlQWGFMbkFNNFcvcCt4?=
 =?utf-8?B?OXo4cmlZMFQ4OWJJcW9Pa2xyNG5BaTRJYkpwUGVpTFJIMG9QZndLQjhpVEVC?=
 =?utf-8?B?aVliakllQy9Salk2TGtKRmI3RDNGL09wMTRldkRnZk43ZFJKOWxLVFVPYUNv?=
 =?utf-8?B?SHZDa3p2STV2VVlXOXJnRDUvblovcXFvS0xTTjZEdGFxUXJpemJ6Y3F3RWNL?=
 =?utf-8?B?V2JNZzljU3hTTFE3d29hVytja0VuTG1rRmF4bHJaNEM1MkxmaVBwcXFwVGpi?=
 =?utf-8?B?bDJCR3dWNW5OKzdaeDQwY0RGRCthU3ZIcDJjV2dmMEkxM0RwUHJIUzBTYk15?=
 =?utf-8?B?NFo1ekpieloxSkErOEU0SkFtSWRDeDVqVHVWK3gwL3BLYU1XeURLblRmazFn?=
 =?utf-8?B?MXpKcnNveFF3dHl2K2ptemRmQmRDaDVWZnZhdGJKZVRVdVhiWE51TUduZE9x?=
 =?utf-8?B?Q2t6R0d6cmxmM0Y5dGJ5eGR6VHFXVllHbUdUenJQY2p2UEZJazkxeURla1Jk?=
 =?utf-8?B?OFFOQU50eXYvTVVadE1aN1VuZldwWmFiQS9XSVRndkowRm1ZaThQdjJubFkw?=
 =?utf-8?B?SVluU01SOFJOVnlPaE1BOWplNmpLYWpma2lSSXBjSVl5MGlLcVo1SnZQd3gz?=
 =?utf-8?B?SGZTQ0dmOWdXaWdTNlFubmF6VUxpVUorSFNrSUQrTmdEWkwxY3QrUjh4ZUti?=
 =?utf-8?B?VTV6UG1vUUFydkNHd0hPZWRjbTltdlB2bFJrMnNUWlNPQ2dkWTRoWXpTR3hh?=
 =?utf-8?B?L3J2ZUJXbkd6SnI0YTdGcWR6V0x3cnRvZmVaOFRQbndnbWJKZDdVdXVoczhi?=
 =?utf-8?B?cnV3VXR4eDA4UG5nVWIrd3FDNzBRSWVNV2JZZ1J3a3RHdk5MK1cwMDJVTUFF?=
 =?utf-8?B?RU80U0Y5YTVrUVg1M1VmQ2dHWmhSRFA0UFFzZWFMSmZWdE9JcWY3bXh3TGF0?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ee6ab-ec1d-4022-0082-08dc85416491
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:25:08.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+1yuCIA4A5e6AJoeeOat/kK9gwHGhZfHCvzbr4jUlstdH9q4D3ub5IrvuOaIIfsYgQ7+vFPYN3CfeLVTr5uTKrl0IioYKVu8fBt6beZUvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8931
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

On 6/5/24 5:25 AM, Simon Glass wrote:
> A recent change introduced a bug whereby a PMIC device is used in
> place of the regulator device. Fix it.
> 

Good catch, but the suggested fix is only fixing one of those bugs, I've 
introduced quite a few actually.

I'm sending a patch series to fix these as well.

Please do not merge this patch.

Cheers,
Quentin
