Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A488C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CEC885CC;
	Thu, 27 Jun 2024 13:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ktVlPFzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3FC9885B8; Thu, 27 Jun 2024 13:36:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFF08858C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzRXs8KTTSqenchogz8BTnnu6djR00NvRi8f9TE9Zxq2fM7ndTELKulrNQeMYmOhwrPmudR6uC+vujubzbpuLaGWAxU/RhIZWFxwGBTfhpMZYI6fiuatGCEVTU95IkWo2EZp3v3vYIifYSH5raqw0mGAXA20bFmUPN7U81drNbmDogW73SAvRSPZ4VOwvX6JS06qP3GHyJyO7NBYePWS1nwetIqwvXI07R7jiFQP4slkKe5pdNSUkDtxRH/y9/qekCsbxmEnQSESWsQvD1LWAmzBKprObQF0yuOYqf/Nkref0wIlDPCBwwbQlHpftTBZ0oyGD6cRtZRP/Py7Iwy9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ful18EmvDhp2X9veMW00DNfyyONycwhMsW96mngoUoI=;
 b=Nxk1/tOlxNTUduIGfWeVeS9u/zHLPRcaWdakdTVUdQbt3dcOfDbAvg4M1kLA5pAKdSKZq/8y5nhHPAxuwvh6+JNxjkWnbG7nXD2opWGy5YdPXh4RhdJDoL+Sx/w0UL35yQLTmPGriUVJcdVxZpx/3qiyjos+GqnNQ1+9RudJPmWG3kwNKEQwIVhAUUVw0dNoFC5lSWs21VZMOpLV6X+X0tW6aI2HuqOjSgU/BvX96IxV9heOZ5PPftdd8MXs7aQwxkb45fwTK6bu5pl3kb8urb7sWL2/fIsIKHqEKE3qLjBr/vAU3kdy++5IRhZfJ4JmIjz8zbg2gqIW94ZnHZxoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ful18EmvDhp2X9veMW00DNfyyONycwhMsW96mngoUoI=;
 b=ktVlPFzov4NWNICNoex9hol6lParY2DPv2EAXQfUWgyKK5F3xjj0u8/4bp8dD9qDVz/bqKPGcQfZKdTGkOxHiVU6wCEUGU4JIvu44luYAphY4xnwpShxZ35DpBZdMs69Z5PSomJ26NF9t2t8GAIb3tx+biw1Bo8yY1pv3PJjM5DMyksZUQDXVMwIJUCQRy+YdqYQnziQgJ5z7olYtUKMKipqBI7/bmysKgZQc6o6EI9Jl4dsAjsQRViXxbkyV+qV/Mf2fI8QJU4UncJhYT22/gBKYkj1SQv4pXrIa0fvdRdyKp123IhjgAOgLOjme9siE87r7gk9+Jb3MkM8F7TwVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6140.eurprd08.prod.outlook.com (2603:10a6:10:20a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:35:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:35:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 3/3] dm: mmc: fix driver rebinding in the case of dtb reloading
Date: Thu, 27 Jun 2024 14:35:46 +0300
Message-ID: <20240627113546.100333-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bacafc-211c-4a5e-a45f-08dc969d4fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qlFm0y81SkS5RA9m0nJfDiVlHi8jNZLguplPHSVqsuVyB3nI72KHq1e+i/Po?=
 =?us-ascii?Q?6tL9/qqsmCaRWGMetCScKnZW6DW2RtiEooQjKtqzj8rLuXEcI7DUz0NWrWAj?=
 =?us-ascii?Q?Ct2BPltVuE/BjAoY29yhi1f3CFDLUldmLYAtctb5s8rdsln6ZY2feeooBf+h?=
 =?us-ascii?Q?WvhID+GdRaR73o99lKSKuatdLf6EjQm8MhTaJmqhSMXwVVeE3hVCDE01eXvz?=
 =?us-ascii?Q?7zozmC036HAVOFUZeKeBSI+KhBQ8sAdZwtwv0u+fkY8jy/oYQJG1UKVKYr69?=
 =?us-ascii?Q?pt2Ue4lLRlNaYQl2P8BLMKNOCPYQoUI2f8yqwdfp1hrLj4qTJ8B+lcM0dkTS?=
 =?us-ascii?Q?xwO8SSs+keT4N7Xz9SUHwLIc6RdYSsfP5gGvHkX1Zo/GOFo9LuTrmSqcg5dM?=
 =?us-ascii?Q?CgqsWMG9MiE1feC6+XX/ciB8Q6zbKAi7+GKMX2nc8H/qo/Ql+XL5+Clp+S3A?=
 =?us-ascii?Q?nc/hok9qvm6QUMySgTdBL3KeZ5MdILZMuoqAUzqKs+Krk1ImotfGm5EglbeR?=
 =?us-ascii?Q?6vRbRCrWF9pY92jPu33s5CCX6Jstc0W/EH6dLrI5tuFGwnsai7kmJRnJ3PAK?=
 =?us-ascii?Q?IIPAV9DjMcxGXCxPdbxoyuXRpzdfGrq2Hf6HCgKn9AOE9Cfa21gn2hrpZtCn?=
 =?us-ascii?Q?4XeuJyXrgsU4yd/nj5AjoseynsBCV8Lc0VMmekon9ts7C+lk19a9tmkbvJ3d?=
 =?us-ascii?Q?NzOOwuJe83ldNc9+Ty+O88Q1Atu1pvMTlagr56y4p0Sb75TGnGTRn6yuDv3T?=
 =?us-ascii?Q?JsviZn3t8YeZEWIlenEHYimO3shw83SG291vlvceK7DMNLzrJg3YIry9VCd1?=
 =?us-ascii?Q?D33zzCQ+tT6QVAD/Fe4tDN/l3H60yh3ZZGM74VsUzWnRHbdg50K1oqg2nQi9?=
 =?us-ascii?Q?oOeuaRmTTOjPPFFcQnqN4TDERJozJ+GkjHobycyEsFNTVLSBZc3mE3VxMpcP?=
 =?us-ascii?Q?kgxY+MUavyBPgqyKwPbsDG/qHLoKIcNETiIgcFieDlZHlilrYbsVEjllCcG7?=
 =?us-ascii?Q?UYGHkA9/U+JKEl67hrxgMn7qlif0i1MEaVgfr9S0sdlS8z9wwkC0i9fmLK5g?=
 =?us-ascii?Q?p6Ruk0ZfYjlUgY/dhmxDgBjUyQRnutEX+T9o6EfSZUEGkNM8tys7/hKzUwtH?=
 =?us-ascii?Q?0HfldkKseSSQAxnOrP3Ly726j92lMNFkgtlb/LE1Hs5lhmiBrb/qComplmcO?=
 =?us-ascii?Q?F3Yb+LQqIh51X9R0c2v0B0ikEbntRO9eQl9OJi+8jEPY9IW4es0VynQ7hPhy?=
 =?us-ascii?Q?j3HsYI04si5JeixstIbWmgFv2CnR4C+03Us0iX9JPJbEjdhZ47geoSjupEix?=
 =?us-ascii?Q?t+K3XmfWrhZsOAeYqfsbFtNv3UrYKgZiKSltwsuNwL+PVLxi7tzncLVlz0/n?=
 =?us-ascii?Q?7FZ6GmmbpIxOoIdVDPq0Uq6FuJoYHAO4buvnVGitmKv6HUgwG/BAUQKPMoPY?=
 =?us-ascii?Q?K+RM8ZiS6GQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fxz/TyNmPb3GxtEX5GLwmQ6zxPbELOs4Zox+x/vTZgHQRmcDdOef8JdOk/Sf?=
 =?us-ascii?Q?G6lZclRY55ZHVwlOJZwnyLZoQB72xipN2uGdHkwxiz9qw1JbEGjlOHrio1sy?=
 =?us-ascii?Q?LZlp5a00xDOnmz4koF+KytbBFEtoBNh05kUqnojD2fpJSc1G2aiEKd7MuMdH?=
 =?us-ascii?Q?mGU6o1AF9yBqhEVnwewK6uHcAxkXba8hV6OKg15jeXGs34rgNXJN3aLwwdn3?=
 =?us-ascii?Q?DW2zWc3XHG0yuSaAXwAf6kX3MXgh4Jzwo+qz8d6y2nIHzSC0gGVWhQvvfExt?=
 =?us-ascii?Q?hBnvpmQSyAsWjD0UW8OE33Dotgse2GDDCjDmWurjaNfOTMaCqZVQvn6i8Pbu?=
 =?us-ascii?Q?yjYYhv0p7m7ji1k6NqIO713VIn/ip2q0ib/3E59U68FNpPtrDphrzDJGYB5x?=
 =?us-ascii?Q?oApB2+PCBzG02OH595zPu8nOSGuogiMFG9KFWbo0pHEN97couIx3kV7QgVnz?=
 =?us-ascii?Q?pb4SNI5/7+DpHk5ZYpha6qe8tlwkOlgZJf4IDBgIoqtG8OT6KJfyF1u1aRgA?=
 =?us-ascii?Q?GxRyxm2kRUUH5bZ9efE7knJZmKwTQcfNhE4KrDGljnc7ibvk7D7KNlJ5x00y?=
 =?us-ascii?Q?uruaGnIFYWiVrgdYr48Bdc5rivCXWDmm2gAcGQI3s6jNta0rkXYpq/xuUBlw?=
 =?us-ascii?Q?VtqraotJp6Y64kiBAaK43YxDRmP0XFlpaIy2oZ6HOds3a9YCtvfVHj+lBuab?=
 =?us-ascii?Q?FeM3VZHWYZv6lfJdsTvD/4keRmvG3psED2fR+pG06pY3IGJdLeaQFn5ruzr9?=
 =?us-ascii?Q?Py1qRUTr1QgBEQiptiDanaXA85bGRBCkFDaB6PzgMIWNj//8EAwl5wnGX2wS?=
 =?us-ascii?Q?u9kt9evq3Ef7MQGMEoTMQ5lHjj4q/ZyK3iTfZPZBGre3q/Bi7fqfrhdxq9Mo?=
 =?us-ascii?Q?v01qUynSywnKtM7tSgxjs2E89NqWnuWcAtaHrRctGnY8bdGXi0KSAyAhsdY9?=
 =?us-ascii?Q?91PcHH08rRhHfqSkzzZzldMgsOjOZvBqmbagn1QpjhpTDT6j/gXug2GYxNLJ?=
 =?us-ascii?Q?kz/cdTGMc4x9+8nJh9srPGuS5EDKQIYyAFfJcwCKN6WGLW76cdt+v26LQbTu?=
 =?us-ascii?Q?pBsoyQgTM/2nwJAiXfWS1c6GcRcA5Gbwg/CBCb/y7DaZFjzktPTOxGKwVSVE?=
 =?us-ascii?Q?3erau+VttfoeA+QF/a1WHa3+7XE/SzT7RTw/SwpdVZqZDhi4sOlLhk0+Cg7U?=
 =?us-ascii?Q?/AD48LHoJun1RpJ+FSrPpC6H5nzwbnF97ZIsokiIjoYWgJXHQsC6gsjOjd1H?=
 =?us-ascii?Q?9VZAiZDRMk+FgsG5VpWnz5gXX3sa3nZ6ToLbgCa/t8uC4+3L0h9lXKnIRm9P?=
 =?us-ascii?Q?EpZPv4cEew8No1ZUA/2r5imDyUDEH4SUmH/hrUJrvbD++Lwm7wl9ADuXYeDJ?=
 =?us-ascii?Q?qlBmnhLiaUfu9Q0WzKqiKCYhRdS9tlqiTPno/LDiUjd4B2BZ/demx2qg/ldO?=
 =?us-ascii?Q?Z+1FhoaEsPMtxk1QLQlGnYgNp4NYIgmZ25S6Xhsj8Q6ZR+2zMEb3i75OUHkD?=
 =?us-ascii?Q?Ka2H181ZK8xsfNFTPHPuJeO8M01/aqYIFY1GaHAmT7tDHxiiitgog4/Q/RA9?=
 =?us-ascii?Q?LT1qXFevGIpVIpdbAISse6VbPT98D5I9RkhzUkF5htG0J+HzrHrVHrpcf8/k?=
 =?us-ascii?Q?VvKqw5IQ1cZJiBVOT7yCZPA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bacafc-211c-4a5e-a45f-08dc969d4fa8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:35:57.1892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnDN9lorQUGtHeQRI6Qvifs56ni3gEtLXmi5r1HAOM8FHajDuwZrkF0v9nXOFA4ioRC0KK3dMFOpPdAUd8K/ttK8K9ybAab0AqSN1e0j/9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6140
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

Rebinding of the mmc driver causes reregistration of block device.
Thus second mmc device appears and the first becomes broken.

Fix an issue by using already registered block device instead of
registering a new one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mmc/mmc-uclass.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 24170c59ecc..403d20dad53 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -420,11 +420,17 @@ int mmc_bind(struct udevice *dev, struct mmc *mmc, const struct mmc_config *cfg)
 	/* Use the fixed index with aliases node's index */
 	debug("%s: alias devnum=%d\n", __func__, dev_seq(dev));
 
-	ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
-				 dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
-	if (ret) {
-		debug("Cannot create block device\n");
-		return ret;
+#if CONFIG_IS_ENABLED(MULTI_DTB_FIT_RESCAN)
+	device_find_first_child_by_uclass(dev, UCLASS_BLK, &bdev);
+	if (!bdev)
+#endif
+	{
+		ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
+					 dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
+		if (ret) {
+			debug("Cannot create block device\n");
+			return ret;
+		}
 	}
 	bdesc = dev_get_uclass_plat(bdev);
 	mmc->cfg = cfg;
-- 
2.43.0

