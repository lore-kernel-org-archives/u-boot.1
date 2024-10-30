Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8320AD6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DF989289;
	Wed, 30 Oct 2024 22:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hjwtEeZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B2788F47; Wed, 30 Oct 2024 22:34:09 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2863489262
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNCptWZjDdGPisK4tO/PxPOJYyj9QygFSdr0XstGcNzxhwoA+MULtCGDXMaEcw7gW9fsYeEWuf70p6dR1hXgHGU3lq2QjIM9VHdizbjs2TKxCFvatPb9WkvsjYBN/uV2dQ4yq/sewldyKXnGI5PSEHFT77BQlHbYLyRDoll8pOvE9+HyyeZHc18H2RnZrjZUzhf6bU0R2KSk9ZS9R8Exq0Z/SKrNKfpANquX752DOe7WD+nIthfY3DkhYqwM9CBiEFzlyJSNyTaoGrNQTuChFNZTg/3TyYw9blQ7CPrMp9pjTS8RADxiCb6RJmOvtn6l5TFtbu5Kr/D6lMuCNcwJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0SW/mqCqOj2DtGJDGCJaxxc1J8VR56UIVH5tdw0sL4=;
 b=BBiq4Kf5nSKmYlbxCqBkvvU++3sLaEh/5l0Wfsl6xjPk1JG3NCMlnmYB8KS/L8AMhj/tYidWo00E1jQ69ZdIMEW8GMGfUAOmDixBoWnnJH8z0lEClYnZRk8tEkciSB76ihJPSlOLQylDJoMu1eu4RHotHr1427TeNeBLSu1MeSQqbyFa2dOnC1GgmQeiwdFITuQnpHyYl2LXr+Y6MBSZ8jGb+/l2AJGA2Cq1uppMNMU2it9pXIS6SxAmmiIL6W7CzdEyuHbYEuFuCm+/DHDue62Hiufx+wGvqm79L8leBT1fth96ivRPGZg7a3RNUkz2XvBCjYyGJIktNNT+zFNLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0SW/mqCqOj2DtGJDGCJaxxc1J8VR56UIVH5tdw0sL4=;
 b=hjwtEeZHSfo3fA1JXKa9tMOUq8R3s2XAtRzzq3U4FIT+MV4DeyhkvWiEtrSVq/sG6QtQKJxwNCejX1++XAH7BYWsMzXNtS0gUA5cYIANh6+B8/+2N4llEwdkizLpbL0+RTTYHACJKbeTD6JBFRvsbM1XrVvjzlYx6gcHXJCM9lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 21:34:06 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:34:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] test: env: add some test cases for new "env default -k"
 flag
Date: Wed, 30 Oct 2024 22:34:04 +0100
Message-ID: <20241030213404.2894247-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030213404.2894247-1-ravi@prevas.dk>
References: <20241030213404.2894247-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0107.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::10) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3201:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bb8c60-646f-4b4d-8470-08dcf92a94e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1jGE1iih/kbgxLxPX5mcqxwM2jSdej6bZM/Yloi/x5FdvZNtLtRpoSdrTMQ?=
 =?us-ascii?Q?122LXPtaebXEKcwUdZRizALF3mVDLyk3mEntdEcd2Bvkyvbiomeb+4L7SKVa?=
 =?us-ascii?Q?2xv2O/LQJCjg3hRPW4/vvzsdceybX+3kgNGcdFY1BNoQv7bzewB/HxIhvc0y?=
 =?us-ascii?Q?kUf0tFXnIMr66Eb0usYFHllCfrOa1lp2n5eGfwcx0bNW91ibRXBNHsPerPlh?=
 =?us-ascii?Q?Jbbar5vU/Y4UQhQPIo/x00oJTx5FO3LPBORFJ4px94hRToa+BAvXQ8eQOCRG?=
 =?us-ascii?Q?Xjnibq8aMOItvw7Af6NCaxGCeRlv+59j3gvDU9k3O5nhjZ6JzVJkEAJeLxju?=
 =?us-ascii?Q?v3aFcbcLAGGctUKAF01YZzlCFwmKBJ8IB/hPGinQLgR9jjn/8Pjrn1P6k4ak?=
 =?us-ascii?Q?72wI0yrSDvmxEkVOkojtGszkGFKvDE9d465T27O8kbg6PbWEjS5LopFUESNs?=
 =?us-ascii?Q?Pk3RFlyDctB1MMbANAsYDPlQ7f5lEIxTncfZUPkY+8+bNzhx/byF43aO2cFO?=
 =?us-ascii?Q?vU59BopqM6l/AWdE0d0QR4G/ed4nG8HjWLlLezIDj4Li0RWISw0ncA/rp/Gi?=
 =?us-ascii?Q?aZgvYVpKInehps1IRj1HWlPHt7oXh4ZD6UxQrTrQezFTpMw+pMnLkxn/JJl8?=
 =?us-ascii?Q?IPTGWzyuoxe0qYc3uK0AhMZLJwMX4qqrEDHZdNGqyqZRANM9OqYlSZVJWvMu?=
 =?us-ascii?Q?TJDhZBwrl2CXwyhDFNpAOp0OLdlA3VxxTOSvENHZfxNwDNk0xfWa/5itG0lH?=
 =?us-ascii?Q?WXnAP+ya+Bxg2TUZBKFVjgG8fybNei300rg12djPPJS4MWwNWW1oG4BBfATj?=
 =?us-ascii?Q?4TdY6xsfbqA1C0K5nlyPgXNEvibhs4mcETZwPnhL54kl5wi595jbrqYmyq/4?=
 =?us-ascii?Q?/W3MV4Cf+UZSQvGlhq+avttP6MWP0DT78XzirbITWA1kuXGTXQOnlDf4p1Cb?=
 =?us-ascii?Q?VOBZfJ+zGLOCsbJonfPfxu+Ot8aPxEyrLXwUPyl/pOtr7MCltdnV0Iarj4tz?=
 =?us-ascii?Q?5jjhqozKPm9Cs+pgnmxoHxXJ+cSEPvfLj+GBRTs1zyHAus4sv9DtyezKBK/n?=
 =?us-ascii?Q?ROFGyccIgQStoGsY3Hd0LRLV6EjVc6l8vsDZaXtzrzqX1LLTyYZrBm+2wpnR?=
 =?us-ascii?Q?TYFDubUPFramklLLz1nerFMN1ZV6sr3Gnul1TBRPXZR9GtRDV22UsgB3gBuw?=
 =?us-ascii?Q?6zaBM0oeGnTEuHMzRmsxFlqTxm0D91TAYs8nPlDH2N876/APjTlTqwQ/CP/v?=
 =?us-ascii?Q?h5X1OIwZ6Ko7VotzIzwtsLmhW9ARAx9MyoIYi2/bj74ORGbtZqpE8zhzYWbF?=
 =?us-ascii?Q?8r+SApD9JdPRJD8nxAuEr2+Qh+CRXKJD+lTfkSthmTSFq5r96AM0uCmNVKK7?=
 =?us-ascii?Q?zNM6rsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MYU8r4UukrqnmVyqdNvksSZDgx2Xn6tbyTP4Hl6CZGD+IYpKxAUAR6ZJRH/7?=
 =?us-ascii?Q?Ib/YQAaWgSddqT8C6vUTlk2h/BTjpIPvWp/ZVTwf/qD92hwEOwhoE4TYYQgT?=
 =?us-ascii?Q?1Ft6WDl4HkR428YLqjC6DfBmJyGpEr4E9gmLgxyFJqfL+Wo7wQybWdu+fcLO?=
 =?us-ascii?Q?klMDnClTXwOX/5IME8Ain/8t472Mnu8lZlYTxBzaRyolDCIc6MqKWKrIcrHt?=
 =?us-ascii?Q?ZWkEib6Gt10zYSC3XTIUSsNHKH0za1TaeZJF9gdnV4CbJENzSUWODk8JcAUl?=
 =?us-ascii?Q?rosmI8nYLmmvEjuNeF90wtBm6NMBVX0WRcW8ra2LieUaxktI05LgdCa4UrKn?=
 =?us-ascii?Q?WRqzDZ2rT/f0YW4FoL+Bai6dKFZn6ayQSLZNygQQ/tI7epYM0KU/9ywQxqrP?=
 =?us-ascii?Q?+AciqeVFeJh3n2Ywxd8cuXydzt1US2p/zVWlpMkqycXt6NaVXHlQVrfc91Gr?=
 =?us-ascii?Q?WqlbQqLENmkOJgfzjwnHOmFVjXig5eWQ7xAO6flPcOH9CraFKwiHKrDzynEj?=
 =?us-ascii?Q?Gt4HDl0E4olUXIZh96jNz4hc3iaIEZfgfR8mCmN6uE7JJYv5D+dT8h58+s70?=
 =?us-ascii?Q?nN70E+7Do/RAttPhLwuew4b3WsFxhITBpxBSHFnprKS2eVAArRWSzV5AwqRC?=
 =?us-ascii?Q?KgVFBi7a5UxbtRjlcWqBqrFobj+FUSlzY1PBpMBBwvO+UVTykLLTy6iA91AJ?=
 =?us-ascii?Q?pgh1PiGOrvPhV087waZB1xveMqmy9IOaJXCaA+MnfcQ9gCQu1ZWNj5ssmWEY?=
 =?us-ascii?Q?El+0/ARqUQiqFQ89afcA9L51MlmNm13iXh7v6FyTwUxiMsi9xKkoS/ycyzLO?=
 =?us-ascii?Q?GFy94ye2cf3qWBDJHIbF1TAAXsNRXySjcXxum1kHuMBsg+CfzyW9PslnL/Bf?=
 =?us-ascii?Q?gx+YqT6r1rXv8IopJhxSXMKeQGOYo7Fcju0rvGFehSRjfdAUCfhc2TZlnMPp?=
 =?us-ascii?Q?1mXYjSXmVI/uBycwK/UNWDqLhdJGXuYqxoI7xFIV0EPbscpPFD6pGEhM3JrE?=
 =?us-ascii?Q?Knad+ATTCG531e/cahSX4xQvCv3nUZoIDoRitJl5EcBH4nPwWmhkmqRmuEi+?=
 =?us-ascii?Q?mjFl3uAevp+T98h/ff8gZnDLMXqWMkLlychLtzIPHVzqUVUHVhIM4HH6KylV?=
 =?us-ascii?Q?7dyLfoE8INAsDZ+XLH/WdkEEpZiDYv2UEtMgA3NinWEXXinWOv/Xndrqh6rv?=
 =?us-ascii?Q?CO9KTfJCh2XYQZp7mOsyO5EBFvf/A8vmGRkhLXgBAMt36SHjHwbdzsPLKirF?=
 =?us-ascii?Q?JnNfxh/3uLkn1cZE1eTgL1cViPQ4DOl7acCalUtZsIPbAcPM4r7sq2yEKHPP?=
 =?us-ascii?Q?SpU5LUbAATdOjQKW/1LbnVi3MZNs2c+9yuioq5/bb0vlD2UYi9LTdILLlwpJ?=
 =?us-ascii?Q?kbxQAMaF+w81bMksMIn/zILZd6z5R62myb7Oreao3O9O+iAtUQRiLC9UDym+?=
 =?us-ascii?Q?Mr5cqBg7tOu5umI3bFLb6+c4kBatK/wgf8eEaVkqVDSG3ZdUTkW19S0k74cM?=
 =?us-ascii?Q?ZQ3eOj1eDn3bZfh0Rx4NXGSAhbLtbBMI1uhNmqpl9KXs4MD/bII4ho/xdmqJ?=
 =?us-ascii?Q?Zt+uu8cm4zxH5jNHItgG8Tkri2j/qsygUR6qk8Ehqvb/na1jL3gHvgpJsqzG?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bb8c60-646f-4b4d-8470-08dcf92a94e9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:06.2825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45tFZRrDJsmUYwfLmQdPgC5sbtfdh3tFLrC5n4UQID2eKUAFewLpkxb48yBklDWPWLUbORSkmcrghXItVsI+rCCNowl/rty/oZuBI5oBb4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3201
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

Check that the new -k flag works as expected.

This also adds a test of the -a flag, which was previously missing,
and as the comment says, perhaps for a good reason. At least now we
have a test for it in combination with -k (and -f, because the ethaddr
variables otherwise cause complaining).

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/env/cmd_ut_env.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index e1dd1a14cb0..9f16a978f2a 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -31,6 +31,46 @@ static int env_test_env_cmd(struct unit_test_state *uts)
 	ut_asserteq(0, run_command("env exists non_default_var2", 0));
 	ut_assert_console_end();
 
+	ut_assertok(run_command("setenv non_default_var1 3", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("env default -k non_default_var1", 0));
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("env exists non_default_var1", 0));
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("env exists non_default_var2", 0));
+	ut_assert_console_end();
+
+	ut_assertok(run_command("env default -k -a -f", 0));
+	ut_assert_nextline("## Resetting to default environment");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("env exists non_default_var1", 0));
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("env exists non_default_var2", 0));
+	ut_assert_console_end();
+
+	/*
+	 * While the following test of "env default -a" by itself
+	 * works, it unfortunately causes an unrelated test case,
+	 * env_test_fdt_import(), to fail, because the "from_fdt"
+	 * variable would be removed.
+	 */
+#if 0
+	ut_assertok(run_command("env default -a", 0));
+	ut_assert_nextline("## Resetting to default environment");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("env exists non_default_var1", 0));
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("env exists non_default_var2", 0));
+	ut_assert_console_end();
+#endif
+
 	return 0;
 }
 ENV_TEST(env_test_env_cmd, UTF_CONSOLE);
-- 
2.47.0

