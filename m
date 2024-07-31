Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB2C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C853F88A28;
	Wed, 31 Jul 2024 16:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iR4JAZTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0891F88A39; Wed, 31 Jul 2024 16:56:32 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDE58881B
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtRVTcRanGTSkFYpQqGACerpT4a+yKKT4M6v1kMdf+Fk7gpns0M/FJR+p/isol6eY8CUpS0imwQ26pwrAsfeCwUQdGbVaTVWupBcjN5DhC+iZJwtXxg865gkPAx1lKgcWLLDm3TSMNJS3TyTGikwx9BPCfR2hvcZyl3pOqP8Rcc4x6plYQaX8liHz9UcvO4zTNDCoIEwpa2oTeMGHoEAarHby4Dnk5p1go4DU1zqE433YixSDuGfIA+MlTZCJu9AZfLlxL7Uq/fK5sj22E0tAqIHbne3Idvu7JovMMH4RVbD/AClg0aNjyNh0VM6/z+yEiWBePYa69R/l+mz1TROmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQC2+DFFpHkE1Mmc7a/DMHmOtexXkI/aVsZBtqrKUYg=;
 b=nF/j9/5T8QQp+5iTww1KM17Vqcjp15yBCAugPYfjqnbVpb0qL94rpxdDzXSkElFjzZIeyOLnK2acou6qa7YIug0+4kMGtcwwr6yQ5netRsoFYZn7sujq7J3Dt+vDc7DDHV6gMxWNa5efLv1VDIjHInDj4t/kfEO5zZZBPj421tLWSwKAbfL8q4mLAL7stQHKf7QDO/o1l1LYRfQEdvEb5M0GUl/ElWB7qvDI0SQhZqKIFc83w9ZjCig9VCBKFi0iGr0sdXVZayeBz8aoLtVv/cMpJc01SwQQyME8fb5rzl14IZ0hx1+PIAaAOiYaaixSkXkiKSfJ9HQSgPpvRxNjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQC2+DFFpHkE1Mmc7a/DMHmOtexXkI/aVsZBtqrKUYg=;
 b=iR4JAZTZOpNa7FvdmprIZNM8kcTstsDS/KYl86H/8gQCWLYezi5BzjIctEAkepVPqdawdrtaIu3IqugC5J4QCZAW+6vqF6gW+dh0iZ4afCwYZDgnTbF6AS1TIi5LQYAUX+Qf4e3AdTi5K1irCvbYEO59KPgSHVrr0CML4BAdEe4w/s4OEWkkgBeSjPo31elJE7q/3Yml5BEVAqwZjBMBn53xerHJh7Lg5qUmJyTb8S3TFD0hGRgPKVpsgzYLX1R5gcUQtsRtDz6LEQsRyVglLKUbKNABHKo2VKt3tnnCDjSBV9L9ufZs+o/hI3OyxgVJk17Yv3eJMO4XvW/tV+A9Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6333.eurprd08.prod.outlook.com (2603:10a6:102:15b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 14:56:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 14:56:26 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] cmd: led: fix led command usage for the LED_SW_BLINK
 enabled case
Date: Wed, 31 Jul 2024 18:56:13 +0400
Message-Id: <20240731145613.48440-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 02115b49-6522-444b-3f87-08dcb170f3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxeVxin4Iay0XSPs1UsZ6IChw4RgX/UkIGW4Akk7ynl7YRjufTeoEmbyEiOS?=
 =?us-ascii?Q?gciztGsCc9ecg1Y9mQhz8ILh10BVhqfFY4BR1RNTJoTTYDpiRbm0B6LtFkgb?=
 =?us-ascii?Q?a0Th4YuSMsLBPfip4S7V7+KED5lYPjUJ1gl5ckyoH0tCYRKA1Pbonl5/23Hf?=
 =?us-ascii?Q?CohfbwRmbzimTP7yPhyFwb+NyzejemCfcbvYJTbN5Pv1aLkUHpVAhV5FEHXF?=
 =?us-ascii?Q?dYoGAliYqh0ULsoJzkfS/ipntZ2mBccwrYa78J7wsc78wMCwywwYTOlClsPZ?=
 =?us-ascii?Q?6A3zNmr74M4018RLGVp+zyDU2eCer6BHXzDAYRWIj10PChW/Q5g0ArHMZHkg?=
 =?us-ascii?Q?le4/gkvyzFAvF7pElIkDwvCl0INgt2LK6SKUxY/cezJ/uLvzIwsL5aKfiExO?=
 =?us-ascii?Q?RW6IAG2tr7dv5/EcC8FNtuJ+EnOaI/nG8BMtK76cnMDokxdjqGwoxB3Ep8Jg?=
 =?us-ascii?Q?Jst2eVL2DP5VGMGRfXZUCqcDNBP7UrTqODQYPMk2Ez5bGM1z6JzDYnGUgY6G?=
 =?us-ascii?Q?EHmXEZhNuT6sryk5Wi6VE9eRLl/IYNvkNNZjx9VVs1imX36rgE3xBTTfIUoz?=
 =?us-ascii?Q?NopwW8n+cvsu0Ff7dgN+LxCb2t3lxPGkYp8iE598eebhn2iYEhkPhnMy10Mb?=
 =?us-ascii?Q?d1v36Hln+aPorS9UIZLkqn/b5Pd9QnFv2AeXQ+Z1xKHc+UFy32cNsOsBUnfr?=
 =?us-ascii?Q?3wv+EkNxW9qcjz+CsrHZF0X88ScRrYMnQAxSZYIf4hazrTpZKniwGITmKBip?=
 =?us-ascii?Q?oK91Bm16i19m0zfnixjy1ag9sWTGWGPSm6X2osaXxWFm6v9MjQm4fxt97NtB?=
 =?us-ascii?Q?gct7pY1T7onzuq6L9pfoi3rDZLKIqr7N4YSvYlGm0jojUvKpuW04ysizA7Y1?=
 =?us-ascii?Q?Or0P1+FmwR5leWEbqIePRVTHEt3AgL++GhMNZ1SLPEPAiGqqcwgGgyTMsCf5?=
 =?us-ascii?Q?Sf2PU5ijWfRcNlL/0AXWduDpRp6EVwRp7UJ7Rq7PhRY8dZAEe7Pjj341XsHC?=
 =?us-ascii?Q?oFtzX1w/rqhyEBLum5hfZtDk3at2mh4tsbkoZ/ivp3nXhwalHd1lFLhQWAzK?=
 =?us-ascii?Q?Dmgf5fTc3koAd4eZ5ycOIJ/9XDCvY8RdNo2oEYTkShI9/84eCrLvAY0Xd31s?=
 =?us-ascii?Q?yVoi/jA7GYcoPFzozRPiDGlUc8jxbBk+P01OSJSqIitC77ceVMinxSpsljie?=
 =?us-ascii?Q?GhbXG1qlUAar5FT7UuX3fOoAMhTD5s1aoIEeZDYPweA9mfiaE3NAB3HU/3l3?=
 =?us-ascii?Q?FaMXknxJNWtLvU4W8F2ko9fkAGiSzGKpgZ25ehH6CnaaP8mwrp7A7YYsxxAE?=
 =?us-ascii?Q?ECVHfJgcXxJ8rLeIQYeHnT/4sKZvWETsUPVhXQb8VVTiUm2/tXeuPORQgzHp?=
 =?us-ascii?Q?/+dEPQGYm4Mklu2H7a8iCCs8YO4u7sPGsxXHUNR7JGGph00FpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YwOGt8o0YrXvvmF5yH/3Gx2keZ85/e74+WV58gt3bFClESqBPuMQJt/+9XUp?=
 =?us-ascii?Q?3DQSJ1BKlYJvH6VEUTp836rBi8YPlFnbW/Ughsxw7X8pEjfRrIC7rWR0tMXd?=
 =?us-ascii?Q?Fx/geO6FjG5BbwdS2momV+xibzI/EH3Z32mQW+/cnuRp7gbwyjoyLn4V87br?=
 =?us-ascii?Q?r5vRJEOolaanbk0zPJwTG+8aEBhe2ubwBWv3521y02Vtq8WgWkYl0FbkkFN4?=
 =?us-ascii?Q?Fi1ixF6YxgPlrBbesnRMzfnZ8HiD8uRC17XiKshimeLbzECkvsWn5ugjuFvX?=
 =?us-ascii?Q?XJsg9Eukpw30Ps1NwehVE3CukAKyFE5ETzAgn3V1UxcyWZhQfTeOs5XU4/FD?=
 =?us-ascii?Q?pBOJTcIAJe0jykzdPfvUHxyLplL/cssSMAMGUi/PSaDOHi9DGEaWTJGs1WBu?=
 =?us-ascii?Q?ZI3ZDpEEpWqrlEo9khru9cm+TyS5F0WfAVuYiJIWIFGqBNYjBA3ns6LWI9P6?=
 =?us-ascii?Q?pvBHgVaXNlUJpEIkO68GAufBbq2/o5l/1eX6y7UkA5DqnCsVYFWliOI5gz6i?=
 =?us-ascii?Q?u2oONn53SBV/UXFJrL++l1n8kF+YA3dqu3yUzyOdAMK3q0RPjGo/7iXsdSz1?=
 =?us-ascii?Q?17ehZiSDDgQPgolHdI8NBUQQFm5YzEpfb04BeeWF89e6SSomQn4R19T28MJo?=
 =?us-ascii?Q?sMjt2X590wVw9I0M1AnjqZ0LkJSjKvHg8zP+BYdJsLtHYgF7eQZqfViBiYQ3?=
 =?us-ascii?Q?at1KIf3VUP5g1+LLrDHUOjmdk0Ks4flePlYlwXuR1wgV6lk1pme11BVkBlyG?=
 =?us-ascii?Q?+pBSLLUfSLmUwkVP+ch3+rj+OcgYc2PecPFEKj7CBjIHzmf89rGSSGs3BcLc?=
 =?us-ascii?Q?H/12pdsi4Qx0kQu0VNj7WSIBgYn411HvFFCx4zVRSTiL+4CylArBo8Fub68V?=
 =?us-ascii?Q?bHpmy2nb8uBgGTvhjikmQ7PCZ+AE4tI/NT9TpgN0dM4Mw1zZ7e/Ty7NQT/6M?=
 =?us-ascii?Q?Y30kJslwkbnKi9Zli3bt3wyyce85bgdlnAUMBLqWinYgShD+5B0JyBMB6xpN?=
 =?us-ascii?Q?s7INYGrcw44gTOldDGbuyEHBZx6BjShq3ikkOXECSXfDXK34YyNlwrvMmriJ?=
 =?us-ascii?Q?A6hrLO1zuxEmlaKG9k9StL5YmN0+5fO6tI3ssGmFfpKNNL2VR71Czg2rqBjs?=
 =?us-ascii?Q?vefxaA+3HLOiNp07wC4kEvYNuZT1tZBLkTl0JFTOjLYO/OUuYJCp7I1TmSgE?=
 =?us-ascii?Q?P60EfEqLhmRTholCtjhYjzjSDV0AAVvpcefWK9vJJb87iWf1skGdAbN4fvAG?=
 =?us-ascii?Q?8I6ZLKdLkgCd9fdpoEJCQ6zNpzqwEq7Fyn7vuQZqPaieApSHxE1J7Zp/XW15?=
 =?us-ascii?Q?3YcVLz50bovkm5Zk7Fd3d3sQgyluBH48FaZ9hakWn5zwqiagABymyBlTHtLp?=
 =?us-ascii?Q?hnp4Brwi23Zvr3GIVUZ3stt6ayNoZp4sr5pM6QtAhZeY3XNitP4crE3Fzhqj?=
 =?us-ascii?Q?dj4kWnxAizrsu7NPfBBLwLYMNrUsbTiLjbt2zyOpGqNi4rp12u5spJYGwKyU?=
 =?us-ascii?Q?9RiAREMICo4rEk6Ddh0DIbzoW1SEg4aPjG79JBSikV/r5Z/mdU0PspIhK86v?=
 =?us-ascii?Q?Ohom9r9jxk6vc9DEOxtcJRkz01F+JVn5PoR9QbUzHXWW1KfRxopGmnB8f4Qw?=
 =?us-ascii?Q?yKEUqJR6nekSmZJOlRKoSH4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 02115b49-6522-444b-3f87-08dcb170f3e3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:56:26.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZwVGTKNwqM4F5uxjD8ot+fFARu+d1/ca9YgReG8M4Nx5JQ//pRaep7mdCMlyWhshIFHiV3PPWgbLcnfJGkY0W6oZ0sIypH4bJsaXsmH1f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6333
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

CONFIG_LED_BLINK and CONFIG_LED_SW_BLINK can be defined independently.
Led blinking works if any (or both) of them is enabled. Unfortunately
the led command help does not display blinking option if only
CONFIG_LED_SW_BLINK is enabled. This is definitely wrong.

This patch fix an issue.

Changes v2:
 * patch description added

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/led.c b/cmd/led.c
index 2f786f34c67..91fb856ee59 100644
--- a/cmd/led.c
+++ b/cmd/led.c
@@ -118,7 +118,7 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	return 0;
 }
 
-#ifdef CONFIG_LED_BLINK
+#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)
 #define BLINK "|blink [blink-freq in ms]"
 #else
 #define BLINK ""
-- 
2.39.2

