Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FBBCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C3B84807;
	Mon, 11 May 2026 09:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SBXbsO64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 689F284815; Mon, 11 May 2026 09:45:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F14A84715
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKlm5MXPSbk2n7Tq/cHPhYHXNeY0unCgBnWne6nmK3Sa0C353hppu3jLlqzyMmKdIEjVntaF9iY1kYwDhxoHYcSQfdUzMemjiRZvNo/nLzPegXCSUPn+FcSmZ62Qc+6aBhTMc1k0sPABzRrtYBsQja2RNipmJuIA/o0RyMs5TxyM2qKWDGz4za86cAs9VY+Q7HY4TaBhUnyGTNNwlLaVlstQ2KGpSTs3YtU126UkGJh+ldgfO+BpCaAYevlrTh7tT838Mr/2AVvx8SfoQrjQaeDWTjqNkOrz6JUI0cg8TB7tjjCZrUynwe8W+ZuHVI6azzLjKzEInSnzYN2GRzjIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtU6VsPSgZP2kprSr7TwuDbCBYrNncDn1k/2Hoy0JSE=;
 b=l8+aSxe86gz0CKCYXvd2IJRO8a8Pu9p/It+z1yh7T5H6ucK180w7cueifXeVhNlHUIrOlopCpiWlhvfURQlHOgWBJBcMaQDFhb4Kr/SLMzD9h4XvZWzUbUx/hXz0v4+7fnfcwIHZBJNpCO+Wlbh3Q9xvC8TPw/j7ZvFqPxvNKlfr6Cuv983Gc3DKLqnXPa7iztmqPuOm4cVgNG3cJFHISAMfp3zTLm/r2eLKNU+hXypBUHBwJZ7NgwljNJQIDVXCWdXgq8G7aMd0cfiHZoKlcC2ptUoystDTeKpdR8SzQkaX20pj0N6u10MvqDR/2zEDKR+xOcwQNRrosmEI48psrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtU6VsPSgZP2kprSr7TwuDbCBYrNncDn1k/2Hoy0JSE=;
 b=SBXbsO6411YCx0fdYC7nhNVOQFWEgYK46Z/CFZlZYBkz5/kAIDj73CqB9vrs+Y6hubWU/wSkABQwX27KB6PWQnx/p+npKR/KsIPU57XyEKmqjFAvInafXZJsPhbXmEaT6/i9nnwGf2cDKgkXOMfIfNqKHYTJwhVijpcykR3xvvzRxOv7H8nJSObFY1dACkyuOrqzD6he81MBg9h9w6tImh/ou+w34sAcDi21TP/hAzkK06eO1kRHW6b6Sc2iEedsA5v4krRL3SIZXvB24HXWEtIdbslAiFYgdceAQHLkzGaVR1t8RjUXFuFvrACHSOEr+RK4yngBHQwm4z1z0fca5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PAXPR04MB8606.eurprd04.prod.outlook.com
 (2603:10a6:102:219::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:45:01 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 07:45:01 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] imx: priblob: Fix build break
Date: Mon, 11 May 2026 15:47:12 +0800
Message-Id: <20260511074712.3772830-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 80832c7c-fc1e-4bcf-63c5-08deaf3134c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|42112799006|376014|52116014|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: BilNiwCdrkDo76uO9+S0BY2d3M/V6pP/Qef27ZTk8O+6wJAVaY5fAO+jQXgT7PA2EHvpsC6X9Ya3AbsuY1PocB5LcpfmuSRcJMlLIadm7/AuBClUNApr3vTAVypRGUKvn5vP53QwIEUgH4tBYxR2THCR7/PLump2FFZHjPVvGElPD3/Kt+XcPDMmxIpaHyWTyZFQxV8AOvpK3YFvTg0Mu9e2BRgOAx2n9B9XXPjdajpJpdYM51o1wkm9H/72RB85fi85p1wloEiieTqcyJC2V+MJ2VKeoMB90SmKzFscdZftVhDnM5kNMU1auu5EKpHOGweq1hsrrvXrlBTTx9FL5SYKEAH4+7+vGcbHjGc4cPkPeS7F+WzqCKoUqRmnVPjePNFRttpfb8pa5oJywwyFDN0xfALao4sIZ/bl/zqsiAWc1CP5DsEamiAmOGb2VHZMJNaEYrEwQ+e+DqxL+mws2Fv6tlsYJNNWCdEVLgOm7BFmlDSuwuJ4yTPu6A4dBqAYSCNGyQU50Ddzui/ulQqv37yClV0OZnz6CgOuj1YpbkuMmVICkyBbyRmnH/7ipF3y294mTANTBSllsdSGnAf24DFWM3463dloVv7jCPPU61ImsquTkCQvQL7Nc+aM+pmK850taTiIWoIe4rWpSIOg8obLWTw+hhCi7e7oHcki/zh5C3LfCS0hNvseXJ+zL22I1iWAhfRgJLj9LENU/RtuAzTpE5Q3uvglhCzlYGen+FIajiz4jYE4Qi/xrfyNV12Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(42112799006)(376014)(52116014)(1800799024)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3R1YmfekYmoPaLph4uRw5VQxhdJSUekBTdDxbCVkzU0QdFW/vnu87bTB9O0p?=
 =?us-ascii?Q?sQtYUN23djfFUjD0XQCP+0e7bDU50Lx5oBMZFU97HlgFlsw1p2v0hpWCJD0h?=
 =?us-ascii?Q?sdFm/XTE9E/MqhnvDmIRH//jRcGEpgjrU4d6subVAEbyWn1utlUv8oKeq/rE?=
 =?us-ascii?Q?h3JpYJ4V06MJ6nhfUTl/rqhoQxVKJlPRJIz0zDqAb+lVL2qcdS2xTRa/eXD0?=
 =?us-ascii?Q?VhwENf/mLd0iX/jm1TBf3yo2uj4Vf4jHgBDZwWPQvoc8OvITYvhTwTp69DI6?=
 =?us-ascii?Q?/QgHhoV3DzAr0kJxnLT6jgV1jo6cHfqxkFSQNIJ7JX3w2YDZ/psZeZOHIUWf?=
 =?us-ascii?Q?WyEPhCWky760T+IgywWUxE7Vg43709YC/KA8l4wqIwjnz6IPYZJ/1noLUNHI?=
 =?us-ascii?Q?+tj1GxzV6zuKh6yR+yC7tJLzwp8DRKLguWmCvDo9E73loHL42mpfznxojGDw?=
 =?us-ascii?Q?rag+W2dmNCF4EG6rePg6PBrnuA2iG4nUTJ30WJDtsf94ZNu/0MZkieK5FFvk?=
 =?us-ascii?Q?gp4/4zNHVIcesb1hwAHtDBEDxJ4mmXrDKJ9ADmDAtVTtR7MLSK3D620XiQ/N?=
 =?us-ascii?Q?g6p3SmYKDjOs0EaEZ4+Xk8JHky0zCGFfvV5nSaPRfg92W2v6m4NHarF37Rd0?=
 =?us-ascii?Q?IJilgqhIVBfSTc1UusJNY1ojaceQqOTJsJ/jPQzT8NJdPTb/H2SOvmGTYrbu?=
 =?us-ascii?Q?Pya40wPRjSfjOqUirJ0MmTV0CDAkTcryExXcF02SdRRertT2GTsHPUHX3RWw?=
 =?us-ascii?Q?pbta2SvK7FrMawvDhE3TIn824/JcgBYwoCyzoAIP06Kv5IXYRn6iBu6KnT2+?=
 =?us-ascii?Q?TY4R50p29uoagUwHVujnfEx/3FUxHqG9MciTIg3gquGk9bPKZAt8zShJyeZb?=
 =?us-ascii?Q?IZIK6BoQCk8UEhXcN2fQsDdz3U9BS2T+V1rsFa8eGM29aSf2aCnUq5n9Gcyf?=
 =?us-ascii?Q?xERA8VcVCx1XFjUEAAIh0kPCZWLd3wlg6Q31UYvWRc0edw4U2T9ZB/o1seYK?=
 =?us-ascii?Q?aMRiS/HgDvhpmJv6RpIEYeW228CPkybkqivrh9xmvLpYmWk/4H6zBa3NTpIU?=
 =?us-ascii?Q?E3CQXXW4+LFqVujcKXfuN+DjtV/v7KJavNchAWdhTuI1sDkCyCD0mnfjTw/h?=
 =?us-ascii?Q?yixJTOtJ+htXLTiV94EgAtX1C2cFhRslQ4Aofn6YO7BHwkROpcL53jA2pCZF?=
 =?us-ascii?Q?D55xYjJqafVN7gJgfQZRQ9OTGNJC+NDioEAtJfjTav/3t1VVRsa0VmHLUNeT?=
 =?us-ascii?Q?X59pwUf3ZFwJvGAu+ImqVXPDfcHVke9U621K568lW7uOZQRq24lviFT2TV89?=
 =?us-ascii?Q?EvVmnLLzo9istwlxb9tekXthZcm/c2srbPIhEwTlUgkm+uRzgXf1/zCReX5u?=
 =?us-ascii?Q?/3czhEN0sGhRcQm1lo7mhzOtxp5vtXmpiJ1E/E4tfrvTq7RLZKAbhOPYhBbT?=
 =?us-ascii?Q?MOdIhXDClt7PPB3EkiP9NkooivRizoUU9hREVdF2TypCcEBzwshnzeCDzDh5?=
 =?us-ascii?Q?dUxyhlXMGigMoXplzSBpfxeQVRWC6MVLZacB6wbsZjj5rsxM4TNZWniG9QVx?=
 =?us-ascii?Q?cs/lA8K1kbTULnVoGzYKYE5x6dOV7yWAfn2TR/kqLsQZlSznO1iCQr19gzNB?=
 =?us-ascii?Q?0BFVMGoAMYRQCgrnvvOE6qcJVJ6jK41ma1WWVPrmCLqSD99Di5G22KrdHLU8?=
 =?us-ascii?Q?ZnnmWbBh3u8uvIoqUua7ViH+44yzeIP9wGkKfE+NNMW9JVX/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80832c7c-fc1e-4bcf-63c5-08deaf3134c1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:45:00.9441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTHE5MLOSDxVIE1wDD7EGrLkXaLeSogDZBNGTzVnscd2HupBKMmLJGint9wfOCAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606
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

Add config.h to fix CAAM_BASE_ADDR undeclared build error when
CONFIG_CMD_PRIBLOB enabled.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/priblob.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/priblob.c b/arch/arm/mach-imx/priblob.c
index 65924483bc8..c22435c1676 100644
--- a/arch/arm/mach-imx/priblob.c
+++ b/arch/arm/mach-imx/priblob.c
@@ -10,6 +10,7 @@
  * to decrypt an encrypted boot image.
  */
 
+#include <config.h>
 #include <asm/io.h>
 #include <command.h>
 #include <fsl_sec.h>
-- 
2.37.1

