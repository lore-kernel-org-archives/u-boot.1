Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12947FED2F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8550841F2;
	Thu, 12 Mar 2026 11:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="LBOhgdYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAEF84212; Thu, 12 Mar 2026 11:01:26 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED61841F2
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWTSdxc+GDZbu8+fG7FT694kF7zTJykFHMkkrsZYcQT1xIlqkQldMEaO7/XEGds2DxziDZb6QfgkV7sjhAKeh37eo4CL3pwxUXi4MQsCz1MBo15TgfJorAmi4pBKtK59SEfaulhjkr5VZFV+t+MxvMu1U0frylrZc1PyTfBnaVeV0Jj4lP7Idgwes3/+wU3G/py4yJtaTnBK00VLxLxJNXYMTd66i8qw+KR8J9UaDeoffQ+uljrYN5XAXSHpqCKjyrUv4l52XM/s8SRweHTtQ2gLpi7py41AhOzIYkN4uRv8VN+fZwmDZGCoBRExvLyWJhYLH+63hhgRFK7eew4IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VPnwyoo4s0/jA+Kmlqc4y7w/qT4dAL12O2RB3Av/cA=;
 b=of143Ba6vHyxalhbACTAsCvxnfCv7sS7PkWjJ/krHgcmi7Q60LM/1DCaoYqTFcsynwVx8Sok3x94v+J7XD3/FdMZT66KvC7F/J/Q8f7qAa9DngK3bfgKPRwm6h3e53WbLaR0DJp8cUdugdV35Ix37sccVEZ+bGsQs2Tyn18yeWPthDJ6t3v3V9dStwlkzo+/sE5gvMLTD0fGYLX4qNMBMaL5iQH+A0ylcRo5kfw0difKQidcUeMATB6WBulwpoAnRf2Zn5scZeKPK4snHsvpKo26MaI7+29KYdb9VhkcJS6Tw4m5IS0Do2fpGgBkvVLry3XNqKTjdhBqXeBqAvEiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VPnwyoo4s0/jA+Kmlqc4y7w/qT4dAL12O2RB3Av/cA=;
 b=LBOhgdYrswNCCnaw22mNpNjH1RDCkL+RkIngzDJ3hBkfrjEC897MpilYptlBwgtJ0VpzrM3giwS+9Eu2QolLnOlti50HN4WhjUecO8SHRvduMkBFAJhxFg/CXcBcB6UneZc39Rx7jUL22gmxywngnvBTi+ybJtrREM3kwePhK+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:01:20 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:01:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/4] test: add tests for left-bracket alias for 'test'
 command
Date: Thu, 12 Mar 2026 11:01:05 +0100
Message-ID: <20260312100106.702368-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
References: <20260312100106.702368-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 72375c54-0267-43dc-7725-08de801e4f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6H4g4cpNSdN/8B5HPT82GMcHWMM6NVzjrzsJqt96pcv4AVr+ZTvU26GB4dBhfQW294woF+CNvjyA6w9GZIlB7b55SESBfp+noGgl4TNMvl+sypYs49ExMgRBsyTNjSI93zPWZNVT+C5UNlMOfO5jHcPDCzk8MdUSc/fha2hyq4A/M1sU6Bpllam0/IPSqLwmQGzc0DnkWJB6aLDgswKmDjtq9N5fIIKHRgjBrU9qBmSO0+s4FsPvQE/jWPcVxEg6GrEc4OaCvlH0RpHlMGrvHaQDN6m5SOQjjf/h1TGnhSkjWDx54UrRii1yA3GIq5hpCBT7xodLk+dUQq7ZUXpUXWZDD6smTUJOkovkAbmGVqOFo1RmZHbDUigScZLspyMa83eeeK+xIJiSQL5nnfUv2maMBDFD55C0/tvH1evIjRGglRcArkpojM7oU0kiF7/Cub0s5mvZDivmvIBMz9ZUfk9lB3ACZkPUWcRzFkA/G9IggkVMNIm7jqbr2IkKvFP3Oxs4qVH1aIK7PI17zI5PAsenHjSEufygKSQlSVAp7192E7dtQnOcY+mtmvAIqpjbUTl/EWlD0g/K2EmhAcDKmVjbqPShux1xZbEeizKOv+Gn/zKoiiDI/SXvkBeukCJDfkG/YDzVCJSkNMLKa2628darZIfOrKiShBq8I35m6I5NhUmR7m2cioXMBjN0QT3kbawpGq9W8a1sxC0GTr5Y0wuuF1mAmrKSc9VbItQIhjP1lABGy/ORjGJy/G/sS4zBTfmyz7ZSILGI6OkQH9kw2WCt2LB1uObeadzcsxAwSS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tFyTDsT/bEcOBZ50h+fL+Bs8/FqFAOMdzQ0RoerHCBQpJ5OFM//qc7btD7qp?=
 =?us-ascii?Q?a2ZfOdwW/6jZlXFs/wXYzTCHBFmKDNyCxnE+F0J1JRhgqRPrqfdQXL3zZPi0?=
 =?us-ascii?Q?Mr/4M+J1pb/nUYjGJv43bv1DmQQJVotf2ocOW/BhCqskrlaUw27TVRXHTlC8?=
 =?us-ascii?Q?pz69cCivxrXTe07QE5M5dvRt9fofJ4YOjCyoVTxvZm2NrBgILoCsIPfFUhR7?=
 =?us-ascii?Q?ZAMp2f9P+NJsJsl6hRMp8sgELfqt6UCVqkCpxB39KLOHb7M/was/MklD3Vuq?=
 =?us-ascii?Q?0pJb9Q0o6SK8nAgFfnKBVsC+kERdaVv/jYKQw4qAygMmrNfs+LBZAD5XpOc0?=
 =?us-ascii?Q?MgXWnBb9ca8qdcVmwcjgYFGmDhzSKCHOquJjOJXgWHjyshGkf8F4BRvFdNdh?=
 =?us-ascii?Q?fHGdLWnbs9yI8HhOeqOwBvGYQ0Yvy2qBISyVKfKIbVyf6VFkB6tXWiB8zndn?=
 =?us-ascii?Q?tResjNqU1qoqcoyotdBnaQ6GbIJY8Nv0SJrbX4zSb4mqjJqFAWq0J3kHPC92?=
 =?us-ascii?Q?8XR8PfUCo6m0ruq7I+oZRRkpW5EkWB4h9jvuP2Gv2g/sRgONr/6zrAaYhv1D?=
 =?us-ascii?Q?rxUhxMwUqwU6N4aNYwgLZuOcOqsJJI0j93iU+h90aS0yqJtSLcmzD7hTMbUM?=
 =?us-ascii?Q?9GBSULyjPd3mR7oFCrffhYYFhRXIgvo5wvHptyWDmFFIV89QdRjmIUgrrTbW?=
 =?us-ascii?Q?PkvcgTZazWFEFMbVqGTYR02aRWCVuB6K3OCHQDHaBico2NBZJ+0S77vAyzxd?=
 =?us-ascii?Q?m8GMBjzgkX4vCQai8xBD3TV4iUvkI7YMrYY9R0ByilmyQCpMn/MyOaPp+KdW?=
 =?us-ascii?Q?82/K2msqdAyWT/2JsRamzHUK2NMk1EkbcnYMmvR3p3XzbnZ66lRuzTQQERNn?=
 =?us-ascii?Q?Kvee7bfeZyTmDauSWTqS2BqCkAJ8V45ZNKCk82YmlqUjer4s0l88Q3vS08D9?=
 =?us-ascii?Q?ms7QYu4gtxDONj2Z4rECluHUp+1u+/ekQkzl3eYBkOT3Nh1vhhoUWWWo5CK2?=
 =?us-ascii?Q?hxINd+ACK+m4jcmCBOQFf7XX9dG/GrfzJcONGhpxKvYUJnEwZCV5iNFVs5n9?=
 =?us-ascii?Q?WlQr1N4tL7c9oMibGm2v48xKputytA9+g8fV+b021WrE4Hm51FXpAx9idzSb?=
 =?us-ascii?Q?9EitZvvLFAnISVedf2LC7CWbklFekFCqMgx6sCWJi8hqQ/YRXB6kOcfDSg9R?=
 =?us-ascii?Q?Vdmdhao+4iNqfRNM9jewT84EcM415GlMtc33fmz8bcQa7Adozz+fQke+VHuT?=
 =?us-ascii?Q?qGXo3Lzy7Mf5uEi11W9x6wI9sPR6X4YDg0R4yhM4xKu/ADIkbXO+aJmgGEze?=
 =?us-ascii?Q?doVn8NCHWsOYruBa+T7r734PMr1EpN6CGjIuRcczn4aAA8mqXOg1avgsoPQ0?=
 =?us-ascii?Q?OAY0OxsVCpdxDJfywGHEeTuyc7uPpo4XlM+mUiGXCmpyprahTMK9rdz87/ya?=
 =?us-ascii?Q?VJG+GHgVIRztY6AyLKGr2w63CcmOTqcoyDtOEa6czPFvCUlc3N5A8trUJf6k?=
 =?us-ascii?Q?I1WOL+yAtoPWGO+xuh06ivFGZfh7nD7gdfDQ5+mTEScMC9EQlDIwxcnoohZz?=
 =?us-ascii?Q?hifivcQXulKq+qzyJJIllZvSoMWhFi/Q4zNdep3d31KCVLzjNj370IhRerwO?=
 =?us-ascii?Q?8e07u/xsZ3dEw6jIGHTtFA6QbJ75jv/wre5drcQWZY5CFnqqlOxRiKdhOQMw?=
 =?us-ascii?Q?/u8e8gpHxVNynUy8I56H238lNtuDhbYUXZnGk19HGvUh0v1excYXEFyVv0QZ?=
 =?us-ascii?Q?unIAAW/jhhxZ/nd5nv0Fr8azSPY6mZU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 72375c54-0267-43dc-7725-08de801e4f83
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:01:20.5975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZJTqlI2YQEUjHGnEgeodLsb64tL98KPxmeBGHw5HsY1MLkIbg2zGDUxIriWxQFQhvD5QLL4PpzfUgO+WCRFhpN/cju+Ut1UNMmh/trfzLM=
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

Duplicate a few of the existing test cases, using the [ spelling, and
also ensure that the presence of a matching ] as a separate and last
argument is enforced.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 test/hush/if.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/test/hush/if.c b/test/hush/if.c
index ea615b246a9..5f75ea68b32 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -315,3 +315,46 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
 	return 0;
 }
 HUSH_TEST(hush_test_if_z_operator, 0);
+
+static int hush_test_lbracket_alias(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+	const char *missing_rbracket_error = "[: missing terminating ]";
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = aaa]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa = bbb]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ aaa != aaa -o bbb != bbb ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ aaa != aaa -o bbb = bbb ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ ! aaa != aaa -o ! bbb != bbb ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ ! aaa != aaa -o ! bbb = bbb ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
-- 
2.53.0

