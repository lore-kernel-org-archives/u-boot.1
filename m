Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A058CA0EE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21128211F;
	Wed, 20 Aug 2025 13:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="M90VxOzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A07782B07; Wed, 20 Aug 2025 13:20:22 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA4B801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbRVlZ39cjpwBuWNLdNlJ36WOQd5S0Jy6ElUjUJfK0KBxj+e7DII8wNlp0bPG/9tgupQieJp7vYG5l/a8gePDP+bh3DFbw5dFjQVqrRYEoNswfS+VanP+FHHrtAv+hK/tPfQ9TcCzPn2yNliB2L67ifcrMs8Hk1jLoizKQFxE99Bs7SuojGXGQTOj2ne9ifm4hHyp4OaiBEGo610paj6OmmSagj+47isjZNGjJGPusY00xvZYyZqC0sKRa7LMi5D5XLfQYSEQ5kkZRoeP0rNyEGvmHx4svuZq1srYdk2h6hv0ujbVTEm6w2jySgT9IEZxTtHoQqKJSYeVRLN1aVyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hm7EFwGkkDesKHfGVnyD9dH+/W+gfDx09bcz16t7Iw=;
 b=iAg1HLw5Q2gCKVZIWlloJiTncIURP3N4zAZDfpnQNYwZeAeD18yh1IfD63hTeQvCt5vnUXLZppsSG8Q1xInFadfiIWgwLUor8GTPnouT0GmmLsoQ21dMt6X6fKuMlztkmF+9NdOyPEfKGS6uY7yi0gkEpAoPXCA62btcqbfRGZxGAc6WRRZU5qY0ete+dyjcruDi889aFSndIygu77t+cFtpDaMHxZVQVTUChcvye0NfK804PETiDZOQdpH0KJPA78kkKFfXV/zrxqGcEw4hVqPjv/KVzG8zpasF8gjlkKExQeXXLEA5w48f1RRpPgbs/uv+GJ+OR8rLEcI28IgPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hm7EFwGkkDesKHfGVnyD9dH+/W+gfDx09bcz16t7Iw=;
 b=M90VxOzHbGz38YMBWNyTZz73nd+FUlu/L5tDNNVAco6KGg5wWYKLQ8Z5Rp9kqRIJUOD1owP2GQF18vYfBrmnRcbRsSPqU+RSsvC6R4TEg45de+kNwhAK9Py2LrBePHQ9wvXIOXsK4+HQqkF0vNdu+yhS32+uCjWxKdLNljwC+W4Cbbwszy3Dw1aucbgCmv8euqRttaptKM0GQklPiZ/CSYRD9W+dfvEGokZho66yfeCq8obyzmKC8efGIqkIzIF/PjccGqYeJhkxz37eJViIQnTGSh7HpUqy0y4m7haydk42i2/gn3UCiiM7PUyC2I+R1cBl5ZrKkm3ygjEnUtmj/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB7853.namprd03.prod.outlook.com (2603:10b6:806:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 11:20:16 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 11:20:16 +0000
Message-ID: <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
Date: Wed, 20 Aug 2025 16:50:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250820075351.6455-1-nareshkumar.ravulapalli@altera.com>
 <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 9997cb61-9181-4999-7d64-08dddfdb89c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1ZbGdQY2ZyMzIrQ3dZNlZHVStob0NzVUFEWk9LVXdoTU5ubndqTGd0UVpL?=
 =?utf-8?B?YXF2YzhRRmNyek5OdzhsbUhFU0F6cDBMWDJrN3VPa001c1VjcDZWeGFIRTRv?=
 =?utf-8?B?eGhhditHaHoyZEsvZGpvY0E4YTRHcWlkekcrQUpxSkk3eEJvMDBZc2V4UER6?=
 =?utf-8?B?YzduSi9ja1ZBQzJZd2pMYTVWZ3hyNEhFK004UTRiTXNlMUJ2MzRjQXltN0U2?=
 =?utf-8?B?dWFsdXFRSVpCSW5lTGZkR0VVWERMWE9uNmJKS201b2orckFkSlY2RkVKUGtk?=
 =?utf-8?B?ZXdsWXE1Yi9pVmJsQ2tXdXJTUS84TXBWNkJiTlNCY3R1WmR2RUlrK2Q3TUFX?=
 =?utf-8?B?c3JjMEJWVnFOU0E3aGFJYzk3a0RGQnNBNjlvUC9hKzNiVWcwWjZ1YUw1Sllo?=
 =?utf-8?B?NlR0L1lXTTVvRGV5a21ONjhEdElhNFRnZlBGY25EUENLVDM2STBzNVZkSmR2?=
 =?utf-8?B?T3RuVEd3TzJuRFUyQ0p4WWc4ckxXaDRxN3ZTUjVrVERWc0dRNHVVWEppMFNp?=
 =?utf-8?B?aXZqZktyVmJKQktSc3lHRWp5cklTNnh6TDdjc1NXeVhtcWFHWk16Qk1zVDJG?=
 =?utf-8?B?OXlsTkQvN0xkREIvQWlYSjdqL0pYRFpER0R3eEhZNHZVUmorTGQ3YlYrVXYx?=
 =?utf-8?B?cW9RZjdQVWVuM2dJNHdSVHNCN1FoV2o1dHpMallBS3RyQ1E3SC9qcmhRcTQy?=
 =?utf-8?B?a2dsZzdBS0RYRHpEOEl2MjdDSFZhSTBPaXRFZ1dYcWRvZCtCeHAyeER5VmJ1?=
 =?utf-8?B?NGs3SzREU2dzbEhnVGdIM1U1M2pOZkxmaEdsd0JyaElrSzd0WTVCQmFVVi9L?=
 =?utf-8?B?WUlrV3pvV3dPS1NkUWxKYTI2U1pmc2VFQzF6c212K1JNVWN1czZQbXhkMlhj?=
 =?utf-8?B?ZVlMQW4rSk15WC8vUk9qTGZsYnFCcTY1UkhSVGNHOEsyVDd0R0dxZEJhTnVG?=
 =?utf-8?B?NEJJYTloYXB2dXdna0pFc2ppZzk3Q2NhcmtyN1NBNWJualF2SlF4RmVZT0Y4?=
 =?utf-8?B?K3pmeFlOVHgrcWdJS3MxS1RUZFFzRzJ1WVZVdGpCTVdnUFd5TzBEbnBpYlZT?=
 =?utf-8?B?RmplQWRuc1VYcExSWXNDNnM0cDRPbGErOGxwNVJrZHBLU3JoZHFSTUw5VURJ?=
 =?utf-8?B?U2xEWWRRZU9XY1lsb2g3YXhuekpGdEdMZldyQTZLamk5SGdrMTFzaFp0ZjdQ?=
 =?utf-8?B?YnpZVmdxWkc2dFhqbkpGWWVuNXE1djY5ZG50UTY1U1ZiNGx4ZFB4VERaUEk3?=
 =?utf-8?B?anYxaEorMzEzcERrd3dxNnhYWDVXL0pCQjd2c0F6ZkZzM1lQdytDVmJleVFk?=
 =?utf-8?B?M21iL2tUVDRJV2UzUis3Mm45ZWVRVjY1OE1oZXhud0wxOG83Qk9Jc1RwTm9C?=
 =?utf-8?B?OFE1aVJjY01QVXNQazZIU0YyTk92WCtTTHkzWThOdjZzeEhQSjZ2K0VkdmNU?=
 =?utf-8?B?NUVPdXE5LzlIOXRyKzA2Y0dyaWU5MWxTWXNRY0p1cnVGQXlxN2Z5bDNHaHBI?=
 =?utf-8?B?UmlmRWhPS2pHQ0dZc0FJSGZTdUNrc0dDYmFPUHp6SVFlMksyNVh1VVNDU0w1?=
 =?utf-8?B?QVI4ZDRaZkhTVUVjSkszR21sbjNKdXROV0RHaG9iTkdVVjQwcU9vREdHS0t2?=
 =?utf-8?B?K0IvTXB2dkRiZnFvcXJGN0JWVG9SazQxQlBLVEZMcmlCb0FLQUM1SmlZRERU?=
 =?utf-8?B?SlpwRXE1RXJiVU1OcFZXNFZGbHNCbnVuaGczRExmb2FQdDFYc2NWMlhhVklT?=
 =?utf-8?B?QXc3bGVoRWxzV3NTdjV6MTRGVkpOQTdGdjY3ZGNWZllHYWhVOUFUZ3k4Tk5o?=
 =?utf-8?B?OVJrRlZFTW9GZUFuekEreE91Mm9yWlJtMEwrd2NEVkNrZ0NmdHFNRHd5bDhV?=
 =?utf-8?B?N0pKV3dTeEptdzJVaVlXSEJSUDdzM2ovSWlxNENUSDFkQVprVWZqWXc1c3VT?=
 =?utf-8?Q?QFGOEgl4m3E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlZc255R25yMzF1T3NQTEMxbEtlNjBjY2tJUXNuckhpN0txb2Z5S1BjVjhw?=
 =?utf-8?B?YVpPeTBwU3gwQlQ4c3VGZWFDRkhDMTVpK0xIVFhGVFJaMDhDaEJ0NkNnRnBM?=
 =?utf-8?B?NkdnR1dEakExckxSRVJPcnV0RW5RNmVzM2VkNUNpbEdMbGhYSGJyY2RxY2lt?=
 =?utf-8?B?T08zenNiQTZoM0hCMEEzbk11ZzFPYXBmQllQSXhsWFR5VGRwR051VWExWlF4?=
 =?utf-8?B?a0g2QnY5OFh6ZENxTldTekNjS3Q1Y3NtY2p3MlhNcFBQaVFpSFBQZjZ1MHFZ?=
 =?utf-8?B?UUJ0R0RBOFpnWVJweXdJZFJiVW5vdVlhb29sVEFuK0VPWDM3UmpxRkJIN1N5?=
 =?utf-8?B?b3VFNGNuY05JZW1jbS93YWs3M1plWWtvR1JqbGgzeHBhN0hYeHJQejVoVHZu?=
 =?utf-8?B?dUpjQ1hkb0JMRWlxQTFoZlorQWZ2SGZPWHFPQ0hrSkdtTVFtNnExTURwVEx2?=
 =?utf-8?B?ZnRJZzNzd1pSY09WNkk3LzZ1ZVpVa0V3YzlZSkNLNGV1Y2lucHlFbTZQWDZ5?=
 =?utf-8?B?YUpBS210cVdEY0w3U3JyeUcxMUhpSW4wV0l1Mk1kVG80T0VLWGNpSnIwSEkw?=
 =?utf-8?B?VWdWOUFOMThNY1hDajRCU2k5UnRLbCt1bURVNWFCYkEyZUNqMnE2cnozK2g4?=
 =?utf-8?B?N0ZjZ3hMcTk0NUt6SHVCYmVWQXpDQUZjR3ozTlFPWGVRSWZHL3piQ2Fpb09n?=
 =?utf-8?B?OVRZUG1CUk9UQ21qb1RIZUJ0QW82Wkt1RGJVWHM2bFdYaEFseFI1SS9WVUIy?=
 =?utf-8?B?bjFxS0FISm1qTVdKWTVSOVA0M243ZStXV1YwanE4VlVCUGpUWFN0RWNUSndS?=
 =?utf-8?B?bGxBMnE0SjNBYmx6eDlnRGk0dzV1WXBlNlRKSVRRTjFubCtIcTJDOFpIZlZZ?=
 =?utf-8?B?N0s4RVdSNFZyNFNUR0FuRmFGS1U0TTJ5WmF5QlJYVithbno5anpPVFRSSEVQ?=
 =?utf-8?B?YW1RZGNkb0VhZ0d0K0FLTXM2UGFNR3YydjF2NDBoc21OTnBEVXNMazFtQThv?=
 =?utf-8?B?TXlaU2ZXdXl1bnZVZW5VK1lSNm9LN1Bkay8wWnB6U3RkSWVQTzU3NXd6Sk5Z?=
 =?utf-8?B?blpUUmc2bldiUkR6eFc4eFdHTVVOOWV1R3pSY1VqeGhjR3FLU2FUVFlwMXBt?=
 =?utf-8?B?L1VlSTZML2pucFFQZWFObjRhem5WY3RSOUhYWlZCZDRQUmJCaE1ISnZOd09o?=
 =?utf-8?B?VFh4a0JDMy9ETTExMW1pTEYwQW9VbTNONnorekV6M3RkWGY2WE1tSjJZOWQ5?=
 =?utf-8?B?a2Zmb1ZyakpUS0JhMDFrZERqSGMxLzRRSjI0VGt6QVpmWjg4QmVaem0rQUVM?=
 =?utf-8?B?U0pmK3I4TDRMcEgreUkyNXdrQ1FIYzlBZ3VEOW84b1RXR3JYY0hsbGYvb2Fs?=
 =?utf-8?B?d1NsakJQZjZzSVRRRkttZTM5a1pWR0hMcWo0S2RscFJBN2FNa3dhekZHU0Vx?=
 =?utf-8?B?c0F1ak85Tkl4U3BTeXBSUHRvREYxbDlEUGNtNUNka09wa0dQMVpKOU4zaGFL?=
 =?utf-8?B?eXdPVlR4MEVVWDU0UXBXNlFxS1Iya3ZaZmI1endLRUNQckhxbGdaeGJ0aG1Z?=
 =?utf-8?B?cXdxeXUvYXhEQlFyS2lGOURDTkpPb3ovZjFMbmNONmR0UnptYlhWZTdHN3F2?=
 =?utf-8?B?N0p6cEh6RXNXSTUrbHpBMm5ubzVRVWM2d1dDSnM0cFVFYnFjN2hWQ0xXb0dN?=
 =?utf-8?B?QStWV2Q3NDdibDhEaWZxS0kvbFN6Wm53NVpodDUvbUIxWFkzREU3K0pNOENH?=
 =?utf-8?B?dmJvNy9YQi93bUxaVkVoU0tjeUhTTk4rQ2swRkUrV2xqYTdac0RGTXB0RzVw?=
 =?utf-8?B?ck9KdkdYTi81ZEpVbTlEUURIa2lqMzBhelBIRVdDMlVOWTFad1RxSDdvYjAx?=
 =?utf-8?B?YWwyRnFnVzFIS05DQU5nQTVXVlBRWllpc216aForeWQrc3ROVENFc1hjeVZq?=
 =?utf-8?B?YzlIc0h5ZjZHZ3Q0Vi92SitSNW5MZ0lTMTlkcGpHYnNLbzkxekV0TzRDVlpy?=
 =?utf-8?B?N1R5UDBmZ2dlSmxlNTc2VlIySmJENURHOWpTR3VqWElWMjlYZm83MWR0d1A2?=
 =?utf-8?B?TGdiUktOTXAvZWovekdQNHRlbElqOEMrSDJBeVhJU3JvZitTRXdVNUVYRkVP?=
 =?utf-8?B?azRpWlFoMG1lRkpLY3RMeDBhcUFYR0ZNZndWU0hzSTBVNWhRV25uZjROUk1z?=
 =?utf-8?Q?yJR90OqEq7xowzf5nWlahhs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9997cb61-9181-4999-7d64-08dddfdb89c1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:20:16.2218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2AouayxGGUI4SyAEyoGa4YJ2n5uFXgx4xDdkE8R86s+JrkM5mPLHO52hHoaRawRu8L1iQ1kFC9AVlVTkqEfk8r3szbAVrQBRMFz8GcBrfCPSOWIzB4BqFn69zDcR4AW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7853
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

Hi Marek

On 20-Aug-25 2:27 PM, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 8/20/25 9:53 AM, Naresh Kumar Ravulapalli wrote:
>> Enhanced the generic firmware loader to support QSPI RAW partition
>> loading. This would enable FPGA configuration bitstream loading
>> from QSPI RAW partition to program FPGA.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Naresh Kumar Ravulapalli 
>> <nareshkumar.ravulapalli@altera.com>
> 
> Why not load from UBI on SPI NOR ?

It is to avoid the storage overhead for metadata and management
for devices with flash constraints.

> 
>> +#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
> Use if (CONFIG_IS_ENABLED(DM) ...) instead of preprocessor #if ... .

Noted, will modify.
