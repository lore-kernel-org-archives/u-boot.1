Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E699C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF3C83ED7;
	Mon,  4 Aug 2025 03:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="de218z+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A221083EA4; Mon,  4 Aug 2025 03:25:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9248383E83
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrfwmPNv9+UOgxCaTqSCBXWzoFJRYonquNB7LCxl0qcbF0wcZOkSvuROPIuaeyI2bDYp9LKdk3wDd4ieYjoEIiIP5FLTQeOif+InID6umj5PNeuCYE317FvG7YWHTUQi8sFdJVsrOrTfY4/jFsABTIYLK/BingpUW2jwyY8KLEHVOG6o7uUMTWnAqDFTjm0fa7gVWzM0zz41dJIkeh6rnWGHMMbzpKHKuk+ZT4tEt03EL9GigJHoH1EXusIoqPH3r2+kDuCzMIIerFFdq6Fsyn/ZSjjtA+RstS7V5yZrRvAxAmGIrzP7CMgmvNxQj4dI+lJSfC7GHAK0yTwV2qoFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RboACDcjx2AZhBFbolq24qsqzOYDIEmEXxEtmBpLz0=;
 b=Pq0wR7etmtf4m6DnLYgh5YtAkp7wemSxkICjIDjwgxSWZbtmuN/TPXU2STVr03nh9Yoh1UKliOwffnidyx7O+BERs+CDuD8QVsz16shphTLbsbo6kLYTdZoR9UNeLXI4sEcgXV0wPf2coLGjlHq3QdxM/7gyH18SX187zTJaFVIoZfCfMk6XTHdtLkdGSN74ySNFBASzyj8dpjHAccvxUgkmovw+itOlzhCjzAQGsCXhGzv8qeLqdjnIp4vQabBfCQ5PbbxngmHluNAfWG0BZ3O40wcTrV9tUKXjJFDBxu51tSJphv70AmtFY/wfjGJAss887b6mwRN5Q7tWWyXOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RboACDcjx2AZhBFbolq24qsqzOYDIEmEXxEtmBpLz0=;
 b=de218z+EeIA5YKNttB+Q3E034S82mK60kZmcIlk1/ZO6F+TpLZvabHGUm3n148RAICIiUKdjEaHVosEcYbailSKFpHa6F8f1239F6yMy9p6phtcg/HfRbEoxCW0/U8se3yjRqFp+MT7YtPd/0jhOazP1Z8WttNJoXFl0avUyGNYrAl0K4HSE8H5b+uqGGcS+3r/nu7ymLPF2vQ4Vct723YM30FdLtZcWGWucYGYuCOojrA4+T3YGyRxZH6yGYcsI9hLr5+zT9c7Xr9fi76IaYyi1dVefxWoaqvYiNlMlyqJSvhNd72SGYutwAijeVJ43IG9TzE2/r3yts7cMi9jfXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:32 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:32 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 26/34] include: configs: soc64: Use CONFIG_SPL_ATF to
 differentiate bootfile
Date: Sun,  3 Aug 2025 18:24:53 -0700
Message-Id: <20250804012501.21811-27-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 796dfb27-b768-4635-47e8-08ddd2f5ce1b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S2ka31SPO/6p+V0yGE5z8TJRCU16vgDvGbN0rgKcuAJPSj5Qn9T08zR+PHq/?=
 =?us-ascii?Q?fmI0sz/BEuZOgcVo43S9QWCkUrGluTvrntl1eoXTbWOmuuUCYkGTwPBji4SX?=
 =?us-ascii?Q?cilZQfvLPVRkuUyyP33rU+hFHUjgZUoy5337H5+2tLHDNaBzgrH0I79dq/hw?=
 =?us-ascii?Q?S7FpxcEdSQBS2JQB4aZ22fiY12xhQtqSfnD87o8vJcLfE9HB1Y+r65aYETL1?=
 =?us-ascii?Q?0SF6kc12+wevfNADby+yRYh7KmIaQY8oWeXCSlzwZqsjIyIbvLFEj1z/Fr+O?=
 =?us-ascii?Q?pqegWUChglJXN8RN1SK46pnMsjppgVXUzDHvmCS7JPyi9BycTn83Gix5sSmT?=
 =?us-ascii?Q?3KFXVba5h54JJoHtsGEcd+wQvT8vFJmbsFyPxNQVugwdD0hJHBtfGGkqsr4D?=
 =?us-ascii?Q?Pmwf1D9FDZLznWvi5DDCn5ib9AphQvfmLXCvPt/QfqVLx9OQOp8DoHDQZruG?=
 =?us-ascii?Q?DylDVRZpN9JwjoISeEUW1Yyv9OfiYfKnNNLdulzbxlZ4E1no5VbucarsqmX4?=
 =?us-ascii?Q?Eo/CUetpgQuDcjR7xxxc7aFeikYhkNcEKVc8/7HkHoVXwdjK91bJhla+hjCS?=
 =?us-ascii?Q?BaQmDpD8aVSBP4prMYJ6PeLpuPVADtDR5ZUeFiXgqudAJ02cETmd2iSQhRox?=
 =?us-ascii?Q?tc6pr/Duj18UdrU/ZRSelGuBa/H0Erg1TUuycxb5m3fEsc3ANyy5XiO8vdmV?=
 =?us-ascii?Q?KWVKa+4z7LQ7P5HPg2z5ApxLDKoB9ZauYYYpmq5KIVwDDvUZogTfoodJmIzG?=
 =?us-ascii?Q?Mf6znslEoSRV7jKU3YbHtkHkhlrZYlvcoqh1G2z75Ppd5enBtv6n3m/sOEEO?=
 =?us-ascii?Q?RyDnPf5Pp0KmWU6i6flahrv+G+tZ6zWsOQ5+FuzB8IxfhFHCPccHfWnO8YXV?=
 =?us-ascii?Q?4jOb3nlVhqq9EKoDrCLFG3ygOaZtWKy8zoar/oS+93Df3XrevjpciA1Lxs8X?=
 =?us-ascii?Q?mmWdqCyKpC6H5MfbHcDvQvrOifgYTn1iDF7T4tOk7I0gLYJ1mD80SRVkppOE?=
 =?us-ascii?Q?jv7QbAC/EhB+doSW8TViee8RQb6jEAeZmqVXSScRAt7YhHvqiwKCwBRDIWQ7?=
 =?us-ascii?Q?Uca47sZ0mP9tOkJj1nKIxTZxrhhf0UNPqCZtIgk2yXnkLwNzvnRzT3cysV5M?=
 =?us-ascii?Q?EXqYZHtsDc7rdNzLkVr7cnU8yfc7iQZfRzkEIzKKV1kidbnLN3q4MnpUyeBl?=
 =?us-ascii?Q?1l9O6H649RKfXtbhY9QdIFcRJR3GlgIEJ5NVwa5FulHVqG29waXHZCmNOc/C?=
 =?us-ascii?Q?4wwJfAv0aqFG1Hl/pWWeVmO3EJmAoLexN9xTkDq4DkcoIdk8YJoE0jQJ17Kc?=
 =?us-ascii?Q?YKotFBEuPRO+Md9vx4StZ7ZHJuihxrGLHavedrN/nHxmZILq/zqyMxvxDGkp?=
 =?us-ascii?Q?dGuMvJfIZUlf03nkoeCzZJl/B1pa4mltPV2k6dU+WmpEGpHb98zJggSbC0Nu?=
 =?us-ascii?Q?WwN+kgicYcQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?maw4A80b3e/Co2HSI5A6HmTUt1okLply+zwxBb2YrhA3kQWiXKIUjI1TustM?=
 =?us-ascii?Q?OC9PqTojkG7K0KOXNCmwrEzaMaLwOoi0Mh+tPoMAH7giu07vDnvqM50FVeSL?=
 =?us-ascii?Q?hdHr+2tQylg/uYZ4PNwVhTyUKeYfCp9BUNZ/Q2/NE7+xlsY9QBDiGzYVP68y?=
 =?us-ascii?Q?+U2VmQKatq1BETEg6elyCls5xgK2dHpqXbfCJyfgnyFxA0XRjsaLOUERuOyp?=
 =?us-ascii?Q?QUytFSOCmCX8L9r1RwQO2SlvILgoQPp9LBzc3RZq07+BqbAwpQfd8GuaO37G?=
 =?us-ascii?Q?Jz8iDP0D36Vw8DTazVFppWOdHUR1U49FIgohu2bNbYZdq2Mrb29j87OAs3Le?=
 =?us-ascii?Q?wGOEyvQGYVTjua0BYYf+IwXeMe1ys7PFh/3NPaJFEbw0149v76cYV1o/C77F?=
 =?us-ascii?Q?RUE6BuuyWEYdVmW8WNRaX6Vj3JZ4QNV3qnb8pCnGI/bn5NKXDQ1YAByRINDG?=
 =?us-ascii?Q?nOzL8IIapU4yMzRmzFg/OOK61xFYgfBun+KZoOLYjAWJ+y+FzgnrjiptuoQ5?=
 =?us-ascii?Q?DzAWlVBJHZ9aVauSR+p7hNep6bw5TrNSsU1bfKP/Uhi22I26fvOR7IKS53lg?=
 =?us-ascii?Q?gjM7pvOOjaiMmWZ94ZZ+RjMVJS+XOJQUJ9Kw39LqHgH7bKyOE/IQdVhHprlW?=
 =?us-ascii?Q?y2TU2ZeQ1nrJgIZ173szIrmeQaNGXaMvov6CzaRTYgigoZBNYHmNPLLQlBIF?=
 =?us-ascii?Q?E2zmhshuGbY8iIJt7M03yhdDCLYXr1/Q2BiEDqHkpvdPH25Rvd5xtIUbOU6D?=
 =?us-ascii?Q?JSjBMY6/sWEIJGZmzi3V0Y3f4GU+usyvoXLC3+rKrZ4pay/BnFBQp08AObh6?=
 =?us-ascii?Q?FFDupnl+dXVsX1nu+ZfUTU99nxWDPsp8MDeVFc1Nwh0MzBAiNRC1867om2OG?=
 =?us-ascii?Q?PY3RksBFy3UkFze5UX3ipvhiB/6nkKrXP632s9eDZ5mjCneDKPnzaxsRQuyN?=
 =?us-ascii?Q?1MtQGY9wbEiD+SfpQjuENBYrsxlgTKIdBdRHVvJDYzhM6/pHqryh6PqvnR0j?=
 =?us-ascii?Q?hW1mXmCuwEH+KBBHgFqlA10b+RiUMkvW3qgOI9OeD4X/TVIrGNUtK525uSee?=
 =?us-ascii?Q?AM9+O1ASdx3frM+cDMBTZjjBPbk5hxP6Py4e27dfSLWuOByEc+Sj/KAYA7SK?=
 =?us-ascii?Q?biL56lWJRCHuGf7zwtxHqorLczB0ixpMTM2XO5//F+bH/fx9SCLo3BlyKCL6?=
 =?us-ascii?Q?h1r1gQWoLyqg8NYWZxPQGi4NFBmSymTwe3EpfJAN6IpdxI3FGjUlnkhrlPAj?=
 =?us-ascii?Q?632p28azTGEHpOW9ffRbW8u72vdiWKrsNs9q/4DxRerj5iTnzfnflrUdPn0E?=
 =?us-ascii?Q?TDuuurFaoK4ypOz0naE7oqD8CmAkTNSvQoEDYbp0v3ExFZeosy9qeYwSYxc8?=
 =?us-ascii?Q?o0hvA/u9o0gVbwIDukdGOUDy1k4XasoOxpfs7xlh9M/uCePNOtrmY57E/1vC?=
 =?us-ascii?Q?MIs8meKVmo4B5HnkevOjcxNKD1fdzbKu+KH6XmVMJhSP5dY3Txz4fOjDGGLY?=
 =?us-ascii?Q?NffmJa4WTmuw68o5/kEOyxKjubIHHSB7Vf/vIMpRezs0LBLeva5cmzkz93iz?=
 =?us-ascii?Q?9wNd3vFf2xDYaXgpCtNKXzhIaKNSO+ZBdFf4Nc+Jlr39CMeQjyvTifNK4FTJ?=
 =?us-ascii?Q?ykxkHjEPqo2cauFhttL0rMQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796dfb27-b768-4635-47e8-08ddd2f5ce1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:32.4915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcBYD/gumqRAxFatXbKPlorKzMWQdsQQRapWBj1qq0KAGsdNmB6dw5zl1qWCNNwgJcqBgAt57WQAPj1mi25uZ3+Y4ck4+6pRFd67w7FzCfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Tingting Meng <tingting.meng@altera.com>

ATF boot flow (SPL->ATF->U-Boot Proper->OS) boot to OS via kernel.itb file
using bootm command.

Change to use CONFIG_SPL_ATF to differentiate the bootfile of default
environment variable. We shouldn't use CONFIG_FIT because it is enabled
by default for U-Boot Proper.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1de2a895dd4..d7c9e18fa41 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,9 @@ config ARM64_CRC32
 	  not be present on all ARMv8.0, but is always present on ARMv8.1 and
 	  newer.
 
+config BOOTFILE
+	default kernel.itb if SPL_ATF && TARGET_SOCFPGA_SOC64
+
 config COUNTER_FREQUENCY
 	int "Timer clock frequency"
 	depends on ARM64 || CPU_V7A
-- 
2.35.3

