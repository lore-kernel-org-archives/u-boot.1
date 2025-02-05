Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3050C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBA780C99;
	Wed,  5 Feb 2025 14:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="NzDrkQuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7BD80562; Wed,  5 Feb 2025 11:15:59 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BBD807E1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuw0AcPVwxkkMky5b2RivhyBD7EVuVgFBAAUN6E2vGtGGo3ZuQq375A9swY4+koZY3HwJedYwh6fsfCkzE8Q6rp/8dKbloM0stsoElIjqDryKw9rOV7cOgARGVemlFdeisvbFpXl6tmfuq/h8mcN9QOwLZnbUrnkUnwCXH2SGvn/VTiHRh1T3ugZsyhBWsE/p7hk1mdirhAbxRd5xDAbTz1zEwGppk5Gzk0XqSZiIO9dzl8Du4vP2y8g4cU3VEDsuR+o5HJiJGCJLdPOKXpwa1mq+YwDQWaDRlNuaR8K9/2j9wzYuWTyZ7K0gJ4WrUw1PAW9Er5VKonCT/jBYmdZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkv4cj0ZKB5JtoSGq33cHQxOnoTZ5/25y/I8Va0uhmE=;
 b=roxcVc9KGnlA0XBsQwoAnBr4hZ33D4IysIlDlzMhUmZ/42HBUvT6EH22SL7jWf284uyACxTx9xgbe3+bmgB5qiYdBEJt7H3IeMAN2dTS66iRrMeF1szCtqkPAozG/1m83uqdWpBhnkkTa5o8Fq+5onPfVB5DhxYybY+VOyJiD40GkZHXTXd4ttnNK4thWE7i4+6Dz02NbcIBb6knRDgbCj7SPooljDexhJj7Uv4uvcVq7WCcJ2Oin/iDnAUBVlbPK4G6Wud9SFJxdfbc6d3033GELFsoJGTXyxl/d2sHK9AOuQvGEZKt79IMFCrJJ7QanO1lU7JdAHUBow77QN995Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkv4cj0ZKB5JtoSGq33cHQxOnoTZ5/25y/I8Va0uhmE=;
 b=NzDrkQuSbfx0pdPBHl7lTyfUjlENaUOXKSSZE4d4+4oVh5Z6PnM+AtRODH+bduMyc1sWMESQ7wRWa8dbgDK3HfDHM6/waA9Xf/vYzh8C94rgHvV2XKTH+R8oBSNBYLRBhFsYW56i+qAWDRHPTNZ2Zc4dZBrvVtzqikeHsHmLVlhevH5XsRnjB2hr5Qelv49gKmoy7oZMw4/G4xN05KxPN+cbwalY3ooj1330cQFu1GYBtE0fbdWzkbEOO0VPUyJH7+mK/cdWJrKcGvCKNkhdxDsTlZWpa9PU0qUX2EjARDMlXYMvWtCKHXkJPoBSq0fa4jaepWmIXiBSYvnyAH/OHQ==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:51 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:51 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 14/20] drivers: net: macb: introduce ePCI connection
 support for macb
Thread-Topic: [RFC PATCH v1 14/20] drivers: net: macb: introduce ePCI
 connection support for macb
Thread-Index: AQHbd7bs8veq5io78ESC06SIfwd9hQ==
Date: Wed, 5 Feb 2025 10:15:46 +0000
Message-ID: <0986c74fd7b543d47e1de30aa92663966caaea91.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 560fed58-7f61-4adf-be71-08dd45ce113b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sot2/lzgBqS+/bq7zCs8M8/SbPmEgGYvG+ujRsObSZjs7exSgC+AMFkE1H?=
 =?iso-8859-1?Q?BFfHmUHMrLhEykshQ9m6FffLWR2YGZTdSjo8HtIIuCAhc/VAj/2jvGYpQL?=
 =?iso-8859-1?Q?Fiyr5NoSYULqPXSh3NKJH9uJ2jdnBJEl1TQipEOSkVN6gnU93LhwtwDWm6?=
 =?iso-8859-1?Q?/uy5Hb0AwAgQvYc5dIxFp71HdsWOF88ecDK14LSi6glfkV4aAVjxyegNuF?=
 =?iso-8859-1?Q?tEUQJ4VJFyKZWVL1Iey6w1z+dX1vVFYg9GnXlk38bnZMGXyN1N2v6b+ygx?=
 =?iso-8859-1?Q?srXrid8X9RbvovSaPbAowfO3TXgq+LFn1knX6yobtjVvU0FKq74/P7rwNB?=
 =?iso-8859-1?Q?AvQs3oGLZQFHpdhZljOMka3uLHqn8BdzIIfAZnvT5nGAXWPRZtlR+pWlDC?=
 =?iso-8859-1?Q?J/tL67KLsKIxiZHRE7Gyq5I5eBAtJENLxFmGrb4Bv86JBbhZF+Vhk45i4n?=
 =?iso-8859-1?Q?Ppu9YJgpCrX7Pko5P0u5g1mjqHbfY+GxVTrINHhB7tL2+GL7OoEmhlt+3g?=
 =?iso-8859-1?Q?TWCk4HEJum3Ye6AWhl7NESHUiL9WwLepmFt+UJNwJuRZwlGhP4mtSPJeLJ?=
 =?iso-8859-1?Q?+4MXxuZDD4gb/tIAEJYX153VYWmeCqLJ4OtSmN0G4qD3iC/MrozguXTwLh?=
 =?iso-8859-1?Q?CoXqaSJ1EHn44b320YoQiZSE3OStAKYv4IEIZ8PUZaGidDJyIhN/ArRuPW?=
 =?iso-8859-1?Q?d4VYDcvZdPkY/evqrSC7GkATUDfAL0ZZuY/OMskL4evkz5RuvvAEQ6Xbf8?=
 =?iso-8859-1?Q?Zkft+GytxUf20RJbi+Z0eOzvYe9/7OwsSDCVnifkNmeyr4q7YTCTL8hcdr?=
 =?iso-8859-1?Q?S8/R+oUgJ0DszsWaTmG7j8+bfZK8R7LwmdVJL/CdF2afBMXVsRFwjExJBE?=
 =?iso-8859-1?Q?WL5FBYbHzIIQNtUe2sGTkSAckXmi164Qy9iPudS6vb0YK2z7yG46kXRzY/?=
 =?iso-8859-1?Q?atoMffTT7WB47/8YXlx0eemTGTn+XbfqusmgQDJpwcTY1Fb9iwIbjc2JVK?=
 =?iso-8859-1?Q?xVg8AtOOMyDc2KTf3Pn2M+Oo5OLf5pijyfaS4SSjsyUfVuJpo4btihbEWn?=
 =?iso-8859-1?Q?VKm1bZWQS1CGsC/sFvXeFHSL9QqvEFplwtR7oImn4GJ8FjJcbwTtoyY5WI?=
 =?iso-8859-1?Q?snA4c571lp0/U2PYTFj/L2+sjvRWwQUdPQERE3neQHYNEzz/vQ1XBvK5OL?=
 =?iso-8859-1?Q?fPzkPLwBuj8FGvGo8FXHlK7zgGE6eUXxjd3rafT7qNlsOu6Jzt8mP8OUtH?=
 =?iso-8859-1?Q?KAXGR/aQdXBKCR2vgQm5jTxrvxhKdByXvTCPka1GxxAn58TfnvthB9Y3tT?=
 =?iso-8859-1?Q?fEQQHX6KzZk5p5oBxx0hbkPQNXe0p3yHX7jj5TgkZyxRhwdFOSBZ4d15lC?=
 =?iso-8859-1?Q?K1FBsrA7SBCn/mHSBN4fM4Y2UWq7Pr8DikO6EhzqyC60M6+oJKE62W9x1e?=
 =?iso-8859-1?Q?aRCLjVoHlEnmZpm1f5UV6tTpGn/w8+iT1nIyhxR5vrNHVgQKCiPwVRum9h?=
 =?iso-8859-1?Q?I7uinYEDCcjqzFmIVQR/wi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KsAh5MS2P4N6D/J9BiHi5SDtO23VilgHoUyMHRmS4OCx2snOVWq7/JVkFL?=
 =?iso-8859-1?Q?7kT4uAH0QTxN5Rm+q866z/GPE4HLdMolNgOGcmNLhqrQgu3mA+vR68LLhT?=
 =?iso-8859-1?Q?xSn2Y1PvXccCIp5GvPPCRlWdTeqRr7nlCW4j1l9HSJ/zwptNRIZPLu0MH6?=
 =?iso-8859-1?Q?ILWUQDKyjbl2+TwNwOO1RPpq8D/vMyT6W4To8nApxkWo1ik3ia+bqKK29z?=
 =?iso-8859-1?Q?Zu64cJ4HqzJ4WBJm4BhabfHgBdb0Res7VcoKRvrmZ+u1DbvSZMWPgUeqQD?=
 =?iso-8859-1?Q?Dkgnx8ysOw+jHhEPwY1QjTW91Eg1hwc8QRJzKjEXO09oXFvwyUEaj2Pzq2?=
 =?iso-8859-1?Q?7UuXE4HGYqvImgI5kV5apvumfvIeODWuFB0nNiXSSTd6HzTBA3ZxFUNw7V?=
 =?iso-8859-1?Q?EEgDPnvCSaLUr9SA72cW+/83U9kpyUU1SoQC/90eMMmhT8AjwA5caxJuWx?=
 =?iso-8859-1?Q?Asnlocu8UAwHAj2DFTkT0FYI8CyWZzYHIQyyi8wXqdGYcA4Z2e9VtAq5zo?=
 =?iso-8859-1?Q?epK7TBHs8h+hTvs6NUhOk3r+c5p1zdUluTcBgFPNPXlt975wxPP1C4bb3I?=
 =?iso-8859-1?Q?pqZBpx/YQMekObKhVMFnFNUW55xYNNOLImdg6VuyYZ7wGJUfUV2jnpV3PJ?=
 =?iso-8859-1?Q?0RY6Tls1H4eajuZQBriiyGLbpo36oMoxiJY4t03bLdtmWM02ZQsdO46AQx?=
 =?iso-8859-1?Q?b7Wc7wI6tXxqJBuZEK/2vF+4xXvKlR2Teg4LRhFqOOOqzfoM70KUaser6Q?=
 =?iso-8859-1?Q?HRNz/Y31XVkFxPOfQoGwsEr1ezrXgmMs0cF5+Y0H8zupQxiUtM82UYTxYA?=
 =?iso-8859-1?Q?YmjMsRMbQPiMx0hNw33OjuVpZFRpH1dNTLMALtRhJ3mvqd9rCxzKNzJs/r?=
 =?iso-8859-1?Q?ALPMC/FvmCFPZJrz1t6bbF5mV8/HBxwrB7N8+SLRiewMi1pQtOJdyE63B5?=
 =?iso-8859-1?Q?G5tTfrKirsOcLnthA6WTmG8Qc/Bh20nguzJFyEmaFSGATOBdhal8DCl4ks?=
 =?iso-8859-1?Q?bJX+LNMNQDprx6Lx1Q6iCTWALCqgY0AhaEqRfCOCUpg1ay+kAqNFoi9C/8?=
 =?iso-8859-1?Q?XcJWQvoVNaFafuiajYAgzB1Lght73QHHDO307jTn++EfqPqHRvQQfRqX1l?=
 =?iso-8859-1?Q?6ZCfmQCALXMJ2zPH4UbfJb2QyGFZMgCTHoMtZjUP25TMq2WDEnCtz+iHSN?=
 =?iso-8859-1?Q?UW67TX4/gZNSaLk1nLohhCoo60EFWsKMmHCuSw/q8r/V427CuxsFSHerZr?=
 =?iso-8859-1?Q?jK8wxbqqOVwqedbA13DhLlZ1swveVE3uksVDkYQeMcg0Occ186GEkW6ASM?=
 =?iso-8859-1?Q?x4/0Uhzh+l2CVlqPNZBzMIlmEkt7zopUB43QFbnI+CXjVvtHusLH8LKC4V?=
 =?iso-8859-1?Q?zir/rRU6YzxIJtmTIOJ9sz+s5atOwE6sbaNkk1UIbCo7qB3ghl65pUNsT8?=
 =?iso-8859-1?Q?1A/p5K6yUb17t5b+4VnllkxV/fkxA8j/WeaszFJsKqXjkR8qJwtIiwJtY2?=
 =?iso-8859-1?Q?MUkoEC87dkbK5LvQdFMRC0OgT44Ecj0mk6hFq98uNOsCZjmqphmx/PKyxI?=
 =?iso-8859-1?Q?2q+7FX2HMI9HDr5Id/lAYWEGG5BomvQGlN6NSEYLXvNGWaxxBH7yig9nfl?=
 =?iso-8859-1?Q?zb7zMNU+7uBvTXo9BT1NOOqDG0TF4Bsq7CZIZbpFZGi9S2QskceT/0uQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560fed58-7f61-4adf-be71-08dd45ce113b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:46.7137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5Cnp4gEVyoetv7kbkJH/UZLuRxJnAwAGd6j8oqLI/F8XFnLS/FVhnt4K3lLUgV4D4uxy7XI1TS68LuEq5nu2p1OkD3fZAfidM2qZwl0AW4=
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

On BCM2712 connected devices, such as RPI5 has an external chip called
RP1 connected to the main SOC over ePCI. Macb is connectet to the RP1
chip and should be transparent to the SOC. Introduced changes are
intended to solve mapping issues and implement full support for the
macb driver.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/net/Kconfig |   1 +
 drivers/net/macb.c  | 154 +++++++++++++++++++++++++++++++++++---------
 drivers/net/macb.h  |  16 +++++
 3 files changed, 140 insertions(+), 31 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b2d7b49976..22846ab7f7 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -525,6 +525,7 @@ config MVPP2
 config MACB
 	bool "Cadence MACB/GEM Ethernet Interface"
 	select PHYLIB
+	select DM_GPIO
 	help
 	  The Cadence MACB ethernet interface is found on many Atmel
 	  AT91 and SAMA5 parts.  This driver also supports the Cadence
diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index a6a9a9b5d7..1f5b241950 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -32,6 +32,7 @@
  * core modifications here...
  */
=20
+#include <broadcom/bcm_board_types.h>
 #include <net.h>
 #include <malloc.h>
 #include <miiphy.h>
@@ -45,6 +46,7 @@
 #include <linux/errno.h>
=20
 #include "macb.h"
+#include "phys2bus.h"
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
@@ -103,6 +105,8 @@ struct macb_dma_desc_64 {
 #define RXBUF_FRMLEN_MASK	0x00000fff
 #define TXBUF_FRMLEN_MASK	0x000007ff
=20
+#define msleep(x) udelay((x) * 1000)
+
 struct macb_device {
 	void			*regs;
=20
@@ -142,6 +146,10 @@ struct macb_device {
 	unsigned long		pclk_rate;
 #endif
 	phy_interface_t		phy_interface;
+
+	struct gpio_desc phy_reset_gpio;
+	int phy_reset_ms;
+	struct udevice *udev;
 };
=20
 struct macb_usrio_cfg {
@@ -273,47 +281,70 @@ int macb_miiphy_write(struct mii_dev *bus, int phy_ad=
r, int devad, int reg,
=20
 	arch_get_mdio_control(bus->name);
 	macb_mdio_write(macb, phy_adr, reg, value);
+	return 0;
+}
=20
+static int macb_miiphy_reset(struct mii_dev *bus)
+{
+	struct udevice *dev =3D eth_get_dev_by_name(bus->name);
+	struct macb_device *macb =3D dev_get_priv(dev);
+
+	if (!dm_gpio_is_valid(&macb->phy_reset_gpio))
+		return 0;
+
+	dm_gpio_set_value(&macb->phy_reset_gpio, 1);
+	msleep(macb->phy_reset_ms);
+	dm_gpio_set_value(&macb->phy_reset_gpio, 0);
 	return 0;
 }
 #endif
=20
 #define RX	1
 #define TX	0
+
+/*
+ * NOTE: To handle buffers - rx_ring and tx_ring addresses should be used =
instead
+ * of rx_buffer_dma and tx_buffer_dma. That is because on the several boar=
ds this
+ * controller could be connected via PCIe or similar instead of the direct=
 connection.
+ * For example in BCM2712 macb controller is connected to RP1 chip via PCI=
e.
+ * When macb is connected directly to the SOC the rx_ring and tx_ring are =
the same
+ * as rx_buffer_dma and tx_buffer_dma.
+ */
+
 static inline void macb_invalidate_ring_desc(struct macb_device *macb, boo=
l rx)
 {
 	if (rx)
-		invalidate_dcache_range(macb->rx_ring_dma,
-			ALIGN(macb->rx_ring_dma + MACB_RX_DMA_DESC_SIZE,
-			      PKTALIGN));
+		invalidate_dcache_range((ulong)(macb->rx_ring), ALIGN((ulong)(macb->rx_r=
ing) +
+					MACB_RX_DMA_DESC_SIZE, PKTALIGN));
 	else
-		invalidate_dcache_range(macb->tx_ring_dma,
-			ALIGN(macb->tx_ring_dma + MACB_TX_DMA_DESC_SIZE,
-			      PKTALIGN));
+		invalidate_dcache_range((unsigned long)macb->tx_ring,
+					ALIGN((unsigned long)macb->tx_ring +
+					      MACB_TX_DMA_DESC_SIZE, PKTALIGN));
 }
=20
 static inline void macb_flush_ring_desc(struct macb_device *macb, bool rx)
 {
 	if (rx)
-		flush_dcache_range(macb->rx_ring_dma, macb->rx_ring_dma +
-				   ALIGN(MACB_RX_DMA_DESC_SIZE, PKTALIGN));
+		flush_dcache_range((ulong)(macb->rx_ring),
+				   (ulong)(macb->rx_ring) + ALIGN(MACB_RX_DMA_DESC_SIZE, PKTALIGN));
 	else
-		flush_dcache_range(macb->tx_ring_dma, macb->tx_ring_dma +
+		flush_dcache_range((unsigned long)macb->tx_ring,
+				   (unsigned long)macb->tx_ring +
 				   ALIGN(MACB_TX_DMA_DESC_SIZE, PKTALIGN));
 }
=20
 static inline void macb_flush_rx_buffer(struct macb_device *macb)
 {
-	flush_dcache_range(macb->rx_buffer_dma, macb->rx_buffer_dma +
-			   ALIGN(macb->rx_buffer_size * MACB_RX_RING_SIZE,
-				 PKTALIGN));
+	flush_dcache_range((ulong)macb->rx_buffer,
+			   (ulong)macb->rx_buffer +
+			   ALIGN(macb->rx_buffer_size * MACB_RX_RING_SIZE, PKTALIGN));
 }
=20
 static inline void macb_invalidate_rx_buffer(struct macb_device *macb)
 {
-	invalidate_dcache_range(macb->rx_buffer_dma, macb->rx_buffer_dma +
-				ALIGN(macb->rx_buffer_size * MACB_RX_RING_SIZE,
-				      PKTALIGN));
+	invalidate_dcache_range((ulong)macb->rx_buffer,
+				(ulong)macb->rx_buffer +
+				ALIGN(macb->rx_buffer_size * MACB_RX_RING_SIZE, PKTALIGN));
 }
=20
 #if defined(CONFIG_CMD_NET)
@@ -339,12 +370,12 @@ static void macb_set_addr(struct macb_device *macb, s=
truct macb_dma_desc *desc,
 static int _macb_send(struct macb_device *macb, const char *name, void *pa=
cket,
 		      int length)
 {
-	unsigned long paddr, ctrl;
+	unsigned long paddr, dmaaddr, ctrl;
 	unsigned int tx_head =3D macb->tx_head;
 	int i;
=20
 	paddr =3D dma_map_single(packet, length, DMA_TO_DEVICE);
-
+	dmaaddr =3D dev_phys_to_bus(macb->udev, paddr);
 	ctrl =3D length & TXBUF_FRMLEN_MASK;
 	ctrl |=3D MACB_BIT(TX_LAST);
 	if (tx_head =3D=3D (MACB_TX_RING_SIZE - 1)) {
@@ -358,7 +389,7 @@ static int _macb_send(struct macb_device *macb, const c=
har *name, void *packet,
 		tx_head =3D tx_head * 2;
=20
 	macb->tx_ring[tx_head].ctrl =3D ctrl;
-	macb_set_addr(macb, &macb->tx_ring[tx_head], paddr);
+	macb_set_addr(macb, &macb->tx_ring[tx_head], dmaaddr);
=20
 	barrier();
 	macb_flush_ring_desc(macb, TX);
@@ -666,6 +697,22 @@ int __weak macb_linkspd_cb(struct udevice *dev, unsign=
ed int speed)
 	return 0;
 }
=20
+static void gem_init_axi(struct macb_device *bp)
+{
+	u32 amp;
+
+	/* AXI pipeline setup - don't touch values unless specified in device
+	 * tree. Some hardware could have reset values > 1.
+	 */
+	amp =3D gem_readl(bp, AMP);
+
+	amp =3D GEM_BFINS(AW2B_FILL, 1 /*bp->use_aw2b_fill*/, amp);
+	amp =3D GEM_BFINS(AW2W_MAX_PIPE, 8, amp);
+	amp =3D GEM_BFINS(AR2R_MAX_PIPE, 8, amp);
+
+	gem_writel(bp, AMP, amp);
+}
+
 static int macb_phy_init(struct udevice *dev, const char *name)
 {
 	struct macb_device *macb =3D dev_get_priv(dev);
@@ -815,8 +862,8 @@ static int gmac_init_multi_queues(struct macb_device *m=
acb)
=20
 	macb->dummy_desc->ctrl =3D MACB_BIT(TX_USED);
 	macb->dummy_desc->addr =3D 0;
-	flush_dcache_range(macb->dummy_desc_dma, macb->dummy_desc_dma +
-			ALIGN(MACB_TX_DUMMY_DMA_DESC_SIZE, PKTALIGN));
+	flush_dcache_range((ulong)macb->dummy_desc,
+			   (ulong)macb->dummy_desc + ALIGN(MACB_TX_DUMMY_DMA_DESC_SIZE, PKTALIG=
N));
 	paddr =3D macb->dummy_desc_dma;
=20
 	for (i =3D 1; i < num_queues; i++) {
@@ -920,6 +967,14 @@ static int _macb_init(struct udevice *dev, const char =
*name)
 		macb_writel(macb, TBQPH, upper_32_bits(macb->tx_ring_dma));
 	}
=20
+	/*
+	 * Call axi bus init only for BCM2712 board which has macb
+	 * connected over PCIe.
+	 */
+	if ((IS_ENABLED(CONFIG_BCM2712)) &&
+	    (gd_board_type() =3D=3D BCM2712_RPI_5_B_NEW))
+		gem_init_axi(macb);
+
 	if (macb_is_gem(macb)) {
 		/* Initialize DMA properties */
 		gmac_configure_dma(macb);
@@ -1081,7 +1136,7 @@ static u32 macb_dbw(struct macb_device *macb)
 	}
 }
=20
-static void _macb_eth_initialize(struct macb_device *macb)
+static void _macb_eth_initialize(struct macb_device *macb, struct udevice =
*dev)
 {
 	int id =3D 0;	/* This is not used by functions we call */
 	u32 ncfgr;
@@ -1095,13 +1150,23 @@ static void _macb_eth_initialize(struct macb_device=
 *macb)
 	macb->rx_buffer =3D dma_alloc_coherent(macb->rx_buffer_size *
 					     MACB_RX_RING_SIZE,
 					     &macb->rx_buffer_dma);
+
+	macb->rx_buffer_dma =3D dev_phys_to_bus(dev, (ulong)macb->rx_buffer);
+
 	macb->rx_ring =3D dma_alloc_coherent(MACB_RX_DMA_DESC_SIZE,
 					   &macb->rx_ring_dma);
-	macb->tx_ring =3D dma_alloc_coherent(MACB_TX_DMA_DESC_SIZE,
-					   &macb->tx_ring_dma);
+
+	macb->rx_ring_dma =3D dev_phys_to_bus(dev, (ulong)macb->rx_ring);
+
+	macb->tx_ring =3D dma_alloc_coherent(MACB_TX_DMA_DESC_SIZE, &macb->tx_rin=
g_dma);
+
+	macb->tx_ring_dma =3D dev_phys_to_bus(dev, (ulong)macb->tx_ring);
+
 	macb->dummy_desc =3D dma_alloc_coherent(MACB_TX_DUMMY_DMA_DESC_SIZE,
 					   &macb->dummy_desc_dma);
=20
+	macb->dummy_desc_dma =3D dev_phys_to_bus(dev, (ulong)macb->dummy_desc);
+
 	/*
 	 * Do some basic initialization so that we at least can talk
 	 * to the PHY
@@ -1175,11 +1240,19 @@ static const struct eth_ops macb_eth_ops =3D {
 static int macb_enable_clk(struct udevice *dev)
 {
 	struct macb_device *macb =3D dev_get_priv(dev);
-	struct clk clk;
-	ulong clk_rate;
+	struct clk clk, hclk;
+	struct clk tsu_clk;
 	int ret;
=20
-	ret =3D clk_get_by_index(dev, 0, &clk);
+	ret =3D clk_get_by_name(dev, "pclk", &clk);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D clk_get_by_name_optional(dev, "hclk", &hclk);
+	if (ret)
+		return -EINVAL;
+
+	ret =3D clk_get_by_name_optional(dev, "tsu_clk", &tsu_clk);
 	if (ret)
 		return -EINVAL;
=20
@@ -1192,11 +1265,17 @@ static int macb_enable_clk(struct udevice *dev)
 	if (ret && ret !=3D -ENOSYS)
 		return ret;
=20
-	clk_rate =3D clk_get_rate(&clk);
-	if (!clk_rate)
-		return -EINVAL;
+	ret =3D clk_enable(&hclk);
+	if (ret && ret !=3D -ENOSYS)
+		return ret;
+
+	ret =3D clk_enable(&tsu_clk);
+	if (ret && ret !=3D -ENOSYS)
+		return ret;
=20
-	macb->pclk_rate =3D clk_rate;
+	macb->pclk_rate =3D 0xbebc200;
+	if (!macb->pclk_rate)
+		return -EINVAL;
=20
 	return 0;
 }
@@ -1227,6 +1306,7 @@ static int macb_eth_probe(struct udevice *dev)
 	if (macb->phy_interface =3D=3D PHY_INTERFACE_MODE_NA)
 		return -EINVAL;
=20
+	macb->udev =3D dev;
 	/* Read phyaddr from DT */
 	if (!dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
 					&phandle_args))
@@ -1252,7 +1332,7 @@ static int macb_eth_probe(struct udevice *dev)
 		return ret;
 #endif
=20
-	_macb_eth_initialize(macb);
+	_macb_eth_initialize(macb, dev);
=20
 #if defined(CONFIG_CMD_MII) || defined(CONFIG_PHYLIB)
 	macb->bus =3D mdio_alloc();
@@ -1261,6 +1341,7 @@ static int macb_eth_probe(struct udevice *dev)
 	strlcpy(macb->bus->name, dev->name, MDIO_NAME_LEN);
 	macb->bus->read =3D macb_miiphy_read;
 	macb->bus->write =3D macb_miiphy_write;
+	macb->bus->reset =3D macb_miiphy_reset;
=20
 	ret =3D mdio_register(macb->bus);
 	if (ret < 0)
@@ -1302,6 +1383,7 @@ static int macb_eth_of_to_plat(struct udevice *dev)
 	void *blob =3D (void *)gd->fdt_blob;
 	int node =3D dev_of_offset(dev);
 	int fl_node, speed_fdt;
+	int ret;
=20
 	/* fetch 'fixed-link' property */
 	fl_node =3D fdt_subnode_offset(blob, node, "fixed-link");
@@ -1325,6 +1407,16 @@ static int macb_eth_of_to_plat(struct udevice *dev)
 	if (!pdata->iobase)
 		return -EINVAL;
=20
+	/* optional PHY reset-related properties */
+	ret =3D gpio_request_by_name(dev, "phy-reset-gpios", 0, &macb->phy_reset_=
gpio,
+				   GPIOD_IS_OUT);
+	if (ret && ret !=3D -ENOENT) {
+		printf("Failed to obtain phy-reset gpio\n");
+		return ret;
+	}
+
+	macb->phy_reset_ms =3D ofnode_read_s32_default(dev_ofnode(dev), "phy-rese=
t-duration", 10);
+
 	return macb_late_eth_of_to_plat(dev);
 }
=20
diff --git a/drivers/net/macb.h b/drivers/net/macb.h
index 72b84ae96e..37b98277a6 100644
--- a/drivers/net/macb.h
+++ b/drivers/net/macb.h
@@ -69,6 +69,7 @@
 #define GEM_USRIO		0x000c /* User IO */
 #define GEM_DMACFG		0x0010 /* DMA Configuration */
 #define GEM_JML			0x0048 /* Jumbo Max Length */
+#define GEM_AMP			0x0054 /* AXI Max Pipeline */
 #define GEM_HRB			0x0080 /* Hash Bottom */
 #define GEM_HRT			0x0084 /* Hash Top */
 #define GEM_SA1B		0x0088 /* Specific1 Bottom */
@@ -764,6 +765,21 @@
 #define GEM_RX_CSUM_IP_TCP			2
 #define GEM_RX_CSUM_IP_UDP			3
=20
+/* Bitfields in AMP */
+/* Maximum number of outstanding AXI read requests */
+#define GEM_AR2R_MAX_PIPE_OFFSET		0
+#define GEM_AR2R_MAX_PIPE_SIZE			8
+/* Maximum number of outstanding AXI write requests */
+#define GEM_AW2W_MAX_PIPE_OFFSET		8
+#define GEM_AW2W_MAX_PIPE_SIZE 8
+/* Select whether the max AW2W transactions operates between: */
+#define GEM_AW2B_FILL_OFFSET			16
+/*   0: the AW to W AXI channel */
+#define GEM_AW2B_FILL_AW2W			0
+/*   1: AW to B channel */
+#define GEM_AW2B_FILL_AW2B			1
+#define GEM_AW2B_FILL_SIZE			1
+
 /* limit RX checksum offload to TCP and UDP packets */
 #define GEM_RX_CSUM_CHECKED_MASK		2
 #define gem_writel_queue_TBQP(port, value, queue_num)	\
--=20
2.34.1
