Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE825D49C73
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 08:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354CA8426E;
	Fri, 30 Jan 2026 09:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxKERxPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5383D842C7; Fri, 30 Jan 2026 09:30:17 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383C08421E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4zrI/zxsGKFguxTFTcCh56pSKTHyKUuwA9q66ipcM2GxuO3Ps6XZNUUEhMuykjQoXwudunuuEAy+vRIOi7l5UpMfGA6/ZTP/gJxg7cj79wxwG511bndYS9yk6sfPZHGgzfArjcDWXJV9rkI7U1ahgsifBUe8ayjAJJ0HuM0zwYRzjwRuUUq96wjyxhMw6ZuOodNragNUJ9IIdAWvZbcAVB7SuVuAJ9zFfXfWJLvFalZgeFhcLdUd5onkdZXxYoHyGUaitblpJtzCL+2LE3O/X6N8VDZ0cgm0A5/5/7BEUjcoy0+RyV1V7df/6Xv2s9TGdytI98l8UtS4mDlhGFiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgKq0icb1efoDmKmBQZAlh4F8XYSv9hB47TJOVDUP4o=;
 b=tzwguM1imRi3zneIxKb7beWBVmPWtPEpF8R/bQeKrJk05nZUr32xiwLVUDar6ROBrrdMHkMSX2GlcUrPHC9OH2UQSslWFPHuyUkwccNOVPqhknn4HWOu4ZlQSmQni7kO14BioL/MxzfVbYeN/j12aHbjQs1Ir+7/yXYakgvejGKwPh5r+wtssetl5RpwO6K8Nj2FU7VUChfNcxMWFuxh23HJS84yRHEfaDesifbXIM0iIThSMH4TXDBLvOiF/pRyR8505KTaVGHy5YpqjO+7K+KiXZpNhyqcQIzzjplTEVOD0gnFMR5XMb1OExFP4HxTwPEjdvCxa7taZdMU7NKQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgKq0icb1efoDmKmBQZAlh4F8XYSv9hB47TJOVDUP4o=;
 b=UxKERxPPwkz1Jj5N6zqW7RNPxzufGtsFPG12Z/dt781ixNXZYK9nHOsC07TBenGTUXzpCh6qz/u04r9TImAiKvCmOPG92KttDU40UUfLewHDPI0pGJ2g3EFPymQhgVHSEoQ1T4u6BRl17RZmJe9qTKznCvlpNl83D9TXbVN9z1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 08:30:04 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 08:30:04 +0000
Message-ID: <de5823b9-2214-47ae-9b4c-77cd413e34f1@amd.com>
Date: Fri, 30 Jan 2026 09:29:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: Add GPIO delay driver
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Greg Malysa
 <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <cover.1769086229.git.michal.simek@amd.com>
 <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
 <aXxb7L03qQ3jdnuT@shlinux89>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aXxb7L03qQ3jdnuT@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 601b2be5-d79b-4621-287c-08de5fd9c478
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXNXRldDWkN2UTFIaVE5aVRyYmxwYmh2aHJrY1hoUkdzWXlkb0lLaVBRcUVC?=
 =?utf-8?B?eGJ6QzFTSWs1SElUVUFyaUpBL0VjQnhCNk5BRVpMQlhLWm1JcmZSa29sVnpE?=
 =?utf-8?B?TVJoRWZPYkEyTWFMQU9tNmlyVWoramx6RXYrK3JkUExBU2JpKzZSWnJzS3JL?=
 =?utf-8?B?eXYvd09YUVh2bTluQnhFaFdJRjl0dmdIWXBJY290UnltaThZaGR5M0lNSXh6?=
 =?utf-8?B?MnFOR1JMZllvWC80SXJBTlN3R3RGZzlDbk1DRWpkTU5OT0pyazB3eVEyVk85?=
 =?utf-8?B?MXBocjd3UUUyeC9GaFVWbEx2eXdFOWZROElkWStDTmQybWRvc2x1UGJiRmRm?=
 =?utf-8?B?Wk9uR0tRY1ZrWllCQ0liQzZGUnpldzROMFZsdStFRnAwUDVxcFgweUdHVjZT?=
 =?utf-8?B?bUdXdFNpYkJhZVFnazhPK3JCSTI5eStIckcyNVpxWW45OVdvM3hSRzZlUWp6?=
 =?utf-8?B?OFdvU0xWcDlubEhyZ1lVcDRGVGMwTFMrTC83cXB3L2tmZmpUZnpnSzc0ZG5z?=
 =?utf-8?B?MVZQWXUwUHlrVWpseHA5MWlPckpDWUd6SlkxQVlqaWVnM2xOUkZxcDlCRnJj?=
 =?utf-8?B?eFQxc3QzbWs0d0hocmtHa2F3NzNxNTdsMGNqYUlPN0RmSkFMa2pPQTdtNVQv?=
 =?utf-8?B?MHlYK244NmorR0xmOSt1TGlWZ3ZUNXpPQ1hOWGhZdDhQQ3IxZGY4ZFl1VzNj?=
 =?utf-8?B?VHY2cnoyUndsWFd5YlN2Yyt5dWM5MEZJaUR1SHpCdllRWER2RmU2OStsbzRs?=
 =?utf-8?B?bjNoWk1MaENXNkxIL3hWSlhwTjRqcDJXOEpaSlJ3ZnUvQ2dFdWJjWWE5clVj?=
 =?utf-8?B?cEg5Qlo1c2QvbExDNmlWdU1PelQzRVVuVjArd1EyNEp1ZVVjZFdxVjFQdHp5?=
 =?utf-8?B?cXQxRno0R1EvSnUydFNpeU1Qc1lmaGYrWkxzMW9MbVBDc0htanVsL1pCWEJq?=
 =?utf-8?B?OWxCVG1GOTlxdjVBcWx6M2FYVjJVbi9DQ3Mwdm4ycFVVWGRnam04cFFOQVA1?=
 =?utf-8?B?bEo5V1I2a0xZYUJUZHFzSXgrY3N4RnpJeGFwZHpDQUZUVXRGMEtOM2JXckRP?=
 =?utf-8?B?aHNTKzNjL2VGZnNJU2MyTEZyY3dMZGtmblhaeDJTcXBJWitXRGR6K2Q1L1lv?=
 =?utf-8?B?WWxrREM4ZU5hZzJrNDVLMGpkSWVPZloxdStNbmloREE3ZWhHcEwzWEEySmZC?=
 =?utf-8?B?Vmpya1BqQmFjUXdjVkNDUHJ0bHVJVW9kUTlKZDVkR1RYV0tKN1FFaUZ0MWUz?=
 =?utf-8?B?TWxEVHIvRlR3Zy9RazJGU0lhVHBlS2toN2MyMXd4THdQZ2Y0eGpBd0NCM0c3?=
 =?utf-8?B?ZUxwWmJSZWRWdXZqOGxvM0dadndHQXAwclFjb3IrTHBRaUhWbmFoaFVyeUNP?=
 =?utf-8?B?U3JscEV5V213Y0hESUhDd3N5R080SEJMZFhieFRUWlFyakhDRENlTVpLd25F?=
 =?utf-8?B?dW9xNVBOOVJMVVhoVjVWUlExVkFudm5zOHNIUWJzWWdNbSttTDdrWFFrL245?=
 =?utf-8?B?Q1hZM0dYVUQwYmI1NEtIN3pKUk12em10ZVVIeFpvaUUwaGNhM2ZCTVJHQlRi?=
 =?utf-8?B?UzROMTVBM0hxQnpMWHVNdDJhL0V3MG10cjRLdXhpTEdLUG9BbUNRakZSVzB3?=
 =?utf-8?B?d0FZeHpBS3dxQXN3em90OGl6S2owVk90MjJIYkFwZzkveDRybTZtNXEvRXB5?=
 =?utf-8?B?N09oMjlLckJ5Q0UrYVZ0R1dRU3VWcTh6VnFibG5BL1ZhT3ZwZWs4MmYyTElM?=
 =?utf-8?B?eklaa3hNZEJoRFBrZ1V1U0UzbmdUWld2YW9keS93TFpIU05nMTloNWFKYWM0?=
 =?utf-8?B?aEVZRFZETlZrZDhKbC9STlo2U0NwbzdCVnVVcXorelZFRXlxNGgrTTFiVU1n?=
 =?utf-8?B?YWtuSEF6SXR0Z1pxYzk2NDR6cW01S2t4cCtsTHRONEhLRXp5RnBVcU4zbnVj?=
 =?utf-8?B?Rmw3VHhBdXY5Q0x0VXJCYlRSY1JER3lScUx6RFpoK2kyQU9SWUVvdHhRTnVI?=
 =?utf-8?B?cFRteVpnRlVBOG1FWGJUekIrWENYZkhHZGVtWTlmeWFhOExVNVViSVQ4QmdV?=
 =?utf-8?B?bWJoUmRVVGZuYU1rUW9KU2lBYmdDbHRTK1g0LzYxb1N3NG1MYkZOd0JXSC9w?=
 =?utf-8?Q?I2s0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEEzM25zbjRiVXVwbDA0MjYxdHhXN0ZFaDd2NFNjRW9KS1V0aHIvT0F2cFE0?=
 =?utf-8?B?WXNrOVhHTWNheWkyQXFYL3lJVVRDNkxiN01BWTQyejRlVFVEZGZ2K1lQcVph?=
 =?utf-8?B?S3c0Z1RBWklDd2dwdW96Qnh2eG50YStpaFFVZGVxVjhNOXhrL1luUHhwdVRm?=
 =?utf-8?B?Y0hkcGRDM1VtTVFBN0lCSjRGWkZ2VlVXakpwTjRMQ09FVENYODNORzYxTU1S?=
 =?utf-8?B?VjgyNlNObFZ1S2ZxM3FORk05WU1lRkp1dEVRUEwvSDIwdlBqc1p6S3ExYmZo?=
 =?utf-8?B?K3BaQ0xseERtRzFoRCtmRFB5dnlTcE5GVUtsdDRRNW0xUzVKWm9FdzVQYkFL?=
 =?utf-8?B?Ymhob1ZsMTVvU3YzWnB6UWVsbTlMMXlHK2dwNDlDZElET2JtcE5SZkdvYS8v?=
 =?utf-8?B?Tzl2RlpCM21KMFFXRzNvV2JiSnZQejI3NndPN2R3VVZVdHlBdDhreE1uak1w?=
 =?utf-8?B?QnNhRmQ0QzlrVWl0MEo4QWVCSmhqeDVrL3d4Yk9ZU2JZRmU2TDlGd1l1RmI3?=
 =?utf-8?B?aFZIS3gvekZUZ3o1K2F1Q0R6MTBLYkluaHBGOHUwVDcwTk4vQS9kKy9UUFhC?=
 =?utf-8?B?VW9nM090YmowV3Q5YjUrYzZ1cXNheG1FcytaTWJ5T1NTbHdZWDFjYzQxTTkz?=
 =?utf-8?B?M3g0Tjc0OUMwSGduQ2h3K0lnQTdWd1ZzbWJzcUs2ZGx1TkxNOFJuYzNOT0dk?=
 =?utf-8?B?UDg0Z00zdnRRcHZOcHB0L210U0lSOVVsOG5CNVdvTUpEUm12b2VKQkx4R203?=
 =?utf-8?B?Tk8rOFZFSVozSWFqRmFnWURIR0RjRXNSYk1HLzU2THJyWjg4SHNvVnNZNmEw?=
 =?utf-8?B?Z2tIbHh2OEVLd2R5eDFqZzdGbFROZDhXRyt5WVFoWDVVR1pjdS8wb2tiRzBz?=
 =?utf-8?B?anJiemJlWVpsQ09peWNGMDJmRjRzemM2dTRhRTF3Z0dXaDhpVi9qbENyMjR3?=
 =?utf-8?B?MHZaMG44YnNPTjd3R0hBeWg5cS9xWkJOazIva2p5dG5GSXlsWnN6Uk0xVlhY?=
 =?utf-8?B?VHRNc1BlRjdDbFV0T2pNeDJlS040RGEwQU5BNEVhY1VHbmU2T0FSQmFPbzE5?=
 =?utf-8?B?Z2N3YnBUSDFGSk9ieGJaZXU5d01DRHRqbWhsT1lrNy9uNUNoUDFsVW4zcHZT?=
 =?utf-8?B?L2p2Nk1obDRZQUJxNDBlWVhuV2h4Z0V6c2I0d3RUTWFZQzdGcC9MN0ZTd25N?=
 =?utf-8?B?Q2ZwT0VyN0ZRZVNwdTdHWGkxc0RWQkZwUTNpL0lEK3NYcVNqcXlnSEI2Nk9z?=
 =?utf-8?B?UUZDcTcrY0lFSVlBRkNVVWZCYjBUbGhnWEdLSGFxM2c3MTRieU5EZEpNZm5r?=
 =?utf-8?B?SGZNTWY1aFRNNTcwSW9kSGdWaDNVWXFadTJoTnlEUmJNZi9Rb01FTkhtd3Ji?=
 =?utf-8?B?VlRuQ0FGUEYra2FNTnBRdTFPclRWUWRva2lmOWl5Yy81RkJuZjVRUXZWejJa?=
 =?utf-8?B?ZnZSVEEyRjIxVFFBcjBLL0Q0OTNkV0tkSVRZazBGai91allrWVFvd3NLeGU1?=
 =?utf-8?B?cjk1NFRTSk5jZTE2b24zdjBVN3VWMW01RDNsbXJ4YzRxRWs3ZlA4cU9sTyta?=
 =?utf-8?B?QTk2VWNTb3RnWTVBOXpCUjUzbGtYTDdvdUZZbW1CTXJkaER1QXpCTWNnYzY0?=
 =?utf-8?B?TWw1Z3NnZ0ZFUkpHTS8vaUx0NVAxT09MbUwwR2dMV2psYmlHVHlOdnlIeVJs?=
 =?utf-8?B?OG8xVFFXOW14enBBTm9aT01RQkJ3WUFWQTMra0pEcnZSd1JkNnlrME1ZNUR0?=
 =?utf-8?B?czFiWW9yQU1iWDNIMXpNaUd3c2xNSEEzWHJqcVR1YW0zT0JLMElKTlNLMnNi?=
 =?utf-8?B?NDdGMngvTGVZZm9nMVVDUzZ6RmhuSWZJVWFONDk4b084RDJoTFhLK09IaGdY?=
 =?utf-8?B?UHVWZW0rRm5MMzlzc2tVZXp2cGw5bVJDYVI0YlBWMVdpYktLakp2RGZneDVu?=
 =?utf-8?B?eGhRQVc2OGMvMHU2V1NZalRucTV0QnM5YnlORHFVYmU3LzNEckk4L1g1UW5K?=
 =?utf-8?B?b1VGemdVWEp1MzBHY0ZRdTV6NEFDSXBHdmlsRTJkZmtGSndockNhMmduemNh?=
 =?utf-8?B?UnNiQnBzVDduZC9SU2t2cE9DQUlIdHhiRmt1a2xCVEpVejVXUkpjMzZiY2sw?=
 =?utf-8?B?MFVXcXpNT0gvMmJJYThsZDAwRkVJNm8reXlja2JTSnNiT3pERWxraHcyK2g5?=
 =?utf-8?B?S3BGQmVwM3lSeHoybllGSVRaamlKcmNBSDhGZmw5b0FwR2RzVVFXQ2l1OGNE?=
 =?utf-8?B?akRESUd6V1hLdnVWVWJPeW16VVRtbzBiSDRkUGxiRTVSZUhQcDVUT3ovYTZX?=
 =?utf-8?B?R2VrMmx4bGozN0poN0NQeG1ZcDFlUnlFR2NpejZoQVRvNHdNWkJ0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601b2be5-d79b-4621-287c-08de5fd9c478
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:30:04.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RgT84dTGJrgW1qg8GzPS+i4uozQCu2zou555cBpgNFSOh3hKpsodHxK2hZeozme
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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



On 1/30/26 08:21, Peng Fan wrote:
> Hi Michal,
> 
> On Thu, Jan 22, 2026 at 01:50:33PM +0100, Michal Simek wrote:
>> Add a GPIO controller driver that provides configurable delays when
>> setting GPIO output values. This is useful for hardware that requires
>> specific timing delays during power sequencing or GPIO state changes.
>>
>> The driver wraps underlying GPIO controllers and adds programmable
>> ramp-up and ramp-down delays specified in microseconds through the
>> device tree. Each GPIO can have independent delay timings.
>>
>> Device tree binding matches Linux.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> drivers/gpio/Kconfig      |   8 +++
>> drivers/gpio/Makefile     |   1 +
>> drivers/gpio/gpio-delay.c | 133 ++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 142 insertions(+)
>> create mode 100644 drivers/gpio/gpio-delay.c
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 60c5c54688e6..f69919abc05b 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -1,3 +1,11 @@
>> +config GPIO_DELAY
>> +	bool "GPIO delay driver"
>> +	depends on DM_GPIO
>> +	help
>> +	  Enable the GPIO delay driver.
>> +	  This driver allows wrapping another GPIO controller and inserting
>> +	  ramp-up/ramp-down delays on output changes, as described in the
>> +	  Linux gpio-delay binding.
> 
> Add an entry for SPL?

Why? I don't have a need for it and someone should test it if this should be 
used in SPL. That can be done on the top of this when tested.


>> #
>> # GPIO infrastructure and drivers
>> #
>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> index 910478c0c7a9..fec258f59f52 100644
>> --- a/drivers/gpio/Makefile
>> +++ b/drivers/gpio/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
>> obj-$(CONFIG_BCM6345_GPIO)	+= bcm6345_gpio.o
>> obj-$(CONFIG_CORTINA_GPIO)      += cortina_gpio.o
>> obj-$(CONFIG_FXL6408_GPIO)	+= gpio-fxl6408.o
>> +obj-$(CONFIG_GPIO_DELAY)	+= gpio-delay.o
>> obj-$(CONFIG_INTEL_GPIO)	+= intel_gpio.o
>> obj-$(CONFIG_INTEL_ICH6_GPIO)	+= intel_ich6_gpio.o
>> obj-$(CONFIG_INTEL_BROADWELL_GPIO)	+= intel_broadwell_gpio.o
>> diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
>> new file mode 100644
>> index 000000000000..0c0d05ccb493
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-delay.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.
> 
> Drop 2025?

Why? Driver was developed in 2025 but upstreaming happens in 2026.

> 
>> + *
>> + * Michal Simek <michal.simek@amd.com>
>> + */
>> +
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/devres.h>
>> +#include <asm/gpio.h>
>> +#include <linux/delay.h>
>> +
>> +struct gpio_delay_desc {
>> +	struct gpio_desc real_gpio;
>> +	u32 ramp_up_us;
>> +	u32 ramp_down_us;
>> +};
>> +
>> +struct gpio_delay_priv {
>> +	struct gpio_delay_desc *descs;
>> +};
>> +
>> +static int gpio_delay_direction_input(struct udevice *dev, unsigned int offset)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static int gpio_delay_get_value(struct udevice *dev, unsigned int offset)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
>> +				int value)
>> +{
>> +	struct gpio_delay_priv *priv = dev_get_priv(dev);
>> +	struct gpio_delay_desc *desc = &priv->descs[offset];
>> +	int ret = dm_gpio_set_value(&desc->real_gpio, value);
>> +	u32 wait;
> 
> 
> Check return value.
> 	if (ret) {
> 		dev_err(dev, "Failed to set gpio %d\n", offset);
> 	}

will add.

> 
>> +
>> +	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
>> +
>> +	if (value)
>> +		wait = desc->ramp_up_us;
>> +	else
>> +		wait = desc->ramp_down_us;
>> +
>> +	udelay(wait);
>> +
>> +	dev_dbg(dev, "waited for %d us\n", wait);
>> +
>> +	return ret;
>> +}
>> +
>> +static int gpio_delay_direction_output(struct udevice *dev, unsigned int offset,
>> +				       int value)
>> +{
>> +	return gpio_delay_set_value(dev, offset, value);
>> +}
>> +
>> +static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
>> +			    struct ofnode_phandle_args *args)
>> +{
>> +	struct gpio_delay_priv *priv = dev_get_priv(dev);
>> +
>> +	if (args->args_count < 3)
>> +		return -EINVAL;
>> +
>> +	if (args->args[0] >= 32)
>> +		return -EINVAL;
>> +
>> +	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
>> +
>> +	d->ramp_up_us = args->args[1];
>> +	d->ramp_down_us = args->args[2];
>> +
>> +	dev_dbg(dev, "pin: %d, ramp_up_us: %d, ramp_down_us: %d\n",
>> +		args->args[0], d->ramp_up_us, d->ramp_down_us);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dm_gpio_ops gpio_delay_ops = {
>> +	.direction_output = gpio_delay_direction_output,
>> +	.direction_input = gpio_delay_direction_input,
>> +	.get_value = gpio_delay_get_value,
>> +	.set_value = gpio_delay_set_value,
>> +	.xlate = gpio_delay_xlate,
>> +};
>> +
>> +static int gpio_delay_probe(struct udevice *dev)
>> +{
>> +	struct gpio_delay_priv *priv = dev_get_priv(dev);
>> +	struct gpio_delay_desc *d;
>> +	ofnode node = dev_ofnode(dev);
>> +	int i = 0, ret, ngpio;
>> +
>> +	ngpio = gpio_get_list_count(dev, "gpios");
>> +	if (ngpio < 0)
>> +		return ngpio;
>> +
>> +	dev_dbg(dev, "gpios: %d\n", ngpio);
>> +
>> +	priv->descs = devm_kmalloc_array(dev, ngpio, sizeof(*d), GFP_KERNEL);
>> +	if (!priv->descs)
>> +		return -ENOMEM;
>> +
>> +	/* Request all GPIOs described in the controller node */
>> +	for (i = 0; i < ngpio; i++) {
>> +		d = &priv->descs[i];
>> +		ret = gpio_request_by_name_nodev(node, "gpios", i,
>> +						 &d->real_gpio, GPIOD_IS_OUT);
> 
> This will configure the GPIO as output and ACTIVE high/low flag will also
> be used per my understanding.
> 
> Should the dir and value be deferred until set_value is invoked?

It is clear that it should be output because you just setting it up later.
But I don't have any issue not to pass any flag here.
Please let me know if you want me to change it to 0.

Thanks,
Michal

