Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE5D16275
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8BC88606;
	Mon, 14 Oct 2024 16:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="0mwLFGRm";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="0mwLFGRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49D78839A; Mon, 14 Oct 2024 16:24:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC918913B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jXrTep/sgUeLtcm+lk6ZqFdBst20HclgBY8apPfH7kznYwfpcrqRwqnwR19VK3s1SEwkp3pEXtEsahiHBmUQeHKh+FuCkJUSwKkboIUl9q1VAQRjnEfLRXyrZiJZYAImBr4jHIR/W3HL9XUo3/5Nr5C+cUBkbbbe0+BgurXsGTfVWXJ3za/OSGhj3+FsiscaUSgGmr6qjE0JjYlkKQPdQ0YubWFtbApiyCwkIW0XTG+IST2TRP1kAjPuXpuT/wYYsYLrzCwDCwJwfzZzGIxlnkD8NG4PD3RhJCm0cLDe8VvjECpiztOQckkYyCDfYY+NtrLubCsYhaRqV7AZI6NqqA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxilVJCIvTNB+/7KOIsjaQwjTyYuAzK/Wr7KIePoasU=;
 b=IpuNv9LQVL82ZBDQS9Cfq5AL1kMRFpwqOJz3AuajaDJEqefZNZ5MwLuRfN4GVGHgIlo7sSOYjsgwICT8JEiqWXRs8o1TSC12knrXCwKVDH6uT3H7t/Hyln4WQObObbDmUhNiYMqTlIUzF87CC/pHQ21cSrDQjhrOhp2iWLJzLzIEOPtDHT3j5c19wYnWOsWMNmUDsf2ceDTWR8AUv+syRVMbWYeG/ctdMi9mo4t3pkijO3ocb0cBYQSydpUt462r6hCUYGKsa3s9n1myKU6YXZU1vAcRCCtFl329zj02oI2T6TK1o2ooVCUijsHTdNKQM4psnWAjAZ6fF/yWiOu+yA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=gmail.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxilVJCIvTNB+/7KOIsjaQwjTyYuAzK/Wr7KIePoasU=;
 b=0mwLFGRmUqr+BANOALl0hYe3+MsD9X+4O6MoJqS+dssqmZPy+dWeG7Fu79Qk5zpgQW5ibqf4UgM1um9Jf+oRDAKMwrHM5RCs3eHsaRwbZC8lzrJdYKoXU4ebqy4TPX2i9HTBPIuSCd4YqWgBtnphUhyk4JRD3FwqMa23u+rSnAmDnLdNt0r7CzvvrwzHVFpcNBM3oYGaqj2Pyk3c6DX4RN6hiPRTktXMUokDChOTVefCuincv3rk6AHlsahpx6+ri7IvsQpA8dqbx+wxhib/1KTqT4/Ci10i3dv2RdhfOMOBtt1EpWsx95iq4Zsh1Q5zDVaucPkZmiNbhQ/oQJv7dw==
Received: from AM0P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::22)
 by AM9PR03MB6929.eurprd03.prod.outlook.com (2603:10a6:20b:287::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:23:56 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::10) by AM0P190CA0012.outlook.office365.com
 (2603:10a6:208:190::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 14:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8048.13
 via Frontend Transport; Mon, 14 Oct 2024 14:23:55 +0000
Received: from outmta (unknown [192.168.82.138])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 BA93620083981; Mon, 14 Oct 2024 14:23:55 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown
 [104.47.51.174])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 6C80D20080078; 
 Mon, 14 Oct 2024 14:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5G8UlPhz6txFn80+zA58ro2fHPHFfv+DOWkdP5gN2OO/ZEdg/UiaWe4Pe9QMLkHdgsKTyUvbPbVZWnOKg+VuZ4qk7gLwtZYKPXWsfF1516nYTiyb2O6h3c5OTMPIGlYjGH59cwn8FU6FpDuCQzNRbhng/wOFD5eDdDmgw53O7h3W7fli8R0I+UKvx9LRh7PKRY85Xm1Z8gsBvwOzk9UEogpuVe1BbsK/7lOihTYoNf4t/7NswP6i+7zI7Dcb96LvHBC/+WxpGbJSTuOF0Q6/kkEykSN4w1zBSuWroIjN9YrKdew44UEs2Likb2pWHIx4TI32l9iXg20zoY+zm7puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxilVJCIvTNB+/7KOIsjaQwjTyYuAzK/Wr7KIePoasU=;
 b=Osa5dtoSotltIuyB9ZnwmG2KXed+NG8xyruAYavddWq9zE1RBgxkzAVTCwDPrcr3vc39Ax7zOy7ypbucl7XlEKOM0ctYZsbsvhESUAplGcJN0qcAKsEhkYMM1FUoZogfUU4owp+8Gpv9yUUZ2zP/9sTTrtuw1duq6T7LgVrnkHPx1ChG79TuFjSQ9/LVgWAH96Kgucdr1DLlVHcRI/66VLF3/gShZxvCaXvJb7+AdDb2gNLD4n7Wi0B/v/1X0+vMovonqZfg/tM9Scd/dQ3iHl0NTJYX6GDRYR5mroHb5CIY4HAN1pOFeQQiadNtcBtnfaWPzQ9S+wUjUF8AudxZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxilVJCIvTNB+/7KOIsjaQwjTyYuAzK/Wr7KIePoasU=;
 b=0mwLFGRmUqr+BANOALl0hYe3+MsD9X+4O6MoJqS+dssqmZPy+dWeG7Fu79Qk5zpgQW5ibqf4UgM1um9Jf+oRDAKMwrHM5RCs3eHsaRwbZC8lzrJdYKoXU4ebqy4TPX2i9HTBPIuSCd4YqWgBtnphUhyk4JRD3FwqMa23u+rSnAmDnLdNt0r7CzvvrwzHVFpcNBM3oYGaqj2Pyk3c6DX4RN6hiPRTktXMUokDChOTVefCuincv3rk6AHlsahpx6+ri7IvsQpA8dqbx+wxhib/1KTqT4/Ci10i3dv2RdhfOMOBtt1EpWsx95iq4Zsh1Q5zDVaucPkZmiNbhQ/oQJv7dw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DU0PR03MB8463.eurprd03.prod.outlook.com (2603:10a6:10:3b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:23:51 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:23:51 +0000
Message-ID: <79fd246b-f5d3-4d6b-b8cb-d109dd135988@seco.com>
Date: Mon, 14 Oct 2024 10:23:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: FIT signature security flay
To: "Lev R. Oshvang" <levonshe@gmail.com>
References: <CAP22eLHhOnBXh-E5BDxLN06T6W1EsdUq4x4hfB9+rC4pDiMwwg@mail.gmail.com>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <CAP22eLHhOnBXh-E5BDxLN06T6W1EsdUq4x4hfB9+rC4pDiMwwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR15CA0031.namprd15.prod.outlook.com
 (2603:10b6:408:c0::44) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DU0PR03MB8463:EE_|AMS1EPF00000046:EE_|AM9PR03MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: a44349a9-6471-4c1f-f822-08dcec5bd633
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NEtybCtrK3NLeVVjMXUyaHdYL0lpOGl2N2JaNm96emJ5ZEJKWEJSbFZGZGhh?=
 =?utf-8?B?LzNpOFIxV3R0RDlOYldEN3NJK0szeW01UFc4RFVKdlllSXJ0OUtuZ1Z6TlBH?=
 =?utf-8?B?YnkxTEVHS01OS0NYZFZ3N2JpalJJV2dUMWZ4bXZCcnFQbzJQM09BUFF1VFZU?=
 =?utf-8?B?ckhCck9RNkJjTW40NVlZMVJIWTRXZ2hsY09pMWRYcFYwY0lERUF0UjNDWlJT?=
 =?utf-8?B?QSs5WEsrK1ZTQkpIVVU0MFUyRHZzckkydm9UdW9qa2EvUnlmazhFMDhxNFNy?=
 =?utf-8?B?ZnBuTFVnQU1QRjdkQU1icUZIeEdMS0I4SXRzVmxmM3ZaOW5lT3ZZV3dncFRw?=
 =?utf-8?B?T21MWjVCNXdNck9hWU5paGV5cWIwNUhMSW8wQmF0VEpVd0F5VFNMaHpFQWhi?=
 =?utf-8?B?UnpUNlQrME9RdWJuTXp6ZitmQW1MR3cxcERETlZrV0lpbEdiMVA1Q1h5YW1m?=
 =?utf-8?B?WWFCQm9MOXZSczZuSVVKK3pOMWtjTXByRDFBRGhJVHFZaXQ3d21OcHpmamJh?=
 =?utf-8?B?dy9WQ2VHU2dLNlZNOTV5QzRVVEs3T1l1OGZMSWt1bGJjcGhCYUFPNmtHcW81?=
 =?utf-8?B?NmVHVU1rNmRZamVhZG5aSzlrNnQ1T1dER0J5SHkwYmhaQU9QeDFJRnhmLzJB?=
 =?utf-8?B?bDFNMGJOY0gxQ1k3VndVVk1VWTgxTG56clhKVy9ZcGlFSDlpSWZwYytZLzBI?=
 =?utf-8?B?Tzk0bFprZXNPT0ZKaGxYSytKcGthcmgyRWxSMC9kOG5hOGZzUm9JblRpSmRm?=
 =?utf-8?B?UkxJdzlJMkxxRlNmQ3dBa25lMStHZnd5NTZ0MmFsZ3UwbVgyVzVnZHE5T3pR?=
 =?utf-8?B?eUZTZzFLa2crN0J0WkVkUzdDTFM4SXNOd0NzWUQxOGM0UG5rWWZQSjZsK3BS?=
 =?utf-8?B?SXVCWTJ3ZmhvR2JlRWUweGNiakRtOXpmSEV2TmxRQWlhanNrRTNzUjdFOFQz?=
 =?utf-8?B?N0RpYXJ0T2hXMFQyaVZHNG9VcFU1UGpsaVBnQ051cjhCSml6dVZNcGFlR0Rt?=
 =?utf-8?B?Qk5QTkxhaXZ5b3JZYVg0MlRzeEUyalY4Ykl3QXp6QUxCbjdJVnpQRWpkRlJM?=
 =?utf-8?B?ZDRnQjdYWGhqN25DQ1Z6Rjl4Z1kzMjJuL0g1OVB1VnZoNkhCZUZnV2lDZ0xQ?=
 =?utf-8?B?bkFsa3VKSUxnbEFDQ0RKS3I0YTExK0luMVd6TDlSTStVUVVGUDk5ZjJzU0NO?=
 =?utf-8?B?WGZzbFlEUFNaNnQ3OHcyclE0dWFUZjhUaG1kU0xNaHlZV0YyRmZlaUJOcDNZ?=
 =?utf-8?B?U3NBUU42RllrS2VXQTcyK0tPdmRCMFhtTkZuMHdSNnk3dm5kNGhLSERvT3hY?=
 =?utf-8?B?SDlqYkl5dVQxUDYyUWlocEl3eXI1TkpmREc0Yy9NSU5Db0NYSWp3VU9tekJ5?=
 =?utf-8?B?SVg4eUJDWUN0UC8yU3BiU1IreUZaeUF6ZVNMa3p0NC9HL2o3ckNCdURDYnVm?=
 =?utf-8?B?dnc3SlgvZVB5SFA3ZVRPUzEreGpJVkRPL0ZyMEJiT3FJNTZuWmUxRnRSWUxR?=
 =?utf-8?B?d1NSa2E0MmxTeHVIWlRjNUlZdDdOMXpNRS9CblVDN05yMFg4K1lvY0pzbEVa?=
 =?utf-8?B?d0xWaWM1NnFVbTVuUWVpeHU5Q2o0Ry9OaFo2VjBBOGEwWWhxY3ZUK0NOUU5q?=
 =?utf-8?B?Tkx5TW1LWlppd3N0anExelQwYUdyT2E1NVIxU0p5aVE3Qm44Wk5zVHRFRUpR?=
 =?utf-8?B?VkpSSkNJdlRQUHFaVFJFVUJuRGhndGxET2VGaGVITWZ0bFpIa3dEWm10QnZs?=
 =?utf-8?B?RTdmdnZFZ3J0U2srNlVaMktXVGw5WU5ZWlRtMFYweGNnSEJYWjFHWVlCSW12?=
 =?utf-8?B?WTQ5cTd2R2pLSlZQcFNQQT09?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8463
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f6b847a0-66b5-438e-8df9-08dcec5bd384
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|35042699022|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnh5Z2R2QllIcFJyQXV6S28vbDBDdGQ2d3FvTGVlR0VpVnNsUFBVeDZYdi8w?=
 =?utf-8?B?OTU1YzRtNEs0WGxOVTNTS0Z2VW1SL1ZQdllHZCtCSVNzZ0FNa0d5YWVGd25E?=
 =?utf-8?B?UDZIYzMvMUQzUnVFeFNIZjFOR0dEQ0I1R2dYemdOY0lTRVNJVVhaRDlBNXYz?=
 =?utf-8?B?ZU8yQ2ZUM3BaSEN5RmRYSmJtT1RTeW1TNkZJbDc0SXorQkFhbzBvQ1BteWhr?=
 =?utf-8?B?SkhjL0tvdUxrZ3RRZHNZUFBqUVFxdFpZWlVkMHRaRnRjOUR4VkZJcWNmMDRO?=
 =?utf-8?B?Zk1Ock9rdzRTaWd1YWlBQXpjNTZWOGp6d3NBTUkvVFJqUFFPQ3JPZ1JKTXF5?=
 =?utf-8?B?cjlkWE9md0tIN0FPc1lXMllWb1NIMEhtZEIzRjBmd0FzY2NMc3Q4dkpJT0M0?=
 =?utf-8?B?OXVHYXFEdnVqMFlZd2d2T0o2Yk9mNXdpN00vZ01aNUN3K3hkazc2VVFEc3d4?=
 =?utf-8?B?WEJ0bWw2b3ZPS3ZSWXNXVE9XblZ6d01RU1g3d2JqaWphaHBtd3pKMENzL29G?=
 =?utf-8?B?N085OThkenY0ZHJOempveE9WYXkvTUt3OVMyeHY2Y3ZrWlhsem9FYUJiaDFX?=
 =?utf-8?B?QzhrZWVFT1BIL29NUDBHd0pYWkZ2ZDVWTjJQOUwrL3FsbVpDZWc5T2RzY1JO?=
 =?utf-8?B?VStVN3VFaVRJQVQvR052akFDWmdHWDVJVFprbFNnTXF4NVM2V0dDK0lHdVVt?=
 =?utf-8?B?ckpRME4zQ2hZbkw0UjltMm85L0t4TUFTb1E4YmFEcW1DZTc2TW1pSGRGRWNF?=
 =?utf-8?B?TGdEaWkwWmorbzJIRkpxdnRsdUR2bFlSOUx3Nzc3TndaMHgzVktuZ0JNTmZW?=
 =?utf-8?B?dXRzLzYyL25odmM3dnVRMGZ0Mm0xZ2N6Y1JCMy9ibUpIQ2RzYnprVkRlRHo5?=
 =?utf-8?B?Q1RiVVdtMG55Y21mcVJrMWYvSVVvbVZTYTVzZlNOMm4ya1piVndiZ3BUL2lp?=
 =?utf-8?B?OHZQdWR0SzFkQUk1U3lDNS9taFpHZXV0NWZVSllZR1hrZmZUL3ZPYzF4RElT?=
 =?utf-8?B?d0VXNnZnbkU1WElJaTVDaHBSZy9BQXhLWWQ1UytvZEkvQ2gyZGg1WnZRcHB6?=
 =?utf-8?B?OXAvdjJraEJMdmJxTmhSK2tsRG9DdTdqUGhOZHBLM3pwQ0F4TEtMTCtMZUV4?=
 =?utf-8?B?OE5heHpRcU9MU0FBS0hhaUNCQzBKeUdVZ2M3MjY1YVY2WmdxRXhhRDNrMkdQ?=
 =?utf-8?B?SUZqdFVYeFdiVThlSTNkb3RXbjhSY0Y2OCs1RlEzK1hNakRQSEdiMVF2ckYx?=
 =?utf-8?B?aVo2NktBdFBpZjNpK2lVdTFlVVlsbzZUQXZtNmhsMk1LWmkzVWtKc3pBc0lx?=
 =?utf-8?B?UzhHanpreUovUlBCYXFGemFPcUFMVXVQYUVzZTNyWUtiVklCbmNnZWNZRURG?=
 =?utf-8?B?alFkeTFFTDA2bFRYMTM3WVRoYWFoMnR4ZHFFc3cyRHZwbEpJWkVIMTA2YjJZ?=
 =?utf-8?B?UEU0TEcwenE1cEVQN2tsNC9ic0plUlpBMFZvU0pWZVB2YWcwdHU2SHVaTHVx?=
 =?utf-8?B?WkY1VmkwMmZ3Q0JzNzZucjBWTHRPdTA1bDNGeFU2Q3BTYWtTd2c5ek1lKy9V?=
 =?utf-8?B?S2QyZERCdFBiYUxRQ0FmL0dkQ1ExNjh3MVZ0eTdCN2RUaHRPZHAwUHY4Mm1O?=
 =?utf-8?B?UTE3aGJCUFJsY0Z4YXR1Zmh0cFR2TktqVDJMWUMwSFE1dUtLSHF3OWdNYU5Z?=
 =?utf-8?B?NmlrOXhRQmVrSkRxVERJNEpnbHhocnFtM2hHR1JFQi9BV1hoRVlDMGowZ2xs?=
 =?utf-8?B?eDFYY1ZPbHgxV0lUaCtLemlDdkJqQ0F0ZWJBOFNPZk9KcWhUeVJBVVZPVG03?=
 =?utf-8?B?aHBZcHptb21oSGhIbU01VmRQdmNmR0pVT2RUMURHdTdzYjZqMU5sTW1NQlBj?=
 =?utf-8?Q?guXAAAsnJpqda?=
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(35042699022)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:23:55.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a44349a9-6471-4c1f-f822-08dcec5bd633
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6929
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

Hi Lev,

On 10/14/24 04:42, Lev R. Oshvang wrote:
> Hi Sean,
> 
> I am looking for help with Uboot FIT  signatures problem
> 
> 
> 
> I  started to work with FIT image (u-boot 2024)  and managed to sign
> kernel and load this image with Uboot using 'required' property in
> signature as  :
> 
> signature-1 {
> 
>                                 algo = "sha1,rsa2048";
> 
>                                 key-name-hint = "dev_key";
> 
>                                 sign-images="kernel";
> 
>                                 required="conf";
> 
>                          {
> 
> Iminfo reports"
> 
> ## Checking hash(es) for FIT Image at 01000000 ...
> 
>    Hash(es) for Image 0 (kernel-1): sha256+ sha256,rsa2048:dev_key-
> 
> 
> 
> To test the procedure, I generated another private key and signed
> another kernel with this new key on another Linux host.
> 
> 
> 
> 
> 
> I expected bootm to fail, but it just happily loads this image!!!
> 
> Even an image without a signature but with a valid hash is not
> rejected against my expectations.
> 
> In this case iminfo report only hash is OK

Did you embed the public key into your U-Boot devicetree with `mkimage -K` ?

--Sean
