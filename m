Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91339CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224918365C;
	Tue, 30 Sep 2025 02:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="VynkoDlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF38383653; Tue, 30 Sep 2025 02:21:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA05483544
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHKT/eSkIohdL/5u9dfFCmV9iq13OuQ8MonX1EXKUtf7mQmLGWYJjnT7ZZEFSBc+NrwH2FvYOFD+hL6kQKNW6ctXx6z/X6qJUT7lTtc0Xb7pUvxcFbYB3v7E1PLoqQdpmiW93Q5FRhbEdMGavOF10xighNyiZzjPff6CyNDbHyMqlu/+bd28laqmFBHcmTzQMAAoa8nX6SX16V49EVHPJen/PWU7CwoVMiUpmohLyLynjGukmkV2K+l+tFOwLht/Q0rpVe7RWK0mm5/8Yj3JjNS/UDr+BES5mkcW/+7eev9p2fS3FnIGap8RX0wsluI5nusdzJ5MsXYJy1RoUCyWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc9l6nVCvagQL9DT8x2UfB/cUGUjHGkXh9YamiB+750=;
 b=SY0tmApthRVufEG1clbFkVPvzjcPfYp5yzfAroRIJj1ozcnjsCpw3SeFpt7MTbmlnY+wmZpG2++ulPOClqbRgJ/7nae5w3p2QHLXX4RN6RbTFYzmk2qyGSctflzxD+pcpbvNIoavBAQZoqZtFoBflcyHHfxQCJF1QFihWGLH4tDZ4Bki78p4daDreVoKFdMH+iPnLhnAXXyOtbOxs8FeY1RBkZQFYpPIy4M0X9vUBa2dRAxGlNaDULeSa2G0qhVKV5uUFUSA9FCUacbUBMEgGsV15eurt+7zQynMbpbXQULvGM2Mdg82p3tYXRGIdkX79HgA5LXubiQlPzazPL8JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc9l6nVCvagQL9DT8x2UfB/cUGUjHGkXh9YamiB+750=;
 b=VynkoDlmBAJEiNwIl/iIn72cQHeoks+epV3mMq3TY45vfOwOsgkOcog2jZMZ0lnqyKfastuJat2hngrHO/0pgUuO6o7UvISQrg9wNtJzaZFbHc7v0SYJK10kxtGXgXgZC4+G9s2u8QbTmn+EIScclFx8YzQB80jxI1zozaLZXiS4SoEsyC9wgeKL0bBE8Q7CKomX19dFtgvBghNc3pdt+SQn9ax/y7GTFn7tmTJmUtAIcTsDh+LI5+URd0tL4iU5YQTurHSOpGpcXwSxaHl96KYTCQ/1JivXITbAEi+T883ebL++OHaA1pYsA/6zxMM3sSguXLXc4rTGe9Mw/9QD+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v7 13/24] mtd: spinand: Remove write_enable_op() in markbad()
Date: Tue, 30 Sep 2025 03:20:58 +0300
Message-ID: <20250930002109.3600886-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0271da-22e8-4fa6-c88a-08ddffb75015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jcsk0k1/wX57oQAQnNIsCPYYAWE/+d40ikgZvzpaeGtoStmbA4zPA32Ph3Jo?=
 =?us-ascii?Q?AIDdTK228H1zrSbFhC0kxvPnKCnZ7Aaf8tMZZXJONxq6/7pGPWQS02uBWS+C?=
 =?us-ascii?Q?aPRCUJFLbQaiUpfKtdAkRTpDAxWqyOQbWkYz29kubBooTUJwM55QKQLIu1bV?=
 =?us-ascii?Q?1Kvt2Hww6I2Xc5hJGGymrjMxgcFzRDVB/jskhceIizkFP2xx3X031R9z9ZMO?=
 =?us-ascii?Q?hBLY1AYKU6EjImWLUyZ3/rDWzfAXTHZov3QQ/IqKexys7nN9iQmsf7PDF4ku?=
 =?us-ascii?Q?FCEwaXlvQECsB5jkF4WzqzOzlkIoqXgjTWHPhAg8maTrxSdUHx58sAooi4oI?=
 =?us-ascii?Q?ZIO58/QPgIzHNysVPs6jjhAEoTuu+PReFF7WAlFSp0ALq/ofi/0mBQh5F4Ii?=
 =?us-ascii?Q?k938AZYi8z0cPrnK9sIp/k8PZ/yq0KFa9D4aEACkQn9+YcDsKNA8dCRn3OUG?=
 =?us-ascii?Q?HAN4N80m+Ua1OwH+m5QfBNG/KqVwwp3Br48Cyt4LjbUslar4yZZf/gLCVVlX?=
 =?us-ascii?Q?yegOBkMiPp8WvagXyZRV2ZL9z3hBIKRChptTd1JCErGgjhvVHO+GEe5Q6MpU?=
 =?us-ascii?Q?2z9xd/IADh67xErvP3wisqmt/QGct9n82RKhFnD4YdUD284xj3y54HWr08bI?=
 =?us-ascii?Q?vclZLHkUPku8lVv6/Wow4W3iQWWXXKQlTmszd0SqQzPc5DciEq36V87gqeIv?=
 =?us-ascii?Q?wB75H+/U2YkADNiSFBLjHrfcOm4ekmIV9c6sxyX8kX0Al1FQOMFkD4U6n3eL?=
 =?us-ascii?Q?U558cTP+fEKtcrSttswE2aJZFGB6Z5Xhao3guVqnZLaEohW+eVWLQFvkFJxB?=
 =?us-ascii?Q?TIDdGkb/G2kkDOc1e7KnouNZnZ5md1DNzfef4aOkumaSjPAgMFNuIT8gXC8k?=
 =?us-ascii?Q?rrIPxB/BrH9ShBUIYpttRoDgc532MJo+lSlI9SDMIOcJZJl9sii27eLOjd0e?=
 =?us-ascii?Q?edP9Qsa8dSRJPSovIHa1By7FOE06PVu1ZFUJH+s43qDXex8RhmT6Zhy/QAyJ?=
 =?us-ascii?Q?mB29z3ILDHjmr6IM9Gvr8HIYwRht09I1nZQ+kocf9MIodvKZR7DglC9FCFUd?=
 =?us-ascii?Q?xCSgkWj0R2zvqIkMPGHZY3JCvoTL1Q5H91+lzUf0poGIA7SWnMTZPc3YDgSM?=
 =?us-ascii?Q?DcIBQBniwoN5QHFUPe38Ie3+NJQTbi1AuZcLG4utjlHlyo0O6kqt5awUuyVq?=
 =?us-ascii?Q?arCHXYtEb9QVjw873VaGxbjaDbTWB6DdPnB3ShohG+RAbGPREfB9ye4f82I7?=
 =?us-ascii?Q?5M0smHlLcr2XjLCBjbUqEMMB1TlIlN4fS92JGvrp86h9/DKrzUYKCIxGsEFT?=
 =?us-ascii?Q?l7ZYVqCQhuTVspSjefDKoq3dK8brKGQw3XszjCvMei4yEFC5xxyM1R2s95y9?=
 =?us-ascii?Q?rUN9WH4l+6PRGaq112qd8z0HN3DD1ujaQj1KSgjLr+qwYcpLu+YFQVCvdS7N?=
 =?us-ascii?Q?iZKmwJxKTsIbCm+pju2uKBHUZjCufSAzpvLZRY8tru6AXqaUR66MrCi7ZxMa?=
 =?us-ascii?Q?HKdRoGVVmn4h2rZ1ojZaOawSECnz/J9EmXJRdRvrwAT0uQpK98yF7FaZEQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PD3BKCBlrxmvH09KoH6w4LPH534MPW0d2iqtVtZuGsBVToIypOdCw2JtMbFO?=
 =?us-ascii?Q?21X9t8XD3QRUGM+OOKXTVP208dqYUDg3dmhlr735I2s6czwl384LHZ+EuU4G?=
 =?us-ascii?Q?QJSfdFC5SeMwU5QLtJpkG7wpYQ3oo7qbqXjbiqAHa2hoG4viY5P2tHdrTNcv?=
 =?us-ascii?Q?3TZVmFaRIlDr3uPGznOYfGuZjvoJjyP3kaYbGWQM8VTpqWA0e3UGmwIf2X7t?=
 =?us-ascii?Q?jb5zlO4Fdfqo2vP1TJq7nlbRi9SHPgeIpY5CxPNMx4vuIAbBK6Lmat/u4S6M?=
 =?us-ascii?Q?j+afD4RM7NEQO5U55+Fdcru0MhtHo4CS+u0Vokse0moLALaDRUTO3JtdsTEa?=
 =?us-ascii?Q?D4uX+IT8wTd/GCohv1VowYVOjRIHIM7G+R12p5hQj3T4kQ1hNnB+LEwjOjRS?=
 =?us-ascii?Q?bSNPvu/NAR0ucN3BXmhnDFY2AZkLlIjZoIMGHdevtVNp+nJkqP4swUAI2LuU?=
 =?us-ascii?Q?tPQAiC4hL+KDp/8uuIieVszsTKOetMvFUqd54g84egs4RI+rv/Uk8/iirPYQ?=
 =?us-ascii?Q?uS/zXN+w4vzsx4PAZ7wUrzwuQp1+CSgH2ot2Lhn+d+6JQOc4WuURp3nhucrW?=
 =?us-ascii?Q?eVe33/8pir9ocnlqJRuWnIXlQ+c3yCRJqSg5yK8SQw9JUkzUcBD1mR3Dp+oJ?=
 =?us-ascii?Q?nLIvNPcC/A5DILkDLpNWDaD6ZmtkRpsVo+k7i3gUIgO5yjFgFs6PNRac1/ii?=
 =?us-ascii?Q?P4jyBbE1NnaJK3ZKUWLwkGrX0EXBmGiyDG23jGZABV61kgXdOVhXdutqYEZm?=
 =?us-ascii?Q?dDmceuVMU/cMZMEujwJTTP1Mu+Mn8w3sjVD4fKTDEubIRoaauRrGhHD5xt/4?=
 =?us-ascii?Q?qemnchWhikgTd9YOIfWUdZW2xkFLRSB90/xmo5iU4EYApQq0IMjmW6WJtFdw?=
 =?us-ascii?Q?amdY5s+FKemY2IXGdkFrPueM6fbUKYz1JnNaGIL9RfGrXz/fqO77b/5NvYhW?=
 =?us-ascii?Q?TQ6rjEaktNYa4vZTfLBF3uE9gZ2lZK+UaN65uaoIgmURedyi+vqAc5XP9hsW?=
 =?us-ascii?Q?h11JA45J/cizAo0u/SU5oafPpGrCKuUJHwCVFyeWSY1jf/jhy/P1hTKmqi/b?=
 =?us-ascii?Q?UYoFKsuBJ0eqamEr/B9N6F7gqeT0Sx687GakQY7uGcdh0+QeTDa19osTDqKo?=
 =?us-ascii?Q?z6GJAMGqIL7ZQ9H4bc0p1Kb22YCbDKMkLpOGZzFq5uRgxdkux6VnpIHWtqpt?=
 =?us-ascii?Q?fwH3cY76t8bLqAs6vxa/sU6eERfTcbzT33CZrVv4YWsEraLww4lxxz23NkUi?=
 =?us-ascii?Q?As1IeHudtFK0iGMmJ0Bw5WJ5qWJXxkRk9o1q7nXdqm/4ZbaF+aoVaOWeqE81?=
 =?us-ascii?Q?h0lLgSrP8eUdsVrIpGbszaM0tPM1lr+uS5MkvZZPutCC8t32W3wetogg/K/W?=
 =?us-ascii?Q?JEQRaqIlGDEPFT5CK0by56YB8q1gxkw5Leqz712KfOoz589mX5/Atq1viF7W?=
 =?us-ascii?Q?suyDZbrkyFyVXS0e5nHo1M09sgoPvLhalxiIuCmFgsbtpBsjJW9dMNdYUDhO?=
 =?us-ascii?Q?1vTMpLGeFytrroMgqPfQOpsby2PYZjKVUymaco/PwQnKDTaLjgVRLqEfhrT3?=
 =?us-ascii?Q?+ubI9PgqpQTlzQZl+pAQ3Gl3IUQT1aMcJ/OT3TJNbgs2FWNb5aYMBrybkmjk?=
 =?us-ascii?Q?eTPo3ovM3A5tdRNa+tCwDts=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0271da-22e8-4fa6-c88a-08ddffb75015
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:34.6462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mn7cXmMhiWvsZk+43XRIq4Xaql2G5gMqzuHNYzaNu3jhorcHxl5NjDc2MQKMBTplHQ4QClUG0QjQFHHfOra478wTymNBlEt6AlwnTXzGdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

This is the port of linux commit
c6858779f1f5 (mtd: spinand: Remove write_enable_op() in markbad())

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2083e3673cc..d0c9083a5b3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -795,10 +795,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.51.0

