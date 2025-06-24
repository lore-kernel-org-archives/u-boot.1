Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEF6C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE49082E2D;
	Tue, 24 Jun 2025 15:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="CZ1yfBrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA1182D17; Tue, 24 Jun 2025 12:29:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D942B82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBguD0R/4fsD6uGVFv8fMQWNdgkTVrr8iZnqSqf4nPJyR9pDsWpIafsPxmk5RxA6ceKNpHTy5XrTdNU79/8bgWghF9llYYMm1+U16dzd+VXvGC8IS+4Y9Oxuuqk3Oo2ZSOMGuseQFbpzdtsc3lUpXp29mzIwFv5oALw2e9qTMnIiPRGlh2nlwFekENLP26HJ+7XlNJFloVFNudcJY9u8NpVflqHAkcB8SXNqPE8IvHx6U7JbwRzYB1seLvflZpR3V0Jx8VVTExBbh+cajyIBCWRPBmbM/Y+uhD2SBxwrkQ2uo0elYpoirvEMnbydn3aUrtPp3pJar4AZAWUTAH4rGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQWqisswL9ciayTSFA50X1FGGvjSX0axhGXYMJ8HXFc=;
 b=VB9vQBV9ZDpwt3oD9F5Bd82GufuNnCtib633FAeR5sl2KeEOoRLzEGKPF5qg/SCbIeAxl/Xc181nqrfHyD/1J2BV1zUNP1Kl4pK5Gjcbizy43JteeIeP9HV9AFIcGqvD6xqyPgWMU0mmhnbFzlU89J9Q2pz5RPKhjbo5oXrG5B7vfy6AX3ZFkyK99Xsw2yqW6JfeYecdHOkhYHDWBZPL0HwBAS5mc7ELliSpO8cCH22JV4ZHj2oqio5xVTudWuYl8TdFIo9/3UslJ52KqEM6Pf55lI2jhQa+qKbO8BGRlUXIHeL9FwCsO9cwZFRw8VvEduLFSZlAXsZTfTeXPDNuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQWqisswL9ciayTSFA50X1FGGvjSX0axhGXYMJ8HXFc=;
 b=CZ1yfBrhOIBYj/QxKonQ95pd6WTtFffUM5kPIdEMxIBBsXsXWSqrWsK3jylPLuK/44elSzNDS4Cww2J9CUnjFXNiJHK+RfYXn9+MFueWeI7r7rRk9s6oin0toBwQOSdBRb1kUxOPHv1A9wEHIyhYEB4H0xC8kQ5XwZZUkCs28jOwxjOJYlaNuxisV5XaBrzyPmZnWqeh+nKzLxtaVksxOeVmbWXFheZHYl6/60nq3AE/VJ/GurieAa2hPJ3auFRVkUMX5eobowBf9NN1tDVztiKvmC+VaZb8LF/izSirNvJE6rxnjLxVMn7atjavmwcZUdgR48d3RSUeq1tcGMCuWQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM8PR09MB5228.eurprd09.prod.outlook.com (2603:10a6:20b:3db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:28:58 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:28:57 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 10/11] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Topic: [PATCH v2 10/11] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Index: AQHb5PLLnKbGbGGxakWyOuTo4InDwg==
Date: Tue, 24 Jun 2025 10:28:57 +0000
Message-ID: <20250624102449.324410-11-uros.stajic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 55b19405-4a4b-40ef-d46b-08ddb309ed95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VQHaaePpyCO8C92UWfV7eYWl+xauvUIYrrSv0KW0YufiLLmmT0i8mg7YkG?=
 =?iso-8859-1?Q?YqqSi0JyKUsjjDiRzvLE0U3RyFG78aaxD+PtTvZkQsR2W0XHOHKXoQAHZm?=
 =?iso-8859-1?Q?tiiunhtK6l5C7e8G9qkM0n91YdsI151XVnpB88KeL5Fyxj3tP8XfBpsBvw?=
 =?iso-8859-1?Q?rilvVUCVnk3o9qZ/1DbHLwOTWrg2AbZ1bSVYtHo6onIPwwtTFa96hK/r8r?=
 =?iso-8859-1?Q?9QtXCYM4knGZ4xH1BsW0Ydz7OU6YKHbE/huKPTuyRyivtV3zSLcaaGHVYd?=
 =?iso-8859-1?Q?pajcQ+BoUQ5P1BHG7VseE1oLwgQXANVIGbwEtcU2bb9vjEiEs89VNXt0eE?=
 =?iso-8859-1?Q?+bHHb8FsYQl7HlBiJxXFVJjDwR6qFgBeylOmY0klf+7YsDWrgau5vkv0+4?=
 =?iso-8859-1?Q?UwvtBQATM4BUHaXgvumzCNPGLcYe1CRvGW4mTCW9udZpzq5TZbdjB0jKDe?=
 =?iso-8859-1?Q?YNm8dQ48JbPnsWWYRTxuCt7nOVy20hPvL8x7Q7XCswni4vnQCl//5Sb7uB?=
 =?iso-8859-1?Q?jRNQrwYd8axQBy/sowA4l656Tp/RHdYW+qCqyEfmlVl0A4NfZ4uAEEkSSH?=
 =?iso-8859-1?Q?4RhvqPsy0ZU+K19mRLN6/bQPblYXuTXygSVKEiK4J62suNluUPSDXkKvUV?=
 =?iso-8859-1?Q?yPopi7p24cabnBv8BdOlz/ya3ZoxkBCU2tN52IHNaSliz5onN/JXm2EeKA?=
 =?iso-8859-1?Q?fGyoCfRV9FN+u6RZVQtdrx27mGHPnQN+/Sbsa2x8YtCPQqd5HNX6MF7DA0?=
 =?iso-8859-1?Q?kmJf7gM2oTLD9KvPTfj2kHLg1q0XdHmTWVpLabH42SrJq+ZKjtBA2jRXQh?=
 =?iso-8859-1?Q?hhuEEcb2Ed3KPmcPIfqsLZr7pLD/9y60QOkpUUFgOw4siULumMDLxLf6ug?=
 =?iso-8859-1?Q?SesKeIIpxfdL3590yGAnbCRyBg+WcySGsm9LJ/AkA/vO7x8niziz7BiKuv?=
 =?iso-8859-1?Q?mnKq+IuJbFA7RoMc8PgoPbyIVebfvBJUV79cCWE7yEW4N49NM04/m8nW3z?=
 =?iso-8859-1?Q?AmRIbGpVPzc7okUwlLlZumZt/VJgm+kd+fuMMpN3MiZEpp5+YIWluvtRsn?=
 =?iso-8859-1?Q?ULAHd1AZDcXFKEbKf5GOi8Tc0I42rcsQ9hivw9cFwhN8FD8neC5OcuIf3j?=
 =?iso-8859-1?Q?nVWqZS5We2HyzN6xsGgxyBrjn8XDX0ptYXK3imFCWvkPbhsLj7csF9z1I7?=
 =?iso-8859-1?Q?chpuBb4R6lbm/F2fLbR5bSpPoeCyFACeKXIDas+paiYWQUxbvmkfcMZ3ys?=
 =?iso-8859-1?Q?vMRVrIL8SXdB7/AZ1h3+Y+cDm1b7oQZ8q8ZKtCFOkoseK/9SEPJv1gmCB1?=
 =?iso-8859-1?Q?uTXvTqofhTMGks4uBkB4vLsr2KXkIMU7TKCSNzipJBSEyHxqGEJrYP+fxR?=
 =?iso-8859-1?Q?ztIIE4Gqb4HtgCDvoIPW02pVkyTgJiNUHS5UDGlp/NKr5fAypp7WmXUHZa?=
 =?iso-8859-1?Q?geLO8via9Z3NJQYg/0aMlTuo69tZ2trnyEGgTvsHDlXKaS6SC3GVbmROlZ?=
 =?iso-8859-1?Q?PdxsWX0bpNDCzQEoUTFl6MRjwk4Rwi8dtywzhzhGRaaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BFmBa2lXMuLvdSGDysxtCBu7J/PErTF0/JN4qXGsoG2Z11j8qgTsdDo/pu?=
 =?iso-8859-1?Q?hCtq0kTae8vXSqmXkFPwG4tYonW3kOburMTgu5oilRDOo2KYeJcXJXHx9z?=
 =?iso-8859-1?Q?v38IuLYirodDoFdbx6GO4dUYiXaYnIQE9Vm4d/q8q5cHZh8gSVJmx34a9l?=
 =?iso-8859-1?Q?8XYQtFa65jidh12+WZXogAGjEjwI9iVEP9nQ3FVAioQfefCwB9QEynutq1?=
 =?iso-8859-1?Q?n5brNBx27UGMIB4vKFWXxNMeFP0Z9sqSwPHx64hdH7YZ12Vrxtx3mM/3Hb?=
 =?iso-8859-1?Q?ijPspkzWLTMPIVE0GBhASEfRcr10dCZd2FNuxmGZno5JQFOuwfogtGISo7?=
 =?iso-8859-1?Q?RqzfJkma7sL+IrJwUAg6fq7t5aOT3WOT7aZF8VOcMXABYALX3vflIzmHn0?=
 =?iso-8859-1?Q?43o6WckU65VSYDemUqeazJPoH+HgZJ8yhRHwvnreXIogBEqolPDT7M8XWs?=
 =?iso-8859-1?Q?xgUADxn+7uuzgbbmiVQoZGyZY1IS7cozNhD0lrepgv8Zu0wsOSD+ABro3m?=
 =?iso-8859-1?Q?1Axxh2zShKviTQWaVmciafD/OY8Ux7VRLSIL1Q6EcXO6U9g7VXjrDEED11?=
 =?iso-8859-1?Q?l3uJtKyrDWL2K975c0ZG0dYf3mKh6i0QpPonxbUYMQwfNEm06D9oVXfBFn?=
 =?iso-8859-1?Q?j7oo9i8dFyvD6OFFTID6LZl6YTwCSD7vyA1ydq7UR/nUxdgZBWp4u+Nq5f?=
 =?iso-8859-1?Q?aksbXOCw60/E6YRsAWfk0jMoJRCW/tQ4w2NXPHeJnPYXvTts93S0EnWV2L?=
 =?iso-8859-1?Q?h4SoPSwlz1pj2pSwuTRZSABLyz8wO/AdhHJuS9BKuWIL4KJ5hzUipW+Jx4?=
 =?iso-8859-1?Q?9AGmuSF/VQ0KjkUV9YvlbTNR9j0QGe5cz8/j93SEagm0bkMGWZTEVBWh2N?=
 =?iso-8859-1?Q?ehGyBs80pVGQHeTYLD7G2HwzLSKKjTa9BQkThB+XjZ/BhQQjH+rkMEzckX?=
 =?iso-8859-1?Q?6d4jLCxeJQI9TGA2UXi1uFp3OFb/YTZmdy6PprHB8VU+feZa0RqTN9pyIN?=
 =?iso-8859-1?Q?f/mu+0CK+Qq71Ew9hypjTu3mu8DninJzOAJM3v+/oJLnRquDjtO5tSKV7z?=
 =?iso-8859-1?Q?JXcBMm6Saea3mWOL+usXGNIT8EGyfJNi83HSKEfmbP9tugUYZXkfl/O2XR?=
 =?iso-8859-1?Q?yO2GhoHWBsNRHdxEhaIpHbnHbrGeOb0TGiz0QdCmfpTmfe7RwgtAy8i6jv?=
 =?iso-8859-1?Q?aUuyGtnP3WYKBh5MRpPcw6QVfKZhY0j0DU02UI3KBn7H1Hlini3dT+HfuI?=
 =?iso-8859-1?Q?iJ+KiruK0RaVwUhEWKszbzCd5XHPjkkqRjcmw+WCagFDQ6JXfmXRsJKy+l?=
 =?iso-8859-1?Q?F46Sgq3s5BErlvIR0aJJWZjpJdRQVwTLiI/Wn2fq9SpSiFNRk82hiRoJpF?=
 =?iso-8859-1?Q?vI2WNjyiui13zmwSnk3fHppVt/qFtBSlqeJpKjAosImeLGzEd18/LNWiUN?=
 =?iso-8859-1?Q?TLVd0h6UliLn4bH8W+4wRo5GHj9Px+EqjRCdPXCp7wPidyY3BrFriGYMtw?=
 =?iso-8859-1?Q?aU+a7lUhgDMDfJi0BUvkE/Q8oUKacdY1FfqfnoLvBodWPW6r2fMoT5DXUo?=
 =?iso-8859-1?Q?YTpzwQQnP2Gf/HDeaWVWkMtQNRCrxsy/gJMTU4c5UkBRkhAZ7b/moEP3vb?=
 =?iso-8859-1?Q?WA2Go403Lk5FI2UXrkFeu7MBrIYX1k9NFVOAXi0SRAAmgHedciXDfECQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b19405-4a4b-40ef-d46b-08ddb309ed95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:28:57.8324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWZO+14DeCF5ydwsoRNLjPeeTiJsz5zVGra3yBlk2bRTH8v6hxiX0jMZKNy/I0vbXVqT3kA7wBt3qVHyMucjd7yyQnhOwk4L7fcUzJ4E/ss=
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
