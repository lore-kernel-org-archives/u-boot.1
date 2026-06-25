Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA7CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 18:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F438498B;
	Thu, 25 Jun 2026 20:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k5D1pAMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0E0847C8; Thu, 25 Jun 2026 20:09:18 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A74849D8
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 20:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbtTWXo3gZ5HAYRPwTQODEruFgLTPDxjK+OdVOrks8jjhDuX94YEJEYJvgUYircMFiC6EGq6dyNDJfZf7krL8/VF8Com7Ut7AduWmyflRB6Uqvm43kQunbbKdaUUExsC8eyme526FK96NPuTJHQhNWg9g39gkkd6oS6TO/7/e6UqZdncicIGTn0s/qLlPTblA/Kl5eQVXVZ8gMNkio1uFFpxnvS0PPqrlzACxlDxg45loNwZURU2qhgWQKkUJP+jKo4GG5pYoA2sCDZbEIA4ryjrfq2s0QWejaCKlrZCytpKPCGQSQ0Kn2bls/Fp0e9Gudj9+1Uj8dP8y4mSASQnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhpk4wCYNo4WUw7CYxn35ao4HD43EEFpCwu9TS7eOUU=;
 b=ZlceZQLsDhOJ3hJhIrBDLa3syJUEux5mfoyhAli3JX7hp5ZfSwUMIaFiGtg9vll2eGow5n93k5FXPBHE//jyyvn/t7aZIzNYfIuCLul800TRc7s0PAyaIg1lUxt8J/BCGoriKPjz5mkdqUWo33JsNpK+hb/j7S+pPFEvJUzw+fvuJAPMNmpZVkKo90eF2fkl/vdEL01YVTpZ1I9FSLjvPJwRkiT1KRYfn0HR6SczsLcLU2mkxkoQIxM/9vQWiqD7BxVhqaL7CGcrHqptNlmKQ5BIo9Gg2lfSCAA0TU76454iqgcrcnJOrYHdKizPxQtiAhnP+/QAJ8xA0ss3dpFk5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mhpk4wCYNo4WUw7CYxn35ao4HD43EEFpCwu9TS7eOUU=;
 b=k5D1pAMcIPrydK7FYdx/bTAvGWPAGJQXLlcCgetDdEx9cgI/CapUh77i3xLY2SeC7Lr7DmiTLLWes/jepkpkK1c+MYTX8rJBzkj7fWn9AH2SQyI/v1ALw9hVvN593cULTsaxDttmfN2C417gXRAn+IirdgviEfI/Egobp93/xERsqL40oewF3tRV553Kq/EoIfow6k4mqZLp9JExtJGT3tDCPp8zFFQb/pft+T3uL8456HLefMCnAvtGo31AJMYcYQO44LRCD0QUH/6HQbQ0GkyK83A09O571YjP0Jdnznbi36HXjzq/S+NK0A5nxoD6A6PhwKaCXTgmMN2ZIrB9PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7357.namprd03.prod.outlook.com (2603:10b6:408:195::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 18:09:08 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 18:09:08 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH 4/4] doc: socfpga: Describe Arria 10 SoCDK QSPI U-Boot and SPL
 build flow
Date: Fri, 26 Jun 2026 02:08:26 +0800
Message-Id: <a869f63c47797e8747df88d9fcab7ce72f590392.1782410782.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1782410782.git.dinesh.maniyam@altera.com>
References: <cover.1782410782.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1d28cb-a5c4-4dd1-12ff-08ded2e4d9e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|6133799003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: prdFD4vqwBD+K39E68Z8eUt947uhkTZVKRuFPSskJgKeqOjCQzD5gHncLSjFtGSIKkJa+FkxydKj1QsiSEAk7YzekmXYaV+yuXrEmCsrcvysDhNIHF++8P2E7TnoRfLJrHW+TgdNkXmmN+i+uQtQ/A1mXh3RhnIRAhgUR8tCDmtogQDY5nrw1HmzBmLAiBiPBAgR/8bavdzMTnxIYzEhWjWCdu4YNH0HEOHjTDiPQN1PFrwqwQIhsqacSu/fzIFs6+3e9PKvyl77evccvxPAQKahRO/FSmEswK00sPae/X8JMb7qnrUlH2IvK0oiyI0zBXCjEt9B2D/kP2K2sOB2oZEjD1JKKU0iD9ZfkpA2MhdiIKnCq1vZ68QLCEIb1lWw3nZX2oLaqZx4veB3yQNmu72Kn7UykVaf5A+XjpWao9w84D2OtswnWNOPXuEHZeePHU0QyW4pHyoFvwtohD4n1Lb5T6Mguv+BBpa7bjzh57VoXZWOFAk33jtAcnHFujf6w953lH1HXRX+YIPpXbrhMgX0bgzhSdqa1auf0JbfjpmX4+bEJuxyBghhuGQUjhJptXGbUEN4MqBTewoUOCKdRwMw1kXsJiAhoXZDJ9qu0Q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYnm7ngB7au3hKUPh6t7LkpFDCx40xo0xgYfQJhVbCKeSyTj/jRPl5an9MKa?=
 =?us-ascii?Q?YD4DzKXT8Og5x6fUENJyNtf03PlMm/EdUCMROOMh+TaOOr+KuAX1+vN0mxz4?=
 =?us-ascii?Q?etk2APNW9+evIuoMiDJFY0Ssh6QRfBbqjT+czlfw/MPao4PClolWFx50uSUc?=
 =?us-ascii?Q?l90UvQpPOLuqxvQxGpWVYP6p+Ud89fXk/axNdcBVr6CpBWSUcJeAXZ9yvuqt?=
 =?us-ascii?Q?LGjX7VHt7HOfNHgALn8+ljFwU+LlMuBAje4GWrkpOXM1zPzD2+FodZefXeri?=
 =?us-ascii?Q?YtvF35ogbNzKqTKCW6RyoyOo92L/xmeJvSIMp4Cea/kXozMHdvr5OVH+q0Pv?=
 =?us-ascii?Q?qDecB5tbld7txfgN+wuLxoKcC4HdwEb2E5ihso3iteCRPhhkFvBLuzjVGyRV?=
 =?us-ascii?Q?ovdrh6c3P+QWg06U8YhmLvkrOq2/Y6lh6rqJ6oN1J9xhqbaTKUxn1k6vkO9b?=
 =?us-ascii?Q?RvkUibTwgpOftHejG+qi+3DRG2akSyKMbbmWC67iIh5ArAwKQnXUHbuTrDzJ?=
 =?us-ascii?Q?AXioxYV6QJBp5sWW66vKLdYFDpZAFOW9pWOAznRigyaEIsbjheK2ElF0INgW?=
 =?us-ascii?Q?VzF4vUtp40MOHzUYQuU2Yu3/5QsbqvN1B6xLvr/Xjq30Qf61WkUpx+iYdbtx?=
 =?us-ascii?Q?Av7ywtz5agNW1gTJQV48oPcYkenXwDiHRx+ECR81rAe+M3LzxK/9dSu/BDRX?=
 =?us-ascii?Q?wFqA13znzKcAQ1Yy5Slg3anJkvtfNlnMdVJRhG77RFhO5JHJEg1vonPTL9iy?=
 =?us-ascii?Q?e7CrZP8GwYSaDTV7BvZ8NMyqLRdJrzUk4NEnBGUFkL6JWO5YK3bkkoCCYs/M?=
 =?us-ascii?Q?gY5ukRt0n6TsL63vWSAJOX72oRPXzB9dHSz+blSqW04GWwsfjyoIsggqVRbt?=
 =?us-ascii?Q?v03KC5Mz2FPUGfapTM+ftG3Optuvlpwn9jFWQfokJVppLyy4+Pkjkugc9oO2?=
 =?us-ascii?Q?QGHC4XKLndUzSFaH4bzMfDjfaLzSN2y88GjgYDvZLqK9DuHP5xFrSDZ3GNpw?=
 =?us-ascii?Q?FSUA+ZCS38wn9eXp1egt2sOKSoGyvoBKo5M+CrXLx6S65CGxhr9QzngLsXta?=
 =?us-ascii?Q?GU08RVrXJGhfzKr0o5kiTiEMItD3k0t5kTZISyXNuLzSDsAzqO01M6pVo9vk?=
 =?us-ascii?Q?hDwW6MEI+ndnmEiuFwbOdzNlVU2hB0t1de+SYRVGwhPLmdasPTUSZJfQhhLq?=
 =?us-ascii?Q?lsyK0GeKac7B8JT5PzwWZSPqhEifv5i3cH5js3MKrQZXIj9CGZj4IDKpR8fy?=
 =?us-ascii?Q?8KKfUlbu5uNUusYt+SRvUZPZlbce5db1gl6RszCTQEtT0lzD1VlaHPEo6T/u?=
 =?us-ascii?Q?/+6XjeDYbRUzKSgylZ6sAwDNEhXMDcOMvdfeQVXmTCVyLL/99dw2oGMzal6s?=
 =?us-ascii?Q?F0wBI44wvRKn/NNKz70WnNotODVXSUCoQHZ5KeSFavfhlpFEQ8FqHfF6Xhof?=
 =?us-ascii?Q?oc0Gil9iWxBr+q6P3idHCbun585VGtmbHuqmnnIapeJf16zmPoTMKqq+GRUR?=
 =?us-ascii?Q?OJgGuY+6CJrMhBddnD92O/M8vTRA9CHPFrHo1SeE11YQSmaTzrvb21bW2P67?=
 =?us-ascii?Q?eR88JbnrVN+Y6jFyPj39o9WuT/G04sNJ5+3NhJ6XBQvNjvB3Nkf9fJIPkxQa?=
 =?us-ascii?Q?G5wD6L+iq+TUG5NmOowKnrvD5pL7nb0AacyzX9WtnfS5taz0xe2DhPAgUPwU?=
 =?us-ascii?Q?CNwXQorZX/ji+TRzwVf5gklpwI9VOMRqveWn1KaKq0PXNRbg3G8/3ddSjZ+8?=
 =?us-ascii?Q?iYx1tftOYE/LaPwNkB4az1fbk6JfA58=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1d28cb-a5c4-4dd1-12ff-08ded2e4d9e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:09:08.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnkzPwtrauDaZIUC0LIyNwN4XOw5rRKaNyg/oQiXPb8pC/0mpZVqnZM+lcvL3bA0rreeeakWzpjOojT78F7jnvtqipjOiA8tJynGLhlEDJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7357
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Describe the U-Boot and SPL build and boot flow for the Arria 10 SoCDK
QSPI platform.

The document outlines the steps to build SPL and U-Boot, generate
default FIT images for FPGA bitstreams, U-Boot, and the Linux kernel,
and provides a reference QSPI flash layout for the resulting images.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 doc/README.socfpga_arria10_qspi_socdk | 56 +++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 doc/README.socfpga_arria10_qspi_socdk

diff --git a/doc/README.socfpga_arria10_qspi_socdk b/doc/README.socfpga_arria10_qspi_socdk
new file mode 100644
index 00000000000..1024fc6eb2b
--- /dev/null
+++ b/doc/README.socfpga_arria10_qspi_socdk
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Altera Corporation <www.altera.com>
+ *
+ */
+
+----------------------------------------
+SOCFPGA Documentation for U-Boot and SPL
+----------------------------------------
+This README is about U-Boot and SPL support for Arria 10 QSPI SoCDK.
+
+a. Steps for building SPL and U-Boot:
+-------------------------------------
+1. cd to U-Boot source directory.
+2. Build both SPL and U-Boot, runs "export CROSS_COMPILE=arm-altera-eabi-;
+make mrproper; make socfpga_arria10_qspi_defconfig; make -8"
+3.Runs "mkpimage -hv 1 -o spl/spl_w_dtb-mkpimage.bin
+ spl/u-boot-spl-dtb.bin spl/u-boot-spl-dtb.bin spl/u-boot-spl-dtb.bin
+ spl/u-boot-spl-dtb.bin"
+
+b. Steps for building default FIT image for FPGA bitstreams:
+------------------------------------------------------------
+1. Copy both ghrd_10as066n2.periph.rbf and ghrd_10as066n2.core.rbf to U-Boot
+source root directory.
+2. Runs "tools /mkimage -E -f
+ board/altera/arria10-socdk/fit_spl_fpga.its fit_spl_fpga.itb"
+
+c. Steps for buiding default FIT image for U-Boot:
+--------------------------------------------------
+1. Ensure a. Steps for building SPL and U-Boot are done.
+2. Runs "tools/mkimage -E -f board/altera/arria10-socdk/fit_uboot.its
+ fit_spl_uboot.itb"
+
+d. Steps for buiding default FIT image for Linux and DTB:
+---------------------------------------------------------
+1. Copy uImage & socfpga_arria10_socdk_qspi.dtb to U-Boot source root directory.
+2. Runs "tools/mkimage -f
+ board/altera/arria10-socdk/fit_kernel_qspi.its kernel.itb"
+
+After going through all steps described above, those images/binaries can be
+written into QSPI flash as shown in below proposed layout. Ensure no overlapping
+for each image.
+
+Addr 0		--------------------------------------
+		|     spl_w_dtb-mkpimage.bin         | 1MB
+		--------------------------------------
+		|     fit_spl_uboot.itb	             | 1MB
+		--------------------------------------
+		|env(64K) & env_redundant(64k)       | 1MB
+		--------------------------------------
+		|      fit_spl_fpga.itb              | depend on bitstreams size
+Addr 0x1200000	--------------------------------------
+		|      kernel.itb	             | depend on kernel.itb size
+Addr 0x2720000  --------------------------------------
+		|console-image-minimal-arria10.jffs2 | -(RFS)
+		--------------------------------------
-- 
2.43.7

