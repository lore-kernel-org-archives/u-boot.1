Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6FC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A076C88384;
	Tue,  2 Apr 2024 16:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="EFUZ+ykd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC848646E; Tue,  2 Apr 2024 16:46:09 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C686987073
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNG9zff6dOuVoj4Xl3Dkpc/UTh6Tb7rtKpbYaxFOxZKgu0BgC1OU6niKnFH2UFy6ifDeLHTrdkSN+SqV0SaU60e/Khq9rhx617F0OJq8aKZFNgVC4HbxwaxeKGZ8mxEvr3Rw9Cni9kbdS/3bw3nI2ttaLM0fh6Y+dugD/IyF/IPkO738FZ0DYLx2dsXSaoV6AKXeNJWrU3SNTOp87m3dnICEFtwhCED6Qytyuam82QjTQxpCH4z6q9r/GNEDg5+5AfT/bk/T7YXIJoZ9fIfvP5yRlBcstAP6hOfD2FfBIvjMb/IwIRv4W4QQUHXhd9+OkW5VWovYiYjaHB4Pm5sNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjsFBNvcSJDcBl/7P2IM6D+5221ULtfM/HJztd3jvxg=;
 b=LfFOAHdnRYnwcle3ATfwEMc8D1vnFjSYm7HeyXA0FGbGNB0zQXhfFBVw2F5H1uxlvoxtlmR+XA4z4OzAvvlj1BV5UME3OO8m1S14HQrcYX1Q7UD3Jq5r+KFsihTmcmInWyvr32XKYZLun1udD+LBvdSJ3wrcwtglJWhKGmGNo4T7O3kwOHFub/OCC90YVYK+ziIFCzRq4S/KONDVb8Kgc6vAvWKUuCFDbTM6ee72lSrHUz5hEiaLtMb0PSQSIzUjCmsVXy/hdtH0Ne60Ux+3TX0RfiRrGxf8LeKfsztw6vYtfJw6CuxGK7JGEmKLR8G9hzucHsG3J7IEOcjYSkV2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjsFBNvcSJDcBl/7P2IM6D+5221ULtfM/HJztd3jvxg=;
 b=EFUZ+ykdCYr9SOpagJUI662z5YdtEOG8WZro02v0yf8jyM+X0rt/+4Cbmt4FncLqskP6PJ8/LimSTNcIFlGiu9fUUdYNsAsC2SoM2jE2Naz6UxrKXxymopbn+yZ/N1cRrRq39ekgJgGszg1gqs9Y1bNCUH89tB4XwVlGU9jYfxAM3K/gLBdV+oVNHcwa8tFiSwSqxdeWVMQ4v9rYopodEH2bshN3RNxBB0tjQrpgaOeegTdF31J4nQI8D2uVigUP++GTeXP4sVFquitt3jYXP2J6FA0bu0Z4gcw4rcs66DmoamAY7lnN4XEO7Ni6T9uuhf6cVz64r+j8kKg/sHVqTw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VE1PR04MB7296.eurprd04.prod.outlook.com (2603:10a6:800:1aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:46:04 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:46:04 +0000
Message-ID: <7d966392-b649-4123-a7d5-ae0f5c354f05@theobroma-systems.com>
Date: Tue, 2 Apr 2024 16:46:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/31] clk: rockchip: rk3399: Add SCLK_USB3OTGx_REF support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-15-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0013.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::8)
 To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VE1PR04MB7296:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ybck9E4Xg2iTdZv6PXoGpt4+ryRgYiFLr+TwIVTSmb1GxTS6ClLKlqhUm04qbBVhEm3vTrmujAjR26VBQaAfuev+eI/Wd/yetxh3xjPVMjmtzyTQgkCY+bWA7lrpoRUDbjAckh8Fy4LLNMNTq4WRIwLPoFnB3dSuR2pE3lqFMc2Ul1Toyi3Ax5OKqKiJ4SQnB0rqvNbsWGwpQoLw96lXYQyIGVHiB/VgTpOSLmhtKT7TVUj/ld5m7XHinzUpshnz+7+vZHayOJKb1OYtqExcGvbu7KdZ21YRyvzOOvtulF/rkCaANdJMpw9w6Y3lqFU3L7ylgaGgEsLf/LH3TQhjI6L7kIXmU1OGcTnArefse+TffHRzBp0LwQTTOOAZ8BU/T+Y4lvxZLO3YoGulJOHpNlZ84btc+/bl+l4L86eqJCvU/iIKEDANa5SofmcFUnfVqZq1m58OyI/q3okR/ZBSULSqkbCT+jKT3lGo9o+iTRBgOBHOyfGa/VJ0UdADbC9I9IHkJAT6APw25Utt3jQkRJIG8YjeWIvLoBfCdU7usaWdo6hO3IOuGJ4mfwWttaT5PIvCvwtGD173UrebUyPpJLF9vXRnrbpSF+YLO3coSU5g8AoqbMGmWdrkoK3rjLESwUSIGEQcEGlX+mm1WwELea/IEBcmZuYUyimED59ASBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RndVNuQ2x3Z0oxNkYvMzJzdWg2bVdmaDFoY2tjRWFxbTBvdysxWnN1alNS?=
 =?utf-8?B?OThZVUpPT3ZkbUs5eVFlZUxRek1idmx3TjBkK1JiNEtoQ0x3SmZzY3JJQWtU?=
 =?utf-8?B?dlZ5R3pRdnRMTUFzOVVSVk4xSjFzR2NaWExxWVhUVUhHYnFjKzlCQ2xvTnI2?=
 =?utf-8?B?ZjFwZE1HUGlLVEp4dEtkdUV5cC9VdWFBTUtSMUw1WVNxVkppVzFrbnJYSVhw?=
 =?utf-8?B?c0NTbUwvRlVLTHFHOFlZa1FKQ0cxenp4Vis2REpKS3V5QlZmRGF3RXMrMEdJ?=
 =?utf-8?B?VnkycC9BaEJ5U1dYWDdOaENrRHpuMm0zZzBET01yMi9YRWxlbzdwOXFJSGJJ?=
 =?utf-8?B?dkNrTW1PWFJudW5ZVHNFTWRwaVFnMTNQNXRPMTkwWG5rL2l4T1Y1ejlGRFBE?=
 =?utf-8?B?NEVaZWNjd0xtTnJ1T3lBZEJnTDVOUzl0VENZODBsOHdPRmNWVUZja0ZyZWdY?=
 =?utf-8?B?RFk3NUd4NG1pejlKclNESlZRelhtck00aTRhdGY3dTNPSVEzTVlxaktXd1FN?=
 =?utf-8?B?ZDFFb0poUG5EU2dOSlNQdzJFWDFXRGVJendIMFpmYUlTaGxXQjRYUzlBcjFO?=
 =?utf-8?B?MU5QNG1SM3VCbE8rZU95VmpaU3lzMVRYUHBRdkRFM0o2U2JiOVJBQm05cVc5?=
 =?utf-8?B?ZENndlNYOVZJOVB4eE11SE5aNjRHS3J3WTN5ZVd2VkJ4U203SzRDbVFpYnIw?=
 =?utf-8?B?U1RuLy96c2dObzE0VlY4RkxKV0FBdGhsNDB6SjlJLzFLREVGZXVmMGlYMXV6?=
 =?utf-8?B?dFBTTWlzK3YzRm1GaFpVanQraHFyUzVXRGpjK3lEangyRk1SY3NsMTNBSnZq?=
 =?utf-8?B?RDRXUXRqVkRuOTgyME9VZUFnYzZLQ2VkREJvWDhHb2MxSWIzY1RBSmFqL1ha?=
 =?utf-8?B?WVN5RUdKVW1aaENwdkM3THllcVFCWXAvcTEzTlgvQldENEVLY1JvZjRTWFh1?=
 =?utf-8?B?SlptbEw4OGhEUHdKUjBpZ09zc08xNEdaNWp0YktXR0l6dVdiWncyanI4ZHpx?=
 =?utf-8?B?akpXUEY5bHNMaUxlUktuR2VrRjV1U0xhcmVwZmEwZW1sb252emthWUZBLzZH?=
 =?utf-8?B?bTVaOWF6WXRkL2thRHdwUXB3bTRvQ3lwaEUxQlpOOHRJWkRQQXNBaEgvbHhh?=
 =?utf-8?B?cysvL1Z0ZVRUUnFzZVpHNzlLQkJ2bnhkWk5KdVpIdzAzT2RUM29YbllENzhx?=
 =?utf-8?B?S3ptWWpiS1FEeWkxVE1TUlhLN015b2ZVL1JVTk5KVGc4TTZtVnlCcVoxZXlt?=
 =?utf-8?B?SW1pWTlVRld4dGRqcERhR2JOK2djY0VoSUprWkY5cnQxNEJ3bVZRcEQvZGFo?=
 =?utf-8?B?UWRvZVk5VUdUSHVDWnlGUStWZUMxNjVqWDlseHRHZHorbXFsM0V5VkNlNXRP?=
 =?utf-8?B?dGFoTUt1dW5vcWY3TEJ1R1VVdGxQdDN1eE1oeXhmQUpKekJYM2kwZERxSmZM?=
 =?utf-8?B?RHZHOWhrVy95YVd2eG9aVGJOd3lNM01PbDdCTU1rVFNaUTQyc3MwbkRFQUV3?=
 =?utf-8?B?dk9QdFZEYVlTclFsMmRERms4WmU1bDNldmIrZmlWc29NQk9WVGMxQjF0c2FR?=
 =?utf-8?B?RFFVa201NE9oOUZJRkE1UUdpaUtkUUZCazh1UXcxTlQ4UklINUhKR3EyU1NG?=
 =?utf-8?B?SmVteXViSGE1RzdSaE1XU3R2bW1sZ0Q0cUJ1R1hvMnRrVjhvVkpxK1RJYkM3?=
 =?utf-8?B?THJlcVlvTlRzTHpsQ29VRFpRYjd2dFowYjk0Z0I0bm4xeGVRS24vVnpDcjZI?=
 =?utf-8?B?cG5UdmdURVpPM3RsSm96ZmNHT2ZDdjRQcVUwdWpPeFllamFpNFJ6NEFUSU9P?=
 =?utf-8?B?R3k4blkyTTdxTmppVVpkQjg5RXk3NWJRVVhQaXcxeW1Jc0pwVVVuVkJRVWhU?=
 =?utf-8?B?K08zSVp6QUVzKzRIWmw3SmgwWnJ5ajVRUXJ1Rm8vUXJ3RFhCbGx1WXZneGF5?=
 =?utf-8?B?djE3TW9sS214VEwyN3loZ0xrdEQzR2xoOFpxc28rTGEya09HRkd4YWF2Vmpi?=
 =?utf-8?B?WTV0VkVjUjFpTDNsTnpHSlhUcVB3OCs5eDFGMmJRL293ZW1KaXplWWR6ai9E?=
 =?utf-8?B?YUlsV0sxdVozUWtiVHNKZHRIdUR6ZnpUUDI1SlFXZ0JydWdMTGREM0tlR1Jr?=
 =?utf-8?B?RmVVb1FzejUwSHBnTlI3MitoZmpteDNjVC9EblNJK2o4L1FGU25zVjMvZHpi?=
 =?utf-8?Q?zJilB9I2tVVCJQczUPDFqCE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04150fb0-1134-429a-71e8-08dc53239f8b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:46:04.6867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/ttGC6p/lAyNZtZl1NXRRnWfgp7RhaOa//zxoRbZQP6O+li36+4LVGlDPkf3vXo+jRmu0tB+GPfgFkqeBHgRGFOsOKglqhu7aXpgd7GWncncXzKZ1m1uGKqnWAY79/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7296
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

On 3/31/24 22:28, Jonas Karlman wrote:
> The SCLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.
> 
> Add simple support to get rate of SCLK_USB3OTGx_REF clocks to fix
> reference clock period configuration.
> 
> Also replace use of 24000000 with the OSC_HZ constant.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
