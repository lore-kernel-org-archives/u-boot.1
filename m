Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E14CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 16:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E2186908;
	Tue, 19 Sep 2023 18:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arrigroup.onmicrosoft.com header.i=@arrigroup.onmicrosoft.com header.b="VHxGOeaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BF786AE2; Tue, 19 Sep 2023 14:47:45 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFBA803AC
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:47:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=LPolak@arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjzTGS0mT/Nhl9fi/OKhGmc1mPum/e4Ac6m8jml+w0jiGqry+j41Knb6JKv3Rb6AGWVk7kM4UG6BbEQ6wVBewwSZe4nFEb7R2D3NhwM+MUjoBxtOLuZ0s1tF7glWgv9QBqN+wFh0ae1mG2XKE2gd9ZE7t3IEGTQ95MaDt1QjvL3OP+RpTNP9NiFcnOiRUGLPlIO0c6Q5vHRPGCAFJanhXTwalHAsbmYO3TsiMc76Y6wvH6CdJryqqvUTIYNbF5QlrCjRYml/Oe4l6Zj/5gQFS12qHkC3LAmKReO736OYxvXy4D/8br5CPZg+qaeIYeN+WlJ6WPAbq5B/wpW0Buub7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VSAWYkV0r30WzEZCsRPRuxWvPwglL11R+lK/j91Xo0=;
 b=jjhhq9PBjVo6/LrOd+cQKN7yqgmj7qt6yu2/33Gnwx5N4XxXkSmUFgFsAEJv0y0FbFU8lugnMO7cRWorIAaDZJ+wm3osInnNjDw0ZEQVmqvcmqKqK51UFLKH4xf6lYnBV+LHcjdHiccnRTWUHJuEbjKRev1GKxWaSGUEK0qRN8nzIEj/JzMrHop2PqzWjVB81Od3iTdPJ4Zy2Bnp9JNzcz7vUKHg5gZJBH2uoNyyyKqt4Y91MJPrccu080ginSmXc+cxCgc5GIKHqbpEdw1eHWVTxTMaDBBgxuMksIaXLh12PcOQ3jOt4f31rHhn/DycqgA/Sdow5uXID943hOLqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VSAWYkV0r30WzEZCsRPRuxWvPwglL11R+lK/j91Xo0=;
 b=VHxGOeaX9G6P4izmyoI4JpblFrgXnuKk7gxDi0qlu4yaH1tjc8fj774RFysyuAykAluGE4F5ctbqSHyyPq7yV/v/nYaOKKM38Fqu8m5ZQKqDmsIDmXXU4qv2+VBjAlMGk5Qz6G0/7u2hwIi5IfOPHpFLF+02VeHQmCnIi1QafoQ=
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com (2603:10a6:10:353::13)
 by VI1PR07MB9541.eurprd07.prod.outlook.com (2603:10a6:800:1cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 12:47:41 +0000
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::eb54:a70:758:cdfd]) by DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::eb54:a70:758:cdfd%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:47:41 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH] arm64: versal: Add SelectMAP boot mode identification
Thread-Topic: [PATCH] arm64: versal: Add SelectMAP boot mode identification
Thread-Index: AQHZ6vbl8dKKxnPer0uBBBwY/fz6pQ==
Date: Tue, 19 Sep 2023 12:47:41 +0000
Message-ID: <DU0PR07MB8419EB5D613237A44374949DC8FAA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8419:EE_|VI1PR07MB9541:EE_
x-ms-office365-filtering-correlation-id: e3919dd1-fe72-4538-1d97-08dbb90e9cfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GII/dV26ypHnDNQVukfqZqvx4yrGsRCn/oGbiTIQw35b9rhmW49ynsCcytIQrpVgoJhCKHaUafRgItvE81NZLjOFGeI1Hu0YElrrtyz4BFAwD9HnyizzfwvuNGLcVukKFS9DTKSqMfbTrO4MgEySTgDAd32suSBZYaTPmEwj8y0fWBoc+bR1gxQwBDJshjvA/zW4qZrUy6HN4bvsG2ZngWiNGtDlpvdipU88ioCrlv4TDtrCCTBlgApGKSLOIg47P6pgKz0e+0sFuj06+j2a7TFVAkE17HPb9jTk9yQ8hQlxcrM2WAvaqyqsdCQfjNWHGjD7WFDYVZT270vz5RVypEVBQTB0mjGzl1kJRUooirYN/QWWFJbg09k3+kRIqDws7AHK+E0Vp/7uymaIw0JSRdId0a2h4qGgMxHJQhsQ/CN2VcWQUG8KSSaycG6K+OEMoodRH1WABCMiRXMuuNb3LAvDE/Go0n5FUlzJD8F9TJdlwJpQO+YGCpUAWSUYWpeOzbZOa5rEqw8esIUF8miyW7knC7h7gxaZFcNttWT+EA/wayo5W4G1q58o3MRIKYxRYMdfimtsbiJNvF9lUEbnCR9jc9V8bzCyVR4cR1aUbaU4bNBulD2lIs6xUyE+v/F4gdHMIIsmKDNNkEOY3bB1pW47wTgT3Hs9BJvXhSFCYTk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8419.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(396003)(346002)(376002)(1800799009)(186009)(451199024)(55016003)(33656002)(6506007)(7696005)(2906002)(9686003)(71200400001)(478600001)(86362001)(26005)(6916009)(316002)(66556008)(76116006)(66446008)(66476007)(64756008)(54906003)(41300700001)(66946007)(4326008)(8936002)(8676002)(52536014)(91956017)(5660300002)(38070700005)(38100700002)(122000001)(55236004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5cm1hNtu6rhah0a/EitIjcxdXOgA/mH5OfdjXTbfeQ/UumpVOqynxQUOXh?=
 =?iso-8859-1?Q?7/ivHICCWC9ORq0iyyiJ2Ta3wY1nNIu4HnFZqiTSTP1MbtI+kGhTkHmtMw?=
 =?iso-8859-1?Q?a1epdNxljdf0EGiW4fJket2FXNailArg5/gKwchi+R+3TqzvKB82dB6Hvz?=
 =?iso-8859-1?Q?ClYmnN9UL7cl9DqNuJShBSlDsTgv7ec9WlU+/HAPETfEXvm6dti7rcezvb?=
 =?iso-8859-1?Q?L6C5DGvRU8wVRmadZygW2uHwRD7LrSk4yZ47CdnzM0gFTzh3fUMaHnqS86?=
 =?iso-8859-1?Q?iRJM4jhWGplXxQiLubYawOpFEfnRtEjjNoUDOkAwNvOBzAvefPnBNbpyxz?=
 =?iso-8859-1?Q?TW4IxDpERP8+p6MoGhuGwZosOHvcJ8w7GBFqnWFGYeWK8848eUJuew0bQ4?=
 =?iso-8859-1?Q?+h7kD115v2haiQwezt4jepiRt23eWokWBBF/B4CjG8FhDoP8fujhjn2Iuv?=
 =?iso-8859-1?Q?sOz89kidw4HCYYiniXGCr9dHyEynBLPDsCs4NOFz4Q7IMQWjfG8ftT1asS?=
 =?iso-8859-1?Q?VBmWAUQnWTKwyt5GTbbeR5svDPqnUWg5FaOvTvOl1LfZm3ew7XweDyd5HA?=
 =?iso-8859-1?Q?W5peCfKIWGkNkggjCkE3QbZX556R735kuDB6eqmqEx3W1g3S3XFcJ3N9QL?=
 =?iso-8859-1?Q?dJw7Xs47ma4LivdgxNnrCs6RmtDT34v9BaexxWUmPBtVmDdiAoZusl/iwX?=
 =?iso-8859-1?Q?jrGJ9l5ITFMJnS7U+qWPGjhH5E8FQti2EdGLraMx7aLYorMFpmhsiHhl0D?=
 =?iso-8859-1?Q?IkPSZ/QqqnjA3p2I4W4dToCL3Zrm0JKocsLZgu6pYaRJF7xIZZ8nh3Nn4V?=
 =?iso-8859-1?Q?Kr4cQcx29lcoIAhpC1IHsEXMWhUnf/ICcoIHMd9jWar2IHhNB5XwFEV5oN?=
 =?iso-8859-1?Q?GfN3zE1UIZWMkizNhJlpr+JiJ/sce8qVluS8snuqkZEbHlOpewdDBCzMja?=
 =?iso-8859-1?Q?J6q4q4Gq5NEd2CZH+J7Xq7REZyfBENU50N/Jrm26n65GQ9wekaR539djP/?=
 =?iso-8859-1?Q?K7KzCC0r8sGyfoxMWGB95GyWWgKrA1iA9R+Y5DYwt4bBasmBe/bEUSshoR?=
 =?iso-8859-1?Q?sgiPAmkNLIqoH6JTdIsjFJRcfShwQ0vH+WZzoirT5nsonor8QVac7WIXsc?=
 =?iso-8859-1?Q?GA+xQCZfWLyQDF+xrdPDp2NMFGd1FM5k0lNfnFf8gpkkyIkkVsnu9PDDbJ?=
 =?iso-8859-1?Q?87qNnUGTwvBQkbee1SoW63VHurK4zC4JoJy9gY3UKz4QO9E8+BSowh6ZbK?=
 =?iso-8859-1?Q?2D45BxwllHJKQrI+OuOKJCN/sSaW1pjJpgKKMmwgX/MTsdzfr+6xWtIqn+?=
 =?iso-8859-1?Q?UoxvjQbxLYRSJKkOhB8zfqXs9l8I0WASiApKJOSH0EWu+lSuZsInXn0DZR?=
 =?iso-8859-1?Q?GjxSm8a6AFzs6L+AIgRqvixNsLdfwxZ4+goXewEY5oo2A/L49+3GTOZATa?=
 =?iso-8859-1?Q?hM1w4e0JFFj9ZbMj/40TVch2Q7rMYtlWQ/mFke6Q6uVl46JZyHfOXJONDA?=
 =?iso-8859-1?Q?4l4UvlEHM7CA2fYrVrqwIcn9IT8o+HEtIP+nWcprl3pqkXlay6Xk4gATkP?=
 =?iso-8859-1?Q?ABWYMkRbG6MACawoB1h5oo8BPUlenbgRdYZ4b3cNeFaQ06OQvwkmmqGAxS?=
 =?iso-8859-1?Q?YgvkaFmBORIho=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8419.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3919dd1-fe72-4538-1d97-08dbb90e9cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:47:41.7368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s921sPwIjQP4KNOhIR8PwRahzVBqmfdqE7aSQWqRBoO/D8EB2EWF1hYnd7hxiCWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9541
X-Mailman-Approved-At: Tue, 19 Sep 2023 18:07:54 +0200
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

Add missing SelectMAP bootmode for proper identification during boot.=0A=
=0A=
The SelectMAP configuration interface provides an 8-bit, 16-bit or=0A=
32-bit bidirectional data bus interface to the Versal FPGA=0A=
configuration logic that can be used for both configuration and=0A=
readback.=0A=
=0A=
A connected microcontoller to the SelectMAP interface can load boot=0A=
image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.=0A=
=0A=
This commit adds the missing identification of the SelectMAP mode.=0A=
=0A=
Signed-off-by: Leszek Polak <lpolak@arri.de>=0A=
Cc: Michal Simek <michal.simek@amd.com>=0A=
Cc: Stefan Roese <sr@denx.de>=0A=
---=0A=
 arch/arm/mach-versal-net/include/mach/hardware.h | 1 +=0A=
 arch/arm/mach-versal/include/mach/hardware.h     | 1 +=0A=
 board/xilinx/versal-net/board.c                  | 4 ++++=0A=
 board/xilinx/versal/board.c                      | 5 +++++=0A=
 4 files changed, 11 insertions(+)=0A=
=0A=
diff --git a/arch/arm/mach-versal-net/include/mach/hardware.h b/arch/arm/ma=
ch-versal-net/include/mach/hardware.h=0A=
index 9bddb8b00723..767cdd368682 100644=0A=
--- a/arch/arm/mach-versal-net/include/mach/hardware.h=0A=
+++ b/arch/arm/mach-versal-net/include/mach/hardware.h=0A=
@@ -66,6 +66,7 @@ struct crp_regs {=0A=
 #define EMMC_MODE	0x00000006=0A=
 #define USB_MODE	0x00000007=0A=
 #define OSPI_MODE	0x00000008=0A=
+#define SELECTMAP_MODE	0x0000000A=0A=
 #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */=0A=
 #define JTAG_MODE	0x00000000=0A=
 #define BOOT_MODE_USE_ALT	0x100=0A=
diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-v=
ersal/include/mach/hardware.h=0A=
index 000af974e867..9d1c2f0dcfc1 100644=0A=
--- a/arch/arm/mach-versal/include/mach/hardware.h=0A=
+++ b/arch/arm/mach-versal/include/mach/hardware.h=0A=
@@ -82,6 +82,7 @@ struct crp_regs {=0A=
 #define EMMC_MODE	0x00000006=0A=
 #define USB_MODE	0x00000007=0A=
 #define OSPI_MODE	0x00000008=0A=
+#define SELECTMAP_MODE	0x0000000A=0A=
 #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */=0A=
 #define JTAG_MODE	0x00000000=0A=
 #define BOOT_MODE_USE_ALT	0x100=0A=
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/boar=
d.c=0A=
index f0d2224b332e..992e0df73b30 100644=0A=
--- a/board/xilinx/versal-net/board.c=0A=
+++ b/board/xilinx/versal-net/board.c=0A=
@@ -287,6 +287,10 @@ int board_late_init(void)=0A=
 		mode =3D "mmc";=0A=
 		bootseq =3D dev_seq(dev);=0A=
 		break;=0A=
+	case SELECTMAP_MODE:=0A=
+		puts("SELECTMAP_MODE\n");=0A=
+		mode =3D "selectmap";=0A=
+		break;=0A=
 	default:=0A=
 		mode =3D "";=0A=
 		printf("Invalid Boot Mode:0x%x\n", bootmode);=0A=
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c=0A=
index 60bf37d3c90f..b619dbc73c80 100644=0A=
--- a/board/xilinx/versal/board.c=0A=
+++ b/board/xilinx/versal/board.c=0A=
@@ -213,6 +213,10 @@ int board_late_init(void)=0A=
 		mode =3D "mmc";=0A=
 		bootseq =3D dev_seq(dev);=0A=
 		break;=0A=
+	case SELECTMAP_MODE:=0A=
+		puts("SELECTMAP_MODE\n");=0A=
+		mode =3D "selectmap";=0A=
+		break;=0A=
 	default:=0A=
 		mode =3D "";=0A=
 		printf("Invalid Boot Mode:0x%x\n", bootmode);=0A=
@@ -298,6 +302,7 @@ enum env_location env_get_location(enum env_operation o=
p, int prio)=0A=
 			return ENVL_SPI_FLASH;=0A=
 		return ENVL_NOWHERE;=0A=
 	case JTAG_MODE:=0A=
+	case SELECTMAP_MODE:=0A=
 	default:=0A=
 		return ENVL_NOWHERE;=0A=
 	}=0A=
--=0A=
2.42.0=0A=
