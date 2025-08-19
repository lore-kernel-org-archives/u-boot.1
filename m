Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C97BCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D736830CA;
	Tue, 19 Aug 2025 14:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="NA8dA2iB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4538D81FEE; Tue, 19 Aug 2025 12:33:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D419802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8fbudMbQWuRT1VJY+lQn88+JQdaxBusutxZu6CD0NJhVy302VNCM2bebnrxdO0oPpTwY4DLrK//9FUXlA6CiImjYrvCBzQIj40cd2yxTxl9GYg5kJIhbil28kIH76SZsRsGFHQbQTvFnCpmrCbW3ACU5hhdF2mct3MH6hqdDIZ7X81jQ94O1BZW0s2P0bKAinhPFXcD4JV1poF5BzhyexJHl5dQI8FcSXN5UFqCIordXd9IRonhKa70v9Og746u1LASvR6aRhpDLcweIz4D/uSLWLrFycTXPYkfeT/l9brqNFsJJ2UwnzaghV03rm9MoqyRYyvR6OcDZ7jlhRJYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PiCwAtJrLOfKw3DY1cIKEjB+Tjw60Ka5pL1/28aDGo=;
 b=uaKG8YHI3QxMrFwLw10yMrr49E9oxm8s549CS52n6h71IXp9tbmFK81plk555WA0S2xhFOQFC57r1X3Xbu3Xvav5n+FXtjSidVDvpxQ1vGrt4pqCm/6MX7KRif6FHSR6rdJRUrfAkLUxRryXqlzqIUY4L7cNTPtogMMdMyhlSvGY5AulSJpYtRxP8Fd+PH4uXj2TTJU+bukhOZirU5cw1TgDx3cknimwoXfwDr/UuFqTqpanZCCreCKQ13v5DW9EXtFKRy9jLV22JHeMyGiXEE+jh0bTyCn6JBdSBVO9pCcv2c0oJsr++CKFz5vs37VtF8XKQLdETf1YXuRSh8+Gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PiCwAtJrLOfKw3DY1cIKEjB+Tjw60Ka5pL1/28aDGo=;
 b=NA8dA2iBmLUXvVhGEu0BFiHcW1eYCOkVHWREMKJBDT4xovRV3j+1/J+ts8Eglc58zFRafXXSix8P1d2o7kgzfh8b0nI50rAYhYUADA0eC7aXFztl/rJn/EwXw0xMABzSqFwKVF6ou2Vx1pEv+UvPn6zt4wRxT1sQTLzCRLn/L+BMt8/9O8jen0lEjHhD9URkB9jAtJMTx4qwr93UI6X8Up2U+da+Q0HzDu8OiCI2lDEEYMIfPAW3McjP9uvyCHSRbcNyqi7VazBG2ZFI265C8rb61OCt3QJ3zTh/qyJWa1pBA7+SOcM7U1w/jbXUuT3pGCRHfcfOSHUDR/L2ksUhBA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:33:11 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:33:11 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 06/10] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v4 06/10] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHcEPSpW8as4/XmC0eOG6uT7fbyHQ==
Date: Tue, 19 Aug 2025 10:33:10 +0000
Message-ID: <20250819103021.1518687-7-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM0PR09MB4321:EE_
x-ms-office365-filtering-correlation-id: 6662d74a-0895-422c-5eb2-08dddf0bcb94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?l8ktBrTZBY6v0Z2C9O5tA9aVGDsMaTt5F5NjdbMjOK3ylznoID49ts+K2V?=
 =?iso-8859-1?Q?U4m5xu1pukfm+tOJcNCKuULdWDkl41OaQ+6syoMUwLa6Aw6ftgyKyXvdWb?=
 =?iso-8859-1?Q?52nRmQynutju9qPtRxyBQsT9BZPZKxzMGilhjwKG/U+275enFY/3G0dk7f?=
 =?iso-8859-1?Q?4b+8oU+BsG+yod7yEim6yLc/XERSUHceM80bhRizZmFDaEAhQ2gjZH49mZ?=
 =?iso-8859-1?Q?COyx22s6LUjzmaw5LLGCZh7zUndHebFJJO9XxkwpoZI2R47eGdhIomDL4T?=
 =?iso-8859-1?Q?HFk8EUvXL52K7jYtHH2Tdj9v3+8Qlo/PyctE5b5VCQb0kIlZCD0J/1SLB2?=
 =?iso-8859-1?Q?+vu7Fuy/brN556S7lbCA8hlBuGTIaAFGH3xegG/JKkxf7+On2DQ3y/QC8M?=
 =?iso-8859-1?Q?lR1T3PjF2B019KNHskNGU8AFa+1OEdZIsFNpDWUPe7Efo+D3OCRbaxkNSQ?=
 =?iso-8859-1?Q?gTl9YmvqUbKAjMogKWeiw7vna6ym1MqMh6UqUMQ1KRRSLpUSuCF+LD+LG7?=
 =?iso-8859-1?Q?VhLMpVasgAps/4HBHy+QpR1jEKrNPZVfAJSvVeUWBpPqC841gF/XlMC2nZ?=
 =?iso-8859-1?Q?XpAYfyzHcOWD/FRCTBELly6kW2qibHQcqyvyAYlvObd1cHTtclAiP+zl+9?=
 =?iso-8859-1?Q?nyiw8R9pBZNU9GliN0Z0zN7tNyl1j8XBeQUa/fk1T8eC1pSNuAeowq8q28?=
 =?iso-8859-1?Q?XNT47C6yQjKcpQL9RNSegdoNDDv1rxv+PC6DTq4DBcVJ5PVzsGLaTY9ZX7?=
 =?iso-8859-1?Q?V8INfOOwy3pRxAFAiDPZZnjbruhrMSkinyK+/fWFNhw2S+DNYu7c2fmx+T?=
 =?iso-8859-1?Q?iK/c36iTzQ0x5lPm2dPumXddHmNzIWEgEcmLKpebdmPiBPVRk9xXOscgxK?=
 =?iso-8859-1?Q?zYMzFcfAWCnhOvEzr7gYUtNmRjKCM376VktFt4xz2j40KSOVvRDvYhN3ko?=
 =?iso-8859-1?Q?Bknd2uf4/ixoiw7MES9MoL4T9UVLnWhthgtamMPXCWNAVsDSoiv2Rg10kW?=
 =?iso-8859-1?Q?NR+lCB0RJ04PwnBNCkjkJmHrWIicOAJqRCXkXWMQj9RkVfKV1IG+djvAzN?=
 =?iso-8859-1?Q?gNXXbVT6idMHOEtRZLbdRVnfQ6+Y+AzrnRwGzCDXuaHGNH8dcIJAXA4dCb?=
 =?iso-8859-1?Q?mxiHwb3AlqPnfsff2cYzobSQHpw+J+lPA4jWODkStF8Gq2Jr1cRb8SAFUI?=
 =?iso-8859-1?Q?fiVEwszCb+3neAM34gkW/k2f/VhQbE5Mp42gfVBXMalbOcfx29+cShK4KS?=
 =?iso-8859-1?Q?6wkTt/BtDiv/bliwFnDBiHK9aHYZCpdaNrA9mA8wM98D8/LV5UnUL+CjRs?=
 =?iso-8859-1?Q?awT4lgrjAJroZnxye/TVfAnXWWCvstUHQ0Q5TuzoREdC1kUxQT+ym1eOdH?=
 =?iso-8859-1?Q?7AoTBeQEkuXAdhFIHDAAi5VbDpDD3KBfjqkVD3vxSK85tQDfe/IvdyhvVs?=
 =?iso-8859-1?Q?7/OqkLjn2IIcanCR5ii/oeq7+cNCnX1KCKIdG/Go8zP4boR1JTIRF2tfvr?=
 =?iso-8859-1?Q?1A5uyi+WvtZCv3syQztuamoiqxJNnTZ8SFh75dMU6HWg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dZjnVeOihD8pjrSm5tQfn3h9xgPCJaTep7Nuo9iO6XffqpR0jXOxhxOGgM?=
 =?iso-8859-1?Q?hSQwX95sezxbXaOt6is19nUkUiDwYc3uDVT7rJYPocYrRzEtKjmcFZFj2f?=
 =?iso-8859-1?Q?3qbn8p8rFsvZx6VRY4Ndg25uNC+Ngrjpcs4PsVWvLD2Zt/+g0omEir1EDn?=
 =?iso-8859-1?Q?c0slHSOa/GEFbFhxv6e2Cz1yvPDr7Ol7mimnlpe3j3mRx6jCUL9H6SPiv1?=
 =?iso-8859-1?Q?viosnrznHGMgGM49kO/bmQkeq+03Y5uZ9FzNCxhsL8UZX+9A7ANGQ1rZsT?=
 =?iso-8859-1?Q?sx6EBad4BI8tUP7Cy8h4l1lDIuHBikhuRdK+n4S/zgK69serf0HAVKPX7w?=
 =?iso-8859-1?Q?QVMhlRGkoxSpl/OFIYGvVXCSryGdxTXTVRufkTkRGgLPN8y3aC3UZ6Rs07?=
 =?iso-8859-1?Q?DeeOhLQiI9UboGhC5hxbjKa/HJ2UYiVAF6hCNUCNXGKWdiL2GgiuC8HU2e?=
 =?iso-8859-1?Q?av/ACSdMw3cKFEFmGHf4nX9QovfWeRO6Gk1KaNBhkLBC+tD1RBrw37N1vv?=
 =?iso-8859-1?Q?B2FlHY7u06PZ8qLFx4naVaOhKjwqm/c0ajMmiuc0KjiPb4P54n4uDh7P9+?=
 =?iso-8859-1?Q?PD/9Ouj3kt2idxZL9X3c4TXA7czoh+LyBphLuJqRCunwtVJFWwp6yPX32n?=
 =?iso-8859-1?Q?9S3lrX4WDobIqo9EWm7mCpTthezwFtX9OpeQvXNn7r53B0pPnkE3J2N/Aj?=
 =?iso-8859-1?Q?g1karmfXE+YPymxBsWFgzMGNcd2unPLeT86YImS7KfOYmU3LgZt+Rem7jK?=
 =?iso-8859-1?Q?9dSx+66cjDBo92sivXz1p0LxIXzptqyUOAr3vtTJQpjV8wuXo7r1rUkxgE?=
 =?iso-8859-1?Q?P5WNRMU7uMQwn+YxZXzByWjnRCQigK6Jz7Ew9wGZPICgRCMYmajtOs/1mE?=
 =?iso-8859-1?Q?Qp2EMjwEPttYb3DcmCtxt1k4qAnnObuCIkzm42yPcpB//pc5C7cvMFwt0V?=
 =?iso-8859-1?Q?ubNiu76DEvSnRmLoT+eAArcDyMxUzwGir80mxrQLKlcXoyRnWvQvCvY43u?=
 =?iso-8859-1?Q?XQ3K4gSMvN5FVaaOmrUWksQpTtTTgoBIQEfL/oclbvp+HYjKvGIcTVT3SA?=
 =?iso-8859-1?Q?mzw9F6E9DW7w6GJHBV1/zFEwYz6K1s+DQDwmPFxKGXq8Yy2zCq838q+qKS?=
 =?iso-8859-1?Q?ztAipUMWnisshfc+Hyod59pX7iEzYhpIR9logBVALYovwnYbtHvkO1Wx3b?=
 =?iso-8859-1?Q?ksgG3yrLuMtFrzxrBaJYicxPLhdS4HFcygYR/ySC4gevFUEAzlSl9G6zi0?=
 =?iso-8859-1?Q?7vnqn3u2Y2hBcdpKB10DiomEaWe0K3a5USxYjH3fi1UgKriKnDi0l+ukTa?=
 =?iso-8859-1?Q?XtV0Mikdvhw//9QkIcO0LmnNoox4O8Di7qb98X+LISjI/XMQwqs+ZnJ85J?=
 =?iso-8859-1?Q?B6eWM/xRkfgDJ9D/i2lkM151vKsjKiB3aRPMT3N+sMQCkbAv+zyl8dSrlA?=
 =?iso-8859-1?Q?UA8rpjNAu2r3U+2NQ19N7S7qkHm4kkkavFPacnRQBHDcNe9/p1xf/oFrI4?=
 =?iso-8859-1?Q?xXDveXoHkjixHaGy19/ICoMhO7aBBJCKknZIdXWL4u8yz4/woEe/mJkApW?=
 =?iso-8859-1?Q?mvTXuJQDGzsrvVvhu/ldQUoOPkgdEZfo5fSkNx55RgCbjo24C6WvIRLSZM?=
 =?iso-8859-1?Q?CGzKoAtF1C/6HMPhIcC0RU5Lzpi0XCBMHSXGlD/xcQtl9nujdfrQ/Mgw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6662d74a-0895-422c-5eb2-08dddf0bcb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:33:10.9181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8juyfgaOOWyJVi6D23q71UveSWk9yeAFX773QBjOnolZz4KcYLc8VyOVkdZ5EBg48w0CXZVwlLNZOWxNZ5xRyn6qV12NGLZcnNGFU6BCSmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4321
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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
 drivers/net/pch_gbe.c           | 37 +++++++++++++++++++++++++++++++--
 drivers/net/pch_gbe.h           |  1 +
 net/eth-uclass.c                |  2 ++
 4 files changed, 42 insertions(+), 2 deletions(-)

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
index adeca3d040d..dea8ab828ac 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -7,6 +7,7 @@
=20
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
@@ -15,6 +16,7 @@
 #include <miiphy.h>
 #include <linux/delay.h>
 #include "pch_gbe.h"
+#include <asm/gpio.h>
=20
 #if !defined(CONFIG_PHYLIB)
 # error "PCH Gigabit Ethernet driver requires PHYLIB - missing CONFIG_PHYL=
IB"
@@ -33,6 +35,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_re=
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
@@ -74,6 +83,14 @@ static int pch_gbe_reset(struct udevice *dev)
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
@@ -450,6 +467,11 @@ static int pch_gbe_probe(struct udevice *dev)
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
@@ -459,9 +481,17 @@ static int pch_gbe_probe(struct udevice *dev)
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
@@ -472,6 +502,9 @@ static int pch_gbe_remove(struct udevice *dev)
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
index a233912fd8e..f9f24305fb3 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -463,6 +463,8 @@ int eth_rx(void)
 			break;
 		if (!eth_is_active(current))
 			break;
+		if (net_state =3D=3D NETLOOP_FAIL)
+			break;
 	}
 	if (ret =3D=3D -EAGAIN)
 		ret =3D 0;
--=20
2.34.1
