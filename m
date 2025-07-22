Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A706C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A51838D2;
	Tue, 22 Jul 2025 13:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GH9F4Dpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7386F8386B; Tue, 22 Jul 2025 13:42:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FA18388C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP5ze/Kcjf5Z5OklrvXqtgM8GAjEw+ylCnWdS/wd5RVzDnAQATzKruinlVyxpsr3ZjIszDaHNKa6UTF2ifyDkV5EIWI/zqC2ztXzYuNul874Z1yqTed8FAiKiSB3U7QRdIdYhjhSCmwWYT2AmIbSw3TFk5QZShmkv5p1C2OEOTWew3IEupzaxocTpnnRkXi8iV756ghx1MsIPvvnyxMl8JKtlXhcW9MEfNwyU0AiuGWvXvvQ4X3+AiHfT1uPG1GgMMrtwbWfsEo1oVubkv8EJx5/yPxp4b418OkwMhkzEFS/h/3tCjKk6Agi/U/oZyqgAn4W7KQUBbI6aFH+G8EYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGvz5wg0oQsqHq31pmfGtZL3liCwN1f2e3tEYmXA/Fg=;
 b=l9L+xL2WQliDA1ATxYlKDt/graIbcOSmEdg1RgDn46uq0IQfxrXOWbNSW1k9NcvTKXCPziw9MtjqbGDXJqmvOSgmH+1aztqNNdu8nO37IEkyMzVdbnavVe6MbloULrFye/2hMPffKCMf4htn2/4aI3NdaXnsi8HD1+yZNjIk+kqQZd/AVMuecFJEBwzlKA4wtDW2EO55iqjxK/wNX47pzote1kaa+85BfbL4qzg6nT2vVkw+qb9rkY/sPQWC/w28azdGUJ8Bp/5tu6ZnH6huUaDodOy+esFixlU2QoZRIhEA9oLCPtiNu7hFxX8U1cqGvq75NWtkWFNHISHLT5kfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGvz5wg0oQsqHq31pmfGtZL3liCwN1f2e3tEYmXA/Fg=;
 b=GH9F4DpkRTVtvHqYhGELhTgUhlfYmLzU7VGY4CAs/c4ZcMPXpb4teG55ibLyI5auDc+eS/NjY5cO9Nifg/WfG9VyDlfPK2j2Rlig7FOCPDr7PraFok6ZhLssalfTbIAL6bE9wYrgfQ3z/B2RC/WM0IpXXqcpGMSsXGjql+S+KGGJIkM+J5W+hlirMcBszsovWHeL5QBjQBl8O81Xzlae6pq9LbzrggCUB71z0x7+wAjlHYj3/uzahDBGKToeUaO/tRJDvfbupYWSOK4mkaVp0WxUjTaok8pijBacqCMPmv116Rps+qM0+XdPX7eWdu3sCRfXQev+NSxtB02FBgvCGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9908.eurprd08.prod.outlook.com (2603:10a6:20b:562::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:42:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:42:08 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 13/19] mtd: spinand: Remove write_enable_op() in markbad()
Date: Tue, 22 Jul 2025 14:41:29 +0300
Message-ID: <20250722114135.768998-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9908:EE_
X-MS-Office365-Filtering-Correlation-Id: f717ebec-71a6-4865-48b9-08ddc914ca3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8HCabcD/H2NLgLBfxLwHYnA473EadzCzCqHh9RvRF0qA9anczODKsfYQoUlR?=
 =?us-ascii?Q?3xiLKN8xCYQaoVAMpjUNjYLWIxVCS61MGxw5Phchuz0QoCFrODo+KkBW2O6m?=
 =?us-ascii?Q?YrGIN77n4valU3/7JpE3sVRi8qLTDFR/U7QoCEBSGiyoEsXKfJ6YoOQZhuhy?=
 =?us-ascii?Q?E59bFBFdx+iiO1uTezDVbXTq6rb0zFvjSDpffQhFrbz5S6uOj5lf+jDM2v+M?=
 =?us-ascii?Q?kSMu/6b3CEttlvkbFkZVRgwKg8btMwnFEndudKt+3kcgbuNTamGh6askSyBg?=
 =?us-ascii?Q?PxWSVH9/AfNSbmqTVZUuRR/2RoNaCMstzzwH0JDhzWE+WQ9duupsKbRtuTK/?=
 =?us-ascii?Q?dzFSyrV7cn4zbXZk5LHEcXD7I9ZxXSvx8zOirM9jQ3bDS+EDLehcw1SPmiEz?=
 =?us-ascii?Q?9NlF48+9hfBupaVgux5QuOXgOeL1cZwSNZk635Pyl/pMZ7ImAZz/MC98VLou?=
 =?us-ascii?Q?8UiXnhXY8y61juJxAaxmWmBIgUbOEwvJGAKLOn0ZFhHXfNB4Q5sv3YgZy6CI?=
 =?us-ascii?Q?Tra2mULlQ94PfjcOhpSgqDBsminqpQi/xoqtE2z/SA0w/salMfUp6hqsOGiC?=
 =?us-ascii?Q?6a1d81w4jXkBcNM1y/rGU7wssOraxkUapxttBObshR7nSYXByj9bZSZmCcxU?=
 =?us-ascii?Q?DUinGK+SauXcr2ZmVZQqJixtu5xgN7o7yY2b/TgtCb948OxSLUAzXUZd2ekj?=
 =?us-ascii?Q?ncoxglRHYywuYx4+pghMy34cSSZse6ObyKtNv6c3C42tRRrnBbExjIAhGdKH?=
 =?us-ascii?Q?uMYDp0MrzCuejNvoSPb9oJNRJljB9WYjfT07L4isAJC3Caw5LM2C9UzcbKUF?=
 =?us-ascii?Q?ghoS1nk/w0ngNAu15T285i0YZpESsD2bIdtZWG/SvyFmRt90Cfkb5OxFVYVX?=
 =?us-ascii?Q?hkeRSD667Hq3gvM6nlntYNdIgTR44ecbb+9sgW4WMqWY8ARWyCbLWDhZHufI?=
 =?us-ascii?Q?LNsF+nqZW0eiJ9qIza2zT8KBib+KeshPWA3L14l/IEminDFL39FhAMhPdjAj?=
 =?us-ascii?Q?fOR2azqbLl2361tisWiqSXo1rCSNyikcT8cFn+XmlXBhyv50UpLyaxRwRNb6?=
 =?us-ascii?Q?ZK/5g5E4D/7a/FiHJ95+E6oi/QYtGxSiWerLLPLjdM4psefR2ud3ElSZhvuN?=
 =?us-ascii?Q?7jT1AKzb8Daq6W4re7Txf5+kPhrIUEVzA+NN76Nr2l4BdiXTMZiPEI4mw1NO?=
 =?us-ascii?Q?ePrbN+kgc3X6FUyYJZ4Oo5nz1z7GDIC9a2wqoHTfA/pfEd7kyrBZQ6rK34ye?=
 =?us-ascii?Q?AG/j73XVXXxobS4MV97ilYRdRrsucJKvTG5z/MGWbdmMI3RwWRLwgRwZuS2f?=
 =?us-ascii?Q?diamcwR9iK+5QdH+U9aXny5cyHyNwUKzSNl0k9IhiDumMfOhK91nwin291W8?=
 =?us-ascii?Q?s+axTb5S7VBmYviC6o/xmZhFrwG+ElG8JgGJK89jMyMcscUS6Ne0/gjiGKi0?=
 =?us-ascii?Q?swv0gJeJkGolTHzDkEJMuElUIGLV0l/LtZ/NQ4WvSi7nfbmaRDxIo7mAL3bl?=
 =?us-ascii?Q?EWdQrMkBaH0T3sA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3keVvqCQ/04nIOCkWcKVyfGUJRKbUlol5MLoJWSEqIDYj6SYLlV7z/Iv/P+?=
 =?us-ascii?Q?TMomvRQCQ8caaGbzWW5QFLLQCk/loZgyaQRP5Kha7JKhwopY8USRsKAkZ2Dd?=
 =?us-ascii?Q?385Y6LNmNkaeGNOgyFYnR2VPXLbEOA+TdRtimTg8ZEtp9CfzMMQF8Zf2LTCA?=
 =?us-ascii?Q?vDPl/f3cQRa19yS9Bg8Ohw1t7oGHZKW1zl6zGvJOJZrQuuPMzUDLoFVCwAmx?=
 =?us-ascii?Q?QODxur8umJyOG16n3XB53VluLk7wQ5FrVeIq89VJi0tEo5tkDxyRI0IFVDnH?=
 =?us-ascii?Q?0S+2t8IVfaMnG4pyQw2LCN7UAFkJGi73QJPx6i7okrh6sXtZmkjqrC8mWh9Z?=
 =?us-ascii?Q?FJnePRl2ynpbLPigpoF5Lb68uftJPwnuz/31iNgKCYeh8A/midv4YCXiHLKU?=
 =?us-ascii?Q?tspjapN0Q1YQhmZoKyuvFl3kvw0IC/3nj7Hx6w9SylamFnDSinGrk8nY3xw5?=
 =?us-ascii?Q?PoZpqx3EybOjJN6didXbTkTYjbBdCGLQHOmUk9+u//nf3C4cJ7JUgr7FEbap?=
 =?us-ascii?Q?BIyFbCiLNq9cRz804cpjkjyeoXAtwM/6mD1ThgAlehgU4uYx4vuSe1S6ditc?=
 =?us-ascii?Q?yc3EbwaD1zrKeKo7IpulixiYG2uOvhMVYrFbogf1VcrP+0YwG2SG9QR8UVeN?=
 =?us-ascii?Q?VahLHecEfij8vrrG+FkcNODfyhPX5mUh6vH9USU4psVNqkVlttZ0DQ6gmqVg?=
 =?us-ascii?Q?5/Tr6aoLyRCjVHDEZSIsomoZDKsXHrljaUWrq0Z/7mem5J7j5tWjleuXQptC?=
 =?us-ascii?Q?0YyLuGDEZpGME6cFvXGJXZahknmoF5JtX1T25OpOt4xf0I1GfJRkBDqymFcN?=
 =?us-ascii?Q?zBeEHqlnoAUWrHhJJy0rq4XSvnbxbcqcGTScIwNsQoGwuSfMF5Z1iNcAIoKS?=
 =?us-ascii?Q?Va++KxgK08UeEz27yQtJvpzF64KESLdNgwKkNkUj8qsbjXojCaagwx4YAPXD?=
 =?us-ascii?Q?oxwvDbFIHRsZccf+u+wUuQM/Qy4n7qQ0ITVLXXauKgE7NReP8OPqrC2qSMDf?=
 =?us-ascii?Q?7sf1yIumuCu3px1QryXXLOYy4nckkqjAgeeal4+CYOx6xyrjhCjzrl4HQXhz?=
 =?us-ascii?Q?e1lKLJfOvC00hlct0ooQvcR7oe9zNMOjPcwpURbC8Oktl7ZigY21Ts287s5B?=
 =?us-ascii?Q?ntkbZuI+SYLnBgUc3u6I1WU4eaEWk0skV84AdZdKuPMA4AMxd+cf+l7/sXGn?=
 =?us-ascii?Q?T2VVuCmp3ezfq2x6PZDWnz7Yofd4/zf2AMise4KKy8hmvPzB4Q5wx+Zt04Av?=
 =?us-ascii?Q?rkJuqYhe2bV+2JOOrPJbnG7fkx1FCkwZkSzK12wQRxnyRNRffjtU7v4fku+o?=
 =?us-ascii?Q?VSdoV7X6aCRC/bnJXE35P2og9Dj9nJL/4voN5ha7kjUWpo8nnoe1kDOR7x6U?=
 =?us-ascii?Q?Sc+8Izt2inh5pvBbUx4nwonDayAZ2FnUdItqaI9T6pdGjrh6Pk80T+INol7J?=
 =?us-ascii?Q?T6SdIQEWrLBEo+K60WtMeX+IEo2ZdPwbAKVbnVl67LDTg1B1/iws5YU4lOBP?=
 =?us-ascii?Q?P2zuzjEBH3uN9Lf5TbVUoVck6I9YX1Rvu+/2s1579fn5P9NAfXZ32NbEbQPV?=
 =?us-ascii?Q?G5uGdsJ+fe1/uf4cO7w8aMjgo0ZK3Yw5hPvNxvOkIRKWBvw/+wib/h24H9kW?=
 =?us-ascii?Q?KdhMvpGWTzSMEm7WItSf9+c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f717ebec-71a6-4865-48b9-08ddc914ca3e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:42:08.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfmQf1icqpz228VBkBOE3CddLy6QVVkfR+h+4uwQ7/zS64RS5m2rIsrk1td0wZN/1CNetjQ69q0svoaeOsdF27n+w+nvg2KK1D4k6Za2Rgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9908
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

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

This is the port of linux commit c6858779f1f549442ec2fe2f69800d8e9cd904ce
(mtd: spinand: Remove write_enable_op() in markbad())

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0cddf2dd742..9f150eb8585 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -783,10 +783,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.47.2

