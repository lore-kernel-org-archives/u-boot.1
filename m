Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57734C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DEC87AF6;
	Wed, 10 Jan 2024 10:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="sAEbjV8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C1987AD7; Wed, 10 Jan 2024 10:10:57 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AC287A36
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc2AmfK9eKId1FAAXKqMwFgQbxhVBuyx49Knf7neoUSTWSDq9ipTrW6rH7BReGCIJ4e9QX5rm1l9TGeZVhtfS1jilF1Pw1Cr+4wxL+mMUYYcbHQ894y9L78TmxbvkNM+4MoL1HDeE3uFWpgrWOJ6u1rQkli8Y6JZHrLKR2DAY/eiDF5j1MYpkEBAp1ceMiX0kLFdxNCPvXbAijHZxkdO7myORmeZcOYeIWr8qCmFPKdZ5ITQn4ckpnPwPm5fC4Cmf5a8YihvyEOjHejcpi0LGtTqUvBm+6oIacU6pTkjizyDKlB5D6OwHHwM9Vfv7ZevUkMAYktS2LbqzD//GHea6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUDxR0usJNbwdJXEgklhfHqvWlvNhqYYBBEfewc3Ebk=;
 b=nFHNMzw2noVyWFzHHOed7yCFsJENz/QHwwK3H52DgejViGrLTNQK9yZwE3wh8c9jF+uhucGNN7VjHZD6VbyHMHwNPdHi1FPkk05xbM/sKV9SWJFUBm4kxg1jgX7ajHlu7RsVFheBz7e5xS9D3LIoNdqJSxQMw6TJpS/7f4ueCH9EpFikxGI61aaz6K52UCisRtQY91wXwmmL42LXx5vS/5Xy9XyupKrWMyhSdzNWcm359z+03SFdFWkJbPrSGeNBCoexcZQW0fDV0TjcCmWAQRBkgWdu0+8MU//IXwVRustjOoPWXu5q1m9usVFe8hIPsvaOupGK5+97gLQDSBPZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUDxR0usJNbwdJXEgklhfHqvWlvNhqYYBBEfewc3Ebk=;
 b=sAEbjV8WVU/H67a+J7dfpQydqa7h/Ao0Krm1I3+zQ3vW9Wh3/4Vr/KpqFxRShnJ00z7eIGX4zipOT6Jws+XVT9XI4h99gK+XRlJjOblfROr0boEP4EAW84JJZaAsEn5Zsr6+B0UtR3zB98AxVEXJCJw2tGO8koOaT+wPD3AOr+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAXPR08MB6527.eurprd08.prod.outlook.com (2603:10a6:102:156::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.26; Wed, 10 Jan
 2024 09:10:53 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:53 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>
Subject: [PATCH v3 11/11] cmd: printf: forward '%p' format string specifier
Date: Wed, 10 Jan 2024 10:10:37 +0100
Message-Id: <20240110091037.392520-12-lukas.funke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6402588-9363-43e7-6c22-08dc11bc0b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vcn3r+GDlb7r3gg6jZKoiuPcNJ0hJEOQTtdE13tXdVIRUPTtwRk9Gc0n3nmJ1WVxsJnKEUfcu8QsIFsXvz3WswvPIM0V4QUlQ6hb+TnwgQAsBy9wgzbQiRTzJ7ZHlkCXQtH5QoS1B0c4sYtqr3Q3rvBGnfuX3JeXKmSAjYbAmG+uk75fPsguo+Ybr+TEnNTPRPdnYcEDsesEGIeexr+NTfeN6BzO1aPaDODfGEKmhYRODhttSI6LKmoeAAfrZVMnaoKH6F4KNISMLCWSGiLuLReYW9A9PEaHwBGOC9clMzwKA2uPxQFpN5vPqNoUs9b8aU+bteah4xoGYIpSvg5/GQhfv8vZszEEVVS0mIvAP118b3PKYzsiY92bhHYZlhfUOmxsuT7/lav6S1s14akzcgk2S5f2fKn3z4+iyb/y8pkeTAFJidp9k91nmL91ijnB56xcAq/h6LoSaL3g57DmLTEKAyFOEpSShunXmUSFhPcV7R7CKVvXuuQsuCJhsgPw+d0b9LnUzxRNyoSIQYM6xdDGDJDVqVWj7k/Rpda44ZjbMIYpfTgT/aUvvGbIhkSpFeWoBeCw1i2zskQNVeVt9P2MS3qUr3yOofEHn4wBReV94SDjnSQ+Y4NKjLUJPdZH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(107886003)(26005)(1076003)(6666004)(478600001)(6512007)(9686003)(6506007)(52116002)(83380400001)(5660300002)(2906002)(41300700001)(4326008)(6486002)(66946007)(8676002)(8936002)(6916009)(66476007)(66556008)(54906003)(316002)(86362001)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbFr6mGWAkCEOXYCjiRBCXXxuQcJTPwk5quyIsVp30jLf9V1SKinWW1qu4qS?=
 =?us-ascii?Q?m1eY3diNmhQNHui0kOB4BADxGy9/uyhcUdmAFsgrhu1w9wN2DbsED7/0lXt9?=
 =?us-ascii?Q?4dJIabwvje2Fv0IgdaFa/+lpLW5OXQEiFELMwfxtALeyB0Az6BY6m4XV/sKq?=
 =?us-ascii?Q?huD6cM06d/+pebYgHwb58+5xY/sQMWlRhANDnzr3htxsixYQac1O76UW8KBd?=
 =?us-ascii?Q?HbWGcDcICfobvz22AP86PojPLAhfq3f3v0nenD6SyUgP2eGQHfeldPqktu5D?=
 =?us-ascii?Q?DOd0CLoEC7+cOIFgf91tC+my02f+HNLYHXyjy4VzKvHF3sfd2kE9ch9OdNeY?=
 =?us-ascii?Q?a7f6SitjdIuzZvJ/u6+Y3eRCNQxBrDIHqsudXq15ud4Q5ZUubvebdckm82s6?=
 =?us-ascii?Q?EC88/7U4IdzVY+0m+lJSjdfAG0P+IUjMRTHDTu3W/v+6wQn4lS/58IXb0Okx?=
 =?us-ascii?Q?6beOTfQp+7xUdvgcOdkyvEe2+dUA1ZiySB3VwLjyOP0Gq90aFbMnrrgBv4Xp?=
 =?us-ascii?Q?IXk1BeiJ6CDjdVEC4JDEFQvqKBlf1DTAN/Gwq5idV2/BpcKvPX9gvIzpsQIk?=
 =?us-ascii?Q?7GkJgfN5Z2AwYARd+GfwGKIzXKBAnueUTHRrtx65EtYnERn2sKIDZaOH1MaT?=
 =?us-ascii?Q?ZGof0DpUCsr5k1VU8L3vgeEQgC9RnI/gtxtX3u/qR/bv/MJ+F2k01Evz6s+N?=
 =?us-ascii?Q?x+IrrDxyyt9x5QiWMDwBnhFAGFAuhTXgkwSRZ22i247qbbpbOX31A0AndkS2?=
 =?us-ascii?Q?O7NduXQxdankHKPUVBQyQReJXctuIMkSqc84MVPGf8oQoQHj7oHObE8FA5hK?=
 =?us-ascii?Q?p+k2jp+TAXOktY1GCROey/h/u6rjYXRpGHe3sD9fO/y268OfenBf07EKRrko?=
 =?us-ascii?Q?ceuHT9MNuIo6jcQbH2B/M+fioN+6NGLe/SBlCtvj3ZXpDUL5lc9LCMbEnHHM?=
 =?us-ascii?Q?NNG0U1YqVgIJ10o3nCkpEJOu+TgBh9WrMhXjMlM2k7u7L8A2/ISoV4SMRSOl?=
 =?us-ascii?Q?yme/RUcJxrwZbMbU7NpPNO2NO41vWdRNIzqnm57Je3seSU3T074qEP5UJazA?=
 =?us-ascii?Q?cb2EDqHmLJVcptcO9DPAxLdFa/aSXPl4ZIJAY4PmFf9jeo8dlFkCyTX6ZwSz?=
 =?us-ascii?Q?vr/gkEqDygr/RxOdS+h6wH15SF9G+DwiHNgcGhz3HWVT2F/unUSPgBRvWNw/?=
 =?us-ascii?Q?c5bP/gXpeXnZeyTpOlzCJ03qC3txg11vO+itMU8cugnpiXKtU6b3iv8qYpYu?=
 =?us-ascii?Q?3QWN672ZjNB2QaAprc/7ZEU/SrUSuIG1PoVlGA5Jm1uk5MEqCjlPiZaXNRPM?=
 =?us-ascii?Q?Z74udvSdb7k0V/XFEDNM+zWzKkvNZdBbGPhrmHFUmJtMhl6Xh9usXswc96yz?=
 =?us-ascii?Q?tGHTD29QXvX1dJxyt2PzOksIru8JXMZhBq47EfwGop+2s3/X8rmxHOs3iT1P?=
 =?us-ascii?Q?cR9Qrv5ciItyB1NqhuLA4dHNFE2TbWLzlx0RF53lvxVu3sJwYBpIpBLihB1+?=
 =?us-ascii?Q?Js3855slRmsqMpmAjjct4rlsFKOAkWuMuSlalDvQs7I3frPSgUjoDvS55/0D?=
 =?us-ascii?Q?FY2w6YVsqjcyuHIsokMe5WSExBSszWr4tmfhXI2g4bT9BUDg9yy5/nl8i+V+?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6402588-9363-43e7-6c22-08dc11bc0b05
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:51.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHranaBTJ1AU3MVlfbYKjDQrb1vQiFEaR83lW4MoYajKt6BHJrjrN0egZwSgwfpUvIpJN8cFnQrsGpx4YGeLXg==
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

Forward '%p' format specifier to the underlying format logic in order
to print pointers, especially bitmaps.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v3:
- Dereference pointer argument (i.e. *value) in the
  'setexpr name fmt <format> value' case. This is currently only
  supported in the 'setexptr <name> [*]<value>' and
  'setexptr <name> [*]<value> <op> [*]<value2>' case

 cmd/printf.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/cmd/printf.c b/cmd/printf.c
index f56543b79e..2e54faf339 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -85,11 +85,13 @@
  */
 
 #include <common.h>
+#include <command.h>
 #include <ctype.h>
 #include <errno.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <linux/bitmap.h>
 
 #define WANT_HEX_ESCAPES 0
 #define PRINT_CONVERSION_ERROR 1
@@ -476,6 +478,38 @@ static int get_width_prec(const char *str)
 	return (int)v;
 }
 
+static int print_pointer(struct print_inf *inf, char *format,
+			 unsigned int fmt_length, int field_width,
+			 int precision, const char *argument)
+{
+	struct expr_arg aval;
+
+	if (setexpr_get_arg(skip_whitespace(argument), field_width >> 3, &aval))
+		return CMD_RET_FAILURE;
+
+	if (field_width > BITS_PER_LONG) {
+		printf_str(inf, format, aval.bmap);
+		free(aval.bmap);
+	} else {
+		printf_str(inf, format, &aval.ival);
+	}
+
+	switch (inf->error) {
+	case 0:
+		return 0;
+	case PRINT_SIZE_ERROR:
+		printf("printf: size error\n"); break;
+	case PRINT_CONVERSION_ERROR:
+		printf("printf: conversion error\n"); break;
+	case PRINT_TRUNCATED_ERROR:
+		printf("printf: output truncated\n"); break;
+	default:
+		printf("printf: unknown error\n");
+	}
+
+	return -1;
+}
+
 /* Print the text in FORMAT, using ARGV for arguments to any '%' directives.
  * Return advanced ARGV.
  */
@@ -536,6 +570,23 @@ static char **print_formatted(struct print_inf *inf, char *f, char **argv, int *
 					}
 				}
 			}
+			if (*f == 'p') {
+				static const char ptr_format_chars[] = "bl";
+				++f;
+				++direc_length;
+				char *p = strchr(ptr_format_chars, *f);
+				/* consume whole format token */
+				while (*f != '\0' && *(p++) == *f) {
+					++f;
+					++direc_length;
+				}
+				if (print_pointer(inf, direc_start, direc_length,
+						  field_width, precision, *argv++)) {
+					return saved_argv - 1;
+				}
+				f--;
+				break;
+			}
 
 			/* Remove "lLhz" size modifiers, repeatedly.
 			 * bash does not like "%lld", but coreutils
-- 
2.30.2

