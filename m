Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94AECFB43C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DB988B89;
	Sun,  6 Oct 2024 01:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w2anWE8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3C788A1B; Sun,  6 Oct 2024 01:26:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B7688A1C
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khUiOvBr5gHUj3IlZBlVAxfMuuLnViMnUFcZ685e6DWm5kDutsd++7UJnvFWazHh/Tn7HH12DAqPg5dxR5pq1csI0UGwqAHATKxgtSw9mU9lFFyonGP8W4/tD5Jn35YuEc0vl8ENQ6i7VBhblznEVv8Cv1JI+7s1I6zDrc7GXUo+ovXi0aKRfmH4Ao0e49Y59mJT6T2SX5Eh49o6OgrHid2YjPf6Pa0NIcKMTGA5QlShYEr7uwVNRDdyQ4uqeo6jjo3goDPyOtFqwQLbY19h/nLDCI4GGtooh6csqjOl9cPFIwRtdEC2B918+boBZ5kyECtOqzB31Nata8uMFWKCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA4i2+JpqVdM4yJGSOT0/omj6ctLMeGIjVj+Ddz5j48=;
 b=vI5vbIwtlG8WtvIHHYYosiMSreBRFVnwoY2ovhSWGV8MJaPngZnY0Ma1MRl955DnrlZoUfm3mg+kKJkilm5XgmddlY6ZutY7tKzTbxW1HwBSo1kuZCD9KmWWOldv7IFZ+NT/gk6h00h9tYEKiB5rkfUEyqjrT4H2ncbF/AcSscHpp3/yq4QPGLxlPPzmQMlA9gmhjfEbrOz/D5RsqzDG4CVaFmFL9fFKz8uLOJbi/bCymsJxDKVnx4U4Yjd7PawwadFgYiTVH7BI8Nfb2svQy16YNwv3FjPZ7qHJyFdqfsjj15+9EV2fk4dMTKHtTU0KvChCwgzoyYvXZqmfV7MHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA4i2+JpqVdM4yJGSOT0/omj6ctLMeGIjVj+Ddz5j48=;
 b=w2anWE8Jsxeconk726ML1blRn4IKJO37Sj/wfNl0rJ5TeXTGikeSsAQvcyRoX3SGl5jqABcmqvaC31V2tcjwZnbDxtQk1d54wRshqulyMUdjboYkfYGGa+ewKdTucAygfSU6b1EUCzse+8l1c/Lh8ngnJebVhO68UBfo6eSq2i4oNJ7gFZINof0B5btZ4Bo0IPy5a2z9W6p8MOPH5qSqBFACWLKegnBxcJpygtr+pBE/tyPmXcUEItMUyB4/uFTujpe6Ah8fZzeaHVdNDah8/jlVTto/mPmK7s3kBr3nqMCuovxnbTKeFwNyf56DwvXZ5jeAsrUPEa6VIfuz53akYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9217.eurprd04.prod.outlook.com (2603:10a6:102:232::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Sat, 5 Oct
 2024 23:26:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:26:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] misc: ele_api: Update ELE read common fuse API
Date: Sun,  6 Oct 2024 08:30:02 +0800
Message-Id: <20241006003006.20162-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9217:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d0db61-6375-4506-6d32-08dce5951f99
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOborptWgEZBMxe0PeFQEC6XWkGETjMesqUaci3XVSJt+cAyXJaGkK+1lrA/?=
 =?us-ascii?Q?2eBKaqZrJjQVwJeuaWFtoUVj/foY6rEWAOAq+fzXsUMWsrfjwY5kebBtgL93?=
 =?us-ascii?Q?Wh9x+BO2QGPHq0hoy10wGmI3OdoosyRWGq9CZ3ytQII+bq6TfC5swFT1aiDE?=
 =?us-ascii?Q?w5Vj2VqGxO3i0rCydowqmMd+G5JIgqdTVmCJsFKA8rc5XS/92ANx5Ix58CSb?=
 =?us-ascii?Q?06ZIU+jTOaK8r3St3mNmOFduFMqYs/uMO4bUnZfNuLtEX8nCZERjDzgwRijo?=
 =?us-ascii?Q?ZXoxCiXHbDe4Ft48XwbyBrFjnSptg2hEDb0fcaMUMF7xnKXd7Kuop2BzoxS2?=
 =?us-ascii?Q?B1O+XSXKwAR+LuxtwErbxROsYyk5B+oyQqU7uftpSric3FCK93mR/ciD7WZn?=
 =?us-ascii?Q?4wsUfwE9KGwu/C0oI6aN2EHjSzw2BSi+lJEot6DM/fylxKQgkFzqSbgh0M8e?=
 =?us-ascii?Q?Q88wFbQv+qCL7sHfKUQ480a9fPrInO84SJE3nr2L32KbD8533zbM8TmkslDs?=
 =?us-ascii?Q?Bt0ZrixC7qL7K3l3zgawXb3d0xwnFVufnrpuuxlq01vC/ObpsnoBj5NiNuvZ?=
 =?us-ascii?Q?aU9OKHUc3tJadWIDqSieWVenuiNCHcfZz1XV9i/E61iKxUPn6D8z+eiVUyM9?=
 =?us-ascii?Q?Bzj4RtLopD/5sOu0yD36Q5oiOCKA+0mODhqHbQnJ9EumGnFcInGc4I4kEFQO?=
 =?us-ascii?Q?T5TOrDVmM2j4h9hTqlORE/TaC1BE5IIER2lqvyKbl1OnLQSNCGRZE281B+kt?=
 =?us-ascii?Q?SjI8t2aWZsG5B+aS0U6XyyHOsK9/fzAcSa7z78j+OYZMqO54ydryHOnouNBw?=
 =?us-ascii?Q?mzcSoFELzUWo4tItYH+giaxcnbppkL+E74dnkQQ8i24spo4sgc7RUoVgPytq?=
 =?us-ascii?Q?vG9yLWGZNvx1iAnx8RmNHg7DWPyQsbuHzy2sNISQkHRYNEyH6yWDzOe377jt?=
 =?us-ascii?Q?gAd7GIqgqYqfLvxgkrADzBzDtrUgACWUeRNvoS9GYk4CdRFd+04gKwzl29Vc?=
 =?us-ascii?Q?Ydp2uO8YaWsTi40Sb3sYVR+SvoH3hP0W9HqGUqTRYmLXwmMX96G5IQytKJ0j?=
 =?us-ascii?Q?RbL2iYivILbiI+UjcBHcgte5lBOJxcRG1jYuEM2VvpGogffpHfnf22x1f6H+?=
 =?us-ascii?Q?YukSfafNAqF3s1zz/CmRfmf+Y4Kok9osVQGQV9JDkhc6EUb4aymQV+yQElgZ?=
 =?us-ascii?Q?ak2VRbKzfo0zbVrkhVQeFbuu2yFSO4ylgrdAXsArkmgqG94XiEto/8wOg7eW?=
 =?us-ascii?Q?ZfLXF1eK3sQ7P9b2Yp+vX2knc5l6fcE/zHsohFIDtcINKEKHOohDgYkX2X4i?=
 =?us-ascii?Q?i+QlN1M8ZrMhuo2LCiSS1B+f8WPvZPHhAUyQqYJmNrp5Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wc8JE5JKSWJxiYJe9gm4qFNj06oNg2+vYSD/3zLjQD06dNgXC6+36QS6a0VF?=
 =?us-ascii?Q?2f0/vYZ7fKTknWP7TFy1DWUgKtV+4nxk9HvW2b6skhCiaAbTqujqIB34GJy4?=
 =?us-ascii?Q?L+E/IY+/+/YxW4hpVgGNayegCOyKrB5nmvk7sbZoVbNFzzmUh8TYPojuh0n3?=
 =?us-ascii?Q?caQwyv8TXJUJfLB587MtaNY0tkvuir1Fq+BU/19TF85V1NFeBiw4z/+YAYVC?=
 =?us-ascii?Q?g8vmmCELFzfOMPCj+ewwEKAKoI23R/kMOkSbZmLfpgfT8WURR9KTtmPb5wHg?=
 =?us-ascii?Q?2aSusu7BDeVzOiN8wgK67+dceqPlpn04VvhSiDfUREV4Pt1kqvouWPZKAogZ?=
 =?us-ascii?Q?GygRENtDTIvsaUwaqzkpltwM/6JO+qUgC4G+8CM2m6dq+CZKSUe1Dk2IrGH9?=
 =?us-ascii?Q?2rjxWyfNsQcmPXFaMzry8/GLve/S+lZ84WV5Q9ba/NECOU4p2MMwOUL3wZW1?=
 =?us-ascii?Q?xKEaTvzuqdbMZqwTcRo2OWQg5+N9KabYVCVxHPejf5VrRiv3Y92+UFSCtMCa?=
 =?us-ascii?Q?FmAxFEjMPmUO6Rmn83RyVHG33HYT91+YCxFbr3ct6MvbWykGuR7fyRCP2qle?=
 =?us-ascii?Q?hO4nrUrKfFHjftbCA56KTv/h4k8BiuvO9DSCVZnzHiyK3MRKeA8MZtXlOc0c?=
 =?us-ascii?Q?C+FUQUym0Ywu9i4HduNdugqfLZq56c5gmhE3es37atQOepavBX6tgdkwBRJj?=
 =?us-ascii?Q?9DUSXNiRL4x3EHk8ulrEoLcKb+OT+o7Yf25cVLP1nCCxkxaJBcq5yLus9u8s?=
 =?us-ascii?Q?9nhtuVS4ZSwoRgcc18H5vk+Euz2zrKLvVKyjhBwIiRqH+lYPoBLPIE1q9HgE?=
 =?us-ascii?Q?1ZSJnwE060UZGK47nQ/eJA5MLff6RWUIGpxpHKxrA6FeSzLNCZOZvApykMZ6?=
 =?us-ascii?Q?yThA1Hygus2Y51gsZH/wwz3A+XfqweeJPKMYkrIh+IDh/B3hdhzURAFY0N9K?=
 =?us-ascii?Q?mRdxo3Q+mw/PBfYtWRKufrOPORBJt2usdIwLxzLh/v9f75UA5c+ztpU403CR?=
 =?us-ascii?Q?JH5+/bnzMmfQnZJhjQO4M4eFqFA9kwCauGEtjAuFI+jevE3rzuPzpxkxS7k5?=
 =?us-ascii?Q?anjnLbuQP7mJIZ2qtvAJ35BZeCd9S1RyFOK4sIISryuiuALrQFjyYzBQauUE?=
 =?us-ascii?Q?Gbw/ipOnllZOAyx0f13ctgd4laj78h8RVeIhEwWhCrKDpD/W6CjJpWJQEbUp?=
 =?us-ascii?Q?SxJPnd0dNX1ScRZkGtY4YjuCKu3mLF3QZZByiK7tnWbNYQaaKGRsZcCLPBa/?=
 =?us-ascii?Q?xkj54P5s5531160f1LR2PEPMNs/A/z/tfEpHdcOytrW4Mn/j1CoE6f/8D4P4?=
 =?us-ascii?Q?i9cjNl0I0f8LASCv4QYParjY3KIIH9XxGNSLsh73oGI5LcB8huKCO9Wp5jbW?=
 =?us-ascii?Q?McONmKWLrO9e0XsMQjZTMqU4C+2tj5oWauoxTlZC9OzddV88P2dotQ9RnA4m?=
 =?us-ascii?Q?rEO8oNX91gV1odbqc0OVtd13cXaPJJMpA6E81fqsjv8odNHc/YUmD0lWtWTL?=
 =?us-ascii?Q?zMK07EZakldm9m9jzVoJI3tXB1iRZvnzAneZEKCayJarW1aLzYGnN8rQnapL?=
 =?us-ascii?Q?F73BISni/qnqzGYqbW92oFrm1Qyfe1HWAE8O7AkO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d0db61-6375-4506-6d32-08dce5951f99
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:26:22.4710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP76v3t7Eap3PsQSMBNQdw9XshgHeWUjt65qMv5RFNWP8f18bwyi0KYtC1YrZ2pa6sB8NE4htsgGgxkuW6txqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9217
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

From: Peng Fan <peng.fan@nxp.com>

On iMX8ULP, the word index 1 is used to read OTP_UNIQ_ID with 4 words
data responsed. However this special index does not apply others.
So restrict the check to i.MX8ULP to avoid problem when reading from
fuse word 1 for others, such as i.MX93.

Also update header order

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/misc/imx_ele/ele_api.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index e478d7dd50f..fd57928c5f8 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -5,12 +5,12 @@
  *
  */
 
-#include <hang.h>
-#include <malloc.h>
-#include <memalign.h>
 #include <asm/io.h>
-#include <dm.h>
+#include <asm/mach-imx/sys_proto.h>
 #include <asm/mach-imx/ele_api.h>
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
 #include <misc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -205,8 +205,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
 		return -EINVAL;
 	}
 
-	if ((fuse_id != 1 && fuse_num != 1) ||
-	    (fuse_id == 1 && fuse_num != 4)) {
+	if (is_imx8ulp() && ((fuse_id != 1 && fuse_num != 1) || (fuse_id == 1 && fuse_num != 4))) {
 		printf("Invalid fuse number parameter\n");
 		return -EINVAL;
 	}
@@ -226,7 +225,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
 		*response = msg.data[0];
 
 	fuse_words[0] = msg.data[1];
-	if (fuse_id == 1) {
+	if (fuse_id == 1 && is_imx8ulp()) {
 		/* OTP_UNIQ_ID */
 		fuse_words[1] = msg.data[2];
 		fuse_words[2] = msg.data[3];
-- 
2.35.3

