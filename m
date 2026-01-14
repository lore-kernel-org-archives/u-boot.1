Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8440D3900B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 19:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14518803F5;
	Wed, 14 Jan 2026 20:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RAs61oTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B2080433; Wed, 14 Jan 2026 19:16:17 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC0680325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol3LiGpIIroD29hFCt5ZmjolhtV/DMRj6kIb3mSIStp9fsS6Ns7UpAhJzayrMIkTkwNvlk88ki9AqV24Ldh/tspRkK9AEhLsNl6j4D7GgIXukpNWOiOBpF7i8bRrOx2L+PbXWovzxzDo7PSq3ceNAF4AgfUtYZJH3gHda24wSJxFUltNmiPGpdQZU7zyFOS/axJMfAePWtE91RULh+GdiLjOka4V3olJ/day00TsYkukYS8XocbBTPq1Ft27VM0ylVZSREYInHAkO5TFJjlreCmjuhHU16PyaMotKK/46l6YSBi5ezBed1tgyMdoEN8VIzwZfvTLor8kwMyEZGsmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aROJNaRuSU/AzJLQIvTDj9VUVnapNH3Xp2O+k7FoUDk=;
 b=xUylcnog55K3ZayWncs4HT6BA1QMkvwxxpALmlqRBUxub18MVTm55SUGyLL2Fme7CWH93/j3cruq36BCw/YGiqLu9esE4KyoJ9cm3QyxvMNaR8sl3AdTBpeZdog2cOVS1qMmKh7UXuUyuZyROVw+k6T7JYoTbm+o24ZzGf1my19A2uY5AMAjkaO14zsdmF/33M4I8RcQbyi+cSVc0Wf8THL2D5z1wRydaPLGF+JrwMG05sZzjz98dwQ8x4DpEWTfJ77HgtHmmzTAPIoXKuk8TNSZECiT83JPKtCjyRWi1onXc83m7X9C75iROuSxz6E6rPqf7+BdvaTWzFU1oTWCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aROJNaRuSU/AzJLQIvTDj9VUVnapNH3Xp2O+k7FoUDk=;
 b=RAs61oTVm16va9y8a7KXlonz+7FOw8PZqOJ0tJAnyC9/6R2bKNy7SlQqnHlGk3+t4op34yHC3MPgIKJF3tA6SWRxBdsIIaMGUGMQr2uMcTJy57R5TisZeAnbXIr/y7y1QHQWqJFHX6sQjpYgUaSPNHvArm9aaSGCL1unnhVBFpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8969.eurprd04.prod.outlook.com (2603:10a6:20b:408::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:16:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 18:16:12 +0000
Message-ID: <e28f332d-72a6-4bb0-82d7-103118410e2e@cherry.de>
Date: Wed, 14 Jan 2026 19:16:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] spl: Make UFS available for SPL builds
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-rk3576-ufs-v4-1-e8e67649f3f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f34798-84c7-44b5-6296-08de5398ff70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmRJSFplWVJCSGVucGJYNDhYZDFOdUhCbjd0RkdYRlBWOXhWc1RDc0wwbnlC?=
 =?utf-8?B?cEhDaWRteWVyL0JxYlBaYllkT1FnSmNUV0JLMGN1Ti9ibDhnb1hWN2lBK2tS?=
 =?utf-8?B?bGJ0WlZ6VmU4UFdidTdNczdnV2pvdG9FeDYyeVlLK2g4dllwNzZWMStock4x?=
 =?utf-8?B?QWJEMnl2aGhqMHZIMTBmMGIycm9sRWFIODR3QTVFNUxwS1k4QXlXV3RIdFEr?=
 =?utf-8?B?TUxYZVlFVUJlTVg5L0NUTVZnNTRRdERFUWN2bS9IR2VKSVNVazVsRXdjUkp0?=
 =?utf-8?B?cVJacWRKSDFLRjdXblhIRW8rN2lOYmltdm1weCsrWEltYThEZkZReFRQc0Y4?=
 =?utf-8?B?UW9YbEM1YUJSRTBVVXdHaWt3d3JYZkpVKzBjN0FudS9lNUJkZy8yRUxaclQw?=
 =?utf-8?B?NWZUai9GcnVVT2pOTUhDRmdUY1RLQnNyemZ0cUZZSmhmUWRocVNpMXZKVFps?=
 =?utf-8?B?a0FtVW5FU0MvK1RiMjZ4OEprSk5XK2FmM1o0eDQ2R2Q0NHpITHk3dExNMU1y?=
 =?utf-8?B?eGV1VDZxUThic2hvSTd1N1R3enRNeXZqY3hSUWFLN3Z5cWhyRmFiTUZjdDNu?=
 =?utf-8?B?TGE5aTN4dGlsc3RjSE9pWUQ5ZkQxcE10Ni9mdndYU1ROQWJ2dDczTjlEaVZy?=
 =?utf-8?B?cUxnWDhVdm9RZjFvLzBTakpJaDhaQmIyVG5YSWNtamZJaS9iYm9tUjJqbzVQ?=
 =?utf-8?B?SS9WNEdpWDQwZ0xZTGZUU2gyRU1hNDk0SHRiQjMwRGg1akFZR0Rja2VtQnpS?=
 =?utf-8?B?NkdQcDJrcWxoUTFRVjdyK2VhNnVRWCtnT0JQWld5S2x4NU9jWWRWS1Arc29w?=
 =?utf-8?B?Sm1mZDNiTHNmYm50K21DOXN3RENRRUp5Q1V4RGVYUlNOdUVBSmlRRkF3bEJD?=
 =?utf-8?B?b3BDS0N3UjBGcjFDeHJtbGczbzVVeFc2L2M0SGI2aktMV3FtSk5lRWR2MjIv?=
 =?utf-8?B?c3RJczdZZXFGWG1aSU1JMUZvSWE2YUplVmFSQzMwVmo5cDRGM0J0dXNWY3lM?=
 =?utf-8?B?NGJyS3ZQaDFtYmRrREVFV1hBa2x1TjBtZTZYWnMrNGw5YTBOMkV1UmlsWEFi?=
 =?utf-8?B?c2thU3YrRy9RZm5aNjhTSkhTdm1FWHZaUmJxL1FDZndFaFhvZ3VxS2xDZEto?=
 =?utf-8?B?T0JjZFdzaVBJQ3ZwblRlak41SHNva2ZsMnFWUmZ5d2V1Y3ZvWWdrVDN6bEJk?=
 =?utf-8?B?aE1uUTdhZ1hndG1qc3pPWWQ1V3BoUW1BdUhhTnM2OWliaTVsZkhiMjc0R3N4?=
 =?utf-8?B?NEdyUCtGaEV2TllUQi93SFhjdWk0ZGtYMGl3OFlLTFh3dG8xQ0h6Vk1taVZJ?=
 =?utf-8?B?UFVVclhGUUVtdEszaEczbThjOGNyTFZjclhVdTRwdlk0SC84SmFtbkFkUE1z?=
 =?utf-8?B?clJ0NkFPUlJueGM3eEI2aWdCQVR5SllVR1J4dkhReW8wVkFkcVNEdFpZVmpH?=
 =?utf-8?B?ZHdWeFY2dUN5VDB4cTNqbFhJUW14cFpNcmhybkxoY3QyaGVHSVByWkpXU1kv?=
 =?utf-8?B?VEMvaU1mdWdyRWM0clc4MUU5OVBtc0xBLzU5TDRqVyt1VmxzYnplbFB0SXpR?=
 =?utf-8?B?Q2Eyai9lRzd2d0hsWUYrZUlGWmJFQm5aMGw3ZXhrendyTzErQS9RS004ci9W?=
 =?utf-8?B?U3lBU2JlZkpBUW0rQlRIcFpMaHh6MjkrMllNcDd1c1V4emY1eGVGNjFUTWFl?=
 =?utf-8?B?bWlNL3BQcElKZG9WMFJIR0twZHN5QVlZd2tmRzRMYTlEOVlpWlUzdkZyZ2dM?=
 =?utf-8?B?VUt3cFROeVlwcjJLRlpOM0tqTzQwNEN4NFlrckVmYm5pbVJBOGw1b3ZuZVFo?=
 =?utf-8?B?bHluWnVtUlV5eVBhd1lqT09HN21ud1dIdUlKdEdRVGRueTZLNVBKbDcwbVVG?=
 =?utf-8?B?Uzl6TldLcTlSclFzSkdubERRT3JBRmlnaTM5dGF1NzdsNzNpL3VzbFhZb3Ez?=
 =?utf-8?B?R204YTVtNFVsMEhPQVkrWVJPUmlXanVkbDVqUTZEb3ZrcHlWeDNyK2xzZnpM?=
 =?utf-8?B?cEM0aFFDZ3JrUERrMmdkbytKZW0xMElkTkYyRnpIejUzVWUybGVFNEg2V0dk?=
 =?utf-8?B?d05LL2w3Q3RURWlUcmlTQVlzbFV1eEY1cFJhRlp2VXFGaE5MN2hac1NPOXdL?=
 =?utf-8?Q?AF9k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdydTNmUjMxaTRrSG1MUEVaNmFNdTJ5R2pNZFJKYXZpTzFkbVVQQzN3MEZQ?=
 =?utf-8?B?ejQ4SHIrQVVDT0xmVGxwVStWZzFYNzRUSW9rK0VJRDlBSllTdHlxWTBuME1o?=
 =?utf-8?B?V01SQ3BJdmU5cUZlTERIRzlnYnVycGlQYnhWS0pHYno3UnBjVWZzSVVrVXVD?=
 =?utf-8?B?NHNPR2E0c0pIYW9mRUptM2FOSkhSWFAvWVY3eWpoZVkraHNrNGdWcUIvanZt?=
 =?utf-8?B?NHJwVHdEWVB6RndIQWlkR3BxbklJcGRKUm9GQ2Q1NWpqRUFuVHRpK3BmaXJB?=
 =?utf-8?B?a0xUeUJYcXVOSXZiKzhxYi8rb3RzczhJQmpqMW50bUFvbURlQ1NBU2dwSi9Q?=
 =?utf-8?B?UldxYWtHWjExeWVFbjVqZWY2eGIzOXh6N2ZyOVhLcGp2VFFnY0RxR0o1R3pZ?=
 =?utf-8?B?WWNMK2tZVmpFdzRzUktFcEp6ZWoza3pKcFl5aGhYenNsaWl2eWRTdzFLVmJH?=
 =?utf-8?B?b05sUjk4V1BjemN5RzlCbmozclhFKzlKbUFYL2JOcExmUmJSUk1EeEgyeVdp?=
 =?utf-8?B?UjZQeTdUYlJqU2xTU0lDMDVRNklNbUNtMG1MajFKUGNxS2Roc2NTSVhBdk0r?=
 =?utf-8?B?SnZBem1GUXEwVW51N29RNXhtYWhTWWpmVkpEdHkrTzlkYzJadzFVR2FmWW5F?=
 =?utf-8?B?cnpjS3pDeHE4RFFEY3dRVTRmc3ZZL3RuOXlzcnkyTVRqdWthREVDc0xIL1BR?=
 =?utf-8?B?VnNHdXVUNlNBLzJ0MGJSWlBjajBpVWpjMU5ZTnVzazJESWFXa0F0QytSWExU?=
 =?utf-8?B?T0Y0c004RGVjdEF5VkdaamNMb01hK0Y1N3o3QUVSSE13KzlGeVYreTBibXQ1?=
 =?utf-8?B?OWNYY1ZnLzZJclYvZ0twSGlkNkNmQVhkNEZHTFBUdHREb0ZVRWh0TWJOa2Zi?=
 =?utf-8?B?bE5yc0krU2t4dVovVktvSWx6M3dFd0tPRTlqdkg2VUVDbkdrcGNtU2FjeXZH?=
 =?utf-8?B?ZHpWVDBBVVVtS0ZEbHFZWG5PalI4cTVkM0FkK2d5c21TbFozSCs0dUR6Q3V5?=
 =?utf-8?B?ZDN1WHJFZ09iTDNFVzdMaEZ1T3lBcitYRHQwZGtKNjhDcElFY0NJZVVVRWVo?=
 =?utf-8?B?OHdNUGxIaU00L0lGOVhlWEFzNEFzU1lBbW9xYmRka2dqYkt0Q1AvTnlWVW1F?=
 =?utf-8?B?Qy8wZ1BtN3lzOEtRNUF0MU5PQzZySHJienh3UXdrbjFXMG0zWkN0azNZanZm?=
 =?utf-8?B?RGF2VmZNVjBVc2tmVy9QTVY2T3IwSDVNOHBMS2tVUEtvNzRmK1g0ZnljQU5U?=
 =?utf-8?B?Y1NKZXhsSm9MekUyelI0U09UcGpZTUlQQWZQL3kvS0NKNVIzMUxGWGlzOVcx?=
 =?utf-8?B?Rlc3cW9Za1NXSXNlVDhaV09QZ3IwSDBjbGY3R3B6WmNvRUZ6aTFhM1ZkbTVt?=
 =?utf-8?B?eDdNdklPQnhyY2s2NDZXZGdYbmZIS1ZOcjlFa0w0NVJOSUtCMXRYSkJiT0l6?=
 =?utf-8?B?Nkw1YXhHNzQ2WEQvVlhqLzVwUzVnWUdhc1FRc2ErODdtR0ovQ0lmU2RBSHQw?=
 =?utf-8?B?d0M0aXFxUEdHaS9yV3pZZmNTc3VVNE5rRGhJSm5USk9mRlRaYW85TzZTeFJs?=
 =?utf-8?B?b3VORm8zWGlGZ0k5OFhSZUVCOGtjeis5cU1lRFBXVW91U1F2dlVjcS9YZ0Z3?=
 =?utf-8?B?bXVraDYwdVJjY2xVTUhsdHdiMThJVUloOGp0OVpMa3ZDU3F0U2FNMG1qa1Iy?=
 =?utf-8?B?RDB4SzNWY0l1bG5PU2doMmVEbmVLWkZjdnNZS3M1RjFTbDZnRUZ6QnJhTmVL?=
 =?utf-8?B?cTZ1Q1hZaWRVb3JNU0hIMjA4NUZ2TXNkRlZyNmQ1QUpQZVV1NU1TQVA4Si9o?=
 =?utf-8?B?ZERZTHJuRnJMcTVrcVFhZUFaczRrYTY3TWJtQXV4MmVYRm1ldm1oRkxLbFFl?=
 =?utf-8?B?ODYrWmFxSk5NQ3RJM0tLZDVYSmROeXhIVGQrTVRkbUtXdFplV2lsVHpiZG5Q?=
 =?utf-8?B?MVpzM1NOY0UzQS94b21PMGdKa2wwQTVtRHIzMXl4ZnV0Z0xFU0hrT04zMjJj?=
 =?utf-8?B?UzY1MnovT3ZMQUFkMmpDWTI3ODhOY0QwNTVIdnBrdDN4UkNKSGZ2VEJjK0NF?=
 =?utf-8?B?MGdCa2E5QXA5RUUwbUJTT2FFc1dvb3pQTWFleHdKMElORkV2VllMeTRqd1pa?=
 =?utf-8?B?WmIvRTJJaEJ4R0cvYzhsb2dsUUNqR3A3VGVNR1VzRUE1NWlLbkpETlFuWXJz?=
 =?utf-8?B?d2lzWVJRaDNXSVI3OHdMeEhxdENPZ0hzWThlU24wNlFqV3JCdSt3ekY5SDRM?=
 =?utf-8?B?T1BZaGd1bGMyNmVyWkRlb2k2Wlc0NkhVVjhiNmU0SzEvYUZTT1BHNTNackNt?=
 =?utf-8?B?a2lFeVdoWUN4cklsZFd5RGtjYXlHUnNGRzQ5Zkd6SUFtbHBWOVR5Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f34798-84c7-44b5-6296-08de5398ff70
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:16:11.9621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWe+J80dIGh+QGux7r/z27cbZm+la4tJPYereC6MfYilAn8dg24KKHB8ufwuC3pZurA2Th/dNJUYGuojindNcUATjGBN7lWXZIltnEy5HYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8969
X-Mailman-Approved-At: Wed, 14 Jan 2026 20:34:42 +0100
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

Hi Alexey,

On 1/8/26 6:49 PM, Alexey Charkov wrote:
> Add minimal infrastructure to build SPL images with support for UFS
> storage devices. This also pulls in SCSI support and charset functions,
> which are dependencies of the UFS code.
> 
> With this, only a fixed offset is supported for loading the next image,
> which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> number of 4096-byte sectors into the UFS block device.
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   MAINTAINERS                |  1 +
>   arch/arm/include/asm/spl.h |  1 +
>   common/spl/Kconfig         | 29 +++++++++++++++++++++++++++
>   common/spl/Makefile        |  1 +
>   common/spl/spl_ufs.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/Makefile           |  1 +
>   drivers/scsi/Makefile      |  3 +++
>   lib/Makefile               |  1 +
>   8 files changed, 86 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27ce73d83f48..ca31e57f018a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1861,6 +1861,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
>   M:	Neha Malcom Francis <n-francis@ti.com>
>   S:	Maintained
> +F:	common/spl/spl_ufs.c
>   F:	drivers/ufs/
>   
>   UPL
> diff --git a/arch/arm/include/asm/spl.h b/arch/arm/include/asm/spl.h
> index ee79a19c05c9..dd462ea6ad82 100644
> --- a/arch/arm/include/asm/spl.h
> +++ b/arch/arm/include/asm/spl.h
> @@ -30,6 +30,7 @@ enum {
>   	BOOT_DEVICE_XIP,
>   	BOOT_DEVICE_BOOTROM,
>   	BOOT_DEVICE_SMH,
> +	BOOT_DEVICE_UFS,
>   	BOOT_DEVICE_NONE
>   };
>   #endif
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 4f4119f5806c..6a82260dd010 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1612,6 +1612,35 @@ config SPL_THERMAL
>   	  automatic power-off when the temperature gets too high or low. Other
>   	  devices may be discrete but connected on a suitable bus.
>   
> +config SPL_UFS_SUPPORT
> +	bool "Support loading from UFS"
> +	select SPL_LOAD_BLOCK

Doesn;t this depend on CONFIG_SCSI as well? Like it does nothing without 
it (does it even compile?), see changes you made to drivers/scsi/Makefile.

> +	help
> +	  Enable support for UFS in SPL. This allows
> +	  use of UFS devices such as hard drives and flash drivers for
> +	  loading U-Boot.
> +
> +config SPL_UFS_RAW_U_BOOT_DEVNUM
> +	int "SCSI device number of the UFS device to load U-Boot from"
> +	depends on SPL_UFS_SUPPORT
> +	default 0
> +	help
> +	  UFS devices are usually configured with multiple LUNs, which present
> +	  themselves as sequentially numbered SCSI devices. Usually one would
> +	  get a default LUN 0 taking up most of the space on the device, with
> +	  a number of smaller LUNs following it. This option controls which of
> +	  them the SPL will attempt to load U-Boot from. Note that this is the
> +	  SCSI device number, which might differ from the UFS LUN if you have
> +	  multiple SCSI devices attached and recognized by the SPL.
> +

I'm not verse in SCSI... Is the device number guaranteed to be stable 
across reboots? Is it probe order dependent? If that's the case, this is 
not a useful symbol and we should be trying to figure out a way to make 
it stable (via aliases for example, or using another mechanism).

> +config SPL_UFS_RAW_U_BOOT_SECTOR
> +	hex "Address on the UFS to load U-Boot from"
> +	depends on SPL_UFS_SUPPORT
> +	default 0x800 if ARCH_ROCKCHIP
> +	help
> +	  Address on the block device to load U-Boot from,

s/,/./

> +	  Units: UFS sectors (1 sector = 4096 bytes).
> +
>   config SPL_WATCHDOG
>   	bool "Support watchdog drivers"
>   	imply SPL_WDT if !HW_WATCHDOG
> diff --git a/common/spl/Makefile b/common/spl/Makefile
> index 4c9482bd3096..e18f3cf09484 100644
> --- a/common/spl/Makefile
> +++ b/common/spl/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
>   obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
>   obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
>   obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
> +obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
>   endif
>   
>   obj-$(CONFIG_$(PHASE_)UPL) += spl_upl.o
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> new file mode 100644
> index 000000000000..6b035db13c41
> --- /dev/null
> +++ b/common/spl/spl_ufs.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
> + */
> +
> +#include <spl.h>
> +#include <spl_load.h>
> +#include <scsi.h>
> +#include <errno.h>
> +#include <image.h>
> +#include <linux/compiler.h>
> +#include <log.h>
> +
> +static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
> +{
> +	struct blk_desc *bd = load->priv;
> +	lbaint_t sector = off >> bd->log2blksz;
> +	lbaint_t count = size >> bd->log2blksz;
> +
> +	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
> +}
> +
> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	int err = -ENOSYS;
> +	struct blk_desc *bd;
> +	struct spl_load_info load;
> +	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
> +	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;

Reverse christmas tree here usually (so longest line at the top).

> +
> +	/* try to recognize storage devices immediately */
> +	scsi_scan(false);
> +	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> +	if (!bd)
> +		return -ENODEV;
> +
> +	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> +	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> +	if (err) {
> +		puts("spl_ufs_load_image: ufs block read error\n");
> +		log_debug("(error=%d)\n", err);

Why both a print and a log_debug?

Cheers,
Quentin
