Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736D3C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5B981D8C;
	Fri, 14 Mar 2025 15:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="g9YoWOvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DC481DDF; Fri, 14 Mar 2025 15:48:04 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::715])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C0581D42
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfATYVDM6HN4k3Tk2iHCO4r90xeOL3QqlE368PojzEJ2LYoW9AClcPFEbgJwP+uPbYqfEHUbcO/yjP3l5uOLx78IgRJB16l28bXrx4/9Jf/M41w4WcnnCdIPpwBEZvFBdijeZPT+lykcwRZ6IsygncyIditwDSjWWC5wO/kqIc1/gkQSoiqPpZkl9JJrThkRlYLXaICx7ubIoITe5Lmv5BEmEBfn1GD02Dpk9s+B5A0qZOQB2IVlqf9/mXEHlooUe68D5Z4WfSkXdLBFYF7GBLdDaJMpcKMbJwmaABdnApoEzX2NmYLsF+e/+EncbPPXG57S6t01Q+wLQns6BypRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v8mkROqDuU2vd7StPLvGJqTS0sfnWhO7FgTs9pRgJ0=;
 b=aNVsKbgyChP9/mj8AfSFUNWAlvW1xRqKXApPV3SHIaAmp3x1tt412iqhd8ysQ2/kDR/VqYwP2GbSdNsyJw0QgnV53/tB04hpIJBQOsOCLYuUfL1y7dCNrdRMreLhp/pSf4SdT0O0D5cGG4CkcGObwGcsdyW/FuMvsiTUlJVBWD2Dj86nDcYAsTFn1eFDNgdgW0KLvf8t8XZQxQx4mp020RjMW8YpOhu9zZzUZuKmf21lHbZOdqeIafE+GrTtKPnMgjfuiKwp9ECPMJnuRVCvkISAlSAL/0uQ/OiQLlN7XHuqE3MX2KIS+iI+xdThN0Fn7jhBW+Ov3Snu2Wpov376sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v8mkROqDuU2vd7StPLvGJqTS0sfnWhO7FgTs9pRgJ0=;
 b=g9YoWOvJucxEor23QYgmXuCMnphVB1RXjQO8uR7u6pvvOhyhHtTEP5kBLROnqBPZ5UJAbsi4cdc8KJui96ofyuwz/Pk2Hv9EtTTtKitdYIFUAeS9wgaQEikfdclj3xIR3E3ymq3idin4+PH8h7p9XRMOE3vvfEcDNr73wsFFV6WeOB2iBJtk69hkAT4LEBoRkE/5UbFRSxXa6RhyycAxIYheIrn9ChzA01Qn7DZagu//QhOvvwpN4XYWBJWRqSL5utToyoWErow9dTV73/WCCxCaN37D/cqeUCRZHy2eDaRLhxLK6IkcIqP0n9d4/3TBKMiVEEySpgQpCVGiGj1/Bw==
Received: from AM0PR01CA0142.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::47) by DU4PR04MB10403.eurprd04.prod.outlook.com
 (2603:10a6:10:56a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:48:01 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::2f) by AM0PR01CA0142.outlook.office365.com
 (2603:10a6:208:168::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 14:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 14:48:00 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.14) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Fri, 14 Mar 2025 14:47:59 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS1PR04MB9455.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 14:47:58 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:47:58 +0000
Message-ID: <7c7d65fc-873f-4622-9f82-cd32ed286c0e@topic.nl>
Date: Fri, 14 Mar 2025 15:47:57 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>
References: <282a304b-29e4-42aa-84de-485944377806@topic.nl>
 <SA1PR12MB8697648198657DFEE5130A1B98D02@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <SA1PR12MB8697648198657DFEE5130A1B98D02@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS1PR04MB9455:EE_|AM3PEPF0000A79C:EE_|DU4PR04MB10403:EE_
X-MS-Office365-Filtering-Correlation-Id: ad255949-3af2-423f-ebed-08dd630737df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VzJiZU51SmRWYmlTRjFSU0hkR3NVQ09aa1FGRmM1Tzd1OUp3OWdhSEFSZmNV?=
 =?utf-8?B?b29oZjVuOUFMb2hSQnlMbXlPT0gxcjgyN0lWdldNM0J5L1hxRXZ2ZEVnTW1C?=
 =?utf-8?B?RXR3cUR4UWNqeFRSQi9BK0xxS2VpeURZT2RDVFJQcEQvanRoT3dRSEN0WFRF?=
 =?utf-8?B?Y3R2WFJDSjQ2VlBLa1pxUm9tVHlYV1pGa0dVblRNQXdPdkxzdm00blJ6Nm1H?=
 =?utf-8?B?aFJKbGJYT1JQNlNYQlB6U2FjVWx5YTAycU96YTdBUjBWeW4vblJWTmVlV2RU?=
 =?utf-8?B?TFo4YWpRdzZiU0pjeTBSUmpHWGhhdThWQjB5eTllVG5VZnF1T0JGKzRoVXRu?=
 =?utf-8?B?RmdwOEF6K2R2NnlCY3loNGJFK3NxU0hCMGtqSjg0YXgrZUZCUUpYSlFSVmts?=
 =?utf-8?B?NU81TkJyNUI5Ny9zeHVYTVprVml3QjBpMCt5c2p6ckF5ZjlMUnpydDErL2t3?=
 =?utf-8?B?Y0tvU1ozVFhjSzFabWNPaExmYU9Ud1BoamVMUVZxamJvRUpERndwMG1zeWJZ?=
 =?utf-8?B?SGY1WldsU3B3THBDYlRNSDJnSjBwKzA1OE91dk5ucTduMCtabml1VUtKMkNR?=
 =?utf-8?B?c254UGhORlRiNXFDWlErNVpRWEc0SkROSzFsUGZ6c2F6b1ZiV1liVGFJNmdW?=
 =?utf-8?B?b0U5VkJZZXhYQVBVekVDeHZ4SktLaUNkWUNKSWFZUGQ5UWg5ZnArM2R2VEhB?=
 =?utf-8?B?YzE5UHVEalptSnhuQ0diUnhDRzMreDhOM0IwVzRaL2tTWndUNDE5ZHpJMmRG?=
 =?utf-8?B?WlJIUUxvMWJTU09IbEZpd25KUmtkNFpUSkViNGg0SlFJaVRwOUg2QnUxdEpB?=
 =?utf-8?B?TnR2VDMya0hybmw3b3V5K1UydDZtelhZNTdNSkhQUGlZakwrb20yam1aWjkx?=
 =?utf-8?B?UU12MXppanNEK08zNVBTRUlPUXZXSVRuV0NMV2hQZnFnOE5zMkEzTWpuMWVu?=
 =?utf-8?B?Ylp5YS8rOWdSSkcxR3QyY1lVOGo2cUZnbmJJeWlSeU9QVzd6eTFwTVh5a3NK?=
 =?utf-8?B?VDlQS3FoWmp2WGsvZ05Dd003cFpwRlpVditOejdnYXFMUzhVYmtlS2RWQ0Jo?=
 =?utf-8?B?YlU0b2l1cHNPenBwRGhnRE5GeXhBOFk2NjRoeXRxYnBISkUwb0hvNUZMSFZK?=
 =?utf-8?B?TzZmcGNJenIzbVpHbks2cjlCcjRuMldQQXRoOC95dGF0TGFndm9LU0l5WWMy?=
 =?utf-8?B?KzZIM2lLUjRsaXhDNEJlYytZUkNOMFhRY05LbXpJNXZuQU4zMDRFNUNybnNv?=
 =?utf-8?B?UjZhSkdsUFJjWUxWeERDS1RyRzZraEp3anVGV01zbXliU1JXQTJ2VXlrUzFu?=
 =?utf-8?B?Ykhpa2UrYldSMkpVUHBQcmNiY1ZzYlRuTzVFOUNyK3cvSGxVOFIyWitycjdH?=
 =?utf-8?B?djRuR1pHeEZ2aXdGbXZmRFROQVNvcExYOXJVcUxKMjU0VDF1ajFKdHJaQ0tD?=
 =?utf-8?B?SVhucWZ1eVNBTjhYVUJrOWh4UlBML2phbCtvbFJKU3JTUUJHZFdraWorSFFF?=
 =?utf-8?B?UE5OOVlXMzZURTI4VUFTR1hqUkYyQ0hCN29pSFh6LzBnbUpyOVVyT0E1OEpR?=
 =?utf-8?B?VnJtNGgxU0x5S2hxZHFjU0Zid3BTZ1o2K2o1NHh6em9CMDZYb1k1OFkzdTc1?=
 =?utf-8?B?SUg5K3IxcHNBWWl4ZjUyLzQrTTRSSlliRWhMcG1IU3BvMzgvUHFzNW4rdGZw?=
 =?utf-8?B?RHp6SkpmdktjdTJqWmF5eEFPckQ1dXlYb3dEbVpFbEt0aUhVMkRnUThaWlVV?=
 =?utf-8?B?VlFSZVFrck8rVGN3QkczcDVpNm8rUFFpekFTQ0JhdmZsS0E1R2pOeFU3TEsy?=
 =?utf-8?B?NVNmK0pscEc2bmxOZ0ZPNnd3ZkNDdm4vdUhmZWFUV29xOGNsNWppVXRqNk1Z?=
 =?utf-8?Q?G8FiJmJ0+OsHe?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9455
X-CodeTwo-MessageID: 931283ea-aca9-47f8-a187-47a3bea48875.20250314144759@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3d6d2920-ace4-47b0-07a7-08dd63073621
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|35042699022|14060799003|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0t6T01UOWY1RDVMWGtjK3VIVGw3dW5YaHkyZmNpbFhOTWp4ZU5IZDRoc2Vz?=
 =?utf-8?B?RTdlTzhRR3k3bHRZVGlONkpKcGk5aEUxU2RDQ3NQWHpzSTd0cERQUm5PdG1v?=
 =?utf-8?B?VTkyK1ZTNkxZU2llNm9meUN4NEt1N2FJTk8wSUUrUmRVakVIdTM3ODB4MTNw?=
 =?utf-8?B?dmpmTHdoelBIQWZyNlZxVWRZeGU4Q0UwRksxbkdSTEVPTFU0SlMzZkE4NWUz?=
 =?utf-8?B?NDFTdWx4NlIzdW9UNWpmWHA5WHhrei9CUVIwM2U1STVhbDNOY1hxVkVsK09w?=
 =?utf-8?B?UCtWVkYvd1Y2Y1VxNy9aK1dnSk1jdUlXUjRpTkNZZHFoMXNiVFRvM3RYZUx2?=
 =?utf-8?B?a1ZmU0tJZE12M0N1QjdHaHRlYWVyN280czhtTVN0VG0vQ2h6YUdITVM3ckZu?=
 =?utf-8?B?NndqT0dSMnI4WHc3bjMzSitrMVRXRUlPUUVXeEdURWVuc2kvc0NFMWd5ZUpr?=
 =?utf-8?B?UjR5SlNZSzFJYU5PdEJXSlZPQ1ltOW1SMWwybEFhMk1QOXlqTmV5L3U0a1hV?=
 =?utf-8?B?N1ViOFM3YUxtblpMWUZGSVRUemJSRUY1eHA4Nk5iaThkNHRMUkdrRUtIWDE2?=
 =?utf-8?B?L1Y2Y21BSW9BelBpT3BEUmpvVlVmVmNnbFV6UDcrUnkwRGZ2Z01aU0NsNXN3?=
 =?utf-8?B?MTE4YVk1RE0vaEdxYkVlbEhwYlR1UDBWaUZHcGJlZWRsUENUOFl2eVZzR200?=
 =?utf-8?B?NUR6VEdyNHl4QndOaENqcnliOGQ3NlU3ZWVLVm84eGRIdU9jQnJOdFUvVm1L?=
 =?utf-8?B?WUlFazlRUzNIbEZ2R28vQXJYZDU5dUZySXowVmNEalRWR0EwYktxSVJDVnh4?=
 =?utf-8?B?dGFrNU5MbElqT0tZYTJZeEU2cjlTN25mbjhzUUZOdm4vWEMrek9zTWJTcTJF?=
 =?utf-8?B?MmxrSU5wbjdjeWx0cmNuN3hUYlRXU0NOOXZ2MHZjekU0SVhSNWtZUE1RZnVL?=
 =?utf-8?B?cDVCTWxsTGFneUhFRktObHgvVHhOd1ZWbW8xeThoWkNTUE13RHh3WnI2VHc0?=
 =?utf-8?B?M3pDQSs3di92dXVNRFRPOXNvM3ZNNW1sY1V1cFZ3NTlBU1dKYmlMUkZPUTJF?=
 =?utf-8?B?MW5UQkVrMG54elBBSVNaQTArSDVlVlk2N21rU2w1ZHNsdkhIek13Y282bHFk?=
 =?utf-8?B?elprd1Z2UDVkWEtWdjlsSk8vdzMvWlRwU05LQm9VVzlsZ3FuaG5wQTljd01K?=
 =?utf-8?B?NXVrSk03cyt1VjFyOTNlYm1ZSzNTY3ZpTUZqbGQ0SnVhWm5OVFFDYTA2UkpY?=
 =?utf-8?B?c2RRUEZEWE1ldmpNODdoUkl3N0hRUU1lTUN4aTRZK0M1QTZ6QVR2RHhNV1Vq?=
 =?utf-8?B?eHN3bWNKeHNkdE40VCtML1VXVDg0bE5VYWhqVzVuT3JuTTVEQUZWWXNnVm9B?=
 =?utf-8?B?RTNla1h3WVFORnVzbmpEVUZGTGRZcFRpTGZYYmdIbkFoYzVrcFNlVU1ONWp5?=
 =?utf-8?B?S21MN2pLbm5Sb1JTR0NtdFVvRlBvZWVwMjRvS2poSGpPZHRzYUREMHZKTFpR?=
 =?utf-8?B?blNLMDk3KzhnMEwwb0ZvNTZCSFkzQjJESUdNVWZGR1NZd20zRG5venp5T2RY?=
 =?utf-8?B?Y1JrTjVGc05KWGNBNVlKaHZSdk4wVE9rTXh2enBHa210UVFJeDNGaVFpYkpR?=
 =?utf-8?B?bVF4dHMycW1Bc0V0UVpJVS9xOFFTRkdJNU5Ia1NpeEdJVTRvODdBTlB3MUZ5?=
 =?utf-8?B?N3ZzUXZaUFA1ZGlnY2tQcnFMUklCaTgrMzZFd3JTZkdIQXl0KzMxc1pueXBw?=
 =?utf-8?B?NzBaZE5BaWNTYXVaTEFNK2Jvb2pOaHFqNVhoT1YzN3ZaUTQ0c1preVNhSmgx?=
 =?utf-8?B?MHJORTBzaVZlbnczSDhWRUFKc01uaWwzUVQ2bmU3czArMGdNdzhvM0F3dm5C?=
 =?utf-8?B?dlMrZ05XdkFOWFpscThXdjNtNDJWNnhXT1VSb2wycjF6T3dkQWhicHF0bHJ4?=
 =?utf-8?Q?weCytJhNJZA=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(35042699022)(14060799003)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 14:48:00.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad255949-3af2-423f-ebed-08dd630737df
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10403
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

On 12-03-2025 05:05, Abbarapu, Venkatesh wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Mike,
> Can you try disabling the config SPI_STACKED_PARALLEL.
> Is read getting failed?
>
> Thanks
> Venkatesh
>
>> -----Original Message-----
>> From: Mike Looijmans <mike.looijmans@topic.nl>
>> Sent: Tuesday, March 11, 2025 3:08 PM
>> To: u-boot@lists.denx.de
>> Cc: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; Simek, Michal
>> <michal.simek@amd.com>
>> Subject: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
>>
>> After a bisect session, turned out this causes my topic-miami board to f=
ail to boot
>> from QSPI:
>>
>> Commit 9bb02f7f4533: "mtd: spi-nor: Fix the spi_nor_read() when config
>> SPI_STACKED_PARALLEL is enabled"
>>
>> I haven't determined yet what the bug is exactly. The board has a single=
 QSPI chip
>> attached to a 7-series Zynq. SPL fails to read from it since this commit=
.
>>
I spent some time digging into this driver, but only got into a 10-year=20
headache plan... The attempts at getting this specific Frankenstein=20
hardware working has been a cycle of broken driver code and repairs and=20
breaking again ever since its inception in the early zynq 7-series, in=20
both Linux and U-boot. Makes me wonder what possesses the hardware=20
designers to keep using it instead of simply slapping a octa-spi=20
controller on the newer chips. And why the cadence folks thought that=20
2x4=3D16.

For the time being I'll just revert the commit before building. If=20
AMD/Xilinx ever come up with a decent fix I'll be happy to test it=20
(though there should be plenty zynq7 boards that only have a single QSPI).


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



