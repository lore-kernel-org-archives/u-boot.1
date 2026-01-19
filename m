Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C145CCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B8983A2D;
	Mon, 19 Jan 2026 10:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="PBNLr3sN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PBNLr3sN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA19183A64; Mon, 19 Jan 2026 10:33:57 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4E983A2D
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UIXX8zwQ0REpqDwj12RvHHQToGZ/ACO6wFOeMXjJqCvaoEkW2ARVGBL88cpw/t3iNxyQPepHdZDkFdSMqYUUXrofFTvhNK3T7Vj8/pIgYgh6ZBoGe/VjIS5O4jsA92hEwYBVfoKKStu1i6XNcQstDz3aB4ngGGhQzWZ16W+sh2cxMLxz5O7WWugwx8D6+OkLu5Uj+XeJe2wPs8ngJ/WR18NNn0BKVkP0PlbW1OTHJr/LhIvAvSKHiSY1UhmQLA0ySP5bXk+ZKfk2wotfYqgtjZ5OE51kQcOzaLjfuhqXAJc2ZxdFKUkbw6lTytlIU4R2OBVnbsujR7tdI6oBDf1LRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=DNksLPDzxPojZR9QhZuqBD582vSX+3JOA16DBlIemLZ2h6ykiuf4z0Cgo1acZT9HaE0lyvTkrt9mNh+J/51XOIyAXS8Fr3PaRlWb+9+0IdD2KvihwdYjhZd9YEPtrNNItpXFR1OCgWoLUGd1sF3UCuqFeIOHiduKcVcvqRtcDPU4E+J2BzzUHd5Ax1zKOdmyXsY+jhsQ5Nd7Nj2W3MeJswitLnCpC8mxveT44u2Ag9Syk/Wbr0dwVqOQvJLH5xbxC3E2YhvVq/OyOH1Z6XEvFXpq921LnE44QnxNsF0VCqmkb/Ac2XpMn8x8DQuEeV/gY4P6ZEYmAdtR4VMYCwiKig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=PBNLr3sNkgJLKDjL8abpCPyRDVwjn7FHzFlwj9X8IPq8KOa+Q9+HRNMOZ7MV7zHG7xDQzhfQgEgPOBjQC5fLlrVuNZkHFbXAqCL5B6LeuqNVU0TmGphfxY31ZvPu8wqHvfaYv+bJCbRLqyHQNKgoxZrAWJepjmIVL6FLB1HD50s=
Received: from AM8P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::28)
 by MRWPR08MB11757.eurprd08.prod.outlook.com (2603:10a6:501:98::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 09:33:53 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::68) by AM8P189CA0023.outlook.office365.com
 (2603:10a6:20b:218::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lftjeOPisgNfZ7/iPIizgF8Dw0uufZoXFqOY1nkD8JIz64MeP3oA2yRLBdCjroJ0Hzy83/PMsISeiuDU5StvRPNexgJHz5aV/TcXnX9aQPSzwnB6ZOaOqTHggB2tliaZTHWk89JUCFYeOoF+Uzp+WN78GXgcrOn9QDfLr5nDDUq5VDVqnOtAGpedGBlsqJzfVT9R121fP4IY2edyKWEXOagRpnI4pCrtF7i4BDXWVxYFrZetjcmF4rgld7DLwSOzKjrcDQ3i23NK1hJu4y/uOzDqQxRpAG0lEJlwHTTaPhGZgHFylr/aJJOZ4FCqQoZvfzxx1GqA8UnTs18m5dfQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=M3cALw8Oib/9lxwvnLbtQlKKZSFLQOrHsjBZyew8u33z1taUl00L1p+YqQwVTuqucmspRJ+16msq5EsnVjN3e0Tu0YNc4355BG//7lba4ogi3lCkjLTnkrgO8d3x2/g0pNs/gdLyqip2CdBMdFOWdHKzz5MpNeb+1/AMsj7C33IAQFMqlpiOcU6HTcavR7dlizdDJURjk9RyYKVe5IXkUAEie9/TAOu41pw5HJ2QHtTWd6FhyFrdji4zrEe+vVhWTL3S7WWj+xBbPyA2sdiwvYFaCdiKO8BTWf6PkZmgdwEiI4sRg+Iztfs8+30ET5z10uKKxOPh+5jKFA9qPpIZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitpWjJAj4s3Uo3Juv4s5Yxr6KY2lbgOC5pjVaj6sAw=;
 b=PBNLr3sNkgJLKDjL8abpCPyRDVwjn7FHzFlwj9X8IPq8KOa+Q9+HRNMOZ7MV7zHG7xDQzhfQgEgPOBjQC5fLlrVuNZkHFbXAqCL5B6LeuqNVU0TmGphfxY31ZvPu8wqHvfaYv+bJCbRLqyHQNKgoxZrAWJepjmIVL6FLB1HD50s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS4PR08MB7629.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 09:33:20 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:33:20 +0000
Message-ID: <a4c10cd4-0fa9-449f-9525-cc58b343eddf@arm.com>
Date: Mon, 19 Jan 2026 10:32:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: lwip: tftp: Do not write past buffer end
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 nd@arm.com
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS4PR08MB7629:EE_|AM3PEPF0000A78F:EE_|MRWPR08MB11757:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f39232-797d-4f10-88a5-08de573ddc00
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TjRnMjZ2R0V2TjFUYms2bXNSSzBHeWtVMkJXR3RYaFdMc2RFSkNuQm1vdmZ3?=
 =?utf-8?B?MXZQNjdveEJkN3Izd0p6ZmhNZDlYME5FNDREUWZ2Z2RvWXJSV3ZSSktlcXA4?=
 =?utf-8?B?WFcrakJhZm1pTDFUUWQ0eTJFMEs0dk90eHZCMCtqUENqRzBxSDNXVlM3ak5s?=
 =?utf-8?B?VUtKQlJqSkpoKzZ1S1B6OU1VR3BpY281L09hVFR3RVJhTXovTnlHdVpzM2d1?=
 =?utf-8?B?QlJub3krTlFEZDJOWUVuVlgzdmYzT2xBTlFVbHdzTGdlVXZDK1d5TjUxV3FL?=
 =?utf-8?B?aFJpVWUzOHdkRXN5NEVMUFlqWE9RREdSK09RV3hFaEFSb2w1ODdQN0pNRi92?=
 =?utf-8?B?RklZTkFnM29sWWxjZXJEcjFLZUgyWWF4aVo3WEozOXB4THVDSWdUdzc5ckNp?=
 =?utf-8?B?SDVJVjhERWZERGVvL1VGdlRPdy9zTS8xT250OWxpdUFoYVlGR2RQdFZTcXd3?=
 =?utf-8?B?Y0gydUNCWVdzUjFLOEJpZ2o5eWR1UjB2c01pR055ZVkvSHI0WkFoVUZ3OVBk?=
 =?utf-8?B?Y3BCUWE2NGx4VGRQS3FpQnRTcWVXTnVqZi9vUUViaDhNN0ZoUHUrTVYvdjlF?=
 =?utf-8?B?R3VRRC9rT2FqODdkeU9VUnVkZGpsanFUVDZoUjUrN2dwY1ZESmJBLzlKOEhp?=
 =?utf-8?B?QjdsQnJJNVRqVHZIWDBhc3FKcnNiM0dEeHJGNlBQbWU1YlM3eWZiaEVHMzRI?=
 =?utf-8?B?QmpTaStYNnR0VkxtelZ1Nm1pcUNnNkROTGc3QkU3bmpTVzRpUU12eFljZXht?=
 =?utf-8?B?RlVWY0VjeTRPU0xKSTBWWFE0M1YyRjV6VEc0T3JWZzg2TW1aRGkwc0ZlSWI4?=
 =?utf-8?B?V01ZUFY0OVFPV3hrV3NBQzVKcy9DUXpnSGhqRzIyMEJaSTFWcUphR2dQZTNI?=
 =?utf-8?B?dk1peDAyVEpmeGNzUmJYTTIwaDJmZyt5QUdvaHJwZkVRcGtsVHVKK2dSV2lP?=
 =?utf-8?B?c1pEa2lPL29DLy9EcnNCSEFDN202ZmpxdUR6ZTBPWGUwa2FkVzZPUk1zVldp?=
 =?utf-8?B?VnhSTVNicEVqWHlJMGk5UytMVFM5ZjliWHdSL1ZkWWgvSW9OR09EeUNWQWZP?=
 =?utf-8?B?S2htdXE3QW9BZDFrWEdEeHJJOGFTWnZqR3JQQ1NQTlM4c1cwbmlxMERIbklr?=
 =?utf-8?B?b1UzVCsvSlcrYkhJbCs4ZEhYWW1mRlNNV1BDWlRHV0ttb1lRVS9waHRoZlls?=
 =?utf-8?B?RVdDajc1cGNZNy9pTlU0ekRqSG5BenlDTFhIS1BjdkNWVGhEYkE2VlIrM3dR?=
 =?utf-8?B?TnpoRXhQZ0xPelZwM3A4ZFY1QlBtWkJiNEpKQVJZSDAya01KMjlOVTVoZkcz?=
 =?utf-8?B?eVo3K1BmSmxWVkIxSlFsU1pidnZzQUhaVWpPcXFrMHhpN1J3cDdYTHQ1TUxi?=
 =?utf-8?B?cWd3TXgwdDA5M293QTY0bU5WYXo2TzZHZ09xbmI1QzB5MWdFdnpVRjgyN21W?=
 =?utf-8?B?eWlGWXlQT3JtOFZUNU9yRjg1TEJZQWVnL25LT1JlS2w5cng0RlJ6RFovTFVi?=
 =?utf-8?B?RGpXWDM2NTN4QmExLzZaRTZjdG03Zi92dGpyY2FKR2FnR2duM2NpQUI1K2VO?=
 =?utf-8?B?YzlKTGJTOS9vbVErb1NKZGhOUW5PSXlvdWg1MmlQTi8yWVFGakVUVGxFQmlh?=
 =?utf-8?B?TUJXNG9xdEgrK3FFeGNnU3dsS3lMbzFSaXZ1UG0ybFhZM1NUaE00M2ZleXZP?=
 =?utf-8?B?akJJQzV1YjRJNGxWRDlEbGFPK0lzVTdRN0ZLV21jSDluaGlPWiszZEJ2NnR1?=
 =?utf-8?B?ckZMcFd0RGNJVnNjWlMvT0ozUGxiaVplRDczZWFhQm5VeDNrZzUwa1JmajNV?=
 =?utf-8?B?VFZYMGVVTWJrNFpaK2ZFTTBNN2J3aGxBeFg5MFFZTlVncHhwaHFBenFSV2hj?=
 =?utf-8?B?RWU1cVVlZ0crWnYzUHRzbExpUWx5VnpzZHUxZzZoaVhUcnBqZTVYbUg2ekhn?=
 =?utf-8?B?VUROZDdJNGE4STFQWitNNFpXKzl6Q0VoNWRyWDAvdXpLUjdWUzNNVmloS0Q1?=
 =?utf-8?B?Rkw2dEFqc3ZVRkhyVEpsdTJvNUdqUndvZGthZFM5Sk9UdEYxQUtJZG8vZC95?=
 =?utf-8?B?a0IycjdGMjFyK1NIM3RjUHN2UnRlRnBYQzUxS0h2V1N5bmhRQzhUVlAwNy90?=
 =?utf-8?Q?xNec=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7629
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1782b9a4-482c-48d6-eae7-08de573dc85f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|14060799003|82310400026|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmtaMEhFdHpscjkweXNLZlV0TTJ0TzBpdm5rRG5qYWNmMGFSUGdqaVIrT0Zj?=
 =?utf-8?B?eWlZZmhhRnBpZHdTTkMyM1NTaWVxRUJuSm5BMWU0eXdxQnZ0dk1GZUxnSDJM?=
 =?utf-8?B?MUJTY3dBUGVQRjdGZlIzclM5enJ5V3V1RzRDT3p6NDBHbmExalFGR0NKeHNz?=
 =?utf-8?B?MWg0dHIrR3Zmb2t6Uk84czdaeFRhbGtreUZXQzYzNk0yNHhEVmwwNkd6cGVB?=
 =?utf-8?B?TEVKamhYRUVCaXNGcGw3MVNXSkdiME5kR21nNnlSOURXVHdkbHRQRDdEVEhx?=
 =?utf-8?B?NE1od3l5VHAxWVhFMTJzMW1hbGRFZnBjWG9HaHAwclN2RTRYWkJBNUlrQm0y?=
 =?utf-8?B?ejlFdDY4TGxESW4wYmlWTXJCVWhyZjg1QU8rNVdjaVh1YVQrelcvQkVycmI0?=
 =?utf-8?B?US8wNFNaM01vcC9aYkhaMVVzUk5NUHlOK2o1RW5xVEl0Y1lKMXZSNWhsU0ZG?=
 =?utf-8?B?OUhMOU5ZRGFqTFpOcmtsM0YzT2NXbnNVb0Zna2dOQnV4SUFZOW9XUVNhMjJC?=
 =?utf-8?B?V3JxSlFrNkIraXE2OVhlOFJCS0g2eHNBWnJiQ2FmWXdJQnd6OU9oSkZXMU51?=
 =?utf-8?B?cjUxNGFkdytRSmczUmpuNzdINlZWWGw3dnVmazBRMGxadFNZUlVXSXp1cTRk?=
 =?utf-8?B?Mk8rUm5KbHYyeGI3RjZLMWZvNTA1ZnVaTFZPV2tzWVlXUy9NYUVhak90ZGZy?=
 =?utf-8?B?eVhRTjk3SDRlcFc2dkZ0VnJIeWxoUzY5QkFKUWNocDY5WjBsakN3UzZTOEpj?=
 =?utf-8?B?dEJvVnZpcXc5ejNuMkVBTFRuYkpMT0FPcUhZUnJwMEI4Y0NMUUVDNE5wY1dm?=
 =?utf-8?B?czJFSURQNHowMnQyaVp0THVsdVRJY2xqSGhVcnExQWJlaUZqTmt1K25xYi9Q?=
 =?utf-8?B?WHRLZ3VEQmVCOEI3Q0lQeG1GMnZ0dEJzQjRTbmZhc0pVTW9JRkhtSkxIK0RR?=
 =?utf-8?B?TGpWaVM3TTUvMWl2cFJYZVhaTmN4OWRwNytTQ0NrN3hhQ1ZDUW04NzZFUDRu?=
 =?utf-8?B?RWlmVkZVMjhDaU5NczlXSmlRM1ZFdEYxb3FjaS9uSGgyUVJBNVZ3YVZjMGhh?=
 =?utf-8?B?bVA5WlVadGhlUDdmVnZEbjFIdUVaNkhXUVBYOFcyYW9lbm9TYlVtTUVWdFpB?=
 =?utf-8?B?aTRiUVhXRWtWalZ1QTI5RjQvVG0vNXdNTGt5cHFmUi9iWnRYNlUvMGNhR0ZZ?=
 =?utf-8?B?UTlvdFB3ZGFrMGFpVkNmdGtpcG5wYjZTRjUxRFJaL3FBN09CUzFRQ2s2NkJu?=
 =?utf-8?B?cXRJV3N0MEFSb1VIQ2lvOWprTC9aOHIvV1FCZzVzM0lKY1psWnZqNWZ2WXlQ?=
 =?utf-8?B?SFNrcEQ3YVRzbW9GM2RDOWlTdkNYV2dyQ1ArSFhMNG81WmtHRDFCUFZwbnVh?=
 =?utf-8?B?eUVSQnlwS1pVOVgvU3dXY0p1R09XTVZsWCtUb1UvbC96MzBORmNaZzVwU0FR?=
 =?utf-8?B?UmdSOXUyZ3MvcnB0T2FOMEwrMlMxa3YxMDNMVU4wTytDNm1GUTZmQnRMQkNn?=
 =?utf-8?B?aHVzWjkxS1J4RFRka09JN2F0Vmtyc01zM2Y0cGFwTERJblBNK3RCMVlNMWd2?=
 =?utf-8?B?Z0QxVTZycnliRnRRRHdOVkZzOTRiZlo5ZWd0YXR5c3lVaHBsazhjV3N2Z2lU?=
 =?utf-8?B?aVdIUk4zK0NJTUNlM1RXaVErWGZkV2xLczNUR1l3aHVSQnVOcE9DOWtJd0g4?=
 =?utf-8?B?aVJWQmpsZmVsTEJxbFNxcTRUWTZlUFROSnpHYnV3Qkk2c1h2cnR3ZU1Cc2s2?=
 =?utf-8?B?L1JQbEtmYmZHYzNNS3RMQkc4Z2JRdW9jSDFMcDFTOEdyOTRuT2FhR3ArVTU3?=
 =?utf-8?B?d3REeU1QakZRMzBSQk9Hb0EvWStGNnBXemtMQ0Rxa0hSNG1oVHNQRTh1d2Vm?=
 =?utf-8?B?RGZRRkdpeXVjejdIaGNNM2xRU1ZtZFdEUU9kc0xzUnc0ZERpcGlxZnRUZTEx?=
 =?utf-8?B?cFg5aVhia21PM1FoaStpYUhoTzhoVXdlczREZHJWYldEdHUxa1lYN0RnRW4r?=
 =?utf-8?B?aW8ycWJLdHBnWGxabWNGWGY0c0s1OW1PeTRMNVMvL2JtV2dON2xYVkVyTGh6?=
 =?utf-8?B?cTgrTEJXM2Nwc2ZicXd1Nk90SWdvS0orL2UrVzVFS05vLzNNekNkZmNlTHZz?=
 =?utf-8?B?bytVS1lxM1NPQTE1Y2RLdUphdzVlT1dnbXM2YjRSZzJlSEFTOG9tZHV2SmdU?=
 =?utf-8?B?ajBmeUZpVVdvMmRXR3RRRVd4ckMrNldac3U1ZFNJaXlhQ2tqcGpFS3lXeWpG?=
 =?utf-8?B?S1RWRmk0TEFhMG5vV1lMSUc3aG5nPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(14060799003)(82310400026)(35042699022)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:33:52.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f39232-797d-4f10-88a5-08de573ddc00
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11757
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

On 14/01/2026 16:12, Andrew Goodbody wrote:
> sprintf will add a trailing \0 so manually adding a trailing \0 will
> result in an extra unaccounted for character being written. This
> overwrote the first byte of the following allocation block resulting in
> unexpected behavior.
> 
> This was found by Running 'pxe get' with no available file resulting in
> multiple attempts, using the default algorithm, to attempt to find a file.
> Eventually there would be a failed assert when free() was called.
> Failing the assert would result in a system reset.
> 
> Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to client")
> Reported-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Michal Simek <michal.simek@amd.com>
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/tftp/tftp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index ecb6c55ae1100779187e7b138d098a0ef1e48ca1..25da952e92566cbca1c64bc89c89102e74d0a42c 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -191,7 +191,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>    MEMCPY(payload+2,              fname, fname_length);
>    MEMCPY(payload+2+fname_length, mode,  mode_length);
>    if (tftp_state.blksize)
> -    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
> +    sprintf(payload+2+fname_length+mode_length, "blksize%c%d", 0, tftp_state.blksize);
>  
>    tftp_state.wait_oack = true;
>    ret = udp_sendto(tftp_state.upcb, p, addr, port);
> 

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
