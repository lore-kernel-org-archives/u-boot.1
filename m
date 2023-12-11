Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BADC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 12:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F958776B;
	Mon, 11 Dec 2023 13:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="WHA07vtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1842187751; Mon, 11 Dec 2023 13:21:07 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B3D8775A
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1tDhDRBEMVdDm6jb4j4db6aCFKiG+rjExYMkvgtMW3YyyE5oBQ9+O78I+GFoB0tmd9SMz6IxDR6hXpj4lmFh7E6onpeEiKS/iKeEDmR1ZINUwnLzPfVtcOuPfvdl/pSJjSBh+oDrrlzmoBY82xDb9Ndww1SxSQcGCXShMf0llCk12qc9wYFkwSIlGUqApQVfnr6DWJqG3Uqu/FfoXFuJ0oDhaRnwPu6cQ6l6iA08K+y2L3P1cbxEkm80aalziQdSRODgI1bvUDVyOVeM8nWfQvXxVOWxDNvYbdHVuOiL+Ze31PiDY9HCqNF7NIxsDgOSwdyfsXQ0nqjdz9qgLF5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvhaZMYIglqpHudmL6IHqqmBHScKhVBtnQk1ex0zbl8=;
 b=jTB23cZa6ZCB2He7HhIa0Q5fk1i7bVv7KEMEvroBqjHzQLQPc7LENchm5zZQvhC+8M9wyHgcBZ+cm567jRt/ry1U/GnNHjXiAcw16bPrWmjQiRwauvsPAmqw9yHwfIqYQS4ctL57Bj0bjXm+kfMxpXsJpEhsdGRRJNi+omcIf47q9CGmsjLShL1GMVi0XjbX9IBBD++SMKOprIihP9/ZzymHcFAf8Fz4cP/9NgRYmBQcS5iYbbMZhZ8i0/6oSpPYQClJDAZw949TKclMkplRJE58dZXRLI6LrT2Bj8P2g/BQNdCulLetOBwI+6f2m8EHMZK1/du1oBRZFMKRowNTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvhaZMYIglqpHudmL6IHqqmBHScKhVBtnQk1ex0zbl8=;
 b=WHA07vtv7Q8bjBZZMyCLCQBn6rvbuMmBx6Xk+AHM3JRhzB7F2Ql/Cqp/843c4CHfcAqAZZ+6rWQhxkL/4izQ6N6LroW2o1g9fWYgmrJWY9DBnF6ejFoZ7P3/tayO+iQmF5yWbFVNUtrYElAXYAIUFlwFaLH+4T+m9Z6XUp2zkZw=
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
 12:21:01 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>
Subject: [PATCH 5/5] cmd: printf: forward '%p' format string specifier
Date: Mon, 11 Dec 2023 13:20:51 +0100
Message-Id: <20231211122051.1240855-6-lukas.funke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 482e7c51-2747-4e1e-f50b-08dbfa43a347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zFufSz2QbvNnd39HG2qqS/HAknd8P9GcxLzsXJK8q430NP6IJeG6x+h1/LdaBtjJhjCMZmRU7afodSbhcz2vTuf2giA7+uIwDTIToGnW7GJxSFukWsvHZruucS7Bxmc3d/H2SZ7agdhYDQkUFlbIq17CAyJR5V0vmXjzsC6rXqCwJdQxR0f2dBLNJ9vu0EQPff5dkKpCN3FuaJkn/B1YLThxtr+endIpq8kG/HOK+eI+BjRVm5Mi+yAT8ByBSv6haDAWR20Ft/0ZY7G6JwU4av3MuF7kre10i/WowCnanHWzlhet8w23v5zKfQ4VUObwBwpfNFzIxq8xTGhBXRVm3RLuz56gUF9Ms0Ky/khb1PxFR0R09Yww5uxuYWNR+63gp8b2k+Ej6Y5LgBST95UykVQWzYA1tm/WO15dKdYSmmaJCx6pH/jvbmAVohwnforZq0NP0eKX6IdtlKkhSuSjMaxDm44vMH/RX/VS6T62BUOCQlpDJ1N0oZqqks1JiSQhYOAsCbxy4NlZCgKQtDaSa4NRaP9uKES0tZhtlLfiGKMjGiXLzRNlfZvfEM0YPSl9IJeu60ijHgPP2C4Ohy7NzZX4MPOiTONzvMDh0iceLLdS0N48d/QTmm/3CHHisiQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(1076003)(26005)(107886003)(316002)(38350700005)(38100700002)(86362001)(36756003)(6916009)(83380400001)(5660300002)(52116002)(6512007)(6666004)(6506007)(9686003)(66556008)(6486002)(66946007)(8936002)(8676002)(66476007)(54906003)(4326008)(2906002)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YcnqT5bO2A0vmotIDxUiAvIG1iSYUjQTlm3jr1Bq68xIe5o45d9EsSfjy7wK?=
 =?us-ascii?Q?UhDKfxESEQ4jxn9yNFkrb6rtTuaZM5W6nOtwUwDBVjLcb3oMQYl/c+xLV218?=
 =?us-ascii?Q?BWyxhFMlqmOwmppCg6ydj1fn0QeULpnkyRBvn12lNhU2B3S1vVTBCoRxGeeE?=
 =?us-ascii?Q?/q06aR16kj6IfjQudlwvmjxpFuHxu7FQkkB05Y+C9KSjpHkVm+n9wrBW15Li?=
 =?us-ascii?Q?c5JMPE79vYk9hk0tihqow504X1Xx7qB135SbBHYzALTncY2I3+aX/wONwYCj?=
 =?us-ascii?Q?VMXmYhlXUKUpJoG8qWh9/fI9sKS864LoFN65nrx5uXY/Ha80CZIkV+qE3/Vj?=
 =?us-ascii?Q?weaPywIX5g+SqTSk7qXf+DffjTLR7GrQKL9N2o7fBkS8Prd+adKr6g3Mv/eg?=
 =?us-ascii?Q?ap2KswwPBSUn9nX8yOsn9WUYwiXGT/Aq5dX95ITEQPkeu8k4+fwYdYkmtmEJ?=
 =?us-ascii?Q?EJUNPZptdinKOwrEMLHE2g8x+WfZiU/g2iLcrzBmPF/ZYPLyjHIHkWGTD6PJ?=
 =?us-ascii?Q?p/2/Ytu1xWfzyzZjTUPg/z+MNwohaqWkkXwOxiZBHPHXFu2t6sPuzhJrugQl?=
 =?us-ascii?Q?sf2Ly514IVyUx8s6ErIThNQAf/ZBvygsS0gAkKjKUgCrcl8WAMNSzwp/qnKy?=
 =?us-ascii?Q?0DWjF6x7fjdChBr7dOPWxiyYlnStJCjqg1E1769uU9ORL0YRynQvvqG06DBD?=
 =?us-ascii?Q?E/3AcVl308/pwwCZ5wty2hYbha7V0F26jKj0wh2w8dRiV6F/cb7zMtrtfrIf?=
 =?us-ascii?Q?prWhtMgOwgcgpIAXixDMEKCt/o6mNU3U+W9QaRqrKssgwInxvfRXlzIIPJRp?=
 =?us-ascii?Q?aQxaJPmavcTsn4JdbKiAm/loD1Q6PlyMmRZ7DZYkmOffe3QoQZFPvtaY0MmY?=
 =?us-ascii?Q?HF5lNFEFw/ZRBZDT7ZVtVGl/pNoyfu85qrByq/fU7rpd2KHqAgjxgWIdTtCv?=
 =?us-ascii?Q?14ulOfAM+PiNIPTsuAZctjY0MeYvwihpNSCQJ9Ee0MljzFiURw0EsGWs3Rnk?=
 =?us-ascii?Q?uxzKXd/LwjTE358GIjQsK8psZm+xwgHfEAfJL3kSENrtpWyj/yix5B97jJNj?=
 =?us-ascii?Q?VFJuVv9noqMG/AuCqtlRPqds8e6WPXt8+FMlDPSUWnIQ3FNov9VdQuUx8tYY?=
 =?us-ascii?Q?vtzFvkcwPQg6zxs49k5sX831pxib4GlydB0wQCG/dPSrXa/usYiCDxljyjmy?=
 =?us-ascii?Q?mnNb54wgrzVCesWnEtE6rgs0LlbtEA8MlR/D/sbm9g1yhczENELpuQ8t8lNe?=
 =?us-ascii?Q?vQkd2nqyEYxkbnr9BnpyOMZ0avldC4POxrZnxwg/KfZw3X2EKpnbMrubCexb?=
 =?us-ascii?Q?CtrzaQQ5D86JhHibKNYhss/RQmCe6P3zpitHpjwzQpELDzAmLwikdU9rD6Qi?=
 =?us-ascii?Q?GJcXgehnpLti0o+QzSqmEVKDJJgo1J19oe2iAyp0S9PP5ouNdAkqiEaNtlTv?=
 =?us-ascii?Q?f3oy3BMv9RjZ0HxMqxBjKoHGvZT/HOtPZ97VlNsPcdIoYD+36CECzgoLW6Yr?=
 =?us-ascii?Q?DqicI58I/23xiBHMjSywbksH9NHnjxExfF38ZD6wq7O15fBa4eNt6XzmI6rx?=
 =?us-ascii?Q?K0DcBeWFxm8lO2tJEaQRYAwA0DG8Nm/ClumSUV3Fn7bx3/BGJpBuGfRnuoWv?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482e7c51-2747-4e1e-f50b-08dbfa43a347
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:21:01.3256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qkep1xbnckC/K+q0bUXX4fROmsAtv89VdGSMUbFXIGLU8MsKYOWMsmJS9Eo9olpGINbpXH0OIxAGpD63xYHjTA==
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

Forward '%p' format specifier to the underlying format logic in order
to print pointers, especially bitmaps.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

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

