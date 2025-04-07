Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885C1C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0756682D0C;
	Mon,  7 Apr 2025 15:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="H8MtVvFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F9482DB4; Mon,  7 Apr 2025 15:42:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AB082CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKe9F1L5TaDktUTjsCaHmCcRLHldPc7zcWbze3sYli0TJwGYQZzP+IGcB6T/hf6NEGHJNuisAww67tc/b8OiARgLW7ETqwaxpqpIHcsbqzbrXW/jwVwDB4z+rml3mcA59RPkVykR2HJwbazmy7DLzYcT/RCjXDVzJ2odaJR3wTjJfHjToScXWyn36yizY15DmEdgWH7LJ4x0pZlAi3wJrfmyOc1inBr0ff+2jaLU+3leSXffy2/HJH+AsD4jzNAXhcELrlS5GbdsPuYS2Ho34U8xgAeVkb9uhc97WVhUsv5ceTy6NaQU8nqv858CWTGd54ufexZVFsV6UVhqc8KE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM38woVasP0BJh411Z7uiws9XzKWJ4ZjsJkI4II6hjM=;
 b=fNgoA0gv5gbDOiOLqLCMs/NuKN648Uq9Th/B+EMSD7csNEx69zwY8gUzF67/1zyyqVPTEPryGNRlJHpUaQ2RMUmp8t5QdHFhDNXho63gLf2qnbKj9Ey7FbXfleEzMc4aTc91KlowGeX19w1/SSZOKTwlRlykM1dwfrZo4Z9OQ7ivO49nGgR7QIT9sSez5LM8BXpbRAZxLzUuUoNleTdNuac8C8hrcoAydLXz71Lg7F3KKOAEaX3raWGRTSonpTT+FBLkUGjo8VVvKszBZFJbhbQgIiCvqefeBTcK9xiC0KhKXYonC7pRbSw0zhF/c3hjgV0LHs39H6N5PxStzjAcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM38woVasP0BJh411Z7uiws9XzKWJ4ZjsJkI4II6hjM=;
 b=H8MtVvFl/a+Lf78Xm4Iu88ZKj85zg4/43FbZi/3bbvG5dZz5lt6RW53SPycgicNW57DOqVMAFnKGG6lGTgqKAZ5J9cMvOcsgM9Yt7zYih0aAJV8dPbBv1MQmbEgE/OEd/otia6Pyz/B+ZTfZmsbBCFTYn31XOuH428DtFsrbX5/np/4/jEHzTVgaKhHjBIaBShlHv6epG+FvjBIaoIlloo5/ZXSfAi12vPKFPOmQ7z6JPljgwK5WIQqMMxcHfcjb1QaXsogR8NdNHcx7dprMpgqkAxFN+Xa0sshpjZigw5QXEM2jAnFxQZah3ALdAiSuPeIKRqaNtyuJY2nsOxWGHw==
Received: from AM6P192CA0043.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::20)
 by DBBPR04MB7803.eurprd04.prod.outlook.com (2603:10a6:10:1e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 13:42:19 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:209:82:cafe::f0) by AM6P192CA0043.outlook.office365.com
 (2603:10a6:209:82::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 13:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 13:42:18 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.238)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Mon, 07 Apr 2025 13:42:18 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 13:42:14 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:42:14 +0000
Message-ID: <2b2f97fe-ebeb-43ba-9751-c7b45a88a92f@topic.nl>
Date: Mon, 7 Apr 2025 15:42:13 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
To: u-boot@lists.denx.de
CC: Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7e9dd5d7-9551-4b99-9b32-ca6f3cd315b5@emailsignatures365.codetwo.com>
 <20250325155310.456037-1-mike.looijmans@topic.nl>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20250325155310.456037-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::12) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|VI1PR04MB9931:EE_|AMS0EPF00000198:EE_|DBBPR04MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 9537c67a-9bab-4ee5-1390-08dd75da0420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?OFVCSndNLytlRzdJdDRMcmQ5MzVUR3dhSnJMMUdBRnNuZnRFMjNUT2d1ZFVh?=
 =?utf-8?B?ZEhZYUI2THZEZWJGbDVTSjhiRjVFTVU4R2piYm5LbitEL0xUWjhlYjRxVDFr?=
 =?utf-8?B?SitXMmtlM2JVWEFHS0Q1QVROMnBDYmxCNHJ6YlFhckI4cmFkZm90VlVUQld1?=
 =?utf-8?B?SzBtUVFMb0FDamJuTTZxdHlkUnJyRVl4a2JzbEduWVZqZlVGNUlScVZBYkov?=
 =?utf-8?B?OGFyRjFUMjBTaXlBYmhLRC9GY1NSV29lWml4MHJRVXU0eWtVTDVVRkFOamNI?=
 =?utf-8?B?VG12V0w4amRWakQrU0VOV3UxUjJzUjdKNTRkaW5VUksxOFdwQ2MyRjJzY0tq?=
 =?utf-8?B?RTRlVXRnaXJuY1Q3R1FOMVlKNndodUdycWY1RVdEZEd3VUltcHN6QWlTakNQ?=
 =?utf-8?B?UHJUTTJYZFhkYkpKb2oyWDErUTJjNDJKa3JtUnV6SUVzemdkekNGalBndGlP?=
 =?utf-8?B?SXJGWWhsTDE4cTZGbHRWc0Q1TTR2dXlnUmVoRUxoM0RIWFB6b0xxVjBId3h2?=
 =?utf-8?B?Z0s4am5IQldJUU9VWUpKQU51cEg4K2RDYktQQlp0cEl6WkdBWUgyUmpjaHlT?=
 =?utf-8?B?SXhuekUycEJXUEo2cnlobTRKZ3Jja0xaSkMwS05rWlh6ZWRtY0xKNDdGSVpF?=
 =?utf-8?B?TmFLcFc3S2xoNHJxb3ord05iSGdWNS8zdHptV1VsTjNsQlR4enZmOTd3REFl?=
 =?utf-8?B?dmhQRkJ2NTZ1cE1WZVBuS29FcW1RZEJuR2FnU1dHa3MvU2UxeGZFanZyaG1K?=
 =?utf-8?B?aE5SbzgxOVluOUFWNEdhVHZnemdwalBVZXcxSWNtOXg1TGpsV041QlIrZGU2?=
 =?utf-8?B?RHY5QmQ3MG5QODVGUXN0ZXNjMkNwbmM5cFo4NGw3UXh4TFhVeGR2cUNTSzNJ?=
 =?utf-8?B?ZVJ0U0Fncm02eExwclFkSGhiOHYwa0tYaVhvTllwaVBzTzNjZ1ZrOFUrenpM?=
 =?utf-8?B?ckk0bmx2emUrL0hqL0hZdlRHcHZCS3BQK1htZEFXd2JsdWR3cCswVGtmWmJp?=
 =?utf-8?B?cHh3MTFVZFFUYm9NNVdwOFhaT2RveldzV3E0MkJEMHAvekQwZG9aOXRzdHVT?=
 =?utf-8?B?ak5SUGN3UUZGQmcvZlU2TnpMZldtTlM1WlZFN1FidzF2UnBXb0M2Wm8vTUlE?=
 =?utf-8?B?WXRSQXBkZCsraitSMUNYVmptNVFWR2o3THZTbTNxTE5ObWR1S1EzNmZvVUJS?=
 =?utf-8?B?R2FMUDE5RjRkS3JvM3psOWIyR08rUS96azlsaFBXVE96ZWh4ejZxNWt5YndV?=
 =?utf-8?B?ekFyOW5FRnFHYi9Ed2g1WEhOcTk2VENmMHRFajRLQkJHbUZ4NVkxK0IwS2dy?=
 =?utf-8?B?azlyRTFkcFloNnBGUFlPczdpK2pZM1dyTWtEdVdkRGJ6SWZ4KzM3cFRQL1pX?=
 =?utf-8?B?RXl3dW9QazFhU3V1NnN2SmZJK1R6bG51L3lxRjZEdTNXU1p2ZVZscjVOZWdp?=
 =?utf-8?B?SzlpM1lTS3NWM2t5YWFlKzI5N3g4NWZmOGNDdkFnTWJHRU1FVjZtTjJNbkwr?=
 =?utf-8?B?a25KVjJxSHlBM0NMNmMxV3QvdXA2MUJGR3VON2tpQmFyNjZsVWhEQTU4Q29T?=
 =?utf-8?B?WWR4cTJ3akNsMVduSldlelFZVUpnRWpSbjdyMnlBeEFqZDcyQTFFYTVQYUQz?=
 =?utf-8?B?dGxxMDRGLzhYUHhnTWdIUnBNQzNhOWJ4RHlnYUFTUWs5TEV4TnozUFdhNHpZ?=
 =?utf-8?B?b3hXVnY1K3ZDM09neFF1Y2xLQkFjbGEzNkVjazZqN0VmM0RzVC9ROWN6VGRz?=
 =?utf-8?B?V3BLNjFtT2QxYk4yU3JSNU9PSURhdVB2S3MrZHo4UkpKZkh6VEFzQURpVFpR?=
 =?utf-8?B?aHpqSE51YTBqZlBPd3J0RUF3YVJnTGQxT0wrcW4ydjREa054UXNuNDBuczZG?=
 =?utf-8?Q?Aj+WnEikmS8zL?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931
X-CodeTwo-MessageID: c7fc7326-c12c-4eab-9b1a-6398cbeb2d7a.20250407134218@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e335df5d-8a38-4d57-afe5-08dd75da0154
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|35042699022|14060799003|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlZITHBWaXNCa1BFd2YraHJ6c0JhZ29hZDlJdG9DK0pxVEJJaVozZDdrSUVB?=
 =?utf-8?B?UXFWYnRxQXV0MllNNERXY2R4N21lVm9zR2hBTnloQXI3TEViV05kWDU3cHJR?=
 =?utf-8?B?QUp3djFIelJzbHEwVmh4ZDYvdjlpVlpQeXZaUGphaE5LSWpVd2FRN1dNK2Rr?=
 =?utf-8?B?ZXFpbk5PRVlLZUdmTFlYMTgzZlhPZEpsZnl4VlVCcXByRmlnQTdiV3E1czl2?=
 =?utf-8?B?SU02Y21oUFNBT2VzU2hmVUlmNk01enJ2MUxlV3YzR0pucFVWenExTStnOTdl?=
 =?utf-8?B?SGN5VFFVcmVMMnhkb3Q2S2RiZktFQ0ZuK3pDTkpaQ0IvOTArMjBhUFJKYzJi?=
 =?utf-8?B?eEI4SkpObk9lWmV0RUw1QmRNQ1g1Q25XWVVLcE1LVy9Fa3VFT2UyOHdKcG10?=
 =?utf-8?B?WWpsbjJpK0RpcnEvRnY4QkJzYytCSG1HNHVrMjN0RVBkSW5tbW9KS3RLOVNP?=
 =?utf-8?B?bWlobFo0WWI1Qkt1WnFESFpNOW41UmJHNmNVdE5xNkZkUTVtTEFjaDUrb0Jk?=
 =?utf-8?B?bXh6TDVLOVY0TXJ6aW12cjhwM0hVMFpLLzFEaW1VL2V3RXFyL3pGcTNkZlhu?=
 =?utf-8?B?Q01ZVStwdS9rL2NmR1ZYbU5tVW5rZzREdkV1elM4aGVURDg0VTJucThhQ09I?=
 =?utf-8?B?a0xsbzAzYWkxMEQ1cUp0cm50cnlJLzhNQ2JVbWdDckE0TVFtaDBSYUdnY0E0?=
 =?utf-8?B?cFpRUnFQZEt1QytDOUpKeUl6QWlKTytwUkVqS0pjVmFEYVdBSlA4UWFSQzZv?=
 =?utf-8?B?VnBRMnVIYmtNRW8wTlNpdFJHdStKNlgvWTBZYzN1ZDNlY0NkbmxiV2liK3pQ?=
 =?utf-8?B?ZEpWdEMzNFU1bmVRdkthd0JSU1Y1WVNyL3JLclJoTnd2SW5ONURwZUxhczhV?=
 =?utf-8?B?NkZud200VzhadkU1OFEwSnczMDRXVmdQTC9vREp1RjZyTE9HMm5xT2tKM3JY?=
 =?utf-8?B?OGpEdDdmL1V3dU45ZFJUM214VWh2bGRQRlNoR3Y2SGMvZ0ZkUUN1VjZhWTNS?=
 =?utf-8?B?ZERDQWVieDNmZUROY3MybDhyRUw2OG5neTJKNk5mNTBLZ2FJNGZtU1Exby9K?=
 =?utf-8?B?UjRVdGhoNzF2Q25UeWlWZkE5Ly8zdms0Wkg4Q3BrWUI1eXpCYVFCUnpqQmpk?=
 =?utf-8?B?ZE9odHJyTThqc3U4a0ZuWWt2Y1F4Um01K0l5Wmg4WU9VdlQxaXhOTmk1c3Jr?=
 =?utf-8?B?bXEzWm5rdXVmSWdlQVdnWmNEaTlzb3I3US9xN1FDTkE2eUxHcktBWURwVWxO?=
 =?utf-8?B?Ym5KbW55M2Z6Q3JaOHZMcWtldi9QT2NucXRMVEtDdjZKMFRiejkySTdoUGNG?=
 =?utf-8?B?Q0FQV3dnWS8wajg5UkkvZG0zOHd1RUk0WDZTUnZXekNJOEkrNFUyOEYzNWMx?=
 =?utf-8?B?dm5RSVg3bGNBRTIrRjBuU3MveFhWdVBBb2VyOGVvZFd4cCtDQ3RCTXkrcFRn?=
 =?utf-8?B?a2ZJNzhCSEh1N2NEeUxBa2VxN2JqZGk3VW45eGtjWEw3aStlaVRDRFF6OHdk?=
 =?utf-8?B?djNVZzllMmhCQVlpdjJMUEtaY2F3RG9PTVBZZ01vSnRnL2ozSHVQOVFnZEFw?=
 =?utf-8?B?TEs2UVdGZlNQL0RRd3JZR1BjVmR4SGFmVXIxNWZzVmx3aHpDRThQeXJ4bXFP?=
 =?utf-8?B?bDJhMXZXcllsZURXRXNxV0NtN2pWaVprTSsyZ25wc1pScGQvaHlxNDV4WVV3?=
 =?utf-8?B?cUI1c3A4a3lxOWN5OFFEcEVKMjU2eU9SZkhVU2JDWWdEOE1vU3d5OWxEckVZ?=
 =?utf-8?B?NVNpazhKSHhCeGhLRGIyeVR3UThSeHNSZDF4cGQyQjluY0FyOExQMGpwaEU2?=
 =?utf-8?B?aFd4eHo5M29WNklsTTZkYTF6cFBKWWllMnEzSHh0VWN1Wlp2eXVDRG1KUXN0?=
 =?utf-8?B?RDAvZk0yZWpoaCs1SkhldnNiRHJDTUN4VDRWRWJZMGxYT3pLZ1M1RFBXUjVo?=
 =?utf-8?Q?AVXN+nV17Y8=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(35042699022)(14060799003)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:42:18.8853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9537c67a-9bab-4ee5-1390-08dd75da0420
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7803
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

ping?

Maybe I should have added to the description that the Linux kernel=20
allows MTD partitions to specify a size "0" in the device-tree to mean=20
"the remainder". This patch makes u-boot compatible with the kernel's=20
MTD partitions. U-boot MTDPARTS also supported this, but it's missing in=20
the device-tree parser.

M.

On 25-03-2025 16:52, Mike Looijmans wrote:
> Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
> partition to indicate "the remainder of the flash". Make this work with
> device-tree "fixed-partitions" as well.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>
>   drivers/mtd/mtdpart.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 88094b81e7a..5284890bd88 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
>   			continue;
>  =20
>   		offset =3D ofnode_get_addr_size_index_notrans(child, 0, &size);
> -		if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
> -			debug("Missing partition offset/size on \"%s\" partition\n",
> +		if (offset =3D=3D FDT_ADDR_T_NONE) {
> +			debug("Missing partition offset on \"%s\" partition\n",
>   			      master->name);
>   			continue;
>   		}
> +		if (size =3D=3D MTDPART_SIZ_FULL)
> +			size =3D master->size - offset;
>  =20
>   		part.name =3D ofnode_read_string(child, "label");
>   		if (!part.name)


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



