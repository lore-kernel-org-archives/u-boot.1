Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E90FC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8599788005;
	Tue,  2 Jul 2024 15:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WDmIPZJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7169188096; Tue,  2 Jul 2024 15:06:02 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB3C86DBD
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k015LSOpru9YKmwI+pNEoVoe9ayLTNkXc5idhoud8wWxjeGFpRTEZgabn9InHmgBXQ+Xr2N9N5NoyGn/ND48l833hcx4vTP3V8fz5RSJxQv4Ow76x9nrQQEAtCaSIq51ZkY5rcGEJNY4KTvI+ErgCWuRd4Ft0wV6Isio0rU7LSSVxMohBim9XDZ9FgIkP5vnnDo6BvmGZFsk7gI8/tdqUCUNpMR66KDKaBqgDV0Lo4UopDl4Y9bV5NAnmhk17u2uVt5JqULTWNZw54pa1z4jHNeI+P648jy8rxHkZ6J+VDCnLEYd5oncx0abM/d55E7ZZpM0o2E6OUFywNWDtbZrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnY/sWjXQ6aKVej7dVO0I13Ey5GWZeKeBp5ut8qx6Mg=;
 b=DOQQxNUijw/tXtFgolzSlP4fIkqJLgJUKMFVk8SlYHc+GWOUrRpoRsKDby1yHCaedf5GWQi0lJQcHlL5ff6TiMH6eL7P1HDN9QcEyQt4npvZtDmUEQeI8mQxVs5s11I2PN1sWIGbLgLuGrr65/UclbDdzntgtmbU5V4aOe8ewZIiSFcfDRrQXEKZrB2gkChU56hkwt6BFPZ8NR340rLdJIWWvfbOssVH17/jfhE9FEoU16dnWfBFGWATNyuYRkwV2dVAfpHLjDGws1pgk446PUAd3UBZ3LiQsdMfuKj2OTKy/17bHKIwr/w+35C8QtIdpcRYXM78WHzbr/FxWVCAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnY/sWjXQ6aKVej7dVO0I13Ey5GWZeKeBp5ut8qx6Mg=;
 b=WDmIPZJG2ZGn3um5PEuQ0aBiFKBMj4xmE7OoFNOxeq3P7RqceC2tCO69msZxlRrKnT51k/XxCyg9xcZnnfA87zabyNEum45JI5SrZgNBifRW0AENxVAzUDMg/z5KS7uUC3pkavqLqV4FrieW00IcYf6oKKUwwTdbnuM9gKObyC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 13:05:55 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 13:05:54 +0000
Message-ID: <fc0efc26-35ff-4e43-9a73-5e63391448d3@cherry.de>
Date: Tue, 2 Jul 2024 15:05:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
 <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
 <6dc671c5-2f2e-4cd9-817b-5aa50e5a4232@weidmueller.com>
 <7687e15d-c601-4f91-b07f-a4f9d5114362@cherry.de>
 <4ae22738-3292-4c03-902e-4a7aa4b45cca@weidmueller.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <4ae22738-3292-4c03-902e-4a7aa4b45cca@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: d2905ef7-7f8d-49e0-955b-08dc9a97b4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEY1TDlSa2hBZlFJN2pWUDgrU1M3UnFReE1JUThlMXEwcU40TkVhUkNTUzJN?=
 =?utf-8?B?elJYek5KZExKNFA1dlFaTTQydVZhb2RvZFJxY3NKd0RlSEI4OXowRitQZ1NS?=
 =?utf-8?B?anBZcnAzTS9OaDVFRDJpaG5BamFjZFRFRFc3VGRCY1d6OU9XbERka3BIeTNh?=
 =?utf-8?B?R3M5dkZsTnAvNmlVMHRDdjI3NWRVV2VCekNrclgzS0J6SUFiVHFXM0E1aHp5?=
 =?utf-8?B?Rll0R2V3WU1CU1l5RjVndmwrUnVBeVRBdWVvdXJmSElIOUVPWUZaZFpXcS9v?=
 =?utf-8?B?TUNZUU1ZS1FvK1Vzd0p5dm9RcnRtU2wyWDhmWE9aQTNncHg0d1FXYVVpa2JM?=
 =?utf-8?B?VGVTa2lDZlFlMWh5R25LYzNQdndRN1lsc0E2QS9UZ2kvOE5oMFRVNTJmZ2Y0?=
 =?utf-8?B?Z2dSY1hpaW96ZldoZ0tTSHdOWFhvZWUwYXlJeFlFa2xMVEo3U3YwSk9zUjBm?=
 =?utf-8?B?K2tiTWExNXc1aHB4bncvVWhubXAwWkNpTVVieUxkNEMyVlNpcGN6ekl4L0VS?=
 =?utf-8?B?RUJDaWs3TUJXSjh0dzFRRWc3dTZBbFJEaDgzL2lObTk0QUcwR3Jpc0czaVJR?=
 =?utf-8?B?WGtnaWpQUktwRWhzYlVydklaTE03VnA4TzNvWkVrQU5ZRkZxdzNlQmFDaGpT?=
 =?utf-8?B?d2tZUTIrOFB1b1EwRDBzQjIva3hMUUovS3hHS2lFN1RaOGVJU05JSGxIUldX?=
 =?utf-8?B?OXVmdWJSRjdyVm5zOUlWaTFqa0Vja2tDajFSR0VaUzNCOFljYm5VWXFaTkN2?=
 =?utf-8?B?QUF6RW1Sb0F4dCtFaUxXNmk2N2tDZVZNajgzVk1va29xSVppYVhTYnBpUk9S?=
 =?utf-8?B?ZGtZdTlWcytQNG5UUTI3YmNQdTUzd09vM2RTMEUyaG5jWU9PZTlHKzJWRWdn?=
 =?utf-8?B?SjlrRURwU1VmRmsyUEtQa0l5ZmcwR3AvYmM1bjR5SkNOalpHbDN2cVEvNXQy?=
 =?utf-8?B?aENTZ1V3SjdDcWUyMmR3a0RVYnlJc1pmVU9pWGN6SVRCVVA2Mlc1OEFnKzVL?=
 =?utf-8?B?VlAvOVpJenhPVzVVYTUrUDd3ckV2QURYbS8vbmxUcnljNDVlb0dQSGFaVWR5?=
 =?utf-8?B?aHlCSE1pakFxVWlEOUlkM3VUZG5ZNEVad0ttNTBqWHRTVmNsWCtCRVduVUNJ?=
 =?utf-8?B?NTJUT3Y5ME15b2ZOUmkzWDVyZlhwMVozTFFWMkxxMEtjOHlqV1J4SUdjcjNB?=
 =?utf-8?B?TUxQQjBkOTFJRTFscGdjQ0g1ZG9FQVZPU1M2bWZSeEpienVZRmREYk5LdWJL?=
 =?utf-8?B?eGxrQ1FXdjVFci8vYnpkTGVpdHBFcDk1eWdjVzJoTzd1UGw4UGd2RVU2ZTBH?=
 =?utf-8?B?ckR6bzMrY0xWSnhkTFhGSWNLd0liOFBYZ0NZSURqUC8wK1FBeVR3RzhBanZO?=
 =?utf-8?B?ZkV2UUNrcXlnOVdCQkR5NnZEZHJFWkF3aTYyMnUrR2QvOWRUdDQzM0IrY0pj?=
 =?utf-8?B?L0ZYcHVUQ2RNR1NKdGw2czltVmNma1ZjOXlQNW5mMlVMenFUbnNDT29xWlU4?=
 =?utf-8?B?d0NsTkVlaWhwekRBSEUyUUZnWEZnbzhHWGVEQXhaeTJYY3Y4QUU2cWR5RUVh?=
 =?utf-8?B?RzFTakVkQ3NNNEl6dUVVME9wazZVa0pGclFVUXBaUWpIKy83dS82cDNGeGhw?=
 =?utf-8?B?VlkvRUhsZ3VmTG1tR3hmUHp3TzJmeVNmNnpSN3Q5Mld5ei9DcXZLN2JrNXFT?=
 =?utf-8?B?ZXVGUHJrL0JtQ2l1ZS9TaHppZTlraWtiUkd3cGJaNzc3M2ZmdCtDYVVkMVVq?=
 =?utf-8?B?YkJQZUx2ODkvQXJJRnk0QlV1RE1URUJGSGRJUlhQWTVPS2lmOVpFWG91NWdq?=
 =?utf-8?B?YUxEdFdieVkwUStMVTZDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpFY2duVnR5NVZseUxHamw2RkRRYm4wUVhwYTFIZ1lsWkxpSjdqallsdDRy?=
 =?utf-8?B?b1V0eXo1K0tqUXpXRkhtNU91YjF1TEl5V2FMY0RCTXhneC9pcUovTkt6SGhT?=
 =?utf-8?B?ODJaSDFjdTJwcXExUXpKOS93aVJJcVc1dTFXRkt5V2NNYWVaaFQzV3VIUUU0?=
 =?utf-8?B?ZzhqYlp2d29SL2d1N2NzNFpaZmNhVnk1cGwrS0JuYUxxV3BwYVhYYkQ3N1Uw?=
 =?utf-8?B?Z0M0VEhCMC96eDFibHJEeEJsZ1UvMHlrVEQrVE5xWGVzNlQ2Qm5iaGJ3L0hD?=
 =?utf-8?B?Slo2MUJDSEpVVnBITGRMOVJMU3JaR1YrT01MVllUVCttWFI0bm90c2N4NWRP?=
 =?utf-8?B?bFVUTlJKV2tLcEM5NVdhN1g3eTdsYjVYSGI2V3RTL3RvaGZ1UjRFdkxKWjEw?=
 =?utf-8?B?SWFjanVIVWhkQlRJRlQ4eHIyZWl0anhqN0t6d2x5UFVYaEpkTjUycm5mTU4r?=
 =?utf-8?B?YnlLeFY0OGRDbHVvL0tNOFprOTdpVURHbGFIbUgvcm1wZGpjZjRsM21OMkFS?=
 =?utf-8?B?dzBnZzVkWVdVbmJFN3dZNEM4TGRTdWsyR2pIc1o5VWdIbFU0N2tqK1FObVVv?=
 =?utf-8?B?dWFXUnZ5clJieHR0d2ZKeHA5UHlndTFlRnFSQk43ZEhFVDVQaXZmRkR2dVFE?=
 =?utf-8?B?Qk1ibUdGd3U4UWd0YXZBcEExS2d2Q0tkQlJ3T1FjSHQ4QUw0OEVlSWRuckw1?=
 =?utf-8?B?cC8wWENxM3g1aFE5am0zSUtiVG5vNHdvdVdsVE9taUF3bjNseFBvRy93czRk?=
 =?utf-8?B?MEZHSVM2Q2w0MGoxaFNRMCtja3hDQ3R5T0NwUWJ2MmJqKyt1cVlMZnJveDVh?=
 =?utf-8?B?bDI1cVUvcXVwUi9rR3U4eWlBMlFkcGJkcFc0eFJHaVNsMEdaQmhEUHJoWWRm?=
 =?utf-8?B?bEpWOWh3WElPb0ZGTlNsN3JJR3hXZFpINkxUc2xSb1oxckRSR3lJd2xUbUR6?=
 =?utf-8?B?TXRjK0NvcDkvZ3BlNkdIQ2NWcE5VWFpEenNWK1FoYWRlS0VFbGFFbXZHMmxM?=
 =?utf-8?B?Q0ZwS0E1VjgweUYwQ1E2R09PVHpaUVhuVkFRZnZuVmU4Tmw0ZkxyN0ZVNE5p?=
 =?utf-8?B?OURobUFmSlZIOVdNV2dZYVpTeUltSE9lZzJGVU1SK3JiTjJCS29LUllucHFJ?=
 =?utf-8?B?YXlRcVZSdjV3YjdMUURJWDlTTjYySjFPZ1h0eGgrRzYyYytubzdRZ1VoM1Zj?=
 =?utf-8?B?U1J0RnhXL0w0dm5CNWp3bXB3WWJzY2xVU1FycXROUnhtNVUrNnpTdFd4RWNj?=
 =?utf-8?B?OFlmZG1XVGp3TFVId1ZZU2w3aXhZZElnVUJkdTNQbDlGYU02WHFtZXlaVFhw?=
 =?utf-8?B?aVp3MlFEYXVSSHdya1prb28wSWU2YXFaZWVwRHJESHRTVmF3Z25raWllQ0Z3?=
 =?utf-8?B?L3J3Q3lBNDJtRDRkQ1lKdm1Oc3BWZlFFbVVoa25OV21rUHZuWTB1OGpjNTJk?=
 =?utf-8?B?WkhiNUEwbjhOYW9zRE1URGJvZzBsRWhnMkE2c2U4RlFFcUhoaUJjVEhoekRm?=
 =?utf-8?B?RGtrY2liRVdyK3RIdW4xQ1IyZ0ZGVkZPUEIxVCtENjc2YVJENHRKN3N5dCt1?=
 =?utf-8?B?SVMrbVZUVlpETXllTjdGbEs5OGROcTVrMjdTY2hEYmhYY1ZPVDN5Z0RHaXY5?=
 =?utf-8?B?MzhZdWFSc0kyOC9VZUNLNlZyQ2dmYXFVT1MyMFdhbkZJcTRoM01XUkxER1du?=
 =?utf-8?B?eXNkM3A4WWFZMFFycjYyQTRFaFIrNlBpK2tyeWxaa1o3K0twbHpyd1VLZ000?=
 =?utf-8?B?eGxndHZHSGMzcXdBa1FXdXpWa3JaamVlLzVFb2pYTHVDVjJya1F2NXhYcmhF?=
 =?utf-8?B?V3N2NGt6VG0zYURwTnpzakxzT2ZRZk13cFhBL0RoUWp0NENKaDM0WVFWRTkz?=
 =?utf-8?B?cFhYL010VklZcFNSb2MxVG50T1JVaUMwdjBsN1ZqU3luTjU1MHlGdERXOTRQ?=
 =?utf-8?B?TE8rZGRTUllDSVhDTERPUGZtcEt4cXhjZ21RLzU1SmxEbUNLL1BGc0laZXVK?=
 =?utf-8?B?M203OU03S25acmtnc2lwNWN1MHRxOHBMQktlYXRkSW5XZCtnSGVaS2xZOWg3?=
 =?utf-8?B?L0lHZUgwcklBeStXSHhaL0NVT29ERTdLdFd3c3dUTVJQZEpyRWROeHZDQTdi?=
 =?utf-8?B?K2ZFc0U1Ym1wd0hBRXFKN2VGL3hwVWt4TGRQQ3h2bjlaNHhUZGc5MEgrR2tn?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2905ef7-7f8d-49e0-955b-08dc9a97b4ea
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:05:54.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9FQAWWTb8lfNfPd0/GrhO0BC5I7D1eYMdyTPqgJIYThtug59WvhTzmSkHYS7LH736B7jtOeNMUqoGHyKhpQ28W3On7hxdUepYhb/4LKzH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589
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

Hi Lukas,

On 7/2/24 2:58 PM, Lukas Funke wrote:
> Hi Quentin,
> 
> On 02.07.2024 13:37, Quentin Schulz wrote:
>> Hi Lukas,
>>
>> On 7/2/24 1:01 PM, Lukas Funke wrote:
>>> Hi Quentin,
>>>
>>> On 02.07.2024 11:16, Quentin Schulz wrote:
>>>> Hi Lukas,
>>>>
>>>> On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>>
>>>>>
>>>>> This series enables U-Boot to import environment variables from the
>>>>> selectd FIT configuration. One use-case is that the overall build 
>>>>> process
>>>>> enriches the FIT configuration node with dm-verity information which
>>>>> should be injected into the kernel commandline. U-Boot will then read
>>>>> these (possibly signed) environment variables and put them into the
>>>>> actual Kernel commandline using variable replacement
>>>>> (see CONFIG_BOOTARGS_SUBST).
>>>>>
>>>>> Example:
>>>>>
>>>>> Config:
>>>>> CONFIG_BOOTARGS_SUBST=y
>>>>> CONFIG_ENV_IMPORT_FIT_CONF=y
>>>>>
>>>>> FIT:
>>>>>      configurations {
>>>>>          default = "conf-1";
>>>>>              conf-1 {
>>>>>                  kernel = "kernel-1";
>>>>>                  fdt = "fdt-1";
>>>>>                  env,dm-verity-args = "dm-mod.create=...";
>>>>>                  env,bar = "someothervalue";
>>>>>              };
>>>>>      };
>>>>>
>>>>> U-Boot cmdline:
>>>>> => env set bootargs="rootfstype=squashfs root=/dev/xyz 
>>>>> ${dm-verity-args} ro"
>>>>> => boot
>>>>>
>>>>> Kernel cmdline:
>>>>> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
>>>>>
>>>>>
>>>>
>>>> I think FIT supports storing U-Boot scripts and running those via 
>>>> `source` command (usually the file extension is .scr).
>>>>
>>>> I do not know if there's support for automatically loading this .scr 
>>>> as part of a config node though, but if there isn't I guess it'd 
>>>> make more sense to support this case than to come up with yet 
>>>> another implementation?
>>>>
>>>> What do you think?
>>>
>>> I wasn't aware of this, thanks for pointing it out!
>>>
>>> This patch was mainly inspired by the dm-vertiy use-case which 
>>> requires just env-variables and no (complex) scripts.
>>>
>>> There is currently no mechanism to source/run such scripts 
>>> automatically.
>>>
>>> How would you distinguish between scripts that should run 
>>> automatically und scripts which are sourced by a specific 
>>> board/shell-script implementation? I guess there are good reasons to 
>>> not run such scripts 
>>
>> Scripts in conf would be automatically run? Scripts not in conf needs 
>> to be executed via `source` command for example?
>>
>> Not sure what to do if you want a script linked to a conf but not run 
>> automatically though (and what would be the use-case?). I guess you 
>> could have a script automatically run (so in conf node) that sets a 
>> variable to know where to look for the other script that isn't 
>> automatically executed?
> 
> Sounds like yet another level of indirection. Not sure if this a good or 
> a bad thing, but makes things definitely more complicated.
> 

Yes, but this isn't an indirection the project has to support. We 
currently support scripts that are in the images node to source. We 
would need to support automatically running the script if it's in a conf 
node and that'd be it.

To be clear, I am not blocking this (and I don't have any veto power 
anyway :) ), just wanted to raise that something else already exists and 
could be extended to fit your usecase.

Cheers,
Quentin
