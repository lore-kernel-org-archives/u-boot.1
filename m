Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB6D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 04:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C8280050;
	Mon, 15 Dec 2025 05:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kLt5WCOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF4180077; Mon, 15 Dec 2025 05:52:08 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10428003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 05:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwiqxxMWVcvU5nm5FZ/e8Xfbj2saUDpwaibKvkc+3Y6tLTp29a3+oKkgd/s7b5tgBGN+yaI4wZPt+Cg5JxeR01FmK2U1hLE9V23CJV750oAU0d+b1zujBt7PVzEcCi9bscAjwambUCfqXVIsH7HCtofcRiLObw6cOiWogk/fQmLtGK4ehCSl0h6ndADJhqGa21XdcwZhJOI3xBqmommwUjuU+dq0xobKe6kKmClB6IALd5To0V25eFS+1k8WywkEp3/+CX43pG2WH4niJLvh7HwtqL02Jv+MF/6Hhhfn76JEa3WUlq4MhU1RQnIUKmil3JY5ygJk3u6VD0ro3qTIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pH9B6HSVWX3wM7C5fkImD+9BBN1WEKYeN1sFh37Fyk=;
 b=FBs64r0MOHx68hk/xrc9FhV+5JxJ6aymhvXd2oTBTZzJM5zBT6ddVwzqGfhK3fyfUIGmiyyCtLsL3ipg7E6HA+Iq5AJ1mYLaXGzoMODZiJlailkpVRUzeosxPqDTjaKlrydAcXCS8YIuYP/JOcTmMUg1MMl9C1r70vv1FiF4ZDMBLWCLzEYAyHvX5blLA8pbLdTtlC+fi990qUD/YXPy/wS3+oEG6/wLSDv5VQpR7PlXqUfBOs9EE/Zs8IkYNOkE8MtfeGKb8H03MwScUxI289Cxtl4Q4JP4tW08lytZ/4PbyyOSkchZCVcNYyah+RFIwHTZSzchpJPgVpbMfc5DfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pH9B6HSVWX3wM7C5fkImD+9BBN1WEKYeN1sFh37Fyk=;
 b=kLt5WCOyfG6my/twyZrR4wI81hLYbYtK1enswGnlH+1bVj0Mwtz/ataWs0FCI35KYD7AkTNC6moaXAlB7xNQR9ekhWpBn0Nu31wYJcnHPCz50Ve3+m9LoEjQrfOYkvcV8XldxlCeJCgufLBHapA2tTmgjXrgai3HjUfLJl8QqWf/U1k1NMZ41cZcLVtPm0+Y14gs0xlcbhwANFJGPnfE71zC6JkKnaoMPUDuJwOVk2ltBq5Tqnyej9wC5AhZzpPMrrgDEccI+MwhY+d9nPXy1jIpdcMw9GcthsZ2SyHvUbx2eqet9JpYcvK3hKxrqkm2UoYsuzaJXEX0mupHV/njlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by IA1PR03MB8098.namprd03.prod.outlook.com (2603:10b6:208:593::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:52:02 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 04:52:02 +0000
Message-ID: <e25fa76c-892b-4e0f-8e5a-6bd36c7aa8bf@altera.com>
Date: Mon, 15 Dec 2025 12:51:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] spl: Kconfig: Add missing SPL_LOAD_BLOCK for
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <cover.1765470899.git.jan.kiszka@siemens.com>
 <53abd048d1c0ba71f09d8fddccb7dc076859a74e.1765470899.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <53abd048d1c0ba71f09d8fddccb7dc076859a74e.1765470899.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|IA1PR03MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ab69d6-d7b2-43e5-5578-08de3b95af91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmpvMkdxanNwVU5oWlE3aDY2SEZiMmdNU3dpOEg4YjB5T0U1QU9DUnMzUXVY?=
 =?utf-8?B?dG9NKzRBOEZwbFByY3Q0ZXQ0V1hIbjQzV292K0pQb2wvN0pQUzQ2OGNpUWxZ?=
 =?utf-8?B?Sit2dFFCcmlPc1hsV0U1Y0J1b2lSUnovRm5YM25FOEl5aW9KU3M1bWJKbElX?=
 =?utf-8?B?dWVUUEd1Vm9RQklUWEJyVG1EcnRZb04wUmJ5NGVYWUpvL2JZTWhPOG9naWFP?=
 =?utf-8?B?OHhtbjFQL3ZxWDAwTVRZL25uT1RiT1NaQW1IY0w0OHJsbFlzZXJncG8zZHdX?=
 =?utf-8?B?K2QvVXAvb1hpUUZiOVlLYjJ4YWxrRHBlNVNKUGR2L3gxZWJhcjA2a0tURmU2?=
 =?utf-8?B?cGVxVUI4YWd0MUo0bnZsVG1QNmJTTEVoL2xyUFlscC9ScVg3eDZ1RGs0UDVF?=
 =?utf-8?B?WURNaXdlaVgwbi96SWI5MEtVNWI1bTNyaTNrVktqSlMwWWpUWjNDZFZaMGFW?=
 =?utf-8?B?SW4wdVZTSmR1V1JYQ2R3Z2tUdUd2aFFSUGkvQjZrR21nOFNVOWZYMlhjb282?=
 =?utf-8?B?aEYzU2l3dStJUFl5bmNrQmtGU1ltc3RnV3AvWlZDbzhiNEhCc09TMTQ4T2hy?=
 =?utf-8?B?SkxaRlJtYmxINVRBZ0VrVklwd3hFSlpsYy9jTFB5U3NPSkh4TkJjbTJEb2hy?=
 =?utf-8?B?WWdIMHVYb05PQUFuUWdNNWpjZVJxVjMrYWJtV1cwbU1mM0djTVdCR01kUWRK?=
 =?utf-8?B?djNlNWYxTGp2NVJERmttZCtOd2VOdW9JTW9SUjg2aE1GQXRaeU51bUdvbm5S?=
 =?utf-8?B?S3JUVVFpaFJKVVpHZUxheCtzTExkUi83dnJlSEVLZHRKR2RyNU5HdVIrMlNF?=
 =?utf-8?B?MGVZSWVtWXBNeW5YNFFNRUdFTzhUL3NxSEV0OFBrWEJkdlRaZndyd0JYWS9p?=
 =?utf-8?B?NU93MXRRUTFHL1FrMUVUb3BldE1oVXc0blVNbm80VlFVWmpIZnBOK1ovUUZt?=
 =?utf-8?B?TGFod0UzNlNUYzhrMGJMK1kySW9KdThuamUvVXhGWkNtdVRPL2RKWU9WdkZk?=
 =?utf-8?B?MmJhdUZESjJ6TGIwa1c3U01wSG5RTXhHYTBSM1NaRHFoR1dWWnNYMEV0RVZN?=
 =?utf-8?B?eDVPaWJTcFNaMWM3OXlYRkdKcjlWRjVCVW5hRmdGWjRxLy9CTXFrTGJQYUFN?=
 =?utf-8?B?b05QbG01cEp3OEpFaSszcTRPOUpaY0kydG9PUlpWT0VwVk4zb2lqUGlyMEZx?=
 =?utf-8?B?THpsemdUWmVoZVRURHo3RmtSSmt4ZGFVNzdEckl4MUxjLzlhZE5KUWxCTW1s?=
 =?utf-8?B?Q2krY2wvaHB2SEZwbGZWVzV2azlCeVNFcGVHWG5DWXBZL0N1ZjRrSEJKMC8w?=
 =?utf-8?B?RnVGVW1lSFRUZ2hiNGZLMmhOUEw5QmZSWDFkWWRTYXlkb1pGdXRGWU10Ukt6?=
 =?utf-8?B?U2pJOEo5V0JqUWdTTm1oM016eUxseTJjT1BOY01uVzNXVGlzbFp3UDJ5ZVIv?=
 =?utf-8?B?WG5oOUV2S3RQZlF6TnhKZ210SUEwbUU0NXdjbEZxb2dWMk5BR0tpZkxhSmNr?=
 =?utf-8?B?RWtHOGo5TWFsUkxqUVBZNWRoTk1UNDRHeFUwSWhmbnVreVlUbnVoVm1xaFda?=
 =?utf-8?B?OVpIR2Y5NC9VUDBqalloamZRVEhwMEJwVFJ2eEt3aUU0bWN4bSt6L2RMWG9R?=
 =?utf-8?B?T004c3V2K2Z0Wm1yeFdNRVFUeFprNkw0TjZqUDBTTUNDNEgyY0VwK3FiUnFN?=
 =?utf-8?B?TUFnbGtoWGwveVdiQUhDTzZSa0lWek8rK3VKdFZncWJUYXF4Z3FKU3RON2pu?=
 =?utf-8?B?TVE0Y3Z1S3FGSlZRY3JaWkova0VNU1UvbTJDNUV2bURxc1VtN3Vhems1Nk5J?=
 =?utf-8?B?NE84Y0I0ek12YmFxUWNrenBLWDVmRGJ5Z21jb1FQTnVYMnBFbHpLeFU2d2Z4?=
 =?utf-8?B?ai9ZVXZYN1pkV2wzeHRaN2hHUTJwM3NxekVBU05sYTd5MGxyckY2Q0pIUDVE?=
 =?utf-8?Q?aQWLJYgg5wFBBxSA4CZRtXf4qn/pUzTg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amxyQVBmTURxS3F6V1VXOWRMWnprVVYra2xTQVZCWnAxZGxnMHR0S292Z05t?=
 =?utf-8?B?ZFcrVEl4dlh5SGlMYlJqdjA3ZUlXNTBrbjFBc1JDbG1KM0txNWJibjR4Sjg5?=
 =?utf-8?B?Mk9aR2xWMWRHUmJvdmhPY1lPWWJscUJXcUtzS0tQRGRqQUl3cE1UNWdjRUls?=
 =?utf-8?B?am9DZDh6VFp3RlB2aW5rU1lURG9GOXZUWlYwaENXdVp2UDB2MkFiQmVBMERC?=
 =?utf-8?B?U0F2UWg2dWF4emZRWHNUd1lQQURWc0hrbittUFNURmtVay9FUjJiSVVLSGdW?=
 =?utf-8?B?OU83RWRLOEpjaTJ2VDdxNVJvbHNlWEsxaTBOU3N1RjNMdk90MUxaOUFCT1VD?=
 =?utf-8?B?ZFF3TVNaSFV3SzNldGFhNXJhZHNzY3F2MHpjdEVFaEtxMTViRHQzTERGKy9y?=
 =?utf-8?B?MHBkbnBkcTkyaHFpOUwyMjdtbkg3Q1pzclFudi9FOFRjV3g4TjUxNiswYTFL?=
 =?utf-8?B?cXgzNUZlcTRLS2dMWWhxSlF2aWc3aGFsV1VoU1drVWRjZEF4eXVVcDJsejNE?=
 =?utf-8?B?enVMUDlWZE9NRENGNG5VN0w5OXE5emVZK2NGS3NhQ3RWNWlWbkZZSGtjS0FZ?=
 =?utf-8?B?RFZ6UG5EMHl6UGsvVk11b1F1dk0vMWNrWEp4Qm03Q3BmalQzekNMQ1d6eHlp?=
 =?utf-8?B?WE1iZlV0VG9CVGcveHEyZjhvK1U1QTh1ejZvWmJOaXFkY2hQL1dSK29yL3lm?=
 =?utf-8?B?M0s0cnpSYUtNSmZiMlJsMzVDUThETFJIdTRjRTEwTFdhbDdSeXlkZ04vOUtY?=
 =?utf-8?B?Q3RjRkNDaXpzS1JxN0c5anlvd09RTngzVnJLeU9XdnZRNGoxVkt1L2dKOEhy?=
 =?utf-8?B?ZHJFdi8yVm4zQmtTRHM3R1FWMjlqdTNZZFZJMXppZ1FLeHNpbWx2d2dtYlUy?=
 =?utf-8?B?eitybEx2cWl0dFVpaFNmb2FzTTMzOUpMT0MzdEJIcmJuOTdLKzBtbEZ1Qnp4?=
 =?utf-8?B?ZmY5QnBoYm8yNDhLNXM1aGxvS3BzQzZCZzZrZDJvMnliVXFHNkJQZ3pBcTZZ?=
 =?utf-8?B?c3ZsQkQ2WjFjKzFpbEEzMk1lYjhrQ3lJcE5rMnJuSnJEQzNmdWhrYm9tVlBq?=
 =?utf-8?B?cnRueHdod2lEam9Pcnpwd2VqeDJQS1BsN1RyUUFjbnRGb2xSN3BzM1BWRFpR?=
 =?utf-8?B?RHlTYncvRXNSRUNlY0xQdjMwOWtrVEx2WHovd3ZMWFFEYWd5N25HTFViTnUr?=
 =?utf-8?B?RHZWeGUvcHhPdlBBd1JkK3lJTFpQSjFlK3Rma1RHejFWWFF3SjN5cVpsdHdV?=
 =?utf-8?B?TDFic2x4YnFFTnU4NTlOYjUvZDh2TTdEYnQvN3UrVkNYcGF0eXpiek1iT3JX?=
 =?utf-8?B?bkloRHI2aXNnQWk1VnlEVzZaT05qdlIwclF4ZzdZVGdwU3N4RngxZzBMRXlR?=
 =?utf-8?B?bGk5dDRGYlh6VjIxT3JPM1ordFpJMnRVMm5VcmlXazN5UlJscnJ2bGFYVCtw?=
 =?utf-8?B?L3hPSlV3T0l5ek1OLzdvUnNzMG5IVGlqbVNMRnNDTU1IV3VLY085N1ZUcWN5?=
 =?utf-8?B?VlZsNEFCcHVGajJBeUFVeklodHlvZWZCZnJEQVpMV3R4Mk5hcnV5b1d3a2NR?=
 =?utf-8?B?QVltK1NhK3NvVlJJSmNzNVp1NVlPSEtPcHNUTEpZK29aVTF0dC8vc1Z1MUhK?=
 =?utf-8?B?RFIweFc1ZXNObjJWeHlEYTNlNUIwbk1kZFpHUHRjR2szOTIzbTFMcm51YTMx?=
 =?utf-8?B?Z1JBazFlK3RWZWJERFgvR0RRSW9sK3Ftc2xyam9jTHpycEFhVm5VcWswVVhW?=
 =?utf-8?B?U2lGc1BWWDNRRjFvNndVNTlRc0dLVVdQZjJ4MVdZQmczVys4aDlnV1JYZG1j?=
 =?utf-8?B?aHBKTlZ3bHhITkhTUi9CUGF3RmxvUTV5aVBPanJGUzY0SnNpbzdaZ2NhU21P?=
 =?utf-8?B?bklYbmpXTFNpRzBJbDF2Zkc2Z3AycUp1QmlSU0RpMzcrUDhpZVVneEppNlk4?=
 =?utf-8?B?bGhJN1MrSW1XWnpWYy9NczFpd2RUQWNwdlh3Um9sQ21xVlB0N29KbDVvRkFr?=
 =?utf-8?B?cnVkREpFR2lFYytMeGQ3TDA5T1BhdWZVWitRY2NYWmdLcTN5SEZ2QVA5UHZM?=
 =?utf-8?B?Tm9RWFprSTRYU292aXhONjQzUGd5SnVuL1UwSEMyY2FUam0zNENhQmUzMW53?=
 =?utf-8?B?QmJOSkoxYVFmM2ZIYmZYUDYrZ29NdmRVaXQ4ZDF4THZxc2dwdTBGUkRGNUVO?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ab69d6-d7b2-43e5-5578-08de3b95af91
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:52:02.0179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP/ZfvrYovQyeimGjGREhzfrDD+vUGhQmx7+GY6EtBwGnsR8JbM4Ac2zJTh+cnJMR10OdwrLNygHHixcIpvV9BThKW7S6bIcn54hbhIebRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8098
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


On 12/12/2025 12:34 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> We need to explicitly select SPL_LOAD_BLOCK when USE_PARTITION_TYPE is
> enabled, just like the other choices do.
>
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   common/spl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 3b7b6cafef8..142cdb34cd5 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -573,6 +573,7 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>
>   config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>          bool "MMC raw mode: by partition type"
> +       select SPL_LOAD_BLOCK
>          depends on DOS_PARTITION
>          help
>            Use partition type for specifying U-Boot partition on MMC/SD in
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

