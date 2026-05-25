Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76147CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0611C846AA;
	Mon, 25 May 2026 04:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ujy9xvND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31B0846DE; Mon, 25 May 2026 04:49:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AD8846A7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6HNxGwNWAPTLGwC/t1yJqYY7KsINbiMpjivaME0SO2vxsGE1CEYE+CmBvwkoVE37EoVLpwkVEXzrShWkxWpOYx3C2YyhhrZL6+lsH5S6ntwhmBO05WgxzC948LanvDDRtMx4XV8R1un9rMMkR+LyGhQBXsFzwAzNr8ITJIj9bJD3kDAM25y5vn/9ZPqzGlB8NerVH07SRYYiS3OtksFbomLC63bdokHYWiQ8DAd/g5dzWxKf73Kf4JZA5OPiilw8BxAY3UlPE6dCDIcYGTdNZHvNmT+lcrQ5rY+5X2wbMoyQfe7HAEsaN+sCAKFDLfuP1ob6+eSsvshbe7qPW6ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9OW1f+4NMCVaSuvXAuynTun4HYP88MVL3+V2fBvcHE=;
 b=bIRVWqIz0tAB7MUJl3rN/0eCKGuLvQCG+tQ5zcqwi+fhujXH5H5jbU5BkcXZv/DfeRfDKFYp/tg6bUOugvJgSHf+bb/WLI/JS/3ektPfqvk6l1BY6Ea/JarJ5ejN8IY1qIXs4Nht0+GKyUXwKsIMgbu54WZ7RQxo+aYgI0GMPiQNCIez5+67slDSTgYGaqxwruXVNE+kif0tEzOVAmezOUiAhUJJy9o7A1qDxgR8V5/IPTcFgaGvuFaWCsN80QSVgE/UOrQVNrJsU0IFoxNdeg3+0ymDOwyWYHzw2zAwNeeYiiWKK7vE6RXUNnliGqI03M57gnBTDIN04gKxarPA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9OW1f+4NMCVaSuvXAuynTun4HYP88MVL3+V2fBvcHE=;
 b=Ujy9xvNDuUjCK0l2xPtgaKqQAhJaod3KYrmIvjl5WxSCXPTO1QE8qZd0s1Q/66zvcCqLObc2GbrV/z3ZuvKMNjakvsJD7h+tvEqMwm/jVykpodr+e58rJGuv3udngBYeFgY6gJYM/doJxj49WZ6IN7MsOvO3XG1cLTOVD81lgOoTCIk7aCkh5SeVkPsrgE3K6srJw3LawfMk5sL2JENx2oucH8t18Jz744nUt5rQiRsLeQoGj4qa0/vpUZ8JjlesGsV4CQEOf6njbBx5d6pVBECj9aDsawRqf2S6G43seFeJQDrGv4rRDJuOzr7ciXTTK/8G0KbV79VeAWgvSYlM8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV1PR04MB9054.eurprd04.prod.outlook.com (2603:10a6:150:1d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:49:24 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:49:24 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net, ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au, trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] gpio: nx: Use dev_remap_addr()
Date: Mon, 25 May 2026 12:06:01 +0800
Message-ID: <20260525040602.2368579-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV1PR04MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c15d741-b361-4421-7740-08deba083b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: B1ovRtKx2PW9b6zqHTDXdF+zpBeiUemw+D308PDDgOgrsTThCu6a9DKBzrKN+O81ZLrOoQa0RNFONgzDdXE63YfT09FnnYBVxYOrV56tnOOafXitpZyL6TvDvF1skdwHre/w76i5AUZd+Nm7DnGyslFjicwn+iYLAGCSL0qpS5J0Cy/3Z2z6mLDaAjMMvjdPsMRG/83NP1KEmqNqBKpLW01urQSybYXRKARqPmN2Vm3S156Us2KMYPiBV/j4s0EMGwe9NCnV6JNMd3EBaJblywO5sIsndJJ3EHxauEnH5KvJ8pIhAMLtgKljmtqVzON8FxHMUeQePhCqXrr+ujGoj3xhL00Z0AQNJfuz6leZ7EkWLJSsj3+0o5b3F7WcvQH6uBFxD9DLKG9290TtD2o+CfhmEcl/DqM3lpHWPvT11X6vA0+nh8FLGvRx0/zRwQSqPTRj7oTXFrXNgyhJeuu5UllHn7yM6aykrGk+Sdh5J1bj7Y/zXxENRQWCz+ZOjJwuF7tah41rRKMyedlHh+pwSu0vSKx9t4gq1PynG1NLJ4kDRVzUe0X4fMa3IDYf0TwbgHcvrJiASWLaKFYPFjfMxp+lW/khYoTxbDe1YJSMw0v8eibe8FyhnDqLPg6UCSrTuqQvraEqOyrZ5WCBt8druMMBmpD3eOxW7wPB5PcLICX5pNBc0eXzyM23NhdmZMtD7dCj2luIhi8gL+uFtdR81RcNeLXvcMNUFReZUQgTT6xBEw28jKwQOe0X8+EFSe00
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQrX4adix2P8xf2mg/wk4/iT0UDTR0cFk0OFPjcEkD12AZKFmKRD6gkU7FBa?=
 =?us-ascii?Q?LwuV6G6avEQ7gswzBEsPDBKYVhfF3OVvHw9e4jwHzs7lb+Zs+7Bo/WzwtZXu?=
 =?us-ascii?Q?D1eb4Gzy7ZBuFYM305/q5aq3KyATnvZaKnUVIfab92aXvadnF/XSt27GbD3O?=
 =?us-ascii?Q?UDZ+SGxqfz4OHjhGuLSNdGgcb48klC5sMmppv1HD043elwqA8majLJlHL/t9?=
 =?us-ascii?Q?sYxtOFzXjdlMkDiTKwGkcby/KtezH/BnTe/JwiJ1szAB0IbFaWTsA9rg58mV?=
 =?us-ascii?Q?UKqK+c39D3PyRDrOZIY2j8MW/q7MgVKI5DMaydP61YeXo6y5hV16TRSY4gFS?=
 =?us-ascii?Q?3kKiCNqgddw2JRF9ucfCCdxZ0O+Xupv0Toib3bXwi5HMp9TagcySYrqyvBUa?=
 =?us-ascii?Q?1EvI4bRrGROhIUrqWes9Xg4ptsuUH3popnvvMqN2UdUiNKSC0tveKoqWsep9?=
 =?us-ascii?Q?PenTspxPwAHKJLmIOfW0M4TFKwYYhQW/oq6cRUm/9tzoQjWZGrTLAym8EwGN?=
 =?us-ascii?Q?5zDiZThvnDqtut/3ms07gmr4YCRIgGcqCdElYGvT4gNhID+N+ugYbUJzN5/Y?=
 =?us-ascii?Q?qrA9G4/iSye8kDWYnE5XGB4KS5XAJxjm8uwHRIY8M3t4AmBDbpdidwE5GPWr?=
 =?us-ascii?Q?wQysgAme5t9bvpSxjV0avcm+isRDuSeUvpUQKVdm80n7BN13WrJ5EVg3WJno?=
 =?us-ascii?Q?dHAmgz6U2+jtByQZN29YdD9CdnvuXI0rbmjMNqQap3GIWiGD1hKRn3dndaDS?=
 =?us-ascii?Q?hn77wXitp8gowjJWEapZqnmsqIgIl9xv/Y9X0tWp0GD2FCGyhLmG50FvZHG+?=
 =?us-ascii?Q?lB/Vg+GRMfnvIwPHALt4Bympi/m1SpwydPSTB494We2Vot/gJlxd2VzQ69UU?=
 =?us-ascii?Q?OeUFBD0ve7mzMkQNnp+lNPgJIHbp9RKWvaOO5VwUahdr/hXd41vDOf5djtq6?=
 =?us-ascii?Q?bjR1Wwt/GH1zhClIygl3nmbDHLG+Pnq4COK3QB+feAJKuOK/sqZWvJwl+ijS?=
 =?us-ascii?Q?zqix+wv8cM1tzfxiYPqC5kaHa+SK3/U1EMxSgYUWgTSsYlDxOo7ygOF02YTf?=
 =?us-ascii?Q?Br80DbZRXdl9dSbKLBM6ZPgltwOp7OSox8n2SaHCUunSSdxO2Dq8FgxBNJRa?=
 =?us-ascii?Q?7FxGqcCCb2wjQrEga9xztoOHXS+UjsB65aV8x48t/u7DiYxePnaVQT0Pqkib?=
 =?us-ascii?Q?TTTSm4GTHd46XFN/TUS6dXvw3W81+lMdN+xkDei3+daqE2Yd5IV+wd41/Jv7?=
 =?us-ascii?Q?GTqNJf7r5uExj7z+j7G442o1qiMAE8focd79H6kBFQASRfyj7QBWc7BUVeti?=
 =?us-ascii?Q?+JhMOindYdqvgiDgABN+SkyWq8oN9dsnXO9iNmGlHAvcX3m2dIse/YBG+jh0?=
 =?us-ascii?Q?zptXQiJ1sX4mD1Wh8NBxOXDl49RSZwJLcqtdkUIXAmRmr+riqQLlSagT6l2Z?=
 =?us-ascii?Q?OZF7vkEl8ER0lhxCrJg5ddskJGwMSrHPGds6SgAJtu1xYkau/d7UChaB1Va5?=
 =?us-ascii?Q?52sjzoX3z0IFvZ1NoY7LVbOww1EXbWrSnN+hrD3+Sug/HUPmk/PzbW7uKDfm?=
 =?us-ascii?Q?/jMm4atDf2rQ9TaefL8NpRXri2X22Ro3ha2DF8LP3T1rGU7cpobpfI4uKtVT?=
 =?us-ascii?Q?Weqi79fVLGS4Q3XvjiuAEvh/sxFtLp4SVEFgYCI7Af3GD95twqD6oyJzrYBS?=
 =?us-ascii?Q?9Qp5IPI2JKau+BpEzicJ0WX+ko0j2wHla7MjFMSuJknG8NJdCAtLzEbG3dza?=
 =?us-ascii?Q?a1GAHZnHyg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c15d741-b361-4421-7740-08deba083b0a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:49:24.8689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6fkYv9rxyjeTTJYAXO5J5vUOR//Zbonr+xCGAmF9uOEOUMZ2XJnw+89P3oVM8SyD0qZ3yEnDwY96nFfnZv17Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9054
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

Use dev_remap_addr() to simplify code.

dev_remap_addr() does same thing as dev_read_addr() + map_physmem(). And
it supports both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

Also add error handling logic.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/nx_gpio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/nx_gpio.c b/drivers/gpio/nx_gpio.c
index 5abbb34daea..1c3d27eb1cc 100644
--- a/drivers/gpio/nx_gpio.c
+++ b/drivers/gpio/nx_gpio.c
@@ -213,9 +213,10 @@ static int nx_gpio_of_to_plat(struct udevice *dev)
 {
 	struct nx_gpio_plat *plat = dev_get_plat(dev);
 
-	plat->regs = map_physmem(devfdt_get_addr(dev),
-				 sizeof(struct nx_gpio_regs),
-				 MAP_NOCACHE);
+	plat->regs = dev_remap_addr(dev);
+	if (!plat->regs)
+		return -EINVAL;
+
 	plat->gpio_count = dev_read_s32_default(dev, "nexell,gpio-bank-width",
 						32);
 	plat->bank_name = dev_read_string(dev, "gpio-bank-name");
-- 
2.51.0

