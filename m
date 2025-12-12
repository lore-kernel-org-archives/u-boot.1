Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F24D59D82
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52987809A5;
	Fri, 12 Dec 2025 19:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="RucUdsEM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="KTyxiErl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2553183106; Fri, 12 Dec 2025 19:40:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2D18006D
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gWZ/XXsWMxrA+KA38adKFlkiVYb6ep4wDj6AqBmK6QWpQjGla1HEMhxAWjUrAR6EWOAhVREnX/ydGWvXsWbNd9rUxi9HPHY40j32qibM90IwwbQ/jdLPToFOi1pjS6xcw9afBSXZSKUY7ALYdL7imqjgQwMNoZFAQm8MBW8h/Kh9AVz/vbAZ1EC70J1EvJGIok4hPpOzgCwQ+sClRi6wfxlNbf31Sf26XhPnKemyeJzLEscBHocsa4q+ecv/v2oG+JkdQyHmZ6ylZqod17MZnwNAG8CtIDi9yU1RrDloco7H1LJSg/K3zT1v4Ncey29c1foUjXn9MvftVIVdRnxjvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VXWM9HutpnHQ8EIGgvie/T7W4AwSwGAsJakTh/fUyw=;
 b=jtLahYweGo/L2jT1xfvRsYKyxOTZS7G3RzTOr44PfkU72vw6hVl6/eKC7sXEEDmpvAEnkmg0zSu7QLIS7V1812LlHJhDREdKXG+1D4FykpxWLuIQvVW8D0NCSSu/bnxL4jTTz7MtdObF2YvRQIRMMKStjYBl1M8MZWkX7owEl/LgLTV/pFFwTTjf/COV9fp/OPbrJcuqL4lLLgtTL6ZxyZSbN9VjPDtbJoBt0YzHmRvvSGZJOT+NkNx1Xk171vWwcJ446SEA/DM3WNZmfjv5hhU8fQ8ij+/5vZaVRzW+EAxtRZjJjLgdy+A78MEkwfOuEIz8DzElhrjK3fLU2d6jhg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=ccns.ncku.edu.tw smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VXWM9HutpnHQ8EIGgvie/T7W4AwSwGAsJakTh/fUyw=;
 b=RucUdsEM7Bss7KJrQvGHOh3Q3yWqTDdGblkRhZSSD+dBq5Dkr6aN7qd7m+9Jj8sk3GyzDCeGH8KrBwKl1rkAvXKqexqCGVRCLd75V4+YEaHtuBSCepGkEQNuRfEiCO5cqMEu1IbGc9vQ8eslUf/l3Qu6LW5duQpVMs+oQHIdgM1JmmMNn2hknJG10q+BmzlZoqh3BRJgcmq7Kdg9TFcfBGt7Y4D38fiarmv/Ynxs/gHUynyKZsYpis/MzGsJls6wFPxM09bo7aBtdeqtjBsz0swiOqnIW0MLS5WG2sSJ/Xwo1XR7Vf8p739hRK/koAuKKX5yC7ceF+pG07qGlBbQLw==
Received: from AS4PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::17)
 by GV1PR03MB8542.eurprd03.prod.outlook.com (2603:10a6:150:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 18:40:46 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::1c) by AS4PR09CA0014.outlook.office365.com
 (2603:10a6:20b:5e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.10 via Frontend Transport; Fri,
 12 Dec 2025 18:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Fri, 12 Dec 2025 18:40:45 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 C7BEA200800BA; Fri, 12 Dec 2025 18:40:45 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (unknown
 [52.101.69.98])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 6CDB620081252; 
 Fri, 12 Dec 2025 18:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLRo4K0YNp3VxcPmBA+UV/o6cn7YjDbEaFOR+xP4kQAOmpqAIktmUVQK+Z3C7YOE+4UvdANp/RbGef9BtEwxTJglPzf2PNLv6+DpVE4l/K01I7JYLVt5+lxayla9AgkxXUVfI7eHHXn/LjaXyo+N3lsbz+yMWuVmVk5A9S+i10mqn7J31dKozDfoeOykToGSXTDYMPWr90mIFpfoIB0W92Ga+G4SvrUYuF9TeoMBtCRLdkrmqucCULZ6xpXZVoIr+kMq4nf9eiaZHPQsu09kuWfUuHzM1F49/jlWALzObuLmTbrInOwNhumQ5L4NTOD3G5LffJ83JkVvlYoudOj5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRQ32Cf9W3yNVpKGstiJV0vMAn7tm8l7WoRpR35WEEM=;
 b=WAnsqiZhMcfMeX4MfIQcpftT17sP8KCQmCZzP76nfKM/Fsylx9NZi/7hFCh9q9NbxAZbyopy+/DT18RK9/umnyY0BD9OkLGngIwpn7cK6vonx9w65APrMFIgBkknZMtFXPo/kOXU4mg6Or/0w0rpi6y7tg4Snx6m1f/ndBFdA/PtBSZNmLaI0fy1WUs8RP7L86Jip7MRT56NLrl/stNY9avZ5KJLDrdEnR0A/lqbdNtbHJ5KjOlQQYUcD+VgjkEhpR0OZ5+auD9+YRQKScN1lcFLprngcijwaF0fcdpExbVnmYNGmRe2rLGln8IlU63Xf5pPtTCkth7i+RQFf5X0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRQ32Cf9W3yNVpKGstiJV0vMAn7tm8l7WoRpR35WEEM=;
 b=KTyxiErlHETVDmTb2XBR5StIQdjzUh8PN+3NIHOUY/NkmAnyXQ0EsmsfyEVUEb62fAxfvlLcvSNZqyMerHA7g4umHEY4O620sVlNe8GCd6YSo0ZkWKphMwVbcD1wqtam7VNlADlC8H5H9ut2l9rRp7wOoY5dN6y/CYoSTNj/5roDBbAhGBhlRx0X6KVBDtJH7RN9eMJGCl10LkKQUGSdAqikMsedwroclzFhi9ROXEtwH0unHxsGm39p8097t7CiGAvrqWD+vLi2Oym604KdQBnDkp/a9dPHCYbqT/JKj+mUFw+9er28qTRW6zThA+z/DGQnC3xauIB9yODERlPYLw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB8690.eurprd03.prod.outlook.com (2603:10a6:20b:54f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 18:40:43 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 18:40:42 +0000
Message-ID: <6b40a19c-3fe6-40ef-abd8-66939eb0dfae@seco.com>
Date: Fri, 12 Dec 2025 13:40:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: versaclock: Fix incorrect error check in
 versaclock_probe()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, lukma@denx.de, trini@konsulko.com
Cc: andrew.goodbody@linaro.org, aford173@gmail.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
References: <20251212180615.4112751-1-visitorckw@gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251212180615.4112751-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB8690:EE_|AM4PEPF00027A64:EE_|GV1PR03MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db1ab19-14ac-4af8-cfed-08de39adf678
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aDV2ckRFU0Z4Z0REY1hqQzZKN3ZKRDdqeGhvak1oMGpVQ2xoc0dRQkZ5OFVQ?=
 =?utf-8?B?Y3hrS1ViZGlqMzdVQXZ4Y09sZ1dwK2VvZkhld1l2dXRDNGZxWHZqSW01clNu?=
 =?utf-8?B?THZsNDVLcjFVSVRwWER2QTR2OFRQQzFxUE0yMDRmdmVnRTQySG9XNFYrblZE?=
 =?utf-8?B?V3FvdCtlelFpUDNJZHZnNTU3VGxrR29jQUxCQnhiQkVPY2FEVzRJRDNrYVZ1?=
 =?utf-8?B?M01kbGhjTktMc2RuTlVpTGRaUDcxaW5QK0szbUF4ZDN1WHFMWDQ2ZW52d05K?=
 =?utf-8?B?YWdTT0tBUW1QMk5FNmE4cDl6eEtqcEFiWG9oRUVDeFF3endwQmlwNUlBay9q?=
 =?utf-8?B?U0NPdlNVM1hnYkJyazIyaXZKUHBMbm1SbzVJL0Y5WVlSNW5vWWJGWVVCdXVv?=
 =?utf-8?B?ekRYWnBTS2NzL0MzcDF6VDQ2RUpKcFFVQU14dlc1YS85NVJQTTRJelhSV1Vh?=
 =?utf-8?B?U25DTkZ2cXI2V21MeUZyTW1kZlI4RDhPVTRFSVpOb2s4S2dUQmhScGlOTTh4?=
 =?utf-8?B?YmhPcllDdlVWTS9yendPakVlSDFMRExhRVo4VVpyYWlocnFJZm4vYy95bXlu?=
 =?utf-8?B?aEI0RDJwaWllMS90dlEvRU8rb3ZDWDRCVWxrRExkQkN5cFVnQVFHUEl0NmRt?=
 =?utf-8?B?azBkNUV5SWY0bjdnUW5CaStLQ3ZXbkFWbzNNd0FkeTcyd3lZTG04Q1BEaTJx?=
 =?utf-8?B?bnl6QjN6WGl1azJEWWJIQmIzcGt4bWplZnljdlBnZ1hMMUVnT2dKUU1kazRu?=
 =?utf-8?B?Z2JDTWNQWEJYSythTlVlRDY1bURnUkwyWHE0M0c0cGtoWmx2WDNsN0ROZFRq?=
 =?utf-8?B?bjRCalFaZUdmQVJtVVJWZGZqWlRDTUpnelJRbFBZVUsvYlBoaC9jcnpyQTAr?=
 =?utf-8?B?ald5enBzWUVsd0xId0FVSjd1NzU0OXZ2aGxyUzI4R2hISDl3dmozZ09ndlFp?=
 =?utf-8?B?QnJEU0I3NDlJYXVqOTZCMThBNTg3YklSeGsrYmIyZmpnb1ZLcndTZVpZWUFy?=
 =?utf-8?B?NHpVUERNWnk4VnMzOVR0Q3lTWjJWeld0ekY2U0ZqQjcyd2ljeW5DUGZiU0Nq?=
 =?utf-8?B?bmdsSDg2T3R3VHF2dlY1QlU0aytDWExaeERRMGhveWRWN3dXR05ick9aQXpL?=
 =?utf-8?B?ZTBOeGpwUXlPUkhTQ3QxSVFhNDhpeXZ5WUtMMU9MTmhwMklIL05MZlRucDBX?=
 =?utf-8?B?QWdnWTdrWFY3d211OENmYng5N3YvVW8zR2xZR3k2WCtDUTNtQTJmOFkyYmNY?=
 =?utf-8?B?cGIySWZ0b3ExZ1BqWmdjMktHNitwVUk1dmxkRnA3V3dNT21FQ1U0K2RxdVZC?=
 =?utf-8?B?S1JQQkU0VkxMQlU4b1o5UnB1MUVyMDV5QUloQUQvUWM1eGpiQUNnMlkyK3hy?=
 =?utf-8?B?dmJXV2toNDVHZU1mdjc1bC9id0ZjZFd1Y2F1TDRyY1FpbXRTSCtpVVgxYkdp?=
 =?utf-8?B?WkxrT3VaTjAzSjRycGgrdThYRkkwd0RqOTQ0dnY1OFBGVm9vYWdzWTd5L0Zn?=
 =?utf-8?B?QmxUU1lUZ3dJQnltTmlPZFZYYWZYQlRtYmNGRFlaUTdqZGRuN0Jzb2xtVjQr?=
 =?utf-8?B?bTh1SEFuclAzVE9OUGpkenRFZDl2V1FVWkZPMEFWaVJDRFBha1ZLRDFEbVU2?=
 =?utf-8?B?MTgvTHYvc2RrcGE1aFVHZXE3cS93OW9ZZGdwdEpUbGxSVmNUNUZaNGtJeU9s?=
 =?utf-8?B?VUtTS3IvUjIzL25uY3AyNXJFK0dGTzlnYXp6dWdCTGhzS3RzTWRVOE1oSmhY?=
 =?utf-8?B?T3lnVWNncUQyZHlBT2EzOFNEcmhRUHJkS1V3Wm81TXdBQy9VNW50aTdvdk8v?=
 =?utf-8?B?ekFEVjAwQmNqaXpDSTZTQjlqU0xEVnV1UkR6NFN3MW1XbmozMVpOUys0TGgw?=
 =?utf-8?B?eXROVG1pR2Z0M0FBUC9Ha1E2eXhmWGtYZ0hGVnE0NU0rTmdObmFlTjFneEdS?=
 =?utf-8?Q?GiJye114UizewFPImDUs0JAMFxyaU3WA?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8690
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c9ff972c-9daf-4c70-7c96-08de39adf476
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|14060799003|36860700013|35042699022|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0hLT05XWkU3S1g3dThFTmJWL2tFemRxSnQ4V0REa01JMTJzRXFzbThqYjJQ?=
 =?utf-8?B?KzV6SmV1N3JnRkgzMktVQkl1a0pUcmFHckdxT05rcGtZSldYdFpvb1FXZlor?=
 =?utf-8?B?RUVlRWJLbWxvZjQ3elp3S2o2QldKemFhRWlqVnJVUDUyeWtvc1BZSU9wV2tG?=
 =?utf-8?B?WUM1cXFVNnUyMzZ6WXVSQVh4L0NiSzV0QkFDZDVOQmk1cGNNSkRVSFdSMGM1?=
 =?utf-8?B?ZTJ3Y2hEM3lyL1pqc0VQRmVhRXlrTHBIS1FoeFR2Uk1lOVBWaGdvVjdJZWR3?=
 =?utf-8?B?TEpOd0M5aXVZSjVockZzSUM5UElrN0dwaXo1QVNZTWExaEJ6YWcrNHNqVS9x?=
 =?utf-8?B?bGhudy8xQzZWclZaNFZDYjBKSDUvWDRVU3ZFRlhDL0dtRXFZbk5iQXNzYlRI?=
 =?utf-8?B?L3hQNmZ0L1dKVGdvM0g0MGdYcmgzcys3OExOSzJNM0hVYnJRSlBPMlhKcE50?=
 =?utf-8?B?a1RoeWpub25HN3hIOU1ucEsvYm9adVVZcnJFUFlGejh6bTNWU0N4czAvc1F4?=
 =?utf-8?B?OTdCc25RUFVEbzdNRm9XWklxTzRpMlVQcmM1dHNKVk5RN2VBWFNwa01QMXI5?=
 =?utf-8?B?MXV1dS8yem16Qlk2dmZLMzhQMlNFc1JOK0ZqdDllWCtsWXBBRkp5dUJtc3BK?=
 =?utf-8?B?bG01VHUrYll1bU80cFMwYXExSk9RWFdNaDhHMWJuRzdvVWZhd2VWUVBvMU9n?=
 =?utf-8?B?Y1lIUW8rK2JjRGJ1Z1c0aXp0YnZzRWhTNWxYSXJ3UmpnRmR5MmJoWTFNNUx0?=
 =?utf-8?B?dFU2YjdXOVBIbGZjSGFMOUhJdmVLZ0Fsem1MZi9oM3hnZVNOelk0M2lLYi9m?=
 =?utf-8?B?Ylh4MzNvcnZlMXpydysvVTczQi9aUjJlM0pvYzhZN0h5NkV4MWJGUWcrUDBk?=
 =?utf-8?B?d3liMWR6bnNsdVgxcmordW5GM25DdlpCYnBsWVozaW8xUTNGVFozaHJWeXV4?=
 =?utf-8?B?OXpZbEN3VW9TR0NvZlY5a3dVL0E0TnpnVjRUTlNrYmpjWWJKTVlpa0VaNVVP?=
 =?utf-8?B?OXJlZzNRVXJTU1BGZTgrQTNrcjNIRmRBSW93bE9PdUxNaFplenJnbUJjWk1j?=
 =?utf-8?B?cU92Y1FGTGp1bThwcU43RUlUVm5pM2FKaTV4L2dEOWx5ejJpYjErSEwybVJ5?=
 =?utf-8?B?bHlseVkwWUUrUklLcGc2bUEzNWd2Nnl4Q2NUUTZRK2lHMEl2d1l1S0tWQXBl?=
 =?utf-8?B?cWE3TURxN1JaTTRVWkZOVmpxd1RjaGd3MnQ2SmZBK0g4dEJYRDhCbWpWWWJN?=
 =?utf-8?B?Q0VKeTk0Y2FJWU1kMjNHNzNRYkpOSEVhc2h3VkpUYWRwMU9PVTV6dE9Day9h?=
 =?utf-8?B?R01sOHY5Tlp3Snd4N2pvaVpVRjZ6aFNYOUlQTWQzWXhTSHVXQjJWbVFoYWJs?=
 =?utf-8?B?U2Q1UVRZTGpvLzNudU42cC93OG9jZk5YdXk2ekpxTnNZMnlTMWZHdGMwNkdU?=
 =?utf-8?B?OXRhMDJkOWlicFVnMEdwTXk4amtEZDNLQ0krWHhOUWppZERRZUMxRnlpM1VV?=
 =?utf-8?B?bmFaV0dyTDRNckxLaGxMVWVmeVVockNScFdlc3NBdFNWQXhNMkMzZ0xBczZV?=
 =?utf-8?B?c003c0ZtT3A1Rjg2WWprMmd6NnE2U2FCOE4xTE9SOENZdC9EWGtWbHQxejNQ?=
 =?utf-8?B?cHVJaVp1MklEQ2lEVm9kQVo5SW1tYWlzY1d2MEU1cXhnRFlYeE1GWVo2WUM1?=
 =?utf-8?B?ZjZpSHRGS21pbEo2bFN6Y1FhVjlFckwyRmRPK0d4THlzY1k5N1BsVnZvZnFX?=
 =?utf-8?B?QlRXYXY1L2FTSUJjdnpCUEF5NC8vbzNyOE9qeHJqOU5ZYjBnQ3FRa0xYM1J0?=
 =?utf-8?B?VjNkc01iRFhtQW81Z1duUEd4OThjRWhsaWp2VWdEUTREZ2htdyt0V3NRNXJQ?=
 =?utf-8?B?Z3V6aUlmWmlzUk9GeHpJdEFXV1RlekNvaWdhTi9IQU9yODBPVkJ2SFV2dG5V?=
 =?utf-8?B?UU1zcEk2TG5MK1NUZk8yL1Z1SWs1VVVXNitDc3Z4eVg3TndaQ3lzc2x4SkJ4?=
 =?utf-8?B?Nmw4ZVlzdTArL05HaEJ5eUk2NG1nOFU2VWp6Tk5IaHZYbzk0S2dEdy9Dc1dl?=
 =?utf-8?B?Yk9xYTYvQ1Nyd2hJcVdlbnIvY1h4SEtGZ1A3QmtjSTU3MGdNOElIYkpCNC93?=
 =?utf-8?Q?Zm9E=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(14060799003)(36860700013)(35042699022)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 18:40:45.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db1ab19-14ac-4af8-cfed-08de39adf678
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8542
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

On 12/12/25 13:06, Kuan-Wei Chiu wrote:
> The error check during the registration of FODs is incorrect. The code
> currently checks IS_ERR(pll_name) immediately after assigning
> fod_name[n].
>
> Since pll_name is checked in a previous block, this condition will
> always be false, causing any allocation failure in
> versaclock_get_name() for fod_name to be ignored. This could lead
> to usage of an invalid pointer.
>
> Fix the condition to check fod_name[n] instead.
>
> Fixes: dcf2cee77f2d ("clk: clk_versaclock: Add support for versaclock dri=
ver")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/clk/clk_versaclock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
> index 19a787eaf0c..1dbde75f180 100644
> --- a/drivers/clk/clk_versaclock.c
> +++ b/drivers/clk/clk_versaclock.c
> @@ -945,7 +945,7 @@ int versaclock_probe(struct udevice *dev)
>       /* Register FODs */
>       for (n =3D 0; n < vc5->chip_info->clk_fod_cnt; n++) {
>               fod_name[n] =3D versaclock_get_name(dev->name, "fod", n);
> -             if (IS_ERR(pll_name)) {
> +             if (IS_ERR(fod_name[n])) {
>                       ret =3D PTR_ERR(fod_name[n]);
>                       goto free_fod;
>               }

Reviewed-by: Sean Anderson <sean.anderson@seco.com>

[CES 2026, SECO]<https://exhibitors.ces.tech/8_0/exhibitor/exhibitor-detail=
s.cfm?exhid=3D001Pp000010EbaOIAS>
