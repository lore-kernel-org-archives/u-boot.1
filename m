Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E81075289
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 10:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3155883F2D;
	Thu, 19 Mar 2026 11:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="I99tLD1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18C083F8A; Thu, 19 Mar 2026 11:03:24 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1CF83F00
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 11:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDf6ymoaz+xvSGLXgAHOdlHhn+d16y+CzKnHQ4tlaNHDxoo632GLc7BjhBxNnikEvvKrDyZ0Zn1c1UAGrI4eYBP2aD+RMgxwBCC0rUfdSDPMdYhLjc46zjm9On+80TymgyrEM3y8Z4XNcyjrFLAwawPg/6q1vi8NwWLAR5VLTxqvUW8DN6gEiA1w7BjdgLqZ7ROM/zwqgQf5G+Cuykx+F+7swg5RzngyX6im80yeFHsfPXhvgr5nLE2TlntfS7R0jJAH8GsPB/Ma3c4e4kMRwfJSQDHzV34FMp2FOc2lmbHTgXpRORAlvlRkCPW266rs9Cd/iHPa/0mrKBTXwHcIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb3cIPLINb2kC95WjoppV7mzALCFD1SaYyN948V9ejI=;
 b=Pl4hBueTmisMABLYIu6kzlTgFe0743NDZavV9QItByWSYQ+hIuUKgW1yTMwPVTqr3Z2HT70Sc6haiMfnHrrU094UwjL2H35238AIET8auiUJNSxPHgfMpc0wzcg0ldE4zI734eAY52igJ4rZ4mJgP0ii88BWiXQw7du3mmTH1nqBWKlQgi8ez1LTGkAu1mSvs7zQXu5Dp3GKajDgrHwbQtA+d1LnN31NAfWEo8MV5NB7OIU3hIyG6JDFVLDYrbJsy0MRJ4V94FC9qTFbxSy/FYErNE0wsmJRb0eTowY0G2JJB/wFnZ1Ja0d5iUw0psgLkKunTGx1hF8uWGOzmis+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb3cIPLINb2kC95WjoppV7mzALCFD1SaYyN948V9ejI=;
 b=I99tLD1gxyXKD/5uhu8SV/EXdjokh59R+ZE+1w1l7Jt0mUgYkAU72+w4NAhCfyOdTknUcUpHrEmrWIJugwsHfiVug/Otq1p7qd1ESdDuKLCXdJo4SqO75TkngxBeTqejE8oW5/Q+4R+6ncx3/+IkJusmCcmzxF5Ew++PT0riMHhpRyJLtbWMyiB+A/RmW0j9n5Dy7ukOMAxBgEd10VtXkb1qkev+cLG3V6SAu5RAViLaAkpVY9Hc5qrJqm2TjP7pwnN/pvNnTR5lcYJfilH5owXSooF/B5mt0207LFV6hEoE3Mfng/OhQ/ribUMsaXcFB80FSo4slG4eaZ4ucoxHog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS2PR03MB8135.namprd03.prod.outlook.com (2603:10b6:8:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 10:03:18 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 10:03:11 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: "Lucien . Jheng" <lucienzx159@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] misc: fs_loader: Add QSPI RAW partition loading support
Date: Thu, 19 Mar 2026 18:02:56 +0800
Message-ID: <20260319100256.965-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS2PR03MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: db366487-0c12-4710-2102-08de859eba92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: hJzrOwdckBk53KZXXGhDfUeSA6Rj1wqqBfFrBK29/mgfL8B0uRxdbuLmVLR++WJpwGlr/H2CNhUJPBsrKt/Mm/NSOu/AKzNAGMSn9bXAcAp8VtMBH7pvikU7AwdPGImcoKyf2snIVkJXRFUqsBRs+izMqcTfBkAckEszE+yFPe1Zw9CBIgok0ogCSRJtvDMfXNhlBHIYgGDYX4ip2qkGlvH3w5hJcEA6VIHR1SLu8QHP6geoJ0Tp9tb4tD1vHB2keRT6Q+lH6MaPIRQ+oVt0GDrUCdJ9dR02f/B7PfBA5snOffOJC/kvusA2tHV8su7yTb0jqxKaLgOed2sKqr9SYu9Nk80WGJhZkq7bV+mS6g3VtFSyywRrNptALsWSIYl0KXf7FAql1NYB7UssNqf9avSIVfDcmyCwHp8UtYY8s21ntf8nF1q6ie91Orj82WnobehYx39hgRmfLW8gDjSTUrvFeIK4pYPCk1CKbAhjiK85L2oIkSnRClqct6+5mO+GJZguKquYfbu6wot+CTSvcyHNOKs95OCZhRX4o8lljWFT1mkFBISd2wXpCEGI+sjBC3H4dlL8TcxEkHfObuMJcrMWt+2070CAWt4XqSkmMQEP5P3K83El1T7W2WIrCDDa9+9trkSx2wpK36XWiIIjQaGSTyfBgpNFNFACdmiMix/s67TfsltKx3Q9ZMk+xWjutRNr2x7c29WCFMMhMHXPzxENrN6QX6QwC57NQFguCXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfeWepmqyosP9zXYqi5JdjADQfm2ANIuEvMSAJyia/PUQVgDw96Mk+bBO9Gw?=
 =?us-ascii?Q?uLJPoVOCY7LFGsSWEDAIzEfCzaQoLFcVG/HaGedJ8r3WE7QHOD0kjAymc1bN?=
 =?us-ascii?Q?T1vjKRJcV2+VQMsLJ/F400z7HoaqFQnsoXxvbTS6ES0aP6f4F5+y3lEeaCo4?=
 =?us-ascii?Q?7d+k9MAcQZd5/Rs+4speV3xBIttcHnuQq2sa/f0oB5Z20002NORhknKBtv0m?=
 =?us-ascii?Q?etTC46HMf46JawDQMy9LzOjteouzlV286lL2XEzxb8rRCtWldH+pVwKd9oT6?=
 =?us-ascii?Q?GeYLXJlgKv/kArZ3aySquGbrrFP9CL17hXjZ2uCEni2/qpEvfWlY/SmIq/ys?=
 =?us-ascii?Q?NmQnCJNXdiSZ6cpSk2+HKPpbOSeN1Qac2uuka8ebby7IFYrCWnKhbURCU3gO?=
 =?us-ascii?Q?6I467RbktxECuRyO84/0MU9wVXf+4pagMgQbI4OLYkThIJgXF9MIZ7H5jNkN?=
 =?us-ascii?Q?haCyslF1Y6KR/tlmJHy31N8DG1ftWF577gK52A0J3b3DI97xv1zgK+ZTN9Ms?=
 =?us-ascii?Q?98Yt2OJsbyV7TEsOZfZ+YK+F4hvfuDWA5gv53dyHQBLcNeJT3Wk+AA9VP2BM?=
 =?us-ascii?Q?XD4U0jpWocKWgZXuX4X/ZwVnYNAD1iseB66pEuYJxixd8bhifB7uYU9ntDN/?=
 =?us-ascii?Q?jGHML9/fRSWWx8dHbLNXGCOiXM4uOoXSPk4r6bTMqdEU4eg+zG7wHN54obJM?=
 =?us-ascii?Q?7DQXGnvu2k+wHlbEbp/UH3ha5WqGQrhA9c9uehxSWfHE/1Jh84xZ1miyJdI5?=
 =?us-ascii?Q?BMtzsLrSyOJpAV2ims9Xr1m3JINL8EASMrgHt96FrJPK+jjKaFDbJ8ESRylN?=
 =?us-ascii?Q?pJZ97Xjpb+FBQy/p5wX+etqsQ3UpTzAdlIfFDo0akGsdSWnBY0nMnd4kboMw?=
 =?us-ascii?Q?YDewx6j2DXuwfhXuRRQveY4+DdpN9CCIQ0v9z8wa7lD0pOpyw2LsN+jMYByT?=
 =?us-ascii?Q?Zxy1f0UVDR1Uad8riPLEQDT9kTtWilSUfYhiiaF2vOVm6hbLhu3VNl1sneOl?=
 =?us-ascii?Q?KZ1nUMlAXCnZ794z69RrstQTnKcQHvhz/oDrjjMhdOMeNpsHZbR3IZOvMso1?=
 =?us-ascii?Q?fz06mESI8zeXh/sr28duufn24n41wuxB87yTuMsCBD9VAiBJ8nDoovCk99pZ?=
 =?us-ascii?Q?LmHkO58JBlfKf3+zeHQ8xtzSgRyVHXQpdDm8F03iVIZL9Xo4JSmNrZo1xteV?=
 =?us-ascii?Q?WFXq7iwH9NIDqPpRWQF5eT86AdGubp9kcIu0ajhS0uriBbAayjI/hdggg8Wo?=
 =?us-ascii?Q?cZnS4ij3755DS1MrRLMCtpd1qxq7OPeKmCF/73lIULpC1sKR8X9Iu6zkf97z?=
 =?us-ascii?Q?a7OMNdBt4fLptoZER0R/63/z9XJHqk3Gv5x60/FoIgq/tUzLLLF4vAQ4FV/Z?=
 =?us-ascii?Q?9ajhSvsntQURAXsOwvw888331Q0fspw2t2Ahct4MQr0exOL8on0W0NTGELRZ?=
 =?us-ascii?Q?PgsK9GMWNqr8Zk5IrP+rBq6aZ2j0ZAGqbBn6O8HQuySakCfAdneXZsjqqMhG?=
 =?us-ascii?Q?iBzWzJnFA23CMd3L3g9vdeERWMJrZs69/Y0NrbI/Qr54xzr2KboNKKIOqi1a?=
 =?us-ascii?Q?nhk3hxIu6dUhmGfx7rMl66qgK1/yxRiZMeI+Pz4OsxSSOqQM7lqVqN3w4fXS?=
 =?us-ascii?Q?PnCixxWir2tvQfqTuTwwGzxW+Ucwk5phK4K/MX5Y4yUmOTQSOvHrbtmbthTU?=
 =?us-ascii?Q?ODGrEJldbdmRQzLHZvXJRcW/GIkg7VAl9os+4lQlimcFD67szt8BME0DYV+k?=
 =?us-ascii?Q?hqdG1E2sVw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db366487-0c12-4710-2102-08de859eba92
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:03:11.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIaoPr3k0qIyZxglr/wDbE4o8NYsmXXTLMfGNn8ilyZ7hVPPNRbM0UQfLdolqXy+ch3MdX2q1ZNaTLxTxlXsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8135
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

Enhanced the generic firmware loader to support QSPI RAW partition
loading. This would enable FPGA configuration bitstream loading
from QSPI RAW partition to program FPGA.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/misc/fs_loader.c | 111 +++++++++++++++++++++++++++++++--------
 include/fs_loader.h      |  35 ++++++++++++
 2 files changed, 123 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7..a425f317614 100644
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
@@ -178,8 +196,19 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 	if (!firmwarep)
 		return -ENOMEM;
 
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
+	if (plat->data_type == DATA_FS)
+		ret = fs_read(firmwarep->name,
+			      (ulong)map_to_sysmem(firmwarep->data),
+			      firmwarep->offset, firmwarep->size, &actread);
+	else if (plat->data_type == DATA_RAW) {
+		if (IS_ENABLED(CONFIG_SPI_FLASH)) {
+			ret = spi_flash_read_dm(plat->flash,
+						firmwarep->offset,
+						firmwarep->size,
+						(void *)map_to_sysmem(firmwarep->data));
+			actread = firmwarep->size;
+		}
+	}
 
 	if (ret) {
 		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
@@ -228,6 +257,7 @@ int request_firmware_into_buf(struct udevice *dev,
 static int fs_loader_of_to_plat(struct udevice *dev)
 {
 	u32 phandlepart[2];
+	u32 sfconfig[4];
 
 	ofnode fs_loader_node = dev_ofnode(dev);
 
@@ -247,6 +277,18 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 		plat->ubivol = (char *)ofnode_read_string(
 				 fs_loader_node, "ubivol");
+
+		if (!ofnode_read_u32_array(fs_loader_node,
+					   "sfconfig",
+					   sfconfig, 4)) {
+			plat->data_type = DATA_RAW;
+			plat->sfconfig.bus = sfconfig[0];
+			plat->sfconfig.cs = sfconfig[1];
+			plat->sfconfig.speed = sfconfig[2];
+			plat->sfconfig.mode = sfconfig[3];
+		} else {
+			plat->data_type = DATA_FS;
+		}
 	}
 
 	return 0;
@@ -254,30 +296,53 @@ static int fs_loader_of_to_plat(struct udevice *dev)
 
 static int fs_loader_probe(struct udevice *dev)
 {
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
+	int ret = 0;
 	struct device_plat *plat = dev_get_plat(dev);
 
-	if (plat->phandlepart.phandle) {
-		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-		struct udevice *parent_dev = NULL;
+	if (IS_ENABLED(CONFIG_SPI_FLASH)) {
+		if (!plat->flash) {
+			debug("bus = %d\ncs = %d\nspeed= %d\nmode = %d\n",
+			      plat->sfconfig.bus, plat->sfconfig.cs,
+			      plat->sfconfig.speed, plat->sfconfig.mode);
+
+			ret = spi_flash_probe_bus_cs(plat->sfconfig.bus,
+						     plat->sfconfig.cs,
+						     plat->sfconfig.speed,
+						     plat->sfconfig.mode,
+						     &plat->flash);
+			if (ret) {
+				debug("fs_loader: Failed to initialize SPI flash at ");
+				debug("%u:%u (error %d)\n", plat->sfconfig.bus,
+				      plat->sfconfig.cs, ret);
+				return -ENODEV;
+			}
 
-		ret = device_get_global_by_ofnode(node, &parent_dev);
-		if (!ret) {
-			struct udevice *dev;
+			if (!plat->flash)
+				return -EINVAL;
+		}
+	}
 
-			ret = blk_get_from_parent(parent_dev, &dev);
-			if (ret) {
-				debug("fs_loader: No block device: %d\n",
-					ret);
+	if (IS_ENABLED(CONFIG_IS_ENABLED(DM)) && IS_ENABLED(CONFIG_IS_ENABLED(BLK))) {
+		if (plat->phandlepart.phandle) {
+			ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+			struct udevice *parent_dev = NULL;
+
+			ret = device_get_global_by_ofnode(node, &parent_dev);
+			if (!ret) {
+				struct udevice *dev;
 
-				return ret;
+				ret = blk_get_from_parent(parent_dev, &dev);
+				if (ret) {
+					debug("fs_loader: No block device: %d\n",
+					      ret);
+
+					return ret;
+				}
 			}
 		}
 	}
-#endif
 
-	return 0;
+	return ret;
 };
 
 static const struct udevice_id fs_loader_ids[] = {
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 7e16e0f7030..c6ad5785f07 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -22,6 +22,35 @@ struct phandle_part {
 	u32 partition;
 };
 
+/**
+ * struct sf_config - A place for storing serial flash configuration
+ *
+ * This holds information about bus, chip-select, and speed and mode of a serial
+ * flash configuration.
+ *
+ * @bus: SPI bus number.
+ * @cs: SPI chip selection.
+ * @speed: Speed selection.
+ * @mode: SPI mode.
+ */
+struct sf_config {
+	u32 bus;
+	u32 cs;
+	u32 speed;
+	u32 mode;
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
@@ -30,11 +59,17 @@ struct phandle_part {
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

