Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D6EEE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC5483AA7;
	Fri,  6 Feb 2026 14:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aKMkrf0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695C083AA9; Fri,  6 Feb 2026 14:59:34 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DD7836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StMc6K5QGxqffWPLyKECJheJLPlpJHPtLQ2VYoQQzaMk1pkQFe6x62NgkRVphSmu1FAxKD4pCoEklTH9A7KxdDACouftzdXGnhicu6F08mBxBcbYnDG8Fam3EbMKABhmk/jR66cW7IdUHkkdN52SALukmU2maPLKneHY0H8ycf0oEDl3Et7s9VTVLHbM7nyYLYlc0g9HmwGFRI5NM/MLxVDP7jP7rMdfUyj3k1akS6w/8RgUR5F10ODtNuagyNiSy3qEFQ9S59KwX2vzXFd8c5NhsqtXn42N6uV61I040B6Gg8gIbmapsJwn5+NDGHi0+FD+buoaHdUWcgu+tFT6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjXscNaEh2z7l4WPXipOIneUqRvhhSDA5gMYvTy05Hw=;
 b=ZfOeRDJ30svlqnw2qEVaa9f8/ukbZyYUB0zMofCtjtjQ/QR2IA6FAWz1dlNXcbUDcR0YnSjLOEIcizXdpkxZXqOvpRtg52Wjxb+0d+DWgjnfz2urHunFFkshESw2qqneU7+E5/y2Au/+/hJ2wmE+dhXuQax5R/RyrfCbhO/3Btl3sl2liJRrh9yB9KBRc3VeptEj2wawKctHwN8vnwuXP+nWLKa3ZkAH77DHH+QETYIkkYN1uvVtUmzsMc4DQdWxngdYYncqAxBx7quyxxqYjIrxxZjq2ZDLNbDcAuT+aKDozuKRkC2S6epzfrnSoZobI7uO3DdY7SP0MgiOr2drnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjXscNaEh2z7l4WPXipOIneUqRvhhSDA5gMYvTy05Hw=;
 b=aKMkrf0joTx+lsHArFYUXkYvJsEtqectiKkxOUxW1rKtc1zzBfR5U3Zla5o6/kFdiCEXjE/rPb1BlJSGHhrh9yrk1jjOPrqh7tM54HFL8pmyR2ZGhiPxsvgoBVCzrZNBLANLc0F1nncGYACOvAGEg89IpRRDXeM8nMWVFP6T/EtC9MVnWb3za7BNpmV5I7oiyX28YQgpNJlKdr3lta8kG6vvL4AWVLLVNRVsPa2cFmZEBKVR2QDIfbnaO6RqR9Eelx6fYkNR82WDtAWndHvC40E3UedqdaKPNYYsgHytMKRInhH6seKVvUkW9bUepz9Hq9DOQqgA+HyAvEDASD1dxg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 13:59:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:59:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Alice Guo
 <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Thread-Topic: [PATCH 1/2] nxp: imx95_evk: Drop init_uart_clk
Thread-Index: AQHclxY7y3vq5T+jjEihB2v1cSDjqrV1fI6AgAA2w6A=
Date: Fri, 6 Feb 2026 13:59:26 +0000
Message-ID: <PAXPR04MB8459B9EF98DA83C9E97E39D18866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260206-imx9-board-clean-uart-v1-0-3965b4e7f79d@nxp.com>
 <20260206-imx9-board-clean-uart-v1-1-3965b4e7f79d@nxp.com>
 <CAOMZO5DovEGrWOWYbnJuNLpcHtZCH53rZ2mZOrYRF+fyON_Phg@mail.gmail.com>
In-Reply-To: <CAOMZO5DovEGrWOWYbnJuNLpcHtZCH53rZ2mZOrYRF+fyON_Phg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10134:EE_
x-ms-office365-filtering-correlation-id: 8d42fba6-67d4-4702-e909-08de6587f0d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NjhtbCtwVVVTQVdERU0vKzNNamxtTy9TdTJvakJ5S1lmZWtNQzUyMndsTkVL?=
 =?utf-8?B?ME1zcDNURElKZlFiTFpTcHY1QVNEWStrc05KOU56UUlxYlB0K3A3ZDMrdExo?=
 =?utf-8?B?ZG1aZWRmUkxuR05vNjhFQWc2V3R1NkdKbGpWWTdxenBNNlRXZ2hac1lzU09Y?=
 =?utf-8?B?dEZCbjJMV0ljWkRCRU51T0hROWswZnpKUGdDRXM2S3JzdE5SYTlYQ1pqSUls?=
 =?utf-8?B?Z1k5c0xoODdrOEx1M1hjV1NBVHNVd3o5SDdJcm44bFlMMmgremU2emZYSU5p?=
 =?utf-8?B?VENUQ0I1bWtzSGUzN1AyU0IyR21JbXp1anVOb0FzSnhyN0JWWE1xZjh1TTlK?=
 =?utf-8?B?VG5GSTRTbWtSbGdoaVMralpHVDE2UE5NUTI0M2lZSVA0czlud055NHJpakdY?=
 =?utf-8?B?VjYraktIVzZEV1dIR1RTdHhGTk5CQmZ5ajVoSU9QV0p4UkZrOFNnM3hDUFVv?=
 =?utf-8?B?TVRJR1pHTk9aMCt4SDJMQXdGZ2grS3ZyWmFndVI5c2NGSUVxMTM3RytMbktO?=
 =?utf-8?B?NzNVUEptbWh4a1RaaUxIWk1PbjYwdWE1dytySFRmcXZDTWhiS0RYS2hSYlBI?=
 =?utf-8?B?OTArNy9tMlQ4cWw3bU1QUEFvWVFtakxIZmU3Yml3RmVHVzA4R0UwSzJUMDl1?=
 =?utf-8?B?WktVQ21oem5DaU1ROGp0MG9MN21wOXhTYkp3YVhVbkFtSTlXYTRwQ0lPaGRW?=
 =?utf-8?B?RElaZnB0dDBxaldiM3BDY3VCNzVwTTRucEpQVU5qOUYwNHFvU1d6OGFyK3Ur?=
 =?utf-8?B?WkNvSzJZUGo0Q1VqWFFpNVdiQlBQMTRzRkVNZC91ZDA2ZTFrWjQzK3dFdkVy?=
 =?utf-8?B?VjRJbFVvVVU3ajByaWtIcGNWbUNnTXJkMUxtZUVORklYQTB0ZUR3SFJzcXVp?=
 =?utf-8?B?SjBmZFRGdWI3cVZOZ0dzc2dlV3dvdFZEWVp3OVhCNTFkZzBKODYwZDBHYm5n?=
 =?utf-8?B?UUsxZElZMjg4a0kzREM0Z3R5bUNNK05aK25CcGNYdkJWUGxGbFZDeE1IOUZ2?=
 =?utf-8?B?M3kvREo3QWNTQVFROHlqSG85eGF4Y09uQ1ZjOUJOaHBKSmRBRy90cURUMmxO?=
 =?utf-8?B?ZTFGSHhiVUQwWTlNLzVmd2czN2p2K0hGd3dmUkw1djlHdXY5REo5eWREVVhP?=
 =?utf-8?B?OWcwRUtLRGtTZEVXTFlqbGdLSmpSNkJPYWUyejcxY3A3SXQ1TkZtV2QxRk1C?=
 =?utf-8?B?bmZ5bUxRc0JTMHptUnVUQ2R1bENBK3VjTmxhTXNpRUoxV2kxMmYzOEVIQ2ZB?=
 =?utf-8?B?UXRnY3huZ3ZMckQ5b1Mwb3BsbnZmays5NW1odnlVY3JiMXJoUFdoazFXc2RL?=
 =?utf-8?B?SWdkTzkyM3N4R3Y0SGJ4UEdTUHpEU29wUEQ5Q2Z1WkdLSTNXMXBRT1lwZ1My?=
 =?utf-8?B?S3poVVVQNjVuaC81WEpubm9vWGY5TzFNajhDc05vY2UxeWtLTTBzZzBVR24z?=
 =?utf-8?B?amMrVUZKYkxJaGJtUXRva290TGEwOTJqWjltTkhibE4rSGJtTkx4b0tvWHRI?=
 =?utf-8?B?K0FNWEh1RDlaRzRCYkpKRE1SdmxCT3VPb2NIR2tWUDJiSEJtT2hETWJZZWpT?=
 =?utf-8?B?RzJIQ3M5VGlMdEpuQjZkbE5LaUFmMmFEbjVSblFsME9PTHljODlJTit2bVFt?=
 =?utf-8?B?anZvUnB2SW5POTdxNEg1RkNJRVg5QkY1VHc5djVpZFQ2dWZRMzgwVTAwOFhl?=
 =?utf-8?B?aEhHaWRhMkFORjY2UTN3NmN3REM4bmdTeGdXeUhxUjNvQlNZaTNabDZnVVJL?=
 =?utf-8?B?UVpxYlZCeDloRXRmMXE5ekZtZWFkYzF5ZnVqTjJ2di9UeThOQzRteUNBVEUx?=
 =?utf-8?B?SnllMWZ1WktPUXpQQXVMNTFFWXJZbmR1VDFsWjNwM2FRWmJRU1d5VUFnU3dm?=
 =?utf-8?B?dVZPRmNycHE4M3g2Mm9IOTU1ZWJISjdYRHoxaDFNd0lka1dTdU5WNEMrVzd4?=
 =?utf-8?B?MGNPYWxXSXUrVzl1WUVNdjZlekROcHpONmxTZ2dMNU1RZlRuUEdiRjNlUW1V?=
 =?utf-8?B?aWtlcnVickVBRjNOb1JyTzhpSHlHZDU2UmM2dndnVllkbVlpdVdnQ2NDUGxz?=
 =?utf-8?B?MFdPMmJoWnZTZ2ZJMkR5THBSSlJrUDR3YUJ0ZmN3NHBxUENUWWxHOGRZQ29p?=
 =?utf-8?B?ZDNSdE5OTVhIRy9pU2g5VEtQRnpMRTJGeWtpVnFKR0YraldRVGxVb2Y3S0Rs?=
 =?utf-8?Q?JB3cAdV/xZDKmaV+NMjvlEI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlyY21lUTlTVlRsVTgwSGoxdGNJQjYrS1poQUs4Y21UVjhaNG1JdExXUHha?=
 =?utf-8?B?Tk5qTGdzdGdCTWErcXNscU5BYnVVM2FPV25ET0RJQnFnVW1mV0lPM3M5THI1?=
 =?utf-8?B?MmpwZGpKQzkzQnhhWnRkL1BPS0lraDhNZFRyN2hYcGxIazNGK1NCWHNvaVpR?=
 =?utf-8?B?eE1hNmdyLzBKTkl0Tmd2b1pxSlpVRXl1WkE1Z1VEeWxQcTd1UGJDY3oxaUdM?=
 =?utf-8?B?RkJ6OUViTU1hRWRtSkh1R0E0WTJMQVZhWmFma1JqcTFmOWt3UVlsYVZuWWpO?=
 =?utf-8?B?bnpxRnI3eVMreU96VEt5NHJFSWJET2F2QkFWc1VpUnh0WlFMYUFmR3FURCtw?=
 =?utf-8?B?S2RKbnZlemFuUklKQU9aK1lOZkpWQ2xBOEdsNGFxSTVwZXJwb1dzQnE5QlRo?=
 =?utf-8?B?RzE0QklFM0daRzZ0aHVzc2JkWXFzejZHMDAwbWNtMXdDMVIrcFRLaFpLcEVw?=
 =?utf-8?B?cEthS0VjSUgxUTRIQmFZeUYrdnJPbUxITlY1d3g1Z2NQWDJuQ1lEcTFvU1lX?=
 =?utf-8?B?QldBYmNoVk91elBtQXpFQkJrZnFCVEcwc0VZaHB3Y1U0NTBDaXFTMUFzM0RP?=
 =?utf-8?B?YUxkQVJMVE9Yd0xvbFZ1RVRLRHplZmhzbXltU29YT3BnVXR0eXM3di9JVllw?=
 =?utf-8?B?eFZseXpCMGxmQmk2RHZVekdoSnJJcVVFS3hBbFgxbnBnYUpDQUFBbmNIUmNR?=
 =?utf-8?B?T05YRXRMQWpCYWNnc1Fsa0N6ektxOUpJL0ZWTWtQdEZJRlhTMXV0cjVnU2Qv?=
 =?utf-8?B?S3Ivb2R6U2xQQm1ZMkJCcDRIK1c2a29KSUo0UXg5MmQ2WTVFWi94NjFETTZT?=
 =?utf-8?B?aXJUQldxYW1EeWZqQjRpL0loTDJHQ0Z6ZTU5dXdiMnZ0dUNnOWs0ditNcHJR?=
 =?utf-8?B?UWtIUWQyTnU0aXFnUzVZWWFaOENrRXpaenRzeVlONG03SExYTmlWQ1NxNVdu?=
 =?utf-8?B?YlZXd0FHZ1RDdmY5Y3ZkcytIc251bHhZWm1CWituTkpqc3FSRmJEUGszbnRu?=
 =?utf-8?B?YkFyVXFXM2Zod1RoNjFFbm5weGFGdC9WMkhvVzA5NnpyTk9yQmdFSE9ha051?=
 =?utf-8?B?UGxIaVpHRSt2RE9YbGVIZTdGVkZrSzUvdDl6dXoyeUtWcmJsWC9wdGk4VE5N?=
 =?utf-8?B?bjMyQkZjRDZ2Tmxwakc4TlRDU1V3VzUwWHJwUU1pZS85MFpBY01OSE9GeWJP?=
 =?utf-8?B?cU51SWU2NkxFUlZnZU1qdCtpWllmWWkwVFI0K1JFa1FyaE51SjJjSXVyTzhl?=
 =?utf-8?B?RUtGbWhsL0dkMTVqZDEvR0VjUWRVZHIwN20vU1JvcjJ0Z2ZUN0JkOWdrYXU2?=
 =?utf-8?B?UWVaeDdDMDQxNFUvbCszQk4wQzlaSk1zT2dQcnpxVVhWY3JQVk85d3c0UFZK?=
 =?utf-8?B?ZXl3YWI1c1pTaUZmV1krdFF0bDZiUnF0RjU4OUZSMXh6UFB3TTBNSG1FRWF0?=
 =?utf-8?B?SmJwR0M4aHBpNlRNUERNcEFCMmcrWVVaU0V4QWZsUHhESTdJT1VNQmhFUkth?=
 =?utf-8?B?Mkx4ekFNekxPc3Y1ZFFQQjZySzl1UVJTSWVYT1NMS3VVU2V0QkVMQVVmbWM2?=
 =?utf-8?B?NE10aFR2SWd6Ry96eFRCWm0zTjAramxLcElFdS9tYjhCMTRNKzFwZklIUFdC?=
 =?utf-8?B?SFFtV0V1SHhPeml1bEFzajdybHhmLzk3aG5wQWhqcGRaOFJ3N01JRTJ0WTgx?=
 =?utf-8?B?UkNhcUw5NGZhZXZMRHg1elRnb1VCcUZ5TytkbDZEWGtwYzRNczF0NGFKSVNE?=
 =?utf-8?B?WGs0N0RYYnVJZzdneDRSSy9QamlEaUxpOHJrQnZ5VkZHMEo2bStjaWFlbnls?=
 =?utf-8?B?TzB2ZUpFNXp5cUJvWGFSLzhVcmtTUHk1L1pScDRFMUxPdGVuVlNsQTNIRHZ0?=
 =?utf-8?B?Vm1COWVJc3dWRDJvWTJ1UWRaUC9BRmpkNWtCUGZ0YkFuK2NwZHQzSDh1ZHdL?=
 =?utf-8?B?eWZ3RE5GVTJ6WVlOb1ZIdDdOMjZtYS9YdHAvemhGRWFBcVR4SisrTmg2Y3Z2?=
 =?utf-8?B?OVRjMnA3cjVLQndOdW5HTmFaNGlwY0h2bmNIc2VZbjBxWjlTZm5MUEY4c1Nj?=
 =?utf-8?B?ejd5dlI3OWcxcWRmVHR5TWlBVjc1a3hDSzZabDJPQmtXMklubTljUUk4QmJz?=
 =?utf-8?B?TkxNN1J3cDN5RktnenZPelJVcmdQTGFsYmN0dlhrOWZXNCsxcWR4VkM5Q3JE?=
 =?utf-8?B?bTJYdHlJMEZqMDNRSkwyRmZUSC95SzJwVWYrMDFOMmFoWWFkcnNyUCtCL3Bt?=
 =?utf-8?B?cjVmNVo3RnZwTDU5ZjJJdUFUeEtxcGRjNmdlejBJUGNBUlBPQmo5aTdSOHNk?=
 =?utf-8?Q?kS1G/PKel4ypogAVEx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d42fba6-67d4-4702-e909-08de6587f0d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 13:59:26.8966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rw4UAKTMC2eEOMYfvaD7tjziGl4BEaN426vq/rBf2WMUyjNvo20R4AyPr+Q9CIkbVmYZQ4/KhVK3hrAXqHBhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbnhwOiBpbXg5NV9ldms6IERyb3AgaW5pdF91YXJ0
X2Nsaw0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIEZyaSwgRmViIDYsIDIwMjYgYXQgMTI6MTHi
gK9BTSBQZW5nIEZhbiAoT1NTKQ0KPiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQvbnhwL2lteDk1X2V2ay9pbXg5NV9ldmsuYw0KPiA+IGIv
Ym9hcmQvbnhwL2lteDk1X2V2ay9pbXg5NV9ldmsuYyBpbmRleA0KPiBjYTFkOTE2ZGVhYi4uOWNi
Njk1NDNmMGYNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9ueHAvaW14OTVfZXZrL2lteDk1
X2V2ay5jDQo+ID4gKysrIGIvYm9hcmQvbnhwL2lteDk1X2V2ay9pbXg5NV9ldmsuYw0KPiA+IEBA
IC05LDkgKzksNiBAQA0KPiA+DQo+ID4gIGludCBib2FyZF9lYXJseV9pbml0X2Yodm9pZCkNCj4g
PiAgew0KPiA+IC0gICAgICAgLyogVUFSVDE6IEE1NSwgVUFSVDI6IE0zMywgVUFSVDM6IE03ICov
DQo+ID4gLSAgICAgICBpbml0X3VhcnRfY2xrKDApOw0KPiA+IC0NCj4gPiAgICAgICAgIHJldHVy
biAwOw0KPiANCj4gQ2FuIGJvYXJkX2Vhcmx5X2luaXRfZigpIGJlIGNvbXBsZXRlbHkgcmVtb3Zl
ZCBmcm9tIHRoZSBib2FyZCBmaWxlDQo+IG5vdz8NCg0KU3VyZS4gSSB3aWxsIHJlbW92ZSBpdC4N
Cg0KUmVnYXJkcw0KUGVuZw0KDQo=
