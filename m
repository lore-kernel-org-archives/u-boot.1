Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2057AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8026F82F42;
	Mon, 26 May 2025 20:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jnr/yHYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB3382F50; Mon, 26 May 2025 20:03:49 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D180F82F35
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwgDOWOlYU5/kF3oBOwM5r9EEHEDwl57TCMy8ZnezCA7nHrnpLoJbdcKY5v2Flmgv6tg4Ao6SyO3OQqWc6LaHu2pRuhkDh9rHRqt0jgdNiDDX50qyzudy6sPjNi/XAmVfmf9KaZKGoHuNdrC9Vo+WYyX0MEokFgpy2GxHR3eCRnxQjQqIw7hp1RCvw9y4LPhungD64pYeOE+EUg0xarCVACvzJZPMLwjb7DJttUXeUxLyJ56h7L7xx4W5rM7xWWlcZCY2v58Z8JY0MVW+0pcbPBlWa9jlpI/+32C0nOxzK474VxwvnBUgGz/DJhr9DFJNAoOX/MeXCjWVJlxb3BFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDO85wbjYwwBjycoc5ThMwSGB8IbBb9mNGV3aGjzRo0=;
 b=jotW07Q4I3XY8CQ275Z71NDC0ixsHBKZYB0/XQlDKHSZhCcpR8iPvKm89f2BOZyTGTU/hd+Qv03u5YMijAmZTOwRHOjPVujRk/e74pa3VlBOhmO3UfSSzA4kOZVQvXHLjmdNuDNMrbfOpIju40FBBSKoRWJ408p8Hp23/zXxlidtVlNK16k2wqH0B2sd2HoMvwkGzYbdGU5e5LWuO8T1/JyJzcXJ9Ojl1TpPwrRdg1mkbTSaRF/2AnTauUdqqT4GSRDbLalSUAw4mMl+tyFoxtRfK3DWm5Hah+4an/foA/8VwVdUDfoBQvrrLiVUcOYTN38dI0Ois9AeVQN91Ww6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDO85wbjYwwBjycoc5ThMwSGB8IbBb9mNGV3aGjzRo0=;
 b=jnr/yHYeyLskBKj8vahDqCTtr2Sk0P+mE+YNXPFkqHOpWDemeRI/9J0PD5mPn3Kn8ps5tBNZC0hpuUaVKuyJfsO9hgUOevDCcobtOT2cwAPk+NCnI0jwSU3tgDOPFas0XXtRBFL2gTufpgc8qTQ0VNZUBksVE6/bVos+xFzwbsZEbvxveew8NiSCF/UtDjQYKRAWz+p4/lfGJmgOqZNSMlDusYs1V2PLtq+JVvDadaCtSEYUaP08oD1OjDwq+uXVUkYjnmtstSDqBnvTY0ePk+5aTt5UBe0Dj/zcbb0zgFriD0wrSjTHi/u1gf7D5d+DGjp2CWNz8/mg2dRSVNDh3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:45 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:45 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 2/6] drivers: ddr: altera: Add valid RAM size check for
 arria10
Date: Mon, 26 May 2025 11:03:24 -0700
Message-Id: <20250526180328.13644-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
References: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a9aa3b-6376-489f-8d78-08dd9c7fa7ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dZlTjRnvRkLRnrcsUQYXZ2x//OTVTVD51o0wLbIxFbqxhEUEzIpn688QcWX2?=
 =?us-ascii?Q?oKKyOaX1GkUzrvUIuU52JrY2FA2Qx97X0BuZNtxsevlLJcFhfkR5s3tLqQY5?=
 =?us-ascii?Q?3/7S9V2ch5WlRUA9vOPL6pWpSnKdckn8SRaFIIHcKDpQBBhlY8vVUMgVdZeQ?=
 =?us-ascii?Q?7wveeCvQd1u90T6apJTmCZxsVIS2+sKj/XoJYuBCarf9Z6vOzjvhVWqf9Rm0?=
 =?us-ascii?Q?HYR0/uS7nV8zWulJgKS83rZhXb5lmKTS5biNFWNZt6gv6hriosFe/Jia/ZkT?=
 =?us-ascii?Q?9c95+WPWLN2soc3MGkrB6XZc9Em9p3p9ZHSGeu/mv/NrRo5lm24W1qvLkczO?=
 =?us-ascii?Q?3Za7zyAHFhsmHOjNh7tQtURXx0FRHxWH0GmqQlC2JGH3A7VLQjSyJ3QSWeKi?=
 =?us-ascii?Q?8Q9OWqWPPp24qKGCc9F6DxDFymnxDNSmFQCJfrRImtUtD4kkoTwB9f5uT6GG?=
 =?us-ascii?Q?3XTAW4WYrHZpwww6a/Hr1qMl91nnAJ+bHvU0EyLSIspzfnshbYEiS7FhBdIz?=
 =?us-ascii?Q?M7pOUswUSiwPbWjJsMG/Arfm8nc6k4p3srnh5/e+L2NLdRloOpPj/kkHtz/2?=
 =?us-ascii?Q?3F7w6IZe5O2iY7JV4akj5Okiyf48fdU2TBmkuFpgPhmclcQF4tiuSz1Fe2jI?=
 =?us-ascii?Q?W41Xqktheo+a46tYEjOmyoZcU1O9ty+PuZSfs+mclC1nb6rqGnIIWjiMhLRp?=
 =?us-ascii?Q?HEvNe1HwpNalVZd3mLhHuPeC/UBXj3fn6QGe53p2m0OVLBJAgNQ4QoAjQdzy?=
 =?us-ascii?Q?MUf+R12lbJTViJX/QeRizCCrPmdSt/8PnvC+9OEfJumry/bGlQw6hD1uMNSz?=
 =?us-ascii?Q?smrLnqXBkfylNwXmCBN+Ih86r3gHz1pLZfFFKVV+KrUpfIrBH6ug1khAxl5v?=
 =?us-ascii?Q?HlAMo7EJ0ElBkNIjvnnRXlEntEOXy8LAJeO14CYtfveD/WLg4TJTq9cTqWaf?=
 =?us-ascii?Q?G8dI0k/Gs8sL+klPJ0LvXP92YxhTy0XzVXA9K/5xOS8XEdyXlUMGaZNybBem?=
 =?us-ascii?Q?HXNVqeYrgfVhalLNCebQJKEqeT+GT+R2srr5cIE95LmI7xf74GGjQ3IJkpdq?=
 =?us-ascii?Q?jGiFgPEt287d3dqmUrUZVxvgfSiLCAWWsSwNTSvcD9/kCrxikHrAZ5qRaef6?=
 =?us-ascii?Q?a2idObpKcwQpZUXEt99JWx9a9rZ1IPjd+5Rai9vG7GDhM3eM9qrCtKoCysGl?=
 =?us-ascii?Q?6DOJzBRGTvO/EV5PIrqQaoss8yKLdZopAk8nXfSKo9wj6cjrFLRAr1eG7yOa?=
 =?us-ascii?Q?/3KoLimvVjl3h7ayJJg243NttAbf04SPgemZYqZVTCJupOf43hqpnrGukzNV?=
 =?us-ascii?Q?/vvJQwEKEd2J9n02BqpHgRXObHm0R76EyP4JuRGIjYB7q+aWTk+WSQhCm0mW?=
 =?us-ascii?Q?o5+oty3f0lgcV7SIWn+8kktskeQg3t+C5C0bHIVLD8M99SXSNZvu6ptBYGz6?=
 =?us-ascii?Q?70TFXwYIxgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJxQPJNlyCWngftxEYSU8iCGRi6JdCZjAbZXXF1qqESoECOpOAiPgBDw5oix?=
 =?us-ascii?Q?CV5YgTs9zLo+mKWxtm2o6ebWr/yC9tvyoA0rECAZUqOIFCzUYUUy/InkUmLJ?=
 =?us-ascii?Q?aMjUi26ZB1D01dMGAYa+Vq6HRvMWoCzJUXplYCcDhGQ5bEYpmuxL1WkZVFdW?=
 =?us-ascii?Q?J36AYxWOOEDlrFt0KuY+814+5kEHeZkKqhjicCPiW1671yu2EBVfHXX6uWlE?=
 =?us-ascii?Q?ewCdxCl3liZIeXVn7Rwt9C+S7IKivZ84ArYfRkWYUEmgQpXlr0TyupHhVlo/?=
 =?us-ascii?Q?EGF9KRrFQDaWa3PnTxcJ/+ROer56WY7mzaotb8ZLKHb1+cl/fmv4IVc17H8C?=
 =?us-ascii?Q?h1m7PcTJHbJxAUz94xJKMhkkFrimQvWiJMTenfsEQFykQTiAclDL9pRTNGXb?=
 =?us-ascii?Q?4b+tHymKGATaw4/vKj6BIJcFkSgXAV2TzawdoGsj67RzLfhvBVtVC5DxgdVX?=
 =?us-ascii?Q?36KNznizvZRyUtiW2KcOheo3MR//aH+9d5e7xJ3hPsoW2DqjTT4jfQ9Hawit?=
 =?us-ascii?Q?Ve2zsUaJf8qGlwS5vI7fkbwMwlbxcJ/QS0j1MPZ0bz7ldOFddEOKXsSnqNOi?=
 =?us-ascii?Q?M5riMuy5XykAdVPw+DsbayyQ5v6HG31sPu7MUPxpGNwidRWR/rdg53EA3OZc?=
 =?us-ascii?Q?85wy3V9FKMuY6f7fMhY5eLoiQQEfg/Hx1q14G4WKCsYMLwKHjtrPu3s90uTz?=
 =?us-ascii?Q?hWH8oUNFNNQdh9aY/404rGeZTWBFIxe4TaWX8MxZ3su8Dr9MQxaEC/3aBOhq?=
 =?us-ascii?Q?Brth7nlYYX+4lo+gyXvjm9Y2doUAWM8XnYazvxYlpq+W/OyX8pmZashtHO7w?=
 =?us-ascii?Q?oAzv+8Sdab/jE9i/xtp948B6s6aYdBKQa5KVi+ZUn4uNghT4MViF1URLcKpA?=
 =?us-ascii?Q?bzDrJ8mkk+UR+99cwqeOBXX1c8r+921QK0GfO3uf3GopOBld5spDvLPVDBYB?=
 =?us-ascii?Q?U3kppK686lASgLeNPP08oU7AI7hHrjmI5cRJX0yv7wt3lha8vYKVbKJvNQ5k?=
 =?us-ascii?Q?/Bl0MmLCi4pFpkLb3Ws4p4Yq5HGiDjUi3RI49jt9gOKNW5CccePnND+4SM/6?=
 =?us-ascii?Q?GVrVEvCv9XiJptozEUNL6g4BYcZDdEy8RHBlDXhFHNVlvHGBXYcDInGoMwNH?=
 =?us-ascii?Q?wc65sdaptk2JGlmBTP/Vo5dKQ56AHGMt+JnipGvzQn9sZG1sh1idJRMuLXg4?=
 =?us-ascii?Q?npr7gSGtA9w9yBy+BVUdlk6vhfG+K5jM78VUy6/x4K7+gcHV6XZE2bOKX6Gu?=
 =?us-ascii?Q?k7E6VjB0mHvILNPcATMv4WtyT8VlC3DGM9EQjmPBrau7fEuzkpF3TWKm1yBi?=
 =?us-ascii?Q?4YylGBgEs5eYLQ7Y9yeR+BGidNpQKkmTtw0LK5zIRBR453RNjO0FJUZdcloX?=
 =?us-ascii?Q?FC6gr+2bpGRVckiosnoH9/gokX4keOfHcQb8NZ1XbYaIW28siTCdkUY7cPvu?=
 =?us-ascii?Q?Rxw1+JitHAmB8MF7flhCF2Ul8MrWCUUGT3q7AR35oyMctGhjHhxOz3BhCjYP?=
 =?us-ascii?Q?rAG7ZWBaCOko3ZwC7Fx/M4ANDPv1ZPcc/b2I5rRkPcqO4dS1fsVSMazFAwzM?=
 =?us-ascii?Q?175nt0Va+xhjm0GEXkLgqp+N729X2AvVRJOLHaZ8VKPQtvbgM0K3ShfIjW79?=
 =?us-ascii?Q?/CbUUga8gz6KvJ6GBFsc59s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a9aa3b-6376-489f-8d78-08dd9c7fa7ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:45.2233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBmU5G75b3GHg7i/UZhkP6A4YZjyVk9p5KJ1f6MzMXO/aClHYBcUmaBVcNw9Y612yFbVYf0nb17vo3Qme11HuuyWmOJRhZB8lHcO2QHADKaR1AbERdlZET06NrpousNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6379
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

Add call to get_ram_size() function to check memory range
for valid RAM.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 088dc1cb33f..7d7bea153c8 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <hang.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -668,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
 	return 0;
 }
 
+static void sdram_size_check(void)
+{
+	phys_size_t ram_check = 0;
+
+	debug("DDR: Running SDRAM size sanity check\n");
+
+	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
+				 gd->bd->bi_dram[0].size);
+	if (ram_check != gd->bd->bi_dram[0].size) {
+		puts("DDR: SDRAM size check failed!\n");
+		hang();
+	}
+
+	debug("DDR: SDRAM size check passed!\n");
+}
+
 int ddr_calibration_sequence(void)
 {
 	schedule();
@@ -722,5 +739,7 @@ int ddr_calibration_sequence(void)
 	if (sdram_is_ecc_enabled())
 		sdram_init_ecc_bits(gd->ram_size);
 
+	sdram_size_check();
+
 	return 0;
 }
-- 
2.35.3

