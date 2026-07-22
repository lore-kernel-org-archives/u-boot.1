Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8032C44536
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F2740A10;
	Thu, 23 Jul 2026 00:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EwrfOR2uyeB1; Thu, 23 Jul 2026 00:53:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BE8F40A95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767966;
	bh=YEUlBI66+4Wal/neZiOk8rKwhgZTpQvXlxqyXgC9+bk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iR5gfQQTlRJ7lcLMa9ifvBa8Dlk9GpHW/VW+7StbwmcikVY3grPd5F7wwDkCx3VNL
	 01LFOZ87raCUqBBX/rMeb6M1Hy9xCUcPjkNufADg0/7mgxnPqXIUnzKQyCwe000eQN
	 B6KXGFwU8RmdFcQRHXQh4S5n86Z+uqFdRpWTCfT64EhgArQ+vYHsfbj4GLEsuhsnOG
	 Le1NFkjnZVy6t+htk4Pc6eCjgWQO64FCoHB6gULeLQQU02OfphMpkCK+v+fktasKpZ
	 Nqj06FWSsan5nSYYf1oakfXkzzZFWKL3fTNmAd01disRp9jNNU7rIMRjUwlu0ZZ+mn
	 9vpN3gmnBh4mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BE8F40A95;
	Thu, 23 Jul 2026 00:52:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EC14390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3470580D88
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ut049zkMyxl3 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 13:20:35 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EBE3F80D83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBE3F80D83
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBE3F80D83
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:20:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1AC848BA; Wed, 22 Jul 2026 15:20:32 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D824803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:20:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdFgTG2vSH/14ksMyaEpRJdh2IhpebV94t+txM5MvcyAfd21LtvkNNo8R3tT1py0mA0IqQU1UHjW76Zm7oEapq33YqI7XR6OT/VgpGkLAcbaRwBbxBIuHcpSMRs58soN1IWh68OCJYKSxQY8O+dHc9mTrJrkhG8KCJYXpl4/fuXpwmGkfNaJOUjM/oXiCc7IkEYy33MNxbGd39uvT4jEuPjuoj1TK7sXYsiZ2X9AGeP5t9Tp/AQgBZTp/wsNy721WD1kVTXX8ODIgKMk15vMX8mmzlHPiAFq35CcDb1wCi9gAuHxQez4EFyuWEJwDYZs0cup+1RpvKee7DpZC8KFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEUlBI66+4Wal/neZiOk8rKwhgZTpQvXlxqyXgC9+bk=;
 b=G7d43ZJiEg3riikLXEUHy/NhfJhjVlPWCdgeSoq2l4YwjsHf3JyaItc5vGd5nE2ji7Xmz0ncAmrsava+93Ozier/lvGxdJ6sKIe315GInrowUP9i6LhU7Qh0n0TJEzMHtwiwfpvJrWrpqHzMYMaBIb48nooZoj3znt5ycsOkhYLpCcsYT/wyqBp78GjUefTtHwSeOpVdF2igUBPiEyLROxbVBrz0KYkvuDjpo0nJKbRvhoyDYVjsxnSwmltiy8gI+4PQRKDj0mvJqao6gx/NsNR2S3DRi8QhkQCprgf7r4vDGiyljX/YO7x5F2s+NNrlcZLeDanuj0HPJJKQXp9erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI2PR04MB10115.eurprd04.prod.outlook.com (2603:10a6:800:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 13:20:26 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 13:20:26 +0000
Message-ID: <bb1da758-b96b-44ec-9a6d-5409df103c07@cherry.de>
Date: Wed, 22 Jul 2026 15:20:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tools: binman: extend ti_secure_rom to handle op-tee
To: Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Swamil Jain
 <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>, Johan Jonker <jbx6244@gmail.com>,
 Apurva Nandan <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hrushikesh Salunke <h-salunke@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
 <20260717-am62lx-v1-2-b9830633afb8@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260717-am62lx-v1-2-b9830633afb8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI2PR04MB10115:EE_
X-MS-Office365-Filtering-Correlation-Id: 5606af1f-abd0-4dee-ff01-08dee7f3fe0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|6133799003|3023799007|4143699003|11063799006|56012099006|18002099003|22082099003|17002099007;
X-Microsoft-Antispam-Message-Info: Ahn6j+HC9TPs1LAazm/y1hLgHYGh4oYtdVqgU0Rso8H6PUf3K2s8suEmNYIRpes4IfTZSnSetCZfBiLzAvZYgKN4wWl2jlybwfn5TRmQvqa6np2BQVrOk9k62UWukAd4LPE6/iaDZEaR47MvI/qqSLuDYYvB4JAYtlqfSziTWNBt+UAMb+QTLWTGZq6i9pYLWndEQB5Ha/rI+MwIsnHSyGCoAeUALBgj/AX1C1+/na+luQqQgAO8oGo2wV7JUFqQ0qalB1YWJSuoznRz7AbKgzqBLQjOuu9a9UbeSC7pmtAtGmcgswiZ8CbSTXHESpR9VLBxDs06nxRWNOHxcFg/JY/quLp7fLUbnpreBpzw2x5RFGZxUB9atV7RdEnT9wTQhmLedFMBW6gZHpLHY/EOvARQVU9E4DB6aiO11BQMaG7fyo98UwE9F/NJL7VrYINoHrFnJUuXltgbK6IZKUqQgdVra/Eyl2gOewqfWp4nqybcb3pBTT/axOgr9WDTzLLwum2j0kS2WhuL4kPu3g9VPFWJq3X2//ofAsdRg5yVNaZmPxC7J+AzQNeQqiCif7mfMxSzIcaNtBmCmpalZnQfQeDjXW3W89G78ftPIB1VoGad3ueLHnHrKhy4ZG9i/UDytLrZyUOImcCvzGw6HbMKlSmy6lKMvoeblEy8Iv1/qgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(6133799003)(3023799007)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(17002099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlplblYxc0lpTDJ3MHZWWllnRHdudXpKbGlkeUxETXdOM3RVZm5JMWJkTnhQ?=
 =?utf-8?B?NDg3ZWwzd2Y3cDIyL1FLYnViTXplZmo3aFRpUTFXUm9xMkhsTXUzckdtRUll?=
 =?utf-8?B?RE5kK3ZlaGZDMzNQU3BNMVNIR1ROZ0xINXphZFVaaWtYL3ZXWlJwRXBsUWNw?=
 =?utf-8?B?RnZ3SmtoUnRJeHYyNlF5a1NBYUpWeTB4d0xoUjZ3RUJxY21DaXhCOFpRaUJv?=
 =?utf-8?B?aUpwaldHOElaRmRzZ2JGMTRRM2w3S01iWW04cUIrQ0RqR0NvWng5UFhpblkx?=
 =?utf-8?B?cEZwclAvOG5IaDdHTXl0eWJkdEhobFBVeTUyNUZDVzlONXMxTUlVRTl6ZWx6?=
 =?utf-8?B?d0VJRXpSbGJTa0c5SnhEZ0FwQitVVURmWFF5RjVKNGJkNlpYVjZpSjZ5Z1BR?=
 =?utf-8?B?czVQN3NzYXo1ZnU1dlRreVJJenIwMXJlMmRnQ0Fqa2o5Rlk5VS9rVTVLbjJi?=
 =?utf-8?B?Z1pPdUtsaFNBUitQSTBmdVF4R1Vmb3Nxb1MvcXlqZVdmMWpUWjYrRUo4c015?=
 =?utf-8?B?ajd2aFljOW5jem9iWU50bEYvcnd6YWxyblBXOEZpYVFxTjNvYlBWS2FjVlor?=
 =?utf-8?B?Yktyc0ZVUFplTGlsN0h5YVo5cjRQZjVtN1djT1liUTNpNUdDZmoyOTVBcUJ5?=
 =?utf-8?B?engwUlR2bUJ3WTUxRWhxVFpKd2ltZEVOaDRqeU9zRzVnbm4xRkUyRXVmUExH?=
 =?utf-8?B?ci9ydGRUKzVWeGV6QTlKYko4YTRKVGpSekExeE1LYkxPS3EyZ0tEU2tOanRV?=
 =?utf-8?B?Um02KzJoTDB1dUt6elJTRGc5TzhiTy80bkZxSEJVdklPMkVsdWtXSFB2dVc0?=
 =?utf-8?B?dXdZTW84YSt6eDNJZUoxR1lCb1VOcnY5S2tpWFJDTm9Oaklrb2xhTllENC96?=
 =?utf-8?B?Uit5emRFL1RDdkNiMUxKS3k3ZkhnbHJsV0lGbEJwRkJldFhnblZnbkVCRngx?=
 =?utf-8?B?NEF0Z3lmZ2NUTU1QL09Ybm9RR3ZoL3JYa0lnT1VVcjhSN0Z5ekYrZmlKak5D?=
 =?utf-8?B?Rm5GbnJQU0Q3L1I0d3VMdTN5N1Vkdm4wNTl0OUpEVTBIdUFvZ1RPV1NQTTF1?=
 =?utf-8?B?VU4wbEZLRzMycXZzZVFLVkR6c200cjAzdWtMWmFBb1RWKzhhK1NUcWt3L2ds?=
 =?utf-8?B?UXJlTWtiUjFoNTZQTVQzNnppeHRlZ212TUdoWjJnR01NdGFSK24yUVJjdnZI?=
 =?utf-8?B?c3U4Wm1Id3EyenZCUlY2bXVjWWZWNmJrNmgwOFhCZVBvUWJENXQ2cjk5dlE4?=
 =?utf-8?B?Qlg2R1ZJVkE3Y3c3eU9nYVhxeDREbTh1SzBZWDJZRzhSTUphZkFrZVZLTTg1?=
 =?utf-8?B?anU3YWZUOWxpYkt4ZGVCcWE2UysxYkIwSHgyaWVGTWxiMlQrYjFZbFZQQXll?=
 =?utf-8?B?VUlIcHhDTlc4NGVrVTJOaytjZktaMHZlb2syOVpCcUJWRTBIOGx6SmFJUzg5?=
 =?utf-8?B?QTJ2VnA4cEkraEpRVEl3b204K2xXZ3R5RXBiVVdJMGRiajBMeFpNMHVxUHNB?=
 =?utf-8?B?L0t2MmU4M0VZbDlFcVR1OGlqOVZvajBvaEM5Y01VSSszYm9HOVNqWThjSU1Q?=
 =?utf-8?B?MjEwKzdObmVRSmQ3cGVGcjh0ZGpuUUZzTy9zYWpONTVtRmRhSmZhQ1kzODlu?=
 =?utf-8?B?SDdZV3JBOVhqdHFrOUJnZ0tsL0JvOTdob29Nb3hyYTlNZlVCMDFwTFVTM1No?=
 =?utf-8?B?djdvMGpYV0pHZDJtT1NRMkNhZDJ1UEZqZG5ULzZXR0lMeEwzUkp0ZmI2N1lz?=
 =?utf-8?B?cFlUeUhyZ2RteWt1Qi9aNDIvSWQ4amFraDZ0MmxhYWFnZCtna2NwdXc4bFNm?=
 =?utf-8?B?Rkdid0ZPWlFFaENjQnRvN2VtTVhWV3QzVHJyc2o0c2Ywc3h6bG95OUhrQ0NQ?=
 =?utf-8?B?VXRaRVkvd3pBVXZFUzdTNlpDL0VVUjNWNjQzekhXRDBRZnppTWJybGhoNzlx?=
 =?utf-8?B?Q0dZNFQyR3NsWGZibkYybXdsMTlxZmFMaStJSjkrNWErUlViZXQxOERQZU9h?=
 =?utf-8?B?dzVoR2dicnlKNFlKUkhQY3gzWFU5T294eWRTUC9HTFlIa0lwTUphWEdyYi90?=
 =?utf-8?B?eDA4NFQ0elJ1TnhXQi9aOVpCVjE5OER4a2NEaElINWx4VUo0dzBYSjVkN2Fo?=
 =?utf-8?B?Y3EyNVBEcXVOeGpkTFVjOWNyMmQ1enJVaU9tYXBYVERCWis3M2UwVHVlWUtE?=
 =?utf-8?B?YXRtZ2c3RG1VWjNDMG1GN2E1OENIaTd5aElGTFM4czJETWlSNTNUdGNZMTVV?=
 =?utf-8?B?citTSUJjZW53TXh1ZTRCWE5sQWtVTmtOendXc1RHbXNwWnNxamtrclJnZGx1?=
 =?utf-8?B?WHZEOFFWdThHTWpjcGRoWmk5TXlmWjY3Uk0yOFBuZVJhai84dmFqQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5606af1f-abd0-4dee-ff01-08dee7f3fe0f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:20:26.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5fNkQlmiN8v4/qvgtiDbt2adkxH3h8AwfeLMDM41kCok8uQFi/H+jKKGBoK0f8UXsgwinlDgSd0h/KbIN0xes2/2wp4CFJ9fUSKQpFAGFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10115
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:44 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEUlBI66+4Wal/neZiOk8rKwhgZTpQvXlxqyXgC9+bk=;
 b=cyOFaVN439fmCpBoDmvdqIAGXn2tD5tW1e3txwrK4mHSGiww8Gc2BlwSacrk+49PmF6E1GQMsXMU5E3IdjvSSKepAjCKCgtFw76y4kLzQmDIZIq665Ytw7GhdeQlzZ+8MpYGn73zVz0DQbCeb0+mIEkpIcCEXqe2WwyJqe+ZWGw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=cyOFaVN4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="cyOFaVN4"; 
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

Hi Bryan,

On 7/18/26 1:23 AM, Bryan Brattlof wrote:
> Add an optional 'tee' entry to the x509 certificate template to include
> optee during the second (tispl) boot phase for the AM62L.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   tools/binman/btool/openssl.py       | 11 +++++++----
>   tools/binman/etype/ti_secure_rom.py | 32 +++++++++++++++++++++++++++++++-
>   tools/binman/etype/x509_cert.py     |  4 ++++
>   3 files changed, 42 insertions(+), 5 deletions(-)
> 

We need tests.

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index b26f087c4470..c4762f6ccee6 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -239,10 +239,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>       def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
>                     config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
>                     sysfw_inner_cert_ext_boot_sequence_string, dm_data_ext_boot_sequence_string,
> -                  imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
> -                  hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
> -                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
> -                  dm_data_ext_boot_block, bootcore_opts, debug):
> +                  tee_ext_boot_sequence_string, imagesize_sbl, hashval_sbl, load_addr_sysfw,
> +                  imagesize_sysfw, hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
> +                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block, dm_data_ext_boot_block,
> +                  tee_ext_boot_block, bootcore_opts, debug):
>           """Create a certificate
>   
>           Args:
> @@ -299,6 +299,7 @@ sbl=SEQUENCE:sbl
>   sysfw=SEQUENCE:sysfw
>   sysfw_data=SEQUENCE:sysfw_data
>   {sysfw_inner_cert_ext_boot_sequence_string}
> +{tee_ext_boot_sequence_string}
>   {dm_data_ext_boot_sequence_string}
>   
>   [sbl]
> @@ -340,6 +341,8 @@ coreDbgSecEn = INTEGER:0
>   
>   {sysfw_inner_cert_ext_boot_block}
>   
> +{tee_ext_boot_block}
> +
>   {dm_data_ext_boot_block}
>           ''', file=outf)
>           args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
> diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
> index 7e90c6559409..4e0c9d54bbc4 100644
> --- a/tools/binman/etype/ti_secure_rom.py
> +++ b/tools/binman/etype/ti_secure_rom.py
> @@ -80,6 +80,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
>               self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
>               if self.dm_data:
>                   self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
> +
> +        self.tee = fdt_util.GetBool(self._node, 'content-tee', False)
> +        if self.tee:
> +            self.load_addr_tee = fdt_util.GetInt(self._node, 'load-tee', 0x00000000)
> +

We need documentation for these new properties.

>           self.req_dist_name = {'C': 'US',
>                       'ST': 'TX',
>                       'L': 'Dallas',
> @@ -219,7 +224,32 @@ compSize = INTEGER:{imagesize_dm_data}
>   shaType  = OID:{self.sha_type}
>   shaValue = FORMAT:HEX,OCT:{hashval_dm_data}"""
>   
> -        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data
> +        # tee
> +        self.tee_ext_boot_sequence_string = ""
> +        self.tee_ext_boot_block = ""
> +        imagesize_tee = 0
> +        if self.tee:
> +            self.content = fdt_util.GetPhandleList(self._node, 'content-tee')
> +            input_data_tee = self.GetContents(required)
> +
> +            input_fname_tee = tools.get_output_filename('input.%s' % uniq)
> +            tools.write_file(input_fname_tee, input_data_tee)
> +
> +            indata_tee = tools.read_file(input_fname_tee)
> +            hashval_tee = hashlib.sha512(indata_tee).hexdigest()
> +            imagesize_tee = len(indata_tee)
> +            self.num_comps += 1
> +            self.tee_ext_boot_sequence_string = "tee=SEQUENCE:tee"
> +            self.tee_ext_boot_block = f"""[tee]
> +compType = INTEGER:17
> +bootCore = INTEGER:16
> +compOpts = INTEGER:0
> +destAddr = FORMAT:HEX,OCT:{self.load_addr_tee:08x}
> +compSize = INTEGER:{imagesize_tee}
> +shaType  = OID:{self.sha_type}
> +shaValue = FORMAT:HEX,OCT:{hashval_tee}"""
> +
> +        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data + imagesize_tee
>           return super().GetCertificate(required=required, type='rom-combined')
>   
>       def GetCertificate(self, required):
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index b6e8b0b4fb09..79b7b37baee7 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -41,6 +41,7 @@ class Entry_x509_cert(Entry_collection):
>           self.num_comps = None
>           self.sysfw_inner_cert_ext_boot_sequence_string = None
>           self.dm_data_ext_boot_sequence_string = None
> +        self.tee_ext_boot_sequence_string = None
>           self.imagesize_sbl = None
>           self.hashval_sbl = None
>           self.load_addr_sysfw = None
> @@ -51,6 +52,7 @@ class Entry_x509_cert(Entry_collection):
>           self.hashval_sysfw_data = None
>           self.sysfw_inner_cert_ext_boot_block = None
>           self.dm_data_ext_boot_block = None
> +        self.tee_ext_boot_block = None
>           self.firewall_cert_data = None
>           self.debug = False
>   
> @@ -132,6 +134,7 @@ class Entry_x509_cert(Entry_collection):
>                   num_comps=self.num_comps,
>                   sysfw_inner_cert_ext_boot_sequence_string=self.sysfw_inner_cert_ext_boot_sequence_string,
>                   dm_data_ext_boot_sequence_string=self.dm_data_ext_boot_sequence_string,
> +                tee_ext_boot_sequence_string=self.tee_ext_boot_sequence_string,
>                   imagesize_sbl=self.imagesize_sbl,
>                   hashval_sbl=self.hashval_sbl,
>                   load_addr_sysfw=self.load_addr_sysfw,
> @@ -142,6 +145,7 @@ class Entry_x509_cert(Entry_collection):
>                   hashval_sysfw_data=self.hashval_sysfw_data,
>                   sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
>                   dm_data_ext_boot_block=self.dm_data_ext_boot_block,
> +                tee_ext_boot_block=self.tee_ext_boot_block,
>                   bootcore_opts=self.bootcore_opts,
>                   debug=self.debug
>               )
> 

Honestly, I'm not sure what we're doing with the Entry_x509_cert is 
correct... I particularly dislike the type argument to GetCertificate(). 
It's like we somehow tried to make a generic class but we're putting 
TI-specific things in there. I think we should move the TI-specific 
certificate types to tools/binman/etype/ti_secure.py and 
tools/binman/etype/ti_secure_rom.py instead and override 
GetCertificate() from x509 class in those files. Then don't call 
super().GetCertificate(). Or if the 20 lines we would spare in 
GetCertificate() are really important to share, have them in other 
functions and make GetCertificate() from x509 class and your TI classes 
call them. I don't think this needs to be a blocker for this series, but 
I think it'd be nice to implement in follow-up patches.

Cheers,
Quentin
