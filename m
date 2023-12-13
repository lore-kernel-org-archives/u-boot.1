Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658FAC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F4E87807;
	Wed, 13 Dec 2023 17:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WZGdiZ9C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00FFA8758C; Wed, 13 Dec 2023 17:14:44 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF6487633
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=radu-nicolae.pirea@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNZYSxGHPymqGvPrPNUB3iUIzO7a3jjOzeuDqCfzYndh6P1450CReyLbdlyS4BZChtlopTMvq1cC78EI/FdF4q/90e62hAIy5hbatQO5l3SgWz2bVZGTQ2j0w1Pj87HWt6KWCgf+PYdrI44OvAyRZl8U8q3MYLtAufk4oLTf4ZCu6bvFnLptNioxeLetDCiXyWH32AjYpYPAQuMgjxZtB02X8mUXwA6Jj6tAL903hDcVhQbJ/D0xjOahDw1mAG0kN0S9qNfq5sCK9/rQgTiIvrZeDBEtpw0HWOcT/eG2e/r+iGw6kGwQ+36if7hSymWqn6t3wvpgylYUereIuJ0pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEVEaY3/PGppedIWut6rdDvZL6zRhzJ/op37G4ybM9o=;
 b=IFNnOF/CFQ8pvHt5l+8cNQil742yaBc6uMCjJKTtv/O2D9QwEsUm6Z2I65FjZwamYo2HjpjDKmXludtWb8LXutpZdPZu8LRONpkBcBa97ShWKyonnkrfCefZ6UsCH6sgQi8SZzvUsliGnqISBr+oOf65IklNEYFhbI973HyKQwSJOIFlkMnQVnYDeT/o4dTiBrlwEfUFq+u4mxEfmdnYII2lZTJFn8vshyvIIS4QG2yHQXuC84vuMMsqxH30n6DU48C8NijA4AcTDi9/wgc7PJWM5NMdDOTJ2UNoE6VMSDTWSJ/TRZvgM8GJ6eXGXjcLzcHKQ7ytSKP5IFgGeCP5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEVEaY3/PGppedIWut6rdDvZL6zRhzJ/op37G4ybM9o=;
 b=WZGdiZ9CXWYhPnePPWUuoFCAX3vBcuxLMnh1JQ1QvV4WtPMckTk9LzapKfXFNrlSTC3BT4h2G5bE4o6svDzXYBe6wd+mKvg+diQ9ZcB1gbeNXPBbjhWHqzKPzkOs9few+vjG8ksJjq+A9lWB5P/N/Qthqc5MZr0Omg/CEBloIfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:14:40 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:14:40 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, nm@ti.com
Cc: u-boot@lists.denx.de, andrei.botila@oss.nxp.com,
 sebastian.tobuschat@oss.nxp.com,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v1 4/4] net: phy: nxp-c45-tja11xx: add tja1120 support
Date: Wed, 13 Dec 2023 18:14:23 +0200
Message-Id: <20231213161423.258870-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: be55fa5b-891f-4766-4d8e-08dbfbf69c09
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNa1Mf/76Q8a65vlcyz6ijGOpTmNygWBJIOYxFo/AA7pJmAcJGfNYJ9w/rmjgpkq8d1p556wjP8EJbEemeYjrsAuizq+E2ejF9A6IQn0sjlA4uNtudmVnZXHPNGcCziGnpNoLXP01mB/d7nU3kBIpHbsvs+dZ8CC6+EhAMaWnuwdgx8/EKshqaGP8yElH0li8KNEDOs3Vb7junIN0gsy8NddLH2m38uTSy823eRiU1yV84/6eSEjP9J0wg3sModbG30W0PQfu3qMrEA9e50bcD2h3KEb3/VuuInvAzrLfDS+tfzyoF0CwIgDmDGMqosCF6KJ2CE5nOecCx3HVvIpAkn1Ff9YdYTEGsv8zHO8xwtBGEfdiwhs8N3Gjm+8MfkMKhimV9oU4xw/DhMfb6CvkYKg2uW2iJldUGtG2PTDimW8ToOb1mU7Dw/QuZQqCMYEktLp89ndF+FYC3Ptn4Xb+YEeNQMpKcwDgIzrdokj1fdxL02l2lhOfzPLVXO/G0a9K5oMt+XuZb/Qd1FxVo4oK96Y0ut2qhBpd+N079/mxiqtfEd4RVz3lP/cL8eNX1gTfQq7Wq2lkvrg9OT/d84cLF9pFulDSu3cAs8JCCYvSftDwZBNWjxSI2ZW8fiQe5up
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8954.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(38350700005)(6506007)(2616005)(6512007)(1076003)(52116002)(316002)(6666004)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(38100700002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/aAFPXdLRx3N3kdFhnBRjWzZY3ozT/uZjfNdIDaIg7euIbOu3pRbLRjruE9I?=
 =?us-ascii?Q?wHnp3FdZ8EVjA/Wrm7DPdoFOnwCTcoWEkKXMnXD/0kosbccdmmimpU2QQIoW?=
 =?us-ascii?Q?93p/Df5ftLp8oihPo0DWLXdrebXmCfUwYfb8FZ1uhihcOGtt48cNnYMNNj+y?=
 =?us-ascii?Q?/6ntQyKRnoatFpC9eQhE6Hsszj1ou+oDm9buaPgPTSdjUNN7xEIpVpgT7wEE?=
 =?us-ascii?Q?3pxnUJwOtSODPo5bO9YaxAVopyHBiA4rs9bBroWQbHM9fwTzcpvdjbV0Ymfb?=
 =?us-ascii?Q?Q+j/1fYhcf3l+jBtAv1D+TrzeizVgJctzfBaG2zx9j44ENe2GINmrDBLz1GE?=
 =?us-ascii?Q?6rPAsKVn+WkQkDGVFN42VGiSwvmOrauvPMh0kCpt2RttPJmrhFcvl+sX8Ttr?=
 =?us-ascii?Q?JZYUkxD6QvALAxEFbbgnVA7yZozZytJuMh2A5bXvJ9lhBRqR6anVQ9WJR+SI?=
 =?us-ascii?Q?x3/4KZKKluWIXB39aIAqV0P6QxJOOPAOAu/ngfZFErMd6j8FNEVpiVkVkJDP?=
 =?us-ascii?Q?VVwkQgwLoSI958DP7rwqonKdRD+1bQTzmRrsHvXIGdCF92seJSuHPd9ZRzgJ?=
 =?us-ascii?Q?+wrRRinXrLdJTslFNgH1cd2MT/hsSiMkFYkFcAY5VdQQNgMrQVomty7cta3t?=
 =?us-ascii?Q?CigKZXPFPIzCbQmx0ZsT+jpt3DWy5TIqcnfFMsDirLuK8FU1/dRjwgDdciJ0?=
 =?us-ascii?Q?/a4fNRjlT43C+P2cVIgYpMNklZfYg8xrcg46+h75V9kquiOVMd65dh+71mV/?=
 =?us-ascii?Q?V9CP0KhuLCFFYsWfePFqbLbh4kNqlVWLf3prLVksFw/jfiLo1B3N0YugdOtZ?=
 =?us-ascii?Q?yhYSi1bCbkPk1CQA5HJnmLQ2khJJUAYP4Opx7NlIzwvVILUKSWPcBtVySuiR?=
 =?us-ascii?Q?75UZXlDxK9YAxpRohP04BYQJO0PR0j4s512BlmasccO5meN8OwkC0qfU0ei2?=
 =?us-ascii?Q?W//gq99hfvJ4g07riFXQf6poCYQZuMxlBV3Ao2izL87sw0BlQOE0pGSwID4G?=
 =?us-ascii?Q?RnSDBgQNUD+3TB3Grg79u8h+VcPX4yFMJC8OoleAw7FkORiYlLpshWqos8wA?=
 =?us-ascii?Q?71oLMS7+eJvZIIi/F7g+hmJzSGkocy75KGiu9PUSm5ltpUTnt+eSGzWM2Lhl?=
 =?us-ascii?Q?53ntj9Wx9EisKpfk1bn9nGD2HgbKdXBqktjTzndlSE4ntunINkF9+oxNK0H0?=
 =?us-ascii?Q?Pijn9UUmbKCtPWXHeIniJ17ILUlV2L8O945QfrTDWAzEN8u3idXiDsnMZkeD?=
 =?us-ascii?Q?dnGMJEYxnaWxDu+vzFIVA5NcmFXYWBNJLht0QF/kwXLy6ety2+Kvk32d0V4V?=
 =?us-ascii?Q?8ApM7cQW8mD+qKMgx9fXJCGCYu8z8DFt0KGGn+tTEby1J5zKJctQpnVt/80x?=
 =?us-ascii?Q?4JouHYg7r4abEUqY58godzu/J/OHFRDPzfRZ3rcGCTeWT2N6YW/PFjoZxaPI?=
 =?us-ascii?Q?VLce+BIa84nrQ5YRhfKgpK25XSAtmfFiYAklnOe3wJwSSpX7QjxwTZPGsFKO?=
 =?us-ascii?Q?Brr+X81ORqGSevW3+05Ro2WJDxboPBEqx6WjtFHSbZJ4C3FSpAtIuZEnqG7I?=
 =?us-ascii?Q?Kt4CdTlEwW1YOy0YtH49wz4Z2AEWLSR4yiI8wfkVe7UvtlHPhtSYLki+EwdU?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be55fa5b-891f-4766-4d8e-08dbfbf69c09
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:14:40.3063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VD2G8qv536tioZIKdZ7uIUv6eEfGqH732HVUwGXeUT/3amrJG09zQtQw4zL1pKjOX0XaGIQKtGLzfV4xcvuqDtoR9nfgIw0tCDsSF2sRek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
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

Add TJA1120 driver structure and report 1G speed.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index e787f5fbb9..f24fc5b2de 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -14,6 +14,7 @@
 #include <phy.h>
 
 #define PHY_ID_TJA_1103			0x001BB010
+#define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
@@ -316,6 +317,8 @@ static int nxp_c45_speed(struct phy_device *phydev)
 
 	if (val & MDIO_PMA_CTRL1_SPEED100)
 		phydev->speed = SPEED_100;
+	else if (val & MDIO_PMA_CTRL1_SPEED1000)
+		phydev->speed = SPEED_1000;
 	else
 		phydev->speed = 0;
 
@@ -363,3 +366,14 @@ U_BOOT_PHY_DRIVER(nxp_c45_tja1103) = {
 	.startup = &nxp_c45_startup,
 	.shutdown = &genphy_shutdown,
 };
+
+U_BOOT_PHY_DRIVER(nxp_c45_tja1120) = {
+	.name = "NXP C45 TJA1120",
+	.uid  = PHY_ID_TJA_1120,
+	.mask = 0xfffff0,
+	.features = NXP_C45_COMMON_FEATURES | SUPPORTED_1000baseT_Full,
+	.probe = &nxp_c45_probe,
+	.config = &nxp_c45_config,
+	.startup = &nxp_c45_startup,
+	.shutdown = &genphy_shutdown,
+};
-- 
2.34.1

