Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8404FD358ED
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBAB83C61;
	Thu, 29 Jan 2026 10:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rCzYc8Cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262E880086; Thu, 29 Jan 2026 10:39:31 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A15D83B5E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugvrHs8wD2+o9iV+CFZ571Yd4aro6FzARuHX+tbVBT2U8keSyKw6+yz7Yj8lAYXI99+yzCvNiOd5T7ZSnV5O8Oi0oJ3CpTLDkVRJh2q2KJExt6P53rLbmutv2JCn9o0Cb0eR3stEIKVMMOl6Fh51vBqxC8fbPhZTPqHVVFPfq882th3JC86ohYnJ0CS1tWTD6ASa7NE0MBveQ/pQ+GdjUooK3sLBlIwXbgBAIyPLLTQqe2dOx8PdITwkkNYdjBX30E8RNmj10XNo00R8XTV7+My8QxCaXt7aeyjIBQgPr91S5ESYq04wQM7vBkVKEG5YD4MciMgquclDakI978kiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEheZcKJZrLEPpzMU4mnOlXcD5/SOTr/r/CpLIpMy14=;
 b=m6AIAGe3gLZJ6N/1Se+wrEzbR+UKT36F6s9zsOS9ykauExYRO0RJ8bsWbhx/CJlYCmteSZqtfSow6sRJzYArUtj4D8uuGC2OfQrrb58oT8IjxNP68rzxqDH44bWWFOA5MNwB2fUci7+Jyi4Q4MikDMKz+aP5h4ZzvD66+yx2bTbGWHKHLq7R2mz3HxNSclkEEsgwCuA0gHmF3SBjauUVYafo8wM1p/Um9o9G8qmw7jmMePPnG6uS/I29lZoKaMJoVryGbROVabV9ci7TpQQ2Bi4yjCEhStk7JKV+eIX9rcrsdz+f1oclX+OD5eRl6nLEjnvf90LKwwcb1rr/swNlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEheZcKJZrLEPpzMU4mnOlXcD5/SOTr/r/CpLIpMy14=;
 b=rCzYc8ClQaORsweUtL/YsszR+o+K8c4KzxNpgxexDHlB7A0ONuwwBJxTyImFJkV9Z4wFdOgi2IgcOcQqAZMe589GtVIXSiiRw0bK+KBz3EsqNw14Z9yFaEC8o5HB/RHTZ7LN1Ue7Lqxa5I2PM9IL4JveCk+JqmA/VX6qYs+xuK3juMeuql8k9C53GfB7TTCNAYNS5phwoTnSq/froZ/qOLeVr32HBITBUBZHHapFsIjDcoFO1o+0CyA/tHKH05brSSb+Rfb65irYYYNYHoOwyZk88Vuww8g3CZUyBu72ZtsiBBpug7fuFPsie96gZk3pKZxellKUoxSiaXCu6O//OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/12] imx8m/8ulp/93-frdm: board cleanup
Date: Thu, 29 Jan 2026 18:54:02 +0800
Message-Id: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEo8e2kC/x3MMQqAMAxA0auUzAZqhopeRRxKjBrQKi2UQvHuF
 sc3/F8hSVRJMJkKUbImvUMDdQb48GEX1LUZyJKzPY2oV0E+xQfMhKsbiAberB8ZWvJE2bT8u3l
 53w9YLdeFXgAAAA==
X-Change-ID: 20260129-imx-clean-v2-d67227cf0a9c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: 14438551-ab0c-4152-363b-08de5f1a49bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEtaU0pGSjFRUDJBc2txUHkyMkJqU1dHUEc3ZlRGSmhHUzBuK005ZFVKZTIr?=
 =?utf-8?B?TFJVMVJZTnhBWk1IREs4ajZSWHQwS0ZTdDRQSzlCOGh0dGtBUFBiNytVcVFq?=
 =?utf-8?B?SkU4L0JrNDIyMmpXZUZCZmZUcjBSbU5TUVJkRWl6TlFkN1JUNGI2QkQ1Zkly?=
 =?utf-8?B?VTF1U2Y3RFlHL0dlUTJEQ240WUNYTDE2TUZYUHFTRXdiSHl6WFlNSEtXQ3hj?=
 =?utf-8?B?QmNEZWJUcjg2SE1GUXhJeWVNNG0xTnRZRlU0SS90aTVUMjc5by9oclMycHpF?=
 =?utf-8?B?aktPQTdmRGE2ekN4cVowQjE4L0JIeFkxV1k2enFURG5VU3UyMllUaGN4aVla?=
 =?utf-8?B?QXluWnNxcXZiNTc5ZGVzWTNhRnBib0tkZTB1TmxCa2ZLN2ZzcElDbm42S0la?=
 =?utf-8?B?RXo2MGJIUVQ3OHR4MndBd25obmU2dEN6ZGtCMEQrTzI0UGcwVmZLcWtYNDRY?=
 =?utf-8?B?QTM0OW9jcmUxYUduUG83UXRVTVRHdVQyUkl3WDJiWmE1Nmxxc0dtOTE2NGhu?=
 =?utf-8?B?c1BFZWtPMW5KcDZjRGhnMlFzTCswUllscFhmaDZyNDJWdHNCVVNwamtUS1E0?=
 =?utf-8?B?dmRuSXNuZWZMSDZIWkxaL2VxRjd6RjRFcHcwSWx1OHpST1hJNll6cGNmQ2dw?=
 =?utf-8?B?UHUvT2xGUm1sVDROcFNrVUgwbHdLTDFaQ3ROMXQzUkhXQVhobFNERGlWZjdR?=
 =?utf-8?B?ZDFXakNib3pvZmlpaE5Sa0N0UGxVc0ZrQ1g0WjNQbTV6d05NQlhkQktyclBY?=
 =?utf-8?B?dFcvMGpobTRyNTg4S0NtalFtUDRzTGZPQ0JxRjNUWWVrUDRWbXU1Zld2WlNT?=
 =?utf-8?B?VDM5SFRBTUlDdnVKTTlkMWhkaVE0R3RsTnZGTk1EWjF3SVBJVWxNMHNDWkN6?=
 =?utf-8?B?MFpwUUNMN3gvd1pqY2Z1N0NiSDVmZ21pdmVIbEkxMHYrMFRlWjZtT1lvcWVE?=
 =?utf-8?B?WnJjMVEzZVVveTE3TFdrcG9xR0dlSlBTK0lSZGpPaFFUU1hEMG1MNC9vSlcr?=
 =?utf-8?B?dUVMeHoycExvU1RoVWZ3U3QyRGVWcm1QYTZHNTJDYWc4UVQ1WmlFN3ZVNG5K?=
 =?utf-8?B?dFhHQkFzSVREcU5hYzMxcFBGZHNhQlhhOXROcDQrSFpkWURYS0ozMWNMR3hG?=
 =?utf-8?B?NkRnM0RkRDZXQU1kcWt2TndSRkZLVjNvMTJxcS9UcmVYSVNRbEtIQUsxN0Q1?=
 =?utf-8?B?a05NNW9HQWpUb09FUWdrZTlqd1hrTEsrdnJia2RSL29LT3BNSnFDY2o3TWJ3?=
 =?utf-8?B?enlHRlduUGFMR2cwTWR2dWJiS2JENWRVaDJpZ0E0ZndLZFI3c0E0ZnU5MCtu?=
 =?utf-8?B?UUlCc3ljT3BhaGNQTU9QbGRZT3BTQnVwSzcyMnhkWU5JS2pyL0IrclppM0xw?=
 =?utf-8?B?MFFRVDcvQVFsa0MrVDFuWjJJQnFCTXFIelF4M0pTTVdTWXJINGNZK3dTYjF6?=
 =?utf-8?B?aHFaa2NzTk5DUGVITW14cnFWNUloSGMzMTF0blVPL09FSzFUUkRWMGtqYllq?=
 =?utf-8?B?NExvT1RKV1ZLdFZ0OWExT3UwN0NvV1JpTGtWelVCNUxmZTkzVDQ2Y0NQb3p5?=
 =?utf-8?B?eGJxQUFLWDNNSTRYZmM5Wng2Vk1UbkpsYndJaDF6ZUxNdmQxV1FHbzREM1FF?=
 =?utf-8?B?d09uOG15aFI2ME4xNlRubWpQYmF5SHV5M3lkZDljNjkzM1VwdlpSZGVJQ2Jj?=
 =?utf-8?B?T1UzL1dSTXllS0hacG9XNkYyRjQyYUlQTThXQytIZ2JpUlB2QnhQdUpOQlZt?=
 =?utf-8?B?NTE3OUhaWWtlWTQ3MEc5dnlaTk9OdFNzTytwbXlPbmNHNUsvbkRMc25KeFQ3?=
 =?utf-8?B?VnpaOEwxQkdIR3laZzhaMjR1YzEvRnV0ZDV1TDZCdkFoQzhzd0xiSm9QSWM3?=
 =?utf-8?B?ZWtDWDZGemN5OHBrQk8wWXVTQlZpTHhZTkxIdWtxMS8vNVpxZDlweVRJRTAr?=
 =?utf-8?B?VlE0RFBVY0EvM0NRMXRVN0ZqY0IxZ1pvY1hUSFF2T3Z3eWdZVHJ6Ly80eHpP?=
 =?utf-8?B?dURUS1B1K2NpV1lqU09SdG9nWlFuWGxDclJJdUhKSnZFTjNkbFpJZllCa1hN?=
 =?utf-8?B?QUx5NkMvUnNDVVdnRk9MbGdDdXZPOHl1bUNLRXR6RDBwRlhsRDdrUElRVzB1?=
 =?utf-8?B?aFlVVDMxQ1d2NHo4elM5UStVNEJZeU5tb3BqUG9zUDNnbEFCbWZ2VmlFdFBU?=
 =?utf-8?Q?Dcus8Wg3Jsy9EhvUdtIHdAw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3B5eXI0a01XRjNIZkhJdGtJVVpvWkxRaHpnZGZLRFJ1RG43VWFCYU5qMFRa?=
 =?utf-8?B?Y2dQb3BHKzc3b1FoNm1icXJPbnpyc2ZqT3ZKTGRIeFZKUk55SmRkbXJieEti?=
 =?utf-8?B?cFA2bjFrQWdmLzRkbkdVRXBJTWV3eGNROWR1ay9QZjQ2SkFpWDNmRERlMzhi?=
 =?utf-8?B?NTkwS0NBUXc0a0lQcGUwTXZOY2VUZGdiaGY5K1hsZXdRNFIvcEgzVjE5anBT?=
 =?utf-8?B?WksvRjYzNGo2TGdXZTl4WEc4ekxKdVl1bWJKaTREdEx0ZTFMcHNVbU1QV2xq?=
 =?utf-8?B?czV6WkVhalZmNERXMXBHTVJKaXRGNkNkWjBFejV6NldSVmxuUitHdEV4UFUv?=
 =?utf-8?B?NHE4RDNyZ214R0M0Q0V4MGhVekQzQ0tFZWh6Yi9seEljTWM0S2hZeG5idHo3?=
 =?utf-8?B?TzlsdTNUMWR1UjF1OStpOXhrREo3aW1Db3hyQ3RWcHhabEdyUGw1V01pUmpY?=
 =?utf-8?B?VEJxSHFPRDlsUkZMUC8vWjA3NDBwTmE3TjZxZkgvK3NuTGpSTnlJRkFjbng3?=
 =?utf-8?B?M1o2RDQ0T0RxMTBtYWdGK3k0VStuREdqQndoUVNLSTZ6bEswc2ZkZXBIQXFr?=
 =?utf-8?B?Wm5rV2Rkd0FyMjM5citZMWhNQzFaenVLRTgvcEZIZkEzY2REcDRLRndicXdY?=
 =?utf-8?B?V2Q2Vk1iNkVFY1VHQ2wxUGZxRDZZdHdBaDdzdFphUVJxM001YjZYWjBNbWpn?=
 =?utf-8?B?dXgrWWlibm54WDFYRDk5aW85WnF5Ym8zeHRYM2xxS2ZaZU52Y1VDTE5FM09U?=
 =?utf-8?B?WDFteThjd0RidXp6T2hRZ3hJcG9NTldiT3JmcTBNaUJ5V3kxZUFqaVREdzAx?=
 =?utf-8?B?S3NMeWVjQWRHMmkrRGRiWEZmQ1cxK1UvQk1BVnNzTk1rd3RSUGovTXI5S2Nu?=
 =?utf-8?B?Z1N5dk9haUZWbk00bUhuS1YrODdhLzNjaHFKWExtYXBXYkhwcGR2OHJvdG1D?=
 =?utf-8?B?VC9Da0Z3Wnk5RE00MGhMa3dHR0wzZHp1L2xjeVZQTUVjeitUNHJpTG5ISXYr?=
 =?utf-8?B?bDFrdExaN3krRUY1aFNtOXBCRTJaZnh4aUdRV1J0Q2FsRzAwWHk0c1NtV2Q1?=
 =?utf-8?B?TWpiT2VTVllFNkJENUh0cHRzTFJPVEFEcjFobWdKZkxMdi9mZTZINlFoR0Vs?=
 =?utf-8?B?ek1ycHZHbUpOVVFISmlzdmJmVjBNVFFVVEg4cWhMbzdjVkwzZDg5UU1ZNWpw?=
 =?utf-8?B?TnZZeUk2VzhzRnVMZjhxc25Nd3VlVy85WnRZMEl5ZGJrL3FpSkdGZTBLRjRk?=
 =?utf-8?B?c3d4Nm5rVUdaRlJLVWR1Nms0cVpJWHhaVy9vVEszNmxRWGY1SjQ0NTJwckxy?=
 =?utf-8?B?Mmd4Z3FQQjVDTHcxSDhLY3Rla1ViQ0FUQkN4VloxRE5wcHF1THhRMDYxYmVX?=
 =?utf-8?B?TU5ZVzJpVkpSei9raTNLNmgxZjhpbUhnNE9IMzUrdnZONHpncDIzZHhIUzZt?=
 =?utf-8?B?S0RPMHppc2pFQmltRVd3MDNyTjVpaldsekZwVENrNVpha1JaRWtzSUdwU24w?=
 =?utf-8?B?ZjJhVUUxeDZjTHhyTHpEcDA2b0pjYmtBZjBxK2pIU2ZPb1U1cWhXWlJGMnl6?=
 =?utf-8?B?SDRWZ2dsd01RMUVrU0ord3VWd0lHdG9sVDRmWXpseE0yNkFubklVR1NwazU5?=
 =?utf-8?B?NFdiWjdTQU9qZlFmakxDNnpBUGduVGZRZmFKb21PMnhZcUU1ZnFsY1l3NXlv?=
 =?utf-8?B?bk5hMjZ0MzVDT1o5ektZNDIydUladmkvTXlxU3AvNnppNFlPYjdlOHA5amtZ?=
 =?utf-8?B?bVMvZ2I1VFhGMVRqK2FTN2hmRXh0c0VzMis3eWNRYjZKVk1hSFJ3NTB4VDdp?=
 =?utf-8?B?SzM4d1ZFMG5HSEJRaUpvVDNuZjR5VHIvd2VUeitRKytTMlBmWXlnY1RBVlQ0?=
 =?utf-8?B?ZUl3TUNHZElqTmNKalNKazRHYTZ3QkY2YUVnSmVMVVh3cUZEOWNSaTk5R1ll?=
 =?utf-8?B?OFlUWlZNZzZHS3FPZVN2WFJMUzc1cFRYTmhKTHNVTFNTZUNkQTZ6YkhVNks2?=
 =?utf-8?B?dlZOcEl6enp0VnVJRndvYlhvOGFBYzFKbzI5WlhsL1h0SDZOeDFQN2tYV0Vv?=
 =?utf-8?B?Kyt5a1YvNzMzWEhDYkVaMW1sNUNLMGttUFJyYUQxQUM5dEEvYkJhMEZsVHJB?=
 =?utf-8?B?Njk4L0dCU0tXQytjVFVpM0ZyNHhzZGcvK1U5LytTQVJwK012YVhpWTN1a1ZU?=
 =?utf-8?B?WHNYZVlMOFFiSzBaWUIrSkNXOGRDbGg0bUZwdWlhQ2Z6dVg5aUt5UHh5c2Nv?=
 =?utf-8?B?VW9oZGlnMWZCWmNNaEtnWjVBVlhhOVhOd3RXN3Q5SlBSalgzUlpnSFdLeHFm?=
 =?utf-8?B?MDlUWjl4bUVLbndVMTRieExGaitXSVhVdXVQbEtnUXk1KzJxSnpOQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14438551-ab0c-4152-363b-08de5f1a49bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:24.6036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaORFn7ZZBQTJbcUzBJuSOydpPIql9gIrAAUr06Dw6pAatO3K0wv0Wgf2y09HhtFgH19J02/J396FTmk2oe1GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

The 2nd batch to do some cleanup. The patchset is mainly to cleanup
i.MX8M/ULP-EVK board code and sort the included header files.

While at here when reviewing the code, the i.MX93 FRDM EFI GUID
is copied from i.MX93-EVK which is wrong, so updated it.

For patches to sort the header, I follow such rules to sort the header,
same as the last patchset to clean i.MX9:
*.h [generic header]
asm/*.h
asm/arch/*.h
asm/mach-imx/*.h

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
 - Rebased to lastest master
 - CI build pass
 - Link to v1: https://lore.kernel.org/u-boot/20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com/

---
Peng Fan (12):
      imx8mm_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: spl: Drop i2c_pad_info1
      imx8mp_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mp_evk: Cleanup headers
      imx8mn_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx8mn_evk: Cleanup headers
      imx8ulp_evk: Drop DECLARE_GLOBAL_DATA_PTR
      imx8ulp_evk: Drop board_phy_config
      imx8ulp_evk: Cleanup headers
      imx8mq_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Drop DECLARE_GLOBAL_DATA_PTR
      imx93_frdm: Update IMX_BOOT_IMAGE_GUID

 board/nxp/imx8mm_evk/imx8mm_evk.c   |  3 ---
 board/nxp/imx8mn_evk/imx8mn_evk.c   |  4 ++--
 board/nxp/imx8mn_evk/spl.c          | 22 ++++------------------
 board/nxp/imx8mp_evk/imx8mp_evk.c   |  2 +-
 board/nxp/imx8mp_evk/spl.c          | 30 +++---------------------------
 board/nxp/imx8mq_evk/spl.c          |  3 ---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c | 17 ++---------------
 board/nxp/imx8ulp_evk/spl.c         | 12 +-----------
 board/nxp/imx93_frdm/imx93_frdm.c   |  7 ++-----
 9 files changed, 15 insertions(+), 85 deletions(-)
---
base-commit: 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
change-id: 20260129-imx-clean-v2-d67227cf0a9c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

