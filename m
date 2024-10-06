Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C83CFB43F
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 07:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381C088D25;
	Sun,  6 Oct 2024 09:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VfjV1SMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DBA88BFC; Sun,  6 Oct 2024 09:23:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999F988BFC
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 09:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx/AUkCpAKZMhAYmKpveAA9DkqfJXWUzYkQmpQmAsBg3VqrWaWevlmoa627gXO0uRqiOhFLXk4xkJbRd/4ObpTQdVOUxHCd1gp6Dvyhka/wmdDf9GWsI0o0C7p+1Pvr94ebfkK1QmgdUp489jFkSuZHQ2Gj1Y671yVD71REtwnnmFB4PRyTZ+piKgZNEks/+dieuIe1kgqCYswBuv6mjscUIAkbSGbSz9lJueUtLRQ7Uxx7XuPptsSpSchfqIOAeVBdrNWJOu0Rc15fza2U9tvQNi3BIaQKWpAXb0PxAvYGNUr4q+fj74LH7Sq1x2ZZg7oAtsmyUriVc2kkBqjAnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxzlCxRWq4ywt3PZ/TgeOhBjGYdZ005zKlPR5G08UNc=;
 b=imUdHqKY9YPSomZ8ik3Snc4b1YIoLCnZ4CCferK8HoGqhKtfMJv89AQkA8w5Uk2kkT6RsVbp3W+XvYZWTUPhRpYMFUX5SwsKA5Smk5lR7PR3Nb42QE+MxHfZC2LK61HiHun/xiSAgC9wyvcx/B9L7Jvs27c81ir0Mdkl7Xkdxx0axaH9Hrhu+O+0xbm3pE9eXCtj2nSH/kK3uHEieh1MZn8ZwcNSdxiKWBttB/kVbi0t5pONlrU5Ha5yveXzCdqhn76s3tsWX46kJ+VOzl7jGf5CQ031o6Txvy8JRSDCpuhvl13qTBWZcAK9MGCYePOS273SwSHXjozoQaqL+XVdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxzlCxRWq4ywt3PZ/TgeOhBjGYdZ005zKlPR5G08UNc=;
 b=VfjV1SMbpQjfL0a8j9UtRcARQt+Vv8/xSAYoOyTtCGhk5rqOwqLjF9oIr/G51xFoNoApsQETwUYI5KuXgdQrNXy7dx+GCAevWeDxAFIGbSZbe3FAh+XIAEoe92cJVH8xTwyMfYxBk/FUK97bKDi2yNckQ5Zfe9+R2M4robSjOfaK3N/ar6EFUVi/VdtJsdCLckCNFz5npJa6qCzdti+SCbTPzmOB0oD9ypmaowsAC/a9Evk0m7COBFNXEauHKxGbW4IETRwceQLjZ10dUQQjH9p2XLm19/H201t0ACFi6CRQFFgX69FG6nuFUY1Gc2erunmSvtlZ+MW6e6t26ho+lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Sun, 6 Oct
 2024 07:08:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 07:08:08 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, festevam@gmail.com,
 marex@denx.de, viorel.suman@nxp.com, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 1/2] firmware: scmi: use PAGE_SIZE alignement for ARM64
Date: Sun,  6 Oct 2024 15:07:01 +0800
Message-Id: <20241006070702.2792392-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f4f6d4-cda1-4011-a527-08dce5d5a1d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivUE/7sHUwuhAKlrYo3v99VvOruidobMrrtC0q9cQFuj572OTh1aXsC0Dz+I?=
 =?us-ascii?Q?+cVrZ1+BB0ytiWWCjrZYuONZOMFx5Rb9JOVQ0MbJpXB2DOvnQgMC7yg8bsbe?=
 =?us-ascii?Q?1hky2rhIPBeEUZuNm3dvjytbUD0HwFW+kgHGRtaERhiE9Wk1DhJZMtSAHcl8?=
 =?us-ascii?Q?x0VA9ffc+R5qemOs1PEQLahT6hI24Kzugr59DsZeYZgF0l5HtYcqd+tst8Tv?=
 =?us-ascii?Q?3Nk2UvsvXI/3GQ8t15udfxEQ1YHTDtTiJSAugemZWP3/OiI0Ld4x8ldJ9EPu?=
 =?us-ascii?Q?ypZXM5ZxJFdsTy/gATc8CPx1gHVp60roUxVfzoLGdcDWEo8Hp9dYt/hXabnr?=
 =?us-ascii?Q?JJkzS/x10uvQ2EmM1bkR0UUr5olBlBSVuvRcJjjMYC0azgP8Ivgiz4OXahoI?=
 =?us-ascii?Q?evIvgxaLRmYlx2/p3Wa77fZwdz77bq8tQbGFVfGkriW7cD4gqaCDtiYWu1+w?=
 =?us-ascii?Q?y0+0CaRfefFKJ1lfVBg6H4zX/ohjr1Tf1gvj7dfbu9UjO98l7Y4uBQy44IAh?=
 =?us-ascii?Q?k2WO4lXO3cPpqnL/w82e+EZOQAvjXnEz3bZHeGbITZtmPRCntZI7g8PTSyCc?=
 =?us-ascii?Q?ND4r5LSn7lI9BUKfzXctM52mxmnJ5lLTPlJEhYhfYL5lBEU3fXLw9lnd9+CY?=
 =?us-ascii?Q?+bFyOU8+Se5uzIWNggfOpgCk/Gqq/WlhfFVdJ1JnWtUcYsQSI2orYVW8wfS4?=
 =?us-ascii?Q?8Tz0YHmvgDDBfAjwfqr31ky0l+GceABGeL+iuCR4XIC3oNj1HMK3nzlHKbp5?=
 =?us-ascii?Q?ofpqb4bL6ylYCDr79TCp62Oq4VXTapqT16nHdPoMAIEV9xCTnDTuqis7gEWy?=
 =?us-ascii?Q?rPggCHg9kTv8C0+m8bJuoX5V65/IAE9uMSPjGBqZWs5BZ0txnjHPgZLj/+Wk?=
 =?us-ascii?Q?9eOuhnF+0kmcsr2eJnbcpGZNIYLV7Tvh+QMNofHZZBp5qLGmJaP0jFFjAGj+?=
 =?us-ascii?Q?Pxva1Dc1mJeKgaelIyQnesta5f0tNPBxOAbbCssHBh06Y7qeSCWX76+9fcan?=
 =?us-ascii?Q?VkzkY2gVN4NJo1vfGAXLVZKb3raPQuKt9C5Cq8KurZcOUUhDQFVnOIiYV9Kx?=
 =?us-ascii?Q?jUQQm8WT4MJbVlt6zlzY2Qx28Obc2+PVGdC57ClfAB7HlzzCt5lRo04UFwiM?=
 =?us-ascii?Q?II0BNyazKN5Zn0twH5HQz82GcDsjt/NdmkGl2i2anIoDQ0GjqEXM1NojAht9?=
 =?us-ascii?Q?MQ34nc938u3g+Cf8hNCOPCIzsv+LKMv4FXh8QgkWS9w7kK3cu0gdH7bAMESI?=
 =?us-ascii?Q?fK0dl/7Ns5e8raaNs2PJtmY++ybpLt7at7zAWDwCyFcAfm69tY9g4u1dnYJ/?=
 =?us-ascii?Q?A42vapamMPjtAhymBUwO8wFSJiBQFZA/3h9GKuoZ/1bOeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+xXBPbx/fiF5dIlqb+gG7hTHpdd+Y9aQT415/Fp0KL2FCtYQNL8iP/aT3tc?=
 =?us-ascii?Q?N9ON31N1KKZ7qfp2FAjZo5sdTfgjgOD2qvQFM/eAYhWQuFiMUQA8NNM2stBv?=
 =?us-ascii?Q?Scd5hhGUCvdppk9qVVkbOeR8/TdoxJ13vHyIi/T2mTOrCIGeFCageJ42BAzg?=
 =?us-ascii?Q?q6tuG2s+xxN4rmkfcZEJLjuewfdO1EOx2/RsX45CocbN4+K8tyOZGS06YZ/k?=
 =?us-ascii?Q?6hv4IinnyejS/iwgk57puPzGAv90bdN0JYrnGVQN86QAgNEQFXZxcIs7FaoS?=
 =?us-ascii?Q?enSM1h8cIp6xZySVknHICwuGo6i+FTulSnFVQ5K+Vl2iNu8RevPA8pNFo77n?=
 =?us-ascii?Q?M2rhg6EL0SUwNIwmBJkDGhCnbrTLQ2V4FiGTvtTgoygs+HadDKCGxeNzbG/M?=
 =?us-ascii?Q?E4vqjI4Wb+j4xlJpBaqfSL+DmaYRD/HZjHyqT7jJMLOUN5Klgn73yA9c+m3O?=
 =?us-ascii?Q?BcdjeGq/ixyaUIYBZHcIsgPWO7ND2tdSGjHGCmhoSj8TbVl/z/EdBu3hfbnB?=
 =?us-ascii?Q?GTDWwK///zO0brGd9FUvcP+cir1V8FN8uIxEmCBlxBLVQYi5eGAmceAx+hOt?=
 =?us-ascii?Q?O5OSh1lG6gaFZnyWQKAHb9Gl+TPBTOql9Rjvj/bWvDe0rIKkGKq0q6xMRgnW?=
 =?us-ascii?Q?C4tsKSNY3WVxshmINRZeYYXADpe3EwPZpefS/VjJH11KV+UFXIDcP2fHB4PA?=
 =?us-ascii?Q?YYvhiwXmBOv4kGo6wC3GY43kbkucLV4ELfpV23NVQfa+nE/gXNi/ySJMOyrL?=
 =?us-ascii?Q?zBrqnwWunFaTyZFavfpCilzPQ+GiR61jgD7qXbn89Fugpbgo1hwpvvs9SRja?=
 =?us-ascii?Q?rZalyPVUtqNqV7FrBtbd//lJvKsgU9tfFkx8qbzcvXO+ywGP3wFtFl/iXXfZ?=
 =?us-ascii?Q?8Ru1zm/8s+2VpkBlpTvpn5ZcmBB8D8C63J1bikdzryRbafxKno0khPBnNhoc?=
 =?us-ascii?Q?tBWvHoqLB4ynzWujMYfoYG2chCpm02g6E6IS2VAUffOqB3hamjZiRUes9d24?=
 =?us-ascii?Q?CCKCughRX9NrJKDF1Eye1TwQGd+mqfbvtfJVqtmmN6uZVh0ZY1qg6D7rJ1aL?=
 =?us-ascii?Q?p2xfw5UZAeBQRrFORRbEOahSvQ6nE6iZMasvEXeBa10GUh0OZaj2YLSHvMvy?=
 =?us-ascii?Q?WY7aUOmBW6VWXcJEKpFXhLHBbxjhCUkvZe8zomwb9Bz97dutEKFv2g5mp/4A?=
 =?us-ascii?Q?0qsbak+dZ0LmJFRIJVkcGIykDsp0w1DA7Euz965+b+Bpgm3w2RLSdpey+eys?=
 =?us-ascii?Q?ZSSjC9YydpDEhDdipTlVvByHpziVkXiGDUO2uXoZEAdUOKtZ84+IsoYHG/31?=
 =?us-ascii?Q?0ElhTAnhgGTX5NSHWInOFobVK9sWyfXRMTwFOoCVIFke+hZcLuXVjdI0OJCD?=
 =?us-ascii?Q?QE924FrO3qAxarPMJ62zcBB6VF4F35TzTzM5ZoeUalb6qDlI8Ad1o7WtmKtz?=
 =?us-ascii?Q?fNmu6TXIQ4IqLM5iCShNcpAH708aiqz+EXxgpftgBvU6DiSx/RTmiAqeqyrc?=
 =?us-ascii?Q?LZlNQX3lJELJ2E0OuPbixG4x4hWThwsI7tC2A+yGVreAjw0i0Me6A1ASfqoT?=
 =?us-ascii?Q?Jqfk+f0u/cBCA7CvleSRypYq+nE29Roq6lwGqcvp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f4f6d4-cda1-4011-a527-08dce5d5a1d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 07:08:08.8320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihxcTCJZhTTz7u0CUpqulez0UqL8k1y9YjKEsrAzkDbZiyaLs5CYQjARUy9ckvJ4PL53sPtgedNXD1wVUf42mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6873
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

From: Peng Fan <peng.fan@nxp.com>

For ARMv7, the alignment could be SECTION size. But for ARM64, use
PAGE_SIZE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002..e9d401f0da 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -29,6 +29,7 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	int ret;
 	struct ofnode_phandle_args args;
 	struct resource resource;
+	u32 align_size __maybe_unused;
 
 	ret = dev_read_phandle_with_args(dev, "shmem", NULL, 0, 0, &args);
 	if (ret)
@@ -49,11 +50,15 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 		return -ENOMEM;
 
 #ifdef CONFIG_ARM
-	if (dcache_status())
-		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
-						ALIGN(smt->size, MMU_SECTION_SIZE),
-						DCACHE_OFF);
-
+	if (dcache_status()) {
+		if (IS_ENABLED(CONFIG_ARM64))
+			align_size = PAGE_SIZE;
+		else
+			align_size = MMU_SECTION_SIZE;
+
+		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, align_size),
+						ALIGN(smt->size, align_size), DCACHE_OFF);
+	}
 #endif
 
 	return 0;
-- 
2.34.1

