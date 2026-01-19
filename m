Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B492FCCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60D28397D;
	Mon, 19 Jan 2026 10:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VxNpz0jt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VxNpz0jt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A1D83956; Mon, 19 Jan 2026 10:29:54 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD4383956
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tHNjESdGm1e11Ed8+M58NcAv3LOZxjjRisdK/U8uW3QZ/OH5vBSTiB1JG1Udn4xeLQqf71ZKvYOCAenY65U9ZmTL1uI4Gw3ZSLf2t6RYLMOuJp8I5noowjbFAoGFbVt69uDrsETEGYwabGPAQh5TN+Dqkd2EStieTCqB0efo1C55vD9u7TpzeAdN6ynwewIFcaxEdFCf82MhTn3P5rb3FQBsp9QrZRWIMHjoc6KBbaDaixORkuuAF/pMMaF2at3Jy1gYha4PZ9u+yrnozQeQHLJb4kYBBq4JsrxrvsNFyuPI6G9e/QaErq4s+OpXdo41eWmVDVfRCp4TZnj92MISuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l++cktB1AnLbrr3J4TAyr5gzIPtIdz/P0fV5gEj3qW4=;
 b=YyKkcZiPSBgNHFhAIoLPsDY7sjLzSMQPfTIwaDRBbbASY2htBiG/1jsG30FP+ct2p+Z1/LeLj9mreVCGbhl47RMY36BeYcus6xYd2Pmpcf+/CC/cKhOSUfmhB+38Pil+QA4Zoj97sRRUwlShrBSkz4itT4uRq7Y4YSmg+m0c2uNHNqtoZaYPpCknxYBIu8rxP3L+um5mDcvTkv2NQRKcPwaD43xakWKpqTABzFOzn6Y4kkeq6qav7HDJKym2sblqqFJiaI/WvwfgqldvfaVwBNOMKnAWVvDvKplnMIX2CVju04VHLMm2ao5o8vUAgbFOiRMtFrpbXtsVcvSemxLe3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l++cktB1AnLbrr3J4TAyr5gzIPtIdz/P0fV5gEj3qW4=;
 b=VxNpz0jt+FazAfLWg1sRcRRchU2EHywKvyzHHyHwIAUhJjkq3G7UEMphB2WtcwLmlXNwa1OfzyNhZxFAOObTM0ppPcb4TaaVV3SYw1Un2CorAzDhQ2KIpkBreDLf1Cq7I1IDC45KqwoC3xU4spM6Jp8lrfPMl6blx3+GlEjyZvQ=
Received: from DUZPR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::8) by VI0PR08MB11798.eurprd08.prod.outlook.com
 (2603:10a6:800:316::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:29:44 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::4) by DUZPR01CA0100.outlook.office365.com
 (2603:10a6:10:4bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 09:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYtRsMFCNwYiI5D0mnOfRV6Mm9H61M0Dswic0i9VyB9iBplBJU3ZM0K7jzLUZi/MKGHTcueEULOFcu7HHb1CayjXIb704xk5NYfKwQ0+SjFB1uXmJCS/nzphZtZQemFnhcwnUxwh/b2ThFR/ghucHzsavok+093urbTbK7Yb5Sbmia+5xEMT5FJgkmvOnWcqf6HKl19CHrfWNitZ+AtVdw6dmztPB3Ts+ypBn5wNdGegfexvtU6xapc1qQLbmE4tVvQQMpdBi4LlfjoPPGbLAT0UChoL3o+AWBcumse9LhEej6o4T16ZirnvGgqewSuEds6232IPNm9cNPSrJf+2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l++cktB1AnLbrr3J4TAyr5gzIPtIdz/P0fV5gEj3qW4=;
 b=UwoQc0rLpBJ8Jm+7GzajQkGemeycIRgwjNkXb3xHbNFrguik82wszwaXdxoofmJNKS9U3vdjSl8/d8YJ+L2T3ssOTz2Xto+mWFdM5/a1/EIfaeh/tSbH7pM8Z0eXp+MTYhaS7ptx/z14V3Pbaawm9osXqY08doAI+FBITH5Tv5Ukco9whzHkbwW3hbkS8+bkwLgGIqhbQbDNzEj/Bp/dBwsV7mqDiJfRjnmSUciSCCC5V9To+mEQIJEBchiEEE04k/J5SlF2k1MooT/L8N7gzX9lM1xhmuXeiUy/BLik974SsqALqH1dXlVCvNrKRy9Nu+yapeWBKZlIDbUCzMFYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l++cktB1AnLbrr3J4TAyr5gzIPtIdz/P0fV5gEj3qW4=;
 b=VxNpz0jt+FazAfLWg1sRcRRchU2EHywKvyzHHyHwIAUhJjkq3G7UEMphB2WtcwLmlXNwa1OfzyNhZxFAOObTM0ppPcb4TaaVV3SYw1Un2CorAzDhQ2KIpkBreDLf1Cq7I1IDC45KqwoC3xU4spM6Jp8lrfPMl6blx3+GlEjyZvQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB7673.eurprd08.prod.outlook.com
 (2603:10a6:10:37c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:28:37 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:28:37 +0000
Message-ID: <2dc1e8c8-4374-4033-b464-298c3f1259ed@arm.com>
Date: Mon, 19 Jan 2026 10:28:36 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 2/6] net: lwip: nfs: Print device name based on current
 udevice
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-3-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260117002452.1026310-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB7673:EE_|DB1PEPF000509EC:EE_|VI0PR08MB11798:EE_
X-MS-Office365-Filtering-Correlation-Id: 782be8fc-0a57-4f69-6bd9-08de573d475a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VmJ1d0RGdTFiTXNZMXp1UHArOVgyaTRnckJqVThZaTlOc1FJem9abFdqZVpv?=
 =?utf-8?B?U1dxSVFndmNVTWIwZENBaEVYWVhuMmdlNE5uLzNmTCtOTXlMb21RM1NSdHR1?=
 =?utf-8?B?U0pmRC9mb2psbExMZDVYbnlmWDdxcFgvSUE1VTNMVXU4ZnBZOEVmK0dMSlpn?=
 =?utf-8?B?b00wcWRsQi91QTg3Y0M2S2ZucThMdVJ4R1FCTzdUbERpOWxONDRrUCtRd3ZE?=
 =?utf-8?B?eUlDQ0szeW5hcUNFbkVJZ3dpNStsYXU2eWV3VWM2OFhpVXdyazhscUtFbTlr?=
 =?utf-8?B?UHdoS05OOGxPU3JJeWxNUWJLNUtrSndsOHVOcHJ4ZXFjUWdOd2FldG15UWFO?=
 =?utf-8?B?QktnSFhtc3BLclJSNzZudTBNa0hxN2pPTlVZZHd0WGZsWm85b0lxUjNYNXBV?=
 =?utf-8?B?SmJ3MEVCdW1FZ1BuNS9MdXA5cDQ4ek4xMmZCaHVUenRKZUljTVBiUWZrSWZ1?=
 =?utf-8?B?czV0enBmQWRQVFFHMkdUckNSVUx0UU1OVDdXRzhtQmhrYkU0Zk13RkxWUjlx?=
 =?utf-8?B?Wk1INWFxYWhXOFBjeDU3Uy8vRHhlMExqNkFYL21SZkw1akhNOEwvNWxwSnpR?=
 =?utf-8?B?Z3VTSjhrMklEUytVT1VMM2R6aTNNY0xSOG9lRU00ZkZmMVU5YUZjc2F4Q294?=
 =?utf-8?B?cGZhZ0FQV0lxVEVJY3RZTzNXWW51ZXhNZ01yUjJIUzZKbm1ZaVd1YUR6UGl5?=
 =?utf-8?B?ZFJ6WUg5Zm1HNXhreG1pSjQzLzdkOGY2UDk3UGhJNWtiNjhpMFJBU0t6SFha?=
 =?utf-8?B?QkR4OFVhYjc5cENOYmJYZllmalkxc3RhQi9sejRqd2dOWVNQUjcwZnE0cVNh?=
 =?utf-8?B?V0pHWFJ4Q2UxQ0krdmh0Zjh0M3E0YzNYblZ3Q3VSTE1Dd2VjZytlTGdNbUxv?=
 =?utf-8?B?YTV2V3RVUUJYdnZWUU4vRXRTeHRyWGc2SVJpUXdtWGJGV0NQa1R2Z1Y1a2dm?=
 =?utf-8?B?Q2ovNmNQaXFBcDZlSWZkanBSQnMwR012VGkxdWtBWnQ0OEp6dW9CdFFpUnQ0?=
 =?utf-8?B?R0FkSFpPY3VxK25HRmVNVjdRcjhQbTFNeEx6MCtjVXlOZnFwSXVYTEJOeklt?=
 =?utf-8?B?SjlaWEtqdXFFb3B2ZUR4MHhOSjgzUEZIQjI3VVBMVmJ2Y0V1YzgrWXJtUlFI?=
 =?utf-8?B?dTRlclpoejNBZEdBd0JjVlJVQjFVdkVvUnNSRWVVcjFnSjB6UzZveHd0eWp5?=
 =?utf-8?B?U1RIZm1HTDdiRFRFaGpkNUxHaTI1eFhyQnJMN3hERmhpdm8zN1JvckgyYzFH?=
 =?utf-8?B?aVkzUjBPMmNvRHZKZmZNWXpwQ3NlZnl2RnRIeExDR21KcjVobDRQZExVdmlw?=
 =?utf-8?B?bXdDVWNEeUY0aEh1Rmh5V0ZkcXdWakloTSsrcmVjczdrd00wMS8wTlVmWlN0?=
 =?utf-8?B?ckM2Rm56YkRtR2RGSk92dkpSaXNBcGRzSHBNbzhGU2lnMENCUXh2V0dVRzFJ?=
 =?utf-8?B?TFRiNHhTVXRXeTRPWVpDVURwSGYwaWVHZldPZGs5YUU0clJ1dmY0NWRIejg5?=
 =?utf-8?B?SGIyL0lVYTFtNnF2empYcUtpcUR0Q2VRVktQQjl5K2tsVXJpSUcweDNXVHZS?=
 =?utf-8?B?blhKdENORmYvNTIva1J4bThZSkh3eDVCdTU5MG5tVTViSnNmUGRVUmlUUjNp?=
 =?utf-8?B?eU9BNllpb3NoY09FL0F5SDRoZlB4eGI1S0tYdDBjTVp0OUZxVXc5MllTbHdU?=
 =?utf-8?B?UFVPeFNNZW9lZU5GSFFtSDJISXBHYUZzdzNYbHV4OGtHQTI4T0VGaHczNExr?=
 =?utf-8?B?c2xUMzdqUjZ6UGw1YjZ1cW1MdTA0dTNLaXlyL1NEWjJ5M0J0T2svQ0ovQWtE?=
 =?utf-8?B?V296UnMvMXJVZXd5cjVZUTNJM2JUWTgvM2Z3Ty9xTFpFdVVkVzlxcjVpWG9G?=
 =?utf-8?B?V3FldVRZaW9HYVZBZURGTFYxcGp3Z2NMOCtnck0rZXI2NnVETFRxQVZQRXJD?=
 =?utf-8?B?UGhxOXpab2F3ZVlyUHRXVnhlMnhmUy9DOFkyVjRXUlpkUVJ2MnhGZ0h0eWdy?=
 =?utf-8?B?dG1pV0crMEcrYkR4U3lXZnppTHpIaUVEKzUxanQreWRJTXpoL2MrWEtFZjFU?=
 =?utf-8?B?d3VnQXJYdTZtU1F2OFl3allVd0xBVGlCL0FobWl3R1dUb3VubVNlOFY5Y09S?=
 =?utf-8?Q?U7jM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7673
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f2c9f9eb-3409-4a5c-3aff-08de573d1ff8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEVtUFRTRXBXU0hLMklyNkJWRGFCZnVUK25oTDJlL2VJRlc4ZEJINXI5eDdD?=
 =?utf-8?B?QUVSZG0zaDJJdHY4clQ4Q2RQdlZEK2VOVG5wL1Q5N1dGMUFHNEtTNTllYTFM?=
 =?utf-8?B?VXM4ZVM3THBDd2dieHZlbExuYm1DSFlud3IydXB0Q2tWRVNxc1AvSzN3cC8w?=
 =?utf-8?B?Y2hpTjg0RlB1ZXIrNzU5NmoreDZGaE1UODBFeTRKRlBURGhRWkNEdmZyWnFz?=
 =?utf-8?B?NlpOL0RqT2REVUtlSkRXb1l0WE5wZTc2QlI4aENSclJMdC9BQWNIdzA1L1lJ?=
 =?utf-8?B?UnVNS3BzV2tYZ200Z3Z0R3VGRy9vUVpOaGpydUJDQjBwUnB3ME9TQTJRTnRO?=
 =?utf-8?B?T3IwRk4rU2RBWFJwVDFKOXgyOGwzRWJOTFZ6Q2locDkxb1BsTVJoMnBmVDVG?=
 =?utf-8?B?cUJicGZGd01Ld1dVOUdZU3llYU1KSTZsSU8ycW94eWJBL0VDQmVrSGRjeWRJ?=
 =?utf-8?B?ZEE5NnRlelVodllNcldBaTNsbk5EVzlrOFByY2JreS9ESnM5d25NRDJlZ3Uz?=
 =?utf-8?B?L2x5K3diSGRYbGRPQ1RtUFNkeXB3ZWtwOVlVdUlaNjdycjh0akQvRmIrUGFP?=
 =?utf-8?B?OUkxbTNXRElwY2NwcCtKWThnancrUjlMMFc2NmgzTjZVd014ZXN3eWEwSmIv?=
 =?utf-8?B?SllERnZyaEJFazJuS05sdktCU1M2QVovaXdGZHRqeTBWK3RuOXlpS3lRVU14?=
 =?utf-8?B?cXlobkNIRkIwSGdsNUpHb0tKTEkvZHpaS2wvQXQzWTBvdkdzbUlmcTNWN3lO?=
 =?utf-8?B?dVgyNytWSGRVNDBIWjlmZlNScDFuYWpNNVUxOFdRVUo3UjBRcjBNOTF4MjFa?=
 =?utf-8?B?ZTh3L3pNTzV1d3J5V2dhY2tDQ3QrRVlaTVJNbTVRWGZKNGRIcUhIelhnUmlB?=
 =?utf-8?B?YUVNUXA0TWRlUWoxM1FNejhPYnlYdVIybGd5dlIwR1FTMmpSaTluT3JNeUVB?=
 =?utf-8?B?YWRoV1J1TGljbVo1a0h0dG9yNG15YzRyb0tLWnZRT1d6dVBqSkZoaUM1YkxT?=
 =?utf-8?B?MTd4ektodncvWk9qQ3hHYlRHcFhpdHpuelZnWDdWRGRjY2VkM1dhbVl1eENa?=
 =?utf-8?B?L2pjTmhUTDdQY01mbzhGQkU2MXVRTEtkQWVVWEEzcnJXaC9oaXlac3lGZnlQ?=
 =?utf-8?B?ZGZwVU1aWFZMVWtLYk45MnVXOTZqckRZTWRjaGRhQVVHYUV3Q2RFaFJsRjlE?=
 =?utf-8?B?dzMzajBvWEpEZU1MZStvRWJvZ0FJNkhNd3hPbXpBWFRpTjliZEhUdWtQdHFN?=
 =?utf-8?B?U3o3TEtLNk5oaGtvOXIxcnF1dGJKTHE3VjVNTGxaN2hxNEJDZUJtQk1TNURR?=
 =?utf-8?B?eFN2dHZvU0ltRktGaVdqdjVrekY5dGVjWVZnRDArUDF5VkJKNlJ0Q21vVGpQ?=
 =?utf-8?B?RTd1d1VxeFRSZ3p0RGVsOWR6WTZ3bnpWdWwzZERTWGozMnR0RmVFSTBQZlJV?=
 =?utf-8?B?Ty84ajZhK1pNa0hXUXhRNDJsTEdBZzhFRlZKNUlCOTl4NzVKdFVFUWJmeDhY?=
 =?utf-8?B?VWZ2VHdVMDI3UUZBOXByVktOZ3RkcDdwWEtNTU95akV3RmQ1d0ppQnlLL0l1?=
 =?utf-8?B?bFg1eiszREFndnZ0L3pjamxTbDg1aStTYzNTRUJyQVZNNmxWVmEzNDE3eGQv?=
 =?utf-8?B?cFRjZldPSW1GMGhySjBrdEdvZCtTKzlVblY4eWNkN1FGN1JMUGM4TDVGM2wx?=
 =?utf-8?B?SFJFZFBnZ0dhS0Fjd3NoVERkUDFQS2pEQzEwVTRVdjBKV25LZ3VtVzFwUC9G?=
 =?utf-8?B?UUpEclBuWXlEcVdNY2tHWU5yY3FVcTU4YWpHRDRXMnU4Wk1IZGprVFE3U3M5?=
 =?utf-8?B?K0lnVXdwdVF5RlRFUFNTQmN3YVIxL256aDdRNmJSdE1lUUJhbE1OekR1SDg4?=
 =?utf-8?B?WU9iUmIvYmtjajRGaERYQzhhSGJGUDRSdFZ6Z2FUVFNOckxZWmhiZDlWZXBu?=
 =?utf-8?B?eHhVMkJIWG1GcnJOMjZlOVA4L2dROHo5YXV5YlFYRUJ5ZC83bXJ1RytHYVlT?=
 =?utf-8?B?aHo2SVJqWEIxNFJLeFVxNWVoY2RUMCs4U29zZ2IzdjhlNlhibXZGMHB4K3M3?=
 =?utf-8?B?ZXNFUEw2aWIrSHAvTzNUeDY1clRNU1lTeFRxajlOcWZkN0o0OVBZcHdpQnZp?=
 =?utf-8?B?YkVKRVJ1VW85SmNIQ0RSM1dpbkNGaHJDR3JEOXB0clFTQ05zTnd4cSs1YU5v?=
 =?utf-8?B?YkVJS1drd3NrTDdMc1Fxa1l3MDVWTDliL1hDR0QzZ2hHZUhqNU5NdUdUNWVu?=
 =?utf-8?B?UDBYZTU4RWdzemcyMHVUOGtSbHJnPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(14060799003)(82310400026)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:29:43.3888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 782be8fc-0a57-4f69-6bd9-08de573d475a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11798
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> Use udevice name, similar to other lwip commands, instead of using the
> legacy eth_get_name() when printing out the device being used.
> 
> Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  net/lwip/nfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index 27579af8f1fe..5fc2d3bd8736 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -3,6 +3,7 @@
>  
>  #include <console.h>
>  #include <display_options.h>
> +#include <dm/device.h>
>  #include <env.h>
>  #include <image.h>
>  #include <linux/kconfig.h>
> @@ -116,7 +117,7 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	nfs_filename = nfs_basename(fname);
>  	nfs_path     = nfs_dirname(fname);
>  
> -	printf("Using %s device\n", eth_get_name());
> +	printf("Using %s device\n", udev->name);
>  
>  	printf("File transfer via NFS from server %s; our IP address is %s\n",
>  	       ip4addr_ntoa(&srvip), env_get("ipaddr"));
Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
