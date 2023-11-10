Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB6AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 09:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD4E877F8;
	Fri, 10 Nov 2023 10:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="D5sF2wlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA29877F7; Fri, 10 Nov 2023 10:42:31 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B570877BC
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUDkaUlQc7d+wuxV2v8q54WzLhGPYsBPMtQgU9QwT4EIPQPooAVH0WS8UztHmq+wj28YbfQBogIaega626lRpBh5iIx4bcjhjfCapr7RsvmybChvpwS6Vam9oFHOLK2rXsQM9Wm0skPtdjny5Ex9DV9QJeY9mnp52Z+bs4z8GmGPIh1MdkwJEqc4IM4dQfQQWh2VFzcb89mRqwZQLMKHeZ0IpydKJkF4SgVcufWRBvYlfrm06WaZg+9rmDUUPpbnuk6NC1RVybIw2ZqTXKKYMoYt76uamzPvsvIKv0istQCU3ClGGaFLpyAHM59uqJ1NvaEm0BTRcz2elzrya/fp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZUelzuAQazUc+ozeTNasjVpBj+xOGgdWyqzjcC4uXE=;
 b=b9khPIUQr5RDc4jDVGcYh1TzVllJH1j1ex6ylZMm1k2CNk/m7hXEUDs3orGO63+p0DMM8a0uizHt9LPVCirzW8Mz+dCYXapArvgxA9hynmKW5MPSLqZOkn1P4ZFi0GnU0UhkWsf8HB8gqmSl25cAxe7jxX0P51HAI6IwTh0AvGPxikVHeOXkT1keFPldkjFXX2f0KkfecbOxYpYz7zhcEfUKMpzA+NaxIMY5eak05Z/xQzzlKhNKy3ht9PwQBrDQfsAARiPQHQ1xuZGmXM33EeL2I7wGQXwcJyxccfe8K6aMhqS4VwcaeRSe3mse1kAIcNPwWwAYPBLCjmUgcjxYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZUelzuAQazUc+ozeTNasjVpBj+xOGgdWyqzjcC4uXE=;
 b=D5sF2wlCWqIVT2Woj9bzR92TlrXhnzc3RhrE99FGR24jhb7m36fHUOcoMWxH1JkqEumBCn1JHQIFcuAEoDxGgfpnKM2RB4KeHNoLyVQ1oWkSc4e2/ZmcVA2G8joHkLh3AjsyFB7FaykaOdwqTQmQPyrlcWqx1wlSsOjp1Ud/V4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com (2603:10a6:803:110::20)
 by AS8PR08MB7910.eurprd08.prod.outlook.com (2603:10a6:20b:50b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 09:42:28 +0000
Received: from VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0]) by VE1PR08MB4959.eurprd08.prod.outlook.com
 ([fe80::b592:2cb1:64f4:bcb0%6]) with mapi id 15.20.6933.029; Fri, 10 Nov 2023
 09:42:28 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/5] fs: fat: use get_unaligned_le16 to convert u8[2] to u16
Date: Fri, 10 Nov 2023 10:42:11 +0100
Message-Id: <20231110094216.50696-2-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
References: <20231110094216.50696-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4959:EE_|AS8PR08MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: da4b3c71-7f46-45af-2eb1-08dbe1d15a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syjF2GrnKml4VVGoREY4AER0txI+OKWJIQydY/AVL8lUJkg9hd5TiXq11cigdnl8+3IrN6mrzt977q/GVIeQd/GDwkNl81wAp82rxus6EiqP7ilqhLjofi5v+nU+6coRSLn+kGrIAaIkc9ZBtgJVJx4DKCvxp2/hEGPPV//d8snPt3QTN4XP+xX0Nn2k7IErYYeclZgrG7JgTw07ZDsWUyM4041YnqWa79+O01qVfKpmWlpnT5phFuZgyr1gkOtNWLY/CwF5QpcjsgnuRf6wUwdf3UMBtfSw7I/yRn+CViTwURv/avJCfUKVkcMxtF2FF0DitHfux/TRGVfyb3rGEyDNzXM7pxFI94yuVYFHoq2otfiSSu0hJok/MMrGiERHk/2CzJHW8unDMHn5CBPv4uhj6XTrj/Rb/ynYLwjz4/r1x7qBbZKtOm8ii3xpG8wrhCXEwTUgO2XF4mwWHIO3OLBgqYjfM026M8MZNfezp00cdg1DuIYuz7l/T46gFfQrXufgzbFEvU8LmXsDrv+kHHrImGliDewAO2mBRneTHgU1oqxSbbMAscN5ZrL7Yjn9EkG9E0EbeHk3lkRjSihDrv7JWwtAjsZuI+JogutbzqeHMfkSDbgqydCT7udZVkuY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB4959.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(26005)(2616005)(9686003)(1076003)(6486002)(478600001)(36756003)(54906003)(66556008)(66946007)(6916009)(316002)(66476007)(6506007)(38350700005)(6666004)(52116002)(8676002)(2906002)(38100700002)(4326008)(8936002)(83380400001)(41300700001)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAmB0A6730d2+fLiqRb4Q/xjSwnZdNWHm3GrjSJ9o+TgXwhI382AOpnx2d6q?=
 =?us-ascii?Q?OsRl6deQ81ocpYx1u0q4aR9dwCSWUtrVg1Riy3kvBqzyfb+ifQ6nhadKJLkz?=
 =?us-ascii?Q?WPSyoliyijg45JizEWb9OAQqEPJG29gDfJcl8OjLqLDHdc3QjNhURNrI5tYm?=
 =?us-ascii?Q?siVyqdtmC7riX3L+gx/zBWY2KFmKdT5CQa3fioIjF1IlDV8KL28j0fvYZ68g?=
 =?us-ascii?Q?KmfnRC71GancrrV9UY3ONejjEMFio7T99OT81AdG0LMGEB0UNPSddNJkkrIm?=
 =?us-ascii?Q?vZC6cGPjreX8EoTVE9NvkWSM+WyOd6BaSS9LIiI/OafQ4lgsQPISygrSt8yY?=
 =?us-ascii?Q?vd5kK4J1239DgPy+avn+sVS+G2MwZ6mPwD3QMBjGUxtBSK8WhZpfJ05YoKUp?=
 =?us-ascii?Q?MUfd9r9ULcnd1ouj6CHmg6igUdGKHmqR8NdrYkvhrbK7q0ScC1/k7IixC+a7?=
 =?us-ascii?Q?V1bh2+TpspTlDra2acfyL9KRqtMMdWS7tXnu0nTFG49PT1RFgyEt9o0a7lFz?=
 =?us-ascii?Q?tImgHdA44/aaIUg7QOFZknGpcsPzph5zkNMQ2Zmmj+XILp9p3LBJehdaviYm?=
 =?us-ascii?Q?DoHuKl7glPC/meGN35EXaOzJ4HibdSn8CWx32o/6neJxooM8rrTmj102lLxA?=
 =?us-ascii?Q?0AW6mvpynAaWuC+BLsMarOZTz/a9qb0drjSK3wxfTyKuI607juXODeFNp4Q+?=
 =?us-ascii?Q?HjGq8z/kPCwZbOKv8sRfpeJ1YnrUec6qV42Vh9sBOwt4zsX1E3Cp+21qh6qi?=
 =?us-ascii?Q?GBZq3e7foIcjA/fJjeaUz+4S1okn6tMOIStXfU2FfrIYldx/DrGXKr1X1okY?=
 =?us-ascii?Q?UMPeQAOq66JkRZX+Rh9Fe5mEELVCsTPW6JPPJiR+E1zlOlUgWp35nuKhgmXf?=
 =?us-ascii?Q?5E/kwy7ZYkvqr7qsryFWuZwvcJE66cTcfxsPI7Hr2j2vtIS8Tge9M4qSTXAT?=
 =?us-ascii?Q?DhOVFXxf4poPu51KolIdt40UJ91hhGJHd9HGYT/PJ2kCJK7ydLmpeH7xtyYv?=
 =?us-ascii?Q?TxyrYsyCxAhkrl6wI6iEdC7ne3CIlcvt8AfUwmpOvVeDZ9SyLSDB3zhpDSdX?=
 =?us-ascii?Q?sXcxXaLg7xVxK4ARQHnx4dEWfjPszL+T57HReuNR7gpFRkP1psp/stSvZXet?=
 =?us-ascii?Q?/58C+sJ+Gh8dlSEE8Ch0VATQn2UAUbn6YWnPfBkIfCy/jqRmtd1FeLgZwViS?=
 =?us-ascii?Q?hPV1PIY3/cua00vKV9XEYq/FDpT5U2Gx8ZIUy1RC2yJl8Opy1gR3eu9VOh6R?=
 =?us-ascii?Q?yJL7bW4bgUe4VvXFx2NPxoz3g4l9XgoW1vPBmUpDoPJ46Uh5wAwF7iQeFP1H?=
 =?us-ascii?Q?BkOA8nHBmq52NtDr5AWb0yMu5eN/Va9kF/cwuQpxnZLak3keVxM7E3uf5xav?=
 =?us-ascii?Q?WKTrkkCPNOtmCuUS57X62jW5v6vT9VmD9W6AdK2nl0Q6ynS41E/jaLHllEul?=
 =?us-ascii?Q?PV2W0YS8EQatZK9nKvgHBo5yEF5Y689JelbB04lmwzXLpsjk1Cea5Yv499iA?=
 =?us-ascii?Q?AcvxKt44I7b0YSx0DBWTFbxcDqUHnbbeL8B82+0mIRT1AFFnfe2Lx+Pbizzh?=
 =?us-ascii?Q?RAau2TC60f0vSEOb5VJsPzSo80l2mPBAPVuiTnOAuwrG3fSBihub+PAj3/9n?=
 =?us-ascii?Q?VjwnBoH+LyJikDCvlFlo+5J8h8E4cA5ggDo9vM4TXoIQ?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4b3c71-7f46-45af-2eb1-08dbe1d15a80
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4959.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:42:28.7417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgFv/00UgNZJ+QrZxeaspP5FZx5wXrpzctXHCCPi9cTVpaqDrOUeECZjuxgFqX4bxBfbTpCTkqaELTLvV0UQ5POkbTaVTmtHmK7XPm0UPeiYJxiwEkcH1z2hVCTinDF6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7910
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

