Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA6FC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC4D810F6;
	Wed, 19 Feb 2025 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jKsf5/I3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6110A809A4; Wed, 19 Feb 2025 08:26:40 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0CF800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=attnWd4cwgS6WN7Ybb2O/pnHQ95zpDBTA2L/3bzlrSr6hq+57R7gyb96193M+x/RSpPs8vAQ8dTOQ7EKQW6Sp+rXEPKiWGfJRQEcorsjhJ9cfuiw5bb/5a+ZTg1uTIZbibWR91b6PKiwQLt9j9e0rqRtwwNt+Yfd1NskWs4zaGNeadkUTgdKlTMFF5VAs6Vbm/hmcrHBvr2fkLOGtPdIVzu+qD3iXlsUMaNh6PXRVqkjmeHe6NoYaEVnpFCUqYzksMprfcYkoWs2eTGAPk4DybELscvX/fzYR7P5mB0f6AoG7wTe4iANtELJxkPiedhtsNaSgaDoE/q8q2tZxdEUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpP6snqu+qssnh9GxZuaKJZfYMklio+55RHIEMJJ+Cg=;
 b=XjCukB4q9GdCTHW3p81kYCgf7t1DVqDsekOEUIO5uyaX9d+b1lpzVTLrfIzskmZV4Z7mfjfI4xY/ABJtmser1aI3xVmvsvY3KRG9jBMGxdGsEstMFAjyxOuTLtebARL9yh4tPq7qeO9QW889dfGo7GfQujaYbfaUXn8Rvgqp/OuwcdwRWrMvUjJrnOxSzW/4aBEnHHbMfPxQ98nWeZzogRLVyVr+qES5mRw6/A+FfH0Cpvg+7ZKVYbr5IF7BLTzZ6fCLEE4kaDvsOBv4VhyI7db1byeXj1QFahQk3uVEu1ZN/1KgasRJzjpB1K1YDeiMab1w/CYQ7rsf8mZK/zK0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpP6snqu+qssnh9GxZuaKJZfYMklio+55RHIEMJJ+Cg=;
 b=jKsf5/I3u86fsuxIYCmBbfItsf0jf3N6ZQuMgYcYgEr4hxSSiiOxFoNhZ2fNKKcrNjd8TuTg8qM4sdJA92X3pQd2i/JSQgeJO8P8Os++5NGAviEmqckd9wRluSxsuiVwmU61M5GUC5GvzQ4X59ACqLPHYaAxOfRtLvPJ/G5RneIckfU7m1Imh4aONLBih4iEo0dCx/EFiUZg8LcD0Hed05NF7Bd9TY43cjQi/tu6RZAyx4NsMu8D0LmbtLtvQLt/tKHqik7PivTGYSJcKneNS4LrB7JIE0++dGthonTdZ8HP4l4j0ioXUSGPO5hdHywuxTTTpC+4H9ZbcbpRQGbXkA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:26:34 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:26:34 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 25/26] configs: socfpga: soc64: agilex5: Enable QSPI
 boot with UBI / UBIFS
Thread-Topic: [PATCH v2 25/26] configs: socfpga: soc64: agilex5: Enable QSPI
 boot with UBI / UBIFS
Thread-Index: AQHbgeAzJkxPKOWmf0SoKp0dQ78rbrNOO2zA
Date: Wed, 19 Feb 2025 07:26:34 +0000
Message-ID: <SN6PR03MB3583CF1CE2A639304284EDC1A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-26-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-26-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 824b9fea-914a-44d0-88b6-08dd50b6bd53
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?k1cUWQR2xINSgbMFkPzFH+37vrc5jkNfKuUl700ZYVuikz5ltewuF32oEU/M?=
 =?us-ascii?Q?54gEGNP6aaVN07nnF/xet1glNSshJcmB+5hB007da2RSBCOX94EgZypXfLqp?=
 =?us-ascii?Q?yQo151mQ+3YZ137fZJvtRyr9DrmaMyhNq0cqy0qGS5Ri3wnnFcZ+p+lh8tsG?=
 =?us-ascii?Q?1yedKwlHuPoJ+wbx1osLUUiQbwRE7mT7lur0W6JnTHQNwVXsNsBG55iYyu5e?=
 =?us-ascii?Q?gSvFI/utKJYX7ntvL9Pe4QT/ZN5Fi3uMTXBuzzl8k8WOX1HdPkkgGvQrVGwL?=
 =?us-ascii?Q?kRnTPpfkBzGzfKraeIB4JpfKhPs1LDARh/knhQa/VscOIFvg7h+92SWN8abj?=
 =?us-ascii?Q?KPYV3liNZu1GeEdOxLYeOxljbyUwAw/WkMNKunxsRUIqrDhN/zua7/0C092K?=
 =?us-ascii?Q?sWq5XlksqcVXbGrOhKyukrFlpnIRmBZ88PI6LK+790dJrHM2uNMuoYSyN/g4?=
 =?us-ascii?Q?/zBI1TzjZpF5vX4tqSzNldYjYxkpzAg9SWHt901eGtt7MTKMD2z9Q0A8tTjR?=
 =?us-ascii?Q?d+/LReyccK61kO1LUES8p2tK86q/MuMLwIXGIJg/6mAnMMdpcR9Mlo+eu5wv?=
 =?us-ascii?Q?FZTofUnoLjCB7z93nzyaj2rieAGn0EV+Z/z42xmUYSptMmQf/mIFIwZ4K0/b?=
 =?us-ascii?Q?m3n3cXE1qRtOWYdGF79AQTjaiaUSZfSOzV6OHBrruFflSpi3pKCIycGrYeHE?=
 =?us-ascii?Q?friYsyCZ1djQFbrKA5N4nZQ0m22q8vVJ9pQtn5Dlq+eLF/c8V81hjOmuGKhe?=
 =?us-ascii?Q?A7b0jXjjs0MFnh/F55v7dps34lyhJyYXvfsKIjMLPjCNRd6eMGAQzWjw7CTw?=
 =?us-ascii?Q?+KENEzoY+/VG45uYg4qRpp3eqhJRuaWsNw0SBdlU1Uu9doW6QImjr0nuyC7e?=
 =?us-ascii?Q?vSkNAXJXKqi0dygc33TSaSHnJ/lIAOcDr0dcXhNqvxEawTP/xg2/UcVLRHKC?=
 =?us-ascii?Q?5PUW6L2/fmA0XB3YZ2xpC6CQamoY3RXayTTzG4bwc8HvkLYSMhTo822k6jlD?=
 =?us-ascii?Q?sisYmdXPsjG8K4UnEHWQXasHcudqp9cslQ1GvHkxy9U/oanedK5cZ8eDnHoH?=
 =?us-ascii?Q?e1yrq6liQloZJ0SXvoiOhLQ9URYQoNs34iqoKf0djH0pg4XHSA35x0EGdG/L?=
 =?us-ascii?Q?60ASDuL74OnbKSfEM9hxpdSi/UNcrGtVcD9NUstJ9tgYLN9tcvlPzhOL30O/?=
 =?us-ascii?Q?kmDazoSe43nP9ytTYxPV0zSj+7LYfqpRzME+m8BSbba0/74jeof5lDjA0U1d?=
 =?us-ascii?Q?XvcFcur9ObqRpyl6fj0EmK7HIwhEYYq0nPGbG9S3KCvQcIGqOKmffh5xPvtv?=
 =?us-ascii?Q?UVIXC691nL+3UNoUDDc7XLlcuGid4JtchX7ppD3pWP/Dcjp0VfsR8fN+0uUO?=
 =?us-ascii?Q?DdSzeQvh6kc6LmwkBCpOUMEmOfni?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q/dSEHazRxbccW+flw5DspzethR/OvCgit8NUV6AjkLv9//4VABuJdE/IasE?=
 =?us-ascii?Q?G6y2LpWMWavo2me1AegAKvB48qEtIXIzIXhzWqhQGWBzXCjdv37a1/acIoFk?=
 =?us-ascii?Q?O9+fRNTXGKYj/F80aAtHeRhClKeLdZNAFTZ8YpAhwiRdqA8zDEDlhQwtPw6J?=
 =?us-ascii?Q?OkswwAUzamffYj7bUqQIrVmiWwjcvlKWk05QQFtJal45wMWYlXvCOZKQsI4Z?=
 =?us-ascii?Q?xlxElIB948rQoa5USYsMwGaIlbaAyk04uaKbzaGfA8sbjEKHpBXzdX/i7DHZ?=
 =?us-ascii?Q?5lrhfu3DXEYO/3UyU8fxd5hb/581dkYVRukynaZrIuaYPfVnbC0V7/mZ/j6O?=
 =?us-ascii?Q?URuEtbfJzzLcL3LkQk4yKqA8V2bPP0I+FD/vCLy8rlETtg9tDJeldk5DxYXe?=
 =?us-ascii?Q?Y/nBNwFOR1ZDRkdySCjLLBTw+nqBvYYbcILvP/R4T4CVj+HhXFM34umAN4km?=
 =?us-ascii?Q?DOlhedD4Eu9ELpQIrK7qp+cglCR+mejMTVsjDuj3c+UHoQjyoQhWCgJ6I6xR?=
 =?us-ascii?Q?MACY9t2kCeGcIos0jFgb+7cW++DWIu0DkwecQDPlMTE0PmRTVylhWRFaUoXB?=
 =?us-ascii?Q?IT+iJYCUChPegqePwLFEFY6u9pJ2QsDb3TU5b1hfDg/3NzZuneAYnItj6OPt?=
 =?us-ascii?Q?cnExubIBFi/q4CgpS3RCUrz0e0DO9S4aB7kX6+MFJmT+AjR6Yft+aH3P3wWY?=
 =?us-ascii?Q?BpSqBGy0+f1C6RV7JxvsG1j3Jg2jvqc45gRDiILlNbzwAzS/XHIXs1S6DxuB?=
 =?us-ascii?Q?++7iwuIRmzakl8xTHky8Sr6obvHu2D3wPtZkSC2vXyxKk0Vu3R1PdZJ4EWbn?=
 =?us-ascii?Q?2xTYbw1ObKUJYMnZ4lFNeiYRHHEBx8Z6mI5NouPBLyyoelzd3iwGUVf8jO//?=
 =?us-ascii?Q?bY1P2EBFQmPvNYr5ZQfbs42tIXJVQrhGnkCjjVkS6oCrFpfeWR3T4nmDzmnY?=
 =?us-ascii?Q?lbFqn/ykLN1du1WJAm51nQNlk4vONW1z8rkV2ghn6drqCfD6SMqv9PXU8j7H?=
 =?us-ascii?Q?BLApCWrfo8x61ilth0K426CDB+IJ3bV89SymUTnkgKCVYUOLBhWKiqMqYWJz?=
 =?us-ascii?Q?b6NJB3ent8xP70rv8D0mAiWWf92ScOrw/tDiQqDCVBUZXs3a/P/b71Tkmvn4?=
 =?us-ascii?Q?o0UQQAKPCR5RH6tpai9hYKAz8E/5cXL2+I80g/WrIGKUnrbNqMm7T75LVjJg?=
 =?us-ascii?Q?pdTje5UHWh9RulWWa9ZwFomAbsKYBGFJwE0ehalaVPy9aJe4iVShw36yxJnR?=
 =?us-ascii?Q?UUiLT/D8TCZVxJhYjEMAykiq5KGGN2WoOAgvelq8cj7AlxhI4wZD2khLc65k?=
 =?us-ascii?Q?vZRdiAWe8JQXfGvrxM50padXnV1GDg5yiLwpGlmgCN/7EDfMUa01mwJ79lt7?=
 =?us-ascii?Q?9X8isHoAfsktt5q5xWNvttaQ07CpAtDDqFU9KNHrRuntHC/u3iclkug/ukRS?=
 =?us-ascii?Q?c+CPtFnkOYxQ8DhUGuThASdNArV2A1y68kQ+kjmAPDopo38UcJmrNO/O2gSc?=
 =?us-ascii?Q?7A2wzbZwOH8tPuG8e+Vbqb/3AsMfZn3QStEGJUOeKbzyFu84tjC9T7rQ/pgh?=
 =?us-ascii?Q?bmhGfdfM6Jnf1vL0PfDRetyoZw9dxP2M0pi3heMQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824b9fea-914a-44d0-88b6-08dd50b6bd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:26:34.6645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hd5ZqrKSOHbE6LBCd4SIaVykBWJq+EAnxJOHGWYCag+VDQSPbnTYa36IVryFgG+bnE11TzJeXuP+TrV/PccYxHG+L8EfNFXvUH5LWRedd/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 25/26] configs: socfpga: soc64: agilex5: Enable QSPI boo=
t with UBI / UBIFS

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Add the required configuration in the U-Boot env to enable Linux QSPI boot =
with UBI / UBIFS.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig      | 1 +
 include/configs/socfpga_soc64_common.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 2b71ccac025..5b3e8125aa2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -37,6 +37,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set  CONFIG_SPL_CACHE=3Dy  CONFIG_=
SPL_SPI_FLASH_MTD=3Dy
+CONFIG_SPL_MTD=3Dy
 CONFIG_SPL_SPI_LOAD=3Dy
 CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x04000000
 CONFIG_SPL_ATF=3Dy
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfp=
ga_soc64_common.h
index b7ee1dbf201..5ed17671f79 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 2017-2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  *
  */
=20
@@ -56,6 +57,11 @@
=20
 #define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
 	"bootcmd_qspi=3Dubi detach; sf probe && " \
+	"setenv mtdids 'nor0=3Dnor0,nand0=3Dnand.0' && " \
+	"setenv mtdparts 'mtdparts=3Dnor0:66m(u-boot),190m(root); " \
+	"nand.0:2m(nand_uboot),500m(nand_root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
 	"if ubi part root && ubi readvol ${scriptaddr} script; " \
 	"then echo QSPI: Running script from UBIFS; " \
 	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
