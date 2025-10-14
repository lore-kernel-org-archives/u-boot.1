Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07841CCD193
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8682A8312A;
	Tue, 14 Oct 2025 18:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="QzFJonZh";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="QzFJonZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761DE8323A; Tue, 14 Oct 2025 18:16:26 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AD3807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kblnrRtZkXy3M+ZcKxf11qiuE2uHCg/E4J4BbHwWgcvOpKsU5duPuk0eJgXYC72qbRZcxX9cq8FqV5dNdz8pbYXT1NcSYO1jPjqZotsF0yoMX+wyoUphiiqRQD9OmnGWD5957J3ikvfrFloj6sQsWlZxMXMgQXvdFNqMuM6BJJwmIGjhFCTW/PqvqxfPKDIggfUE9vqEeDIFdXDPJjwxX+lHcoQdw2G/e2ADc8sSBPtBctfzRenf5S61LhCAgzBmsPQymygRrIUh6zs03R9E03RH2yu9uQv5uoRb3hyfXm2YRgfW+VGhiCgQJxXItTYnktxtp/0+/YFyr3exw2p/WQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9vZMhayq2MQ5dahrhEqueqxKhNWezeENOpvj4+N5U8=;
 b=VlSYjPm1s2U2MviXWf98ojPfDr6g0w3YKkiW58E+NfAINYjzzdT2dOvrjJrl7+GST1sn7et8OQj1l4QPSyG1ILtPhvNOQqXbtkRjUJTTd46Uq0/L/+jjCCj4ZiLAISyforU67Ad7csRfgul29Xt4qsEn6adRRvoret0GuvGeKz9ZEElnNSif8ZjcUo6LfRQb9Byia7zNySSQmem/vuPuvHIkqJAeJgpgHUAIIkL9cCaIU/UrlO1Pmll1kTkXScRvDkBrRhLmAfTPOivZ8dedPS/1bjDGtG7Ve0EBJJmq3NMw1IdsXkhOY0BOUvFIZE77QuvcL2sfASZZGJBE3QqCLg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9vZMhayq2MQ5dahrhEqueqxKhNWezeENOpvj4+N5U8=;
 b=QzFJonZhbeEDNW+CSp7ImmBYcFz6iOG7pORSfMPiWjDsI49+hC+uhreH7qQ/BlhNk3EFuB6qE1PfXcZm1RrcxBxFP68MqYxDkeTUVzUtPrMVnq4JBap2+vBKtbEM07+8l29TfvkazErySyhWUFDMmFDF4MEcdMXjxlnwbi1VY2EBjv0clsQVIijM5Xs6GcBo1Ah1jyNVc+vk9X7FRv8oQTuAXAJI/pcHLWAsGuskLLiEirQxYpQFgrFLq0C/Z+CroPgPHA/Uie65nHqgA1gVTsbViCiw0EXyXZm3dDeodVQvBy1XvT8GHJ5G5Z7ea92yc7CI4GdG7LfI6m3eN2i0Ew==
Received: from AM8P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::30)
 by DB4PR03MB9460.eurprd03.prod.outlook.com (2603:10a6:10:3f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:16:17 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::a8) by AM8P189CA0025.outlook.office365.com
 (2603:10a6:20b:218::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Tue,
 14 Oct 2025 16:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Tue, 14 Oct 2025 16:16:16 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 194802008162A; Tue, 14 Oct 2025 16:16:16 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.65.94])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8649720081244; 
 Tue, 14 Oct 2025 16:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m589OyNcL4s8juOrOobtL5RVNDQrnse8dnAd9DRjQJor2RTLRc6hlh73fNmZZXABzgZOc1J1AsStn5dE2XOg3uuBjqYxed6rZQIZrCzc0wBI/ZMVnLu2jq9ctIVd+XThRjPb9E7dQLAu1JrE3/wpkXcb/+ikzTY83zPkqwl0EvmCXa1W4wtJYWmOEhflvVdJxxb1EwljVj4Wg3iSvIrZVFb2pvvhgERAPsM6dMiUmWTJW2qcX3ThBSJX1Jq3r5SR6xS0YY8+b7o1osHOjIr1ddaykjsvaNrd6WnNjzvlDpZQuGPsrLpm/c0CPEEFcD51VfaxeyG0udtT9bW1/yVUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9vZMhayq2MQ5dahrhEqueqxKhNWezeENOpvj4+N5U8=;
 b=LYZqCbe/qaYBK9352pir7B7xgUtk5y3Vi4hQ8ZT6iqvvBdzN0cwEZauQOiKzZPMy3ALFe/D3eCgOeLXNrhp1nVG+p0rHTXDXa9lDiW9APgAfqsPKOe3ABmFQNYdC6Q8HKFdDAGxtAFD3Htb//2R+N2kRwC43OZJs+l88tmx3E/buV1P1h73WXJ20OJBNfh1576au8LRQCaMatrqXhaRp+xTrARWcX4gxq+PoG2Ds7Xd6I9f2MnJGHdW/OpILRkoaKEo3lIOpLmdsj5fK8pb280F1BxUUXRAu/DBJ/fHtm4Lhgm8lkCPkhNRkIBCqSXMy13O0o9jntLDrO4M4mkAD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9vZMhayq2MQ5dahrhEqueqxKhNWezeENOpvj4+N5U8=;
 b=QzFJonZhbeEDNW+CSp7ImmBYcFz6iOG7pORSfMPiWjDsI49+hC+uhreH7qQ/BlhNk3EFuB6qE1PfXcZm1RrcxBxFP68MqYxDkeTUVzUtPrMVnq4JBap2+vBKtbEM07+8l29TfvkazErySyhWUFDMmFDF4MEcdMXjxlnwbi1VY2EBjv0clsQVIijM5Xs6GcBo1Ah1jyNVc+vk9X7FRv8oQTuAXAJI/pcHLWAsGuskLLiEirQxYpQFgrFLq0C/Z+CroPgPHA/Uie65nHqgA1gVTsbViCiw0EXyXZm3dDeodVQvBy1XvT8GHJ5G5Z7ea92yc7CI4GdG7LfI6m3eN2i0Ew==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM9PR03MB7742.eurprd03.prod.outlook.com (2603:10a6:20b:3dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 16:16:12 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 16:16:11 +0000
Message-ID: <11c7b98d-71a9-42e0-a2a6-70496a1c54df@seco.com>
Date: Tue, 14 Oct 2025 12:16:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: semihosting: Fixup smh_flen and smh_read against
 overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20251003-fs_semihosting-v3-1-5f6de9b7f225@linaro.org>
 <20251010203134.GA1187059@bill-the-cat>
 <f8fa81c6-8fc6-4f3c-bbbb-9f6c4be016ef@seco.com>
 <a1ef5592-647e-421b-946e-2ceed6bb47e9@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <a1ef5592-647e-421b-946e-2ceed6bb47e9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0429.namprd03.prod.outlook.com
 (2603:10b6:610:10e::13) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AM9PR03MB7742:EE_|AM4PEPF00027A64:EE_|DB4PR03MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c26e51d-18de-43f4-50e2-08de0b3d0081
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?T2hsODFHd2VIdXl3NjFnTE1FcER6NHEwR3Y4YUE0aTdGSkRWcndFd0wwc0Z1?=
 =?utf-8?B?VlVwN2dCT0VEUGphM0syK3NlQlFwclVQemh5ZUY4RVF2RHVHNm10SFFSZUtE?=
 =?utf-8?B?YnlMTTY2TEx6Z3FCeVprOGZUL2RWdWxHcFNpTGhha1ZrcS9WakZQL0xlNGNH?=
 =?utf-8?B?K2xvbGUrMXoxeHBYV0czMkRPUW44SERXWkVLOFUrd0EzaU96Q2xFcE0rd1d2?=
 =?utf-8?B?bElwWnM4ckJDSGZHOVEvRFlGMmNXaVl0UUF2N0NjRE03eUhJWlNHUitudVd2?=
 =?utf-8?B?Z3V6L3FIVVNMNi93SGJnQVRnRGw3NW8zd2VKdk9CTXc0a1hoNlRZR3VXbnlj?=
 =?utf-8?B?OEkvd1p1VWpyREd3YWZoM3kva1BxdUhPT1g2NW5uWkVmbUdWVU1KV3dzV3dM?=
 =?utf-8?B?aDlEa0tWT0t0UU5OMk4yMWRrUGp5c1Y4cjB5N0k0bnNpKzJFdmNXMm9XY3BY?=
 =?utf-8?B?czZBMkY4eTdzbW9BR2oxVm51YXA3VlF2VFhZZTBJNDNSM1c3NzVOSXp6cENq?=
 =?utf-8?B?ZWd1MG5LTS9yNi95WWpkUXEwOHFOS1JMaTV1WTZLSnROcVQwK082YittdEZw?=
 =?utf-8?B?NlYyZjZDT08wS2xlRUtZcmQ3b2QreTNCZG5FcFMrUkdmN0RKK3Rlb3Y1OTNn?=
 =?utf-8?B?U0owVnVSWWxIeGNVNnUyUTlDdUMwaFlnTzdUTVJXb09JNWZ0OTd2ajBOT2I2?=
 =?utf-8?B?d2J5S2NyUEpDSldPNG5FT2dOb3l1cXZmaHNIV2tNV21odUcwYkRNUG92ZCsx?=
 =?utf-8?B?YWhEdmJaZ3JoOC9iOHZSdFRZcFBxay82TXB4eTlPbFNRdkVPNmgxd1I2ZUJC?=
 =?utf-8?B?TVZtaXhSMFVteTZ1a24xMWh5M0ViSjV2SDl2T29BaFFoc3YyWUVTMHUxRGtB?=
 =?utf-8?B?UEFTcThhYnJOL3VHQVpFQWRoWmZQa3dud252cHpDU3lKOUtpdE5XbzV0TjNo?=
 =?utf-8?B?U2x3d3k1VzMwSC90MUlaa1hFV1RHRWUvenlRWCsvbFgxMmpsUE0ra25NOVZE?=
 =?utf-8?B?VXF3bTlWY24vcnRlK0ljNXoxaUVhY2syMmdWbnR0UWZVYkNrOGZsbmpId3ZQ?=
 =?utf-8?B?bWV4bjJsc1lWNWMvemYwN2lSRUo1SU5ib2NDWTlHanFjNXlwWHNZTXFaSUF1?=
 =?utf-8?B?SmF3ZEtaWVZ5R3hDYTM5QnJQSkJsOEIyZDlCNEk0M3hFMjJZb2V6QmdBT1hw?=
 =?utf-8?B?QzdNNWRkdVJtUVQ2YUp0a2VGeG4xRHZVOUpkU05RK2NjU1J6R0diYXg1UXg0?=
 =?utf-8?B?WEplbHVqQXNBbm1YSWVJb2hVUHRoSDFIczRKVXp1YjYxU09ScjJabTR5QTRX?=
 =?utf-8?B?dEw4WE1OTUtQUURYdGRHWE42cy96cFV6ZFVsM09lOWdNTk1GUGYrcS9ScmRC?=
 =?utf-8?B?RzUyNmVPVUkvSVp1dEwwcE5WZUp3S0J2MUtJcERjSmtDNXFSOURGOFJ5ZjVy?=
 =?utf-8?B?N1VkTnZEVVg5ckp0V1V6ZFZGandqODd6b1RaeFJ5emxvQUNBK29Tb0xTUGI0?=
 =?utf-8?B?MmVQSmZqek5NR0tSWVpRTTBlaVFpVmtGSGRYNTlZNVEvWm4zb0dKL0ZUK1Bn?=
 =?utf-8?B?Qi9WZVV0MFh1TDY4cmdtM0Fxck02eU5aZDhMcDdsVU5HeWdUQ2ExeGluc0pV?=
 =?utf-8?B?eHAxbmJPN3FoUXlqYkxxQ2RnNHpYZjRIV1F0OWlkdlhjUG1HRGRrREpGdldY?=
 =?utf-8?B?ellpa3NLZnIrMyt3WlIrWEJBaE5BYk80NkVjMDQ4V1Vud1VKOE05bFhKdk8r?=
 =?utf-8?B?Uk9sRUZLRndoWGROckdKbjhWZVdDYjFSZ0VQSFhkZGZWd3ZRbnhUUENPdlZH?=
 =?utf-8?B?aW5ZaVFEdzRNb3I1b3hWdWZ5V0N5WFRDalIzWE9DL1JhZndtTVpBZ3BpUXhy?=
 =?utf-8?B?dUppbmZQSkQ4TnVyQThvQ1NuamFRaGlKT0ptWlIrNFJMWkVMcGtzTmcwV1Jt?=
 =?utf-8?B?S25LdDRkQ0lscWtRM2I3cXExUjR3bWpZQVNJMU05WkNabGhzaCtoNXpsQ3pv?=
 =?utf-8?B?VEh1N3kzcVdBPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7742
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 507fd4fb-0bc3-4a89-e88d-08de0b3cfd36
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|35042699022|14060799003|376014|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVQyMUF2L25PMVVRd25PNElDbno1Y1pmNEU0a3dteVE5Z2kvaS9HYWRyTlRt?=
 =?utf-8?B?aU5UVXVtS3JkOFd4OVE1WVdsQjFUYkJvdlZMMUdkMGpCVXNQWmZEVFpIbURy?=
 =?utf-8?B?SWYrbk5mMlhrYmJRdWJIUk1Cai80Zzg1V2ZxK2gxYmZXb0pKZmtIekVvRlNC?=
 =?utf-8?B?US9CSFA1MUh1SmZmb0FPd2pmTHVldTNNbFpvR2dHbldLa0NZKzRkVkhXUE00?=
 =?utf-8?B?M3luVFlRem9oRXN5S0U5UTBzakNzbHRYRUt5WnhRNmwrSnVIckFQZUtKUWtX?=
 =?utf-8?B?UFNsWUllbjNsbzFBME0zRHZUVThQQkhjWVVLR1U1UDY4QktVOHdnODBBSVd3?=
 =?utf-8?B?RXZvR0JMeVJEakVNNGluQXlKMWlxZVJGbHpJaHNuWUJ0NTVPQ09ER0FaYlhR?=
 =?utf-8?B?Y2h4MGFZei9nbDVtelYyNG1YUWQ1OHdKb1FhK2tacHJGUHdicHhVVmJ6VkxQ?=
 =?utf-8?B?ZG9XOGZBVzkyemdtai90V0d3VFI0WjdYRzR0cFpwWXB5ak5hSEZyaXJuVThH?=
 =?utf-8?B?OFBIczdNcWhGRnBTYXlRMGhpeUdvblZGOXlzWDZFOUxkcnJWRC9NZGlNQWE0?=
 =?utf-8?B?NFRma05xdjFhcWV6d0FaWUJ3NmlYamlsT0QxQi9DYXJwM252ZEJOUXVLdmRm?=
 =?utf-8?B?QVAyOW5NcStacnJnRnZDbXpSL1RqODEzOVFWakVTSmgvNDM2QStSOWNBKzZN?=
 =?utf-8?B?a24yQkZ0UGZvQ0dtZjRWWjlLZGdpNFNUWFh3K2t6TFlKNmhTV1pRSWcxRGJ0?=
 =?utf-8?B?SzU5VTFSbU0rRmFEWGtQdHhhV0JrRUFBdzFNV0Evckp3TDY3V2N6eExrZEZ4?=
 =?utf-8?B?MGROYWcxaDFocSt1cFBLOGNuRFFCQmR6a0lTS0E2OHJxSFY1UE8yY0s4OEFB?=
 =?utf-8?B?SnRSNjhrMHRDMCs5SG5oTTJhRGJyaHRQVnY4NVpMVTk5Y0greW00dGtBTzcr?=
 =?utf-8?B?VlBTcVcydFVMQUpaUCtNdnhWTHFUWnUrS1FpYU4vTG5na05TZG5tQU83WFFa?=
 =?utf-8?B?dHl6bTVHK084ZU84cHB4dldORFJQWWk1VHV0cGlLYjQxN002WFRpQ2FkbUhj?=
 =?utf-8?B?c21STXRWQ29SR1hmUE91V2RuRFFuUUpiVVBpRytnOVJyRHA4M2ZMenFxQWQ3?=
 =?utf-8?B?RG5OQjNhSjd3Q2plTVBtM1grMVVuVnh0YTN2ZmhmVlViM3NoejFvSTBwckxR?=
 =?utf-8?B?ek5UTVA3TkVocEtXK094R2h2blY1YXMzNi81Wlk4RmxueUxzeFd2VFJ2dGtr?=
 =?utf-8?B?NGEzLy81ckl4NTJYeFRCSHVpekRCNnRiVG9PODVoQVFsVnpxL014anQ5RDVD?=
 =?utf-8?B?NWxCYS9wNktJTFNISTY1R2FtQlAzWmU2eGdKWVhjZWJKeTdJcEpoaVFDWWZ6?=
 =?utf-8?B?SVYvUitGWGMrU3hZZEw3WFJzQWlPYWs0bFIrSUZld2w5WXN1L01pY1Z5ME5G?=
 =?utf-8?B?MFNvcUxaSTV0d1dPNE5hMERxaWkzUzhTTkFFcjR6OWtIdVRlOE5ST0ZrNXJ0?=
 =?utf-8?B?TVhkc293SUtPZVh5OFIrdkcraVQ0ZWhsbXl2QnpDSVFUWTJiOWlNbnFLYzNC?=
 =?utf-8?B?bkZxZWJtNVpSdEZZRDE5Ry9OU3Zubjk1RldBYktlUDFFRTErYTI3MHlubm90?=
 =?utf-8?B?WVFCWG5PeWdKSlhJZkNsb0ZkSTc2L2VFR3lDb1JoQm1wZTJ6Z2E1T1NzanAr?=
 =?utf-8?B?T0JENjlYKzdScXIrT1daa1ZUMjUyR2w4ZWVpZUxkR1hDYjBkTGtoOElMYXdO?=
 =?utf-8?B?RFhPY0x1dHNhTWUzYjFlekcrZFl2K2lJSGlLaWJVTFVJdDJIbjNrL1J4Sksx?=
 =?utf-8?B?dGRHbllmZnJiUlpTMlArcm1DcVpLcUZHV1VDWjlmdnlaMnU1dzJodUZTUzlU?=
 =?utf-8?B?UnY0SVltLzNZSzlaRkp1TkhqKzhKeTU0OWxIV0x0VzcwSUh3d0dyd201bTgw?=
 =?utf-8?B?TGFpRFhBTlB3STgyL1BYcXBoZ1hlRjJleVB5YlNvSllSRGY4ejFUa3B1M0NR?=
 =?utf-8?B?RGpVbXg4V2t0bE5EOUxVVGV0ejJ0K3RKQ0VabFNPanlsTFFtcnFjU3RibmtE?=
 =?utf-8?B?QzNkRzVjQTFDZmZCQjNkWUtUMk1QVlFPRnNscjI0bDJJRFJhOTVxQ2puZWw0?=
 =?utf-8?Q?KUN0=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:16:16.2119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c26e51d-18de-43f4-50e2-08de0b3d0081
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9460
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

On 10/14/25 12:03, Andrew Goodbody wrote:
> On 10/10/2025 21:55, Sean Anderson wrote:
>> On 10/10/25 16:31, Tom Rini wrote:
>>> On Fri, Oct 03, 2025 at 10:03:57AM +0100, Andrew Goodbody wrote:
>>>
>>>> The sys calls SYS_FLEN and SYS_READ were being used in a way that did
>>>> not allow for file sizes > 2^31. Fixing this required changing the
>>>> signatures of the functions smh_flen and smh_read to allow file
>>>> sizes up to 2^32 - 2 and also being able to return errors that could be
>>>> tested for.
>>>>
>>>> This issue was found by Smatch.
>>
>> IMO this makes the API more awkward for no benefit, as no one actually
>> needs to read 2-4 GiB files (but no larger) with this interface. Aside
>> from this being unimaginably slow on real hardware and inferior to
>> virtio on emulated hardware, there are still other problems. Like, how
>> are you even going to address the RAM on a 32-bit system? U-Boot
>> (AFAIK) only does a linear mapping and most highmem systems will not
>> even have more than 1-2 GiB of memory without mapping over devices.
>>
>> I think a much cleaner solution is to just limit lengths to 2 GiB where
>> appropriate.
> 
> The very slight increase in complexity

It's not particularly slight.

> in the API is a small price to pay for not arbitrarily limiting the
> file sizes that can be worked with. If this prevents someone in the
> future from having to dig in to the code to work out why the file size
> of their 3GB file is being mis-reported

Which is why we should just fail with EOVERFLOW, which is unambiguous.

--Sean

>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>> ---
>>>> Changes in v3:
>>>> - V2 missed fixing up one use of smh_flen, fix it
>>>> - Link to v2: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv2%2d1%2dc1783e4188d8%40linaro.org&umid=1b00a19f-b6b1-4ab2-9d9f-84f132d68ca8&rct=1760457796&auth=d807158c60b7d2502abde8a2fc01f40662980862-e80c0315b3643fb260c9aa5a6365e45e59486c5a
>>>>
>>>> Changes in v2:
>>>> - Fixup smh_flen and smh_read to allow for > 2^31 byte files
>>>> - Link to v1: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2fr%2f20251002%2dfs%5fsemihosting%2dv1%2d1%2d1124e6becc51%40linaro.org&umid=1b00a19f-b6b1-4ab2-9d9f-84f132d68ca8&rct=1760457796&auth=d807158c60b7d2502abde8a2fc01f40662980862-f2db845098a672e64659cbb8927629c60f820805
>>>> ---
>>>>   common/spl/spl_semihosting.c        | 13 +++++++------
>>>>   drivers/serial/serial_semihosting.c |  6 ++++--
>>>>   fs/semihostingfs.c                  | 23 +++++++++++++----------
>>>>   include/semihosting.h               | 13 +++++++------
>>>>   lib/semihosting.c                   | 25 +++++++++++++++++++------
>>>>   5 files changed, 50 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>>>> index f36863fe48d25859ee9af67a67140893b6e9e262..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>>>> --- a/common/spl/spl_semihosting.c
>>>> +++ b/common/spl/spl_semihosting.c
>>>> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>>>>                 ulong size, void *buf)
>>>>   {
>>>>       long fd = *(long *)load->priv;
>>>> -    ulong ret;
>>>> +    long ret;
>>>> +    size_t bytes_read;
>>>>         if (smh_seek(fd, file_offset))
>>>>           return 0;
>>>>   -    ret = smh_read(fd, buf, size);
>>>> -    return ret < 0 ? 0 : ret;
>>>> +    ret = smh_read(fd, buf, size, &bytes_read);
>>>> +    return ret < 0 ? 0 : bytes_read;
>>>>   }
>>>>     static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>> @@ -27,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>>   {
>>>>       const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>>>       int ret;
>>>> -    long fd, len;
>>>> +    long fd;
>>>> +    size_t len;
>>>>       struct spl_load_info load;
>>>>         fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>> @@ -36,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>>           return fd;
>>>>       }
>>>>   -    ret = smh_flen(fd);
>>>> +    ret = smh_flen(fd, &len);
>>>>       if (ret < 0) {
>>>>           log_debug("could not get length of image: %d\n", ret);
>>>>           goto out;
>>>>       }
>>>> -    len = ret;
>>>>         spl_load_init(&load, smh_fit_read, &fd, 1);
>>>>       ret = spl_load(spl_image, bootdev, &load, len, 0);
>>>> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
>>>> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
>>>> --- a/drivers/serial/serial_semihosting.c
>>>> +++ b/drivers/serial/serial_semihosting.c
>>>> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>>>>   {
>>>>       char ch = 0;
>>>>       struct smh_serial_priv *priv = dev_get_priv(dev);
>>>> +    size_t bytes_read;
>>>>         if (priv->infd < 0)
>>>>           return smh_getc();
>>>>   -    smh_read(priv->infd, &ch, sizeof(ch));
>>>> +    smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>>>>       return ch;
>>>>   }
>>>>   @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>>>>   static int smh_serial_getc(void)
>>>>   {
>>>>       char ch = 0;
>>>> +    size_t bytes_read;
>>>>         if (infd < 0)
>>>>           return smh_getc();
>>>>   -    smh_read(infd, &ch, sizeof(ch));
>>>> +    smh_read(infd, &ch, sizeof(ch), &bytes_read);
>>>>       return ch;
>>>>   }
>>>>   diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>>>> --- a/fs/semihostingfs.c
>>>> +++ b/fs/semihostingfs.c
>>>> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>>>>   static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>                 loff_t maxsize, loff_t *actread)
>>>>   {
>>>> -    long fd, size, ret;
>>>> +    long fd, ret;
>>>> +    size_t size;
>>>>         fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>>       if (fd < 0)
>>>> @@ -34,19 +35,19 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>           return ret;
>>>>       }
>>>>       if (!maxsize) {
>>>> -        size = smh_flen(fd);
>>>> +        ret = smh_flen(fd, &size);
>>>>           if (ret < 0) {
>>>>               smh_close(fd);
>>>> -            return size;
>>>> +            return ret;
>>>>           }
>>>>             maxsize = size;
>>>>       }
>>>>   -    size = smh_read(fd, buffer, maxsize);
>>>> +    ret = smh_read(fd, buffer, maxsize, &size);
>>>>       smh_close(fd);
>>>> -    if (size < 0)
>>>> -        return size;
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>>         *actread = size;
>>>>       return 0;
>>>> @@ -78,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>>>     int smh_fs_size(const char *filename, loff_t *result)
>>>>   {
>>>> -    long fd, size;
>>>> +    long fd;
>>>> +    size_t size;
>>>> +    int ret;
>>>>         fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>>       if (fd < 0)
>>>>           return fd;
>>>>   -    size = smh_flen(fd);
>>>> +    ret = smh_flen(fd, &size);
>>>>       smh_close(fd);
>>>>   -    if (size < 0)
>>>> -        return size;
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>>         *result = size;
>>>>       return 0;
>>>> diff --git a/include/semihosting.h b/include/semihosting.h
>>>> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>>>> --- a/include/semihosting.h
>>>> +++ b/include/semihosting.h
>>>> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>>>>    * @fd: A file descriptor returned from smh_open()
>>>>    * @memp: Pointer to a buffer of memory of at least @len bytes
>>>>    * @len: The number of bytes to read
>>>> + * @read_len: Pointer which will be updated with actual bytes read on success,
>>>> + *  with 0 indicating %EOF
>>>>    *
>>>> - * Return:
>>>> - * * The number of bytes read on success, with 0 indicating %EOF
>>>> - * * A negative error on failure
>>>> + * Return: 0 on success or negative error on failure
>>>>    */
>>>> -long smh_read(long fd, void *memp, size_t len);
>>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>>>>     /**
>>>>    * smh_write() - Write data to a file
>>>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>>>   /**
>>>>    * smh_flen() - Get the length of a file
>>>>    * @fd: A file descriptor returned from smh_open()
>>>> + * @size: Pointer which will be updated with length of file on success
>>>>    *
>>>> - * Return: The length of the file, in bytes, or a negative error on failure
>>>> + * Return: 0 on success or negative error on failure
>>>>    */
>>>> -long smh_flen(long fd);
>>>> +int smh_flen(long fd, size_t *size);
>>>>     /**
>>>>    * smh_seek() - Seek to a position in a file
>>>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>>>> index 9be5bffd30124777c4f8110065e6cca5640312ac..a0f42d41e4a7ad95023c684f6824bfc677ad25cd 100644
>>>> --- a/lib/semihosting.c
>>>> +++ b/lib/semihosting.c
>>>> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>>>>       size_t len;
>>>>   };
>>>>   -long smh_read(long fd, void *memp, size_t len)
>>>> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>>
>> But really we just need to make this return size_t.
>>
>>>>   {
>>>> -    long ret;
>>>> +    size_t ret;
>>>>       struct smh_rdwr_s read;
>>>>         debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
>>>> @@ -105,9 +105,20 @@ long smh_read(long fd, void *memp, size_t len)
>>>>       read.len = len;
>>>>         ret = smh_trap(SYSREAD, &read);
>>
>> This is a separate fix. Please break it out into another patch.
> 
> OK. V4 coming.
> 
> Andrew
> 
>>>> -    if (ret < 0)
>>>> +    if (!ret) {
>>>> +        /* Success */
>>>> +        *read_len = len;
>>>> +        return 0;
>>>> +    } else if (ret == len) {
>>>> +        /* EOF */
>>>> +        *read_len = 0;
>>>> +        return 0;
>>>> +    } else {
>>>> +        /* Partial success */
>>>> +        *read_len = len - ret;
>>>>           return smh_errno();
>>>> -    return len - ret;
>>>> +    }
>>>> +
>>>>   }
>>>>     long smh_write(long fd, const void *memp, size_t len, ulong *written)
>>>> @@ -140,7 +151,7 @@ long smh_close(long fd)
>>>>       return 0;
>>>>   }
>>>>   -long smh_flen(long fd)
>>>> +int smh_flen(long fd, size_t *size)
>>>>   {
>>>>       long ret;
>>>>   @@ -149,7 +160,9 @@ long smh_flen(long fd)
>>>>       ret = smh_trap(SYSFLEN, &fd);
>>>>       if (ret == -1)
>>
>> Just change this to
>>
>>     if (ret < 0)
>>         return ret == -1 ? smh_errno() : -EOVERFLOW;
>>
>> And now all the existing code works.
>>
>>>>           return smh_errno();
>>>> -    return ret;
>>>> +
>>>> +    *size = (size_t)ret;
>>>> +    return 0;
>>
>>>>   }
>>>>     long smh_seek(long fd, long pos)
>>>>
>>>
>>> There was (as good thing!) much review and feedback on v1 and v2. Is
>>> everyone happy now with v3? Thanks!
>>>
>>
>> Sorry for the delay, I'm not working on U-Boot at $WORK at all right now
>> so I don't have much time for review.
>>
>> --Sean
> 
