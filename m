Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB41CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 12:46:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31087835B3;
	Thu, 23 Oct 2025 14:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JZTQUAZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F7E835B0; Thu, 23 Oct 2025 14:08:51 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622A38323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDQm+ZOSlx4jU4+3/Lw0MGjfFrYimifeQcl08HZR3VL7i1Ro9doHA+jhCUmoyj6Es5QQAAKRMMOjv/r3kycDAWho0/+2w2qesVQvnoreN+9KVuVfdCAyeI3chXVWxuU3dZCFNq7RuLZs1W9zdSuMUKYR/UuZc9nf0ojakICeDOljbnPCSglnf6qW2a2bjG/Cy7vugg+6kx5/RKkq/Po22295tQH0nWdQQ1T13bqFd5STQBIh30Xw/UUKgEgmgASUtvl27ILIk0SYMBTG9F7JBeJurZowwrjB1Z6a/GqGCy9Jg+r7DV9KGDTA8ypuf1K2+b5imrzHJxkDAGVFa0nFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG32xclejwA3cLAb9KC47HdLcrIdK67xR9SOIX6yoEY=;
 b=mpBX3HJHnSzhtcVdWaI/WdZnaelbZbzH/6CX+YzQAX8/X4B7Hm7Ue4bLpIm20I8L+P3xiHy/uAzIGlKsbTcS3iA6+JFfIwDCnmzL6GydJxAp+Skz8+jrth4bCLbLaMpyQbK1dhC40W5onOQv+ku//jG5lxlAMApgBx5mV76WE45vtWjomgzs57VKrS6eGzuvKI6s/pqZNPyp5tgOuzg35Rul9g1ogBFrHzHFCwxZaH26fSDdpgKSDh6Klw3DvzTBv+TFJm14iK5l4vUM84ESNU3x9BDKLYGnkAiAZYim1F41A13YlCqT6x1Qjx7kzC8nN3IDbaa2cPjzXQaWcNJyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG32xclejwA3cLAb9KC47HdLcrIdK67xR9SOIX6yoEY=;
 b=JZTQUAZveSmX54lxnpsLVyhS+AxIwcZy6p6bZi4keUsySNTwCRoObmUbi4XFxSYGgiBxu9CGIj6V2go2r2Et1N0XuZGiuEEzAzFJhdt+NFK3moHJ3bm5RCm6NHet74veCJo5o2d7cEv6xVRq4JOd6JM0uO+bQJU2yP69AsDuYhroj+F50St1Lb/6PXjylO2bvIit2c6KujdW3z8NvFYdWiNjtYUKA/f9RfYKc5x6MY1DOwRXRy7fGlZxbpPSLWNWUc96luhvWRJG1M2MYvZPaH9YL+4lRO8kUj3h9tI+Wqnf5ARiWPw8HREPsq5er39z3+lSmyKJO2YBHMFbxMX3Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 12:08:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 12:08:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jh80.chung@samsung.com,
	kauschluss@disroot.org
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: exynos_dw_mmc: guard execute_tuning
Date: Thu, 23 Oct 2025 21:20:53 +0800
Message-Id: <20251023132053.25862-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddf30fd-29b1-4765-3c0b-08de122cea57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rKFmDeFP2Q7mhR+uscx15XNV4RJmrOsRaCAsXljPNVEcU9CDD11DltjyDyy4?=
 =?us-ascii?Q?tr2laq2U6+8UVCebl29gIW+dasBwHmUiUlQ97q7Cyphf7MaN9Hr2oYmbf3pJ?=
 =?us-ascii?Q?Naww7bdR5WbvZEGfc8xuUGaGVZJsnBmRtJCKCalgVALKYf5An9sO4PqgmbLJ?=
 =?us-ascii?Q?7Zl155pEON+kZ83uqSSYmUrcaA6Kn6aMRNJHNyokxMdm3iHeXSx02sPScVIs?=
 =?us-ascii?Q?/qNXlcnhOBngzZ5q1+SfCc5TI8XqttZEGJKHAyPJLr8KRAeVoLhgW3DGU7Gj?=
 =?us-ascii?Q?rKRwIC+FRXH1XlRwj0PpbKm0qhgsY2yZUR90w3dk3szQwNuAeOSRaf4rqzGD?=
 =?us-ascii?Q?IqoAYpH3QCawjMkgvFE92baBfifseKUNM224eNd+6gRr3Lj5pY9UdZXkQO4X?=
 =?us-ascii?Q?KlQyLchWRbfZQ4Aoi26ii7QJCVg/gop9gDQxaucHsBbggfKCqaOkYiZbRMTe?=
 =?us-ascii?Q?k3YoU8eZLvQEH3uJ+dnhdQX4ncC86BHaQrse92y432qos7b+pqvX+CWoY719?=
 =?us-ascii?Q?3k9b3p9/CGDc1k/I2osPSkraLgf9b6k34OnQn4Ba3VDhEXAMpsQZVk7CWDoy?=
 =?us-ascii?Q?OT/Xg/OXEWSOjGHKjb8CtjJ+pu3drNfN+T91+Il23jLO+V4HMQJSKpNA1fb/?=
 =?us-ascii?Q?xKGxR8NaPj1ddzHgw4WpWAe5GaL/BPZNYme4CSu28Qm76VXTJYiN/VIU9A0l?=
 =?us-ascii?Q?B2l4ARcQ1Pu/rjP3mBZlD1dVCg8wtvZUsxN3x92f+fdZlwJUr0oazJ86LtM5?=
 =?us-ascii?Q?CGQVReueT07+CVhhy3VnbbU3P/RrkJ+MtDhUCwR/5cYgjSzzGfC2jta/Rnpd?=
 =?us-ascii?Q?R/aEJnoUha4xPoDdxFGopPRECmB1V2aCp0p27h9w6cXjFze4Lv216SJ4EIgy?=
 =?us-ascii?Q?1Wt/+hEyG8UdwdJI2ssLdKNwn3B597g4ucwsaTj3fYh4n4JfZfzN8wot142F?=
 =?us-ascii?Q?oNvpC61qUEtRq6IjcHrr7E3kZ0jLSTeVsjiOi0SK+qJzqNIvepsuQJHZ/k+W?=
 =?us-ascii?Q?FUQenLFmqtJHNLXWNaRhN0n8Nitm0hJAfYAHi+r0aTBxIJee9Hks5BXiZGF5?=
 =?us-ascii?Q?ru5O0p6mePrZlgEQCrgBh0PhqUBcaXZlaELB1xlREJqiwgmWJkxFxWwb0Ymu?=
 =?us-ascii?Q?YwWUOkZPshWHBIFmTgYyZjtjDqBnuWBEgoYLpVktVSh9HNPjvK9DvNNxM7f/?=
 =?us-ascii?Q?iMaMSolhu45IuJGwWVZZ3jvTKFQKTHM7VbArOksjjWZ5DIGgJ2frX9nU9omQ?=
 =?us-ascii?Q?7kzM2Mqv9/1I7A+D7j74k1fS11sa28HUrccBYyf3NL5yy+8bEyOHrY0W5awH?=
 =?us-ascii?Q?tBPNwOZ97wneH+pHKZ8N8QW7aVcRmr2jUn/g6NmxXwuFO0FyNqQqSfMsJw7p?=
 =?us-ascii?Q?jD33gxCBi9VBQwEC6h9f1v8ETWYf/hCxL0RnlkyCVVF7j6gCvwvBbP8fyfa1?=
 =?us-ascii?Q?j50WWKHHbpZjyajxp++FmAJrHHKgZMZzs+uEz4od1hfCWEiM9WoVmxyZBih+?=
 =?us-ascii?Q?plPjL226ATJglyUI2vF6FI2H2jmXWA3fgVQ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lg0Z9hlkH4i4FWJ6mpu7xXzWQO3tgqxTwnaGGWLG6ISm0xYGoAPyE9GwGrVU?=
 =?us-ascii?Q?svHj6pXimtiygrtaDx124TeQM42/QTRnCRSfAfWxULeFUyzZ7Xdr/f37fOgd?=
 =?us-ascii?Q?Hgsr5NsxRJXWE8C5/33k0WDtucOoYP75As+EXN/3uqY96NbaHfZWC3K9C8hz?=
 =?us-ascii?Q?f8WrTgbexFYOiBQimY2K4isRNSJI1UeDjFMSSohepuXZxDQIuUK24BiCkiT9?=
 =?us-ascii?Q?JEqhEp3rSWMLMT7prnPKqSn/th8dzlGbXs28V2J2XpxqokgD2zOzkOizvNno?=
 =?us-ascii?Q?rR9K82ESUVNSAC3OI3pZa88OYSKpXoNNOoplGC5H0c3AuFw6HE7hlAnzcaKJ?=
 =?us-ascii?Q?vUIS6iAce7STPEE5AF90EqQ4mE2Bh4Y/oNH6zz+LT7qIurqLPxmzg+sZOgZc?=
 =?us-ascii?Q?iXNAX+4aTwFlEnH0HNdCpSJj5SEZmN1nFbneKWOC2DLazTea7X3WQPyvOrCH?=
 =?us-ascii?Q?Nluf2kPuPK60LqWWfqmovP+NGG2mvkfBAcuQapyfwnuaqJKoBg75mgdnDHcc?=
 =?us-ascii?Q?inU3Vwrol4c6A9mtrmWMR1CcUHNMv7e0jwmb8HM44WfF4DLgwt1BtcV7wyP7?=
 =?us-ascii?Q?WnniINPqxypv1Oho5DvwThqii5hWu8XBeLO+J9D5ik30IsY+uH3IYbvyIkzU?=
 =?us-ascii?Q?Ep4FRwzVzLj4JJeLa0K1bSiVUFOZ/9bB039Ox9KnyXL0qgzB/Be/lNqdrDiI?=
 =?us-ascii?Q?GaMRy73VPc6coqc2dzw5q6SbUPQLG1fqgGgDYVp280C0cE63aMVk/XrcxZ5j?=
 =?us-ascii?Q?Wu8zQ1T4KSWhq8pH2Bydc3nvJD8hCoofpW7/fBZcHqfaHXezILnipoOybIBo?=
 =?us-ascii?Q?v4QGm811OW44qUN3hg133mQ56zabOGdl5nFFAugLI/6PaDjUS0YEnW/7QMZq?=
 =?us-ascii?Q?kwJlFQRGa7KGJWANGEKhH8ZQb/O3qs9WrkYH48GoeQll+lwsdaQoDi3a8Wsa?=
 =?us-ascii?Q?r1NJzUMRtFFUC9UnknqGgWv6sRcNOelab/FeUEWVBLc0sE+/y/6DA3AWBBKK?=
 =?us-ascii?Q?8hIAcycG6JkmBfOT2MxrF3DF+F0TLVpmwWyzLvW9oZmIJ+z4h6Iw27APmTCj?=
 =?us-ascii?Q?tDcQCBoLyLMENOl+hIrG1lVPVXCrbVUlN5+ZpQ9sJHTHH8btH8wHH4n0gauw?=
 =?us-ascii?Q?M+Y78MUcXXEfKT4MB9Ev6tFERKEk+51/kr1///CqX66Bpz1n31YO15BwzxCT?=
 =?us-ascii?Q?MF7WQafL0zFHhAvPpnizEny7BY+PGmye8zY5eMsK2S11CtvLHwnrrBeHx6FF?=
 =?us-ascii?Q?MLPxSWs2erLxwfg5YpNHMhSJjowZoL8SrTXuCSVjUtsObVS+J7Hy0pJDObTa?=
 =?us-ascii?Q?P/Dd7GhB08nCkhnQ+NWn/+rqNHESlNAC0S+UDiUreUvyrVL4GCWJBsUBUyvM?=
 =?us-ascii?Q?WbIC/2SbBrEjWwZUu93SeVLub1ZuhRm7VxkbL5EScDZ04WTHs50xJfTho/8k?=
 =?us-ascii?Q?0imfpg5XP6b+sUv2uYPb+73xNpTRYt+HyjnBnGW7BEXefszOsZLQaWUy4g35?=
 =?us-ascii?Q?YLz16ms3lZ8jeFU5DMtY45x8IxtKcBthnjVf5cN4haXAVpQsrwBtrkRQRmli?=
 =?us-ascii?Q?0jUgJPq1TTvr16Xozj3XEghm9MSmdAJsShTHdS+N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddf30fd-29b1-4765-3c0b-08de122cea57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 12:08:45.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPyYaY4t80IklShFR4hKEMnzQwNaEPd7N0ioNgW0K/KEMobSzlBI3xo34rF7io1f+uRJwWH/MjjtmVWG1BN0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485
X-Mailman-Approved-At: Thu, 23 Oct 2025 14:45:50 +0200
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

Guard execute_tuning with MMC_SUPPORTS_TUNING, otherwise there will be
build failure:
drivers/mmc/exynos_dw_mmc.c:484:10: error: 'struct dm_mmc_ops' has no member
named 'execute_tuning'
         .execute_tuning = exynos_dwmmc_execute_tuning,
          ^~~~~~~~~~~~~~

Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/exynos_dw_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b6660fb2cd5..0b7af2e784d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -481,7 +481,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 struct dm_mmc_ops exynos_dwmmc_ops = {
 	.send_cmd	= dwmci_send_cmd,
 	.set_ios	= dwmci_set_ios,
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.execute_tuning	= exynos_dwmmc_execute_tuning,
+#endif
 };
 
 U_BOOT_DRIVER(exynos_dwmmc_drv) = {
-- 
2.35.3

