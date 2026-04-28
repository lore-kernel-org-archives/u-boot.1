Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8C0FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 10:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01FC8466F;
	Tue, 28 Apr 2026 12:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="F9/gSqTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6289B84679; Tue, 28 Apr 2026 12:07:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC8184658
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZX3A25qWYUjhBqw718lZOiwGPhk40n+AW3tgJxxLbkqVB/NCehZVpSYMVMuMt9uOCp4pjtgenmAwZZMG4S8F4+dGxRO1kPyrARlmQ2mwtRE0jsQbYqCmJl393uylLcMLqbnwuKzCK4D6sOb0CStFCNM5qM4hdO5e+hqymuYUQx9yaYgrcMq+dvZ+wDHb32c/wtGTyAWXIv2pWAZnmq2axtBsn7N31KD9AnA03btiHoXsQmnMwK5rI61cy28KJZjIoc0aQR1Fpjjg+i6DgYOWhd3pLhotGsOAfjFXAsWcUKBdNtSn66W1fzvs+hybtjHmuQ60PtA9wo69gXGGkw3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO4T5jMQgV4a4CsCS4WEbg4tGwOu8z2iQzeKLpHnanM=;
 b=cerA+/8UE4lpRYx8YM6ctms8DKjnuNT/I1H6QUs8WhRZEd976t0p94U29Al7WSeVwj41tagy2vht+oeASWI4vJLrMw0ZYNv3S0co1aSbijPZfxe/lQ8tIooDFhubgpE6F2LCi/240lnqDgPFrp4Y0yvTUDpH3CKAhOwsWN0QT4x8330Ps8kM1VTpmNJ3x2naa0gy+X4zaj4tYSLGe9bv9tjzDCsMmhp+FyPRzVT+5cTeJnLBqEPJcsQxo1i/Ohl1C6c7vBK2gMlwoLpYHvwOa40fhTBBaws/mh7dXiSQEl8NLj4Ls1LJddHUKHbuzKxhMhzGHwpnmWbbkPIvOC/8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO4T5jMQgV4a4CsCS4WEbg4tGwOu8z2iQzeKLpHnanM=;
 b=F9/gSqTD2u4vf/NjwsddWEhCB9EZX5Vh1wofHAR/SkIMMrlh2vcW7JMapOAEq7vtmfQpzRDt8cVaNNZYozYeXcZWXtFb1D9PIsUUZHKToYk+4SScRgqVn/r3fOojVWjVAQvh6Ee/AwamEFKN5dgTHu4jcXkTucY72uQtUE+paZxBuMGlusdanjzv08mw84yQRt6/O3baMDuZyXXa6DR2++TZBDUx1OWb6YiHBCOVyFd5fvdS/OyO7y/oqJhAem92ZuUZO6sbORAb9EQsMg1kKH/Zpjt4rKMqnSiV/2Jlk1bVIVUPwMHUAInmn+u+AeqD8Hp3lrxDw/F8UyT28DsgqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by VE1PR04MB7487.eurprd04.prod.outlook.com
 (2603:10a6:800:1a2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 10:07:50 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 10:07:50 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] imx: ahab: Use authenticated header for images loading
Date: Tue, 28 Apr 2026 18:09:58 +0800
Message-Id: <20260428100958.1868472-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 486cdb7e-0c33-4350-aa15-08dea50e0124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|19092799006|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: dFg+7J+IwDElk+LE/KkRMpDBEWhXSqD33pC3T3LVfLMF7zQnkoOJ74E5kAeOtQGvDM2I7IE1YSYeQPCnmzWjEFiS06BOPUk8usPw5mssApdQBG9XOQnYwk1s9AgOQyPJFuHWImh1n04zyahsHZnBJCqadv6y42fiNeq7RxTFz70VZ0/nHPa306/ay15m7R5U2se/uMnZMmzxD9vahyZhXP1fy9xViHWtIMOgwnXoEDbctRbFfLkH49ek9WQWiRlq0/ZNS6+QakmWcBgkp7jx+xlMtwo6twsSqOsOOBEMHJwNhvkDrDKd6kbGrDd3AfxvwLxG2LlvnK+BwPFsr0UgpP+tTL63etL5ghi4e/UWS7dbkD0Bnjwmnx8zAnmJGWQ2he5V7DjhwgJlGm5sNyIbeTt86cO6NrWoMWf/Tizn9oAQHn57fjs0uNV2eLyQY3GopuV1GuCfzReIgXKWf0h8t8LKWvs4CTRAXgPPCWVRy6DJKLsfncyg4j1grvK58PcQKnUOoe2jxnyfyGgHZogQNQTXVve8ZPjNPhYPND3bXMzE4eT4kgaVcqJDjj6QuvCs1A9+XUdm97MEuM0vAhAlhn6tTQtuNib+98Pnw8vvRI9rhna+YsudlJEmMaY7hlXs+qNNd5UJz5AGkvynHJHDvsYb2ZQffJpc2XwIFuQgDMEfJnMw+Epy7ZIDU1kYM6bkdDCKh044LK6CBjPM7JrC5De+nmrTCF6J9+27gljkWFn/3A8gq4xxE+PbK146jEvxP+kWxltQewrnGNm/ue9CCUuDYS5kYWtlyCD5fvaS/js=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(19092799006)(376014)(52116014)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqdBo8AQAImeXpuKqpmGZ6hfbfWNpv7YuMBmkF90cAptaGfCFvt8E4C5E7B4?=
 =?us-ascii?Q?G6ObVzy5MaZ7coa5Y3uhVSwjFZGu7beUhVnFeroomIHhARW1Dvo8p5+BNIwH?=
 =?us-ascii?Q?lLs3yYV9b2GIiexrrsqoDaaXAYjU4nAVWj1GkIGBSltdoCnSGWtYhTcxWId2?=
 =?us-ascii?Q?GT8I12nQaEY/Idki0L4k1g4cxlFDE2EUOhAqiKJYbFPwREiavMp2ZgT+zCKp?=
 =?us-ascii?Q?gheR5tvviHgHtsssmNzOlFXwsx8tFqzZWdNVBKYN+x9wUjSen6aySsY5e9Oi?=
 =?us-ascii?Q?+lhkPDtZliOtiHIt16XwcpKbgPcM6C2UlTwh0AGjFlvHfSKAMqmMq5micw1v?=
 =?us-ascii?Q?vcFbDpU8+rTn+bP7mXS7EBnzmvHvOjnX//tHNcc9JKUoplQAXregKhQRSljR?=
 =?us-ascii?Q?WwKVHfPMVMeTsSc1ls+D28AOLlfpf1WfjeBLm7XLEacpiYLpg4PxW8Ytxt0s?=
 =?us-ascii?Q?uftrQxZVvzLWOjZSMq53u32Av2HTdv8D1ENKxAt3FuBIi4sg/nG0KvD1OlGq?=
 =?us-ascii?Q?oCuDGDFB4fqhTIlbZyLZVfNqygrbJYz1YRhzDplv/TKoqpo7YvJ46SAccGvQ?=
 =?us-ascii?Q?rBflrQfqHT72vNpjoGrKeAxZNsMjanBLNrrLLQ6mHUt00Ah4ec2s3Fz4obOR?=
 =?us-ascii?Q?sotBV76/qIemhZl6eRjYjlXmueOlOimQlAvpLk82QIfDQ+/a9xQ1Tn8KzUN6?=
 =?us-ascii?Q?DaPAXg1HgBF+/ug7leiNzsDOegdtlEqvhE2Wm8fq81ut5K93lPHH07pAKp9J?=
 =?us-ascii?Q?8Up65Aztpq/YhZ7Qeayf7zFKmIz/qUArYifTx1fruZ64vSLj1j+Ex883O7Oq?=
 =?us-ascii?Q?nbniiFOFwW9ADywjmI8L1aXCevscbdvycP76wNVuL+s3aNGX4x+RcUFCgUH6?=
 =?us-ascii?Q?b1JOC32n8UXCnfRXjCgJOWN12Ve8y2sIgONrxGVjXVqtrU2dyAvKQaF8NGKB?=
 =?us-ascii?Q?2oQdrSr+EL7g+VCvB+bYeHvQx8vQ731Nm2soKIeK8QALqwnd4WrrURnrRKGQ?=
 =?us-ascii?Q?So7Hd9A/gbG13pkg3YGHLGyIUo5gQQxuCbgu2AW8BkRfOBZzXazzRPRf1k8b?=
 =?us-ascii?Q?jxWFQYkJlcOi9fZy9lgxjJIkhxy0GHCr+RR0nMChUGkmXK+CuHzUPEI3fYrt?=
 =?us-ascii?Q?e0NOwNGG+AF78gbcQdDb7ydCBgHOynISWydPLcIK4z+4NlDORZ5RVz7QzuSE?=
 =?us-ascii?Q?eLNx9isYN/sQ2dxPJbwfh+UhpbQ9w/mtPGLuZCMnntqSgUIsSawS66IVcVug?=
 =?us-ascii?Q?1PXEjrJlAUCghKTPyLVfZuQOjUKBBjEo1OkzQlUvJphAvQbuyIS2Khts2FNJ?=
 =?us-ascii?Q?15z59IYnjRLa0ljGZroP2Hs7m+3rOB/IaF/UPeyOndvVhki3LwrpCYjKmpkR?=
 =?us-ascii?Q?Zk6i2IWKavK5PVKw68Gq2Xs+k9tUEIT4U9nbhfEsWmqFeh2IekefWBeDm26o?=
 =?us-ascii?Q?Rob00MeBnby9ZFd9gy0s3TO599Bnj9WpEpwnWcLtXtebg5lPm3L6MwLRCdey?=
 =?us-ascii?Q?8ohJyMGOdou05xmaMV7vEJRn9DgrI0VrDPkoPirPQD0d9P1tnlRFcvCtzs5E?=
 =?us-ascii?Q?Ph9Vn0vQDRTGZrKr4lSNBr4W5GYJLn4FGh84cwQs165CpOeCokxibv/p/h5Q?=
 =?us-ascii?Q?9+mNkhjJGAdd6ClT5iAYhQy29J7nYbnLz6A4kqb4J+dizaDj2Zj6JUMsKFno?=
 =?us-ascii?Q?CeWLg2As7bco32r1aNxoVynVu7e5rah02KIiL6c/DrqfUhUd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486cdb7e-0c33-4350-aa15-08dea50e0124
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:07:50.1758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD35009XsZgOR4Hz+yOYtF2jSFM9JikbJOlwjxQhsl0JZ0XFVeob7ZMzv4HTd6uf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487
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

When loading container image, the container header is loaded into
heap memory. If ahab is enabled, the header is be copied to another
fixed RAM for authentication in ahab_auth_cntr_hdr. The better method
is using container header memory being authenticated for following
image loading.
So update ahab_auth_cntr_hdr to return the address of container header
being authenticated. Caller uses this header for following parsing
and image loading.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/mach-imx/ahab.h |  2 +-
 arch/arm/mach-imx/ele_ahab.c         | 12 ++++++------
 arch/arm/mach-imx/imx8/ahab.c        | 16 +++++++++-------
 common/spl/spl_imx_container.c       | 13 +++++++++----
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/ahab.h b/arch/arm/include/asm/mach-imx/ahab.h
index 4884f056251..dad170cee47 100644
--- a/arch/arm/include/asm/mach-imx/ahab.h
+++ b/arch/arm/include/asm/mach-imx/ahab.h
@@ -8,7 +8,7 @@
 
 #include <imx_container.h>
 
-int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length);
+void *ahab_auth_cntr_hdr(struct container_hdr *container, u16 length);
 int ahab_auth_release(void);
 int ahab_verify_cntr_image(struct boot_img_t *img, int image_index);
 
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 9794391fb35..86b11bdf2ac 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -255,7 +255,7 @@ static void display_ahab_auth_ind(u32 event)
 	printf("%s\n", ele_ind_str[get_idx(ele_ind, resp_ind, ARRAY_SIZE(ele_ind))]);
 }
 
-int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
+void *ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
 {
 	int err;
 	u32 resp;
@@ -271,9 +271,10 @@ int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
 		printf("Authenticate container hdr failed, return %d, resp 0x%x\n",
 		       err, resp);
 		display_ahab_auth_ind(resp);
+		return NULL;
 	}
 
-	return err;
+	return (void *)IMG_CONTAINER_BASE; /* Return authenticated container header */
 }
 
 int ahab_auth_release(void)
@@ -327,7 +328,6 @@ int authenticate_os_container(ulong addr)
 {
 	struct container_hdr *phdr;
 	int i, ret = 0;
-	int err;
 	u16 length;
 	struct boot_img_t *img;
 	unsigned long s, e;
@@ -357,8 +357,8 @@ int authenticate_os_container(ulong addr)
 
 	debug("container length %u\n", length);
 
-	err = ahab_auth_cntr_hdr(phdr, length);
-	if (err) {
+	phdr = ahab_auth_cntr_hdr(phdr, length);
+	if (!phdr) {
 		ret = -EIO;
 		goto exit;
 	}
@@ -367,7 +367,7 @@ int authenticate_os_container(ulong addr)
 
 	/* Copy images to dest address */
 	for (i = 0; i < phdr->num_images; i++) {
-		img = (struct boot_img_t *)(addr +
+		img = (struct boot_img_t *)((ulong)phdr +
 					    sizeof(struct container_hdr) +
 					    i * sizeof(struct boot_img_t));
 
diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index f13baa871cc..71a3b341913 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -28,7 +28,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define AHAB_HASH_TYPE_MASK	0x00000700
 #define AHAB_HASH_TYPE_SHA256	0
 
-int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
+void *ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
 {
 	int err;
 
@@ -37,10 +37,12 @@ int ahab_auth_cntr_hdr(struct container_hdr *container, u16 length)
 
 	err = sc_seco_authenticate(-1, SC_SECO_AUTH_CONTAINER,
 				   SECO_LOCAL_SEC_SEC_SECURE_RAM_BASE);
-	if (err)
+	if (err) {
 		printf("Authenticate container hdr failed, return %d\n", err);
+		return NULL;
+	}
 
-	return err;
+	return (void *)SEC_SECURE_RAM_BASE; /* Return authenticated container header */
 }
 
 int ahab_auth_release(void)
@@ -126,7 +128,7 @@ int authenticate_os_container(ulong addr)
 {
 	struct container_hdr *phdr;
 	int i, ret = 0;
-	int err;
+	__maybe_unused int err;
 	u16 length;
 	struct boot_img_t *img;
 	unsigned long s, e;
@@ -159,15 +161,15 @@ int authenticate_os_container(ulong addr)
 
 	debug("container length %u\n", length);
 
-	err = ahab_auth_cntr_hdr(phdr, length);
-	if (err) {
+	phdr = ahab_auth_cntr_hdr(phdr, length);
+	if (!phdr) {
 		ret = -EIO;
 		goto exit;
 	}
 
 	/* Copy images to dest address */
 	for (i = 0; i < phdr->num_images; i++) {
-		img = (struct boot_img_t *)(addr +
+		img = (struct boot_img_t *)((ulong)phdr +
 					    sizeof(struct container_hdr) +
 					    i * sizeof(struct boot_img_t));
 
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 79d021f81dc..57cd75b9b5e 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -88,6 +88,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 			       struct spl_load_info *info, ulong offset)
 {
 	struct container_hdr *container = NULL;
+	struct container_hdr *authhdr;
 	u16 length;
 	int i, size, ret = 0;
 
@@ -140,15 +141,19 @@ static int read_auth_container(struct spl_image_info *spl_image,
 		}
 	}
 
+	authhdr = container;
+
 #ifdef CONFIG_AHAB_BOOT
-	ret = ahab_auth_cntr_hdr(container, length);
-	if (ret)
+	authhdr = ahab_auth_cntr_hdr(authhdr, length);
+	if (!authhdr) {
+		ret = -EINVAL;
 		goto end_auth;
+	}
 #endif
 
-	for (i = 0; i < container->num_images; i++) {
+	for (i = 0; i < authhdr->num_images; i++) {
 		struct boot_img_t *image = read_auth_image(spl_image, info,
-							   container, i,
+							   authhdr, i,
 							   offset);
 
 		if (!image) {
-- 
2.37.1

