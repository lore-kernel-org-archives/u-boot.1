Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8530FC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E57781D5D;
	Thu, 24 Apr 2025 08:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NBePnSWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5485D82103; Thu, 24 Apr 2025 08:34:54 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D7680944
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk3HIoCtmPghoPjA+nq8/4EoYbHVdqJKHr5/XG6TmovFYPQJDOuSQ/P2CIJGjbeudhao8g80UCc3a/TMAWVqA2P+ASXuRG2v4j1B1ygHdmdpk0bf5Zxq3g/hvCj8nCWikc4SGvTWFzAZOcmnj4Ddr3jt6kdgiZ5zt/UrUX9CYIjrVkVNKX6sFvyPvGm8jCwUViQUg9HXvQ3CG2rUjxy6kiiJjgYdi93dbfavE3SbCoDRbuvvrn2AJ0Z2xSi0fuqfGxfqH68TWGn1hDwzFW7+fDy6D+JLK92AL/eUwRa+OWrI1mQEbv0YNp8t8/KWtTMTgy0FtOo6dfqiJZDybrBguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2NyOrvLbnpwFnzHtLZ4sPgKYhoRwuDSJgTblMTkcFY=;
 b=ZREyuzoWMks551bhPzPyLHkC6CU/OkFCUjR+ftgsOekvDRQpQgjEeY1P2AEtq3iiBmpRyqXmk4ih+2hAQ7aLI0p6OqO6NWVLZAHuYKEp4bfApPdR4sb006PdbjrNdpDHtTx2Xv8fetM1M/O2aCdlIPBDliAhDzb8waD1b/ee4Xwnn7hD5RVD5KOAHrVfJ8X7m5JtUjhrHS5SvFicXtBgADdkb8PtL8gCJY7gepTQhG4x8Wf/m1RboCFsqbIkKygossi2rFeoalcN1POXftqv6RuAyMFl2Xi3f22VcDq9TiMQf77mixk335jnblL6TjGwgidxztxA5KIg3kCmdcDo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2NyOrvLbnpwFnzHtLZ4sPgKYhoRwuDSJgTblMTkcFY=;
 b=NBePnSWArHsnxNpTcYwt9NrPjS+sd5yviweDW/BEVpMNBY0Jf0OhVHyJlhSpcVl5rTCP0PVfFo/7MYv0f08rWwPbSHE6DF0QZsytSb3pDIqS27BZuV5XnDkc6C5IWpLNkg5zlA2bMUZMnPSuIrzeil7BkjauIKXQ7a0JAlR7DhkfxLpDM4Vy5d1aYf6yKb6wuebU0QLYATxkUHNHB783f8ql8GG0B0mKjDtj2AoktfDub/VkhtD/hjeqZwwOyRjGmUcFVXuOhT27zDGyrF5M4pAQGTLNpHYvUfZ6bYEvkoBUKMtTRtE8i5Lrc7uCoIYPi/D1vUkZa5exrG3NCvguMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:10 +0800
Subject: [PATCH v10 14/21] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-14-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: f684985d-4351-4a2b-e28b-08dd82fa1bf7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qi9xL2wwMEZxYUkwZWJKVS85MkpocnppOWVFT2dMUGtxbmpRZURRMElxVTZB?=
 =?utf-8?B?R0VnNmJrUDdhWDlCakRJaVZGTXlpcVNVRlNMYTRxd1JhQjhUYmMzUHNqRUJs?=
 =?utf-8?B?Vk9hSXhDVGp0SENEUU82b1RxNUl5YzFVelFYT25GeGkycnMxK3crTEhIRFRH?=
 =?utf-8?B?VGtnczhyUlU2TlE1aEhVQmxXZGJZSzhzdEZCSldCYkhrSkdWbDUvQ1FoMlUw?=
 =?utf-8?B?dVdXbGI5YmxnWEtuT1JPZnZBb3NZdnJaMGJMQU41U1dMaUs5WXhoQS9nWkxK?=
 =?utf-8?B?TFRQN1B6bTlrbldsU0lDYmR1bmJZUHdleUdkbll3Lzh0Vk5CeHRSOWtjWmR1?=
 =?utf-8?B?VER6RDFtYmhXWjJuVGU2WE9XQVNFTVBWM1ZlekxqTHpjUDlsYXgzbThGTVA3?=
 =?utf-8?B?cFU4NzNWdVpXZGFUQlRUOU1WY2xXY1ZYWnN4cmNLS3pZWi9UTmpjSnZpOUgw?=
 =?utf-8?B?dGFEcDdUcGdpVldtQmlrUzd4Vko0cFMrd3k0VFQwTkxicFUyK1V4QlB4Ykgz?=
 =?utf-8?B?TzFZa0pOTXpheDJSdTBhcVZiam5ERmx4cjlleDQxd1o5RS81MnU5Ukk5emdT?=
 =?utf-8?B?aXQza0pKSVYycXhKVnRURjk4K3ZDakJBUjVHRDN6SFQ1bXFKS0FDVVJLQlBV?=
 =?utf-8?B?dW9XMXFTeHVGSW5KN2NCUDZ3NUpUc3Q2YnlpcFU3ZUZ4WFc2ekdibTBrWXN3?=
 =?utf-8?B?QmIzSGRVeGR2M3BBUHBRbW1vK252U2hsNXMwYlBlT3BzRVZXSW5IbUFsYTI4?=
 =?utf-8?B?eS9kSnBiVmZxZEFjQ1NuNkhJT0pBNUkrU2hrckFyL21JWE9VWmJQMm41alBZ?=
 =?utf-8?B?L0xIOVJtUWwzNXA3ZHM3YldheWJNOW02SVRXcUJyaEdKRW12TzFxZlZaUllE?=
 =?utf-8?B?TmxJaXpZQjdxOXdwemozUEpZc0lWd0xia3FPMjVyZFFKZFBFYjF2RmZ6Tk95?=
 =?utf-8?B?c0VUVTFXRE9kZ29uLzNJTXAvcFhqRlhUL25IeGFjR2YxN0k2dDBMcjJoeFBD?=
 =?utf-8?B?YVd1bzFpeG1HM0xXTW95S2FTN09MaE5OMnhOVmhaVWJqRElIUHMyNzhqdWR2?=
 =?utf-8?B?M2NzSWhEaDBnOTdYTTdqVTFsWTB6M29TZFNLRTJVLzFxTHlpRHg3Yk1CbWJO?=
 =?utf-8?B?TWtzVkplbU9uRnlKQU9DVFJJKzJDYWpCbjlTeUR5MFdPanR6a1NHTHhSbXo5?=
 =?utf-8?B?NktqZHFycFl1c1k5TTlqV3pUMTZYaXUwUTRMSHkxUDR6TVk0YnlRTEplSlpX?=
 =?utf-8?B?VWZiVHVjdW95VW1TRElidUhYdmVVa2Z4T2tNSSs1YUprcXpqbHJKNHhER1RM?=
 =?utf-8?B?M1E3dTlTZ1FNT3N5N01HSVVraE52WGhoZGh5dUQ4dHZpMEhVa1hvNnlnWGVm?=
 =?utf-8?B?bVdyMnc0RzV2djM2YTlCMkVpaWlYT1VvMUtSRnQyellTMXFKUVo2enFFRXVX?=
 =?utf-8?B?dVRwMThoQktWcmpRZVVFVHNHZTMvaDloT3UzelRrbitiYS9jVEpaaFN0TVhH?=
 =?utf-8?B?L2NNMlluWGFVZVZ3TTd4NjhyOEJnQjRSOEhwWmN6c2czaUUxSkxEaWZxcmJD?=
 =?utf-8?B?R3ZlWkdXVXFBL1VLUEtNS0swZ3YvUmZvVmJCT2lKY2FzRXFSbm9GejZjQUtE?=
 =?utf-8?B?dzdMbXhTamhCSEt5VmM2VG0wb3R0Y2p2VjV5dUJobExEVG9NcXF1Q0pUYVl2?=
 =?utf-8?B?YkF6cVR0MTc3M3B3ekVzMjhwMDdFOFhPSy8xdzY2bGFPSVR3aUMwV3Q2Tks4?=
 =?utf-8?B?czRDa2poT0RjWjY1dkVMRloyaE1WUnpZcjI4bWZsV01ONkVtOWd4b3d1ZUJJ?=
 =?utf-8?B?Q2Izc2RkU1o5TVgxOEkybTR4U1Vpc3l3MTJxdkcxZFRXa3crMlUwbGNqV25m?=
 =?utf-8?B?YnlMeEp3RHE2MWx2VStHVmRjVXVGQkloaVBuOTZiWUNWZjZkUjduVitHeGd5?=
 =?utf-8?B?UjcrY1h6aHl3Zm10RUN5b3M1bEEvZzVLR0ticnJxZEhRQ2ZYQVcvb2l6UUtB?=
 =?utf-8?B?dHp3R2kyMU5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEV4dVY4UlNKTEN5UUpiS0wvaXEwVVJOVVhldWxoNU11dVAvU0FZbExVMTU2?=
 =?utf-8?B?NEE4TEM3R1B6SXFBcnZJcXo3NUdJQlVWY1FMWHI2anFJaFo0cjA4MVQzdjBK?=
 =?utf-8?B?WHI2VE8yU2hqaHNIZFFCZ1FwT3dlZGtIV3NWRnMzZjBNV0gzTEc3UU9YNXdZ?=
 =?utf-8?B?MWlmMmFzMzViOXNqZmRFNjlyai8wTjJESkxOK09Qb29oTGkvdjI4UHIyS1dj?=
 =?utf-8?B?UlhBZm1mRnE5UXVmS2I5M3FwRVk5VnBsb21yZkJXbHYxK2diZUlTTGo1bGZa?=
 =?utf-8?B?VW1UblA5K2pmN1NLMkkwR2pKTU8xY0FuSHdNMCtNYmMwVUdqMlVlb2NaZEpn?=
 =?utf-8?B?SENGR1BaYm5ZNEFUeTNvK2pBNzhGalc3Z0JpVmFVZDBRQ1Z2d0QvV1BSUWVD?=
 =?utf-8?B?VDF5TlJvc3dzVndMZ3JSc3REeHdjWnhtTENqazE2ZXVndzhiTHM0SHRRcDhB?=
 =?utf-8?B?ZHFqTER0MXBzSWl6UXdHc1B5bjBEbkVMRW5wS0szUSszVlI3Rk1xVVpvL0FX?=
 =?utf-8?B?U1ZNUEVvVDJJdXlCZXlzaGEzMnA4U0Z4NmhQSDJYNUd5a1J2TFVxNktXbEs0?=
 =?utf-8?B?RjhyaGFqb3J1OEk2QU9JRkRlMnp4dGF2dzd4SG1ybmhnSktsUjFzdTV2Y1Fy?=
 =?utf-8?B?UmhtdFFhdnpITEZFSVdTMkVtUWpMYVB1Qno1TVJDMzZ2Ync1NWoyM08wT2tt?=
 =?utf-8?B?eXpTNnNGZ29jdDJrY2RDaDlpR3J2eWRHSzBvVmtSZDhlZE5LbGhIWlc0QVNM?=
 =?utf-8?B?WXVUVlN3dTRSQWQ3Y0M3MmZWK09OTHZJclBMRmxvOVl3OTk1WWpFYXJTU0dy?=
 =?utf-8?B?YWc4bUV0Z3I2WUwxdjQxNnJEazIzYWZPeU9kbkpmTkhuQm1PNlZyTDZRNmJh?=
 =?utf-8?B?SG8vVTAvUHpSZVFmMVBOWnREZmhOWkZwUmc2U1pGd2JZTnN4RnJwbEgzWnYz?=
 =?utf-8?B?QlV2SmRJTWQ0c3o1ZENLemttVzdqVDAxMHpRRUJ3bkRMSmVnSUVoSW1oVmRP?=
 =?utf-8?B?L2RJZklURGdsckdBNUdTaUhTZ1crVnF2WlNlRnpsZGx1UkJrWkZtN1FLK1lT?=
 =?utf-8?B?QXNYaWNidTAxVmdObVMvM2NjK0szZzJ4WSt3eXRnVGNRTFNFVzBrU0xPalQ0?=
 =?utf-8?B?M2h1UkRUc3hINlB3LzdnaTdBMGVLYmJUak1FeUYxUFFIa2RicFZTRmJsQ29u?=
 =?utf-8?B?d1doT0JFQjM5ek5iZTkwdkQ4UGU5eE8yT0oxRVJmMG9oRFZVZW1scXNkd0hP?=
 =?utf-8?B?Q1cydlZzbDJZaVo1ZVN3U2pLRG1ZckY5anVJa0FSR291QVhRcjhMSEZZYXh2?=
 =?utf-8?B?Vjh6dzdGZmxMdlRCVDNYNzFkL3FBYWVGMGFpamVxN3pwd3ZwN3lZN2J2b3c4?=
 =?utf-8?B?Mi96ckVmUDNYZ3YySXVUS1dGdEVwMDZRTmVreTAyV3pGcHoxOGlLUkljb0dk?=
 =?utf-8?B?STNaVW50QmkrK3FSdFpsQTZqaW1mbGVWT1FkbkdHUCswRE9vRTUxa0hndU9p?=
 =?utf-8?B?SS92anZjSWtLWUpJV1FkTnJ3WjhkUGhzMjJHREJpL2JvWnRHbThROGhDektF?=
 =?utf-8?B?L0ZGVmFrRVpDd2hHakhtalRqbkxJYjNpS1R2OEE5ZnZTbVQ3ZUx0TnJtV0N0?=
 =?utf-8?B?WmcvSFR0eklYUjRtem12SkxKbW5QSTg4dW9iNGF2ejZEOWFuTnZWOHBjZXRF?=
 =?utf-8?B?bE95ZitLdmluNStleW1meE9DUTk4UUlEMDc2Q1V6MmpYMWZPS0xVbjkvdENE?=
 =?utf-8?B?YUtuVkFHSTF1SkRhMk16VG81Myt6cnpvQkhYQ1FKdnBRWFE4U0k2TmY3d3Y0?=
 =?utf-8?B?VkNWb1BFQ09odGdQRGhObEVobjk0RGQvN2ZBcmtaSzAxSWpNYkFxU3FnZFIz?=
 =?utf-8?B?dmJFRExYZjJFTzNjM0Y1WExoRDhJZnBMWWlhQ3gzdm52ODE1dnBBVVhkbkln?=
 =?utf-8?B?cDFiNy9QVEtzeGhnbmNDZytEMHdDdjl4QTRtNTIrMDlxZVZubngraHpISXha?=
 =?utf-8?B?TmNmclFxYXNpeTBTamdpZzR2Zi9xNWJpT3JLeTNmVlFsOC9hVGNvVUE0bXpC?=
 =?utf-8?B?eUkzTFdvYzY5ZCtiL1JTNjlHZmlWMlZxWkZ2eXc5VTJWTXhOTHpTR0RCUDIz?=
 =?utf-8?Q?jOh2E/kbsb3ZTTlvXkK71rr5h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f684985d-4351-4a2b-e28b-08dd82fa1bf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:48.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cvQwN/X190SHNVLOsV7gvKWiIqswcvW8svPHHO0GxSD8uP49t7w7o1YPbevCc7g54rVvFBCd8ebt4dN2IJG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 7 +++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 1ccdb1cf64f..f6a9a13e4c9 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -24,6 +24,13 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a..53cc97c6b47 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.43.0

