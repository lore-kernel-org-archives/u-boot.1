Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D499C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C1087677;
	Wed,  8 Nov 2023 13:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="brCp16dk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1965F876E7; Wed,  8 Nov 2023 13:13:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7281A87677
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqxtiNw1OYLcR3dLgggizOnDw9Z9qxC5Vm1NIrwvkt0xV0r0uh+cYhMZWRUjWSGB/Y9S64p0kTGIgVZzLsrOlMa+nos770qgFLN4M8O2FDgRuis2ofTObvAnC8AIt5stdi/HLU+SCfw3qPzgg0Q1Z+kxc/okMsJhvgleRfFxAfN/j2ifthtfwaIH75ht6hGjL12zvnvAMSIyVhOvc/Z6K7rNwWvFXIx0SZuj1PacBaNoOtjfhsBZ4UNK9wCq9casDs/NBTN9C6RUOepfZgCxGvwbvKnq0BSSqIN0AUUXIDMFVhXUFT+ExECAKXSCehuHtz7hz13iOjAWttqcjNY9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48MkOw+7jLDOgrwFuexwqWnt2FDw0d5ovU3a18HGo6Q=;
 b=g+2PKqIRyyDSletr2nKse65MIC9X7LQTJvHNowGYHD95KB3UcVEvVE6pkYVuAxdtwjuQu/8YoDRnxOnrY+sP+rdwCX2G3LPjSKz20cXYHd7F7x0vcv1yYgrv0AFWZ8I5fgH62pvBFd0zzf6Hdrhy1hLc8o4SF5H3gda3ZPToooQyD9lDN/QTAhAF/pRtKdz7ojFmc5XVBppX21DcVhobgYCX8LBTkZiUOgssf4wR/AH3swZP9rJoWrqY66reHz/bH+eMBCK4gvcP45UjQ08P0+WbNWLYOq4erRtCbLrTXBM96HoWYppYM8JE3itvNWn4WH//Fn4NJEfiHfCHAYHv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48MkOw+7jLDOgrwFuexwqWnt2FDw0d5ovU3a18HGo6Q=;
 b=brCp16dkDPXvSkfqyj5tOtqc0zLhKnPNm9ygxaDQq8boPAWGW5rXQebKSLvfpF/m13ztNQaJq/ObE0ja8j3EB/XsTX1HDXLLERuyZIWyUi+UFmSshZ0PF5vdaCPDssRUX5wUqOEVDWq0g8X8Fr1rKTKU6YII5Z/OhfBoCxi51FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DB8PR08MB5386.eurprd08.prod.outlook.com (2603:10a6:10:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 12:13:00 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::512e:4ffe:2678:395f%4]) with mapi id 15.20.6933.029; Wed, 8 Nov 2023
 12:13:00 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 1/2] fs: fat: add macro to convert u8[2] to u16
Date: Wed,  8 Nov 2023 13:12:38 +0100
Message-Id: <20231108121239.26737-2-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
References: <20231108121239.26737-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::17) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DB8PR08MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 94598a5c-b9fd-4e82-2528-08dbe0540cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UV7yjyDkqH3GYDoHAa/lOt2Mu7d5uSmx3vYtx8klqKV1zyNBgkApGsp2ZOIEilePEQ8XWUR0V4tPTWQXuHvzmsLOPsL5IjHnzshXr4L60Pu6ReYxFnUYiK2uXUlzXDg5aOKEgypUOPAU/AjTr3ooSOo+If5xOB1w1lzGvj8mWO2qjUrIrD2ROAe7chq+B2D9g4fHG7CX3SyhSiM2CpFLo+dKiUcPTvACrrczNj1PyqqlmUJJ/Xe+jRoKHpQF+/YL4usk2egNMz9Wsrrm6O4kp/9SwkuJOhGjgJelGhjCWhrsd86InKYnUHAZ51gXIaHF061yyyKq/xzYaiPhuhmRdslImUoSOFDeHLNr0y/p8kzTDIpncep03pVDhiLsQaJa5hkLZHilZUxflOl0FDJjNd9pjz2t1ZW+E1b+Mvul+Whbc5XIRAtLuVLxRS39B5anUpt+sAzeOQk6FHgxHTid26FRw3x3AkxsOLX21EEBPD/CTE6Lh7ufHpTgSYsNaa6/+BC1CGZlf5ZU22fBeSxiYgicMWdhO15wsEfVKhN+ktQhU0Mtlg10FjvS5cJaqD+YCSi/ra6ppRCGGb2iz79dRHaX+Fq5/+hMx6d15LdX/LhyCCNugotiTdxarCOJ/Mm9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(1076003)(2616005)(6486002)(478600001)(6666004)(66556008)(66476007)(54906003)(6916009)(6506007)(52116002)(66946007)(316002)(6512007)(9686003)(8676002)(4326008)(8936002)(41300700001)(26005)(2906002)(5660300002)(36756003)(83380400001)(86362001)(38350700005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tP+cTf/0o+5YL1urCnQbAGV/VUtD0EQRFrDvW3PzXtVUq0WF8WyKyzd818Bo?=
 =?us-ascii?Q?xqueMdgzz8uDap6B8OML1CqEQ1EcIbt1Tnlqkfyqblr66Plp3gU9vsREo0u/?=
 =?us-ascii?Q?nQcXTW5AZ9eKztc4I4e2unkmHHa6qTmR5x1SmJFcIjLcjRexxFVwJqP/6xrg?=
 =?us-ascii?Q?wEPnpD8HgFJ11Iw0XtRyxBKSidNF71wxUqZ0XvCHEzRyJxU1IEhJCxD/3mzu?=
 =?us-ascii?Q?nZf1cJOQUz8JehRxwCB6SbovGi5VWirKOulNGktmEP9BnqQ2r8d/Pm3PBES1?=
 =?us-ascii?Q?FkUxFHAWLotAcej10D03GYvh1t0iH7zVsTRpNciGwrkWv6C7y2gJLViZmhXt?=
 =?us-ascii?Q?HMmmDszslicAlme3UMHuOoQhpUE4FleFohPq5Xcke8qLeOkPBLweFuYPkbty?=
 =?us-ascii?Q?Pvuzb461TtlUdT1oNPf8+Hsi9OLhGHc679mUXLGRDgwVIFzr4rkgfrMTfIkJ?=
 =?us-ascii?Q?m4Cjm/CkDaQMtlNuLecbwEiusrCOV5+nuTGL2oiDScmSrY+TTuPMbKGHIVMt?=
 =?us-ascii?Q?hK3steebML9DSDhznQMtC/F0fwf4Zv14CUpsNTHkcK9s0o7iPESW/hLxqJNV?=
 =?us-ascii?Q?O0obWb0M37esQKStSDautt9n0/xB3PRNSkA+tAjDlQZPk46EzZxt0MsS7I8Q?=
 =?us-ascii?Q?+8a9AOnShI7V+6Usuijljk3UIXhHVn4jPTc30jdWcxHo2YNcaj2sgvsvX+WD?=
 =?us-ascii?Q?putFzqfNHHNUntKrss7Mpc8p8gmdBVLtoyn3USvcj3SKfh4JvvYddYh5dHn0?=
 =?us-ascii?Q?eDr+zoM0rDiaHLa5fEtu+EAi7RLtBUPX7WK9vNVR/WGd6iDaAy0H0AvxAe/r?=
 =?us-ascii?Q?hkeMU+BqY8+xIV9+6Df7hq2f1cgg1sIPSWFjBavCCxUkouKZOdWnbfb7lSPO?=
 =?us-ascii?Q?c++tQWgoy2Kfon2g28H93K8d5z1n7l2zw9fdrLoNRS5gfPVVM1MtMaOJH0Ka?=
 =?us-ascii?Q?xbxyUulx/TXjMhddVmGLWm+6bUNB3pSAthmnr2beWEcHWVa0Zpg+u36v1CgW?=
 =?us-ascii?Q?8p0Y26+M+hH4rEQ64Jwz6TjVEPF+TYrbVBGlUsz5dZAMq3btqrSOXNq2uOuP?=
 =?us-ascii?Q?l/G6k4eyMGaqGjDemlhW5q3MVy8iF9uL97Syy+C7wA1sbHje/8GAIJXv49LB?=
 =?us-ascii?Q?TaXmm9cAoHxSPUStaqkEqeCULRO5poecGbvPfQtx35XjWhranxLo/J1ZUEIu?=
 =?us-ascii?Q?Z1k5f4pdQ2L6n9D3YqRnUCKskVHmiw3MSL2wpuUoIqHn3uh3C/LPaspocNIs?=
 =?us-ascii?Q?+D2zxEiYennFXJvTNCdnwY/pniVhfXqqm+tXv6rXt3fRZhdDMI+mSKuqj202?=
 =?us-ascii?Q?CZ+zNXl3vsE+3VqGfd2llkRbFaU+F5vwH3TnDUhp910OFmtjiIS8/+/wdyGY?=
 =?us-ascii?Q?/WOktXDMxSQslgyOeeo8U7fGRo+4Ysl8ZSv+8jw6fVEadzL2uFR3LssTcA5G?=
 =?us-ascii?Q?IVYOptgXT5OhSLK2joy0LCSR1BJkfDWQzBIWIrlADDQOygQOY2xSNgdB+QZt?=
 =?us-ascii?Q?8bpryvC0fSWKrS4vPy+XH8xvzp6Yw8lGW7L8VE03AlErSRcCcNQ+t6MYZiAT?=
 =?us-ascii?Q?1pxAEb5u3t5GuVK4iQdVqbRUELkhGPlBiJeGjy8LalqnlnqxxvbF+1ZFlrry?=
 =?us-ascii?Q?/b7WCiCZtPcqxJ3lkQYJcrSUoriHqAzdhry9xYLpiD6j?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94598a5c-b9fd-4e82-2528-08dbe0540cff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:13:00.3894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaqHxekBaOYde20OOi2dl+m007FW5VI1Zui9pctwM0I53uS31hvpb6galcF9wXAef0f9cdHXoSsa5VA7XinEKcV1wITul+AVFaWD93s8FpnIg42lf/49IOMpKzhim9DT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
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

 fs/fat/fat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 8ff1fd0ec8..8a0f4e4e6c 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -25,6 +25,8 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 
+#define FATU8ARRAY2CPU16(x) (((x)[1] << 8) + (x)[0])
+
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
  * 'len' may be larger than the length of 'str' if 'str' is NULL
@@ -571,7 +573,7 @@ static int get_fs_info(fsdata *mydata)
 		mydata->total_sect = bs.total_sect;
 	} else {
 		mydata->fatlength = bs.fat_length;
-		mydata->total_sect = (bs.sectors[1] << 8) + bs.sectors[0];
+		mydata->total_sect = FATU8ARRAY2CPU16(bs.sectors);
 		if (!mydata->total_sect)
 			mydata->total_sect = bs.total_sect;
 	}
@@ -583,7 +585,7 @@ static int get_fs_info(fsdata *mydata)
 
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
-	mydata->sect_size = (bs.sector_size[1] << 8) + bs.sector_size[0];
+	mydata->sect_size = FATU8ARRAY2CPU16(bs.sector_size);
 	mydata->clust_size = bs.cluster_size;
 	if (mydata->sect_size != cur_part_info.blksz) {
 		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
@@ -607,8 +609,7 @@ static int get_fs_info(fsdata *mydata)
 					(mydata->clust_size * 2);
 		mydata->root_cluster = bs.root_cluster;
 	} else {
-		mydata->rootdir_size = ((bs.dir_entries[1]  * (int)256 +
-					 bs.dir_entries[0]) *
+		mydata->rootdir_size = (FATU8ARRAY2CPU16(bs.dir_entries) *
 					 sizeof(dir_entry)) /
 					 mydata->sect_size;
 		mydata->data_begin = mydata->rootdir_sect +
-- 
2.34.1

