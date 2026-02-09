Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD7EF06FC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BF683CB5;
	Mon,  9 Feb 2026 02:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hqs/w8j3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 926E283C72; Mon,  9 Feb 2026 02:29:05 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9194A805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbgmRzzb0b6gnijr15x8LZKeh6BD918i1S8RrhXoUdoWsI+24ZkGtjMXA/CVWexA983asDmbG4cHUgk7kkS7UTbCojiTTouCvNFImzYCy0nURih6IH1KHbxwkaS7QUefUeVV3uOPFdgWnA6xaLpdfAvzy6nUpdwvzGg3TLamsn8eN3mpIwnMpKiluTHvUXNKBOF23TUbeIShbz3nsT0eiv6+v7g1QUVA+gW8R2u61DEiCHIlIGMH0OFOjsgJAlE6SANc3Pp6OHAuQ0h/nd/4rWm3Y2H7C+eMhu3bNWt6PsDghJZZbDeWJbFv8xGBmSozNi2dIsGf2WmETvHJxEikVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=LMVgrHd57cvkzlftnI9azcnMqKFj9vv0Uez8MtQEwdxGZB/JDw2QO1kRvG1dmk7L9vePRZbuUbkXL63xp/xbkrzmV1E7Bv9J6koIh4byl83YNPeV4HwrXE4wslJ+C3z8cxETVfLl3xljGwsCkNoE/nGe2+LTP4iArQ1bMeLaZjQK2XdK5ZZXf/FZfQ41arRZsWWTYu/k9uDCbg3E1BWy3GE8acdaIJ45ua3uelnVQR/zh8D8zq95ufdYT2Myz/3Q9ZMGHRm2Tn/n7qB2kdGJ1IS3WxizCXBMRGhub9oaIECnjHOXYICTQYAmO8pcDIr/SyVIIBtL1DKQ2kI/e04pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxfvyil36xY1D/eNw+BGYVnOp5UonpwJ6UoczsWHOPY=;
 b=Hqs/w8j3Y6OYfVlByllNfQ+q11opyICUcabdI0W1RbhBxU5VhZUiKlqBTrx89T+UwdaNRZxxPVl/IkAlSKmPxhmFfyzz8mLBU7VdGHnCehcKoFwhABiJoxsltyNJUctPq3I5ghc5gXMR+QuH7MR1Hmy0NF1EP/CKJ+2aUwFszL9xMN6G3OcgbKuoxHsE4oZMTBorxwpc0FLM6WAMkXBtwKHIyUcyUhC/66RuONQLG3vUkhJuOgFALlJJYC+6GGqH5HHjfhzMQdEpd6ccw0GjMaC41Sy8Yqu+15TutKar1BxcyIWJd+gPMP2nX6DYEVeyZb9xkds2hLXGfsPjwhvXGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:09 +0800
Subject: [PATCH v2 05/14] test: log_filter: Include vsprintf.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-5-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e00584-9476-408a-fb9a-08de677a9add
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEtCdzZyRDlMRXlpUitKZ0tlUFg1aVBMV0VUdk9oODB3SzBBUHNKOGNHSWp0?=
 =?utf-8?B?SU91aThwOVFCUUtKdzZDWGcydDl2M1N0bmQ4T0U1TTQ0dHpHNzlzb2c2OGxx?=
 =?utf-8?B?b3BNWi9tWkxrYjZPZGE1RTA4VDl3d28wQWVrd2NoY3ozODgvMFk5Mk0weUht?=
 =?utf-8?B?QXdGUEl2Vy9tMG5uKzBKTEFiQXlBZ1FuMXdPQTJoUnRmR1pmMzVXR1B2UDYw?=
 =?utf-8?B?OXRHalQrSncyNDhiRDVIZmVZN2IrRHNLd2pVS2dSTm1sOUhLeUVJeVVnbXJX?=
 =?utf-8?B?blBENWx4U3NtRTJmT1BnUkdYUnNaa3MzNFhhVkcxZjMyekh3cFZIL2FFUjls?=
 =?utf-8?B?Zm84bUExMWN3YzI5TWtmQktmaFNHY2NGRElvN1hMWW9wd1J0YWRHdGRuK2R0?=
 =?utf-8?B?TUx5amg5V1FXSDZiRW56cXNxMldVMmRmU3h1ZVlHWVQ4WHpSUWJSK2E2aEw0?=
 =?utf-8?B?YmFUeDAwcXFaNU9kUnJCTjNtTnFWWUxFQ2FLWlprVjcwMkozTE9mQjBkMjQ4?=
 =?utf-8?B?QXZ0TFhRMHRNUnBQQVhQaGsyQmlRaHY5U3Bscmw2Y1p0YkhTbXAwVzkzeGNl?=
 =?utf-8?B?dS8yaWVLaDEzWjVjRFBqRWY2aE91cTQ0d0VCdXhwZUxxQnlqUjFTL3pQY2lh?=
 =?utf-8?B?Sk0xVlJaWGNtV0VLWXJwN2pHWDJnb3BTbE1rcVNSRURGU2ZqQjJtZnJPcGRz?=
 =?utf-8?B?VDQ2Q3E3c2huc3dXVjFMZWtZekw2dnZLUmlUVDBnSTREeFpmUTBTVUZxeFJV?=
 =?utf-8?B?ekl6Rmw4a3dLV2Y3QVN1S2VTS0g0L2MxalZFUFFicER2L05ZOUlTUnVJRFBQ?=
 =?utf-8?B?N0hpVXpQajFkNEtQNkFKY2tCZE96TWxkcjIrWmEwTDdTQzJqRnpQOE5hNHNT?=
 =?utf-8?B?alpkQW1nUTN6a3oyMUdUMDFRc3IvZWNHNVNnK0d0Q3ZDY3JGdjFid0orTVl0?=
 =?utf-8?B?dm0zaTdBQ25vcVBEK2lPVVg3OVk1eTRGdVJwTmc1eURTeGJaOXRMNi96N3RW?=
 =?utf-8?B?azBWaWhyWTkvZFJrRGlUcXVCTytaaVNZUE14WlVzU3h0bjlrektZeVJ3dzVy?=
 =?utf-8?B?WWVITmFqZ0Q3a25PdkZJZVhvQnFUVkNJY3ZWcjEwOU1Ka1NtclhjWTV3aUdH?=
 =?utf-8?B?UUJaa3ljMmF1a0Z5c3E0Q0RXWlpuanhBNGUrYTdGbjRqemdFUVo5UHRMUTEw?=
 =?utf-8?B?TzVPQWNuKzJUaHdpVkhaK1JMalUzZm92RnY4ck00ZTJ0OTZSK0xJdm1kYndh?=
 =?utf-8?B?WFdvYVFlU3ZoTEp3ekUyYkduYnJLSkZsRmRnN2FRRVNZY3djZm40TU05cElU?=
 =?utf-8?B?SWtEbEp1SW1sYmR3VVBuSHNSc3kwSW1MRXdUMUt0Rmd5dUVaMktZREpDQzlo?=
 =?utf-8?B?NE9wV2VxVUkzVDY3aWttRElzNE1mdjl2K3A4WndCRjVCcEEzNjRsY29LbkU5?=
 =?utf-8?B?cVFabm90ZktZaVF6QVJCZElSU2ZBMHZiZ3JON1BQQklpbkJBM1Z1VDQzWHhl?=
 =?utf-8?B?dWRlVmtVVHhFZSs0dVJJdDVGWGY3MmtOa0ErRGEwMGN2NlY5SjhQbUR2Lzgw?=
 =?utf-8?B?dk5ORUh0WHdpSVFnaTMzTkZDdTd5ZXBVbDl5UGdkMHUzSnMxQ0VPRXlxclRi?=
 =?utf-8?B?bWVFc2ZrZC9MTi9naGhPRk5qVlREM0JXd1RqRXVTcWpzQlpWcm0zeWwzcGhL?=
 =?utf-8?B?enhBNGo5NFFtb1lubzRLM2Y4aTBRMDJFNFdRdHg2OXBhSmp3eVZOQ1MvUEhX?=
 =?utf-8?B?ME14d1FwaURyZHNkV2plaWFlV3VXL1h4bFFHaU5ZR3Y5dkwrZUltUlk1dGZ0?=
 =?utf-8?B?WFJqcjJmK3B2eUlOdGlleUV0Y25CLzdTbkdOS1RCcWJHcHBUNWJDSTQ0aHd0?=
 =?utf-8?B?b2JuMFpuZkZLbE1yam5INitKSUJmQS9rWGZCMmRMTTRTTzNwQy9EN1d0LzJG?=
 =?utf-8?B?TXFURTczMjRuR25Ya1g2bEpiS0NFdU1JV25MUFhGN3VYemh4WnFRVk1Rc3c2?=
 =?utf-8?B?VFhXc2NPU1VmTnpuRXlHTjJYaCtrTFprUlJEa09xYm5Ka0dWTE1aV29lTGtF?=
 =?utf-8?B?VVFIS3VQS1Z0U1lKYjQ3YW9sL1JpZ3BYdDc0Z2plNlR1dDhDb3JSQW14UWNo?=
 =?utf-8?B?OEVObFduSkdHdXdkVHB2amgrbi9PZzR1UGxhNmZQWWl1aFE5UlBlckFzTWM2?=
 =?utf-8?Q?ni4G5+Jov/T+2q2NGUMSi0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdPRTIvSVd6UzBqcDU4c0dFSEp3eTFYSVRuYW9vNlBKdDVyVFJtUCtBQXFt?=
 =?utf-8?B?eUlYeUc4cGJaOG1jdmNhU0ViSVNIU3ZXU29UMEZYUUpwTkN6S2s0ZjFadEt5?=
 =?utf-8?B?WWxOQVlkSUNCQ2t0MzFBZmszSjNYazJJVyt4MkRmUXVWNnRBWDEybnRGNWNS?=
 =?utf-8?B?Rjdyako1bVJrZHlEYXdNcWxGOE1LV0ZyaC9aL3BUQWpFT3RXTXhHNEhabGR5?=
 =?utf-8?B?aVFSYXRDeVRoem0yc0VRTi9RZnZrQk9ta0YwSmhQT1NuMUtDZkJmdUxyK0o5?=
 =?utf-8?B?emExZWJEclJMVmlqa1J0VmlVNDFUcXhzOUNoeG5lbWE5OXJUOWJqby9CUnhu?=
 =?utf-8?B?UTVDTm56ampYYmJaa2JSQ3dhSEhHTkJ6cXRpRjRGNXkxTEVmbWdVTk5OellD?=
 =?utf-8?B?QTRFYjNDZEtsRmdTTTBFVE44bU5COUZUSVVJZm5mYXk2QzlmL2pCdU9Yb3dO?=
 =?utf-8?B?dXJLR1FLOWdHN0J3dE1EcDd3K0xiS2I0UHZhL2J1SlE2anhhS29KRW5JdXZj?=
 =?utf-8?B?anB1bjQ0MU90TUpXbTJRZUMvazRwWVZ0VWM1eHdXdjdEQXNPQko3SGM2MXNa?=
 =?utf-8?B?d0hBVTk2R1dwTEpnenRoeURkVTl0dk81VDZMTUxrNWl5T0g5eWVFTXFTNUlm?=
 =?utf-8?B?bVBURjFkKzNBQ1F0MGNmemtQTko2aXRzNWFEZ0JtWFFzdGVaZm5ueFowdit4?=
 =?utf-8?B?TXJzQTdkRkQveEk2Q0xsMVluR2JTRUttTHBuVVZEekY1Ui9hdUdpNVRrWmFU?=
 =?utf-8?B?WHNGVUwzMHBUTU5TMEF4R2xpcTdlQzBFTDBhNGpibmtYN213WDFkS3lzMi9W?=
 =?utf-8?B?SE9tRzgzU094WVc0eWJHaU5HNGhhU3VFQ0doamppQkFuak5uN0ZYUklxUENt?=
 =?utf-8?B?Q01YcVhEcTVXdWZJcktrNTNZYlhQSmVaVE1UaG1QN1RRcUxHSjZOMVoreEoz?=
 =?utf-8?B?cTVTc1M3bmdlT1oxU0FHeDZnNU1KeW5rVUUrQkNBcW1jb3N1dHd4V3hjSXFZ?=
 =?utf-8?B?VVNJelBRZmFoOW5mUkcvd1hnWC9OMUVYR1hKU2pvclQyQmk5QkQzY2dGT0Z6?=
 =?utf-8?B?THJNK1d2ZGtMWlNCbkh1Yi9aL0hlR1ArQm9jZkNuQTA0NjVCV3gvUjJjUFQ4?=
 =?utf-8?B?ME4vUUhaZmZGcHpPU2pZcjhqeXdYMERya2N2d00ySXgvQkNPMkJNaUd3bXBu?=
 =?utf-8?B?QmhsT2x2aWN6blpBNVg1UEhZUHB6RVJkUldWVjhmVmNVZko5M2wzbnU4YXQr?=
 =?utf-8?B?aGZpMjJWbEsrTS8zajRTRFFQL0lLelRESGV4R3JiMGwwU1dWNWtPcm9zaWds?=
 =?utf-8?B?eU9vOEZwazA2TzRTUUhkYjJyelNjT1g4L0wzdTBtcEZLYmU1RjlxR3EraHIw?=
 =?utf-8?B?dENBa0VncnFhcmJyZ2JHaXhYQXl6VGY5WC83OVFMUXhxWmZpcnRraTFyZFZH?=
 =?utf-8?B?SW9tNHRFNFVjY2xPZUpxbTZkTExmalM0d05ibkkyUG1sQVlJRWF4cXY4N0RW?=
 =?utf-8?B?dXZRL3hmd0xySEhWKzRMNlRuS25BOURtQ3VmSWtFUXlVK0h1SzJuUnBxSHNy?=
 =?utf-8?B?UFA0Zk94Q0dxWUorN2t1emg0ZXRubkl0N0VvL25vMVJxeklOQ2xQa3hGQlVE?=
 =?utf-8?B?TElNTlh2KzF1eWZrYS9LNVN1dnR4VVExZ1BPbU5QU0piSzBBa2JpY2dqdFEy?=
 =?utf-8?B?RW5vN2pubEt0NjlYZ0FyYXVtTnpXUDhKNHdtY3RGQTBPNmJnT3VaYkhxempv?=
 =?utf-8?B?a1h3T0JkenhTSVh1UlJITzAxSzZyZmdqWUZpVEl5ZlFUM2NkamVrSjczakJx?=
 =?utf-8?B?ZmF1NlBtOXp0R2lKUkFEZkpSNHdUSEk0NnRMNTdxYXpLQXFMM0c3aFUxT1dH?=
 =?utf-8?B?K1JPV3RIa09yN01yWHcrdmtNRm5SUEY2MWQwZVE2QXFNRU85TCtQQnZQZm1S?=
 =?utf-8?B?ajBXNmU3YlgxZmFrZTlXbjNtS2pFeE1WN0RpZnQ1SHZVUUpBVDVFWDNVYndI?=
 =?utf-8?B?Yk9qUVBsc3JzaXlwdDVCdFByYnB5WVB6UENnT2FjYm1BMFBjbUJHWjVaZlFv?=
 =?utf-8?B?ekt5Sm8wc0x4R05CdjVjMXF6SnhaVm93NmxvU3Yzam9GbFdSOEV3S2gxQkRX?=
 =?utf-8?B?VlZvVHlKVmdYUWdIRzFnaHRIc2hwTnA2emJxbldacWJ0L1FvVjRkRXRJUU5K?=
 =?utf-8?B?S1psL0Y2dzBSUW83STBUSUl5Mmg5NDI1U2VPN1BzUU5Nc3VOVHhHUnZOT3RC?=
 =?utf-8?B?b1dlR3BEYi9uR0cvWEgzU0VTaUJockJnbVhBenV3bmQ4Qk5aOUpjRnNzOUYz?=
 =?utf-8?B?aFJGc3cxQTdDSUdIS0FWdFkzc0tlSXltbXNaUW1sT3pGRjBQSFBMUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e00584-9476-408a-fb9a-08de677a9add
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:01.6375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgjWW6lxfXCTH6BhdtqY9FxglWPSTNJfICBAl4qPiCJSuGYwwy51iUOZTlCA/0m8X5F58dwKHep0WEarG1d1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

snprintf is used, need to include vsprintf.h. Otherwise there will
be build error after asm/global_data.h is removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 test/log/log_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index 8622dcf29130f6f6eb70536e042c2ed51ad61893..680c60164b623bb30bf0a5457c190bab8d97468a 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -5,6 +5,7 @@
 
 #include <console.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <asm/global_data.h>
 #include <test/log.h>
 #include <test/ut.h>

-- 
2.37.1

