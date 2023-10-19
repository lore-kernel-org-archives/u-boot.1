Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9ACCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88FF871EF;
	Thu, 19 Oct 2023 12:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A8IWJHHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BF9871F2; Thu, 19 Oct 2023 12:26:27 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEE4871EE
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZTE9KOuaWkYVYalw/xhSNXR6KJgD+/QOtk3zQdSIgdNx37LwXcASZwxEIcqQ4vk2qonLdgwaVNWdSNXnSmCFaaExeKGxwby7CcM8c4LiuRu7k7BL21N0U7QyhoodNd2ZcmizGWI6RzpabTSYxJ0zUpRbMPbdsGGnuARH0rlZNInQmzjOcZaIallDE7qaakY3GBBXxCw+p2OXjj87iAFOTRTfQTr4A6XFPN9gCAizveFK2sR0fksxgUR0rEeGBL+o32fp5AIeNZaxeVNAc7U2A67u28EfhgEUorXNECM5AA7sVvgVbAM2ioqXyS3IUizi7zeqlcfSEX/cSfI4HotxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2Lvsrs7Skz4rAisojs8D5TKUPuGKI4TuKNBPQF2bEM=;
 b=JdneD0ps7/llNR9vhbQdJ7ui8HSxKft+VnxGDokQHvX0NdGf6SOVtOkhmTGJ7fkr0FQaOQG9HO2XwcEvX3DMOC+L8sN87xaF9nypBbZSqMTtYwZozbsGzsUUSnTLCrjE6/o/tVHHBWiZD9Z8motPDX6mKbeF3CABdn9rXQV0Zl77xziSjQS45JmSUQY+QS3M3h89MS79zc+QzJAUwUwR/XOVmZklufizcSbqBtm/PdbW8zQb33iPNd2h0OSN1STEtBoBpXF+ZfeEVPrVXFZ1uva/sWhRXtEmQmRLkre/jj4NCU0vy7u395T7CdHhFidpOc+YVbvYqeOr7883dHC3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2Lvsrs7Skz4rAisojs8D5TKUPuGKI4TuKNBPQF2bEM=;
 b=A8IWJHHt8HnuEMQF+xXkN6UigxuhErppUoXEp6jWB498SzAwPQ3vtgDZ4wR9pM7JcOqA3M/MI1jvJCXuYrCaL4lyGiue/0HCj8kwjEVELumrmC0Ral71zGqV6IziZIs+ECvJxVD4sJK4U7nmSjexAX/nr76V62k46gXoNlziSAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:26:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:26:23 +0000
Message-ID: <2e18301c-f372-4e7f-333a-38df450180bc@oss.nxp.com>
Date: Thu, 19 Oct 2023 18:26:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] imx8mp_evk: Add myself to MAINTAINERS
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
References: <20231018191742.1303779-1-festevam@gmail.com>
 <20231018191742.1303779-2-festevam@gmail.com>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20231018191742.1303779-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1997f3eb-4838-45fe-3603-08dbd08dd7f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUd5Vc34rUIrAauqe7NLdqpssz7c/Ax/iEgLisu9uEa9hFvjzDcS5k/he0yZCP1/H8jSlKrSAiue2yPj+8qaieNmjewQT9APSXz38zQFAdkrGWSy7bpjcHSiSEn+fU0yzJS9/CNUqCNAa3RVmGtSetDPz+RAXOrR2pQoh7ewuvIMMA0+qZKY8tH/wHIkaOHA7xH3wrTNHtiOI8GPGnk+chgPgdxG9wHnyx/XhC/C/VC8NnSZKhQMGzuaA/uRlYrlF1b/GUCc0RUzyZKNdoEd/oWgVplrPVkiU6ENlww5F31K5ZJDjfvU99DaxGlHp4HIemn37Xb1jjCZNV/5ER2QUBqPwaN7o5aE+nFXJuDGCX254GoPypPLWsJgxk4kJDQgM0isgi1c/x8YPuuZriJY1pWj4iQuzwiBSR/z9HFgG/LKzbWcZJ7yCgaNSW/jJ8mzp2Tof15byL3lFJ6v010Nm4cQ/FUpQiDwwT/KkqBR7lFACGGXWGWsTL3drZz5m0yRTLArjNMVxvU76oYmheXATMuH2DvMuotOg8hr8JuHZUOB833O4oiiMs8ryo43yUIlQ45DtgcUY1fbnPxFMjpOrPFXXRA3KTZqgJSymErYiN5WENwQCLN0OHhXd21ZkoYOq94hGrK7A/a97X3gKiPiJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(38100700002)(478600001)(6486002)(6512007)(5660300002)(4326008)(66946007)(66476007)(4744005)(86362001)(2906002)(66556008)(6506007)(6666004)(8936002)(41300700001)(44832011)(53546011)(31696002)(26005)(2616005)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZISW9GcHJwNmNMakV3VWNRVmJnUm1ISXFQcWxncHI0c09rNm1TZk1YNDBk?=
 =?utf-8?B?M0ZyeG5GY1NQQ1dNbTlha2tiaXRQR2doTklhQXlXaHNOVnZQbTNwVXE3bDMz?=
 =?utf-8?B?cHpNaVIyMGtUM3dERUN2ZnUzV2hLazdGTktxYVNQSlJEYnAraHlNaHVYakdK?=
 =?utf-8?B?RnhQMTZhTThBYWxqSEVSa0FmbHd0TkpRblBqNTRHZURGVnYxN1RXNkZwd1Rv?=
 =?utf-8?B?YXlQSDNwSjAyR0tDbkhxZXgyRWgweUF5Z0piM0JDaGFqK2FTS0VzWW9xazZx?=
 =?utf-8?B?amEyRUpMVDJOdzBTM3hxY2JjdDl5SERDVVowdFFyc3dHT0cxdFNoaEZFNzNE?=
 =?utf-8?B?emQvVGhvRVExSkVyUDFUQUpWbXg1SWkwd1BjQyt5bndDQVpBNW4wb0ZZT0M0?=
 =?utf-8?B?aUYreUNJMjg5RFpDc1NicWdnUkR0SnRxQ2RZb0ZKc1VENGlBanpEMXg2YlA1?=
 =?utf-8?B?d01jdVpreHZ1Z2NjWWF3UG1QWUtRcitwbW5JbnlCMThNcnhncnU4MFVJL0tV?=
 =?utf-8?B?d1Buc2wxamRvSElVRXdOcXJScGsydDExblN4VWRkMExZeTJDL1Fsd0VVU2Fo?=
 =?utf-8?B?NHFYVVJrUlJxZ20vWk4yZ09telNWaGVkdzljS2d3djZHV3k4WDR6ZjJLOXZl?=
 =?utf-8?B?MDlsYnpHWlpVRDFqSGJwc0hRTkVMc0dhYndPWDNhcFpCdU5zUXQrRlkyTFFs?=
 =?utf-8?B?aXBxS2c5WUtZQnROL3A2eGM3MFFOY1BOVUxTTXkvLzJkMml0MCsvV3FCUVRJ?=
 =?utf-8?B?M1hhUndRb3NPOFNEcUFqcVdFYXJwT0RlT3RSYjU2QWhqUWJpTzBUZHpnM3cw?=
 =?utf-8?B?WmpuR1NBck5TQ2hVNTJpVVRrMnVPT05mcEJuaXFkU2h0RVF4cExhamlJYllk?=
 =?utf-8?B?ZUxDVGhXZ25iZHVzR01iWWhidytxNWRKNUNKK0YySGhvSmhvcFRnWlhpU2lJ?=
 =?utf-8?B?dmNaZk1TRUJvdWQ4ajdwZ08ra01iNlFMU29nbWhRRzJlK3Z0aCtVbHVpMkhh?=
 =?utf-8?B?Zmd0cHI3ZzV0eEFGelB2ZEpmTHA0a0JBK00ybm9hWU9IbUdhWXZyNkpRK0dF?=
 =?utf-8?B?UzBLdk8vS25zd2ZyTHNqTUVNUEpmbHg4TDNraHBoUmtONnFYcGhZTjBEZ1Q2?=
 =?utf-8?B?d1BacldRTjlEb3JpWnRQZEpUVDJZa285YWRJU0dqUGtvVDQ0RmVzeHBCaXVp?=
 =?utf-8?B?TzlvSFNaY00yajBNWElGM2l2ZjVDNjdwMlo3OFB0cUtsZU9rbFM4bEs4M0dH?=
 =?utf-8?B?MzRSYzlvTmc1VVNYdVVZdmtQK05OUFdPWWovYmtKc05qVE5Oc1I5QjZjNjBZ?=
 =?utf-8?B?TjJ5UmwvQXhxdkN3bC84RmRJRWhsNWt5dXc2ZjRLSlQ0aHNMcnhSZXhtTS9k?=
 =?utf-8?B?ZWRVcTE1a1l4c0t6ZnRsWnRDaGxaaFp5OUlGUG95b2ZEV2w3VFUxdFZiVmpC?=
 =?utf-8?B?TTZ5NE9Ja0U1WkNBYVhzZnFqOER1WFJKWWlFMkNabU1lK1llb0pEdTNaYnF0?=
 =?utf-8?B?elJhTmsxdWFqN1lGd3dhalpwZE0yb0xhd1BHazBhenBrbmhqT1lGNkZUeW1X?=
 =?utf-8?B?bGdRWVZKOU0wWlNHeHZpelN0ZW5VKzJBM0xvLzZ5NU8vZ3hjVTQxQ0FrOHVt?=
 =?utf-8?B?RkNRR1hwT1pBY2ZtcVVnelZRYkRIY2ZiUXQwUWREaEV2bEVmM1ZmZVQ3djhu?=
 =?utf-8?B?bi9PTVRGV1BwTzZtNzAxK0Q1YnlGWWFaQk1DNnNyRmkxdzJHU1NFZ3Q1cnF4?=
 =?utf-8?B?VHZocWJ4Wng1R2MzTW4xeEQ1NHNiamI1QlNSN0QrVkU5SE5vOEJxNkQ0TnpZ?=
 =?utf-8?B?UVVMN3RXcWw0QWdDSTJCaldXL3RYMitiRi9wQ3lJQm84dUNmOVhMOGlvTUYw?=
 =?utf-8?B?MnQ2VEpTeU5xVmxzWDl6eWJLWTNxY3VOTGd4SzdaYmRXdHI1YUZrTnJjd1p1?=
 =?utf-8?B?U3RYcm1wbXBwMmVVNjhlVGt3c0djV2duTkdGTEg0eSt5QmF4SzAzMHdqTDRY?=
 =?utf-8?B?Z2tEdWwweFdjZkFYaDBwTjZLanFmdUtCbG5JNzFWY0Z2aEdiZU1hZkJnWmRN?=
 =?utf-8?B?UDA4akcvb2VJdFBHV2ROQ0xLZlZMRXFXdGx3OG53TEswekRORUNGc2ZzMlNH?=
 =?utf-8?Q?93AVVeEneU7yCOvubWkKAdVE1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1997f3eb-4838-45fe-3603-08dbd08dd7f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:26:23.8321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1/FGL5S3DvlA7X8l5jX/bosZwj+StI667GVm0NC/gKUCOQYQQVjWXbmlmBTG1+tqmgJ8bj4adgRrOwlcvgTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728
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



On 10/19/2023 3:17 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> I would like to help maintaining the imx8mp_evk board.
> 
> Add myself to MAINTAINERS.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Peng Fan <peng.fan@nxp.com>

> ---
>   board/freescale/imx8mp_evk/MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/freescale/imx8mp_evk/MAINTAINERS b/board/freescale/imx8mp_evk/MAINTAINERS
> index 2759652cc425..c2c7c830b5d2 100644
> --- a/board/freescale/imx8mp_evk/MAINTAINERS
> +++ b/board/freescale/imx8mp_evk/MAINTAINERS
> @@ -1,4 +1,5 @@
>   i.MX8MP EVK BOARD
> +M:	Fabio Estevm <festevam@gmail.com>
>   M:	Peng Fan <peng.fan@nxp.com>
>   S:	Maintained
>   F:	board/freescale/imx8mp_evk/
