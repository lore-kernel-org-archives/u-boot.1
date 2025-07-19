Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2D3C83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37556836B8;
	Sat, 19 Jul 2025 02:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="HDakuMra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F30683693; Sat, 19 Jul 2025 02:57:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA55E836A6
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg9D8h60ruVEMSIeDowEtNWb/tGDyo33CKpY7LW9LB8noRjJUJafnL/C00WH13QbQ6cot5Vku10TD+xQBVWFmt3IijM0F//9rKC36ucKV0svSH4WwqTsWV/IU9HPpxobptbxNGrJtBua1OXC91e7H13gpcIBbtFbP4P4HS7pAbm/7Mi0IuRQj2zQpkS+ZdxFeMzHyI/y6ZS3Op7Is8u219YL7GzEE61KR0jvJHkRG0Hu6uNI8YcIaG3dL3wT/s7TCfg+jEpotXZVfgX9WUSQLcyIXaQWEOF73POV1qBFK093s51aqlhygggGPs8g1zEzQpWpsh2SPHti2jU6JM1C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hJuKIh6EztzcjPr9/i9h/PZQK0kbc64pUI91ixa6Qs=;
 b=eh1TZpuXaMG11E0EGzDTRrBUmm23gbzMT+1ohjMLB6lTlsqiyHLkrQJMkmUqer0hrEQR60C2EEqSzDYnrZJvRH+kGYmueJlrMeHq2z9FrkNikBv0Ayx467nEpVWxE/gI/MQo5Vtbj442FmqmO9BYFi6CweEHizTlyaEW/eaFjLDWjPlM1QizjNlfXSoERR4UCNl73J+4SfcnmtqFrq12WjKMp6bergxrJYrwL3WT+OdCz1HSkC3PxCvQpQjjTl51EVv2g4UHZUG766RA3L9I+gno7o5fZQhdA80KrEGtZImG+IS1e8lrCBpjXIzHmEkka7W5RPSjrQDxYxTG3B2BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hJuKIh6EztzcjPr9/i9h/PZQK0kbc64pUI91ixa6Qs=;
 b=HDakuMraNy0mZzetff0yC8gQ9/0SOZeGcWxRLb/hNM9kcARZ4cMRBJoXeigzPQg6h6EZFSPAVE38yONGRFMVLYa/in4euIocQgt4PLDIGWsJoqXJaSylsqlSM7hAKOH5PtMDX73Hlcrfoi3XoDFyyd5FM+X47IzLvo1dIF2lWrPI7e1FnkWe2Vl0SFoAOldu02QnocpPzn0Zh11ZHpeaZ6jZ6aMZ+lDhi8lD/EUQ8SXPShOwdUT/7be6EiHA/Ss7zIJ+iO5WVqIQYAlZfODSnwkiJpG00duKM+xPYc6mcvDv8ZSVY1bZtxkFH5mKopb9C7jTOBp0jYf2h6SCQShjrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:39 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/7] airoha/an7581: add CONFIG_TARGET_AN7581=y to the defconfig
Date: Sat, 19 Jul 2025 03:57:12 +0300
Message-ID: <20250719005717.113842-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3fb4cd-94c9-443c-5420-08ddc65f420d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?83TDG0DSE27JQlfRNTrGlIAjfu7MVtM8ueQUlvZ9BWDcsf96/Z9ajcSOkt8b?=
 =?us-ascii?Q?HKODcZ/wLt418LZVps5GwswaiRNaVcAgNj/q2HrEDaUPvD+C5Vhp+43/8+0L?=
 =?us-ascii?Q?TE9R1ukXCinBFLqIxHRWx8/HM4G+uaWdjt1TpAHI2E/hohi09wyMOFuHm3GM?=
 =?us-ascii?Q?XNtXkP2rWmlYdrgdL97O9aOqWj5B7080LpZ1mEoLssgcY5hrj42Bt/0iWVeb?=
 =?us-ascii?Q?qBqvHtlaJhQ6a22UAtryOyrWvgHpMIyqPgvt1HHVQzig1cbhBiXmpoiIEJGe?=
 =?us-ascii?Q?O38Bc7PSucuzvASqow5Dbjb84Fzuu3GUBBPo0wTI4pBP3vFktSb18/k2hQmO?=
 =?us-ascii?Q?vlHjC2suCaNIdwTsDWUxh/m66tph3qnIUjmTfT2Zla5mpPFPqE/ayvnLlnG4?=
 =?us-ascii?Q?riW0l/xNsCB9cFtcsHhTb6EEh8Wpyc3k1d9QGT+6XGS5nBSUCOYXLcE111IM?=
 =?us-ascii?Q?om0TS4cLXCQPpJcRBDMxDzEC5VvdrP7u9tpEqFTAUJrx8NU/p79X4ZtO3sza?=
 =?us-ascii?Q?/47kBCoAI8Ot7U1x9uiNd7bY7CWmOSuewztt4mc2/+b8XzZj+/JDjaqW6gMX?=
 =?us-ascii?Q?S8EpcyA/MERtYT5WkMFBqIyntRpgtolmkmPIR1Eu0vjUGIynoVwMl7HFnhhZ?=
 =?us-ascii?Q?aHPxbZnHenZn8u7UyYNPsd0ozus3EcvZtOuDN3JuE8Y2UzfykaoYtdmob+5k?=
 =?us-ascii?Q?aB+kYVjJrfo7DXpms78YdUbSOeJLZBk5CM/owylg0Iq6fgYS8L7KsE4noTDd?=
 =?us-ascii?Q?jZHFs53z1lRt/jS1+INEQhG2Ly5wVzCwIn3mmyqAZCl4A3uzvXUbfKZ+/7kB?=
 =?us-ascii?Q?md93lJqObpRuSNVRBN0Iph8NCWKmBu1UQAuhL3hZv86VF5JKMYh3Ok/2DhHn?=
 =?us-ascii?Q?I43TXKd9BnAl/kY7mUf4r9czRKwEQhbwglm7KSjin31+y8g7qF6j+G7Lrsog?=
 =?us-ascii?Q?swNFSmnp+86EspNLzuDuTH79W6is8UKfih1pF+Xbdyc/Hg2lUWHiNXaTw+eJ?=
 =?us-ascii?Q?DRc4YsPF3pb/SfNuMQltYo1HQ+9t/fA1oRYHNZ4Ob0hKCLiN1kB0AlqvXDhE?=
 =?us-ascii?Q?hARGoqAs0xGgOus4BiNcgt3w0EusV+iErdygUWEDkeMHFW05Xb1xa2nUS8ZG?=
 =?us-ascii?Q?xF0CfWfh551zYL0U7HrlWHn/51ZSo8NXCnIGYpQt8ClDxtP26f74IUA0MN40?=
 =?us-ascii?Q?D3JmwJxVOgzg4YEH8qJkAPsCe9jcVELZYF6oqHY+DFjlgXp8d5T2TPjB1wsZ?=
 =?us-ascii?Q?qgtnwpzdVK3hJXt0I/gre7eaO1quCsgAbayz2prZaiIEs1WPsz0Hcy/+doSp?=
 =?us-ascii?Q?N70/pH8yLNvRpaqja3y1v+KUxBUC81hkdNw9EF1f+RReYEzt/9/6W7BiSK49?=
 =?us-ascii?Q?JwlFzJ5WbqGmel5TlW8HT7FYeasCmh2Ya4PULKLvIZeByEMCgK2XFC/ef8RR?=
 =?us-ascii?Q?4edJ82lIZd29EUmAVbqiqiWrCzagMw3+2xAebFtKDmC1SOgM4G+6kth7sRUf?=
 =?us-ascii?Q?PTR48vYIcQMt7to=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IYjPkhkl71byAkx3IXXwSAx9jgb6XI5ZxvvQJ9yeU3psa/Gv4TO9CGOBOc58?=
 =?us-ascii?Q?nVW9Uu8+E7t7JB5BXY7t1JqP7o2g25NX7hhGiOShEOIQXzweP4voNxpVHlSK?=
 =?us-ascii?Q?iyYYm3E+mCNXh9tdrD/40fx8jHZKuN0OuF599BPAv01tRfH7or7tIuZrHqvo?=
 =?us-ascii?Q?Lrc0e3Dy5o+U/T4ap77Cem3UAPL1dhuNqKiDbB1qxNoy/qAVEWxy01l4Nmo0?=
 =?us-ascii?Q?fTTP3t88gD8fbuCvuQi23RT5DYhIgfqn0qDmooEq/zEWUj/wSvkHwQXqjWf8?=
 =?us-ascii?Q?O6HaELPcySHDNA3KNlJFBBBLxf/2ABQPZ4qQXhZc259/qvmlDNrwgmm4rsFJ?=
 =?us-ascii?Q?J7E30HXTU/aBS2A4P3JXHKKFhNpn7NUo9CR31xgh99+SZ8zgcH8T5Y6d7w4j?=
 =?us-ascii?Q?Jl9Hyg2xXUfjVtP78jLC4WwLRI7SFL946hz57Aac2YfaqVqGDdwfROKM1chw?=
 =?us-ascii?Q?aye4t4q2WUp9n2qjR/aDdklkk/xbaUlW+1djgBjmIs8rGe0dEDSeiYqoeHqd?=
 =?us-ascii?Q?eGxAag0VjVjdYzFdWM5ahWAoRkLDqyELt9hIPmSPz8uB48ODBk7TLIWSejz3?=
 =?us-ascii?Q?vOqsRZhCbaCy5UYT07YnJGX31A+WPn2q8Vi99Yvwp4MrWrK5Jt6j9r7V2SKa?=
 =?us-ascii?Q?T6OmuiLaPnNVo5+DcqMMOWOO4XBCwwyoNGErtgQbvbg2BGYz1AfXfzTrVo/I?=
 =?us-ascii?Q?YJoY1pGlklWKXHmuio5vCfH+/zO/DqWWRSUCQyb2Ux7aH6gFh3abMCoYWq0Y?=
 =?us-ascii?Q?zv1YnHyxHdjvtvxisBQ2zbZlfy1RN2+ZA+UV+PnFtvMR7IwTkrQ8tFhCdriP?=
 =?us-ascii?Q?D5L3rnPDLg3rTtl1j5sV/FWZpumHTbOapTCSp0a7jqbLjhe4vx2d6NJ8lABZ?=
 =?us-ascii?Q?89QIlwffyiyItPU0CYUov5hILB5Gt+EmQj1vwvWIyutNFXtYWYVrtaILalcX?=
 =?us-ascii?Q?TFJQAq6sxnhyvlOEroIhiTNDGrL3NGriYRCd7C8UJ6HRAfTsOtNvUoAk7xro?=
 =?us-ascii?Q?JLHjYnraGimafNDWkeqUn5wqx3GXa22qX4Uclspx9gIJxiAFsLGPyDUq2eDI?=
 =?us-ascii?Q?+XFgg8kh5W0+LTFmyjtJbHGh0YbyLCU/YmDeoDPwVD6HYPdyNeg9OF+TT0Eh?=
 =?us-ascii?Q?Eb4iidnSkkYknYwveJxLHrDcma2KJ1C7Hv2ZmliaziUFnxTYEQWA1lCkcl5T?=
 =?us-ascii?Q?XKzr1AnlAhpNUS0A+itm8f5Abvz5tD1rXPtzIuLmlo8ohAcbdyJBZA0yM9Ri?=
 =?us-ascii?Q?DsiXMF5QNVYtRA1ZcY+F3+648jY48HyKUFbE/R+RwQTMgxvlYJ78sHf5Tpfc?=
 =?us-ascii?Q?Nn5zux4iiXBorPgT9K3EY9H1CS6yyO8jBTHmJSdkMfOgg33k6bWtGH0mtaHA?=
 =?us-ascii?Q?H0cP91UNrOqmL55yV3m8pkE9V98d8TavfteNxst41+Yvpwt51Ti+hhIxxu5l?=
 =?us-ascii?Q?ZWdoNtJ8P6LTjQMqB0JYBtnAIoPRyVx8ndXIngI8EH1lEB2VAgW9Y6gnDgqd?=
 =?us-ascii?Q?2TQjQZjm+ZhOEKMC9mBGNoJovZMC+zCbctimmwWdIkNCyPwdq4+19NN9npa3?=
 =?us-ascii?Q?P1IqnmHlgmK+jQyjTzf4Z7+0jkTltxIbIJs6gUhhzILvNnm7Zao2IS+lbwT8?=
 =?us-ascii?Q?ld4cpAj0c7Rd0vRBNH5L18Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3fb4cd-94c9-443c-5420-08ddc65f420d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:39.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eu9FtfIPQpv8pQZuT/G4coJJAvYYOaYoa6p/sELVpr8C6Dii5KOa3uGqS0SBK5p61jPUF0rz4QmSeJ5jXG+LInX4Vd12Mu08QKPDXBAJtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

This is required because airoha/en7523 will be added with the following
patches. Without this line config for en7523 will be created instead of
an7581.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index baa3fc3f5de..73af30cd693 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_AN7581=y
 CONFIG_TEXT_BASE=0x81E00000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
-- 
2.47.2

