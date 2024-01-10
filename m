Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACAC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD2387AEC;
	Wed, 10 Jan 2024 10:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="hKbvBjQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7319287AC9; Wed, 10 Jan 2024 10:10:56 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B2E8792C
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFiUMDUQdHe3+q80Qvzj9hqKAFXnGVsxOfI9IAz5KGGYIECCxm6ofvKJk8MjllYipyopsIoCXtopbsPS3Z8yP8SjA7lQUEtvIsdcq5+6apdOG6J6oRqd7JZ9vTV6JT1nenWqef1Xz3/JAwYySlRep0SEO4ZNw8SmQ4C3SJc8x0HepePunIBwG4kzY29qVXRyNVilRmrt7I2lsyA5eiq5EJBXxkP+g7/9XCb17omSxai5w/6BoqS3o31WmiIi2D4xlU8u6DBVzXQOqtGios2iNedyg+5sKGrHebd75LpH0iPwSXPp0x35tiYw/UnVNYI6IYZZXgEFABKwjZ49Wy6fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFl6bRAhN0MaFTSzO7WG8IaxEOGytGzxn+YX1njLevw=;
 b=aNlg+GPoGhDrW32orjhmba3mQ6Xs0XrAhjfjNPAqyW1jFaOQYLPKN+a7QiqPY4VgA8rG9TDI6igAnudME3OQ6T22K3lGvOVZuxIXst8tmdL443xVFdX2g0SEMHQion/8FiJzlk0roHgPQMb/UnDlksAmNPE4bcnIZ+Fln3neKfV77/G9NOpDwksWlV29gAlJBNJGttaRmdyOBnVRI+LH7c//3k25wbBcQG1QLANwbvsF8dI2ND2k+5seU8YogYxpXWcesGqv7KO+4XFUawOifzmplma97clryGnukiUs/OtVggJqr7GFvA7j1ghMDZFkrxujH8lpnRwa9FQvpS/p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFl6bRAhN0MaFTSzO7WG8IaxEOGytGzxn+YX1njLevw=;
 b=hKbvBjQmSIW9hcj8D3nGUKpnsTe9TN1JalVMBiopWIkt3B03P+owKetF3ioUzcDbwylPyURfsa/8TM/U6YHAThTMKLeJeBcs4JPiNbj7xuroK1sjwM2vK1PVhBzcAJSFfcXlodOT80ZcAqXuUr8uo0XtsRymwtf97eTR6ZtB7Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAXPR08MB6527.eurprd08.prod.outlook.com (2603:10a6:102:156::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.26; Wed, 10 Jan
 2024 09:10:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:52 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 10/11] setexptr: Extend setexpr_get_arg() to handle pointer
 to memory
Date: Wed, 10 Jan 2024 10:10:36 +0100
Message-Id: <20240110091037.392520-11-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAXPR08MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd20140-436b-41a6-d127-08dc11bc0ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HYYi9+4SZi/Rs/86JvJk7LZ6etfuKA6J+I1vqJWECcv2u/CAUcmsWS04tS82jWEkj4gCljB2ejyfNVZWmEAAsD6ihXNjeaEL44y4iPzP78vRrf1oGfSGuKreIG/74C4cOd0g7NjyUk8OlU7qr8FvnbC9YxDQY1vq7FnGuw6xYyRm1GpLBm6VlIviWreIdSGtdYsHxjawRd407WJGEE+6VluCULstpHxUtxjyRJRX1jYA3x/lnvGHL9GbNifBNAH5suMdvvdWll3J05MksZA6WRqzLgENnTqSuew1Xp/v5HaXGSAgbpkQrIMFhfs6TWA4g8niledu+PFi4n9aJkM586VN3CZ7MYY6XlOfQXagE+UotFIxwYt+WhvgQIP6BkA6nuW9OSgfeuktVJ/8VaPbC2EAc8vIHNQU815hSY6WkE/pkDgxG4IY4JWCpqiDQ0NGyoRqkkUTPWV0eAIWZS0oUEZSUH6awkoDAa9V2u7wR1jVjcr1EzrZX2W03vtwr0z0v8dsSrc+zqL+CB6Uy3Zzf15C2Xp2UkS/JbyEIlASdmlUt4S21WWnOWpveBZbeb5udPVGsuqkWpT0oYHjYMy7ZNzpm8GXd+cJt7XxNVhM9RP1xYIhbSqBNFb1GBlMkNt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(26005)(1076003)(6666004)(478600001)(6512007)(9686003)(6506007)(52116002)(83380400001)(5660300002)(2906002)(41300700001)(4326008)(6486002)(66946007)(8676002)(8936002)(6916009)(66476007)(66556008)(54906003)(316002)(86362001)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?apqZ+KiCX6zkhCkqiCmoyVM/Dakrs9HZa4DDLfd9HYIyxQkCNO1jYlDF/Duu?=
 =?us-ascii?Q?ieWYiiU3F+LHVeOlguqY3+PsVOf3a53RSS3AJDnPnU9gg2spBDsYNQtslyYp?=
 =?us-ascii?Q?6JkVylFh+e87Oij13ojPeaLvG5WRFARM/qYhteHN9h9ds5hNz2WCi9Jci4di?=
 =?us-ascii?Q?WLPe3U6+iBAkNBPjarC+hvT10zu1IuFXxR4YBEKnJ4t9ttMiSmX/z4FoMjUs?=
 =?us-ascii?Q?KEbWJYTgrdWlJ/jG1sQk6RTp6x+xjyeGQ2j8OGYcZbd6sfxurSi8ldP7gQPq?=
 =?us-ascii?Q?mppisjZR9xfZ5l9UV5N9MhMBwlXzAzb85mcGUA2+rroL7jTbxlAYmBoAFmdz?=
 =?us-ascii?Q?tze22/hn6tUQufXxyIiqdti1sYTmhSNDyGz9JPn47yEwThsORuPqfshSj6Di?=
 =?us-ascii?Q?vznDDI16U04t99/B9eWkmi/URefJwaFEBxnY/PJf3/dkTa5Pp6+fAg++Hspr?=
 =?us-ascii?Q?CduYYfPl4ETsBQp8OhMsfFZBbbCSIOrryF7R8VhJobOMbNt+/mtFsY2KrlYp?=
 =?us-ascii?Q?zlohStiBe6aXRHb5d3X901VLCRStCkSliZU0JNuPSMdNH2ByZCcQttpBHFfq?=
 =?us-ascii?Q?TI5eUJt6IgyJrZ2AywdsqE2WEv2hL4OrLWZK/LKAVpss9aceFgy0Fqgu+dWt?=
 =?us-ascii?Q?afnik17kd8V6M/rwDzSbfvnqfVedM7Ri2DhGrvHk0vx6XxDwwHt+V9+Nt/XU?=
 =?us-ascii?Q?+z+wvi+BflY98H719y3G6+eQwXaAO7Bo68UYBZ4Py5TVmUKI4Er5OeLTWQ8M?=
 =?us-ascii?Q?4H3FtHAG5WzdtfhHbRjcQrjG0SjjQw8ZRYiKAvTkCmuNYRnYEhoq/TlXpXsX?=
 =?us-ascii?Q?91pwqLVkmS+3qPuzbT6ouYiuYCZfr1sFNZBxB+H5mSZm2ijLgQa9eCsnO1Sj?=
 =?us-ascii?Q?pJ0tIJ6pLxm/FkMGInJwGCpLpUpa11ZVLeJ4pWgH7QQBcgVrLfF9hgFx+nY4?=
 =?us-ascii?Q?PwRv60d62GayQpnyrx29ld/jMGYWwUC2K5zD2nh+7JmRlkB+B2TYFCstlmoo?=
 =?us-ascii?Q?mbdaxKc/Z5Iyaj2NXP6aDeBL3WUqX5EktxoDUF37gvbuappZUNGa0BYZsmEd?=
 =?us-ascii?Q?LzXIGTYGs+oA4dHT+gJ0TW5pPmk2A7GkVUPkmJ+I+YpnA5RRlDmk19AaAu2E?=
 =?us-ascii?Q?zZi9Twjc9zSLRWdMNFszT0ZIT+K4mUU69qZgZCyYweMdvWFEGmHDKuv9kEso?=
 =?us-ascii?Q?PoU4FynS/86kw+AErk77s+xT9Y/odFQBm55NRhzGwojkkxK+OrSLk5dbDuhd?=
 =?us-ascii?Q?vGBvpYEXvKOOpst4mOgAw3RdJXq2RlMDJHbTfCedcydiWCMT8wqZz3epFiAJ?=
 =?us-ascii?Q?7GiXHOA1Bun3u6ubE2Pt2Esj3RygOCg6L9IXBywDPgvyIjjXVQ9PR5ieGZ/x?=
 =?us-ascii?Q?w5Llt7SpoRvqHTN13QW/cot9m4CKbUkaNVYUty+8dQTreGMswy2kI3bNKPgG?=
 =?us-ascii?Q?YmcYcA4Oca37bsM31Ap6IZsnHKos4R/k+dtA/W46OhR7SzLO7y6CwtjM42R1?=
 =?us-ascii?Q?7lCKn1YzLCPMh+pLk7AffA+eAB9ZFnVqXe4Zu5PVDWPDIjhHGEK86UvRNGRD?=
 =?us-ascii?Q?n5j/CAWRO9GPeYUac9DWAAa8zlfMEEPf+KtCmbcEPmU3dvSIOEGI63QMe47f?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd20140-436b-41a6-d127-08dc11bc0ac9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:51.3153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYkaLCXjFI+w8dZM9ttLRPIzOiUqTyknzB4UYTvDb/iYPXzU8QEGxEsnT5WWzEzq9jXGmNPujmQOf7I3PZLYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6527
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

Extend setexpr_get_arg() function in order to handle bitmaps with
length greater than 8 byte. If the bitmap is provided as hex string
the string is parsed into a bitmap.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 cmd/setexpr.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 9caa68d20d..fed457bb7e 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -17,6 +17,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <linux/sizes.h>
+#include <linux/err.h>
 #include "printf.h"
 
 #define MAX_STR_LEN 128
@@ -24,6 +25,8 @@
 int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
 {
 	struct expr_arg arg;
+	uchar *bmap;
+	ulong val;
 
 	/*
 	 * If the parameter starts with a '*' then assume it is a pointer to
@@ -32,7 +35,6 @@ int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
 	if (s[0] == '*') {
 		ulong *p;
 		ulong addr;
-		ulong val;
 		int len;
 		char *str;
 
@@ -71,17 +73,38 @@ int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
 			unmap_sysmem(p);
 			arg.ival = val;
 			break;
-		default:
+#if BITS_PER_LONG == 64
+		case 8:
 			p = map_sysmem(addr, sizeof(ulong));
 			val = *p;
 			unmap_sysmem(p);
 			arg.ival = val;
 			break;
+#endif
+		default:
+			p = map_sysmem(addr, w);
+			bmap = malloc(w);
+			if (!bmap) {
+				printf("Out of memory\n");
+				return -ENOMEM;
+			}
+			memcpy(bmap, p, w);
+			arg.bmap = bmap;
+			unmap_sysmem(p);
 		}
 	} else {
 		if (w == CMD_DATA_SIZE_STR)
 			return -EINVAL;
-		arg.ival = hextoul(s, NULL);
+		if (w > sizeof(ulong)) {
+			bmap = hextobarray(s);
+			if (IS_ERR(bmap)) {
+				printf("Out of memory\n");
+				return -ENOMEM;
+			}
+			arg.bmap = bmap;
+		} else {
+			arg.ival = hextoul(s, NULL);
+		}
 	}
 	*argp = arg;
 
-- 
2.30.2

