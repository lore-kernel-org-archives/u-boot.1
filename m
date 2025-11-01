Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A2CCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363E083BC9;
	Sat,  1 Nov 2025 01:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="t3Ok6QSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D92383B91; Sat,  1 Nov 2025 01:45:26 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6F983B86
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rj3x7E4tJXdmRGBdoE4qLEaxFvobmin54VF9RU/eR94vLrGRb+jQ2CkaFu0o3c86H8zf8cY+rf+UNRCUdw7104RaVBJDVpn2Oj6hr+9y/Un6NM1VE9hZdssfX0YG7Sp3ZIzWkixeG1iaaUEi11NaWWcLwzuyc9174TQiInKTAldZ/Px9wHOLdx10fbvsl7DfNxot90nyFT5hY4ftOo7lJufRGmKYULQPsVa41KPvscyXVWlrhNm7e1PK7L0eEhBJqKYMy4erwuXZHT2Rcy0BjSibg+CrCwdpW5LxP9FKxIxVYejapyGyXix4wMLqp2iIekgkACqq3QvreBQ1PMC2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzPRIbSZpQuV3XPrzSE5K2EHbbA6iDR3PoZyIfqKSeE=;
 b=iSmwS6EwMUMq5CR70lHfEtQbJNxOMfrzyVzFZ/ufI6SKT0yCc1/kaUwjfyKSVjJ1YaF4gJoXi9yko7xN43/ADcY6woV+Z4RowzPtbz8rHB2nsbIdmDrhcame1ijvV80dM8jWspIY72glJk6tCPgnIf4bj5mdpSZtuaXxriSXTBud6On43VKHXJeQovs6kNHm1zmmpN0eI+Mq2nJvkEfCcf9+N/wFlFfwfyVfg+T6HhKUaN/9KIdAgYsm4vAY+6d2df/C099TE9OvLbrghVpDmgbDNO+ZzAuOW2hC2h3EP39kgaK/Du7rqrAKHxlqVO0NZP7mLfP/lWf+xtLOCiqk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzPRIbSZpQuV3XPrzSE5K2EHbbA6iDR3PoZyIfqKSeE=;
 b=t3Ok6QSSdnKxlQePmvc/TKtReK8ag12gbzk0z2601f0mUsDggESmSrL0XbLblg2UplBi9J1tIJdXQBuI+jNPU1gepzMQYcHMB3/2GmvL7BeZqOUkY1nxBUAczELpoN/Xq9+aEDg8SANYZ3Xeod3201TQEzcrs7LyMeGZn/7bGgJcTyKV1SYy/C68HSvBQzf30DoKKmU8b6Dxd7f/lef3Lghn3DpiAombwrKgmoazcDmCJzXeMdKkkx+v89hUxM+9kuvQDwq+adwUJgWNdfCG6Uzt5u46C+qjnSE2JYrozU4K4sbkyQ50Ha93aE7CZYCiG/bUB5ufzlg7JoTn7F76qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9258.eurprd08.prod.outlook.com (2603:10a6:102:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 09/19] reset: airoha: unify code using SCU regmap helper
Date: Sat,  1 Nov 2025 03:44:53 +0300
Message-ID: <20251101004503.2379529-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: bab23e03-4905-4f75-1949-08de18dff028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgRQ0kEkIac0cStIkUPzOZdasvhrtIN1K5c+Kr8eATrqGfiEaTfeLoeBzaNc?=
 =?us-ascii?Q?m+XjU9pBIUb+68xHDV0UdzYqsHGT7kOOeU2dQ5Psc5+CrGXdibMs0h3QNV04?=
 =?us-ascii?Q?xqnA6u4Dmfc5LgOuMn3C4AniiAP9lViEE14ExhBSXYxpJykPLbwfy2/+CY1P?=
 =?us-ascii?Q?q3DNoHBUfSqWhAUXvgE4jsbFnaNqb4bbi7BxGx/b/C7k6KcJWFdi5PV3MG3A?=
 =?us-ascii?Q?bll5LLE0G/qcYkCzTzJP8pQ6HRTe0iKW5jL8G2SO0622EY45I8Io0spuhTpF?=
 =?us-ascii?Q?V4QDuHODmfR+WSxDFieRQtGk06ZV97mJ4Iy6uDtAnyUauG/VGmMnXivSs0it?=
 =?us-ascii?Q?13CHAEBEKXsQib1qzyBxiKRHNJHdOYsgZ7+4S79oMZcaduE1H9/M6ATjvfoU?=
 =?us-ascii?Q?VuZZrCtF3WayMXOZ2sNs2Sh8FYqOrDkG2HBfxzzjnTTk3nq8ugreOukE2g9A?=
 =?us-ascii?Q?TtjuSHmBqRUbYJVh5T91PZ0LjksD3zvJKPtyzQTKjaiLGU15ByYhM25/l2sM?=
 =?us-ascii?Q?jpH24pDYa0qZ4rp9KHGTYxCjKXHwJx2sgvgOeZrrfWVEjb1hRnX2BXpLqvR2?=
 =?us-ascii?Q?b5B+U21MpHoPtJhDHKAWIDawDHdrpNP1lzTclmUGVKwElirHx8VZvyGtdU38?=
 =?us-ascii?Q?I/003zQMXaICzHM5R9SvlIJuXMQFf0WEgulK8FZyBeVlK1mFPN00ZSTnDa+Z?=
 =?us-ascii?Q?Ft180QdBaDXaMafu/rFC4Em3OGDuorVTNHFzkClWNYn5FWoltiImgq5BGdcH?=
 =?us-ascii?Q?sc6/FqShT06ryi6xU/l2A1ibCjfoydv/O0prHG32tqUbvKqcQbu2K2dBIbTh?=
 =?us-ascii?Q?SYfVAMS/6l7MOLFiTu76n7a0WI2t8yeVTf5g3OJDLLXIFGoBshP4fTBCkAoC?=
 =?us-ascii?Q?og2HHMPhoMMprXa8/q1if1Yw39eI0YGucfQCefVez9F0GDi+/VTNLy52myh/?=
 =?us-ascii?Q?eUji1houVoHdEJ2UV3aa9HFbI/APnJuFY/1eSNE5OIoFZJt3NwFo0CggoE3J?=
 =?us-ascii?Q?0bwzNQZN+GZHrTbgrzUp6WV6FUS88/Ho15hjKEDW/EpnddOGQkuI3nkS0DzL?=
 =?us-ascii?Q?GmULFByivU+tjIvUYQGQaGUtQibi5AxyFtW8S66Q8JPWlNXr9FG+t4Ki2AbF?=
 =?us-ascii?Q?1dkZHL2m6u4JcActgQl3C9G7oMUIXRHFvtV1x9iYQHLBbgsGADBG0i7eewst?=
 =?us-ascii?Q?Ti3wCoCXg+1CI08TkTczsDSPbUAjVF36oVpwTTlRv3gr2JNShv2cBT0d+3FL?=
 =?us-ascii?Q?EeH6bfl9YvxFOROBylBSTNzygMCsG/qpp850oPLn+v2h6ZwGcDBbeb5qY1jP?=
 =?us-ascii?Q?TUMbaE9/9DI9P60dZSKPdEQwmJeV3RmMDvyj3RDzOMTuiKGSMblfY0UdkwEh?=
 =?us-ascii?Q?jsRMMwEy5mnx6QrvR3V04JaQEL/+RPCZS7jO8BfT19pilqePkEhrqI2Oj5lU?=
 =?us-ascii?Q?zRq+NUD5kInd2Z3B3+49dxMc8LJ5hrkPp19A2/Srcz8o2bcTcOFIJ3cJC5fo?=
 =?us-ascii?Q?KdcwB5Fz/R5IUGHZBlibUPXVCalDJkm5YWMP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VRvfpQfdvUOkz3TNCGzXrCcl0D+R7wfhqG37XXym8k+2dmJ9cN/Sm6RHNtD?=
 =?us-ascii?Q?swGt92j6NHHbrYiFbcxDLkxKP0U7BpaicpVMtAdnyq5tvpJmdD+T9y7rxuUa?=
 =?us-ascii?Q?plDUQVVYhhJvaak+ta1z4M/Z1OYKH7dywciYqQOJLEYa6MbO2mIvL4tPK7E+?=
 =?us-ascii?Q?mIzgHYxGYy1MGGRXlO3rWvlUDreGQk8b3qi9EpQuJRXa1TdvoamYLYLb0nyz?=
 =?us-ascii?Q?zGGRwdxsmL8QN2ph7EZC/gFUsniKWKimE7n9c2yxErtikrSYc5Xj6hhXWXl8?=
 =?us-ascii?Q?SI7hQecLKNQX3gvAPoVR7iwNMBYolaNe8kkWi4KyLc68q/OH54bHpthakB2v?=
 =?us-ascii?Q?FlBU43IPY/0T9Th6fZti9d00lwSnHpKY8KBSNljXo32UNXSYBUea0M0kIhhx?=
 =?us-ascii?Q?pGZPk7YKvefz3jyXVTb62UfSmpPiOa7k9UgORMu0Yk53KZ6JZ/l0VsuxFAKy?=
 =?us-ascii?Q?wNvSD7G4Ychyi2DdNZdiWAn3K0odOGddM5Le68xBARQ3ezO1DJBXLoZDMI9T?=
 =?us-ascii?Q?Adu7UxzKWRCyN2cfC4F1wgdcj7CwP174unhd5K1ZiUYJxzUbp0pFiKLJSCHN?=
 =?us-ascii?Q?zUhUgj/Ss0XN245YWmLzzI+awjVSrCMhqXdoJVN00vcnEv00ownXx+ZJ7FDu?=
 =?us-ascii?Q?3pTjmwmR0h/2M9LevoDrrGHzFKIznZqs8Re48Bgs0HLXkBH15++muYtiYnnH?=
 =?us-ascii?Q?CccAQhMJchDGQEVWpbu6l2LYYsy7gn6N140hSIeFpQ5hssnrs1Fze5R6OoWY?=
 =?us-ascii?Q?9Zg+gbzuo8e7Tgoj/XsOF91YS89Z3Nf7m5x8DcDQeKIEf9WecA21quycwWCc?=
 =?us-ascii?Q?tPqVy3JBVVL+vRZfdoT+DYZh1prn0gCYNbdejbIyWPhj4SNbHGm0ZPtMyAYu?=
 =?us-ascii?Q?DnmX65yunokhL9dfOywO/0PHY4o6vIbhhD6xh5eobcvvL4vExdz+H64xeeLS?=
 =?us-ascii?Q?ZAFbRV/0fYisQXOq4ID9SKRBRAFpyzU76Pd/vOk9YDuHvrtBylcbjA/1er/Y?=
 =?us-ascii?Q?vCOzbMZaKw832QiZs0VlKoB8h/KwbbApXR2A1dDthqYJO96YqhJga1aW+Ohh?=
 =?us-ascii?Q?8I2dBzHVPVW5KvG9lgKl+orbFFPjmgQVUTUgaEEhG3w3OsL3y7DbQJYNEt72?=
 =?us-ascii?Q?p77PsVuye+HGGc29ZAiel9yhSXCiS9vgW5wbygKFCVvafw9OJfn3Vyixilj7?=
 =?us-ascii?Q?WWeBWzA5D2nJZ5oPkVh9eJnp1RtO8pvj/+x9Im3jekCF639kTVODSINAr3ou?=
 =?us-ascii?Q?rJBDtGh7/RSfqeFMaXD9Xk14YrJGjcL0MvAFswNd+RjfTShtlDVggVnvbPB8?=
 =?us-ascii?Q?Gk84kBL4AhwyuD6pyWrnHIE4+Rt5sbbKA0oDrChIwUXyHziNwEVdWKv4z7Hb?=
 =?us-ascii?Q?mKIwIaaz56Exy7K0wu9LzlxK+zHMBNp7yVVK0C7Dl4Jule13FIkt98/srFb0?=
 =?us-ascii?Q?mKmLHBzvgKPBK/e1Gz/oN+d92VuW/SgnczXQN3/+Qc9nPKG5VQAwqOQWQpQ+?=
 =?us-ascii?Q?E6Tm83hQcA6QOerZPsl5LoytsyL0b3NS96oe0Y9SZou6R6W8tpjebI467XM9?=
 =?us-ascii?Q?SS5uW5zfL2Bk0uFyiQmM9rqYjQck6Vp9qJJFkLIylaVmwmvGkerISRxIBrpL?=
 =?us-ascii?Q?hYyWI0iGwkfi8G36k6JTcB4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bab23e03-4905-4f75-1949-08de18dff028
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:22.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjoNr0tAyMVenGhJ4tTMwSaQG8rQZ0IBQ3zKhYTJlveaUU3gRBOfVxYB0bwCr399JRtpWLn27q0MvPywUdSKqHc7Qmhp+VOMqylZrlh3PX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9258
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

This patch unify probing code using airoha SCU regmap helper, thus a
common function can be used instead of an7581/an7583 specific ones.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/reset/reset-airoha.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-airoha.c b/drivers/reset/reset-airoha.c
index a618bf62b4d..58b868d9855 100644
--- a/drivers/reset/reset-airoha.c
+++ b/drivers/reset/reset-airoha.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <reset-uclass.h>
 #include <regmap.h>
+#include <asm/arch/scu-regmap.h>
 
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
@@ -153,11 +154,10 @@ static struct reset_ops airoha_reset_ops = {
 static int airoha_reset_probe(struct udevice *dev)
 {
 	struct airoha_reset_priv *priv = dev_get_priv(dev);
-	int ret;
 
-	ret = regmap_init_mem(dev_ofnode(dev), &priv->map);
-	if (ret)
-		return ret;
+	priv->map = airoha_get_scu_regmap();
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
 
 	priv->bank_ofs = en7581_rst_ofs;
 	priv->idx_map = en7581_rst_map;
-- 
2.51.0

