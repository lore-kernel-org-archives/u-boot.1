Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D881DCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 06:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB1382E34;
	Thu, 23 Oct 2025 08:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cOfejBqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42EE48323A; Thu, 23 Oct 2025 08:06:31 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D76780422
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 08:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGfUCWFPsM5j5/BAWJwz25qBXY47nyz4UqMD8/J6DrnWf2o4xbMOBtBDOUMB5ivbwEZe4vd9ri5dMqgX8r0GVgzSXvHPxVTzcrtUfvgwWx8woCXLW5Cy19m0x09+sV8ZNQnmATJpP9SD9pylO6pJwX8Ddn/igQ9YrpProWdnzNUEQXKI6JJu8myvBKITSuCm7FKTf7rr9BbvhYxQlO0xtNQ4WMAzQLe1lUdOcw6tN/etR0eE2H41U2MhJu3jSXwLh/arr+3nhC9GXFn5Yg+OQiPWzAjVBAstr5EdjvkqxAEyMA6elPYt6qiIczbBqwpwC3nFD46UpvOGkMQAlYDo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCvDId0LSUOY6nmWeckHEKjll7iqBWfyn12DLXsOSG4=;
 b=ao2koIbFLLRskHnkpL5Qrlaq8JI2sFdogR1iC9NK6o/+Wa4zNRJNmY0vvPdzwlSVoIM90rwHcK37ISUNWReAWla5Mjz9D6OhufROUaTU7/oKTwv6GPrzEMjq8wiJ5UcZEBweFFwocAU/hR1NHFmMaIGW42W25acHSs7WkicD3a1SY1hpvtGxiMYs66kNfJUV+Nq2VYNtCZkIWaSoavLPWK2N7FveGK1JEeMWqMFCb/GcAg457oshmHqvgjjLwzsgzHoiEDFkmNrX6/0ZLjMDqO5+dkT6ABHuvSryHAViaS63pIOgCSlrtU1zvV8uVAptUhnQHFCt/ztOddd9UvxH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCvDId0LSUOY6nmWeckHEKjll7iqBWfyn12DLXsOSG4=;
 b=cOfejBqMJnSwkHfQyTCvlbxIKmbFXbRah7+2iWrmmx2eI9d5n+vzbDJ0xsR/Cu7ov6ugrl9C2mnmajLWflFmeZVsVj2HPrZUG7h7XPxRlTLAiJysJO+ygMo8anZBPgX9MqKlfCugfxfYSYOatqRFqLRTDpzOc0hFCs1v2rEA4Xki9ojmpfFwPLSdvOScum20jPcUR6nGY6xu+84tXBk8T0t9a62H8/0MQbUMLjy3I43YcwtUAPNKgKmhdvXFDCQ7FljBGeWeKG56aWyxsT1KVISrX7EuuJZqDq93LQqMCtfZJ6QbKMsY+fa0oA3k3QWo1rGY2tTddcOyJaveNTV5Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV8PR03MB7448.namprd03.prod.outlook.com (2603:10b6:408:182::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:06:25 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:06:25 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version defines
Date: Wed, 22 Oct 2025 23:06:14 -0700
Message-ID: <20251023060614.6441-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV8PR03MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8037fd50-5464-4c72-0228-08de11fa4c7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MVRk1+/NAIvfzS6bd+rZiFljsRiNuqazAXsN4Pz8IQHE+k5ff9JfvV3af4Fa?=
 =?us-ascii?Q?hzG32SAi6KiJrPuTdLSJBbnLvUR9Kg84+TOmUPZJzQumT/gEzPJB7o7eq1ku?=
 =?us-ascii?Q?3K70ZwsuVWbBgXT00LC3WyM42NBJtNLHgMOGinyTMbyeG1OOi9FfpLXZgcO8?=
 =?us-ascii?Q?AR35J6v9W7NnSlTZiPjkSnibQksFHMGHbh4ARu5iYRlZHzxzeZiDNv8bjmGZ?=
 =?us-ascii?Q?mcAT339cfDgnekNh60De1b7n1sxjIF3Qc85GGu60fhVSvD4CRejIpQd/4Sbt?=
 =?us-ascii?Q?cMedYXLqjo5EdXu0pTZkiteUKB1PRsUjPlqZGR2IFPkRz4FEtR0ueB/UHN4b?=
 =?us-ascii?Q?QafPBVdCjkhEys+vWoeAEogmogCqFNmVWUvyxokVX5m75i0DDmjQnDP9YdE6?=
 =?us-ascii?Q?fMfvh1xg52NwYmDp73BrVriKK+oLG8PfZqA9k9JaqTZd168AFW9pYfNdmxrW?=
 =?us-ascii?Q?hWqV2maxI0Z9M4OwCIVV2RG4lf01whkGLJnKTYQ9IDH/RwqkqLQAIHEMTAok?=
 =?us-ascii?Q?U74aPxwesciWpygJnzJvRYmzT3IVOHd3QUXlG0VqlGGhQbbng4T14/nA1qu7?=
 =?us-ascii?Q?Yr9rRXuXCmvbkGN4rAYNpqqH47o3/l6LhD8yNcihNgdn9X0ZEd1+Et0MOsgg?=
 =?us-ascii?Q?Rnh6Tl5oZZC5OQ0gzUTyhaCpG95b/+VmFwplS/zX49aCXblVLbLtyWZDSuUX?=
 =?us-ascii?Q?9NlZIHbpGvWsJu6Hfj+Vqi3GlW2kZIYqtLhFBu3BHZXYbWAhjAPHLa0IfI3q?=
 =?us-ascii?Q?yf/6R2oj9CJ6hVmfHZE/JarPJXykkqT5gmaKTp7Eq0MYO3y/wZuHAGC8sHMH?=
 =?us-ascii?Q?YtB6A4oBz6hwrZ94GT7mgRwZEW/AVDevPbbOCpHikFriggtlO1Pajconusy5?=
 =?us-ascii?Q?YotEMRsmD+DdyKQJ+klm084ZudzR8pd2fvPC6k+rI/qnE/dXTfgTkVOb/uD0?=
 =?us-ascii?Q?/ekJXEr6b94FKbYnRjlLdXQcO8blUSgP8gk7WjSqwE1tzhKjgdWCEStKkQ2o?=
 =?us-ascii?Q?rvtZqw921LjPt9yogDtoBqbD2K6V5r0qb1by7mbp3WvUNBm4DBRSAQwvy27P?=
 =?us-ascii?Q?GyGd9AfEY4aiJQIY4aPQWQWrYbCF4vsqCaytIcAu24WOJ2ZXCxF4pIJ2V5ap?=
 =?us-ascii?Q?GeBAma3wzOQsoqBdKgL/4bqXS0b8D19ytkN/o1w7Cc53oETDZTs5de42J8wP?=
 =?us-ascii?Q?7BYDPHE2VLrs5lA4Su11uVA8YNOzvp/9ipyfNWWoJoKy/H55JYijbl1PIQnK?=
 =?us-ascii?Q?DKihIRfp8L0GhMnXnlWANRuhHVVXFGaGLNWnyPc/Q7SYyW6ydK8lxqkzZ1CW?=
 =?us-ascii?Q?Hp5k6d+3SgtJmcOiQeA0XhbydL9xQ9UeutIoy8tGRXyy9oj+JSCCpsN2t9Ki?=
 =?us-ascii?Q?M8flWOHwPWV3ccmk9RkVEgtOVlfpJKGjABA+KxJKewbK3dYwTTrrWt7N8r75?=
 =?us-ascii?Q?iAI0UC+PaIr7ZA/MpsCF21jpctKdY/XP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OR334M2w7TVFjOHAys6bWD7qQQDC1x7Jm6YnN7VB8iZUJIaRHaJ6+6aP2ssO?=
 =?us-ascii?Q?Zb7zA0+J6bhtPqnGet6e6YvmjzlJ3hr/v3O0DzFwrhK33UQlaTtR31qtlF0c?=
 =?us-ascii?Q?Bl/jpwos4xOyt7Zk2mnR+9GaN/OK6GOkQXvHx5P9dh1xyFheXviqOZJ2OZ7T?=
 =?us-ascii?Q?aoKWlMt+qsaQgo0jWO059dgfJ6hi8mz1XVShGGfeTn/SHO7+0whHIBHL0Twv?=
 =?us-ascii?Q?z1Rde6QoiOzPXlAIqxFkoDCuDPzx2d71WUfO7g7kyp6b0S6XjPuR2ly74P6H?=
 =?us-ascii?Q?Ms1SgeEFAYb04up9XSjZ51bxBctfF11G65FmOOa/KXJgs93AQdciIkwpEYJP?=
 =?us-ascii?Q?NSc1OOif7HMbtkEMQCbOPQ8UxoZeF66oNJm+1/r1/zAl/Bzk0iMBAmEzJMKh?=
 =?us-ascii?Q?Jdb6Zmwmuaae0nNoBO26n3hfyaX2eNQ3cpme38CMZE0afobGFWtUf7beNjxu?=
 =?us-ascii?Q?opslVIfkz3fB6xOnetehAfP502sdQtvXkOCMX872DdzLt2j1TLonI0kT8n+U?=
 =?us-ascii?Q?Gc4eJWZu7oxhqs94ZQFB2OpWG7qMHejj3dmxQMFt8FMrqNusA7zLzdPO9H5W?=
 =?us-ascii?Q?6oz5cRLQvNgooxvCjIaoo2csI3sqqzcy3OcWW1k5Yxr1zXGl9aduXjeVXD1m?=
 =?us-ascii?Q?I/kxNM1JSWUSFT57Gu2i00sOv2wWYP5MbREmaV6moIGNsqg7/b1faemiypUD?=
 =?us-ascii?Q?Ns/aizRfmDIg57H/oS+7uRKeNPacHoLkq6VFBWDgUEFVOSMjKTg02Cf22k1d?=
 =?us-ascii?Q?Wxsuf589ybCSA0AF7H3/GGtTmROxMePbVt5xGKAtw9FT5pjy1KC9+nyh5eQJ?=
 =?us-ascii?Q?leLblTTwv/zDtD2kQDEgksyZu2xJ+3r/k6ISYkb4fed1xsZm6FUrY1hIyssS?=
 =?us-ascii?Q?EoyaxG2f3+eTE338IywxXuuV9NKDz+9M8IIRAPHhgkm3rtSkFD2O4Pqjki/2?=
 =?us-ascii?Q?YqYXo7+zOoyrxhomSi4Bjde87fGIR/FqxddgLBpAecTxSYLjE4uoSVLdEMMK?=
 =?us-ascii?Q?U4SBvu8iQxf+3CtFNYez/GSi/E/RnzF8EpINPEnTclUQZPOoGFUSjhI+GGWe?=
 =?us-ascii?Q?+U54oHfAbGYgNQXlvwlhofMElOuVlRSo7S8UfefJRbjZbUKfRRtQszB0uMGn?=
 =?us-ascii?Q?yI/8De44uaZG3E37AkLnNPSCgk6PQEDPnNXdFzaI4IfIKcKIOznCZb58ROle?=
 =?us-ascii?Q?Gs6Cx8ZTdnvJV5FUfbFPEPWhVCf1QnJjPcSIx3NC1Dse3bTDI/cNtlRIB0i/?=
 =?us-ascii?Q?tUitSHOeNvrATAX1nAjAkHIg2NARfHsehuXgaCMgwWNNCwu160qOdeUeGft7?=
 =?us-ascii?Q?snEwNxTy4b8AU2sKMCHJbDjrWAtsZL+iL7U3dFw4ojjEG2ZxTkxA+S6U4MUN?=
 =?us-ascii?Q?HBN7VAdwxQZ3zC7KdY9jYMgR0ovYRYiiCx4iYcd9jSaYE5IH0rNkP/GU3sBB?=
 =?us-ascii?Q?TQRnWXR2K98AdMdCTUhMHnMCDn7m3WvtwdR+fD1zTSPeUZ1HIeV+RLL0rRu7?=
 =?us-ascii?Q?SGIXUiBVJoXeBMYwbJos1EscvsYO+t3Hdft5LFGJ0sRJFhKy2Vsf1c7QK1LO?=
 =?us-ascii?Q?b5m10sQAtiIb1DAq17ZfHHl2KRx/roDdaLJ5VRfPOOhI4A9SlOeu9ChHQOxI?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8037fd50-5464-4c72-0228-08de11fa4c7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:06:25.7978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dA0QG41+AFQbyCA1qG7c1lmy3CZjVXrGh91VHi1k8HJdUjO1reMkj5R+OMlcaMqOxYm8FNCC/jvRaBNaA8NOMUSmIOLv7NhCvjcIRwm1VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7448
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

Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros to sdhci.h
to support newer SDHCI specification versions. These defines are required
for compatibility with controllers implementing SDHCI 4.0 and above.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 include/sdhci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sdhci.h b/include/sdhci.h
index 2372697b743..a962cc93caa 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -223,6 +223,9 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
+#define   SDHCI_SPEC_420	5
 
 #define SDHCI_GET_VERSION(x) (x->version & SDHCI_SPEC_VER_MASK)
 
-- 
2.43.7

