Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA4CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 06:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F9A841D7;
	Mon, 25 May 2026 08:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NmPa0/Q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE6A844CF; Mon, 25 May 2026 08:13:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049B38405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVKp7stagEGbEFQd2PR4oW7LULH3yPD/9+NBJ95OoBuUrGyflADKhR6QmUxmtbriXRLDvu2oOYLBMOPXAs2RyiZeUGTH/t7g0kGe2C55STVyedmobNXd+CVBVnPTUU39xazmpuLxGYDWcFA+IcDg9I/XjRoSPcDS9xzprEGkembXulFAKZM9DLpyWqmtr02n6gL818du1lmnjWywy/wz9mTUZ0E76dviGTbCnAgFU3ojkHuQUnO/DVZxhFZWkX5EYI+pQuJmeR183FaXzxJT7VGTglvGWlY5Lnxg/5wQ82qw0UguYFM6fg22YfvZHyYFlfO7Dl64n2yQpUVbYbcshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaFIDOeX0OkAqzmv0A8mVd4qrhMJWr34Sy3A8uwRftg=;
 b=GpkkXTXgyWjRq93hh3yeXV5KaWKuI15tAyw8FCs0cmhliQ7TrSHp4WrGaVakMYMJwiFML2tivwOjroNmzHDW9u4z/0l9ctKu8a++hpdXt9oC2Z89+eGYs9LWP4mT90SlepHMtX3R+vTOIWoFrQrJsKO6Qs6cERbsCsgPIiZZRDfw28/GA2r49wnoq6K6JCM1QbY0+rfNtR8ylZ3Ti5oOZBt25D1i76oyIAA1QIkj+zdnG+bMd066+PZkIAFsW6jltAZpohIJRjVcPnqykIKyXhpzz1jjmHWvVDxDw7dmnKuB9hI1gcSupDmF+yoHXwIe12V9cux9kcTjXC/yorziTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaFIDOeX0OkAqzmv0A8mVd4qrhMJWr34Sy3A8uwRftg=;
 b=NmPa0/Q5FFm8V7WpMo6Qafa40QHCU6fGKQZSRq/1UxqVkSUPKD1cNWmdC6nPBv9hg6eXj1Bn7WofNMwTBOps0dNnykdA1pnCzcMDFK1v+aywjeHxHOtuVxyPt6uTo3nX5I+coxpywcRP6vy+3GISFCvHNJkXH6fIr1X2fQ0DAdE0zjAURcn5ACSSCx4mJ5vPDCRqQLM3cSHGT4gDWpCoNuus7GYH2o3NI3ct8cXspGJs5RLtKWpJSYftdD0RwsaQxsp0F+WN7DFMxJ8TdMgvTcrRx6eAfbSgDcqK1452+Uupa6ORADo3PfiSLEtwNdJCurzq4dOfXNUExceQR4pFuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:13:08 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:13:08 +0000
From: peng.fan@nxp.com
To: jh80.chung@samsung.com,
	peng.fan@nxp.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] power: regulator: tps6287x: Use dev_read_addr_index()
Date: Mon, 25 May 2026 15:29:47 +0800
Message-ID: <20260525072947.2399715-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 2688b77f-98fc-429d-123e-08deba24b012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: fl5tXg5BawaXnVx8fEdsHz6ueOj/zibqPK6xk61hmj4xj4jw4ScOFWCzS8ILZx+1I9p1tz7Ec9ljEQLge8baC3pgf/PHxCTQ+PQd9itXcyqaUgHMzrFQO7QO6diNKR806VY0XIkq8DcUAz31f2NxfmRB+ZRv8giHTgR/hK+XY528ysDou4GmgLCt5SdFRr39NlnNobaOj9qX3ivMzQ0vnLf0BfoKrAA7lToLgJXZlAWdDVt2I0AT2/aED3yd2YXCgiWjB4/uSsPjtXJXzYP4UbreVvZHGRt0fr3M00PneZEyqYV1xoX+UPOt4LtctJqVKKsttg8jdp0WG/OxrGYGG5KnDFnF5QcxoANFoFSjx+wunZFbHP15vM6jfpZzy0GecLLwGr4MHxW/urlsf7pDGMxJvaWm9VIu/s7rdXnKa5z8EHN8cLOBsWI7DW70HKeGE+Z4SPZMMf6t5F1UKX+Sz/tz/8RF1JQVBKlJa87Nt6wTJL4Xf4LDc3wIrhNvzscROHDr11cBhefmLKouQTiyKvjo437R74cYw7V5JEGPgD93QX7bavKznX+y3LIIYL+tENx65+b1q8G/IYRPVckdlse38NBaNysZQGhFYNiyW6Fj6RxK0TUiYhc7RfoKxKFFgZVNxlmrkDQouVb2xmGVzP4JSZ9QmAbXN/vK/u1vH7VC0b5/DXi6Ao+CyW4iAaXOo/cdViE9ife6HAFwd6Qfc7ZiYx3Dxph0ajifZj/mpKaDPBC/BhaTeGwOFzb7wL/B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7JwOCAmX9/6H+Ci34yFi8Linmj04wThfOunzKQwQNEQKLy9rDXpv5MTmmds?=
 =?us-ascii?Q?F/M6FMMhXgUdLoduF0fesGjTj1TVLxr//n17bBhyHtULLxZagaVqRiTqh3uK?=
 =?us-ascii?Q?ztGSTnUShUrlHmtc4o1Xy2VouWJBgau2o0BWueCH9Xpy/CkgMYjqBDrtMvLx?=
 =?us-ascii?Q?cuYhYcBB+j0dixA9u/VU0qwdGuv+fTibCQ6ypBxuJEnKXUQq6YjJcTUS5g77?=
 =?us-ascii?Q?23+8r6UrnEtuyaZYP4fdSGQkqh+uTOJ4pe3uHPLuTvslJ9c5iW4vGeXm3pvJ?=
 =?us-ascii?Q?068MCR4XZSdtWjANFBEFskf3DMQwlWUMeohbPl/2m03LupvFtUZNIYQBdUSh?=
 =?us-ascii?Q?Eq68dghDNH+l+xywgP7Sg1xS4j1OYD8SEmOEXMjm37c09R2/1NOB7qa33HDC?=
 =?us-ascii?Q?lpJiQxXytKwyb2PlhpYH93hZsZKiGuFMAXjO8NeEzAicU03fP5kitv29wn3Q?=
 =?us-ascii?Q?x5bkHlAUxqTRoOZktLCue2KyWec8fx222lmFqAkMsTiUpiplbAMGXofjMrOu?=
 =?us-ascii?Q?1O4XK4bXxVik2VDj8TMHaQ906FXjIKdl0AFqPVYivNjVOUZSXajVd83ddkMf?=
 =?us-ascii?Q?8iGmAVKO+FtBoyVJ+9cOKCfDAzk0tvHPiHOPDCuKjK+pVpOz+vBgRt5/fjlL?=
 =?us-ascii?Q?ccp6ypoTiyxp9yW558lnh7Y3GOUsBbGwzgA/I6qV7w1Z7aTGrfRZHMUTZnCv?=
 =?us-ascii?Q?uyYZwKdkVcnAU22FmtRpRF9cZnb0EnrURUKxaY03g025DOL57qFei0EtRxeB?=
 =?us-ascii?Q?GMZVlRd6WW6DUBbngA2u2UG9ukLaEv0mOobAb7uEPuWKT0qgRwJ57ecHlzZw?=
 =?us-ascii?Q?9JseJjOorPUSy88iudnPxIYHp5OUG0HGodouh368ueP/63kDMaPp86q0FNgR?=
 =?us-ascii?Q?Obeon1J84R7HTkkCGv2xlJKaw1CPM9DMQx0AKmykyOF+ReYzy5uJu9409vau?=
 =?us-ascii?Q?8zkSJ/KfR1kbQjq/DiXwSW0BVfJel6t9gfpd5K8N9O+oi6pSL1ZaL4JqIjF3?=
 =?us-ascii?Q?ZD98CMWWDQBrHJwYIOmJdQ6MOYJ5u6lLOg3hXxsWVS91jb+M/Cuw15EJOuk4?=
 =?us-ascii?Q?fej9+8zQkq3l3ZBiJLRTKTyCFxuot+n6agm+lK8/ca9NcKZt49eAfxqYc98+?=
 =?us-ascii?Q?TPqP6v47coiEK+RKxOBBRnz0pwQlX357yUKPpO9GURYhwMNOKYszR8ieA8xu?=
 =?us-ascii?Q?X/jUtiCXbR1kmk1dx3sCTe3XjK8r+cWPRe+VDS5fYz9MiBm4K0CgNHvEDL0x?=
 =?us-ascii?Q?f0vD0uy3DvfqzVCnaEocDSslEpTAd+TX4OVJl4VG49oVN42vxcZenpDso8dQ?=
 =?us-ascii?Q?sW/3BazrYnweM75obQ+OgvQhwcrgn6aLUsOIt46jw0bChn6bvAoG7+1UMbrn?=
 =?us-ascii?Q?eNVnrhc2tqR5JGoTax6BbHla2sTI/FCPz4czBHZO4d5T5yBS4hEBF9+bGqgy?=
 =?us-ascii?Q?Hy8QTDSuKbMPDm7xNu00+BpB2/Oc/z1mqlH213U/OGlgrn0azNnZNYfHzrT8?=
 =?us-ascii?Q?1TANXwkoJQIRGqfjsHeDabljDjLsLai/MkSdzC4Icypep1rvTz3pZ4ylMPbP?=
 =?us-ascii?Q?5+j1r2eRrFcrn1zpvJ9L/k6EPIgXjziyFJfKpxYbuULnatYAVi9/NNezBSUj?=
 =?us-ascii?Q?/HO6cosoGVxg1BjDqxxwyDn3pD6OHFU88aFJ46Ky+0THtEfstdV+n0PXgOk2?=
 =?us-ascii?Q?4JPUhBDeP8gDe+iRSXz4C2UYv2wceUU5g6TSpg3kkykZAVuApHSK18uJoNLW?=
 =?us-ascii?Q?FXHZESquOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2688b77f-98fc-429d-123e-08deba24b012
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:13:08.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWVHvfxGnE0XmP/BMDFjZKnrOFdun36quYgnHdO4AuwVJg3eH2jGhH42Xzi6zTSW87tlG/KOPkQ7yKUk4JqUAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/tps6287x_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/tps6287x_regulator.c b/drivers/power/regulator/tps6287x_regulator.c
index 6d185719199..2e6d85f677a 100644
--- a/drivers/power/regulator/tps6287x_regulator.c
+++ b/drivers/power/regulator/tps6287x_regulator.c
@@ -141,7 +141,7 @@ static int tps6287x_regulator_probe(struct udevice *dev)
 
 	pdata->config = (void *)dev_get_driver_data(dev);
 
-	slave_id = devfdt_get_addr_index(dev, 0);
+	slave_id = dev_read_addr_index(dev, 0);
 
 	ret = i2c_get_chip(dev->parent, slave_id, 1, &pdata->i2c);
 	if (ret) {
-- 
2.51.0

