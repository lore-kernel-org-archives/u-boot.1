Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CDDC07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48AF871CD;
	Wed, 15 Nov 2023 13:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="1icQnK3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6423186FB2; Wed, 15 Nov 2023 13:44:41 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54435871CD
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiECj/uFtLjnJaIp3N+rByO5E5G0/Tf3x7gWm0VFgPLDwHHOSUBEt47ZbP5/y4dGdTdiJgCrI5IxIScTYa504tr7oDqIFEojOwv5griDCZPtUtolzW6O+rNvOHntzeXiB6fz13ppXFdvH3bFzL2b60teYiEYgBDhP82zf+D1EGg1G96s7d7jX2hSdnXNsBPTel5gyCVcGaNBWWDSLozlWEj8/EsGT0lCcz1fOtiIt072aF4TrO0+4Y8pJHbL5MEtIrCfeU46F8RT/wu3kqk4A6C/2cRS2rWLKgeOH+DKOksag/pl/fx3aFmXxmw+1rpTA18eurz84Sv2syYix4EXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH8ouZQsrKdFzaz9ClbGTsB4WLEGZctl0duvIlaNyMk=;
 b=KKEIrMgWiIo1hQ96eC/VLmoP/VvZBEGJ8LEmwFk33Vi9dz3CkfIIYlpLO27RIAwvcNfmeWji1PAnIEo88d0xMyhkpOHtKZwUaeyWgBxlhSNfhgn3DLWbG+bnZBqcsYy3MISYxhhAZsY4qRTvIOMT5pXUqr1F0gi9dL8Zo7M8chfoRAnpxvDCjxL4YQsTLvDw4SevwebAp/PYg4jDwour37b3SgpOgsevLxcwlxKjlaZjfSVnxeqbdLlyX4ZN9+V0Tqbp0+FgGmplDPx18WvA9iNkYDeUq2UDKsO0lx+b04bn1Y8ZAt/JS4cqRWXXAM1BZJf5mzudppiJoQgpYYlPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH8ouZQsrKdFzaz9ClbGTsB4WLEGZctl0duvIlaNyMk=;
 b=1icQnK3AcNLR8gpzTYiJQkiS9XDQnyv1JWdsPToCGZkluyqQhU/7M2R/gDaynWiswqBhqHBbj9F/uxNpq84hURhLZeNJp56GKqu6sYkUu6ypclO6AOeg1q/2XMjnzZ2V8PvyGHFG/SGbkJ9Aq50R3mU1cR/2oWQtEwmsIx1kp2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:36 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:36 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 6/9] test: Add support to create a fat12 fs
Date: Wed, 15 Nov 2023 13:44:21 +0100
Message-Id: <20231115124424.125823-7-christian.taedcke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: d71a3430-8121-4782-2b6a-08dbe5d89fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TX7PBD1adhsdSma1XjQtg+dBNy1GthqRiEUx+HWXzxtkPFaCbdwI0JUiTY8yQZlxUEJuoqJbz0jZvu4Al4uZrpDCW6Z8dMvRj7F+mHHfdjGe5ehEzMl+g4UCqDuTzGPMLZVTkCQBhJHLPIEYhvQyN6kd4k1qrgLeqKT4VFeuDgF+Q0R9wk++WRE4w4o0/scxjWxkMCS1qbdbTFVS2qlR2v2wkzImo3BuvRWjrh2PhzvfFW1x2SpJ8p7TXVQmS+rsn8RqPr6s4T8PIqMjSUYQQx9LOmMNpR+NZ/p/fULCAujJAKIqtsLGhjq2efJPYU7eTCPBHnDlbjjziWqPgjOEMDfhAc5PFqUQXUP3zHFODmv9msouAHbLh3OSh3tFLweru6ZAMu6WZrI3S5bS6eA6HueVFeV5W5JyoM4BjChveRoydiobYf0mQv8i0SA6vxmn8EIGEUbdQhngwW9T3w1R+Fa5zD691liZifUitCbFboj+x4h7gccMg7p75CtYYTsZgNn2VcT7Dg2bQX1E/uE61+giepVfOcFawstXsymXj1gwaM+97q8ZkcGU7hrghiiX0DYw2t/jtonrOhqf6e2tXtNpE+5TVLLGUOuQn71sClpyRxQUd6b47ik0ywDz7h9F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(4744005)(478600001)(2906002)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lR3546tQvUghNA9mk+rwSq7+PMOZ1UqSA7+r6zMMQmHQSY/wj0ZikZJGZeXb?=
 =?us-ascii?Q?sXNTj6gVIeQrcX7KbeHoT6NRrLweTfALsHVaHUCRsQe57HDr6ZN/juaW55WN?=
 =?us-ascii?Q?pxgSPur+LTFJiidK7bAt/C90NQf/bkg3pkDIZWYgQ2GzLPryKGVTVeDHktww?=
 =?us-ascii?Q?QbekNx1i3uTY4DLUd00ri4wj3rY5nNDJcdnG/QmFLWEdJhEOttr4NRkEWyU4?=
 =?us-ascii?Q?Dl135HQgVw/tcfkce4shEVZxbndIFILDjdOr8ZjXDnXdrQy2gRXCGfUn9YFn?=
 =?us-ascii?Q?firENiULPWSliXa5IMfuzUprocTqPVO4Z4iiBSAtEgB/xxJrzf3zvSPC6Qu5?=
 =?us-ascii?Q?kGLM4owyY7fFndzTdXX3dqOs4Vg3pdhw581lKMT8rdkbp4poHrw3HkYdvBSV?=
 =?us-ascii?Q?qzUPJOJtFvuha0az1yTdKMjFp2QnSV4IQWYajgVB+7oKmzDniMDFSczzzPEH?=
 =?us-ascii?Q?22VDG3kEKKasPAJqu5OkLclSYY1L543P5OpZWeZXnLEPX3mtcwXZ2B8+MKHN?=
 =?us-ascii?Q?BmYjLD0TgFUlt03zI/G+5hzcvTerEdndcWlbtBr7+UuaXE1mLb+UmGR3O+M9?=
 =?us-ascii?Q?bfSL3zDaPKNDMabkL49iN5PUU6hKGlDdG2q2i3paI8gCytv2+6qUK63hzZx9?=
 =?us-ascii?Q?7lttMXSGZme41Hp6I83ZBO+HIYEuNeZ4fb1g24zfhcNVrpQMtoXPFbD595zx?=
 =?us-ascii?Q?znul5k+RhjABJ02DcEZM6c8oZvAae229P+FxF14GivWx8uVrvaazRkoocX3i?=
 =?us-ascii?Q?ToA72F4wcM5ZQPrNwKU0+IUkROmFjq/8jx0gfU00+c1iT/PqzPxPM3LMYfP9?=
 =?us-ascii?Q?cfsCHJz2NwiDrL7grcW4qzSPKbwWDmoIwwspX0/JnX+SCYY914bTAnxEthk1?=
 =?us-ascii?Q?jQJAwJch+8TAbYN9pAdmtDUb4sLBJyKfJlcM8zjsnAvfswQqjA+laQajeK2J?=
 =?us-ascii?Q?2xwW6IQb+XceZ0wQst9PXzf6AGQACtK8QBgTwiW2Sv9300ZMIf6P8fgkUcaL?=
 =?us-ascii?Q?8FdwoZawpOBxsN9oEZfi0d70MxAFwlqeqM1xPLULwdVnheQNiluwNIslolqr?=
 =?us-ascii?Q?vS4gq95Y/moSjVSuJrnJOeY9xx9AWabLdyyV5wMJwmKaapo4G2ADcyQXfGty?=
 =?us-ascii?Q?MgnF3ylBn1/oBZql0lrOoDE8vQ4OGpyVveGj4fQBi1NoN3KDRFAnuTK36v6h?=
 =?us-ascii?Q?WLc3+I1YDgT9/f31TiO3US3kwTg7DFq1j9OIvXOR3iDQhphzXDqSzSwgreTY?=
 =?us-ascii?Q?ArllAqA/o1/1shksxScvMQJ/Ps3gFWOxZpXG0tuXMIuw7JfpIZ17BtMB/4Db?=
 =?us-ascii?Q?56TkrLLZRKb8m9KV/9pgx3gx6bb7XQEn4QGPcMNHloZw87jVQ6zLhIpHkw9D?=
 =?us-ascii?Q?0oQXhx5yNXkehCbnLP1SJolf4h4yMOorYc1yYheH68xVlhPJa43FDYOY9d1z?=
 =?us-ascii?Q?YMUg/VeRcr7foN/YH3ITmZD0ZYRt1X2ycxAoaTeb+zEBIiER0ScMRLxfx73+?=
 =?us-ascii?Q?aPVLOqmbBoB6OiB33malGKYhuJbt527e8s9aMPVky/5FetE5ysRAAgc9su/7?=
 =?us-ascii?Q?vWKmgX599WP2Sx1nk9Lb9ZAGdwz/ubSSettcxUkxKAxwGqG7JGdi2GMsSVYZ?=
 =?us-ascii?Q?iJTeoPf7DsQZMGgWxaH0C/En3pQr0CzFqohTEO+ls5PC?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a3430-8121-4782-2b6a-08dbe5d89fff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:36.4085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gto/xgwqN3nXC7+blS/hhFEfNAIU4ViL9TFpWhqqOYYQp7A+9c7r1zTHPFYFe3GT8xtXJKm3Tl2CSgy4T7p90+wB0CQ1TOrWK0q+Y4puucab8nEW52dshql7gLqhKUQT
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

This enables to implement tests for fat12 filesystem.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v1)

 test/py/tests/fs_helper.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 9882ddb1da..0ae7a4c4d7 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -24,7 +24,9 @@ def mk_fs(config, fs_type, size, prefix):
     fs_img = f'{prefix}.{fs_type}.img'
     fs_img = os.path.join(config.persistent_data_dir, fs_img)
 
-    if fs_type == 'fat16':
+    if fs_type == 'fat12':
+        mkfs_opt = '-F 12'
+    elif fs_type == 'fat16':
         mkfs_opt = '-F 16'
     elif fs_type == 'fat32':
         mkfs_opt = '-F 32'
-- 
2.34.1

