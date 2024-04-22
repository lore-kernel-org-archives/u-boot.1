Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9DAC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 17:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C23888EF;
	Mon, 22 Apr 2024 19:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 235B7888DD; Mon, 22 Apr 2024 19:23:57 +0200 (CEST)
Received: from PNYPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c408::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F356A888CD
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 19:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=siliconsignals.io
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=kishan.dudhatra@siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZL534Lxwf6qI2Um4sLrMe3Bp9WbECfTAlnA2Dlce9uoRq0yHdpRpneiYbYqN9MjdJE0nV2x+U7r+QfuPNLlC4+beLxArvRsnxsD3z8oic/OL6yC/DrDs2crpOawf2sC+ZIa1+0/WrdmPzdRpuUTdlmsqxpPTmd4NCa7q6UPGML4gdA6fHjIPyeixPjlrM0qmehcUA+aN0KhoAfQExx9pz59CJb7z1hpM0viSnJPMld7rwwxPO2Eitr4B7wHKShecfrdXQ+2x3JigKQSwDDPLab/mLslxh6m0GZhAe9avr2FxoiSD5yIdssRbWLnBIm41lRWgbKoqP8y6dusuZvnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y+L/Io5DuINHVByWaIFOy9NIq+iJ8TgWOspFLfWBoE=;
 b=KliNjDMhwUFqkHPJMWNaOQS/NM+GUCnzOk1ZlpNdyI8yirLGiHv4D3QqQaBmlme27QYcrXiKOukuIUd/pN+M7q6iMDdpsLFY5vM39thyUp8kJqetIvUBtyJjI9pCpGh6w9WTUUXGTedWotCyQvZMumup1aS4C0S131YU8HjdDL/AAjC1uhZe2CDcSHULb1SW9tU1Mdw7l09ZE/kILXDWB7YpEk9eJBPCXvQueEV06xveOmD6Ksv0pF7z1RVaRh5W51TRu5v69HEA0YypjnjqQl23V6wBuj0iG5EomcpEKBhOC/+kCm0ii74aEdDcSOYKuD5azKUUZWCF6NnzYY9/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::10)
 by PN0PR01MB6405.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 17:23:52 +0000
Received: from MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469]) by MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::da4e:be76:93b8:e469%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 17:23:52 +0000
From: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
Subject: [PATCH] cmd: gpt: initialize partition table
Date: Mon, 22 Apr 2024 22:53:35 +0530
Message-Id: <20240422172335.166727-1-kishan.dudhatra@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::13) To MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB7912:EE_|PN0PR01MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1859c574-fab3-4a31-333c-08dc62f0fb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7+15dEArjK6+yIEcC4OPwQOchi8XuF3Cwjh34vBgCkuiw0p3Uiwf50I9gByB?=
 =?us-ascii?Q?s5FR/5rbeECwqQxNm1GZKEmfX+odW3YL/IwYxFeEAtsdheh8zE3FgqhlMUQm?=
 =?us-ascii?Q?9UrW+3PbjUvq9kkL/L0VDmj2QDwPQB03hkeZF50jcyuk2h3aAqQA7r9c08qN?=
 =?us-ascii?Q?q0CK7tyUYorovNl3p4ViD6TEs3G9XzutC//QUzX3Lki8AIJc4VTyT8fAs4or?=
 =?us-ascii?Q?oTHgHXke39GOGTBtGnkOeKFWqlakwPuX7q4aPjG/DW08Ks1wL5xDuGysOHnW?=
 =?us-ascii?Q?zPUXXX1pE3pjSNAEhXUOa3XjH53d72lYq/26JocNzJPmyx/legBRZedIeHNU?=
 =?us-ascii?Q?C0KI588YfEJoWozqFQNvz2JYGeS+/3NcOT1DpUH5eU/PL/cWpJgj7b+1Cgl2?=
 =?us-ascii?Q?1kHR9aXn3MM1lcnzUDZ+dDLhKbTtsszq194nNXb2hc97NU0FsHzYOpVHI9CO?=
 =?us-ascii?Q?r3egVFeg2umiZHHk0YJIaUYdB8UYWgLMD05tBfjdFhiaU77sOA7vimyjnnuz?=
 =?us-ascii?Q?w3NOMk/7O5Tnlvlq++o6Ga+VfYvMtb3nDIQRHGB7S6QKOv7QC6Y+WPKUy7DH?=
 =?us-ascii?Q?C9hXE3ESBYTN259qB3uwMzY3KrJ0x33i1S2CRpViGEapZZg7vgU6P+JoMWgp?=
 =?us-ascii?Q?+mGpK5XC88JXVUcIKxeJTOdWgNDL/uLubN7fGh5d35GKMXxPjsuZZ9wflqLH?=
 =?us-ascii?Q?yWwOwrnjhnJzD7MBOc0SqWvKY9BeuLpnuLxETqaqMVvSNkHdoqbcKl056Dho?=
 =?us-ascii?Q?ETwXakIjUuCOWIamgL1j5vUVt0Vlg1owcSxs/w5ZlV287adt4B7TzZ5Dc0AC?=
 =?us-ascii?Q?otV3/2oCOsx6Ysfe9X8lCDzHySXTt0+IHCr/Q1k6ls2QojlMr2w7ovIiprku?=
 =?us-ascii?Q?GJh1UI2i/kttdf8+MJmJgu8WjX1BRYoG2pCpy0kWczKVtH59icXtoKiAf3tU?=
 =?us-ascii?Q?ZVesrcRfGIt7N5Et2bRSbZUTuoQ3IoetSGKfohRoCvKr4Qu1E2SXKmtlcmda?=
 =?us-ascii?Q?3kjViflbd52+sntB08t+QFkL6N+XTRFLNeeHL+t5bBR9GM+9GSPZ6D9SVonT?=
 =?us-ascii?Q?Kx5mKiH7BzmrEaftz+Z6Qjj2q5JLxfuoLpx22on0EXr4iUbRlleoGPvO0wsZ?=
 =?us-ascii?Q?tikSFPT2C36eQAgAP9BvLZKsjD+U7V8D2AG29N6djKkLabCOszd63hKLLFVm?=
 =?us-ascii?Q?HlJIbichqX+6likQYNk7eWNNUvbdp4moLe78I9NGjcSIVGfjLikAGZYFefj0?=
 =?us-ascii?Q?fKTxITCw0t0HVcDAPjqr5mceV04Z1nJskTQCEZjVLRMD/b6zT28vCxigr5OO?=
 =?us-ascii?Q?DQphI4yp8ZvvKPcHzeZRYVc4Q/YJZlh3qWpgx3krxysOBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wPXf3aKynwMEYUTt722qbj7K3zjMvBMm5gx1VmZXZK9GpTVa+c2qoQOdzsN?=
 =?us-ascii?Q?N93pozdB/3sPxH9MvAIYMbl5dfCm2rSQ/WfxJ+jRhd5D3Zv8D8upPuKRy4xP?=
 =?us-ascii?Q?PH0FzJNj8olm/nUdWjYe5dvdxV8bWwFg5/JcFWfHZSRdhQoXZB6IWVJisaN/?=
 =?us-ascii?Q?2d5q20AdpfVENQFwh6PW7NtO5Bn3KRGilbp8nNp8YaVjkokIpoIkeMkBGIs0?=
 =?us-ascii?Q?OXXEXjSIWXWdfMfyqJdmAHdHMe5gcTMjBjAJq7tyOiyIhy434hhfSuYDL9bv?=
 =?us-ascii?Q?DAw3/NHsMIBL2v+q/DNjiqXJkYZkQB0eUrBrYZovPhz2FbRQlFFA/zPl1nPp?=
 =?us-ascii?Q?HEM+p2i1od/c5NyzoC/B++a0tOtUEZc3EbeCjW6ZcfnnoJycaGEYzWti+xMD?=
 =?us-ascii?Q?dpyaq1MMwmNmG62aXAMx/Fjna5FoH2lR4WXKQWj3oXl4eoaIxK079PMRTw9D?=
 =?us-ascii?Q?NXIpKWyH/sobbs1vCfDlT4n7xuNP2mS7/Ai+i2+SlUi/kiuz7/e4oZ7pRuAL?=
 =?us-ascii?Q?XkdMcdDDNGyb4+POgdifvhN+0CcdIOtdNbr6CCJKDLbbVqx7bR0aQxRFDfGg?=
 =?us-ascii?Q?chXlyFXIMu5c0sVCHjLOLJ4pwFE/b8Jzsw0pCXTQZkwnL54p7y+ZQIjUPfSA?=
 =?us-ascii?Q?UJDEZnu1B7+CYydVXbEYenX+iwSbjcm83sxY54bYKEcNlAuZGvvgczWhO4Dv?=
 =?us-ascii?Q?G6iFkiENY17zNd/oCkW0OsS0WdRhM3HgO7xXVR/UKEk9LMbZe1PGc24hIF0H?=
 =?us-ascii?Q?CWLxkSs0mQ7D1rJkVKHId+17tKk7uUuHOe7D4ADlkWWOmTHe7fQ7+4th11Wx?=
 =?us-ascii?Q?R7plVKUdJT57kEBpCAuqe50/vgo4yfS/jCtl1+P8dS8QM5rAQNlQmcJZ3vdL?=
 =?us-ascii?Q?VqDYNbL6vYXDksqqRuFFue8SUfltfIQ5+m0UNpwK3QjvWuDTQ8/OkTkFKFOP?=
 =?us-ascii?Q?bpJeDViM2DxGwCVvHH3qh1BJDbDbWl0JHrNVG0o2nrtivy4Lo0YE8aBrm8L3?=
 =?us-ascii?Q?cvNX7NF1i6PnGBSDkVslxn6SN0mnlTYFs7xH0qdhksi/H0VCzkT8LsyzMJ6o?=
 =?us-ascii?Q?uO+XllFQRch0Nf07Ep3dAiSk9JKPb/qo92SdRiR6l3zoPCovd1Xf+Y+GmP0L?=
 =?us-ascii?Q?xfoJiSu0JsuNDO4GB0Yi1LBiregci+Y0T4IeJ2WQ0zvbNwYYxtNBRbB4EOxq?=
 =?us-ascii?Q?DS1M9gKvl4o0Gb3cx5EBrJQr+T7CbV84RidtzH/likzSvBuAq28Ws3/jeOU/?=
 =?us-ascii?Q?1yA56UoNsylaPpOZ+Pj684SSS2c22VcFTS4vOhMnOgIEN3cYiDopo/xO1mwH?=
 =?us-ascii?Q?fEiLEH0v2l8h1neDhCW+4nUHGIXIFWr+Tce2h5vwjHJsyXKxMsyYYaXAkvC1?=
 =?us-ascii?Q?66GVYiZVPwli930R2HbutPImCWqg/BKUXQVVKGI3bPkBKV5BOu//fsXLvIyH?=
 =?us-ascii?Q?w7zn9bpU7F2139DO8VWgmWMTEW2FlABuadQdAtMmIuZvOfehKe7CxrL0T0Hs?=
 =?us-ascii?Q?u9bTuoQCBHMbJGEEE0wRDqYPv7DrG5d9xWG8PlZEXzT7gCEnu9H0sT4aZdMB?=
 =?us-ascii?Q?Ht2HANBJp+9f9FNTjIus+lQpszC0elMij7CjDAy7AcXjWi2yjUIf/JlUSKEC?=
 =?us-ascii?Q?wnEa1V564igIfLKsgOnYIZg=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1859c574-fab3-4a31-333c-08dc62f0fb1e
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB7912.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 17:23:52.5985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blwOxTS2dl/xAwzkJShO1/y3BEISaujTIi0nr0yExcMzzSCJadRknL8MhG8cSGPBQPYlRhLgdiAiw0zvBC8DX4ps3LJHST3Y1Y+hJ8Mm8rsJlT4Pf2ibAG5fAMsfIZVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6405
X-Mailman-Approved-At: Mon, 22 Apr 2024 19:37:07 +0200
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

If partition init is not completed within the gpt write,
the gpt partition list will not be updated.

Signed-off-by: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>

diff --git a/cmd/gpt.c b/cmd/gpt.c
index d7e96529a6..2d652f480a 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -643,6 +643,10 @@ static int gpt_default(struct blk_desc *blk_dev_desc, const char *str_part)
 	free(str_disk_guid);
 	free(partitions);
 
+	/* initialize partition table */
+	if ((blk_dev_desc)->uclass_id == UCLASS_MMC)
+		part_init(blk_dev_desc);
+
 	return ret;
 }
 
-- 
2.34.1

