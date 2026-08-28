Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C63C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 15:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 562C760867;
	Fri, 28 Aug 2026 15:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5AwBOW4YFYV; Fri, 28 Aug 2026 15:06:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787929579;
	bh=YYprW6OPnHcr3jF9aMMBkEsHv2XP05PuhB11gHmcpSk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rSCv84VJfSFqRMVvxsu93hJmK3EceS6DvJCF9vSIYkYepJKus6fuGwDxo96okaN8l
	 t0wrTUR/OcmQ4VKT2Q3r8BDP1YhMrIc/LSul7asxMz2QNemVIrX00dSQqynIybC0e3
	 Mik8rObDCd3XSTmfGCsSRXsHUkXEdTe+8uvR5qrWAhUl+gsJvoxnYOGeyPSJeS32J4
	 +nMMRO+lq48JUHP0+K7sPFG6x8yNcE9uNq4Yxw4dt2HBmazaKHJ7PLdawX9G0dyfUW
	 XrUsMjfa+Q02t8K+SEaVtLqnjtlFuxCbDvXdZQPTZP59Q6y1C7gt5ujdf1NyZ7G1vo
	 3xGNN3QA3XFHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C55760652;
	Fri, 28 Aug 2026 15:06:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DC86578B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE11260652
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rI32lVUDE4a for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 15:06:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=gbYQ77mx
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56171605E7
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irLuRnsQkBlvsHaMsDgyqxz5B6sCk+YQ2fuSRx9P+q5aD7h+EoHSoTNc91/dMADmyfCjrXHv53cKmIjZwfTHNSn9dqef5Lnv/B9NMfB2aQpz/lVeN/6AB1+Lihy8LsB2/Gy/AYIxCPH1D4PWuJCCCpay//+10CuBuzExCx6ts14/21hms+V0qwNrqMR/3AZEjhBTbQtp2rrXJaMr2f9qGDJQmuWXW+0/wzxNDeC3ZlVNgGXTmqZjN4REZX1h5ItnyMLp3i+WZufyVjS/cmssdFMXY0xMZC+fC4g8djRRw5BPjQwWwxqF21Cn4s5PuLhWAGpTZg7lpMfAsp1zVvprJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYprW6OPnHcr3jF9aMMBkEsHv2XP05PuhB11gHmcpSk=;
 b=dwXF1SrobkUsRAcqlgONbuxmtJVabxF0h9RBxc8e/9Hb2pBpIj5LXypeZsbTDrZXoL8iEoG9DORaqaMmHIcyOz2dnKkq6rwbIQYrwbQ1SpE91a74URigaIwQPETUMTeQ/xAeP//tGeciftlDiShcFGhaSkWrfv2DnWeP/GrBMe0AvkIuGlnUWIna2aVMO+mq7BqW25/xsQEEh0082D23DFKEompgZiJgalITOIf9iZjZ/7wndibyvCloRVcRkC41QCm/c08bWMHbr5i0qPVqWi/MYn3y3SUu49EO2DA6Lbdw2peIsP9BAaeFGU17zkxLVQwAey4Ae6B1nXnG0EiMZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYprW6OPnHcr3jF9aMMBkEsHv2XP05PuhB11gHmcpSk=;
 b=gbYQ77mxvIV/Fp9eSdpMPrMYaolm8MoAwnluyBVBKmfE0w9zGnAB4b+eWffh4T5y5O6mbSu5NT5ExqfQ5+1ZW64dVoLd+URvy17LvuNAZfkKLiRzrqWqKslvXSW/VOCFIvQCbzKV8BT8v7YZwSZQ11pFq/5mtnw2+oiq3qsNi7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 15:06:06 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:06:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Jacky Cao <Jacky.Cao@sony.com>, Tom Rini <trini@konsulko.com>,
 "nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] include/env.h: use plain old #ifdef
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
Date: Fri, 28 Aug 2026 17:06:00 +0200
Message-ID: <20260828150600.918158-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0010.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: f79aa367-961d-4f1f-fead-08df0515e2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IbQVaZolfTkUhwLQNhZxbBVLk/iLYP0D62Uk+OLqcbc872Rn4hAE5tqgN3UwAauktA7/COJ/DtJROHoKP/JS13zoG/IMcMsi1qeVuYYvJKzpDp4l/6sdq/eCVygat0L9PQan8RxVA5nLLN+mMHbQ+MajIeaWoOygiliFxZYPi4Jjy8V/6wslDi5Zj1B0z2qO6IV6YSFPcyqyrObR5Z+kb0wYtX088lt4xscHPngIPsanvEeC2dprBDptRiMvfLd/57p/FrauwSnSSXoK2uXr1/YQJ7iZy2es+X2IfX17u06gv9SehGboofXx8FPcJPjdu3tafOXPwn3xggwy1soZ64v2IcYWQlBGlsVdmljm1MhhF5uWcXUwepUk0zqLYOCASqVL8Lac9a3JGz1dbQbow07dWKBsNbck96ZcTkFTRYOo41AXRkRchPNd3xs+iBYVH7zd0/rHnMI0KKht/gwAlkQI4c1Ktx8uF2yPo7Mktorma4djk+efmPoFBxrCaEqWxj6E2Y7+EAWZ0b9MchFCb83dTc5aMCXO0Jxt/l2pGQMYdXhQZ6O1qpOcCfm0UfRh8o57IdYzaOghRRuLqZ8ATfRikKORXuk7FhZ7ojSPmOWnnOonAeJLGSh3wIOKPn9sHppKnyJPxvqa9ffJKojlzxaL7Bi/BbFGGbH6OJdbcuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tH1vyv/zb0XlhJFe+BL71NpSdHjbRBQDjChd/90DvvGwAJXqaBTNWrjrA9kn?=
 =?us-ascii?Q?KnaOjN9WDnCkp5h9jEyG2BFTgHlrHzQ6N5OjV5Xo4j+um9Hfbqq6ZN6n5LXp?=
 =?us-ascii?Q?FiGwopBGPH74xkJI6RwSCiQHm9w0W3rbAD1+vhm4m1pnWY7RmAbHZUi1YD7r?=
 =?us-ascii?Q?Kwevdx3ndAp2Ld9+1tqUJjYX0C4qBMmqCV7ycmGmEMElEjVIxj5sfUnYnpk4?=
 =?us-ascii?Q?zRlD5M9HX5GSxlHO/Th+4ozoRIhXIuDr5tBLPK8H4DGk0i7dY7wTckd5xmp0?=
 =?us-ascii?Q?TcQVYDh9jUkWa6AQl1iwrssfuLcbgv5migcj+3No4cxVVz9oiAVmHRZgV8An?=
 =?us-ascii?Q?2DnbbLN9xPxbyq8BHnU45qVdowI2X58z3bJwuuBzM3j7asg50uW3fgNxGvhU?=
 =?us-ascii?Q?idutFcmtHUzHqIFy1CaSQJDYIQjwcmOOGbjkIcrUjP4DxWrfWUDpiFv3BcLN?=
 =?us-ascii?Q?Ef3JePhf5xPPrDX9Dxn7ZuvhCI/yFYOjwhnhk7fqVj7NGgcxYN/Wtmm9Wqfe?=
 =?us-ascii?Q?+Drc38LipFdPZQoMvD3CVCdLHSOEIrS9iZW7KBGS5QttkfFvxOJAwf4KPCvO?=
 =?us-ascii?Q?OLw7FK4pA4dvgG3HRHxQOSfQpklDEAKXgA8rha97H+RIMBERqPpr7eohMXm2?=
 =?us-ascii?Q?xN/WjthnBM/qRMaBH3kTbW4jxG9Gxp+VSYiTXpBH3bcLxqWEh2LVydFyRKsl?=
 =?us-ascii?Q?c6aKojohRc0pPevnrozNvgOyUjT4BcggNZ7DfIiwuJSMYMKjM2jaaKFfRWUk?=
 =?us-ascii?Q?oQXsLiGn/gKsJ4rO84mwCEG3L1DHsjMu7bewYWwmn83X35Xe/zYdbHO9LPU7?=
 =?us-ascii?Q?56faGnVR2kYN7TITedMgcRRGKuA/lqt5sWfJV23EhuBZIP1HqnYln9+M3ROm?=
 =?us-ascii?Q?91AyfeUB5oJm4jWh/agAfq3qAz84rsyFMGt9IsgwUeelyUVPy+iIjg5LVd0V?=
 =?us-ascii?Q?Zv9a8lAXVAi5XNLoc+CM0FFjG4iTQtrc3A6nevUMAnD8ccMg7DVVvJsXevIW?=
 =?us-ascii?Q?noHDf9QiBZRLC4TUakJGff9LQ5kOXUrKXQbhm/Uo47f0WxqOWveeLOdzOzFi?=
 =?us-ascii?Q?7nmaUFC0EeascXRkuhIlm1Zdw5iZYd93R/bO7jf++ZY8DgO8FDQIGBV3hIMY?=
 =?us-ascii?Q?MFUPWSYgcXULjr59ajjpqq47FjwDng5lNoF/U9U4FmSYJYLVGLefQgZdRUnm?=
 =?us-ascii?Q?Uj63rcgSMp5D2hUX2IlVLw4mJrtEhiuM1N7URZYX8pDtVlzcAWBR3BRWuL+N?=
 =?us-ascii?Q?1jtGrVQhS9lzJL2M5sFPmInoOv+vntqKJcFn8VcbG5LsD1FgHIzPSUymXBW7?=
 =?us-ascii?Q?uMm4YPi/TQbEEbsWe+fWw3unYRKNfIVeyo/oy4x875ntQPQteGKyoddX0DOH?=
 =?us-ascii?Q?OiRdrLfGvHLXWgKka9ARN2D6mnsXw7bocLIWc2yvmRYt+DXkeKG9IJP7auiM?=
 =?us-ascii?Q?Vqsv7da1hrUbjH0Azv6PGArFaGg6skswsE7RCh+ZrbgojuTV3FUQYW/sZ2/a?=
 =?us-ascii?Q?QjIRzLvr4LGD4Y1BblkCwMHhoBP7tsnW6u1gUuDPm1kQ6SUHV0CbxEJ8JWyv?=
 =?us-ascii?Q?nUIOqAZtofNB1HgmTqEwjWFbesuo4V9Wv+CzxbWr0qe0g2tBO6kUpH8fdQh4?=
 =?us-ascii?Q?+UJyeiRWEARyzMumVdWg96q34xrPAeKv58K/R6+Z2yyd/sKdRTT0mUO6XwCF?=
 =?us-ascii?Q?2C8A80sfSya7sZBRJ9U4b9oJhIq50wsiTQ7yl7UE/VkgyQCwh+O0w4UqPPkV?=
 =?us-ascii?Q?DRCQATDRYpdMF4Flv2awVeiK0ePwqWs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f79aa367-961d-4f1f-fead-08df0515e2a4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:06:06.6592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3UNFK/eS8/Oc0qVMBsulBfzL2aAMN4hNqPkwfZ0SlQB1DOFDdWan7kNuX7F0cx2bQjMCm1xFDi2xaK70F35VxwIhCcSxzZD3YWiChhSp04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7780
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Commit 9f1807e57cb ("env: add env_set_runtime() helper") broke the use
of "make envtools" to create the target fw_setenv/fw_printenv
binaries. The problem is that the #include <config.h>, in addition to
pulling in linux/kconfig.h to get the IS_ENABLED() helper, also ends
up pulling in lots of architecture/board specific headers.

Fix it by simply using an #ifdef.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

Tom said "Just using a normal #if/#else/#endif would be the better fix
here." so here it is.

I'm still far from convinced of the value of this helper, but if the
tq-group folks want it it's not a hill I'm gonna die on, I just want
to be able to build and ship v2026.07.

 include/env.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/env.h b/include/env.h
index 9b872fb26eb..8bd6cf23932 100644
--- a/include/env.h
+++ b/include/env.h
@@ -9,7 +9,6 @@
 #ifndef __ENV_H
 #define __ENV_H
 
-#include <config.h>
 #include <compiler.h>
 #include <stdbool.h>
 #include <linux/types.h>
@@ -174,10 +173,11 @@ int env_set(const char *varname, const char *value);
  */
 static inline int env_set_runtime(const char *varname, const char *value)
 {
-	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
-		return env_set(varname, value);
-
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	return env_set(varname, value);
+#else
 	return 0;
+#endif
 }
 
 /**
-- 
2.55.0

