Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED5CC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7847387BC3;
	Fri, 23 Feb 2024 12:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aF1S4uv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648FF83CF3; Fri, 23 Feb 2024 07:03:45 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E238272A
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 07:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jason.hui.liu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPKx1aqt3E+XQ49sYedDmgZ4sFkup/0ej0sFM2rAqD0LDS0sep5M4XrwUIIaQOzF32XZCdzc9SrUkzs4wduFflKNmSpALEWRw3dUWJON+1PuROJDmEfOccR+KZb8qed7iEED7CV6CPZUWSvzKzZKZ93to8Fr2yw0C58ZhEJ10Ts6dKf/XTYSpOcFcdCv757/uxKctJpHymDOjUO/uZoYxf3oQoLf/R8nrvZthlUEtdIgozNIQde6GgOhBxLy86avgfh7aiVuiU2fIyo+Ss6n7PJvj3AQVSF1NiSy9kHpLwOlhH81qi0p/psQVFWkDzb0DsjEdcSs+8o5tmYlPmc+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9X2zOisIK7LnTCIyMb9CvBCBcQThdbpChMMBkE974Y=;
 b=PbehKyKvC+0EdwGHhcH7iYwz7heWyqTTvUlavPBUViYpq2qzaCO+lIEaxBnx3QlhZBfMyMC7+KoeprxUcrzsc2q2c5nsNSkRHyRNED792BnKs+5LTfzD+bnqPuFkqzMZ/juSvkiaKwbbyukmq/DUFzvj3l0jFwFn+3gTue90GTjt8agAjdkIYxmGRRpPr+HaV43dwlq0gA6G7Qzj/hCxRV9NVoiUVj21V3kO/pAmH5s/7o6FDx+F0Qr5li23no4OJTHaJzpjxZKLjMJcGHt6OKqx9tUdpQ4LjIGooYA5I7c9Ajg/tWWgwwMV/Uiel3+NfMgpTTdOGca6+HsvwMwUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9X2zOisIK7LnTCIyMb9CvBCBcQThdbpChMMBkE974Y=;
 b=aF1S4uv7G16uMtShcv/gxNg+l7VLUoB3I7hcSHhkfddV8TBuOF9oNgw7anoHbV+1ZbillGVLAhG7I7pWn6OpAiSBTADJKD0z1rxSXSPAf8fyL4IdyVhALZoarHOAHc1P0BpMaRB8yNpfXpZRzDxSdi1cS6DCip75IbqNoAXbYsI=
Received: from PAXPR04MB8159.eurprd04.prod.outlook.com (2603:10a6:102:1c1::8)
 by DU2PR04MB8821.eurprd04.prod.outlook.com (2603:10a6:10:2e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 06:03:41 +0000
Received: from PAXPR04MB8159.eurprd04.prod.outlook.com
 ([fe80::473c:beaf:abb9:56a]) by PAXPR04MB8159.eurprd04.prod.outlook.com
 ([fe80::473c:beaf:abb9:56a%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 06:03:41 +0000
From: Jason Liu <jason.hui.liu@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "sbabic@denx.de" <sbabic@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] imx53-qsb: Convert to watchdog driver model
Thread-Topic: [PATCH] imx53-qsb: Convert to watchdog driver model
Thread-Index: AQHaZOz8lZkctt+Ot0iFcqjONP8VNLEVmH7N
Date: Fri, 23 Feb 2024 06:03:41 +0000
Message-ID: <PAXPR04MB815952CEAE947B5B30BF7ED3AE562@PAXPR04MB8159.eurprd04.prod.outlook.com>
References: <20240221173930.868473-1-festevam@gmail.com>
In-Reply-To: <20240221173930.868473-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8159:EE_|DU2PR04MB8821:EE_
x-ms-office365-filtering-correlation-id: 29c0f1a8-f0d3-4904-b587-08dc34352f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dekHZgVfbNZu2LPL0ndzMn1uSLdgAl1N79AkE1ZlueQFIQTucmrYTnCehQwE5Kvg6ETLME6cMHsmRq12RulkyI8tLwaPNxcU7RyYXAFtk3IOVHNvfZaTXhgBfNIXN3GJlZKH46O5JpJr+V2qVvvjGDMCsKlSHEMm5QAZMJ2TWxK6r0P9aCIgbUfHS3/v5wBpBGamF5IfPg0HbdbusZFEbvrbgw4ZXl6Kuz7HxcY2YO34btakS3GsrIw60aSNM7KKSLf0Otp5bTsNGLPtKdVG6AlHMTMQ2DCrZ7b9QuurzHEBB+8QhcBoLovXT4Ely8U9XOy+h4SwMSejAi6x022/vzECstc+14TwiumPuhu1z6jAk0tBPzup7W0YnTresZbyKwo4dwjHtGpB6nysI/zqFxeOZzLqybzIzPsrUMR9jEPqc4xE8ihmF54VVSyZ0GsHBEfppobzauftGU0a/oCH8Xv40FeTNvvao/D34nnI+N5Sc1+fqzwYT33MlTdugmX4+YXo+xFl6tkz1tYGYIKG7YFoKAorMMklKvuFYmOKdbfPuWOgEKuPKYQXeG5k+n5QwvCrW/UQi3Kpv1GbQMDyckas+DuTzW7ubAECQPNgxnOJbGSW73q3Qp0xSKOBmUwR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8159.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kCpiwF/xioKwDuGkh/A0FPx9dL1q62PBv/lJrtQt5mw2CafG9cMdLt2J0Y?=
 =?iso-8859-1?Q?OEgg31lsriQaSP1NGHOTvnH3xaH3kOh1k8/GavTymuvXvhhS8XfQ/zFr2C?=
 =?iso-8859-1?Q?lPQVJpuXadHjg9IP9l7sMma2DRZq499Lj/NKrsZEyyoQo03egbIFM9aJ0c?=
 =?iso-8859-1?Q?kbmnvLyGm1foags6GuE2Ux+VaL+RY0MRj4NSZMb4aqzrtNsKRGafEY29Ga?=
 =?iso-8859-1?Q?0wnHtQs9cdG26Tmx9ueY/6LoUCM8uDrYweedL+6hXgeSp+vvW/b4ITMBEJ?=
 =?iso-8859-1?Q?TzYASt5yOMOIEmLzFjwM63SE2icm00eoXXLIiW9AcRAOtF4npPpmlEtIVV?=
 =?iso-8859-1?Q?pSkpnS2QxadmLCHFBVHUopJtOai6S5YAPycENXaKMeFNBx8OwxCrbmavCi?=
 =?iso-8859-1?Q?bcl+NRf1ktV4rylRD7ZeyPEHxIYnS1w08NFvbQkUN7wMYQoslAGOfi8RaK?=
 =?iso-8859-1?Q?b4CFHlM+u9w+1UhuU+2smbgbKGh7hLJ6mp7nN/qbGuUA257VV4sbXje5/S?=
 =?iso-8859-1?Q?hC73bqQOIRXz9/ERMonAoKWausE3YcWAyrgpwb+gITwVocC5bOoNdWW44j?=
 =?iso-8859-1?Q?LOUECI4N1r1bZ4i99EHgAIiQQ8s8ozwxvgnKLAS4Ro9oNi34OGDXjC9pDK?=
 =?iso-8859-1?Q?epFNWTLTABD9mozGf1Hwr58GJ0NUMGPlztHGjxTYYRzlOx6YIFzLhM4X8n?=
 =?iso-8859-1?Q?KXlsVFct05kFlYpf/UayiNPWUl/NvAK7kSxFjrEOFZL4eX170LYnG90WvM?=
 =?iso-8859-1?Q?n7nrtFld5qgdvs6WogBo0uTuIGMRcUhUMhMvc00aFjkfPJ9YcEoR0eoIB1?=
 =?iso-8859-1?Q?+8GBPBLi+GG++pWBKEjxrecWdRzn/bDOZQuYpH+e//TlYsOlyGHV5v7uen?=
 =?iso-8859-1?Q?LF2hzn9mSpYitxdF3wboL6qy3oEOoSoj53CpRM1NzPo7GFs0e+tUFrW+Ep?=
 =?iso-8859-1?Q?5DRj61mL1/p6bPFYZmTDVOELKzhedZxLX7wo8xn03dhUFqCICmWczaNago?=
 =?iso-8859-1?Q?I5PqllfVBv6NECYmOTvUIinMi65n/PduKKZWj9Wt5qcMVO3UGohEqmb0p1?=
 =?iso-8859-1?Q?qJIis1TcfPO/VOlr3vf+wEM7JWBWinKlJ7wns4vhVUvSA/j70f0tm1YmpA?=
 =?iso-8859-1?Q?2zbOgWM/EQg8KOjb0LOR4EmP0QhwWJVj3RKL3Q1VqSVvKWbo7QEh0T763H?=
 =?iso-8859-1?Q?xg3xSfdRFSJNmNit0vF2BTac1XZKCmiUwEs2QZNa7W/RHPHcJXYiW+hpbk?=
 =?iso-8859-1?Q?HWqklBVSIcCySKJ7En1/MSKN29hMPnz0zNYJVBjt6mUm0kYRo94CnxBCSp?=
 =?iso-8859-1?Q?htYp6Pw+XA9KQP2m0VJB1ZGNgzComslFCTbWimediESdKtwYm3Uc4d87nY?=
 =?iso-8859-1?Q?DSzxFtotboIOofMk3y7XdrCq1XpuwEqJWyq60b/eOLvjFFQbUprxiWgqm7?=
 =?iso-8859-1?Q?CHy+ha+7Aqw93FPgAasUs/owkbgH2f5802bKyp7sehy9J7KBIRXtyeNlR9?=
 =?iso-8859-1?Q?j+DWGjesWLvxAbnfVFz2pgrr6EvFbypbCWyHOpCd30uS9YsROv88NySZqb?=
 =?iso-8859-1?Q?++E1+d4oiz4f8XWCCFlB3ky94V7dUnaqLQv4weJXOihMadnVJSTvScyh8s?=
 =?iso-8859-1?Q?xWlHYChaAzV0CBdlH6iikGIjzc9zgSmrzH?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8159.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c0f1a8-f0d3-4904-b587-08dc34352f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 06:03:41.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UPWRBTe6xqXdIACajxit88zib8eQGdgbASfYFs0pzpGqoSYS7Xu7C2ZvfhXeUiGPDNz4SYILsAOkrB0+keLMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8821
X-Mailman-Approved-At: Fri, 23 Feb 2024 12:56:25 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


________________________________
From: Fabio Estevam <festevam@gmail.com>
Sent: Thursday, February 22, 2024 1:39 AM
To: sbabic@denx.de <sbabic@denx.de>
Cc: Jason Liu <jason.hui.liu@nxp.com>; u-boot@lists.denx.de <u-boot@lists.d=
enx.de>; Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx53-qsb: Convert to watchdog driver model

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.

Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/imx53-qsb-u-boot.dtsi | 14 ++++++++++++++
 configs/mx53loco_defconfig         |  3 +++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/dts/imx53-qsb-u-boot.dtsi

 Thx for the fix.

Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>

diff --git a/arch/arm/dts/imx53-qsb-u-boot.dtsi b/arch/arm/dts/imx53-qsb-u-=
boot.dtsi
new file mode 100644
index 000000000000..593ab7caa635
--- /dev/null
+++ b/arch/arm/dts/imx53-qsb-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/ {
+       wdt-reboot {
+               compatible =3D "wdt-reboot";
+               wdt =3D <&wdog1>;
+               bootph-pre-ram;
+       };
+};
+
+&wdog1 {
+       bootph-pre-ram;
+};
+
diff --git a/configs/mx53loco_defconfig b/configs/mx53loco_defconfig
index d4de8df7b49d..e2d3bc0b094e 100644
--- a/configs/mx53loco_defconfig
+++ b/configs/mx53loco_defconfig
@@ -60,6 +60,8 @@ CONFIG_POWER_FSL=3Dy
 CONFIG_POWER_I2C=3Dy
 CONFIG_DM_SERIAL=3Dy
 CONFIG_MXC_UART=3Dy
+CONFIG_SYSRESET=3Dy
+CONFIG_SYSRESET_WATCHDOG=3Dy
 CONFIG_USB=3Dy
 CONFIG_USB_EHCI_MX5=3Dy
 CONFIG_USB_STORAGE=3Dy
@@ -67,3 +69,4 @@ CONFIG_USB_HOST_ETHER=3Dy
 CONFIG_USB_ETHER_ASIX=3Dy
 CONFIG_USB_ETHER_MCS7830=3Dy
 CONFIG_USB_ETHER_SMSC95XX=3Dy
+CONFIG_IMX_WATCHDOG=3Dy
--
2.34.1

