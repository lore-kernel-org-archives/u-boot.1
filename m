Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8021DCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF938422F;
	Fri, 10 Oct 2025 13:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Hix202vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84898422F; Fri, 10 Oct 2025 13:58:54 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B3283E92
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZUUUeedBmvkw1uQJaqcitpN0PqDX5fr36HNNzgq7/aNT6sE2zGhOxrm/P7TBwBDZTG4ZPMFPnr6bxKRqp39fWFsZgbmdVFUsGk16lJzXYGiTgxMGzqqvZTm2UDrRJnTYH0COljnYN9GQis4oFaQtBc5kZkP5qasSu+BBJFV2zQUlTYm/ISaKuSUQw0b1USyjSn7eDil9XDiBrngG+EUpWY0hYziFZaejZBtVd88hsx8vG5AyaDhOBc30E9r83boMBYjuQxzE8oqBBDZ5nf4u3DepE3N/4JxlWQ/dspGm0FhH8DkBqjqSVW0UHnaE9jS74l+LjGYXN8EXVlanQkqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc9l6nVCvagQL9DT8x2UfB/cUGUjHGkXh9YamiB+750=;
 b=lOcmxj6TlLrPLD+Uowe35lfs08cBKggZRCLQuj5gQJsd7qh/P8X495HaIxBBkiJ7HP1xcQb9cXxFl7UiXDpdYpdklSdhNeoEZ2Jyaam4XpLMCIfMpomYoLnUByVQlD1T4R43Bjn1/48/XIpG5gpKAIeJ73sLvNZluIVoJikPGR4qry7h4jY4LrNo/wsqOSTBs/mwGi/VI9uHBSN1WjWFQ18XM9W8Ns+Y9OzYFr81ONmG6MtkcWHVCMm/SgrpWCuQ1zOsYzP8oEf6/lzdfYO8QMDkiMxlCdctIIZuOa5VDpbbMptD538DU7VSKuL1O3wWEMgv2fiDiSzfXXAbEbrp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc9l6nVCvagQL9DT8x2UfB/cUGUjHGkXh9YamiB+750=;
 b=Hix202vrGYm84/jE0NGoSgm2Pfs2osbTEEzZbAHgkctxxgtK7ZVsVc1LoixkYJ46Ms+9l8LhEx3cDmAZBTRcWR1wkzFOWzmqkAFWtCnqnXiqs9Q0vMX4a2jrZCKrNWYwPff5Yn2TsTy6p9Gm+GwOpQzLZDoQDF+0NypgO3EIHDAx4K6amif9XNKDVRbOfiNdA5agB1Qr6h7L/pKhF0T98vcrfxObs8691cICf6L30uMn6L7INaRllHzpUawmRTQRRTvzNFZecwfP0kszyDzP9LLaQjsMgKIeGQUPwu+7D5X0Uz0Jf54uU62quN9V2+e422FJTDwqU9JP8QJzwVdNww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:51 +0000
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
Subject: [PATCH RESEND v7 13/24] mtd: spinand: Remove write_enable_op() in
 markbad()
Date: Fri, 10 Oct 2025 14:58:14 +0300
Message-ID: <20251010115825.1531775-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e6dd88-cd8d-41e1-49e4-08de07f46108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aWwQftVZOCzglchli0SjC/uDDqsQ/3euDDvxnVE7iH+UaT0MAjkPq/Z5jxb1?=
 =?us-ascii?Q?NDUX/W5QFludehx4g0AfIakWfYJLBx7wgOSKvEGpyneboKevkO4n0GTixhet?=
 =?us-ascii?Q?yiDQVP6a0moQ9jHyaRCO0jrY8KcGlTgxeB4oXDl1i7ok2u12/ACL38V2nH3t?=
 =?us-ascii?Q?yVDGTFtJ5atot06KQHSwOq2330kqnDzlX5EIUnVPawNUhVihvD8y+/SRZIUb?=
 =?us-ascii?Q?D78NrTcfbVEjvltpwH5VPuTysepj1jn3SLiLU51aeEqyepxNIYneGfT8UnZc?=
 =?us-ascii?Q?v7uLlCtABzp+4ncFsTWH4gZQhdMcoaU72mRfeB7ZUZ2pwWWHijSoqZ0JDsfl?=
 =?us-ascii?Q?z2x6SEo2H/wRqRxDAPwqnmlknDLIsbQ3yG8uvxkG/7/2sbjDWzlWf/WA1K7Y?=
 =?us-ascii?Q?HKqlj/7IdOR/yeK2nDFIku7j9/YjV+m82pSeME4H5THgwKhpZjk74vmGIYBH?=
 =?us-ascii?Q?feazgw5574N3HdSrqS7vhUEcJ9UUWGpeA9JhaTcOVcNJX/NH84h0HHCH/EKU?=
 =?us-ascii?Q?kvNgbUQtaakAHMw5aOnIBjzEoOYHHgxGOhZVS0kRhDDlIlg7zlwPyimbggbJ?=
 =?us-ascii?Q?EWDRGkIZiG8hKRlZ3qiq0uvO+GVFO4GpRjjbkpysLCbtpX8m0fsVx+GxCB2L?=
 =?us-ascii?Q?CdPXyiMr1MvVnPyIBzNVc5lTC91/On7eM6Op3FZ5P6uo1HLFMDKgNTTL4LB8?=
 =?us-ascii?Q?nzD6QQeL/25Ydva8eLo56WRU7ym2rwPjMhE4vxB109XmnvuQH/v4RYtH9QgY?=
 =?us-ascii?Q?z+ZXXC57WmzatMt5kxOybsSlPZHY9k++7H3GdaFH77vENdJp29y3yJChmR/i?=
 =?us-ascii?Q?sEFJOLszyIlMdVwKfLSjQqfp9Plk6IVtEvGz1VJVYPhjo9O6qP152QpDtF7+?=
 =?us-ascii?Q?X4UyrkF+aJtAha0nr7emO9m7+NVsgJdXm0ncHYdxyQAMeZCR1nEkCmHq0Dj3?=
 =?us-ascii?Q?KrXqArZoLQP7XRzWliOdmzCkb5jLjzT59xjOREBl3hVwZGGj8HsLYbkQTRB3?=
 =?us-ascii?Q?uT72XFqFzJeOCGgvY+weAPuoEA9uw3ISIGJStcky/ESCxL/XluY+wEAiR5sH?=
 =?us-ascii?Q?/4qfBrvaAwEXCOYmcXanst9pNB/SSGCHXLYHaVS780xcvn4XbwFcEC3Jw/qg?=
 =?us-ascii?Q?gc/8crzijRV4/gVON5w/tAUtqzCqXiQUEAw2GGDBkQQiYZE/vU+TyQtw1srG?=
 =?us-ascii?Q?Uap9ORhEVGNcv8rkVrU8Luv+9+WqglvZLZh+KvK4440KDCvLsZx/VcWzoRDF?=
 =?us-ascii?Q?DcxnpEx0StiQCeHZyzdgMvTwV45w2elbvk1e8VTXPsxwzugNDqGO8alLFOMA?=
 =?us-ascii?Q?TIXg7Riu5c/Ph3EatYwOWYHEjXc3GMKNJ9+RfLYsnnDl54cYa33+LuK6Cho5?=
 =?us-ascii?Q?IPAL7RZSra6rlu8deLCrHwN8QnHV7mip5tc0pHcIzoz84OYEiJHeKfcIj7E4?=
 =?us-ascii?Q?JHKwEzcjPhk0U8Nq2hcROZMFvqutdLKAkewB+LWtrjwxb9CBuqjsmnSZxeHy?=
 =?us-ascii?Q?EMVRa5RMjKx07p2BEYexQk2TwnMz+Yf5jIoPk5ZcRynFZM7CQgHONwWfEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O/Yvx9TRn4x+2GcQ7nH1Ae7dCpEQQKIiqmNLAToaib2mGuuzzChnCvqiZpSB?=
 =?us-ascii?Q?q0j7g83ouRGzv5JfGCn17F9FfcN7a0IVJaKbUiTQ455z9wMu67XXANuWYlPW?=
 =?us-ascii?Q?3fsXYgObHWCKOh/9v5Av09J7spS6VxNoClLoISJA5wyAiM18vA1IBfSqw7Ro?=
 =?us-ascii?Q?bVGnY+UvI4vH1mlYh6M3xWT3JypA8jdc+XQ/vxkjQZUTtXgk6EIg6u7+BxRY?=
 =?us-ascii?Q?W/1dAwOo4RBbtXwQzg744ENLwbvr6t4EmedpTN4jz7T0QZQWloCgOUrHqvjl?=
 =?us-ascii?Q?GBvs8OQGPROQdzbDc5o4uI6B7siHQAK5ghBYmnfseKZLI5QO4yU7OaGE52va?=
 =?us-ascii?Q?UWHzOIMYW6eiR3E72ED1ayJ1Xni+ipROvp+GtqV2XhdsTnWtDqxz3dbkjU1h?=
 =?us-ascii?Q?jE4s5EUEaWOR5FhX3yorBJrbIr0D4obHaqkPbE4br5FmMEZ/FHIhZWfATAHE?=
 =?us-ascii?Q?u5fZI98O5H08LBraQaFyW03Vu7I8T/tOsxeWAVc5Pce6nhx5kc78oZbCK6OQ?=
 =?us-ascii?Q?jdSh/AF5S1yMOxSQQzjJzVyHo+ymT9ln0FOVDqI+Y8ZgOATxm81ZnijZ9kth?=
 =?us-ascii?Q?YK74DrZavy0YO8vU7FULIYOql3Wm5N/hPcpLR6lKb4xe6ZkZYi74Y9QU5wS7?=
 =?us-ascii?Q?8HDMdlVvGPi/GgvUOmRpid4PigyHP8KEKhxutV6uVZIb1sOSofVahtLfvJLc?=
 =?us-ascii?Q?8Nf4J/XPOB7DX0klpnCqvC40HxckTDT5msHm601lmlKh2RfoDZDBeGDergvA?=
 =?us-ascii?Q?bkYnD5cCmg16VbgDSnvD7FyXle6Ko0p17it5yLudWiGhvSfqpuql7QPbqTmP?=
 =?us-ascii?Q?tbBKiyVPyv2x/GZEu3ZS3sDvuKCiVIj4fp9PN2mU62wfvBAjGB07i0SEFkXN?=
 =?us-ascii?Q?Z+8Z9uU8fQMdtFnspVl+8W2bJT5vGaKUYJ78DSaNMsQWBTCz8XJZ3IJRUHMw?=
 =?us-ascii?Q?PXsjuWjWtDaLUsFnWFZI7IRkICwKsQXwsi3mGYpJ3YH9vBiYxEDPpEfm8n86?=
 =?us-ascii?Q?23gTAUV0FiC3QQWt+PeXfxZc7PImCZnHr3yRhHCyPWQ2wDPMnB42aikwVR65?=
 =?us-ascii?Q?TyCgQ1JJRVRbD971bUzsZazV0VOhwCamsJL7C3bNnaCJjjODyOB2iJObGani?=
 =?us-ascii?Q?HR5QJsJx7RbWI63YPUTlctfTYdcmUHU/epo7x7oCGNiakycyv8Rd4mdCQDej?=
 =?us-ascii?Q?iZ4f8xdYJtfWjBuCdWtG9pZbGUh7NcQn4qPL25PnNL5kMGd1JymQsbKH45sZ?=
 =?us-ascii?Q?UjHEpAfnEQJ3FenRfFGx7BA3o/VUzh+cdgFZl0BbZIwN5l1qqHB0JCrE/PXy?=
 =?us-ascii?Q?eL6js7gl/LZhcnyr4goVTzmyoSCJX0MvRmIgXF3rFq4UdnSt3s5PWq0cK3zR?=
 =?us-ascii?Q?dy+eCZs/nqcYx79pVX9hjfTnvG0it9/gP+iUij9cdWcTb3X/jGGjDYC0rNTH?=
 =?us-ascii?Q?SwJ3P37+hhWlHw/fBqsNfmvZ2RrWJ4vfYMjJ6w15aTFPvqZ8rVTi2wfU+wFn?=
 =?us-ascii?Q?Yd4vUhM4c6igg7Gfsa25hLXtgqE3KXUCEX5lXZ8fZO56a0tVp+DAuaD16RO8?=
 =?us-ascii?Q?ZeIJAnU6KMlYVTQTKLq+SNE1sjFNU+/cYnD57lN3NXu4e/FTktzDU3C2zY8B?=
 =?us-ascii?Q?Va5pVL2RIoXXJSBu9mhWEhA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e6dd88-cd8d-41e1-49e4-08de07f46108
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:51.6960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QdzKlb2yU4iA5Cf/UG5ealflq9Ne14nLJ0/64YmafFaQaktliNn4gxtTB9AgJ/0/HGhAG8/bTK/kx90xnpU6zBilVRt5km6YM/uBcW4eBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

