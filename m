Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936AAD1266D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 06:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B7B83F3F;
	Wed,  3 Dec 2025 07:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XEZYaqf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C15383F4C; Wed,  3 Dec 2025 07:46:35 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE7D83F2D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 07:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK6HwN7haZS5WFt0vpX/QkJwqI2sJkTPJnykbNKU5O4dPdqhg/GbV6Yryx8paoNU6KhKMNIedT59PZbuCPjebs3N87Va9nQnqpFLr7zSCFcJAB7FPZVTDAgn8JS68zWKbLrwvTy57oVHIlobmwgaxOI48XgWDHqs8vLMfwlEfxzXNuPVysJ2TYAXgwFK9RBB4sgOXTqJyvYbmipAOsPOiHcUqYnjFzh6oBwX96gbNPe/0uLvRC28Ron63tuLsVxhiEJTv1SKDvc14sk8txAKitI7MvjmraLtV7sYVnI97Zl593z6i0/QffA0wMNMpK2ZIew0jmvXFyUvMyb6qyozzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH3BMagNdKisgxOIkYt9oxx7h6Cxz444ybU6zI/PzPk=;
 b=AZ8XKNtJx6ppGtaQd+RR/Hiork8WJxD0EeBDzncIR02xfOIPDwEBlZ4RJN3ZyWuVJiw+H2r+Xoxo7jkij4Wok2D29t0dQAwr17uvVcyuivswqskQyI4vzaxp5OHgjVKF6zjcSFFIBcsbDkvJ6aWyL4vnfy0/fUfUv5d6SV2rwSwmyVCCRjstZRluEzpZqEJs5spd44m7RAS57PrrkkWcU39AzFlz8e45KmJuthCXwR3Eefq6Fco/nzhmokC9YgA2rZJCcQLIQpMCQNCTmjmDzjnnlR7WsfwGEUW7U53LgHjb29YoNGHmVEY+1Gs3goEkWcTykebTpA9BnR1h5y0a4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH3BMagNdKisgxOIkYt9oxx7h6Cxz444ybU6zI/PzPk=;
 b=XEZYaqf+V7QkS94S2gOA908IEaoBRERUGzkmNA3ZUK9dLyMJWZrzgyOgnIOR5YNRerDUJ3kO0h1e4JMdPSuPsSvnS0oJ92fFQM4VBSkjWv1siZgGo5eueMG1iVOCLWOc/xw/qVhPwOLpSLoCQhOhmOu/2WEHz2nhEdI3ygDHjazwxs5CJ7pUJhBvG601QzBzpmvYdJkU88h/xTrScxTDjTUKpGoh+u0+HC3eB33CF8zU9IFuXuc0ZU8h+tmq9ClWokgr7u7+EchhzLqqcBQIgT60nA597mzR/jBDxaotFtQaPBUh92/7vviXwb5PKnKavILcI5mCSUuVgnOxpjq7Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by IA1PR03MB8061.namprd03.prod.outlook.com (2603:10b6:208:593::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 06:46:30 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 06:46:30 +0000
Message-ID: <d481c4c4-76e2-4b6c-9bef-19c2d616fe23@altera.com>
Date: Wed, 3 Dec 2025 14:46:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Sune Brian <briansune@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
 <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
 <CAN7C2SAEZgm8KshbGU3d48U3w01vtG5zvbzZRbA_3tE5S0E+Lw@mail.gmail.com>
 <CAC_iWj+Jo1fP2ucXPY+q6+rFhHsT3PKz7H2J4dH-3cyAk01HEg@mail.gmail.com>
 <CAN7C2SDDAtxfDiHUac9q-WfB8jr_eRPDKcbfrtbcyXDbdV7_nw@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SDDAtxfDiHUac9q-WfB8jr_eRPDKcbfrtbcyXDbdV7_nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|IA1PR03MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc4ff6b-e7b7-4859-07e5-08de3237b057
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkhWb1JYSUtsR2pzTUxLUFlnZTBxbi9IQUJneHBwMlVRNjQ2MjdPL2F0R1pR?=
 =?utf-8?B?SER1UEIwQlVuaEEvUzJQTzdCQ1VtdmFrOGVmUU5UVmJsQkw3dStCRWNKWFV2?=
 =?utf-8?B?N2NTcUhoMzJ1YWQ1TEl4MnZFdDgvdjBWbGtlcHd2NTFmeUJVWlRwSGtqWjlG?=
 =?utf-8?B?WnVHYUhCVTNoMUtBaGVHelZhUTNER1pDUkk0UjVJdlJYcHhVazBkYW9FMnJk?=
 =?utf-8?B?WDd0NDY0NlVZZnBJbDFaVlNvZWFQdTJwWG9PekpKNHIzeFNvVmw2NnRoTGhM?=
 =?utf-8?B?M3M4QnpMVmFoeHlRdkxNVFU3T3M2Zm53aEhqek9BWVlTbWptQnBVTm5OYkVY?=
 =?utf-8?B?ZE1Vd1ZrMWxSNGowd3M3cW9mdkVhT0ZRUDdoT1RrQ0VTb0draXI1V2tWOHJF?=
 =?utf-8?B?cG1xMlhhNkJCbVcwWUJETFB3WFpLc3g0RUV3SWNodXhHOTlBbUcrQWVlajEv?=
 =?utf-8?B?T3JmQUttMlZ4allUU3AvSUlySEdJU3I3ZjhkRDJ5b0xobkw5RlErRlZzY3No?=
 =?utf-8?B?SzhmaU9KZ2NCMFg1aDZiOWQwL2dnY1FiakZsVFkyQmUyYk1HN0RQUCtxOE5k?=
 =?utf-8?B?ZWFUaHpob285czdqTGhzajIzOUhScXBtc0NlQjg3SWUrR3BEK1VTa3Nab3dw?=
 =?utf-8?B?VFYxOWM5b0cxbXpnSk14ZUE4KzN4bGRycjdXSDF3TWI1U3lQdm45dG1WaFFv?=
 =?utf-8?B?Y1I0ekZ6aWZBTk1rZlJVdDBiTzAyVjQyNlpmK0sxYVYxenlPTXZKVGg1WTlY?=
 =?utf-8?B?TWNBNFNaMEJrZ25vR2dLc1JCTW9lejRLdmlhUEVmbUkzdi9PSzlWVTNMVlJ3?=
 =?utf-8?B?YlFNRW5ZbFpCaFZpNHE4V3FHN1dSZFJnVmx1UVN3SzJBa01JZmVlNTBxbVNV?=
 =?utf-8?B?YmxybmZub2pUUzlJNTA1K0tOUWhWTm5Wa0cyL0NRaXZ1R2ZrdTZ4MEQvM0sr?=
 =?utf-8?B?bERKbjdwTkFKb0xUdG1IcWtBOTlSWTV2Q3JLc1V1UnM5ZDRnQmpHTnhVUVhY?=
 =?utf-8?B?YVhvTVhrdllqME1pbUxsTzNyaG5sQjUrbllMUUk3RStSc2V3djJMaWQ1WmxJ?=
 =?utf-8?B?dDAySUpXcHpyaWJQZ05YYVlCcHNkYTBvRkZkVjZoT1ZDMDZ0RnhsZVF6cTZZ?=
 =?utf-8?B?b016M2tLcGdSTXRMTjlRQXpwZkxEUUlaQzJ1RnZXRkxTTlFGNFYyUm5PVFlX?=
 =?utf-8?B?T1AwV2xnQXlVSEdKLzFJUEpqaytjd2hqYUhxWk1mN1hvWTN6SlB1QThnNTFh?=
 =?utf-8?B?SkU3Zk9aSDg4VUxWbnF3ckl5Mkx6MzBWaGtPL1BIZnNqcmZISWkrTUZxYWpE?=
 =?utf-8?B?Q3VjRGRaSFkwd2o2Q0ljeVg0WGplQXJ0RC90eTlLNUtQTEZKczhLcnJaUUUx?=
 =?utf-8?B?dU4vbHo1VjFyemd4SElvY0FyVzY5eW43cXovcFpOdGVleXFBcDFHMnErRyts?=
 =?utf-8?B?UzVPbFI1ZFFTN2lzRFhkWGtHQmxsN3p1MDVpcklHaFE4TGltTnpOVDl6WTYz?=
 =?utf-8?B?WTMzQXMvZVFXaU1zdWZ3YTZQZEZQMWxJb3BpQzFESHF3VXgvdzNuNitHT2FI?=
 =?utf-8?B?SlpuTlpaQmcvaER1WEhGdkRCVStoOGRiY2JiQmMyamJFMlE0a21JZ0R5UUpa?=
 =?utf-8?B?WFFRZnVKcjVOMVowd3U3T1EySEVJZVlFNFZlOUdMRDJpUWVSNVptR2pZRmJk?=
 =?utf-8?B?NjVacGNKRnIyRjZQczZMTmFKb2cvMjYrUzMvVVRlT3JuM21ZYmNqcFh5MmtZ?=
 =?utf-8?B?S1Fiam9RdXY3djFzTXF4aVFFL1V5Ni96cWxIZ3hVc05sUG96STVsaWlpL0Jh?=
 =?utf-8?B?c0pab1pkaDJWaEFQdi9TaWV1Z0Y4YU1SN1A1eWYxTWc2M1draUJPK0FEaFRT?=
 =?utf-8?B?WXhFM0wvVkx6eUJ6cWdkOVh3bmpSeUFYbHZMNmtITllCWURoRzcreTkrQ1Z2?=
 =?utf-8?B?Qkphb1R6bXZFbVNhRmViMkJXUlBRajR0QUFxM3NXQlFiQ1BPcDl3dzYxMXBx?=
 =?utf-8?B?QmpWZlY1YkFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGw4UUkwVGpOSytUT3NYODJoWXBQcWVIL0VsOHlmak9Vd2NadWZMc0RUWUhl?=
 =?utf-8?B?ejkwbG5lRjVwT3ZHZDRDMm8rRnV5cTdZYkdsNE5mVkRPZ2xLU0YrNnJTTEN0?=
 =?utf-8?B?SjY0dlFqQmpCUzVuWkl1RkF5TEQ0czFEVkVvaFdiL0h1U2FhMHR2TmxLa1RR?=
 =?utf-8?B?dkFZWjF5eDVmWktBMUs4cWpvSEdEVVVzNzdmdkxRaW9UUVRpS1hvdS9rUngr?=
 =?utf-8?B?RC9pVDRDVjcxTlk5MGxwdXg4Rmh3U1ZtSHJsZC9lQW1ESGE5TDMwUmpjSzZm?=
 =?utf-8?B?TURrREp5V2ZLQ3ZjK29MVE5NcGswaG92ZUtuSVVtdk5VaGdhRTlYQVdQU3JJ?=
 =?utf-8?B?eFB0ME55aFEyMy9pVjZwUEFneGlRSzc3YWRkYkcxRzRiS0NvdW4vREJBQ2dh?=
 =?utf-8?B?YXMxNzRPU3hrOEM0bzloOHJ5NUtWb3R6ZGhkL2VCOC85dFMvZVU5M1hyYndV?=
 =?utf-8?B?RHdHYnZnc0Zpd1pDeDFhUzl5TE45UzljcXlkWkZtRHRTclVPZThLZVljMnl2?=
 =?utf-8?B?WXEwL0FoeUo1S3JIdk1BZUlZRVREWThqa1RwdW5ZMnZmYUg2QkxmeUhBOU9M?=
 =?utf-8?B?UUxMdzBmcmZJVE8yRTdjLzROdkgrMzlmUEZBZHlBN3E4WTlSSW0ydjRJZ21s?=
 =?utf-8?B?SkhvaVBteE8wUUNFbWgzR3ZXMjVMelJjd21HbFQ5OW8yVSs3U2pFQjEyOENt?=
 =?utf-8?B?eGdsYzlubkxkQVhLbWF3bW9xSitwTjRndDFDU3l5dmtvRzlNWXJVN2FjVThy?=
 =?utf-8?B?dWNlNW1Ca01PRXdOM2ZoMms0RnFxbzEwRzN1WWo1ZlB5ZFdIZkQ0RGt3NVli?=
 =?utf-8?B?dlJwajlHa05VUW5aVXYwcG4yUCt0SU1icEdKcXNMOHA5b3F4N2w4YmlyTmc4?=
 =?utf-8?B?ZTRqdGtYcllGNVJwQXB6K1lzVWYzUk04VDVOSlBzZDdzT0pHRktkMW85czNn?=
 =?utf-8?B?ZHcwakxyR1pqWHVCQ2dwQkEyaGpwSTQwUldmNkREbmw4SThqdWlKcDR5Q2dr?=
 =?utf-8?B?Rm1wYWVBY0hyeGJLeDlwdDE2RDJjR01Lei9aSnVscEo3ZXk0SDVNZjRsdVZw?=
 =?utf-8?B?TkRkOGJac3ZCc1VsamFDay9FSnRFSkR0aXY0TzdXTXpPMEMvOWVUSzllMFRO?=
 =?utf-8?B?MUpCK1NmTXFiZ0RVT09KbGVqZkM2b2tyOGxzaXlDalZadVlUZkE5K1VSY1p6?=
 =?utf-8?B?dEJGZTZlWlI5bDhNZ2hXRmFoTTF4dDJudHNqVzFJYWJDcDNHcXFPMmsyMWJG?=
 =?utf-8?B?Z2Raa2hzUUxncGlTVUQrY2VJOEMrT1hlUFBEMitKS05ldEJuS1RrbTdtZ0F4?=
 =?utf-8?B?K3UzRE0wdmlhSit2TVhnU1kzekZ6MkdMSXlMQTBiQ0Zic013dzdJdkVSUXR5?=
 =?utf-8?B?K2JUcDZGcWtIc3cySm1NNHZscFdkdjl3WklrUXhxekFvSExDQis1UVJpM3Bq?=
 =?utf-8?B?WkJFQklCYzhjSVZzRGViQXdVOWlzUHkwdy9zQ3h1d2VxNnhqQUkzaHpwZVpR?=
 =?utf-8?B?K3dYUlpuZzRKd3pIbTFNUGlkVVg4Nk4rM1pGbHFCbHZlWWpGVDIvcElqK2dj?=
 =?utf-8?B?UzR2aTJpd09nQW9pV3ZwOEIvRnRVdHB6c0hQTjZRT1BZcU00NVN2Sm1Hc0hS?=
 =?utf-8?B?dE9xZWI5UGxkVm8wdVdxQlRDSjJCdkNWZFBVZ0lIZXRTNmR1cEdITGJESURz?=
 =?utf-8?B?M3JGbXdDZ2oxQ0Y3aWV4UnZONm1BenRWQlpaTiszanVTMFV1Y2tlN2pFbHJY?=
 =?utf-8?B?SjMzR29scWtIdmpUSlBacUgwME5MU3dabjNXTG11U2srSnNXaVc0VjY4MWVY?=
 =?utf-8?B?Sjh1MGpTUEVoYlhzcU9lb1R3bVJNVjZTWG9VWWNlRTRSdUFUNERWcmdDeU5I?=
 =?utf-8?B?SzVJY2k4R1p1a01NMjhidVNDV3BvZXNLTGcyTVYyRWVCTnJQM1ZxNE1Za2xJ?=
 =?utf-8?B?YnlkVE1sdU5lMFJIS012OVBrZG5iNGxvczBvMVlGK1Q5eCtuRTAvSkpQcDlW?=
 =?utf-8?B?V0IyWW96TnNOaEVaTGhySndzYllmNGV6L3plWFdydERXYUJvZTRsVXdlbmtF?=
 =?utf-8?B?TGdBMFRiQ0paMERhK3BBanpSY3RQYk81bVNIeDg5b2w3SVRIN3gzSnVVVkww?=
 =?utf-8?B?U3M1SjIycXZaOU4yUS9vZ2VESnZndk5VVUVLWUVubGJzenZIOTNrUFBQanJ2?=
 =?utf-8?Q?IPP10b2nG3n8500W9ZFhBOs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc4ff6b-e7b7-4859-07e5-08de3237b057
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 06:46:30.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EKxg5ty5XGxN54+r8BNceLSFGsUr804DKoTNf4XHCSUX2zejsLLFNLB1+rzrTZTgDDFTLferIS0P1wNtQjokAQgOGc2FaaHOF3M6XoAh+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8061
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

Hi,

On 2/12/2025 4:59 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Ilias Apalodimas <ilias.apalodimas@linaro.org> 於 2025年12月2日週二 下午4:53寫道：
>>
>> [...]
>>
>>>>
>>>> Ok, let me go through my irc logs in case I find it.
>>>> Reading the email thread we should compile with anything > 8.1 right?
>>>>
>>>> Cheers
>>>> /Ilias
>>>>>
>>>>> --
>>>>> Tom
>>>
>>> Hi llias and Tom,
>>>
>>> I have a question might be wrong or not even exist.
>>> Tom mentioned GCC 8.1 kbuild but u-boot is considered as
>>> kernel build or it does not always be that case?
>>
>> We use the same Kbuild system as the kernel. I updated that a few
>> months ago since we where stuck on a really old version.
>>
>>>
>>> At least so fat there are nothing can build properly below 10.0.1
>>> Using ARM official cross compile binaries.
>>
>> I think I tested with gcc11, but I I don't remember testing with 8.x.
>> I probably missed something on the backporting. I'll try having a look
>>
>> Cheers
>> /Ilias
>>>
>>> Thanks,
>>> Brian
> 
> Thank you IIias I don't really know all the u-boot things.
> I had provided the first draft for fixing GCC check.
> https://patchwork.ozlabs.org/project/uboot/patch/20251202041029.186-1-briansune@gmail.com/
> Now it is on 10.0.1 if 8.1 is the case will update after your confirmation.
> 
> Thanks,
> Brian

I am able to build CycloneV with the later GCC 10.3 version on my side 
without this patch included in the patch series.

Thank you all for your valuable inputs.

Alif
