Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E1C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFECE82CF5;
	Tue,  3 Jun 2025 16:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="iv2MFskJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209B380F9C; Tue,  3 Jun 2025 15:39:40 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D104B81E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVlV4Fxeddseh3D1a3RZ7+AcuO+YO4qsWiE/sxeEa07XasmV0pB/jHGEoLG7J5SjK6Pqc9GRySU5rJMeQLlZaUx5FPn6xiP18xOTQOPNTiU96jWram1Abnb6P1Nw1LAibfKsq3pWNmViEdEXAQQxDNkR82I9v2HR+1awWMA2K69q612jPhY79F89XZS9a37w02YOUYILKcBVF7PBi3EZukDoMD36dns9800NfBmbmSNxG88OxjX2ylUiXSRtiGv3rXaNQK6gxiCt0PL+UH+8cRwwNhxr1sE1qbDzswp0Fqg8Q9vJiWXVVBcbDMvP1Ut6BLI7BD165n7RfNLuabuBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU9eBMxH0zDOQsbdqApf53Fhda6FPIuZQFLLtMYPpso=;
 b=qfltih2pl56LKKETwdU0uOBAOpm4wZ7VOnMEOPt0eIJPAcadJpq5aAix4LMKsu53RUgloNpjOBmJQ2Yp1hczts5fJ4o+tctLDvt+MEM4JQC6FNPvjjAiZJNdrT3kr2jt5NPTnl6um5JN8NzOFr+lNiPqlm+gFMQnGgSB4TjyKjPaTfORBLTx6jvBiIb2EPeflrG48MUZOInOcT0uQ1Cbr1YskSoqmhFJFr6uGh959tDAXo6PCPVj0/Xf6uSEcxv+BCObVrXA0KYMhn2Jnu0oIR7/e8QsZL88CmvX/rEjimZGIjBjWolIaggBdcsP5XSZBKwyFja5lLWNWFv2ytnaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU9eBMxH0zDOQsbdqApf53Fhda6FPIuZQFLLtMYPpso=;
 b=iv2MFskJEdBffV1Pxj9Epb5D0IaJzrsJNw1+wP4cR/I5nOEsmGNLbGnhsC7Wwaesv2olS6fumrVsOMVHpKaCa0MyuNF51vj0JxdYWF7JH3ecgMwCzM7h9l6/+t+cX+JpPdvZc5z3/wKW5wukeSAEBNmbbxuxj1Z+HnjND2es+vVSFWLUDG7QTBaZdPurUkXasskhUSjO54yWqo2mc8rbEEJmCZzyq1fzAcYFOpV+EPB85UDiA4XOouECO0s3DXMxCsbs6Duw1cL0HE2PcJ0dkmvkGsdJybTbaJxLvo2zrXcYDHCxZZ17OrKn884kNA3WZMOEQQf5hzJNBF03ZdVxHg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PA1PR09MB7847.eurprd09.prod.outlook.com (2603:10a6:102:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:39:25 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:39:24 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 05/11] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH 05/11] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHb1Izr+WYZtG6sw0OXAiunmx7+QQ==
Date: Tue, 3 Jun 2025 13:39:24 +0000
Message-ID: <20250603133744.278790-6-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PA1PR09MB7847:EE_
x-ms-office365-filtering-correlation-id: 45be7149-4a45-4f11-b177-08dda2a40d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uBMnbG1RofXkndYiUacuKmPALUa3uq3UtySoX9birf9xQ2VvnCa+PcW4iP?=
 =?iso-8859-1?Q?GfFWbn9GzSzPZFaTmxtgg3cQta305Y2kOlEC21puV6YFue84gPtmroM9qC?=
 =?iso-8859-1?Q?DI3fzAyaXWWtiw3G+75+Nur6wdbxMCYhwmOa70XgvL5Rfmg4MF9cbZPX6f?=
 =?iso-8859-1?Q?yVpu6za6TVZKEQrdPQBwdWpSHarHV95f/z0oB7jPEWNMJ//0lK+lwesZqp?=
 =?iso-8859-1?Q?NMs9A0QgiGdLXuuFdv5E+H3B2Vd2gh40gbukZz+tCplGRmllzbQyS9VWm4?=
 =?iso-8859-1?Q?T6ZqYBXY1D7zlOwWgSBVO074o6qo3Usp30ci95tzJB8DV1y6IBLF5C+Sqa?=
 =?iso-8859-1?Q?4hmOF6pdSIL+CHc6FCK0JdU0BUmSfyhMXvEoYRiPJ2mkd3KVv86luf0RdZ?=
 =?iso-8859-1?Q?O8vLnkfFBW7SnTPFAHUTj9Oe2IwJIThwfNv6OkYKqVuAtTIqB9KTffLXuu?=
 =?iso-8859-1?Q?KjjHctIYDzThtzXdHRk/py8H/3B4AcW5spri/kSzmLiBRRy78eee5vcrrB?=
 =?iso-8859-1?Q?wMYtJnK5iwbVwi2HLHER40Yg2Szio125WhVYdqXMm3yb5c+pDOCCLAft8V?=
 =?iso-8859-1?Q?IEWSrEk8Hx3weHdKFbUOtBFGmBBreO4KKDPbLCtlRgBCt22NCRRzEgPs0t?=
 =?iso-8859-1?Q?I/VgY91MPaZFDGd+pPHMgfnF3C8Uq2xYM6+dt2GBo2a2slecawmRlO0D3O?=
 =?iso-8859-1?Q?vx19PMD4jubds0NTwrVKwpHxxWVDfILPUNhDGR/GJ/RXq0HYS4Ab54UdnS?=
 =?iso-8859-1?Q?sxLy8mbUSZxiQQQChIwz8nV+ZSi4v1qv8tEhoRb8kUC0a0wKcJH9m7c7tX?=
 =?iso-8859-1?Q?emwqXX81GakjYUNmygaYU+OOuujm80n1ktr9bWYKqBPx5XIVIjpKKMoixO?=
 =?iso-8859-1?Q?h9K6Ma9wyWns29WjGys70jrg/oufPl+TJAxGrL+OFKoblcHV5xohKgkvbP?=
 =?iso-8859-1?Q?rbECDuzms8PN8yVJ4PSy9qoEUMm+7H/8kkhuGXzwZsxEd+OnRdxVpAn2DW?=
 =?iso-8859-1?Q?ZHAh9U99BzVmYImtx1C9OuLoPpkaPiOc7Fdq8dvtQFeDRIZyXmIlEv8+Wg?=
 =?iso-8859-1?Q?s1LX0jY8bCX+uG29EJtMcjyRo/ZKbEf5fagfxQO6vjnZQ0HXifkgpekWgv?=
 =?iso-8859-1?Q?9f7LRxkAViydnwtwTKgtGGtTsET+MuHH1ilXaVpzG8WTWc8ej0xz/ak3KB?=
 =?iso-8859-1?Q?bKectlrsGZtWv8JxncIoifT4mf9jSj1gTc45jbosfHiG4kbIOPJOqXaqhf?=
 =?iso-8859-1?Q?uGwir1uKub7p/3KqRh+RwvzhiAbbbNwVIQy670T8sHHB4v5sj9qV2f3GWb?=
 =?iso-8859-1?Q?JVTAbGIkOAnbRAViSQvMfJyum8drBR2UbSef1BySnPsa2WB0+1Pw6O9mCC?=
 =?iso-8859-1?Q?+sv1WVejaP1vYqKV8eg1q65YrYli8ewm/Uab+LD0nR3Cq2snb9Djlipicx?=
 =?iso-8859-1?Q?IQ+AImddFRumODjNM7n78MDDx4PCZ59NWwz9/DI5Aofk3gQh4nP00jAv1x?=
 =?iso-8859-1?Q?oq6ZHc6SuJ7RJn0YOzyckC0G8PiTRTDmB0zNcJrsdlaQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TZnQ+QlTWE+huqua2RsHbM1dx6zI7/FxeB4ilCtRIlUT2haUovrDaz3eOi?=
 =?iso-8859-1?Q?evAMVhtpZORQXKVkS/rUP95F0/cVnUmpXuByAhOkcbcOPJHf+Dc+swZQou?=
 =?iso-8859-1?Q?A9nMpgYptY2pz++Lm29I+F7LrgJsGc2gFbWxQZBb3vUTvEiG8LdWgxuee8?=
 =?iso-8859-1?Q?OhMvApD0m1RkTgxw10MPvzCkGtUAVHBSZPl4Fbwr2o1nTQK8DX/p5XRcmL?=
 =?iso-8859-1?Q?qRvL11w10sDdHVBBKbKxu+bg4vZYtYvOzGzGoIl03Pc7VTTrfzu1HO+aLm?=
 =?iso-8859-1?Q?6E00T+ObxDVPaGXD1cV/TeoTlG9NOv5eK3dRKMGQkIqZuf+Pd8jX1Kfynf?=
 =?iso-8859-1?Q?ohsxbMnuw7AAQ/deNO+v2tD1ySGPLAzms5txFi9U+E4vCTqq2P72jWqvzU?=
 =?iso-8859-1?Q?E6x7O+0y7cG/Gg3IXb+Z/Zpm9EoEGJP1FTdTKLgvt1yTF2rO2L2nDUb6nG?=
 =?iso-8859-1?Q?absmSrJuH3FZJwWQbPAbxm6BWz0TNOhmOtssLQvalnRKeNtSwwmQTtkJsV?=
 =?iso-8859-1?Q?6EkH+lH7YS+S7fdQFs4dG1bUNP/qgHu5niesSRRO3Fnz6H8oHiBRhVx9Ed?=
 =?iso-8859-1?Q?NXYKP/QdFrsHHzbZ6em9unodGZkVKOhyH2ibNHH+pyqZ9jyJvP152pSJ4f?=
 =?iso-8859-1?Q?rGCXE0cOSYbp2NK9mxIkZ7GGE2W2E/+b9scdpa49UBZmLmlA8PG6A7glqC?=
 =?iso-8859-1?Q?1WKxjBLO8uWkiegQpR9gMgO9aCOa8eDKzUF7GsEe4+4Hx2tuW0uXBMiYUW?=
 =?iso-8859-1?Q?RrTWucFFkbyHSsgQCEez8CSGqsSIZ7OsWMBTP6c5gT2MjrA4vrT/6Znjgx?=
 =?iso-8859-1?Q?KU27V0zqCqrofq1QCdRm4xigvIM3QBXq9EBuuxMp6aw1JTQpi7/T4HYnwr?=
 =?iso-8859-1?Q?5LFPJRcdCKt75JVXhWVtGFvmPBmKPpWH/2TuurHam1i7t3RBLhngs+ru0s?=
 =?iso-8859-1?Q?2vh5TSZ3mF6kHGsR+XY6Zg+Q2BB3/Ll6TD5WFW+RTFcAEJf/HnclMl+Xf1?=
 =?iso-8859-1?Q?7cIRiT/PxbYCXs3JAUT0EP9siSxiVl4GvnPOApVDER0NcboLznXu7B5yjj?=
 =?iso-8859-1?Q?2IyUWIUPaAkllN1OtpLKghECaQtuUn3tHPYbwBYzSgbBlc+GPsKv/L3jOi?=
 =?iso-8859-1?Q?FvV4inpU0p6iHz0SAcwyUVoecl9Qm2pKEliJoI7iqSl4DV6bK8VzMuVEaB?=
 =?iso-8859-1?Q?M8KcbnhELG5qc/GyJhTpA/QjT3JVyJUEFq/vLYkqWRBk5YQfla2cZ3CZm2?=
 =?iso-8859-1?Q?3uiCwL3OjukJD3ZW9iilJ9I84AtzapL3dyGsyC0zNiVVwpNN1qBshqCckh?=
 =?iso-8859-1?Q?xs1I6zHq+mt7Lfv+KnmGNT3GfuWJYUPm1mXGtK+VHCrkbIu+HGeN9/nwEj?=
 =?iso-8859-1?Q?xeqtX1u8Uiw+DF92+2gGymHEf2JmsYD4uj54YMwbLTnaAyd6L5EcJ3HYZ2?=
 =?iso-8859-1?Q?nUC+y5j0y8RXmbEc2v9pCnNVAIKdeRlS48NQZPHGp/NvodOQ7hG/9JferX?=
 =?iso-8859-1?Q?t3ePKwv1TpMIrzO3yaPklHXVUE9hU118bj25Vu2rn/Y9/dtngid/vjqRd5?=
 =?iso-8859-1?Q?mPG1FhqBN+e26vGyJuXvCDgCfnfDW3g5Xu+yzYmtb+v+uhGvukHJVDztj7?=
 =?iso-8859-1?Q?iDwVNC9sUYb6EzU4pnrHuNAiRSWUpiJu/j3ei70Ci3LzFe7vbxxeiuXg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45be7149-4a45-4f11-b177-08dda2a40d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:39:24.2203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVVCBKp+6O955RE7W/6ByuOiEFVbXS2s6s6wYMCIVgjUVQKJk42scQCRNz4L01SU3n1mvMD7mlEk6cSHkH6PTJtcdY2JN5IEtIZLuJsou38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7847
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

Add optional PHY reset support via GPIO defined in the device tree.

Improve robustness by handling probe errors and falling back to the
environment-provided MAC address if no hardware MAC is found.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig |  4 ++++
 drivers/net/pch_gbe.c           | 36 +++++++++++++++++++++++++++++++--
 drivers/net/pch_gbe.h           |  1 +
 net/eth-uclass.c                |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 68c5fc50489..4d55d96603e 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -40,4 +40,8 @@ config PHY_REALTEK
     bool
     default y
=20
+config TFTP_FILE_NAME_MAX_LEN
+    int "Maximum length of TFTP file name"
+    default 256
+
 endif
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index adeca3d040d..0970a2dd8ba 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -14,6 +14,7 @@
 #include <pci.h>
 #include <miiphy.h>
 #include <linux/delay.h>
+#include <asm/gpio.h>
 #include "pch_gbe.h"
=20
 #if !defined(CONFIG_PHYLIB)
@@ -33,6 +34,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_re=
gs, u8 *addr)
 	macid_lo =3D readl(&mac_regs->mac_adr[0].low) & 0xffff;
 	debug("pch_gbe: macid_hi %#x macid_lo %#x\n", macid_hi, macid_lo);
=20
+	if (!macid_lo && !macid_hi) {
+		if (eth_env_get_enetaddr("ethaddr", addr))
+			return;
+
+		printf("No MAC found in either EG20T H/W or environment");
+	}
+
 	addr[0] =3D (u8)(macid_hi & 0xff);
 	addr[1] =3D (u8)((macid_hi >> 8) & 0xff);
 	addr[2] =3D (u8)((macid_hi >> 16) & 0xff);
@@ -74,6 +82,14 @@ static int pch_gbe_reset(struct udevice *dev)
 	priv->rx_idx =3D 0;
 	priv->tx_idx =3D 0;
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset)) {
+		/* Reset the PHY */
+		dm_gpio_set_value(&priv->gpio_phy_reset, 1);
+		udelay(15000);
+		dm_gpio_set_value(&priv->gpio_phy_reset, 0);
+		udelay(5000);
+	}
+
 	writel(PCH_GBE_ALL_RST, &mac_regs->reset);
=20
 	/*
@@ -450,6 +466,11 @@ static int pch_gbe_probe(struct udevice *dev)
 	plat->iobase =3D (ulong)iobase;
 	priv->mac_regs =3D (struct pch_gbe_regs *)iobase;
=20
+	err =3D gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &priv->gpio_phy_reset, GPIOD_IS_OUT);
+	if (err && (err !=3D -ENOENT))
+		return err;
+
 	/* Read MAC address from SROM and initialize dev->enetaddr with it */
 	pch_gbe_mac_read(priv->mac_regs, plat->enetaddr);
=20
@@ -459,9 +480,17 @@ static int pch_gbe_probe(struct udevice *dev)
=20
 	err =3D pch_gbe_reset(dev);
 	if (err)
-		return err;
+		goto out_err;
+
+	err =3D pch_gbe_phy_init(dev);
+	if (err)
+		goto out_err;
=20
-	return pch_gbe_phy_init(dev);
+	return 0;
+out_err:
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+	return err;
 }
=20
 static int pch_gbe_remove(struct udevice *dev)
@@ -472,6 +501,9 @@ static int pch_gbe_remove(struct udevice *dev)
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+
 	return 0;
 }
=20
diff --git a/drivers/net/pch_gbe.h b/drivers/net/pch_gbe.h
index 7e0fdbfd5a3..dcbb94094bc 100644
--- a/drivers/net/pch_gbe.h
+++ b/drivers/net/pch_gbe.h
@@ -292,6 +292,7 @@ struct pch_gbe_priv {
 	struct udevice *dev;
 	int rx_idx;
 	int tx_idx;
+	struct gpio_desc gpio_phy_reset;
 };
=20
 #endif /* _PCH_GBE_H_ */
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5555f82f23e..c82e8b0a523 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -461,6 +461,8 @@ int eth_rx(void)
 			eth_get_ops(current)->free_pkt(current, packet, ret);
 		if (ret <=3D 0)
 			break;
+		if (net_state =3D=3D NETLOOP_FAIL)
+			break;
 	}
 	if (ret =3D=3D -EAGAIN)
 		ret =3D 0;
--=20
2.34.1
