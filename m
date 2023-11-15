Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3058C47074
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E155A871D0;
	Wed, 15 Nov 2023 13:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="fWlOHDJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C58871D0; Wed, 15 Nov 2023 13:44:37 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86F986FB2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3wYcm6FU3GFA1rSOfmBUAoR6EwNJX+o6UH+jOffaa4ZVf9z5GjFG8EAT0nkys+HdeyMqAisG2AgnCSDX9qyP1xwP9r3pb0W0uARQ2PNbuw0Q2CWD1nPQpok21J3ro6+jccKGaAgaMLqp7+QlGIwkxLx+urV/xbua7PP7601cihqXIn5eEmoKqfJyu8UvdKbKY9qGo2M5F7Y2HsdUW0O6sJnSXJPB874rGyIe1uJ6Opud364I+/iFvfWjeLVXy5lQyvZrTdmVa8cO9F1p3Fnr55mHjBzXg/QgwZgTkuRLaazDpbw5uBIx6DV3ZOTWRiKRw86+YZeCG4zFHez24CIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRX8i8FtgzzH84rGOHYXqam9Kuh47u0YWv6Fl+zBniU=;
 b=CxqS5RvbNJocBqgiaHl4jkkYgzuLAEFzByb2skNLZq70QvXhvly+Hi5NL5SpGFKEyeEqnk4MFfOd16Vanpx+F61mIgsQ9JjQFLMWBa1w/oE9Mi/tCvVTR+oCkTkHFvmyI7iNDHMHbWORcp4960TgBstIgSLxCX8CcjiHsQxWY5eJpjfVIrLadv7mIMK5q65ZjimfV/kcZ0dgdZpmTzRyEQd8LTphLUTKxjlkfBmw/uc0sUlqAYb1FC27eTqUSmwDheNZmu0jBzohVX2wGDtGLp5lxz7KpquER6fTJLaEpPduqCfA81roiV120JAvZFIdtf3XargFCF5jNqvEPQTuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRX8i8FtgzzH84rGOHYXqam9Kuh47u0YWv6Fl+zBniU=;
 b=fWlOHDJpNwU2yihFZLUxFE9POWl2/2mcMJoBaty+1tccMbV1RTIYPBFMC0nsKk0Kqa0IgZDueboz1HmhXQ3SL1G5YYH2AtauJ4miC6NnSzN/qCtuTIDk3ovBQOyMvG6JpvWATkdyxEcLFg1JgFnXq6ygx3BcpkRU0EjiaO3l348=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:34 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:34 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/9] fs: fat: use get_unaligned_le16 to convert u8[2] to u16
Date: Wed, 15 Nov 2023 13:44:16 +0100
Message-Id: <20231115124424.125823-2-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|AS8PR08MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 93943735-5ad1-4758-ff08-08dbe5d89ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5HwgRQSp7doP7ZEXuzdRflKrp0MKBqx9DQIDm9PotU+ACYv42KaYIMV+iNt0UH5upF+wC/pbbkYgCGQEqGJNkhxmRw0ckgHQUxvl5ZyOoxKxkRiP0sha8gFakBR2I3NNnmjk3NaFs/Y2C9zZROQqCQ6hVfh1j+5M49LQVrzFvlAotjk1VTT2OgqtkqPpc3VTTwI2ojwm+v5/LywZJQAShbKfzUXKePbOjdbW/7L/f50PWxYjfIkZiDdkP4qgj2DwNTshsv1ZK23Dlr3HbydsgEnzQYui8fJqjMJVkoRWmlzU96m15MNI9SblJCB4iLEmrwQyC9d71c1BUx/PQNuDSXkUSrPs9U15tP92W+i3LAUwCjbg4+DeESWTfQwWtKBeFLsupVcn7ZcR6p4ydLHAWHMC22uHrxGIYq4v02NljpYA779uvzJx+c2yH4Mh9VXhXKijwWCyw8vFrYJVXfO9DX4g392crVwog4Doure0e5BNjd15Qk1+m6M+H1gPXGnqdohMOpwe+zfLQUhQUWspY+tB8cT5R0BfdaOHKU0H7BwEp32h3XfVIvcJv9gCLVH139Gaah5FD3IOnHJf8whNGCQJFJwe3kqqjeFKRu8AqYRXS80c0HqbCXM0RjUgKQi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(478600001)(2906002)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZTewlhS39bloxehAz+ED+JWJVQYR8/JVJvjkj1xPoafKbCpTrE8DWPc1foB?=
 =?us-ascii?Q?0x1ARZdAm5vcXX1qNXLFgLxzNpltzEpb6G5JV3s6HOiaZ/MCZbXwbMV24VeO?=
 =?us-ascii?Q?02Ae6xaXDy6gwiTt3tCWEWaZ5Kg7gDpW4zTENBMfRTQsd7n9ubyHFiF/E0I2?=
 =?us-ascii?Q?UpLzafeSKlRepnINp+IG3hexzZXEYzjoNp/cumsAK9wXr4GJmGuavLlXkvhK?=
 =?us-ascii?Q?p++r5UoNhPq57W9CL9IkDcdowVFHMxo3ozD1udjk8F/NDKlGaFUeUQld0pVL?=
 =?us-ascii?Q?472ouMr2bVPMP3FYicIy70CCkt7jT1Oy4/+ifNz2ytCUSW7aMg2QqdhZXa3U?=
 =?us-ascii?Q?JfwvwgONLCqejVnZ7czlbpc+ikL1cE05t1T2hMqznrPVeix41zeCeUK8VuzF?=
 =?us-ascii?Q?n1oMXhoACEe/Ky03FQiWRmewhEfy3Yhi5CXHDPhqBYxZ46vQCdetISOcqqml?=
 =?us-ascii?Q?T6cR6PnSFN90M45xZ9riYSu/1KfT9t4tmFsqocgZj/EzRj3HGWDB6LumThgN?=
 =?us-ascii?Q?yQh3s2k2y6U3ILO1nMOq7qq/ELUO/Wli2ZxxdtNifK7+z07WCPelaAWlbtPq?=
 =?us-ascii?Q?siRU+8b7ICLHPd7l3ewy72x4d39jio4WWAB2emikOQUmVdib1I4IVe9DMels?=
 =?us-ascii?Q?27tgE6NqyadGmABbeFivziGBkppoYyndR4TAOrEYNezruhonSOr1mRQzIZU3?=
 =?us-ascii?Q?Y/fHflbwirWQyGtOXv980em0XCMs1mlmmF3PZPkjWqm7o79iCkUSOLzVT6v8?=
 =?us-ascii?Q?BDn7YKw9hzPBfs/uyKCqwF5q1GWrC6Rm5phvf6DP0JvjySEcrRq7GE7o2RwE?=
 =?us-ascii?Q?Ubf9JEK/glatklRyvkv9ru/J74hNw0QqrApUEUYQImxWZPPklj2WHuKhfYRG?=
 =?us-ascii?Q?jzhcCrg5PjNRLxAOTnswA4xdcgoL4teNTWNmRPHw7jUGRK0aR6AR6S3BAI0p?=
 =?us-ascii?Q?/RA/ue4yLrgvvRp3vue1ojKMjQxVIwq+FzfcKI7Fniu17E3dDrCQJFuFnkc6?=
 =?us-ascii?Q?vuD2XVZcshxhKZa//Eli5JKVoHMYXmrY0i+wsm7cPTmKtaNCjI0hbf2oJ3Fq?=
 =?us-ascii?Q?azbmenhTgy8BnBs9CvG1X6eZ5lH7RDpkQWMLjIz1uOnY6U3+eAbRSfoB9bC8?=
 =?us-ascii?Q?V50NI67o5nannGxkypff7WFF9869Zl/br//Vd8S3NXgqjbFDfe4qhwVqLegr?=
 =?us-ascii?Q?C+Ft1uR0ZNkDnxDbmH+u0hbxr7a4jzhPYzgZTUPsOYb1u2LOcuzzcNakltTT?=
 =?us-ascii?Q?sMKtS+wyuz7mpUYGbXET7Qtf5pHymyW9h6Nd7FhrZsd4CJ7a5/QOE7TZFx3e?=
 =?us-ascii?Q?oZrrEWQkCgc42Z3KAQaOYDiPqqRfCOwCvgVpJuoc0rycMEKgtDegZ72UYrbl?=
 =?us-ascii?Q?cU36ZtuzHRzTjXmuuCGRz5MZRTamvsKO5UmitxSqDAkxiqQrjpgAHJuBj9Ia?=
 =?us-ascii?Q?rOj2vmTmqf/1q2SR+lvcuukM+fOFU2gBrZ8CfkvCQ9amIqHajCmsTiz/ZY9u?=
 =?us-ascii?Q?sT+xsilvcEQMTSdeuvLkGd3CyZIjL/0jgcQ5AtJt1duh/jU4oMeXK2r4kJ7s?=
 =?us-ascii?Q?v2I1UZnWJJePqVGtwWwzI7n5yGuCuP7MAfJKJXKFCerJQ5MzcS2l1FGXejjz?=
 =?us-ascii?Q?Qe3rjRykkCPVpe6GUT7QL/iyfx5WWXzKGwvaPSu88OV7?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93943735-5ad1-4758-ff08-08dbe5d89ecd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:34.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5os2p6mIoM/Nn9OHPvNlE5YstCAXEkmQBq+Br/GSNVhwTHnEliUkZsSNwMTvoYV2MtWRH0WXEfoQ02yYFPp3YUiXM4vov2WCr64Y6IO8YmTnaESTgS/arcluxWByDnk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5911
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

This reduces code duplications.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v2)

Changes in v2:
- Use get_unaligned_le16 instead of custom macro

 fs/fat/fat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 8ff1fd0ec8..a3522340ef 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -18,6 +18,7 @@
 #include <fs.h>
 #include <log.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 #include <part.h>
 #include <malloc.h>
 #include <memalign.h>
@@ -571,7 +572,7 @@ static int get_fs_info(fsdata *mydata)
 		mydata->total_sect = bs.total_sect;
 	} else {
 		mydata->fatlength = bs.fat_length;
-		mydata->total_sect = (bs.sectors[1] << 8) + bs.sectors[0];
+		mydata->total_sect = get_unaligned_le16(bs.sectors);
 		if (!mydata->total_sect)
 			mydata->total_sect = bs.total_sect;
 	}
@@ -583,7 +584,7 @@ static int get_fs_info(fsdata *mydata)
 
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
-	mydata->sect_size = (bs.sector_size[1] << 8) + bs.sector_size[0];
+	mydata->sect_size = get_unaligned_le16(bs.sector_size);
 	mydata->clust_size = bs.cluster_size;
 	if (mydata->sect_size != cur_part_info.blksz) {
 		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
@@ -607,8 +608,7 @@ static int get_fs_info(fsdata *mydata)
 					(mydata->clust_size * 2);
 		mydata->root_cluster = bs.root_cluster;
 	} else {
-		mydata->rootdir_size = ((bs.dir_entries[1]  * (int)256 +
-					 bs.dir_entries[0]) *
+		mydata->rootdir_size = (get_unaligned_le16(bs.dir_entries) *
 					 sizeof(dir_entry)) /
 					 mydata->sect_size;
 		mydata->data_begin = mydata->rootdir_sect +
-- 
2.34.1

