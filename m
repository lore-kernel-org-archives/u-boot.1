Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583A6C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 09:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B518D80EFB;
	Mon, 28 Apr 2025 11:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WNGcacmS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WNGcacmS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF6280FDA; Mon, 28 Apr 2025 11:54:13 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C3080EE5
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Udxdy32i9Jz6H0nQWOFLfvxyCB6drtOPGt+nSBekc8tkcPyIjc66MgrpYG9mhRwQRaLUwypR2akqySUzgKBbjc5S4QACvIBXBujhmWUYXwExICvKrs2CWEYLEefvg7cTpTw8uc0vUB/lh4TOaTr0iqJFGcnDday6+dq6tCGopXmZru4aFUt7HSbviI9OSP/PJ2ooRCpmjK0UpKB7+q0mOcKNtCWk+Cp4MHOzt4iJDYdH+Y3iaazE16JgdkpW4L8YWWieifglEPvWOUmHHLiMsWLgJuFXBEj6QqeKNVWxR0ItkjF80BWZNNYOzF2jT2OpvTDvPBFl5BfnPRVgRq//yw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFBxVXAKgG+eQzQJa8aDopvGsOaFnabWnXifZ2utTtc=;
 b=eEFdYqLWjwA8lIEZTDdGWrnjkkDqDoVE9sF4oByXIj+Do014J+39ExBUiMfTFj73sRjiTsZ5UiFqKVzTJmLcaP1/1yvwWhcKqtVnSqd3T7CCWDpooxDM/P/OJ4R6e9ud9bDWZhXk1fRLkZouGqJNookRytZDWbNetcOyIk1woqED9478bj01uMmDzuGRogyjXy2nIjvJr7lzf1RL0EF4X0SCw5CcPAN07E3Qne7mq/B422GTIxUNh9C9hj1Oz1t1PodvuDLyTv0aJl+EhKu/e+q52xc/CGxJ0MmHcksPqkUp3kEcLDVWmr2lF9WDssc2qmhNaL4vIEp/pSkpMoCqWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFBxVXAKgG+eQzQJa8aDopvGsOaFnabWnXifZ2utTtc=;
 b=WNGcacmS2PsRrSvjgLeLVAQOeYmCfOw7W4nKK7CBU9Pwsrj3vidgczz7Mo+S6qHurfrGJZ7dqGwk6T7U/ODSmngXigw2MNyBug0rC8cOSrc//Vk3BTF4MUgOByIi/4TtH1AYQPxWTm14MSYdopGjBnTvTv49k7JOGe5zdUUrcBA=
Received: from AS9PR04CA0157.eurprd04.prod.outlook.com (2603:10a6:20b:530::29)
 by DBBPR08MB6234.eurprd08.prod.outlook.com (2603:10a6:10:202::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 09:54:08 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:530:cafe::d0) by AS9PR04CA0157.outlook.office365.com
 (2603:10a6:20b:530::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 09:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.33
 via Frontend Transport; Mon, 28 Apr 2025 09:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMZ5LGZFRlko5TtHqm53iYcj8K2pbIc6+almWT3QVpaPjv+GKr89m+VOcGiVlDeQ9ozHB8LlqqN4lDsB9OMHM0Y/BHMEwB+HSYE4ht3toNlodoqoV9iqMEBfpZv9ZmKEGy2G/4INhpsNISVhU5+3cuivHMJ/ShZLrKB8DnCG5MAszK9VSc1RD5g/25oTer46tfL5tUanx3wO1HQ5F53zL+mpHbrTeSrNTX7A1ZnMpB4yjvKpGZXo6Xw8jli8qVxuKYL7me3P+LM8nx8gr5jkQN/dzk7zRwZh87vtIfav5SwfV0woZJyEsKNTj976YPSZoSfE7UX+gotSYRt4VSxcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFBxVXAKgG+eQzQJa8aDopvGsOaFnabWnXifZ2utTtc=;
 b=Yd19QPdKBVzClGbPVSF9OCRQdUBhM9/NxsSQNBjPG3V2xuYOAXQe4MRMI6Kd0lZaKwaybmZQI/lRJwiFJ5IsFCj6M83ZZCq2R5CslRNByASp4iMsjdAsg4rQwf3g++hHYSkfQjrbvFjjG2dwmTTKRUtvl4e5NGYn1yrydCVJQW1JylkJt5f9M4ZcLEJpG8PBO+B3Yflf16u2gE7T8XxKfXb6F7VhRC37L/v67UaD4j2pQ9oY5rK+t+bqqOpNINTMh0LhsSa8d+Xipw3Gj7Y6FEd61BYwODxvMg/d4Y40Gnt4vzucdHFt2oCWb5R5e5lD63jZgda7+sfuCiTcuCxNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFBxVXAKgG+eQzQJa8aDopvGsOaFnabWnXifZ2utTtc=;
 b=WNGcacmS2PsRrSvjgLeLVAQOeYmCfOw7W4nKK7CBU9Pwsrj3vidgczz7Mo+S6qHurfrGJZ7dqGwk6T7U/ODSmngXigw2MNyBug0rC8cOSrc//Vk3BTF4MUgOByIi/4TtH1AYQPxWTm14MSYdopGjBnTvTv49k7JOGe5zdUUrcBA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AS8PR08MB10346.eurprd08.prod.outlook.com (2603:10a6:20b:57e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 09:53:35 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:53:34 +0000
Message-ID: <f46bf893-dabc-4df9-9a05-5b24642c8572@arm.com>
Date: Mon, 28 Apr 2025 10:53:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docker, CI: Add vexpress_fvp / vexpress_fvp_bloblist
 support
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd <nd@arm.com>,
 Manish Pandey <Manish.Pandey2@arm.com>
References: <20250422193657.512324-1-trini@konsulko.com>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250422193657.512324-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::13) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AS8PR08MB10346:EE_|AM3PEPF0000A797:EE_|DBBPR08MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb9eead-d5cf-478e-e8b1-08dd863a9e46
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?OUtDS2RKUzltOU5pcVNrb0VycE9BUWR1c2owdE1TY1hpY2Z5L2sxN05ocFhJ?=
 =?utf-8?B?YjdJVFNJdElFc2txaEpBUEdlNzkxSHQra1hKSERPV2huZklYaWJBS0VuTUtj?=
 =?utf-8?B?enZvMHJLaWU3UjRpZzFVeUErVXdVV1pWUUFQc2p5TUl5RE9QNDBjZi9TdlRr?=
 =?utf-8?B?a1lTNmpvM3ZqVE9reU1QMDkydHN4QkQxOE9ZY0NTRjlOZ0NWYUVPcVV6TWt0?=
 =?utf-8?B?VUI2OXBaNmVDRWZncTJsU2NrT290S2ZnUEdtdU4vT2dWbGR0QTJlMDVEZHdM?=
 =?utf-8?B?b3hvSUwyUUp1SDR4NUtEQ0xuYkJTQmRUNVBsSkkzOXE1Z2RVaGh0d01nS01T?=
 =?utf-8?B?OEYvOEF2UU9PRnZtTVdwY0d4VWhLTzVWdktMWjIwTzVtT3NQdFJNRUZlcWUv?=
 =?utf-8?B?YTFXZlFnZUkyUTFNaHdpaHZXZm5IVlRCamROdEY4cHRtbjhBNFA2RXR2T1Y5?=
 =?utf-8?B?SG9MR1hTM2MyK3MxWWtndlI2aHdSTFBBRDZGVEE1ajhvdmVORmI3UVlTNzcz?=
 =?utf-8?B?a2s0RWZhYWEzVm5XcTVvT3ZIdnNXRHJRYTB6ZUtpS3J6Y2RMN1ljWDdVcGdo?=
 =?utf-8?B?UGFFMjl3aVRpVzNhSVlxVDlOZ2ErdFJlTFNVK1UvVUlTeE9lTkUwV2VlTkhm?=
 =?utf-8?B?aUluWFJFKzhKaStJZEFaZGg0MHVkazNubTY4K1oxRGpEb01IUzdveUk1R2tw?=
 =?utf-8?B?Yno1UW10bmNiNmlBVUNWTGJRMzhiZTREOFcweVo0Tk1uMW12SDVNZnltb3lN?=
 =?utf-8?B?SnJ0QVBZMVVHMzVPQ2RObGVyd3VOckMvZVpmbTBTSzYrVnhpbHhjLyszTE43?=
 =?utf-8?B?UXlDY2Izb3F0c0VCWDQ1RFZnWStZMjNCT0JtUHliQlA0aVFXSW1lNDIrMHlL?=
 =?utf-8?B?QTZUTkkzVWZLZWRFR3Y0bnFwc1BIdFQvYmpGTWhMeG1EajMxL1dxV0VyS05k?=
 =?utf-8?B?UEZONlh3dDdlem5reHZQRmhOZklFa0tqZUxYa29USmRORnZjWFNLY0RBdWx4?=
 =?utf-8?B?cXNBUGZCd2xyQ1AvTHc3bjU3cG9YZXA5ZS96ZVlzZDJQNTFaUldoN2N5V3dH?=
 =?utf-8?B?Nnh5Z251ZGN6aXZhbXJWaDNCOXNTck4rSnZBQnRJQ2Y1bTdwUGVxOFlYRmRD?=
 =?utf-8?B?QVlRQStOSUR0NkQyZHJuWUNETEJpUkxTQ0t2bEMxc3JMcy95M3ZWems0SmVT?=
 =?utf-8?B?djdtZzZCSlRuSENCcDkyR3dBRTdVZ0FhNGNDeVAycEF1b2JERGVWUnpNNWZ1?=
 =?utf-8?B?STgwZmxOelQvRmlQaHpWYmgxeTJtSy9VWmxFcGUyV0lJMS9rNE9PVmgwdjYz?=
 =?utf-8?B?bVB1TXJ3MkxKUThFQjgyaSszK2M5RTkvUnAyZ1JuM295NWdXUTlENTF4VDNB?=
 =?utf-8?B?MVpYOXg0SDl0Q1hJdVZwQUdPSTA1ZDZzSGRCQ1ovUDVVUW9icVJmangrMGFm?=
 =?utf-8?B?bmIrS29MTGNtNGNDN3QvVWZYOERXWDhZRzRZSHNqNEhHc0JGd1JLd2x0VXN4?=
 =?utf-8?B?aGlUOVVMSEtOd21kNUI5OXAxbXpSWlltSFdHQW4yK2VvemVmSWpCbU5IeGRU?=
 =?utf-8?B?RTFqWjJlbmZmRjJmTTdTUXlWOXl2Y2Z1ZlU5WTJWSmM2M1FOQ0lUc2M2RDhD?=
 =?utf-8?B?bzFRSFVOMTRGVVk3ME9JOHhBUHMya2dxMmdlKyt4d0xkcEE4QndaaElYVldy?=
 =?utf-8?B?QWJPTkFENHo5VW5rUlZ2WFVSU0dkejNBWDg1ZTBGWThjT3RDTzM5Q1NGUXdW?=
 =?utf-8?B?MmxMU2VaU211UHZWRTBDMmpLRnFZMDlFUEc4NVJmWFBzbUdna1JWYzcwS0ho?=
 =?utf-8?B?Skw4UENxY1JMMUgwTFJwSFBCS1o3eTZaNGx0YjlCOXdqTlJqYm5XcmdzcFZi?=
 =?utf-8?B?ZnlXUitZelRFcTNveXlMOEp5WnRLbzREZHUrUjUyeGN6UndNbXR6c3c0YTg2?=
 =?utf-8?Q?4X+i62Dy7TA=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10346
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8eb51f6-820e-4493-5aff-08dd863a8a67
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|35042699022|14060799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2hIUnJhdFJ0VW9jRGhhZ1p2dmJwSkFnd2lmaVZDMUJrbUtvYzRmSm11NmxF?=
 =?utf-8?B?Z25MVTNNanB1Q2hWa3NUM3gwQXE3ekFHN0Q2QVBzVXdyREhRWGl4QkVqRDhv?=
 =?utf-8?B?cHBEZTRRalN6bncyUTQ4VU0yTFVOdlRGa09WUlFuM2dyUGlzVHVRbnh4VlI1?=
 =?utf-8?B?YmNWVlVMNnJVNEpqN3pFdE9Hd0JZUGljT05TdTJvQlZNaEtzVS93bDVqUXBs?=
 =?utf-8?B?eGdPZDNleitJanhyWHhLVXZoM2RyN3doOTF2YWttSHBMVDIxMzN3amQ2YU1T?=
 =?utf-8?B?TktrTDU0Q1RkNjhsaEEvb29BdzVKT3pjMWUyRVhvRitQcTZXZ0FJaUF5SWNR?=
 =?utf-8?B?Z2gybEduWUZhNHdmTHdJQkhGSFZieVpzRG1RUk9BRVBZSndUSWk1elNnRXBw?=
 =?utf-8?B?TkJHTURNdjg2VGJIWG9GTVhPMG12TXcxTlVBVmFmVGFKa0lSZFB2WnJUTWs3?=
 =?utf-8?B?bHBxdzQzNjNPbU51bGd1SWI1WmtnOTBlZ015eUNvR2NqY2V3clBTcUpXZmpO?=
 =?utf-8?B?N3ZlZTJUTEM3OWZ2SGZxaW9xUzJJOUttYnNKam8vckJvZ1pZUnorZzZuRDht?=
 =?utf-8?B?SGZsZ3ZkL21tR295Ym91ei9PYWU4bjRaaEREcHR3eE55cW52U0NhVlNZeGZm?=
 =?utf-8?B?Y3Y2ME1WeG5ia1FNT05BRFNFek1rU0hxZUVZVC9ycDAza3duWGpFa0QxeWRV?=
 =?utf-8?B?QkZKRVJpZEIxenpWUFl5Y01LZ3JzZXFTckZWVGlsc2V0aWxqVmVONGhoMkE2?=
 =?utf-8?B?Qi9zU1NBWit6VEovMnZROWVjdkJtWmM3WitIZ3h5ZjhUYmJpMEFuOVlNbzNO?=
 =?utf-8?B?ZXNtZ0srbHBWaXdWY2pSTnh2cFJzVzJQZWZoeWVZRjJieWJYL00weGtLcE9Z?=
 =?utf-8?B?VHlMWjFzdm9CQWJhQVA4N0F0OUpGS3Z6bS9Ea1N1L1Mvb2VtdEFxeXpSSWp5?=
 =?utf-8?B?czZwbnFQaHBBbkJLdnl4WVNiRzVNbk9TR2xrTnExTFBKaXQ0Y2ZOZUpRZUhy?=
 =?utf-8?B?cm1FOGVObGpQb215Y3piMG9ZczEwaUhKcDY2a0ZUbW5hL1d6T1A1TnVOdW1z?=
 =?utf-8?B?NmoxTzhRUHo1SFFQcE5jNkszSnFsVDB6SGw4Um1lYjRSWENDRU8vOTZEYno3?=
 =?utf-8?B?RFhuRmE5eGpBbnh4cFd0MkpkRStMREVIVFVZN0E4YnR0d1lPMThTUllha0VG?=
 =?utf-8?B?VUJnbTFzOVlKbVNRM1U4WnhxQzJKYmVYK1lRalhTMTFTV2VzazB5NW1uOFNL?=
 =?utf-8?B?cUQ2ZGlyanFzSWprS0NKR1ZOMkhiQnhKUG50c1FwdVRMUWFYZnk0ZEhSYURa?=
 =?utf-8?B?dFIwRlpEeXUxbytiRzRLWXlpTE4wSUg3Mk5IakhpVzZKZDcrSVNYenVaelVs?=
 =?utf-8?B?c1JSaW1HbE83MU9EOFlwTDdLWDJaNUdZUlpyRG5YaEp1WHJwOG83OVNyT2s5?=
 =?utf-8?B?b1ZjcnNUc1YvQWQxa3VGdHd0cjd0UmJQNTNuWEN5QmoyQ3BBa1huTEFjc1c5?=
 =?utf-8?B?ck52Z3h6NDQzaWt2M1hBSDFvblFSNjdYOHNFL1hIQTlKMnlxVTZheDV2cTR3?=
 =?utf-8?B?NmNha3VhMnN5V2daaVpjY2xKQW1zNEFFU3k4WS9kdzRDTlNvazhwSDBKd3h3?=
 =?utf-8?B?dEkreTlsTFBMZzBnQVM1bCsxdTZqZFZTSkFsV1FwaEpkcXdub2FzblNMOWUr?=
 =?utf-8?B?M1I4WlJqT1N5S2hMOCtNL1dQWmpTUlU1Q0lHc2FPNHQ3TVF0K2RjUUE4bDk3?=
 =?utf-8?B?RURRbC9EWklJTjMxbFlsWlNuVXpZU3lXYWxTb1NNRGt1QVpQcE0zK1lEcU14?=
 =?utf-8?B?SGhXNGc4elJxYkptQUdMd01sVEp2UWpUUGVnZ3ZKU2kwUDVkNlZ1cmVOMFR3?=
 =?utf-8?B?c1pQc0hMYjFRQWhvMVQyODAyN1FBL3grQ1pXcUU4M3dRdXVUQWJWUm1TdWtq?=
 =?utf-8?B?djZUcndwZkphNkFNYjkwNlJPVHFXbTdVdEJnWkFxSmQxZzVVU2tGdUF5SmlX?=
 =?utf-8?B?Ti9GZXlnbmJVaWFvWFhkQ3dKVzVqN2cwLzVwdHMrUlZhMFdTUEl0bU5uMk1n?=
 =?utf-8?B?VFdNdjhqdDNRVmhqdHBZWklpYUZQYVphWnN5QT09?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(35042699022)(14060799003)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 09:54:07.7173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb9eead-d5cf-478e-e8b1-08dd863a9e46
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6234
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

On 22/04/2025 20:36, Tom Rini wrote:
> This adds the vexpress_fvp and vexpress_fvp_bloblist platforms to the
> list of platforms we test via emulator in CI. In order to do this we
> need to first have our container runtime have TF-A builds for the
> vexpress_fvp platform, both with and without transfer list support as
> well as installing "telnet" so that we can access console. In the CI
> files we check for the existence of /opt/tf-a/${TEST_PY_BD} and if
> found, copy bl1.bin and fip.bin to /tmp and set the variables so that we
> can later run FVP to run.
> 
> Note that we currently disable the hostfs (semihosting) tests as they
> trigger a bug in FVP. This has been reported upstream, and can be
> enabled when fixed.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Harrison Mutai <harrison.mutai@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: nd <nd@arm.com>
> Cc: Manish Pandey <Manish.Pandey2@arm.com>
> ---
>   .azure-pipelines.yml    | 13 +++++++++++++
>   .gitlab-ci.yml          | 23 +++++++++++++++++++++++
>   tools/docker/Dockerfile | 17 +++++++++++++----
>   3 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index cb787d32f142..0a9f7b508ddd 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -307,6 +307,13 @@ stages:
>                 /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
>                 /opt/coreboot/cbfstool \${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f \${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
>             fi
> +          # If we have TF-A binaries, we need to use them.
> +          if [[ -d /opt/tf-a/"\${TEST_PY_BD}" ]]; then
> +            cp /opt/tf-a/"\${TEST_PY_BD}"/fip.bin /opt/tf-a/"\${TEST_PY_BD}"/bl1.bin /tmp;
> +            export fip=/tmp/fip.bin;
> +            export bl1=/tmp/bl1.bin;
> +            export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:\${PATH};
> +          fi
>             export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
>             export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
>             # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
> @@ -428,6 +435,12 @@ stages:
>             TEST_PY_BD: "vexpress_ca9x4"
>             TEST_PY_ID: "--id qemu"
>             TEST_PY_TEST_SPEC: "not sleep"
> +        vexpress_fvp:
> +          TEST_PY_BD: "vexpress_fvp"
> +          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +        vexpress_fvp_bloblist:
> +          TEST_PY_BD: "vexpress_fvp_bloblist"
> +          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
>           integratorcp_cm926ejs:
>             TEST_PY_BD: "integratorcp_cm926ejs"
>             TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 5f3418e482fe..0268938fea99 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -96,6 +96,13 @@ stages:
>           /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom remove -n fallback/payload;
>           /opt/coreboot/cbfstool ${UBOOT_TRAVIS_BUILD_DIR}/coreboot.rom add-flat-binary -f ${UBOOT_TRAVIS_BUILD_DIR}/u-boot.bin -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000;
>         fi
> +    # If we have TF-A binaries, we need to use them.
> +    - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> +        cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_BD}"/bl1.bin /tmp/;
> +        export fip=/tmp/fip.bin;
> +        export bl1=/tmp/bl1.bin;
> +        export PATH=/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3:${PATH};
> +      fi
>       # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
>       - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
>         export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
> @@ -504,6 +511,22 @@ sifive_unleashed_spi-nor test.py:
>       TEST_PY_ID: "--id spi-nor_qemu"
>     <<: *buildman_and_testpy_dfn
>   
> +vexpress_fvp test.py:
> +  variables:
> +    TEST_PY_BD: "vexpress_fvp"
> +    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +  tags:
> +    - ${DEFAULT_AMD64_TAG}
> +  <<: *buildman_and_testpy_dfn
> +
> +vexpress_fvp_bloblist test.py:
> +  variables:
> +    TEST_PY_BD: "vexpress_fvp_bloblist"
> +    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
> +  tags:
> +    - ${DEFAULT_AMD64_TAG}
> +  <<: *buildman_and_testpy_dfn
> +
>   xilinx_zynq_virt test.py:
>     variables:
>       TEST_PY_BD: "xilinx_zynq_virt"
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index be46135d6a52..37076de01011 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -90,6 +90,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
>   	help2man \
>   	iasl \
>   	imagemagick \
> +	inetutils-telnet \
>   	iputils-ping \
>   	libconfuse-dev \
>   	libgit2-dev \
> @@ -233,10 +234,18 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
>   RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
>   	cd /tmp/tf-a/ && \
>   	git checkout v2.12.0 && \
> -	cd tools/fiptool && \
> -	make -j$(nproc) && \
> -	mkdir -p /usr/local/bin && \
> -	cp fiptool /usr/local/bin && \
> +	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +		PLAT=fvp BL33=/dev/null -j$(nproc) all fip && \
> +	mkdir -p /usr/local/bin /opt/tf-a/vexpress_fvp && \
> +	cp tools/fiptool/fiptool /usr/local/bin && \
> +	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
> +		/opt/tf-a/vexpress_fvp/ && \
> +	rm -rf build/fvp && \
> +	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> +		PLAT=fvp BL33=/dev/null TRANSFER_LIST=1 -j$(nproc) all fip && \
> +	mkdir -p /opt/tf-a/vexpress_fvp_bloblist && \
> +	cp build/fvp/release/fip.bin build/fvp/release/bl1.bin \
> +		/opt/tf-a/vexpress_fvp_bloblist/ && \
>   	rm -rf /tmp/tf-a
>   
>   # Download the Arm Architecture FVP platform. This file is double compressed.

LGTM - thanks!

Reviewed-by: Harrison Mutai <harrison.mutai@arm.com>
