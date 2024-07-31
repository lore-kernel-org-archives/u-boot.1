Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393F9C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CC38898E;
	Wed, 31 Jul 2024 10:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qQBQQugZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A588884A7; Wed, 31 Jul 2024 10:28:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0A588982
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5QLUlyYr1zKbZ/NmaPPB1O/X8elt3058jzzR4o5ysOFF60nKGSzQoE6oclugqUiYiO8q9lgPWFUNn7M5WFDQxeHX14I3AJoSbZpaxBJFv6FxzQs24A+OoydoY8TQqsp5yNAXSqgO42TIqrNdm5OhrpNZ2dNb8e3ldRyZ0LkLbsLehbueJTMiuEIKxSIZyLqbAP4W8Rr2zao/oM4Cpe0cM/VAiORPCoF0A1Od4OmX/OJutGM3LeyrEyq5uac8axBgMxxYruBYXJHmR2ai/xubLHW6761+PZuCf1Zyz4ZEoORzhv/Fd6u7zej2MBK2ChRJdoUj0m2ZAniCcENlnw/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdk5U8Ycr1FVQ8B5gUEI2BchXKFzkqhtc7UrkCMDtbw=;
 b=qzmsLgV7Xf8y5rAvCR6tUf4sUzr98Vh7rJ8hMdWzawhHvMccg62iMrXhtdHmmFGEhexxL5Ki+h1CIuFrI5Lar3qfeAwm4KLw/xgthMyTchbWRwdw+g17ABmzPiSUUTUCywZubhp3d31i43EFAM25X2zsv55WgmOcjSyX3OWU7QRfgMFaOEb17FW4FnXDq2B/HK9cBWTr+XUoRDWIeRKneoy+rLW/upsxBpXUZM4/b3j1SbrQoTaz2iWnQ67A5jGlc4+q2CR6DMnOHmkDr5W55/Q98X+RyFPcPiK769d3SFnp7vnMMIU1JgE+6TMCFDqbtdUb6cIdLwm9KN5qZcdQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdk5U8Ycr1FVQ8B5gUEI2BchXKFzkqhtc7UrkCMDtbw=;
 b=qQBQQugZ8SbfsHcAMKxIIo9f6OS0tkHQEU2r1mewsnEugsIlH21YPAQvVlgKBvL8r6wzn9VCuaP7xr68ntXwdB+Ce0R8wpNUlw1lWKMObccWoWMmBYW0DtIoPAQ+tAcykxlos/sS2JLgQqfa+33mZ3/o6hugAXd2ccUNbQfSo60IeLWwxrzhx+yFPC1c/7RgelYk5zRnktyLMUa/4H0FVVXd+oC9AnDCGPQapao2Y13TARmpxnFQTAdTOQun+WNes5z5I7j2BO7P4Vy63e2QFhiRuKhU5j4NlA1uq/C/qpoEsBFHX13WLkTlxBEoDdosx8t5eQ6zKamVWmVAzAUZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 03/10] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Wed, 31 Jul 2024 12:28:17 +0400
Message-Id: <20240731082824.3890809-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5038cc-c7c7-49fb-bb79-08dcb13aca09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4CBL6uHf/4PFHTD9u5gUEJcp1CSYIX5xM1aZLdMZB45j1ZbcFQtpkvk4EEO4?=
 =?us-ascii?Q?NmUznX4r1W+j8XDiNQz/uxrTUPy+Mkd+iq2kXBRY4InM4iwejYPLKXNQ8ezN?=
 =?us-ascii?Q?CS3FbJeWzSI4SyRONyVS8eLdxdQRLd+NQ/e2PcRtisFvjadBtRTD0WVOH974?=
 =?us-ascii?Q?1wJcY790nO/vtQrCpxu74ZgEifa5U45zfJ1GyK/onw7aKGqCJRd/wvD5FC6n?=
 =?us-ascii?Q?SoZv7E4efRlMJzM9s4+7cC8HVv0eLxvsMDuc9XMgyMzNySvSVeJaHJNn3DJ+?=
 =?us-ascii?Q?zNzVf0g73PpvNyKJppEzQqYgqBckrYkCA6A2qzhlYNUllxhcdDVuQBb5K7S1?=
 =?us-ascii?Q?RwOY41S+UejfJPTEyA+tQkJrA07NKC1KbEdJ4yf6lmuIohT+Rg5oYi+AXoXU?=
 =?us-ascii?Q?bajIxPKNCPNHSS0EZwpOsk5RLZIZ4uPYw8dPG0/PGbQuB80otVB4/Guf2KX0?=
 =?us-ascii?Q?H4mj9dqcq94WGhCB7Wvp+CV3f2dEYlCmGyvOeSipE6yKkMI9jg+xhrG/maDs?=
 =?us-ascii?Q?rbqi8l/55Vw+D3kt8351QQ4Wbse/+QlUW+dGHzpjcFkaN1wbBOMGLg6bVWod?=
 =?us-ascii?Q?7ZYy1ewkeQB8E7DgVP/IJX0k332SBnIYrwp928lzdbP9t6QydmdLwAroZ6Fl?=
 =?us-ascii?Q?4U+2aj+TwZWAP4/pmWApXMGZV2XFDVFrscjjDmN/juIBlBHcJ7GcvnLtWtgX?=
 =?us-ascii?Q?zsgZXxncMjkaC5mOi5B5eVQfuWjdvDM7OWPG8kL152Z9nLmI775CX3EYtoe7?=
 =?us-ascii?Q?VkNDGUsZBBD1zs0KNE1VqOHF2mVMw7TNzgZwADJTqqzOYySE8gl3GeiAnQtF?=
 =?us-ascii?Q?1qXM56z96YkDFwjMvIUtuS60/bin7PtljZTczhBoa5waAaejTxTqEYRfRX+6?=
 =?us-ascii?Q?/hGcnej6mwTkIXCVh0jwbrEnNECedBFvdW5OfzluFJCMKzy0Z3bHCVPlJQN3?=
 =?us-ascii?Q?/UcNPBpi0KLODJRltAFR67OlXqFSLOmhuoRntS+1CuN00AEqJcr4/se8thHJ?=
 =?us-ascii?Q?Snl86aCHpLRgTO2eYVLn1sN4L935NipkJt004tXH450LPJ+N8RPGC8eREERU?=
 =?us-ascii?Q?wpfYYcu6cttmfllbxNK5vOhqb6f5zH3AURGGpm6oIdEGvHdOedm51XzXqIq3?=
 =?us-ascii?Q?5y7vn+ntb6MdpOQyyj6ko3Fe8sKpHEuQUTiekjRH+p/nQGhgWgT2tUEsNDpZ?=
 =?us-ascii?Q?oG7xZGUGul/RzmkkqI7sGqnEFiFUPAwP+lIrvYxJVgcvaf3SLVQdAcZ6Xaba?=
 =?us-ascii?Q?nrt8KRndHWOqIKyXem3LCEAryjgb7epFX5WGa4SD3fH2XMnmLo+yuZK2XxpS?=
 =?us-ascii?Q?aPJLWeEaxB4XV8W0DNwR7GecHlu6eWiWC+jRVCDUTz/Po/APF2x0hQJIcKhm?=
 =?us-ascii?Q?xZjTWNwk5Ysf6u/tPgPC0wmRWRYuq0IAUqElmN4NA3lFoSfK2xAkHF51ZH2q?=
 =?us-ascii?Q?56PYZfaxjAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?490oEGdgg5PPhFndmpDr5pCJ6r1m2rwLniyk7hmMlgHpKjsDIu/cZPYkBIPv?=
 =?us-ascii?Q?E5aIMmyvK5DcS9wgwYlmCcaeVgOA+pAzV+Q/bNIT3QKc9oJCGqM0hb2vGDcU?=
 =?us-ascii?Q?jSk8WziXSMDp8ZM+pfRwAdtrmhXk4WcC1kqA3uh6p+Nad4GRVjq+c2M8fjWB?=
 =?us-ascii?Q?ehNMGu3tESTGRrv994ZxRI0dV4vFKNh8UR0rNKb/kq5kJ/F9anOYh0Fi6/Pq?=
 =?us-ascii?Q?gQa3S1afRRyTlEIYjyMfnx2JhNbommhO7EL+/lt9pPWb5EMsq1LNOtxjGCqD?=
 =?us-ascii?Q?2XyAjbDrGNpJMmVX8DcbRV1RQ84/+9cLpVM8xCFZ7JJ+UUNhy28/piCXij5K?=
 =?us-ascii?Q?c9np/ROZ4YoVxCeV1lBFaBavC1w47Pr/hd3MXApTDA3MF187zAdvVJFhl3ry?=
 =?us-ascii?Q?aivesaP2vVDTLDY+0XKUjLF6VK3tzi5+Wf1r3sujAv3oqeVvbIXdisZG7gW+?=
 =?us-ascii?Q?ckKG0wdqJBKs1rCx9KTK95oakazZ32PAK1mDjcrXofcR3LJVA0fcGti9ndxN?=
 =?us-ascii?Q?bniWWU0j3MNqRDjm4Gg2BTnBMKzq2jPw9ukRjmKfoq6VypkH+2fU8TUkLqOp?=
 =?us-ascii?Q?nNhNs3eCvoO932pCJyhef4Vxu/b/CuIy4oZwNDEkmN5fKSfiFuyLoYQqWcNo?=
 =?us-ascii?Q?78WFB7ubBVEyzx9s1fB2NyOIQfFPCLTsWXYCdBZZSF7FTX55Ql9HCg+gQIt7?=
 =?us-ascii?Q?8D3bQYlXCUKmO7xx6q14tMMjJmZ9LGQ8bpzVn3w7HaETNMxg8qTnb9cXeOz0?=
 =?us-ascii?Q?CtxLdTIEiSGiwnAzdcUA2NobppqN/DL8fhDFTWtlPwQK9J9sCO5ynPT5ENkr?=
 =?us-ascii?Q?Av8CKSfLJXLfkwjo2FCVPEsssHM6V7jcDT7kAbfiv0Kx1bHUHD05iQH480ZA?=
 =?us-ascii?Q?09W8g6b7lsAZIHAIyX4x73KpVLyvRfqZIFAecV4QAywLnUui/6PToUqg/8Jg?=
 =?us-ascii?Q?zfj+Eq7Tne1EmqemXyANm3D//vhzzKpsK1oWt9yG7BIC+qqQELye1aQeuqUu?=
 =?us-ascii?Q?SvAz6ati2YDuj8AqiHN+nuEIa9rl1ty/M4xWu5XEuOzlzvSIb/DqwHgCpBjp?=
 =?us-ascii?Q?4Ok5jM1DJuMtGVF3R6F6hjKUG9wzgAzkmqZAfXshTWj2q26eDko++J8mbabs?=
 =?us-ascii?Q?W0Gpw+GhGLIiunzt3w2pIR7E75fTwWu4+OQodcKT2ifWXug0JB3hOMlIhMUV?=
 =?us-ascii?Q?LQHs40kDgcaEzJBh45qiE29jvXyknTZf8hv7ThqtnROIZ9tNOFz04lVpn4Ox?=
 =?us-ascii?Q?S5uPD1z41T0HjH4ugMS0I7aH0zh0yWk7N1xUCaLGRk0Yz1K6eLCP/yCpMYAZ?=
 =?us-ascii?Q?QolhcUbrfRjyJKPs4B2FZBysT/rp6wLBBjSIHaxNJ+opEUX3Nrm1lxzS8sY4?=
 =?us-ascii?Q?wUhSugtSlP0kU1x1/X91fgxB6DqE7Lp1VT2S8u01FsSgo3Kst3VX04V48A/u?=
 =?us-ascii?Q?vEuQyPl5inhqVqDXTyzGzXmqVMOTHBp4u3PD7zdEXNWFrKyRFd5xHudrYseY?=
 =?us-ascii?Q?+a6t1PNdCm/NvnAYbP/Env1K/WIOFpkg0K3fXMx5RCl2Q1KW99coEzJHKENe?=
 =?us-ascii?Q?XoekD7kz7Hpdl/2rCWQC9IiHA/oidsOa7gUN3KXiuKWGCwyvacdHSaJZk6Io?=
 =?us-ascii?Q?/qj8i2dRuCfECWWNeN41fZg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5038cc-c7c7-49fb-bb79-08dcb13aca09
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:43.8259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivqLTIE2AWDC22Wm17On0BwD7Fd2P2perCAve46CHbOBdAQ17PMQ7aVPcH0VfW+eik3661VTzlymNamI1Q1gbaxBc4KbPJJQvD/D7VtJrHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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
index ca07c70e217..4741d3e087c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1240,12 +1240,14 @@ static const struct spi_device_id spinand_ids[] = {
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
2.39.2

