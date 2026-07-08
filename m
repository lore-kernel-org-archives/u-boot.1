Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E969C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4311F84A1D;
	Wed,  8 Jul 2026 14:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kgTT5dc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A154838D7; Wed,  8 Jul 2026 03:13:07 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC1C84994
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOVrPffgps8L7Jm9ZVZifqcW5H/3geULdNoJN99YYdic2r+ZB8AM8wu6qGhXico1WHbseFOl3zPgOr5gWwUxOOT3Glfh4V0+pN9nuwEoZZjSbSKI+Gw2nzEKHsMEO94qKQjAZ5X2e59ebTwyv182Km/7XoRQvUcSFjc5yUVapPToK6gETk5CH3avwDmDwZ40LQAcql0c1OkoAYoUIQ7CBWJrTlVhQOm7E6D3ksnoCl0whB4H+F9nr6EyNrp2WuWZ4LZnBQcVcN5Konk4x81nqtATGeTi5aHjFQnEa6sWwz2rfIuJ3JHO9j52dbOh+jXudTkYqhA0dOz65dZaKFySbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKX4iVV7W5K/ymLj7CKrzKQdCKbmiMxLeAlswpyD2cg=;
 b=V43QyZaI1UX69g2qstiiW0L4K0ahEmTHXO8c/48sDPBqJAdJiv+l1b2utew3NaRWgEpIGGrkgWVGQeiHvRZypFQVrmJfY1V6DJk2Y9CIjBnkHVFRyXqssE7grO8yccBtkxwmw8mXco/wSHXLhmCUSN33w1qbfOqnT1IehyuxPw7kqKHGCjkjuhBRQbg8gUM6wCD8oNu5Q3zwsZa/4qDulEghmI4keOs0qK9YrK4lb2lx7D16yEZMg875aRg2pVo9MkJ7dI7fgsxs6ETuACiByKtJCqAXTi1lzWK1ivX0oT8Vv9uAANBz0B9zGQmFCIgCY2/mZhKR/Gm7p7lg/qz0CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKX4iVV7W5K/ymLj7CKrzKQdCKbmiMxLeAlswpyD2cg=;
 b=kgTT5dc2GxwmGaF/Mn+2PlIVZ/h7wniu2W60jU3CiIEsHJ2XVqzD9XqtOgb1TnJFFatV8KQLBf85xwJ6024dhKNZfxyxog2G+rHbuUGU6nsu00DJzDiGINUR3ooodAfd+nY47UiOUcwbEIrubWVgRmyg92jeGSZB6SOov+sKG1IXq7/muaWno6IGc+gea8xkMkDCd08sToa0bKYd493mik2rnV+F9k+jbVpnmgKJ/BZWI//1zNF/s8HBklUHzArP4PXKzFpEfmMfxBIDJFwDlB7mD0i6oKqve7BKOMS/oqrEkMm4C377S3xEh3dsFDmSLANIe5Xu1B10GiSmRcSK+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:02 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:02 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 03/15] arm: socfpga: n5x: enable QSPI mailbox before DDR init
Date: Wed,  8 Jul 2026 09:12:16 +0800
Message-ID: <20260708011228.15613-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aa678f-1cf2-4b16-2d9c-08dedc8e0ecb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: pL7D6xO6vYCk1gGgUWpbh6VyTW71hV3/hHTb2rytHer24QkuzGjVjnGC/O2cp5oZvSG2HTdtA9LbzkAEVGhrWGPhvvQgzbMxY4XJVXu5hP6nomLgZTyqSdDukz0TozaXOxwLL22nuqLZnSdSYn4fMZ9bRp9EGv7c87xMgLiIbd2gC73yQYnk1a4SeesFwOuvUYGgJwiRFvgzW5PMVFYOTI1H1zneD8n61al/OF/a3jU5G2f7B68n8MqBIZSKsEjp9s3RKskKx1784pQzM9PXzXqxE0m+ttpWz8kai8d1aX935KDa6kP6ii3qM7b1ScS7ArGWWLnMiU3S9DK9qtrudpFwT6YKnSGGCS005fUGN4N+rnmYb6xre/LHSGpxSFoo0Sk/RJ5q4iup3ugt7TuoNUPhfbo1qfqL6wPl7MjQ/NimvVdQiBF7Jrz4YT83m1mgNLfLY1C03o1ZJLiEq4SC3LyXfQK6fNgA4g6M7wbalXb6EanpiebXAXChZYJk3IrgwuTndwlArixKJ93kM1+5+oszEVYL1B4nGevAht7hphDQYrAW9/fPYz2vPRSQiJokT1+jd5aqPmx6k2Vrl+iRRHF2B2hBiJvTqcb/aXPVYtjjz/VvInapEnp8qJ7j3hLQwHPYYun5Mc/NdMf0FSU2nmzSFILkyF5cQEEhSQbLYbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FtijX8XX3RvOXWcpKXkfX9jpAA/6Kd7iTXMu5moUBfIX9elxaD1Afwqhwtag?=
 =?us-ascii?Q?++e5L5n+yXK3wTxH2O24V8EJIfGDJqhCh+98/oC6Lf5L4LU5TUJZIjDk9FHo?=
 =?us-ascii?Q?PnpJJRv1SHWYbNhTcz15XZghFhmPyXrBx0cHjtvfkDG7FdOghSylE0ufR8UQ?=
 =?us-ascii?Q?mTYdc+Yoss/PUIeRqBsd/26AT5EQXJ+L9A+61cVAYnyRHrr4bCDB7XS/hbXs?=
 =?us-ascii?Q?59i4miyK5ay9Lhw+NfOn5BkbS32ArIa4td85zcWOwQNzO4cVJB5enidwsFgK?=
 =?us-ascii?Q?nUBqjqa7HU8xYJ/+HrOoeA2oi1+WWtK+uu+azBOrp1CLNjObQSPFEtq6t72K?=
 =?us-ascii?Q?SmVmyiWiHTXgPvC5Z3lJV7CbRUR0jGt/HZ6E178GFa3LekUBFsnXZeq8V/MD?=
 =?us-ascii?Q?ogNBFiGCPcwWdHdvW0yIZD5JZVHwUpebL7wgwiYXEXbL8OpMdXW4WvUgaJQQ?=
 =?us-ascii?Q?XWg6bxugl7FGajZexg8Y2hXDQoA3HC3LwmDfK3O0MpHxY+zjzS3x8n6qkndl?=
 =?us-ascii?Q?jHrIVFszGiCP83uVW2JColaRdyP366pcg8DtI5dAIKING50RUnxyGrh8ticK?=
 =?us-ascii?Q?UEGrY78CS+GaV4d0mnCJ+HWqiRshz/4XZ9gs/Mzmaso0o+16aKoJDtCDEkxE?=
 =?us-ascii?Q?yZ6lrKgJdciBEesFuMwfpQ6jI5oMT/aOgkK4GNqmEGaYrMrHl1DogldXBW6H?=
 =?us-ascii?Q?D0JnUUHv0sFnkPbL23Nkc6q1Vof9nymvHFBWwP56ZnJ9fEwSO/yQ4z89raSO?=
 =?us-ascii?Q?4JI8ggqEkZtPXfkQOObIGvxKFPtnNhPbCe8wRtEiyRLUXLGUrsVuB8srCJNV?=
 =?us-ascii?Q?61FCpdrNysC/3up0SoVzKyRvSVFVPCGA9mbj++yccfXCJuNiL/M2R1cQxg+M?=
 =?us-ascii?Q?CoObE1zA7IY+x5RgeHdv8BJGaqEJNtKHWLdhiulBceXunPU2bUjRgYe+uXXM?=
 =?us-ascii?Q?/bP6B+d2vxSucP5I4VhYUs52+wM6j+KRGRcOEsm9dwT3KIo9goOVgAor7yq2?=
 =?us-ascii?Q?DA1kTZxqzYo7uVEE314WQP9jk+vvOvWeb+Ekr4CETTG1mVWdt12cFQBFwHAF?=
 =?us-ascii?Q?l01hFZxe12Mj4aPgbaVSL2eNOQL9RgXoeexQITI2vcSy4PWJ2SlWktnK6LTQ?=
 =?us-ascii?Q?nWg9Zw0otT6t9W9d6aZuW2JkkMkJpcMnl232m5OrhM1dVLgIEzEOiCBCe+1/?=
 =?us-ascii?Q?03Ww/bBSozYZmS/sNU7fgAlQMqKRAukHWH0gvfseykE5I/zK2Ngq1jbD2pwJ?=
 =?us-ascii?Q?NG0mWwqfjtYiJrs1X9lM7vy+1R+Ft//SfvD2sDGc4oQ014NuxlKerqItuHxm?=
 =?us-ascii?Q?ri4J+r2ttWPH6DcFzVppSSIZOmiG7WHamvdiQLp4wRc/7J+F44TwYmAv1hf5?=
 =?us-ascii?Q?9sBIcxWHVVO2WER2wl5R+1zhJnV0ZjlWqj8JCwHZuAABUwh+GA0fZSoaNbfA?=
 =?us-ascii?Q?GJO26W0u9nv4NVmFlJg4QvFo1RZhUeQo6LhxwjNS//OPSSM+xcaMVWGinzjE?=
 =?us-ascii?Q?i1NGh8AwzPfTE3kQ6kn/OxkXi0i/q2IQSEK9oEfqHgCHmyf8D7wHuwO0gxEy?=
 =?us-ascii?Q?mGDw9wzwif0TQfYELtpeww19LrskGOMWOQwF7etrKAr8gkuVV24P8HSnxwNX?=
 =?us-ascii?Q?YRpdWyYm3Gu79eSDyTd60lBpvLUhxB1/rOw8mDnnuScMQX2LF8imkeIuDD8k?=
 =?us-ascii?Q?Jyb9yWiXABcv9b3if8EYesIytq1EU7rK2Sl8upFeW75tjfv9umrCEZfDbLZV?=
 =?us-ascii?Q?bDEaH9BizwUFCRoVnyNaKItUdTU6CMA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa678f-1cf2-4b16-2d9c-08dedc8e0ecb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:02.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyqMDg1TmasO+rTewoaOcyLLTtDd5Zz+9F+hXi5ujmIKpY6wOYA4hlmE8N/V7aYLRU/k0rDIdegq34hfVmBGGgymzSDzs3ZVtccw+LUOH80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

Move the mbox_qspi_open() call ahead of DRAM initialization so the QSPI
controller is handed over to the HPS and its reference clock is
configured before the DDR retention path reads the calibration backup
from QSPI during DDR init.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 8b03d047f33..0810aed6597 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -104,6 +104,10 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+#ifdef CONFIG_CADENCE_QSPI
+	mbox_qspi_open();
+#endif
+
 #if CONFIG_IS_ENABLED(ALTERA_SDRAM)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret) {
@@ -111,8 +115,4 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 #endif
-
-#ifdef CONFIG_CADENCE_QSPI
-	mbox_qspi_open();
-#endif
 }
-- 
2.43.7

