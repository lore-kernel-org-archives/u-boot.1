Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F5C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7A980568;
	Mon,  3 Feb 2025 14:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="JRPnredA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6E0801DE; Mon,  3 Feb 2025 11:42:02 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA3780087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4Cjpnp9t95ApUpHWzd1mffDQWk0ld73Sc5wDLVkN4nzrWhjElsNOdtjLlfpqJ2JjLCBrxpg9v5v+96T/NZoWM8crSevGF/09f1DhxpQKK3kM2S63hkNuWZJxXx97iYKSNCNNgWiImociCdxfmHPzWXv0ZphzgrxUCPTNZ7jha6QlfxD+2MUaYjz/S3ipCY+yqRJSKVh+lUxlHjS2tHhqGkYKlt/ayJHq2WPekObrD80Ryc4jAl64H3Ay/rkNeWv4tbjuDELxZOkEV7XYPy4vGG149Tgk9d0lICNOr1sdosMbh4/PuQetm9kTz0XxoH4niXX2Vq3oFo9SGZY76RrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVHPwEW56l/7SDilf4ZNO6Ztg8DYDEli8C/tZ0oT41k=;
 b=LKJZlWtMpn1C56OufKENkoawX7934og6tqfG2HOcaOHKhZhf0KXgOYHsaGX/CVOq17Ewf349nOaHK7Tm1+B1+1pBYDC8mLy+zMZQc1IJjd4A2dfuWwhkc0XK91Lfrn1vGEJjKILuiOgdr6kxBf0ZgNY+kCmR1w15hpMLwpuHIY4VyiB49kWAt3puYETj9Hny7qv1nzWLbJ6rNHuFte8wtdnIol2Lt7I9SX/zIlbb7DLXstYTQ/6c0AC5lrBYdRBbJKsALXBzXia32ZX8HlcMHCU25DpkluALtOIrJCrYxxt/ujedqVzCUSl3SoSaJEEJpCdj5aOsowr9yfg7mvHshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVHPwEW56l/7SDilf4ZNO6Ztg8DYDEli8C/tZ0oT41k=;
 b=JRPnredAAFZq/6RYfTQ//WEoYvhoNyWSjNBc4ayn0jX1zw9jHApzzBhPxRkmPsAld/638xFMqi6jD+12dIwyPv4+9erF9fmzH6mbOKdGI7DKQQ5alPDLtVjoGXxVzRYOqYszNye9ezJHz408enRhUxWcCsVvzMll6ls6gtMds6yaAcePe2w3jrK9wLtgzW/xh57+foOx7h5g/tv/MCPqxmn6WyINLaKXr5lsl+Z9rpClWUWUO/rkR1q20bhOsezpCfqaWBxUQg6LVi+EJK/Tf86VWUpR8DwC21brSs18kXni00F9e5tTtB3rNMqix610nTdY1JJfKklSXhfAnuwpEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by AS2PR03MB9394.eurprd03.prod.outlook.com (2603:10a6:20b:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:41:55 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:41:55 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: Manuel.Traut@mt.com, burak@gerz.io, Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] fs: fat: Refactor delete_dentry_long interface
Date: Mon,  3 Feb 2025 10:24:50 +0000
Message-ID: <20250203102501.35750-4-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203102501.35750-1-Daniel.Venzin@mt.com>
References: <20250203102501.35750-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|AS2PR03MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 648c2486-d113-4813-e03d-08dd443f60d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5ZvBEbNqYqPSgtOq21GJuH35KCX4U/y33lBc4+TRx4Y3D/J5pLL3/1ZQpkNd?=
 =?us-ascii?Q?UzocZ/i5Gjhr5bss7cSl3bv4u3mY+q3Q8gRqgJ1Z/46okUZjZfYz4bu9oq03?=
 =?us-ascii?Q?zxElfpe7cOU/A96LrhCd6XdjfoUZChp79niCADXr+Py9OJXhCe2+bP/4l0kh?=
 =?us-ascii?Q?NOtn8g/OSXqYofkF6JeB5J+MYSyy+9iX8pssNozkcVxoE5Cmm6+64OMMgE/I?=
 =?us-ascii?Q?fKhtTE0qCB7DfTHzd9j4TR+taZjNrLHlM6oAbr8ySzB1et1NAdr3093rXgjB?=
 =?us-ascii?Q?oZOWguOXo7cMm0XbP14ieSUcH/bO0bv428tC1nCZqOyO0TiTbYovyhNm+XUU?=
 =?us-ascii?Q?05ngj608d4zv8inhlBqYZwxmk8eGbhDYId4r+FqarQAfOX8w+cJOypuwzwyD?=
 =?us-ascii?Q?J8jXNJuZisqYRQh+GVKj1aGmnyp4N+haoZIpiDXPbe83LZ3piDdeibLldC9B?=
 =?us-ascii?Q?E4bdvSe+JBSwWvDqPHFzzZIJwYbKI+UOOuO+0DRQkq/oySdJIT9ci7Sfmo6Q?=
 =?us-ascii?Q?nxPQWED4Z1S97CE6deCsd1x0Jalf+oTab4HxiZWWFfWNcXE4j6xyBYSkexaP?=
 =?us-ascii?Q?MKx6bayEC1G0pj5TM/mpoOvSbyOdDn534Xw49fJ6snyhBeDDxZjC56BdqBnS?=
 =?us-ascii?Q?+CzzD9faXKhLNVY0vdByvnuK9Cb0W+ZyVzt/3yogqneuME99g8biwokYZDmy?=
 =?us-ascii?Q?c0MpAh9JAxjlH5/ZYtP7zehd2UNu1XeitYpiNBfloaDQUQ0Pc7CI8GGhKbqQ?=
 =?us-ascii?Q?KBTCcgzMzfxjVOZBLnfYQO6e3M7ckXh/P8r1NdjQoyia5zxMfnmKhmVo7/64?=
 =?us-ascii?Q?32sIuhEC7fBX22j9t8wTaPrCjE8PMV8WnrUngrLM8P0+z5cSUwTEpxyXRywZ?=
 =?us-ascii?Q?NWnv+1YfzOOAnK91louhaVf8bP8rWTz6qTJs2Hp1nKi5iUaF7oXmS0024vOe?=
 =?us-ascii?Q?AMnxDxDS0YE1mKHIfxSqcn1/xQKqCqRaH0e5DdEygIwikl6Yhw8HZ4G5+OOW?=
 =?us-ascii?Q?AoPuI3KOmkkFInvnkgZeznTavwtjTNNZQer26Uq7i84917d1EuKsaWSyUHDY?=
 =?us-ascii?Q?R0/lXDeM8V2G20wrN6q0kUWCsYzdYbof8JoBbirL6Yl9EBZCJACcgxkcC1bz?=
 =?us-ascii?Q?SlQLc8Ky2tIgMAWijlTVfTxrf7y7etmHylS4AhB6lx2Bc+kou6rYcgSTY6s7?=
 =?us-ascii?Q?946Dpqy4l7kxe9Sdge5mCNExuUJUWDeCj3VYH/cg2kutNHDJ4p0aGimxe3Da?=
 =?us-ascii?Q?gvfl+v9dmGTlEhcuY0kYApGGfd+uicNlC3a26wBFidFtP0vK31yEpSlsmVkA?=
 =?us-ascii?Q?tKxbMlz5VrTOZfhdj8l3RRMdp/M6d9h+QKAwdMSZB9Hmff/7jik4AWJLoP4B?=
 =?us-ascii?Q?rpTWpx39e+FN2yclr7FW+XolOJehM8YvLYFlOWx/E5kSVP6V/vOPRqApzE89?=
 =?us-ascii?Q?PnrzJEtzpd6BpD8KWsvMIjUX9kEaN9x0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F94ojLjPw0uY9wa2U2GUkYGBucCMKKlJi/Ukwt+8RaQ7+B5vyxDMEx6PQgJf?=
 =?us-ascii?Q?ZwdbAP/P42MmM3HZJFCGMpFjkywUj4J3OdaDl8GTQZOxPk3POuI09+D+eBoY?=
 =?us-ascii?Q?rFPJgVuWHNa+8UoW93tDKTg9NfXB1LJdjSY55PY435B8w756pmsg+2uJnMQ6?=
 =?us-ascii?Q?ZDCxLNDoV4Szapdo5C8CQ3+qJRed/BVMT2sQdoQYdQvzLHpnygjRi0BHwohL?=
 =?us-ascii?Q?Fl+ovjHBes7kaQUc5Uvv75hHfoyl3PKK/PcJHkW6m3zBsdATRtxs2fxMeM3r?=
 =?us-ascii?Q?CAeH5KmXEahhSdbxywhaRlI4pOJSh5IaX8nlHy/WNEg66Eb8w0IFCzyh3ncs?=
 =?us-ascii?Q?EBJhQ095ApBv7lLkoJkVzVaE0ouvM8KlnZ/xXBZbIcfnQO5fpfWN7Ud1ExmD?=
 =?us-ascii?Q?mGIxqPFut1ZC5qxXSQ4M3I1gX0n/0Aw/fmJYT6JU+9hORK0mHaRz2FWJQfDZ?=
 =?us-ascii?Q?eCaKNDfLySQnHbmnmknO+lbMroKvXFsR7dQ8gxNxLxYj7b1mN+h6wmKGT29R?=
 =?us-ascii?Q?Kamxa6o6yBp5CvX+7MxmSq9s8eJe/OiyxIxSS+G2yMEFfgaUOfDs/bjEtl5C?=
 =?us-ascii?Q?cDtj0ufYRgxQvUeEDxHQmOVs3iQraUl0zmZTzbg5SLYSvpP+3hRnWXE5avYX?=
 =?us-ascii?Q?hFvzoe7WgtuI4rzNTFJvr+JGQj2Ypmsz0QjTsWpQFHOTZ4Cz/A9KBMmRL9P+?=
 =?us-ascii?Q?VvXm9WtLp/TVFCSQ0bg5OLLEBKZHAHTwK+4TLrKgHJ0SH0wlvU/98UHveKXF?=
 =?us-ascii?Q?61eDzii6+JgAmzM2vfQqnmPYN8/H19JI259ywLFRkse0rkq3Qoy3sLtdJTcQ?=
 =?us-ascii?Q?NY0TNI3n3WaRrCW2NvfppJmN+TDNEpbuBqBk7h+qHIpWboxZ0qmd39uhcyGu?=
 =?us-ascii?Q?EgbNY6MfFircQuUAYFpPEDmtO3wDbwLDHCoJ6+t/eQSyB7QMMmSETLZDsFuN?=
 =?us-ascii?Q?Hd2O3LhUsscQWDeSsF0uGyZFWf2mqYvW+6oXWVJha/BY33jvv93Iu/v6WjW8?=
 =?us-ascii?Q?l2xqgD1FIZOs2bGulsA8KwtnaCrbbAwPAUb+l3rNq5vVkNCFgBtP12NUodeW?=
 =?us-ascii?Q?plEH5Tc9DuMFB6tbF7PGULYhOfbts9ZVWhu0w/f+/KR+2dRjaPpLYHwwGsVb?=
 =?us-ascii?Q?vWzecEnhqJv4H6oYju1Rl8xGbg01cHMayyXknTdAOKrZ2sqZ0HqJnMN7cAUd?=
 =?us-ascii?Q?Nxi6cUM9uX131uMe56A1u/7CHZyaZDE+j/kjKiqhFKbG7ZW1tDHpzp6IieYQ?=
 =?us-ascii?Q?+V+SU9Qv4nLNvfR1iRpcFFuN030hct8lxJvq4WGZyJ3smfpgcZfz0x38di6p?=
 =?us-ascii?Q?OsUISmzlEA6peE+lS9ZDl+YKVkqS/qr0zUwshM6kIcmQd9WMFT4S8sSrcdAJ?=
 =?us-ascii?Q?E/CKh4LeKdEL/r2lpNJcAWG0YEDYd2caS7ztfhFgIZGEZyAaj6H+v81Pm9ke?=
 =?us-ascii?Q?bpBXVIoQtKFSmZgBgDCxzmMXm16oeTQ/k2donlWu7iEsBnp4UKKVeFN1BZxT?=
 =?us-ascii?Q?4mX13CJQ2CMryHpeI2QYu3/3Yz9zr72naJ0sxfseBGHlmy3WtOWxoDnV7WMI?=
 =?us-ascii?Q?MlebeFHDaKm8rkLZmtIdCMYyWdE9XYYoIRUhnS6u?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c2486-d113-4813-e03d-08dd443f60d2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:41:55.6445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVyVgEiE9u0teHqUKxa6vyczmNOF3iUYdCxtXlGp9E0+vjUaGFhNWJxi6tO/gbp0Y8VzGLJpGyPx2QB4obc2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9394
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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

Directory entries cannot be deleted without also removing their
corresponding FAT entries. This refactor allows for individual
selection of deleting the directory entry and the FAT entry,
facilitating better reuse of existing functionality.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v2:
- Refactor delete_dentry_long for improved reusability

 fs/fat/fat_write.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index ea877ee9171..c78b80e0b7a 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -31,6 +31,10 @@ static const char LONG_ONLY_CHARS[] = "+,;=[]";
 /* Combined size of the name and ext fields in the directory entry */
 #define SHORT_NAME_SIZE 11
 
+/* Flags to control the behavior of the delete_dentry_long(..) */
+#define FATENT_CLEAR_SKIP	0
+#define FATENT_CLEAR	1
+
 /**
  * str2fat() - convert string to valid FAT name characters
  *
@@ -1568,19 +1572,23 @@ static int delete_long_name(fat_itr *itr)
  * delete_dentry_long() - remove directory entry
  *
  * @itr:	directory iterator
+ * @fatent:	flag indicating whether to delete the FAT entry
  * Return:	0 for success
  */
-static int delete_dentry_long(fat_itr *itr)
+static int delete_dentry_long(fat_itr *itr, int fatent)
 {
-	fsdata *mydata = itr->fsdata;
 	dir_entry *dent = itr->dent;
 
-	/* free cluster blocks */
-	clear_fatent(mydata, START(dent));
-	if (flush_dirty_fat_buffer(mydata) < 0) {
-		printf("Error: flush fat buffer\n");
-		return -EIO;
+	if (fatent) {
+		fsdata *mydata = itr->fsdata;
+		/* free cluster blocks */
+		clear_fatent(mydata, START(dent));
+		if (flush_dirty_fat_buffer(mydata) < 0) {
+			printf("Error: flush fat buffer\n");
+			return -EIO;
+		}
 	}
+
 	/* Position to first directory entry for long name */
 	if (itr->clust != itr->dent_clust) {
 		int ret;
@@ -1661,7 +1669,7 @@ int fat_unlink(const char *filename)
 		}
 	}
 
-	ret = delete_dentry_long(itr);
+	ret = delete_dentry_long(itr, FATENT_CLEAR);
 
 exit:
 	free(fsdata.fatbuf);
-- 
2.47.2

