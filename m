Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBAFC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347C282C87;
	Wed, 11 Jun 2025 17:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LCI7sM/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6574E82C79; Wed, 11 Jun 2025 17:10:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800F482B7C
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 17:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUJQc/tSgjpiH8/Uu1b06LnyGJWz2xaH+mBNrMLt0preCKpXhvITRdMoxKq1iVuQ4nvukNgbwMA5LCo4WH8MawSfDbcyTDaozO3359VhqBgOe2U+oRPIp86HHaW+hBfEdnftU9TLdn1E+wOYqFuGe7vYbD2oz1dykoLp1OXj4/UQesn7NEvqZPjS2cAwsHwoWkERhSDkIuMl8i2Zotex+gWpW8px/zM1nwuXdzeSVPRoICJwNUz2eIDhpKX/CkG6bRcyX4kqM+yehJMMKSvzpjoVaXaXc85SLVJU79PyjoFOuc60/M2fmTzzU8itv4wbqC9FYtAA3fAcfvxcPlcATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=kT/NQ7uJiBWrwAQT7TRJCN1Kno8bDn8ab4/jdcSXctqFmyOexGRQIYO9cMgse1xGLaGUMIuFMDK1QwLCp6WIvs5J7O2dA/0N6Wo/Kao8A4f5HUMxserU5fgwYPLEDT3SvO+u74a9ffPjrOe6Vx6BAr2Qup/LqBizyWkAniuSvYKzpnCOqJIdfZLYm2+jchFVrB8YDtnYdk7yod+rJ247YarQIMIdFwaQCg17AaWw9LccSBIuU5Y8Ry0/OgIj98EDsFzG5qIiGX8ctnO1u/paF3cVznOB/ri/1JB/jypII2ugkUD9IkqZsb9FYrYMU0p9rxXG8Jg9G40wA5BWouA3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=LCI7sM/RPxQDSIc3mX+PP9PVmX3EYqGJnSDSaimd1khuj9C37tN/SbjRrOqap/Jz1dWpzyxxsgvRTV6Oyrgaq/hj8K4FrcWT/1puhHZLkG0eF9PcXa1RR0V+awBR9kRuvz49PdlQLxvYqEyNUF06r1YrVvZUg+XiOH0uORBmrBVV2WHduPqViiDqxWf8hEnyxEk0xl+PjUA5SCFXMyB/6B84/AYCKryRJz9K5QLdHnYSDjNqVGu85t1+FyHbfjJ+0/zydOIpnsEx09HmDpVMUvkwumCKOaUDtNfXPbrLmicKLRfIQJly+1B6A2DuzHPfvD6pvihnfoHA00MpfMggTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8089.eurprd08.prod.outlook.com (2603:10a6:10:3e8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Wed, 11 Jun
 2025 15:10:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 15:10:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] drivers/spi/airoha_snfi_spi: remove unnecessary
 operation adjust_op_size
Date: Wed, 11 Jun 2025 18:10:41 +0300
Message-ID: <20250611151043.1259441-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
 <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 393d2cfa-7ecf-4478-c3ab-08dda8fa2871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3xXyK2mmHYr4bK1KslfmLx02v0BsAXFxldi1bF0EdzTsmN2iBPMmGwc6fdx1?=
 =?us-ascii?Q?bHX8kpCIskuWD8aZ3T7mnpf/Adm05+fKKyeIx0VbJIKeqw1G1CxCHAg8sHcP?=
 =?us-ascii?Q?1Mue4tSst4/6UlPMMNxsuzPV1Kss4mCxor53Hy/MEymzQiy7wzIpydyzBa1a?=
 =?us-ascii?Q?jEjMYwn9Asshn4jp3/wtEskN9rz4sMK7sjWq894yOXHerLRCpoh8sSSPPtzW?=
 =?us-ascii?Q?goG6CRAzGBQXWK2nstYKlIOnt/xyMqLHY7fkXRPFf1+eE03eNmGArxSpiGlP?=
 =?us-ascii?Q?ykjGbXTCQmE42kZtLLQcmQiTHV4r11xqQD32lVkprtb4TsbRJWTCG8cYaHco?=
 =?us-ascii?Q?lq3ct+tAR5MevMdkR5oNQoFJofdAKJiyaeSBG+/tx9ZXNSx4qXmw7+3IvFU9?=
 =?us-ascii?Q?8swtG2wRAxfurIu7i0NvuDEDK67pY2pTqZChN8aQ4EQSrQ92qHBeZd+FLydO?=
 =?us-ascii?Q?Qt6gFEuSdGEB1Fp2z09b5ZwU8Z+0/PbOk6c0+HHdSBKXF5Kr7V9R4h2DfROE?=
 =?us-ascii?Q?afLovXEZVOgXV2NBMek0740ftkyLw1fQKY47Kms+fb0eeJ48IQm3vZijHKKh?=
 =?us-ascii?Q?M5kd0MKXj7WMUp0UrVsAvpDKvYSROdySG/RVfkXduvadfmKHditgQiStTKW8?=
 =?us-ascii?Q?fCk1xtH3nI3Oe/HF6S+T6faDGSv9avWcjKLIx/ch5DtPV02gKPMBHXpIWQK5?=
 =?us-ascii?Q?6K7i1WFw7Pq01a+8b5BXDrmUV3gaIbu5pLYjDNB7DgorPpnvEMUPSn3WSLZM?=
 =?us-ascii?Q?3X+TycvJV+JCSjRULSPbCnLlR1BqaoZWqHz0MB6I0fP2N3QWhyzwI94U/hxZ?=
 =?us-ascii?Q?XhfGX8DobUR0iOsWz+dyqdIMsEJ137GQHNLOwwBQDiHy0zyx2xAnhuq0A0DK?=
 =?us-ascii?Q?/QAGJbEPNl8/Hjek5vCkf7GcZJIxaMbH1tK/VStU7gf0TF332B9wimvw1Jql?=
 =?us-ascii?Q?CCSZ5T/xFtmrdxMJxVrRxmFmZtNkmhB4fQShFTCqA6QbPeykJ2KEuq/0PfEy?=
 =?us-ascii?Q?ggocYMQr17pl8aet0tMmkFJd9V8JcDDZG7ttHyNX3fsGqMpZvEk5TCRQ/WAi?=
 =?us-ascii?Q?TdXPii+4xuqNi7RSGrhUAluo/e9Zw71+ig6RXq+E7BdTJorzAKJGmVcjLMu+?=
 =?us-ascii?Q?HIUdzGWyQ+cum72PoJXYyXCdrNedyVKmtfrCn3o2usQcrn/Iixwvm+oStb74?=
 =?us-ascii?Q?jivImIu0hH/qvAe1chMeDGiLxrsa0KoP009d5sZK59TaMgFMoDSuKyL6/iws?=
 =?us-ascii?Q?OnpA8Aa79CW3VTcHkeCS1ebXRBWjThPWZGWDxxliVaOMIvTVV5kktq8fcCSD?=
 =?us-ascii?Q?E2183y6XChTHQgLacLA/y5y6pTcFCKHuIgeluXfPF3MH/DLRjNXBAiJAiCB8?=
 =?us-ascii?Q?YX1fA7xr7GLAzJRqwyB87sGHFp+zSO67SD4249cCFiDmcH2CU/wFrH/aJQyM?=
 =?us-ascii?Q?oJR7TkzMa+Ez9Zq/navAqTosjTg2cCZyPJDXyzkP93T8EltzNSZZiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gWXS7AtqLSxs4hwFU7bVoOH9Rsez3oXTB9nCwG8hYaSced8ZzsEnZ8vuTRF?=
 =?us-ascii?Q?pZ7l6PjPXI7YWRWrSynXe38neQIBiptCHE+t9x9s7OkwbCCcs8oOJsp7Nwxe?=
 =?us-ascii?Q?0HfgyRnWk8G97vGgJOVsDrnwDRO5DvA9BNyyXlrclDBCm8J9FRKSlkoHOHgc?=
 =?us-ascii?Q?z6skeJbIcTVwU7Uw8DRnvq8NdPZZgvz59UolbgWD2VGapBixXTTfOyD9wjEt?=
 =?us-ascii?Q?D//NiaHyt/M3QEY0YHKwkiLEPWUZ9ylPrCMPgUgzCqMYMSZQKKhK19qepQ/b?=
 =?us-ascii?Q?x6cvQYJlZpTw30QxCDWNzKo5oy9nAGuXgCkT9bn1ZLp8mQdP7xDkg+xL1Eaz?=
 =?us-ascii?Q?wLvUs1b3L3jI4crtITJomMPCD/fx17lyDCX8JBBE8sphzpsvfmfLB+BHCEOU?=
 =?us-ascii?Q?HgYUBzI6u6IWPOSC7igjqSJ3Um4lx7tt3EmtDaqZ3NP3Ny7oITRf8Z0e36V9?=
 =?us-ascii?Q?MMiKp0HcscKVg8VdRmrWIzyB6PFRBA5W/oxwqUyrsMgRUmvNgceSXzaufqoc?=
 =?us-ascii?Q?Z45vACnNB039dRrlqHP/wCI44Y1mXN/meiTK48kwdva1+jsl7l1Mz2GknbLE?=
 =?us-ascii?Q?1FfUy30UuvFX+fHiV2pKaXrmtWpIwfSOrsp+XozlhrL2FcDg8Qub6x7L5PaH?=
 =?us-ascii?Q?6c+ytDv1jzy7QicGflPrVC2MZVFPhwbtkBdA9641LAYjfOqOZReUd4vC44nM?=
 =?us-ascii?Q?gTk5ZhbIghdwfDbSRZM/C4Mmk7bcTn0PcY4aPcIz0Jowggd9bjjFUWV5s4ic?=
 =?us-ascii?Q?0b9295rg6fwDDdB9gdQbdq8ynuoRIbJYE5q/CG2vePDicdlXLryJElX3LFA1?=
 =?us-ascii?Q?4UJqZkKsz5qHvRc03z3CgZB55pvsDmKcikELs0ZYcHxoMR11sOPgRQbmdetZ?=
 =?us-ascii?Q?p6mFk9Y+rPb+mYms6xlKmkd6M/EV4zJcW99eM+nD0gTeeFzSaiMc5CLhxzig?=
 =?us-ascii?Q?+5DYO0HcC9PRLZD4DT0pYCVIUwsLfNpLLMwJM/dYQm88RrNdOI8Oh7/fQvnC?=
 =?us-ascii?Q?1Rp/H3G/U3aTrVNREezZbFqCbCJxa7F1WW5AW8kU6xFlvSEakTV2c8sAX9u2?=
 =?us-ascii?Q?+20MQJsT00fjEkghixzuaRXlF5rDxDAFVbNryq4lR0zVEx++7oL6Nvddkv7F?=
 =?us-ascii?Q?7UFTaB9C2ls6n0q66AEvPe1TpiQvHWQA1+CrU1RpN6fxCQKsYCCbDn6XYXkS?=
 =?us-ascii?Q?t06P0SNS2iAnYUDmseVf1UwByqMs8mwKJIjhhjU3QjUXfwXWoV2veLDBlUfq?=
 =?us-ascii?Q?+GYLCrD4Qs+OHv3Kh/rgddGmvRp4WDf20MgJneyH+B+OlYftIKv7FI4qujy2?=
 =?us-ascii?Q?SiSImAqR1mymWwzDiW3E2EQPvnZ9PkwDLtFDPCBvGFCVEMuoNq3TYlpPnhmJ?=
 =?us-ascii?Q?Z8Gcdl0h6rnoZUPVjFJmscCmnZy3b72WgfdDMgo2LeGMxjqdiAJUfMRIaSxK?=
 =?us-ascii?Q?NNoKFeIfPZh6sjtK7ZaxvlmWsLJiw2vgpNeEWnxpWDUukku9irfcZ6luUiBa?=
 =?us-ascii?Q?enaVO8Jo2sBm2zrsu2kYRdtALaLxh7B/Ted6ghGqOh5XQG2xtjcE1v4Tka0d?=
 =?us-ascii?Q?rh75DgWWAMqhEXBuTrx61HCoaTVIWosofPCIhRyMK+ylbwfYulJgNN3MNAgj?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 393d2cfa-7ecf-4478-c3ab-08dda8fa2871
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 15:10:53.3166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO8PTFWtFbBkkdGzk/6Jgjnb5x6tF1mhBtxSlUTYbfKNYYfJxLukqmCqZUyEwpX8XhzWCvg1i4gCETpeNFfJzvj//WvJ5MJt1Yl49UCpWUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8089
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

This operation is not needed because airoha_snand_write_data() and
airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..4eb01038404 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -525,21 +525,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
-static int airoha_snand_adjust_op_size(struct spi_slave *slave,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	if (max_len >= 160)
-		return -EOPNOTSUPP;
-
-	if (op->data.nbytes > 160 - max_len)
-		op->data.nbytes = 160 - max_len;
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -691,7 +676,6 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 };
-- 
2.47.2

