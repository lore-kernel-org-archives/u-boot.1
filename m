Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22350E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 14:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DFB865ED;
	Sun,  8 Oct 2023 16:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arrigroup.onmicrosoft.com header.i=@arrigroup.onmicrosoft.com header.b="M1ScAUJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371B98667A; Sun,  8 Oct 2023 16:34:47 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD15386477
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 16:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=LPolak@arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq1HfQQiFB50iQv5oNdMmzObpWI86klLCzbpRaFXpHB1LBT2dqGdmAWerJSoFZG5h7U4spXyTvgaFhMwTer+lKNTePHC5W9RmFwouLt+jd3XYtbDIByJaem0GEmUuHLljiKJrnYY8CORRR8CAecazcPZ5Ea07SpzEw68W/tTUZoipz9AgKvrJnX27S495SFIsYnnY/5WR3Lys8ph67aoU9E746ICR06puC0MMyZKzIAQ5R0ezYYaRCVtI+jo0INK72PEPbBnskqK4JZXwlfTEXEcVojQQQZRvPxKX7YX5+HSVrnM2V0lFDnOVDk7w7VbDNoWc4L2djpEkB58naT6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc3au8X2++UjCUQlzvyV0PdGpmA2whF3fiOSlj97EhA=;
 b=SdW2NUSL3lbK64s2s23Lb7OZ7GtGNlDTM4SMqvYqsuawSnpEkaVHIrpK9rE29Bfzw/jTq7SXT1/QAIXNBrWZhldp/9IuC1alsR+/r5a/ureRPfrbZ8ykJ9/TNK+CS6LD1OfJD6the4n23akU7zUOlC4+yRiYBS3uK+MzHHp+kHKg5liJfMKjsRj4onsVgbd3IssFXfzv8W4JyXHJKqnX7H7xtlgD/RTxD8Ixk93WkdmKWlv92bQmrqr3SB2nDeyXNqb3DisucKSh24/gUkZok/G5zn50Lszvt7hD/C1wt9XNH5QGD+BY8V6b5lW8301J3KsaKxTVgrbnBFJGw4PqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc3au8X2++UjCUQlzvyV0PdGpmA2whF3fiOSlj97EhA=;
 b=M1ScAUJpccHRBiPjyWHZ0gHKdi9mKwNcQ1GuW8lKdss9wDjnm25LqiLc+XAAx7LVOIB1SkNuF3cXmhSBIPnI3YRC+jBnOXQRp0chOER1mJTh3ffJOaOfiWR0cPsffFISwUSdGM7FQ8vHyAvfBkk+mcpUMcFFz0v2wRX6rDoOHmU=
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com (2603:10a6:10:353::13)
 by DU0PR07MB9039.eurprd07.prod.outlook.com (2603:10a6:10:409::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sun, 8 Oct
 2023 14:34:42 +0000
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::cbf9:cff3:7543:9c36]) by DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::cbf9:cff3:7543:9c36%5]) with mapi id 15.20.6838.033; Sun, 8 Oct 2023
 14:34:42 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v4] arm64: versal: Add SelectMAP boot mode identification
Thread-Topic: [PATCH v4] arm64: versal: Add SelectMAP boot mode identification
Thread-Index: AQHZ+fPmqEhWzlpgS06mBfWjXH8blQ==
Date: Sun, 8 Oct 2023 14:34:42 +0000
Message-ID: <DU0PR07MB8419F7765892CDBCE7D559C5C8CFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8419:EE_|DU0PR07MB9039:EE_
x-ms-office365-filtering-correlation-id: a504214c-9a87-47ae-573f-08dbc80bb5cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MvU4OoHqFtHO3wnlajc3JoM1ggX3OTlurgu2R7f1hlEfDVs7+ArCWjCTdE4jNIjjbCYbak3kb5tFAhSyO4RjY0Z+MKDDpE0hSR/P9H/bt2VEpZ5MGtvuBm9ovrcBZohNwO8+fd930Q5L7Xby+WcZKO/8q1ZsY5NMqd4pB7LS9UPy/10yTyEZ4yy4WheOZGnYob20kLdEEmSPQ4sQWnDZng+LCYvNSFdUePd2sD0XPdFZ33s6j8B/Me9g9INum7ToDKo0k7cTNCGrZwJV0Yg8QvjbNWPEVyMjHXxYyXbViwVYsv8t5S38Q5dPw19HaRfHHyoUMOc7jcBcke9gT7X9gPYufZaCAWZTO0yyv3mZQC9kkGi6hNejua5r0SOiPHoBPvfZkoB7eVS6CHIzHDquV6+CZVVw9O7FHmDr0KGTuz5PUDL2va4k1fadPTldEqmeOeHKAXhswPuauF0immiFzO8B5Qem4KcptuW0BynJYaTTgX7C7v5ij3IRwWMC738ghHV0w4XkiFZWVDwsvRvRlJjP5/5Ak1Dsq5WX6g3ETXIY9LT11mV0xB7wJZii8wlRJ+JlhKdPcn989DKXvXjzqqjfsBPk792qzXlTkaMY912upj7kAd6DE+4RYBU4SNLeRbodNFsIUgIs8JyViq9kHB2kutXa61pfPrKB4FxMlM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8419.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(39840400004)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(33656002)(86362001)(55016003)(122000001)(38100700002)(38070700005)(76116006)(26005)(66946007)(8936002)(8676002)(71200400001)(4326008)(316002)(66476007)(66556008)(66446008)(6916009)(64756008)(54906003)(55236004)(9686003)(7696005)(6506007)(91956017)(41300700001)(478600001)(5660300002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HMeGDzMaKgIyVQVI96eFqGj49RnqUF70OzoYYl4HboBGn8PTYpy+eiSRTB?=
 =?iso-8859-1?Q?WlvbQXQNqMOIoLQkwnHSo1H0avIAGQyVX1e3RwE7CwWpXRHiaXkpFPXxzm?=
 =?iso-8859-1?Q?5lqrqvGXxB0Tm31D8CCgDwYKSsn6Yzv34TK/G0SsnRxOlReT4EUb/iMD1M?=
 =?iso-8859-1?Q?vIKQW8ugiFFLKvans3NcK8g7+X8TKkS6u2VVHd5mMU2I7lAZyP3u2ko8cE?=
 =?iso-8859-1?Q?deDDkjmiqKumK+HQ+6XQOCx6Wk2Wwvo0UZJPQNGTx6BLMxEQrxllF4bw2X?=
 =?iso-8859-1?Q?Q8qsd9lBtiw2Bq7rg+ZzzXlxmU/6MMXXUCyqsus5mNRIU3w3togAjo3cHq?=
 =?iso-8859-1?Q?bG8mrBT9I8iLuA8uDlHQ81VEz800rKrc71ix1RUCgf4MbnnC0Z+cFNxfF/?=
 =?iso-8859-1?Q?3WFwZPc2X46Xhjndi2GlFDFG+BEr1AsTPO5g8he8e+LtXr/g0PrZHA8Jrj?=
 =?iso-8859-1?Q?aN7tkds0J1RJTd8UKju1Xd0FWfwocT3/jkubQqUwe0YhsEJpkMwJU8lSYF?=
 =?iso-8859-1?Q?sEBolgZMfyYqLPcIRT8y0zXRj96BW743Pn1CEJocJOyff/kdAFxSZd0FWh?=
 =?iso-8859-1?Q?3hSPANQ3TqMThiby369d7alUpFMYI5/IQvFxjAd+l+UvdPx9FnFEubS+AV?=
 =?iso-8859-1?Q?+JUlJClm03E9eIpWIH7LBVe1s2ifAzYNH+dEOkH6/S3GSChCHLNxZOTr69?=
 =?iso-8859-1?Q?BI142jFJP69bvPnLw1XXKgBKEH4hhAzE871gdZbxAGnBEU6/KsrN9s0w55?=
 =?iso-8859-1?Q?TACP2lOu6x8l09k7pslInZ/Rsy8yT2nteIdoaFkHfgOw3BYdKX8Ix1VYR2?=
 =?iso-8859-1?Q?q0KP6q+p23Jw4lmYlNWrl27bMEI5d2zlkxYOmlJA/0v74D+pX6axSRoe4q?=
 =?iso-8859-1?Q?gpzE5TK4O1I9KqLzfCKxZv+EB8S7rUjxRRZscEGmc4d1lb/Ul08PJt9h4w?=
 =?iso-8859-1?Q?Z7Fd/4DIj9D12vsgYlkL9LWQAogepMBW8XRBT3g8wR01gOm4LcCcqmeBO1?=
 =?iso-8859-1?Q?zXI9cOsNGIYiAUk5CAIRJBOx85wkQVajgGZOi9rdjLESRSdvwtMLF/TCwi?=
 =?iso-8859-1?Q?XqsKwdNjQWNAOiofZDAPDgLmysyrGoIkOIl7moS35r1gd3BERqHH/N8bYq?=
 =?iso-8859-1?Q?YvOfpIrEpMTLPCFeMXDkDkUY534ZuNnFiUcsNWyPGvV4fUQIbCStzbSID1?=
 =?iso-8859-1?Q?hD72z5HHi+NrwVwgZLMAtuXpdGdrngnfg3JxPYJYLE6aHUqccGBEvzobe/?=
 =?iso-8859-1?Q?ruszOznBd52kSJuY+WCaIzGkNbbKRZDCyfy8KiobSXW6d7LUrCSxxkPkgm?=
 =?iso-8859-1?Q?Q5uU0Af+oKxRoggCkXbJHYf9mKYkOTo5aFW1rYaM1L9TTXv8q0KpnYSDp6?=
 =?iso-8859-1?Q?C0erISL6M+W+ZeozBdOAkJ+kgcVZxCvwQ9SwcxPU+pbx0vX2u2q1kanKK9?=
 =?iso-8859-1?Q?Npyc2O527tL0qXB6Y95fp1SGb4HG9+GYXnDtkhWElJmEgqaqazPFoCcci2?=
 =?iso-8859-1?Q?YW8WTMXX+VRcVZiq6ujjOMOUB5XN6KfXsfJc1KgcDDJ2Co2XGvea2jIvc/?=
 =?iso-8859-1?Q?kgRz+LGe7nLp2ToTfZKYTDEYpwzCzk0HK0KySv/9jrVnN/DWheF0+5jRDT?=
 =?iso-8859-1?Q?S9QSBOxV8M6+4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8419.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a504214c-9a87-47ae-573f-08dbc80bb5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 14:34:42.3290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu9dqdBt85bLJhi1PDF4Bz3ohHP4ZUzIjyacxo+qRxR/4CIxdO9zogqyqggSHM4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9039
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

The SelectMAP configuration interface provides an 8-bit,=0A=
16-bit or 32-bit bidirectional data bus interface to the Versal FPGA=0A=
configuration logic that can be used for both configuration and readback.=
=0A=
=0A=
A connected microcontoller to the SelectMAP interface can load boot=0A=
image with bitstream, TF-A (ARM Trusted Firmware) and U-Boot.=0A=
=0A=
This commit adds the missing identification of the SelectMAP mode.=0A=
=0A=
Signed-off-by: Polak, Leszek <LPolak@arri.de>=0A=
Reviewed-by: Stefan Roese <sr@denx.de>=0A=
Cc: Michal Simek <michal.simek@amd.com>=0A=
Cc: Stefan Roese <sr@denx.de>=0A=
---=0A=
v2:=0A=
- Drop assignment of 'mode' as selectmap is not be supported=0A=
  by distro boot=0A=
v3:=0A=
- Changed E-Mail/Name to be the same as git setup=0A=
v4:=0A=
- Fixed formatting=0A=
---=0A=
 arch/arm/mach-versal-net/include/mach/hardware.h | 1 +=0A=
 arch/arm/mach-versal/include/mach/hardware.h     | 1 +=0A=
 board/xilinx/versal-net/board.c                  | 3 +++=0A=
 board/xilinx/versal/board.c                      | 4 ++++=0A=
 4 files changed, 9 insertions(+)=0A=
=0A=
diff --git a/arch/arm/mach-versal-net/include/mach/hardware.h b/arch/arm/ma=
ch-versal-net/include/mach/hardware.h=0A=
index 9bddb8b007..767cdd3686 100644=0A=
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
index 000af974e8..9d1c2f0dcf 100644=0A=
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
index c18be0c26c..990ca1650a 100644=0A=
--- a/board/xilinx/versal-net/board.c=0A=
+++ b/board/xilinx/versal-net/board.c=0A=
@@ -252,6 +252,9 @@ static int boot_targets_setup(void)=0A=
 		mode =3D "mmc";=0A=
 		bootseq =3D dev_seq(dev);=0A=
 		break;=0A=
+	case SELECTMAP_MODE:=0A=
+		puts("SELECTMAP_MODE\n");=0A=
+		break;=0A=
 	case SD_MODE:=0A=
 		puts("SD_MODE\n");=0A=
 		if (uclass_get_device_by_name(UCLASS_MMC,=0A=
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c=0A=
index e4bdd5d7a3..8c2e614ad8 100644=0A=
--- a/board/xilinx/versal/board.c=0A=
+++ b/board/xilinx/versal/board.c=0A=
@@ -174,6 +174,9 @@ static int boot_targets_setup(void)=0A=
 		mode =3D "mmc";=0A=
 		bootseq =3D dev_seq(dev);=0A=
 		break;=0A=
+	case SELECTMAP_MODE:=0A=
+		puts("SELECTMAP_MODE\n");=0A=
+		break;=0A=
 	case SD_MODE:=0A=
 		puts("SD_MODE\n");=0A=
 		if (uclass_get_device_by_name(UCLASS_MMC,=0A=
@@ -312,6 +315,7 @@ enum env_location env_get_location(enum env_operation o=
p, int prio)=0A=
 			return ENVL_SPI_FLASH;=0A=
 		return ENVL_NOWHERE;=0A=
 	case JTAG_MODE:=0A=
+	case SELECTMAP_MODE:=0A=
 	default:=0A=
 		return ENVL_NOWHERE;=0A=
 	}=0A=
-- =0A=
2.25.1=0A=
