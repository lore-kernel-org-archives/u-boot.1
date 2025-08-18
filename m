Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E036CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791CF82F14;
	Mon, 18 Aug 2025 12:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="scSrQn8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F335E82AC4; Mon, 18 Aug 2025 12:06:45 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1CB982E37
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzpFd/P35xzToWu55h3pm+lGgJ+5QKw5x4RkXUaFFWZvlo89wkXzDtm/P8ukvHfsl55e2QGsPL7DeEb6rKShtzoSkYfsx9pP3SMrc325QMDQ3AV/E/dtIr45Au1T3kOkd4a8YPMTK/WrFI/D06JsKNIgsy3evm6DxRqDfOmgci0SGAPQ4KnvzsUplulXd/C+kOh64MUJD09ZweQJKecMYzBRUpIAmYCAegr6AcvFy8NOkl2bC2RTt+Ez/2fSeoh/J/rvrFRdCApMXyjhpfvkV+ecrmuLJxbgOp7v1fH9maqM4VREqdXrOCd2gydwR0BTR8wMAdm4BnZ0kG7vwNio+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLLEgLywmmLbzMdHQdBSux3CH0Snyy+GcU5i7STF3dw=;
 b=xadQSs6zJZaCpcBgrnFNi/DvcNO6+P/UZmV/WaDN9INH/NC+s+hRfyfJzq6zqCvXmPRM7a9XqQ2iP6fqiCuds+DQoWKQDvy9sMeqyHUqUHWftSkndCMT9l56J5813DsY71nbRjUfxAVKrwByvTVzgV9Ja15HSXVSf7CFp92F7O2Cd4OczB+VxvukaCxFSwvJMM4sc4mplneNUwyXiujNSmjVNMfKTa/iANsr5EI6zeFdyboxGePn8iB13gx+unPouM0wTux8M4Dw/kjjMpheDuEII+0oTMwXkR5i+Bv8KwYAEJactE9SEsVACyFFrXlK3tQXE1reacJDdT/yYjTmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLLEgLywmmLbzMdHQdBSux3CH0Snyy+GcU5i7STF3dw=;
 b=scSrQn8DpWdF3AKe9054eE2skIIKx6pi/S+vhELNXhu+PwGcxHfhq/NLak901s0i5h/otWfqGK02kfILJNgNUzry/L5p4nVttosRfVZhsB2wfIb6HmZpUCKvT10S7SxDiS1TQHWP2ooSWtoWJDhHuq8h1GCu4+eVdmcLcGDL2WEdgDAluzJex9Te+Ip6W281RSpa0riOiLnNaFyx98UGggFl3GQ8ttcmMm0+PZQbt8VXoeqdpnffflos+4ieQoWnE83xIn6FqS54H8CgcgMPxPZxlXOanypqWyAlf+jN8VarwK45eGvy2juJ0M+zJHEPtIagcGJ30utggbWEgwJaaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 11/21] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Mon, 18 Aug 2025 13:06:03 +0300
Message-ID: <20250818100614.432931-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c160946-4026-4205-fd6b-08ddde3eed3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TdpTkHQyclMDAgoQIftAf3t3JlNIawT3UqG7CN/N5MFr5LuLpt711acbYYvM?=
 =?us-ascii?Q?267LpIipPtrUzRh3mGjVqyb5sMAJDwYFFZCZyYhmhOsrOqaC8hzdgPxRK7P5?=
 =?us-ascii?Q?ulLjoKXgjDcuAG3SvXpxgC1jrRStsHF4PpdXJnTDMX8Ca77cX11l9fyxq9yo?=
 =?us-ascii?Q?FTX2BBSjzOsHQZP4RmG3MCwkm3o5vSVLIFsxox1imA08Dmju7i2yx/SPu4vZ?=
 =?us-ascii?Q?jGdCz4CQGCGEjrbJOVh1lA2tEUdXDP+9Str5xz3forNA5nAG3NLaFEp+WkIS?=
 =?us-ascii?Q?RTxHkJpri4S7LsTNA/nMYLnnxOho8aK37nMPab0eNMbZSZw/qaheeCiRCYo9?=
 =?us-ascii?Q?KR/wnuKqQaRDiZqRR7yzvshLIFXo8HsNZOoEQxajzl5hTve7q8wuNVz5dQ/w?=
 =?us-ascii?Q?t3hgRPrljxK2BlHxE/oFcDoCSOo+xExIM1+ramhCPid/Gv7WSHT3V7XBPh25?=
 =?us-ascii?Q?esUX/cIgQf7oVdW5RholD1IoYI9fjMh6fNrZyTCcPJXG1/dmMT1mTpv6UBF6?=
 =?us-ascii?Q?HKA9Vvhrz4ofk8b/PxcmjhjHAnqxo35n+VTnrkY5WRrylQyiI2UqkYa5Nh6E?=
 =?us-ascii?Q?eUXgyRdFtlQOlbokGkoE3OfiDMvl60FaxzoyAJY1VO7bjilfReVh/tgaEsEd?=
 =?us-ascii?Q?+sJPVFzALQgkTyAdpC5DKg1rB9vMCJ84btA6+RPmitr4ulA/qufwrzE1Oj0u?=
 =?us-ascii?Q?6YcaPs+ogPpmsoAiRlFKlKSxE4rEIihP8t+0/YNoJCY6PYSbrhk5j1DrUKE6?=
 =?us-ascii?Q?9VnwHRCekYqi/8FTKoKn/6o1ub7MXn4luC2etjdmF+IJGUuPk1eCTMBbBuO0?=
 =?us-ascii?Q?EdY0CXHDbqJIZ1jbqAUOaQjBGiJUqOjFAD23auAnzLjwPCZIdCYP9hymoar7?=
 =?us-ascii?Q?tUR9gEAEuu9oRSrqEyGRQBfzXevAxnFzoWeSkLudqvcFWwUdwkSKaTth2Sfy?=
 =?us-ascii?Q?BJNZuuuIefEwy23X0QYSZjrzzIjUsO8Lf3k9Gi7ROjHuXV+tZaZDOlCgANRf?=
 =?us-ascii?Q?xUyl62j2UJ4s2z2cwm0y49c5KlLqg+rhQl5tDrKrSbDo3JaAoyqNGkYVoGzk?=
 =?us-ascii?Q?P8b0y3czIG9a0s//0o/1vGf2sGhY0VjxsvyWA2r6JAwwEp6q2umJ6RGHpkrn?=
 =?us-ascii?Q?gztmngYvF6avOBT8tyax/ATeUtoMtWTll7K7gRHVYdQGi/giip2V0umrEYla?=
 =?us-ascii?Q?BqF5H517RhAkoZAEguHGvIswF7O3sfT8HlXDhp4btj8Tk0Gnho/L7/qvSqAK?=
 =?us-ascii?Q?VmkgjmQcMXFj0y60vjkaBtjLbFWGpDth3kJ7ezfmaG/fPDHUynKYoP4mY/dM?=
 =?us-ascii?Q?Eo2S48QPdBd85Bzx3qY7CM0vOdiuSDzwkce4OSrS/sHBBtwDd/stqdi/iqkz?=
 =?us-ascii?Q?ecjTbmw4EBG4rH0o8wjT2WBO5dBVRYqBkRwxYtX26nVfdC0Pcl+1I6zi9gIL?=
 =?us-ascii?Q?TI4mRVEsn4xmXD99aGVjg3VM+xUpk28f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWIk/YXD8QrcKnMU7dwsh8k4KfbcEkTo6FA+9OpI7fCV6Df2yqncA77q7UJl?=
 =?us-ascii?Q?0wi2qGtrw+TRRwezIsPMK1SgK818uwA6RbQnMnh3DyOErcD96Q3MBtAgdDvn?=
 =?us-ascii?Q?DAJhN9WOzz21Q2KjNFCuyE/DGXAQGui74N/YddDfN2O422g0Ag1WTVC3REXI?=
 =?us-ascii?Q?WoIEdI1B8cx3dq5dU3SfwN56KYQa5G/0XvJ0mV/BTgDntyBzPt4Wh3f6N1Bh?=
 =?us-ascii?Q?5iFusFRxII0MWDcHecB6om/hv686BYXsU8UrLrqYzXXEgBDLEKFXweoVOkvd?=
 =?us-ascii?Q?hqnva7rhMa3TJpamRl0Z96LA13sHQ/Bge9MGMjbhr3cbiA/kb+ZbJYvEY1vV?=
 =?us-ascii?Q?Dm7BEqAtKAAmXgvvciWv0S50V+XuIz1eRyK/iK2nNIrRyssvc06sYt+4gox/?=
 =?us-ascii?Q?AZ1pIRId5a3ZstLZu1GX0t0sIentyQ80qZcl/4oydlhKK7iTf57gkBxPXHHX?=
 =?us-ascii?Q?Pe8nMmItzyunycw3fwHEtIW7d7GwAMqorL2a4RXHBuU82tBXnBPYinGmNwvn?=
 =?us-ascii?Q?zvOuAMKvmmJXOPRuMmUCE9qzwsrbMjkt+/9npsSt9mLLzHl2nqJR+7jpZGbR?=
 =?us-ascii?Q?3KneKcLTD3XvJdS8pJhZ7me1I6N0xnz3VJRn0XtrmAfUFR4QyhHlqTswJPL5?=
 =?us-ascii?Q?Xspr7+FUBwDSccswJUh7+pJYg3rCFl6AjdG3vt6g/LIXhA9/RPUo6xvW4NvM?=
 =?us-ascii?Q?Tg4TU0tfvuZM0vIeEDA3wa6d3hQHr8JNkq3QHLpvNv7maHGwfbcyvzRlEqU2?=
 =?us-ascii?Q?7rKG6rWmT47RR+NMZxgU7f1WpynKpAWvFPaDk8fqtQTlPmFvVaRUjBqYOiTw?=
 =?us-ascii?Q?RkvsAZ4VjL9LfOjNA7oR0UZ6hYdo2WKLUxxkX/ZnIzk1IpSZsjB17oNJNBUE?=
 =?us-ascii?Q?QXCpH/WP6NGKFS0BxvOun/rmbaZwPRdvxr/8EMVh5EHqBS7VXEfz7GPTlozg?=
 =?us-ascii?Q?53TBMZmEWcV83IFlwqFfYiRNbOJuULfhGklg5X5PEsGO3qNbiNTCUlw3BurU?=
 =?us-ascii?Q?xGvyMTGwFr34TAOVBbfFJ1nAdFlPnRdVRcF///wEibqMOUd/A8bsJrtPbtgS?=
 =?us-ascii?Q?Jl/JYGY2ng5tmIe6A3g0CR74p8Hxo6XZeqhFeQCMUGTsnWHY/CpLUVIjdc0O?=
 =?us-ascii?Q?hSffcBg3dPwRkMiH7Uxxr8cy3uvcvaJUFZfK9vupkcbXxT4xOuq8eEAc0OwC?=
 =?us-ascii?Q?GQmi8/7/qkK16DwvU68+L/muNpknRpxDXvUjxJRmmBerPrcoRjC93OECM44W?=
 =?us-ascii?Q?KUXlvtj7+XGEmYE8ezM86FSr7aa9g//PWVU5LyXyei9kJQZTakYdD3pMwrHS?=
 =?us-ascii?Q?Z18pxjSdTPmQ/KYdGwzrSUTSXb10z2fU7ZnKQ3neJO73+Od2Q+2NCIREJVLH?=
 =?us-ascii?Q?Qz2G8GE6sY/ZEFBJsOxDqdGJJdmuKgKeb1ooCqNqlgEdVZnHnvAospHg5QyM?=
 =?us-ascii?Q?fEm0z55edTrhj0O69fvxjir0qC0cq6eyN5khPQVK5+hZTzQumEIzkVlEyAVh?=
 =?us-ascii?Q?0rekrIFGlBFCgd/2P+3SzJ/vuBYyBrt/08/qFFoRzbBcd8XSOgBZeQDUCTZ2?=
 =?us-ascii?Q?wjiPPsXRdpOSJmF14Tb49IDAq7VNf/9tsW9McoPfvJNoCdfs6l+v8RysFjZw?=
 =?us-ascii?Q?sJ8b8z8aAOFBsEzdpaNhHfI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c160946-4026-4205-fd6b-08ddde3eed3f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:40.8718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czly0jsbGeXQMRhvLclyU7+VErrS83wFlCoGlffBPOSQWOXjOgk7zp+ErPZVf4PCHwPURDPxfhpvQoz+Cvwz38DWona7+nzkEMUjTcRZ9SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

From: Daniel Golle <daniel@makrotopia.org>

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit
1824520e7477 (mtd: spinand: set bitflip_threshold to 75% of ECC strength)

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/2117e387260b0a96f95b8e1652ff79e0e2d71d53.1723427450.git.daniel@makrotopia.org
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b5daab21743..2a2ab664c2c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1291,6 +1291,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.50.1

