Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17369C3814E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C963C88663;
	Sat,  6 Jul 2024 15:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="X0j/IC0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026C0889D4; Fri,  5 Jul 2024 22:30:15 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E85A889CE
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 22:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLFFmtaOyA9Rq+56TAdGJAIUc/iccM1lMf3/KmMQi3IFcjST/P3zd2IpIaKdJ2sLT0jCEMREvUR7KusW/TONVk2Blyom2bAMwSCSTF36N5V9fGzkIRogIkULJGm+X8RNJthxKkGvu1+DIF6S6SH21ldPHiQntWhlffuoD4VWvKm+xj+Ehr76VFPA8XfLHtvFoSaXaO0fqwxUKy47b+a+90gx/fqaBIPziHOdFZV/dGfX74G2C/C3pgAeTCse1qB+FagTQ5LlQkmEkyjWcXpmmdzVn7s/lbv3SmEtbK7V8zK0jjVZIhYwEzy045iXQb67hgl1NE9ipjX39GRkKcwH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS9jNvjLNPXXgXnaj943yrz1zH74LYFOL2fZrLj5H2E=;
 b=ZgXAmnJg/PE6VvG+bs2zAzagWVgjb4WLDNrMdOScksHcruCgvYRDzJk74Ib3DaSUEbYUcDcWBB5azF5/XqJklqvYuutpxaNeGfyuW6UvQX5F6s98/2eRLt9BfpTfedSXV8P4P0oPhDbjGv6URgUOJPnD3w4Dp8nRaOOwU29l6vEEVPVQgFBPodSXR0O97e2edTij6r8ScM78sWfp8S+hYxni1iHiyvbQBTFtudFdNi8D4A1VNGXoMZFgh7al5hpfe3tQeMWtriVl3UhpZyowI7Z0mHDVjG5+YA/x7Ls6jtCnv1wUotr1iztLHj2IPnAkox9iZ9Ryi5YUWvxT/PeZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS9jNvjLNPXXgXnaj943yrz1zH74LYFOL2fZrLj5H2E=;
 b=X0j/IC0ZuRqbzM9HekEqKtFEq1oprZRbv8XdUaVFBUGZeilNbe9xX46HyXxWbIVnrvxQt6xW71esdi6tS4Xf3HBjrDLB39gdFcIP1q2bxs/TI6+TlGmKm4N1o6SJWRKXkrFFLgNEWd0jZ9t76tFyVcc376kjo1DEW2P7w3v8ZWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 20:30:06 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 20:30:05 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/5] finish using .dtso for overlay source files
Date: Fri,  5 Jul 2024 22:29:49 +0200
Message-ID: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0039.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::31) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5757ad-d496-425d-0fc3-08dc9d31411f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3qdtuWsoA6/elyFQxD/t1Cy/6yRX6SjFPhNZa0szWQt4K3q5QP2HkcD1H5bd?=
 =?us-ascii?Q?t+OkTU3Ksp3tcUcbqvpO8VYoRCiRbzzxH5ew5kE7I/rsjergMFXNV7WXcrwO?=
 =?us-ascii?Q?hLWo41L7WYA2teMGB0MRwIlM4Im1meKzme03CzOos+jocovS42G3sG4OlrpE?=
 =?us-ascii?Q?MzgIjNLyZnwVcsZmD2Rx3zX53YEDvGnoqf+dq5UUHEpyb8zJDQfx/9ibAcY9?=
 =?us-ascii?Q?l4Wd1E0CLjarBxxPUz1UbrdLAtlxQlTK+uvf17wVuAdQSzfJ96n6Gm0CC5h4?=
 =?us-ascii?Q?EvqSXf45Eskiama3v+mJy3vuxUL2XkS50PisFtaCUV7Y0PWlrfXYiGhMiXJw?=
 =?us-ascii?Q?1l9iUKZxJfzFwgUez08QNbo6VbVNvldTpHaYjapkn50n2ZYnJq0azfDJ0GCA?=
 =?us-ascii?Q?lOrNOze3eMfUxwnunDaDR7rrUZhIVgMJIJ2cW4elPtZV7GlhPL8BtW2hP+ct?=
 =?us-ascii?Q?iilnfLE+Qxw/dWQWfa5aKyAdqpgh+C5xSEGAfXsnV3wd6x9D0UggGGHJM5mK?=
 =?us-ascii?Q?IOmz4Mb08KN5YGhap6rKBebSjrvJBmSpPkJg0izHFQZGS6fhIumPJsfvo2QE?=
 =?us-ascii?Q?lk4d2Ec2ElmcywBZQg1otoFXNXv8eNibz+Y9XCzRj5fdkMnodnzDQh1T1O8P?=
 =?us-ascii?Q?aSkDteP0qRxU4tB6m0HNMFwWUy/27ab+UOKOmqBOwxbetBSRSxhuqg4ScAN6?=
 =?us-ascii?Q?63xPngUy4SxbHM1ZAyerb3uBcQDwg3d2lr1zE4c8SPmO5OHxJEq7TdxHLebO?=
 =?us-ascii?Q?YsZ3w7Umr802aFl/HTlX+QhjHFjQs8/MHlukMEXyglqkfexDG7FAjVJy1Xxv?=
 =?us-ascii?Q?XBFmTZW7GBrIrstI/Cs+YgJsNVLhi7gPtooC9aXTf62qrHHw0WCemCWKOXYP?=
 =?us-ascii?Q?NIh2NLba8gufQUzOGjyEljeUUpf+RxWLm2pifAYJ4g1d5SnOXQgjspIDWdlF?=
 =?us-ascii?Q?IGfjQEg2e9jB/c6hEbrUojZU1vD2TfTLcZwsDHr8ynwW7YnVT+etzd18AG7h?=
 =?us-ascii?Q?diWiQWeaU3FlkJBR0Uq1aVm7xoGAzTKcpXFz08P3tD8DuWCx7977xBb++yT2?=
 =?us-ascii?Q?Q5FvkRzISuE9ZFlrTPJwFLjFZAEyDXz7CiR/CM89fhP01emsOa1E/GMM+Cnm?=
 =?us-ascii?Q?nXBsSVza7yO+LJ3mPVtNpG6AB26Kbc668ClVG2lH14xRZX/yKIdVWVXX2NHs?=
 =?us-ascii?Q?RT91b5YXAyxQPdJEHvmIjd43/0NYfTJt8KysSXuT01n/kM0MCU/f/ZoTedpS?=
 =?us-ascii?Q?YM6FxbqsYVRZ3sNzEp+HT6CzCmkZEF/8yw6iGic93SYSihJgMaVMhlGP+w4J?=
 =?us-ascii?Q?t6WYp+/TBfV49BWGgFtpPjOGpibWEjU5RLDYrIWTRmcHVHhyt3g+mirxlscc?=
 =?us-ascii?Q?bNoeR3cUt6d8Wo322z/2pyIAgZql+KR5/1cbWmhDVWDiTHsuEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DqSTfG0SZvJkjaSanXcpGMyYx7b5ukbdzgmXICiJeYZ2ePLFYuVZUCZ8R/a0?=
 =?us-ascii?Q?39yOBteD+eaTVa+IdHFSdy951nkiTxzSpsWPxOd/WA060+paacWPcH4HT8w7?=
 =?us-ascii?Q?YOxl7tLC4Pn1X1pAYXwnV85oQpT+ZwBFuRyYBUUwrmSAxRcFSRRMU5T1yl2b?=
 =?us-ascii?Q?KK0kKw+dVpbZ3O1+j0CVUEmcVC23LYvO41EFBEoEGfWJNWHCxFbVjpIER3YP?=
 =?us-ascii?Q?I7i6XLRHqmrLGEAFevjCAVU3iNUXpBsS7BaTrdceaJaK0OAQWf5roxb0b7XE?=
 =?us-ascii?Q?/I+ZQ1MBl5AaGXA3HueWXsLt3Tkh3+iU/bvJzyFbGH9/YZPIrky6K7Ohhiwg?=
 =?us-ascii?Q?3tDlNMiaQMISkBTFX5efY7lmAUJ7acmQlDZtpfFRl27YfqffaqJcmYPTZXjX?=
 =?us-ascii?Q?x4ZtozZwl9PvsNfDzYYZCR7nR3WYkSNLtEmveoSOXY9eHibyGs3TEdsgFvQa?=
 =?us-ascii?Q?EvzQEd5mpo0xmE+pbICSdyKD3pOItI/Yb6gBR/YfPGM3Jt4ysqrQA5YEZdmE?=
 =?us-ascii?Q?biSrH82u4YcRXGzJVoRh9QL5Q+0SVnNey/4szJ3NwAELDU2hrw0U2e5Qj63p?=
 =?us-ascii?Q?KxoZ7EVHCNFTDLpPweJ9MpE7KRwvXcwSDqqxyGfaS9GuQJMcV6iSOlNj7vvA?=
 =?us-ascii?Q?dnuQsrmMsCjevjYzehqewIQhroLae5zcbBaOdGmCyZo5eHEquW94bE4QFpFJ?=
 =?us-ascii?Q?5Evgk98LCD9td1bOtOdv1hU7YubyWJ3lQSk0MqsUnpbS7esqMasCFck47nfX?=
 =?us-ascii?Q?AyNga1+UDk5MipC6H0LRQI1l8/t+waDnA5iWktP6RZdHvg019XXmIgkcECPR?=
 =?us-ascii?Q?W/dAAgFsA3quuGdtL+QhM9uzTT/IKcxTZ/g3OZAB0KPrfqtR4A4SDMw15GOC?=
 =?us-ascii?Q?kJ2Wujz87H4UPp5UyEBNtY91EpXZSHyVKAKP/gfAjaKlk8AwB9fbEFnfAb9T?=
 =?us-ascii?Q?UyCG2reL6q6lYqMoXO+0ZGFyRJ1T58yMziN9EyXnSKep+BP7UuqgckzAT+cR?=
 =?us-ascii?Q?NsTVT3uXLO2hYpFxTnFP9HVciNFRG/vb/k8aLLXgFwKTurtsp3FmZqck9xI2?=
 =?us-ascii?Q?yCVG0Yq+IOUqe2QK3/HsBe6/P/njHs9uZpReS3LftPyAbB4q4heFoRI1g5Pe?=
 =?us-ascii?Q?e218DQAnRhchUXGhVCoxL68RNh/7Vp0fREPSCDavWSXCzrzO70FsO7gWBdLm?=
 =?us-ascii?Q?+jAMGuzBWQ/zMkdjeQp8HG4ymO6N6e5pL9nBeoSKt7k9vqD0W6dP0N0eEnMn?=
 =?us-ascii?Q?u6HOtU+n7mJd5+fNZ7/RTZyHa9w0ZyvBh84FlrqC5Iiad23Z5MyCDFhk4I4z?=
 =?us-ascii?Q?r3Ys3vccQy1Le99xco/0zFf7varujXIznPRUvI76iKsioLU4O9D4S1yTrmjO?=
 =?us-ascii?Q?rdR+ZFElouqf6wCA7bm8hSpZmkx6lX5JQZfUsff9wKQwQ2SGruEmB0f+GYpY?=
 =?us-ascii?Q?pvbwC/SY94BIarLvvW8vpRCL517JByn6oqkvOiww4aYcI7tC57W8fwzRrfU5?=
 =?us-ascii?Q?GyJhK9ZaeTVgMEWacuxdmIam7CnJuSG3kUgX4EQDR6DEi+MRTwXi4DlpUi3G?=
 =?us-ascii?Q?OaELYfTsGV7LlD/TGUT1kXZpXi3zoZ2QGDB0SgEGTmWLG7VMWMtT12FJSoVK?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5757ad-d496-425d-0fc3-08dc9d31411f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:05.1863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctX1btXYDD+EOfqkOO78bC72mMY3WKx00iD6GwT77MAzbUy6xLD1Bx5RYDZmua4lh65lXUUqZoabNDqBjZ32/YjNrsQ5Zc5W9XR0PuWA3S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6307
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

This is a followup to the patches that landed in 2024.01 and nearly
made sure that source files for producing .dtbo files use the .dtso
extension. In the same release, a few new .dts files snuck in, and
there was also some test code involving .dtbo -> .dtbo.S -> .dtbo.o I
didn't really know how to handle at the time. This should finish the
job, bring us in sync with linux (at least in this respect), and drop
the .dts -> .dtbo build rule.

Patch 3 depends on 2, and patch 5 depends on the rest.

Rasmus Villemoes (5):
  arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
  kbuild: Allow DTB overlays to built into .dtbo.S files
  test: overlay: rename overlay source files to .dtso
  test/py: efi_capsule: rename device tree overlay source to .dtso
  kbuild: Disallow DTB overlays to built from .dts named source files

 ...> imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} |  0
 ... => imx8mp-dhcom-pdk3-overlay-rev100.dtso} |  0
 ...> imx8mp-dhcom-som-overlay-eth1xfast.dtso} |  0
 ...s => imx8mp-dhcom-som-overlay-rev100.dtso} |  0
 scripts/Makefile.lib                          | 23 +++++++++++++++----
 test/overlay/Makefile                         |  4 ++--
 test/overlay/cmd_ut_overlay.c                 |  8 +++----
 ...cked.dts => test-fdt-overlay-stacked.dtso} |  0
 ...-fdt-overlay.dts => test-fdt-overlay.dtso} |  0
 test/py/tests/test_efi_capsule/conftest.py    |  6 ++---
 .../{version.dts => version.dtso}             |  0
 11 files changed, 28 insertions(+), 13 deletions(-)
 rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
 rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)
 rename test/overlay/{test-fdt-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} (100%)
 rename test/overlay/{test-fdt-overlay.dts => test-fdt-overlay.dtso} (100%)
 rename test/py/tests/test_efi_capsule/{version.dts => version.dtso} (100%)

-- 
2.45.2

