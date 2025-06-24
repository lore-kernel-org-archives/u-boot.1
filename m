Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2C9C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0EA82F2B;
	Tue, 24 Jun 2025 15:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="tDP8Jzbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C8782D17; Tue, 24 Jun 2025 12:28:43 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F80A82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhksaqzEpMaybalhrb4ZzRhg9UTbxIcxmfeVuIXQFTPDxs4GkL6RvgwWKFrXGP3pw6xlfaUvMdmC6jPno9DfW/H1650wmGrPwrwtGHU0JyTnS5QwrvDmlxW5371bsDo+PKrdS4r/GZ6TmkLMsHdYlKzGs0umep7NQ+krUQGJYsl44uUR1uNYUa7XlfVsqGdDkKoEBV2ox7oqJzwxl0AWR4SWQmo47tugEvaT5JWy5gp0iB/BEhAM3s0aNY8jx7VbtP3K+a/6D7ogXLS6U0/HhJ4LEXmFCd1mUalemhJjXGUQzsin4m0QbSwRsTG/G0fdg6nKlnuXoDN+TRbkVZZNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgx1kR7CGFKYHnpdcfKGFbuLW27PNO6HbXFUy1LVTGw=;
 b=tY68V+O3IpD6W1cryh2LCMh8o1ZGFNJj4HAvGi3ASZvhQMNADZzBHbQEAC7viBZUOP54JjLreSpJp0awz13UBU5GjsYa5icoyiLc2x73XzyqxORne9tHYmcK79NSqCb0GvSZCqppYsA+RKhvtFewJ3JP0WfL5rkFDgHb+Bz1Uktojs5wZn/Mup9NypINYQNLv+IlsSPsM97vNuLMsMW1oXaB87e26USabgxg2RL2GdGDZI3D19aV+Cale2sNU3K24d98Si+rN+g/AvaeVtfm3bl9oIbpGRfFDUYRFygDFqsKKJtpw+jnG85OuT5UMDEOdHPE09VmJbIjnMwORgyytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgx1kR7CGFKYHnpdcfKGFbuLW27PNO6HbXFUy1LVTGw=;
 b=tDP8JzbhgsuNtRmDE4gpxmJOXlh1NqGAmhBXwL/aYe7OvbUVCMKVN2duJTZwezJwllh8Ed7BDhqitDV48+wPzBzP3Vw65gubFuGIkD1LQRw3QJFgqa9k4u2L94kH5ZEOKR1w6d8+PkU8iQ0d4/X+iHkiV5F4lHHwvwB4Gk7iCYNUk7bLT1hurkeVK60ehubvyzNhFfRHVkKIN6GSkYUJDuCQtK09W2ae17fFAWnMs0JisrQheHAtZaYTTjL3/3tix+61f/TY2Y6+LbLsHRI61x5nvnFhNZQhjnQkYZvAXVZzWVLOK7KadifZPn6FO0iotZCFPwQ13QoWj70CcX0cJA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM8PR09MB5228.eurprd09.prod.outlook.com (2603:10a6:20b:3db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:28:38 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:28:38 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 09/11] riscv: boston: Add support for LED character display
 command
Thread-Topic: [PATCH v2 09/11] riscv: boston: Add support for LED character
 display command
Thread-Index: AQHb5PK/B9uU4C57lkucjb9pslYgGg==
Date: Tue, 24 Jun 2025 10:28:38 +0000
Message-ID: <20250624102449.324410-10-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM8PR09MB5228:EE_
x-ms-office365-filtering-correlation-id: 3e5447c6-c203-46fc-35d4-08ddb309e210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ELacnC1JAA2KIL4H7i4x5enVhvpc6rGRb3Yn9GgjBGITCEeBQ5Ur8bIWMc?=
 =?iso-8859-1?Q?Ehe8UqLQJDGPxeaG5XMPlTN5bnu9ESS/uKNXUTOndNdcSzq2+GmdQO4M5r?=
 =?iso-8859-1?Q?8r6knguji6pfso6W+TBlbWcS6Yx7rDHGnJKc2byAW6RWzNDw2tH81/WMaS?=
 =?iso-8859-1?Q?b5+PUt0ljmTxh2hHaOu+oSirMvhODhUWUQPxMiBg9OhXZaAnyQTbCPIfJo?=
 =?iso-8859-1?Q?iPsATHZhmWm1u+6mSe2/D61cbMFE5cYVxx1MY8Hmmuh5wp/6dC+LBXj8+V?=
 =?iso-8859-1?Q?/oDsFgSDpsvNVjWHMO00ZZU8KJ051C0kz/gh+YmO2v798gpoxeQSj7aDdS?=
 =?iso-8859-1?Q?HtNQOc4JDtjmD9bln6AdxwqPQ/7Rgu2+8LkjT87to6jzhQJauUKQGf3O7Y?=
 =?iso-8859-1?Q?KS6Fk356ADAJNVdnhPAQsN17jCW6FdG3eE+wQe7P40YKCtF8MQxX2jzzHn?=
 =?iso-8859-1?Q?9yAGtaUG8Q/TKvnwC/9j3W2OrnTBhgtq3Yl5pCtxvE3vPSfQ6iMnOXCsTA?=
 =?iso-8859-1?Q?wOlY+UyYqL3Va/TPLw+ZRFkZfeYBW0YgmfsXCeSqpuHT3QRHwbstnY7MDH?=
 =?iso-8859-1?Q?jhn78XM0z8vJjuZ0mH04cJ7WLGACohgsP2ItqsdgBHCygxbiCXgSqUkoRL?=
 =?iso-8859-1?Q?Gg1i4bXgxedb5mrrwumgLsdI25u1oZTbvw9hUrtkVP7pacsVxWpi9k0Odx?=
 =?iso-8859-1?Q?s05xzxK4atlXf+Atyi6ncNg6knKv2hgolsK6fKX3eIv0Q7hp6dDgsmyT53?=
 =?iso-8859-1?Q?o+T4DXA17qsmsrukAml4x61/XvZSlGR+prQEE9fEfSFwiQ9v4k0+365WYY?=
 =?iso-8859-1?Q?dcBhTK//LuQD66f9tqexvTQZZwNgoWqNDAJOJjn66YbDO7IGanlctm80O5?=
 =?iso-8859-1?Q?MyuDxw+gey3QUyzXipC2exBeEho2gXOTiqNsbbTxILTd/knR2KFvnAysdt?=
 =?iso-8859-1?Q?K3mWcSyJgeXbk5ZIfG7kgLFyLTmInEenxVTftXbWc7qF/K7FkHamxXwFTj?=
 =?iso-8859-1?Q?f35201RavoItk6wOyOpDhI4pfbgmFdY54Qemp8qrsluV5oD1Xg3k7sLifJ?=
 =?iso-8859-1?Q?PE4F1i6S708Id+SVPPp2W3hjSn8gCVBSb72AnP7d/ZVVzpc3x9cq+Jz+oW?=
 =?iso-8859-1?Q?SzpVX7oOyKHxl4xE85f3QtQ9BVoTnbdmDpWUA5giTDGpABtzJZwaDsdVoQ?=
 =?iso-8859-1?Q?KTPW7zR4HCS6IpQk75EWgportKwkoibUi7pmOE0RW3cyX2NHF2bKR/bDCF?=
 =?iso-8859-1?Q?BVaHBAmghtiBskSQfUQodyYOMg2R5R8u1geIofZmUmnjK1xwaTxpmA178k?=
 =?iso-8859-1?Q?EdKrlDE2KZffajeoQlcEuvtWCvdG4Hp3ZhHjXYxuXeBhdCmSMw0G+cs3II?=
 =?iso-8859-1?Q?99fxOoaaX2iwTKH4x2sa0iPMQZxLM3n4Tjo4Go5tlkKfBykHfd4i+CFXD7?=
 =?iso-8859-1?Q?YNAlZZFNA6IxDwVGCqssVoDhL9Lz4U4e/Zbx8cTrd4LekJMBTxHPmcjAH7?=
 =?iso-8859-1?Q?oz/sHsQ9/VUZOIjpdwa1XAVipGq5SxSXjKel3E3VVWmg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UX0sRY38YwKaiuUrqMWuz4TYxuRreU/R7GMdFc4ODHlj04zphAEdyy71ok?=
 =?iso-8859-1?Q?1pL6MesvDyCRcfeaZD+YwJAKS5oazUSVLP6/m85IoNG7nBMEE+9b5rGBq+?=
 =?iso-8859-1?Q?v4sBOK01+DboEMI5BHsa1VMzQ3F8biFuXPEYGBrZ8j9MkzYYvgS4ACwUVj?=
 =?iso-8859-1?Q?hGp8yumu0YaI5pjGB6Mykw2FwljDo/KyaL9rehhMHa+MBWKLcQ2knsdyM7?=
 =?iso-8859-1?Q?c1NUrmbjTqiYAut/Ws88+jZoBKgkL0JtOP9Gbwav2t7UcXl1mwn2jwGDAz?=
 =?iso-8859-1?Q?ay1rPC/3ft+63/h4QXJQFYKjBn5QWBgP07bapcp/39/aWjz7DHGUgfkh7+?=
 =?iso-8859-1?Q?zGEvTEzg/NFYvJmZSJvH+7/5LIbWairNLLixCG19AD2hgH3sqsk0AeNytQ?=
 =?iso-8859-1?Q?uSeZ6fQumy44wxAxry3p7bHxt0Cr0uXRnnHRuUbap+HxsH65S3XIPb0DwI?=
 =?iso-8859-1?Q?8Ocu1eNwJvLxYt1jOGcK5tW8DXLAneI/eX4Y3kJNy9qnsxk9bWYSf3rane?=
 =?iso-8859-1?Q?hQRWnkqZ6zebUWP0f7XNOeWKjMkuMTTZm/HfrboXhQdQSIFV26AFRQ+GPl?=
 =?iso-8859-1?Q?f8UtBsMS4qMPJ/KV5NXFHQaQEaLBy2Orxu2yhrUicfRUpGjY5dn9vOWwig?=
 =?iso-8859-1?Q?DWfmZEjgPhB7+Hvsu42gPHkoigRg0EGR8aOTVi2IEEKnQv41mOj7glfqJt?=
 =?iso-8859-1?Q?uygqGqimIIbJW8fS+u3nrMSQ77C76QJbR90SpqLztPLia3mHCrOSLYxRWk?=
 =?iso-8859-1?Q?UjdWdDOv2EdsjVVC1/ju0BawMcvjTz9IlOJCPP3J/f4N3ZgMfU81o5Kxg2?=
 =?iso-8859-1?Q?sCM0GK8sLEHq6lH4r/I+udivCCLBrXnDp0dWPpnLscnXONRk7iOGaDJZ+w?=
 =?iso-8859-1?Q?CqQ8AEPI55OvUJZOsG4+KYJPqaRnS0bICNVcSS/h2QQGDaC9qcpdFpFPQa?=
 =?iso-8859-1?Q?LR5UtoH0HjMaHbwlcXGSeKRZ0IZcYFItLY89N/qAbCHAhyEXV5fqKm95Pz?=
 =?iso-8859-1?Q?8hnOqiGSDW5uYNCFMTsHYQUpL8AAPdUabcujwVEjAZnpUze6r0R9FliRh6?=
 =?iso-8859-1?Q?TijEje+ebRC08NtdeCpBbb3n5HiNWG5R/AskDXK/abjQtvegwfjjBypVR9?=
 =?iso-8859-1?Q?AsjtFlWYtHKl5acGFBCT+XFZ2T67jA1+ndPZv5hNBGRsC/aNzliQWNv9tL?=
 =?iso-8859-1?Q?ZgVNCkCVeiAn4Yzv1dE8vPhJf2H2zpMtpJbpXOUzyPx1O0rOwpMPDcwn0x?=
 =?iso-8859-1?Q?hxbOjQnyynGY91BbgFpZR9E0bMkXJP6Wh8HrahsZ5ZOZZXBLTo+XZnbbv2?=
 =?iso-8859-1?Q?8H8gH1cLfZAKxaA3zzCoGj16GVFg+xN3Z+0SHY99NIAIRQNylW0ybwGyPS?=
 =?iso-8859-1?Q?gWR6DswMBZcpFGglZl/OP0NZxFD7VL/Vl7/3dYmOQG2F2LcBeu/G4UDYAk?=
 =?iso-8859-1?Q?u7R92BaYRIYZgpZ2Ild+6N98snJxl/CAdcZpRQ5nvkTC/m/bJrUXcoE/FF?=
 =?iso-8859-1?Q?f4r3iFfCbLvpUQ4PJqLuBUldUft34SlnhsBmIjON8oP3CXcnDsM40QDjUQ?=
 =?iso-8859-1?Q?v0XCXhrVmntRnhNR/wJj1CsxYEMAxQ8R8Jmnof/01Zu+VI2wxf9Aa4ezdT?=
 =?iso-8859-1?Q?Gn1jHQHSchgYaSRQ8idnLPcNm3gYZU22GkMiMqkqGcTKq8/Fx+qDAl5Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5447c6-c203-46fc-35d4-08ddb309e210
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:28:38.4993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxdaOuCsPOeAeLs7qQHQ3yObDRSidDFlgYbjFAFAr7isU2eW9e+/MefqklIatjTOOfomtFT7xyt8rQouEQ1OejSZGBA4d9+eNNIiblAPYD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5228
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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

Add basic support for the 8-char LED display on P8700-based Boston
Board using display_set() and display_putc(), enabling the generic
'display' command with clear and home support.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig         |  4 ++
 board/mips/boston-riscv/MAINTAINERS     |  3 ++
 board/mips/boston-riscv/Makefile        |  1 +
 board/mips/boston-riscv/display.c       | 33 ++++++++++++++++
 board/mips/boston-riscv/lowlevel_init.S |  2 +
 cmd/Kconfig                             |  8 ++++
 cmd/Makefile                            |  1 +
 cmd/display.c                           | 51 +++++++++++++++++++++++++
 doc/README.LED_display                  | 26 +++++++++++++
 include/led-display.h                   | 33 ++++++++++++++++
 10 files changed, 162 insertions(+)
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 cmd/display.c
 create mode 100644 doc/README.LED_display
 create mode 100644 include/led-display.h

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 4d55d96603e..5ab89cb5a69 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -44,4 +44,8 @@ config TFTP_FILE_NAME_MAX_LEN
     int "Maximum length of TFTP file name"
     default 256
=20
+config CMD_DISPLAY
+	bool "Enable display command"
+	default y
+
 endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 0d9a951441f..b04dcde943a 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -9,3 +9,6 @@ F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
 F:  arch/riscv/lib/mips_gic.c
+F:  cmd/display.c
+F:  include/led-display.h
+F:  doc/README.LED_display
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 007f68287bd..8ca0967b09e 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -7,3 +7,4 @@ obj-y +=3D lowlevel_init.o
 obj-y +=3D boston-riscv.o
 obj-y +=3D iocu.o
 obj-y +=3D reset.o
+obj-y +=3D display.o
diff --git a/board/mips/boston-riscv/display.c b/board/mips/boston-riscv/di=
splay.c
new file mode 100644
index 00000000000..cd222cb6648
--- /dev/null
+++ b/board/mips/boston-riscv/display.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ *
+ */
+#include <led-display.h>
+#include <asm/io.h>
+#include "boston-lcd.h"
+#include <string.h>
+
+static char buf[8];
+static int pos;
+
+void display_set(int cmd)
+{
+	if (cmd & DISPLAY_CLEAR)
+		memset(buf, ' ', sizeof(buf));
+
+	if (cmd & DISPLAY_HOME)
+		pos =3D 0;
+
+	lowlevel_display(buf);
+}
+
+int display_putc(char c)
+{
+	if (pos >=3D 8)
+		return -1;
+
+	buf[pos++] =3D c;
+	lowlevel_display(buf);
+	return c;
+}
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
index 8fa85749e40..f65021a0974 100644
--- a/board/mips/boston-riscv/lowlevel_init.S
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -15,4 +15,6 @@ msg_ddr_ok:	.ascii "DDR OK  "
 	.globl lowlevel_display
 lowlevel_display:
 	li	t0, BOSTON_LCD_BASE
+	ld	t1, 0(a0)
+	sd	t1, 0(t0)
 	jr	ra
diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..e40fbded3e3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2313,6 +2313,14 @@ config CMD_CLS
 	  Enable the 'cls' command which clears the screen contents
 	  on video frame buffer.
=20
+config CMD_DISPLAY
+	bool "Enable the 'display' command, for character displays"
+	help
+	  (this needs porting to driver model)
+	  This enables the 'display' command which allows a string to be
+	  displayed on a simple board-specific display. Implement
+	  display_putc() to use it.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8..e1ce7bbaff9 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
 obj-$(CONFIG_CMD_CYCLIC) +=3D cyclic.o
diff --git a/cmd/display.c b/cmd/display.c
new file mode 100644
index 00000000000..0602345e6c9
--- /dev/null
+++ b/cmd/display.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <led-display.h>
+
+#undef DEBUG_DISP
+
+int do_display(struct cmd_tbl *cmdtp, int flag, int argc, char * const arg=
v[])
+{
+	int i;
+
+	/* Clear display */
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+
+	if (argc < 2)
+		return (0);
+
+	for (i =3D 1; i < argc; i++) {
+		char *p =3D argv[i];
+
+		if (i > 1) { /* Insert a space between strings */
+			display_putc(' ');
+		}
+
+		while ((*p)) {
+#ifdef DEBUG_DISP
+			putc(*p);
+#endif
+			display_putc(*p++);
+		}
+	}
+
+#ifdef DEBUG_DISP
+	putc('\n');
+#endif
+
+	return (0);
+}
+
+/***************************************************/
+
+U_BOOT_CMD(display,	CONFIG_SYS_MAXARGS,	1,	do_display,
+	   "display string on dot matrix display",
+	   "[<string>]\n"
+	   "    - with <string> argument: display <string> on dot matrix display\=
n"
+	   "    - without arguments: clear dot matrix display"
+);
diff --git a/doc/README.LED_display b/doc/README.LED_display
new file mode 100644
index 00000000000..19977ea7e0d
--- /dev/null
+++ b/doc/README.LED_display
@@ -0,0 +1,26 @@
+LED display internal API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This README describes the LED display API.
+
+The API is defined by the include file include/led-display.h
+
+The first step in to define CONFIG_CMD_DISPLAY in the board config file.
+Then you need to provide the following functions to access LED display:
+
+void display_set(int cmd);
+
+This function should control the state of the LED display. Argument is
+an ORed combination of the following values:
+ DISPLAY_CLEAR	-- clear the display
+ DISPLAY_HOME	-- set the position to the beginning of display
+
+int display_putc(char c);
+
+This function should display it's parameter on the LED display in the
+current position. Returns the displayed character on success or -1 in
+case of failure.
+
+With this functions defined 'display' command will display it's
+arguments on the LED display (or clear the display if called without
+arguments).
diff --git a/include/led-display.h b/include/led-display.h
new file mode 100644
index 00000000000..50830903b0d
--- /dev/null
+++ b/include/led-display.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2005-2010
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2010
+ * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
+ */
+
+#ifndef _led_display_h_
+#define _led_display_h_
+
+/* Display Commands */
+#define DISPLAY_CLEAR	0x1 /* Clear the display */
+#define DISPLAY_HOME	0x2 /* Set cursor at home position */
+#define DISPLAY_LINE2	0x4 /* Move to line 2 */
+
+void display_set(int cmd);
+int display_putc(char c);
+
+static inline void display_puts(const char *str)
+{
+	while (str[0])
+		display_putc(*str++);
+}
+
+static inline void display_sets(const char *str)
+{
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+	display_puts(str);
+}
+
+#endif
--=20
2.34.1
