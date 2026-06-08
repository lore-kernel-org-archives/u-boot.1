Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D6CCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E63A8488D;
	Mon,  8 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="F5ZMwXqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE9683314; Mon,  8 Jun 2026 03:28:30 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D325784154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA8Tm+etTgk2a+wbiSn/LGlMjDfmTj8yPmDzsYJFAZC1HtPhh8pkcI+9zB9RNbo/fovr9pIcDSo5JVRR6UaYesCEEuA4TlKSRg6DiFsU1Yer0cq1NmltXYUeWPAhbttpECjw17xp9U2dIIBdv1GhG3oYJ+XFH8ELKNIpVJp7O4vRdLBRFPaDfPwM9rj136f1CRlPrwGqF68pkkD6+ynncB7iOi680nqmTQNX5LVi6BgFhVQ+rCY3am0JZdk4nkooOy/+/TzMBEKwXb8WJgne9sAx6jLMUGLF10iJsPCgCYSwde32cg//8bj7qXQjt2UZYLxhfZMWyBicmDGLM7yEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUDPwEjhELjkNds41qr5BMC3zMo7wr+HVrNksZDTdoQ=;
 b=i6HHNHlnzYRjOVnyGDMIhbxBQg+UHpQKqCZ1ZiMODvq6rcdibggIROJqjyeoAq0hQEs1yx/KBVZCxMejLquO/whJ/qgxcBwhCVPF7LvMyQKweQ9xiYEoWfqWvqOA1KyBfSzTI9unNSpeEh5S7GtXuvGicUrYY8Lu2hwi0TdF5faJHwtnLwcYdyyWEMvOJUpJyPlhcP//m1e7q8p5SGYgDu8nzQ22ggENW3yK2UjKD2l6OeSBLpr1yeq2pgatp/BkwQUZyohsuQO7B3bQmq6omdJmnijquZortMWg3dFqBx7QnfmUvZN7NioN2ky37KdXm3V17CAZ7OxszicXXPMrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUDPwEjhELjkNds41qr5BMC3zMo7wr+HVrNksZDTdoQ=;
 b=F5ZMwXqRfq1/zdeKBfxmnhlnpnzg9SUPuDjQNpDgCZdKulEIsZmo3ynA9TVTckLiIt2L0x2AxqOWUDWHeImQbpe9sJQD3Icprg/5ujySkCxFD7xecWdB5JBhwCVThzltWUlfLkSXs185+lTK8ok4oPqm63NLUTFfufY/dmJwR0VM8dZoenJJ33T7uMLkzX2L5bRXBK/NGaAqy2/KMLEd4+uDiXkqFpSVP+xDnnpzR40YSYFUF5R+nKlRPrInm2jjSURZtawwLHzkjrtlOHWWo25SBUPxCRu/gD0kh0EJJ3Nh+K6Cvv17FdSiqADYx/0Yva7H9BaTTd/yoSHUHtOXZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:26 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:26 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Subject: [PATCH v3 4/7] configs: socfpga: n5x: enable ISSI QSPI
Date: Mon,  8 Jun 2026 09:27:38 +0800
Message-ID: <20260608012741.23760-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608012741.23760-1-chen.huei.lok@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b62e4e6-54d8-4ec6-44e1-08dec4fd3ce1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EiMhgPZ4l/P/ItGONTRkpQv7LuoPyx026/GSCiWAcrY0a+04ePyhxye31VMypeBNquoue4ayFhNdiV+GEKPz111kKWhpBOTkx9qnp6OgvAFT8BMwx8ingFy+wUncq/L3GgXyTp/ubRiFd+jh1OlCidUN8HB5jyRyDKLR0l/IDereYFArEkTQ0lzqXxkvh/vEns9qlql1ovUEaG2tF7FbfizyIhsIZhqrzUionCcpjWc2e7c3rFwLpwIT3Xa9MWpmF6lu+WkgEBjh9rAhSjocMkdwqUWBZssonTpP9650Rf80xnTfjz+DbIm3QBxrahGxRKbF06vNxEPSf8WKSfTxYebgX1G0do1u5+EpPHUslMhkujFq1G4fbeynEIjeBmtjEHvqQp8Tf/CQe0Y8pB2ZWXaE+Fx5K77zQ1F0z3UMYAGmZWzUDmyNduZLQD+IoLsN/BBXWS977ukcGpF2dZIoK+NorKVYzzK/TiThTqVldOIEwXdzReoAU7Ja5ZFcddIpX+MaX9SNF22+N/I+Nu6vGpG2l+bSxh2VrZxuMysVM5V9+vTcMWnqpZ3mYkf+FNqlK7+kitKokE1+0p0xADWTYh2u3pcgXrKj1FB/53wg7DoQCARNiDVGcaR6vprUoflkFovp//sKG0maCzvVmkpgZkNENe+chBUyuaN/JyK/OumzHz9tavAHGLuT6JxyvBAv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGFfaxOiWKlqi+3dBN/hftC3PWzLRWY7hMShgcYaygWKlhXiSJNMF1LfUNHk?=
 =?us-ascii?Q?kxR6tQJCXYTDuZhk10K3m7PrNCgXSzT+lnVAe+QDZJbxqSgt6Qgk52klCPg9?=
 =?us-ascii?Q?ZAvH4UV2gMkHKIc24K2oMC/+wDBgzBalcIFYCDJdtlDeM104Ok4N6Je1T5bD?=
 =?us-ascii?Q?zE+iWOjSqcWV5OW+pRNqSnWzRVRMFrzWeOjUre8wzX+FamT59mAZqN9iACLQ?=
 =?us-ascii?Q?426LoxNGVNSE07VidPV47tM46GUOEdju/DxPpxAsbokMFZo+l06HVj8HsS1b?=
 =?us-ascii?Q?Xftp7TRJFgPtr6cqFO/3JpuxZCnqqOC8LkL0vNfeiajziQTz6ntl6GcuK/3l?=
 =?us-ascii?Q?57ECMe5tlUkSY+z+Kmc97oL5eUjGLtHv6jXdFzzxLq2gdzu6W+O9Bh3Ilydt?=
 =?us-ascii?Q?IlvKS+viRz63DCzP7ZUIYaS6VV/Vod11IAg/4RJDMYggjzPxNvIVu1z4fjbj?=
 =?us-ascii?Q?wPJPIUKA7ijAZcmWvDWPJeKpFh+7SM7nA6s2uYDd1bvgC4KCWD7ZLnTk1btJ?=
 =?us-ascii?Q?LivyG3ZkjgsWeiKItTCvlkVdFWrrGwn/ZPW+9uUBVwAXG6C+m60/4vQ6VuLk?=
 =?us-ascii?Q?nNKRtKnPEMymZEWlT8T6eLQ3tQ9vEX0ynsho4vbnATEGMThU1z7q5Y9TltDL?=
 =?us-ascii?Q?iNkXqgWB7RS0QtGzI8Gja7q92uoqik94SpGMIUz6XW5s20uNh45m4WK5CYPI?=
 =?us-ascii?Q?uFWcygIJC2WdIrYDgCn472ehVI4M4jD75Ia5ZPTE9+pzXYE9vxgz56xpuANK?=
 =?us-ascii?Q?r8xA6QeA8NjC9IuXCmPUHQsRVlv34dDy4/Jc2RFlormkYU/iRKPIWD8do0uZ?=
 =?us-ascii?Q?S11hC7vM8ZmpfisIhTBmBEUSxMmQtGc2vhqzAJpB+2YB+j2gMOFVDBoaZJ70?=
 =?us-ascii?Q?thsW/+FoLEXstmCoazL0Gg/HivuAcz5mrxqb676qMhnJyhFOvgPVs65bSKdV?=
 =?us-ascii?Q?7k/Riobmga8ddWyKhDm9VXLrJSfxCpe2oRR06B4thehwiB7iPvgYNi9VKmAu?=
 =?us-ascii?Q?7uxl2K8bMSjWil0pCQM/BfzSiYgQbUk708rSDzmak4x4IQ9mVIlAAa5OIsQB?=
 =?us-ascii?Q?60n2Bb8Hnm0OZioDrjjIjAsOxGr06litRk3naSnD9UTyhr7X15BSBAPm3F9j?=
 =?us-ascii?Q?qHTMu62kohp7jgiMXjolm3Wv4AEdYCy0+4gx4/QaWyvK/d9R39YkCqBaKjN+?=
 =?us-ascii?Q?LIjEqAfo7vtUWu0hLrAdwkVPLIblSeOGvS0C2g3/pTtVdnhCwyeslNKubxRD?=
 =?us-ascii?Q?d3RuizEWOR8dfafSTZTFp1h8oHpmY7nHpImKM34ZQ4GrrMi4uXglzbuTa5Td?=
 =?us-ascii?Q?OeiZYpR/YdBthHbDviR3lD73mIH07kzoB+ioogp+tk2KXjNziH7M3YvNkJP4?=
 =?us-ascii?Q?7dJAzqauNvIxw93Jb9+a6E5m9NOdbxrgneL1/QN9idUpj+OwzZbO/70RIym4?=
 =?us-ascii?Q?BiEz35PQ6ykzfIYONNzLoelee1GdF4f+XBzK2xIKB1jnCT/P/y8TH5Rh9dGF?=
 =?us-ascii?Q?JtGmaMvzqzVhfp+Nxsw6Pqpnp8GvzP19QKUPnSRIM/49n375062bJ9lJ9Xab?=
 =?us-ascii?Q?uffsRovJpmJBKxpECuPE1/hXbONaE4yniyZLdpvTIoXNbnBzOBiZSiBVhKLt?=
 =?us-ascii?Q?496tz/bk3QNNBgU+n3yQt02XjbtgmeE8M3wp+A7c2yt0hopAZ2yeAQ/tz08z?=
 =?us-ascii?Q?pUw8ncOs+WZfTmaNvfrP5Keh/qTD5etVzfn88t9wKD1/uIyfdgDOfmb78wsD?=
 =?us-ascii?Q?8lKUa6GqJw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b62e4e6-54d8-4ec6-44e1-08dec4fd3ce1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:26.3003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFBJSBTIQFJs/vpISFxMVOy7hl40paXPXCDnLxJiZHVVRWGi8zBFdeasxaZhvHk7RKxKCb00UF8/IuL2MohqFdk+Pq3+PvXuXen76mnhdyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

Enable ISSI SPI flash support in the N5X device.

Signed-off-by: Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---

Changes in v3:
- Renumber from 5/8 to 4/7 following the removal of the DDR retention
  patch from this series
- Fix CONFIG_SPI_FLASH_ISSI position: correctly placed before
  CONFIG_SPI_FLASH_SPANSION per canonical savedefconfig ordering

 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 9159fa0c859..fc988ed3da2 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -71,6 +71,7 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
+CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.43.7

