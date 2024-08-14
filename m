Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF557C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45468881C;
	Wed, 14 Aug 2024 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FTL/HWLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22138889A2; Wed, 14 Aug 2024 12:08:49 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8F287BF4
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjKodb/vyjVdleI4EADjtAM2BPdXvFqWTac/+sEPmBJUfDMLntT0BdQAdyaDs2x/tpEwc43jr3A4CwGdyqvXzzW2qZsCxGS0Pwy6yA5BTuSic6164eckuq2dXQQ9zAM033H6i1PhV5jW4D3ZDZ2UnTfiLyHJtWLElPUNC3HnAuljaihmTTvCfPIDmPW7XEj9bH2O3LIZve6Bt7JwH8KkD4BNk08THZmXWhulCAeUmQYzxfTj53OkGHtfJLjQXGBctCv2puXfCFm35pLHf/39xp4+/xBZY9uxXiGQrk+na3/FbI5h0x6sYMPsNG+0FDTTOaK1/ktoNqTdufzS1LNlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfK+fEO+iol8rYZCbO75TaXnY2/61hr/M2mIm/QGUro=;
 b=w8zeEv/XK/LFTQmD89XX6CJ5o21ItgzxPTphbGd6TyP3WAx7g5cMiTx7vQOG7UJMRQ2BHRLOsiEdbCNy+uz1W6tMNfTJdOAYG4/AUIHYLI9owYY+yD2j/eVDcqmnnnEfl7j8k8qylDsOA6ZVprqRif4BbaE+JH0dCoxCtQ9Ao87EGpbRbQhomTFlm0QBoBTuulbTU4PQ8hPQo9L0Hve2LpUBeAQoUJ8FQUx/EtLOdUdPYkNdJnyiM5cmWhRfQkNvTs3vpgN/5dBxyetz8p18zmBXBVB22B62dZTLj7t5vAPOH0dRbcVU32HYA1GRWKKoWpw3askmumhKrUye0fi0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfK+fEO+iol8rYZCbO75TaXnY2/61hr/M2mIm/QGUro=;
 b=FTL/HWLMrHj8tK3iVn2TVl+SQ3U2CplXLuaW4uQjnWBsk4oGtyjetCbWL6HcQpS5aw2cu43dgxSj6AlR3Ky9n5vWuAPYC/cC4dA0lXErjc6gPxBGGryi+JrGaNfPP/7SFbQE2Vnz/ZA9/xLL6YpJTC/KG7ewjK7Vi7c6FPs5NzCkjOkgD3ZPmYeSClGDPt+6bVhZgyxE8Q/sioY0fe07JIiLHG/drF1M1cBB9X8X0kLGUQOUqbZpCXFGFH+CAHRHqd85UXwzImOl5ej+0RpDpY2eAMRQTfn8aLsUmoPT6WLl8YmDii4lNOnYkceZQJnxEZN0BQ02MkApU7PtwF3dsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7764.eurprd08.prod.outlook.com (2603:10a6:10:3b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 10:08:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:08:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2] cmd: led: fix led command usage for the
 LED_SW_BLINK enabled case
Date: Wed, 14 Aug 2024 14:08:30 +0400
Message-Id: <20240814100830.1296313-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0660.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: ca95b246-bb38-47f4-380d-08dcbc4912d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: kXit8PclX5hEwp2+9kG5ZTK71G4aXkKjxFwaMTyvLzarAdOb+/U26qqSgkGrFse+WxS7PHF5yWIene4NpXP2SK5ktCPLChDzod/Bc8nOhYsl4++6FABoqCwQtd8qWv4Ph22N5Ox0aasrh4yCoq0SyUlYykaxnziZIg1b6CHO3e/KeP9+FG9tj20RDkCZecuXwmLlNu1fS8xL5+GnGfT8oJiJ8cRxU68Ei9pPEwqz2Dt1PgkAcLt84E7cbwjVDEvJrrkafTq07zvzUrHlb+tc5BYGRKHxYM8WLrcLsx1It77jH+5OR/OgsIRiW4HLv7xki0QRwGpcrrGb1qmpEygaK98iRqVitOPRF8KPgAT6eSFCaCdaWWRACKs1KBzwY1VcxrdnA6llACfeGcVScisVSfhe0AL4JcfMQHVWvDXSvOoVabBqVH0DGLeLVhJDWJNdRmz5PqorssxHG1OTnZPlS+oDeI1R7OSEIuqATfuH9rzot13AzLLjUTnpNPcVYBPmkbr4KcqXIwwqyyJIubkSsa8g833QC/9P8EzaMbIS7v9mqjQjzillboCzRyO+eOkN3hX6TMdd5SPV17whmL1zUfH92yy3Z31a4jyufiB0CNWPlFEypxo9ZIMWnw+KJyBAOSSnDL24HoeeQNI1AEeQxHrQVCRQe5JGeKrRk8zVYL81MagPIlPwKzDCldPwyG2HgU4x4qdUeS/VzvAnIJJJ7Jgn3L+1Q2RI55S+0bC/Z84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uzpYmT+RNd+lQ6PmyEgi2q3Np7tdv/Yf+AtL7mBbmbaY1LgqHBD+iAgqlr+?=
 =?us-ascii?Q?JnJAZUkEOGSgn3XSTK7WKgbv5uROt3/vXPxtp6+FsfdWsr+888d0GZDZq7Xs?=
 =?us-ascii?Q?0CTRS1xm9DJurNLLDjtQAtAkTc9XhaVRqnlmwCxS2FF/bXFbXq7Sj4lkZ9rh?=
 =?us-ascii?Q?BleedM7nRNYz1bdMDczguPc7R3fDsNYn6ywaFFQlh6rn7H93nufDAJx0cfOo?=
 =?us-ascii?Q?CzUUR1QQY3FHRjmjxIyxh0HzzyFs4R+td1KF8lafdiWbOOS14bgmA4NvtlQs?=
 =?us-ascii?Q?AQ7clZrfAIk+joF31OPESjpZu/97uH7QrHMgkfdkayazd42OmDvMoB9kdcHl?=
 =?us-ascii?Q?A7MfTncjA7BRqdWCQAnPACtdpSqZqayi50WNXr1NoTJ/QB2dhQa9Zveykw1b?=
 =?us-ascii?Q?NFe3WyL0ZCyHggV1rV4Uj/H2ly93v/t5qlJn6OLhy/m/oVQLJdloliN7rgrs?=
 =?us-ascii?Q?dX1zXBE1C37EZjFNooPjBRxNTr1y8wm9MG2qhw/XP9ZFPAbx7kKDC4dX1Lxx?=
 =?us-ascii?Q?i6urIY218Dlz3Hn4hzfxJmRY7NfD5tgYeUChvO5zv/9o/5/6ZWcyeMfWrLo3?=
 =?us-ascii?Q?e16WpeQI3zHRxs2L5fFtmCC+Zgt35PbeWou9vBR7Vh3hxmLqr+33y8iVOs4I?=
 =?us-ascii?Q?Cu5tEm7iCBQdjsCOek3y/CLTNgSqLWKYPGKB2aOyWYURDUCuAEpA75PLHvoP?=
 =?us-ascii?Q?XTfcxNCk2W7mnfKcDvcBKsaEqeol0NAD3R2gD5bgiytAIAIQdnef9jfmlGZa?=
 =?us-ascii?Q?enwhyZSV1m7XMW7BzNkFA9TLLsi4TKh61JZZKNCu9JJ1tvbSm5jzH/lgI56i?=
 =?us-ascii?Q?QvsasHihH330EAf86O7MD5sQo+70gCy4ccGXwdojc/mqatF7R9s+uWJ6h8/x?=
 =?us-ascii?Q?pOnlaiPZ3Ht98otd8L40f+7d//zZ8hf6mqOZdLMVt9W+nwLJJGaSRuCgI11U?=
 =?us-ascii?Q?BHqbl+63cBWLu6FLwiwGUv++G12GQV9cjqlMuGreXBzU0fqVA1qlD9GbHBYQ?=
 =?us-ascii?Q?Eo/CYf/wC3F3+dpHluu247ZbqjN24V/e0/AcMunQMu3xMspJWT5FLzUvVw8s?=
 =?us-ascii?Q?p8bh7ZtHCG5EI5U9k73AQ9/WCvVE+bshXiIpNdWMw1kEwFC+tFmAP+c+Qi5i?=
 =?us-ascii?Q?s3/co7BRrWPjRYdZMRGyoh6Hrw+f9npDi4BUoGQBCPdbzUfLGXaZ2vYZSgRW?=
 =?us-ascii?Q?XV7aX9PGiSc85Nn2Un2M7+yVCn6biquLU0yleeFW4dTMU+LYAHHG9FdDN9wB?=
 =?us-ascii?Q?rrU2iMHZ+/BhI+1ntUaMmDnK9L2SO7Pmz2VTko3rSOvc1Q34A1Lc1/C1CKc5?=
 =?us-ascii?Q?xTZRTKdTE6v00C6KZ3FLpR7FsaSwLHd1NvT6qAss7o9IGZiAD4AI5tsGNarg?=
 =?us-ascii?Q?GNCjGUWZXTDFuz/UpoS3Hho97kwuNdSkPFdNzs3ySoMYm23DrCqGo9kUrB6f?=
 =?us-ascii?Q?r8ms5njG8JrNDBJBwylsfaAHHPb9Cf0OsqxA3P+dxUQOlaVPhNySDNiXUSq9?=
 =?us-ascii?Q?nZ1ikLgKHoXrKMOfGAm/PjKKS/KKQZtuTj+N3O5roLPSifwl5YIvEWDKPZFX?=
 =?us-ascii?Q?sc5hj8zbBYLnG3+AiXuhU5/V5jdjoTEfFsinJmEVAq2HcRlFY4H9wNsdhE2w?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca95b246-bb38-47f4-380d-08dcbc4912d8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:08:41.8318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAxF+JGvA8hupujXRklE/p3Ez4SxMFh18He8BKxTkwR7YiiTRlofAgXZq5eFFBiH42znaz6CFKVzH1PHIFt1M1Al7rfbf/xsUMCIcoylOoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7764
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Alexander Dahl <ada@thorsis.com>
---
Changes v2:
 * patch description added
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

