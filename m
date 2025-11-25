Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CEACFD374
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 03:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973C783F2B;
	Tue, 25 Nov 2025 04:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s35ZOL/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4451083F37; Tue, 25 Nov 2025 04:10:17 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A890983EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfJByazF87bJ5tC/JRk0WV5HFFPgE4UCpv+AU6oX28D7Agm1nXF1ngj4ewbTX1m16G+agP6kytDTOLrzuUyF6EBmt3AauJNlAsxByA2K5fbKiugOIyX0YM0jKLpcvD6MgzWFbt4J5tXuvyDgtqzYfcbxz3Sq3/fVhz6iGpxYKLauGQhXtrH6GI3Xqa9HdcMj920B3MfsuKSSwPN5GhfuoBHpHKOXBVEQ4O1wGeYgUZ81Iu2EPOOy3wG6mW1BKWLVqQnCeDUnCOBdUqhZnXPdv5DZ8MP8mTK4soR8iSRTeDsNMZ2VpRoipSBuSHQQQ0ZVt321mBbGoH9Di8MxX9HeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLnlYrlx+PChCU+bvnjuB0iEaWt21lzuo7klOe2N6tc=;
 b=VmY9Yk59r6y8CbrwEM3h9L8RYd6mYNpjjmA3/cGlt00Q1Xx4uc3RXod4s0s6EhgjQTH2+JitdOJuJKgOJn2nXReVHp1kUNtWWcr9WppdxfQ7lfOx6PWX2qNAZLM54kF9wIRB7HtmoiKbKZfIpsR22TJcxHW3/hjJcqK7E4aNts30dXdlGSfhP1aKUWVyrYq/YhVo4wiEQqx7CCMSKuA+UhhBzKOZ1aZbtqpMOYN1nxTOq3cP5KLl/tj7GiYRLbHlxikqn5ONefwWDXXdWdZR+UyoT0XUEx2nih07OFlTOrWZeD1vUTx/rJhFEo3xWSEloHzTP0OvBgJRyMbsgXiTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLnlYrlx+PChCU+bvnjuB0iEaWt21lzuo7klOe2N6tc=;
 b=s35ZOL/ldTNV92GZCg13qZPMl145FBA3vYMo6n/ZF16OJmZYzO5O9WoZD10cQ9+MSvJzoUeYZ/SCUeHw/EPdKERZUQGTmqNZLTwu4dXPpcYow0+TfPN9sxb7NRbBebb61e+fj8cjJZtthrQj0T80xdh5mNhVX+n7U3zcIaiig9tz5ZNeMrEnHJWD8s/K+Cnw7bU23CzihCUQ9LVYr7p6ge3F8QL0r5wWOXgdocVbdo3pzoupzTvbSC1i4KUAgvFT/k7g6pGRLKG/t7fQJ3Jso/9yxrQ7oG9ZIB/nbb5zxzo0LRoCgliyu/lvWZRYakaOirkATdUjluUuK/w1gcMXRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5682.namprd03.prod.outlook.com (2603:10b6:303:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 03:10:11 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 03:10:11 +0000
Message-ID: <edcf7ddb-966e-46e5-9fef-b218c0d4de1d@altera.com>
Date: Tue, 25 Nov 2025 11:10:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Sune Brian <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
 <20251114173535.GD6688@bill-the-cat>
 <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
 <e2557c4f-19b8-45b9-b956-a8131271c7a6@siemens.com>
 <CAN7C2SDc9uQO40+hR-tsTW490sCMUAsLsb_52a3kvHqiDOLtYg@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SDc9uQO40+hR-tsTW490sCMUAsLsb_52a3kvHqiDOLtYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: c453f9b8-52af-45d1-1360-08de2bd02536
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ny9Wb0tGV21QZHBYSG55U3NZZ2Ird0Z1WTBuNEgvY1hGb3hFbXBZM1pXWCth?=
 =?utf-8?B?ckNscFhGMi9RRmRRa0Jvand5VEJQQkZWSlZZeFZRNGRXZHFQVStjRkZGdWdD?=
 =?utf-8?B?RDlML2xXMWhBVENEb3FmSnNPdjZ1TTM2TitGcUFqT0UvZkQzVGZpWWdIUnla?=
 =?utf-8?B?MkVtVklvMWlPUjI0OUMyV2NUQmNuTlZscVJrWFNTdGxtcFRiYUdObUR2SU5n?=
 =?utf-8?B?eGNFajNsZDRGUmF5SXo2S2N6dmdCREFFRTcxUHVJb2pLTVREcjZ2L0dzQnlj?=
 =?utf-8?B?anVmYnhNUjZHdlZrVnFpQk05NHhlWG9QY2tzRGNuc24zK29uN1QyMkpOOFQv?=
 =?utf-8?B?amVmdngyMnRzVUUrZDhYZHQvTm5ibXY1bjBpNmFmR3lSZnFJbWZIK25yeTVs?=
 =?utf-8?B?V1ZOcGl0YzVpZE1kK0NiKy8yVWE0N1RReUtJdTZQKzJTMEJwK0FGVWJWcERi?=
 =?utf-8?B?RW0zZmZzUFJMcmJDbE82OEVyTUpibmprODVDSFRzUWVqS2hDV0M2bGx6K0JB?=
 =?utf-8?B?aGxPaEFqaTV6Y2kyMDYydWtGSmw3Yy83SHB2UHhrYjR0dlpkNHhGS1BkRlNo?=
 =?utf-8?B?djBaQmJKZnJPa2gzSitOakd6bWJyTTNYSXdsYXQyVnI3ZmwvU2JNM0ZTVEpu?=
 =?utf-8?B?bUlZbm5LVXF2amw0Q1c2TzRQRFhEWTdKK1JFb2VZRUNHeW8vd2x3amh1VlBZ?=
 =?utf-8?B?dHV6TTIxY3FpenR0a2c4b21QOURIZE9XcU1Gci8vQkovVDQwVUVvN0VhVGp6?=
 =?utf-8?B?dUpYZFMrYVBXTGFvVXdxNkcvZTl3RGNtcm9xWmNxeExOT0Z0VVB2M2gxRzBZ?=
 =?utf-8?B?MHVUS0s0TlBraC9ZVmJhNnZGMzBoVzFxVlNzTnFYMTBzOWZWcUV5SFJyMkk5?=
 =?utf-8?B?YTZUSnN1MDFCSGNVT1ROM3ZrUDBEWkRBSVpDak1MOGZYaitEVGh3aU94U2My?=
 =?utf-8?B?Zm1ydmNQWVJMNmpGWksyM2F5d1l0T0VKdjZDWjhMQUkyckh6TnVsZHd1dGdS?=
 =?utf-8?B?YWJ4UWZCY0xqTXpJNkZFcXRXQ3RVSTBmb0l2eXk4OWtGWlF4Ym54Sm4xakZ3?=
 =?utf-8?B?MGFoNDdpT1BmVjhRUm0rTVpodFdvTGJJVkVrNHpMN0xmQzhhdDdyREQ4Ui9N?=
 =?utf-8?B?TDEwNjVLQ01IWjlaTjM4dW53ZWVaUjV1Z1grMVRrOTdtdmZNb0hsRG9CczNk?=
 =?utf-8?B?SXBHaitGY0t3SVQxeXdXbXFzOWJ5bzN5Rm9mckZnMmVjSk1lSGtuYkVYOEkx?=
 =?utf-8?B?ekdwcDgzMTgwdUFla2kyRnJKbFZBbmF4bEZldVpaYXoyVzFwZUZTRFJvbnNV?=
 =?utf-8?B?TzV4VHFweGpRam5nVFFwRkZiNkw3MEJKNkJOeUh5RzNkK0JTVGhyNzZEK2dQ?=
 =?utf-8?B?Vk1qMU9hRGU4bSt1elVna0dZb3NoYzVTUSs3ZW5HcmpOcmdBbmx4OWJ3eTdL?=
 =?utf-8?B?RXNhbDczenV6VFVFYkxGcGRFQWwwSHBmMnBGS3lEQlJBc2QvbzlnV1BJTDky?=
 =?utf-8?B?cnhvOUZwUDFKYUQ5cHlPc05sVFBkeTJEN3hJZUxvMEZnSFJvMVlFYUREbEt0?=
 =?utf-8?B?N2s0UFJIbU11TjNqOVJJVDFSbFhVNjVkdm1KOEtnK3R5UUJ4NFcwQm83WXJa?=
 =?utf-8?B?dEN0RmlKbm1ieEVLZng4WHlHazdsOEM0YVVWcG5LV1JOV1FNQXRKOTJicUsy?=
 =?utf-8?B?ay9EdGM3TjdzckQ4Z3o5M0YvMitPUGpUNy9RTmQ3MkRxZFp5YzNtMnlJZnZS?=
 =?utf-8?B?U0xXTW9rWnhlSVRoMUFhZVhZbDFYMkRiaGg3MDJFOTFCUzYvczRUSHpha0h6?=
 =?utf-8?B?RENZTGFDS2dGUThnT3hkYVplbUxMYys4am1RUk05UkZySFNHUG9qRjlhRmdS?=
 =?utf-8?B?MHc4cXFTOURldXFLVm9sQVQwblliL00wMUpYK2V5V1doNXhwTlFJbkQ4UDI4?=
 =?utf-8?B?YzMwV0tMZVZDdE5yTnBONFBnYjJmK1pZeDA4YnFKcnJ0VWRrdjc3NllrSVRm?=
 =?utf-8?B?V2t0QkVBWjd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2prZENDV2wxOURvdjJqc1JoQ1B4ZXdCNFFaVVZIaFJ4MHptbVRHQ2lvSGZS?=
 =?utf-8?B?SVhnVzlHVnZPTXZNU25VVmlwZE9BYTNaUVNOOUhJcGVzYWpRcU1pR1ltUTVw?=
 =?utf-8?B?QmZ6SUM0bFdWZG0xU2Fid01QeHI3WVJveG5YenhxQVN1eW12SDAvNTlZaGhx?=
 =?utf-8?B?SjBzZSt0ZmdlM09OaFJNMTMvbUJmVEwwUXAzNmVwOTZGclNtMVZ6aStsLy9k?=
 =?utf-8?B?b3pyeDBoUDV5UnpZd051cGR3MlhVckJxTytML1oxNWtNQUhSczVqS2tvbEdF?=
 =?utf-8?B?TzVGVVdVZnQrQWpZaWdLcmdIWjJMQ25zcGk3dENPb1ZmL1ZpOW8xd0xCQm1a?=
 =?utf-8?B?dFRybFY5eUJYcTZOb3hOVDQ0eFFHN2taMTJoRVJyYnRqQ0NkeExtdVBtZjlw?=
 =?utf-8?B?TVVIMlVuRk1XZ3ZRTTczRzMvQzJkYTNjclhhcXFiLzd1eVZ6dlRiaVVLTjAr?=
 =?utf-8?B?Znp3dmROUFdCemovQWQ2NFhDdnZ4SXp6WmxKKzUrUy95TG5nY3hnMDZaeVdT?=
 =?utf-8?B?YmlnWEc2b3ZTbmpWVU5DRUFYTDlZT0M1b2FEM25veU85ekVOTmVhelFUVmZF?=
 =?utf-8?B?NndIMzZIMkU2N21vNW11TnJiUnRqQVFFOTJ0cGNiVG44ZFZobzdyZ3V3K054?=
 =?utf-8?B?M0pSWUZGdG9EUnhYYkJSbXA3YlpiOVl5RzNZdEtJa2JweHFzVm9JY1lpWFZ6?=
 =?utf-8?B?SGZRYUkwNDJmSUVDaG9YdVlSOXorYTc0bzNkaFRrMVpYRm1wOWx1SHJpSnB3?=
 =?utf-8?B?eUN4VVk4MFIyMWJIZGpvOWxSa2YyeUZ2enN5Q3FJRTIySWlUemxJNzFtanVN?=
 =?utf-8?B?dmNibUtlSngzUWNqNXJERXRjTUpRTGkvcGtlY2QxczNpMmNBZWd4Rk5FUWh2?=
 =?utf-8?B?N3gxZEJIL2UxOXBZTlc2SFQ0aU55VG1zU3d5ZWpOaFJKcTBRU3BGSjhjWGxx?=
 =?utf-8?B?UzRJR3FrNm1xVGYvTE16K1dYdFpPU3JtU1VhUjE5di9qell5Q0RPdFpCNjR0?=
 =?utf-8?B?amg1YjVQNGJweVlKRzcxYWwrRjVOYUxCWnN3aHRsckd0QVhGTFI1L1Baa2NF?=
 =?utf-8?B?WS91aGRQL0YyNGRqa3hWZ3dPK2t1dXEwaTRyRUlJamx6bmlKeGp1a3htSE1m?=
 =?utf-8?B?S204TFArSFk1TStSeDNoYWc2cU1wbEM5amVjTVRoaCs2cmw4T1hRV1FwMHJi?=
 =?utf-8?B?MUpJRzd1WUxIbXNicVpzc05Bem9KT1lnUmpTN0dVMjEwbVZEMUhqT3ZMdGxG?=
 =?utf-8?B?bE1mRi9LTVErNEJnMHNWWmc2Vmk0SnZpdGRXZDBMa2dGNjltRitWZzFNbDlw?=
 =?utf-8?B?Q1ltczROS0JZTkZtN0wrNGdhUHZ4NnptUENMYU45SXpJSVdETW1QTVhSWFE5?=
 =?utf-8?B?RCtkZGZHVFpjZnYvNU5Ed1BkbXBHMzNGT2JjdlRpYTRFK3ZnTk8xMFE3N0dJ?=
 =?utf-8?B?cElhN3doMDVNZXlnUzUvRS8zVXlUYnU1ejRBeFlsano2QnJoa3BLMWVkNUZO?=
 =?utf-8?B?MWszSytsY05QaUNHbitJeUdtd1JiUHE3WUpUYmh4REFSeHVZQzF0K1VOV2ln?=
 =?utf-8?B?T1I2MWxJWmZoY3NXR2g1dENzL1YvRCtSTWxTc0pHSmlSczE0cjlaUko4MWty?=
 =?utf-8?B?YnlzT3VOZFlqbUVST0huSU9NS1VDNGQvYVBUMHNvNXB2ejE5WUhrNGVjQ1hH?=
 =?utf-8?B?azFTdWVHSm9mOEQwMzBkVjMxR1J3N0R6TGg2ZjR2OWlhd0dlN216Y08xaWNU?=
 =?utf-8?B?bnFjZjVjZzUrdDZyVXZUSGRDMldZay93elRCNW5uTGU0UzFNM3VNRUZyTjky?=
 =?utf-8?B?OTYwVjExUExyWlBFRm1zWndsRGlIdWtXQi9Nb0l3aEU2RnpUb3BSN0lOQjVD?=
 =?utf-8?B?eWtyazZsY1ZNRERQY0dSd3NJS3BpeExQaVBDQUhLNkt1anA0YndQbjZ4Tjlt?=
 =?utf-8?B?dFlBaDl6bnBRdSsybzNiRUxESzdOeEh5Vmgvd3Z1aEdMUXhLamlUOCthc1dw?=
 =?utf-8?B?d082aUFZZUFNU1loZjR1VUlyREVyU1ozZXJHVDY2ejljbnJjVFRTNDdYaG9v?=
 =?utf-8?B?ZGxrQWdqNGFoMkE5czBUaW45TndDR3pnQ0hPUkdjQzQwNDlYYm1VOHp3Vnhp?=
 =?utf-8?B?RXlvWjFlZ0gwL25ZZHE4UWx1NXJ4N1VNbkJ6NTd2YVd1Sk1DUU1OR2JUZjha?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c453f9b8-52af-45d1-1360-08de2bd02536
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 03:10:11.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65PA/9qTRHChi8zR4+5bTlre+kOPpoYBfTyySrkwT/FZApdBA3E2OzYydHlUGrwl5Qg39QWBZ2DUAVJqUwplgF5kYJ+w/rF94OzIBalyowc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5682
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

Hi Jan, Brian

On 25/11/2025 6:25 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
>> I'm all for finding the best technical solution in the end, but I wonder
>> if we can at least come to an intermediate solution for the upcoming
>> release so that folks do not need to carry too many extra patches in
>> their pipelines (https://patchwork.kernel.org/project/cip-dev/patch/cf43e9da3cfc59771e801d3215d3b3794f3602a8.1763446144.git.jan.kiszka@siemens.com/)
> I am not sure why point to patch v4 but I did provide the final path
> version that T.F. should be ok with.
> https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-briansune@gmail.com/
>
> What this delay is that there are several feature coverage on the same file.
> Meanwhile, there are several similar patches pushed and T.F. action time
> is a bit slow.
>
> The very first patch was almost two months ago.
> https://patchwork.ozlabs.org/project/uboot/patch/20251019092341.1158-1-briansune@gmail.com/
>
> So I had no clue why that huge delay. BTW it is supposed to revert
> that pointed out patch to easily fix things.
>

Thanks for your patience. We have completed testing with Brian’s patch 
as well as Jan’s patch series, along with a few additional issues we 
identified during integration. We have addressed those issues in our own 
fixes, and we plan to send the patches out for review today.

Brian’s patch:
https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-briansune@gmail.com/

Jan’s patch series:
https://patchwork.ozlabs.org/project/uboot/cover/cover.1763140421.git.jan.kiszka@siemens.com/

During our testing, we found an issue in Jan’s series; I will follow up 
separately on those to provide detailed feedback.

Once our patches are posted, we would appreciate your review and 
testing. Please let us know if you spot anything that still needs 
adjustment.

Thanks again,
Tien Fong
