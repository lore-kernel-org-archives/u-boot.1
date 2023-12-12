Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E7DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 08:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778F3877E0;
	Tue, 12 Dec 2023 09:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="B2oI/GjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FA4877CC; Tue, 12 Dec 2023 09:53:13 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB452877D3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRGcFgohNrNK5bhhhd4u+nuSAN2xVWiJ2scwpKEy7nJjhSgjhy7L4AVHXe9tZdP9uBGYzDst1R9Oh5XueRHC6dc4fZEvfhYGFziNYysybhQLBH+D2P6cDdjwIN0wiC9yNt5o09UcG2+gJ7Y5W87B/j3x6KnJ4Ymgj5Pi/YzMn1+09g1qn9ByXQGIKqwOv4+OjSKC6l/ueOg7mINy8rBuj2i/WLqgadYHQKxA1L5Z57l1Tf24NzzTIg+MU7peP4ufz1GchaROhI0Vt8Wqz6nn42zR7bO7gutlSkYKFjmBQ9+3uDwk9M38+v7uHTUVn8eFtfK+0jshTIToohDaMSq+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTo6TKh5LKdQRcsHSrXO5ZdkVkjRi0Yd/H+mywJoONY=;
 b=m83uNWfG/zH2i2RxyAwZlaeJkWbNUNThoPWxlNmdWpOci/nO/k0N00Hxr+e7vYo7zRPbUEaFu/zboe5pq97HXGK5fAzMCcsRc/KZ5JCuvHKFLeZXuKnNsIO9f6VVYBxwxB+BExAUxvCuvv/mltf1XBL86RjnZ4x68nB9qndebTUnc9Z/Kcq3MhtAAjUo/TLz/Sgtfo9kqz/RgueM+So+iWITugt2thoBYxPOhRWbRgNl1J0e06iDvD7ijaaoiX5zjXNaC++8oIWXrwHApfDpgc7AoXm3eq4WfTH9vOd3i/7N3ZW45o+80tLqaYGRi1Lmr4vZwfhuacXUH6V9N5qIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTo6TKh5LKdQRcsHSrXO5ZdkVkjRi0Yd/H+mywJoONY=;
 b=B2oI/GjW8gWLGSp/a7usIv8iwISEXP1aFgdwpRBMM5auA6W9yfoY4t2NlB6smnGrEILDJYYq7JAZhypFN4nJsv9NYaDRnRZHUDmBbxbGXt7iL5XBlrGBtyCUJsUOlje5NNLUHmBf7XG4wRZ1QHBTtHNQ70Mw8GAS1PegOuOlZx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5940.eurprd08.prod.outlook.com (2603:10a6:20b:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:10 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 08:53:09 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v2 4/6] doc: printf() codes: Add bitmap format specifier
Date: Tue, 12 Dec 2023 09:52:34 +0100
Message-Id: <20231212085236.2730768-5-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 960ecda1-4636-4ec0-06f1-08dbfaefc427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uj/ZjBTstLfvy3HYz5jDi1gMNUqf2Ck12ksGVD3NXVc4qJAOYdiRu85dYbzQGEOjlyfn72b0zjAdXvnznn15u5d0+Be7mb5Ug+a+D8o9Lxjjdbcl488iR6YCKlICUchivwaM3a7ZbDm04xIKl+oSntvEKsbQ1LJty4X2nCE/MNA1GnqU7t7CoFMLPZrRjrPkM1OaFbgTN/riPV9yYePV3ayuhebJ4uRMGSh8NFHcxwA1R7q100LGiJqRoh8mIUY4Cp9KHfuJU+xbH1l33O2IBnBwom2R5xBTj/CcMZh/vqBzvAJtX6lGsQlgIuaUfWgU/cBQaeTtsUkunOhQPIU6yZBRNZP3IQrIthzidadBk5UjjAW/Y2tnjoZfq7icAuhiXZI/cH90TgbR6jjHMCyX51m6oU69NKh/jZ6IHNnrxsp1ORhZB1g4WBiOwsTRPRyTqWQWnJoJo5EDTen2MhtM+SX0F0cDNz3m66UA9jZr1nuwt1ak39CN49KGLoFw89cstEGU6/xSV0gU0JtOmuKe/QjI22QCMXSepypxuGXsakssb9eMouYqv0nyZ/pwErBCadWT+5xZcOVCZWZcmZvyLcriP1fe9ApNDu8jAtyhwhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(52116002)(6506007)(6512007)(2616005)(1076003)(9686003)(5660300002)(4326008)(8676002)(41300700001)(6486002)(2906002)(6666004)(8936002)(4744005)(316002)(966005)(478600001)(6916009)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001)(54906003)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n3u0jlCCyH9bTCXpP0jabnfJoEEIfU74HjyGotYIDDa15GSRKF/AhAgqP6C4?=
 =?us-ascii?Q?2dAO22q2CF3udwWBlABHn2NOhydSdlPMWUgvz9YjRk3hkipyDO1rRO4CLuB1?=
 =?us-ascii?Q?cE8n7D+j4mAQgkKdYSLHdsDIYwVOfL2AWOlIvOe+YO/U6o4PETNbP2MkLiET?=
 =?us-ascii?Q?MHJA0m9zFHickXQQxQt4aDRdX0/Yo1hptJ/SfFRoMJIQxjx2FjiNdVmXZ3S4?=
 =?us-ascii?Q?Rm/hQllMOdP88Ix1uGIXqm9vSdJaQo7zvYLA2ejzlT7SJMRgPSzgpU+hmYcO?=
 =?us-ascii?Q?FOEXopMjP64dibNiMLFWuvO9sJCQYpteEXUC3LVZEHneJqid0ywPMQifL3sx?=
 =?us-ascii?Q?hFtbwON+5q+0Gk/qMij/G21nNElx5b4WL4XVo5pni/5oeDGTEJXhvcVoVDrQ?=
 =?us-ascii?Q?HJuoIMkqM+PjA/99i9k8bDV9CsS0ej0tq3o49JQysPY3em4jdIMVXA9iG6ky?=
 =?us-ascii?Q?8zfMclRR37NPN80k/2MeZCT5WUpFzuigRzzpr93CatYrBLY9SA+4Mjw/vjHw?=
 =?us-ascii?Q?otkjsnz87IJ+ylUbfZbxcrw5OmMlxcXUJViH2X7+UxE5Ja7N4/EXgSUPLVvw?=
 =?us-ascii?Q?88spQ4QnS88qq5BpRDcv4CyZ8QD3NP7SlXh+QKIaLVY4VOErvl6mhwNnSwuD?=
 =?us-ascii?Q?SMveZ1iejKUO98wZBMWOih7dLgdOJr5PUGqlE9Vr51wVYfMmSMlzbPF74z1J?=
 =?us-ascii?Q?e0xJ6vO/rFiXMn1Sbzl47feu0LhfKn2Y17KkgD7Cl1TuiqVaLB87xS0kf3Xr?=
 =?us-ascii?Q?vfgjk/KYhYJ0Sp+qdCMWiiYtcXFb1ju2HIDF5dyVDrVJb0YpxmH32Kq3Ga8Y?=
 =?us-ascii?Q?2KsDAaHyvTpuuGnIzb3Ds3NLThRwadYX3ZD3jHKsS2GnGg38dVnWL8Ux5Apv?=
 =?us-ascii?Q?3cfuARFGCx244FdRmrL/7fcOUr7IzZmMLPT6k7F/7etp3OAkGOMpmTdP8GS4?=
 =?us-ascii?Q?N3839NskklEFre0qbIkLvQ85qaTnb1e2vPjWLwJguO0hMZ6Tra7NF3VOoj/B?=
 =?us-ascii?Q?LCNDXnYoo6GzxZisSClJ/QigDOGdaT8fyWjmGB4PbHjaB3Xbc0rlnDn2zeNs?=
 =?us-ascii?Q?fG97NVIH1+109weX78+Vl0/VUX0foP3g9ud/ij5DdK04G8ViR8JOh/MY2gZb?=
 =?us-ascii?Q?MsU35TFFoGBw13sfAlohC4k1Z0YZmD0CrPqNPRRPNI7ImnGq0fKegLY57TSC?=
 =?us-ascii?Q?kfSc9jUbAa6Jxhgs7BqgTj14YhMaI7pPwQfIXlas2a+BwR48KeH+f7epxp+u?=
 =?us-ascii?Q?nCvGCORMQh+7Xolz8Lof3EkdQ5Uciq97xgpnNJdZy/f9hL1YWN1wuuo207cO?=
 =?us-ascii?Q?livkoBQWBQ4i/aEkuVcGVMm28ktOxCT3qL1O4D0s65pCrrvXlPEcBKRY7944?=
 =?us-ascii?Q?P2fH1D1k3iCgOwM0Olp65adphQ0ZLOdnkyES4f/sZUy7TFav9LxBkBIoPfS1?=
 =?us-ascii?Q?/AFSOVtBhDt1ecArR1X2CkCi7KVWiFKcvKtMSDD1OJYupC9GKeqHRJiIS7ke?=
 =?us-ascii?Q?zVlWAkGDxgNyXtxRQjwuJs6fEcclMZgXZxwcdh8inD/j8J6aTp1ST6dLbfVg?=
 =?us-ascii?Q?ZwvkKioht2+adD8N4rXnz3bUdu1TF0UL0/bBjZgrNE8CgW15QrHA6ZUKUYzv?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960ecda1-4636-4ec0-06f1-08dbfaefc427
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:09.9164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gQQknK2MfaHfe89u76P0y58U+FWtFKVwf2fIvI/dwQ21/sd9sbsBwOdv2d3aWh4bQ8NYn5HJ7zML0ZaC7wVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5940
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add '%*pb[l]' printf format specifier as descriped in [1].

[1] https://www.kernel.org/doc/Documentation/printk-formats.txt

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 doc/develop/printf.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
index 99d05061b1..c3537b1796 100644
--- a/doc/develop/printf.rst
+++ b/doc/develop/printf.rst
@@ -165,6 +165,12 @@ Pointers
 	* phys_size_t
 	* resource_size_t
 
+%*pb, %*pbl
+        prints bitmap and its derivatives such as cpumask and nodemask.
+        '%*pb' outputs the bitmap with field width as the number of bits
+        and '%*pbl' outputs the bitmap as range list with field width as
+        the number of bits.
+
 %pD
         prints a UEFI device path
 
-- 
2.30.2

