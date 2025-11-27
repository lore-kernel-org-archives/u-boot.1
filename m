Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F84D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 10:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BA884375;
	Thu, 27 Nov 2025 11:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UrxlVKxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEAA84375; Thu, 27 Nov 2025 11:36:32 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7728432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 11:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLat781bXwILN6k+lDVb7TL7ofWn6QJME7jO0ASBBM3zzlsL65BZo6Vs8HuWaJzjvYLp9eUbOXQeeMWgAEGjG4qL36kG68isEW2uo/Wt+TgXjUkipyTMUfNOXFZc+4jdCQJS3GMkVN2gMiY5o3RzpXazu4fuEVispiB7F1/1w8Eb3/pTm6rXVzSoIzNo4R/zNyVeWRCOqp6c1KVQ8klnDICBcg/E253I0YAc5IkHlxFUonstVF/i12CMsGxuRmv/jB7AcJ0/02IqIIe/4K7aZVM4c8BVj5IIZ4ocgsBuL7bGS1sDGrikP3qNbGoeyU1EAPfkPPLB87tPNi2zS6lVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxFb8Uo4wxb1/QXP7K0o08OEpuPZIWqUKxcvbjcW5go=;
 b=hUaXMDoWPYUxf08DWYcC8L+RxWSAYylBSbRJc4Ss58vhK7avNxW5Rn9U4Czdp0pQCav51A2S4GdEBAyLJ5py+MtQGy5S1KPeFsv/O3ENwHLQ7L5B/jHpdhq6RQjxKcYY+Mp4jz/gEBKQfvsPESH+bcG1/xnspaIYdDVLlum7y3ZKQ0Nm3p0aQZXvspA4vt0xoKMWEd7ALWTMmEbluyletPRMkfGkaf/SlXSMymvuRgIExx0MYwIA8z+YlDYWO9wQxyvHxZyEa5z/8T7lfEyaWQhHe4tZTbacMoLopMWEcp1P6TkcOGQXyB83rPcFSr8hr6quxJq1lg0b9kXqvPN0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxFb8Uo4wxb1/QXP7K0o08OEpuPZIWqUKxcvbjcW5go=;
 b=UrxlVKxbUuH/tAr10ExbE5tDoKVt5Fh+hf7X3ERMGdzXL9TxZ/8s5eYahKDduN1rZtwhQ6oHjtWq3WQzn3WYbzk6VT5vp2mvUQjlNGjJQTT62ABs49DCGEi4VtwGOLkqol9PEgNF7OLQ0ZNZ342dady6SVHdVNgYVUiQ20GTX1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8217.eurprd04.prod.outlook.com (2603:10a6:10:244::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:36:27 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 10:36:27 +0000
Message-ID: <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
Date: Thu, 27 Nov 2025 11:35:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0039.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::25) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d536c3-b68f-4622-a561-08de2da0d1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnNDV3UzTTBWSDUzRG1hUzJxeDI3aWZoenprVTFlQXRSQjlBOTNvTDlNN0ZR?=
 =?utf-8?B?UktRUkc5T2l0SVRYQUZUckY0Z09VazVBZHMrL0g4VDE3VlVacWRGbHdUYi9o?=
 =?utf-8?B?WkFCT2NBWXVzTndmN3Fmd01NNEFiTUFUQWJVQTFLdHp4Y2RhTTEvdHJzY0tj?=
 =?utf-8?B?dFNhZVE0ZUtrNXJPM3NpTyszS3h2T05NaUtodmdPalk0S0tCdFM0dHh5ekNt?=
 =?utf-8?B?MjVMaDZQd0NRemxaOE04Nk9KR3pzYTZUTFU2OHNXV1hvNEdYTUhNYzB1YW5k?=
 =?utf-8?B?ZGZrbEEzRElCTVhvSXlMYld4eWI5eUoyVXVKUmZlOU1qaTg3TGJuZ2grUzhP?=
 =?utf-8?B?bHVtOEl0dXc5WHhYVmJTbmxndkE5RFZCdXYzTWtZUlJ6QWJ6ME9GRzgwYktN?=
 =?utf-8?B?UnA4cW9vWWIvNTFzdExMTi9kSzBEeHZIZVNxejBXNFcvTUY0U3NmQ25nSVdi?=
 =?utf-8?B?cjhPOFFPb3RwWnRoVy9GQ2ZRQTF6dWk0ajVpVHZuS0xIeWRmYncyVHhmdFR6?=
 =?utf-8?B?WUNLRmJ0dEpiSVZBWFE2TWRuVGZaZldxUTkvNHgyVlNmWlpRUnhaaVJKVFh6?=
 =?utf-8?B?R3dTT2xncVdNcWpUT2FtdXkwQTd6M29Uelk5OUxBUmNoeFFlbUQrOGRnem44?=
 =?utf-8?B?UlNZOGVlM2tNSGVBdi9FOG9mY2xiemxndUFHWGFMUFR1VC90VU9zNk5WZ0NW?=
 =?utf-8?B?SytTQTBKajkyV0VkRklNK3NubjBQUU5zNFNldTQyeEJ1ZFpFbjhVanQySVlK?=
 =?utf-8?B?YzBVZnYvYXVRbzNzSytUNjNzNzdXQVBNME1wSDFJWDhoUkxYNlZUeE91VzRB?=
 =?utf-8?B?ZWdCOGhuSmVyVE83N2xhdGhpcnY4Y2d0ZkhiL0hXb0tWYVc4aStyVkp3dENu?=
 =?utf-8?B?RlRaQSthT0Y5MnR1NEdlRTMvUU1SRGZrQ3llZVl4KzVWUEJnTHZMZEEwRnds?=
 =?utf-8?B?ZnRubmlLU3RRM1JMVCtQUnlLa2Nxc2VGQ1p3QmJUcHpNTVFqL0pEcnEzM1VY?=
 =?utf-8?B?cWdyTEx3WHpabi9yWHlLaVV2R0s0VUFaV1VlOEE3aitLWitoUWVDK0krK3lF?=
 =?utf-8?B?T2ttSTBlazEveDZQcFZEVDZFQzdmcG5hZW9scmVhUGJEdDdFVUpKaWdLcUx6?=
 =?utf-8?B?MDlkREUxWStpNkhaNmk3dEQzcEI0Q1VHdjFUdDRoamRuN1NmYkNRU0N6eGxH?=
 =?utf-8?B?ZWNYMEhQWUJ4c1ZxRjl0aExCaENtNDk0WTNXK00vd1I2cW5GRU5JT1R0dlUv?=
 =?utf-8?B?VCsxNWlOWmVHRVNxWURhSGZOOW5sblo4ZVpNVWVqTWhPTjBHSC9GMXhQdmZE?=
 =?utf-8?B?ZEs5VmhxcHY3YmV2UDlveDNxaExTWHgrcjFRL2hqZjBCN2ZhZjJKUUthdzJP?=
 =?utf-8?B?VXNKWXBTRlBSSnV0dUsxVkVudEpYK2FycWlUR1dUaXplQlVRWGJDWWFweTQ3?=
 =?utf-8?B?b1JaeUhjR2ZYQkF2OUhVRDFmcDY0ejBsZXpaYTNtVEx2SjN2SGZRKzN5YlhW?=
 =?utf-8?B?TnJpNHpaelZEQ2xEWDhNaStHSXBkbjZBeW9BOWp3aWN2MGRHSjhNdFNlV1g4?=
 =?utf-8?B?eithOFd0UDVQTEMxeFFDZlU0VXlsUDdiV3I5OFVIeWkwaEJZMWZTWlcrandy?=
 =?utf-8?B?UjAzZGM4Nlk2dys0YSt1MHJlU0ttRnhQZzRCa2t3RlRDRmVNeEF2NGhHanVK?=
 =?utf-8?B?QTFzcUtNV0krUDFjejZRUGExVjI2YUphaFdEd203K0lrb3pSRWdHdUFHbllT?=
 =?utf-8?B?VGhPcVNKbmN1NGNtMDZNZ2ppL2hlU0NxR1NVWE1tdCtWUjJ4clhJWko3VzVp?=
 =?utf-8?B?UksvaHVzTFRnWnQzOThrUlZkQmtsRmNMZTczS0Z5M0hsUU9hNnlxMkNXUjF0?=
 =?utf-8?B?MUdYZU1GMk1SWjBONFhEcUFMVjliRExXL3psaVFndVhGb0oxYmw3eEpwbU11?=
 =?utf-8?Q?cw2MOvMKRaVAQPINng10LZ9TEESlu1J4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dNQTFabmlIbzlLL25UMHlZUEp1M25lSFl2dkd2Tm04TE9OcVRlNWRVVUVn?=
 =?utf-8?B?UXNRallFQ0UxTVFMQ0M3YzFEM3lQMlJvQXZnbjNqQ2FHdGNhbGYzcjN3UlJm?=
 =?utf-8?B?alFRcW1PQkRTRjBOQkNIRG1xZFNDdzZhMk1OV0tFR1B1RTZNSnEzZ0VWTTZ3?=
 =?utf-8?B?N2c5Ykp0eERiVlJ3R3ZBaG9RUFlVbHlUMEZ4akJETEdMZVFEVXFRN2d5eFk5?=
 =?utf-8?B?WlpkanNhNU1GRlV4eTl0SVNySGhzYXNNR1hKWThLTEl5S3FmMjVlU25yOW9i?=
 =?utf-8?B?VjJIeXNmRnBycjZCMERJTkMxay9zcHVhbnV5akpxRXBUdWVFRWo2OVVyTVND?=
 =?utf-8?B?YlBwS3FZcnVKYmJhNGptV29yVk8rYnpiVFFPN3ZGN0Q2M1Q5UjIxeXZtNDVo?=
 =?utf-8?B?ejJRWk9MVnA0RStJcU9MRDBCSnJDdHZ6TEFLNVRCK1hWVkxMNUF6OHJ6aEFU?=
 =?utf-8?B?L2loRDlDb0IxYkZEMmNISlhPdy9sd1lQeWFSZWFheldwbWs3NjFtc2tEZndm?=
 =?utf-8?B?QmNnYXVWTElxMlAxYm5hUC9sd21mUlk4TWRxUHMwV0dkQTdQb0I1Z3djRW5z?=
 =?utf-8?B?c3Y5RnA1bmh6ZUFSUTFTTENBZEpkZkNJc05Oekt6emh4T3RZOGtMVy9WNVE2?=
 =?utf-8?B?WkFPOEdoVzhmQzhBMDl5cWV6YmZoTFk2N3dBMVFWSk41Nk00Rzk5em5ITUkv?=
 =?utf-8?B?Z25oQ0U3eUQycDlSZWhiSDZFS2p3MXJiSks3SzBEOGV6M2xGbG9Ecjl5UnBj?=
 =?utf-8?B?QmIvWlhaNXBkbWx1Nm9aM0NMZ0lldnptVlN2OXR3dnlCRjFpWlA2SWVyR2lL?=
 =?utf-8?B?WnZvem9FQlN2eGVXMzRMaG5GbVdlelkvRTNaQnI0TWdiOG9jcEMyZlVPWUc1?=
 =?utf-8?B?eG5nUUZwUTZURkplN2tQZEYvRmhvVy8zcm1HYTlIdU0xYkxaMG9MM0U0cmZh?=
 =?utf-8?B?VVBYeS9mMExuY3h6S0tvWDlncUxXZStFYTY1M25VTGphMTN2ZEY0R1ZoRGFO?=
 =?utf-8?B?YjdSd0pzeXFzaWdqcXQ2b3V3OE5GV0ZMcGZYbW15V1pPYzR5SDllSVIvUWhk?=
 =?utf-8?B?MVVyU3Y1T0pCd1V4RWdaZkJOOWN3a2tESmZsMGFCVTBTUnpYaUdtSUFhS05M?=
 =?utf-8?B?Z21mNVkvdlk5VkhvMExuUm16d3BPTjhLQzB6dXN5WGRsWkx5ZTBDMXEvb284?=
 =?utf-8?B?OVA1MHc4VGJHNFFGRmZ0YytyeVdpejl6RitFTitQNTBTc1BySGN4bHhuTi9H?=
 =?utf-8?B?ejR0SzZlRHdtUFBJa2hjMmVKRytRMCsweVNqWUY3RFpXS1p3SytpWC9jTXdM?=
 =?utf-8?B?TUgxbk4vODRIL0VLYjR1U1o3V01oWHQ0eCs2Q2VBaCszY3Q1L2pSa2V6SCtk?=
 =?utf-8?B?TVdkcWZPSE1CNUoybEtoWHhsbWFLdG85azdhNTZZajdTRGU2OTU5aWxHcW0y?=
 =?utf-8?B?dE9CV29MdlJjTk1WSUFnMnNzTkJaSHJZWEMvYWNFYjRuamtpS005UFYrWHBw?=
 =?utf-8?B?MlF5ZnZ3cVAxKzRsTU84c01zank1ZGxpODhiTldra0I4a1ZuVU1BS3EzMnBV?=
 =?utf-8?B?YVFLOGRSeVRMT3lsc1NSQVVGcXJnN25ER3Q1cWtxY0hNUGNBOCtoR2pCSFRN?=
 =?utf-8?B?dlJYL2Zza3B5OWhCdE94MnhUQ1ZmZ2MwMmZFNlo1QlVSUGU4Q1RzU3FXbHdC?=
 =?utf-8?B?VXhuYUNxbVhHVGx2VHhhdUs4YkhHVlJsOEhabmZ5NjFOUi9yWk14aWpEZnpH?=
 =?utf-8?B?SHdrU25TOURncmQyZzNmejlmOU00R3hURUxnK0g0SEVVQzVhQVdNSHREV1ZH?=
 =?utf-8?B?cjhqblRKaE82WldwUVdIWUducU9yZ0NWNFlKVE1TUW92N3drYldLUUZwNDI5?=
 =?utf-8?B?aVVSbkM1RkdFcnRxYlpXL2V1NVJsRENqdXZoa0JqbzQyS1NJa1NtRS9ub2pt?=
 =?utf-8?B?QUQxZnZYc04yNlh5RjcrUndqdW5Hckt5YnhSamhNdlNtNlJSS1oxejVnb3dG?=
 =?utf-8?B?MHNwQVUyWUl2RzZVUXF3YitoRGY3YnJjTklkamw2R3pPOFZqV0c2OEdDVldj?=
 =?utf-8?B?R0hHem9vaEhjelpZU1hQcnR3RHNZbitXVzJYclVIUGNhVVhiMERPTis4ak9h?=
 =?utf-8?B?LzFsaGxYMm9XU21xS201b1dKOE52VkRUa2NhMDJFemViRmdIZUJvWXRNYldk?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d536c3-b68f-4622-a561-08de2da0d1b7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:36:27.0668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7bHBcBsWV8XsajNnXpIjfFVsV85gMh/KEz+LmutKdL2pDF7j6keh8olwVOgDazuYLsB4TCGEefwRbNkBikPZ8Yatmc8BNU49W0HIZU/Dkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8217
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

Hi Heinrich,

On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
> On 11/26/25 16:00, Quentin Schulz wrote:
>> Hi Heinrich,
>>
>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>> Hello Jagan, hello Heiko,
>>>
>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial 
>>> console output stops after "PMIC:  RK808". The same can be observed 
>>> with v2025.01.
>>>
>>> The serial console works as expected if I disable 
>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>
>>
>> It is I believe implied here but asking for confirmation. The board 
>> doesn't actually boot right? It's not that the serial console is gone, 
>> it's that the device is stuck?
> 
> Hello Quentin,
> 
> Thank you for looking into this.
> 
> The device boots I. But the serial console output becomes mute and I 
> cannot send keystrokes via the serial console.
> 

Uh. That is *weird*.

>>
>>> The problem seems to be specifically related to the bt656-supply. 
>>> Removing the line below also fixes serial console output:
>>>
>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/ 
>>> rockchip- io-domain.c
>>> index a0573c52193..b0d78f2d4b4 100644
>>> --- a/drivers/misc/rockchip-io-domain.c
>>> +++ b/drivers/misc/rockchip-io-domain.c
>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data 
>>> soc_data_rk3328 = {
>>>   static const struct rockchip_iodomain_soc_data soc_data_rk3399 = {
>>>          .grf_offset = 0xe640,
>>>          .supply_names = {
>>> -               "bt656-supply",         /* APIO2_VDD */

Reading the code and this diff again, this you shouldn't do at all. The 
offset in the array is the bit offset for the IO domain setting in the 
GRF at offset 0xe640. So by removing this line, you configured APIO2 IO 
domain with APIO5 settings (audio-supply).

It would be better to write NULL instead, so that the others are tried 
and we can pinpoint the faulty one.

>>>
>>
>> The UART2 (which I assume is the serial you're using for the console) 
>> isn't on that IO domain. And there doesn't seem to be anything 
>> important to booting on APIO2 domain according to Rock 4A schematics[1].
>>
>> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0) 
>> on RK808, which is using VCC10 (vcc10-supply) which is a fixed 
>> regulator whose parent supply is also a fixed regulator. So I am not 
>> sure what could be going wrong there.
> 
> In the schema LD05 on the RK808 is connected to VCC_1V5.
> 

Sorry, I meant to say LDO8.

> With any of the following values I can enter commands via serial console 
> but still get no output. So none of the voltages seems to be the correct 
> one.
> 
> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/ 
> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> index 046dbe32901..f15b5b63815 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
> @@ -517,7 +517,7 @@
> 
>   &io_domains {
>          audio-supply = <&vcca1v8_codec>;
> -       bt656-supply = <&vcc_3v0>;
> +       bt656-supply = <&vcc_1v5>;
> or
> +       bt656-supply = <&vcc_0v9>;
> or
> +       bt656-supply = <&vcc_1v8>;
> 
>>
>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa 
>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain 
>> driver compiled in.
>>
>> Can you check the error paths (all the ones with a continue;) in 
>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>
>> Not sure where to start debugging tbh.
> 
> I found the driver by setting CONFIG_LOG=y and log level 7.
> 
> Here is how the console output ends. Do you have access to a board or do 
> you need further debug output?
> 
> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
> regulator-state-mem
> regulator-state-mem
> ofnode_read_bool: regulator-off-in-suspend: true
> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
> regulator-suspend-microvolt: (not found)
> ofnode_read_prop: assigned-clock-rates: <not found>
> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
> regulator-min-microvolt: (not found)
> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
> regulator-max-microvolt: (not found)
> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
> regulator-init-microvolt: (not found)
> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
> regulator-min-microamp: (not found)
> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
> regulator-max-microamp: (not found)
> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
> regulator-ramp-delay: (not found)
> ofnode_read_bool: regulator-force-boot-off: false
> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
> regulator-state-mem
> regulator-state-mem
> ofnode_read_bool: regulator-off-in-suspend: true
> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
> regulator-suspend-microvolt: (not found)
> ofnode_read_prop: assigned-clock-rates: <not found>
> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index: 
> regulator-min-microvolt: (not found)
> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index: 
> regulator-max-microvolt: (not found)
> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index: 
> regulator-init-microvolt: (not found)
> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index: 
> regulator-min-microamp: (not found)
> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index: 
> regulator-max-microamp: (not found)
> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index: 
> regulator-ramp-delay: (not found)
> ofnode_read_bool: regulator-force-boot-off: false
> ofnode_find_subnode: regulator-state-mem: regulator-state-mem: 
> regulator-state-mem
> regulator-state-mem
> ofnode_read_bool: regulator-off-in-suspend: true
> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index: 
> regulator-suspend-microvolt: (not found)
> ofnode_read_prop: assigned-clock-rates: <not found>
> ofnode_read_prop: assigned-clock-rates: <not found>
> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply: 
> 0x7a (122)
> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at 
> 3000000 uV
> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply: 
> 0x91 (145)
> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at 
> 1800000 uV
> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0   $
> 

This seems to highlight the issue is rather audio-supply.

And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.

I'll shortly send a patch to Linux kernel with you in Cc, please give it 
a try as I do not own any of the Rock Pi 4 variants.

Cheers,
Quentin
