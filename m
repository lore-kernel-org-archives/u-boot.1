Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A323F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB26A84390;
	Tue, 21 Apr 2026 09:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JrCQXvvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ECC28433B; Tue, 21 Apr 2026 09:55:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F4384310
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMTMW9sZuRK3rCkjpeMgH51EkweZwPDcNm9ZMi2+/WL1atPHMe+3McAf7QUaQsIqXT7nVK9PmH5lFSO9B5UMX+3ddlWH2Mgz8UynBBqpwsunKXTuvoJ7k70+aMuSu3usDAB4PFFnjYK/7LbCEpIKFNi+i/MQpocx+ECF+vS+W6k1bNB5I4fTAbNsjM990QX+jTPCv9FJqPjwqi9pLuDhmts4OFgSyRZN+RoMzrt/c+AuE18COgHe2yAA1LcFfBujKLYmPx6nxZt/tcExI0DOglBju9D6hFC/X8sUWswhN170jP3h+LE8fmKZvhOvbioiU0XRsfvqcJEyzgn1bPXMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqV9g9cSspDA9jVS5BR4CD5PoBJxloTTP6ij/L0SbII=;
 b=q6Ne4r39noWyea4+5GLawQL/dxctJy49yiIV23zdpXbht6NGFMiSjMfY5cIDQn4nqCxWaj5K4l+I81lwQHTcKmug9usZ3+Axbonr3dhiNZuDHNNWRYBdnSK92zXtFLS0MUB5Kg6r4Ml8+lHnZcQ5aPZzo2KiqK8BruXKG25/gHurAtqN2iMnub4qjT3O3fiLnbot+XDFT17JpB7MNxtnlckD0wdD/i9zEuca3MvssH9duWCh0zGqBbQKxaJUMvoewBtcADcNuaoM9Uye+igJLpdm3Co1djjuCgmWliSc92U4TOaJBY6ua76ZEKZ9d9jPHrYpweoKaESUx849R8aU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqV9g9cSspDA9jVS5BR4CD5PoBJxloTTP6ij/L0SbII=;
 b=JrCQXvvRI8ZIUBet8J0vRpYfo28o5McJjKzO7Kz7to/iOKf2ksoFQ3CeCxQvQotMAFL/6X1piGl41mdQgMXf8kq7Q+Lm3gejPduQSCaakCt23BJLNJjqJCB5aOquJBDfKlk8/FhviV8wxjrxGWeviQBX3rdWXvgg/tbJcqN9cFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:54:57 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:54:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 4/9] lib/string.c: introduce memdup_nul() helper
Date: Tue, 21 Apr 2026 09:54:34 +0200
Message-ID: <20260421075439.16696-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f0e3e8-e423-4ed5-3972-08de9f7b47d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2XgnfOEBDv7cAOAcSzJkux3KvE7yHlG2t4kmKsG4F5ArzTXhj48YhCrXQSib/cj9zpaVjaNhFD18SPYITlhhiYxK+k+0yTY0XK7+hhURu7CQEjnFl93LLQAiNIcBtu3W+kpwrmyLFQqKvjhcxbFivV2zfOpvDpgq/ypp0dAx7B/u0pMa6VM18pvD1rjmSCi3PmzJmeD3PkwP8GRkSTcmEb6Wwyg9QAH/lGHjqtDl5D2tn226xcygxOJZCJrFetMX3V1sj18N5tMYdRp5sQM/0rmSxNqB9SID+L2K5aWzOdUBMOyWhHbTQymtF6eEMQ6yMKbyalPLfu8+TagjOkpso50aI/IZ4WYnwBvFI4/L/m0I5za+wWB/gUY66gLt60MAseWsik0V8q69y+PWDYIEpEksQJvSxyqaHTxWkzhtyG6NmfeW1FaiMgjQ+kEquiuRSbjPGRN2kZPEj2Doa3eamvVYDoadqjkxEapUOyErzwu/d5WXP3R3e3t5T72wNPMppls8Q4fLWjfObXH1JNV9ZuMMcpR/qRSB8VehwaFq9oUbwQmkDm6R6QUhZnaxE1+vlsKz/K6924HHauZUD6efwvTca8xHAiwBqUfxxg8HDUriG+Hs7hInx9yabcq35/Wc6Nm6mIl5u7rfTizQ2gI7Oshqxo48uDL6pIMZBSm9gYn9rWtKu0aq4dibODzkprv2VkwOcspe8Qz2aAs0MeupcqTZycHIw70rp1eB7FTyt17wzZrbR4tMtL2h7iUVhD4VrzpBAnTbLKzDj4guw+SgxkO2L5Nr626Zi2LhIRb9WPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UCHyACeOSJcgVMlSeXx2j4wtL9b6rigDOCUCIskh9ehhTY3iF8FFblpK8rwI?=
 =?us-ascii?Q?J7uhNv8aQQVqRf5YkWjdgJQhhFvdcYZqxfWew9TKW2ZT5DtyDOpkFFKjrezc?=
 =?us-ascii?Q?Js7497mqbnvevYSIP5Oi4p1IZN0n3YtriMRsUdNKYBSQkm7gCnAvA7nqKRZN?=
 =?us-ascii?Q?LYloDvt6CXMlxlHtuEL83WGxgUviFaxBcaxsA/+FkWzgv5Ynrj7vp6DgL/hS?=
 =?us-ascii?Q?x/ooTU8vkz66tb57upcbERvwwDXNQT9blnH3zXPeD62aseZ8QeSnvNePOFub?=
 =?us-ascii?Q?JHWq2wIyFoK6GqgAH2kkI7Gc+B9NXhSEmjzL69yx4gBlJSw02tfOdrmfLvKa?=
 =?us-ascii?Q?DXi/sUZVG2X1xiHQ7mo9d2hicWnBGl27APcNKHNyM8VgyhoWSTSq3qcnMtLU?=
 =?us-ascii?Q?dLcIuMINmchYJl+93fWv/iNYN57bh2H/vjicnB4lEw1W/AqEFdsF6a7JFT//?=
 =?us-ascii?Q?+dosLW5xPLak7cOrQ+kJA+5Bz4pNMr/CSHCMFpnPCrt+UxyfYouBJXuqvyGk?=
 =?us-ascii?Q?vjIBVIPnZTwC/zS2o5Cfr8CG85kNu8pHUkxsD7TeezJSfYu25/T+aXl9REFh?=
 =?us-ascii?Q?83TnI471BdBWL/QVu+Wrm5E/K3a9mRjSTAnaY7icJ4W908WPT3yaY9JNnSF/?=
 =?us-ascii?Q?E7jepPlH/63zynpPH1Wa4pmjpgpf8fn1Oc4AAm+pwP8pPBbeQDQ6FzHd9cfj?=
 =?us-ascii?Q?1ruexjbigbMaWCz4eQrx6bi7QFGcadcopmSIpYmuUNvareLbt9VjuHMtoR6r?=
 =?us-ascii?Q?1Qe73GNHTZDHHk14aCkhDkbX6e3OOVkchLyP+unNc0FpO4k1h8EgmNWrMfs1?=
 =?us-ascii?Q?bM/Q4ZdK/NGxgt+lmjTVvS5ZyIzYHVBQg7rWBZAByIhD/nKU0Gm9TJFSvmzm?=
 =?us-ascii?Q?YaVuMIebTfhqUgn+HPuAujb2HIWOjZ5Ve9TRfldgTh+HHymZSnqLkyHv5x1D?=
 =?us-ascii?Q?7YYWkVtdbn0HsyMmtkRwoGuxqqW60e1cFnByUYcF0gj/KI61RGfjgCdajLtd?=
 =?us-ascii?Q?pb0QX1jZGbTJaTEw8Ir+otQY4iuiPGZfcpK6D+yIr7GFdh7xjODcKenxTPEH?=
 =?us-ascii?Q?BUiXAePMM6yDpnJhPA83rFvei9Vpr/IsgSqi/MDqF8Pp0uTcJ7WzMoi3CtxX?=
 =?us-ascii?Q?p+QO5Qk1OUsg9/3sjlFlKHA3kmNNsvybviCzipK7cQrUfUEj4rDeN6+W8Y/0?=
 =?us-ascii?Q?DtcRO201vEVXA8cfieY3CTxWS19qQn30SepBsckC8yhsBE/935Of1dnDKnDq?=
 =?us-ascii?Q?H3D5x/pNRNwa6OONaHN9Pn0igbrxx6w3UNGRbzepHczHbvm8YhIwnXti88Q4?=
 =?us-ascii?Q?S1eQ3rXcjLR4VEJIzpZ/srmq99L+Fin/+ARvT6aAENhwdjEJWWvy3pBHhPb2?=
 =?us-ascii?Q?Tc1H1ivvEZwveBcR4T2zdvUzxJKgtdJ7u4lCLOAMxmYXCGS5E8yC6xD2rqx2?=
 =?us-ascii?Q?RHcTioCusO09Q9zc4AkLLHcz2oOwlTvspvVaAH48L5NrUVNLxCycSxQs4HaS?=
 =?us-ascii?Q?K5k1GzOool+q24YedURXnWldUDzgYlx05nWybzv269ClVleJ1UXtnz+16b9n?=
 =?us-ascii?Q?jHqO5Rdzcuiia1+lRFDHsXao4ZmmMfu1pmca39zIWK12+bkhQwYsZ9yrLgtG?=
 =?us-ascii?Q?MkHw+P2yiwlGzm2JQVDZXZOnuyCV7gykjUh4SDq5uf6SnWLQXpEkcZ2i0+pD?=
 =?us-ascii?Q?tzc1suxcvM7N3Y9NR2Rpm9pM9CHJicL8etIeEFaX1/XacjzDwTTefMxE6cmW?=
 =?us-ascii?Q?1MJpVEZydvz1xyim2Qx57NBvVcEacQM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f0e3e8-e423-4ed5-3972-08de9f7b47d6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:54:56.9545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRlDPRRH5Loyt+7BQc7i1a0s/IvhnzwIv3MtIFq+sJrAudGWCJkaVPAGHrn4+rCZxBWPGCzAgEC37Y/IWlxH9DOFTTyBLhcyHBpjR7SFLE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6233
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

This is completely analogous to the linux kernel's kmemdup_nul()
helper, apart from the lack of the gfp_t argument: Allocate a buffer
of size {len}+1, copy {len} bytes from the given buffer, and add a
final nul byte.

This pattern exists in a number of places, so this helper can reduce
some boilerplate code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/string.h | 13 +++++++++++++
 lib/string.c           | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index a28150fa578..b2e38ecf26e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -143,6 +143,19 @@ void *memchr_inv(const void *, int, size_t);
  */
 void *memdup(const void *src, size_t len);
 
+/**
+ * memdup_nul() - allocate a buffer and copy in the contents, appending a nul byte
+ *
+ * Note that this returns a valid pointer even if @len is 0
+ *
+ * @src: data to copy in
+ * @len: number of bytes to copy
+ * Return: allocated buffer with the copied contents and an extra nul byte,
+ *      or NULL if not enough memory is available
+ *
+ */
+void *memdup_nul(const void *src, size_t len);
+
 unsigned long ustrtoul(const char *cp, char **endp, unsigned int base);
 unsigned long long ustrtoull(const char *cp, char **endp, unsigned int base);
 
diff --git a/lib/string.c b/lib/string.c
index 2c1baa568b9..3923cce5561 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -343,6 +343,21 @@ size_t strcspn(const char *s, const char *reject)
 }
 #endif
 
+void *memdup_nul(const void *src, size_t len)
+{
+	char *dst;
+
+	if (len + 1 < len)
+		return NULL;
+
+	dst = malloc(len + 1);
+	if (!dst)
+		return NULL;
+
+	dst[len] = '\0';
+	return memcpy(dst, src, len);
+}
+
 char * strdup(const char *s)
 {
 	char *new;
-- 
2.53.0

