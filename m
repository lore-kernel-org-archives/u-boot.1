Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8D5EE14AC
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A5285F2B;
	Wed,  6 Sep 2023 18:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TrUVmwcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE84866A0; Wed,  6 Sep 2023 18:02:09 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A346F85E44
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 18:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBC305XKiYRiGZJwLkNr0QLlGBXRdV1/rdwdHlFsRnS3sYZaWzRnO1W4iVWfRXa2nilLjZ+VQg+UuriAcSsT4xjDRD3yPYpwOoYBlOG/+XpuDdGorZQ2I44vwWXYa1/zCmu1Pq6AyazDmXOtoK0CxBivflghWTYzcpJcJX+3MJfO00jzpzJ5EDjDC91SqBMh+o+zcqAYdXZjs3jb0ot4rntnyCz8SCl4ROfqFIw6G5NlRKhXraxC4ZE8kqDexaWgIAQtgss9+/cBpCpkBBRJhV6LpzD526TaPJe2buvOQyxaNWqzO3/6diW88PkfGOBju7N6h8dNNqHcAT2CzZjkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuL02PCPrLrP2Up53LBSoTTczBCAU7+ImQLpEARBH6U=;
 b=kM/qtnbmpB3qJClBDA2GKYRTp2GlxeRCK7g3xQ1TAxCdFRc1tTFP/imdyRWMhmPpWyhL3YUjEPA1NfSCoiuUeoIeXEKafXCdoaAaxn/+mGEWiJtT9bpPG7niFu/VH8e/gGbdEHoCZtUvKsGI8IhFAOQAYeMQAfqvUrau4iYWhjr7O4ih6qwysE1KhRvInFzrJ9ZVvnjM4UvRYbNuQzFoUe0KzHJ3AqRlrhvSv82FiAU8P6Tu8bOU0163wvCccvebltYjng+Ob7DM15OFLM6AikqToZFZqmZFXH94HEWvoOrpQfXlbfIoGE1+7ZXAS9MUM+dlNz9DkHZUhQ8339mNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuL02PCPrLrP2Up53LBSoTTczBCAU7+ImQLpEARBH6U=;
 b=TrUVmwcsvOnfq6LEakL87M1P4b4RaeUioXIMbtl8PNxndih5QD2OxO4lStUr/F7r2XWl3XVJtZxVPgR88/bQPsEOCkt6PBpd6ymeiaJx7dDbD7A3Eh7yvSyIYPtc3HUoXDyOWjozdLtgFefdYITE/DRFj2BjL61v5xa7Fma8ZHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:02 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:02 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com,
 meenakshi.aggarwal@nxp.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 peng.fan@nxp.com, sjg@chromium.org, sean.anderson@seco.com,
 ioana.ciornei@nxp.com, u-boot@lists.denx.de
Cc: thierry.reding@gmail.com, robin.murphy@arm.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/5] armv8: fsl-layerscape: make some functions static
Date: Wed,  6 Sep 2023 19:01:48 +0300
Message-Id: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3dfc7f-d981-40c9-b0be-08dbaef29bb3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQ2Pu/wP2IwpDSI8oZPjc88Q/aRk0FMEPNiT0G9qbWe8za0OMpI9GHpeTAhm4Z+Zm3dmdhVSX+SGacIkcDHta32j62kBP8SkRxLn1Txu8nP9SxNVUia0Ad4Q/wvqqtSNPaYiI7jMv1hUKCvsBt5QYJNoQpL8PNHYYiFNBngS8Ve7ydq2HeqzXL1J5McwEnkXZnkZ79qcz16pG9CQJ9/nPXC2H4Go4UXr4tLML+GC1mnIx2s2FnPvRKv1VJGE3dClty55GCT0/IRzgz2teOCEc+mE2kODDZzer1wObo7DvrmJOm8f4UwtC+8CFNdkvUIP4aA9SaZQTiWlpmIJ3Kt62LK4PhN6P4hv9uNR2lXurFPOa2/H27DDvmzYBpCfIzy5BEcXpkKdZeJs+vDepMiyXOqIc/Ax6rw9dA9pnsU3EToOk7qmR1TGk8VQPz/ux419IzRaxzT0bAaAYMHboqExzH/DXEa6zk3Z0NRWGYPlv0FP+5vTo9sI1J7oYenYfcJ6ORpXNGjbuWS9nSZwUGN5S7QDQFbnLdHGjUW6nMk5yJUOeHA152XvBk8nlx7MGsqit9aQgbt1Rx7hKvPZvJ4v0G5E8kFHlcLMZRex95AvQHPg6wh2Eybp8ISBk67x4aMR+kISxySfszm3uafQDuYvPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(5660300002)(83380400001)(86362001)(41300700001)(44832011)(6506007)(8936002)(4326008)(8676002)(52116002)(6666004)(6486002)(2616005)(1076003)(26005)(6512007)(478600001)(921005)(2906002)(38350700002)(38100700002)(66556008)(66476007)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3VXvjLGVetR35xgNocLVe+9kQomvjcpLh3MiwZG3mntn7/17d7QrD6ZZ/lN?=
 =?us-ascii?Q?ufbLCCmkAhzufOB5jL/hhjUl0N8EwvuMs54m8MsKsZEGIcjlD/MiIqpiH8Hy?=
 =?us-ascii?Q?UThFpaKHbKS8W1aq+rWrqP8fDpqyD8fq5xbJGm/xV8bIZuR1unkH7uyqAZ/t?=
 =?us-ascii?Q?FZo3VZU2vofln4iIp7T9V7gT2ic1MeSjSsUNTvo150H/pjV1gdBp5tUavbCr?=
 =?us-ascii?Q?FBNntoNApRI9NpYuWj4A7Xl4OLUjI9mxNKmzz4oOrN5IPS/xpk2NSexpRlCT?=
 =?us-ascii?Q?1KOrelGjxkAnNYcO4+yfj2o+cPYtaQOeaxRvlBBVgzLtluVHSRH4qFeKwSun?=
 =?us-ascii?Q?I/n6LpYQkcAYbbxxcftDtGdN5QgMGmEnVs8kd1aI4CznVJRtuLc84/BJGiQo?=
 =?us-ascii?Q?MxJ/sojB7ivOx0w+i7b4exlR/sUaVSYj2RoNE3DLK/VzShq5TYzubjWXBgv2?=
 =?us-ascii?Q?YU0C516LdHWVH3BrQYIZopah8UR56T7ZaSpFIbXvvSvzAH5aWbYFhGcoMpBD?=
 =?us-ascii?Q?NIDvL+z6g+89JzYEaO0t/9ONdSCvabr4nWwaN8PCkr4vqLSNm8SXp11w8Q0A?=
 =?us-ascii?Q?w1YLGTShcEuCOjl0wj1/PBiSSoIBRyxS8bk2P4Hcc9TogV2dsQtXpq/vLtA6?=
 =?us-ascii?Q?wI23C7lrWBW2iUjMuBAB5e0WtkeB0K8nHcvzQmxMncscO0UZgMD1vNQ2/boa?=
 =?us-ascii?Q?27DY0hqxgxfj78wKnC4V37XyYsmaBu1FlbUAqq5La2r2uei5pBHvKCXri3BW?=
 =?us-ascii?Q?VEm7B97DtRP5srC7ezXlyI5gy0c2j6TEAK66YFftQ0Loho976k2qnd4b1xMV?=
 =?us-ascii?Q?ph/2ky8SlaxX03nz/GlbGlLTQufIHKFcLB16k7Vfsu8x25sDx2TghvG2e1Ut?=
 =?us-ascii?Q?FF6RDoN3Iv119HaDa54OfIdt6Is1PhVwfPa87kqvhzzrsK8QPErYi4IpeGMU?=
 =?us-ascii?Q?/v1yR4OxnPYQePZhRHRCm/VCIdpk1i+lW6A+/4C7GgwcX70QdFICWhAdByV9?=
 =?us-ascii?Q?V+d2atQgHxwr/vxPdlsEvFdf1rxV8LXjS8N8bd3TDE6QItJFIGiIXvG6H448?=
 =?us-ascii?Q?L+4F6YROCewDsLjScxpu8cNNq4HOYlY3XbPGbNWHVyMVfyRZDbEM8pa0G1fd?=
 =?us-ascii?Q?nWSTLV3OREY4yDZXKj9CJFK9YiZpnT7+gP0QkoZ1bijdOX6He2KsR7ruWAqc?=
 =?us-ascii?Q?NlOFA+i2ah8RnO92GgzbHADwdPhPSn6YUsqQTuIqHhVutSrqC9lAZYpMD/G8?=
 =?us-ascii?Q?SdB81oHwVy2/oRopgUnJtE0jeyAyuTgBlC3o4hJsgPaq7RhthHV/QSgT8gSz?=
 =?us-ascii?Q?9bMotYXs4ElpVzF1MoMNGplpBN7XdYWX2aaJea1zUkY5ZzhCI8BX/SbinMK0?=
 =?us-ascii?Q?l63QfIVuJ4KKEvfIXlGwDpi8kdXN2HcexsU71xqCFBGK0P61obJn5UcH+8Lj?=
 =?us-ascii?Q?B3AC3pKXNmjjRpHo6PWG+bxQ/3NijIx9n11p1mv+C6WhJXEgZzXAJ3ZChENF?=
 =?us-ascii?Q?jTjcUfrfNonOXLWl2u9t8AvDRMgzZdW6vVk/IGju2BWKxCGgh/ANteoN0Nb8?=
 =?us-ascii?Q?aRsx4KCGy2OIO12BVnUI2JF9Pc/euWGxc/mdRWDT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3dfc7f-d981-40c9-b0be-08dbaef29bb3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:02.2699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgRstDhQKaC3qb4gyuQiIygOln+K4PXQKFT2qEOG3G9147rh06ie9hbz8Ksf0Kg+tv5czi8IkkEQyDtVHWWybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
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

Some functions are not used outside this file, so make them static.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/icid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
index ad20d71717b3..c22e73253c3c 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -23,8 +23,8 @@ static void set_icid(struct icid_id_table *tbl, int size)
 			out_be32((u32 *)(tbl[i].reg_addr), tbl[i].reg);
 }
 
-#ifdef CONFIG_SYS_DPAA_FMAN
-void set_fman_icids(struct fman_icid_id_table *tbl, int size)
+#if defined(CONFIG_SYS_DPAA_FMAN) && !defined(CONFIG_SPL_BUILD)
+static void set_fman_icids(struct fman_icid_id_table *tbl, int size)
 {
 	int i;
 	ccsr_fman_t *fm = (void *)CFG_SYS_FSL_FM1_ADDR;
@@ -71,7 +71,7 @@ int fdt_set_iommu_prop(void *blob, int off, int smmu_ph, u32 *ids, int num_ids)
 	return 0;
 }
 
-int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
+static int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 		       struct icid_id_table *tbl, int size)
 {
 	int i, err, off;
@@ -98,7 +98,7 @@ int fdt_fixup_icid_tbl(void *blob, int smmu_ph,
 }
 
 #ifdef CONFIG_SYS_DPAA_FMAN
-int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
+static int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
 		       const int size)
 {
 	int i;
@@ -111,7 +111,7 @@ int get_fman_port_icid(int port_id, struct fman_icid_id_table *tbl,
 	return -1;
 }
 
-void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
+static void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
 					const char *compat)
 {
 	int noff, len, icid;
@@ -140,7 +140,7 @@ void fdt_fixup_fman_port_icid_by_compat(void *blob, int smmu_ph,
 	}
 }
 
-void fdt_fixup_fman_icids(void *blob, int smmu_ph)
+static void fdt_fixup_fman_icids(void *blob, int smmu_ph)
 {
 	static const char * const compats[] = {
 		"fsl,fman-v3-port-oh",
-- 
2.17.1

