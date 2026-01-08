Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC667D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E2A841CF;
	Thu,  8 Jan 2026 14:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tSKea6iK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7665840A9; Thu,  8 Jan 2026 10:52:56 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEF783A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWNq+MjKGRSzHJ4bY7pAsgOLYvUM2Rosddh5wx7r4z+0OU+e+YMIJfxNpKwsR6HEaWgprByiw2dZIJcDpyG6T05gjrlz5We1rPAkx4Ndn+hgrh9Vtbtu+UQy6gjq5mu7gPfjgHNsZgeD/BBRZmr4KBT1FeYi2xCrOIDtPl68AmrwW+XJuCRkmtapwnEbGKfycZ71+ZBgKOKs2BEpTQZCIGLJBkdTPuNE5jgVCyhvtVEyUUa+lfJ+AAvmLbQKh0q2OjwQ6XfTHZjmCCxnnxfO5/nro5pPWq/qDAqOGtK0P8p65zRZWps7rs6hKRiXaEvlxlBDVaNtGg2LY4xCzqjfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfjVATy9DkyPwKv5gmbpvhAkx2Tsc4a3mWze4mUCS18=;
 b=w7FqJMF3LdHYd6Ova9lq02klEADWmJBCbCfdoTl+dK97fb1HBiCivQfivbi9bGOs8QFJDMb8F+WPKfg1PwY8OlRoENlAVStjMX4VvvzIzNNqaP4hc29ifOzQZqdm54yYB/xODdIks1hNDL48c4ILcV8idpUGtaG4lsefV85TIl3iJGyLwLlviuvb7QvNtn/fNHC55iO5tCvNQnimkfcjc9hCbnsZCVolm+/LoIOfWreTVFxlQPLRidmYNBrnTx//v1EqDfsUEZ169jO+HKlMDHTHD1+pg6G4pMpxKs+f7bosZgjW4UCN+kf7LJFGV0hGpgQWNymUjwgHNHAD1D7xLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfjVATy9DkyPwKv5gmbpvhAkx2Tsc4a3mWze4mUCS18=;
 b=tSKea6iKblNGpX0X52WA+cfY4EOS7AAOwZg+wD9zSiLOZbmxEYdO9DG5bySpv4mpFTgF0TVCL0+Zt0Iz4vqIzVLJ8pd7P0QVr4NrSGow9guj4k5I1ZYXSOYTYh/gKXge0d4ncuHYUvTsOa+gDbdOXYflZuOCvMVxe2FI1zlQzEi2J6xVCcR/UitoLKMfJ2YVadirhTN8ATkpQCeSmbdAPc2/hAOQ2ZVa5cRSt7EaVsUML8WmazSK/PI/gvw8XmTMyqhqy0VHu/dofUqM4trF8efgXyQRZ2W7eli3beWU8I9uK1MdSJTDGLI0tRkKJlU54+YStolGSa87ziDOrjiVYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:52:53 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:52:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:48 +0800
Subject: [PATCH 03/13] imx93_evk: Drop board_phy_config
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-3-0d5921c575bb@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ab092b-9422-4e77-e8c1-08de4e9bb0fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTVnYUlxNXpBVkJzelRqVkV2Z3ZPMlByWGlPZW55NCs2Y0RFZmNYSHJCZGVJ?=
 =?utf-8?B?YVMybUdqUTExS2dvdlVwS1VoWjdJTWF5Y1NiUXQ1SmlVdnZRRXlkN3FvZ242?=
 =?utf-8?B?S1pMa0Y2WnRmeHYwcVljNmVKeVV1MGlSbkpFSldXQTlDNXVsci9tMDFJRVFM?=
 =?utf-8?B?SzFlOFluVk5Xb2xVUjA4MnVFOTcxbXZyTUtPTWZpUzd3STI0NGdCTVppeXUv?=
 =?utf-8?B?ODRZNzZsaEVHVUg2V1I1S0J1WWp2Y0lMdFplZGNxdlVLTGFCTXBuV29rczh6?=
 =?utf-8?B?RzFadW93S0w3S1BpR3ZzUmpld1B4eld5NGRCczV3TzlMUGh6eTdDckNnTUVw?=
 =?utf-8?B?MmNWd2lRVldvTkdTbGNUa2ZvUWxhTjZHUnNMNlIraS8zV1FOOWJYK3U4b1Vp?=
 =?utf-8?B?RzB3ZVVxbXRzdEt4c1ZnQ2dCOFBPVndRcDVuakRTck0rdVptR3Avc1ZuVjBV?=
 =?utf-8?B?UmVVUHZiaGc3ZGYxMTBZQU0zbUpaYTdXMFdxTnEzcDZWL0xmNVN1Sjg4TTZj?=
 =?utf-8?B?K2pubW1hb1NRRnRKcWlVdllGMmFrZ0Ezb2NvdmJjcGt1Vk5SNE9sTC9ISmt4?=
 =?utf-8?B?UVJXSTV3NVZwMjllNkIrVkRFS2pTaVpGZXFqRUdvNnVJZStZWklxbk9HbGRs?=
 =?utf-8?B?SmNJak1Vb0RieEVIanRpc0tYejFpbnpJU05nNitQK3JMRGZJUit6Q01mcFVG?=
 =?utf-8?B?cm5CNG14OFh1VEh3eG5xM3JYNXFsNVo3ak1KMHZwNy9OMG9wMHFpUzU0ejdn?=
 =?utf-8?B?T0dka2dleWgxelAwQ2pQNHNGYThRbzRKT3NrOWFkS0xWOHdEUWZJVkxpSldm?=
 =?utf-8?B?MG5CMy9rWmFGbXdQQVhUOEFtNGdmcjB3ZzcwSjhWajBxQjRQSkZrVTBTcHQr?=
 =?utf-8?B?alR2dTloNThmdGgwUW1aYi9mNDdaRERKZ0l2VzdXekdRUVB2ei9DaHp6UTBw?=
 =?utf-8?B?SzdmY1U3S25TNUpNM2pad3VDS09yaFZWWjB0emVFbXhWWlJrSDFXbzJqMDgx?=
 =?utf-8?B?bVFnOHU3aGwzd1drYzNCZWxmTWhWZVVOckt5WVhqM2V2QnNkdmFhYS9lamYv?=
 =?utf-8?B?NWdWTmFaLzM3Wm5EbWI5NzVYSi92Z2g1cUZ6NmFZSTh5UDRHVzFnTVczdFZ0?=
 =?utf-8?B?ODVzNm5yVG9nVjA3WVkyRUtEeDNGNUZlQ29la2VmOGQ5b1BZVFNFcnY0OUxK?=
 =?utf-8?B?ZVZPeCtsKzZnM08wYng2amI3c2ZFSkFvblFEcHZaa0JhSjNrMGc5QU8wN1dG?=
 =?utf-8?B?T2JpT0M1QTlySFY1cDArOUI1QzVvVjZLNjh0RFlBaGNHanJQSXRwbTdtZEZv?=
 =?utf-8?B?dVRodXQ5QUpGRlo2Q3hLYkxuWDVPVXdIWXlreDhsa08wU3JYT1loNFRtUWdB?=
 =?utf-8?B?cHZRRDRYSXJlV3MxVkhNU1MwbGZsVnM4aFpYalhjV0IyKzA3U1lBdnQ4blYz?=
 =?utf-8?B?dVdYMWxnSlR4eDFEQVh0TExERW5UemZPNE0vSDlwemM3dGUvaExLOU5kV3Fs?=
 =?utf-8?B?d2ZpYjdFSnRnWVVVVTk0VlN5RkxMUG04c3hWbTNqUWdZUDc2clRuWVFQc3Bl?=
 =?utf-8?B?S2hHcnZGMFpBeFd2WEJpT21iVjdIQnFtdjZ1VXFyZlRNY2dYakM4NFM0U0wx?=
 =?utf-8?B?SWJRcXc2VitnSlozazV3YWJzaVN4eldQbGhTaEVFdXBWdjRkd1NLN0Jtazd4?=
 =?utf-8?B?V2ppS1hNc00rZmxNYkFLRGxrbUNMQjVnbERRMWhuZzFDbjR2UXZXZ0htbnN2?=
 =?utf-8?B?SkMvTWhnUEdsMU9QUXd4M0RpWlc5U1djYlNnTHhkMEVZeExYU2hLS2pLSENL?=
 =?utf-8?B?dEg4WTFORXVkdmhIOWJ4NWh4Q3RJYjBZaVhmQ1RJN2lHbHVpU0ZrTi80Mkhy?=
 =?utf-8?B?eDg1dnF0TkUzZjJuV3J1RTdEeTJSOUxRYlRBbmZBV3RVV3dwaFdhekI2UzF2?=
 =?utf-8?B?STdtZG9FckhwdlFXVmIzUm5TT09VZGNZWlJ5cWNuQU96UHFEYXNzSHpHdW1J?=
 =?utf-8?B?blM0ZklGZ0NBdFVpc1l5TE1CeHoxTjRnWGxBM0hMYjNHM2lWRHJLNEtiSjdr?=
 =?utf-8?Q?nhKI7D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhxRTdPYnhuaXFxTUdNQ25GZlhNbkFXMVoxTkNJaG1YOVQvclZkMTVraTRv?=
 =?utf-8?B?TnNLMlVtYXQwU1V2bzl5ZFFQUVc4TXRSN040MEVZSXRLODB1eXdIbGVZTjRR?=
 =?utf-8?B?M1hnUnpGNUdWWHJiQlpuV05SYWJ1dk55QTNZV0hkeElpd3RIeVpFRXNFdzVR?=
 =?utf-8?B?V0o5VFVVa1ZJeGp4OUFJcUxrMzVCSzEwK0JTR1M5ZUdFRzNnanJNN2xqSWlw?=
 =?utf-8?B?bFBvVzl0bEJwWExQa3JRMHRYTDVpQ00wQktFdDNCZHBuM0FTZ1hjNE9kTlBa?=
 =?utf-8?B?eW80V0tudGFmVjl4SU1qTkc2U3dzVlc2Y09oSDVZVjBZT3d0blpISlN0TFZO?=
 =?utf-8?B?Rm1YazRvRWkxeHBiWk1XcndpbnRnU1FBWjZJc3pHRUdraUd1WnNDSTdzUFR2?=
 =?utf-8?B?c21Fc29NZG1NOXNyQi9lTHM3M1MwZnhRRjJKTDFsb1JFYTBXeTk0VFVSMjgr?=
 =?utf-8?B?TmFvbnF4THJYeWtMaUNOYUh3amx4YWhrSHY5NzdVeTdFTG1heGE0WjdXbWZv?=
 =?utf-8?B?QVhNU1BsbHNoc2JodWw0VVMva25tTEdwdTlXemQxelVnZjVMUHNKRTZJbHYv?=
 =?utf-8?B?Y25yRHo5VTFvZFlXaVNnWVNvR0c3anh4dUlCcUVhZzlkUllzVHRtT0pSaVNW?=
 =?utf-8?B?VVptc1NTbVhxTFY1WE8raXNxUDM4ak0zRktsaHNCUHpaT1BwUFJaeGlCaHR6?=
 =?utf-8?B?dUgwUTR2ZStuaTVwSTVoRlhabURlbHMrZHo4akFUR09rRmNmNzZlVWkwendw?=
 =?utf-8?B?ZlZyc2ZMYU9PTU9Nd2h3dFdiWU44S1lNRnZ6MlZwdFFkMDFsU015M0Vhalp0?=
 =?utf-8?B?VnFvRTNONUNVZGtVSjhNbmZPZmhzMFVkckQ3cGJrSm5Qbytob3dtMExzK3kv?=
 =?utf-8?B?S2djZ1VuTTM2S1pFUzRLV1lmUGJXaERyY3p2eGpUNEZpUXlaMldvM2NTcEp5?=
 =?utf-8?B?Qk1BYXZ5dUdLUnRwUUJ3a3ZOZU11NWg3Uzgza3BSR2RtZUJOOGxQbURMMGNC?=
 =?utf-8?B?b2cyeVF3emN4K3ZsL3BtUWk3MjNmSnVqdkkvSUhtUVplSERXaldRRVVSNmFp?=
 =?utf-8?B?aytMc05oQWxuNmprVUZqaWRHREtRSFNiOHhxbVhYckZaaTUxU2dVVTBOa0Qy?=
 =?utf-8?B?cTJUVk1KbURGbVM4ZTZxVFd5QWNPVUlveG1BOFFlRE5BS2VpVFc0UUJQT3FJ?=
 =?utf-8?B?N2dZODFFQTRjdjRGUmtVNHlxR2NEVVE0bXBOd2FVQVFiT29lUmIxM2I1RVo1?=
 =?utf-8?B?a1NXWkdpMmgwU3Y1aE5JSG1NOXhaN3IwUXFPWk5Hc256TkxKb0NrMysxQmNa?=
 =?utf-8?B?ZjdQaEF1eDFWcVRjcEhrMi9pNUZRZ2hGM2QwWWNLOVBKU2xhRFg4Z1BEU2ZZ?=
 =?utf-8?B?WE10UnVDMXdnSW1ZaFIrZ1IybnhNR0JkMTRHMW4wUk10ZG13bWJrckV4NUNQ?=
 =?utf-8?B?aTdJWlVsVkhvWkpUVUpGUm1jZ2lvMVdBVGw5T1JLNVFIRllIM1o5T200VVdR?=
 =?utf-8?B?VDZJRjJ3NE5CM1dCaUpTWEZoSEhPMXlrWEp1UTRobmlrWlQ5RHFPZDJrK1ZH?=
 =?utf-8?B?a3VmL1duY1pVMm5Nck4vUWZuc0p0dFNmUG1TSUREaWFPYVFUdHRLalpQc1NX?=
 =?utf-8?B?cW5PdHZsS1VRR240YmZUc05jSm5XN3Q5ajZBdFZTNkErQTlNclRyamd1MnI3?=
 =?utf-8?B?WVFwMFUvb0FObzV3S29mSmczWGFSWUZvSWZQYnhOT25zdjByNW53MGJ5UG9N?=
 =?utf-8?B?NXhrWGIybGpSTkkwSEZ5TklwVzRkOGdmSmp4U1V0UjJ3MjVMTjdqSTUyODNC?=
 =?utf-8?B?T0txMThtMFlvVW00blBpcysyZFkxOUJyVTZEbTh3K01IeXdPQ3hJNjR4WkZB?=
 =?utf-8?B?bk9SeW5nUkZITWp4RHEzM21zTmROUUxCNFhudlNRUjRnbGZjRS9DWktJQ05B?=
 =?utf-8?B?SEVlMlgvTmtYOENqbEtyaHhkZWRPbFE4SzIzdzhLZU5RVVp1cVdKTUxLS3lZ?=
 =?utf-8?B?QzhKcUg2UVh5TW5YblFFcWFDREFhMzBaTW9OQW1KOWdmS0ZIN01aU1F1Uis0?=
 =?utf-8?B?QU9hY0xZVkt2TTR0d3EyNVk5Qmt3RWpmWndIamxHR2llVkRTUFV6N21YSCtU?=
 =?utf-8?B?T1IrcmdhcEdTMHRWY3pOOThzeWhITWJYUWZJZnlqRzhoZnNrNjBJdGFMbW1G?=
 =?utf-8?B?V0ZvdytDanF4YkpkVW8rNDhnVG9BY2RoYjRBbiszb0NueEFKaHc3U2Z1TlFW?=
 =?utf-8?B?R0tGYVhTVWpKYkI4Rk1EeE5RTWFTeHNBbDg3SXpJMThIOHdzVHJNK0ViTzFB?=
 =?utf-8?B?UC9IUkwxZnJpV1NackZTeGNtZHphbHVWT0RHZ3R3ZkRoR2hXMXZDUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ab092b-9422-4e77-e8c1-08de4e9bb0fd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:52:53.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJP2R8LInIjCcP9ittAWxWhfHlfzsnHGoU1zYHLMmfUkwqMhiMW1RaEWBg0INYJ6dWCyt5JwIpPJVztRWNyLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
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

There is already a weak function in drivers/net/phy/phy.c, which
does the same thing. So drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 64400b584d1..4c58272523a 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -6,8 +6,6 @@
 #include <env.h>
 #include <efi_loader.h>
 #include <init.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
@@ -35,14 +33,6 @@ struct efi_capsule_update_info update_info = {
 };
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-int board_phy_config(struct phy_device *phydev)
-{
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-
-	return 0;
-}
-
 int board_late_init(void)
 {
 #if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)

-- 
2.51.0

