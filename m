Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C32CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565D4841F9;
	Fri, 10 Oct 2025 13:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Fj2XxyT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1E983E92; Fri, 10 Oct 2025 13:58:46 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF7E83F4B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxOPCnxv5iJUlovIxJ6JsISC7KU8r1YD3ji33aWiTXZ7ib7u8LfXD3M9b1+Klswi9QyoGahWKyvzfLCtRlRF68Et0Y/87TtdCMMTJWNcFd7x72ShjnaOPymGBQcjXN9ZwGPez1Q+VrKZVlPPVl+H8pAqDpnClOqejRDDMreGbvzILA4XUidNCos/C1WOrsv+D3U3lwpC64Mb5nrp1WcPZ21dNaQ+FLQPBK7RLgg/gUTt5XNkH4HdFpGC6sdltzPEPqdP6MPqptsF2JbJOi8WTBdtYYG1Y0W5tp9V81YjJfPhdhQ1E/X5rQPME5NeiNpIaOWQWVxXmCYQM59tOfKfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTih+RxydYrCaX29g4wYDPvJ4TOK7ZYvv9kCDqoiQwg=;
 b=vVTcq6OL+Pu19VdhP+bKrw+WHJ4HByWrj/Uz3I+4HKG9+DP81BvtFbkVCNt0iFcheHtZ9DjMvWhMtlvHIr4z07tz6+5TTegYT0HI+wSP3FpD6uTykmeeetCXOjJCQEcUc/tv3h8cTe0FcUC8ydQ3Y1RvCSLqj+RmqMPc2jrFcwNUR9toSSvGmSEwSO2Xy67dHWaZoBQFH94UijdcBSEVD4HU3c4wrYtYTQ3uw23GZ/tkD5nw+7bKFzCAGmcuBVRZ1uxX1KnEnBY+IxyJSMaPafU/xS8k5rkIMwyLdLxIbzAuXeir5wTF8XBoRTNpKyC7PyLJFEjKoTzIHFFXk09Aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTih+RxydYrCaX29g4wYDPvJ4TOK7ZYvv9kCDqoiQwg=;
 b=Fj2XxyT+9WmvedeUfFAk+/PLQ2RSKC48SfaqoTz8QKiaFmtbdS1wn2/hF3qxUFTB8F71KdPJ35n1LA/rlhHzLK43YbJsqxbvY2zkeDZuxoSD56q38oPQdVUHndHghsOTcZifgoDlvce2V29SsVWIq5Ma+TSaXvhwMDyx/jQRRRZcHjBS7++YByyl+7n9JkepVSVo1GJPUF9JAWzuLF54vocjesYsFaxgx4wNciVjwj8R4XMCRfdvyx4xhmDonitiNIlHAg7l+2Kvh7l7JQyJ9kBDGrBQmwqH/cON6L9WiucrgF2pH5ivo39Yc2JhRQS4Mjn/DoMuw7dUESI+/WJ6kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:43 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 07/24] mtd: spinand: Align logic for enabling ECC to
 match Linux kernel
Date: Fri, 10 Oct 2025 14:58:08 +0300
Message-ID: <20251010115825.1531775-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: c31df96f-4f60-433e-54fd-08de07f45beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8TCESHQKPRdA/JOVRpEx6/aiF2k6cDpT+3Ji8oIO10/V/bl4jC9hUngVyk/l?=
 =?us-ascii?Q?J/RbOx48qNIyxcNRtT6Tcx6J4MbFOQ8axktdN48sjiXr0T0KgzbWEbb5FXpx?=
 =?us-ascii?Q?//IbdN5GNtVfzIE7WqPEnG0vrP9oLrlqIsb5rDeFoeYs61p2Z4bWU2OaTzNZ?=
 =?us-ascii?Q?m2xAMiwNPR1F2dlRZbbatKL/Sa/z43SneABzXm3xUma8CWzTuBpZ7E+D16K/?=
 =?us-ascii?Q?PimdBLgmRL9dsERETkenRGh3Spb8XoxQ6rARB7Qxhhd5dkGfQjPtYqQSphuc?=
 =?us-ascii?Q?wt8VV/Wqk+B+fa7f63w++8wK6EptO30i0K2L5qWQ0J6wWgUGuKseP0RlUFMg?=
 =?us-ascii?Q?f7jk59YY4HA/UCM93v6Tffn7/WqLxVR5TWo/PnVQIcJdEUlnKmXtrhZr901L?=
 =?us-ascii?Q?qWc4uqkoOMqVzWebLuY/Jw0SuB2IkABxoaBiSNKAM0dtV9U1Z9sFv4rmcFVv?=
 =?us-ascii?Q?sC0chI8Gbv6DfydS6F/Vo3PhAvIRRn5rH8YUWOzt1Z5Bu3x2lyFc7kKhipwB?=
 =?us-ascii?Q?08OAP1o476N+eODYzwpZc90HmoYbUTIJh3rMj2PRpjEk0LbZJOMkcMmguO5y?=
 =?us-ascii?Q?9T5Z3Z30Mt0jxJw/bEt0NhpNw2Qnd4fhmvYlTXP/I2nOiGvjm2c+YHpC++1f?=
 =?us-ascii?Q?e4fxWwuiRqpivkRvvA8KI25b80NY9oImMwIPsWEI6wxyiNWZ5qp2WU/ZT3e1?=
 =?us-ascii?Q?j3jlFhJnekoELTJymgLUEKZanJB8LhzcMa/K+hEtEokcBHGLfN71vb3wZsMP?=
 =?us-ascii?Q?vM2irqCBsj0uDUOLuyzwjku6f/WNU0pzWVAHYg615HTdv+9DnThWhMsXFibK?=
 =?us-ascii?Q?+ZxvEQ2rDIGhKdVbx1IXohq3CIXMl5rSLqhuukjjmomQMumlocwuP14Ez1z0?=
 =?us-ascii?Q?fJGWp403u55p6exTR10HB+NiOx/hzTHNwS33mvlA9Pu+PYtUbeQ3Q6DSgkFv?=
 =?us-ascii?Q?Lyja/egxytxbkt1wKBz8Nu5ht2cvJa379iBROuQiU682rHjSGXWvOyPJRmbu?=
 =?us-ascii?Q?SdUuidnkh3Pb23hqFtPXSIJ1ZzbCg0rzum/mG+MqUbH9WlT2csIk6lFyJ60f?=
 =?us-ascii?Q?MbYoF+m6fFfH338RK5P0yYYQPkz+qdYrjzUYxz/zFPg86Q79gv3HWgxth+lW?=
 =?us-ascii?Q?1FmF0tKG02RWxnlbbzbY4SmX4Be53qV2vzokAKqODvyYcTvjKiBSD4eZfkiX?=
 =?us-ascii?Q?R+Welo+QUKcnCEHocebb9GqzpBxJ3s/nFQeZePuIx6EG+XcnXarIjwfVeOkE?=
 =?us-ascii?Q?eyk76GLVdmD+blHGfLmE36ow4WikfFmP580uClMm0wBK58gR0+uLwIQ76r0u?=
 =?us-ascii?Q?LttlSrBxGE9qDh97i5Zisk9M0FnV0QeYWvK8DvH/ocATNSunTW0POUVWx6AN?=
 =?us-ascii?Q?5wzIV0gyYNyfoi99eLGjtzaXqUi+j6tYpC1s2TQWqU3wenIBRKaAt9+nHWaB?=
 =?us-ascii?Q?WUmLxIS+Cwi24TaVbBzVS3OPnk2MGGbPZ+ubtRtlqzPgIJ7mRFyFcb/pItfr?=
 =?us-ascii?Q?In6YfMX6XXly/wWzf2AH1g8/6vCfYzubXOLfcTeVLkw5fF7lH6h091J2Jg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3b6emCcBD6xNSS27YyO9PIGvY6de6P82v7fiGdvuqfcU23mb/+U8M+jfSazk?=
 =?us-ascii?Q?COYlLKWOWcH8MInNi7cTEvBDOtERQ57FUJAznSn31J7rLxq4cCxMQN2mOVrq?=
 =?us-ascii?Q?DO/kB7Y3CLG2WYf3Uu5YV8WyWdXIXCxZY6gj25rGvVxi97KB/AhqNnnEdR+Y?=
 =?us-ascii?Q?93Tyf/xJPFo8YC4aZ0UhtjlCQBjzjjZPYLfqwe4/9k7MmhdqbxePqst1scIq?=
 =?us-ascii?Q?qL+/AJxan6L2zS3L4cih3vrXspQSrVsst1mPX095e5VP8zJTOTofXq1/amHr?=
 =?us-ascii?Q?YUrLwCiG2/yRhsl07ZQRbjrXyiz1Tylqn0vZjVaEsHXjpQIDlcr/v/lGs5NW?=
 =?us-ascii?Q?wVuE0HW0mEZO+h6psnjwXARiaLIHDfdmYJ87R2ftP5MJ+6blVW1qrqVKLhap?=
 =?us-ascii?Q?OtGH1E2lbdS2O+BD15Jc96eczlDd7Zmq/KsdNm8gYPFCxia6HOsqeVMhR9cC?=
 =?us-ascii?Q?A9ETxN6abuR6jDPwgKA3Q52Q2sEaB1j+Dr78FfkZsztObB8hbfwiVQOoxjRr?=
 =?us-ascii?Q?ClWNOoo/wh0mbpxp4av4J06OXwkTgVAreQaIXtpT5NYXsCvr/RAkjV0u00jZ?=
 =?us-ascii?Q?gITUXfVbdztVc40NJfT3IfggKhTVdxUmD7cyUhQaQg94+qQf4IaGBHaQmQ0J?=
 =?us-ascii?Q?OdjM4g+SDuY9DF+zBdXQ1Vs7cn4SpX++SxBe7UxhoBatA2+rXiQyfgY9nGIA?=
 =?us-ascii?Q?zbQLZ9kWLnU1xS46JH1J8SuzCCDoGCD1CwxES0Qko+I9i1/bvDJtjNiru4Ho?=
 =?us-ascii?Q?A4wMsCMpa1ZsxHxt6OMgOonX0+D4JMBNA0KRl4gQgYwXrf+NHLo7papV8IqN?=
 =?us-ascii?Q?3WWklE36itiQeA2lHgxXoP9Y8Kcta9MKBShT7yzJv2MOdiDnl5Lk+klNf0GS?=
 =?us-ascii?Q?AJETlntJMmHsOoG/egDFPIM0Jz36gKId1brrN+tvZfBycRZW2mcLVO7hC0Cn?=
 =?us-ascii?Q?Ru3XimsMbF4smR5cqMb9XXYrzKf3bDRhwr6gnTDtvK8x6Wz0SJAcBE3vzDCb?=
 =?us-ascii?Q?Jv5rYe7BcQrQiI1f6KDIap8bgX9AYctyFqclFE+gABs3s8mk0ea/8vaMWz+A?=
 =?us-ascii?Q?ZeVhv24nrGwIGpwzA/X4QJGysislKc9jtJSLCpkKE4y5rnt+TpY2b3M/QPx2?=
 =?us-ascii?Q?jQ8+6YCdiyXby2u38GXOwLK9QfemNP/TxfF1JFt26Yr+nqXsy9hvgkBrzQPR?=
 =?us-ascii?Q?m5S/2TXYo/ZG0Le/vijWtcEKfx3r7gYRaW9S5952bDs750wMOIOInzCgX4fM?=
 =?us-ascii?Q?OBkxXMWXqnS9lERsebb/GkzCFvqMm4eFtzYP0tAqstf50syiCMEi+57GA30l?=
 =?us-ascii?Q?Gk+myRkkLmHR0WEZCb2MQRVc1pyIxeejx4Rwofy999u/ZlvPBsJgzCeZQp68?=
 =?us-ascii?Q?CnlTkPt6SpJdtgwH4o5tOAMw/5NT6ZR1qaqKZxPIlv3mxbLR5I56AA1cj8n+?=
 =?us-ascii?Q?eYqWVJadHBI18NYhNg61C4fIl0NMziQEVY+rJ9xlPZ7qNaXPJlm8Ckmm7oYt?=
 =?us-ascii?Q?iy8Ta/DLlT+D/6UA5od6+2dloPauBKV3ZSTh4Dec90uCfpIVqziaEt4G7TX5?=
 =?us-ascii?Q?MQbIaaPIq5TfVtqaiUCHHULhcmu88rVaegTRPW3gPwzIJGO4OHaYyj31kTFm?=
 =?us-ascii?Q?dMy4zwuYwRO9tLPSD98cIwI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c31df96f-4f60-433e-54fd-08de07f45beb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:43.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbeVGMSQsPVcCk237TKqKlxf+W5mp11kWaMzO580/qh1ekYRSxsZCvK7slTTQP2ERxPiPtB8uxduxmArEhsnAytsCP5zaRZ9oEqobdzX8+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

This aligns the logic to match the Linux kernel implementation.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4e8d7444bd6..6d80b7c6d30 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -542,12 +542,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -555,15 +555,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -595,11 +598,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -607,11 +610,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.51.0

