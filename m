Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A07C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 09:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E02805D7;
	Tue, 18 Mar 2025 10:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="voST+DA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E647D810E8; Tue, 18 Mar 2025 10:04:29 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CEC80548
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4JKSL4j25XayDJmhbk2E3aiyaBfENtqtqtYVeD7D+wnLEcwvIY+G1l5qKXYhLgxkbEAPE5/h+jqKmhGjiG/3Y+8Cpf9dNwem4SL2vohdiGO28rNLTxy7syqwZgxxVcERwmra/k3KQ9tfzx2eZ24hiS5Q8xtOsk42ekMXhaaCv4ICnm9SokmBID/RkGLpUfEktI0QM1sh5fkyZdT2PijkAoMpPck84XRRXmqtPy35QgPZ0GKswJjqlIJT9nIR9EnHUSsTxbwcJlFa3fNZ3+KU9LaLfmA3O0Knas2aQyJI7W0ch/I/aZ+9i992BXEFzh2WqbivB9FZn40bUo0i8XpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3ZxhrpR4voA8Ui4qUG1Nt7xHEu7weMDbMOuSxI+gwM=;
 b=Crx8NjvCBJL2YjZPnQ44rovsD7B7N0ClHSPkAr7BfBt2/ZV9WUdW6B2XW9tDnkWd6g+YJB9GGyQ7MR3DpucmiMO83IKPr/DGbGRAYh3W4iHBVUJj6sFLBaLwE0OGRuWhDUmi+N3ibyuqsBwzfCU2PT7VE7CYPvWZPhZrZRFwP2mF5X6R6Xmds22dIifjhVUVjUKBY571flMTvuJGUdtEncaeNxcat9i8OganPkLbNFx9LkDnrdPatETGm5pD4fNG80/uih2oejcHeHsc5D53coNr693aJ9ybsEBQhvp0JNqWXJcIsGXvoq3pqrjyGy2QgHP62CXbBOwcxCyr9h0RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ZxhrpR4voA8Ui4qUG1Nt7xHEu7weMDbMOuSxI+gwM=;
 b=voST+DA3bTEDbHIfhKQtwbwTnvPOH4N8vKvJHJlRhS1zme5X1qbq6q08OoIUX7JjPQIwxUgQDCNNbTF20lgbTbvY/PXnza6ucv2WUf9DjPfmtW6z1YQhsr5RCd9gvKnF+NPmJgse4NJk3b80Lc6lZMvkMBcvm5ARcOrjEPe1RtOZ7yYwN+sNsPBlkf1gZHr2kLUu4U1RgnaoBIevR/+Mo56/y0lbV3RG/MVpXFC1jJ2G5Dc8b5y4PD+nLWaKtxwlp6FCtFpyz8X85Yn5zJNHTKEiBnH5hZiRlEVyd/y9RzLe6n5gUCNN02M99exx+KMi0Vdud1ybirrh/cGYRdPThA==
Received: from DB7PR05CA0054.eurprd05.prod.outlook.com (2603:10a6:10:2e::31)
 by AM9PR04MB8130.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:04:23 +0000
Received: from DB1PEPF0003922D.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::b6) by DB7PR05CA0054.outlook.office365.com
 (2603:10a6:10:2e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 09:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF0003922D.mail.protection.outlook.com (10.167.8.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 09:04:23 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.49) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 18 Mar 2025 09:04:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:04:20 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:04:20 +0000
Message-ID: <cd57ac47-02b6-458e-86a7-7c837a89b550@topic.nl>
Date: Tue, 18 Mar 2025 10:04:19 +0100
User-Agent: Mozilla Thunderbird
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Language: en-US, nl
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: block devices on MTD and UBI
Organization: Topic
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0157.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::24) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PA3PR04MB11204:EE_|DB1PEPF0003922D:EE_|AM9PR04MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 365fc752-6f25-4c2e-2ca1-08dd65fbe089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Mk03NjdQZUUyU3daQTlscFBkNXhIc05BTUVZWm9abnZaZWR3bmtxNnlQdC9n?=
 =?utf-8?B?dkIvYlI5QVN5VGhYK2orU0xYNVl4N3d0clVQUzBBMXpWN0s5Rmd6VzBoZGxU?=
 =?utf-8?B?WTR6aURLQmgwYU02ZlY0VllqaFVyNFZlVExWYm1xaURyN3o0VUlmVmJueU1T?=
 =?utf-8?B?K1RGendzT3Y4ZWd3aEh5RkhibmdpRG1xL1B5eFBQY2JIMHVQN1FDUkxJcGkv?=
 =?utf-8?B?ZEpZUVo3Q3BsVTVoc1RyRGthNmJ4TE9IOGRNYk80RVpSZ2ZYU2ExMGRlSGdr?=
 =?utf-8?B?K2x2RXdkMTdBTllsNzhBWTBPcFQzT0NDTGFmNnQ3V0lUK2hpQUlUSGE0Y3JE?=
 =?utf-8?B?NzVoaDlRbjcrekVZVzFEd1VkalZFTDZad2FCZUxuajRHYU9YZllVVmFvOU9z?=
 =?utf-8?B?dXhHOFowR3JxcEtqSHlQYUlsUkZDRzN3Yi9JY2FzS0w5eHQ4RU1Jc3BrdTBG?=
 =?utf-8?B?NHc0VWFIcW5ubnJWVzF4MUU4aG1PVUdVZjVLYjlrVnBvUS9pclhQTnVFUDJH?=
 =?utf-8?B?cXlrN2tpMnBzb3F2TmhZQTNVZTNYb0NLUjNQenAzSnhoeFJRd21FYmk2ZDB4?=
 =?utf-8?B?WjJ0OEhtaVNOVDkrZWlqRFNSMlpiTURyT3lFaHA2dUVZTHh4UCs4UXY5dWFM?=
 =?utf-8?B?akswU3I5cmxGdHpTbmZxZEtqYUNWamt1MUQ4ZVBVak96NGN5bURMNTNtckRw?=
 =?utf-8?B?aEx6NC9LZldpcUxuOXByRVRBdnZuQVYyc3Zja3p1NmFRUEo2aGlSQ0dab2FF?=
 =?utf-8?B?UVJZZklMbU1KR1FjY1Q4VmRyVk1sOG5GT2UyK0k3ZTEwcS9EMjRZMGZFL2ky?=
 =?utf-8?B?dlhBd2pyeU5QMzBiTlNPRE9Id3F3bGl4YUtCR3RmNGd6RmlpclB5VVdRYkJI?=
 =?utf-8?B?YjdUbnJTRmFPQUxZRnh2ZWNFSFM1d1FIYnU3VlhrZWlzaUJxYThtaEpQcUZy?=
 =?utf-8?B?cHJPT2VjTFNJMzF4Lys0TUhxTmdtdERIdmVkT1JpRkxMcXE3WnBqcm1uTi91?=
 =?utf-8?B?ZGZacE5YaUFIQzhGQTFaaDl3Q1N3SGxjK3NsdGRKdzIzT21uZ3NDTEZpZnRI?=
 =?utf-8?B?aEJjdFl4bHRHZUlCSW9pMGRVbWxBUm5ZWFgvVHhQdlFsN01rVFBMUGVLNEJ5?=
 =?utf-8?B?aFZYUE9HYmM0V2F1aUg3Tk9ISHNEc05KanVzYmk4dUxzdjBCS3FQRHdzSmEz?=
 =?utf-8?B?M2pSTXVVRXRuaUJWaHlXZU5FeVQ0UUk2N1M1QXVhOFZMZloxZTdkbHR5aDEy?=
 =?utf-8?B?VmFBekJYU3FTUVFhTkJQTE52TEJ3RGYyemZJYjZDcTUwbzNuZjZITWpiL2F5?=
 =?utf-8?B?clBLZERXZ29panVHdkw0dnRHWUpzWGJYdGorY2w4bDlTZ2I1Nnc5NHZFM2pr?=
 =?utf-8?B?WGZRQVp5cC9sM1VjZldTTCtxamVpc0hYcEZHTlUwN0ZpZXdscDJJQ2RqK2da?=
 =?utf-8?B?RDJGang5dVBzaVBxeXc3clRYNEdReFN5cTdqNTZHVVorc3o3ZGlDOW9iWnVl?=
 =?utf-8?B?dzNSOE1QTE1jQ3BCN0ZvZWNoSVVzSEZRdWJSeG5hUG5wbGdvMEh6SllMbUNC?=
 =?utf-8?B?R2dCQXYvcG9YMCtvbDRIM2VFVUZYaWpCWTRUSjN5VDVsbEJsL3FZekZLVzNq?=
 =?utf-8?B?elVmOVJBeS9LNmhJWFB6SEZsclM2WHI3Tmh0L0hKVFgwU1lnRVFzMnRDMnlM?=
 =?utf-8?B?cE54ZU1PalE2REFJR3pDTFlIQnNKT29JRmpDSFJoL0I0R29FcGFTYWlTQU92?=
 =?utf-8?B?MlNvSWhOSnVVQjJoSkdPVXdTMlc1SnlMTWZzUHJ3WC9oeDNjVHpQcnBObWVv?=
 =?utf-8?B?c3l0aThaVFBvNmlpWDRWbnNKY1BoQUNNWmZMdm4ySDRSVVRmb2FLN0xITmcy?=
 =?utf-8?Q?nVaalivpEzugK?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204
X-CodeTwo-MessageID: be1512e4-9f1c-4a52-afef-4f3070bb29cb.20250318090422@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8603c6a-2927-4f03-1206-08dd65fbde9b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|82310400026|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzViMDd2aDZCU3o3YzFYeTA1ZDR5eHgxaXplUnpyd2FCeHNNdTFNdkhwZWta?=
 =?utf-8?B?dGdDM1RZdlZtajBiYTBNYVhML1NrYlhweVZaa1JOV3JnbmF5aWp5d3RDdmtj?=
 =?utf-8?B?bDkxYUFRVXNKTDc5d3RMbm02Zkp2NHo1MVFXenVybnpPaXZyU0lWK09JSXZk?=
 =?utf-8?B?OUwrQmxmemp0WHY2ejBBY1I5Sm0waGtQaCtnT0wrTmJRUEZFNXFlcEFJK2lt?=
 =?utf-8?B?eVc2STI5alhLTDdUZVRXQ2NDUnZYRGRUTHVVa1VMaTY4cTB0V1lZU2ZsalU5?=
 =?utf-8?B?dktjMDZMbFpkMEg5UnRxQldtc0pOTnRGOU9QS1l2bnhLMitJQzVraEc5b0Ri?=
 =?utf-8?B?K0FQcFUyZ2JQY1dyd2hwKzhZeDU2U0psS2FTUlVlbGhnWW9YOHB2Q0RiTlhN?=
 =?utf-8?B?bkwrQUkyMSt4emFITEIzdVRQWTViOVB6dzJJSm0ydEw3VEJFbkVaT2FrM1hV?=
 =?utf-8?B?Y01lRjBydGd4Rk5mTjhZT01qb3A0bVIzVlRodG9SZGVLdDZOUUdqd05MUjd0?=
 =?utf-8?B?RXVzUFJkdEp4V1lYU0V0UU1YNVRhZVNOZlRtLzgwTngrVWFRb25GSVN5R0FD?=
 =?utf-8?B?c2oyc3B2dmlnZFc5TW5hZnBuUnZ3dC9lcEgvU2JZVGljVTVBcVd2ZmZhcmlD?=
 =?utf-8?B?L0pTUWRlOUtIMUZ0RkJ1K0tObW1DREZ4dUNtQ3ZidDBEK2IxTzJxaUtsU29m?=
 =?utf-8?B?cENNWUROQ1ZqUkNrTHdsVGZ3b2RiVndzcHdkQlFxbUR1QzlmM0lxRjJpVVBL?=
 =?utf-8?B?Nkl1N3ZmNHYyR2dHQ290OW40N1NBYmJDY05IN0xzRzdlc0lKQ3lSSjdPTHNo?=
 =?utf-8?B?WHRseHV5ZWtQaUVEVS8wbE8vVVk3Q2dnTHpmcFo3NHJuZGNrVzk0SmtSb29O?=
 =?utf-8?B?VytTbHJLdW5nZ3JTK3lHTUpNRjc3aEVhMEdWZU0rY0ROT0JRUFNrR0trTmVS?=
 =?utf-8?B?U280UHNna2VkMWN5RmtpWklYVXE1bTVtTUZaR2tTWlNDdGJTdit2L2xQV1NL?=
 =?utf-8?B?S1ZKQU5LajBpRlVkcWZmOEp5QUVQd2NhOW5jK0w4Q2RwbGROdEY3cm85UXdM?=
 =?utf-8?B?SW1rUSs1c2dway9BUE1VLzF5Y291U3ZjbDlCY1Nud0tGYm9jSVVoRVk1cE1Y?=
 =?utf-8?B?aFZOM3JIN1ZWSGNUY2IzSktaZElHL3dkSHcyU0VNNDR2YUVKWnVQbXM0a3JL?=
 =?utf-8?B?ejJBcmlnWThuU2hYd1o1bXVFNkV4UnBpb2tHYTNRdFJHMCtLYTAzOHBMOFRT?=
 =?utf-8?B?Qnd4ZHliZE1HUGpsVjhTeUpwbW9SdUZIa0JmSlNQN3JiQytlV0dJOWJtczdC?=
 =?utf-8?B?bDh1ckFYKzJScFVRNXQ1SzlmSkE0aVRCZUUrNFFWb2cwdXNWRHJVL1JTUlhi?=
 =?utf-8?B?S3hVMlRuM1RNWXUrNTlZeXduYTdSNVFmWldqc0xjNENhNGtjWm1icGw2Nnlj?=
 =?utf-8?B?UmJwVjNNb2t3QmIzYjdpM3B6LzJrbUlGdm9PbG1mNnlGYndwT0hmbFdodTl0?=
 =?utf-8?B?S1IySk5mbkNFVGFJNjlLTFZycUcyNnNMTFRDazcyT1NieDZHNmNTNHN3K0kx?=
 =?utf-8?B?RUhYL0s1eWgrcU5xSmN6eXpJcWE3ek9JZ3RjVFAzQmRJNDh6bmNvaHpCemt6?=
 =?utf-8?B?UzR0WERCMlEvY21ld0ZISDNSVWJXaS9TZ1J3QTlmMmJYdEk3cmtkY3QvaXVO?=
 =?utf-8?B?Z0J0S3hVd3EzRnFjWGt0UVhVRldTK0RPODFuKy9YQnlpbmZwQWhZbFh4Q1JJ?=
 =?utf-8?B?YXdmdmVCMVhCdENac3ZibFhtT2VxemRNWjJmSm90TWFqQXRBM3BmT1Y4Sm5I?=
 =?utf-8?B?M1N3bWJrOFpDOUVKSFZkQXZYbmhpdTVNdmpYZFo5bUNBY01XSjRiRFFhVnRR?=
 =?utf-8?B?Nm5XaVIrWW5veDVEemhRSGt4UkcvNTYra05nZ0VISGhNK2creXZuSnc1RVRM?=
 =?utf-8?Q?k0QgN2ZAgCo=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(82310400026)(35042699022)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:04:23.4292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365fc752-6f25-4c2e-2ca1-08dd65fbe089
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8130
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

I think I have everything set up to access MTD (and UBI) devices as=20
"block", however, lsblk always ignores them, and refuses to list=20
anything but the mmc. I can read ubifs and boot from it though, and=20
since UBI runs on top of MTD block devices, MTD block device should be=20
working, right?

I also have UBI_BLOCK enabled, so I would expect UBI volumes to appear=20
in the "lsblk" as well.

Example U-boot session:

Zynq> mtd list
SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,=20
total 32 MiB
List of MTD devices:
* nor0
 =C2=A0 - device: flash@0
 =C2=A0 - parent: spi@e000d000
 =C2=A0 - driver: jedec_spi_nor
 =C2=A0 - path: /axi/spi@e000d000/flash@0
 =C2=A0 - type: NOR flash
 =C2=A0 - block size: 0x10000 bytes
 =C2=A0 - min I/O: 0x1 bytes
 =C2=A0 - 0x000000000000-0x000002000000 : "nor0"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x000000000000-0x=
000000100000 : "qspi-boot-bin"
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x000000100000-0x=
000002000000 : "qspi-rootfs"

Zynq> lsblk
Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devices
-----------------------------
efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : mmc 0
mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>

Zynq> ubi part qspi-rootfs
Zynq> ubi list
0: qspi-rootfs
Zynq> lsblk
Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devices
-----------------------------
efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : mmc 0
mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>


I would have expected the SPI NOR flash to appear in the "mtd_blk"=20
devices, and would expect the UBI volumes to appear in the "ubi_blk" list.
What am I missing?

What I'm aiming for here is to be able to:
- Read from squashfs in (raw) MTD partition (NOR flash is ideal for that)
- Read kernel/devicetree (fit) from UBI volume
- Read from squashfs inside UBI volume


I can read files from UBIFS (and boot into Linux using bootcmd_ubifs)=20
just fine, e.g.:
Zynq> ubifsmount ubi0:qspi-rootfs
Zynq> ls ubi 0
<DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5200=C2=A0 Fri Mar 09 12:34=
:56 2018=C2=A0 bin
<DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 160=C2=A0 Fri Mar 09 =
12:34:56 2018=C2=A0 dev
<DIR>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4984=C2=A0 Fri Mar 09 12:34=
:56 2018=C2=A0 etc
...


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



