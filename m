Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF7BCD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0634A84671;
	Mon, 25 May 2026 05:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YZR95IkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0776B846CA; Mon, 25 May 2026 05:20:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3988465D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpT4k6QHgIaufaOzovs6uyv/v8tIvKpUV8+Z38hHhQSXpsoZHALm/JIql0HrZGG3R/u+oDDf1AjQcMNAEPcsSPysLFTu8igJROWYIwisfniXIvV1wcq1sLuBcp3arKaRT5AlF2BMQVuyweICByv7XPZ0Fp/WzhGjiGWSxyfelAFSg+5o1kXQ6XlHMJiFf4HRq02/QF/WNEehau3XlZTG9pRZL6gAI6Df5ZWoz1RlGCwZStucRZK81ZjpaVup9TqP9MIid9bYd70HtCXGqJmablVfqmmFYXiEJHsC9fYdB7p35v/n/skrYRJ5hzW72H/v9OpNnKBwDjBWnZeu1EqPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm8vGL06a+G+m9r1eD/IwHvjuPgxdcEY+jsr6HEC07w=;
 b=bZZL9ZAPVnMUl5+nW0hCsh/S5aRryhj07mCgsmFNgakQ6A0u1rd2eBIX9OtK/5PKmrKpzhG7ZOmHAakrQ4lxVixhVpjUv4ui6jNh2N+waGTKrdpFUF92yjNYus/Ydu3IQa88Aw7ozeCFkuEuuFLf5q+r0KsgR4aUR3hxZkbo+hsIQkVwID2x1f5lxCwFG0ovXQb8yy4WnGFrfFFUgOREtIGb/KeV2/EAGYMM88673rYT482mRBYFkoUP6rBxnIKHl2ayl2EKdAzjK/3f2tWgcRTfj+SUvVV0DcdCJeiT+ihTNIRcffe4ZSjkiGtyRPv/lpoW/bmSqyKi3gPe1CgFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm8vGL06a+G+m9r1eD/IwHvjuPgxdcEY+jsr6HEC07w=;
 b=YZR95IkRb3BPKJ3Snz4V3HjIW9IfOyzN449SjC04vs88Q8oxcxa04V3jKg57Qho9cHEJfUC4QQH1tEQnhAd7arUY4Vha/EDwLfGui46PVUB6yOAnIja2XHGPBWXWdBOeK+7oHxP8qZHrEu18FlMlOTU8YyV4Zubv8DOcqEjClDiKylEaHtD0jg1ooBQXKbLBF0Ya+yalZw5Qq7sBbbUfOWDg7qUtkpVyxfg60cMDTrObsJD9CnaIJjsLMKPiy4hXGhp48BERqItBcXCNYHpIKgS3zqCSx3J6xF9+wyZMdVjv84vvu+1xUscehASliHI1sk2CuG3eyKIXcNy7OvcW7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 25 May
 2026 03:20:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:20:40 +0000
From: peng.fan@nxp.com
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, treding@nvidia.com,
 clamor95@gmail.com
Cc: BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] crypto: aspeed: Use dev_read_addr_x()
Date: Mon, 25 May 2026 12:37:13 +0800
Message-ID: <20260525043714.2374516-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 914c7062-d7b9-49d4-4d09-08deba0c98f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: 7zWE7Atr89irInmOstSY25AzGLsXzciRcCMetdVwTKrJd+fQd6duHi/L3mZtx38/nwMBLQPRHtxQXahG4Bc6h9rXR/ghsz+gkpwrPaexRP/lAVLQHrO+AHG1tF0Tp8cUSjJyhJT4s8gsAdDdeHsBjUpsohST6FLHUYJNfb/3eNqp8k9iYDaBAHgqwzLMdZfvTXM9mWmGoYlxdnAsbrLD3fj95hNQJOzRy9G4JK69BZrQaslQ2kdq8nm4n5yJ0dMvNsl/ykPK6B9CGtK+qa9mb1RykwG9ZIduNCrG/puwZ0MxVi9sS0Mq1o+WhMOaqKAYZzlvijy4mMIxQ8EC2oVLhzOlWe7jRmKq7EqBQUFN2g22WyRpU2QM1b0CB6BWK2SAmu+YQzPhqyusqzFW/o0s0duP4OzXx71I+DD5mqQshlVA2ZCRYeElesqQ0EwIK1rMopbcm7X0jpQD+jdQcj4pEOmw7USSziBZmDJBBYEF1rkBQHa1ekKNsaPdzYdvtYah+upb4tWhzsLNe8mvZP1rYx35nLuL9EZFoheFfkXmJPMRdMtd41gde9rXFWXSQKHyHCwjQrjJKu6HGyFoPIapN2FahuH/TulWdtnutnZknsqs+bYZTTyr74+OSBD7kB0tJt8wNyqNWSdXVIewwaVjA0viztqJq/YgABdXWyJxIIz3GCLySNi+klOOozibxA4RhCWhwKxxCXZgvl8imjchS7OVe/KfYQpSNMkWo12XqUZi0pOjpgeeXOZS/H7Zfzew
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qMmRKlT33qClXkUKg2yWRzQN6xjQFi+zlRsoNkcIGH4Ld63Sb381rj2CLpnA?=
 =?us-ascii?Q?9CDgOA3RynXO5O1mmmGV1qYIEPLFOPjeoRhE2vOGqi/KY0mCJSeGflOjr+YJ?=
 =?us-ascii?Q?YC1kySL1AASqeCDOi3a12eY0KCAP1PBMRmVAqrboPo6PRgacjNhldYiku0l7?=
 =?us-ascii?Q?2JvoKAIyGxT5clErNcNrYUom8OIffk3iTKnaG7Z9B9Y/StkIUm6D+4Pkzojh?=
 =?us-ascii?Q?ixApCV8kMHz+e5fnmU6+EtopJYnRk0V8Mof3mqELmv7mZ+jPb4KE7hG4oqej?=
 =?us-ascii?Q?RXVSKRQfeb1ZspwszPMrm/A33Wl9p1wGtetNXkXlh8taaaxaU4yqRf04MYqi?=
 =?us-ascii?Q?VjX4yB6ALLC2cKBFtnUjvKFC8W+t0Ijbia696d+syWu+bDRuaYjkdLkwy+/F?=
 =?us-ascii?Q?MtdEmm+PPJrKS6G2ryr3Ttdg9dozX5iQdz9wxz0xcKMGC5VYNf0u+8GlxK4p?=
 =?us-ascii?Q?DiEvHgUzf5gjXPMZH4UQ3RLsU2y/GlyTzggdfo+WydWoA+3qOKJdMEiTK3ak?=
 =?us-ascii?Q?JT89QD9twLi2MS5aLgWpEl3iguaYKIXLmUQV2CtMOKK5EV9znu6KLbtzMnhD?=
 =?us-ascii?Q?+N7PDc5/Vquql/c65pSbhbuMgM2NP+5KShHi1fmEwnu+LLFzyhpCKH9xjNCk?=
 =?us-ascii?Q?xqvvmH43MxUUw4Pqx8B/5dbkPNmUSAJRSFUjVqGNfChcVUF4+/rBj21gf8j+?=
 =?us-ascii?Q?t9RCroDXr+GPiX2W+JOymDUS+soOGoXtPEydw74ZnOSBz9y8l4qZ6UjwqrrX?=
 =?us-ascii?Q?p7jITSz36SLUM0/9OgWRmMg6tYw/EqlydomiBqG3FRrl9uaiKTgCW9F6yvl9?=
 =?us-ascii?Q?g3NqwLa6UjsCURUX/OdQ2sydcLohNFJutUKIXAAk3T/NTJnNB1VlimHx2lsU?=
 =?us-ascii?Q?D0ELJLKjQnG77YywPySClepLuJ8tkyoahJkCe5VK2F0h1qkICN4apoH0oZbm?=
 =?us-ascii?Q?PKXImN1HnZEJGZPR9p/JGWPmH7oTFevWbyVZl2aT2WrUjGnAM9YdHcmd0lSG?=
 =?us-ascii?Q?pQyXqbMH8Kz9MHOaopYMIHyGlANt4W1niyNKzgDpishwxrayGrBwxD4rjCgi?=
 =?us-ascii?Q?td9Rd9z7bo96Wc9IjI8LlpEwGjQn9jlJOI2Liz24bJrMBVKm4Uc2PLOf/Slf?=
 =?us-ascii?Q?5WSbylcKvdfi8H1fCiU7BXPTuB5E7r+Xe7G7axA299WkTChVbaM6gXO65Qnj?=
 =?us-ascii?Q?i+/hX/i47MD/peIBjXgHN0s5i3mJQNx7VlDHyHReVrxuvoCdTlN3/IGGe747?=
 =?us-ascii?Q?Kcg9JR+BT9VCsxPBQvH+s4Lnnowim94mPFZE+RbERMXr6lm7X4GSfoigVuCk?=
 =?us-ascii?Q?E+D6tOpluxfwh5nWvbMLV1A8hgsFGlrQZUWStFjs5HUNAUd8RtjPtjAgTZKO?=
 =?us-ascii?Q?iDpUhEBF/95/+U38giDX1FQ8EdtEKVmpmyr2VxPeO/JCIgbV3OOvMpeelzPN?=
 =?us-ascii?Q?3/8BRXEdCibCQZe96Jwa7+wIHEQzvlxb/uJQzYhDb0nQmamEK1+RjG9J6pFB?=
 =?us-ascii?Q?eeCiyTJRF7vd6Sm/I1MxsgiTvLsS1gFCyng+2cY7ASdujqETXCqaLnJh92XM?=
 =?us-ascii?Q?gsXtqojROGykEJykgOdtTrFd5ZoyUlS6RqnJpK7JvwQYwE0WXE7qfmeqPOqI?=
 =?us-ascii?Q?kDYRKGExcQ2yHsfbf4KhoPgBV88a8wjDpHbHQQKgEwkvWjdZbE4JXWpLnXAZ?=
 =?us-ascii?Q?ucKjAHnm/yGv55Kt7epT/CPxTcoEoWl7BLbrqtshgxZxKCK7cWW1ylD4v55o?=
 =?us-ascii?Q?BtLX/W+jIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914c7062-d7b9-49d4-4d09-08deba0c98f7
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:20:40.3336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMhZA3gFTjybhZbL6lTHZPQ+1K6keglTNeJU90gMxe+6GSqO58BUl/bcT19pqxALSRx20+5QEog2GPC+/kbKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997
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

Use dev_read_addr_x() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/crypto/aspeed/aspeed_acry.c | 4 ++--
 drivers/crypto/aspeed/aspeed_hace.c | 2 +-
 drivers/crypto/aspeed/cptra_ecdsa.c | 2 +-
 drivers/crypto/aspeed/cptra_sha.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed_acry.c b/drivers/crypto/aspeed/aspeed_acry.c
index e3f81ebd5c7..ff01256e150 100644
--- a/drivers/crypto/aspeed/aspeed_acry.c
+++ b/drivers/crypto/aspeed/aspeed_acry.c
@@ -144,13 +144,13 @@ static int aspeed_acry_probe(struct udevice *dev)
 		return ret;
 	}
 
-	acry->base = devfdt_get_addr_index(dev, 0);
+	acry->base = dev_read_addr_index(dev, 0);
 	if (acry->base == FDT_ADDR_T_NONE) {
 		debug("Failed to get acry base\n");
 		return acry->base;
 	}
 
-	acry->sram_base = devfdt_get_addr_index(dev, 1);
+	acry->sram_base = dev_read_addr_index(dev, 1);
 	if (acry->sram_base == FDT_ADDR_T_NONE) {
 		debug("Failed to get acry SRAM base\n");
 		return acry->sram_base;
diff --git a/drivers/crypto/aspeed/aspeed_hace.c b/drivers/crypto/aspeed/aspeed_hace.c
index 17cc30a7b54..22b5008a296 100644
--- a/drivers/crypto/aspeed/aspeed_hace.c
+++ b/drivers/crypto/aspeed/aspeed_hace.c
@@ -341,7 +341,7 @@ static int aspeed_hace_probe(struct udevice *dev)
 		return rc;
 	}
 
-	hace->base = devfdt_get_addr(dev);
+	hace->base = dev_read_addr(dev);
 
 	return rc;
 }
diff --git a/drivers/crypto/aspeed/cptra_ecdsa.c b/drivers/crypto/aspeed/cptra_ecdsa.c
index 4b70d89def7..7603ca373ff 100644
--- a/drivers/crypto/aspeed/cptra_ecdsa.c
+++ b/drivers/crypto/aspeed/cptra_ecdsa.c
@@ -149,7 +149,7 @@ static int cptra_ecdsa_probe(struct udevice *dev)
 {
 	struct cptra_ecdsa *ce = dev_get_priv(dev);
 
-	ce->regs = (void *)devfdt_get_addr(dev);
+	ce->regs = (void *)dev_read_addr(dev);
 	if (ce->regs == (void *)FDT_ADDR_T_NONE) {
 		debug("cannot map Caliptra mailbox registers\n");
 		return -EINVAL;
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index 26b97bdd92b..f57778e160d 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -219,7 +219,7 @@ static int cptra_sha_probe(struct udevice *dev)
 {
 	struct cptra_sha *cs = dev_get_priv(dev);
 
-	cs->regs = (void *)devfdt_get_addr(dev);
+	cs->regs = (void *)dev_read_addr(dev);
 	if (cs->regs == (void *)FDT_ADDR_T_NONE) {
 		debug("cannot map Caliptra SHA ACC registers\n");
 		return -ENODEV;
-- 
2.51.0

