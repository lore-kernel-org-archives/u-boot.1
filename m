Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7373C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB38E805E2;
	Mon,  3 Feb 2025 14:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="h1IQQJN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA85B80087; Mon,  3 Feb 2025 11:42:02 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFBC80107
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3nzQZDblfDW/SES287RHkwaPfOHTelveRyiBldvp9Zsw8rSrfn+DtvXsOphKuH9JmG5ChbvPA2H1cooD93wFaEQ20qjcR5U6Q+ppeqvMU5ZGdwok/UiKmwEvJwhZQSDVINEXX8n7cuMbJrB0z/zJYuCjEU7oFVQQu1VCu5kwL4Czo4tEVqrjseQ6dmRfGMKnXFOdcuwxkV8FYR1hBH8lMywsA67A0q9Xz/JiB7EqTverDYGWJmm06W+wdDHhQ1z535lXzerhVug/dRJ6Gjyfs8pCnwC2ywq43MHMc7vXgchIS3AAZ19WCH9P79PjDZAlVF/Rv8yU1OMCuHvvehwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuYb2nELGG2ClcC7fUtoeCdyygi26vAJQ7eIQKvnJbU=;
 b=W+ob+ikMWl7QrpncjBqhXpIRX9/VE6dpirRPa0+NYRuw/zdZ2I0q/R7jF2sFk0Y9vjegAYfy3QUiJC6bm3N69hKQBNGqs+TZPxqziPU2xPXzo6/ooEM9VipSYNsKws3OvywZrUlTfmoOYccWd7K0mbcaIKiLZ6l/4jGVC62RWhmG1B/E1Xg7S9sRLZxz+08pJWNLjbI1M6VoaNrVCERC8PGi3SBC7bhzqkhaIaGlCZYjxPqkXatsDifoN4NnEMf59Dx1HtHl923qriNZVlq8Bf8Ptfv18AKYRUgW80eEC0V08JmDUxvuJnZB2KSAOp65t4wPJktH9sJZF44/IX6E3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuYb2nELGG2ClcC7fUtoeCdyygi26vAJQ7eIQKvnJbU=;
 b=h1IQQJN/tWrwP+l26SxIlgd40BnJ9M0HcYg4dJTY8GdYEcudWwZCbgnv2+XK+3YRrT88dm0Z7Awci5MKj/3rgShpFqrPKa1hIyl06EaNxZfx3/I/hdMikWsNLS7jtM0gw73B/Jen0aMBNXYl7Bz1LFFxqomekIqP2g/1JZD4ibc4JM4SsMrl+7Yaz1F4MLCJhmrHZLaDKK+K0Ki7IBlXVNbknhTGj49qdi+mqZi7skmgQMpqnBXo5ed0eVfV8BjRWEF8yROY4NruTbaOQRC4Nhh0BqBecDITdCypQbFKhix6p9invzIclEVxlKB81pykRSTVU9iEnSB6KJMyxqY0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by AS2PR03MB9394.eurprd03.prod.outlook.com (2603:10a6:20b:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:41:59 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:41:59 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: Manuel.Traut@mt.com, burak@gerz.io, Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/4] fs: fat: Support basic file rename
Date: Mon,  3 Feb 2025 10:24:51 +0000
Message-ID: <20250203102501.35750-5-Daniel.Venzin@mt.com>
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
X-MS-Office365-Filtering-Correlation-Id: d44a9b61-1f36-4f8f-6ccd-08dd443f6200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dNxF6fR/Ox5Xo4IbFX7kXa09iCCXFMBZpDs2Ltg6z0AjQ+nkQxpdFDp7BzGH?=
 =?us-ascii?Q?lTsfousIiH2WkXzYUc4Zff+OBEaT6UqsmdrjqwaaeqnbpwpzEjj7dG/HljJ6?=
 =?us-ascii?Q?KhRvf49mK2HK6YzIYrigQNAGlxwRKRqVqiYsfJ06j14eLXfyaeCY2cui4YCX?=
 =?us-ascii?Q?0V4rxkiq+ZxKrBoOVFb8Vl81EG0wW8B19DncKoGYa/1JiNzWY10k4DLjq87b?=
 =?us-ascii?Q?cWV1P0YE8Zfjt48oUwNXCej9NBwSu9OUI13Rb7gySpzzYIbFxLeqxGpY/67P?=
 =?us-ascii?Q?966rtq1s2SNR5yeKU3OToMSMsirO0pXnzRMdDE2E1HL7/oeYlsau3Jt0jGcw?=
 =?us-ascii?Q?TXbN13PcOYbqa7cQAzNqcg9IP5/b80mS5TprDB+Qk30/SIW2QmTixfiemAzn?=
 =?us-ascii?Q?MMft6eqJbIjuIE8r14xJadl9bxgf9x5rfrYTlS0XP/2rwYZFXRFjEYnY8bb/?=
 =?us-ascii?Q?6rSC09FHyGc2ca0dXQl4kpAZT0THOqMJiu3o043eb1lRmResTFrzgxr2g0VZ?=
 =?us-ascii?Q?j3UXiwto9y9Jh/ZURhpa7fndROZRoQa3xdymnqiw2oQyajM0oMZdYfPysumk?=
 =?us-ascii?Q?DK/F3Rz2lLc0UljBidusTCUf3WZr6q2P7TDFXyvULU2jmkHLzGwf9RW6HU3J?=
 =?us-ascii?Q?bOE3rZU93DMxUqFsi32vzrkFboAFlMjy1fiAVZ5E/PR+CuF0fHOjZkcFyA4D?=
 =?us-ascii?Q?7dpod5VmymbZj4fclkwTbtqAFjbYjmKeK13dkC3+JxfgkPGlcyD9M1Yw/cW3?=
 =?us-ascii?Q?5a7wrmbxydQlwppKK9pLuPAuBXuJR09rGCTnMCUrDSaEgR6iUwRgl9OWN1Fq?=
 =?us-ascii?Q?BXh+r+tg2oRwsT1P6+NntAqhAuCU8RMwsgt8IwdTKjuyn8VUt8ncq3F0XaKr?=
 =?us-ascii?Q?n26Q5tp4LZNpKY59D4k43uxFRhgSYwD41z5sBHZo2OVnHswmwJ4K080svT6Z?=
 =?us-ascii?Q?ONyacYxDQQE672l9v1SytiwUZkaazuemS1yd6cyPt9CrKN4mESvPurvkyDLp?=
 =?us-ascii?Q?u8h/TQ5jGn1wj0tlgLbLEeI3mDdlNfV3kgyW3vMKtYX2idWkGqH+5wlU5jwc?=
 =?us-ascii?Q?deLFoeNhtPdlhNZ5MF46kCnjdp09J3gwTDGpD7rAzfmUQtQqOy7FW4SgjQk6?=
 =?us-ascii?Q?+hqlhRT/m1h1Ke/rA03QefgRcwUrSyRREMkQWwxtZejZs+6PV/7HRMwDBwOK?=
 =?us-ascii?Q?bKq0a24Hjzt2s9XzqGSikicJ39QAHB8ckPROHDvJbbaKlh9SD6SWDNLG2G/p?=
 =?us-ascii?Q?WF4d20CgbiVERtLucgNZUtkg6ZC5dHj5DYZhDEknSgW0maYgFIZruGKJMNNX?=
 =?us-ascii?Q?ha9K1eFaM1Oqe6EmhEN6ghAfNh+NVvmzSzIVvB4uA7TZFFo1oEpTtnNwH99I?=
 =?us-ascii?Q?M5ZAY5q8TNuCn8OUM8yGV0E9s/hPS/7fh6jlTIJ6KrbqgHyQOz1TlI/s518A?=
 =?us-ascii?Q?4A/fwm7924/x3dDHH3fWzucsxxa/1X+S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bC0VEuHjd7MPwS/gp0LgzqoqndlnL+1ICYTeDrrcE59ZvjVdSnPJH2E3KnnL?=
 =?us-ascii?Q?aOFrsrQ+cwnYv9ALZBclzXY4tQ1QZoUr7Uv+B6no+QTO8B7AzZzI20tC5L9e?=
 =?us-ascii?Q?UPzFPQjLxR+Cr5vWurrMUNxekSFL2ipmQq07EM2LiAt1553uSo2NsDmMe29M?=
 =?us-ascii?Q?1xAuVxnbzKCRgPT2XROrkPBUG4SbunQgGZfTXvBffd6/Sc7KAp2/NHMynW+3?=
 =?us-ascii?Q?+GuWLq9u7rPPxYvWhV5gUZRJSQ4FrQXiJRGQl7HPtH/J4i357qO9aw/3IDim?=
 =?us-ascii?Q?wnQcSSHDdySWsNfxIVGvf9p7UYAqHnknNOAFvVwyx18PG5s+HBf13H+9EROA?=
 =?us-ascii?Q?W/DEcXCT72X2E9Jij3D7PyXRHLMYoMR1HxODOv3Xg2Mp+5dMHH3BqPvn6CGQ?=
 =?us-ascii?Q?x1V4hdEKdMLPdZQPlHeNjvxXhetGDwDHIRg+swbwiQcgzh9UcqVdpFIFLjAs?=
 =?us-ascii?Q?HUGe6NvMFPbuto3zp0ilsKbyAj8+GgcOOIUfI8IawWU72QMFA/2HV9T42LMc?=
 =?us-ascii?Q?/ZXxUgy6eZ6U/GhDzkRA9lDyHzuk3xu9jzkK6ervEbSH5dm3xx8hww080X5N?=
 =?us-ascii?Q?S+tyoJTl2gizu5b/AIwFLZdTVCyQ6aTXviUNE/1HXzT6xR+vHvdbq/ctGQMO?=
 =?us-ascii?Q?tb7pZt7zLjS9QNZ0mhfnlwZ9D/GnDMJ/hWTvyGOI0cDYmJCVZ6LpWZwoC/gU?=
 =?us-ascii?Q?iSaQ5TviYifugdVwjsVcnNbAvr0Cfl6jV9pmd0G1yApL2lS5ff/7up7Y5iRe?=
 =?us-ascii?Q?BZMcVaE5nNbMtpISNSMS8ZzhZfpLnWOB0miKbMVhd0S+kTBZJ7+pVgNtLMiW?=
 =?us-ascii?Q?JPaOzQow43KNRjzfsnvfO4qe3udRPsjZblpILaWZWQ22ZNmfT4i5VA1FIXXl?=
 =?us-ascii?Q?YFCPklYEh76AXP2lEoiHaEZl03LKsc0OztoUTsSBu2JE9eK3SpKrBWgTIi0g?=
 =?us-ascii?Q?IlGIlc3ooCRlysfXvhrWDszhfFSYxLfXo1So3eJLECABXDMur8916oSScuyu?=
 =?us-ascii?Q?snN9yGHA+F7MooKwm5tPQ2hoRSsgShJ4bjqhpAYj81sdVZ40HyvWRtfNNG3a?=
 =?us-ascii?Q?fAUp/X3v59XKAajft8BWQC2314wnNGzgfwY7PwSyeMMgE+8ovr1toQdM9acy?=
 =?us-ascii?Q?C0tgqS0DQQHhqRVg+u4j3eZPKPxAuzGU0WEAinxTxtUWsPMPA1KHa0flNm6v?=
 =?us-ascii?Q?q/lU8gbqhsXe9fm76Jo2MeqXSjgRmwVOMueaIGERkl4zOQZOFUbwp7LtmmN5?=
 =?us-ascii?Q?efVSMcF8A0XQwiN/oZn3230NDuRr6VQA+/7SXbZIehB3Jp12ecmPtUIGvs75?=
 =?us-ascii?Q?Cqg5iJfqiYaQLU6w7R8EF1VULMEU1PeN5lnrITYlLzkRwivdLEBLRiLIiqvN?=
 =?us-ascii?Q?hcOLzLl4PYNRXh1fre7KIVaWNjJeWnaISSgTlfErFUwSfAsna5Ms/IRUJdTI?=
 =?us-ascii?Q?fpWJffh+CRoX0fy4BiImd141UFeASZ0J0FbSoxkwzwzDPb37KInejkH+JPTu?=
 =?us-ascii?Q?Gnd055GMhKIep/MbF0PbUi8nM1nvvPGLNCZKc7GoQpdueHNq7pXBQki/j50X?=
 =?us-ascii?Q?YA3UoxnO4itZya36pLjU5+OfJXpIi+9PDk872cq8?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a9b61-1f36-4f8f-6ccd-08dd443f6200
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:41:57.5822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6P9XWWYJCFSwl6LSsfE/ZgWlloIAWqW3WJYw0eWmBhrsQbKLCfv6M3UX+fLr29ao9q9LGZN0oV1BPK31mo6+Jg==
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

This implementation currently does not support
moving files between directories.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v2:
- Separate the rename implementation from changes in the filesystem layer
- Eliminate code duplication with delete_dentry_long(..)
- Ensure that the source file exists, but not the destination file
- Free the fatbuf if it has been reinitialized with fat_itr_root
- Delete orphaned FAT entry after copying file metadata

 fs/fat/fat_write.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fs.c            |   2 +-
 include/fat.h      |   1 +
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index c78b80e0b7a..2273bf16053 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1821,3 +1821,113 @@ exit:
 	free(dotdent);
 	return ret;
 }
+
+int file_fat_rename(const char *path, const char *new_filename)
+{
+	fsdata datablock = { .fatbuf = NULL, };
+	fat_itr *itr = NULL;
+
+	dir_entry *dentry;
+
+	char new_path[VFAT_MAXLEN_BYTES];
+	char *path_copy, *dirname, *basename;
+
+	loff_t actwrite;
+
+	__u16 starthi, start;
+	__u32 size, entry;
+
+	int ret = -1;
+
+	path_copy = strdup(path);
+	if (!path_copy)
+		goto exit;
+
+	split_filename(path_copy, &dirname, &basename);
+	snprintf(new_path, sizeof(new_path), "%s/%s", dirname, new_filename);
+
+	if (!fat_exists(path)) {
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (fat_exists(new_path)) {
+		ret = -EEXIST;
+		goto exit;
+	}
+
+	ret = file_fat_write(new_path, &actwrite, 0, 0, &actwrite);
+	if (ret)
+		goto exit;
+
+	itr = malloc_cache_aligned(sizeof(*itr));
+	if (!itr) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	dentry = itr->dent;
+
+	starthi = dentry->starthi;
+	start = dentry->start;
+	size = dentry->size;
+
+	free(datablock.fatbuf);
+	datablock.fatbuf = NULL;
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, new_path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	dentry = itr->dent;
+
+	fsdata *mydata = itr->fsdata;
+
+	entry = START(dentry);
+
+	dentry->starthi = starthi;
+	dentry->start = start;
+	dentry->size = size;
+
+	ret = flush_dir(itr);
+	if (ret)
+		goto exit;
+
+	clear_fatent(mydata, entry);
+	if (flush_dirty_fat_buffer(mydata) < 0) {
+		printf("Error: flush fat buffer\n");
+		ret = -EIO;
+		goto exit;
+	}
+
+	free(datablock.fatbuf);
+	datablock.fatbuf = NULL;
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	ret = delete_dentry_long(itr, FATENT_CLEAR_SKIP);
+
+exit:
+	free(path_copy);
+	free(datablock.fatbuf);
+	free(itr);
+	return ret;
+}
diff --git a/fs/fs.c b/fs/fs.c
index b746d05ebcd..3576d5c6644 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -208,7 +208,7 @@ static struct fstype_info fstypes[] = {
 		.write = file_fat_write,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
-		.rename = fs_rename_unsupported,
+		.rename = file_fat_rename,
 #else
 		.write = fs_write_unsupported,
 		.unlink = fs_unlink_unsupported,
diff --git a/include/fat.h b/include/fat.h
index 3dce99a23cf..415ebd7b7c8 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -207,6 +207,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
 void fat_closedir(struct fs_dir_stream *dirs);
 int fat_unlink(const char *filename);
 int fat_mkdir(const char *dirname);
+int file_fat_rename(const char *path, const char *new_filename);
 void fat_close(void);
 void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
 
-- 
2.47.2

