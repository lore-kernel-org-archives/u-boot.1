Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CC3C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B45C40874;
	Wed, 22 Jul 2026 14:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVoHvzg_S7W3; Wed, 22 Jul 2026 14:57:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5535540849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732254;
	bh=iUhZoRTnN+O1S6M6VwjrXS3hvkXHCklVXIqOuQve4ys=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YSZRFfsmDBOjxhKjAPtaFrMjwzvrgFpY5h+0ce8+1aIYyOkLYphF3IJaaJgwGkxrj
	 JZmqzfwvyKH7Q6bupM3Ujjs76UtGRoTOgmJccH4SgnV2Ht46/UsGx4KN3hmoyfVO4E
	 Kuvi5cdM1QlV3D6s5+hn3tGDYRBt8q+iLqelH9nHyVN0xQ8N5JTspH5yJL+/OBuhyv
	 bFTktXbdE1CihB1TRgeelceSZ9CPD+L7qdv/QXVmxmSx19kPSAsyVDPZAG+0pqn5eI
	 MMZleYnrI2cDp8UeJiCUN68R9jIAcOIQVYE7Ph+D6AdRWJ8oBnPwD2UrfLoFwuTVwt
	 NX0g+urpuo/hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5535540849;
	Wed, 22 Jul 2026 14:57:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC74C313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E1A1606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:57:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmjJKzA2abum for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:57:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 61D89607C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61D89607C0
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61D89607C0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOnmzb3yUNXDjV0O3pRF1OC7Qei0p1uPAmAbDRksvDuJTU6S9qdJRES09kCzVVtV2eFouE3RwafIUhYFEQIV6Ugd9ItJhXHR4Ry1KL0k3GloyJ4MXAf1ZTVieZkc+qoweri8bazY+SoY/pqfo8sJYrAVwR9MGA1oftNuQcgBCdufa2NXnarA5ePB69rSVd1RVfcDwaHPbnPjYSFuwjTmV/eUwOVZBxgXzE+10eBB0OwriwtJhzJtgVVeKUrBIoTf/AdfP3eRNjzRBTlkyNvy2yx8/4h95if8yKELV9o8GefainDJwi8l22rSVdGNP7uij+V/BfRm8I6UdF3rgmFaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUhZoRTnN+O1S6M6VwjrXS3hvkXHCklVXIqOuQve4ys=;
 b=wiF6Rv5EoLiDQnz4n+a0Gnt9wALmsM7mQR7LelS1mk/RbcXtg0Fg/X90aH+GLM6CaxDYOGGWs1Y0qS1AKQbqHnMqQpIRsiiJvIuSz4qok9xNe9cQgdseKIp0GAl8d0IW85MKN3mb7+VkdXhbao1Q8a4anJ7xmHoWABnH1QF7uxLkmuLysv86rqdV39omsixs3mIeWj/Dm/T86P+3MHW2ah7sKPjO8nhF5Xb8Ds+RzRy7RUSXabrGqZ/vKYf+dPZfvaQeyYQhe4/NzIdCqlvDK03zl/gia8YMLSwlLh78J+c/z8JWn3ZY5ev+O9r3t+ztBPd6U+Pk2u9QJmkur04+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU4PR04MB12110.eurprd04.prod.outlook.com (2603:10a6:10:63f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 14:57:26 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 14:57:26 +0000
Message-ID: <c33da7ff-d9ad-4d04-b2b6-2bd2b720d948@cherry.de>
Date: Wed, 22 Jul 2026 16:57:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rk3588s: Add support for ROC-PC-RK3588S
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722132728.1093856-1-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260722132728.1093856-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::20) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU4PR04MB12110:EE_
X-MS-Office365-Filtering-Correlation-Id: bd15ad56-f9ee-4d5c-e3c4-08dee8018b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vsjwPG2eNidtpdCpjvXwItekXbmgItQuEP0WmlftZvVbqomVEdBDx9UQTnFPbdshIXsB0Apqi8tTrxuuaZi7m3X/0N7+I+3N1PFR/Uk61PEcf1OdDVJ4B7nTcNfL4Fx8d1tYumSm9wHkR0hLBi/35R3OnNz7KFSP8qmQ+ISufJuARPSSicqvyGkVm2PObLgjPR56Gvnc0sMvjzT4A7SVwuhQ/E9qa6ZNRqgz3VQFmPq0+Bbj2RDpxbuw9qALJAcUUkAp6MTaCuY963IkvMzVqc7KySLzkOY2ck6unKGhRTzxslLvTsvzQkKLjBWwQShdVXY4u5UZr6erqXQ1+oAedj1XPF5kiLvsnP8CnNi7bpWGsTN9kCjcJC+QpsfjJ4cMYgvc3TRda3YX3nDY7PkBgS8eXs/DLLtnEBb4TH2oagVu3LWLDyZghQr59JbacYgp6vQiKsYr3sgnODWmLVU/B6Aavbt+2nCejgoz+q5SNZWrjYxZP/i6BRzVxIMS9hY1rSCbLFN2+O6mRnvH9CEW+iPjp96tMqnJWuCluewBGGyoIzEZR2CzDV0L2+GrU8ODbanPsKL6spuG9L0yM4hpA/fyBP9qCQLVRMuqa9VMgLMWumdh3ZNizjbS/o7v9yDnyNwcEP4Y1/4KlZjBRuLwEfjqHa4yweYjMcyLvDCnFk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlrMDlOUjZFY2pQb21rQlA1bmkvRmFJVmtYbFkyNUpvbXQ0dkxTWXJ6WEU0?=
 =?utf-8?B?U25EdmVmaUdNNU4rR0FVV0F2ZjAvVTFXUDhZb1c2SmszeUdaQVJIbnl2S3FN?=
 =?utf-8?B?VncyVTRBRGtYYXowYzQzTHJndEpKTmNwTW5LVDdHNU1BUTRvc0pxM3pDVVZl?=
 =?utf-8?B?enRUcXpiYUpxaGczYlJwTFZiUFdxL0FnemMzUmEwVmk4N043cVA4UGw4dFUv?=
 =?utf-8?B?WExUd3ZQY1VaNWEreVhXdXk5VWZXdk1ONVpzVlRsWTMzK1pCb3R0RFZpeHln?=
 =?utf-8?B?YnllQm1jbEw4aG5SMzJ3dkdnSVNFaDR2eWRFSkVzd2VJTGh6SkZkc2ZzR3hm?=
 =?utf-8?B?UWlJa1l5QkdIVEdWeG9Bd1dpckpFcW9FOUs1aTBQczZvN3J2Nm5WQkNtdkgv?=
 =?utf-8?B?TUJTaGhLQVdZcWJsVnB5T1JsMWJLQ1dkRlczN1hPMzd4NDZTcXJEVkNXS0NP?=
 =?utf-8?B?MlpkZWM4bzNEVkVKU0RlTldwZXg3UWpNekNubHE5MktRWEk0ZzBMZUpLRDdi?=
 =?utf-8?B?WXN0cGxKR3ovcDNLbmMrWEpMWGd0dlFBM1haN05ZUFpNMW5uNlIwZk9jRmpr?=
 =?utf-8?B?eUtZY1lVZlFlZVl1QUMveHpJM0Vvd3FvV2ZuWmZnREZoU0tKcmcxV2R2bWl3?=
 =?utf-8?B?ZjZZR1FJbGF6aVgrSzFJVHpVVFVCZjNHaUdSQzZ4NmprZHhpWmRQbWtQazY1?=
 =?utf-8?B?TVRvQzBsTmVYeFN6ZTZDWjVucy8yK0NzSGlUY1M0THJFbW9FcWtRUDF3OExk?=
 =?utf-8?B?VXdQY3E4V1R6cTRDVXhpQzJCVzlhaHhEMWRHZDZ3SmI5RUpjTjNOSzkxemI2?=
 =?utf-8?B?YjYxUjc5RDRvNDBJbUZENFJTRlZQTHpHeXdQMVpiaXg4QlRiUW1mRm9PRVUw?=
 =?utf-8?B?RmNrSDhiaWZtUTR0akVQVlVzTitWRmhERDlkSmFHb1dkL2FDZWlrNFVwdW5W?=
 =?utf-8?B?WnByK01FRHpwaytjd3JHUWRKaEIvNDZDRmZMRFluNStzUm92SjllMEVrWXMx?=
 =?utf-8?B?eWdwK256cFJjMllqTHZtWnllWEh4aGdVWG5hN1dLeFdRMXU5UXhQekRFaDJk?=
 =?utf-8?B?V0MwT0pXL2N6RDBuU2lYOEMvZjVDMWxYdzVHM21OeERsRG82ZlBHUDY2VXE1?=
 =?utf-8?B?aWFZZWlEZXZaVnpqOHFLUGoyQkZZaEVwb1BFcUhZekNKREtlNFFsUU9INFZP?=
 =?utf-8?B?b2pSL3c0UFE5dzhyYXN0b0RPQ3d3MzM1cmh2MlllVXpyK3pTQVdscitzMnNC?=
 =?utf-8?B?NUpNRk4rZ25MQnY1S3pxZGhjZUp4eG5USit5SVhDTU5zU09nTXFTVGFCWVRw?=
 =?utf-8?B?c2VrMk1HQk1UVWxQcVN5REg4MTBla2RwRmlyUmxtQ0Y3eEd3YUhEYTRyRVlJ?=
 =?utf-8?B?NVpLTTE0T0lpOU1mUU9Ma0JPSkdHZUswenlJUmNxSnFxdHV2cmMxcUl2NWR1?=
 =?utf-8?B?UE1oanlsdmdPbVhQNm8wc0VWbDNMbGJNSDA0TklRRTQ0dExyMnRlMXMvdmxR?=
 =?utf-8?B?VUI3bW5waS9scmVaV04yRFVVVURxbjFUc1E3Y0NaREhyelVzSERRdHNoclVO?=
 =?utf-8?B?YXBYcWtJRkduMVNIclBPTkMwWjRRRWc1bUxGRk9lUnVkNDUrSTE3OWxzbWJN?=
 =?utf-8?B?SzB3U3hVVmFoNGpyN0UwdTNmdzEwbHlRSlc3UGkxTXIxMitBOVNwcEZORFIw?=
 =?utf-8?B?RlRHbU1OUUovL1NQK2pSMUtBTmMvOWVHN2JISnpMSDdWenhWemZ2RnBQOENF?=
 =?utf-8?B?bkp3bnFiV2hTSGpmSDdGUmYxVDN5Z282TkpFaHh2c2N6Y2hIaUk1dS9TUXhj?=
 =?utf-8?B?di95NWpPMTl6KzJqMlY0OTFCNVd1UzRyaHUzajdSTFVDR3p6MUVSeWFIdWQz?=
 =?utf-8?B?aDVBMTdlTDlibG9lZzZrYWp2RTB0ckZES3ZUUUIvdlBPOG82ODhJRWN4MVRW?=
 =?utf-8?B?TlYwYUhhc2xmeVBqSFlaODVPU2JQdStXdEdOdEtYcGZIZ1ZyM01aUldrbGVK?=
 =?utf-8?B?N2czOGFxS1pRVnNQSGRWVmc0MEtzZDBOUVd1N0NDNnFLWXBOWk9RS2YwY0E2?=
 =?utf-8?B?R05PUjc1ZGx2SXgrNUthaWJpUXhZMkppTTA4QTlieWE1SHAzMFRtOSs2V1lv?=
 =?utf-8?B?SDJ6aWdzRUt3bFE3amdsUkpDRy85YUIwaWZmSnRJa1lROW5TcjVHZE1jaDFN?=
 =?utf-8?B?UW5jVXFkYkVrNVlDNXRSVjBSWlM0bExYYndkb1BIeUtLcDVCeVlPRGhLdEcr?=
 =?utf-8?B?Ynk2ZFk1S0NkWXJyVWtBQURuSjVCVCtNN2J4T2FPMU5xRGtnWGJCVmZzWlF2?=
 =?utf-8?B?NzB2OSsxMjJ0MitwTWd3SEJSb1hsOFJwWk1QUEVkcTh5UWtYK1BKQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd15ad56-f9ee-4d5c-e3c4-08dee8018b48
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 14:57:26.3697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVXzb0+dsrNII0wGiOasnbuUdBmg8RQX73/HEclkPdoQdiyhlMNxTGIEXT7JLAP1D8dEv5whTsceGsIvLOFToCD+Qv0dEizqUn1kfOxOWXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12110
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUhZoRTnN+O1S6M6VwjrXS3hvkXHCklVXIqOuQve4ys=;
 b=BnZR+u0xfE7vhVlDxAm+wqNK8yQwZI3NS7wcDgkH1yanyqXWYtP+71bomPDF+3NV/w2fmar2zPaCNOBsFEbhQVI2hAdCZ+2cEIb+e9mXAlHRlFtHySrsAJ/esm1MxKWsp1qNjTR5bkfbby/+cD9QPpGx779QGINUHFR1YxdYjiM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BnZR+u0x
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/22/26 3:27 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
> SoC.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Use the traditional environment offsets of 0x3f8000 and 0x400000.
> - Keep clock-names in the SPL device tree.
> - Drop CONFIG_RTL8169 as the onboard RTL8211F uses CONFIG_PHY_REALTEK.
> - Add the accepted upstream USB device-mode changes to
>    rk3588s-roc-pc-u-boot.dtsi pending the next devicetree-rebasing sync:
>    https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=for-next&id=9d1e32bfdda1aef3291e47c2949b3b9978162a5c
> 
>   arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi  | 13 ++++
>   arch/arm/mach-rockchip/rk3588/Kconfig    |  7 ++
>   board/firefly/roc-pc-rk3588s/Kconfig     | 12 ++++
>   board/firefly/roc-pc-rk3588s/MAINTAINERS |  7 ++
>   configs/roc-pc-rk3588s_defconfig         | 90 ++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst          |  1 +
>   include/configs/roc-pc-rk3588s.h         |  8 +++
>   7 files changed, 138 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
>   create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
>   create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
>   create mode 100644 configs/roc-pc-rk3588s_defconfig
>   create mode 100644 include/configs/roc-pc-rk3588s.h
> 
> diff --git a/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> new file mode 100644
> index 000000000000..7d97f64ec7a9
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&usb_host0_xhci {
> +	role-switch-default-mode = "peripheral";
> +	usb-role-switch;
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};

This is not fixing an important bug, so I would rather we wait for it to 
appear in devicetree-rebasing and then cherry-pick it (or wait for it to 
eventually make it to U-Boot during one of the dts/upstream sync in a 
few months).

Ideally, we shouldn't also enable drivers in the defconfig for things 
that aren't available (yet) in the Device Tree as to not mislead the 
user as to what's currently supported by U-Boot for this device. 
Dropping the above Deivce Tree changes would mean USBDP and OTG-related 
symbols would better be removed from the defconfig as well.

> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 675f13ab66d7..841ae490e85a 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -208,6 +208,12 @@ config TARGET_RK3588_NEU6
>   	  IO board and Neu6a needs to mount on top of this IO board in order to
>   	  create complete Edgeble Neural Compute Module 6B(Neu6B) IO platform.
>   
> +config TARGET_ROC_PC_RK3588S
> +	bool "Firefly ROC PC RK3588S"
> +	help
> +	  ROC-PC-RK3588S is a single board computer from Firefly
> +	  using the Rockchip RK3588S.
> +
>   config TARGET_ROCK5A_RK3588
>   	bool "Radxa ROCK5A RK3588 board"
>   	help
> @@ -421,6 +427,7 @@ config SYS_SOC
>   source "board/armsom/sige7-rk3588/Kconfig"
>   source "board/coolpi/genbook_cm5_rk3588/Kconfig"
>   source "board/edgeble/neural-compute-module-6/Kconfig"
> +source "board/firefly/roc-pc-rk3588s/Kconfig"
>   source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
> diff --git a/board/firefly/roc-pc-rk3588s/Kconfig b/board/firefly/roc-pc-rk3588s/Kconfig
> new file mode 100644
> index 000000000000..bded7a2fcba1
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROC_PC_RK3588S
> +
> +config SYS_BOARD
> +	default "roc-pc-rk3588s"
> +
> +config SYS_VENDOR
> +	default "firefly"
> +
> +config SYS_CONFIG_NAME
> +	default "roc-pc-rk3588s"
> +
> +endif
> diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..9a2bb4e69e89
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ROC-PC-RK3588S
> +M:	Fabio Estevam <festevam@nabladev.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3588s-roc-pc-u-boot.dtsi
> +F:	board/firefly/roc-pc-rk3588s/
> +F:	configs/roc-pc-rk3588s_defconfig
> +F:	include/configs/roc-pc-rk3588s.h
> diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
> new file mode 100644
> index 000000000000..0941c3c08236
> --- /dev/null
> +++ b/configs/roc-pc-rk3588s_defconfig
> @@ -0,0 +1,90 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_ENV_OFFSET=0x3F8000

Can you please use 0x3f8000 here (that is, lowercase f). It'll then 
match the default value we specify for Rockchip and not appear in the 
defconfig.

Please also use savedefconfig before sending upstream, 
CONFIG_SYS_HAS_NONCACHED_MEMORY cannot be y for example, as it depends 
on CONFIG_RTL8169=y, which we don't have anymore since v2.

The rest looks good to me, thanks!
Quentin
