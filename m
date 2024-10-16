Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA7FD2A526
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C2D88C05;
	Wed, 16 Oct 2024 17:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RNTcQ5v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198C388CC5; Wed, 16 Oct 2024 17:10:38 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07FF88BC2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iawevd/cbzUV7aoSUZzjHba3qm9iupOAp7xEOOdSmYuyTq3naNcKe3AEuwUra7R6UO9yN5dTtcHzL8g3YkBSLfL0x1csQVjO8YkMG7cDvamBwQCNxZknnjDABx2iMvmfYCCrSIkepeBy8NzO7K9KnlPSbIavYOMjIphnqx4GBxleijoyZzGkXEzWv2duZqSHDuZ8zIQ87dNEdTEH/vRAibEgS9ha2UIDhKJukiedkV9R1nrH/qpaj2QNq/z6PrdG/eHCa5NftpwWSqGV55b5Iac7j4xeyARQrDuNc4N2PdYXzsrnJ3NFbU68tBlUubQFsxhok6lS6PEk1j2mNDbVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQd4isQv47yuK0XG3U1JDFsWyzFKYpbWnXPIrGs2Q4Y=;
 b=DWfbDmYUPfX6DGr/43ajIowtrFVdlYUJC8zUjGVMVYFDm1fA5/lK4hWrjV3NfAUOelrm6j3iBUszVE1OYCpgRGSf2W75Jo7iJmNRvRw8Rh/YeBLFmt0ta5QUlAnySJUftKkxAMuGRmePG4MUcP07P3TXgUdwlURjxx7pIaPJ/NMbpsPJx7hmOmuf/tSur5FSoxnWRxDkI8DzhJORIxVZu1q6fr8XNDDepAqtDoSKm+DrdRzZGmSxTPdgn1Gi3W6BK6LjKscVquADp+IamQB69Kne+k2z2qzKRR1Z7X4QhwuMhukvHY1UFEmTiV5cu7y6JwRTi4fcCkNr6FifedG85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQd4isQv47yuK0XG3U1JDFsWyzFKYpbWnXPIrGs2Q4Y=;
 b=RNTcQ5v2nUwbzKoyC2bVR3SHL9+90vQthSJcaVNdcUZngUjf4nPHz2Qd5gn+/275wBR/nLiR6mZHrxV2k3AxprB0z7QWo432aQkBO9wToSxBCpY55bl3hS4cdiwpdJ4i1Cqm1ufHrKa9rmzb1fpRXUhG6iHat13BWsYuggM2K3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB5927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:529::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 15:10:33 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 15:10:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: emkan@prevas.dk, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] envtools: make them build again
Date: Wed, 16 Oct 2024 17:10:35 +0200
Message-ID: <20241016151035.709351-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0aad08-613f-4909-bdc0-08dcedf4ae96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4vKxuVo8BX01mMidvB7uscY39cm9kr5dc3s+I49CBX/R1MOMziNVdpfNwL4u?=
 =?us-ascii?Q?p5UZSbF9xvE2w2rzMKeXoGPrCNCXMum0zrP5saqe6WVYRCfrVKths+rZIuXb?=
 =?us-ascii?Q?uO7pf2UlKUop4FMcN0xRwkY9Pj+7opouAKHCl/OzeotFuy1mj/tG1MP2XFGe?=
 =?us-ascii?Q?ZM6qVjLhXjMQS0FwGWTkckbbSN5HkRXmdXn65A1HWCyCOGAy9PrB9wQCW21h?=
 =?us-ascii?Q?0UV6pqpJlNAUaQyrKdPNbJK8HrkSjLEt/LTxhm9spMl9qgAH8GwjE2RpO65T?=
 =?us-ascii?Q?4JjLJ6HX2NMSPLlXMPb2hj1LbtZjwCjozsPZrZBbt739BN7nfxiQHx0ylHRw?=
 =?us-ascii?Q?cBQMamqqa3e/pCB1Q/V1NnR3xRHdW8SCP8+AfYzP5/efrohn2iJtoXlRrKJ/?=
 =?us-ascii?Q?1zuLz7q1jmos9sKsv7GvnrQbL+emiGKMw8eYEQAKFC5nNS3B4eaV/cnbcPOd?=
 =?us-ascii?Q?6zwCzw419o1euIo/LOVCDFvFnL7pmUf+0OtQlgumThfOsTQOkeknDolrnirr?=
 =?us-ascii?Q?XIVW+/2ySIc3j0vYaUTO7NZxuUfCuzIf1fPQciihp0FNPTx3lebRrNCzCAFo?=
 =?us-ascii?Q?D+ec/H38VOGqarpcfCqlfDMgar4CKlWIwx2+Ftol+kViMZwoZS57reQwYNod?=
 =?us-ascii?Q?y1SYA8g6KrdvASVmh6Yo6csmeSB4KPKMJyIQuQwPENfl4ZFz4rrvBvbdq4wR?=
 =?us-ascii?Q?wWGTOfOtf0wj9FpGM9KpsaTeMlR++0wMiTFLJ6WsouaZZaEXNF4gK4b4Jkz7?=
 =?us-ascii?Q?6jBdDY5qH95EIbYucahXbfGoe/MNaHOPfgTm6QJtF5jXavB0fJGHsQz2smfl?=
 =?us-ascii?Q?dRaE2qGDV75QzFwVzSaX6+EFMolL9IWLkLZuZQeOKBrlZJgkzPdCnSzDI4R1?=
 =?us-ascii?Q?5ehJfBQPsyegsncufCfifIGHUU9W3eMOfBLT/tOWT/FxqiaCLx61bNyhc0v3?=
 =?us-ascii?Q?EQ3TrlH2J9Ts0wgfnB74Qn97DCkrSW0WVk70djIDNwraTC4SxEavVWzh29LF?=
 =?us-ascii?Q?cR4gMNC4Ha8/eTP3/cxrILgW0sxbujYZaHZuAeXyATjZUNfIIHgh2RSwC3mU?=
 =?us-ascii?Q?tiGmaBGmeLEFbujBKDwAbvN86Lq1R1340+H9RxFZpjRj655M4qfK1BxTz9UP?=
 =?us-ascii?Q?5NdJnyiEOS3AHhcEjVPzfdxXIqsxi/n48wzj689gWVARfkoUu01P8/Fo7lEd?=
 =?us-ascii?Q?nB5ioXdQQrs9PYdvenuQCzIylp9q3iT4RTNklefgdleeS78rZCax+gG6deG0?=
 =?us-ascii?Q?G2/d4V3hl5smpfdopxp6MrWJKlYHRyreTtsjVhiX5a9qCQs/99GO/6jD/fKx?=
 =?us-ascii?Q?BvGZ1UwGokdiTLa9KaGJhxkYljpmzdmSTMxqOEM9Bh2y0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9lzHKPb8Gm6oIs44X+0ExpJiGN7f9VqgG8mfGczT1/X3k/5vcvmgK8qPQtj?=
 =?us-ascii?Q?0uN3HRI1MHSHDPbVouds3mFuCazdZUEHSYObDH6JAqoFruA9wqvJmrkvVh5Z?=
 =?us-ascii?Q?tgyyEsYam8YhwezlTS98e2GLCcfqWuc9RTJ/PN2gH+NKo/Dmvil35Salyz4o?=
 =?us-ascii?Q?fF2/0qiDFgxr+JOVAs1IcqPmgc4zwqBzi9vub3QvbwQtxsgXSdctPcWQE1J6?=
 =?us-ascii?Q?RCMgImD+rSq3KMlesFaEKjd6a8vf5pWwlEik0grEYjU6WDgGh/EmB9cAFZhU?=
 =?us-ascii?Q?08QOfzsIFomwiamH6jGYIdW0Rv6659Z1OKxh0x5Ud2ws2SnpELZtABLle1uW?=
 =?us-ascii?Q?DO2eDc4f5T977bnxorTm4ydiETjJW2LuqJU5L2TyI4Boet6zgTWtIumrEbvs?=
 =?us-ascii?Q?f82McQ57cAhswVQrdsj8xyCmESX5RvidXrkBOCrOogobUar5Tj7eoB4JV6jp?=
 =?us-ascii?Q?zNh2ZOCcQBNScQ0tlPxkqBFSBOaVF+v+4CE+DT/Z8yCbC8ove18QOShabyWr?=
 =?us-ascii?Q?3ta2YxOksnlHh+TvJ1vMkiDZIfuI08bt0xhqRlDUeMbehnDnuYwOh5bEgm2/?=
 =?us-ascii?Q?ABA7jUOkaPGIvE0GWzz9pTtclayHcLgPiRzScgRLdTVqPJGaqFZUsKFd8RKf?=
 =?us-ascii?Q?mA91o5pZLYqdJzPxO4J+UujneEsZsesbvJYP2erJF06wtSUuhaleslWrJFs5?=
 =?us-ascii?Q?+O5rPShjJN9Ue+dNZvInt4UhguviMjED1jihfFVP5GYHcSqn758JmJQH035x?=
 =?us-ascii?Q?iW14S3/RwYmltFxp+9aOdjBCJb3ZHCi+QEoC/CixZbIGeLh9Tk9/HegofWZ1?=
 =?us-ascii?Q?BqdAN2oNAvEeLRqTaSj6qLpbAUt5KlAwJCNNToBa13wkiJztqhbuXid90zok?=
 =?us-ascii?Q?/DHcQsFEKuREIZJGy1ayIb2asJRmSjcgeClBA0FJybCsYOk/WHsMO5uP6lZA?=
 =?us-ascii?Q?EogzAMBVQNaN98G3lkh0JMM1ZxWrm23gnbMxxkagGvaYLW51aDFlUsaQXT3z?=
 =?us-ascii?Q?A0DEio4u/dNEjDwy9jAcsmlRSqk5/aRI/NimR9E5SiWFp9OMeL4ctbZVaREp?=
 =?us-ascii?Q?O9sD47HFhou7QU+M8Y75MtPtuLa6CjI5gRVjSpgdwcmBYAYpIsx1khPZhTX1?=
 =?us-ascii?Q?ekoewDrvqKWaGzLzlAeK6CQhlg0SJ4Wrxcdx02Io/3ZyDIPJahmGWuTF9RBe?=
 =?us-ascii?Q?JRFOx9+IbfnYyzOXc24dOuHprxoUb/1ZBXhg85fzLWdBE72dJFjYGnIfR/Qi?=
 =?us-ascii?Q?wgBm14znY+iUIpP3zfChC1XK1OV266djFvIuo9lwZz2Frtl156URuNpV+ink?=
 =?us-ascii?Q?tLggszdjcE1rsqlM4wc4FuI8og4Li+sEFRB9w5kSf5COin7gR/hi36PBSIX/?=
 =?us-ascii?Q?lkq4Qbe+aM1bJ6LKSzoaZjpwP6L3t3oZYYofUKrbPZxWK67Ffb4iUhjRz7N2?=
 =?us-ascii?Q?F6K6qSPIMNarhBDG40xOlcAGEXdEQtGxz7MoXPjV98876whMG1jIJ1FLHlOd?=
 =?us-ascii?Q?W+DCzLywx5gqk5+DHtkHT0Nlr7mfc7M191N6di0OmJc1RqcoWARc6HB88F9T?=
 =?us-ascii?Q?AebUwyDfJMFJwcVxvGsfnsZL56xrWSNTmTnqv2hGY0gb4GVCL5yF+cKbdrFK?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0aad08-613f-4909-bdc0-08dcedf4ae96
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:10:33.7701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndSlk5+xeMIJGv7QhYBLoud3f6EP/EYoahY8kPXSSZ5FhiEMq7NcXW/TAadhsV2RSa/Lkw/aB+SMHIrhHL9xVVTAgUQ2yc+OyveUPF8ZhWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5927
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

In v2024.10, "make envtools" is broken for at least these defconfigs:

   am335x_evm_defconfig
   rpi_3_defconfig
   rpi_4_defconfig
   mx7dsabresd_defconfig
   wandboard_defconfig
   imx8mp_evk_defconfig

The only defconfig we use for which it is not broken is
stm32mp13_defconfig. They all work just fine in v2024.07.

The symptoms are slightly different, but all related to the fact that
some transitively included header uses IS_ENABLED or CONFIG_IS_ENABLED
without linux/kconfig.h having already been included.

A simple git bisect doesn't produce anything sensible, it ends up at
3a9f642ca94 (crypto: nuvoton: npcm_sha: Support SHA 384/512) which
clearly has nothing to do with this. But digging deeper, one
eventually finds 0f92fa45603 ("env: Remove <common.h> and add needed
includes").

So at first I tried adding "#include <linux/kconfig.h>" in
include/env_default.h and include/env_flags.h. That fixes it for some,
but not all, of the above. For example rpi_3_defconfig still fails,
then in log.h complaining about BIT() and u8 not being defined. At
least BIT() is should have gotten from bitops.h, except that that's
behind ifdef __KERNEL__, so not set for the envtools build.

It turns out that the envtools source code in fw_env_private.h already
has some hackery to deal with all this, in the form of the __ASSEMBLY__
games it plays before including config.h. It seems that if we just
make sure to do that include early enough, so that config.h is indeed
parsed with that __ASSEMBLY__ hackery in place, everything builds
fine.

Fixes: 0f92fa45603 ("env: Remove <common.h> and add needed includes")
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
Resending because I failed to send to the list the first time
around. Sorry for the noise.

 tools/env/fw_env.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 74451ecb945..425faf380fb 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -9,6 +9,8 @@
 
 #define _GNU_SOURCE
 
+#include "fw_env_private.h"
+
 #include <compiler.h>
 #include <env.h>
 #include <errno.h>
@@ -39,7 +41,6 @@
 
 #include <mtd/ubi-user.h>
 
-#include "fw_env_private.h"
 #include "fw_env.h"
 
 struct env_opts default_opts = {
-- 
2.47.0

