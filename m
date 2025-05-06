Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248DEC3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 20:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F498007D;
	Tue,  6 May 2025 22:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Q65JqcTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 317B48056A; Tue,  6 May 2025 22:55:00 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5976C80050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 22:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaxspcEtClQNYQaavTcj004/wjxNK0h97wS3bR9GcvYRMyf9lf4c00laF6sPTGmKnY2yrMTyY76At9SOQaJx5ovvO2J6LMW0nTTntbyBRofotZ6cUwk2lWNNoXUgJJyMg7lGIYeH5KZ8hrWxA+oYzC6Ky0Oo4lr7OZqYks4UZZ+IVvLJC+rphK6fgWFNlfV7SiiqkydmsxXehaKz0EN7N+hpSJFg/ajjX7+gw+maBEY0nvPv7emVM3RUckAyl0sILp55VmU1p7kM+XmV+J8KuFBnVB99R253ukxXTlzIyGzUtv0nco9BsybjAFpn22sB3loLs4pg3P7h+KmzUDMjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy6CLIVhjyv8is8MpdinB52wUALKU1o+eHQhYKQ835s=;
 b=rlhD2jxslBW+h+/4P8NYMiI8YNG/jNwV28epzcs5yXBpf0RZbYWAJxUoAR4ckXO8oMihl+Z8xaXclIFH0hUtLCbL/Qf75tDB7g7WtvbiSRKQ49xpw2nuQJICoaUmkIawlUpyRGtidSi/YD1CjAuB9QBEqEoMJGdGr14pIe8MiWqxnXMYlV/uIoMfsOTilh+kRGkbLEQAjGc3kgZpvgHaJ1wPun55oiWf95FmFbO67oVblPtVnvoYiwIK/8dmLbgxnHJqzMnuu7Qwi8GH7njniK79wHf7bhX0hVDdPyQX4GbZOUo+eCvHNYTORJV2ux67t+OAv4NbKT1ZpHr48KBxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy6CLIVhjyv8is8MpdinB52wUALKU1o+eHQhYKQ835s=;
 b=Q65JqcTSKwWG/MYi9H4yCM6zUi7BQA4p6QlvNxnJ1SD9aclCzhbpUfta4o++nJPbj0OCxfMmE+dJ39w64Yf27OThNw4YRi90cPsO2hys5Tyzt2Lwu9Jgzdo+dVlrJQOyEh16xsPgz5EYfV+mX5XgtAwjSnLubvPEf0Jlbe4hnVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB8PR10MB3846.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 20:54:54 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 20:54:54 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] doc: document test command
Date: Tue,  6 May 2025 22:54:39 +0200
Message-ID: <20250506205439.415877-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB8PR10MB3846:EE_
X-MS-Office365-Filtering-Correlation-Id: 301989b2-0433-4d07-b54d-08dd8ce040a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hcyMSyq/d6RYROumkWX814gSjnDTHEzqE4mg44XFVCW+tlOAmOWL5XMccH2A?=
 =?us-ascii?Q?QPdifPERgW/+BZokCIpZj/fSMEBcxv9zntreYmTV/sxGPqRHeJ/QoY6Qe/KK?=
 =?us-ascii?Q?aHzL3605V8QqztGba2YGe6DmasIyAoKwfmqfjiMjmwsxjOXNqKWMolJ/c4Z+?=
 =?us-ascii?Q?lHrSr8B1JhLxI4GATFaNtzoSlY+inzxj8BT709Xljmxq75zK+JFFnjKJE4eu?=
 =?us-ascii?Q?wr9fAAXJbnQ0gIUvCTih4UD1xGCcyfeyTypr35XxwfQxu26nmvjIMR3WWa+f?=
 =?us-ascii?Q?P4RncMT3nsoWHitU536H6qur8TlZ+ZySRPpKBRCko4qZV8lDPVicFhOGt3to?=
 =?us-ascii?Q?g+cDda1RRGKzfoaSrNpepPmcqhxsulEi18vDWX1aN330Ebu9XaIzqCPv52MR?=
 =?us-ascii?Q?a2CTqr80L5uem3aZOTtHclNxvaVXxLtUWra+xGEzGoN+vsd0KM9EmbloRqZF?=
 =?us-ascii?Q?axv5E3aeiJ0I7Uguq+bJHzFgAw7JS5JlCeun5h3y7TO2ValfNaB5Q/IG6eOx?=
 =?us-ascii?Q?7sN5uv+JOzSMcHWSlPhWJaC5TsTL2OmcyqOcUwa6qI6HsshN6J5roXswkMRF?=
 =?us-ascii?Q?Jm9+xxfpM2XD5DDbzg2sZWZ+ALTq356HMRdGCpZMUtCXQxxyj3vxy4btQxHM?=
 =?us-ascii?Q?m+uWkvWN/q7l6SIe/KYb9Sm9UaPKrh+Oo3nzNgrto+Fq3LqnN7MhD5JE7zxX?=
 =?us-ascii?Q?MiJBCMREZSltE3oZrecq0QwSmkbVgztTwA0MO7XdpuIAk/7tYRF5xqykiB8Z?=
 =?us-ascii?Q?DdlszZReq5ywItHvXbX5ArfWBDGcuRAT3/dSPxjY2inxBAQXU/qVzDjOB92K?=
 =?us-ascii?Q?6g4H341a8cSQGU1cGyBTId14NM9FAg8HoX4dGAehfFn9uAF+r+qOHtb7+pVQ?=
 =?us-ascii?Q?1zuuos+sS8mGEiZozbTVIdWj09mRwEV6X5+gdv2B5S8o0NjSxhDrsaZRzqa8?=
 =?us-ascii?Q?y+TWgRqfJT8OpD0zEsCwyfAG52YVqDxtwOPqTuR739/8KTk5YhsnY2Ae269B?=
 =?us-ascii?Q?hWeZwykgKD76GAsP4j7ltuMksCI/I2HPPAuVmcFOWaNk1u/18F4ampMn+0hF?=
 =?us-ascii?Q?80nCcJLl0hIEbWnfslT9XonrS6+lV9C0PxwODPRu1VFiXSZedKCz3BcobLdP?=
 =?us-ascii?Q?leZEg960OO5W4LFultrTtGBfdlrWDA118at2ncQNpmk6ud6Id70TOxSRxC5J?=
 =?us-ascii?Q?EmjjCj4mGIuWkT80ET7F/gatvWvOoJvwz820BUZdjlzLLGutv6ZeACY6VgzA?=
 =?us-ascii?Q?sdaVakbKtAUB/tr47g1RUaodoeKeeYo48EtfI8taafjnj1LCjVzxW0kPLU9D?=
 =?us-ascii?Q?olaePomHIT56H23IWECWIzm0OZwbyL1+BRk1t4pCH3I+PTVQUFRR7mXj65QN?=
 =?us-ascii?Q?QU8l5zjvdQ2lw4xstBFCYnUQ2ahjVTOJadcrZvtVSYw7F4dWVNzKJIQa0Xgs?=
 =?us-ascii?Q?PP79KugHLb6XEizkkG804seuduJSKo1Smkqi4eAtdz6S7pd4T1fU4XKxIMVr?=
 =?us-ascii?Q?Kf80vuLCmFh79qc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8taPNHCW8w4WVhVzB6qvs0+cWXm34qSeJJCBebOLCqqXLGT1AYv+cHO0sMZ?=
 =?us-ascii?Q?/VXr6Jgaef4YZR2cC41BeOcD0he8CrJGZ8r2/LFl5xBZw4b1PXmYIsk9Qvb8?=
 =?us-ascii?Q?g6w0j2N8aEcLRTNy5xozqHJknlrLXRhylTlWo9KKEN4T0Ksz0n1/JPwQjBvU?=
 =?us-ascii?Q?jfsgjWGRrWXfJCPvj7zMYO/m4N7jPoUAht6uyYYpsJ2OX/98n6ZRckrbRpNE?=
 =?us-ascii?Q?OLqIucX58v4iU2T9O/4QLUMTcyX5sPQ6SbAxZqvUmS4ZADBK1TbQeqXIqNmh?=
 =?us-ascii?Q?H40MCP0gUjmSJ5VfRYHtzUGfxVaU//OTG8PcQKaiv75AG3FOY2ldTX8pQO20?=
 =?us-ascii?Q?dEgPLpaka7JLY/+H7GqsfnVy19AHdgaaZKPQaxyonLAKGt3SsKTGlbWiOYY7?=
 =?us-ascii?Q?KIIo5Vois7yVzBbJDIqPXcXs10WXr/2D8x4jujPu6jIonVs1UKMVObqXF2km?=
 =?us-ascii?Q?3SOHzaDiODdrYn0jEjj9MQRfxvC+21L3FoLEpfBKD9RuRzL65NL9h4KWThx2?=
 =?us-ascii?Q?NNmhUFp+GUyS0Vh49kY2usXsHq6Nuwvkaas9ihpoStHH5LksWtz2gR463LNr?=
 =?us-ascii?Q?hDyc6ohm68fJCCe5GmGMI6XqP2ees7NZ2N1NFcM6Oc0QUy5ynO9BBXGk/+8r?=
 =?us-ascii?Q?SQgREJ8+bbDoMQ6wB5Z9LW0oFCUj43DQsA4iZWiqdz8gfkRdo6NQ3/jzwabK?=
 =?us-ascii?Q?0bTFJXm9Xli0bnLVzrOvnTboH+IMoyNqLUq5tRzYCwe+hvEqvo7RvyvIarJA?=
 =?us-ascii?Q?TpQBU/08TGnW3I0TMq0iCzWOWZTp5/r2vlwYU+Oi+FQR9jVKdXguJuIZsxCY?=
 =?us-ascii?Q?FENCrjz77Io8DwXXorHvHB730CG6HGN3NvXx6/9Qm06tszB2brkiXyB9qu17?=
 =?us-ascii?Q?9mHQQYtrDDYbt4QAaGrcgTI76oDObtnBCnrdacG8GF1LI+aIMgzjOItaR0Hn?=
 =?us-ascii?Q?/FVSWcdz4P9ydBicl/yJfRE348AJrXaioYtJik28lbhP2ZteYOUBu8JSPDtz?=
 =?us-ascii?Q?xp5/waOmGTw1OfKe4A91gaZAjxLzyq1fZznrwE3v9FweUF4jlF6lE8mCCTjM?=
 =?us-ascii?Q?1jH0tN9EZsaT30WVwxYLCwDi5Bhyj+gZxPVBtYjYQMN+RCOdSAkyouP23V82?=
 =?us-ascii?Q?LSh6y3j0XqtM/ocDb6ACrLK+ash8rKDDZXhW4hL6/e88cx9fuFneekkmi/O7?=
 =?us-ascii?Q?MzWYE+ADA1CdxMSOgAumE+Zhkc3uXHmvqx+z4nQxM/L4vKX5ycaCIlVKwC2q?=
 =?us-ascii?Q?TdqId81rOWzZDRbSS3g067htYcsCLZHtAvVPWZG4rfudL6WcFeGVFfGVYc/y?=
 =?us-ascii?Q?QU+UQTAtnm+ska/my9GV9Pqmb6eWl65ixHJsz70ucjQ1LaxHtru8gN5CBv/3?=
 =?us-ascii?Q?HtcwFaOHURHI7d6BtNSAQV6FYw6A+UCpMqjfCwD7dAXN649bdbFclNmzFwRk?=
 =?us-ascii?Q?/J6jtLN119X43C4Uua9n4ASrpLZV+i0gsnnI7u0bzVd2mU5kgI41cN+ReE5Q?=
 =?us-ascii?Q?KvLogg5iLFQZhXF3GpHJTqY3JTo+jLju6knv5SAwIw4Edhn9M7Q3fL+FHpXH?=
 =?us-ascii?Q?r5BgK3NDHkI+TFOf88COPXmt46exHkNjEEMTC4BBuWe8QZc5rhDno6xrIjtO?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 301989b2-0433-4d07-b54d-08dd8ce040a6
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:54:54.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ocJr3g40Zy1Exo71Vhkcl2DbrwmIfoNoknwY7jgCAFrew/JDZnp5tnZfaxHq9Id0NK5awNCXhs4/pJXklteyPKK4+IicP9P5WnOEej2oto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3846
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

This should be considered on top of
https://lore.kernel.org/u-boot/20250506141035.385756-1-ravi@prevas.dk/
, but everything other than the regex-related stuff could stand on its
own.

My rst-fu is quite weak.

 doc/usage/cmd/setexpr.rst |  5 ++-
 doc/usage/cmd/test.rst    | 95 +++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |  1 +
 3 files changed, 99 insertions(+), 2 deletions(-)
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
index 00000000000..74ee4173639
--- /dev/null
+++ b/doc/usage/cmd/test.rst
@@ -0,0 +1,95 @@
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
+*Note*, however, that the numbers are parsed with ``simple_strtol(,
+0)``, meaning that they are treated as decimal unless there is a 0x
+prefix, any errors in parsing are ignored, and parsing stops as soon
+as a non-digit (for the selected base) is encountered. And most U-Boot
+commands that generate "numeric" environment variables store them as
+hexadecimal *without* a 0x prefix.
+
+For example, this is not a correct way of testing whether a given file
+has a size less then 4KiB::
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
+``<expr>``. The ``-o`` and ``-a`` operators perform logical or and
+logical and, respectively, of the two expressions.
+
+File existence
+~~~~~~~~~~~~~~
+
+Like ordinary shells, the ``-e`` operator can be used to test for
+existence of a file. However, the U-Boot version takes three
+arguments: The interface and device number (possibly including a
+partition specification), in addition to the usual path.
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

