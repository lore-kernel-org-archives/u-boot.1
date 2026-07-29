Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF10C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E1940B75;
	Wed, 29 Jul 2026 10:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uv6H6w6UbSKX; Wed, 29 Jul 2026 10:42:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 823EA40AFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785321762;
	bh=/b59QBx8RpyoMX74BOpMbLL4wy4yib+UObe03EZj0lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7122OAXcwODtiBHj94A7nbhnz2JXrAVVr2UNWhQVKY/lJZExO4QV74ZL3HTvltEN
	 FomWDB6P8c7gr34IZuRLjxnLtKAiUr/bnPb0MuSFqOir3Jis8MLvoV/dSxhoHGz0//
	 La3l96VCH3S56hCf3eV1T14HXtrx0/Wf6aCKsXkF5sZSMFIGcczTm6gw6dLLvREiXT
	 MjtMZHzkOh1t1SziKa4T5v2fSZDvEcGzZlqom9eHyoCUn4lV5um/WR5gk663DYPZkW
	 OqaFgSDTjIMSiJEMPtj5bt93c4kfU/KV8FJa3rbKIYIaIGP1CJUE+fdLM/fLNmJztO
	 CVSRZ/+zb986w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 823EA40AFE;
	Wed, 29 Jul 2026 10:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0784245B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E788E8118B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:42:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Df4nducPjspv for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:42:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5A18981091
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A18981091
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A18981091
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:42:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABAA08493F; Wed, 29 Jul 2026 12:42:35 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BF8803F6
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 12:42:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEsaYSJFh+kZubySa2QYld0+HIYS8vRLdSfHO3R9IScRL3xTBpaEcgVsDFwsIps+B/ciHTbRRK3Ad4sz0AgIe5LdDjS02smX1Q7GDU7IcYXIeSniSaOghGPZZXy0DvL8mrpunR9DECSUbH9FR3Y2O0UDUDUCDYM5P8ckvoY5k8X5vQde903RLzVHGQAQw1AP6zVY98mv29+YiBHvLVwk1+V6+2hm0di569/E8ccoywm15rpRjZ3RmyaFLYw6DaPSMwhggIQkfV5HVNNXAx3H/lkyTHopNtfbKMhf2LY9Ilmh3yPpei/bU3ZXQMEs6YQEfBlxkVxEOl+mWni1DNC44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b59QBx8RpyoMX74BOpMbLL4wy4yib+UObe03EZj0lo=;
 b=dTL/BwV2YNCR6YjjJw+LZAbK/f/Q6AiaR6zt3G25oWD7Ln3ogqBAnagHLeiUrizOCUacgYmFOmdTnB0vMQxcLv2vTxHWyZCkzE2XB7ITps1jA25v/SrnHy6cB/nd9UGrddAwke1uxgLfNixMx7M6uH43eJ9xKN/Sq5H042oRms9DIw+m6HDtJC/B3tt66DK0I1VaBTleofw2b9kLL9Ge0ALNFZquruzOC8GFVMu2R3CDZHM7u3Knd5wfbGmjA4KyfvrkHaNpxT4trpywKzcqB8caX/AqcG1Fx5y71/8aIea+DlBPCSTjd145ry0YqWN4JWV1cCGukTtPHp7xWS+BfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB8307.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:42:31 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 10:42:30 +0000
Message-ID: <37b6996f-f0bf-438a-b96a-1d2d74ec8d9f@cherry.de>
Date: Wed, 29 Jul 2026 12:42:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fdt: Fix phandles not copying when using templates
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Moteen Shah <m-shah@ti.com>
References: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0097.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: b10bc192-bdf6-4b1a-c0e3-08deed5e1745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: yvjYRVmEYENScnlzquaGxGHF9iTQtIZJQPaPMWFzJFDgNc2aUcqJn+drI7yfeAwILfVK7CcbIrozXk9o6No4vMTMELwJYwHFtFo+XtgatFGQGIr9VTEb8oIONXI3SDQ4mbwhZsGVt00oWECpoViiomEmswIVtJN5tzVk9nDIS9SY9bP2F/QpY0b26MzTl0D8GL0Ljltqzy+LKn3wFdGP+PEGI7XRqzUSz62xfH/tMS4uu8s4ZWsLA4/1yyQb+OmP1hGTiAfxK+wTJ7YglpjJ3EMzqii7JK6g+bvZYksLzY0ma6G7myesBzyIT/3V/dpRjBNDOyo+mtSlVnVDYfheit085qNRRShDQZxkfWdUrhrMbrf2pSqm5njWZ66Gi7tBpU2d6/RB32qj5NZKkGMjHc9kNYzbxU54chZ8yl4nrTcy4eX08jeQRUOjA8ndSSe5kdqGjhmoNFeYMZdkY9j9rTo4lkV7wGBp1SU7C4OzDs2GranwDNI8k5jMpK6KpTMxSAVZBtwivCHM9wUYNESbFCEwWGf9lHJ7CQ99dp0zAUhOYoJSmFxJhW1SM+VVqFbPtGlRvStj55b6g/U4Zvr/GWEXvjW+BE5LVx2s9tYdZI2cGWVo/VLLEDzXKso+lE+5dsHc8PPKvwKl+UyJtaUeiEkuzA0tgH70FA1WEnPrY0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhnLzdSdUZ5MUdIenozaXEraitDZVE3QzVZZzVVMnVhZHIxWS84dVJ5dUF2?=
 =?utf-8?B?VGhuR3JoWGE2dlNPSnRUcjhMOHROQW5sNklFMXhzaEFLbEEyVGNEY0RpYUFm?=
 =?utf-8?B?d09rRm1DMEVoWnRIZDRaaEhQTUNQUGhyejMrV2l6UFE0bTFOWHh2YjdMZ0dY?=
 =?utf-8?B?TDZac25oTHJpT2EvU1lZVGc1SUxJb09RYlNnQzk2ampySEwwZk9FOUN6OWFR?=
 =?utf-8?B?S2VvSUFKZHh5REl1aVFzUkNuTHppc2JvYXJLbDJVcXg5bzFCTE83VXN5ekFa?=
 =?utf-8?B?T0hiWU5KRWx6ZUc4NExPRlQ4dmhtS2ZKUE9uL0lTMXNQTEN1VnJLbXdOc1Vs?=
 =?utf-8?B?VmVGdzc5L2t1NnI0OW8yWWZqYUpSajErdmo0dUljVjlNWjlqa1RjRlpUdjgz?=
 =?utf-8?B?ekh2cG8xVVNLV3VZN0hmY3c0TUU1SzBKS2Z5R3hjeTB5MTFJSDBYZElDQTNt?=
 =?utf-8?B?SzZURFVkTTZlaVJhQVBqcWNQdEkrSGE5TGpZaVBneVIxNWlvWkh4dnFUZGV4?=
 =?utf-8?B?T2dmcUltb1RxajUyOTdUUlRyVGw1R2NSN2hpdlI0ODVDdUZUUDA1OWliYWlP?=
 =?utf-8?B?VWN1NjZnNFUxVUxmZk9HSWdORzhGdE9MZ2JzTmtjbEJSVVkxWVJqWWVaaHc4?=
 =?utf-8?B?Wm1LL2pUOCtZdnFseHRhQWFtWEhOVlFWWnNhTWJYUjdtYkxLSXR1SlVoMTRC?=
 =?utf-8?B?MDFUaHpIb1BLNlZ0OUVRTk1tYXpkbEcrSStDSlNOUVVHZ3kwUXlUekl0dS9o?=
 =?utf-8?B?cmgvcHpTNHg5eENWczVMN0dzTEFBMnpqK3RnVkNsbXB2SkhVb1UzV1U0QXI2?=
 =?utf-8?B?cGprU2dzQng4YnlKTCtLeUdOYVRsYjhLWUNwMjFFeWdyRDBwMHhUWFRyZFMw?=
 =?utf-8?B?Qkl2eThaSlpMeGlTdkdrUHJjYjFwdGdlcCtITFhsN2U0SlEwZUhEVGkxMFNp?=
 =?utf-8?B?cjZJVEdsdW5RYnBWcGdZQlJpVkxPeUZvVnRxeHd4YnVPN0F3djRkcENrKzVr?=
 =?utf-8?B?Nkx2enF3K3NLY2dxeTV4SDhxRmRDNFovcGZrZGdTakoyc3p5TUIvMTVpazFB?=
 =?utf-8?B?S2ljR2ljQTFqZmsvTGpZc3FwSzBQazFlMkhLemdBaDBvcWRnaFpBOG53U21m?=
 =?utf-8?B?ZVpVVlJKM0phQ0pIQ0N4bnRBMHRxbUJobzhoeXAzajB2V0NPZG1EbkFwdm00?=
 =?utf-8?B?eWJmeHh1TUx4ZU1reURKalcxc0FNZ0kxTHZHdWo5RkFtQnR4OSs1bWJlR1dD?=
 =?utf-8?B?aHJQbmpjQXRweVROZ05tSzRFWFA2NmtGR2Fqa0FNTGZScXBYMHUwUHhNR2tC?=
 =?utf-8?B?YnRNRFpVQk53UUwwcVlSWUYyQXhPUVFmTnpZdEJtcmZBTWJiZTVHdTAwSGM2?=
 =?utf-8?B?NEpuKzRJZWJZVk1vY0V0R3FEVVJkNFhRQ0NISU42b2s1a1VENkFFUmEwbG1r?=
 =?utf-8?B?L3pteVN2NmluM2RZZllSQjNHQ3RLbXphMWo3R1NoRnJhVjZHOFRRWEJBc0ds?=
 =?utf-8?B?NkdTeEROQ3FjVkNRYk0wUzNVcGpjREw3SnphZSs1cFlBQXJScURwQ29wcmxt?=
 =?utf-8?B?ZWdHL2lOYklaN1U1cWl3eDBzUnU3VkRwMWR6RUlYV3pGVjljL1EwMmROYkVH?=
 =?utf-8?B?VytBTUVsTDlYRW55VU5RQ0pYeEFlRlYrQnVmYUozc2ZnNEViWU5OelYyZDNT?=
 =?utf-8?B?VHUvL0pkVGp5QmxrakhYcjI5anE4bHVYZ1I3N2k4bDhONW5BRzM2OGZzSkps?=
 =?utf-8?B?bUtLcmIyVE9OM1FhVS91L1g4OXBEYTFUaDJXVzZ2Y2wrc2VRY1U1TVNiLzFT?=
 =?utf-8?B?TCtBKzNZSnBYNnM0bUhYRERBak5STUNTL3RmOThmTk1HRlYwc1pIcjN5MjBh?=
 =?utf-8?B?Uis5Q2RGS28wN2JmTmtMNWhpaW9sSGgzcjZ3bEI4MWJnVzhtTjVKTUhFdnpu?=
 =?utf-8?B?TkplQ2UvSFgvUVFVTlorNjlsNUdpMkVlYzQ5UnJsMzZBejBPVnc3M25jUDU0?=
 =?utf-8?B?dHVhZlIxTVBxdzN5YUIzYUkzcTJKNTFoeFJkckNvVEdKV3RxbGhpdjNnbG44?=
 =?utf-8?B?bUJrME9CaTk5WERrSUhUajRHSkFCekR5akN3NXhMOFZDNythVWlwT294VWFq?=
 =?utf-8?B?eXdnS1BGVlN6bDJVR0w3bGxLQnFCYTNQUlRrM1ZkTGVEL1RTdU1nRFZ2Q3VS?=
 =?utf-8?B?c0FCQnBoRTNPQy93Y1duWTNPbHlDMDRVYTU0TFFHMzFRampNcTFrKzJTOEZ3?=
 =?utf-8?B?U3cxcTJsMDNtNDROaXliYTU0TGZ5VTQzMUc3QkNnZUt1QlU3ZzNFZk5BeVBP?=
 =?utf-8?B?Z3RMaURmeTc3NW1WZkdMVHdTWWs4T2xrRUgwMERqVVF3b3EyQzQ3Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b10bc192-bdf6-4b1a-c0e3-08deed5e1745
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:42:30.7643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpZq3t8wvRKB0KVuSkgxCgBIBVgLhSX7e1HSd0Jdy3Wg+RXtpiBuFv5vKNRBOdAbDad/OyjobL+ltsXmZJkkF4OnGP+4nT8spSkdeRfwz1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8307
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b59QBx8RpyoMX74BOpMbLL4wy4yib+UObe03EZj0lo=;
 b=gN3R0OxYRxw6fijhLGTm0PoGY85C9XGHRl1u4MtGId/QkUc4PPEchJKBtbGZoLLWw0jPxXMgrqxmtz5vQLofonsi3F+dYh/QAhjM9UTCG6XuRBzpYhSiQYgUzuPi9tet39cM78QcG4kgi4d83+zWu0OMnF9MVNEPzMQGlyuEP7M=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gN3R0OxY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="gN3R0OxY"; 
 dkim-atps=neutral
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anshul,

On 7/29/26 12:24 PM, Anshul Dalal wrote:
> The phandles used inside a template are not copied to the node inserting
> the template, leading to a missing phandle error.
> 
> The following example can be used to reproduce the issue:
> 
> &binman {
>    some_template: template-0 {
>      ti-secure-rom {
>        content = <&some_data>;
>        keyfile = "some_key";
>      };
>      some_data: blob-ext {
>        optional;
>      };
>    };
>    output-bin {
>      insert-template = <&some_template>;
>    };
> };
> 

What happens if you insert the template *twice*.

e.g. have:

  &binman {
     some_template: template-0 {
       ti-secure-rom {
         content = <&some_data>;
         keyfile = "some_key";
       };
       some_data: blob-ext {
         optional;
       };
     };
     output-bin {
       insert-template = <&some_template>;
     };
     output-bin2 {
       insert-template = <&some_template>;
     };
  };

? Gut feeling is that this will fail to build because we now have the 
same label for two different nodes.

Cheers,
Quentin
