Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B16ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF01583E21;
	Wed, 11 Feb 2026 19:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wU1uHGJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A562B83015; Wed, 11 Feb 2026 19:23:26 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6495E83E62
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imBigUXuORdaJbqwfbAUot+7WKOeXYbY4GEaigTD5iRl/NLdZCyOZW54l0OIUGhAXIaB5mbJDeCRaEObnchaF8UM3ijvCmgi8YRO8yykcDlrFpIPkq0PKkhVSReKlX2VrX71wtz3o8bFftW6RIug00TTEi4kRr1bTr8z0MqF8kxGpuBLpaQmDhRoNH7sm0MCwLNYhxvOQIiMGcRabAkzfF6Qo+oOG9CuKhUj2rIsmnb/uUtwg5grPgWZ500SgRh/LbKrbFitysVv2k7m6JR8/VwwAYRjAbqdt1lG/TxHM1SLnwmGEVjbHGwk+xtBltHDvEVcqAPTBODcbUizSO5FYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=kK0NKLgWQ7VSgavOqOnCNQU5bfij7UqTiqml6gDS/MQcysXarE/TVDvLZnVorPcgPPXxlVEnJd8AFau3TwrSJWAJn4UxFLTYr/t5a+8jF7GarSkfyBJ6aJ7yaqoR1fMuE6rVRPjFgDLgc0yS5OobZh4G2uc6AHGuWgmMrrQrvDBkGDXtRCu5yxjVL2UPxN7UaWy6lIv/0lXAVQn9y2teXLcFOxIjx/6zKcLKYarI6NSfuId1fx/8IZGBECs8pWgcR7cWRuVy1NfZ9sCE1X0WdIzZoUpq5CeYILx72FKMldDy94lrSjM7nDks/oRph2nbCB82jb4yv+HRBJPKdQgniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+UA/dnXIikNOMw12c2YZM0SABRB8STpo6hD7eQqcA=;
 b=wU1uHGJnQTaWZGGzugCTv5MzJZnSMGTZgK1cUCq/w8hOfn4Z7bBXgxiUuyMzmukvWU/Q/Xh0Wujsz5sIe5t0mmg86Ea1Dd8/CK9aoDZAr8DAmA9B+OuivKaCI2CeuQXQl1Wj/wSrkr2fDufOkxq0epZE6O70hp8JTYTc4TVs24TP1yvdRb7aG2xprysVB2PRmbAANfluSNlKffcxsfQk3HSQ/IQgaw2CyOHbOB1urNlC5HSeyqft9PxKtOLEOnb4BwxZtVqZ3G25ZvFeAd8V8t+BvCSjJJfFN77wJi2tL7TWQPFVhac4xFbezvX33qTWHvhpFQpyTNbLMMiiu0d68A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:22 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:22 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 10/16] net: airoha-pcs: an7581: sync with linux code a bit
Date: Wed, 11 Feb 2026 21:22:24 +0300
Message-ID: <20260211182230.968921-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a79d86d-caa7-40f8-28a6-08de699aa365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oZ6QllQ2B++33fzAogrVzlQ5j1ukRkUETQC/yLfYgI3oOqn7TyGqHz7bHWkm?=
 =?us-ascii?Q?PxvKYI5A1ha0s2HUWU2Yy/CBEhpucMEjpC0/51VZdWAfXQuNv9yuOnkTg03w?=
 =?us-ascii?Q?X8Y7YZTgUb9oSKfovDjmWO6M6tXt7dzarn/NxHzgxmiFzk+k2A8l3iTqhiYn?=
 =?us-ascii?Q?ltbW59f6sZj8tCRGTZwknOxGA4/S6pmo6LQZ5tQHOgasMnWUt0BeD2p8GFqR?=
 =?us-ascii?Q?O95BIBLhOh+M00C/2B6KnIDaTdgjUr9JLG/C0ZD7LuBArHsOF/OZQ9QyNyoR?=
 =?us-ascii?Q?LoGOm2A+UTkvAOraFNAZQ5ennFwRXkUQOOyn3MEj0eFMMswj8BMFY5GlYd29?=
 =?us-ascii?Q?BnlheFLH4PgT6/RDc/8HGLN5fq2c0d0l4WNB9px4SsnK5dJu0ysQxv0+WpRB?=
 =?us-ascii?Q?boT/2aXMf+wofwgglT0F8GmPQ5aJonrCn/zJauMDpt0BBhFeIOYDrf5ePv/5?=
 =?us-ascii?Q?Skni1Tpod3Pb4zSEPs43/xlOa4QewYznfvS+7fs7uGUeAE7DlUfqndHe73ii?=
 =?us-ascii?Q?TrmKjUS67R1TF5QgNtf27z4f+jN447Qp+79jCO/8GvJKDoYo+pPp/GQre0HM?=
 =?us-ascii?Q?yPCrk/YtDvcGAOFQ6aaL7pkuKASr0JdUM80g/XNSaDstKW4NWLy+/5+u9fnF?=
 =?us-ascii?Q?sgD/9XucXvnveqMjrxEO0u/twd1uoIxnqx4l5lFL92rhzhvUOLOHcw4yg78X?=
 =?us-ascii?Q?iXvl8YDPEUVEdYbjlad5Wtn0JRK7Jf8HifH0yOmbDN7XKEcWHA5l2AQ9JS4o?=
 =?us-ascii?Q?mUr5HRJvqTrRhPtpNbMkdwL4o2jXTz0rdEhQuqz52gJg2yYnid2K5mPz6964?=
 =?us-ascii?Q?e9csds66dbctRxwpKq0PKZD+euTGgv3BDgARK6kpE6urubc0gfjnv4V+hgB+?=
 =?us-ascii?Q?QJx5NfPUKh5z8M8jVFETw9FCg5riGEq6xBURWQC/t1pacCHZBkxrFQtw0qZp?=
 =?us-ascii?Q?YBrbvQbCM0wqzW8jDAEyyQ1wBx6BrB+iV5YsfSZZlE4MTcBHZjemua0YTw54?=
 =?us-ascii?Q?iuJqY8PTt3sxUyuZxv1jeh1U5KY6Zh9ADDZPbo6ddbOF8eSiwOrvVd4xXdOb?=
 =?us-ascii?Q?ZYcSUV008vydxP+pnnaWGTHKT+9BA79mtgxYHt0xPUDVbHvYvkZvxtdAbmGz?=
 =?us-ascii?Q?fWolxgiWHP1SY5gSlRU4MbpDE8MYcJxJi93H8/6V7bd3gyTYxhDIWgoScRxL?=
 =?us-ascii?Q?o37c9QhP3D6f/xaXeykhkxGEyyfGcJzu7tXX2wLWbE/CfaQlYCLvq++vgXGl?=
 =?us-ascii?Q?VQVG0guqs/fH0EdaWB8Q2t6eR5LC9ngYPSutwTGFecucJYldgLBVbQGLHgUe?=
 =?us-ascii?Q?zvc0Ocz6MZt4NOxknO9pU+R3cAvTP4GGqnrf/bBQ8Wk0ytC4D7DmJIqwu215?=
 =?us-ascii?Q?Io6P8idrOb62hhcSgjii+5zMrqysED+budrRDI6UZYPx09yTO73i3VipY/9Z?=
 =?us-ascii?Q?pF2orRmykp0S1nrF5VMGkjj97/U33hgNfWxvAHZJG/m6GZ4WG1r9d5oX/XXv?=
 =?us-ascii?Q?ZLmhDihOQsIPTYl2p/aFfuVvgttjGRyXIugL7IXrf05zfazf5uwQVSrnv3G4?=
 =?us-ascii?Q?oJ7BhIYc1JvabEWaEmXOWaAJc6Bnr4DTPJJTkDNy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QXrq9gxaVq+Cuqxj1Bm0l8sM2g1UOCbZlXj78iY55vvJULYxdUtYBrwyduhg?=
 =?us-ascii?Q?BOzi7OEt7SWyk38EpII/kXsquNk4Cfi7pY7fihrvuumA+OGTsqmZ1Mszahr3?=
 =?us-ascii?Q?vMTX4Jsyo1Bt45/SYGcFDtOxKb4EV63I5JQEnuacNZW1mloEzoIOG2lRRuEC?=
 =?us-ascii?Q?jfKrZjlGqLeKwyVFQpgqXY8GPfACGrWZYEdqAdYNbWgp/3zqMqVlLkpVSltW?=
 =?us-ascii?Q?ms2NMO+5Rq4cMf2z4najQbYyBhJHkaJB83EF1CoOjMVN/4JZNmianS1+E8TH?=
 =?us-ascii?Q?gXMzfq0NjbmpzjR4lWA9LZ8YAYudmI82/ZwSwvHmJEQbbn1f01Z5LE0KMhRx?=
 =?us-ascii?Q?vv3T+DxyPFxSUa/bd+TvXFpqsJqvNAXVPNa1uozrp6ER4AMPYxBu6cJm5cIG?=
 =?us-ascii?Q?Gy2AYfqb86BQ9l4bN+kN742Q9kNQ5vCD10FdF/65I5BC8WbFFJ6y+IS4quXj?=
 =?us-ascii?Q?bdrgWV3nrUmHy1ETpGgvCfAxesyTY8TNfYmysySIobTFuoTEvvNOHHTMm585?=
 =?us-ascii?Q?zeEhERraFN5vw0Us9hVcX7NtNjDQg9cxuSN0ulQNmRkDXUbakGRyxfpTsPOt?=
 =?us-ascii?Q?sDY/Ob97dTFqqtvtIjNvTb3C9xAA9S9J1KG0IktUHAYlKJpBZwHxwSlN95E1?=
 =?us-ascii?Q?2/8afHZUH83X8Z+j/oSG7/pAoln+4Yc00/klDtRAMUvyMexYaIJAmmVifNEu?=
 =?us-ascii?Q?r8WFDJKCUY9xvuQZyihYX0a7ZkwGFXh4Nh8fC4RhY/6J0Zq0UfDoW7JJzILF?=
 =?us-ascii?Q?d1YrJyII+cS7USRX3kW364yfJC4cJK5H6YnjZXrNp4zAZ4VZDZ4h8Z8ZbwLb?=
 =?us-ascii?Q?e9J5Ge7Q4bBC4dqJCSm72aryTuwG0OyxPtERUgrOE2WENICOP9tI1K4p6cNF?=
 =?us-ascii?Q?xc401N4kEPtVES5I1bNCAZuu3xkmfnHJDfJ6D8WieYstS6sD8B8QFccZuV8N?=
 =?us-ascii?Q?AGkAIQqZqlSiRnl/X8hwEce22RdkyGG7q1wevZlupyncJ2SXibjSo0DHx0f2?=
 =?us-ascii?Q?szyDusdBTEAjx84HR6MYofopAMKRVEsvenI3D2+VnfTtmosj8RtLUVwFYJE/?=
 =?us-ascii?Q?G+3aqXk9CWwAphnp/cKWC+ngRdraWpOh8LqYSwicaCGmNfk/t5GDNtlv4Md1?=
 =?us-ascii?Q?7nir2lY/KcFPUTSch9dWvPJFgeYM14FvLvGcDuq55T3XlOoWL1Eiz7D/YqvL?=
 =?us-ascii?Q?y/FwpE8QSUUowTIJFTsL8Qj0PbU7gzT9/uFLFQGp4XFsSdNmTa3e0SrSXSRT?=
 =?us-ascii?Q?Yri95dndKEpT+fBsd+Xi2Gn/ePHHWIhKmGsUTcGUzzGmFzbBSRqBbSKpoH7L?=
 =?us-ascii?Q?IK4LHZhjk7Pxyw9AQRU+e37dt85nnvhqSc+dHUv2TYPJr/okKIxgsRbNr6vX?=
 =?us-ascii?Q?2Yt4UiOvBVEtX4YnJ0qLGv+obtNQUpyuhReqVw1iWCwRRnVBVVFnm+B00N6r?=
 =?us-ascii?Q?GvduPfFVW6jN5jns6mdAc4rpuHdvYIpYv+FQh2cximHjqEOLnDJTq+bGvrYg?=
 =?us-ascii?Q?GChC4xI5/T8bLVKtjgGcXcJgu1KVtPFBg6MhvFwmlidkOxXoNnFc4Xricc/J?=
 =?us-ascii?Q?R3C8ORLlNmLaPzVRLVP9L8QZvNhpt4ggQAGBPw004q93czgRyhNzF0hZJioe?=
 =?us-ascii?Q?5zAw/9obQbWDgz4cH9NjqnH2WVznYK3r/p+ZrzXmflsvQ29kffZeNeH0UTbq?=
 =?us-ascii?Q?ozWTzHBPNWctKe4w6T6NIOqafQVc/LnQXr2DLoplxlgGFWCPx/1djgIkzdoq?=
 =?us-ascii?Q?HI29QTZqakOg8XDOk/1xrzgtDltecZw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a79d86d-caa7-40f8-28a6-08de699aa365
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:22.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd/b0J/EmewZaI61QVHwJWWCYVN2IJ5nBAtJtq/bCa4bt1/ssk/w60D/PEqlsFwz7NF0edtHvcoUqEIdYb5lOf0TSntStwi9Pb64T+MZUEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

based on linux kernel patches from
https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-stable/
created by Christian Marangi <ansuelsmth@gmail.com>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/pcs-airoha-common.c | 16 ++++++++++++++++
 drivers/net/airoha/pcs-airoha.h        |  4 ++++
 drivers/net/airoha/pcs-an7581.c        |  8 +++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha/pcs-airoha-common.c b/drivers/net/airoha/pcs-airoha-common.c
index 16f0dac2951..1263092fcdd 100644
--- a/drivers/net/airoha/pcs-airoha-common.c
+++ b/drivers/net/airoha/pcs-airoha-common.c
@@ -775,6 +775,22 @@ static int airoha_pcs_probe(struct udevice *dev)
 
 	priv->xfi_rst = devm_reset_control_get_optional(dev, "xfi");
 
+	/* For Ethernet PCS, read the AN7581 SoC revision to check if
+	 * manual rx calibration is needed. This is only limited to
+	 * any SoC revision before E2.
+	 */
+	if (device_is_compatible(dev, "airoha,an7581-pcs-eth") &&
+	    priv->data->port_type == AIROHA_PCS_ETH) {
+		u32 val;
+
+		ret = regmap_read(priv->scu, AIROHA_SCU_PDIDR, &val);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(AIROHA_SCU_PRODUCT_ID, val) < 0x2)
+			priv->manual_rx_calib = true;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/airoha/pcs-airoha.h b/drivers/net/airoha/pcs-airoha.h
index f9e325511af..714d2ebe520 100644
--- a/drivers/net/airoha/pcs-airoha.h
+++ b/drivers/net/airoha/pcs-airoha.h
@@ -9,6 +9,8 @@
 #include <reset.h>
 
 /* SCU*/
+#define AIROHA_SCU_PDIDR			0x5c
+#define   AIROHA_SCU_PRODUCT_ID			GENMASK(15, 0)
 #define AIROHA_SCU_WAN_CONF			0x70
 #define   AIROHA_SCU_ETH_MAC_SEL		BIT(24)
 #define   AIROHA_SCU_ETH_MAC_SEL_XFI		FIELD_PREP_CONST(AIROHA_SCU_ETH_MAC_SEL, 0x0)
@@ -1173,6 +1175,8 @@ struct airoha_pcs_priv {
 
 	struct reset_ctl *xfi_rst;
 	struct reset_ctl_bulk rsts;
+
+	bool manual_rx_calib;
 };
 
 struct airoha_pcs_match_data {
diff --git a/drivers/net/airoha/pcs-an7581.c b/drivers/net/airoha/pcs-an7581.c
index a95eb8d54d1..746ff55d72f 100644
--- a/drivers/net/airoha/pcs-an7581.c
+++ b/drivers/net/airoha/pcs-an7581.c
@@ -1261,7 +1261,7 @@ static int an7581_pcs_phya_bringup(struct airoha_pcs_priv *priv,
 	udelay(100);
 
 retry_calibration:
-	an7581_pcs_cdr_reset(priv, interface, true);
+	an7581_pcs_cdr_reset(priv, interface, priv->manual_rx_calib);
 
 	/* Global reset clear */
 	regmap_update_bits(priv->xfi_pma, AIROHA_PCS_PMA_SW_RST_SET,
@@ -1300,6 +1300,12 @@ retry_calibration:
 
 	an7581_pcs_cdr_reset(priv, interface, false);
 
+	/* Manual RX calibration is required only for SoC before E2
+	 * revision. E2+ SoC autocalibrate RX and only CDR reset is needed.
+	 */
+	if (!priv->manual_rx_calib)
+		return 0;
+
 	/* It was discovered that after a global reset and auto mode gets
 	 * actually enabled, the fl_out from calibration might change and
 	 * might deviates a lot from the expected value it was calibrated for.
-- 
2.51.0

