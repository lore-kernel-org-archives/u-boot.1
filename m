Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C241EC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E726D80C6F;
	Wed,  5 Feb 2025 14:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="EKbokWzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8DA8081A; Wed,  5 Feb 2025 11:15:58 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE779806DC
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugsR6IuEuJt0TiHuCWk2ySG/V/UJBA8eI77LTJM1xKpqN4gwS1WbFkKmIjoQu+03qeI2hZ4mXOGXACviBePXvzblCX9dGdRGVk7YRtntRcO3/bkQ8k4FAtSGGX2TIGDVjBxjewsoh8zX9h+dhbTqeok5MBzKtJhD3w85D9vzaR5DOISfWIbEliYU/rekL7GIG7FvbYXXT+/HV0RhDqrRaPSOwUQ7BgjaPnClnkK0Md7iBzc388H/vYTdfGaPfhQaOcbrDu3x/PTriE7Xo1KdTIeFq1EjN9j4hN69EOiY6Cpd89sG6yhKt5PrOTbH3tKwXjibwLPl6KCownqwFKJL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1Ya2E3zcH2DYKKQK359GafPJv8NgEqYSFD16fbtIQ4=;
 b=PcCc83DCKdCDWVb0Pbfw63f+eF681VqtygtNueF8WacJQISgQeiO6GO1ovZSLV3olAr+71ZQmozcR5gU+DHpgDYea2/X08Q6qHMRWSr4waa5ZYyJ1UdB5N0LcjSyr1CQ0rB5N5fuUnoNGLHkzFRLx9tDidFrEAO5ukREUa3eEeAxqwe+oaXzIBs0A2x+XU5idBA+Qd3g38QAU2OY1lAojdMjKOFEeDZtIke9bOZ2ZPmMs/+kncDtYTXubzcOEGoDONVQ/ocfKPuofcKUK0y9FPICyUu9/Pbs3V5J1UzqtYQtO+uvQ5IHUTXN3l93zP2ttXjRb75ftIb2XW0oyfmLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1Ya2E3zcH2DYKKQK359GafPJv8NgEqYSFD16fbtIQ4=;
 b=EKbokWzOKCOLqhePSus6+FvwuA+Fd7RTYB6VVibAhgWUFpOiNuzontcxUaptCgdoXhiw0DwcOjz/r4hA44C4yCa2KbpYUlvwkGjPpD5LLJEGccnToZuLADxZJ1HdIBmbxR1JI83noVhciLwX8rsiN+FlRoOSh6z34jDVuwgb4qG45RlAA6YRNdz43keHNnFrn+L3BDeDvFszATVEOMz1yo0Ss3Rs3Z3GLLC85y6hKSNntleDWWiqYrbyM23PJ9yJKfueRtsKLLA1TAjswVAhj/KwJFQMWF87zZOWlgX1t0tvcUtlZBHjko5tmsX/8liccZYhug0lQKNvPnPM4ApNXQ==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:50 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:50 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 =?iso-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>, Stefan Roese <sr@denx.de>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 11/20] drivers: gpio: add support of RP1 GPIO for
 Raspberry PI 5
Thread-Topic: [RFC PATCH v1 11/20] drivers: gpio: add support of RP1 GPIO for
 Raspberry PI 5
Thread-Index: AQHbd7br0krOXg/E+0+QGJmDUkVo/g==
Date: Wed, 5 Feb 2025 10:15:45 +0000
Message-ID: <3f36c2863ec3dfc5efe297b80c25e315a59260e5.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 8d837b67-b9d5-46ad-c702-08dd45ce1098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sp74VfDSHN4atViDudUKoVOZXAhLtnpwrb5wLpIZcZOsixvrqS+RE5+YyT?=
 =?iso-8859-1?Q?ITcr00fOCqWshIsQH7LlvkoW1iFenez+e9mVtmknaa7Gg/2x5d76cSw9YQ?=
 =?iso-8859-1?Q?93mUrQmKA1Lzog1VNLGk68OL7B4ed8pQeIjM7jN706wtPNdgoML0A11DRY?=
 =?iso-8859-1?Q?3Kjjq3WdhH94GziY2i3WRDspWaDtIpGAJB7dlT6Jpmq20n/cv4CAoIqpBi?=
 =?iso-8859-1?Q?T9sbym9MByJER/pHCqG37qTxt4r8/arA+iDiywrrGWZGBfzDxoeQot9GiE?=
 =?iso-8859-1?Q?Bn0mrneHj5/FGZfppzYOOASRq+TJyFg9zZIl2j/YSK9cHgO9xEELBaemV5?=
 =?iso-8859-1?Q?0ulKAnghsSylv8bNGKU//oAe6oExUWgFAsDeLyJQ6CDiHIPfPTPHADnbUf?=
 =?iso-8859-1?Q?gjuWtRtip1WLKD32SpFcv1mS/zeqDPKyIO0ApajNKpqz9tzLIy+fUd9yR+?=
 =?iso-8859-1?Q?wbtQjpW8lI4oJcf3I9yQQ3f4GyGfzvG1o7YQMqvsqPI8cgsbZcn2Q52w1j?=
 =?iso-8859-1?Q?8Ws19WrhkNPiaa4q15P7jeimv5kW+ufQYGjSAFQfWR8vsirQdozt4uVWeI?=
 =?iso-8859-1?Q?GE/gTVJbvvKyEkCSxdQWthfM/r1GGfc41LXKTSS6hZKVa3N1rzx+zDLex4?=
 =?iso-8859-1?Q?Xhe0GXaidPDT2qUmXWd1jtKhiIY/YzZnG6gC5GoCx3aQTti4X01Aex3kZj?=
 =?iso-8859-1?Q?YWAucG5pXJQYy6kl19QPWGOyWUiF4pIPhK6BGc92NhepVyNOXT7pDDeTWa?=
 =?iso-8859-1?Q?yfcn+u/giBZh8ItKzsDs1kGL4NzPSTeleiYwMsL/6VtbIJPVnrSpHkkfrH?=
 =?iso-8859-1?Q?4ZNr/A/y6t6pAyAOs1l5wl2szrLhAJTdK7qNcWt44LG2/t8EYuB6GyBCGs?=
 =?iso-8859-1?Q?AoyF0zbML8lU/DXNm5A9nqWYbftL+32thNU4RdruEjV6QAiadJBDQuKs/B?=
 =?iso-8859-1?Q?PKJNt7BYFd82fH86dUHLUZqHNE8yy7iLwF+jSbOC8mOnnAmaV5wb6mgKGn?=
 =?iso-8859-1?Q?LZHbexzHCE0gsAXqaYiZPkJHrRITnecUEJTTG0GsP/PY+pKhZoKeLndDWr?=
 =?iso-8859-1?Q?ny+6LggD8k12/90+CEftbpRGkFdev30FYo62JdNh/3KeV9OwXm5jXyn/Z1?=
 =?iso-8859-1?Q?lXIqFnIBO2GMeGxoIkt5oYw9AqNDZt0/6XhUcRY8bgGKtuP55qhN/bWCwn?=
 =?iso-8859-1?Q?P3bGiBcEBapY3YN6sdH3zjaLFVihcfPnzAuzOW3jptRn87nleWdKExcWRG?=
 =?iso-8859-1?Q?DoxdSp0tptRoHJPkYpGI0abSdRcDT4E1Zx4+01+xdXMAcrQLivg6IoU0CS?=
 =?iso-8859-1?Q?mrUveBiQk+0wO++uuMDuBUtFDd1r1DbRA5BENNItwTKelamXhe/qlZWtTf?=
 =?iso-8859-1?Q?Df5wVWnganUhik3YAa5EbZ8q/PWqawOZDRKV9rcVZybvI1JXDasD6TO1ez?=
 =?iso-8859-1?Q?jati95pLTcLE8B1LrPH+O9AKoIG2jtwTRFiFgkujhl1o+maQLoM2wVDKRL?=
 =?iso-8859-1?Q?umgpBcGYiLxxLzZWs7jxLb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s9tpQj4U3z/H/n3OZ2gIdKRmbk8mw7/nsBuIpVF/2xSWMFWnRk5Jb+IYgd?=
 =?iso-8859-1?Q?EXBfV6vQktexL1PFG694LoUcECkBbDUz/1gFMuD7zwf7JT88ubonPmrT10?=
 =?iso-8859-1?Q?oE1SelyUvyqu9fK1DGzceFHOXAOdzUYmo6AIpYcakw4a3nf8uMEDeJvmjj?=
 =?iso-8859-1?Q?d8Hcfp/WHq6XLJ/YR7p9ar90l+FxQM9xGD+xxLmsw/eQAEYHisSoZkoeRi?=
 =?iso-8859-1?Q?tGMD4Gmspw38uYvsOGds4YTWY+30nJRoC6ugSL4tvyUrJ/w2lwa03T2uxS?=
 =?iso-8859-1?Q?hXkl6ufXjtsDOlek9kDbwvOnSIR6WqyUEBqoObVPhOoGrLFNk4tHZaXCY4?=
 =?iso-8859-1?Q?7kOk8fHdOPIatc+XFGmVBGTUZxvOWwgfDqDD1DkXOxhY1NESrvLTzB2akR?=
 =?iso-8859-1?Q?ASxG5AMGFCrRS3h+8Tsicu4lZBcDpryP0RcYME9RywHjU7hLBpVBWQY2hp?=
 =?iso-8859-1?Q?NulcGfRJEWXls3Fc+Loot5qd/Y0uRPXDERbStbdJscDTqVHTgFuspgUWtX?=
 =?iso-8859-1?Q?PrH1OfPFGTT4edqehGiCRm8VbeFpoJHygfTgjQR/ZibJ9OzV4Wi28L2eTz?=
 =?iso-8859-1?Q?SVXO0gO4fs24RYCGPW7hlaZCZ8XthHM/4JBY6hyzUu54mpdPNOj+zTgqO2?=
 =?iso-8859-1?Q?Ej3cuMYejiSM8x9snZEbZhegs3CVUOQBrpB2HsdwZ7aYbFaJdNR911/Z2e?=
 =?iso-8859-1?Q?1DT3uivazQBg0HJpGIZnvtzF24vRXyyC8ivHyKt6LdM4PyV7Uul+XSGVFv?=
 =?iso-8859-1?Q?9pC/dbsyKRlmjqar2T6AW91V04gL1aP8x4tI8RF7iZ/rynAParkwEJNJw5?=
 =?iso-8859-1?Q?W73D79CrYZqn6WRH+GkRYtxaQ1DvlaPowjZxWBb72h2yvsKNUkZxsTT/qa?=
 =?iso-8859-1?Q?ssOP6cv6pykGKFYpVn8ioTruaP2czRTdSP0MGe2S2XY4oA0M4mI3yFPP7a?=
 =?iso-8859-1?Q?ebK4ibDucUAY5wMGpNxCVaO8V8UDwiDqVoTnOQph0EGBaQbvadBIKS6qHO?=
 =?iso-8859-1?Q?haE/3o/1kwDdBYeLyh0/7TFHMFLDtVs7S2BNBpSEuNbY+vD52S3KOVd6tQ?=
 =?iso-8859-1?Q?nYa+zme7/34XwkV1kVE11z/kSKWThlGRLf3qdkkIwoxh1R4AiC7RrLCwGc?=
 =?iso-8859-1?Q?MccQi/Q+OwYb3hPd7550/+H8rsA/RC1F2O0Q7UCKmuTs8VkG1JaR6qQf/x?=
 =?iso-8859-1?Q?NbLj1wpvl8eaOyEkbJYmRg9kMaeaTVsn2XI+re0sqnkj2PN/eooUC5R7kl?=
 =?iso-8859-1?Q?PLl7IEGp3pgPJONUZUyK0EqfytkmiZGB9UoE3CN9f5A+6IIdSVHhr3YI2m?=
 =?iso-8859-1?Q?9kPu1VOAoHpd4f/UVxpsgohbscxJcQzCf2WXAAgemzCkvJowsDIVHyyCTx?=
 =?iso-8859-1?Q?E1YuoJYNDa/wO96NGWIZ8cdkLIJsqZudOk8AoxvyN6rUHd3sCDsQHPjHEc?=
 =?iso-8859-1?Q?IzTBJG9JtHGII5LmdBzOx9SDs5c83fDwcQZTsTp81oiQoLmEnUU8z8qmp/?=
 =?iso-8859-1?Q?SVrV5y/ky5pG030BJ3kpQ60Ue9/uQumsoiG3N5hejNBjFj5TCoVFOkutGm?=
 =?iso-8859-1?Q?ceXE4rJ/e1mE+AuA1zW/PL81tY8Mhivfu1tL2kitcicgQw/ZfIdbFURO1n?=
 =?iso-8859-1?Q?px6ZWnbisgSlRiSEr7KWpKa0TeRf71cgUrfBEFo7ekohLmjINDWj1cIw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d837b67-b9d5-46ad-c702-08dd45ce1098
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:45.5220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9lITAZ7EI9Egyit8hS5sJeZZSWn1tRxZK5L7KjtRuqEQi3m1qhPc83/s05nw40qVmp/78r+dNaRNaXI7WAgl3iNVxsjbv5HibiTMvIbIpM=
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

Raspberry PI5 has an external chip RP1 installed which provides
it's own GPIO controller. This driver implements GPIO support
for RP1 GPIO controller.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/gpio/Kconfig    |   7 +
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/rp1_gpio.c | 374 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/gpio/rp1_gpio.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b050585389..74d5a4dbbc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -340,6 +340,13 @@ config RCAR_GPIO
 	help
 	  This driver supports the GPIO banks on Renesas RCar SoCs.
=20
+config RP1_GPIO
+	bool "Raspberry PR1 GPIO driver"
+	help
+	  This driver supports the GPIO banks on Raspberry RP1 chip.
+	  Raspberry PI5 has an external chip RP1 installed, which
+	  provides it's own GPIO controller.
+
 config RZA1_GPIO
 	bool "Renesas RZ/A1 GPIO driver"
 	depends on DM_GPIO && RZA1
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4a29315435..29d0bdf343 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_NPCM_GPIO)      	+=3D npcm_gpio.o
 obj-$(CONFIG_PCA953X)		+=3D pca953x.o
 obj-$(CONFIG_ROCKCHIP_GPIO)	+=3D rk_gpio.o
 obj-$(CONFIG_RCAR_GPIO)		+=3D gpio-rcar.o
+obj-$(CONFIG_RP1_GPIO)		+=3D rp1_gpio.o
 obj-$(CONFIG_RZA1_GPIO)		+=3D gpio-rza1.o
 obj-$(CONFIG_S5P)		+=3D s5p_gpio.o
 obj-$(CONFIG_SANDBOX_GPIO)	+=3D sandbox.o sandbox_test.o
diff --git a/drivers/gpio/rp1_gpio.c b/drivers/gpio/rp1_gpio.c
new file mode 100644
index 0000000000..a64af18fcf
--- /dev/null
+++ b/drivers/gpio/rp1_gpio.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 EPAM Systems
+ *
+ * Derived from linux/drivers/pinctrl/pinctl-rp1.c
+ * Copyright (C) 2023 Raspberry Pi Ltd.
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+#define RP1_NUM_GPIOS	54
+#define RP1_NUM_BANKS	3
+
+#define RP1_RW_OFFSET			0x0000
+#define RP1_XOR_OFFSET			0x1000
+#define RP1_SET_OFFSET			0x2000
+#define RP1_CLR_OFFSET			0x3000
+
+#define RP1_GPIO_STATUS			0x0000
+#define RP1_GPIO_CTRL			0x0004
+
+#define RP1_GPIO_PCIE_INTE		0x011c
+#define RP1_GPIO_PCIE_INTS		0x0124
+
+#define RP1_GPIO_EVENTS_SHIFT_RAW	20
+#define RP1_GPIO_STATUS_FALLING		BIT(20)
+#define RP1_GPIO_STATUS_RISING		BIT(21)
+#define RP1_GPIO_STATUS_LOW		BIT(22)
+#define RP1_GPIO_STATUS_HIGH		BIT(23)
+
+#define RP1_GPIO_EVENTS_SHIFT_FILTERED	24
+#define RP1_GPIO_STATUS_F_FALLING	BIT(24)
+#define RP1_GPIO_STATUS_F_RISING	BIT(25)
+#define RP1_GPIO_STATUS_F_LOW		BIT(26)
+#define RP1_GPIO_STATUS_F_HIGH		BIT(27)
+
+#define RP1_GPIO_CTRL_FUNCSEL_LSB	0
+#define RP1_GPIO_CTRL_FUNCSEL_MASK	0x0000001f
+#define RP1_GPIO_CTRL_OUTOVER_LSB	12
+#define RP1_GPIO_CTRL_OUTOVER_MASK	0x00003000
+#define RP1_GPIO_CTRL_OEOVER_LSB	14
+#define RP1_GPIO_CTRL_OEOVER_MASK	0x0000c000
+#define RP1_GPIO_CTRL_INOVER_LSB	16
+#define RP1_GPIO_CTRL_INOVER_MASK	0x00030000
+#define RP1_GPIO_CTRL_IRQEN_FALLING	BIT(20)
+#define RP1_GPIO_CTRL_IRQEN_RISING	BIT(21)
+#define RP1_GPIO_CTRL_IRQEN_LOW		BIT(22)
+#define RP1_GPIO_CTRL_IRQEN_HIGH	BIT(23)
+#define RP1_GPIO_CTRL_IRQEN_F_FALLING	BIT(24)
+#define RP1_GPIO_CTRL_IRQEN_F_RISING	BIT(25)
+#define RP1_GPIO_CTRL_IRQEN_F_LOW	BIT(26)
+#define RP1_GPIO_CTRL_IRQEN_F_HIGH	BIT(27)
+#define RP1_GPIO_CTRL_IRQRESET		BIT(28)
+#define RP1_GPIO_CTRL_IRQOVER_LSB	30
+#define RP1_GPIO_CTRL_IRQOVER_MASK	0xc0000000
+
+#define RP1_PUD_OFF			0
+#define RP1_PUD_DOWN			1
+#define RP1_PUD_UP			2
+
+#define RP1_FSEL_COUNT			9
+
+#define RP1_FSEL_ALT0			0x00
+#define RP1_FSEL_GPIO			0x05
+#define RP1_FSEL_NONE			0x09
+#define RP1_FSEL_NONE_HW		0x1f
+
+#define RP1_DIR_OUTPUT			0
+#define RP1_DIR_INPUT			1
+
+#define RP1_OUTOVER_PERI		0
+#define RP1_OUTOVER_INVPERI		1
+#define RP1_OUTOVER_LOW			2
+#define RP1_OUTOVER_HIGH		3
+
+#define RP1_OEOVER_PERI			0
+#define RP1_OEOVER_INVPERI		1
+#define RP1_OEOVER_DISABLE		2
+#define RP1_OEOVER_ENABLE		3
+
+#define RP1_INOVER_PERI			0
+#define RP1_INOVER_INVPERI		1
+#define RP1_INOVER_LOW			2
+#define RP1_INOVER_HIGH			3
+
+#define RP1_RIO_OUT			0x00
+#define RP1_RIO_OE			0x04
+#define RP1_RIO_IN			0x08
+
+#define RP1_PAD_SLEWFAST_MASK		0x00000001
+#define RP1_PAD_SLEWFAST_LSB		0
+#define RP1_PAD_SCHMITT_MASK		0x00000002
+#define RP1_PAD_SCHMITT_LSB		1
+#define RP1_PAD_PULL_MASK		0x0000000c
+#define RP1_PAD_PULL_LSB		2
+#define RP1_PAD_DRIVE_MASK		0x00000030
+#define RP1_PAD_DRIVE_LSB		4
+#define RP1_PAD_IN_ENABLE_MASK		0x00000040
+#define RP1_PAD_IN_ENABLE_LSB		6
+#define RP1_PAD_OUT_DISABLE_MASK	0x00000080
+#define RP1_PAD_OUT_DISABLE_LSB		7
+
+#define RP1_PAD_DRIVE_2MA		0x00000000
+#define RP1_PAD_DRIVE_4MA		0x00000010
+#define RP1_PAD_DRIVE_8MA		0x00000020
+#define RP1_PAD_DRIVE_12MA		0x00000030
+
+#define FLD_GET(r, f) (((r) & (f ## _MASK)) >> (f ## _LSB))
+#define FLD_SET(r, f, v) r =3D (((r) & ~(f ## _MASK)) | ((v) << (f ## _LSB=
)))
+
+struct rp1_iobank_desc {
+	int min_gpio;
+	int num_gpios;
+	int gpio_offset;
+	int inte_offset;
+	int ints_offset;
+	int rio_offset;
+	int pads_offset;
+};
+
+const struct rp1_iobank_desc rp1_iobanks[RP1_NUM_BANKS] =3D {
+	/*         gpio   inte    ints     rio    pads */
+	{  0, 28, 0x0000, 0x011c, 0x0124, 0x0000, 0x0004 },
+	{ 28,  6, 0x4000, 0x411c, 0x4124, 0x4000, 0x4004 },
+	{ 34, 20, 0x8000, 0x811c, 0x8124, 0x8000, 0x8004 },
+};
+
+struct rp1_pin_info {
+	u8 num;
+	u8 bank;
+	u8 offset;
+	u8 fsel;
+
+	void __iomem *gpio;
+	void __iomem *rio;
+	void __iomem *inte;
+	void __iomem *ints;
+	void __iomem *pad;
+};
+
+struct rp1_gpio_priv {
+	void __iomem *gpio_base;
+	void __iomem *rio_base;
+	void __iomem *pads_base;
+
+	struct rp1_pin_info pins[RP1_NUM_GPIOS];
+};
+
+static struct rp1_pin_info *rp1_get_pin(struct udevice *dev,
+					unsigned int offset)
+{
+	struct rp1_gpio_priv *priv =3D dev_get_priv(dev);
+
+	if (priv && offset < RP1_NUM_GPIOS)
+		return &priv->pins[offset];
+
+	return NULL;
+}
+
+static void rp1_pad_update(struct rp1_pin_info *pin, u32 clr, u32 set)
+{
+	u32 padctrl =3D readl(pin->pad);
+
+	padctrl &=3D ~clr;
+	padctrl |=3D set;
+
+	writel(padctrl, pin->pad);
+}
+
+static void rp1_input_enable(struct rp1_pin_info *pin, int value)
+{
+	rp1_pad_update(pin, RP1_PAD_IN_ENABLE_MASK,
+		       value ? RP1_PAD_IN_ENABLE_MASK : 0);
+}
+
+static void rp1_output_enable(struct rp1_pin_info *pin, int value)
+{
+	rp1_pad_update(pin, RP1_PAD_OUT_DISABLE_MASK,
+		       value ? 0 : RP1_PAD_OUT_DISABLE_MASK);
+}
+
+static u32 rp1_get_fsel(struct rp1_pin_info *pin)
+{
+	u32 ctrl =3D readl(pin->gpio + RP1_GPIO_CTRL);
+	u32 oeover =3D FLD_GET(ctrl, RP1_GPIO_CTRL_OEOVER);
+	u32 fsel =3D FLD_GET(ctrl, RP1_GPIO_CTRL_FUNCSEL);
+
+	if (oeover !=3D RP1_OEOVER_PERI || fsel >=3D RP1_FSEL_COUNT)
+		fsel =3D RP1_FSEL_NONE;
+
+	return fsel;
+}
+
+static void rp1_set_fsel(struct rp1_pin_info *pin, u32 fsel)
+{
+	u32 ctrl =3D readl(pin->gpio + RP1_GPIO_CTRL);
+
+	if (fsel >=3D RP1_FSEL_COUNT)
+		fsel =3D RP1_FSEL_NONE_HW;
+
+	rp1_input_enable(pin, 1);
+	rp1_output_enable(pin, 1);
+
+	if (fsel =3D=3D RP1_FSEL_NONE) {
+		FLD_SET(ctrl, RP1_GPIO_CTRL_OEOVER, RP1_OEOVER_DISABLE);
+	} else {
+		FLD_SET(ctrl, RP1_GPIO_CTRL_OUTOVER, RP1_OUTOVER_PERI);
+		FLD_SET(ctrl, RP1_GPIO_CTRL_OEOVER, RP1_OEOVER_PERI);
+	}
+	FLD_SET(ctrl, RP1_GPIO_CTRL_FUNCSEL, fsel);
+
+	writel(ctrl, pin->gpio + RP1_GPIO_CTRL);
+}
+
+static int rp1_get_dir(struct rp1_pin_info *pin)
+{
+	return !(readl(pin->rio + RP1_RIO_OE) & (1 << pin->offset)) ?
+		RP1_DIR_INPUT : RP1_DIR_OUTPUT;
+}
+
+static void rp1_set_dir(struct rp1_pin_info *pin, bool is_input)
+{
+	int offset =3D is_input ? RP1_CLR_OFFSET : RP1_SET_OFFSET;
+
+	writel(1 << pin->offset, pin->rio + RP1_RIO_OE + offset);
+}
+
+static int rp1_get_value(struct rp1_pin_info *pin)
+{
+	return !!(readl(pin->rio + RP1_RIO_IN) & (1 << pin->offset));
+}
+
+static void rp1_set_value(struct rp1_pin_info *pin, int value)
+{
+	/* Assume the pin is already an output */
+	writel(1 << pin->offset,
+	       pin->rio + RP1_RIO_OUT + (value ? RP1_SET_OFFSET : RP1_CLR_OFFSET)=
);
+}
+
+static int rp1_gpio_get(struct udevice *dev, unsigned int offset)
+{
+	struct rp1_pin_info *pin =3D rp1_get_pin(dev, offset);
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret =3D rp1_get_value(pin);
+	return ret;
+}
+
+static int rp1_gpio_set(struct udevice *dev, unsigned int offset, int valu=
e)
+{
+	struct rp1_pin_info *pin =3D rp1_get_pin(dev, offset);
+
+	if (pin)
+		rp1_set_value(pin, value);
+
+	return 0;
+}
+
+static int rp1_gpio_direction_input(struct udevice *dev, unsigned int offs=
et)
+{
+	struct rp1_pin_info *pin =3D rp1_get_pin(dev, offset);
+
+	if (!pin)
+		return -EINVAL;
+
+	rp1_set_dir(pin, RP1_DIR_INPUT);
+	rp1_set_fsel(pin, RP1_FSEL_GPIO);
+	return 0;
+}
+
+static int rp1_gpio_direction_output(struct udevice *dev, unsigned int off=
set, int value)
+{
+	struct rp1_pin_info *pin =3D rp1_get_pin(dev, offset);
+
+	if (!pin)
+		return -EINVAL;
+
+	rp1_set_value(pin, value);
+	rp1_set_dir(pin, RP1_DIR_OUTPUT);
+	rp1_set_fsel(pin, RP1_FSEL_GPIO);
+	return 0;
+}
+
+static int rp1_gpio_get_direction(struct udevice *dev, unsigned int offset=
)
+{
+	struct rp1_pin_info *pin =3D rp1_get_pin(dev, offset);
+	u32 fsel;
+
+	if (!pin)
+		return -EINVAL;
+
+	fsel =3D rp1_get_fsel(pin);
+	if (fsel !=3D RP1_FSEL_GPIO)
+		return -EINVAL;
+
+	return (rp1_get_dir(pin) =3D=3D RP1_DIR_OUTPUT) ?
+			GPIOF_OUTPUT :
+			GPIOF_INPUT;
+}
+
+static const struct dm_gpio_ops rp1_gpio_ops =3D {
+	.direction_input =3D rp1_gpio_direction_input,
+	.direction_output =3D rp1_gpio_direction_output,
+	.get_value =3D rp1_gpio_get,
+	.set_value =3D rp1_gpio_set,
+	.get_function =3D rp1_gpio_get_direction,
+};
+
+static int rp1_gpio_probe(struct udevice *dev)
+{
+	int i;
+	struct gpio_dev_priv *uc_priv =3D dev_get_uclass_priv(dev);
+	struct rp1_gpio_priv *priv =3D dev_get_priv(dev);
+
+	priv->gpio_base =3D dev_remap_addr_index(dev, 0);
+	if (!priv->gpio_base)
+		return -EINVAL;
+
+	priv->rio_base =3D dev_remap_addr_index(dev, 1);
+	if (!priv->rio_base)
+		return -EINVAL;
+
+	priv->pads_base =3D dev_remap_addr_index(dev, 2);
+	if (!priv->pads_base)
+		return -EINVAL;
+
+	uc_priv->gpio_count =3D RP1_NUM_GPIOS;
+	uc_priv->bank_name =3D dev->name;
+
+	for (i =3D 0; i < RP1_NUM_BANKS; i++) {
+		const struct rp1_iobank_desc *bank =3D &rp1_iobanks[i];
+		int j;
+
+		for (j =3D 0; j < bank->num_gpios; j++) {
+			struct rp1_pin_info *pin =3D
+				&priv->pins[bank->min_gpio + j];
+
+			pin->num =3D bank->min_gpio + j;
+			pin->bank =3D i;
+			pin->offset =3D j;
+
+			pin->gpio =3D priv->gpio_base + bank->gpio_offset +
+				    j * sizeof(u32) * 2;
+			pin->inte =3D priv->gpio_base + bank->inte_offset;
+			pin->ints =3D priv->gpio_base + bank->ints_offset;
+			pin->rio  =3D priv->rio_base + bank->rio_offset;
+			pin->pad  =3D priv->pads_base + bank->pads_offset +
+				    j * sizeof(u32);
+		}
+	}
+
+	return 0;
+}
+
+static const struct udevice_id rp1_gpio_ids[] =3D {
+	{ .compatible =3D "raspberrypi,rp1-gpio" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(rp1_gpio) =3D {
+	.name =3D "rp1-gpio",
+	.id =3D UCLASS_GPIO,
+	.of_match =3D rp1_gpio_ids,
+	.ops =3D &rp1_gpio_ops,
+	.priv_auto	=3D sizeof(struct rp1_gpio_priv),
+	.probe =3D rp1_gpio_probe,
+};
--=20
2.34.1
