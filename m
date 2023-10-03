Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26628E7AD78
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 17:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D0186C4D;
	Tue,  3 Oct 2023 19:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arrigroup.onmicrosoft.com header.i=@arrigroup.onmicrosoft.com header.b="EXbOCDKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CE786E5A; Tue,  3 Oct 2023 19:04:56 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70AE786C4D
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 19:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arri.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=LPolak@arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQdZt4sHNWotfWMxPPiobrkVzHhP+gH9bjCahYbBr+Fo9EPiWVwaJHbeZwXQiGSfLDnyfNUtNLybpKOAgIPNZ59cwjDRCa/AkwihIyYqUIbUQEx7zW8uoEQuC6Gql9xGN7rN32fPSqPQevqq0BwNZyb2djI6Cv1EdZRnEgxCv8JRloO88AZZJS+qX3+HZxTr9TCTYGrakvCSkSOLCKelhU9YLrQHhKiSjYPHiWx+ZWPbxYNpbm6gW7OWA7EOoxpKtMPw04OH2eBsZdURFw7+aW6LhQj850DflObeBAkmHXya+gBExHeB1cT/1cbB5pLKOQnrB+u+AYlIpB0wlNntDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAzajAoo8/2ttGicPbhtPNqJdNWCmogaL8Ui1LjGYCg=;
 b=aohYyJSb/kUskZ45zovQGDi7FN5SeUSWzAo1dIEkaw9JojjQoMhVXOzG93t4I+xfIvrUmbZ3hl58lUXxeFU8fF6/SSJQ+5rQP+uUhocf0M8ldGripjOLr/1pK330vKiuQl+fyF+He4c0qNSZQirL+HX8pdN5qe0gqVQPxU5z1MWqgEEXNhgTQRxRFErUZhxtfo44cS206rZ1eSzesppeLMEDOkQZVQTW2VOGh7ZERLwA9mbk/9skuSpSw4OK2M1jS9vFD+NiW5gtQ/Nm2eSkbFw1flfA8fdEdg5d6CJlVHSNkmiP3F7YHhjDwEg7q3/6M8szF67ovqpPpHNS1Scqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arri.de; dmarc=pass action=none header.from=arri.de; dkim=pass
 header.d=arri.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAzajAoo8/2ttGicPbhtPNqJdNWCmogaL8Ui1LjGYCg=;
 b=EXbOCDKK6Fhfg2WkknzX1z5ZkFFfG3imjqeVdj+6xYsB6RQQrWLJM40IfccgDs4EQaJQLWASLJc9VJ5HIPBZK36z+K/1BeNcSTE7nAU50MSGdqiGzGINr4e0EYswmfsmsaex7now6+CP0r82ny7stbzCPTvt6ytGm/mW92/5CPw=
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com (2603:10a6:10:353::13)
 by DU2PR07MB8173.eurprd07.prod.outlook.com (2603:10a6:10:272::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 17:04:52 +0000
Received: from DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::a48:2399:6ba1:da39]) by DU0PR07MB8419.eurprd07.prod.outlook.com
 ([fe80::a48:2399:6ba1:da39%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 17:04:51 +0000
From: "Polak, Leszek" <LPolak@arri.de>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH v3] arm64: versal: Add SelectMAP boot mode identification
Thread-Topic: [PATCH v3] arm64: versal: Add SelectMAP boot mode identification
Thread-Index: AQHZ9hlFwxYl+vQaRUG30MYX0TM2Vw==
Date: Tue, 3 Oct 2023 17:04:51 +0000
Message-ID: <DU0PR07MB84197FD4D47E8F4921E200B1C8C4A@DU0PR07MB8419.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8419:EE_|DU2PR07MB8173:EE_
x-ms-office365-filtering-correlation-id: 099b651c-c292-4324-537a-08dbc432dbdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OcsP4HWxKTs06W05yyb6Tju350Q7jr2SxOl2mOzQNRghcYD+oNBqL0RptApF+UG2VhFm4RaFEVRbguQDevS0g6KSW3h8MoOz7P9yOtlu50085pGRGnudRSHRvf2vgF9/0WAQ9DuLSMn4vBYErYKkHAKwvrTPb3b/0EFzu1JpDNFRKoICczZ8tMLSOiSugWeN5f8qcJgVD+0qdYPPHMGZ2p3T4Am9tGqBL/6caTCnHJkzPytCNXwhLNAq5GyBFsua+EBxGOO5Op9IwQd9oV2twbNuG9WEPamxXX8rZCd5ho8aqZjTSdrW3oiwM7TY0qJd02l8g4SPR62AzQAqLV2823wbSJWkJJb7YkcyTn7/0LR5Qg5+QMZKYCdJa8fSwbEwLACh+v6X/pExqYy6ey0WOY9HjqE0UqxSHnmor3ukAJzTxgSMbwaxZQUm3IOfgOltFm8fTw2sxiRVrUlkbVuYDa+nIsvrqJvYi68LXvQBhUc/is8GZC/nFRpeNNP4xfpy0W0yLCHJqQIphu0vkCe50DAe/QLr+m0JRogkjhZKSE1Cv4J9jQVhUXcH/+xDGurYYCg0VKg5Yv2weLyX5AOBW/FUp95rdSDNJ0HAAOeI8WkLrFU2u6t+01vZt36f1U+RxPai27kT8W2zvmEuNQsUj6aE70xxw0bZgQq27xRBUtY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8419.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(55016003)(26005)(9686003)(38070700005)(122000001)(38100700002)(33656002)(86362001)(71200400001)(6506007)(7696005)(54906003)(64756008)(41300700001)(66476007)(66446008)(76116006)(66946007)(316002)(6916009)(4326008)(66556008)(8936002)(8676002)(91956017)(52536014)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QnicPxAySux0nM5XTh9jzminBdxFS8yj8EcY/2F4FBdkCNoK0fYxwHaqGB?=
 =?iso-8859-1?Q?+MPPzY/+CHvsXx60lasZC1g2ZY8SSDYWhDvCB+t5I1juwpTe1CQKkd6lnB?=
 =?iso-8859-1?Q?CZyElOiNOBO4ddlJIHLzn8+NBRNAUBfBLhA4bqlKDPT03PBSWfZaglKK1a?=
 =?iso-8859-1?Q?SLMbP8IvkOAzFIpQhByvJXQMp9Bqto+xNNYIXtr5NmfaILYjtydNAbK71h?=
 =?iso-8859-1?Q?CpLF1WHpcixvbmZn9p1viQQkLChWc+NJK6AQRo2kLO1G5IAY/kKIfPUnbY?=
 =?iso-8859-1?Q?ru9YqEGu5/quunmvMpFpeSU93g9mXdNnLwsc2zY7L2buAIgluPUgf8OsZF?=
 =?iso-8859-1?Q?zUTdZko8cAdLvHu9s/G76ZXVSmF3g2syN5wizT9kgi8JuRBja6do4gMVf9?=
 =?iso-8859-1?Q?OWAeRvDOoWizM3A4HUeFw02MPqNkxpNVCwpqlq0NPKw2Jt1pKfg5ndp1Mx?=
 =?iso-8859-1?Q?KMPSr+xNed+6KHuGr5167Tb2VT+F8zlAmLp0W8xY64+K+MDd6l5ML5oXGn?=
 =?iso-8859-1?Q?WqFvarGcO7geQW/ArHTsKIvVzuzZOg+B5RAGpeVcr+FGFv1OM7eQ70YTUb?=
 =?iso-8859-1?Q?DN43LPTlaiY13g8AFEaLwW6aKwxyPKYhCPDcpMpfhH/W5SzVbPAbOodGP2?=
 =?iso-8859-1?Q?dlS+8qc459//X/5OTqpg3hewMTd+nEdPDF5wc+yjnXvcojB5VVgwpW/o/S?=
 =?iso-8859-1?Q?0PK/O3bAl2luZE1kRP1wD55xdEMcLrsBbF0lp8HAqpowaABL6gU8usPVmp?=
 =?iso-8859-1?Q?6rKrVV1HaPD9SAb+KDqpSC7H1vrnBCbJgiRt+01lszIkF2Ob+txNhlkfZM?=
 =?iso-8859-1?Q?cnkgG3jtleDDu2ky8WqvtnCLcU5uuIBX4Q2dz9gGCTNk1HnCTsqcmEvJj6?=
 =?iso-8859-1?Q?m7QlR28ZLmBkCiCbB0FMwZAQLdj0Rwvs90cTthz9i7zJU9ziCiBf9/nLAn?=
 =?iso-8859-1?Q?GjhTVndYMfb/xvP7sN72tntZSILkoMOJXyHawvxEFRcJAFJIJWYSYYcnHX?=
 =?iso-8859-1?Q?ouIaiPW/4fhSiz2b1t4EL6WTwC+v+pIAXxLx4s/iGN4xWl4U2IjMFiUyzz?=
 =?iso-8859-1?Q?iIU2GAEqxAYwT6J+o2N3tGUSmFvz6GgZLXeDN+gRfKekIUvxTp3OM7EPnW?=
 =?iso-8859-1?Q?YCnMWCPvcePoQIWZSJ7pfmuS8n4e7q9LNnGsUsGms4iAqRZwXY8hDfbCV5?=
 =?iso-8859-1?Q?2vm5/qIzey7teEr5Fm9YtT1eIHbnubYtAV19oKzUmt+NG/DDLS9rw69Asb?=
 =?iso-8859-1?Q?59+pZCR7AqwV+uihHjH6erMVhEHx/DrbFVWW2w70zSVHwGr6wsd3R913x4?=
 =?iso-8859-1?Q?fpMwkCJuBi4VzKja46DKPweR55FICuZEarYTymvJekDt0obXBxEC/nv9qU?=
 =?iso-8859-1?Q?TSPec2zcvI4q3qPj3mdcD4OLnCMfRo+vKVRBJZlg2yUmBBGMZdDZQV5FC3?=
 =?iso-8859-1?Q?aS845y/sp8sVHEzPWz0HGxMsolSUds55rzePyMV34AJX8LoW5ny/2bBhOt?=
 =?iso-8859-1?Q?sDltm/fnFwwoxeR90yhpYWe+9KYihEHbbU/dz6OVjuDKZAuhSAbABC8IGJ?=
 =?iso-8859-1?Q?rkDOdAThRBumsJRJrXoNzNZrrZlatX+V2bRlKPfuxxBMPLynEO4++NOQq8?=
 =?iso-8859-1?Q?EASts+bgDaYBw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8419.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099b651c-c292-4324-537a-08dbc432dbdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:04:51.8969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeX1O2k0vMqsxfCNOxQJZX7/R6SSAbScBp5KHmSojQ8RH1gqAY3V2KOtPwILjImu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8173
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
 #define EMMC_MODE       0x00000006=0A=
 #define USB_MODE        0x00000007=0A=
 #define OSPI_MODE       0x00000008=0A=
+#define SELECTMAP_MODE 0x0000000A=0A=
 #define SD1_LSHFT_MODE  0x0000000E /* SD1 Level shifter */=0A=
 #define JTAG_MODE       0x00000000=0A=
 #define BOOT_MODE_USE_ALT       0x100=0A=
diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-v=
ersal/include/mach/hardware.h=0A=
index 000af974e8..9d1c2f0dcf 100644=0A=
--- a/arch/arm/mach-versal/include/mach/hardware.h=0A=
+++ b/arch/arm/mach-versal/include/mach/hardware.h=0A=
@@ -82,6 +82,7 @@ struct crp_regs {=0A=
 #define EMMC_MODE       0x00000006=0A=
 #define USB_MODE        0x00000007=0A=
 #define OSPI_MODE       0x00000008=0A=
+#define SELECTMAP_MODE 0x0000000A=0A=
 #define SD1_LSHFT_MODE  0x0000000E /* SD1 Level shifter */=0A=
 #define JTAG_MODE       0x00000000=0A=
 #define BOOT_MODE_USE_ALT       0x100=0A=
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/boar=
d.c=0A=
index f0d2224b33..651b7d24d7 100644=0A=
--- a/board/xilinx/versal-net/board.c=0A=
+++ b/board/xilinx/versal-net/board.c=0A=
@@ -260,6 +260,9 @@ int board_late_init(void)=0A=
                 mode =3D "mmc";=0A=
                 bootseq =3D dev_seq(dev);=0A=
                 break;=0A=
+       case SELECTMAP_MODE:=0A=
+               puts("SELECTMAP_MODE\n");=0A=
+               break;=0A=
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
+       case SELECTMAP_MODE:=0A=
+               puts("SELECTMAP_MODE\n");=0A=
+               break;=0A=
         case SD_MODE:=0A=
                 puts("SD_MODE\n");=0A=
                 if (uclass_get_device_by_name(UCLASS_MMC,=0A=
@@ -298,6 +301,7 @@ enum env_location env_get_location(enum env_operation o=
p, int prio)=0A=
                         return ENVL_SPI_FLASH;=0A=
                 return ENVL_NOWHERE;=0A=
         case JTAG_MODE:=0A=
+       case SELECTMAP_MODE:=0A=
         default:=0A=
                 return ENVL_NOWHERE;=0A=
         }=0A=
-- =0A=
2.34.1=0A=
