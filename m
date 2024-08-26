Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D44C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F078188A92;
	Mon, 26 Aug 2024 17:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K7V5H+74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E29889C5; Mon, 26 Aug 2024 17:59:01 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6803B88A92
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE4hfOmvIvvAiYLVUOtNcrCXpTl5YbvM+CBcN1KNjLDay4yD6xXDRwmel2dgDdg8OS+jeKpXZO3/XuXssBpOb0LxnZ/YX6IPm9aKeqZBMA6BJuj3+MGMOfVIgMUdDkJR9ggl9+GhFeYAvQJrcNVdZUshO8/Nkiiswh39lvmMK2Z8Z+wIDySs9nA13Ap+9He3tKQZzxck6x/Sk5aixXtJpQF/hXcY+/gXG8/XJqI0auGhapna4IoRpK3plWSJSyPb0MJiGxFG94/J+/UN/zPElEtWs4h6vX39hA+fAdmE5L+1puDtJeorJBYV4UrfXUrt1G56PVTdf/Zcqmhhs7QoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoRbjkG2En+2b3MEq5eZbBt8vGkZnAHgO1jt3cRkabo=;
 b=TGtwQrBqI4sK+oqn+wP9O8qh2PrUnC773nQcSXw24NppUboNX6oqBE5fC7vKaxdBMzokGytFpkMCercLioQbBukfl625stsXa7btyauQ/EDYhU/DoO0K1r2neb0ZCRvPd974sI/zw2+vW9vAPAl1dazD8G9CaKNViDEV3Ipn9W296CRCy4XRgFqACuVA32Y0l2EeNgzLxEaksycxQ/GUiQWOTXHhGd/PYE1ZEG9Xtg7MZXAybhaXHvVKo+2ETsTJrK4qssAQ6x6tBDGrEc6FOx9twVeGOvac/dz4Kp+Ps/k4iQjostbhmGJxEXA0qS+Qq8gDQw1PqlaBkMPE8ku4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoRbjkG2En+2b3MEq5eZbBt8vGkZnAHgO1jt3cRkabo=;
 b=K7V5H+74hfayPSk2s+1TZjS6bejkihGbnPco81ClQ3gjjbLhqWpwp7v1JJ5m/qZSHkXHHS7axVw2SxupiVxsu33HChIiIWUOkamAMQ1b1pVodWoqLbA5oZEdhiAk2KWDhIrK6ZwxqM5dd/p783tIYIon5SqBYluQz9INT91y/fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10204.eurprd04.prod.outlook.com (2603:10a6:150:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:58:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 15:58:58 +0000
Message-ID: <1f963aa8-948a-4657-9f1b-a3bc38df4714@cherry.de>
Date: Mon, 26 Aug 2024 17:58:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] bootstd: Avoid depending on BLK
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Eddie James
 <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
References: <20240823204824.443631-1-sjg@chromium.org>
 <20240823204824.443631-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240823204824.443631-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10204:EE_
X-MS-Office365-Filtering-Correlation-Id: cd141728-f089-43f2-a1e3-08dcc5e7fea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bndjYjB6M0ZZaUFkOC83RkdQRG4vcklGQVdOK3RSMmgyU25ieXVlMEs0eTlJ?=
 =?utf-8?B?Q0JJVkRUWGZQK2NBbzNuODhRaWJXMTFJbE82NGIxcC8zMWNOL0xnVjh4ZnJN?=
 =?utf-8?B?ZkxWK1pCNFQyS3FKNkxUZDR1N2liR1pyVkFhV05zRU1lNXkwYVk4NVVZRXYr?=
 =?utf-8?B?ckVPQkdHOTVTTG8xbVBoRFhNNkg4Q29Fc3FaMHI0SjNtQWpzcml6UDhCdHBx?=
 =?utf-8?B?b09YQkFXMHA0dk1vVWFiREQrMVRHZ2NrUmdKQ3JIZlc2UG01dzZ2ZjdIMmZR?=
 =?utf-8?B?S01TUEhXWHFHZTBTY2FDNXRJSW8wM0d3N0FadzFGTFhMNkNGYmxmdzNhY2tl?=
 =?utf-8?B?V1FGY1ZhK2t4L2YrdndKWWtoZTJXdmd3Vi9HZ3RnRlUwcDR1bWx2N1BxaU0r?=
 =?utf-8?B?WTFXN29BSDdlWWhlVjBwQ1NsVE52djVLaDJxVEdRVzhIbW9UcGlSZmZsU3B6?=
 =?utf-8?B?cjcyenVmZ0dKTm1iVmVETXVLam1SWndvV0tvQjVKRysrMmJrTHVzbXBwekx4?=
 =?utf-8?B?TVJoTVFmR2FiMWo3ZEV0L0k0VTQyOHluTHJDUGduMVROZEJISmx5TUg0OXVB?=
 =?utf-8?B?SWxGWTkxSHlUTWRPSmxpMDgwNW81VGhldWZGamlqNk1YallBWnZpbDJ4Z2dM?=
 =?utf-8?B?dk0rQ2JGdFBzaE5aWWNsaHFYaFBOSFNnWCtXZTRMWUVvZFZKNTRGajAwUWdW?=
 =?utf-8?B?SjRZS1ErMkUrWHJ2b2M5eWFUckh2QXBjckRuSmVPMlFqVnBPRU10Q0d1RzF0?=
 =?utf-8?B?UnFhTkZycERURXYvdW9nV0xha1lQc1E5dEZDSUpFVTBNWExRMEZVUmFTS2pZ?=
 =?utf-8?B?NGlTc2pjMDJrbU5OQzZnT0FWdlZxTHJQTWNxbno4QUFrSUk5UFV3MWhBOFVl?=
 =?utf-8?B?ck4vZmoyWjlLU1JhRGE3M0plMGt5TGZuUEFNbmduWFNlUFo2RCtPTTRMMWNF?=
 =?utf-8?B?dm54VHpoQlhQV2JJRURCWmRrWlh6WGhtV05VTGV6Q2N0NVlESnBFVnk3Y24x?=
 =?utf-8?B?cmVDcDY4VlM3WnR2b0I1L1dOQ2t6RDJ4ekdsODN5cS9YNnJtM1gyVUZYcSs1?=
 =?utf-8?B?SGphYk96ZmozVlU4NzZNNkcyS0M0TWs0U1dKRmYxOE1aZk9uSUdsbG1oMDNW?=
 =?utf-8?B?cE51SGRoMDVUQWtWZE81OXY5VjJUYkZBc016UU8xNnVVQk92OGY4OTl3djZD?=
 =?utf-8?B?U0Yxb3BDWGl2NG1xWDd6aFN0dXVoYUVYMmlERVk2aVRDd1E0Vjg4VHhpeVRO?=
 =?utf-8?B?ekZ2ZEc1akJwY05GQXJ3M3kxMkxwSzhPa3RLNVBWdG5kQ0VEVUM5bGFCR2hi?=
 =?utf-8?B?ckJZdjE3NitxK2VuaU5KQzdoYTg4R1ptNzhsaW5KYWJZaDREQ3FXMW1JUWV0?=
 =?utf-8?B?UTV2aUFxMUw1ZExGdWRoZ09rVUFvTEpDWTRkalhVbkdBVTI0Wm1DRGZubTNt?=
 =?utf-8?B?YkRIakloNmtvcmt6YTByZk5YRG5VdWZQZlJMUWdnRTh6OTJTSWR4YXpaVE1P?=
 =?utf-8?B?R3JhTGE2OVA0bVJlSldvbTRoWHZldTRpTFBmRzl3ejA0aGY5SElWL1d6THpn?=
 =?utf-8?B?eW1UZ0M3S1orcmdzU2JoRWp5S2ZLbXVZOVdpaDM4UWYvUlFuYmJCTHFiYXpE?=
 =?utf-8?B?eG8xc002N0RGaXpvOHJuS1FlSWc2UWJDTEJUZC9MTzN6eS91bmQyOU4wRFh3?=
 =?utf-8?B?aHlwMVhuVHVrSjcyZDg3S3M1RzVSb3dDRVh2cmVROERoYmh2aW1ndGJKb2Vk?=
 =?utf-8?B?a2pES3pBN1E0ZGw0Nkg1SGdIYjBlOHBkNUkrdG5EZHVxTWxpWjkxWFIwRXZo?=
 =?utf-8?B?Rm52dUFsWFFvRmhVWmNGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNCMThnWTNMbnluTXhtSVBzL3FyUWdaNFdNTG5jYlE4V0IrTURDaXNldUh0?=
 =?utf-8?B?Y3ZYUExXL1BwQnQ3L1VKVE5CbFA4YWJGQlJuZ251amdLd0IwTEl4MDVGQ2RC?=
 =?utf-8?B?VDhSeURzRmRHQXYza2J5Y0FnTDJaNEhrMk1FSkgxaHhJbjI5MGNocUR5akFN?=
 =?utf-8?B?ZE5Pa1IwS2VYV1IyWVUvcUx6MnUwZVVLNjkvREZwZnQ0eVkyOGYra0VtRDNm?=
 =?utf-8?B?bzBGUGdmSWkyZmxJdDFqNnV1VTFuem5lQzh4b2oyYks0eWRoVzR4bURwaXll?=
 =?utf-8?B?Z05PWENNQXkwNWxyRWcxRGgwOEIyNUVFRHM4U2oxSEEvazZoMmFVZkpFV0U1?=
 =?utf-8?B?dkVoQlZNOTJPTjE4VmZ5RmJwQ05ubTJtR1hydVQrSDhpZWJKZVVWSWdNUm55?=
 =?utf-8?B?ci9EZm4vSytvNlR5dHZxbEV0U3FLN3h4bGpxQUY5WFYxZW16ZFJSbWtsSUZK?=
 =?utf-8?B?dllPaTlWenVMNjlLSnVjenpWTi8wQjVKLzlMWGFIYzlTZVlzU0Q2M1N4ZHYv?=
 =?utf-8?B?clVRVEpaNXYwRmI1VDdKNmZpVVRlL0MzcHFJQzAyQndsYWVObFhtUzIrbzlj?=
 =?utf-8?B?bktsT3FkakJvU0MwQWRoRUhHbEFyYWJGR0dsbWlWYW5jcVZTMUF4OG9RUkk1?=
 =?utf-8?B?TFJ2KzJIT2ZidmdzRXN5T1NRRU43bk9FMVVKa3ZxOGVQbTk5aVBvcHFhWUV1?=
 =?utf-8?B?VmNESE5yVHNhVlFlWCtXTm5qWkhQNlpLZXdmVzM1YW9TaHhqUjlBTjV3L0dO?=
 =?utf-8?B?TzlKUElGSnVFU2NnNGVXaS91L3lvMHo3VDgvdnFOY2pnMWg4VHAyQk4rQjdi?=
 =?utf-8?B?R09WTytnS25hYU9Rd0dQK3FGQ1J5YUR1SVZ4T1M1d1hIZ3hHSjZuS3JxaVdk?=
 =?utf-8?B?cUtYL05tS2ZER2llcVVHa0FrR0QzcEljakJUR3p0ejkrREFwR1ROT0J4NFcr?=
 =?utf-8?B?d2Qzc0VLMjRvRG9Dd1ZvWjdJOEFnTXBZa2ZtV3R6aWpaeUhXZktaNHpDU0Ji?=
 =?utf-8?B?R212Y3FmNmcrMDhkeEE3RkJHRWdaU3AvWWxPYUdjbzNFeFF2bHYwK0NnVGtt?=
 =?utf-8?B?dDZaODJTbVVIeUdRMUNVRUpjYzczMjEwMGlQWlhKalM4Vzg2RGcyZFhYVEFS?=
 =?utf-8?B?ZEFGK3hGRGtyYWdaY2l6VEVkaFJha1dhN1JLUFp3NWJmczY4UFp2MVJ1WnlO?=
 =?utf-8?B?NW5hMXZTamZFTFAyTE44K3B0WWFYV2JtYjEvOHFKd0toZzJUR0pJQzJCbEU5?=
 =?utf-8?B?dTBVMnZraXpBWDROdVJVMlV3NU5KVzJJUkVjS0pLSGFLOC9iSGI0aVJPVkFP?=
 =?utf-8?B?dWdDK3doMkVRME01bGF5Y3B0YUJiSUp0c0N0cTdhakF4Nnc1L2I3b1h6c1FR?=
 =?utf-8?B?UWVtZDBpdW5uVTErN1BYWjQxV3JFZkoxTjRpejJqcVYyNFFuUzFtTlhNR2NB?=
 =?utf-8?B?ODJhWFVuRjJCaUpqMEJPWGpBNW5sK2ZzeTl5TEQ3eExzNkVHa2lXTjJDbTVu?=
 =?utf-8?B?dTAvYlVkYXhMbHJPRWdFMzZ0LzhBUVVuMjBMNlJra0VBTHRHK1pHbVRmdEhq?=
 =?utf-8?B?V0hVWmFDQ2tNaXhQOE01MzExU2VBZy9aUFlLclpyQktGZDhmam9ERDkxTWN6?=
 =?utf-8?B?eW5YNDNBZFlNUzhmOE1WQlA5ZWpKMy9jODVPSlYxRHZJeHlwNDhhOHRCaWwr?=
 =?utf-8?B?OXZ3MDZpK1Z3TUduM2ZlMUF2U2VjV3NVN2VHMnRUQnBDb0dHbDZjSVpsbG1h?=
 =?utf-8?B?T1VmN1dvV2JHd1V5MDR2QytoTTVjcDBKNWhoWS8yWU81U3J1VjdkdGw4RlZL?=
 =?utf-8?B?WTlKMHB3ejBxaksxMFFTVmRDVm9zeHFqK2M5VjI4QlgvbXJDVXZFSkJyWHJX?=
 =?utf-8?B?Ui8zR3ZsSWFtSmFtWXdvZUtzVEh3WURiVjJmTUxzTHJKZENNN2hRYzVURWI0?=
 =?utf-8?B?WE16ODNDRzRRKzRaV2l2VUpNbGQzaURMSzl6UGpPNnptam5vQzhGMGJwVEtT?=
 =?utf-8?B?eWtSY3lzN1RDeENqQmpMZGwrYUMyTldRY3hWUTR6WmQwbU5sTXc3blh2RkpP?=
 =?utf-8?B?bFZ1eER5ZFBkN0RabWlVSW8zMmNTbU45THZ2M2piVVRwTDIzajNVM0FhNHZt?=
 =?utf-8?B?YzdiTmJoc3BxaWR3R2dhODV5WnFzM3JnVThFa0Zlak1SU2NLNVdzd2U5U0Vq?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cd141728-f089-43f2-a1e3-08dcc5e7fea2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:58:58.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciUWbETgDcGxGZ0W8mQuQWpvvekpotyEHFDFH01pK//0TgEYn2HXvLXrdFj+J8vjPO/x66ijDQwz+uKTGhDFpGI5QbMNsT96dgz687H37h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10204
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

On 8/23/24 10:48 PM, Simon Glass wrote:
> In principle bootstd can work without block devices, even if it does
> require driver model to be enabled in that case.
> 
> The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> is now defined, producing recursive errors through multiple different
> paths, one of which is this (with Linksprite_pcDuino3 and
> BOOTSTD_DEFAULTS enabled):
> 
>    arch/arm/Kconfig:7:error: recursive dependency detected!
>    arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
>    arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>       part of choice <choice>
>    arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
>       ARCH_UNIPHIER_V8_MULTI
>    arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>       part of choice SPL
>    arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
>    common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
>    arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
>       choice <choice>
>    arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
>       ASPEED_AST2500
>    arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
>       choice DM_RESET
>    arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
>       by CLK_RCAR_GEN3
>    drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
>       CLK_RENESAS
>    drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
>    drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
>    drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
>       POWER_DOMAIN
>    drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
>       BCM6318_USBH_PHY
>    drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
>    drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
>    drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
>    drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
>    boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
>    boot/Kconfig:398: symbol BOOTSTD depends on BLK
>    drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
>    drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
>    Kconfig:176: symbol XEN depends on ARM64
> 
> We don't want to revert the change to BLK, which has been in place for
> a year now. We don't want to select BLK in BOOTSTD since it should
> support booting without block devices. The only realistic option is to
> remove BOOTSTD's dependency on BLK.
> 
> Disable standard boot on the one board which fails.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> wip
> 

wip?

:)

Cheers,
Quentin
