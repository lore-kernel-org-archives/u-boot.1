Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F1FE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA358067D;
	Tue,  7 Jan 2025 07:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lx1ppndR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E915780609; Tue,  7 Jan 2025 07:59:31 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1945E80703
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJJrpep2lojitawpntImqTj9t0uBEPNDOX6f5E+RJ9LkKclaFXV+4O6l7CohtqUcUlG5CMqdaCCxogNLOyJKYOuGloBp8pMYQY1CgkDJJYIU7IE1bNunzIEhOLX4W8yKES+wqX4XjDt3WO6E75UJrHuwFBP4yyyIq3spHlvVT4IhU3TbpV4ALz3tws/ySD/tcecUMusyeWkcyRASCrq720X1F4l5C85IoTlqm1+gBpwOKPUC9nmtxsNkuVwGGDrfVQBVwc34K2+AisqkS8P+9H2HBek33k9VBvlpyxfX5U5RbiZK4QUQ0XSfeqz4R4N9xJkOUKvaRFkOgi8MZ7hTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xShNXIDbXB8pv7yzWUJsn7rSvYlKEfWH5DTk34j/QN0=;
 b=EHtmXCJC8KqXCd/aDb5nVYK3UxKt/a8Z5vkr+G5zEwzDYgcx6bt2IpRYsggkvHpb6WZgynbMKsj7nYse6isNm6ylQ8sdrMvENUHzKKq5Exl2DaSApy8MS0HIB0PA+uMdziRUFJfr142PJdt63UTruUvq+QE1J/PIS9nKpC4mmE6xzcYkvGTdQZFy0dbjpYiRLX4cP6Iykwchb2ncoow14eFrWnv/qzGRYuFJIqoQ2GgN3665od8Y6njosJXmI+Ft+D2zwaWPWS5kZuqBilWJ5A9SZVTuvcni1gP5wJ0XDuIPN9l5m1YxAfVOo4xpBV5P+eKLIkjFSRlagOlEEtuFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xShNXIDbXB8pv7yzWUJsn7rSvYlKEfWH5DTk34j/QN0=;
 b=Lx1ppndR8Nr9IAkOW56P9sgblPNizCrsxxnA9qrVsnBT3tZN30k5PSiQCeXrNLuRhOvzgBCbVKjirhTAAg06AxIzA0dC43yBAiw1z9+dh4Wi23ivARjPslRT7GkzskKJNxdqsIjzjNkQF9X5CAiHx7qzKCRpkJMl+rLNOVVaybSi3etrYRVvE9jetoSU6FG0VtG6eERkRutVun0EHiWwUxIqqL0NBE1hnve17RvfuT/oXIPS4Mus1+zqoGtiEpZcnTsvB/Dj3xfRTig+T2SwWbn457sv0+Q0aevk44Glk8AS0immBkgtW3cyvqwFizrYMBdibqHBQxejLa3Yy9ln0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:09 +0800
Subject: [PATCH v2 09/16] imx: imx8mn_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-9-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed9d061-369b-443f-3ea3-08dd2ee8d08f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czJodW92dTB2WkVUT1FrNkNicEYxOEZnZ3pYUzhyMVhtNVdvS2ZIMmhoaTJI?=
 =?utf-8?B?c0FYaUlJS1JLRHpaOWFyYlZCWGVVVUd5bk9yTEh0blhOTTlwKytET09tUTNS?=
 =?utf-8?B?WVN6dDlaV2x2RXBsUmdkZkozZVZEcmZOR3lRL1FONEVGNUcvVzlEcWNKZXlF?=
 =?utf-8?B?QVo1eUViRkplQ0U2NXArT2FOQVhGTlJVQUsyT0NMT0pJRmQ5V0lRQks1K0lX?=
 =?utf-8?B?UHN0Q2xkNEJtUHA5UUM3U3hOUlhsMWdXT3V6cmEwb0tFZFViQ1pWZFFpY2pn?=
 =?utf-8?B?V0w0RVYyQmV2aGUxMDl0ckRacW50NHorWTlPRVZidkJVVmpXT1ZkZzhacFNC?=
 =?utf-8?B?dWNWTDlGVGFyWGpncFdVdFkxb1Izc3ZaK0RMMmNCN0NlRVMvNmlmNEcxQzVY?=
 =?utf-8?B?dVNhZVR1NzZRT29kYWx2a0kzaEVmQ1UxdTVtK0pzeDJ3UVBtcEJMaEZlZTVR?=
 =?utf-8?B?cnZSWkpTTmh1bElhcWlWS0JnTkowaldES29xU0FXMG5qT1FaNTdkL0hmU0dT?=
 =?utf-8?B?Qm5WUUllUEZyS0ppeHkrNVZRcFJuU21DSmtVMFdiRDloM2lWemdkM1lHVWlw?=
 =?utf-8?B?VDJyQ1pnQTJqYjFSNm9Xa2JUbTVRYm9LSmZ4UnhOWUxEQmdSNmk0WjgzQUxh?=
 =?utf-8?B?ZjhYdndldmMvOWx3dDRMV1JlaG5YSUo2K0kzZHpRWXUxK09oWXNSaFFwS094?=
 =?utf-8?B?a096OVU4akFEUTdqdFdKR1JXRzVhZitSdTNVbzNtV2dqZVZOUjNsRkZNNERK?=
 =?utf-8?B?NG9pU1hJVGZ2VlZSZDNhSjk0WUt4SmE2VDNuaG1IOGJpVVZoR0pNNTVtUjAv?=
 =?utf-8?B?d3p3U2o3Ym9LdFYxd2NtbWV6MTJ2MkE3N2dlL21sOHFHajBDbElFb2JLZGNQ?=
 =?utf-8?B?YWdCb0pEMWJQQngwVHpDN3V6RUdETGwxMTFKQmIwN0NNRHpHUGNRbWFEWE5F?=
 =?utf-8?B?SUlnOFdxZGthVVpVR3ROUDVxdEpic1RRdUg3VHhuZXhOUEhqQStjZ0x2Zytv?=
 =?utf-8?B?dTViamRDMVhwREF6N2YwTGV4aVlOM2tSOUdxY2srNnZKc1RxWXIxOStDOHNu?=
 =?utf-8?B?aWM2K0FJbkRva0lnZmZkdGx4OFRKb3JWa0FacDVFMEpTQzAwZ2h1T2x2SVpa?=
 =?utf-8?B?VCtsS0lUdTBxL1IrL2Naem5GTEJSTm1ROVVIN1ZKMWVqMHlGVVUrc1pPWDNN?=
 =?utf-8?B?NWx2eHRWd0FOQnZ0eU05OUdxMWtVZC95RVltWDZmS2xpUzFLWFpPZEJobWFZ?=
 =?utf-8?B?bnhBeFZGQlJPYXRCZUtRTytBUTlXdGczWE5XYW0vczVIMWhFS01GOHROUk9R?=
 =?utf-8?B?QTludzdzT09vcCtWRDU3SU8xdlkvUXFNbTVwdlpnODVhZ2RKbjZDSWNrTmhh?=
 =?utf-8?B?RHcwckJrL1NnTVczOEV4eGhDSVFCVTRpREJkcWdYcFBzdmpiZmg4ZFltUlNV?=
 =?utf-8?B?TUVNcHFXWU1YQ3ZxRGZ2cjUwZGN5eklXb1hrNUhFWFpyUWdVZTBkQlRtdTZD?=
 =?utf-8?B?cjZLTFc0MHliMmNrU0t2ckhvSCs2TFFRNFpnL0l0LzI3T0ttWmpEQlIvM0NO?=
 =?utf-8?B?TUMzN0RtVFdxcHlrZXZGekxLcXlWdkNyTEdZaTdLYkc0TS9GaE5tVW96ZEpq?=
 =?utf-8?B?UVZxZXZRT2VFTng5d1ZrTWlWRXdaUXRvdVFtTkx1NTdqWEtlZGxIZ3M2cjU0?=
 =?utf-8?B?eU9RWDBmWHU2UHRvOUlFME11R3l0QTV1SW13MVNERlNvekk4ZGxaaXlRcGlL?=
 =?utf-8?B?ZnJoTy9BRklBaC8wWVo0OUYyYzFEc3VNT0ppYXhPaDNIR2kwNS95WG5ja1Jh?=
 =?utf-8?B?UkdlRlpxTW11U0w4dFhCcXV0VzVEaFpjWjVKMlMwMVNMTDAxZzRENUI4Mm1w?=
 =?utf-8?B?OU9ZeVpTTzUxRFlUTy9Oby9BTzNEc3l1YU9xYis5U05ja1diemE3MVUrWVZj?=
 =?utf-8?Q?A//kVpmSiDlib3HOHXEXSr2iwNKT4f9i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWFWTFM0ZXJiSXZqUWJ5RGhWVFVJb0M3YnQxc0ZFcVJEYmJxMUZ1ZW9vanFv?=
 =?utf-8?B?akpVd3ZzVFVHMnFLTHhaS25CcW1Cd2lhZUozbnZoWlBBcmF5REFEMkZ3RVB0?=
 =?utf-8?B?Z1FvV1htNi9RMHlTMHhoWmZiRExHNmdUczJRbjhWZW5JRTg0dEduWlM3blFC?=
 =?utf-8?B?RjlxVk9LYW82SUk4Um9OMDcrODBGWTRoVE9RWFh6Rko4cXRoZHNEaUhybmNB?=
 =?utf-8?B?VG92clc1Q0FLNHh5Z3ZxaFRQNUdya1NvVG1kelNrSnRSQSt1d294Uk91Y29F?=
 =?utf-8?B?Z0tOcmlYVEFjYmN2QituREg1Z0tLSVRzSm43cWhndHJROUo5RUdIOFpjWTY2?=
 =?utf-8?B?cFdtalNPdXRSYXE2MUdXSGZPSkdyVFhjbTFHV1VXSTlBTzhVdEltcmtLaHp0?=
 =?utf-8?B?dWFTUzdvdXhVb1RvSlNmYUREYmdHc0xTNDNRZVZkeG5LdGhoQVRCRHpsU1Ni?=
 =?utf-8?B?bmFhS1UweTE0cWdETmhVSUlVYU5QaVh1clJzdUFjWHY0Y3NwMzF2R2YzSm51?=
 =?utf-8?B?VGJpVUJUVVduT2FDVk5KS3hFcXJkSDlFb1VnZVNOWGpTbzBDOXVHblg4Y0tZ?=
 =?utf-8?B?cWJuRlhmWWNrMFUvZHpqeGFwY1E1UGcxam5mWWhTeVRDU3FJcEdXYVdQb2Uw?=
 =?utf-8?B?Y0lQckxHNHoyWmZkRk9SMis2RnZCUFJWOVh6bjk5K3RBNmE3VThRNmx6emZ4?=
 =?utf-8?B?dXpSUmtNa2NNZ2djdFVKM0Fld0N2aFBDcHE2RUlhc1F0ZlIwV0hBQllMejA5?=
 =?utf-8?B?d0xmWXIvbzI1RzNtQ1FYTERGejNsbDJQQmpWUUlvVnA3d3dYL1JoRGlpaTI4?=
 =?utf-8?B?REVDM0RNVlE3OE1Uekt6ekgrbXRlZHRvek1CNjdBc0I4VW9HT0tPUXVZdktu?=
 =?utf-8?B?WkZJWThLWnZNQnhWS0lZR3JZRFJFWTJmVnpEU2Q0SUZPdUo3cXNJZS9STUxG?=
 =?utf-8?B?N0E3ZXE3NEhKLzFxbGJ2NkdRaGsrS0ZPNmhhUU1Rek9JUXVFRHA1dXB6TjZs?=
 =?utf-8?B?alJXbkFMOVV5T2p6SFR2KzNhc3ZIMG9hU1RQYVE5amdnNk51YnVUeXhEbUJs?=
 =?utf-8?B?VEZxRWdhSjRBYUlGMGE3cFMyUFdvRVlBSW4zL3I2WDlUYjNNTDNXUzkwYWxQ?=
 =?utf-8?B?N0YrZmJsOFllMHA4eGd5eThCaXpwZ2sxMEIvbEc3QkhBVytVdmcxZklObXds?=
 =?utf-8?B?Ulk1Nm5mZWZ3TVlnaHJlakU2UXZrdklxckg3NDBLNXFHV0F3VXp5ZjNYdVY2?=
 =?utf-8?B?aHRnNWFUa3hWM3NSQmJ5TXIzZjhTdHJ2akNMUVphVjlrWSt5RTdNSlJNN0cz?=
 =?utf-8?B?QW96bWF1dmJpSjBmZmNjS1dPUlZLRlZvRllyUERjdUlDTzdkd3pOaU45dVVz?=
 =?utf-8?B?ZkFnRVMrdXQ3OU9UV3FDaWtoM2Rzb1lKaVZsNnhwT0xocytTcEQ4MDRaeWFO?=
 =?utf-8?B?SjhuaWR1MVhSKzJ1R3VvUmI2M3pLa3hJMlYxbVArVDdkekpaQ1A3SUhQdHI4?=
 =?utf-8?B?OGhIVk1sYXgrN0FMdWtHaEdXanZZME1rQTFRL2VEaFFFMEJvN1hseVJmbzI3?=
 =?utf-8?B?NjRyci8rOG5lSHBGTnlRN2xnUmFScHQrVDg1RHY1dm9iV256VDBmcDlXajVm?=
 =?utf-8?B?NzVUbzFSVVpJQVgrdkkrSUU2N2h0SCtFdE1Xc3VNR21MenVFNlZxcUdhMWYy?=
 =?utf-8?B?bjY1Rk5QMlNXTzhOdGpOU2QrUnVkVGlmTXBqZFdMK0dSZERNL3AxdlFqNnpG?=
 =?utf-8?B?VVdEYW1meXRKVDVLKzRVZXBrbDdYeit1WUpqUFVZSkoyU0w2MmpCQUxIQzJz?=
 =?utf-8?B?OVZoVWhuTGxnaHlDT2ZLVVNXV2hjMHBTYWFnZ1Vhbjk4Tm80WGN3VDUyUDQr?=
 =?utf-8?B?elNYcnAvMmFNMkMrdU42ZmwvK1RubERYRnVYakNXSks5NCsvN0RndjY0Qkx0?=
 =?utf-8?B?Tkx1UGNuRXp1dERkZU1TeXVYYmtjSVN6MW9mTDY0eW5WdGY3TVRxSjJ2WitZ?=
 =?utf-8?B?YzFvbEpVcVlib0VyVzEydFNsZ2V1TEhGc2RjSzRJOUxEUms4S0dMVklQUlRr?=
 =?utf-8?B?OWpnb3IzVFJIYjl4ZmphMWtVaXFPZXdNaUoxTFU3b1RCbWgvTTVURlkrSnU1?=
 =?utf-8?Q?vJzwtqSj1mG/sgQ+Vyot7VrX1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed9d061-369b-443f-3ea3-08dd2ee8d08f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:22.3885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX0KBRFHhMlxRMXUvr1tqN5EV4VAzPUQqO6IjSq0CxuvfcE9ZnZCu6b6bx73iQbtlxQT8t546yoXUTvlGzGEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

From: Peng Fan <peng.fan@nxp.com>

Move env to imx8mn_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.env | 67 +++++++++++++++++++++++++++++++
 configs/imx8mn_evk_defconfig              |  2 +-
 include/configs/imx8mn_evk.h              | 30 --------------
 3 files changed, 68 insertions(+), 31 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.env b/board/freescale/imx8mn_evk/imx8mn_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..16a6543ffc692f5ddce5baf1ced11889c444f3b1
--- /dev/null
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.env
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc1,115200
+fdt_addr_r=0x48000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x49000000
+initrd_addr=0x48080000
+image=Image
+ip_dyn=yes
+kernel_addr_r=0x42000000
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted;
+pxefile_addr_r=0x40100000
+ramdisk_addr_r=0x48080000
+scriptaddr=0x40000000
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 43860fe3f56f9a178bbf83dbedb6a2ca0bba19fe..967eeea4051bbb00a758c46bd1aaa3ce61bbb115 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8mn-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx8mn_evk.h b/include/configs/imx8mn_evk.h
index ca02e26c26e42f7606be4e17f77ccf25bdcf9bd1..9972dc17812b7da4f2996f96a618cf8abc871288 100644
--- a/include/configs/imx8mn_evk.h
+++ b/include/configs/imx8mn_evk.h
@@ -13,36 +13,6 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-/* see include/configs/ti_armv7_common.h */
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=0x42000000\0" \
-	"fdt_addr_r=0x48000000\0" \
-	"fdtoverlay_addr_r=0x49000000\0" \
-	"ramdisk_addr_r=0x48080000\0" \
-	"initrd_addr=0x48080000\0" \
-	"scriptaddr=0x40000000\0" \
-	"pxefile_addr_r=0x40100000\0"
-
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"image=Image\0" \
-	BOOTENV \
-	"console=ttymxc1,115200\0" \
-	"boot_fit=no\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	ENV_MEM_LAYOUT_SETTINGS
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

