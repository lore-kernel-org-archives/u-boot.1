Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85842CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 08:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D8E846AD;
	Fri, 22 May 2026 10:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Qm23ZLNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B35E846D0; Fri, 22 May 2026 10:04:13 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9EB8432A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Guc95zq6poGml2mWMMeK1ofHN+WTEVv5iYnYsQ6WbpzD0xsu6uBUEGF5psFDMF1jnzUFbbiVoLiAQndmRju5n9q5kDWtSmcxuLW4gWXhe2/clUiAkls/wX6abyQavUjldtRe60iMzah406IslxkoT8TPVHaAO16colYN5CL3h6OVcDTu/R+sdSHcO5JAK4T78rhV7D8TY2rSKkPAEKSKrqTTmULxVlFAVwmhJE6yqtaJcurZQaRyyfxANA+YqhT4eXE3Jbl7apsZbD0PU3ta/jWVsg6vp02XA0ngnj0KC5YWscXryCFRjyTS49mAmDLJnmhZA9h25BedZ4ZAUEcvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxyD67O4qOSPa77zUu6yvWSvmC3uVbqMRDwy8Azksl4=;
 b=X0O9OEoDBVLic8xfrTyZ/4xjkIOXoyTCu0HBFroEkFE1sl3+SGPf7xnoUhjcwLQP2K0Ibkk+Hv+ImM0Rc5VFVKXs99WgKS4bdUsXMCpQfDvN7v93LFKS6Un6CiPuNHAU6yLEhmfcOgcRg0j3wvAXH37m20uVMf6vOLFToSwbR23KCb0oSrex/A+68UKyaCBvAfIHXcMblj5Y+FXtDljlH0C1pFT8vTyksrYHvoBnZvpN+X6rHO2PApYwuDgiIVel1urp4alqcfezGwJe0CB1JgnIqWgJ4zfdY8UKSFNQA0fLY05MNT7CSHWVhiruoVHtInv8oymOiWXP9fx6iSl0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxyD67O4qOSPa77zUu6yvWSvmC3uVbqMRDwy8Azksl4=;
 b=Qm23ZLNw7QodnUAd3QxbyxET5lbuJV1vZ5hI/m5CNzpAbOyRmWps/8nAoeqpejSHcoz6uEUjM5cY92Zbma5EGZgLLuWZPmXwVU0/hSMejgX0fkMjuqMDYF+xiu262tpObR09wLpyLqRBxjqkaQGg/2SkQKCDRq9VnzHbPKI0S1mEUKXBq1SbGJi299xJ2GJqtE7aVm2/KcWp/1Fid2fcW3ADhWdN+bsSbW0vYZjeutt349IOet3wqnrCN85FaYtm7yyUC1ldDcFGrh9WKudeOOOOb8IgTGamyxwPjusgfNHUaYuFwS28TFMwFJP5YHfqmicPw6vMNYYR27ixwXvAqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by AM7PR04MB7030.eurprd04.prod.outlook.com
 (2603:10a6:20b:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:04:09 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 08:04:09 +0000
From: Ye Li <ye.li@nxp.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com,
	lyrix.liu@nxp.com
Subject: [PATCH] arm: gic-v3-its: Fix LPI pending table size calculation
Date: Fri, 22 May 2026 16:06:22 +0800
Message-Id: <20260522080622.1291963-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|AM7PR04MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d6d08-ef02-4b45-6c94-08deb7d8b42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|376014|52116014|1800799024|366016|38350700014|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: dShdeTAMPsgFC5vD7pR2jepBtzu2QX+B94r1RJXKLbCxZ8uUX21d8s4u+ZKeim2rfqrQRf3mfhxH/QHfk8NxCW94EuvuDCVrLNkT2TNL+9wDBBRF8XItOlUfQlGfOnwROeqP0RDK5g+ncZJOBSE0XL4+09lcwSrSZN+SURqU2nQzs+2iRhJTigMcqNB5zJWrywoUm9/8W+1nq9Isaeux5jXIZ1C41UMhJACsaCem7SQKnYjTZ7deFHNtT3JMsAFXRqWoa07Ohyl5xd6vvH3mww5/w88HaEtaIbjofwnI899IWWSOolZB+tK+MDP2gowCZh+ZsJLG3ysAEFyN9PBlBZ7hw4ZNEPCnGrohzWYjYv6nEuLTFH0F67dHt38P5IMmAZCYxElOW7z3M/FsvfM6HCkSTimU+IAyJoZCoR86BkrHgVm/k56Woh3RnQ3BOpwoTiddWZ0DitGzScIAcwnYAvyVO5GvCS/KXzbC8Id+aRGaC4fZqTNAymTVgcoRwQBQyCLkOSGOksEgIxKRSD3drH/waDQoq9UNrBIhMXceXQh4Fw8x4WDOfaeGTWsM6jie8LsrwkKmo5RXEyRdOCPHZgvOAdXp6yo3k8txhBXNeknhcCiG+5ZCvicshyms8ddZ8LR6yf1aH83MrW/rzUW+rvyN7JuDNJm47wYrDpFcqNOXXAJf4tveKM/SYTwkWxErbCUl8smHc1f+LyKo7me3INJlRyHw5/xOZs9eLRW8HB9NT10yCRQCVtisPAiBTMLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dRfZnBcy0bPmUOt1atbMksQYwKzNaa9iiZSxWVO9WCQvu9Bn37vTxAaZ0Xug?=
 =?us-ascii?Q?djzjHKAKB+N7dFwUDy3IalJrForWAuA6SfQby/BkIUi/SFSqYUnQJNDg72mg?=
 =?us-ascii?Q?XYWbWtTsQj417ptfPfGc4XgFVYO/0rL8Rp5Lxm/1iszuf0+e2ToPnrYY3oDX?=
 =?us-ascii?Q?uERbIX0we8SMk/IG6g2umkWUSAGFqjO3INBoBvbXFqEs+xQVCTYHpB0lG4Ja?=
 =?us-ascii?Q?7LoGom8iWjEGyo+as31yDnD4jDp/IvT8e+c+SmVI9KtlWT3gpdrQN+8bMTkk?=
 =?us-ascii?Q?CqnHH3lOyUoUWUiRQsTsH1+qGt2DTAN8IHJmnR1ynz8+9sVg3IklUEBpCT/u?=
 =?us-ascii?Q?YCkfjKLBuOJPbebWYAuHpKkP8Rzba5Ax+SilnxDCGD520mEQnWP12wcVS2OV?=
 =?us-ascii?Q?eORTW1jrmskcV33hUE3wn5hm1StawNQy9iyAmWbD0MTEMGFkzDPBj6X6kK0t?=
 =?us-ascii?Q?7RFjHYItmrHgqIBRuPBHGBk9rkNn9fWpxWohSRNpz2QcPbGHBNVyw7fPi8A5?=
 =?us-ascii?Q?mcSD5gBxKps3hrHPcaSfqXqF7YaRBG/Q6a0Y1VPZgWz172bcATEVgbFawdIp?=
 =?us-ascii?Q?e5eOx+rWCg7pSjsRmHmUEuKFwcSJkUpq0js8RVdfv3Wn2i87UMO3RATqYktG?=
 =?us-ascii?Q?QhtgXGl5hq2ffC88byOqSLWNbE8y11U8tgBVoUu1hADAEb+oa0wBaEY8FHJI?=
 =?us-ascii?Q?eVYFE6pv3Hv5olbiMvTvTc0VpH7q6O8KoMPSB/3nxU3zmMTPGN4TjeUooHG1?=
 =?us-ascii?Q?MHBPx8gdtkPL47B4UAeu53BLTlq8yCSQ8NDOixCr/+AXSUArLpYWN4VUmI+5?=
 =?us-ascii?Q?t0u2YpJ7MZhAfUyVId3Ow2Gc4yWFl8Yl3Zor03okILvvhHR91e6fEf0YQ0V1?=
 =?us-ascii?Q?OtHdQHTL4zu6Qz3TiDJdrkFd/nbWFp+GY2js1J26+isXABmdPK8b6cTZQD0C?=
 =?us-ascii?Q?YgmBS8ebtdx4onPbf5hLMZ7BUDvhgNxCOa5WfgoMXWflJnkkvR4PjFWxgz/z?=
 =?us-ascii?Q?gSlKkaRY2/DdQINwQ7uq12A2WZYUV/w5pUlAGuWX0vIReczd283HFHK9e192?=
 =?us-ascii?Q?LOJBV98Spw9nQJ1HcgpdAVZf4aogKDi7APS80sCZMeR672AIjddBvdXOqcqv?=
 =?us-ascii?Q?91VscwdQQOqIMGCN4hLEqmibGCAObNtHyItANWjMhu8W/dhL+PPSo1zg8+Sl?=
 =?us-ascii?Q?IE128UaQhNwX9UhiUxCU2PrFmYM3JOdRi8qI3NlllSWtMVYsmAgyFS0iOz8b?=
 =?us-ascii?Q?eQUnoJx6PDN3tZVNisgCnnLAScvKU66TNloqokOFNzCE+slqTmPgeSt4x7WG?=
 =?us-ascii?Q?Qqy+T4Cuy/5YaHZR+ADMlpyorlVMhaZRKUTykRgBHMS8DOxEOa+pwpBSUS2x?=
 =?us-ascii?Q?G/3X7LfD0cjZxlaCZfBq0KgSYCt3zfkFWZwu3jjV/t37By7Gl7Ofe/PHnway?=
 =?us-ascii?Q?ts8zLDahJ4ZNx92n0UTFUMUE+FD4BhxHuiK305L+b2w+Zt4bq7aTizfrz59G?=
 =?us-ascii?Q?kDtWMV3RNvvHJGSFwdgsO6270cy5hH3GsH0IMrHdfuPtzL3Fk+BgRv+Q0p03?=
 =?us-ascii?Q?NCSitShHkuWMC1K/jjccyH+913niCXZKa7B7d6PW1vvX5NwgRwxClpy/aN/5?=
 =?us-ascii?Q?aGjZlFV5S+51h7OTvC/R3XGqwNALPSoCitIJAa18qVfACsCNWkN5Yg9TBDXt?=
 =?us-ascii?Q?h07DzdsBXHEkAeZ0Mbg4Aai5z9qCsrp6lbox+9KENTEUkQZD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d6d08-ef02-4b45-6c94-08deb7d8b42e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:04:09.8830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TUiXZXoLpfl3JCsuhyypGz93yZn0Gwu/tgF7S7SDuVxyyGHM+OdeUAE5Fg2RuMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7030
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

From: Lyrix liu <lyrix.liu@nxp.com>

The variable `pend_tab_total_sz` is calculated using the macro
`LPI_PENDBASE_SZ`, which depends on the global variable `lpi_id_bits`.

However, `lpi_id_bits` is initialized later in the function based on
the GICD_TYPER register. This results in `pend_tab_total_sz` being
calculated with an uninitialized `lpi_id_bits` value (0), This leads
to the LPI pending tables being mapped with an incorrect size.

Fixes: 60b9b47d295b ("Revert "arch: arm: use dt and UCLASS_SYSCON to get gic lpi details"")
Signed-off-by: Lyrix liu <lyrix.liu@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/lib/gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 34f05e94672..d11a1ea436e 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -81,7 +81,7 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	int i;
 	u64 redist_lpi_base;
 	u64 pend_base;
-	ulong pend_tab_total_sz = num_redist * LPI_PENDBASE_SZ;
+	ulong pend_tab_total_sz;
 	void *pend_tab_va;
 
 	if (gic_v3_its_get_gic_addr(&priv))
@@ -133,6 +133,7 @@ int gic_lpi_tables_init(u64 base, u32 num_redist)
 	}
 
 	redist_lpi_base = base + LPI_PROPBASE_SZ;
+	pend_tab_total_sz = num_redist * LPI_PENDBASE_SZ;
 	pend_tab_va = map_physmem(redist_lpi_base, pend_tab_total_sz,
 				  MAP_NOCACHE);
 	memset(pend_tab_va, 0, pend_tab_total_sz);
-- 
2.37.1

