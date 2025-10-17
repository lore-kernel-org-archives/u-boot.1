Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B318CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 17:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B753683849;
	Fri, 17 Oct 2025 19:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="nwlCXwY+";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="nwlCXwY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9798386D; Fri, 17 Oct 2025 19:08:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A1283837
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 19:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kj1zB8sV6IU5UuvvKI+eJnk09kHpqZgMTI+JuhcNlKJ9JFULUu7JmHvGuKj/AACH4zBN7v7L4iUaxM56sNks1NO1v1x/CvwB1QC7LpSDq4xXD9r6CBqi5L1WVSzNtKFacN/bHJJWKYNTEGTfBV7TY0EnV9vsObTLS49axTngLCbjvxs6iyrqCWCONIZH5w77J5vFQqWqE/8BBN54Z6R14aZEP5JBTsp7zwdO93nUVZPa63rBQbYGuxRTJjuFIoBAGd4NfpVwhDFin/hXKoZdInJuKNHN0LC5j3QnJlW/Mbagcvx2m3uiyoyKwf7tEaC4/4is7pQq88gAapkRZP84aA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUN867AJD+3nCS46qtvZ/OCAdDNF7IhPtJIFzzne1qU=;
 b=toDPO7ycDbFfml4VtxD4uOoXfwUojRqUFd+AU35pf6pqU0KKbpnmZvU6YGpkqIjwepCwhgEFJ40dwYYA8elsYSYIdU+Q2GBlcgmTk3HxXfAF50gnGrzG2LTKQYCS228K+ga31JL8jh1OLqqIVICrHkrcWgRxw1H8SOLX2KjFlCaF6GeCHBAlUHQeGwB15Ud4uxLjahrP+3lkiaIZGwF59KnxbnRt55B3/3f9MzeYhqLA+hQU4tFjGtkHuRhqcKkHNreLeFQcJMq+lAJO66VtH7q9OO6PkL6wiMqyAwcszhIe8pcq6mEaSr6c2AWzkYlBsGvmmAMUs/r2/V2j297mUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUN867AJD+3nCS46qtvZ/OCAdDNF7IhPtJIFzzne1qU=;
 b=nwlCXwY+Q4K4oYnqhcwf9uXqFb/cHieZIUxLBTl5yzwppizqf6uC4SbbNDS0hpsA/MVaG9k9Nt2REJQuwKZO6U+gB/ZtVdxncHr9F7o4yfW/nG6Z+afmBxT1IfPqPzNurekOVhfIBuDFSzE7L8BbbhOTktNX+TJjyttmR8RQ3hLUnoOD4viUl7SPjRI5DkZoyMjl/LakrolZ4sinmL0ocTx/7+0BqM0aAQunQhaHhn/mbCoM9Y1tX8ivKIPdJm9T/V2rvW78qOyYzhcHOg30Vb3OsraYn0AsUwCLDm7Vf/OQI1mw9LAlRyvV1AFygVrUgCjxTEHIg68Zk6iFXHUCDQ==
Received: from AS9PR04CA0054.eurprd04.prod.outlook.com (2603:10a6:20b:46a::12)
 by DU2PR03MB7974.eurprd03.prod.outlook.com (2603:10a6:10:2db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 17:08:32 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:46a:cafe::ba) by AS9PR04CA0054.outlook.office365.com
 (2603:10a6:20b:46a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 17:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 17:08:31 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 999F8200831D6; Fri, 17 Oct 2025 17:08:31 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (unknown
 [52.101.70.131])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8F63620081246; 
 Fri, 17 Oct 2025 17:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsjGNX0mc6ArWm15Tj2rzKnn1xmlBXmkLjFGqVQM3i1FCrfV+TKVUtgcTQfVYjACwHr8NVCSiIgzQPm+drmSURHHow+mHltG+GyzX8bYgkauI2oQj5a41Z2LItNj5R6SmzYXRv3iRbICz9T9nU+nRyo3wh7LfX59egsUTdw81FbaO9fMH3UoJoOZlX2HpzfdvLyABbiSHaBREX7Sz4LcdBOa9qEBffJHCzeqcMrE4IMux107fcFj8mBs2W3rpaBF7SZ+AvlfZAFHXGtAmSUgq07aEEV4ClPvF1iPpWLB5esjrzvJ+8/CU4e9/Gko65v6UFgygDVNljZM0GjlQYWlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUN867AJD+3nCS46qtvZ/OCAdDNF7IhPtJIFzzne1qU=;
 b=nGTYPKSBtupe2cefjONevF4sCBAbBaxKdW459fxcckB0MIhWKO5tQL5MMmCnJk35CaAWwqw8wJShRUtW2MDpIC0+qwaLo9JZlyqR4PLtldEc7tBqPBQ/zv1OsG5uPNQ7skRWWomzxGY4z9ymiqEjEtmuOB0BebpgGMxUpR9UwHeEB7mfCeZTujlaFhAmxvZ3Mlh2vCY/YY01MoX61SoEDH8l3rJoXvjiJukrNx0F6hxNytjBTp29O2wgtKnOe4yf+xXPkacxLvOp9aCkVLiN+iTGUqqnjJsozCBHcersIaYvba2GOKI7A/wl6XKI+acgUvghWh40Wj+vPRuW7Lha3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUN867AJD+3nCS46qtvZ/OCAdDNF7IhPtJIFzzne1qU=;
 b=nwlCXwY+Q4K4oYnqhcwf9uXqFb/cHieZIUxLBTl5yzwppizqf6uC4SbbNDS0hpsA/MVaG9k9Nt2REJQuwKZO6U+gB/ZtVdxncHr9F7o4yfW/nG6Z+afmBxT1IfPqPzNurekOVhfIBuDFSzE7L8BbbhOTktNX+TJjyttmR8RQ3hLUnoOD4viUl7SPjRI5DkZoyMjl/LakrolZ4sinmL0ocTx/7+0BqM0aAQunQhaHhn/mbCoM9Y1tX8ivKIPdJm9T/V2rvW78qOyYzhcHOg30Vb3OsraYn0AsUwCLDm7Vf/OQI1mw9LAlRyvV1AFygVrUgCjxTEHIg68Zk6iFXHUCDQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU0PR03MB9707.eurprd03.prod.outlook.com (2603:10a6:10:44d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 17:08:26 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 17:08:26 +0000
Message-ID: <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
Date: Fri, 17 Oct 2025 13:08:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <20251015162858.GA669557@bill-the-cat>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251015162858.GA669557@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DU0PR03MB9707:EE_|AM1PEPF000252DB:EE_|DU2PR03MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b442bcd-126c-4da9-d82f-08de0d9fccb1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Q2FtTWRNNTlreis4dDlSZW9pVURPTHFQdWpGZWxtMXl4YXplQnk5RERTbkZ4?=
 =?utf-8?B?WE9wdmdieXFKeEpCWkRualIrM0F4enZUaVoxa21SVGlaRkdxSStYNjNLVnI4?=
 =?utf-8?B?UGVRb1dBM0ZtUHB5U1lCOVRPalBsY0ZCREg1WTk4QUlVWW5rOHpBbmEwUEdy?=
 =?utf-8?B?VllZUmkwQmozMTBUaUlPUkxXd1MxbVZOZThJSy9zN3FSbWF4WEpIUGdMN3k2?=
 =?utf-8?B?TmxhTEtlT1RQUHR4TVh4a1lJdWc4UDdIQU5jUEVaM3hjUWRGREpYNFBZZXht?=
 =?utf-8?B?WHRVd01WMWsyMVY5UUYyTWRpb0JCdWFhMVlBZ1Rpd1BLZUZvc3hUcXp4ck9P?=
 =?utf-8?B?NktPKzhZRDh0UTM3Y2ZHY1ZZZFJjKzE4OHNtK1psRUpLcGtOTysyd2NRazNh?=
 =?utf-8?B?WldyUXBSU2FlOVFFRUJlaVNnMXF6aTc5bzNaa3hhdm85WkhqOEZ0V1oxV0J4?=
 =?utf-8?B?OFd5Yk03eFgyLzFmamtPdVFkUjBDcUhIdHkzUndpdmlHcTdXNWxqR1lKcVll?=
 =?utf-8?B?WGp1TU5BZXJ0dXgzQ2hNYzMrLzFDMHZONENEL3htSkR0SGxUZ0dmUzYwdkJx?=
 =?utf-8?B?eWI3VjRROEYrazM0VExBWjZSYzR4OEVPSU1iOEZrV3hJK3o0L3N4Y0FnQVNr?=
 =?utf-8?B?Tk53ZGJZWStjSTZuRWkrakNzNzdHbm5yaU5uT245bnZUYklQVjE1dWd2TnUv?=
 =?utf-8?B?TUdLbks5djVYcStOZzBjZHJMYllEMXdmUU1VOVdPU05JUDlTa1I3QkRsODFn?=
 =?utf-8?B?K25lcVBFeUJBSXpFWndBQWE0cUhXcTl4VWNsY0l6VGFXM1R6UlFaZ1plTEtR?=
 =?utf-8?B?QU5mY3RLV2l6VHlqMkhDaURBZkRLcjluOENSWllDVXFqSTI5SjJKRWVERzBC?=
 =?utf-8?B?ZkdnYzBYMzM4eER3MlB6VGtiVFI4MFBJNzdpRUF4Ynpxc1VkZUxic3lLS1E0?=
 =?utf-8?B?ZWpKajAwTXZpczBtcUpQZVJhVGdIRTgwYzY4OXd2c0U5SFdrUm1ORU1kMGxG?=
 =?utf-8?B?dWI1UTVJWGFwOXY4ckFvYjZJWldzSzdpb1FrMkd2ZCtkdVpVbVRiY3NySEhB?=
 =?utf-8?B?WnZQdVFtL1E4WTEwTUFiaEdkVTU3OU1LbThFZFUrbDZldlVVVU5HeGZId2tj?=
 =?utf-8?B?L2h2TmV1bEhWMTJKU2F3alJmYnpLS21HUFBaSVJoK1IzbmhoK0xZNXRiNi95?=
 =?utf-8?B?VzZyaFlBZkxteUNzdGJpblJ0eFNBcFFqOVlrVm02MHNGcVB3MHU1UGlDQlZL?=
 =?utf-8?B?N25mMUFnOW1SdmdLY09xaGFIRVpmUnNTU2FJNWU0aW5yTUFubHBhRnV0d05N?=
 =?utf-8?B?WlRFa3YzaWZoSVc5VWI1dUgrNkcraFR2VzE2REI1T0dFVmwwMmJZMkNVU08w?=
 =?utf-8?B?YWpDZUhWNnJzTkg3MGM1clo0ancwbjNjS0Z0VzRyT3lGMTFRVENoSXA2OFNz?=
 =?utf-8?B?blJVV2k0KzZOWmJ5ck9TWUwwdUk3c3JreUd1bXhPdkxGbHE3SEkvN1lmZGd2?=
 =?utf-8?B?dFljZ0JQZTh0QzIwZW96cTFOVThweFlBSEhPZE0rN0JudEp5N25xSWhKK1ha?=
 =?utf-8?B?SjEzcWhPakxZTVJiSlN1RzN2QmV5bndKdFgwV0ZWaW9HRjNEZTc2RzNkZitr?=
 =?utf-8?B?UDRIUUc4dHZVS1luaG10eGpNUFh3cExoWVJKS3Q3aEFrN2g4TG40dXhiak5Z?=
 =?utf-8?B?QmNMZnVnTEE0UFgvbnFuUDJRN3NYK0FwQStOTHlUSUNTa3pJME45U1RCWkRm?=
 =?utf-8?B?THVTNjdNNjhyeE1YclVEc2RPbTlaTlB4U2lHbWM0SXpPWUJIaVpLZmxvUm1N?=
 =?utf-8?B?bTNNWWpOVUV4aVdYSVNVMzFNZ1poOG5SMHVyaEhBRWJOYmJWWXBQM3ZNRkpv?=
 =?utf-8?B?REFTTnNRNGpFM240VEorVzhuQzdUTDE1Zi9nNjQ3OVZiZ2xtL2UvOE9tTk8v?=
 =?utf-8?B?Q1hMMTR2OUlPZ1hrQnZxMVBBYzZWdnBVdUgxUVVXNis2TThiOGVPZmhpSFVK?=
 =?utf-8?B?SjYwTDJiRGx3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9707
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f06533eb-e37d-4979-af7b-08de0d9fc910
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|1800799024|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUJ1WEVwWXAvb3dVdEhTa3dDcVBrazF4Ym9UQUpWSklnOHRQSW52UitxOGwr?=
 =?utf-8?B?QmtZVzVWU0ZFWUkvWFBSclRDZHQvaFAvd0ZLdXViTmpUQlB3elcxQTFPTkdJ?=
 =?utf-8?B?TWs1RFQ0QWl1VWNnUDJQbkdBOWtvci95MFdFT094THVpSjVGSDBkMi90dFBD?=
 =?utf-8?B?L1NSRmMrekVVanRpSmozLy9hN2pjMmtwNmZUU0hFSUN6NStzVDZMRVBqUy9w?=
 =?utf-8?B?Zy9HRjJobU9yZklMcHNYTjlwMG9ZUE1LSnRMbnBvQTQzTWlQQTFwdjl5KzhW?=
 =?utf-8?B?NklFajVHcDJZVVozSTJreWg5WVZ5Kzd2ZnZNNmxpOGg1NTJaUEJ1TUVGWlZu?=
 =?utf-8?B?RG5xZGR3d3FWOXNkSFpRZ2VFb3lSZ3VQN0hOemMxb2FWWnBHZ2tUeWkyUlE4?=
 =?utf-8?B?YTF5aG1NODczb1hmYVBYVXE0Qmx3TGVTSVBLeVZhOTJjT29SN2podjE3aVlz?=
 =?utf-8?B?dTY2ekR5R3h0cEYrUU5qRTdja09RZDVWckJ6Z3ViV2FZZmw5TTNnYU93bHFS?=
 =?utf-8?B?UmgzMlZleGUvclZTMlBqWUxkSEVCK0JnSmNUSmVyYXlUWTI0RDd4YStKQ1Bv?=
 =?utf-8?B?TzJKK3NTem1FV3ErTzFSSGxEbDFMSnM5clhNNXFjU3dubGROckV1NEZQQ21T?=
 =?utf-8?B?WHpVMUdrb3hsL2VkdUxGZTJvRnR3aTRORTN5d2s2a2EzK3QvSmNLSGxvb0lV?=
 =?utf-8?B?M3ptSHhEQmtLOCtLVzE1eG1GTENucFQ2dHhWNk9aSUVRTkNlYXQ2T3pnNlVv?=
 =?utf-8?B?eUhWelpESWh0QnZkZkFqazZMZG94VTlPSlc1eGVMZ2llMDl3MnY4L3VnU0xt?=
 =?utf-8?B?NTRRUWZaN3JDaHVOSTVJdGlnbmM0SCtsTkNiYXJjdTlnK0RKajV3Y0lJRlZ3?=
 =?utf-8?B?VzNpb3N0NnR1cThqTklXOEpzU2F0YXVZcC8vZUxKQUFuM0xqR0dhTGtoRGcz?=
 =?utf-8?B?TEptMkk5UWZGNHdTeTBaZmVuUDFVdHo4dW1RM2Z3cVVKUVUrdUNnWlJ0Y29n?=
 =?utf-8?B?eGlJdjVIanl3anBGWWFGdEZzTXVSdUlHeHBjc3d0Yjl0MEZKU2VLMENZRFdL?=
 =?utf-8?B?Z25CTnFRMk9Nbm1DY294UFlKUG5hS0dLSUxTMkVwaDd3UmRIQXBBT25vOGlO?=
 =?utf-8?B?UXE4Y2tvaUcvVVNTalY5U29tYXBXK3g5dnIzeWMyOHJGeW54U0ZSenhjTUt4?=
 =?utf-8?B?TjJLUzdKbkhWazFOMTJMbkZTbnp4THBQbm90eW96UnF2OHlnMjd2ckMrNSsx?=
 =?utf-8?B?TTJqWDl6YkFpSjZhZ1AvQ3NlSWhRaWxRMVcrRDJLUXM1VlgrTElyMkIyUjZh?=
 =?utf-8?B?M2xCdzVLdXVtYTNkb0J6a1RnVkNYc1VwdkI4aERNU3ltdzZwQWlsb2h5V2FV?=
 =?utf-8?B?aVhXSzkxN1E4d0xEa3VBdFY1M3dCUGJ2ZTJnd2pmT2VvSnlSaFhHTXVPUmtE?=
 =?utf-8?B?NG9NcU9BcmpzK1ZHUzZkaEhyUmQyNUtkZEI5L0N1V0JEbS9laWkyMXlnVzAr?=
 =?utf-8?B?QkU1eHdhbFVwSVhtblEyUHB2OUVWSEl1b1BXQlZFZmxqYThjU1lTRFlNa2dn?=
 =?utf-8?B?Mko1Nys1YVlYVmh0SkV5WExZNlE5R1ZHdHFHQ1R2VmM3V2pGK0E2dmxPajBH?=
 =?utf-8?B?VjFpVnZBYzFvdzVENHNaZ3A1WlJEWWM0b3pjU0ZnbmtZaTFFV09aYlBiODUz?=
 =?utf-8?B?M1JZQkVwWFVZZGkvVHMvR3pMTWxoblVSODNGRWw2OFlnNVZXaTBHZ2VUTzEy?=
 =?utf-8?B?aDBuRTBjZU1BWVJHRk83WU9BdkcvK2VmcDh2c3BwYk5zTDlQY2NNSXhZSXRS?=
 =?utf-8?B?N3RTb0dWRlRHSVFQc3doTThPeWhZM0hROWJzOWk4WUxOcnJrN2dack5sZTM5?=
 =?utf-8?B?clVmeDA5akhMOTRVNk8rMUV3T1ZsekU5Um50bUNsSVlzcWVSRlNMOUNXM2Ey?=
 =?utf-8?B?czh5S3cxaThBLzlMazg1eExWSytnY0o0eWU0L2pNNlloMGE5bHdEOXMyYXk0?=
 =?utf-8?B?WE9mNUlKSGhRS2JlYUd5YVBUYTJaYUhudit1WEplR3poYnYwdEJRQmpuMmto?=
 =?utf-8?B?TW5uRDRkdVcvMEI0a0hCRE9zYkFSQ3BxZFhrTWNmbFVha2xpKzFpNm1jVW5q?=
 =?utf-8?Q?3zto=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 17:08:31.7914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b442bcd-126c-4da9-d82f-08de0d9fccb1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7974
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

On 10/15/25 12:28, Tom Rini wrote:
> On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>> > On 10/2/25 11:39, Andrew Goodbody wrote:
>> >> After calling a function that can return an error, the test to detect
>> >> that error should use the return value not a different variable. Fix it.
>> >>
>> >> This issue was found by Smatch.
>> >>
>> > 
>> > Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>> > 
>> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> >> ---
>> >>   fs/semihostingfs.c | 2 +-
>> >>   1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> >> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>> >> --- a/fs/semihostingfs.c
>> >> +++ b/fs/semihostingfs.c
>> >> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>> >>       }
>> >>       if (!maxsize) {
>> >>           size = smh_flen(fd);
>> >> -        if (ret < 0) {
>> >> +        if (size < 0) {
>> > 
>> > The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>> > 
>> > SYS_FLEN (0x0C)
>> > 
>> > Returns the length of a specified file.
>> > On exit, R0 contains:
>> >     the current length of the file object, if the call is successful
>> >     -1 if an error occurs.
>> > 
>> > Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>> > 
>> > %s/if (size < 0)/if (size == -1L)/
>> 
>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>> 32-bits of information. The host must detect files that exceed 2 GiB in
>> size and return -1 (simulating EOVERFLOW).
> 
> OK, but this is for 64-bit systems too, isn't it?
> 

Sorry, I worded that poorly. What I mean is that the spec says

| On exit, R0 contains:
|     the current length of the file object, if the call is successful
|     -1 if an error occurs.

which implies that R0 is a signed integer (otherwise they would have
specified 0xffffffff or 0xffffffffffffffff as the error value). So
negative values (other than -1) indicate a negative file size (or are
unspecified).

However, both OpenOCD and QEMU just take the return from stat(2) and
copy it into R0. With a 32-bit host there is no problem since stat(2)
will itself fail for files over 2 GiB. With a 32-bit target, this
produces erroneous values for files larger than 4 GiB. Files sizes
between 2 and 4 GiB could be recovered, but I don't think we should do
that. On a 64-bit target, there is again no ambiguity (at least until 8
EiB file sizes).

I don't think we should try to interpret negative values because it's
ambiguous in the spec, the hosts known to return such values do so
because of flaws in their implementation, and large files themselves
have dubious merit.

--Sean
