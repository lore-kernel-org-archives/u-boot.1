Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BFACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9F983ABF;
	Mon, 10 Nov 2025 21:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eo5MBz7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB83A83AEE; Mon, 10 Nov 2025 21:54:18 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00C683ACD
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrXCv5ny+Zn1j5jkmO27oC+nlGcArUtPj4XwLHcbG/HFhZOFcTMHnCtZ54/YAvP+X8tecor5F1V2rYv9PLoJgwtBTRdU2g7w23NtbhHxx/kMVZp0mwpkNlEwY4lTTp8gUcNC0z2Jch5cnh0wtZ0WKDCWqu6CVuP0/npN4NS+Qt1WyPxd/zur5vQlQSLqIGODODbNAeJN4IGNFqOPv+hhvv3vXcNGYXUFZmyX11eFrBl8E/Y7Ij118MCaGmxUlP0di2LnyJtGUKVXIBDeF9D7wcRzOyf4vtoXZAvsxS8+IzLb9mdiCycx8s5nClRln0RKut5jKGs5W7xxtYN4dWJbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1XZW0gzbmnPE4qgLth5GdjoPst7FMh8KkFKFlG+KV4=;
 b=BSyl4i8fBE1mIlxEWx1kEyZgr8FOs4x20JBLGCcDf72ZK+R/RPfJdfzyXC8HczxIma3rahaZu11AMZjEzLdg7G7NIjroQ+E5T9itVwZ1zaPOBRVg+YXUEz/Eo9Fx9HWfbi6j1CE8Ag7g7VX2V6ZyDk5/CxjNB/d0A3rhc3i7i7uhIo8Sil5Q+UR27MmNIbCcu4989qV+TD+Z+CNn46KLipAmvSl6k20BAaAZZ9DGJmNA+vgxeuPCFS7CuGXCPVBV0ydnLzj6hsV3/2LotYhiq5Qi4TrAFvwieLgIqJ4PU4L1uV0s7lvMqAb8QitWvCI9Aoc5WRJsEO35YkyBaxpgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1XZW0gzbmnPE4qgLth5GdjoPst7FMh8KkFKFlG+KV4=;
 b=eo5MBz7SvRNWaE+k4Yrb08QXOJZ99AWhqCoNeg3xDoByynr5KPk3YPc4X+XvHCo9tTAN1dv7985ibZOqHAYBrW+xXB7oHfTLOU/dqT7hXv++bUzmmJ0mjfME/KEIO0W6WL9uKwicKNSnLEOj+CE0HjLqOyRW6yvdL0Mpvgebs0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:54:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 20:54:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 1/2] disk/part.c: ensure strings in struct disk_partition
 are valid after successful get_info
Date: Mon, 10 Nov 2025 21:54:10 +0100
Message-ID: <20251110205411.4075351-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110205411.4075351-1-ravi@prevas.dk>
References: <20251110205411.4075351-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 59854df0-ca0d-4c4d-d757-08de209b4ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VB/rESbc4XuEtDJbgG0UBA2zQ4LrjSYUodiuUDOZNMqCXhOiIi1+J12lWffd?=
 =?us-ascii?Q?IITrnbe21OfdGLNwnugwDNQjZaHfrXXt3hMaXc7fk7twRFX4SD15OQ39SnZA?=
 =?us-ascii?Q?RoXO3A39dupmbe4iSMh1tb5o6Cj3mETKVzmu6f4NxzGjYG2q5zZ8LBvOYu4q?=
 =?us-ascii?Q?LC72cph92XD4l4eqW/RCINK47Qj9CGZ4t2XCzq7/6PfHkbeUXbaUMa1/wIwp?=
 =?us-ascii?Q?sOP4SOQUdKuJxH32NKST9JV3Sm7odzbV2lHmDfIFT2Bls7NIKqhbQIiGucpF?=
 =?us-ascii?Q?HZSXr7nxY6GobJ0kqiq6ogx92UgMafK6qZXOdykgKYU6ZyWMDzfk45N7ko6g?=
 =?us-ascii?Q?R98ZYIP62mfx9vZsApdAELB1Oq28AsYkpI2UOZHCBxGooNuK02AdqLXS3m30?=
 =?us-ascii?Q?UMwgXhA11InBMbK8ptPspcsha7aVJrSBqIF4QSGMI9w28E0gH0xQ0/2odzsI?=
 =?us-ascii?Q?RKaYdtEVhQa6Uzlv2TyHWbpKH973R0RwXswne++o2eBLsi0SM9AO8NH5ay4w?=
 =?us-ascii?Q?KfWA6OEmMu9+nn7y9ag5RHAXtSaWsbqLk0Fd2xCf2e/kwlQPJpqDQClG9LLt?=
 =?us-ascii?Q?NPzmrzmKIk/Yw0h9YU2SETPWK7XuKBxhYNcr9Pq2pUTFItlKpzA9hKkGk7wc?=
 =?us-ascii?Q?pucMxqLCSxHiKE2VFbehnLlK6OdQnhG1sts7yH3mAUl3lHmjbsW9pDGVetwz?=
 =?us-ascii?Q?s14c8lSg8fs51Pk7BxugpAxyWCiV3UZOQa5PqE0ekSsUEngm+7tv9sNKgDMZ?=
 =?us-ascii?Q?AqoBaea3oSdB4wUping9n87wTtD0sgqYel6HO012gDNqQJDIrCzL23BMqAqC?=
 =?us-ascii?Q?7h8z+/KPPMk+GXus5FB8notVguTVfCt49luG22hpHcEj5QlAVKhAJ7oCWP7M?=
 =?us-ascii?Q?q6bb9pJ9PsPvvDmDYtKp+71Cn+FEK+Chd53XhDg/jNBYV/pxe7GNNR+gYZfD?=
 =?us-ascii?Q?W6DBGqywXO+Z3EFfmKo9EaYUSYm19OAieoDyIKn2jQg679A1q2dZwsBoh6lr?=
 =?us-ascii?Q?mkAcMVNalsvWIWWqDiXctzqFgmN2wkcOOKkhJwKKmkRf3r4j6v3IJetCHDFr?=
 =?us-ascii?Q?aXpuO/bNyWVCeX/1DtwVeHLp8wLZpAHn9INUUh4Iaq0+aC5EZu0UG2iJ8Bxv?=
 =?us-ascii?Q?2+jEzjtuU4EMBn6O/4WOVpzUyEXclA2OTxFXULaSHJG+yrzCwwQ8T2SqRVYM?=
 =?us-ascii?Q?B9sZYsp7F/iyqcfE78mdf/YIURQJFjJ+6I4HPOrUZ1ju+gpqVM2+yyailyCv?=
 =?us-ascii?Q?eeK8ec95h0xKJoiYA16MvjXqcPSPwoukty7xraAplldxM3R7z3QVD4gYMPwW?=
 =?us-ascii?Q?RFSQrbBJWQ/dqorhakz9bSC6Ll6WmTw6oYr8ZRG5aW8A/Gu1WXNcGPcdRIM0?=
 =?us-ascii?Q?htlhHd8qIV2S0uma9mYoSsrk9imoTuDGvF9ipW95qHCZcEA1yBcBNJ19M8wY?=
 =?us-ascii?Q?nkdIX/+s50Q0j68GFuKdSqfrGMBScAjgGf056Hf5JDnqrgajbtZhLKNxYZJo?=
 =?us-ascii?Q?gToJuRHZiQA0ALqj0n623UXvXD+AIL5cJrM5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?boGv4FTxnWCqELGDM7TMzefOKbBgjs+MvCorTTCE3MUaFrB3nw+4zxdIWhT/?=
 =?us-ascii?Q?XLE+Q36hPYi/mOEATuRuFQZdoQXLF3bpPYu64rJSzmrFihxnxJ1k113kbyIS?=
 =?us-ascii?Q?0mhZjzacTFCLFAfxxlPBwZA9hY+BQ01ZaDwLbPstEOOHhk/Xd+d8hYdK004g?=
 =?us-ascii?Q?MSbZAAoXGBkJSPwgNFB38U6QIZHLdrIrgpoWveh7eUYxGrvX1UX78L9pLmcA?=
 =?us-ascii?Q?KLPDhI+T6drd9bhSA0/OCAgV1c2xsxWD2ANHrLPkJobQFleCuqIIZWAliGIv?=
 =?us-ascii?Q?m27j0F/CPcrcbIZe48e0QAhPVUXtEx9xTvo5CiMSKhAc4xi68eVrTjma1ses?=
 =?us-ascii?Q?iWcgxZvez6kDpXj+vZkNYN1mDY/ufxQY6hKXLXySTP7WosRDNVzT7KAp6avZ?=
 =?us-ascii?Q?01k8DRJm0JKqkDluWpkvEiNUOjJMlT30detzDIgHHFWc99WHEvV5wQu0we+F?=
 =?us-ascii?Q?MHZ7B4Ts3OsgdyABWbpwM2oacYXiBAQpgI0tVXtRvc2jPSPxb3m6EKuaNhsC?=
 =?us-ascii?Q?lxgcEdPMTiutm79lTo0AQiwrOdvPiWQjD3DZM/2ligHu0um6R5cdym46bxm2?=
 =?us-ascii?Q?f6ssN8+jjV5t4pMXq3g6iBhhwZxv6Xh+4NhNjRBNGCzdcPzbaMI54NIOPh6+?=
 =?us-ascii?Q?VzLzrfpxTG004ypX/z1z5vdMbVbHSutDNTXBQX334AXkOoy3iCRNbUMLXqeR?=
 =?us-ascii?Q?V5ysJR/AujZFSE1vbFH91PXYAiQUt49JYDpk70l8OqWmro3j4wzNQPsEqVR+?=
 =?us-ascii?Q?J9WCF8+nOouR3GQcXn6kuVAT9QYeDxw9Z6mJ9gqRA+839f4goYWoyyxjx6cW?=
 =?us-ascii?Q?TueZ1pxCgQpJNOpOVRSUe6HJ0g79SQkKgnhd/pEIWgop621flCXfZCmjznsW?=
 =?us-ascii?Q?FjCHzypc7/+FFxMHEWMk6dOxbW+c7aOL4O11P+SGRjpQhllWpakh28CnJOsX?=
 =?us-ascii?Q?1o+SR4f/utJvAx5dY0bvhjd9K+KBtKEmWGhd+NftiNUdW+sHF6p2Da8wQOzh?=
 =?us-ascii?Q?SkLLHG9d22Gg2JvGgAnm5TOOntzp2NE7LkMGG6dkqgeDFP/AVlT8FWvlk+mL?=
 =?us-ascii?Q?eyUnx70WxENiIiWStA05+MRK45XxmbjJN6XvILiywjbV4iwFW6Apk5vvVi7q?=
 =?us-ascii?Q?SrM3F4lyN0O1zhwdLeiR+upARKg/BeEPrTg+xerTWStP4Mu0fLE1FK39bc0E?=
 =?us-ascii?Q?mqvrVIlOFFdP0tpQCgLV0Hnof/oc1EuXE1kdttwnvcMq56P6IA9ZZ9ZDuGH8?=
 =?us-ascii?Q?iwGzS/zfGzTCJULc2OyzH7SYm0/qMkBR03da4FDamAgFrGrnXqI70lMCHmxd?=
 =?us-ascii?Q?EVqbIUnoWus4l6l8MegUFfYGY20CWmVihU8xQDhUa9sxt39Z/AkF4SN2iqZ3?=
 =?us-ascii?Q?BLaqxiWaROb/PxwjeprsD8YExX2W5P8/Mjswt0YxQ4RlGcEdZYtkQmrUU0Mi?=
 =?us-ascii?Q?VBgNYVlGew3GdZfCg+KV4Hse8mnESELJ0Qz3q54YNh2PNkNgrEV/MbnWGggH?=
 =?us-ascii?Q?5BDXxm64fnPEL0S4ePI+llUNApO3+qY3zxjLEqLWPpA1Ty3IHcX9G9h4+Nll?=
 =?us-ascii?Q?+tIYUs11Z6y18a/Q7eaEILf6vQyV3ry3Vc9YtCr/SVk9pnEh2dyc1Pm+2YDQ?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 59854df0-ca0d-4c4d-d757-08de209b4ea9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:54:14.6586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTTVS2jvIezgZbw/xHb7jk9kc47KfUjQs4RkrmTYX3ftfZ11BhT3Ix7Xv15Jnd6gH8hXICYQLElErTqJ2k64VkUBzEkBEScQAXfGjnZjaz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720
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

Not all ->get_info implementations necessarily populate all the string
members of struct disk_partition.

Currently, only part_get_info_by_type() (and thereby part_get_info)
ensure that the uuid strings are initialized; part_get_info_by_type()
and part_get_info_by_uuid() do not. In fact, the latter could lead to
a false positive match - if the ->get_info backend does not populate
info->uuid, stale contents in info could cause the strncasecmp() to
succeed.

None of the functions currently ensure that the ->name and ->type
strings are initialized.

Instead of forcing all callers of any of these functions to
pre-initialize info, or all implementations of the ->get_info method
to ensure there are valid C strings in all four fields, create a small
helper function and factor all invocations of ->get_info through that.

This also consolidates the -ENOSYS check and standardizes on using
log_debug() for reporting absence, instead of the current mix of
PRINTF and log_debug(). It does mean we have to special-case -ENOSYS
in the error cases inside the loops in the _by_uuid() and _by_name()
functions, but it's still a net win in #LOC.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/gpt.c      |  4 ++--
 disk/part.c    | 63 +++++++++++++++++++++++++++++---------------------
 include/part.h | 16 +++++++++++++
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index e18e5036a06..84221881c39 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -724,7 +724,7 @@ static int gpt_enumerate(struct blk_desc *desc)
 			continue;
 
 		for (i = 1; i < part_drv->max_entries; i++) {
-			ret = part_drv->get_info(desc, i, &pinfo);
+			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
 
@@ -820,7 +820,7 @@ static int gpt_setenv(struct blk_desc *desc, const char *name)
 		int i;
 
 		for (i = 1; i < part_drv->max_entries; i++) {
-			ret = part_drv->get_info(desc, i, &pinfo);
+			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
 
diff --git a/disk/part.c b/disk/part.c
index be2b45d5a29..49a0fca6b89 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -72,6 +72,28 @@ struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 	return NULL;
 }
 
+static void disk_partition_clr(struct disk_partition *info)
+{
+	/* The common case is no UUID support */
+	disk_partition_clr_uuid(info);
+	disk_partition_clr_type_guid(info);
+	info->name[0] = '\0';
+	info->type[0] = '\0';
+}
+
+int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc, int part,
+			 struct disk_partition *info)
+{
+	if (!drv->get_info) {
+		log_debug("## Driver %s does not have the get_info() method\n",
+			  drv->name);
+		return -ENOSYS;
+	}
+
+	disk_partition_clr(info);
+	return drv->get_info(desc, part, info);
+}
+
 int part_get_type_by_name(const char *name)
 {
 	struct part_driver *drv =
@@ -322,12 +344,9 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			  struct disk_partition *info)
 {
 	struct part_driver *drv;
+	int ret = -ENOENT;
 
 	if (blk_enabled()) {
-		/* The common case is no UUID support */
-		disk_partition_clr_uuid(info);
-		disk_partition_clr_type_guid(info);
-
 		if (part_type == PART_TYPE_UNKNOWN) {
 			drv = part_driver_lookup_type(desc);
 		} else {
@@ -339,18 +358,16 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			      desc->part_type);
 			return -EPROTONOSUPPORT;
 		}
-		if (!drv->get_info) {
-			PRINTF("## Driver %s does not have the get_info() method\n",
-			       drv->name);
-			return -ENOSYS;
-		}
-		if (drv->get_info(desc, part, info) == 0) {
+
+		ret = part_driver_get_info(drv, desc, part, info);
+		if (ret && ret != -ENOSYS) {
+			ret = -ENOENT;
+		} else {
 			PRINTF("## Valid %s partition found ##\n", drv->name);
-			return 0;
 		}
 	}
 
-	return -ENOENT;
+	return ret;
 }
 
 int part_get_info(struct blk_desc *desc, int part,
@@ -657,15 +674,12 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	if (!part_drv)
 		return -1;
 
-	if (!part_drv->get_info) {
-		log_debug("## Driver %s does not have the get_info() method\n",
-			  part_drv->name);
-		return -ENOSYS;
-	}
-
 	for (i = 1; i < part_drv->max_entries; i++) {
-		ret = part_drv->get_info(desc, i, info);
+		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
 			/*
 			 * Partition with this index can't be obtained, but
 			 * further partitions might be, so keep checking.
@@ -695,15 +709,12 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	if (!part_drv)
 		return -1;
 
-	if (!part_drv->get_info) {
-		log_debug("## Driver %s does not have the get_info() method\n",
-			  part_drv->name);
-		return -ENOSYS;
-	}
-
 	for (i = 1; i < part_drv->max_entries; i++) {
-		ret = part_drv->get_info(desc, i, info);
+		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
 			/*
 			 * Partition with this index can't be obtained, but
 			 * further partitions might be, so keep checking.
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa..d940f8b5d0e 100644
--- a/include/part.h
+++ b/include/part.h
@@ -509,6 +509,22 @@ struct part_driver {
 	int (*test)(struct blk_desc *desc);
 };
 
+/**
+ * part_driver_get_info() - Call the part_driver's get_info method
+ *
+ * On success, string members of info are guaranteed to be properly
+ * initialized, though they may be empty.
+ *
+ * @drv:	Partition driver
+ * @desc:	Block device descriptor
+ * @part:	Partition number to read
+ * @info:	Returned partition information
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc, int part,
+			 struct disk_partition *info);
+
 /* Declare a new U-Boot partition 'driver' */
 #define U_BOOT_PART_TYPE(__name)					\
 	ll_entry_declare(struct part_driver, __name, part_driver)
-- 
2.51.0

