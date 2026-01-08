Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95649D185FB
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA1383A26;
	Thu,  8 Jan 2026 14:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BUQUi9Jy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA8E84132; Thu,  8 Jan 2026 14:51:33 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azhn15012014.outbound.protection.outlook.com [52.102.136.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59503839A5
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMMlBfYg3nTDd9T9j2OvYm+EtvLbjbq4TxNcv5Ol6PAoQt23fFZDRgyzkF7ZcareHXaoix+Gqfm9l/898clIkZwqMnq0qwowo8CXHRNbxP+HUhkkCIlj1/iAAvK7IzhMKI3Wh7A1affe5xsA0DxGX5DZJuGnVCtoMJruKOOIyZkYg+Z2bbsxGLKR3AADe7XuE38J/eStN9xluKf1uhIv5wMSIlB60DMGe/47o0YQSCs6FUTmwkWPy1KZ2Zjv1HjlZhsFLatCMWj8UgUGdip1qY4SdEt49VdPEjFALeMBa8nHgHzbgwfoYQRCHxhyrMhRquccgl9qM46atGNt6FKrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/HZJ5GPmBWT0jUVXkda+VemP8cPQxtZmGXpEwrJZHs=;
 b=iyBJjaMGjS83JZkelE6okSk3Gqts5LT8+Sd1DW7vocTSDhATtKo/QpcOAjwTWWfVDwANYZe/He4TKRYerYZxVQWE6ja+LRgdWlc3H6/8d/aiZLMoL1py9Btlv/+bdSij1DgEUCAFXYT17DD+urBtJaoieyM8zq03xf1Y97XSHCyYDydE9n39n4T+4+I0IZP1Ve7a1294pP/HVrHJNwdrr61EB98RTn+A5iIzXaUP142j+wLlmLqTmXczuQ25WSzdn6bTPvLa6ldJLs9FJN6chezLRuQ6d8GjMr2pchvQLR/3dEkQ/H7IRx8e1QCNaoM+V1DPsPNCIzTAGsvH/HoQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/HZJ5GPmBWT0jUVXkda+VemP8cPQxtZmGXpEwrJZHs=;
 b=BUQUi9Jyi771hGy1yKMwUOaom1ZU9H/GMg2dnY77BZA98a4MAOourOuR0XXYijN6AxTwlHVcAAKVDjo+1mTfRhzAE8UxZClCs8er92/+t3CILlc3MHQ+Doci2SVpLiXbj1jBMPe9WuMLTn8FjCMAbmZmMAyZ7hmlp7sJGs3j3gY=
Received: from BL1PR13CA0409.namprd13.prod.outlook.com (2603:10b6:208:2c2::24)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:51:19 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::f9) by BL1PR13CA0409.outlook.office365.com
 (2603:10b6:208:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 13:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 13:51:16 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:51:12 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:51:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 8 Jan 2026 07:51:12 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 608DpAO82576875;
 Thu, 8 Jan 2026 07:51:11 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 8 Jan 2026 19:21:10 +0530
Message-ID: <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
CC: Adriano Cordova <adrianox@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <vigneshr@ti.com>, <b-padhi@ti.com>,
 <n-francis@ti.com>, <nm@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>,
 <i-sihag@ti.com>
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com>
In-Reply-To: <DFJ950O0QM0D.380U0N16ZO19E@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 304f5fad-b16e-4203-c6cd-08de4ebcfe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34070700014|34020700016|82310400026|1800799024|7416014|376014|7142099003|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0pCMno5TjhqWmZzcDZOejZSWGt5eFkwUmdvNlYzaG1seVIzdFl0QjFzTWFh?=
 =?utf-8?B?Rm80ZUEvK1lHeWlPSFZwK0ZUMkRsdGE4SFM4V09aK2xFZjFwaXVXV29vMUVJ?=
 =?utf-8?B?SlF1bU1JWXlsYi9pRUFsTjZnOFNnVE96Qk5hS2FhQmZiMTJ3cDB2WUI0dmJ0?=
 =?utf-8?B?SFRTQmpJcHA3Q2V4d0ExMEVZSHdlUzdrZ1NSNFhQaVlQZzhGaldzdDVQeVho?=
 =?utf-8?B?cXJibnRDWmFyc3Fub2M3cHhNaDFxWmFVeGtGQ3Q2c21MbnBsRFNxZUt5S05R?=
 =?utf-8?B?M1g3a0xKdWhaRE9rQStTbFNuTEc5aDRNam5ZRVFGNW5VQXJTeitwMmdORFVk?=
 =?utf-8?B?MnN1bjN3NU4rcWxxMVNZQmtGUmpaaXRWbzYzcG13M0ZwbjI5RGkwZkJ3aEI1?=
 =?utf-8?B?ZWFscU5KR2NJK1ZHdmRVcEp3WUJJdksxcGlTT29oaml6c0dhUllxcXAwL0sw?=
 =?utf-8?B?Sm40WW1LMFBJVjJxWXUreWl3NWJBYUp0WnUwY2lIajNVYUlzdUo0VG1kUDNh?=
 =?utf-8?B?SktDOTBibkQxZnNzeGU3eWZ4NGFYSWxyNGV6bkkwRmN3QjlENzFYNGlSY3pj?=
 =?utf-8?B?dGczMVZVdUNJTi9aYUdudksxU1JmdWt6aHhRRGZzUXV5MzA3b282ak9WZmRW?=
 =?utf-8?B?eWhIT0tMRjBhYVByQWRRdjR5MjRPb0tvVDg1bEFIZDhqUllYM3FkbWZHbXJ6?=
 =?utf-8?B?eWw2WTlnUC9BTnpOOG9JU2xyUmxQaHRhUHVKWW16OTc2YmMvOXVGaWZLU2li?=
 =?utf-8?B?Yy9QVG5nem1YNDBBT1pzNkVoR3k0YVoxbmwzLzZFMjlMNVlEVWw0SktXTFY2?=
 =?utf-8?B?aHN6YVFYWTBZK3lLei96K3RDTzVlenZLODk5TndDTUFWRUpJTHBRcnVNalQy?=
 =?utf-8?B?QmZVRzRmeHZ0aTJ0SGdOY1lRM0tyZGdkaTA5TnQxYTgrNjJnQ0M3Y2hlV2Zm?=
 =?utf-8?B?TVpsSDB2ZTJvRytibXBlaVVwSVZ4WjhYYlVpemIxMlpxOG9wQmtXUXFQUzVE?=
 =?utf-8?B?MUFtRUxrTnd6RmRocWZNUm9zbElORnp5aCtjcm5PNENGVHA1VUpjTVBWeUFY?=
 =?utf-8?B?U3F6Y3lVNjV3Wkw3R1QrK1VVRjQveERHNDJTc2ZYdlhGMGEwalhJc0s1bHF2?=
 =?utf-8?B?b1BHV2F6ZG44blQwbnc5bVowRG5COVkvcmxKWkMwS0V0c09tTkRaUTR2NEVn?=
 =?utf-8?B?YzNBV0hweGNKRXlKbmR5QWV0UkN5bEhyRjhHMnVaQ1pXTThnd3RsQVg1cDdm?=
 =?utf-8?B?eWk5TXhDcUgxNjZoOFlJcXdPMDByT0d6VklGSmJrVm1QWHVmUWEyNkRUKytv?=
 =?utf-8?B?OVRscThKNHlqS2RoSDZhRUFRc2NUNW8zZnVtZGlCNGNPRVJKZU5sc3lzaVNO?=
 =?utf-8?B?RVJGcjRLRlFyakpVZFpJVGdFNkNTdG1pdlF3dDNyZmlKamo2NDk1OVk2U0Q1?=
 =?utf-8?B?clNLbkJJUFdlditaRXRMclFxczAyNHh4RTNvZFEvc0M0QlJxU0ZmcTh2bWpm?=
 =?utf-8?B?ak5HaDRJRmxsYlVqQ1kzODZ2b25XajZkNkZWN0VObHVTdUw5TXBCZ2xTQnVS?=
 =?utf-8?B?bnUyTk5ReWVhSlVzYnJCckdZWHgyODJlQ2RoNzg2NW1Ec3NnQTdORGVVcnhr?=
 =?utf-8?B?KzUwOGlKQmZRWTV2SElQczlsVDZlYVNWamV6bndZT3g0K2Z0QWlrMXZiVjA3?=
 =?utf-8?B?OEpvVStvTG85ZVZyUi9uRno4UW1mdThlZ29OSFV2QjY0YXJsaEh3U0pjOFZ1?=
 =?utf-8?B?QTBnckJZcStBQkZ2K2Z2SmNFLzlzTTNkYWhRTXhILzVEdkJPbGlTakRteWlI?=
 =?utf-8?B?elcwNytwSHgyTHZJbkUreDRaSVN0R3ZtOGtEWUY3ZHkzWmZPSFpJUVdHbktV?=
 =?utf-8?B?NllGa3BXYnZBUWllTm9qTlhwVFFmcW5qT0xRam5FRkVZeEJKeTQyaWtWTjJh?=
 =?utf-8?B?UmxDZGN2TVY5TlhVbmRqbDAyTm50NlJ6QysrMys5QUFyTzQzaVJHNDJ1L3FT?=
 =?utf-8?B?cnNzdlFOd0dHVU1iWFdzYkVlMXNVdFJwYTNGczgxMjNqYzR6enMvN2g5NStX?=
 =?utf-8?B?Z2NNbXdadVRETTRCMm9aM1RqVWZ6S3RpVXQybXY0aWVOaWFGOHVYTk1NeGVw?=
 =?utf-8?Q?Bf8M=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(34070700014)(34020700016)(82310400026)(1800799024)(7416014)(376014)(7142099003)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:51:16.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f5fad-b16e-4203-c6cd-08de4ebcfe7d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
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

CC+: TI folks

On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
> Hi all,
>
> On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
>> Synchronize local copy of DTC with Linux 6.17 . This includes the
>> following picked and squashed commits from Linux kernel. The squash
>> was necessary, since the DTC here contains changes which were also
>> part of DTC in Linux alraedy, and the squash helped resolve those
>> without going back and forth with the changes.
>>
>> The following commits from Linux are picked:
>>
>> 8f324cd712df7 # scripts/dtc: consolidate include path options in Makefil=
e
>> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
>> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86da=
84d30e4
>> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf267e=
674d145
>> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g87963=
ee20693
>> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702c1=
b6c0e73
>> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
>> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40ae=
b60b47a
>> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent bracket=
ing of properties with phandles"
>> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
>> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a656=
ae5ff9
>> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non-s=
tandard path
>> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d788=
8cbf19c
>> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting consis=
tent
>> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead of =
overwriting
>> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbca9=
77ea121
>> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC proje=
ct
>> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183df=
9e9c2b9
>> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
>> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
>> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
>> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9=
d3449c8
>> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help t=
ext
>> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
>> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g55778=
a03df61
>> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabbd5=
23bae6e
>> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df7b=
047fe43
>> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd02=
b523429
>> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f07=
dcca47c
>>
>> This also includes forward port of U-Boot commit
>> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
>> to avoid binary size growth.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Adriano Cordova <adrianox@gmail.com>
>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Sam Edwards <cfsworks@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>
> We observed several boot failures on K3 platforms since the addition of
> this patch at the R5 SPL stage, the issue seems to be the newly added
> check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c:95
> but the binaries generated don't have 8-byte aligned FDTs.
>
> I have been able to reproduce the issue on AM62p EVM with a clean
> working directory (this is important since any minor change to the
> SPL binary size such as by the added "-dirty" tag could make the address
> aligned) and GCC 13.3[1].
>
> Are we ensuring the fdt present in the SPL binary is properly aligned?
>
> [1]: https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/=
13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
>
> Regards,
> Anshul
>
>> ---
>> V2: - Fix off-by-one in fdt_remove_unused_strings()
>>     - Restore e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfd=
t")
>> ---
>>  scripts/Makefile.lib                 |   4 +-
>>  scripts/dtc/.gitignore               |   1 +
>>  scripts/dtc/Makefile                 |  23 +-
>>  scripts/dtc/Makefile.dtc             |  18 -
>>  scripts/dtc/checks.c                 | 686 +++++++++++++++++++++------
>>  scripts/dtc/data.c                   |  74 ++-
>>  scripts/dtc/dtc-lexer.l              |  38 +-
>>  scripts/dtc/dtc-parser.y             | 109 +++--
>>  scripts/dtc/dtc.c                    |  58 ++-
>>  scripts/dtc/dtc.h                    | 137 ++++--
>>  scripts/dtc/fdtoverlay.c             | 214 +++++++++
>>  scripts/dtc/flattree.c               |  70 ++-
>>  scripts/dtc/fstree.c                 |  26 +-
>>  scripts/dtc/libfdt/fdt.c             |  84 ++--
>>  scripts/dtc/libfdt/fdt.h             |   4 +-
>>  scripts/dtc/libfdt/fdt_addresses.c   |   2 +-
>>  scripts/dtc/libfdt/fdt_overlay.c     | 386 +++++++++++----
>>  scripts/dtc/libfdt/fdt_ro.c          | 100 ++--
>>  scripts/dtc/libfdt/fdt_rw.c          | 101 ++--
>>  scripts/dtc/libfdt/fdt_strerror.c    |   1 +
>>  scripts/dtc/libfdt/fdt_sw.c          |  26 +-
>>  scripts/dtc/libfdt/libfdt.h          | 414 +++++++++++++---
>>  scripts/dtc/libfdt/libfdt_internal.h | 141 ++++--
>>  scripts/dtc/livetree.c               | 156 +++---
>>  scripts/dtc/srcpos.c                 | 190 ++++++--
>>  scripts/dtc/srcpos.h                 |  31 +-
>>  scripts/dtc/treesource.c             | 319 ++++++++-----
>>  scripts/dtc/update-dtc-source.sh     |   7 +-
>>  scripts/dtc/util.c                   | 122 ++---
>>  scripts/dtc/util.h                   |  61 +--
>>  scripts/dtc/version_gen.h            |   2 +-
>>  scripts/dtc/yamltree.c               | 235 +++++++++
>>  tools/libfdt/fdt_rw.c                |   2 +-
>>  33 files changed, 2830 insertions(+), 1012 deletions(-)
>>  delete mode 100644 scripts/dtc/Makefile.dtc
>>  create mode 100644 scripts/dtc/fdtoverlay.c
>>  create mode 100644 scripts/dtc/yamltree.c
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index 791eb1cb327..b062db7e87f 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -319,6 +319,7 @@ quiet_cmd_gzip =3D GZIP    $@
>>  # DTC
>>  # ---------------------------------------------------------------------=
------
>>  DTC ?=3D $(objtree)/scripts/dtc/dtc
>> +DTC_FLAGS +=3D -Wno-interrupt_provider
>> =20
>>  # Disable noisy checks by default
>>  ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
>> @@ -338,7 +339,8 @@ endif
>> =20
>>  ifneq ($(findstring 2,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
>>  DTC_FLAGS +=3D -Wnode_name_chars_strict \
>> -	-Wproperty_name_chars_strict
>> +	-Wproperty_name_chars_strict \
>> +	-Winterrupt_provider
>>  endif
>> =20
>>  DTC_FLAGS +=3D $(DTC_FLAGS_$(basetarget))
>> diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
>> index 689b9be0f93..60984f72e27 100644
>> --- a/scripts/dtc/.gitignore
>> +++ b/scripts/dtc/.gitignore
>> @@ -1 +1,2 @@
>>  /dtc
>> +/fdtoverlay
>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>> index faa72d95e28..73081b17d18 100644
>> --- a/scripts/dtc/Makefile
>> +++ b/scripts/dtc/Makefile
>> @@ -1,15 +1,32 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # scripts/dtc makefile
>> =20
>> -hostprogs-y	:=3D dtc
>> -always		:=3D $(hostprogs-y)
>> +# *** Also keep .gitignore in sync when changing ***
>> +hostprogs-y	+=3D dtc fdtoverlay
>> +always		+=3D dtc
>> =20
>>  dtc-objs	:=3D dtc.o flattree.o fstree.o data.o livetree.o treesource.o =
\
>>  		   srcpos.o checks.o util.o
>>  dtc-objs	+=3D dtc-lexer.lex.o dtc-parser.tab.o
>> =20
>> +# The upstream project builds libfdt as a separate library.  We are cho=
osing to
>> +# instead directly link the libfdt object files into fdtoverlay.
>> +libfdt-objs	:=3D fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerro=
r.o fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
>> +libfdt		=3D $(addprefix libfdt/,$(libfdt-objs))
>> +fdtoverlay-objs	:=3D $(libfdt) fdtoverlay.o util.o
>> +
>>  # Source files need to get at the userspace version of libfdt_env.h to =
compile
>> -HOST_EXTRACFLAGS :=3D -I$(src)/libfdt
>> +HOST_EXTRACFLAGS +=3D -I$(src)/libfdt
>> +
>> +ifeq ($(wildcard /usr/include/yaml.h),)
>> +HOST_EXTRACFLAGS +=3D -DNO_YAML
>> +else
>> +dtc-objs	+=3D yamltree.o
>> +# To include <yaml.h> installed in a non-default path
>> +HOSTCFLAGS_yamltree.o :=3D $(shell pkg-config --cflags yaml-0.1)
>> +# To link libyaml installed in a non-default path
>> +HOSTLDLIBS_dtc	:=3D $(shell pkg-config --libs yaml-0.1)
>> +endif
>> =20
>>  # Generated files need one more search path to include headers in sourc=
e tree
>>  HOSTCFLAGS_dtc-lexer.lex.o :=3D -I$(src)
>> diff --git a/scripts/dtc/Makefile.dtc b/scripts/dtc/Makefile.dtc
>> deleted file mode 100644
>> index bece49b3553..00000000000
>> --- a/scripts/dtc/Makefile.dtc
>> +++ /dev/null
>> @@ -1,18 +0,0 @@
>> -# Makefile.dtc
>> -#
>> -# This is not a complete Makefile of itself.  Instead, it is designed t=
o
>> -# be easily embeddable into other systems of Makefiles.
>> -#
>> -DTC_SRCS =3D \
>> -	checks.c \
>> -	data.c \
>> -	dtc.c \
>> -	flattree.c \
>> -	fstree.c \
>> -	livetree.c \
>> -	srcpos.c \
>> -	treesource.c \
>> -	util.c
>> -
>> -DTC_GEN_SRCS =3D dtc-lexer.lex.c dtc-parser.tab.c
>> -DTC_OBJS =3D $(DTC_SRCS:%.c=3D%.o) $(DTC_GEN_SRCS:%.c=3D%.o)
>> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
>> index 2feec44a0f7..d10c49eeb2a 100644
>> --- a/scripts/dtc/checks.c
>> +++ b/scripts/dtc/checks.c
>> @@ -1,24 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> +#include "srcpos.h"
>> =20
>>  #ifdef TRACE_CHECKS
>>  #define TRACE(c, ...) \
>> @@ -45,7 +31,7 @@ typedef void (*check_fn)(struct check *c, struct dt_in=
fo *dti, struct node *node
>>  struct check {
>>  	const char *name;
>>  	check_fn fn;
>> -	void *data;
>> +	const void *data;
>>  	bool warn, error;
>>  	enum checkstatus status;
>>  	bool inprogress;
>> @@ -78,23 +64,57 @@ static inline void  PRINTF(5, 6) check_msg(struct ch=
eck *c, struct dt_info *dti,
>>  					   const char *fmt, ...)
>>  {
>>  	va_list ap;
>> -	va_start(ap, fmt);
>> +	char *str =3D NULL;
>> +	struct srcpos *pos =3D NULL;
>> +	char *file_str;
>> +
>> +	if (!(c->warn && (quiet < 1)) && !(c->error && (quiet < 2)))
>> +		return;
>> =20
>> -	if ((c->warn && (quiet < 1))
>> -	    || (c->error && (quiet < 2))) {
>> -		fprintf(stderr, "%s: %s (%s): ",
>> -			strcmp(dti->outname, "-") ? dti->outname : "<stdout>",
>> +	if (prop && prop->srcpos)
>> +		pos =3D prop->srcpos;
>> +	else if (node && node->srcpos)
>> +		pos =3D node->srcpos;
>> +
>> +	if (pos) {
>> +		file_str =3D srcpos_string(pos);
>> +		xasprintf(&str, "%s", file_str);
>> +		free(file_str);
>> +	} else if (streq(dti->outname, "-")) {
>> +		xasprintf(&str, "<stdout>");
>> +	} else {
>> +		xasprintf(&str, "%s", dti->outname);
>> +	}
>> +
>> +	xasprintf_append(&str, ": %s (%s): ",
>>  			(c->error) ? "ERROR" : "Warning", c->name);
>> -		if (node) {
>> -			fprintf(stderr, "%s", node->fullpath);
>> -			if (prop)
>> -				fprintf(stderr, ":%s", prop->name);
>> -			fputs(": ", stderr);
>> -		}
>> -		vfprintf(stderr, fmt, ap);
>> -		fprintf(stderr, "\n");
>> +
>> +	if (node) {
>> +		if (prop)
>> +			xasprintf_append(&str, "%s:%s: ", node->fullpath, prop->name);
>> +		else
>> +			xasprintf_append(&str, "%s: ", node->fullpath);
>>  	}
>> +
>> +	va_start(ap, fmt);
>> +	xavsprintf_append(&str, fmt, ap);
>>  	va_end(ap);
>> +
>> +	xasprintf_append(&str, "\n");
>> +
>> +	if (!prop && pos) {
>> +		pos =3D node->srcpos;
>> +		while (pos->next) {
>> +			pos =3D pos->next;
>> +
>> +			file_str =3D srcpos_string(pos);
>> +			xasprintf_append(&str, "  also defined at %s\n", file_str);
>> +			free(file_str);
>> +		}
>> +	}
>> +
>> +	fputs(str, stderr);
>> +	free(str);
>>  }
>> =20
>>  #define FAIL(c, dti, node, ...)						\
>> @@ -123,6 +143,14 @@ static void check_nodes_props(struct check *c, stru=
ct dt_info *dti, struct node
>>  		check_nodes_props(c, dti, child);
>>  }
>> =20
>> +static bool is_multiple_of(int multiple, int divisor)
>> +{
>> +	if (divisor =3D=3D 0)
>> +		return multiple =3D=3D 0;
>> +	else
>> +		return (multiple % divisor) =3D=3D 0;
>> +}
>> +
>>  static bool run_check(struct check *c, struct dt_info *dti)
>>  {
>>  	struct node *dt =3D dti->dt;
>> @@ -179,7 +207,7 @@ static void check_is_string(struct check *c, struct =
dt_info *dti,
>>  			    struct node *node)
>>  {
>>  	struct property *prop;
>> -	char *propname =3D c->data;
>> +	const char *propname =3D c->data;
>> =20
>>  	prop =3D get_property(node, propname);
>>  	if (!prop)
>> @@ -198,7 +226,7 @@ static void check_is_string_list(struct check *c, st=
ruct dt_info *dti,
>>  {
>>  	int rem, l;
>>  	struct property *prop;
>> -	char *propname =3D c->data;
>> +	const char *propname =3D c->data;
>>  	char *str;
>> =20
>>  	prop =3D get_property(node, propname);
>> @@ -226,7 +254,7 @@ static void check_is_cell(struct check *c, struct dt=
_info *dti,
>>  			  struct node *node)
>>  {
>>  	struct property *prop;
>> -	char *propname =3D c->data;
>> +	const char *propname =3D c->data;
>> =20
>>  	prop =3D get_property(node, propname);
>>  	if (!prop)
>> @@ -277,19 +305,20 @@ ERROR(duplicate_property_names, check_duplicate_pr=
operty_names, NULL);
>>  #define LOWERCASE	"abcdefghijklmnopqrstuvwxyz"
>>  #define UPPERCASE	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>>  #define DIGITS		"0123456789"
>> -#define PROPNODECHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
>> +#define NODECHARS	LOWERCASE UPPERCASE DIGITS ",._+-@"
>> +#define PROPCHARS	LOWERCASE UPPERCASE DIGITS ",._+*#?-"
>>  #define PROPNODECHARSSTRICT	LOWERCASE UPPERCASE DIGITS ",-"
>> =20
>>  static void check_node_name_chars(struct check *c, struct dt_info *dti,
>>  				  struct node *node)
>>  {
>> -	int n =3D strspn(node->name, c->data);
>> +	size_t n =3D strspn(node->name, c->data);
>> =20
>>  	if (n < strlen(node->name))
>>  		FAIL(c, dti, node, "Bad character '%c' in node name",
>>  		     node->name[n]);
>>  }
>> -ERROR(node_name_chars, check_node_name_chars, PROPNODECHARS "@");
>> +ERROR(node_name_chars, check_node_name_chars, NODECHARS);
>> =20
>>  static void check_node_name_chars_strict(struct check *c, struct dt_inf=
o *dti,
>>  					 struct node *node)
>> @@ -310,6 +339,20 @@ static void check_node_name_format(struct check *c,=
 struct dt_info *dti,
>>  }
>>  ERROR(node_name_format, check_node_name_format, NULL, &node_name_chars)=
;
>> =20
>> +static void check_node_name_vs_property_name(struct check *c,
>> +					     struct dt_info *dti,
>> +					     struct node *node)
>> +{
>> +	if (!node->parent)
>> +		return;
>> +
>> +	if (get_property(node->parent, node->name)) {
>> +		FAIL(c, dti, node, "node name and property name conflict");
>> +	}
>> +}
>> +WARNING(node_name_vs_property_name, check_node_name_vs_property_name,
>> +	NULL, &node_name_chars);
>> +
>>  static void check_unit_address_vs_reg(struct check *c, struct dt_info *=
dti,
>>  				      struct node *node)
>>  {
>> @@ -332,7 +375,7 @@ static void check_unit_address_vs_reg(struct check *=
c, struct dt_info *dti,
>>  			FAIL(c, dti, node, "node has a reg or ranges property, but no unit n=
ame");
>>  	} else {
>>  		if (unitname[0])
>> -			FAIL(c, dti, node, "node has a unit name, but no reg property");
>> +			FAIL(c, dti, node, "node has a unit name, but no reg or ranges prope=
rty");
>>  	}
>>  }
>>  WARNING(unit_address_vs_reg, check_unit_address_vs_reg, NULL);
>> @@ -343,14 +386,14 @@ static void check_property_name_chars(struct check=
 *c, struct dt_info *dti,
>>  	struct property *prop;
>> =20
>>  	for_each_property(node, prop) {
>> -		int n =3D strspn(prop->name, c->data);
>> +		size_t n =3D strspn(prop->name, c->data);
>> =20
>>  		if (n < strlen(prop->name))
>>  			FAIL_PROP(c, dti, node, prop, "Bad character '%c' in property name",
>>  				  prop->name[n]);
>>  	}
>>  }
>> -ERROR(property_name_chars, check_property_name_chars, PROPNODECHARS);
>> +ERROR(property_name_chars, check_property_name_chars, PROPCHARS);
>> =20
>>  static void check_property_name_chars_strict(struct check *c,
>>  					     struct dt_info *dti,
>> @@ -360,7 +403,7 @@ static void check_property_name_chars_strict(struct =
check *c,
>> =20
>>  	for_each_property(node, prop) {
>>  		const char *name =3D prop->name;
>> -		int n =3D strspn(name, c->data);
>> +		size_t n =3D strspn(name, c->data);
>> =20
>>  		if (n =3D=3D strlen(prop->name))
>>  			continue;
>> @@ -477,7 +520,7 @@ static cell_t check_phandle_prop(struct check *c, st=
ruct dt_info *dti,
>> =20
>>  	phandle =3D propval_cell(prop);
>> =20
>> -	if ((phandle =3D=3D 0) || (phandle =3D=3D -1)) {
>> +	if (!phandle_is_valid(phandle)) {
>>  		FAIL_PROP(c, dti, node, prop, "bad value (0x%x) in %s property",
>>  		     phandle, prop->name);
>>  		return 0;
>> @@ -536,7 +579,7 @@ static void check_name_properties(struct check *c, s=
truct dt_info *dti,
>>  	if (!prop)
>>  		return; /* No name property, that's fine */
>> =20
>> -	if ((prop->val.len !=3D node->basenamelen+1)
>> +	if ((prop->val.len !=3D node->basenamelen + 1U)
>>  	    || (memcmp(prop->val.val, node->name, node->basenamelen) !=3D 0)) =
{
>>  		FAIL(c, dti, node, "\"name\" property is incorrect (\"%s\" instead"
>>  		     " of base node name)", prop->val.val);
>> @@ -625,6 +668,8 @@ ERROR(path_references, fixup_path_references, NULL, =
&duplicate_node_names);
>>  static void fixup_omit_unused_nodes(struct check *c, struct dt_info *dt=
i,
>>  				    struct node *node)
>>  {
>> +	if (generate_symbols && node->labels)
>> +		return;
>>  	if (node->omit_if_unused && !node->is_referenced)
>>  		delete_node(node);
>>  }
>> @@ -635,7 +680,6 @@ ERROR(omit_unused_nodes, fixup_omit_unused_nodes, NU=
LL, &phandle_references, &pa
>>   */
>>  WARNING_IF_NOT_CELL(address_cells_is_cell, "#address-cells");
>>  WARNING_IF_NOT_CELL(size_cells_is_cell, "#size-cells");
>> -WARNING_IF_NOT_CELL(interrupt_cells_is_cell, "#interrupt-cells");
>> =20
>>  WARNING_IF_NOT_STRING(device_type_is_string, "device_type");
>>  WARNING_IF_NOT_STRING(model_is_string, "model");
>> @@ -650,8 +694,7 @@ static void check_names_is_string_list(struct check =
*c, struct dt_info *dti,
>>  	struct property *prop;
>> =20
>>  	for_each_property(node, prop) {
>> -		const char *s =3D strrchr(prop->name, '-');
>> -		if (!s || !streq(s, "-names"))
>> +		if (!strends(prop->name, "-names"))
>>  			continue;
>> =20
>>  		c->data =3D prop->name;
>> @@ -669,6 +712,11 @@ static void check_alias_paths(struct check *c, stru=
ct dt_info *dti,
>>  		return;
>> =20
>>  	for_each_property(node, prop) {
>> +		if (streq(prop->name, "phandle")
>> +		    || streq(prop->name, "linux,phandle")) {
>> +			continue;
>> +		}
>> +
>>  		if (!prop->val.val || !get_node_by_path(dti->dt, prop->val.val)) {
>>  			FAIL_PROP(c, dti, node, prop, "aliases property is not a valid node =
(%s)",
>>  				  prop->val.val);
>> @@ -726,7 +774,7 @@ static void check_reg_format(struct check *c, struct=
 dt_info *dti,
>>  	size_cells =3D node_size_cells(node->parent);
>>  	entrylen =3D (addr_cells + size_cells) * sizeof(cell_t);
>> =20
>> -	if (!entrylen || (prop->val.len % entrylen) !=3D 0)
>> +	if (!is_multiple_of(prop->val.len, entrylen))
>>  		FAIL_PROP(c, dti, node, prop, "property has invalid length (%d bytes)=
 "
>>  			  "(#address-cells =3D=3D %d, #size-cells =3D=3D %d)",
>>  			  prop->val.len, addr_cells, size_cells);
>> @@ -738,13 +786,15 @@ static void check_ranges_format(struct check *c, s=
truct dt_info *dti,
>>  {
>>  	struct property *prop;
>>  	int c_addr_cells, p_addr_cells, c_size_cells, p_size_cells, entrylen;
>> +	const char *ranges =3D c->data;
>> =20
>> -	prop =3D get_property(node, "ranges");
>> +	prop =3D get_property(node, ranges);
>>  	if (!prop)
>>  		return;
>> =20
>>  	if (!node->parent) {
>> -		FAIL_PROP(c, dti, node, prop, "Root node has a \"ranges\" property");
>> +		FAIL_PROP(c, dti, node, prop, "Root node has a \"%s\" property",
>> +			  ranges);
>>  		return;
>>  	}
>> =20
>> @@ -756,23 +806,24 @@ static void check_ranges_format(struct check *c, s=
truct dt_info *dti,
>> =20
>>  	if (prop->val.len =3D=3D 0) {
>>  		if (p_addr_cells !=3D c_addr_cells)
>> -			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
>> +			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
>>  				  "#address-cells (%d) differs from %s (%d)",
>> -				  c_addr_cells, node->parent->fullpath,
>> +				  ranges, c_addr_cells, node->parent->fullpath,
>>  				  p_addr_cells);
>>  		if (p_size_cells !=3D c_size_cells)
>> -			FAIL_PROP(c, dti, node, prop, "empty \"ranges\" property but its "
>> +			FAIL_PROP(c, dti, node, prop, "empty \"%s\" property but its "
>>  				  "#size-cells (%d) differs from %s (%d)",
>> -				  c_size_cells, node->parent->fullpath,
>> +				  ranges, c_size_cells, node->parent->fullpath,
>>  				  p_size_cells);
>> -	} else if ((prop->val.len % entrylen) !=3D 0) {
>> -		FAIL_PROP(c, dti, node, prop, "\"ranges\" property has invalid length=
 (%d bytes) "
>> +	} else if (!is_multiple_of(prop->val.len, entrylen)) {
>> +		FAIL_PROP(c, dti, node, prop, "\"%s\" property has invalid length (%d=
 bytes) "
>>  			  "(parent #address-cells =3D=3D %d, child #address-cells =3D=3D %d,=
 "
>> -			  "#size-cells =3D=3D %d)", prop->val.len,
>> +			  "#size-cells =3D=3D %d)", ranges, prop->val.len,
>>  			  p_addr_cells, c_addr_cells, c_size_cells);
>>  	}
>>  }
>> -WARNING(ranges_format, check_ranges_format, NULL, &addr_size_cells);
>> +WARNING(ranges_format, check_ranges_format, "ranges", &addr_size_cells)=
;
>> +WARNING(dma_ranges_format, check_ranges_format, "dma-ranges", &addr_siz=
e_cells);
>> =20
>>  static const struct bus_type pci_bus =3D {
>>  	.name =3D "PCI",
>> @@ -842,7 +893,7 @@ static void check_pci_device_bus_num(struct check *c=
, struct dt_info *dti, struc
>>  	} else {
>>  		cells =3D (cell_t *)prop->val.val;
>>  		min_bus =3D fdt32_to_cpu(cells[0]);
>> -		max_bus =3D fdt32_to_cpu(cells[0]);
>> +		max_bus =3D fdt32_to_cpu(cells[1]);
>>  	}
>>  	if ((bus_num < min_bus) || (bus_num > max_bus))
>>  		FAIL_PROP(c, dti, node, prop, "PCI bus number %d out of range, expect=
ed (%d - %d)",
>> @@ -862,10 +913,8 @@ static void check_pci_device_reg(struct check *c, s=
truct dt_info *dti, struct no
>>  		return;
>> =20
>>  	prop =3D get_property(node, "reg");
>> -	if (!prop) {
>> -		FAIL(c, dti, node, "missing PCI reg property");
>> +	if (!prop)
>>  		return;
>> -	}
>> =20
>>  	cells =3D (cell_t *)prop->val.val;
>>  	if (cells[1] || cells[2])
>> @@ -910,7 +959,7 @@ static bool node_is_compatible(struct node *node, co=
nst char *compat)
>> =20
>>  	for (str =3D prop->val.val, end =3D str + prop->val.len; str < end;
>>  	     str +=3D strnlen(str, end - str) + 1) {
>> -		if (strprefixeq(str, end - str, compat))
>> +		if (streq(str, compat))
>>  			return true;
>>  	}
>>  	return false;
>> @@ -921,7 +970,8 @@ static void check_simple_bus_bridge(struct check *c,=
 struct dt_info *dti, struct
>>  	if (node_is_compatible(node, "simple-bus"))
>>  		node->bus =3D &simple_bus;
>>  }
>> -WARNING(simple_bus_bridge, check_simple_bus_bridge, NULL, &addr_size_ce=
lls);
>> +WARNING(simple_bus_bridge, check_simple_bus_bridge, NULL,
>> +	&addr_size_cells, &compatible_is_string_list);
>> =20
>>  static void check_simple_bus_reg(struct check *c, struct dt_info *dti, =
struct node *node)
>>  {
>> @@ -962,6 +1012,160 @@ static void check_simple_bus_reg(struct check *c,=
 struct dt_info *dti, struct no
>>  }
>>  WARNING(simple_bus_reg, check_simple_bus_reg, NULL, &reg_format, &simpl=
e_bus_bridge);
>> =20
>> +static const struct bus_type i2c_bus =3D {
>> +	.name =3D "i2c-bus",
>> +};
>> +
>> +static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, =
struct node *node)
>> +{
>> +	if (strprefixeq(node->name, node->basenamelen, "i2c-bus") ||
>> +	    strprefixeq(node->name, node->basenamelen, "i2c-arb")) {
>> +		node->bus =3D &i2c_bus;
>> +	} else if (strprefixeq(node->name, node->basenamelen, "i2c")) {
>> +		struct node *child;
>> +		for_each_child(node, child) {
>> +			if (strprefixeq(child->name, child->basenamelen, "i2c-bus"))
>> +				return;
>> +		}
>> +		node->bus =3D &i2c_bus;
>> +	} else
>> +		return;
>> +
>> +	if (!node->children)
>> +		return;
>> +
>> +	if (node_addr_cells(node) !=3D 1)
>> +		FAIL(c, dti, node, "incorrect #address-cells for I2C bus");
>> +	if (node_size_cells(node) !=3D 0)
>> +		FAIL(c, dti, node, "incorrect #size-cells for I2C bus");
>> +
>> +}
>> +WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
>> +
>> +#define I2C_OWN_SLAVE_ADDRESS	(1U << 30)
>> +#define I2C_TEN_BIT_ADDRESS	(1U << 31)
>> +
>> +static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, str=
uct node *node)
>> +{
>> +	struct property *prop;
>> +	const char *unitname =3D get_unitname(node);
>> +	char unit_addr[17];
>> +	uint32_t reg =3D 0;
>> +	int len;
>> +	cell_t *cells =3D NULL;
>> +
>> +	if (!node->parent || (node->parent->bus !=3D &i2c_bus))
>> +		return;
>> +
>> +	prop =3D get_property(node, "reg");
>> +	if (prop)
>> +		cells =3D (cell_t *)prop->val.val;
>> +
>> +	if (!cells) {
>> +		FAIL(c, dti, node, "missing or empty reg property");
>> +		return;
>> +	}
>> +
>> +	reg =3D fdt32_to_cpu(*cells);
>> +	/* Ignore I2C_OWN_SLAVE_ADDRESS */
>> +	reg &=3D ~I2C_OWN_SLAVE_ADDRESS;
>> +	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
>> +	if (!streq(unitname, unit_addr))
>> +		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\=
"",
>> +		     unit_addr);
>> +
>> +	for (len =3D prop->val.len; len > 0; len -=3D 4) {
>> +		reg =3D fdt32_to_cpu(*(cells++));
>> +		/* Ignore I2C_OWN_SLAVE_ADDRESS */
>> +		reg &=3D ~I2C_OWN_SLAVE_ADDRESS;
>> +
>> +		if (reg & I2C_TEN_BIT_ADDRESS) {
>> +			if ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff)
>> +				FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bit=
s, got \"0x%x\"",
>> +				  reg);
>> +		} else if (reg > 0x7f)
>> +			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits,=
 got \"0x%x\". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the prop=
erty",
>> +				  reg);
>> +	}
>> +}
>> +WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bri=
dge);
>> +
>> +static const struct bus_type spi_bus =3D {
>> +	.name =3D "spi-bus",
>> +};
>> +
>> +static void check_spi_bus_bridge(struct check *c, struct dt_info *dti, =
struct node *node)
>> +{
>> +	int spi_addr_cells =3D 1;
>> +
>> +	if (strprefixeq(node->name, node->basenamelen, "spi")) {
>> +		node->bus =3D &spi_bus;
>> +	} else {
>> +		/* Try to detect SPI buses which don't have proper node name */
>> +		struct node *child;
>> +
>> +		if (node_addr_cells(node) !=3D 1 || node_size_cells(node) !=3D 0)
>> +			return;
>> +
>> +		for_each_child(node, child) {
>> +			struct property *prop;
>> +			for_each_property(child, prop) {
>> +				if (strstarts(prop->name, "spi-")) {
>> +					node->bus =3D &spi_bus;
>> +					break;
>> +				}
>> +			}
>> +			if (node->bus =3D=3D &spi_bus)
>> +				break;
>> +		}
>> +
>> +		if (node->bus =3D=3D &spi_bus && get_property(node, "reg"))
>> +			FAIL(c, dti, node, "node name for SPI buses should be 'spi'");
>> +	}
>> +	if (node->bus !=3D &spi_bus || !node->children)
>> +		return;
>> +
>> +	if (get_property(node, "spi-slave"))
>> +		spi_addr_cells =3D 0;
>> +	if (node_addr_cells(node) !=3D spi_addr_cells)
>> +		FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
>> +	if (node_size_cells(node) !=3D 0)
>> +		FAIL(c, dti, node, "incorrect #size-cells for SPI bus");
>> +
>> +}
>> +WARNING(spi_bus_bridge, check_spi_bus_bridge, NULL, &addr_size_cells);
>> +
>> +static void check_spi_bus_reg(struct check *c, struct dt_info *dti, str=
uct node *node)
>> +{
>> +	struct property *prop;
>> +	const char *unitname =3D get_unitname(node);
>> +	char unit_addr[9];
>> +	uint32_t reg =3D 0;
>> +	cell_t *cells =3D NULL;
>> +
>> +	if (!node->parent || (node->parent->bus !=3D &spi_bus))
>> +		return;
>> +
>> +	if (get_property(node->parent, "spi-slave"))
>> +		return;
>> +
>> +	prop =3D get_property(node, "reg");
>> +	if (prop)
>> +		cells =3D (cell_t *)prop->val.val;
>> +
>> +	if (!cells) {
>> +		FAIL(c, dti, node, "missing or empty reg property");
>> +		return;
>> +	}
>> +
>> +	reg =3D fdt32_to_cpu(*cells);
>> +	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
>> +	if (!streq(unitname, unit_addr))
>> +		FAIL(c, dti, node, "SPI bus unit address format error, expected \"%s\=
"",
>> +		     unit_addr);
>> +}
>> +WARNING(spi_bus_reg, check_spi_bus_reg, NULL, &reg_format, &spi_bus_bri=
dge);
>> +
>>  static void check_unit_address_format(struct check *c, struct dt_info *=
dti,
>>  				      struct node *node)
>>  {
>> @@ -978,7 +1182,7 @@ static void check_unit_address_format(struct check =
*c, struct dt_info *dti,
>>  		/* skip over 0x for next test */
>>  		unitname +=3D 2;
>>  	}
>> -	if (unitname[0] =3D=3D '0' && isxdigit(unitname[1]))
>> +	if (unitname[0] =3D=3D '0' && isxdigit((unsigned char)unitname[1]))
>>  		FAIL(c, dti, node, "unit name should not have leading 0s");
>>  }
>>  WARNING(unit_address_format, check_unit_address_format, NULL,
>> @@ -1013,29 +1217,48 @@ WARNING(avoid_default_addr_size, check_avoid_def=
ault_addr_size, NULL,
>>  static void check_avoid_unnecessary_addr_size(struct check *c, struct d=
t_info *dti,
>>  					      struct node *node)
>>  {
>> -	struct property *prop;
>>  	struct node *child;
>> -	bool has_reg =3D false;
>> =20
>>  	if (!node->parent || node->addr_cells < 0 || node->size_cells < 0)
>>  		return;
>> =20
>> -	if (get_property(node, "ranges") || !node->children)
>> +	if (get_property(node, "ranges") || get_property(node, "dma-ranges") |=
| !node->children)
>>  		return;
>> =20
>>  	for_each_child(node, child) {
>> -		prop =3D get_property(child, "reg");
>> -		if (prop)
>> -			has_reg =3D true;
>> +		/*
>> +		 * Even if the child devices' address space is not mapped into
>> +		 * the parent bus (no 'ranges' property on node), children can
>> +		 * still have registers on a local bus, or map local addresses
>> +		 * to another subordinate address space. The properties on the
>> +		 * child nodes then make #address-cells/#size-cells necessary:
>> +		 */
>> +		if (get_property(child, "reg") || get_property(child, "ranges"))
>> +			return;
>>  	}
>> =20
>> -	if (!has_reg)
>> -		FAIL(c, dti, node, "unnecessary #address-cells/#size-cells without \"=
ranges\" or child \"reg\" property");
>> +	FAIL(c, dti, node, "unnecessary #address-cells/#size-cells without \"r=
anges\", \"dma-ranges\" or child \"reg\" or \"ranges\" property");
>>  }
>>  WARNING(avoid_unnecessary_addr_size, check_avoid_unnecessary_addr_size,=
 NULL, &avoid_default_addr_size);
>> =20
>> -static void check_unique_unit_address(struct check *c, struct dt_info *=
dti,
>> -					      struct node *node)
>> +static bool node_is_disabled(struct node *node)
>> +{
>> +	struct property *prop;
>> +
>> +	prop =3D get_property(node, "status");
>> +	if (prop) {
>> +		char *str =3D prop->val.val;
>> +		if (streq("disabled", str))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static void check_unique_unit_address_common(struct check *c,
>> +						struct dt_info *dti,
>> +						struct node *node,
>> +						bool disable_check)
>>  {
>>  	struct node *childa;
>> =20
>> @@ -1052,18 +1275,38 @@ static void check_unique_unit_address(struct che=
ck *c, struct dt_info *dti,
>>  		if (!strlen(addr_a))
>>  			continue;
>> =20
>> +		if (disable_check && node_is_disabled(childa))
>> +			continue;
>> +
>>  		for_each_child(node, childb) {
>>  			const char *addr_b =3D get_unitname(childb);
>>  			if (childa =3D=3D childb)
>>  				break;
>> =20
>> +			if (disable_check && node_is_disabled(childb))
>> +				continue;
>> +
>>  			if (streq(addr_a, addr_b))
>>  				FAIL(c, dti, childb, "duplicate unit-address (also used in node %s)=
", childa->fullpath);
>>  		}
>>  	}
>>  }
>> +
>> +static void check_unique_unit_address(struct check *c, struct dt_info *=
dti,
>> +					      struct node *node)
>> +{
>> +	check_unique_unit_address_common(c, dti, node, false);
>> +}
>>  WARNING(unique_unit_address, check_unique_unit_address, NULL, &avoid_de=
fault_addr_size);
>> =20
>> +static void check_unique_unit_address_if_enabled(struct check *c, struc=
t dt_info *dti,
>> +					      struct node *node)
>> +{
>> +	check_unique_unit_address_common(c, dti, node, true);
>> +}
>> +CHECK_ENTRY(unique_unit_address_if_enabled, check_unique_unit_address_i=
f_enabled,
>> +	    NULL, false, false, &avoid_default_addr_size);
>> +
>>  static void check_obsolete_chosen_interrupt_controller(struct check *c,
>>  						       struct dt_info *dti,
>>  						       struct node *node)
>> @@ -1143,15 +1386,15 @@ struct provider {
>>  };
>> =20
>>  static void check_property_phandle_args(struct check *c,
>> -					  struct dt_info *dti,
>> -				          struct node *node,
>> -				          struct property *prop,
>> -				          const struct provider *provider)
>> +					struct dt_info *dti,
>> +					struct node *node,
>> +					struct property *prop,
>> +					const struct provider *provider)
>>  {
>>  	struct node *root =3D dti->dt;
>> -	int cell, cellsize =3D 0;
>> +	unsigned int cell, cellsize =3D 0;
>> =20
>> -	if (prop->val.len % sizeof(cell_t)) {
>> +	if (!is_multiple_of(prop->val.len, sizeof(cell_t))) {
>>  		FAIL_PROP(c, dti, node, prop,
>>  			  "property size (%d) is invalid, expected multiple of %zu",
>>  			  prop->val.len, sizeof(cell_t));
>> @@ -1161,14 +1404,15 @@ static void check_property_phandle_args(struct c=
heck *c,
>>  	for (cell =3D 0; cell < prop->val.len / sizeof(cell_t); cell +=3D cell=
size + 1) {
>>  		struct node *provider_node;
>>  		struct property *cellprop;
>> -		int phandle;
>> +		cell_t phandle;
>> +		unsigned int expected;
>> =20
>>  		phandle =3D propval_cell_n(prop, cell);
>>  		/*
>>  		 * Some bindings use a cell value 0 or -1 to skip over optional
>>  		 * entries when each index position has a specific definition.
>>  		 */
>> -		if (phandle =3D=3D 0 || phandle =3D=3D -1) {
>> +		if (!phandle_is_valid(phandle)) {
>>  			/* Give up if this is an overlay with external references */
>>  			if (dti->dtsflags & DTSF_PLUGIN)
>>  				break;
>> @@ -1211,10 +1455,12 @@ static void check_property_phandle_args(struct c=
heck *c,
>>  			break;
>>  		}
>> =20
>> -		if (prop->val.len < ((cell + cellsize + 1) * sizeof(cell_t))) {
>> +		expected =3D (cell + cellsize + 1) * sizeof(cell_t);
>> +		if ((expected <=3D cell) || prop->val.len < expected) {
>>  			FAIL_PROP(c, dti, node, prop,
>> -				  "property size (%d) too small for cell size %d",
>> +				  "property size (%d) too small for cell size %u",
>>  				  prop->val.len, cellsize);
>> +			break;
>>  		}
>>  	}
>>  }
>> @@ -1223,7 +1469,7 @@ static void check_provider_cells_property(struct c=
heck *c,
>>  					  struct dt_info *dti,
>>  				          struct node *node)
>>  {
>> -	struct provider *provider =3D c->data;
>> +	const struct provider *provider =3D c->data;
>>  	struct property *prop;
>> =20
>>  	prop =3D get_property(node, provider->prop_name);
>> @@ -1234,7 +1480,8 @@ static void check_provider_cells_property(struct c=
heck *c,
>>  }
>>  #define WARNING_PROPERTY_PHANDLE_CELLS(nm, propname, cells_name, ...) \
>>  	static struct provider nm##_provider =3D { (propname), (cells_name), _=
_VA_ARGS__ }; \
>> -	WARNING(nm##_property, check_provider_cells_property, &nm##_provider, =
&phandle_references);
>> +	WARNING_IF_NOT_CELL(nm##_is_cell, cells_name); \
>> +	WARNING(nm##_property, check_provider_cells_property, &nm##_provider, =
&nm##_is_cell, &phandle_references);
>> =20
>>  WARNING_PROPERTY_PHANDLE_CELLS(clocks, "clocks", "#clock-cells");
>>  WARNING_PROPERTY_PHANDLE_CELLS(cooling_device, "cooling-device", "#cool=
ing-cells");
>> @@ -1255,24 +1502,17 @@ WARNING_PROPERTY_PHANDLE_CELLS(thermal_sensors, =
"thermal-sensors", "#thermal-sen
>> =20
>>  static bool prop_is_gpio(struct property *prop)
>>  {
>> -	char *str;
>> -
>>  	/*
>>  	 * *-gpios and *-gpio can appear in property names,
>>  	 * so skip over any false matches (only one known ATM)
>>  	 */
>> -	if (strstr(prop->name, "nr-gpio"))
>> +	if (strends(prop->name, ",nr-gpios"))
>>  		return false;
>> =20
>> -	str =3D strrchr(prop->name, '-');
>> -	if (str)
>> -		str++;
>> -	else
>> -		str =3D prop->name;
>> -	if (!(streq(str, "gpios") || streq(str, "gpio")))
>> -		return false;
>> -
>> -	return true;
>> +	return strends(prop->name, "-gpios") ||
>> +		streq(prop->name, "gpios") ||
>> +		strends(prop->name, "-gpio") ||
>> +		streq(prop->name, "gpio");
>>  }
>> =20
>>  static void check_gpios_property(struct check *c,
>> @@ -1307,13 +1547,10 @@ static void check_deprecated_gpio_property(struc=
t check *c,
>>  	struct property *prop;
>> =20
>>  	for_each_property(node, prop) {
>> -		char *str;
>> -
>>  		if (!prop_is_gpio(prop))
>>  			continue;
>> =20
>> -		str =3D strstr(prop->name, "gpio");
>> -		if (!streq(str, "gpio"))
>> +		if (!strends(prop->name, "gpio"))
>>  			continue;
>> =20
>>  		FAIL_PROP(c, dti, node, prop,
>> @@ -1337,6 +1574,121 @@ static bool node_is_interrupt_provider(struct no=
de *node)
>> =20
>>  	return false;
>>  }
>> +
>> +static void check_interrupt_provider(struct check *c,
>> +				     struct dt_info *dti,
>> +				     struct node *node)
>> +{
>> +	struct property *prop;
>> +	bool irq_provider =3D node_is_interrupt_provider(node);
>> +
>> +	prop =3D get_property(node, "#interrupt-cells");
>> +	if (irq_provider && !prop) {
>> +		FAIL(c, dti, node,
>> +		     "Missing '#interrupt-cells' in interrupt provider");
>> +		return;
>> +	}
>> +
>> +	if (!irq_provider && prop) {
>> +		FAIL(c, dti, node,
>> +		     "'#interrupt-cells' found, but node is not an interrupt provider=
");
>> +		return;
>> +	}
>> +}
>> +WARNING(interrupt_provider, check_interrupt_provider, NULL, &interrupts=
_extended_is_cell);
>> +
>> +static void check_interrupt_map(struct check *c,
>> +				struct dt_info *dti,
>> +				struct node *node)
>> +{
>> +	struct node *root =3D dti->dt;
>> +	struct property *prop, *irq_map_prop;
>> +	size_t cellsize, cell, map_cells;
>> +
>> +	irq_map_prop =3D get_property(node, "interrupt-map");
>> +	if (!irq_map_prop)
>> +		return;
>> +
>> +	if (node->addr_cells < 0) {
>> +		FAIL(c, dti, node,
>> +		     "Missing '#address-cells' in interrupt-map provider");
>> +		return;
>> +	}
>> +	cellsize =3D node_addr_cells(node);
>> +	cellsize +=3D propval_cell(get_property(node, "#interrupt-cells"));
>> +
>> +	prop =3D get_property(node, "interrupt-map-mask");
>> +	if (prop && (prop->val.len !=3D (cellsize * sizeof(cell_t))))
>> +		FAIL_PROP(c, dti, node, prop,
>> +			  "property size (%d) is invalid, expected %zu",
>> +			  prop->val.len, cellsize * sizeof(cell_t));
>> +
>> +	if (!is_multiple_of(irq_map_prop->val.len, sizeof(cell_t))) {
>> +		FAIL_PROP(c, dti, node, irq_map_prop,
>> +			  "property size (%d) is invalid, expected multiple of %zu",
>> +			  irq_map_prop->val.len, sizeof(cell_t));
>> +		return;
>> +	}
>> +
>> +	map_cells =3D irq_map_prop->val.len / sizeof(cell_t);
>> +	for (cell =3D 0; cell < map_cells; ) {
>> +		struct node *provider_node;
>> +		struct property *cellprop;
>> +		int phandle;
>> +		size_t parent_cellsize;
>> +
>> +		if ((cell + cellsize) >=3D map_cells) {
>> +			FAIL_PROP(c, dti, node, irq_map_prop,
>> +				  "property size (%d) too small, expected > %zu",
>> +				  irq_map_prop->val.len, (cell + cellsize) * sizeof(cell_t));
>> +			break;
>> +		}
>> +		cell +=3D cellsize;
>> +
>> +		phandle =3D propval_cell_n(irq_map_prop, cell);
>> +		if (!phandle_is_valid(phandle)) {
>> +			/* Give up if this is an overlay with external references */
>> +			if (!(dti->dtsflags & DTSF_PLUGIN))
>> +				FAIL_PROP(c, dti, node, irq_map_prop,
>> +					  "Cell %zu is not a phandle(%d)",
>> +					  cell, phandle);
>> +			break;
>> +		}
>> +
>> +		provider_node =3D get_node_by_phandle(root, phandle);
>> +		if (!provider_node) {
>> +			FAIL_PROP(c, dti, node, irq_map_prop,
>> +				  "Could not get phandle(%d) node for (cell %zu)",
>> +				  phandle, cell);
>> +			break;
>> +		}
>> +
>> +		cellprop =3D get_property(provider_node, "#interrupt-cells");
>> +		if (cellprop) {
>> +			parent_cellsize =3D propval_cell(cellprop);
>> +		} else {
>> +			FAIL(c, dti, node, "Missing property '#interrupt-cells' in node %s o=
r bad phandle (referred from interrupt-map[%zu])",
>> +			     provider_node->fullpath, cell);
>> +			break;
>> +		}
>> +
>> +		cellprop =3D get_property(provider_node, "#address-cells");
>> +		if (cellprop)
>> +			parent_cellsize +=3D propval_cell(cellprop);
>> +		else
>> +			FAIL_PROP(c, dti, node, irq_map_prop,
>> +				"Missing property '#address-cells' in node %s, using 0 as fallback"=
,
>> +				provider_node->fullpath);
>> +
>> +		cell +=3D 1 + parent_cellsize;
>> +		if (cell > map_cells)
>> +			FAIL_PROP(c, dti, node, irq_map_prop,
>> +				"property size (%d) mismatch, expected %zu",
>> +				irq_map_prop->val.len, cell * sizeof(cell_t));
>> +	}
>> +}
>> +WARNING(interrupt_map, check_interrupt_map, NULL, &phandle_references, =
&addr_size_cells, &interrupt_provider);
>> +
>>  static void check_interrupts_property(struct check *c,
>>  				      struct dt_info *dti,
>>  				      struct node *node)
>> @@ -1344,13 +1696,13 @@ static void check_interrupts_property(struct che=
ck *c,
>>  	struct node *root =3D dti->dt;
>>  	struct node *irq_node =3D NULL, *parent =3D node;
>>  	struct property *irq_prop, *prop =3D NULL;
>> -	int irq_cells, phandle;
>> +	cell_t irq_cells, phandle;
>> =20
>>  	irq_prop =3D get_property(node, "interrupts");
>>  	if (!irq_prop)
>>  		return;
>> =20
>> -	if (irq_prop->val.len % sizeof(cell_t))
>> +	if (!is_multiple_of(irq_prop->val.len, sizeof(cell_t)))
>>  		FAIL_PROP(c, dti, node, irq_prop, "size (%d) is invalid, expected mul=
tiple of %zu",
>>  		     irq_prop->val.len, sizeof(cell_t));
>> =20
>> @@ -1363,10 +1715,14 @@ static void check_interrupts_property(struct che=
ck *c,
>>  		prop =3D get_property(parent, "interrupt-parent");
>>  		if (prop) {
>>  			phandle =3D propval_cell(prop);
>> -			/* Give up if this is an overlay with external references */
>> -			if ((phandle =3D=3D 0 || phandle =3D=3D -1) &&
>> -			    (dti->dtsflags & DTSF_PLUGIN))
>> +			if (!phandle_is_valid(phandle)) {
>> +				/* Give up if this is an overlay with
>> +				 * external references */
>> +				if (dti->dtsflags & DTSF_PLUGIN)
>>  					return;
>> +				FAIL_PROP(c, dti, parent, prop, "Invalid phandle");
>> +				continue;
>> +			}
>> =20
>>  			irq_node =3D get_node_by_phandle(root, phandle);
>>  			if (!irq_node) {
>> @@ -1390,12 +1746,12 @@ static void check_interrupts_property(struct che=
ck *c,
>> =20
>>  	prop =3D get_property(irq_node, "#interrupt-cells");
>>  	if (!prop) {
>> -		FAIL(c, dti, irq_node, "Missing #interrupt-cells in interrupt-parent"=
);
>> +		/* We warn about that already in another test. */
>>  		return;
>>  	}
>> =20
>>  	irq_cells =3D propval_cell(prop);
>> -	if (irq_prop->val.len % (irq_cells * sizeof(cell_t))) {
>> +	if (!is_multiple_of(irq_prop->val.len, irq_cells * sizeof(cell_t))) {
>>  		FAIL_PROP(c, dti, node, prop,
>>  			  "size is (%d), expected multiple of %d",
>>  			  irq_prop->val.len, (int)(irq_cells * sizeof(cell_t)));
>> @@ -1421,6 +1777,11 @@ static void check_graph_nodes(struct check *c, st=
ruct dt_info *dti,
>>  		      get_property(child, "remote-endpoint")))
>>  			continue;
>> =20
>> +                /* The root node cannot be a port */
>> +		if (!node->parent) {
>> +			FAIL(c, dti, node, "root node contains endpoint node '%s', potential=
ly misplaced remote-endpoint property", child->name);
>> +			continue;
>> +		}
>>  		node->bus =3D &graph_port_bus;
>> =20
>>  		/* The parent of 'port' nodes can be either 'ports' or a device */
>> @@ -1434,31 +1795,6 @@ static void check_graph_nodes(struct check *c, st=
ruct dt_info *dti,
>>  }
>>  WARNING(graph_nodes, check_graph_nodes, NULL);
>> =20
>> -static void check_graph_child_address(struct check *c, struct dt_info *=
dti,
>> -				      struct node *node)
>> -{
>> -	int cnt =3D 0;
>> -	struct node *child;
>> -
>> -	if (node->bus !=3D &graph_ports_bus && node->bus !=3D &graph_port_bus)
>> -		return;
>> -
>> -	for_each_child(node, child) {
>> -		struct property *prop =3D get_property(child, "reg");
>> -
>> -		/* No error if we have any non-zero unit address */
>> -		if (prop && propval_cell(prop) !=3D 0)
>> -			return;
>> -
>> -		cnt++;
>> -	}
>> -
>> -	if (cnt =3D=3D 1 && node->addr_cells !=3D -1)
>> -		FAIL(c, dti, node, "graph node has single child node '%s', #address-c=
ells/#size-cells are not necessary",
>> -		     node->children->name);
>> -}
>> -WARNING(graph_child_address, check_graph_child_address, NULL, &graph_no=
des);
>> -
>>  static void check_graph_reg(struct check *c, struct dt_info *dti,
>>  			    struct node *node)
>>  {
>> @@ -1496,17 +1832,21 @@ static void check_graph_port(struct check *c, st=
ruct dt_info *dti,
>>  	if (node->bus !=3D &graph_port_bus)
>>  		return;
>> =20
>> +	check_graph_reg(c, dti, node);
>> +
>> +	/* skip checks below for overlays */
>> +	if (dti->dtsflags & DTSF_PLUGIN)
>> +		return;
>> +
>>  	if (!strprefixeq(node->name, node->basenamelen, "port"))
>>  		FAIL(c, dti, node, "graph port node name should be 'port'");
>> -
>> -	check_graph_reg(c, dti, node);
>>  }
>>  WARNING(graph_port, check_graph_port, NULL, &graph_nodes);
>> =20
>>  static struct node *get_remote_endpoint(struct check *c, struct dt_info=
 *dti,
>>  					struct node *endpoint)
>>  {
>> -	int phandle;
>> +	cell_t phandle;
>>  	struct node *node;
>>  	struct property *prop;
>> =20
>> @@ -1516,7 +1856,7 @@ static struct node *get_remote_endpoint(struct che=
ck *c, struct dt_info *dti,
>> =20
>>  	phandle =3D propval_cell(prop);
>>  	/* Give up if this is an overlay with external references */
>> -	if (phandle =3D=3D 0 || phandle =3D=3D -1)
>> +	if (!phandle_is_valid(phandle))
>>  		return NULL;
>> =20
>>  	node =3D get_node_by_phandle(dti->dt, phandle);
>> @@ -1534,11 +1874,15 @@ static void check_graph_endpoint(struct check *c=
, struct dt_info *dti,
>>  	if (!node->parent || node->parent->bus !=3D &graph_port_bus)
>>  		return;
>> =20
>> -	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
>> -		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
>> -
>>  	check_graph_reg(c, dti, node);
>> =20
>> +	/* skip checks below for overlays */
>> +	if (dti->dtsflags & DTSF_PLUGIN)
>> +		return;
>> +
>> +	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
>> +		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
>> +
>>  	remote_node =3D get_remote_endpoint(c, dti, node);
>>  	if (!remote_node)
>>  		return;
>> @@ -1549,10 +1893,35 @@ static void check_graph_endpoint(struct check *c=
, struct dt_info *dti,
>>  }
>>  WARNING(graph_endpoint, check_graph_endpoint, NULL, &graph_nodes);
>> =20
>> +static void check_graph_child_address(struct check *c, struct dt_info *=
dti,
>> +				      struct node *node)
>> +{
>> +	int cnt =3D 0;
>> +	struct node *child;
>> +
>> +	if (node->bus !=3D &graph_ports_bus && node->bus !=3D &graph_port_bus)
>> +		return;
>> +
>> +	for_each_child(node, child) {
>> +		struct property *prop =3D get_property(child, "reg");
>> +
>> +		/* No error if we have any non-zero unit address */
>> +                if (prop && propval_cell(prop) !=3D 0 )
>> +			return;
>> +
>> +		cnt++;
>> +	}
>> +
>> +	if (cnt =3D=3D 1 && node->addr_cells !=3D -1)
>> +		FAIL(c, dti, node, "graph node has single child node '%s', #address-c=
ells/#size-cells are not necessary",
>> +		     node->children->name);
>> +}
>> +WARNING(graph_child_address, check_graph_child_address, NULL, &graph_no=
des, &graph_port, &graph_endpoint);
>> +
>>  static struct check *check_table[] =3D {
>>  	&duplicate_node_names, &duplicate_property_names,
>>  	&node_name_chars, &node_name_format, &property_name_chars,
>> -	&name_is_string, &name_properties,
>> +	&name_is_string, &name_properties, &node_name_vs_property_name,
>> =20
>>  	&duplicate_label,
>> =20
>> @@ -1560,7 +1929,7 @@ static struct check *check_table[] =3D {
>>  	&phandle_references, &path_references,
>>  	&omit_unused_nodes,
>> =20
>> -	&address_cells_is_cell, &size_cells_is_cell, &interrupt_cells_is_cell,
>> +	&address_cells_is_cell, &size_cells_is_cell,
>>  	&device_type_is_string, &model_is_string, &status_is_string,
>>  	&label_is_string,
>> =20
>> @@ -1569,7 +1938,7 @@ static struct check *check_table[] =3D {
>>  	&property_name_chars_strict,
>>  	&node_name_chars_strict,
>> =20
>> -	&addr_size_cells, &reg_format, &ranges_format,
>> +	&addr_size_cells, &reg_format, &ranges_format, &dma_ranges_format,
>> =20
>>  	&unit_address_vs_reg,
>>  	&unit_address_format,
>> @@ -1581,32 +1950,57 @@ static struct check *check_table[] =3D {
>>  	&simple_bus_bridge,
>>  	&simple_bus_reg,
>> =20
>> +	&i2c_bus_bridge,
>> +	&i2c_bus_reg,
>> +
>> +	&spi_bus_bridge,
>> +	&spi_bus_reg,
>> +
>>  	&avoid_default_addr_size,
>>  	&avoid_unnecessary_addr_size,
>>  	&unique_unit_address,
>> +	&unique_unit_address_if_enabled,
>>  	&obsolete_chosen_interrupt_controller,
>>  	&chosen_node_is_root, &chosen_node_bootargs, &chosen_node_stdout_path,
>> =20
>>  	&clocks_property,
>> +	&clocks_is_cell,
>>  	&cooling_device_property,
>> +	&cooling_device_is_cell,
>>  	&dmas_property,
>> +	&dmas_is_cell,
>>  	&hwlocks_property,
>> +	&hwlocks_is_cell,
>>  	&interrupts_extended_property,
>> +	&interrupts_extended_is_cell,
>>  	&io_channels_property,
>> +	&io_channels_is_cell,
>>  	&iommus_property,
>> +	&iommus_is_cell,
>>  	&mboxes_property,
>> +	&mboxes_is_cell,
>>  	&msi_parent_property,
>> +	&msi_parent_is_cell,
>>  	&mux_controls_property,
>> +	&mux_controls_is_cell,
>>  	&phys_property,
>> +	&phys_is_cell,
>>  	&power_domains_property,
>> +	&power_domains_is_cell,
>>  	&pwms_property,
>> +	&pwms_is_cell,
>>  	&resets_property,
>> +	&resets_is_cell,
>>  	&sound_dai_property,
>> +	&sound_dai_is_cell,
>>  	&thermal_sensors_property,
>> +	&thermal_sensors_is_cell,
>> =20
>>  	&deprecated_gpio_property,
>>  	&gpios_property,
>>  	&interrupts_property,
>> +	&interrupt_provider,
>> +	&interrupt_map,
>> =20
>>  	&alias_paths,
>> =20
>> @@ -1630,7 +2024,7 @@ static void enable_warning_error(struct check *c, =
bool warn, bool error)
>> =20
>>  static void disable_warning_error(struct check *c, bool warn, bool erro=
r)
>>  {
>> -	int i;
>> +	unsigned int i;
>> =20
>>  	/* Lowering level, also lower it for things this is the prereq
>>  	 * for */
>> @@ -1651,7 +2045,7 @@ static void disable_warning_error(struct check *c,=
 bool warn, bool error)
>> =20
>>  void parse_checks_option(bool warn, bool error, const char *arg)
>>  {
>> -	int i;
>> +	unsigned int i;
>>  	const char *name =3D arg;
>>  	bool enable =3D true;
>> =20
>> @@ -1678,7 +2072,7 @@ void parse_checks_option(bool warn, bool error, co=
nst char *arg)
>> =20
>>  void process_checks(bool force, struct dt_info *dti)
>>  {
>> -	int i;
>> +	unsigned int i;
>>  	int error =3D 0;
>> =20
>>  	for (i =3D 0; i < ARRAY_SIZE(check_table); i++) {
>> diff --git a/scripts/dtc/data.c b/scripts/dtc/data.c
>> index aa37a16c889..5b25aa06041 100644
>> --- a/scripts/dtc/data.c
>> +++ b/scripts/dtc/data.c
>> @@ -1,21 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> @@ -36,10 +21,10 @@ void data_free(struct data d)
>>  		free(d.val);
>>  }
>> =20
>> -struct data data_grow_for(struct data d, int xlen)
>> +struct data data_grow_for(struct data d, unsigned int xlen)
>>  {
>>  	struct data nd;
>> -	int newsize;
>> +	unsigned int newsize;
>> =20
>>  	if (xlen =3D=3D 0)
>>  		return d;
>> @@ -74,7 +59,8 @@ struct data data_copy_escape_string(const char *s, int=
 len)
>>  	struct data d;
>>  	char *q;
>> =20
>> -	d =3D data_grow_for(empty_data, len + 1);
>> +	d =3D data_add_marker(empty_data, TYPE_STRING, NULL);
>> +	d =3D data_grow_for(d, len + 1);
>> =20
>>  	q =3D d.val;
>>  	while (i < len) {
>> @@ -94,10 +80,11 @@ struct data data_copy_file(FILE *f, size_t maxlen)
>>  {
>>  	struct data d =3D empty_data;
>> =20
>> +	d =3D data_add_marker(d, TYPE_NONE, NULL);
>>  	while (!feof(f) && (d.len < maxlen)) {
>>  		size_t chunksize, ret;
>> =20
>> -		if (maxlen =3D=3D -1)
>> +		if (maxlen =3D=3D (size_t)-1)
>>  			chunksize =3D 4096;
>>  		else
>>  			chunksize =3D maxlen - d.len;
>> @@ -241,11 +228,7 @@ struct data data_add_marker(struct data d, enum mar=
kertype type, char *ref)
>>  {
>>  	struct marker *m;
>> =20
>> -	m =3D xmalloc(sizeof(*m));
>> -	m->offset =3D d.len;
>> -	m->type =3D type;
>> -	m->ref =3D ref;
>> -	m->next =3D NULL;
>> +	m =3D alloc_marker(d.len, type, ref);
>> =20
>>  	return data_append_markers(d, m);
>>  }
>> @@ -267,3 +250,44 @@ bool data_is_one_string(struct data d)
>> =20
>>  	return true;
>>  }
>> +
>> +struct data data_insert_data(struct data d, struct marker *m, struct da=
ta old)
>> +{
>> +	unsigned int offset =3D m->offset;
>> +	struct marker *next =3D m->next;
>> +	struct marker *marker;
>> +	struct data new_data;
>> +	char *ref;
>> +
>> +	new_data =3D data_insert_at_marker(d, m, old.val, old.len);
>> +
>> +	/* Copy all markers from old value */
>> +	marker =3D old.markers;
>> +	for_each_marker(marker) {
>> +		ref =3D NULL;
>> +
>> +		if (marker->ref)
>> +			ref =3D xstrdup(marker->ref);
>> +
>> +		m->next =3D alloc_marker(marker->offset + offset, marker->type,
>> +				       ref);
>> +		m =3D m->next;
>> +	}
>> +	m->next =3D next;
>> +
>> +	return new_data;
>> +}
>> +
>> +struct marker *alloc_marker(unsigned int offset, enum markertype type,
>> +			    char *ref)
>> +{
>> +	struct marker *m;
>> +
>> +	m =3D xmalloc(sizeof(*m));
>> +	m->offset =3D offset;
>> +	m->type =3D type;
>> +	m->ref =3D ref;
>> +	m->next =3D NULL;
>> +
>> +	return m;
>> +}
>> diff --git a/scripts/dtc/dtc-lexer.l b/scripts/dtc/dtc-lexer.l
>> index d34e1b04220..15d585c8079 100644
>> --- a/scripts/dtc/dtc-lexer.l
>> +++ b/scripts/dtc/dtc-lexer.l
>> @@ -1,21 +1,6 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  %option noyywrap nounput noinput never-interactive
>> @@ -72,7 +57,7 @@ static void PRINTF(1, 2) lexical_error(const char *fmt=
, ...);
>>  			push_input_file(name);
>>  		}
>> =20
>> -<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)? {
>> +<*>^"#"(line)?[ \t]+[0-9]+[ \t]+{STRING}([ \t]+[0-9]+)* {
>>  			char *line, *fnstart, *fnend;
>>  			struct data fn;
>>  			/* skip text before line # */
>> @@ -166,6 +151,21 @@ static void PRINTF(1, 2) lexical_error(const char *=
fmt, ...);
>>  			return DT_LABEL;
>>  		}
>> =20
>> +<V1>{LABEL} 	{
>> +			/* Missed includes or macro definitions while
>> +			 * preprocessing can lead to unexpected identifiers in
>> +			 * the input. Report a slightly more informative error
>> +			 * in this case */
>> +
>> +			lexical_error("Unexpected '%s'", yytext);
>> +
>> +			/* Treat it as a literal which often generates further
>> +			 * useful error messages */
>> +
>> +			yylval.integer =3D 0;
>> +			return DT_LITERAL;
>> +		}
>> +
>>  <V1>([0-9]+|0[xX][0-9a-fA-F]+)(U|L|UL|LL|ULL)? {
>>  			char *e;
>>  			DPRINT("Integer Literal: '%s'\n", yytext);
>> @@ -212,14 +212,14 @@ static void PRINTF(1, 2) lexical_error(const char =
*fmt, ...);
>>  <*>\&{LABEL}	{	/* label reference */
>>  			DPRINT("Ref: %s\n", yytext+1);
>>  			yylval.labelref =3D xstrdup(yytext+1);
>> -			return DT_REF;
>> +			return DT_LABEL_REF;
>>  		}
>> =20
>>  <*>"&{"{PATHCHAR}*\}	{	/* new-style path reference */
>>  			yytext[yyleng-1] =3D '\0';
>>  			DPRINT("Ref: %s\n", yytext+2);
>>  			yylval.labelref =3D xstrdup(yytext+2);
>> -			return DT_REF;
>> +			return DT_PATH_REF;
>>  		}
>> =20
>>  <BYTESTRING>[0-9a-fA-F]{2} {
>> diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
>> index b3b9c83873d..4d5eece5262 100644
>> --- a/scripts/dtc/dtc-parser.y
>> +++ b/scripts/dtc/dtc-parser.y
>> @@ -1,22 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> +%locations
>> +
>>  %{
>>  #include <stdio.h>
>>  #include <inttypes.h>
>> @@ -32,6 +19,8 @@ extern void yyerror(char const *s);
>>  		treesource_error =3D true; \
>>  	} while (0)
>> =20
>> +#define YYERROR_CALL(msg) yyerror(msg)
>> +
>>  extern struct dt_info *parser_output;
>>  extern bool treesource_error;
>> =20
>> @@ -76,7 +65,8 @@ static bool is_ref_relative(const char *ref)
>>  %token <byte> DT_BYTE
>>  %token <data> DT_STRING
>>  %token <labelref> DT_LABEL
>> -%token <labelref> DT_REF
>> +%token <labelref> DT_LABEL_REF
>> +%token <labelref> DT_PATH_REF
>>  %token DT_INCBIN
>> =20
>>  %type <data> propdata
>> @@ -89,6 +79,7 @@ static bool is_ref_relative(const char *ref)
>>  %type <data> bytestring
>>  %type <prop> propdef
>>  %type <proplist> proplist
>> +%type <labelref> dt_ref
>> =20
>>  %type <node> devicetree
>>  %type <node> nodedef
>> @@ -164,6 +155,8 @@ memreserve:
>>  		}
>>  	;
>> =20
>> +dt_ref: DT_LABEL_REF | DT_PATH_REF;
>> +
>>  devicetree:
>>  	  '/' nodedef
>>  		{
>> @@ -173,7 +166,7 @@ devicetree:
>>  		{
>>  			$$ =3D merge_nodes($1, $3);
>>  		}
>> -	| DT_REF nodedef
>> +	| dt_ref nodedef
>>  		{
>>  			/*
>>  			 * We rely on the rule being always:
>> @@ -184,9 +177,12 @@ devicetree:
>>  				ERROR(&@2, "Label or path %s not found", $1);
>>  			else if (is_ref_relative($1))
>>  				ERROR(&@2, "Label-relative reference %s not supported in plugin", $=
1);
>> -			$$ =3D add_orphan_node(name_node(build_node(NULL, NULL), ""), $2, $1=
);
>> +			$$ =3D add_orphan_node(
>> +					name_node(build_node(NULL, NULL, NULL),
>> +						  ""),
>> +					$2, $1);
>>  		}
>> -	| devicetree DT_LABEL DT_REF nodedef
>> +	| devicetree DT_LABEL dt_ref nodedef
>>  		{
>>  			struct node *target =3D get_node_by_ref($1, $3);
>> =20
>> @@ -200,7 +196,7 @@ devicetree:
>>  				ERROR(&@3, "Label or path %s not found", $3);
>>  			$$ =3D $1;
>>  		}
>> -	| devicetree DT_REF nodedef
>> +	| devicetree DT_PATH_REF nodedef
>>  		{
>>  			/*
>>  			 * We rely on the rule being always:
>> @@ -221,7 +217,26 @@ devicetree:
>>  			}
>>  			$$ =3D $1;
>>  		}
>> -	| devicetree DT_DEL_NODE DT_REF ';'
>> +	| devicetree DT_LABEL_REF nodedef
>> +		{
>> +			struct node *target =3D get_node_by_ref($1, $2);
>> +
>> +			if (target) {
>> +				merge_nodes(target, $3);
>> +			} else {
>> +				/*
>> +				 * We rely on the rule being always:
>> +				 *   versioninfo plugindecl memreserves devicetree
>> +				 * so $-1 is what we want (plugindecl)
>> +				 */
>> +				if ($<flags>-1 & DTSF_PLUGIN)
>> +					add_orphan_node($1, $3, $2);
>> +				else
>> +					ERROR(&@2, "Label or path %s not found", $2);
>> +			}
>> +			$$ =3D $1;
>> +		}
>> +	| devicetree DT_DEL_NODE dt_ref ';'
>>  		{
>>  			struct node *target =3D get_node_by_ref($1, $3);
>> =20
>> @@ -233,7 +248,7 @@ devicetree:
>> =20
>>  			$$ =3D $1;
>>  		}
>> -	| devicetree DT_OMIT_NO_REF DT_REF ';'
>> +	| devicetree DT_OMIT_NO_REF dt_ref ';'
>>  		{
>>  			struct node *target =3D get_node_by_ref($1, $3);
>> =20
>> @@ -250,7 +265,7 @@ devicetree:
>>  nodedef:
>>  	  '{' proplist subnodes '}' ';'
>>  		{
>> -			$$ =3D build_node($2, $3);
>> +			$$ =3D build_node($2, $3, &@$);
>>  		}
>>  	;
>> =20
>> @@ -268,15 +283,18 @@ proplist:
>>  propdef:
>>  	  DT_PROPNODENAME '=3D' propdata ';'
>>  		{
>> -			$$ =3D build_property($1, $3);
>> +			$$ =3D build_property($1, $3, &@$);
>> +			free($1);
>>  		}
>>  	| DT_PROPNODENAME ';'
>>  		{
>> -			$$ =3D build_property($1, empty_data);
>> +			$$ =3D build_property($1, empty_data, &@$);
>> +			free($1);
>>  		}
>>  	| DT_DEL_PROP DT_PROPNODENAME ';'
>>  		{
>>  			$$ =3D build_property_delete($2);
>> +			free($2);
>>  		}
>>  	| DT_LABEL propdef
>>  		{
>> @@ -298,8 +316,9 @@ propdata:
>>  		{
>>  			$$ =3D data_merge($1, $3);
>>  		}
>> -	| propdataprefix DT_REF
>> +	| propdataprefix dt_ref
>>  		{
>> +			$1 =3D data_add_marker($1, TYPE_STRING, $2);
>>  			$$ =3D data_add_marker($1, REF_PATH, $2);
>>  		}
>>  	| propdataprefix DT_INCBIN '(' DT_STRING ',' integer_prim ',' integer_=
prim ')'
>> @@ -353,22 +372,27 @@ arrayprefix:
>>  	DT_BITS DT_LITERAL '<'
>>  		{
>>  			unsigned long long bits;
>> +			enum markertype type =3D TYPE_UINT32;
>> =20
>>  			bits =3D $2;
>> =20
>> -			if ((bits !=3D  8) && (bits !=3D 16) &&
>> -			    (bits !=3D 32) && (bits !=3D 64)) {
>> +			switch (bits) {
>> +			case 8: type =3D TYPE_UINT8; break;
>> +			case 16: type =3D TYPE_UINT16; break;
>> +			case 32: type =3D TYPE_UINT32; break;
>> +			case 64: type =3D TYPE_UINT64; break;
>> +			default:
>>  				ERROR(&@2, "Array elements must be"
>>  				      " 8, 16, 32 or 64-bits");
>>  				bits =3D 32;
>>  			}
>> =20
>> -			$$.data =3D empty_data;
>> +			$$.data =3D data_add_marker(empty_data, type, NULL);
>>  			$$.bits =3D bits;
>>  		}
>>  	| '<'
>>  		{
>> -			$$.data =3D empty_data;
>> +			$$.data =3D data_add_marker(empty_data, TYPE_UINT32, NULL);
>>  			$$.bits =3D 32;
>>  		}
>>  	| arrayprefix integer_prim
>> @@ -383,14 +407,19 @@ arrayprefix:
>>  				 * within the mask to one (i.e. | in the
>>  				 * mask), all bits are one.
>>  				 */
>> -				if (($2 > mask) && (($2 | mask) !=3D -1ULL))
>> -					ERROR(&@2, "Value out of range for"
>> -					      " %d-bit array element", $1.bits);
>> +				if (($2 > mask) && (($2 | mask) !=3D -1ULL)) {
>> +					char *loc =3D srcpos_string(&@2);
>> +					fprintf(stderr,
>> +						"WARNING: %s: Value 0x%016" PRIx64
>> +						" truncated to 0x%0*" PRIx64 "\n",
>> +						loc, $2, $1.bits / 4, ($2 & mask));
>> +					free(loc);
>> +				}
>>  			}
>> =20
>>  			$$.data =3D data_append_integer($1.data, $2, $1.bits);
>>  		}
>> -	| arrayprefix DT_REF
>> +	| arrayprefix dt_ref
>>  		{
>>  			uint64_t val =3D ~0ULL >> (64 - $1.bits);
>> =20
>> @@ -468,8 +497,8 @@ integer_rela:
>>  	;
>> =20
>>  integer_shift:
>> -	  integer_shift DT_LSHIFT integer_add { $$ =3D $1 << $3; }
>> -	| integer_shift DT_RSHIFT integer_add { $$ =3D $1 >> $3; }
>> +	  integer_shift DT_LSHIFT integer_add { $$ =3D ($3 < 64) ? ($1 << $3) =
: 0; }
>> +	| integer_shift DT_RSHIFT integer_add { $$ =3D ($3 < 64) ? ($1 >> $3) =
: 0; }
>>  	| integer_add
>>  	;
>> =20
>> @@ -512,7 +541,7 @@ integer_unary:
>>  bytestring:
>>  	  /* empty */
>>  		{
>> -			$$ =3D empty_data;
>> +			$$ =3D data_add_marker(empty_data, TYPE_UINT8, NULL);
>>  		}
>>  	| bytestring DT_BYTE
>>  		{
>> @@ -544,10 +573,12 @@ subnode:
>>  	  DT_PROPNODENAME nodedef
>>  		{
>>  			$$ =3D name_node($2, $1);
>> +			free($1);
>>  		}
>>  	| DT_DEL_NODE DT_PROPNODENAME ';'
>>  		{
>> -			$$ =3D name_node(build_node_delete(), $2);
>> +			$$ =3D name_node(build_node_delete(&@$), $2);
>> +			free($2);
>>  		}
>>  	| DT_OMIT_NO_REF subnode
>>  		{
>> diff --git a/scripts/dtc/dtc.c b/scripts/dtc/dtc.c
>> index c36994e6eac..b3445b7d647 100644
>> --- a/scripts/dtc/dtc.c
>> +++ b/scripts/dtc/dtc.c
>> @@ -1,21 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include <sys/stat.h>
>> @@ -27,14 +12,16 @@
>>   * Command line options
>>   */
>>  int quiet;		/* Level of quietness */
>> -int reservenum;		/* Number of memory reservation slots */
>> +unsigned int reservenum;/* Number of memory reservation slots */
>>  int minsize;		/* Minimum blob size */
>>  int padsize;		/* Additional padding to blob */
>> -int alignsize;		/* Additional padding to blob accroding to the alignsiz=
e */
>> +int alignsize;		/* Additional padding to blob according to the alignsiz=
e */
>>  int phandle_format =3D PHANDLE_EPAPR;	/* Use linux,phandle or phandle p=
roperties */
>>  int generate_symbols;	/* enable symbols & fixup support */
>>  int generate_fixups;		/* suppress generation of fixups on symbol suppor=
t */
>>  int auto_label_aliases;		/* auto generate labels -> aliases */
>> +int annotate;		/* Level of annotation: 1 for input source location
>> +			   >1 for full input source location. */
>> =20
>>  static int is_power_of_2(int x)
>>  {
>> @@ -60,7 +47,7 @@ static void fill_fullpaths(struct node *tree, const ch=
ar *prefix)
>> =20
>>  /* Usage related data. */
>>  static const char usage_synopsis[] =3D "dtc [options] <input file>";
>> -static const char usage_short_opts[] =3D "qI:O:o:V:d:R:S:p:a:fb:i:H:sW:=
E:@Ahv";
>> +static const char usage_short_opts[] =3D "qI:O:o:V:d:R:S:p:a:fb:i:H:sW:=
E:@LAThv";
>>  static struct option const usage_long_opts[] =3D {
>>  	{"quiet",            no_argument, NULL, 'q'},
>>  	{"in-format",         a_argument, NULL, 'I'},
>> @@ -80,7 +67,9 @@ static struct option const usage_long_opts[] =3D {
>>  	{"warning",           a_argument, NULL, 'W'},
>>  	{"error",             a_argument, NULL, 'E'},
>>  	{"symbols",	     no_argument, NULL, '@'},
>> +	{"local-fixups",     no_argument, NULL, 'L'},
>>  	{"auto-alias",       no_argument, NULL, 'A'},
>> +	{"annotate",         no_argument, NULL, 'T'},
>>  	{"help",             no_argument, NULL, 'h'},
>>  	{"version",          no_argument, NULL, 'v'},
>>  	{NULL,               no_argument, NULL, 0x0},
>> @@ -95,6 +84,9 @@ static const char * const usage_opts_help[] =3D {
>>  	"\n\tOutput formats are:\n"
>>  	 "\t\tdts - device tree source text\n"
>>  	 "\t\tdtb - device tree blob\n"
>> +#ifndef NO_YAML
>> +	 "\t\tyaml - device tree encoded as YAML\n"
>> +#endif
>>  	 "\t\tasm - assembler source",
>>  	"\n\tBlob version to produce, defaults to "stringify(DEFAULT_FDT_VERSI=
ON)" (for dtb and asm output)",
>>  	"\n\tOutput dependency file",
>> @@ -113,7 +105,9 @@ static const char * const usage_opts_help[] =3D {
>>  	"\n\tEnable/disable warnings (prefix with \"no-\")",
>>  	"\n\tEnable/disable errors (prefix with \"no-\")",
>>  	"\n\tEnable generation of symbols",
>> +	"\n\tPossibly generates a __local_fixups__ and a __fixups__ node at th=
e root node",
>>  	"\n\tEnable auto-alias of labels",
>> +	"\n\tAnnotate output .dts with input source file and line (-T -T for m=
ore details)",
>>  	"\n\tPrint this help and exit",
>>  	"\n\tPrint version and exit",
>>  	NULL,
>> @@ -128,6 +122,10 @@ static const char *guess_type_by_name(const char *f=
name, const char *fallback)
>>  		return fallback;
>>  	if (!strcasecmp(s, ".dts"))
>>  		return "dts";
>> +	if (!strcasecmp(s, ".yaml"))
>> +		return "yaml";
>> +	if (!strcasecmp(s, ".dtbo"))
>> +		return "dtb";
>>  	if (!strcasecmp(s, ".dtb"))
>>  		return "dtb";
>>  	return fallback;
>> @@ -201,7 +199,7 @@ int main(int argc, char *argv[])
>>  			depname =3D optarg;
>>  			break;
>>  		case 'R':
>> -			reservenum =3D strtol(optarg, NULL, 0);
>> +			reservenum =3D strtoul(optarg, NULL, 0);
>>  			break;
>>  		case 'S':
>>  			minsize =3D strtol(optarg, NULL, 0);
>> @@ -256,9 +254,17 @@ int main(int argc, char *argv[])
>>  		case '@':
>>  			generate_symbols =3D 1;
>>  			break;
>> +
>> +		case 'L':
>> +			generate_fixups =3D 1;
>> +			break;
>> +
>>  		case 'A':
>>  			auto_label_aliases =3D 1;
>>  			break;
>> +		case 'T':
>> +			annotate++;
>> +			break;
>> =20
>>  		case 'h':
>>  			usage(NULL);
>> @@ -283,7 +289,9 @@ int main(int argc, char *argv[])
>>  		if (!depfile)
>>  			die("Couldn't open dependency file %s: %s\n", depname,
>>  			    strerror(errno));
>> -		fprintf(depfile, "%s:", outname);
>> +
>> +		fprint_path_escaped(depfile, outname);
>> +		fputc(':', depfile);
>>  	}
>> =20
>>  	if (inform =3D=3D NULL)
>> @@ -297,6 +305,8 @@ int main(int argc, char *argv[])
>>  				outform =3D "dts";
>>  		}
>>  	}
>> +	if (annotate && (!streq(inform, "dts") || !streq(outform, "dts")))
>> +		die("--annotate requires -I dts -O dts\n");
>>  	if (streq(inform, "dts"))
>>  		dti =3D dt_from_source(arg);
>>  	else if (streq(inform, "fs"))
>> @@ -350,6 +360,12 @@ int main(int argc, char *argv[])
>> =20
>>  	if (streq(outform, "dts")) {
>>  		dt_to_source(outf, dti);
>> +#ifndef NO_YAML
>> +	} else if (streq(outform, "yaml")) {
>> +		if (!streq(inform, "dts"))
>> +			die("YAML output format requires dts input format\n");
>> +		dt_to_yaml(outf, dti);
>> +#endif
>>  	} else if (streq(outform, "dtb")) {
>>  		dt_to_blob(outf, dti, outversion);
>>  	} else if (streq(outform, "asm")) {
>> diff --git a/scripts/dtc/dtc.h b/scripts/dtc/dtc.h
>> index 39c50a2c4fc..fcc97bbc70e 100644
>> --- a/scripts/dtc/dtc.h
>> +++ b/scripts/dtc/dtc.h
>> @@ -1,24 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>  #ifndef DTC_H
>>  #define DTC_H
>> =20
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include <stdio.h>
>> @@ -50,14 +35,15 @@
>>   * Command line options
>>   */
>>  extern int quiet;		/* Level of quietness */
>> -extern int reservenum;		/* Number of memory reservation slots */
>> +extern unsigned int reservenum;	/* Number of memory reservation slots *=
/
>>  extern int minsize;		/* Minimum blob size */
>>  extern int padsize;		/* Additional padding to blob */
>> -extern int alignsize;		/* Additional padding to blob accroding to the a=
lignsize */
>> +extern int alignsize;		/* Additional padding to blob according to the a=
lignsize */
>>  extern int phandle_format;	/* Use linux,phandle or phandle properties *=
/
>>  extern int generate_symbols;	/* generate symbols for nodes with labels =
*/
>>  extern int generate_fixups;	/* generate fixups */
>>  extern int auto_label_aliases;	/* auto generate labels -> aliases */
>> +extern int annotate;		/* annotate .dts with input source location */
>> =20
>>  #define PHANDLE_LEGACY	0x1
>>  #define PHANDLE_EPAPR	0x2
>> @@ -65,28 +51,88 @@ extern int auto_label_aliases;	/* auto generate labe=
ls -> aliases */
>> =20
>>  typedef uint32_t cell_t;
>> =20
>> +static inline bool phandle_is_valid(cell_t phandle)
>> +{
>> +	return phandle !=3D 0 && phandle !=3D ~0U;
>> +}
>> +
>> +static inline uint16_t dtb_ld16(const void *p)
>> +{
>> +	const uint8_t *bp =3D (const uint8_t *)p;
>> +
>> +	return ((uint16_t)bp[0] << 8)
>> +		| bp[1];
>> +}
>> +
>> +static inline uint32_t dtb_ld32(const void *p)
>> +{
>> +	const uint8_t *bp =3D (const uint8_t *)p;
>> +
>> +	return ((uint32_t)bp[0] << 24)
>> +		| ((uint32_t)bp[1] << 16)
>> +		| ((uint32_t)bp[2] << 8)
>> +		| bp[3];
>> +}
>> +
>> +static inline uint64_t dtb_ld64(const void *p)
>> +{
>> +	const uint8_t *bp =3D (const uint8_t *)p;
>> +
>> +	return ((uint64_t)bp[0] << 56)
>> +		| ((uint64_t)bp[1] << 48)
>> +		| ((uint64_t)bp[2] << 40)
>> +		| ((uint64_t)bp[3] << 32)
>> +		| ((uint64_t)bp[4] << 24)
>> +		| ((uint64_t)bp[5] << 16)
>> +		| ((uint64_t)bp[6] << 8)
>> +		| bp[7];
>> +}
>> +
>>  #define streq(a, b)	(strcmp((a), (b)) =3D=3D 0)
>>  #define strstarts(s, prefix)	(strncmp((s), (prefix), strlen(prefix)) =
=3D=3D 0)
>>  #define strprefixeq(a, n, b)	(strlen(b) =3D=3D (n) && (memcmp(a, b, n) =
=3D=3D 0))
>> +static inline bool strends(const char *str, const char *suffix)
>> +{
>> +	unsigned int len, suffix_len;
>> +
>> +	len =3D strlen(str);
>> +	suffix_len =3D strlen(suffix);
>> +	if (len < suffix_len)
>> +		return false;
>> +	return streq(str + len - suffix_len, suffix);
>> +}
>> =20
>>  #define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
>> =20
>>  /* Data blobs */
>>  enum markertype {
>> +	TYPE_NONE,
>>  	REF_PHANDLE,
>>  	REF_PATH,
>>  	LABEL,
>> +	TYPE_UINT8,
>> +	TYPE_UINT16,
>> +	TYPE_UINT32,
>> +	TYPE_UINT64,
>> +	TYPE_STRING,
>>  };
>> =20
>> +static inline bool is_type_marker(enum markertype type)
>> +{
>> +	return type >=3D TYPE_UINT8;
>> +}
>> +
>> +extern const char *markername(enum markertype markertype);
>> +
>>  struct  marker {
>>  	enum markertype type;
>> -	int offset;
>> +	unsigned int offset;
>>  	char *ref;
>>  	struct marker *next;
>>  };
>> =20
>>  struct data {
>> -	int len;
>> +	unsigned int len;
>>  	char *val;
>>  	struct marker *markers;
>>  };
>> @@ -99,9 +145,26 @@ struct data {
>>  	for_each_marker(m) \
>>  		if ((m)->type =3D=3D (t))
>> =20
>> +static inline struct marker *next_type_marker(struct marker *m)
>> +{
>> +	for_each_marker(m)
>> +		if (is_type_marker(m->type))
>> +			break;
>> +	return m;
>> +}
>> +
>> +static inline size_t type_marker_length(struct marker *m)
>> +{
>> +	struct marker *next =3D next_type_marker(m->next);
>> +
>> +	if (next)
>> +		return next->offset - m->offset;
>> +	return 0;
>> +}
>> +
>>  void data_free(struct data d);
>> =20
>> -struct data data_grow_for(struct data d, int xlen);
>> +struct data data_grow_for(struct data d, unsigned int xlen);
>> =20
>>  struct data data_copy_mem(const char *mem, int len);
>>  struct data data_copy_escape_string(const char *s, int len);
>> @@ -118,7 +181,10 @@ struct data data_append_addr(struct data d, uint64_=
t addr);
>>  struct data data_append_byte(struct data d, uint8_t byte);
>>  struct data data_append_zeroes(struct data d, int len);
>>  struct data data_append_align(struct data d, int align);
>> +struct data data_insert_data(struct data d, struct marker *m, struct da=
ta old);
>> =20
>> +struct marker *alloc_marker(unsigned int offset, enum markertype type,
>> +			    char *ref);
>>  struct data data_add_marker(struct data d, enum markertype type, char *=
ref);
>> =20
>>  bool data_is_one_string(struct data d);
>> @@ -147,6 +213,7 @@ struct property {
>>  	struct property *next;
>> =20
>>  	struct label *labels;
>> +	struct srcpos *srcpos;
>>  };
>> =20
>>  struct node {
>> @@ -166,6 +233,7 @@ struct node {
>> =20
>>  	struct label *labels;
>>  	const struct bus_type *bus;
>> +	struct srcpos *srcpos;
>> =20
>>  	bool omit_if_unused, is_referenced;
>>  };
>> @@ -194,14 +262,16 @@ struct node {
>>  void add_label(struct label **labels, char *label);
>>  void delete_labels(struct label **labels);
>> =20
>> -struct property *build_property(char *name, struct data val);
>> -struct property *build_property_delete(char *name);
>> +struct property *build_property(const char *name, struct data val,
>> +				struct srcpos *srcpos);
>> +struct property *build_property_delete(const char *name);
>>  struct property *chain_property(struct property *first, struct property=
 *list);
>>  struct property *reverse_properties(struct property *first);
>> =20
>> -struct node *build_node(struct property *proplist, struct node *childre=
n);
>> -struct node *build_node_delete(void);
>> -struct node *name_node(struct node *node, char *name);
>> +struct node *build_node(struct property *proplist, struct node *childre=
n,
>> +			struct srcpos *srcpos);
>> +struct node *build_node_delete(struct srcpos *srcpos);
>> +struct node *name_node(struct node *node, const char *name);
>>  struct node *omit_node_if_unused(struct node *node);
>>  struct node *reference_node(struct node *node);
>>  struct node *chain_node(struct node *first, struct node *list);
>> @@ -215,12 +285,13 @@ void add_child(struct node *parent, struct node *c=
hild);
>>  void delete_node_by_name(struct node *parent, char *name);
>>  void delete_node(struct node *node);
>>  void append_to_property(struct node *node,
>> -			char *name, const void *data, int len);
>> +			char *name, const void *data, int len,
>> +			enum markertype type);
>> =20
>>  const char *get_unitname(struct node *node);
>>  struct property *get_property(struct node *node, const char *propname);
>>  cell_t propval_cell(struct property *prop);
>> -cell_t propval_cell_n(struct property *prop, int n);
>> +cell_t propval_cell_n(struct property *prop, unsigned int n);
>>  struct property *get_property_by_label(struct node *tree, const char *l=
abel,
>>  				       struct node **node);
>>  struct marker *get_marker_label(struct node *tree, const char *label,
>> @@ -266,9 +337,9 @@ struct dt_info *build_dt_info(unsigned int dtsflags,
>>  			      struct reserve_info *reservelist,
>>  			      struct node *tree, uint32_t boot_cpuid_phys);
>>  void sort_tree(struct dt_info *dti);
>> -void generate_label_tree(struct dt_info *dti, char *name, bool allocph)=
;
>> -void generate_fixups_tree(struct dt_info *dti, char *name);
>> -void generate_local_fixups_tree(struct dt_info *dti, char *name);
>> +void generate_label_tree(struct dt_info *dti, const char *name, bool al=
locph);
>> +void generate_fixups_tree(struct dt_info *dti, const char *name);
>> +void generate_local_fixups_tree(struct dt_info *dti, const char *name);
>> =20
>>  /* Checks */
>> =20
>> @@ -287,6 +358,10 @@ struct dt_info *dt_from_blob(const char *fname);
>>  void dt_to_source(FILE *f, struct dt_info *dti);
>>  struct dt_info *dt_from_source(const char *f);
>> =20
>> +/* YAML source */
>> +
>> +void dt_to_yaml(FILE *f, struct dt_info *dti);
>> +
>>  /* FS trees */
>> =20
>>  struct dt_info *dt_from_fs(const char *dirname);
>> diff --git a/scripts/dtc/fdtoverlay.c b/scripts/dtc/fdtoverlay.c
>> new file mode 100644
>> index 00000000000..ee1eb8f3ad2
>> --- /dev/null
>> +++ b/scripts/dtc/fdtoverlay.c
>> @@ -0,0 +1,214 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2017 Konsulko Group Inc. All rights reserved.
>> + *
>> + * Author:
>> + *	 Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> + */
>> +
>> +#include <assert.h>
>> +#include <ctype.h>
>> +#include <getopt.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <inttypes.h>
>> +
>> +#include <libfdt.h>
>> +
>> +#include "util.h"
>> +
>> +#define BUF_INCREMENT	65536
>> +
>> +/* Usage related data. */
>> +static const char usage_synopsis[] =3D
>> +	"apply a number of overlays to a base blob\n"
>> +	"	fdtoverlay <options> [<overlay.dtbo> [<overlay.dtbo>]]";
>> +static const char usage_short_opts[] =3D "i:o:v" USAGE_COMMON_SHORT_OPT=
S;
>> +static struct option const usage_long_opts[] =3D {
>> +	{"input",            required_argument, NULL, 'i'},
>> +	{"output",	     required_argument, NULL, 'o'},
>> +	{"verbose",	           no_argument, NULL, 'v'},
>> +	USAGE_COMMON_LONG_OPTS,
>> +};
>> +static const char * const usage_opts_help[] =3D {
>> +	"Input base DT blob",
>> +	"Output DT blob",
>> +	"Verbose messages",
>> +	USAGE_COMMON_OPTS_HELP
>> +};
>> +
>> +int verbose =3D 0;
>> +
>> +static void *apply_one(char *base, const char *overlay, size_t *buf_len=
,
>> +		       const char *name)
>> +{
>> +	char *tmp =3D NULL;
>> +	char *tmpo;
>> +	int ret;
>> +	bool has_symbols;
>> +
>> +	/*
>> +	 * We take copies first, because a failed apply can trash
>> +	 * both the base blob and the overlay
>> +	 */
>> +	tmpo =3D xmalloc(fdt_totalsize(overlay));
>> +
>> +	do {
>> +		tmp =3D xrealloc(tmp, *buf_len);
>> +		ret =3D fdt_open_into(base, tmp, *buf_len);
>> +		if (ret) {
>> +			fprintf(stderr,
>> +				"\nFailed to make temporary copy: %s\n",
>> +				fdt_strerror(ret));
>> +			goto fail;
>> +		}
>> +		ret =3D fdt_path_offset(tmp, "/__symbols__");
>> +		has_symbols =3D ret >=3D 0;
>> +
>> +		memcpy(tmpo, overlay, fdt_totalsize(overlay));
>> +
>> +		ret =3D fdt_overlay_apply(tmp, tmpo);
>> +		if (ret =3D=3D -FDT_ERR_NOSPACE) {
>> +			*buf_len +=3D BUF_INCREMENT;
>> +		}
>> +	} while (ret =3D=3D -FDT_ERR_NOSPACE);
>> +
>> +	if (ret) {
>> +		fprintf(stderr, "\nFailed to apply '%s': %s\n",
>> +			name, fdt_strerror(ret));
>> +		if (!has_symbols) {
>> +			fprintf(stderr,
>> +				"base blob does not have a '/__symbols__' node, "
>> +				"make sure you have compiled the base blob with '-@' option\n");
>> +		}
>> +		goto fail;
>> +	}
>> +
>> +	free(base);
>> +	free(tmpo);
>> +	return tmp;
>> +
>> +fail:
>> +	free(tmpo);
>> +	if (tmp)
>> +		free(tmp);
>> +
>> +	return NULL;
>> +}
>> +static int do_fdtoverlay(const char *input_filename,
>> +			 const char *output_filename,
>> +			 int argc, char *argv[])
>> +{
>> +	char *blob =3D NULL;
>> +	char **ovblob =3D NULL;
>> +	size_t buf_len;
>> +	int i, ret =3D -1;
>> +
>> +	blob =3D utilfdt_read(input_filename, &buf_len);
>> +	if (!blob) {
>> +		fprintf(stderr, "\nFailed to read '%s'\n", input_filename);
>> +		goto out_err;
>> +	}
>> +	if (fdt_totalsize(blob) > buf_len) {
>> +		fprintf(stderr,
>> + "\nBase blob is incomplete (%lu / %" PRIu32 " bytes read)\n",
>> +			(unsigned long)buf_len, fdt_totalsize(blob));
>> +		goto out_err;
>> +	}
>> +
>> +	/* allocate blob pointer array */
>> +	ovblob =3D xmalloc(sizeof(*ovblob) * argc);
>> +	memset(ovblob, 0, sizeof(*ovblob) * argc);
>> +
>> +	/* read and keep track of the overlay blobs */
>> +	for (i =3D 0; i < argc; i++) {
>> +		size_t ov_len;
>> +		ovblob[i] =3D utilfdt_read(argv[i], &ov_len);
>> +		if (!ovblob[i]) {
>> +			fprintf(stderr, "\nFailed to read '%s'\n", argv[i]);
>> +			goto out_err;
>> +		}
>> +		if (fdt_totalsize(ovblob[i]) > ov_len) {
>> +			fprintf(stderr,
>> +"\nOverlay '%s' is incomplete (%lu / %" PRIu32 " bytes read)\n",
>> +				argv[i], (unsigned long)ov_len,
>> +				fdt_totalsize(ovblob[i]));
>> +			goto out_err;
>> +		}
>> +	}
>> +
>> +	buf_len =3D fdt_totalsize(blob);
>> +
>> +	/* apply the overlays in sequence */
>> +	for (i =3D 0; i < argc; i++) {
>> +		blob =3D apply_one(blob, ovblob[i], &buf_len, argv[i]);
>> +		if (!blob)
>> +			goto out_err;
>> +	}
>> +
>> +	fdt_pack(blob);
>> +	ret =3D utilfdt_write(output_filename, blob);
>> +	if (ret)
>> +		fprintf(stderr, "\nFailed to write '%s'\n",
>> +			output_filename);
>> +
>> +out_err:
>> +	if (ovblob) {
>> +		for (i =3D 0; i < argc; i++) {
>> +			if (ovblob[i])
>> +				free(ovblob[i]);
>> +		}
>> +		free(ovblob);
>> +	}
>> +	free(blob);
>> +
>> +	return ret;
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	int opt, i;
>> +	char *input_filename =3D NULL;
>> +	char *output_filename =3D NULL;
>> +
>> +	while ((opt =3D util_getopt_long()) !=3D EOF) {
>> +		switch (opt) {
>> +		case_USAGE_COMMON_FLAGS
>> +
>> +		case 'i':
>> +			input_filename =3D optarg;
>> +			break;
>> +		case 'o':
>> +			output_filename =3D optarg;
>> +			break;
>> +		case 'v':
>> +			verbose =3D 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!input_filename)
>> +		usage("missing input file");
>> +
>> +	if (!output_filename)
>> +		usage("missing output file");
>> +
>> +	argv +=3D optind;
>> +	argc -=3D optind;
>> +
>> +	if (argc <=3D 0)
>> +		usage("missing overlay file(s)");
>> +
>> +	if (verbose) {
>> +		printf("input  =3D %s\n", input_filename);
>> +		printf("output =3D %s\n", output_filename);
>> +		for (i =3D 0; i < argc; i++)
>> +			printf("overlay[%d] =3D %s\n", i, argv[i]);
>> +	}
>> +
>> +	if (do_fdtoverlay(input_filename, output_filename, argc, argv))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
>> index 086c5abf10f..ae3f9dec82f 100644
>> --- a/scripts/dtc/flattree.c
>> +++ b/scripts/dtc/flattree.c
>> @@ -1,21 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> @@ -139,7 +124,8 @@ static void asm_emit_cell(void *e, cell_t val)
>>  {
>>  	FILE *f =3D e;
>> =20
>> -	fprintf(f, "\t.byte 0x%02x; .byte 0x%02x; .byte 0x%02x; .byte 0x%02x\n=
",
>> +	fprintf(f, "\t.byte\t0x%02x\n" "\t.byte\t0x%02x\n"
>> +		"\t.byte\t0x%02x\n" "\t.byte\t0x%02x\n",
>>  		(val >> 24) & 0xff, (val >> 16) & 0xff,
>>  		(val >> 8) & 0xff, val & 0xff);
>>  }
>> @@ -149,9 +135,9 @@ static void asm_emit_string(void *e, const char *str=
, int len)
>>  	FILE *f =3D e;
>> =20
>>  	if (len !=3D 0)
>> -		fprintf(f, "\t.string\t\"%.*s\"\n", len, str);
>> +		fprintf(f, "\t.asciz\t\"%.*s\"\n", len, str);
>>  	else
>> -		fprintf(f, "\t.string\t\"%s\"\n", str);
>> +		fprintf(f, "\t.asciz\t\"%s\"\n", str);
>>  }
>> =20
>>  static void asm_emit_align(void *e, int a)
>> @@ -164,14 +150,14 @@ static void asm_emit_align(void *e, int a)
>>  static void asm_emit_data(void *e, struct data d)
>>  {
>>  	FILE *f =3D e;
>> -	int off =3D 0;
>> +	unsigned int off =3D 0;
>>  	struct marker *m =3D d.markers;
>> =20
>>  	for_each_marker_of_type(m, LABEL)
>>  		emit_offset_label(f, m->ref, m->offset);
>> =20
>>  	while ((d.len - off) >=3D sizeof(uint32_t)) {
>> -		asm_emit_cell(e, fdt32_to_cpu(*((fdt32_t *)(d.val+off))));
>> +		asm_emit_cell(e, dtb_ld32(d.val + off));
>>  		off +=3D sizeof(uint32_t);
>>  	}
>> =20
>> @@ -234,7 +220,7 @@ static struct emitter asm_emitter =3D {
>> =20
>>  static int stringtable_insert(struct data *d, const char *str)
>>  {
>> -	int i;
>> +	unsigned int i;
>> =20
>>  	/* FIXME: do this more efficiently? */
>> =20
>> @@ -310,7 +296,7 @@ static struct data flatten_reserve_list(struct reser=
ve_info *reservelist,
>>  {
>>  	struct reserve_info *re;
>>  	struct data d =3D empty_data;
>> -	int    j;
>> +	unsigned int j;
>> =20
>>  	for (re =3D reservelist; re; re =3D re->next) {
>>  		d =3D data_append_re(d, re->address, re->size);
>> @@ -360,7 +346,7 @@ static void make_fdt_header(struct fdt_header *fdt,
>>  void dt_to_blob(FILE *f, struct dt_info *dti, int version)
>>  {
>>  	struct version_info *vi =3D NULL;
>> -	int i;
>> +	unsigned int i;
>>  	struct data blob       =3D empty_data;
>>  	struct data reservebuf =3D empty_data;
>>  	struct data dtbuf      =3D empty_data;
>> @@ -393,7 +379,7 @@ void dt_to_blob(FILE *f, struct dt_info *dti, int ve=
rsion)
>>  			padlen =3D 0;
>>  			if (quiet < 1)
>>  				fprintf(stderr,
>> -					"Warning: blob size %d >=3D minimum size %d\n",
>> +					"Warning: blob size %"PRIu32" >=3D minimum size %d\n",
>>  					fdt32_to_cpu(fdt.totalsize), minsize);
>>  		}
>>  	}
>> @@ -453,7 +439,7 @@ static void dump_stringtable_asm(FILE *f, struct dat=
a strbuf)
>> =20
>>  	while (p < (strbuf.val + strbuf.len)) {
>>  		len =3D strlen(p);
>> -		fprintf(f, "\t.string \"%s\"\n", p);
>> +		fprintf(f, "\t.asciz \"%s\"\n", p);
>>  		p +=3D len+1;
>>  	}
>>  }
>> @@ -461,7 +447,7 @@ static void dump_stringtable_asm(FILE *f, struct dat=
a strbuf)
>>  void dt_to_asm(FILE *f, struct dt_info *dti, int version)
>>  {
>>  	struct version_info *vi =3D NULL;
>> -	int i;
>> +	unsigned int i;
>>  	struct data strbuf =3D empty_data;
>>  	struct reserve_info *re;
>>  	const char *symprefix =3D "dt";
>> @@ -517,7 +503,7 @@ void dt_to_asm(FILE *f, struct dt_info *dti, int ver=
sion)
>>  	 * Reserve map entries.
>>  	 * Align the reserve map to a doubleword boundary.
>>  	 * Each entry is an (address, size) pair of u64 values.
>> -	 * Always supply a zero-sized temination entry.
>> +	 * Always supply a zero-sized termination entry.
>>  	 */
>>  	asm_emit_align(f, 8);
>>  	emit_label(f, symprefix, "reserve_map");
>> @@ -525,7 +511,7 @@ void dt_to_asm(FILE *f, struct dt_info *dti, int ver=
sion)
>>  	fprintf(f, "/* Memory reserve map from source file */\n");
>> =20
>>  	/*
>> -	 * Use .long on high and low halfs of u64s to avoid .quad
>> +	 * Use .long on high and low halves of u64s to avoid .quad
>>  	 * as it appears .quad isn't available in some assemblers.
>>  	 */
>>  	for (re =3D dti->reservelist; re; re =3D re->next) {
>> @@ -618,11 +604,11 @@ static void flat_realign(struct inbuf *inb, int al=
ign)
>>  		die("Premature end of data parsing flat device tree\n");
>>  }
>> =20
>> -static char *flat_read_string(struct inbuf *inb)
>> +static const char *flat_read_string(struct inbuf *inb)
>>  {
>>  	int len =3D 0;
>>  	const char *p =3D inb->ptr;
>> -	char *str;
>> +	const char *str;
>> =20
>>  	do {
>>  		if (p >=3D inb->limit)
>> @@ -630,7 +616,7 @@ static char *flat_read_string(struct inbuf *inb)
>>  		len++;
>>  	} while ((*p++) !=3D '\0');
>> =20
>> -	str =3D xstrdup(inb->ptr);
>> +	str =3D inb->ptr;
>> =20
>>  	inb->ptr +=3D len;
>> =20
>> @@ -692,7 +678,7 @@ static struct property *flat_read_property(struct in=
buf *dtbuf,
>> =20
>>  	val =3D flat_read_data(dtbuf, proplen);
>> =20
>> -	return build_property(name, val);
>> +	return build_property(name, val, NULL);
>>  }
>> =20
>>  static struct reserve_info *flat_read_mem_reserve(struct inbuf *inb)
>> @@ -723,7 +709,8 @@ static struct reserve_info *flat_read_mem_reserve(st=
ruct inbuf *inb)
>>  	return reservelist;
>>  }
>> =20
>> -static char *nodename_from_path(const char *ppath, const char *cpath)
>> +
>> +static const char *nodename_from_path(const char *ppath, const char *cp=
ath)
>>  {
>>  	int plen;
>> =20
>> @@ -737,7 +724,7 @@ static char *nodename_from_path(const char *ppath, c=
onst char *cpath)
>>  	if (!streq(ppath, "/"))
>>  		plen++;
>> =20
>> -	return xstrdup(cpath + plen);
>> +	return cpath + plen;
>>  }
>> =20
>>  static struct node *unflatten_tree(struct inbuf *dtbuf,
>> @@ -745,17 +732,18 @@ static struct node *unflatten_tree(struct inbuf *d=
tbuf,
>>  				   const char *parent_flatname, int flags)
>>  {
>>  	struct node *node;
>> -	char *flatname;
>> +	const char *flatname;
>>  	uint32_t val;
>> =20
>> -	node =3D build_node(NULL, NULL);
>> +	node =3D build_node(NULL, NULL, NULL);
>> =20
>>  	flatname =3D flat_read_string(dtbuf);
>> =20
>>  	if (flags & FTF_FULLPATH)
>> -		node->name =3D nodename_from_path(parent_flatname, flatname);
>> +		node->name =3D xstrdup(nodename_from_path(parent_flatname,
>> +							flatname));
>>  	else
>> -		node->name =3D flatname;
>> +		node->name =3D xstrdup(flatname);
>> =20
>>  	do {
>>  		struct property *prop;
>> @@ -797,10 +785,6 @@ static struct node *unflatten_tree(struct inbuf *dt=
buf,
>>  		}
>>  	} while (val !=3D FDT_END_NODE);
>> =20
>> -	if (node->name !=3D flatname) {
>> -		free(flatname);
>> -	}
>> -
>>  	return node;
>>  }
>> =20
>> diff --git a/scripts/dtc/fstree.c b/scripts/dtc/fstree.c
>> index ae7d06c3c49..0f9a534bacd 100644
>> --- a/scripts/dtc/fstree.c
>> +++ b/scripts/dtc/fstree.c
>> @@ -1,21 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> @@ -34,7 +19,7 @@ static struct node *read_fstree(const char *dirname)
>>  	if (!d)
>>  		die("Couldn't opendir() \"%s\": %s\n", dirname, strerror(errno));
>> =20
>> -	tree =3D build_node(NULL, NULL);
>> +	tree =3D build_node(NULL, NULL, NULL);
>> =20
>>  	while ((de =3D readdir(d)) !=3D NULL) {
>>  		char *tmpname;
>> @@ -45,7 +30,7 @@ static struct node *read_fstree(const char *dirname)
>> =20
>>  		tmpname =3D join_path(dirname, de->d_name);
>> =20
>> -		if (lstat(tmpname, &st) < 0)
>> +		if (stat(tmpname, &st) < 0)
>>  			die("stat(%s): %s\n", tmpname, strerror(errno));
>> =20
>>  		if (S_ISREG(st.st_mode)) {
>> @@ -58,9 +43,10 @@ static struct node *read_fstree(const char *dirname)
>>  					"WARNING: Cannot open %s: %s\n",
>>  					tmpname, strerror(errno));
>>  			} else {
>> -				prop =3D build_property(xstrdup(de->d_name),
>> +				prop =3D build_property(de->d_name,
>>  						      data_copy_file(pfile,
>> -								     st.st_size));
>> +								     st.st_size),
>> +						      NULL);
>>  				add_property(tree, prop);
>>  				fclose(pfile);
>>  			}
>> diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
>> index 28f4e1a5f15..95f644c31f9 100644
>> --- a/scripts/dtc/libfdt/fdt.c
>> +++ b/scripts/dtc/libfdt/fdt.c
>> @@ -19,9 +19,16 @@ int32_t fdt_ro_probe_(const void *fdt)
>>  {
>>  	uint32_t totalsize =3D fdt_totalsize(fdt);
>> =20
>> +	if (can_assume(VALID_DTB))
>> +		return totalsize;
>> +
>> +	/* The device tree must be at an 8-byte aligned address */
>> +	if ((uintptr_t)fdt & 7)
>> +		return -FDT_ERR_ALIGNMENT;
>> +
>>  	if (fdt_magic(fdt) =3D=3D FDT_MAGIC) {
>>  		/* Complete tree */
>> -		if (fdt_chk_version()) {
>> +		if (!can_assume(LATEST)) {
>>  			if (fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
>>  				return -FDT_ERR_BADVERSION;
>>  			if (fdt_last_comp_version(fdt) >
>> @@ -30,7 +37,7 @@ int32_t fdt_ro_probe_(const void *fdt)
>>  		}
>>  	} else if (fdt_magic(fdt) =3D=3D FDT_SW_MAGIC) {
>>  		/* Unfinished sequential-write blob */
>> -		if (fdt_size_dt_struct(fdt) =3D=3D 0)
>> +		if (!can_assume(VALID_INPUT) && fdt_size_dt_struct(fdt) =3D=3D 0)
>>  			return -FDT_ERR_BADSTATE;
>>  	} else {
>>  		return -FDT_ERR_BADMAGIC;
>> @@ -75,17 +82,21 @@ size_t fdt_header_size_(uint32_t version)
>> =20
>>  size_t fdt_header_size(const void *fdt)
>>  {
>> -	return fdt_chk_version() ? fdt_header_size_(fdt_version(fdt)) :
>> -		FDT_V17_SIZE;
>> +	return can_assume(LATEST) ? FDT_V17_SIZE :
>> +		fdt_header_size_(fdt_version(fdt));
>>  }
>> =20
>>  int fdt_check_header(const void *fdt)
>>  {
>>  	size_t hdrsize;
>> =20
>> +	/* The device tree must be at an 8-byte aligned address */
>> +	if ((uintptr_t)fdt & 7)
>> +		return -FDT_ERR_ALIGNMENT;
>> +
>>  	if (fdt_magic(fdt) !=3D FDT_MAGIC)
>>  		return -FDT_ERR_BADMAGIC;
>> -	if (fdt_chk_version()) {
>> +	if (!can_assume(LATEST)) {
>>  		if ((fdt_version(fdt) < FDT_FIRST_SUPPORTED_VERSION)
>>  		    || (fdt_last_comp_version(fdt) >
>>  			FDT_LAST_SUPPORTED_VERSION))
>> @@ -94,8 +105,7 @@ int fdt_check_header(const void *fdt)
>>  			return -FDT_ERR_BADVERSION;
>>  	}
>>  	hdrsize =3D fdt_header_size(fdt);
>> -	if (fdt_chk_basic()) {
>> -
>> +	if (!can_assume(VALID_DTB)) {
>>  		if ((fdt_totalsize(fdt) < hdrsize)
>>  		    || (fdt_totalsize(fdt) > INT_MAX))
>>  			return -FDT_ERR_TRUNCATED;
>> @@ -104,11 +114,9 @@ int fdt_check_header(const void *fdt)
>>  		if (!check_off_(hdrsize, fdt_totalsize(fdt),
>>  				fdt_off_mem_rsvmap(fdt)))
>>  			return -FDT_ERR_TRUNCATED;
>> -	}
>> =20
>> -	if (fdt_chk_extra()) {
>>  		/* Bounds check structure block */
>> -		if (fdt_chk_version() && fdt_version(fdt) < 17) {
>> +		if (!can_assume(LATEST) && fdt_version(fdt) < 17) {
>>  			if (!check_off_(hdrsize, fdt_totalsize(fdt),
>>  					fdt_off_dt_struct(fdt)))
>>  				return -FDT_ERR_TRUNCATED;
>> @@ -137,13 +145,13 @@ const void *fdt_offset_ptr(const void *fdt, int of=
fset, unsigned int len)
>>  	if (offset < 0)
>>  		return NULL;
>> =20
>> -	if (fdt_chk_basic())
>> +	if (!can_assume(VALID_INPUT))
>>  		if ((absoffset < uoffset)
>>  		    || ((absoffset + len) < absoffset)
>>  		    || (absoffset + len) > fdt_totalsize(fdt))
>>  			return NULL;
>> =20
>> -	if (!fdt_chk_version() || fdt_version(fdt) >=3D 0x11)
>> +	if (can_assume(LATEST) || fdt_version(fdt) >=3D 0x11)
>>  		if (((uoffset + len) < uoffset)
>>  		    || ((offset + len) > fdt_size_dt_struct(fdt)))
>>  			return NULL;
>> @@ -154,13 +162,13 @@ const void *fdt_offset_ptr(const void *fdt, int of=
fset, unsigned int len)
>>  uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset=
)
>>  {
>>  	const fdt32_t *tagp, *lenp;
>> -	uint32_t tag;
>> +	uint32_t tag, len, sum;
>>  	int offset =3D startoffset;
>>  	const char *p;
>> =20
>>  	*nextoffset =3D -FDT_ERR_TRUNCATED;
>>  	tagp =3D fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
>> -	if (fdt_chk_basic() && !tagp)
>> +	if (!can_assume(VALID_DTB) && !tagp)
>>  		return FDT_END; /* premature end */
>>  	tag =3D fdt32_to_cpu(*tagp);
>>  	offset +=3D FDT_TAGSIZE;
>> @@ -172,20 +180,27 @@ uint32_t fdt_next_tag(const void *fdt, int startof=
fset, int *nextoffset)
>>  		do {
>>  			p =3D fdt_offset_ptr(fdt, offset++, 1);
>>  		} while (p && (*p !=3D '\0'));
>> -		if (fdt_chk_basic() && !p)
>> +		if (!can_assume(VALID_DTB) && !p)
>>  			return FDT_END; /* premature end */
>>  		break;
>> =20
>>  	case FDT_PROP:
>>  		lenp =3D fdt_offset_ptr(fdt, offset, sizeof(*lenp));
>> -		if (fdt_chk_basic() && !lenp)
>> +		if (!can_assume(VALID_DTB) && !lenp)
>>  			return FDT_END; /* premature end */
>> +
>> +		len =3D fdt32_to_cpu(*lenp);
>> +		sum =3D len + offset;
>> +		if (!can_assume(VALID_DTB) &&
>> +		    (INT_MAX <=3D sum || sum < (uint32_t) offset))
>> +			return FDT_END; /* premature end */
>> +
>>  		/* skip-name offset, length and value */
>> -		offset +=3D sizeof(struct fdt_property) - FDT_TAGSIZE
>> -			+ fdt32_to_cpu(*lenp);
>> -		if (fdt_chk_version() &&
>> -		    fdt_version(fdt) < 0x10 && fdt32_to_cpu(*lenp) >=3D 8 &&
>> -		    ((offset - fdt32_to_cpu(*lenp)) % 8) !=3D 0)
>> +		offset +=3D sizeof(struct fdt_property) - FDT_TAGSIZE + len;
>> +
>> +		if (!can_assume(LATEST) &&
>> +		    fdt_version(fdt) < 0x10 && len >=3D 8 &&
>> +		    ((offset - len) % 8) !=3D 0)
>>  			offset +=3D 4;
>>  		break;
>> =20
>> @@ -198,8 +213,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffs=
et, int *nextoffset)
>>  		return FDT_END;
>>  	}
>> =20
>> -	if (fdt_chk_basic() &&
>> -	    !fdt_offset_ptr(fdt, startoffset, offset - startoffset))
>> +	if (!fdt_offset_ptr(fdt, startoffset, offset - startoffset))
>>  		return FDT_END; /* premature end */
>> =20
>>  	*nextoffset =3D FDT_TAGALIGN(offset);
>> @@ -208,8 +222,11 @@ uint32_t fdt_next_tag(const void *fdt, int startoff=
set, int *nextoffset)
>> =20
>>  int fdt_check_node_offset_(const void *fdt, int offset)
>>  {
>> -	if ((offset < 0) || (offset % FDT_TAGSIZE)
>> -	    || (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE))
>> +	if (!can_assume(VALID_INPUT)
>> +	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
>> +		return -FDT_ERR_BADOFFSET;
>> +
>> +	if (fdt_next_tag(fdt, offset, &offset) !=3D FDT_BEGIN_NODE)
>>  		return -FDT_ERR_BADOFFSET;
>> =20
>>  	return offset;
>> @@ -217,8 +234,11 @@ int fdt_check_node_offset_(const void *fdt, int off=
set)
>> =20
>>  int fdt_check_prop_offset_(const void *fdt, int offset)
>>  {
>> -	if ((offset < 0) || (offset % FDT_TAGSIZE)
>> -	    || (fdt_next_tag(fdt, offset, &offset) !=3D FDT_PROP))
>> +	if (!can_assume(VALID_INPUT)
>> +	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
>> +		return -FDT_ERR_BADOFFSET;
>> +
>> +	if (fdt_next_tag(fdt, offset, &offset) !=3D FDT_PROP)
>>  		return -FDT_ERR_BADOFFSET;
>> =20
>>  	return offset;
>> @@ -292,21 +312,21 @@ int fdt_next_subnode(const void *fdt, int offset)
>>  	return offset;
>>  }
>> =20
>> -const char *fdt_find_string_(const char *strtab, int tabsize, const cha=
r *s)
>> +const char *fdt_find_string_len_(const char *strtab, int tabsize, const=
 char *s,
>> +				 int slen)
>>  {
>> -	int len =3D strlen(s) + 1;
>> -	const char *last =3D strtab + tabsize - len;
>> +	const char *last =3D strtab + tabsize - (slen + 1);
>>  	const char *p;
>> =20
>>  	for (p =3D strtab; p <=3D last; p++)
>> -		if (memcmp(p, s, len) =3D=3D 0)
>> +		if (memcmp(p, s, slen) =3D=3D 0 && p[slen] =3D=3D '\0')
>>  			return p;
>>  	return NULL;
>>  }
>> =20
>>  int fdt_move(const void *fdt, void *buf, int bufsize)
>>  {
>> -	if (fdt_chk_basic() && bufsize < 0)
>> +	if (!can_assume(VALID_INPUT) && bufsize < 0)
>>  		return -FDT_ERR_NOSPACE;
>> =20
>>  	FDT_RO_PROBE(fdt);
>> diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
>> index f2e68807f27..c6e4d7838dc 100644
>> --- a/scripts/dtc/libfdt/fdt.h
>> +++ b/scripts/dtc/libfdt/fdt.h
>> @@ -7,7 +7,7 @@
>>   * Copyright 2012 Kim Phillips, Freescale Semiconductor.
>>   */
>> =20
>> -#ifndef __ASSEMBLY__
>> +#ifndef __ASSEMBLER__
>> =20
>>  struct fdt_header {
>>  	fdt32_t magic;			 /* magic word FDT_MAGIC */
>> @@ -45,7 +45,7 @@ struct fdt_property {
>>  	char data[0];
>>  };
>> =20
>> -#endif /* !__ASSEMBLY */
>> +#endif /* !__ASSEMBLER__ */
>> =20
>>  #define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
>>  #define FDT_TAGSIZE	sizeof(fdt32_t)
>> diff --git a/scripts/dtc/libfdt/fdt_addresses.c b/scripts/dtc/libfdt/fdt=
_addresses.c
>> index 9a82cd0ba2f..c40ba094f1f 100644
>> --- a/scripts/dtc/libfdt/fdt_addresses.c
>> +++ b/scripts/dtc/libfdt/fdt_addresses.c
>> @@ -73,7 +73,7 @@ int fdt_appendprop_addrrange(void *fdt, int parent, in=
t nodeoffset,
>>  	/* check validity of address */
>>  	prop =3D data;
>>  	if (addr_cells =3D=3D 1) {
>> -		if ((addr > UINT32_MAX) || ((UINT32_MAX + 1 - addr) < size))
>> +		if ((addr > UINT32_MAX) || (((uint64_t) UINT32_MAX + 1 - addr) < size=
))
>>  			return -FDT_ERR_BADVALUE;
>> =20
>>  		fdt32_st(prop, (uint32_t)addr);
>> diff --git a/scripts/dtc/libfdt/fdt_overlay.c b/scripts/dtc/libfdt/fdt_o=
verlay.c
>> index 7a65c35af6f..ee64f0b8110 100644
>> --- a/scripts/dtc/libfdt/fdt_overlay.c
>> +++ b/scripts/dtc/libfdt/fdt_overlay.c
>> @@ -40,37 +40,22 @@ static uint32_t overlay_get_target_phandle(const voi=
d *fdto, int fragment)
>>  	return fdt32_to_cpu(*val);
>>  }
>> =20
>> -/**
>> - * overlay_get_target - retrieves the offset of a fragment's target
>> - * @fdt: Base device tree blob
>> - * @fdto: Device tree overlay blob
>> - * @fragment: node offset of the fragment in the overlay
>> - * @pathp: pointer which receives the path of the target (or NULL)
>> - *
>> - * overlay_get_target() retrieves the target offset in the base
>> - * device tree of a fragment, no matter how the actual targeting is
>> - * done (through a phandle or a path)
>> - *
>> - * returns:
>> - *      the targeted node offset in the base device tree
>> - *      Negative error code on error
>> - */
>> -static int overlay_get_target(const void *fdt, const void *fdto,
>> -			      int fragment, char const **pathp)
>> +int fdt_overlay_target_offset(const void *fdt, const void *fdto,
>> +			      int fragment_offset, char const **pathp)
>>  {
>>  	uint32_t phandle;
>>  	const char *path =3D NULL;
>>  	int path_len =3D 0, ret;
>> =20
>>  	/* Try first to do a phandle based lookup */
>> -	phandle =3D overlay_get_target_phandle(fdto, fragment);
>> +	phandle =3D overlay_get_target_phandle(fdto, fragment_offset);
>>  	if (phandle =3D=3D (uint32_t)-1)
>>  		return -FDT_ERR_BADPHANDLE;
>> =20
>>  	/* no phandle, try path */
>>  	if (!phandle) {
>>  		/* And then a path based lookup */
>> -		path =3D fdt_getprop(fdto, fragment, "target-path", &path_len);
>> +		path =3D fdt_getprop(fdto, fragment_offset, "target-path", &path_len)=
;
>>  		if (path)
>>  			ret =3D fdt_path_offset(fdt, path);
>>  		else
>> @@ -116,26 +101,22 @@ static int overlay_get_target(const void *fdt, con=
st void *fdto,
>>  static int overlay_phandle_add_offset(void *fdt, int node,
>>  				      const char *name, uint32_t delta)
>>  {
>> -	const fdt32_t *val;
>> -	uint32_t adj_val;
>> +	fdt32_t *valp, val;
>>  	int len;
>> =20
>> -	val =3D fdt_getprop(fdt, node, name, &len);
>> -	if (!val)
>> +	valp =3D fdt_getprop_w(fdt, node, name, &len);
>> +	if (!valp)
>>  		return len;
>> =20
>> -	if (len !=3D sizeof(*val))
>> +	if (len !=3D sizeof(val))
>>  		return -FDT_ERR_BADPHANDLE;
>> =20
>> -	adj_val =3D fdt32_to_cpu(*val);
>> -	if ((adj_val + delta) < adj_val)
>> +	val =3D fdt32_ld(valp);
>> +	if (val + delta < val || val + delta =3D=3D (uint32_t)-1)
>>  		return -FDT_ERR_NOPHANDLES;
>> =20
>> -	adj_val +=3D delta;
>> -	if (adj_val =3D=3D (uint32_t)-1)
>> -		return -FDT_ERR_NOPHANDLES;
>> -
>> -	return fdt_setprop_inplace_u32(fdt, node, name, adj_val);
>> +	fdt32_st(valp, val + delta);
>> +	return 0;
>>  }
>> =20
>>  /**
>> @@ -228,8 +209,8 @@ static int overlay_update_local_node_references(void=
 *fdto,
>> =20
>>  	fdt_for_each_property_offset(fixup_prop, fdto, fixup_node) {
>>  		const fdt32_t *fixup_val;
>> -		const char *tree_val;
>>  		const char *name;
>> +		char *tree_val;
>>  		int fixup_len;
>>  		int tree_len;
>>  		int i;
>> @@ -243,7 +224,7 @@ static int overlay_update_local_node_references(void=
 *fdto,
>>  			return -FDT_ERR_BADOVERLAY;
>>  		fixup_len /=3D sizeof(uint32_t);
>> =20
>> -		tree_val =3D fdt_getprop(fdto, tree_node, name, &tree_len);
>> +		tree_val =3D fdt_getprop_w(fdto, tree_node, name, &tree_len);
>>  		if (!tree_val) {
>>  			if (tree_len =3D=3D -FDT_ERR_NOTFOUND)
>>  				return -FDT_ERR_BADOVERLAY;
>> @@ -252,33 +233,15 @@ static int overlay_update_local_node_references(vo=
id *fdto,
>>  		}
>> =20
>>  		for (i =3D 0; i < fixup_len; i++) {
>> -			fdt32_t adj_val;
>> -			uint32_t poffset;
>> +			fdt32_t *refp;
>> =20
>> -			poffset =3D fdt32_to_cpu(fixup_val[i]);
>> +			refp =3D (fdt32_t *)(tree_val + fdt32_ld_(fixup_val + i));
>> =20
>>  			/*
>> -			 * phandles to fixup can be unaligned.
>> -			 *
>> -			 * Use a memcpy for the architectures that do
>> -			 * not support unaligned accesses.
>> +			 * phandles to fixup can be unaligned, so use
>> +			 * fdt32_{ld,st}() to read/write them.
>>  			 */
>> -			memcpy(&adj_val, tree_val + poffset, sizeof(adj_val));
>> -
>> -			adj_val =3D cpu_to_fdt32(fdt32_to_cpu(adj_val) + delta);
>> -
>> -			ret =3D fdt_setprop_inplace_namelen_partial(fdto,
>> -								  tree_node,
>> -								  name,
>> -								  strlen(name),
>> -								  poffset,
>> -								  &adj_val,
>> -								  sizeof(adj_val));
>> -			if (ret =3D=3D -FDT_ERR_NOSPACE)
>> -				return -FDT_ERR_BADOVERLAY;
>> -
>> -			if (ret)
>> -				return ret;
>> +			fdt32_st(refp, fdt32_ld(refp) + delta);
>>  		}
>>  	}
>> =20
>> @@ -344,7 +307,6 @@ static int overlay_update_local_references(void *fdt=
o, uint32_t delta)
>> =20
>>  /**
>>   * overlay_fixup_one_phandle - Set an overlay phandle to the base one
>> - * @fdt: Base Device Tree blob
>>   * @fdto: Device tree overlay blob
>>   * @symbols_off: Node offset of the symbols node in the base device tre=
e
>>   * @path: Path to a node holding a phandle in the overlay
>> @@ -352,7 +314,7 @@ static int overlay_update_local_references(void *fdt=
o, uint32_t delta)
>>   * @name: Name of the property holding the phandle reference in the ove=
rlay
>>   * @name_len: number of name characters to consider
>>   * @poffset: Offset within the overlay property where the phandle is st=
ored
>> - * @label: Label of the node referenced by the phandle
>> + * @phandle: Phandle referencing the node
>>   *
>>   * overlay_fixup_one_phandle() resolves an overlay phandle pointing to
>>   * a node in the base device tree.
>> @@ -365,34 +327,17 @@ static int overlay_update_local_references(void *f=
dto, uint32_t delta)
>>   *      0 on success
>>   *      Negative error code on failure
>>   */
>> -static int overlay_fixup_one_phandle(void *fdt, void *fdto,
>> -				     int symbols_off,
>> +static int overlay_fixup_one_phandle(void *fdto, int symbols_off,
>>  				     const char *path, uint32_t path_len,
>>  				     const char *name, uint32_t name_len,
>> -				     int poffset, const char *label)
>> +				     int poffset, uint32_t phandle)
>>  {
>> -	const char *symbol_path;
>> -	uint32_t phandle;
>>  	fdt32_t phandle_prop;
>> -	int symbol_off, fixup_off;
>> -	int prop_len;
>> +	int fixup_off;
>> =20
>>  	if (symbols_off < 0)
>>  		return symbols_off;
>> =20
>> -	symbol_path =3D fdt_getprop(fdt, symbols_off, label,
>> -				  &prop_len);
>> -	if (!symbol_path)
>> -		return prop_len;
>> -
>> -	symbol_off =3D fdt_path_offset(fdt, symbol_path);
>> -	if (symbol_off < 0)
>> -		return symbol_off;
>> -
>> -	phandle =3D fdt_get_phandle(fdt, symbol_off);
>> -	if (!phandle)
>> -		return -FDT_ERR_NOTFOUND;
>> -
>>  	fixup_off =3D fdt_path_offset_namelen(fdto, path, path_len);
>>  	if (fixup_off =3D=3D -FDT_ERR_NOTFOUND)
>>  		return -FDT_ERR_BADOVERLAY;
>> @@ -404,7 +349,7 @@ static int overlay_fixup_one_phandle(void *fdt, void=
 *fdto,
>>  						   name, name_len, poffset,
>>  						   &phandle_prop,
>>  						   sizeof(phandle_prop));
>> -};
>> +}
>> =20
>>  /**
>>   * overlay_fixup_phandle - Set an overlay phandle to the base one
>> @@ -431,6 +376,10 @@ static int overlay_fixup_phandle(void *fdt, void *f=
dto, int symbols_off,
>>  	const char *value;
>>  	const char *label;
>>  	int len;
>> +	const char *symbol_path;
>> +	int prop_len;
>> +	int symbol_off;
>> +	uint32_t phandle;
>> =20
>>  	value =3D fdt_getprop_by_offset(fdto, property,
>>  				      &label, &len);
>> @@ -441,6 +390,18 @@ static int overlay_fixup_phandle(void *fdt, void *f=
dto, int symbols_off,
>>  		return len;
>>  	}
>> =20
>> +	symbol_path =3D fdt_getprop(fdt, symbols_off, label, &prop_len);
>> +	if (!symbol_path)
>> +		return prop_len;
>> +
>> +	symbol_off =3D fdt_path_offset(fdt, symbol_path);
>> +	if (symbol_off < 0)
>> +		return symbol_off;
>> +
>> +	phandle =3D fdt_get_phandle(fdt, symbol_off);
>> +	if (!phandle)
>> +		return -FDT_ERR_NOTFOUND;
>> +
>>  	do {
>>  		const char *path, *name, *fixup_end;
>>  		const char *fixup_str =3D value;
>> @@ -480,9 +441,9 @@ static int overlay_fixup_phandle(void *fdt, void *fd=
to, int symbols_off,
>>  		if ((*endptr !=3D '\0') || (endptr <=3D (sep + 1)))
>>  			return -FDT_ERR_BADOVERLAY;
>> =20
>> -		ret =3D overlay_fixup_one_phandle(fdt, fdto, symbols_off,
>> +		ret =3D overlay_fixup_one_phandle(fdto, symbols_off,
>>  						path, path_len, name, name_len,
>> -						poffset, label);
>> +						poffset, phandle);
>>  		if (ret)
>>  			return ret;
>>  	} while (len > 0);
>> @@ -535,6 +496,255 @@ static int overlay_fixup_phandles(void *fdt, void =
*fdto)
>>  	return 0;
>>  }
>> =20
>> +/**
>> + * overlay_adjust_local_conflicting_phandle: Changes a phandle value
>> + * @fdto: Device tree overlay
>> + * @node: The node the phandle is set for
>> + * @fdt_phandle: The new value for the phandle
>> + *
>> + * returns:
>> + *      0 on success
>> + *      Negative error code on failure
>> + */
>> +static int overlay_adjust_local_conflicting_phandle(void *fdto, int nod=
e,
>> +						    uint32_t fdt_phandle)
>> +{
>> +	const fdt32_t *php;
>> +	int len, ret;
>> +
>> +	php =3D fdt_getprop(fdto, node, "phandle", &len);
>> +	if (php && len =3D=3D sizeof(*php)) {
>> +		ret =3D fdt_setprop_inplace_u32(fdto, node, "phandle", fdt_phandle);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	php =3D fdt_getprop(fdto, node, "linux,phandle", &len);
>> +	if (php && len =3D=3D sizeof(*php)) {
>> +		ret =3D fdt_setprop_inplace_u32(fdto, node, "linux,phandle", fdt_phan=
dle);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * overlay_update_node_conflicting_references - Recursively replace pha=
ndle values
>> + * @fdto: Device tree overlay blob
>> + * @tree_node: Node to recurse into
>> + * @fixup_node: Node offset of the matching local fixups node
>> + * @fdt_phandle: Value to replace phandles with
>> + * @fdto_phandle: Value to be replaced
>> + *
>> + * Replaces all phandles with value @fdto_phandle by @fdt_phandle.
>> + *
>> + * returns:
>> + *      0 on success
>> + *      Negative error code on failure
>> + */
>> +static int overlay_update_node_conflicting_references(void *fdto, int t=
ree_node,
>> +						      int fixup_node,
>> +						      uint32_t fdt_phandle,
>> +						      uint32_t fdto_phandle)
>> +{
>> +	int fixup_prop;
>> +	int fixup_child;
>> +	int ret;
>> +
>> +	fdt_for_each_property_offset(fixup_prop, fdto, fixup_node) {
>> +		const fdt32_t *fixup_val;
>> +		const char *name;
>> +		char *tree_val;
>> +		int fixup_len;
>> +		int tree_len;
>> +		int i;
>> +
>> +		fixup_val =3D fdt_getprop_by_offset(fdto, fixup_prop,
>> +						  &name, &fixup_len);
>> +		if (!fixup_val)
>> +			return fixup_len;
>> +
>> +		if (fixup_len % sizeof(uint32_t))
>> +			return -FDT_ERR_BADOVERLAY;
>> +		fixup_len /=3D sizeof(uint32_t);
>> +
>> +		tree_val =3D fdt_getprop_w(fdto, tree_node, name, &tree_len);
>> +		if (!tree_val) {
>> +			if (tree_len =3D=3D -FDT_ERR_NOTFOUND)
>> +				return -FDT_ERR_BADOVERLAY;
>> +
>> +			return tree_len;
>> +		}
>> +
>> +		for (i =3D 0; i < fixup_len; i++) {
>> +			fdt32_t *refp;
>> +			uint32_t valp;
>> +
>> +			refp =3D (fdt32_t *)(tree_val + fdt32_ld_(fixup_val + i));
>> +			valp =3D fdt32_ld(refp);
>> +
>> +			if (valp =3D=3D fdto_phandle)
>> +				fdt32_st(refp, fdt_phandle);
>> +		}
>> +	}
>> +
>> +	fdt_for_each_subnode(fixup_child, fdto, fixup_node) {
>> +		const char *fixup_child_name =3D fdt_get_name(fdto, fixup_child, NULL=
);
>> +		int tree_child;
>> +
>> +		tree_child =3D fdt_subnode_offset(fdto, tree_node, fixup_child_name);
>> +
>> +		if (tree_child =3D=3D -FDT_ERR_NOTFOUND)
>> +			return -FDT_ERR_BADOVERLAY;
>> +		if (tree_child < 0)
>> +			return tree_child;
>> +
>> +		ret =3D overlay_update_node_conflicting_references(fdto, tree_child,
>> +								 fixup_child,
>> +								 fdt_phandle,
>> +								 fdto_phandle);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * overlay_update_local_conflicting_references - Recursively replace ph=
andle values
>> + * @fdto: Device tree overlay blob
>> + * @fdt_phandle: Value to replace phandles with
>> + * @fdto_phandle: Value to be replaced
>> + *
>> + * Replaces all phandles with value @fdto_phandle by @fdt_phandle.
>> + *
>> + * returns:
>> + *      0 on success
>> + *      Negative error code on failure
>> + */
>> +static int overlay_update_local_conflicting_references(void *fdto,
>> +						       uint32_t fdt_phandle,
>> +						       uint32_t fdto_phandle)
>> +{
>> +	int fixups;
>> +
>> +	fixups =3D fdt_path_offset(fdto, "/__local_fixups__");
>> +	if (fixups =3D=3D -FDT_ERR_NOTFOUND)
>> +		return 0;
>> +	if (fixups < 0)
>> +		return fixups;
>> +
>> +	return overlay_update_node_conflicting_references(fdto, 0, fixups,
>> +							  fdt_phandle,
>> +							  fdto_phandle);
>> +}
>> +
>> +/**
>> + * overlay_prevent_phandle_overwrite_node - Helper function for overlay=
_prevent_phandle_overwrite
>> + * @fdt: Base Device tree blob
>> + * @fdtnode: Node in fdt that is checked for an overwrite
>> + * @fdto: Device tree overlay blob
>> + * @fdtonode: Node in fdto matching @fdtnode
>> + *
>> + * returns:
>> + *      0 on success
>> + *      Negative error code on failure
>> + */
>> +static int overlay_prevent_phandle_overwrite_node(void *fdt, int fdtnod=
e,
>> +						  void *fdto, int fdtonode)
>> +{
>> +	uint32_t fdt_phandle, fdto_phandle;
>> +	int fdtochild;
>> +
>> +	fdt_phandle =3D fdt_get_phandle(fdt, fdtnode);
>> +	fdto_phandle =3D fdt_get_phandle(fdto, fdtonode);
>> +
>> +	if (fdt_phandle && fdto_phandle) {
>> +		int ret;
>> +
>> +		ret =3D overlay_adjust_local_conflicting_phandle(fdto, fdtonode,
>> +							       fdt_phandle);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D overlay_update_local_conflicting_references(fdto,
>> +								  fdt_phandle,
>> +								  fdto_phandle);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	fdt_for_each_subnode(fdtochild, fdto, fdtonode) {
>> +		const char *name =3D fdt_get_name(fdto, fdtochild, NULL);
>> +		int fdtchild;
>> +		int ret;
>> +
>> +		fdtchild =3D fdt_subnode_offset(fdt, fdtnode, name);
>> +		if (fdtchild =3D=3D -FDT_ERR_NOTFOUND)
>> +			/*
>> +			 * no further overwrites possible here as this node is
>> +			 * new
>> +			 */
>> +			continue;
>> +
>> +		ret =3D overlay_prevent_phandle_overwrite_node(fdt, fdtchild,
>> +							     fdto, fdtochild);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * overlay_prevent_phandle_overwrite - Fixes overlay phandles to not ov=
erwrite base phandles
>> + * @fdt: Base Device Tree blob
>> + * @fdto: Device tree overlay blob
>> + *
>> + * Checks recursively if applying fdto overwrites phandle values in the=
 base
>> + * dtb. When such a phandle is found, the fdto is changed to use the fd=
t's
>> + * phandle value to not break references in the base.
>> + *
>> + * returns:
>> + *      0 on success
>> + *      Negative error code on failure
>> + */
>> +static int overlay_prevent_phandle_overwrite(void *fdt, void *fdto)
>> +{
>> +	int fragment;
>> +
>> +	fdt_for_each_subnode(fragment, fdto, 0) {
>> +		int overlay;
>> +		int target;
>> +		int ret;
>> +
>> +		overlay =3D fdt_subnode_offset(fdto, fragment, "__overlay__");
>> +		if (overlay =3D=3D -FDT_ERR_NOTFOUND)
>> +			continue;
>> +
>> +		if (overlay < 0)
>> +			return overlay;
>> +
>> +		target =3D fdt_overlay_target_offset(fdt, fdto, fragment, NULL);
>> +		if (target =3D=3D -FDT_ERR_NOTFOUND)
>> +			/*
>> +			 * The subtree doesn't exist in the base, so nothing
>> +			 * will be overwritten.
>> +			 */
>> +			continue;
>> +		else if (target < 0)
>> +			return target;
>> +
>> +		ret =3D overlay_prevent_phandle_overwrite_node(fdt, target,
>> +							     fdto, overlay);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * overlay_apply_node - Merges a node into the base device tree
>>   * @fdt: Base Device Tree blob
>> @@ -636,7 +846,7 @@ static int overlay_merge(void *fdt, void *fdto)
>>  		if (overlay < 0)
>>  			return overlay;
>> =20
>> -		target =3D overlay_get_target(fdt, fdto, fragment, NULL);
>> +		target =3D fdt_overlay_target_offset(fdt, fdto, fragment, NULL);
>>  		if (target < 0)
>>  			return target;
>> =20
>> @@ -779,7 +989,7 @@ static int overlay_symbol_update(void *fdt, void *fd=
to)
>>  			return -FDT_ERR_BADOVERLAY;
>> =20
>>  		/* get the target of the fragment */
>> -		ret =3D overlay_get_target(fdt, fdto, fragment, &target_path);
>> +		ret =3D fdt_overlay_target_offset(fdt, fdto, fragment, &target_path);
>>  		if (ret < 0)
>>  			return ret;
>>  		target =3D ret;
>> @@ -801,7 +1011,7 @@ static int overlay_symbol_update(void *fdt, void *f=
dto)
>> =20
>>  		if (!target_path) {
>>  			/* again in case setprop_placeholder changed it */
>> -			ret =3D overlay_get_target(fdt, fdto, fragment, &target_path);
>> +			ret =3D fdt_overlay_target_offset(fdt, fdto, fragment, &target_path)=
;
>>  			if (ret < 0)
>>  				return ret;
>>  			target =3D ret;
>> @@ -838,18 +1048,26 @@ int fdt_overlay_apply(void *fdt, void *fdto)
>>  	if (ret)
>>  		goto err;
>> =20
>> +	/* Increase all phandles in the fdto by delta */
>>  	ret =3D overlay_adjust_local_phandles(fdto, delta);
>>  	if (ret)
>>  		goto err;
>> =20
>> +	/* Adapt the phandle values in fdto to the above increase */
>>  	ret =3D overlay_update_local_references(fdto, delta);
>>  	if (ret)
>>  		goto err;
>> =20
>> +	/* Update fdto's phandles using symbols from fdt */
>>  	ret =3D overlay_fixup_phandles(fdt, fdto);
>>  	if (ret)
>>  		goto err;
>> =20
>> +	/* Don't overwrite phandles in fdt */
>> +	ret =3D overlay_prevent_phandle_overwrite(fdt, fdto);
>> +	if (ret)
>> +		goto err;
>> +
>>  	ret =3D overlay_merge(fdt, fdto);
>>  	if (ret)
>>  		goto err;
>> diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
>> index d65656aaa8b..3e7e26b4398 100644
>> --- a/scripts/dtc/libfdt/fdt_ro.c
>> +++ b/scripts/dtc/libfdt/fdt_ro.c
>> @@ -16,7 +16,7 @@ static int fdt_nodename_eq_(const void *fdt, int offse=
t,
>>  	int olen;
>>  	const char *p =3D fdt_get_name(fdt, offset, &olen);
>> =20
>> -	if (!p || (fdt_chk_extra() && olen < len))
>> +	if (!p || olen < len)
>>  		/* short match */
>>  		return 0;
>> =20
>> @@ -39,7 +39,7 @@ const char *fdt_get_string(const void *fdt, int stroff=
set, int *lenp)
>>  	int err;
>>  	const char *s, *n;
>> =20
>> -	if (!fdt_chk_extra()) {
>> +	if (can_assume(VALID_INPUT)) {
>>  		s =3D (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
>> =20
>>  		if (lenp)
>> @@ -60,7 +60,7 @@ const char *fdt_get_string(const void *fdt, int stroff=
set, int *lenp)
>>  	if (fdt_magic(fdt) =3D=3D FDT_MAGIC) {
>>  		if (stroffset < 0)
>>  			goto fail;
>> -		if (!fdt_chk_version() || fdt_version(fdt) >=3D 17) {
>> +		if (can_assume(LATEST) || fdt_version(fdt) >=3D 17) {
>>  			if ((unsigned)stroffset >=3D fdt_size_dt_strings(fdt))
>>  				goto fail;
>>  			if ((fdt_size_dt_strings(fdt) - stroffset) < len)
>> @@ -72,7 +72,7 @@ const char *fdt_get_string(const void *fdt, int stroff=
set, int *lenp)
>>  		if ((stroffset >=3D 0) ||
>>  		    (sw_stroffset > fdt_size_dt_strings(fdt)))
>>  			goto fail;
>> -		if ((sw_stroffset) < len)
>> +		if (sw_stroffset < len)
>>  			len =3D sw_stroffset;
>>  	} else {
>>  		err =3D -FDT_ERR_INTERNAL;
>> @@ -162,7 +162,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(c=
onst void *fdt, int n)
>>  	unsigned int offset =3D n * sizeof(struct fdt_reserve_entry);
>>  	unsigned int absoffset =3D fdt_off_mem_rsvmap(fdt) + offset;
>> =20
>> -	if (fdt_chk_extra()) {
>> +	if (!can_assume(VALID_INPUT)) {
>>  		if (absoffset < fdt_off_mem_rsvmap(fdt))
>>  			return NULL;
>>  		if (absoffset > fdt_totalsize(fdt) -
>> @@ -178,11 +178,11 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64=
_t *address, uint64_t *size)
>> =20
>>  	FDT_RO_PROBE(fdt);
>>  	re =3D fdt_mem_rsv(fdt, n);
>> -	if (fdt_chk_extra() && !re)
>> +	if (!can_assume(VALID_INPUT) && !re)
>>  		return -FDT_ERR_BADOFFSET;
>> =20
>> -	*address =3D fdt64_to_cpu(re->address);
>> -	*size =3D fdt64_to_cpu(re->size);
>> +	*address =3D fdt64_ld_(&re->address);
>> +	*size =3D fdt64_ld_(&re->size);
>>  	return 0;
>>  }
>> =20
>> @@ -192,7 +192,7 @@ int fdt_num_mem_rsv(const void *fdt)
>>  	const struct fdt_reserve_entry *re;
>> =20
>>  	for (i =3D 0; (re =3D fdt_mem_rsv(fdt, i)) !=3D NULL; i++) {
>> -		if (fdt64_to_cpu(re->size) =3D=3D 0)
>> +		if (fdt64_ld_(&re->size) =3D=3D 0)
>>  			return i;
>>  	}
>>  	return -FDT_ERR_TRUNCATED;
>> @@ -255,6 +255,9 @@ int fdt_path_offset_namelen(const void *fdt, const c=
har *path, int namelen)
>> =20
>>  	FDT_RO_PROBE(fdt);
>> =20
>> +	if (!can_assume(VALID_INPUT) && namelen <=3D 0)
>> +		return -FDT_ERR_BADPATH;
>> +
>>  	/* see if we have an alias */
>>  	if (*path !=3D '/') {
>>  		const char *q =3D memchr(path, '/', end - p);
>> @@ -303,14 +306,13 @@ const char *fdt_get_name(const void *fdt, int node=
offset, int *len)
>>  	const char *nameptr;
>>  	int err;
>> =20
>> -	if (fdt_chk_extra() &&
>> -	    (((err =3D fdt_ro_probe_(fdt)) < 0)
>> -	     || ((err =3D fdt_check_node_offset_(fdt, nodeoffset)) < 0)))
>> -		goto fail;
>> +	if (((err =3D fdt_ro_probe_(fdt)) < 0)
>> +	    || ((err =3D fdt_check_node_offset_(fdt, nodeoffset)) < 0))
>> +			goto fail;
>> =20
>>  	nameptr =3D nh->name;
>> =20
>> -	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
>>  		/*
>>  		 * For old FDT versions, match the naming conventions of V16:
>>  		 * give only the leaf name (after all /). The actual tree
>> @@ -361,7 +363,8 @@ static const struct fdt_property *fdt_get_property_b=
y_offset_(const void *fdt,
>>  	int err;
>>  	const struct fdt_property *prop;
>> =20
>> -	if (fdt_chk_basic() && (err =3D fdt_check_prop_offset_(fdt, offset)) <=
 0) {
>> +	if (!can_assume(VALID_INPUT) &&
>> +	    (err =3D fdt_check_prop_offset_(fdt, offset)) < 0) {
>>  		if (lenp)
>>  			*lenp =3D err;
>>  		return NULL;
>> @@ -370,7 +373,7 @@ static const struct fdt_property *fdt_get_property_b=
y_offset_(const void *fdt,
>>  	prop =3D fdt_offset_ptr_(fdt, offset);
>> =20
>>  	if (lenp)
>> -		*lenp =3D fdt32_to_cpu(prop->len);
>> +		*lenp =3D fdt32_ld_(&prop->len);
>> =20
>>  	return prop;
>>  }
>> @@ -382,7 +385,7 @@ const struct fdt_property *fdt_get_property_by_offse=
t(const void *fdt,
>>  	/* Prior to version 16, properties may need realignment
>>  	 * and this API does not work. fdt_getprop_*() will, however. */
>> =20
>> -	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
>>  		if (lenp)
>>  			*lenp =3D -FDT_ERR_BADVERSION;
>>  		return NULL;
>> @@ -404,11 +407,11 @@ static const struct fdt_property *fdt_get_property=
_namelen_(const void *fdt,
>>  		const struct fdt_property *prop;
>> =20
>>  		prop =3D fdt_get_property_by_offset_(fdt, offset, lenp);
>> -		if (fdt_chk_extra() && !prop) {
>> +		if (!can_assume(LIBFDT_FLAWLESS) && !prop) {
>>  			offset =3D -FDT_ERR_INTERNAL;
>>  			break;
>>  		}
>> -		if (fdt_string_eq_(fdt, fdt32_to_cpu(prop->nameoff),
>> +		if (fdt_string_eq_(fdt, fdt32_ld_(&prop->nameoff),
>>  				   name, namelen)) {
>>  			if (poffset)
>>  				*poffset =3D offset;
>> @@ -428,7 +431,7 @@ const struct fdt_property *fdt_get_property_namelen(=
const void *fdt,
>>  {
>>  	/* Prior to version 16, properties may need realignment
>>  	 * and this API does not work. fdt_getprop_*() will, however. */
>> -	if (fdt_chk_version() && fdt_version(fdt) < 0x10) {
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
>>  		if (lenp)
>>  			*lenp =3D -FDT_ERR_BADVERSION;
>>  		return NULL;
>> @@ -458,8 +461,8 @@ const void *fdt_getprop_namelen(const void *fdt, int=
 nodeoffset,
>>  		return NULL;
>> =20
>>  	/* Handle realignment */
>> -	if (fdt_chk_version() && fdt_version(fdt) < 0x10 &&
>> -	    (poffset + sizeof(*prop)) % 8 && fdt32_to_cpu(prop->len) >=3D 8)
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
>> +	    (poffset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >=3D 8)
>>  		return prop->data + 4;
>>  	return prop->data;
>>  }
>> @@ -476,23 +479,23 @@ const void *fdt_getprop_by_offset(const void *fdt,=
 int offset,
>>  		const char *name;
>>  		int namelen;
>> =20
>> -		if (fdt_chk_extra()) {
>> -			name =3D fdt_get_string(fdt, fdt32_to_cpu(prop->nameoff),
>> +		if (!can_assume(VALID_INPUT)) {
>> +			name =3D fdt_get_string(fdt, fdt32_ld_(&prop->nameoff),
>>  					      &namelen);
>> +			*namep =3D name;
>>  			if (!name) {
>>  				if (lenp)
>>  					*lenp =3D namelen;
>>  				return NULL;
>>  			}
>> -			*namep =3D name;
>>  		} else {
>> -			*namep =3D fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>> +			*namep =3D fdt_string(fdt, fdt32_ld_(&prop->nameoff));
>>  		}
>>  	}
>> =20
>>  	/* Handle realignment */
>> -	if (fdt_chk_version() && fdt_version(fdt) < 0x10 &&
>> -	    (offset + sizeof(*prop)) % 8 && fdt32_to_cpu(prop->len) >=3D 8)
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 0x10 &&
>> +	    (offset + sizeof(*prop)) % 8 && fdt32_ld_(&prop->len) >=3D 8)
>>  		return prop->data + 4;
>>  	return prop->data;
>>  }
>> @@ -517,19 +520,34 @@ uint32_t fdt_get_phandle(const void *fdt, int node=
offset)
>>  			return 0;
>>  	}
>> =20
>> -	return fdt32_to_cpu(*php);
>> +	return fdt32_ld_(php);
>> +}
>> +
>> +static const void *fdt_path_getprop_namelen(const void *fdt, const char=
 *path,
>> +					    const char *propname, int propnamelen,
>> +					    int *lenp)
>> +{
>> +	int offset =3D fdt_path_offset(fdt, path);
>> +
>> +	if (offset < 0)
>> +		return NULL;
>> +
>> +	return fdt_getprop_namelen(fdt, offset, propname, propnamelen, lenp);
>>  }
>> =20
>>  const char *fdt_get_alias_namelen(const void *fdt,
>>  				  const char *name, int namelen)
>>  {
>> -	int aliasoffset;
>> +	int len;
>> +	const char *alias;
>> +
>> +	alias =3D fdt_path_getprop_namelen(fdt, "/aliases", name, namelen, &le=
n);
>> =20
>> -	aliasoffset =3D fdt_path_offset(fdt, "/aliases");
>> -	if (aliasoffset < 0)
>> +	if (!can_assume(VALID_DTB) &&
>> +	    !(alias && len > 0 && alias[len - 1] =3D=3D '\0' && *alias =3D=3D =
'/'))
>>  		return NULL;
>> =20
>> -	return fdt_getprop_namelen(fdt, aliasoffset, name, namelen, NULL);
>> +	return alias;
>>  }
>> =20
>>  const char *fdt_get_alias(const void *fdt, const char *name)
>> @@ -537,6 +555,17 @@ const char *fdt_get_alias(const void *fdt, const ch=
ar *name)
>>  	return fdt_get_alias_namelen(fdt, name, strlen(name));
>>  }
>> =20
>> +const char *fdt_get_symbol_namelen(const void *fdt,
>> +				   const char *name, int namelen)
>> +{
>> +	return fdt_path_getprop_namelen(fdt, "/__symbols__", name, namelen, NU=
LL);
>> +}
>> +
>> +const char *fdt_get_symbol(const void *fdt, const char *name)
>> +{
>> +	return fdt_get_symbol_namelen(fdt, name, strlen(name));
>> +}
>> +
>>  int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen=
)
>>  {
>>  	int pdepth =3D 0, p =3D 0;
>> @@ -617,7 +646,7 @@ int fdt_supernode_atdepth_offset(const void *fdt, in=
t nodeoffset,
>>  		}
>>  	}
>> =20
>> -	if (fdt_chk_extra()) {
>> +	if (!can_assume(VALID_INPUT)) {
>>  		if ((offset =3D=3D -FDT_ERR_NOTFOUND) || (offset >=3D 0))
>>  			return -FDT_ERR_BADOFFSET;
>>  		else if (offset =3D=3D -FDT_ERR_BADOFFSET)
>> @@ -634,7 +663,8 @@ int fdt_node_depth(const void *fdt, int nodeoffset)
>> =20
>>  	err =3D fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, &nodedepth);
>>  	if (err)
>> -		return (!fdt_chk_extra() || err < 0) ? err : -FDT_ERR_INTERNAL;
>> +		return (can_assume(LIBFDT_FLAWLESS) || err < 0) ? err :
>> +			-FDT_ERR_INTERNAL;
>>  	return nodedepth;
>>  }
>> =20
>> diff --git a/scripts/dtc/libfdt/fdt_rw.c b/scripts/dtc/libfdt/fdt_rw.c
>> index 2eb2b38703b..7475cafce07 100644
>> --- a/scripts/dtc/libfdt/fdt_rw.c
>> +++ b/scripts/dtc/libfdt/fdt_rw.c
>> @@ -13,8 +13,6 @@
>>  static int fdt_blocks_misordered_(const void *fdt,
>>  				  int mem_rsv_size, int struct_size)
>>  {
>> -	if (!fdt_chk_basic())
>> -		return false;
>>  	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header),=
 8))
>>  		|| (fdt_off_dt_struct(fdt) <
>>  		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
>> @@ -26,16 +24,16 @@ static int fdt_blocks_misordered_(const void *fdt,
>> =20
>>  static int fdt_rw_probe_(void *fdt)
>>  {
>> -	if (!fdt_chk_basic())
>> +	if (can_assume(VALID_DTB))
>>  		return 0;
>>  	FDT_RO_PROBE(fdt);
>> =20
>> -	if (fdt_chk_version() && fdt_version(fdt) < 17)
>> +	if (!can_assume(LATEST) && fdt_version(fdt) < 17)
>>  		return -FDT_ERR_BADVERSION;
>>  	if (fdt_blocks_misordered_(fdt, sizeof(struct fdt_reserve_entry),
>>  				   fdt_size_dt_struct(fdt)))
>>  		return -FDT_ERR_BADLAYOUT;
>> -	if (fdt_chk_version() && fdt_version(fdt) > 17)
>> +	if (!can_assume(LATEST) && fdt_version(fdt) > 17)
>>  		fdt_set_version(fdt, 17);
>> =20
>>  	return 0;
>> @@ -44,11 +42,11 @@ static int fdt_rw_probe_(void *fdt)
>>  #define FDT_RW_PROBE(fdt) \
>>  	{ \
>>  		int err_; \
>> -		if (fdt_chk_extra() && (err_ =3D fdt_rw_probe_(fdt)) !=3D 0) \
>> +		if ((err_ =3D fdt_rw_probe_(fdt)) !=3D 0) \
>>  			return err_; \
>>  	}
>> =20
>> -static inline int fdt_data_size_(void *fdt)
>> +static inline unsigned int fdt_data_size_(void *fdt)
>>  {
>>  	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
>>  }
>> @@ -56,15 +54,16 @@ static inline int fdt_data_size_(void *fdt)
>>  static int fdt_splice_(void *fdt, void *splicepoint, int oldlen, int ne=
wlen)
>>  {
>>  	char *p =3D splicepoint;
>> -	char *end =3D (char *)fdt + fdt_data_size_(fdt);
>> +	unsigned int dsize =3D fdt_data_size_(fdt);
>> +	size_t soff =3D p - (char *)fdt;
>> =20
>> -	if (((p + oldlen) < p) || ((p + oldlen) > end))
>> +	if ((oldlen < 0) || (soff + oldlen < soff) || (soff + oldlen > dsize))
>>  		return -FDT_ERR_BADOFFSET;
>> -	if ((p < (char *)fdt) || ((end - oldlen + newlen) < (char *)fdt))
>> +	if ((p < (char *)fdt) || (dsize + newlen < (unsigned)oldlen))
>>  		return -FDT_ERR_BADOFFSET;
>> -	if ((end - oldlen + newlen) > ((char *)fdt + fdt_totalsize(fdt)))
>> +	if (dsize - oldlen + newlen > fdt_totalsize(fdt))
>>  		return -FDT_ERR_NOSPACE;
>> -	memmove(p + newlen, p + oldlen, end - p - oldlen);
>> +	memmove(p + newlen, p + oldlen, ((char *)fdt + dsize) - (p + oldlen));
>>  	return 0;
>>  }
>> =20
>> @@ -122,34 +121,36 @@ static int fdt_splice_string_(void *fdt, int newle=
n)
>>   * @fdt: pointer to the device tree to check/adjust
>>   * @s: string to find/add
>>   * @allocated: Set to 0 if the string was found, 1 if not found and so
>> - *	allocated. Ignored if !fdt_chk_basic()
>> - * Return: offset of string in the string table (whether found or added=
)
>> + *	allocated. Ignored if can_assume(NO_ROLLBACK)
>> + * @return offset of string in the string table (whether found or added=
)
>>   */
>> -static int fdt_find_add_string_(void *fdt, const char *s, int *allocate=
d)
>> +static int fdt_find_add_string_(void *fdt, const char *s, int slen,
>> +				int *allocated)
>>  {
>>  	char *strtab =3D (char *)fdt + fdt_off_dt_strings(fdt);
>>  	const char *p;
>>  	char *new;
>> -	int len =3D strlen(s) + 1;
>>  	int err;
>> =20
>> -	if (fdt_chk_basic())
>> +	if (!can_assume(NO_ROLLBACK))
>>  		*allocated =3D 0;
>> =20
>> -	p =3D fdt_find_string_(strtab, fdt_size_dt_strings(fdt), s);
>> +	p =3D fdt_find_string_len_(strtab, fdt_size_dt_strings(fdt), s, slen);
>>  	if (p)
>>  		/* found it */
>>  		return (p - strtab);
>> =20
>>  	new =3D strtab + fdt_size_dt_strings(fdt);
>> -	err =3D fdt_splice_string_(fdt, len);
>> +	err =3D fdt_splice_string_(fdt, slen + 1);
>>  	if (err)
>>  		return err;
>> =20
>> -	if (fdt_chk_basic())
>> +	if (!can_assume(NO_ROLLBACK))
>>  		*allocated =3D 1;
>> =20
>> -	memcpy(new, s, len);
>> +	memcpy(new, s, slen);
>> +	new[slen] =3D '\0';
>> +
>>  	return (new - strtab);
>>  }
>> =20
>> @@ -182,13 +183,15 @@ int fdt_del_mem_rsv(void *fdt, int n)
>>  	return fdt_splice_mem_rsv_(fdt, re, 1, 0);
>>  }
>> =20
>> -static int fdt_resize_property_(void *fdt, int nodeoffset, const char *=
name,
>> +static int fdt_resize_property_(void *fdt, int nodeoffset,
>> +				const char *name, int namelen,
>>  				int len, struct fdt_property **prop)
>>  {
>>  	int oldlen;
>>  	int err;
>> =20
>> -	*prop =3D fdt_get_property_w(fdt, nodeoffset, name, &oldlen);
>> +	*prop =3D fdt_get_property_namelen_w(fdt, nodeoffset, name, namelen,
>> +					   &oldlen);
>>  	if (!*prop)
>>  		return oldlen;
>> =20
>> @@ -201,7 +204,7 @@ static int fdt_resize_property_(void *fdt, int nodeo=
ffset, const char *name,
>>  }
>> =20
>>  static int fdt_add_property_(void *fdt, int nodeoffset, const char *nam=
e,
>> -			     int len, struct fdt_property **prop)
>> +			     int namelen, int len, struct fdt_property **prop)
>>  {
>>  	int proplen;
>>  	int nextoffset;
>> @@ -212,7 +215,7 @@ static int fdt_add_property_(void *fdt, int nodeoffs=
et, const char *name,
>>  	if ((nextoffset =3D fdt_check_node_offset_(fdt, nodeoffset)) < 0)
>>  		return nextoffset;
>> =20
>> -	namestroff =3D fdt_find_add_string_(fdt, name, &allocated);
>> +	namestroff =3D fdt_find_add_string_(fdt, name, namelen, &allocated);
>>  	if (namestroff < 0)
>>  		return namestroff;
>> =20
>> @@ -222,7 +225,7 @@ static int fdt_add_property_(void *fdt, int nodeoffs=
et, const char *name,
>>  	err =3D fdt_splice_struct_(fdt, *prop, 0, proplen);
>>  	if (err) {
>>  		/* Delete the string if we failed to add it */
>> -		if (fdt_chk_basic() && allocated)
>> +		if (!can_assume(NO_ROLLBACK) && allocated)
>>  			fdt_del_last_string_(fdt, name);
>>  		return err;
>>  	}
>> @@ -256,17 +259,18 @@ int fdt_set_name(void *fdt, int nodeoffset, const =
char *name)
>>  	return 0;
>>  }
>> =20
>> -int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name=
,
>> -			    int len, void **prop_data)
>> +int fdt_setprop_placeholder_namelen(void *fdt, int nodeoffset, const ch=
ar *name,
>> +				    int namelen, int len, void **prop_data)
>>  {
>>  	struct fdt_property *prop;
>>  	int err;
>> =20
>>  	FDT_RW_PROBE(fdt);
>> =20
>> -	err =3D fdt_resize_property_(fdt, nodeoffset, name, len, &prop);
>> +	err =3D fdt_resize_property_(fdt, nodeoffset, name, namelen, len, &pro=
p);
>>  	if (err =3D=3D -FDT_ERR_NOTFOUND)
>> -		err =3D fdt_add_property_(fdt, nodeoffset, name, len, &prop);
>> +		err =3D fdt_add_property_(fdt, nodeoffset, name, namelen, len,
>> +					&prop);
>>  	if (err)
>>  		return err;
>> =20
>> @@ -274,13 +278,14 @@ int fdt_setprop_placeholder(void *fdt, int nodeoff=
set, const char *name,
>>  	return 0;
>>  }
>> =20
>> -int fdt_setprop(void *fdt, int nodeoffset, const char *name,
>> -		const void *val, int len)
>> +int fdt_setprop_namelen(void *fdt, int nodeoffset, const char *name,
>> +			int namelen, const void *val, int len)
>>  {
>>  	void *prop_data;
>>  	int err;
>> =20
>> -	err =3D fdt_setprop_placeholder(fdt, nodeoffset, name, len, &prop_data=
);
>> +	err =3D fdt_setprop_placeholder_namelen(fdt, nodeoffset, name, namelen=
,
>> +					      len, &prop_data);
>>  	if (err)
>>  		return err;
>> =20
>> @@ -308,7 +313,8 @@ int fdt_appendprop(void *fdt, int nodeoffset, const =
char *name,
>>  		prop->len =3D cpu_to_fdt32(newlen);
>>  		memcpy(prop->data + oldlen, val, len);
>>  	} else {
>> -		err =3D fdt_add_property_(fdt, nodeoffset, name, len, &prop);
>> +		err =3D fdt_add_property_(fdt, nodeoffset, name, strlen(name),
>> +					len, &prop);
>>  		if (err)
>>  			return err;
>>  		memcpy(prop->data, val, len);
>> @@ -350,7 +356,10 @@ int fdt_add_subnode_namelen(void *fdt, int parentof=
fset,
>>  		return offset;
>> =20
>>  	/* Try to place the new node after the parent's properties */
>> -	fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE *=
/
>> +	tag =3D fdt_next_tag(fdt, parentoffset, &nextoffset);
>> +	/* the fdt_subnode_offset_namelen() should ensure this never hits */
>> +	if (!can_assume(LIBFDT_FLAWLESS) && (tag !=3D FDT_BEGIN_NODE))
>> +		return -FDT_ERR_INTERNAL;
>>  	do {
>>  		offset =3D nextoffset;
>>  		tag =3D fdt_next_tag(fdt, offset, &nextoffset);
>> @@ -392,7 +401,9 @@ int fdt_del_node(void *fdt, int nodeoffset)
>>  }
>> =20
>>  static void fdt_packblocks_(const char *old, char *new,
>> -			    int mem_rsv_size, int struct_size)
>> +			    int mem_rsv_size,
>> +			    int struct_size,
>> +			    int strings_size)
>>  {
>>  	int mem_rsv_off, struct_off, strings_off;
>> =20
>> @@ -407,8 +418,7 @@ static void fdt_packblocks_(const char *old, char *n=
ew,
>>  	fdt_set_off_dt_struct(new, struct_off);
>>  	fdt_set_size_dt_struct(new, struct_size);
>> =20
>> -	memmove(new + strings_off, old + fdt_off_dt_strings(old),
>> -		fdt_size_dt_strings(old));
>> +	memmove(new + strings_off, old + fdt_off_dt_strings(old), strings_size=
);
>>  	fdt_set_off_dt_strings(new, strings_off);
>>  	fdt_set_size_dt_strings(new, fdt_size_dt_strings(old));
>>  }
>> @@ -427,17 +437,20 @@ int fdt_open_into(const void *fdt, void *buf, int =
bufsize)
>>  	mem_rsv_size =3D (fdt_num_mem_rsv(fdt)+1)
>>  		* sizeof(struct fdt_reserve_entry);
>> =20
>> -	if (!fdt_chk_version() || fdt_version(fdt) >=3D 17) {
>> +	if (can_assume(LATEST) || fdt_version(fdt) >=3D 17) {
>>  		struct_size =3D fdt_size_dt_struct(fdt);
>> -	} else {
>> +	} else if (fdt_version(fdt) =3D=3D 16) {
>>  		struct_size =3D 0;
>>  		while (fdt_next_tag(fdt, struct_size, &struct_size) !=3D FDT_END)
>>  			;
>>  		if (struct_size < 0)
>>  			return struct_size;
>> +	} else {
>> +		return -FDT_ERR_BADVERSION;
>>  	}
>> =20
>> -	if (!fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
>> +	if (can_assume(LIBFDT_ORDER) ||
>> +	    !fdt_blocks_misordered_(fdt, mem_rsv_size, struct_size)) {
>>  		/* no further work necessary */
>>  		err =3D fdt_move(fdt, buf, bufsize);
>>  		if (err)
>> @@ -465,7 +478,8 @@ int fdt_open_into(const void *fdt, void *buf, int bu=
fsize)
>>  			return -FDT_ERR_NOSPACE;
>>  	}
>> =20
>> -	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size);
>> +	fdt_packblocks_(fdt, tmp, mem_rsv_size, struct_size,
>> +			fdt_size_dt_strings(fdt));
>>  	memmove(buf, tmp, newsize);
>> =20
>>  	fdt_set_magic(buf, FDT_MAGIC);
>> @@ -485,7 +499,8 @@ int fdt_pack(void *fdt)
>> =20
>>  	mem_rsv_size =3D (fdt_num_mem_rsv(fdt)+1)
>>  		* sizeof(struct fdt_reserve_entry);
>> -	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
>> +	fdt_packblocks_(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt),
>> +			fdt_size_dt_strings(fdt));
>>  	fdt_set_totalsize(fdt, fdt_data_size_(fdt));
>> =20
>>  	return 0;
>> diff --git a/scripts/dtc/libfdt/fdt_strerror.c b/scripts/dtc/libfdt/fdt_=
strerror.c
>> index b4356931b06..d852b77e81e 100644
>> --- a/scripts/dtc/libfdt/fdt_strerror.c
>> +++ b/scripts/dtc/libfdt/fdt_strerror.c
>> @@ -39,6 +39,7 @@ static struct fdt_errtabent fdt_errtable[] =3D {
>>  	FDT_ERRTABENT(FDT_ERR_BADOVERLAY),
>>  	FDT_ERRTABENT(FDT_ERR_NOPHANDLES),
>>  	FDT_ERRTABENT(FDT_ERR_BADFLAGS),
>> +	FDT_ERRTABENT(FDT_ERR_ALIGNMENT),
>>  };
>>  #define FDT_ERRTABSIZE	((int)(sizeof(fdt_errtable) / sizeof(fdt_errtabl=
e[0])))
>> =20
>> diff --git a/scripts/dtc/libfdt/fdt_sw.c b/scripts/dtc/libfdt/fdt_sw.c
>> index d9e67fa2a61..4c569ee7eb0 100644
>> --- a/scripts/dtc/libfdt/fdt_sw.c
>> +++ b/scripts/dtc/libfdt/fdt_sw.c
>> @@ -12,7 +12,7 @@
>> =20
>>  static int fdt_sw_probe_(void *fdt)
>>  {
>> -	if (fdt_chk_basic()) {
>> +	if (!can_assume(VALID_INPUT)) {
>>  		if (fdt_magic(fdt) =3D=3D FDT_MAGIC)
>>  			return -FDT_ERR_BADSTATE;
>>  		else if (fdt_magic(fdt) !=3D FDT_SW_MAGIC)
>> @@ -25,14 +25,14 @@ static int fdt_sw_probe_(void *fdt)
>>  #define FDT_SW_PROBE(fdt) \
>>  	{ \
>>  		int err; \
>> -		if (fdt_chk_basic() && (err =3D fdt_sw_probe_(fdt)) !=3D 0) \
>> +		if ((err =3D fdt_sw_probe_(fdt)) !=3D 0) \
>>  			return err; \
>>  	}
>> =20
>>  /* 'memrsv' state:	Initial state after fdt_create()
>>   *
>>   * Allowed functions:
>> - *	fdt_add_reservmap_entry()
>> + *	fdt_add_reservemap_entry()
>>   *	fdt_finish_reservemap()		[moves to 'struct' state]
>>   */
>>  static int fdt_sw_probe_memrsv_(void *fdt)
>> @@ -41,7 +41,7 @@ static int fdt_sw_probe_memrsv_(void *fdt)
>>  	if (err)
>>  		return err;
>> =20
>> -	if (fdt_chk_extra() && fdt_off_dt_strings(fdt) !=3D 0)
>> +	if (!can_assume(VALID_INPUT) && fdt_off_dt_strings(fdt) !=3D 0)
>>  		return -FDT_ERR_BADSTATE;
>>  	return 0;
>>  }
>> @@ -49,7 +49,7 @@ static int fdt_sw_probe_memrsv_(void *fdt)
>>  #define FDT_SW_PROBE_MEMRSV(fdt) \
>>  	{ \
>>  		int err; \
>> -		if (fdt_chk_extra() && (err =3D fdt_sw_probe_memrsv_(fdt)) !=3D 0) \
>> +		if ((err =3D fdt_sw_probe_memrsv_(fdt)) !=3D 0) \
>>  			return err; \
>>  	}
>> =20
>> @@ -63,15 +63,12 @@ static int fdt_sw_probe_memrsv_(void *fdt)
>>   */
>>  static int fdt_sw_probe_struct_(void *fdt)
>>  {
>> -	int err;
>> -
>> -	if (!fdt_chk_extra())
>> -		return 0;
>> -	err =3D fdt_sw_probe_(fdt);
>> +	int err =3D fdt_sw_probe_(fdt);
>>  	if (err)
>>  		return err;
>> =20
>> -	if (fdt_off_dt_strings(fdt) !=3D fdt_totalsize(fdt))
>> +	if (!can_assume(VALID_INPUT) &&
>> +	    fdt_off_dt_strings(fdt) !=3D fdt_totalsize(fdt))
>>  		return -FDT_ERR_BADSTATE;
>>  	return 0;
>>  }
>> @@ -79,7 +76,7 @@ static int fdt_sw_probe_struct_(void *fdt)
>>  #define FDT_SW_PROBE_STRUCT(fdt) \
>>  	{ \
>>  		int err; \
>> -		if (fdt_chk_extra() && (err =3D fdt_sw_probe_struct_(fdt)) !=3D 0) \
>> +		if ((err =3D fdt_sw_probe_struct_(fdt)) !=3D 0) \
>>  			return err; \
>>  	}
>> =20
>> @@ -161,7 +158,8 @@ int fdt_resize(void *fdt, void *buf, int bufsize)
>>  	headsize =3D fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt);
>>  	tailsize =3D fdt_size_dt_strings(fdt);
>> =20
>> -	if (fdt_chk_extra() && (headsize + tailsize) > fdt_totalsize(fdt))
>> +	if (!can_assume(VALID_DTB) &&
>> +	    headsize + tailsize > fdt_totalsize(fdt))
>>  		return -FDT_ERR_INTERNAL;
>> =20
>>  	if ((headsize + tailsize) > (unsigned)bufsize)
>> @@ -379,7 +377,7 @@ int fdt_finish(void *fdt)
>>  	fdt_set_totalsize(fdt, newstroffset + fdt_size_dt_strings(fdt));
>> =20
>>  	/* And fix up fields that were keeping intermediate state. */
>> -	fdt_set_last_comp_version(fdt, FDT_FIRST_SUPPORTED_VERSION);
>> +	fdt_set_last_comp_version(fdt, FDT_LAST_COMPATIBLE_VERSION);
>>  	fdt_set_magic(fdt, FDT_MAGIC);
>> =20
>>  	return 0;
>> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
>> index 16ec53e78b8..7f8bb05c545 100644
>> --- a/scripts/dtc/libfdt/libfdt.h
>> +++ b/scripts/dtc/libfdt/libfdt.h
>> @@ -9,7 +9,12 @@
>>  #include "libfdt_env.h"
>>  #include "fdt.h"
>> =20
>> +#ifdef __cplusplus
>> +extern "C" {
>> +#endif
>> +
>>  #define FDT_FIRST_SUPPORTED_VERSION	0x02
>> +#define FDT_LAST_COMPATIBLE_VERSION	0x10
>>  #define FDT_LAST_SUPPORTED_VERSION	0x11
>> =20
>>  /* Error codes: informative error codes */
>> @@ -97,7 +102,11 @@
>>  	/* FDT_ERR_BADFLAGS: The function was passed a flags field that
>>  	 * contains invalid flags or an invalid combination of flags. */
>> =20
>> -#define FDT_ERR_MAX		18
>> +#define FDT_ERR_ALIGNMENT	19
>> +	/* FDT_ERR_ALIGNMENT: The device tree base address is not 8-byte
>> +	 * aligned. */
>> +
>> +#define FDT_ERR_MAX		19
>> =20
>>  /* constants */
>>  #define FDT_MAX_PHANDLE 0xfffffffe
>> @@ -117,6 +126,23 @@ static inline void *fdt_offset_ptr_w(void *fdt, int=
 offset, int checklen)
>> =20
>>  uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
>> =20
>> +/*
>> + * External helpers to access words from a device tree blob. They're bu=
ilt
>> + * to work even with unaligned pointers on platforms (such as ARMv5) th=
at don't
>> + * like unaligned loads and stores.
>> + */
>> +static inline uint16_t fdt16_ld(const fdt16_t *p)
>> +{
>> +	const uint8_t *bp =3D (const uint8_t *)p;
>> +
>> +	return ((uint16_t)bp[0] << 8) | bp[1];
>> +}
>> +
>> +static inline uint32_t fdt32_ld(const fdt32_t *p)
>> +{
>> +	return fdt32_to_cpu(*p);
>> +}
>> +
>>  static inline void fdt32_st(void *property, uint32_t value)
>>  {
>>  	uint8_t *bp =3D (uint8_t *)property;
>> @@ -127,6 +153,11 @@ static inline void fdt32_st(void *property, uint32_=
t value)
>>  	bp[3] =3D value & 0xff;
>>  }
>> =20
>> +static inline uint64_t fdt64_ld(const fdt64_t *p)
>> +{
>> +	return fdt64_to_cpu(*p);
>> +}
>> +
>>  static inline void fdt64_st(void *property, uint64_t value)
>>  {
>>  	uint8_t *bp =3D (uint8_t *)property;
>> @@ -149,23 +180,23 @@ int fdt_next_node(const void *fdt, int offset, int=
 *depth);
>> =20
>>  /**
>>   * fdt_first_subnode() - get offset of first direct subnode
>> - *
>>   * @fdt:	FDT blob
>>   * @offset:	Offset of node to check
>> + *
>>   * Return: offset of first subnode, or -FDT_ERR_NOTFOUND if there is no=
ne
>>   */
>>  int fdt_first_subnode(const void *fdt, int offset);
>> =20
>>  /**
>>   * fdt_next_subnode() - get offset of next direct subnode
>> + * @fdt:	FDT blob
>> + * @offset:	Offset of previous subnode
>>   *
>>   * After first calling fdt_first_subnode(), call this function repeated=
ly to
>>   * get direct subnodes of a parent node.
>>   *
>> - * @fdt:	FDT blob
>> - * @offset:	Offset of previous subnode
>>   * Return: offset of next subnode, or -FDT_ERR_NOTFOUND if there are no=
 more
>> - * subnodes
>> + *         subnodes
>>   */
>>  int fdt_next_subnode(const void *fdt, int offset);
>> =20
>> @@ -190,7 +221,6 @@ int fdt_next_subnode(const void *fdt, int offset);
>>   * Note that this is implemented as a macro and @node is used as
>>   * iterator in the loop. The parent variable be constant or even a
>>   * literal.
>> - *
>>   */
>>  #define fdt_for_each_subnode(node, fdt, parent)		\
>>  	for (node =3D fdt_first_subnode(fdt, parent);	\
>> @@ -201,7 +231,7 @@ int fdt_next_subnode(const void *fdt, int offset);
>>  /* General functions                                                  *=
/
>>  /**********************************************************************=
/
>>  #define fdt_get_header(fdt, field) \
>> -	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
>> +	(fdt32_ld(&((const struct fdt_header *)(fdt))->field))
>>  #define fdt_magic(fdt)			(fdt_get_header(fdt, magic))
>>  #define fdt_totalsize(fdt)		(fdt_get_header(fdt, totalsize))
>>  #define fdt_off_dt_struct(fdt)		(fdt_get_header(fdt, off_dt_struct))
>> @@ -219,32 +249,36 @@ int fdt_next_subnode(const void *fdt, int offset);
>>  		struct fdt_header *fdth =3D (struct fdt_header *)fdt; \
>>  		fdth->name =3D cpu_to_fdt32(val); \
>>  	}
>> -fdt_set_hdr_(magic);
>> -fdt_set_hdr_(totalsize);
>> -fdt_set_hdr_(off_dt_struct);
>> -fdt_set_hdr_(off_dt_strings);
>> -fdt_set_hdr_(off_mem_rsvmap);
>> -fdt_set_hdr_(version);
>> -fdt_set_hdr_(last_comp_version);
>> -fdt_set_hdr_(boot_cpuid_phys);
>> -fdt_set_hdr_(size_dt_strings);
>> -fdt_set_hdr_(size_dt_struct);
>> +fdt_set_hdr_(magic)
>> +fdt_set_hdr_(totalsize)
>> +fdt_set_hdr_(off_dt_struct)
>> +fdt_set_hdr_(off_dt_strings)
>> +fdt_set_hdr_(off_mem_rsvmap)
>> +fdt_set_hdr_(version)
>> +fdt_set_hdr_(last_comp_version)
>> +fdt_set_hdr_(boot_cpuid_phys)
>> +fdt_set_hdr_(size_dt_strings)
>> +fdt_set_hdr_(size_dt_struct)
>>  #undef fdt_set_hdr_
>> =20
>>  /**
>>   * fdt_header_size - return the size of the tree's header
>>   * @fdt: pointer to a flattened device tree
>> + *
>> + * Return: size of DTB header in bytes
>>   */
>>  size_t fdt_header_size(const void *fdt);
>> =20
>>  /**
>> - * fdt_header_size_ - internal function which takes a version number
>> + * fdt_header_size_ - internal function to get header size from a versi=
on number
>> + * @version: device tree version number
>> + *
>> + * Return: size of DTB header in bytes
>>   */
>>  size_t fdt_header_size_(uint32_t version);
>> =20
>>  /**
>>   * fdt_check_header - sanity check a device tree header
>> -
>>   * @fdt: pointer to data which might be a flattened device tree
>>   *
>>   * fdt_check_header() checks that the given buffer contains what
>> @@ -369,8 +403,7 @@ static inline uint32_t fdt_get_max_phandle(const voi=
d *fdt)
>>   * highest phandle value in the device tree blob) will be returned in t=
he
>>   * @phandle parameter.
>>   *
>> - * Returns:
>> - *   0 on success or a negative error-code on failure
>> + * Return: 0 on success or a negative error-code on failure
>>   */
>>  int fdt_generate_phandle(const void *fdt, uint32_t *phandle);
>> =20
>> @@ -390,9 +423,11 @@ int fdt_num_mem_rsv(const void *fdt);
>>  /**
>>   * fdt_get_mem_rsv - retrieve one memory reserve map entry
>>   * @fdt: pointer to the device tree blob
>> - * @address, @size: pointers to 64-bit variables
>> + * @n: index of reserve map entry
>> + * @address: pointer to 64-bit variable to hold the start address
>> + * @size: pointer to 64-bit variable to hold the size of the entry
>>   *
>> - * On success, *address and *size will contain the address and size of
>> + * On success, @address and @size will contain the address and size of
>>   * the n-th reserve map entry from the device tree blob, in
>>   * native-endian format.
>>   *
>> @@ -415,6 +450,8 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t=
 *address, uint64_t *size);
>>   * namelen characters of name for matching the subnode name.  This is
>>   * useful for finding subnodes based on a portion of a larger string,
>>   * such as a full path.
>> + *
>> + * Return: offset of the subnode or -FDT_ERR_NOTFOUND if name not found=
.
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
>> @@ -454,6 +491,8 @@ int fdt_subnode_offset(const void *fdt, int parentof=
fset, const char *name);
>>   *
>>   * Identical to fdt_path_offset(), but only consider the first namelen
>>   * characters of path as the path name.
>> + *
>> + * Return: offset of the node or negative libfdt error value otherwise
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  int fdt_path_offset_namelen(const void *fdt, const char *path, int name=
len);
>> @@ -471,12 +510,37 @@ int fdt_path_offset_namelen(const void *fdt, const=
 char *path, int namelen);
>>   * level matching the given component, differentiated only by unit
>>   * address).
>>   *
>> + * If the path is not absolute (i.e. does not begin with '/'), the
>> + * first component is treated as an alias.  That is, the property by
>> + * that name is looked up in the /aliases node, and the value of that
>> + * property used in place of that first component.
>> + *
>> + * For example, for this small fragment
>> + *
>> + * / {
>> + *     aliases {
>> + *         i2c2 =3D &foo; // RHS compiles to "/soc@0/i2c@30a40000/eepro=
m@52"
>> + *     };
>> + *     soc@0 {
>> + *         foo: i2c@30a40000 {
>> + *             bar: eeprom@52 {
>> + *             };
>> + *         };
>> + *     };
>> + * };
>> + *
>> + * these would be equivalent:
>> + *
>> + *   /soc@0/i2c@30a40000/eeprom@52
>> + *   i2c2/eeprom@52
>> + *
>>   * returns:
>>   *	structure block offset of the node with the requested path (>=3D0), =
on
>>   *		success
>> - *	-FDT_ERR_BADPATH, given path does not begin with '/' or is invalid
>> + *	-FDT_ERR_BADPATH, given path does not begin with '/' and the first
>> + *		component is not a valid alias
>>   *	-FDT_ERR_NOTFOUND, if the requested node does not exist
>> - *      -FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>>   *	-FDT_ERR_BADSTATE,
>>   *	-FDT_ERR_BADSTRUCTURE,
>> @@ -521,7 +585,7 @@ const char *fdt_get_name(const void *fdt, int nodeof=
fset, int *lenp);
>>   *	structure block offset of the property (>=3D0), on success
>>   *	-FDT_ERR_NOTFOUND, if the requested node has no properties
>>   *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_BEGIN_NODE=
 tag
>> - *      -FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>>   *	-FDT_ERR_BADSTATE,
>>   *	-FDT_ERR_BADSTRUCTURE,
>> @@ -542,7 +606,7 @@ int fdt_first_property_offset(const void *fdt, int n=
odeoffset);
>>   *	structure block offset of the next property (>=3D0), on success
>>   *	-FDT_ERR_NOTFOUND, if the given property is the last in its node
>>   *	-FDT_ERR_BADOFFSET, if nodeoffset did not point to an FDT_PROP tag
>> - *      -FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>>   *	-FDT_ERR_BADSTATE,
>>   *	-FDT_ERR_BADSTRUCTURE,
>> @@ -553,9 +617,9 @@ int fdt_next_property_offset(const void *fdt, int of=
fset);
>>  /**
>>   * fdt_for_each_property_offset - iterate over all properties of a node
>>   *
>> - * @property_offset:	property offset (int, lvalue)
>> - * @fdt:		FDT blob (const void *)
>> - * @node:		node offset (int)
>> + * @property:	property offset (int, lvalue)
>> + * @fdt:	FDT blob (const void *)
>> + * @node:	node offset (int)
>>   *
>>   * This is actually a wrapper around a for loop and would be used like =
so:
>>   *
>> @@ -607,6 +671,13 @@ int fdt_next_property_offset(const void *fdt, int o=
ffset);
>>  const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
>>  						      int offset,
>>  						      int *lenp);
>> +static inline struct fdt_property *fdt_get_property_by_offset_w(void *f=
dt,
>> +								int offset,
>> +								int *lenp)
>> +{
>> +	return (struct fdt_property *)(uintptr_t)
>> +		fdt_get_property_by_offset(fdt, offset, lenp);
>> +}
>> =20
>>  /**
>>   * fdt_get_property_namelen - find a property based on substring
>> @@ -618,12 +689,22 @@ const struct fdt_property *fdt_get_property_by_off=
set(const void *fdt,
>>   *
>>   * Identical to fdt_get_property(), but only examine the first namelen
>>   * characters of name for matching the property name.
>> + *
>> + * Return: pointer to the structure representing the property, or NULL
>> + *         if not found
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  const struct fdt_property *fdt_get_property_namelen(const void *fdt,
>>  						    int nodeoffset,
>>  						    const char *name,
>>  						    int namelen, int *lenp);
>> +static inline struct fdt_property *
>> +fdt_get_property_namelen_w(void *fdt, int nodeoffset, const char *name,
>> +			   int namelen, int *lenp)
>> +{
>> +	return (struct fdt_property *)(uintptr_t)fdt_get_property_namelen(
>> +		fdt, nodeoffset, name, namelen, lenp);
>> +}
>>  #endif
>> =20
>>  /**
>> @@ -676,7 +757,7 @@ static inline struct fdt_property *fdt_get_property_=
w(void *fdt, int nodeoffset,
>>   * to within the device blob itself, not a copy of the value).  If
>>   * lenp is non-NULL, the length of the property value is also
>>   * returned, in the integer pointed to by lenp.  If namep is non-NULL,
>> - * the property's namne will also be returned in the char * pointed to
>> + * the property's name will also be returned in the char * pointed to
>>   * by namep (this will be a pointer to within the device tree's string
>>   * block, not a new copy of the name).
>>   *
>> @@ -684,7 +765,7 @@ static inline struct fdt_property *fdt_get_property_=
w(void *fdt, int nodeoffset,
>>   *	pointer to the property's value
>>   *		if lenp is non-NULL, *lenp contains the length of the property
>>   *		value (>=3D0)
>> - *		if namep is non-NULL *namep contiains a pointer to the property
>> + *		if namep is non-NULL *namep contains a pointer to the property
>>   *		name.
>>   *	NULL, on error
>>   *		if lenp is non-NULL, *lenp contains an error code (<0):
>> @@ -710,6 +791,8 @@ const void *fdt_getprop_by_offset(const void *fdt, i=
nt offset,
>>   *
>>   * Identical to fdt_getprop(), but only examine the first namelen
>>   * characters of name for matching the property name.
>> + *
>> + * Return: pointer to the property's value or NULL on error
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
>> @@ -731,10 +814,10 @@ static inline void *fdt_getprop_namelen_w(void *fd=
t, int nodeoffset,
>>   * @lenp: pointer to an integer variable (will be overwritten) or NULL
>>   *
>>   * fdt_getprop() retrieves a pointer to the value of the property
>> - * named 'name' of the node at offset nodeoffset (this will be a
>> + * named @name of the node at offset @nodeoffset (this will be a
>>   * pointer to within the device blob itself, not a copy of the value).
>> - * If lenp is non-NULL, the length of the property value is also
>> - * returned, in the integer pointed to by lenp.
>> + * If @lenp is non-NULL, the length of the property value is also
>> + * returned, in the integer pointed to by @lenp.
>>   *
>>   * returns:
>>   *	pointer to the property's value
>> @@ -776,11 +859,14 @@ uint32_t fdt_get_phandle(const void *fdt, int node=
offset);
>>  /**
>>   * fdt_get_alias_namelen - get alias based on substring
>>   * @fdt: pointer to the device tree blob
>> - * @name: name of the alias th look up
>> + * @name: name of the alias to look up
>>   * @namelen: number of characters of name to consider
>>   *
>> - * Identical to fdt_get_alias(), but only examine the first namelen
>> - * characters of name for matching the alias name.
>> + * Identical to fdt_get_alias(), but only examine the first @namelen
>> + * characters of @name for matching the alias name.
>> + *
>> + * Return: a pointer to the expansion of the alias named @name, if it e=
xists,
>> + *	   NULL otherwise
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  const char *fdt_get_alias_namelen(const void *fdt,
>> @@ -790,10 +876,10 @@ const char *fdt_get_alias_namelen(const void *fdt,
>>  /**
>>   * fdt_get_alias - retrieve the path referenced by a given alias
>>   * @fdt: pointer to the device tree blob
>> - * @name: name of the alias th look up
>> + * @name: name of the alias to look up
>>   *
>>   * fdt_get_alias() retrieves the value of a given alias.  That is, the
>> - * value of the property named 'name' in the node /aliases.
>> + * value of the property named @name in the node /aliases.
>>   *
>>   * returns:
>>   *	a pointer to the expansion of the alias named 'name', if it exists
>> @@ -801,6 +887,42 @@ const char *fdt_get_alias_namelen(const void *fdt,
>>   */
>>  const char *fdt_get_alias(const void *fdt, const char *name);
>> =20
>> +/**
>> + * fdt_get_symbol_namelen - get symbol based on substring
>> + * @fdt: pointer to the device tree blob
>> + * @name: name of the symbol to look up
>> + * @namelen: number of characters of name to consider
>> + *
>> + * Identical to fdt_get_symbol(), but only examine the first @namelen
>> + * characters of @name for matching the symbol name.
>> + *
>> + * Return: a pointer to the expansion of the symbol named @name, if it =
exists,
>> + *	   NULL otherwise
>> + */
>> +#ifndef SWIG /* Not available in Python */
>> +const char *fdt_get_symbol_namelen(const void *fdt,
>> +				   const char *name, int namelen);
>> +#endif
>> +
>> +/**
>> + * fdt_get_symbol - retrieve the path referenced by a given symbol
>> + * @fdt: pointer to the device tree blob
>> + * @name: name of the symbol to look up
>> + *
>> + * fdt_get_symbol() retrieves the value of a given symbol.  That is,
>> + * the value of the property named @name in the node
>> + * /__symbols__. Such a node exists only for a device tree blob that
>> + * has been compiled with the -@ dtc option. Each property corresponds
>> + * to a label appearing in the device tree source, with the name of
>> + * the property being the label and the value being the full path of
>> + * the node it is attached to.
>> + *
>> + * returns:
>> + *	a pointer to the expansion of the symbol named 'name', if it exists
>> + *	NULL, if the given symbol or the /__symbols__ node does not exist
>> + */
>> +const char *fdt_get_symbol(const void *fdt, const char *name);
>> +
>>  /**
>>   * fdt_get_path - determine the full path of a node
>>   * @fdt: pointer to the device tree blob
>> @@ -969,14 +1091,13 @@ int fdt_node_offset_by_prop_value(const void *fdt=
, int startoffset,
>>  int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
>> =20
>>  /**
>> - * fdt_node_check_compatible: check a node's compatible property
>> + * fdt_node_check_compatible - check a node's compatible property
>>   * @fdt: pointer to the device tree blob
>>   * @nodeoffset: offset of a tree node
>>   * @compatible: string to match against
>>   *
>> - *
>>   * fdt_node_check_compatible() returns 0 if the given node contains a
>> - * 'compatible' property with the given string as one of its elements,
>> + * @compatible property with the given string as one of its elements,
>>   * it returns non-zero otherwise, or on error.
>>   *
>>   * returns:
>> @@ -1040,7 +1161,7 @@ int fdt_node_offset_by_compatible(const void *fdt,=
 int startoffset,
>>   * one or more strings, each terminated by \0, as is found in a device =
tree
>>   * "compatible" property.
>>   *
>> - * @return: 1 if the string is found in the list, 0 not found, or inval=
id list
>> + * Return: 1 if the string is found in the list, 0 not found, or invali=
d list
>>   */
>>  int fdt_stringlist_contains(const char *strlist, int listlen, const cha=
r *str);
>> =20
>> @@ -1049,7 +1170,8 @@ int fdt_stringlist_contains(const char *strlist, i=
nt listlen, const char *str);
>>   * @fdt: pointer to the device tree blob
>>   * @nodeoffset: offset of a tree node
>>   * @property: name of the property containing the string list
>> - * @return:
>> + *
>> + * Return:
>>   *   the number of strings in the given property
>>   *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
>>   *   -FDT_ERR_NOTFOUND if the property does not exist
>> @@ -1069,7 +1191,7 @@ int fdt_stringlist_count(const void *fdt, int node=
offset, const char *property);
>>   * small-valued cell properties, such as #address-cells, when searching=
 for
>>   * the empty string.
>>   *
>> - * @return:
>> + * return:
>>   *   the index of the string in the list of strings
>>   *   -FDT_ERR_BADVALUE if the property value is not NUL-terminated
>>   *   -FDT_ERR_NOTFOUND if the property does not exist or does not conta=
in
>> @@ -1093,7 +1215,7 @@ int fdt_stringlist_search(const void *fdt, int nod=
eoffset, const char *property,
>>   * If non-NULL, the length of the string (on success) or a negative err=
or-code
>>   * (on failure) will be stored in the integer pointer to by lenp.
>>   *
>> - * @return:
>> + * Return:
>>   *   A pointer to the string at the given index in the string list or N=
ULL on
>>   *   failure. On success the length of the string will be stored in the=
 memory
>>   *   location pointed to by the lenp parameter, if non-NULL. On failure=
 one of
>> @@ -1130,8 +1252,8 @@ const char *fdt_stringlist_get(const void *fdt, in=
t nodeoffset,
>>   *
>>   * returns:
>>   *	0 <=3D n < FDT_MAX_NCELLS, on success
>> - *      2, if the node has no #address-cells property
>> - *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invali=
d
>> + *	2, if the node has no #address-cells property
>> + *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
>>   *		#address-cells property
>>   *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>> @@ -1151,8 +1273,8 @@ int fdt_address_cells(const void *fdt, int nodeoff=
set);
>>   *
>>   * returns:
>>   *	0 <=3D n < FDT_MAX_NCELLS, on success
>> - *      1, if the node has no #size-cells property
>> - *      -FDT_ERR_BADNCELLS, if the node has a badly formatted or invali=
d
>> + *	1, if the node has no #size-cells property
>> + *	-FDT_ERR_BADNCELLS, if the node has a badly formatted or invalid
>>   *		#size-cells property
>>   *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>> @@ -1181,6 +1303,8 @@ int fdt_size_cells(const void *fdt, int nodeoffset=
);
>>   * starting from the given index, and using only the first characters
>>   * of the name. It is useful when you want to manipulate only one value=
 of
>>   * an array and you have a string that doesn't end with \0.
>> + *
>> + * Return: 0 on success, negative libfdt error value otherwise
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  int fdt_setprop_inplace_namelen_partial(void *fdt, int nodeoffset,
>> @@ -1294,8 +1418,13 @@ static inline int fdt_setprop_inplace_u64(void *f=
dt, int nodeoffset,
>> =20
>>  /**
>>   * fdt_setprop_inplace_cell - change the value of a single-cell propert=
y
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node containing the property
>> + * @name: name of the property to change the value of
>> + * @val: new value of the 32-bit cell
>>   *
>>   * This is an alternative name for fdt_setprop_inplace_u32()
>> + * Return: 0 on success, negative libfdt error number otherwise.
>>   */
>>  static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
>>  					   const char *name, uint32_t val)
>> @@ -1367,14 +1496,14 @@ int fdt_nop_node(void *fdt, int nodeoffset);
>> =20
>>  /**
>>   * fdt_create_with_flags - begin creation of a new fdt
>> - * @fdt: pointer to memory allocated where fdt will be created
>> + * @buf: pointer to memory allocated where fdt will be created
>>   * @bufsize: size of the memory space at fdt
>>   * @flags: a valid combination of FDT_CREATE_FLAG_ flags, or 0.
>>   *
>>   * fdt_create_with_flags() begins the process of creating a new fdt wit=
h
>>   * the sequential write interface.
>>   *
>> - * fdt creation process must end with fdt_finished() to produce a valid=
 fdt.
>> + * fdt creation process must end with fdt_finish() to produce a valid f=
dt.
>>   *
>>   * returns:
>>   *	0, on success
>> @@ -1385,7 +1514,7 @@ int fdt_create_with_flags(void *buf, int bufsize, =
uint32_t flags);
>> =20
>>  /**
>>   * fdt_create - begin creation of a new fdt
>> - * @fdt: pointer to memory allocated where fdt will be created
>> + * @buf: pointer to memory allocated where fdt will be created
>>   * @bufsize: size of the memory space at fdt
>>   *
>>   * fdt_create() is equivalent to fdt_create_with_flags() with flags=3D0=
.
>> @@ -1425,7 +1554,7 @@ static inline int fdt_property_cell(void *fdt, con=
st char *name, uint32_t val)
>>   * @fdt: pointer to the device tree blob
>>   * @name: name of property to add
>>   * @len: length of property value in bytes
>> - * @valp: returns a pointer to where where the value should be placed
>> + * @valp: returns a pointer to where the value should be placed
>>   *
>>   * returns:
>>   *	0, on success
>> @@ -1450,7 +1579,8 @@ int fdt_pack(void *fdt);
>>  /**
>>   * fdt_add_mem_rsv - add one memory reserve map entry
>>   * @fdt: pointer to the device tree blob
>> - * @address, @size: 64-bit values (native endian)
>> + * @address: 64-bit start address of the reserve map entry
>> + * @size: 64-bit size of the reserved region
>>   *
>>   * Adds a reserve map entry to the given blob reserving a region at
>>   * address address of length size.
>> @@ -1521,6 +1651,38 @@ int fdt_del_mem_rsv(void *fdt, int n);
>>   */
>>  int fdt_set_name(void *fdt, int nodeoffset, const char *name);
>> =20
>> +/**
>> + * fdt_setprop_namelen - create or change a property
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node whose property to change
>> + * @name: name of the property to change
>> + * @namelen: length of the name
>> + * @val: pointer to data to set the property value to
>> + * @len: length of the property value
>> + *
>> + * fdt_setprop_namelen() sets the value of the named property in the gi=
ven
>> + * node to the given value and length, creating the property if it
>> + * does not already exist.
>> + *
>> + * This function may insert or delete data from the blob, and will
>> + * therefore change the offsets of some existing nodes.
>> + *
>> + * returns:
>> + *	0, on success
>> + *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
>> + *		contain the new property value
>> + *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADVERSION,
>> + *	-FDT_ERR_BADSTATE,
>> + *	-FDT_ERR_BADSTRUCTURE,
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_TRUNCATED, standard meanings
>> + */
>> +int fdt_setprop_namelen(void *fdt, int nodeoffset, const char *name,
>> +			int namelen, const void *val, int len);
>> +
>>  /**
>>   * fdt_setprop - create or change a property
>>   * @fdt: pointer to the device tree blob
>> @@ -1549,8 +1711,44 @@ int fdt_set_name(void *fdt, int nodeoffset, const=
 char *name);
>>   *	-FDT_ERR_BADLAYOUT,
>>   *	-FDT_ERR_TRUNCATED, standard meanings
>>   */
>> -int fdt_setprop(void *fdt, int nodeoffset, const char *name,
>> -		const void *val, int len);
>> +static inline int fdt_setprop(void *fdt, int nodeoffset, const char *na=
me,
>> +			      const void *val, int len)
>> +{
>> +	return fdt_setprop_namelen(fdt, nodeoffset, name, strlen(name), val,
>> +				   len);
>> +}
>> +
>> +/**
>> + * fdt_setprop_placeholder_namelen - allocate space for a property
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node whose property to change
>> + * @name: name of the property to change
>> + * @namelen: length of the name
>> + * @len: length of the property value
>> + * @prop_data: return pointer to property data
>> + *
>> + * fdt_setprop_placeholder_namelen() allocates the named property in th=
e given node.
>> + * If the property exists it is resized. In either case a pointer to th=
e
>> + * property data is returned.
>> + *
>> + * This function may insert or delete data from the blob, and will
>> + * therefore change the offsets of some existing nodes.
>> + *
>> + * returns:
>> + *	0, on success
>> + *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
>> + *		contain the new property value
>> + *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADVERSION,
>> + *	-FDT_ERR_BADSTATE,
>> + *	-FDT_ERR_BADSTRUCTURE,
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_TRUNCATED, standard meanings
>> + */
>> +int fdt_setprop_placeholder_namelen(void *fdt, int nodeoffset, const ch=
ar *name,
>> +				    int namelen, int len, void **prop_data);
>> =20
>>  /**
>>   * fdt_setprop_placeholder - allocate space for a property
>> @@ -1560,7 +1758,7 @@ int fdt_setprop(void *fdt, int nodeoffset, const c=
har *name,
>>   * @len: length of the property value
>>   * @prop_data: return pointer to property data
>>   *
>> - * fdt_setprop_placeholer() allocates the named property in the given n=
ode.
>> + * fdt_setprop_placeholder() allocates the named property in the given =
node.
>>   * If the property exists it is resized. In either case a pointer to th=
e
>>   * property data is returned.
>>   *
>> @@ -1580,8 +1778,13 @@ int fdt_setprop(void *fdt, int nodeoffset, const =
char *name,
>>   *	-FDT_ERR_BADLAYOUT,
>>   *	-FDT_ERR_TRUNCATED, standard meanings
>>   */
>> -int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name=
,
>> -			    int len, void **prop_data);
>> +static inline int fdt_setprop_placeholder(void *fdt, int nodeoffset,
>> +					  const char *name, int len,
>> +					  void **prop_data)
>> +{
>> +	return fdt_setprop_placeholder_namelen(fdt, nodeoffset, name,
>> +					       strlen(name), len, prop_data);
>> +}
>> =20
>>  /**
>>   * fdt_setprop_u32 - set a property to a 32-bit integer
>> @@ -1655,8 +1858,14 @@ static inline int fdt_setprop_u64(void *fdt, int =
nodeoffset, const char *name,
>> =20
>>  /**
>>   * fdt_setprop_cell - set a property to a single cell value
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node whose property to change
>> + * @name: name of the property to change
>> + * @val: 32-bit integer value for the property (native endian)
>>   *
>>   * This is an alternative name for fdt_setprop_u32()
>> + *
>> + * Return: 0 on success, negative libfdt error value otherwise.
>>   */
>>  static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const cha=
r *name,
>>  				   uint32_t val)
>> @@ -1695,6 +1904,39 @@ static inline int fdt_setprop_cell(void *fdt, int=
 nodeoffset, const char *name,
>>  #define fdt_setprop_string(fdt, nodeoffset, name, str) \
>>  	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
>> =20
>> +/**
>> + * fdt_setprop_namelen_string - set a property to a string value
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node whose property to change
>> + * @name: name of the property to change
>> + * @namelen: number of characters of name to consider
>> + * @str: string value for the property
>> + *
>> + * fdt_setprop_namelen_string() sets the value of the named property in=
 the
>> + * given node to the given string value (using the length of the
>> + * string to determine the new length of the property), or creates a
>> + * new property with that value if it does not already exist.
>> + *
>> + * This function may insert or delete data from the blob, and will
>> + * therefore change the offsets of some existing nodes.
>> + *
>> + * returns:
>> + *	0, on success
>> + *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
>> + *		contain the new property value
>> + *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADVERSION,
>> + *	-FDT_ERR_BADSTATE,
>> + *	-FDT_ERR_BADSTRUCTURE,
>> + *	-FDT_ERR_BADLAYOUT,
>> + *	-FDT_ERR_TRUNCATED, standard meanings
>> + */
>> +#define fdt_setprop_namelen_string(fdt, nodeoffset, name, namelen, str)=
    \
>> +	fdt_setprop_namelen((fdt), (nodeoffset), (name), (namelen), (str), \
>> +			    strlen(str) + 1)
>> +
>>  /**
>>   * fdt_setprop_empty - set a property to an empty value
>>   * @fdt: pointer to the device tree blob
>> @@ -1826,8 +2068,14 @@ static inline int fdt_appendprop_u64(void *fdt, i=
nt nodeoffset,
>> =20
>>  /**
>>   * fdt_appendprop_cell - append a single cell value to a property
>> + * @fdt: pointer to the device tree blob
>> + * @nodeoffset: offset of the node whose property to change
>> + * @name: name of the property to change
>> + * @val: 32-bit integer value to append to the property (native endian)
>>   *
>>   * This is an alternative name for fdt_appendprop_u32()
>> + *
>> + * Return: 0 on success, negative libfdt error value otherwise.
>>   */
>>  static inline int fdt_appendprop_cell(void *fdt, int nodeoffset,
>>  				      const char *name, uint32_t val)
>> @@ -1878,7 +2126,7 @@ static inline int fdt_appendprop_cell(void *fdt, i=
nt nodeoffset,
>>   * address and size) to the value of the named property in the given
>>   * node, or creates a new property with that value if it does not
>>   * already exist.
>> - * If "name" is not specified, a default "reg" is used.
>> + *
>>   * Cell sizes are determined by parent's #address-cells and #size-cells=
.
>>   *
>>   * This function may insert data into the blob, and will therefore
>> @@ -1908,7 +2156,7 @@ int fdt_appendprop_addrrange(void *fdt, int parent=
, int nodeoffset,
>>   * @nodeoffset: offset of the node whose property to nop
>>   * @name: name of the property to nop
>>   *
>> - * fdt_del_property() will delete the given property.
>> + * fdt_delprop() will delete the given property.
>>   *
>>   * This function will delete data from the blob, and will therefore
>>   * change the offsets of some existing nodes.
>> @@ -1930,13 +2178,16 @@ int fdt_delprop(void *fdt, int nodeoffset, const=
 char *name);
>>   * fdt_add_subnode_namelen - creates a new node based on substring
>>   * @fdt: pointer to the device tree blob
>>   * @parentoffset: structure block offset of a node
>> - * @name: name of the subnode to locate
>> + * @name: name of the subnode to create
>>   * @namelen: number of characters of name to consider
>>   *
>> - * Identical to fdt_add_subnode(), but use only the first namelen
>> - * characters of name as the name of the new node.  This is useful for
>> + * Identical to fdt_add_subnode(), but use only the first @namelen
>> + * characters of @name as the name of the new node.  This is useful for
>>   * creating subnodes based on a portion of a larger string, such as a
>>   * full path.
>> + *
>> + * Return: structure block offset of the created subnode (>=3D0),
>> + *	   negative libfdt error value otherwise
>>   */
>>  #ifndef SWIG /* Not available in Python */
>>  int fdt_add_subnode_namelen(void *fdt, int parentoffset,
>> @@ -1955,10 +2206,9 @@ int fdt_add_subnode_namelen(void *fdt, int parent=
offset,
>>   *
>>   * This function will insert data into the blob, and will therefore
>>   * change the offsets of some existing nodes.
>> -
>> + *
>>   * returns:
>> - *	structure block offset of the created nodeequested subnode (>=3D0), =
on
>> - *		success
>> + *	structure block offset of the created subnode (>=3D0), on success
>>   *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
>>   *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NO=
DE
>>   *		tag
>> @@ -1968,7 +2218,7 @@ int fdt_add_subnode_namelen(void *fdt, int parento=
ffset,
>>   *		blob to contain the new node
>>   *	-FDT_ERR_NOSPACE
>>   *	-FDT_ERR_BADLAYOUT
>> - *      -FDT_ERR_BADMAGIC,
>> + *	-FDT_ERR_BADMAGIC,
>>   *	-FDT_ERR_BADVERSION,
>>   *	-FDT_ERR_BADSTATE,
>>   *	-FDT_ERR_BADSTRUCTURE,
>> @@ -2013,7 +2263,7 @@ int fdt_del_node(void *fdt, int nodeoffset);
>>   * returns:
>>   *	0, on success
>>   *	-FDT_ERR_NOSPACE, there's not enough space in the base device tree
>> - *	-FDT_ERR_NOTFOUND, the overlay points to some inexistant nodes or
>> + *	-FDT_ERR_NOTFOUND, the overlay points to some nonexistent nodes or
>>   *		properties in the base DT
>>   *	-FDT_ERR_BADPHANDLE,
>>   *	-FDT_ERR_BADOVERLAY,
>> @@ -2030,6 +2280,24 @@ int fdt_del_node(void *fdt, int nodeoffset);
>>   */
>>  int fdt_overlay_apply(void *fdt, void *fdto);
>> =20
>> +/**
>> + * fdt_overlay_target_offset - retrieves the offset of a fragment's tar=
get
>> + * @fdt: Base device tree blob
>> + * @fdto: Device tree overlay blob
>> + * @fragment_offset: node offset of the fragment in the overlay
>> + * @pathp: pointer which receives the path of the target (or NULL)
>> + *
>> + * fdt_overlay_target_offset() retrieves the target offset in the base
>> + * device tree of a fragment, no matter how the actual targeting is
>> + * done (through a phandle or a path)
>> + *
>> + * returns:
>> + *      the targeted node offset in the base device tree
>> + *      Negative error code on error
>> + */
>> +int fdt_overlay_target_offset(const void *fdt, const void *fdto,
>> +			      int fragment_offset, char const **pathp);
>> +
>>  /**
>>   * fdt_overlay_apply_node - Merges a node into the base device tree
>>   *
>> @@ -2043,4 +2311,8 @@ int fdt_overlay_apply_node(void *fdt, int target, =
void *fdto, int node);
>> =20
>>  const char *fdt_strerror(int errval);
>> =20
>> +#ifdef __cplusplus
>> +}
>> +#endif
>> +
>>  #endif /* LIBFDT_H */
>> diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/l=
ibfdt_internal.h
>> index 5436e2ceeac..b60b5456f59 100644
>> --- a/scripts/dtc/libfdt/libfdt_internal.h
>> +++ b/scripts/dtc/libfdt/libfdt_internal.h
>> @@ -10,20 +10,25 @@
>>  #define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
>>  #define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
>> =20
>> -int fdt_ro_probe_(const void *fdt);
>> +int32_t fdt_ro_probe_(const void *fdt);
>>  #define FDT_RO_PROBE(fdt)					\
>>  	{							\
>> -		int totalsize_;					\
>> -		if (fdt_chk_basic()) {				\
>> -			totalsize_ =3D fdt_ro_probe_(fdt);	\
>> -			if (totalsize_ < 0)			\
>> -				return totalsize_;		\
>> -		}						\
>> +		int32_t totalsize_;				\
>> +		if ((totalsize_ =3D fdt_ro_probe_(fdt)) < 0)	\
>> +			return totalsize_;			\
>>  	}
>> =20
>>  int fdt_check_node_offset_(const void *fdt, int offset);
>>  int fdt_check_prop_offset_(const void *fdt, int offset);
>> -const char *fdt_find_string_(const char *strtab, int tabsize, const cha=
r *s);
>> +
>> +const char *fdt_find_string_len_(const char *strtab, int tabsize, const=
 char *s,
>> +				 int s_len);
>> +static inline const char *fdt_find_string_(const char *strtab, int tabs=
ize,
>> +					   const char *s)
>> +{
>> +	return fdt_find_string_len_(strtab, tabsize, s, strlen(s));
>> +}
>> +
>>  int fdt_node_end_offset_(void *fdt, int nodeoffset);
>> =20
>>  static inline const void *fdt_offset_ptr_(const void *fdt, int offset)
>> @@ -49,6 +54,25 @@ static inline struct fdt_reserve_entry *fdt_mem_rsv_w=
_(void *fdt, int n)
>>  	return (void *)(uintptr_t)fdt_mem_rsv_(fdt, n);
>>  }
>> =20
>> +/*
>> + * Internal helpers to access structural elements of the device tree
>> + * blob (rather than for example reading integers from within property
>> + * values).  We assume that we are either given a naturally aligned
>> + * address for the platform or if we are not, we are on a platform
>> + * where unaligned memory reads will be handled in a graceful manner.
>> + * If not the external helpers fdtXX_ld() from libfdt.h can be used
>> + * instead.
>> + */
>> +static inline uint32_t fdt32_ld_(const fdt32_t *p)
>> +{
>> +	return fdt32_to_cpu(*p);
>> +}
>> +
>> +static inline uint64_t fdt64_ld_(const fdt64_t *p)
>> +{
>> +	return fdt64_to_cpu(*p);
>> +}
>> +
>>  #define FDT_SW_MAGIC		(~FDT_MAGIC)
>> =20
>>  /**********************************************************************=
/
>> @@ -61,20 +85,21 @@ static inline struct fdt_reserve_entry *fdt_mem_rsv_=
w_(void *fdt, int n)
>> =20
>>  /*
>>   * Defines assumptions which can be enabled. Each of these can be enabl=
ed
>> - * individually. For maximum saftey, don't enable any assumptions!
>> + * individually. For maximum safety, don't enable any assumptions!
>>   *
>> - * For minimal code size and no safety, use FDT_ASSUME_PERFECT at your =
own risk.
>> + * For minimal code size and no safety, use ASSUME_PERFECT at your own =
risk.
>>   * You should have another method of validating the device tree, such a=
s a
>>   * signature or hash check before using libfdt.
>>   *
>>   * For situations where security is not a concern it may be safe to ena=
ble
>> - * FDT_ASSUME_FRIENDLY.
>> + * ASSUME_SANE.
>>   */
>>  enum {
>>  	/*
>>  	 * This does essentially no checks. Only the latest device-tree
>> -	 * version is correctly handled. Incosistencies or errors in the devic=
e
>> -	 * tree may cause undefined behaviour or crashes.
>> +	 * version is correctly handled. Inconsistencies or errors in the devi=
ce
>> +	 * tree may cause undefined behaviour or crashes. Invalid parameters
>> +	 * passed to libfdt may do the same.
>>  	 *
>>  	 * If an error occurs when modifying the tree it may leave the tree in
>>  	 * an intermediate (but valid) state. As an example, adding a property
>> @@ -85,17 +110,35 @@ enum {
>>  	 * Only use this if you have a fully validated device tree with
>>  	 * the latest supported version and wish to minimise code size.
>>  	 */
>> -	FDT_ASSUME_PERFECT	=3D 0xff,
>> +	ASSUME_PERFECT		=3D 0xff,
>> =20
>>  	/*
>>  	 * This assumes that the device tree is sane. i.e. header metadata
>>  	 * and basic hierarchy are correct.
>>  	 *
>> -	 * These checks will be sufficient if you have a valid device tree wit=
h
>> -	 * no internal inconsistencies. With this assumption, libfdt will
>> -	 * generally not return -FDT_ERR_INTERNAL, -FDT_ERR_BADLAYOUT, etc.
>> +	 * With this assumption enabled, normal device trees produced by libfd=
t
>> +	 * and the compiler should be handled safely. Malicious device trees a=
nd
>> +	 * complete garbage may cause libfdt to behave badly or crash. Truncat=
ed
>> +	 * device trees (e.g. those only partially loaded) can also cause
>> +	 * problems.
>> +	 *
>> +	 * Note: Only checks that relate exclusively to the device tree itself
>> +	 * (not the parameters passed to libfdt) are disabled by this
>> +	 * assumption. This includes checking headers, tags and the like.
>> +	 */
>> +	ASSUME_VALID_DTB	=3D 1 << 0,
>> +
>> +	/*
>> +	 * This builds on ASSUME_VALID_DTB and further assumes that libfdt
>> +	 * functions are called with valid parameters, i.e. not trigger
>> +	 * FDT_ERR_BADOFFSET or offsets that are out of bounds. It disables an=
y
>> +	 * extensive checking of parameters and the device tree, making variou=
s
>> +	 * assumptions about correctness.
>> +	 *
>> +	 * It doesn't make sense to enable this assumption unless
>> +	 * ASSUME_VALID_DTB is also enabled.
>>  	 */
>> -	FDT_ASSUME_SANE		=3D 1 << 0,
>> +	ASSUME_VALID_INPUT	=3D 1 << 1,
>> =20
>>  	/*
>>  	 * This disables checks for device-tree version and removes all code
>> @@ -104,34 +147,54 @@ enum {
>>  	 * Only enable this if you know you have a device tree with the latest
>>  	 * version.
>>  	 */
>> -	FDT_ASSUME_LATEST	=3D 1 << 1,
>> +	ASSUME_LATEST		=3D 1 << 2,
>> =20
>>  	/*
>> -	 * This disables any extensive checking of parameters and the device
>> -	 * tree, making various assumptions about correctness. Normal device
>> -	 * trees produced by libfdt and the compiler should be handled safely.
>> -	 * Malicious device trees and complete garbage may cause libfdt to
>> -	 * behave badly or crash.
>> +	 * This assumes that it is OK for a failed addition to the device tree=
,
>> +	 * due to lack of space or some other problem, to skip any rollback
>> +	 * steps (such as dropping the property name from the string table).
>> +	 * This is safe to enable in most circumstances, even though it may
>> +	 * leave the tree in a sub-optimal state.
>>  	 */
>> -	FDT_ASSUME_FRIENDLY	=3D 1 << 2,
>> -};
>> +	ASSUME_NO_ROLLBACK	=3D 1 << 3,
>> =20
>> -/** fdt_chk_basic() - see if basic checking of params and DT data is en=
abled */
>> -static inline bool fdt_chk_basic(void)
>> -{
>> -	return !(FDT_ASSUME_MASK & FDT_ASSUME_SANE);
>> -}
>> +	/*
>> +	 * This assumes that the device tree components appear in a 'convenien=
t'
>> +	 * order, i.e. the memory reservation block first, then the structure
>> +	 * block and finally the string block.
>> +	 *
>> +	 * This order is not specified by the device-tree specification,
>> +	 * but is expected by libfdt. The device-tree compiler always created
>> +	 * device trees with this order.
>> +	 *
>> +	 * This assumption disables a check in fdt_open_into() and removes the
>> +	 * ability to fix the problem there. This is safe if you know that the
>> +	 * device tree is correctly ordered. See fdt_blocks_misordered_().
>> +	 */
>> +	ASSUME_LIBFDT_ORDER	=3D 1 << 4,
>> =20
>> -/** fdt_chk_version() - see if we need to handle old versions of the DT=
 */
>> -static inline bool fdt_chk_version(void)
>> -{
>> -	return !(FDT_ASSUME_MASK & FDT_ASSUME_LATEST);
>> -}
>> +	/*
>> +	 * This assumes that libfdt itself does not have any internal bugs. It
>> +	 * drops certain checks that should never be needed unless libfdt has =
an
>> +	 * undiscovered bug.
>> +	 *
>> +	 * This can generally be considered safe to enable.
>> +	 */
>> +	ASSUME_LIBFDT_FLAWLESS	=3D 1 << 5,
>> +};
>> =20
>> -/** fdt_chk_extra() - see if extra checking is enabled */
>> -static inline bool fdt_chk_extra(void)
>> +/**
>> + * can_assume_() - check if a particular assumption is enabled
>> + *
>> + * @mask: Mask to check (ASSUME_...)
>> + * @return true if that assumption is enabled, else false
>> + */
>> +static inline bool can_assume_(int mask)
>>  {
>> -	return !(FDT_ASSUME_MASK & FDT_ASSUME_FRIENDLY);
>> +	return FDT_ASSUME_MASK & mask;
>>  }
>> =20
>> +/** helper macros for checking assumptions */
>> +#define can_assume(_assume)	can_assume_(ASSUME_ ## _assume)
>> +
>>  #endif /* LIBFDT_INTERNAL_H */
>> diff --git a/scripts/dtc/livetree.c b/scripts/dtc/livetree.c
>> index 4cfc2adccdd..1e121d41a89 100644
>> --- a/scripts/dtc/livetree.c
>> +++ b/scripts/dtc/livetree.c
>> @@ -1,24 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> +#include "srcpos.h"
>> =20
>>  /*
>>   * Tree building functions
>> @@ -50,25 +36,27 @@ void delete_labels(struct label **labels)
>>  		label->deleted =3D 1;
>>  }
>> =20
>> -struct property *build_property(char *name, struct data val)
>> +struct property *build_property(const char *name, struct data val,
>> +				struct srcpos *srcpos)
>>  {
>>  	struct property *new =3D xmalloc(sizeof(*new));
>> =20
>>  	memset(new, 0, sizeof(*new));
>> =20
>> -	new->name =3D name;
>> +	new->name =3D xstrdup(name);
>>  	new->val =3D val;
>> +	new->srcpos =3D srcpos_copy(srcpos);
>> =20
>>  	return new;
>>  }
>> =20
>> -struct property *build_property_delete(char *name)
>> +struct property *build_property_delete(const char *name)
>>  {
>>  	struct property *new =3D xmalloc(sizeof(*new));
>> =20
>>  	memset(new, 0, sizeof(*new));
>> =20
>> -	new->name =3D name;
>> +	new->name =3D xstrdup(name);
>>  	new->deleted =3D 1;
>> =20
>>  	return new;
>> @@ -97,7 +85,8 @@ struct property *reverse_properties(struct property *f=
irst)
>>  	return head;
>>  }
>> =20
>> -struct node *build_node(struct property *proplist, struct node *childre=
n)
>> +struct node *build_node(struct property *proplist, struct node *childre=
n,
>> +			struct srcpos *srcpos)
>>  {
>>  	struct node *new =3D xmalloc(sizeof(*new));
>>  	struct node *child;
>> @@ -106,6 +95,7 @@ struct node *build_node(struct property *proplist, st=
ruct node *children)
>> =20
>>  	new->proplist =3D reverse_properties(proplist);
>>  	new->children =3D children;
>> +	new->srcpos =3D srcpos_copy(srcpos);
>> =20
>>  	for_each_child(new, child) {
>>  		child->parent =3D new;
>> @@ -114,22 +104,23 @@ struct node *build_node(struct property *proplist,=
 struct node *children)
>>  	return new;
>>  }
>> =20
>> -struct node *build_node_delete(void)
>> +struct node *build_node_delete(struct srcpos *srcpos)
>>  {
>>  	struct node *new =3D xmalloc(sizeof(*new));
>> =20
>>  	memset(new, 0, sizeof(*new));
>> =20
>>  	new->deleted =3D 1;
>> +	new->srcpos =3D srcpos_copy(srcpos);
>> =20
>>  	return new;
>>  }
>> =20
>> -struct node *name_node(struct node *node, char *name)
>> +struct node *name_node(struct node *node, const char *name)
>>  {
>>  	assert(node->name =3D=3D NULL);
>> =20
>> -	node->name =3D name;
>> +	node->name =3D xstrdup(name);
>> =20
>>  	return node;
>>  }
>> @@ -183,6 +174,8 @@ struct node *merge_nodes(struct node *old_node, stru=
ct node *new_node)
>> =20
>>  				old_prop->val =3D new_prop->val;
>>  				old_prop->deleted =3D 0;
>> +				srcpos_free(old_prop->srcpos);
>> +				old_prop->srcpos =3D new_prop->srcpos;
>>  				free(new_prop);
>>  				new_prop =3D NULL;
>>  				break;
>> @@ -223,6 +216,8 @@ struct node *merge_nodes(struct node *old_node, stru=
ct node *new_node)
>>  			add_child(old_node, new_child);
>>  	}
>> =20
>> +	old_node->srcpos =3D srcpos_extend(old_node->srcpos, new_node->srcpos)=
;
>> +
>>  	/* The new node contents are now merged into the old node.  Free
>>  	 * the new node. */
>>  	free(new_node);
>> @@ -239,21 +234,23 @@ struct node * add_orphan_node(struct node *dt, str=
uct node *new_node, char *ref)
>>  	char *name;
>> =20
>>  	if (ref[0] =3D=3D '/') {
>> +		d =3D data_add_marker(d, TYPE_STRING, ref);
>>  		d =3D data_append_data(d, ref, strlen(ref) + 1);
>> =20
>> -		p =3D build_property("target-path", d);
>> +		p =3D build_property("target-path", d, NULL);
>>  	} else {
>>  		d =3D data_add_marker(d, REF_PHANDLE, ref);
>>  		d =3D data_append_integer(d, 0xffffffff, 32);
>> =20
>> -		p =3D build_property("target", d);
>> +		p =3D build_property("target", d, NULL);
>>  	}
>> =20
>>  	xasprintf(&name, "fragment@%u",
>>  			next_orphan_fragment++);
>>  	name_node(new_node, "__overlay__");
>> -	node =3D build_node(p, new_node);
>> +	node =3D build_node(p, new_node, NULL);
>>  	name_node(node, name);
>> +	free(name);
>> =20
>>  	add_child(dt, node);
>>  	return dt;
>> @@ -340,18 +337,21 @@ void delete_node(struct node *node)
>>  }
>> =20
>>  void append_to_property(struct node *node,
>> -				    char *name, const void *data, int len)
>> +			char *name, const void *data, int len,
>> +			enum markertype type)
>>  {
>>  	struct data d;
>>  	struct property *p;
>> =20
>>  	p =3D get_property(node, name);
>>  	if (p) {
>> -		d =3D data_append_data(p->val, data, len);
>> +		d =3D data_add_marker(p->val, type, name);
>> +		d =3D data_append_data(d, data, len);
>>  		p->val =3D d;
>>  	} else {
>> -		d =3D data_append_data(empty_data, data, len);
>> -		p =3D build_property(name, d);
>> +		d =3D data_add_marker(empty_data, type, name);
>> +		d =3D data_append_data(d, data, len);
>> +		p =3D build_property(name, d, NULL);
>>  		add_property(node, p);
>>  	}
>>  }
>> @@ -439,9 +439,9 @@ cell_t propval_cell(struct property *prop)
>>  	return fdt32_to_cpu(*((fdt32_t *)prop->val.val));
>>  }
>> =20
>> -cell_t propval_cell_n(struct property *prop, int n)
>> +cell_t propval_cell_n(struct property *prop, unsigned int n)
>>  {
>> -	assert(prop->val.len / sizeof(cell_t) >=3D n);
>> +	assert(prop->val.len / sizeof(cell_t) > n);
>>  	return fdt32_to_cpu(*((fdt32_t *)prop->val.val + n));
>>  }
>> =20
>> @@ -504,7 +504,7 @@ struct node *get_subnode(struct node *node, const ch=
ar *nodename)
>>  	struct node *child;
>> =20
>>  	for_each_child(node, child)
>> -		if (streq(child->name, nodename))
>> +		if (streq(child->name, nodename) && !child->deleted)
>>  			return child;
>> =20
>>  	return NULL;
>> @@ -527,8 +527,7 @@ struct node *get_node_by_path(struct node *tree, con=
st char *path)
>>  	p =3D strchr(path, '/');
>> =20
>>  	for_each_child(tree, child) {
>> -		if (p && (strlen(child->name) =3D=3D p-path) &&
>> -		    strprefixeq(path, p - path, child->name))
>> +		if (p && strprefixeq(path, (size_t)(p - path), child->name))
>>  			return get_node_by_path(child, p+1);
>>  		else if (!p && streq(path, child->name))
>>  			return child;
>> @@ -561,7 +560,7 @@ struct node *get_node_by_phandle(struct node *tree, =
cell_t phandle)
>>  {
>>  	struct node *child, *node;
>> =20
>> -	if ((phandle =3D=3D 0) || (phandle =3D=3D -1)) {
>> +	if (!phandle_is_valid(phandle)) {
>>  		assert(generate_fixups);
>>  		return NULL;
>>  	}
>> @@ -618,11 +617,27 @@ struct node *get_node_by_ref(struct node *tree, co=
nst char *ref)
>>  	return target;
>>  }
>> =20
>> +static void add_phandle_property(struct node *node,
>> +				 const char *name, int format)
>> +{
>> +	struct data d;
>> +
>> +	if (!(phandle_format & format))
>> +		return;
>> +	if (get_property(node, name))
>> +		return;
>> +
>> +	d =3D data_add_marker(empty_data, TYPE_UINT32, NULL);
>> +	d =3D data_append_cell(d, node->phandle);
>> +
>> +	add_property(node, build_property(name, d, NULL));
>> +}
>> +
>>  cell_t get_node_phandle(struct node *root, struct node *node)
>>  {
>>  	static cell_t phandle =3D 1; /* FIXME: ick, static local */
>> =20
>> -	if ((node->phandle !=3D 0) && (node->phandle !=3D -1))
>> +	if (phandle_is_valid(node->phandle))
>>  		return node->phandle;
>> =20
>>  	while (get_node_by_phandle(root, phandle))
>> @@ -630,17 +645,8 @@ cell_t get_node_phandle(struct node *root, struct n=
ode *node)
>> =20
>>  	node->phandle =3D phandle;
>> =20
>> -	if (!get_property(node, "linux,phandle")
>> -	    && (phandle_format & PHANDLE_LEGACY))
>> -		add_property(node,
>> -			     build_property("linux,phandle",
>> -					    data_append_cell(empty_data, phandle)));
>> -
>> -	if (!get_property(node, "phandle")
>> -	    && (phandle_format & PHANDLE_EPAPR))
>> -		add_property(node,
>> -			     build_property("phandle",
>> -					    data_append_cell(empty_data, phandle)));
>> +	add_phandle_property(node, "linux,phandle", PHANDLE_LEGACY);
>> +	add_phandle_property(node, "phandle", PHANDLE_EPAPR);
>> =20
>>  	/* If the node *does* have a phandle property, we must
>>  	 * be dealing with a self-referencing phandle, which will be
>> @@ -809,18 +815,18 @@ void sort_tree(struct dt_info *dti)
>>  }
>> =20
>>  /* utility helper to avoid code duplication */
>> -static struct node *build_and_name_child_node(struct node *parent, char=
 *name)
>> +static struct node *build_and_name_child_node(struct node *parent, cons=
t char *name)
>>  {
>>  	struct node *node;
>> =20
>> -	node =3D build_node(NULL, NULL);
>> -	name_node(node, xstrdup(name));
>> +	node =3D build_node(NULL, NULL, NULL);
>> +	name_node(node, name);
>>  	add_child(parent, node);
>> =20
>>  	return node;
>>  }
>> =20
>> -static struct node *build_root_node(struct node *dt, char *name)
>> +static struct node *build_root_node(struct node *dt, const char *name)
>>  {
>>  	struct node *an;
>> =20
>> @@ -874,8 +880,9 @@ static void generate_label_tree_internal(struct dt_i=
nfo *dti,
>> =20
>>  			/* insert it */
>>  			p =3D build_property(l->label,
>> -				data_copy_mem(node->fullpath,
>> -						strlen(node->fullpath) + 1));
>> +				data_copy_escape_string(node->fullpath,
>> +						strlen(node->fullpath)),
>> +				NULL);
>>  			add_property(an, p);
>>  		}
>> =20
>> @@ -919,13 +926,19 @@ static void add_fixup_entry(struct dt_info *dti, s=
truct node *fn,
>>  	/* m->ref can only be a REF_PHANDLE, but check anyway */
>>  	assert(m->type =3D=3D REF_PHANDLE);
>> =20
>> +	/* The format only permits fixups for references to label, not
>> +	 * references to path */
>> +	if (strchr(m->ref, '/'))
>> +		die("Can't generate fixup for reference to path &{%s}\n",
>> +		    m->ref);
>> +
>>  	/* there shouldn't be any ':' in the arguments */
>>  	if (strchr(node->fullpath, ':') || strchr(prop->name, ':'))
>>  		die("arguments should not contain ':'\n");
>> =20
>>  	xasprintf(&entry, "%s:%s:%u",
>>  			node->fullpath, prop->name, m->offset);
>> -	append_to_property(fn, m->ref, entry, strlen(entry) + 1);
>> +	append_to_property(fn, m->ref, entry, strlen(entry) + 1, TYPE_STRING);
>> =20
>>  	free(entry);
>>  }
>> @@ -985,7 +998,7 @@ static void add_local_fixup_entry(struct dt_info *dt=
i,
>>  	char **compp;
>>  	int i, depth;
>> =20
>> -	/* walk back retreiving depth */
>> +	/* walk back retrieving depth */
>>  	depth =3D 0;
>>  	for (wn =3D node; wn; wn =3D wn->parent)
>>  		depth++;
>> @@ -1000,15 +1013,13 @@ static void add_local_fixup_entry(struct dt_info=
 *dti,
>>  	/* walk the path components creating nodes if they don't exist */
>>  	for (wn =3D lfn, i =3D 1; i < depth; i++, wn =3D nwn) {
>>  		/* if no node exists, create it */
>> -		nwn =3D get_subnode(wn, compp[i]);
>> -		if (!nwn)
>> -			nwn =3D build_and_name_child_node(wn, compp[i]);
>> +		nwn =3D build_root_node(wn, compp[i]);
>>  	}
>> =20
>>  	free(compp);
>> =20
>>  	value_32 =3D cpu_to_fdt32(m->offset);
>> -	append_to_property(wn, prop->name, &value_32, sizeof(value_32));
>> +	append_to_property(wn, prop->name, &value_32, sizeof(value_32), TYPE_U=
INT32);
>>  }
>> =20
>>  static void generate_local_fixups_tree_internal(struct dt_info *dti,
>> @@ -1034,7 +1045,7 @@ static void generate_local_fixups_tree_internal(st=
ruct dt_info *dti,
>>  		generate_local_fixups_tree_internal(dti, lfn, c);
>>  }
>> =20
>> -void generate_label_tree(struct dt_info *dti, char *name, bool allocph)
>> +void generate_label_tree(struct dt_info *dti, const char *name, bool al=
locph)
>>  {
>>  	if (!any_label_tree(dti, dti->dt))
>>  		return;
>> @@ -1042,18 +1053,31 @@ void generate_label_tree(struct dt_info *dti, ch=
ar *name, bool allocph)
>>  				     dti->dt, allocph);
>>  }
>> =20
>> -void generate_fixups_tree(struct dt_info *dti, char *name)
>> +void generate_fixups_tree(struct dt_info *dti, const char *name)
>>  {
>> +	struct node *n =3D get_subnode(dti->dt, name);
>> +
>> +	/* Start with an empty __fixups__ node to not get duplicates */
>> +	if (n)
>> +		n->deleted =3D true;
>> +
>>  	if (!any_fixup_tree(dti, dti->dt))
>>  		return;
>> -	generate_fixups_tree_internal(dti, build_root_node(dti->dt, name),
>> +	generate_fixups_tree_internal(dti,
>> +				      build_and_name_child_node(dti->dt, name),
>>  				      dti->dt);
>>  }
>> =20
>> -void generate_local_fixups_tree(struct dt_info *dti, char *name)
>> +void generate_local_fixups_tree(struct dt_info *dti, const char *name)
>>  {
>> +	struct node *n =3D get_subnode(dti->dt, name);
>> +
>> +	/* Start with an empty __local_fixups__ node to not get duplicates */
>> +	if (n)
>> +		n->deleted =3D true;
>>  	if (!any_local_fixup_tree(dti, dti->dt))
>>  		return;
>> -	generate_local_fixups_tree_internal(dti, build_root_node(dti->dt, name=
),
>> +	generate_local_fixups_tree_internal(dti,
>> +					    build_and_name_child_node(dti->dt, name),
>>  					    dti->dt);
>>  }
>> diff --git a/scripts/dtc/srcpos.c b/scripts/dtc/srcpos.c
>> index 0ad89e2af60..627a0760e6e 100644
>> --- a/scripts/dtc/srcpos.c
>> +++ b/scripts/dtc/srcpos.c
>> @@ -1,23 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>> +#ifndef _GNU_SOURCE
>>  #define _GNU_SOURCE
>> +#endif
>> =20
>>  #include <stdio.h>
>> =20
>> @@ -33,6 +21,10 @@ struct search_path {
>>  /* This is the list of directories that we search for source files */
>>  static struct search_path *search_path_head, **search_path_tail;
>> =20
>> +/* Detect infinite include recursion. */
>> +#define MAX_SRCFILE_DEPTH     (200)
>> +static int srcfile_depth; /* =3D 0 */
>> +
>>  static char *get_dirname(const char *path)
>>  {
>>  	const char *slash =3D strrchr(path, '/');
>> @@ -50,10 +42,51 @@ static char *get_dirname(const char *path)
>> =20
>>  FILE *depfile; /* =3D NULL */
>>  struct srcfile_state *current_srcfile; /* =3D NULL */
>> +static char *initial_path; /* =3D NULL */
>> +static int initial_pathlen; /* =3D 0 */
>> +static bool initial_cpp =3D true;
>> =20
>> -/* Detect infinite include recursion. */
>> -#define MAX_SRCFILE_DEPTH     (100)
>> -static int srcfile_depth; /* =3D 0 */
>> +static void set_initial_path(char *fname)
>> +{
>> +	int i, len =3D strlen(fname);
>> +
>> +	xasprintf(&initial_path, "%s", fname);
>> +	initial_pathlen =3D 0;
>> +	for (i =3D 0; i !=3D len; i++)
>> +		if (initial_path[i] =3D=3D '/')
>> +			initial_pathlen++;
>> +}
>> +
>> +static char *shorten_to_initial_path(char *fname)
>> +{
>> +	char *p1, *p2, *prevslash1 =3D NULL;
>> +	int slashes =3D 0;
>> +
>> +	for (p1 =3D fname, p2 =3D initial_path; *p1 && *p2; p1++, p2++) {
>> +		if (*p1 !=3D *p2)
>> +			break;
>> +		if (*p1 =3D=3D '/') {
>> +			prevslash1 =3D p1;
>> +			slashes++;
>> +		}
>> +	}
>> +	p1 =3D prevslash1 + 1;
>> +	if (prevslash1) {
>> +		int diff =3D initial_pathlen - slashes, i, j;
>> +		int restlen =3D strlen(fname) - (p1 - fname);
>> +		char *res;
>> +
>> +		res =3D xmalloc((3 * diff) + restlen + 1);
>> +		for (i =3D 0, j =3D 0; i !=3D diff; i++) {
>> +			res[j++] =3D '.';
>> +			res[j++] =3D '.';
>> +			res[j++] =3D '/';
>> +		}
>> +		strcpy(res + j, p1);
>> +		return res;
>> +	}
>> +	return NULL;
>> +}
>> =20
>>  /**
>>   * Try to open a file in a given directory.
>> @@ -127,8 +160,10 @@ FILE *srcfile_relative_open(const char *fname, char=
 **fullnamep)
>>  			    strerror(errno));
>>  	}
>> =20
>> -	if (depfile)
>> -		fprintf(depfile, " %s", fullname);
>> +	if (depfile) {
>> +		fputc(' ', depfile);
>> +		fprint_path_escaped(depfile, fullname);
>> +	}
>> =20
>>  	if (fullnamep)
>>  		*fullnamep =3D fullname;
>> @@ -155,6 +190,9 @@ void srcfile_push(const char *fname)
>>  	srcfile->colno =3D 1;
>> =20
>>  	current_srcfile =3D srcfile;
>> +
>> +	if (srcfile_depth =3D=3D 1)
>> +		set_initial_path(srcfile->name);
>>  }
>> =20
>>  bool srcfile_pop(void)
>> @@ -195,18 +233,6 @@ void srcfile_add_search_path(const char *dirname)
>>  	search_path_tail =3D &node->next;
>>  }
>> =20
>> -/*
>> - * The empty source position.
>> - */
>> -
>> -struct srcpos srcpos_empty =3D {
>> -	.first_line =3D 0,
>> -	.first_column =3D 0,
>> -	.last_line =3D 0,
>> -	.last_column =3D 0,
>> -	.file =3D NULL,
>> -};
>> -
>>  void srcpos_update(struct srcpos *pos, const char *text, int len)
>>  {
>>  	int i;
>> @@ -232,13 +258,46 @@ struct srcpos *
>>  srcpos_copy(struct srcpos *pos)
>>  {
>>  	struct srcpos *pos_new;
>> +	struct srcfile_state *srcfile_state;
>> +
>> +	if (!pos)
>> +		return NULL;
>> =20
>>  	pos_new =3D xmalloc(sizeof(struct srcpos));
>> +	assert(pos->next =3D=3D NULL);
>>  	memcpy(pos_new, pos, sizeof(struct srcpos));
>> =20
>> +	/* allocate without free */
>> +	srcfile_state =3D xmalloc(sizeof(struct srcfile_state));
>> +	memcpy(srcfile_state, pos->file, sizeof(struct srcfile_state));
>> +	pos_new->file =3D srcfile_state;
>> +
>>  	return pos_new;
>>  }
>> =20
>> +struct srcpos *srcpos_extend(struct srcpos *pos, struct srcpos *newtail=
)
>> +{
>> +	struct srcpos *p;
>> +
>> +	if (!pos)
>> +		return newtail;
>> +
>> +	for (p =3D pos; p->next !=3D NULL; p =3D p->next);
>> +	p->next =3D newtail;
>> +	return pos;
>> +}
>> +
>> +void srcpos_free(struct srcpos *pos)
>> +{
>> +	struct srcpos *p_next;
>> +
>> +	while (pos) {
>> +		p_next =3D pos->next;
>> +		free(pos);
>> +		pos =3D p_next;
>> +	}
>> +}
>> +
>>  char *
>>  srcpos_string(struct srcpos *pos)
>>  {
>> @@ -263,6 +322,68 @@ srcpos_string(struct srcpos *pos)
>>  	return pos_str;
>>  }
>> =20
>> +static char *
>> +srcpos_string_comment(struct srcpos *pos, bool first_line, int level)
>> +{
>> +	char *pos_str, *fresh_fname =3D NULL, *first, *rest;
>> +	const char *fname;
>> +
>> +	if (!pos) {
>> +		if (level > 1) {
>> +			xasprintf(&pos_str, "<no-file>:<no-line>");
>> +			return pos_str;
>> +		} else {
>> +			return NULL;
>> +		}
>> +	}
>> +
>> +	if (!pos->file)
>> +		fname =3D "<no-file>";
>> +	else if (!pos->file->name)
>> +		fname =3D "<no-filename>";
>> +	else if (level > 1)
>> +		fname =3D pos->file->name;
>> +	else {
>> +		fresh_fname =3D shorten_to_initial_path(pos->file->name);
>> +		if (fresh_fname)
>> +			fname =3D fresh_fname;
>> +		else
>> +			fname =3D pos->file->name;
>> +	}
>> +
>> +	if (level > 1)
>> +		xasprintf(&first, "%s:%d:%d-%d:%d", fname,
>> +			  pos->first_line, pos->first_column,
>> +			  pos->last_line, pos->last_column);
>> +	else
>> +		xasprintf(&first, "%s:%d", fname,
>> +			  first_line ? pos->first_line : pos->last_line);
>> +
>> +	if (fresh_fname)
>> +		free(fresh_fname);
>> +
>> +	if (pos->next !=3D NULL) {
>> +		rest =3D srcpos_string_comment(pos->next, first_line, level);
>> +		xasprintf(&pos_str, "%s, %s", first, rest);
>> +		free(first);
>> +		free(rest);
>> +	} else {
>> +		pos_str =3D first;
>> +	}
>> +
>> +	return pos_str;
>> +}
>> +
>> +char *srcpos_string_first(struct srcpos *pos, int level)
>> +{
>> +	return srcpos_string_comment(pos, true, level);
>> +}
>> +
>> +char *srcpos_string_last(struct srcpos *pos, int level)
>> +{
>> +	return srcpos_string_comment(pos, false, level);
>> +}
>> +
>>  void srcpos_verror(struct srcpos *pos, const char *prefix,
>>  		   const char *fmt, va_list va)
>>  {
>> @@ -291,4 +412,9 @@ void srcpos_set_line(char *f, int l)
>>  {
>>  	current_srcfile->name =3D f;
>>  	current_srcfile->lineno =3D l;
>> +
>> +	if (initial_cpp) {
>> +		initial_cpp =3D false;
>> +		set_initial_path(f);
>> +	}
>>  }
>> diff --git a/scripts/dtc/srcpos.h b/scripts/dtc/srcpos.h
>> index fcd9937a911..0b634f212eb 100644
>> --- a/scripts/dtc/srcpos.h
>> +++ b/scripts/dtc/srcpos.h
>> @@ -1,20 +1,6 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>  /*
>>   * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #ifndef SRCPOS_H
>> @@ -74,6 +60,7 @@ struct srcpos {
>>      int last_line;
>>      int last_column;
>>      struct srcfile_state *file;
>> +    struct srcpos *next;
>>  };
>> =20
>>  #define YYLTYPE struct srcpos
>> @@ -93,18 +80,18 @@ struct srcpos {
>>  				YYRHSLOC(Rhs, 0).last_column;			\
>>  			(Current).file =3D YYRHSLOC (Rhs, 0).file;		\
>>  		}								\
>> +		(Current).next =3D NULL;						\
>>  	} while (0)
>> =20
>> -/*
>> - * Fictional source position used for IR nodes that are
>> - * created without otherwise knowing a true source position.
>> - * For example,constant definitions from the command line.
>> - */
>> -extern struct srcpos srcpos_empty;
>> -
>>  extern void srcpos_update(struct srcpos *pos, const char *text, int len=
);
>>  extern struct srcpos *srcpos_copy(struct srcpos *pos);
>> +extern struct srcpos *srcpos_extend(struct srcpos *new_srcpos,
>> +				    struct srcpos *old_srcpos);
>> +extern void srcpos_free(struct srcpos *pos);
>>  extern char *srcpos_string(struct srcpos *pos);
>> +extern char *srcpos_string_first(struct srcpos *pos, int level);
>> +extern char *srcpos_string_last(struct srcpos *pos, int level);
>> +
>> =20
>>  extern void PRINTF(3, 0) srcpos_verror(struct srcpos *pos, const char *=
prefix,
>>  					const char *fmt, va_list va);
>> diff --git a/scripts/dtc/treesource.c b/scripts/dtc/treesource.c
>> index 8c8b914698d..d25f01fc693 100644
>> --- a/scripts/dtc/treesource.c
>> +++ b/scripts/dtc/treesource.c
>> @@ -1,21 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> - *
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include "dtc.h"
>> @@ -61,24 +46,18 @@ static bool isstring(char c)
>>  		|| strchr("\a\b\t\n\v\f\r", c));
>>  }
>> =20
>> -static void write_propval_string(FILE *f, struct data val)
>> +static void write_propval_string(FILE *f, const char *s, size_t len)
>>  {
>> -	const char *str =3D val.val;
>> -	int i;
>> -	struct marker *m =3D val.markers;
>> -
>> -	assert(str[val.len-1] =3D=3D '\0');
>> +	const char *end =3D s + len - 1;
>> =20
>> -	while (m && (m->offset =3D=3D 0)) {
>> -		if (m->type =3D=3D LABEL)
>> -			fprintf(f, "%s: ", m->ref);
>> -		m =3D m->next;
>> -	}
>> -	fprintf(f, "\"");
>> +	if (!len)
>> +		return;
>> =20
>> -	for (i =3D 0; i < (val.len-1); i++) {
>> -		char c =3D str[i];
>> +	assert(*end =3D=3D '\0');
>> =20
>> +	fprintf(f, "\"");
>> +	while (s < end) {
>> +		char c =3D *s++;
>>  		switch (c) {
>>  		case '\a':
>>  			fprintf(f, "\\a");
>> @@ -108,91 +87,103 @@ static void write_propval_string(FILE *f, struct d=
ata val)
>>  			fprintf(f, "\\\"");
>>  			break;
>>  		case '\0':
>> -			fprintf(f, "\", ");
>> -			while (m && (m->offset <=3D (i + 1))) {
>> -				if (m->type =3D=3D LABEL) {
>> -					assert(m->offset =3D=3D (i+1));
>> -					fprintf(f, "%s: ", m->ref);
>> -				}
>> -				m =3D m->next;
>> -			}
>> -			fprintf(f, "\"");
>> +			fprintf(f, "\\0");
>>  			break;
>>  		default:
>>  			if (isprint((unsigned char)c))
>>  				fprintf(f, "%c", c);
>>  			else
>> -				fprintf(f, "\\x%02hhx", c);
>> +				fprintf(f, "\\x%02"PRIx8, c);
>>  		}
>>  	}
>>  	fprintf(f, "\"");
>> -
>> -	/* Wrap up any labels at the end of the value */
>> -	for_each_marker_of_type(m, LABEL) {
>> -		assert (m->offset =3D=3D val.len);
>> -		fprintf(f, " %s:", m->ref);
>> -	}
>>  }
>> =20
>> -static void write_propval_cells(FILE *f, struct data val)
>> +static void write_propval_int(FILE *f, const char *p, size_t len, size_=
t width)
>>  {
>> -	void *propend =3D val.val + val.len;
>> -	fdt32_t *cp =3D (fdt32_t *)val.val;
>> -	struct marker *m =3D val.markers;
>> -
>> -	fprintf(f, "<");
>> -	for (;;) {
>> -		while (m && (m->offset <=3D ((char *)cp - val.val))) {
>> -			if (m->type =3D=3D LABEL) {
>> -				assert(m->offset =3D=3D ((char *)cp - val.val));
>> -				fprintf(f, "%s: ", m->ref);
>> -			}
>> -			m =3D m->next;
>> -		}
>> +	const char *end =3D p + len;
>> +	assert(len % width =3D=3D 0);
>> =20
>> -		fprintf(f, "0x%x", fdt32_to_cpu(*cp++));
>> -		if ((void *)cp >=3D propend)
>> +	for (; p < end; p +=3D width) {
>> +		switch (width) {
>> +		case 1:
>> +			fprintf(f, "%02"PRIx8, *(const uint8_t*)p);
>>  			break;
>> -		fprintf(f, " ");
>> -	}
>> -
>> -	/* Wrap up any labels at the end of the value */
>> -	for_each_marker_of_type(m, LABEL) {
>> -		assert (m->offset =3D=3D val.len);
>> -		fprintf(f, " %s:", m->ref);
>> +		case 2:
>> +			fprintf(f, "0x%02"PRIx16, dtb_ld16(p));
>> +			break;
>> +		case 4:
>> +			fprintf(f, "0x%02"PRIx32, dtb_ld32(p));
>> +			break;
>> +		case 8:
>> +			fprintf(f, "0x%02"PRIx64, dtb_ld64(p));
>> +			break;
>> +		}
>> +		if (p + width < end)
>> +			fputc(' ', f);
>>  	}
>> -	fprintf(f, ">");
>>  }
>> =20
>> -static void write_propval_bytes(FILE *f, struct data val)
>> +static const char *delim_start[] =3D {
>> +	[TYPE_UINT8] =3D "[",
>> +	[TYPE_UINT16] =3D "/bits/ 16 <",
>> +	[TYPE_UINT32] =3D "<",
>> +	[TYPE_UINT64] =3D "/bits/ 64 <",
>> +	[TYPE_STRING] =3D "",
>> +};
>> +static const char *delim_end[] =3D {
>> +	[TYPE_UINT8] =3D "]",
>> +	[TYPE_UINT16] =3D ">",
>> +	[TYPE_UINT32] =3D ">",
>> +	[TYPE_UINT64] =3D ">",
>> +	[TYPE_STRING] =3D "",
>> +};
>> +
>> +/*
>> + * The invariants in the marker list are:
>> + *  - offsets are non-strictly monotonically increasing
>> + *  - for a single offset there is at most one type marker
>> + *  - for a single offset that has both a type marker and non-type mark=
ers, the
>> + *    type marker appears before the others.
>> + */
>> +static struct marker **add_marker(struct marker **mi,
>> +				  enum markertype type, unsigned int offset, char *ref)
>>  {
>> -	void *propend =3D val.val + val.len;
>> -	const char *bp =3D val.val;
>> -	struct marker *m =3D val.markers;
>> -
>> -	fprintf(f, "[");
>> -	for (;;) {
>> -		while (m && (m->offset =3D=3D (bp-val.val))) {
>> -			if (m->type =3D=3D LABEL)
>> -				fprintf(f, "%s: ", m->ref);
>> -			m =3D m->next;
>> -		}
>> +	struct marker *nm;
>> =20
>> -		fprintf(f, "%02hhx", (unsigned char)(*bp++));
>> -		if ((const void *)bp >=3D propend)
>> -			break;
>> -		fprintf(f, " ");
>> -	}
>> +	while (*mi && (*mi)->offset < offset)
>> +		mi =3D &(*mi)->next;
>> =20
>> -	/* Wrap up any labels at the end of the value */
>> -	for_each_marker_of_type(m, LABEL) {
>> -		assert (m->offset =3D=3D val.len);
>> -		fprintf(f, " %s:", m->ref);
>> +	if (*mi && (*mi)->offset =3D=3D offset && is_type_marker((*mi)->type))=
 {
>> +		if (is_type_marker(type))
>> +			return mi;
>> +		mi =3D &(*mi)->next;
>>  	}
>> -	fprintf(f, "]");
>> +
>> +	if (*mi && (*mi)->offset =3D=3D offset && type =3D=3D (*mi)->type)
>> +		return mi;
>> +
>> +	nm =3D xmalloc(sizeof(*nm));
>> +	nm->type =3D type;
>> +	nm->offset =3D offset;
>> +	nm->ref =3D ref;
>> +	nm->next =3D *mi;
>> +	*mi =3D nm;
>> +
>> +	return &nm->next;
>>  }
>> =20
>> -static void write_propval(FILE *f, struct property *prop)
>> +static void add_string_markers(struct property *prop)
>> +{
>> +	int l, len =3D prop->val.len;
>> +	const char *p =3D prop->val.val;
>> +	struct marker **mi =3D &prop->val.markers;
>> +
>> +	for (l =3D strlen(p) + 1; l < len; l +=3D strlen(p + l) + 1)
>> +		mi =3D add_marker(mi, TYPE_STRING, l, NULL);
>> +}
>> +
>> +static enum markertype guess_value_type(struct property *prop)
>>  {
>>  	int len =3D prop->val.len;
>>  	const char *p =3D prop->val.val;
>> @@ -201,11 +192,6 @@ static void write_propval(FILE *f, struct property =
*prop)
>>  	int nnotstringlbl =3D 0, nnotcelllbl =3D 0;
>>  	int i;
>> =20
>> -	if (len =3D=3D 0) {
>> -		fprintf(f, ";\n");
>> -		return;
>> -	}
>> -
>>  	for (i =3D 0; i < len; i++) {
>>  		if (! isstring(p[i]))
>>  			nnotstring++;
>> @@ -220,17 +206,116 @@ static void write_propval(FILE *f, struct propert=
y *prop)
>>  			nnotcelllbl++;
>>  	}
>> =20
>> -	fprintf(f, " =3D ");
>> -	if ((p[len-1] =3D=3D '\0') && (nnotstring =3D=3D 0) && (nnul < (len-nn=
ul))
>> +	if ((p[len-1] =3D=3D '\0') && (nnotstring =3D=3D 0) && (nnul <=3D (len=
-nnul))
>>  	    && (nnotstringlbl =3D=3D 0)) {
>> -		write_propval_string(f, prop->val);
>> +		if (nnul > 1)
>> +			add_string_markers(prop);
>> +		return TYPE_STRING;
>>  	} else if (((len % sizeof(cell_t)) =3D=3D 0) && (nnotcelllbl =3D=3D 0)=
) {
>> -		write_propval_cells(f, prop->val);
>> -	} else {
>> -		write_propval_bytes(f, prop->val);
>> +		return TYPE_UINT32;
>>  	}
>> =20
>> -	fprintf(f, ";\n");
>> +	return TYPE_UINT8;
>> +}
>> +
>> +static void write_propval(FILE *f, struct property *prop)
>> +{
>> +	size_t len =3D prop->val.len;
>> +	struct marker *m =3D prop->val.markers;
>> +	struct marker dummy_marker;
>> +	enum markertype emit_type =3D TYPE_NONE;
>> +	char *srcstr;
>> +
>> +	if (len =3D=3D 0) {
>> +		fprintf(f, ";");
>> +		if (annotate) {
>> +			srcstr =3D srcpos_string_first(prop->srcpos, annotate);
>> +			if (srcstr) {
>> +				fprintf(f, " /* %s */", srcstr);
>> +				free(srcstr);
>> +			}
>> +		}
>> +		fprintf(f, "\n");
>> +		return;
>> +	}
>> +
>> +	fprintf(f, " =3D");
>> +
>> +	if (!next_type_marker(m)) {
>> +		/* data type information missing, need to guess */
>> +		dummy_marker.type =3D guess_value_type(prop);
>> +		dummy_marker.next =3D prop->val.markers;
>> +		dummy_marker.offset =3D 0;
>> +		dummy_marker.ref =3D NULL;
>> +		m =3D &dummy_marker;
>> +	}
>> +
>> +	for_each_marker(m) {
>> +		size_t chunk_len =3D (m->next ? m->next->offset : len) - m->offset;
>> +		size_t data_len =3D type_marker_length(m) ? : len - m->offset;
>> +		const char *p =3D &prop->val.val[m->offset];
>> +		struct marker *m_phandle;
>> +
>> +		if (is_type_marker(m->type)) {
>> +			emit_type =3D m->type;
>> +			fprintf(f, " %s", delim_start[emit_type]);
>> +		} else if (m->type =3D=3D LABEL)
>> +			fprintf(f, " %s:", m->ref);
>> +
>> +		if (emit_type =3D=3D TYPE_NONE || chunk_len =3D=3D 0)
>> +			continue;
>> +
>> +		switch(emit_type) {
>> +		case TYPE_UINT16:
>> +			write_propval_int(f, p, chunk_len, 2);
>> +			break;
>> +		case TYPE_UINT32:
>> +			m_phandle =3D prop->val.markers;
>> +			for_each_marker_of_type(m_phandle, REF_PHANDLE)
>> +				if (m->offset =3D=3D m_phandle->offset)
>> +					break;
>> +
>> +			if (m_phandle) {
>> +				if (m_phandle->ref[0] =3D=3D '/')
>> +					fprintf(f, "&{%s}", m_phandle->ref);
>> +				else
>> +					fprintf(f, "&%s", m_phandle->ref);
>> +				if (chunk_len > 4) {
>> +					fputc(' ', f);
>> +					write_propval_int(f, p + 4, chunk_len - 4, 4);
>> +				}
>> +			} else {
>> +				write_propval_int(f, p, chunk_len, 4);
>> +			}
>> +			if (data_len > chunk_len)
>> +				fputc(' ', f);
>> +			break;
>> +		case TYPE_UINT64:
>> +			write_propval_int(f, p, chunk_len, 8);
>> +			break;
>> +		case TYPE_STRING:
>> +			write_propval_string(f, p, chunk_len);
>> +			break;
>> +		default:
>> +			write_propval_int(f, p, chunk_len, 1);
>> +		}
>> +
>> +		if (chunk_len =3D=3D data_len) {
>> +			size_t pos =3D m->offset + chunk_len;
>> +			fprintf(f, pos =3D=3D len ? "%s" : "%s,",
>> +			        delim_end[emit_type] ? : "");
>> +			emit_type =3D TYPE_NONE;
>> +		}
>> +	}
>> +	fprintf(f, ";");
>> +	if (annotate) {
>> +		srcstr =3D srcpos_string_first(prop->srcpos, annotate);
>> +		if (srcstr) {
>> +			fprintf(f, " /* %s */", srcstr);
>> +			free(srcstr);
>> +		}
>> +	}
>> +	fprintf(f, "\n");
>>  }
>> =20
>>  static void write_tree_source_node(FILE *f, struct node *tree, int leve=
l)
>> @@ -238,14 +323,24 @@ static void write_tree_source_node(FILE *f, struct=
 node *tree, int level)
>>  	struct property *prop;
>>  	struct node *child;
>>  	struct label *l;
>> +	char *srcstr;
>> =20
>>  	write_prefix(f, level);
>>  	for_each_label(tree->labels, l)
>>  		fprintf(f, "%s: ", l->label);
>>  	if (tree->name && (*tree->name))
>> -		fprintf(f, "%s {\n", tree->name);
>> +		fprintf(f, "%s {", tree->name);
>>  	else
>> -		fprintf(f, "/ {\n");
>> +		fprintf(f, "/ {");
>> +
>> +	if (annotate) {
>> +		srcstr =3D srcpos_string_first(tree->srcpos, annotate);
>> +		if (srcstr) {
>> +			fprintf(f, " /* %s */", srcstr);
>> +			free(srcstr);
>> +		}
>> +	}
>> +	fprintf(f, "\n");
>> =20
>>  	for_each_property(tree, prop) {
>>  		write_prefix(f, level+1);
>> @@ -259,7 +354,15 @@ static void write_tree_source_node(FILE *f, struct =
node *tree, int level)
>>  		write_tree_source_node(f, child, level+1);
>>  	}
>>  	write_prefix(f, level);
>> -	fprintf(f, "};\n");
>> +	fprintf(f, "};");
>> +	if (annotate) {
>> +		srcstr =3D srcpos_string_last(tree->srcpos, annotate);
>> +		if (srcstr) {
>> +			fprintf(f, " /* %s */", srcstr);
>> +			free(srcstr);
>> +		}
>> +	}
>> +	fprintf(f, "\n");
>>  }
>> =20
>>  void dt_to_source(FILE *f, struct dt_info *dti)
>> diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-s=
ource.sh
>> index 1a009fd195d..32ff17ffd08 100755
>> --- a/scripts/dtc/update-dtc-source.sh
>> +++ b/scripts/dtc/update-dtc-source.sh
>> @@ -32,11 +32,12 @@ DTC_UPSTREAM_PATH=3D`pwd`/../dtc
>>  DTC_LINUX_PATH=3D`pwd`/scripts/dtc
>> =20
>>  DTC_SOURCE=3D"checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.=
c srcpos.c \
>> -		srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \
>> +		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
>>  		dtc-lexer.l dtc-parser.y"
>> -LIBFDT_SOURCE=3D"Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_=
tree.c \
>> +LIBFDT_SOURCE=3D"fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
>>  		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
>>  		fdt_wip.c libfdt.h libfdt_env.h libfdt_internal.h"
>> +FDTOVERLAY_SOURCE=3Dfdtoverlay.c
>> =20
>>  get_last_dtc_version() {
>>  	git log --oneline scripts/dtc/ | grep 'upstream' | head -1 | sed -e 's=
/^.* \(.*\)/\1/'
>> @@ -54,7 +55,7 @@ dtc_log=3D$(git log --oneline ${last_dtc_ver}..)
>> =20
>>  # Copy the files into the Linux tree
>>  cd $DTC_LINUX_PATH
>> -for f in $DTC_SOURCE; do
>> +for f in $DTC_SOURCE $FDTOVERLAY_SOURCE; do
>>  	cp ${DTC_UPSTREAM_PATH}/${f} ${f}
>>  	git add ${f}
>>  done
>> diff --git a/scripts/dtc/util.c b/scripts/dtc/util.c
>> index 25d4db1e8c2..0e19a9f8acf 100644
>> --- a/scripts/dtc/util.c
>> +++ b/scripts/dtc/util.c
>> @@ -1,24 +1,10 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>>   * Copyright 2011 The Chromium Authors, All Rights Reserved.
>>   * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
>>   *
>>   * util_is_printable_string contributed by
>>   *	Pantelis Antoniou <pantelis.antoniou AT gmail.com>
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #include <ctype.h>
>> @@ -27,6 +13,7 @@
>>  #include <stdarg.h>
>>  #include <string.h>
>>  #include <assert.h>
>> +#include <inttypes.h>
>> =20
>>  #include <errno.h>
>>  #include <fcntl.h>
>> @@ -36,6 +23,22 @@
>>  #include "util.h"
>>  #include "version_gen.h"
>> =20
>> +void fprint_path_escaped(FILE *fp, const char *path)
>> +{
>> +	const char *p =3D path;
>> +
>> +	while (*p) {
>> +		if (*p =3D=3D ' ') {
>> +			fputc('\\', fp);
>> +			fputc(' ', fp);
>> +		} else {
>> +			fputc(*p, fp);
>> +		}
>> +
>> +		p++;
>> +	}
>> +}
>> +
>>  char *xstrdup(const char *s)
>>  {
>>  	int len =3D strlen(s) + 1;
>> @@ -57,36 +60,54 @@ char *xstrndup(const char *s, size_t n)
>>  	return d;
>>  }
>> =20
>> -/* based in part from (3) vsnprintf */
>> -int xasprintf(char **strp, const char *fmt, ...)
>> +int xavsprintf_append(char **strp, const char *fmt, va_list ap)
>>  {
>> -	int n, size =3D 128;	/* start with 128 bytes */
>> +	int n, size =3D 0;	/* start with 128 bytes */
>>  	char *p;
>> -	va_list ap;
>> +	va_list ap_copy;
>> =20
>> -	/* initial pointer is NULL making the fist realloc to be malloc */
>> -	p =3D NULL;
>> -	while (1) {
>> -		p =3D xrealloc(p, size);
>> +	p =3D *strp;
>> +	if (p)
>> +		size =3D strlen(p);
>> =20
>> -		/* Try to print in the allocated space. */
>> -		va_start(ap, fmt);
>> -		n =3D vsnprintf(p, size, fmt, ap);
>> -		va_end(ap);
>> +	va_copy(ap_copy, ap);
>> +	n =3D vsnprintf(NULL, 0, fmt, ap_copy) + 1;
>> +	va_end(ap_copy);
>> +
>> +	p =3D xrealloc(p, size + n);
>> +
>> +	n =3D vsnprintf(p + size, n, fmt, ap);
>> =20
>> -		/* If that worked, return the string. */
>> -		if (n > -1 && n < size)
>> -			break;
>> -		/* Else try again with more space. */
>> -		if (n > -1)	/* glibc 2.1 */
>> -			size =3D n + 1; /* precisely what is needed */
>> -		else		/* glibc 2.0 */
>> -			size *=3D 2; /* twice the old size */
>> -	}
>>  	*strp =3D p;
>>  	return strlen(p);
>>  }
>> =20
>> +int xasprintf_append(char **strp, const char *fmt, ...)
>> +{
>> +	int n;
>> +	va_list ap;
>> +
>> +	va_start(ap, fmt);
>> +	n =3D xavsprintf_append(strp, fmt, ap);
>> +	va_end(ap);
>> +
>> +	return n;
>> +}
>> +
>> +int xasprintf(char **strp, const char *fmt, ...)
>> +{
>> +	int n;
>> +	va_list ap;
>> +
>> +	*strp =3D NULL;
>> +
>> +	va_start(ap, fmt);
>> +	n =3D xavsprintf_append(strp, fmt, ap);
>> +	va_end(ap);
>> +
>> +	return n;
>> +}
>> +
>>  char *join_path(const char *path, const char *name)
>>  {
>>  	int lenp =3D strlen(path);
>> @@ -238,11 +259,11 @@ char get_escape_char(const char *s, int *i)
>>  	return val;
>>  }
>> =20
>> -int utilfdt_read_err_len(const char *filename, char **buffp, off_t *len=
)
>> +int utilfdt_read_err(const char *filename, char **buffp, size_t *len)
>>  {
>>  	int fd =3D 0;	/* assume stdin */
>>  	char *buf =3D NULL;
>> -	off_t bufsize =3D 1024, offset =3D 0;
>> +	size_t bufsize =3D 1024, offset =3D 0;
>>  	int ret =3D 0;
>> =20
>>  	*buffp =3D NULL;
>> @@ -275,20 +296,15 @@ int utilfdt_read_err_len(const char *filename, cha=
r **buffp, off_t *len)
>>  		free(buf);
>>  	else
>>  		*buffp =3D buf;
>> -	*len =3D bufsize;
>> +	if (len)
>> +		*len =3D bufsize;
>>  	return ret;
>>  }
>> =20
>> -int utilfdt_read_err(const char *filename, char **buffp)
>> -{
>> -	off_t len;
>> -	return utilfdt_read_err_len(filename, buffp, &len);
>> -}
>> -
>> -char *utilfdt_read_len(const char *filename, off_t *len)
>> +char *utilfdt_read(const char *filename, size_t *len)
>>  {
>>  	char *buff;
>> -	int ret =3D utilfdt_read_err_len(filename, &buff, len);
>> +	int ret =3D utilfdt_read_err(filename, &buff, len);
>> =20
>>  	if (ret) {
>>  		fprintf(stderr, "Couldn't open blob from '%s': %s\n", filename,
>> @@ -299,12 +315,6 @@ char *utilfdt_read_len(const char *filename, off_t =
*len)
>>  	return buff;
>>  }
>> =20
>> -char *utilfdt_read(const char *filename)
>> -{
>> -	off_t len;
>> -	return utilfdt_read_len(filename, &len);
>> -}
>> -
>>  int utilfdt_write_err(const char *filename, const void *blob)
>>  {
>>  	int fd =3D 1;	/* assume stdout */
>> @@ -369,11 +379,11 @@ int utilfdt_decode_type(const char *fmt, int *type=
, int *size)
>>  	}
>> =20
>>  	/* we should now have a type */
>> -	if ((*fmt =3D=3D '\0') || !strchr("iuxs", *fmt))
>> +	if ((*fmt =3D=3D '\0') || !strchr("iuxsr", *fmt))
>>  		return -1;
>> =20
>>  	/* convert qualifier (bhL) to byte size */
>> -	if (*fmt !=3D 's')
>> +	if (*fmt !=3D 's' && *fmt !=3D 'r')
>>  		*size =3D qualifier =3D=3D 'b' ? 1 :
>>  				qualifier =3D=3D 'h' ? 2 :
>>  				qualifier =3D=3D 'l' ? 4 : -1;
>> @@ -410,7 +420,7 @@ void utilfdt_print_data(const char *data, int len)
>> =20
>>  		printf(" =3D <");
>>  		for (i =3D 0, len /=3D 4; i < len; i++)
>> -			printf("0x%08x%s", fdt32_to_cpu(cell[i]),
>> +			printf("0x%08" PRIx32 "%s", fdt32_to_cpu(cell[i]),
>>  			       i < (len - 1) ? " " : "");
>>  		printf(">");
>>  	} else {
>> diff --git a/scripts/dtc/util.h b/scripts/dtc/util.h
>> index 23e32962385..2d63a9a9d8d 100644
>> --- a/scripts/dtc/util.h
>> +++ b/scripts/dtc/util.h
>> @@ -1,6 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>  #ifndef UTIL_H
>>  #define UTIL_H
>> =20
>> +#include <stdlib.h>
>>  #include <stdarg.h>
>>  #include <stdbool.h>
>>  #include <getopt.h>
>> @@ -8,25 +10,16 @@
>>  /*
>>   * Copyright 2011 The Chromium Authors, All Rights Reserved.
>>   * Copyright 2008 Jon Loeliger, Freescale Semiconductor, Inc.
>> - *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of the GNU General Public License as
>> - * published by the Free Software Foundation; either version 2 of the
>> - * License, or (at your option) any later version.
>> - *
>> - *  This program is distributed in the hope that it will be useful,
>> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> - *  General Public License for more details.
>> - *
>> - *  You should have received a copy of the GNU General Public License
>> - *  along with this program; if not, write to the Free Software
>> - *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
>> - *                                                                   US=
A
>>   */
>> =20
>>  #ifdef __GNUC__
>> +#ifdef __MINGW_PRINTF_FORMAT
>> +#define PRINTF(i, j)	__attribute__((format (__MINGW_PRINTF_FORMAT, i, j=
)))
>> +#elif __GNUC__ >=3D 5 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 4)
>> +#define PRINTF(i, j)	__attribute__((format (gnu_printf, i, j)))
>> +#else
>>  #define PRINTF(i, j)	__attribute__((format (printf, i, j)))
>> +#endif
>>  #define NORETURN	__attribute__((noreturn))
>>  #else
>>  #define PRINTF(i, j)
>> @@ -49,6 +42,11 @@ static inline void NORETURN PRINTF(1, 2) die(const ch=
ar *str, ...)
>>  	exit(1);
>>  }
>> =20
>> +/**
>> + * Writes path to fp, escaping spaces with a backslash.
>> + */
>> +void fprint_path_escaped(FILE *fp, const char *path);
>> +
>>  static inline void *xmalloc(size_t len)
>>  {
>>  	void *new =3D malloc(len);
>> @@ -73,6 +71,8 @@ extern char *xstrdup(const char *s);
>>  extern char *xstrndup(const char *s, size_t len);
>> =20
>>  extern int PRINTF(2, 3) xasprintf(char **strp, const char *fmt, ...);
>> +extern int PRINTF(2, 3) xasprintf_append(char **strp, const char *fmt, =
...);
>> +extern int PRINTF(2, 0) xavsprintf_append(char **strp, const char *fmt,=
 va_list ap);
>>  extern char *join_path(const char *path, const char *name);
>> =20
>>  /**
>> @@ -99,16 +99,10 @@ char get_escape_char(const char *s, int *i);
>>   * stderr.
>>   *
>>   * @param filename	The filename to read, or - for stdin
>> - * Return: Pointer to allocated buffer containing fdt, or NULL on error
>> - */
>> -char *utilfdt_read(const char *filename);
>> -
>> -/**
>> - * Like utilfdt_read(), but also passes back the size of the file read.
>> - *
>>   * @param len		If non-NULL, the amount of data we managed to read
>> + * @return Pointer to allocated buffer containing fdt, or NULL on error
>>   */
>> -char *utilfdt_read_len(const char *filename, off_t *len);
>> +char *utilfdt_read(const char *filename, size_t *len);
>> =20
>>  /**
>>   * Read a device tree file into a buffer. Does not report errors, but o=
nly
>> @@ -117,24 +111,18 @@ char *utilfdt_read_len(const char *filename, off_t=
 *len);
>>   *
>>   * @param filename	The filename to read, or - for stdin
>>   * @param buffp		Returns pointer to buffer containing fdt
>> - * Return: 0 if ok, else an errno value representing the error
>> - */
>> -int utilfdt_read_err(const char *filename, char **buffp);
>> -
>> -/**
>> - * Like utilfdt_read_err(), but also passes back the size of the file r=
ead.
>> - *
>>   * @param len		If non-NULL, the amount of data we managed to read
>> + * @return 0 if ok, else an errno value representing the error
>>   */
>> -int utilfdt_read_err_len(const char *filename, char **buffp, off_t *len=
);
>> +int utilfdt_read_err(const char *filename, char **buffp, size_t *len);
>> =20
>>  /**
>>   * Write a device tree buffer to a file. This will report any errors on
>>   * stderr.
>>   *
>>   * @param filename	The filename to write, or - for stdout
>> - * @param blob		Poiner to buffer containing fdt
>> - * Return: 0 if ok, -1 on error
>> + * @param blob		Pointer to buffer containing fdt
>> + * @return 0 if ok, -1 on error
>>   */
>>  int utilfdt_write(const char *filename, const void *blob);
>> =20
>> @@ -144,8 +132,8 @@ int utilfdt_write(const char *filename, const void *=
blob);
>>   * an error message for the user.
>>   *
>>   * @param filename	The filename to write, or - for stdout
>> - * @param blob		Poiner to buffer containing fdt
>> - * Return: 0 if ok, else an errno value representing the error
>> + * @param blob		Pointer to buffer containing fdt
>> + * @return 0 if ok, else an errno value representing the error
>>   */
>>  int utilfdt_write_err(const char *filename, const void *blob);
>> =20
>> @@ -163,6 +151,7 @@ int utilfdt_write_err(const char *filename, const vo=
id *blob);
>>   *		i	signed integer
>>   *		u	unsigned integer
>>   *		x	hex
>> + *		r	raw
>>   *
>>   * TODO: Implement ll modifier (8 bytes)
>>   * TODO: Implement o type (octal)
>> @@ -180,7 +169,7 @@ int utilfdt_decode_type(const char *fmt, int *type, =
int *size);
>>   */
>> =20
>>  #define USAGE_TYPE_MSG \
>> -	"<type>\ts=3Dstring, i=3Dint, u=3Dunsigned, x=3Dhex\n" \
>> +	"<type>\ts=3Dstring, i=3Dint, u=3Dunsigned, x=3Dhex, r=3Draw\n" \
>>  	"\tOptional modifier prefix:\n" \
>>  	"\t\thh or b=3Dbyte, h=3D2 byte, l=3D4 byte (default)";
>> =20
>> diff --git a/scripts/dtc/version_gen.h b/scripts/dtc/version_gen.h
>> index b00f14ff7a1..226c48bf75d 100644
>> --- a/scripts/dtc/version_gen.h
>> +++ b/scripts/dtc/version_gen.h
>> @@ -1 +1 @@
>> -#define DTC_VERSION "DTC 1.4.6-g84e414b0"
>> +#define DTC_VERSION "DTC 1.7.2-g52f07dcc"
>> diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
>> new file mode 100644
>> index 00000000000..55908c829c9
>> --- /dev/null
>> +++ b/scripts/dtc/yamltree.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * (C) Copyright Linaro, Ltd. 2018
>> + * (C) Copyright Arm Holdings.  2017
>> + * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005=
.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include <yaml.h>
>> +#include "dtc.h"
>> +#include "srcpos.h"
>> +
>> +char *yaml_error_name[] =3D {
>> +	[YAML_NO_ERROR] =3D "no error",
>> +	[YAML_MEMORY_ERROR] =3D "memory error",
>> +	[YAML_READER_ERROR] =3D "reader error",
>> +	[YAML_SCANNER_ERROR] =3D "scanner error",
>> +	[YAML_PARSER_ERROR] =3D "parser error",
>> +	[YAML_COMPOSER_ERROR] =3D "composer error",
>> +	[YAML_WRITER_ERROR] =3D "writer error",
>> +	[YAML_EMITTER_ERROR] =3D "emitter error",
>> +};
>> +
>> +#define yaml_emitter_emit_or_die(emitter, event) (			\
>> +{									\
>> +	if (!yaml_emitter_emit(emitter, event))				\
>> +		die("yaml '%s': %s in %s, line %i\n",			\
>> +		    yaml_error_name[(emitter)->error], 			\
>> +		    (emitter)->problem, __func__, __LINE__);		\
>> +})
>> +
>> +static void yaml_propval_int(yaml_emitter_t *emitter, struct marker *ma=
rkers,
>> +	char *data, unsigned int seq_offset, unsigned int len, int width)
>> +{
>> +	yaml_event_t event;
>> +	void *tag;
>> +	unsigned int off;
>> +
>> +	switch(width) {
>> +		case 1: tag =3D "!u8"; break;
>> +		case 2: tag =3D "!u16"; break;
>> +		case 4: tag =3D "!u32"; break;
>> +		case 8: tag =3D "!u64"; break;
>> +		default:
>> +			die("Invalid width %i", width);
>> +	}
>> +	assert(len % width =3D=3D 0);
>> +
>> +	yaml_sequence_start_event_initialize(&event, NULL,
>> +		(yaml_char_t *)tag, width =3D=3D 4, YAML_FLOW_SEQUENCE_STYLE);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +
>> +	for (off =3D 0; off < len; off +=3D width) {
>> +		char buf[32];
>> +		struct marker *m;
>> +		bool is_phandle =3D false;
>> +
>> +		switch(width) {
>> +		case 1:
>> +			sprintf(buf, "0x%"PRIx8, *(uint8_t*)(data + off));
>> +			break;
>> +		case 2:
>> +			sprintf(buf, "0x%"PRIx16, dtb_ld16(data + off));
>> +			break;
>> +		case 4:
>> +			sprintf(buf, "0x%"PRIx32, dtb_ld32(data + off));
>> +			m =3D markers;
>> +			is_phandle =3D false;
>> +			for_each_marker_of_type(m, REF_PHANDLE) {
>> +				if (m->offset =3D=3D (seq_offset + off)) {
>> +					is_phandle =3D true;
>> +					break;
>> +				}
>> +			}
>> +			break;
>> +		case 8:
>> +			sprintf(buf, "0x%"PRIx64, dtb_ld64(data + off));
>> +			break;
>> +		}
>> +
>> +		if (is_phandle)
>> +			yaml_scalar_event_initialize(&event, NULL,
>> +				(yaml_char_t*)"!phandle", (yaml_char_t *)buf,
>> +				strlen(buf), 0, 0, YAML_PLAIN_SCALAR_STYLE);
>> +		else
>> +			yaml_scalar_event_initialize(&event, NULL,
>> +				(yaml_char_t*)YAML_INT_TAG, (yaml_char_t *)buf,
>> +				strlen(buf), 1, 1, YAML_PLAIN_SCALAR_STYLE);
>> +		yaml_emitter_emit_or_die(emitter, &event);
>> +	}
>> +
>> +	yaml_sequence_end_event_initialize(&event);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +}
>> +
>> +static void yaml_propval_string(yaml_emitter_t *emitter, char *str, int=
 len)
>> +{
>> +	yaml_event_t event;
>> +	int i;
>> +
>> +	assert(str[len-1] =3D=3D '\0');
>> +
>> +	/* Make sure the entire string is in the lower 7-bit ascii range */
>> +	for (i =3D 0; i < len; i++)
>> +		assert(isascii(str[i]));
>> +
>> +	yaml_scalar_event_initialize(&event, NULL,
>> +		(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)str,
>> +		len-1, 0, 1, YAML_DOUBLE_QUOTED_SCALAR_STYLE);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +}
>> +
>> +static void yaml_propval(yaml_emitter_t *emitter, struct property *prop=
)
>> +{
>> +	yaml_event_t event;
>> +	unsigned int len =3D prop->val.len;
>> +	struct marker *m =3D prop->val.markers;
>> +	struct marker *markers =3D prop->val.markers;
>> +
>> +	/* Emit the property name */
>> +	yaml_scalar_event_initialize(&event, NULL,
>> +		(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)prop->name,
>> +		strlen(prop->name), 1, 1, YAML_PLAIN_SCALAR_STYLE);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +
>> +	/* Boolean properties are easiest to deal with. Length is zero, so jus=
t emit 'true' */
>> +	if (len =3D=3D 0) {
>> +		yaml_scalar_event_initialize(&event, NULL,
>> +			(yaml_char_t *)YAML_BOOL_TAG,
>> +			(yaml_char_t*)"true",
>> +			strlen("true"), 1, 0, YAML_PLAIN_SCALAR_STYLE);
>> +		yaml_emitter_emit_or_die(emitter, &event);
>> +		return;
>> +	}
>> +
>> +	if (!m)
>> +		die("No markers present in property '%s' value\n", prop->name);
>> +
>> +	yaml_sequence_start_event_initialize(&event, NULL,
>> +		(yaml_char_t *)YAML_SEQ_TAG, 1, YAML_FLOW_SEQUENCE_STYLE);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +
>> +	for_each_marker(m) {
>> +		int chunk_len;
>> +		char *data =3D &prop->val.val[m->offset];
>> +
>> +		if (m->type < TYPE_UINT8)
>> +			continue;
>> +
>> +		chunk_len =3D type_marker_length(m) ? : len;
>> +		assert(chunk_len > 0);
>> +		len -=3D chunk_len;
>> +
>> +		switch(m->type) {
>> +		case TYPE_UINT16:
>> +			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 2);
>> +			break;
>> +		case TYPE_UINT32:
>> +			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 4);
>> +			break;
>> +		case TYPE_UINT64:
>> +			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 8);
>> +			break;
>> +		case TYPE_STRING:
>> +			yaml_propval_string(emitter, data, chunk_len);
>> +			break;
>> +		default:
>> +			yaml_propval_int(emitter, markers, data, m->offset, chunk_len, 1);
>> +			break;
>> +		}
>> +	}
>> +
>> +	yaml_sequence_end_event_initialize(&event);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +}
>> +
>> +
>> +static void yaml_tree(struct node *tree, yaml_emitter_t *emitter)
>> +{
>> +	struct property *prop;
>> +	struct node *child;
>> +	yaml_event_t event;
>> +
>> +	if (tree->deleted)
>> +		return;
>> +
>> +	yaml_mapping_start_event_initialize(&event, NULL,
>> +		(yaml_char_t *)YAML_MAP_TAG, 1, YAML_ANY_MAPPING_STYLE);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +
>> +	for_each_property(tree, prop)
>> +		yaml_propval(emitter, prop);
>> +
>> +	/* Loop over all the children, emitting them into the map */
>> +	for_each_child(tree, child) {
>> +		yaml_scalar_event_initialize(&event, NULL,
>> +			(yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)child->name,
>> +			strlen(child->name), 1, 0, YAML_PLAIN_SCALAR_STYLE);
>> +		yaml_emitter_emit_or_die(emitter, &event);
>> +		yaml_tree(child, emitter);
>> +	}
>> +
>> +	yaml_mapping_end_event_initialize(&event);
>> +	yaml_emitter_emit_or_die(emitter, &event);
>> +}
>> +
>> +void dt_to_yaml(FILE *f, struct dt_info *dti)
>> +{
>> +	yaml_emitter_t emitter;
>> +	yaml_event_t event;
>> +
>> +	yaml_emitter_initialize(&emitter);
>> +	yaml_emitter_set_output_file(&emitter, f);
>> +	yaml_stream_start_event_initialize(&event, YAML_UTF8_ENCODING);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_document_start_event_initialize(&event, NULL, NULL, NULL, 0);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_sequence_start_event_initialize(&event, NULL, (yaml_char_t *)YAML=
_SEQ_TAG, 1, YAML_ANY_SEQUENCE_STYLE);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_tree(dti->dt, &emitter);
>> +
>> +	yaml_sequence_end_event_initialize(&event);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_document_end_event_initialize(&event, 0);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_stream_end_event_initialize(&event);
>> +	yaml_emitter_emit_or_die(&emitter, &event);
>> +
>> +	yaml_emitter_delete(&emitter);
>> +}
>> diff --git a/tools/libfdt/fdt_rw.c b/tools/libfdt/fdt_rw.c
>> index 7189f014295..95d47be2d8a 100644
>> --- a/tools/libfdt/fdt_rw.c
>> +++ b/tools/libfdt/fdt_rw.c
>> @@ -26,7 +26,7 @@ int fdt_remove_unused_strings(const void *old, void *n=
ew)
>>  		new_prop =3D (struct fdt_property *)(unsigned long)
>>  			fdt_get_property_by_offset(new, offset, NULL);
>>  		str =3D fdt_string(old, fdt32_to_cpu(old_prop->nameoff));
>> -		ret =3D fdt_find_add_string_(new, str, &allocated);
>> +		ret =3D fdt_find_add_string_(new, str, strlen(str), &allocated);
>>  		if (ret < 0)
>>  			return ret;
>>  		new_prop->nameoff =3D cpu_to_fdt32(ret);

