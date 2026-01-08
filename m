Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1A7D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8D18420C;
	Thu,  8 Jan 2026 14:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GeBp9BYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B0D83A26; Thu,  8 Jan 2026 10:53:21 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4009A8405C
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hb1SysYy1Fg3xAldrLEGOrJ12+D4XsJ4lJvQle6rJC4GttIOByRLSgUGD3GJDzavv73yKQ6esWqIcTqJVKFgU/IcFM4dxWe/ftygk6ktmu5HoP6Wr6FdSxWRuKUqAcj7LEik/d69qkVkltysdo5pLyfpJpfAYNIGfIz68Zd03bj8nMHyMLNa/QmkVrYRDaH6XNQ06klaon6mQc0hInLOHWlCC6pFBXSP/GqPvZ6wFb3iPRiK4uABvwdTQcHn81BZHCuFYFXHBDl7/3smDXG7laZeHK32tpP0mCWMFOHVs310Gcn8r2uJHd/TGFy4Rk6XT11//RhjagdF+SkdXk0N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXq/XDmxCdjgzu/3jbzYJHkKC3Suju1+ssFAcXwz2a0=;
 b=rrrWN+5JxZs0i5mm8l2e4C0bpGO/30xa78BiVALDq04fI/Mcwa9OlebHgPOisXNtFme76L1sZXv0Fj6GOinh08L0rbZOyuoQ8rYUOVnWGMyxyV5Vf7ehhVYf2bMFT61Mf+x2ZslaFzpVnUgsrn5s4BuVu8gpsBEUJTpr3yPNZavXyDR/30YP4f0fl4glNrzcalMDlXXV6dkyXQ2sEw7MbsgYOYLjyrEbAA6ZyCDBN4nuZQPM77MrlMvmxhb7uPs08coIr3YsYD4k1MXdyvb1F+VEnHXctXlHdmm3AKh8dzrXU+1D+IuQyI+NVviYpcb2CyD/l274IT+Sc41GppI/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXq/XDmxCdjgzu/3jbzYJHkKC3Suju1+ssFAcXwz2a0=;
 b=GeBp9BYe1bcKGhfvwfrzCKwvR/OaX8zzneJC8pFlFonMfDf2yv+9Mq77JGR3DkkxEnH31AJ4K+58s9+gW86dnCz9Xi+nxIFvkmXXKGkXlVK2AgVY2a7OJnrzYDrTFIY2lYISvI3DifXyFjHrDaPs+lJ1TxrXr3DskMYczPyKEAu+G8FiOPHvqHTi0iz2y6WTAUrLBFO31fAtDljAwYLgohOT2zzYPCiroV620OAV/DaMDjuTPBsUNouMzvlLFLnM/izIURVt2qRLhkb1V8ThEZZMysTjzq5vTZsCInygPf6hO7Pp6hJsVqdz9glHRtTYAFAAA1lZ8AkI3mi6Q8vVHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:55 +0800
Subject: [PATCH 10/13] imx95/4_evk: Add missing header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-10-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e64803b-d441-47db-2dff-08de4e9bbf23
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3c3UGdJT2IyY1RxOTN1Z2psckNHM2RLSlpmdzErOUNZUkt0T2g1eXFaWkhy?=
 =?utf-8?B?RzBnTGFBNlJNZkZpUWx1YUpIZjRlQUNSbGpnMzY4K0M4TGFieDFTekszUG5H?=
 =?utf-8?B?Yzg5c1B3TTRodjVnYWRzM3FvMkxicUpRTHVraTMvdCs1RjJlc25lZnd5Rkg0?=
 =?utf-8?B?WmpKRHdPUU10RFVmeTNTS2QyaS9MUzhYci96OFJVbnREOEo0NSswaVJHTWRT?=
 =?utf-8?B?SlVYZGZBQkpxRkNXekh4SXBtQ0JkWXlJZHpMUkE0RmZkQWhBcGw5MjdtK0xm?=
 =?utf-8?B?ejA1bW56MXhneFhXZG9menRVQzFGMDUrOGM4ZDlMbFBBTGdMOGoxY00rM0ZF?=
 =?utf-8?B?QUFvWDE2bXFVTW1RNDhqM051K1J6Wll1YklSOEdUVmNSSEhFSGZRYm1sb1Zw?=
 =?utf-8?B?Y01sR1p4NFZPazdOYmhkVExrUjN3S2pDK3ZIeklZNU50WTB6bzlIcmFrQVFP?=
 =?utf-8?B?SWhYZ1F0RkRNSDE1UnMwWGhKditjb1ZPZUFvUXdxNnRpUTQ0UDZuZ04yK1Ji?=
 =?utf-8?B?VFJrQ2VxQVdlYmxRYVdsTXpBVy9jVFNxV0VWalJ2VTR0Uy9CdkxDREk3WEIv?=
 =?utf-8?B?WlRjYmFKZFBVc3BzcGtINnRFM0xaejZoRXZIQm1TNDhiRFdoZG96VmVXeWl0?=
 =?utf-8?B?dkhPNmFMdGg3YlNEZXdQNWRhUjMyWW4vdkZ2Y1ZTTlU4U01jUGFZMHloMkhm?=
 =?utf-8?B?T01Pd3JBaVNjOGhWbHN0WmsxdTNiQlhabFlIOW9XbmpwSUZCb2poRkhscHFW?=
 =?utf-8?B?OUR5YklONHV1bHd1ZW5iZldXemJhZnBkM21HSFR5K09HK1JxUmVEMHNOaE9k?=
 =?utf-8?B?ZzlGK3hUWnpra1Rsb1NETDhkcEMydWlNMlVET2lQL1MwZUJsOGMxRFZER0xQ?=
 =?utf-8?B?OFR1ZnpRVGFiOUNsZmNJeGthdnRnTkdxZ3hFcGxwditSaW1TZ3Y1dzQwenFa?=
 =?utf-8?B?eEpUR05sb252aFJFcVRyMzA4RnVzZVFQVFJ4ak1GMnNjOEFqbHdDbW5VUXUr?=
 =?utf-8?B?TnptZmNNeGxrUVNtVWtTUFovQjNQK3lZM2FzelF5ZU81SDNYQmMreXUyd0p2?=
 =?utf-8?B?a1BRSGo5WVI5OUhBOVp0ZWVQV3hoVHRzNmoxRld0eGc5THkwTE1MSXBzWmFZ?=
 =?utf-8?B?eDV2ejIxYWZVYVNWRzllblNMa0FCdDh6Vll2anlaRStiSzg1L3N5c01FZHRj?=
 =?utf-8?B?bXZnRnV3OXdrQ2k4SVVOcXIvUXZpeFRYaEpPd250b0tMVVZDa0RQcjg1dmFD?=
 =?utf-8?B?RXl3MHRVZHdMR2R5UFprZ1lLQnVvUmo3ZERqM3VtWlpXRytsSDZlNUZVaHda?=
 =?utf-8?B?MzJDTTRQdWUyWlROR2NnU0FrNXNUYnUrM0pleGhVbHNGUkpHTGcxYWttbnBK?=
 =?utf-8?B?b2FDTStHYnFUbksyU0FGOXA4UlV4YURvRElRTGYyTDREM3VMWHhxU3RNTEVy?=
 =?utf-8?B?a2x2KzdHNEdPNnBQZDVsQ1V3cjBrYXJKWUs0bHRHVTVZVWZTU1RISzhVUnhx?=
 =?utf-8?B?NStEeXNQSVc2OFBJd3pvNFJoSEZCUzFYZVZUZE9QYVNManZFY1l5WHVYbWpU?=
 =?utf-8?B?bXFQM3kvaXRaSjVkWGwra1dOYXVZK1YvV1ZUSGpBbGFHZWxGR2E0anZSVXQ2?=
 =?utf-8?B?ZTI1d3Qxb2FzK1lQVlVQMWVQZGNZK2tNamJFdXBBWXhWMDQvRlBQeWZGRXk4?=
 =?utf-8?B?aktwNjNGa3JUdWVac1VBRzRMUmZoOEUwNDhaMm9Vcmh6K2Q2SFBWUGNSVFZk?=
 =?utf-8?B?QnIwZi9BRzJaQjR3VkNDRE5UL0taRXVSL214OGszbUZtUWJkOTJZZ2hZSmw1?=
 =?utf-8?B?a1BvNUc1N0lsRndBcVJZRGNTNXNuZnVkaGI5VExabTNYaHY5WUVlbXAyY3hj?=
 =?utf-8?B?U24wb29LWFViYnA1N3dHT3FPWmlacURTcGJMc0x5NGp5MzNWMWNvTG5FUmEr?=
 =?utf-8?B?OUVzTThQUUNUdUF3VzRGWjBFNU8vb1NnejdET0J3dzlnMEIrMWVTaldEejY5?=
 =?utf-8?B?WndWVDBtZXNWUVRpMFZtNk5OVmlmT1R1YW1oai9TdjBjS1lySjNGcnFmNWJs?=
 =?utf-8?Q?+njSCI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJSS0Z4YjhuMkxoeVp1WXliby81dzRSRWxSWEFhNmxlWDBRMGJjZnZYY3U5?=
 =?utf-8?B?bGpaUm9Hcmw4R3RBWk5xUEU2OHBYL0Nmdk1OZVFLMVpYVWZSSFBhaDJqZk8r?=
 =?utf-8?B?Yys3akxCYitkc2VEL2p3eFdiU3NvNERuV2pKMmgvK2d6aXlhUncwSFAvSnVz?=
 =?utf-8?B?RVZVQlJpbHlGQ2lwMlMwcGk0cktDekpSVlZ2TVJ2cFFWNXVHUXhkdWpYbmNh?=
 =?utf-8?B?TkVIUUJEem1aZ3hjakVrbEcyd2IvQmsrd2g5RmdKVmMwNldHa0E5Sy9SaG1m?=
 =?utf-8?B?aWpFQ0VYallIS3JtZjdoZnpTMWtKZm1TbHVxTWN5elpYZGQ2LzlONDIwaHVF?=
 =?utf-8?B?NklSK1V1bEpWT3hNaUhIYWtaYXc0VkREeUlKNktGajBPNkY2WTZ3UzFXTWVl?=
 =?utf-8?B?VUF6UXJiSkhBOVE5VDZmcVdjT2ZQdjFSMXVBc0RwNHRkcXZYalRLVGIyanJu?=
 =?utf-8?B?UlFwTzRtczljNzNvaWc0VG1CVzFjWk5sWFA4dys2OTFpSk50WkdEV0ZoVHRY?=
 =?utf-8?B?d09CQ1AvYjhMVmZiQmxBVzNRVDNQU0tZRnJ3WDR4U1ZEY2NwWTlmQm5vN2do?=
 =?utf-8?B?WHJ5MDVoekd6dDBnVFAwdnlkc3dqQTkyS1dPVEcvQllrbzZMc05MdHJLVk9N?=
 =?utf-8?B?amFtN0VaWExDREhlbGxKOXozNVBIb3E4dnVGRDkzNlZPeTU1SzlIUndKTGJ6?=
 =?utf-8?B?ZU5TTEw3bGtETXNDRUhER2grWEljSzVMb3JOK1lWVkNsMDQySlh0ZzFvQmE1?=
 =?utf-8?B?aHJZVU5RNEVUTmcrTUlBejN5cmxmd1J5WmN5Q29RMEZuQWhUcjdCVG8zUVZZ?=
 =?utf-8?B?ZUJGYTBISWNUVVU2UVYyOUtyd0c0U2crTE8vZkpyemRmY29ZOStlQU5vbHJj?=
 =?utf-8?B?SWxKTjhzK2FwUktBUFhoRXNUeVRYR1pXaUwvUFkzWGVKTkhPdXFXTnlIVUNo?=
 =?utf-8?B?ZEh1TUNFNVk3UmJVSCtRTXZHbFdjQ2tzd1JEZ25DZU9LRnJ2d2dkUHVlenhP?=
 =?utf-8?B?R3VWRDZCSVdOeWlKcGNZWnhleFdZL2NXUHljWXpIU3VPSDVKOXJIeDdFY2Nz?=
 =?utf-8?B?cGs4VGJTRndGeU45dWx2K0ZPWjZkaUVCS3JLcEhBdWNRTzU5MVVNeW4zNk5o?=
 =?utf-8?B?RElGM0I1ajhnTE1leDM4ZXRncnBQTWhsa3JsUTN5VUtYaHNGS1Z1YmxoZkth?=
 =?utf-8?B?ZTg5REZkdVlZSlZXZHFrUUVSSTFLWXNodHdGRW9Jazg5eHR4VU1pQ2dBYUgz?=
 =?utf-8?B?TzF6aWdtQ0NLR09pbjVRNVcrcUtwVVJXN0Q0QU8yaHIvQk92QUllcVY4Vy9h?=
 =?utf-8?B?c2VQUkpHWkRBT2l6TlFMN3oxOXA2M25MQllZd0FRL2NRNUZMUTc4WnFZQzdM?=
 =?utf-8?B?Rno4NDhnbSs1TDBnVUdXQ29RUXR4MnU2SFBETFlORzVsTzZOcllHZ3JTY3ov?=
 =?utf-8?B?T01MdkM3UUVCWDhva20vWjJTTy9kUlo5bkE0eStVNTNsb2krN3UzOFJJMTZy?=
 =?utf-8?B?ZXdvMS9SWndXT28vUy9CaUtjbXEvMDE1Q3NGSGNTSWpsdXRBV2RlVVpQckVk?=
 =?utf-8?B?WEhwcS9aeHU1Q29qZ1Zrbmxjdkg0cGdJdTJsQTVzN3hmZlQ5ckVWaGhmK0tn?=
 =?utf-8?B?QkQwK05zb2d0MGJKMzZSU0VDVUt3NHlPRUxBTDZRQlFXdDcrcTBhN1gzTVZn?=
 =?utf-8?B?dHJvUkErak5zMzdBOW95aXpoLzVQN1h0UDF5ZkxIN2JENHR0WkZRR3NSZjQr?=
 =?utf-8?B?d1d0enNhUDltOXpnczJxeGpiSXpYUmdWRGdycnd4UFJ5cGxGcFRuOXV5U1hF?=
 =?utf-8?B?Yk9MeXJySUpzNmpYVC84NE01UFpXeHUwSE5PNVBxYmI0SjNhazNhbXREQVFz?=
 =?utf-8?B?S0xDbnJLOUlyWm5xMDNsYWZaSWhpcy8vYXByRm03Q1pyVXB4dUVVYmJTQ3JB?=
 =?utf-8?B?dktCaFJiQVlkTzlZbndwV0xqVXJ3aVhZSy9ZTU1uV1pJZ3RWaTRHbHpyaFFK?=
 =?utf-8?B?RjlJdWtZcWRvdjFVdnlibXMyYnZ2bHNRYUs1VUM1ZVVCVmludHVvcUxIZjBp?=
 =?utf-8?B?bmhHRGx5RjQvRGNLd3lSeFNmajhSSG4vcFRINEhDZ1QwRGdJUFBLZ0ZLc2Nk?=
 =?utf-8?B?VHZsaDFDOW1FZHRRRE9YdnN5NW9EYldVbTJwMWdzd1p0YllMOXdEN28rSTcz?=
 =?utf-8?B?ZFdiVmp1VDZYdzZkNGJHZHBQUGF6NTJIUm56VE0yekw4UnRMSVYza3QvZDc1?=
 =?utf-8?B?aU1HVXFaTUxER1BIMkFDRExVUGhpMlpvM2M4Z1BjUTNpVytTTUVEbkROQ0ZT?=
 =?utf-8?B?ektRSlA4eXJWaVZQVjJDVStOU1pLQXo4dmtNSi9yNW9vU1R2VVo1UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e64803b-d441-47db-2dff-08de4e9bbf23
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:16.9422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOF7CFFtjuGQqzp2HCmPz0RXPH+Wp4zrqlAEAnr495hjE6EKQjPeTaG2jWS7eIldIvXEL9Uzw/Kg02N+0PbC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

From: Peng Fan <peng.fan@nxp.com>

Include asm/global_data.h for using DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx94_evk/spl.c | 1 +
 board/freescale/imx95_evk/spl.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
index 0aa75ea907e..797806a8d4d 100644
--- a/board/freescale/imx94_evk/spl.c
+++ b/board/freescale/imx94_evk/spl.c
@@ -7,6 +7,7 @@
 #include <init.h>
 #include <spl.h>
 #include <asm/gpio.h>
+#include <asm/global_data.h>
 #include <asm/sections.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 90c7429272b..752d7f916b6 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -6,6 +6,7 @@
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/global_data.h>
 #include <asm/sections.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>

-- 
2.51.0

