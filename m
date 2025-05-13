Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A6FC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FA982AE2;
	Tue, 13 May 2025 10:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Xwf/xFK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA70982998; Tue, 13 May 2025 10:40:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F9382991
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxM8vaMS7F5U5UYBqCCRvVKtfE87xkkOCkEbrkmMotRgnKfveRdEzjHBIzxuOZpI7Mv0cmPvDY+B7IfrtIA1nLRMYrC+bPoMZ5RPd3TdDf2T98Lqxv7K3gjVBwdPGGWvVXp2TWUDLzMhd0JWCjKqYxDT1ozRgro0hyGh69LaRpv+nriusDlM3J/sqtnkc0OdBs+tzJnZUh0U1IJbTaB9a3RZz5Jg9bCqT2aTBmrPl4zQNjLqq5K7HgluO89ChnTklYI4Sy7eQArKAfzhBCKVsXpaKwMvLYdMV9t1RiCEIHoV+T5qwU4IGCfFfqGsG5KNgwVeH2AJyUzR01a6t3jr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol+0HnD11S6J5oX0pVEg2rhYDy+P9czXz+j49jGYY/I=;
 b=DqTGgzAEDu/EYYj4CyWdUl9xGbN2vqFCDTn4I5CmRsd8Ovwfi9uJ0WZLv98yUZyKu7d0JCjULEPSqzjpEXHUlhFzqpvg2zmGgikE+oaF2R6e0gkFjcwJc77DGbg5ZXAW650etIXYO4K+l+oEfV0k5x5cUyMtftSXn4aYTQUKEkA2c/jIrhrBohJQK1oPU5ec3eGgL9+bSO/J+jWlUfRtQywqAY6miqHMrfA1VULGVFrQomrP/akcG1qazJVhm7us9c7xUbbs5Vj4nJkZaoPsgx2xT7LM+JWB5/WIOhkOXEEEYgZM2X50d5cCp0ttgd77tPcDRec9W/s5Clvzq4O1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol+0HnD11S6J5oX0pVEg2rhYDy+P9czXz+j49jGYY/I=;
 b=Xwf/xFK4pQaeZr5MMxqCKpY4EBM/U9wX4S7Cq7Qw2/7y+zXWtmG6Ql/ZqO7TYDFo4ZbXOGnQqQF4gbTfXXvXKyu0LdJp4M6MdnjlK+agWPj/VQwsIe1p6zpMiJM/H6RF+Tt/oK3LSN8R+BIiFLgsNHCtOt9Azvf1i0WdLoqWJAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:40:53 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 12/12] doc: document test command
Date: Tue, 13 May 2025 10:40:34 +0200
Message-ID: <20250513084034.654865-13-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3693:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d2407e-73cb-4381-d411-08dd91f9dee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZPL1XVHk/UaWdS0rnsaQ2tiQjEOdyd+1q23cd3bnL1yMEJ9tkKXaZhVSOMlR?=
 =?us-ascii?Q?UnY6TDY59xr8h2rrk0X7o08vDyI6w5szCkARIEq27gWSUp2jqwMp31uno0Tq?=
 =?us-ascii?Q?BiwZ1bd22G6ODc4SlpJczR+zuKXFbFibrw9hhB9f8PNFoSBpmcUEKY84PFBH?=
 =?us-ascii?Q?i3eHKJAB0MU5fJC7Bexf6H6RGjW9cnqKcAVpVB0Hme+rfPuVFShqfkRcatIb?=
 =?us-ascii?Q?Da3DevoeNihwSG3tW1VVpMR7ll9FsrcJm1kEdfP4Xut+dKqHRAn36PhId4i8?=
 =?us-ascii?Q?9qTX4mzjpPne1EGAG42sRzNYk3IkYEyYQOfqSdvZ01xq4cImMg68sc6ZR92c?=
 =?us-ascii?Q?eFSssORVBhtRLSIRmYhyPmRej3q+aOCM3VZ7S13w0UTNu8c9AsW/fvOJa+zG?=
 =?us-ascii?Q?XvpoQWk3ZEiJkPhaKUUbqhj0ub9tPkYZyurEafMltvx1Uj8AB7diKzAn4YB0?=
 =?us-ascii?Q?JJyxZaeDG2BqmSdn7Tqbz0n7hM4fxYUnLZbgoez8E9xoFE1MqWFWrsiqVBaK?=
 =?us-ascii?Q?Jj2WGW2xzfbO02gJc31vco9PWOQ3D2MsuvxPe/lH77+r++73QQz/BFusJZfG?=
 =?us-ascii?Q?BwvGUyqcUV8Qz+vKCAwGmFjksAsyoO2vyO7Mpmpcf05MPz66E52uWTeJ1IzI?=
 =?us-ascii?Q?FGVdI1mQHzuHYbEcYvnoozV5juRs+zRBvO8HOwgaNiJ81Moar/8OfuViRKdW?=
 =?us-ascii?Q?0t3/FB7R+7OKFgxeMo8Wu8Ryzbc94buhvsja+tVZSQVd6r43CzDI4zTz4Xnx?=
 =?us-ascii?Q?1AAuMXq+XthFmgcIbu39MQSK3/8uiQQC6JaZpbon8yLE3hk68L/CC2fPs1IC?=
 =?us-ascii?Q?lBTPxw5zVIAkDaz2SMHRViLnQ3UHI7NzCrEx+MFMe24ypj0+h3HgCeBnbyZK?=
 =?us-ascii?Q?YjhUSv6Bu9Z7ik++128RjesUkWrWL4NiNiupswRsO5w55rSKD3uRnQtQe4W2?=
 =?us-ascii?Q?T3M2dZPaP5FSVllI8vKPY2EWWbLQEQR2kE0yddFLvbdUxsKTACt6+Nmovl11?=
 =?us-ascii?Q?CWrlL4wp2Q0LlxEkQi0GjR3Lv86dtf9AX3e8IRnymGXiDDXjtkRRlUNcea29?=
 =?us-ascii?Q?XmxOoEBUsFIATbch2YO/oc4VngFyaw6hymu8+QYheHcdbrjr9iXKOjaRZ5mk?=
 =?us-ascii?Q?WuH0QJwk4xsxUtcJIAkevWH3rpeWxoYwhbakwWxyaD7K2pKcgozoyBlLGYjf?=
 =?us-ascii?Q?pFM1q9rLy7ltVLjzAlZ+whivhod8FMqd04X14N3nDDwcqgK/3pCg8Zqzifck?=
 =?us-ascii?Q?hA9oDmohvsAvjrT0xy7tqgBS5rTnh3wjDRkZ4m5Jdlj3jp3a52Tsvu+k0N+0?=
 =?us-ascii?Q?rH1u165NAjuYwYx+I6VfWg0WyhF7OsnV+Hxu18qE2N7M+IfhGxPJJae/1XHG?=
 =?us-ascii?Q?32hv9I3cMw2ZKMmU6U59WhHBr3Z2wy4nAnMnfCEf6oEntyuWXFvl79+ZbP4H?=
 =?us-ascii?Q?phrfzgad1FamaZmakIBhLjQK2VZD9+fGDFNyAmhkXSlCkN20j/VnBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drdJWBORm7AiAXknYjxv5ensgIKWd243EQGJCPiFlvdqUiHsHfOWIv+mzzxy?=
 =?us-ascii?Q?CmfOvguuXpWsEbT4Tz6JF5VdbLefjgjynosOzQWLV0Pz2/wGF1NcO8V2ns00?=
 =?us-ascii?Q?B0KCCVgj9mUZ4AmGIGKObkaDSvgrn4G8fJbqv1J3tad/rXCCrkH5cjUiBkwp?=
 =?us-ascii?Q?ZfkbgQ+uBbAn3ajRF11ovKLHYIqW6YMBCykAIBlFBSysJJ5Z2zS+qARLTxn3?=
 =?us-ascii?Q?DzvURgBMXcT/Y1lYHeFvQ1dNifkIOnrOOKbSxMZPLgIK4QxBZtPdpa/DrIpp?=
 =?us-ascii?Q?FKpIj6U0KmQs3hDdjdzej0V+a/gM66MZTDFJl58SImHO65zRsXkivabccpKM?=
 =?us-ascii?Q?gAsSOB8J7aWBMfKGqXiZi8MRfg164gLIxAtDKV9M7/BkUWHXjKlAmCtBuZ+4?=
 =?us-ascii?Q?QtAC9J9bmA7Bhzk+Mv0GimNo30udCRWccU35Mi66Zno14RJooSKmGS2U0wGE?=
 =?us-ascii?Q?hyyHO8D0YgZC885tqAGwYSthGg55+245+Kp5AtKoIcpzPdaPvLkKrpyut+yd?=
 =?us-ascii?Q?7ATDKZfbcbH59eBmTbxG9OBsMfyAsmB/MIrpMuESOmsx3jhX1k5cLJcrIQpx?=
 =?us-ascii?Q?v1LK3wZwlSKtqr7/pxy7Dd9P2L04Txljq2B60E9VvsP7kCMhPJquY7FbYvJc?=
 =?us-ascii?Q?/+ESAAuYOqVP+xy4wlhPgp8wY3qH/LCgFAdHqZHCI/Lcdt2cu9BcOFIxr2Ig?=
 =?us-ascii?Q?fHlVF71bYWF3I0tZenkj+K7NTSYwgznTEeRR7Od2fhEI+EPxaTjDwoB0yrDT?=
 =?us-ascii?Q?90WAjnFf2fDCZCKIq2ryuJVAX7gsEHF1f5p7+6KbojWVwaYdewMbo3u33oFB?=
 =?us-ascii?Q?IbdJtvueBhHTGQXEjUktwjo6wMGJux0MBvzD6j/gdF7WE3IeS2I4I4bZqECn?=
 =?us-ascii?Q?fMss3JW7R4yV8x+I76w9GBEEp8Gamg8R2+XkqkhxV40nq4+WRJPUDlVHCSG4?=
 =?us-ascii?Q?92u0ARthjbu5HmEJ0FN+OBAhqQBdWzDnAS65LaUdssBSAazc5fp/iOMDm0ZP?=
 =?us-ascii?Q?7lT/j8bjFF7g0MNVz+2N2XANSl+wpAUG5tr/2L3hiAUXNI9JxpIsdImKWDFR?=
 =?us-ascii?Q?ksFbU2Ee3xTX/V4v3k1OJzYQEK63cQZL8p3r2NItx/XvS6T7Zr8H/JuGHRr7?=
 =?us-ascii?Q?Xb1QsNl5MDv5uqDIjRTlHqMy6KtqiEvrFZcOjqCBiUZXg23HGyvkaaJx0XQw?=
 =?us-ascii?Q?d4Z0q1FCVf7JaemHfCWgGet11zXFs8Xnur3nKthiVOpg2fybwLqcBUe5QfVp?=
 =?us-ascii?Q?upVwzzvkPc/ggx1ZN1Tmqosl/VmxaMbXS4TjVg/yPJ/XgcxkUZmiYE5xzewQ?=
 =?us-ascii?Q?rerYTQiB3qYuqqOeV8hGz/b7f4vt4Xpcain32T/iZoxC3hYr2ihSRFzD7BDX?=
 =?us-ascii?Q?0H+EUpEwCZUG6/eQtauFLrvdC5t1ZhTPK7Mc4EidjRfHcWwjxMpk5lV8HaJn?=
 =?us-ascii?Q?swfSOeqQ//TwOWPpwQMt2PS6cCobq9U2pWaWucrtTKFTiEXzgtmq66TA5aCB?=
 =?us-ascii?Q?r7wOi0+H6XCaSZQYXqWvXJACI3OOdUajfmncc9ipa8rqouvL1Kd7kiXK+W+0?=
 =?us-ascii?Q?+8mdkk24ioMWTe2mEtu45xtoLNFxHcD60XjCdYOUmT9T2xpFgysHMmctSpGm?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d2407e-73cb-4381-d411-08dd91f9dee4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:53.0284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QRPNPubXu9L2nlWJIw4A2JmdRORu0ImxNA9Xfze1UDXGEvRcnmikn/RtG0AqpmeuGijdJ4JyHBsM6Kj9wL6T33wFDjX7+0WltYPlfodz34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3693
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

Add documentation for the test command, including the newly added =~
operator and some gotchas wrt. the numeric comparisons.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/usage/cmd/setexpr.rst |   5 +-
 doc/usage/cmd/test.rst    | 102 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 3 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 doc/usage/cmd/test.rst

diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
index 593a0ea91e1..5bc37ae50fc 100644
--- a/doc/usage/cmd/setexpr.rst
+++ b/doc/usage/cmd/setexpr.rst
@@ -144,8 +144,9 @@ Configuration
 
 * The *setexpr* command is only available if CMD_SETEXPR=y.
 * The *setexpr fmt* sub-command is only available if CMD_SETEXPR_FMT=y.
-* The *setexpr gsub* and *setexpr sub* sub-commands are only available if
-  CONFIG_REGEX=y.
+* The *setexpr gsub* and *setexpr sub* sub-commands are only available
+  if CONFIG_REGEX=y. For an overview of the supported regex syntax,
+  see :doc:`test`.
 
 Return value
 ------------
diff --git a/doc/usage/cmd/test.rst b/doc/usage/cmd/test.rst
new file mode 100644
index 00000000000..d1379117fca
--- /dev/null
+++ b/doc/usage/cmd/test.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. index::
+   single: test (command)
+
+test command
+============
+
+Synopsis
+--------
+
+::
+
+    test <str-op> <s>
+    test <s1> <str-cmp> <s2>
+    test <n1> <num-cmp> <n2>
+    test ! <expr>
+    test <expr1> -o <expr2>
+    test <expr1> -a <expr2>
+    test -e <interface> <dev[:part]> <path>
+    test <s> =~ <re>
+
+Description
+-----------
+
+The ``test`` command is similar to the ordinary shell built-in by the
+same name. Unlike in ordinary shells, it cannot be spelled ``[``.
+
+Strings
+~~~~~~~
+
+The string tests ``-n`` and ``-z``, and string comparison operators
+``=``, ``!=``, ``<`` and ``>``, work exactly as in ordinary shells.
+
+Numbers
+~~~~~~~
+
+The number comparison operators ``-lt``, ``-le``, ``-gt``, ``-gt``,
+``-eq`` and ``-ne`` work as in ordinary shells.
+
+.. note::
+  Numbers are parsed with ``simple_strtol(, 0)``, meaning that they
+  are treated as decimal unless there is a `0x` prefix, any errors in
+  parsing are ignored, and parsing stops as soon as a non-digit (for
+  the selected base) is encountered. And most U-Boot commands that
+  generate "numeric" environment variables store them as hexadecimal
+  *without* a `0x` prefix.
+
+For example, this is not a correct way of testing whether a given file
+has a size less than 4KiB::
+
+  # Assuming readme.txt exists, sets 'filesize' environment variable
+  $ size mmc 0:1 readme.txt
+  $ if test "$filesize" -lt 4096 ; then ...
+
+If the file size is actually 8000 (decimal), its hexadecimal
+representation, and thus the value of ``$filesize``, is ``1f40``, so
+the comparison that is done ends up being "1 < 4096".
+
+Logic
+~~~~~
+
+The ``!`` operator negates the sense of the test of the expression
+``<expr>``.
+
+The ``-o`` and ``-a`` operators perform logical OR and logical AND,
+respectively, of the two expressions.
+
+File existence
+~~~~~~~~~~~~~~
+
+Like ordinary shells, the ``-e`` operator can be used to test for
+existence of a file. However, the U-Boot version takes three
+arguments:
+
+- The interface (e.g. ``mmc``).
+- The device number, possibly including a partition specification.
+- The usual path argument, which is interpreted relative to the root
+  of the filesystem.
+
+Regular expressions
+~~~~~~~~~~~~~~~~~~~
+
+When ``CONFIG_REGEX`` is enabled, an additional operator ``=~`` is
+available. This is similar to the same operator available with bash's
+extended test command ``[[ ]]``. The left operand is a string which is
+matched against the regular expression described by the right operand.
+
+The regular expression engine supports these features:
+
+- Anchoring ``^`` and ``$``, matching at the beginning/end of the
+  string.
+- Matching any single character (including whitespace) using ``.``.
+- Character classes ``[ ]``, including ranges ``[0-9]`` and negation
+  ``[^ /.]``.
+- Grouping ``( )``.
+- Alternation ``|``.
+- Postfix qualifiers ``*``, ``+`` and ``?`` and their non-greedy
+  variants ``*?``, ``+?`` and ``??``
+
+For extracting the parts matching a capture group and/or performing
+substitutions, including back references, see :doc:`setexpr`.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 372ef56c967..c5b45fd9290 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -123,6 +123,7 @@ Shell commands
    cmd/source
    cmd/tcpm
    cmd/temperature
+   cmd/test
    cmd/tftpput
    cmd/trace
    cmd/true
-- 
2.49.0

