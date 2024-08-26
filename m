Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B75C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A69889FC;
	Mon, 26 Aug 2024 14:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=weidmueller.com header.i=@weidmueller.com header.b="nrCmt1eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736F288001; Mon, 26 Aug 2024 14:51:24 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8BA8895B
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoCHU3fRsA9WvBGh8852d5ygm7NnfiOzBvpXm006nZ0UIjgak7h6Q2LTOcrUiAD6t+Yg6qVIinlf4eiRHPTtzFASNvIkLQyraogGt0FMEGku3N+oX6SxFWzrG5ZgPjuoT9osoN+YN1O0lJaTpRaN9fHMwqMwmF8rYRlHvtjZymyRFxnvVzZEYZpuLPanLN4bFJImrsfzWRjPPZFE01NXV0NCcsgzCdgC7varzqGdysQpzyGjk3BDKxtpZg8VnZRThzCtH005fFarWkOar+uc4RkKp+6VB0H8K61qnDSnRyEUKWFTy2CWz//2WoY//QO8AvESeroxjvfxwoxOWSVbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkxOvhTDaSCzB0wnF4te9nYLFHgdSDNaklfou3wswfY=;
 b=ZlW088cldflSeLMkxgc803muAtJ/fXolyy2YuPHS5WRjblL7GamR3KC7r2Qw8s6KXjN1AQ8H4lqvPfJdcji999c4s3mPCuJgHQu5qsSUCAFnZqGDrzc/UF1odNZG+oh39whsb78p/f4id+3AGd9dEgvljtiVfz5UQhwaNok6MvEyI89AnW0/1OgRtxCfPRRlrzgq+3ijNwSKz0fmPNj/u1142c0HZ7DbMr+CSk7Ak0gMwqpmlqzOOa+Rs6snVIPW1eSjZvIcjBQj+9xrV3S/Fr+NrvSoFmq9E2sb7D7XVkRA7ANuo5SYkLg7RTwDrwYbrqZ1B0CXeqwxnl389n6tOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkxOvhTDaSCzB0wnF4te9nYLFHgdSDNaklfou3wswfY=;
 b=nrCmt1eUeB4edpfW/IMLNN6H5klZIW+Uw6Tpl+AzKszlcHT3if/qhMBW4sDT84Op3UcORkR6Tctk+VT0fL8ZIefXKFKRzFmvLSzeafYUNZGXDQ5BSofLoA1+0XvpfCRL14OOfTiHtFU6qCorbh53C+cO+RRVNs+6d4oAYR+0SZ2AZ6Eq90Pa/EUaY3KOptKkimA+wX8nblhih8OgdgAW9PhGCDnhAKKHOi1CRP/VrXr6P/4vfDLzm7SALkMohoF8wQuRRAt41p0quc7q6sRy4Nz9/x4PuKMhiEqQaO5jlkqCu6qdiIsdroRIY94xklnzCzWfGnWZEziMEMcYLjGyVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB6534.eurprd08.prod.outlook.com (2603:10a6:20b:31c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 12:51:19 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 12:51:19 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 1/1] env: introduce variable ranges
Date: Mon, 26 Aug 2024 14:51:11 +0200
Message-Id: <20240826125111.1332215-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826125111.1332215-1-lukas.funke-oss@weidmueller.com>
References: <20240826125111.1332215-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: ee42a18c-bc04-4b0b-db48-08dcc5cdc7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rhJdQQ5EtaZnprKTYkyq8slJ6DQ09qBw0AKmKo65m1OaobBcmgZuYzzbFsb8?=
 =?us-ascii?Q?++DeQzJi/EB1oj3zZ80iwQ+B5MO/wA/A0jqd6ShWdY+JUa+8jPYbvrJsCDVE?=
 =?us-ascii?Q?VHFvS9IXhTYTuTVVBovCnRhb31RZeM6X9kOnyaaVxjjMmrYXDWqzBz7eZf6T?=
 =?us-ascii?Q?Gwy7lDTgK3QCjHTtKjrFk0yKkTJct2sF/vjNLI6Vl8qrbwikP3gzELm6bUJM?=
 =?us-ascii?Q?0ZR9mC4Qg0x7l2O8lVGWVa9gxVTM+lg4lpHba41+qgZ5vQsfINplIYgTcYZF?=
 =?us-ascii?Q?gIuOK9dq3icysE8sn38rI4jT7YWGiyd/cdBXdGsOkpptSebFeMWT0Il1OF98?=
 =?us-ascii?Q?LkkAp0cX2HPLfT3kmWQM59KzN6a3f42MMxpCoU1hgxfvGSHsrhw6sC+nLHuw?=
 =?us-ascii?Q?afJWh33U4efLaeS/kCCY/E98iise+HCR2kgdR/Tz8JJLKl/lDL3M9F9iGhMX?=
 =?us-ascii?Q?K5vVh3VJHQbFbFmbYFp0cga/hh78syfJS9DkKU47roBVjqh3pNDC3dfyfdK3?=
 =?us-ascii?Q?ggwgGkSsgoKP1NXaZErY65CbAKKot5HvTmTG29n80zUEuSL1O1ww/QKzl0Y0?=
 =?us-ascii?Q?vBCq+6Gx0sCp5XN743iKph4Hq9cu73BiW01CrifsyNbFCm8puqKGXinXsS3D?=
 =?us-ascii?Q?MzOhB6E3zuF8dgyNG01PaxoslNnkAeUcOdDMs57dBr3+EWOJY05wS/Z7Vusw?=
 =?us-ascii?Q?q4VMdLFyId6HOypWwLeehFOt8czdRkS/p9Y+ZebcxrWMiZEBW3+grhbFSGLw?=
 =?us-ascii?Q?Yl+HbDsQisr6HPVGGutsC64oU1iXM8GbytfV+yJa+Rvl2+Soe6FSgoZZRYsE?=
 =?us-ascii?Q?vjLQw+2DElb9mqEnSLFEGjAnick9X2jE5QUKlw1PPWt7sqxMwo37qvRlEDFE?=
 =?us-ascii?Q?8qL7DnpqB1SJJLlap3RsaSiAk8ws+Yj4XXhCw7s9YEVUYU5nuVODrqNumpAT?=
 =?us-ascii?Q?0IgEL3Nn/q2T8JsUkcj6zJXWMCyg4MQNDGhX72LUJdHFWXXx8YiM+7xtCp+a?=
 =?us-ascii?Q?mXFKmGoxDcSRCF1ZpX40J7S0nT37ZUtLx4dvzjXOb22sybHpnEKMxgrOP2C+?=
 =?us-ascii?Q?gmrVj54Lm4Q8QFn91IzsNw0Eza68ng+hCIWzI3lN8qFAlLvlrB7mrOZhCehG?=
 =?us-ascii?Q?JUX8R7AjU22qiLQ8AhXvBOdezmKckrSwx34R5l7TdWS8kcHfTuQtMTtut3y6?=
 =?us-ascii?Q?vvDmzSvpeqzJ4n2LGTyG43u0kiwvm4/cPO8qCHfrGLJkHr6GfYte03Ju6lVK?=
 =?us-ascii?Q?bBID0BTJotntkabqtveGpd4tGij2WKXT9Fnz2jljVbUbh1Wd6xX/Go404A+H?=
 =?us-ascii?Q?sqI7nQneW+MyJrdWBzdpmjxFmchbHK2hhFxFXYOCJrdgEBDSaHWLewzOmpzE?=
 =?us-ascii?Q?Oj+dyZ2DUVq0NnuXRT1Yn+VKT7EeDrhdTcF+DM3z9B4m2CGVew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Hv6fBcKv9jvHDN7upjUBE6D4YrYLUQSE3oHveLsiNAQDArc4wz7sgqrKJBo?=
 =?us-ascii?Q?erV/fjHZv99Y16tcP0e/ZOJTHKLycFxtSZ++xHtKseozD6myt2ghMZ9BdcCY?=
 =?us-ascii?Q?I2OVlA3+k6job/Yv8jO38t8Vzo2Ulqe8glXnIhQqTnMCESbxaF+eYNGtIleB?=
 =?us-ascii?Q?FsUW0y2ZqQzY2oFKdY4rHTJqXymbYB0p1z/xanWTd2q5G51LwVDnxrkfqepI?=
 =?us-ascii?Q?IZP6/627P+cv5uZzHdTsXVEf6D6Xb9v69Zbosnv2l8Z+R+I+JLl0ZfYoT0vC?=
 =?us-ascii?Q?UKcBF2Ve4sT1cBCBhKuN4LLa0IgYJObbqmS4KlMuy9vbc3/yHtfmWsH6dUgi?=
 =?us-ascii?Q?VvH5ZYwgDzxJds1OzY7K4jnGk1XkzXI3n6Gs5NAMkjPQmAeqV9QEnKvAlLC2?=
 =?us-ascii?Q?5fBdraj39JtkWIMYJ9gNqNTbo8M3D/aRM9G36jxxSFYDSIJb9LNthcuqOxD1?=
 =?us-ascii?Q?aUGqU0GYTGiV48Q4wIrbBj8HVWHQWbuHbTEELNc5r7qkG+Jc/iUAnu+1EYdb?=
 =?us-ascii?Q?jmrhjO9yhS8fhLVJ52GxsiBotJOm+l3BzjQj1SLCKdEiscvB0DLth4s5bBvT?=
 =?us-ascii?Q?8cKi3JDNw/0w5SIryGYEYdZGKhW839DuygizTsdrPSE4FM5vI4duhlzvB953?=
 =?us-ascii?Q?eahXbtghZRMi8zMTNOXktEpYJN+PmyO+ujTYk71xr5raW0LZCVK+RbiWuI+9?=
 =?us-ascii?Q?hx+GwVlmlPLCw3W7kN3V2sWRlIhdAu/amwpN97n4wm6hkSg28ZPHeCwp+flK?=
 =?us-ascii?Q?SiuKy72T8Hhkz0GuhtjMKAWUSG2nB9leDt+TU8xHryOmNoA3zpIBM4zrFvc/?=
 =?us-ascii?Q?FAOGbr5FT5sB0wtSoMZymPSmW024JrJMgALSdk0+UJ9DlntmGyeeWspp9xRr?=
 =?us-ascii?Q?sQHXouRb5a6OqjR7Ad3wcsipZF8+zTsGEhjcN1iSp6E0zLDBStQvyq03CVbC?=
 =?us-ascii?Q?nlBMth5JkmqRta+1M3ekE8T7DNUqiTZokO2Suu8Wzf4unBlI2nVI3lvzZqcN?=
 =?us-ascii?Q?sv+rNmA04JVwvYTyMZfa23rn4Y3mBPgviFu4ZMCkgOykVmiAu8QBhi8h5pm5?=
 =?us-ascii?Q?30RBipBnaZCKB9LnA3QLKykpCDL1cS3oBEox9iJJ+MvWtldmVG/vj2xt6zbX?=
 =?us-ascii?Q?ONrxlQKwTIb0y4dmkaArOzXHpfsI1XnzNzfE78DtnZ2HMrpOi1h0Gx1aPUcb?=
 =?us-ascii?Q?EVxE4Qs4xTbuPCVlqrlHhs/zLuU1TsVHM9LP8AsakFN2RS1kboJec0RSTbQ8?=
 =?us-ascii?Q?sqwDjfIMkl8tSOoH8isAXwuufjOaXx34dKlBGjw8YrbnStllGCXKeRlAtR62?=
 =?us-ascii?Q?a8MggzLTU+YK+qOSK9YMwOBHkk5GP/sjPXbIUtGdKE4YtBkXWnTQjSFuISkU?=
 =?us-ascii?Q?nRWMD3XHqLGm9FxQxQw/3vhkYnHvciF0moaPaVMTkQ11+LmeatipzsocMdSH?=
 =?us-ascii?Q?stZcti1kxSc5BiAKQhqSvkE5NnDgaDsPStLgKOfraQeUU4u9OqsKe/5QOiV7?=
 =?us-ascii?Q?3KC0RrkgeWzihnjycp+WS6tzon94upmxewyI6hZNE6+JdRzMY7B7rKNpgP8/?=
 =?us-ascii?Q?EArM5TkzeCdwmcbzpvasMHJWD8xCJCzxNv4yODThPyo+gf/3752mMTqaGGbt?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42a18c-bc04-4b0b-db48-08dcc5cdc7f1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:51:19.5072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juc8gYP6y42CMEcRkVC6LF7hbhCTRiIXhkJhSQeOA1+eN8m92GFJbYm2w4iS9sgruxIeeiQZuMBhMc6reATiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6534
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

This commit extends the flags-variable with ranges for environment
variables. The range is appended to the variable flags using
the '@'-character. A range can be decimal (min/max), bitmask or regular
expression (64 byte).

Value ranges for variables can be used to make the environment more
robust against faults such as invalid user input or attacks.

Decimal-range:  foo:da@<min>-<max>
Hexadecimal-range(bitmask): bar:xa@0xdeadbeed
Regex-range: mystring:sa@r"klaus|haus|maus"

Example:

	"decimalvalue:dw@100-200,"
    ...

=> env set decimalvalue 1
1 < 100 || 1 > 200
=> env set decimalvalue 150
=>

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 cmd/nvedit.c              |  30 +++---
 env/flags.c               | 217 +++++++++++++++++++++++++++++++++++++-
 include/configs/sandbox.h |   5 +
 include/env_flags.h       |  27 ++++-
 include/search.h          |   1 +
 test/env/Makefile         |   1 +
 test/env/range.c          | 113 ++++++++++++++++++++
 7 files changed, 377 insertions(+), 17 deletions(-)
 create mode 100644 test/env/range.c

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 98a687bcabb..f02545c7a55 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -352,10 +352,13 @@ static int print_static_flags(const char *var_name, const char *flags,
 {
 	enum env_flags_vartype type = env_flags_parse_vartype(flags);
 	enum env_flags_varaccess access = env_flags_parse_varaccess(flags);
+	struct env_flags_range *range = env_flags_parse_varrange(flags);
 
-	printf("\t%-20s %-20s %-20s\n", var_name,
+	printf("\t%-20s %-20s %-20s %-20s\n", var_name,
 		env_flags_get_vartype_name(type),
-		env_flags_get_varaccess_name(access));
+		env_flags_get_varaccess_name(access),
+		env_flags_get_varrange_name(range, type));
+	free(range);
 
 	return 0;
 }
@@ -364,6 +367,7 @@ static int print_active_flags(struct env_entry *entry)
 {
 	enum env_flags_vartype type;
 	enum env_flags_varaccess access;
+	struct env_flags_range *range;
 
 	if (entry->flags == 0)
 		return 0;
@@ -371,9 +375,11 @@ static int print_active_flags(struct env_entry *entry)
 	type = (enum env_flags_vartype)
 		(entry->flags & ENV_FLAGS_VARTYPE_BIN_MASK);
 	access = env_flags_parse_varaccess_from_binflags(entry->flags);
-	printf("\t%-20s %-20s %-20s\n", entry->key,
+	range = (struct env_flags_range *)entry->range;
+	printf("\t%-20s %-20s %-20s %-20s\n", entry->key,
 		env_flags_get_vartype_name(type),
-		env_flags_get_varaccess_name(access));
+		env_flags_get_varaccess_name(access),
+		env_flags_get_varrange_name(range, type));
 
 	return 0;
 }
@@ -401,19 +407,19 @@ int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	/* Print the static flags that may exist */
 	puts("Static flags:\n");
-	printf("\t%-20s %-20s %-20s\n", "Variable Name", "Variable Type",
-		"Variable Access");
-	printf("\t%-20s %-20s %-20s\n", "-------------", "-------------",
-		"---------------");
+	printf("\t%-20s %-20s %-20s %-20s\n", "Variable Name", "Variable Type",
+		"Variable Access", "Variable Range");
+	printf("\t%-20s %-20s %-20s %-20s\n", "-------------", "-------------",
+		"---------------", "---------------");
 	env_attr_walk(ENV_FLAGS_LIST_STATIC, print_static_flags, NULL);
 	puts("\n");
 
 	/* walk through each variable and print the flags if non-default */
 	puts("Active flags:\n");
-	printf("\t%-20s %-20s %-20s\n", "Variable Name", "Variable Type",
-		"Variable Access");
-	printf("\t%-20s %-20s %-20s\n", "-------------", "-------------",
-		"---------------");
+	printf("\t%-20s %-20s %-20s %-20s\n", "Variable Name", "Variable Type",
+		"Variable Access", "Variable Range");
+	printf("\t%-20s %-20s %-20s %-20s\n", "-------------", "-------------",
+		"---------------", "---------------");
 	hwalk_r(&env_htab, print_active_flags);
 	return 0;
 }
diff --git a/env/flags.c b/env/flags.c
index 233fd460d84..dc0a9c5764f 100644
--- a/env/flags.c
+++ b/env/flags.c
@@ -20,6 +20,9 @@
 #else
 #include <linux/kernel.h>
 #include <env_internal.h>
+#include <vsprintf.h>
+#include <malloc.h>
+#include <slre.h>
 #endif
 
 #ifdef CONFIG_NET
@@ -34,6 +37,8 @@
 #define ENV_FLAGS_WRITEABLE_VARACCESS_REPS ""
 #endif
 
+#define ENV_FLAGS_RANGE_SEPERATOR '@'
+
 static const char env_flags_vartype_rep[] = "sdxb" ENV_FLAGS_NET_VARTYPE_REPS;
 static const char env_flags_varaccess_rep[] =
 	"aroc" ENV_FLAGS_WRITEABLE_VARACCESS_REPS;
@@ -115,6 +120,35 @@ const char *env_flags_get_varaccess_name(enum env_flags_varaccess access)
 {
 	return env_flags_varaccess_names[access];
 }
+
+const char *env_flags_get_varrange_name(struct env_flags_range *range,
+					enum env_flags_vartype type)
+{
+	static char range_str[64];
+
+	if (!range)
+		return "";
+
+	switch (type) {
+	case env_flags_vartype_decimal: {
+		snprintf(range_str, sizeof(range_str), "%lld-%lld",
+			 range->u.int_range.min, range->u.int_range.max);
+		break;
+	}
+	case env_flags_vartype_hex: {
+		snprintf(range_str, sizeof(range_str), "0x%llx", range->u.bitmask);
+		break;
+	}
+	case env_flags_vartype_string: {
+		strlcpy(range_str, range->u.re, sizeof(range_str));
+		break;
+	}
+	default:
+		return "";
+	}
+
+	return range_str;
+}
 #endif /* CONFIG_CMD_ENV_FLAGS */
 
 /*
@@ -151,6 +185,9 @@ enum env_flags_varaccess env_flags_parse_varaccess(const char *flags)
 	if (strlen(flags) <= ENV_FLAGS_VARACCESS_LOC)
 		return va_default;
 
+	if (flags[ENV_FLAGS_VARACCESS_LOC] == ENV_FLAGS_RANGE_SEPERATOR)
+		return va_default;
+
 	access = strchr(env_flags_varaccess_rep,
 		flags[ENV_FLAGS_VARACCESS_LOC]);
 
@@ -211,6 +248,138 @@ static void skip_num(int hex, const char *value, const char **end,
 		*end = value;
 }
 
+struct env_flags_range *env_flags_parse_varrange(const char *flags)
+{
+	char *range;
+	struct env_flags_range *r;
+	enum env_flags_vartype type;
+
+	if (!flags)
+		return NULL;
+
+	range = strchr(flags, ENV_FLAGS_RANGE_SEPERATOR);
+	if (!range)
+		return NULL;
+
+	range++;
+
+	r = (struct env_flags_range *)malloc(sizeof(struct env_flags_range));
+	if (!r)
+		return NULL;
+
+	type = env_flags_parse_vartype(flags);
+
+	/* parse regex range r"someregex" */
+	if (!strncmp(range, "r\"", 2)) {
+		if (IS_ENABLED(CONFIG_REGEX)) {
+			if (type != env_flags_vartype_string) {
+				free(r);
+				return NULL;
+			}
+
+			char *rstart = strchr(range, '"');
+			char *rend = strrchr(range, '"');
+
+			memset(r->u.re, 0, sizeof(r->u.re));
+
+			if (rstart == rend) /* invalid format r" */
+				return NULL;
+
+			rstart++;
+			if (rstart == rend) /* empty regex is okay */
+				return r;
+
+			if ((rend - rstart) < sizeof(r->u.re))
+				strlcpy(r->u.re, rstart, rend - rstart);
+			else
+				return NULL; /* too big */
+		}
+	} else if (is_hex_prefix(range)) {
+		/* parse bitmask range 0x[a-fA-F0-9]+ */
+		if (type != env_flags_vartype_hex) {
+			free(r);
+			return NULL;
+		}
+		r->u.bitmask = (u64)simple_strtol(range, NULL, 16);
+	} else {
+		/* parse integer range [0-9]+-[0-9]+ */
+		s64 min, max;
+
+		if (type != env_flags_vartype_decimal) {
+			free(r);
+			return NULL;
+		}
+
+		char *lhs = strcpy(r->u.re, range); /* exploit regex buffer */
+		char *rhs = strchr(lhs[0] == '-' ? lhs + 1 : lhs, '-');
+
+		if (!rhs) {
+			free(r);
+			return NULL;
+		}
+
+		*rhs++ = '\0';
+		min = simple_strtol(lhs, NULL, 10);
+		max = simple_strtol(rhs, NULL, 10);
+		r->u.int_range.min = min;
+		r->u.int_range.max = max;
+	}
+
+	return r;
+}
+
+static int _env_flags_validate_range(const struct env_flags_range *range,
+				     enum env_flags_vartype type,
+				     const char *newval)
+{
+	if (!range)
+		return -1;
+
+	switch (type) {
+	case env_flags_vartype_decimal: {
+		s64 value = simple_strtol(newval, NULL, 10);
+		s64 min = range->u.int_range.min;
+		s64 max = range->u.int_range.max;
+
+		if (value < min || value > max) {
+			printf("## Error: value out of bounds\n"
+				"%lld < %lld || %lld > %lld\n", value, min, value, max);
+			return -1;
+		}
+		break;
+	}
+	case env_flags_vartype_hex: {
+		u64 value = (u64)simple_strtoll(newval, NULL, 16);
+		u64 mask = range->u.bitmask;
+
+		if ((value | mask) != mask) {
+			printf("## Error: value out of bounds\n"
+				"value = 0x%llx, mask 0x%llx\n", value, mask);
+			return -1;
+		}
+		break;
+	}
+	case env_flags_vartype_string: {
+#if defined(CONFIG_REGEX)
+		struct slre slre;
+
+		if (slre_compile(&slre, range->u.re)) {
+			if (slre_match(&slre, newval, strlen(newval), NULL) == 0) {
+				printf("## Error: value does not match regex\n"
+				       "value = %s, re = %s\n", newval, range->u.re);
+				return -1;
+			}
+		}
+#endif
+		break;
+	}
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_NET
 int eth_validate_ethaddr_str(const char *addr)
 {
@@ -241,7 +410,7 @@ int eth_validate_ethaddr_str(const char *addr)
  * with that format
  */
 static int _env_flags_validate_type(const char *value,
-	enum env_flags_vartype type)
+				    enum env_flags_vartype type)
 {
 	const char *end;
 #ifdef CONFIG_NET
@@ -360,6 +529,20 @@ enum env_flags_varaccess env_flags_get_varaccess(const char *name)
 	return env_flags_parse_varaccess(flags);
 }
 
+/*
+ * Look up the range of a variable directly from the .flags var.
+ */
+struct env_flags_range *env_flags_get_range(const char *name)
+{
+	const char *flags_list = env_get(ENV_FLAGS_VAR);
+	char flags[ENV_FLAGS_ATTR_MAX_LEN + 1];
+
+	if (env_flags_lookup(flags_list, name, flags))
+		return NULL;
+
+	return env_flags_parse_varrange(flags);
+}
+
 /*
  * Validate that the proposed new value for "name" is valid according to the
  * defined flags for that variable, if any.
@@ -395,6 +578,25 @@ int env_flags_validate_varaccess(const char *name, int check_mask)
 	return (check_mask & access_mask) != 0;
 }
 
+/*
+ * Validate that the variable "name" is valid according to
+ * the defined range for that variable, if any.
+ */
+int env_flags_validate_range(const char *name, const char *newval)
+{
+	int r;
+	enum env_flags_vartype type;
+	struct env_flags_range *range;
+
+	type = env_flags_get_type(name);
+	range = env_flags_get_range(name);
+
+	r = _env_flags_validate_range(range, type, newval);
+
+	free(range);
+	return r;
+}
+
 /*
  * Validate the parameters to "env set" directly
  */
@@ -460,8 +662,10 @@ void env_flags_init(struct env_entry *var_entry)
 	ret = env_flags_lookup(flags_list, var_name, flags);
 
 	/* if any flags were found, set the binary form to the entry */
-	if (!ret && strlen(flags))
+	if (!ret && strlen(flags)) {
 		var_entry->flags = env_parse_flags_to_bin(flags);
+		var_entry->range = env_flags_parse_varrange(flags);
+	}
 }
 
 /*
@@ -489,11 +693,13 @@ static int set_flags(const char *name, const char *value, void *priv)
 	/* does the env variable actually exist? */
 	if (ep != NULL) {
 		/* the flag list is empty, so clear the flags */
-		if (value == NULL || strlen(value) == 0)
+		if (value == NULL || strlen(value) == 0) {
 			ep->flags = 0;
-		else
+		} else {
 			/* assign the requested flags */
 			ep->flags = env_parse_flags_to_bin(value);
+			ep->range = env_flags_parse_varrange(value);
+		}
 	}
 
 	return 0;
@@ -547,6 +753,9 @@ int env_flags_validate(const struct env_entry *item, const char *newval,
 				name, newval, env_flags_vartype_rep[type]);
 			return -1;
 		}
+		if (item->range &&
+		    _env_flags_validate_range(item->range, type, newval) < 0)
+			return -1;
 	}
 
 	/* check for access permission */
diff --git a/include/configs/sandbox.h b/include/configs/sandbox.h
index 2372485c84e..8dec2b2cc89 100644
--- a/include/configs/sandbox.h
+++ b/include/configs/sandbox.h
@@ -21,4 +21,9 @@
 /* Unused but necessary to build */
 #define CFG_SYS_UBOOT_BASE	CONFIG_TEXT_BASE
 
+#define CFG_ENV_FLAGS_LIST_STATIC \
+	"decimalvalue:da@100-200," \
+	"regexvalue:sa@r\"foo|bar\"," \
+	"bitmaskvalue:xa@0xf00f"
+
 #endif
diff --git a/include/env_flags.h b/include/env_flags.h
index 2476043b0e3..dfe45ce04d5 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -32,8 +32,19 @@ enum env_flags_varaccess {
 	env_flags_varaccess_end
 };
 
+struct env_flags_range {
+	union  {
+		char re[64];
+		u64 bitmask;
+		struct {
+			s64 min;
+			s64 max;
+		} int_range;
+	} u;
+};
+
 #define ENV_FLAGS_VAR ".flags"
-#define ENV_FLAGS_ATTR_MAX_LEN 2
+#define ENV_FLAGS_ATTR_MAX_LEN 64
 #define ENV_FLAGS_VARTYPE_LOC 0
 #define ENV_FLAGS_VARACCESS_LOC 1
 
@@ -108,6 +119,11 @@ const char *env_flags_get_vartype_name(enum env_flags_vartype type);
  * Return the name of the access.
  */
 const char *env_flags_get_varaccess_name(enum env_flags_varaccess access);
+/*
+ * Return the range of the access.
+ */
+const char *env_flags_get_varrange_name(struct env_flags_range *range,
+										enum env_flags_vartype type);
 #endif
 
 /*
@@ -118,6 +134,10 @@ enum env_flags_vartype env_flags_parse_vartype(const char *flags);
  * Parse the flags string from a .flags attribute list into the varaccess enum.
  */
 enum env_flags_varaccess env_flags_parse_varaccess(const char *flags);
+/*
+ * Parse the flags string from a .flags attribute list into the varaccess enum.
+ */
+struct env_flags_range *env_flags_parse_varrange(const char *flags);
 /*
  * Parse the binary flags from a hash table entry into the varaccess enum.
  */
@@ -154,6 +174,11 @@ int env_flags_validate_access(const char *name, int check_mask);
  * the defined flags for that variable, if any.
  */
 int env_flags_validate_varaccess(const char *name, int check_mask);
+/*
+ * Validate that the variable "name" is valid according to
+ * the defined range for that variable, if any.
+ */
+int env_flags_validate_range(const char *name, const char *newval)
 /*
  * Validate the parameters passed to "env set" for type compliance
  */
diff --git a/include/search.h b/include/search.h
index 7faf23f4aca..c3de3109a4d 100644
--- a/include/search.h
+++ b/include/search.h
@@ -34,6 +34,7 @@ struct env_entry {
 		int flags);
 #endif
 	int flags;
+	void *range;
 };
 
 /*
diff --git a/test/env/Makefile b/test/env/Makefile
index 9a98fd47966..717cbc5555e 100644
--- a/test/env/Makefile
+++ b/test/env/Makefile
@@ -6,3 +6,4 @@ obj-y += cmd_ut_env.o
 obj-y += attr.o
 obj-y += hashtable.o
 obj-$(CONFIG_ENV_IMPORT_FDT) += fdt.o
+obj-y += range.o
diff --git a/test/env/range.c b/test/env/range.c
new file mode 100644
index 00000000000..ed2cf27ef91
--- /dev/null
+++ b/test/env/range.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024
+ * Lukas Funke, Weidmueller GmbH, lukas.funke@weidmueller.com
+ */
+
+#include <vsprintf.h>
+#include <command.h>
+#include <env_attr.h>
+#include <env_flags.h>
+#include <test/env.h>
+#include <test/ut.h>
+
+/*
+ * Set values according to their range
+ */
+static int env_test_env_set_range(struct unit_test_state *uts)
+{
+	int r;
+	char *value;
+
+	r = env_set("decimalvalue", "100");
+	ut_asserteq(0, r);
+	value = env_get("decimalvalue");
+	ut_asserteq_str("100", value);
+	r = env_set("decimalvalue", "500");
+	ut_asserteq(1, r);
+
+	r = env_set("regexvalue", "foo");
+	ut_asserteq(0, r);
+	value = env_get("regexvalue");
+	ut_asserteq_str("foo", value);
+	r = env_set("regexvalue", "klaus");
+	ut_asserteq(1, r);
+
+	r = env_set("bitmaskvalue", "0xf00f");
+	ut_asserteq(0, r);
+	value = env_get("bitmaskvalue");
+	ut_asserteq_str("0xf00f", value);
+	r = env_set("bitmaskvalue", "0x0110");
+	ut_asserteq(1, r);
+
+	return 0;
+}
+
+ENV_TEST(env_test_env_set_range, 0);
+
+static int env_test_range_to_str(struct unit_test_state *uts)
+{
+	struct env_flags_range range;
+
+	range.u.int_range.min = 123;
+	range.u.int_range.max = 456;
+	ut_asserteq_str("123-456",
+			env_flags_get_varrange_name(&range,
+						    env_flags_vartype_decimal));
+
+	strcpy(&range.u.re[0], "^(some|value)_[0-9a-zA-Z]");
+	ut_asserteq_str("^(some|value)_[0-9a-zA-Z]",
+			env_flags_get_varrange_name(&range,
+						    env_flags_vartype_string));
+
+	range.u.bitmask = 0x12300000;
+	ut_asserteq_str("0x12300000",
+			env_flags_get_varrange_name(&range,
+						    env_flags_vartype_hex));
+	return 0;
+}
+
+ENV_TEST(env_test_range_to_str, 0);
+
+static int env_test_range_parse(struct unit_test_state *uts)
+{
+	char str[64];
+	struct env_flags_range *range;
+
+	range = env_flags_parse_varrange("s@r\"somevalue\"");
+	ut_assertnonnull(range);
+	free(range);
+
+	range = env_flags_parse_varrange("sw");
+	ut_assertnull(range);
+
+	snprintf(str, sizeof(str), "d@%ld-%ld", LONG_MIN, LONG_MAX);
+	range = env_flags_parse_varrange(str);
+	ut_assertnonnull(range);
+	ut_assert(range->u.int_range.min == LONG_MIN);
+	ut_assert(range->u.int_range.max == LONG_MAX);
+	free(range);
+
+	snprintf(str, sizeof(str), "d@0-%ld", LONG_MAX);
+	range = env_flags_parse_varrange(str);
+	ut_assertnonnull(range);
+	ut_assert(range->u.int_range.min == 0);
+	ut_assert(range->u.int_range.max == LONG_MAX);
+	free(range);
+
+	snprintf(str, sizeof(str), "d@%ld-0", LONG_MIN);
+	range = env_flags_parse_varrange(str);
+	ut_assertnonnull(range);
+	ut_assert(range->u.int_range.min == LONG_MIN);
+	ut_assert(range->u.int_range.max == 0);
+	free(range);
+
+	range = env_flags_parse_varrange("x@0xff0000ff");
+	ut_assertnonnull(range);
+	ut_assert(range->u.bitmask == 0xff0000ff);
+	free(range);
+
+	return 0;
+}
+
+ENV_TEST(env_test_range_parse, 0);
-- 
2.30.2

