Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A0CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 16:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4343983FF5;
	Thu, 11 Jun 2026 18:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="E5txkHSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A51684671; Thu, 11 Jun 2026 18:26:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB5383FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzMqZ2ax5KXt4DafEBzXV7DMCtGaYtqBcBVdVkeO2baUIUresL87gAioc34ojjs9a7LPmSJtkwNPpnlfw0RPZhfbQ+KaqZp0oUhppG2ljhmg8/Nl7Fpj1Sd4OnIlEvu6TQd1qHDlz38gZKs+oyFu3RoVhpRkZ3IL6Ce8WoIKze1+j3A24iCbOPEZc6hoE82+T/LlK+NxNJspRcT93iIQMedjrwnztcG0qJJROkDE7phK1njuv/T0qEaDjq15pZjNH/6o4XeGuJXuOcKKkYf5lkH+VIHX3OGfJMh5MHXoaJBul021ih/NkOMwSKxeS/xC/89sbpR6WoUYrSkCcjSISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1f5U+oK/ATXJHGBBZteIPawfrJvLVv624Ebzqx8avc=;
 b=KH47Q+HtvjuFrt+ADBZfRVSc6ytdR4CBzaLk4xlaiX8rqBMVB86Z1C6LvOsZQSdFMSMrYRVVJF9BV+gHcbCuSVr1x70YtJfIYvCJftbOUKyD5ib4OJVJjRdH9ILd5tviQMawREtGPi1f33eJR/O4ckNk1ZA/Q8dYTZU43LquPQ/PGeKZt+cisTY4XncbMgOkiHs8dLNxXyyCbB772IcFYlTwywVO8Gvt6ZTyNeGXVxLbA5VFwNQ7lcFs0xsFqNMMhHA2MOEdH180hZQJCA8F2mHEKxD00wK/Ol127RX0jkJvDt5y6SwL46g5LGo/LIJQYFbeI7GVLY5qNLspzyjQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1f5U+oK/ATXJHGBBZteIPawfrJvLVv624Ebzqx8avc=;
 b=E5txkHSDMXivFfzBDxJFGr72Sk/UDDDr6yFa03Oo0h0H8kZw3vi5q3H8TNT1dBkYDMBWVBpB4TueGM5aKOBNlxFuvqa/gqy/AFsiRJN92LjwlpAtmxgfzF1JTk5mrrBbYG6St3qi0FmeukMu69C+b90dWbqhBZo5PxeMJKX/Uqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAVSPRMB0011.eurprd04.prod.outlook.com (2603:10a6:102:322::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:26:45 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 11 Jun 2026
 16:26:45 +0000
Message-ID: <2b700412-b84e-418a-bb71-1bd003c5b37f@cherry.de>
Date: Thu, 11 Jun 2026 18:26:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] binman: add PKCS#11/HSM signing support for X509
 certificates
To: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 xypron.glpk@gmx.de, y.moog@phytec.de, afd@ti.com, Wojciech.Dubowik@mt.com
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <CANu7NGuR3JUiV-4xZQ25sc2k2WkJxBaM_pRtKfmscTDPFDMemg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANu7NGuR3JUiV-4xZQ25sc2k2WkJxBaM_pRtKfmscTDPFDMemg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAVSPRMB0011:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ed89ee-4974-4fc5-6952-08dec7d63a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dovmdPMJCBwE4gh+ZbSXDigJ7YCLv4QgSCrtRNNgmFh3bmB1XX4eeu4A4nLWEKpiTlcyRoKAvXKlfK1X2tBQMhAjv3HhdwDKgQq/c6ZL6BMlXaCuEZzitkGTZ0vY5BDJ4EQTDxe3X8ggUafBapxhvfjp++5xSUZGSbhBCjZYKF9sJEleeQd9Pt/tHhhuvfcfEUcR8CXiGEj6jiNm6l6NTgCtdx1L12v1qT9z2pjcl1XYYQm1h4m6GvKaxPTIdIzqQhfNIieLmTgKEEpnUHVLmCWND34c6+/AUKwoMMa/Jt/LWrt+J84FdhyIGS2Vm9PtwwJomtiwzkZ6pkey1AC5DO3N8lF+EhFYwJa3LC6Nh97OyjnWXIEfUdNkdBjmcViBtaLG5Z7Dhn/FrPNoe+vWYDgn2e9B3CDoFNqajAIEYxKiT5ITPmXVnInuQqkQ8ffE9yq44ctcJaGgJUHuUvOj0UZr8rlh5Gp3Q3aPqyZfDwxjufWJOxZQDXgtmUeyfbdzgQFlNlAtbi287x+JM1HxMVSNC2PzB22lwVD+cTwCqMeb+ftDQHBFi4x9jvvz38HeWYJkQLUqorcVPqU2vGr1GVy25/PialdflOivYKpRKwlP4dBXNBh35TtgCnh78sAuA1qfXBKqh8XGnshLH4zHnVAXFagl23oSKtTRg9tk5M0itMYrSpVZQCgBXn4m4Y3q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJSZmJ0SXM0Y1U5SzMzTy9KMXdCVTBkbTFGV3o3cTFURmUyZDNmQktLS2NX?=
 =?utf-8?B?T1BuNURCWW93Q2dnYlUySncrTmJ5Tkk5Ukx1akZsTUZMOGgyNVV2VzNaY1pt?=
 =?utf-8?B?QUZuU2hHQ0VlMnJDZmZVTEl1Q1R1aWRpVG83dEQrdEVtN3BmRWRSWENxWG9m?=
 =?utf-8?B?c2FITWZjaTVzbk8yYS9HWmRONkl1QUcvMkYwTXhhdUZwbE10WUlOMGFqQjRT?=
 =?utf-8?B?VXQ2VTVVbnJqeDM2MkcxUVl6bThzdDhmRnJvMnJFQVF2WVp5bnlnRjExV0N6?=
 =?utf-8?B?MHJLTStqSHhSNTZoRTZRdm5BYlFzZ08xVVBJcUpCdHlxaUhBM0MzQjV3ZVpR?=
 =?utf-8?B?VWMxb09tSWRRcFV2TkxjSHRKdm9MNHU2UTRxbXp0dnF2VUd4Q2VBQU0wUGdW?=
 =?utf-8?B?Y0NocmIyaTlscHR0M0NOMWl5UW9qeGJqdUdxWVRUQ1ZpTzBxSzJOYVJTRWVI?=
 =?utf-8?B?VDh4aWUzYkpzUmplTS9wNzJTelVWSVR0OUNQaEJVR2JoQVFGOEs5eFRPb3Vx?=
 =?utf-8?B?VnA2YVM1OG81NHJQcm5sdVJacWNZbVQxMUhnZEo4MmI3ZWZ6SXp6OUZvOU1E?=
 =?utf-8?B?VmIydTBDYXJFWldHMmJlY1FnNFljdytHWjAxOEJ2UWpGRUhid21YSlhocXZT?=
 =?utf-8?B?dnRsTHFrdzhjbXRMRXlJRVUxb2lrVnVUMk9qRUw4aWE5eS9HbGw2OUtDejBP?=
 =?utf-8?B?MjBlTVh2cm1HNFBLWGRXZUd2SDNpMmFtS1NWdnRNZVpuSjU0RnZ4RE40dkZJ?=
 =?utf-8?B?cDU3ZjJUdUJqWU9TSkNyNG9vaTB0ZWNTR1E1S2piVDkyemQrUXU0ZFlmczFY?=
 =?utf-8?B?NG1uSHV2ellVTm1qdVRycEpxYVZJOGV6OTQzdjVwVzdmS1daTmQ1bFZMVmFO?=
 =?utf-8?B?OExhU3A0a0d3ZnhZeFQ0N3F2a3YrMy96VTJpTnI5MUIrMlJzTVZRdlBUUVdD?=
 =?utf-8?B?dk10VFUxMzMwUHRZZWxWTUZyNDJyRWFyNTgyQnZDbkdUMkJYSTE4M2RaRWdQ?=
 =?utf-8?B?U1VlZzZtbHQ2SVhneUMrU2xObzVaQ29mSW10SkRnTk1qZ3p3bFFLSUVmM2RF?=
 =?utf-8?B?M2pNbXdzS0FKalJUYjNUVjFWeFk5SFhOTWlhTm1YM012NXhrTzF3dUxBRmlu?=
 =?utf-8?B?MnlNNk5DblRTUXl1YmVXOSsvY2NjbWcrTnpzcms1OENDQ1M1ZHhkOEllaC9K?=
 =?utf-8?B?eE9jKzFNRHdLSC9xMldva2RpK0JwQjZIRkNnaXhQWFRidHBKenViUXoyWWpF?=
 =?utf-8?B?NFpNVlFJUFJ2WE9yaGVJTzA5T3VVVWhibTc1TXNZUHp1OTVvZjRTOTQySk81?=
 =?utf-8?B?cEo3YUg2b3BlSytrRnM3dnowRjRCTE9kTFhPc09kMFZmK1VlSWNuZlU4MHRH?=
 =?utf-8?B?dUMxNGpmZDlXb2dhRkxlQitzYjU0VWRGR0xZeWVKdnIvdGwxYWNyY1pVc05w?=
 =?utf-8?B?UHBnK1FnUHFKTGlPR0tQejF6UjVzQ1dQS2k5a0hseHpGWjAvWngybElZZ0tI?=
 =?utf-8?B?UDZYcmlIekRRR3pGTEt4U1hSNERQZ0xJSkJhWnZrS2EwcU5oeWZOQk1zSUR1?=
 =?utf-8?B?TlVFYWpFTWFxbjhCSGE1MCtrSGV4L0hidGF1a1ViMmQ3Q3BxMmtwQkhUT2p6?=
 =?utf-8?B?MnFCWUM1aHJ5U2VNMXVvK0lRZUN5K3o5NzZtWFlpMDVaSEpGNzFBamdhUEEz?=
 =?utf-8?B?dnlhbS9JYlNKVFEwYnU1elNmM2pHb2dsWHNSQkJhUzZQTEpmTEdZTDVYWHlU?=
 =?utf-8?B?U3FJbXJJaDdGbk1tUUwrTkFrU2lpSzdyQituL0pSOGpjM2NEV2pCSXAwR0VY?=
 =?utf-8?B?WFNSeG5xMFRYSVN1U3FxelA1Q3hNYnFpdFI2dFdBaGJRUG04Um83YkFaa29Q?=
 =?utf-8?B?c3Erc2hnV1lMWG5ERnUxdk1jYWpRN1JoeWV5dlppdFdHdXAzNXlkSFBTb2RW?=
 =?utf-8?B?RnY2UG1rRkRDVWUrSytNZjlTYVFUNCsyQzJHV0VuL21jOUxkMUV5TFNKZUo1?=
 =?utf-8?B?LzMvZmtRbE4wcjZGMmRENFhjZ0YrTk9LU3V3dW0xWlVDaXFwaGFEUldHUjVx?=
 =?utf-8?B?ZVFsQjl5Q3hpSGpzdW1pWkFwaWhxbHZkbm00dkpJc0xlWWZsbnJuN3c5ZXkr?=
 =?utf-8?B?Sno2b0VuS2NDNk1kQmJ3QWJGa0h5V2JtNWhnZTFVK0RiL2xybWk0SUg2clo3?=
 =?utf-8?B?QzdzNmNyQXVZSEJTT01JWWtmNTBOSUlOTGF6cDU5U0YvRmZEZmJJRmNGMXFD?=
 =?utf-8?B?SjJMYlEwcU5IbDVoaWtaMzNsYVo3ZDYxMDRyMi9vZnQ3VVB4OHB3Mk8xbGFD?=
 =?utf-8?B?d016YU9WOTRMOUNOM1JVU21qcVZBWEhuZkE3dkFncEhrTDZUazhaUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed89ee-4974-4fc5-6952-08dec7d63a87
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:26:45.2985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Vtr3u3PkLhTTXyK1DECusiqEYBt0daEfG7Z+z2Q9ABflcCizt+TRbxfqMAsXFv0H280/t23YtDoNfdeVKQBFEMxxyLl1Khbvt9/DbEanXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVSPRMB0011
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

Hi Sergio,

On 6/11/26 11:14 AM, Sergio Prado wrote:
> Hi Simon, Quentin,
> 
> Do you have any feedback on the v5 series?
> 

I'm sorry, I'm currently drowning at work handling CVEs and I don't have 
time to allocate to review this for now. I am hopeful I will be able to 
carve out some time the week after next, this should be hopefully still 
in good timing for the 2026.10 merge window.

Thank you for your patience.

Cheers,
Quentin
