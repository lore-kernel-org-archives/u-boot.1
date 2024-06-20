Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4934C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 22:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 235DB8826B;
	Fri, 21 Jun 2024 00:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kQ/vuPt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15A488191; Fri, 21 Jun 2024 00:22:51 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8883087D87
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilYZVuK1q7Xvtqp8Tq6BLnolrSCqrjoor2YKGWbUO6MUDNJu/aTihS9TDqeBnCWu9F7OIfA1GB3dKeoqdl807MKbCjFvSlO2fQy0oGlgpniKiN/OwZVWx1u+g/kTOcmzIVP9UQzXq4c2pnoey84lPuK6uCkuhiFKAlwoG3/VeoBLmyp1cusGUa6tq89rDlEz14liNo7GsatiGdcDD0g4aXWYVDqYjiKjalXOy6fYMLMOO70dS8jNLtHI4up1lnsp2PQ4BHlJlkUeS9mo6niukQ7kahMFTjhCGiaBP+wEydpvzyr+HOeVQKcYq6kvA4eAhve/OgwbiDkpLbJqjde3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQJtFCJsw5lvxLgZ1qwe+U9by6Frd4K6Ih5dNE2KXJk=;
 b=SA01OTERUD84RzAr12th17ITzQqA3QCbYMqcC1rw8QUjxx6/tRkJ8R8mqmCDLyw4jpjX1wnN7Lp7Oax/q64wW2+ei0FuoVSRq1pf2WFuysJhDY3ZWYiKeD4o6IvXuCKuzCHOHuAVpcRqaRN6Bd5zifkgvwS1wsJlZ5qtgplTAsoJYZlmJcLWW3KWT2sgrOxx0n0UJMgXvHgepk1o+qWSIM8WfdO3C5ilON84dmC3VIjeUyBoXlxkpQ7SAY8/TXcYiBQSEfIxaZQrwY1/cH2UN+j6/iZ5s3sgS7gOXkie6B+jeqnXJooeFcaSH94OQV3Qn0rEeEGzCKo44J23C1nTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQJtFCJsw5lvxLgZ1qwe+U9by6Frd4K6Ih5dNE2KXJk=;
 b=kQ/vuPt8U+17ahZ7zxYs5C8UkCxNUtjwpc7liznWsLPtp7+qF1yayp2548JcHTVnSwtBp8zYKTmPTiLOd/zW1aeNWWPffcL6egCdA0Y3wNJ1C+S2nYFB3qg6/D08Ff/M32+lJ5j+fgTo3Vy1481nb/R6qLg4iWtopWr0wDci69I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GV1PR04MB10535.eurprd04.prod.outlook.com (2603:10a6:150:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 22:22:46 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 22:22:46 +0000
Message-ID: <a7cca1a2-5ba8-487b-9fce-1553da93c56e@cherry.de>
Date: Fri, 21 Jun 2024 00:22:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
To: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Josh Boyer <jwboyer@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240620213539.ftmjhphypssxp5n4@desolate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GV1PR04MB10535:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea4b75e-e8bb-41be-2c8e-08dc917782a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE9LREE0TlpHNzFWN0FTcE9wM0svVUxRYUtYQTBZQ2tlV0sxMHNjYVNWT05G?=
 =?utf-8?B?cTljVXdMdGh5WTdld0R3TEJVMHBhVmswSHlPMmdjdVhMUDN0aEZSMVlzUlNu?=
 =?utf-8?B?MEVWbTZETmc2dnNYc2Vud1Q4NkwzKzk4RnMzcEh5ZVl0dGI4a1hHa1BGTXJx?=
 =?utf-8?B?RXJwT09pRjZFQmRCWXZ2cS9Oc3RQM3ozSzd2TVc3ZURnTHd1Wm1jSGExcnV3?=
 =?utf-8?B?WVJxYk8zZkp5WE1HcWU1Ulk5UzZjK0FVMk1lOVpyaUZLckJUZTZ0Z1NOcWc1?=
 =?utf-8?B?K0M3dFpwKzNTalYxUUxJdnlkVmFOcWw3VnNSNHM3dWJFaXZ2aW9EU0V0QmJ4?=
 =?utf-8?B?dkdkZ0prUnJRN2JWUTMzZUdwNDZSei92YkpnZDJPUVNtVjNFTE9VVmpkY2pS?=
 =?utf-8?B?em9zYUZYdk56WnUwUW8vNXdjS3dmVUFqeHNrT2dLOUVTZjV1alRLVjVxRFdu?=
 =?utf-8?B?OUNhN3BzSnUxUG1RZTFEUnhORUE0RmM0dm4zbTgvd045cEhlbVFqbjlaTmYx?=
 =?utf-8?B?bzdwQjRBVGFldzUxOVVXOTVXL3RFNTRHTStQRGROUEgxaXpBNWlnVnB0VG90?=
 =?utf-8?B?dklBUmdTYlU0NVRJelQ2ajNVNUVQVTR2V2hnczltZFh0TTl4RUtpeWwvYkJt?=
 =?utf-8?B?WFgvamllNm42UHFRbThNWUNaTFB6Ync4M05ucnlGTUhpNmg1WFJJOHRVTjk0?=
 =?utf-8?B?ZGMzWndiSjRPcXF2cldpbERnaVhQc05jenFOdWpVYTdPSFF3UVNTZ1NneFpX?=
 =?utf-8?B?RytpeFRsL284VkdPcGczODNSTzhzQ01zVGc1U21BeWpMRUI0eFNIK1BHMlBP?=
 =?utf-8?B?Yzk2MllWcjc4SGQ4NzhZZFhKZHA5WGx1ZmNFVVcwUU00SkFldFJUempEZ0Nm?=
 =?utf-8?B?RGRpanUxRTQyQ2N3UnE5N01yUGQvR0E0QUxXSWZMeTFzMkZmWUJQNERGT1pI?=
 =?utf-8?B?Q2VCdEZVQjNpQnJnSXRzaUhjNTRxUUsyd3FFL3pZVEo1Z3I1MjRVRDRkdnpT?=
 =?utf-8?B?T0NrbmsySnJ1bVR3akxUcnNHa2JHSHkzVElqRmpLbVc3WTJsQllPWFE1ZGxB?=
 =?utf-8?B?aVB4UFNRby90d3duTTNoSXBoZHRtQ0plZFJVWS9OY3RWeEJ4VHdLeldlcG9B?=
 =?utf-8?B?WjcwcklCOHBPV1AxTHZ2UUVIM0FOa3BHa0pkVnJkejRYa1JZU2thTEVYMUhk?=
 =?utf-8?B?cXYwZzhtVHBIcU5KUGVUTVZBMDVHckM5bnk4ZHNRbDAwclhOVWx4djUySkR1?=
 =?utf-8?B?Vkpsc2tpSWY5Skc0MEpKSXlQQTBrck9haSs0WS90T0dqVGdhcC8xa29HWVh6?=
 =?utf-8?B?ZGtkS3VDUU5yWllzMDJQdWhjMDJyRm5tNVlmQzZrWU5wajlTT0duRFlsUG9x?=
 =?utf-8?B?TEtuVTJ2MVhhMk5BU2xHYUVSck5DZ1phOWMyQ2ZHY0hsdGE2aHVPaU9pNEM3?=
 =?utf-8?B?MWhCY3NrWW5qTyt5am5ETDZjM1hpcUt3dmZXaUJnbGJVQ0RmWVN2QzFrM0JQ?=
 =?utf-8?B?L3UrSk9JOWFyQWlIM2g4V0xxK1h4cE9aOFcvVWcvNHRmTi94NjMxanREWkZr?=
 =?utf-8?B?VDVkZVk1SWNIdy95a05XaEVoTW5tazEwUFZNcDNTSmFXNTJFZUpUSEF6dmlJ?=
 =?utf-8?B?WnlSbjN0M05GNUtLSGxXS2VDejZQWTdraDhUOFE4SEZBclE0ckhxV1MvSXdY?=
 =?utf-8?B?YmJUV2FRdjVEbTZUMWdkL1VYeFR0MWlNQjZWMU9ZSjF4cmpFNit5Wi9pSXJH?=
 =?utf-8?Q?/rHeTXjcZgLrzloZqKjSbmxY12x5j11QvoLz2Mj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(7416011)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpCOFhPYzk4NlJSSHU4K0RiOUR6Y0FjWW9HbEhQbTJvZStPWGRMeWRlNHk4?=
 =?utf-8?B?WHNLQ1ZXRitPMCtyOEZ2L05MKys5VW1MUHJPV2lTeTFTTmJzTXZkUTM4b2RJ?=
 =?utf-8?B?eW1vMGRPZGxlbldpVjcvY3poNThFMndOdDVtcCtNanB1N1RKdW1Pbkh2ZSt2?=
 =?utf-8?B?b290eHpreE1WdmZ3WXg5MEFpNWYzYnlMNk53NGQvdVlYOFczZ1ZlVlBPc1p2?=
 =?utf-8?B?aW1JTGRYV092SXZ3NzZqdDUxbUJIczJ0bkMxNVBXS3cvc1BleDQvN1paV0Nv?=
 =?utf-8?B?anBJZkNScUtJRFlZc0wxMDZJR2gyZHFUZFk3eUpYV0VuaWlVcFhCTDQyNW9z?=
 =?utf-8?B?TjdudTdINTRpbStrT0dNZmcxelBHay95NmVhcXdzNEVTRG42WDI2U2NvZ3F0?=
 =?utf-8?B?U2FSb1R0c09qajVsZE85N1BUSFl1VmZVTHVJRm16YjQvUkxrV2xTS3lzRksw?=
 =?utf-8?B?ZVNET3hmY291cGlpYzQ3b2ZldHkrRnk3M25KNkxBejFBamFGY2x2WFBHQVRO?=
 =?utf-8?B?TWl2bDhaWDE3VTZsdzI4Wk9OeFowSmMwZlJrWk82M09ONU9BNWFXN2Z3a3ZL?=
 =?utf-8?B?cHBOTTNWT0FCTUw1R3hUblBKUjEvVHRxTVFRTGxIb0NNWTRKTUFFVEhSRnNs?=
 =?utf-8?B?bC90U3d3YnZucHNpT3pMZU92c1d1ckYwSWxadE1iTEo0NnFkcUUwbnN6Rm01?=
 =?utf-8?B?T0plMWlNZGpKa2RXazl4L3V2SUNsMmozc3VSaVd0dHpOOVNKZngxdnhkV1U5?=
 =?utf-8?B?a0VNM3hYNkVRenMvZnBFVEhwSnZpdDhvYnl2RlNOR0Q1Q0VCdk5OalFpVlJ0?=
 =?utf-8?B?T2NTVTFUVXBVNXRMSFBpemFwMm9RbUhmZW4xR2xGNmVtbnN2azh6MUhESlRW?=
 =?utf-8?B?UWU4VGErWUZGaTNLejNodEVBcFFOM1NlZmZ0bTRoMi8xcEM2WlVsK2l4SkVF?=
 =?utf-8?B?RFBmdVA5Ri9PcFh0RUxaQXdWLzBrbU1yZ2FUSURCdkQyWElPam5VaFZYemgw?=
 =?utf-8?B?dGhNeTIrR0oxYXdaUllXNk9qM1dYQTEzNjBMd1c5aStlUjcyV3lqL2dEYTEw?=
 =?utf-8?B?WjFyUitwN1N3SmJZV0pKRk1ndVd6eXk3UmNHMHFvMzczTFBPb2M1Sm56a0hv?=
 =?utf-8?B?b0xEZGNuV0todzV2QkdkcTlnRHE2bHQvb3I3VzZ5OGhtcGtjdGdKSDVzaTRj?=
 =?utf-8?B?bjlqdjRvSFNIMjFZOXBiRDl3M0lkVmk4clVWbkl1Q215SWN6SHdGWHlkc0gr?=
 =?utf-8?B?Tk51WElnTEpYeDZEMzh0NjMxNWU3bzRuQzRqRit2V0Z1Vm5QcnBBUFh4U0FC?=
 =?utf-8?B?Q0FycU5BRDBVeGk0NnBYc0M4R3Z4Y05hS210K1hTWmlxZExJZ2lZeUNGT2RX?=
 =?utf-8?B?VVJQcUI0d2Fvb2piRENkVjdQRy9JYXAxVXFLQ2FHdjZ4dVNGNXU4N204Zjkx?=
 =?utf-8?B?TGVIODFHOExTUkdyOURraW5RSU81M1BpU3ByYmQ2TmwvQjZaSFdKbkwxYzlx?=
 =?utf-8?B?aUhBM3NHOHBvWnNla1Bwb3VYWThFUnFlU0twSENlNlFwWXlKTnY0cWZ4N0or?=
 =?utf-8?B?cmVQTXlJdXZpZm12ek5GU2V0M3l1NktvVks0SzVMR0l4VUtsYjZienN3ZmdG?=
 =?utf-8?B?T0d0U28yOGY3cDVkRkFnZVRvSm9ZaEFXcE5YWS9aU2F0UHlVR0FvK3VCQnkw?=
 =?utf-8?B?UWpNZGtiWElBUUVvWkNsUzM2S0xRVW5GRmxGRk56SUtyamY0dVMwNUtTcWFC?=
 =?utf-8?B?WVljbE9IQmtoVmNTVllhdWlBVUN3VEp0bGliTmRGaWMwa3RVam8xZ2cwWlhx?=
 =?utf-8?B?TmJkL2ZtMzh6bDRNaEVLME1PRm91Q0xabmNwOUNGR3lwZWdxcjVPR3FpUFln?=
 =?utf-8?B?RTB5cGdwcm1sRzJUYk51K05UWXVoeEZ4QVNQOVNRMElEWEJJV01Zdko4Rm9n?=
 =?utf-8?B?U0pSMTNkZ0xSRHh3ZnIvTXZpU1l3SGIrbG8xT2FJRDN5SnFnQmhJYm5DMmF2?=
 =?utf-8?B?RERIODBUWjJYVVZWejhWcW51ckUvckdoWlRJQzJudjZJUkpIemd6eEVHWFZH?=
 =?utf-8?B?L0ZoNi9tYVhjWjZTQm95RWdlVlJSYUF4RkRsWVl1VHNuOXMwcHQxUEtOeWtw?=
 =?utf-8?B?bUdPUW9jSm5uaEZhVnVGek1qNVIyM0xlRC9YaGIraTE1QitqOWVYU0tCVHJE?=
 =?utf-8?Q?YftnLG22Ftl1q7Kslna8fBU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea4b75e-e8bb-41be-2c8e-08dc917782a7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:22:46.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4HmE83ZTMlbwd0OrjOqdHJHNsR0mPflCweW+nhzw1E9+HJk0N+lRJUsidXTFOuPbfMzg8TE02YdIiatgKf339c3Qn1ickw2yYedpV4c3i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10535
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

Hi Nishanth Menon,

+Cc Kever from Rockchip as maintainer of the arch in U-Boot
+Cc Heiko as maintainer of many things Rockchip in many projects

On 6/20/24 11:35 PM, Nishanth Menon wrote:
> Hi Team,
> 
> We have briefly discussed this topic on IRC[1]. I would like to
> propose a new boot-firmware repository similar to the Linux-firmware
> repository under the aegis of u-boot hosting.
> 
> In addition to TI, it looks like some NXP[2] and Rockchip[3]
> platforms seem to require additional closed-source/open-source
> binaries to have a complete bootable image. Distribution rights and
> locations of these binaries are challenging, and there needs to be a
> standard for how and where they are hosted for end users.
> 
> Further, looking ahead to future architectures:
> * IP firmware: More and more IP vendors are embedding their own
>    "specialized controllers" and require firmware for the operation
>    (similar to Rockchip's DDR controller, I guess),
> * boot stage firmware: Additional stages of the boot process involve
>    vendor intermediate firmware, such as power configuration.
> * Security enclave binaries: While I see a few folks trying to have an
>    open-source s/w architecture, many PKA and PQC systems still require
>    prop binaries for IP reasons.
> 
> NOTE: I am not judging any company(including TI) for reasons why some
> firmware is proprietary, but I hate to have the end users and other
> system (distro) maintainers have to deal with hell trying to make the
> life of end users easy to live with.
> 
> In the case of TI's K3 architecture devices, we have two binary blobs
> that are critical for the boot process.
> 
> 1. TIFS Firmware / DMSC firmware[4]—This is the security enclave
>    firmware. It is often encrypted, and sources are not public (due to
>    various business/regulatory reasons).
> 2. DM Firmware[5] - There is a source in public in some cases and
>    binary only in others - essentially limited function binary to be
>    put up in the device management uC. In cases where the source is
>    available, the build procedure is, in my personal opinion, pretty
>    arcane, and even though in theory it is practical, in practice, not
>    friendly - efforts are going to simplify it, even probably integrate
>    it with a more opensource ecosystem, but that is talking "look at the
>    tea leaves" stuff.
> 3. Low Power Management (LPM) binaries: tifs stub: another encrypted
>    binary that gives the tifs system context restore logic before
>    retrieving tifs firmware and a corresponding DM restoration binary.
> 
> All told, this is not unlike the situation that necessitated the
> creation of a Linux firmware repository.
> 
> Options that I see:
> 
> 1. Let the status quo be - SoC vendors maintain random locations and
>    random rules to maintain boot firmware.
> 2. Ask Linux-firmware to host the binaries in a single canonical
>    location
> 3. Host a boot-firmware repository - u-boot repo may be the more
>    logical location.
> 
> * (1) isn't the correct answer.
> 
> * (2) Though I haven't seen any policy from the Linux-firmware
>    community mandating anything of the form, the binaries we are talking
>    of may not belong to Linux-firmware as they aren't strictly speaking
>    something Linux kernel will load (since the bootloader has that
>    responsibility), and in some cases may not even directly talk to
>    (security enclave or DDR firmware stuff). I am adding Josh to this
>    mail to see if he has any opinions on the topic (but keeping
>    from cross posting on linux-firmware list, unless folks feel it is
>    OK).
> 
> On (3):
> Proposal:
> 
> * Create a boot firmware repository in Denx and/or GitHub (if
>    financials are a hurdle, I hope we can solve it as a community).
> * Limit binaries only to those consumed part of the u-boot scope.
> 
> * Limit binaries only to those that do not have an opensource project
>    (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on vendor
>    source or are binary only in nature (subject to licensing terms below)

FYI, on Rockchip, there are currently three blobs **we** use on Aarch64 
(i have only worked with RK3399, PX30 and RK3588, so they may be more :) ):
  - DDR bin/TPL no clue what this actually is under the hood. I think 
most SoCs do not get an open-source DDR init in U-Boot sadly, therefore 
mandatory until it isn't,
  - BL31, mandatory on Aarch64, a blob that is an old TF-A (v2.2/2.3 I 
don't remember anymore). I don't know the state for all SoCs, but I can 
say the RK3399, PX30 and RK3568 have an open one, RK3588 is one the way 
(but considering the RK3568 and RK3588 were released years ago, BL31 
blob is mandatory for a while),
  - BL32, OP-TEE. I don't think we support it upstream for Aarch64 (I 
think there was some issue around the binary format being different than 
the upstream OP-TEE?). Don't know the state for Aarch32 SoCs though.
  - I vaguely remember something about a miniloader but have no clue 
what is its use as I've never had to use it, mentioning it anyway.

So, BL31 and BL32 are blobs but based on open-source projects with 
"weak" licensing requirements. This means "Limit binaries only to those 
that do not have an opensource project" is maybe not the correct wording 
(or it is and then we can only have the DDR bin there, which isn't 
necessarily a win since we would have to fetch the binaries from some 
other places as well).

FYI, the DDR bin is printing stuff on the console, so we had to modify 
it (with a tool from Rockchip) to remove the gibberish breaking the 
terminal by setting the appropriate controller, mux and baudrate (for 
our products, there's no one size fits all :) ). The question is how to 
handle this since we cannot realistically store every possible 
permutation of that binary for each UART controller, mux of UART 
controller and baudrate (the only parameters **we** modify, but there 
are tons of others).

Cheers,
Quentin
