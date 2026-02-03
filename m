Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56BE7C712
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB368405A;
	Tue,  3 Feb 2026 12:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rQb93Neh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6425E84088; Tue,  3 Feb 2026 12:46:06 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71ACC8401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6g/KSDz3wfMvjXE+p5Pfn0mARtZ+viS/A6AEx//AJZ3pHgWfyMWVaNDuZ7kyYYj4hUJZfiog7hTy1pXy3nVRp34HPboZHwEUTWxPhbpkVjd3+CSNBwBc6h1mWC8hXlnGtNKFnLTxAXc1EdNtHpAKbZTnSxULvd3yXQ4fhKsLsdIEWGITBB+WBUB3ibb+B9Mv+gLJ+rS3fUqb6opq5pfThvS4a4ERIqxf0M1b4qt5h94DnV/x8R/1zi1Ofe0BNgaQq4xoXICXZBTldEXybJtpAiyB9B7fLsLHVcvbonU26nGbVytaVR1GkBjowOmPFywTzBgOmEub+Z4+2ccPEfMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljlUxSr6Xs1gqfZO7Wvzv5Wbuh/CH2RHpDwiSfn1idk=;
 b=TORr423RmF0Mc7K3eiJuhGMhAxZ7PEfRc5w9kFJ8vBqS6Mq8aOJ+jZrTYku35lKMlwgkgof/m6N2GLHKU0Juf95f75E1ULc9a7/afNdTBX2tmRrYsfyriEEbjGdLZAZvvReJe/Y3SsWR1Gce7cm4YfZrNod7Sy4vfrs2oipTezL2KH6XL1BS9GystnlV9uE6YcpHe2h4eP94MKDVRNg15tEPFKWz6c8xlpp320IKFqBbYUE750TyQxRDb1Et1SY3lC6LdsKcV++0LU9zAJ8y8JnMQuNzckZObafgFUL/HtDkzYb/eyw5GVbRSa7Nlx1iaLy42kSTdXgioIc4sYfMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljlUxSr6Xs1gqfZO7Wvzv5Wbuh/CH2RHpDwiSfn1idk=;
 b=rQb93Neh+GsvvYO/BxZBc4vZGKA/cZHMUU/T5CFJQA5rbuH6n5RP8ewdjNYMMpktBe6Du8eerpVPqEg3g96m5pDdNfS78/0b6PDUqyO7BafIOibzzc4oohwJHWm51slNXLX4gkabBU8XtXeFVg1jhOQEm1r4nFvL2RWPw4XvI0kgKA/nsmUTEZeltP1EZoabUfll+/Il6SQ4GBO06V3LyV6+3iOZrGQycWsDsJGVxp45DpJtji5qq3/KDGEjFrAqwAHsYl84mXgfHlofdJLgT0IqhgarLC54sKPHVnls8yWtpuf7OBTcJut7Y9FBn8ym7jq3isF1aVCZwPqjGxbagw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11766.eurprd04.prod.outlook.com (2603:10a6:800:2e8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:46:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 11:46:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH RESEND 13/14] socfpga: clock_manager_s10: Add missing header
 files
Date: Tue,  3 Feb 2026 19:47:00 +0800
Message-Id: <20260203114702.1867224-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0259.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbccd53-16b1-4afd-2200-08de6319ce1a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjNjNfdNNGyOCJHJzaYoFUQmCGqvXMSW5oEOJn8n8CwPLPLLtSPR1SnzF4l5?=
 =?us-ascii?Q?DMoWWmQNKfGGSng5BwNr5O7abfifqWNAxUIdZ6/fGC0I+abXzNrYWndrVvpT?=
 =?us-ascii?Q?Q3xmsBElWQMz1MZKV0Vnf47qgJEMsbhgHfVLIaxHJH1E1BGpffy+4gcXnAX8?=
 =?us-ascii?Q?SvzCk9MwJA5+1lHRsVa0msvxyPsxACAydAnuOLB4P6IG0cT6752yR9s+uqoe?=
 =?us-ascii?Q?dOd2mpF7aZutoE+d4E2lkzShmsV56W5pjwn5l/gPAprYMadbbDIsuM9G9HAM?=
 =?us-ascii?Q?NXxRwAAiFTIbyoWs5S/6Nm6ZetM1wYrLMdWLGg6yBONi1W3dIATZBCyoVv0o?=
 =?us-ascii?Q?LTsSQe5TmGIOplUp45MJnEGmfHI90KGDby+vbBucZUjggtLlsXKNuwkzaBcA?=
 =?us-ascii?Q?gadfEzEJdzjMaD8R8TfBtdw8GCEEgoLS3c9xkv2AS19zCg3QogQ9aRh0DMMJ?=
 =?us-ascii?Q?11SODC6X7ALULBoQYXGNlUUBs85nKhoIms4ee5KUCvDSLRnNfADNmi6CIr8L?=
 =?us-ascii?Q?ufUTEuBDrMDJRpFDi/+P4N9sokkea2uLLSVcfKF3AoPyWqF7xDq6mRxhuBNg?=
 =?us-ascii?Q?fXTFmIpp3D7vMYwD2XwjZBEXJ17NUaSCE/Wy7SPUJ8eXGY4uZu3xl98MM7Qn?=
 =?us-ascii?Q?nvU9COky/uJqMyXFZGXbAJDLKiEpA5zx2KIxww0OXS2ucxFsMge16VIvoxq3?=
 =?us-ascii?Q?qLTzcLf4Spo5HKbgPv1bw9fj7cGHJctEmuPMaW6AyWPkdwC7KYaiYtw/8xKD?=
 =?us-ascii?Q?yyVmYFPzUyruzRSe8w14Fd0yb5fZ8FYsdplkBSW5aXAeAxf9HclOu0kW04dE?=
 =?us-ascii?Q?vPhPC1rgWotcLEkQD3IkfzwzZW++oGP4wy4MlKfiSUevsV0S0nKBqkQkWHyr?=
 =?us-ascii?Q?qQGRQS2F0nGjgNdS5JYgcWaQoYzcT7Tv64RtDO/ikJNIv4CulvBcnTxjmH+v?=
 =?us-ascii?Q?5UoqIgQlhY2O/Ck1hZSqKbggUX/IVvzySVFyuBJrVu8di/ZaplUbAUohFkHQ?=
 =?us-ascii?Q?hX+c0lxUeUnrvF7mQUF3+c2WEmFaRv111HPBIw2iPO4i9iE91dMwYlLzXho3?=
 =?us-ascii?Q?+cOn7EG9VRUdj1sHtad6edliosvt8+TX1S5aYFM//zIRh3UaJGkU4vty4ivY?=
 =?us-ascii?Q?TzCCs02awcl3ukskfg0slEs3NeNU0HbvjY0V/PB5bm5n6i1NGV/Iuvd4getM?=
 =?us-ascii?Q?0i+5B0a4ZcUTuQpOeKeEfVPLxMHBGpuOr9BWSj2k/my5aXHnIEkt1kB6C3p6?=
 =?us-ascii?Q?DsvZkVTq8252Z7A1aCeDLm1639Lbm78453PVdOO5PapsYqI5cRpBQAcYLbM5?=
 =?us-ascii?Q?QhBh7yPhPF22SBQgzOFJhoFeHk7iI23t7DHSRI4UkGt5s7kHx9qMhNm98DZP?=
 =?us-ascii?Q?WmLhMedjmPe/i/998EhLdXdNcfYM5cvLPX5nW58F6IQh1pW/4Jc6FosPcJEK?=
 =?us-ascii?Q?rILcufO6RRMGESoi4DJAwKw34jj70yqDkHckzHLxOTsrAY2qKSuOzTc6Cd88?=
 =?us-ascii?Q?0kklXqu0h9mneRMBdKjI69Q3KNVSwO6ZdsE+lIUN+n3pVWbFyjE+bBwuI9Vm?=
 =?us-ascii?Q?jgwVhlBCS+Lrl/1IZgphyUK/7Irj5N3aiC6qO/2TvK1JCONJtTac5adTfWFD?=
 =?us-ascii?Q?7320+D3Mrn3SmLU4xtDTfeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hq6Sr21ADSnITB6tOQnyhmvMrNkzlxkMWJIRXG8qG2ajn/CN22fZZMd0B8GP?=
 =?us-ascii?Q?7EYsUvpRwFA7jC4Fgq6Qz3RH7bLdgOvPaUsRmEsl/lobTqRvQMsLdI0ClojS?=
 =?us-ascii?Q?QRvm2Nrbwb4J7ZDJUTTxUULZ7gACcZZpf6wXEVAj+51DLj3jffYCeSX7KOZ6?=
 =?us-ascii?Q?vqs8cHgMJVuuJ5EtEBRPDZnl6yZDxjmwYvnzie8Lm/V4Fofi7zw/ytqbyNkh?=
 =?us-ascii?Q?B+lYefb2A56A5qaFDZFjyLZ6oIiOBoyB9UuQa44zMJPrqVpvX117MT43TdDo?=
 =?us-ascii?Q?JvLNlegq6uZCaCCkYRVuAf6FHImXWWDq1NOc3pUbHZiFPwO2SGX+FJW1ZXX9?=
 =?us-ascii?Q?90hqX05n7zpXKYTff8I2w4OT1y16AaxMadDrJTzqQ0lNHb4i8V9Wfv2/pMj2?=
 =?us-ascii?Q?LQxmhRSu2X5RsnpCXWcwvF29ooTj2XoXnzMqshsElBevDfpN1Lveiot+xI9s?=
 =?us-ascii?Q?p/1ElQPsRgEaMV/CmLtxlENLFHHiBsTeSjURrRZg6IBEGpW46uY/+s8pU7pS?=
 =?us-ascii?Q?mOiY1vKTdYFAjiljBxEHEBH56qKqNZKljvVTdc2yGHBjjYojfA6earpuOqyr?=
 =?us-ascii?Q?h8mzoWk3UCjTZLG1+SPkydFBTMfnGcYv68+VjvnwBsGsCYw27kO1vISJzOu9?=
 =?us-ascii?Q?F0zPJdUSMBMUe0lzk8flAJKCzb6/Xr/Jp/wRzZMEwd/v1GNRLOKqorLdK/JD?=
 =?us-ascii?Q?rmgktSZa9/MPm5L9poe713HmXQRe2JNa+MCKiP8OOOH2e6LckQWydvAXZh6r?=
 =?us-ascii?Q?4QMYFD6BgIV0VpeIIAfgCXPI8bxEMM3NgwvDDRaRScGTkMH4KOkpL4RaOVSL?=
 =?us-ascii?Q?Hhmo9ARs+LFBNpA2iGn1zOx0Tt8nzvdgp+a+deZzBEjTKnhbZnveMk0Ta2C5?=
 =?us-ascii?Q?89Bv6zqp2d9+qKJ3kbXcVkeslHnyCd94wAjjqwZaiXAS/wW0howP4MTIuLBc?=
 =?us-ascii?Q?NInfI535rT+ZSbwPtHhFXFfvOe3l4yueAc/8q70UFBSq/X8JIVv1+VI3BbK6?=
 =?us-ascii?Q?9NsdiebV9r5tM9/yhzR3PjLPP2XXmbKYqYKauCSKL76cxMk6bkYHFhBUleg3?=
 =?us-ascii?Q?RWVP1WUcmZkuUTWLxRoAClD8okE/AQSVdzvslWPr07Ymw5VkXRuwokD7pYg0?=
 =?us-ascii?Q?1My2BGwYoOtViQttO1Z6KKmXyQp18P/cakEZNzwjr5PRyUeeroT9QUnF7pJV?=
 =?us-ascii?Q?bXgrzRHA4bqCubaY1tRTL+hLzu8zZwy4zHty9ZUoM75MENgi9ndLnRnuoYVm?=
 =?us-ascii?Q?3gbAKv/i3tdmH9yuuBwPDYfFUTlJup1aUFv46fjqVOJS6QBCYzje4zn4nBuy?=
 =?us-ascii?Q?H3xS04xytbk/AMA89jvUJ2aQNxQFtHj4WEH4ShdqfusNu+p8L4Pj9K8s+gtx?=
 =?us-ascii?Q?nAqjL7LJwCm+bJdgFR2C+7ZKQzQfAihKfPH2wNxl/7sWPBADl7RZk2pDy9Zr?=
 =?us-ascii?Q?iFUxYWnG0meG5ocSH1+Fibev6sKgZTOStf7BMpU0/pDZ8khA1Ckch/11ShKE?=
 =?us-ascii?Q?Ukg+dFEgxJ1knCXp35g3PvbbCZVoKrYLb/IDTYmVhVmd97dmHAOomYbG+kBM?=
 =?us-ascii?Q?gvpPW2AVfYXNa7UboxckYpHuxAlkhpL6DeS5QCSItW3dtMEDhNpjMkQPlXAI?=
 =?us-ascii?Q?+mP0OUXXBaVhskREwVtdoxR1CwRKvDyFd224tu17+w40zBixmKIReY6s+IpP?=
 =?us-ascii?Q?3kUCs9FifEw6ac9burh3+QLvCiyu3KLcrR7H0P6Dn0+i00LlSl8+h9/jWL4O?=
 =?us-ascii?Q?y3psws+HTA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbccd53-16b1-4afd-2200-08de6319ce1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:46:01.9790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wueTbraUIVoE0FMtdlqEQLFDqcDEwHepEKHrD9hxBh5T51D1LglHAcSUr2Z3qG62rP7e+ruMV1rj9p+ZgAO7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11766
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

struct udevice and u32 are used in this file. Add missing header to avoid
building break after asm/global_data.h is removed from this file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-socfpga/clock_manager_s10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index 1e148947a33..d6c64e98010 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -4,6 +4,8 @@
  *
  */
 
+#include <compiler.h>
+#include <dm/device.h>
 #include <linux/errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-- 
2.37.1

