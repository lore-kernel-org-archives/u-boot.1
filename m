Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF4FCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FC583768;
	Mon, 20 Oct 2025 14:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EFYhKAUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F53A836D2; Mon, 20 Oct 2025 14:11:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8F3831D5
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5R7VZVQbmwqGfKz1e9w84cUKdP6SLE2vi09hHvGDJo0L2gf1o8N1WMZTc6xMP6jrfCjVDbCaEta4Vt5Es/1fTMUIPtYV5RQHL+1+cfj46Sh7WKhOu3k1nLu4PjavSY2dY74NuEuasJRYVUK+XdrXVFl7Z+ORZqQ7zBMwWfApf2El7p7ZZWjL76gefTCkJ1yc4CdiAMwXXJW3yJ16HRonZpNleCTLs4ezNVGuPowclO7wfg3TkljMbAgb0xl2lziqaH16iJaRgZ3i+a9qtsIDaARLiYhCWM7AExkucdcM427GjaHebWshDrxu1CRcHcr+90igRAfLVwv2wKmwv2/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0Lve2pJ9iYeOcsF78w6g+UoiI51g1V1P215gBEQjwE=;
 b=UANcas2mzRGyWqZLGvo1+QRV4SRAvsx2O/iWsZEHTLd4tLdMAnIJAgV7Yn7aTA/0vJzQvmUJcdaExBnZVKib0OsfMjTb2Vj7VIOGNaBQGnJhednDYDVB80NqlHAllrnlpMBR4LJ/PLyx9tvz/cRURglU6dtpQkrx5A5dJkItxSvmzsWiYUXPytcJtbNOtJ0NtTXMAj7RvlAMHtoUhvEm6GTnFj/INBgYH6eML+P9Y4RFNzZhTP3EnqL0R6Fnj7U58h98H9Xjzr3/BLh3ZtVTuLFZQXkhvO+GwfO/lpTNT/HsHxah7sluzK8tm+I9nRg5cI5IG+iKJfQpEIvrwFQYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0Lve2pJ9iYeOcsF78w6g+UoiI51g1V1P215gBEQjwE=;
 b=EFYhKAUOh+uRJ4mgPiFgiLhy4mTIQwXk1NcFsE4nD2X5hbsi2/Xgz6VUVyMUW3N2bz+5N6QKwxGjeb9LShRhgzQSt5Pvx7dkqIr3CsuTrQi3uD7odg1LKKDBUj85jvJutUfQhSctWM5pzl2jS1IgERVtRKxC0wrntE/xDMiAru4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:11:09 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:11:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/2] cmd/part.c: implement "part name" subcommand
Date: Mon, 20 Oct 2025 14:11:00 +0200
Message-ID: <20251020121100.1742812-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020121100.1742812-1-ravi@prevas.dk>
References: <20251020121100.1742812-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe63102-df0b-45ab-fe92-08de0fd1c10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NHUSADaZgWII1rnJjv0uliDrcRCgsjiIvX/CpcBZYr7IUX46PL/RX+job91x?=
 =?us-ascii?Q?4m2WOjDvNb9a28dguacEwc4LTZ9ObX6hvwoQPgyDXTwwRx4Wkl1TJrXDs9sw?=
 =?us-ascii?Q?+en1srr/uo6Rr9/DzFhCuQrBUuuKBItQVtGjvEdbqWi+gQTbOt+Scuq21YMZ?=
 =?us-ascii?Q?+HiBJlmVw44mjYCclHS6W9qvC+Je7qq3ZhPFpbUJIzy4SPvcH3oZ0cer6tAw?=
 =?us-ascii?Q?0ibYt7okOfGI7PoWmmLjpAfqfGr1vBpa7JbZAeG6lsU/7Hd3oG7Jef9/ei9B?=
 =?us-ascii?Q?IsaImhBc46we3/RbdIDeyRj4/PACWs+AcHmT2ohzvXNam2BBWqUXgFmP0TJc?=
 =?us-ascii?Q?0bEYCJkGdLdhYZbVWCIhL+FicAoWouFCsck9+DzORJrvNq9f/wYCGYpHnSMO?=
 =?us-ascii?Q?Vkb2lQVWz6kCKSmw63j0u43kZuwxySYEWyuB/Eeis7ZCIOZ98LHSL26oChiG?=
 =?us-ascii?Q?57AwTEYHsEeWiWvdJdCW4n8ZuS2oP4JEmN2/3s/gWfQVgkmEAytOYdIq9ssv?=
 =?us-ascii?Q?lvOFJJkxD8WCUV2Ebe7un2bJfFfstLXOy4qAQHkXr2aNSbKLotilgcNkjwdw?=
 =?us-ascii?Q?5fLT8iPDk9O/u//58StSkwSnrAovidLCPql8ZPtiJoJpSYBEnf3RBugpd4I7?=
 =?us-ascii?Q?CoXH1qksBuevka1JTko+F7fUhefxGCTvwFDCx78QMrskKl9QiAtrJHyBzBYM?=
 =?us-ascii?Q?iKeR9fine47g8bbs8w5dFLtA8G926Nmr78DndWUhGeQJJT4B06IqQuSsslAI?=
 =?us-ascii?Q?gHow17SNYt7UiCfTeQzYpXuJlX1UrI+3nbPfqATNfKEeOvSusV+o2maIgyR0?=
 =?us-ascii?Q?5pxvf05vBMOWanCVFrytU+8qRHPThbHYdXe8ye9x3EHJyHs0pr2Xbf/C7mqK?=
 =?us-ascii?Q?tAvEKbX9+/CcyKAWPnnG60HFSA5ibLf5kCuhfGAdVNtJPU1ubf+jrFvbaCfA?=
 =?us-ascii?Q?F2ZPNevoUueDXNpfykfhga2hBtAYxbV6ZTtyRdyz1GP68DOdE1npChgenRmf?=
 =?us-ascii?Q?SHlpzXUJT/O3Z4HhFv1KDY8HH0x9womFwKpHOKRh8kqYDqwB7q21e1E7tCAq?=
 =?us-ascii?Q?KKaM0sldybeZjYBhEcoZAopSCvcJyPPEZiRJRNvSIcd9ff3JAqpaRdphkLGd?=
 =?us-ascii?Q?oPSnDIkgD0uN5t47/qTiYEu24JcdT+t/LJqu4TtgjnftnxZy9UrKsl/JEfqO?=
 =?us-ascii?Q?4Pcj941l7VPOxWXKeLF08mVcqeQW9mZlgdYGewxTvziIb3F9nlWwe6cYUQcF?=
 =?us-ascii?Q?jMQ/94JyM5Rs+TZ09aEuBBL/yZke6O4ivqbBO+0lQXxOfTOpDw90W5VnmF1K?=
 =?us-ascii?Q?lgFU0r6rLL3a3rNfxFMUwqvLQoPkh0+FI372tAnqRS34REwbRzBVguX9KA/d?=
 =?us-ascii?Q?Q9338NWc+7kKnZVHhhFh2V4Tsytb0OKjcthH/w9prII6xeaWiHs8eLCGLgPh?=
 =?us-ascii?Q?hGL1qkSdxqjR+pfDwdG7zaDC+FT53mm9fIh7xhn+C1JgvtGu9XkhX08+MM3i?=
 =?us-ascii?Q?tsusZYK8zi3Z20w5tdTS1J3jHJzG97oGgHGl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUaH6/3JIC1ItQtIPBGwiCKGhdxFO2w2fM+rPUu/d5tvolN2Irl9F0VDojG2?=
 =?us-ascii?Q?rxcL6qwPXnLEcCRi23RubX43Pn+VagAD749fazg45QLjhs5UC7TXJUvr8V9z?=
 =?us-ascii?Q?MhUFgRUDjbkeuVUpqeysOzoOWvlHNfUHEotK++0Q7Xnc7LtRDJYo4+el1UpI?=
 =?us-ascii?Q?1sEbGKvNKbwTazxpOQTe6+Kt5mdOQ0AC1LoMWsKAD7v4U2n4KIwRhAOynwmW?=
 =?us-ascii?Q?T/kReeAf9JfZTvlaW/dxkTg0eDbzIAi5bju57/m9UyC++KM2W87GR8SO/W70?=
 =?us-ascii?Q?B/lQ6hOGIThfAFfDWTE6ipl8FkaMjh7Ip9py0JdlTXPehgqOPHkyRygwxwTW?=
 =?us-ascii?Q?yBmQqIXVbNghHxR/ogf6OKMvt1WdMDZnu3lVeUOVFeG0IuZducJocpFWzDzi?=
 =?us-ascii?Q?KMHA0fMVwyZ0Lvg5+fluXDz68fJpLqvtTfvMlXbcJLspdbQKB5dJndTaAyE1?=
 =?us-ascii?Q?3oITc4HYOQHRnMg8L7JsGyleAYOGoI5PlTgpsLRuAWucdpBlgm/5G+RQZbGh?=
 =?us-ascii?Q?ivtu2hAur6Rgl45yTYLgURCLTYIt07pGYN0vE9Zj9W3r4tmAphLY6evvnBVf?=
 =?us-ascii?Q?lBGcnNJ2/Jo1Iufqo31yJgsUblLf2mCdnHO8tm/dUiVJy+i7pUTPjrwX7nR1?=
 =?us-ascii?Q?J1wi68l165pLBHVTTiGtdfuSvNRj3/Nujdw4AWUe8zDStgoP5JOEPhZtw8yR?=
 =?us-ascii?Q?OgEBPp98P5GVtKJX/PxGOWneDrhiHa6u+kDaVh64orZuLLv1/Cl8zfCxPYXP?=
 =?us-ascii?Q?CRdOATzGexhvq5aBMqPxDNFDMNff/3QZ4dnV/szu9r74ZrwYPXqgGxuEEKrA?=
 =?us-ascii?Q?RQA15HucDu/Cd8PkIpnIuKWUMJalryNt108dL/2pC9iBlOYOMqJEqj6Dyukd?=
 =?us-ascii?Q?FTMZ4eQIXj2E4Bim2SDKadCUHvi1PK/qS1eY3obxKZDZeezFCRHKQqx9JsYz?=
 =?us-ascii?Q?E6CoglFCl/n7RgSZ/V0oIZFI6i4AKhzhEwV7Rcs/dxnLLr8j1n8W37mbBnLW?=
 =?us-ascii?Q?IybRulbgSfyLopqs1a95yy07J0WxAmQb0r9ahkiahwPusraJ+KxA88sQUG+Y?=
 =?us-ascii?Q?vH0c2SeaBPpZH8VGXyGb+ICBmj6gFOTnPbQdoJQq+uK89fukacaKoYoVzCIo?=
 =?us-ascii?Q?tV5MfidUks71W5rHuiKVUuR6Dxc2GrFvfT/cWeirZnbAOs2NrTBBEN6eFALF?=
 =?us-ascii?Q?jSpL6LnY6xLWEOSaZwKh5jJb/QF52J9avg+VbsJXBHgQ60LdihKtpjB/FVA+?=
 =?us-ascii?Q?w60epjETQNn3QHQtp1IRaYJ6fS02Gc0CGxgjqrTfWl0Ezjw+LLdUw7TpwGxV?=
 =?us-ascii?Q?PGaKreDpdcE+7q/6+7GGICnbIMCACfYos0qh7Efjh5fJBHTweXArlaJwSsIl?=
 =?us-ascii?Q?1TunaTCXLrcCin4Fp9Gs7Z1H1E0bmdvraLJsOwR6elMRrrwoUw6aFJLdGGaL?=
 =?us-ascii?Q?q5F/mowyzX3jac+SpXRHTZ96l2/CfXerv2lf5hXvH7xQJiWeu9enAexR8uCD?=
 =?us-ascii?Q?jTGepnbjePkEHsJOJJiTOHK6W4WpsRgar1HZsycCVtZY456g9kUNiPp6SGHg?=
 =?us-ascii?Q?k20E6uG9AhLb3m8uJ9SVYt/cNN6WM4w+CMDvaoMswnf0txxgj6OUkbwBGL2p?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe63102-df0b-45ab-fe92-08de0fd1c10b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:09.5920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfy1SDDDvAyR0SJdNTNYHsSln+rKq98n8fh1RbNbUPm9QGXlog+yrQgKQ1bgjeebaK4aRjpl6PN//0/BzvNRmM9Q2G510GpPOAu9o6N6aZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5924
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
v2: include documentation update

 cmd/part.c             | 16 +++++++++++++++-
 doc/usage/cmd/part.rst | 13 +++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

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
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index e7f6e54ecea..df510685154 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -16,6 +16,7 @@ Synopsis
     part start <interface> <dev> <part> <varname>
     part size <interface> <dev> <part> <varname>
     part number <interface> <dev> <part> <varname>
+    part name <interface> <dev> <part> <varname>
     part set <interface> <dev> <part> <type>
     part type <interface> <dev>:<part> [varname]
     part types
@@ -86,6 +87,18 @@ part must be specified as partition name.
     varname
         a variable to store the current partition number value into
 
+The 'part name' command sets an environment variable to the partition name using the partition number,
+part must be specified as partition number.
+
+    interface
+        interface for accessing the block device (mmc, sata, scsi, usb, ....)
+    dev
+        device number
+    part
+        partition number
+    varname
+        a variable to store the current partition name into
+
 The 'part set' command sets the type of a partition. This is useful when
 autodetection fails or does not do the correct thing:
 
-- 
2.51.0

