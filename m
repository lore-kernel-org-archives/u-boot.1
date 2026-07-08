Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB4C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD6C849D2;
	Wed,  8 Jul 2026 14:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L8dn7bXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFB4849F3; Wed,  8 Jul 2026 03:13:00 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB3C8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uen9G++A9Lay+3n+CbzYQhELQIG3Bw8gAFOKzAGSMLpWLEEpAtcDKKl6W8BWIAQOkSN4hPE0vAbvJiO2o6WMLuinOykAXnKiHblG8Qvd5yrcpLUuKl2xikelYfkphESar5N5BuhDXZaXxAYksPxA2sTMngr5YKTDefsE2uNQOskJO8xA+QGOtodgB5FtjE9RSUwhZINjy0Obd9H2VhzC/msznGlGlpzAk9ZcLfpwxtVdxmQKM4vy/3g6+qVY88+3hMj4qHndYCn0gigVZQ1On6Aacscy8HWZOEaQHb364Pq+Oe/Nu7nemE4EMzxc7uC3OW+G9+7z9RJEFxz75c2wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VIMEEAkXvgC2uta/7Lh/9bSJ2qd6X3elXRAX+eQz5A=;
 b=rtqCl1oI2UQqKTLDCqGCZ9LAW+GoPYufTCDT16pqG5Xg1NBpOrv7UZ57j+gLDxyyCZQKsZYaIlSlHsYjYCh5FPAMUBLyUSSgLbA8rsdb21Lfrn7A1Daym/f2sEpvcsPYgcOtEPQMgIGaxPeKb9fDetGSlInoL0e/1ndFU+j2N1iCmQMia4sOcZ9yIKQHNaKQPHBKAOIQNHMX42MOANmzu/UOq9uv78/krVwMgX3+5WOwyEfabSE2dP9ntX2sDfi1YaiVzL5RxXsVVelk6cWXtsZo+gF6EgSJdivHXFUC1OmGW96zI/cNjkPrONGsZSAk0Up82VNDv7EQjpZGDV4b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VIMEEAkXvgC2uta/7Lh/9bSJ2qd6X3elXRAX+eQz5A=;
 b=L8dn7bXdW0nkurp8ZRPEq3UhRDd/3n7hK7H1w2FeJc+JMH7rxPDGOA7AQBURRVnZRBZb2+KkWj8WORz6uO/o0GZCIqEu4493+rIYhCDmkGkd8Rg3tDIPXs6kOk8kTV//KiY33D9nBtLRHcHGYhzQLfgpxT/kla9tCEGgMfhKjUcuo9YASQPxLKH1tKVsPxBPo6pyQzNb+J+xt0YSVOo6YxJfaFX7DbgAHLPzerBqkGt51hhLJyYg0I42Wij470XiRI5qKn6Z0dSRSGJEcvoOhVPBv6dxkOM/npiKuAm+pgQa5YpIOGYFCPriRj5oPznqezKRuulhgDRr+YbZ1wxcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:12:55 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:12:55 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 01/15] misc: fs_loader: Add QSPI RAW partition loading support
Date: Wed,  8 Jul 2026 09:12:14 +0800
Message-ID: <20260708011228.15613-2-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c19bd5-0dac-48b9-270a-08dedc8e0a09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|9063799003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: R8X2PoxCxOMBgyaki2lz1Me4acd+k7KnQOBn7P1Vy1JuW6UPOP1/DsFBbmyDZkBbOOQlaz0KbBQBVKQl8hyDgF1hhFl1GDDD8EyflSfcCu5kMLW7SyWsPhHdd9kbVYveCWTduUhF4SMytIuviJYEWbb6R2UZKCPkuuOVW5JqlNLqOrqUyo+oZ++/6iiE0F28wCjj2asl7ZeZSh4sAssE/mrejPKMvafel1JgcJDzSRpFDiHxJkKGizGB2kENvlI0U7KCCF+0250pUIoTFW7ItMm1rEawugY/DUXmxr59kwvHpXSIuCXaJvmRFXV6m8k+OIQTO3UTfcXhtRZyBHG8ivZEk3iC/7bILn8pU1pai3uuI9xWuGxfM8tG9fPnIgcwTEOTaH28O6ejRWPGuKsCWWEiD7mnX9dH6Ekrt/KnUO3JawMW17C4qV6qXZhNlyLHWExKbQP/izLvXq44A1/MQH/CeOBpOfEw182pTVaDIsDAmZAvPXPDqlj6SczDD25bc7wHLS8BZuwtVkYYMAw808c49kgo0JP4r7+KX/ZCXHvu0m1B9Znfm9ZNgGQzHsJ1SYda1pQlVGFuDeRFeLIMqaIIf32fgMg6OMHBibmSo4c3YdN+vFNpCwOv4r20pFu/cWj2B65F3CNhxJw0LzgECGq08OyFDm00ChQh3ldyHu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(9063799003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1wq9LjI/RJTkIuLOQWqManCdWjCYc/dLrxMnfEEbiAE4M3oCudZq9lIIgYC?=
 =?us-ascii?Q?FlnnDLuaFqxb7vbEdcvNv/bnFhGI1UQoKi8d0VrwlLLxdfiM22WnEM5RNamn?=
 =?us-ascii?Q?uSTpgVibNwaKzmVmIwL81MaeLgezQGLvevGcV4IXeawTg8oTQNvrizYmO7Ae?=
 =?us-ascii?Q?9BalYcm5RXZZQ337Mdxq0O0iA4Fbb3upKM4/ghG+QYW/F05ezJSLFGG3IKgz?=
 =?us-ascii?Q?2Q6YogawkJw8AdlVkCaxV/1S7cGqwDiVILEWVbJQLkJcPBeGnuy0RIuMaJNd?=
 =?us-ascii?Q?pjdGKTIqVxhxfu7LOo2+tvxBT6rntnoJQ61IYiDcbrzeHs/GvX/cBy0VyWsc?=
 =?us-ascii?Q?56kDWpjXoN+8cTxoKZdtT39GgI5iBZZ1Ab2jWBWBc3b+7hJ7KEvLU8SPZ8xA?=
 =?us-ascii?Q?l0/J8oxANPgwl645BE+yyZqpgXia+zDl0fIRYlD/lLxTbceWc0d7IxpgxEao?=
 =?us-ascii?Q?VXXHMetKNFONsya+fL1/fgrZGeeiWlgl3guPBIWK8luH+KF40aDT9HhT2bTV?=
 =?us-ascii?Q?R8DIu0wAcNRud110UkDC7lJV/wEodm3lP7voua96v3UiJWidGx0q/xQboC7o?=
 =?us-ascii?Q?KlrUW0RYltdMnFVwv3STN64dNH0Ovyi7kCFLrlxGOWrrhq/sO580nQlPw/JF?=
 =?us-ascii?Q?mohhz0tzxUbgf+rn++U9PI8pgEyz8cUzYKGEHKSZcxHaUxkOmokaCkFC/F2u?=
 =?us-ascii?Q?gKhLYttmdFcxdM0LkcoWJTpE/CrdI7bh2ghhcO4zBDPlUdrImSeMrk8zV/2z?=
 =?us-ascii?Q?jN2FqQswvMTYwzc6ULcpoofdnA9PEg6X6KZ6tIgFRkRAwdVYK5b5oqoalh/a?=
 =?us-ascii?Q?jHpQDyoXaIkzFDbVhoxdFhPOHenyuJ28/mgHDNF5Jin9VpQqKQWtrzKyyHVt?=
 =?us-ascii?Q?A6l1n+jxZMz+pvGGLfu8bEcmI4mJIyVbUeTuakETdIL1HjXhNyIkywLMhSlv?=
 =?us-ascii?Q?4CkORU7l4bLqA7XSMuDTMV/31aiRO78/hxPWsn27TpEnssYJiltndwFNbsWn?=
 =?us-ascii?Q?AOmDk0c3jBGZ95UcQ4xz7wk5hbZqbhSabuvibttC34u4MKarz7/cGeXFtuCo?=
 =?us-ascii?Q?a/SCaImjyJ0RQqxuep5Fs68MWmxGXuWXCBgs6qYnKftPRo1oe5fJYqH64qXd?=
 =?us-ascii?Q?oiLCqvorfRnJ0KBT3nbzZcSycN8fGGKCOvVxoylDUhaiQM8gUNiVAV7BDBcq?=
 =?us-ascii?Q?Vn+NG3KiF/e0MZCg3ogt1nr8G9SGl+IjAQciw1XqJgR90HzZPftlk3OUo1se?=
 =?us-ascii?Q?cl3tt3rMzbwSbdVpjWPutYgPDTM2UyYu4dpy+SFduZNrzn7qEgl+roSntZeP?=
 =?us-ascii?Q?tl/0Fro+0lm1gZ662V34KkGWaWAbRCh9gRJNNXLqNsYY1ExDSsx+fDNGMhc7?=
 =?us-ascii?Q?AZZlogOYH+r1m3u5sB5aDB5OwinwVdRu39874cBbGG+RiR6J75Eyfl7JO3yo?=
 =?us-ascii?Q?vrFX5d8MuBAv8jyybte4RIcrLrS4Trvr3TTuY+PeyyOxY4k2/Zm+hMmUfWV4?=
 =?us-ascii?Q?JwTqIJ5EgsmUeDsPzXxlRJ5dzMZVJx+n62YOwjC9J3H3OqTcJsc5lTEA68Db?=
 =?us-ascii?Q?leDW43S9x0TJ9Boo28XLzok+T74mKLGAFOSSHhPJRL4MZzRxupMBCWWxje4n?=
 =?us-ascii?Q?VBi1w93Jd/DsWO0obeWpUQu+CNtUxXsUehQA2MJXwDERlGmUkU9QeNjJEP9E?=
 =?us-ascii?Q?ot1Mr72k91CkZAwVe+/0VG/ZsjIUNet3kx0iPL0xka74mPQoFn9VCVH9DqOb?=
 =?us-ascii?Q?mBuDjHILpaoTPnVlvZD760Tcsgrcz0s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c19bd5-0dac-48b9-270a-08dedc8e0a09
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:12:55.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmOlAazynJG6s2L9J6TCONhhBUzJX3jwz+yHVH/tczyew0B0b23k04XOinqEy42y7IIdwFltv6DorBgmHlnJgJ10IrGPnYjPoqxeRQa1GwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Enhanced the generic firmware loader to support QSPI RAW partition
loading. This would enable FPGA configuration bitstream loading
from QSPI RAW partition to program FPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 doc/device-tree-bindings/misc/fs_loader.txt |  8 +++
 drivers/misc/fs_loader.c                    | 79 ++++++++++++++++++---
 include/fs_loader.h                         | 31 ++++++++
 3 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
index 542be4b25a0..8ee59db24d5 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fs_loader.txt
@@ -12,6 +12,7 @@ Required properties:
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- sfconfig: should only contain "bus number" and "chip selection".
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +47,10 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for qspi:
+	fs_loader4: fs-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0>;
+	};
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7..d4804d649e6 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -19,6 +19,7 @@
 #include <mapmem.h>
 #include <malloc.h>
 #include <spl.h>
+#include <spi_flash.h>
 
 #ifdef CONFIG_CMD_UBIFS
 #include <ubi_uboot.h>
@@ -67,6 +68,11 @@ static int mount_ubifs(char *mtdpart, char *ubivol)
 }
 #endif
 
+__weak struct blk_desc *blk_get_by_device(struct udevice *dev)
+{
+	return NULL;
+}
+
 static int select_fs_dev(struct device_plat *plat)
 {
 	int ret;
@@ -121,16 +127,26 @@ static int _request_firmware_prepare(struct udevice *dev,
 				    const char *name, void *dbuf,
 				    size_t size, u32 offset)
 {
-	if (!name || name[0] == '\0')
-		return -EINVAL;
-
 	struct firmware *firmwarep = dev_get_priv(dev);
+	struct device_plat *plat = dev_get_plat(dev);
+	char *endptr;
+	u32 fw_offset;
 
 	if (!firmwarep)
 		return -ENOMEM;
 
 	firmwarep->name = name;
-	firmwarep->offset = offset;
+
+	if (plat->data_type == DATA_RAW) {
+		fw_offset = simple_strtoul(firmwarep->name, &endptr, 16);
+		if (firmwarep->name == endptr || *endptr != '\0')
+			return -EINVAL;
+
+		firmwarep->offset = fw_offset + offset;
+	} else {
+		firmwarep->offset = offset;
+	}
+
 	firmwarep->data = dbuf;
 	firmwarep->size = size;
 
@@ -147,7 +163,8 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 {
 	loff_t actread = 0;
 	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	int ret;
+	int ret = 0;
+	struct device_plat *plat = dev_get_plat(dev);
 
 	storage_interface = env_get("storage_interface");
 	dev_part = env_get("fw_dev_part");
@@ -167,7 +184,8 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 		else
 			ret = -ENODEV;
 	} else {
-		ret = select_fs_dev(dev_get_plat(dev));
+		if (plat->data_type == DATA_FS)
+			ret = select_fs_dev(dev_get_plat(dev));
 	}
 
 	if (ret)
@@ -178,8 +196,17 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	if (!firmwarep)
 		return -ENOMEM;
 
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
+	if (plat->data_type == DATA_FS)
+		ret = fs_read(firmwarep->name,
+			      (ulong)map_to_sysmem(firmwarep->data),
+			      firmwarep->offset, firmwarep->size, &actread);
+	else if (plat->data_type == DATA_RAW) {
+#ifdef CONFIG_SPI_FLASH
+		ret = spi_flash_read_dm(plat->flash, firmwarep->offset,
+					firmwarep->size, (void *)firmwarep->data);
+		actread = firmwarep->size;
+#endif
+	}
 
 	if (ret) {
 		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
@@ -228,6 +255,7 @@ int request_firmware_into_buf(struct udevice *dev,
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
+	u32 sfconfig[2];
 
 	ofnode fs_loader_node = dev_ofnode(dev);
 
@@ -247,6 +275,15 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 		plat->ubivol = (char *)ofnode_read_string(
 				 fs_loader_node, "ubivol");
+
+		if (!ofnode_read_u32_array(fs_loader_node, "sfconfig", sfconfig,
+					   2)) {
+			plat->data_type = DATA_RAW;
+			plat->sfconfig.bus = sfconfig[0];
+			plat->sfconfig.cs = sfconfig[1];
+		} else {
+			plat->data_type = DATA_FS;
+		}
 	}
 
 	return 0;
@@ -254,10 +291,30 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 static int fs_loader_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
+	int ret = 0;
 	struct device_plat *plat = dev_get_plat(dev);
 
+#ifdef CONFIG_SPI_FLASH
+	if (!plat->flash) {
+		debug("bus = %d\ncs = %d\n",
+		      plat->sfconfig.bus, plat->sfconfig.cs);
+
+		ret = spi_flash_probe_bus_cs(plat->sfconfig.bus,
+					     plat->sfconfig.cs,
+					     &plat->flash);
+		if (ret) {
+			debug("fs_loader: Failed to initialize SPI flash at ");
+			debug("%u:%u (error %d)\n", plat->sfconfig.bus,
+			      plat->sfconfig.cs, ret);
+			return -ENODEV;
+		}
+
+		if (!plat->flash)
+			return -EINVAL;
+	}
+#endif
+
+#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
 	if (plat->phandlepart.phandle) {
 		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
 		struct udevice *parent_dev = NULL;
@@ -277,7 +334,7 @@ static int fs_loader_probe(struct udevice *dev)
 	}
 #endif
 
-	return 0;
+	return ret;
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 7e16e0f7030..8f868f031f1 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -22,6 +22,31 @@ struct phandle_part {
 	u32 partition;
 };
 
+/**
+ * struct sf_config - A place for storing serial flash configuration
+ *
+ * This holds information about bus and chip-select of a serial flash
+ * configuration.
+ *
+ * @bus: SPI bus number.
+ * @cs: SPI chip selection.
+ */
+struct sf_config {
+	u32 bus;
+	u32 cs;
+};
+
+/**
+ * enum data_flags - Flag to indicate data as RAW or as filesystem
+ *
+ * DATA_RAW: Data stored as RAW.
+ * DATA_FS: DATA stored as filesystem.
+ */
+enum data_flags {
+	DATA_RAW, /* Stored in raw */
+	DATA_FS,  /* Stored within a file system */
+};
+
 /**
  * struct phandle_part - A place for storing all supported storage devices
  *
@@ -30,11 +55,17 @@ struct phandle_part {
  * @phandlepart: Attribute data for block device.
  * @mtdpart: MTD partition for ubi partition.
  * @ubivol: UBI volume-name for ubifsmount.
+ * @enum data_flags: Data type (RAW or filesystem).
+ * @struct sf_config: Serial flash configuration.
+ * @struct spi_flash: Information about a SPI flash.
  */
 struct device_plat {
 	struct phandle_part phandlepart;
 	char *mtdpart;
 	char *ubivol;
+	enum data_flags data_type;
+	struct sf_config sfconfig;
+	struct udevice *flash;
 };
 
 /**
-- 
2.43.7

