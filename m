Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515C4C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA1680BAA;
	Wed,  5 Feb 2025 14:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="e5rr+bw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726088081E; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 335B9807B3
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyACQ25Yk5ExQ1gZECnX+T94lFE1JrLfmY68fV/ZdGu7nLpB0xhXIEWM2p2mmN1JqrQEJLmUGq8H0GXqEfWwMuVRRKyDhKovhEQw4ZuBq4jK4bx8ysL40pjWdnKcAmKyuxBpQ7ns22R4PZoBZ4c0297smp8BD5B0d+4xaDGc7X09NxCV54xRiVCZgCgnJawuGI9WuqM0I+Q/dsrEp1VC3kcwuXZbg7yweppMED23yn+W1v+dTMB75mgrmiaOpDIKjeW+23zl1PPxS95/sPKzx9CvR5q1OMizxDnz3lMZqJVVf5ZoE2zDz+yudXtRus2d8mZAjfwWHng6OCciPyf/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1Gy7+HkG8YxboqW6/HnsLujloxsESxGGhO8scZ+r8=;
 b=jABrlW2kdmsiqgG3N5JXNHSUHDqvG3+8x3CPHZRGi71/c7h1pT537bdBIX1XoYlst+0xo/VpeYsJ379XcIe5VPicUgfHiulpwcWsbsaFO6uOE3OFe12V0x+8i/05pbLmheuFYXFrO9PDILT1yuMFoXO0MzX8F3ZCv/O7UvlgwHmXwyAWSOsKZZT3shDeGx2oW3dJ/xN5/sObmGYfPEMx6yXHgZfIfjZZrCUbhKvQLecYPuxl3PhWyLuRquK0b+FF7VzKMhnWX6+klrDalTDSRKuwNKpVhZz5N+oXWeCmjf5lqtbFZ9OeESSKqyx8A1gnYJcMPmiZUvhagDt1gOWAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1Gy7+HkG8YxboqW6/HnsLujloxsESxGGhO8scZ+r8=;
 b=e5rr+bw2+h1qPmxkHdXEUcYb6cjgqOnBcSceDrKLNIXp4k5xDAuEv3AttYwXBXll6jGq0FMXVHGJsu5kREfbHGjCqJyvlPABW/jZLrGGEH9rmW+l3Qiu/ttU+jLUN3TA24hvjLpvBR9y5Smp3XtAU2kxpGgRa+8JGdfP/iznjpXtzCMFRCgITuFl7qSzf31NolePfIWleLo8porLYgM+NwPUo9zgqp8flETUbmZbi9xOsCXzryvbsyhpAIuuQ/yC3Lvv8xyeYA6Td+N5AKIv7D4czPQzqGsspow6BVmRVWaI3e3NVN4a3hyxArzmGBiADl3qASjuJWwH5XlvwbZiqw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:46 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:46 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Matthias Brugger
 <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 08/20] board: raspberrypi: rpi: save board_type to the
 global_data
Thread-Topic: [RFC PATCH v1 08/20] board: raspberrypi: rpi: save board_type to
 the global_data
Thread-Index: AQHbd7bq307yeOEFpky6emkkj02XGg==
Date: Wed, 5 Feb 2025 10:15:44 +0000
Message-ID: <6709e5412eae9c8f96f7f0394918a12f1d8b8332.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 6ff174b6-30e6-4ab2-20ff-08dd45ce0e93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+8Uk+E0oYYVDKiPGdWeT53clZQ35WWbaPuvz2sdxyMgXXxfuL9+DLH+dL0?=
 =?iso-8859-1?Q?EWPc24jS/6z6IFHLX7fUoLDH+Y4Q8YvfPB/9d3P6+YwdwW2cR4gpQN4SVm?=
 =?iso-8859-1?Q?xaOiX8jActIetYoaTcqRLQIfkLLOlY+76d1RB+5lrfq0Qml9C6XjFF5bRz?=
 =?iso-8859-1?Q?TBqqhV7AXZdfXOPiRZP8m/ppUTafHhOQLeWJwGz9r0exNmALsjwvG3u8c2?=
 =?iso-8859-1?Q?+wVWyMyCngr1jx0vUC1krTu0Fm/SAmlt1P0scOImdjyyYrLYXnO3EkWXAC?=
 =?iso-8859-1?Q?awcK2hEB4rfcUlNa6cVTiNeqHn4yFFi2MG6Dl69PbiA+oAhCsJS0NWnmgu?=
 =?iso-8859-1?Q?zVw4Ic0uZQvRp6XfHqz0/X4JidLLnEcBFHfvgjsbsUH9sM4J4dJ72T19M6?=
 =?iso-8859-1?Q?7US7SfnRW/gVIZBDy33mzpemPppZb9iXb9cGzdS6/M/lZuLLffaexRm22b?=
 =?iso-8859-1?Q?o3TnDXgkBNdh26Bmk6UAlerTUyOOPY+7NoyRDsE4pCW/SL3vAUna4P3HmF?=
 =?iso-8859-1?Q?Zk8gSdDMlRFqXBDPHBlCu39NtAHdhC9WrM2RxL7WWwNg3ASJR4IamuenAc?=
 =?iso-8859-1?Q?b2QNx4ohILIpPnyrdecxjUH3wTp5HCP4uCTS2uUj9hzokvblYQywCPUPC2?=
 =?iso-8859-1?Q?p32S9quMJSA2tv6dhFFFjuTPtH+cnNMHb+kpxGK+mqT7MiMcmx7Y3moNME?=
 =?iso-8859-1?Q?1Wt2CjbVhLqxTjU2idfYxy8BQ7q4aSv6NsSdpdtg+0arpXjrs0rW3qxsOM?=
 =?iso-8859-1?Q?HOZXoEnHpmuk/BMYUXjitBS5/TlisVuG8dSPw64VojOnQpiI71vXhD50bv?=
 =?iso-8859-1?Q?tHSO9R5xGiMokaeSXwn/N3Dx/nSGc8Opoey76GQuJHqkoHDluThVfK2AKb?=
 =?iso-8859-1?Q?oyfjXTk3w7VjdNtmWNEslPCC6lHuPXE2Ej5Ow8pisrOfucViSVg7BuH5Ft?=
 =?iso-8859-1?Q?/a9iMinnwwd/IxHowwX78/cGC95NBtZ+KLHMcy6+fXHVFTogIcTXQNfL/d?=
 =?iso-8859-1?Q?axfA6ppXWnQuDE5cSnvcJlQYmRC0pSwvfTZ1iKsbVATcUFXcIfsxvocNGI?=
 =?iso-8859-1?Q?Quz9Wm0T4ivf0hTTyumx7NOMs/PaKluCHl61a3Ii2Fh3dG9C3NUD+Cm84I?=
 =?iso-8859-1?Q?Vdg0ks0mmCbDuhZKCgucgSQVaDgF2YVkeDyDuhc+lVTLsVdBwt3ZwIfeaX?=
 =?iso-8859-1?Q?qccEAIYzsJ3L1xnOb9MJflEUtt6U+nHke3VdFhEr8IWliyAqXcY0iD6SeO?=
 =?iso-8859-1?Q?rKLWLhx61yxnC35jOQ/w8OLxUs+KwN35I/L3AIHXgQWAlmwwVfTWmUcwJJ?=
 =?iso-8859-1?Q?Zv5PRUeJ8eAF+X6WURBW0a2P3lta+f7K5kt+2yOQorY5CJxxwnlmH/elpB?=
 =?iso-8859-1?Q?Sy5aShmswPkdzedQ1d3qUFm/kBAfyI8UGbx2bBmHhf0EgWtxDSpMzuoGYb?=
 =?iso-8859-1?Q?pJ7dVDLM0tzkeGwa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U2RnxcNti4A4xQjCjfeIxp6M+3iavjuDhi+bw0F72xaN8OkHJKKtxcgtqk?=
 =?iso-8859-1?Q?KdKLDE9BbQxLCoGnI53uuNjL6scxDK4aRPCNblJ9UXwpJ2BVYAM03cthS2?=
 =?iso-8859-1?Q?9zzVvb5xL2jziQH2mv6rOYQFOMo+z8Gd7B4YY+LSnD/m0QWeiE/7ZUyY6X?=
 =?iso-8859-1?Q?ZCYx8uywwhtkP2GRxmJNjaOFiJbZvmAjJWY8cinEYhN65fAdFh03vtALjD?=
 =?iso-8859-1?Q?/I5apD5is1tq2ebvlpcrqHGYwvt2bMk+3dYWNwoyDqdflX1vZpfzrfvJrX?=
 =?iso-8859-1?Q?SVBKnaHhjcywO0yDXL4WSIaaG2SC6qtygvDRN8P4MfONYUhtmWbCkUpdVB?=
 =?iso-8859-1?Q?yXxx6C9kgYGDxsFDW3rkOHoFqjXddy+wgdtuNZh3D/rVQkiedymA95Ujjs?=
 =?iso-8859-1?Q?ZqJ4X32nHlO8+CAYe5Law2FKVUIFksP3kkMLxt6giOajTGObRqc4Dptvg3?=
 =?iso-8859-1?Q?e1GcbxXZHsDcvWFiwmz+tmmtSut18iOQBYXbAGkbK6f9RuksM3y8gxX+JP?=
 =?iso-8859-1?Q?rzSMtYJJ/h7rVdS6Syifr21xernVFXfZmE30UTwxCM+CnEu5EuFc2gocXx?=
 =?iso-8859-1?Q?DCpMEkQjoz8q8ZtwCqOP0hS2zrt2YCofHgjY3+VYXbHGOTy1KDLymDCF47?=
 =?iso-8859-1?Q?XF0pRISt9UhOU7aa90ZPnk6ALAjWftLiRlaVpjS5zipz2m3kSlmjd10/QI?=
 =?iso-8859-1?Q?H0ZksSVvHmR5aOETu+vcmk6wN5HLikNMk2EpQVZ2uXOtF49UU4rn9S/ZAH?=
 =?iso-8859-1?Q?DnXs9J+yhvbUMzZNNghFt5fqe0OILsMYqowx59/MSXYMntkCdE7e81CZao?=
 =?iso-8859-1?Q?H3IAibbH0+LlrSlEuBwr8m4eALeBJXEPboP+i6uvEZciGT9+mOs4qXkQ47?=
 =?iso-8859-1?Q?Je1ymiiEbbTH5pS1/g5Oc/UedOX4iW+WXDC+McQ8OlOrYEY5Lukj561/k3?=
 =?iso-8859-1?Q?xwHbMsSy3kp+OewhkKDltEseXY7W/vGWkqI9JYqbY5woiUGUBb2b/1sc4a?=
 =?iso-8859-1?Q?eGLz/KuzMzPqWh9DMPEsox1drSGiWWGIRZqOcIb8hL7AsfzWYgVkLirhgq?=
 =?iso-8859-1?Q?kA0/2b0A1HsvUIFJ/BOnOOEY3z2/Af1wQPxxpl1M+FsWoje5c0KVtfyuCZ?=
 =?iso-8859-1?Q?v4+7otap5kHh79N0l1OHpURZjw4ZfAJZhLyGqMp9Sm8Yi/kZWu89cK/+8B?=
 =?iso-8859-1?Q?hKTDbTsRYg2NJf9/mD6vTj0cUwAc0pPwoyEza3V9jmVMC3NeVx0gUF/G4c?=
 =?iso-8859-1?Q?wJulnzo0pf3LEn1MOBbDO0i48SP9YBx7318inPzAHG6LwLnh9scsUdJ09o?=
 =?iso-8859-1?Q?aFjtbuScR5lcRAatj7qGNMQ06e56LeCrizmbxIQPUmGg+osFKqs8g0+/4R?=
 =?iso-8859-1?Q?eVHO5zTfqtlFYuuDmJuYVUa5w/Uz54TA1L4sP/q4OlcxgkURXUms4tfvIi?=
 =?iso-8859-1?Q?raXaKtjscMpsVWP5ThODaUzL7VN0t8n8mv96Y0dtWAWjR/RI5ly/d5/ubJ?=
 =?iso-8859-1?Q?+rMNdt+sj6+WiUyObmxcIjmeAb0aI/wyqyX0WCUgICz2LGf6728Z366Na1?=
 =?iso-8859-1?Q?jTD4x82b6yfz8odR30CNL8tToF79DeWl4GsMuwRrY6kPCmkJEQQytJtRuY?=
 =?iso-8859-1?Q?nlcJaVo7FIX8/V2LUAXakfg2wwtAKjeShTkpHd2TX2slseCYip+GHu6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff174b6-30e6-4ab2-20ff-08dd45ce0e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:44.4003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVZYg3ZWTVhL62olpeOmEodxDtHoEyJZe4cSloXuI+GlNr7LhhJ4S/Ykssnq3/wO8FonATOF7fEp+sHzjKBFw/xjytx+IQ4P3yHhXOvTmCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Save board_type retrieved from the BCM board firmware to the global
data. This information can be accessed by using gd_board_type() call to
determine the type of currently used board.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 board/raspberrypi/rpi/rpi.c        |  5 +++++
 include/broadcom/bcm_board_types.h | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/broadcom/bcm_board_types.h

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 2851ebc985..32d67eb7f4 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -19,6 +19,8 @@
 #include <asm/arch/sdhci.h>
 #include <asm/global_data.h>
 #include <dm/platform_data/serial_bcm283x_mu.h>
+#include <broadcom/bcm_board_types.h>
+
 #ifdef CONFIG_ARM64
 #include <asm/armv8/mmu.h>
 #endif
@@ -489,6 +491,9 @@ static void get_board_revision(void)
 		model =3D &models[rev_type];
 	}
=20
+	if (IS_ENABLED(CONFIG_BOARD_TYPES))
+		gd->board_type =3D rev_type;
+
 	printf("RPI %s (0x%x)\n", model->name, revision);
 }
=20
diff --git a/include/broadcom/bcm_board_types.h b/include/broadcom/bcm_boar=
d_types.h
new file mode 100644
index 0000000000..69db528874
--- /dev/null
+++ b/include/broadcom/bcm_board_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header defines BCM board types.
+ *
+ * Copyright (c) 2024 EPAM Systems
+ *
+ */
+#ifndef _BCM_BOARD_TYPES_H_
+#define _BCM_BOARD_TYPES_H_
+
+/*
+ * TODO: This enumerator defines the main BCM types.
+ * These types are defined by the BCM firmware and requested
+ * via mbox. Currently only one board type was added.
+ * This is needed to determine whether current board is bcm2712
+ * or other to control the behaviour of the following drivers:
+ * macb and pcie_brcmstb. New board enumerators can be added here
+ * if needed.
+ * See https://www.raspberrypi.com/documentation/computers/raspberry-pi.ht=
ml#raspberry-pi-revision-codes
+ */
+typedef enum {
+	BCM2712_RPI_5_B_NEW =3D 0x17,
+} bcm_board_type_t;
+
+#endif /* _BCM_BOARD_TYPES_H_ */
--=20
2.34.1
