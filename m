Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C0CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F418F83710;
	Tue, 28 Oct 2025 14:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FRXAIigb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D97383A43; Tue, 28 Oct 2025 11:48:05 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2817B83A13
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKkUWtJAoJ/hmK//FRejacNYRh9mluEH/pfZcA4Ru600h+9prxY2u3wG5B9FB/vy9URhFdAuF/lN7Y0dKzWg9Jd2OCZruk3wdxUrjcfFdcC+Oz3j5nu9tklF2NymrUDtWrycIP3BhPnyTv2zth65cPOPdhj+zH+mVA3zvWyz0AfeRDnyUeouIsPGb72dcER0GCqGQfHx9w5LYFhPInigiNubvY7/3Tk6O/krE8iAdDEnF6+uYIvodXxeEZwUs1s1jDlSVMkA26X0P1mw1vCyZeLLxW8XoawVEkGKg+CNKKIIQ71cwerZpzzESN/lRkqxLBqubDTn5RE95p6DtQQruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PekkMH94G1Q7k8EHTFrdrjYfv4gvS0XGZvnJ/FaR+uo=;
 b=pAO1T2z1AIfXHnWKGodomKvd2Ra51mMQRo2KHs44Kcb5Obr4KmKhw1IRJGG8VrGbo+aYAetUcMVd+FQ0C313iykUsLyrw5bS0xrJpogIvB7KgqKkPATdtAJ8uGjLTvX9kHRMyMJwB5jjsYK3adaLcUuhUgLE/mlY0vGQnxvt8jMGLGA5Rro+fiY166CTFvE7KKlGvoV0EQHy8+rdlSwNBbDOCxA6R6+TzDsY/d3NP1m1yeqOe8GIL43810944hU4JRqfFN27jFvS2Vnm62T6uYkougVV2aFZ1eGPhn1WQCaoUdu+gMcV8YqXymO+ayWqkDp4WZThcKuzjaje/zG30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PekkMH94G1Q7k8EHTFrdrjYfv4gvS0XGZvnJ/FaR+uo=;
 b=FRXAIigb1lIZPhYMIGUI9PitBrlzhU4yHhxKYupph9FdgGSLn/NtofzmXHdJgXQX8BTTfSomPs4bpZtzM7FDHxBfwAWFnGkdcoukJ1PyZwxNeCKjHum1JyUv7EVRf9l95Z/PVbRtUNSMSNLBbz3sMX5red3gsJy4aek1Z0WJTgu80xI3odsU8qroiYlFKPzeAyP/9thtbvNiEs3clG8MKSSmkyeyCxZfInDq9t1W7Fuj9gFFrbJOGWR3TkAjamTVWm03kLW+FTzYTo1e/DSedMN/Q5AluHiO+3/MP1tHnAB5RomZag+TsuNsK23q2XVg8B147jOdACf+tOEoDvSNDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 10:47:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 10:47:55 +0000
Date: Tue, 28 Oct 2025 20:00:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Message-ID: <20251028120019.GB9371@nxa18884-linux.ap.freescale.net>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a56f65-1dbd-4f2d-08e2-08de160f73c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?btSix9qW8poM/eJOyBc4V1C5KoDqDniRSqacgGS0Qj0+Cd5QlgNqD5nA1Gau?=
 =?us-ascii?Q?h5iSP2UD0p+PAhf0Ftfd8BoGD6DmSDi5WZ5tWcEXj6nf8gXymerJe+Wz9gdH?=
 =?us-ascii?Q?t9oONcAkpuRQiVi9IRchrpiNPyov1SzEOe/0dMskluvwympzbPbT/eKNly2e?=
 =?us-ascii?Q?Nx1oghE4yBRVITf/zI5XfiIrXXRbvAf4rXvva+WSNFBggQ6GzHJzvJK5HMac?=
 =?us-ascii?Q?qdzfypB4knu8exOPv3UAZlfAaGOs7mp1yB2XA0qinZ97of6lOa4pMkxoWiwR?=
 =?us-ascii?Q?4M9ZwM5W2UpZPBPNEPP5s/s0Tw/AbhcPWlLu8QoQlu3U51LRqxabhl49C2d8?=
 =?us-ascii?Q?GdTcDFMQrdgFeUMNiD67Y6lfkw47uYwlpmxDnFC0b8IXO6OsPp7B5Q/l3esn?=
 =?us-ascii?Q?AbQLRoOUMOTCC1soH1232GYK9m+p0/57UNKhUc0eISoGmkbUB5Iy6uIIs9/T?=
 =?us-ascii?Q?CM7lWDPC9iCgw7ODUB37TWBX2W03ogUA3dNaKXYwTR/RKcXjGj4OQIauv2A1?=
 =?us-ascii?Q?VAf19mf1iCvy9bdTICjiy+TXfC2i7J1JzEwyxgbyRuBlApFFkIxGWWImmj9x?=
 =?us-ascii?Q?1TkMztxoKeBCGJV5Cx67NUW66eZDOdGYgB4wWwgbQv2ESOObzzL4amZD0T+a?=
 =?us-ascii?Q?7OJNYSTYwE43j+nOMNq7QVVp/d9xue0YmZITIn5J27GPl46h3qxGoeHqaC/C?=
 =?us-ascii?Q?x+g0mvXlQTztRovziQVLDqgNMtXoWSIVNLtNjjnIf7hqvK6YozwtyJxhACbE?=
 =?us-ascii?Q?KiG1tYpDgk3J/R0SmIb0vsxcaCDI6300CVRM1tHXMqV8uxt3tD0jUM6/fPjb?=
 =?us-ascii?Q?YqpE3tq6a4EEk4ZCUzuSYuKTmpyJB6YLsYeE6xesSV5mq+eXy6VaEAMZ9K6I?=
 =?us-ascii?Q?rUTKHHzmIk8QM74eWXID+svKjj1m0rNxip+gKcGPsRxA6hKCqFErGfmdsH2q?=
 =?us-ascii?Q?2nsCtFtTLvG+c6+sTKRuD/4c0II3WZxIzhZRjrH96/YwrKQchrwTqVMEjc2c?=
 =?us-ascii?Q?BpKSa0eapM+MGPJGJ1fM3acBuMQ3kXb0TzRoFHc8F6V7aTCdMwWi94DcrYqm?=
 =?us-ascii?Q?PcoF6EeZInpFgOEnSFK5HBzfMWERB2a+Fwkb/ci8VPSGTFZZyHeeyoJpHGG5?=
 =?us-ascii?Q?qqHIQuOCfNbcQlnVbaq0y5Q6jbB7SBiH+yrS+a+vgE/cnq56msSXZj/tzLKr?=
 =?us-ascii?Q?WMvj55KGJo5/uvoXRbB8zjToIkpcFfY11U5HfPrIkm79txhIuvXJLMz36zoO?=
 =?us-ascii?Q?W6XjXrjclxRDXHhPCxz3YExznpaQIotngbLby0Zy7xPQ7UlRvXT6hPxILXyK?=
 =?us-ascii?Q?S7QWSKCOHyTqqp0wHmD/BADWOvj4IlSPxkysd9baY0Fi4a/bGESWc3m4kCYK?=
 =?us-ascii?Q?hoYeqg4g4vcllceXKB4w01n7SYgqNgu9OkjR55blODkOMO8wLbyqlmen+Csz?=
 =?us-ascii?Q?UED/Af5j+MNAP4PisDILQyJNisOg7HK74RTsELs/zb5y+CVIMbtgJCkeFJ6N?=
 =?us-ascii?Q?q3ID1guZNG7xR9iG8KLCTIRBKQU/zG8e4pzU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1NazqD5c+bPU3gkd7BCrKIr3180t/+mAvhfvuk5hMyA1GK+mi7ZW1qkSecKz?=
 =?us-ascii?Q?nalkR7bC+Si5IgvhhwdbUK04KvXtmdppBTHk2DwntTB+nlbftN+gQW8EdiCk?=
 =?us-ascii?Q?DGxv3xxlFmlxhqlubtweGqeR36MG52XO5XODgOdnY9wygOfqGjdI3AdBlMaj?=
 =?us-ascii?Q?/x/PxuI26zLJvZzOXYKfCjQVSvDeTG7w6p4S2qNY3J0Joxg5F2ozQT0IJ5Tc?=
 =?us-ascii?Q?0jv7mc2FfZnUI2OR+D46x4SdgKS8QDP5LfimhFLIQB5l/AdlUdw8OOZdJQYg?=
 =?us-ascii?Q?wi/uZR1/IyJywsixYGg3ZJuLmxGAxDy7gtsPMZ5LuRgp/ceILRQ7As6gqvHz?=
 =?us-ascii?Q?qR3Wpx/e58AmYLDwiFw3kM5Hq0x8XilCIzitovzxSgCUMfWhiD/iAP1sK4pn?=
 =?us-ascii?Q?kZFeTv61ptyQnXbUKwx+uUaY6Vb0E0uI/qH5+GM3KnUD5OEqkqHTxdLqaQlw?=
 =?us-ascii?Q?IcTU4i9nBK7bFZHQH6vacc300+lI/edpNaS5sGkin53Om12gzl1AoTpgrgwY?=
 =?us-ascii?Q?k1XR6KNzUDmaN8E/g3k5hP3sROxSz7f/jO4+rifXwEpSgmvRN091ppSAQHzN?=
 =?us-ascii?Q?TWDMmkmWupfnmZ51lQYjV5m2VF6h3DZ1P47033weCjCuu2T3BH+2y8GH1nKc?=
 =?us-ascii?Q?Yyz5qkwg9SUF/RHXxPfciZ/q8LHRtIP1/I1c/VnvAF57W+Wj51ubynOa+5xz?=
 =?us-ascii?Q?D1vZoVx8O1xjHzg1SczhWRPYX8m9JuwdUu32KdwvVdCK2vCvcyvnEVOm6lJg?=
 =?us-ascii?Q?SdXC6hNu7ND75XBzUASjjusDYdWrhxeTPxIjn257sfmEU0buKUQeGRbVs8gA?=
 =?us-ascii?Q?18BU7oLYrcZVVopnRCo4G/DL2tJ9TKfZdC9m1J31kc+6OEw/IDCd5WU25yxu?=
 =?us-ascii?Q?t4Akoo4OHYm2lUEbNwAh/n4UIPFV/hfR171bwrFAeFaBplavydPYvbPQbj8x?=
 =?us-ascii?Q?09gMoJn3eWni5O5sKXgAiIvALwjkJY2CUu4HmTtAc9TBUS7H2Rff94BHyuFy?=
 =?us-ascii?Q?/chgYKStoXx8YWRJ8Z/S8RVvBmpFWmvH9i94mWi9FMjvK4aN2wSKUDE6h9zv?=
 =?us-ascii?Q?YsLghtMGzOjEHp9AKjWD5VMTmhWNt2ZHGPfOVm2vwdSgaBFtLYFnCW8n1Rsa?=
 =?us-ascii?Q?EL23WJP35B5L20SAOEyUcoAtiEoRNhrvBhiV3Bd6XIdcpR9KFyywTPLabB7i?=
 =?us-ascii?Q?63MYW0WIHQGuVrJb9GPgSeTfnIzDVkGE1DsULiYqftkSGhSCpoVvoYkgNhaN?=
 =?us-ascii?Q?PEh0musa6J1DLIb5Trj8+BRseku68TXb8OY7lIqX6ovoDw5exyQiQxjnmPxs?=
 =?us-ascii?Q?LeVeUBMlHnzuk8xZljup1agTl76QheffXXpyOmw26ouQ2PI/bUubWzYuY75j?=
 =?us-ascii?Q?k+tzZWnFT5t0jEdK3fg9R/E5O8QzMNtBXLarhIfk2NYD1lm5+ZrGCUN3EhQQ?=
 =?us-ascii?Q?JByl2JSwifEk06vvy3zVy+j/E/inSzuENEpPj7Ao1Iy30tYK+CAEruumzMzy?=
 =?us-ascii?Q?fJB54Mf+iNwBap4UAFGj6f/vGj+IJKzW2dLZPpTmQyIwOOrTZ9QvzjY5yj44?=
 =?us-ascii?Q?jze3yhMBmHwmId2eUrM6YmwA33BbB4eNoLhsIIq3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a56f65-1dbd-4f2d-08e2-08de160f73c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:47:55.8513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbo8abAfef74N0LR4TDlNL2UUhUzWfIvc5k+kyTlKaFEh/e5plLaGU5iUILvST910ISuzhoDmOgGS9PcYqTvNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

On Tue, Oct 28, 2025 at 04:41:03AM +0100, Marek Vasut wrote:
>Allocate all sub-driver instance data at once. The amount of data that
>have to be allocated is known up front, so is the size of the data, so
>there is no need to call malloc() in a loop, mallocate all data at once.
>
>The upside is, less heap fragmentation and fewer malloc() calls overall,
>and a faster boot time.
>
>The downside is, if some of the clock fail to register, then the clock
>driver cannot free parts of the bulk allocated sub-driver instance data.
>Such a failure can only occur if clk_register() were to fail, and if that
>happens, the system has more significant problems. Worse, if a core clock
>driver fails to probe, the system has even bigger problem.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
