Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6985EED606
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDEA88FD1;
	Thu, 12 Sep 2024 15:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SDqegBC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F2588FE6; Thu, 12 Sep 2024 15:41:56 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768EC88FCE
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOj7o/byWSFXus32TlaKE6+M9J1x6mieox4QsutlNlafgd7oeBCAix8cis15c99PglL8CiwMiiNSZZn0LHuP2VcPA4fBC966i0I/rp/XZMx6mEKNzm5znBS2ypg3AtRgKo2rZl26ZeZGZMn1dm87AwgDPqt+llqYPcragQJC+xKshrtWmcBDTKqqLI11MghM5AmAEy4zEZuRGHMnrnFpVwSmTiNo9iUQmy7wiWkGbJPtzuHeXlORvvAxx6/wo9hUK3F79rqpc2XSslqlHnt+lrhzwEXLahJVROQCACN47Q2A3KQbs3N90q4VvE7UKtdtJea/uIgtz5RQrDqGLmJ7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2cT6svjjowq5FjTSXVgGpn7Gs7ULZ1pMscdKTOwXlo=;
 b=cAhVD2u90KUQSDo/5PC/MEEXnH+lI0ZMhaCEilcTIaT10UfcR+J26uXidITJ2e57xfrSz2UlWdLlp92ZYKofjeOpb1iTFY/OfDOlCOVSz9ONQ08APuSGElGfCbSmYhuI6GxsnG4p3RaheVKeAQuj0PUA2/oD0I/gNVX4ZxsjFRsf5pRS4Hj7HnlOrKKiv9r565/+PZAaU+Cu+AZ1kOJeCvwOJdrJTgUTnoj5ZjG/BAmuPjqiImO5aa6np+y3JE9LpxewpPxS9Bq0Fl0VXsYXJt1AFsD9Z1flmuJDIXaGw5RHOzA6mq73wLGlJ+5slgrcXvDL7/r+CBNANTKPscbggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2cT6svjjowq5FjTSXVgGpn7Gs7ULZ1pMscdKTOwXlo=;
 b=SDqegBC5jg9FCsFIKklubDYK9Y+aymh+a9hWNUkXXQAv8I3SrIwcVHsDqJihHOjbWjMs7sTOJiHUO/BymijHbWyTHeZy1XQDBQSOOr6AjZoAisZZDJ2mF7Z/RDAwXJLGnq3UWyG/MFcFlFrZJyo65VxilaOs/BvaPI9uw78SNN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:41:45 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:41:45 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/3] env: mmc: do not return an offset before the start of the
 partition
Date: Thu, 12 Sep 2024 15:41:40 +0200
Message-ID: <20240912134141.4143855-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c174795-9d40-4003-80e9-08dcd330a496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CrnqsIVTNjMIznoZrzwyzoCNKdF7H4cEOSBdOa2WdJ94xgeIUAopgU64YfEL?=
 =?us-ascii?Q?P0E05scmHTlapUuMvCYF3o0bIk8BDoC8SZ07zFxMywN180Cy6fvAG8T5ax2f?=
 =?us-ascii?Q?SnsLMrZNr39dVoQSOHrca9ohpp99WfWnuJab2jqRM/IRvbLM4hING/NS3evw?=
 =?us-ascii?Q?bUQot1hGrS1ACFuQ/Hy9TBYMpUqdHm0L4ZtCKOkPFDxEgj4ObTlCHCxbAbv4?=
 =?us-ascii?Q?n5GTgKpg3dD6DnebWiQpUNS/Jfj5hydFIU1RbXkLodNZz8D2ycfU8szmyqHy?=
 =?us-ascii?Q?nsGKBN7Lm2YPUN19IKf1vtR/Mxxj9W3eb38h6VqNxxOMZAWjGY0uYQZ4f/GN?=
 =?us-ascii?Q?aKiY0mzqQZCYsVx5DLVWCSI9/0zNL2yKIKjq0XSQcdJ+m6BWADRc0xL1whYX?=
 =?us-ascii?Q?Zrdl9nk1lAe6G4YNl6dc/IqIZviWjbm3qddZBTJyhF2Ck9MUS3g1dc9JD4OA?=
 =?us-ascii?Q?PeD/r+Yf4JuSL3/jOeCbh7kJhhBDJS3j3Oq7hhrL46fyfosGikfQnsmvfH7b?=
 =?us-ascii?Q?Mt1YoGaF0CMqemSutJvoCDv5a0LVNUyInLtM/wbSVTD/E8yZnyRzKdrs0lXx?=
 =?us-ascii?Q?/JNmrxTbhXxeaX8NfgjSjx9UbrAc/VJmx8OxxrZ1JorctNWhxVicHCL5/Ixm?=
 =?us-ascii?Q?1dqHKU9sP2IwdzRA4TubDs4r5UOzEcd/TaVpD6rQdYakE7tC+iUQIu8lSIzx?=
 =?us-ascii?Q?OpN4YVBi7gv0t6CZMEMK1SmeRjQK55XzRsvundlg/QLTK1fgtOv+VYkpfMQ1?=
 =?us-ascii?Q?/NQanQND/ZRmOAQyeiE78J6fB9+PFHqNm6wdvHLZ2QvHFkn2xRehU2crGXzU?=
 =?us-ascii?Q?BBMFB0pq6dyh4efbEdHVVuxDJM4Kh0XUMVjk6mprnfn39gIlfz99IPqDHDU/?=
 =?us-ascii?Q?Lly0Ls8spOAJFoMcpIFpHcycfaTnvHwEv1AO4mZ2YkiplrBU782yscFbgO3/?=
 =?us-ascii?Q?IRub9bzAUlfI29AgW1hgQD+CZle/R1Trbhg79hs4GOMJNoaTKGUqQvrJJQ2i?=
 =?us-ascii?Q?NM9kfAYH+zKhFfIptKIERRTVv7NInsFgZ6DWJtg00YgZe3HgWhhO6O9Uqv8j?=
 =?us-ascii?Q?Z7+jLkB/kYM7CQqY2JcrHWxqYlonvgGwseK2F5mBLOCzySJlVBdnvh5okspM?=
 =?us-ascii?Q?T/tsQa0VmXjdlatOv/UX/1UJYiW5eNONpzpMjslg615/Vhf30Iyw+x4Jyv2o?=
 =?us-ascii?Q?pYDApM/ZjUHBj+ouS90UQHQUt0B9eSQQrN8LLaCpdj8yxwBDF6bdSfonGkb1?=
 =?us-ascii?Q?+TBudnA3QDhMM8k2hnTZKzhWoCkgNZp9fOImMgV8UMbwBj1mts3sYJKMXzDT?=
 =?us-ascii?Q?6mLLiGWx5TMF2xCW2EJ/DxEbPAzoPzemDA48ez7hf+McSbro0qQpd+EYJ0Yc?=
 =?us-ascii?Q?nuAp7ifF59QN6VK7Djmcg/A4WFNVuqzjTZnvcOlDbp1Q/s+vig=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBqNfFfqHiuRy66bi2FXdymQcuEOe5Kj0jZ6IAI/RyVLiRncdggntXmkyctw?=
 =?us-ascii?Q?SAJXPsEWYTxhEbwv+G/+V+dSdsF8jJ+XkCTKWouvR4DSwUZjdgbWpz+m9zCZ?=
 =?us-ascii?Q?ALlXZiUekQYasw4NGIkCgD6q/LKJE5k8yMk8qfOSx2V3AMTdeF5rfd4NoxgQ?=
 =?us-ascii?Q?vQZdytogeS1klx8u0oGC557B10MfaOcxpKuNLz2oDF6c8qzudsKtIB9E1Nnf?=
 =?us-ascii?Q?dfilvFEU5k3xYn3B+HouxGdy2U0IU6ELcX5loVP6jcR9IQbXn/1cy5wbj+ql?=
 =?us-ascii?Q?ImKp3uY0vWdOgfEmaZsXPICw67QK6PQcmW1bM+26FoNwCBkOdX9131EKyM/9?=
 =?us-ascii?Q?9MxQ2LLAOIJ/v1DEbd5kIVrIB9CS6JqnaL9kAcivKZ9JU0uZa4YncO/kuKEj?=
 =?us-ascii?Q?zFwHegqq/06zl4HLe39yowcn9NMZtWmXXOdTSd2jq1x2Mf3+jYYQVhEne00J?=
 =?us-ascii?Q?dSQe+Szg6iSOKZRYwnGjsyRuoT/Y3b3gI/Ipy+JoOQSAvwT5WisiIknOtjkL?=
 =?us-ascii?Q?itwLCgGy5xU4oqeD6D4mZqCtC+0IRYm+eAhKa/vdFZURqG6ClBIRVNfJzlgC?=
 =?us-ascii?Q?pCUDi30m3q4sgR0XqGdYzl0N9q7KksbVELiCyNZFpUCdujKXCSb+QPJaBeyd?=
 =?us-ascii?Q?9HE8h+btjVY7rF5ZCbR60ysQ/IKPli2iwsgMCYvFx732UMCZpmi7FNcEDiv3?=
 =?us-ascii?Q?HN5KQUpJWLUF6PwHF1QOUXnQ5No8hY66dAw9brB6SXRV7rA2qrAL8aVqdEgq?=
 =?us-ascii?Q?tciiL9dMalcuw5/i+aOQcIrwulibNbjeEN1c96HrpsSHVTVZ+wV9xSHfgX/m?=
 =?us-ascii?Q?1ZDDsg9IigRSmPlVUySZ9uAFfSUNznYJI5DfVdAQdyt55q4/M8iElidK04Zz?=
 =?us-ascii?Q?3uzy1nLZ4R16KGWmhqoBepyOyGdQX2yNzsgfNN/i6Kb1AGTrZZVAxqw6c5gz?=
 =?us-ascii?Q?WoZ72t4KQA43x4ht7IZoKIuZ5i+/fgqBGHZ1PblA4Q8fTlW31ztwtxAfCGrj?=
 =?us-ascii?Q?8xVi6zo5KtnOvaMb/iWqx7K6BfC1hUBBkTG0OCUqRDFhAbY3npzxBKf/m1Yd?=
 =?us-ascii?Q?3uZ2Imid3iXPNmGZ1Zq8vVYiT8R0pIEmhB7RvC9bptPl8s4J0tWPWQRheOGN?=
 =?us-ascii?Q?mBuJtWyqe/VPod0+4hcZ8/4H2HazoqMTs4bsNkZBH7HZjhN3uiPKsDxHJz+W?=
 =?us-ascii?Q?/H7ZgelpFVTslYMTEoXOSo6ymb5d0LRAT4bOPZjW0zohnk3lmAWuE3tURieu?=
 =?us-ascii?Q?1wGmhEk5S4klAeudBrapCZ5cIP0knKSE7k0+H/eM1iCUAAqW6Ko0s657soZg?=
 =?us-ascii?Q?RE2eeqtukWiw1n2HRvBaTO07444SeLXImCD74JTQGyiyhlxAPdeMefAQfzlx?=
 =?us-ascii?Q?QGj5P6OzXZ/Cq++MxuwLq2y1swhgkcRgBTDODCX20vK+DCLnKSd1gciWEPdQ?=
 =?us-ascii?Q?Tnw3+IM6bnffHlCePb6XVTF1g135PJEgQWimwrUby0fVlkPQ5/ayTk+k/PFQ?=
 =?us-ascii?Q?dgi3a5LR+zayECeZLVyVtNUlIFey9gcTFGfFpdJhes8nnBEk86C/8D0LYByZ?=
 =?us-ascii?Q?D/ZFECyc0VbApCjhKMw+X2OGEFhAganlgu3rDwELGCnRyWHMJslNa+9MKkRt?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c174795-9d40-4003-80e9-08dcd330a496
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:41:45.4180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C58DaOiJ/hsBllb+EkMq566QpMkGCtETOdcA/IqEyQAojHu1GtLe/7srNEsHAETA8gRhLS6zs/2MjYpmk/tcCcS4zckQXzxulGqXOIkbtn4=
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

I have an GPT layout containing two partitions with the type GUID for
U-Boot environment:

        partition U-Boot-env-1 {
                offset = 0x1fc000
                size = 0x2000
                partition-type-uuid = "3de21764-95bd-54bd-a5c3-4abe786f38a8"
        }

        partition U-Boot-env-2 {
                offset = 0x1fe000
                size = 0x2000
                partition-type-uuid = "3de21764-95bd-54bd-a5c3-4abe786f38a8"
        }

and have set CONFIG_ENV_OFFSET=0x1fc000,
CONFIG_ENV_OFFSET_REDUND=0x1fe000 and CCONFIG_ENV_SIZE=0x2000.

This usually works just fine, but on an stm32mp, I was seeing weird
behaviour. It turns out that can be tracked down to that board setting
CONFIG_PARTITION_TYPE_GUID, so the logic in mmc.c ends up only finding
the first of the two partitions, but then in the copy=1 case ends up
computing 0x1fa000 as the *val returned (that is, the end of the
partition minus two times the environment size). That is of course
outside the found partition and leads to random corruption of the
partition preceding U-Boot-env-1.

Add a sanity check that the partition found is at least as large as
needed for the "one or two copies from the end of the partition" logic
to at least produce something within that partition. That will also
catch a bug where the partition is too small for even one copy of the
environment.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 env/mmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index db2d35e9bd4..5d09140655f 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -91,7 +91,8 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
 {
 	struct disk_partition info;
 	struct blk_desc *desc;
-	int len, ret;
+	lbaint_t len;
+	int ret;
 	char dev_str[4];
 
 	snprintf(dev_str, sizeof(dev_str), "%d", mmc_get_env_dev());
@@ -110,6 +111,13 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
 	/* round up to info.blksz */
 	len = DIV_ROUND_UP(CONFIG_ENV_SIZE, info.blksz);
 
+	if ((1 + copy) * len > info.size) {
+		printf("Partition '%s' [0x"LBAF"; 0x"LBAF"] too small for %senvironment, required size 0x"LBAF" blocks\n",
+		       (const char*)info.name, info.start, info.size,
+		       copy ? "two copies of " : "", (1 + copy)*len);
+		return -ENOSPC;
+	}
+
 	/* use the top of the partion for the environment */
 	*val = (info.start + info.size - (1 + copy) * len) * info.blksz;
 
-- 
2.46.0

