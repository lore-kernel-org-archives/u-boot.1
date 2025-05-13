Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07635C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161BE8129F;
	Tue, 13 May 2025 10:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kDyvOC5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56D782998; Tue, 13 May 2025 10:40:45 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32ECB800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Awv1Fy2igYZeOF2DnRjZWJ/Ptyn9Oj3Xj+SkK9UbxkOmZctsR0xNPaSP27/ZqQZ2DFCSZocLfhT+4r4zYSiH8GZgpqr6mldvJCJFtQCrd8WU3SmwqptDhCum5Jvb1iyd5mA6Hp5FzBdf/LKAJrdT9YJFUjtNZTuwuEB5H5XAXBk82uYtsjninnVQd/SaEqKLWrPij9QUrT1VyePZ1kepnSX8HYuIROyWdsZxbD+vzQfESgWY9uGvvWvxdm0FDAqQ0k5fAWeDAa+wlR3jyTO52LzRYL+vcXVStYo7Pm4pzuq3mE8b4QeKtStE/nUpaRyHMeBYLmiXiGvGCkWClvONig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmpVmJMm1/M/rYSbobExHVJCSm/w75ItjeAza7riRyQ=;
 b=x/cuLXSS7NeMrVBmuILV9usN9Ji9oZsQ/aaF7WfuL8cbCAlSf5DbBKXDZh//sDS0+f2Br5LkQ1V+EmL69JNFmKUfkjZFEhYEgiKLnfvpcTRU0gQ66q5jKobZP2mVRBAFNuZqzsTN+cNr5v3eqM2R4EZAU+Z6aEUVkgy+oCYC3t9eMh4zu5l+OdRbUflLFADJgiIfSwEOQYzYHGVLMVSDvCEraWfRTw6GoLYnjvSDRJjD2QX3+DgKNqLc0iuarIm8MhyP2R5GPA0PnP70ldncHCn1u5qTo7xa096dJL0XtHqA501e1ZR32Qknn7Y0mmFyA/2WV61vFcdcw8f6YVSr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmpVmJMm1/M/rYSbobExHVJCSm/w75ItjeAza7riRyQ=;
 b=kDyvOC5z+9LcM7LRWQfvaQQQjg0HBg3rwHeaaD2BDsD1A1OxjXIDLYOTkelMSA03jQIbSJfynmULXbY4RsY1MK0EGolMaox/vXJoTMJEpZZgz72yIfqduLiKR0+cBN6BsGGwG2ddcbo57W7B7Ewpf5tOUo2ClnuMFDqSjDRPe/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 08:40:40 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:40 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 01/12] cmd: test: add support for =~ operator
Date: Tue, 13 May 2025 10:40:23 +0200
Message-ID: <20250513084034.654865-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 16adc627-2752-41b0-2ad6-08dd91f9d6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tPMVZmKcSr1GXCzvo6GAYH8Eo7ZQSPoEtdxcn2OSUEfFrzPbXPoUVMLMsOrv?=
 =?us-ascii?Q?r3D9f/z+Wrdt3URjkQjlYd62CXgJcmCvxtK4uotTdFg4zO9PnheRT/K7MPOU?=
 =?us-ascii?Q?6ND8p+Zd6aBPnnsRHxqgXHdJKbjCOaqMZuM/yWeSPmQLKcR0Wjr9NoqcuqCz?=
 =?us-ascii?Q?DE3yGhXZDh2GtqBBMa1ixofm6BhiqoKf20nqwbU5KqT+sxcMf0BeHUoU547R?=
 =?us-ascii?Q?sf/osJ5vkPo8k5g28P9t1vmOCRlCCR28GJAZrx80r/5iZ/U6UKTZWK0tkXK3?=
 =?us-ascii?Q?eTPgeyKOw5c9oRhjkf5jgePIjzzKq8q+PgxQU3kYd+qMGW9lgEZkhQv8hLdt?=
 =?us-ascii?Q?Y2F96WEkg6LptlcOZ6SK/1G3l7waMg/r16daZv6PJkzAW8yr034Xn/rz2ct1?=
 =?us-ascii?Q?q4yjtOfmv0yu5EaJh/foPDQwo2ekMbO/lu3jei0dytzvHy9/Bq7IWbkLKk3K?=
 =?us-ascii?Q?L09287LluKi+EA9mO7lg6WbtnumJ19nV5xoVbkKUUhEPweNLHLhTx9TmEOZt?=
 =?us-ascii?Q?W8K3JcVViht5T466+b14BC+cT0OBtQoeYtHWMECNJX8ROjwpU0+nzBo4s6V/?=
 =?us-ascii?Q?cnDRQM9oX4k5q6JT8+aYbGlKL8j/Nw2A9UYamWXIrSVIYCKwNWlk0+bj0uMp?=
 =?us-ascii?Q?5RoHmbkXCVxs3ykhSg0G4yBgp25YeVeBOieg0PgQCuokJqn+9dfx/y6yGw6J?=
 =?us-ascii?Q?ov2b3FHlii5pmgWmzKIqLQ68FG6PZ/TUeg8WAQhbAY4rgQNgYkLcqb87TDBw?=
 =?us-ascii?Q?lmX3Ipid2coosU+krWZMpi+OEj3EOBcKZupVem4eWstcRGLbB2By0RKK0dRe?=
 =?us-ascii?Q?jj8cIiEOWBDEd3LReUWj2xoJCkSwRr6vwaEQPJY4evfCV0ihyXI7y4ekGStT?=
 =?us-ascii?Q?e7Ybwz42LBmRpCujxnvow6M22obSWpkGp3V6uEjwUytxlbqhzd95pfNjr+CR?=
 =?us-ascii?Q?cmpvTaBH6PYvX+qQhvzWUyrNVUIRDHLgdwYMFU3Zzgcy1oPEeSm7erckSYqj?=
 =?us-ascii?Q?i3v4ZB2OSun7mBNdTtktGW3Mfv3SxnuqByI6fZcUU4EbqIqduJW+uprm4Qb4?=
 =?us-ascii?Q?PSufY64o5uRtr+7Os1mimE6VvQWrU7zBi0raREodjZswlYCI6Q6jReysrypF?=
 =?us-ascii?Q?NovLWJ9/Waw04IzubvAlcLoVlCcBQtsXppWdqYIVIRWD1pJKiWT5JLw7emZd?=
 =?us-ascii?Q?1tREu6BJYrVmD5sZ3fNNLMwNxW8AcGRIgXs1Pszo3FCko2Oqtx7LSmnDa9mF?=
 =?us-ascii?Q?5AUGoEWrVvSDcUfdx4C4X2S/dQr8zxMv16Nwf0ddO7GuuN+ZqBu1xI03dSDX?=
 =?us-ascii?Q?2uPxTiKt8DQYKdsi3BJ4n9eOLbd3A//6Jgrx58u75Rbfzp06kFawpQA+sd6g?=
 =?us-ascii?Q?e6rKaFSZH6y+mTmmmv2D+u4B53NPzo2feGK83q7rM1Y3JElZ4lKloPYTJb4z?=
 =?us-ascii?Q?zyvoms7dQHX521Az9titcXClBLDVlNPoeXhfYbo1N1S+lX3ZOXRVnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcLQWjZw3ogdbESLrJfwZExumzPyQTQ2giBI34yLv64415rMBnv3dB1j1+6j?=
 =?us-ascii?Q?+2n32eNZ7vJ3EtjeOygN7ynUYjj4CHjpq1xwCEXp24tx/SKKlI+ikDp+S7XT?=
 =?us-ascii?Q?4o31NbxUxauxEeahjo/mxMoKdqpRiNow47mOdm6RSHy+WSPAbhpmFrFIvPa1?=
 =?us-ascii?Q?CbXZ4AVSJkFny+7ykzzbJGSLnjw/WXwMXffyCUOnc5uaIzwJxMlUfyhhV9bn?=
 =?us-ascii?Q?YdDSfWWgIifPp4q6Z3h9yULdKtO2zKSMSTzwxa9P6M4QR7eemcztih2SQyeK?=
 =?us-ascii?Q?HShJFsRPDdn10oW8HqAjeHIdK0/BomWJJiHinQV3S9HPl2+0BPUZgpsOAE92?=
 =?us-ascii?Q?Pi50tEEAXcZ4+VpUoicYsvLmY1i4ZzrSaonZsSUeHaoMCO9wQ3o5EyWAsFPl?=
 =?us-ascii?Q?nLwLlX9my/gGgeo7R8HQCfNgKrPSAT7WE9+PtsvPVC9go6i0/25qF6M38CfB?=
 =?us-ascii?Q?8r4QlDDtkQZVslWrBFFxDgtB6nKd+AuzitfWYaehdXoJIqCf7vsN4BDv+dfx?=
 =?us-ascii?Q?ZFwMXH/rQ7bbTWl84krsHBBpqp7tpADQo6jbby1UhO6tJl+qP4vSB34G+k+c?=
 =?us-ascii?Q?q2Ey9BgBqkO6r/4fWRuYxOmIMUz13cIfexrsDiMTwowkEdsSX2Hk9bTlCuka?=
 =?us-ascii?Q?PcN2EqGEuVntHKx+MTkZVjuLAI6h1TkwjvAf+5yX7jjPAVEydgNRIvhDjQUE?=
 =?us-ascii?Q?lkrgVSnQ2Z57uPupZX5pVzxp10dWkNDIC1yeQyMcvkeeILuHBuZXlnFAprG8?=
 =?us-ascii?Q?mMHscLvPUfoj5t7uu0XZgPsLlOyF65K/bLeYmHI5DgSeZtZwl8GqcrdkAHYZ?=
 =?us-ascii?Q?3DBArK4o8d6WEgddPNTnKUGyY+rhcPcYgoQpVvpG32xqTJZGUJbmVLKMIPT1?=
 =?us-ascii?Q?OMUP2b6oXVSzH4oohgiDXJcVVfO+bR3sh9OQz5Xeiw3E6SqTew3w8iPvda/M?=
 =?us-ascii?Q?5uDo/rkontqcGpRFuWoFb2fVtDb0YkFv3r9IXcJx5EBTPs+wfc60SFxRD6Zo?=
 =?us-ascii?Q?RZJuhFfrHJ3hNH7yEXXSBZXBEs1nSJGhShKdhF3XgFmJD/hcKcT8angr6ETE?=
 =?us-ascii?Q?B7RtlhD2bSVs3u1uBMI0JTEII0qNIsZ9KeKOTKzufDSXCiGC62PFYqOxf93C?=
 =?us-ascii?Q?Myd53uis/3WD+x30yYQwzPz2a6LF4PXud50s2a+unWlpDBOYhyQBZcN9eyN4?=
 =?us-ascii?Q?ikyaw8C6shReqrIawpr1NCCa2zGG9RuzAw76x/UUC0Uvv/yfUT4dvLeG3SXO?=
 =?us-ascii?Q?ShpAjJMidWmRpkrl5H6C4SJdi9IaBG2fRIvNMR2U7OBsMr1d5MPp5or40RcI?=
 =?us-ascii?Q?nFOA70HflXo1XgGbYWeBqBVGwGKtGYkHBb1P1tz8RHQx4b7/MI6A4zJJ/7P/?=
 =?us-ascii?Q?3WXzNI4efngcuSYZeBMUoM3sAfZiFjYYNNC+/hHnAyxBRnBDfPx23p3m2EvF?=
 =?us-ascii?Q?eBDHGYlNs6m7hW9U+/Dlo5eXYf1Pz8tZZHKi9Vx70crkbiU+3sNJErnsOb15?=
 =?us-ascii?Q?u3vEgC1/IfzkmnZTBso3otO9NQfVlb0FbHupj0mrHFaQVo0Zsq+IoNK6Exr8?=
 =?us-ascii?Q?rrdDZi0AejkMCSYVDSn24O8jsQBpkleJUD5cpvARrLyY82PsFJiWyFZ8bBry?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 16adc627-2752-41b0-2ad6-08dd91f9d6a5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:39.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFyy5KBx0A0LnBdRpjGGlDhud72+/6rRLPfQ7BW5eqak4LZaSjPgcmFhX1eqhuwe9t7sSY9wRhUyfP6VXBDlciVJDDTd726G5r8Qo/6zX94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
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

Currently, the only way to make use of regex matching in the shell is
by using "setexpr [g]sub" command. That's rather awkward for asking
whether a string matches a regex. At the very least, it requires
providing setexpr with a dummy target variable, but also, the return
value of setexpr doesn't say whether any substitutions were done, so
one would have to do some roundabout thing like

  env set dummy "${string_to_test}"
  setexpr sub dummy '<some regex>' ''
  if test "${dummy}" != "${string_to_test}" ; then ...

When CONFIG_REGEX is set, teach the test command a new operator, =~,
which will allow one to more naturally write

  if test "${string_to_test}" =~ '<some regex>' ; then ...

The =~ operator with similar functionality is also supported in bash
when using its "extended" test operator [[ ]].

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/test.c b/cmd/test.c
index b4c3eabf9f6..a42a523d33d 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <fs.h>
 #include <log.h>
+#include <slre.h>
 #include <vsprintf.h>
 
 #define OP_INVALID	0
@@ -26,6 +27,7 @@
 #define OP_INT_GT	14
 #define OP_INT_GE	15
 #define OP_FILE_EXISTS	16
+#define OP_REGEX	17
 
 const struct {
 	int arg;
@@ -49,6 +51,9 @@ const struct {
 	{0, "-z", OP_STR_EMPTY, 2},
 	{0, "-n", OP_STR_NEMPTY, 2},
 	{0, "-e", OP_FILE_EXISTS, 4},
+#ifdef CONFIG_REGEX
+	{1, "=~", OP_REGEX, 3},
+#endif
 };
 
 static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -141,6 +146,20 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 		case OP_FILE_EXISTS:
 			expr = file_exists(ap[1], ap[2], ap[3], FS_TYPE_ANY);
 			break;
+#ifdef CONFIG_REGEX
+		case OP_REGEX: {
+			struct slre slre;
+
+			if (slre_compile(&slre, ap[2]) == 0) {
+				printf("Error compiling regex: %s\n", slre.err_str);
+				expr = 0;
+				break;
+			}
+
+			expr = slre_match(&slre, ap[0], strlen(ap[0]), NULL);
+			break;
+		}
+#endif
 		}
 
 		switch (op) {
-- 
2.49.0

