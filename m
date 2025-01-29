Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B8C02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511928091B;
	Wed, 29 Jan 2025 16:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UtroLhog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 219258091B; Wed, 29 Jan 2025 16:06:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C87F8091A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDNCZhDA6xDmgzNCXA8Vpiih7YRaRr2VLe1x2wMHio4ikHs/BVFoMz+wAONpfJjxaKnAbNJDKL5gVZ8rnLkSE5S8Trfxxa4dYGgkomm8WDIcO9yKO3Q7Bo77Z1z077/o1jVyyRyy5uUlcs095I7KadwFYHrgBotFj79Q2kEZadXT6C9D/U85gFRwIf8Ruk6puMez0yw0UlmMJwC7Nc6bGP8BRlYpmIndwd5jGZpicBBAd0XpxjR5SIZIrHphQkHntIL//3JOolJVxOrcU8kERfdnUkvj0S45Dqm7nlyrohrCzSh1UceFCCdeP2l1SiVHtWOJYfhYZxX+9N0zz1N0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGkJ8KSMIpPuyD+EJW5NyFpnvCJnVess2FGDyLLBblw=;
 b=WwjDu8O6S2ZqeYaIR22Wv0eGzrCIrrtIQ+7u+gqX4+d5VC0VvXSm8MKx7HNN2Kk4qMbJtALtH0FHslTn952SKDiAfUOA4rNO0f27xmWG+8UzrBoG9KBCzQcdPFzhNhe+IOIeVt2kiHX5W92zuCmZ+XjRMcD3ATn8tThaW907xa9v3FfNqFbyzxAiyEiZq7QvqhJLbHH1b1KxfHAIPc3ELA6o8McDu5vp5SSZ84iZGFW7zZPY9ysnMVYJDYG63S6uiuJKf9vLLxG49tlMSZA1yknqzFOUCcv+gXz4Bdb7c+eqN8q0V4K89knsKgM0M9CS23DMT7VPrMTzzoNHTHSY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGkJ8KSMIpPuyD+EJW5NyFpnvCJnVess2FGDyLLBblw=;
 b=UtroLhogxPhotrzOmm4g7qvMjh3jrcXcHm6Ntz5rFBuXvUqjfaSGUopNtnOD+wQ03miJSvXq6EJLdxnVgGyCZ0X7bMMQc1tE2N6eMAi4SdEu93It/zgcAGsR32nGtyGYzzU9GL5bQFQ1+Lsnebo9Z8bgCS1yDY0J3dY0QFTL2N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8905.eurprd04.prod.outlook.com (2603:10a6:20b:408::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 15:06:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:06:44 +0000
Message-ID: <c955a4b5-aa37-4ec2-9dd9-650b0f6df150@cherry.de>
Date: Wed, 29 Jan 2025 16:06:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: renesas: Deduplicate R-Car Gen3 and Gen4 SPL
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-8-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250118111621.362188-8-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0064.eurprd03.prod.outlook.com
 (2603:10a6:803:50::35) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: 4613a3c6-f013-4225-bfbb-08dd40768b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXFjVzV4K3pGS2U2NjB1alpVdkZ0dmhOKzNqLzlpR2JrUUpnSWNsblJ4M0RY?=
 =?utf-8?B?VC9sQUhWZDRIRnNiM3FmWXdiV0FGWTJqZENQYkMrblFQNnRDMTFQQ09DQTRD?=
 =?utf-8?B?QzVOTUdPclB5Z3dPVE96YTRoUC9LVlp4eTFyM2NaamNlRU5TeDVCKzIrK24r?=
 =?utf-8?B?REhDWnpmcjdmOWZBZ0tiY1g4VS9lN1F4VnZsVWYvT2RTU2dOOGNHckJCWWxD?=
 =?utf-8?B?N3JnNitCbkpyQ21XZ2ZGbStnRGRQMW5PRWxidDNaMytnYTV2cnNmQzk5Y2Nr?=
 =?utf-8?B?SFRHSXFTSFJaM0V2MXlRNThiem9mQXZlcWE0VHhPRk1oRXlQTUFxOE9tRlFV?=
 =?utf-8?B?dEdoMGFDbWpmaCt3M1B4cHFsakdhem5pVXY4aXhJcllHaGg1U080bFIxK0hV?=
 =?utf-8?B?T0FheTNkVDZqL0JvWHc5M2RMekdWdnhMQnZiZFhyUlczSGpmRk82QlkweWlm?=
 =?utf-8?B?a0g0Y1hsQjBDVzc1VlFQUHZiRGFRY0phSWVGellidXdURnEwSFpyYktyTWZP?=
 =?utf-8?B?S3JEL01jakl3NkgxNFFLNUYvTzRPR1VnOHRUNUxiQnEzc3h5dVR0R2tMMngy?=
 =?utf-8?B?N1FOV3NHQnJTRGc3TWxYaEdaall1M1c5aEphY0J6VjVPVjQ2THRTS2ZCWUZF?=
 =?utf-8?B?d2FaQ1JvalRZcmMxTTQ2VGlVYlFHd3RSZ3hpcCtkYXREc0FUTUJUZ0FLeXg1?=
 =?utf-8?B?ekk0Zlcrc2xuUk9acW5BNTNIYlpEVDFkNDJrRU10MTBiaUFWc3FEcVl6aWw0?=
 =?utf-8?B?M211aFlQT0tCRTA0VDFiMDJlL1dPaDkrWFdlUVdSNzdPZkFCQVhlOHRDY3pm?=
 =?utf-8?B?VHYzN1ZWY3Y4RXJiYVl1eS80d2h4bVpsa2w1aWMzSDdEcTZyS0NqNHNQVjRh?=
 =?utf-8?B?ODd6QWxwM3dqeUhDaWNkdnR6RG1jZGJuUkdnWk1aWWdDYk91ZC9BbTFsWmpw?=
 =?utf-8?B?KzFXa1ZkSGp1em1PRjBSTWE3ZDBoZlZoMm9KdG5KeTZQU2ZiZk9WdmVtRUo1?=
 =?utf-8?B?akxEaTJITW9KSmQxOFFMbzZaOGZYNlNPays1MkpHUmJnV1NZRVk1ZDBxY0NM?=
 =?utf-8?B?NFppN1BYS2x5TzZjeXgxLzRNaGgwSXMzellXc2VQK2pjS0Z6bVBZTmdPLzFG?=
 =?utf-8?B?aUI1d3VBMmhVQmU5bWFZeWc3akpkRU8xMkFIdUxqVTRoejFPV3c2RUlJZXRT?=
 =?utf-8?B?R291R2dkTGRGS2IzVE8rM2dkcEdLVE1hRHlmK0IzZmhBeWhVT3NscFhhWFha?=
 =?utf-8?B?NjJJZzMwV2JKMEFTeEdoQThzWkNFOTdETC9qWi9QaGlyWEtwT0ZsekJSdVJS?=
 =?utf-8?B?Z3hWd2NROG5IbmhieWgrdmhocFBWUkRxMmpWM1pkdjJ6RXBsc2JoWGhJbGNL?=
 =?utf-8?B?dmczRkZUMUVHaGdxQmprLzhlOVg3Sk9zU2VsV3Y5Y3cvK0RzMUEweVA5MVAw?=
 =?utf-8?B?QjdyMlN1NzFPVnhLMXhiRUNXcW1TYnBldmVhRTU3ZGE3bGFpeVpCUGhmSVR3?=
 =?utf-8?B?MVU4ZVRwVDNlT3JkZVREa0FzTHNseEVFaGM3RzVBQlZSWjFLbzQzM25wZU5O?=
 =?utf-8?B?bzVpamthM3NjZE5mbHBEZ1lma2NlMThNVnVxYjZLZ0RlZkRCT0RGeXVhU2Mr?=
 =?utf-8?B?aFpxM0xVb1lpWWtiSEk2S2d3TGVlWW9MUisyUDZaSXE2S3Jnck1xaFlpc245?=
 =?utf-8?B?UnovYnBUZHZadjFEN2s4M04wL0tUeHVXU2ZwWVJMM1Q2ZGR2NEpjVWZna2Q5?=
 =?utf-8?B?TXduejdwVXMxeGFaWjhNeitJQldhUDhNOTY2VVZXU0FDNWpxRGN0c1FOWk5u?=
 =?utf-8?B?bVhGRzVmcUdVMngyWmFUZ3AxaG9JamdPN1V0VVJtZ0Z4cE5PQXNQam1zYU1H?=
 =?utf-8?Q?Z18JrgWauWXvR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktIcnphOW5sK3dLVVlnRVNMSGQxQ1Vxa3FkUWVzdTFROU83a1U3RU9JV0tM?=
 =?utf-8?B?RDlnMENTUlFPOVN3SWI1MGRoM2dJbDBja1FrTXZWMHd4NEQzSXFZZkhhNFdD?=
 =?utf-8?B?anRvNjlaVTNFVGZub2RnUk1lbkxvQ1lpTWVRaUxDZmJKYTJlMld0bkFCeHlC?=
 =?utf-8?B?UlJlVDRtN2V4Zys1ZmF1bHExUG4rZ2lvcDBJMGxMWGN6ckp2NFF3SFNWKzhh?=
 =?utf-8?B?TGtqNWJHYlpUcXl4LzYxNndpUW01aU9lSWpJUzZ3SnJjU1Mwa1lSWHlad2oy?=
 =?utf-8?B?b1o5alFiYWM0dnJiVDNja0JIb1paWmtnWmxSd0NLRlNLSW9QK1NZL3FzNXlL?=
 =?utf-8?B?ZGt6K1MveTRMRVh0S0Z3a0xpcXZHbC9waEd6YWFkRGtDMGlkVVZ3NjNEN1Z6?=
 =?utf-8?B?OEU2SlVkOFF5TWVhZ3dacVh4ZjRKTkF0MWVqOFU2ZEZzcWpGL0p2bEFnM1RT?=
 =?utf-8?B?U2w0V1Uya3BhMklOMFZEVEgrSlMxZW8rK3Jvcmc4R1dBSTdnK1l3L1dXbDU3?=
 =?utf-8?B?UFQwVnliWEFvZzBvLzRadytaZ3dtYVh1anhzOTM2L0hmbUU0SGt4R1l5TGs2?=
 =?utf-8?B?czQrdVNldHdNVUpaVi9BU2hBSTFKS29NRzBqQXFaR0JsQUQxdEJkUDBGWFcy?=
 =?utf-8?B?dHpqUUYxWHlwaTVraWZ5QXBYVTdRN3lhWHVvWXVMMGJJeFhHakk2R3Q2Lyt4?=
 =?utf-8?B?Z3VibHBNQnNKOHVIWjRWVFAyVUJmeWN4S096NitxN1VNRjY3NGlHVkhjeTU3?=
 =?utf-8?B?S3MvSnFYYncwVTJQbHdvRjRmYWI3Rk5xdzQwdEdMNm9iWDRmck5HVDhLTGpT?=
 =?utf-8?B?TzJIMTB1S0dtVTVSQnRhNEovUDZYaUc0V3JSc0Jja2pLK092N2JmbklkUVFo?=
 =?utf-8?B?M1pKQmZsNjd4QTU1UHZmNCt6QUhRVDhiejhLVEdxMU15SXBBWGF1N3g1LzRq?=
 =?utf-8?B?VVJWTVhiMCtiSWd1ZU9mTVp1am5yb25RbW04ZEZiSXFTMFJuK24xZkVYRmNu?=
 =?utf-8?B?L3BSdUJlMFF5QnJqbE9oK05BaCt3ay9uOVIyTkFKRktuWnAxamNBTU1MN3VE?=
 =?utf-8?B?YlRPdGZvUXRVbFo2TkZRU0V1clkwR3lPR2RFd1owalR3RWJlK29DWmVLWnpz?=
 =?utf-8?B?MmEvNDBoZGh4S0loL3JIQjR1WTNEMWw1N0V0REdTb2FiSGZPRCt0bVR4R3Rn?=
 =?utf-8?B?TmJkQnc2eEF0UVExOThIcDQxVGZvdnZydHJ1TTRPLzVLdlNjdGUweGgrbDRI?=
 =?utf-8?B?YVlDb2hOcm5UNncybmpMYlFjcDd4N3JVeEhBYWo1SW9VeHcvWlNWbkdlMEZM?=
 =?utf-8?B?a0J1Nk8wOGptWERVZlp2ZGMvZWdLNjNTTnNxb1g0SUxGR0grSjVRT28ydWxX?=
 =?utf-8?B?WWpaRUNGckcwMUFRYVhVemE2YU1HVzZZNkFLam5pTVE0MHExcSthWkloZHpw?=
 =?utf-8?B?SFhFbEpnend5WXMrM1pCMjNoZGhhUjEyenl0RHo3NDRlT0tZUm1xSWFIS2xI?=
 =?utf-8?B?dzR6THB1bjJaaVFKRmlxZGFlRkllYjI0dlJTR2FOK2ErTGd3aXN5dmxLcUUv?=
 =?utf-8?B?dXBycy9QYVJZY0ZDdHNvV293YTJEcHlZTEcyTzFXdWFjNE1vekxjNVVJZnlo?=
 =?utf-8?B?NzdIM0ZScVZQMUFlcXc0dW5YZ0sxZFEycDFvOUFDM3lKWm1iNGk0Q2J6ZkFu?=
 =?utf-8?B?YUxId2oxR0pXN2prcTF4aEh2bUtMWHJEK1lNR1ZsUWtPSzNVUDA4QStTS3hO?=
 =?utf-8?B?NDA1N2tTRTlGNy85NXJsVFUxSTY5Q051bWF3YWdnY0NQb3cxckc4TW9KUk5N?=
 =?utf-8?B?NlVZTGw1VkhySlJCZlE0MC9obSs2czlyTitXVmpqOFA2eCtHc0lwZ1gzOGlF?=
 =?utf-8?B?RjFUQVZzRHdMeUhwaFRrQjJld2Q2NEsyTHhKUVpzK3JST0cyekxUZUNNUXVk?=
 =?utf-8?B?WDdoNVZQZEIxbWl0OXNSZWJDaHVOVDlpeXI4dGtnaXkwTGlKSzZGRlVWYk1i?=
 =?utf-8?B?aEl2MC9jSDRTNkpzRmdxRGhxNjJpVjB3Mkt3OWVuN2hLRDA2aGRuZnNnUm12?=
 =?utf-8?B?M29UNDA1VWt6L0NsOVpZVlZCUE9ubWtOOFN0L1kydXdJa2ptOXVZOVptZklU?=
 =?utf-8?B?eVppU1pWdXBrbUNETUdsUnl3b0d6WFp5S1QwOG0za3EzYTdUU2ZaQkxTSCtR?=
 =?utf-8?Q?81TODaSFLJ8QKJ4X3YLNcrs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4613a3c6-f013-4225-bfbb-08dd40768b56
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:06:44.7638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQTIoE4dTAdkVfcSUarN5DdX+4q5mtlEBL+5+F0vVtMnktqXxe42bMzwhbCiNTyKnjP/KRTa5lNgsTAIoh6jg3swpPVU7geFOPdvrIGPpKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8905
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

Hi Marek,

On 1/18/25 12:15 PM, Marek Vasut wrote:
> Move R-Car Gen3 and Gen4 jump_to_image_no_args() into dedicated
> rcar64-spl.c file. The implementation of jump_to_image_no_args()
> is identical. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
