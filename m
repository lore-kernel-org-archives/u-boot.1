Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED6C52D1D
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67F5889C3;
	Wed, 31 Jul 2024 10:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NFzbDkWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37F2E889D1; Wed, 31 Jul 2024 10:29:08 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF74889C3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuTmv2qnUDc7TYwdPO4EQaL4H0ApjhGuNH9ttXxOmEb/aqECycQ6tnCLggKEw8u/2njdm5C5ugYZXLgG83ynTeE2Vfk1yRba58kwhr8f3wmkG6BElcUdV0Kr3f/R6UW9DB8HrmzDyLT5dkkRs6kntjXzrll7VGJNxpSpDmO4lP8m6mhhiWqKx4AERvdrUiTHRQw68KkdhtfW4rxSNP2BCRVVQW5hneQ1vin1kaXrCGKQZXZCcP7a3rogo8I+C5BRUDTfH76pL2yE2aOYdrA7+s/rNc9H+DeO9gKwtA1sbhahrZNQV27Ll79TraT+8XI54PjRVMk2KpDTzYoQeVj37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/IiHZCaTsfuOwhGGvYe2YhrESLhGHjigjYQh8WIu44=;
 b=X6rWKPd4X1rsMlSGcleq9dqLzxTN1WD+Y2huyBNQfEB5hQe/VaasQdQ539vxeGMDEJodQJ05mCa9yEFJJaOvEkko66G2CbR4RZuE0ojrGHLAxyCV6QUNbWdNCZZPpDH5HJDb+apH/8LEkDSjqOPIKKqzSU6QhOm55TTemepZGt63WUUV4OU8m9PYpoqyk3Zvmonks6mCzWxvQ2Jdpb8SWGxJsXg8X20gdDT+plC2qZhe4tPgGIP/e5Zs2fVneSjph/XosGpok8hMj2zPEuzltdvkHPlDoM4aZsCSPK/xdQvRXdW6RxuYdntgFdUK6AugV9wA+lhMutKwx3lFciyREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/IiHZCaTsfuOwhGGvYe2YhrESLhGHjigjYQh8WIu44=;
 b=NFzbDkWp2v6v1E/iMMUejqskyfrLqyaCDEKoXujpcNXzKJiz1YaAuwCK8q1r2yr2vdFmoNFkRC09yVABTd2/EN2u4b3VY/CWouy/VQX5tJSkn+sC8d4/+3bXMmyKcRXms77+8UZs/VgR2ss4/SQfgx+Y/YriMne7jk3skA44QeXwP4POHkM0z7nQRuXTwKSTxSjqlhw5uhP0dKDudikSzSkg/sL4/dF57i1sZPHK0111RRrCjAaeb83Bw8tFgojjZ1zVGNTaytV6IIDNQr6NJ2W1mdet7IvhbUtgvNd/cAXuqZORJXlH+s7w7sKV6l8eqzefSWHuN5TpW+mxy/DoIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA6PR08MB10471.eurprd08.prod.outlook.com (2603:10a6:102:3d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:29:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:29:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 10/10] mtd: nand: add initial ecc engine support
Date: Wed, 31 Jul 2024 12:28:24 +0400
Message-Id: <20240731082824.3890809-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA6PR08MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab52d48-b5b8-499b-6aa0-08dcb13ad3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|52116014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFRLdGE3QUZXTzFxRnd2Z3RyWGdKTWJ5d2VPZWF1aXEwZXdlbUd5eGtvV1FK?=
 =?utf-8?B?S0lPY3RtRGcxU3lFemhnVkd2OWZmK2xnS1pxbjZVeFQzdVBxbmZrUjlqYWNT?=
 =?utf-8?B?eFRGTGoycEtoSkdjTExtcW43UDV1VmVCcDhaUWpSdlJ1ZzdsSmc0MWEwdjBX?=
 =?utf-8?B?aWJaREJ0UXgyT0RYTWw4L0I5VmFtZzRnNDB1Q0g1K3U0dVY4SERWRWVIbzdO?=
 =?utf-8?B?TThrRUhEMHhiMmxiNnBJKzRPek5XOTRRaXVpOXhyZ3FlR290WmlkSVUzcUNj?=
 =?utf-8?B?ZC9QanYrbVVBdzhkMk4wLzhISmhBelNGeDZUY3VOcUlPM1NvbW1taklRdlN1?=
 =?utf-8?B?K1NjMStGOVdnMVZ1WHFvMU1Tc1ZSK1NaMEgwbzNMdzhjS2pSODRMRW5ZWm5M?=
 =?utf-8?B?TFF4T3hUUnl6NkZGSEFSUThOMVNxb2ZEUWdDSzVXbzdUQ3hsUFZYTlJ0SVhT?=
 =?utf-8?B?YVJvZE9ONWpFd3dmRjViSUJQdmpBckxuS3BvQmcveXo5SCtOVm55UXJLWFh2?=
 =?utf-8?B?cjNXNm5ZeFpIeWdjSk1MVnJzYll5aGc0SkRRVGhJSDR3T3h2bEpuYUpYOW5M?=
 =?utf-8?B?dW9NRERRbnFXblpqbDJ3RUNFV3lxSjZlaExidXZZT1BFNnBxaU1Gam94WjYw?=
 =?utf-8?B?d1kwRnhEZyt0VCtRL3JQUDdyUEhmRlhVYW5IaEM2VnJrRm8xUHE5eThja3JN?=
 =?utf-8?B?NXJLT056RjQyZDhrTldqaFlPQWpxU2VYT2RwL2lHTVhmQ3FVOFZScXNnak9G?=
 =?utf-8?B?Y1RGZ09oSTVUbDdqekJpYjN1dDZaUktzVEZYODFaQ2Fhb244d3RYN1d3RkZl?=
 =?utf-8?B?aEtndDhIRC9WcnlzYUNvZ1kwVWNSWVBQWGg2WG9EaWNRQzhibVYvMzh0OTJn?=
 =?utf-8?B?VHRwWXFZNVlPamJRMmdNbWNhQ3lpd2ljRklkd1ZoRlJPcXRweFRPVmx0YTB5?=
 =?utf-8?B?QWVQK2twTzNvR3JicjBzNVN0TkVnd0JjTmcrM0VzT1dCSFRaVlB0TFdnNVBI?=
 =?utf-8?B?aE9kUlFFUkNnRUt0dGpRWGFreGd6ejFaTWtHc2tNNVhaOGRGd1EreUhCNUVL?=
 =?utf-8?B?QnpRbHV0THhpU3VjWTZKalg3MUcwa1JYV3Z0SjRkQVZOZGQ5UGlVUFp1NXVU?=
 =?utf-8?B?WXhoa0FMRlFNZGlkL2V2MmIvQ3NlQk1IM0lGVmFaQmpKMzBHVUZpWXNhVlRR?=
 =?utf-8?B?dlR1V3pqbU1kWk5YbmRxbzBVSnhQNXRmeTlWdVM2c1VzcXNzWVNDL1ZlWUdI?=
 =?utf-8?B?NmJhdFNXL25zdnI5TkNtZEFabnk4VzZKQ1YzNHptcHRkMWZlTnp1RndDanRH?=
 =?utf-8?B?SUxNbSs3VjFlaExRSlZDQUVJbTIwYVhvamM3WC9ONnU0TlNKZWZ2eTRsN0hx?=
 =?utf-8?B?VVlNNmJadEQ0UmQ4SExpb0wrK1dYRkREWnZTOUJvcjMwc3hyNjR6dC90c25q?=
 =?utf-8?B?MnNRTWFNWWkzY0NQWUkyY3Z1MWNBNEJLS1kybXVSUXEvMFFQaENJYmVnK1VS?=
 =?utf-8?B?L3luTjl4N2tNRG84Q0dHdzJ6VmNYRmlzekp1RXRBSFpQNzlsU2FmTWRPci9t?=
 =?utf-8?B?Ymg4MWpEVkpxOXY4UHNYQ2d4ZlZTSUVkbnZXaEpPVzJYd3JNbDNRdWpsUnpm?=
 =?utf-8?B?Vm9zVmVpV0ZOdnY1UW9jeHBjWm5ZZGQ2eUoycGNJRy80amtQeXM2KzBrTVVG?=
 =?utf-8?B?NHhsZExSV0VVaDV2L2tHN1hMK3dEMXJJNWIwMXg0a2FrbjFBNXA5dnNaT3Mx?=
 =?utf-8?B?czJSSmE3cjVoNjJzZlNvWWw4VzU0UUt2R1MyRXdCYjU4dmtVbGNTK1BHeWtP?=
 =?utf-8?B?VC8vdTNJVVFXTGc2MDlsZHB2N29YUnVqT2l5dGlYYjlRS2JxWEoreWs1b2N3?=
 =?utf-8?B?Wm1Fdk5SUGFxanFKV1ZhMVEyQWVuNVFhTlFLZUFIZkJNQzV2Z2JtckI3eGdo?=
 =?utf-8?Q?j4+sPh/7aSw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1I0TDhWaW9hd2NBNTBtOXd4b0xiTEZjT3hjbTFjaDVvQ1JXNWFsWDlacEIx?=
 =?utf-8?B?cXhjVExSNnhLUk56TDM3WXpyQXBYZVZUaFZSR1k3OGpXWXNWb3R4QU5CS1pi?=
 =?utf-8?B?ekxYOGxYZ3grUWdHWHQ5TzBUSklRdmZZVVA1ZU4yOGpTaU1XU1ZOclQzRzkr?=
 =?utf-8?B?VmVXQ0VvZ0pnNVpkN09ZVEE5TGs2endwWmJGUy9aWVJsZGV3M09OQzBGVDRl?=
 =?utf-8?B?dWpsdGNGay9KUXNLR0JSRkRuOTgyNkU0ZzhSVkZRKzZEYTB1MFMrT01EN3Q3?=
 =?utf-8?B?c3FRQ2ZRV2IvbkhUY2VyV0F0VGZIVkhhZVRsMFZFQmpCNldtR1RzU1RjZVZ0?=
 =?utf-8?B?TDVsRGFoZWRJM0hSekVFWmxpdFVQL2g4ODdnMzR4eE9yNmV0OWZub25HOW1K?=
 =?utf-8?B?aUI5RGY3QmJhWXA2bm9YWE04S0tDYmoydGt2dnQyck5Gb1pDa0g0MDI4U2V3?=
 =?utf-8?B?dTh2NjNQbkFvQi84U1cyejBRR05lcVdzbzQ0Z1VWbkZodi9CNGdUTVFFQS94?=
 =?utf-8?B?NitKRXJISmhzUS9yK0xGNFZCV1lLOGxsUkxMSEFWRGozb1hOZXczUGpid3Q4?=
 =?utf-8?B?UUZ2WnVScFZoOGsvdTY0SUZFRmNiUlBuNEZGZ09pSXZsRDFuQW96QU1GNXBQ?=
 =?utf-8?B?aVNnZkc3bERWV0xWNmRtMzNOWlA4QjV5MWhGdTg3N1hrY0IvMnZLWU1DZzlM?=
 =?utf-8?B?bVlpelRUeHpvVHpmSG5Zb2FwREhJTndoSWY0enJOWWpRQlluUUwrVUdHNjE5?=
 =?utf-8?B?RFkvOUNmZ1NDNFdvZ2QzZ1ZIa2t4c01HOEYzOW5SKytiY3RReG01WVEzaFRi?=
 =?utf-8?B?NndKZW9NeUs0R3U4TmZtVVpiRW0zYWo3TGpmenJFTGFDV2xjb3ZQMWkrbXN6?=
 =?utf-8?B?YWVadis0cHI5QTBrVS9JWkN2VlZOdnZYUldQT1gyb2t3VE9TdHRuMVJKdDBq?=
 =?utf-8?B?cldjYkVKOXpJRGxEUjRCaldHczFTQWI5bzFSZys5eWN6VURjTWxNOG5YR2pu?=
 =?utf-8?B?K00xRkRyWjQxNmR1cmQrOVlSbVZYYjltYk5KZGQzZkp4bW8yL1djOXN0M0xi?=
 =?utf-8?B?YVU1MERVV3NlZlhPVXQ3U1E5SXh5eVBMMFNUZTJyWHloWU5xU1RPUTh2MXlz?=
 =?utf-8?B?VHBDdWYvb0tYRW9jOGE4NU85YldwNWxVK0s2Nzc3RmRGNnhoRXpENVRPQzRH?=
 =?utf-8?B?SnRBMnVuZkYrQTZVTXB4dkNsUGxnb1pSUlV4Z0ZvMmMyMURlNTV0Nk83TXpZ?=
 =?utf-8?B?U0IxdjlzME9Lc2I5VkxrZUwyS2xXSDBRamJ4SjZHQzRTMXlpWDRVY3d3bTZ0?=
 =?utf-8?B?ME04UWlJbC9OZXVUMy8zRGhNVnBvaXpaR3pEalNsOUZ0U1VjcmRnL1lkamZU?=
 =?utf-8?B?V0tLR1RyZDNHdkl6L0tYeTFDVmI1d1JCditHTTFoUDZsTHJwU2lKV1FLWDRs?=
 =?utf-8?B?MkVpSEJJT2FzRm12dkhqRFNWYTcwcVdUblhyNmFnYUE5MVFkR3ZsZWhSenpw?=
 =?utf-8?B?MmlVdjVyR1p3aW5QVXkxWFdnK25xczB2NGVJZVU4OEV1aXErZzZTS0ZYNnNV?=
 =?utf-8?B?V2VtNlpOV0RNYURmbkZsR2p5a3FhNjEyT2pXV2tOTlR2QmlHR1NqUGxPU0hK?=
 =?utf-8?B?WUlqaWZUZkc2UG8zSXBWK2hkNlQ0Q1hSOExHM1JUYncrZnlrRlQ3bVlZRFpB?=
 =?utf-8?B?VXdGbGdJNHk4c3RmUmZQTmpSZWh6Ym9TMXc4c2Qxak5ydEJQN01YTnVkdlU2?=
 =?utf-8?B?SFJ6ckc0a0tiRURxL1d3d01hQTJsL2s3STJXRXBjQjhLRUNNSWQzcm9BNTlM?=
 =?utf-8?B?VGZoaTBKeFpYaTJhc2tjM2pkNG5XNXI3VUg3ckFLdVMzZUV1ZlIvbnUwNTlY?=
 =?utf-8?B?OHdPT1pDdGErenl5OFZ6TlZjZi9jcHNGc0w4LzZ3OU83OFB1M0hpMHkvcjdp?=
 =?utf-8?B?UWFFRVdzaUpjSVI3MTlMYytEbmhFeGFOY2hvRlZNay9XcFVoSFJHWjBHZkJ2?=
 =?utf-8?B?TUs0N2c1dCtJZjZGcSttS3VNK1JxVExFQndnTEJMVXVHc0F0NW9UTFl0M1JW?=
 =?utf-8?B?bFkvMk1HVHVOb1JOOEM5M1JLWXJmamIvNXA0OWJhdks1NlNNbDdnYlQ2NTdH?=
 =?utf-8?B?WVpPYTJZanRaaFFFWGJseGhWeU9JUllubU91ZVdNS0RYcXBDRXhxKzdiZy9Q?=
 =?utf-8?Q?jYvkm1YkV+jqzqDH/8lNNyI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab52d48-b5b8-499b-6aa0-08dcb13ad3bb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:29:00.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtVYzsWEnRCHvrgrr49ZcynWQzqcgsHkkD7S/PMEn3kNmLjMWpP2ZrCT2ZqyM6W0Zo/SfaN6iYy/atbjmNDDd6ecZr0my92hugvxsRjCxzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10471
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

only spinand on_die ecc is supported for a moment

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/Makefile       |   2 +-
 drivers/mtd/nand/core.c         | 130 +++++++++++++++-
 drivers/mtd/nand/ecc.c          | 249 ++++++++++++++++++++++++++++++
 drivers/mtd/nand/spi/core.c     | 200 ++++++++++++++++++++----
 drivers/mtd/nand/spi/foresee.c  |   2 +-
 drivers/mtd/nand/spi/macronix.c |   7 +-
 drivers/mtd/nand/spi/micron.c   |   2 +-
 drivers/mtd/nand/spi/toshiba.c  |  10 +-
 drivers/mtd/nand/spi/winbond.c  |  10 +-
 include/linux/mtd/nand.h        | 261 ++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h     |  13 +-
 include/spi-mem.h               |   2 +
 12 files changed, 828 insertions(+), 60 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc.c

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 96e186600a1..56179188e92 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
-nandcore-objs := core.o bbt.o
+nandcore-objs := core.o bbt.o ecc.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
 obj-$(CONFIG_MTD_SPI_NAND) += spi/
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 472ad0bdefb..6c90d576de3 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL_GPL(nanddev_isreserved);
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-static int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
 {
 	unsigned int entry;
 
@@ -187,6 +187,134 @@ int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
 }
 EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
 
+/**
+ * nanddev_get_ecc_engine() - Find and get a suitable ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_get_ecc_engine(struct nand_device *nand)
+{
+	int engine_type;
+
+	/* Read the user desires in terms of ECC engine/configuration */
+	of_get_nand_ecc_user_config(nand);
+
+	engine_type = nand->ecc.user_conf.engine_type;
+	if (engine_type == NAND_ECC_ENGINE_TYPE_INVALID)
+		engine_type = nand->ecc.defaults.engine_type;
+
+	switch (engine_type) {
+	case NAND_ECC_ENGINE_TYPE_NONE:
+		return 0;
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+		nand->ecc.engine = nand_ecc_get_sw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+		nand->ecc.engine = nand_ecc_get_on_die_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand->ecc.engine = nand_ecc_get_on_host_hw_engine(nand);
+		if (PTR_ERR(nand->ecc.engine) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		break;
+	default:
+		pr_err("Missing ECC engine type\n");
+	}
+
+	if (!nand->ecc.engine)
+		return  -EINVAL;
+
+	return 0;
+}
+
+/**
+ * nanddev_put_ecc_engine() - Dettach and put the in-use ECC engine
+ * @nand: NAND device
+ */
+static int nanddev_put_ecc_engine(struct nand_device *nand)
+{
+	switch (nand->ecc.ctx.conf.engine_type) {
+	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		nand_ecc_put_on_host_hw_engine(nand);
+		break;
+	case NAND_ECC_ENGINE_TYPE_NONE:
+	case NAND_ECC_ENGINE_TYPE_SOFT:
+	case NAND_ECC_ENGINE_TYPE_ON_DIE:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * nanddev_find_ecc_configuration() - Find a suitable ECC configuration
+ * @nand: NAND device
+ */
+static int nanddev_find_ecc_configuration(struct nand_device *nand)
+{
+	int ret;
+
+	if (!nand->ecc.engine)
+		return -ENOTSUPP;
+
+	ret = nand_ecc_init_ctx(nand);
+	if (ret)
+		return ret;
+
+	if (!nand_ecc_is_strong_enough(nand))
+		pr_warn("WARNING: %s: the ECC used on your system is too weak compared to the one required by the NAND chip\n",
+			nand->mtd->name);
+
+	return 0;
+}
+
+/**
+ * nanddev_ecc_engine_init() - Initialize an ECC engine for the chip
+ * @nand: NAND device
+ */
+int nanddev_ecc_engine_init(struct nand_device *nand)
+{
+	int ret;
+
+	/* Look for the ECC engine to use */
+	ret = nanddev_get_ecc_engine(nand);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			pr_err("No ECC engine found\n");
+
+		return ret;
+	}
+
+	/* No ECC engine requested */
+	if (!nand->ecc.engine)
+		return 0;
+
+	/* Configure the engine: balance user input and chip requirements */
+	ret = nanddev_find_ecc_configuration(nand);
+	if (ret) {
+		pr_err("No suitable ECC configuration\n");
+		nanddev_put_ecc_engine(nand);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_init);
+
+/**
+ * nanddev_ecc_engine_cleanup() - Cleanup ECC engine initializations
+ * @nand: NAND device
+ */
+void nanddev_ecc_engine_cleanup(struct nand_device *nand)
+{
+	if (nand->ecc.engine)
+		nand_ecc_cleanup_ctx(nand);
+
+	nanddev_put_ecc_engine(nand);
+}
+EXPORT_SYMBOL_GPL(nanddev_ecc_engine_cleanup);
+
 /**
  * nanddev_init() - Initialize a NAND device
  * @nand: NAND device
diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
new file mode 100644
index 00000000000..58cbe7deaac
--- /dev/null
+++ b/drivers/mtd/nand/ecc.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Generic Error-Correcting Code (ECC) engine
+ *
+ * Copyright (C) 2019 Macronix
+ * Author:
+ *     Miquèl RAYNAL <miquel.raynal@bootlin.com>
+ *
+ *
+ * This file describes the abstraction of any NAND ECC engine. It has been
+ * designed to fit most cases, including parallel NANDs and SPI-NANDs.
+ *
+ * There are three main situations where instantiating this ECC engine makes
+ * sense:
+ *   - external: The ECC engine is outside the NAND pipeline, typically this
+ *               is a software ECC engine, or an hardware engine that is
+ *               outside the NAND controller pipeline.
+ *   - pipelined: The ECC engine is inside the NAND pipeline, ie. on the
+ *                controller's side. This is the case of most of the raw NAND
+ *                controllers. In the pipeline case, the ECC bytes are
+ *                generated/data corrected on the fly when a page is
+ *                written/read.
+ *   - ondie: The ECC engine is inside the NAND pipeline, on the chip's side.
+ *            Some NAND chips can correct themselves the data.
+ *
+ * Besides the initial setup and final cleanups, the interfaces are rather
+ * simple:
+ *   - prepare: Prepare an I/O request. Enable/disable the ECC engine based on
+ *              the I/O request type. In case of software correction or external
+ *              engine, this step may involve to derive the ECC bytes and place
+ *              them in the OOB area before a write.
+ *   - finish: Finish an I/O request. Correct the data in case of a read
+ *             request and report the number of corrected bits/uncorrectable
+ *             errors. Most likely empty for write operations, unless you have
+ *             hardware specific stuff to do, like shutting down the engine to
+ *             save power.
+ *
+ * The I/O request should be enclosed in a prepare()/finish() pair of calls
+ * and will behave differently depending on the requested I/O type:
+ *   - raw: Correction disabled
+ *   - ecc: Correction enabled
+ *
+ * The request direction is impacting the logic as well:
+ *   - read: Load data from the NAND chip
+ *   - write: Store data in the NAND chip
+ *
+ * Mixing all this combinations together gives the following behavior.
+ * Those are just examples, drivers are free to add custom steps in their
+ * prepare/finish hook.
+ *
+ * [external ECC engine]
+ *   - external + prepare + raw + read: do nothing
+ *   - external + finish  + raw + read: do nothing
+ *   - external + prepare + raw + write: do nothing
+ *   - external + finish  + raw + write: do nothing
+ *   - external + prepare + ecc + read: do nothing
+ *   - external + finish  + ecc + read: calculate expected ECC bytes, extract
+ *                                      ECC bytes from OOB buffer, correct
+ *                                      and report any bitflip/error
+ *   - external + prepare + ecc + write: calculate ECC bytes and store them at
+ *                                       the right place in the OOB buffer based
+ *                                       on the OOB layout
+ *   - external + finish  + ecc + write: do nothing
+ *
+ * [pipelined ECC engine]
+ *   - pipelined + prepare + raw + read: disable the controller's ECC engine if
+ *                                       activated
+ *   - pipelined + finish  + raw + read: do nothing
+ *   - pipelined + prepare + raw + write: disable the controller's ECC engine if
+ *                                        activated
+ *   - pipelined + finish  + raw + write: do nothing
+ *   - pipelined + prepare + ecc + read: enable the controller's ECC engine if
+ *                                       deactivated
+ *   - pipelined + finish  + ecc + read: check the status, report any
+ *                                       error/bitflip
+ *   - pipelined + prepare + ecc + write: enable the controller's ECC engine if
+ *                                        deactivated
+ *   - pipelined + finish  + ecc + write: do nothing
+ *
+ * [ondie ECC engine]
+ *   - ondie + prepare + raw + read: send commands to disable the on-chip ECC
+ *                                   engine if activated
+ *   - ondie + finish  + raw + read: do nothing
+ *   - ondie + prepare + raw + write: send commands to disable the on-chip ECC
+ *                                    engine if activated
+ *   - ondie + finish  + raw + write: do nothing
+ *   - ondie + prepare + ecc + read: send commands to enable the on-chip ECC
+ *                                   engine if deactivated
+ *   - ondie + finish  + ecc + read: send commands to check the status, report
+ *                                   any error/bitflip
+ *   - ondie + prepare + ecc + write: send commands to enable the on-chip ECC
+ *                                    engine if deactivated
+ *   - ondie + finish  + ecc + write: do nothing
+ */
+
+#ifndef __UBOOT__
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
+#include <linux/mtd/nand.h>
+
+/**
+ * nand_ecc_init_ctx - Init the ECC engine context
+ * @nand: the NAND device
+ *
+ * On success, the caller is responsible of calling @nand_ecc_cleanup_ctx().
+ */
+int nand_ecc_init_ctx(struct nand_device *nand)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->init_ctx)
+		return 0;
+
+	return nand->ecc.engine->ops->init_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_init_ctx);
+
+/**
+ * nand_ecc_cleanup_ctx - Cleanup the ECC engine context
+ * @nand: the NAND device
+ */
+void nand_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	if (nand->ecc.engine && nand->ecc.engine->ops->cleanup_ctx)
+		nand->ecc.engine->ops->cleanup_ctx(nand);
+}
+EXPORT_SYMBOL(nand_ecc_cleanup_ctx);
+
+/**
+ * nand_ecc_prepare_io_req - Prepare an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->prepare_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->prepare_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_prepare_io_req);
+
+/**
+ * nand_ecc_finish_io_req - Finish an I/O request
+ * @nand: the NAND device
+ * @req: the I/O request
+ */
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req)
+{
+	if (!nand->ecc.engine || !nand->ecc.engine->ops->finish_io_req)
+		return 0;
+
+	return nand->ecc.engine->ops->finish_io_req(nand, req);
+}
+EXPORT_SYMBOL(nand_ecc_finish_io_req);
+
+void of_get_nand_ecc_user_config(struct nand_device *nand)
+{
+	nand->ecc.user_conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.user_conf.algo = NAND_ECC_ALGO_UNKNOWN;
+	nand->ecc.user_conf.placement = NAND_ECC_PLACEMENT_UNKNOWN;
+}
+EXPORT_SYMBOL(of_get_nand_ecc_user_config);
+
+/**
+ * nand_ecc_is_strong_enough - Check if the chip configuration meets the
+ *                             datasheet requirements.
+ *
+ * @nand: Device to check
+ *
+ * If our configuration corrects A bits per B bytes and the minimum
+ * required correction level is X bits per Y bytes, then we must ensure
+ * both of the following are true:
+ *
+ * (1) A / B >= X / Y
+ * (2) A >= X
+ *
+ * Requirement (1) ensures we can correct for the required bitflip density.
+ * Requirement (2) ensures we can correct even when all bitflips are clumped
+ * in the same sector.
+ */
+bool nand_ecc_is_strong_enough(struct nand_device *nand)
+{
+	const struct nand_ecc_props *reqs = nanddev_get_ecc_requirements(nand);
+	const struct nand_ecc_props *conf = nanddev_get_ecc_conf(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int corr, ds_corr;
+
+	if (conf->step_size == 0 || reqs->step_size == 0)
+		/* Not enough information */
+		return true;
+
+	/*
+	 * We get the number of corrected bits per page to compare
+	 * the correction density.
+	 */
+	corr = (mtd->writesize * conf->strength) / conf->step_size;
+	ds_corr = (mtd->writesize * reqs->strength) / reqs->step_size;
+
+	return corr >= ds_corr && conf->strength >= reqs->strength;
+}
+EXPORT_SYMBOL(nand_ecc_is_strong_enough);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand)
+{
+	unsigned int algo = nand->ecc.user_conf.algo;
+
+	if (algo == NAND_ECC_ALGO_UNKNOWN)
+		algo = nand->ecc.defaults.algo;
+
+	switch (algo) {
+	case NAND_ECC_ALGO_HAMMING:
+		return nand_ecc_sw_hamming_get_engine();
+	case NAND_ECC_ALGO_BCH:
+		return nand_ecc_sw_bch_get_engine();
+	default:
+		break;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_sw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand)
+{
+	return nand->ecc.ondie_engine;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_die_hw_engine);
+
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(nand_ecc_get_on_host_hw_engine);
+
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand)
+{
+}
+EXPORT_SYMBOL(nand_ecc_put_on_host_hw_engine);
+
+#ifndef __UBOOT__
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("Generic ECC engine");
+#endif /* __UBOOT__ */
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9cc094110f8..e49322814f9 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -234,7 +234,7 @@ static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 		 * fixed, so let's return the maximum possible value so that
 		 * wear-leveling layers move the data immediately.
 		 */
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	case STATUS_ECC_UNCOR_ERROR:
 		return -EBADMSG;
@@ -270,6 +270,92 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_ondie_ecc_init_ctx(struct nand_device *nand)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct spinand_ondie_ecc_conf *engine_conf;
+
+	nand->ecc.ctx.conf.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ctx.conf.step_size = nand->ecc.requirements.step_size;
+	nand->ecc.ctx.conf.strength = nand->ecc.requirements.strength;
+
+	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
+	if (!engine_conf)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = engine_conf;
+
+	if (spinand->eccinfo.ooblayout)
+		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
+	else
+		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
+
+	return 0;
+}
+
+static void spinand_ondie_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	kfree(nand->ecc.ctx.priv);
+}
+
+static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	bool enable = (req->mode != MTD_OPS_RAW);
+
+	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
+
+	/* Only enable or disable the engine */
+	return spinand_ecc_enable(spinand, enable);
+}
+
+static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	int ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	/* Nothing to do when finishing a page write */
+	if (req->type == NAND_PAGE_WRITE)
+		return 0;
+
+	/* Finish a page read: check the status, report errors/bitflips */
+	ret = spinand_check_ecc_status(spinand, engine_conf->status);
+	if (ret == -EBADMSG)
+		mtd->ecc_stats.failed++;
+	else if (ret > 0)
+		mtd->ecc_stats.corrected += ret;
+
+	return ret;
+}
+
+static struct nand_ecc_engine_ops spinand_ondie_ecc_engine_ops = {
+	.init_ctx = spinand_ondie_ecc_init_ctx,
+	.cleanup_ctx = spinand_ondie_ecc_cleanup_ctx,
+	.prepare_io_req = spinand_ondie_ecc_prepare_io_req,
+	.finish_io_req = spinand_ondie_ecc_finish_io_req,
+};
+
+static struct nand_ecc_engine spinand_ondie_ecc_engine = {
+	.ops = &spinand_ondie_ecc_engine_ops,
+};
+
+static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
+{
+	struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
+
+	if (nand->ecc.ctx.conf.engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE &&
+	    engine_conf)
+		engine_conf->status = status;
+}
+
 static int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
@@ -312,7 +398,10 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	if (req->mode == MTD_OPS_RAW)
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	else
+		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
@@ -361,9 +450,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	 * must fill the page cache entirely even if we only want to program
 	 * the data portion of the page, otherwise we might corrupt the BBM or
 	 * user data previously programmed in OOB area.
+	 *
+	 * Only reset the data buffer manually, the OOB buffer is prepared by
+	 * ECC engines ->prepare_io_req() callback.
 	 */
 	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	memset(spinand->databuf, 0xff, nbytes);
+	memset(spinand->databuf, 0xff, nanddev_page_size(nand));
 
 	if (req->datalen)
 		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
@@ -380,7 +472,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	if (req->mode == MTD_OPS_RAW)
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	else
+		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
@@ -493,12 +588,16 @@ static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
 }
 
 static int spinand_read_page(struct spinand_device *spinand,
-			     const struct nand_page_io_req *req,
-			     bool ecc_enabled)
+			     const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_load_page_op(spinand, req);
 	if (ret)
 		return ret;
@@ -510,22 +609,26 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret < 0)
 		return ret;
 
+	spinand_ondie_ecc_save_status(nand, status);
+
 	ret = spinand_read_from_cache_op(spinand, req);
 	if (ret)
 		return ret;
 
-	if (!ecc_enabled)
-		return 0;
-
-	return spinand_check_ecc_status(spinand, status);
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_write_page(struct spinand_device *spinand,
 			      const struct nand_page_io_req *req)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 status;
 	int ret;
 
+	ret = nand_ecc_prepare_io_req(nand, (struct nand_page_io_req *)req);
+	if (ret)
+		return ret;
+
 	ret = spinand_write_enable_op(spinand);
 	if (ret)
 		return ret;
@@ -545,7 +648,7 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (!ret && (status & STATUS_PROG_FAILED))
 		return -EIO;
 
-	return ret;
+	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
 static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
@@ -575,11 +678,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
-		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
+		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -630,10 +729,6 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, !disable_ecc);
-		if (ret)
-			break;
-
 		ret = spinand_write_page(spinand, &iter.req);
 		if (ret)
 			break;
@@ -662,7 +757,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	};
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req, false);
+	spinand_read_page(spinand, &req);
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -830,6 +925,36 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
+	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
+		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
+
+		return 0;
+	}
+
+	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].wdesc_ecc = desc;
+
+	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.op_tmpl.data.ecc = true;
+	desc = spi_mem_dirmap_create(spinand->slave, &info);
+	if (IS_ERR(desc)) {
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].rdesc);
+		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc_ecc);
+		return PTR_ERR(desc);
+	}
+
+	spinand->dirmaps[plane].rdesc_ecc = desc;
+
 	return 0;
 }
 
@@ -1014,7 +1139,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			continue;
 
 		nand->memorg = table[i].memorg;
-		nand->eccreq = table[i].eccreq;
+		nanddev_set_ecc_requirements(nand, &table[i].eccreq);
 		spinand->eccinfo = table[i].eccinfo;
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
@@ -1166,6 +1291,15 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_manuf_cleanup;
 
+	/* SPI-NAND default ECC engine is on-die */
+	nand->ecc.defaults.engine_type = NAND_ECC_ENGINE_TYPE_ON_DIE;
+	nand->ecc.ondie_engine = &spinand_ondie_ecc_engine;
+
+	spinand_ecc_enable(spinand, false);
+	ret = nanddev_ecc_engine_init(nand);
+	if (ret)
+		goto err_cleanup_nanddev;
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1173,27 +1307,31 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_block_isreserved = spinand_mtd_block_isreserved;
 	mtd->_erase = spinand_mtd_erase;
 
-	if (spinand->eccinfo.ooblayout)
-		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
-	else
-		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
-
-	ret = mtd_ooblayout_count_freebytes(mtd);
-	if (ret < 0)
-		goto err_cleanup_nanddev;
+	if (nand->ecc.engine) {
+		ret = mtd_ooblayout_count_freebytes(mtd);
+		if (ret < 0)
+			goto err_cleanup_ecc_engine;
+	}
 
 	mtd->oobavail = ret;
 
+	/* Propagate ECC information to mtd_info */
+	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
+	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
 		dev_err(dev,
 			"Failed to create direct mappings for read/write operations (err = %d)\n",
 			ret);
-		goto err_cleanup_nanddev;
+		goto err_cleanup_ecc_engine;
 	}
 
 	return 0;
 
+err_cleanup_ecc_engine:
+	nanddev_ecc_engine_cleanup(nand);
+
 err_cleanup_nanddev:
 	nanddev_cleanup(nand);
 
diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
index 7d141cdd658..6229c959b2c 100644
--- a/drivers/mtd/nand/spi/foresee.c
+++ b/drivers/mtd/nand/spi/foresee.c
@@ -60,7 +60,7 @@ static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 status)
 		return 0;
 
 	case STATUS_ECC_HAS_BITFLIPS:
-		return nand->eccreq.strength;
+		return nanddev_get_ecc_conf(nand)->strength;
 
 	default:
 		break;
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3d4a7f0c3cb..c2a7aa2da96 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -87,11 +87,12 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		eccsr = *spinand->scratchbuf;
-		if (WARN_ON(eccsr > nand->eccreq.strength || !eccsr))
-			return nand->eccreq.strength;
+		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
+			    !eccsr))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return eccsr;
 
diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
index b538213ed8e..01c177facfb 100644
--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -14,7 +14,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index ad48b1c7c8a..bf7da57de13 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -93,12 +93,12 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c62096dc2e6..d7dc1c86494 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -113,7 +113,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -130,12 +130,12 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		 * data around if it's not necessary.
 		 */
 		if (spi_mem_exec_op(spinand->slave, &op))
-			return nand->eccreq.strength;
+			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
-		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
-			return nand->eccreq.strength;
+		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
+			return nanddev_get_ecc_conf(nand)->strength;
 
 		return mbf;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0afdaed5715..18b9cf276ac 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -12,6 +12,8 @@
 
 #include <linux/mtd/mtd.h>
 
+struct nand_device;
+
 /**
  * struct nand_memory_organization - Memory organization structure
  * @bits_per_cell: number of bits per NAND cell
@@ -126,17 +128,72 @@ struct nand_page_io_req {
 };
 
 /**
- * struct nand_ecc_req - NAND ECC requirements
+ * enum nand_ecc_engine_type - NAND ECC engine type
+ * @NAND_ECC_ENGINE_TYPE_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_TYPE_NONE: No ECC correction
+ * @NAND_ECC_ENGINE_TYPE_SOFT: Software ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_HOST: On host hardware ECC correction
+ * @NAND_ECC_ENGINE_TYPE_ON_DIE: On chip hardware ECC correction
+ */
+enum nand_ecc_engine_type {
+	NAND_ECC_ENGINE_TYPE_INVALID,
+	NAND_ECC_ENGINE_TYPE_NONE,
+	NAND_ECC_ENGINE_TYPE_SOFT,
+	NAND_ECC_ENGINE_TYPE_ON_HOST,
+	NAND_ECC_ENGINE_TYPE_ON_DIE,
+};
+
+/**
+ * enum nand_ecc_placement - NAND ECC bytes placement
+ * @NAND_ECC_PLACEMENT_UNKNOWN: The actual position of the ECC bytes is unknown
+ * @NAND_ECC_PLACEMENT_OOB: The ECC bytes are located in the OOB area
+ * @NAND_ECC_PLACEMENT_INTERLEAVED: Syndrome layout, there are ECC bytes
+ *                                  interleaved with regular data in the main
+ *                                  area
+ */
+enum nand_ecc_placement {
+	NAND_ECC_PLACEMENT_UNKNOWN,
+	NAND_ECC_PLACEMENT_OOB,
+	NAND_ECC_PLACEMENT_INTERLEAVED,
+};
+
+/**
+ * enum nand_ecc_algo - NAND ECC algorithm
+ * @NAND_ECC_ALGO_UNKNOWN: Unknown algorithm
+ * @NAND_ECC_ALGO_HAMMING: Hamming algorithm
+ * @NAND_ECC_ALGO_BCH: Bose-Chaudhuri-Hocquenghem algorithm
+ * @NAND_ECC_ALGO_RS: Reed-Solomon algorithm
+ */
+enum nand_ecc_algo {
+	NAND_ECC_ALGO_UNKNOWN,
+	NAND_ECC_ALGO_HAMMING,
+	NAND_ECC_ALGO_BCH,
+	NAND_ECC_ALGO_RS,
+};
+
+/**
+ * struct nand_ecc_props - NAND ECC properties
+ * @engine_type: ECC engine type
+ * @placement: OOB placement (if relevant)
+ * @algo: ECC algorithm (if relevant)
  * @strength: ECC strength
- * @step_size: ECC step/block size
+ * @step_size: Number of bytes per step
+ * @flags: Misc properties
  */
-struct nand_ecc_req {
+struct nand_ecc_props {
+	enum nand_ecc_engine_type engine_type;
+	enum nand_ecc_placement placement;
+	enum nand_ecc_algo algo;
 	unsigned int strength;
 	unsigned int step_size;
+	unsigned int flags;
 };
 
 #define NAND_ECCREQ(str, stp) { .strength = (str), .step_size = (stp) }
 
+/* NAND ECC misc flags */
+#define NAND_ECC_MAXIMIZE_STRENGTH BIT(0)
+
 /**
  * struct nand_bbt - bad block table object
  * @cache: in memory BBT cache
@@ -145,8 +202,6 @@ struct nand_bbt {
 	unsigned long *cache;
 };
 
-struct nand_device;
-
 /**
  * struct nand_ops - NAND operations
  * @erase: erase a specific block. No need to check if the block is bad before
@@ -169,11 +224,130 @@ struct nand_ops {
 	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
 };
 
+/**
+ * struct nand_ecc_context - Context for the ECC engine
+ * @conf: basic ECC engine parameters
+ * @nsteps: number of ECC steps
+ * @total: total number of bytes used for storing ECC codes, this is used by
+ *         generic OOB layouts
+ * @priv: ECC engine driver private data
+ */
+struct nand_ecc_context {
+	struct nand_ecc_props conf;
+	unsigned int nsteps;
+	unsigned int total;
+	void *priv;
+};
+
+/**
+ * struct nand_ecc_engine_ops - ECC engine operations
+ * @init_ctx: given a desired user configuration for the pointed NAND device,
+ *            requests the ECC engine driver to setup a configuration with
+ *            values it supports.
+ * @cleanup_ctx: clean the context initialized by @init_ctx.
+ * @prepare_io_req: is called before reading/writing a page to prepare the I/O
+ *                  request to be performed with ECC correction.
+ * @finish_io_req: is called after reading/writing a page to terminate the I/O
+ *                 request and ensure proper ECC correction.
+ */
+struct nand_ecc_engine_ops {
+	int (*init_ctx)(struct nand_device *nand);
+	void (*cleanup_ctx)(struct nand_device *nand);
+	int (*prepare_io_req)(struct nand_device *nand,
+			      struct nand_page_io_req *req);
+	int (*finish_io_req)(struct nand_device *nand,
+			     struct nand_page_io_req *req);
+};
+
+/**
+ * enum nand_ecc_engine_integration - How the NAND ECC engine is integrated
+ * @NAND_ECC_ENGINE_INTEGRATION_INVALID: Invalid value
+ * @NAND_ECC_ENGINE_INTEGRATION_PIPELINED: Pipelined engine, performs on-the-fly
+ *                                         correction, does not need to copy
+ *                                         data around
+ * @NAND_ECC_ENGINE_INTEGRATION_EXTERNAL: External engine, needs to bring the
+ *                                        data into its own area before use
+ */
+enum nand_ecc_engine_integration {
+	NAND_ECC_ENGINE_INTEGRATION_INVALID,
+	NAND_ECC_ENGINE_INTEGRATION_PIPELINED,
+	NAND_ECC_ENGINE_INTEGRATION_EXTERNAL,
+};
+
+/**
+ * struct nand_ecc_engine - ECC engine abstraction for NAND devices
+ * @dev: Host device
+ * @node: Private field for registration time
+ * @ops: ECC engine operations
+ * @integration: How the engine is integrated with the host
+ *               (only relevant on %NAND_ECC_ENGINE_TYPE_ON_HOST engines)
+ * @priv: Private data
+ */
+struct nand_ecc_engine {
+	struct device *dev;
+	struct list_head node;
+	struct nand_ecc_engine_ops *ops;
+	enum nand_ecc_engine_integration integration;
+	void *priv;
+};
+
+void of_get_nand_ecc_user_config(struct nand_device *nand);
+int nand_ecc_init_ctx(struct nand_device *nand);
+void nand_ecc_cleanup_ctx(struct nand_device *nand);
+int nand_ecc_prepare_io_req(struct nand_device *nand,
+			    struct nand_page_io_req *req);
+int nand_ecc_finish_io_req(struct nand_device *nand,
+			   struct nand_page_io_req *req);
+bool nand_ecc_is_strong_enough(struct nand_device *nand);
+
+struct nand_ecc_engine *nand_ecc_get_sw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_die_hw_engine(struct nand_device *nand);
+struct nand_ecc_engine *nand_ecc_get_on_host_hw_engine(struct nand_device *nand);
+void nand_ecc_put_on_host_hw_engine(struct nand_device *nand);
+struct device *nand_ecc_get_engine_dev(struct device *host);
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_HAMMING)
+struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_hamming_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
+struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void);
+#else
+static inline struct nand_ecc_engine *nand_ecc_sw_bch_get_engine(void)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * struct nand_ecc - Information relative to the ECC
+ * @defaults: Default values, depend on the underlying subsystem
+ * @requirements: ECC requirements from the NAND chip perspective
+ * @user_conf: User desires in terms of ECC parameters
+ * @ctx: ECC context for the ECC engine, derived from the device @requirements
+ *       the @user_conf and the @defaults
+ * @ondie_engine: On-die ECC engine reference, if any
+ * @engine: ECC engine actually bound
+ */
+struct nand_ecc {
+	struct nand_ecc_props defaults;
+	struct nand_ecc_props requirements;
+	struct nand_ecc_props user_conf;
+	struct nand_ecc_context ctx;
+	struct nand_ecc_engine *ondie_engine;
+	struct nand_ecc_engine *engine;
+};
+
 /**
  * struct nand_device - NAND device
  * @mtd: MTD instance attached to the NAND device
  * @memorg: memory layout
- * @eccreq: ECC requirements
+ * @ecc: NAND ECC object attached to the NAND device
  * @rowconv: position to row address converter
  * @bbt: bad block table info
  * @ops: NAND operations attached to the NAND device
@@ -181,8 +355,8 @@ struct nand_ops {
  * Generic NAND object. Specialized NAND layers (raw NAND, SPI NAND, OneNAND)
  * should declare their own NAND object embedding a nand_device struct (that's
  * how inheritance is done).
- * struct_nand_device->memorg and struct_nand_device->eccreq should be filled
- * at device detection time to reflect the NAND device
+ * struct_nand_device->memorg and struct_nand_device->ecc.requirements should
+ * be filled at device detection time to reflect the NAND device
  * capabilities/requirements. Once this is done nanddev_init() can be called.
  * It will take care of converting NAND information into MTD ones, which means
  * the specialized NAND layers should never manually tweak
@@ -191,7 +365,7 @@ struct nand_ops {
 struct nand_device {
 	struct mtd_info *mtd;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc ecc;
 	struct nand_row_converter rowconv;
 	struct nand_bbt bbt;
 	const struct nand_ops *ops;
@@ -332,7 +506,7 @@ static inline unsigned int nanddev_ntargets(const struct nand_device *nand)
 }
 
 /**
- * nanddev_neraseblocks() - Get the total number of erasablocks
+ * nanddev_neraseblocks() - Get the total number of eraseblocks
  * @nand: NAND device
  *
  * Return: the total number of eraseblocks exposed by @nand.
@@ -370,6 +544,60 @@ nanddev_get_memorg(struct nand_device *nand)
 	return &nand->memorg;
 }
 
+/**
+ * nanddev_get_ecc_conf() - Extract the ECC configuration from a NAND device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_conf(struct nand_device *nand)
+{
+	return &nand->ecc.ctx.conf;
+}
+
+/**
+ * nanddev_get_ecc_nsteps() - Extract the number of ECC steps
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_nsteps(struct nand_device *nand)
+{
+	return nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_bytes_per_step() - Extract the number of ECC bytes per step
+ * @nand: NAND device
+ */
+static inline unsigned int
+nanddev_get_ecc_bytes_per_step(struct nand_device *nand)
+{
+	return nand->ecc.ctx.total / nand->ecc.ctx.nsteps;
+}
+
+/**
+ * nanddev_get_ecc_requirements() - Extract the ECC requirements from a NAND
+ *                                  device
+ * @nand: NAND device
+ */
+static inline const struct nand_ecc_props *
+nanddev_get_ecc_requirements(struct nand_device *nand)
+{
+	return &nand->ecc.requirements;
+}
+
+/**
+ * nanddev_set_ecc_requirements() - Assign the ECC requirements of a NAND
+ *                                  device
+ * @nand: NAND device
+ * @reqs: Requirements
+ */
+static inline void
+nanddev_set_ecc_requirements(struct nand_device *nand,
+			     const struct nand_ecc_props *reqs)
+{
+	nand->ecc.requirements = *reqs;
+}
+
 int nanddev_init(struct nand_device *nand, const struct nand_ops *ops,
 		 struct module *owner);
 void nanddev_cleanup(struct nand_device *nand);
@@ -598,7 +826,7 @@ static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 }
 
 /**
- * nanddev_pos_next_eraseblock() - Move a position to the next page
+ * nanddev_pos_next_page() - Move a position to the next page
  * @nand: NAND device
  * @pos: the position to update
  *
@@ -708,8 +936,18 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
 
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
+int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 
+/* ECC related functions */
+int nanddev_ecc_engine_init(struct nand_device *nand);
+void nanddev_ecc_engine_cleanup(struct nand_device *nand);
+
+static inline void *nand_to_ecc_ctx(struct nand_device *nand)
+{
+	return nand->ecc.ctx.priv;
+}
+
 /* BBT related functions */
 enum nand_bbt_block_status {
 	NAND_BBT_BLOCK_STATUS_UNKNOWN,
@@ -760,5 +998,6 @@ static inline bool nanddev_bbt_is_initialized(struct nand_device *nand)
 
 /* MTD -> NAND helper functions. */
 int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
+int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len);
 
 #endif /* __LINUX_MTD_NAND_H */
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 81a7b0dbbb2..3bcdbffc34a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -319,6 +319,15 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
+/**
+ * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
+ * @status: status of the last wait operation that will be used in case
+ *          ->get_status() is not populated by the spinand device.
+ */
+struct spinand_ondie_ecc_conf {
+	u8 status;
+};
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -342,7 +351,7 @@ struct spinand_info {
 	struct spinand_devid devid;
 	u32 flags;
 	struct nand_memory_organization memorg;
-	struct nand_ecc_req eccreq;
+	struct nand_ecc_props eccreq;
 	struct spinand_ecc_info eccinfo;
 	struct {
 		const struct spinand_op_variants *read_cache;
@@ -391,6 +400,8 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
+	struct spi_mem_dirmap_desc *wdesc_ecc;
+	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 3c8e95b6f53..82dbe21fd5a 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -91,6 +91,7 @@ enum spi_mem_data_dir {
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
  * @data.dir: direction of the transfer
  * @data.buf.in: input buffer
  * @data.buf.out: output buffer
@@ -119,6 +120,7 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		/* buf.{in,out} must be DMA-able. */
-- 
2.39.2

