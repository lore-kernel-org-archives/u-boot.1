Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DF5CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5EB84A7B;
	Tue, 23 Jun 2026 08:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aaeS0Uuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1EF849E5; Tue, 23 Jun 2026 04:03:02 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4451849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evPPDaX5rmiShiVPVmEmBBLpWXHUUPY44AX2PZo9Od31sxtmbkb3SCgZE5Vad/wEckGSzlS91Vafl2raWKtTlofoFkjizHwLSmNujmauv+HhBr4oJKIAr0sKPduBsSGdPe4vpIzymizU4KtoGCJpk5CFXIKC+iQyAYZ/TvocIVk6NsopGt8NVC2nD9fN+/u9F4Wp2wM/uQ5qDsgiP1Sf6eELUH0bazg5mBiqRIji0heqE4w2pKjND6RCSMLZ7M9AelSqd3+omYvWyB7TRHC5Em++qfQuDxmD8BUfObW6k5ycWzAPr9aMueLyNfibd6sGZvZ5EIYQhR+JFcllXXcQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUDPwEjhELjkNds41qr5BMC3zMo7wr+HVrNksZDTdoQ=;
 b=ZMTUVkI5rBJMz/ltZ4eYbGpaB1uqmkUZNZujupBxgVK8Pe+hlE/HBHnCxmDjcHW6GX+QEqAF6mGgcOiR0TQt07XfrgxR4OLXpFEuwK7UXjicnnmmlBWxiFlYmBBAJtpfgw/vCcf5Ptxe+hmKmxEGG/Ech9pu5zcvnKO6OU5oFfnUB0DluOBzEVzyw8iUkqshrAyfgCWM97vafA7UTsnoPeG3cCX5BaoqQlYOLFh5zVP7Vgy89wLHurOOFxnv7tDUH0lgddQgyATTqpH3wh3+c5Ps3IHl6qoI7A6opdmnNtN+mSZ6VUzX639jL8/GQ2yMacnyB9ghhih18Aa9JFo0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUDPwEjhELjkNds41qr5BMC3zMo7wr+HVrNksZDTdoQ=;
 b=aaeS0Uuj9csuaPTlXdbZX7E71cW3v7/CBEJn05cTxRkDUX7+EysH6tWiKyXUNXi60YJFFrjsp0FfAQRwl0/rg7p9DjosxWuxFh4aPo+xQ/upxY33A2giQEHuoLsYstWXSy6sgVICot2L5iHbnBrvmFR9r4Lu9Fdczcy51H/SYo6WZBwRC0Z7h1F9zP2QAysNuMVqzzR7dT4A2bTbeFe/m4mhlfBhJfAFZkWCkR/FgML7Zm/vErwEyhi35/5wl1UoX8NZ5hyGIwqUayntJ22nr7mNw1Qf2wIrAekAfHFutzlUMz47eQ2zd1y1oFvdYfaLb+NZ72O1SPnfsBFt93MArA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by CH4PR03MB7627.namprd03.prod.outlook.com (2603:10b6:610:241::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:02:58 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:02:58 +0000
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
Subject: [PATCH v4 4/7] configs: socfpga: n5x: enable ISSI QSPI
Date: Tue, 23 Jun 2026 10:02:18 +0800
Message-ID: <20260623020221.32362-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260623020221.32362-1-chen.huei.lok@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|CH4PR03MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: e78c571a-3d07-4deb-ae4c-08ded0cb8c59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: wYlwzzmregyBMnkX7TgN7WnYedMSOsMqi0q0cFtY0CgAIVk4Z/QJN0PbcTdxo5ggV3vxptgQ47wVaXkrDeN+k93uoHIlPB91xIXzWGaOpWsshGLI+qpQeWLMX9aqr9jCaNvaoiofgncuBCvfKdu5nfxlY5CzLbBKa12oKJnnl2u/Ao8rtaFFml9FDBJxICH4SlWZpal9sFyr79bIatcoymrBAhKPrmRbJkX9tXlwTOqFUSUsqXQNEItNZO7z8WAwbe4eXj6RYdm78j7sSvtQrq9FZg+qulQgvXt2GTkW+okFstdGCTQEN3djh7hhcJ+KXJ+wzzWO42v2Z0EVeVp10F4v8imiVGa4WYYuwVIT5VSebDEN1qAfuGL8kuEAuR7ENn90bFuP0ljuq/ibhaWf8kkSUV/W3UQKjO1pBgefj6jCdt5BvlCBplIUMX4EzY1/hxRS/sDxCsRWoDDj5T7wc6TnZ87778nEACY3G2Gkpyi48+UAHBuDy7FKbyhAVz/nhmBiURFEJmNFbj/Cne40/Dyu97jh8yHA0Kc7maVXkkESk5w0uf7HTJBtdAiVcQEa2ZHH5XLBZuXHQ3n/2HWiV4VVpXCwxTrvu1Qz72FY9dhq1aGxG5WbSioi8Gw70HgGoooRoWYjEVWYuqL7noe0+AKHkUJ+IGT/NoGCX0ehIDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZK/C5+rfVs2fHmgjyTBkjcmxNlml8KEYK/22YMRutPORdQZg3cfn/aL8KIf?=
 =?us-ascii?Q?z28vqNOfQjilUB9Pt5PmqTToImdS426QiVDELsIiOFbKqCHQQxKtvCEbm71f?=
 =?us-ascii?Q?+ih3hV6P6okPDbufnRT1zwmQddxHoJy+YkWzREaXrSsMfYOhPmtjiPn4aU9p?=
 =?us-ascii?Q?iv8GTtJ8n9r+/ZnotbKtin/eBoAu54n1d/0DqRf0zOT04EO5qs91MU7nerQM?=
 =?us-ascii?Q?6C4QsYDDVyI3Sq8upygrTungPkslmsQErGfutRkNt0iHZnrd+wvUdmXE/tDs?=
 =?us-ascii?Q?xsEc3CM+o9oUFNi3Dsw5K2NCDC7hstUzk/IjUSw6FCZEfBn48vMqJdiPY6eG?=
 =?us-ascii?Q?s6//8qQNuPOkhmX8j3YqRkYhel+OtYJOZm/rx0dAToaf2R6+/an8GkWbA7fv?=
 =?us-ascii?Q?3RbESczB8hAo56pFISy7cLqR38DYHkrM91RPPTD+lQ3UA8d5baJQagVNBM/3?=
 =?us-ascii?Q?8K5InRCfJhCmwLmDV0NvXnHTWvt4rp5/E9bM/MUkFF8Dls++Sd/8FXRvwS7/?=
 =?us-ascii?Q?1sQgKLPx5NboX7mbVNBsvfH0c4rwL3DcikRJ+XuXfWgwO6ini6lpfevUM3mD?=
 =?us-ascii?Q?uC85aJGEnwrYOyipfae2vkKGDDabYTck58e9W0w/wre0lFk0Z6WWGF2fnyN9?=
 =?us-ascii?Q?irGAwUwWXEG1AL8eAkuopRZ4FKgNvkF+0qkH3m5+fdZm/psa/12+e7FFLmox?=
 =?us-ascii?Q?YMN8gfHB5bUdQiYHWygQ2tcjP4RTgo++9gq3Jg4WowJS9iT4LYk0uEU8//6m?=
 =?us-ascii?Q?5JIQiqM9H5zk+2tDhx+e/ZVM6Og0I4RW1ryk2jXTy3fMzNGM/74QVNlgVhNH?=
 =?us-ascii?Q?FhceJgC/y7b3YHLaYGESqVIjoRdey5LBL2+mh1pKV5t2sZD5ORjs7WkAHtrJ?=
 =?us-ascii?Q?TBMeapFytZvoelQAaIfobgbNbxrJvhjWGQSm7N6rBIfb9Frv7Ctza8gxEwKi?=
 =?us-ascii?Q?k7aeCPGZtYMaAgq4MM1ZDnCbz/XcYUj3Ed9zvuKQjg79dGetAovmGknlnjpT?=
 =?us-ascii?Q?VQ7xwzxV1h941gsohKp7zl2qX21JMdU7SM3Ujs+0C2LP9gHH+/5CtvBhQuOO?=
 =?us-ascii?Q?LTcj+WVt4mVr6Hlj6jIA3GY9dNk6NdxJeJeEOJAinAIPa/ePPUNT+9SyO0rH?=
 =?us-ascii?Q?QV+OV9pLrEJn/0Nse4UpxBneTfMI89JJJj8uW3wd4r1rN3JPLjD5z+bdQ7k/?=
 =?us-ascii?Q?oSfcE5+LfS4wzCTaxCWx4oxMweDFMOcdfK8YKCbXBQHJI5vFf75T47oy3X/O?=
 =?us-ascii?Q?lTE3NEUzXwt/ZEfnbzWxZscUH3HWPce66s3YIs68wZxyAk61rgWYiPMgHOY+?=
 =?us-ascii?Q?MvTManJvnDaBZt8Cps5l7UDuO1TegOJ9//Ek1Bzt22YNCN7xLP1gKmpvxyZM?=
 =?us-ascii?Q?x539i36jcHSVkTl4xVw4AWR2+sAxIP7+f7Pjom32aniES/jTgZCRkKCLOxpQ?=
 =?us-ascii?Q?mLUbi38SnnxKyGUq5iK5elzTfHXha7Ydqib2esuxNVRDSMcYtq2JKUyWOtLR?=
 =?us-ascii?Q?m5zu6vk8Q+gEoWDHPxGuPZwqrN55AV5p6F/vhABu62Cvbdcs6Jlji31ULGKp?=
 =?us-ascii?Q?ZAN040qGpqK1Dgkf/pinNFnbQqRKZQcl1ssCASHiy99qv0QHNM1udSQ8aw5c?=
 =?us-ascii?Q?BDPC2ug6XlocYSkgfQV+97wxjfGofNu49oedONErXU9Kv9Jv0M6eRsahLfIw?=
 =?us-ascii?Q?hBKsGE8wdAQD/FPoYZmQnaG8sMb30z6OvhMq+ZUG8C3M1WJ0g0mjt4V83pej?=
 =?us-ascii?Q?n3SHaERyfuZdjicxYgXW0T3G++XU2dc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78c571a-3d07-4deb-ae4c-08ded0cb8c59
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:02:58.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F38feRoUbG2228ZH4N6AgtOVw4cIy3EmSLfTCp3huGFzkDxNzdvva++hj4YQeiznUtqV1hahtk/Y9bsJ2S+5+UutfQZvtTL/MvYMO/8oNeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7627
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

