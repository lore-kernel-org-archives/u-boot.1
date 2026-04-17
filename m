Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C25F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 984278441A;
	Fri, 17 Apr 2026 14:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="TiuFOCor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092CE841C2; Fri, 17 Apr 2026 14:26:59 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F2C83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzQVJSiTwF7vxjRQXwHzb38OyDAVM2nJYxHhGuImCi6qtLZ4xChQUnPImleK6yvISTHg2uO1jDQSpUeBEYzvWDL9DpcJxYDAGhdXGZE1/0wkDJGAVvwTBA/0GvfRvxzTjYvyCufgeBGHhkqYdTaTr4+qmAa8nOd1cW4HxV+aMU/zoKrqH01mhmn/MLvhXHpSIESfjF6OWfubaLhMRRYChxYBXOWLvt2l196zFFvmemi9LX5ZBTA52QHXv5HFxsjKYgrydB/RE3X+E547pR3xOKDLRHOakS07E8+BhhQd4DaMkLFAKNyMkvSTNFF2iUiLeh6uJQaDXILdgim9/Vladw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6V4qRQCDqTfY4t1bIpU/JnrDc91aC/XNAKl4T/VxVQ=;
 b=ZSjrIsvujctl83cf+lp1JVKNOB6vcsHHlMGeeWC9pkOU08E8UPd+qgkKmbkrN/RkBtbuZvYg+J0eLbbWjj8GRrxIPIu3p7bI1S4jgEa/4aFSLodlaXxqCL+SMxiV35/TqkZToI1QoHjrrRM9swFTgVbBmZBMYGczvlWo1CqV5fB57fGWTI3GzEpHi8i+GF960sIRA2KwgZS9HcyBEXC+o4yTW8Mu+M0KoJxuX6H9BACAIxX6L2NU53SMfcejtzJ9cCFRgG3x+0761rgNaTS3WHKnRMxnwOvRf2xZsJ+bzDX9xUQZH/3CbAYdsIS2ccygmvgoHPUlV84AuoZn3GFUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6V4qRQCDqTfY4t1bIpU/JnrDc91aC/XNAKl4T/VxVQ=;
 b=TiuFOCorsuqA25YtlkMgwNDzZef6/4tg9heDPq1a4h/8v3q7pnt+XED96+v5+qHVF3aMvDhILpvaC40qWl/GYtYKt2nWsQ3lbL+Qc6kAuzFXisH4/jnbTnhqM4q228emQaxxaVqQQd1VA2O/XHaoI4HUiJFCPGvYBocxaCnOxgSWnS6BPYablnNuaQQKu+J5ZIjDFbRYK/a8wC8CW8G1tKsyPr00WgGPNlmnyq5+A881/klovG2dkPTQt+64CFp/5E0gVvh/0FB7edD4sDYWtJfZJNbGo4EKC7tkVInZh+loIShtgBuQlRtO8AbAYNX+jxObMuUiBeQ0oKi9rjcavw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DB9PR09MB6059.eurprd09.prod.outlook.com (2603:10a6:10:3d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:26:53 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:26:53 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 6/7] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v7 6/7] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHczmV5YUFfYrhlr0qHd0EfcBT0mA==
Date: Fri, 17 Apr 2026 12:26:53 +0000
Message-ID: <20260417122213.147529-7-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DB9PR09MB6059:EE_
x-ms-office365-filtering-correlation-id: 0a79740a-33ce-4126-9c70-08de9c7c9bd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: xKsdd//KmI6iXFiK56AFxczhrCz8MFsW90uVwywBS7a+Db1SJiFjK9U790N+OAaNhwES9oqi8V7NvDLfU4ZXUIMsBesyKTU5QciDBTimInpWx9PAlYfd/SjNx5vBd90Y456pjaWKZecvXvkp2+du4wgu3lwbXGhJl/PVI5AxSTHdeobq6TMIE9ur99UiehGjhZDAPVHQUHnNhoEjE6qdUFOySRqkrJBFCkLpKdl+qBN1fPZsnLytZyHLbeV7gPwM/7+KxmKCdP2Yo7/V0wwIRI04lvUa3zkwu6m48NAtRX6Wjx7ZHstxlx+IjX6Ligrcb4de20sRIjaIaDyBuxlj7wau0mZMox0X6G/Pqj7q5CNlkyfHCHMY6H93oEys/PDh+LG3g4cInEdpGgPNc/6uJ+5XEwqPTKQ14M+5kM6a+xFqVQSkdStYI2mpGRVoVOp2t9bblu06UhbcOVN36gERpAP4JTclAk9waVVFUXmkvIKPt3l4T0YUbzI9F5cW7lcfTujsPAJE3rfni/5ARtSw7325s5qyXCOwFSmiBeG9lQ1J7q4NSN8NUgGIPb1cAnqPzsplEFwpzNqLvpe743OvXrqSXIzrL8M44k8/nSTw7uZRiM4BblTTw2G9ePZNJbSUogCkDzPjSZFvKawq9andKSdNPr42qXzCFokSi3MQABn6fg0qsK6DesWCzIzd4DZCb8CQBLXXdROgiy0TsUmDOMFu7j+4h10xHiHvTxiHIYDpyIQaTAXUSu1Qyys8rO8HOFB1cwC9cFSrsYbhLJ/va7/kTnSBw79A6bDFXfUit6U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7WtoJe6dLWgbh4oUNdthsMlgol9ekIW3XSPtfWkmBngZGu0+9stCsfTZoT?=
 =?iso-8859-1?Q?jLUEI7tt5LQq1Rdb2UB/grcCubkztQSv+o2Y7iEd/P3lPWI6wTzQEOBcaf?=
 =?iso-8859-1?Q?QW+Uuy9viazKWKixCyBVOzTSPgqO53b/NMS7OhWdZ/FnckM4Zp4X7x2qOL?=
 =?iso-8859-1?Q?OFVd98zHNe4aXoecfhkn23fkQUGn/V29Uq4uB8s4p6QnwmkWE2/HglFha0?=
 =?iso-8859-1?Q?poVC7n9pY8pP46SGL/O/tlnxlt8+2S+27I+sFlBfP0UN1zhrDVTPUkzYek?=
 =?iso-8859-1?Q?PYraEVXtGiCvTlP17zn5T4uQaiTHOJ95O5VRDYt6hJGU14FHETmI5F3UfE?=
 =?iso-8859-1?Q?UTFTWqYul2u8YtdoS3tFdqRSz8muynEBtuOFrJ5hDa/5WjRcEnTNLK+pFc?=
 =?iso-8859-1?Q?/6/PPFQRsSIkoIypJbSGQ4dNN13rJ/FZffJva46vAQ4vyLPdlQTFuCN6Wa?=
 =?iso-8859-1?Q?hHzDZwEgJxVvV+xLic9y6181LHDIi8rFlF7DdDU3KMa8Vc56/a8MlY66fd?=
 =?iso-8859-1?Q?AZ7qzMiCVhCALx7ZHp7zZHsJ7GZn5xvI5ZY4w0Sg5EHEWchXh1nhSWud6X?=
 =?iso-8859-1?Q?nLUfA3XOCZQjp+eeTKfLCdUFYeYW7DoxZ1niIE8WCee9kEq9L5Rlo4A63H?=
 =?iso-8859-1?Q?K9zSM5mwCpqy+7019aa9X1jHrkXNa4hQK+90t/quu/xf2om+2jw0qLWOGu?=
 =?iso-8859-1?Q?mDQtuyZ+r8otlnv3oY0aNpAxwuHwleiDI1hrA0KyEWDJGnLZLC/LJXeM9O?=
 =?iso-8859-1?Q?lcVIqCrjXFARMPloq9hBbMg8zzHq60zaXpoFXWQrEkWFmWic/TjnsqS8OE?=
 =?iso-8859-1?Q?NRcAqwViZeGkOcrb3n6EIErE73iF8uGOFR8jyH89AhAuONF8rq7PZcsGDd?=
 =?iso-8859-1?Q?sQThDlox5U889HrfDHYqfYGSqzfV+cnXpkdJ/s4VuTR96RPmarS8T1fhFg?=
 =?iso-8859-1?Q?BKDqM3tHpSvBcb+NgO8pDsSc3VjCya/T8RlVHV2XJOMqtgLO4hhDf7XWx+?=
 =?iso-8859-1?Q?bCDm1TT70Oe4EN6a3gI52GCwOD+d178Khjr5Ud6aqWF2C0Tq6HnbNGznWs?=
 =?iso-8859-1?Q?iYrBYFkZEe7LbXQbP4wYm/1iWZWY1rVgaNncXEE3vvraHUkba98QibHLWa?=
 =?iso-8859-1?Q?Jx6C3ImZ27TWXgrbZdL4DSo8JeQe+yZRsridNxH+8/Ds6fgcvbLhrAr9pl?=
 =?iso-8859-1?Q?25z8f+SZoZ6wX8JLHBBQrOnySMmP3WMKe1CSN9QyvGDxjN/JIZJ0BqMnDx?=
 =?iso-8859-1?Q?lBaMAz2jwbgzAbinBmR++gEz/btHNKMdD5Lt7Oy1kLibE5/gRKoTi1zVGA?=
 =?iso-8859-1?Q?+3eyfGZoxtPBCXC3EP0F+qGNpNS1Fusf1f48M2Wl556/cy7e2KzapEXJWz?=
 =?iso-8859-1?Q?3IPB+YFmSFimYL2AxcQIOktfpJaxJdPv0xe1XvE+AOCztUXw4PrAavyMzh?=
 =?iso-8859-1?Q?nSaFg9jS3bi4hgdXUc309bMljZ2/j0oHNGzH0X47Lb6aqzfB5GtfBVG0sB?=
 =?iso-8859-1?Q?jV3DVOiIH0td7VZ9n0Uo2j0E9SxUsv9ugRAfuiSf8hMtOIbywQMFYckfkc?=
 =?iso-8859-1?Q?3JOTrhY7AF7ClYaO+0rdKIJlxBqdBE+2sCd63Ga+UCwzLbsQ+xHIw6vnq1?=
 =?iso-8859-1?Q?EtTdXcDav7sziSqReV/AOBcfr4Rq/WxlnC/P1pVIcFP+27VKVJmWRFBk1J?=
 =?iso-8859-1?Q?phG+r643u2P0LA8EUyG307paj8jDo59qIyImcUCC8WX6wQ438gRhGnpYvO?=
 =?iso-8859-1?Q?jtss9wUj35J65j7AOsNUf3+QmXGHma4Y/sfB8lZC7rH8L3HfeAgA6bm3cg?=
 =?iso-8859-1?Q?DivFWaAjzgPiP0MTZYH6AlizmRjqiR0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a79740a-33ce-4126-9c70-08de9c7c9bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:26:53.7490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhcD1IZ0kJh4OeshwJbtRqVyQ9mdsXha8flmLMQk3ltS1/uE9dmt/BSgbYuAMnJE5XSOHq8Jw+C6cC2SyjYodZEZBL96qQLAykGy3sbTSX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6059
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
