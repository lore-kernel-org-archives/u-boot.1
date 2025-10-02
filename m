Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDD5CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 14:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 120C8828A2;
	Thu,  2 Oct 2025 16:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="SJsWARYG";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="SJsWARYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED72A834D4; Thu,  2 Oct 2025 16:36:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5611780107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 16:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n6hB4oEXwr+yPwUNzPJb09gRso5Xn6FyV7pquTFfR4+aRE6rHRP8vH4JlBIinJih5ydOG2OKHk8XzUdPn636cxC72PGE6SqFjVTE6NkpNA//Rz69qI7VgDSB2yI2Z6YLjFYycjm7dggeNHnlnn/CsNT87YMS1t8nLRqLByUFXCP8k5rvjV8bflPSwOLVEWDVnflUyb1+b/BajU8yRn3uPWh3DlPmqiuVBugC3z1Ldw8qFWNHxpasHPbgi3OCox4WD+Zjqms/eIDUiqxB2GC9RXyrqM1issi1S+zl6L2zhDm7tCeFERjtdcVRJ1aaslcVWUz2COfeOFtdQcktRBYn/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+lpzGBmuf2Cq0OiIay10/N+l5yAFGwzaP3dHe+2t28=;
 b=ELHSEAEfOjSgHdASRFYne1FCO6Kj3OfZ8YnHF65QoJupYmnjw/uCkSYTSbhDkPtpdPWhjg0EvtZLkKZRzZqPEc8lFxpZkd/DG3MQMnz6R9m/l5CdJrDb9oxNFj7+D78Z5yR6Z5EmKKija6aSdrpJzQIf3ldz2TeXmga/530JivInebFArjT23YlazFz0GeKFjLjbDUe8MAZbXNaTzOwxGeDQP/o0MoNjQX3iv2S2jgPJucH9c+tHnh2QfTdfDYDwlMAD5RRpLqa8VAK7sHDeCsZR+ZkY67LiHjBWbv/O2AprxkUJArQR8ZSTOx5geZ2a4ccZ3c5GAzZ1fA/ZzuOKPQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+lpzGBmuf2Cq0OiIay10/N+l5yAFGwzaP3dHe+2t28=;
 b=SJsWARYGlH4onAhieTpp60DO1Gn9enYDRjjujCSMCO4298hq5pGcX4OE/s2VlmMFtTuPn3ejJF7YNRvCPUlhmaPR5MTm8hL6ukF8BlPTJZBWRw/YZtWhAHn4f70YnyhP76jEG+qMIYl1EfAzJBehM5bD1zKpNSZfsqAzdJ1begYHgz7KatNKPUy/NZFkq2LvgQbW+MxIPQjzKU66/EmQbkwMRjVze6RNqv0cKIp14j0Uye5ShXhESw7RTFmYFAKguKN2OSevDfGTccDrDwqk/RcsIDyTl6D+ww9HfQOIH9VNFgzWZOdowd5uR4g/HK1YCgt5MkFtRJEMdk2loM6B5w==
Received: from AM0PR02CA0114.eurprd02.prod.outlook.com (2603:10a6:20b:28c::11)
 by PA1PR03MB10625.eurprd03.prod.outlook.com (2603:10a6:102:492::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 14:36:15 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::86) by AM0PR02CA0114.outlook.office365.com
 (2603:10a6:20b:28c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Thu,
 2 Oct 2025 14:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Thu, 2 Oct 2025 14:36:14 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 8E6D92008161E; Thu, 02 Oct 2025 14:36:14 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [52.101.84.124])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8BBC1200C4FEB; 
 Thu, 02 Oct 2025 14:36:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRcJvFWS0lWAJN/SnwH906YOG0xYoq0ZsdFxvVAf1d2bN/r4fpR2LGMadjh/a/uRNZjLIa78IGgSL7gDTQ2j+cG0VwhQ2g9Pi4B/qKycKsyzfChDIPraANCkOvnrpH2DHs6AU9P36qN20apO/+dGacqbB6rk6GNqaSepd7lGmbc3UCVdb+57KlQ+qJt6lpxgt3uxvZDxKPriOBjKOmE9dj+o+DoZWLRZ2W+vrCn5GsOU/Wb2aOXurx8DzcoSGfW3BcDfX/39FxNHH7f8Zhn0hHtCrVI1nYLlWOm87MuQ0/9m3ztWLACXWwgs+PfPk0stzsX1Sx8v/ls5zTV+r6krnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+lpzGBmuf2Cq0OiIay10/N+l5yAFGwzaP3dHe+2t28=;
 b=MYvBF8iq4st6XAAv2QfBsPtF+Fjm9FLHKrYI54MNtRM/z6qGhcbq68TP4kdwBu9fFU1fZGoyQ71xxheAAbsWfWTDKYT6OW42mDY5Kjt3ywH4iA+Oq8TFUEEYdkWEXGM6ZWhlmajexoYDuu3azUUWZgBiKTBxlxZNNAfQ1HX5AiFqUGWjSmyx+GPdgr6tPBW3wBoG0UaSjeX9Fn+CJB8hD9uUwM8UWtRl0GIib1CFelYn3wkIBCXi5lQvPEJe5BhZWCyEnBLijw1LpoQ65Odvs3JaaD01hMFrhVc2VllO5MnfznPwxYy5PEDiqw8Tqk58kg/Arr5HanGbTTjxavW8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+lpzGBmuf2Cq0OiIay10/N+l5yAFGwzaP3dHe+2t28=;
 b=SJsWARYGlH4onAhieTpp60DO1Gn9enYDRjjujCSMCO4298hq5pGcX4OE/s2VlmMFtTuPn3ejJF7YNRvCPUlhmaPR5MTm8hL6ukF8BlPTJZBWRw/YZtWhAHn4f70YnyhP76jEG+qMIYl1EfAzJBehM5bD1zKpNSZfsqAzdJ1begYHgz7KatNKPUy/NZFkq2LvgQbW+MxIPQjzKU66/EmQbkwMRjVze6RNqv0cKIp14j0Uye5ShXhESw7RTFmYFAKguKN2OSevDfGTccDrDwqk/RcsIDyTl6D+ww9HfQOIH9VNFgzWZOdowd5uR4g/HK1YCgt5MkFtRJEMdk2loM6B5w==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DB9PR03MB8281.eurprd03.prod.outlook.com (2603:10a6:10:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Thu, 2 Oct
 2025 14:36:11 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 14:36:11 +0000
Message-ID: <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
Date: Thu, 2 Oct 2025 10:36:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::9) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DB9PR03MB8281:EE_|AMS1EPF0000004A:EE_|PA1PR03MB10625:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfdf287-c10f-4594-ec25-08de01c10a5d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VHlXQnE3OSt2TFN3MWtCT1hPdHIxeXN4YUtBck5xQ2F1LzdlNWFmOW5ISUd0?=
 =?utf-8?B?V0dmQTR3K0t6TG5JcU1NYjRaVVllMUQ2amltSEt2VmZoaVFycG9lK2dyT2h4?=
 =?utf-8?B?ekZ3Z0p4aHNuZ0VObzhxWVpiM3J1NXA3aTVVKzd2Q1FxNDg1NkNFL0R3bmZp?=
 =?utf-8?B?bDdhSU1TVXZTcVNQMFpaNjhzOWljRWRiZWZESjFxaUhNeFZFVktkaStBbWsv?=
 =?utf-8?B?V1Z0K0RNbGJ0OE5sSDQ2ZXhjaFJpdTJycXFjK0tIdU8yK1ErMUxYSDZHQkVv?=
 =?utf-8?B?TDVRSE1YQjJ3K0tDQ1dMVDNUNklXeFV0UWRIaTR2UzdtS2J0YVF0VEUxVkJU?=
 =?utf-8?B?T1lFOTJFRDRheTF4WmxOTHgxeVdxbXUvdTBDeFdKNFY4QngrRm93NGQvbC9o?=
 =?utf-8?B?MDlJcWJMTWZ6empLQ2d5eVFsZ1luVTdOa2tFMm9DckUyVm9BSkZDemdGQUlz?=
 =?utf-8?B?cE81bTc0NDJJVFJRRi9UeGRmWVZiSzRlK0E3VTU3NWdZOW5MbDNDR1lTbENw?=
 =?utf-8?B?ZlEzcUd5RUQxeGFCVzVJa29uMVlxY2ZXUmtBU2F2OWNFdXYwMGlCazV6RWI3?=
 =?utf-8?B?UGN3MG1zb1A1UCtUcm9NcEVESGp2dnh3a09VODhkRUJCbVRxTXRPWHdIc3hG?=
 =?utf-8?B?aWdtYjY5c2VhSk9wZytWSzFCa1phdWVGRkp3bi9Edm1PRUJXTXM0UUJ1Zy9N?=
 =?utf-8?B?LzljSEpSQlI1RXRHcjM3ZWxyNzgzVktBYVNLcVA3VXJJa2FtUkxVOXdHNVpp?=
 =?utf-8?B?UTM0SEpxZFJ0dW5VUkE2QkdKdTkramErbXZtLzR5bVR0SEVkNFVienA4bE5V?=
 =?utf-8?B?bUQwdWdLaWpGTlhVck5mUkk2R0FwcnppeDk5ckhRY01wVVMxaXJaaHpTVnpH?=
 =?utf-8?B?T0IvN2luTGZkdVdDeVVRRVBESEZtUnRJVHNsZkR2NEExTEFkNmxZYXpEaFZO?=
 =?utf-8?B?dXp2Tk9ja1NRTjR0VGJzSkVWUDd3M0EwSHpwZ1JlSXcrcHF3MG1PcUhwZFJ1?=
 =?utf-8?B?dkQ1WVRjVnJHSGd0UFp5ZmtmODBOTUszUjlZN3FFNGFVU3JIYmVFK1c1MVY2?=
 =?utf-8?B?UU5jMTZ2RUUzeWxrcDEvbTJoQVdKT0wwNEkvTTluWTBGSmF4NFhUeTM3M0x2?=
 =?utf-8?B?WWQ5QjF5YzliM3lkVXd0UU1YYjZxQjM2c0ROV1RxS3c5UXExL0pUeEZEZXNr?=
 =?utf-8?B?aGExeVNKY3JsTzFKdmEvUXIxV2hLQmpFc1hxdzFza3RkakJ4aCtLUU9JSllG?=
 =?utf-8?B?MXNkU2tOQmpRT2RhOWhyQ1UwWEY5eUZyTnpSaFpHa1Jka2E1ZDRSNWVpMkdT?=
 =?utf-8?B?N2RLOGlrcHY1TkRVR05BajFnd1dQU2hFMmZRNklia1podnNJbEp3cjNWeUpa?=
 =?utf-8?B?MitIZjRZdHphSnZ2cklVUWp6Y09IQVg4azVrbWpDWWMwN2NEaVMyL1diNWhp?=
 =?utf-8?B?c3c5eFF1VzVJQkVGYlBCQ0ZncmFxVDA3eUZWMWdVRzd4NTg5UnQ1NmYzS1pu?=
 =?utf-8?B?dVN3VHhzemszc0cvdWQ5THRBZlJraStWcC8rdUZvckxCY0VPcnViRTVjTzZp?=
 =?utf-8?B?NlVNcVh5TnNkSHFRcjM0WnFnS3l3WVRpZ0RXeTV4bHJOYWFxNXZpVjZQWHhr?=
 =?utf-8?B?a0g5WmphY2dZQmdkNWsyQloza21VSmh2QjJiN1VhVU9BZCtnWmpadUVyaVc1?=
 =?utf-8?B?R3NnekRZUmJ6a3NXQzRJc3RXVkhuRnNENzlSWTlJYVBUWllMcXQyRGQ2eSs1?=
 =?utf-8?B?V2NieEJ4alVqOS9KWngrZjc5b0NMUXAzUE5ISk9zTGNRYk42ZG9iMkVWUVo2?=
 =?utf-8?B?bGtzM09iYWxUSjJmc3Q3d1hWMklJNUF1YkNVVTRXeitYaGJCL3Y4RmZxVU8x?=
 =?utf-8?B?VWlZUUZ5Yi82Q29XcEVUOFpLYlhBMVREMVdwZDYrT0tTbFVNSCtaeXJpRnZP?=
 =?utf-8?B?TUk3UzZXbHVka0ZaZ3VUSVNzYXQ2djJkSVV3UUdyeFZPR3IzTVk4OWpQSDQ2?=
 =?utf-8?B?UDI4YVowbkN3PT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8281
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7c197e8f-d974-4c81-e6b4-08de01c10808
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|35042699022|82310400026|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2FkeHFscWFjclc3L0pFU2R1TmhXZDZMMjR0dTZSYm9jcU9lSys2VVNSbGRq?=
 =?utf-8?B?Z3BqNmprNWtuMVFkOUtUWGlIb0FuN1h5T2hzWVp6WSs4cUtwR3FabnoxdnhT?=
 =?utf-8?B?Tml6RDhSSXZtbXArUkhpTTc5cFRYaUh1N29ERE1aS1NsSkk3MHFGK0hEYTRj?=
 =?utf-8?B?a2ROYXZYRlZLYUo0SVM0dyttc3QyMFJpa1UyeUx3ZHZRYk02SjlhQmtVUEtE?=
 =?utf-8?B?SHZ1TW9Kd211MEFsS2FGS0UzdjFQRTI5SzJuQjRWaXN0YnVkWHZlRlkyZVRN?=
 =?utf-8?B?am5WV1FZajFqS1pIaTc1RlBxL3p6dEt2SWdXaVVneW12WUpkMXcvVzBJZE5T?=
 =?utf-8?B?QkhHVHB3RjA3ZkF0UnVibjJ5SUJ5MWxBSHpsanR4WFBpek5EOGNhKzhhbHJI?=
 =?utf-8?B?N2ZNZlhBYlp4SkFNSndXUzdLc3JldC9tT011M2lTTHh6N3JGeEtGc2cxSnV2?=
 =?utf-8?B?eVZRUHVYU2hIazl0NnJ1U1IwaE1iRUk3d0NERVBuNEphV1pRQkZ0cDVET2pR?=
 =?utf-8?B?T2ZEWUhQNDdNWlRjYUhNa3UyUk5Ea3N1Y2x6djNvN01YODBndVhScXExMUNB?=
 =?utf-8?B?d25FRVdTNWsyTUdVVkFYeHhpVzYza2E0WkVJb0VkUUxSNFl2dTRmNG9rc3lO?=
 =?utf-8?B?NFVqSElyb2dPTElESTJ3SCtuQTg4Vis3N0NSMTRvVlltRVAyLzdUdldLcXBn?=
 =?utf-8?B?ck1RM2JibzdsRlloZHFhc0VRWU5hTDI1eENYcTEyQ1AyQmdWQm9PODdjd2Fa?=
 =?utf-8?B?TExIY2NZNzh3YTZSOXZTbytaWEQxMmFlOVpZemI2WFZrTXJBdkxNUFFncDd4?=
 =?utf-8?B?TG9qM2Q1R1p1VGZWUThPdW4yZnNsN0JaNmpldS9RMUxLeW5Nd1dHaG1WMXVz?=
 =?utf-8?B?UGZ0REhJUXpJVExUT2RFa0M3STByWnRLTzc0TW42b01EVThQQitVOXowMThp?=
 =?utf-8?B?RXdvbDJtMi9ET2VJb3FRaG5sNHA3Z0RiSVNPS1o5R0NMbjZoeHRJVkZkWk9n?=
 =?utf-8?B?YVRxQmVZWXY0UXZNNzIyOE5CWGlzdDNuMENjVHkzUjU3V3dScXByaloybjE1?=
 =?utf-8?B?bm1KMGNTWHNMU3JsK3BVL0RtcUIvcWpoT3RVa0szWG5CU0ZORE5vVmhWS1FV?=
 =?utf-8?B?RHA0QXdzaGYyOGw3N3pEeElOTGI2eUQxQ0F1YXNHMVdheGJraHFZY21TRnFt?=
 =?utf-8?B?REk4SVFtdno4cngwVmo4V0x2YXZXclp4UXdCTWh2UFZwclUzSVplbHZGRHcx?=
 =?utf-8?B?NnRTYjI3aFphRW1VcHprTDZ5czBOOE5CbXRTcDQ5b1NmekpXT1JuVDVBMHZJ?=
 =?utf-8?B?RkpTZThLeElXeGRLeUZJQ2o4aG9RYmRQM3dTUzREenFHRG5rQWViaStBQ0hq?=
 =?utf-8?B?eVNFN3h6NTFSL3QyamxWcXNmWGFNa3FRR1h0czQ1aUJBS2tCejBjTzczWWJG?=
 =?utf-8?B?VXpqTnRqNC9VenpLRS91anc5ZTJGWm9vUEZMdXJKMTkrWkdCcEdRL2pzcjNM?=
 =?utf-8?B?SFlKQXAzOExuRkpsTGlVb0tWRUNlTW9tenU1aVNSOWZtY2pudFFKbFhoM24v?=
 =?utf-8?B?bmJsZmFkU21kRExCbk1zaWpSQmRVa1hVQkZuSExGSXhHdmpIc0VnK1VsaTEr?=
 =?utf-8?B?UU5yVk1XbVRjNW42elRNRnI0VjU2S1hpdVpnWFZsYVA5UDN5THR3WlFYK1Zv?=
 =?utf-8?B?eklFbzAveG1wb3BoZUxSaXhaNzg2OCt2UTZQdjQ4Z0d0NGwzclhjampodkE3?=
 =?utf-8?B?SW9qS0tZbmNUMnk4R0hhSXRkVTlZWis4NXNRWW83eFhOajRqY1RKTi8rTHA5?=
 =?utf-8?B?MWliMVhIUVZ6N3pLYlNZODZpQnZDMWE0KytYL2RKQWpOa0Z0MUEzWmRyRE11?=
 =?utf-8?B?REJRZFpWbW1ObUZyajFJOEVCTmxPY1dLSnh3SFJ0UTVOV0tuSXBXajEvdGRV?=
 =?utf-8?B?N0xNd203bXpuVHhDQnQ0anlJTjFnc21OQjNQbnlVZjVxb20xYy81QlhzU0VG?=
 =?utf-8?B?bVZkcTk0UXoxdEJTN1Y0TFVnaE1Sc1NVN3NoQWttQlBjdE1ZRjZWWHJSeE9X?=
 =?utf-8?B?Q1AyRWM1WFN3ZVAwbVFxeWFXUkJTS1FIaHppcVkrQkZsc1NRU1R5RjQ0Z2Nm?=
 =?utf-8?Q?Rktk=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(35042699022)(82310400026)(14060799003)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 14:36:14.6977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfdf287-c10f-4594-ec25-08de01c10a5d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR03MB10625
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

On 10/2/25 05:52, Heinrich Schuchardt wrote:
> On 10/2/25 11:39, Andrew Goodbody wrote:
>> After calling a function that can return an error, the test to detect
>> that error should use the return value not a different variable. Fix it.
>>
>> This issue was found by Smatch.
>>
> 
> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
> 
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   fs/semihostingfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>> --- a/fs/semihostingfs.c
>> +++ b/fs/semihostingfs.c
>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>       }
>>       if (!maxsize) {
>>           size = smh_flen(fd);
>> -        if (ret < 0) {
>> +        if (size < 0) {
> 
> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
> 
> SYS_FLEN (0x0C)
> 
> Returns the length of a specified file.
> On exit, R0 contains:
>     the current length of the file object, if the call is successful
>     -1 if an error occurs.
> 
> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
> 
> %s/if (size < 0)/if (size == -1L)/

This cannot occur because on a 32-bit system SYS_FLEN only returns
32-bits of information. The host must detect files that exceed 2 GiB in
size and return -1 (simulating EOVERFLOW).

--Sean
