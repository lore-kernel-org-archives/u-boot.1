Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237C9C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 07:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5059B8870C;
	Wed, 10 Jul 2024 09:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hVd9trLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F38886F0; Wed, 10 Jul 2024 09:17:40 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6128988717
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3pLox3ebkPVDEVlFOB6yxCfsn65YAKpGihIm+NCMfdpfrqSuKm5vaeWCDpdUnjTclq/i2UklCGBcU7veo0irgHWCJ4EQsEzqCHVSJYUcW/xFGtUwq5TMUn7t384SuE0cGSJA5ngNhWk2/oTWRIJbHkVt19OhOnl3BX/Nhfgwxup+hdcBGrcTtvE2oMpfTDj2N6CUL/WyHTk6wDIQURR6s9XlE4zcPfv/EF8rUryBmHJfwGEKTmZ5vUOd08rJAecVHhCVv4nfnmCvgJBDVRG2Po2Qn6xOpvrFbxxfG1lD5+taFWR/9Zw9JQTb7wSLX9L9cMWiUQmDTi2wEE6iZk+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+pDfKRI7/Sny/AuHA7r3O3y1RNK2JtG5bq6JmIwvfE=;
 b=iYmNKXoTi5zuBNkuWuIbOFPDkG2ihmfSidvu1RUTg4enM3cA/yDUov6d/B9oxsgijYQQcwsYj9psUSBGTdq34pujjKbiyHd41EXZb/mw0e7ZUacFDH8io4EPFEoVbbi/GvoiOxZjBJtHO3FH1iucU9hIxhW0SjbM1vO1SX7Bf5OfLvtDZ+FxCiJ4cTrsJ3rVH2swQW/rW4DKxg+jfSzpTTrrvt/l+dfcU/3r4W00Y6PCh7if0tQ2Qr2atnrF8OwDIvzyM20z5xKFO5JCDOL3YY9m/JGhfXbBy1C6tsQpaLdqwWcsBOdin71dtN/GfkRFj+BBuwvBc1lX8DOzedHHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+pDfKRI7/Sny/AuHA7r3O3y1RNK2JtG5bq6JmIwvfE=;
 b=hVd9trLSzzhR1XomLrtq+ZQDqhlKewDlXDAvmR0grqHjv2GVfLDnTMsoqJ21URVixFXE/KxjUJxK9C39XFN2DWJ2xCG3LsHl0FxSTRO1EaqSf7nU26/mKmHLx20d+FzBVElcFBauuC+CgzBduK90Ff3Y0m0dQmvk3osjgO40vKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB5885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:68::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 07:17:35 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 07:17:35 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 5/5] kbuild: Disallow DTB overlays to built from .dts named
 source files
Date: Wed, 10 Jul 2024 09:16:12 +0200
Message-ID: <20240710071612.1717460-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db61313-c18d-4721-edff-08dca0b05f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7TWAYcjPPU9o7/dhbH3n0BRuNWOWx+NMlMyWGSQ03p91mXEdeo4XA2O+v6eO?=
 =?us-ascii?Q?cWPIPuWUeUXFyAMxdfWz3OT5t2xs5NBvwufRIcWT867o4WYXdoKokQeea9BN?=
 =?us-ascii?Q?YyiNSoTm+lxOvaL9jKAFrPFKVSgdS/Ie94IQuwx0+5N61kW0eZkxLsNpTKB+?=
 =?us-ascii?Q?tuSaE1QGhEfQmQO/SU01ClBwH/0GCsyi+PB0jk5XHZ+0pMbH77h2J7ndk8KE?=
 =?us-ascii?Q?eQmFdsbOvEDHHIYhgzuuq5hZfFEdMvU1ZNtjpRJFpBT9c2vrLFMcz+QzeTxJ?=
 =?us-ascii?Q?a0oeMEYCEYXDxSOSyGhWVeFOC1U7aSwkmOjhA9I+uTL6z/ddmA6/z11dbNZj?=
 =?us-ascii?Q?YJsFDHDbYTR94uTJj8eTdLsT7sbih+lHLz24o0qz/WQTNcMs6iEVjVARHUwr?=
 =?us-ascii?Q?wDdf9rUbHoHumsiAe4KVpwHCv32EBl03dVbMVpodXFvSxenkJ/e9k7iGsx1V?=
 =?us-ascii?Q?IIEPrTF5z6PJQ5hn3fIU0MCvZn9MyUVo75Qr+22X0J4pdtCuLyBYWI+vb52f?=
 =?us-ascii?Q?AnYVHWZJmCr20XapZSb7EUxYvDr/eMRY5VaIGVU1/y7qnBCTrrOEhAknOfHU?=
 =?us-ascii?Q?sd4LaQ5A3pQ+g/0s7bgWxqVhiv2I4ZcA/PPSN71MK5BAwXg+LjzhWyIoz2oJ?=
 =?us-ascii?Q?oyPEc9c1rzpzMG/njpagvSIQHCERq0xIh8uEt+nrJvRWbMutyQtgnUepqmJQ?=
 =?us-ascii?Q?xolsDotqSdTP94NclGT/xRKkF63hoFPU653IMrhBVWnkXvUKHkXAKB8UyILT?=
 =?us-ascii?Q?+cMr/rY/kdV6JVVFcn/go5aKmoxpEEC+Xl/w8n5QjDqhjy32cw7ndO2yhthL?=
 =?us-ascii?Q?DRG53kjCDU935goAg5NEXe6RsvgCoNsPNNKEh6mL79RUqusHVfMFFrqLnngD?=
 =?us-ascii?Q?lJ42wPYrPh3PDpPe8NNwqJC8AaoboS07UgcEFHso773qX781oqj/Wb73W2dI?=
 =?us-ascii?Q?o1t/xzi9xejx0jHatFUSvNFT157oG4wnygKBRIHVA/x+anDrSNB/FOQU69qX?=
 =?us-ascii?Q?Lh1jql9Hu05b/NpW6ALjFNp7x+EFq5zMDPnpTLksIMW08Lb2Lige9PE4NYea?=
 =?us-ascii?Q?wOsyUyW7hhxIhgNnXs2/1Tu/l7Qurqy2nJCD/LLzsgPNzpAdRBnFc4GoE/Yv?=
 =?us-ascii?Q?3OV8M5/10TGJAeAOqSGfgNxsxuooc7D8TrmnruqytVROFpoIisV/Z2EZbOn1?=
 =?us-ascii?Q?pIlquS67XbgI9TSSizY/99EGshckjntOJ/mkPrSgXM+SzdDkOz+7lae1G13T?=
 =?us-ascii?Q?Zu+P7DfIIjnaidFqxMZoAVP4vIm0Ri/z7kqphyrRPWl37q+aUxyfQQGFV9lF?=
 =?us-ascii?Q?oJyRsu3aBNibiYl24jDOQUvLy2O8MrAfwrBUceHAcS2d00DmzqJVH7OIL/gk?=
 =?us-ascii?Q?Zc8wE1MBN3Z/9mJg2TtsZ8MAx957tgJlsnrPADohkAfac/KKCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PGC2F2oE1jSmzAuJAHoVc1eA0sRHHj0drRp79dRCiSrK/ExW5fIlcRac0oFQ?=
 =?us-ascii?Q?2tHAObyrZqeD4h9F/fBwsDahcgRu/bUxgzkBDRMoDKn555KzLNmBj9KHkXKo?=
 =?us-ascii?Q?kCVZary8pShWgxym/ldIveMmyk4j0JdfjF+itTUx8wHuSqFeb/1i16xnQxok?=
 =?us-ascii?Q?ZfOCFJjTuhjM1zQwOYKTvb1av4xsRkEVJKnwVxsTjywpPW0fY9XgwnkI4emv?=
 =?us-ascii?Q?MOcfKscWCZE/n1i62I9gFp+ObxKooInwQKNxtCDSPKPhBwJ4KSM2Z2MMlotm?=
 =?us-ascii?Q?kekipRtYm50nGF3HDCSG9LlR6PL9HeZCU7/Kszbj0yNJYkm2km/737kMiMmT?=
 =?us-ascii?Q?4iW4DhHWVqKU47FAzfh59uWd6gbPJEAPhKtBCJq3Wt6lcL6eCqMOzuIHCTNp?=
 =?us-ascii?Q?YXFRVeZ/pfwrFWYRkJH0b/elln9TEgS5FGJnHoN9JerTF0AmeH/YBDW4UWDd?=
 =?us-ascii?Q?CVtsXAmYC/s30Y0NDpeEn8MtOXYc6IZIE2I6VILIUa1fqYGjGOQvlZ8d+FkH?=
 =?us-ascii?Q?bELoVvmhYjVWRow1IrDAh8Qi1VGCx6dKwgYbJ4LRGqfyEaIOSY+ifzWK7wu3?=
 =?us-ascii?Q?3lGa/940XLu6/yK4fLHipcv4X0bZf2FpYWws3GO61IdPzL4IuLqSu62Hdsgc?=
 =?us-ascii?Q?O9FgoNqxOgqtniSoAZUi96de00FF4kdR3XGCdjkaDrHJTcBuId75V8UgrG/7?=
 =?us-ascii?Q?GAzBJJ9KRQ/rfVfpMVcpsUZgTUI0JbmGIL8Wi10LyUah50Rc1yZaX0P/y48D?=
 =?us-ascii?Q?1bqGe38ALq+p2IYjJ0EYNPK8tgAt4u9crR09tGrUljVbMYTQXVs1En8AthLI?=
 =?us-ascii?Q?L222PGHAmsrg+TBuUypQAgTy53o445QXddJc5jpewwQXoJ4DWGqeUQRTDdls?=
 =?us-ascii?Q?WIFZR6psRn+4KmGQBrk/LPzOH61DBDLw58SwRPKEpBgvO24cw5jxwUfhqGzT?=
 =?us-ascii?Q?V7qxnx6/sZUH3yFIaMpDjQxjECa1TWIztczTxCn9agY/hOPecCD/iACLWZjF?=
 =?us-ascii?Q?2VuhuznOBiA2kxYc6AIrDuN0VyYDKjVU2ZP/1Rwyt9amb2N0iziqT8dwoD4i?=
 =?us-ascii?Q?66jaHhtvwSz3W0Xs7Za3xbLCaTUh5svjN3uPshA8sZJCwZiuc7p5N599bcUN?=
 =?us-ascii?Q?yzFrTncVbMMo/OnXslgENsho39ldtubGwufUk3BqmgIMXl4fuyw/+6DWuk1/?=
 =?us-ascii?Q?2xgtIly7ZgRuqgaPpXf9jC/1HdzHkUOzNO5QJQC4vVIzRUXpo3Va1Mmte057?=
 =?us-ascii?Q?etEzm5tRYXzhU2gRSh4W/la8KW4br1wQq8i+4f2s9a0axsqu9YgTaySq21bI?=
 =?us-ascii?Q?BUNrrb55cbxwZh6hLmZeHoeWMxatigNg36gkBC4IJldYsYnD8D4y/v5Au6fl?=
 =?us-ascii?Q?89ijdxQvvgfIyF+/9ouwlIzXO9+fhr9Mae2n1A5r4scSpDjdGm+gro62blqI?=
 =?us-ascii?Q?CBfkLN9jDvqJJ0AdN9nIRJEfWwVnOdoyHfbs9yQDQ2GBjbgTt9TeA1hRXLFH?=
 =?us-ascii?Q?SBqLOLGuJEM9JpHS/25l12Gy3/2grioD/WkRh0P0PD5X8eNigjeN3oq8Wasn?=
 =?us-ascii?Q?gbQ3ETA0CX3EbH4i6tUjUc79INd/V++eRl9gfdrMMjadsPt6g72hL+H9I6fM?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db61313-c18d-4721-edff-08dca0b05f49
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:17:35.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keMzyxVDpkXe3KCLGid8T3tlhYDSrZ8EVlM14bQB/wN17wZt0a2k+BjZA8bVo3P1VNM8/P9JJ5Lkx4sZaesEn//2skuqgkDDdJne0kwZTyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5885
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

[equivalent to linux commit 81d362732bac]

As a follow up to the series allowing DTB overlays to built from .dtso
files. Now that all overlays have been renamed, remove the ability to
build from overlays from .dts files to prevent any files with the old
name from accidental being added.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 scripts/Makefile.lib | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 549c3619472..d6fbf9a7659 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -416,9 +416,6 @@ cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
 	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
 
-$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
-	$(call if_changed_dep,dtco)
-
 $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtco)
 
-- 
2.45.2

