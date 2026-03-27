Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF710F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565CA841DA;
	Fri, 27 Mar 2026 17:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="J8ct5Qrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39CA083C5E; Fri, 27 Mar 2026 15:14:54 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 084BE81E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe1nx7lFYODCYgtYzTw1DKDEx+LdJt8nxuT9+vmtkvB672vB5xqBzgqBt04m6hQOgKbyEvEndloI1oSXDfmYDLeTBNLrKuSkjsGv09MmVDXgOtsOyx861nmJ2c/RVGqR/WS8PKgMU5vToTRjCQpGVkECsqQzzOy82Oh2qHMNBCx4LCgACG2cHbB/nvAZYvZbEG1ssmkqNv4WWZl3nzrVQ2mar6mELAy9BIoMI3jno1bYcDa9ofm9nH/laMysw4bRkQgBn8NRNH8uF0MfMl3DfCEgbTKdSjiTe6wMzr56Yi2jvba3eEN1FVg5vJknR9VJrSQ61kjwFHS5saNFzO7c8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6V4qRQCDqTfY4t1bIpU/JnrDc91aC/XNAKl4T/VxVQ=;
 b=Bd7uqRFGuTE0ZLePSUs+ZhRrF11uhuf9abMigG/aqsUaVAySnvwPltcqgiezukv6hGD+sjUplRnnS+xozwf8V0O6iauBgSvoXh2wgD7RElOxVOOazVURJZrW5bokiTj+DdUwsN3FOghj24lt/5Tx6melJlrlZEKTuczOvEjvQlvW7fS0T2P7yV/zKwQ4Q3bvsiZpifHhqdhupmstc0kVWRl3unEQ4Op0TDXse7ymWp26nvV9EbiOq7Jea19e0SGGZeFAmB7Odwn8iSUW0k4Cfk8LO+S7PtoaxEPHOsSMI5+cJqlz3AtuHk81xuvJ6MqkaZfaDx1OxxGHF+DONIToaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6V4qRQCDqTfY4t1bIpU/JnrDc91aC/XNAKl4T/VxVQ=;
 b=J8ct5QrfrBHEzjnbnY/QM75U1N3whNgbSWxRofuNWNFzjo1MQT6bY7aTacAwadv7agnLMaSUIVPkFV8XJOH4Ga4rrKGErKnTpLsZ/T3o5XckvzBeDyylyz8w3z5QdGEDDaiPwlU0uRdIhOJM4f8zdYocFm6ngsLL7bh5gVYtiYXp3/l+fUBTGSoAaWUUhdbztiCOSG7+OysNNjODQlSZncRKh+NAd2Jz6mkTcTXf7PmYpntnQGmi/IoSd+IVSDVMdC4FPfrMviJs1vXc6LzGDIOUe6Z85XVTnU1s1oSRDWBxGA2T2czehDY0QK6tfawxcFR22qDYJuyV7J6akZ48vQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AM8PR09MB5398.eurprd09.prod.outlook.com (2603:10a6:20b:328::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Fri, 27 Mar
 2026 14:14:49 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:14:49 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v6 6/7] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v6 6/7] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHcvfQS/7AmeLdIUkOBVc3vFr9Rbg==
Date: Fri, 27 Mar 2026 14:14:49 +0000
Message-ID: <20260327141029.628483-7-uros.stajic@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AM8PR09MB5398:EE_
x-ms-office365-filtering-correlation-id: e9711e9a-2723-465f-e38c-08de8c0b3529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: YsmjTPh3YPU1Hw1HVvTlV6L9W6y+lUC8jo3An9WomE7soVvtIULQ8eM2HAlKbuqn8o4t6N0fd0BXlXp7ze36bCI6z9ynxcDLi3KrOvIf59+dXR6EyzH6G3OQl+kigWCZ1iZkWNrpisFKRvzKNihgIdzsYCvHlJFXf1b4EIKtfyIK1P0xWdpVbt2vgWLfDzVA4gShzj5WBRYzyfkEKklrnoeiw2P4bdHspuqgcZOxFKNey8m4+/ksHiNLzwqLPGcpTlNW8+Wnk4PsmOtczbjTkpltS9sBWfUuNOXod2kmKXrJEa7ZUdjkQUk+fRC+eSVl/JfxgIno3i9vF+Wc1L6s9MijP1Q74fcy5C2t5EF/yWTHhZWZrTwOjesCeW+vYVqUn7GUxBn+FKm2LwR/T/HExarlitDpNAUg17FneKLiuvexvyzqUBaSAofaBIl0jn6wE1TnwYoqLVXXGw9k85wzUgusxqYJVYuh2zPKdZmUEpltdpVHt/us+UBFpXq5UQBCX6L8aulY11xQn0HZQZn2aiRoZUosI1xpfngRkDB617hq4/+EbQh7Yb5GAH9LqmVanmJDrO5WmZJnfFpiVFp0nVK2beYNFwoUUNtUo35cKm26JlvatLRHYuoJ3GDnNPmTjJLnZ2Xyt1zrwZU9BdovBExcq4xbUIBvlQb/QZ72Ap5Hb43XDKc/OmVKT5Fz0+eQcQUsHCM/KZGgQI/skf6fjwllisD0Y92Wd1nhJ9nZxlQepcfcAQW+rMij2LdPQBY7TzfaPEetT/Fhbr4MDHUUhQrPXo+6KykM9R38VYgyZkE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/lR7hv40sOGdZw5sU0pB08ZRogokTohkCd2gkMPPMQt7YzEbrtF+xiF4ew?=
 =?iso-8859-1?Q?I+GMedI95JGiqlIDblivAHYCjCUQeUGYqbxzceEosDGZyQUaplTr3dIGPn?=
 =?iso-8859-1?Q?lrp3tLQ5BEISZhQSHWKKODAQIOAn3mEgKMQhCtrPRmMJ1nxJAEEBvpCy6Q?=
 =?iso-8859-1?Q?bXGSslUumOORF5MlSbP+BbHiQ6qi9ma5sb+yY8CrP2b81q6+B2b+AlpUok?=
 =?iso-8859-1?Q?TTEBPAAHfrOtBafJ5zY/4OR/qiA8/eZ7+nXJ2pfp8sIfUcYHzZw9KTnQ84?=
 =?iso-8859-1?Q?xrHZR+YWajiCFKlRjKy8d/fE+50xXDS5Obg4glmHkPl/kfQIS7OVqbFrjM?=
 =?iso-8859-1?Q?WZ77dk/N/E2aUcEZgwR1EHOenoX+PH0JcUuv3ia2dp69WI8bQyzaK5mgkc?=
 =?iso-8859-1?Q?3vxRGXr50va4WgutnHb68F3DLSTnbv5VhNuDD3evskHD/jpt1uR/WJeUx6?=
 =?iso-8859-1?Q?I5S6rhWBpbmfy/ZJDjhl3HSNG3fNYbb6x1Wov9X8xPxEe5RI/K9FVlHENA?=
 =?iso-8859-1?Q?pcDGMZtDXcdpHha3GyN6OSy0xAUt48iTWs+D4bCLu/vMtUDZK+mDhS+DdY?=
 =?iso-8859-1?Q?qjThxeGPYdF5rwixgz4XrGMuAlYJ7VkJNvcElKLjFN3sE7S+keOkvPmIop?=
 =?iso-8859-1?Q?3qyhXRP1vwDL6J5n1vxhFCEBSEFKECcMnD4waiKp4AhQxss8H7PjLx16gp?=
 =?iso-8859-1?Q?grepdP+VGbWYFl+0F9O4IuShMeyulnEOzmiQGZl1T22dyhM8+bLauAl979?=
 =?iso-8859-1?Q?+BqFJnNb3yzySjFay971nZjqTQca4GA3lkTZNkAF1CeQH/Ns/MfSKKvqtq?=
 =?iso-8859-1?Q?xnRUO50wWiMKVHZxIf8y4jgvzDKjNCyuqbQptw91t1Az/ui7OeLrJiFJfh?=
 =?iso-8859-1?Q?oHlYbCMnc9rDqTuCY2EBPcE58g+8Ghz1V3F+rYfDYOuNralsRfy6ITc/FN?=
 =?iso-8859-1?Q?oORc/slQ7jMZH+ewpTewQYIfoG5rWy6QlcB8k2wd6Rq7XPCttt1sNI+mQ1?=
 =?iso-8859-1?Q?MkNKAamLoNUSGjw+J+5wJa18DRJ8EB84ifDlYaVPBZUkg+ydG0TU5rfxHi?=
 =?iso-8859-1?Q?UnMDOiH5Nahu6EDWHdyWJJBTTMeb/eN25zzV3wwgExrZ7IvvMfbxOWp5Se?=
 =?iso-8859-1?Q?neD+lKWbKkJYwayaOCq1B/WfBAGjylIw1kukRVGlFJ8oToid9LmcZowacR?=
 =?iso-8859-1?Q?i+5ELKkRU1OLPkijcJBkcuU9cVA9xAvFpmkxrvMajoWJarbyjOLCMonLwI?=
 =?iso-8859-1?Q?yE9mhwEIrvbI4cuhhqqYelfOe0bNcFY3sEWyFOndHf2GipqmT8KWi/29IL?=
 =?iso-8859-1?Q?abCxkbdjdxN3NnBCEh4nw/Jn4GIerp45hckQVHV5uxISLP6i6MYLi6VgFb?=
 =?iso-8859-1?Q?290o558BDTxrJSdID4/AEPgGW9lYHjNDQLqFjPcj2nrgjsmwBrgJVz1+4O?=
 =?iso-8859-1?Q?5no3L2qlcEr/50o3eAzwGPE9z2gelmH8cJLD3tBpd7QUJ6XTVIbuMh45v0?=
 =?iso-8859-1?Q?ybQ90inKoLwEEPqRJLlUPCCIPObUmt1LQo9ybRaQcWirgrmA9yHKyQAykt?=
 =?iso-8859-1?Q?rxNyhf2m65HTX1/VqPj9hpLpygxnimZnZkJGH5zdYWFgxDkgpN9pAz/SDs?=
 =?iso-8859-1?Q?+oQr0g5nEzrs4W4xkS98n1JEHOPtFt8UJ7J7DcLOohUTN7sMxZZF5ih5Wf?=
 =?iso-8859-1?Q?MpDCcJsFrYyp47VmBzj8tmCglrj8O7ljVY2QoRaalSmAzwj5EX2Gc28k9H?=
 =?iso-8859-1?Q?MvcsiSUdOfcy4kt+ZId1Yx/a6gH//aV5gGgRieQwKbXZ/TRFktKGkLskpQ?=
 =?iso-8859-1?Q?LtYrbVf4KX6c/L42zbll9NMDg5OYYYs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9711e9a-2723-465f-e38c-08de8c0b3529
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:14:49.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezkav1XCz1/khP0wSOHBiCWxz6fVPt26CGciMAAmP0NJCFPp5XYMBVdO6+ja9c3eidA5zTw7ubTjcFPkr80IdeM02t3QqqcZdmJsS7j5YgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5398
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index bada4b6752d..f11ae736db4 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -40,4 +40,8 @@ config PHY_REALTEK
 	bool
 	default y
=20
+config TFTP_FILE_NAME_MAX_LEN
+	int "Maximum length of TFTP file name"
+	default 256
+
 endif
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index adeca3d040d..380dc339e50 100644
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
+#include <asm-generic/gpio.h>
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
--=20
2.34.1
