Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C520CF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CD888FE1;
	Thu,  3 Oct 2024 23:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="esPFe1zG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64ABA88F62; Thu,  3 Oct 2024 23:28:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3577C88FFD
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJiFoO3ywYRBdHf6VUOzdEnzH2EvgQLg8XMNPVyBcdmPhuX3bNkwGAK0ftpQr0cnEdm/x/EwqFAuy3S+M1kDSGBs2X+RGX0Q6Gnv+Nvs2kDsol+owf5unUeb1gvUp2XBEtKFmD5wzdKIBESRXsGifcvKZfFMF0A0qnn9dyE2bBqEfsDDtGEScMU76YP9bxoq32KdJFj9QSN5Ppk6L75W9+BYbKemXeFPaMaACrDnwmqZTe70e/jKzahBcO6Twqqjojw6H8aOn4CzSFTlBzsmskaOwFatVRdHY+WKIPIbXn8lJTI+b78l7zJSGTCGTJPfzAC2UMYziXwNZ4fkijnqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FM4KAUg4zuJ/DMmExasJ+0M6jVNBjg834rR/bQSjOYg=;
 b=mWeeKXVysj3swVu9DqY45u4JGFAABIedpJFSPJTKZq/WYRpWE5uwmSEkgy10qootOo8I7wAlrq+eQ2Z2hmRoe4FIpyx3cZyZEs74YZrI+AbBrfuUNYRyikizn+5Ce4dYjzr+oVbFXmI2kARLH8LS3+l4abFomkIHHwtc9DHIMxM4tDet8whIN2V0ddKXoFLDLpDwy59lmo6a1fOvUEpcPLqdhEq6Zf+Ze7VwdZ0qt0fVxOA2TrnwgbL9IeJ2uh8Nnh/1XWQFgeWDhYc7/3FuC3O7LZeZhJY+j/fnq37dW/Xhwse6hu2Bzx6t1rW1Dq+KbvvsWV7qIbTbbT8DGC6qtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM4KAUg4zuJ/DMmExasJ+0M6jVNBjg834rR/bQSjOYg=;
 b=esPFe1zG1I+4JoNdGt6ij0OlCqMqo2LVIzWV5dgLx0K/vZsV9y/FxgVfIZ+saHheZLS3ALO7UIl4Kc3NVUcTUX9UbnYRvRnGdXsW+ryiqXWLLPWtcVFr0eRsZqetLed+3xv3n+KnHOxBasETuu9g8mPM90Bc/ci0CKx4n/5S3yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:27 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:27 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 13/13] global_data.h: remove unnecesary include of cyclic.h
Date: Thu,  3 Oct 2024 23:28:02 +0200
Message-ID: <20241003212802.3810-14-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9479463f-974e-4795-5a24-08dce3f251a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JwKdXyfP0iYRxsMss+qTLoRVrR7YHh25MOJggQ5PVGyfJ4sXz8O38wX7NWlJ?=
 =?us-ascii?Q?ucuytZy8kb51C528hiErMM5V0wd9FHiOI5HtKxARPn1DTJwdK3QAyui2WQvA?=
 =?us-ascii?Q?zTaPuihzHQph0vo2OkSYbSShKy7OTzIn2QGzyWu+lQ66/yIb16FZ9mnYt0Is?=
 =?us-ascii?Q?Jk/izquRjeVrvWcIFWFvfbU3YYl5ML2ZOuwwRF7PCSvfqPtv/iAQzvBGoAve?=
 =?us-ascii?Q?vOqhf1F+62sYDyZmesKpovLK1IMDvQy7I4AiynZfxZaUMUbrCTw2izLTb7wz?=
 =?us-ascii?Q?CJ6ft8KVTGIaUT4g1PueNYKGxrNy22vlzmJzYSrLfjXcZxjBrob/36sMZGSr?=
 =?us-ascii?Q?MZkL6ZMwVxf2awbLFE09mf6V4OLzL6qO3iQTnbk0yAc4EPXKHeC7eX7l3/w+?=
 =?us-ascii?Q?SQ5lB/0JOYEfCgxF6RJBAhtKX5bISvT7E2VmUp0ZGeiLJtLWgwGmpIch/t9L?=
 =?us-ascii?Q?EfPojBrwbZp7hLYecs2WuX5FpHyyZy/C6SPr4t6ntB4is+eZdmd/pG73nvyg?=
 =?us-ascii?Q?uX0y/bnLSXmCQoP5sZXKCkFBcA/ab5cnu4D7pvwlGYz+7s60GmcBWqxDB72v?=
 =?us-ascii?Q?UjZxwAYuqFaJD2dAdO+OL5MLRznqMv4/3pwkgQFwZ0f6WZ+rkDLjnXLe9SbN?=
 =?us-ascii?Q?POh56Pwl0EmgEOKmlLGVhExitdE9ajmqtfhsTvJo+blGe+gHSSVR1noQT7gb?=
 =?us-ascii?Q?xmKknHUMSPKiCpfIIUo2nyV1QyBIhAfnahCcZADsqGXcXSvA0CavUIF1VozV?=
 =?us-ascii?Q?AwQVr4qLgiikUSAvuzJNZWdQaMZfoXGnwVmD+MOII3ajps0xdkcTRgiCbkQK?=
 =?us-ascii?Q?D99ygJlk6/oVkM4pz8UhbfWoBgTdr1klH4/256mh2lCZ3jIHahCmoCTvzHOJ?=
 =?us-ascii?Q?2guQTffqqivAodb9j54M1E/VuTHSY34U+LSe51phk2LnKcRyXwfZH67vy8Ky?=
 =?us-ascii?Q?4sXwXpm6vJjS8reNXSX+st0LR2tRl/FHkFHdOyI+zOEqnm05/fJJirJzjkOx?=
 =?us-ascii?Q?qkO4P/EKAxsu1PJNw9ppB0XPik80FqjBuwFeQniNZ86Ne2BbYzOJDwVhZ3ki?=
 =?us-ascii?Q?/uHp0F9/DR3vRoSajovACRiu8wje0QcE5f+y32RJ0vvEu3IqB11nkXhvuEIk?=
 =?us-ascii?Q?GEPV/4LP8O7FOJn94iQiLnu6h7brsce/EFb0bqt2ylzYT52y/QEtoke6IST5?=
 =?us-ascii?Q?wYTGcZdS0SItKNPAZztH8Ew7yR3wjOAZUnIKkG18kLSVydJYuxczKBvjU0ka?=
 =?us-ascii?Q?mT+bwu0HFFVig2f1PNChhosULcpoLWR/zwMARk3t4pho3FJ4+/7taSnnEGtx?=
 =?us-ascii?Q?qM5Svm3XZ8K8R/T/tFbNqjOetL0yDp4Q9/1jeFs9HximOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNIl+SDe7VrAhoVUSajjrSzI1F6kwbeoGNQXX1RnTWnPhUZPH7qKLXM/HPTr?=
 =?us-ascii?Q?csE3vU5Ain1tmb87ZMRlMo93aD++O0evcS8jh7ebzCJjMvFp9rlWNHK6Y7Oy?=
 =?us-ascii?Q?I91IRDjP8E+9dFO129NTadCcz048aCPRwyXLsJhbLf6f7RDSwA9VreXtXCIS?=
 =?us-ascii?Q?vS03L5g9X8IlbFdw8QtIJzD+vpeeLLSfMDcnioPKWduH6eLs1TrDRcpjGDuS?=
 =?us-ascii?Q?ydfxnXnp31A8BfgLDzhIeMkeq6BOmVn89LMakFn0lv3zc9Ymr0U9qJaXICU8?=
 =?us-ascii?Q?V4A+diaiCqurWJpCKQdk1rzOb8Mb0CecAtZ0e7MTC0YO2bms8Ugymg2CReJn?=
 =?us-ascii?Q?Z3kRw3BWADk1AxgbQx6odZzEff5uKz9Xe2kYKm8lQy1i8yoz3zxG5xEsowdI?=
 =?us-ascii?Q?esI6+OKjYS66W9AFIJn3uctKLPJap+MzzhIdW4kn7mO4y00oe4J/5A7y2FsV?=
 =?us-ascii?Q?1EttT3tAG6QOnu6W8bYZT5XfKq2NqRMRVK1lm9vOH0oCd9++5L5sun5ezWeF?=
 =?us-ascii?Q?REi0juGyeagmmDfhwlvBsu6acJ1Ljg05tQegItVnSsolgeDzkQCHWYtZj7Sr?=
 =?us-ascii?Q?+HoaBqeShD8OVp7ZIe9XhPinoSTFPdXlFHxBsAV5mraA4FJpEVIlPjaR9lDb?=
 =?us-ascii?Q?wKd+AxMcYz0xwvM5MLWebIyMrLXLGy5VTWcA/0MzzrezCwMLSYPfhIUoiPls?=
 =?us-ascii?Q?RIEXM5dlayE/hX33JulUWnXIqvLtG2qfWCX4rJN4wf04IcGN65coeNNKZsBe?=
 =?us-ascii?Q?2MTh9hZ5hrklyieVGQHNixzVFkr6dijFnzfxFn8vd0Ba9nFUtDpWSR5YevGn?=
 =?us-ascii?Q?vekAA/DYwgzDGqahhTnThx2q/vmn+5U9fLC9QszXyb8JtPttnC1CAjN/SkH4?=
 =?us-ascii?Q?wypsMGrGM8yBG2NSZkUJjUC6xZI6m8yW4BYBKor6XhGgZj99X+LGAsQUYR2Q?=
 =?us-ascii?Q?Ny+HaoJDviaiuDgwqrUuLBTXQYTR8EPilNOio4otk0X/QTVMZR9cbJ8rvWrL?=
 =?us-ascii?Q?osmv0nzFzILT0+JoBe24X0EQc/Kqbfv3n+gwqzGHsEZyHO/0niLJ+DIbDIFK?=
 =?us-ascii?Q?iGZoS/TqeBkMm6yWWsaupS4FiIKKNC4Ihm+dZ/hFYnzXkS3Y9Y/gNKe3UcKF?=
 =?us-ascii?Q?Zde4QEzoT+CjrEK5ngWfRStUk2rceXCzQ1169wxKVC+8U83JLhyq658Ygp4I?=
 =?us-ascii?Q?hjQloBC0OAmDaJfVw9uBNJrH32MPIk3S/8ZZWciAvbERr2ZOycrYytckjAw7?=
 =?us-ascii?Q?UCrLRC9oUThoDSzIzIiGgLU73CY+mK08xcuoTD2K037wdHTU2aj94ppBu3C+?=
 =?us-ascii?Q?muuKMqb7uxCDlEJCwyFcJ/bOkvLiiaX0Y+tbmGw/U/37Et2HOrFG3ZK2zCb6?=
 =?us-ascii?Q?0m4EQTRvUVOtpQKQ5/Qi5JdxPnlTRVSjGhHX2MTYy40iCeqEIljIQsf/xkRy?=
 =?us-ascii?Q?4WONWaSJIlGBtbGXmMZUhavdlTQ+zH39LMLvWaHPvyy+T1IfUS86S8JdPhKO?=
 =?us-ascii?Q?HJ4w9L47NpRfRXiWiA0hVItkodFE+mPQ8C0Bu0K4AmN2yHZrUOpTAKTJ5XtO?=
 =?us-ascii?Q?zwDekMb99hnW5u02yXQ4JgcpGnwoYklmaL1ZozwPdnghsnlUgkVMOu4+Ilgp?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9479463f-974e-4795-5a24-08dce3f251a1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:27.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXE2BKqA/4K3q0J97Wn7XUbyUeK9MmYcvLd3ofBYTyKpvMJHu1mBcCIYPFiP6MjpgpaEymIKhLDkc7mi/wCLqfD4ufdih6l96i6OzZzy15A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

Nothing in cyclic.h is needed to define struct global_data, so do not
include that header.

If any .c file relies on getting cyclic.h through asm/global_data.h,
it needs to include it itself.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/asm-generic/global_data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 27aa75e7036..1570ad8f0c0 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -20,7 +20,6 @@
  */
 
 #ifndef __ASSEMBLY__
-#include <cyclic.h>
 #include <event_internal.h>
 #include <fdtdec.h>
 #include <membuff.h>
-- 
2.46.2

