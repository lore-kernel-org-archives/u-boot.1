Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455FCC369A6
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4EF83E16;
	Fri, 11 Apr 2025 04:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UxFk+y6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A5E83DAE; Fri, 11 Apr 2025 04:46:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FCA830E4
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkQxvfsKq6RMt1cb9Xmj6OF8gZLYCRChazN5VBy6wBw+GzvPKfxZVE+S4rBEegtWn4vQmVolRG9bBOZmnhE07+pT+D1r2Qi76e4KoTgtDjn+y3vrDLu/x/NYrdx6Ols30lc0N5vzs0DlT0xo9UzlHWUZYMKcDQT2g9ZiYHlyynA70a1jVNVKYPuUZ4CSeALLoxTUJ9yKedsPpjwTZyy3w2nD8qD9E66vcivBHyeep6jNjsHynGASJ2vAwNL0W5OwCrj5i4hrdWsOIHCLCYIxgnBTXFJlhUHznKsNnx7Z4Clly1Rwl5vUwEUROiGnt7TvyyMqKxMDYVu1jUtEWGFU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO1BiMFJjZP77wpixo5UaqMM7oE5DmndX+h6YSN69MY=;
 b=SISKTriNulI42Z+3ENC4XkBaAL9aCpu71fjb2eTs8dw9aIJwq7kJOgc56NGH8vVVSIS0GneSSpodk1SJQMEE6d/ckM+cFX+1VGGOKNZdi6w7FG50tSAJk6Et6U32B0J47VGHemUwzCb+DaGKmH6fccThYLwHJD77aWuNlChSK98Wkpmtm2ZLFPkGlYUmihtYGpPSdOQ8KIEU303qYukbsiUtIOZ0Ger4rINRxNFCzt0zxOMOrNiiU2UZ0b94PweoMVsOZzD8pIMB15GkzWmFPjyFCjmBks4/EcpX9ra4BwBGJTEJza4S8PDtYZ/jC/Vo9kJNTXDfgZ/L+oP83EPUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO1BiMFJjZP77wpixo5UaqMM7oE5DmndX+h6YSN69MY=;
 b=UxFk+y6OnkKnDNY1Kfr4Px4yFyGp9TCcp4ZPrQ7KzVS2ot6xzV3MbwrtmqrQu01ruujCLLSymxp5EV+SP6wGglF+Z53577T9iMyinZHi1SwI8bFKl5oqLU2ROlKykPMszoyxs1RDDmgqTvfJmESbYXMsGB5PflJQuVRXLI4rEC91Qjnat1eXqEeyQwj0ksqbq0phSDweQcWquo2nTnrQATIaE3mCBcWowvd5RlPZiMe1KxR/F14HXgmzvd1pU1083K6mH6NRopYibPGrw2HoqgvG5fLw8bowWft4HinXsipIrimUEvidRUiI3XpH4c+7SQbjI9w8NR6A9TYOQ5Xnaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, festevam@gmail.com, sbabic@denx.de,
 jh80.chung@samsung.com, trini@konsulko.com,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, pbrobinson@gmail.com,
 Faqiang Zhu <faqiang.zhu@nxp.com>
Subject: Re: [PATCH] mmc: Optimize eMMC erase speed
Date: Fri, 11 Apr 2025 11:54:19 +0800
Message-Id: <174434362344.24440.8702258988346386113.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250120043009.30097-1-peng.fan@oss.nxp.com>
References: <20250120043009.30097-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 127e80ed-43eb-4fbf-365d-08dd78a30a07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFJPNmFTMUNyRklSZG1nSGtKV2NZUFQxdmJhVjFTNm1VaWRxdUYxemFpdGZY?=
 =?utf-8?B?SGM3MytMNkozYXNJbStJcFQyY3BWYko4MHVXSlB4ZngvRFF1WjZwR09zcUJN?=
 =?utf-8?B?LzV3dG55K0xiUWowZXBQSGRLUlBpdkNoRW4wZzgrdjVmSHEzK0V6eitpNExr?=
 =?utf-8?B?OWtTcE8yY3JOOWswMWpDV1VCMEZHWmtwSEVZMlE5cnE4U1NFTjdRaUtEQ24y?=
 =?utf-8?B?M1hkNUZoaE5DWWtZemtjV0JGUVZvT3JaaG5kUjUwVGM0R0NldmZWZnB0OGlk?=
 =?utf-8?B?bERCYnBiY3g3cUk3dzlaWmZpRy9UZngveTN4cnRBdzA1QlM5VWNmckxERWRj?=
 =?utf-8?B?WE5DSVMyZWtBU3hYVkNQVXkvVVRhc1JGd0RiWi92M2VNb3V0M1J6ZnpYZ2RM?=
 =?utf-8?B?R2hSWWZka3hDc1d5VTRSeTk3clA1eHM4REZyS2NHUXhNaVIzc20yTnVtWUlZ?=
 =?utf-8?B?WWw2S3duSlNwVUJwbVNjZnVtVWJtRE5vVmk5VEliZStxNVMwdjIvaUF2TlND?=
 =?utf-8?B?R3d0OG51Z2tvNmtPbXlvVkRvSHM1VHc5SklIT1hKeHh1YkRhL0JxZWllYXZM?=
 =?utf-8?B?RmRGQmdYOHIya1ltSHAzWHBFU3pZV1o4bE5hSUNzdGRmMC9UUkU5Z0Z5Sk8w?=
 =?utf-8?B?aCtJYjk3SlV6OTJIVlkyOFJUSFVocTZ3QkVRNG93V2xudCtXYUdQRk8vYXZK?=
 =?utf-8?B?Tm4rbHNXSndqOGJzYjhMWGVDdEN2cHlMekk5NmxqNzQwbkd5SmpNVVhwaWxF?=
 =?utf-8?B?ZVRtNGVZOVlNTXBUZGlyZFZJMWswRHZDSWNtSmp1eHNRbXRnaUVWTjRKWjcy?=
 =?utf-8?B?akMxMmhReXMxMzdpQTZxZnNrQzhZdGF1Ky9PVTBLSmRsbE1oOGNuN3BhRU9B?=
 =?utf-8?B?eVVraDFlbSt2TGZvVXZRN0lZR25sNTJOSzBDeUpOYlJJT3RNWGhLN3FjNkFW?=
 =?utf-8?B?TXR4cHgzbTJMMVNjRFdOU01POWVoeG1zSEkrUlVxdjhDaFBzSUNlOXZncERp?=
 =?utf-8?B?WG44NldGZytiaHdtTHZuNnN5YmxpbnNjeG44VmNrUTBqV3ZjU1JHeXUrczha?=
 =?utf-8?B?dzh2Tmd1VS9zY0hDOWh3MnFJdFVNelM5RWU2L2dyR3lUNjFtV2UrYUtqeUZC?=
 =?utf-8?B?RDJSSHFMZlBnTU1JMUd0YWx4allHSkEreHlHQUQwL2hNQjY4QXZaZGhSbGFJ?=
 =?utf-8?B?Y0VvUUM2dVkrdkNlZ2pjY056NWwvaFB0MnJGRktSQ3UzL1gxZ2oyMHlxRjNR?=
 =?utf-8?B?REN3K1NYaDU4ekNpU3NFcWJhSWlQWk8wYXZ2WjdGN2lZRVhlVEY0dUhOVTdq?=
 =?utf-8?B?UHhLTDVKK052UzNzMmVScnBuM0xmVkFsdkM4dnE5Wi9YSWN1ekhsenBCTHlI?=
 =?utf-8?B?anEvMWNwVmFvSEVjUmZzY3hoYTRpTXdvNEVZSUg1SzEwLy81dkNqNFZmZmUy?=
 =?utf-8?B?VHJOSmFRTGsyUzdGaUJmQkU2WmM4UVQxNTFXRFdYWjVUL1hEYjQzcVM1akkz?=
 =?utf-8?B?UHZGNDRwTWt1RGF2aWoyYjN6N3ZySThMME1xaVFLOHRvSi9lbDJHSGJoMjFU?=
 =?utf-8?B?OE9aZVNqbUlSVDZmQzFNblJKelJmdUJGbncrdTZGWXpxNFoxUVlsQUtDRVVQ?=
 =?utf-8?B?VzRpRGhXS3ZUa0JjWjR3bWZHRXd6THZkSmtoQjZyb3Ayd2NsQ0YzZEFLTmhQ?=
 =?utf-8?B?Yk5PRHpYTkxBQkRObEVlNDJ5eGp4SFRWcG9idkp0WWpveW1ybHBrSWxUR3Qv?=
 =?utf-8?B?UlFkbk1nZUZsMTIyV1FCUmFRdUNwSUswc3UwQVFDUVczU05GMkg4Y2RoazlL?=
 =?utf-8?B?RXJIa3Q3R1VyS0MrUXJaTmhiTGFwR3NUM1ptSUlzNlY0QXNVZjl3dWdVVTRa?=
 =?utf-8?B?R3FhRjdvM3E4WmZjc3l4QTlKeXNLOUJhaE5nM05XZDY1NGsrMmwyektHZ2RF?=
 =?utf-8?B?dTUzUjBHOFFzSkpJaFQwTWhWT0QvMnU0R1FDdEFmdHV0OWVBVmxKR0c5akZY?=
 =?utf-8?B?b2VzL3VMTi9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9FSXo5UjhNUUgrTWZsMzJNbmhYSGVtWEZtdHgvTWhlanBKSGdzUTZwY2FQ?=
 =?utf-8?B?WXByTlZhUGlVY2lrVkhieEVhaFFValFkdzhYZ2FHeTUzRFB3S0puUUNIQ09v?=
 =?utf-8?B?bzJ1N1AvZHR4cTNHYkV2R0thQ3JmSXN3ckl3VkRGbXdmK21Oa2hNQzdaRkhH?=
 =?utf-8?B?bGFJYmQ3dHZaZ2xLb1ZBdkNjTkRXNnorUFNOQU5pWktydUh5NUpCUnEzWTdR?=
 =?utf-8?B?dFNzNXFSaUFDMXZjWVZncHhoZnJiSEgwMlZFVDUyRHhmQWdhYWlJN1NiQ09B?=
 =?utf-8?B?Q0pzdndSaTdLUjNCNEtnTkV6WktUM3VBK0NLNWlVYllaV1dHWW5qWU50ckUr?=
 =?utf-8?B?VGNLbjZjT1JtSUY0TjFaWmxRbGlSRlIwc0k4dm52WXhDTi9Pdk9tSGxoYzVK?=
 =?utf-8?B?ekVwVVIwWWpoYm1Jay9uQmVQK3JqRlh2VTc5eGVVRTAwRkZPalRyTHhaNzZj?=
 =?utf-8?B?WXRNRk5uZnRTL0hXWENqT3dPcFNyY3Rld0RZRDVaOHNDNHpQZHlMTWxlSG5r?=
 =?utf-8?B?eUxid3MrOWdmbkFhbDlYOHVaWDlobE44TU40L1JWQ2Exa2p4d0FjLzVpcldm?=
 =?utf-8?B?WHZUcXd1YVhkUVkrRVIzZFdIeFBlc3FYaVFHWE80QTkrbk53a05UdEo1Zklh?=
 =?utf-8?B?NkRzV2E2NUVxc2NUQ0Vsd282UFZWNnJTdVVacXNQRDZWU2MydjhqWVpSRi9X?=
 =?utf-8?B?TnBMVUVJNG1EOXlhVXB3MUNYWkVHOERYQ2JLdlY2OWc5UjdqRnhMMFgrQzk3?=
 =?utf-8?B?VWxZaTdCcGdCdEtlU0JFekY4eFI2M3pWVjZnSnU3SEFtWEx6RlhVM20xaWdx?=
 =?utf-8?B?ZkFoRGl0TWYyM1pVeDNNeUkyVUFFcUMrM29DR2pJajlTVkZpdGZMSUFlaksz?=
 =?utf-8?B?TDZJQ2xJakIrWDlYOFpFYXZiYzkvNWZHK2ZxVW1SWWRXT2Q1RXc3Q1Q1NlRC?=
 =?utf-8?B?aEZrTzNTT2JQa3J5STFRb1Fwc3BwYml0SG1ZcUV0OGRVMVloRjd1U2g4RjVm?=
 =?utf-8?B?YlJKcjJ4bEFzZkhjYzc3VG53ZWpscWpsdlRmeWs5cU1KaCtwajVEWlBNTE8w?=
 =?utf-8?B?TzFBdnZwK2lCU3FLNHk5YS9Fbm9GMlVZcno1a29pUlVhR0kxUStWUWpmdHYr?=
 =?utf-8?B?OFIxWEIzRGlkbXNzYmJrejcyRG4vRzZ3UG02dzROc3lodFpOc2hPS0pPUWFD?=
 =?utf-8?B?YW8wdzNVYTJRTjdHUVNHWkFNMTRzYWM1SWRmUTVQTFVDNU92L1A2YitWODBv?=
 =?utf-8?B?ZG9BWjMyS2FGZHVLVnpsQmQyNFNuMU1YUS9RcE5oaE4wWTZQRXZEOEw3SUZu?=
 =?utf-8?B?TVdtYXNsNkVwZCtiSm54bm1OTk1vVHlzQ2g4cjZ0eWRnM2xBZlNqc2FKb21R?=
 =?utf-8?B?M0FIcUQrRkNJQnYwUW0wOGJzeUsybGtkSFFCQzdzUXRaRmlhbytCOGhjeTJv?=
 =?utf-8?B?ckFHMWswdmMvdXpOTzhrZVc4dVp2OVJLMFFoU2lNaG1hampwajdPRVlaNVJO?=
 =?utf-8?B?bXd4dzFyaVUvRVJMOHpjZHVxRlVNTUVTb21Mei9SQ01FTE1PcWU5QkkyUDE4?=
 =?utf-8?B?TEJFVkZGUkY1S05BT1ZoWHdiV09BYVhwTkxqeWIzNGc1MjNUVDZGVUdQVVFm?=
 =?utf-8?B?VU4xSnJwZjFsd2c3SWpBNGRodVV2cTlmN1Qzd3BDZCtjWk9KMndocHZ5L0xr?=
 =?utf-8?B?ZlU3SDY2SDZzRFBza2ZNNCt2ajNDN3hBNGJ4MEFzMmpPbU0rMklMZG9vWmZV?=
 =?utf-8?B?TEYvS1k0VWMyaEUxQzZqblExeW9udnlBTTk4SHNMaFYxS2hVa0UrTmZEcjZo?=
 =?utf-8?B?S3BacUlQT05nOGg5NWtpS2d3MHZzNE1WN3AybUJxb3NSL25JVG9paVFGV2xn?=
 =?utf-8?B?eTBjMDZXQ3F6Y01YenViQlhVcHpwR2tlbEpqTHRWbXBiTE9aM3NnVUtjaXgy?=
 =?utf-8?B?N3k5TUpFc0gzanIwTGxPeVNjQmpxRDZIVjh1UjBCMisyb1B3aGx1VUxlYzNz?=
 =?utf-8?B?VmJ4U0NXaVZXeWc5RzVMeTdTdEdxVXBkaVNXYnN2MWYzd3AzOWNVMmdlU0Yz?=
 =?utf-8?B?Y1BZVjd0bGp3ODRtVGc3NWVZTklnOG85TW43bGlNR29RMUZSNVh1MzhWMitO?=
 =?utf-8?Q?rxDrlhKEk8yvmUQCdbqHqyPBI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127e80ed-43eb-4fbf-365d-08dd78a30a07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:20.6163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTUZ/bL0NoeG+iM9n++RSEVjK+x4luSy/7UzkHF2RpXkUj64KzZJeEW+TnYJAvUjWxdPSI/Ik20G/dJTepiCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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


On Mon, 20 Jan 2025 12:30:09 +0800, Peng Fan (OSS) wrote:
> Per JESD84-B51 6.6.9 Erase:
> The host can erase a contiguous range of Erase Groups. Starting the erase
> process is a three steps sequence. First the host defines the start address
> of the range using the ERASE_GROUP_START (CMD35) command, next it defines
> the last address of the range using the ERASE_GROUP_END (CMD36) command and
> finally it starts the erase process by issuing the ERASE (CMD38) command
> with argument bits set to zero. See Table 11 for the arguments supported by
> CMD38.  The address field in the erase commands is an Erase Group address,
> in byte units for densities up to 2GB, and in sector units for densities
> greater than 2GB. The Device will ignore all LSB's below the Erase Group
> size, effectively rounding the address down to the Erase Group boundary.
> 
> [...]

Applied, thanks!

[1/1] mmc: Optimize eMMC erase speed
      commit: 674a0498e9b15a84524a0187f1d80ba30029a470

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
