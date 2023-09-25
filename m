Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F8FCE7A95
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784BA86BCD;
	Mon, 25 Sep 2023 10:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XOkSr4ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28EFD86BAD; Mon, 25 Sep 2023 10:10:15 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68EC486B96
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h31flXGaPtoWpplMAt1r0+62dQo/IUYByDB4t8u4E6CmiZtzzWc/gmTRj+SD+1A2b9bCLIThO16RLXbzD7X8IrHb9X9WBzvYvvAHuWZb2w85x8HVpfuxqxGbBPip+eKNGm3L031rshIwTUVi7RQg3gg6522qOQK/ZfZBnQoL9S1MBjdu4hCpZuC/PDOQBLDEz2nOCKa9PECg6i7ObEbEC715bgqL5uhCbebVRrvkLXsRbobgKPa/t+Qti3mUlcRQvEAfoORKrvRb9X2i0IAZqVzrtFlo6qBJbY7CorN+oJRA4JPGd3qVLWwSV+yoNk3O4v6jm+ceT3cZsiz/u1bJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGSsYScIq9z5KU8/GHXGe/igFvSxQ0Sl/aJ4e5ERmNA=;
 b=Q+7UgzR4f0ex66s0c/QRqsEtMe7ENra9/hzl8eOqeeN1rY0GWxEikw6WZAf0dPtu2qIW/xLtkdaIFVZNqdVLIip85xqM3zTFtwPzl2Nvk8iQXWlbnQaQnypY7Q4WfVwm3Fwqef2OHgVA7SuK4U9e2yMb63yg4YoLBCOC2ccGZVP9dFUyRrIB+C2uCWfUCh2UQTnWHv38jLcbQdDTEco1Xy5TBEvsDcXNg+Y1X5r99SURbystlySVG21b0ssNQPCdt/rUYoXzTEF3sB62SttHCfZ2+TWCk5eL8+QxBkb0i5GiDy/z16S8t6ZAm186ujWu1547JoPSjzOmixjXs3n8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGSsYScIq9z5KU8/GHXGe/igFvSxQ0Sl/aJ4e5ERmNA=;
 b=XOkSr4uae6Jlg/T0nS6bv5tl2q5De321hs4aI3fppPbfeAtdMwnTKF5aSJbx5jaddh0r6t79T2dnbsKX4n/NftdKx0n1+aQadwRn0bhNj/Oh0pPrxaSZOXs2DJmrrflCeaq9XM/zEUuPacDVdBTnKS17HVHKi3F7NyssTa5iNyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:09 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 5/5] doc: use .dtso as extension for device tree overlay
 sources
Date: Mon, 25 Sep 2023 10:09:09 +0200
Message-Id: <20230925080909.365098-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: d40b577f-2ade-4765-34f6-08dbbd9ed5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWFjySAItEXcPxiLmZ+50ZsrCuRYuzbuM4G+VBbNcILJpYQvaSJlS8ho3FkNqh4T6sGfJMDX8iZ+j17jbfnwCv/1KI4XbsF8G5DuV27D6rvjkwUwL0xEz+qmjWuapd19VRgMe+0AKkw9/1mynvpHTIM1N5eUPYXBZUCOHWVQ3GJN9rJLrHXrN34ekAnTHRmeLiFxGRt89Ldod2BdxAQpw0aDY7FMNsin6nqb/BFA4Q6LjrVXQp8PCcluRAY7FP4Ijm2y1FgU1VLzzpSz71/f3uNxMLiqgkxcQLNhSZELhW8L8QiPAChD5VuF8/fgyVffG4r+/tdwMDkrc6NJLpDClmmQZosysKZMii6Vvu6IlFqNgkDWMQugfc4ZvTmkV3yyHyOvmj2PwDPKrQzZw4YRTy1DwilvuaMJb2/57tQOPlKHos+etEAVp5jNrXFly4C+sJHFfNaYeCyCfSmJA2uY4Hf73ot89Trxr3R776EHFWjGsjCdHMDHAf69Ckf8yeyMQCUGDrn0Me4d4SSEwurpjS4Xuamw2szsbYpNHaVfRfnGHmzg62pfQRgY7ss+ZZGVpOduxe8I5nYCP+0ESvX+T9tcF4u4d9ZTuQtJYiLiurlAU7x3EHELq7zy96u8QnyltGZpkAsQZxWfvfslnS+VSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vd7clWuSgyvpxUcN99NmBPQ4Q73sadLLXGrxZsNp2tHkdBnITisZe8At9YWn?=
 =?us-ascii?Q?0N0zIOtxiDzbHdnhGaPeKGDYLuQkA3joz8B7a/5hkBuELhBKD/+JNl20KJWT?=
 =?us-ascii?Q?eDBJ0eshp/1YpANdMxr/251dXfkunUtRDYQpCcymNUKOFa0gv8Mcrw1miVdk?=
 =?us-ascii?Q?TB6rpS2SZX45m2znF1rw1kjVR3445wc/jyLtjjZd2XFJmwl60DNhS5jyhVU0?=
 =?us-ascii?Q?IfYJY09ePuQKVJsEI6iWBpFndyoh2ZKwAkKqEd7xEsslQUABmHmbMB4qdFWA?=
 =?us-ascii?Q?w1o8+3ulTYIgaKIutJ+npir9hetd7PnPUODVOPAgdh1Oh5BnxuIO96feZcBM?=
 =?us-ascii?Q?C6rsdalkSTNadH+M3cUhs1yXpPSVxme2uwkGCwgIFWDHfsDG4DhWhojco5kI?=
 =?us-ascii?Q?jY9swxGOsAn0CV9KfzMbgDX3t07ZZWwGQag6Atn2HNxUUqWxcFj6A8wsxnok?=
 =?us-ascii?Q?n+MEkTLR6/6KVFaNiSl31GFXiWnUU2bqsYCMMXLjoO7dv5zBgV+j6d9+0bNC?=
 =?us-ascii?Q?cL8UeTyeblihl6uXHeWnaOoC11MB52fp+yhSVijuOx6UBLL3uY6NxYYdB/ye?=
 =?us-ascii?Q?v6ILRLcRKiacFmfpbp8DWQioY5W1k+bvEl3onMMQAIUXolebhH1WflFoK2z8?=
 =?us-ascii?Q?8Zyfu1wUOlO5/05uTqccTq9mRoSwR3vdp9IkEIezhAYQ71/TKJJcWo3GLFa6?=
 =?us-ascii?Q?Mv6Lj8YSMlXUOukZi2KSYeSBEjbUndn1iwosa0+WOb89/12/e43Xm264TD6D?=
 =?us-ascii?Q?dT4J2Z35MTgyfq+nYTKVXw1Zkfkz2vabO0NVG2sIa0mq9A/umnS4+rrwfZol?=
 =?us-ascii?Q?neReMvADRmUAQ8Dkrchj1RwJtqgFiLsOUCd7RwMFvdlbIs+hl59wTfD3eft0?=
 =?us-ascii?Q?19iO1RR2scwnlp+Igt2asd+58td98hM8nOec/RQEeqsjilExc4fmGweaiTag?=
 =?us-ascii?Q?8hENT6HWHA+E/SviUCCbm3J7AY6M6I7SK5xg588am5mooZQ5l6VpuOBmiYMM?=
 =?us-ascii?Q?HEvBAzVNqdhVzFzsDDaXJSPmZ9ekAkcuTlJZaLsGHZ/r8GlGxMHe8GBCkVHK?=
 =?us-ascii?Q?ymrX6k0Zo/xWzmYsiOqj4TiEMID9ToiII5MLWHS/mLcymD4+NHIowMhNjp66?=
 =?us-ascii?Q?hvmwa8kyvgDRoyEuIMNs5NH/DU5HvSnPwM6QIwZpvi6iznd6L/7Jyby4XsLY?=
 =?us-ascii?Q?7SK9HJKC1NeWrCeS2jyj1c/P2CvwKAE5iUk29fv0n9PX26oWlzhyb4Or9Cav?=
 =?us-ascii?Q?DXwc3ZFA2V+ZdQQccCkRi1WDIJH+NW7znwXNhoSKDZ1uT4lMUDfFXgSA+Uio?=
 =?us-ascii?Q?gZ3r8ApwKdAYLICcRvqeRNb9h14/0olUBk1IaSFANDyAJyxpw7T9el0uIV84?=
 =?us-ascii?Q?Jft4yKHQWuNkhCgCe0mAz6CnWW6x4wqYP3WdiqPLF7pHSQSjPMUphVAwRmgk?=
 =?us-ascii?Q?HxggnORnCujgb/rr7u/GEa5Uzb3I1Cr12XEMXsMOpTH8WRPt5HLhCVXALrpT?=
 =?us-ascii?Q?aBUfpJ+BnYwWRlOzcGCa0gWkfH+2bSE9q+f2kvDdg1B1vyr4NY+tEHagDba/?=
 =?us-ascii?Q?GfYen9KqsJyenin1HXwyLYe1Ep67c7MbaoPMVwukFKaNHCut2BMaJvoIQucF?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d40b577f-2ade-4765-34f6-08dbbd9ed5c7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:09.3274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuODzOT0omDmnPIxwLIyfce9Iu1Ve5EpgkBJFcQl2XNskNKw7SIc28irQs+BAPNLFO2PV1uI3PEI7xwjLSlxlE60zU0QWxg+7GyWKfTRalQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

Moving towards using .dtso for overlay sources, update the
documentation examples to follow that pattern.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 doc/develop/uefi/uefi.rst  | 4 ++--
 doc/usage/fdt_overlays.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index a7a41f2fac..34dab3c12c 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -563,10 +563,10 @@ To insert the lowest supported version into a dtb
 
 .. code-block:: console
 
-    $ dtc -@ -I dts -O dtb -o version.dtbo version.dts
+    $ dtc -@ -I dts -O dtb -o version.dtbo version.dtso
     $ fdtoverlay -i orig.dtb -o new.dtb -v version.dtbo
 
-where version.dts looks like::
+where version.dtso looks like::
 
     /dts-v1/;
     /plugin/;
diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 7f113edae3..81d0d37f3f 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -43,7 +43,7 @@ traditional binary device-tree. For example:
 
 	$ dtc -@ -I dts -O dtb -o base.dtb base.dts
 
-**overlay.dts**
+**overlay.dtso**
 
 ::
 
@@ -63,7 +63,7 @@ traditional binary device-tree. For example:
 
 .. code-block:: console
 
-	$ dtc -@ -I dts -O dtb -o overlay.dtbo overlay.dts
+	$ dtc -@ -I dts -O dtb -o overlay.dtbo overlay.dtso
 
 Ways to Utilize Overlays in U-Boot
 ----------------------------------
-- 
2.37.2

