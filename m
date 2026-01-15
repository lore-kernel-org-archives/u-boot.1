Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A9D4115A
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 10:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4C080325;
	Thu, 15 Jan 2026 11:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gFjw0R1y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gFjw0R1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CD183623; Thu, 15 Jan 2026 11:10:17 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EBB80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 11:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z18/3henW+2kMlPf9+rtbPyTS/8rLAWeSSdyGAwJTA4V1WmL74CUZYKd1DcCwsihemRx01LZkJ4OYPw9PDd6Mmc4etixqVYIDWpLVmC2RFCjZeLhGKRw/sDkJanXGlaEAa7fZ4re6JhzOHMrZRSxB08Jh/ATZIIJe1MYDGrDs5Zs6tiVHgrY5sjBzCU5RTtzrxeeBghBJmFhfN5X/Nms2OCY5DsL4WcJkKR6lXnKx6aA/Vqa3qbRg9JcqYcPDOw+T5B7W8encK+oJ8koWIJWJJHBUfLRNfBvBWdDFntMa1cokJsjMl0yLpU5FoHLAXUfGHsp7LU/fr3Aat/c8d49Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TRoEs7+5ET1SbGUwCwf5miQuQjn4TeAbcHa7nvyZo0=;
 b=RBXdZPpBjdN/naz7iRoMSDp+t6WRz/nubKcJZEHVnPYtHqaWA0cXxU8v6kMHWqM08ZPmJr0lYGrslMapdX/101aZsZQaW1tX68iytzxmf2ZxLSxz1eg0krYtMIF5wVFcU+kAgOb7bmaSOCyjA8/q6WOkcQ6Ktk+SvymUuUnWeTrJP9ruytI1LrsHnyimowjx/HsCJR/M/HEqFRWyK467xv7pWeFHkVhh+efZLxWUWDFA461dDYhcGbPv7M1Op4uqNanqIpFDjxtQVCjTn1mFTfwfv1XfN+q0S3WYaMdjpPGR+hrEGM3B3YyPfjqfTKjN41t2z2pOnY7+JM9eXRsjmw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iopsys.eu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TRoEs7+5ET1SbGUwCwf5miQuQjn4TeAbcHa7nvyZo0=;
 b=gFjw0R1yNXJzhykHErBmDsGzBJfQKXfWnjeZDlN/GZS2h616U9lX59oiwcvz3qkjGmfNDvsNkN250KvBi+TUx1nEuDpBejZtgX/5wPDcd1Ptb6yBlbFXuQ2cJGBimeZhIxrQsiYegK6oi9tI1ZaQU3IixsjEjfkSFGmcRXm7+Yg=
Received: from AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31)
 by DB9PR08MB9730.eurprd08.prod.outlook.com (2603:10a6:10:462::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 10:10:11 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::24) by AM0P190CA0021.outlook.office365.com
 (2603:10a6:208:190::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 10:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 10:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZxeSeKMmfhGH8qmqoTmCt/Y1aXJOhcHGIG1mIqcuQBZDi13qcWjYHKdZwNmYWeqf2KSyqgSIsGgS6ZW1tIjOAAey2pIpEbCnYZWUWUeAThvs6qMrvlOqtkdoOLGFGkEDxbSTOGVjnAxOMUO7m53n0Lwuyov7Ob+GISYLCO5lPeS+ZO9vyhmrJU0g+AH+J7WtKutW1jIcBBXsjetvaKmjLMRW1m65WEhWEYTrGm/jRXZkLTHSx69b7jVeNS4jzDhmx9F11U/m3rkZAocbGC1sTxFm9+DhrSvzvnHdUpzhCQBMKKywzKHbJ8SyhhMcq5rRhLmB2/7pwgr4v30pvh09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TRoEs7+5ET1SbGUwCwf5miQuQjn4TeAbcHa7nvyZo0=;
 b=HVl3sDgwV23gYs4kCMe3kD9ehVZxtwlN/H7OisuM4TwKqxlqKSarvAyfVH+uDax5CgTIK0uRt4fhUU3IRSXA+EhjthjQmp5BQucnd5KHS23yafEjRDNfirhrd+oOpfDw6Jphd2JKrHx+xcLN/y9WyIJa95gQ2i9IpMuwWYiJv+3VbDNm9ySZNTXdm5zEkPLHADck2EsubzVgzNqDn3D1eBCEscoHE9fxw2aXAvKR0wEUgxzDcIi7HeY2BYN/0F2DIlHVAMZfIM20NilttaajD+mSNb0YrxTF7p0y34Jb4gEB+k1QHgMJ1PMqGEqxpi/woXDB35JgC0geTA6B/zmA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TRoEs7+5ET1SbGUwCwf5miQuQjn4TeAbcHa7nvyZo0=;
 b=gFjw0R1yNXJzhykHErBmDsGzBJfQKXfWnjeZDlN/GZS2h616U9lX59oiwcvz3qkjGmfNDvsNkN250KvBi+TUx1nEuDpBejZtgX/5wPDcd1Ptb6yBlbFXuQ2cJGBimeZhIxrQsiYegK6oi9tI1ZaQU3IixsjEjfkSFGmcRXm7+Yg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GVXPR08MB11787.eurprd08.prod.outlook.com
 (2603:10a6:150:316::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 10:09:07 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 10:09:07 +0000
Message-ID: <78c0919e-bc00-409c-a102-e47188a7a7cd@arm.com>
Date: Thu, 15 Jan 2026 11:09:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/19] net: airoha: PCS and MDIO support for Airoha
 AN7581 SoC
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
References: <20251224082409.1347373-1-mikhail.kshevetskiy () iopsys ! eu>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy () iopsys ! eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GVXPR08MB11787:EE_|AM4PEPF00027A67:EE_|DB9PR08MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 704e69c0-c08f-4f74-7965-08de541e445c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RmROMmJqMlVVMkZzbjVoWkFHcVNSZHNTdlNscDdYZnVJTEh1NWlDY3VnVUd5?=
 =?utf-8?B?ZlRRVktFSEpTSGdiYm5tQW9WZXV2YUNPOE5CR0ZUY1hLcDFXRmthbG9PYVJo?=
 =?utf-8?B?QnZuKytpSjdPYnNIUlFteVpFSDBNQTFmMTVsL0ZxdGpNNWxmWDBLOVdITExu?=
 =?utf-8?B?QzBVdE95bk9xSHlSYjBXdlN5K1kzZ0h3U0o3ZURMZWVYVU0wT3FJRUQ2U0J5?=
 =?utf-8?B?b29MVlZ0eUVlWFh0YmkzRlRFaGRuQXA4UXJ6SHpWSS83SXp6eGFYRzhRM1Jx?=
 =?utf-8?B?eHkvWTJZWHE5UmxEWmpSMkIrZkRrU3BlMWF2SHRKTFJkSnBDT3dGM0tGRDE4?=
 =?utf-8?B?VzNYUW1qYzJqVWc4S0lDMjU3RFdHb3J5TkZIWlg2c3hpYkFjaGFPZitSRDNQ?=
 =?utf-8?B?U1NkNU02UHp2WHFjeFl0VXpmTU5ZemdMZFBQWHJ1V01DS0lacE9CUHNOcklK?=
 =?utf-8?B?UEtvdnl5VEpoc2pzZ013K2hNNkhNZExOZ0dRcG4vNUQ1RGljbGl4OExQa0x2?=
 =?utf-8?B?RERKQS9vQWpmSlBnRDdBZGlURHRLRFJYMDhiNTFIdFNudThDLzJ3cHpvOGtV?=
 =?utf-8?B?aTBTell3VDF0ejlSeVk2ZERLN0xHR2pMdU5WcWk5b2I1TXNCMWNRajdBdVF2?=
 =?utf-8?B?bUtYT1hZRU13WUtaY3BNUDh5NDFOanNhQS9XdnMzemIrdzZpbWpyTFltVzQv?=
 =?utf-8?B?RjZPamkxYkNFZTVrVU96eEhKd3dkOVVZN0g5bFF3WjhTSkVxTlVkYjBaSUlx?=
 =?utf-8?B?V1ZlU0VXYlV1U1dQWkwrYWp4OWpRR2IyZE0vcTZjeXlvZFZCZjBRejRWYkov?=
 =?utf-8?B?emRhT0pjcDZoYmczcnBmMHpob1FoZko5OWU5M0M3NG5vU2F2aklDVzdRRnlP?=
 =?utf-8?B?NGFvSDBKZkFhb0RBelJpUDNCRDVVTWQ1NzdDamVoRFpBT053SmRrMUFxY0FX?=
 =?utf-8?B?a3ZFUmxFTjlnclRIVm1HQ05RU3JCV25tL1lWS2tZYmtwczdmWkhCbE45YXJN?=
 =?utf-8?B?YThkb3hVS2J1UWJtNFU4cHUyclNwZ2ZIejVnd1ZOMTRLL2lTVFcvT2hYNGlr?=
 =?utf-8?B?Zm02OVRaMG9weVVGTVhvWDZuQjJ6MnoyNlpINWhiQWJzL2JXUWpRYmU0YU81?=
 =?utf-8?B?TmM5aG9lR3IwbGZUZlJhWGN2eFJXT2JlY3NLZk1uYXlQa2pVbXYyUFdIZ28z?=
 =?utf-8?B?SE5DTlQzOVdHemsxc1FMNjFvT3FlOTF2WjhadWVxdE9WQzdBTlo4bUNEV1FZ?=
 =?utf-8?B?YktTWU1qSG8vbEJ5emx6aTluN0szVHcxT01UTGtITE5FZ2lRRHZTSmpIL0VS?=
 =?utf-8?B?UTlVZ3lxVXlRaXVxaW83c3JoNDA0WHptY0lPdEhjZmRCeE5jWmVVbDR2djh2?=
 =?utf-8?B?ZEpCalJVTTZQZG1zUHBwQ0FUWkJHYzVpWkJaQUtPL2w0QXFRMVlNYmZacXFy?=
 =?utf-8?B?LzRBTHRkT0hKSlFScmowVmxXVHh2M3RXMG8yMTRDZEtuZmMzbjY2anI3RUNw?=
 =?utf-8?B?Sm9XdzlSTm52Sm9UVGRmR29zckxJVXh6RDNtdkJkMS9vMm16TFdLcjgreFln?=
 =?utf-8?B?TzN2S0xkYzZrK3QvWVB6cUxWOEQ2N0FpcXQwaTRPZGRUQVphVk5DVy9nRUdn?=
 =?utf-8?B?MFpyM2FXWTR4dEZMSXFFbnlCbzVFOW1xRzNZbWQ2cHo2SWNjTVpaVXRDb0tr?=
 =?utf-8?B?Ry9HQk1qSmsvbGY3YUJ3RHduNkhaYzViTkdBY2k2UlhWbG45dERNeW1QdVdP?=
 =?utf-8?B?NUpXQTVwVktXdmc0dXRDa296dEpCUnpMM3haT213STNuZW9lYTVkS2k1ejVI?=
 =?utf-8?B?Y3FkamEvWkxPU0RkTUFwbGdPRndINDRURjVjT3ZMYjJCOWw0T3ZVSEppTStk?=
 =?utf-8?B?Q0hPcW1MSWNrTHJEaDgrR1ROQmRXc21Ua05KcC8yYXlVSklQS2NEdUVLb3hR?=
 =?utf-8?B?dm9Eb09uUVcrUERUZ3VnUVIrUEFGOVZQczk1UDYwRnFVYU5qWE9jSlByKzNM?=
 =?utf-8?B?a2RmeVJQdmw5b0RBSDVwVGx5Nlh5SWpDSGhZT05MZ3BUZnNWM3ZtYVZpZVRl?=
 =?utf-8?B?all4VDdnZEtQUjFaci91ZWlyYm13NjB6MXZPRlBqNUtsdnM1QUNORm1tTHBn?=
 =?utf-8?Q?w0JU=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11787
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 870302cb-356e-4683-af80-08de541e1ecd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|376014|35042699022|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzVpZktiREVKUjR4Z0hEOEMzRXpFZVpiL0pOQ09qUkJ3azdMYlhseERqazla?=
 =?utf-8?B?SlhnTGVDM2xYL3daQkZOdC8xRGNDR0lQcVBBRHVWQ255M3h6RmJHblM4U1Yy?=
 =?utf-8?B?U0t4ZndZQnk4RXdleTF1bnduY2JaOW1oakhyLzJVcEJwSkpSd0RuQjNxOTd2?=
 =?utf-8?B?RFhaNm51LzBObmhuWFhjSzFBL1F1Q2VrYnJqODJaaUNQOUxjeGw0OHlFRG9r?=
 =?utf-8?B?TmJuVnJPUmJ2OFkxOEdCN3Vjalg3dnllemw0cm5PdEZMQTh3LzUzd3RoN1hF?=
 =?utf-8?B?Zm80d3VjVFJvU2podGp6VUVTc2xrQ0Zsd3E0TWJWVzY5a25GRVhrZVRQY1ll?=
 =?utf-8?B?RWJoTTNDczlnVERZUXVTQ1VQMmVHNDJIVDJqSlUxZ1ZwcWNPcHdpcjExTGlN?=
 =?utf-8?B?QWw3S1dIQ0R5bzBHM01XYWRVQUpGRTltem50TmQxOS9tK09WNVNnbExxaHIr?=
 =?utf-8?B?MiszK2x5a0xGVmV0bmZzTTdydUJBcjJ3ZG5TeUtQQWUzV2RjR0xBZy96SHEr?=
 =?utf-8?B?YytBaWg2ZTF2cTNzem1hdGtNMEN4NVpVeThwMjBPVjdmbU5RVlN1QnpKemNJ?=
 =?utf-8?B?MXkxaktqUVVUUzFpM1BMcm1GN2lzYVNtNHpKdnZ0bTNSaVpST0J0WkpNYlhk?=
 =?utf-8?B?NERBbkVFamRHUy95M0tZUU0xa2U1L2NFYVBoMk9EMXZyemZPc1luajZqRDds?=
 =?utf-8?B?VkF2NGNhOXBGaHZ4S0VObXU1anMxWnNzQmQyUkg0MzhLUktpRUFHWjRVblI5?=
 =?utf-8?B?ZWVQMnRDSDVHeWdhY1pWbGhic2wyRDVGa093Z29MYVAxOUxjQVVHczM4aFhW?=
 =?utf-8?B?TjlrUjJHc2xJVnp6WEtkV2t5TWRsdmZjVWVzWnJDZnBnbTlBWDNadEJFRUpl?=
 =?utf-8?B?NnJzeFhpK05nc3VIUjcxckM0cmM5ejJvb09tTGFlWmVENXZsT29RenRqUi9R?=
 =?utf-8?B?eTFXUTJ2SU9OOVpBL09yVTk0T2R5MmM1eDlVSmJoY0JuYTU5Slo0cGphSVFw?=
 =?utf-8?B?NElvaGtlQ3pMa1MrNjJNTXBXdGRBYTA2QmluN2drcG9Kb0RKQnZvZG5nZDBL?=
 =?utf-8?B?R1ErdUprOFZ2am1LVzVIWTdCOWIvdTFSZ3pJaXdJS3krUkN0ZUZkdm5GTGhZ?=
 =?utf-8?B?dWkrMmNzbi9EQ25wSVFKR1hlcVBScTdHdnhWUTNLQ00vQTk5dTRFTDV5cG1q?=
 =?utf-8?B?Q01CbFJOOVpTdGdlbVRQcHluUkJiVkF0SHh2L1BJeUhLWmxZMDM5OGFaOE5O?=
 =?utf-8?B?RWQwVVQ5WkVISnhKSnRVOCt2OU1tdHd5bHV0Z1pqL2dRZ21USyt2TWdHQTZo?=
 =?utf-8?B?dFkxSHRoTFo1NUROcDlVditJZDFrV0hjRk9SZGJwWVJHZ21QanlxTTU0azNR?=
 =?utf-8?B?VkxZTE9UdDFIODhRaUZWYVE0R0pzc0ZjdldFYjZTcGFrMUtGemxkSnNrblE5?=
 =?utf-8?B?NGNFRXIzL1ZZRDRCNU8xRlM5V2Q3YU9OeUdzQU5nVTR5a2VuY091bUd0dEkz?=
 =?utf-8?B?aVdpZmQwa0dQekdIMU5NS2xYaEtRa3p6U1BUQVNvR1FsUGpaeGRYM3U5c3FW?=
 =?utf-8?B?K2hLVjErYmExekYxUFRLakFQcTR6Lzd1Wk92NEpBWHNSd2Rhd2haYTNCeVJV?=
 =?utf-8?B?OTBwcEUzODRGeFdxVE1ERmw2SGg2WlhmMTF1bkRFdm5OdUpiZlgwRDJJZW02?=
 =?utf-8?B?QnBzbDhaUVlKMmxkQUE3NTdEZU5RM3JYY0NEMzdhbXNXV3IwZzdIdTN0Tmtj?=
 =?utf-8?B?WWJTUVdjZk03QS82WEtCdlB6KzBvQXFaRlpEaXM4dVVvSm13eElpWEU5ZXNi?=
 =?utf-8?B?TEdpc0hxTURqd2NaOEU4bEdvZGNHaFFXNWl2aFpMQVVQMzhCeE1WRjN6bUI0?=
 =?utf-8?B?VEZVLzIvUnlxcmVyYk9mSFZNK0QvYkcyNnZxK01BWFIrMnZSU2cwdFBEczFh?=
 =?utf-8?B?dk14a3pPaDJ3elF5NUFyNHhyT3NrSjYrSHV6WTdJaGphUGFsamNkZGJZK1U4?=
 =?utf-8?B?R3lpVjlsTkhBYzFqWFFsUUtyemxrQnZ4RGVoUmE1YUthb3ZnM1cxZnpLV0wr?=
 =?utf-8?B?emg0THlYVEU2bFMwTHNoYzd1S2lvMTZLeFRkbWIrbHVXRG0yaEpiKy8rY01v?=
 =?utf-8?B?YjlMKzFxcVVScEJWcW90MmlFZjhnYVJHS2hPWWRSTzJRRFEwdDBlWTF2MWR3?=
 =?utf-8?B?b2p2TGszQ2dUekVJME9IZVBUQzhjRHZZQTdmeXIzaDQ5UEhzQWZQL3VScUxh?=
 =?utf-8?B?dmdzTWtubXJYdkt3dnU2RzJTWStBPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(376014)(35042699022)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 10:10:10.5291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e69c0-c08f-4f74-7965-08de541e445c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9730
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

Hi Mikhail,

On 24/12/2025 09:23, Mikhail Kshevetskiy wrote:
> The were no any activity for almost 3 weeks, so I resend the series.
>
> This patch series consist of
>  * PCS and MDIO support for Airoha AN7581 SoC created by Christian Marang=
i
>  * Fixes and improvements of the Christian Marangi patches.
>
> PCS and MDIO support patches were taken from 'package/boot/uboot-airoha/p=
atches'
> directory of the OpenWRT-24.10 clone repository
>
>   https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-s=
table/.
>
> Original patches were created for U-Boot-2025.01, so the following change=
s
> were implemented:
>  * patches were adapted for upstream U-Boot
>  * Airoha AN7583 SoC support was dropped (not supported by upstream U-Boo=
t)
>  * minimal support of Airoha EN7523 SoC was implemented
>
> @Christian Please let me know if you have any objections against these
> patches getting upstreamed.
>
> Christian Marangi (8):
>   net: airoha: add initial support for multiple GDM port
>   net: airoha: add support for Airoha PCS driver
>   airoha: add PCS node for AN7581
>   configs: enable PCS for Airoha AN7581
>   net: airoha: fill in support for PCS/PHY in Airoha Ethernet driver
>   net: airoha: bind MDIO controller on Ethernet load
>   airoha: add mdio child node to switch node
>   airoha: enable DM_MDIO and MDIO CMD by default
>
> Mikhail Kshevetskiy (11):
>   net: mdio-mt7531-mmio: fix switch regs initialization
>   net: airoha: allocate string for GDM port name
>   net: airoha: declare airoha_eth_port as U_BOOT_DRIVER()
>   net: airoha: do not call airoha_fe_init() from GDM port independent
>     code
>   net: airoha: init switch before GDM port initialization
>   net: airoha: pcs: improve/fix building rules
>   net: pcs-airoha: unify code using SCU regmap helper
>   net: airoha-pcs: an7581: sync with linux code a bit
>   airoha: add GDM1 sub-node into EN7523 ethernet controller node
>   net: airoha: makes PCS support optional
>   net: airoha: use mt7531 mdio for GDM1
>
>  arch/arm/dts/an7581-u-boot.dtsi        |   76 ++
>  arch/arm/dts/en7523-evb-u-boot.dtsi    |    4 +
>  arch/arm/dts/en7523-u-boot.dtsi        |   18 +
>  arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 +
>  configs/an7581_evb_defconfig           |    5 +
>  configs/en7523_evb_defconfig           |    3 +
>  drivers/net/Kconfig                    |    5 +
>  drivers/net/Makefile                   |    1 +
>  drivers/net/airoha/Kconfig             |   12 +
>  drivers/net/airoha/Makefile            |    4 +
>  drivers/net/airoha/pcs-airoha-common.c |  827 ++++++++++++++
>  drivers/net/airoha/pcs-airoha.h        | 1220 +++++++++++++++++++++
>  drivers/net/airoha/pcs-an7581.c        | 1375 ++++++++++++++++++++++++
>  drivers/net/airoha_eth.c               |  368 ++++++-
>  drivers/net/mdio-mt7531-mmio.c         |    7 +-
>  15 files changed, 3908 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/net/airoha/Kconfig
>  create mode 100644 drivers/net/airoha/Makefile
>  create mode 100644 drivers/net/airoha/pcs-airoha-common.c
>  create mode 100644 drivers/net/airoha/pcs-airoha.h
>  create mode 100644 drivers/net/airoha/pcs-an7581.c


This series doesn't apply cleanly to master. Could you please rebase and
resend? Sorry about that. I've been kind of off-list due to vacations and
a change of employer.

Regards,
--
Jerome
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
