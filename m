Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8F7C2D0CD
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 01:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965BE81DD6;
	Fri, 16 May 2025 03:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Ul2fR1AJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BCAF8205B; Fri, 16 May 2025 03:44:49 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E79F806D8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 03:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoYT3a7oCbFlxzH0GxK0Rhq+adJlKAQH8MNtSly5mPAWO7Qi6qevqRi8ZcQ7NTGncaQzt46A9qXOlvue41O6fLIOilowlspBrBx+u0c8BDtWOgELT7DenQWqMEGRPeQOGWhoZ48kStNvnPacfDz3g7XoYbQgwtIkUC6qWvfqzi5jrXk5rJ5wmYujFW5Nbjop8XPpGnOIYjAMYpch+KzNSMgbgAlf40aomS0BaL0nEhOKei01l3yT+iULXYn/adHxydomr6Om1lWoV1ogZQrtHDcyFUV0HRS+cDSW545KWFemIi1ukrTZeuH/YtGPxBPRBfs5/m1XYt0J7ywfzCVWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXV43TGcGp+err9S1uGe8S7dlUjy3DQjpxRtlw6jhK4=;
 b=sQy4tF5KFoknGYNBNqrjXnBVG2xahPlye+dXgl1JmuRpF+vORjdTV94PK06cbPiV6trjkj2FTGo+QwPUoj4glKQZRnFENcrhoJG3ASQVEVtj32s8mig+TMUoBrJX2vq/tB80EAQy1hEZVCdvGnBaTyqA7pjAMPYwhYhFIGIpmCAJwbvruNyFL8UgOdZt/FwAdGDZFkjRL35jo2RdOf28S1bYSRwNpFK3C+TssC5z/wvR5MH9l+VVjS3aKU1vKMCRaMTFbMVT8GbOboLGnbFLwYaNS6/BxfYICoO9VwF/NDFQerpPNl49pP2TK6XOXpKN9H7EB9S8s2Zx+UElKj13og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXV43TGcGp+err9S1uGe8S7dlUjy3DQjpxRtlw6jhK4=;
 b=Ul2fR1AJuzlcPLPcAjL7b/3NTzQfetbIr48GYYidzjz0nygzHzLgHvdrU9fPp/JQZRpbU6XZ3m1NjwH8uY0rImfcu89xm82mhoBE7WkFyJJQLUaQ38zMtvjAetVTYJsXuJzNlLcd+HZf87rEkxuJDqEDwsmdAqSGV9hjrpnYjDg3jyKrTsHiHzHy9Y0cB927sM34x9/RWKQUgo2QkwfYhGWACsTCICNDtrYpdN3lSpP4MVfiRQdqvpUU8ctLwFjWJ91yIwQ8H5BRFA0oOyArfLX3qBQymbfsI63YkO7bxhYWeRE7RWq0SH5WqtpnqoCDEM2kVqlZFgr0ZCVlivKJDw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8386.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 01:44:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 01:44:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marex@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Paul Geurts
 <paul.geurts@prodrive-technologies.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v3 1/2] arm: imx: imx8m: soc: fix the macro name
Thread-Topic: [PATCH v3 1/2] arm: imx: imx8m: soc: fix the macro name
Thread-Index: AQHbxatu5ZLh4aC540yyMranF/l0kLPUfL0Q
Date: Fri, 16 May 2025 01:44:45 +0000
Message-ID: <PAXPR04MB84594F80E2B48CA88488F7478893A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250515150955.926708-1-dario.binacchi@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8386:EE_
x-ms-office365-filtering-correlation-id: 5ef16d70-3190-4952-ea77-08dd941b3c41
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GV9FZCFP6yO3sd/BQ2hOhSBT21m+eK6haUN0Tt/m+NdKRqclN0JfLNjd1Oiz?=
 =?us-ascii?Q?PRV79wgMgHyuDUSOKDFzMZKbAomC5dVHP0/HX/f/HKNjyUIcTSj2i/7TD/Yi?=
 =?us-ascii?Q?DUU1oskKvkTZuvqq59r5dZzSaXgHmNtE3kAtrLusbar5zWcTsOvnj+fsSCu0?=
 =?us-ascii?Q?0SmP/nrrtZWNshlkZj440CXoN+RzEiRfgXJ9KC11+YW3PsfCcKKEoqg+m5rd?=
 =?us-ascii?Q?4yk/3F5w30Nlv5r9PLrShGlhIMqiipbkWPofGWIO2wpxoXDX7ZerT3LLuyr+?=
 =?us-ascii?Q?6ba83TsfYJ3ItGMm9yNbYqiOWvN5dDFIMw7FN4TaIZ6yi+Di1AzeaUdLGNEc?=
 =?us-ascii?Q?7/8qCYLlz8l4UP2AQUuSFtVq6hSnC1S7NYfs1oPFeg8Cqo2AMXvYYdqr0b07?=
 =?us-ascii?Q?59RpW03d3rFSXzerf6EHfk3J6jjwP86dtzv7rdWya1Nu3cYubtoagTfxG1SK?=
 =?us-ascii?Q?wM8jn/jdOjllwPi0ffiSBG1vCFqX9GrKyO2EH0UERAeyIFeoIx7R3vTkF8OE?=
 =?us-ascii?Q?eiD9fPBAD/OltvZyR8iRpeIOYeRbKI7XxSW3OxvBHOPV1hBljOH25iZdp7R/?=
 =?us-ascii?Q?P161byuHs3OAY/ptvd3ysRhSiJFrdRxQLsjlFbRS5Ws+9IXAXDeoOwPqAliN?=
 =?us-ascii?Q?myAAlpdCgfciYquaukhyNlZVi2kfPKEv3SzqohN1vJGsRcVoxEckaPvP9fBB?=
 =?us-ascii?Q?VGQJ1F9FGZraJvvR5EpuAsW0EvXlP6B5M/ULtoTrSFW2XuQY7czUpN7OSkJZ?=
 =?us-ascii?Q?E9TF6e9A+1HL13NwVr41SUg/qieyfQNErs0uaNIfLUVMtnAkoK+AovPbqcAT?=
 =?us-ascii?Q?KmeuNstEI6HNTkVzcWK4Wt9Psee0K8jjz75jnvzHA6o0BC1TDY69GO/RU29M?=
 =?us-ascii?Q?j8A+I5q1FsWD3t1o5GuMtpoajmjePSakXeOmlKGJ9HRU5lJ4z26F5YI0epP+?=
 =?us-ascii?Q?s0YfR2fO8oStlPhq5IzeXWjFASsZt+nRkAsrrFuwCFx1sIN5ErF6rOLgRXUv?=
 =?us-ascii?Q?Kb1AdRmjg43+/uQyjO1fGrDDDwBjo0NfJD4TvCmR/s+1sELbe+tlybb3tfYY?=
 =?us-ascii?Q?+DsMIyFTB4Bhq+wh66Q2LetyOgr33Mx9pt7aybpGAJIptrCuz2rhN5Dhjx0U?=
 =?us-ascii?Q?fCyl97dv31iEV++keSIpk6PAnUnadD644i8TBX4SflaYt3FXGw6h91q8udxY?=
 =?us-ascii?Q?aXzyumomx2gtlEuiICD6+DFWK6+dChkDlMok9YEzgdvYk8trKTKum6+0de7Q?=
 =?us-ascii?Q?ciLGtuf4qSKOXHsYWUwJp2oViwWtrocmYHBy4QjuelBlcU2S02f7/w2UFsUx?=
 =?us-ascii?Q?BYmS34CfDPFU/y7EH82cPt5wP3s1GREs8QJTzZwM2K4EGWMWZgFPMRiOFhqs?=
 =?us-ascii?Q?/moozeQ8t4aD9KApSnYqCQ/OW/96XSEPFdo6JSzbcCiMvXcDJB+yGSBBoK3q?=
 =?us-ascii?Q?pT30Q1JtReBzWGKTnf9w9/RxnSfd2kduu53Us2JsNP20I/npT+8xzQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ToYd5ZB6iVvOKezXycb+VOGy2+N7SeuCjRAnnQI0mOZzO37Rj2/AA+IKX0AN?=
 =?us-ascii?Q?mU7Nm2RUX6Jawb7gDcYwYpx1e90uFfAXmmPXGdy38n85UTOqwVC775H1JQur?=
 =?us-ascii?Q?eU1YIuaQgRZGFn0cMdEzV6R5T5aWkCo3S3atWcTKgDLfe6HpqPWUbSZBVLrC?=
 =?us-ascii?Q?yK0HBGEsepTb0qQr47Sm1xdDbnw4Tn/siQKJ83IyAZcD1uzWMv08zyTMYIsE?=
 =?us-ascii?Q?aHcqubk20xTiE3rjDqgRF/UfNvcEUCZv7Ji4KuSyboFXPvl2uYukgUJAztiq?=
 =?us-ascii?Q?vqvhY1AWmuGEQCz6Gt8aBEqMjQqBMcaPW12G7dxUo1wlZrLWtyXoDwtgWXN9?=
 =?us-ascii?Q?BqLI8e56Cs8A14FFH+dmPAE4ro8r9+EK9p5EdRpYGpdTULLkA75+T4IzazLn?=
 =?us-ascii?Q?uEOLsVNa0SEDIL3+lEMXACPS7FBLcJ+ukyiOteDDl2x8olo3v82DdU/2fkPk?=
 =?us-ascii?Q?+vE+oCzo2V6IpwQusjonPIWoV4YzKWrZioa6+229p4Sa1Mt5Hkr74/JBjV4U?=
 =?us-ascii?Q?iZLcutW0clZcIL30TqHd3Y4W6XwDI+g0e9RUf2W0PQB3VrIRReXlj1/x0AEq?=
 =?us-ascii?Q?DutpdrcxcoIFwTioVCILJ+SN8ycT1t5l6cDgR0mzmykQkCFCJ7/lTBG51s4X?=
 =?us-ascii?Q?Kb//blQlZtOCYmlwg4It6d2nCu6uIhGF3PNl7MArkYE2KRVc2JDm2neh/DFu?=
 =?us-ascii?Q?Jpwcq5JVuPGIs3L8kuxe4EiZAzRmRi+oXXfZkBueIoRdqHt35DKQyBqMMzBm?=
 =?us-ascii?Q?YAb9JrhpB5v6oA1IGVxRVlVEuUdVX18TIjpBRkcQNXVNA21CiSHZu/JqR5MQ?=
 =?us-ascii?Q?dnxxpj22YUsNTQRXG+9xKAkTqOs12YAZJ/zMoPvqOMXGUTa9z1Fuw/DhyD3J?=
 =?us-ascii?Q?JEW93DIUCgjSx0BH2S7ntWAChtZ84tosbNnK2XuuyQgaE1qoxZNkBK1u9gFS?=
 =?us-ascii?Q?iAALx3rwrWd2rVdE4XH5Khp5EGnL8x2mgS1s7HKw2sIKNTuq+I/b1lw/eJ9K?=
 =?us-ascii?Q?xMuvrwxj6uuZu19wOAfC+IeiluV/LJbf8BaWapRpUXgTsDFckumiWl3D3AID?=
 =?us-ascii?Q?uZlpSO++i09ThFK0i4oT6h0cl0OOGcnwba4YZgF5VZO8nFuwzAZ68JtaJvTX?=
 =?us-ascii?Q?vg7/J4UDhv7ktZUL2Z03H2AEA87gKU21zlpvYOdC2lhInRGt7C5N3xXi/iKQ?=
 =?us-ascii?Q?DNdHzw2U6Yy8BWzVuxqyO5iFUphSnjxhr3r9jMD3yWz47qeNKnJ+xQyFG/8M?=
 =?us-ascii?Q?hTSsQ9Vc5gfQ1isJxhTN+jkIQYSX4Acs2SGj/ZAxwxPAsR5giBrLMj1O4I8F?=
 =?us-ascii?Q?wETxoltAekf8aB0Y3VMrdUwhHU5ttx/LUrxusIQvz6vtdAu7ZxauBCHqkT3A?=
 =?us-ascii?Q?tUDNEjJUzy4N150JmJfGBCoJdmv2QUI2Ief7RmYqBKV6egc/WX3EpGLb/eXQ?=
 =?us-ascii?Q?2Ix6ztw84tccXT8Uh0Q8RDirz39i2KNDRUz/7J+r9wPAHEhjWaevMhpzND3t?=
 =?us-ascii?Q?6fzYagFnnkVP4MfaRken63UmptBlveBw1aDbnDJi/pDo4vd40Q7X4jVY30+4?=
 =?us-ascii?Q?K3YVxcGy0Ewsm54jDx4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef16d70-3190-4952-ea77-08dd941b3c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 01:44:45.2064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLdL38MMcE6PY/pbJ3vYe1cJs8kMAfqSK7uFk/F5Jb6AyxoWdXvPkwKmn3j/vUJWCDz65pPZtQXyetC3Fxszkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8386
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

> Subject: [PATCH v3 1/2] arm: imx: imx8m: soc: fix the macro name
>=20
> From: Michael Trimarchi <michael@amarulasolutions.com>
>=20
> The function arch_spl_mmc_get_uboot_raw_sector() was never
> compiled, even when the option
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
> enabled. So rename the macro
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.
>=20
> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
