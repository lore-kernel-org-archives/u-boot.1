Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2E9E6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CBA83DFF;
	Tue, 17 Feb 2026 12:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="eHvdq0yU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD9E83CF2; Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AAAA83CB9
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5sThgtVFoLgWM3Bl1LptcWKBBNXvgDj4kM7VaeVH629Ys29apumfneovyjiI26dZ4BbNTlFt1ozeXWTaUVTUZ2GhlsrLK/3wOP/mdVB1myTDpEW3VIS+7PVGR84S+BBe4pWgTbzj0iUvIKM3ikMUGlSnnf9n4/05x1Ju0RhIhTaPmDgslh37YRGhTWVTKhBXcrsPAzoodP1YLveFMMjQ2bygcBiHBgdpBKnZFVEk72/mfjyugjcxTRwr6Uob6etpQHUiQ6Anw9l1wWFYDRU+12M7mnR31JV2wKcvhxmZeLjg99gjmv53BIFTH+PnRKGMYRfgo11LrXjYTCA50Ly4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NSZ49/Xyt0mQ8/JYbmbj3pTDKFWvqMPO73X1Kueq2A=;
 b=SGf0E5Y9ursK3weZrJqO6UwQIqUIgZ0qvXPeXMxCiPi/Hu+Ebb59guNkWLYA8z6SDyxLkUpY/MW/MArr7qzCiM2HJIxf379PBD6nOSR6+Rb6jR//JQUBL8SVYX9sF37rx1feJr82njp7GXE+cfzO7E5fmToYLuQYC9W/ILYoBvkzks0lMzpFlQLOwF1+DlOZol4W45DHf7OXLicNNZNf2Kl1SlcxOf+PMYj2raZ3lv7Zf4c3qOtGcvB6aToquRideBpspU2uWYJ/x7tBmhRGbQOhlm+b/QMPgVjWp5Qq2GPCzfSCH9015FHwETKwHVEMW6M2ehV41r1D5A93f/e/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NSZ49/Xyt0mQ8/JYbmbj3pTDKFWvqMPO73X1Kueq2A=;
 b=eHvdq0yUYacIvRbXmkKf4a9jze2sQFXiTUdLhRVwBOnBq4BpQmbyKElTTnBMlTrIXztLmSy+4vOC0iyvU/ah7UG1WJDRRR7b9JbJBQxdjXZW53Sz89Rg6hBLrfqtHsHDOEBx96TDoobovCtBr8DwxUn7j2Pm4HEiM73PqHFgnNeu3+V0WeQab8itWq+As4irGsvMx5yl6Nox628dkEMgHzWIK2vIj7TJc7DBJVh9qI4FSBb5uavTScw7bGDTK1nxespKOh3fzCDChaTB03yK0TRSaBqVvC1WTRPuFNOASFql/DGLGC0pdmpopl1ktMVp8UQuT8Hy1hcXG/Bl6/fwCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:39 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:39 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 3/6] tools: mkeficapsule: Fix dump signature long option
Date: Tue, 17 Feb 2026 12:53:29 +0100
Message-ID: <20260217115333.503359-4-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::15) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3ff0bb-40f7-4544-2ccd-08de6e1b3071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1Rxfid1qiiWEaU589G+RzSEC1USxR66ClRIB46fJkOTBJQpC0PTpcJTYMke?=
 =?us-ascii?Q?1XF+re3w+Gasd+WZE+671pOiFIGavxInzIVQ4+h5c4N7AZiES0XgmNvZs3IK?=
 =?us-ascii?Q?b8dVRxwq4WiR1+zBcJkc9Vvss7DknljMCFXwgrNLoC0asMDfRXSCA9DTRzDP?=
 =?us-ascii?Q?FnfgCy2UQQ7jDStIVXL+TJ1iCCR0L8C+oNij74kdImu48uaNwi0+N7AibbKw?=
 =?us-ascii?Q?7xXp7Nlq/FSElORrzxejshH/lc8SVrxS6scxV74hnN+nCWw/wU0BivcSLEWO?=
 =?us-ascii?Q?OclegiJbcbZHQSaYx5twVGk2ZxRoUWi6s/xfCDwVchlH9kKhsx4Hb7PJMNSs?=
 =?us-ascii?Q?rvYnMJ5sC6uye4MdD30MW2me5YvvJK21Bq9offNDOGR+UI9ebEtmhfEhQL2H?=
 =?us-ascii?Q?dY7M93UI/ROXS9Bzte5faKCHzcBsLTCdGeSn0HZk0MEttx6XSnKmD69bzFvS?=
 =?us-ascii?Q?EqV8sWOraZB4nMMzQvtQmITtC3Le7koN9VUhPbDyKwxD0ds1GvMV/1pQlunN?=
 =?us-ascii?Q?7kph+OtLEwq/H6Vc9IX7pZDzFYgepOJOSHcGMqUBHzWKHsm5EDYG+mh1Nljt?=
 =?us-ascii?Q?jbHbAKcIwYDqcv7TrvIG8oyZh4PDLroel3OMqloMsH7hio0b5tX8Ba4iI7H+?=
 =?us-ascii?Q?6c3+56hEGf5hVMkaMj9gnAylXUb/XNC4PnOSSa7BFIGtbMeOuS1A2acKa+Uo?=
 =?us-ascii?Q?33yN5z784yQGtzUxxXB76EUWgA3PsdGsU+BBk3Qr88Od2b8ytqerxleZtNen?=
 =?us-ascii?Q?qSpsZ1kHet2sjjo4uMpq2jkGQVCYtDl1SBBDeOWQsGu8z6M6L7oD6jQwopnm?=
 =?us-ascii?Q?tqdsQClmbxcLLkFuTehTWCgt/kkM4lPHuGJDLkI6T+DpsSnSJjbrPeFR/AQH?=
 =?us-ascii?Q?OwJpUHJTeBbzw9PIlD/SL3MDuy9UG4EiJyUzY1rl7tb+INYNZZGqS4QSJuKA?=
 =?us-ascii?Q?DtKZt4AhhVSnfq8v4clU+huXh5Ztv2OYU3L3j2YEZHTgJw+F3+vyI8Svd1lY?=
 =?us-ascii?Q?tRe3rCEkw8P0Pd0YcMi9p9pONP83RwMY/j7muHO4KWTVkQU48JdN01URynxx?=
 =?us-ascii?Q?7xxYwm4fOdgmsuDhhLcAnBnPkErKotpq8IMug/5AQ3EB3gMQlG4er/H295gQ?=
 =?us-ascii?Q?uiGq3BOz0Qkb8HwBuXmbdg1jLubxfrygHQ5ZPvrZzzayjK1HZdoEvPpn/DHo?=
 =?us-ascii?Q?tBVLufZjq5F2ZCc9vtu44n9HUZhdNDgp6T+Edjm391/z3gn1jNsNUrfmcu8b?=
 =?us-ascii?Q?4yMRjcbgVejXOvfvq3XXNfW4L1FL+lOH69LidxpEkTKuXKecJaElKEoRNiWY?=
 =?us-ascii?Q?cT7h6xWSVtTNDcNWnT+maCUeO7PiXsqdkW9TJFfGR0T64erhkqJBgjC/Sz8T?=
 =?us-ascii?Q?xDvPlD+Hm5QGdbofTVwdFu251X1xe96bBt7KEDxlyA4M6qiJhxQ/Nh5R1VC9?=
 =?us-ascii?Q?pLqufMjrYzNrDAIc+n2KwKZTPppIZyT+JV6NdktOBsm1OIjm9Sqy9641oTE3?=
 =?us-ascii?Q?Qfq/8UNjpbSnQycPQOdyJbmVdMiAWCgNmBXX77UYU6MaSrZRlodReG99eS7s?=
 =?us-ascii?Q?VZtvZnkizF8SCdc72imS+CqR6FQGsCl4c5D3IMglZuof1hFDu68braIVa4zG?=
 =?us-ascii?Q?a5yS+pwwGBEwCDTW0XfV9eE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xiQ5eMOcf0NakDR7vZvNPkzQ3S/hJloRsX4CIhTZ5tVAiUXlEz8h47epspP?=
 =?us-ascii?Q?bnIDEOptjetVIlea6u2gInS79vGqMHSB0ED5wctidIVgvjEucTln7eFzizuq?=
 =?us-ascii?Q?9CDlUBiXVZDyjZjFElv642tIo3bLLat5ympBEe6Rjr85n37uovd9WlFcGhaq?=
 =?us-ascii?Q?Ut1m+TJvKyT5grV2//9nOb3nRQGwUWoxYaAJU7cEspj+oTRCP2mtTs4UtMwe?=
 =?us-ascii?Q?o1ol1S1NEuGzJ6Mret8LQl9awmoD6JxVp47Qb0z/dVklYn9oTf1l1iUOpXOm?=
 =?us-ascii?Q?0JMW9OLf+SYN55jK/n7p3Td+nXabj7w4b6knL9AisFXhbjfpzxeoPHsb/t2P?=
 =?us-ascii?Q?ZOIYPxA5wA3+A/4idHrIYwCe7IlFgdgWimE5X3cQpuQt44vHKLysZmtfV/6x?=
 =?us-ascii?Q?pmG7DICq9mzAn3JGZeiOzUVjs0QqanEDjyAM9m+7iGZg2jGa0+bZf7ypqLQN?=
 =?us-ascii?Q?+iNlNsQUi5mboq24j4VyRetjIu21X/XTjQJAPgT9jxVTsSMRRePkXpx79UFP?=
 =?us-ascii?Q?uYtEjYfwTyEVHn/F8SYJihg8L3Z6B+Oz26B9/kH4wzl/57sWko1Rcoah1199?=
 =?us-ascii?Q?Hpqug7mQcpa/1MvoZk8WWNAMB5bJ2SsdQ40Pl04NHpifQ8FDwHI85mdiPF1d?=
 =?us-ascii?Q?VpeXbS6xuUsm8OKDKcvjt8Al2aMslWHijY0gmnjppuyG+rCtME8Icd4dHnr1?=
 =?us-ascii?Q?J9SL6z9JkdZY46Up1OfbyfF+E7Kz/oyqtO30jVvxd5ah7bU2rjbQDMjgPw9G?=
 =?us-ascii?Q?1inSHg7m4VOOPdZY0crvsgcJaLy+24iB8WqKE/PZdwHxrSv+h3sEVI3rupzP?=
 =?us-ascii?Q?iEAya+AVW/KsyZAKpo+IGRBHhuya3GEbgRfjJBj/iYlrLcZlYhLOXpsVX+sY?=
 =?us-ascii?Q?PGjJ1/fRG/XwN5rFmKF+E2VfBIZskTPf2BY+OJFW51jRSRCSCP1k993gkrAd?=
 =?us-ascii?Q?DMBHgKAnqPaJpwfDtRB1IzM1iOaqY/WGDccOqjqpWbSKP30tCRbw3rQvqw3/?=
 =?us-ascii?Q?y9SjPIJ1rRjL6qpMrCtjPF8g01XKC+NOsX6oNmWmcpOME9GGBKr+VprbcYeg?=
 =?us-ascii?Q?FyRrfl83q2zgX7GYPb3kP3VOeWlX7GupaG96Cic3lggwdKSTgQbjhOu8OcmJ?=
 =?us-ascii?Q?a4Dm9JuYGmlhN8pmic9ZPGSivM1Q3uH3zVJ1JYLN8nUw7tIqkx7zefCm79V4?=
 =?us-ascii?Q?L5beLCdY/gPZysD3K9awAvuMBiNVm+HIpXa+ybRXd5pdSuRhIKP1SkjP/fMY?=
 =?us-ascii?Q?GFo6ppd3fLJgOcMo07VDjwmZaFKVNOVHc0OvLqo2ofPt50VVR031r3SHa9oO?=
 =?us-ascii?Q?g8T397XKp8TWLJ7/Wukujh/XsueX6cKZ39QAq4iK/7mtWh2f/niNI3cWpfCA?=
 =?us-ascii?Q?kZbhadtv8hPbPxp1Tp8hJ+kEkAk4Jgpe3q7dZUP516Y94WwtZPHw2bJIVQoU?=
 =?us-ascii?Q?chEJNDu0IDhNww0oB2ZcOZ2kmzjQPk7R4KsrhPvYQNUjpgWfKLH7IShFDRt6?=
 =?us-ascii?Q?APAzK0twV13LL6XcL0IoHzSl/stfJ012LKTR+/PM10yDmoWuNvXPeGe6N+w5?=
 =?us-ascii?Q?KP0edTfeeNFgC0V2AgJPLiu9nnl6ShVFRjxoCZ1fXvCjhJ7koboeZIARwQWG?=
 =?us-ascii?Q?hEygnn+Pe5odxiRe+te/WY5qHxj7ag0cUZ2naYX+8sIj9BVKqlHDxhRk+K39?=
 =?us-ascii?Q?7d4a8ER2SAvqs6J53VoDT+HSBGSlrIkJT5mNhzF0JLgcdBPh2Y33D6Br6GwC?=
 =?us-ascii?Q?x1mrFYt52w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3ff0bb-40f7-4544-2ccd-08de6e1b3071
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:39.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pAZeNr+Bq/fm21CwFRH3P5k4yr130d01KngPvquWojeeI+oDTUZPgTm0s3a5T+WMrZNafMSrPDutcMnHIINrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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

Only short option has been present. Also rename dump_sig
to dump-sig to match with other parameter names.

Fixes: 16abff246b40 ("tools: mkeficapsule: add firmware image signing")

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/mkeficapsule.1                 | 4 ++--
 tools/binman/btool/mkeficapsule.py | 2 +-
 tools/mkeficapsule.c               | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index a726149ba2ce..d6653ec42472 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -121,8 +121,8 @@ Specify a monotonic count which is set to be monotonically incremented
 at every firmware update.
 
 .TP
-.B "-d\fR,\fB --dump_sig"
-Dump signature data into *.p7 file
+.B "-d\fR,\fB --dump-sig"
+Dump signature data into <capsule-file-name>.p7 file
 
 .SH "GUIDGEN OPTIONS"
 
diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f7e5a8868495..f2ac654db81e 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -16,7 +16,7 @@ Options:
 	-p, --private-key <privkey file>  private key file
 	-c, --certificate <cert file>     signer's certificate file
 	-m, --monotonic-count <count>     monotonic count
-	-d, --dump_sig              dump signature (*.p7)
+	-d, --dump-sig              dump signature to <output file>.p7
 	-A, --fw-accept  firmware accept capsule, requires GUID, no image blob
 	-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob
 	-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index a0ee76295a1a..ec640c57e8a5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -56,6 +56,7 @@ static struct option options[] = {
 	{"fw-revert", no_argument, NULL, 'R'},
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
+	{"dump-sig", no_argument, NULL, 'd'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -83,7 +84,7 @@ static void print_usage_mkeficapsule(void)
 		"\t-p, --private-key <privkey file>  private key file\n"
 		"\t-c, --certificate <cert file>     signer's certificate file\n"
 		"\t-m, --monotonic-count <count>     monotonic count\n"
-		"\t-d, --dump_sig              dump signature (*.p7)\n"
+		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
-- 
2.47.3

