Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B993FCD6E43
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 11:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BFE084671;
	Fri, 29 May 2026 13:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pnbL1mqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42117846A3; Fri, 29 May 2026 13:25:55 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B727F844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+1E65kkvx76Y+FF4JZ9JqxLtAZJoktfhQelCk0hNrpFKA6rbCa41Q/CRdsFdg65Gtzej56TyERfZrWGIMMb+zfSSoo9lRt1r6VQViu+jqfhzhba7dIS3nohsGBaBUirYOmOQN/SUl0vTqd+D57FYu43zVdShJEaS24hVlPzggWWQRH+sqW2MtAYqnB5zS0TbtmEPbWI7+KxtWaYmReGhtvoasK6Has3CpzGcQzZrzsIdmjMG6CwEswnJ9/LddZJrToknNrO3fD4qvYMp6GJWlQVHBTLOOhh1IPQnR3e6F4qfUtcir1Wtk/UIy0mOK6lFSMAFUzzKDLQM4NaNrfoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkTsj343PkA1G0SG253/24a5JWIV7IKjt5yvDqWs/oA=;
 b=VVHFrNxas/Qb5d4RxBMdOeZzQ7kTZY9xuvZkdOfB+/TqjQz2RZz1Qd4XPR7vrUmtGCwr4WjB1ePdXVkgxw6DZ5p6telXn03EI+8seAzNdLRoZnS73PLotmrpRU+Rh2uSjvimtlq2gj1LiQpHKZrUGqtjMPPRRvz9g0b5urFVdlHWvWL5Fe6HzvTHqoq+A52bY37VvT6ple2RQqJ1eT0+1z1TSODLT93IDAtF+hTIQrlqkIqNCxZmgheSlsk8Hn28ppCdYYVrN0T0xPmDzZobRtwb7jsD4NlKk3LJo3NNfb49BGwZeobX/jfQgVyiAozdsRdeL7tf2rSK32agzyiBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkTsj343PkA1G0SG253/24a5JWIV7IKjt5yvDqWs/oA=;
 b=pnbL1mqz2YJcJP5nxvpLyU9+98gvoRFHFv7ZsCyTlFjZhmK4ZXEBc/uGwqG5mAlqh2xLnd2UL0BO9+HqobZ71hb7utGhxIt5f3rUDrWJmwJ1OeP1A+VCDWiYMjmBh8fpXzyGXJb4/9g9bg68LxalTVtxXLuWzEwc+kGAaPzILk8OIdvssqMm2OQcUzWIeZ8RzBlGY853j5WWSkjvWbAsPVKvWK5hw7251Jtvs+Fp1EwBvEq43ijbVlf2N6h7yJ5BRuHdEjZp7WSILwICELu376817YOqd+hpkPNGW5zcALTK3cd3iZkOeUyxoCWEiEsbVU+e6wZrKeBDTCzOnqxx1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by CH8PR03MB8298.namprd03.prod.outlook.com (2603:10b6:610:2bf::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 11:25:48 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 11:25:48 +0000
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
Subject: [PATCH v2] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
Date: Fri, 29 May 2026 19:23:51 +0800
Message-ID: <20260529112351.32301-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|CH8PR03MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: f587120a-4d76-44ba-f3f0-08debd7507c1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: OlMuMlBaddIbzpTIWbcjqej8bwHbNkGDIdR3YN4GO1mP7OCuihlv62y0He5+kkogVcZVXS+T+MxbGuzPII3LXenqrCADOocI2rsIhMftVA5C37WCFCzM47hQkm+6MdcCK7K0jshWrfEckSUiaWtwnGTF1oH7uGQVy4h/V4+M9/c2vAiUnL+K0VCe1bnroBWtl7rkzW3Z3XbzSe0IOVM1b1JJ0L/Qa79Uu9zucYWZPTC/8a89xHxvTJEtuOl7oWFVlx4/j2/7P7iUnjzwwk2j6auZ9MLbZGjB5RrCT/mqUpAdvHYJisnR2XTrWff2g1jPTeFIRLtyP3p5hCDaq9t245tF94n48Vi0s0dbPYe/kcTBKiVedpH3qE4jNwC0QXZNdhiNJ/VvlV6IvIVjmSIMIvSpNR6GGMGZJqHW9ZgwdKWifmAha4jOy8pNqdDleBZRE7Ll9/g0ggNE77U6AC1jwpN0VYDlHSp31/BHW1UQR5E5mshhCAZje2bBYCVzZrvHdMYbYzgwyR49xOxjUA2k4kW4f3pb5LPlezfizXaycQpoGx1/jeWLBSRWOUw1w/WSCb7TQSyXZ56OcVPfW9CqudLdHjxGz9dKl02UongHFXJRLBHhMCgoRZhWyyYLOte3w6cevU6loBQKK7Q35Lo9EXtssUpS7uC1RTVR0RCaxzmp8p7hMqitGyCRHc5uIVYVmqFuD0LZHRSAnpkoNMs0Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpQ8Qa6WyJfBN/pNNnVVYz6qYnSyOK5GQEJry8FktsGa/5OmnL3iZTjztiup?=
 =?us-ascii?Q?u8UdF3co8f0TvqixAB5r1Gwa3pxsBLB0R08sVptrQqYSZC8/EmXnydkIGQ9W?=
 =?us-ascii?Q?yf+CuNF2ihCBGvySQ6VOtqCBIAN9ix5cT2IvHymZDeQz/DINmTwZ04pIgar+?=
 =?us-ascii?Q?0407MOrOrj18FBz+VJ0wbbsAes7CrW9hZ7fPRpkdLmn4Im18p8QyF5yJLiWS?=
 =?us-ascii?Q?+YjQWkT51BexAz72EzehX6muSKY+bW/+P0J2V+pylCsdfNTRhFE2K4C5gggb?=
 =?us-ascii?Q?K/i8MMhgc+n67Fpi9nBB4oaw14QV9m5Ro/j/LHHQTVsCs08T2fyPCPJy3FW0?=
 =?us-ascii?Q?1YIQdWV1o2QZfBfjFaa5sBDkifpEmpD/Divepjztbm0hhTbTUlQnRY3zaRR6?=
 =?us-ascii?Q?dV6GOdkKri0RLfz48FTvKhEexkfeIiuEeigdizdPyMSTRgA0LvMhO0vlGySc?=
 =?us-ascii?Q?MMIw0hZT2aGCKITbd0fNdxgmv5/xWNkal9ZRPRYykUHv36l38UZ3zI2caHjk?=
 =?us-ascii?Q?idnaLWVHXclLb273mlxWTvLXmLMC+VfklX2kbDwQThPa2R4sTpolCSQ5RvUB?=
 =?us-ascii?Q?c8MPEhPLztLrGviYQ58XXKH3O2rB/mtK2gvLXhcFdNrXWO9jVF4WtZQmQO6G?=
 =?us-ascii?Q?IusRPnGKiLWYv4dsAbANz8ELVuFYHCgLs/yklmxFxLph9KlyKkhsGkC6x8BP?=
 =?us-ascii?Q?L9DoNbnSBPv4/6YUoKRO+cojwntFTHpMm7bEuOMI24Cp4ZzN3HZNTzRsgXVn?=
 =?us-ascii?Q?aNbHk8ZseqgowHcyD8aTh4yLByHbf31UfFnW+KoHWhFyMStUBrClKV1lLjQv?=
 =?us-ascii?Q?hNjDRfE5/9LGjAbU1FbthEdwQmiKP46hwVLrnmyA/OqXAFxuPmNgZUk2qcpU?=
 =?us-ascii?Q?9G5eGp5aHYVdMTgioXxs0LR+R/GU9b0rhN0bFeE55hDpeWGfW81noNM6uLYk?=
 =?us-ascii?Q?P8rNFitGsNW21zXm43TKn/16ThHCZ52j8vCPxFL8Y/gmIhEuHom49rn0Gnry?=
 =?us-ascii?Q?Q6XH+EyUtpxLdsTLRMc2i6bjVP/A45BYkBCtXFsghx2C3I+8c5JxALlCEFYS?=
 =?us-ascii?Q?GHcKUlFtxk5RHIorvvhH3vmg/vJej/buYNzBxUZoQdw431nZg0m+ugvhFcIt?=
 =?us-ascii?Q?ZYeMK/5W+RU2zxL8x5IUBJMeDdXZ9LBxHeDNJAVac0Z/ZKxbdTcXdsT16wLy?=
 =?us-ascii?Q?SYlqqCyyRtzotbcOU/UxkeQdog+IVuoiCS2JVfjHxhmI2UVz6UOWK8s6/TI3?=
 =?us-ascii?Q?jWWUiL8biXHgz5DLtywP7u+ZuBgvr2GuthXdOISMBQbexM5ofPxTKJMgqQLA?=
 =?us-ascii?Q?Ac+n7DHCKTFtNEvsImg6dGv/0s6NiN/Et2N9hbEevOsK1OnWQIW6+hLCtQ0Y?=
 =?us-ascii?Q?A/tjtdXZ3gfkBCSsdNvn704FGmzYWHg704bsZJ5PJIaZIto9+vbZJRV/EKNI?=
 =?us-ascii?Q?+2d4DYcARPcC1cJrinFBKik72u8+PRAZ5cuWr/aho0auqu7ZGjwaSoE7taH4?=
 =?us-ascii?Q?hhnQ1S0nuj2/zuRg8vM8GjNvlJnicSYg9guwnJc/qUcshZ7uapTVZBRsrXXV?=
 =?us-ascii?Q?DJC22oGgqn20Bw/xNioNIf+uSRS0YOY4bvXZWnvHP9WSN5iVzh2cZBuBYGE5?=
 =?us-ascii?Q?l7sNcqZgID2AU+c/24ohVbsflc+S0LUxM7x7cmFAXx5VX2pKmpUBYkt6RM/F?=
 =?us-ascii?Q?oFMIuA0wax96cgPTVloumFWSr8dk4Hii9QYZyIoB6cI4m+0uBKRw7fG37TUC?=
 =?us-ascii?Q?YfADQJeYvg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f587120a-4d76-44ba-f3f0-08debd7507c1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:25:47.7106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVFLHP8nSTB7gsozoNnv5Wtd0lNuhVoi1xOYLndae979OTEWGhdKJDMywUiLJlNbt7EZ0e/SqW06YYLMgJFbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8298
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

mkeficapsule tool is automatically enabled when EFI_LOADER is selected,
which introduces a host dependency on libgnutls.

This causes build failures in minimal toolchain environments where
gnutls headers are not installed.

Stratix10 SoCFPGA platforms do not use UEFI capsule update workflows
and therefore do not require mkeficapsule.

Disable CONFIG_TOOLS_MKEFICAPSULE in Stratix10 defconfigs to:
(1) avoid unintended host dependency on gnutls,
(2) reflect actual platform capability, and
(3) prevent tool build failures in minimal environments.

This is intended as an interim fix; a proper Kconfig refinement to
only enable mkeficapsule when capsule update support is actually used
is being discussed with EFI maintainers.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

---
Changelog:
v2:
- Update commit message to clarify root cause of build failure
  (missing gnutls/gnutls.h when mkeficapsule is enabled by EFI_LOADER).
- Clarify that Stratix10 SoCFPGA platforms do not use UEFI capsule
  update workflows, so mkeficapsule is not required for these boards.
- Explicitly state this change is intended as an interim workaround
  to avoid unintended host dependency on libgnutls in minimal builds.
- Note that a longer-term fix should refine Kconfig logic to enable
  mkeficapsule only for platforms that actually support capsule updates.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/
20260319112717.7805-1-boon.khai.ng@altera.com/

 configs/socfpga_stratix10_atf_defconfig | 1 +
 configs/socfpga_stratix10_defconfig     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
index 2eea9a2a731..e7ae16fc278 100644
--- a/configs/socfpga_stratix10_atf_defconfig
+++ b/configs/socfpga_stratix10_atf_defconfig
@@ -88,3 +88,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 7b04859dec7..3071864d88e 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -90,3 +90,4 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

