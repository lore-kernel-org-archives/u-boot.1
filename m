Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19911FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA75384366;
	Sat, 25 Apr 2026 18:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xh6lFwP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC3E843FF; Sat, 25 Apr 2026 18:08:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB6D84314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
Received: from GV4PR04MB11356.eurprd04.prod.outlook.com
 (2603:10a6:150:298::12) by AM9PR04MB8924.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 12:48:00 +0000
Received: from AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 by GV4PR04MB11356.eurprd04.prod.outlook.com (2603:10a6:150:298::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 09:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4RIrOP4iMZ4I5SuG8PNgmEyOEwLtzAAv3w0IoZqxrbIO5Uvn9TX++tom0DaMJbnkO4w7mnkuXK3EDLkmprl85QDI92IDaAg6EYZj5g/vKMhAhQPM+wiqFgm4SC70u4Z5Yhf1oO/kmrHhoCDK/mZ9tfw5gBfRv+4O0bwMH0j8ziBrXiRC+G+xqWMJs9oSg4WfWiZMfreAMuulm/099nkxn0TgpVcRW0J3/3qm+bsGbwOLhrvIVcBXU0wKUZ6paWE5lTqWUzeBVoIp/DHFV+oQ+HUok95kxhe5b1jqDnvsM7e4YYaWseI2h6GkK3A6U9CWgGIRp51o1VeoQCUDeGesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0P3ex7KmcIDwbkFSnZy6WlRQjDFvnrwpTL+BG4GvZE=;
 b=EFoHSXv308ZEKk6tP4xRDzzkQ0NeeoECNxkdRFlB+8+u8wdPLBcQkwZikILnFMsvZTPBs+zXbY4BM+sctg3zbaOn+FvkJPR+nnR2Pz6F7+V8lkU0ecZln1sytV8GzNXtlXIOJmikXp9F4F8fxzJToXES4yuikHIgPvl3bqPX6cwaRJrYN47ToZVNFAR/Ur7ucEbjNS2cqvT+ZPTyW+AcEoDtB8jginQc3fHeD1715qoCElKNQ+U1CbU3AhHnb4+lOCneofdEKWY//v8w7PaTBOh6DqbMJk44B94mWspwou+2pGibEmTndyHYJhYRfPCvbqmD5MOmJhWrNS94M/TlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0P3ex7KmcIDwbkFSnZy6WlRQjDFvnrwpTL+BG4GvZE=;
 b=Xh6lFwP1lhsA81vRKUY031rPDeLIwvssWA9jPNlrt7cNx2vD15hAditZegAY8pHG/FtZPHpV2Z9z7h3c9wHGHewMLa2euFfJa8LyOyhnVPRB5lcfa6RKVcPBCe02nqA3y2d8D46e9Iyyf9YZXeuBYrEASl6HqujwN2ol+Dj5tZqO20FULx7Tt4pIhiV5MjDP+alkLiVkZTxdLBatbLOdQKebtm89PWX0oSNo1p0rLeTQXyGmpysOW6XJTJ3YdNHuig2Q9GjuUz3smxxJAaJbxIQh1vcK9kbFsXAA0FSiITWi5zXBO6bFWDtBIiEeVgTF/4H/xCEX+BE75HHPXV5WRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 23:21:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 23:21:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 25 Apr 2026 08:37:05 +0800
Subject: [PATCH 13/13] imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-imx8m-of-upstream-v1-13-07527be92e5d@nxp.com>
References: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
In-Reply-To: <20260425-imx8m-of-upstream-v1-0-07527be92e5d@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm, u-boot@dh-electronics.com
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Ye Li <ye.li@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Angus Ainslie <angus@akkea.ca>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7876:EE_|GV4PR04MB11356:EE_|AM9PR04MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dcc988-a93c-4f0b-efca-08dea2583f89
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: Kq0hQHyipP4I8azA+3sXtaQlyNte6wVgOhXqmmZ3Fj6r2de/XGKwxFYbwOw6HGV7V0D3GXf31Hty1WK5aJXR1p39PKuZoo/IDUlgw5hYlEMHIThmNJsYtwpD2hri4BJrr5bS+wqK97woepQItR4RFu5as3gDcKhtKysxziU1ZOERsL37KIJVf1dWb/jv0DJPHpWdSBK762ZGc6pmGFZKu25fAfvxBFjvM39IlC1m7bwl4oGMPugR6LWZ80ptt+DxkfcBaSQWd+s95UeNZGUvAI4/Yi4kQMLqIkre62M86WMHHAUNPjVsTUMA3GMgAoiRq5sJh7lA2k5CZO0d6CBBWOCpxzBM3aWkD64hgXQfHGsFC0dfll9Kc6FZA/4ft1/fKl9jwtaj0eoLNEtC4R1+Ze1H9N3wujl9AkKegX888u5ssFa78NSX4y/Wz5grVBRtWHkTkKPnqMp83F/Xq54NNU4SyJ/6klIDL7Gft1AK9w0zGLv3jUkgWDEpMZH/s0CyiUgKECQEhOWVfNxT8LvpFcLQlhlsIg1uK+YKEJcJULN+FajsAWHoA4ud+/nTwfkSyNkmrlZ0loyltmYFJJ9y98eAKUQK15PGiHh8AWbTUwIsl4xeZRLbOK8os+B/cIUD+Sz6pXJD11pEN9d/n6KsvPeXaxyRFdncOqr+Vyb1A4fmEhIpQcN4+4y7DXfrIxYF1oQEih55Ql8Oz06GsMckTKVjFU+79/br3J1tPwj7giKtzCmvmaDhUcq/Fe16bRF2W8m9SAk94C1dwYcQjJm2WHaYQU42pdBEvqNr9oqGI50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em42T3dzVWZUeTBOUjVacjcyNDR2Z3lLbVl5aFUyQ0Z1UkFDeGdhTFJvYmJZ?=
 =?utf-8?B?anczaVgwVHhxcFVmWll4Y0VuVENEaVlsRG5xRDFBck9qM1h5akZDWHpjKzJz?=
 =?utf-8?B?UmdWUlphY3pDMkJDTExuRWVpQmJaUEU0amJDd0hZaG5vSFNWZjJ5Yy9xb3Zq?=
 =?utf-8?B?S296elpMc2lPcE9Kak5JeGJwdjQ0bHJWMUVCUDA0Y0NVcFZSeFB2VDN5SWFj?=
 =?utf-8?B?eVhqdytPNEFKRllvdExPMVBibXVWQS9KYk1RT3pyZ0oreEtob0JBbk5WZDhj?=
 =?utf-8?B?Ry9RSk5EeHRwc29HQnh4UmRVYTkyNy9sTjR5c3lHR295OExhZDM5YVJHRVFv?=
 =?utf-8?B?Q2F5bEtPM0ZCc0pqYVc1cmdJUWJaNnluSWdjZ002QS9sNWNRZlhUUHZjMkJu?=
 =?utf-8?B?dU4xUnlBajFXZUdkUmxlSlJwUjlSV3Zxa1VwRjlybkFrQ3MwMVh1LzZvTm1C?=
 =?utf-8?B?cXJaWDB4VGNMTmlhNXowRHIrZGtQYXUrZ3NTL2FrV3N3OUV4WFQ4Y0Fqa2Ri?=
 =?utf-8?B?dThYQmFTb01XSzZ4SGlNalUvT1ROVDNhU2Z2RmlGK0p4dHVEMDZUY2lLMW5Y?=
 =?utf-8?B?YVdkUzZjNUVhZDM0MklqZGdjeFpGZUwzL1k0T3E3enJUTlNFM1JBb3g5S2Ju?=
 =?utf-8?B?bXFGeEgwT3FqRlhXa01qWVpicFNsUFJQbTZVQ0NYbUI5N2dpcTVoWHp6TzYz?=
 =?utf-8?B?RVRtV3BEcTRjbzBzUTAxZm9FTEZpMFd1NTQwQkNZTnF0bDd0THl5YXFBSG8y?=
 =?utf-8?B?VDM2b1RKMkkxeVVJdExUOHVDRFFUQk1lNDc3L0crcm9oL2tFK3JhbGNVeWFo?=
 =?utf-8?B?anF6YkF1bndnOTNSMk1Zdjd0cFdVTHZsc1F3bXFQK0xDQlgxN0lFWVg1aHhU?=
 =?utf-8?B?czM3QmROSUtuZXg1Q3pSa0ZkczYxZGllWE9YcHhlWTlFdGVJeDllQzJGU3Rs?=
 =?utf-8?B?eVd2eXowd0tKYzNKLzZOR1F6TlRZSmVWTHBRbEJCMU4wWEtJMzVGS3lYNUx1?=
 =?utf-8?B?dmNtRmhORWJvZW1CUGVjTnlVREt5QU5ld1diVWluVnhmdWpCOGs5ZkpySGxs?=
 =?utf-8?B?NXV3ckVtamU1c0c5dlV3bUZ1UXZnSGJ6ckdZOEVBUU9NaGVJS1BMV3h6SUlt?=
 =?utf-8?B?Zi9TR2lUZkE3Y08zTFB3MVo5MlZPVUMyTmNTRGVaeVA3bGp0VmUxSXYyUC9y?=
 =?utf-8?B?SUkyL2thbllneE1mRHptRVJ4d2hZdGw5TmEyUlhVZ3VadzJCV2p5TlZHQlIr?=
 =?utf-8?B?d21qUGIyalRFbXpVMkxPeWkxRnQwcW9YNUFnRmkrVDRGUXpXbnp0OGpaREpk?=
 =?utf-8?B?VGxVMDhLSExpSVpUdVhWZ3pJVzRxZTRTWGtBSGFtcldydlZQUm1YeExndjhT?=
 =?utf-8?B?eStESGZrcVFyRkloNWpwNEZlVDZNYXo5YzBydW5sWEwzQ0k2QW9HcE4rdmky?=
 =?utf-8?B?bjRPNUN5d2E1L2E5bExmN2o3d25FRDBweUNBa0EwdjR0dnFIeENSK3RXVk9l?=
 =?utf-8?B?TTlZVVpadTFMR3B3bEJJdVVRN1lNMjk5SmI5LzBhUlBqRlV5bFk5RHRhWkpD?=
 =?utf-8?B?ZlpSaG9vRU02czRnSU10TFF4aVNkSHd4dU9RN3dLLzM0QUl3bnRYZGhIOGdQ?=
 =?utf-8?B?THJabnU4M1Jya2k1dHV2WlArejMwOG43ZG9uRWUwNkJ5bk44RHNzY01zYW1F?=
 =?utf-8?B?M3V2cFJCSHV0ZHc2STEwVmx1ZTE4UnBFWlNUNzIvZXpsWkE4aFNOZVhidUQx?=
 =?utf-8?B?QTlWTUpRcTZXNVluY2lNUUM4VmovQ3M1UG9vdkhCbjVHbjRaZklkR3Z2QU04?=
 =?utf-8?B?a2NwMTZFSUJxb1EzM25tWFpJVW5aUVlvZDNVcThWTlp3dHlvWHM4YlpITVRu?=
 =?utf-8?B?WmJzVkJURStybVJ4bTdxMmNyODNmSzRUUmhPbEg2dWtwVElVK24yNHM4ejJk?=
 =?utf-8?B?RFFkcnd4bTNPckZTa3p6dUg1UVF1MURCS1F1Y3QrQzR1aGdJRHV5NVN2OGda?=
 =?utf-8?B?cEg0UXNxVDBQZWp0b0hWS1BVT0JIcURlUUI3Q1lZeDZ6NW81UWxSZUlyMS9R?=
 =?utf-8?B?N211cGczZ1JHOEFJamRjMDZmTkR6WFRPY01waTI0bkE0WWxldEVNMHdqQW1w?=
 =?utf-8?B?TEdUL3NEbk1CNCtBZG5vZElmVmcvdXpMSkswSjltajdCSlpINEJUQldUMFli?=
 =?utf-8?B?ZklSTjFhenEyYUVpRDZseWQ5NUdrWVowY3J1c01WbGpyM1JzN3NESnU3Z0xN?=
 =?utf-8?B?MTZ4ZE1ISnNuajROUzBvUzMyZ0QxYWZFQkUxZHNrRjdLNGdkMmljZXlpOWZT?=
 =?utf-8?B?QlVyeStYT3RORGtjSEpJeEo1cnVZb0JlZzlYdDcrYS96aWp3YUhuZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dcc988-a93c-4f0b-efca-08dea2583f89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 23:21:44.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5Z3n7r/ObDHTovF+oty0uzQLHRWl12KiSa/q6L4ByOKYofu+taPyjpw6F3qy7NY+DiUUb1PClP+wakYfAVvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876
X-OriginatorOrg: oss.nxp.com
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

The U-Boot copy of the board device trees for this board is same as the
ones in dts/upstream, so switch to the board to OF_UPSTREAM, by dropping
the U-Boot copies and selecting OF_UPSTREAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts  | 175 ------------------------
 arch/arm/dts/imx8mp-icore-mx8mp.dtsi          | 186 --------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |   1 +
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig |   2 +-
 5 files changed, 2 insertions(+), 363 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d2ddf885c1a..07c995db027 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -880,7 +880,6 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-som-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
-	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts b/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts
deleted file mode 100644
index a02b31c42db..00000000000
--- a/arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts
+++ /dev/null
@@ -1,175 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/dts-v1/;
-
-#include "imx8mp.dtsi"
-#include "imx8mp-icore-mx8mp.dtsi"
-#include <dt-bindings/usb/pd.h>
-
-/ {
-	model = "Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit";
-	compatible = "engicam,icore-mx8mp-edimm2.2", "engicam,icore-mx8mp",
-		     "fsl,imx8mp";
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	reg_usb1_vbus: regulator-usb1 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usb1>;
-		regulator-max-microvolt = <5000000>;
-		regulator-min-microvolt = <5000000>;
-		regulator-name = "usb1_host_vbus";
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-max-microvolt = <3300000>;
-		regulator-min-microvolt = <3300000>;
-		regulator-name = "VSD_3V3";
-	};
-};
-
-/* Ethernet */
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-id";
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@7 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			micrel,led-mode = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-/* console */
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usb3_phy0 {
-	status = "okay";
-};
-
-&usb3_0 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb3_phy1 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-/* SDCARD */
-&usdhc2 {
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	pinctrl-names = "default" ;
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_eqos: eqosgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2
-			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90
-			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90
-			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90
-			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90
-			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90
-			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90
-			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x16
-			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x16
-			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x16
-			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x16
-			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
-			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07				0x10
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x40
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x40
-		>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX	0x140
-			MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX	0x140
-			MX8MP_IOMUXC_SD1_STROBE__UART3_DCE_CTS	0x140
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0
-			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
-			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
-			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
-			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12	0x1c4
-		>;
-	};
-
-	pinctrl_reg_usb1: regusb1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x10
-		>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mp-icore-mx8mp.dtsi b/arch/arm/dts/imx8mp-icore-mx8mp.dtsi
deleted file mode 100644
index a6319824ea2..00000000000
--- a/arch/arm/dts/imx8mp-icore-mx8mp.dtsi
+++ /dev/null
@@ -1,186 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright (c) 2018 NXP
- * Copyright (c) 2019 Engicam srl
- * Copyright (c) 2020 Amarula Solutions(India)
- */
-
-/ {
-	compatible = "engicam,icore-mx8mp", "fsl,imx8mp";
-};
-
-&A53_0 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_1 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_2 {
-	cpu-supply = <&buck2>;
-};
-
-&A53_3 {
-	cpu-supply = <&buck2>;
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	pca9450: pmic@25 {
-		compatible = "nxp,pca9450c";
-		interrupt-parent = <&gpio3>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pmic>;
-		reg = <0x25>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-min-microvolt = <720000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-name = "BUCK1";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2  {
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1025000>;
-				regulator-min-microvolt = <720000>;
-				regulator-name = "BUCK2";
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3600000>;
-				regulator-min-microvolt = <3000000>;
-				regulator-name = "BUCK4";
-			};
-
-			buck5: BUCK5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1950000>;
-				regulator-min-microvolt = <1650000>;
-				regulator-name = "BUCK5";
-			};
-
-			buck6: BUCK6 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1155000>;
-				regulator-min-microvolt = <1045000>;
-				regulator-name = "BUCK6";
-			};
-
-			ldo1: LDO1 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1950000>;
-				regulator-min-microvolt = <1650000>;
-				regulator-name = "LDO1";
-			};
-
-			ldo3: LDO3 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <1890000>;
-				regulator-min-microvolt = <1710000>;
-				regulator-name = "LDO3";
-			};
-
-			ldo5: LDO5 {
-				regulator-always-on;
-				regulator-boot-on;
-				regulator-max-microvolt = <3300000>;
-				regulator-min-microvolt = <1800000>;
-				regulator-name = "LDO5";
-			};
-		};
-	};
-};
-
-/* EMMC */
-&usdhc3 {
-	bus-width = <8>;
-	non-removable;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	  0x41
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
-		>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
-		>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
-			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
-			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
-			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
-			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
-			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
-			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
-			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
-			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
-			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
-			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
-		>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index d56fc7bf7f1..a97f2e621e5 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -267,6 +267,7 @@ config TARGET_IMX8MP_ICORE_MX8MP
 	select IMX8MP
 	select IMX8M_LPDDR4
 	select SUPPORT_SPL
+	imply OF_UPSTREAM
 	help
 	  i.Core MX8M Plus is an EDIMM SOM based on NXP i.MX8MP.
 
diff --git a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
index ee55d804980..21ba4b631da 100644
--- a/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
+++ b/configs/imx8mp-icore-mx8mp-edimm2.2_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-icore-mx8mp-edimm2.2"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-icore-mx8mp-edimm2.2"
 CONFIG_TARGET_IMX8MP_ICORE_MX8MP=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y

-- 
2.51.0

