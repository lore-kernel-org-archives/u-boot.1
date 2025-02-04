Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48375C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 10:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E75801BE;
	Tue,  4 Feb 2025 11:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="e7Wj/aqb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e7Wj/aqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19E5800CF; Tue,  4 Feb 2025 11:33:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943DD800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 11:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OUhNNsPAbLziQDwovbXsUx+gYZ11kMk70rlAhG/fZHN5co6JGYcLKahQafYvZI2cN1kLWyw92WIDGnt00ozXUZpX4hdYXrNoIvQ4ezhfVr3mVI9fnsWVeU1B98givPGxDUHFY730Qg2GvCYGHkCXsNtzzb+lGaA4kyB8PfG4+mCGuf03giBmxhr6FbLSYbAX+bcYxU9a/NqqLBVe9WTySnjHrkeWmS+ErbSG6L+DPj/YHp3H5407kBEAnnw9LQf5YCQH69Ug2ncC2+WarA7OhrYkw9gJufYGCUu7RTBnPHceMcvubRBbdp0sxXSCp6/svyCREYr5Tk8y3A4h6HplZA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzFNdj4JMjX2vzYNKPCdKR+YzHYIC9zHy13ShJ6ihIQ=;
 b=nqPab1Y9iRIGxEleVs/MW6qHbjFqJWFnOoqybJYZoXTJb7Rlq4MrKUsD4FuJsMPqgV+LJ0tVqEJKqkC2hItUS5k5CYNYhU+O/vdA8ThcWT9fwDDBZSyIIj/LIBNlH2dKciJISxOCpk03JShfu0JMxxkdZ1AUwZinJQqcE/6xLEDFLMv0iKU7dWSLdf1kTKN83zXtgHeup1WvcphM/ytoQLFvXlkDHahtiyjng4vduyHevoOwuwkDEvoh5DhdOmT8MYC40h+OUd6TWApXHQk6JfID96be/Zng6Ue0pR3uEDDu7TC7nzgFAXgeNEV35YD6DQx9abMbo7ianMWXuMSHFg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzFNdj4JMjX2vzYNKPCdKR+YzHYIC9zHy13ShJ6ihIQ=;
 b=e7Wj/aqbdpOrfYrE8wbAxsCXYk7CB9cdlP4KlX4ySS6s7FobHvT24oeztZKKXnJm4pWSk42/NK7tUTcadCFty44Xd7Ximo07woy5Q9c3FsTQHMeUiVhtEBAnpzRYeXynaRe7HPDYcwQy/aOuYLMd/UTAmVFfHia+6fc3aZt9eSw=
Received: from AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 10:33:06 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:208:136:cafe::6d) by AM0PR05CA0082.outlook.office365.com
 (2603:10a6:208:136::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 10:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Tue, 4 Feb 2025 10:33:05 +0000
Received: ("Tessian outbound 57745bc349d8:v560");
 Tue, 04 Feb 2025 10:33:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 256fef0dee587aa5
X-TessianGatewayMetadata: mJG05aBb7c1qLUqWdwu7xygEgMc1hR1tC2peAjvYQIgjxxOVlmGoLmRKVqqvWaEZm7ouuU7zmUMBcIP0pm8+PbYwpEc4edrPy9N2VQtA7KrhG93glbtC+PieYgjb2zEpIOHBQVcPUIFNbKPj0w4hWo/1yGn/iyh53aOk2UP76PY=
X-CR-MTA-TID: 64aa7808
Received: from L99039e3540ad.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 3E0E76CA-F3CE-4192-884B-ED937BFE80D7.1; 
 Tue, 04 Feb 2025 10:32:58 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L99039e3540ad.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 04 Feb 2025 10:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp8Q8wN3pkNhafEh+Vs6mBZGD1oPqbDyMRUY3y437eWARdUM81FIgsY6RtTywldmr3Xjc3o5s9e7qc8N7HA0yU/Eu7btXbN/5OrfDzGrlQ7S52gj0gTpu0qiSZxiY/fZ8xZRmB6VYUBFP4gfy355IPvoGHFAXwz5aivdZct6xgSvQ0HlDC1aCdPPIkQNeE7C5iEeChtIXa/3EedwhmcZTWSlrycXyYyqxR6s7jiIhqWVkhfGS4Jkxw5o33W9VmR/eGK9VASBUyzYrpDG1Ly7eoAWYM1aBw7x63E2XR/R5k5W64Ges4i8aZ8SOjl8aXPlSJhHTxypqA5iT3nX67S9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzFNdj4JMjX2vzYNKPCdKR+YzHYIC9zHy13ShJ6ihIQ=;
 b=J0e0nT5pu3QyikxjuH1n1bi6MMC5BoWH5wHyv8yvp8IIL+ghAhwuLkQ0Fx86W0HzGH7bNVRrsH/cHCSes4BIt12h/E9RD4EmtUaTQ0YkODTEgsmPjGTocF1/AkSHEF+j4fMeDAvCDH7s34N+FLhwANKEYewEhedht6o7hQI9eyKTgrlkKusZf0yHfLuOdmWGetIBYIClgFWhrv5bXd1pWKNmihrFxLZ5u03sqF20k/KcGcqAeuaXtfSlBoRv0thUyLh1n33dmMd+dipU+6cyl38SpQ+HpCK5AgCFDrmiZ73D1HEZEXu7KfZz2/6AaqwyMD+eAEVOvT9+8K0l8u8FoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzFNdj4JMjX2vzYNKPCdKR+YzHYIC9zHy13ShJ6ihIQ=;
 b=e7Wj/aqbdpOrfYrE8wbAxsCXYk7CB9cdlP4KlX4ySS6s7FobHvT24oeztZKKXnJm4pWSk42/NK7tUTcadCFty44Xd7Ximo07woy5Q9c3FsTQHMeUiVhtEBAnpzRYeXynaRe7HPDYcwQy/aOuYLMd/UTAmVFfHia+6fc3aZt9eSw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by VI1PR08MB10298.eurprd08.prod.outlook.com (2603:10a6:800:1be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 10:32:54 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 10:32:54 +0000
Message-ID: <5053c62b-519e-4659-84f0-4aa14343450d@arm.com>
Date: Tue, 4 Feb 2025 10:32:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
 <20250123171239.GM60249@bill-the-cat>
 <e2cbe06e-c83b-4bbf-94dd-386fea7fb41f@arm.com>
 <20250131001021.GN1233568@bill-the-cat>
 <e9fee281-70aa-4a8c-a8ae-b1ed76eeefa5@arm.com>
 <20250203222218.GA1233568@bill-the-cat>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250203222218.GA1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::21) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|VI1PR08MB10298:EE_|AMS0EPF0000019B:EE_|AM7PR08MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: b434ef10-9523-44fa-a21c-08dd45074fa3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?WFMxa2Y3L2Z0RmJQd3FMdGU3eW1yMGNzdmVXT2l6a0VxWVVMSHBqQkRsTXBR?=
 =?utf-8?B?dmtsMHNmT2tZRWFJSFRPUnpkZUpXT3RFbHZidGRpck9DVWkyK3dYdUZ6UlVn?=
 =?utf-8?B?OVB6bzd0ZDJhTlpzNWFnNUluQWwwY3hoR1JPMGMwUmNhM3NaeFpzSEhOdGRD?=
 =?utf-8?B?ZnRodW9ZZW9RMEMwZ05QUEpRSXIvZllGaFVGNGpsYUJUWFkzQ2pYTVZZV0Qz?=
 =?utf-8?B?YStuenBBMGhaUEVwRmRaemhMbVZqanh6ZHV0OUVLWTBaTGc4Z25UZ2JPazZP?=
 =?utf-8?B?WWQzZTkxOFNTeWxFcWtHRFpVd0d1ZVlWTXEwYi9uMXVuQnFNL3VKU0xTQkho?=
 =?utf-8?B?N3hvMTRVZVYzNTBkNjU5VUh4eFVOTElMUE1qd1ZqNWRnT0J2cHZ0N0h4UEpQ?=
 =?utf-8?B?VUJRSFdUV1Q5YmJIWDAvdjlyUUh5QTZGZTN0QTZvL1kyYjlUSHJ4TjBEUDlC?=
 =?utf-8?B?YUpEcVBPeGtqYjlNK0N4R1F2RHMrNDMwN3QzWGwvQW1BY0ZVZHdUQjJZa0JX?=
 =?utf-8?B?N25DV0tBNzJwTTJudUlWaCthMmNOOFgyTVdxZmtXNTFnOFV4R1piQ01lTlc3?=
 =?utf-8?B?aktON0FoWUFPTlJjejFtN1pGZm5naHhoWUQwMUkxcUUreVRwNkVFbm84UFZW?=
 =?utf-8?B?Q3ZuZTVybGpSalNaWExubkxlc0FZcU9vUFZxWWkxaUhNU3ZPSkpTWHZqSE5P?=
 =?utf-8?B?QnQ0L0ltK3lSVjZScFNycDlXZDBQbVV6TGxCbE5XZ1JkbDZweWt1K1hwNDlj?=
 =?utf-8?B?VzFKZ1RZbE90RWlhQ2NRR1FHUGpNNDNiSms4R1B4dkNKMTJTc2JhUGgrU1Bu?=
 =?utf-8?B?S0JsSkpkZFNKRGNGaEVHSWp5cXA2YWxvRDExUDhVMWR1TFRJQkVORWJWWTdL?=
 =?utf-8?B?QUl6WEh4UGs1b0Ftbm9kc2tMdUpVT1JmaVhza2V6QVFXcHJSLzFvdUg0bUdG?=
 =?utf-8?B?Y2tRUXV5RFJldld4REVTSERsZWNzNUdpMFRVemsweTBaNkNQa3BPRU83ejF1?=
 =?utf-8?B?dEVycVl1MTdzTHc2TFRmOU5IMWs2a1drMnZPUzRQSm4yYUJETVVjYkFiY0lC?=
 =?utf-8?B?MlRLTUl2ZzM2L2Y1V2FkQkdqNVRJYXNPSDF5eTB5RVFCRGhVVEh5VWhSRzZ2?=
 =?utf-8?B?YXdyYWp6YkdRZUtXUVROUk1GQS9CTm1pVVZVZVRJaEl6azhWZzlha2Q4ZFdT?=
 =?utf-8?B?WUhjQ09Zb0pDdnlMNjRIRVdXa3FiaXB4dWFPTTh6M0M0RkRxb1NPdHJna1ln?=
 =?utf-8?B?RUZUQ2xqSWVRUCs3dk8zQXU0M1RJZTIvZHdrenJsVzRaZWpUS3owcEZmMlJP?=
 =?utf-8?B?QmUxMzdrSTBTVkdKSnFkVW4rTlM4U1JSUGdUZ3dHZDhzVTBvSDdhMmF5eUNn?=
 =?utf-8?B?MEYrcHUralZLenhFQXJyY3dpTFIycWhybGZtZTllUjJIcE1nTS9LRmVWYWZB?=
 =?utf-8?B?RVFWN3d5akQrTHAvNEduajRLSWo1ZVppbUpxODJVZmRJKzVyRnA1cjNiSlUw?=
 =?utf-8?B?N2NmVzNia3Zjd1dsMWMrUDZLeWFUdEVLbFM0aEI4NEoxeVUrc3JsK0gyK2dW?=
 =?utf-8?B?Zm5RL3BTcC9na2tLNW9Ebkgxdm1aWEhqaCttMklBcDJoOVhCOWRNTHNuMWJG?=
 =?utf-8?B?SGlqNHZkSXg3cGo1S3NoeUZEZS8zcXBOQ3RFbGY4QTRKdFNGcFZaQzdHR0po?=
 =?utf-8?B?S3VHZkQzZmpRNVBURjVORkk3NVZLNnlGclhuQm9ZajV6c2xHaFd1N2hmVzU1?=
 =?utf-8?B?QkZxRHlZbDJLMWZZUTdiYnBiVXJZQUVkdlJ3SlhlS2VEeHlrNkx3OSt4Nk9N?=
 =?utf-8?B?eGUvd2hHSlBxMjhaRnR3Zz09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10298
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a93b21a3-a58b-4481-0f3e-08dd450748c3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|82310400026|36860700013|1800799024|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um9yM1JwZ052QkxKVjEydm5GVnBVVWtmVWZuaDIyeXJWZTJKdUxBbDg3UURw?=
 =?utf-8?B?MXNucEw3T0M4TU5uUGJFaXYvWitKOE1idWJEbHMyUjZabFdJNWtnTk84V3BC?=
 =?utf-8?B?RTQ5RjF1Zld4K3psVEJuLytZa2VwL3NFQ3FKNmQ2NTFaVWEzeGZSWTBKZGlX?=
 =?utf-8?B?TjNWZnB0cnFlV2h6b3UrSDJiOEdwZk1HbjNramd6VU9ZQ21nbmNqVGc4Tm1w?=
 =?utf-8?B?R1lLbHJJVDQzdHB3VUhlMHJrN2hZb2JYRnkrOTdjYXB6K1RUMFlDczcyNm04?=
 =?utf-8?B?c3Rwd3RnZGtRNTR6TXorcm1aTTEvdGEvRjk3V2Z1QTJleVQ5L250M3BZZmxo?=
 =?utf-8?B?bDlmZGR6ZUpYakhuaVJrTTNRRHJiNkc4QnI0T2ZYaTM3OWdyUW14RE5Fakxu?=
 =?utf-8?B?SFczOU5KYjI3aGliUU4vdG05SENqbk5NVTVGcTR2YVN2bGpLaGovU1dTQ1J3?=
 =?utf-8?B?dzhuT0g1THNhcCtDSGVCNlZFSDJYYWtGeDVRcDdUeGRuTUhVdGRyUVMzRGlM?=
 =?utf-8?B?RXNiNG82SHZuVVF1WVhnc1ErR2F5QnlrUU9GL2VQLy9XNWN3UjhURjZmMVFp?=
 =?utf-8?B?VzlrRVp0cVo0WVZOTnBCRmJzTzdhVVd4eWZZRFhnaW8vdWtWaVFRZW9KVnJC?=
 =?utf-8?B?S2NDYUp3TzJESDdrdmdiTFpSY2NTWFM4YjJPOVdiYlVtUnBhb0lCeUR4MHB5?=
 =?utf-8?B?TWdHQXlaTk15OGpsTTZQYVh1ODhjMi9aQXUwTzNlelZPejQrSWpjVHZrRm0w?=
 =?utf-8?B?OWlqV1R5alI0WE1TcWxNTE1uUzN6c1E1Q2tQRzFjYVdsV1B6R0ZyMkZLdzdG?=
 =?utf-8?B?cnFZMEc0TmFySUFXcW1xd2ZJM3hjWGRKTWJwcDcxVmxiNi82aGVXcG5UWTFl?=
 =?utf-8?B?MXRPd1R4NE5aV0lnNTRiUjZtS3dmMVduZVBWREsvVUZ6blUrV0ZWTE9ST0pK?=
 =?utf-8?B?blU4dHFTRGpVYWZWb3l3dUZKVlF0SWk4SDdVd1lYRjI1Vk03Tm9lbStsTitW?=
 =?utf-8?B?U1VsaEVWUEQ0M3did0YxY3hhdTM3ZnZZS0xXNHUxR0pSYkRJMzM3MDBCZ3Ey?=
 =?utf-8?B?V0hWcVJLN2JiL0hNcnFGZCtqZmwyanZGTGhSeVNHaW9UNjRCc29aM1VmZmFD?=
 =?utf-8?B?ZW9qNnl5ZDFWclRFSE1QOU1sKzRhU0d3MzRQbndEYXA5R2owd3h0WStqMXVX?=
 =?utf-8?B?SUQ0Q3RhMWNtK0lSV096bVJrWWxYblN1NVRpS3BlUUo4QzIxSlRCWmlrQURj?=
 =?utf-8?B?MlFMSTVEWVF3RmdhQVluQUY4ZWxKQTRvTm5aUzRIVlVxL08vdjMrKzQ1RElq?=
 =?utf-8?B?Rnp4UGVBeENIQzVKNHl6ZjdUV21xTjBBeFFMMUhPMTk2ZzhkcjhnNE9BMmtJ?=
 =?utf-8?B?VFFERTlpTXd0Rk00QjczTWREc3ovdy9HZmJEZTJxbDdkcHBibW9HQ3ZRem5F?=
 =?utf-8?B?OXh3anNvb1A5UFZ4aldyYVhQbTNaczVqQXQ3MittMDhSLzYwZjBtVE8zNjhX?=
 =?utf-8?B?a0JDWkhyM3pyN0N6RmZZWi8veFZLN3FXaFBqbTdEVEcwUmhtVjZ4UG1Jbmcr?=
 =?utf-8?B?am1NK1EwUTdBSE1aTzkrV3ZuaGsyK1VPQnRlVjN6TjcwOGdPemFjYlp4VFhv?=
 =?utf-8?B?RVhTT3Z6ZDhWQ2Q1OCthWjg4OG1IdGtlQ1FXOG1FQ0Q3cE9mdmxoSE9VSm0x?=
 =?utf-8?B?TTRTbmxQUzFIN2VxRENvekRFRTJxRmxUWTNpYUVFQU9ha0ZHdWZxWHdDSENM?=
 =?utf-8?B?YUxaQ2w0SWpwalNMU3N5UHlPaE5iZ1ZyMkxWSU9lNnA3ckxhNitvaEkrWUd5?=
 =?utf-8?B?UUVtVVExdHhDOXFJZmpIR0VlYmMwWEw0aDlpZ3RpTlMvQnVnb0wyMUdSVDR1?=
 =?utf-8?B?NUdScncwSFhHYnlUWXhjcTNCbkprcXUvdGI1VHJvbFdGcDNKVktBWWluZWpi?=
 =?utf-8?Q?3Ct8zPt/xbZ6I+sMoW+LOI6in4NJely+?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(82310400026)(36860700013)(1800799024)(14060799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:33:05.7502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b434ef10-9523-44fa-a21c-08dd45074fa3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
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

On 03/02/2025 22:22, Tom Rini wrote:
> On Mon, Feb 03, 2025 at 12:28:25PM +0000, Harrison Mutai wrote:
>> On 31/01/2025 00:10, Tom Rini wrote:
>>> On Mon, Jan 27, 2025 at 12:42:30PM +0000, Harrison Mutai wrote:
>>>> Hi Tom,
>>>>
>>>> Thanks for the additional details, that helped!
>>>>
>>>> On 23/01/2025 17:12, Tom Rini wrote:
>>>>> On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
>>>>>> On 22/01/2025 17:21, Tom Rini wrote:
>>>>>>> On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
>>>>>>>
>>>>>>>> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
>>>>>>>> bloblist present in the incoming standard passage is utilised in-place.
>>>>>>>> There is no need to specify the size of the bloblist as the system
>>>>>>>> automatically detects it using the header information.
>>>>>>>>
>>>>>>>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>>>>>>>> ---
>>>>>>>>      common/Kconfig    | 8 +++++++-
>>>>>>>>      common/bloblist.c | 5 ++++-
>>>>>>>>      2 files changed, 11 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> This leads to failure to boot on qemu-arm-sbsa as seen in CI:
>>>>>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>>>>>>
>>>>>> Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the source
>>>>>> of the failure is. All I see in the logs is what looks like an intermittent
>>>>>> error.
>>>>>>
>>>>>> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10392&view=logs&j=ac5e904b-a30c-5e1d-9570-462b8181c990&t=863544fb-ed04-5d34-fdac-10f5bbb057bd&l=423
>>>>>>
>>>>>> Would you be able to share the results XML?
>>>>>
>>>>> The problem is that qemu doesn't start anymore, sorry for being unclear.
>>>>> Looking at
>>>>> https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-ci/conf.qemu-arm-sbsa_na?ref_type=heads
>>>>> we can see how qemu is invoked.
>>>>>
>>>>
>>>> I've successfully reproduced and resolved the error. The issue occurred
>>>> because I relaxed the condition for calling the architecture-specific hook
>>>> xferlist_from_boot_arg. Previously, this hook was only called if the
>>>> bloblist was at a fixed address and U-Boot was in the first phase. However,
>>>> since we also need the hook for BLOBLIST_PASSAGE, I've added a condition to
>>>> prevent calling the hook if BLOBLIST_ALLOC is enabled, assuming we don't
>>>> expect to receive a bloblist from the previous stage in this mode.
>>>>
>>>> However, I'm slightly unsure if this assumption is correct. Generally, when
>>>> BLOBLIST_ALLOC is enabled, is it expected that U-Boot will allocate memory
>>>> for the bloblist, ignoring the bloblist from previous stages? In the case of
>>>> BLOBLIST_FIXED, we relocate any bloblist received from the prior stage to
>>>> the fixed address. I'm surprised we don't do the same with BLOBLIST_ALLOC.
>>>
>>> The problem is that today at least yes, BLOBLIST_ALLOC is only viable
>>> for full U-Boot as we don't have a mechanism to pass our own from one
>>> stage to the next unless it's fixed.
>>>
>>
>> To summarize, BLOBLIST_ALLOC is meant to serve as a fallback buffer for
>> internal use when a prior-stage bootloader hasn't provided a bloblist at a
>> fixed address (BLOBLIST_FIXED) or a pointer to a bloblist
>> (BLOBLIST_PASSAGE). From the perspective of a prior-stage bootloader, these
>> are the only relevant options. BLOBLIST_ALLOC is also entirely irrelevant
>> when U-Boot is staged. Have a I missed anything?
> 
> With the perspective of a non-U-Boot prior stage, this is right.
> Ideally, U-Boot should be able to use BLOBLIST_ALLOC in one phase and
> pass bloblist to a later stage. But that's outside of the scope of what
> you're dealing with right now, yes?
> 

That clarifies things for me - thanks! And indeed, my interest is mainly 
in passing information from firmware (i.e., TF-A) to U-Boot.
