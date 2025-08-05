Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5BC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F913841AB;
	Tue,  5 Aug 2025 10:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="K2Z+YcTN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57D38414B; Tue,  5 Aug 2025 10:15:52 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 107CF841A2
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqivP37k/OFpIJdHIjV34f3qGuE0SYFCRQQXyhpzrJ9TzG0FoI9rpzYm33I6l8Im0I+wfp9Y60lwExxazwSYjxy8ybcsEIILEhJ4Bj7anzq9/MSebXmpNzfgggQ/5wUFIntBLqnPqDoWztqwwk8p8qpdLgRMQmtKEwAl7DgYVxm94yV6ApVKtJ3eV6XoA7KgFKamyfkaC2fKjnFgjhwUooOZbWT3FXoFJ+1Qu2mJOQU6WNKZ0lsCkm3HCorcf3rGzFYGJNXsB/8cA4j0wOw5RgM8XB+lAkLGwPZsJs9FsHP+X97rqoaNx+ov/GKIr3CcvKQl8OWcKf3slYnyKAAZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db9gIPzaWlYuzyjKQ6L80Y1mtK97bDSrP6no/huEbNA=;
 b=tPqIMNsksogMpEF+/ujRxYOjng7Y9cJ9uGOiQYzzpViRjDCSIXdHxcTc8STrjbI/XVtw9CzS0ChKRStVDXAfLW9vUGER27dkxhSCpiRT9/REFNNnb2A9btjATUyBbJHNEwygYGTPLHyD/6qE/YPjFyA7fsc2KVJboMVHFSg3vrmPeaXnruGw3zYCJ3u4AopryligWMHNmb6L1dqTj/9D2hcICj/jXVYDyRqBHteNoqtbH0kd3vA3fH9HGkKPVX/XPqoEFLKEp0iOIjtleLDq5pTVxyUWHyZfhfy60AiUg0QDfK77dH3dHDt0XPjQue8yAr0jUDK+eZPjGz1osNQm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db9gIPzaWlYuzyjKQ6L80Y1mtK97bDSrP6no/huEbNA=;
 b=K2Z+YcTNZ6uSoRixsyvF3tkjRGyE458J0dWnuVCITJIfkv/bv/M/KdrP2iUp0+JNzV0rdIPm0LrwaIkMLPSPQ5IMl8VL665qsZXNN9ftU/BQXDfyknLfzrnsXaOK1T9z/mBt8XzVyv67/CaFQaiNXm24mQltlh3E4Jp/vT97Jv7p3CeAaWMb885zEbR6Eug/aHmrDGvk5VxqF7tl1NaOHf+FLHqKyF4RDAyNvs6is75YSSOMSdvGtzprj6yGjKdQQ6oTK+FfbTfzGpr6gPJh27pwZ8FoyzgWceIKivUDt5Am4oAvFSnbuWuog+6WM+Uhi2yojJa+eUeM9thX47/vnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 13/22] mtd: spinand: Remove write_enable_op() in markbad()
Date: Tue,  5 Aug 2025 11:15:02 +0300
Message-ID: <20250805081511.1482964-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aac9849-81d5-4adb-8654-08ddd3f8418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A8soj/t7WG8QJACJKIV9mpJdaK7waYo2b+dZ3LP0CJBTwWqOI14tk8z0Ls+E?=
 =?us-ascii?Q?OtKi+C3giHVASHKiDdF1oN2K9ZOnHTawavWmx0rXA/pFhzAuGKFjgTv/TjDA?=
 =?us-ascii?Q?izKB/+RSRoVwqIIaFzrmf/VhbpXqMIeabVyrcJnMPL5EvDD1TP+ooNIkJU4p?=
 =?us-ascii?Q?lRR/y7WC8ZzeXa0cAwLHMCtrbrxNv60owUBcdVD2T2RhB7spMSq02+3ofkUt?=
 =?us-ascii?Q?LdyGzf0K1FEoSaZhztmqCQCpz2AcqkI5Mki0dps2Ry5z7kmKHzRKv6Ko4YaO?=
 =?us-ascii?Q?+nUdFX4u1llookS7uTzWLpbrQZBeccyTyjxb7F2oYd1lI5wLly4dukLJufFb?=
 =?us-ascii?Q?hy5XiClWOU/d/TB35pQE38hv0n6ckANY/OBXyoq5KYBHyUgVGOs0S+CncL1l?=
 =?us-ascii?Q?ikAeuv6rHi7FvYHVsZfmjlZdPsHBifVtKqao1e26ojSj3EWRls79iVrnJS4/?=
 =?us-ascii?Q?sFMKFGumWfYS0e7xIFgU1IP4Z6s4mIAaRzUtS8Q3lyFtxGfkqnhzcEN2qDu8?=
 =?us-ascii?Q?rksYFuPwecgTE9sBFBZTX8I5leSXLnmxMuXhn1mrznp0yPaRYF/gkGXgsfoZ?=
 =?us-ascii?Q?uNeArg2DeiyvJWBu+Q8bkagQBapk+hAG4NvyfkfYvCoGdeiSjPrDdtWLLUt4?=
 =?us-ascii?Q?6/bEOMcvAj6FjJCw2g/XcipMW8uvSGCE3tAQ449bxXhcptxpqweB/cy3O5Di?=
 =?us-ascii?Q?SPQR1LgqLZGSGv/3q7zbBNI2Oa6d8VEYtaUcCu7EvPQjtIYU0W+q65W8uiqQ?=
 =?us-ascii?Q?fIdo+bXt77rLCKTIE+kAocugPnKJoSdqejWEdE6pQFcg0dd+g81McP3GvwHk?=
 =?us-ascii?Q?yytZQZTnjjRx2rQ8UbSmS4qhjnxJZIIVpYwbUNt70tUVwuibBUIelkAk7TBf?=
 =?us-ascii?Q?1sYiZEapKAabaHr1AdYDzvKUGtqK4wh+D0oAFteJek6v6Dc584PZU6oPf0by?=
 =?us-ascii?Q?LURCnp9X26c/T3kfCTXQoY+IlEzLL6q/ga0Sgk3O5IS8CKIPqmWMkcIMctbb?=
 =?us-ascii?Q?IbWXwobcngnwnzBtWr8S6k9LpIt+PzK1FO0T95yO3HtuXoEzO+xcj54LTv98?=
 =?us-ascii?Q?u8NGUq80NM7mVjXbNwo9iH5l838q6/5mU8yU2TcosY52XKBjAK3S36x6PiQ6?=
 =?us-ascii?Q?IflanirsQkY9wt1W3chvOZKC6tDa3Kt9rM/RDivzph5vrmKek+9TperLk56O?=
 =?us-ascii?Q?lDBQ4f0/falxNoOzzLCtqc6p9IrKZOwkxQemRMF8899VXEDadba1JmHAfXzJ?=
 =?us-ascii?Q?KgguQimgMNVwB+wPmCeyUHpnC08ENXAS6bpgxx+qFczVzPi/9dFL+YoesU5J?=
 =?us-ascii?Q?mbHoT5tjUkGoXXTZgY+HiV50NLyyadZxk2T7vH9rS5SNxBN7VIWj02UcCRCb?=
 =?us-ascii?Q?WinR4FHhhBr8ikFN+3tT9QY11QtTxAA+hJPavBIDouTCK1DUj/l1rDXfiKlI?=
 =?us-ascii?Q?YElkSGn/w1TSBjKf++hUC++xF2HWkKlceaIJIoWqhzstp/Aun/O1FUyYVZWe?=
 =?us-ascii?Q?Dv8H7fkWImVgBWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jqtYJl6ssPCfvFOBYbYENP+nlsr+8g8HClF1OgdEx+NwwwyNmzOuEGBVUWI?=
 =?us-ascii?Q?AjfZ9uuALZevCah17MfopfxeirAVOdK9NzY1HAPySxsfIGkIDaYDaotH3QC0?=
 =?us-ascii?Q?dMUvkm/TGZkI7HFG2LsqLAk0acBoKbFCl+zCkfLC9AAwUprw8ldZZxuxG+3Y?=
 =?us-ascii?Q?PPRYCvOyllXsL7yyrAUAEHeiaZCj1omUDvpv5fUzujsE06R/WSKUT9QiM7bi?=
 =?us-ascii?Q?oNKmjzaaEUehtNbQn9/xnO1sQRgfEw6xnSeJgAumAWPxnXAtMCcCEvlOKv6u?=
 =?us-ascii?Q?jOq2ojNX9EqJCSbMv4neJbVtRWdD9b9SsbOssPx2EWish1+Mo06mwDGQWpPI?=
 =?us-ascii?Q?Cgtc7hb+GAu+3C/LVbG3MParNHWQbXPYkLNgrGhY7qPTpJszbqX2ljXL1OGU?=
 =?us-ascii?Q?rLveGw7yIY2WzvJTfZsJpYpezdsgyUTv7/4tf5Xz6kpCRldqeTegZI7gPU3n?=
 =?us-ascii?Q?c+UJMVK70VdUGEoqtpB1oMFUmGUNIeS9tFAvZW7+6udfjR2GKNfLp+hNtf0N?=
 =?us-ascii?Q?YW/xm6yItmLU1FxuZ24jAjbqVol7SLJxcYz/a0vsCHXCYHgvV8Zqe/40x4jr?=
 =?us-ascii?Q?NPUqDTZIUge6VeiQgLF1fQvXHgeQCXTErlzGZ93xJjnhOQsxejyGgW/kJaTi?=
 =?us-ascii?Q?LZUDKiJgb2pT3wOhMKOCN9778QGzA1NW1s0TJCgdxerXrvOaW04AuhoBANjG?=
 =?us-ascii?Q?Ar9TTi59AJ4DSi+/mvOd9R5aH1Av4uHPOkaxzaAzHqnmphsz5xVFJM9y2s+c?=
 =?us-ascii?Q?9GcGVvcufsm5RuzLQLpkjd+o/5kl+tL3hGM2oppyqtd2f5jhQ7wMIgNt0NCr?=
 =?us-ascii?Q?U2zvR8JOJENSqmkQIyFgUZczCGld6C0DWW6f9fuGlhTjcps2boijQsdORRPh?=
 =?us-ascii?Q?OMilk/eTrrF2uPIumFBlKzeqkWYacFIW9tlVPmw+hRzGBjfmS/4CHO81kObU?=
 =?us-ascii?Q?nSakFxkYpAONoJVJWylR5Ymj2t2SwTr/AWFwu3olg2/nrFZxY6+O0gDELrRJ?=
 =?us-ascii?Q?Bey1Nrd7W8pWruRLoFcg3UQBJVyLdZpkahaUhc4QL7l/Eyx2fZQa+322TJG3?=
 =?us-ascii?Q?F60wZxPQvhI9ncC2Swx1g80rkMDRliwmPyLZ0D7dRLQwFQSgQ2JCnWilLrXQ?=
 =?us-ascii?Q?WwyW1iMYvqS94zF8VBungaFqD7N2g3hgwJHmwY9+d6Xe//j+EgGHrmD1Vvlg?=
 =?us-ascii?Q?G5vlLTZ7KILDcKvD9jV/TE6C1Gx6GFfTlZc9Xzp0rc7OD9u/qNYpDM5kWfHn?=
 =?us-ascii?Q?Wl6uiWgkdcR1LPSQI+defzjF05ixdv6mXqKEZqk4zXkpuuNIgl59/VclhTCi?=
 =?us-ascii?Q?ZYVmFyYhi2a/kBwh+zYD2bMwTaOQLawnm3cxcnSv2/dX+v/Wn9B8yuU90XKq?=
 =?us-ascii?Q?QM+zriw+g27ZDh94FVkgxE1kyy0WDooY6QpcY2B5VSLa0MieDGrI5oOWXECS?=
 =?us-ascii?Q?SIzEM7S0iN2iGylCnNgVaDf0rtPIFfddhjTq+Oaa+BG24soPMZMbg3o4caUZ?=
 =?us-ascii?Q?wWgq58YygSND/dLW5YddtVLnaspm3LVIcbRyezffFBolnvAjtujjElYOgRe1?=
 =?us-ascii?Q?Uuh1I34uAG7Rx6nUtTIIsJ5N4XLx3ZVm0+WwMyqnIVLpLpnWZyAzYurj6nTz?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aac9849-81d5-4adb-8654-08ddd3f8418c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:36.3188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHpd44MsWMU7/95xnNXqAYV8n1lYJDZ2VjYu/YcAVGXHO9gpK6R50SOHH23va9e0nel5LKh/hgNHdACiuXbJmu/ghhN8VX977c92nVxk060=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

This is the port of linux commit c6858779f1f549442ec2fe2f69800d8e9cd904ce
(mtd: spinand: Remove write_enable_op() in markbad())
created by Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0cddf2dd742..9f150eb8585 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -783,10 +783,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.47.2

