Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CD7D2A00F
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 12:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEF5802C1;
	Wed, 14 Jan 2026 13:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fB4w9bnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E48808AF; Wed, 14 Jan 2026 13:59:09 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A0F8003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 13:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXYngw3eevn4cFOzuoSNJHoVZmBY+11YJjhy86s7m/kzNsCDr4TG69wjaLFYekp2SsgvfRTLrxz/OkUvJGRi5KkA38x7HvqkjyhAgvchvIDpLHMBucHVe42BEoIGATIwBrLENO+3HurfPoZG0XU+f4pP0Cwq3KmigozBcB863RpSXlsO4T2F7SyIrthbTvoKST1MOzl/T6hK7PmAxcxfE8AKngXw0yY3uICJnEDnTPw4+Uw5UbJmyA4e0/JyBAwbfOcdmOFezugDtXLkzpFKdyU8cjhTTvY8zDLN/hAj5DoGYzcYtr1PoYZDsAS8iFfcvfPL/m+FNbtZBA3ktkJ5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxf+XN3lGVwd5JKDhMtJdK/UyjIEH9ollgw2e2dnojE=;
 b=dA+aJYtb0YH2ftIVN3R2MfXQxLYeG7VEN7cd4FKXsC4w3mcPUcltO5CPihtEcR4DQ+pYhd2qixi3+T4MRPB6ZOFqG1wkLFeDcdJbATXEp+S0amvfmpAx+voQOrGFKVTEiuk5w9kaGxYqyNIP8WM5nqpJPaE1G23jMBHqItTgt9c5AXfT0gcIIByt0iaXa3Np9/EU12v+xULWo2XLgGbcxAvUvzfS2CFhszqtJqAN8hHPwIpbhcnYZxHj/XJiQtUwIBkfRK4qYyeSWm9tOgthJJd4DmE37I3IAeR+QP9q6follJI+II/NpLEyZbK62cuLUsmhOrUgvWSCfldIVPNG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxf+XN3lGVwd5JKDhMtJdK/UyjIEH9ollgw2e2dnojE=;
 b=fB4w9bnnHiUw8MmnjLjE/zm8X6ZJeolpFLTuNPIK8BdfqZDWlvycGFHoAVR1yIKLtIxnIIEyqAz3lth+/7JNePIncmEKeuWcyjfRWsyi/vmc3qMKNDbmvUzvWyVYmb84AUQjMNWTQAXapaWsosubxYgQtwMHDZUX8j7Sll564pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by PA1PR04MB10144.eurprd04.prod.outlook.com (2603:10a6:102:460::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 12:59:05 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 12:59:05 +0000
Message-ID: <aa20052d-a870-46ce-a666-06d58e7584d6@cherry.de>
Date: Wed, 14 Jan 2026 13:59:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mediatek: remove extra gpio header
To: David Lechner <dlechner@baylibre.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260105-mtk-remove-empty-gpio-header-v1-1-01dc6c70eccd@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260105-mtk-remove-empty-gpio-header-v1-1-01dc6c70eccd@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|PA1PR04MB10144:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df007f3-56c0-4283-0e90-08de536cb291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czArSlJsZGc4RU4vVG1MQ3MxQllrVFFBdGZ0NHNEbDg3MXpNaDdzaFVNbmhH?=
 =?utf-8?B?ZW5rSFdaUDRSOHpjWjdxNWxkUGhLMkZQd2xzdlVQZ2pVSDJXVlRVMVNTbXF6?=
 =?utf-8?B?a3dGS25vQWRzSzROTkNFWGdpeVlGa3JWeENpSTVrRnJDaTMvZVBqM3AwMWJM?=
 =?utf-8?B?clBidnB5YS9Pd21PL0lpNEdwcVhPY0ZuNWFOcllyQTg2NFQ4dDRqUkxCR2Ra?=
 =?utf-8?B?L3VzR05ITm1rcksvNWV1TmN1Z0FiK0J5UWRlbkxBUlRhYkZ6alRJbFJuTC81?=
 =?utf-8?B?RlJ2OUhQY2xIY29LSmsrUkh3WFo0Y29BSk5nQUwvalNsSlNWOGFjbmIwUXZU?=
 =?utf-8?B?eG5nckU5SjhvWDlybkg2VEFOSzdRcTc1RkZsSDA5dzFwT2tGR3YzcUgxNFpa?=
 =?utf-8?B?WHVzbEcyN2YvcldodldSUnkvRlQ1SzU4Tld2OW5sMk9JOUVRdVVoYklleTlo?=
 =?utf-8?B?WmptMU83aHVVZ3pCUTlBRzBEcjZHL2c0VTlYQk1YOGtSd3h1NHp0VFkzSjJJ?=
 =?utf-8?B?bVdnUzhIMVk0Zzl6Qnd4V3VJdjk0Ukp6dThkTkozaVBOQ3BoVFB0N0xtTFc3?=
 =?utf-8?B?bDVXR3BrV1liTklXaG5FQ2dhNFVFdzU0eWJ2VDBvVXpDUWtvNzB6V1ppcXlN?=
 =?utf-8?B?TW9KWEY4eWtpWEc1a3dMTFYwdnJERUM2emJ4RUNqZTJaY1JCeVFnakIvaFpq?=
 =?utf-8?B?aDk0SjFxeitNYldPaUJLMEp4RFVkTXBjMlNPdzMzYUVieThWaGFpRVVLTnFR?=
 =?utf-8?B?dFNsVVptTmJoak1QbCt5SWdWdHRPZ1E3UngvcWJjUm5qYnBMYmRUd280dWJC?=
 =?utf-8?B?TEJ2YWZZWDRlMmVrNjVHT2VlWmxZSlU1WUtDZTYxWENnVkkydGNQWlE4RVU0?=
 =?utf-8?B?OTAxTHdCRXRHdGNibHhrcTEzVEpuWHRaTitYbDBkZU1oSDh2UlpESDF4dFBQ?=
 =?utf-8?B?VEZWSXdHcElVaDZvWGczY3hBNzI5em41UktialRrS0MyVEEzeW9WZWtndFA0?=
 =?utf-8?B?TXVmQlFraS95Z2t6S2NqWnE4L3BaUmthcG0zMFUrTFozeE9SRjhvV2VvTVZS?=
 =?utf-8?B?UE9KTzgvcHRHY094UnE1MzFQV0lmWkYxeVZxemxvNmJZeS9maU5VaCtqUEND?=
 =?utf-8?B?Wm10Mm1JWHBBSTRxU2FCNm54aURJTDRBUVNaQnpzYUFxREhXbnhlQ0dlZEpm?=
 =?utf-8?B?Y2dXNEZOQkd3Ylh3RHJ5VHNYM1J4bkFFeE1Xb0dubFordXM3d0pwTWU3TFFX?=
 =?utf-8?B?Z3JSUWNsUzVzTkU0Rkd4dDJKOGF2aU8rUHdLU3RNOExCcDExT2l2UDFSekov?=
 =?utf-8?B?cUs4MTNlZnFpMjRBaVRYanIwc0VJSWx3eXRKSk1Mck1mU0s3UTZGcnVKYTFZ?=
 =?utf-8?B?OW4vZEZnZEdaRVVEOExoZFluSmE5ckRXWnhqWWI1K1oyMFlPUk5lWG1UejRM?=
 =?utf-8?B?ZEtoRlgyL3ZmUVZQd1R0a0hkTDNlbWZUWlE3VUFkRkFoSUo3V1d2Sitia1JX?=
 =?utf-8?B?U1VnSU9EbVQrU0hvN1ZOTUNodGIrbE9aOHNDRWt6Z3pIWTd0ZUNBdStZR0lI?=
 =?utf-8?B?d0hKalArS3VTTG51THpWendWMzBCaXNCNDJHYlI2RTlxVHFtVUNWSVcxbHRn?=
 =?utf-8?B?MTEwbUswZ3RjRC9QM1VaekNTQUU2d3h4SlloWjVqaExFOWZuNWxBNVhsYVRn?=
 =?utf-8?B?R0djaXF3RzdUS05VNDhaTHpFdE9Gbng3UjdTS20xc1ZqZHBCcUtPN3JqTE9O?=
 =?utf-8?B?Y28rbE9mZUdTdXF2ZkdrT1pBaDRtRllYY0EvZDhhYk95OUdXbmRSNVZ6S3dD?=
 =?utf-8?B?RXhDTWJVcCtHRHJhemY4M0FyaUw1eUt5ZUZXMHBwVHVQZUdQMmhuQW9PRWlk?=
 =?utf-8?B?YXkycXdTNmRHcVBwK1Z3bTREdVNmNUVTcHVEcFVacEN5SlhlKzlNNHlXbDFM?=
 =?utf-8?B?aGI4U0p3cjgwajVnQzBvaFJsQ2NKdzhzTjB1clRZNlExSUZEcnNucHZvVDN4?=
 =?utf-8?B?YVNOZEJBVE5hMDRuWExVellHeUl5bUEranNsclNFMGVHa0FBdms4QmhPUm9h?=
 =?utf-8?B?RmJHZEJuRUZBZjBxUXJ2OEVkNXYwUW94VE9SK3RuTFBjb3M2aVBZazVaeEZs?=
 =?utf-8?Q?VBsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0o3bkYrcGcwYW4xZEw5RnFINnBudFlDcGxFdFg4cEJ3OC95QU91MTFnQzdZ?=
 =?utf-8?B?U2F5S01KYitFalFzWlJLY3ZheGxkMXJUVVcwYjRVR2sxeVpvTTcwVnljKytr?=
 =?utf-8?B?NmhOMEtPN0tHOXZ3cHNlMGFjNDErTDAyV2g2aWEvWjNrM3hPN3R2dTBOYkh1?=
 =?utf-8?B?Z0VCMWFPbUVWN2MvUnpLb2xtYVZVK2lJOXc1cjBGbTRmbVhHNlNmUmpXenRV?=
 =?utf-8?B?Y01ULzVWeSswVU94bzVmUTVUVG1TSGp0ZHg4d2pNNGgxUmFBMlVFeG1ianBu?=
 =?utf-8?B?RXVqQXdIZ1g3dnlKdjB5NjAzOFU0Ulgvek5wMm05VW5NeFFRVWJPMXZ2OHpH?=
 =?utf-8?B?R2RXVEF3SkowTDFrbFF2dC8xM0FHNVcveDBsb0RELzNXZEdadXgycm1yNDNC?=
 =?utf-8?B?aW8xb0JRMzRIeXZIWWFYY1dzSktLYXNTcnRWSEVMQ3E5emI5cGhFSmtHTUJM?=
 =?utf-8?B?UkhWaWpQOGZ0MlE5Vm9zaGtPNVEzL1FVejFzWXFpRjZJTzA5S2tYS3JhNlVF?=
 =?utf-8?B?eTJEOFZOQ2Z1bUxuTkpkY3E3RjIyanRTamdicHQzcklnMkV4RXFoT0R5c21N?=
 =?utf-8?B?TFErT3lydGJoaWZJRmtKaDhPWFZDNDR4NjRxK2Rxd2JCTlRsM1Z5aDRRbTJ5?=
 =?utf-8?B?dnBaaVpXRUpjNWYzVjJxc0N0YjgvaGpOVnZWL2dwTWdYSjFuUDBBaEhadEt5?=
 =?utf-8?B?eDA4eGk2cWNiTU1RRU9mZVNPd0ozbE1SWVRXYkxrcnQyYy9DQlBBTmY0WjYz?=
 =?utf-8?B?YXRCZVRNTGxMWjErZURHRDlTSW50dEQ1L3kwR2E0TGEvZGN1OXczL1hENkRI?=
 =?utf-8?B?dDFsalIvV29zWGFoRW1DUmxlVlVYNWwxUGdWaVZxTk9ROWs0bFZjb2NqcmdE?=
 =?utf-8?B?R1lxZFJyektaOWtySXhpTDZBRU5MbCtsa25YWk9VcDAzUGs5YU9VTW9ValNr?=
 =?utf-8?B?c1hmKzAydFlPWGkva0R4QXNKWWpBS05sMk52bmowVFdOT1ZRb3poZ0VXUlh0?=
 =?utf-8?B?UVlsZ0lxaHFydGEzZkp2THZUUHVzTWlLK3RrTHBqYjZaK3RVSjZ3cEFpdC9I?=
 =?utf-8?B?M3dRbVRYSG9rY01zWDJzU1dDYlFTNVBRZUhESnFiSS9WSWZiYy9EeVdqc1ln?=
 =?utf-8?B?SlovbHFLYUdmMTNsbEJ4K0EyVDNIWEcybExOTWR1QWlUOHlIdzdKQWEvY3c1?=
 =?utf-8?B?MXpKRDV1akxJbVNhZHZycFluTDNmLzZESk9xd20vd0hQbTNHSEp3RDdFQU1C?=
 =?utf-8?B?QnJlS3dISUdOOHRPd05PZVdnblhDR2ZCYU1NbmhyZEUzYVpFRUwwL3gxb2Rt?=
 =?utf-8?B?dXloYnI2cFFySmJNQTZrdkJZcWlVNUFDeC8rcVVEWnBGaFVmVmdBWHZzVW5E?=
 =?utf-8?B?NXhaK1ZlQnVjdlhsSE9TR0M5UmR0SDRkMGxXZUxvWkk2THFxUlJ3eTFKRjJq?=
 =?utf-8?B?bDE0WWlTeHNtbC9rd3U1eHZJUnRVQ2RtWWxyMDZXY2FLUFF0RUpmVE9iRXJY?=
 =?utf-8?B?bDIwaGtJbjQvRXIzcmFCZFgrL1Z4Z2Jjb2FjL0pRTHV3d05Zc2doVndOeWll?=
 =?utf-8?B?NFU1amY4YkcrMm9GZFZjTmEwcXFqdUdKd051SUU0WlN3VXplQ2FKNXU2QUFH?=
 =?utf-8?B?dUs4Tm01Z0RYRXo4R2Y0RDdGQnZTZW5pR3hvSk1EMVRIdGZhZnhOam9KL3dv?=
 =?utf-8?B?UFlDTHk2SmFHMmJqeTBIbVB2Skl1dUQvamFlZVR5R2tJcDVSYmJTU2VvNWVI?=
 =?utf-8?B?Q0p1cHp5MFFhMmxUcEkrTUh2Vm5Dd2VtVWp5cXRaaG9zZC9qdGVSV0FZTzJJ?=
 =?utf-8?B?Y1lSa05RbEt5VUw1bDIrMU1sK0hEc0UwdCt1TjJYZkduc0hiMEFDZmo5N2FI?=
 =?utf-8?B?UjB4SzcvYktrbXlHMVMrNTVCN2ppWExHQlpCUllVUlBzaFpqTlhndGpBUG5Y?=
 =?utf-8?B?aVdNTnJiTXZLeUhYV0EzQlhsTVh0MlZhcG1oUTI3T1JNbjQyZ1UwbnZyR3BO?=
 =?utf-8?B?blAza2pJK2JXN1NMZFlPbmRjWUd2Mk1QbzVnVVp2UTd1ckREa3pLekRXd1RG?=
 =?utf-8?B?WFZkZlR6QlNDZDI5M0kxaFFncHNrOUVaZEZ4N3hzUUVyaGpwQlBDTnE3QTdw?=
 =?utf-8?B?SDE2dEU0YmgzckwvaVlvS3d6UGJzUndjOElSa0htUWhKT1NBWTZCRW0xTnFX?=
 =?utf-8?B?Q0dlZUtGM1hPaiswQkpsaW92YXpoaEtZazdoUGJDTVdWOGQ1UmJ2SHlQeTFp?=
 =?utf-8?B?K3FNR29JV0czeXYzbE9XTXVVUGV3Z1JtSnQ1RlE0SG90d0tVTlNWS1V0eThZ?=
 =?utf-8?B?emhsd2VMaDllZlg4NGpiYlI3L3FOS3I5SEVSc1JQWlNxWUpUellLUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df007f3-56c0-4283-0e90-08de536cb291
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 12:59:05.2108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSjiFLlHqnCSMKKRLiR2r2H+X+qQtNHgay6nYGh2oKj6fakmSVsp0XexD1ced/8833a/0XqQqoEMJer28ElioHf6hZKM7gRBENaqALa5GvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10144
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

Hi David,

On 1/5/26 9:47 PM, David Lechner wrote:
> Remove empty gpio.h header file and CONFIG_GPIO_EXTRA_HEADER on
> ARCH_MEDIATEK. There is no reason to have these since the header
> doesn't contain anything.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
