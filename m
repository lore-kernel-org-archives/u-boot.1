Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B50BCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 21:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B2A8490D;
	Fri, 22 May 2026 23:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="SCjg8xHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DF9848E2; Fri, 22 May 2026 23:28:10 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAEDC848BF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 23:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqGhcTvye+ng0UZLL/G57hjWvSiAPk6RYwvK/lyshImVKzQmbOGlPpB/U4DqkeByKAbSm2yKHkspCnfjJMFAp29WoMqpntLtlNe/4oyAIhunhyukETv+zJ+ypoVm+/IMKYE4/mw1gJdDXSm7i/2NDHsKYWFPU4unlb0MlSQAbTF0S8gONHy63AWA7YAqQM9olBftvH+HaA3aLNVMH/C08KdHE1u3oJckVJCN356Eq+ZavZkohImo0qc2ezBZqAt+zBCgouzI59Ci6W2QU7rC3gg7i761+CTA9RkptTPtgum6gId04GJVhVyHqDM2T2XZ03LVKu1NNaj8Y0BOfO4gig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQCMeQ++hw7oCHkAQkx/iC9NESmFiWPDFMgx5YWw94=;
 b=Otb15Rs8bdqO0q9ZijoOxplqdPEPQUICqLT+2DUMimKxBLVArEUmvITbYobX3143/nuiDkx9K2F+ova1P7PdU58e7r48icto1s1Or7hF28y+uKACpOByPxt9P2R/AJoNC02oeNmYbaVVtApNEbl43TvNFSnTsDpvmz4A7u6ZVDZg4MDA+qvyFBh5vly2DM+35AZw9T/zf+ZnS5elMr+0Lizg1tPtmo5cc00lG03Oq7Q5jODYVJeRDdlC0CSNFW/2KwTvvZ4hkOG5fENeI5OnuA62CzF5ogd7glrUyNwVBo1lC3mqA2oExDbY+cJLPYiwOFEQBZGmRLkS1k2FtuvoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czQCMeQ++hw7oCHkAQkx/iC9NESmFiWPDFMgx5YWw94=;
 b=SCjg8xHL0k+HeeHObQ7oYg+XMrlvqfIEm9BJrt2D9BQ237tCZ5Ao06P0M6x3C27j6P0dgSbAMUhEngVXyM1W1LJ2g15ppqHBZQCtnwXqfhBYqOOUxg+L3N//AvNj/00OjBE2u2ZKl2lzBG8BX9uuIdopIBmgtHtfHjxLz7t8LpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 21:28:06 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 21:28:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH 5/9] linker_lists.h: drop _2 from section and symbol name
 prefix
Date: Fri, 22 May 2026 23:27:52 +0200
Message-ID: <20260522212756.3169222-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522212756.3169222-1-ravi@prevas.dk>
References: <20260522212756.3169222-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0406.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5fda74-77ed-4426-03c1-08deb8490391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|11063799006|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: escLo6LauBEXBFNjZ7jQ9APIJWxJDnyEp+bI0XWoU4XS4xQ5+o861ixTTxayixEf19gjUp+58fpcSDzTZ7vptmaTopkyTa1lUHz+y1GBGVkXIpKER79HJW/rVAzZBELLhjSlWq3gQFrIhxTxZ1ZQzhpeNxfakYRrFIW6Ts/m9l8T+DJVNAZsKerpux773f7If+Flfz/Qp/wmDMeue41i8sxWcwX+bjujcYOLiz2+7Dj71zt746rc9xZ+cUsCc/HKGdb4kMMyRHAsyYsRWyXylTrub/w+zLMvwRPAPdqR2mYXceFViY/auKg++y/W1+fkVRQNKwB2T5new2nM0qfu8L90rkV+y3dcFWZaRRzFvr8u3NeZfjwVcRodLXttI19gIMv3wdBXEW2BboCtQuGaCT56PtMPEq5yvraruw0ZC1IRnborlmDlJfNpK6aoVqwy62y6ECZxtkc6tNwUdPkKaKk7zyUViNPojLT90HKmudAsAVimVyFwuT986ZoHjRh1RnasjeCO5/Qxm1LA8TtHJpfoPNdLLOb3t0DWuaa6sXiGPZPnFhuilvwUmMAy6TJE7BrBhi/4V9pkuPSLvCvBuMqIF406YGo3SpePPfW2cHEpv1dElIoG83f5t/Q5uPLOyOFcYa20X/3MTlu5hqc0Xt8jQqMtm2/YzUPIB7jF7tQHp111U5o38EKuLZCgPNmmAaHWJn8YhaFKEuVNe8hSkWoKdaTkNNqvzApRnxryppYK5ICV+goszINEOWktgYX3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(11063799006)(56012099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1yVKfzAg/7l7RaYg40pVdh9/RC7IapSRTuSJD4xZphz+woYt1cCcDSDHhAQ?=
 =?us-ascii?Q?vUSuyNo0ZkIigVz85h5qkjcL4h+81cw53d2s5KzGZ+mwGMsm4ImTgMI5hd5l?=
 =?us-ascii?Q?tMU5pMWeKMiXJSJSEH7VY5AlWygpFCtDrZSoUH2pppigku8ndqtczxT4b+lV?=
 =?us-ascii?Q?SyriT9/bQwvwXOoS1FYQQzVGOG7QMXXB9v8FS0z4Fute35YUfYEIWFcCrO3B?=
 =?us-ascii?Q?K91JuMZpaV8aZtdjA+tqdPAYvFZykRgpIhc8CUCvg+RITx5vC76sABk+eEas?=
 =?us-ascii?Q?Vx5tswjTxTfYz4ib4CGZweOEXyi0XVEKcR7APguZJHx4Y0OnNNQggLUxfuqZ?=
 =?us-ascii?Q?hpWuiD4BDjdYvHjplnYtTndGDn11nTHShHmHhn3kidHmjRDPeqf2bgCphrOf?=
 =?us-ascii?Q?5FHzdk0YK2gdA3vvndqA1btmbAQ/ctYX3y7PwBS+Nw8dkUj8ZqWYPNRXBHrz?=
 =?us-ascii?Q?QhbpUMdRv0CXNQS/YzFeJJ9ZTgYNfkkGV0RS/lKZnK1ZXBRibBM2VCX7sGrD?=
 =?us-ascii?Q?yZgbGX0R3U4CV8iSd2aTsiL1WkJ6m1+N1AqAz5WkQFXFW9iG/mEqDkgy1pdd?=
 =?us-ascii?Q?4y/kHAk8SinuFDKh7ov/aZ7otONNjLRncEE1mwIWdIbyl7A3AD+hS2rfYjQg?=
 =?us-ascii?Q?xb7QSHe1ct4cQtrL+mNNHENcazZLrtw+ff8bHLe6GinL03PveuH8r4hprBYY?=
 =?us-ascii?Q?xTxoWnH2ylGDA4QwFYHtOzQf4hE7H0SatndUhvUbmhp8HTV+bmkdnKnZ7LQc?=
 =?us-ascii?Q?FhWD8mkvFZpVldL83qW9qhGII59gFN4fvCLhtX/8yOvsqcJIsB6BY1knJ1Lp?=
 =?us-ascii?Q?/HYF192dVtpkRvYYKtFNPpp9E2GXl60NM3SwhHsZ3FU3Hm8FMI8V323S1RlD?=
 =?us-ascii?Q?Ukn0bEXUZaI1pT3QPfw7DMjDvilBlntJV58rgBuDKyOb3oT6ZUzhfTlVgV3g?=
 =?us-ascii?Q?Ueuw+iX0qGoGrdAVfSS/Y3JzMCsf0q45kRCNhwHDqqaovmzcoe8XT1LepFGH?=
 =?us-ascii?Q?GPGzCioakI5f8taW18jUPklBbrrV0kqi6YJ0Ft5y1BTvbw0+siqWvH/brqfu?=
 =?us-ascii?Q?1982EM5Yp/1TrBIMrM1g0Hy/cwsEAWngC1Jklt5G+Mj5EeLQq6ZGkTVV6QqI?=
 =?us-ascii?Q?NdKbKP1w2pX9LPjXLoXnm5Erw/oPvCQnOBOKSHwsHK/cRQjbHIwedk1TeQ9e?=
 =?us-ascii?Q?BxpomKugLjKyxcOZqetIaY69cF4PbHZlIqjfb8UB33H9PsnB1490KxDNCEqA?=
 =?us-ascii?Q?RQHeYsHb8IzEzs4sKrzs42OrZbaEQ21fixrUGl8gHyCUlIKJQ8cTyQaIPHQt?=
 =?us-ascii?Q?XV/h3k5tL4mF629cnHJjF0tm7eJXBG6DNCScZRv2bCvMtnXUESxsyQ9cCS73?=
 =?us-ascii?Q?rNas9aANDJy+gBrm51nuSMYufNdGTACG9+lx6A3+hpnv9Dx1XrIAi2RbxwRm?=
 =?us-ascii?Q?TIpgnMCMkTbC/YQFK6hSHCcK431fY3hoXKK5ElCwgy6oF0e/0KyKsyWSkQw8?=
 =?us-ascii?Q?OUqOwe5XClkopZxYdU559y1fabWY3QJdBOzpIxPvptCGKWuik5he1lTS48f1?=
 =?us-ascii?Q?d1rfTCNMfToDtvAcvj4QekbSfvdjWNUBdQOU63hGFiMQ/rB5JMbQi0zOE4S2?=
 =?us-ascii?Q?MdQYbla9ufXto84cA+SRln4vVRc98Ci+DAFo5uf7aXcTSqdN2IPJDkYjlbyf?=
 =?us-ascii?Q?3vfl4j547FREs5u3E3bRh4KMkpXBSqU3F9ey+jfWaBWWlMn1sEx1kstsj7TG?=
 =?us-ascii?Q?muhg3P1UYCPKnRDxUmsRqbEzryurVo4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5fda74-77ed-4426-03c1-08deb8490391
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 21:28:06.6347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ooj0khtYhuy+PkKU2XfinPPsDsmSIvf5sANnotvxkCfWMN7GvzLT/AO2BzYPMMqZMiHTqiNnSHJV1n+6NE1tNw1Kq/a8Od9uwgvSZeBn2WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5385
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

Since commit e2138cf1e60 ("linker_lists.h: drop never used ll_start,
ll_end macros"), which removed macros that would create
__u_boot_list_1 and __u_boot_list_3 sections, the first _2 in the
linker list section names doesn't serve any purpose and is in fact
just confusing. So remove it.

There never seemed to be a reason for the symbol names to have that
_2, other than perhaps for consistency with the section those symbols
belonged to. Regardless, remove that as well.

All linker scripts use a "__u_boot_list*" glob, so they will work just
the same without that common _2.

Keep the _2_ part in the separator between list and entry names for
symbols, since that is called out in the documentation to allow one to
define sublists and iterate over those. I cannot find any current use
of that feature, but a later patch will make use of just that.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linker_lists.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index b6437ad6462..b94e3a359f3 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -19,11 +19,11 @@
 
 #if !defined(__ASSEMBLY__)
 
-#define ll_start_section_name(_list)        "__u_boot_list_2_"#_list"_1"
-#define ll_entry_section_name(_list, _name) "__u_boot_list_2_"#_list"_2_"#_name
-#define ll_end_section_name(_list)          "__u_boot_list_2_"#_list"_3"
+#define ll_start_section_name(_list)        "__u_boot_list_"#_list"_1"
+#define ll_entry_section_name(_list, _name) "__u_boot_list_"#_list"_2_"#_name
+#define ll_end_section_name(_list)          "__u_boot_list_"#_list"_3"
 
-#define ll_entry_symbol_name(_list, _name) _u_boot_list_2_##_list##_2_##_name
+#define ll_entry_symbol_name(_list, _name) _u_boot_list_##_list##_2_##_name
 
 /**
  * llsym() - Access a linker-generated array entry
-- 
2.54.0

