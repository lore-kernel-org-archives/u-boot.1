Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD987EED606
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FAE888FD5;
	Thu, 12 Sep 2024 15:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dbFj8GC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D4888FDF; Thu, 12 Sep 2024 15:41:54 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9939E88FBD
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h80Ibl2TMbr5cYZADGrNdAJXWh7RThkKxyCy9GJSBy66nHhZGAn7MPBVgiuhhsGKsHgYLfGGrLfjtKQs9YgcGBpUr8hukOeOvu568xJsTLmKjWhkJYFdM1FDtuv/zu+T8AK6yMN9VP0XAJfR4X4SoOSUpxSlXa9AZ3yiyBi8bmw8OfoLb4U5PbJpwjFbq/gADxBVwYD6HjajZwa9ZFSP69CBqo1TKhRDehVliWUifNnkJPzPI+0lR95Xz2I2DCqgc0Ks/a1UE9M2s6D8dmwnXkxuCVVQJ0pMVLKfjhysM21QxIluKKZuMS+CJVIDyRPngmk6GeKJZhdlvnGqGEccRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Uspxl7cY4J8UeTga4cKrX4Y1c1UNOyOi2joSm5JNU0=;
 b=heGRcWWKunxzQHuRJFfJjmonfy4PSyEEccQquZK5OgC64kWr8uinqoUOjSAllOJqleLfMlBndMw5cctXc2bY3pvLsnS8fWFGv3aIsZkBS7j9mAZnTcQgxcRHASj5ftzK7aWIAeJqPyjBsaDcJnrnX0fTzboGMKfYT4MXOlKhJ83VXQx8Zq/c4F+NaiaDxAuELfLvuoEJy8sOXEWj99tSQPLvfbHyYokGPU3eK3D2qrpfZ455PKPkcWN1P2wZzf18dTNT77dAGjEIWwUXcFGrAZ+0gAN11yLkASHzTV++7nRkIsF6y6MBuUvVB6uww0Qg3akXpJd59aWxztshTMcAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Uspxl7cY4J8UeTga4cKrX4Y1c1UNOyOi2joSm5JNU0=;
 b=dbFj8GC6TLqCgY+GM35hCHm27/p56ELf67Ab7slK7yzjB1+zc544RT1SnQ1qB12RhXKBlopeib1CcoKHnMDgTH6rwysm9XRevw03lPi2edo6GMXrLVSpUn4RX3FOk3oIjxeGKWcucIVH0DVqNHwIiuHBN3UAq5uPdrvu2fbi6NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:41:43 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:41:43 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/3] env: mmc: refactor mmc_offset_try_partition()
Date: Thu, 12 Sep 2024 15:41:39 +0200
Message-ID: <20240912134141.4143855-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 66df9d02-c186-42be-2d40-08dcd330a3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?paQw7Xj5ftQU9I2+fjKdSrgs8KRWtcPu1UJrp2PrSSogSj/G0zFljxvU15PA?=
 =?us-ascii?Q?9M9sfOX9Yv12HYHL2SppZdbQWZLwAEpZLslhFNkEFNp04htyR+dGEIExHN2n?=
 =?us-ascii?Q?Y7IQFEiu+wAGjzFUv66+SiHyP4DbOaCp47q/uXlzye3A6vZgxOcMwbKSd8/w?=
 =?us-ascii?Q?kYt7qqWX7ZmRu63ZtZbmtSyJE1iny7vAlTjHkW2NY93jhYYWTZupSPeQbRK7?=
 =?us-ascii?Q?JeOJIyrMjJKggmL9N/lt8AnBEsiSlptfzn1RCXLWr+nYaX6YSIuw86JTG7oW?=
 =?us-ascii?Q?A8pKC5Wpdoe1ybujIrstUwwKRkkrghrFzfFh3BWNzxqRxySI2Z6cnPz6ojpD?=
 =?us-ascii?Q?Q70mqzAVHDRW5oi4bhiTqOGJpIzvg7pAofUUPe6/FFsKajiXYybe3iQQrxem?=
 =?us-ascii?Q?ylOsx4xsRsAxugKEhdRlWQ3nrg96Emire/0fQw1PVnGq5HrHbJpck9mW5NMd?=
 =?us-ascii?Q?WY1vde3VlS0ufRU4WJg8BQBMTmqSngZRDupLNssiGjuRJcYXFkd8iATtQv/L?=
 =?us-ascii?Q?Segw2rH9UzmASKz6Fp6JGfHOzMsx6QGf7tL8EEUxR18/0ipopXRXG7WfuqYN?=
 =?us-ascii?Q?HGaaBYfPuzNbeOnOhMRbsumIEuDNiTqZ0+P/x66KA5k1JPa6c0mladK8UT82?=
 =?us-ascii?Q?+rN+yZZJqphx0a7/5UB5ZEone8q9cgTCutREW48PNLdbxbPPCeY3a3RDzLWe?=
 =?us-ascii?Q?oJAAhjUONquO8769Rq1UXMz/m2TwJ1PTFF+766YidP6ojXUqVmJaDTDmtmd+?=
 =?us-ascii?Q?HiCTUpZ6sIU5cZkhb1KFxkbHNgw70aB2GRIYOV2cpoVUYCVoV8cXmu+R853J?=
 =?us-ascii?Q?jjHw+Jtmae5u47YNc06xGZqqBwSew0qRfnjyXSvZhlbpWvesPE8X1xT3jsLi?=
 =?us-ascii?Q?rPu8xcmN93NCSAqUFkGsJ643qr/TojMYyfeKeuWXRElw2sRVwHTLcVQVy2AD?=
 =?us-ascii?Q?nJPQWA0XM17+AKdyB/9gMqS4d3Ug83dyxTixsHP/eqKAzzBjB3VkVlHWGvgD?=
 =?us-ascii?Q?r2nZe1pGKz+XtYTC3a3IRBgr8Bv1tFu02vYqIDM//eFCwdcT/ZiZQMyGjZ/9?=
 =?us-ascii?Q?90GnKd0dROVqQcpjGIEjieDsJa47KHjQ8yklddZPJ519+mvL/IIQgFz+mK2R?=
 =?us-ascii?Q?62mGxPrwzKMLkdjbgzhulp95fOfr7R4i7wCSQTyC9pOKadyd0HJ+OVJjMWZu?=
 =?us-ascii?Q?4YbhEKJ4UEQruqwmHIKXOFulQM9Za8K+qj/5vAUGMO3aCKpfacfeeKpXp9jG?=
 =?us-ascii?Q?dVzglbgK7kqn6RL18w/jnldbagZhHGYPI7v6h4Wo77Tvr+DWxEEh+e1/NroS?=
 =?us-ascii?Q?KqaxY0s7VePtgDsFpp8hSjxnW5dDjFpByrORRWeXHn/wbuTGxmZs/qFU6Zoe?=
 =?us-ascii?Q?bbM5ZApeCvbzarcqKu2RPi0rtQ22UYKhls5j0nNIrp2JpABGXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ROWO8orGhqjTO/lEPmJBBGINGGgeKWGOmY9IORmIdvZbpzhT5ve6yYgT/pf3?=
 =?us-ascii?Q?PDz9cvLYktVYoedWrnAjV5LH3Rsmat1qzivPq3yVZ6cyIA7TCZfVQ8t3JyKK?=
 =?us-ascii?Q?ZVWK+l60Ge0hunnzcwohBKoQKj1iry2DTqoMtFS4HA6sDDs0n+byxmJ0uVBz?=
 =?us-ascii?Q?sclc7KBA1fWYWXlRwoMpmz1bujoiJUS0modSk2aPwDRs1qCwm6zx1Tjpax7s?=
 =?us-ascii?Q?c/PkNHnb2BVTgpQiczqjaO43KkVmW+U+uc6qDKaC4EsM62c+rdjaKKpcd4st?=
 =?us-ascii?Q?0Fu9ycTpzWCLssLYEjoDlQiVs3eKBmC5vvHlv7MozEihr0vfkNs17GXiHDMX?=
 =?us-ascii?Q?uZkqkpvOyxXesnBG8VgVLk8nqsD/RrVCefMLvEpkQLRVPmdmmVWfLZ6eCbjY?=
 =?us-ascii?Q?eGmUJiektxrxsfDIUQSCmw5Vrs6f2FStwQyuHep1UpuolHIEa69d0Hc+4nx/?=
 =?us-ascii?Q?YyVj+nCp2ECAt3RJ3F8o+QB5UMvuNnMhO9n2LpOZNaKMsPHaYO51+x77DKfa?=
 =?us-ascii?Q?+/ZMx1PbEB5O9LGU/G+x4i2gIkqSpKupWcNV25MpQdjPt2Snx47+/72+zYMf?=
 =?us-ascii?Q?9mNtMi8x8/551H4N7F161VFw+osw/9vbrlLalSAozWKMODEGhrOVW6OdPeG2?=
 =?us-ascii?Q?POw4ja8o9U7V9RON4BxCbhTbuozerOlUHXNhi5YSufvtUZmIWpN+d1himDvS?=
 =?us-ascii?Q?6JXYGii7pfHJoV2Fg4ojLrAjjoFMX6L018+JYiEmQf/EeU5lI9V9/O6QeBFL?=
 =?us-ascii?Q?bs5SNmtRDbbZkfsB8+2grwstIsYop6orjRJhSOasjSdFK6rkSZ6PM6YNVieV?=
 =?us-ascii?Q?TDNuExy4mh/WsMjcb6upJS0uMJSG5buP3ptWYXu/haLeJLdy0A+6eVQseHTI?=
 =?us-ascii?Q?AAniVqFPGB+gYDVgJ05IoiK3Ng1clgMZvlVZn5LjZS9NpI7ozUnvt8D0GMie?=
 =?us-ascii?Q?z9qJlXaDtqIsyvR4Ni/MQ/v207M26p2Kf7cwJpEr2TmmgC/WbtbyPpis4DwQ?=
 =?us-ascii?Q?f/GLir/mQWqGoRKBFaz8djZ81sx8JiowWsQdMY0ObTQP2fG3H5zx0LLTDdeY?=
 =?us-ascii?Q?fOwkpzr8FYxBvnQitG695Zy8rCy7cHjNORydVvif9EPG9rH86eV1+67KCNfr?=
 =?us-ascii?Q?o4I/jvuz9TqTA+TdL13MkZX2JBRvnHti71kJQwYsJg4a95AcetbaBUh37Lk/?=
 =?us-ascii?Q?LT1DtgFQJXDJsIvCjD3/Zw1E4GVooHaWD8d/0GBPRzIhq3L2UjBuOdIN34yY?=
 =?us-ascii?Q?6srckD+/arOnOJSuZ3UL4PQtm9ECgPBGnWgdvcBWiUbNhjyatay0UqeovpOZ?=
 =?us-ascii?Q?fYXDPDMtAkHpGBQnpjFvBbFL/KmSCUiX8gFy4Hu/7FJZr/uQCenfxddog1Ho?=
 =?us-ascii?Q?VADfqIqEdc02ljWybIc7Ga4g/N803j3DKe65zt0adBnT6dOfoS+TiNjiZZvw?=
 =?us-ascii?Q?HEXTOo1S70vODmrpuCBxb20WAbP3G8o2PteBgwxgbKkYQFZ3oaSqMwHDCKTq?=
 =?us-ascii?Q?U83DJ+n7r1maJ5EeQmD21jfiIf0YHRi4n/H3uubJEL6tjHnw2DcgiMhQkHl5?=
 =?us-ascii?Q?4bU2OLGbmjzJV7LPL+Jz7wVjeLi5Rq/pWPju5iNO1Ghxfkex8W5Jhmii8Flu?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df9d02-c186-42be-2d40-08dcd330a3aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:41:43.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vKGMlSPsHJD10LjQIYssNfvDmpjFArJYBfxR5y6CGpSWo8X7wKPfAo5B0hgf6l3eMC8eQy/Oqmn2QSTrQCkc49ewxwwZJvbjt9iVXa6lrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
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

In preparation for fixing the handling of a the case of redundant
environment defined in two separate partitions with the U-Boot env
GUID, refactor the

  for ()
    if (str)
      ...
  #ifdef CONFIG_FOO
    if (!str)
      ..
  #endif

to

  if (str)
    for ()
  else if (CONFIG_FOO && !str)
    for ()

and put those for loops in separate functions.

No functional change intended, but I did change the direct access of
info.type_guid into using the disk_partition_type_guid() helper, so
that I could avoid the #ifdef and use IS_ENABLED() in the if() statement.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 env/mmc.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 18 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 0338aa6c56a..db2d35e9bd4 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -53,11 +53,45 @@ DECLARE_GLOBAL_DATA_PTR;
 #endif
 
 #if CONFIG_IS_ENABLED(OF_CONTROL)
+
+static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
+				     struct disk_partition *info)
+{
+	int i, ret;
+
+	for (i = 1;; i++) {
+		ret = part_get_info(desc, i, info);
+		if (ret < 0)
+			return ret;
+
+		if (!strncmp((const char *)info->name, str, sizeof(info->name)))
+			return 0;
+	}
+}
+
+static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info)
+{
+	const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
+	efi_guid_t type_guid;
+	int i, ret;
+
+	for (i = 1;; i++) {
+		ret = part_get_info(desc, i, info);
+		if (ret < 0)
+			return ret;
+
+		uuid_str_to_bin(disk_partition_type_guid(info), type_guid.b, UUID_STR_FORMAT_GUID);
+		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
+			return 0;
+	}
+}
+
+
 static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
 {
 	struct disk_partition info;
 	struct blk_desc *desc;
-	int len, i, ret;
+	int len, ret;
 	char dev_str[4];
 
 	snprintf(dev_str, sizeof(dev_str), "%d", mmc_get_env_dev());
@@ -65,24 +99,13 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
 	if (ret < 0)
 		return (ret);
 
-	for (i = 1;;i++) {
-		ret = part_get_info(desc, i, &info);
-		if (ret < 0)
-			return ret;
-
-		if (str && !strncmp((const char *)info.name, str, sizeof(info.name)))
-			break;
-#ifdef CONFIG_PARTITION_TYPE_GUID
-		if (!str) {
-			const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
-			efi_guid_t type_guid;
-
-			uuid_str_to_bin(info.type_guid, type_guid.b, UUID_STR_FORMAT_GUID);
-			if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
-				break;
-		}
-#endif
+	if (str) {
+		ret = mmc_env_partition_by_name(desc, str, &info);
+	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {
+		ret = mmc_env_partition_by_guid(desc, &info);
 	}
+	if (ret < 0)
+		return ret;
 
 	/* round up to info.blksz */
 	len = DIV_ROUND_UP(CONFIG_ENV_SIZE, info.blksz);
-- 
2.46.0

