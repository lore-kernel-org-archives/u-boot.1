Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638D4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A21877E9;
	Tue, 12 Dec 2023 09:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="H6FosJ09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC358078B; Tue, 12 Dec 2023 09:53:14 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E171877CA
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0KROatX6yU/sBfyP2apcLSsZp7X3uFqoup3WJ0IOdf4bfdP7DdsM/wrVka6GgD3zexgJV7LkoulWba8XA8Qq29PAmqh2pXP7Ppj+7c33fKnVXUZO7KZcLWZCVtk/SMDLVExZQWLs2pKUsiMxb8Nf7X9LlXyTrDjwEg2m1C2Nj1PaRxVbDsep+ytzp1oznIhoqxWRCZ2GMP77NNeZs5eoHQigeTbFyVhqHQHR9mEd6H7O51C9EiMHvJDldBoNV2KODCJZVzTfJczr2IYenh3Sagm5L8jYkUMt3B4SFVt04y6AxEitR42BRohZyBMn5+cD1iV91d3Z3bl5tyI2oex6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFTbjpNPQRqwH2qpVzOQBIZdMsD4U9SVvyJRtX1kE4s=;
 b=afbFinOvRKwBuWM4PH5v/Bna41o+Ijdma8xuRut5+UzjTBRmreSrteVVZIpkAM7Er/c753+1sBdNETIdHJo4/+4R/GgAfT/6eLwEBgVUtG1sNuwxi7Zm4QTHgB711zpSn9IOg9p0pJQ0yKVWa2NdTpgOdVYBa92N48dwfnotriiYALFUMDaK5/9XH1cUDCSEhAWIgdnto8a1CLFeh71ddKjv1QDaSRFaW9QrSXPLFPcfzKB2I/UxfP8p4JfXl62kRKXmgBNdJV6H41B7AdtP05CQbeM/UsiWO1mb+at3325QT68VtVgD9hOO8UM8OuD46iyoVTSGS81OGt2siBMuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFTbjpNPQRqwH2qpVzOQBIZdMsD4U9SVvyJRtX1kE4s=;
 b=H6FosJ09Jh4NaKghnORo544i/WDCcNI/qKEtWBA/wMVHLE5fk2e0iZwBa7S2uXWI4FWS95wqwy9eJgH4U80raW4UfmoHtdKf6ObmpXOHsQEkRlyJo+hmFhcl48TYOIh55XNDHIwXKOTGS1p8Adr1kXAoucoInINgcFjkpT1sAkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:11 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:11 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>
Subject: [PATCH v2 6/6] cmd: printf: forward '%p' format string specifier
Date: Tue, 12 Dec 2023 09:52:36 +0100
Message-Id: <20231212085236.2730768-7-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b091ff2-b6ce-4336-d65a-08dbfaefc4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TxpsFMn0YY1tCHjBWrztxwwnzf8Wlauey8AGvD1wZu7V2JqkEXfCJ0Qk49KMP4vMEBchPvV8/oE1ayff9Dcamazbxk3EHGepxazMVdJpmXIiTgV+rgsar1NQctpZHpUO/rix7luA9V/+XMnxaABbFyhLuQJiPmbgGve6MEu10LHHX/HGq/LPQhqJk9fXazTSugpiYCGQEOy8Hy5O5cz3R/cDiLwWZ7sAr0dKOvZ5+ZZD4mwcqxnRWU/g07U7XIASwGVokODcLynnYVFqlxf+GLorqbfvF5j5rYMnr++H21v/WcNNkwICJFhuhAokuq4+WEPT9XCSrew2UdNp8N0oZcaKNX9usmCt/ROxL3XMAGScud02uMuotDmqCwU61BUXS2tPMJCrTE8MDXRVrejwrRpAx/N+IcUbJYIsZNtgtxaW1Nn+/wV8buvq0VivWNJtTe/TmgD1JX85zWEL0SDLVwyboimaGFwrGxhLqet9TpEwjHHiHQxub32SE4861HBwRFPjqjeTQS2rV0alETYy8lJwkOAA4rmvJZDbkosWgMeM6kOOicH/K967LIIqPHIwzL+uPD2cMYDozKVd42FqweK4WtiRxthP1Zq4sqovRjm6Xv6bkYx+dQTf7bEreu4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(83380400001)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(316002)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfWbRBsmZ5D9ykkBlObAELhSgI7jO68s6faem+kBlkgo4vf3NPgW1C3XC8Bz?=
 =?us-ascii?Q?zQK7zFc9BMZXun/a/k37HQY+UUhdFV/m4op5bZCGyhf/TL/yd1Bs/lrZfvkQ?=
 =?us-ascii?Q?RS7dnK6n6xVDgPVb0foA0FU6jpFDPDa4JcaF3r0IkBW2ktUXcqviut9633hR?=
 =?us-ascii?Q?OLNUCdk9+z8I2bO/cyMVY113A1BYfqUBtkv20PfXPo+V0Kdv7jKpkLbkKabr?=
 =?us-ascii?Q?mYcQdLzHIw4owyLoj1eiIERCQ5iCqjdiyjk6jf4UkPRO5NTJl7K5aJx7+4B9?=
 =?us-ascii?Q?a6CKqWRiCgkmJ/IxAE+ZXftIBBBnlPpsmdayTV5KKCf0UpO3qOVQJFTNUQPH?=
 =?us-ascii?Q?bBu9Jp1QekqnKIdZ1lAQItyYqafSKftxBWzxMjw9eKdDuw2EcLRdSlP7NFne?=
 =?us-ascii?Q?kQW8apVLPfwYuG775cF8EHrnQNKFPjbuYZjeZA+OJc1cyzsBTT/xZWoma05E?=
 =?us-ascii?Q?OhjMJPFGa7p7zD3mTdjuN97B7EqjDmyyGcihAFqaDzz5g5G+nNORLnY0RCG3?=
 =?us-ascii?Q?ekO/deG0TlVX2LblwQqe3BTV/oAThnISVQ+d5sCbXtoI/qft4zTYHpPJuQND?=
 =?us-ascii?Q?0NXlR86F3aUMeQ+M6eCqwwST57Bc8QtzMWfbhJ/2Na+leckuC6YLbFq/cJ/S?=
 =?us-ascii?Q?nHKQacV2x44SqVLbiYWc4Haz/VmF8PTn6/fjDNA+E/4ti1kXMdloK2ZOgbdm?=
 =?us-ascii?Q?m4JFIzHfGpm7upVCyNI1OW90piuyw+Su5+orr93VqJYxUBspW0VQS+PekbOL?=
 =?us-ascii?Q?Gg/XLtCE6VOYKboD3L/nZmriWtjoeulDRebn3yDJoWZXHY63PzXe9Ru63b3S?=
 =?us-ascii?Q?ywdrSWCl3Su5zGGC9nuFvvU/Zym19/0YKdMtP5GD/t5n+9gDP7otl1Yc6UqI?=
 =?us-ascii?Q?DtsTYYZ9gk2DU1P8agVfM89eQK/lxmnSjgVOZttwTok6yVYGPWQi8q/fMreH?=
 =?us-ascii?Q?UnU7q9G0rGlGg1JTwNraPfj4vEeiBTsqMxV1StR/YwhLpuw2RpcyrL0Kc12B?=
 =?us-ascii?Q?akI4aJtfqRa8GmUtB0W+LHTRSiwm2bJCDPDILRYDfXWyXFp9f599DWZOrEJh?=
 =?us-ascii?Q?EVC8m4PvEm8gwY6cMcMKf43tQSADmBVg2WbOL0xptnZOi0pUotGLyolWyUmE?=
 =?us-ascii?Q?SXJLOLaXnymgFHRWuRmzSvfesxlYWzI5B1uQHb7mV1Q8JVNZpp3gJxTQtNV+?=
 =?us-ascii?Q?FYWV2D9i7p3JmC8cewSv405BQofEDcx7Th6Uus5MMJ0fwafXHkNawywM9FEl?=
 =?us-ascii?Q?zYNwOfoS4CZr0yHv0Bay13wCjKSSRZxVKejVrsS9y5uNf5rsq7AwXLDowwFB?=
 =?us-ascii?Q?wt9jWNEA43ZZj9jl0cQT8zb+XqJOouOY3Zikh+7VfSW9JqX1/i6fG9TLpOAo?=
 =?us-ascii?Q?vwtancwdOLdqhp0KXVnLBTWDUD5FbxboF/mV3x4z2HfTQ3IMxFIoV8nO1hwl?=
 =?us-ascii?Q?rXktaefFz04u/H7Mtx7zD4YCMPprzVtnKh9rmJiwAW99/c1Bs6XuNP30WwSu?=
 =?us-ascii?Q?405pCfEose4/OQrrjl35Gi/k/wEogA2SHaKlj8o+dllkBQOHrVDKRF9M4oaP?=
 =?us-ascii?Q?0MuLW0WpuScRxDnrlSkz8hqmp4qjT31ruX8gslpsePZ9zRfPt/hqVTr1UfYW?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b091ff2-b6ce-4336-d65a-08dbfaefc4f8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:11.2897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRjm1YwEvEpUIy3oib7VLrJEi88quV6RaFxgW7xNb9odPWY1SeQUkacYmi1LFcUC1gLa8fFY1/Q6oQzYtOSDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

(no changes since v1)

 cmd/printf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/cmd/printf.c b/cmd/printf.c
index 0c6887e0d6..a90c923871 100644
--- a/cmd/printf.c
+++ b/cmd/printf.c
@@ -90,6 +90,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <linux/bitmap.h>
 
 #define WANT_HEX_ESCAPES 0
 #define PRINT_CONVERSION_ERROR 1
@@ -476,6 +477,16 @@ static int get_width_prec(const char *str)
 	return (int)v;
 }
 
+static int print_pointer(struct print_inf *inf, char *format,
+			 unsigned int fmt_length, const char *argument)
+{
+	u64 value = simple_strtoull(argument, NULL, 0);
+
+	printf_str(inf, format, &value);
+
+	return inf->error;
+}
+
 /* Print the text in FORMAT, using ARGV for arguments to any '%' directives.
  * Return advanced ARGV.
  */
@@ -536,6 +547,24 @@ static char **print_formatted(struct print_inf *inf, char *f, char **argv, int *
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
+				if (print_pointer(inf, direc_start, direc_length, *argv++)) {
+					printf("`%s': invalid format\n", direc_start);
+					/* causes main() to exit with error */
+					return saved_argv - 1;
+				}
+				f--;
+				break;
+			}
 
 			/* Remove "lLhz" size modifiers, repeatedly.
 			 * bash does not like "%lld", but coreutils
-- 
2.30.2

