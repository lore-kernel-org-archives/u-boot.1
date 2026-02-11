Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E684ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2997983E85;
	Wed, 11 Feb 2026 19:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="AI9xNEBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB4183E70; Wed, 11 Feb 2026 19:23:49 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DD183EAC
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1TX47tcbgL06qhpNEsSVk87x93E4+EyugH0oKnZFp7GPkh7aw5wSFV2JDuIrFas02+UuABExv0szeHa4ji/Afjozng5OU7oOdLUg3xcEg7CkS8S3MrvXn70bjhRvrHtZHbYb3HrhfT5DZm5HMJ+VrQwzpUPZwo9vqhjH71maz2nXAkuFCf6P/1iQMMWJOfdB3iZT2BkZldPis95ZNu3Lv7r31uhn9FyNKb7MfAL/QLiZzhO3GjP1AU2DDSYS9xZcwend4tG5Trix8o3CJSVG9QL1AUqutFwjiFoqud0n1J5XKcMZp/+uUJMMiYSYXo+GqFwb+9snBbyxsypuNJ7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSMDHddy9Qu77SupXvAM5v2zTzE9R4pzJfwYApU8aCE=;
 b=VQqe1h5OV08mnN5dO0Gu8KMQvWsYap17EfSkjnYRxP3saMyIke+RRf8iJddSeJNZgf/wvb9C0LboFulLlq76UGEQN5paiRU1vTrwHK5hrE3WPL/m9zS1ZqL6MAOsEV6ZnKgVzqyvfI1hm/jGNfcJc9+97wC5aRwNIdX4ecuPrDoaEw1JvwpKWLUyZJ22jBJFI1jXn+tVVO2t3QRksf62evVzpo1+CqzbabpiLWQp83hvzll1u7BPW06CArF9jLuV3Boj64bxshD7i/GBptXmNzX9WjPW+V28Vqq1/PQUWI0zh5dMK77nk4ETnR1wzrIcXaPJ0fw8M0XirG+8y+X8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSMDHddy9Qu77SupXvAM5v2zTzE9R4pzJfwYApU8aCE=;
 b=AI9xNEBqEUFIYbbhfsMZb5WWRowpdL384x09cJxxTkcwuhSE+Oi0JUZXvD/mVEA4IjipjskoCv/Tbv9NWxK0TOBwcUDNqq0LbhsZIaBM1g8t+s+BlE4V2c6Md0B/MznYLAVBd0MCjVQ11+T2sc53qnOr5OXYtSIEGSfI+aYP5oTg5Yd2yTVPXqttMvR6OZYlFNv4MOob+Taqr+lL+dcCdiPwSSxJybbUl8F52yPB9HHxz8n0tVAX2Pw9EC/dVQ0Cv6fZtZj1iQt0/lSJg2NDk7FlNbVVYdu+jXPeVyqh9U3kbvSK5RaIb+CGpPGzmzYMexxyva4qMddkr41IN4yMOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB11040.eurprd08.prod.outlook.com (2603:10a6:102:46f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:44 +0000
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
Subject: [PATCH v2 16/16] net: airoha: use mt7531 mdio for GDM1
Date: Wed, 11 Feb 2026 21:22:30 +0300
Message-ID: <20260211182230.968921-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB11040:EE_
X-MS-Office365-Filtering-Correlation-Id: a463909f-9ff6-4fe3-a262-08de699ab07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5c5YS0RUsbjSHpdW+ZbUuYPD18QMM7Fjl7WCfm9pDRd9pBCvvqxHIkqsLk5x?=
 =?us-ascii?Q?uo+BWCXM2umHEl6vrcnNi8nWViSn3Jnz9AguWc9E1wQK49ay+34nAkjsZaaW?=
 =?us-ascii?Q?NtkB089deFQd71auBKL3LNxTGNOIi6taMb/+N1iRTw8xjpx/HklfKJrRnlzC?=
 =?us-ascii?Q?OSxhi7NpGQTAv/K+3DKDuGJlT25yDMjFqGaE+vnlSqBmWfZMUPF3EB7m9dYZ?=
 =?us-ascii?Q?q2MbJcpn5jryD/uhLe136VHrWD1JzMkY+yt3yh61rutYVQ1pb5SrcA0d04MY?=
 =?us-ascii?Q?yHBzQr/Aq/zQkmEWKGFy/RlPNG6Z5fWlVLFq/NFP4NSctLp1L4Hgy7rUvA5m?=
 =?us-ascii?Q?sBYrqmhe573JgHfTtzAZ6F066Xc5ivSQ02mplmHUOGNN27Acf5FW90Ygfw/P?=
 =?us-ascii?Q?fYOc+XkC3kE5h8beW0wD5gE5xtsjVu7FX/D9ZkWMjS6scrmNcETz/q6r6q2o?=
 =?us-ascii?Q?eQOxqHYjiEGxdIj+JPKsQ3diinFSNNvBBj33ZJ5DgHbz5G7EYRPvZiKwTCjd?=
 =?us-ascii?Q?6O36paBEukZiMLubaegHFCnPVp4FceIL2vw5zG2hJu0UuQEFTD1hn1v8wnSi?=
 =?us-ascii?Q?y/4Rw89wkFwoiyF5tkaVV/DtXmtNpYq6dGECjYNg56+XQhRKTsMhXkTvV7+W?=
 =?us-ascii?Q?oWVxiblNGqNCWLJIgKaTZ3mOutWEzIS/ZPj9nMtAuVdR36yHjIrhWotcXTkQ?=
 =?us-ascii?Q?P3Se/4KlBeysMHqnP94rfCxorf3125Pq5GgM7jBrAJyLWHWDie9No+1RfyRZ?=
 =?us-ascii?Q?o1rcMxKZpJg2dw1+uOrlZfKI0ZE7Q/zlVvuAKID0oaUf7ag3MWLBKPF8O6ND?=
 =?us-ascii?Q?wP/y/NSTOtPxKt8U3ThHGiPdtfsSaYycDm5KTOOT4kzPi35NB1lHplhDvXa+?=
 =?us-ascii?Q?yq5NjPCUFq5TEp5lMnOmS4Pc6Bd8bLR31WeSEjtT+8pua9aadJ7qXTROrCwS?=
 =?us-ascii?Q?9bYOwlZxvtvWQeds3DVTeHsTjPzUJ48M2zFiCfL/Dy+6+M/LyxV4suM+ENCn?=
 =?us-ascii?Q?EtaFYuHQ861y2YGKT3orgBQbyW1guYetxQDMCHoFLArCE97pjaMCkffoDQ/U?=
 =?us-ascii?Q?tUxIb7X1h261RsR6kg7H5ItiV3azb8EaXq2mP/nuRtapDj4IGfdvIXhSzusY?=
 =?us-ascii?Q?JW7rO/emgdwK0aC+Z4mCmBlM50GnaYr6XOJZZ125lyfxnwcjnBl0EwHo914e?=
 =?us-ascii?Q?iqJFki0zGy8fRMjl7ywLJQDAp/H85xwuVx0sSfs18uh336DDWlmMZ78HR0yi?=
 =?us-ascii?Q?sySUrJBo4UhlCB62CYcZ/TZ5KVYAujEOGC9Ljb/RTfBSgnKrcXtXBll39vPK?=
 =?us-ascii?Q?mkMcQZ4GThzlRngJXGnj2I8Pyp+O1uJxH0Gxzxb23kY6ZjvShTTfThgkRdze?=
 =?us-ascii?Q?HxvR8pd6iM45MPROCO7aHzGhKgKMzeLtE+qrm4FrAjJodan/1wUYZFLnPM1/?=
 =?us-ascii?Q?I4xiSOC7icKszVwMhKTz8LRjPFQdNdugXEnkrCQPbk+RbYW/vakLysARX5Ur?=
 =?us-ascii?Q?77TUH7N3qy29Yh9Z5uQ8OIpAgF6Pldz1oxsVkQtnJHnvEXp6zqZe4ENRYmxl?=
 =?us-ascii?Q?99iB1+EQUniji3KpUzSc1TyX9d06j5+2tFoy7w9CamA5b3ftmN9IxTM6sDyV?=
 =?us-ascii?Q?IcLhDk8DjPgOP0AVKCDdoug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NGJ8paASX6qPi3QEqKl/+HudqxIt4FUGq7D0zZhbpX+U3k1VLftrR7AfmUo0?=
 =?us-ascii?Q?7NOmOD/JuMknWTfhGgGIoUEum69sYL1bxjM7L1z3oP3GJglDgWBrkmA5uPI9?=
 =?us-ascii?Q?POf86GiFfoVUwnljVsDGoytM+5KzSFErG48jvBLdWokpyKNCzQfONlT9Naqf?=
 =?us-ascii?Q?TGjzSvSRPv4DYpBfVZoaWh0uMEcE07eRya3oqiBdpDklZvMeO0GluQY8JsjR?=
 =?us-ascii?Q?l9IToMZ4pac3+4be5IhK8bGGetApFewKtAtDwrqUa3l69/7/9Lz+RrrgdLI6?=
 =?us-ascii?Q?Uv5RUDeYbaLtl1EXt61zToezekXzuzMnBJZ7ErYdt9kv3SJWdIl24t2Np0QQ?=
 =?us-ascii?Q?1ttoUTLfuUzib+gy8cmoxPR0zRZFFzQVO3HHMU+kVqvDxH07H6eQoVKjZxte?=
 =?us-ascii?Q?f0RugtQ7Bs0zzVi24+JAMbITC/V9LvTSSdOaB1Nq1/cTYuQkYKMi/ZhV6iFv?=
 =?us-ascii?Q?O3asDG5C65bc4kzl9p88Dzl4auXoVQNn8ICpAgnOAXgiJH5ddhsqn3t4RP+N?=
 =?us-ascii?Q?9xcN4FCSDiyL7ze0sQMOFN2YOizXKkD4IHFG6znARfIP1xPZKl/eEpAwPCmE?=
 =?us-ascii?Q?zWObgFXDh9DN5Y1JOvaHVK9seR16VubLSogyaK4teDjvqqriKFX1A2VRtMWU?=
 =?us-ascii?Q?fBTbNamUJ/DAQ6ijHvwfmyINt8CSz+/qxLolZKcByysBJYnzARWyDkZy9vqH?=
 =?us-ascii?Q?OsyBWiHphfGoLbM5OXUxRtQt6+1kE0HSqsovAS/Mim6qDYLGBp9aveWpwYLZ?=
 =?us-ascii?Q?LTaNyCnMPVKy+UJBJiLbhApCL/rSz5V7DiVcwJlt5CKmpdN1wRHXdCY39Hk6?=
 =?us-ascii?Q?yA9mR7ttl7kvoMaOUGTSDrX3yhWgdxM2wdY2HNAa1VEnC1c+IIWseMj55qk5?=
 =?us-ascii?Q?22Mf2b8dY/yCtd4D6lpYBP+Src4yDcejWkxhMhcMUHic7CqwNDeBiBvTNN1x?=
 =?us-ascii?Q?/RJu0KDW4kjXlAPGrl3Nj3OO/NanZeYYg9OeCSY62ve39Xllj8jxsoPujQ97?=
 =?us-ascii?Q?q4FY51nX6wdHEKplhafE9yyPua1wRBrcdk9kR2krK8e3IAwtK/sRKyls5wcd?=
 =?us-ascii?Q?u10aprib4aPOFPcRqVtcz3iOZN3GmP94AXZHGrIn8zGxw4c4PaPKXcHRuHKb?=
 =?us-ascii?Q?YjRL20zf4w4rtvyADOB3ITgD3T9+REkZcdMPhf2Dutpqn3aOtTvOshdv4wc5?=
 =?us-ascii?Q?YEDAXF+Rzu71Yu+SjqZcwmLKYZLTQWNSej2WptENm0Z9zP5j2PXc+mAGhhRt?=
 =?us-ascii?Q?PpNVYMKQP9l4LyhxcgIfjm5xs2T/NlXz72qOoIZC59p80NX3jsxHRt1yYZ13?=
 =?us-ascii?Q?DOH7KRLXhrsMNm26LymYd4E1m8knR5F2Ji9d5pYeVa0/zdVyTqlKVSHouwjL?=
 =?us-ascii?Q?bE9LLb5nvTeBiBoibfinyF+WhlAHCNKBVXU2VK5v9Ak4LcgGRkbgpY7IY6OO?=
 =?us-ascii?Q?R+3Xk3WKI75zdzG8fPDSTamE3QXtCJV/PcfKG0H4x7DwtOqYzCcUukakfD03?=
 =?us-ascii?Q?o9eAgTeeOt7yL2YwjgbgVIVj/7KahZK2exyDjgzgpqdMQm00zPtp8dFZvRNv?=
 =?us-ascii?Q?4boQhbT+/WUhhhH8Z4NWFJHeo9ORmwI5ZtQFg7FshHMFUiywjcHoHmgWLEXw?=
 =?us-ascii?Q?X6BCP+dM6KnRLh3Zd1bNRlhHu/S4Uxvi4FkD1afoHHgn0eFdffWDWyFJb9qd?=
 =?us-ascii?Q?1WVi28oHINB/IWyFtcT4RHZYMhuKcCMUzV6gXkk8QkgBoqObmIuOSORIFaZd?=
 =?us-ascii?Q?Ky41vjxcKnplT+uaxqPUTXgLSgO7TPo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a463909f-9ff6-4fe3-a262-08de699ab07c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:44.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a78o0xGXdqnE09CZdGcujLK4F9BEs+QE8qerZBm3h4gRUT8dqrDO6WAJiDaa/YNBn5qUAYwg0/L+HOH20kgzi9EjOVJHVse9IBw1TEGuVXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11040
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

Current code just bind mt7531 mdio with it's driver, so mdio device may
not be probed and hense not usable.

This patch:
 * Forces probing of mt7531 mdio for GDM1 port
 * Renames the mt7531 mdio bus interface to 'mt7531-mdio'. We may have
   multiple available MDIO, so the name 'mdio' isn't descriptive enough.
 * Sets mdio bus for the GDM port device

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index a0c1786c628..f60405392b6 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
+#include <eth_phy.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -334,6 +335,7 @@ struct airoha_gdm_port {
 struct airoha_eth {
 	void __iomem *fe_regs;
 	void __iomem *switch_regs;
+	struct udevice *switch_mdio_dev;
 
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
@@ -933,6 +935,8 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct mdio_perdev_priv *pdata;
+	struct mii_dev *mdio_bus;
 	int ret;
 
 	port->qdma = &eth->qdma[0];
@@ -941,6 +945,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	mdio_bus = NULL;
 	if (port->id > 1) {
 #if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
@@ -948,11 +953,24 @@ static int airoha_eth_port_probe(struct udevice *dev)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+		if (port->phydev)
+			mdio_bus = port->phydev->bus;
 #else
 		return -EINVAL;
 #endif
+	} else {
+		if (eth->switch_mdio_dev &&
+		    !device_probe(eth->switch_mdio_dev)) {
+			pdata = dev_get_uclass_priv(eth->switch_mdio_dev);
+			mdio_bus = pdata->mii_bus;
+		}
 	}
 
+#ifdef CONFIG_DM_ETH_PHY
+	if (!IS_ERR_OR_NULL(mdio_bus))
+		eth_phy_set_mdio_bus(dev, mdio_bus);
+#endif
+
 	return 0;
 }
 
@@ -1197,9 +1215,9 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 static int airoha_eth_bind(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	struct airoha_eth *eth = dev_get_priv(dev);
 	ofnode switch_node, mdio_node;
-	struct udevice *mdio_dev;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Force Probe as we set the Main ETH driver as misc
@@ -1223,8 +1241,8 @@ static int airoha_eth_bind(struct udevice *dev)
 		return 0;
 	}
 
-	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
-					 mdio_node, &mdio_dev);
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mt7531-mdio",
+					 mdio_node, &eth->switch_mdio_dev);
 	if (ret)
 		debug("Warning: failed to bind mdio controller\n");
 
-- 
2.51.0

