Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8E5CFD376
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFD183A47;
	Mon,  1 Dec 2025 04:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KF0VWUZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1241F83935; Mon,  1 Dec 2025 04:08:48 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7CE83A48
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqlv7nZJIz+Ci5+FG0JSPGQYQOqQh9WYjKq6uaP0sjJq519+N2+2YyyPOj2rCjbo8/Mfv7Qp+0ah4wkNseqvKFphDzFtqIi69nP6KVCW8K0WoOIIc8X5bH9zQoQP7UeIQbQ+HCOOcWG+h/Q6fUPPi6ASnY8QgZD0BBWcyrvNlYUN1p+sfaKj+r1CwQWmS2qThtZ+hOwV5pBv/e03pZwFU5WwmB9HvT6LnRM262OefszkZSbjaKXQBB4jSnI60o31opJ4M8qmZXsgl1q/98p1y5rqBmOca2p+YepPnG7ccpSSKPojwiuH/6MnrfOfgCyZ7Pcmd6HA0h0x4/ypK9+D5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IXIZkDV1bPiEjMLrbT59QRbgc8WPbqpcdGLvUCqDds=;
 b=UIDcT2/7WW7AVxVajuKzqsmjU5lPQtrIMw/5ItZs9I/+5JYv1Ar5OGRcD4NxvwH+oYvXgMG2BVbJRKKddXMoX0Vii5o2L/nAbidfJMHNRq2mPbyYFW9Que0+Zm/D40GzAXtZPi9K22WaYmKRFkcce48ng3DBp0B8UMWHCQxgNRUIJ0T4rZCEVEXInK3liFAF9hZVrVCK6/qFyZ2hmtNqCjFaiv1TtWMBmBRhSOj+G/Kd7znZd7rCc/h1MIWyw50V7eiizuVTtdihllg/Isxw/FZ27PkMIyBpQTlee0dpGZc0mv6jHzHfoyimPsgHubIz0Piw+wshKYipOMT9uQdxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IXIZkDV1bPiEjMLrbT59QRbgc8WPbqpcdGLvUCqDds=;
 b=KF0VWUZkjhOGrvR4HK0YMMpAmGnpYEyqMtprWea8SmAljOUA7+Z2fSsCc6PlK2IxxPBZlPHOuSgKo0qAIAR/XsmNNmxQNED38T4aCerOlxurdiwhL1eYwlxeZRabBHkDn1cIRpEwOwA2pMuLPrJgXk1luAGfLuhaynvAIl/IBdok0ZYeqLtgRN+lSR1E47qJbBSD5LfOh+VtdCJn9iUA1QNWIf6uS6tLAwst4rT14shPz3f2Olaj+9+bYVBaVeG0n/p8dK2dr8NqUeSDkgFSaIHuAOGqIFq+7MwMhB9mEvRKthMe50tz+p+86yNqlKRxpIYpnI55jQidNnOrebP6Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:08:44 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:08:44 +0000
Message-ID: <8068f275-97ce-466a-ae80-8ecea788ee21@altera.com>
Date: Mon, 1 Dec 2025 11:08:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1809be-35eb-488a-4028-08de3086ef9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlJ0RlhQUzEwaGRNOEF1MFdabEltK1diYU84b1dKK20wRWtxbmtyQkwvdm1y?=
 =?utf-8?B?MVV1Y0pJOStNc2xpRFNCV0ovd0RHQTdmRGxwUTZWNVlXTG4rMlFNcWpPb1VB?=
 =?utf-8?B?ZWMxUXNSVGQ5ODVGMGdlVEd4OWNONUJvY1pCS0I4Y2oyUWQ4OHVGdVJMV3BI?=
 =?utf-8?B?Z3N4N0F3eWZTeXczbHBnK0pYZm13NGJRSWZEbE4rZFFSajZWRHk1YXhLNzN6?=
 =?utf-8?B?RjRuWFI3MVlLUzRHVnBPb3ZVMG5WSHlqMGhZZHBzY09QVG1PblROTkVqaTg3?=
 =?utf-8?B?cGlYQjQyWCtWSjdsMWhGT0wwbHE2R2lzc0g4bXA0dllXbU0yOEcwNGJZNFJn?=
 =?utf-8?B?alowTHdBMW1oZzZDelNwSGJaR3d1MDNsSGtFUzk4SjJpODIzTVVWTURaNm1V?=
 =?utf-8?B?STFRUVRFbG8rNlR5VlU1VlkxQjFSVjlYQU1BUFZrRDl6WTVxejRkeDQzNTRM?=
 =?utf-8?B?UGQ5OWQrakQzZzBBUnROU0czWmlNRjhkWlhRaDhXOVJYN1dsSHJZdFp1WWJp?=
 =?utf-8?B?VnFDalA5QlE2aE1ZSk85dTUxWDNNcGZmWEkwTm5PNkNmR3BIZkdSNlQ0Mmsx?=
 =?utf-8?B?L2VQcWJaYUoydzM4ZnFsdUhhT1ZiR0lUT1lrcGdCTmk3dnJQSHdMVUM2Zjlh?=
 =?utf-8?B?WDBLNGpsRWVaUmZpamtQbkdIaERZM1dGUDNFUkozQkdnTDNFTDJEenBBWWFW?=
 =?utf-8?B?M3hSTHFvcHh4S3psRWNNWjFzYkxOU0N4VG4xWXZMdnVBMHRDMExDdDFMYWhl?=
 =?utf-8?B?WmRoNWt1L2FlVlN2TEN3R3RlYUlHd0hnVkhrdDhkQVlCejFMR1dtS2RnUTc2?=
 =?utf-8?B?YVUwMXZZbEZQTytrVi9pcjRvVW9zTXRTWE1kZnJwa3E4VXNQMzJHSUI5YTl6?=
 =?utf-8?B?RU44ekd5a0N1T1lKZjAwc01UYUY0dFhnMHpvQ3NGakR3ODNwUGRqYjE0eU15?=
 =?utf-8?B?ZXNFMUNNd25kMHE5cmpMTU5ZYWN3dUxzM21EWDY3UHFZd3NCS1p3M2M0UXZv?=
 =?utf-8?B?RDVTb2ZkQWNsOStURzVUanNJRXpUVHhDallHNzNTTUorK3ZRZTJhbldYMTc2?=
 =?utf-8?B?R0VUNWRjV1U2U3lOdWpwemoxaUhqVXExWjltbjFxdUVraVVkVlZleTFHOUo5?=
 =?utf-8?B?c0hlK3Ywdkd6MGZUakNVZDRlT2dFOTlsTk84eXR2Q3FHT0FTeDkwYUxiRkZT?=
 =?utf-8?B?NWRKek5hNlpXMmQyWkZIaFNtMEVNbGZUbVZ1azF2eDlCbjdkVkt4QndoQmRY?=
 =?utf-8?B?T3dQWFQySEhxYU42eVB0end0QUM4M1ArUXZzd2FJZzNsMVpxczk2Z2lEL0li?=
 =?utf-8?B?Q1lDRHAyU0cweWVSeGQ1cHJjWkpWaVlyYWxOWG53VW41VGNaTmZ2Rnk5UzZu?=
 =?utf-8?B?TUhpTEZkSzNycWROOG5jREhJMHhRVXgxbDBFSkZhcjQwNkluUVFzKzZoWSsw?=
 =?utf-8?B?U2J4WG5oU1pnRmpEbDJGVVB6amRqS3g2Qis0R3orWTFVbmFRM1JRSWo2Z2hM?=
 =?utf-8?B?N0NPaS9rSGxWUUJzQm04ZGlDZnlGVUpGMDlsTWFDSXNEcUluVWZ1WGhkVE82?=
 =?utf-8?B?NVhiNmJoQXFsNnhHaHczbThEdFRjUURISmRDeFJrUUZWako2amtjM1krMjl0?=
 =?utf-8?B?c0NyWEdVTG1qeFBocWxlVEFVTEtYdlZXTE9aQk4rcWJaY1M3bTFjeFIvS2dB?=
 =?utf-8?B?L2dmTUlsYzRkM0hNcUo4NVk3Z21ab1lYRWlIZ3RvN0xRdXBpOFlTMnZESTVz?=
 =?utf-8?B?Z0tMQUI3OWRCVC8xNllwQ2VmWmtFRXZ6U1FwSWZURTNScTJIUVNnYThDQmRI?=
 =?utf-8?B?UkdvbHBrMTk0bTQ4b2lxQjZQZnQ2VjdUOWM4VjUzUkNGd1ZDMUMyM0tCREpU?=
 =?utf-8?B?bVQ3cGRQWEVYMUJmaUs0ekY3cTFkcXR2RzJBNXZxQWhZdm5uTU82cHJCcE1s?=
 =?utf-8?Q?cwe8e59LueK+4dhBIWoEhASU6q9OHvQ4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZ5UFdtdllDNXZNbjU0VWhiTlRIUDVLZlZ2TUZtQktyYzVtZmdjRXVsY2Va?=
 =?utf-8?B?UGpRVmFyMjhBTFkrY29WR2VRdGlmSnZiVEhmTnB6NXBoZkZuRVdsRndPTW9C?=
 =?utf-8?B?M0oxK2hvbTh2alBCZDBMRVppZVZGRFkxbjU0UnpTS0RVTTFHZ2U3eXlYNGI5?=
 =?utf-8?B?WEdlY09RcVBRemhGNmpiL3RLZUc2bGpJa3EzY0ZseC9xNDN3Zi9HV29jbExE?=
 =?utf-8?B?bFdzdFpPMjhTMnlua2pBQ2NvWjBnbXloVEZoZyszSjd3ZTlVL2dMZGJkSURY?=
 =?utf-8?B?TldrNWd2VlFyb2RVQUR0N2dISFdiOSsxK2NTbkZWem9EMDRUTm1EVW92RWda?=
 =?utf-8?B?UEhGNFhWMHE3K2tCM01yVlF4SENwU3liNFpjcGM2Q3R3RFA3TXpYZ0hNUTIz?=
 =?utf-8?B?TlZJUGNYTUM4aXp6Q1dxUEE1NDZvRVJBRERKYVQvaHFKdjNialV3SjBzc2g2?=
 =?utf-8?B?MHhSUklTdWZzNlk5enYvWVpUdXZGdG5aQUtENGZTVzA3WlNZQW93Z2orK2JK?=
 =?utf-8?B?MTNhRm9OSGhUakhDMDNYcHNnd1pqMkZhRWRvZVlQbWNZQkFETXg3Yk1KdU01?=
 =?utf-8?B?aWJLS2hsRzJDNmN2RHBmc09lQW04c1c4aEcyQmJlb3g2ZU1MWnJlOGRtaGFz?=
 =?utf-8?B?TUlqcEY2UWNRNXdwOThxa0ZVbWYrSjEwNVhVRzRHSWNlMEpYMVBEZzJ3RTAx?=
 =?utf-8?B?MFlrUlRpTUVUVmFvVkF1S2ZtT0tLclR0QmZ4d3BXRUEzSXQxZVM4MlZEdmM1?=
 =?utf-8?B?TFVqY3FFTWp2OG5SZVJDR290YllsdDI2aGNnWFBXZjg1N2Fud3NvYXlsWG9K?=
 =?utf-8?B?S1NqaTlwUEVURE5MeDQyci9UcU1qL3ZWK3dOa01OQ3RYZFhEMmE0L0dHbXEz?=
 =?utf-8?B?d0hNZ0tma2ZpeHljQUozb2hMcFROTEx0Q1Q4cHQ0SkVvUGxTa0NaWGN0WXBq?=
 =?utf-8?B?dm53RC9raiswb0lCM1R2ZC9BOEhWa0FuZXJYeDVCRTRiQmxNOUM1L0diQUZJ?=
 =?utf-8?B?YmovdmhwcURGMi9MM2RTczZKZzBMdzVmT3lwMENSMm1PMGV2dElWR0VqcTdW?=
 =?utf-8?B?Y1NhZTQ0cWxFb2R2SDZZL2Z2SXRFVmh5WE1RTTlCbzh2ZVdXcWt4Qno1eEM5?=
 =?utf-8?B?cklxUmNUczZIeDl2U3Q5TUJaaGcyRUpJUGFXalMwbzIzK1E4bjI4SS9CSmFP?=
 =?utf-8?B?QWwwRVpZcVo3Vlh4M0N5SEpRQXNiV0ZEUEt6OS9WWlRRLzdrM1QrKzN6T2dk?=
 =?utf-8?B?ZkRzU2NOWFgxU3NweEhIYjVZODlna1kxTFNaK0huUWlmUEI3QTM1eGtjbkwv?=
 =?utf-8?B?REVwcWROa3NZMzg5WG5OdGNNZTkrdmx3V3BXVnFUSVMzUEd1UnhudWJVM1dO?=
 =?utf-8?B?cEdzRk4rdzNPdVJvMUZZcTNSNDVUWkMrS0tBUjRLY1Q3a1VXYXpvSVJjN2hF?=
 =?utf-8?B?QWU3NFgrUkVMSjRpeGtHVFRVdXZJM0dOa0V4dmtwMlBKYUpPVFF5T01EaVhs?=
 =?utf-8?B?bUdOQjIrMCttVks1R2ZYMk9CRHVQa3N5R3ZTd2I4c0RWNlV3TnZDVmRQSjdm?=
 =?utf-8?B?VXpMMk1NTk0yWFRnMUh4Qm90MEttbnFCNWlCK2xVT1VPYkZBbDJtdDIwQXk5?=
 =?utf-8?B?NkVSYUNwOTlYVGhQNFkweGUwUnlualhUeDhyaHNwa1l6ZmtoQTZsblllaC80?=
 =?utf-8?B?ckR2ZDJSQ29TVlBLV0lRSDFkUjRQOGZoZ29EYnVKSXlLK2xYajZ4YkF2Rktn?=
 =?utf-8?B?bEgzaEZVYUN1WmtrdjI0dUpBRERBZG5VYXpvOWRSWGhqV09JekRLUmN1Mm8v?=
 =?utf-8?B?M3JLWGdqdHgvOEUvRzBGYXJwSEVsY1JGSGxrS1c2aXlqOHdGNzU3VS93VVlK?=
 =?utf-8?B?djJEVHVnZHdrNDYwSG9Ha3F5NVpZdkRYSTN2TU9uNGhETytucGthc0J1dW1R?=
 =?utf-8?B?WXVXWjRMTkFuN0pNWmo4eW5iM0NsYk9EQmV1amNSdDhNWW84QU1Qd1BVdWtG?=
 =?utf-8?B?UnowMWtPSDkyWm9zcDR5dkN6aVpGbHlRUHFaQ2MrSW9oc3hrNkZ2R0x4OGls?=
 =?utf-8?B?bGpoR3NQcDdFcGlKb0lienZVK3NGVC81VVZqSVREc3kyWWdoak5FeWxITFA2?=
 =?utf-8?B?a1M1RUlCdEttM0NPMWpHa2F1ZHlZVERsZWxsZnlZRytyM2NwNFN4QzZCRTN5?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1809be-35eb-488a-4028-08de3086ef9f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:08:44.1248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OHBHQlifUrYBWHkIsJXTeRMuNUxzr0nszrWWtCzSBtcsMQfrXQGpt3JYZ48N630N71E/Cnq6duQjyKcFPyPjZiYJS5s0W739QMj946Nwnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable support for FAT filesystem with SPL for CycloneV instead of raw
> mode.
>
> Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
> required, as well as aligning MMC boot flow with our other devices.
>
> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_cyclone5_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index 2bec82b0625..2b2435a27bb 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>   CONFIG_SPL_STACK=0x0
>   CONFIG_SPL_TEXT_BASE=0xFFFF0000
>   CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
> +CONFIG_SPL_FS_FAT=y
>   CONFIG_TIMESTAMP=y
>   CONFIG_FIT=y
>   CONFIG_DISTRO_DEFAULTS=y
> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>   CONFIG_SPL_NO_BSS_LIMIT=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>   CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>   CONFIG_SYS_MAXARGS=32


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

