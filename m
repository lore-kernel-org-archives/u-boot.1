Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E78D35691
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B80A83E16;
	Wed, 28 Jan 2026 09:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EksnPV9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B9583E1E; Wed, 28 Jan 2026 09:31:57 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBFC83E0F
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7ZAOrvGE9kOnDVtRQWHr/Xzo25XH6RDq5Yh1SDpiuLOyGoJfCXOQGOmdOHol2nlppcI1TGlF8lhEe9iLlPdXAQlqCLKKqPXwCXmSw4wp7izNY33j/PVi5d3Efd+oaXpb4qWIPWgGaHWuo/biBDmh1p9m+4ySHL7s15VJH+xeGfnvI/FFfkKMdUw3D79bZh1LWAKKh18MGIhlNdmODdIs6LpnJBMzPuLNwrwMnFSVExDZ3IWo1M30j8hkfJDbnieYD+6/zZp9tOlvWh05GhbMqeWmTMAkCTXHhfaiKNUiKtUpGzEUFxckgozcLhgnQ1VKI2fakmbZVpUHgZZlVIuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/FEnV7MKO6G8L/g7xXIWH4r2RJkTiQHoSJ3O1An6L8=;
 b=SWY9Mebr55wODjrBLUQi7ATLCwq9EJpvHQk5omd+A+4Vk5uHJsUZMyqoRF4bb5caMYwWOJpkqRXh4j7RFNpC/dD9ub7OV7JBe9jSkpfGJyuRd+2UfpViABqSaqnS7tWXFcav0XQkzArIkZkFm1aJfI1LpTLWUrqD1OTnKwfF59VWQ9wqDXrr9I/TweSXK1b4XGuLFDJ05EaF5ZuZD+iSL2rAeYGSf0KTLi+sxr6Ane+oQDP633Ax/I+kRJ6gcP420tF7AcWoxNdJb6fykMOuo1ei8d4rE1Q4u+iBAziLMrXEyfvpXace9bGV4Op1RNggzjaqAylFqrK0Lxup0FL8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/FEnV7MKO6G8L/g7xXIWH4r2RJkTiQHoSJ3O1An6L8=;
 b=EksnPV9vY+LPzC3gA/syJ0TkKbm9PC9cenSNu0lynN4dD3gEESW7NZW3hrBwQzFwQEmhl3ihqFXLrWZ2jo2EQmYk5/+pACYrr2tMYIg45U8nCgOqrFJ9aesd3Sxg3hpgi93Rs13nIwod+GuOTx4O4aovZq93GvbGS6LHzCpi3RlvWE3efFn+QmauyU2aeSWoRnDQ/70tqJDq3tjMH2EQ+ODvgzjDjRBqV9Ybby/VNwbqqpQUU3V+/hg/5FTJrcqOK+CFxKOWmSDO2VrTRvWZP5Vkac6GgYXz3EPBhDpH8sj8TI0qcsI9dklGI1XOXcngZfwu+ozy4Uh3edV1zt8V3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY1PR03MB7216.namprd03.prod.outlook.com (2603:10b6:a03:533::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:31:51 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 08:31:51 +0000
Message-ID: <4777ebdf-ebca-425d-ba09-e058871ab01d@altera.com>
Date: Wed, 28 Jan 2026 16:31:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm: dts: agilex5: Fix DT property naming
 convention
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
 <20260125202329.12738-2-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260125202329.12738-2-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY1PR03MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 341ee697-f1da-4ba7-5a6a-08de5e47af73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0JUZStFeE16blp4SHZ0SjZEL25zRkR1SUl6OCtvZ2FzbDFETDJ1UWtUSUFi?=
 =?utf-8?B?SmM3OXJmTVA2ZTNXanU2T05kcGpDanByWE05UWgzSFF0Z3FtL0FObW1KeFVv?=
 =?utf-8?B?bnA4ZnlLN09rTmhJNEQ2UGJoRTZ0Ykh3cGp4Z3NEZURrbmUzOUZ3dXpKQURT?=
 =?utf-8?B?NjFpWnBHcVc1ZnpvRFJoUWdaSHg0ei95cGhnTXZ2dFJZVkY0WTdnZ1lwMExo?=
 =?utf-8?B?WTR2UDd6bzBtemppcnF6aGhPazhPbnpkRU9pcktjTS9RZERyanBVOVBkd1FD?=
 =?utf-8?B?N0JneXBIaWxmclpGR1Azd0FhY2tQeDBOL2VRQ3A3eGFUenFCaFpoNVhHZlh6?=
 =?utf-8?B?djBzVm4rZ0dGZ25LU0c0VjNFbTRTSVdEUGtXd09LQ0lnSXcyV0lUZVM4bE1D?=
 =?utf-8?B?TWM0TmpJTlpsZTNDTVVaVlh3dWZPdGNLRTcxUE1pVEFTSDRvTy80NEhPS285?=
 =?utf-8?B?QVNhKzNsanQ4SlVUZ2V5Y2RVZ3M3cGkrQmsrNnRmNHVNdXNTamlrb2NTL3gy?=
 =?utf-8?B?V3crVWo2OW1RcW9jclN0aXRFWE5aYysrMERMQmkxdVJ2Q3ZiUWR2ck5OaC9i?=
 =?utf-8?B?U2d1OC96MmNoQ00rNTBGdFF2bmpZTDdaeE5PcXFqNGhuWUVDN21MYzJnK3ZZ?=
 =?utf-8?B?YkNQc3FmWEdyaTFWRUlnZWZyeXNQYWVBVUNrbkl5OGlqMVE5OXYvczYzM29n?=
 =?utf-8?B?a05zdmdCWSs3SnpJOU9GN3VxNE4yVEFtWHovNHpRU0hiaXlIdWs4Q1FnL3c1?=
 =?utf-8?B?aG9qbFhCNU9QeVBjZFRkdVpTTk12OWFzY0xSbXJFdlIwVUtMWnV6UDArWkhW?=
 =?utf-8?B?MlFVYmtuaWhZU3JmM0lQU2dmVUdmTWwzQW1SVWZLcC9mNHFtQ0pINE9rR2FJ?=
 =?utf-8?B?Y1NsUGRZUDFRTFlRTmJVdmVFaGdkOWU3Q1VpbVY5NFVXWWpPY0RySWp4NzMv?=
 =?utf-8?B?NU9PTFlveStUNThWejFIblZlcGplODZ6djk2dUxhVFNscnhFcFQ1alZuUEFN?=
 =?utf-8?B?QWRUV3RHUU5XQzlCcTdkTDc4SnlPV0QwQWl1MElDL3RJVk4yY1piMlE4eVVo?=
 =?utf-8?B?SkVXdkhtS0lnTTlCVkxPdytXVnR4T1lkLzZnL2E3RnU1RUN1clJ1VUYyblVq?=
 =?utf-8?B?SXgyVWNyV2tUMUtaY2N1MmZSTFR2T1FIWDdEVmxHYjNNZFl0WVN6RVIzNFBL?=
 =?utf-8?B?WjEvamdONUxWTVlSZWE0NkI0UFhTZm4yT2loai9NSlh4NTVBbkdBMUpoMzFG?=
 =?utf-8?B?cUFNcm9sZnN3eVVxdWw5SGlHNkZ3ck4zQlM5bHNXd1hiS2tJT25iZ1Z0bVRo?=
 =?utf-8?B?SVJiM0ljaDhWR0FiOFAyTUtDYUN0Y3dSRU43YVA5R1haWkJML3FqWWcxQUcy?=
 =?utf-8?B?bE9zY3h4N1NBSG5MUXQ2ZGNsZ2xTKzNnSHlYekdISGY1RlVrbUZ6QzJzUEFn?=
 =?utf-8?B?OVM2NWliRlJWUGFuQ05DVWN6SWo4eTBMZzJzdTU4aFlob3licEdHalA2Z2VT?=
 =?utf-8?B?MU1BQWNDTDhYYXVEZjVtVTVCbURRTThsM29sSTBxcUhJczRwZjlLVm1CcjBN?=
 =?utf-8?B?aEtxOEtHMW9kMnRmWHVnZFJvZ2JPWXBjTEQwS3pyZmEwTUN6WHpCNkFaZ05p?=
 =?utf-8?B?Ylo2YjRBbTI1RlBkVHA1SFpIQkhOWERXSVNHNGZkV2xUSkdOTnRVYWFOeUpN?=
 =?utf-8?B?T2QwUFpPMzJlWldRT2VjRFFqMnZpNnpWbk1qN1JlUlJuMy9sbFl4WkY1dW9N?=
 =?utf-8?B?eEtlRUFDWm5jbmRWZzBSRUhCVG1vNTc1MnRhaUdRWjRkRWFTeFpya3drbU9h?=
 =?utf-8?B?empqSHEzVnZvUldiMjAyUFloc291Mk9XSXRxa25INnZGZTYybnRXZkJGWU8x?=
 =?utf-8?B?UFljMlFYYXdqdGNmb1dhVFBKVnVCaU9OQ29EYTJxbGRmdzViUC96ZUZSekNC?=
 =?utf-8?B?Uk50RGJxMGhZN0RXQ1RTdStHVTVoKzlZWVBqdzEwRWNCamcyb3NmOFArSHlm?=
 =?utf-8?B?dm5ybFozWXhoVnNWY0xsdmhCYVVjSG8zLy90OEJFWVM5WVBZU0dLZEJ1Kzdu?=
 =?utf-8?Q?MGn4y+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmg3RzNSdldsT1NzZHg1UnRsbWk1QkxkUW9PeTlXYjhNNXAvNWFJaXBlYmZQ?=
 =?utf-8?B?clkzbXBsTVN3WVJ0UTVKdWJQdWg1MFZrdWlGRW9FYW9mR2VkMG11Qkd6emd3?=
 =?utf-8?B?WkpsdVFWYVhHb1dIZm9EYkhnOXdETHlOU1dsczJFdTQzQUhmVFpNenBNYjEr?=
 =?utf-8?B?QUJrMXRBb25hWXkzYi9pbkhKWVVmaEpZdkdoMFkxVGZzMnBtQ3ozYVBIc08x?=
 =?utf-8?B?MEx4ZkVGUVBhK2dzdXI2RE5WazVZaXFiU2F0Q3JYeHJyVDVkVDZzRzdNZ1hM?=
 =?utf-8?B?YllsQkg1c0hhU1BwTlVJNEpObmRJREM5VUdhM1M4Uko2NDU1TnVGT2FudHJ6?=
 =?utf-8?B?bmlzUDdCbmZVVDBHcTh4MGllVVVEdCt6U0M1Und4Ykh3TUdNc0tWcVZaaGVz?=
 =?utf-8?B?VUdqdVJtSXJaVG5GZ3hxU1JueDFCcFlYak9EMENOV3UvdW5jb21RemZFQWY1?=
 =?utf-8?B?aEh5dVZsLzFwTjdTUTlRWWtwSEoyUlc1b0NRRStqTE9rZm4rdFBKbmFJaEFF?=
 =?utf-8?B?UWkzZ3RUSW9PNGhzYVk3TWI4aFpNeUJFSkJWd0NEMEVIekRRUEljMzRybkJX?=
 =?utf-8?B?bDlEVW5ZUHJVbWJXb1JOSEtJcjNHREFSWmpacDI3cEFuMEdEaWppZGJteU51?=
 =?utf-8?B?eDdJdEkvOWZLYnl3OHp2ODgvWVdvajdwNzFIU2o5ajZHbFRna0t3NHNhOUp3?=
 =?utf-8?B?OWRtaXJIemJNaEh5d2dSZ0g0aFp4ZkNjRXYxUnlTWWRmdWxjMEQ1ekd2SDJ6?=
 =?utf-8?B?TURNemVvLyt5TTZKMkN5NVp4cjVVTjVSUk9ma0h4WG8xeU5tdXovTXZoZlZy?=
 =?utf-8?B?d3BjNE41WWVZWVl0MWVpaEo1R2pKbDRyVVBRcEE0NGo4NEFra3dQeGVFdU5y?=
 =?utf-8?B?WUh3RTRpME9zb0hxOEQ5OXBLRWN1V2E0OFpTaEdmVlUwSEVBcGtoeW5IS0FP?=
 =?utf-8?B?K3BIWENuWHVSb2Y1bVBVbXVSRGRpRGZaUDdSRDhISVZTMVg4a25Rc3BjNzRZ?=
 =?utf-8?B?WEMrTWo2VzRDTGFLV0UzajEzc1M2eGoyZUZEVGx3WElHQVF6RHZHeGVyR3Jj?=
 =?utf-8?B?bzlTbmVzZVk3NHpnT1ZzT3lVeXpBeHZQUGwyTU5CN0c0RzBmMWcwYWZXOGZp?=
 =?utf-8?B?QzdYMDhRTjhXdGcwTElFbkZsSEZWK2cwUW1XdzQxa0dsbTVTZHRkQ2tkWkl2?=
 =?utf-8?B?N1JiYk5qRnB4U2pCU0hUL0czYUdrVStiVE5Id3UvTkhvM0NyVkhUTW1rbTV6?=
 =?utf-8?B?SkFveUxlVkhIUks1VGdmZnFFbFRPUlNtWGYrVkR3enhUdTFpWE8xQkNNa2ky?=
 =?utf-8?B?QnNFc3FLbSs3VWtTZ0ZZVEtIVERORHJjSzJTbmVrWXlnZUY0QkQ1UjNscFo5?=
 =?utf-8?B?RDlVaG03ZEprWkpVdy9QYlJ5dXhweUNVR0cvNW44ampBeEI3SXBSRzZtcFdB?=
 =?utf-8?B?QUM4NmZIQjhZb1hCVG5GQTI4bUc4ZUpleVdyc1pZeXdjOHg0ZzZ1VGYvcEpq?=
 =?utf-8?B?Nzh5eGtLd1B2MGtkT1l3M1lBRFVyOU1CTHFzMXBXcEl6RU5ycmRUaEZRS2lV?=
 =?utf-8?B?UytCTUVJbklpdkFTNXR6aWpJamdZRGhuNEd6U01lYmpUdHZnOGdHMGpDQnFU?=
 =?utf-8?B?K0JTT0Z6aDNTbU5lMkNBenN0dFE4QmdpU1FQdUF2V0l5dTd3R2h0amVKS0ZW?=
 =?utf-8?B?cnk4QXZkaHJ6WDk3RGl6V2xqQWZrNi9VRCtCYmhaVDFCTkR3L0hqZEY5Ukg2?=
 =?utf-8?B?REg3cmoyem9xNlM3YXVjRkczdDMwekphQzlLTjlhb0VKWGdWL0pUMTlWdHlH?=
 =?utf-8?B?dzVobkFLU2ZtS1g3azJSMS9UOXBQNzR0R2ptZm1ZbDZWVjJyME9QRmtSRmVq?=
 =?utf-8?B?enhEN1BXNjQ3OUdsRzAwc3hqREVhS2pZMkRpb2d3MVZZS01JRkZaNUIwYlZ3?=
 =?utf-8?B?djZKUWZYU2Y4bVF2UkpHd3BMSzcrSEdvR0l2Vzg5TjdJZ0ZzbGQyc0ZNVEto?=
 =?utf-8?B?c2Zva2phQUZ3dlorVy9sbm84Mkgrd0k5Q09od1BmQWMrSjZLSUhHb2ZOdXVl?=
 =?utf-8?B?dmRYbEtRd0FKYkwvRm82L25HTkZJQ2doMTZJWVplSE90NG1PZ2FJeUxvV2dE?=
 =?utf-8?B?U0laaVlsaG1CTExEWjR1N1JYbEhmQ0lBMnk2RnNPTDF0NXRoVUd1WkQzQ0Uz?=
 =?utf-8?B?dm9hUVRvYmZPUzltb2tNL2VNOUszbmNKTDJiVE16UWNuN2NiaVpRanNmSDIv?=
 =?utf-8?B?NTJoaWI0Y0JOeXZtc05zVlpNWjUxVzcra2NZYk5VNU5maURQNWpLNG14WlZK?=
 =?utf-8?B?dkJmcDg5NTFMZFBBVVN2UHFDdDRJQXJnQzhKY0czSU41L24yUUQzcE9IZmVR?=
 =?utf-8?Q?Pzn79+/mUOU/Lesw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341ee697-f1da-4ba7-5a6a-08de5e47af73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:31:51.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gljr0krUy48PZkT+8lfED+/pfowF01gMwMqLvV1RHUWYshTIQqg9+cDStENUO03MiABbN0nKWNSMqHDL57jh3TRm6MnYj4YEmHg7CJxn2NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7216
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tanmay,

On 26/1/2026 4:23 am, Tanmay Kathpalia wrote:
> Replace underscores with hyphens in the PHY timing configuration
> property names to follow standard devicetree naming conventions:
> - phy-gate-lpbk_ctrl-delay-sd-ds -> phy-gate-lpbk-ctrl-delay-sd-ds
> - phy-gate-lpbk_ctrl-delay-sd-hs -> phy-gate-lpbk-ctrl-delay-sd-hs
>
> Signed-off-by: Tanmay Kathpalia<tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 5a7aa5841e3..417575fa0f0 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -3,7 +3,7 @@
>    * U-Boot additions
>    *
>    * Copyright (C) 2024 Intel Corporation <www.intel.com>
> - * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>


Please don’t change copyright notices when making minor code changes.

Copyright statements reflect authorship and do not need to be updated 
year-to-year or for small modifications.

Even if the file still reads “Copyright (c) 2025 …”, it remains valid 
and does not require adjustment for this patch.


Thanks.

Best regards,

Tien Fong
