Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5675AC624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 09:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 958606086C;
	Wed,  2 Sep 2026 09:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BM1TLTG0JAjr; Wed,  2 Sep 2026 09:00:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339602;
	bh=M03fiVj9xcTGrCsosTexLp7eSMbL18kbNzIs420j6cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+hPemJedsiOSZ/W3gr5JC85HL6Yd8nAufQ6EXUX6W3n/uqZ5x73a+Vxzm095kGu8
	 2N0hr7xtfB+UvXvEzZPrkRbzLzYud5+lH1isKj88TDE5JVFZTmNeBNDBfkko8iLDU6
	 t8NmXyE2IUbpaYVOIvc8CT+Q5P7eLi2NPbaObeBav6Hxu8Gz7ycXYhQjpDlug8CTiA
	 LAQGfc9lhLd8zZ2qL+/vtNwnIkZQLzAZs6oyv5epPmeqZMJJsAF/NTC8FyKi8jwM9h
	 juVNOPjhetBVkDdSL+YmGz3tu4eZO2yhMdO4PcGyAfOgjL0RcWMwM36jG1e7tzErgG
	 OyimXsoTGXeOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79AD460860;
	Wed,  2 Sep 2026 09:00:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E8F5A2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA89940810
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOZO1nqhyHya for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 09:00:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=6gWRRQ2V
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 017C74080B
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:59:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYssfXkT7DCm8u7MWP5NiUt0x4Iqu3lo+nbG/RhbuBYJ5M+87KGmYFonI8fBMJ3qOtnwK/7Naz7vywEKvezrCN1+RCKplLWi9qsBHMV6mrNSNMubtmG+XUn83cSKUn/iwCBitM5jl75YbSmGuhEBBrHM5+svazALt09tRluDJq8ihhySBXoPO65PxfGHDIsLJaOmJi95n/ewVNrkfbsFGwsrG0KH3BkjMDrfAQUPY1eAjWH0Ok3KfRrjl2Xe6ynC63ZLbMFQ6eiLKr702bLrUZY0ROJgWlWWGmEsebC5hfLQAlDCmXjzniSoSCGYvc9TicczhriAsyg0Hew7BrW6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M03fiVj9xcTGrCsosTexLp7eSMbL18kbNzIs420j6cM=;
 b=B/EK1crjJXkhfBsqw8o/hFVXOq6H5rwEiSQ6div8tBEKzBQpTZ8YHRcXCluL25O05/gndTMFXmkf2k0BXUpK+V0VRzrG7pfZhVqBozCCc5nqbQUdlVJC2kGkuTW9Ywl0sN7QJJ88rzeXcASFucHoZhEtkqWpvc42PzMFOrSl//vAe+1ZKznqky6QNwmSc5JZpK11pN0mZNBq7advNXePVSnqNLt0Ah9InQ85TeIaK/rcGlCKQCLBbFNThYAjZ/lqRfxDFa++eYvkMfETpxFynvUJ31Tm5Lwf1G7l+FNMxz2jTHRDFyqo0Ff4ca+w0K9uJVIgoeaf44P/AVRbImCUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M03fiVj9xcTGrCsosTexLp7eSMbL18kbNzIs420j6cM=;
 b=6gWRRQ2VVR+IkcFlRxc08davWgpjVQmTDGvG55N5hLogTicMpUaahMfEjfODVyPVtOOEQ1FdY+RRl4uclf8L6YP3ZlS3XPmMjkBpueEun/4wC/VpkMAD21k95DoxKEtwaGNZaCXRzmrRux9fE8icLSTpHSmtku80B5yihaGQhpeEFS6+FkEsqpcbZV1gfPewm63cryCaGEo8IEVA1CCv6nZB3W5yLwJ6bt9mCsTIWC2zbOLQ73ZlJfh5h/AjycXbNSRb/jU86/iiN8r4J/0BVowAJpdZ8COuJS+r4nRkdoMUpoJHppMDhbFmovrBvGOzuNh+1r1xZMhteicPFZTBmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB10692.eurprd08.prod.outlook.com (2603:10a6:150:160::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:59:53 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:59:53 +0000
Message-ID: <4716de2e-50b9-4b2b-803d-74f9d33e3fcd@iopsys.eu>
Date: Wed, 2 Sep 2026 11:59:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] airoha: add support for Airoha AN7583 SoC
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
References: <20260821070345.138264-1-ansuelsmth@gmail.com>
 <20260902021814.GA1592625@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20260902021814.GA1592625@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB10692:EE_
X-MS-Office365-Filtering-Correlation-Id: a2660b8b-d7eb-4d8d-5cf6-08df08d08de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|4143699003|6133799003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: CFw+TqwJVsPbVzlyVWQ/l2COmkLG6o7XTgrxA2lWrUqBowTS4EhqsySChCppLGMncAYzcTZ4cjWusBUnxzjW+08LvbOZb0QL6hhU9oRezGvDPx+gdnK1eDsRwdXK2XSK3QKA/PUEo0wrSwW7gVyKjerovlE6+gybia8VrQm0kLAX9D0ln+fwPLu2cnN7FbEA5DUX2/yRXeK2/4sdrYYMgufeYi8mpcIysJvC4nS21g7eYRiOCh7RXD4r/EFfPmlrfn8IXOHOVqnyS1YcahE9cTNK/1PajfoL7igNE3+vP6+YN5uLtFE46PZ42vZwaUdgnxsqIxY5muZFV1qmSPhdC5+2pKJ19j6wNs9QvGLVmnXVisZBFLjyczO0fI7xzor6paKzTZyVp6E0Wg7uWzVzPqONiX1+c3Kjr/LCeaU5lHkDXqPhV0GAZmtt7Cl1TRUzf+tCYsw6sVjAoI/nVFBL8JdTVGx4qJrJN19RT/3ebpVWoNgexaQB6JonHyUCLBree9TIYQzfunFQRQ2JJipL6ARGwqvPbz8lbIN1ng0KPBECd0TQm1XhVxfXrhP9/ApUQR364unEjnaDBwENeMqdFtJZ2s0rFuhaUOEGLVS9hgSYm6uc8ZZB+/GPQjbLj+zkvFvWq9vtlWGr77w97d5f1qrj/JjocgzigMSxTHCpVG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(4143699003)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9PbHZ5Wm5TSDAyQW1BN2ozcUJyZzZHa1hEVDBmd3hJZ0lnWURpZUtYY0lK?=
 =?utf-8?B?aVB4TzFaVGpVMkxxaGxFK0VyQ0c5bW9yQXAyN1JhZ0lteStyTnMrMUJLQlhO?=
 =?utf-8?B?aGVYcm9TVVl4dnVKb1pQRWhVcjdwQ082dmRNM25DaG4yd2RGNDdRNXZuWEtQ?=
 =?utf-8?B?Yk9xQWxFK1JKMEg2UEJSWnhIcWYrY3ZyeUE3bFJGUXlRK2xjMm1pdlBSM1Ev?=
 =?utf-8?B?RHE1aUdoSzd2V1F6cFJpUHVaNmVjWEhENWFpS0lSOGcxL0tqVUpRaHUwUktU?=
 =?utf-8?B?cU9FaC8rby9PcGJ3Um03MzdHWXd0Z1VJcFFzWTZ2MUJOam5tQ3VXYzdLa1RN?=
 =?utf-8?B?K1A3TmEvSVFUMjdzL29PaHpQRFlMVThOYmU2MUZLZXorMnlnbzRtVTkrTUUr?=
 =?utf-8?B?dXZ6LytuSDY4UjBqSFFqSTZreUtlTHBvOGx5bWQyclRoSFVxSGliL3dRUmpT?=
 =?utf-8?B?QzJuSFczTlhxNmNmOUV0bHNJNklKMjFKWkFVZ3VPaFR4bW1pSW55SDRKb2k3?=
 =?utf-8?B?WE9qTzc3TG1tanBpRlNoem5RVTV6bU5nZm5wU2VSd0dmRGlrSURSRUdpeEJS?=
 =?utf-8?B?cXVZVFFhNnppaG4xaDU1Zm5PZitZOE9xVTVOZUR4L1hFZ0xrQ0kza3JhZEx6?=
 =?utf-8?B?TFN5SER1bC9pbHFsSm5aMGhjN1N2Q2c5cFhrL3NmeklWVi9EV3o2QTZhZytE?=
 =?utf-8?B?WGROMWxVdGFHWlIrbExZRGxmRVNJODUzY3RXY2VLZlhVMTFXdks4eUtxcXdy?=
 =?utf-8?B?MnZZSVBjLzkyZmtnTHBrdUV6bm4xVEp2QVFNR0xzcDc2NjRlQis5c1FTclFX?=
 =?utf-8?B?WkZ3Z3ZkNmFONVZxZ2NPa3BoZUc5bUhZdWQyOGRlemtxMUtESEMxM2VXZmRZ?=
 =?utf-8?B?WFpxeDFBN1NoRTRCTVJGQ1RHK0RDd1RXRStNcEh0ZkVZUmlNUUd2SXVRNkp1?=
 =?utf-8?B?aFE2TjNlV1U5Vk9wQkVTSFVBbFFDR0VwdUI5ZE9iWE1sam9BeDEvWWZhWXZx?=
 =?utf-8?B?YkdQRDRoSDZOVVZXY3pJUDZ5NzRkMkFFWHZITHFMaUNmc0tRblpmd0F1U1pY?=
 =?utf-8?B?czRBbDc1Tkg1dEovT0h0VThzN21RemFEZ21EWVMxTzR3TnZXNmFuZENaSEov?=
 =?utf-8?B?UW8rTkFTVUYxdmlhUE4yOHlBTDdhcDJKZlVMSFZZdlU4UVRTY3BqUWFVYkFj?=
 =?utf-8?B?bklkN0pjdE5UaTREWUxVWE1vb3BmU2VIQ3BOblE3Snk1UWZ1SG5tOUZ3cjNE?=
 =?utf-8?B?R0xNa1BNL2NwcDdXSkg2ZTFVQzFMNFlibHgvRDBndzZxVjJXbTNpUkwyQnJr?=
 =?utf-8?B?REc5YmhqN2M1akRVQWpXeXBwREpoQmpBNzFlQmU0SGtjZE9XZU5ZQXpsOURu?=
 =?utf-8?B?UEJDRWpsdkwrUnNXNTBYcHJuWEJuaUhPVTd1MUovS1ZTekk5R1ZMYmhxTU16?=
 =?utf-8?B?MkgyR2wvWFBUOWhDalFNbWV5UFVwZ0tsTlBlbmNRaFQwR1Y1T1hSN3VvZllH?=
 =?utf-8?B?VE1zNEZVdnpRVEpKdFIyc2FTbW42UzJzSnlWVW9lSytGSVhBanlqKzhxdnA0?=
 =?utf-8?B?TG96VCtPQ2thLzVESVZpNzh0VGM3VmdDeThqNHpjbjFOYVZiaEMxblZPR1BE?=
 =?utf-8?B?eDAreDd4dUZhcmJRT2ZwdmE4bDlGYnpZekFMWUhvdXJQUkhKMFZrSFBiejBy?=
 =?utf-8?B?cmRkTm1TWHR4QiswOTRVVVRQNzBlS0NoZjArenBrOXhKb0ZsL3FLaUFubk81?=
 =?utf-8?B?RENIdy9OT2xYc3VSK0lLZXYrbCtLem1CN29EeVJYK05yMDFQNk5ub2ZzZ0lm?=
 =?utf-8?B?eE1maWZMNHRVODdBNFdNUTNWUzVjZjdDaXlONTc5cUxTakJ0ek1heWczcUhp?=
 =?utf-8?B?dUZUSjhEOEN3aGY4blNnMnJCWUhwdTJ0d3BrWlNPcXhiOUhjeDhPay9MWExK?=
 =?utf-8?B?dVFZWFBBSnhkMnhIcEtSSDlrM3pNYlB4dys2K0xZMUpIMy9pUWg3TU01enFM?=
 =?utf-8?B?WHRNelNpZFlIY05zeVlkNXVraWUrUHhWMWNCYXNVT0tiOHlRbWozTHFEWDRp?=
 =?utf-8?B?eFl3NktJOGlES0FIOFJKZEVsYlNCNnBFbFphMlVNWitnL3I5ZEN4YmMzRHBU?=
 =?utf-8?B?dGVSVmFQbkMxRVVEenNwb01hbk1Zbkk5MVhEVGdpZ2kxVURKSkROTVh4cGZn?=
 =?utf-8?B?QkdLRFNWWjhQNGFsQWZ0UWJVeUVtZm5VdGpoU2ZRQ1JOZzFFOXBtRDFxMkJ6?=
 =?utf-8?B?aXBWNXRYbENwQVJkS0JDTU5aRklzUXhxNDNOTTE2WkthM0dGZWcydzJ2a3JC?=
 =?utf-8?B?MEpPajRxQXloZG9UcGM4RHMybjRxci92NDU4dzlkT25iZUFacERkK0hpMWUv?=
 =?utf-8?Q?HrIRUchzCwkfCqNo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a2660b8b-d7eb-4d8d-5cf6-08df08d08de1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:59:53.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvWfo4bbNDvtmc5ja+fF0kcnjDcAdD/4uzcobDkMtDMo1EP8utsysvOCJmtjFcecd31OzsW8KEDTU0i4W+x6wSZkraHX1KWRIDj3NwWdm7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10692
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

Tom, could you use

 
https://lore.kernel.org/u-boot/20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu/

instead of this patch?

The above patch series based on the same commit, but provides much more
complete an7583 support.
Changes from above patch:
 * fixed arch/arm/mach-airoha/an7583/init.c compilation issue
 * added an7583 specific helper needed for clk-airoha
 * patches for proper support of clk, reset, network

Regards,
Mikhail Kshevetskiy

On 9/2/26 05:18, Tom Rini wrote:
> On Fri, Aug 21, 2026 at 09:03:44AM +0200, Christian Marangi wrote:
>
>> Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
>> entry for the SoC, DTSI and initial config for it. Also add the code for
>> CPU and RAM initialization. Everything is mostly based on AN7581 that
>> share lots of common piece.
>>
>> Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>> Changes v2:
>> - Rebase on top of next
> I see:
>    aarch64:  +   an7583_evb
> +(an7583_evb) arch/arm/mach-airoha/an7583/init.c: In function 'dram_init_banksize':
> +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:26:15: error: 'struct bd_info' has no member named 'bi_dram'
> +(an7583_evb)    26 |         gd->bd->bi_dram[0].start = gd->ram_base;
> +(an7583_evb)       |               ^~
> +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:27:15: error: 'struct bd_info' has no member named 'bi_dram'
> +(an7583_evb)    27 |         gd->bd->bi_dram[0].size = get_effective_memsize();
> +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:30:23: error: 'struct bd_info' has no member named 'bi_dram'
> +(an7583_evb)    30 |                 gd->bd->bi_dram[1].start = gd->ram_base + SZ_2G;
> +(an7583_evb)       |                       ^~
> +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:31:23: error: 'struct bd_info' has no member named 'bi_dram'
> +(an7583_evb)    31 |                 gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
> +(an7583_evb) make[3]: *** [scripts/Makefile.build:272: arch/arm/mach-airoha/an7583/init.o] Error 1
> +(an7583_evb) make[2]: *** [scripts/Makefile.build:497: arch/arm/mach-airoha/an7583] Error 2
> +(an7583_evb) make[1]: *** [Makefile:2221: arch/arm/mach-airoha] Error 2
> +(an7583_evb) drivers/clk/airoha/clk-airoha.c:19:10: fatal error: asm/arch/scu-regmap.h: No such file or directory
> +(an7583_evb)    19 | #include <asm/arch/scu-regmap.h>
> +(an7583_evb)       |          ^~~~~~~~~~~~~~~~~~~~~~~
> +(an7583_evb) compilation terminated.
> +(an7583_evb) make[4]: *** [scripts/Makefile.build:272: drivers/clk/airoha/clk-airoha.o] Error 1
> +(an7583_evb) make[3]: *** [scripts/Makefile.build:497: drivers/clk/airoha] Error 2
> +(an7583_evb) make[2]: *** [scripts/Makefile.build:497: drivers/clk] Error 2
> +(an7583_evb) make[1]: *** [Makefile:2221: drivers] Error 2
> +(an7583_evb) make: *** [Makefile:189: __sub-make] Error 2
>     0    0    1 /1              an7583_evb
>
> When trying to build on current next, please look in to this, thanks.
>
