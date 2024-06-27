Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4A7C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD98885B6;
	Thu, 27 Jun 2024 13:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TA3w14tN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3DB885BE; Thu, 27 Jun 2024 13:35:58 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45AB1885AE
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HirbAN8rVheAObX2h5NNi/JEfT7W8D60UUGLPXkM0R48m4g9H8SFjJWIRXbxOjx58eJnZEhatpjAwrDeHxlIgwe0ygj5ed+2IpVc3IQ4fskGX6ZILN9NxVzv3uQGFIGaLiklhivbQITLHWC2pjMmyB3jOLBLKLRnZXsnBFbVxEL1KLgFh8f68T3XnU6X4PPuELXymrixuzwqZ1+3yNYt2LhqvY/wnSCgNHjPOX/jyJfRF3eMTQzYMw/WYBCyCbbpvTL98BrJgr6oqjCdVPHq919lw9e2DFfeWW5IaP7QOA+6wFyzG3RmMXBpBbTdOtmQ41oqjJ+KznvYLHurto+AlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fWLUmhTpLR6N+P+OYT+eImBCmH6DUVY96GYWxMdTTk=;
 b=Yj4OwXe3d9YCgHwYnhFBAtLK7uTmreDRp0truvfhaaCsQqhJiHzLZHeTxiXAVEigbff4IbiJWlL58y15pnUkUPlbANCkWd6WwEeoRZ2HGBSIS9jMsrhbCbAXwbEmRSer8x0718SECLVcUKE/hIf42hurOISFzR4rWJ1iGfmNsv7L/YsZ3aV/RQs8HgFoyPrfdn3pAD8FZWhj1Qia/n52GOQQ3mBdhVfozkUqjZuLw90TZuye2HqhZACA785lypbynelL5ah3Id5d1ngO/89nBEE6yV0J+gYyZo2NV3FNREwxGt5DXnNQs7lLSx8RZL72BfG3cqSIuNN/3Jl1a8YyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fWLUmhTpLR6N+P+OYT+eImBCmH6DUVY96GYWxMdTTk=;
 b=TA3w14tNqb2XYHdw8HVb9GVuho4Woi9MVr6oaqyinCqX8+zAmM5A9+7erAdjX2l3BRJ4Ph2u9LVsIhnVTNLr/88C2ORAo8Ui5xKVvYK0+id5h0lLWuz1D75AhJJblp7dPuNHS0iZHydA3FOEyKxbl9hoT/8pdEwu7l8DPVYVCHPl8xaZesMe/dlzVG8uz42W6wwZYBGx4ykJcCq6SNhYrrvnfj6XKEU0sXNzZ1l5sByBRj46SyasORW/z377iYf3q+tV0u3lvbjynigOWN7uEzcJTaLSgLZZrpoT0YUZ1k3FwrxrMcEeZIkVIJbI8jbDfgQD5wcZ9kJbocK/LMB8kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6140.eurprd08.prod.outlook.com (2603:10a6:10:20a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:35:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:35:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Shiji Yang <yangshiji66@outlook.com>, Raymond Mao <raymond.mao@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 1/3] fit_dtb: relocate whole fit dtb image instead of selected
 dtb only
Date: Thu, 27 Jun 2024 14:35:44 +0300
Message-ID: <20240627113546.100333-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 816aae1a-88b2-4db3-8cd7-08dc969d4dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PpcDvghrDxeozTQ3f9wnQXEAFwnexoTdvyvIkWXmnkRTeBtEkogMxoScna1U?=
 =?us-ascii?Q?7f45exP6dyR2I2+Szeo6hTkePOYyxnoUYw2qiX0z5dqU8AtCSaMZMo0B3Jsj?=
 =?us-ascii?Q?+klEjCsbTSysaVMwNAryxnQs2OELYBfdB7+eJsBCdoMMqG1ceWwg9qn16X8l?=
 =?us-ascii?Q?KVdJljHRxiyeQUNzdkfsAl+v9J+v1ciYoCpImqC0fD5Q4JRIchYJiWG1okrn?=
 =?us-ascii?Q?ylah/Zzw6v3s4pbb09A9astTN/7aejIs+UWAn+s7LLzbz5C03ncMmHpkcrpB?=
 =?us-ascii?Q?vC9AboklCNnrpXYOcgYzuKvWiAUGe5ePjhOinMUZ3H22HIORUmZZZic6Cet/?=
 =?us-ascii?Q?EMmjVCyJbNvAeNRULAvcw+puSGis+KAXjKVWwazduBuemJncaWZGFVLr14b9?=
 =?us-ascii?Q?Y/sLUc8qHRmZ9DfVnbC3NfIb0ZtaFRTCz047k5KvofgucsS688Ie9LuIsoxF?=
 =?us-ascii?Q?ChdbZY73k9gxQsLEbKvhdlVPKcPNThbXCl6V0yJBOz/YDD/irJVIbdX4Qr2u?=
 =?us-ascii?Q?eNhBQ6k+qeoF0gyQAykSEWiO8W/d+He0Po4XpMGgfpDBzn/RJ1PQMk/W0Bmn?=
 =?us-ascii?Q?Szlxq6r8okyAjnbGXbnjfSZ/a49UzCrHRZCZoaO2aU4CxBx98YEdXP4E1JxM?=
 =?us-ascii?Q?R98dQAm1tM4mq+Zys6tq2c1vmYiFPk4FQ5yjVkQrXn7pkM4jjQL27WHz0VaO?=
 =?us-ascii?Q?PaquLGh7SwOa0/kdOGd2cv5y+DjDt3tyJZ+xejUkFM4eCub2nRqjXwE4uEfQ?=
 =?us-ascii?Q?kuGYTkp/jXyFo2hOeD9V+iRMQytattfUzO5b0KqMVDomSfLq8ush5/C8ELVQ?=
 =?us-ascii?Q?2m5YOEnOS6BgRGsmun1HCGEvXZaa3FVrVspP7K1BT3szNbi2fGCppIzX2u/m?=
 =?us-ascii?Q?umnCbcbXI1ujQ0j3HWJP/JPNNDUGI2eSVZ3Cwlivpvg7MiL68nul5fg48Fk4?=
 =?us-ascii?Q?zEMK5mi2VV4xkYUduCdtAVaecOYSWcDDdJxVrTH56ha5J5MivNFvJM6/5wW8?=
 =?us-ascii?Q?EV+gpR4Q6Cn/5cwOPAS6H2BA0B79E8bkR9RW1XmGd/5dB+8/N51BGzRbNZVQ?=
 =?us-ascii?Q?/jbDVN+vG7STHmDfF5e+GGfwSgHf2gZTjJ58wVIyhbsAyeoj5C4x7Ud1wc46?=
 =?us-ascii?Q?0xIiPBtGBnYDmDsD4YjiMFjCteIklB7aasJHYBnN5cJra+bKuYQ1Enl6QuGD?=
 =?us-ascii?Q?9Bk2DsPVu7vitWwrqd+bNnS+EVceb6fmJjklVFKRslzhZMrsEk36tD00VcH6?=
 =?us-ascii?Q?o/iMQ6ltlgi360crBlTBcSbZRhmjAfDbjunVeBhG5+RFdZOH3StV/eXqdw2n?=
 =?us-ascii?Q?FGdTiBOPz354GwU3a+Yn1TXnWt/VPq0SBzhhVUaY2aru5BtwUwx9xg7vmhAh?=
 =?us-ascii?Q?Lf43YkOWbW5UwTV8BkmN3zlUINJXZmai0gqW/hH90GWc4habR+ioixpaw8+9?=
 =?us-ascii?Q?xA6GSxTXYqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W8IOduAzxb23QmsSZr8QcRLTS58f6zQo2aWSEJHCQsMDwCE5joapXQwkUmSu?=
 =?us-ascii?Q?BZeEsckIUEDGRMnRz6EawfxeFYJRIc0FUQmTm5Bqfb2wC0ikM61NzPut7bDF?=
 =?us-ascii?Q?lGvhSyS5NisdwCIoRkO55vfQGoPCaC9HmxMZ+NThiqxhUZxSbgApmj5DL4Nb?=
 =?us-ascii?Q?gr0kzk9S4j4EsHRWKl/GYe95N1mbcIfUMOUagxV6GeKICR65Pzi749m8U/R0?=
 =?us-ascii?Q?1+7a2WGxfnFGNuYDVRl5EuYm33iYZUMtMpBYeZgoH/akE6YQiFoKGXtZ2Rgr?=
 =?us-ascii?Q?IW15xVby4CuBx6ysbV7LOVtkKOgA1BVaAR2GYn1j9qwyFKDDZsmCHUAsI2sm?=
 =?us-ascii?Q?VA9oZSBVy32ui74EDPHUYl8Ri17Jm1KDzRizHRsEUfxlRxtnxRKmcGbBTw2F?=
 =?us-ascii?Q?JDE8bEZO6oC3Y/eMaRM2HSHUY0wwVCN82BJjhstTbgNquzyplqLffKIp2g+S?=
 =?us-ascii?Q?hACQ5a5I8iHldvmZN29kqWesgjGbjPN8+kasbmoYqNQCSXaw14uhou7CeN6q?=
 =?us-ascii?Q?IJCBZX+1KiSwWjNqkCxSaWKw5EVCEgG7lo0m2n8G46vL+taiD50VUqn5TqWY?=
 =?us-ascii?Q?aebyN/YUBjWt5CnC3o7rYOOUCqCA2jC147LOLpNgBMq6Jr0PWzEhSRusCjga?=
 =?us-ascii?Q?9E1ifh+ofsOikz7LkHQhui5WI54VyKD/hBgvz+qcLpxdsquyHY8D475/Zxfo?=
 =?us-ascii?Q?Oe2aqAll1VJdbMf+xsREDsg6ndfJladHQez/Wl8PYuS8j+tRIzrWr+AerPxp?=
 =?us-ascii?Q?1iB8CIkckUtB/g+JLYiRQjmSHuT8dc6QQr4bFO2UjMpfWyELeDb/a47m6AOX?=
 =?us-ascii?Q?ib81Mj9cYTC9YF/cociQog1OHQicpKq/iWGxGQRIbo1zIDgeA9e+17ZWRpax?=
 =?us-ascii?Q?fcD/hZ98fvBTG6HkAlYcaoXU6WU3SPvv6JmtPDgKnDrQrHIc5nnV+JUyIqBN?=
 =?us-ascii?Q?ea5bQDwRxOcsXrvJyvhQYUh+ZfShca7ph2xfQmVXAgu+dSyhyz9EzxWzA2hI?=
 =?us-ascii?Q?JqCBneDF+ip/tuh6gic5hlhLkS2HSMyRZJx0faXeK4DfBvrVXSVU1kPOzTKa?=
 =?us-ascii?Q?F9tsfvMINbMD//1e7Z5PthQ0XZVp+meC6YpTF04XTuLm0TWD0KtQAnTFLXTO?=
 =?us-ascii?Q?e1UYnWRPPuSpQ+1DrsAwaPhkKoriYnpKP6kQuylVv3TdXGo39u7Y4TqrpTrB?=
 =?us-ascii?Q?XIOr7/I5Ss4N6Qg+OouCS7mvZJqPizYBvpb4t9j0LDHleUJ2p+vX9iF21ATM?=
 =?us-ascii?Q?FB319t2NC3Qj+hEb80S7wOhyWRwzHzgt34MhCJ8vaLg6AdIy4A2FBkXadsq1?=
 =?us-ascii?Q?RxQFwOy3kgdnP7ILySKW0wR0+R66FVMwtx3SUtcIjHfJdaeQ/2Ubk5Vr+K3+?=
 =?us-ascii?Q?U3SGs/XuS4GAFFdVSlzJFn6VnneaKxdsuKW5yWvZ4KTzCJNqasekwjN9V7BJ?=
 =?us-ascii?Q?Jmi5hQh2hUGYMSKcA2WIX9otn5+vKVWlee7Th4SDnpKsKHpftTtor6Olr7jb?=
 =?us-ascii?Q?BW8binxdSX9UqCR2V+3MeQC7YJUdcRIGFTzp+A/1tDgy2IXbx3ax+2inV0jG?=
 =?us-ascii?Q?lJzyMLEimU5GekaLDANqI38GE03fnmrop3pguOE6DMt1ziMiT1KldneS/T4m?=
 =?us-ascii?Q?5wddRe5s86k/rBqRike/Ug0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 816aae1a-88b2-4db3-8cd7-08dc969d4dba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:35:53.9291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/PgPHXMUyxzTCbN5zwrvnOcQ20K/Vxp3RD8JZrYUSFbJmXBii0t9R+P3rzOjxRftRv654SugmAt3fjHxFcB6CqE6y/8ItePKZWMp4Z1ggA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6140
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

U-Boot with linked fit dtb image may be loaded by a bootloader to
a low memory. On a later stage U-Boot will relocate itself and used
dtb.

There is no problem until we decide to reselect dtb on a later stage.
In this case dtb placed in the low memory address may be selected.
But this data can be overwritted by flash reading or network file
transfer. Thus we will use damaged dtb.

To fix it move the whole fit dtb image instead of just used dtb.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 boot/boot_fit.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 common/board_f.c   | 34 ++++++++++++++++++++++++++++----
 include/boot_fit.h |  8 ++++++++
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/boot/boot_fit.c b/boot/boot_fit.c
index 9d394126563..e9aac61c6a8 100644
--- a/boot/boot_fit.c
+++ b/boot/boot_fit.c
@@ -13,6 +13,54 @@
 #include <log.h>
 #include <linux/libfdt.h>
 
+int dtb_fit_image_size(const void *fit)
+{
+	struct legacy_img_hdr	*header;
+	int			fdt_size, blob_total_size;
+	int			images, conf, node;
+	int			blob_offset, blob_len;
+
+	header = (struct legacy_img_hdr *)fit;
+	if (image_get_magic(header) != FDT_MAGIC) {
+		debug("No FIT image appended to U-Boot\n");
+		return -EINVAL;
+	}
+
+	fdt_size = fdt_totalsize(fit);
+	fdt_size = (fdt_size + 3) & ~3;
+
+	conf = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (conf < 0) {
+		debug("%s: Cannot find /configurations node: %d\n", __func__, conf);
+		return -EINVAL;
+	}
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0) {
+		debug("%s: Cannot find /images node: %d\n", __func__, images);
+		return -EINVAL;
+	}
+
+	blob_total_size = 0;
+	node = fdt_first_subnode(fit, images);
+	while (node >= 0) {
+		blob_offset = fdt_getprop_u32(fit, node, "data-offset");
+		if (blob_offset == FDT_ERROR)
+			return -ENOENT;
+
+		blob_len = fdt_getprop_u32(fit, node, "data-size");
+		if (blob_len < 0)
+			return blob_len;
+
+		if (blob_total_size < blob_offset + blob_len)
+			blob_total_size = blob_offset + blob_len;
+
+		node = fdt_next_subnode(fit, node);
+	}
+
+	return fdt_size + blob_total_size;
+}
+
 static int fdt_offset(const void *fit)
 {
 	int images, node, fdt_len, fdt_node, fdt_offset;
diff --git a/common/board_f.c b/common/board_f.c
index 039d6d712d0..89a1a0b563c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -49,6 +49,7 @@
 #include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/log2.h>
+#include <boot_fit.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -574,7 +575,24 @@ static int reserve_fdt(void)
 		 * section, then it will be relocated with other data.
 		 */
 		if (gd->fdt_blob) {
-			gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			if (gd_multi_dtb_fit()) {
+				int dtb_fit_size = dtb_fit_image_size(gd_multi_dtb_fit());
+
+				if (dtb_fit_size < 0) {
+					/*
+					 * Fallback to default:
+					 *   - switch to non-multi dtb case (single dtb)
+					 *   - reserve space for current dtb only
+					 */
+					gd_set_multi_dtb_fit(NULL);
+					gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+				} else {
+					/* reserve space for the whole dtb fit image */
+					gd->fdt_size = ALIGN(dtb_fit_size, 32);
+				}
+			} else {
+				gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			}
 
 			gd->start_addr_sp = reserve_stack_aligned(gd->fdt_size);
 			gd->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
@@ -668,9 +686,17 @@ static int reloc_fdt(void)
 {
 	if (!IS_ENABLED(CONFIG_OF_EMBED)) {
 		if (gd->new_fdt) {
-			memcpy(gd->new_fdt, gd->fdt_blob,
-			       fdt_totalsize(gd->fdt_blob));
-			gd->fdt_blob = gd->new_fdt;
+			if (gd_multi_dtb_fit()) {
+				memcpy(gd->new_fdt, gd_multi_dtb_fit(),
+				       dtb_fit_image_size(gd_multi_dtb_fit()));
+				gd->fdt_blob = gd->new_fdt + (gd->fdt_blob -
+					       gd_multi_dtb_fit());
+				gd_set_multi_dtb_fit(gd->new_fdt);
+			} else {
+				memcpy(gd->new_fdt, gd->fdt_blob,
+				       fdt_totalsize(gd->fdt_blob));
+				gd->fdt_blob = gd->new_fdt;
+			}
 		}
 	}
 
diff --git a/include/boot_fit.h b/include/boot_fit.h
index 092cfb0b7fb..bf146286a70 100644
--- a/include/boot_fit.h
+++ b/include/boot_fit.h
@@ -4,6 +4,14 @@
  * Written by Franklin Cooper Jr. <fcooper@ti.com>
  */
 
+/**
+ * dtb_fit_image_size - Find a size of a DTB FIT image
+ * @fit:	pointer to the FIT image
+ *
+ * Return: a size of DTB FIT image (negative value on error)
+ */
+int dtb_fit_image_size(const void *fit);
+
 /**
  * locate_dtb_in_fit - Find a DTB matching the board in a FIT image
  * @fit:	pointer to the FIT image
-- 
2.43.0

