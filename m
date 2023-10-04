Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E445E8FDDD
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 08:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E64486D77;
	Wed,  4 Oct 2023 10:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="r1QzRY5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B91886D94; Wed,  4 Oct 2023 10:56:49 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B897886D5C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 10:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egeK/kvo0G+40hGix5szDTNBl9REnXjMun4boeARpbfqAFOyZgP5CpUU6skzgzCrC5itfS1B6NZRm+XLDUcBhfAAGGJ45dfOwJ/q+fOt8MKCrlhYBIB5YsjEFSKhwHCLGbfQyobVYrWNSCrR/XEVI6uDTEYYyGrzSj1N74iJKEZ5xg/jXJVRaaDO4GZsAm+nUxi2zycRlRECZ/S+eBJZm8I6Tsebg/BKY9zJoy4AKs0pEzDyZfm47Hz7x4U6Y95erXVTpp5Xah1ufYhw27cuyt1Z00TVQP1S/52OMbQDC3zyiim8Eszj+M9ylY4DMfYueBpraeHS4X8xmatGgW3Xqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHISZJb0YhVxar9t66C8SimX91OlX2WeWtIP4qG7O1U=;
 b=VZy5Se5Y1l180GK70MINEC/WUVbEJXkFWbfhxJSLZcdT1Ew70tITx7DUbw5ssjhjHN31059X1I6r+N4Hafx19TXz2bVZZpVOKlsqGFdenkiedUsI+bVyFMSOXDGL78S8PIv3T0rAD9TDRJHq6PBRWtPT0Y8DVhoErLmak/ZnjdEefaaBChJSWHG9If1eOiup0snjsr0xLY0++XEwcAFCFVsy5W/juLKA3QFXdFjQEw5+8nOy9h3cOH4Wg0QgxvuqgK+xBx4fwRu6u0OBeWqBBLG+qaSsPkVXMf++hApA8cLtYztjDlM65VBhs4CLwx4t70+e60Q+aDbbzCLngEYeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHISZJb0YhVxar9t66C8SimX91OlX2WeWtIP4qG7O1U=;
 b=r1QzRY5lBBvbx7vRGo87GxmpgGJhCGZtpt/0Lu3DjJkXRNP5qJSf3U62uHzzvOFekeJTyIt/uzTn/JCzvuXKmJecv0iPK2XCko9y3WEtua7VS0J5IfyAh8Z/uvHMgUVu5T4IalE81ZhfZTMhjTQaIQ+8Qm7RmsONGHDUpDbIWRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB8PR08MB5482.eurprd08.prod.outlook.com (2603:10a6:10:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 08:56:44 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::4d2c:55ba:282e:9a62]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::4d2c:55ba:282e:9a62%5]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 08:56:44 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] binman: bintool: Change make target arg type from string to
 list
Date: Wed,  4 Oct 2023 10:56:35 +0200
Message-Id: <20231004085635.330221-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB8PR08MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 047375b5-02ec-4598-8fa5-08dbc4b7d584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jefbtj9qV3EyO4hl+K1pdPVXkblxWfyg8Dvxeg8Jb1I4icZzhtN7HLGRT07xsF8/TsrTEch9nFbn+H6CLoK7XJCZYCPAzQn6JpavXxlCa4D4oVSznHmBMuqpw60ZBOlLqmcmGb2AzQuvUhsZWrPAB/wOjwIQfpXhdmBpmdxyU9Yv1sjPQbbKvtHAOJbk8S/dVUInbSmn4L2nzMuuBU+1l0mu8jQ4NFDZvDAc+RJ2D2ymgbLGCJhxUs8i49kY5zkf9bpDK3EnFUP6zF6nWwUQFUTjwWjujUYJvLZFwao1PN3sOcveHrO7zSyatHVtRBHL+8s+MUvpClcdnrdq3fJPVT4zGufQ8b/sbzCPMvFBElp94iRux1jDBnJe4tro+5z5mCqspunNU0sx/G9V1QgpnkbNGVvywXc05lsS7vcosnNOdhU8l6YNl5h8hZ3Ai4IlOEdHrQlHeQPbvju946+IdTeotxPxUozuL08nwFuWPzxgLjUxmp1rOlN48SP5BPG/omVYj+/rqr/sLlO3Xdzvln0TGNm0LFt3C/E9oQl4bmvmvjuhFVDzijbcmdVhWBhm71fUHnfCgMzXtKYkTJkg7L1u1b0bGM6c5sPnICnMMBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(6506007)(6512007)(9686003)(8936002)(6486002)(38100700002)(478600001)(5660300002)(66946007)(4326008)(26005)(316002)(6916009)(1076003)(41300700001)(8676002)(6666004)(54906003)(2906002)(66476007)(66556008)(52116002)(83380400001)(36756003)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eN6XoaXkTfIEpe48sqHIDBglttB4AbrNbbSwfvn0bhy9gS+mHzJkZnwmZRQQ?=
 =?us-ascii?Q?FO3vYbvZIQX4NelHkKxNyAl3qP59wwid9n3bL34OhmX1+tW+x49GxzA++dZH?=
 =?us-ascii?Q?4sRI0Cmqkm9Dp228Sv8Ry8nsDjle6Z59+NKqbGxpwINHQKJRS0EsOTsq6dnY?=
 =?us-ascii?Q?1oJEHA8d2WYGwflRw7yBz0tkhv/5i1dPYIMwH+0PWl6sTm2Ff/aLAlWvypcT?=
 =?us-ascii?Q?vkGjNAW7P2xT2gLRIPC0cdtnKQeGNCaNrFoUSIiOWsQZ+NTeDFKXxPAJRKoH?=
 =?us-ascii?Q?nfDLrNAnyK9ZN3AC3XXOlMEOCFCR1zkv3yxsU360eLh/ejw00DbeL9WVtSN3?=
 =?us-ascii?Q?CAKOR6rUYpjU4xSUQJaf7ybuz+2j2B29fRTdE/6d8G9EL7RxeAQZ8+qvLF8d?=
 =?us-ascii?Q?KFa56bXTJK2Em8qlQzt9vyp9/Kyq9dWN3+UzLqw6VdJkHf1LnNw8WtHuL2fv?=
 =?us-ascii?Q?xIV6PESRioPVz9+Ak7L9B6lIA/Pz427GBkeMGk7W44NPTcl+Z4SQi/4HMNe1?=
 =?us-ascii?Q?itEhaKfBf4+iMf0XCtEkADJMy00VLKuYBeDSewl5zLC4YR7YzAHTrZJoUup/?=
 =?us-ascii?Q?DJZcv49Qp0VNYT7Tw5PRuMmjHkT3a6JQYLgX1MFqnP6JVVxIDU1l3y6lo4Gk?=
 =?us-ascii?Q?WWb1/97wymE0XS/5OhNdH8UpZdVr5a3FPEXatrfS3AsQHie+4RsNFML2K7eE?=
 =?us-ascii?Q?YOaKaXdsBbK5nJmg3yBheoCMFMvANHlcKPpAWAUnwMgtzFiqYEyR+hiTOEZF?=
 =?us-ascii?Q?3cqIWSEcZ/hurA6/a5kH5WYyqNrAJbdCevLJKipxVQwwJAbOuiKEdzVDN5bH?=
 =?us-ascii?Q?VrMeyykjMKuPnBCbuPrVE32iFuIJKSgr+fkVx+tB50WAZ/vo9/GywnCiUrT3?=
 =?us-ascii?Q?RK+UDHz1jO0REzFugKvZ76tDKJCbLMlLkOhH1K2kXn+j+Lcsxe1Fp8QvjLO7?=
 =?us-ascii?Q?P3x5im+4r0LxWsrOSsfu8is7axDt4v0NoEartkGNR/ncggibSvi63bH+kG02?=
 =?us-ascii?Q?eCnjPFpHBU/Zl6c8ystgRdbFWM8UWdBi9gClLnKufHMTWAOmfWOA1c4LU3FU?=
 =?us-ascii?Q?ujB1K58WcssiFympwfNFIBZ2sOOMFhd3atZkRNXUIJpS/7kV7KhJCdo1/Ww1?=
 =?us-ascii?Q?Gz/K5c1aPn+rj6bWhc7Y9XSaEJEDN7PvqL1NQ1pVr7GZQHuVuLo/TuokwoCU?=
 =?us-ascii?Q?wR32I2YVgcLfIVc0Kz63t4VvbCb9VOZhcLpeL07tnopS3ZlQ5aKCNrLM5Ur3?=
 =?us-ascii?Q?3Uu7MIbHzlHYcUPhPosyEZIM3orTJUJ558iHlOPJqgyFVFxr0TIfq7up1sny?=
 =?us-ascii?Q?w8WNBhW5Rs42yDUIsy84mlsRhLRHInNQFA+rrQ/nxmr+g0Tq4RIw/BnIuUli?=
 =?us-ascii?Q?2tmnfFBpfwTFLpxMraprzxZ7GhON/oC9LGt7diIotMHB0k2khaZlO2Mn4keb?=
 =?us-ascii?Q?u/1jqvb11k6WbrWYfjfV8f9f4kIIeHZtBuZ1wSsRki5/zPOBVPwmAUent26b?=
 =?us-ascii?Q?UUHOPshTJ9D7F21KJT3AtZ2qISsZucYLKyiyKpSMGNhjPfyEmgoSS6sOUMkq?=
 =?us-ascii?Q?mHA/kfoNhxjSQqawtnSumbczXJkndoQ75Y5yYB6XloDr1FHO5PgGFhlhWZ5Q?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047375b5-02ec-4598-8fa5-08dbc4b7d584
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 08:56:44.4784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojcdWMSgkUK+NCEDeOHIJyINUgu7OXtrLz0p8lNRKFpbT756g2Up591jJGjQIytPoeDQPju9b1Iq1JcFnQOoYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5482
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

The argument type of `build_from_git` was changed from string to list
in d71e7116997f14097735f04cc7847f0a68dbc485.

This commit adapts the argument type of all bintools using this
function.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>

---

 tools/binman/btool/bootgen.py  | 2 +-
 tools/binman/btool/fiptool.py  | 2 +-
 tools/binman/btool/futility.py | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/binman/btool/bootgen.py b/tools/binman/btool/bootgen.py
index f2ca552dc2..1bc9f0aa96 100644
--- a/tools/binman/btool/bootgen.py
+++ b/tools/binman/btool/bootgen.py
@@ -132,6 +132,6 @@ class Bintoolbootgen(bintool.Bintool):
 
         result = self.build_from_git(
             'https://github.com/Xilinx/bootgen',
-            'all',
+            ['all'],
             'bootgen')
         return result
diff --git a/tools/binman/btool/fiptool.py b/tools/binman/btool/fiptool.py
index c80f8275c4..34002f54af 100644
--- a/tools/binman/btool/fiptool.py
+++ b/tools/binman/btool/fiptool.py
@@ -109,6 +109,6 @@ class Bintoolfiptool(bintool.Bintool):
             return None
         result = self.build_from_git(
             'https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git',
-            'fiptool',
+            ['fiptool'],
             'tools/fiptool/fiptool')
         return result
diff --git a/tools/binman/btool/futility.py b/tools/binman/btool/futility.py
index 04c9aefe9b..0d3980d071 100644
--- a/tools/binman/btool/futility.py
+++ b/tools/binman/btool/futility.py
@@ -170,7 +170,7 @@ class Bintoolfutility(bintool.Bintool):
         # .gitcookies file. So use a mirror instead.
         result = self.build_from_git(
             'https://github.com/sjg20/vboot_reference.git',
-            'all',
+            ['all'],
             'build/futility/futility',
             flags=['USE_FLASHROM=0'])
         return result
-- 
2.30.2

