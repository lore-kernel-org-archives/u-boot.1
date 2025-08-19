Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF318CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 13:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C28831C6;
	Tue, 19 Aug 2025 14:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="mqxskHFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9626B81FEE; Tue, 19 Aug 2025 12:34:42 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9077A802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmsrCxCL9FutMhgqjmSop9RYOdwSp2AG9t3smFDZZ/Mv9YIqY9ADPfxdIFPNKsMCPInkCcDkeVvPw759378bY07WqrShyEEuvgfPulIH4ysQVqXFNUVH1dpIxgYL6huaifbKEjfnHmASuf3doUXsKB+D4ePa7aUOy35KdWuUCnYjetX5Hm34vbFhskAUsJ+rlru0ci+qqvcAK8XreBWkFWAVoLR1z1/FRbbwbq2GROKTHvTIaMzjhzKKGfIdL3jjvrgxwbcs4LKFe2zyegF9pViodnWxwWdnBKZ5gsYIaaH2No3an33xXw9hOwy0ITWfKRoGj+udYXfi7Siw0IwmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=801lOc8Q/fAkTXNNGHlfD2qa5KfDIl20pIzOspYsBIc=;
 b=Z0EuEsV79v2I9076imd7Dmn6jArCy16vum+ePTzGmgS+GWQwivd0bsl+jZM2WaP6ILq+sfrEJpAmZzbFGc4phRCdyf3DFkX+cyYoTbKrLrJrfYzKWF+EDgX5rRlyU7oodUXJhMmlkyv1xYpelawdK88GSmRgDHt7ghvUPPVJACGM/Y4h9CBClCTDzv53aXU23IWmopRd0Ch7NMOjU1/C8cfYHq9rQpQgLDWjXu8qmVKo/OC433jDqCZRdi+G2cAjnu6PUpMY0rO4r0DYwZXB+XxA4eoktJI8LKPsigf7l3AtzzxuclfRTjPMjtmbRf9yLU+oahNYY9u8DivQer+1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=801lOc8Q/fAkTXNNGHlfD2qa5KfDIl20pIzOspYsBIc=;
 b=mqxskHFKb4jMEoYT+QnwBI14+UbShdOw0myVnwDiV7AzNatPO/Qa41JAbtFDfw1N7pI4TBTc7PbgtcRe/SZ8y3QU90ThUfzybKsIZ4vlqeg88+PlEDnuEox7Jxh6XJv8OXZ5yOYXdBLLqQS2C2tZTP5P19teqZEoKvpdcMJE5nFVcnfCQwZpkSZEJOyY8qaO5YkWjMitB/Kl3LbhyyP5tek3cpu+hnWDkDmxaNvdk5pAnbWGGmDtW0st4IBdngQVRSYVRf0mSFBMr75vsszZ6Or+Ov+x0WsTMMnT3cF6Wbu1SbtuKBJWIBpySeQA1Gh/g4xZo3KmWLr8LjvJOymgJQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:34:39 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:34:39 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 10/10] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Topic: [PATCH v4 10/10] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Index: AQHcEPTd8PlOhGnmQkitS5QV2fnTyQ==
Date: Tue, 19 Aug 2025 10:34:39 +0000
Message-ID: <20250819103021.1518687-11-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM0PR09MB4321:EE_
x-ms-office365-filtering-correlation-id: faabd908-10f6-4d54-a1a7-08dddf0c003c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HyjEPWcrteDPKbQYCJfmqI0HmQkX3e2kFJMfAMs5HArLZZh4hd1yAPLvxh?=
 =?iso-8859-1?Q?6W3RbLrbQTdnYe0+WsnLRodXBEiOP4vJr6YsmtaRqoExMnMpIoE/51A8/p?=
 =?iso-8859-1?Q?1SQs6NEx5fHvW7AyEDQQGOUNC81Mj0/iagM/9ZVTF49le71gspUFtH8lsN?=
 =?iso-8859-1?Q?IVbRYNlOUgk9pvGydi6o6fSv16Lrr52NXvdBult+Mu/a0q0wepeqi1kj37?=
 =?iso-8859-1?Q?tfIlwNeA9n0/2ZBFF6m9VTOpK0AcoY1PDeIilJva7KixlRr94OcyvieYFv?=
 =?iso-8859-1?Q?0K9X77e6Os68843ZCHR4TgK3o1WLOWsZ+PV63v9c9wdlrFZE4Ei2GKdtTW?=
 =?iso-8859-1?Q?r3tWYnI64tj9VHDX4O8FTfqKscMTDd5o+gwyu/AUZDgIkLzW4x5lr1/pNy?=
 =?iso-8859-1?Q?mJCIDWqqHpnnxHySV5nkwwMxtiKJ/27fAu1QI8P3glrb83u6+Gl/0ZzZtn?=
 =?iso-8859-1?Q?pOun6AFyo9ZXCBYTHH55Wtaoex5YqCyP8cIdd1LOQ+DcgNu1ZDk0wMGq9u?=
 =?iso-8859-1?Q?0MPt5G2CUs7syTkAXkUl6N6l34S/LcR8f3MMr6JAq6GX/m8X8qxxrZ97Tm?=
 =?iso-8859-1?Q?8EzNOi5aIvXYXs4AkYVGhpbsipRDb2QBGyRQtXggFDfzShW0gCuZ78icTk?=
 =?iso-8859-1?Q?PXsH+ZFAumFoTO+qIqI6en3ixk8U9fZNaBii7K8jUzTUdbMuExa+DNI//T?=
 =?iso-8859-1?Q?EiPlZ5Oz0BJqVvYG5SFt0mz/MW9PlmPDtaIkWdmnpKUHbC0BMjo/M7m9tc?=
 =?iso-8859-1?Q?qcqNlI2WboOcFRbSKlESuDskK7dM+Fcr0SrADSuyiLRUKdG6yn7xsVRr9K?=
 =?iso-8859-1?Q?ULT3vmq0HbD59cacq+pSLwcQxOxcOs7qzbdUAouJOXv0HyAL+AUaKq+v6G?=
 =?iso-8859-1?Q?feFGXNTuCh49nvX964dhkhJFVh2bynNWD5ZKuVr3x6BfpDlBo96Dba0ZZV?=
 =?iso-8859-1?Q?CM4AfQcOicZWTptwtEE+fmQQU7Gmxthy6meEHqM6iXlrDzvbVmN082ZTRG?=
 =?iso-8859-1?Q?ZkCVu5oDNoz3frygzxqQyiQU1EK0Zb+w/riAQJ6mJBkvS3kVPV+o6FchmX?=
 =?iso-8859-1?Q?UQcGxjAldg/VTP3qrJgD1ckDXJSiiN6yhlOm4PTUQxEZxM82LkRgJqZLnC?=
 =?iso-8859-1?Q?89UrDKS+tdacBN0ZaQC1y/B3UEcGoNDsA5Qg38Z5VZMX+8e8B2MvlaQKeb?=
 =?iso-8859-1?Q?Q3WuzlhLLAqWGv6GFPph+LbedOEUmGIvc3Tt/z6WTXFM0AjvNOr6fBsX8+?=
 =?iso-8859-1?Q?iqxH99qtd/R8Js2Lxmd4nb5NngqqR3jqh80lZUPY/2ho3zK8s5zNUkByKH?=
 =?iso-8859-1?Q?ef2zidp4RJicRaqU6SA4GAIykWX6L7mhy+msnFD0EGO8eQOnlE6o0WTVif?=
 =?iso-8859-1?Q?v+aNZtgGCKW5aTrekonddUpbjGpAPMQJVEGnVEH/NgY9wOTNHatIp9lBHH?=
 =?iso-8859-1?Q?q5BuPfG/EQVbUsMcDy4RXIzzaYyWa79Fmgy16iAFLlFHhtbbm+Lf12zhaH?=
 =?iso-8859-1?Q?C+tKVY8fxcy4crggxJ2H/eCPyE593EBC/oUR8JYUT9P1+3jw5nuEbH5Ug6?=
 =?iso-8859-1?Q?05TAVME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h+k8LfAW1t2rH8rsw1bOfJ/R4jHmB9rm9Htt3hH+aaJ36KdwWzMcIMR+ou?=
 =?iso-8859-1?Q?qOAArF6zxeod2C3M6C9eZoUovOQrTRXl5Akmcg6Nd+iaXP0wgYojNtpEsO?=
 =?iso-8859-1?Q?4jo1LULYqBujvrWN7iQ+PMESAtjcfzhIRYsvY8qSsDymPEaZXlBg0Wlx43?=
 =?iso-8859-1?Q?5Y6ggkyc6v1JezX5ilddlwjwcN3HUHJJYimFFudD0dSYzt/i2QW92+zqIs?=
 =?iso-8859-1?Q?BxT+DmDC0OkjsgRJch95MElq/PBLQHC84GeqmsvXsSXF4hP/hZuHHdVQcK?=
 =?iso-8859-1?Q?N1l58N1WsMoL7OphGkXwOn71XhDZx6t8H7uAOSqh/HhC0nWzr29o2IPdtH?=
 =?iso-8859-1?Q?iHU5wd4tglLzj07LWy/Vhab9RMREZeplLwA1tAexdt6uweCXoDDJgBmw8C?=
 =?iso-8859-1?Q?DwpS/ROYrCywOQfgsPa46bs1qJVrERe/HcbX6jiVXd2SmQyPBmh4TTCoe6?=
 =?iso-8859-1?Q?hT7AybW0P1gAE32UM1tNgW0CImqvfls79t3QY13RPZh/t4uYOoe615fX5C?=
 =?iso-8859-1?Q?Lo/2D8gV/aPyEZqHUyYXwxWCk2tMy7IToCeyrvJf3VOBdQXrt6oCDP/Bes?=
 =?iso-8859-1?Q?mt0ZpDRsbQbx5BPToV25D22jC9mCyay5upA2m+6QniJMsJVibUK/BXSVvx?=
 =?iso-8859-1?Q?GxrDUgVvUvye2IwsuyMV4Edf7QoE8JMrX3GJVSH1p7zZbUKkTlQptjCLur?=
 =?iso-8859-1?Q?gYu8rs6pTQ4Iq+yA62eh5a69c1+HUnj4xZ5fNLGdxaDFRiv/74rZAFVjYI?=
 =?iso-8859-1?Q?gzzxBXEhs9vWX+j7YRMrJMt/bAktPfRCa6k43L1aPu2NoFHQPpvucMiFes?=
 =?iso-8859-1?Q?1YNyogeduFvZwn+/kvrWPHWyOWQE8COQtZgltnjsmqjJn8Ooe3ZIak9gX6?=
 =?iso-8859-1?Q?RA1wJj4Ke14qoR6IwGVmLJowv7vNwE3kKg7383d17+4467R25MW+JoUpqX?=
 =?iso-8859-1?Q?+lhJcMZsY1rJfBc85Itry69dRuM6IP7rA5zIh6AleacUa6FEu/8E/RJHrf?=
 =?iso-8859-1?Q?FRmkvvnjB4EMFhbZoE2YoJlAjzbUEjIClFmEGJMZCDqaqObykR0BREDa4D?=
 =?iso-8859-1?Q?dvu1j7mSH1Y38rSPPu5BwmG91hQSRj9uwV6ISpWCsM/LP9xCuLcsj2uhve?=
 =?iso-8859-1?Q?v7E1sA88Fho2l73VaKF2E7yN1SoO8X0MKVi3gDeN1z0O5+EMWS40B+dJV2?=
 =?iso-8859-1?Q?/WX/WnmnlbmAjio8IB6i1gsobZSQzt9h5uoUTQe0Orr1E8Piui4X7zZHUv?=
 =?iso-8859-1?Q?cYeB2ECh0yK6mYCHutLLMMecbmVQahIG6u+gKxtUr/6h7GiCOZCA+PSNa5?=
 =?iso-8859-1?Q?PnKpdTQ599lLQ55AxfznpHZL/yTxMlJmktewZh49PQFdkmwWW3O/bwlLuN?=
 =?iso-8859-1?Q?b+ICZzZpGPqiQylmYkOUm87VcIFPVvbdmlXU9AkGtTO9VNxB8FmNgZwxqX?=
 =?iso-8859-1?Q?0vngwt341PjZaRV7FLwWcd66TXqLbVJAsWUSVi6643Tc4Ab8JlRZ6nfIB/?=
 =?iso-8859-1?Q?g+IER9z75AbmwHJwxKJXOlQMIPCP/aVWbouB6K3iOqPCHfc61rRV7HvZjB?=
 =?iso-8859-1?Q?A+oGRUxOjZOHCc4p4ikrRVEspc06Irea2lbSork3okx0QN2UZt2oqNQjX3?=
 =?iso-8859-1?Q?Rgf1OUO1pXZLRO2xJT23Huyg4w3/HPMDdYiUfJemrpNOR75SDb/WQbew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faabd908-10f6-4d54-a1a7-08dddf0c003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:34:39.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRdAfhyQ+WILgKNSwy0kVDQTEJwIXtK0oDN1Uc8YYOs3xIZwel6+vMzGVPqdRLrSPh2DWY/842Qg72nje51BFJgUxtbEx7l3Ae/M63wIKSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4321
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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
index 3be6459acf6..3cfc6bcc7e7 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2334,6 +2334,12 @@ config CMD_DISPLAY
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
index e1bdb7f05e8..afe10e92291 100644
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
