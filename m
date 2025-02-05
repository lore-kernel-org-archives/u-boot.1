Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07840C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B38B80C91;
	Wed,  5 Feb 2025 14:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="oPFqlX/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90D980207; Wed,  5 Feb 2025 11:15:58 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E248078B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOIa61AErcs3euwjrw3agqPr3zHQ69QP10g6pfyUa/Nhn3mQmsbabodEGF013WBCv0uL8LoP4th64s2O67lPvz6B/iHSkosHx5L5lf4I/Nrd6pYyNqr+0bsswiGTGpE/wmPIBtWn31qBUXjDbDfRgbepwotKwXGkbcCqwpHsCwlWJA0R8Uq40ZG6+vl1XUuj0AXiQE/jy7dRFfCIotQGdng+MWZm1t2e71lbC+9w2cM4KHR/xT1er6XKz1YwykCuLqAMn7nQxEyqgoIHzWVZCxzec3TlYK3Ycc5YtrOcoZkiflq77SKoPu/ok1wRqCM6iGo+/gFEiabHNMEV2og7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NOwGE38vAR1HAYfm/K7ie0r7M++9OF4RLlWWyIQ6kw=;
 b=Ssfk1ijezoQUpvWxSBXnBiPpAgBgu7L+5XvOw5a9HAKbAiI1Rk00q4IhDFTsD0H68Xw8Pc3M/gRxhIOmyQP50TBSxSGTIXITeOHit6KmVEpkPGtqPxaLMyM53FFnZmPAoA2FdVagTE/+HB9N560Oat2SkFZItsvI3euSY5u3SLwkaKqKmWadex9XQPZo7a9/MWdVxZsMerWzvmXi70WE6IDdeJzYGlg/7J7VXHjOx9Us4Qy1v16CNqXinR1qEXVwEUAwZKG4yDgqFs/TJIKk2D558D60VEF6bAZRh34Nqx7SE1Bn4Dm+Q3KVNg0Yp/D93JuVzLruMZqvwuztC/fi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NOwGE38vAR1HAYfm/K7ie0r7M++9OF4RLlWWyIQ6kw=;
 b=oPFqlX/Vltn8En7AE9KPmW9XsuWkHGWH9ZyjoxeqYnfEeEDVa1dDCyVfzJIPUtmdCgLUIiwSKMWx8S13pBNjkI5K9PIyYQOdkRcAzUBeG2jLbfu2AZ4tF66w+MqlnvKlMTHOPJ7YjAN/R+sasbNIyJhJWTIz6nk8C6K0e12RN5v40kmQxbUWSEvzhHGWNEFMz8XYXGB0FFSBa5hXMwVI5+Q11+ingOC/PggrhImTQs1mi8Y6EudIKxKZvO7T9dJHGdFFb7OUVhxzm5bE8C4lvX8/Z2ZUOXL+zBDQZbP9aCKdoRjcB/rJgqX8I+4r6EwPf/tYShEK3xvbKOCNfZ5vlA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:49 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:49 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 10/20] drivers: mfd: introduce RP1 chip driver for RPI5
Thread-Topic: [RFC PATCH v1 10/20] drivers: mfd: introduce RP1 chip driver for
 RPI5
Thread-Index: AQHbd7brA/0KT5zznkSdn9H7mkkvNQ==
Date: Wed, 5 Feb 2025 10:15:45 +0000
Message-ID: <63a3407abc16d3f6ea854fc3b95a131c1d245b5d.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 5bcc5b65-7bce-49d7-cace-08dd45ce105c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?75c57S6WUWzpxttgHYsykM+1H5d912yze8gSPKdbXExpGtQ1hRTnl+6O8e?=
 =?iso-8859-1?Q?CgbXgMzPZzN0GG74J+lNuLuM2OlJlq4Pl6HTMNaPa9FJEp1EeTSXC5vYY8?=
 =?iso-8859-1?Q?S546qFOXBxQ9kOiQiJuW4Qjj5ju4mwRItnzruHoU0OICcIPlVWMGfx66W9?=
 =?iso-8859-1?Q?D9vyN4XvxRs/GJ/+fTiKm/0kkj22kSJTJDHmxsuWJpkAymVprPPU1eMDrK?=
 =?iso-8859-1?Q?PTAABENlANYkWzV+D7XAngdH7WQfxeWkMjkNiBsh+uxqkOgxJzZWmLYwi1?=
 =?iso-8859-1?Q?zjPO9qtRDqn9XT5DFTUE84uCbrHaJKQL5dmzWXVNjT5THpXoI3obeVUu+Z?=
 =?iso-8859-1?Q?TT0Hz/Onsv6VfcUUADFsZZfzy2l0NVIaEWSKlUYr58hBHz0JjaAZDE/s7q?=
 =?iso-8859-1?Q?s3buZjglRw7xqqjunKmWQzWfdcMgvkPx9B8wauWXAzcaL8kUfqrmbJbzX2?=
 =?iso-8859-1?Q?NM23NsdZYi/EZ/cylS10iAxBVI4F/alE/+WVKDxZKJpzQC8e5KnuuWZ/ht?=
 =?iso-8859-1?Q?B8wvggU9oeJXK5ni4vDsyZf0npEXz+c/XGJYSdiOuzpX8j+2MAl9Z6S/hD?=
 =?iso-8859-1?Q?BkZG9DrWKG0PI5PuOb5OLYSoU4fbmqnMcUSObPke0BijOSCta8bMTHTLvD?=
 =?iso-8859-1?Q?d4BGIhxAvT1fWV5quueuUG3RmMzCGGqJNnSN0yVUl5uzmq/Jj3IwZ2bp9j?=
 =?iso-8859-1?Q?SxSPEMy3lzYZrF978DjurV2mBhV5jZFbxfu+hGS6qEmWOhT90IY4RZqdKc?=
 =?iso-8859-1?Q?99yP5WFj1O06+q2lhUkQQx6Bb1DJaoYeTbNjurayoeu4mayZXMsGQtgnX0?=
 =?iso-8859-1?Q?JZjD8kpWWy3Gr/8+KenVdItoNR6F+e6nTl8sOQIDQ/8B2jN+A2OFNB01uD?=
 =?iso-8859-1?Q?NAmJVYLPuYLx442dXHlsrUP/2n/9Mau3qCUCErMKHTsw0RiHaOUB0F9NAj?=
 =?iso-8859-1?Q?yrf0pQ3209Tx4WBeOgqxmk0spK76MwyIGAAzzKvMPFx8Gx3z+F+5euHY+Y?=
 =?iso-8859-1?Q?vgGx32T1ymlhcJFdYt4R7K8TotsrZuKu47P/wTst8LboP2klfPXu7tz/Aj?=
 =?iso-8859-1?Q?d73YGsseYODf+2ZbzvqGSbUv3RJY5m768VoPoYSY0qeDnO5agmh/X+kajP?=
 =?iso-8859-1?Q?T094Y38KmmY9X9OXdaKRuncpyIbpKXh13OibusaNmIR+Ttdd2mdS2bMA7D?=
 =?iso-8859-1?Q?HgW5rWY0qqO0NcbqZJXmFNQUj74udEu4MLf8WkvCpcmx0faNJO8wgWSveK?=
 =?iso-8859-1?Q?Tu7KqQ0hlPsrp01ivZj2+5ie19zi29jkiv0le7LUmFRO9ydG3+xH/stzqU?=
 =?iso-8859-1?Q?/hoatQSJm3LYEc1g/tgGHjbxtHfoEZJNQRi5Lmy5/akd5tkW+qnCWI8v0p?=
 =?iso-8859-1?Q?YzBhpfNw/YHQnc4k/+vqkgx/YgyxmBKWmaggRQYsrTCs5nBItuLlYJZ4A1?=
 =?iso-8859-1?Q?BHfM38WG+u8MKK6X/9WZPxC4bUw9NdVpp+f4BGdKZMTvd+vRzN4LFnY2fn?=
 =?iso-8859-1?Q?GHKiW3NHWCvDh2j88JU6si?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3QiBSi8ak3wKMfeh+c0mPYMdIplbYyhtWbde/tJHCVHSn5peP6Qw9XXi/s?=
 =?iso-8859-1?Q?/U9s6wjMnD85TGjOewpfNbljpTyc2LUhgO1lsIgy/1u9cN2sBM7cN2/XSH?=
 =?iso-8859-1?Q?JL/k14KAfbWeyRJsKC9L1/1EM42fMo0rEvK2fR6WcYfqYFuONjNev7fm5K?=
 =?iso-8859-1?Q?WvtUBTqpZzuZ3i4A4FNd0gutfdISPkcDh82JDuA+BOaAZTvrCIVw7ENYYL?=
 =?iso-8859-1?Q?uAq+gmEgrQOMweSTI4bCd5N1LVNxBj0BwE4PeRTeB3+WANg8AA6xrj0gzn?=
 =?iso-8859-1?Q?TH1zaBUantjTAUELmwnwMm/e7viLKQlXhI3xy48eU7c7McLkphZC/Xdphb?=
 =?iso-8859-1?Q?9dCFMX0PzJv5/L8MmtEN7Ax5lD7/RjXnC/Y6gj9lm4iKOVrlqZ8s9u1HMa?=
 =?iso-8859-1?Q?IulP0z2C6s8l/BN3hpXc+vV34ku30Ll12t6WuhZrLBmEwMPWclHF9uIFNH?=
 =?iso-8859-1?Q?KKZC23tCdV8IgNDVYyS2pHos14pgipJsJc6JvbsVGawssYVbE0K+zyFWyw?=
 =?iso-8859-1?Q?Oxg2vHXe0DEIWIVsQwRMhv+bv/EpEGYwgPMEH51dsqztXlz9/oFjHGoZRp?=
 =?iso-8859-1?Q?7w/x2zGw5jMinyjhR2zDhqFWd4lMii/1CA1TI6rXNpuN2Ui4UaEe1hygO7?=
 =?iso-8859-1?Q?8qAWELrUu3QjJG+luYWcpHkEoCfwP935qEknWR46tom7o+YXvYtTx1SS28?=
 =?iso-8859-1?Q?wceUyqc3Tw2hjdIcOhDJVmhWNgVjw69yPqmUIWxpOwlZkleCLaokLYbhEf?=
 =?iso-8859-1?Q?KnSu4X7JmyuH54b5svmfRtZbUAZjDxgTkKRLuA3fLG4NpmDJ1ZXYmzTzH4?=
 =?iso-8859-1?Q?NNVhFw6RtX3PULu3u2jcvH4lcXe7Q0R20PwikwRQI1ecGT8ZmUc4usrQEd?=
 =?iso-8859-1?Q?yc8BhMG57bi0ux109jU0cGAO7z3f25cMcc1MifVy7AN/VgQS/Zbbg533dX?=
 =?iso-8859-1?Q?DOd2WnoLtcUtRjnVEUpZthZubc9xHBXg0dMQsG9r8OYzUlO+MuwrufqPYX?=
 =?iso-8859-1?Q?PWzQxiDD2x1+AUybfeLelTZvEUEnG0R967DdKYoVCEw0eMweMw07gxo2zr?=
 =?iso-8859-1?Q?KWSZSzIxDi7vZvrJq1mbD9AhJ5OkKsP1Mw9VIaTkGD4/Vc7SHhSJsG8bvH?=
 =?iso-8859-1?Q?wZaPz9OA+8KXbscZjWyPJoWuPa609lCsE8h+dJPyMSLoXdPsj2e7Nsja1H?=
 =?iso-8859-1?Q?kL2sdsYcoGK3e74RchjnNMCt2t/Dt7DCJ4noNhYz+0Y73n3XHNH7auAE0K?=
 =?iso-8859-1?Q?a9gvUUQIISyLFUziVPOO3oioP6R09ePph6uOixY6dkh+3cgXTgYilH6IDv?=
 =?iso-8859-1?Q?/ExYo9ClaeZQZozJFy0VhCkmnQTafYGxkSgiJZmhOyizb+CJON4Oq6Ki04?=
 =?iso-8859-1?Q?8nmoo/LQhkeDe7dsr7r1N/cidAdVGuU5QoYQIytcmY8JVSIi+h1Iv5E3qc?=
 =?iso-8859-1?Q?RZ59XmO4/FYA1AEq8NKiT8xbT7vx+n24g9RRG3p73y05m4J0Eush8o4lWQ?=
 =?iso-8859-1?Q?96eaDKqrJmd1Ktbrfn8Y2bXj2FRUjrJ7A8ou9WJ3nT4MUSrKo7/5IKIXhU?=
 =?iso-8859-1?Q?6Hb4v/lbcz6znoYBHiri/AyshZC0spn/RJWiqsRB0JnOydADODRwuN+x5l?=
 =?iso-8859-1?Q?lf0xkaFNQ76D+PlSYB1lyIZGJzGt0icrHvGwG5RZjUeCA6LJ5VQ/InUQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcc5b65-7bce-49d7-cace-08dd45ce105c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:45.1582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Z1Puy6dyNu4lHxtu8xi/mvYA+QRnL11uvUd7JuIQrUSbzrawa98jpUjV4uuX1SrlC2XsXXTpqRHhAlzGDlGXvuzoWsEcAhKmH3D1VjyEfw=
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

Raspberry PI 5 has RP1 chip connected over PCIE and working as a
bridge to different hardware.
This driver implementation was inspired by MFD RP1 driver in the Linux
Kernel.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/mfd/Kconfig  |  10 ++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/rp1.c    | 120 +++++++++++++++++++++++++++++++++++++++++++
 include/pci_ids.h    |   3 ++
 4 files changed, 134 insertions(+)
 create mode 100644 drivers/mfd/rp1.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae53b02f27..a9de45797f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2,3 +2,13 @@ config MFD_ATMEL_SMC
        bool "Atmel Static Memory Controller driver"
        help
 	Say yes here to support Atmel Static Memory Controller driver.
+
+config MFD_RP1
+	tristate "RP1 MFD driver"
+	depends on PCI
+	help
+	  Support for the RP1 peripheral chip.
+
+	  This driver provides support for the Raspberry Pi RP1 peripheral chip.
+	  It is responsible for enabling the Device Tree node once the PCIe endpo=
int
+	  has been configureds.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4454815a98..c81ee5789b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MFD_ATMEL_SMC) +=3D atmel-smc.o
+obj-$(CONFIG_MFD_RP1) +=3D rp1.o
diff --git a/drivers/mfd/rp1.c b/drivers/mfd/rp1.c
new file mode 100644
index 0000000000..265ed668f5
--- /dev/null
+++ b/drivers/mfd/rp1.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 EPAM Systems
+ *
+ * Derived from linux rp1 driver
+ * Copyright (c) 2018-22 Raspberry Pi Ltd.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/of_access.h>
+#include <dt-bindings/mfd/rp1.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <pci.h>
+
+#define RP1_B0_CHIP_ID 0x10001927
+#define RP1_C0_CHIP_ID 0x20001927
+
+#define RP1_PLATFORM_ASIC BIT(1)
+#define RP1_PLATFORM_FPGA BIT(0)
+
+#define RP1_DRIVER_NAME "rp1"
+
+#define PCI_DEVICE_REV_RP1_C0 2
+
+#define SYSINFO_CHIP_ID_OFFSET	0x00000000
+#define SYSINFO_PLATFORM_OFFSET	0x00000004
+
+struct rp1_dev {
+	phys_addr_t bar_start;
+};
+
+static inline dma_addr_t rp1_io_to_phys(struct rp1_dev *rp1, unsigned int =
offset)
+{
+	return rp1->bar_start + offset;
+}
+
+static u32 rp1_reg_read(struct rp1_dev *rp1, unsigned int base_addr, u32 o=
ffset)
+{
+	resource_size_t phys =3D rp1_io_to_phys(rp1, base_addr);
+	void __iomem *regblock =3D ioremap(phys, 0x1000);
+	u32 value =3D readl(regblock + offset);
+
+	iounmap(regblock);
+	return value;
+}
+
+static int rp1_get_bar_region(struct udevice *dev, phys_addr_t *bar_start)
+{
+	*bar_start =3D (phys_addr_t)dm_pci_map_bar(dev, PCI_BASE_ADDRESS_1, 0, 0,
+			PCI_REGION_TYPE, PCI_REGION_MEM);
+	return 0;
+}
+
+static int rp1_probe(struct udevice *dev)
+{
+	int ret;
+	struct rp1_dev *rp1 =3D dev_get_priv(dev);
+	u32 chip_id, platform;
+
+	/* Turn on bus-mastering */
+	dm_pci_clrset_config16(dev, PCI_COMMAND, 0, PCI_COMMAND_MASTER | PCI_COMM=
AND_MEMORY);
+
+	ret =3D rp1_get_bar_region(dev, &rp1->bar_start);
+	if (ret)
+		return ret;
+
+	/* Get chip id */
+	chip_id =3D rp1_reg_read(rp1, RP1_SYSINFO_BASE, SYSINFO_CHIP_ID_OFFSET);
+	platform =3D rp1_reg_read(rp1, RP1_SYSINFO_BASE, SYSINFO_PLATFORM_OFFSET)=
;
+	dev_dbg(dev, "chip_id 0x%x%s\n", chip_id,
+		(platform & RP1_PLATFORM_FPGA) ? " FPGA" : "");
+
+	if (chip_id !=3D RP1_C0_CHIP_ID) {
+		dev_err(dev, "wrong chip id (%x)\n", chip_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rp1_bind(struct udevice *dev)
+{
+	device_set_name(dev, RP1_DRIVER_NAME);
+	return 0;
+}
+
+static const struct pci_device_id dev_id_table[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0), },
+	{ 0, }
+};
+
+static int rp1_pcie_read_config(const struct udevice *bus, pci_dev_t bdf,
+				uint offset, ulong *valuep, enum pci_size_t size)
+{
+	/*
+	 * Leaving this call because pci subsystem calls for read_config
+	 * and produces error then this callback is not set.
+	 * Just return 0 here.s
+	 */
+	*valuep =3D 0;
+	return 0;
+}
+
+static const struct dm_pci_ops rp1_pcie_ops =3D {
+	.read_config	=3D rp1_pcie_read_config,
+};
+
+U_BOOT_DRIVER(rp1_driver) =3D {
+	.name			=3D RP1_DRIVER_NAME,
+	.id			=3D UCLASS_PCI_GENERIC,
+	.probe			=3D rp1_probe,
+	.bind			=3D rp1_bind,
+	.priv_auto		=3D sizeof(struct rp1_dev),
+	.ops			=3D &rp1_pcie_ops,
+};
+
+U_BOOT_PCI_DEVICE(rp1_driver, dev_id_table);
diff --git a/include/pci_ids.h b/include/pci_ids.h
index f1886c3a75..4027b89b25 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2556,6 +2556,9 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
=20
+#define PCI_VENDOR_ID_RPI		0x1de4
+#define PCI_DEVICE_ID_RP1_C0		0x0001
+
 #define PCI_VENDOR_ID_TEHUTI		0x1fc9
 #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
 #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
--=20
2.34.1
