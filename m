Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B067C87FCC
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 00:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFB883754;
	Fri, 25 Jul 2025 02:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Hz+4k3+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856A883700; Fri, 25 Jul 2025 02:21:46 +0200 (CEST)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6DB83666
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 02:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3oHdh+fx9KjIKnfDLBHHk3aBIDXT+w7crQdqVB7wFE9AQY/Pr3mcBdVm9CVgl5s46OxLcmhI+AKK7q2PUCh4FKt4Bsg1E7JK1Q3AVe7DaUN9PkiZ2H+/+u0Q3Q+5nmulDFh/7TNcOC1qfLyYhDJAEaV/M2/bJNTZlG9P86tDYDIVnPysuvSz1oLy2b6/2arn/Z3guuZi/R8cn3zpOySkYcDlwEKxE8ei4eAUwbeSmw0N4qJGuglcOMsfsh0UxDb34EDYSHLYdT1h/cPWa+NtgBjFyqh5rTTMdWFjyysKHLUYW05sZNuegTRzC9uBAoV8spaSZOJyKU5FhcVXyk7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMxYxls92/mGSS5fXbGo3+6eR2KjopXYaxAneDyMKIo=;
 b=S7GD3rqffsZD6v+4YEKK8Lp2/81RoW/vk+Tukw+BFpMQM10Z95FdzlC61bh7p8qmNtM+gwtmPrtUBDX76NqjpkQNFa7VdIjWLxxCcwYLnBoXa2BOlKSkpK6whaqzKENBW5D1NWaFX43jDczbEp0ZQuysOy3zLVL06FPGnytomt+o23IFotUNoPMQtRhS3jAtS9MaKRcsyYSEiV9P4bcK+ZRAy8uUQNNqW4ms/suw27ulHzJrkXTyp8ex9C9YmgWnCU+p2bH9oQ6EQarCRLRCBTn+n7gutUaLbV9l0bHeUXfF2rhjFgHjTWZ2J2f7kOUaxDTdGassg79P+J9vqsBvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMxYxls92/mGSS5fXbGo3+6eR2KjopXYaxAneDyMKIo=;
 b=Hz+4k3+hyb19ZHI66/C4T7iSIP/en/OnWfIuhwy7San+RLLgsa4V73OmHii1JN4CsxTKafvAv6jlrVr53P1yVSRS4etkuLn0KsScq1+6bt84aiFiLblNT0DE424pnOuO2GCDbKRZMSJGsgUyf/hnc/Y2aDpPIc8IDI6wghZnAZj1KbeC0XKy7th0Mte0b4JEblngcCe9CwhONNIE969V8cp/YaH8SrC/HJLqJjPG+B/sL+J5TCCYlN/t5JKAG1fWbDP3jqGve3lTWu7bbKNnbwM1VOCMkqeTleHBpjCIQxVrWcMRSPukKKBd5JaL66nSvrksB8gzW5qiXyTyGr321g==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYRPR01MB16229.jpnprd01.prod.outlook.com (2603:1096:405:2e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:21:40 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 00:21:40 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 1/2] env: mtd: add the missing put_mtd_device()
Date: Fri, 25 Jul 2025 08:20:44 +0800
Message-ID: <OSBPR01MB1670E56647F1F8B4BA66A931BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250725002045.7673-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYRPR01MB16229:EE_
X-MS-Office365-Filtering-Correlation-Id: cb284922-3d60-4a7a-273a-08ddcb1137bd
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|8022599003|19110799012|15080799012|8060799015|21061999006|41001999006|5062599005|5072599009|440099028|3412199025|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ng4/fNx9luE3aG0BeDqnuknnUyllz5eNtKbSdUuuqY1AtKss4Q3eu1M5YcS7?=
 =?us-ascii?Q?cuCpmqEXtP99GHRSVYZXHZaVmneDCKIamQTSPsZVpeo0M/S2MAcctg2xCoD7?=
 =?us-ascii?Q?MbRWAQLO2DBBOuTbsW/tT8USWcBZPglIOkrisCvy5KbO8gEgY/vCym4UZWg8?=
 =?us-ascii?Q?+ubDOQ8cDK+002ptZ2282JeLic3JRyGARACgFp+PN3DH1Zc5ZS33i4DoskcR?=
 =?us-ascii?Q?VrzPBPF6zpOHSKzETNDEAldXvikPcc7ySC7ZhQnbIspoh+mjmPWgBuSuKa3w?=
 =?us-ascii?Q?tW+gh/CQMvoE3IGOUcOhQZkaL8wZg0X82FKjp7lPckQ6kc/p/mjJNHOG08f0?=
 =?us-ascii?Q?EH7Drn4zMWbytFP1dnusJ1sruNC3DmDLRbMpY2kGLx7hM+sglo/JBq8M1Opt?=
 =?us-ascii?Q?dZADmyNk+Vr074j3zyCQ/nMw8c1bctoeMxvOvJvN31dvFroM7cL/NsnSVhSQ?=
 =?us-ascii?Q?fNgkr338Cg34En309GC/C9YQNF5k9tAHLf6Z89BA2jjHroWEHuZinm3iHpap?=
 =?us-ascii?Q?18gYfiT2Vcw0jrqLetGIG0Ex0ILGcWikHqQc7E5U75ln4OR6wT1DpmlAj+wR?=
 =?us-ascii?Q?TiCg37QNUaoeSu+gcn9+gnD8UtYwP5Bcuo0qLJkiETr8zrlZItCt2EgFxiDb?=
 =?us-ascii?Q?GyeoxoMniJ8PGDrhhfbK7j8RnpHw682F+m0LP8BL91WgrVgjBwCtJHfvCmO8?=
 =?us-ascii?Q?oWYKtrpjcLO/+Obu+4kv4nYCV8qpnisOlWfslOHgmX8iztTVm5NzAAtcAaWV?=
 =?us-ascii?Q?7tEebyqzos5XtnViCp5IJoOPdkwYWNStm2kvfJ86igbTasCrZY16ysl5Q9b4?=
 =?us-ascii?Q?8FNxV4MMcp7UM4V1NjRRmrziJRrE3lKCv1wSNqzEVUe8y2XFmQjPX5bzoT43?=
 =?us-ascii?Q?X6XXRPqZtapdwndwoc+WEcrZfUL8wABCos1XQ9JpYFpyvr83+GQoWzEaDiMf?=
 =?us-ascii?Q?gpOfbIZ3MZZlG3bLwoueu6Y1V+5Cm2NBtDhjdTusNkK7NWBtkCrWmv6y6Oa/?=
 =?us-ascii?Q?2yFcLX1H0+X45r3w/pTUoUnIXDMnqbYMcc/mQ5v70qOcyzVh+JnH3fXm5RfS?=
 =?us-ascii?Q?trNMODZciUZd+yEJB9g6afXX+yoCAhYWjt+W0b/G4Bj/Iu6wy4uXhQNialbd?=
 =?us-ascii?Q?31255dmMvje1miRgeQdxMjpf5Z0XcxGn4gFD5dfu8qCYsrEVT72h8m/OiU3B?=
 =?us-ascii?Q?UgVIFxyXoz41QSUT8UK02SD1XpxgxBU7VLOfkEzR5/s3z41OZetjby01hmFI?=
 =?us-ascii?Q?WGKaJyiQM9YYOS9sguREYBf44G+x557CwvJT4EIJ2g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RKUoJf4iFjRBwzsc9Au0/dtKht1bNxyirHUHmKJ2kNyC1u720tkDuZP/oo5?=
 =?us-ascii?Q?94aISdyB8MwVWnFl328AWbGI3l0XE+vcqHW/sQRHzIf11aKayHVk5OHGWgib?=
 =?us-ascii?Q?74gpyQ7zLV4x3jcXCjUBmOQq2lhdFx6/Y9KHW6IJLrYFfYv9R5pWUw/gGQOU?=
 =?us-ascii?Q?PGvKUlU9J4U4+f2sCSwHHgl3WODp4nWVEw7rXP35gPZCpI7MTfXj+nZczxbd?=
 =?us-ascii?Q?5S5RNX1fm/Hgu6j5zVClRdTaRxRXyV/g0mCCfaSAgwh1JpdftJTwbxlleaNg?=
 =?us-ascii?Q?ktlDiSKUgF3JbCGwN4Ti7RzdY1wQlNIPMFZJQBPY5Q+1/afrxxtF3jzN8ZNA?=
 =?us-ascii?Q?gcNZGwLenJAFy+egKKC8++j/ycJu5ARn7UdBWQcF2KQMSK/Fzlq3E5p1lKul?=
 =?us-ascii?Q?VlIWYpHCBO+kvYkPuHMPH4/3HO5/BzycAutrEKTNpU/kI5RWRSC6wZO8PVZ8?=
 =?us-ascii?Q?6F6s3vyR4pAMRY/P07aLXdlHXOYLs2GlduPqEyVhO7LbQ/Lh0iEAoNqUvfT/?=
 =?us-ascii?Q?1G7Ij2BUftXNr14ArSEJhKOg1FA8PNvPbHfKkyYrsMWpmQ5RA8u4RMDWqcEg?=
 =?us-ascii?Q?0bJyf+Tp6MItv0oEFZr1Tc/nhilz0ceMOp74PoHCNWbuxss+uQjkoTpse3su?=
 =?us-ascii?Q?PJLyWDxJIJcYIhMoIkSfbmMYUf+7/XiLDLhkRkrbvyCMCNxPKShaDpqgTz1g?=
 =?us-ascii?Q?4HSihbeG82mmcaQ/oRWSTBlX4/a2mYjjM6DdzF9QJIYYvNYA2w44cbe4/LUK?=
 =?us-ascii?Q?kd4TtL0ApoByOwg7IuaIlM1jUNd7QzM9mrlZIhtt45x/F/pOeWQy/NfXixqL?=
 =?us-ascii?Q?1dA4XPZm7FIAECi5Ms+1xPaKr1fsXNop4HibuUm1cC6l7fXS5+eWQHtM8s+r?=
 =?us-ascii?Q?aVElaCn9p3/RUAE6PK6nl6a5rtRD17/zPNMBFV0Yapf6jPvX3lsx3veLh56D?=
 =?us-ascii?Q?OKh4QCYg25o5xXQoO2/srBaZy3C/YrCndQU7ZSNvOrzryFD2NNWTkXBdRtqn?=
 =?us-ascii?Q?lUbHF8B7fAxOGFs5izXGZyUPx+jT00s56LHRDwyPQm6r9ndKQzMFY2piwEh3?=
 =?us-ascii?Q?pogMzojfTlZrsXZhNYvfghtKvj7nPDqBbCzDTnWwhMR96XIrggv3ON1Fimvh?=
 =?us-ascii?Q?ywIS7bNoywF403JUV9JqOuwqxIxjrm7mzQlEb4onzyuhtL0j3XyY0hbPwdH9?=
 =?us-ascii?Q?/xDo6e1e74v7u/Dw3mlF6MvgGHoKAsqWsyEJAf2fFFSzMJTieOt+YVskj4an?=
 =?us-ascii?Q?rD2gyeGAzQi/h96vwSYE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb284922-3d60-4a7a-273a-08ddcb1137bd
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:21:39.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16229
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

The mtd device is got in setup_mtd_device(), we must put the mtd
device before exiting the function to update the mtd use count.
This patch fixes the following env error:

> Removing MTD device #2 (u-boot-env) with use count 1
> Error when deleting partition "u-boot-env" (-16)

Fixes: 03fb08d4aef8 ("env: Introduce support for MTD")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 env/mtd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/env/mtd.c b/env/mtd.c
index d7ec30e183a..ad263ed4b29 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -131,6 +131,8 @@ static int env_mtd_save(void)
 	puts("done\n");
 
 done:
+	put_mtd_device(mtd_env);
+
 	if (saved_buf)
 		free(saved_buf);
 
@@ -188,6 +190,8 @@ static int env_mtd_load(void)
 		gd->env_valid = ENV_VALID;
 
 out:
+	put_mtd_device(mtd_env);
+
 	free(buf);
 
 	return ret;
@@ -280,6 +284,8 @@ static int env_mtd_erase(void)
 	ret = 0;
 
 done:
+	put_mtd_device(mtd_env);
+
 	if (saved_buf)
 		free(saved_buf);
 
-- 
2.50.0

