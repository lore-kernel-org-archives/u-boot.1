Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70155C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8BCD83542;
	Fri, 29 Aug 2025 09:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ayzI8Kas";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4067E83531; Fri, 29 Aug 2025 09:48:53 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F5A83542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgdcQPBzqtz2Vzr1/Pbz7/R869drI6ngVmZZQmekT0IhxfWwv8z6/C518R4nAegVErIosEiivv3s1ErcmHhhfOKP8JTZGoHEd3L4ZfLn9XhRsddShBUc8ZLj9b7VKM10vjsASg3tTq8EW1OLrptMTto2UZVEuP2pvGT9Qj2kgUhVju3CtRQLcV6YZBL5q8UB7YCBeT81HRzzAPF213Kth75rTG0ZYnE7j7csCY8bAjV7lpJnmUF/FqbEGyZerJgde0v+w+7r3MnT3RfBhLcT88fFRUacktuepnkhGwGzV2a/Fa4W/kdFRPOi6QeQCIB+5vmbceC3dxbN3mtQZ0ALlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmwtbTWfMGqGx3A/zYpepDybaqtsf7c8iO/9kVWKeag=;
 b=AkBM5brdM9cCDy2xcdx+ixEYA/VAif0c80BtZjYxBmD66n2/wTLLkTfMsoPHeGN3LMaxiCKQGBGL2Ae20CiswFrJurO0/LoXkHqdafnwYEC11Sqpx++eSnxaXB7WIJUFWdhUBAnAHnoYDNDU2Ou6dsuNgx06Y/g9OzXZ5YTN9AcjgAui9qf5ABWFue8gOKBlwNBgvzca0C5ij2fB0SQ31W0vdwDuFkYfpjQDH4of7MV62dnFepA2HhgYa9xpFRzMsNzPXLlpTky0R9d+aV6UMEEULTbwSVAhq6Ja8mGwe+PYY6NWucZVZS98PK8PLpgxJIRxr+xxLf1o62m9WAL99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmwtbTWfMGqGx3A/zYpepDybaqtsf7c8iO/9kVWKeag=;
 b=ayzI8KasvZqfRrtT9w3w+NasY7efuXk1czXlWxsrDqOS/4K/QFM7z13TeoKiKpEXIJNuuVClQTal98joxefKq3nKHH5k/gDx0/EEoXe+TrCqnthL8egTUP9ng5HHKIedFQ8N6PCOXPunSD4IdZhja0sMQZHcEyh0LXJueIbZ+VEG2IKWebDhE4Wz/NY6y7U1e4h1lGRhoV8x1ISAUpKNCdNe7PRdfqJXGmhyxZmK/ZlUf2g9WMNkflvmu/wcLthz3lXHmsO2XtYV3gFFK09ErkesbJ1vtErQrZVJ/FQh6LGoQqImunm0AIkFfn9hVDEEv+n1DQ6S5cvbIHoKIW+S3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8320.eurprd08.prod.outlook.com (2603:10a6:150:b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 29 Aug
 2025 07:48:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:48:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 2/2] cmd: mtd: add benchmark option to the help
Date: Fri, 29 Aug 2025 10:48:36 +0300
Message-ID: <20250829074836.2894264-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829074836.2894264-1-mikhail.kshevetskiy@iopsys.eu>
References: <87tt1r6api.fsf@bootlin.com>
 <20250829074836.2894264-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: df68cfa9-d4f4-45eb-2b40-08dde6d07c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xqRpdK9xuqKfN5anMfiGch+D5s/P+xB1hnyJqAJMjwZIYAO9v7aZWV7kFPsB?=
 =?us-ascii?Q?iddE4hbzvf0BQg6HoS0hEkjn5RVLoq/S6tpSRvheU04CDA/e5RWcI00JCpN6?=
 =?us-ascii?Q?gnraokYOZ6RMiBqf4uLjIIgPyj1vjzKgs07GjOSX2QwJzmt+1MHPQ/hwRPra?=
 =?us-ascii?Q?zBXumxZA3D8jajC8JOEtRIkbSqwjv0YqkUmERWaxLokaNeEV9ydVAm/piLi2?=
 =?us-ascii?Q?CA+uw/sKo/33F7zgxbg3HtglXEF/yFgWWy5c1zvJAyKMBY46Wf8zdFJLtr/g?=
 =?us-ascii?Q?eGqzkz4cKcu7zPQ3E0J8rgnWEgyYSwOJZYfItoJ37Ysh0Ma9XGan8eIn3604?=
 =?us-ascii?Q?4lD1uYDzXhMBMvQdYq2x5Oy5fO7Z5oPqabuHJ0BwWFpBmo51uqH0jypvqpFc?=
 =?us-ascii?Q?vnSDDMkXGBP/AUGodDLj8L/il7mmTEcjMKMTPG7zQun/fdugxOMI3gOh6ZDG?=
 =?us-ascii?Q?f0JRbtLfn45Zy2KdPmxzLHgAq2f1Yj9ToZ9CoB+SEGXXQEXGkUCnqhLqCYEr?=
 =?us-ascii?Q?S12zZP0b7Rm6SObJ67lIV7DYmI+tk8rAGeamXhRsh1y3EMGXMvlFy/aPUl/K?=
 =?us-ascii?Q?qLDKQweA4YjstOmE5qW8xQZhCN18Mzba6GpUVXs7ZrnjjR3ZV9O75ewyVeHw?=
 =?us-ascii?Q?mkHGarRZWLLQCN+Z2443/jkh4LaWD8ghPOsRAhzSuHwk5IYM45JXhOJ5M8dG?=
 =?us-ascii?Q?Rye6pK3pmcyoga+1xs6MOSYN2+90/5vLl4h+31QhHX1UsrAnxAb0T1xD7gUI?=
 =?us-ascii?Q?ABk81rlJlB6siQ9Sr+l5rqoCoGTel0Z0evRvEIM7lb9Nrmf56XH0+7ZDZwgi?=
 =?us-ascii?Q?XEHME8oVIbmmKxifc79KMGM5wA18GLZ5iiMWa7mUx5oTLUCk4EUObcUSazBk?=
 =?us-ascii?Q?6EX+ma5dIcfd7PO4laD2ECFaoJipuKJG8g/cBlh8iK7KzC8JE6hqHol10i6a?=
 =?us-ascii?Q?dgUQZENtoe9ELUU1bYDw9BmcoqmYxYH5eZIxIAnruQPE/MpMCR06C/pNnL8R?=
 =?us-ascii?Q?xvsvWVi9+36haGKJ/wpaKh8m+BnqkUgSGSS3RPRW+9zVeKSZUJGEPovFhK07?=
 =?us-ascii?Q?Yg/xCxuMCgM4dHULkEelHl7baYGSnxzcjE7dtJr2O9JmtvWYA63RZh2i5ml3?=
 =?us-ascii?Q?2WyvYdMuW0/Q2246dqg9Gp0pvQokhirZUzDKp4H2+GbmygH0k4flXz2MLfGh?=
 =?us-ascii?Q?Sv98lN7vAaKnl5+9v6E8NPsyq5LSO+BMCbCENwker8kTrtX5EHZDmxwnz9dZ?=
 =?us-ascii?Q?Dcd1AS0lK02krWxmXBNjzDHFPcrpFhZQXIFCcfNR4PTwip2VCQTiFrL6EPHw?=
 =?us-ascii?Q?M2AxPrEaoMnGBM2Dd4JLcJItMmEO0nlFtpm6YmKpT7x7MF7Th4MzL4sYIML8?=
 =?us-ascii?Q?W2f2QZneA0gQZCOmoDLPg7kx6JYjiUxfotbHK0xYYe7o6P0ibrammcX34XtM?=
 =?us-ascii?Q?/bfYHpTwOaNwujAaCD9/yNYTYrfQrmXLVGqSAja01eW5SG9XRAmM+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0FMwaOk/1uByJEFrmYRnTxmdrgZSMlQfal1LkuY977pczs9CcKXpUIi4V5z?=
 =?us-ascii?Q?W+g4J4UrfB2DOX52vHUYJWC0C33SLDl0HR6FWYDk+elc+wGktZ4koOYeMh90?=
 =?us-ascii?Q?js5E5VnEN1lfcjDqFuMN+uQCOIrJG8g/JvGSmZ+NcFaRHVuirW8jBkx9qjvB?=
 =?us-ascii?Q?7WGpG6yv3IEE2suaHI3i5u31MZCKjkgmOr0ZqzbYb3+2gURYMXerUEyMJY7J?=
 =?us-ascii?Q?OHkoZe133+gA0thNP+94ZEf/S3Vyfd1VtGw1f7la/cb04m2xk/RmztzvUaN2?=
 =?us-ascii?Q?b4N7NgCrQzqxzXTb/8KKdHHoJdJYzrSg6+uYW+0GhP1rgQM2HSEoURB+IyoM?=
 =?us-ascii?Q?cEOFBdVVhY/xflDBTPYjRxV1zfe38O8vCwLoZYOqwsX5OhhKpU0dq6zWnIzB?=
 =?us-ascii?Q?ROr9tqln+yAbB36tpAtLtpbN8Hcdq+1pInFq+A5KhxEt3kRjP8a9ajg9epnG?=
 =?us-ascii?Q?0ucJFndswi9x+oYBl6AU9UQ26Hm22th/DcywJOUD3zXxBS1D4FpXEIqxe3Gn?=
 =?us-ascii?Q?boeuszlxdYTQq471Pjgk6W9G1ZzwFY2psLqqt7fmkKw9b24J9w14Sq8FIgw9?=
 =?us-ascii?Q?ueldR0rQzeMB3l3ZO17PV2434TuPuauYGSNY2/MOknFtwg1/cKJ4fOwulBEP?=
 =?us-ascii?Q?UzOxZ9DPPbz0nkW8w90SFattOd6ibWWNCCZWIF61Kh+46EMJKqf/lHlhZcwW?=
 =?us-ascii?Q?mWFvcAIFR8+fHrb2olm4WhGI10J5COTvKAae6D9g2ZPM86Py7HHz9JZIew9M?=
 =?us-ascii?Q?HRQB7OCLG9spUJvcXWDmhtkMWjF5WRdJWswTB6M4UO6zFXH2BtHKAqv6noJp?=
 =?us-ascii?Q?aErzl20W/3VpTDbkpVga0YJlioz51Wu3dR97kD4XeJWwdy+a9iAMbdVydsWa?=
 =?us-ascii?Q?0gTtrnVbwWNjG3RdnkmQIwL4YByOso6xVXAzRd9kPRuxMxxF7lA4ipdKtbkZ?=
 =?us-ascii?Q?b1EyHn1wGNnPIyK2LGZtyJHRvx6ac30uNYk7phbEPbUEeD0C7zvLHroahhoS?=
 =?us-ascii?Q?hDurEyjgi0NMZo12g7SEMIM2bv3mwc5+x4sdBPil8lq/w9ubejD81yNLIjnt?=
 =?us-ascii?Q?FX9qxMwn9PzPAPkptZVY86MKEhV+6UZQOOoYsswJ+ICRvZQiMDF5Dj3eJof/?=
 =?us-ascii?Q?iVRdDxV5Iz5KRO5z/ADFYxlnxEWPWD0A3w4qm+yZmJkeut6tAjJkpKtB2Qrc?=
 =?us-ascii?Q?PKiCnX+Tk11WVNBw4I8haWwUNAHOCurm7Ync3qjDzzsmVDAMFkQiO2Hyjoer?=
 =?us-ascii?Q?J2Q/lkV+VO1nk0zNUeEq9Q4vMEbTzjRlH7xRnC4beNmecsT33X1DSt/VILxC?=
 =?us-ascii?Q?wjiY5aQcfFmxEHOJZUy7xiDXKYVrLNVg2SmfZA6bLcCRvLbk6ox6VbqittCG?=
 =?us-ascii?Q?2AoUhRYHJDyllKVSUyCR84b6iqCIyWtG7WkMqXn4rxVsgeM7Moko9d0OKOrI?=
 =?us-ascii?Q?/un7jv5U+yj/eQlzTRSgz+zYWY3qjGSj1XImSMMXjMK0Htf5in8ckD6WRBqM?=
 =?us-ascii?Q?YE7vLa0LLjg1FQ7x2uZCM2z8wXdzytNz++edwpeX7ZKMkyCwCM4bcpK9MmKP?=
 =?us-ascii?Q?EuPlhmDvvLGAK+81P4A/Y6dDYbWwnlF0OSoMYDZ0GfrK4AndQE0ICugup6Sr?=
 =?us-ascii?Q?muA0WvcmIveZPMRqubnMg08=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: df68cfa9-d4f4-45eb-2b40-08dde6d07c30
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:48:46.9706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIdLWKZAmlHSoQBUxx2bBCO7mvzkIn884Tnv+VrQXGhUGwQBFMRXYillNXkweYCYd+DuDbETyOst9BzRqWj2rbXrNYbQoZx7ZGz4rtBRgxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8320
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

The patch adds benchmark option to the help of mtd command. For the
'mtd write' case the help line exceed 80 characters. Ignore this issue
as modern terminals are capable to handle more characters.

The patch also formats other command to make sure all device names
starts on the same collumn.

Fixes: d246e70cf81d0 ("cmd: mtd: Enable speed benchmarking")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index d4e1f83b91c..b072838c97a 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -1211,27 +1211,27 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
 U_BOOT_LONGHELP(mtd,
 	"- generic operations on memory technology devices\n\n"
 	"mtd list\n"
-	"mtd read[.raw][.oob]                  <name> <addr> [<off> [<size>]]\n"
-	"mtd dump[.raw][.oob]                  <name>        [<off> [<size>]]\n"
-	"mtd write[.raw][.oob][.dontskipff]    <name> <addr> [<off> [<size>]]\n"
-	"mtd erase[.dontskipbad]               <name>        [<off> [<size>]]\n"
+	"mtd read[.raw][.oob][.benchmark]                <name> <addr> [<off> [<size>]]\n"
+	"mtd dump[.raw][.oob]                            <name>        [<off> [<size>]]\n"
+	"mtd write[.raw][.oob][.dontskipff][.benchmark]  <name> <addr> [<off> [<size>]]\n"
+	"mtd erase[.dontskipbad]                         <name>        [<off> [<size>]]\n"
 	"\n"
 	"Specific functions:\n"
-	"mtd bad                               <name>\n"
+	"mtd bad                                         <name>\n"
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
-	"mtd otpread                           <name> [u|f] <off> <size>\n"
-	"mtd otpwrite                          <name> <off> <hex string>\n"
-	"mtd otplock                           <name> <off> <size>\n"
-	"mtd otpinfo                           <name> [u|f]\n"
+	"mtd otpread                                     <name> [u|f] <off> <size>\n"
+	"mtd otpwrite                                    <name> <off> <hex string>\n"
+	"mtd otplock                                     <name> <off> <size>\n"
+	"mtd otpinfo                                     <name> [u|f]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
-	"mtd markbad                           <name>         <off> [<off> ...]\n"
+	"mtd markbad                                     <name>         <off> [<off> ...]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
-	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+	"mtd nand_write_test                             <name>        [<off> [<size>]]\n"
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
-	"mtd nand_read_test                    <name>\n"
+	"mtd nand_read_test                              <name>\n"
 #endif
 	"\n"
 	"With:\n"
-- 
2.50.1

