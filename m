Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE01AC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 20:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC08F88168;
	Mon, 27 May 2024 22:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VsvXeHQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8708824C; Mon, 27 May 2024 22:04:31 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A5088131
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 22:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMBTFvb2Xd0lvRQs6QVxLTw0e8y5nWsQfD9UMUVw56ue5rwHwLDdEZ7aGRqrfSrEJEapCR9blyJFOAWqdCpyn2ynRSXx63QRTLMvjB3s4WyNLMdqOZ6/DlsJKKcM1FKRfrN7u5cOKVztflmD2KhOrF9TmXrNUIKeZSoIzn+mbDY7pb6t3a9LK/NCmtR+Y2Cm+k7G5nUVgPVnZM82jdD0MSMQWwkCuSqHvsciV1VNx5N4NZbtigLcr0Cj+cu21viuDv/O8mKQKm9yWz4iiSWIj2kqyrzll+N1JSxLIpWGJPSHIbcGeNU7DDKC1gx5WMBdOISaGMKXitN6EIG9Mleapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LurAuOnU5kBXvmh8QSV/cOzB7oFFWQjsiAWnMJUVJc=;
 b=PdNPOBGuJ2/jVO5bobOICZno3KUZ0CTQQ9DZq6s5UjWIeEnSMlibTBB4ET88nhaPLUZnyu12zAJT9LoOh3s6u2IHGE6CkcTueR2Z1Z5Lr5YFZ9TOZBlkXtx98wmrLRlkqRrbPFlseWyxB4a75wPDapz9r9ImLjSnfZ7yA7BN6Rp/LUNKx//JzFBySPfbvZd9P936QWKqY63ull11i8mvitzyJaotnbOc7d8T9g3GxBhYo2zkhB74PsBBxGiOUEsqgKpjiP/wX5lkQl3WjYO42EpjqpOEHknURa+bsO4RwnyfJOb1jtIcB5kHVVoxfgBt5z/H6Gy2bN5t+Vn3uff3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LurAuOnU5kBXvmh8QSV/cOzB7oFFWQjsiAWnMJUVJc=;
 b=VsvXeHQwm/LcnDZxzFuyZjOgtBVakTVyEv3Wm0KnxrKu8y3I7Z9lR1+aLt4Nc9P5y9gF8mrxS2HmzMmH7+rTbDApNMVUPEygosKeI1RFotU4JGgeZqAlnVGrahZRksbONQeFKMh7xucLh4kMplgNJ+B8umt6PRubvvB9IWl7Ggw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB7201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 20:04:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 20:04:26 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] global_data.h: drop write-only field dm_root_f
Date: Mon, 27 May 2024 22:04:17 +0200
Message-Id: <20240527200417.2108290-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbb271b-51e8-4e3d-cf1c-08dc7e8835e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|52116005|1800799015|376005|366007|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fNH2NHAgZ1r2CR3UauF9wEb3IrTkmB8+QlMyuqWNs8OrdEAWYdaHJdM+b+3j?=
 =?us-ascii?Q?pbijnmaAoTJXlD+znSSNQTM9lRIm/MZODxUDjfCp2XfFZhR8EzZFRzYanhOe?=
 =?us-ascii?Q?at05jixTrDnJlrRvIqWLfVtmp27DFcqJkJD8DUhOFp9X+bMNVn8axGPOhvNb?=
 =?us-ascii?Q?muR1jyby/HS+SIKI0oKY7y9DAqzuPcxyIGsgqBGOiCknDoPeeMDQ5SEkYFTa?=
 =?us-ascii?Q?EqAzx77ogwZUTV/i2EHvBynL9AELAABvRKXUZry/aOc5biqP+QJWmLK8T8ji?=
 =?us-ascii?Q?NUslOmsAuPd17ZUmUC6iETm9m8X3qitelAk7PwHlIbWZJqTH7XFX3H0H7BPg?=
 =?us-ascii?Q?ef6wOpIr0Ei71g3O9Sex8KgKUYSbFUF5k9DiTdmN5+8KJ05UAuEV07F3UIEQ?=
 =?us-ascii?Q?ElUiojxis/s7/qnxlvrtf9HHKgzKVKPbw6yNJgwLg9+RXRGWnMbbw756GsWW?=
 =?us-ascii?Q?G7huQ2KP+ECHZk5au/UBLq17ekCYMBt5RjJbGAhyFTsv3M5opApblqPn35sB?=
 =?us-ascii?Q?x5YyMTiZZ58jnW9vNLdyXnZkOGuJGZL94K35wgm/Qxn05S1APb85yhJQx+SC?=
 =?us-ascii?Q?KQzhj6ADa+sxlmzJl/GTFgzC+0M8eIKmaWjefVz8u9Rwfr0l5dGyRDzsX0xB?=
 =?us-ascii?Q?QMur5Arkra1BacXpBbT+Uki1Qx6J5HS2M59x8Ru6O84y8wNBDlOdJc7nJzEJ?=
 =?us-ascii?Q?jlX37TZbYhZxaDxhRm4/zOjNNFRvhqo9nZq1zRLq65dpKJK0RePg6slTlia6?=
 =?us-ascii?Q?wr+nTnLthkztZCJkaifSe2w/C4LbVkbB5bmbUmtAkBmDepRajvutn/yb3h40?=
 =?us-ascii?Q?W86JHAk+VbkLAT0bVdesRmvtcbtqxIPe0YRkJxLgwUZvXyieLLBJC8QRZxwS?=
 =?us-ascii?Q?+OrGS+yE1ZkF29jGF1GKD6EU0iPe+6vgq1Ohyg2turTS1y8Q7LY3bJ5gxFQw?=
 =?us-ascii?Q?NYVwgpHaedNwsF9elHaT/bnL6WxHbqAn6bAAZuHD7WUnqhpwDFkHdOuuIRYv?=
 =?us-ascii?Q?nl3507xIHLizTfladXHiZ0Y98ArI8tkEUA9KnH3C/ZJbDm2711QsQ2xNS+tR?=
 =?us-ascii?Q?3pi+nB5zNI5FV7m1lUSCb60VhNZe3EI1ozPGie8rTzSH/XTF8QYN6K/eQMn2?=
 =?us-ascii?Q?c+B8GDN7zSyU/6NKGO8lBSVre2cYoNOhQTLxTq/At7QSNGK+d69Hd9wNf5xk?=
 =?us-ascii?Q?GE3kCNi36iEm+2zXWeoPUgHnyL9KXDaXQAAKTS6p+HHSI6YcYADNvDaTaiN9?=
 =?us-ascii?Q?chIGp2jZXw9bGG90ISMb+K5rGb+1WCJwDxPgQjOIvZEQX4NSS1DctI0k530G?=
 =?us-ascii?Q?IGzd/d8eiieYSywsmtroTvuF7l79bwxrOF8wu8hcybrg3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5lemHRgL/5TNsdP0aFFLFUb1hxfQtJ/sk+dNVIkxPns3oi409wQ3E+PsZAR?=
 =?us-ascii?Q?5r31T9lJrSJQEpvkvqCvLd3hTLSZGIvFun42eDNYWJ9zgRQmhBEXVKWiCSy1?=
 =?us-ascii?Q?u/8LOGlrIupy5mg/b9LNo1dkJhXNC3kIVy67ZSfzcz+ops9/uXlLtGgD40XF?=
 =?us-ascii?Q?GV9NQd8aDhh3Luo0wdUtk49PgJmGK+1vfhdLKIGXOvLjwX3RmQMJd0HESDxI?=
 =?us-ascii?Q?fL+kpQag31CSxLB2OAW1LNzHBy/JEbv0n9X/9pVuqPyF67F7CgdLGnPKIpIf?=
 =?us-ascii?Q?3R6mnqd5ukIstSnVVgi/LZGda9L1lYW+KT2DnkEkSUPPpZFx/FFeITGn7znQ?=
 =?us-ascii?Q?JNT4HUjOnStFJhtJ94ixQ/cHz+21LOL5J0WYPj4mJvRHcuYpaxlf3iuXWlZW?=
 =?us-ascii?Q?nyF8wKC0XqJ+ydDpLS2KTKUQhEuPs9oO9Pf+8pWvOu0puhm2X7F6HScWNxP9?=
 =?us-ascii?Q?I9FElKxvAIyjpc5uQIFXqw1U8h/tb4pnb37Vg56i8OKx8vBmn+wfoSOXK7TF?=
 =?us-ascii?Q?MkmpGDrzQq9PFBjwdODgzoCt8eNxupjjcM4kVw0jU0R1nhVq1HY4SmQpli7Z?=
 =?us-ascii?Q?/PZpDsj/S1M9ZZ5zIeHSuzv5d5Zioqv8uQRTzZDcKo2wcFM/CuKNDHCmPeFO?=
 =?us-ascii?Q?9zoLpwzdzroBNiIiv7o9zAAkqf0PQPMDqgqXaPoIeWWK6HfTndvNlW/VSKU+?=
 =?us-ascii?Q?+g2IZp+ZS3FcBoVcOIyRkdcXlX1s7zj5sU6j8Qi0cfRoYIfW63EQDiMGSefv?=
 =?us-ascii?Q?i/oO0eCGjBsGegQ+JAN2GH70sdgDTpn87fJML8/bEEVluQ9GXU7tL3bOV8vr?=
 =?us-ascii?Q?DeQQdrCQ6LDlqPJMmZ1jIkt9Cgqy5cVJ3U+5Tgp3Tz3nWYoPKnmNshbHXEXn?=
 =?us-ascii?Q?ffpVPMgd4GmUvaOehfgXyrTZ1zQ5rXb7aHsikvokOPHz0OIFXoAxqA5dn2ny?=
 =?us-ascii?Q?9xWy9MW21LhRDvKFoxXUIJku04TSszQgY/aoRdX8F72k44kILNKGplBvGNS2?=
 =?us-ascii?Q?ITf6YPUCyg0c4gqO5IH0Q/ecy6yM4hBbbGUqpxB+0wKxW/3IXUUIlj41IyBZ?=
 =?us-ascii?Q?Ps+JeM3clRmpgxFhKyivki4Wb3bnFEMk1jxtgDvMMWj/ypq8VErK75ITNgBb?=
 =?us-ascii?Q?R0lK3o9lmndXObcIT3bbz3ZA39G14A3pFfdn22daJbOl7KZ9HpBQ3QMuyHM3?=
 =?us-ascii?Q?9u+suhYZDlV7CFtGHpfEGgLCRYZc/t6/3ZeH+Fe7JaBPME/5fQAuG8Z3m2rQ?=
 =?us-ascii?Q?mxakKrUqPj7FclNn1m9BkKfp9MQk2XKafxT3i3fGkJj7QU2jl9MRRQi/O4Gf?=
 =?us-ascii?Q?oxv/2IMG6ruMKz/XDo4WnlseBIOQoMtQ+5zfQo2seA88xjZLXqGiFsxuMdY4?=
 =?us-ascii?Q?4CKzFJfp7edb0oeTGj0wsbI5bAEeGf6sHVLOrgKvu3xxkXJc4lvapmWMIkeF?=
 =?us-ascii?Q?8dV32gip/A8/7+7CsoaZjoEvSbhE9Z76oK5aghCYgqTLMp/PwE+79HMpsqQT?=
 =?us-ascii?Q?94AT5a97TuuD7npAhdn/3bYmMlHAmzd6EcR0AqAmnL+oLJ6Gq4+X/tAE3q3T?=
 =?us-ascii?Q?AXQbuj60qyH5rt1f1hpngKRm6osmCdE1JKhMq5P+NVchIrhEa268gFWaI8fN?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbb271b-51e8-4e3d-cf1c-08dc7e8835e0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 20:04:26.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6Cuv34yX36Zqnu9BL4PoSLN23i5r2hiQ40/9XJQnIHU0U6C1p0tmJ6xKLOuTPzlUEubS+iRnwVxhhG7zgUTRzN2C4xO1JExNLfvctA27Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7201
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

The dm_root_f field seems to be entirely write-only and hence
redundant, unless 'git grep' fails to find some access generated via
preprocessor token concatenation or similar.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/board_r.c                  | 3 +--
 include/asm-generic/global_data.h | 4 ----
 test/dm/core.c                    | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index da0b80f24ff..fd263f4a0a8 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -230,8 +230,7 @@ static int initr_dm(void)
 
 	oftree_reset();
 
-	/* Save the pre-reloc driver model and start a new one */
-	gd->dm_root_f = gd->dm_root;
+	/* Drop the pre-reloc driver model and start a new one */
 	gd->dm_root = NULL;
 #ifdef CONFIG_TIMER
 	gd->timer = NULL;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index fcc3c6e14ca..aa336d63e3a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -195,10 +195,6 @@ struct global_data {
 	 * @dm_root: root instance for Driver Model
 	 */
 	struct udevice *dm_root;
-	/**
-	 * @dm_root_f: pre-relocation root instance
-	 */
-	struct udevice *dm_root_f;
 	/**
 	 * @uclass_root_s:
 	 * head of core tree when uclasses are not in read-only memory.
diff --git a/test/dm/core.c b/test/dm/core.c
index 7f3f8d183bc..34e5c163b98 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1007,7 +1007,6 @@ static int dm_test_uclass_before_ready(struct unit_test_state *uts)
 	ut_assertok(uclass_get(UCLASS_TEST, &uc));
 
 	gd->dm_root = NULL;
-	gd->dm_root_f = NULL;
 	memset(&gd->uclass_root, '\0', sizeof(gd->uclass_root));
 
 	ut_asserteq_ptr(NULL, uclass_find(UCLASS_TEST));
-- 
2.40.1.1.g1c60b9335d

