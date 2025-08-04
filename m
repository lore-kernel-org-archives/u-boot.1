Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BCFC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7696F84081;
	Tue,  5 Aug 2025 00:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="yyw1Z9/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3107984005; Tue,  5 Aug 2025 00:11:48 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63F384015
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4J8HZB4DU8mtxNu1zBb1qIZwpm+R9dQAo9N+duR+CoSawDEPFGtA4Ggx9MQyqrWTHum1npMCT/FAi3Chiy9mg4B7Stv/YpHbtd3LQnOM+xukbVCoqto88qAVZmaHKQXUAJmVSvqzTbap7gwX2LCAsiQ3znBGOi6d47Onkk08iiv6ghCBBF5Y26HZRpTQruCkvsbGRVWkQwNrYyRWmzTH5EOUO+XoCBlUFM5ay0/TuaNEvzb9tZEix1aCKBv2SDLXTVyrl5o05I5hR0ysVxZ2YGlhZA4Q/N4YQuK0XRcxF9JuLTMsi+IHS/K2XJsnP3pJg85IKJkknNAMonV58gAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWftgK8agPsp65LB1cYVcOkYUucOKtYZMyQU51s9K/Y=;
 b=XabayaWEVmLfg2GuJ4MEYJjZMHQGhBsXtgiQcUu46CA6Ymc+F1+Usr4MxUEKhjr1+eK4nhVUccrUd7ZDboOyI5Vgu13ILeb+RdnCF3DfkNtGi8O9TOKk8Mrz93J0leWP/xvVXoUigXQV1kO4qzbzCo155GKAxOAsrGeX2KpvDP/FWmY/dSYUxwftPK9u6VZJhuCx2iSPicJvj5UB1sGSP7+AJW9v/INdufgLA0VGoYZOTtzSugATfWR4qxZ8dhsjgbCqNqVzpKuFbL3aVmPo8TlK+kiD8xtK3s8F8ZWMlL05hXUUVIptPZpX2T+Iqz8vRT+66GihFPNY9T+/ayXJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWftgK8agPsp65LB1cYVcOkYUucOKtYZMyQU51s9K/Y=;
 b=yyw1Z9/EVRlA+k72+s3nG1nXOscYbBZmtYJLkTuW6K7qK+aKJ30GrMWg2AYHjZ3HY991UwWQKlkRl/ppvrlGMJ0qgV2bgJb8DUkuc4PZMmm4rYop63Y51Y+g3jSLxp38Td2tOU4ATeHz0JnP4wVyuuo84ncu++Cl0xjnHaKsEMgGH6XlJV/w60BCB03FX+QWTxx6ftXpWsseXMMOE1xDs5obJvH6Kw6a7WLfTW7Y6siiASeMsthcdRNY/644BdWExPW65AX9odGFWlVxqg9s7JGRfcjmNXNZus6PUANBjP5v+Sqo2UevVTDpy2l+ArMra1KK3sspnTv9140+hmIb0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 04/22] drivers: mtd: spi-nand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Tue,  5 Aug 2025 01:11:04 +0300
Message-ID: <20250804221122.1420516-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3dc28c-f631-46d2-b864-08ddd3a3e0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NoJdr4JdUIfFrk3CNhptpYcfPQuZ/09q4WBSzpMyuXYys1VvPZfcp4S+ISlr?=
 =?us-ascii?Q?nros+wEakFETuaUP+vn+7uaIgTN/vxagxKIqlOnP+6xC1h1v+531JM4MJs7C?=
 =?us-ascii?Q?UjCBB2Mtbh0XBrZ9qkkN2bCVPebXR9+zzhiPq3Ta1ruNeeQs6r1Yir4VFbjF?=
 =?us-ascii?Q?7Xgrmc7+qIVOsHo0ivgkOJ3rDQ+ToKYZVkhrul1JSxPq9uFGCBGk3kfwf07C?=
 =?us-ascii?Q?AZCA9SWlp4TkeynzgWFPKooRhIhcemXdM6iAGhy4Ci0OAq2q9QshGx9aptTa?=
 =?us-ascii?Q?3xWsjxQDLu2IFK6UXSjXrJj29Af9hL6tfnI8I/ql5npTEVcrRidfTMAQHgBV?=
 =?us-ascii?Q?W88fZTYgFR1tRcCWWM8jhO7d64OlCtfppInf/++zGAD2H4O+FBFXrdJKKkQY?=
 =?us-ascii?Q?wUPucB3TJaVkVcmASTs91hPLUrmzSyf4q+SkGMaUGctiuavlyaJ79BCiEoso?=
 =?us-ascii?Q?N1+J2du08YJoECVsEvgQ6Bqn9Uwt6Lc+94y20xKuo3Xloytje71LHNdcrZfZ?=
 =?us-ascii?Q?ljzABbSoEn4M8VhwTwYfjfbFan2hX0hFKHKTzmhjQD9YvRlqE1cJyzKnh6Fl?=
 =?us-ascii?Q?M+p832coS7ynDDQPezPUbHIBlqIBeWl2E6fi4LfCkSX4p6F2uoIt9v3yTIZF?=
 =?us-ascii?Q?wRyaoD/4/KGKXB5QxwVyP3ZEZL+2Ia22/xRvGOgj0OJs7J4Fl55B1jmTfLgA?=
 =?us-ascii?Q?xdXB56/c6NRkE8EGj2DrlEiTvHGb0tEiL/OVD9G123PbK9ERp1/hkw3DV3jk?=
 =?us-ascii?Q?w4T35mUIM0B5IeDy5EF0IGS2O80B7WvXbKOktCfAHT57Plxo4x3PBXSXjviQ?=
 =?us-ascii?Q?F9DCr/hGhVOtt/JqeP11g0p5B+6nG2DaO8lAXirKALVDcT03eq2wSH7PlPC6?=
 =?us-ascii?Q?IowbY6FSkYfDofVZ7blp7hGCEJF83uaTx14+FwpC7LObeSIoXyaVgj51h+sm?=
 =?us-ascii?Q?J6sD3g/5pn64BAexb7AWaNpFrjIAuZ/tX50LHzrh1QgsxUa6Y5nCkmPXd+Gk?=
 =?us-ascii?Q?XtgqfecmBc7+O5+/OBGDWjwb+BcC1R7qA0DBJFVHSgnluNNuXWsCPyb+2tmG?=
 =?us-ascii?Q?ncTlgafwinS/16NiQTtcsJMrKz/0ygNHP6zKl0pB9JLU68hCHBqPHZISD4Qv?=
 =?us-ascii?Q?7F9QCWrIb0xj+Xq30cyKIwpaUQfKGb1KQywFL+b6aKwpAqgVBmvoXzmGm4pT?=
 =?us-ascii?Q?CCGHBCM7s8WIVSVKyqdh3dLurI0vS9QkCPxdhdwC+zpt3gDp1p+g+xq65Ckl?=
 =?us-ascii?Q?OXThleUOAokVL/ZW4yKbsewQWCK9jORqVIYBubu86cReNN6R0Kk5GV85E6wx?=
 =?us-ascii?Q?xclZPtYzIM8gKNmp+Qg7UvyL9dK8d8yvwZAuVbyYrOPnhIRb/he0ivJGMv11?=
 =?us-ascii?Q?HX5CKfLB0Y4GHYnv3lY0NLKimTj8FcLaOgMfLZKhfUY9rs6OIrK/KekU5WgD?=
 =?us-ascii?Q?3zENZWHzt1x5N/BiXzecJGr4DKoT/NOpLxxha1Aj1RwMvFiLLBTHsheInH2i?=
 =?us-ascii?Q?U43Y8KqlGOj+hR4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X43mrdc2jlQQZbLwK7sS16+sdTTVzKiCry9Gc4EUNx3tDDKkGBBNv7LW/Urp?=
 =?us-ascii?Q?EInt6gs7emw4IoubxiRPFA/157b9GUVw0MhIbC8BXfgiak0aWr/kv/wwhj6N?=
 =?us-ascii?Q?be6mEsgEQrUP4xlJOdZTqUMjW+TkR0rlG2zn3nLk1CQoR+KnyL8lMfP/wKqj?=
 =?us-ascii?Q?RV8ODQwIqjRfyLlWx8NJUR48e5O0nuF4sg0HJ8WSWENAF5n8m5FfCK+Y3yvV?=
 =?us-ascii?Q?fOqBBb1sWWtwGnA+703rBt6IPes/cKzqiyEYm6z6oBoIKb/N0d7CW3ZM0m3P?=
 =?us-ascii?Q?5N3AqSxGVUJf0T1k2Q3TSfOVoLvhZWN9IiRVcBXnVCjPYziftXsc+JKS4TF5?=
 =?us-ascii?Q?bwDbdVBryWKElmftEurohCg3ezbW+fMkF0L8SKhztWEhMX+hoXXykw6qfTnA?=
 =?us-ascii?Q?pZJSiJPguHxbq314Js42XMVYTudiF/wMgCWOM/7JugVRKdF1y5YlcZeeUtLH?=
 =?us-ascii?Q?R0q7+sNDl8tsTUf/43IZyALQPN7gogapSsCnL/Ii2PrkhGqOBOtTZf7uO8Pm?=
 =?us-ascii?Q?T/SdA3FS/FkHIFNiIN+JYvVTQ+ex1aaBmlb1TBlvJiDPEiMoxx0IR/xhGCs7?=
 =?us-ascii?Q?UxlRNUbO6Gmv+gqQBg4dn8MOixbhpiTwHfHmCudeUOcEsjw5MExaK5ZGS0wJ?=
 =?us-ascii?Q?lDedfsgFevg6CXpVJTXic0gLwx3PqDW80NcQNJVtQnEdwbTpdthLyYc8RCS7?=
 =?us-ascii?Q?xaHuxtqlbgsTJLKJ3pLEFc6M96fLXl+qB6ZWSmgaNL+71RH+LY9u976iskNN?=
 =?us-ascii?Q?Ve5B0I66b94px90T5VurRc1up4LcJpwh8FA+/FKru0p7qlNfc08jF02MotkN?=
 =?us-ascii?Q?k0aiZYWJtK4UvH0xI+c0rgRVdiHccni069vxcThHHd3Mht/Bx6mByzQkWxpC?=
 =?us-ascii?Q?Eg82VT5Hv2qxIWkDztqLtni/uSjPn0hODqOm13gPAB68V2PMBS/mhVNotg8M?=
 =?us-ascii?Q?W2Mrd8+huIjKCCQhmLuu6XGSIk+Su10hUgZ8IGnI8KURo5sO9S28I5I1et3u?=
 =?us-ascii?Q?z7+0EgOx6F038ek3gcU0qqKkhFtkltgloaklyO/9W7+Ns0G/yzyvrsBTxmJX?=
 =?us-ascii?Q?r9n8X4Jnda8MONg1JRA5dY1znB37EEHn9XxJay5YWPIy492eiZfYwOsTIDkH?=
 =?us-ascii?Q?1fnJi7HkV34zjl8227+HBMRVNnnR0up193rGbMgxblxR5ADWIKmOd5uaMPSZ?=
 =?us-ascii?Q?Xcod4yOJIbsswMiUa2P2R8BkXLV66nZtOti+RKcSvJTrXaiZRMc73jId4Gmc?=
 =?us-ascii?Q?Z9DTdl/pxxOFkXfngFqdbKXF6fyX/no4brrz8ix63xX6I/ONv2HhCcWvrECx?=
 =?us-ascii?Q?E0RB1nRgVXI5vMO+yVyPvk8pDIaZ5jgmC3pzNgZyZSZDqvreI/yi3rBuIDQQ?=
 =?us-ascii?Q?Ek44iPgnimSxkI7iDel7l2drylPYIXuytMOwQddkZy53PHrudI+Q7s9fnxpP?=
 =?us-ascii?Q?ZMBkThfh55gvqmiYWfcCJ0QZxwVgp03KqTsXTiGTSRUhvL4HFFvJjVvSq6Jh?=
 =?us-ascii?Q?tkBsiXio7OmR6Sx8Dn1ZeA3Cmj1OU+ORjbWp36sB8dZINFRP3FBBJqHBn95u?=
 =?us-ascii?Q?vQ4zRmdzRLLCNuCRTGSgCh8a6prY3NRsvWq74PisYJUQBxJJRZpAl7YBF9e5?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3dc28c-f631-46d2-b864-08ddd3a3e0e6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:36.5193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z+wNuyXY0yQ/u6MywdIiDrt91HeXUaQBDCH7BoAjbHfYsGa2qtwYiq2k79UcjvzNDh/leSj1o8gAGD0CVDYvA5I8HuS5vxFxKbIQUKla9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.47.2

