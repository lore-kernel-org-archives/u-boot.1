Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37504C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08793889FA;
	Wed, 31 Jul 2024 12:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="W1eieqKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CB9889DC; Wed, 31 Jul 2024 12:20:27 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5EC889D2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYP5k2AQiRmKyMRfSN/Z4MfIV30UG4y2rtaIA5ygeDh5krrAxnBP0KdiN1fDLjPxNRkUJFTLMHOKZw6hcGo/5PPF0DlsKWD97utmxd81I2nSpzugvx6O+U55sxw0rlziw/PN+ZXgv0knOPLqez7Q+moykobr25EXKrB7hpS/+o6HUQoS7hfctdWTwsXCmZUE2G5ypMvoKIIvw1HqR/lMODaaLuhUuR/ZUJSQe0MO+zeyzd89CRcCW1Cz/y59F6NyMA3rT6GYcj4NKOZJGqbVUtD3HaX5VhW3/u6zQ96/7dlZHdrL84PBM5cBgwgXgr0hDlcR8f32s+LQPTXLLCKaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+aCfZbhjmdzdPBJwDBzwy4NvuNWc+JQczEsny/+QTE=;
 b=Wo9vhvoydkDIQeduXtGScXQZG72EEOL+JdYi+JJ7xa5u52IzAzfxTEE6p1ZQd1Lr76OX3U7ynDgoTPg/rVPjSgx88VEGMuAoi3f6wCcZs7EdIKZYmkx2D3Rp+GAjzkVAxD66a1kiKjqEAn9YGbBEc1+IIQGn3huEMUdb4I4gvdBBh1gAd6s0vG9L/CR8MvZSwNm6Sm12Y3BewOXv2TnzS8ned6P8XZDOGNwSIbe/qnvoCBD46EvwpRJRfJSMTX3kF2ruBwJyEQMR8cAXhYeX8L3hGO1Luc96G2H6oZdehRtAcDJjMNpXeC7lF0jKeEDQShag/DXpkqmPeLWfX+p9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+aCfZbhjmdzdPBJwDBzwy4NvuNWc+JQczEsny/+QTE=;
 b=W1eieqKMzGTXO6YMV+4E99Wf/igsM8sR+zaJ4LS8S6rNPKhyXmJUshsvoh5n0zQ7ocTUdTxnbjNLYaEHlibh5eReS+Xy+7w6EUumB8f+17hDWNaORn/gAD2xhfgfYGmJyV+w3f3ieqz1Rkk1FEuo1An0BfHrVm+FW4rb7roppVV45MYHFfBU+KGHgnYadWq24NV63pIOTR7xxkwaETxsyB+v6SRogxScpqZwb1laoqyCEXcU/PE1w+Is8D99eImyS1h1W2mTU5U6i/cfVE8yl6wbU6oDM+EkozXjD704U3V+/hj9y7/hgLTJONd7eIXKatsEf8zTcWp51ly+z9JYXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10002.eurprd08.prod.outlook.com (2603:10a6:20b:63b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 10:20:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 10:20:21 +0000
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
Subject: [PATCH v4 04/10] mtd: spinand: simulate behavior of linux's function
 spinand_wait()
Date: Wed, 31 Jul 2024 14:19:55 +0400
Message-Id: <20240731102001.4030460-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731102001.4030460-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10002:EE_
X-MS-Office365-Filtering-Correlation-Id: 361b4c90-814c-4e94-6742-08dcb14a61d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?36afIXnN4jfkhBLQNWnlSByylwRrI0tAtgh6E0S0pUjJXZIo48QFx/Iqd/wH?=
 =?us-ascii?Q?Pu7WSYjoghmMRGLZHY5gcqId0dk3J/vNB7dThQelmrVUz2AUPWoT5VPfHZW6?=
 =?us-ascii?Q?mBfrBrZKKJOJb1vwjlzrQcZKnyluFewe2CpVamyqQrzX6ol3eHVV8/vBcsKb?=
 =?us-ascii?Q?DR03kj8aC/lV0dxjg7r2AvxvliFEPz3uJ1/uq5kiR6Da1ubHekjL/3J81lxa?=
 =?us-ascii?Q?bXqj2/+7dFQnnLF6oDyuUwDic3xeC12wQsqxiojuCjXnwiSdtE/K3H80WE2G?=
 =?us-ascii?Q?JAYuNeEYfrOES7PcbJZMRM2E3kylnd+8PTElRbEmyf3/jW4w0oFxV+scuWUM?=
 =?us-ascii?Q?jVS8hCS7RrdBQNMeDzbeKCaPZgUOWAG42km6J0SMg9quwXfhEj/C4BglOfaV?=
 =?us-ascii?Q?e9QoSE6+WHDeLPheOoyFeGL7QKWYRNshDJyBvomomwfvVPm2P986Eo9ldhej?=
 =?us-ascii?Q?YyV9WZm3LwJzjoL+kQ6llVKLkC6PPAHyjOkNsrtMEVzDPtz3zdu64offC7FR?=
 =?us-ascii?Q?R+lAAMMO31bYTo1xZJV+RNnqlY5PQOOfN5UpFtSQjxEIzwvQCHizOYsD87RC?=
 =?us-ascii?Q?6HJGb9TKDVsQZynL2YxdJfgd0RFBNCIVuMztgZCfe6Fu6e7ORwiCWyCMs0KJ?=
 =?us-ascii?Q?omHcz5v2jSauYPTdam0gOpw+cS2mTcWYOiKtz/RYPjYM4BuWmRJYSm1scagX?=
 =?us-ascii?Q?7C2wqbg0xIPU8XFqed0MPoFetUnjCLJVP6f8ulQ4qKxlzCsbqO5QVCDYd3FH?=
 =?us-ascii?Q?VRGeunL9bv09MngwztJLkxJlPVGDS6VTetJqiLCDcyZWPGKtFdEWgiU0osIw?=
 =?us-ascii?Q?Z+v2Uq4zb0cHHg9WBnBP9SB6RlGjwpWwUKo6yCvhwGEhb8nTJL86UmHc3WY5?=
 =?us-ascii?Q?ew003rqi6zwRF55IfNqkFrKhvB74x3aHyklaWqLB3+sqEwmwj5JcqjFhjWtH?=
 =?us-ascii?Q?+gov4Wrcom1/M3+2wy4p1wTKldjSiisjBL4BBrUw1tFVJxAp2tX86FAhm9mS?=
 =?us-ascii?Q?ZP+zf6R7p1DpBx7tDDA0wwlpu5b2lCCidR2pWB8w/RYGshg7fA0+Oe9AXlt8?=
 =?us-ascii?Q?vo04FeKEWXf1FA8cYF+nFzsniFEGXvsC97uFqwcmTrqP49T6TC0QTbZ/dq3M?=
 =?us-ascii?Q?vHoFMcP6ISWRcUzEuuV+i/aOwC6IH1YZ7Jo/JkWWmQnORKxQ0JJE2dStpLPQ?=
 =?us-ascii?Q?vb32UJUa4W/CyM7o13QhElno9XcXXHDT6/w0giUBVuhcunSgHHeDpxL6BcgY?=
 =?us-ascii?Q?HsC1IXIlgywLo3+5RDHs5BYG1xKq1jdEuVoEfVwaTVxPb4WyPd0lRqE8f7JC?=
 =?us-ascii?Q?4KJqcrvZWYcpdj0eQEI3FxuBcBLKnnVeJWM79CpYs0evyU9HQEF8Dd2W1vGI?=
 =?us-ascii?Q?K0SSceqRE2WaXLg4Fnw+mC8/0X5QowpHxiOzHNUudnAbQFS2mpzMFwHrQfYD?=
 =?us-ascii?Q?mjaP46jkzlw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TrM+MoQoqMagMVr1QKH3MDF02IBnx7ppcEeJDrvmweSh4rx3xNLIIOwP11tf?=
 =?us-ascii?Q?gTl+TEooGN+rnXZr+R42Mvx8WikHqZRKz+XvTwsnH2Gh1hNo+nc2ZuXBCQ4l?=
 =?us-ascii?Q?rW09QFf+ErTFlAyb5mcpcKOQ+eHIml7z94qOijJcbu4khBOHQUxrHZLsarlN?=
 =?us-ascii?Q?ZzqwV3pSdH7I/qSwh4tsG1TRXEDHMKOUopMwe5kCPnW8YdjFRm8m+3C3KPcV?=
 =?us-ascii?Q?3ptGWMTIhdh8oNK+d4tO2qicrnj+vXbfDLw9TNZAO+Byyia/01sCVZ0uPjf+?=
 =?us-ascii?Q?brnnhqR8CvN5Lg5kLfsHF+WWz4KCaIz7btzUI3Ej/6Ykt5BF37aF8ZGvRMij?=
 =?us-ascii?Q?FXYnwGGkZ3+Rop0soHa6PH6PtbL6bwXtN1DkOJzLSdlCXgAWgLu3C0rUtx7u?=
 =?us-ascii?Q?XvMl+iQ3AGDoOT7DiEAUkMqJgnY6Nsq2pf2sXxUnQgknTaw6eJ1fgdTN1pfk?=
 =?us-ascii?Q?+phJrf22H6fZWNxaAtw+5FTf3cnBC0+z38rMdTSBnYDS5VnvJKMr1fZ9ruu1?=
 =?us-ascii?Q?d9E2+04QRVrqeD3NT2a18Po5HZfxnS0KRZw4XVm3eLZauW4xyobq9HlDln5G?=
 =?us-ascii?Q?1laZAR3OPNJtgVlHbMxVLSa73F5DJAvtfZ9JARESBQKe/Adp6J3b+Zne4FV7?=
 =?us-ascii?Q?td6Zcdre9STHFb6CVoagtMlNijToXvUKY+ZhtNbSvva8NFwNXTsn28NcilSZ?=
 =?us-ascii?Q?84nfbBObAuBMYNZtgjYxysUP+o5dlXmFw1F9HTQRyv+WQOeQN1jYxQIU1Fh0?=
 =?us-ascii?Q?V02XUR+baAoCk8rrfmo7YRLOYRbpcU7QH5T2xNqTBa5sn+GaNne//e9oIjrN?=
 =?us-ascii?Q?1MEQ1phtR2hS03jRB5kn7Ot0DZpRW63bjs1xrH9Y7yXC0PFA/jtHXU1NP7mN?=
 =?us-ascii?Q?IeQo5eQa3QYTzFOieg+VgUwo6hsaT1y3xQ/xyFs9EDWf4+eDWHg2dfMa2YWW?=
 =?us-ascii?Q?5ZmOH9Uvg9uY4ulsUqCHdSmzocmt1thrf/nxLFntw996WHra1SMMrGHCy5s0?=
 =?us-ascii?Q?eMjD8f+IIZrWxt1aDM+b/zRjpq0TsDI/4Ef3FW+n06bSFrvH4Q8PlP0naCdf?=
 =?us-ascii?Q?KksSH2t18uPVki8yshBnKUyxhcNHJmEVKXGQHew9r2BgqOR9ffHcaC/PjVVe?=
 =?us-ascii?Q?4YGhEv9Z3MDotEmzfoDyX8FMb7S0Ea5OxlVvg1HeFiAg178d49JunBoV1Mf1?=
 =?us-ascii?Q?a14gvn7Tb0sS3CoH1h8nF2R32QT2+Jjszi6+sYMtOFy0BYGfIB4IyyCYkUgW?=
 =?us-ascii?Q?JcDXMo5cClOfF+7tz8vP0dWduVtI6HpaE/t+kLvQiCw+sBgmcyFGSGwAqDbt?=
 =?us-ascii?Q?V0oenFqmZEJkNE7MEZDDySej/cLZDZ+S7zsUCX3C+tBX4d0TBEh63kZmN4dF?=
 =?us-ascii?Q?k/buTfS1P5nKByhVoj7PzSD0oSkGWGKEtrqpF8wo70VjFTy2gA1w4pAzsb4p?=
 =?us-ascii?Q?prF5SpQuyRzPFWTBbX1V5BZdlQpfAw322eI1KJXfKRPmU1us7IS9F8Ei54eu?=
 =?us-ascii?Q?KNSWcSRUSySF1/nBg7NNNJ/8RKfFhJqBs/JaYDG1ZLbC4F02pL4tICBWU5FK?=
 =?us-ascii?Q?L1wsl4HbXMZE6WEojvnreWIGs4SUm2iyOHq5CIlKc5ro9iRC18i+P5ppPKvU?=
 =?us-ascii?Q?qagu/LY/OHsAR61ssvUrUYM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 361b4c90-814c-4e94-6742-08dcb14a61d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 10:20:20.9792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgaFO2fiHeHkeOx/09s2bKqG+2/rmmiFrRCoXamAnyUYRZrY8XBnC8bohGk0ywolIjiUo0CccdzlyJFWiyY9BsDFlGGrrJ6K0cArgYtjATw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10002
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4741d3e087c..bc16d9888d5 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -31,6 +31,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 /* SPI NAND index visible in MTD names */
@@ -357,21 +358,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -413,7 +422,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -461,7 +473,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -493,9 +508,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -697,7 +715,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5934b7604cc..b701d25f73d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.39.2

