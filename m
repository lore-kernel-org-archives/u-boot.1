Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E60DC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD65082CA4;
	Tue,  3 Jun 2025 16:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="ptnKjFti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F3B82145; Tue,  3 Jun 2025 15:38:39 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF9E80AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLMcPyrNOCEFQPbVf1b9fsgn7ujB9o1ViJ+XtwrmIy5MtTd9XehGcY1uDYs2ICpPpOCf1DYu0uz8pcdCXoUjc4MMq9Z8hZ4+cyHZh3+2AXnbwZBO8GGubr9tczVAiVVeXlfFmCG2tSFIgD9YaiW8cZGBlRXms+YMlW8GeYvSxcmSBuHQRTGqMHWaxEdwQqgYboM7ysgk2dmlz+SWU6MsERRyUf59RqIbIs6ZBuENTcWDBCRvAPLj9DkqJU+dB3lf/aPNlQ4vnfHj++p26cWURhDlzzSC7QwASMmoxiOlIbmcUdmFNBXZiJwX7Ih7JRD7MSA+UsxcpXUiwNzWavLrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uTznaV1B6/F1Shg6Bz8x38BeITRynE4mWaRhcp8xyc=;
 b=ODTqBExeHMZ7hwu4YTiPG7DMjUZ03IsZCI0z7yIHa2dULfihICDCO86I0Uz7FVWoJi3vyRDnsRB2yn+zac8YsAS6GMM2nowAx1AfRfK9AaYfmfwxJytKAOcqXgg4tNI03sSkQmC47132dur7dHnoEiqfxjBogdbrMmMM9+gCTRSx61Nr1Pj0NUkFnRA9vORyAzcOuzb4XPjuRg2uFamRCSY9bnSErPHG2DxgaBBTPctOnpT4edOmxrwdTS7QlSeAW+S8cWF/P9c+oyc8/yHdt0fEdjmImAj1GUmRtTkQnLtAqNnuWhndPUSVP9+449RheKdZ0b/jckQ8MH1peVsq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uTznaV1B6/F1Shg6Bz8x38BeITRynE4mWaRhcp8xyc=;
 b=ptnKjFti2VpcUrMfjfzEttpyD9uB9ztXX+egC8VFa4S2HT3LuFoTxd3U4nr73cSbTIESl6PEPBMw1RwmPHSbjTDZaZlxJsWc9bcMNaQyoBXgG+7m1Nnds11uxT91bjuqoYkdK6LiGtBHT+qQnPRhhkowIfTlSrgaAj1hHXr85iCDP5iF7MjQ5wmRrKvPImGj34osiLKuURliMAjcFmV/bvxgWqUYYVFRcf/mGrSb7Y4SaPCJRpvwlz/moT73sdSZTJChazt3ONSU6sbW0SSJw48M37vm0GJD/tvAAPyM44m/lW++Ach0Qye0GXaNfTxeZR3GpHWhFuU4sLl3Ym5isw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB4PR09MB6623.eurprd09.prod.outlook.com (2603:10a6:10:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:38:34 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:38:34 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 02/11] gpio: Add GPIO driver for Intel EG20T
Thread-Topic: [PATCH 02/11] gpio: Add GPIO driver for Intel EG20T
Thread-Index: AQHb1IzNBsr9g4BjMEypCFBieXzCWQ==
Date: Tue, 3 Jun 2025 13:38:34 +0000
Message-ID: <20250603133744.278790-3-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB4PR09MB6623:EE_
x-ms-office365-filtering-correlation-id: 1f30ed57-0320-4af5-3efa-08dda2a3f00a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Xjmrw9yJxMYGb2LOEj2wpzfp1M5hWn1/o4dptOoFgF5laJz30ow+JZCrAa?=
 =?iso-8859-1?Q?7ma83oP/pWuxYTbFVU7wctt2VsoIMmZTYnFKAJadzg5WR9Kjlkp8YvIKQi?=
 =?iso-8859-1?Q?xMeaGgkWpMD3Bc3mJ9nH0N8DAr5uUcu+JP/96n5mxsFQt9klAXiRqRKY+6?=
 =?iso-8859-1?Q?QLswXR2j1QZRSM3S44HyxmZZHgkF3nMXP/XTCl06UUHALUcLG5loQs7hwr?=
 =?iso-8859-1?Q?wo/uLijowsLnPzMuDl3zuexAL7CwkHzXNY1e5XXiX5VksAwWyPgm0C6VpN?=
 =?iso-8859-1?Q?7iBPUizOuwKId4kJ5K1Xcdi2kOm8UoJ6QKU5IftUPWVEy3lgLTi27JmbUp?=
 =?iso-8859-1?Q?0/HvgH8/QD5f32jnKu1yji071XS4U129/RB7Vj7DONyqXsgJoUBZ34RM4q?=
 =?iso-8859-1?Q?MAlv+N1TcrYZKW3tTdULOfszUHTaaS86U5piFk+T56WXpWOQc76ifr4ipZ?=
 =?iso-8859-1?Q?FaJm5iSylNJ8yiC1Av9BNWIToIicL+ixRLLUd8saVVV5f8G/2ZDzhORvDp?=
 =?iso-8859-1?Q?rBOWcTiTWq3sLeSSFB5wUKcC4fndtJCSnCuCN/zlcARw4ZoSz4ozpSEYAs?=
 =?iso-8859-1?Q?R17BuSJ6sc7vH5eR4OtbjOx588+t9mtV1yfvxXyIlU6DmbGkJnyLe2uQfA?=
 =?iso-8859-1?Q?eo40DJ+qECDCMyCQl+9UTngmftNMHJLdJUafXLDLllwMvCZoZ5OCgaCKcW?=
 =?iso-8859-1?Q?AATjBwhp1FIyYR8uVUdcB0YIz2o+RImN4BC6rV4rt2AM/OOwPoayrG0Vps?=
 =?iso-8859-1?Q?vsJZPDEV67VmAwu3NZky/CGlRTib6ORl5ugyJE9LRxmCcGVhr0MplCBlix?=
 =?iso-8859-1?Q?Kr2ZxRaq5z50at0XRonmeNOsqedygYV6g3ufPlzHFuIqUWgam2FedU85iE?=
 =?iso-8859-1?Q?xTp+68iebT/tkkR4DLJVEYdFSv3ShRZVfQZku1pPaO75VfdOquiR1WTYLH?=
 =?iso-8859-1?Q?Q8AnRleZWUY9Xf+BVYSnVxozVqCIuWVQYViiXfD9R4VQhLcYCFv/pz6FBM?=
 =?iso-8859-1?Q?rogSboLazqAUyRBItNsHaz2YgqKkxU4euXVTyiozMvbcfHrMp9/mVQ2NXk?=
 =?iso-8859-1?Q?FEVSMigqDkophRsB7HviALd/PGuZ64TuHT3jQqMmSxMvkF1eAviuyuiSWU?=
 =?iso-8859-1?Q?6P2iY7V4kKxnJyrsDcBlGQmxZmsEmQ67SHVO7DMSqfdEbfwIovS5zursyd?=
 =?iso-8859-1?Q?HWRR1wM1IHhDMUz+2iiz5dGD5/QDXkUhsbegaZDGOf9dyIwLpc0BqpU38J?=
 =?iso-8859-1?Q?mkCCUjt5gNYaaZ74SvAZAAJJAdShPJ7lE/csXLnq4JtRmWmv0lajDzDAsx?=
 =?iso-8859-1?Q?x+y5sVoKVCESe2EiyLrq83cWieT88fbSJtoi6HX2cNe4jbaxUxj1mMNrGZ?=
 =?iso-8859-1?Q?0pvz+tnsVN59zpEKm5LyE1VeoAul8eANMVFSnA4P1qmiWpqYs3sGNDtDCT?=
 =?iso-8859-1?Q?6vvmRoeYexmzQUdyygkxdJJai2D9CSOH16ov/2Dna3ZdA33D1YyIxLmE3Q?=
 =?iso-8859-1?Q?4UA97TOKQVDECAONvXoa9NaxqIhe+O+xiuD1jK8dMHOBHwvCfsAIWyx0l7?=
 =?iso-8859-1?Q?NrnTRg4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/1eCARBTlN57RLhIUw2sE0MoP1U5mSTsXO2e6Q2/9Gu0pDopTedLGhvgMS?=
 =?iso-8859-1?Q?aC5lcO/EAxvRUJEQ5YK6KsDB90UpqDAunUnVzfFioKYryZcDGPg5u3oLPQ?=
 =?iso-8859-1?Q?TzPYERuCmWqRf+YASYKUdrz3k8u+h9jN06BtQy6EeVOd9GpS3jEzx7lpAy?=
 =?iso-8859-1?Q?KVNW4F04ZoV7S9UxFTM5EkfA64veDiiA06jkLuYPPNWlq55puuMRXkPF5j?=
 =?iso-8859-1?Q?7XE0XLJnub4O+1aqKI97szYnCrjgqALW3TYio+xdLZCof04rl6/21zyWw7?=
 =?iso-8859-1?Q?j7DKW8CQSuUi+E0q+HZFtm1dsEufSuv5271UiZQ6ZaA5/F09aGvt12p3h9?=
 =?iso-8859-1?Q?rZ0T9u+Zotak7Fcbufq5xhZ6yxxH9To+iVGA+vExzrsabhqH3X1md+Yo/J?=
 =?iso-8859-1?Q?lYHEtBIDxUPntukRPVoLAxxGXWEFFlwrdPu0Oih+r2Z/Dzpi3TvBbQfAgm?=
 =?iso-8859-1?Q?zXIJPLbH60CMZXOZCv9g3dXcuk8hEw4ZDl0shFJeurhCsf88670Qj9VTfJ?=
 =?iso-8859-1?Q?JdKwDOchCLNy/+SLrIYF5zgla3IAlFen/JCDQ4hb/u/ZkTGLqqzx+Kzj8v?=
 =?iso-8859-1?Q?xDUFTPIVRbP1KlJMV+V4TLziTObL80313BHwuqqs3j2puhAkcPl9lbKqd8?=
 =?iso-8859-1?Q?syEAm31/LpUwS8asIDhbKZ+gep2nJJrrmhKjn6I/SeHHSEmA5CISOd+zMU?=
 =?iso-8859-1?Q?Vtbzeslx8jRbtu8c2b6QpBtCKuo7KGpDa8SWw3RfvRlNlYsOWuXqrAoRFt?=
 =?iso-8859-1?Q?aIXPlwUWAYcYKS0KK5JeKx8OtIQ07VHm1Dc5VK7Ti4sCFwf/7U78r/E7A0?=
 =?iso-8859-1?Q?kW+kHQStHz2YbpngnCabXNwwZTufUjS7jFxOnTGvVXDnLQIAz5f/u53wA4?=
 =?iso-8859-1?Q?8yOP1jAcGUKLkcWzDqzcHRb2aJigZ70qwAXCz5ZXWMGWSqijzbvuO0HK5g?=
 =?iso-8859-1?Q?4uqKYsnklRP3BFmGEGf4Xc9XVqPomHCWehIF6eDzDXzREzm8bhZFh8krfp?=
 =?iso-8859-1?Q?xbE2WRk2j4R3u2xpNCyWxO4sZeM57Xkac489ffY6GF/59IFWFTgxSqZmV7?=
 =?iso-8859-1?Q?gv4XLoiATXf5OMeZQGuRehY3aOjPWk8IqA3XmTJx072g7XEt6VQJTF07DE?=
 =?iso-8859-1?Q?bCpIQuXioVUWYqpfy6ovRYGymxGb9ZIM4+nm4aKK3flRTJwttrMp+Yy8o4?=
 =?iso-8859-1?Q?IppAIIUH/Hz5ISE9sWeGp1T4tZpMT5kjdpJSbf3rWg26rclp69bCVtKa/o?=
 =?iso-8859-1?Q?vbCoyp9x+5IRWEWzG5nBeT5yNMxr8tBJ0cMV43wEIn7P0hk++8tAb8BS1C?=
 =?iso-8859-1?Q?2xOutNTjLJLxlnxnQckaMkDcEHbiB8ow4A5l95L42cKm1D0A4gZ41Pi2qI?=
 =?iso-8859-1?Q?xrcNiXEovbzPLarsH2IxlQU8rMzJyAqeJTfJJmnCDnFcUnsKKnz3PXLCuP?=
 =?iso-8859-1?Q?F78set4bldxwzUkfcbf2fqOnEb3hS8THq2V63wQ2gTGNSOSn8dJjkLduyM?=
 =?iso-8859-1?Q?0q+JLyTSsBgK4dYIQOIiXULgcbkByM3KIp9rO8NeJaPTTDPxvn/PTIRK1g?=
 =?iso-8859-1?Q?TM03nt+faXpfxN+uJlHKQQZEQ83rHztLGI/9M838gcqrSMzN++15xYJgXR?=
 =?iso-8859-1?Q?rwv2JjfUUyGvngg9fKNtPVkoOtPxS+4+BvT2QMrQLhujGXYtZJaFigGQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f30ed57-0320-4af5-3efa-08dda2a3f00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:38:34.6444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55Nijz+NzIS7+uIpzvrH1TXc8gwj6ZeiG1lm8aOz/QG1Uo6Ou81QgNVWne6qii6D665ueKPsdrljg/Ov2dU4aK2fZwCUrCN35z+0FMJG8NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6623
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add a GPIO driver for the Intel EG20T Platform Controller Hub, which
exposes a set of 12 GPIOs via PCI MMIO.

The driver implements basic GPIO operations (input/output direction,
value read/write, and function query) using the U-Boot driver model
infrastructure. It maps the required BAR1 region via `dm_pci_map_bar`
and uses internal registers to control pin state and direction.

This driver is required for platforms using EG20T, such as P8700-based
systems, to access GPIOs through the standard U-Boot DM GPIO framework.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/MAINTAINERS |   1 +
 drivers/gpio/Kconfig                |   7 ++
 drivers/gpio/Makefile               |   1 +
 drivers/gpio/eg20t-gpio.c           | 138 ++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/gpio/eg20t-gpio.c

diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index e350121395e..bc59a628c79 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -7,3 +7,4 @@ F:  arch/riscv/cpu/p8700/
 F:  arch/riscv/include/asm/arch-p8700/
 F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
+F:  drivers/gpio/eg20t-gpio.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e11109fb56d..3a45c1e1158 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -731,3 +731,10 @@ config SPL_ADP5585_GPIO
 	  Support ADP5585 GPIO expander in SPL.
=20
 endif
+
+config EG20T_GPIO
+        bool "Intel EG20T GPIO driver"
+        depends on DM_GPIO && DM_PCI
+        help
+          Enable this to support the GPIO controller found in the Intel EG=
20T
+          Platform Controller Hub.
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d64c14db5cf..23b18401f9a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -81,3 +81,4 @@ obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+=3D gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+=3D ftgpio010.o
 obj-$(CONFIG_$(PHASE_)ADP5585_GPIO)	+=3D adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+=3D rzg2l-gpio.o
+obj-$(CONFIG_EG20T_GPIO)	+=3D eg20t-gpio.o
diff --git a/drivers/gpio/eg20t-gpio.c b/drivers/gpio/eg20t-gpio.c
new file mode 100644
index 00000000000..d41ca4bfb17
--- /dev/null
+++ b/drivers/gpio/eg20t-gpio.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <pci.h>
+#include <asm/io.h>
+#include <asm/gpio.h>
+#include <log.h>
+
+enum {
+	REG_IEN		=3D 0x00,
+	REG_ISTATUS	=3D 0x04,
+	REG_IDISP	=3D 0x08,
+	REG_ICLR	=3D 0x0c,
+	REG_IMASK	=3D 0x10,
+	REG_IMASKCLR	=3D 0x14,
+	REG_PO		=3D 0x18,
+	REG_PI		=3D 0x1c,
+	REG_PM		=3D 0x20,
+};
+
+struct eg20t_gpio_priv {
+	void *base;
+};
+
+static int eg20t_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm, pval;
+
+	pm =3D readl(priv->base + REG_PM);
+	if ((pm >> offset) & 0x1)
+		pval =3D readl(priv->base + REG_PO);
+	else
+		pval =3D readl(priv->base + REG_PI);
+
+	return (pval >> offset) & 0x1;
+}
+
+static int eg20t_gpio_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 po;
+
+	po =3D readl(priv->base + REG_PO);
+	if (value)
+		po |=3D 1 << offset;
+	else
+		po &=3D ~(1 << offset);
+	writel(po, priv->base + REG_PO);
+	return 0;
+}
+
+static int eg20t_gpio_direction_input(struct udevice *dev, unsigned int of=
fset)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm &=3D ~(1 << offset);
+	writel(pm, priv->base + REG_PM);
+	return 0;
+}
+
+static int eg20t_gpio_direction_output(struct udevice *dev, unsigned int o=
ffset,
+				       int value)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+	pm |=3D 1 << offset;
+	writel(pm, priv->base + REG_PM);
+
+	return eg20t_gpio_set_value(dev, offset, value);
+}
+
+static int eg20t_gpio_get_function(struct udevice *dev, unsigned int offse=
t)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	u32 pm;
+
+	pm =3D readl(priv->base + REG_PM);
+
+	if ((pm >> offset) & 0x1)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops eg20t_gpio_ops =3D {
+	.direction_input	=3D eg20t_gpio_direction_input,
+	.direction_output	=3D eg20t_gpio_direction_output,
+	.get_value		=3D eg20t_gpio_get_value,
+	.set_value		=3D eg20t_gpio_set_value,
+	.get_function		=3D eg20t_gpio_get_function,
+};
+
+static int eg20t_gpio_probe(struct udevice *dev)
+{
+	struct eg20t_gpio_priv *priv =3D dev_get_priv(dev);
+	struct gpio_dev_priv *uc_priv =3D dev->uclass_priv;
+
+	priv->base =3D dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, PCI_REGION_MEM);
+	if (!priv->base) {
+		debug("failed to map GPIO registers\n");
+		return -EINVAL;
+	}
+
+	uc_priv->gpio_count =3D 12;
+	uc_priv->bank_name =3D "eg20t";
+	return 0;
+}
+
+static const struct udevice_id eg20t_gpio_ids[] =3D {
+	{ .compatible =3D "intel,eg20t-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(eg20t_gpio) =3D {
+	.name	=3D "eg20t-gpio",
+	.id	=3D UCLASS_GPIO,
+	.of_match =3D eg20t_gpio_ids,
+	.probe	=3D eg20t_gpio_probe,
+	.priv_auto_alloc_size =3D sizeof(struct eg20t_gpio_priv),
+	.ops	=3D &eg20t_gpio_ops,
+};
+
+static struct pci_device_id eg20t_gpio_supported[] =3D {
+	{ PCI_VENDOR_ID_INTEL, 0x8803 },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(eg20t_gpio, eg20t_gpio_supported);
--=20
2.34.1
