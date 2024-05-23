Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BD4C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E366D885A5;
	Thu, 23 May 2024 16:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CUwls5lt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44590885B6; Thu, 23 May 2024 16:52:10 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB70885A4
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1oAWRD7f4+/dvEp0ZwW1rBG9SK7Z5MFX2l7Gx1tqbXd6TWETRkGhNWgo+uR2/L9NZCEMigXZw6GhnMxaghF/3rYYpqj8Xkc/A3A6OOxzSL8U3rGluke1Vz5Ib56MjKIc/Z8o3wf00KgRmXDhYLut6KxJDXtKg1grKM0lWVr6Vt00LCnXF11LD4KzccsWi5GN+qFhOZQaEl2MwI0Ag3u+qPEEb/pVvDFEdV9zAhzQnovgWPb1Wc0zZH9PATLrTtUgX04mlZqMRMfbVT22klGPaQ2DsI/nWuBxAeCkGx52Ka4iThzcVf8XxolFWAcdKNPk0GsRTRyArrw50s/7hIYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi3gUaS6tj1TXvI2XPgtUGRHjT+/7vNvG33m+OLyuHU=;
 b=IA223/l0EPUWWYkplMdGY9EU3c+g9GW2bUPfx6fBmx4mmUVnwHBxZd5dVVbp6+1xxL9KN65Vh3zQTo0QCC7fsNp4Kf2RISMiqFwtWtmE8ombbpopYyVSVknibJakYVVW1u52wAr0R5CLMJPLN44Qsncyaq9uSiWDfhNrgmy+5i/X3cIIHakdOiMtgYR1UamYkKsTucLZsj2oroAR/OK166GZgCjHRyi1eonxGsmu6CZcfoPYgkwBxSeb5rgUVyFc/+HxMINNe3Gjsa3JmkzrOkBl4YCgeRQ9/DBk9z/LcG5l03D2vTwDHxByd13jwEolJ1Roh1v4Ifs6e5kz800dJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi3gUaS6tj1TXvI2XPgtUGRHjT+/7vNvG33m+OLyuHU=;
 b=CUwls5lt8JtUpeAWoHmGmRtZW/ocY9PBxnQ25vVHAMr/yKEQQZ+YJkW/h2wABvUMGAIuebZ4w+7bIiQtLzBZMth9AiTH8KJ3hnqDZuuPQJu/g2d1t1uIkNMRsprY8rhf+8tR3DGIUUh+qweiyeaRI9pP0SUT+TIGqfEUwyFX5AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:52:06 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:52:06 +0000
Message-ID: <ba8f56be-1b5e-47c0-a25e-71f5d4e28146@cherry.de>
Date: Thu, 23 May 2024 16:52:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/42] mmc: dw_mmc: Move struct idmac to dw_mmc.c
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-4-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d08925-467b-49d9-7ca4-08dc7b37ea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVZYQVVkUDhUdzR2WVJIcTZGK1JhWHN1eUtKWjJJaUJTLy9yK1JDZXZqZk02?=
 =?utf-8?B?YnRMYk5abTRIZGVuTGE1eHdDbmZ0RkV5YjVJMHBxSm1UcnNDQzBFcmVaTVN0?=
 =?utf-8?B?cHhBMmJCeUYzVzVCdDNadUFocjJRa1JCL0pGTzB2QVI3bGN3WnhKdmZvQ1dL?=
 =?utf-8?B?ZVh6MllxZ1ZyNEI5ZlJmUVpIMXpyZ0crbEpCNExsT1RzTHYxZGZzV2ZHRHlC?=
 =?utf-8?B?YmtYTlN5VE1zcE9YUnI0S0Q5TGZua1gyME5ad1k4N2JtNllCVSs5VmxUdlNy?=
 =?utf-8?B?MGhsK1JCQkZGQ0UrYmZFZ1RRUk9hZmsyUklJNlJ1VFdKaFNEM2ZQQkVaQnh3?=
 =?utf-8?B?QWx6ZGN1UmZIN21iZkY5VFIwaThwbW5PdWgzOW5oNHlIc1h1NHYrYzVodFY5?=
 =?utf-8?B?d2JQNnE4RkgyUU5iU2RIR3hpMzk5WTBFaFU1bk5uTHJDdkE0ejE5d0c5NlVy?=
 =?utf-8?B?RlROdC9UelJnWExjSFlrNkxPWll4K1dBSkljWnF6K1VjaFBiQnk2d3lFaWF1?=
 =?utf-8?B?aml3blcydy9PYk54MlBEWG5oeWkzK1FQZXAyMG9pK0xqZmpEa1hpM1BhMHAz?=
 =?utf-8?B?SWR3eGRkWk02NzNyTmliUWV3Qk5KaVByRUhzM1dhdk9WczJwdGU3TXJDR0xt?=
 =?utf-8?B?QzlrU3l5RzdTL25adXFnazVTRHIwYUFpd0ljQjJRaVZQcXN3blJKYjVXNS9a?=
 =?utf-8?B?UGl5V1VSVmZJZm8rSUxUMi85bGtaWUpqYnk1L1hwbDF6Y0JldmgwNXFidCtB?=
 =?utf-8?B?ZDdmTHJZbTJwUmpZQzhDbDBtZjRMc1RrMGo5Z0N1MCtIcDdDU2ZmRlgvYlZh?=
 =?utf-8?B?OC9XL3A2eE9UTFlaR2h6TG45RnBWckZXU21WQ0g0d2pua3dqWDdGZlAvNjFB?=
 =?utf-8?B?WTBnRUl3TFVKTEUxSnU4c3FFb1R0TVVTWldLOHBmUldBbnpjaEhGOFdPekF3?=
 =?utf-8?B?Mm9pVnJlelJmZDlSNWxFRFAya0xxZVpBWVJYQzY0Tk9qL0swVTJNeXB6c0NG?=
 =?utf-8?B?dzZzMnpxTzdVTC9WMllvM0l1M1hnNWQ4WDB4bVJuRlduaDUxZVRGcytadkVW?=
 =?utf-8?B?aGVaWUhJL0lIQ3V0dnZJZDdveGp1QVVTN1J0NHZJbnlNWXRqSVZBdFRYVXBE?=
 =?utf-8?B?clkxbk8zYkZRT3I4eGxqRjYzS0NpSm5rMFozNGQzNWkvNUxmWEh1NkpINkZw?=
 =?utf-8?B?Wm5URGttV2ZRRFFFaGNnRXQ4Yms4VFVNK0RNOU8wblZnMFFsV2RsaDI1MEkr?=
 =?utf-8?B?VG9vVFJZNTN2RzFseHF4QWpBZjdQMnBBb3lGWG9sR0s0U2t5TTcrdFc1QjMx?=
 =?utf-8?B?M3EzT0lOY3VDZEE2dHZTWkpwTjIrUnlxdE9zL1hERmVHNU1rS1Y5Wlord1Ez?=
 =?utf-8?B?RUtoZi9kT2E1NmZxYlRnNHVveFVxRU5hVFpicktnL0FIY0VnSnN0dFFmLzg5?=
 =?utf-8?B?R1JhdVJVRzlBcWdOb1Z0b2Y1VG1Cd1d1TlUydEg1Z1pEWjRTTXE0U1NWL2c1?=
 =?utf-8?B?b2xMZk5qUTNVYnlZeUt4RnRKRXlvVVI4VE9iRGY0U0xXYXcwdkZFcjFlWXZC?=
 =?utf-8?B?bExRVXBmSnRwaGZJQ3crYVZ6TTRETW9PTnJQYVNvKzRPM29qSWJDRHUycVQ1?=
 =?utf-8?B?TVBEVW9MTXZrSWJ1ekhnZWFmYUJTSHBxZUUrNjgyd25HelBKNTN4djR5bTNS?=
 =?utf-8?B?TWN3U2pIMWlqR0pPZFF3c05sdEhKTnU3MXFXSFFvNEVlblU3SDJnOTBnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzdtQXRBNHpBanNlQmk3MHdzbGRWc1YvOU5pTlJHcTFXY3NCcHdXQ1dqSmNh?=
 =?utf-8?B?L0VwY3dPZmF2WkNWQ2ZDZTVuckI4dmtrMXJ4ckhJUmxJZEIrd0JkRjJDUUM5?=
 =?utf-8?B?YVJVcElIZmZCc00rUzYwb3hnN1ZxaG1vdllGakJ6Y1F3dmtZeGlLTkkveWll?=
 =?utf-8?B?REVIbTZNWWE2Sk50WnEyUVUwaFc3ZHFMUnJaY3hBZ2hZaEFuQnN0a2M5R3N6?=
 =?utf-8?B?ZTdpN0NjTzRjOEJNbVQweHRiZS8wblpKd25oTjRsaFdrdUFaZXZySGFIa1ZZ?=
 =?utf-8?B?akx5YWhVbzREd0FrQ0lzNHhLUUlrUHpMR1lDUWFEMU5YWkl6WVByd091V1lU?=
 =?utf-8?B?M1NSbW5rSDZ6SHBDUFg4OWFPZVZURXVNSjFLdDJqemFDSUVmSkJoenoxZ05k?=
 =?utf-8?B?cWsrblNJOHRvQzdkNWVEanhONXBSRWI1RnA1S0YyWmFScURNY2hhenlTUDAx?=
 =?utf-8?B?b213dElVanRwWHFVNmVKWnhkS0czTG9wQW9Qb1FpdktwWkNwUkJxOEdKVllH?=
 =?utf-8?B?dnBXY0owU1FSOUJ0ZzNUY1pTOWVoSGdWd0NCSUs1N0N1Y3N4NlNOMFVtQldm?=
 =?utf-8?B?RzA0eDJHeFZUWG1XcnR1WFRzckNhNHBkQnUzbitDU0FnbmJZdmJBNVFQOEto?=
 =?utf-8?B?U2hvK3BubXk2M1VQLzh4NGo0STNEZm84T3BjZmoxdGR5QTBsbFpjKzZHeWVD?=
 =?utf-8?B?YUh6MlpIZ0ZNR3dIQTZQTEx3NEVqcGs3b0tYa0VEbDg2WjJhc3I4ejFEZW03?=
 =?utf-8?B?ZEZmdTJyQ3BydlEzT0RmZGdHdCsvT2VuU1VEU2RwQjJtOGhpUEFoRDNUU0NZ?=
 =?utf-8?B?TGNqbkJSVnRTQ2t3VFp4N0VQRVdLalVwK0RhcGQvTFJVTmg0NWNZQlRxS3Y2?=
 =?utf-8?B?TkVFK1Y1ZlJ6R1dZdFROdGdYNVdjU1JiZzB0NFE1SGk3Z21ibVd6c2JRYWlE?=
 =?utf-8?B?ZndiVTJkaWxCb2RVUjVLdkdwOGhabnRmanVYZWVTcWRLTXI5WDRUcDJqN0U4?=
 =?utf-8?B?ZGpzaU9DTzFlUTg0cG53aTlSdTV5bnlhS3B1V0oreGltWkdEbTh5dXFBYXN2?=
 =?utf-8?B?K3luaW92N3ZPVVhHQzdJcGgrY21uMitKQlNvRlJUODVFTGlxSEVlc3F1QnN0?=
 =?utf-8?B?ZjJFUklZRUZrT3ZzbHdVRCtnT3RYalBLbHVlMjFlVG1XRHQ2Yk5wb3BMMFpF?=
 =?utf-8?B?MmFBaEpPOHZueDhmWlNNUDdNd1RSNTdMcjRzaEdNdWl3V2U3eitmYmdwUkYx?=
 =?utf-8?B?NmtoNmJUWStwcURYWTRUK3dpT3hqaFFYN2xmZ0xxRmlWZ0Z4YTRnbVFDSU83?=
 =?utf-8?B?L1M1ZWJ5MjFIelZmU2ZvaFBTbkgzWjVNL2xuRUl1U1l0N2ZpRGt1MDY3Vjlv?=
 =?utf-8?B?TkQ3YUpEV0JVekRDeWFpNkhTSHFHazI1SXdaTlhuVUdZVEM2ZHErMFhYaEdk?=
 =?utf-8?B?MjhCQlNJQUUvYXEzc2NPUjRmcTNxNmFySTBzNGNnRDk1aUVRWWE1OFF2RDZX?=
 =?utf-8?B?b1hTUzRDWU5zZWp6a2FDOTRoV3RPWExJSkFYMlFLS1NkcWgvdHA3dlgvTFFl?=
 =?utf-8?B?RGg1YktPTWlyYkFZa053UFNVcGZEVHNPQkhqTDdUZVBPendsN3JDTlR6NjZv?=
 =?utf-8?B?d1pmay85R05ZWmNTNC9VcTNZbXcraVphVndqUDB0WDN0TUF3V3Jib0d6b05C?=
 =?utf-8?B?amxVcG1XZmpSK3dHaVgxWkpkMFpISTh3OGN6YWZTVTRuWTdUU1p2RHpzMU9W?=
 =?utf-8?B?T2RmTm1QNFF0a2R2YmFzTEpGZm5mbWRBUmJVdUd4QWRlK0xOK3dINEtwdHV1?=
 =?utf-8?B?QnpOL1pSTkUzNTltVjlmYW12cnl6K1hoRmlRaDBwMUl5WDN4dC9NeWRudEp5?=
 =?utf-8?B?NWprOXAybkVnNXRZSCt5cVF2N1krbHkxOEY4NlpPc2hjdXdnU0E2dENvYnFX?=
 =?utf-8?B?bnZJYWdGajFZeXVueGd3Y1UvNVBIMTlBaTBrNkk4bG1oVnNDZGZZWVl0NDE5?=
 =?utf-8?B?V2hmVmhqV25CTWRlckZJeHduYWdiR2pOTXZ1cXNFMndJdkREYm5zT2VENXpF?=
 =?utf-8?B?eFFzZ242d3Brd0ZXL09IWUNmSnR0N0NZSUhVL0k2Wldwa0cyaWR4VmFwbVRi?=
 =?utf-8?B?YVFnWm01Zmk5YzNoaTArVm91VXhKcERiVG5UekVBcXErTHRzUENtZWE2eTY1?=
 =?utf-8?Q?F+odTj5j+YxOVj2in0b36ck=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d08925-467b-49d9-7ca4-08dc7b37ea5a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:52:06.6617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuUkKlz2JzTPMyX5en5Fcumh9DrPQAbWm2aPzw/fVm2SldSDBTHwFuE/B03WqyOd/nX2n42ReJap4d8X/VMjeSGHBRn6RbfZrJg3Qo5YbuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> struct idmac is only used in dw_mmc.c, so move it there from dwmmc.h to
> avoid cluttering the interface in the header.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
