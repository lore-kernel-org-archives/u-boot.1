Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E3108E1ED
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 11:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF9783FC5;
	Thu, 19 Mar 2026 12:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LMHb1+qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A945A83E36; Thu, 19 Mar 2026 12:27:48 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52DAE83FC5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 12:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3DaGL4oYkWrhV5/XtWk/gga97YraG3GtnxeV5s6xNjECQIm2Fz0BDzDLOY2ry6J5CYpU8QTcrCEESFHpmsTYPNYkytFnSb1P7KkafU3zabPGKoHk2ndX4cXgcCMizU9MBMgpsBqQrDS9LPykoGAYlCDGUYKCJRS52A6CKnfmJ8Zara+hzugEq3fJv9yPKFcTNKNkz+hzL6ADMi4Q9PiShY0bMYbfSJ545nleBp4W4fC+nx1CRVlkMdiDwCSquaeb0waTRw91pVzGnZX5No3Fr/YQM6h5ZJ7W38y+m70XmBH8LHQM/NjbN+3UpOKyPvyjRNYehNOMVvJ+8aExiE6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aDd/bZupE/PbUOwDhvJ0VqAPd9yVTzcaEs6RyjRpHY=;
 b=XD9/yIoVxEnR6JCh9rntZqt/ghnfIats6crzN5wtbaa/lFaCHBLkgLcBQl1pUo4V/thRBv/ma8p/z6Ak0hvNU9cNybbBVToTAfIFFAxvlFwvfQ1gJy25roJKPCUT2NvPZp1TxkQbJF95LLNtFg5MomyFwRGZkB1abeQ6k1aoEFFTr1aucDAtZmDUQyWEU37wwv9WGuR5mWcoNyO2DsXxGy9YncjyxM+lxx0LydcNqlc3oDCq7VvLQupHpt81oqNBKZIuTsgMgi+JvD10Ne9cU4hHDBS8udYhzlqUO5ZapLZSnbJNeAkm0r/jCg180K4CMODJ+PYM4+KOq4OorDKTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aDd/bZupE/PbUOwDhvJ0VqAPd9yVTzcaEs6RyjRpHY=;
 b=LMHb1+qeC61xb024BrkbggcDeUGJRGC+y94wKFZxF8omaV4j3OA/+ObaXAJnow+nNzceaea7oTJcump5Dq89fXL8k75LkgjJ19i33dvkvpnboHIP939AdSrEUw5Cg2IDZmjQb4PR1HA8GYduBefkuVc7sb2fnriMd3Eidtax1m+ImteBho3kd+WN/qc5N2yRHKsGdKWtkPUKNGLyIR7kvX7Glnxg1OFkcyP2GQz4Wcpy9YctR0L0sBivzKESWhHZd+jnTEJCStwNQ7uqLAz8kemh8fqVamQiLomTmOnpfBLCKDMK9TyEm5GGklZ5zJmNWB0SfHVtKTxjprB0/rfb7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DSWPR03MB989105.namprd03.prod.outlook.com (2603:10b6:8:35e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Thu, 19 Mar
 2026 11:27:40 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 11:27:34 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
Date: Thu, 19 Mar 2026 19:27:17 +0800
Message-ID: <20260319112717.7805-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DSWPR03MB989105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5327766f-b1ff-45e5-f512-08de85aa8408
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hI526/bsxbqzps5VE6wpkSjWdTvODS6u9mIe9EVyp+ptb5Q6i30YQ+kwVjQk0UY0A7NM3de0d1IMOtnJqsT7dj14EjBkgquoBfk25nqjhyn5cDvaI05CjDLhcXxMCz6dAnGZOMNFg8HIqc78pHqjls5+/7nfvfQFFikk0c4pnfMDYCPi4vQfKsbJ2aMbAfpWqO81NnhD0Bkv6r4rFzBKnGSmUPQwWAQx5uVBJWW3cQRmBI49R90mubTGuik7/MxxTXVLstEhjVt583YQ3DQGU/8H8TWUqldDnv1As1zM6bTkOyRTUrmJX+4Ynt9g1pnam+WnX7dPF04K0eu4C/Sg8Vm1KuJSB3K4z3cX3Bk5DDdBZFq7i8/f5zqPIGyYK9s+ESmCUhlyiQSXTzroBDsn55UEzZT3NjGuz/v3Bf9ROLN0o1FP68xxpvfQzoY88uiD+133PFlC7/Z01e9+9THa0foFxSPbut1coZe3OxedmARVyvf9KyFGhSD8fS8e9ei3jfnBGxuY8xocQU/b5My+7yPI/qR15q0MyZmTtgsjn6+qJURuPxZ/Y1XUcxV3tGg2+XXV/hlouf7rwEsu3keh3SUvGEutfpKl6jjQgVOWNd82fcF333l7cwT1LyNQlJos1M2KwdZD6to2kx8CpMRHgG02+PciL3vZ5wuY/JZRu+B2Rci8vUcNMcwwb0OiK2GbLurqvUdnlpOo6YfPabvbdcLJNSc2lCTVhbx2YAzqvwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Yp7A1QXSw77XEpCkIIH8tgW/CHi0Km4NhJ6xTDiu3KCpFJX3j+qcXHGuyC3?=
 =?us-ascii?Q?sWsCILo8GsxLWMy4uMrV9ByBnbL7NVTpK4Y1rFe+VEue3K3zXzzn5Zqsj5tT?=
 =?us-ascii?Q?aiqlILSYUXsTZA1PPxoVnj5NCVAK3aOOqlEEwpFbs3FYi8d7MDxfUFflTi1F?=
 =?us-ascii?Q?Ha6DoLELElakEJ7w+TRrTXX7+vRHKyo33C0Urcn3JRf9oKyW2zKkOl01LZUC?=
 =?us-ascii?Q?sirBeuX/HUPzZuFz8o+PksPLgCASymLhlvViKIqwhse6VR6mpu2cAEh2HtoF?=
 =?us-ascii?Q?jqnEAu8DzjJBvuk+/4GSbfnBzdMb++0j9vu1bm3VmaRCPdFY0ZkPIzeDMmjW?=
 =?us-ascii?Q?DdN1Z2Qcwyr7cIJar1Zyuzyx2xYGaFIc6Kp839hvA21/Xfunt8HOJhU6TfAE?=
 =?us-ascii?Q?knEwPoRzuk8Jurl1tBX1FDkJbSavDVqrmCOMEwg3PoXjNZFrAj/EiW98m3vA?=
 =?us-ascii?Q?8tB10Ur7LXnwUAawyvAJfrqwwY+YUaC198LOUAiGStWIxocv2aI2gvjcsng8?=
 =?us-ascii?Q?uapMxkcOpkwfO8WGHS1cqNeKaLt/KFlj8JjpcfCxxDk75ICv1NGO9fSSdFAQ?=
 =?us-ascii?Q?gnP/NK757Tb3iNauhkGNTXTOwCQejgXGUxhzqI1HEF+d8s3/aGvFgUfpIYM7?=
 =?us-ascii?Q?4RNCOx6nurCE/T9tuD1ZJeGZRPE1XnBSV6nyDWi4NbJNUXpeoG4GQM5kfqpU?=
 =?us-ascii?Q?pnRs9lS14pzBESwYgfexQjkd+x4r6srYwyREqMRL7J+0ZQ+Xiv/e/1j6g4HF?=
 =?us-ascii?Q?VTp1VaTAabzLys5YfQ1x+d5m7gHDh/6SeDDY2l+Vq3AnfpVexYZ5KtTPjT7V?=
 =?us-ascii?Q?gnO6Ihl9p5iuhLuqHiuAoxOzqNgDz6aZiU1szHkd1HuRn3VF3zPil6pfMhV7?=
 =?us-ascii?Q?eXhq5ymOoTzfJ0Fl3bJpedtUVnPPSxvqB04gJM63invcpWl6ozuEgszM0qaq?=
 =?us-ascii?Q?XixzNI4sVt4XHSfy5Y1CqoBuqkE6QdDnRy6PTmfMmpRkHR3MbFu+oB0fDg9N?=
 =?us-ascii?Q?ZxuyUzKZbUXM8yNjKW1z4U+uJYN0y/aVo2zGWGc0q8zY98PZtnoCYLyneXee?=
 =?us-ascii?Q?GPJ/oJ0g0cRlUyc2Wn5Q2+y2DF954EuwmH8oAJNUrN1b12ZLHi2RaoAmKYHq?=
 =?us-ascii?Q?IUOdLiHGHc2Bl7v/PIrHbgzZ2fN4BcX6cJOvBvD+hL8T4fz71xLG1ba9fKLK?=
 =?us-ascii?Q?BV9v8r5iQtTVwtasWyMqJ93SF6atgUZPGrWul2w34nylEuQ3oH30TiGLvFOm?=
 =?us-ascii?Q?j605zzmCs6QT77js7PpCf8x7vU8FL8Xlob1jvH7+8Uvw1PMdjiE6KWmjlUpW?=
 =?us-ascii?Q?kjZID9IY260KaUPRDAzvRs8OIQL9+EYTogB8P49vveFDBlBsa/pC2lzspJJD?=
 =?us-ascii?Q?02A0r6+GlSV6cGH42cRwEwp8QntQB4FgW57EjgL37jp3v5aAlSaeOkNDtLnS?=
 =?us-ascii?Q?O8Ff7sQLtOMcFthfD2BRrD42+zFcMdlzi8wk+535ra/2G0IYMZufTuC7kGAd?=
 =?us-ascii?Q?cCajRMuH9cCdjUV2XED3ACq6yI0xzCefWfHu1oivLy8Hv0F5EJMwdZiCAnb2?=
 =?us-ascii?Q?9PaZu9mZUr0pF8wnZD1GzySE+xTG9lxJDx8Gue/+aderkByHKZdUtoZIDktN?=
 =?us-ascii?Q?JqYl42ahyZ0QOmGlEJIoMujQra2ufMy9K0rBjemUxq1qcYLIPyLvZoAn8MJt?=
 =?us-ascii?Q?4n5EALpZCQtTf13ozZv/6eeiZq7fdhEEjCv/4drc9ku2CX+CL0/j9INuZdQy?=
 =?us-ascii?Q?vR+Gj/L5HQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327766f-b1ff-45e5-f512-08de85aa8408
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 11:27:34.2863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrBWk9rETXBep0LHZ0Z2pWb0mNxFP3OFLHNECs1FlysH6bvHhJiAQExRJwHL5HvdwsNC0lAWvhLsDLe8DSzkMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989105
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

mkeficapsule tool will be built by default if EFI_LOADER is set due to
external changes for U-Boot v2024.10 commit b7a625b1ce49 ("tools: Build
mkeficapsule tool by default if EFI_LOADER is set")

This will cause compilation error on all our SoCFPGA devices, hence we will
be disabling this config for now as we do not utilize this tool.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_stratix10_atf_defconfig | 1 +
 configs/socfpga_stratix10_defconfig     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 206343885d9..4340e8b904e 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -88,3 +88,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index e360048078c..437198a654a 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -90,3 +90,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

