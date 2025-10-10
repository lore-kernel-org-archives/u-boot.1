Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71874CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE48D84327;
	Fri, 10 Oct 2025 14:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="a3AUTQho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4398C843C5; Fri, 10 Oct 2025 14:41:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F7484327
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqX+z4buo0yaRIeMLzd+seXvg+eKiQdcmrD2Q5LzK7rMFmJy1QlrEasGJZ3M06g5RtDWcHc4+dfAjb1R5bJDFQaleg1fSzAz/eKhyABUb22v/rrcl2Mkm1ywOuDvNlP2nb0e+RCpIFwi+7aQ0jHbz48cbPXsfpcm7iqHny1NIlNsg8cokiUeycMMFHcDl73XVYQoqyT6LK4mKs8N0IykVRdvrKQTm+9in1LwDfhNKAUVyGKCQtAkaMFXmITQzbsE1Yjj1VU2bxUaD3pEIhqlFotiQCnBp5s/74iQ7V9ej5Qq8limaG9jf3bHL9oLBnkF6gQLUVBfsAuVZT5SFCPsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSGcLyDXcnErid//KVoH0K3HGkkVabygKJ6jVWZf5LE=;
 b=d8eISLYoxX01jwqZ2z8B4qobJ+qwhcju1UsyVJsB10pmePJ74ZVB2Y+Mq91kLAnPubTRRJR5mlSvG5hMymE/J466JUJ+3l8EgudvjkXf8Ib4BEKZFQKD1Wvzr75mzif1Lq5A4pmu8wrKlEP9s2hXRXS3IRp3dpeNtKgf5RSQqg3wSI2wkp2uEguztWY90Jc7VxQMLxXM8hPjd5ojTRSK7lDnlphUymlwgysx2AZxIl+CsSpwgx0g6fRWiTdAVYUYq3JeghKdI1HoaF5rTCkge3j6Geh6EwprgaXpaEU1zbTttq4f5hKXyc0RZd76J0aab/S0NOTrbgGoj/f7PDXpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSGcLyDXcnErid//KVoH0K3HGkkVabygKJ6jVWZf5LE=;
 b=a3AUTQhox7EVRNLQ4LohacTDFP1NloqbBnbz+W4Ci44Nk1nz1d1WgQ3WcbcFIdtLaAzrv7cd0umM9MLK+CopNsWCMW3KAYqhGYOV+mLZn3edG8Fd6IQp9JEnAhBfYW+dBprDNlpXskaCKisQRBIfFlKz8yayO1gErwldfOysT2+3KYQdr9ZZX2RDkoy2z9ModZZmsS9yggKtUeooczH6yKTLQ5Y8NGvnBM3p0GOyNJmB0MEnkj6tWZWE2BqopJI4YWv/DAsdYExiHJUcjCSPLGmgk7mucDCrmfX+xsTFI5q+ch6z0SWvmI9I8Tykt7AYJm1ccydOaQZMbqKkIotSuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11522.eurprd08.prod.outlook.com (2603:10a6:102:50e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 5/5] cmd: mtd: add benchmark option to the help
Date: Fri, 10 Oct 2025 15:41:15 +0300
Message-ID: <20251010124115.1545865-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
 <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11522:EE_
X-MS-Office365-Filtering-Correlation-Id: d80e9bd1-1a7e-49ee-c597-08de07fa561e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IxryJA3z5YPAgAZhashPfFM8rp1JVkP965jWPzxfoLFE2LveG5hwDMbrCCxP?=
 =?us-ascii?Q?aUftQt3Es8uM34wF8gFYyog5M5eZ2sQ9jBqcH/m7T4y46vXHx+sQyYcQdzOP?=
 =?us-ascii?Q?ssXul6N+VbRITujrGnUwPkTO9aQj6dbI6Fi++J3t9M4aY05FJPafXhygCn6t?=
 =?us-ascii?Q?v5LRFsNlw9sKCahBCW8HHyEDyoOuWVzrFDEIDGH4XI5nJuXysBC6gf4av4N9?=
 =?us-ascii?Q?GDKDP3i2qZ6m7Oy853kDZ9mpY00Ac4joB+Vqnm6Uy4sGYKrjdp6j36Eodvtp?=
 =?us-ascii?Q?s7TSvHqsVTiw1UQe4FCrYjftuupboVnYuGPljnFufOlvlygBwbynC4YiQuJw?=
 =?us-ascii?Q?PbYJOt/ytsSlZ4lxwzaViH2Lv/H0NlYRKa/txJr2jzLLk2OqHpYypy/9eyez?=
 =?us-ascii?Q?4phOp/j4ntomxdOXqIl/FD4mD6IqzCqMvTNTwfjLmFPcXo9G4aP3Pvby01/s?=
 =?us-ascii?Q?Q9QMcVQVSc4m6mnlqjPTrnmItqFe3s17XlTh2Ox/s9C3VSufqNH51eGahlbr?=
 =?us-ascii?Q?e+OGajXQ3zqq+dJEySwx3FLYAhm1dbSsjwBaWuk9RR7wJuioXbETD1QEr+QC?=
 =?us-ascii?Q?Zlmrs30nIGJEL7jX9+2BO/tAeDSTpEI/ahaIy9l/GvoAFTrl/PJm415jK3Ls?=
 =?us-ascii?Q?JqVmrHAG9q1RpB5u9pxAy32wffLjSi2tKbQJmH7dnB+G4jEoBHSyn20owJB/?=
 =?us-ascii?Q?GJZs7tncSbcLU4T5oSxyY7Xdna/ZK1jHm6ptxGafoW27a2s4+eFKRi1pijRv?=
 =?us-ascii?Q?UFNGaUjkpfdmLI2ZS5icj7+pT5pzECjWgrnftOyFWpB8SIlF4qx+WO7Kbpky?=
 =?us-ascii?Q?ZX0mzglapbGWidfmM+BJ4G8QWCqoW1CZJ0mxKQICuGqzaCrcZY2HlKGsvhpm?=
 =?us-ascii?Q?hCec20Pt/dj5G8Ryq125HBwhsx8IxgXqulh7UIxfOvWNTdA0MstycOa3BlEv?=
 =?us-ascii?Q?a9oDkI4F9C54a1pJJUwReyXqaDkf+5sFoJh/AjtNGv8RI2oHKovxsu4YBPV1?=
 =?us-ascii?Q?wPYSC09nvr5W2X4dDw4cMFnVAtWO1E6BDbB2sT/Yo3FgtFUqM2kReUfHNMja?=
 =?us-ascii?Q?MzAnjOqCxix4Q8+Ph4sckUicogBmh5WobZpjtU/c6XvUS/k4B7hHq5wUKMCc?=
 =?us-ascii?Q?UdytZci7ECamq7QVvPfxmR6yxsjTBPzbwyB6wTkvk6s0dxV2AKcWkzII1RrY?=
 =?us-ascii?Q?DOiVlPN3+JkSQq/VueQDZvhiwfD7ttx01FKCcJmVuLZaG9NQr5U9DxRLRYYq?=
 =?us-ascii?Q?zRb2InfNLXmNeS+K0ancZQxuxotK0WJ/8BPvR8TMuy8qSQSAxBgP9dwRGemc?=
 =?us-ascii?Q?ZjnVd2bJT6ezmOtjOeN9z9JBC244mBTHu37+Q89DY6UfYGWq4EaFhVfikkCQ?=
 =?us-ascii?Q?pPzYm1VF7GKN7g04fE7TS7y2Foz6jw3CbCxk0aKLXL0sFVerKSdAeivuv2O9?=
 =?us-ascii?Q?KYQqznhdX0I97GXYEiazeHKbNWA/BVKh9N2xMP4JL5OdBXiAkp5Z3/aFcu7A?=
 =?us-ascii?Q?epso4P69A+xwmzwYpAOY7z5P8FtNN/K135gZEFk4AFqRjZpduxCnn1lbXA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YfIl7GNkB/jxmLOKLZ7yJFbDrOahOxjAB9ZE89vsHrHr52IiJhE2hFxAPfXK?=
 =?us-ascii?Q?6/k5GWVfm/KbWx2qpDR1/SCoRtjW7xvipXCpDrjTNYAFzgKYwlBs93zhb0s/?=
 =?us-ascii?Q?1c2OCnsdiMgLExRzzETUalHuow0VFxiLgRZJlPiW9vsQwe/+5RgUVAxgeH5H?=
 =?us-ascii?Q?ssLQKO+3XZfM2T0fm80F/MRVXUsozZBIgmG7A/GhKAPeWngjchC3yfcFfOyB?=
 =?us-ascii?Q?aanmUg11OODtmrMX1/DKEUzysJreN9ChPBBNZup7eff0ejGqk11xlAoXB3Rt?=
 =?us-ascii?Q?Gz9boby3HdV0Tn2YJQld5RtFIeuQ2/fU4W4Is1qz68SZM7dgL7ktM2MuyVLD?=
 =?us-ascii?Q?eQro6ybf3xEPz8B6F8Nq02CceIKB/gL5t773aUAUDjJVgSu5vXFo3Az2sByx?=
 =?us-ascii?Q?SOvamFt/ki7lhjp6zfXZm4SitML4nlGsGLs12Gi885ZM3AYSDoLNBLfyNXwg?=
 =?us-ascii?Q?aDCS7onueRNzNzrmyQByGVkwkXP+fCmQpVTBUm3gxjGgY8D+FGLr5AvFI7/w?=
 =?us-ascii?Q?WwzCA2gYvUaVmQmvgGX2EHjRBqgYEcacPwSYOw+nUiWQ1J0BYoBXJ5UNQjfN?=
 =?us-ascii?Q?U2iydrWdKsMfmhWwMMCwwBmUwsVEhfo2Kmw7/TTx9rYXXxEYbdvPM5M7WRql?=
 =?us-ascii?Q?3QGMTgSuYaCJr1Pt1ZKVAAKMdnkVkmZmPjEzBnwM61TJhhQzPA3OVdBDxsNb?=
 =?us-ascii?Q?P4M+wwGVWzBy8kb94ZtyLAgm04kTFh8DlGAN1RD2jUFVcyp3drto0Dt18Tju?=
 =?us-ascii?Q?ES4/viKgmxteTOvihKx1dvxGnFep9/w3ETkPN2AEG3jw09a9uujwwMBHJYEF?=
 =?us-ascii?Q?on7ORDO1+h9hy8owIgxfucB7HCkCQP+yNhn2yGCQKVw3q2MkI7srXQuVBeKP?=
 =?us-ascii?Q?jlpSCOUPm8CD6DzjoZ72P7YY26sYPPNIGcb7wWzreET85yIiBGStQ/3LoTl3?=
 =?us-ascii?Q?AVtiklPzrPmhGqE4Zojr448It4Hzuo10krs1b3wseygvBIYVJjjx1vK1f7oZ?=
 =?us-ascii?Q?2xMZ2aBcx4ouzCApRVyXFNN/VWAfAy3YB+Y4IGKDe4eYBZumiuCHMoSdwYS1?=
 =?us-ascii?Q?y5OhMpV1WyaABka/lMhzGhHQsRyMJ2ozWEyMTk6I0RkWmDXq/EUQl7xBlIOW?=
 =?us-ascii?Q?esKfxh+XSPiP8oIFFPY1MnPp/jLq430dKa6wdgRtDcnAwidIhmhHxSGy06fu?=
 =?us-ascii?Q?NGqLB4PH6LOgZTmEdxhe/CGW2Q1f286VkZykiOMjuq5Qb2jR0FmbDsz/1tM4?=
 =?us-ascii?Q?MRi4D5JeVhYhDGvnIBFhq4wuw4zHfL+GDfvopnpEvImgHRHAxvfiorcbdOLx?=
 =?us-ascii?Q?/kHEYy3zpNsISWEvFWBpX3US99+JtkfsBbt7KoZecHprz5tEx+N2Q1Q08lLf?=
 =?us-ascii?Q?X7Vthch/I4slvZ+wla5rKsjWMqPpJwDUvclPumldgTNEsL9K5fwDQepi2QRj?=
 =?us-ascii?Q?qitPK0V4xktMeD/dCd4R/YjPYQ3pRFIRCycoowdGDL8qYM8omLGre3MhHzK6?=
 =?us-ascii?Q?70rxtBaLAKwk9lWvDtNk2b9siuKOKFQvlbQ5zjz0sR+b+gQ5KLl2Q3SvhazT?=
 =?us-ascii?Q?fE2tHPtkdFASfGAVd17kVxjTmd+Jd0OhItbq421A5CZpVgsoz5scCgXfxV0Q?=
 =?us-ascii?Q?JYXFuqfTEMmuWjnGbaw+rCw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d80e9bd1-1a7e-49ee-c597-08de07fa561e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:30.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJrldlPD8v9aAdyBXs9EnIKyijSIRsFE/DdwaVYnK5i7SuX/gTDmbpTnwS7kMc2OKibiQOFm/Uh/FtTgIduHi3ZLFEuOUaLGBhPKPYs372E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11522
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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/mtd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index 34870fd3835..2bc9fea697c 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -1217,27 +1217,27 @@ static int mtd_name_complete(int argc, char *const argv[], char last_char,
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
2.51.0

