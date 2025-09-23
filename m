Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD117CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2DE88349B;
	Tue, 23 Sep 2025 04:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zyo+3bce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDF883211; Tue, 23 Sep 2025 04:15:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B485583443
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s60azoZTLsFKSro6QIJ7iCw10eFSTEpMnaNYObPDHBI9DEjOBE+C69Q47WCWiA4Qb1mxlhDXybOpvjwDqlQqkkpRofkP8Xwy3WmTA72WL5EUqwqPfAXeIZHUbcqRWA949IKitTSfd0ZdFE/QPGT8MzKn5LoXJ7N0VE2XF0rQrMZCQY2lLwYcBxHu3+l0p6DU1JmVvMLt9Z3Ewy6DZiJYm7dJ5bYXkOnvO1p8GquTxKJSJztrTw+RosntAdvcGMXE0f3e24zKuy6ZBheCo4EZOU+Qf6fCnz9GP1yLyciKzhytBPYX7cg1r1cpJF478Txyw1/oKhcWg2QROqrdvoiJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ybviiJmU1CPMmlQVrmRH80Dga6XE3vPmbDr4oIOxZs=;
 b=dXVF/3/+qGQMRdSaDE4rhgkm0o+TBko6FA/w8Ik0Yb+DmjEk68eHV/+R8M9oemlGduM7aqoySwwhjSMZUZ5SfznBWXFplfzxpR5D7ozFh5qfy+MDgi9mL3S4nQFxePpsYef+4kym5E6HA6IlcinJdxsmtDhw9KwW7uii/gQ0diqpsmYx3tZAEkCdoRFr88xTgyp9nlnvLO5yBWsjaMfrjGdbKKxT/ZfvoMGo5KeJ62Qvg8eDf3W0qevxkhsRpDp+0i+kigm0PbHUIId3oOvf7GocYaaIB0/MXqceqaooCizbJmdvqeHak/HAkW/5OzIJGvhPognrYV8KE6nZb2HXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ybviiJmU1CPMmlQVrmRH80Dga6XE3vPmbDr4oIOxZs=;
 b=Zyo+3bcep92ov1o9S/SdxaZt53I90my6AhqEBvdkJN9S+fKzlQHjDkGvjxGAHhDBA2jnJ2SvvyUSNC2iwxpiNIK6z88gTHhwk4zfijq6z2p+FkvXq4yrEIEVQAn/2QDfveJsMg8yCubBiMO9G6ODVXcegK49DErZsbIKRvDAVRHqv4Xw4ygKWP+V7K53ApP5cjkmgbxZj2rPA7Yz0uoIfm0Jox/NDQjZF/snZ/3McZ7/a0/A6cxRzFqqUIxLB3hbbWHtCctvidmW55BzELrF5b8/12BaIE+97hhCHMPs6+EZI5pl/3boION4qHVGNmz53Onbku0FMpatRB529FstDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:17 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:17 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:14:53 +0800
Subject: [PATCH v3 01/12] imx9: Add i.MX94 CPU type and SoC-level Kconfig
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-1-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcd9322-6c47-4ea5-a821-08ddfa4709a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmtkaDJkY2FOaFd0QUluSURjK2poMnlkUnRzZFBoWW5LK2grOGQ5ZVU0UUY1?=
 =?utf-8?B?RXhSR3oxOUMzRmgvdFZ4QXJMWXRUU2xTK2ZpbHUwWGpabUJwUnBIVnViMkJU?=
 =?utf-8?B?YU8wNFFCeG95eTVIcCt0dXhNa1dCbExId1FuVTliWHJOV1Vwa0g1WkR5Z1J2?=
 =?utf-8?B?RXVXdjVTSDJTL3VUUmt3emFuQkRpeHpua0swQWhjdG9RU2d1cjBYbWpaSVJZ?=
 =?utf-8?B?VkFONnp0NDBZVVF1V3U0RFpJT0t5amhBOHAzd0srNjdsenVzMzA1MlF3bTl1?=
 =?utf-8?B?aUVuaXphVXpXYXlOMGQzMTJUM3VFaEVMWTZVRXlZVjdoNnJRenVtQ1E1YlZ4?=
 =?utf-8?B?c2UrZkUvck9wbE83SjBESlBsaWtLa292TlZ6SGI0Nk5HaVAvQ2FxdkhRemFW?=
 =?utf-8?B?Zkp2YSt3c05abHFtWjNKdEJFeVJjbUFBMFpVQVA5TGkwb3R6RWFvKzliNTFC?=
 =?utf-8?B?V1pHdkZPMTJjYTE4Q0JKZkt1MlFGa001S21tYXpFZ0RRUlRaT3U5Ui91S3BN?=
 =?utf-8?B?VDk1WHZXQVhPRWhEd3dSRDNqK05HVXNQaGpDUkFzY3hGSmtlbDdLTGUxWFB0?=
 =?utf-8?B?TjdpcW9FVkFpaFZXbWw0eGE5dktPNmp1VHpXemNMTkoydUxad0FlT2xNdDJR?=
 =?utf-8?B?RXcyTWxvd2RvczYvWHgwZkZnYU9FMTh5blNSa1g3emNaMWtyQWpHZERUOWRj?=
 =?utf-8?B?SmlqemxCMFBQL3FwbVZ1alk1Y2xGQjE3U2Z4cGpRV3EzaERQVFdmOHhndENT?=
 =?utf-8?B?VkNoeEFKaHV2cURlRStUQnFzQ3phcFMrcjNCMUNobVNQTU5sZG4xck5Ud3Iw?=
 =?utf-8?B?elVpait3bUJjSHlZTEE1MDlUZnpob1lqSWFsT3VoVUZjRzBabXY4NGRHTWk1?=
 =?utf-8?B?VWFzVFNjd1hGZUhwVE0rL3NJd2xCS1R4MWF1aVNpT2xUNjhkSU9mWUJDdWhq?=
 =?utf-8?B?dXVZKzlMRVdLcDJGNG0xWW1Xd1EzSTQ4d2dEUVc4RHRRMHdnRkhoekgxNVdI?=
 =?utf-8?B?L1UwZmJYSGp4ZmZESmNIa3Q5L09BVzBNWWp6UlVnUXNCR1NSdGdBTzVFNmEy?=
 =?utf-8?B?Zzg5TkFSZmlDb0xqYWZ0eVAzVG13Zkd6WnJIRkdvWDZVR0Z4OUpXYW84MTgv?=
 =?utf-8?B?eE9sSEpiTzVSTHp4OWRPVkk3Ni83ZUpsZytYbHRtaUM3VHl6SC9nMjdBaC9x?=
 =?utf-8?B?YnFFa3FoTkZCaWpwd3Nrc2NlVVltRW5HRjZwcEg0bnhibWVFaFFNV05XSVky?=
 =?utf-8?B?cWZGZjJSZGllQWhkcnhpM2tBWUVBNkVCSGhDK1EzM3VMR1ZIN1IyRDhsblNT?=
 =?utf-8?B?amE2d051QkpEU0RkU2ZpSlF4OC92d1ZLdG93TGtRSHZ0WDVIVHR5YUFzdENQ?=
 =?utf-8?B?KzNON0RMZWhuaVpKbGtHWHpWb0EyeERvdnAwbi9hb2tNZWNISmF4dUJ1aXdU?=
 =?utf-8?B?b0JpbWYrc1lvUUpJOFRxZlpwWko3KzNNdmhCNDNBb0lRM2pPeVN6TVd3T0l1?=
 =?utf-8?B?R1h5MHhsajJCSkI5UjhFY1JMMXpkWDlRYWpMVzNVMGh1ZXJ2UWdGTmdHRTJ0?=
 =?utf-8?B?Yy96YW50ZTZ5N2lhNFdhMUY5TXFFTk4rQmZBVWZRMGxGRTlCUTlVRnFROWNr?=
 =?utf-8?B?MWFGWnpGSTNGS2U0SFlrNHRJZGN0TDI0WEhEYXpoVE42dXBua0pyNmNBN1lQ?=
 =?utf-8?B?cFNRK1o5UzlIRXl3a1RzbUJ4RnI0clV6TFRQTGV4YVpBOGQwWFFDMk0reEVa?=
 =?utf-8?B?OUNuNUdVSk9OblBBZi9Sa2RxdXczSlFrMU5COGs3N3ViaWlWeWd6TVRIZUNh?=
 =?utf-8?B?dnpkZTZWRk5vdUNiQ3U4cmNGN0Nuc0FZWlFRM0ZVcEU1OHFINDJTUVVpak5L?=
 =?utf-8?B?WTY0RnRLaTJXN25RdUh1aTJQSExnMDlSVkVsNTJEckNETlJ5UlJBU0Q4eWdY?=
 =?utf-8?B?S0VYNFhtWnVNS0tyTFVxc0o4TTNUZXJUa1pJcXNFVkRBTEVSaTE2VGd1Z2Fr?=
 =?utf-8?B?SHBMNGh5ckxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUxrZENHdHZOOUZJN1hhZE1aU25kSU9iN05kVjhOckJLWVo1L1p2RjBpVzdP?=
 =?utf-8?B?VGNPR0FxY21zUm9YN0l6WHNVek83c25DYkh2VXNyb3RHRndiL2tkTWlNcjcy?=
 =?utf-8?B?Z215RWRWR1J0YVdMbXVvQnBYVXQwbUMvQnhlRE5GZ1J1Unp4eWdMMDRFakFP?=
 =?utf-8?B?SzlIMHIzb0x1VXdGMDdYTWI2VXJwbHJLRW9SQkRIaXgxSmtJSjlaaGJoLzJo?=
 =?utf-8?B?OENnRmoySmEwUEc1UTYraHNTbTh6SE5sdlFwdS9KVkUvc29GUTEzOFppZjFE?=
 =?utf-8?B?TWVUTE5jZ0RuUDFmZGd0UmNvdWhvVjFJVHBXa0U0S1JUSndHaHdtejBhekNO?=
 =?utf-8?B?MGhlWndZSjlmV05aaWJSYkRPcUhhMzgrUGY2dDUzVnA3c2RybFFvVUdWMm1M?=
 =?utf-8?B?WlVpMFJESzZpZWpyTWF6aDk0UWNFT2trTTl4TmRrRjhCYXNudlEyTi9MRWlY?=
 =?utf-8?B?R3h0bHNLQTZpZmZRdStkRld6QUdYblZLWEF6aE5BVjBDaEUvVlRaZVQ3eEtx?=
 =?utf-8?B?TjVRWDU1U2R5aHRvdXdLRVVqcnJuSVp4aWY4WXRwZHdmUFFlaFdWaEJHaVBD?=
 =?utf-8?B?dnNySzVRMDlnSHVxcnowVXY5R05oVnZ4WlF1eFR3NWsvaHJ2dklVdno0cmI1?=
 =?utf-8?B?RXV2YjJNdFZoQXpub252d1hNeUdMbEVreWcvUDFCYVphVzh2WXpmSlg4TFFs?=
 =?utf-8?B?clI3RmJ4YTl4Mi9jTWhJR0dGd2VVdzFXOGhmbmtOSjEwYUplUzJ6T1ZrSG00?=
 =?utf-8?B?S1ZEbnc1SXBONi8wd3hnek1KeER6M3NZNmtyVEFUSFk3d3paRzBCZkYvZFJ0?=
 =?utf-8?B?Y3NPL1JpN1RjSC9EZnE4K0ZSTVBLS3NnRG1MamdHbWdIUDRWRVduZ21rSENq?=
 =?utf-8?B?amdOUDBjd0NkYmxKdVlSWFVselM3NEpYSTc2MWxoVWxWMVhxU05RaHhhYWZB?=
 =?utf-8?B?SDJNTkhQZE1NenJPb2NEV2NUaytaejl3UFJIdVVGK1JZcVptZlA2WnFSMUNn?=
 =?utf-8?B?M2NTbHg0RkZkL1BVb3BGOG05MFdnMSthUVpmYWUyNXpoVzhMeTJxeEtzdGlr?=
 =?utf-8?B?cWVLbXdtTVFrOVZNRG9FYW5vdnVrQXBYUXNQUkwySW5DUmM2Sk9kbE9BWGRP?=
 =?utf-8?B?U1NIbFUramlpNGkyZ252S25ITFV5MThOaVBGUXFiT2hYSkRuVVRBS2tSTldj?=
 =?utf-8?B?YzZRUmdwRFdMV2dXTE5xZ3FoUFdQbGU2VU1kc3l5ek1NMHRHb1RNeXoxQjV1?=
 =?utf-8?B?ZUpubWZrNXJnRVpEcXpjdjQ3SDZxNm5HWStTVXl6K0psNVZzOUdWTEVKaElX?=
 =?utf-8?B?QTBxUTJBMkhyd1hVUTQyTU9SdythclNVZzVRY2pwNVEyN2NaeGNWckV0cDdY?=
 =?utf-8?B?bU92SnlXNjdqazFHK29GbTltaGE0ZXplNFl1NmlWR2ZqN053My9JZHY5bHpF?=
 =?utf-8?B?TWIwV28vRTFNbFA1ZjdCTkJNekpqS25Ec3NONXBHYXM5d0tkL2d2SUpGdDF0?=
 =?utf-8?B?TzV1NWZpT3JWMGhPLzN6TGVCcklMalZVTGpsZ3ZRTmhicFVsRWpFK0pWdTBT?=
 =?utf-8?B?blNaUkdYRFd0NnZsVXRlRzh1MWwxRDl4aFNRc0d0elkrTDZvdDYydk50WXJu?=
 =?utf-8?B?d091and3MG5qVnRxbURsNTdTZ1ZzTlFmWE1vcHNtMzVVR0U4SEJINWZvOFd1?=
 =?utf-8?B?bmE0dmZzSXdlWVlpL2tLZVM0dEEraW9pb25YS3pzMVNpbkh2LzIyQ3R4cGMw?=
 =?utf-8?B?K2JxZ3dZaWwvYnhlaDU4dUZIMFFhZGZtMmlZMk1Ya0R4amQvbGNaWllmMGxj?=
 =?utf-8?B?V0l2M3hYSm9rZmxBSU53UXBvdnA1U1MrS0RXVUczREZ2Q2x3TDM2NWhPbDN0?=
 =?utf-8?B?Q1JKUDdMSGY2WWdmU0tGNjVvQ1RjWW5lV3dRZ2JLQWRNVERzaEdHNmZ2RldO?=
 =?utf-8?B?dmpxbGUzeFM4N1RZRTczdURnSUZQanFEc0JxSVRuV3FWYmFRUG5Zd2kwZ1ZR?=
 =?utf-8?B?NTBOVml5RE1TdFdhdllVdTVZWmxvVzcvVGsxa29FaVZpZ3JmL3F0ODRPZXhr?=
 =?utf-8?B?QnRqeVRqdkwrWUZLcXFnakxENUxNaFg1UjYxVFVXNDFSZnJDbVY0ekV5c3lX?=
 =?utf-8?Q?C6Pv0+1vpJabh4jG9TDgEcxFz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcd9322-6c47-4ea5-a821-08ddfa4709a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:17.0034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbrVG2fYrsFz9H0xE8gjNoDY0IafcEjCbLIyqkwelEowkkQmOeu4S6K9CWJGKA3PCNni+sz1+abW5aVa6BUhDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
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

From: Ye Li <ye.li@nxp.com>

Introduce support for the new i.MX94 processor, including its CPU type
and SoC-level Kconfig entry.

The i.MX94 is a new member of the i.MX9 family. It uses a System Manager
to handle system-level functions such as power, clock, sensor and pin
control. The System Manager runs on a Cortex-M processor, while the
Cortex-A processor communicates with it via the ARM SCMI protocol and a
messaging unit.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 1 +
 arch/arm/mach-imx/imx9/Kconfig            | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 1f669c72d00..1af9778f8ce 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -78,6 +78,8 @@
 
 #define MXC_CPU_IMX95		0x1C1 /* dummy ID */
 
+#define MXC_CPU_IMX94		0x1C2 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 0780f99b49a..46da7a1eff5 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,7 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx94() (is_cpu_type(MXC_CPU_IMX94))
 #define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
 
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index b6acbb20ff0..f2011448c23 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -38,6 +38,15 @@ config IMX95
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	select IMX_PQC_SUPPORT if !IMX95_A0
 
+config IMX94
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select DM_MAILBOX
+	select IMX9
+	select IMX_PQC_SUPPORT
+	select SCMI_FIRMWARE
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
+
 config SYS_SOC
 	default "imx9"
 

-- 
2.43.0

