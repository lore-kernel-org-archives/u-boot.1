Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6183A106286D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BA083FD3;
	Wed, 11 Mar 2026 13:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="TRipbmzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5D083FE9; Wed, 11 Mar 2026 13:09:28 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0105283F53
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyoCV3LUG3lVmvid6hX0k2G64tIb5hKak0KdglcXdxZHh/og8XmGdk9PkoKXQaM7NS4PYnmnwKmAbRQzpsSwV53wrHGE+Y2sR0kxtweqrXsyyvVpZe/DTudhtp4sqJCQE1d2i/eO2H8XMyW6fm5RxcfOCOytbAe9rFL2hrrjEtPaKjvA/zXSryFj28L8APDzjLaMLPw1ecaGR4kmR0mTFy8cBrw1PLrV+FXYPTJomMa9BCY/CFTlLNVagPNAJPO6XJ2fYi+TphKSL7DpzkYmkVeq+T4wWZk9GR02nKoRjGAlkQzZWgpHypi7uwn+r45xWXPaun+RLpZDtsnrrfPBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU3T1I6zeOVnvU/BLdXM8e3LGHuaSaluSOJGBpLaKsU=;
 b=MTRL8qDo4gB9FKd14kyMxjQ7wcW+99qWFgaYha3xtHo6EZ0XIM7ZDTeYXOEvAT3MsBPZGFp+PHotOdA2mXTADiXlnGjrDpxnnaD136anroycOhFDyySH/ckNZ3m7HMPUF7I+dEhXhQnhS3Br8hMhiI9cE+Yk4EGgrgIN6r2sviFbo7GJsjQnxwz/LgeSJugKR252zxZ8ZG3o9EKDAtEFuaytc+CtDQBp2tpbqor0+rEL1mlnf0j+vwOnSmrl3+OlaLts7i3G1fxCFMlK3YXe1gS5FqfVic0MKGirp+NO5FJDnGSJyTTJlbO4Pn+egwaaRVbkHeMP+80KZegbVjtLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU3T1I6zeOVnvU/BLdXM8e3LGHuaSaluSOJGBpLaKsU=;
 b=TRipbmzsOYCrdHnG+7a+875u1MbwIyxEcpufg0vu0TO/SB/LFLXMyHfGbnunl8VmnbnLncXxVh4CMCI1cvTgabASB5dYO9U3aauQhdzG+WqnzSjbp6lpe4h5QV677s2LMYIgDhbTeO1wB1Bv8rTFAaTjwgUoyApnXdlrYk9S6yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:769::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:09:23 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:09:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] cmd: test: fix handling of single-argument form of test
Date: Wed, 11 Mar 2026 13:09:10 +0100
Message-ID: <20260311120910.3934114-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311120910.3934114-1-ravi@prevas.dk>
References: <20260311120910.3934114-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::10)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: c045e935-8308-411d-9119-08de7f670867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ngpBFNgPyofPwdEIsy7lwPWNpWgSgEkZKeM4+u1QWScMIRYqwkuWeE4PM7yfRQvfrr4dbg22dZtyCa8LoGCTOCzDkLWpFTXJnIYHLJAl0oer2mZZagUvV8pGhXkFXvViEasibnrHwJzJgU5x6jl7+hgsK/N8+TYE2+chKzFIXFtST/iU44tOtadotayYqwKAwQ1CoBvOeVH1yOxwteLdrTriL+KXwWrT1+9MSu5tABAOL6O0RiHqOiNy/2LmC9iO/PYYeoEiHb1eAQt/zZqftu9N+uD2QVXSxbyhP6ch8MW54JMphFcKhq0wJQdjJdFrTKS2obcwPEyCaAeXzXThiOcWrpUymuuStrPBfjQwgM9i8KwnP7zdCS1XRFn0LN4djK0vj9yfT75QM5GE2N3Wv1pLOo/Fv6YTEfiqdEV3gXiHaM0b2JCgLHxXQHTaPl2MblyHHImg0/xukW6EI1NJFschyzvv0peX0zDNbDfORoLn76L2jhNt+C5j1i6qMv3HzveUWlXikKvisKG8Y0W+YtN5ck6tSr16TUFHOets8sC8WBFto6YxvpcSANxoq5+RYrjFquB4SZlNqICbnivNhfgdFUxQeTATEPhr3BvWFvv2gte9JUzG7Yqt9eKOnAgDIFCQGyMTEHk4XBXLh0wQmRjlcBzbf/GONpjErpyLJnq9AyHbqfLMdCYgG9Qwf1Ls03cC3iFPBtr1c11zY8Gr+VuUigb/TLArqWdJVcybksxU4XQ0rPYQ2Ls/9pPmAB0en/qDdxMnBqy0T1pdilXOJA4qvehLOW5r8Sj73XSnbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Na5q5Yj7kSovtRr1d8wzsgd70ZIiVIvaHELI4pinNuEGASjsEH3KYiJ8hQv?=
 =?us-ascii?Q?ZUzfb6oSdJMRyvJWgM2xavLMRK0QuolLYgm4Me8goHBS2zPAXBqhelqD9Lbp?=
 =?us-ascii?Q?FC3qD8d5X8RZTNwWtXQ7bduM+13Q9y6XLpPxvMHL3EKD/luWCAlPIPO7mIcm?=
 =?us-ascii?Q?SGUQUBJzx9xWiFrECYYSLTqPcpQB+dWgHAcUzdZxznoKZswvTvamq/OmM0Lb?=
 =?us-ascii?Q?L863f/HN1QF1XD40SIO6SiYxeFrcpqqk4wGSGEmy6IJ3VP2RfPB9V3ZuF3mC?=
 =?us-ascii?Q?KXAVmhN7Og79VKbYZjqYoCDhXwMbyONqn4ZrWwLVHuxM4WFAKrJBtexgzmXX?=
 =?us-ascii?Q?bIcZtrWnhof5ZFkALzuDZhS8VopUo9EdczynmeFPhpzJf0QqNBK7lWvPPnZU?=
 =?us-ascii?Q?wMVoFnz9uoNF99wDSc+NMPbM6V10O6678qXv76s8FrsT0O7WqJA8ZsyWNVkh?=
 =?us-ascii?Q?mn4sI5aHOrejBN2NLlUUUEkBamQxfF1iE3/dvQ/65ZJMvYEBaxCjSCaDAsRd?=
 =?us-ascii?Q?0MYDvvf6q9disE2sIz7g/gYcrG+tBtO/1o6+7H9RvxpuMKCyCfynwx5rEWJd?=
 =?us-ascii?Q?T+kc3Cy8KRjyWiFfzsY+1v6an3r0TEQgwiBKh7pQJuQLRVT5mbCa4u7joPXe?=
 =?us-ascii?Q?903PSqB/tD6melyAI6k2Jd06Vb48S3KLCcDULeiNQOjO4aldP5gMJMDk0Dkm?=
 =?us-ascii?Q?Q8becN/I6abR1aPVc7jdHK7mVEz8G8kWFtrQ0KD87ER8Sjqa0b4gjPeCs+J0?=
 =?us-ascii?Q?ECCNUjyfbLrn+1bl1Q70rixgU/YwcPV+Ozlv8a02A4e/EdAFvu4CSWkXzHj/?=
 =?us-ascii?Q?2kWU7Ys1W4dQfHeRL7NrHJFKYknrWbcLZzR/XJhtukoExbR/tXr/Tub07bKI?=
 =?us-ascii?Q?9R8+mAi/PDs3ZYkXCmhafCRfyqyaXNIFMCPSdQXfn3NwrJV+Ih5zadcUMywL?=
 =?us-ascii?Q?iQSiVA/1GeaBQ7G3TpNSERIuWxqOE2ksJopRuL4gjE3Z5X0QZwqmG7sGLKfD?=
 =?us-ascii?Q?Nr87+5qD5dPBGNNtr0/Mlq3b+zgOMFVxXiS7JopRXn8luPMoz2StSwtS3SLK?=
 =?us-ascii?Q?c/XT2JkwG+0z9VxsdOv2WiKr40wlFNK9jGQMiimEf+IeNGKTeNfpMOZCrH/s?=
 =?us-ascii?Q?EtDGBJBX9lBhQtDLU2vOqMmYvQjglwr3clBTEDEsxpGZcOBuL/kmmR2kQvyw?=
 =?us-ascii?Q?ci5PRVh9zg77xKSdVA0qupbH/zk3rq3HT8w8bLiPwjfsjEfIMNm+ku+/nNwf?=
 =?us-ascii?Q?JnRdz6lJGEkcGLQkKuchTPyllVB1q3/xtLhOWdmhCKnU8uclBCF+4n7qElFY?=
 =?us-ascii?Q?zFlVpVUfFZog9LL9z++mHLKEMj7iEHZMFIT3YHLFaaVMWedQukoYSSuL7a9Z?=
 =?us-ascii?Q?8qZIPmOl66tvQ4dQatE5BWbs/IlC5dLR0d7ZwnInq+7BBCl5bWSX5154QiHj?=
 =?us-ascii?Q?QGVNyZxnH4sxvR9aa8IzjTzNOycaz6MnQQzQ5Dr+Gm7mv2NuAMC1Wkn8oWXW?=
 =?us-ascii?Q?wqdqqQWyb29wnllv3ivLcFkYxaPZpCoFTPF/hlgKI+CQKCB980wSAdV/anot?=
 =?us-ascii?Q?BABtZGG47mWyIva3JiCbosp4AtNlB38AYku3dmB008Vs48F6+RTAQM7dyvGI?=
 =?us-ascii?Q?nro88627w79SQrU5BBujiEym9wCz0YOD5uSAddbldCuDNTKhfNljLA2eBP78?=
 =?us-ascii?Q?4adsMoaklv2iAtT0+bb9GTILT3As1E2r/AWxbNduPeoUiWjrX2GpJ8/RyqXS?=
 =?us-ascii?Q?vcRRMLRCbmA0MHrlUAu6WGBbzugI/OI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c045e935-8308-411d-9119-08de7f670867
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:09:23.4351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b97vxQp0dY9BAOzAsYl1VzaVtgwohuK1n4P51TZRJbGs5tOFxGxX3au6YL29uGylIWBoEc2pUjOp2oLNN67y58Jihsivw9ttPTaBl/F3JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9706
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

POSIX states that

  0 arguments:
      Exit false (1).
  1 argument:
      Exit true (0) if $1 is not null; otherwise, exit false.

and at least bash and busybox sh behave that way.

The current 'argc < 3' does the right thing for a non-existing or
empty argv[1], but not for a non-empty argv[1]. Fix that and add
corresponding test cases.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c     | 11 +++++++++--
 test/hush/if.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/cmd/test.c b/cmd/test.c
index f0645ef98f1..0d0f090386c 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -71,10 +71,17 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 		argc--;
 	}
 
-	/* args? */
-	if (argc < 3)
+	/*
+	 * Per POSIX, 'test' with 0 arguments should return 1, while
+	 * 'test <arg>' should be equivalent to 'test -n <arg>',
+	 * i.e. true if and only if <arg> is not empty.
+	 */
+	if (argc < 2)
 		return 1;
 
+	if (argc == 2)
+		return !strcmp(argv[1], "");
+
 #ifdef DEBUG
 	{
 		debug("test(%d):", argc);
diff --git a/test/hush/if.c b/test/hush/if.c
index 148e9a53e90..e82a95aaf27 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -32,6 +32,15 @@ static int hush_test_if_base(struct unit_test_state *uts)
 	sprintf(if_formatted, if_format, "false");
 	ut_asserteq(1, run_command(if_formatted, 0));
 
+	sprintf(if_formatted, if_format, "test");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ''");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 'abc'");
+	ut_assertok(run_command(if_formatted, 0));
+
 	return 0;
 }
 HUSH_TEST(hush_test_if_base, 0);
@@ -343,6 +352,27 @@ static int hush_test_lbracket_alias(struct unit_test_state *uts)
 	ut_asserteq(1, run_command(if_formatted, 0));
 	ut_assert_nextline(missing_rbracket_error);
 
+	sprintf(if_formatted, if_format, "[ ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ '' ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ ''");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ 'abc' ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ 'abc'");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
 	return 0;
 }
 HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
-- 
2.53.0

