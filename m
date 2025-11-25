Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709D9CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8855583EAE;
	Tue, 25 Nov 2025 09:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wtOacHWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4328D83F82; Tue, 25 Nov 2025 09:13:36 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66C483F70
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiWtMpV95mVdokQhUKANNdSRDbjeuIXWLSwfXqE/1aRpzPaIAxFO4kV8zazuKQNKJ5nDD3IWtrqbrMKa63ImVpd3cleyjwZ976PYwPzobR942SO1PMEKwelUS7JwFFkgzl9S38ihw4eoShM1hJzJkB+rGsN4VQnnyhjpIpdEYLAFGjEK0XO1lwUSvA4mDOOe1VkeMRG10rUxiRTT4vQv7xbYog4MCRe/lA9UDRdSoz6ZdFxgseCw79Q9hqlgp2dT9q0bMn0/V2l6fx6zcmgE2volPTgHLKNTDo8KIeGOjgtOKiuf43aI6MoTLz7m+2vQgyiroG2Dh2n1l8Oq8VGXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwUyA6KEpOwTK4AOTM05gTFiiNXHiBeSO0vqRiT4cQ4=;
 b=WXQRbmFyQj3K/gx9nadYwY64EqZFzlwabXvGyoOGft+dBK/Q8kCiq1FDoTbo1XxjviuoVEMR3eqABbLBCWm6Nq2sLkz78YV43oBOso5s0t1t70V7/PR2xNrY7EckYFi+3JyzyoGjx9g3NpiUCxePnr42aeTbYUdEpl31GYZhBow51GWL+vA1fhYyrmoybOpLnZCUh/C1x3m1xBuPg76fcez8OXVC2OCwkGv9qpuVh6hiMT/4LCuWNcs98FxXT1G6dqAxEr7l9MCUQRCmgWTO2QO6KMPhSw0Y3H31wSsF0RgM6KWXYZyt8JRBXuRTBJzc/hMQjLZJznVzjKYX/sdCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwUyA6KEpOwTK4AOTM05gTFiiNXHiBeSO0vqRiT4cQ4=;
 b=wtOacHWk+zwaE+RUS6QK0QeiKzAXaBiZwennKJJ3PFGMRjym+xswJOS72KkxSLUNWoJNIwwS8pJLbuYAINjY74OQg4AhmQWI8SC4m1BZxBRzaZ/3gTHrZEwZkAMNjDrm/6Kv2drC+O/xecG+twQEVLAlkPfd3AAl+cbdeGr8d/RjsToquyWWXCF0HpnVDW1s90M8ClVlWOw5EvBnwnxV/XDnDm0LgG271vmJuJj5aV+SEgClbwUKBtJsWRAs7IrpO7Dz9BwejHEo7H7TpWsXJSbps6jxyRMoyx4d4TrarZ2iN/89e+LpI+ZVuseeLoI4Zjj1CdChLrhu7B5sB8jaqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:29 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:29 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
Date: Tue, 25 Nov 2025 00:13:10 -0800
Message-ID: <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ef7026-99b2-4243-624c-08de2bfa83da
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3F0QXQ2L3YxU3NTNXE2bnpsM0dKM2xxRCtzS3YwVkNTbFVCaElvWkVDTEhx?=
 =?utf-8?B?TkpUZnZBRUVFcEljWWdzaVRQOENlZ0NpWnJDdmZ4eUlGb1RWZ2Y0OHdTL0VS?=
 =?utf-8?B?RlIrZTlMZHNHYisvNGswNEQ5NE1VZ1JmQ3dON2FpeHZhenRuZGxadmYrR21p?=
 =?utf-8?B?VFJ1ZGRRdENITS9UY3VSRXFORzlHdGw2M2F0R3QzNE5rbGRWaksySU9sSkh0?=
 =?utf-8?B?VEVpNzNGYUw2ek51aXhyM1p5aHo3b3pxSk9HRm8vR2h1TW52aS9OYm9Ha1p4?=
 =?utf-8?B?aDhGbXdRLy92cDFXdUplN0hNUTh3eFZpM2JEU2JacXNpOHcvYlRYQ1pXaDVY?=
 =?utf-8?B?ZmhnRGgzZFQ5VlhLQWR3SWJtd2RuS0ptcGpTWU1FbEZmL0RIeEcwU2V1bGdH?=
 =?utf-8?B?QkdWQ2ZINzV1aUk2U0crUzRVaVR3blJPeDlrTjBMc3V4ZmF6M3RidTZqRmVV?=
 =?utf-8?B?eC9nelZuOVVkK2EvSmNiZ1N2SkZSMGZWYnNKVkZVL29IeXFBS0twYXNuVzQ1?=
 =?utf-8?B?V3o3Y0ZreWJXdGlqNFVaZ1FCZjJoY1M0MENRVUt3MnN3SU01SUlCUlVMc3Qx?=
 =?utf-8?B?OW9ZVFJKS2NwQmg4RC9ZVDhCRVJzYitKcTdWOVVFdTExcWtrUlBVVEVvQUxw?=
 =?utf-8?B?VENHQ1ZnNE5rYjBtTW9TNm9JeldrcnpYWE1qQy84cThjcXE5RVhsTUxhRHdT?=
 =?utf-8?B?alIxbzZVNXFvY2JpaHNWT3laMWdUVlUwbGZOTm9xeDJ5U2VwYjlkMWUxSThw?=
 =?utf-8?B?WUxLT0JtMGtqempXUlNJQWMvOXhEU1QvdUVFT1RjSXVPRzFPdU10N3Z1OFJJ?=
 =?utf-8?B?OTVtRGZkVHZraUtMcVdwS3cyWlhHazBONm5SV0JiNjVLQldEbFN2eVR2VTdE?=
 =?utf-8?B?blJscGJCaHlVeWxCODZxR0hObEdscEtDUk8xRE9mN3hkWm9ITVRJY1dXelpl?=
 =?utf-8?B?SUNKRE1lcjFFcU0yQkduY1VhMHdBVExld2NxSlQ4KytITXdTeEIveGphVkpi?=
 =?utf-8?B?TkNtUXBBUWJ5d0NEbEFRdkxtYkh2OU5hVnJtVG1YZEdGV2pkdW5TOWVGcTJs?=
 =?utf-8?B?c0FZNTFGSlhRa25rSzNPVWRNQzNzdWxCZElVVFlmV1B1ZEZyQ0RBV2E1aDBj?=
 =?utf-8?B?ZGRkSlNYZm5VVm1XQmhqREE5OE1GRGUraHl2cGNsMUZqQjFkemo2bzA5bkxZ?=
 =?utf-8?B?c2dWcVpZTUlzdk9QLzZaSGlVVUtCdUxHRS82dk81QVI4T2RvYlN5R0t0SmJi?=
 =?utf-8?B?dmFDT3hRYWNaS0w0RkhoMUNMZ3EyOC9yQjhYckR3M3VyclpOcnNjUlZiMHll?=
 =?utf-8?B?cGVJWnljYzY1RTFLdWw2SkFPNC9GSzRtWDAvU29ycUxjNFp2N05wQWJZTWU3?=
 =?utf-8?B?VG5GUExtQXlnZXUxY1oyZ3F2akhramNYWURiR24vN1RydXY0dU5sQmh6SHRM?=
 =?utf-8?B?cDVNMlhMbVh6UmhCWkRHR1NML2hZY2pWV1RLOXU2RjkwTGp5N04xV0xqTzJr?=
 =?utf-8?B?bnFYTmh5OE8yS2xGYW9kNTRHd1BnbkU1WmVBNHl4QjUycnFTRnFHQzVxMWRO?=
 =?utf-8?B?OUtXaUtxWngzZzBnbDJHTXNHSytVY3AvQkMyOGdYZ2szckU2TW5FLzBFdDRa?=
 =?utf-8?B?aURuQnZMUFczQVVwSUprMXBrVzRLM1NZM3hQSFVqV1hVbVhzbTJnZXFEZHRD?=
 =?utf-8?B?UEJHV2ZGWWVyODRaREtnRHJ0L1dBY1g4M1FoWXpOU0cyK3k0RGsySzFQZEEr?=
 =?utf-8?B?SXhucXd6Z1ZMWnlMZHRtQ0VYaXBKYXFLYjVBMjlCdlUrWUFoTjhUR2JLdWI0?=
 =?utf-8?B?TmJWSlNqSWVoVEU4bjhZK3hsTXpqVTI5T1BsYXM1dG8rQ0gzSFVsSm5FRGo5?=
 =?utf-8?B?cUNRbmR6OS84Y01NTTlqWWJSMlE3YWlFd29aMlJuZ29SRERJZ2ZBTjQva2Ny?=
 =?utf-8?Q?XmtpABhTzXZEIC0xsARA586AnO10CSpI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzloSGY5Ri8zL3JIOHZxcUlqZFoxSkpPVVY4eURnY3V4b0F3TU9Gd2V6QW5y?=
 =?utf-8?B?QWxnYXE0dk8rNnA3TWp4cTlUVTdvN3FwcCsyNlIvYmZ6QzB0SHBHWm90UnR5?=
 =?utf-8?B?c3REc1g2Q2lmcmYvZlZsWHR1dWZUNk1uZ1BhbklrQ3FNc212aDllUG5hL3BL?=
 =?utf-8?B?SUhaMzM3TnVZL3RUTjd2UFplb2tZREYzcldNUTJJWnc2UGdPN00wRFAyT05G?=
 =?utf-8?B?V3J2N3hUVEt4SGlQcjBrWG15S1BtMm9YanJ6TVNsYmMrM1FhTFFEZW1YK0FR?=
 =?utf-8?B?ZWtWbE1FUXphOTRCOWJQR3pCcFN4eFFTNkw1VkEvQ1YvRGlqR3VoSUxUNGZU?=
 =?utf-8?B?VThRSVc3WFNLNWFHbFlYUzl3TFNxa3RGemc0OWk1Q1JrVzNxSlA4YUtJTEZz?=
 =?utf-8?B?cENKeDFXZ2xlNG1YOU9DY2lRS0RjbzVidURtODd3R2hkMERoNTJveHl1OWdv?=
 =?utf-8?B?MlRTTTJUN1ladUJQMU5WWnRPd3pxQm5WRXhFSzJXOEpNMmVLQjNNa3QvQW1L?=
 =?utf-8?B?Wk5qelZvbXN1bjJXQ3M5QjVZVjFnZVdqY0k3M2J5Z2gxWlJpejZLaU9WQW1Z?=
 =?utf-8?B?THVnQ09BeVBMVkpMcmJBVGFBaWtYa1A5a1VSdU5ZajBEUDZlNVpQRzFodDJI?=
 =?utf-8?B?S3ZRVi9rREl5ajVuZmZLQnJtSzA1ZklqNC9OeXd1SUhhNmpwWnpIenUxaTE3?=
 =?utf-8?B?aTlyWCs1ZUhLSXkxR2Vmd2hKMzNhYkE2VWRNdjRIb2RhZjJVZ3A4dlFlaXNH?=
 =?utf-8?B?ZHpuajNqSitpSW5VNXFXdTJaZ1h2QmZpSlh3aDJUR05ndmdSS05QMTg1M1pE?=
 =?utf-8?B?Ym5walRnMlc2T2NzTTlNRjVQRHp2N3pZT1c4UlVMREtkdkNJcVZJdnBCZ0Rm?=
 =?utf-8?B?WFVwUmNDQVVpQmJWQVY0ZEdIRzYwRC9BSXE3aFBXZ0xIaFJCcHVBNThoVFUy?=
 =?utf-8?B?TTM4VGhjOGxWTlZMdU1Tdm5HcXp0aXRlWmUzK0NUMmtPTTM0VUFqR1FueHFQ?=
 =?utf-8?B?eVVsKzB3UjJ4bWl6N2NjSVdLcitoWVREVG8vbkdkeVhUWlhRdlN1SXE3a0I0?=
 =?utf-8?B?UEgrOHNhZjM2TWltZUFvT0xZbVF6OWd3a0tOZ054UEEzazdoS1Y3bGZwaUZr?=
 =?utf-8?B?eFBJUDN1YndlWlR0WmtHeE9teE9nRmFBNFY4dVM0MHVhNUo4RE1xYkFGdGlz?=
 =?utf-8?B?SEZZaW1xVDZ6RERVQTJESXNCVDZ1R25TRlhJR1hvaHlXVXNxMG04SGtGeFNk?=
 =?utf-8?B?RFlqTnU1aVBVbkw0UktWWEs4R1JPTkxLMjIwOFhxcm9MTjVIK3B4bVd0dk1l?=
 =?utf-8?B?K1dtRkZYdGtmSzByMDdHVnp1Y0IyVElISjc0YWRKT3I5U25BTkNuMktvY3dt?=
 =?utf-8?B?OGZJalRBam5ZWDdvamliL00xS2ZjaVh0WE04blkvajZEc0xKNlcvOG9LcTRI?=
 =?utf-8?B?SWR2aU4xMkdjQnE1a0lxcGh6OEdDQmdxZHRkOTFnY0haVGNIQlN2TXhaR2s5?=
 =?utf-8?B?aW14WHErUWlLTnQzN2wrcEgwckhVZ0RQdEhhelI0TlB2QlNvZ2tkZnRIZjZk?=
 =?utf-8?B?OEZMZnhEZk1ucWNEVWo1ZFQzdXNFbHZXOGoxWUFlNC9QeHVWQWhITS9MNEdV?=
 =?utf-8?B?dHNoc1IwTjdXb1Y5Y1h3U2krMHZYTSt1M2xuOUR2K2JUQ1hiN1NmWVZhVHZ6?=
 =?utf-8?B?KzFEdmFGaUxxOThPWFc0NlF0MHFjZUUydzRUTHpzeTVmcnNxUHBGU1pBUHJV?=
 =?utf-8?B?T0M2Tzhzb2E5a1Bja2EvNjg1Ky90NlBuRm9NdVIxS2l3SHJwVWZSV2FXWUJy?=
 =?utf-8?B?MkNlZU1jZE5FRkVLRDZuY0NQUmJuUHBNY1ZwUnZVNnpCTC8wMk80SGI2eHZZ?=
 =?utf-8?B?cWNncVh0RDNKMHVKcFV2UmMwVlVrajRUWnFncklFaDVBTHk4bHBPcWFnSnVa?=
 =?utf-8?B?dWc0SnBxTXZueE5xbmZyWFl4cStrZWlueE80ZTJHZ3dxdytZZVlQMGpaYTVy?=
 =?utf-8?B?UE92bWQzYkh6NjV6UW01NFBCYVViZS9TcFJCT0tMYkdiT2pKZ3VDZmRzL0Fa?=
 =?utf-8?B?VGVDb3hZazF1UmdFWUJTbE1Tengzc0FRYmdoM21DMUJFVEEyZms1U2dBSm5Z?=
 =?utf-8?B?Q0g1UTE1bFc4MHA5cWlsU0VUcldtNiszMDhmVnpIOTNQaWl6dEhQaDVNQmtR?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ef7026-99b2-4243-624c-08de2bfa83da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:28.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNjSUNLtS3nCwJo0kSDMq3mX9ntDGGF/HvabJrFA3OLdVnBMD1+J/K6xjYibPfxulwj7oHnpXNsw11Nyy7YyPsQ8aKoC6neG8OCl/h+xp0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Tien Fong Chee <tien.fong.chee@intel.com>

When building 32-bit ARM SPL (e.g. Arria 10), linking may fail with:

    arch/arm/cpu/built-in.a: file not recognized: File truncated
    cmd/built-in.a: file not recognized: File truncated
    dts/built-in.a: file not recognized: File truncated

This happens when a directory (such as arch/arm/cpu/, cmd/, or dts/)
produces no object files under SPL. GNU `ar` still creates a zero-length
archive, which older ARM 32-bit linkers (arm-linux-gnueabihf-ld) treat as
invalid. The final link step then aborts with the "file truncated" error.

By contrast, 64-bit SoCFPGA (Agilex 5) builds use aarch64 linkers that
tolerate empty thin archives, so the same condition does not cause an
error.

To make XPL (SPL/TPL/VPL) builds consistent across architectures, this
patch ensures each affected directory always contributes at least one valid
object:

  * `arch/arm/cpu/Makefile` — add a persistent `dummy.o`
  * `cmd/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y
  * `dts/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y

These dummy objects define no functional code and do not affect runtime
behavior. They only guarantee a valid archive for the linker, preventing
false "file truncated" errors on strict toolchains.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/cpu/Makefile | 2 +-
 arch/arm/cpu/dummy.c  | 7 +++++++
 cmd/Makefile          | 4 +++-
 cmd/dummy.c           | 7 +++++++
 disk/Makefile         | 5 +++++
 disk/dummy.c          | 7 +++++++
 dts/Makefile          | 5 +++++
 dts/dummy.c           | 7 +++++++
 env/Makefile          | 5 +++++
 env/dummy.c           | 7 +++++++
 10 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/cpu/dummy.c
 create mode 100644 cmd/dummy.c
 create mode 100644 disk/dummy.c
 create mode 100644 dts/dummy.c
 create mode 100644 env/dummy.c

diff --git a/arch/arm/cpu/Makefile b/arch/arm/cpu/Makefile
index a0e1c2a651d..fc409bc5a90 100644
--- a/arch/arm/cpu/Makefile
+++ b/arch/arm/cpu/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-obj- += dummy.o
+obj-y += dummy.o
diff --git a/arch/arm/cpu/dummy.c b/arch/arm/cpu/dummy.c
new file mode 100644
index 00000000000..a7a55a02c20
--- /dev/null
+++ b/arch/arm/cpu/dummy.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void __arch_arm_cpu_dummy(void) { }
+
diff --git a/cmd/Makefile b/cmd/Makefile
index 25479907797..104e8a770e7 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -3,7 +3,9 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_XPL_BUILD
+ifdef CONFIG_XPL_BUILD
+obj-y += dummy.o
+else
 # core command
 obj-y += boot.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
diff --git a/cmd/dummy.c b/cmd/dummy.c
new file mode 100644
index 00000000000..a4d10f413bc
--- /dev/null
+++ b/cmd/dummy.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void __cmd_dummy_placeholder(void) {}
+
diff --git a/disk/Makefile b/disk/Makefile
index 2248a659f8b..eb17dac8b67 100644
--- a/disk/Makefile
+++ b/disk/Makefile
@@ -18,3 +18,8 @@ obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   += part_iso.o
 obj-$(CONFIG_$(PHASE_)AMIGA_PARTITION) += part_amiga.o
 obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   += part_efi.o
 endif
+
+# Avoid empty dts/built-in.a during SPL/TPL/VPL builds
+ifdef CONFIG_XPL_BUILD
+obj-y += dummy.o
+endif
diff --git a/disk/dummy.c b/disk/dummy.c
new file mode 100644
index 00000000000..0d7d99f744e
--- /dev/null
+++ b/disk/dummy.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void __disk_dummy_placeholder(void) {}
+
diff --git a/dts/Makefile b/dts/Makefile
index fd4ae31a533..1bf5577b403 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -89,3 +89,8 @@ subdir- += ../arch/arc/dts ../arch/arm/dts ../arch/m68k/dts ../arch/microblaze/d
 	   ../arch/mips/dts ../arch/nios2/dts ../arch/powerpc/dts ../arch/riscv/dts	\
 	   ../arch/sandbox/dts ../arch/sh/dts ../arch/x86/dts ../arch/xtensa/dts	\
 	   ./upstream/src/arm64 ./upstream/src/$(ARCH)
+
+# Avoid empty dts/built-in.a during SPL/TPL/VPL builds
+ifdef CONFIG_XPL_BUILD
+obj-y += dummy.o
+endif
diff --git a/dts/dummy.c b/dts/dummy.c
new file mode 100644
index 00000000000..8007239d3f6
--- /dev/null
+++ b/dts/dummy.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void __dts_dummy_placeholder(void) {}
+
diff --git a/env/Makefile b/env/Makefile
index d11b87702c1..4ebb6018b4a 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -31,3 +31,8 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SCSI) += scsi.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
+
+# Avoid empty dts/built-in.a during SPL/TPL/VPL builds
+ifdef CONFIG_XPL_BUILD
+obj-y += dummy.o
+endif
diff --git a/env/dummy.c b/env/dummy.c
new file mode 100644
index 00000000000..dc23f8439d0
--- /dev/null
+++ b/env/dummy.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+void __env_dummy_placeholder(void) {}
+
-- 
2.43.7

