Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ADCC8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED39831C6;
	Wed, 27 Aug 2025 09:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZaFsnlAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E86F83192; Wed, 27 Aug 2025 09:35:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EE4E831C2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHGtDCfHydcZwfk1+NS3rNLyDVgXN2xlZQvQKWDf93nO2GhVBoNI+I4WFFtRSOdVn4oCWKXZuOCUqrRT7xCyY97ojxPSIqItFRRK6bD1FHaglce1cjOw9pl0YAfD66A1t1Pzk2xUFp6Y6hjUtax5i3o/SusCq0gqGxulJ1M/hNlexkKHIxChJQ0R2biPVg8B1/ZA6uXaqza69OFvoTHdq6bEKBh3lhcH7b72DuFg6RjHlskdgF/WVOz7Tv26iIBJKK9zRtKVc3tXypIM5yxBsUaFrOPySSeb8RWZOVRSV5f0C0OxdPHu1saipykvzsPWyABAu6phkTlNHjJNTk3k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZkoJ83IufD7jhiCWg+ziGEMZohOpZ+kAzTs5wQ8d9w=;
 b=lbGb6fSo+jUdjjz3xFhOQ2oCr/KP5/LYuFEHykLHgY+OW4GRphsMWhk4mrjwuYCcSV7edCIMZMMm/+2NupjBZkCMAividRqgn+rbT9K7cAMSlCPbAUdtDg73YSGDfdUbrLCktyS0PIPKwTWljAUDc5TkkcNvl5gQJtazXNiJviH0p9dBuls9kF4nirXu/gSwDyHzMEnlx8SWZUjiu6ifstTod8FrCy0DLKGEVuqp2Qh/7jpbQnY+9RoLibaANC76vuhldipOMbPMb6oABBzzb7GALBEi1ke07ut7qAx1k4WxG99p+BDUX3+6IxBtfNEufhaWDvkjBtJJzAdCda41gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZkoJ83IufD7jhiCWg+ziGEMZohOpZ+kAzTs5wQ8d9w=;
 b=ZaFsnlAAfSsK4oD1FbRqi2rEPPUoFi3vxvQFtZ/3BeAKbLA8XH8j0X6AftopFHxH1wCyMEOzluJ+GejRxDPpADZOAkslHQG0AeRvdoYeb1r3Bc9fH9Qbh9VoNKT5C4NgzaPmETefoZTIJhfPZifdOXwzL7o3UUWRSnbLyRcFwmGcddkurByGH/TL1i/GIJl8874FG5d7okUKY0iDjGiTHCOOM81RzkQrvTm4dy7+TECQuuorm9ne3JcV7qgXS3AO1mzYgfGZIzErgsmi3rgSjTPyIBN/ET1gv1iXEZU5TqkaDFZY0ahTv/+tBAhJ3UsEVE/ABS+JBpu0gA1eRbcK2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:35:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] drivers: qe: avoid double free()
Date: Wed, 27 Aug 2025 16:46:07 +0800
Message-Id: <175628406773.4168.6136575606245230188.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250808-qe-v1-1-7b62b9229128@linaro.org>
References: <20250808-qe-v1-1-7b62b9229128@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: d665a246-a9f6-416a-865d-08dde53c42ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T010djNqNFlrRDRJNUJoeHAxdlBER2tnVkdVem5SdGhiN0grNlVObm4vdDh4?=
 =?utf-8?B?c1o4dnJQMlpFYlFPWVBBYUZFU2pNdTBieGZHUFNFOXJOSXFKK2xTS2J6VnZ5?=
 =?utf-8?B?TGUycTZNWUZNRy9OcTlNODRCUytTc1hVZ0xvV2ttcU5VUzQ2UDZweTVCVGho?=
 =?utf-8?B?WlBadldXcGJpN0NRY3pGMjlISFgwT29WVVZ0QVZ6dktrK3U2WjROTEllR2Zj?=
 =?utf-8?B?OTVMRElyWXhPbXpjWnlPSmNsOThIN0FiN3BJeVJGU1YyaXB0Y3BvSktEVG9H?=
 =?utf-8?B?aUVXZWE2TUh5bDAyclBWSENHMkhpVG9yTzFiYnVyWkExTFk0L1N0V2FiZnNG?=
 =?utf-8?B?WUR0aVI4aHY0S2x0ZGlUMkUvTTU1NGpFTmFDVnFwNVEwRml0L1BITllIRnJ0?=
 =?utf-8?B?UEh0T29WTGZCNkZXQ3gzMnVoRFoyMGhaTFpVbkNKK1FXNmJmOVc5ZG91cVIz?=
 =?utf-8?B?UlAzckRMVVJMNWZxR1JNV0NWUDRZRWF1akxTZXp2Qnl2eExHc1ZKK3FLUmVs?=
 =?utf-8?B?Y2ovNlFEZGdra20yQ3QweUhpUDM0bENjdmdTOXVZODltZ0hzK1orelRQZ2FW?=
 =?utf-8?B?dlBHRHZrRlRHbHh1WXpBUW04clFUOVZSYk9FS0VsOHlFSE41aVhES2thM3R6?=
 =?utf-8?B?UnJORzNLbUEyWGw2bEZCNU9WUURXS2lRMUhmNUpZUmpDajdCWi9JMVNWbEpN?=
 =?utf-8?B?WmlOQ0lQVzdtdTdLclhEa05sa28zZlAyZGJQLzJETzdqTkFQQXFIaENJdU5V?=
 =?utf-8?B?VTFqR1ZtWEdLQXpwZUpFQmFyUVIrY0ovRXFyTTc5c2tiYmZaUm8xTytkNEV1?=
 =?utf-8?B?cnZZbWR4cTVaY0lieXZZU2ZXc3BiSXRKd2N6NEpTRTZvN3pFeE1UTlM4TGIz?=
 =?utf-8?B?cTU0d2E5QmIrdjBPWjhNQXdDWFVmK3FTMFFYNnJiMDVzcHEvZThOWjVLb3NS?=
 =?utf-8?B?U2RDeitNRWQ3NHY2MTY2VjVDcWRlb2Q3cW01N2VPcWplaDZJVnNWaGhWK2g1?=
 =?utf-8?B?QnJTNHNQMmYyNUV3YWNua0d1M0UzeDcwbWdFT1k1MWtBRkZIcStSTmpXcCtJ?=
 =?utf-8?B?SHR4VjdGSDB1VHBiTk1nZXBTaWNQUUYxbW5CYnBtV2lOaFFnU3YrUktoTjlo?=
 =?utf-8?B?Rkh1K2k3aCs5RTRqSEQwaDMrNEN2TmFtMkpRSUlkWk8rb1F0Nk00MHVzMVRn?=
 =?utf-8?B?ZGRxcUdMcEl4RE1SVlRkVnAvcmh1ZU5vQ0VGc2lITjlXQ0FZVTI5Z3pXRHQr?=
 =?utf-8?B?M0xENmoyUHZFbmE3ekpkWjNKdFM4dUxMQ0tEdHFQa2xOK0IxSXp0d0IzZDJL?=
 =?utf-8?B?ZFVlMmZDZnZVOFZ6dzBhMmVBaGd4TFZtU1NMV09DSE9xYk9kRFd5dVB6bXAx?=
 =?utf-8?B?SmZRQ2FZMGxrS0FjWkxjejY2SENHT1IwVHRmUUVEQkVhN2MySmhJZmF5R0dO?=
 =?utf-8?B?ZkJ1ejBmbDRJcjFEdnlMM3JVT2hERnFDTVBjMzY5eUszdjdBYmdhcFFxY2Q2?=
 =?utf-8?B?MllTenNFV0VVL0EyQlplUks4UmwvejRiaHMzMzRYQ3lXUWp2c3lGN1JSZ3F3?=
 =?utf-8?B?QXpqY3ZUTDdUZ0ZyQUU2RzNEV2RUQTNCY2R6MHJqclI3dU9sMWdyK3RXektV?=
 =?utf-8?B?Z1V6Y2ExWHVtY0FUSnUxRXo2VnlQVXZvbDkraklUTEhKQXRZaFBET1F1aGQv?=
 =?utf-8?B?NTJscURMQ1JsbzY1ck5BTGVuTkdNRno1YTJIbkh1SXhzZFVCeXRqL21VRmxU?=
 =?utf-8?B?cUc0ZFNwRVJLNi9GTThZa2RQTjlkNGdESjlWVUZ5OCswZXdldFpNcFF1SkRI?=
 =?utf-8?B?MytuWVpBOTJUR3RldFFsR0NlTHBKa2d6R1R4N2tRTEl6YnduWVJIRzJBRTJP?=
 =?utf-8?B?L0pRU1JMVlA0ZFVsS2dvRTRxYlZpWlhOVUNKcFdwcGIyWnRBM3ZxT1hodjJ5?=
 =?utf-8?B?cWZDUG1wbDdTTkZtZFNFR1kvTE5DS21aYjdqWWYxdmxXWXkvRWxGcFlCdFZQ?=
 =?utf-8?B?RDR2bUlrenZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhwWkNybUh0UjQ1d1M5bTcvZ0ZnZlBJWXBtazdleUU5eWt5MDBKUVRMckxi?=
 =?utf-8?B?azFhVG5XU3E2R3JnUjlHemRGRkl6QmU3Z081cUZwcThYaHFmd21jbytFaFlL?=
 =?utf-8?B?TGtJUmtiRS9Ybm9YYWJ4d0lxbTRmUzUxUUNvcGNzRnF1c2x6Q0VrcFVBS3Vy?=
 =?utf-8?B?aC9ZbG5pbFpYSkQ3VGh0ZkJyb2xia0VjMjAzaXEwUmwyRk5GTUozUHpqcGM0?=
 =?utf-8?B?QkhEUDZwSVFmZjF3WDQwSTZQN3J0NGgvRUpJaml0TzFncTR3R3VYZTNHeFkz?=
 =?utf-8?B?UUMxNklWRzVBTldCbDNpeDUvdVNkYkVrdVVNQU9lUG53NXlHNU9KcHYzZG1G?=
 =?utf-8?B?ZGJlWGN1NitzdU54cGJjM3MvMnFDcGNzbzgvTnB2VXdYd1VJZjgvVFFGS1Zj?=
 =?utf-8?B?Skw3OHJFYmE4V0xpcGhoMi9lNmtoVmtBOXlaK1IzUGFwQkNKTHQrU0FkQmNk?=
 =?utf-8?B?ZWx0MU45QzNRTlBRRVJCY2lJMnZBcjF1UnVYcnlrZ0FKRFdFREJ1RGhTQWlL?=
 =?utf-8?B?MU1BZ1dnZnFFdXB2a3NZODVhZEdmSG9GMFROYjVnaVNvZ3BCd0tFUm9ZODY0?=
 =?utf-8?B?RENUemwraGVyYmhickthSHlDQkt5bUI0bUFWZ1dqVTUzNjdPQ3R1TUZmcjUv?=
 =?utf-8?B?NTJOd2wzVTVGRmw5S1RuZUxueU4vdjFJMU1VdGgyZG9lcE1xdWhPdmpNcS83?=
 =?utf-8?B?VDlKOFNOeGRPTXc3R1o0ejBEUG9ZYVJyTmJ1Nm5wdXBSV2drdlVnUUtqVEt6?=
 =?utf-8?B?Z1Y3YjJIOEZaNEtGODVraUVYT2E1VE4wN0w3ZU5QRlJpa0pzZXRWbUJDWEY2?=
 =?utf-8?B?ek5zRmIzZ2pmV0M5anYyc1dBU2VLK3R6SEhpZTEvMDFDMUNyRzFONjN6VXJD?=
 =?utf-8?B?Z3dENkNrS3V0TFFDbG9manRiVzNCc05SaTJia1BEYS9lK1VuT09qcUVvc3NU?=
 =?utf-8?B?SG9laTIrRzN0VUJjeTl5MHVVVmRNZllXRXdMWm5xdi8zNlN3bDVpSTV0NWxH?=
 =?utf-8?B?ZlpWbjMxMFFmZ2NoSTRHWCsvMXZKbFNlN2dwWW1zMXkwOUFTdGJJZ29Oazlp?=
 =?utf-8?B?eGFKTndPdjhoajFZNEtMY041RFlMUDh1NmRDQTBTc3UyOG1kcklVMXEva0xV?=
 =?utf-8?B?QXpXT2V0TkVVMHIyZzhlVHdYTkYzU0xzZGFxUFRCK0gzczFwUVVtMm1GeE01?=
 =?utf-8?B?Kzhsd2lPSzJlbGJVSWxPYkVZcmJLRHlVTHhmL3VLVU4vMWE0TjQxeS9jQ3hV?=
 =?utf-8?B?Qi8rRWp6bE10akhwNzFYQkFRbHkzKytWa0FmVjN5RXhBZzNJWFdlSEl0TzZ5?=
 =?utf-8?B?MWtNbEhkVmdNTkpNS2lweEt0SFJwR2p4TjJwQzMvMk9xVjBPQ0xLV2RDUWlM?=
 =?utf-8?B?TFo2ekdxSFJxQUowenNJQ1M2cS8zc3ByRGVSczVGZE00WVVDSWhtbmtjVHUr?=
 =?utf-8?B?c2tDK0JXeUdBVjdESHVhM25wKzBiUzkwYnQySlBoaVdxSkVpenBrK3NIcVlQ?=
 =?utf-8?B?M3l0NjB0UHo5eFVuUXJYVkIwMTNTd3ZNdERLN0NVR1dUQUlEWHFUMmExYkwy?=
 =?utf-8?B?dWREMDJ2eTR4ajZWWWVKQmphMmJNaWlHY2N2Zmh0Q2xVaHhkM3dQVk0ydkZh?=
 =?utf-8?B?dE1FYnFYaTJGNGF0S3NramFlY1lqZnM5aGpwa0NpZC9WWisyRjF2TUhocnFO?=
 =?utf-8?B?UXNDTUN6R0YvVGFEWS82YnltY3hJREprWnhHcXRadXhyUzRWYzJMZ1FmOEYy?=
 =?utf-8?B?aUNmM2ROZkZHTUtZWFBud2lIME1nS1ZCNGQreW93N2docVRNZk5pUGM4bFM5?=
 =?utf-8?B?RGpqaG5ycXFlT3hMK3l1emxzUzh2ODJNMkl0TDJpY1R3cmdRcXFleXAzcFNW?=
 =?utf-8?B?ekVoN0tqcm1XNjVidXo1QVU0SkN2WS9oVTRHN3UrZmRpWkpmMHFlQWNoUE1S?=
 =?utf-8?B?TDl5SjU1MVZoVGhlRzVneEZlUlhzR2QwRDg1bGwwb2FzckdrMXArSWVLKzN4?=
 =?utf-8?B?eWJLOVZIaHBnb0M5UU9BcHc3VmtGNXBmdG5ha2JUUkRkWFNnbWttUTR5cGpH?=
 =?utf-8?B?ZXBXM2xaQTYxcXFpNHgxYlZndDBTWkFOVlQ1RzQyQ3NpRDN4dEsrelZISkVu?=
 =?utf-8?Q?tLB38I/lcGnyw3ynZ7krEW978?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d665a246-a9f6-416a-865d-08dde53c42ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:14.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXPUKUotmIKI/0GyYxBVSXUS0iBXvdqSIi2xmp7YWwmulOOwynOo4kM8lk7YIf2knFdnl6fnw6+Pxu9DHgZU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
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


On Fri, 08 Aug 2025 11:29:33 +0100, Andrew Goodbody wrote:
> Avoid calling free(addr) twice if the device for ucode is not found.
> This patch repeats a similar fix but that only applied to code without
> CONFIG_TFABOOT enabled. This patch applies to the code with
> CONFIG_TFABOOT enabled.
> 
> This issue was found by Smatch.
> 
> [...]

Applied, thanks!

[1/1] drivers: qe: avoid double free()
      commit: dc37adfc040877db359abdc7eab19adffb8fc722

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
