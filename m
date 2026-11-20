Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325E4606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xln4tlao;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=DWqFbzaS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CBF560755;
	Fri, 20 Nov 2026 14:07:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H55-i4Skxvym; Fri, 20 Nov 2026 14:07:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A87E60B8C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795183665;
	b=Awaeq0LdjhP3GHcuW1HCKfQ4Y/zSaVedNIeCK1O20/ZtggzpEKc2mm8N3xYw4y4rCoiC
	 P4Uw32xhyZpDqdpdHTUFPDBa0xDNMsIEjSigpsCR9JWzdKKdFM5CXGHhVJpZUtvkRmPIb
	 d1L3fYu9uCGn617OCjHWRfEvT4BRNq3zvjDH7dVHJBZohuMhj8X5QPzez5/yk2Dmrx9Q2
	 T6U6gAr0hnRq0Pzjp0idm6HJ1ay6HkY0NbeEk6P9sIo2IwsYiyj8WnNdem2Zia2Cn1Sig
	 Jsr+oWqJHKLYToR060gavJzosKeNF/c80no9GSSocrvo1ZY3FMGB6OL1+J7kR1yto6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795183665;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JZCqFxl0uRPwQ6cOWjzqs6vneUDDqY8p/KsGvuoC400=;
	b=VGPdraa1xLMJCojstVwPrE4ZejwT4pPw+//akiz+P8iNRzB9F9Oz3A9hJ8LnMW3ky7uy
	 YbB0PR33kUG2ikmjFmPNJDMuThtQDclWb6KaQG5cLsmaJ2NvRZ6/CjyhC8gpIQnzuSAhF
	 5z1gryKVN6o+HNNHhdUQvc+nsKS7fDcU+h3FnuCmosib6I7rqAA/ZGuHIJrLO8s4hGnXQ
	 JhqSbDWvF8JKaehZCmHzmqS605xo7GueBuKDd17zQV/YyIoEEIdvfvhkffYSADXWCJBzQ
	 GJb4smfPdNC/3Ty6liDcQ/LxDdWgz6sBBx8zzivMwHeST2ao8eYJy7BSyIvHoofSchw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795183665;
	bh=JZCqFxl0uRPwQ6cOWjzqs6vneUDDqY8p/KsGvuoC400=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xln4tlaod0WIHuAkgaR0YfUbAJUadWO3ZsApUxEg0TW2i/25GdW7Z8frz9fqH5OLL
	 YspkW3bwDI/maKfIdFGmUQq7fwIPb4lNF7Xv6ekw7ybRZphR4Gl2UEOCzRo39IIYl5
	 5Dd9GBRodBUx1OWCeZ+gvLyLMjaC4eWWx5qUK9Zzj4PJoKDckdsq+of0Z4XIViodFn
	 Ny7SNq4X86/qNYVfnOLi4zswXJ3Eq24j7Qtb4+C26HV/iKPLuxtZhXjAl+tLsM/1LN
	 tUKxT3QEn6OudRhGYt2cR0fnA3dagcMoLpxXVHQhjUS2kAg4O2WhjhpI3dATX/828m
	 Gwh/u+rwezwFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A87E60B8C;
	Fri, 20 Nov 2026 14:07:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F7FCE52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4598640A31
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHWcaTVVzI9A for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 14:07:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3301D40208
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=DWqFbzaS
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3301D40208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZCqFxl0uRPwQ6cOWjzqs6vneUDDqY8p/KsGvuoC400=;
 b=DWqFbzaSkh6Obx9nicqWehKQvufVZE2sUAThFS0pLX4GoG3DCgprhzKvD/99jJQQq6ruxrQ5jAVBHGfbdQFN9U7PZkW78k2eBXs+d2D1BsKT8aMNFO4B3MSZnvPsp1ky62FiE3I5vBRgOuGrqGeHUZasvS1c/S544bjecfArMYQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB11275.eurprd04.prod.outlook.com (2603:10a6:800:296::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 14:07:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 14:07:32 +0000
Message-ID: <8b2556fc-7f00-41d0-a15a-e093190fc2d2@cherry.de>
Date: Fri, 20 Nov 2026 15:07:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] arm: dts: rk3399-pinephone-pro: Enable USB port
 (peripheral mode)
To: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>,
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
 <20261011-b4-pinephone-pro-defconfig-v2-1-6b7be35fbee7@protonmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-1-6b7be35fbee7@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB11275:EE_
X-MS-Office365-Filtering-Correlation-Id: 387e96e9-8f2d-46ec-f4dd-08df470f9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: OqBNlItYkszm8/V3CM8TKR0bpAncnIfkr6jg5ADkD5TuZZJl8GhB6MdHwB35Q/L3SOLAnV3f3PBa1QKERQtn7USGo6i3EvdSwyrQEOSK7mXDcoiNTN6vT/mauFMLAWKFi/GY3ZDw53wYWv0cRAlvyerA5W60vE7Q9keE6erK5JSNZ7q2YJoEVGDF1ZA8ecjFTzYHD4Z9eb+4MKxtPCp1ejKRxzGmFbzx1R9QhjkTW5bGgcZKKzq2Fdi2t1uxuFvERvF5cyLt6sjFv9cJ85vCtmLvlzvc82VVX7eMWtJ2mdI7xn3iaWKNkGH9fOfbzDJV8MawA4/u0NZ/f8QgCjxorUHPluDUQeseckSDRMDWv5Z8zTIWBlbv6NWvaeaQEmfFhSiGpz6a3PW0N0dzUVdXRua1sqQSzAoRKxZJJcDrDr8NJkWSR4CrXG9PKmsOiyroSisElIH84RFHzbIbkSG0AeGC2iys93CpKekvyvcY29NGYv9asoICwRVI0UtTnC7wJJyhjb4DlAsLfcs7cxNdN33vM7HwA1v7mK57uQ+goL4wOJs0TN9kK3jJLcGThhrMXV/Z0XLcp27MQBWfi/bm7EAmKpunyRMe7yfx3Ws/5dV15GGAxGJucodocIANooNP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdmQks5cEdTbERoeHkxL2dyaFdGOTF5VUErMmtYQmpyM0htUVVDdXRGYm5E?=
 =?utf-8?B?dndaL2RvY0xHZVNSa3VUY3lCYzFUd2dka1o0ZXNwajRZeWQ0RzZYVENUbjRO?=
 =?utf-8?B?N1VYekV2NXgrTitDUFJqRGx3MFNiQTAwb1JzNnpJSXFUeEZlVEVjNkNTSnQw?=
 =?utf-8?B?TTRXRDd0em5BcUdBK0NQTFBER0NwSUNnVXRDQ0UzeUdIUHR1THBlWmwzVUFt?=
 =?utf-8?B?VmRVUE1RZ3M5MC9KbC94OW0weWFJLy81cCtaem1nTmtuMjUya2ZueTh3NnBO?=
 =?utf-8?B?UXlrUjkvMkJMN2QzSk1qU1RvVnE2R1U1aURDcTlYZlZpa0NjSW1pSzZ6ZENN?=
 =?utf-8?B?Q2R5c2lad2Npb1drS3lsRTc1a3Eyd0RNb3kxUmNVc1VNNGRnNTVZSHl1ckU5?=
 =?utf-8?B?Q2FOTlNZY3A5UWJ3dDMxVFkvZktJcXp2aTBWenZGUnQyVTRRdzVTWUxkeW5k?=
 =?utf-8?B?aWt1ZnFBckJsd2toZGYrTlBKQXBWZUVSd2gzU3dQT2RMR0lWcHM4ckdLOVAr?=
 =?utf-8?B?QklKUXYvNVR5Sk5lalF1NVRhenBTdWZmSCtiZStqc24zN3ZuSDBiRDU4M01s?=
 =?utf-8?B?ODMzMHRIWTJPSFJFZUx6NHN2eE0vMmM4aHZ4WDhETFZUd1dvYWRFYksvVkdO?=
 =?utf-8?B?WmxKQjlTM2dxb1lGN0JraFVtQXo3eFdGT2JwZm82RW12MmRLWS9EWk01THlC?=
 =?utf-8?B?VVEvaDh6UHAyUm5yei92OFlJK21oTnE0QWlhVnE1cldJUU52WGF2MEJlQ1Q0?=
 =?utf-8?B?NDZBci9VaXZTRzNDQjBTRWZQakd6TUV1cHYxa0NOdndLR2dvY1V6dDR2YUY2?=
 =?utf-8?B?OXJTU2p6ekRha1NWUFZtZHZQR3NCbk5NUjFVUWNtRmtXR29sbURqVzVrKy9M?=
 =?utf-8?B?Q3BOTjZYSHRQekRxd1JmQkpTbVVDWGVGY1REVmRkMHVKbEtEcnBXaCtrVDlp?=
 =?utf-8?B?UmVSMUs5QU5GQkk3VkdUb1VSbEdIOXQ2SjBHYmlPeGlZL1Nyc2l4NmxmeFAx?=
 =?utf-8?B?SWVOQnFhUWplL3NHbS9SbkFJWmxOeTJHUDhmTjIzNmRtWmxWbk4yNmtOald3?=
 =?utf-8?B?UDFqMUUvbUVOWHBPUVZRY1M4TkNyMTVjeXRKa0U5VHQxU2l4eDAxMTJTWm5x?=
 =?utf-8?B?ZmF5cXAzVGtON0VMRlBDNC9JQUpDVG5RZHpoUTRYQlMvVG1HN3IvTnd2TXRu?=
 =?utf-8?B?cVY3SWtCdDdwN29MOWtGd2dZUnoyNnRGRmFuSzJVOFZjUWtTaXhTU21pMTRJ?=
 =?utf-8?B?eE0zR3RWcDJ5MDRJVE8yQXFsMTFyTTd6WGVJTzFaaWx2UVZzckptZzBPNjV0?=
 =?utf-8?B?TlErWFNVb2ZaOWdhdDBRdFdiVUVya2xVTWkybmFGVmZZMjF3amZCM3UzOFJP?=
 =?utf-8?B?WkQ3dFlKWEVuWTVzbEg1dkZzM1N1Y2V4c3Q1cnVSWHdzMnhmaTdYVU42emFD?=
 =?utf-8?B?WGd5cUlITk1rUHJnRE91bTdVWjFxcTE0MmxhSkhsckJZL1dNbkdFaEpzQkRM?=
 =?utf-8?B?ZXc2L1Z6b3VnZ0NhTjNRdzF3OFVENkc0a0F2VmNVbUhLSmYyZnlEWTIvVjhV?=
 =?utf-8?B?L3lzMncrZGg0YitCZ01hR2hyVXhqV2FrZ29zRTdDYXJtTC9HckhaWGRyKy9W?=
 =?utf-8?B?OG9WOE5DSTZNclY3U0pZZjNTYWpibzBaanBVTzkzRk85OVZCdzRpZVdtdEgr?=
 =?utf-8?B?TlJQNWlNeWF5bEx6eEFzVDFMazNaUW9xalNBVGwraTU2eUtyYmxIM3hsNDFC?=
 =?utf-8?B?c1dRQXl4MEhHbzhKMThYYjcvdHJ5eGJsWUVTcFhmNGJmYy90aFdjby9OcWhP?=
 =?utf-8?B?Z1V5YlFSOGxxOGMwY0wrZE41Q294VEl2cEczYmE5VkduUG5LYVZlOG1QalVr?=
 =?utf-8?B?OE5OTGZ5bGVzcW9sUGRXdThMNGhONFUrZWhkVmg3SDdJVFBFUG1FU2NNYklw?=
 =?utf-8?B?ME1UMDdHVEp2NnpzNVY3a1NHTnZmU01tUjN6T2xrNjZ6cm1NcHNxRHMwcGZn?=
 =?utf-8?B?a2kwaWhmSVptaFdkSU5xdDIyeFREVFdMc25XWi80NUFQMm1wY0ZKK1VmVlE4?=
 =?utf-8?B?OU83MzdUVHdxVVVIekV3dHdGeU40a21Cc2NsTjBxZXN6Z3Z5bEtScEJMdmFn?=
 =?utf-8?B?a0pwdUU1ZDhXa2thMHowc1ovODBYbWFxdFNrSnBLWGdxMFhEUW9yNVI3cnYw?=
 =?utf-8?B?YnF1WHlDMWp5VnZSUFZqTnppU2l0Qk1WNncvTGduQkt2UUpONVJKVEI4aEll?=
 =?utf-8?B?dU4wUTlJeVZpSld1bkJHOUlVdWxYWDByNUwzc1FKRHhvTW9KMUplcWxOZXJq?=
 =?utf-8?B?bEVpbGYvcUw2T3F0VWZWNC9OZWYvRVQ0SEx1My9Qb2RQZHYvNVMxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 387e96e9-8f2d-46ec-f4dd-08df470f9e79
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:07:32.1174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSYZeUuXQp9ZX9j5kc0jgIIORuCuIcmXB7o7zZvE2eKDC99pKyEO5CsdeIuDOtry1Y7y/JwMByWFEwHqmO3PrEKmYDLNwth3yk9LlLsavtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11275
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

On 10/11/26 9:35 PM, Petr Hodina via B4 Relay wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Enable the USB2 phy and set the direction as perhipheral.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Tested-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> index 7438bec4ee6..2825d43a9d8 100644
> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
> @@ -20,3 +20,24 @@
>   		bootph-some-ram;
>   	};
>   };
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	phys = <&u2phy0_otg>;
> +	phy-names = "usb2-phy";
> +	status = "okay";
> +};
> +
> +&usbdrd3_0 {
> +	status = "okay";
> +};
> +
> 

The Rockchip part of U-Boot doesn't accept changes to U-Boot Device Tree 
aside from U-Boot specific properties/nodes (bootph- properties, 
/chosen, DRAM config, and that's about it I believe) anymore. Please 
send those changes to the Linux kernel first, and cherry-pick them with

tools/update-subtree.sh pick dts <hash>

once they are available in 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/.

There's still some time (but not much) to send patches in time for 
7.5-rc1 early January so I would suggest to not wait too long here.

Cheers,
Quentin
