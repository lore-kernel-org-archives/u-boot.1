Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB7FED2F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C9384205;
	Thu, 12 Mar 2026 11:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="X7HBy7gT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED43841E2; Thu, 12 Mar 2026 11:01:20 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A452D841B9
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSB+qdmbL6bqvCS85ABXKOBW3wchwPGi8wN4wmBCIPeONKBhSLSUtRLfEz4j1oRfxxTBtIXdkRVZE1tjYFMQF/BwpPc/CRSc55bJUqs94rlmtTU3ptThfoGliAyQT3JJQ1Em9Vh59cHcSVEn/PAoEM/zfSDBCObW6kxXGfQGA1ImUWIOlUr4qQOSGJ91l0582e3rYkRZEqFX9dNMYZKmXeH52SFy0ET49bNzJvujkGhV7RAH2Rl/54TX2xquhKuBsK2SO1ofmdD/d8ar/VmGxwE/FkVP/HcWR8BL7mIQ6zHhC0BoeU93WDhjLW+vcxVRJH0FHwk/8oHwLSc3CNKf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EonnSOuB0H3757hBlzlGZ2v/wIGIMM5tZZTXvY62ye4=;
 b=WgyB8k4RXdmFfplKAZdv3BY+zejh0xz4aoxfw/9pjG4MjAhO65iDrBghUp0uXDdcicFqVKx9y3uT7BsIH/cW3ACXfOieIfDGZqtnIu4xHh/5gGiBX7wkK3BpN8OU/rCQxhkwNFeedtGOBdjE2z+t32ld9tcL6friOEGdKF4xwCjByMUy7yB3eHOuDQOcqQcmFhzPae9LqoAkas3qgyPCsEe5LW5ubG8F4SjXa2M1kxg8m5pc4QMIdoyLxgsgkt58uKYVVNxzmYeWNdL09kOXV3kL1HSD/CGF9laRy5dZ76Actu7NZlCXtNqCN2+a3y7PlEhAcMa48zRs1BKWE2nbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EonnSOuB0H3757hBlzlGZ2v/wIGIMM5tZZTXvY62ye4=;
 b=X7HBy7gTv0jCNXM4boHX3alIWVo6mjsMoVCQxvY4HKDSWRh0xQ62vY4dWOvq84xNntxdoQrt41Ed6/km2FG4FrGXmK4QUOh2O3VBIGXMOziNjrEEortXyy56L6yYicaa3duL22nRfQMdpxmk+9nr5GpJFEyp7BIUw3uSYzS3BJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:01:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:01:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/4] cmd: test: allow using [ as alias for test
Date: Thu, 12 Mar 2026 11:01:03 +0100
Message-ID: <20260312100106.702368-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
References: <20260312100106.702368-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0004.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 56eac917-a3a8-4e8c-1d1a-08de801e4aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kbMuMNmSccgfXn4v+5Hz+SvZHwaDBOmVdhlUpWmUoS5YIfyRyzsDZS9LteLV/i+hu4M5466C3GxklXq2gXVVdFgIaQLo8pxyHeaPTHl4rcD2MRVAoWUdZoCZ4SLlmA8l4j7DEqvfZKoZro2ugqRw768zSHHboaFA1022zt3dxvCgezneids6/O5jbhIDaiThqM8YydZm7+Je2lir6ufOrLKW+H7v3vWXq+TupEIcL07zqUninkFi22itSwO3poDDfSgKyLnH6j6RvWQ9vl2Xh7NKLMn/SVb52ERKSxqvX8Pun0zJZMuBmE0Fgp8rw8DqtcH+flh14BEycHOAlTZJD4uQxvuNKzXA7H11zyxflhZx4su23s7O0mLVpZ5XRpXU9ASh/WtjJyPWb1x92QjnMikkBFrOG839/vCADa5gs6KfJeSzTj5BpgAQPRIzCH52HBKu2K10nATnUftVAgYd+G6qqMMMnAY2jlPTpjPE0VSWmRVZ+XPeKlB3o3zJ9tW84ngRLGdOt9rtppTGBjfygeOW2SASIQnyJqs7CdWAeRi1jZUOp5nm1YiAkdD7P4ZQ9nOQv6G5aaJIGdVNLcXTJIWbaERB0QsOoRHQQAktDIxn9XCrGugw/xM/Hf/W21on13/YPNbrPvzmPQTsuE8x9N2xqc9R4D4QNlqEwYVA4Z01T8pQxlnemPoAbGiIMjLvz5jneeLAxHRn2NxkOMtPUU1iBiTlbKyoIbhoBEuJsRkBgSfkVJGk03uohCR1annpKoPu6D4cWjPa0391SkcTQp1B3liSA+7yH2WY525gLH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+R6U0t40U3uHlHxkuWoMHmCr8Ci64FFlyKN9QdUx5WbZbPYQI38bV9R6zKh?=
 =?us-ascii?Q?fzoXibV8UfKWWkkyk9z16m+21w//EPkiLsFULuzlZx4rN77hgcR7ePZ0AkrD?=
 =?us-ascii?Q?soX/ubSi/eYreK1LglcSj7k/GeCd6AdtpA8Vce00O/jyR5fLm7gGDZxYrXPA?=
 =?us-ascii?Q?dNKnAIj0KMsD/0OVCrozFXTVIAXGAPtzDHy+7Z3NlvmZ5AcaUnDAO7uLPH6K?=
 =?us-ascii?Q?55WmA+6AERPFNMLZWTW5bkVKaDHREbcHKyI28JWINJMegqXU2kYNh6gV4F40?=
 =?us-ascii?Q?3RmhS4KlJ1ao+b4rs5vRSgyAMluhd3Not6+Ca0zAqzcC/X27Zrj6SmNtJPjp?=
 =?us-ascii?Q?36exRgg7FTYA5ToS5ozXBWjXYnw4XxVJwV9NPHpzL4Egwaur4NOtEq7TLBEx?=
 =?us-ascii?Q?XllpXL1kEZy9/dctJY2HS/Eoyj7qj/uZxQVanPWCiJMCBFtEL4HgOBIRnnZy?=
 =?us-ascii?Q?gVVK4GjthKgr2UsPgfjR5BN2AHNCJ3ZKA/D5QUw6WSg8abky/fc8VZyqdKjj?=
 =?us-ascii?Q?5gND5+w6zLNDj6GrZN6/fA/52ywuO/5DuQs2aSD6NudrCN+Ke5P1f4pFv6r5?=
 =?us-ascii?Q?HUDqW7M1ytH4YoU84KMhu9U0vqn0NIwEiR+iA6n6DK9TGiwL98N60uWFL5Tq?=
 =?us-ascii?Q?IxPCXFx/TFMLW/AEFts2IEEYYK017duZsiAv9kxLFHdKgTSEiZQVidDqf7/3?=
 =?us-ascii?Q?P+ncUy8LOcFslqoAmj1KS/r0SXZJ4mZxMAjTHaLAyq6M9x6zjbXsQ5Y4ggQD?=
 =?us-ascii?Q?BHqMwOgCFhnMqeYR6S2TX+72i9q5l9igRcaJZKm8TQ/jvjMFBuQuR3O1jOCk?=
 =?us-ascii?Q?myMB5nfyKV+pbrgVILUqDX/OZXMR4CIZz04ieUd3/aYfEBIRHGB0rIp/v+aB?=
 =?us-ascii?Q?ieplQQhVYIrlFhfxc7BfaeVcWFy58wXk+48tCsBOG0NzJe3TYmO9kT92DQ4T?=
 =?us-ascii?Q?Fi3b85FkjeP1xZ+hfPk7Z+Tx7sx5hmoKDrjxuyXhyqiAn5tcXrd+GY63QM/P?=
 =?us-ascii?Q?MLZRyS7WNgYuvKiHRU07+GlHJ1XyNp7JPMkfMwPipWwk1IyNcUFA4q/SN42q?=
 =?us-ascii?Q?pNQukLQQg67hD4k2b7YfhhPW6OhLSKPNJEK+1Cn9rtF5D4krfnb7SKjdSOR6?=
 =?us-ascii?Q?apPJoOx3OJce1btt57A3Axk1TnwSa3i4wZ7c4d4Gyeo6TYfl/8qdM0zruqIc?=
 =?us-ascii?Q?eznJNnwCfs4hRUfpDRiEY2U6aL0KdrSof1K0Pe4W2CzjSjJPjB+XSAXrXZwb?=
 =?us-ascii?Q?hi2GUpS0yIQTrz9phO/MggKiL9p66IgHCOaSaa3J+heUZbH6bG9kYVlJeFnD?=
 =?us-ascii?Q?V4Oxweb5o9nZAC0QiYrGbYOmvv5U99dEQXODOLe0NR2p6A4XxGSIkwWHJGXi?=
 =?us-ascii?Q?nAWFoBhiMOxe3WZQRvBI1rgqrLpNXPJBYCIbRlKs7uO4WN/T4EU27uQ4ZY3O?=
 =?us-ascii?Q?ViFgsiyxfu5zT1DMUx14CCnX+xVrrivpd4TA9uwBMmo9vBPsWLCMVJAcDmRN?=
 =?us-ascii?Q?e4PzXmbnJaY993cy2jqf8+KfdOeR9m7AL0f6F3SBVXLKsJpWEztNiU9GxTs3?=
 =?us-ascii?Q?4vaTuP0n01k8mzmDzt2ywtRBu5p9C47lJ6Su9sQrnPW/IvP+f93gsXrcL3cb?=
 =?us-ascii?Q?W39i3UWrgcZIe93fFHfKPqAu/Jf0HIo9WnGz5X5qFuAPyNfhenqVsq5C+gDu?=
 =?us-ascii?Q?9nRPScAj1oSpPFnqp/kvcYFt3PyN1BjR3/wIj5xTQzycERYrdXNHuCt1xgBe?=
 =?us-ascii?Q?zYrfAQrFaOZPDLSJNK5Z5kqA7RsI1Io=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eac917-a3a8-4e8c-1d1a-08de801e4aed
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:01:12.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkUT+XbzNieiuTz5AqDfkjXw9Dyqy/XDMZjIUaWQ//kW1dMlDle70erLxAAk2AYaTBXU4jzyNfo6kPmbbV5wFJoBh/ccSchK+nMuV26tUhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6694
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

I often find myself writing something like

  if [ "$somevar" = 123 ] ; then ...

only to realize that that syntax doesn't work in U-Boot shell, and
must be spelled

  if test "$somevar" = 123 ; then

It only takes a few lines of code to support this POSIX-standardized
alias for test, and helps developers focus on their actual problems
instead of dealing with such unexpected quirks of the shell.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/test.c b/cmd/test.c
index a9ac07e6143..f0645ef98f1 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -63,6 +63,14 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 	char * const *ap;
 	int i, op, left, adv, expr, last_expr, last_unop, last_binop;
 
+	if (!strcmp(argv[0], "[")) {
+		if (strcmp(argv[argc - 1], "]")) {
+			printf("[: missing terminating ]\n");
+			return 1;
+		}
+		argc--;
+	}
+
 	/* args? */
 	if (argc < 3)
 		return 1;
@@ -212,6 +220,17 @@ U_BOOT_CMD(
 	"[args..]"
 );
 
+/*
+ * This does not use the U_BOOT_CMD macro as [ can't be used in symbol names
+ */
+ll_entry_declare(struct cmd_tbl, lbracket, cmd) = {
+	"[",	CONFIG_SYS_MAXARGS, cmd_always_repeatable, do_test,
+	"alias for 'test'",
+#ifdef CONFIG_SYS_LONGHELP
+	" <test expression> ]"
+#endif /* CONFIG_SYS_LONGHELP */
+};
+
 static int do_false(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
 {
-- 
2.53.0

