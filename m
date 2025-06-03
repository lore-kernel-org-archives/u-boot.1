Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E6C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59ED082AAF;
	Tue,  3 Jun 2025 16:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="qzwLlwD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFF181E72; Tue,  3 Jun 2025 15:41:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA82E80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZThFsjJasCxUrPYRdNUCFKguqKre6QZMXNCJe2zetSNW/VXRZDmFLGsttXGxhotP+wqCncciboecE5eAb2fkjLJKEZbCaTlG2FIJWsZ0iJ4awNkWuXnUGTd2IcNKCKkqhy2X6dchilAFHvCAPdC0YMNEZZXem9E9xg5WluU74xafQdDn91I/RYfO+JplijRFIdNOOm2pVe1qmsj1/lnk6RTLGGQmGwHPHbcO/ydSSVrU9HooStoBZxkbxH287AZGXEFQdZoJ5ruup/5qHo0Z0IMMOwuAb97Tcm7DwWOtLd2fYLtGyqy71RiNOPl9Xr07jPynNhouZnSQ6P12QjsXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQWqisswL9ciayTSFA50X1FGGvjSX0axhGXYMJ8HXFc=;
 b=sRM10/ku83rs49m1ynoe9SnfNerHIvM+DADC+E6viWQkwv3nzUbWWbf0mat44EiH2ZPraH2Lg9z/TB94yg6UuzMejl2dWcmUlAfHoO9NAjmTcO8xlguLDrUgZxILqWtIAsf1ifjvzVK5wyMdWrVGFE7hH8rbGf9C46bvwFZH9fMVqws6wYWfZkmtRXSFl6w9szxctF5o6pKRlwy5k8HwUcSYfmEL7bGmApvi6C5K8y45MvOdd5b/MsABFC9NmsHI6PSfGQIsCM7dJWdOU3xdSKoscMUXkaUxQ4I7llYE9JQGGVvbOcRfXFFLHsqL5WrNt6CkYRQLHeqfzdTtWJXT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQWqisswL9ciayTSFA50X1FGGvjSX0axhGXYMJ8HXFc=;
 b=qzwLlwD91cLYzXiFXyjqIstQ+VqoNK+yi98qNysy+rlsltsIujHU1s8muVk/sPJKaLsFywzobXf/VQDD1qRkZamth+OyjR/6hUjmqwyeTMRGj2HgzyyMO4SALGLuiAg3RmSo+ATO1CTOaw7PeGlCRP2sydaxW35seJADhQjoxz9LR+DevsuKpHCio2q7RhRocfnDL1SwKCW/gWzgI1Z7ovbiaH/QZiMT9H+6Yjq08bblNXLHLC8YOA2eCMckG1Ggb0cqtvVUsq7v7Xfcu3+ZnXILEL5HqfYfSDRKkltDVGGgl4ZjUJly00TgFgU3HOQJfxUM1DvBe+fH+A6Ey6k77w==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI2PR09MB7303.eurprd09.prod.outlook.com (2603:10a6:800:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:41:08 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:41:08 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 10/11] cmd: riscv: Add 'startharts' command to start multiple
 harts
Thread-Topic: [PATCH 10/11] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Index: AQHb1I0pw6LHNzOVQUS36Tvd3ua2Bw==
Date: Tue, 3 Jun 2025 13:41:08 +0000
Message-ID: <20250603133744.278790-11-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI2PR09MB7303:EE_
x-ms-office365-filtering-correlation-id: d68bc20f-4a09-42f1-3152-08dda2a44b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XLca4qyUgHhzwj2DFVd/v3Om5DqvPDd/vrBecI0oQDQEsO3Kcz7LpiBYv2?=
 =?iso-8859-1?Q?zmh5n3On62iWp+SXwKsSUQtHxFSsu/GdKQr32zq76K9Eu8Dmbyur9GfdEq?=
 =?iso-8859-1?Q?nZmEc8d6SfDAtQcyoQVvwQkbBj17m+C5jLAK2YCf1ZiQP6PNB21s/1sNFk?=
 =?iso-8859-1?Q?bIEFDkfy2cdEWSUGvsJCv/fUJkT7xrwonqaBs0Q2YtlIHHrQFXRnDQjBmQ?=
 =?iso-8859-1?Q?ZhjKR2VxB7lzuWHVTzZ7bQKJxhLFA/78dHS1Ds67plHma/2CDzUR5IFu7n?=
 =?iso-8859-1?Q?Jpz9pIh3NOtyLjdTlCvXHl/kfmjymVIMNFSvtncr4S3jpfzsfNZN434k5u?=
 =?iso-8859-1?Q?mZsDfDhkX9Z7Gz4UrAvxaESmg0zWcnmu0cmByCychNlMlb1eOxCyWq8Pj1?=
 =?iso-8859-1?Q?A8ggZvhpmrU77kSPGrusxJeTkFY/Z9dNburIJLXaGCwtrOja4+SM0JVVBM?=
 =?iso-8859-1?Q?U3hWD0NBRMUDSpJYS2KXMqiJhQvExTg9hfvU1Hvy8sA1RFngw9rNB5/AlU?=
 =?iso-8859-1?Q?Zn52liZENpGconyjWxdGNzAjgj2mBy/nqCBfTwRIekkZcjGwtkW2eM0sg0?=
 =?iso-8859-1?Q?2p4LzY42yCrZXuZSIwEAaerGA+oDDrSOk8Y2XtjIS4BsCAMZkcxCacw1Q0?=
 =?iso-8859-1?Q?Y3zPz3qz633byGLXpcaHriHzXJ5w+b0EbDw1UtS86/WsMc2Djo7LcaH5li?=
 =?iso-8859-1?Q?nEV2CQZs/m6p58En7fBnKYlCu7tb0jRW877MOKV5h21WFOJG6l5FCrLrSC?=
 =?iso-8859-1?Q?vJbmoup4XCkSuGdj6Iae6omQ7fNA7CCbSFKC+0Zo+eplSdGdHT/LWsqVag?=
 =?iso-8859-1?Q?FyvX3DhQCoTAOGA3S6E+uM8kmLam5oKyfUezYbKCThyj0ZZf+L0fFgDb5q?=
 =?iso-8859-1?Q?LETeCriGKjJnqrOLXVONYjl8T9ruR6HEsE0NVnSnW1DkgY/RczHCX/4z70?=
 =?iso-8859-1?Q?UH6507tu7xqNHwMve6GM0Enz7NoCp0iQb96dyekkezcyDPaUkaT7C+Ez1B?=
 =?iso-8859-1?Q?xAwgN12l3qEy23ZL0K/CYmhvkSK9Qlhs81OPtnbFH4e+HxyxfSvqAMxiDw?=
 =?iso-8859-1?Q?zEn75AVmxdK2rmzqsZrzU7bFpaMeR8qr7R3G4DwqTKKYf+pE3iorjnM6eB?=
 =?iso-8859-1?Q?Ugp6DQcs47fx3tgNhIl6fKW8uM65TUSQK8BPu9t8R9DconcR9LFclcHf/J?=
 =?iso-8859-1?Q?oNeAN20s0kIdTL+gOB0Zxa8ROydjvRpSrsxuJ/M+1hnTTTu9JVBVzpzg7s?=
 =?iso-8859-1?Q?UcbpxPgL33FTp+CjBGm7Xh1FYqrnfNmRbZgVqbROO3OPrkE4JGQ7qaZABj?=
 =?iso-8859-1?Q?FHXZxpdZPECWCGhAigRAcE3W8LCRYfHmNs2g/OsPis12B+YPNL3mIBlxyt?=
 =?iso-8859-1?Q?4zA61or4yHC+Kl6XAXtVQaYPC5nQQfkiLksjmN7un6gLYqOw6mWOQO7PCV?=
 =?iso-8859-1?Q?z0fX1D8CgNiF0//IDBHLN6+oRgRKGxvaPU5VBfs9j2qBjMZWFluEZEEyLa?=
 =?iso-8859-1?Q?gWfz+5xGVVgwl0o8DnbYuRbQRwV02rLGM1iQZNDLyr7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TolBmlHlDUEhRxVzcOZfiFenaOHr39Kix4URlnmslqNTDOKi7FJi9nn9Wo?=
 =?iso-8859-1?Q?oZOSNJREzHbX0ABuUD7rhvqhhjc2yPOSQkvfGySPR1cqTZeHF4aFi/NH7/?=
 =?iso-8859-1?Q?BWwTi4eUf/YZwVe4aQ4LFFEenkF6P6qkHmHHO8wEnlk7OXRfiRDkMf/auf?=
 =?iso-8859-1?Q?4d1LudnHbcxBxY7DDqctOt4DcJQMR+98/JgFB6WZjmWwFLNGFhBQysa8EA?=
 =?iso-8859-1?Q?alyew9vb5NuFv/h8TzjKsnVM6RylnTRWahh0u9baDIAu2vEzwFUQ2BXHAC?=
 =?iso-8859-1?Q?djiAuRotop6fkKLW+B2h3fflYEK+UJ1oF4v0sdzIUqzVo/Ak+YdtQc0cx1?=
 =?iso-8859-1?Q?JGmv1VfJUzN8AjqpJCBAX6w9RwviinmtPq61ewaBVugYdPQedzV/jHmTA9?=
 =?iso-8859-1?Q?KXJAab3syIF+NmUy3wspAPwdobFJKEuBTnp2t/KOfDB6nbsqkMnURFz6bo?=
 =?iso-8859-1?Q?XHviZ3ou+Cxsy1oLdGIiXGHKzj3Gpt0xW9vt6RjiU5onm5Wanw5V9voaxQ?=
 =?iso-8859-1?Q?N0trdypm3JyyQJUt0HEMPgNoDN/H9/E5FOSa3lmGdRTh9MEeByAfthuir9?=
 =?iso-8859-1?Q?279jVT6K0Xhm8zPpq5UR0Tr4M1qw5XhIKtPkjEUlyB+nSaER37Zka0G6bl?=
 =?iso-8859-1?Q?H9MsNRsGLHmPyxRVm/XPXWdNFk96GaslEbNEvgFwgz5orfOAaDyzngYH8P?=
 =?iso-8859-1?Q?PI+FceoVJISknwLDV3ZkgEhUiljh3vpsEVQkTHRRdlQWrRSVxYWimf+hPb?=
 =?iso-8859-1?Q?S1l7ZS43ScIlcmXVVIxLlWdDoQ7TmCORpfFGvU+FmpwPaDiKLZw/61By86?=
 =?iso-8859-1?Q?BKkT4KbrVAibSTyI065wxaHqfHA5K8btqW9vOWqsL+SxHtM+xpDj2JHI2T?=
 =?iso-8859-1?Q?28RisIMQd4ugf7TsF7I/X6iwYC4zRuZ1r6l/1dF+jA23KTUdUvr0RuA2EN?=
 =?iso-8859-1?Q?jjADdKcaSRG32mGqeVSUIdEgEqJOAdBXTBp6yqd5nApm1KSM8ThmkxN7RS?=
 =?iso-8859-1?Q?APPFcncFCz3/3OHmqEBdiEbsiOUmaxF11Ux5MTXX5Pqn4rA1M2XcS/bZ9G?=
 =?iso-8859-1?Q?jWWGOd+gtRZP2jJrRQkroybySAODTVCILTbkU2HuT3cZ3Z7nIWVO85qu/a?=
 =?iso-8859-1?Q?lacnTbra32TAXO6dyy5hikS8Ef4q/qPvSWDsFzBbdAHey1SNLqfaHG/rK8?=
 =?iso-8859-1?Q?6xbilbiuSyymQpLAyTjCX1/cCVXQ4i7Pc88aQgS7SlgxDzzxnG7y9V6w5M?=
 =?iso-8859-1?Q?SAJOtkSdZu1rgbqn+8tAxco3qqS1+U2kPWtX3ngTWeiLSkViihf6IuyLwt?=
 =?iso-8859-1?Q?+4MI8CyjaxI9H687+vQ+jQfDlCaMjqFG4OHtIr1F1almTo0cFZXdLXLxEu?=
 =?iso-8859-1?Q?L2ug3Wi3jaIFdblsEh70IZHes/pLrPXsV4D81Vir5Q1yAj4BUyF8Z6Uxxb?=
 =?iso-8859-1?Q?sfpeqS25R/53vxuSxceb4eR1XUfsyN1KMgjzZENVW/FQQ4xE7JDpKAhyrH?=
 =?iso-8859-1?Q?IUSHttkY5LZV5elsRKC39DzORlQFpdgXm7+59ktEJvDji1Cr8XIY+v+o9G?=
 =?iso-8859-1?Q?qCxFapxBd+teSVB/wtSlMjHKc0ZaI6jHWPmqT2bkNYJoqLHwuQE9c2BNp0?=
 =?iso-8859-1?Q?eFABmHyvH3vORo7+ZEsz6o9yPxvwFvfA4H0AohXx9EexmsSrXSvb6RCg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68bc20f-4a09-42f1-3152-08dda2a44b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:41:08.1344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtV6hwHsUGgDrYsVq0G29A5mjnA/PoRuUWyhHcrRAsB/3ENFrMMLf7sXL99Fq7puEopuR6HSh0Nmwf/03o9YQREHdoy9VmGqAStQheQf6vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7303
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

Introduce the 'startharts' command for RISC-V targets, which prints
or executes commands to power up and reset all harts and jump to
0x80000000. The command supports optional cluster/core count and
immediate execution via the 'g' argument.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/include/asm/arch-p8700/p8700.h |   3 +
 board/mips/boston-riscv/MAINTAINERS       |   1 +
 cmd/Kconfig                               |   6 ++
 cmd/Makefile                              |   1 +
 cmd/start_harts.c                         | 103 ++++++++++++++++++++++
 configs/boston-p8700_defconfig            |   1 +
 6 files changed, 115 insertions(+)
 create mode 100644 cmd/start_harts.c

diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index 6c47de9a633..20868eee419 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -77,8 +77,11 @@
 #define CPC_SYS_CONFIG		0x0140
=20
 #define CPC_Cx_CMD		0x0000
+#define CPC_Cx_CMD_PWRUP	0x3
 #define CPC_Cx_CMD_RESET	0x4
=20
+#define CPC_Cx_VP_RUN		0x0028
+
 /* GCR_CONFIG */
 #define GCR_CONFIG						0x0000
 #define GCR_REV							0x0030
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index b04dcde943a..0e2f4c277d3 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -12,3 +12,4 @@ F:  arch/riscv/lib/mips_gic.c
 F:  cmd/display.c
 F:  include/led-display.h
 F:  doc/README.LED_display
+F:  cmd/start_harts.c
diff --git a/cmd/Kconfig b/cmd/Kconfig
index e40fbded3e3..eda2e5b8306 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2321,6 +2321,12 @@ config CMD_DISPLAY
 	  displayed on a simple board-specific display. Implement
 	  display_putc() to use it.
=20
+config CMD_START_HARTS
+	bool "Start harts"
+	depends on RISCV
+	help
+	  This prints commands to start all harts and go 0x80000000.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index e1ce7bbaff9..e3d7e944715 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_START_HARTS) +=3D start_harts.o
 obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
diff --git a/cmd/start_harts.c b/cmd/start_harts.c
new file mode 100644
index 00000000000..0d074778b6d
--- /dev/null
+++ b/cmd/start_harts.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <asm/arch-p8700/p8700.h>
+
+int start_harts(struct cmd_tbl *cmdtp, int flag, int argc, char * const ar=
gv[])
+{
+	int n_cluster =3D 1;
+	int n_core =3D 1;
+	int run =3D 0;
+	int cl, co;
+	long cmd_reg;
+
+	if (argc > 1 && argv[1][0] > '0' && argv[1][0] <=3D '9')
+		n_cluster =3D argv[1][0] - '0';
+	if (argc > 2 && argv[2][0] > '0' && argv[2][0] <=3D '9')
+		n_core =3D argv[2][0] - '0';
+	if (argc > 3)
+		run =3D (argv[3][0] =3D=3D 'g');
+
+	for (cl =3D 1; cl < n_cluster; cl++) {
+		cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+					CPC_OFF_LOCAL + CPC_Cx_CMD;
+		printf("# Start cluster %d core 0 hart 0\n", cl);
+		printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_PWRUP);
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_PWRUP), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+
+		printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_RESET);
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_RESET), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+
+		cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) + CPC_OFF_LOCAL + C=
PC_Cx_VP_RUN;
+		printf("mw.q 0x%lx 1\n", cmd_reg);
+
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(1), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+	}
+
+	for (cl =3D 0; cl < n_cluster; cl++) {
+		for (co =3D 1; co < n_core; co++) {
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_CMD;
+			printf("# Start cluster %d core %d hart 0\n", cl, co);
+			printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_RESET);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_RESET), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_VP_RUN;
+			printf("mw.q 0x%lx 1\n", cmd_reg);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(1), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+		}
+	}
+
+	for (cl =3D 0; cl < n_cluster; cl++) {
+		for (co =3D 0; co < n_core; co++) {
+			printf("# Start cluster %d core %d all harts\n", cl, co);
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_VP_RUN;
+			printf("mw.q 0x%lx 0xff\n", cmd_reg);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(0xff), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+		}
+	}
+
+	printf("go 0x80000000\n");
+	if (run =3D=3D 1) {
+		void (*addr)(void) =3D (void (*)(void))0x80000000;
+		(*addr)();
+	}
+
+	return 0;
+}
+
+/***************************************************/
+
+U_BOOT_CMD(startharts, CONFIG_SYS_MAXARGS, 1, start_harts,
+	   "print commands to start all harts and go 0x80000000",
+	   "[<#clusters:1-9>] [<#cores_per_cluster:1-9>] [g]\n"
+	   "    - print commands to start all harts and go 0x80000000\n"
+	   "      If the 3rd parameter is 'g', execute all comamnds."
+);
diff --git a/configs/boston-p8700_defconfig b/configs/boston-p8700_defconfi=
g
index 3df7ffe50b3..85ed687107e 100644
--- a/configs/boston-p8700_defconfig
+++ b/configs/boston-p8700_defconfig
@@ -72,6 +72,7 @@ CONFIG_OF_EMBED=3Dy
 CONFIG_CPU=3Dy
 CONFIG_MMC_SDHCI=3Dy
 CONFIG_MMC_PCI=3Dy
+CONFIG_CMD_START_HARTS=3Dy
=20
 CONFIG_UNIT_TEST=3Dy
 CONFIG_UT_LIB=3Dn
--=20
2.34.1
