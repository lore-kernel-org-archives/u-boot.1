Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22372C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 22:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD84D606A6;
	Fri, 24 Jul 2026 22:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzrDBBdsYEFj; Fri, 24 Jul 2026 22:07:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C6EB60A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784930840;
	bh=/CQ5g965edqTpHYCizHlQxJWb4OyDnGoh8755CCdXHE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=WGxMG77yN03mwSioRLs4kY7qWmEErBDa1wUul8L2JhdT7noDBeL0UUbh0bIc/QZNr
	 P5Ehv/fs+zM6tpSBaOJ2SXIh2aIsxB580Sx4GdBVw7CpB2bHrNnVwI76EYlDCg+BCs
	 3BmFXKlEQDbIBUgLQzHBBEF1XCzDkbHQMXUMAcLuvQ3AZ7Ju8BKp1Q9sQgfihSBF9n
	 yh4qTtzB7WpuViarVuU8i66Btq81OE6CXxSnnR93j6Rde+pVxncOLKHjwe0yMVF8bG
	 jt3gD5L8qkUdNKd0UFRKV5VbluFnIGhqMKWiAC5ecpgH6cTD5xIVHZ5YqEWFIRHsMa
	 gQUH0MZR0uvdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C6EB60A3D;
	Fri, 24 Jul 2026 22:07:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 494DFEB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 22:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A9BC8121D
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 22:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W7flfrLAuPWh for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 22:07:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4D70381219
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D70381219
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D70381219
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 22:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGFZx5zrmwfT2WESwb3dsr4rRWu/t2OllOniGokyxrahAd4ZMU1IgXn9vT+Kidd5RMp+NGyk0yEVGv58W5lXqKHJ1tVQheQKV7A9smmKuSKypdfwik9z2MEB/CvG5H/fJlh/0FcBLll1FOVkwuFo742+c5XTKkgsahm5Ht/97I3oe/9z35SlI22M4ao/EZehMJhH+rYWWwQM4qm+ff/MqDVZNX3CK2nhD9XaWW9Fny7q2rzOOT91cpcIPPGbf+LvoLQzEVOdgx74JbTNkCz81xNIkhp7URdKKWGzbeEHfOFjwR/LhRueFoe1GLbfQCU8DPcJ0Jp8mPEOzpnFhb0obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CQ5g965edqTpHYCizHlQxJWb4OyDnGoh8755CCdXHE=;
 b=fCfZL608oh7jlXAifUdCEu43o16LTx1tDcRfGhqr8SJeqreJjsn5XTGY4j6MQXQoXAPKd9g9+6H7k+J87wPHfT0e8s8lfeaAnD44I7HYVpfnSb0Ow+Gm6pPPuvSyR1CIcSDBGLtJbQvl39AdlaaMLbEL/aOVLfaHKJYkw5elEaotMfoGV33htUU9mjIT6sGVSB3wvDPYtn9KCx3hbgBWR2tnZYqDBXIWPdc6rVZ8QabOIOi/ImBsU/+KMHcmuTq1qlxH8q417ZyRWqc8JwAFxIvs8TLdkkv86khViJDYc25iM3mLEqzttXkYPpeDx3K/QnosvMYceukwera8AOymrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GVXPR10MB8508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 22:07:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 22:07:08 +0000
To: u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] bootretry: only reinitialize retry_time when bootretry env
 variable has been touched
Date: Sat, 25 Jul 2026 00:07:04 +0200
Message-ID: <20260724220704.232438-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0004F090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::629) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GVXPR10MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7218b7-e040-43a0-52c4-08dee9cfe70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|11063799006|5023799004|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Cx6Jz7QQJS3Ot26Kl2OG0imPjT+og1Mm4KHOjJ0uf2dEFzU1iZwNIWSq6C9jQfietJ0WTxkT/H5ts7b/e2XY2SbdWmOovBe1CxQ1wf95heJije+DGQlapYVWdb3mhtRXaGvtJFaFcDpfP2FYjoaO2dms/zyKLXsgdqdX+l2PjUNZ2VmIfMnNnXuGaYo0BkQBxDZnNeQdVkgmeILh28WPSH43BWm4cYfNslBuReb6iafHThvpYDz5Q2Uw9w/KD/Ghsp/3dZo0FGKdLDAmbKdaEun8OvjP13cXU+QNVT6NXyKLo8ZPs9bWq23T60ETg8ExJLbIAzZsrFauINWE4mcChdJqX0MspTeg72/ThZrkrtZ9w0bmsvIMyS+N18kAbVGd+2Tz4DgVkZze+RFDc+Ihy5pPil+ksf+k9LlsD+PRLXG9UNCoDuyFnpfwUf9zv0MWSfynWC1pVMXnzzik6mKsz2k1K2JK4rhrsHOOnYC1HJqaj1jH4bwCXGmvRNiZ3S2bfxTkvHN4aHuqyMOxrtHL/Slo2Ei+W2YziY5iZU0wDNu54OJVaKGaAeAEk6IoS8/+C6JAA6u53LaGD7TuQIT9vHhc0B/iuf1RJLYBXNiwi0KPjj8ER8241L59d+kmSIV9AsncaWk1FlYJeAtBWdtekrThV2+xRegLWz/gn2ohB58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLE495oJO+d1xB8jmxPGYVLjqfYXSx5bd++qm48HPePNAyNN5WycIlvVKP7v?=
 =?us-ascii?Q?w2coWugVRXW2Xe8bkz5/cXlJKIv3o14ikY3aCceDLz98zAXwsfCY1ucceP0X?=
 =?us-ascii?Q?nbJlCPgRurV5fk4kw3jDfEJHSS6dZQP7li+qUFgb1BZ9J3aKsEtouwCNgcMc?=
 =?us-ascii?Q?vY/tpSPjjd99Qro97qZ2A49VRAZ6uHHhwM1BiY9TJNR6IZ844qYCpIfsdqFb?=
 =?us-ascii?Q?aXzQQQt54ReO+IanwA0BMFMG4opY2gEE0BvTkm2MDIADQlPymmB9eU5en85Y?=
 =?us-ascii?Q?0GGvtm0qlFPweIygpSCqtSx9uw//1nJfcj3P3xCaFlE6ST5M9klUSM1LelTH?=
 =?us-ascii?Q?Rmaht3WHFIzHbw5Fq1bkGEvul1mvT00U+5NiOseefJxVviQzUqYr4v2qT7uN?=
 =?us-ascii?Q?djuOtsZ9fHBAWae/GDFmjGE755DQhe+yo2TIN5l3PCRR3PxBDy9fGf3IxYsZ?=
 =?us-ascii?Q?ZrinSfVsDnYajm17+FptAslrr0wPAtzERcvb/WAbQaJdeuZ1i53f6Clihldu?=
 =?us-ascii?Q?nkC/Rg9Yji5pc1Vz+kjytTQsdkaDjKkozsrlc8QGXEhW9z13CtxJsxk7oPPI?=
 =?us-ascii?Q?8LlNYU9vOQFId3Rl7PR/v436wsQh+Pi0ZVM/VPnLQ+S8+1bAI8NvX2aMEqKF?=
 =?us-ascii?Q?+RUQZ6BWe8p2L1ag6lpiJHQo3OLnk3JxRMUvNRQ76aF32WLwJBMyOYcxVGAc?=
 =?us-ascii?Q?fNgs0sckRkJfZndzwRPgq6QHV4OgVec0WA/lghug3OXnIYAU759lFa/gF1sf?=
 =?us-ascii?Q?6W42qdzP6Nc3yGtN8JGD9Ogn/g1iDauoXp+ZWcC0S/0wK0dvlZ7FO0VCvUTk?=
 =?us-ascii?Q?ebwi+cyaoCCPUkV2ws2b35yXIGwqlp+VpRBX973s3F6rXNQsIeY3aMw23+Ul?=
 =?us-ascii?Q?tnapKe+QllPcgY18GPA2kcdsR4ugRB/LvuMHJiLWrXIVsFcLLnFBOeE6vZ2U?=
 =?us-ascii?Q?sSdcJxxZyY5Dk6zy2ruRgwuYnsKT95/x3oOABkepZ9NmGa76JqXIKfut96Ce?=
 =?us-ascii?Q?7x5Y2Tl+VJDRVdd43/27xiDFB5Ta7UcRSN6hU5/6O6ikX1E5BsgP3qT1cwW4?=
 =?us-ascii?Q?RrH90gQZHMLipYZm0jWczR73KQU6m1Fz5UAHb+E0oLru77fsrdXyzC2UPNE+?=
 =?us-ascii?Q?D8S76fkc+tdKPqbdgIgrlx+gdYLK61ZDHsyDRS2TB47cx5WLUctG41AqSEWm?=
 =?us-ascii?Q?LlA2bhQPr17Q9cJRPLeolZNII//HCm9JDMefkqIVHx15tAWURm0Wq50w+brd?=
 =?us-ascii?Q?2v8RHVmV3luGDB+y2Dn1N43C7jeTL6c5op+/MkyM+jPBDYpnKTLAwcbwu443?=
 =?us-ascii?Q?LQiBfQibIbRwCWkP6YruhBtGurjXpkdph6tfsUn5LkxOveoC1GOM3KFO2EOz?=
 =?us-ascii?Q?2cOF24F3OoGoMylnOIsxXRHz/UUgyEGasWvTrpZducHxLGBvbN1esoWJnMkm?=
 =?us-ascii?Q?6wfmmXGf1KAE88A3EgSI0G31ePW5icIlz5wmvqa2tHFTIwH+p9HYRU+j/s9J?=
 =?us-ascii?Q?I3TF9fRFUropxD7/tRJhfPUZbCEq9Aeh/tz+ASPBC01ulyif9BY9FacYKax3?=
 =?us-ascii?Q?PRuIk1KOKcNEVHYQUd+k58PajyEOnnHZ1nUWn/CWqG15eqj0wsDfYmkodmk+?=
 =?us-ascii?Q?hoLv3T/zgR69jhTBXucHok1zatpI5iZFVl2w5NVPLk2FT9RNonITO2TD5aA8?=
 =?us-ascii?Q?ISX85VqJ0Rb+QRr6dUkG79QJhQnDa/bHap9RGT2f8oA4erizYj3r6elZ/fpk?=
 =?us-ascii?Q?aOV81JSHtN9l2bjDXuShEtORS6rkIrM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7218b7-e040-43a0-52c4-08dee9cfe70d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:07:07.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDFSC2pAHByN/sAR34NexmvgGXSQTHpJ3QuL2e00LhNaNSSRw45vSde4GKjR5CF91uI6kAIvmJqCtYUt2SSvgMhrqPmwelOg6oiiiQd6eWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8508
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CQ5g965edqTpHYCizHlQxJWb4OyDnGoh8755CCdXHE=;
 b=W6ldka61U955Scp1daiqneU0UJHpls+rXfidvyVtvWS6YAYaJNBkw8vh3zDQ2XX/q0BFXeLP6CeJgHzWYjTgMkfL9lVWi4XiXjinEC/gw+yjqnVekgm/sOrL4gA7/S1Ea00OsOaAY3ox+bLsFJRhwAQ1+2gbN7rPtOCrcFqx4+U=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=prevas.dk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=W6ldka61
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Rasmus Villemoes via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Rasmus Villemoes <ravi@prevas.dk>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Commit aa5ef3c0a75 ("bootretry: check for bootretry variable changes")
broke the feature where one can define different keys for "delaying"
versus "stopping" boot. The way the latter is implemented is by the code
in autoboot.c calling bootretry_dont_retry() when the stop sequence
has been detected, and that simply sets the retry_time variable in
bootretry.c to -1.

However, with the mentioned commit, that is unconditionally overridden
on every command, since it gets re-initialized from either the
bootretry environment variable or CONFIG_BOOT_RETRY_TIME, thus making
"delay" and "stop" effectively the same.

To fix that, while still picking up changes to the bootretry
environment variable, use the proper mechanism for C code to be
notified about changes to environment variables.

Since the callback is invoked before the change has actually been done
to the environment (callbacks can reject the change from taking
effect), we cannot simply call the existing
bootretry_init_cmd_timeout() from the callback, as its env_get() would
not see the new value. Instead, refactor most of it to an internal
bootretry_parse(), and call that with the new value (which is NULL in
the case bootretry is being deleted, so that works exactly as it
should).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 boot/bootretry.c       | 28 +++++++++++++++++++++++-----
 include/env_callback.h |  7 +++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/boot/bootretry.c b/boot/bootretry.c
index a60767eaa2e..52a253edd3e 100644
--- a/boot/bootretry.c
+++ b/boot/bootretry.c
@@ -8,6 +8,7 @@
 #include <bootretry.h>
 #include <cli.h>
 #include <env.h>
+#include <env_callback.h>
 #include <errno.h>
 #include <time.h>
 #include <vsprintf.h>
@@ -19,10 +20,9 @@ static int      retry_time = -1; /* -1 so can call readline before main_loop */
 /***************************************************************************
  * initialize command line timeout
  */
-void bootretry_init_cmd_timeout(void)
-{
-	char *s = env_get("bootretry");
 
+static void bootretry_parse(const char *s)
+{
 	if (s != NULL)
 		retry_time = (int)simple_strtol(s, NULL, 10);
 	else
@@ -32,13 +32,31 @@ void bootretry_init_cmd_timeout(void)
 		retry_time = CONFIG_BOOT_RETRY_MIN;
 }
 
+void bootretry_init_cmd_timeout(void)
+{
+	bootretry_parse(env_get("bootretry"));
+}
+
+/* Parse changes to bootretry */
+static int on_bootretry(const char *name, const char *value, enum env_op op,
+			int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+	case env_op_delete:
+		bootretry_parse(value);
+		break;
+	}
+	return 0;
+}
+U_BOOT_ENV_CALLBACK(bootretry, on_bootretry);
+
 /***************************************************************************
  * reset command line timeout to retry_time seconds
  */
 void bootretry_reset_cmd_timeout(void)
 {
-	/* Parse changes to bootretry */
-	bootretry_init_cmd_timeout();
 	endtime = endtick(retry_time);
 }
 
diff --git a/include/env_callback.h b/include/env_callback.h
index 1181ab4a157..572cacde03e 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -70,6 +70,12 @@
 #define DFU_CALLBACK
 #endif
 
+#ifdef CONFIG_BOOT_RETRY
+#define BOOTRETRY_CALLBACK "bootretry:bootretry,"
+#else
+#define BOOTRETRY_CALLBACK
+#endif
+
 /*
  * This list of callback bindings is static, but may be overridden by defining
  * a new association in the ".callbacks" environment variable.
@@ -81,6 +87,7 @@
 	NET6_CALLBACKS \
 	BOOTSTD_CALLBACK \
 	DFU_CALLBACK \
+	BOOTRETRY_CALLBACK \
 	"loadaddr:loadaddr," \
 	SILENT_CALLBACK \
 	"stdin:console,stdout:console,stderr:console," \
-- 
2.55.0

