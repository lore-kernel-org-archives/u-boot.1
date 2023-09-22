Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B165E6FE2F
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 13:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC161864AA;
	Fri, 22 Sep 2023 15:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arrigroup.onmicrosoft.com header.i=@arrigroup.onmicrosoft.com header.b="Z8SlNsA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B8E86484; Fri, 22 Sep 2023 15:51:23 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBAF864CB
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=LPolak@arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioMu9eOFZGKoUfMvVGU5VELeYpH9j2TN9Oy++PYDLI8sW2jYVse1hsPuzG81bAgz8okMKq4Nu1FRoSg47amOdH0E4lcElOAxzOnQqGOgBagTnl+qB1AC+xlz97AF6j0VGL2bAfxbG3PXUYxv5JMDqNGzE92gk2rq1CClkahE4BzCAkoeZFCA1BnOzeQM2SeR6zJbNB23a6TJmaEY520vzBUMddPKGkU4mfyrDNZSyQHUHfCxE6/0hx1uZQJPx6XGXrtSSErOwYMCCCl3K3/Md43unZUZY6GbtX6eP/xz08lQueUc0iozG23xp2ZGt/ktKQE9AbK2PfUA9VYDXSiTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G1xRsx1mSCcf1bnEw8DHQABDVSNHKC4vOi/buZi/Yc=;
 b=dPrZRyqQHEumTWEQC7tJNf/XqgYM0btJSqsgskIQx79i1Zetoc6MEuVFwwyzsUmubTW07JiOpNZO/vOkbDTU0OIT1R4AdFWkawvwGGm4wof2nQluONnjjHMmPIDnUEUAAHEmx4VCvWD63Yg4l4cp8PE+2paenE6amSXDBXgNDOEvI+d0yQxavfQtcWAKRiZxMiwiGAwkfcz5RHIQN8fbA15XuuHrOhQWB6UFG+Md7wJj5VCOEYENDTB/d0qVFkJ2wZiQuYlbSeRprAzqSvKFnf1Rq3w6M6NMq1LLTfrcxYXNL1shUNYC12bFTgcdMaeKS548xCDOTkVIV2YTGMjT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G1xRsx1mSCcf1bnEw8DHQABDVSNHKC4vOi/buZi/Yc=;
 b=Z8SlNsA4E/4ZdAandziTIpJfEzr6JyIMkgDoQIu3scvH55VkRdIIFLruxAjmeQXDHPPWw6Kz64aradGHhVTxfYks2PlLAe7hSFuzkws+FGJemb7gY8bwn39vBdwSqoBqOcALowJQab0w97uYdiIxqu+60eigkSC38OYewG0j/g8=
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com (2603:10a6:10:353::13)
 by PAVPR07MB9191.eurprd07.prod.outlook.com (2603:10a6:102:317::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 13:51:17 +0000
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::eb54:a70:758:cdfd]) by DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::eb54:a70:758:cdfd%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 13:51:17 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v2] arm64: versal: Add SelectMAP boot mode identification
Thread-Topic: [PATCH v2] arm64: versal: Add SelectMAP boot mode identification
Thread-Index: AQHZ7VtsbFOir4CCh0Ko4bupOA/kEA==
Date: Fri, 22 Sep 2023 13:51:17 +0000
Message-ID: <DU0PR07MB8419D03ED9705DEA5FAAD992C8FFA@DU0PR07MB8419.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8419:EE_|PAVPR07MB9191:EE_
x-ms-office365-filtering-correlation-id: 5a398610-d4a5-4093-a109-08dbbb72fe79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4hzsiYcbK2dkr938ocSLyT+PVfBkAtAwLs1IXxX0jr+xNp2SrZUfJx3hKtjbmYk5fez0rY16PYoaRHw9TzD9jkd1Gy18BNnrkGMaE0JoLF8DffUVU3aoazY90H4Y3XWM4aflY/Phw1J9KlRM1PElN0t1lNDCjS4vZkw71W4xxu+kaZij/B6WL2DCdim52XZJbiGqgNqKoyhpFGeEU7Qfxa9UC0+ITcnCpgywNgWZyjhH9ZjcXeSkAmuWflXbHX5gNmGz9k0rGXZckHNvEbF7AOkShuNUqwfFcS8zbAtRCFdveps2MPDN8SYI1wXFN1xD/a3hMhWqRFINQjXET+IAaZ9HUkLx1Qdo59AsZUhjSiIYJsU+DFJbmUe56UpOJCTkMMCXD0iT/oqRY3WZqDAmpAEU0Rb4bznJkwEg/9WSW11l/Zgs2znD1zYrs9JA89RDE4DSKiaAJrmTiCGR3U9A+W3ThYWmeq51EIeAXpWtF4IRq1m5KCkQA4XZuFtl/shwY4H5lKzwHEjxBo7PzjgB9012R/OGPoHOi0kWS7lwF1oJkOfLOwKudB8EbFf5w+DxEjAcIZZCOMr6iEIo46OG2t9sBB5JUEV6H2wLSb4QaxL2F/FkNkWb/21RCzLP6h3caUmgkFPn9XhnSReoOtrZxoTuRpMIUCbSJmhFicx3dM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8419.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(64756008)(52536014)(6506007)(71200400001)(7696005)(9686003)(55236004)(478600001)(26005)(4326008)(66946007)(6916009)(316002)(2906002)(66446008)(8676002)(54906003)(76116006)(66556008)(8936002)(66476007)(5660300002)(91956017)(55016003)(86362001)(122000001)(38100700002)(33656002)(38070700005)(41300700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8+zYBE8K8NEWEzpdkQ2qM2whmbtMo9zqg0VgdYcldnctliNr/JvvV75CXV?=
 =?iso-8859-1?Q?u1rhkAUlWiQ5sTF+xPozvfoc9nFTXZubGKz3jCR5NKGq3fTD+3Y+raF6F7?=
 =?iso-8859-1?Q?Tg/+z3QYrqk+Jbvm5RwhFe3abHtxlvIZgMyN2CjPNsqnz08j/f8wON0s3k?=
 =?iso-8859-1?Q?EXYKHCHQ0bp7llFAWdXHBCFiSrMpa31L56rNfQ8Bl+GGbnG+f8gdQ0Pz5U?=
 =?iso-8859-1?Q?fqH9u2RMdQpbVFKMHLLunn1RBZkKRhbCtbBZvwQlfcWQuZfQVcRPqSuEhk?=
 =?iso-8859-1?Q?EQunCHTueut3XHLJU3TswUS0seZtPvrSiqDGDJTMVxsel6Lg36STV38yz9?=
 =?iso-8859-1?Q?BgzdJx7mkgnKVpFsblGDDATYH9WdIdWc5MjnXlTJgxWHizUXa4ch49hzwf?=
 =?iso-8859-1?Q?n5500yTFzoJAOJZ98utnbRgZMIkx9wh0vZIVQgmNTmMpeEs35Tj13yPjAO?=
 =?iso-8859-1?Q?sPvSNGrXaSGL1bjREXFzM/vIli+xJnKh1wJ11PlwDNUSUk9oQtXnFZqaAP?=
 =?iso-8859-1?Q?IpKJuGerQ6pRffc0LgMrvDn2axup885o2dk6/EBPovCm59krbwKSMiXPwz?=
 =?iso-8859-1?Q?KfFgbHA/LYH6LFRb451Y82/R+H8dL5NEc2QpYW1tVUNpnd9gtXf2DHeffR?=
 =?iso-8859-1?Q?0CiApu8JGLpsvEUZIB14Uz7p9/qoL3RIXVXUgQgh3mIoHY09NDkMe9bEKF?=
 =?iso-8859-1?Q?quKU1BSzGNKtN0PqK13cX8YFoa5v6q+UWLTWOr/gitgx6GFs/dh6NdZsnM?=
 =?iso-8859-1?Q?Q7ulhhRbeFeR5Fk6CVlMIfAWMirsQlyGkNVLDemyJfLzgKyw4PoXiOhVTK?=
 =?iso-8859-1?Q?0SDehdKEmXSK0rFlwnIXXtD7sTZrROkTYZQbeDF8A+kJw7n5RiND7xibCn?=
 =?iso-8859-1?Q?VQ8678gPdqB0gK3tbIv1wjHVZK2WIkXgJaBS+FhSN1GsgW7pATZHxowtfg?=
 =?iso-8859-1?Q?CVAJSlz0Rbkkmcc2J8Tinlr3VQ0r0CB+i6C4l5sSIc0RRHLO4umf217gjo?=
 =?iso-8859-1?Q?r/18av5HIvu1IcLL62KUf7W9T2aobj7wNf1/JXkK2OKtvW5gn1J6STjozd?=
 =?iso-8859-1?Q?pU2NCcGJ1mSCxqWsOoyg65c7Nz5cYYgjIxr7pzAkISfNJUa2Y2mPTjFJqS?=
 =?iso-8859-1?Q?G5XFB4xPzcTrKeVlj9Y+ZGmBvKnJjNnPoNpqyyR91/59ooQ3ozgBscj+DH?=
 =?iso-8859-1?Q?lshW5zcoZH5dLfYGhCH/kb09GIRu+hPLRQzUS2tPWBUMqlFLJV3XLTnV/R?=
 =?iso-8859-1?Q?iW1ErCRSUFqu/cBGkyWhSsmZdc4ebAZPLv+32NdLYU3kt1qheo5heshYD5?=
 =?iso-8859-1?Q?cW2o5KZ2YRB72XQdHKmZl8PFWv7Hzc5qQXSKIqiYR2DuQ5BzemiZzHrtvm?=
 =?iso-8859-1?Q?/LeQYMjyA+hdeNfrgwMdiuhQ0Zv76G6QDm74suBLVcU0NiRxn0oc8WTR9E?=
 =?iso-8859-1?Q?nKqv4MYr9cPdsYlLFYELPeeFaGyksIW1qjQGicDgpR8aUlhkmyoulO1sSq?=
 =?iso-8859-1?Q?QQ1fZHQ7aou2rqfV7hnKL+jJ01JaBwknJS5nD831l2KErT/KZYhxP1Zpj7?=
 =?iso-8859-1?Q?YB7WXkG4e9Pa/fdEgcLw6Zlp36G7R28Bw87v9eHhZLSxNzaNZtR4mG86+f?=
 =?iso-8859-1?Q?XRi6n9WOHFjoc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8419.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a398610-d4a5-4093-a109-08dbbb72fe79
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 13:51:17.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRqFw6iVhbkpFElDBBCG/TTH1Vz63mVYa2daM6XaggBWrqhakYuBNwCepapuv5sm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9191
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
Reviewed-by: Stefan Roese <sr@denx.de>=0A=
Cc: Michal Simek <michal.simek@amd.com>=0A=
Cc: Stefan Roese <sr@denx.de>=0A=
---=0A=
v2:=0A=
- Drop assignment of 'mode' as selectmap is not be supported=0A=
  by distro boot=0A=
=0A=
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
index f0d2224b33..651b7d24d7 100644=0A=
--- a/board/xilinx/versal-net/board.c=0A=
+++ b/board/xilinx/versal-net/board.c=0A=
@@ -260,6 +260,9 @@ int board_late_init(void)=0A=
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
index 60bf37d3c9..26b4c7bf39 100644=0A=
--- a/board/xilinx/versal/board.c=0A=
+++ b/board/xilinx/versal/board.c=0A=
@@ -182,6 +182,9 @@ int board_late_init(void)=0A=
 		mode =3D "mmc";=0A=
 		bootseq =3D dev_seq(dev);=0A=
 		break;=0A=
+	case SELECTMAP_MODE:=0A=
+		puts("SELECTMAP_MODE\n");=0A=
+		break;=0A=
 	case SD_MODE:=0A=
 		puts("SD_MODE\n");=0A=
 		if (uclass_get_device_by_name(UCLASS_MMC,=0A=
@@ -298,6 +301,7 @@ enum env_location env_get_location(enum env_operation o=
p, int prio)=0A=
 			return ENVL_SPI_FLASH;=0A=
 		return ENVL_NOWHERE;=0A=
 	case JTAG_MODE:=0A=
+	case SELECTMAP_MODE:=0A=
 	default:=0A=
 		return ENVL_NOWHERE;=0A=
 	}=0A=
-- =0A=
2.34.1=0A=
