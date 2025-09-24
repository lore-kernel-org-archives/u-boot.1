Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C07BCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5A583678;
	Wed, 24 Sep 2025 17:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ds6dvY1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1590C80819; Wed, 24 Sep 2025 17:18:56 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304FB8319C
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 17:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiNC3dPBhbgibs5qRwGt4BC6eo+qTe/pzDs9bLajzIGtcc9N7cbBBfsFbD5Sea7emd/UOKLo7+oChfPO/4WIsggzmGMrwXsz6DeKxuo3OQyaElNv1zjK0htZOwW2tCPVGYoYWyTRExda9E6bZAfpDpRs9LxoiY801JVx1TQUf0LB84ItitrquPm5JBHnZnmADjtRPEYjs135Ura9OWZ8jbVSuhemk/eEgTlRa/VGrK80DayfXZOeG6p7FTmGVNziyHNftgZtadO9TDzgItcbi+8xsPrzss2xj9Mv0X6ElHKp7rzpbvwwAQwIstZU8cLko17RcrJrygoMVyiDHo9nVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfQfbpqyhb7qTdvAXFoErOr+7MAnvst/GIz0Eh72I/o=;
 b=xHpL2kxuWX0mLObGpYpp46joNWK9qNVbBTcy1YbukNUwAHuWypFL8PXHpMaz6vzYqkOwhAWN/uWlU273Cnyirr6eX2P/uDRKYNACGou3bPcqiF33k2JnjnptW7mgVHRENtE6Tt2mfppz+85ngDeHNR4Mtzw14crl8Jsn6Ybou7M7mqgM2EVyzHpFJT4IbyOuygR2CRvQYoGmJKexvQKlB0tgu3RboU2HnJaNy+W8sYIJ/htK4+r2b8mjZPJxG6qCNyal8OkjAz+nlm5n98bOM7W3PGPxfa3EmI/4O8UCl4SwnV3aFvkGbc7v/28A/9RES7xCF8ayyINHRzbXfMyTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfQfbpqyhb7qTdvAXFoErOr+7MAnvst/GIz0Eh72I/o=;
 b=ds6dvY1WZzMBh/ocC4yxYqt4D39R6YKIxSnUwetIFH/b1AnFr/Rr/qaGEnj9AmxKoirrlEapPJeynbsTCi6cQ1QoiiUVyjB31Ge/9naj/dkXL/jL30ae7Zt8DDFhLvdvl3jymtXlBAOPFDc3B7SzW05u1kqm9Qxehhh7A8E5Ix7bWQfbQ+q7zHXHcqW6oOjtCqLVm6fmOwJRXWUWZ/LRbH2tlBEIaXaxWs95q7hcgcTFtlQwiSo2Fm74jADnXOQtQWeGvetHGF0w9GbcU3Nwm9i3KTZ5U9rloumigqkfpV5NBdc3xNM51+QA2kzVOAC5SsjXbdpLTpi3AhyXkGq8kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB5PR04MB11254.eurprd04.prod.outlook.com (2603:10a6:10:5e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:18:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:18:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: core: style fixes in mmc.c
Date: Thu, 25 Sep 2025 00:30:13 +0800
Message-Id: <175873139554.3222.16127612470531674510.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250901134410.34344-1-bhimeswararao.matsa@gmail.com>
References: <20250901134410.34344-1-bhimeswararao.matsa@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB5PR04MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: cf625504-4a8d-4b5b-6713-08ddfb7daa90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|19092799006|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXgvUmdCLy9mR1BlWWhrUXBhbEUwS09aZVBCYVhPLzQwQ2ROaDdvVm1oWTJE?=
 =?utf-8?B?Wll4SHcrRUJJUk1YRFNHOVB3SUVrbS9iWTBZc3RjUmorQlljMmhuMW0rM2xU?=
 =?utf-8?B?UVBUTmczQTVMekVrSFViZTdLRnM0RElUaEpTKzBxcnRraEZza1NaME5UTGxE?=
 =?utf-8?B?dWZnelhUblZGZUdTbkdkaVhIclRIV2xZaGFZUml2R3l6VytDbkVqNnVjYXVr?=
 =?utf-8?B?dTlzWnFxSDRhcGZZbnhCZXQ5em9aYVdUVGZyWjNPMXl2akxjVHZYN1lmZmJC?=
 =?utf-8?B?NFFRNUk1aG9zNzVNUlpRSGw3aURsc0RMenMyRlZ3Z2hLbjZrRllCNDhsMWFS?=
 =?utf-8?B?L2FJYmxxSGJxMkpvRTc4VWdXMWs4NVY1K3hJTFM3WjdONlVFTFhnclAxOWpt?=
 =?utf-8?B?NytCdUxSdWRwcXdZWkc2WEVwNlVLeTE0UGxtZTgxZmFhVHRQL0d2MmtoK2Jr?=
 =?utf-8?B?YVUvT3d3Z1VsYlQrQVp5eDlCeTEybU5EWDZNZmtPVU02ZFY3RmVCaDQrYUFP?=
 =?utf-8?B?MC9WZXAxZ0lCY1NHU1czWjAxS0wwL3VDR21BeXlvRm9GTjEzNU01RGhsendU?=
 =?utf-8?B?c2RGa0NGMU5RdnF4d2w2aFhlTjBUMkwzalkrWk1tN0xENGdPa1NPSXE2cHhq?=
 =?utf-8?B?RVJFWjllUldYNnVXSDUzWkZLa3ZqbzNWM3ByRkZWSjM1VDRXSm9zdDlnQkNx?=
 =?utf-8?B?a1VvdS9uYkxzMCtteEE2WEFBTlkySGJ6NW0vdSszcFRaNDRvWHBqKzJCT2ZW?=
 =?utf-8?B?VFFwcFBXVDdHOGhFeDJKcFpzempGM1NFVW1PcEF6M1M5WUZLSllEMExGeFV3?=
 =?utf-8?B?Q2JnRVZaY214bTlDYmk4WVVxbXVrT3pSYzBML2Nxc0UzVkdxN3FZRUdWRDEz?=
 =?utf-8?B?QW41RjRYVXBoNHVoWmxsWVQveEZQZ3VZUDB4RmZTVzl3TVd2eW9TOUwraysr?=
 =?utf-8?B?NklSakcvb0cvNC8yUmxGNnl0OUFCQnEvV2JxUmIxVjRUVGhpN3MvS3c3WHhN?=
 =?utf-8?B?bDJjNlFWa0t4dkZIYUxsZlk3aERSaktuOEpOczAzNFJxbi9ZQUJmN3lza3ZX?=
 =?utf-8?B?REc3eTdlY2V3OWdweHVacXVmVnlNU0FweUs5SDdNbTMwaVhzeDVNZkM2b0M2?=
 =?utf-8?B?REJEZ2Myd1dtV0d1NDhncTVOeUJIeFVkSnFXYURhNnFTaXRRYmhQSG1wc1hJ?=
 =?utf-8?B?TWlYUDB6ZjE0ZEhVN3JIYm1iZjJTYmNSdEMyblN3cUh1SnJDZ0x6V2E0aVBp?=
 =?utf-8?B?WG1JNTMyeWltMUVtc0NubFgvdW5uY0FCQ3N6bjNNUVEvQmtvWVlBcW56MlR4?=
 =?utf-8?B?eG82SHBjbldEcUNLb2RTbllqL3F3MGt1NVo2VnNBc1gzR0gxZjgxS2pWUmRn?=
 =?utf-8?B?WDdId0VoSXN2MW1HRThLN1cya0hGTlZidzBWZy8yQ0E0K01aVTFEV1NTei96?=
 =?utf-8?B?T2pLMFFJSEI2U2l3V2ViejZ5ZTNnNzVYK0FrZWt5Q3JPaDFKakpDaXpoU1dG?=
 =?utf-8?B?eldGS0Ezbmh2YnVSaGRWalhadHRCZEVuSUpWK2thak5wbG9naFVzUWFRbXpz?=
 =?utf-8?B?NC9IMGtHZ0xoSnpuRTROR0JFSHdOd05JYUl1WnB1R2lidldIdGpOc3FPd3Rz?=
 =?utf-8?B?Tm1jQi9manpDZnB3eFk5dlhFTHgrWHhUNHVqa2UxUGJIUlZDNENTREJIT1ZZ?=
 =?utf-8?B?Uzd2L1hMY2dpTEk5Y0xCSW92dDNlMlhUU00ySE8yTE9DdzdwcW02L1I2T01L?=
 =?utf-8?B?STlOVk16MXdTQmhzY25XNHYxaVNPcmkrNnFzbGVoM0hVMzBsRHN6alZqaDQw?=
 =?utf-8?B?a1loQ3RkOTBaZUpaVHJpUGg0bEJpbGI0L3hBZEx6L0JSaVNSS3lYeUNuTklw?=
 =?utf-8?B?UEJLbVhuOURsY3FXZjNtUzBaTzcwTW1SalEwMHdsc0JiU21YZjVsL0FyV3FW?=
 =?utf-8?B?VUNLa3c3c3UzOGRoSWtlUy9Fd2FzclBiVlRyZ3FWNGpmYk5ZQTV2TVFVL2t6?=
 =?utf-8?Q?lgyJ5MVGyZtwhmKbqqDMQVfA014TQQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2hxQzFOYVFsd2lkbG5URFBmSEZ0Tks0WEdyTHZlMFdSd29rTnlxYW92bmxo?=
 =?utf-8?B?OG50R1AwM3FxSjc3OXhWNGxJRi9tUTJYWjZ4OFBjK0ZGNGYzZVEwL3ZjNnlx?=
 =?utf-8?B?UjRzaVJ4QmtZaVJ4NHRmZjBLMHE1QWY2L2RFM1lBN0NvMm9NZWxGTFFwZEZR?=
 =?utf-8?B?MnQzTWRNQitSU2VEWVIxeFdQQVhlVXEwS1UrSmFRMGhLbklHR2NqMDJWc29C?=
 =?utf-8?B?V0RiWjNFQkd5WkQ3dDMyaVR1dUVYWlhXYmhYYkFBaUZTTVFSM1RTamFHWkl5?=
 =?utf-8?B?WWwwSmwwODhxN2Q2U2owTG9hRHZkbkUzWWxoeUkvaU9ndWVMSytxdFByenBU?=
 =?utf-8?B?dkozQmxTZGlIR0VaTGpJWFVidjBSVVJKYWtrcy82Nm1LcEhpaUVoUlpUR1Jp?=
 =?utf-8?B?TTc4Ukg2WUFsaElCTzlWdllTSmJDWGo2ZHZpalk4dXFiU2RjbklWNXBOVDZP?=
 =?utf-8?B?elFTZ1g5K092UWJxU1ZUNEZvV2ZZMmlxendOcHRxaUFxVlNicDdJWVJlM3Uv?=
 =?utf-8?B?YVJRZUV1ZjBUTXZZbHdYRm9uUHpJbHlPcFFwMjNxWWJGR2FUQUFiWGthYVNJ?=
 =?utf-8?B?U1Fjdzk5d2YyWE0vZTdFQVlwSFJ6eTNHUmg0aWpSTGhJSHhNMlB1WmJFRUkv?=
 =?utf-8?B?RzJpdEYvcTU4VUcvVWtMbFZETG5mU2VnTjlKMFBVSkZZcFhGK2tlRlpQWm9y?=
 =?utf-8?B?TTZyUUF5ZHRuZFBNRXZvNjhHeTF1SlNVOGdGc0FOK2l4ZTNBYUt0TS81UmZu?=
 =?utf-8?B?YUkyK0JsanVsMERTL3VEQ1l5dmQyT1J2eExkYlEzczJ2STdIeXBUREs2dmdj?=
 =?utf-8?B?aHB0Mkt5d1k3WWhUWGRJMVU0bW9WaVdTVmFHSFQzSjZHaWNTU0dZOWxjR09M?=
 =?utf-8?B?MWJoTXM0SVYzTHZiTEQ4NVNYNGYwSTBZdWNzY2ZEcFc0VWhtZXVIeG44bVVR?=
 =?utf-8?B?NFpKQ1dlWndORjdQMHRVWUZYaUNpUmZIcDZBakx2dlFzRmpsWVZIamdwc0Vk?=
 =?utf-8?B?eU9ZeGdGOEl2MlRKcWFwTFRBVXJaNkdXbENpMmw2VGxsMm1Ud0FBOUY5M0Nl?=
 =?utf-8?B?YkVPOWNFOTRvWENQamk4VmRWcHNvSDgwdTdOR0xmTFlreEJRakFKWlFpSTNI?=
 =?utf-8?B?aXFlQUx6L1JYUG5KckVPRk9Sc0ZBVmhxdnM4TmUwWi9VN1NOWFE3WGt6Ym1U?=
 =?utf-8?B?eWJZNjhlUU5MbTMzY2grUFFPUWpMZEVWNS9LV1kxdGZnMkJMT0FKMENUN0F2?=
 =?utf-8?B?VnNXVTZGSGdLOFBVaXNGT3JNdm5zZnM3RlhnRkdTZ1VjZFdHdXV6Rkxsc0lL?=
 =?utf-8?B?RzhFTjJuMFU3SHNLQ3R6MEhYbmJtTGhjWC9qamtFTWpzQW1hdXpwVXAycktq?=
 =?utf-8?B?UWNXMlFIVnFLdWVWdVhnYXdUbEpaOE5mcDZaVXJCZTRPV1JNVVh4b3QxQzV3?=
 =?utf-8?B?eFJ5UmIrbnNadGVMa2hjVHhNYVdadTVybEV3alUyK3BEdllkcnZ5M1lwK2Vi?=
 =?utf-8?B?OE9xcWVHUDE2bkkyQW1qdFlzKzdHTHBQZ0pBc2tzTkhTUVdCR3krcERtWWFi?=
 =?utf-8?B?UE1Mci95cE52NTJNRnFjRUlROUNWZ1dweGt1TG92NENjWXZKaEJIdXh0K0hm?=
 =?utf-8?B?RDlzSEUybUQ1eHhmWW0xVVY1eVFLTUhHVEhYSk9BYXR0MFFBR1ZRMU81U3do?=
 =?utf-8?B?OWxJcHZZem9IRjd3eVByRWpRNDUvMkl2UGxKWXRzUEFWL1dhaVJabC90RVFy?=
 =?utf-8?B?bjRaN2FQUitPUlpwc1N3aW9IaCtmWjhsbks1T1E5QVY2NEpMN2RMYjUzZmZr?=
 =?utf-8?B?aVFDRkV0WEsvZ3dpYWZZaXNqbS9MZzNYclBRblBNUkRrYjhEa05nT1F0OWhD?=
 =?utf-8?B?M043cmNTaG1zbUp5cyt3OVRiWGNTdVZvcGhPR2ZrZC9RNThYM21TRWFCRGRr?=
 =?utf-8?B?blM5RUtJZmNKQ1FoNlQrUGY5SkFZQk8xTmppdTRBZEJkVkdHd1Z0Y1FndWUy?=
 =?utf-8?B?OHJBV3VnbzhoT1pXdWxyVjM3S3pQN3ZSVFY2QWlwT3ZoNFpiTHZtNzVHMzQr?=
 =?utf-8?B?bnMyZ0hIK3RMdzdVMXVidVdwejF5MkVPdUJTTXlZcUt4QUxPenA3Y2FWc3k3?=
 =?utf-8?Q?6xcILyOwAiOCgJsWrgnJt+70p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf625504-4a8d-4b5b-6713-08ddfb7daa90
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:18:51.1020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx0MnhUhiq9M8G0z59auBjIvnbVPxMO8sPJv3ZPzIdz8Bi6aR6b8E8d30WQvEZl9p+X4JPYGuWf9Ot3BOdebQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB11254
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:56 +0200
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 01 Sep 2025 19:14:10 +0530, Bhimeswararao Matsa wrote:
> Fix a couple of style issues reported by checkpatch.pl:
> 
> - Replace `#ifdef CONFIG_MMC_TRACE` with `if (IS_ENABLED(CONFIG_MMC_TRACE))`
>   to follow the preferred kernel style for config-dependent branches.
> - Drop explicit zero initialization of a static variable.
> 
> No functional change intended.
> 
> [...]

Applied, thanks!

[1/1] mmc: core: style fixes in mmc.c
      commit: 3cabc6bf7e16c7e2a1156392c31e40f678cc7026

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
