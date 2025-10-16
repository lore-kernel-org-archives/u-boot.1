Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0087FCCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 12:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4858F8367F;
	Thu, 16 Oct 2025 14:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="U+exNX+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA65836AC; Thu, 16 Oct 2025 14:52:54 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F173283655
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 14:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbJh1P6AiwHv0NBfL+dUCInN4dmdN+5SU4EKt6OF1SWIUbQDl6bCtEofr/gki8twQ6Jr+ho8lyfoqlxRgxq3q0uJ46wl+2oYRe6ob5WlmpF7p3L4RoWvkMPHVeEkwR4tcGhnBzuSFujUFrEO0OHpG4u9yCwKCCEjOEX3+or3VlCPQ9x7BhHHqy6ew1HsC0Q+Y8AO9eSpo6PzekXxoAlBLgvPQrAZLtI970KE6nfsVAc/YpvaUrCGNxpfvUTnT91zG2su1j7xJin0nMYA6xi+EKHUSZQ2VPrYRKkH+yGffDhozavTGGz4vk6hBpyBx5NuXQmaUFefQLSthXkKxUyD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qObVmW5NSjd3eb9NRPM4hc68wzh4qxAP8atEi9Xlcl4=;
 b=zMuw9FqUJFGDqYjGX9mpCNYpjro9YOsiM1W2om1+48SKlurkkqH2Mj8kfqhzXev63NmD9Y3OYVQbjKLtgBKf/fLbNJ3912nm1D8wNgWxkMJ3/AO6OcVDP2BzonQLVdhYWdPvhnulLE3WuK8heVRXPaAKNuCM0iYqTIPPyGk7wQUUxHdek6p94GqK8aupuqGclYDedAlxamnNiw+3ycGc89eht/54UkLqMWvaoL9N9QN7zIH80hbgs2n2Vl0aMWfaDNtMJ0hxmk7a9iL6TZz2NJIDRfmHdsgCl0OsGqi5u5ImP2mJbr6uGsrUxOFVPIax1nEFuHid4xp30avOlaW5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qObVmW5NSjd3eb9NRPM4hc68wzh4qxAP8atEi9Xlcl4=;
 b=U+exNX+a5iJz8tx6as1zisY26rMjhZhTaP7Ruzx9eL1DBLtw7oKJMmjV1nus0lmeK2/1IVtVgA0bj4rky9SaTtvyJc23U+aVxbW6g4kfBbfiv9beJjEprR/1mz4UU8HjRoMF3Dvk1XdAEhQFGrEy1dEoCLraBU8tIRhRchjPwwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PA2PR10MB8477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 12:52:50 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.005; Thu, 16 Oct 2025
 12:52:50 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] cmd/part.c: implement "part name" subcommand
Date: Thu, 16 Oct 2025 14:52:47 +0200
Message-ID: <20251016125247.1594643-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PA2PR10MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e77dd12-5d46-47c7-6681-08de0cb2e9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3a1LTCTZr7YOS+LVTwVBF0xyDZfOvaFDSp4GHQ1VIzB0pdkdGyc8BGuORVuB?=
 =?us-ascii?Q?4Zdu5gZ4ciYEve8w+55nED04uTrAXOpkvfO54G5cBzoyaINQy0xentDSzMaL?=
 =?us-ascii?Q?JzGHkU0vu0Hm/AQYGvLdpL2gMGlmJbDgzWq/d8WUML3tMWX/ravPnBkcwt66?=
 =?us-ascii?Q?O5/yeHXWpl0GKmSFK9HjKDx5PgOXwVGJPyV1X4or+Ot7ay4uDHopGo5JhVFe?=
 =?us-ascii?Q?7XGYfE8g+rZ/WdtoOh6EHqWRZLSLjl0nIBJNd36wU9Qk6AhUiKhcSzGuBOer?=
 =?us-ascii?Q?f3XrnJeg7K5MM94FoBjNjv6dbOuCJHMnKbw9CUcxw31BLqo3/IbjWXeJKVft?=
 =?us-ascii?Q?PIc6npCaNYlMd1JKxzZfh/9ChBode49pDmmbLY5k/YxQyGjS/OYkmiCLrX+R?=
 =?us-ascii?Q?XtpKFjayebeIuVu9+g/EM8QmVK8lVgX4Od6b6DNesR+MzLzqhjYBjO4LU3Ox?=
 =?us-ascii?Q?aGDUuIinkVxQLvMso4GpbinMLXHa802BS/wrjafR4+Q3m6qXJuysJMsUoOog?=
 =?us-ascii?Q?EHkaCk223GEye7io+/S/TfcgFybgpXxthEqgGG8ABZ161w5VKC4gNN0hvwCF?=
 =?us-ascii?Q?fOq2FEHNWmEBeUpg+fbMXhNI5ddba8pWvg+4g5jNYVuJGYduys64Ui+rDDzk?=
 =?us-ascii?Q?ZQtrBsqVZSS/tXEuOppFtgaw/072BuscyutQu5Q9FRywUgyLUvK3uTEOswg6?=
 =?us-ascii?Q?xj0ImSYCt0T6qH8TP05yoTorPbNEYbr429NSqFBwMEus+6hbOweOfCo6qjzM?=
 =?us-ascii?Q?qGS9Np4SWWqTi/DvuzrnDy3yTpKNO0NhIbekPN6gPyLFBImcN/k1iiTA6P61?=
 =?us-ascii?Q?rLKxSVXPWQP4/dqqld/fk199cX8ZXcinoXqZvKo/Nw9mcblbLOSNFkTAxoEw?=
 =?us-ascii?Q?28gjVqJ2I5+sC/vZDj237wKB25l1E600p7cHp7ec3INq7ZlXNkcqffTbWbTz?=
 =?us-ascii?Q?fg5hvGk0mm88yhlUcHSIYxXb7nbBsEQbFR/mFrxwrEZAlz8uQYhb/3WnOxjm?=
 =?us-ascii?Q?MFMxlUPtQHf3EPG/ZI+O5zal/XF2koqMs0oSZHim3zhUkUpv7sDCyqkDHxwi?=
 =?us-ascii?Q?jt95mbGNlSgj6YtPJ4AsBBbniUrULvzls7nUEIdhK0UoQtNSFMsehisEOE8E?=
 =?us-ascii?Q?8nhY137F8HMXeNMDcSfvz4ZZCKd0wPRhEL2N8UaaPOJFROEML4KDCTvEx61H?=
 =?us-ascii?Q?mbKI1YT4Men16NUqqwYH9U/mpCY3tcYzdHVd4v//mJy0qt+xtD9if5RMPTnY?=
 =?us-ascii?Q?WZR2XBC+dbsVq8RscZNbhMZB6bHTiP9g/CBgGEyIJgL1bzHH35/p2SPAkGwS?=
 =?us-ascii?Q?OsWXh3ClQr3n979xwGs+g3tML3eplHzzpI/Jyrr2HLCGIyIlaV06lGdcNYbw?=
 =?us-ascii?Q?h4OyaGxhgIFx8k7k2v9smthmBjSo8nbY9CbAhVVliqEHmP/mKgkKUmNPy4u5?=
 =?us-ascii?Q?BIOhqlzQAtjEhlZZXavKSXMzK7l+vBv8vIa/6BGkozaF7C3TbdZ195F2x+7x?=
 =?us-ascii?Q?Zplav4wVlxMoQmvk86EaySP2HZr1HeMRVSA3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DUikXjtrbV48/smUmfhcL3Ft/9HWvRVxkkyT7d/Hqo4VYIoz7kwa8JTmc1e?=
 =?us-ascii?Q?TIrgxqajTRWx8E3ALmCkXSputE1kKztJaz3lUCS4/4V4WfIv1XQKC+2Pr8gN?=
 =?us-ascii?Q?FSzVbaoUeHeuk2qWy5T7iFr+g+9Rlh4MSifTIUUSbv9tZ2CO6TjiZjQctF7m?=
 =?us-ascii?Q?gZrF+EuANJ3OJiDBcSAYU1unuH4IDBeLsCnJervs29nTlfS3gRpSIAkVJXGv?=
 =?us-ascii?Q?iRS/qn99zGYAdD+A3V5bbLDcy87i/zT8EyfPASMhmi3yylTc9ZoV/zbJFmIS?=
 =?us-ascii?Q?QI8pz+VlsTHQVp3g8EkSWA33j4HESjdtky61/nNA2OxHeh/3bx0uRBSVAXZw?=
 =?us-ascii?Q?tjgugsp1b4NBRdughVfUxfqM28Aj9z69itJz4PYEoGGg14c7i5Votn+/56Aq?=
 =?us-ascii?Q?qVO5jcKZqscUeev1JQ7sTWk2ZBZPMNr+7UYstIPwCsOq949woHYhoeoOK8X6?=
 =?us-ascii?Q?8VrrjZjKo/oe+Fl0+ccJXSBKWV1BgVJWCVHPX5X7wNbN0nVhHOEv4VMqIUUd?=
 =?us-ascii?Q?+rJ3aWCidu/KWQ0eOHmVvyX9KQ3TZJ1U6LBag7yPkfaVdrjupIqbJVWEZk8t?=
 =?us-ascii?Q?fj9/DHLL4kJfQsurmY3wudocXN3jo0jUgi3pvd2CIzKSzywOdIT91GS4Xvkg?=
 =?us-ascii?Q?WXvUp0ADhTku2V4jyqqSskpLXcGkIuQxUvm+PIUk/8M7kXhG7VLGreR0U7Zz?=
 =?us-ascii?Q?IoDHwTy31FK5HsibQJAyV+Oaa+42RSk9ZIXDM5UmiiMmCde11KvXqXLk55Pg?=
 =?us-ascii?Q?z072ce0Su0MV3kOpQILfbeQeRrqweNmrHD4oILEtYHVXcNhH97IkjQLfSmli?=
 =?us-ascii?Q?FafSSuxD6AE7w8VPS0L/ci1EG3dq5WP9RcBYaBwkW7to47WIxXDPZfIJ4eGU?=
 =?us-ascii?Q?ipQS20qkTMKRE1KRmi/Wc2OiSlj/z6sI8Tg7IN9caYbuOdj6ImE81F0LVe23?=
 =?us-ascii?Q?EiwSUjN8PI9TLSz6c9ViDrLiE1gVGHm0mOmNpqqiLUC5VVlRgbwc6D9jRMxj?=
 =?us-ascii?Q?rGjDUxrZ2/tXPYpRhDItN5Eo3w9nK5nMmPfTAMVpUQuJyCrTbi9RB1Ajic7j?=
 =?us-ascii?Q?YGcT1NH4e2OiPL7WeizC1R+cVvwWAkHu3/k9D5/8sc1/oDnKolxCYuwxmFv6?=
 =?us-ascii?Q?UaxQ6iVatqgBcubsy7Yt9rmhQxXNk+TgjkDuMtdB1ZLQW3kQU/JfRtPfkLjo?=
 =?us-ascii?Q?ZkcE55g3GRZVtfr4MUisuSTgwl4HQl7mCCrlLqog+BBRzDbY5QPIHoI1tV40?=
 =?us-ascii?Q?ekr8b23SUyuOh0PTPLB2SVe4sWDw7m60nLutDD3xmFno9Adhyzo2zFXZTHR1?=
 =?us-ascii?Q?3WgNjqjzFuB/uHNGjN96/7Y7RKrdhecWqTj5bzCduEYdwE/n+B7Esc+ODYZf?=
 =?us-ascii?Q?BOHuwiaooPHfYDY7eKsEZbdjO1347/zXKKMFXNuRCrUXQQNSLd9pvrTf5XSh?=
 =?us-ascii?Q?E9gH1fwIYQjol4IsRzyz5ySWCkyDPnqTZCzMD6yceVWRfZkzWIhZjYuYBTSh?=
 =?us-ascii?Q?K0kjIQz4moIYrhC5czQH9emztQspbwhHcnp7Xsz0ozy6qcY2uyz6BfTsR97b?=
 =?us-ascii?Q?UbvC6Yt28bgmgkJOfvAg8E5x+Or2VjJqsnL/jGXDByBblpdN5ZLppBAckasJ?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e77dd12-5d46-47c7-6681-08de0cb2e9b3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:52:49.9476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CsQmWRhAHsJXRNyYhl0IXllz68NGO+X0ASBGnXifWQuSaHio/mcpfY+5G3TZISnpFrsDOjDdvM16I6rE/hlkWiDIFZxjbLCoccDQEPX42c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8477
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

This is a natural buddy to the existing "part number", allowing one to
get the partition name for a given partition number.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/part.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/cmd/part.c b/cmd/part.c
index db7bc5819c0..975a0a08a99 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -25,7 +25,8 @@
 enum cmd_part_info {
 	CMD_PART_INFO_START = 0,
 	CMD_PART_INFO_SIZE,
-	CMD_PART_INFO_NUMBER
+	CMD_PART_INFO_NUMBER,
+	CMD_PART_INFO_NAME,
 };
 
 static int do_part_uuid(int argc, char *const argv[])
@@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
 	case CMD_PART_INFO_NUMBER:
 		snprintf(buf, sizeof(buf), "0x%x", part);
 		break;
+	case CMD_PART_INFO_NAME:
+		snprintf(buf, sizeof(buf), "%s", info.name);
+		break;
 	default:
 		printf("** Unknown cmd_part_info value: %d\n", param);
 		return 1;
@@ -182,6 +186,11 @@ static int do_part_number(int argc, char *const argv[])
 	return do_part_info(argc, argv, CMD_PART_INFO_NUMBER);
 }
 
+static int do_part_name(int argc, char *const argv[])
+{
+	return do_part_info(argc, argv, CMD_PART_INFO_NAME);
+}
+
 static int do_part_set(int argc, char *const argv[])
 {
 	const char *devname, *partstr, *typestr;
@@ -273,6 +282,8 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
 		return do_part_size(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "number"))
 		return do_part_number(argc - 2, argv + 2);
+	else if (!strcmp(argv[1], "name"))
+		return do_part_name(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "types"))
 		return do_part_types(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "set"))
@@ -305,6 +316,9 @@ U_BOOT_CMD(
 	"part number <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition number using the partition name\n"
 	"      part must be specified as partition name\n"
+	"part name <interface> <dev> <part> <varname>\n"
+	"    - set environment variable to the partition name using the partition number\n"
+	"      part must be specified as partition number\n"
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	"part type <interface> <dev>:<part>\n"
 	"    - print partition type\n"
-- 
2.51.0

