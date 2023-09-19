Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FA3CD54B5
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE7E86B49;
	Tue, 19 Sep 2023 13:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="m4g2mve9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D134086B4C; Tue, 19 Sep 2023 13:37:20 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C528186B38
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFrlNYRIb+GmsKr/EwDIjgQ7+LzcmxMDUybap9+7mCZEo5D69qx+mcAGNZ0vT3A2ds37nmfTOAQn9mjhRrZ6LQ7Ydl/GIoZ7sethMNKPHtkWf7XS12qxXM8uS3HY5b19s9t0qrMVAeat8AL6O/Ii4efM9XnfQseDFRjf6+ypYy8/QN/vBptSh9tGQepQiLRHtkoP9Fx+eF9pWwq5/woi/DPDuOzeRrW2KTS6LVhiqAyClXRVFizmiT/g0FpiYl6oy/Dx9X4zJnf491T3Sv9gVlpqZ8xwvans1KDZgsHW3qAgFcEh0fS50ZJU67jebX4xfGL4uwNfFfiHHnZXsrVvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJw4aWSo9hK2oLbiowTP02hOOuWa3vq61EtNyrD6H6E=;
 b=a92FMHjcW4udxcnE7/nmpzbAXNIrjKMm8XaNlO9Ko76prB6hzMFvZX8p+NcBTDjS5pbeltV2qCo85SU1xlG0Wf+nLwl8iS3y+ReeN5Bggyhf6S3BATmEaA90hkt22Yxl8oQ+WvMIz5PhObRpK9vfOfQyUD22+fGIwqlpNCFASyb+1iGzkenHM4ZKTXanbMvPeMiJnIBquF4gSScDyqxDd3e744m5v4DHHq8wroKh0dsilXXuEg+1892m1+TdEZyu3uTkkGguAOIKDoKcmpuOCdAX6M5m7xzYpuEkpvmQmcfVVPGgfSobwL1lTvbxrAI6brdJU5GEjA9G4O62JrKZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJw4aWSo9hK2oLbiowTP02hOOuWa3vq61EtNyrD6H6E=;
 b=m4g2mve9z69dXjWCTypk/ZEDSrUcv7t5ffCVgBmTv0j8qm8r0S65wRH93gFwat7TraRjjMdEklLTSEtHkVrsNpdofvTZ9mST7vUMXyx7mPGbcRele4xtlh77Mn1owUKhukGxDmWQjYZMxeDKR2ZXlW00X6ZRJdb9o5b4KbtlNjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:37:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:37:16 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/4] binman: test: rename 275_fit_align.dts ->
 275_fit_align_external.dts
Date: Tue, 19 Sep 2023 13:37:03 +0200
Message-Id: <20230919113705.109639-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:208:be::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3683:EE_
X-MS-Office365-Filtering-Correlation-Id: e572028f-c792-4098-6dec-08dbb904c645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP6MyQ8HhDgLwF4XsNF7yQZ6tJfyTDC4wDNd1RY2dwzPpVxHDlx/+ssu6Yig8GHw2mcmKbzUS2Otd0Te9BDAp+Gc2xvjHxyKpP17sWG0O4ORziojPeWwcd5RM33lja9a0qXrFmPEDIL+C9f8wCK51HXaYi0P+YyjG+L+1oIb2qXxO5pocrjzSQnxfG2ZLcXpJ669vnxazwI7wIrdiiGgzt3U9KiJL6nA4H2Sw8hHVBbJFlbr3hZli3BKa3WtkYGJEUpoM9cllxNP2Pz23C/h+Zv6UKIXW3yubOTvU7BDgFf6BxE7MFrDgAMZIVK4w1GyIXZZ7w2Zs/WSa1wLe7OKNKA6Zf8wfENJfTzSdJt6//FbCZ4Gcmt7r4c9ws5xAQ2XFkZZpaShK6J3BpXM58KsRFTa7BpSXYHHDk1CLdJNAC2D6iwKnyrteT4VLQFFaueQwDK1UP9whIJbwaR/mYmbzKSeWNgvMoK6eZI5SKakZrFqGO4lGgu1uRAxfZZYQ6UGuSF6sDD7/dB0YureLA9swG9/NEmX/JvCXaeYDnctNJ2VwsthwQq+hH9mhZoDdkxMXenZKfZE3piZBu/Y0rFQ/UzM9OOLzLJ/mJEVqFSHVsEUn5FIBApBOxT8eNWIaVrj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39850400004)(136003)(366004)(186009)(1800799009)(451199024)(2906002)(5660300002)(83380400001)(6512007)(107886003)(26005)(1076003)(2616005)(41300700001)(316002)(6916009)(66476007)(54906003)(8936002)(8676002)(66556008)(4326008)(44832011)(66946007)(6486002)(8976002)(6666004)(52116002)(478600001)(6506007)(86362001)(36756003)(38100700002)(38350700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiamDYjWjwCXnjo1MapOJixZxaw7WiHpbwJ+xt9dstZ9VpKhqGl4MqlzoxUC?=
 =?us-ascii?Q?TCENRLfxA3TlpHtIbLY4yBMDbBzZ/j/ZolNCHWmVSjZloA931rJv+A08LjjF?=
 =?us-ascii?Q?9ivZe2ld+29Ms+sQ8BdGDignt5HEmRyAnngVHRgqF7LhTxokGuxRVx0khADD?=
 =?us-ascii?Q?osAqHJGapq4ppYYBzgGQbUNSv1MG8z6TjRm/+duNtztwgbUPTWgnPoQp0Xuo?=
 =?us-ascii?Q?Mvo7Es1iKkIJurZL9xA1AyMRvSx70ay+prEmzes2l15sndN2khyhoc3EiVfz?=
 =?us-ascii?Q?u7IIFZza8Ty4kVw073p/WijU2Zexj0rku61L1ND/qxGX6mIYbBHSbZyd233I?=
 =?us-ascii?Q?s6fDOkFRFBexZ3xvKcoc5PV3eDhsBaUEnQhoxhUOwW9twf+rm3kNcGUEYZtY?=
 =?us-ascii?Q?8tQdHkkQCAF6JR7xH0rLfeoyAB/eS3vaG0G2Zs043KQxnIybNIIKkEoNqz4u?=
 =?us-ascii?Q?d23EBRot0+6ZAFi1kDw0P95ZlpLON3jz1DHKrnLUYBsNc+2nLi2o5ivoCGnv?=
 =?us-ascii?Q?3G1XJ+ThF4aACsDl0aWITHy8Kdo1ktfMAHh078TILBrhgWpHKv8PtXlKhkIF?=
 =?us-ascii?Q?qQqySwo3uXP8PcyGmCBbS4n1vOF8AHQ1ObSbw62Durl5X+YWVdLdAZTg0vk/?=
 =?us-ascii?Q?C5181aIXpZFgqREIlGCvXLW3KM0zkxBir2invF8Og9Aj1rylwqzEtlNl1YJA?=
 =?us-ascii?Q?Of+03oAzg29Z1r+xWJ24srWGz5CpJFuTMxr147uULUfb2V9RGyR+x89P+nkI?=
 =?us-ascii?Q?eCdlb6kh8ax3S9I5trvzbeCmf1V4YXbhLGpiV2Zx+YIb2yO4YbTEhYe/C7zA?=
 =?us-ascii?Q?oKcvJm3B7SmYw6QqWVXWE39gZucQZjMAWCBxRNhgaKDvgz3QyTd2CTAPtbaQ?=
 =?us-ascii?Q?ATOb5Tq8Gw+4bs6k5aEcvJ/yYjm1YH/KzjsLjHpp7Na+yS98yILLuFjSdCox?=
 =?us-ascii?Q?nUHh2X6TO4wpQ9g7V9yKI581wBCVWgfS2UxlLLsGrJypVJAmj7zLLohx2jyz?=
 =?us-ascii?Q?gV0AJHohD8YTl02NqccOC2KyMSKjh+2bGI3IidXVDjR2r5lzFL6MjXYhjQK5?=
 =?us-ascii?Q?wKav5EbfVcRj6vd7lAP8s7wByLv+Hvd8FAGZO65i/Edrc+BDKxqhWG/I0n1y?=
 =?us-ascii?Q?SA/dDHieMdQrJAWfj19no+aqJ6PoeQtNqUh2NesMr85fKBrK2s/z1piPkiyE?=
 =?us-ascii?Q?nQ7Ha34zI8OQmyvh0/Xy19CswIh1CYqOpO3QOycsss/Z50F+obwjPHMR1qI+?=
 =?us-ascii?Q?1PAel/aUOeY+7Mw+foUjnJmCQkKgKpplBjaFUq30wTnK7JtfzAqAqRjPB7BE?=
 =?us-ascii?Q?f7oJTKkQmNSI1biskPJ5pBkADWmxC52rZRUZAlODuRlCXgkxnpJJJi0MJe4N?=
 =?us-ascii?Q?cJ5pJKOGAs9qXIon4nbagP+TEIituNLVKhFAOnrtPeKYMK6P2oCDqK2qYlfc?=
 =?us-ascii?Q?stbV+rhScDa3hOuqs4eqpH+QiG9pFxFIrpQf+xuq+kUo5MZqrvAI9P0YpOSL?=
 =?us-ascii?Q?vRMBpvCYJt6PbotsqPnz/JWzr4+8ClcsXVEotr+LI39WuJSrWi5wTemfayEP?=
 =?us-ascii?Q?mNxLpxGVRqDp7QFvzBK9QLIKUeCeR6Fr819dQdw8kT4NkmVpJSAL1W/Th2yG?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e572028f-c792-4098-6dec-08dbb904c645
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:37:16.1680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbJmHXQfj7m71VAqYoUlP7I/HWqzX9GiY1Y4IM5Pr53sQY2FPERmxiVO+t0cI8Vn6NBTtNjVAhgFJIAY7XafQHUFk8WxkRYuxGAOTYhX3dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3683
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

In preparation for adding a test case for fit,align without
fit,external-offset present, rename the existing test case and
corresponding file.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 tools/binman/ftest.py                                         | 4 ++--
 .../test/{275_fit_align.dts => 275_fit_align_external.dts}    | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/binman/test/{275_fit_align.dts => 275_fit_align_external.dts} (100%)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1293e9dbf4..d26e7511f7 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -6522,9 +6522,9 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(base + 8, inset.image_pos);
         self.assertEqual(4, inset.size);
 
-    def testFitAlign(self):
+    def testFitAlignExternal(self):
         """Test an image with an FIT with aligned external data"""
-        data = self._DoReadFile('275_fit_align.dts')
+        data = self._DoReadFile('275_fit_align_external.dts')
         self.assertEqual(4096, len(data))
 
         dtb = fdt.Fdt.FromData(data)
diff --git a/tools/binman/test/275_fit_align.dts b/tools/binman/test/275_fit_align_external.dts
similarity index 100%
rename from tools/binman/test/275_fit_align.dts
rename to tools/binman/test/275_fit_align_external.dts
-- 
2.37.2

