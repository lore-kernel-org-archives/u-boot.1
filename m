Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C2DF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCF58440E;
	Fri, 17 Apr 2026 14:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="kOmmOUkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D577D83EEF; Fri, 17 Apr 2026 14:26:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38F6841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT1JAstbVeuXcpQQfq3t+AIY1SlBL4AuxOE8wl7k5yNxsUxDFSo8uphcUVeSBMjxbmsDG2xozISmjJYB/FAbKuW1PpWXdUpUlyYQEDcCMykKrKbfhvBAnAcrxdvWYyZcTIkFcWznAwSEEYxrMpG/WyTldzfxkloN/Kwo8Qc1j7FYIc8JXBtlyld6qxpfKcGUHFd+/1Bc5cQdWdzQPDsaN5qrMe5dZ+JlnF5qXTa4LZNnPFMOa1kD+xxjbhOnF+Lh5NV9qeaeWtB87PNq0MeJnmankPUUqe3cPezMtta8j66RTiPgr3wv94O4vU8wh3S1oPFtVJ8NX+z8jdTbKjlvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzXuN+l0kB3XarvRYMb+1Ko7WA04I3MGfvCVezSGppA=;
 b=Klm9o69dJYnNtes2VMkebKmZw8X/H6H8LthatvzA60Z0eHjAodnKQbQasYT/WDKXVJ1ydiMVGkWQlhZnStwSaSunRR+Im+s9PPRfMyTBQSQgiq8rjF2x99aTjBjdMdtD6WO7U0rWZaAluihe5QGc4jLBKxpFMGZjyJr+L+/O7IReN60VvbtTOT1r/l0fAGjaWkpdHD5RKBgd8nVlWsMEVlqMaPTV3Lv9Rd6vIrbDIy5SvlpBti1e6CWJ3O7KQuK+zsNclFLA+zHAlehM0ElW8CrCd7qfFWLgEdQpxn13KDX0Pekr4dZQM5lXSeokQPR32cXq3bVbhS0prJC6aGr6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzXuN+l0kB3XarvRYMb+1Ko7WA04I3MGfvCVezSGppA=;
 b=kOmmOUkWVMVOneLVHQCLjjvRtwJ4YaBVniWKgAuXyjhMDSmIWvOQPlSsGoD8XQcb9wWdUef+ENWQ8M06hPFZx3uWagKi/5UYXVK+Pb/uQQC+ys57Sk5Qq140Ge/aybaDYRG2/d9Sdp94DWqq8fM15QkX7E0Y7vMTIw8OQiSsUEY2Jh2cPXsRDFB3S3zXFXR9nIhpnfrf8uO2ug9hpXfVu5JMND83URGPMSMULtW7nPnqiMuOobN4eV6LhrVsWAW3TOi2BiecqQgKjOiD1wo/G/hwhKsswSMyhzEg1eeIEnCAWW4tN955V3i1a+GS8mvLsyqvnMG7g7Z398zPcSf+bw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA4PR09MB4525.eurprd09.prod.outlook.com (2603:10a6:102:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:26:18 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:26:18 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 5/7] riscv: Add syscon driver for MIPS GIC block
Thread-Topic: [PATCH v7 5/7] riscv: Add syscon driver for MIPS GIC block
Thread-Index: AQHczmVkE0ki6d98zE+BpmVmcYYKQg==
Date: Fri, 17 Apr 2026 12:26:18 +0000
Message-ID: <20260417122213.147529-6-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA4PR09MB4525:EE_
x-ms-office365-filtering-correlation-id: 531f6abb-6e30-43b4-c1f3-08de9c7c86bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uOlfdfPBpTx6XH+qIe868ATW2nEi3zeHC2X8zQHb05YW3yh6QdJaGyQ/6dKmRfGzFvYkon/6OWRK/JPqdh35e6VNJcKlUW2jfZIZVEGJXwizj/JhRw6c6ZMWhscYd9QSTXVP+Q9q0OaPHEGugDvWeEF83mmmoa89IkZ+vPz0FEuOmHOYGn+EiEOUffdiSnz4j9i5L1Scie/5JKQXCZzlPnA2gEIHQrzTXQ5avBt+mCMbzqBxmDXpnMmpEdlvXzZMgYPFY5ZOZ5Er/cvUBo1VzmJPUBS2XvSB7ydT6xO3E2Saz5DBR/ZCyJFGFdz0LwO12VjsZHNbYWH2rcS9I/0xl0K+KM4m6i09K59MxxoxhRKQm6aGb7yJaAi+GW53wrpvfQ6YPv7lLE76+7//+MljCN8Niui2qCnx7XLGDf6zNMTbctll0YZ6QJw723d7DUE9WidrrvwMmo4dwxoQNRvQDDu16vjIx56mFvpvU76RzRuVENaB0zjsmCySG+l09LJs5SYF30rbDuMYYkwbvR8+vJcqEGNv4XD3xpszkPcySEbhVpqBRNnYw8IurOuTQmodtbcIoDxiwUG4XeuWzEyr25UQub5jHr0p5Bn9e+RfyKJLq12p9/oQsDLEotgD5275pGINtdNYfXH4shG+dVkiJV/FLcUlYN5YmZNmufoubFBQQ4O2k3BsixFSYesfmk34oHBs8Hc4Ca6NLnhxjiBDMWUQ6SH9GLoNG4OTekwsVf3tmoKfbhfWL3oG59N1lKTqR/+vi4PN4tnKOJGG6dZWLR1IbPITK8sflBywI69jbUA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+NUVc6dY2OYSjDjecdd5gfVAaOCkqAlGp7rOYtF827WBx41ko0X1MI9OZR?=
 =?iso-8859-1?Q?XF158HGIqiWCQIgDZHGXlcOsjedXuhpmxJRtowFOLX/LzNwLYZg3FVPktJ?=
 =?iso-8859-1?Q?zRGs7T0gnr5X9S5D1/eybuWRExSYoYhcXOFbUY8vm0iNhnHp/PCGMLlwll?=
 =?iso-8859-1?Q?w+T7iRcQ1Tt7FPuTyClinYAYT3g0KyXMUQh7vVRbrUiROgTEEDCKoRxILB?=
 =?iso-8859-1?Q?IT6A768y90/WgYZffq54R2Y13rv07ay4cGgYHa0B99F6NlUU0AcGfSIPJ9?=
 =?iso-8859-1?Q?ANbczuya69HotaJnFK4geqJe8RSky2WYNjysp/rKZKJUdEZIBoCzmHHxDB?=
 =?iso-8859-1?Q?KEM4UbA3Oc+edv9zt17t+gXnRK5PHmHrWMMdjRFWzMf4o9c2eZvQMJIKtw?=
 =?iso-8859-1?Q?eKZdth5wTqu7ep9ZeVsrekAfvQrT+NPitd41T0f80j2tZB3ODL2154i+Th?=
 =?iso-8859-1?Q?oacx6sU2wWZDiexIjEGXAcDiLLicwPDJx00VtvBILtqxLldfwwerpPSmii?=
 =?iso-8859-1?Q?4fpcWzNMuQw5iNfqqO9TTgH6kRHVcmAQl1qgSSpkdT3zQTLFd9aw3OE7H7?=
 =?iso-8859-1?Q?3ccqQhRj+qpOuKJCSn9R97xbdJT/3lHVKo+I+CQzn+0y3fZgWAmhCkgrLK?=
 =?iso-8859-1?Q?eg/ygfqwewv8Rd6Jt5Tp0Xz1KMu9EZrykF0I0bMpn39jKcN+kJp/IioT0A?=
 =?iso-8859-1?Q?gQ6/4vnXuc3MoetJAPOgTvuH7urCHIBY/hkcIEnYn7djRaV3OtG1bgF++t?=
 =?iso-8859-1?Q?teinxV4aKxQ5bktjTPf8fVuWDVOaR/VD+A1acL3YQZ77w9hOBV00IVFMEp?=
 =?iso-8859-1?Q?1d3rJBzwmpC9ycrdmPfpQ98kgq6xKQC1BCk5WG5LmKEN5egWMK31iwdGOb?=
 =?iso-8859-1?Q?7HJhm6VXlkiVM6vaO7dC7m3RDlSextUTNuXQ861gu+wpf027XS0NO8Ui1n?=
 =?iso-8859-1?Q?P0KcQJqEqpLK0M1mQhZVwV7a4p0AAawjYN/IERexar/NZJPtd/vzFOvBbn?=
 =?iso-8859-1?Q?H2zY5ro7O7y+tj8FgY8f3sYh5hovIIHFhp2L2AI8+RKwKD9MzNl9bN442F?=
 =?iso-8859-1?Q?ILZFDmNwzNm5Ew4pRI8WUtiuxxr7KnL3hydPd4vmU3ZvaQJP5w9I0fbhb7?=
 =?iso-8859-1?Q?F4MAGBkoOWHGH14HklKY/FX5DC/I2pfSVF5MpTbs4TnLpjLfVGnUIEwMBT?=
 =?iso-8859-1?Q?OParBAWwA4xQKfiO3Uq8DPVTWHSNSspZBhfQvAX6ShB/hmKNOqgqf1ICxa?=
 =?iso-8859-1?Q?q72PdpDZ/7w2rEN+2Flh0PSoFDRzIZYoBKFEa7ZGi6hZ4zp7gNWE0GCZiG?=
 =?iso-8859-1?Q?0wStJeQm+bsTC4qz1bbV2a4X5s5vRXO9BirT4/qU+O7oMfcbMxIeQUVWgc?=
 =?iso-8859-1?Q?iPCYdHNpwOZOfQOrTOcRUMgBnGYGwXyvru9jYQATxd4mq5LGZArH3bfBYt?=
 =?iso-8859-1?Q?Y/QGpRMioM1frL6dgFWLLAYDPwPirIsOt5glwnBriLzh38ObdLpfJAKGlz?=
 =?iso-8859-1?Q?RJfRlVfPEIV2Io22jpah/f1P3rptK/IrJF0wlGKNNpfnhv8JlsACJ5YARA?=
 =?iso-8859-1?Q?D9Sl/Y1McO+mUeuti/6swO5Y+UXP0Ee1m5Emcg5mfHx7GjYFr3TG8Y4UBx?=
 =?iso-8859-1?Q?i7atZkF9lsORj/fpAFcbKSpRRqgGVL2fjKWOwxe425VT5nzscSUzccVroi?=
 =?iso-8859-1?Q?r5CVbVqgHPpJ5iGax1Jog9XTPISQyy120FAOiQaNLLSXspKVc4quG4uwv8?=
 =?iso-8859-1?Q?e+2ULi+zpVh1lWVlaqANmv8oKUzw0EpxRIFtvmci5XFPlaz16/VhnJRKWw?=
 =?iso-8859-1?Q?aVzBNnAKvN96zv+fDUPQr65WMGtIIxU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531f6abb-6e30-43b4-c1f3-08de9c7c86bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:26:18.3534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cH9pUQBc5d2RkwYDxdgNWGrvVNKjYETYXWOyx1E6Yqm4frwfNZ1bpdh9AMstJsBvfSqo8sjwbq2vBliYjIUNCtj2c5q1pq8OC7ULqJhz4lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR09MB4525
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Add a UCLASS_SYSCON driver with DT match for the MIPS GIC block, so it
can be accessed via syscon/regmap.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                  | 11 +++++++
 arch/riscv/lib/Makefile             |  1 +
 arch/riscv/lib/mips_gic.c           | 47 +++++++++++++++++++++++++++++
 board/mips/boston-riscv/MAINTAINERS |  1 +
 4 files changed, 60 insertions(+)
 create mode 100644 arch/riscv/lib/mips_gic.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index edb5e6da10b..df2f4484b00 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -412,6 +412,17 @@ config SIFIVE_CACHE
 	help
 	  This enables the operations to configure SiFive cache
=20
+config MIPS_GIC
+	bool
+	depends on RISCV_MMODE || SPL_RISCV_MMODE
+	select REGMAP
+	select SYSCON
+	select SPL_REGMAP if SPL
+	select SPL_SYSCON if SPL
+	help
+	  The MIPS GIC block holds memory-mapped control and status registers
+	  associated with software and timer interrupts.
+
 config ANDES_PLICSW
 	bool
 	depends on RISCV_MMODE || SPL_RISCV_MMODE
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index a527b3e9ae3..f0f5e40a20b 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SYS_CACHE_THEAD_CMO) +=3D thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) +=3D aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) +=3D andes_plicsw.o
+obj-$(CONFIG_MIPS_GIC) +=3D mips_gic.o
 else
 obj-$(CONFIG_SBI) +=3D sbi.o
 obj-$(CONFIG_SBI_IPI) +=3D sbi_ipi.o
diff --git a/arch/riscv/lib/mips_gic.c b/arch/riscv/lib/mips_gic.c
new file mode 100644
index 00000000000..7d761c58e74
--- /dev/null
+++ b/arch/riscv/lib/mips_gic.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ *
+ * U-Boot syscon driver for MIPS GIC.
+ */
+
+#include <dm.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/syscon.h>
+#include <linux/err.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int riscv_init_ipi(void)
+{
+	return 0;
+}
+
+int riscv_send_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_clear_ipi(int hart)
+{
+	return 0;
+}
+
+int riscv_get_ipi(int hart, int *pending)
+{
+	return 0;
+}
+
+static const struct udevice_id mips_gic_ids[] =3D {
+	{ .compatible =3D "mips,gic0", .data =3D RISCV_SYSCON_PLICSW },
+	{ }
+};
+
+U_BOOT_DRIVER(mips_gic) =3D {
+	.name		=3D "mips_gic",
+	.id		=3D UCLASS_SYSCON,
+	.of_match	=3D mips_gic_ids,
+	.flags		=3D DM_FLAG_PRE_RELOC,
+};
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 8b95f53ab32..47f2dd180b7 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -8,3 +8,4 @@ F:	arch/riscv/include/asm/arch-p8700/
 F:	configs/boston-p8700_defconfig
 F:	arch/riscv/dts/boston-p8700.dts
 F:	drivers/gpio/eg20t-gpio.c
+F:	arch/riscv/lib/mips_gic.c
--=20
2.34.1
