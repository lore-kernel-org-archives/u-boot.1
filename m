Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37DCCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 17:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA22836F0;
	Thu, 30 Oct 2025 18:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=live.com header.i=@live.com header.b="V/+YJTn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8BDC836D3; Thu, 30 Oct 2025 18:03:29 +0100 (CET)
Received: from YT5PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazolkn190110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d103::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E6683642
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prasad.kale@live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrQh58d257O4EMpW1xzzmhvuQuraFDi9JZOS4UCutaCT5/fe9lxiuICDaR8cRKPFzaZGl0cmbFTXTEckrEdG2JazxQaBKXTYx60BOwg/iXV21jve45Q2U51Glac2l6pJimCy8HKxzAs28MI4o2cms5W3F1O4lgffaMhsHSHxHK3a1zmgStVj6ZNRXRiavk2BrmyNn1PzDCHXNektdUtCgADHqnlqgzwsw4Cpp8+/XARCA6OdrIl1wVW/V2Dlx8tLsMpYhYo9IWHc81W7NirliLvrxgW4GkySDH8Gn2eIDzZxJjAY8Je7VZet06TRBRTEXOijC80Pq4CoyveDNNDU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgoO6VDhYLFIfM9nTh4lqeM6XGZiYnbfr6zVLs9NwYg=;
 b=DbDcttMA2w/tbcU0vL2ROnaonTyUwRaA/XnczSdYYJ0/mK/EBnlxCgMSNXvKFC6/DQgN3PquELQbEKFvGv7xfQrPAleC3qSlx+bzjYXEta9K23L0nZaNab7NR7/3maamnbtVurRNsWfa0WDT07fdiZOkwhkuJ8BINYbs0L/3I+3jLjINJLdFtMlPeMj7uRf7HYpKfs+ZK2N/G2zFF+fatioVLnZ/6LVT2Ukuf1dbW26Rk22tEYn3CDdHt6yD1zAShVqkmq91bV9Q8ZptLvAI4lHnWds7wNTE/bR13h+PKZNUadZu72Sd289F/ctQofQHMUg4f0RYK0e0Q/nEqRMOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgoO6VDhYLFIfM9nTh4lqeM6XGZiYnbfr6zVLs9NwYg=;
 b=V/+YJTn0+87Q6DONrXQ7QkM/F6jGK2+E2OwcvAnjsxqEOHpUxt2xzds6F71p9oSxqYCkrzvr79BqdSQ2RcCB8u0bENqroM5yk4LubjxIszOArj4/4r0LJp7w0Ws0d0Yg+tygXB52V3tFSpF661rroq+K5F37/5FnkjylskToiG1Lcslrb1lq1UqL/feze7NkYAxbVGtqbO378qoxmeXIHWperqPLu1msl1Omtg1KdHBV6ZPpRnhbxgCRv62b/OCo4/CR1DdaAxWBtuzv2jG6KVLB02gej9CizTD9qKeH5Z4bv7kcmvoMAohRUfTID683HGyZrzFCmj9yHqZxWQr/Og==
Received: from YT2P288MB0091.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:f3::22)
 by YT6P288MB0754.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:03:20 +0000
Received: from YT2P288MB0091.CANP288.PROD.OUTLOOK.COM
 ([fe80::c0e8:3f2f:548a:a775]) by YT2P288MB0091.CANP288.PROD.OUTLOOK.COM
 ([fe80::c0e8:3f2f:548a:a775%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:03:19 +0000
From: Prasad Kale <prasad.kale@live.com>
To: u-boot@lists.denx.de
Cc: Prasad Kale <prasad.kale@live.com>, Dan Murphy <dmurphy@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Invalidate cached FAT device upon boot error
Date: Thu, 30 Oct 2025 22:33:01 +0530
Message-ID: <YT2P288MB00915176E3C7F2F72F4C2A879BFBA@YT2P288MB0091.CANP288.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::31) To YT2P288MB0091.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:f3::22)
X-Microsoft-Original-Message-ID: <20251030170306.154506-1-prasad.kale@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2P288MB0091:EE_|YT6P288MB0754:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e443a37-d2b1-42e2-e4c8-08de17d639db
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqmuA8ZRYPGvc/RfahimXgDOjVx4tUlMggdZFcZYY/ZacmLI0m+gPlqmnfv5NJRp7+8no3Z+LymjVvYJ8ZF7vI7ZKFIV/yeJA4dgAzfkOU+3hKJMMaaq5mzZZml27dCeDyTqImE60ctad8mvUwvpnDdZBV91SRLUuroc7DYd//yHip8RX2kFLGzEfVwuMjBsdVAkB33PZpaXIvmth9vRNngBv4lhoZlI0qcHFZhLdjUG8g+tzPpCFs2MGZOUgkIkJn3fCimQZxKffrlNHKEEMi1s+OYKZuJXWL+LNQQD4cDyr2RDyCjo91dPWZzwdgUDVkPkWZPscX5pt61aD7stwW/811i7/TXf09e1BLolwxMDo1wEQWsgSfOMA7cMrko8qHECY0Ph+FZ01/imp89P6L4se0iXd13hmzvhAXBtBZEYsr2+rrmwhl0hOUNmQkIH83L7QXTLG12XMTLi8wn5NI6Pl6G6cKQ6VXyMDoHOD5vnlFGrVfaKAC+CwkWQdML2vpUAgkRwsXZrkunPMW1fImLr50L26YvOD7NdCGH2Z6xjT9w96eQQwDyV9bpt8KPpn2edv6t41USex0u5lNg3g4XizxFZ4qsckyqq5m+bEwNMjk25NUReZ1nPCRgIlgGlT1R0zR2EYmS9bqS1xo2pwB/zt43qpxlNlx6uK7oPDJ4EXiCQp3tikjzNcvLVNScXgb4GJ/SQqGUYY=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|8060799015|23021999003|19110799012|15080799012|5062599005|461199028|5072599009|40105399003|52005399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xxqpzRG2Nnoq1BkQ9MxcibHLozq9d8K7AbUtrNS9uY99HwDM8+V6qyarWb/z?=
 =?us-ascii?Q?aJm/2AAh2NF1qcJltFDJ65z4c9eSiZvZKu+BihemxDsfgmmr7W9B6aTED2jj?=
 =?us-ascii?Q?Ta2OJ0hO6acU/DNaqwREUw/DZABdmW24gwchdt77fDY3pUMoWKZboLtcxlZh?=
 =?us-ascii?Q?RNTZHuKJsJ7+rq1lPRMtFC3SMlnHBzOQSap/G49HVFFFEOBstVdEO02NIAAR?=
 =?us-ascii?Q?3TiIQrsKz2uJO9EUcrc9tK+qFz1FIQuJyRsJ3rH9QRHFbxuX503u9B333M6s?=
 =?us-ascii?Q?gT0c91JlBSdCQ0wsiODIrijRmOWoNZGPG99jV/AwmkXfzlxcx/fdhxHjvmsl?=
 =?us-ascii?Q?7xadmGb3CdZ20zheP5i8vRAG+91Zcr3MtyVGYjTqVi+xrO8QkLyqS6ATrmF0?=
 =?us-ascii?Q?zZJneZt1N0BhjKAe5tv4KA0uvEq5il0bhfP2ZrsaVTsIFIhuMzelBJ3AhDFg?=
 =?us-ascii?Q?ZQuFPcT8BtGRmeiqjEYX8RZguRsyP4iw0Au8ltd55YV2LM2Q02uUtLJRbck1?=
 =?us-ascii?Q?CWOJvxZvLLyU0IVurdxGRoeOW7sMqSrPhj8ODFCa0DZgPfX5E+vyYVE5JcQp?=
 =?us-ascii?Q?dTnbeLw0qKiGG3CKf8pSwruzidL8/OOHksmCIkULG6/IUyNgPpDbAB5rhrxI?=
 =?us-ascii?Q?3TYE1C4WGiPYUsQrzOfZy2y0SO/vg8lTQiOUoEW3cgbrXju+tB07vvDhAnoT?=
 =?us-ascii?Q?NRvnGUxu8Nr4w2vsKrMVspOYmhlUZc9RMkyoyx5ENkiCIGhgBIv7mlb04o7v?=
 =?us-ascii?Q?DCC3/6qgVE7VZF4CFROahgS13bJeuFnTVIa3wak7K7fMRc35oQJunmo6XP4n?=
 =?us-ascii?Q?meN63ZK4SlH6b6SoAgXDzndqx9yhhf1olmTJCpniQTfKyWAtj29r/2XCeXPB?=
 =?us-ascii?Q?Ioiey7pWKoohjfe2HIMwuGNiCx7pqB2x/ryVngtHhbzgAy1QBfkNFlCZfpN4?=
 =?us-ascii?Q?HKeWzetU537IVAZfm4unFCj9+ZwJGEBjzmyu2zTGLjaUH8AlMoS7tUa0KoeB?=
 =?us-ascii?Q?iRpI7UMDkDYi4dL0IXm6LHqcf2K4xNiq/Zi8scGJGzfP46kellz1wWb4amUz?=
 =?us-ascii?Q?HhO4LkESiDE5aD10UNnfaXRvcOA4cMWxvRSnKmPxh2PWDyPDyG7VYAcBLyd1?=
 =?us-ascii?Q?nDxlZcyB/q3MG/GT4zG7Lriy9+3DoxvSPcu+rnCqhgf+WVnojGU3EkJgXLL3?=
 =?us-ascii?Q?f3yUwVVe+oFAPEcUYfo2dGaZdc8FCWkragglv270sNh2+zejQgCX+l76u7VC?=
 =?us-ascii?Q?CrIidwMb6ZzUJO57gFUslhC7FiBWP04lUBEdIVrXQg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0LgskjnqjMaZvRiLT1uv+4gRjUOGPQB1tGNF4QsZXH6aMOox1H/MKPhKcQf5?=
 =?us-ascii?Q?/YOL2qmRzTSxPuKhcStknOpPLQXZTJm2vGcg3Q2g6e9T5i6HOpzy2fxMUw+D?=
 =?us-ascii?Q?4nUbDEykfXRTUIsOW1IaGyLwrqLIkzY2QK/mODAZHLvDWO6mv5H6GMQycjzl?=
 =?us-ascii?Q?/L6XzzWnjrnmf8zSs0+9ftWQ0ivIwKa2syU4iX7yZ8w2qLr81PCB8haIFC4e?=
 =?us-ascii?Q?tY/lLhEDLE3Ac9xh+yBbY5EPWTsHQA4E++Kz0KiNtsX86naVsKrQAu+Z3KCV?=
 =?us-ascii?Q?AtKQDtj7OBUtsfXHNfFZ5sP9MNEyfD64qWqVpBdo3AE7iR0pslAK93j0yU9p?=
 =?us-ascii?Q?gTb2YvlAYlBskD+WxbLhrJcXJgJUFM536NOiFdFo7d79+TK7Q2r5KVNdcbuu?=
 =?us-ascii?Q?hv+JYq0kKxsdD9UV6CCCsX4JOht2eOWx1kRjFCu6aT/3lJLZlKXlxRnK91Kh?=
 =?us-ascii?Q?RTkHTmDMKdqCb7hd7NRwa5k34oF/13DJtY5iiURnDmE4ZypmGen0a18gASUf?=
 =?us-ascii?Q?WppDS+LAg6yFjP5jhueWD4Ge8mtn8w98R+Aqj2ZpjztpHNftwP6Tu8oitjVw?=
 =?us-ascii?Q?HOhv2NTdM/79eTzHx8L75dnzpHRdSCgYqN5CgSgjaDpQw4NlPiYfJySBjHpE?=
 =?us-ascii?Q?z3CnIpAN+e04ZSb2pgz7vXs/vOKmlU9H6lthYhRoE3SD1gepma6Hu0uIctYZ?=
 =?us-ascii?Q?k33BZVFMfeWjo/fWUwYU5ONmQAU5UEjYq60WYJWLIXy0E1cTNm7rprBnSf+i?=
 =?us-ascii?Q?Yzlx8Hs17L2Ubnk5cg/Fo3Afdur7eziSKOGIa/erH1TmZ9XA4uP78mnEpvxs?=
 =?us-ascii?Q?gSvq6VQ/9uj3NUWyCG9Jy1Q8FevxODSO3U2SqPEJ7dZE7RV40gNsRDWZ3Ddk?=
 =?us-ascii?Q?qBG+qgT9gi3SpsTraBshbTJqgG5UPMGSgOg6KBaj5TJ37f0uB5o7kWxlcZlf?=
 =?us-ascii?Q?TXCXmbDPZ4MTV5ix1162qLrJdreq4h5OnXNXXuoSyNnXNig7ELifIF9/1NdH?=
 =?us-ascii?Q?xEd42RCeMjfNF56Ca4WkM6KUxl5eD6qiGxBR+8qLnh7kIUtdBrqiW999KnCA?=
 =?us-ascii?Q?I9iCjqsC1/X+OVzFhKz0WgJfgBjy+pK2wpLU1MSCpIFJfkf3nyW0OdacrQ27?=
 =?us-ascii?Q?OeSN3P3lSXRIKlRNfxphdJzEgmXHq3XMdAOzUbvnHMf1m47ACUvSdMzxaxUc?=
 =?us-ascii?Q?auQleijjwT4kA6FIfpS5Lk66UAz9GGrdfELlZAsY0MZKQR91VtVvV/Wn5gjK?=
 =?us-ascii?Q?lEimsZw/h2/dffbZJja42IEU1GNrj4rP2eLN0m0/FXmLXjZYg+hzb0swezWX?=
 =?us-ascii?Q?rF0=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-a8de4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e443a37-d2b1-42e2-e4c8-08de17d639db
X-MS-Exchange-CrossTenant-AuthSource: YT2P288MB0091.CANP288.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:03:19.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6P288MB0754
X-Mailman-Approved-At: Thu, 30 Oct 2025 18:36:24 +0100
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

When spl boot device list has multiple FAT devices, any previousely
registered FAT device should be deregistered before registering
next FAT boot device, otherwise the function may not attempt boot
from next FAT device.One of the situations where this issue can be
observed is when the boot device list has two FAT partitions of a
memory device and if booting fails on first partition (because of
file or partition related errors), boot from next partition actually
gets attempted on previous boot device only, as the previous device
has remained marked as registered. Call the function that invalidates
cached boot device in case of failure in booting from current FAT
boot device.

Signed-off-by: Prasad Kale <prasad.kale@live.com>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_fat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index e9ee5487d6e..8b1d01cff4b 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -96,9 +96,11 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 	err = spl_load(spl_image, bootdev, &load, size, 0);
 
 end:
-	if (err < 0)
+	if (err < 0) {
+		spl_fat_force_reregister();
 		printf("%s: error reading image %s, err - %d\n",
 		       __func__, filename, err);
+	}
 
 	return err;
 }
-- 
2.43.0

base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
branch: master
