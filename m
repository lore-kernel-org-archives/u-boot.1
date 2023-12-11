Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B8AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9983A87772;
	Mon, 11 Dec 2023 13:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="1axzYEBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611CB87755; Mon, 11 Dec 2023 13:21:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCAB87757
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rr9zXo0XjMZMC9nAuBNitvg0QzKQzzOSbensknH9mIqxIYi3if46m5c3HPfJpg/g5/j2o09o6wiFSR22+UuQf9guCcLVmbx5tyATBrHbR5x9KVmv8CnEJxk3KwOrALcPHdcUagqTxG3r1JHia3jMA0vDYadVgJKs6LIhwfHBKpsoaP3Dd/PszgIn3MiyeVeQARvsGLR1+ePTZxSMIyxbT9gwiOarizothaY22IpjrH0oiyDEKFUZoFpC4CXEVyu35Lud6UTFMMlhMeLG5TltafMDf+ekEdVIgwXPQ/pIPhITTS4OLLHllGOc9uO+gYJBceRiXPpHCW3OkbP74VsUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EL7/GpCJYNR/HscYasw6xPX5GxhBYseAe1NQnRn9StI=;
 b=Ar+l7+GbpkBQ6J8CmtzeEkfRO9fE8eTfMeIS/JTErqLBshdtOiHnz2RrENIzr3TGDWMC8Ml+42CIoFgms3cNE6vne16iA/9wfX4pTfKxb3hXjQnJU6oV4jASX0mNVDPracHPQWwBcu7xwxIjs9wRptQk+QG2j6aFZJZQQf+sIaEwFVKtOvaoej9cwL+/JHw0YUvegplW/k5J7fHEymNQtGjtfOHcED4FOghYy7EL4vY3YIpKw+NLPYHMTX45cGtykDGdVq/TlzkqyeoxPRagvp1Ih4u9+9byjdEY72R9ScdUlYIZe5Dpan6tHdf1x7/1v0ogzH27nVrVze2AsROFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EL7/GpCJYNR/HscYasw6xPX5GxhBYseAe1NQnRn9StI=;
 b=1axzYEBJBUnDnn95MgIBpKfz6ZsgCtxIhfVLEqvM84+lM5A+WGpydWzQF6g3pBdbcM69Qjekjxkxy2Zmrred8eOHmz6/sfAHFZaBaVZIj1254lwIhcn/3WqCFaiZSxjCcjPQs/Pz1WiLCaIXEGG/H4AnpXxB4lIN+5/fK4tuxRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8168.eurprd08.prod.outlook.com (2603:10a6:20b:58f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:21:01 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Mon, 11 Dec 2023
 12:21:00 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 4/5] lib: vsprintf: enable '%*pb[l]' format specifier
Date: Mon, 11 Dec 2023 13:20:50 +0100
Message-Id: <20231211122051.1240855-5-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cee1444-72c0-4a72-955a-08dbfa43a307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDBv8/CEOZBJrJXC44M80QvhKFxElOK53bOJwwVYg+ck6zbO5msQJRrRu7v8ToMo/Tps/3BuWAfxd9sNIE6lMgrK0vUL92RwMYolG9z47yMjoWtYYP8XI210lxAfv//n/Ms2OO3eqnenYV1VVYW7zrNpfWX+h4EjcMl8UTC7N7K+vtiDROx2vokBJ2C3+f0rQt0yIU7vUbXhbMT9Dq66yr+ciyxGrg3cAVp718cq2er6ntxstPSud6sbVW4Cfg2/5CXWfJnR7oDwauN+e804lr+sHBZryHlfWh/xt1aJuZ7TLJQO7bSRb5VU97U1QVHgo6bLkBBqlERPAtqo8yShzbchod5tnftNLSi/sd4w5KzPKSAsNoh7Oxs+GWqjm4eKKhFa91P8H0BxN2dV0PPt4Cl8rbqBP4etzfCYKLybrdmIhhE/a5go5T+RB7hHMb1Ektx273wogs34E2S8d+PZocKwbWGKyMZ9gQxtL9AZLG3xikCKYgK1m5PqfCuRuOvS68YhP+wHaTXxDBFljaBTS9gbPsHOIIwH8aPK+Wror2lnUpqCDfwe6Lwp4po6wXlsDvQB6ZhalFMTzFAMYJQJoU7ps2OyOKYUsgDdlowANVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(966005)(66476007)(54906003)(4326008)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5ftR6uw3aQC19wialxEvS9Uj5mmXE6btE+PFbOxRrYXNTrI62/x7Hzfxb+w?=
 =?us-ascii?Q?bfsqY1jJIrORDYacxqaAMcM4M6atC5C0iFPN8Asw6xETWjEdFRrzemHJj2LX?=
 =?us-ascii?Q?sppKRYGnu5mJg1gOyIZkhJeTLn2gB8e3U9P5TcbZ8KRwqkThvLd/RXRXTNwP?=
 =?us-ascii?Q?/985MiZHw3Vcs05y7QXUe/x4KnX6UCRzpW3xkfAi95Vjh+ylP1HjBj/cZIuP?=
 =?us-ascii?Q?1woBvyEml6mOlh5bXZ4sAN7Z+VOudQsydtDAZ0w0W3PekVSFYBTq+jGQB4AX?=
 =?us-ascii?Q?/5pa4dti7pkaYp5MrKkDCYnoZkb4hIbrEbyJny/zT7GO+I3na2mHCKB2A4jN?=
 =?us-ascii?Q?RxqS5UZUQht00BmlANiX2LCI+UHKQeGx2KiGVNJ0zEHVrfFswYk+sMU09sJa?=
 =?us-ascii?Q?kn98e57g+gMBpT/wQCmQlJEdioR0f77jjaJf+ewXRC0dJ2NJj1tsKQ7PxZ19?=
 =?us-ascii?Q?i+v1rEh8SbkYwSy6wOBzeKtDV5sA0FsooBBrIg2WivEb/iGeUg6b9e8ZunR1?=
 =?us-ascii?Q?vPm+il/dilDelC2OwOsKIrHyRC/JYvQrpd8ZZiSY7kb7TUQEF76JG3TeMP+z?=
 =?us-ascii?Q?8LAnDsRHUAmSA4nS7YwMoocFPzFTzzPZC/Qh1buyoB1u6qexe6doK56IsBZ/?=
 =?us-ascii?Q?c64lZFkDDBUi1YuWQzJghW0+TIRUbH3qiOaIeOJZf+l2stpUsI3md9GjL2gV?=
 =?us-ascii?Q?p2u9DbwnKTOuU/3V/m9US6R+0bZoZ8Sj6HbJGNsVL0mOc1J8x+LaxwcwpoW6?=
 =?us-ascii?Q?It3GYRgEA71eIWPGKIA9wLjMykbiSnaGcnVi2CDa9a8nVZvYG6BKcNOIAhAP?=
 =?us-ascii?Q?yPmQoDdBfS2ygaJyeG4QksF4rDf7Pnk6nGrDu9jMNXTE2hDoIy0PTzYsfAeI?=
 =?us-ascii?Q?ytQkPei+10QucEnp9Cbi6JEagkA0+FU2dzRZFbZODYAsQBF1kt9m8KUG0iNs?=
 =?us-ascii?Q?hd6KVpsCr/zWVf56772M+rBpTJFpoCq+OOJ+HcNDhqPgdc3jO0pDaHCBSeWR?=
 =?us-ascii?Q?SkUgx9iUUitfhJW6Wqr/293dqTS2NmynD4PZv0ueTh7PDCbWQl/6gntA8oCk?=
 =?us-ascii?Q?fT9zkTZgDp7gP7d0FovmBLacGZ8bLLuYe/859NoIinHQJ0OKlIErgNM5/3me?=
 =?us-ascii?Q?c1LkLGVxcgmFWxcE+Q2SXUXt7HGwPUuf7wsOWOEIyF9IcFiG9/DCvXveorG6?=
 =?us-ascii?Q?dqQpTCe9tQ8JQzkxrsJnhUWvBssUX88S4yjU/q6VgNzd9cRw31XYsChAyoyA?=
 =?us-ascii?Q?4jLT1EdMdzBWDjvGyt4CfDTy02JeV4ECI7rxNtzf0S2pdC+lWiIWAiP23Ihe?=
 =?us-ascii?Q?WsNhzQtgs5FwvTkIDBsaPznE7t4hZzesVQJ9w5WkN44JO3BPlsD7KxyIfw4r?=
 =?us-ascii?Q?fOq7TcurkDgBXm0dT73IhwKShF0/+rHkFcXid+kkEWa1KmGA+aJVPY7Qg8yP?=
 =?us-ascii?Q?DVsLGFav9Wu9M3CjqwvL5RqMZS5VU6MdPQiv5fDvvTAKuOAjFYgq/Kl1TF6V?=
 =?us-ascii?Q?UCv8DWkmTsXBPB9gTSCbderIOaUqGYPoJ96Qsx+tAPWis/Rd488uJTFPVvEA?=
 =?us-ascii?Q?1jpDV63iD/0zfcIXsZj87le5UxKqfi/zh5i/0EKB/qn8w8AyZX6twiuSaSno?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cee1444-72c0-4a72-955a-08dbfa43a307
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:21:00.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WFkgJhkj+PbhKY/6SdszH3p8O3TmfyZ322xMcok51h3MEM7ubqVXPqv2F/dCvMhDDVJgDrsRLFVZkvlMeUYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8168
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

From: Lukas Funke <lukas.funke@weidmueller.com>

The commit enables vsprintf() to handle the '%*pb[l]' format specifier
in order to print bitmaps and its derivatives such as cpumask and
nodemask [1]. This can be used to derive kernel boot parameters from
bitmaks such as 'isolcpu' or 'nohz_full' [2].

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt
[2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 lib/vsprintf.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e14c6ca9f9..abbd80ea9c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/string.h>
+#include <linux/bitmap.h>
 
 /* we use this so that we can do without the ctype library */
 #define is_digit(c)	((c) >= '0' && (c) <= '9')
@@ -390,6 +391,71 @@ static char *ip4_addr_string(char *buf, char *end, u8 *addr, int field_width,
 		      flags & ~SPECIAL);
 }
 
+static char *bitmap_string(char *buf, char *end, const unsigned long *bitmap,
+			   int field_width, int precision, int flags)
+{
+	const int CHUNKSIZE = 32;
+	int nr_bits = max_t(int, field_width, 0);
+	int i, chunksz;
+	int first = 1;
+
+	chunksz = nr_bits & (CHUNKSIZE - 1);
+	if (chunksz == 0)
+		chunksz = CHUNKSIZE;
+
+	i = ALIGN(nr_bits, CHUNKSIZE) - CHUNKSIZE;
+	for (; i >= 0; i -= CHUNKSIZE) {
+		u32 chunkmask, val;
+		int word, bit;
+
+		chunkmask = ((1ULL << chunksz) - 1);
+		word = i / BITS_PER_LONG;
+		bit = i % BITS_PER_LONG;
+		val = (bitmap[word] >> bit) & chunkmask;
+
+		if (!first) {
+			if (buf < end)
+				*buf = ',';
+			buf++;
+		}
+		first = 0;
+
+		field_width = DIV_ROUND_UP(chunksz, 4);
+		buf = number(buf, end, val, 16, field_width, precision,
+			     (SMALL | ZEROPAD));
+
+		chunksz = CHUNKSIZE;
+	}
+	return buf;
+}
+
+static char *bitmap_list_string(char *buf, char *end, unsigned long *addr,
+				int field_width, int precision, int flags)
+{
+	int nr_bits = max_t(int, field_width, 0);
+	int first = 1;
+	int rbot, rtop;
+
+	for_each_set_bitrange(rbot, rtop, addr, nr_bits) {
+		if (!first) {
+			if (buf < end)
+				*buf = ',';
+			buf++;
+		}
+		first = 0;
+
+		buf = number(buf, end, rbot, 10, 0, -1, 0);
+		if (rtop == rbot + 1)
+			continue;
+
+		if (buf < end)
+			*buf = '-';
+		buf = number(++buf, end, rtop - 1, 10, 0, -1, 0);
+	}
+
+	return buf;
+}
+
 #ifdef CONFIG_LIB_UUID
 /*
  * This works (roughly) the same way as Linux's.
@@ -503,6 +569,15 @@ static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 					       precision, flags);
 		flags &= ~SPECIAL;
 		break;
+	case 'b':
+		switch (fmt[1]) {
+		case 'l':
+			return bitmap_list_string(buf, end, ptr, field_width,
+							precision, flags);
+		default:
+			return bitmap_string(buf, end, ptr, field_width,
+						precision, flags);
+		}
 #ifdef CONFIG_LIB_UUID
 	case 'U':
 		return uuid_string(buf, end, ptr, field_width, precision,
-- 
2.30.2

