Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67FD185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926EB8421E;
	Thu,  8 Jan 2026 14:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IzKX/nMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B3C083B87; Thu,  8 Jan 2026 10:53:27 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8701883A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKoqI0PjZQ5eOC/J2CPu95eBqorQVMFb687XroZSGfiECdh8z3HN7SkcLI/qT98hqS4dDcJ4NNH+lAmR+1NKFxaOReqFdreFf9IS8GIBG1MSoN/sRs32NLdIGJPtZRDJDPOVIx1bMhnaTx9NDn3YzWLFrXWbGB7Ms9QmlxHSvMtvx8+sPtZMjF5FnK0AZXUimm9v1WQkoCJslr/MHVToiR3EnjAa/1VATgm28grTcncwvqUgcZIqjbS8e6+qvtwbb9PSCHmK+XfMv7FOFcR0avCAp31l6wMXhdk+5E00R4hAHRpSetQAjItChmg37h3oENWowcD47xjZuP8lETQ+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Wz4RdcInvXjPrlBcGDeXS2NKp6T1KboslLBoanhpJk=;
 b=OmcV592eKiuFu7Ki8iD+0JdiKBaUJfm34UMg8Vt+Uk+/mcz9ojESki1tuPqw+WdN/z3ouAXjY+pD1wg4ZJvd1dk9IM/m9dCVFFUrYJXQkfBA9u1XTt9WXPmTyoiJs5sU6oRGOPyDMsH0WjqLzuEgKbXdMRJ/sXjp10mVVmCma+V8LcAjxmv/aFydIxn0GhA0aVK7DFQVQh78VchiNhVCQeRu0CBliSFzW0T7TvJ1C+0K3Rp/B7xy8GqT0W5z4J9B5YpSpdT6Stwt1FSiSDDJdVErrrYMC2pQTTADAvWNVjdmKoxcRnxd/60l490D+Ne75ATaLNEAg/5aCdlEG5samQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Wz4RdcInvXjPrlBcGDeXS2NKp6T1KboslLBoanhpJk=;
 b=IzKX/nMZP/q+Bn8iC/1Jax2uV5ga7pDmyqxfgYpxiJomM9ubD4i8CnAghkI2faK8iQ7qGVv/55+tCnrucKtNfyM0Y3qGcxGI6HlX3O2B7zR+BZ/lG4Lm3hK42qsow/0BZx0rxN6sMxTSSeOmdP2SoRCQYnb+xOZRaFfFCE70MFAdINSuWQEuEa9NYKsSoHtiffpFuafPKC32MjWZ2RJFRCc9D3ewm4Wi1KfYTVywwQLA/vvDJaW8tV4TAryto1bsahSys3txSzaKWcimm824v50S0FtJ/TLWAkPsdCd4xMjl/Z8IvbBf+DCdl6XLck8Zh8zvugrOw2uJi+KFxgwahA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:23 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:57 +0800
Subject: [PATCH 12/13] imx93_evk: Invoke the ELE voltage APIs when adjust
 VDD_SOC voltage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-12-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 38de63ee-6f38-4a91-6223-08de4e9bc2fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzhvV0x4SEduSjdtdHJIckY0YWJMUEFPOFNhaS9OYTM5UEJ1ejRNTTAranZJ?=
 =?utf-8?B?R2tEVFdzZ0d2VTg5eE8xVDZwa3cxOTI2QWNkbXhTajZnZzF2SFQ5V1pTWXJH?=
 =?utf-8?B?b3QyUnlaY1YzL3gwbVdFTGVtOGVNbWZoWEYvelhhVVZFRXFqOXl4TGpJeU5K?=
 =?utf-8?B?eHZyUFFLUE5jTmlKeWEzOU5yRWFBS05JaXlGZHJaTkJ3a2U4aXZHZE11aDBH?=
 =?utf-8?B?WUEwV3NBWW5oR2VrUWNZbG55QjVPUk9SWWxqbFcyN2xJSUUzc25oNXpxdjIr?=
 =?utf-8?B?aGJUT2ZwSzVWenBzTSs1Q0NDaE9jNDNpNDRZdGRHcWF5MGF6YTN4VG8ybjdp?=
 =?utf-8?B?UFM5K0htV2Fucmw0U0tCcDRBTkIyaGIzWDhLTFNWdmd4QzI1aFUrallPVGZz?=
 =?utf-8?B?R09SUHhCdnpmSmxrODFBdUtabVV5b1I0dDlURHd5UkpUMlFOMnBJdVBXczRG?=
 =?utf-8?B?WG9RL0RrcDhPQmxyd2sxZ3IzK242RjBDamdDdjRNb0QvbzBtVDBSWUxJWkdD?=
 =?utf-8?B?dit0TmpFNDNnQ2syb0NWRGtNOHJ5UnEzMnI5dldFU3NuSnNBZWJGbzJiUy8x?=
 =?utf-8?B?MlA5UWFWaXZESTNGSUtudmNiVDJuakVHZG1mYVc4R21qZVg1b2dBNzJzUDRi?=
 =?utf-8?B?Q0hvZGpjMzFsWXNham1iTGJQZVZhTThLbVZuOXBmNlRDUlZEdjN6RW9qNzRH?=
 =?utf-8?B?eU5zMDlIV0pFRGN0R1JDVUVDZ1hFZTRmUTNWT3ZockNSWnlYTVJ6alVyOXV1?=
 =?utf-8?B?YVdpWWFoKzIxMnpyMmt2NnZDd1h3bUk3cnByc3ZjOHRkelNMQWkxYjZrUXNt?=
 =?utf-8?B?L1dZbkh6d3J6WXNTUFZZaXFKVnpib0crZmwvRUVMQ3MvS25BdFlNUEg2a1hF?=
 =?utf-8?B?Z1JCcWF1Skh0akpPSWhzY2hCVWlpU3BJb01BWEllNTVySXNmdTdNQnBQRTRD?=
 =?utf-8?B?L0I0ZUVBUnZyeUdDQzlWRUpmbERHckFYRU1tTlMvTSt1bmpzeHdsdlFWcDBr?=
 =?utf-8?B?MlR4bWdvejVaV2hlNDUvVVhjcWh0enUxa3pzOWNHQS9qQjJiWXVWUk9uL3ZQ?=
 =?utf-8?B?T3hrWXVzLzh3NUxISkxXZ3RBVkNMR0Rhd2dBUnExY2FRb1NpL2g2RnNyMERn?=
 =?utf-8?B?OUNTM1czMFUwQTEyYk43a3dsaEJOeXVySUpkWVBTRXFaLzVCRWhSK2hrRkp5?=
 =?utf-8?B?M0xxR3pEOVNhRVo4Y0ROTU1uZTFjY3dXWlZSVEZIZVhzcG5SWmpuS0hDcXFk?=
 =?utf-8?B?MDhhUTBzdnRLNlFxQmI2alRJU0xra01CS3Z0SGUzMzBCa0JxamlZSVNzUWlx?=
 =?utf-8?B?cHhKKzFvdFZXdmJzbWN2OHc4WlJqNlk0SE9hT3RBNTU5bWhEVDdjWEJ4NVZr?=
 =?utf-8?B?YnRLSVNhRjcxR1haRE1VSmRGSUVrYVg5ZTVvR01NSTFzRDZBdHE0ZTdPUzE1?=
 =?utf-8?B?Q3V6b3R3Yjk4NGYwV0hQZllwbEFuWll5cFl2ZmltVDd3cFNML201V2l1YjFN?=
 =?utf-8?B?emFXU3M2eWxsU2NUdU9iNDFuUFVKMk90ejJ5MEUyMDJRU3I4SE5GWEFSTzhH?=
 =?utf-8?B?a0VHREZhRFhrOHNodFppdy9qQjdlUG1EeGVnT3U3OXlUeHB0S2drc0RPTk9C?=
 =?utf-8?B?UFdhQkhCYkszQ0s1dTlrdUJLNzRlTjEyQjhtOVdQODhRcStVNElmc2JxRWhl?=
 =?utf-8?B?OUthRG9jTjkwTlp4azdXaVYrVjJUSjhHWjJzMDFiUjAwWlphMFU0N2wyTUtx?=
 =?utf-8?B?UmJHWmQyRnZ0Z2Z4RWtJOXIvdUZnTGVMbzdsNTM5NGMxdEdXMXg4Mnd0T2k5?=
 =?utf-8?B?YmhGYSt2OHU2d3FVcU9NT0RPQ1B3QUdkbjhHUE1nWGRYWWhIRStXUG5ad1Vx?=
 =?utf-8?B?ZnN6Q2tjMXBPRGRWbFluZzNZWVU3cVV5TzduWGRZeFkrSVhOR0ZKUGtYQWw5?=
 =?utf-8?B?UzBaYWhQYm4vZm1Id0d4c3VhN3J1OERZMGY2WEZQRTVxUnBkeWVLWUNWckRR?=
 =?utf-8?B?VXhPbThidllrMWVVT280K3k5L1BMbGlGY3ZucDhEcklSNTlqSHNDOFhXWWls?=
 =?utf-8?Q?Ikvd5X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJDU3A1L3ZwZlYvQ2RNd3ViSE5kSUkycC8zblJmOU1wZC9MT0pyb1dtekEv?=
 =?utf-8?B?Mk44aEg5TnY2bTdFcWVYN2hpRmx3ZkRScjdhTm11N2EyQ0duLzZzNEFSa0wz?=
 =?utf-8?B?VXZSdTdtNGYyWkp3STRqMklHUW9wVnJXOVV5WnV0TnErMWhjTU5yVkZKb1pX?=
 =?utf-8?B?T1ZrTklQV3JXYmljdHdQeEFzdHlDY0h1TFpaYzBMUHo1YzE5Szg1NHlvL08x?=
 =?utf-8?B?RjM4cVA4VHFYSnJEY1NaQkgvVWJFYWZYd1NyQTQ1dG82L0RIanFtSFV5TmpG?=
 =?utf-8?B?VU1VYU1sYXNqWjNzL3VrbjV2eEtQRzNET09HN0tzM204Vm9aVEtkMUlNUjR2?=
 =?utf-8?B?UHI1cHkwRStBWG5ReVFRSjVmcHBsMllqYVl0aVhWSktzaGUxbFBTZGJNamlI?=
 =?utf-8?B?WGZOVUFXR28xWG5BUUs1ZXpJMFRIQm1vWmVvOU9NcklocHlhUFhlWGZac1M4?=
 =?utf-8?B?ZVpUendpTGJmWUxkZnNmd0EwaFlOS005SmkyRTBmTmVnL3pGdVJVQlo0U0Ru?=
 =?utf-8?B?RUpTYXI0ZXRoOTQwSmZaOHNQUER1MFRCaks3Y3B2MW5rc3FvdklaUnA5b09j?=
 =?utf-8?B?VDZKTTNJLzBFNUNibmUvdkdpbUpLNnNDbzJvZkkxdmRta1g4bVJsblVLWnZG?=
 =?utf-8?B?SzQvZE1pMXhuVk1FS25YY1l2ZVpCeDRYOTVtMXNLUE9FWFFyN2dPT09YaWZI?=
 =?utf-8?B?VVkxWEpnNCtScVJBSW9FL2J2Q2FZMDlmRlpaYVVPUkxDN0RCa05OT0dIYWs1?=
 =?utf-8?B?VWdRL3hvdFFvRHBIdHBDTEs1cnZVUVJxNnQ1SHJSWXdaeGI0UUc5cTByYlFn?=
 =?utf-8?B?UU1zZU5USDI1bVJWV0VWVGRrN1dnVEtyYlk4bDFFTWZmUDN5QVNEQjNhLzZW?=
 =?utf-8?B?eUYyNmhEbXkwK1Z1Z3pnc1dtcUUvRlMrU3FBaGlyUml4blZWeHJzeHBuYVFi?=
 =?utf-8?B?dE5CRGZadDljam5qVEZMRGdJaTB1NzFNbGpkVHVlb0JhT29HclpiM091NVUy?=
 =?utf-8?B?TGhKeTJzT2xkNlk5QkpYbmxqTHcyNGhFQ3ZxeG5zM0cwcGovTllQMVgrU0Nz?=
 =?utf-8?B?OGcrWXNHS3M5UjV5Y3B2ZjlqQ013WHVucXI5N1l2YTI2c21CN1lpd2tBUDV3?=
 =?utf-8?B?OXhUMXhCSjZOSDRZWENkL1NvWU9CWjExVFRaekRtVU5HbFNXRDMyMXlPKzc2?=
 =?utf-8?B?U3VIcFYrTm14M2JSaWNsSTUyV1RwMjhwa1ZnZnowaFJwa1hQYVJvbU1iRStP?=
 =?utf-8?B?MFdvTUdIaWs2TFdMQTRFZGRmRnFiZzZUWDZacWhPM1hEbE1qTWU2ZEN3ajU1?=
 =?utf-8?B?aU9ZZGtUNTNNRTl3RUVjclhSWCtvSzJKek45UnBRQStkNkprZEhZN3ExZWxp?=
 =?utf-8?B?ZStrVVpscFl2WlhqaUhaLzFWT2lhU0pSemcyejBUcHdVa0tmQ1ljdi81SCs2?=
 =?utf-8?B?L1RpTjZqSmptQVNvWjZGbFp5TFg2S0NOcTRDMHFlRTdGaE91LytiUXp5UU9B?=
 =?utf-8?B?bmZVcmpoY3RyQUtRYUxkMEkyUXlwNk9GVDhMUHp2QStONGpMRmk2NjQrSSs2?=
 =?utf-8?B?Vlprd0FmM1Nhc3JQNCtXUVZsVmZtZ3p2QXdQT3UrMWpZQ3B4VFJBQ1M2dkE1?=
 =?utf-8?B?eVl2T051bHlXa1Y4cDRaazRPMzhZWjE2L3FRemRDNnZhenNuZWIwdEVvOFZY?=
 =?utf-8?B?WWJ2SE9ybEtPY0VXSjYyQmtVczU2UU11UkFJdThsRGtMOERxd0dzc1gydFdE?=
 =?utf-8?B?V2NCOEVSQVNoakRSS05iOGljelFQaHJabnY5LzJROGJIT0Z1YlY4cVV4QXBM?=
 =?utf-8?B?Y2F0YWdLOUF1WGhiRmUvTGh3STNndTVHRW91ejFVOWtySUhlWjNleEUxQVIz?=
 =?utf-8?B?Uk9MOHJqTnVTdWdUQUFmZktncnhKUWJpY0gwNWdEZkcvdXdqMFB3Y3VGRTNE?=
 =?utf-8?B?eXIxZlRWYk0vM0dCV1dLbzc5aUw0VzFpd0I3Mit3WXZ4S0ZrcGhJYW50aW0x?=
 =?utf-8?B?YUdrSjBxbTNzQVA2dUF2ZFRjODlMU0RLdC9Kanh6MHppSThMQkFCM2FFNFB4?=
 =?utf-8?B?M0kwby9iN3FuYjZyNWVzZ3pLYnFnVHkySlRiT28ybE5OQ2loWkpQN2RHYVBO?=
 =?utf-8?B?VXhKZEJhVElwbVo0WHlHV2pWejEwRzdTQ2V3b0pSdyt2M2tGRGhnS3ZQTVlH?=
 =?utf-8?B?TnpISE56YThJQW1DV3ZJK2dSQWZ4ZG5VemlreEZMblU3dTVBWTRJMXJGQ3pJ?=
 =?utf-8?B?aURmY0UzK1hZM3k1Nm9lS1pHZ1RNYVNDaUx3NTIyc0VWTFdIODJPRUxHV1hQ?=
 =?utf-8?B?K1RRaFVGeGpXclNJWDUzTWZYRlVWV2Zac2xMVW9xUkV2cEdTVjZIQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38de63ee-6f38-4a91-6223-08de4e9bc2fb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:23.5695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4zjDp8P4bzZrsZxwv8VfGXv5rDakzEphyHDse/WfVUWUvgtl69zcUg8IlBytpd7uvqzGX7wecqA/Ek6JTgD1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

SPL will adjust VDD_SOC to OD voltage, because some PMIC uses
0.8V as default for VDD_SOC. So need to call the voltage change
APIs to avoid ELE Glitch Detection triggered reset.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2e4de10fdd5..176d25a74a6 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -85,6 +85,8 @@ int power_init_board(void)
 		printf("PMIC: Over Drive Voltage Mode\n");
 	}
 
+	ele_volt_change_start_req();
+
 	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
 		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
@@ -93,6 +95,8 @@ int power_init_board(void)
 		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
 	}
 
+	ele_volt_change_finish_req();
+
 	/* set standby voltage to 0.65v */
 	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);

-- 
2.51.0

